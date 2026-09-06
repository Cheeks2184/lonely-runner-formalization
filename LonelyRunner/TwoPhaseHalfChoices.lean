import LonelyRunner.FoldedPairSafeBands
import LonelyRunner.FoldedCirclePhase
import Mathlib.Tactic

namespace LonelyRunner

/-- Two phases admit either their original half-choice, their common half
translate, or the doubled half choice at the closed sixth margin. -/
theorem two_phase_half_choices (x y : ℝ) :
    ((1 : ℝ) / 6 ≤ circleNorm x ∧ (1 : ℝ) / 6 ≤ circleNorm y) ∨
      (((1 : ℝ) / 6 ≤ circleNorm (x + 1 / 2) ∧
          (1 : ℝ) / 6 ≤ circleNorm (y + 1 / 2)) ∨
        ((1 : ℝ) / 6 ≤ circleNorm (2 * x + 1 / 2) ∧
          (1 : ℝ) / 6 ≤ circleNorm (2 * y + 1 / 2))) := by
  by_cases hx : (1 : ℝ) / 6 ≤ circleNorm x
  · by_cases hy : (1 : ℝ) / 6 ≤ circleNorm y
    · exact Or.inl ⟨hx, hy⟩
    · right
      have hybad : circleNorm y < (1 : ℝ) / 6 := lt_of_not_ge hy
      have hyhalf : (1 : ℝ) / 6 ≤ circleNorm (y + 1 / 2) := by
        rw [circleNorm_add_half]
        linarith
      by_cases hxhalf : (1 : ℝ) / 6 ≤ circleNorm (x + 1 / 2)
      · exact Or.inl ⟨hxhalf, hyhalf⟩
      · right
        have hxbad : circleNorm (x + 1 / 2) < (1 : ℝ) / 6 := lt_of_not_ge hxhalf
        have hxfold := circleNorm_double_half_gt_of_small (x + 1 / 2) hxbad
        have hyfold := circleNorm_double_half_gt_of_small y hybad
        have hphase : 2 * (x + 1 / 2) + 1 / 2 =
            (1 : ℤ) + (2 * x + 1 / 2) := by ring
        rw [hphase, circleNorm_add_int] at hxfold
        exact ⟨hxfold.le, hyfold.le⟩
  · right
    have hxbad : circleNorm x < (1 : ℝ) / 6 := lt_of_not_ge hx
    have hxhalf : (1 : ℝ) / 6 ≤ circleNorm (x + 1 / 2) := by
      rw [circleNorm_add_half]
      linarith
    by_cases hyhalf : (1 : ℝ) / 6 ≤ circleNorm (y + 1 / 2)
    · exact Or.inl ⟨hxhalf, hyhalf⟩
    · right
      have hybad : circleNorm (y + 1 / 2) < (1 : ℝ) / 6 := lt_of_not_ge hyhalf
      have hxfold := circleNorm_double_half_gt_of_small x hxbad
      have hyfold := circleNorm_double_half_gt_of_small (y + 1 / 2) hybad
      have hphase : 2 * (y + 1 / 2) + 1 / 2 =
          (1 : ℤ) + (2 * y + 1 / 2) := by ring
      rw [hphase, circleNorm_add_int] at hyfold
      exact ⟨hxfold.le, hyfold.le⟩

end LonelyRunner
