import LonelyRunner.BoundedRealReduction
import LonelyRunner.FourRunnerOrdinary

/-!
# Ordinary Lonely Runner theorem for four total runners

This specialization combines the proved bounded H5 natural supply with the
generic labelled real reduction.  It concerns exactly four total runners.
-/

namespace LonelyRunner

/-- Every injective real speed family of four total runners has an ordinary
lonely witness for any selected runner. -/
theorem fourRunners (speeds : Fin 4 → ℝ) (hinj : Function.Injective speeds)
    (runner : Fin 4) : ∃ t : ℝ, LonelyAt speeds runner t :=
  lonelyAt_of_lowerCount (m := 3) (by omega)
    lowerCountPositiveIntegerHypothesis_five speeds hinj runner

end LonelyRunner
