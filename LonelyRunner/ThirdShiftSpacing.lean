import LonelyRunner.SmallDenominatorWitness
import LonelyRunner.StructuredClasses
import Mathlib.Tactic

namespace LonelyRunner

/-- Distinct third-grid shifts of a speed not divisible by three are separated
by at least one third in quotient-circle norm. -/
theorem circleNorm_third_shift_sub_ge (x : ℝ) (d : ℕ)
    (hnot : ¬ 3 ∣ d) (k l : Fin 3) (hkl : k ≠ l) :
    (1 : ℝ) / 3 ≤ circleNorm
      ((x + (k.val : ℝ) * (d : ℝ) / 3) -
        (x + (l.val : ℝ) * (d : ℝ) / 3)) := by
  have ordered : ∀ r s : Fin 3, r.val < s.val →
      (1 : ℝ) / 3 ≤ circleNorm
        ((x + (s.val : ℝ) * (d : ℝ) / 3) -
          (x + (r.val : ℝ) * (d : ℝ) / 3)) := by
    intro r s hrs
    let h := s.val - r.val
    have hhpos : 0 < h := by dsimp [h]; omega
    have hhlt : h < 3 := by dsimp [h]; omega
    have hhnot : ¬ 3 ∣ h := by
      intro hd
      have hle := Nat.le_of_dvd hhpos hd
      omega
    have hprod : ¬ 3 ∣ h * d := by
      intro hd
      exact hnot ((by decide : Nat.Prime 3).dvd_mul.mp hd |>.resolve_left hhnot)
    have hsmall := smallDenominator_circleNorm_ge (N := 3) (q := 3) (a := h * d)
      (by omega) (by omega) (by omega) hprod
    have hphase :
        (x + (s.val : ℝ) * (d : ℝ) / 3) -
          (x + (r.val : ℝ) * (d : ℝ) / 3) = (h * d : ℕ) / (3 : ℝ) := by
      dsimp [h]
      rw [Nat.cast_mul, Nat.cast_sub hrs.le]
      ring
    rw [hphase]
    simpa [one_div] using hsmall
  rcases lt_or_gt_of_ne (Fin.val_ne_of_ne hkl) with hlt | hlt
  · have h := ordered k l hlt
    have hphase :
        (x + (k.val : ℝ) * (d : ℝ) / 3) -
          (x + (l.val : ℝ) * (d : ℝ) / 3) =
          -((x + (l.val : ℝ) * (d : ℝ) / 3) -
            (x + (k.val : ℝ) * (d : ℝ) / 3)) := by ring
    rw [hphase, circleNorm_neg]
    exact h
  · exact ordered l k hlt

end LonelyRunner
