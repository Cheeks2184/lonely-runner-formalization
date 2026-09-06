import LonelyRunner.FastRunnerInsertion
import LonelyRunner.StructuredClasses
import Mathlib.Tactic

namespace LonelyRunner

/-- Every real phase has an integer lift whose residual is its folded circle
norm, with either orientation. -/
theorem exists_int_circleNorm_lift (x : ℝ) :
    ∃ z : ℤ, x = (z : ℝ) + circleNorm x ∨ x = (z : ℝ) - circleNorm x := by
  let z : ℤ := round x
  have hnorm : circleNorm x = |x - (z : ℝ)| := by
    simpa [z] using circleNorm_eq_abs_sub_round x
  by_cases h : 0 ≤ x - (z : ℝ)
  · refine ⟨z, Or.inl ?_⟩
    rw [hnorm, abs_of_nonneg h]
    linarith
  · refine ⟨z, Or.inr ?_⟩
    rw [hnorm, abs_of_nonpos (le_of_not_ge h)]
    linarith

/-- A natural multiple commutes with folding under an integral half-shift. -/
theorem circleNorm_nat_mul_add_int_half (x : ℝ) (n : ℕ) (β : ℤ) :
    circleNorm ((n : ℝ) * x + (β : ℝ) / 2) =
      circleNorm ((n : ℝ) * circleNorm x + (β : ℝ) / 2) := by
  rcases exists_int_circleNorm_lift x with ⟨z, hz | hz⟩
  · nth_rw 1 [hz]
    have hphase :
        (n : ℝ) * ((z : ℝ) + circleNorm x) + (β : ℝ) / 2 =
          ((n : ℤ) * z : ℤ) + ((n : ℝ) * circleNorm x + (β : ℝ) / 2) := by
      push_cast
      ring
    rw [hphase, circleNorm_add_int]
  · nth_rw 1 [hz]
    have hphase :
        (n : ℝ) * ((z : ℝ) - circleNorm x) + (β : ℝ) / 2 =
          ((n : ℤ) * z + β : ℤ) +
            -((n : ℝ) * circleNorm x + (β : ℝ) / 2) := by
      push_cast
      ring
    rw [hphase, circleNorm_add_int, circleNorm_neg]

/-- Translation by a half-turn complements the folded circle norm. -/
theorem circleNorm_add_half (x : ℝ) :
    circleNorm (x + (1 : ℝ) / 2) = (1 : ℝ) / 2 - circleNorm x := by
  have hfold := circleNorm_nat_mul_add_int_half x 1 1
  norm_num at hfold
  rw [hfold]
  have hnonneg : 0 ≤ circleNorm x := by
    rw [circleNorm_eq_abs_sub_round]
    exact abs_nonneg _
  have hhalf : circleNorm x ≤ (1 : ℝ) / 2 := by
    rw [circleNorm_eq_abs_sub_round]
    exact abs_sub_round x
  rw [show circleNorm x + (1 : ℝ) / 2 =
      (1 : ℤ) + (circleNorm x - (1 : ℝ) / 2) by push_cast; ring]
  rw [circleNorm_add_int, circleNorm_eq_abs_of_abs_le_half]
  · rw [abs_of_nonpos (by linarith)]
    ring
  · rw [abs_of_nonpos (by linarith)]
    linarith

end LonelyRunner
