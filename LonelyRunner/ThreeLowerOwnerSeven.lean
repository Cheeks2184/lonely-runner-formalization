import LonelyRunner.ThreeOwnerSevenArithmetic
import LonelyRunner.PeriodicPivotCounts
import LonelyRunner.Prompt99Scaling

/-!
# Three genuine lower owners at denominator seven

This file translates the independently reviewed arbitrary-height argument.
The only exceptional normalized owner is 7/8 of the pivot. Its overlaps are
reduced by common scaling to six literal finite rows; all other steps use
uniform normalized counts and finite-set cardinality inequalities.
-/

namespace LonelyRunner

open Finset

private theorem seven_normalize (p d : Nat) (hd : 0 < d) (hdp : d < p) :
    ∃ h P D : Nat, 0 < h ∧ 0 < D ∧ D < P ∧
      p = h * P ∧ d = h * D ∧ Nat.Coprime D P ∧
      (Nat.gcd D 7 = 1 ∨ Nat.gcd D 7 = 7) ∧
      (pivotBadResidues 7 p d).card = h * normalizedBadCount 7 (Nat.gcd D 7) P := by
  let h := Nat.gcd d p
  let P := p / h
  let D := d / h
  have hh : 0 < h := Nat.gcd_pos_of_pos_left p hd
  have hpP : p = h * P := by
    exact (Nat.mul_div_cancel' (Nat.gcd_dvd_right d p)).symm
  have hdD : d = h * D := by
    exact (Nat.mul_div_cancel' (Nat.gcd_dvd_left d p)).symm
  have hD : 0 < D := by nlinarith [Nat.zero_le h]
  have hDP : D < P := by nlinarith
  have hcop : Nat.Coprime D P := Nat.coprime_div_gcd_div_gcd hh
  have hk : Nat.gcd D 7 = 1 ∨ Nat.gcd D 7 = 7 := by
    exact (by norm_num : Nat.Prime 7).eq_one_or_self_of_dvd _ (Nat.gcd_dvd_right D 7)
  refine ⟨h, P, D, hh, hD, hDP, hpP, hdD, hcop, hk, ?_⟩
  exact card_pivotBadResidues_normalized 7 p d h P D (Nat.gcd D 7)
    (by omega) (by omega) hd hdp rfl hpP hdD hcop rfl

/-- Common scaling copies a literal difference of two bad rows exactly. -/
private theorem seven_difference_scale (p d s t : Nat) (hp : 0 < p) (ht : 0 < t) :
    (pivotBadResidues 7 (t*p) (t*d) \ pivotBadResidues 7 (t*p) (t*s)).card =
      t * (pivotBadResidues 7 p d \ pivotBadResidues 7 p s).card := by
  let S := pivotBadResidues 7 p d \ pivotBadResidues 7 p s
  have hS : S ⊆ range (7*p) := by
    intro r hr
    exact mem_range.mpr (mem_pivotCandidates.mp
      (pivotBadResidues_subset 7 p d (mem_sdiff.mp hr).1)).1
  have heq : pivotBadResidues 7 (t*p) (t*d) \ pivotBadResidues 7 (t*p) (t*s) =
      (range (t*(7*p))).filter (fun r => r % (7*p) ∈ S) := by
    ext r
    simp only [mem_sdiff, mem_filter, mem_range,
      mem_pivotBadResidues_scale_reduce_iff (by omega : 0 < 7) hp ht, S]
    tauto
  rw [heq]
  exact card_filter_range_mod_mem t (7*p) (by omega) S hS

private theorem seven_row_coarse (p d : Nat) (hd : 0 < d) (hdp : d < p) :
    4 * (pivotBadResidues 7 p d).card ≤ 9*p := by
  obtain ⟨h,P,D,hh,hD,hDP,hpP,hdD,hcop,hk,hcard⟩ := seven_normalize p d hd hdp
  rcases hk with hk | hk
  · have hb := normalizedBadCount_seven_one_bound P (by omega)
    rw [hk] at hcard
    nlinarith
  · have h7D : 7 ∣ D := by simpa [hk] using Nat.gcd_dvd_left D 7
    have h7 : 7 ≤ D := Nat.le_of_dvd hD h7D
    have hb := normalizedBadCount_seven_seven_bound P (by omega)
    rw [hk] at hcard
    nlinarith

private theorem seven_row_le_two (p d : Nat) (hd : 0 < d) (hdp : d < p)
    (hne : 8*d ≠ 7*p) : (pivotBadResidues 7 p d).card ≤ 2*p := by
  obtain ⟨h,P,D,hh,hD,hDP,hpP,hdD,hcop,hk,hcard⟩ := seven_normalize p d hd hdp
  rcases hk with hk | hk
  · have hb := normalizedBadCount_seven_one_bound P (by omega)
    rw [hk] at hcard
    nlinarith
  · have h7D : 7 ∣ D := by simpa [hk] using Nat.gcd_dvd_left D 7
    have h7 : 7 ≤ D := Nat.le_of_dvd hD h7D
    have hP8 : P ≠ 8 := by
      intro heq
      have hD7 : D = 7 := by omega
      apply hne
      rw [hpP, hdD, heq, hD7]
      ring
    have hb := normalizedBadCount_seven_seven_le_two P (by omega)
    rw [hk] at hcard
    nlinarith

private theorem seven_scaled_remainder_budget (p d s t : Nat)
    (hp : 0 < p) (ht : 0 < t)
    (hb : 8 * (pivotBadResidues 7 p d \ pivotBadResidues 7 p s).card < 15*p) :
    8 * (pivotBadResidues 7 (t*p) (t*d) \ pivotBadResidues 7 (t*p) (t*s)).card <
      15*(t*p) := by
  rw [seven_difference_scale p d s t hp ht]
  nlinarith

-- These are six closed finite calculations, checked by the kernel.  They
-- certify only the base rows; seven_difference_scale supplies every lift.
set_option maxRecDepth 10000 in
private theorem seven_base_remainder_budgets :
    8 * (pivotBadResidues 7 72 56 \ pivotBadResidues 7 72 63).card < 15*72 ∧
    8 * (pivotBadResidues 7 120 56 \ pivotBadResidues 7 120 105).card < 15*120 ∧
    8 * (pivotBadResidues 7 120 112 \ pivotBadResidues 7 120 105).card < 15*120 ∧
    8 * (pivotBadResidues 7 16 7 \ pivotBadResidues 7 16 14).card < 15*16 ∧
    8 * (pivotBadResidues 7 88 28 \ pivotBadResidues 7 88 77).card < 15*88 ∧
    8 * (pivotBadResidues 7 88 84 \ pivotBadResidues 7 88 77).card < 15*88 := by
  decide

private theorem seven_exception_remainder (P D h s : Nat)
    (hh : 0 < h) (hD : 0 < D) (hDP : D < P) (hcop : Nat.Coprime D P)
    (h7D : 7 ∣ D) (hstar : 8*s = 7*(h*P))
    (hex : P = 9 ∨ P = 15 ∨ P = 16 ∨ P = 22) :
    8 * (pivotBadResidues 7 (h*P) (h*D) \ pivotBadResidues 7 (h*P) s).card <
      15*(h*P) := by
  obtain ⟨b9,b15a,b15b,b16,b22a,b22b⟩ := seven_base_remainder_budgets
  rcases hex with rfl | rfl | rfl | rfl
  · have hDeq : D = 7 := by omega
    subst D
    have hh8 : 8 ∣ h := by omega
    obtain ⟨t,rfl⟩ := hh8
    have hs : s = t*63 := by omega
    rw [show 8*t*9 = t*72 by ring, show 8*t*7 = t*56 by ring, hs]
    exact seven_scaled_remainder_budget 72 56 63 t (by omega) (by omega) b9
  · have hDeq : D = 7 ∨ D = 14 := by omega
    have hh8 : 8 ∣ h := by omega
    obtain ⟨t,rfl⟩ := hh8
    have hs : s = t*105 := by omega
    rcases hDeq with rfl | rfl
    · rw [show 8*t*15 = t*120 by ring, show 8*t*7 = t*56 by ring, hs]
      exact seven_scaled_remainder_budget 120 56 105 t (by omega) (by omega) b15a
    · rw [show 8*t*15 = t*120 by ring, show 8*t*14 = t*112 by ring, hs]
      exact seven_scaled_remainder_budget 120 112 105 t (by omega) (by omega) b15b
  · have hDeq : D = 7 ∨ D = 14 := by omega
    rcases hDeq with rfl | rfl
    · have hs : s = h*14 := by omega
      rw [hs]
      exact seven_scaled_remainder_budget 16 7 14 h (by omega) hh b16
    · norm_num [Nat.Coprime] at hcop
  · have hDeq : D = 7 ∨ D = 14 ∨ D = 21 := by omega
    have hh4 : 4 ∣ h := by omega
    obtain ⟨t,rfl⟩ := hh4
    have hs : s = t*77 := by omega
    rcases hDeq with rfl | rfl | rfl
    · rw [show 4*t*22 = t*88 by ring, show 4*t*7 = t*28 by ring, hs]
      exact seven_scaled_remainder_budget 88 28 77 t (by omega) (by omega) b22a
    · norm_num [Nat.Coprime] at hcop
    · rw [show 4*t*22 = t*88 by ring, show 4*t*21 = t*84 by ring, hs]
      exact seven_scaled_remainder_budget 88 84 77 t (by omega) (by omega) b22b

/-- Every different owner leaves strictly less than the remaining half-budget
outside the exceptional 7/8 row. Kernel-one rows need no overlap estimate. -/
private theorem seven_star_remainder (p d s : Nat)
    (hd : 0 < d) (hdp : d < p) (hne : d ≠ s) (hstar : 8*s = 7*p) :
    8 * (pivotBadResidues 7 p d \ pivotBadResidues 7 p s).card < 15*p := by
  obtain ⟨h,P,D,hh,hD,hDP,hpP,hdD,hcop,hk,hcard⟩ := seven_normalize p d hd hdp
  have hsub : (pivotBadResidues 7 p d \ pivotBadResidues 7 p s).card ≤
      (pivotBadResidues 7 p d).card := card_le_card sdiff_subset
  rcases hk with hk | hk
  · have hb := normalizedBadCount_seven_one_bound P (by omega)
    rw [hk] at hcard
    nlinarith
  · have h7D : 7 ∣ D := by simpa [hk] using Nat.gcd_dvd_left D 7
    have h7 : 7 ≤ D := Nat.le_of_dvd hD h7D
    have hP8 : P ≠ 8 := by
      intro heq
      have hD7 : D = 7 := by omega
      apply hne
      nlinarith
    by_cases h9 : P = 9
    · rw [hpP, hdD]
      exact seven_exception_remainder P D h s hh hD hDP hcop h7D
        (by simpa [hpP] using hstar) (Or.inl h9)
    by_cases h15 : P = 15
    · rw [hpP, hdD]
      exact seven_exception_remainder P D h s hh hD hDP hcop h7D
        (by simpa [hpP] using hstar) (Or.inr (Or.inl h15))
    by_cases h16 : P = 16
    · rw [hpP, hdD]
      exact seven_exception_remainder P D h s hh hD hDP hcop h7D
        (by simpa [hpP] using hstar) (Or.inr (Or.inr (Or.inl h16)))
    by_cases h22 : P = 22
    · rw [hpP, hdD]
      exact seven_exception_remainder P D h s hh hD hDP hcop h7D
        (by simpa [hpP] using hstar) (Or.inr (Or.inr (Or.inr h22)))
    have hb := normalizedBadCount_seven_seven_lt_remainder_budget P
      (by omega) h9 h15 h16 h22
    rw [hk] at hcard
    nlinarith

private theorem seven_three_union_remainder_bound (A B S : Finset Nat) :
    (A ∪ B ∪ S).card ≤ S.card + (A \ S).card + (B \ S).card := by
  have heq : A ∪ B ∪ S = S ∪ (A \ S) ∪ (B \ S) := by
    ext r
    simp only [mem_union, mem_sdiff]
    tauto
  rw [heq]
  have h1 := card_union_le S (A \ S)
  have h2 := card_union_le (S ∪ (A \ S)) (B \ S)
  omega

private theorem seven_three_union_with_star (p a b s : Nat)
    (ha : 0 < a) (hap : a < p) (hb : 0 < b) (hbp : b < p)
    (hs : 0 < s) (hsp : s < p) (has : a ≠ s) (hbs : b ≠ s)
    (hstar : 8*s = 7*p) :
    (pivotBadResidues 7 p a ∪ pivotBadResidues 7 p b ∪
      pivotBadResidues 7 p s).card < 6*p := by
  have hrow := seven_row_coarse p s hs hsp
  have hremA := seven_star_remainder p a s ha hap has hstar
  have hremB := seven_star_remainder p b s hb hbp hbs hstar
  have hsum := seven_three_union_remainder_bound
    (pivotBadResidues 7 p a) (pivotBadResidues 7 p b) (pivotBadResidues 7 p s)
  omega

private theorem seven_one_bad (p d : Nat) (hd : 0 < d) (hdp : d < p) :
    1 ∈ pivotBadResidues 7 p d := by
  apply mem_pivotBadResidues.mpr
  refine ⟨mem_pivotCandidates.mpr ⟨by omega, by decide⟩, ?_⟩
  have hdM : d < 7*p := by omega
  simp only [cyclicResidueDistance, one_mul, Nat.mod_eq_of_lt hdM]
  exact (min_le_left _ _).trans_lt hdp

/-- The union is strictly smaller than the full candidate row. Distinctness
is used only to keep the exceptional owner from occurring twice. -/
private theorem seven_three_union_lt (p a b c : Nat)
    (ha : 0 < a) (hab : a < b) (hbc : b < c) (hcp : c < p) :
    (pivotBadResidues 7 p a ∪ pivotBadResidues 7 p b ∪
      pivotBadResidues 7 p c).card < 6*p := by
  by_cases hstarC : 8*c = 7*p
  · exact seven_three_union_with_star p a b c ha (by omega) (by omega)
      (by omega) (by omega) hcp (by omega) (by omega) hstarC
  by_cases hstarB : 8*b = 7*p
  · have h := seven_three_union_with_star p a c b ha (by omega) (by omega)
      hcp (by omega) (by omega) (by omega) (by omega) hstarB
    simpa [union_assoc, union_comm, union_left_comm] using h
  by_cases hstarA : 8*a = 7*p
  · have h := seven_three_union_with_star p b c a (by omega) (by omega)
      (by omega) hcp ha (by omega) (by omega) (by omega) hstarA
    simpa [union_assoc, union_comm, union_left_comm] using h
  have hA := seven_row_le_two p a ha (by omega) hstarA
  have hB := seven_row_le_two p b (by omega) (by omega) hstarB
  have hC := seven_row_le_two p c (by omega) hcp hstarC
  have hcommon : 0 < (pivotBadResidues 7 p a ∩ pivotBadResidues 7 p b).card := by
    apply card_pos.mpr
    exact ⟨1, mem_inter.mpr ⟨seven_one_bad p a ha (by omega),
      seven_one_bad p b (by omega) (by omega)⟩⟩
  have hfirst := card_union_add_card_inter (pivotBadResidues 7 p a)
    (pivotBadResidues 7 p b)
  have hlast := card_union_le (pivotBadResidues 7 p a ∪ pivotBadResidues 7 p b)
    (pivotBadResidues 7 p c)
  omega

/-- Three distinct genuine lower speeds cannot cover a denominator-seven
pivot row. The pivot is arbitrary and equality at the target band is safe. -/
theorem threeLowerOwner_noncover_seven (p a b c : Nat)
    (ha : 0 < a) (hab : a < b) (hbc : b < c) (hcp : c < p) :
    ∃ r ∈ pivotCandidates 7 p,
      r ∉ pivotBadResidues 7 p a ∧ r ∉ pivotBadResidues 7 p b ∧
        r ∉ pivotBadResidues 7 p c := by
  let U := pivotBadResidues 7 p a ∪ pivotBadResidues 7 p b ∪ pivotBadResidues 7 p c
  have hsub : U ⊆ pivotCandidates 7 p := by
    exact union_subset (union_subset (pivotBadResidues_subset 7 p a)
      (pivotBadResidues_subset 7 p b)) (pivotBadResidues_subset 7 p c)
  have hsmall : U.card < (pivotCandidates 7 p).card := by
    rw [card_pivotCandidates 7 p (by omega)]
    exact seven_three_union_lt p a b c ha hab hbc hcp
  have hnonempty : (pivotCandidates 7 p \ U).Nonempty := by
    apply card_pos.mp
    rw [card_sdiff_of_subset hsub]
    omega
  obtain ⟨r,hr⟩ := hnonempty
  rcases mem_sdiff.mp hr with ⟨hr, havoid⟩
  refine ⟨r,hr,?_,?_,?_⟩ <;> intro hbad <;> apply havoid
  · exact mem_union_left _ (mem_union_left _ hbad)
  · exact mem_union_left _ (mem_union_right _ hbad)
  · exact mem_union_right _ hbad

/-- The supplied residue is a common closed circle-distance witness for the
pivot and precisely the three listed lower owners. -/
theorem threeLowerOwner_circleNorm_witness_seven (p a b c : Nat)
    (ha : 0 < a) (hab : a < b) (hbc : b < c) (hcp : c < p) :
    ∃ r ∈ pivotCandidates 7 p,
      (7 : ℝ)⁻¹ ≤ circleNorm (((r : ℝ) / ((7*p : Nat) : ℝ)) * (p : ℝ)) ∧
      (7 : ℝ)⁻¹ ≤ circleNorm (((r : ℝ) / ((7*p : Nat) : ℝ)) * (a : ℝ)) ∧
      (7 : ℝ)⁻¹ ≤ circleNorm (((r : ℝ) / ((7*p : Nat) : ℝ)) * (b : ℝ)) ∧
      (7 : ℝ)⁻¹ ≤ circleNorm (((r : ℝ) / ((7*p : Nat) : ℝ)) * (c : ℝ)) := by
  obtain ⟨r,hr,ha',hb',hc'⟩ := threeLowerOwner_noncover_seven p a b c ha hab hbc hcp
  exact ⟨r,hr,pivot_circleNorm_ge (N := 7) (pivot := p) (by omega) (by omega) hr,
    outside_pivotBadResidues_circleNorm_ge (N := 7) (pivot := p) (by omega) (by omega) hr ha',
    outside_pivotBadResidues_circleNorm_ge (N := 7) (pivot := p) (by omega) (by omega) hr hb',
    outside_pivotBadResidues_circleNorm_ge (N := 7) (pivot := p) (by omega) (by omega) hr hc'⟩

end LonelyRunner
