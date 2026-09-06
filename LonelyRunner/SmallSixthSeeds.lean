import LonelyRunner.FastRunnerInsertion
import Mathlib.Tactic

namespace LonelyRunner

/-- A speed at most one sixth of `A` is strictly bad at the first and fifth
sixth seeds relative to `A`. -/
theorem small_sixth_seed_norms (A U : ℝ) (hA : 0 < A) (hU : 0 < U)
    (hsmall : 6 * U ≤ A) :
    circleNorm ((1 / (6 * A)) * U) < (1 : ℝ) / 6 ∧
      circleNorm ((5 * (1 / (6 * A))) * U) < (1 : ℝ) / 6 := by
  have hden : 0 < 6 * A := by positivity
  have hfirst : 0 < (1 / (6 * A)) * U ∧ (1 / (6 * A)) * U ≤ (1 : ℝ) / 36 := by
    constructor
    · positivity
    · rw [show (1 / (6 * A)) * U = U / (6 * A) by ring]
      apply (div_le_iff₀ hden).2
      nlinarith
  have hsecond : 0 < (5 * (1 / (6 * A))) * U ∧
      (5 * (1 / (6 * A))) * U ≤ (5 : ℝ) / 36 := by
    constructor
    · positivity
    · nlinarith [hfirst.2]
  constructor
  · rw [circleNorm_eq_abs_of_abs_le_half (by rw [abs_of_nonneg hfirst.1.le]; linarith [hfirst.2]),
      abs_of_nonneg hfirst.1.le]
    linarith [hfirst.2]
  · rw [circleNorm_eq_abs_of_abs_le_half (by rw [abs_of_nonneg hsecond.1.le]; linarith [hsecond.2]),
      abs_of_nonneg hsecond.1.le]
    linarith [hsecond.2]

end LonelyRunner
