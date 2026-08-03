import os
import shutil
import subprocess
import tempfile
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
SCRIPT = ROOT / "scripts" / "audit_public_release.sh"
GITLEAKS_IMAGE = (
    "zricethezav/gitleaks@sha256:"
    "c00b6bd0aeb3071cbcb79009cb16a60dd9e0a7c60e2be9ab65d25e6bc8abbb7f"
)


class AuditPublicReleaseWorktreeTest(unittest.TestCase):
    def setUp(self) -> None:
        self.temp_dir = tempfile.TemporaryDirectory()
        self.tools_dir = Path(self.temp_dir.name) / "fake-tools"
        self.tools_dir.mkdir()
        real_git = shutil.which("git")
        if real_git is None:
            self.fail("git is required for the deterministic command-construction tests")

        self._write_executable(
            self.tools_dir / "git",
            """#!/usr/bin/env bash
set -eu
for arg in "$@"; do
  case "$arg" in
    --git-common-dir)
      printf '%s\\n' "${FAKE_GIT_COMMON_DIR:?}"
      exit 0
      ;;
    --git-dir)
      printf '%s\\n' "${FAKE_GIT_DIR:?}"
      exit 0
      ;;
    grep)
      exit 1
      ;;
  esac
done
exec "${REAL_GIT:?}" "$@"
""",
        )
        self._write_executable(
            self.tools_dir / "docker",
            """#!/usr/bin/env bash
set -eu
printf '%s\\n' "$@" > "${FAKE_DOCKER_ARGS:?}"
if [[ -n "${FAKE_DOCKER_OUTPUT:-}" ]]; then
  printf '%s\\n' "$FAKE_DOCKER_OUTPUT"
fi
exit "${FAKE_DOCKER_STATUS:-0}"
""",
        )
        self.base_env = os.environ.copy()
        self.base_env["PATH"] = f"{self.tools_dir}{os.pathsep}{self.base_env['PATH']}"
        self.base_env["REAL_GIT"] = real_git

    def tearDown(self) -> None:
        self.temp_dir.cleanup()

    @staticmethod
    def _write_executable(path: Path, contents: str) -> None:
        path.write_text(contents, encoding="utf-8")
        path.chmod(0o755)

    def _run_audit(
        self,
        *,
        git_dir: Path,
        common_dir: Path,
        gitleaks_output: str,
        gitleaks_status: int = 0,
    ) -> tuple[subprocess.CompletedProcess[str], list[str]]:
        common_dir.mkdir(parents=True, exist_ok=True)
        git_dir.mkdir(parents=True, exist_ok=True)
        args_log = Path(self.temp_dir.name) / "docker-args.txt"
        environment = self.base_env.copy()
        environment.update(
            {
                "FAKE_GIT_DIR": str(git_dir),
                "FAKE_GIT_COMMON_DIR": str(common_dir),
                "FAKE_DOCKER_ARGS": str(args_log),
                "FAKE_DOCKER_OUTPUT": gitleaks_output,
                "FAKE_DOCKER_STATUS": str(gitleaks_status),
            }
        )
        completed = subprocess.run(
            ["bash", str(SCRIPT)],
            cwd=ROOT,
            env=environment,
            capture_output=True,
            text=True,
            check=False,
        )
        return completed, args_log.read_text(encoding="utf-8").splitlines()

    @staticmethod
    def _mount_values(docker_args: list[str]) -> list[str]:
        return [
            docker_args[index + 1]
            for index, value in enumerate(docker_args[:-1])
            if value == "--mount"
        ]

    def test_normal_checkout_mounts_common_metadata_at_repo_git(self) -> None:
        normal_common = Path(self.temp_dir.name) / "normal common" / ".git"
        completed, docker_args = self._run_audit(
            git_dir=normal_common,
            common_dir=normal_common,
            gitleaks_output="INF 7 commits scanned.\nINF no leaks found",
        )

        self.assertEqual(completed.returncode, 0, completed.stderr)
        self.assertIn("7 commits scanned", completed.stdout)
        self.assertEqual(completed.stderr, "")
        self.assertEqual(
            self._mount_values(docker_args),
            [
                f"type=bind,src={ROOT},dst=/repo,readonly",
                f"type=bind,src={normal_common},dst=/repo/.git,readonly",
            ],
        )
        self.assertEqual(
            docker_args[docker_args.index("detect") :],
            [
                "detect",
                "--source",
                "/repo",
                "--redact",
                "--no-banner",
            ],
        )
        self.assertIn(GITLEAKS_IMAGE, docker_args)

    def test_linked_worktree_mounts_absolute_common_metadata_path(self) -> None:
        common_dir = Path(self.temp_dir.name) / "linked common.git"
        linked_git_dir = common_dir / "worktrees" / "feature"
        completed, docker_args = self._run_audit(
            git_dir=linked_git_dir,
            common_dir=common_dir,
            gitleaks_output="INF 11 commits scanned.\nINF no leaks found",
        )

        self.assertEqual(completed.returncode, 0, completed.stderr)
        self.assertIn("11 commits scanned", completed.stdout)
        self.assertEqual(
            self._mount_values(docker_args),
            [
                f"type=bind,src={ROOT},dst=/repo,readonly",
                f"type=bind,src={common_dir},dst={common_dir},readonly",
            ],
        )

    def test_zero_commit_output_fails_closed_without_replaying_output(self) -> None:
        common_dir = Path(self.temp_dir.name) / "zero-commit common.git"
        completed, _ = self._run_audit(
            git_dir=common_dir / "worktrees" / "feature",
            common_dir=common_dir,
            gitleaks_output="INF 0 commits scanned.\nINF no leaks found",
        )

        self.assertNotEqual(completed.returncode, 0)
        self.assertIn("authoritative history scan", completed.stderr)
        self.assertNotIn("0 commits scanned", completed.stdout + completed.stderr)

    def test_contradictory_zero_then_positive_summaries_fail_closed(self) -> None:
        common_dir = Path(self.temp_dir.name) / "contradictory common.git"
        completed, _ = self._run_audit(
            git_dir=common_dir / "worktrees" / "feature",
            common_dir=common_dir,
            gitleaks_output=(
                "INF 0 commits scanned.\n"
                "INF 7 commits scanned.\n"
                "INF no leaks found"
            ),
        )

        self.assertNotEqual(completed.returncode, 0)
        self.assertIn("parseable history summary", completed.stderr)
        self.assertNotIn("0 commits scanned", completed.stdout + completed.stderr)
        self.assertNotIn("7 commits scanned", completed.stdout + completed.stderr)

    def test_multiple_positive_summaries_fail_closed(self) -> None:
        common_dir = Path(self.temp_dir.name) / "multiple common.git"
        completed, _ = self._run_audit(
            git_dir=common_dir / "worktrees" / "feature",
            common_dir=common_dir,
            gitleaks_output=(
                "INF 7 commits scanned.\n"
                "INF 11 commits scanned.\n"
                "INF no leaks found"
            ),
        )

        self.assertNotEqual(completed.returncode, 0)
        self.assertIn("parseable history summary", completed.stderr)
        self.assertNotIn("7 commits scanned", completed.stdout + completed.stderr)
        self.assertNotIn("11 commits scanned", completed.stdout + completed.stderr)

    def test_absent_commit_summary_fails_closed(self) -> None:
        common_dir = Path(self.temp_dir.name) / "absent common.git"
        completed, _ = self._run_audit(
            git_dir=common_dir / "worktrees" / "feature",
            common_dir=common_dir,
            gitleaks_output="INF no leaks found",
        )

        self.assertNotEqual(completed.returncode, 0)
        self.assertIn("parseable history summary", completed.stderr)

    def test_malformed_commit_summary_fails_closed(self) -> None:
        common_dir = Path(self.temp_dir.name) / "malformed common.git"
        completed, _ = self._run_audit(
            git_dir=common_dir / "worktrees" / "feature",
            common_dir=common_dir,
            gitleaks_output="INF many commits scanned.\nINF no leaks found",
        )

        self.assertNotEqual(completed.returncode, 0)
        self.assertIn("parseable history summary", completed.stderr)
        self.assertNotIn("many commits scanned", completed.stdout + completed.stderr)


if __name__ == "__main__":
    unittest.main()
