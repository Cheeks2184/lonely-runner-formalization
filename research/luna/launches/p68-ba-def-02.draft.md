# P68-BA-DEF-02 immutable launch-record draft

Status: **draft only; not approved and not launch-authorizing**.

This file is a Sol High preparation template. It is intentionally stored at a
different path from the final immutable record required by the contract:

```text
research/luna/launches/p68-ba-def-02.md
```

A worker must reject this draft. Sol High must create and commit the final
record before launching a fresh session, replacing every placeholder and
changing authority to the exact literal `approved`. The final record commit
SHA is then supplied externally to the worker; it does not change the worker
base.

```text
Task ID: P68-BA-DEF-02
Worker base: 1bfe7fe27e01478cac8921a895882d1fedf6df61
Contract commit: <40-hex reviewed commit containing the exact contract blob>
Contract path: research/luna/contracts/p68-ba-def-02.md
Contract SHA-256: <64-hex SHA-256 of Contract commit/Contract path>
Worker branch: formal/luna-p68-ba-def-02
Worktree mapping: ../lrc-luna-p68-ba-def-02
Runtime target: gpt-5.6-luna/xhigh fresh top-level Codex session
Runtime not-before UTC: <yyyy-MM-ddTHH:mm:ss.fffZ recorded immediately before launch>
Sol High launch authority: pending
```

The not-before value must be recorded immediately before the new top-level
session is created. It must be no more than fifteen minutes old when the
worker runs the exact self-metadata probe. Reusing Task01's session, timestamp,
branch, worktree, launch record, or runtime attestation is prohibited.

This draft creates no task admission, worker session, implementation,
verification result, evidence label, or mathematical status.
