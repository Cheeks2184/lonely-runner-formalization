import LonelyRunner.OwnerKernelBound
import LonelyRunner.PeriodicPivotCounts
import LonelyRunner.Prompt99Scaling

/-!
# Four genuine lower owners at denominator nine

The reviewed proof isolates four normalized exceptional owners. Scalar bounds
reduce every remaining overlap obligation to a finite normalized pair, and
exact common scaling carries those kernel-checked pairs to arbitrary heights.
-/

namespace LonelyRunner

open Finset

private def NineStar (p d : Nat) : Prop :=
  10*d = 9*p ∨ 11*d = 9*p ∨ 19*d = 9*p ∨ 19*d = 18*p

private theorem nine_normalize (p d : Nat) (hd : 0 < d) (hdp : d < p) :
    ∃ h P D : Nat, 0 < h ∧ 0 < D ∧ D < P ∧
      p = h * P ∧ d = h * D ∧ Nat.Coprime D P ∧
      (Nat.gcd D 9 = 1 ∨ Nat.gcd D 9 = 3 ∨ Nat.gcd D 9 = 9) ∧
      (pivotBadResidues 9 p d).card = h * normalizedBadCount 9 (Nat.gcd D 9) P := by
  let h := Nat.gcd d p
  let P := p / h
  let D := d / h
  have hh : 0 < h := Nat.gcd_pos_of_pos_left p hd
  have hpP : p = h * P := (Nat.mul_div_cancel' (Nat.gcd_dvd_right d p)).symm
  have hdD : d = h * D := (Nat.mul_div_cancel' (Nat.gcd_dvd_left d p)).symm
  have hD : 0 < D := by nlinarith [Nat.zero_le h]
  have hDP : D < P := by nlinarith
  have hcop : Nat.Coprime D P := Nat.coprime_div_gcd_div_gcd hh
  have hk : Nat.gcd D 9 = 1 ∨ Nat.gcd D 9 = 3 ∨ Nat.gcd D 9 = 9 := by
    have hdiv := Nat.gcd_dvd_right D 9
    have hle : Nat.gcd D 9 ≤ 9 := Nat.le_of_dvd (by omega) hdiv
    interval_cases hg : Nat.gcd D 9 <;> norm_num [hg] at *
  refine ⟨h,P,D,hh,hD,hDP,hpP,hdD,hcop,hk,?_⟩
  exact card_pivotBadResidues_normalized 9 p d h P D (Nat.gcd D 9)
    (by omega) (by omega) hd hdp rfl hpP hdD hcop rfl

private theorem nine_count_one (P : Nat) (hP : 0 < P) :
    9 * normalizedBadCount 9 1 P ≤ 16*P := by
  simp [normalizedBadCount]
  omega

private theorem nine_count_three (P : Nat) (hP : 0 < P) :
    normalizedBadCount 9 3 P ≤ 2*P := by
  simp [normalizedBadCount]
  omega

private theorem nine_count_nine_coarse (P : Nat) (hP : 10 ≤ P) :
    5 * normalizedBadCount 9 9 P ≤ 12*P := by
  simp [normalizedBadCount]
  omega

private theorem nine_count_nine_le_two (P : Nat) (hP : 10 ≤ P)
    (h10 : P ≠ 10) (h11 : P ≠ 11) (h19 : P ≠ 19) :
    normalizedBadCount 9 9 P ≤ 2*P := by
  simp [normalizedBadCount]
  omega

private theorem nine_row_le_two (p d : Nat) (hd : 0 < d) (hdp : d < p)
    (hne : ¬NineStar p d) : (pivotBadResidues 9 p d).card ≤ 2*p := by
  obtain ⟨h,P,D,hh,hD,hDP,hpP,hdD,hcop,hk,hcard⟩ := nine_normalize p d hd hdp
  rcases hk with hk | hk | hk
  · have hb := nine_count_one P (by omega)
    rw [hk] at hcard
    nlinarith
  · have hb := nine_count_three P (by omega)
    rw [hk] at hcard
    nlinarith
  · have h9D : 9 ∣ D := by simpa [hk] using Nat.gcd_dvd_left D 9
    have h9 : 9 ≤ D := Nat.le_of_dvd hD h9D
    have h10 : P ≠ 10 := by
      intro hP
      have hD9 : D = 9 := by omega
      apply hne
      apply Or.inl
      rw [hpP,hdD,hP,hD9]
      ring
    have h11 : P ≠ 11 := by
      intro hP
      have hD9 : D = 9 := by omega
      apply hne
      apply Or.inr ∘ Or.inl
      rw [hpP,hdD,hP,hD9]
      ring
    have h19 : P ≠ 19 := by
      intro hP
      have hDs : D = 9 ∨ D = 18 := by omega
      apply hne
      rcases hDs with hDs | hDs
      · apply Or.inr ∘ Or.inr ∘ Or.inl
        rw [hpP,hdD,hP,hDs]
        ring
      · apply Or.inr ∘ Or.inr ∘ Or.inr
        rw [hpP,hdD,hP,hDs]
        ring
    have hb := nine_count_nine_le_two P (by omega) h10 h11 h19
    rw [hk] at hcard
    nlinarith

private theorem nine_row_scale (p d t : Nat) (hp : 0 < p) (ht : 0 < t) :
    (pivotBadResidues 9 (t*p) (t*d)).card = t * (pivotBadResidues 9 p d).card := by
  let S := pivotBadResidues 9 p d
  have hS : S ⊆ range (9*p) := by
    intro r hr
    exact mem_range.mpr (mem_pivotCandidates.mp (pivotBadResidues_subset 9 p d hr)).1
  have heq : pivotBadResidues 9 (t*p) (t*d) =
      (range (t*(9*p))).filter (fun r => r % (9*p) ∈ S) := by
    ext r
    simp only [mem_filter,mem_range,S,
      mem_pivotBadResidues_scale_reduce_iff (by omega : 0 < 9) hp ht]
  rw [heq]
  exact card_filter_range_mod_mem t (9*p) (by omega) S hS

private theorem nine_difference_scale (p d s t : Nat) (hp : 0 < p) (ht : 0 < t) :
    (pivotBadResidues 9 (t*p) (t*d) \ pivotBadResidues 9 (t*p) (t*s)).card =
      t * (pivotBadResidues 9 p d \ pivotBadResidues 9 p s).card := by
  let S := pivotBadResidues 9 p d \ pivotBadResidues 9 p s
  have hS : S ⊆ range (9*p) := by
    intro r hr
    exact mem_range.mpr (mem_pivotCandidates.mp
      (pivotBadResidues_subset 9 p d (mem_sdiff.mp hr).1)).1
  have heq : pivotBadResidues 9 (t*p) (t*d) \ pivotBadResidues 9 (t*p) (t*s) =
      (range (t*(9*p))).filter (fun r => r % (9*p) ∈ S) := by
    ext r
    simp only [mem_sdiff,mem_filter,mem_range,S,
      mem_pivotBadResidues_scale_reduce_iff (by omega : 0 < 9) hp ht]
    tauto
  rw [heq]
  exact card_filter_range_mod_mem t (9*p) (by omega) S hS

-- These three rational thresholds are encoded by integer cross-products.
private def NineBudget (u v : Nat) : Prop :=
  (u = 15 ∧ v = 28) ∨ (u = 33 ∧ v = 64) ∨ (u = 57 ∧ v = 112)

private theorem nine_exception_cap (P D u v : Nat) (hP : 0 < P)
    (hk : Nat.gcd D 9 = 1 ∨ Nat.gcd D 9 = 3 ∨ Nat.gcd D 9 = 9)
    (hbudget : NineBudget u v)
    (hraw : v*P ≤ u*normalizedBadCount 9 (Nat.gcd D 9) P) : P < 71 := by
  have hb := normalizedBadCount_ownerKernel_bound 9 (Nat.gcd D 9) P
    (by omega) hP (Nat.gcd_pos_of_pos_right D (by omega)) (Nat.gcd_dvd_right D 9)
  rcases hbudget with ⟨rfl,rfl⟩ | ⟨rfl,rfl⟩ | ⟨rfl,rfl⟩ <;>
    rcases hk with hk | hk | hk <;> rw [hk] at hb hraw <;> norm_num at hb <;> omega

/-- A common lcm period suffices even when the original pivot contains
arbitrary powers of three. Both owners scale together with that pivot. -/
private theorem nine_pair_lift (p d s h P D S Ds u v : Nat)
    (hh : 0 < h) (hP : 0 < P) (hS : 0 < S) (hpP : p = h*P) (hdD : d = h*D)
    (hSp : S ∣ p) (hstar : S*s = Ds*p)
    (hb : u * (pivotBadResidues 9 (Nat.lcm S P) ((Nat.lcm S P / P)*D) \
      pivotBadResidues 9 (Nat.lcm S P) ((Nat.lcm S P / S)*Ds)).card < v*Nat.lcm S P) :
    u * (pivotBadResidues 9 p d \ pivotBadResidues 9 p s).card < v*p := by
  let L := Nat.lcm S P
  have hL : 0 < L := Nat.lcm_pos hS hP
  have hPL : P ∣ L := Nat.dvd_lcm_right S P
  have hSL : S ∣ L := Nat.dvd_lcm_left S P
  have hLp : L ∣ p := Nat.lcm_dvd hSp ⟨h, by rw [hpP]; ring⟩
  let t := p / L
  have hpt : p = t*L := (Nat.div_mul_cancel hLp).symm
  have ht : 0 < t := by nlinarith
  have hhfact : h = t*(L/P) := by
    apply Nat.mul_right_cancel hP
    calc
      h*P = p := hpP.symm
      _ = t*L := hpt
      _ = (t*(L/P))*P := by rw [mul_assoc, Nat.div_mul_cancel hPL]
  have hd : d = t*((L/P)*D) := by rw [hdD,hhfact]; ring
  have hs : s = t*((L/S)*Ds) := by
    apply Nat.mul_left_cancel hS
    calc
      S*s = Ds*p := hstar
      _ = Ds*(t*L) := by rw [hpt]
      _ = S*(t*((L/S)*Ds)) := by
        rw [show S*(t*((L/S)*Ds)) = (t*Ds)*((L/S)*S) by ring,
          Nat.div_mul_cancel hSL]
        ring
  rw [hpt,hd,hs,nine_difference_scale L ((L/P)*D) ((L/S)*Ds) t hL ht]
  have hmul := Nat.mul_lt_mul_of_pos_left hb ht
  simpa [L,mul_assoc,mul_left_comm,mul_comm] using hmul

-- A single filtered range is definitionally inexpensive for closed kernel
-- checks. The following equality proves it is the literal bad-set difference.
private def nineRemainderCount (p d s : Nat) : Nat :=
  ((range (9*p)).filter fun r => r % 9 ≠ 0 ∧
    cyclicResidueDistance (9*p) (r*d) < p ∧
    p ≤ cyclicResidueDistance (9*p) (r*s)).card

private theorem nine_remainder_count_eq (p d s : Nat) :
    nineRemainderCount p d s =
      (pivotBadResidues 9 p d \ pivotBadResidues 9 p s).card := by
  unfold nineRemainderCount
  congr 1
  ext r
  simp only [mem_filter,mem_range,mem_sdiff,mem_pivotBadResidues,mem_pivotCandidates,
    Nat.dvd_iff_mod_eq_zero]
  omega

-- This finite predicate includes every admissible normalized D, including
-- the other star at denominator 19. The scalar lemma proves P < 71 first.
private def NinePairCheck (S Ds u v : Nat) : Prop :=
  ∀ P D : Fin 71, 0 < D.val → D.val < P.val → Nat.Coprime D.val P.val →
    v*P.val ≤ u*normalizedBadCount 9 (Nat.gcd D.val 9) P.val →
    S*D.val ≠ Ds*P.val →
    u * nineRemainderCount (Nat.lcm S P.val) ((Nat.lcm S P.val / P.val)*D.val)
      ((Nat.lcm S P.val / S)*Ds) < v*Nat.lcm S P.val

-- Separate closed residue calculations keep elaboration memory bounded.
-- The classifier below is also kernel-checked: the explicit table is not
-- trusted data, and its completeness does not come from a Python search.
private def NinePairMembership (S Ds u v : Nat) (pairs : Finset (Nat × Nat)) : Prop :=
  ∀ P D : Fin 71, 0 < D.val → D.val < P.val → Nat.Coprime D.val P.val →
    v*P.val ≤ u*normalizedBadCount 9 (Nat.gcd D.val 9) P.val →
    S*D.val ≠ Ds*P.val → (P.val,D.val) ∈ pairs

set_option Elab.async false in
set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
private theorem nine_pair_ten_4_3 :
    15 * nineRemainderCount 20 15 18 < 28*20 := by
  decide

set_option Elab.async false in
set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
private theorem nine_pair_ten_7_3 :
    15 * nineRemainderCount 70 30 63 < 28*70 := by
  decide

set_option Elab.async false in
set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
private theorem nine_pair_ten_7_6 :
    15 * nineRemainderCount 70 60 63 < 28*70 := by
  decide

set_option Elab.async false in
set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
private theorem nine_pair_ten_11_9 :
    15 * nineRemainderCount 110 90 99 < 28*110 := by
  decide

set_option Elab.async false in
set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
private theorem nine_pair_ten_16_3 :
    15 * nineRemainderCount 80 15 72 < 28*80 := by
  decide

set_option Elab.async false in
set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
private theorem nine_pair_ten_16_15 :
    15 * nineRemainderCount 80 75 72 < 28*80 := by
  decide

set_option Elab.async false in
set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
private theorem nine_pair_ten_19_9 :
    15 * nineRemainderCount 190 90 171 < 28*190 := by
  decide

set_option Elab.async false in
set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
private theorem nine_pair_ten_19_18 :
    15 * nineRemainderCount 190 180 171 < 28*190 := by
  decide

set_option Elab.async false in
set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
private theorem nine_pair_ten_20_9 :
    15 * nineRemainderCount 20 9 18 < 28*20 := by
  decide

set_option Elab.async false in
set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
private theorem nine_pair_ten_28_9 :
    15 * nineRemainderCount 140 45 126 < 28*140 := by
  decide

set_option Elab.async false in
set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
private theorem nine_pair_ten_28_27 :
    15 * nineRemainderCount 140 135 126 < 28*140 := by
  decide

set_option Elab.async false in
set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
private theorem nine_pair_ten_29_9 :
    15 * nineRemainderCount 290 90 261 < 28*290 := by
  decide

set_option Elab.async false in
set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
private theorem nine_pair_ten_29_18 :
    15 * nineRemainderCount 290 180 261 < 28*290 := by
  decide

set_option Elab.async false in
set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
private theorem nine_pair_ten_29_27 :
    15 * nineRemainderCount 290 270 261 < 28*290 := by
  decide

set_option Elab.async false in
set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
private theorem nine_pair_ten_37_9 :
    15 * nineRemainderCount 370 90 333 < 28*370 := by
  decide

set_option Elab.async false in
set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
private theorem nine_pair_ten_37_18 :
    15 * nineRemainderCount 370 180 333 < 28*370 := by
  decide

set_option Elab.async false in
set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
private theorem nine_pair_ten_37_27 :
    15 * nineRemainderCount 370 270 333 < 28*370 := by
  decide

set_option Elab.async false in
set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
private theorem nine_pair_ten_37_36 :
    15 * nineRemainderCount 370 360 333 < 28*370 := by
  decide

set_option Elab.async false in
set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
private theorem nine_pair_ten_38_9 :
    15 * nineRemainderCount 190 45 171 < 28*190 := by
  decide

set_option Elab.async false in
set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
private theorem nine_pair_ten_38_27 :
    15 * nineRemainderCount 190 135 171 < 28*190 := by
  decide

set_option Elab.async false in
set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
private theorem nine_pair_ten_46_9 :
    15 * nineRemainderCount 230 45 207 < 28*230 := by
  decide

set_option Elab.async false in
set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
private theorem nine_pair_ten_46_27 :
    15 * nineRemainderCount 230 135 207 < 28*230 := by
  decide

set_option Elab.async false in
set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
private theorem nine_pair_ten_46_45 :
    15 * nineRemainderCount 230 225 207 < 28*230 := by
  decide

set_option Elab.async false in
set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
private theorem nine_pair_ten_47_9 :
    15 * nineRemainderCount 470 90 423 < 28*470 := by
  decide

set_option Elab.async false in
set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
private theorem nine_pair_ten_47_18 :
    15 * nineRemainderCount 470 180 423 < 28*470 := by
  decide

set_option Elab.async false in
set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
private theorem nine_pair_ten_47_27 :
    15 * nineRemainderCount 470 270 423 < 28*470 := by
  decide

set_option Elab.async false in
set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
private theorem nine_pair_ten_47_36 :
    15 * nineRemainderCount 470 360 423 < 28*470 := by
  decide

set_option Elab.async false in
set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
private theorem nine_pair_ten_47_45 :
    15 * nineRemainderCount 470 450 423 < 28*470 := by
  decide

set_option Elab.async false in
set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
private theorem nine_pair_ten_55_9 :
    15 * nineRemainderCount 110 18 99 < 28*110 := by
  decide

set_option Elab.async false in
set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
private theorem nine_pair_ten_55_18 :
    15 * nineRemainderCount 110 36 99 < 28*110 := by
  decide

set_option Elab.async false in
set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
private theorem nine_pair_ten_55_27 :
    15 * nineRemainderCount 110 54 99 < 28*110 := by
  decide

set_option Elab.async false in
set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
private theorem nine_pair_ten_55_36 :
    15 * nineRemainderCount 110 72 99 < 28*110 := by
  decide

set_option Elab.async false in
set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
private theorem nine_pair_ten_55_54 :
    15 * nineRemainderCount 110 108 99 < 28*110 := by
  decide

set_option Elab.async false in
set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
private theorem nine_pair_ten_64_9 :
    15 * nineRemainderCount 320 45 288 < 28*320 := by
  decide

set_option Elab.async false in
set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
private theorem nine_pair_ten_64_27 :
    15 * nineRemainderCount 320 135 288 < 28*320 := by
  decide

set_option Elab.async false in
set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
private theorem nine_pair_ten_64_45 :
    15 * nineRemainderCount 320 225 288 < 28*320 := by
  decide

set_option Elab.async false in
set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
private theorem nine_pair_ten_64_63 :
    15 * nineRemainderCount 320 315 288 < 28*320 := by
  decide

set_option Elab.async false in
set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
private theorem nine_pair_membership_ten :
    NinePairMembership 10 9 15 28
      {(4,3), (7,3), (7,6), (11,9), (16,3), (16,15), (19,9), (19,18), (20,9), (28,9), (28,27), (29,9), (29,18), (29,27), (37,9), (37,18), (37,27), (37,36), (38,9), (38,27), (46,9), (46,27), (46,45), (47,9), (47,18), (47,27), (47,36), (47,45), (55,9), (55,18), (55,27), (55,36), (55,54), (64,9), (64,27), (64,45), (64,63)} := by
  unfold NinePairMembership
  decide

private theorem nine_pair_check_ten : NinePairCheck 10 9 15 28 := by
  intro P D hD hDP hcop hraw hne
  have hmem := nine_pair_membership_ten P D hD hDP hcop hraw hne
  simp only [mem_insert,mem_singleton,Prod.mk.injEq] at hmem
  rcases hmem with ⟨hP,hD⟩ | ⟨hP,hD⟩ | ⟨hP,hD⟩ | ⟨hP,hD⟩ | ⟨hP,hD⟩ | ⟨hP,hD⟩ | ⟨hP,hD⟩ | ⟨hP,hD⟩ | ⟨hP,hD⟩ | ⟨hP,hD⟩ | ⟨hP,hD⟩ | ⟨hP,hD⟩ | ⟨hP,hD⟩ | ⟨hP,hD⟩ | ⟨hP,hD⟩ | ⟨hP,hD⟩ | ⟨hP,hD⟩ | ⟨hP,hD⟩ | ⟨hP,hD⟩ | ⟨hP,hD⟩ | ⟨hP,hD⟩ | ⟨hP,hD⟩ | ⟨hP,hD⟩ | ⟨hP,hD⟩ | ⟨hP,hD⟩ | ⟨hP,hD⟩ | ⟨hP,hD⟩ | ⟨hP,hD⟩ | ⟨hP,hD⟩ | ⟨hP,hD⟩ | ⟨hP,hD⟩ | ⟨hP,hD⟩ | ⟨hP,hD⟩ | ⟨hP,hD⟩ | ⟨hP,hD⟩ | ⟨hP,hD⟩ | ⟨hP,hD⟩
  · norm_num only [hP,hD,Nat.lcm]
    exact nine_pair_ten_4_3
  · norm_num only [hP,hD,Nat.lcm]
    exact nine_pair_ten_7_3
  · norm_num only [hP,hD,Nat.lcm]
    exact nine_pair_ten_7_6
  · norm_num only [hP,hD,Nat.lcm]
    exact nine_pair_ten_11_9
  · norm_num only [hP,hD,Nat.lcm]
    exact nine_pair_ten_16_3
  · norm_num only [hP,hD,Nat.lcm]
    exact nine_pair_ten_16_15
  · norm_num only [hP,hD,Nat.lcm]
    exact nine_pair_ten_19_9
  · norm_num only [hP,hD,Nat.lcm]
    exact nine_pair_ten_19_18
  · norm_num only [hP,hD,Nat.lcm]
    exact nine_pair_ten_20_9
  · norm_num only [hP,hD,Nat.lcm]
    exact nine_pair_ten_28_9
  · norm_num only [hP,hD,Nat.lcm]
    exact nine_pair_ten_28_27
  · norm_num only [hP,hD,Nat.lcm]
    exact nine_pair_ten_29_9
  · norm_num only [hP,hD,Nat.lcm]
    exact nine_pair_ten_29_18
  · norm_num only [hP,hD,Nat.lcm]
    exact nine_pair_ten_29_27
  · norm_num only [hP,hD,Nat.lcm]
    exact nine_pair_ten_37_9
  · norm_num only [hP,hD,Nat.lcm]
    exact nine_pair_ten_37_18
  · norm_num only [hP,hD,Nat.lcm]
    exact nine_pair_ten_37_27
  · norm_num only [hP,hD,Nat.lcm]
    exact nine_pair_ten_37_36
  · norm_num only [hP,hD,Nat.lcm]
    exact nine_pair_ten_38_9
  · norm_num only [hP,hD,Nat.lcm]
    exact nine_pair_ten_38_27
  · norm_num only [hP,hD,Nat.lcm]
    exact nine_pair_ten_46_9
  · norm_num only [hP,hD,Nat.lcm]
    exact nine_pair_ten_46_27
  · norm_num only [hP,hD,Nat.lcm]
    exact nine_pair_ten_46_45
  · norm_num only [hP,hD,Nat.lcm]
    exact nine_pair_ten_47_9
  · norm_num only [hP,hD,Nat.lcm]
    exact nine_pair_ten_47_18
  · norm_num only [hP,hD,Nat.lcm]
    exact nine_pair_ten_47_27
  · norm_num only [hP,hD,Nat.lcm]
    exact nine_pair_ten_47_36
  · norm_num only [hP,hD,Nat.lcm]
    exact nine_pair_ten_47_45
  · norm_num only [hP,hD,Nat.lcm]
    exact nine_pair_ten_55_9
  · norm_num only [hP,hD,Nat.lcm]
    exact nine_pair_ten_55_18
  · norm_num only [hP,hD,Nat.lcm]
    exact nine_pair_ten_55_27
  · norm_num only [hP,hD,Nat.lcm]
    exact nine_pair_ten_55_36
  · norm_num only [hP,hD,Nat.lcm]
    exact nine_pair_ten_55_54
  · norm_num only [hP,hD,Nat.lcm]
    exact nine_pair_ten_64_9
  · norm_num only [hP,hD,Nat.lcm]
    exact nine_pair_ten_64_27
  · norm_num only [hP,hD,Nat.lcm]
    exact nine_pair_ten_64_45
  · norm_num only [hP,hD,Nat.lcm]
    exact nine_pair_ten_64_63

set_option Elab.async false in
set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
private theorem nine_pair_eleven_4_3 :
    33 * nineRemainderCount 44 33 36 < 64*44 := by
  decide

set_option Elab.async false in
set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
private theorem nine_pair_eleven_7_3 :
    33 * nineRemainderCount 77 33 63 < 64*77 := by
  decide

set_option Elab.async false in
set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
private theorem nine_pair_eleven_7_6 :
    33 * nineRemainderCount 77 66 63 < 64*77 := by
  decide

set_option Elab.async false in
set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
private theorem nine_pair_eleven_10_9 :
    33 * nineRemainderCount 110 99 90 < 64*110 := by
  decide

set_option Elab.async false in
set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
private theorem nine_pair_eleven_19_9 :
    33 * nineRemainderCount 209 99 171 < 64*209 := by
  decide

set_option Elab.async false in
set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
private theorem nine_pair_eleven_19_18 :
    33 * nineRemainderCount 209 198 171 < 64*209 := by
  decide

set_option Elab.async false in
set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
private theorem nine_pair_eleven_20_9 :
    33 * nineRemainderCount 220 99 180 < 64*220 := by
  decide

set_option Elab.async false in
set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
private theorem nine_pair_eleven_28_9 :
    33 * nineRemainderCount 308 99 252 < 64*308 := by
  decide

set_option Elab.async false in
set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
private theorem nine_pair_eleven_28_27 :
    33 * nineRemainderCount 308 297 252 < 64*308 := by
  decide

set_option Elab.async false in
set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
private theorem nine_pair_eleven_37_9 :
    33 * nineRemainderCount 407 99 333 < 64*407 := by
  decide

set_option Elab.async false in
set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
private theorem nine_pair_eleven_37_18 :
    33 * nineRemainderCount 407 198 333 < 64*407 := by
  decide

set_option Elab.async false in
set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
private theorem nine_pair_eleven_37_27 :
    33 * nineRemainderCount 407 297 333 < 64*407 := by
  decide

set_option Elab.async false in
set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
private theorem nine_pair_eleven_37_36 :
    33 * nineRemainderCount 407 396 333 < 64*407 := by
  decide

set_option Elab.async false in
set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
private theorem nine_pair_membership_eleven :
    NinePairMembership 11 9 33 64
      {(4,3), (7,3), (7,6), (10,9), (19,9), (19,18), (20,9), (28,9), (28,27), (37,9), (37,18), (37,27), (37,36)} := by
  unfold NinePairMembership
  decide

private theorem nine_pair_check_eleven : NinePairCheck 11 9 33 64 := by
  intro P D hD hDP hcop hraw hne
  have hmem := nine_pair_membership_eleven P D hD hDP hcop hraw hne
  simp only [mem_insert,mem_singleton,Prod.mk.injEq] at hmem
  rcases hmem with ⟨hP,hD⟩ | ⟨hP,hD⟩ | ⟨hP,hD⟩ | ⟨hP,hD⟩ | ⟨hP,hD⟩ | ⟨hP,hD⟩ | ⟨hP,hD⟩ | ⟨hP,hD⟩ | ⟨hP,hD⟩ | ⟨hP,hD⟩ | ⟨hP,hD⟩ | ⟨hP,hD⟩ | ⟨hP,hD⟩
  · norm_num only [hP,hD,Nat.lcm]
    exact nine_pair_eleven_4_3
  · norm_num only [hP,hD,Nat.lcm]
    exact nine_pair_eleven_7_3
  · norm_num only [hP,hD,Nat.lcm]
    exact nine_pair_eleven_7_6
  · norm_num only [hP,hD,Nat.lcm]
    exact nine_pair_eleven_10_9
  · norm_num only [hP,hD,Nat.lcm]
    exact nine_pair_eleven_19_9
  · norm_num only [hP,hD,Nat.lcm]
    exact nine_pair_eleven_19_18
  · norm_num only [hP,hD,Nat.lcm]
    exact nine_pair_eleven_20_9
  · norm_num only [hP,hD,Nat.lcm]
    exact nine_pair_eleven_28_9
  · norm_num only [hP,hD,Nat.lcm]
    exact nine_pair_eleven_28_27
  · norm_num only [hP,hD,Nat.lcm]
    exact nine_pair_eleven_37_9
  · norm_num only [hP,hD,Nat.lcm]
    exact nine_pair_eleven_37_18
  · norm_num only [hP,hD,Nat.lcm]
    exact nine_pair_eleven_37_27
  · norm_num only [hP,hD,Nat.lcm]
    exact nine_pair_eleven_37_36

set_option Elab.async false in
set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
private theorem nine_pair_nineteen_a_4_3 :
    57 * nineRemainderCount 76 57 36 < 112*76 := by
  decide

set_option Elab.async false in
set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
private theorem nine_pair_nineteen_a_7_3 :
    57 * nineRemainderCount 133 57 63 < 112*133 := by
  decide

set_option Elab.async false in
set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
private theorem nine_pair_nineteen_a_7_6 :
    57 * nineRemainderCount 133 114 63 < 112*133 := by
  decide

set_option Elab.async false in
set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
private theorem nine_pair_nineteen_a_10_9 :
    57 * nineRemainderCount 190 171 90 < 112*190 := by
  decide

set_option Elab.async false in
set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
private theorem nine_pair_nineteen_a_11_9 :
    57 * nineRemainderCount 209 171 99 < 112*209 := by
  decide

set_option Elab.async false in
set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
private theorem nine_pair_nineteen_a_19_18 :
    57 * nineRemainderCount 19 18 9 < 112*19 := by
  decide

set_option Elab.async false in
set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
private theorem nine_pair_nineteen_a_20_9 :
    57 * nineRemainderCount 380 171 180 < 112*380 := by
  decide

set_option Elab.async false in
set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
private theorem nine_pair_nineteen_a_28_9 :
    57 * nineRemainderCount 532 171 252 < 112*532 := by
  decide

set_option Elab.async false in
set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
private theorem nine_pair_nineteen_a_28_27 :
    57 * nineRemainderCount 532 513 252 < 112*532 := by
  decide

set_option Elab.async false in
set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
private theorem nine_pair_membership_nineteen_a :
    NinePairMembership 19 9 57 112
      {(4,3), (7,3), (7,6), (10,9), (11,9), (19,18), (20,9), (28,9), (28,27)} := by
  unfold NinePairMembership
  decide

private theorem nine_pair_check_nineteen_a : NinePairCheck 19 9 57 112 := by
  intro P D hD hDP hcop hraw hne
  have hmem := nine_pair_membership_nineteen_a P D hD hDP hcop hraw hne
  simp only [mem_insert,mem_singleton,Prod.mk.injEq] at hmem
  rcases hmem with ⟨hP,hD⟩ | ⟨hP,hD⟩ | ⟨hP,hD⟩ | ⟨hP,hD⟩ | ⟨hP,hD⟩ | ⟨hP,hD⟩ | ⟨hP,hD⟩ | ⟨hP,hD⟩ | ⟨hP,hD⟩
  · norm_num only [hP,hD,Nat.lcm]
    exact nine_pair_nineteen_a_4_3
  · norm_num only [hP,hD,Nat.lcm]
    exact nine_pair_nineteen_a_7_3
  · norm_num only [hP,hD,Nat.lcm]
    exact nine_pair_nineteen_a_7_6
  · norm_num only [hP,hD,Nat.lcm]
    exact nine_pair_nineteen_a_10_9
  · norm_num only [hP,hD,Nat.lcm]
    exact nine_pair_nineteen_a_11_9
  · norm_num only [hP,hD,Nat.lcm]
    exact nine_pair_nineteen_a_19_18
  · norm_num only [hP,hD,Nat.lcm]
    exact nine_pair_nineteen_a_20_9
  · norm_num only [hP,hD,Nat.lcm]
    exact nine_pair_nineteen_a_28_9
  · norm_num only [hP,hD,Nat.lcm]
    exact nine_pair_nineteen_a_28_27

set_option Elab.async false in
set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
private theorem nine_pair_nineteen_b_4_3 :
    57 * nineRemainderCount 76 57 72 < 112*76 := by
  decide

set_option Elab.async false in
set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
private theorem nine_pair_nineteen_b_7_3 :
    57 * nineRemainderCount 133 57 126 < 112*133 := by
  decide

set_option Elab.async false in
set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
private theorem nine_pair_nineteen_b_7_6 :
    57 * nineRemainderCount 133 114 126 < 112*133 := by
  decide

set_option Elab.async false in
set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
private theorem nine_pair_nineteen_b_10_9 :
    57 * nineRemainderCount 190 171 180 < 112*190 := by
  decide

set_option Elab.async false in
set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
private theorem nine_pair_nineteen_b_11_9 :
    57 * nineRemainderCount 209 171 198 < 112*209 := by
  decide

set_option Elab.async false in
set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
private theorem nine_pair_nineteen_b_19_9 :
    57 * nineRemainderCount 19 9 18 < 112*19 := by
  decide

set_option Elab.async false in
set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
private theorem nine_pair_nineteen_b_20_9 :
    57 * nineRemainderCount 380 171 360 < 112*380 := by
  decide

set_option Elab.async false in
set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
private theorem nine_pair_nineteen_b_28_9 :
    57 * nineRemainderCount 532 171 504 < 112*532 := by
  decide

set_option Elab.async false in
set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
private theorem nine_pair_nineteen_b_28_27 :
    57 * nineRemainderCount 532 513 504 < 112*532 := by
  decide

set_option Elab.async false in
set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
private theorem nine_pair_membership_nineteen_b :
    NinePairMembership 19 18 57 112
      {(4,3), (7,3), (7,6), (10,9), (11,9), (19,9), (20,9), (28,9), (28,27)} := by
  unfold NinePairMembership
  decide

private theorem nine_pair_check_nineteen_b : NinePairCheck 19 18 57 112 := by
  intro P D hD hDP hcop hraw hne
  have hmem := nine_pair_membership_nineteen_b P D hD hDP hcop hraw hne
  simp only [mem_insert,mem_singleton,Prod.mk.injEq] at hmem
  rcases hmem with ⟨hP,hD⟩ | ⟨hP,hD⟩ | ⟨hP,hD⟩ | ⟨hP,hD⟩ | ⟨hP,hD⟩ | ⟨hP,hD⟩ | ⟨hP,hD⟩ | ⟨hP,hD⟩ | ⟨hP,hD⟩
  · norm_num only [hP,hD,Nat.lcm]
    exact nine_pair_nineteen_b_4_3
  · norm_num only [hP,hD,Nat.lcm]
    exact nine_pair_nineteen_b_7_3
  · norm_num only [hP,hD,Nat.lcm]
    exact nine_pair_nineteen_b_7_6
  · norm_num only [hP,hD,Nat.lcm]
    exact nine_pair_nineteen_b_10_9
  · norm_num only [hP,hD,Nat.lcm]
    exact nine_pair_nineteen_b_11_9
  · norm_num only [hP,hD,Nat.lcm]
    exact nine_pair_nineteen_b_19_9
  · norm_num only [hP,hD,Nat.lcm]
    exact nine_pair_nineteen_b_20_9
  · norm_num only [hP,hD,Nat.lcm]
    exact nine_pair_nineteen_b_28_9
  · norm_num only [hP,hD,Nat.lcm]
    exact nine_pair_nineteen_b_28_27

private theorem nine_star_remainder (p d s S Ds u v : Nat)
    (hd : 0 < d) (hdp : d < p) (hne : d ≠ s) (hS : 0 < S)
    (hSp : S ∣ p) (hstar : S*s = Ds*p)
    (hbudget : NineBudget u v) (hcheck : NinePairCheck S Ds u v) :
    u * (pivotBadResidues 9 p d \ pivotBadResidues 9 p s).card < v*p := by
  obtain ⟨h,P,D,hh,hD,hDP,hpP,hdD,hcop,hk,hcard⟩ := nine_normalize p d hd hdp
  by_cases hraw : v*P ≤ u*normalizedBadCount 9 (Nat.gcd D 9) P
  · have hcap := nine_exception_cap P D u v (by omega) hk hbudget hraw
    have hslope : S*D ≠ Ds*P := by
      intro heq
      apply hne
      apply Nat.mul_left_cancel hS
      calc
        S*d = h*(S*D) := by rw [hdD]; ring
        _ = h*(Ds*P) := by rw [heq]
        _ = Ds*p := by rw [hpP]; ring
        _ = S*s := hstar.symm
    have hbase := hcheck ⟨P,hcap⟩ ⟨D,by omega⟩ hD hDP hcop hraw hslope
    rw [nine_remainder_count_eq] at hbase
    exact nine_pair_lift p d s h P D S Ds u v hh (by omega) hS hpP hdD hSp hstar hbase
  · have hmul := Nat.mul_lt_mul_of_pos_left (Nat.lt_of_not_ge hraw) hh
    have hactual : u * (pivotBadResidues 9 p d).card < v*p := by
      rw [hcard,hpP]
      simpa [mul_assoc,mul_left_comm,mul_comm] using hmul
    exact (Nat.mul_le_mul_left u (card_le_card sdiff_subset)).trans_lt hactual

private theorem nine_star_count (p s S Ds B : Nat) (hp : 0 < p) (hS : 0 < S)
    (hSp : S ∣ p) (hstar : S*s = Ds*p) (hbase : (pivotBadResidues 9 S Ds).card = B) :
    S*(pivotBadResidues 9 p s).card = B*p := by
  let t := p / S
  have hpt : p = t*S := (Nat.div_mul_cancel hSp).symm
  have ht : 0 < t := by nlinarith
  have hs : s = t*Ds := by
    apply Nat.mul_left_cancel hS
    calc
      S*s = Ds*p := hstar
      _ = S*(t*Ds) := by rw [hpt]; ring
  rw [hpt,hs,nine_row_scale S Ds t hS ht,hbase]
  ring

set_option maxRecDepth 10000 in
private theorem nine_star_base_counts :
    (pivotBadResidues 9 10 9).card = 24 ∧
    (pivotBadResidues 9 11 9).card = 24 ∧
    (pivotBadResidues 9 19 9).card = 40 ∧
    (pivotBadResidues 9 19 18).card = 40 := by
  decide

/-- Each actual star supplies its exact density and a compatible strict
budget for every other original lower owner. -/
private theorem nine_star_budget (p s : Nat) (hp : 0 < p) (hstar : NineStar p s) :
    ∃ u v : Nat, 0 < u ∧
      u*(pivotBadResidues 9 p s).card + 3*v*p = 8*u*p ∧
      ∀ d : Nat, 0 < d → d < p → d ≠ s →
        u*(pivotBadResidues 9 p d \ pivotBadResidues 9 p s).card < v*p := by
  obtain ⟨b10,b11,b19a,b19b⟩ := nine_star_base_counts
  rcases hstar with hstar | hstar | hstar | hstar
  · have hSp : 10 ∣ p := by omega
    have hc := nine_star_count p s 10 9 24 hp (by omega) hSp hstar b10
    refine ⟨15,28,by omega,by omega,?_⟩
    intro d hd hdp hne
    exact nine_star_remainder p d s 10 9 15 28 hd hdp hne (by omega) hSp hstar
      (Or.inl ⟨rfl,rfl⟩) nine_pair_check_ten
  · have hSp : 11 ∣ p := by omega
    have hc := nine_star_count p s 11 9 24 hp (by omega) hSp hstar b11
    refine ⟨33,64,by omega,by omega,?_⟩
    intro d hd hdp hne
    exact nine_star_remainder p d s 11 9 33 64 hd hdp hne (by omega) hSp hstar
      (Or.inr (Or.inl ⟨rfl,rfl⟩)) nine_pair_check_eleven
  · have hSp : 19 ∣ p := by omega
    have hc := nine_star_count p s 19 9 40 hp (by omega) hSp hstar b19a
    refine ⟨57,112,by omega,by omega,?_⟩
    intro d hd hdp hne
    exact nine_star_remainder p d s 19 9 57 112 hd hdp hne (by omega) hSp hstar
      (Or.inr (Or.inr ⟨rfl,rfl⟩)) nine_pair_check_nineteen_a
  · have hSp : 19 ∣ p := by omega
    have hc := nine_star_count p s 19 18 40 hp (by omega) hSp hstar b19b
    refine ⟨57,112,by omega,by omega,?_⟩
    intro d hd hdp hne
    exact nine_star_remainder p d s 19 18 57 112 hd hdp hne (by omega) hSp hstar
      (Or.inr (Or.inr ⟨rfl,rfl⟩)) nine_pair_check_nineteen_b

private theorem nine_four_union_remainder_bound (A B C S : Finset Nat) :
    (A ∪ B ∪ C ∪ S).card ≤
      S.card + (A \ S).card + (B \ S).card + (C \ S).card := by
  have heq : A ∪ B ∪ C ∪ S = S ∪ (A \ S) ∪ (B \ S) ∪ (C \ S) := by
    ext r
    simp only [mem_union,mem_sdiff]
    tauto
  rw [heq]
  have h1 := card_union_le S (A \ S)
  have h2 := card_union_le (S ∪ (A \ S)) (B \ S)
  have h3 := card_union_le (S ∪ (A \ S) ∪ (B \ S)) (C \ S)
  omega

private theorem nine_four_union_with_star (p a b c s : Nat)
    (ha : 0 < a) (hap : a < p) (hb : 0 < b) (hbp : b < p)
    (hc : 0 < c) (hcp : c < p) (has : a ≠ s) (hbs : b ≠ s) (hcs : c ≠ s)
    (hstar : NineStar p s) :
    (pivotBadResidues 9 p a ∪ pivotBadResidues 9 p b ∪
      pivotBadResidues 9 p c ∪ pivotBadResidues 9 p s).card < 8*p := by
  obtain ⟨u,v,hu,hrow,hrem⟩ := nine_star_budget p s (by omega) hstar
  have hA := hrem a ha hap has
  have hB := hrem b hb hbp hbs
  have hC := hrem c hc hcp hcs
  have hsum := nine_four_union_remainder_bound (pivotBadResidues 9 p a)
    (pivotBadResidues 9 p b) (pivotBadResidues 9 p c) (pivotBadResidues 9 p s)
  have hmul := Nat.mul_le_mul_left u hsum
  apply (Nat.mul_lt_mul_left hu).mp
  nlinarith

private theorem nine_one_bad (p d : Nat) (hd : 0 < d) (hdp : d < p) :
    1 ∈ pivotBadResidues 9 p d := by
  apply mem_pivotBadResidues.mpr
  refine ⟨mem_pivotCandidates.mpr ⟨by omega,by decide⟩,?_⟩
  have hdM : d < 9*p := by omega
  simp only [cyclicResidueDistance,one_mul,Nat.mod_eq_of_lt hdM]
  exact (min_le_left _ _).trans_lt hdp

private theorem nine_four_union_lt (p a b c d : Nat)
    (ha : 0 < a) (hab : a < b) (hbc : b < c) (hcd : c < d) (hdp : d < p) :
    (pivotBadResidues 9 p a ∪ pivotBadResidues 9 p b ∪
      pivotBadResidues 9 p c ∪ pivotBadResidues 9 p d).card < 8*p := by
  classical
  by_cases hstarD : NineStar p d
  · exact nine_four_union_with_star p a b c d ha (by omega) (by omega) (by omega)
      (by omega) (by omega) (by omega) (by omega) (by omega) hstarD
  by_cases hstarC : NineStar p c
  · have h := nine_four_union_with_star p a b d c ha (by omega) (by omega) (by omega)
      (by omega) hdp (by omega) (by omega) (by omega) hstarC
    simpa [union_assoc,union_comm,union_left_comm] using h
  by_cases hstarB : NineStar p b
  · have h := nine_four_union_with_star p a c d b ha (by omega) (by omega) (by omega)
      (by omega) hdp (by omega) (by omega) (by omega) hstarB
    simpa [union_assoc,union_comm,union_left_comm] using h
  by_cases hstarA : NineStar p a
  · have h := nine_four_union_with_star p b c d a (by omega) (by omega) (by omega)
      (by omega) (by omega) hdp (by omega) (by omega) (by omega) hstarA
    simpa [union_assoc,union_comm,union_left_comm] using h
  have hA := nine_row_le_two p a ha (by omega) hstarA
  have hB := nine_row_le_two p b (by omega) (by omega) hstarB
  have hC := nine_row_le_two p c (by omega) (by omega) hstarC
  have hD := nine_row_le_two p d (by omega) hdp hstarD
  have hcommon : 0 < (pivotBadResidues 9 p a ∩ pivotBadResidues 9 p b).card := by
    apply card_pos.mpr
    exact ⟨1,mem_inter.mpr ⟨nine_one_bad p a ha (by omega),
      nine_one_bad p b (by omega) (by omega)⟩⟩
  have h1 := card_union_add_card_inter (pivotBadResidues 9 p a) (pivotBadResidues 9 p b)
  have h2 := card_union_le (pivotBadResidues 9 p a ∪ pivotBadResidues 9 p b)
    (pivotBadResidues 9 p c)
  have h3 := card_union_le (pivotBadResidues 9 p a ∪ pivotBadResidues 9 p b ∪
    pivotBadResidues 9 p c) (pivotBadResidues 9 p d)
  omega

/-- Four distinct genuine lower speeds cannot cover a denominator-nine
pivot row, at any positive pivot height and with the closed good boundary. -/
theorem fourLowerOwner_noncover_nine (p a b c d : Nat)
    (ha : 0 < a) (hab : a < b) (hbc : b < c) (hcd : c < d) (hdp : d < p) :
    ∃ r ∈ pivotCandidates 9 p,
      r ∉ pivotBadResidues 9 p a ∧ r ∉ pivotBadResidues 9 p b ∧
      r ∉ pivotBadResidues 9 p c ∧ r ∉ pivotBadResidues 9 p d := by
  let U := pivotBadResidues 9 p a ∪ pivotBadResidues 9 p b ∪
    pivotBadResidues 9 p c ∪ pivotBadResidues 9 p d
  have hsub : U ⊆ pivotCandidates 9 p :=
    union_subset (union_subset (union_subset (pivotBadResidues_subset 9 p a)
      (pivotBadResidues_subset 9 p b)) (pivotBadResidues_subset 9 p c))
      (pivotBadResidues_subset 9 p d)
  have hsmall : U.card < (pivotCandidates 9 p).card := by
    rw [card_pivotCandidates 9 p (by omega)]
    exact nine_four_union_lt p a b c d ha hab hbc hcd hdp
  have hnonempty : (pivotCandidates 9 p \ U).Nonempty := by
    apply card_pos.mp
    rw [card_sdiff_of_subset hsub]
    omega
  obtain ⟨r,hr⟩ := hnonempty
  rcases mem_sdiff.mp hr with ⟨hr,havoid⟩
  refine ⟨r,hr,?_,?_,?_,?_⟩ <;> intro hbad <;> apply havoid
  · exact mem_union_left _ (mem_union_left _ (mem_union_left _ hbad))
  · exact mem_union_left _ (mem_union_left _ (mem_union_right _ hbad))
  · exact mem_union_left _ (mem_union_right _ hbad)
  · exact mem_union_right _ hbad

/-- The same canonical residue gives a common closed circle-distance witness
for the actual pivot and precisely the four listed lower owners. -/
theorem fourLowerOwner_circleNorm_witness_nine (p a b c d : Nat)
    (ha : 0 < a) (hab : a < b) (hbc : b < c) (hcd : c < d) (hdp : d < p) :
    ∃ r ∈ pivotCandidates 9 p,
      (9 : ℝ)⁻¹ ≤ circleNorm (((r : ℝ) / ((9*p : Nat) : ℝ)) * (p : ℝ)) ∧
      (9 : ℝ)⁻¹ ≤ circleNorm (((r : ℝ) / ((9*p : Nat) : ℝ)) * (a : ℝ)) ∧
      (9 : ℝ)⁻¹ ≤ circleNorm (((r : ℝ) / ((9*p : Nat) : ℝ)) * (b : ℝ)) ∧
      (9 : ℝ)⁻¹ ≤ circleNorm (((r : ℝ) / ((9*p : Nat) : ℝ)) * (c : ℝ)) ∧
      (9 : ℝ)⁻¹ ≤ circleNorm (((r : ℝ) / ((9*p : Nat) : ℝ)) * (d : ℝ)) := by
  obtain ⟨r,hr,ha',hb',hc',hd'⟩ := fourLowerOwner_noncover_nine p a b c d ha hab hbc hcd hdp
  exact ⟨r,hr,pivot_circleNorm_ge (N := 9) (pivot := p) (by omega) (by omega) hr,
    outside_pivotBadResidues_circleNorm_ge (N := 9) (pivot := p) (by omega) (by omega) hr ha',
    outside_pivotBadResidues_circleNorm_ge (N := 9) (pivot := p) (by omega) (by omega) hr hb',
    outside_pivotBadResidues_circleNorm_ge (N := 9) (pivot := p) (by omega) (by omega) hr hc',
    outside_pivotBadResidues_circleNorm_ge (N := 9) (pivot := p) (by omega) (by omega) hr hd'⟩

end LonelyRunner
