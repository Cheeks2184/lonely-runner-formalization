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
#print axioms LonelyRunner.circleNorm_ge_of_int_band
#print axioms LonelyRunner.minimumScaleResidueBands
#print axioms LonelyRunner.card_biUnion_le_sum_card
#print axioms LonelyRunner.exists_mem_avoiding_of_sum_card_lt_card
#print axioms LonelyRunner.card_union_le_card_add_selected_remainder
#print axioms LonelyRunner.card_ordered_union_le_sum_selected_remainders
#print axioms LonelyRunner.exists_mem_avoiding_ordered_of_sum_lt_card
#print axioms LonelyRunner.circleNorm_mul_abs_right
#print axioms LonelyRunner.exists_stationaryWitness_abs_iff
#print axioms LonelyRunner.exists_stationaryWitness_scale_iff
#print axioms LonelyRunner.exists_stationaryWitness_natScale_iff
#print axioms LonelyRunner.twoMovingSpeeds_of_abs_le
#print axioms LonelyRunner.twoMovingSpeeds
#print axioms LonelyRunner.twoMovingRunners
