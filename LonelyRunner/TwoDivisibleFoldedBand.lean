import LonelyRunner.FastRunnerInsertion
import Mathlib.Tactic

namespace LonelyRunner

/-- Two divisible folded-circle constraints force the stated closed lower
margin and the open band for the larger phase. -/
theorem two_divisible_folded_band (a b : ℝ)
    (ha0 : 0 < a) (ha6 : a < (1 : ℝ) / 6) (hab : a ≤ b)
    (hbhalf : b ≤ (1 : ℝ) / 2)
    (h3 : circleNorm (3 * b) ≤ a) (h5 : circleNorm (5 * b) ≤ a) :
    (1 : ℝ) / 8 ≤ a ∧ (11 : ℝ) / 30 < b ∧ b < (7 : ℝ) / 18 := by
  let z : ℤ := round (3 * b)
  have hzabs : |3 * b - (z : ℝ)| ≤ a := by
    simpa [z, circleNorm_eq_abs_sub_round] using h3
  have hz := (abs_le.mp hzabs)
  have hzloR : (-1 : ℝ) < (z : ℝ) := by linarith
  have hzhiR : (z : ℝ) < 2 := by linarith
  have hzlo : (-1 : ℤ) < z := by exact_mod_cast hzloR
  have hzhi : z < 2 := by exact_mod_cast hzhiR
  have hzcase : z = 0 ∨ z = 1 := by omega
  have hz1 : z = 1 := by
    rcases hzcase with hz0 | hz1
    · have hz0R : (z : ℝ) = 0 := by exact_mod_cast hz0
      linarith [hz.2]
    · exact hz1
  have hz1R : (z : ℝ) = 1 := by exact_mod_cast hz1
  have hthree_lo : 1 - a ≤ 3 * b := by linarith [hz.1]
  have hthree_hi : 3 * b ≤ 1 + a := by linarith [hz.2]
  have hfiveabs : |5 * b - (round (5 * b) : ℝ)| ≤ a := by
    simpa [circleNorm_eq_abs_sub_round] using h5
  let w : ℤ := round (5 * b)
  have hw : -a ≤ 5 * b - (w : ℝ) ∧ 5 * b - (w : ℝ) ≤ a :=
    abs_le.mp (by simpa [w] using hfiveabs)
  have hwloR : (1 : ℝ) < (w : ℝ) := by linarith [hthree_lo]
  have hwhiR : (w : ℝ) < 3 := by linarith [hthree_hi]
  have hwlo : (1 : ℤ) < w := by exact_mod_cast hwloR
  have hwhi : w < 3 := by exact_mod_cast hwhiR
  have hw2 : w = 2 := by omega
  have hw2R : (w : ℝ) = 2 := by exact_mod_cast hw2
  have hfive_lo : 2 - a ≤ 5 * b := by linarith [hw.1]
  have hfive_hi : 5 * b ≤ 2 + a := by linarith [hw.2]
  constructor
  · have hcompare : 3 * (2 - a) ≤ 5 * (1 + a) := by
      linarith [hfive_lo, hthree_hi]
    linarith
  constructor <;> linarith

end LonelyRunner
