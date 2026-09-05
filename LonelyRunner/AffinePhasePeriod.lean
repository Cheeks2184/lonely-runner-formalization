import LonelyRunner.FastRunnerInsertion
import Mathlib.Algebra.Order.Floor.Ring

/-!
# Common-period normalization of an affine phase

When every second-phase coefficient has an integral common period, an
arbitrary second phase can be moved to `[q, 2q)` without changing any circle
norm.  The period need not be minimal and no condition is imposed on the
index type or first-phase coefficients.
-/

namespace LonelyRunner

noncomputable section

/-- Normalize a common affine second phase into `[q, 2q)` while preserving all
coordinate phase norms. -/
theorem exists_normalized_affine_second_phase {ι : Type*}
    (A V : ι → ℝ) (q y0 : ℝ) (hq : 0 < q)
    (hperiod : ∀ i, ∃ z : ℤ, q * V i = (z : ℝ)) :
    ∃ y : ℝ, q ≤ y ∧ y < 2 * q ∧
      ∀ i, circleNorm (A i + V i * y) = circleNorm (A i + V i * y0) := by
  let f : ℝ := Int.fract (y0 / q)
  let y : ℝ := q * f + q
  have hf0 : 0 ≤ f := Int.fract_nonneg _
  have hf1 : f < 1 := Int.fract_lt_one _
  have hyLower : q ≤ y := by
    dsimp [y]
    nlinarith [mul_nonneg hq.le hf0]
  have hyUpper : y < 2 * q := by
    dsimp [y]
    have hmul : q * f < q * 1 := mul_lt_mul_of_pos_left hf1 hq
    linarith
  refine ⟨y, hyLower, hyUpper, fun i => ?_⟩
  obtain ⟨z, hz⟩ := hperiod i
  let n : ℤ := z * (1 - ⌊y0 / q⌋)
  have hy : y = y0 - q * (⌊y0 / q⌋ : ℝ) + q := by
    change q * Int.fract (y0 / q) + q =
      y0 - q * (⌊y0 / q⌋ : ℝ) + q
    rw [Int.fract]
    calc
      q * (y0 / q - (⌊y0 / q⌋ : ℝ)) + q =
          q * (y0 / q) - q * (⌊y0 / q⌋ : ℝ) + q := by ring
      _ = y0 - q * (⌊y0 / q⌋ : ℝ) + q := by
        rw [mul_div_cancel₀ y0 hq.ne']
  have hphase : A i + V i * y = (n : ℝ) + (A i + V i * y0) := by
    calc
      A i + V i * y = A i + V i * y0 + (q * V i) *
          (1 - (⌊y0 / q⌋ : ℝ)) := by rw [hy]; ring
      _ = (n : ℝ) + (A i + V i * y0) := by
        rw [hz]
        dsimp [n]
        push_cast
        ring
  rw [hphase, circleNorm_add_int]

end

end LonelyRunner
