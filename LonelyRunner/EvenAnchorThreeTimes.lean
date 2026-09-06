import LonelyRunner.TwoOddOutsideThree
import LonelyRunner.OddHalfTimeShift
import LonelyRunner.TwoPhaseHalfChoices
import LonelyRunner.AnchoredPairTransport
import LonelyRunner.RationalShiftOrbits

/-!
# Three common times for a both-six, even-anchor configuration

The three prescribed labels are even, while the finite complement consists of
two odd labels.  A single two-phase choice controls that complement.
-/

namespace LonelyRunner

private abbrev AllSafe (v : Fin 5 → ℕ) (s : ℝ) : Prop :=
  ∀ i, (1 : ℝ) / 6 ≤ circleNorm (s * (v i : ℝ))

theorem both_six_even_anchor_three_time_witness
    (v : Fin 5 → ℕ) (p q r : Fin 5)
    (hpq : p ≠ q) (hrp : r ≠ p) (hrq : r ≠ q)
    (hp : 6 ∣ v p) (hq : 6 ∣ v q) (hr : 2 ∣ v r)
    (heven : ((Finset.univ : Finset (Fin 5)).filter (fun i => 2 ∣ v i)).card ≤ 3)
    (τ : ℝ) (ht : Int.fract (τ * (v r : ℝ)) = (5 : ℝ) / 6)
    (H : FoldedPairSafeBands (circleNorm (τ * (v p : ℝ)))
      (circleNorm (τ * (v q : ℝ)))) :
    AllSafe v (2 * τ) ∨ AllSafe v (2 * τ + 1 / 2) ∨
      AllSafe v (4 * τ + 1 / 2) := by
  obtain ⟨u, w, huw, huodd, hwodd, hlabels⟩ := exists_two_odd_outside_three
    v p q r hpq hrp hrq (dvd_trans (by norm_num : 2 ∣ 6) hp)
    (dvd_trans (by norm_num : 2 ∣ 6) hq) hr heven
  have hfold (n d : ℕ) : circleNorm (((n : ℝ) * τ) * (d : ℝ)) =
      circleNorm ((n : ℝ) * circleNorm (τ * (d : ℝ))) := by
    simpa only [Int.cast_zero, zero_div, add_zero, mul_assoc] using
      circleNorm_nat_mul_add_int_half (τ * (d : ℝ)) n 0
  have hp2 : (1 : ℝ) / 6 ≤ circleNorm ((2 * τ) * (v p : ℝ)) := by
    rw [show (2 * τ) * (v p : ℝ) = ((2 : ℕ) : ℝ) * τ * (v p : ℝ) by norm_num]
    rw [hfold 2 (v p)]
    norm_num
    exact H.left_two
  have hq2 : (1 : ℝ) / 6 ≤ circleNorm ((2 * τ) * (v q : ℝ)) := by
    rw [show (2 * τ) * (v q : ℝ) = ((2 : ℕ) : ℝ) * τ * (v q : ℝ) by norm_num]
    rw [hfold 2 (v q)]
    norm_num
    exact H.right_two
  have hp4 : (1 : ℝ) / 6 ≤ circleNorm ((4 * τ) * (v p : ℝ)) := by
    rw [show (4 * τ) * (v p : ℝ) = ((4 : ℕ) : ℝ) * τ * (v p : ℝ) by norm_num]
    rw [hfold 4 (v p)]
    norm_num
    exact H.left_four
  have hq4 : (1 : ℝ) / 6 ≤ circleNorm ((4 * τ) * (v q : ℝ)) := by
    rw [show (4 * τ) * (v q : ℝ) = ((4 : ℕ) : ℝ) * τ * (v q : ℝ) by norm_num]
    rw [hfold 4 (v q)]
    norm_num
    exact H.right_four
  have hr2fract : Int.fract ((2 * τ) * (v r : ℝ)) = (2 : ℝ) / 3 := by
    calc
      _ = Int.fract ((2 : ℤ) * (τ * (v r : ℝ))) := by congr 1; push_cast; ring
      _ = Int.fract ((2 : ℝ) * Int.fract (τ * (v r : ℝ))) := fract_int_dilate_eq 2 _
      _ = Int.fract (((10 : ℕ) : ℝ) / ((6 : ℕ) : ℝ)) := by rw [ht]; norm_num
      _ = _ := by rw [Int.fract_div_natCast_eq_div_natCast_mod]; norm_num
  have hr4fract : Int.fract ((4 * τ) * (v r : ℝ)) = (1 : ℝ) / 3 := by
    calc
      _ = Int.fract ((4 : ℤ) * (τ * (v r : ℝ))) := by congr 1; push_cast; ring
      _ = Int.fract ((4 : ℝ) * Int.fract (τ * (v r : ℝ))) := fract_int_dilate_eq 4 _
      _ = Int.fract (((20 : ℕ) : ℝ) / ((6 : ℕ) : ℝ)) := by rw [ht]; norm_num
      _ = _ := by rw [Int.fract_div_natCast_eq_div_natCast_mod]; norm_num
  have safe_of_fract (x : ℝ) (h : Int.fract x = (1 : ℝ) / 3 ∨
      Int.fract x = (2 : ℝ) / 3) : (1 : ℝ) / 6 ≤ circleNorm x := by
    rw [circleNorm_eq_min_fract]
    rcases h with h | h <;> rw [h] <;> norm_num
  have hr2 := safe_of_fract _ (Or.inr hr2fract)
  have hr4 := safe_of_fract _ (Or.inl hr4fract)
  have hp2half := circleNorm_time_add_nat_div_of_dvd 2 (v p) 1 (by norm_num)
    (dvd_trans (by norm_num : 2 ∣ 6) hp) (2 * τ)
  have hq2half := circleNorm_time_add_nat_div_of_dvd 2 (v q) 1 (by norm_num)
    (dvd_trans (by norm_num : 2 ∣ 6) hq) (2 * τ)
  have hr2half := circleNorm_time_add_nat_div_of_dvd 2 (v r) 1 (by norm_num) hr (2 * τ)
  have hp4half := circleNorm_time_add_nat_div_of_dvd 2 (v p) 1 (by norm_num)
    (dvd_trans (by norm_num : 2 ∣ 6) hp) (4 * τ)
  have hq4half := circleNorm_time_add_nat_div_of_dvd 2 (v q) 1 (by norm_num)
    (dvd_trans (by norm_num : 2 ∣ 6) hq) (4 * τ)
  have hr4half := circleNorm_time_add_nat_div_of_dvd 2 (v r) 1 (by norm_num) hr (4 * τ)
  norm_num only [Nat.cast_ofNat] at hp2half hq2half hr2half hp4half hq4half hr4half
  let x := (2 * τ) * (v u : ℝ)
  let y := (2 * τ) * (v w : ℝ)
  rcases two_phase_half_choices x y with hxy | hxy | hxy
  · left
    intro i
    rcases hlabels i with rfl | rfl | rfl | rfl | rfl
    · exact hp2
    · exact hq2
    · exact hr2
    · simpa [x] using hxy.1
    · simpa [y] using hxy.2
  · right; left
    intro i
    rcases hlabels i with rfl | rfl | rfl | rfl | rfl
    · rw [hp2half]; exact hp2
    · rw [hq2half]; exact hq2
    · rw [hr2half]; exact hr2
    · rw [circleNorm_time_add_half_of_not_dvd_two (2 * τ) (v i) huodd]
      simpa [x] using hxy.1
    · rw [circleNorm_time_add_half_of_not_dvd_two (2 * τ) (v i) hwodd]
      simpa [y] using hxy.2
  · right; right
    intro i
    rcases hlabels i with rfl | rfl | rfl | rfl | rfl
    · rw [hp4half]; exact hp4
    · rw [hq4half]; exact hq4
    · rw [hr4half]; exact hr4
    · rw [circleNorm_time_add_half_of_not_dvd_two (4 * τ) (v i) huodd]
      rw [show (4 * τ) * (v i : ℝ) + 1 / 2 =
        2 * ((2 * τ) * (v i : ℝ)) + 1 / 2 by ring]
      exact hxy.1
    · rw [circleNorm_time_add_half_of_not_dvd_two (4 * τ) (v i) hwodd]
      rw [show (4 * τ) * (v i : ℝ) + 1 / 2 =
        2 * ((2 * τ) * (v i : ℝ)) + 1 / 2 by ring]
      exact hxy.2

end LonelyRunner
