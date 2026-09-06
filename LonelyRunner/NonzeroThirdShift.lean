import LonelyRunner.ThirdShiftSpacing
import LonelyRunner.SeparatedPhaseFamily
import Mathlib.Tactic

namespace LonelyRunner

/-- A weakly bad phase is safe at each nonzero third shift of a speed not
divisible by three. -/
theorem third_shift_safe_of_weak_bad (x : ℝ) (d : ℕ) (hnot : ¬ 3 ∣ d)
    (hx : circleNorm x ≤ (1 : ℝ) / 6) (k : Fin 3) (hk : k ≠ 0) :
    (1 : ℝ) / 6 ≤ circleNorm (x + (k.val : ℝ) * (d : ℝ) / 3) := by
  have hsep := circleNorm_third_shift_sub_ge x d hnot k 0 hk
  have htri := circleNorm_sub_le_add
    (x + (k.val : ℝ) * (d : ℝ) / 3) (x + (0 : ℝ) * (d : ℝ) / 3)
  norm_num only [Fin.val_zero, Nat.cast_zero, zero_mul, zero_div, add_zero] at hsep htri
  linarith

/-- At least one nonzero third shift is safe for any phase of a speed not
divisible by three. -/
theorem exists_nonzero_third_shift_safe (x : ℝ) (d : ℕ) (hnot : ¬ 3 ∣ d) :
    ∃ k : Fin 3, k ≠ 0 ∧
      (1 : ℝ) / 6 ≤ circleNorm (x + (k.val : ℝ) * (d : ℝ) / 3) := by
  let k1 : Fin 3 := 1
  let k2 : Fin 3 := 2
  by_cases h1 : (1 : ℝ) / 6 ≤ circleNorm (x + (k1.val : ℝ) * (d : ℝ) / 3)
  · exact ⟨k1, by decide, h1⟩
  by_cases h2 : (1 : ℝ) / 6 ≤ circleNorm (x + (k2.val : ℝ) * (d : ℝ) / 3)
  · exact ⟨k2, by decide, h2⟩
  exfalso
  have hsep := circleNorm_third_shift_sub_ge x d hnot k1 k2 (by decide)
  have htri := circleNorm_sub_le_add
    (x + (k1.val : ℝ) * (d : ℝ) / 3)
    (x + (k2.val : ℝ) * (d : ℝ) / 3)
  have hb1 : circleNorm (x + (k1.val : ℝ) * (d : ℝ) / 3) < (1 : ℝ) / 6 :=
    lt_of_not_ge h1
  have hb2 : circleNorm (x + (k2.val : ℝ) * (d : ℝ) / 3) < (1 : ℝ) / 6 :=
    lt_of_not_ge h2
  linarith

end LonelyRunner
