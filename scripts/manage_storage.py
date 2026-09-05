#!/usr/bin/env python3
"""Report and safely remove this checkout's rebuildable build caches.

This intentionally is not a general cleanup tool.  Its allowlist is limited to
cache and build products named in this repository's .gitignore.
"""

from __future__ import annotations

import argparse
import json
import os
from dataclasses import dataclass
from pathlib import Path
import shutil
import shlex
import subprocess
import sys
from typing import Iterable


# Keep this short and explicit: research output, certificates, source, Git
# metadata, and arbitrary temporary directories are deliberately absent.
ROOT_CACHE_PATHS = (
    ".lake",
    ".pytest_cache",
    ".mypy_cache",
    ".ruff_cache",
    "htmlcov",
    ".coverage",
)


class StorageSafetyError(RuntimeError):
    """Raised when a deletion cannot be shown to be safe."""


@dataclass(frozen=True)
class CacheTarget:
    path: Path
    label: str


def repository_root() -> Path:
    return Path(__file__).resolve().parents[1]


def cache_targets(root: Path) -> list[CacheTarget]:
    """Return the fixed cache allowlist plus Python bytecode directories."""
    targets = [CacheTarget(root / name, name) for name in ROOT_CACHE_PATHS]
    # rglob does not follow directory symlinks.  We still validate every result
    # before deletion so a symlink itself is never removed through this tool.
    root_cache_names = set(ROOT_CACHE_PATHS)
    targets.extend(
        CacheTarget(path, str(path.relative_to(root)))
        for path in root.rglob("__pycache__")
        # A parent target (especially .lake) owns its descendants.  Keeping
        # only top-level targets prevents double counting and a second removal.
        if path.relative_to(root).parts[0] not in root_cache_names
    )
    present = [target for target in targets if target.path.exists() or target.path.is_symlink()]
    # A nested bytecode cache is fully covered by its nearest bytecode-cache
    # ancestor.  Keep only the outer target so reports and cleanup are exact.
    paths = {target.path for target in present}
    return [target for target in present if not any(parent in paths for parent in target.path.parents)]


def bytes_in_tree(path: Path) -> int:
    """Measure regular file bytes without following symlinks."""
    if path.is_symlink():
        return 0
    if path.is_file():
        return path.stat().st_size
    total = 0
    for directory, _names, files in os.walk(path, followlinks=False):
        for name in files:
            item = Path(directory) / name
            if not item.is_symlink():
                try:
                    total += item.stat().st_size
                except FileNotFoundError:
                    # A report is best-effort if a cache is concurrently gone.
                    pass
    return total


def _within(root: Path, path: Path) -> bool:
    try:
        path.relative_to(root)
        return True
    except ValueError:
        return False


def _has_symlink_ancestor(root: Path, path: Path) -> bool:
    relative = path.relative_to(root)
    current = root
    for part in relative.parts:
        current = current / part
        if current.is_symlink():
            return True
    return False


def _run_git(root: Path, args: list[str]) -> subprocess.CompletedProcess[str]:
    return subprocess.run(
        ["git", "-C", str(root), *args], text=True, capture_output=True, check=False
    )


def validate_target(root: Path, target: CacheTarget) -> None:
    """Fail closed unless target is an ignored, untracked path inside root."""
    try:
        root = root.resolve(strict=True)
        lexical = target.path.absolute()
        lexical.relative_to(root)
    except (FileNotFoundError, ValueError) as error:
        raise StorageSafetyError(f"refusing {target.label}: path is outside the repository") from error
    if _has_symlink_ancestor(root, lexical):
        raise StorageSafetyError(f"refusing {target.label}: path contains a symlink")
    try:
        resolved = lexical.resolve(strict=True)
    except FileNotFoundError as error:
        raise StorageSafetyError(f"refusing {target.label}: path disappeared during validation") from error
    if not _within(root, resolved):
        raise StorageSafetyError(f"refusing {target.label}: symlink resolution escapes the repository")

    relative = str(lexical.relative_to(root))
    tracked = _run_git(root, ["ls-files", "-z", "--", relative])
    if tracked.returncode != 0:
        raise StorageSafetyError(f"refusing {target.label}: cannot determine tracked files")
    if tracked.stdout:
        raise StorageSafetyError(f"refusing {target.label}: target contains tracked files")
    ignored = _run_git(root, ["check-ignore", "-q", "--no-index", "--", relative])
    if ignored.returncode == 1:
        raise StorageSafetyError(f"refusing {target.label}: target is not ignored")
    if ignored.returncode != 0:
        raise StorageSafetyError(f"refusing {target.label}: cannot determine ignore status")


