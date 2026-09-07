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

## Memory limits during restoration and compilation

The 2026-09-07 resource check identified an unrelated parallel Rust build
as the cause of the machine's previous memory exhaustion. This project still
needs to leave room for the desktop and other work whenever it compiles.
Use a project-only transient user service for dependency restoration and
local Lean checks. Keep its aggregate `MemoryMax=4G` and
`MemorySwapMax=512M`; a limit on an individual Lean process alone does not
limit all of a build's subprocesses. Root verified these values by reading
`memory.max` and `memory.swap.max` from inside a probe service on this host.

Root grants the serial verification slot before a cache-writing operation.
Acquire `.lake/verification.lock` inside the service. For a focused check
whose imports have already been compiled, the command has this form:

```bash
systemd-run --user --wait --pipe --collect \
  -p MemoryMax=4G -p MemorySwapMax=512M -p TasksMax=128 \
  --working-directory=/home/joshua/lonely-runner-formalization \
  /usr/bin/flock -n .lake/verification.lock \
  /home/joshua/.elan/bin/lake env lean -j1 \
  -o .lake/build/lib/lean/LonelyRunner/MinimalCounterexample.olean \
  LonelyRunner/MinimalCounterexample.lean
```

Create the ignored output directories before the first check. Use the owned
module's actual path; do not compile an unfinished or unrelated target.
Compile missing project imports in dependency order, waiting for each process
to finish before starting the next. `lean -j1` controls that compiler's
threads; it is not a Lake build-job limit. Do not assume `lake build -j1`
is supported by this pinned toolchain.

After idle cleanup, restore only the imports needed by the next authorized
verification batch with `lake exe cache get` and explicit Mathlib module
arguments, under the same aggregate cap and advisory lock. Set
`MATHLIB_NO_CACHE_ON_UPDATE=1` to avoid an automatic all-Mathlib download,
and `MATHLIB_CACHE_DIR` to this checkout's `.lake/download-cache` so the
compressed download cache is also removed by the normal project cleanup.
Read the pinned cache CLI help when its syntax is uncertain. Retain the
installed Lean toolchain and fetch dependencies from the pinned manifest.

The root owns full integration and trust verification; hosted CI supplies
those checks for each published source checkpoint without allocating a
parallel full build on this desktop. A failed or memory-limited local run
must retain its diagnostics and be repaired within the existing worker
limits. Do not remove the cap or launch an unbounded duplicate to recover.

Cache cleanup is maintenance, not a research or source-management operation.
It remains forbidden during any active build or verification run.
