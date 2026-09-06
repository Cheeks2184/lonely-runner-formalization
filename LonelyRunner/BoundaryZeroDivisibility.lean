import LonelyRunner.SmallDenominatorWitness
import LonelyRunner.StructuredClasses
import Mathlib.Tactic

namespace LonelyRunner

/-- A zero circle norm at a natural rational phase forces divisibility by its
positive denominator. -/
theorem dvd_of_circleNorm_nat_div_eq_zero (M a : ℕ) (hM : 0 < M)
    (hz : circleNorm ((a : ℝ) / (M : ℝ)) = 0) : M ∣ a := by
  by_contra hnot
  have hres := one_le_cyclicResidueDistance_of_not_dvd hM hnot
  have hnorm := circleNorm_nat_div_ge hM hres
  rw [hz] at hnorm
  have hpos : 0 < (1 : ℝ) / (M : ℝ) := by positivity
  linarith

/-- If every phase with the five-sixths anchor has one of two norms zero,
one speed is divisible by the full natural denominator. -/
theorem dvd_or_dvd_of_five_sixths_pair_zero (a b c : ℕ) (hc : 0 < c)
    (hzero : ∀ t : ℝ, Int.fract (t * (c : ℝ)) = (5 : ℝ) / 6 →
      min (circleNorm (t * (a : ℝ))) (circleNorm (t * (b : ℝ))) = 0) :
    6 * c ∣ a ∨ 6 * c ∣ b := by
  let t : ℝ := -1 / ((6 * c : ℕ) : ℝ)
  have hcR : (0 : ℝ) < (c : ℝ) := by exact_mod_cast hc
  have hanchor : Int.fract (t * (c : ℝ)) = (5 : ℝ) / 6 := by
    dsimp [t]
    have hphase : (-1 / ((6 * c : ℕ) : ℝ)) * (c : ℝ) =
        (-1 : ℤ) + (5 : ℝ) / 6 := by
      push_cast
      field_simp
      ring
    rw [hphase, Int.fract_intCast_add]
    norm_num
  have hmin := hzero t hanchor
  rcases le_total (circleNorm (t * (a : ℝ))) (circleNorm (t * (b : ℝ))) with hab | hba
  · left
    have ha0 : circleNorm (t * (a : ℝ)) = 0 := by
      rw [← min_eq_left hab, hmin]
    apply dvd_of_circleNorm_nat_div_eq_zero (6 * c) a (by omega)
    have hphase : t * (a : ℝ) = -((a : ℝ) / ((6 * c : ℕ) : ℝ)) := by
      dsimp [t]
      ring
    rw [hphase, circleNorm_neg] at ha0
    exact ha0
  · right
    have hb0 : circleNorm (t * (b : ℝ)) = 0 := by
      rw [← min_eq_right hba, hmin]
    apply dvd_of_circleNorm_nat_div_eq_zero (6 * c) b (by omega)
    have hphase : t * (b : ℝ) = -((b : ℝ) / ((6 * c : ℕ) : ℝ)) := by
      dsimp [t]
      ring
    rw [hphase, circleNorm_neg] at hb0
    exact hb0

end LonelyRunner
