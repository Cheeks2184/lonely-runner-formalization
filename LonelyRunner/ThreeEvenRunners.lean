import LonelyRunner.ThreeEvenOrbit
import LonelyRunner.WeakSixthShifts
import LonelyRunner.OddHalfTimeShift
import LonelyRunner.ThreeWeakExceptions
import LonelyRunner.BadSixthDilate
import LonelyRunner.TwoOddOutsideThree
import LonelyRunner.SmallDenominatorWitness
import Mathlib.Tactic

/-!
# Odd-zero obstruction for the three-even branch

At a zero of either odd phase, a closed-safe multiple-of-six pivot forces the
two even phases past the sixth boundary and the remaining odd phase past the
third boundary.  The statement intentionally has no positivity or distinctness
assumptions: it is a reusable local obstruction for the labelled assembly.
-/

namespace LonelyRunner

/-- The five closed sixth-margin inequalities used by the three-even local
obstruction. -/
abbrev ThreeEvenFiveSafe (A E F U W : ℕ) (t : ℝ) : Prop :=
  (1 : ℝ) / 6 ≤ circleNorm (t * (A : ℝ)) ∧
  (1 : ℝ) / 6 ≤ circleNorm (t * (E : ℝ)) ∧
  (1 : ℝ) / 6 ≤ circleNorm (t * (F : ℝ)) ∧
  (1 : ℝ) / 6 ≤ circleNorm (t * (U : ℝ)) ∧
  (1 : ℝ) / 6 ≤ circleNorm (t * (W : ℝ))

private theorem threeEven_signed_fract_circleNorm (σ : ℤ) (q : ℝ)
    (hσ : σ = 1 ∨ σ = -1) :
    circleNorm ((σ : ℝ) * Int.fract q) = circleNorm q := by
  have hfract : circleNorm q = circleNorm (Int.fract q) := by
    simpa using (threeEven_circleNorm_nat_mul_fract q 1)
  rcases hσ with rfl | rfl
  · simpa using hfract.symm
  · rw [show ((-1 : ℤ) : ℝ) * Int.fract q = -Int.fract q by norm_num,
      circleNorm_neg]
    exact hfract.symm

private theorem threeEven_odd_sixth_safe (σ : ℤ) (b : ℕ)
    (hσ : σ = 1 ∨ σ = -1) (hb1 : 1 ≤ b) (hb5 : b ≤ 5) :
    (1 : ℝ) / 6 ≤ circleNorm ((σ : ℝ) * (b : ℝ) / 6) := by
  rcases hσ with rfl | rfl
  · have hb1R : (1 : ℝ) ≤ (b : ℝ) := by exact_mod_cast hb1
    have hb5R : (b : ℝ) ≤ 5 := by exact_mod_cast hb5
    rw [show ((1 : ℤ) : ℝ) * (b : ℝ) / 6 = (b : ℝ) / 6 by norm_num]
    apply circleNorm_ge_of_int_band 0 ((b : ℝ) / 6) ((1 : ℝ) / 6) <;>
      norm_num <;> linarith
  · rw [show ((-1 : ℤ) : ℝ) * (b : ℝ) / 6 = -((b : ℝ) / 6) by ring,
      circleNorm_neg]
    have hb1R : (1 : ℝ) ≤ (b : ℝ) := by exact_mod_cast hb1
    have hb5R : (b : ℝ) ≤ 5 := by exact_mod_cast hb5
    apply circleNorm_ge_of_int_band 0 ((b : ℝ) / 6) ((1 : ℝ) / 6) <;>
      norm_num <;> linarith

