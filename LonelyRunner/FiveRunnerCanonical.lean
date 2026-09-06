import LonelyRunner.FiveRunnerOrdinary
import LonelyRunner.BoundedRealReduction

/-!
# Ordinary Lonely Runner theorem for five total runners
-/

namespace LonelyRunner

/-- Every injective real speed family of five total runners has an ordinary
lonely witness for any selected runner. -/
theorem fiveRunners (speeds : Fin 5 → ℝ) (hinj : Function.Injective speeds)
    (runner : Fin 5) : ∃ t : ℝ, LonelyAt speeds runner t :=
  lonelyAt_of_lowerCount (m := 4) (by omega)
    lowerCountPositiveIntegerHypothesis_six speeds hinj runner

end LonelyRunner