def validate_lake_dependencies(root: Path) -> None:
    """Protect editable Lake packages before considering the .lake cache disposable."""
    packages = root / ".lake" / "packages"
    if not packages.exists():
        return
    manifest_path = root / "lake-manifest.json"
    try:
        manifest = json.loads(manifest_path.read_text())
        pinned = {
            entry["name"]: entry["rev"]
            for entry in manifest["packages"]
            if entry.get("type") == "git" and isinstance(entry.get("name"), str)
            and isinstance(entry.get("rev"), str)
        }
    except (OSError, ValueError, KeyError, TypeError) as error:
        raise StorageSafetyError("refusing .lake: cannot read pinned package manifest") from error
    if not pinned:
        raise StorageSafetyError("refusing .lake: package manifest has no pinned Git packages")

    try:
        package_entries = list(packages.iterdir())
    except OSError as error:
        raise StorageSafetyError("refusing .lake: cannot inspect package directory") from error
    actual_names = {entry.name for entry in package_entries}
    if actual_names != set(pinned):
        raise StorageSafetyError("refusing .lake: package directories do not match the manifest")

    for dependency in package_entries:
        if not dependency.is_dir() or dependency.is_symlink():
            raise StorageSafetyError(
                f"refusing .lake: package {dependency.relative_to(root)} is not a self-contained clone"
            )
        git_metadata = dependency / ".git"
        # A .git file identifies a linked worktree.  Its contents point outside
        # this cache, so removing it cannot be established as self-contained.
        if git_metadata.is_file():
            raise StorageSafetyError(
                f"refusing .lake: dependency {dependency.relative_to(root)} is a worktree"
            )
        if not git_metadata.is_dir() or git_metadata.is_symlink():
            raise StorageSafetyError(
                f"refusing .lake: package {dependency.relative_to(root)} is not a self-contained clone"
            )
        status = _run_git(dependency, ["status", "--porcelain", "--untracked-files=normal"])
        if status.returncode != 0:
            raise StorageSafetyError(
                f"refusing .lake: cannot inspect dependency {dependency.relative_to(root)}"
            )
        if status.stdout:
            raise StorageSafetyError(
                f"refusing .lake: dependency {dependency.relative_to(root)} has local changes"
            )
        pinned_revision = pinned[dependency.name]
        head = _run_git(dependency, ["rev-parse", "HEAD"])
        if head.returncode != 0 or head.stdout.strip() != pinned_revision:
            raise StorageSafetyError(
                f"refusing .lake: dependency {dependency.relative_to(root)} is not at its manifest revision"
            )
        branches = _run_git(dependency, ["for-each-ref", "--format=%(refname:short)", "refs/heads"])
        if branches.returncode != 0:
            raise StorageSafetyError(
                f"refusing .lake: cannot inspect local branches in {dependency.relative_to(root)}"
            )
        for branch in filter(None, branches.stdout.splitlines()):
            # A standard Lake clone can retain a local default branch which is
            # newer than the manifest checkout and mirrors origin/main. It is
            # disposable only when every branch commit is already reachable
            # from either the pinned revision or a remote-tracking reference.
            unique = _run_git(
                dependency,
                ["rev-list", "--max-count=1", branch, "--not", pinned_revision, "--remotes"],
            )
            if unique.returncode != 0:
                raise StorageSafetyError(
                    f"refusing .lake: cannot compare local branches in {dependency.relative_to(root)}"
                )
            if unique.stdout.strip():
                raise StorageSafetyError(
                    f"refusing .lake: dependency {dependency.relative_to(root)} has local branch commits"
                )


def _process_rows() -> list[tuple[int, str]]:
    """Read process command lines; malformed or unavailable data is unsafe."""
    try:
        result = subprocess.run(
            ["ps", "-eo", "pid=,args="], text=True, capture_output=True, check=False
        )
    except OSError as error:
        raise StorageSafetyError("refusing cleanup: cannot inspect active processes") from error
    if result.returncode != 0:
        raise StorageSafetyError("refusing cleanup: cannot inspect active processes")
    rows: list[tuple[int, str]] = []
    for line in result.stdout.splitlines():
        fields = line.strip().split(maxsplit=1)
        if not fields or not fields[0].isdigit():
            raise StorageSafetyError("refusing cleanup: ambiguous process listing")
        rows.append((int(fields[0]), fields[1] if len(fields) == 2 else ""))
    return rows


def _caller_ancestors() -> set[int]:
    """Avoid treating this command's invoking shell as a concurrent job."""
    ancestors = {os.getpid()}
    pid = os.getppid()
    while pid > 1 and pid not in ancestors:
        ancestors.add(pid)
        try:
            # Linux proc stat's fourth field is the parent PID.  This is only
            # used to suppress our own short-lived invocation chain.
            fields = Path(f"/proc/{pid}/stat").read_text().split()
            pid = int(fields[3])
        except (FileNotFoundError, OSError, ValueError, IndexError):
            break
    return ancestors


