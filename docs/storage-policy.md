# Storage policy

This checkout keeps one dependency and build cache per shared checkout. The
cache is useful while Lean builds, formalization work, or research scripts are
running, so do not remove it during active work.

At an idle checkpoint, inspect rebuildable storage with:

```bash
python3 scripts/manage_storage.py
```

The command only reports sizes by default. It prints a compact list of the
allowlisted cache and build paths it found; it does not inspect or list their
contents.

To remove the reported paths at an idle checkpoint, use:

```bash
python3 scripts/manage_storage.py --clean
```

The cleaner has a deliberately narrow allowlist: this checkout's `.lake`,
explicit Python-tool caches, and ignored `__pycache__` directories. It does
not remove generic `build`, virtual-environment, temporary, or package paths:
those may hold work that cannot be reconstructed. It never selects sources,
certificates, research evidence, project Git history, arbitrary `/tmp` paths, another
checkout, or any global tool cache. Before deleting it refuses a target with
tracked files, a target that is not ignored, a symlink path or escape outside
the checkout, or a detected active Lean/Lake/research/test process. It also
refuses `.lake` when package directories differ from `lake-manifest.json`, a
dependency is not a self-contained clone at its exact pinned revision, it has
local changes or local-only branch commits, or it is a linked worktree. A
normal local default branch ahead of the pinned checkout is allowed when the
same commits are present in a remote-tracking reference.
If it cannot inspect process state unambiguously, it refuses cleanup.

The process check is deliberately conservative, but it cannot eliminate the
race between inspection and a newly started job. Coordinate cleanup at an idle
checkpoint with everyone sharing the checkout; do not rely on the command as
the only signal that work has stopped.

When ordinary process inspection is blocked by ownership, the command may use
passwordless `sudo -n readlink /proc/<pid>/cwd` only to read that process's
working-directory link. This accommodates unrelated container processes whose
reported working directory is not present in the host filesystem. A failed,
relative, or deleted-path result still refuses cleanup; the fallback never
uses sudo to change files or stop processes.

The installed Codex CUA browser-control launcher is excluded from the active
work check even when it inherits this checkout's working directory. The
exception matches only its exact bundled `node .../unified-computer-use/<version>/scripts/launch.mjs`
command outside this repository; ordinary Node, Python, test, research, and
build commands remain blocking work.

After an idle cleanup, rebuild the pinned dependency cache and project with:

```bash
export PATH="$HOME/.elan/bin:$PATH"
lake exe cache get && lake build
```

Run that command only when you intend to rebuild. Cache cleanup is maintenance,
not a research or source-management operation.
