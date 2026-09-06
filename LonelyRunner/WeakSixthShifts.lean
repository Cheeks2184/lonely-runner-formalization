import LonelyRunner.NonzeroThirdShift
import LonelyRunner.ThirdShiftExceptions
import LonelyRunner.FoldedCirclePhase
import Mathlib.Tactic

/-!
# Weak sixth-shift choices

Checked nonzero and common third shifts, together with the half-turn identity,
produce one common sixth-shift choice at the closed sixth margin.
-/

namespace LonelyRunner

theorem sixth_shift_weak_even (x y z : ℝ)
    (hx : circleNorm x ≤ (1 : ℝ) / 6) :
    ∃ b : ℕ, (b = 1 ∨ b = 2 ∨ b = 4 ∨ b = 5) ∧
      (1 : ℝ) / 6 ≤ circleNorm (x + 2 * (b : ℝ) / 6) ∧
      (1 : ℝ) / 6 ≤ circleNorm (y + 2 * (b : ℝ) / 6) ∧
      (1 : ℝ) / 6 ≤ circleNorm (z + (b : ℝ) / 6) := by
  obtain ⟨k, hk, hy⟩ := exists_nonzero_third_shift_safe y 1 (by norm_num)
  have hxk := third_shift_safe_of_weak_bad x 1 (by norm_num) hx k hk
  have hkval : k.val = 1 ∨ k.val = 2 := by
    fin_cases k <;> simp_all
  by_cases hz : (1 : ℝ) / 6 ≤ circleNorm (z + (k.val : ℝ) / 6)
  · refine ⟨k.val, ?_, ?_, ?_, hz⟩
    · rcases hkval with h | h
      · exact Or.inl h
      · exact Or.inr (Or.inl h)
    · convert hxk using 1 <;> ring
    · convert hy using 1 <;> ring
  · refine ⟨k.val + 3, ?_, ?_, ?_, ?_⟩
    · rcases hkval with h | h
      · exact Or.inr (Or.inr (Or.inl (by omega)))
      · exact Or.inr (Or.inr (Or.inr (by omega)))
    · have hphase : x + 2 * ((k.val + 3 : ℕ) : ℝ) / 6 =
          (1 : ℤ) + (x + (k.val : ℝ) / 3) := by
        push_cast
        ring
      rw [hphase, circleNorm_add_int]
      simpa using hxk
    · have hphase : y + 2 * ((k.val + 3 : ℕ) : ℝ) / 6 =
          (1 : ℤ) + (y + (k.val : ℝ) / 3) := by
        push_cast
        ring
      rw [hphase, circleNorm_add_int]
      simpa using hy
    · have hzbad : circleNorm (z + (k.val : ℝ) / 6) < (1 : ℝ) / 6 :=
        lt_of_not_ge hz
      have hphase : z + ((k.val + 3 : ℕ) : ℝ) / 6 =
          (z + (k.val : ℝ) / 6) + (1 : ℝ) / 2 := by
        push_cast
        ring
      rw [hphase, circleNorm_add_half]
      linarith

theorem sixth_shift_weak_odd (x y z : ℝ)
    (hz : circleNorm z ≤ (1 : ℝ) / 6) :
    ∃ b : ℕ, 1 ≤ b ∧ b ≤ 5 ∧
      (1 : ℝ) / 6 ≤ circleNorm (x + 2 * (b : ℝ) / 6) ∧
      (1 : ℝ) / 6 ≤ circleNorm (y + 2 * (b : ℝ) / 6) ∧
      (1 : ℝ) / 6 ≤ circleNorm (z + (b : ℝ) / 6) := by
  let phases : Fin 2 → ℝ := ![x, y]
  let speeds : Fin 2 → ℕ := fun _ => 1
  obtain ⟨k, hsafe⟩ := exists_third_shift_safe_nondivisible_family phases speeds
    (by intro i; norm_num) (by decide)
  fin_cases k
  · have hxsafe : (1 : ℝ) / 6 ≤ circleNorm x := by
      simpa [phases, speeds] using hsafe 0
    have hysafe : (1 : ℝ) / 6 ≤ circleNorm y := by
      simpa [phases, speeds] using hsafe 1
    refine ⟨3, by omega, by omega, ?_, ?_, ?_⟩
    · have hphase : x + 2 * ((3 : ℕ) : ℝ) / 6 = (1 : ℤ) + x := by norm_num; push_cast; ring
      rw [hphase, circleNorm_add_int]
      exact hxsafe
    · have hphase : y + 2 * ((3 : ℕ) : ℝ) / 6 = (1 : ℤ) + y := by norm_num; push_cast; ring
      rw [hphase, circleNorm_add_int]
      exact hysafe
    · rw [show z + ((3 : ℕ) : ℝ) / 6 = z + (1 : ℝ) / 2 by norm_num, circleNorm_add_half]
      linarith
  · have hxsafe : (1 : ℝ) / 6 ≤ circleNorm (x + (1 : ℝ) / 3) := by
      simpa [phases, speeds] using hsafe 0
    have hysafe : (1 : ℝ) / 6 ≤ circleNorm (y + (1 : ℝ) / 3) := by
      simpa [phases, speeds] using hsafe 1
    have hzs := third_shift_safe_of_weak_bad z 1 (by norm_num) hz (2 : Fin 3) (by decide)
    refine ⟨4, by omega, by omega, ?_, ?_, ?_⟩
    · have hphase : x + 2 * ((4 : ℕ) : ℝ) / 6 = (1 : ℤ) + (x + (1 : ℝ) / 3) := by norm_num; push_cast; ring
      rw [hphase, circleNorm_add_int]
      exact hxsafe
    · have hphase : y + 2 * ((4 : ℕ) : ℝ) / 6 = (1 : ℤ) + (y + (1 : ℝ) / 3) := by norm_num; push_cast; ring
      rw [hphase, circleNorm_add_int]
      exact hysafe
    · convert hzs using 1 <;> norm_num
  · have hxsafe : (1 : ℝ) / 6 ≤ circleNorm (x + (2 : ℝ) / 3) := by
      simpa [phases, speeds] using hsafe 0
    have hysafe : (1 : ℝ) / 6 ≤ circleNorm (y + (2 : ℝ) / 3) := by
      simpa [phases, speeds] using hsafe 1
    have hzs := third_shift_safe_of_weak_bad z 1 (by norm_num) hz (1 : Fin 3) (by decide)
    refine ⟨2, by omega, by omega, ?_, ?_, ?_⟩
    · convert hxsafe using 1 <;> norm_num
    · convert hysafe using 1 <;> norm_num
    · convert hzs using 1 <;> norm_num

end LonelyRunner