def _process_cwd(pid: int) -> Path:
    proc_cwd = Path(f"/proc/{pid}/cwd")
    try:
        return _resolve_existing_directory(proc_cwd)
    except PermissionError:
        # Some unrelated root-owned processes hide /proc/<pid>/cwd.  A
        # passwordless sudo readlink is read-only and lets us establish that
        # such a process is outside this checkout. Container processes may
        # report a cwd that does not exist in the host namespace, so do not use
        # readlink -e or require host-side existence. Anything uncertain stays
        # unsafe and refuses cleanup below.
        try:
            result = subprocess.run(
                ["sudo", "-n", "readlink", str(proc_cwd)],
                text=True,
                capture_output=True,
                timeout=2,
                check=False,
            )
        except (OSError, subprocess.TimeoutExpired) as error:
            raise StorageSafetyError("refusing cleanup: cannot inspect a possible project process") from error
        candidate = result.stdout.strip()
        if (
            result.returncode != 0
            or not candidate
            or not os.path.isabs(candidate)
            or "(deleted)" in candidate
        ):
            raise StorageSafetyError("refusing cleanup: cannot inspect a possible project process")
        try:
            return Path(candidate).resolve(strict=False)
        except OSError as error:
            raise StorageSafetyError("refusing cleanup: cannot inspect a possible project process") from error
    except (FileNotFoundError, OSError) as error:
        raise StorageSafetyError("refusing cleanup: cannot inspect a possible project process") from error


def _resolve_existing_directory(path: Path) -> Path:
    resolved = path.resolve(strict=True)
    if not resolved.is_dir():
        raise OSError(f"{path} is not a directory")
    return resolved


def _is_installed_cua_server(command: str, root: Path) -> bool:
    """Recognize only Codex's installed browser-control Node launcher."""
    try:
        parts = shlex.split(command)
    except ValueError:
        return False
    if len(parts) != 2 or Path(parts[0]).name != "node":
        return False
    script = Path(parts[1])
    if not script.is_absolute():
        return False
    cua_root = Path.home() / ".codex" / "plugins" / "cache" / "openai-bundled" / "unified-computer-use"
    try:
        relative = script.relative_to(cua_root)
    except ValueError:
        return False
    if len(relative.parts) != 3 or relative.parts[1:] != ("scripts", "launch.mjs"):
        return False
    # The service can inherit this checkout's cwd, but its executable script
    # must remain outside it. Do not make a broad Node/Python exception.
    return not _within(root, script.resolve(strict=False))


def active_project_processes(root: Path, rows: Iterable[tuple[int, str]] | None = None) -> list[str]:
    """Return detected Lean/Lake or project research jobs, failing closed on errors."""
    root = root.resolve(strict=True)
    active: list[str] = []
    caller_ancestors = _caller_ancestors()
    markers = (
        " lake ", "/lake ", " lean ", "/lean ", ".lake/", "research/", "scripts/",
        "tests/", " build/", "/build/", "./build", " -m unittest", " -m pytest",
    )
    interpreters = (
        " python", " python3", " pytest", " node", " ruby", " perl", " rg ", " grep ",
    )
    for pid, command in (_process_rows() if rows is None else rows):
        if pid in caller_ancestors:
            continue
        if _is_installed_cua_server(command, root):
            continue
        lowered = f" {command.lower()} "
        references_root = str(root) in command
        marker = any(piece in lowered for piece in markers)
        possible_project_job = marker or any(piece in lowered for piece in interpreters)
        if references_root and possible_project_job:
            active.append(command)
            continue
        # Build/research jobs often use relative test/script paths or a binary
        # in build/. Inspect their working directory before treating them as
        # unrelated. Any unreadable possible job is an ambiguous unsafe state.
        if possible_project_job:
            cwd = _process_cwd(pid)
            if cwd == root or _within(root, cwd):
                active.append(command)
    return active


def report(root: Path, stream: object = sys.stdout) -> list[CacheTarget]:
    targets = cache_targets(root)
    total = sum(bytes_in_tree(target.path) for target in targets)
    print(f"Repository: {root}", file=stream)
    if not targets:
        print("No allowlisted cache or build paths are present.", file=stream)
        return targets
    print(f"Allowlisted rebuildable storage: {total:,} bytes across {len(targets)} paths", file=stream)
    for target in targets:
        print(f"  {target.label}: {bytes_in_tree(target.path):,} bytes", file=stream)
    print("Report only. Re-run with --clean at an idle checkpoint to remove these paths.", file=stream)
    return targets


def clean(root: Path, stream: object = sys.stdout) -> int:
    targets = cache_targets(root)
    active = active_project_processes(root)
    if active:
        raise StorageSafetyError("refusing cleanup: active project build/research process detected")
    # Validate the complete planned set before the first mutation.
    if any(target.label == ".lake" for target in targets):
        validate_lake_dependencies(root)
    for target in targets:
        validate_target(root, target)
    removed = 0
    for target in targets:
        size = bytes_in_tree(target.path)
        if target.path.is_dir():
            shutil.rmtree(target.path)
        else:
            target.path.unlink()
        removed += size
        print(f"Removed {target.label} ({size:,} bytes)", file=stream)
    print(f"Removed {removed:,} bytes from {len(targets)} allowlisted paths.", file=stream)
    return removed


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description="Report or safely clean rebuildable repository caches.")
    parser.add_argument("--clean", action="store_true", help="remove validated allowlisted cache/build paths")
    args = parser.parse_args(argv)
    root = repository_root()
    try:
        if args.clean:
            clean(root)
        else:
            report(root)
    except StorageSafetyError as error:
        print(f"storage manager: {error}", file=sys.stderr)
        return 2
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