/-- At a zero of one odd phase, the no-witness hypothesis forces both even
phases strictly beyond one sixth and the other odd phase strictly beyond one
third. -/
theorem three_even_at_odd_zero
    (A E F U W : ℕ)
    (hA6 : 6 ∣ A) (hE2 : 2 ∣ E) (hF2 : 2 ∣ F)
    (hU2 : ¬ 2 ∣ U) (hW2 : ¬ 2 ∣ W)
    (hE3 : ¬ 3 ∣ E) (hF3 : ¬ 3 ∣ F)
    (hU3 : ¬ 3 ∣ U) (hW3 : ¬ 3 ∣ W)
    (hno : ¬ ∃ s : ℝ, ThreeEvenFiveSafe A E F U W s)
    (t : ℝ) (hzero : Int.fract (t * (U : ℝ)) = 0)
    (hp : (1 : ℝ) / 6 ≤ circleNorm (t * (A : ℝ))) :
    (1 : ℝ) / 6 < circleNorm (t * (E : ℝ)) ∧
    (1 : ℝ) / 6 < circleNorm (t * (F : ℝ)) ∧
    (1 : ℝ) / 3 < circleNorm (t * (W : ℝ)) := by
  obtain ⟨zE, σE, hEres, hσE⟩ := threeEven_exists_even_unit_sixth_residue E hE2 hE3
  obtain ⟨zF, σF, hFres, hσF⟩ := threeEven_exists_even_unit_sixth_residue F hF2 hF3
  obtain ⟨zU, σU, hUres, hσU⟩ := threeEven_exists_odd_unit_sixth_residue U hU2 hU3
  obtain ⟨zW, σW, hWres, hσW⟩ := threeEven_exists_odd_unit_sixth_residue W hW2 hW3
  let x : ℝ := (σE : ℝ) * Int.fract (t * (E : ℝ))
  let y : ℝ := (σF : ℝ) * Int.fract (t * (F : ℝ))
  let z : ℝ := (σW : ℝ) * Int.fract (t * (W : ℝ))
  have hx : circleNorm x = circleNorm (t * (E : ℝ)) := by
    exact threeEven_signed_fract_circleNorm σE _ hσE
  have hy : circleNorm y = circleNorm (t * (F : ℝ)) := by
    exact threeEven_signed_fract_circleNorm σF _ hσF
  have hUbase : circleNorm (t * (U : ℝ)) = 0 := by
    rw [show circleNorm (t * (U : ℝ)) = circleNorm (Int.fract (t * (U : ℝ))) by
      simpa using (threeEven_circleNorm_nat_mul_fract (t * (U : ℝ)) 1), hzero]
    simp [circleNorm]
  have hUres' : (U : ℤ) = 6 * zU + (1 : ℤ) * σU := by simpa using hUres
  have hWres' : (W : ℤ) = 6 * zW + (1 : ℤ) * σW := by simpa using hWres
  have hEstrict : (1 : ℝ) / 6 < circleNorm (t * (E : ℝ)) := by
    by_contra hE
    have hEweak : circleNorm x ≤ (1 : ℝ) / 6 := by
      rw [hx]
      exact le_of_not_gt hE
    obtain ⟨b, hb, hxb, hyb, hzb⟩ := sixth_shift_weak_even x y z hEweak
    have hb1 : 1 ≤ b := by rcases hb with h | h | h | h <;> omega
    have hb5 : b ≤ 5 := by rcases hb with h | h | h | h <;> omega
    apply hno
    refine ⟨t + (b : ℝ) / 6, ?_, ?_, ?_, ?_, ?_⟩
    · have hpres := circleNorm_time_add_nat_div_of_dvd 6 A b (by norm_num) hA6 t
      rw [show circleNorm ((t + (b : ℝ) / 6) * (A : ℝ)) =
        circleNorm (t * (A : ℝ)) by convert hpres using 1 <;> norm_num]
      exact hp
    · rw [threeEven_circleNorm_sixth_weighted_shift t E 2 b zE σE hEres hσE]
      simpa [x] using hxb
    · rw [threeEven_circleNorm_sixth_weighted_shift t F 2 b zF σF hFres hσF]
      simpa [y] using hyb
    · rw [threeEven_circleNorm_sixth_weighted_shift t U 1 b zU σU hUres' hσU]
      simpa [hzero] using
        (threeEven_odd_sixth_safe (1 : ℤ) b (Or.inl rfl) hb1 hb5)
    · rw [threeEven_circleNorm_sixth_weighted_shift t W 1 b zW σW hWres' hσW]
      simpa [z] using hzb
  have hFstrict : (1 : ℝ) / 6 < circleNorm (t * (F : ℝ)) := by
    by_contra hF
    have hFweak : circleNorm y ≤ (1 : ℝ) / 6 := by
      rw [hy]
      exact le_of_not_gt hF
    obtain ⟨b, hb, hyb, hxb, hzb⟩ := sixth_shift_weak_even y x z hFweak
    have hb1 : 1 ≤ b := by rcases hb with h | h | h | h <;> omega
    have hb5 : b ≤ 5 := by rcases hb with h | h | h | h <;> omega
    apply hno
    refine ⟨t + (b : ℝ) / 6, ?_, ?_, ?_, ?_, ?_⟩
    · have hpres := circleNorm_time_add_nat_div_of_dvd 6 A b (by norm_num) hA6 t
      rw [show circleNorm ((t + (b : ℝ) / 6) * (A : ℝ)) =
        circleNorm (t * (A : ℝ)) by convert hpres using 1 <;> norm_num]
      exact hp
    · rw [threeEven_circleNorm_sixth_weighted_shift t E 2 b zE σE hEres hσE]
      simpa [x] using hxb
    · rw [threeEven_circleNorm_sixth_weighted_shift t F 2 b zF σF hFres hσF]
      simpa [y] using hyb
    · rw [threeEven_circleNorm_sixth_weighted_shift t U 1 b zU σU hUres' hσU]
      simpa [hzero] using
        (threeEven_odd_sixth_safe (1 : ℤ) b (Or.inl rfl) hb1 hb5)
    · rw [threeEven_circleNorm_sixth_weighted_shift t W 1 b zW σW hWres' hσW]
      simpa [z] using hzb
  have hWstrict : (1 : ℝ) / 3 < circleNorm (t * (W : ℝ)) := by
    by_contra hW
    have hA2 : 2 ∣ A := dvd_trans (by norm_num) hA6
    have hWhalf : (1 : ℝ) / 6 ≤ circleNorm ((t + (1 : ℝ) / 2) * (W : ℝ)) := by
      rw [circleNorm_time_add_half_of_not_dvd_two t W hW2, circleNorm_add_half]
      linarith [le_of_not_gt hW]
    apply hno
    refine ⟨t + (1 : ℝ) / 2, ?_, ?_, ?_, ?_, hWhalf⟩
    · have hpres := circleNorm_time_add_nat_div_of_dvd 2 A 1 (by norm_num) hA2 t
      rw [show circleNorm ((t + (1 : ℝ) / 2) * (A : ℝ)) =
        circleNorm (t * (A : ℝ)) by convert hpres using 1 <;> norm_num]
      exact hp
    · have hpres := circleNorm_time_add_nat_div_of_dvd 2 E 1 (by norm_num) hE2 t
      rw [show circleNorm ((t + (1 : ℝ) / 2) * (E : ℝ)) =
        circleNorm (t * (E : ℝ)) by convert hpres using 1 <;> norm_num]
      exact le_of_lt hEstrict
    · have hpres := circleNorm_time_add_nat_div_of_dvd 2 F 1 (by norm_num) hF2 t
      rw [show circleNorm ((t + (1 : ℝ) / 2) * (F : ℝ)) =
        circleNorm (t * (F : ℝ)) by convert hpres using 1 <;> norm_num]
      exact le_of_lt hFstrict
    · rw [circleNorm_time_add_half_of_not_dvd_two t U hU2, circleNorm_add_half,
        hUbase]
      norm_num
  exact ⟨hEstrict, hFstrict, hWstrict⟩

private theorem threeEven_coprime_six (q : ℕ)
    (h2 : ¬ 2 ∣ q) (h3 : ¬ 3 ∣ q) : Nat.Coprime q 6 := by
  have hq2 : Nat.Coprime q 2 := by
    exact ((Nat.prime_two.coprime_iff_not_dvd).mpr h2).symm
  have hq3 : Nat.Coprime q 3 := by
    exact ((Nat.prime_three.coprime_iff_not_dvd).mpr h3).symm
  simpa using (Nat.coprime_mul_iff_right.mpr ⟨hq2, hq3⟩)

/-- The fixed three-even residue branch supplies a positive common
sixth-margin time.  All role distinctions are label distinctions, so repeated
positive speed values remain admissible. -/
theorem fiveMovingNaturalRunners_of_three_even_residues
    (v : Fin 5 → ℕ) (hpos : ∀ i, 0 < v i)
    (hsix : 6 ∣ v 0)
    (heven1 : 2 ∣ v 1) (heven2 : 2 ∣ v 2)
    (hodd3 : ¬ 2 ∣ v 3) (hodd4 : ¬ 2 ∣ v 4)
    (hother : ∀ i, i ≠ 0 → ¬ 3 ∣ v i) :
    ∃ t : ℝ, 0 < t ∧ ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ)) := by
  have hall : ∃ t : ℝ, ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ)) := by
    by_contra hno
    have hno5 : ¬ ∃ s : ℝ, ThreeEvenFiveSafe (v 0) (v 1) (v 2) (v 3) (v 4) s := by
      rintro ⟨s, h0, h1, h2, h3, h4⟩
      apply hno
      refine ⟨s, ?_⟩
      intro i
      fin_cases i <;> assumption
    have hcop3 := threeEven_coprime_six (v 3) hodd3 (hother 3 (by decide))
    have hcop4 := threeEven_coprime_six (v 4) hodd4 (hother 4 (by decide))
    have hdiv3 : v 3 ∣ v 0 := threeEven_dvd_of_large_partner_at_zeros
      (v 0) (v 3) (v 4) (hpos 3) hcop3 (fun s hz hp =>
        (three_even_at_odd_zero (v 0) (v 1) (v 2) (v 3) (v 4)
          hsix heven1 heven2 hodd3 hodd4
          (hother 1 (by decide)) (hother 2 (by decide))
          (hother 3 (by decide)) (hother 4 (by decide)) hno5 s hz hp).2.2)
    have hno5swap : ¬ ∃ s : ℝ, ThreeEvenFiveSafe (v 0) (v 1) (v 2) (v 4) (v 3) s := by
      rintro ⟨s, h0, h1, h2, h4, h3⟩
      exact hno5 ⟨s, h0, h1, h2, h3, h4⟩
    have hdiv4 : v 4 ∣ v 0 := threeEven_dvd_of_large_partner_at_zeros
      (v 0) (v 4) (v 3) (hpos 4) hcop4 (fun s hz hp =>
        (three_even_at_odd_zero (v 0) (v 1) (v 2) (v 4) (v 3)
          hsix heven1 heven2 hodd4 hodd3
          (hother 1 (by decide)) (hother 2 (by decide))
          (hother 4 (by decide)) (hother 3 (by decide)) hno5swap s hz hp).2.2)
    have hsmall3 : 6 * v 3 ≤ v 0 := by
      exact Nat.le_of_dvd (hpos 0) (hcop3.symm.mul_dvd_of_dvd_of_dvd hsix hdiv3)
    have hsmall4 : 6 * v 4 ≤ v 0 := by
      exact Nat.le_of_dvd (hpos 0) (hcop4.symm.mul_dvd_of_dvd_of_dvd hsix hdiv4)
    let t0 : ℝ := 1 / (6 * (v 0 : ℝ))
    have h0R : 0 < (v 0 : ℝ) := by exact_mod_cast hpos 0
    have hElarge : ∀ a : ℕ, 1 ≤ a → a ≤ 5 →
        (1 : ℝ) / 6 < circleNorm (((a : ℝ) * t0) * (v 1 : ℝ)) := by
      intro a ha1 ha5
      by_contra hE
      have hpivot : (1 : ℝ) / 6 ≤ circleNorm (((a : ℝ) * t0) * (v 0 : ℝ)) := by
        have hphase : ((a : ℝ) * t0) * (v 0 : ℝ) = (a : ℝ) / 6 := by
          dsimp [t0]
          field_simp [h0R.ne']
        rw [hphase]
        have ha1R : (1 : ℝ) ≤ (a : ℝ) := by exact_mod_cast ha1
        have ha5R : (a : ℝ) ≤ 5 := by exact_mod_cast ha5
        apply circleNorm_ge_of_int_band 0 ((a : ℝ) / 6) ((1 : ℝ) / 6) <;>
          norm_num <;> linarith
      have hsmall3R : 6 * (v 3 : ℝ) ≤ (v 0 : ℝ) := by exact_mod_cast hsmall3
      have hsmall4R : 6 * (v 4 : ℝ) ≤ (v 0 : ℝ) := by exact_mod_cast hsmall4
      have hbad3 : circleNorm (((a : ℝ) * t0) * (v 3 : ℝ)) < (1 : ℝ) / 6 := by
        simpa [t0, mul_assoc] using threeEven_small_sixth_dilate_norm
          (v 0 : ℝ) (v 3 : ℝ) a h0R (by positivity) hsmall3R ha5
      have hbad4 : circleNorm (((a : ℝ) * t0) * (v 4 : ℝ)) < (1 : ℝ) / 6 := by
        simpa [t0, mul_assoc] using threeEven_small_sixth_dilate_norm
          (v 0 : ℝ) (v 4 : ℝ) a h0R (by positivity) hsmall4R ha5
      have hweak3 : circleNorm (((a : ℝ) * t0) * (v 3 : ℝ)) ≤ (1 : ℝ) / 6 :=
        le_of_lt hbad3
      have hweak4 : circleNorm (((a : ℝ) * t0) * (v 4 : ℝ)) ≤ (1 : ℝ) / 6 :=
        le_of_lt hbad4
      let B : Finset (Fin 5) := Finset.univ.filter (fun i => i ≠ 0 ∧
        circleNorm (((a : ℝ) * t0) * (v i : ℝ)) ≤ (1 : ℝ) / 6)
      have hsubset : ({1, 3, 4} : Finset (Fin 5)) ⊆ B := by
        intro i hi
        fin_cases i <;> simp_all [B, hweak3, hweak4]
      have hbadcard : 3 ≤ B.card := by
        have hcard := Finset.card_le_card hsubset
        norm_num at hcard ⊢
        exact hcard
      obtain ⟨k, hk⟩ := third_shift_of_three_weak_exceptions v 0
        (dvd_trans (by norm_num) hsix) hother ((a : ℝ) * t0) hpivot (by
          simpa [B] using hbadcard)
      exact hno ⟨(a : ℝ) * t0 + (k.val : ℝ) / 3, hk⟩
    have hEone : (1 : ℝ) / 6 < circleNorm (t0 * (v 1 : ℝ)) := by
      simpa using hElarge 1 (by omega) (by omega)
    obtain ⟨a, ha2, ha5, hbad⟩ := exists_bad_sixth_dilate (t0 * (v 1 : ℝ)) hEone
    have hlarge := hElarge a (by omega) ha5
    have hbad' : circleNorm (((a : ℝ) * t0) * (v 1 : ℝ)) < (1 : ℝ) / 6 := by
      simpa [mul_assoc] using hbad
    linarith
  obtain ⟨u, hu⟩ := hall
  have hu0 : u ≠ 0 := by
    intro hzero
    have h := hu 0
    rw [hzero] at h
    norm_num [circleNorm] at h
  rcases lt_or_gt_of_ne hu0 with hneg | hposu
  · refine ⟨-u, neg_pos.mpr hneg, ?_⟩
    intro i
    rw [show (-u) * (v i : ℝ) = -(u * (v i : ℝ)) by ring, circleNorm_neg]
    exact hu i
  · exact ⟨u, hposu, hu⟩

/-- A unique three-divisible label and exactly three even labels can be
relabelled into the fixed three-even theorem. -/
theorem one_three_divisible_three_even_witness
    (v : Fin 5 → ℕ) (hpos : ∀ i, 0 < v i) (p : Fin 5)
    (hone : ∀ i, 3 ∣ v i ↔ i = p)
    (heven : ((Finset.univ : Finset (Fin 5)).filter
      (fun i => 2 ∣ v i)).card = 3) :
    ∃ t : ℝ, 0 < t ∧ ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ)) := by
  have hall : ∃ t : ℝ, ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ)) := by
    by_contra hno
    obtain ⟨i, hsi⟩ := divisor_cover_of_no_small_witness v (N := 6) (by omega)
      (by simpa [one_div] using hno) 6 (by omega) (by omega)
    have hip : i = p := (hone i).mp (dvd_trans (by norm_num) hsi)
    subst i
    have hp2 : 2 ∣ v p := dvd_trans (by norm_num) hsi
    let S : Finset (Fin 5) := Finset.univ.filter (fun i => 2 ∣ v i)
    have hpS : p ∈ S := by simp [S, hp2]
    have herase : (S.erase p).card = 2 := by
      rw [Finset.card_erase_of_mem hpS, heven]
    obtain ⟨e, f, hef, hSef⟩ := Finset.card_eq_two.mp herase
    have hep : e ≠ p := by
      intro h
      subst e
      have : p ∈ S.erase p := by rw [hSef]; simp
      simpa using this
    have hfp : f ≠ p := by
      intro h
      subst f
      have : p ∈ S.erase p := by rw [hSef]; simp
      simpa using this
    have he2 : 2 ∣ v e := by
      have : e ∈ S := Finset.mem_of_mem_erase (by rw [hSef]; simp)
      simpa [S] using this
    have hf2 : 2 ∣ v f := by
      have : f ∈ S := Finset.mem_of_mem_erase (by rw [hSef]; simp)
      simpa [S] using this
    obtain ⟨u, w, huw, huodd, hwodd, hlabels⟩ := exists_two_odd_outside_three
      v p e f hep.symm hfp hef.symm hp2 he2 hf2 (by omega)
    let v' : Fin 5 → ℕ := ![v p, v e, v f, v u, v w]
    have hv'pos : ∀ j, 0 < v' j := by intro j; fin_cases j <;> simp [v', hpos]
    have hv'six : 6 ∣ v' 0 := by simpa [v'] using hsi
    have hv'even1 : 2 ∣ v' 1 := by simpa [v'] using he2
    have hv'even2 : 2 ∣ v' 2 := by simpa [v'] using hf2
    have hv'odd3 : ¬ 2 ∣ v' 3 := by simpa [v'] using huodd
    have hv'odd4 : ¬ 2 ∣ v' 4 := by simpa [v'] using hwodd
    have hv'other : ∀ j, j ≠ 0 → ¬ 3 ∣ v' j := by
      intro j hj h3
      have hup : u ≠ p := fun h => huodd (h ▸ hp2)
      have hwp : w ≠ p := fun h => hwodd (h ▸ hp2)
      fin_cases j
      · exact (hj rfl).elim
      · exact hep ((hone e).mp h3)
      · exact hfp ((hone f).mp h3)
      · exact hup ((hone u).mp h3)
      · exact hwp ((hone w).mp h3)
    obtain ⟨t, ht, hbound⟩ := fiveMovingNaturalRunners_of_three_even_residues v'
      hv'pos hv'six hv'even1 hv'even2 hv'odd3 hv'odd4 hv'other
    apply hno
    refine ⟨t, ?_⟩
    intro j
    rcases hlabels j with rfl | rfl | rfl | rfl | rfl
    · simpa [v'] using hbound 0
    · simpa [v'] using hbound 1
    · simpa [v'] using hbound 2
    · simpa [v'] using hbound 3
    · simpa [v'] using hbound 4
  obtain ⟨u, hu⟩ := hall
  have hu0 : u ≠ 0 := by
    intro hzero
    have h := hu p
    rw [hzero] at h
    norm_num [circleNorm] at h
  rcases lt_or_gt_of_ne hu0 with hneg | hposu
  · refine ⟨-u, neg_pos.mpr hneg, ?_⟩
    intro i
    rw [show (-u) * (v i : ℝ) = -(u * (v i : ℝ)) by ring, circleNorm_neg]
    exact hu i
  · exact ⟨u, hposu, hu⟩

end LonelyRunner
