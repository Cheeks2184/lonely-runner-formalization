# P68-BA-DEF-03 bootstrap supervision audit

Specification task: `SPEC-P68-BA-DEF-03-BOOTSTRAP-210`
Correction task: `SPEC-P68-BA-DEF-03-CORRECTION-222`

Admission: **`MEDIUM-SPEC-REQUIRED` pending independent contract review**

## Disposable exact-base tests

All tests used a fresh Linux-native detached checkout of
`1bfe7fe27e01478cac8921a895882d1fedf6df61`, with no initial `.lake/build`.

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
bounds. Independent review 211 found two operational specification defects:
retained `commands.log` could receive unsanitized negative-fixture diagnostics,
and the cache and targeted dependency build lacked explicit Linux-native
timeouts. The correction uses mode-`600` ephemeral diagnostic files with an
exit trap, retains only two exact allowlisted cause summaries, fails closed if
the cause or cleanup cannot be verified, and gives both bootstrap commands
ten-minute fail-closed bounds within the unchanged 55-minute total budget.

It retains the Task02 theorem signatures, strict/closed semantics,
canonical ordering, six fixtures, exact runtime metadata probe, immutable
contract delivery gate, allowed files, evidence ceiling, and worker report
schema. Sanitized preflight artifacts must remain available through the
supervisor's pass/fail decision. No raw runtime metadata or private machine
path may be retained.

The full repository build is intentionally excluded: the targeted bootstrap
succeeded, so a broader build is unnecessary for this admission repair.

## Required independent review

Requested fresh review ID: `VER-P68-BA-DEF03-CONTRACT-223`.

The reviewer must compare the correction with commit
`138f3eb72899846ce1c5147b8baa8e1b80af5720`, confirm that only review-211's two
operational defects changed, audit the allowlisted diagnostic retention and
bootstrap timeout handling, and confirm that the six fixture semantics and
four declaration signatures remain unchanged. This Level-1 correction does
not rerun the already recorded bootstrap. The reviewer must return either
`LUNA-READY` or a precise specification defect. No Luna session may launch
from the draft record.
