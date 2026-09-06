import LonelyRunner.DivisorInsertion
import LonelyRunner.PivotResidues
import Mathlib.Tactic

namespace LonelyRunner

def FiveRunnerMixed (a b c H : ℕ) : Prop :=
  ∃ t : ℝ, 0 < t ∧
    ((5 : ℝ)⁻¹) ≤ circleNorm (t * (a : ℝ)) ∧
    ((5 : ℝ)⁻¹) ≤ circleNorm (t * (b : ℝ)) ∧
    ((5 : ℝ)⁻¹) ≤ circleNorm (t * (c : ℝ)) ∧
    ((4 : ℝ)⁻¹) ≤ circleNorm (t * (H : ℝ))

private theorem circleNorm_neg' (x : ℝ) : circleNorm (-x) = circleNorm x := by
  unfold circleNorm
  rw [AddCircle.coe_neg, norm_neg]

private theorem fifth_at_one : (1 : ℝ) / 5 ≤ circleNorm ((1 : ℝ) / 5) := by
  rw [circleNorm_eq_abs_of_abs_le_half] <;> norm_num

private theorem fifth_at_two : (1 : ℝ) / 5 ≤ circleNorm ((2 : ℝ) / 5) := by
  rw [circleNorm_eq_abs_of_abs_le_half] <;> norm_num

