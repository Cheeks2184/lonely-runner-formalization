# P68-BA-DEF-03 bootstrap supervision audit

Specification task: `SPEC-P68-BA-DEF-03-BOOTSTRAP-210`

Admission: **`MEDIUM-SPEC-REQUIRED` pending independent contract review**

## Disposable exact-base tests

All tests used a fresh Linux-native detached checkout of
`c05cd83743e6290598077006b380da5d80a1c122`, with no initial `.lake/build`.

| Test | Result | Scope |
|---|---:|---|
| `lake exe cache get` | exit 0; 214.83 s | pinned package acquisition and cache restoration |
| `lake build LonelyRunner.Formulations LonelyRunner.PivotResidues` | exit 0; 76.47 s | narrow dependency frontier only |
| required `.olean` existence checks | pass | both frozen imports available |
| unchanged Task02 candidate source SHA-256 | `9c106c6775036ee58ef8f4304ea70e94430ae27c741c43c9e4c8894e56a60c19` | source identity only |
| direct candidate compile, clean single process | exceeded 300 s fail-closed bound | operational result only; no semantic fixture accepted |

Observed `.olean` SHA-256 values were:

- `Formulations.olean`:
  `a8fcddeb77df0debb0311debb89dfe609a2564dcfc748d56c5609aab7f2e7840`
- `PivotResidues.olean`:
  `428daa1defa2f0e0e1744f1d59e9b7ee8b7197dea9cf25f667ff3e1b27c444cf`

These hashes document this probe; they are not cross-machine acceptance
constants. The earlier bare targeted build without cache restoration was
stopped while compiling mathlib from source and is not counted as a failure or
success. Two duplicate Lean processes left by outer Windows timeouts were
identified and terminated before the clean bounded compile test; no probe
process remained afterward.

## Frozen Task03 correction

Task03 adds only the narrow dependency bootstrap and fail-closed process
bounds. It retains the Task02 theorem signatures, strict/closed semantics,
canonical ordering, six fixtures, exact runtime metadata probe, immutable
contract delivery gate, allowed files, evidence ceiling, and worker report
schema. Sanitized preflight artifacts must remain available through the
supervisor's pass/fail decision. No raw runtime metadata or private machine
path may be retained.

The full repository build is intentionally excluded: the targeted bootstrap
succeeded, so a broader build is unnecessary for this admission repair.

## Required independent review

Requested review ID: `VER-P68-BA-DEF03-CONTRACT-211`.

The reviewer must compare Task03 with Task02, confirm that none of the six
fixture semantics or four declaration signatures changed, replay the
bootstrap commands in a fresh exact-base worktree, audit the retention and
timeout rules, and return either `LUNA-READY` or a precise specification
defect. No Luna session may launch from the draft record.
