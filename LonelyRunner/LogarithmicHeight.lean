import Mathlib.Data.Nat.Log
import Mathlib.Data.Nat.Totient
import Mathlib.NumberTheory.ArithmeticFunction.Misc
import Mathlib.Tactic
import LonelyRunner.BoundedHeight

/-!
Arithmetic interfaces for the logarithmic bounded-height argument.

This file proves the elementary `omega(c) ≤ log₂(c)` component, the sharp
totient product estimate, and the short-interval coprime selector. It also
exposes the exact interface needed to reuse the kernel-checked two-hole
denominator theorem.
-/

open scoped ArithmeticFunction.omega
open Finset

namespace LonelyRunner

/-- The arithmetic-function count of distinct prime factors agrees with the
cardinality of `Nat.primeFactors`. -/
theorem cardDistinctFactors_eq_primeFactors_card (c : Nat) :
    ArithmeticFunction.cardDistinctFactors c = c.primeFactors.card := by
  rw [ArithmeticFunction.cardDistinctFactors_apply]
  rw [← List.toFinset_card_of_nodup (List.nodup_dedup c.primeFactorsList)]
  congr 1
  rw [← Nat.toFinset_factors c]
  ext p
  simp

/-- The product of the distinct prime divisors gives the elementary bound
`2 ^ omega(c) ≤ c` for nonzero `c`. -/
theorem two_pow_cardDistinctFactors_le (c : Nat) (hc : c ≠ 0) :
    2 ^ ArithmeticFunction.cardDistinctFactors c ≤ c := by
  rw [cardDistinctFactors_eq_primeFactors_card]
  exact (Finset.pow_card_le_prod c.primeFactors id 2 fun p hp =>
      (Nat.prime_of_mem_primeFactors hp).two_le).trans
    (Nat.le_of_dvd (Nat.pos_of_ne_zero hc) (Nat.prod_primeFactors_dvd c))

/-- The number of distinct prime factors of a nonzero natural is at most its
base-two natural logarithm. -/
theorem cardDistinctFactors_le_log_two (c : Nat) (hc : c ≠ 0) :
    ArithmeticFunction.cardDistinctFactors c ≤ Nat.log 2 c := by
  apply Nat.le_log_of_pow_le (by omega)
  exact two_pow_cardDistinctFactors_le c hc

/-- For a finite set of integers at least two, removing the maximum gives the
telescoping product inequality used for the distinct prime factors. -/
theorem prod_le_card_succ_mul_prod_pred (s : Finset Nat)
    (hmin : ∀ x ∈ s, 2 ≤ x) :
    (∏ x ∈ s, x) ≤ (s.card + 1) * ∏ x ∈ s, (x - 1) := by
  classical
  refine Finset.strongInduction (p := fun s : Finset Nat =>
    (∀ x ∈ s, 2 ≤ x) →
      (∏ x ∈ s, x) ≤ (s.card + 1) * ∏ x ∈ s, (x - 1)) ?_ s hmin
  intro s ih hmin
  by_cases hs : s = ∅
  · simp [hs]
  have hsne : s.Nonempty := Finset.nonempty_iff_ne_empty.mpr hs
  let m := s.max' hsne
  let r := s.erase m
  have hm : m ∈ s := by simpa [m] using Finset.max'_mem s hsne
  have hrss : r ⊂ s := by simpa [r] using Finset.erase_ssubset hm
  have hminr : ∀ x ∈ r, 2 ≤ x := by
    intro x hx
    exact hmin x (Finset.mem_of_mem_erase hx)
  have hIH := ih r hrss hminr
  have hrsub : r ⊆ Finset.Ico 2 m := by
    intro x hx
    have hxerase := Finset.mem_erase.mp hx
    have hxle : x ≤ m := Finset.le_max' s x hxerase.2
    exact Finset.mem_Ico.mpr
      ⟨hmin x hxerase.2, lt_of_le_of_ne hxle hxerase.1⟩
  have hcard : r.card ≤ m - 2 := by
    have := Finset.card_le_card hrsub
    simpa [Nat.card_Ico] using this
  have hm2 : 2 ≤ m := hmin m hm
  have hcardm : r.card + 2 ≤ m := by omega
  have hcard_s : s.card = r.card + 1 := by
    have herase := Finset.card_erase_of_mem hm
    change r.card = s.card - 1 at herase
    have hscardpos : 0 < s.card := Finset.card_pos.mpr hsne
    omega
  have hfactor : (r.card + 1) * m ≤ (r.card + 2) * (m - 1) := by
    obtain ⟨d, hd⟩ := Nat.exists_eq_add_of_le hcardm
    have hsub : r.card + 2 + d - 1 = r.card + 1 + d := by omega
    rw [hd, hsub]
    nlinarith
  have hprod : (∏ x ∈ r, x) * m = ∏ x ∈ s, x := by
    simpa [r] using Finset.prod_erase_mul s (fun x : Nat => x) hm
  have hprodPred :
      (∏ x ∈ r, (x - 1)) * (m - 1) = ∏ x ∈ s, (x - 1) := by
    simpa [r] using Finset.prod_erase_mul s (fun x : Nat => x - 1) hm
  calc
    (∏ x ∈ s, x) = (∏ x ∈ r, x) * m := hprod.symm
    _ ≤ ((r.card + 1) * ∏ x ∈ r, (x - 1)) * m :=
      Nat.mul_le_mul_right m hIH
    _ = (∏ x ∈ r, (x - 1)) * ((r.card + 1) * m) := by ring
    _ ≤ (∏ x ∈ r, (x - 1)) * ((r.card + 2) * (m - 1)) :=
      Nat.mul_le_mul_left _ hfactor
    _ = (s.card + 1) * ((∏ x ∈ r, (x - 1)) * (m - 1)) := by
      rw [hcard_s]
      ring
    _ = (s.card + 1) * ∏ x ∈ s, (x - 1) := by rw [hprodPred]