private theorem fifth_at_three : (1 : ℝ) / 5 ≤ circleNorm ((3 : ℝ) / 5) := by
  have h : (3 : ℝ) / 5 = ((1 : ℤ) : ℝ) + (-(2 : ℝ) / 5) := by norm_num
  rw [h, circleNorm_add_int]
  have hn : (-(2 : ℝ) / 5) = -((2 : ℝ) / 5) := by ring
  rw [hn, circleNorm_neg']
  exact fifth_at_two

private theorem fifth_at_four : (1 : ℝ) / 5 ≤ circleNorm ((4 : ℝ) / 5) := by
  have h : (4 : ℝ) / 5 = ((1 : ℤ) : ℝ) + (-(1 : ℝ) / 5) := by norm_num
  rw [h, circleNorm_add_int]
  have hn : (-(1 : ℝ) / 5) = -((1 : ℝ) / 5) := by ring
  rw [hn, circleNorm_neg']
  exact fifth_at_one

private theorem quarter_at_one : (4 : ℝ)⁻¹ ≤ circleNorm ((1 : ℝ) / 4) := by
  rw [circleNorm_eq_abs_of_abs_le_half] <;> norm_num

private theorem lower_at_one_fifth :
    (1 : ℝ) / 5 ≤ circleNorm ((1 : ℝ) / 5 * (1 : ℝ)) ∧
    (1 : ℝ) / 5 ≤ circleNorm ((1 : ℝ) / 5 * (2 : ℝ)) ∧
    (1 : ℝ) / 5 ≤ circleNorm ((1 : ℝ) / 5 * (3 : ℝ)) := by
  norm_num
  refine ⟨?_, ?_, ?_⟩ <;> first | exact fifth_at_one | exact fifth_at_two | exact fifth_at_three

private theorem lower_at_two_fifths :
    (1 : ℝ) / 5 ≤ circleNorm ((2 : ℝ) / 5 * (1 : ℝ)) ∧
    (1 : ℝ) / 5 ≤ circleNorm ((2 : ℝ) / 5 * (2 : ℝ)) ∧
    (1 : ℝ) / 5 ≤ circleNorm ((2 : ℝ) / 5 * (3 : ℝ)) := by
  norm_num
  refine ⟨fifth_at_two, fifth_at_four, ?_⟩
  have h : (6 : ℝ) / 5 = ((1 : ℤ) : ℝ) + (1 : ℝ) / 5 := by norm_num
  rw [h, circleNorm_add_int]
  exact fifth_at_one

private theorem lower_at_quarter :
    (1 : ℝ) / 5 ≤ circleNorm ((1 : ℝ) / 4 * (1 : ℝ)) ∧
    (1 : ℝ) / 5 ≤ circleNorm ((1 : ℝ) / 4 * (2 : ℝ)) ∧
    (1 : ℝ) / 5 ≤ circleNorm ((1 : ℝ) / 4 * (3 : ℝ)) := by
  norm_num
  refine ⟨(by norm_num : (1 : ℝ) / 5 ≤ (4 : ℝ)⁻¹).trans quarter_at_one, ?_, ?_⟩
  · rw [circleNorm_eq_abs_of_abs_le_half] <;> norm_num
  · have h : (3 : ℝ) / 4 = ((1 : ℤ) : ℝ) + (-(1 : ℝ) / 4) := by norm_num
    rw [h, circleNorm_add_int]
    have hn : (-(1 : ℝ) / 4) = -((1 : ℝ) / 4) := by ring
    rw [hn, circleNorm_neg']
    exact (by norm_num : (1 : ℝ) / 5 ≤ (4 : ℝ)⁻¹).trans quarter_at_one

/-- The normalized `(1,2,3,K)` family has a five-runner mixed witness. -/
theorem fiveRunnerMixed_one_two_three (K : ℕ) (hK : 3 < K) :
    FiveRunnerMixed 1 2 3 K := by
  by_cases h4 : 4 ∣ K
  · by_cases h5 : 5 ∣ K
    · have h20 : 20 ∣ K := by
        have hcop : Nat.Coprime 4 5 := by norm_num
        simpa using hcop.mul_dvd_of_dvd_of_dvd h4 h5
      obtain ⟨d, rfl⟩ := h20
      have hd : 0 < d := by omega
      have hdOne : (1 : ℝ) ≤ (d : ℝ) := by
        exact_mod_cast (show 1 ≤ d from hd)
      let t : ℝ := (1 : ℝ) / 4 + 1 / (4 * (20 * d : ℕ))
      have htform : t = (1 : ℝ) / 4 + 1 / (80 * (d : ℝ)) := by
        dsimp [t]
        push_cast
        ring
      have hfrac : 1 / (80 * (d : ℝ)) ≤ (1 : ℝ) / 80 := by
        apply one_div_le_one_div_of_le (by norm_num : (0 : ℝ) < 80)
        nlinarith
      have hfrac0 : 0 ≤ 1 / (80 * (d : ℝ)) := by positivity
      refine ⟨t, by positivity, ?_, ?_, ?_, ?_⟩
      · rw [inv_eq_one_div]
        apply circleNorm_ge_of_int_band 0 (t * ((1 : ℕ) : ℝ)) ((1 : ℝ) / 5)
          (by norm_num) (by norm_num)
        · rw [htform]
          nlinarith [hfrac, hfrac0]
        · rw [htform]
          nlinarith [hfrac, hfrac0]
      · rw [inv_eq_one_div]
        apply circleNorm_ge_of_int_band 0 (t * (2 : ℝ)) ((1 : ℝ) / 5)
          (by norm_num) (by norm_num)
        · rw [htform]
          nlinarith [hfrac, hfrac0]
        · rw [htform]
          nlinarith [hfrac, hfrac0]
      · rw [inv_eq_one_div]
        apply circleNorm_ge_of_int_band 0 (t * (3 : ℝ)) ((1 : ℝ) / 5)
          (by norm_num) (by norm_num)
        · rw [htform]
          nlinarith [hfrac, hfrac0]
        · rw [htform]
          nlinarith [hfrac, hfrac0]
      · have hphase : t * ((20 * d : ℕ) : ℝ) =
            ((5 * d : ℤ) : ℝ) + (1 : ℝ) / 4 := by
            dsimp [t]
            push_cast
            field_simp
            ring
        rw [hphase, circleNorm_add_int]
        exact quarter_at_one
    · have hmod : K % 5 ≠ 0 := by
        intro hz
        exact h5 (Nat.dvd_iff_mod_eq_zero.mpr hz)
      have hlt : K % 5 < 5 := Nat.mod_lt _ (by omega)
      interval_cases h : K % 5
      · exact (hmod rfl).elim
      · refine ⟨(2 : ℝ) / 5, by norm_num, ?_, ?_, ?_, ?_⟩
        · norm_num; convert lower_at_two_fifths.1 using 1 <;> ring
        · norm_num; convert lower_at_two_fifths.2.1 using 1 <;> ring
        · norm_num; convert lower_at_two_fifths.2.2 using 1 <;> ring
        · have hcyc : 2 ≤ cyclicResidueDistance 5 (2 * K) := by
            norm_num [cyclicResidueDistance, Nat.mul_mod, h]
          have hf := circleNorm_nat_div_ge (M := 5) (x := 2 * K) (b := 2)
            (by omega) hcyc
          rw [inv_eq_one_div]
          refine (by norm_num : (1 : ℝ) / 4 ≤ 2 / 5).trans ?_
          have hphase : (2 : ℝ) / 5 * (K : ℝ) = ((2 * K : ℕ) : ℝ) / 5 := by
            push_cast; ring
          rw [hphase]
          simpa using hf
      · refine ⟨(1 : ℝ) / 5, by norm_num, ?_, ?_, ?_, ?_⟩
        · norm_num; convert lower_at_one_fifth.1 using 1 <;> ring
        · norm_num; convert lower_at_one_fifth.2.1 using 1 <;> ring
        · norm_num; convert lower_at_one_fifth.2.2 using 1 <;> ring
        · have hcyc : 2 ≤ cyclicResidueDistance 5 K := by
            norm_num [cyclicResidueDistance, h]
          have hf := circleNorm_nat_div_ge (M := 5) (x := K) (b := 2)
            (by omega) hcyc
          rw [inv_eq_one_div]
          refine (by norm_num : (1 : ℝ) / 4 ≤ 2 / 5).trans ?_
          have hphase : (1 : ℝ) / 5 * (K : ℝ) = (K : ℝ) / 5 := by ring
          rw [hphase]
          simpa using hf
      · refine ⟨(1 : ℝ) / 5, by norm_num, ?_, ?_, ?_, ?_⟩
        · norm_num; convert lower_at_one_fifth.1 using 1 <;> ring
        · norm_num; convert lower_at_one_fifth.2.1 using 1 <;> ring
        · norm_num; convert lower_at_one_fifth.2.2 using 1 <;> ring
        · have hcyc : 2 ≤ cyclicResidueDistance 5 K := by
            norm_num [cyclicResidueDistance, h]
          have hf := circleNorm_nat_div_ge (M := 5) (x := K) (b := 2)
            (by omega) hcyc
          rw [inv_eq_one_div]
          refine (by norm_num : (1 : ℝ) / 4 ≤ 2 / 5).trans ?_
          have hphase : (1 : ℝ) / 5 * (K : ℝ) = (K : ℝ) / 5 := by ring
          rw [hphase]
          simpa using hf
      · refine ⟨(2 : ℝ) / 5, by norm_num, ?_, ?_, ?_, ?_⟩
        · norm_num; convert lower_at_two_fifths.1 using 1 <;> ring
        · norm_num; convert lower_at_two_fifths.2.1 using 1 <;> ring
        · norm_num; convert lower_at_two_fifths.2.2 using 1 <;> ring
        · have hcyc : 2 ≤ cyclicResidueDistance 5 (2 * K) := by
            norm_num [cyclicResidueDistance, Nat.mul_mod, h]
          have hf := circleNorm_nat_div_ge (M := 5) (x := 2 * K) (b := 2)
            (by omega) hcyc
          rw [inv_eq_one_div]
          refine (by norm_num : (1 : ℝ) / 4 ≤ 2 / 5).trans ?_
          have hphase : (2 : ℝ) / 5 * (K : ℝ) = ((2 * K : ℕ) : ℝ) / 5 := by
            push_cast; ring
          rw [hphase]
          simpa using hf
  · refine ⟨(1 : ℝ) / 4, by norm_num, ?_, ?_, ?_, ?_⟩
    · norm_num
      convert lower_at_quarter.1 using 1 <;> ring
    · norm_num
      convert lower_at_quarter.2.1 using 1 <;> ring
    · norm_num
      convert lower_at_quarter.2.2 using 1 <;> ring
    · have hmod : K % 4 ≠ 0 := by
        intro hz
        exact h4 (Nat.dvd_iff_mod_eq_zero.mpr hz)
      have hres : 1 ≤ cyclicResidueDistance 4 K :=
        one_le_cyclicResidueDistance_of_mod_ne_zero (by omega) hmod
      have h := circleNorm_nat_div_ge (M := 4) (x := K) (b := 1) (by omega) hres
      norm_num at h ⊢
      convert h using 1 <;> ring

private theorem circleNorm_normalize_positive_time (s : ℝ) (w : ℕ) :
    circleNorm ((s + 1 - (⌊s⌋ : ℝ)) * (w : ℝ)) =
      circleNorm (s * (w : ℝ)) := by
  have hphase : (s + 1 - (⌊s⌋ : ℝ)) * (w : ℝ) =
      (((1 - ⌊s⌋) * (w : ℤ) : ℤ) : ℝ) + s * (w : ℝ) := by
    push_cast
    ring
  rw [hphase, circleNorm_add_int]

private theorem normalize_fiveRunnerMixed_time {a b c H : ℕ} {s : ℝ}
    (ha : (5 : ℝ)⁻¹ ≤ circleNorm (s * (a : ℝ)))
    (hb : (5 : ℝ)⁻¹ ≤ circleNorm (s * (b : ℝ)))
    (hc : (5 : ℝ)⁻¹ ≤ circleNorm (s * (c : ℝ)))
    (hH : (4 : ℝ)⁻¹ ≤ circleNorm (s * (H : ℝ))) :
    FiveRunnerMixed a b c H := by
  let t : ℝ := s + 1 - (⌊s⌋ : ℝ)
  have ht : 0 < t := by
    dsimp [t]
    have hfloor := Int.floor_le s
    linarith
  refine ⟨t, ht, ?_, ?_, ?_, ?_⟩
  · simpa [t] using (circleNorm_normalize_positive_time s a).symm ▸ ha
  · simpa [t] using (circleNorm_normalize_positive_time s b).symm ▸ hb
  · simpa [t] using (circleNorm_normalize_positive_time s c).symm ▸ hc
  · simpa [t] using (circleNorm_normalize_positive_time s H).symm ▸ hH

private theorem normalized_fiveRunnerMixed_exceptional (A K : ℕ)
    (hA : 0 < A) (hK : 3 * A < K) (hcop : Nat.Coprime A K) :
    FiveRunnerMixed A (2 * A) (3 * A) K := by
  by_cases hAone : A = 1
  · subst A
    simpa using fiveRunnerMixed_one_two_three K (by omega)
  · have hAtwo : 2 ≤ A := by omega
    obtain ⟨k, hk⟩ := exists_int_coprime_grid_circleNorm_ge
      ((K : ℝ) / (4 * (A : ℝ))) K A hA hcop.symm
    let s : ℝ := (4 * (A : ℝ))⁻¹ + (k : ℝ) / (A : ℝ)
    apply normalize_fiveRunnerMixed_time
    · apply circleNorm_ge_of_int_band k (s * (A : ℝ)) ((5 : ℝ)⁻¹)
        (by norm_num) (by norm_num)
      · dsimp [s]
        field_simp
        nlinarith
      · dsimp [s]
        field_simp
        nlinarith
    · apply circleNorm_ge_of_int_band (2 * k) (s * ((2 * A : ℕ) : ℝ)) ((5 : ℝ)⁻¹)
        (by norm_num) (by norm_num)
      · dsimp [s]
        push_cast
        field_simp
        nlinarith
      · dsimp [s]
        push_cast
        field_simp
        nlinarith
    · apply circleNorm_ge_of_int_band (3 * k) (s * ((3 * A : ℕ) : ℝ)) ((5 : ℝ)⁻¹)
        (by norm_num) (by norm_num)
      · dsimp [s]
        push_cast
        field_simp
        nlinarith
      · dsimp [s]
        push_cast
        field_simp
        nlinarith
    · calc
        (4 : ℝ)⁻¹ ≤ ((A : ℝ) - 1) / (2 * (A : ℝ)) := by
          have hAR : 2 ≤ (A : ℝ) := by exact_mod_cast hAtwo
          field_simp
          nlinarith
        _ ≤ circleNorm ((K : ℝ) / (4 * (A : ℝ)) +
            (k : ℝ) * (K : ℝ) / (A : ℝ)) := hk
        _ = circleNorm (s * (K : ℝ)) := by
          congr 1
          dsimp [s]
          field_simp

/-- Every scaled `(1, 2, 3)` lower family has a five-runner mixed witness. -/
theorem fiveRunnerMixed_exceptional (a H : ℕ)
    (ha : 0 < a) (hH : 3 * a < H) :
    FiveRunnerMixed a (2 * a) (3 * a) H := by
  let g : ℕ := Nat.gcd a H
  let A : ℕ := a / g
  let K : ℕ := H / g
  have hg : 0 < g := by
    dsimp [g]
    exact Nat.gcd_pos_of_pos_left H ha
  have hga : g ∣ a := by
    dsimp [g]
    exact Nat.gcd_dvd_left _ _
  have hgH : g ∣ H := by
    dsimp [g]
    exact Nat.gcd_dvd_right _ _
  have haeq : a = g * A := by
    dsimp [A]
    exact (Nat.mul_div_cancel' hga).symm
  have hHeq : H = g * K := by
    dsimp [K]
    exact (Nat.mul_div_cancel' hgH).symm
  have hA : 0 < A := by
    dsimp [A]
    exact Nat.div_pos (Nat.le_of_dvd ha hga) hg
  have hK : 3 * A < K := by
    rw [haeq, hHeq] at hH
    apply (Nat.mul_lt_mul_left hg).mp
    simpa [Nat.mul_assoc, Nat.mul_left_comm] using hH
  have hcop : Nat.Coprime A K := by
    simpa [A, K, g] using Nat.coprime_div_gcd_div_gcd hg
  obtain ⟨u, hu, huA, huB, huC, huK⟩ :=
    normalized_fiveRunnerMixed_exceptional A K hA hK hcop
  let t : ℝ := u / (g : ℝ)
  have hgR : (g : ℝ) ≠ 0 := by exact_mod_cast hg.ne'
  refine ⟨t, by dsimp [t]; positivity, ?_, ?_, ?_, ?_⟩
  · have hphase : t * (a : ℝ) = u * (A : ℝ) := by
      dsimp [t]
      rw [haeq]
      push_cast
      field_simp
    rw [hphase]
    exact huA
  · have hphase : t * ((2 * a : ℕ) : ℝ) = u * ((2 * A : ℕ) : ℝ) := by
      dsimp [t]
      rw [haeq]
      push_cast
      field_simp
    rw [hphase]
    exact huB
  · have hphase : t * ((3 * a : ℕ) : ℝ) = u * ((3 * A : ℕ) : ℝ) := by
      dsimp [t]
      rw [haeq]
      push_cast
      field_simp
    rw [hphase]
    exact huC
  · have hphase : t * (H : ℝ) = u * (K : ℝ) := by
      dsimp [t]
      rw [hHeq]
      push_cast
      field_simp
    rw [hphase]
    exact huK

end LonelyRunner
