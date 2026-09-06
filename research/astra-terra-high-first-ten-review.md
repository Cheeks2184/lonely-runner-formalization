# First ten Terra High deliveries

Cohort: the first ten completed High task records, ending with the signed
remaining-phase adapters. Eight are Lean tasks and two are Python/tooling tasks;
the active three-even orbit task is excluded. The first-check metric includes
launcher failures, so it is not purely a measure of source correctness.

| Cohort | Deliveries | First check passed | Worker repair rounds | Astra guidance rounds | Direct Astra edited lines |
| --- | ---: | ---: | ---: | ---: | ---: |
| Lean | 8 | 1 | 9 | 1 | 0 |
| Python/tooling | 2 | 2 | 2 | 4 | 0 |

All ten eventually delivered their assigned checked output. The Lean guidance
round corrected invocation after two pre-elaboration failures; the full finite
tables then compiled unchanged. Terra handled the source repair cycles for
residue/orbit arithmetic, certificate soundness, a complete parity branch,
weak shift helpers, finite tables, real assembly and signed wrappers. Those
settled implementations remained appropriate for Terra High.

First-pass success is low, but compile ownership substantially reduced observed
root repair work: the old source-only audit required root fixes in eight of ten
recent Lean modules, whereas this cohort required no direct root source edits
and one launcher-guidance round across eight Lean deliveries. This is a change
in measured repair burden, not evidence that raising effort alone caused it.
Task scope, exact plans and compile ownership also changed. Astra still supplied
mathematical plans, source reading and independent review.

There were two delivery-protocol failures: SmallPhaseOrbits and WeakSixthShifts
did not retain failed-source bytes. Their final sources and logs were preserved
and accepted, with the historical gap disclosed. The same worker's latest
signed adapter delivery correctly retained all three physical source snapshots.
Two launcher/startup failures on the finite tables caused avoidable coordination.
Use the now-successful direct Lean command and existing receipt capture pattern
for future bounded focused checks; there is no need to redesign verification
for each module.

Keep the current High division of labor and two-repair limit. Continue delegating
cohesive settled modules, escalate semantic uncertainty, inspect complete receipts
without duplicate successful runs, and retain final integration/trust reviews.
Reassess after twenty completed High deliveries. All ten per-task usage and
worker-duration fields are unknown, so neither token savings nor elapsed-time
savings are established by this sample. No model/effort policy is changed.

## Frozen cohort evidence

- `/root/terra_high_workflow_controls`: `research/astra-pass54-verification.json`
- `/root/small_phase_orbits_high`: `research/astra-small-phase-orbit-implementation.json`
- `/root/affine_phase_certificate_foundations`: `research/astra-affine-phase-certificate-implementation.json`
- `/root/remaining_phase_data_program`: `research/astra-remaining-phase-data-program.json`, `/tmp/astra-remaining-phase-data-fixed-v1`
- `/root/one_even_branch_implementation`: `research/astra-one-even-implementation.json`
- `/root/weak_sixth_shifts_implementation`: `research/astra-weak-sixth-shifts-implementation.json`
- `/root/remaining_phase_kernel_pilot`: `research/astra-remaining-phase-kernel-pilot.json`
- `/root/remaining_phase_full_tables`: `research/astra-remaining-phase-full-tables.json`
- `/root/remaining_phase_real_implementation`: `research/astra-remaining-phase-real-implementation.json`
- `/root/signed_remaining_phase_implementation`: `research/astra-signed-remaining-phase-implementation.json`
