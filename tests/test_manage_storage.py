"""Focused safety tests for the repository-scoped storage manager."""

from __future__ import annotations

import importlib.util
from io import StringIO
import json
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest
from unittest.mock import patch


MODULE_PATH = Path(__file__).parents[1] / "scripts" / "manage_storage.py"
SPEC = importlib.util.spec_from_file_location("manage_storage", MODULE_PATH)
assert SPEC and SPEC.loader
storage = importlib.util.module_from_spec(SPEC)
sys.modules[SPEC.name] = storage
SPEC.loader.exec_module(storage)


def make_repo(path: Path) -> Path:
    subprocess.run(["git", "init", "-q", str(path)], check=True)
    (path / ".gitignore").write_text("/.lake/\n/.pytest_cache/\n")
    return path


def make_package(root: Path, name: str = "dependency") -> tuple[Path, str]:
    package = root / ".lake" / "packages" / name
    subprocess.run(["git", "init", "-q", str(package)], check=True)
    subprocess.run(["git", "-C", str(package), "config", "user.email", "tests@example.invalid"], check=True)
    subprocess.run(["git", "-C", str(package), "config", "user.name", "Storage tests"], check=True)
    (package / "package.txt").write_text("pinned source")
    subprocess.run(["git", "-C", str(package), "add", "package.txt"], check=True)
    subprocess.run(["git", "-C", str(package), "commit", "-qm", "pinned package"], check=True)
    revision = subprocess.run(
        ["git", "-C", str(package), "rev-parse", "HEAD"], text=True, capture_output=True, check=True
    ).stdout.strip()
    return package, revision


def write_manifest(root: Path, packages: dict[str, str]) -> None:
    (root / "lake-manifest.json").write_text(
        json.dumps({"version": "1.2.0", "packages": [
            {"name": name, "rev": revision, "type": "git"} for name, revision in packages.items()
        ]})
    )


