import LonelyRunner.FastRunnerInsertion
import Mathlib.Tactic

namespace LonelyRunner

/-- The quotient-circle norm satisfies the subtraction triangle inequality. -/
theorem circleNorm_sub_le_add (u v : ℝ) :
    circleNorm (u - v) ≤ circleNorm u + circleNorm v := by
  unfold circleNorm
  rw [AddCircle.coe_sub]
  exact norm_sub_le _ _

/-- Pairwise separation at twice a threshold permits at most one label to be
strictly inside that threshold; labels may represent equal phase values. -/
theorem circleNorm_bad_subsingleton_of_separated {α : Type*}
    (f : α → ℝ) (δ : ℝ)
    (hsep : ∀ i j, i ≠ j →
      2 * δ ≤ circleNorm (f i - f j)) :
    Set.Subsingleton {i : α | circleNorm (f i) < δ} := by
  intro i hi j hj
  simp only [Set.mem_setOf_eq] at hi hj
  by_contra hne
  have htri : circleNorm (f i - f j) ≤ circleNorm (f i) + circleNorm (f j) :=
    circleNorm_sub_le_add _ _
  have hstrict : circleNorm (f i - f j) < 2 * δ := by linarith
  exact (not_lt_of_ge (hsep i j hne)) hstrict

end LonelyRunner
