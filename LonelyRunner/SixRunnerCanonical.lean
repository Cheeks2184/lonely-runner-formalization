import LonelyRunner.SixRunnerOrdinary
import LonelyRunner.BoundedRealReduction

/-!
# Canonical Lonely Runner theorem for six total runners

The bounded `H_7` supply from `SixRunnerOrdinary` is transferred through the
existing real reduction.  This declaration retains the canonical injectivity
and selected-runner quantifiers, so it applies to arbitrary real speeds.
-/

namespace LonelyRunner

/-- Every selected runner in an injective six-speed real family has a lonely
witness at the canonical closed sixth margin. -/
theorem sixRunners (speeds : Fin 6 → ℝ)
    (hinj : Function.Injective speeds) (runner : Fin 6) :
    ∃ t : ℝ, LonelyAt speeds runner t :=
  lonelyAt_of_lowerCount (m := 5) (by omega)
    lowerCountPositiveIntegerHypothesis_seven speeds hinj runner

end LonelyRunner
