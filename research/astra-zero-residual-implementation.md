# Zero-residual mixed-height implementation

## Frozen source contract

This implementation follows `research/astra-zero-residual-mixed-height.md`,
whose SHA-256 is
`91f2bfee846f2c682976e3476e8c3e3214c163661945957bdef8bdb6cecbb8a7`.
It implements the accepted zero-residual strengthening only; it does not claim
a Lonely Runner Conjecture proof or alter the existing arbitrary-runner height
theorem or ordinary finite-family equivalence.

## Implemented contracts

`exists_affinePhaseTransfer_with_zeroResidual` now returns the original
ordinary phase bounds and, for every index whose residual `V i` is zero, the
stronger `delta + epsilon` phase bound at the same positive time. The old
`exists_affinePhaseTransfer` is retained as a projection wrapper.

The corresponding stronger witnesses are
`exists_positiveAffine_witness_with_zeroResidual` and
`exists_signedAffine_witness_with_zeroResidual`; their existing public names
remain projection wrappers. The relative wrapper
`rational_affine_lonelyAt_with_equalResidual` retains the ordinary `LonelyAt`
conclusion and supplies the `1 / (m + 1)` margin for every *other* label with
the same residual as the chosen label. `rational_affine_lonelyAt` remains its
ordinary projection.

For `m >= 1`, under the existing lower-count, sorted, stationary, and
primitive hypotheses, `primitive_sorted_largeHeight_stationary_mixed` proves
that a height strictly above `Nat.choose (m + 2) 2 ^ m` gives a positive
stationary `LonelyAt` time and the additional fastest-label margin
`1 / (m + 1)`. The existing
`primitive_sorted_largeHeight_stationary_lonelyAt` retains its prior type as a
projection wrapper. The new conditional converse
`primitive_sorted_noMixed_height_le` uses exactly those hypotheses and a
no-mixed-witness premise to conclude the inclusive bound
`s (Fin.last (m + 1)) <= Nat.choose (m + 2) 2 ^ m`; it has no ordinary-witness
premise.

The final proof cleanup factors the coordinatewise phase/norm equality before
the ordinary and zero-residual branches in `AffinePhaseTransfer`, and factors
the sign-normalized norm equality before the corresponding branches in
`SignedAffineWitness`. Both conclusions consume those shared equalities.

## Verification

The shared pinned Lake cache was restored with `lake exe cache get` and kept
in place for the independent review. The commands below were run against the
current source; all completed successfully. The final command sequence and
its terminal summary were captured in this task rather than written as a
repository log file.

```text
lake build LonelyRunner.FiniteHeightReduction
# Build completed successfully (2966 jobs).

lake build LonelyRunner
# full source build completed (3638 jobs).

lake env lean LonelyRunner/AxiomAudit.lean
# all six new API probes report only: propext, Classical.choice, Quot.sound

python3 scripts/audit_lean_trust.py
# Trust audit accepted 438 theorem reports.
```

After the factoring cleanup, the final combined run completed with these
observed summaries: the focused build completed successfully (2,966 jobs reported);
the permanent axiom probe reported the six stronger APIs with only
`propext`, `Classical.choice`, and `Quot.sound`; the full source build
completed; and the trust audit again accepted 438 theorem reports.

No broad Python search was run. These are implementation and trust checks;
the stronger mathematical contract remains available for the queued
independent review.

## Source hashes after verification

```text
62291689ea8fb589ae96f50e159363277713ee67ad6bc172f8f2804cbd69ba05  LonelyRunner/AffinePhaseTransfer.lean
94532f1686bc612e9f0e852f541ed06a0e20362878c2be1ecaff645df69f261f  LonelyRunner/PositiveAffineWitness.lean
a1652cdad78c03da52c39d869b0e37d5c97d3aafb14359674492f8d4e17c3c6e  LonelyRunner/SignedAffineWitness.lean
6866bbb379b7b8fcd62f686818d5929e2ba8b2def5b06f2bf5def2b587a68459  LonelyRunner/AffineLonelyAt.lean
cb41059260b943411e2ab5360b84b59cd13f2ddf352c3c50a0b3715b9b9987d6  LonelyRunner/FiniteHeightReduction.lean
834a94f4a431c4728e5ebf22e722ee518c4c7060133fae665ee9ecfb74d54aa6  LonelyRunner/AxiomAudit.lean
```
