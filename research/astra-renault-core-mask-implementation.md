# Renault core-mask implementation receipt

Pre-execution source SHA-256: `e8d22315011c0365a2dd05d6bc9bf0a7acc2389fb1b75e6479d7d30c4c2cc6e6`.
The 41 literals are the stipulated `masks[class_reps[i]]` entries for the
saved `minimal_classes` order from certificate SHA-256
`c1374409d4f6804487179fe9765695a2f0d756ccd2a79b5ee8616e919acbb7b1`.

The one permitted source check is launched with:

```bash
set -euo pipefail
export PATH="$HOME/.elan/bin:$PATH"
ulimit -v 8388608 -t 59
timeout 60s env LEAN_NUM_THREADS=1 LEAN_STACK_SIZE_KB=65536 \
  lake env lean -j1 -s65536 LonelyRunner/RenaultPhaseMasks.lean
```

It uses the settled 8 GiB virtual-address cap, 59/60 CPU/wall caps, one Lean
thread, 64 MiB stack, and source-local `maxHeartbeats 1000000` and
`maxRecDepth 4096` settings. Execution receipt follows after this predeclared
invocation; a timeout, stream truncation, or nonzero exit is retained as a
failed check without cap escalation.

## Actual source checks

The initial generated source used SHA-256
`e8d22315011c0365a2dd05d6bc9bf0a7acc2389fb1b75e6479d7d30c4c2cc6e6`.
The worker-reported capped launcher exited `1` after 24.4 seconds. The
ephemeral tool response showed no stdout and the following diagnostic excerpt:

```text
LonelyRunner/RenaultPhaseMasks.lean:140:2: error: failed to synthesize
  Fintype (Fin 41)
LonelyRunner/RenaultPhaseMasks.lean:141:4: error: Type mismatch
  renaultPhaseCoreMask_row_0
LonelyRunner/RenaultPhaseMasks.lean:142:2: error: No goals to be solved
```

This was a tactic-import issue: `Mathlib.Tactic.FinCases` did not supply the
finite enumeration support used by `fin_cases`. The only repair replaced that
import with `Mathlib.Tactic`; all 41 literals, 41 private row propositions,
both public theorem statements, resource options, and the finite domain were
preserved. No cap was raised and no data was searched.

The final source SHA-256 is
`65bb6c52e52e710f098b60ec1e3c00bebc43771845268789cd82519618d801b2`.
The same launcher, with `ulimit -v 8388608 -t 59`, `timeout 60s`,
`LEAN_NUM_THREADS=1`, `LEAN_STACK_SIZE_KB=65536`, `-j1`, and `-s65536`,
then worker-reported exit `0` in 25.8 seconds with no displayed output. Both
runs invoked the stated 59-second CPU soft limit, 60-second wall limit, 8 GiB
virtual-address limit, and source heartbeat/recursion limits. No raw stream
files, byte hashes, resource receipt, launcher file, or enforced per-stream
256 KiB capture record were retained; the direct tool response was ephemeral.

The final module was direct-source checked, so it produced no `.olean` file.
Consequently the separate import-only axiom probe worker-reported a nonzero
exit before its `#print axioms` commands, displaying:

```text
/dev/stdin:1:0: error: object file '/home/joshua/lonely-runner-formalization/
.lake/build/lib/lean/LonelyRunner/RenaultPhaseMasks.olean' of module
LonelyRunner.RenaultPhaseMasks does not exist
```

This is an expected unavailable-artifact result, not an axiom result; the
root focused Lake build is responsible for the later import-based probe.
`git diff --check` passed after the final source check.

No filesystem paths exist for retained raw stdout, stderr, launcher, or
resource receipts from these three worker invocations. This receipt preserves
only the source hashes, commands, and worker-reported outcomes; it must not be
used as exact raw-execution evidence. The later root-owned focused Lake build
is independent verification.