class ManageStorageTests(unittest.TestCase):
    def test_default_report_is_dry_run(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            root = make_repo(Path(directory))
            cache_file = root / ".lake" / "build" / "state"
            cache_file.parent.mkdir(parents=True)
            cache_file.write_bytes(b"cache")

            output = StringIO()
            storage.report(root, output)

            self.assertTrue(cache_file.exists())
            self.assertIn("Report only", output.getvalue())
            self.assertIn(".lake", output.getvalue())

    def test_clean_removes_an_ignored_untracked_cache(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            root = make_repo(Path(directory))
            cache_file = root / ".lake" / "build" / "state"
            cache_file.parent.mkdir(parents=True)
            cache_file.write_text("rebuildable")

            with patch.object(storage, "active_project_processes", return_value=[]):
                storage.clean(root, StringIO())

            self.assertFalse((root / ".lake").exists())

    def test_clean_refuses_cache_containing_tracked_file(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            root = make_repo(Path(directory))
            tracked = root / ".lake" / "keep.txt"
            tracked.parent.mkdir()
            tracked.write_text("must survive")
            subprocess.run(["git", "-C", str(root), "add", "-f", ".lake/keep.txt"], check=True)

            with patch.object(storage, "active_project_processes", return_value=[]):
                with self.assertRaisesRegex(storage.StorageSafetyError, "tracked"):
                    storage.clean(root, StringIO())
            self.assertTrue(tracked.exists())

    def test_clean_refuses_symlink_that_escapes_repository(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            parent = Path(directory)
            root = make_repo(parent / "repo")
            outside = parent / "outside"
            outside.mkdir()
            (outside / "state").write_text("do not touch")
            (root / ".lake").symlink_to(outside, target_is_directory=True)

            with patch.object(storage, "active_project_processes", return_value=[]):
                with self.assertRaisesRegex(storage.StorageSafetyError, "symlink"):
                    storage.clean(root, StringIO())
            self.assertTrue((outside / "state").exists())

    def test_clean_refuses_when_project_process_is_active(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            root = make_repo(Path(directory))
            cache = root / ".lake"
            cache.mkdir()
            with patch.object(storage, "active_project_processes", return_value=[f"lake build {root}"]):
                with self.assertRaisesRegex(storage.StorageSafetyError, "active project"):
                    storage.clean(root, StringIO())
            self.assertTrue(cache.exists())

    def test_nested_cache_is_not_reported_twice(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            root = make_repo(Path(directory))
            nested = root / ".lake" / "build" / "__pycache__"
            source_cache = root / "tests" / "__pycache__"
            nested_source_cache = source_cache / "inner" / "__pycache__"
            nested.mkdir(parents=True)
            nested_source_cache.mkdir(parents=True)

            labels = [target.label for target in storage.cache_targets(root)]

            self.assertIn(".lake", labels)
            self.assertIn("tests/__pycache__", labels)
            self.assertNotIn(".lake/build/__pycache__", labels)
            self.assertNotIn("tests/__pycache__/inner/__pycache__", labels)

    def test_clean_refuses_dirty_lake_dependency(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            root = make_repo(Path(directory))
            dependency, revision = make_package(root)
            write_manifest(root, {"dependency": revision})
            (dependency / "local-note.txt").write_text("unique local work")

            with patch.object(storage, "active_project_processes", return_value=[]):
                with self.assertRaisesRegex(storage.StorageSafetyError, "local changes"):
                    storage.clean(root, StringIO())
            self.assertTrue((dependency / "local-note.txt").exists())

    def test_relative_test_or_build_process_is_detected(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            root = make_repo(Path(directory))
            with patch.object(storage, "_caller_ancestors", return_value=set()), patch.object(
                storage, "_process_cwd", return_value=root
            ):
                active = storage.active_project_processes(root, [(4242, "python3 -m unittest")])
                build_active = storage.active_project_processes(root, [(4243, "./build/search")])
                search_active = storage.active_project_processes(root, [(4244, "rg theorem")])

            self.assertEqual(active, ["python3 -m unittest"])
            self.assertEqual(build_active, ["./build/search"])
            self.assertEqual(search_active, ["rg theorem"])

    def test_clean_refuses_lake_linked_worktree(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            root = make_repo(Path(directory))
            dependency = root / ".lake" / "packages" / "dependency"
            dependency.mkdir(parents=True)
            (dependency / ".git").write_text("gitdir: /elsewhere/worktree")
            write_manifest(root, {"dependency": "a" * 40})

            with patch.object(storage, "active_project_processes", return_value=[]):
                with self.assertRaisesRegex(storage.StorageSafetyError, "worktree"):
                    storage.clean(root, StringIO())
            self.assertTrue((dependency / ".git").exists())

    def test_clean_refuses_manifest_pinned_dependency_with_local_branch_commit(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            root = make_repo(Path(directory))
            dependency, revision = make_package(root)
            write_manifest(root, {"dependency": revision})
            subprocess.run(["git", "-C", str(dependency), "checkout", "-qb", "local-work"], check=True)
            (dependency / "local.txt").write_text("committed local work")
            subprocess.run(["git", "-C", str(dependency), "add", "local.txt"], check=True)
            subprocess.run(["git", "-C", str(dependency), "commit", "-qm", "local work"], check=True)
            subprocess.run(["git", "-C", str(dependency), "checkout", "-q", revision], check=True)

            with patch.object(storage, "active_project_processes", return_value=[]):
                with self.assertRaisesRegex(storage.StorageSafetyError, "local branch commits"):
                    storage.clean(root, StringIO())
            branch = subprocess.run(
                ["git", "-C", str(dependency), "rev-parse", "local-work"],
                text=True,
                capture_output=True,
                check=True,
            )
            self.assertTrue(branch.stdout.strip())

    def test_clean_refuses_unknown_package_not_in_manifest(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            root = make_repo(Path(directory))
            dependency, revision = make_package(root)
            write_manifest(root, {"different-package": revision})

            with patch.object(storage, "active_project_processes", return_value=[]):
                with self.assertRaisesRegex(storage.StorageSafetyError, "do not match"):
                    storage.clean(root, StringIO())
            self.assertTrue(dependency.exists())

    def test_manifest_allows_ahead_branch_when_remote_tracking_ref_contains_it(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            root = make_repo(Path(directory))
            dependency, revision = make_package(root)
            write_manifest(root, {"dependency": revision})
            (dependency / "remote.txt").write_text("normal remote advance")
            subprocess.run(["git", "-C", str(dependency), "add", "remote.txt"], check=True)
            subprocess.run(["git", "-C", str(dependency), "commit", "-qm", "remote advance"], check=True)
            ahead = subprocess.run(
                ["git", "-C", str(dependency), "rev-parse", "HEAD"],
                text=True,
                capture_output=True,
                check=True,
            ).stdout.strip()
            subprocess.run(
                ["git", "-C", str(dependency), "update-ref", "refs/remotes/origin/master", ahead],
                check=True,
            )
            subprocess.run(["git", "-C", str(dependency), "checkout", "-q", revision], check=True)

            storage.validate_lake_dependencies(root)

    def test_process_cwd_uses_read_only_sudo_fallback_after_permission_error(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            with patch.object(storage, "_resolve_existing_directory", side_effect=PermissionError()), patch.object(
                storage.subprocess,
                "run",
                return_value=subprocess.CompletedProcess([], 0, stdout=f"{root}\n", stderr=""),
            ) as run:
                self.assertEqual(storage._process_cwd(4242), root)

            run.assert_called_once_with(
                ["sudo", "-n", "readlink", "/proc/4242/cwd"],
                text=True,
                capture_output=True,
                timeout=2,
                check=False,
            )

    def test_process_cwd_refuses_when_sudo_fallback_is_unavailable(self) -> None:
        with patch.object(storage, "_resolve_existing_directory", side_effect=PermissionError()), patch.object(
            storage.subprocess,
            "run",
            return_value=subprocess.CompletedProcess([], 1, stdout="", stderr="sudo: a password is required"),
        ):
            with self.assertRaisesRegex(storage.StorageSafetyError, "cannot inspect"):
                storage._process_cwd(4242)

    def test_installed_cua_server_is_not_treated_as_project_work(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            root = make_repo(Path(directory))
            cua_script = (
                Path.home()
                / ".codex/plugins/cache/openai-bundled/unified-computer-use/26.901.31953/scripts/launch.mjs"
            )
            command = f"/usr/bin/node {cua_script}"
            with patch.object(storage, "_caller_ancestors", return_value=set()), patch.object(
                storage, "_process_cwd", side_effect=AssertionError("CUA service should be excluded before cwd lookup")
            ):
                self.assertEqual(storage.active_project_processes(root, [(4242, command)]), [])

    def test_project_launch_script_is_still_treated_as_active_work(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            root = make_repo(Path(directory))
            project_script = root / "scripts" / "launch.mjs"
            command = f"node {project_script}"
            with patch.object(storage, "_caller_ancestors", return_value=set()):
                self.assertEqual(storage.active_project_processes(root, [(4242, command)]), [command])


if __name__ == "__main__":
    unittest.main()
