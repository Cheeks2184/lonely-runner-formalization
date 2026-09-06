import LonelyRunner.FoldedCirclePhase
import LonelyRunner.RealPhaseBands
import Mathlib.Tactic

/-!
# Safe folded pair phases

These ten named bounds supply the fixed affine cases of the two-divisible
argument. The additional strict inequalities drive its maximality contradiction.
-/

namespace LonelyRunner

structure FoldedPairSafeBands (a b : ℝ) : Prop where
  left_two : (1 : ℝ) / 6 ≤ circleNorm (2 * a)
  left_three : (1 : ℝ) / 6 ≤ circleNorm (3 * a)
  left_four : (1 : ℝ) / 6 ≤ circleNorm (4 * a)
  left_half : (1 : ℝ) / 6 ≤ circleNorm (a + 1 / 2)
  left_two_half : (1 : ℝ) / 6 ≤ circleNorm (2 * a + 1 / 2)
  right_one : (1 : ℝ) / 6 ≤ circleNorm b
  right_two : (1 : ℝ) / 6 ≤ circleNorm (2 * b)
  right_four : (1 : ℝ) / 6 ≤ circleNorm (4 * b)
  right_two_half : (1 : ℝ) / 6 ≤ circleNorm (2 * b + 1 / 2)
  right_three_half : (1 : ℝ) / 6 ≤ circleNorm (3 * b + 1 / 2)

theorem foldedPairSafeBands_of_bounds (a b : ℝ)
    (ha8 : (1 : ℝ) / 8 ≤ a) (ha6 : a < (1 : ℝ) / 6)
    (hblo : (11 : ℝ) / 30 < b) (hbhi : b < (7 : ℝ) / 18) :
    FoldedPairSafeBands a b := by
  have band0 : ∀ y : ℝ, (1 : ℝ) / 6 ≤ y → y ≤ (5 : ℝ) / 6 →
      (1 : ℝ) / 6 ≤ circleNorm y := by
    intro y hlo hhi
    apply circleNorm_ge_of_int_band 0 y ((1 : ℝ) / 6) <;>
      norm_num at * <;> linarith
  have band1 : ∀ y : ℝ, (7 : ℝ) / 6 ≤ y → y ≤ (11 : ℝ) / 6 →
      (1 : ℝ) / 6 ≤ circleNorm y := by
    intro y hlo hhi
    apply circleNorm_ge_of_int_band 1 y ((1 : ℝ) / 6) <;>
      norm_num at * <;> linarith
  refine ⟨band0 (2*a) (by linarith) (by linarith), band0 (3*a) (by linarith) (by linarith),
    band0 (4*a) (by linarith) (by linarith), band0 (a+1/2) (by linarith) (by linarith),
    band0 (2*a+1/2) (by linarith) (by linarith), band0 b (by linarith) (by linarith),
    band0 (2*b) (by linarith) (by linarith), band1 (4*b) (by linarith) (by linarith),
    band1 (2*b+1/2) (by linarith) (by linarith), band1 (3*b+1/2) (by linarith) (by linarith)⟩

theorem small_folded_three_five_improve (a : ℝ) (ha0 : 0 < a)
    (ha6 : a < (1 : ℝ) / 6) :
    a < circleNorm (3 * a) ∧ a < circleNorm (5 * a) := by
  constructor <;> apply circleNorm_gt_of_int_band 0 _ a ha0.le <;>
    norm_num at * <;> linarith

theorem circleNorm_double_half_gt_of_small (x : ℝ)
    (hx : circleNorm x < (1 : ℝ) / 6) :
    (1 : ℝ) / 6 < circleNorm (2 * x + 1 / 2) := by
  have hfold := circleNorm_nat_mul_add_int_half x 2 1
  norm_num at hfold
  rw [hfold]
  have hn : 0 ≤ circleNorm x := by
    rw [circleNorm_eq_abs_sub_round]
    exact abs_nonneg _
  apply circleNorm_gt_of_int_band 0 _ ((1 : ℝ) / 6) (by norm_num) <;>
    norm_num at * <;> linarith

end LonelyRunner
