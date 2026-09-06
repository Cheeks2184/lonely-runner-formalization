import LonelyRunner.AnchoredPairTransport
import LonelyRunner.FoldedPairSafeBands
import LonelyRunner.TwoDivisibleFoldedBand

/-!
# Safe folded bands from an anchored pair bound

The supplied fiber bound transfers to the triple and quintuple times. Their
strict improvement of the smaller norm forces the two scalar constraints.
No existence or positivity of a maximizing seed is asserted here.
-/

namespace LonelyRunner

theorem foldedPairSafeBands_of_five_sixths_pair_bound
    (a b c : ℕ) (ha : 3 ∣ a) (hb : 3 ∣ b) (hc : ¬ 3 ∣ c)
    (t : ℝ) (ht : Int.fract (t * (c : ℝ)) = (5 : ℝ) / 6)
    (hpositive : 0 < circleNorm (t * (a : ℝ)))
    (hsmall : circleNorm (t * (a : ℝ)) < (1 : ℝ) / 6)
    (horder : circleNorm (t * (a : ℝ)) ≤ circleNorm (t * (b : ℝ)))
    (hmax : ∀ s : ℝ, Int.fract (s * (c : ℝ)) = (5 : ℝ) / 6 →
      min (circleNorm (s * (a : ℝ))) (circleNorm (s * (b : ℝ))) ≤
        circleNorm (t * (a : ℝ))) :
    FoldedPairSafeBands (circleNorm (t * (a : ℝ)))
      (circleNorm (t * (b : ℝ))) := by
  have hphase3 : Int.fract ((3 * t) * (c : ℝ)) = (1 : ℝ) / 2 := by
    calc
      _ = Int.fract ((3 : ℝ) * Int.fract (t * (c : ℝ))) := by
        rw [show (3 * t) * (c : ℝ) = (3 : ℤ) * (t * (c : ℝ)) by push_cast; ring]
        exact fract_int_dilate_eq 3 _
      _ = Int.fract ((15 : ℕ) / (6 : ℕ) : ℝ) := by rw [ht]; congr 1; norm_num
      _ = _ := by rw [Int.fract_div_natCast_eq_div_natCast_mod]; norm_num
  have hphase5 : Int.fract ((5 * t) * (c : ℝ)) = (1 : ℝ) / 6 := by
    calc
      _ = Int.fract ((5 : ℝ) * Int.fract (t * (c : ℝ))) := by
        rw [show (5 * t) * (c : ℝ) = (5 : ℤ) * (t * (c : ℝ)) by push_cast; ring]
        exact fract_int_dilate_eq 5 _
      _ = Int.fract ((25 : ℕ) / (6 : ℕ) : ℝ) := by rw [ht]; congr 1; norm_num
      _ = _ := by rw [Int.fract_div_natCast_eq_div_natCast_mod]; norm_num
  have hbound3 := pair_min_le_of_special_sixth_fiber_bound a b c ha hb hc
    (circleNorm (t * (a : ℝ))) hmax (3 * t) (Or.inr (Or.inl hphase3))
  have hbound5 := pair_min_le_of_special_sixth_fiber_bound a b c ha hb hc
    (circleNorm (t * (a : ℝ))) hmax (5 * t) (Or.inl hphase5)
  have hfold (n d : ℕ) : circleNorm (((n : ℝ) * t) * (d : ℝ)) =
      circleNorm ((n : ℝ) * circleNorm (t * (d : ℝ))) := by
    simpa only [Int.cast_zero, zero_div, add_zero, mul_assoc] using
      circleNorm_nat_mul_add_int_half (t * (d : ℝ)) n 0
  have h3a := hfold 3 a
  have h3b := hfold 3 b
  have h5a := hfold 5 a
  have h5b := hfold 5 b
  norm_num only [Nat.cast_ofNat] at h3a h3b h5a h5b
  rw [h3a, h3b] at hbound3
  rw [h5a, h5b] at hbound5
  have himprove := small_folded_three_five_improve _ hpositive hsmall
  have h3 : circleNorm (3 * circleNorm (t * (b : ℝ))) ≤
      circleNorm (t * (a : ℝ)) := by
    rcases min_le_iff.mp hbound3 with h | h
    · exact False.elim (not_le_of_gt himprove.1 h)
    · exact h
  have h5 : circleNorm (5 * circleNorm (t * (b : ℝ))) ≤
      circleNorm (t * (a : ℝ)) := by
    rcases min_le_iff.mp hbound5 with h | h
    · exact False.elim (not_le_of_gt himprove.2 h)
    · exact h
  have hhalf : circleNorm (t * (b : ℝ)) ≤ (1 : ℝ) / 2 := by
    rw [circleNorm_eq_abs_sub_round]
    exact abs_sub_round _
  obtain ⟨ha8, hb0, hb1⟩ := two_divisible_folded_band _ _
    hpositive hsmall horder hhalf h3 h5
  exact foldedPairSafeBands_of_bounds _ _ ha8 hsmall hb0 hb1

end LonelyRunner