/-- The sharp elementary totient estimate
`c ≤ (omega(c)+1) * phi(c)`, including the degenerate value `c=0`. -/
theorem le_cardDistinctFactors_succ_mul_totient (c : Nat) :
    c ≤ (ArithmeticFunction.cardDistinctFactors c + 1) * c.totient := by
  let R := ∏ p ∈ c.primeFactors, p
  let Q := ∏ p ∈ c.primeFactors, (p - 1)
  have hR : R ≤ (c.primeFactors.card + 1) * Q := by
    apply prod_le_card_succ_mul_prod_pred
    intro p hp
    exact (Nat.prime_of_mem_primeFactors hp).two_le
  have hRd : R ∣ c := by
    simpa [R] using Nat.prod_primeFactors_dvd c
  have htot : c.totient = (c / R) * Q := by
    simpa [R, Q] using Nat.totient_eq_div_primeFactors_mul c
  calc
    c = (c / R) * R := (Nat.div_mul_cancel hRd).symm
    _ ≤ (c / R) * ((c.primeFactors.card + 1) * Q) :=
      Nat.mul_le_mul_left (c / R) hR
    _ = (ArithmeticFunction.cardDistinctFactors c + 1) * c.totient := by
      rw [htot, cardDistinctFactors_eq_primeFactors_card]
      ring

/-- The logarithmic version of the sharp totient estimate. -/
theorem le_log_succ_mul_totient (c : Nat) (hc : c ≠ 0) :
    c ≤ (Nat.log 2 c + 1) * c.totient := by
  calc
    c ≤ (ArithmeticFunction.cardDistinctFactors c + 1) * c.totient :=
      le_cardDistinctFactors_succ_mul_totient c
    _ ≤ (Nat.log 2 c + 1) * c.totient :=
      Nat.mul_le_mul_right c.totient
        (Nat.add_le_add_right (cardDistinctFactors_le_log_two c hc) 1)

/-- A short initial segment of a complete residue period contains a coprime
integer whenever the omitted tail is smaller than `phi(c)`. -/
theorem exists_coprime_in_Ico_of_complement_lt_totient
    {c start ell : Nat} (hellc : ell < c)
    (hphi : c - ell < c.totient) :
    ∃ q, q ∈ Finset.Ico start (start + ell) ∧ c.Coprime q := by
  by_contra hnone
  push_neg at hnone
  have hsubset :
      (Finset.Ico start (start + c)).filter (c.Coprime ·) ⊆
        Finset.Ico (start + ell) (start + c) := by
    intro q hq
    have hqFull : start ≤ q ∧ q < start + c :=
      Finset.mem_Ico.mp (Finset.mem_of_mem_filter hq)
    have hqCoprime : c.Coprime q := (Finset.mem_filter.mp hq).2
    apply Finset.mem_Ico.mpr
    constructor
    · by_contra hqLower
      have hqShort : q ∈ Finset.Ico start (start + ell) :=
        Finset.mem_Ico.mpr ⟨hqFull.1, by omega⟩
      exact hnone q hqShort hqCoprime
    · exact hqFull.2
  have hcard := Finset.card_le_card hsubset
  rw [Nat.filter_coprime_Ico_eq_totient, Nat.card_Ico] at hcard
  omega

/-- A selector producing a coprime `q > H+c` automatically places both
omitted residues, `c` and `q-c`, above or outside the selected speed family.
This packages the interface to `twoHoleDenominator_family_witness`. -/
theorem twoHole_witness_of_coprime_modulus_above_height
    {n N H c : Nat} (speeds : Fin n → Nat)
    (hN : 0 < N) (hc : 0 < c)
    (hpos : ∀ i, 0 < speeds i) (hbound : ∀ i, speeds i ≤ H)
    (hmissc : ∀ i, speeds i ≠ c)
    (hsel : ∃ q : Nat, N < q ∧ q ≤ 2 * N ∧ H + c < q ∧ c.Coprime q) :
    ∃ t : Real, ∀ i, (N : Real)⁻¹ ≤ circleNorm (t * (speeds i : Real)) := by
  obtain ⟨q, hNq, hq2N, hHcq, hcoprime⟩ := hsel
  apply twoHoleDenominator_family_witness speeds hN hc
    (q := q) (by omega) hNq hq2N hcoprime hpos
  · intro i
    have := hbound i
    omega
  · exact hmissc
  · intro i hi
    have := hbound i
    omega

end LonelyRunner
