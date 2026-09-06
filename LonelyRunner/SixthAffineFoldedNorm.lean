import LonelyRunner.FoldedCirclePhase
import Mathlib.Tactic

namespace LonelyRunner

/-- A speed with signed residue `3*ε` modulo six reduces a sixth-affine
phase to a folded phase with the corresponding integral half-shift. -/
theorem circleNorm_sixth_affine_of_three_residue (t : ℝ) (d n : ℕ)
    (β z ε : ℤ) (hd : (d : ℤ) = 6 * z + 3 * ε) :
    circleNorm (((n : ℝ) * t + (β : ℝ) / 6) * (d : ℝ)) =
      circleNorm ((n : ℝ) * circleNorm (t * (d : ℝ)) +
        ((β * ε : ℤ) : ℝ) / 2) := by
  have hdR : (d : ℝ) = 6 * (z : ℝ) + 3 * (ε : ℝ) := by
    exact_mod_cast hd
  have hphase :
      ((n : ℝ) * t + (β : ℝ) / 6) * (d : ℝ) =
        (β * z : ℤ) +
          ((n : ℝ) * (t * (d : ℝ)) + ((β * ε : ℤ) : ℝ) / 2) := by
    push_cast
    rw [hdR]
    ring
  rw [hphase, circleNorm_add_int]
  exact circleNorm_nat_mul_add_int_half (t * (d : ℝ)) n (β * ε)

end LonelyRunner
