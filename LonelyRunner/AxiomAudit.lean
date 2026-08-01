import LonelyRunner

/-!
Run with `lake env lean LonelyRunner/AxiomAudit.lean`.

These commands report the axioms used by the statement-equivalence layer.  The
expected output is only Lean's standard logical foundations (typically
propositional extensionality and quotient soundness where applicable), never a
project-specific axiom.
-/

#print axioms LonelyRunner.lonelyAt_iff_relativeLonelyAt
#print axioms LonelyRunner.conjecture_iff_nonnegativeTimeConjecture
#print axioms LonelyRunner.conjecture_iff_relativeConjecture
#print axioms LonelyRunner.conjecture_iff_distinctStationaryConjecture
#print axioms LonelyRunner.distinctStationaryConjecture_iff_stationaryConjecture
#print axioms LonelyRunner.conjecture_iff_stationaryConjecture
#print axioms LonelyRunner.oneMovingRunner
#print axioms LonelyRunner.StationaryConjecture
#print axioms LonelyRunner.DistinctStationaryConjecture
#print axioms LonelyRunner.PositiveIntegerConjecture
#print axioms LonelyRunner.abs_circleNorm_sub_circleNorm_le
#print axioms LonelyRunner.exists_small_shift_circleNorm_ge
#print axioms LonelyRunner.fastRunnerInsertion
