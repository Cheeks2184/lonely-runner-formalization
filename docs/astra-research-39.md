# Thirty-ninth Astra checkpoint: ordinary five total runners

This checkpoint proves `LonelyRunner.fiveRunners`: every injective family of
five real speeds has a lonely time for any selected runner, at the closed
one-fifth distance threshold. The supporting natural theorem accepts any four
positive natural speeds, including repeated values, and supplies positive time.
The unrestricted Lonely Runner Conjecture remains unresolved.

## Mathematical construction

For four positive natural speeds, decompose each into a power of five and a
unit, and choose an attained maximum exponent. If every lower level has at
most two labels, the previously verified filtering theorem supplies a common
multiplier. Otherwise three labels share a lower level and the fourth is at
the maximum. The hard-pattern theorem handles their unit parts after removing
the common power, and exact scaling of cyclic distance restores the original
modulus. The count is of labels, so repeated speeds are allowed.

The hard-pattern adapter normalizes three units by complementary residues,
constructs one coupled carry tag per unit, and applies the finite carry theorem
once to obtain a shared multiplier. Its digit identity retains the actual
current multiplier in the correction coefficient. The separate top-level bound
includes digit four at the closed boundary. Reduction modulo the period gives
a positive bounded unit multiplier and preserves all distances.

The natural witness uses the multiplier divided by the original period. This
scaling matters: the fixed hard example has time 53/625; using 53/125 for its
original speeds gives the top runner distance zero. The resulting four-speed
supply combines with the existing smaller-count results to prove H6, whose
scope is one through four moving natural speeds. The previously checked real
reduction then gives the canonical five-total-runner theorem with arbitrary
real speeds and any selected runner, including repeated absolute relative
magnitudes.

| Declaration | Checked conclusion |
| --- | --- |
| `fiveAdic_four_label_multiplier` | Bounded unit multiplier for any certified positive four-label five-adic decomposition |
| `fourMovingNaturalMultiplier` | Such a multiplier for arbitrary positive natural speeds |
| `fourMovingNaturalRunners` | A positive common time with all four closed fifth margins |
| `lowerCountPositiveIntegerHypothesis_six` | H6, covering moving counts one through four |
| `fiveRunners` | The canonical real-speed statement for five total runners |

The generic carry tag handles equality at all interval boundaries. Its state
and digit helpers allow exponent zero; the hard assembly uses a positive
exponent to preserve the multiplier's unit residue. Natural decomposition
excludes zero speeds, and the distance-scaling theorem itself also handles
zero scaling factors and moduli. Existing normalization proofs and the
canonical four-runner API are preserved.

## Verification and reproducibility

The full Lean build passed with 3,657 jobs, including cached targets. The
trust audit accepted 532 dependency lists and three axiom-free declarations;
all dependencies are among `propext`, `Classical.choice`, and `Quot.sound`.
All 15 new public theorem declarations appear in the root import and explicit
audit. The final five assembly theorems use exactly those three axioms.

The [independent source review](../research/astra-five-runner-final-source-review.md)
accepted all exact contracts and the canonical bridge without source
corrections. Its final probe contains 64 Lean examples, all 15 new types,
five compatibility types, 20 axiom reports, and 28 source guards. Root read
and replayed the exact standalone command successfully, matching its recorded
output hash. The review also checks the real-division elaboration, closed
metric predicate, count transition, arbitrary removed label, signed relative
speeds, and preservation of prior root/audit and normalization bytes.

The [verification record](../research/astra-pass39-verification.json) preserves
commands, source hashes and terminal results. The
[assembly plan](../research/astra-five-runner-assembly-plan.md),
[decomposition report](../research/astra-five-adic-decomposition-implementation.md),
[hard-adapter report](../research/astra-five-adic-carry-adapter-implementation.md),
and [ordinary implementation report](../research/astra-five-runner-ordinary-implementation.md)
contain the underlying contracts and reproducible checks.

An initial compatibility probe omitted the separate four-runner canonical
import and returned exit 1, which the worker incorrectly reported as a pass.
Root detected the error by replaying the exact command; the corrected probe
adds the import and explicit universal examples. Its actual exit code and
full output are checked. The original failing command and input bytes are
retained in the verification record. No theorem source correction was needed.
An earlier worker also ended after the carry helpers; a fresh Terra worker
completed the already assigned assembly, with the overall goal kept active.

After all local Lean verification and review replays finished, safe storage
cleanup removed the single 7,788,671,927-byte rebuildable `.lake` directory.
No allowlisted build/cache paths remain. Pinned toolchains, sources, Git
history and unique evidence are retained; restore the pinned dependencies
before rerunning the documented Lean probes or Mathlib-source guards.

Pass38 was published through PR37 and merged as
`0608747f78d8e07100af900f4f746da902bd2fa9`; the reviewed head was
`ef64109257b09da2db481b43652ba0df891d3c1e`. Both required CI jobs passed,
and root verified that remote and local main contain that checkpoint.
This verified Pass39 is ready for its own publication sequence. Research
beyond five total runners continues separately under the unrestricted goal.
