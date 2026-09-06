import LonelyRunner.SixthAffinePhase
import LonelyRunner.FoldedCirclePhase
import Mathlib.Tactic

namespace LonelyRunner

/-- Either signed half-shift has the same quotient-circle norm. -/
theorem circleNorm_add_signed_half (x : ℝ) (σ : ℤ)
    (hσ : σ = 1 ∨ σ = -1) :
    circleNorm (x + (σ : ℝ) / 2) = circleNorm (x + 1 / 2) := by
  rcases hσ with rfl | rfl
  · norm_num
  · have hphase : x + ((-1 : ℤ) : ℝ) / 2 =
        (-1 : ℤ) + (x + 1 / 2) := by ring
    rw [hphase, circleNorm_add_int]

/-- At the fifth-sixths anchor, a signed special residue reduces to the
displayed natural sixth fraction. -/
theorem fract_sixth_affine_special_anchor (τ : ℝ) (c n κ : ℕ)
    (z σ : ℤ) (hd : (c : ℤ) = 6 * z + (κ : ℤ) * σ)
    (hσ : σ = 1 ∨ σ = -1)
    (ht : Int.fract (τ * (c : ℝ)) = (5 : ℝ) / 6) :
    Int.fract (((n : ℝ) * τ + (σ : ℝ) / 6) * (c : ℝ)) =
      Int.fract (((5 * n + κ : ℕ) : ℝ) / 6) := by
  have hgeneral := fract_sixth_affine_time τ c (n : ℤ) σ z ((κ : ℤ) * σ) hd
  rw [ht] at hgeneral
  rcases hσ with rfl | rfl
  · convert hgeneral using 1 <;> push_cast <;> ring
  · convert hgeneral using 1 <;> push_cast <;> ring

end LonelyRunner
