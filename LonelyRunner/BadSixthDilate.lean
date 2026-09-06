import LonelyRunner.FoldedCirclePhase
import Mathlib.Tactic

namespace LonelyRunner

private theorem circleNorm_lt_sixth_of_integer_band (q : ℤ) (y : ℝ)
    (hlo : (q : ℝ) + (5 : ℝ) / 6 < y)
    (hhi : y < (q : ℝ) + (7 : ℝ) / 6) :
    circleNorm y < (1 : ℝ) / 6 := by
  have hphase : y = ((q + 1 : ℤ) : ℝ) + (y - ((q + 1 : ℤ) : ℝ)) := by
    push_cast
    ring
  rw [hphase, circleNorm_add_int, circleNorm_eq_abs_of_abs_le_half] <;> push_cast
  · rw [abs_lt]
    constructor <;> linarith
  · rw [abs_le]
    constructor <;> linarith

/-- Any phase strictly farther than a sixth has one of the bounded natural
dilates two through five strictly closer than a sixth. -/
theorem exists_bad_sixth_dilate (x : ℝ) (hx : (1 : ℝ) / 6 < circleNorm x) :
    ∃ a : ℕ, 2 ≤ a ∧ a ≤ 5 ∧ circleNorm ((a : ℝ) * x) < (1 : ℝ) / 6 := by
  let u := circleNorm x
  have hu0 : 0 ≤ u := by
    dsimp [u]
    rw [circleNorm_eq_abs_sub_round]
    exact abs_nonneg _
  have huhalf : u ≤ (1 : ℝ) / 2 := by
    dsimp [u]
    rw [circleNorm_eq_abs_sub_round]
    exact abs_sub_round _
  have hfold (a : ℕ) : circleNorm ((a : ℝ) * x) = circleNorm ((a : ℝ) * u) := by
    dsimp [u]
    simpa only [Int.cast_zero, zero_div, add_zero] using
      circleNorm_nat_mul_add_int_half x a 0
  by_cases h1 : u < (7 : ℝ) / 30
  · refine ⟨5, by omega, by omega, ?_⟩
    rw [hfold]
    apply circleNorm_lt_sixth_of_integer_band 0
    · dsimp [u] at hx ⊢
      linarith
    · linarith
  by_cases h2 : u < (7 : ℝ) / 24
  · refine ⟨4, by omega, by omega, ?_⟩
    rw [hfold]
    apply circleNorm_lt_sixth_of_integer_band 0 <;> linarith
  by_cases h3 : u < (7 : ℝ) / 18
  · refine ⟨3, by omega, by omega, ?_⟩
    rw [hfold]
    apply circleNorm_lt_sixth_of_integer_band 0 <;> linarith
  by_cases h4 : u < (13 : ℝ) / 30
  · refine ⟨5, by omega, by omega, ?_⟩
    rw [hfold]
    apply circleNorm_lt_sixth_of_integer_band 1 <;> linarith
  · refine ⟨2, by omega, by omega, ?_⟩
    rw [hfold]
    apply circleNorm_lt_sixth_of_integer_band 0 <;> linarith

end LonelyRunner
