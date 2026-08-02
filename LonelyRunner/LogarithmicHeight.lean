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
  push Not at hnone
  have hsubset :
      (Finset.Ico start (start + c)).filter (c.Coprime ·) ⊆
        Finset.Ico (start + ell) (start + c) := by
    intro q hq
    have hqFull : start ≤ q ∧ q < start + c :=
      Finset.mem_Ico.mp (Finset.mem_filter.mp hq).1
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

/-- Every complete interval of residues modulo a positive `c` contains an
integer coprime to `c`. -/
theorem exists_coprime_in_Ico_full_period {c start : Nat} (hc : 0 < c) :
    ∃ q, q ∈ Finset.Ico start (start + c) ∧ c.Coprime q := by
  have hcard :
      ((Finset.Ico start (start + c)).filter (c.Coprime ·)).card = c.totient :=
    Nat.filter_coprime_Ico_eq_totient c start
  have hpos : 0 < ((Finset.Ico start (start + c)).filter (c.Coprime ·)).card := by
    rw [hcard]
    exact Nat.totient_pos.mpr hc
  obtain ⟨q, hq⟩ := Finset.card_pos.mp hpos
  exact ⟨q, (Finset.mem_filter.mp hq).1, (Finset.mem_filter.mp hq).2⟩

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

/-- Elementary logarithmic bounded-height theorem. An injective family of
`n=N-1` positive integer speeds of height at most `N+t` is lonely whenever
`(4*(Nat.log 2 N+1)+1)*t ≤ N`. The conclusion uses the exact closed `1/N`
boundary. -/
theorem logarithmicHeight_family_witness
    {n N t : Nat} (speeds : Fin n → Nat)
    (hnN : n + 1 = N) (ht : 0 < t)
    (hpos : ∀ i, 0 < speeds i) (hinj : Function.Injective speeds)
    (hbound : ∀ i, speeds i ≤ N + t)
    (hgrowth : (4 * (Nat.log 2 N + 1) + 1) * t ≤ N) :
    ∃ tau : Real, ∀ i,
      (N : Real)⁻¹ ≤ circleNorm (tau * (speeds i : Real)) := by
  classical
  have hN5t : 5 * t ≤ N := by
    have hfive : 5 ≤ 4 * (Nat.log 2 N + 1) + 1 := by omega
    exact (Nat.mul_le_mul_right t hfive).trans hgrowth
  have hN : 0 < N := by omega
  let S : Finset Nat := Finset.univ.image speeds
  let U : Finset Nat := Finset.Icc 1 N
  have hcardS : S.card = n := by
    dsimp [S]
    rw [Finset.card_image_iff.mpr]
    · simp
    · intro i _ j _ hij
      exact hinj hij
  have hcardU : U.card = N := by
    dsimp [U]
    rw [Nat.card_Icc]
    omega
  have hnotSubset : ¬ U ⊆ S := by
    intro hsub
    have hcard := Finset.card_le_card hsub
    rw [hcardU, hcardS] at hcard
    omega
  obtain ⟨c, hcU, hcNotS⟩ := Finset.not_subset.mp hnotSubset
  have hcBounds : 0 < c ∧ c ≤ N := by
    have : c ∈ Finset.Icc 1 N := by simpa [U] using hcU
    have := Finset.mem_Icc.mp this
    omega
  have hmissc : ∀ i, speeds i ≠ c := by
    intro i heq
    apply hcNotS
    exact Finset.mem_image.mpr ⟨i, Finset.mem_univ i, heq⟩
  by_cases hrecip : N + t < 2 * c
  · apply smallDenominator_family_witness speeds hN hcBounds.1 hcBounds.2
    intro i hdiv
    rcases hdiv with ⟨k, hk⟩
    have hkpos : 0 < k := by
      by_contra hkzero
      have : k = 0 := by omega
      subst k
      simp at hk
      exact (Nat.ne_of_gt (hpos i)) hk
    have hkle : k = 1 := by
      by_contra hkone
      have hk2 : 2 ≤ k := by omega
      have hmul := Nat.mul_le_mul_left c hk2
      have hb := hbound i
      omega
    subst k
    apply hmissc i
    simpa using hk
  · have h2c : 2 * c ≤ N + t := by omega
    have hctlt : c + t < N := by omega
    let start := N + c + t + 1
    let ell := N - c - t
    have hellpos : 0 < ell := by
      dsimp [ell]
      omega
    have hsum : start + ell = 2 * N + 1 := by
      dsimp [start, ell]
      omega
    have hselector : ∃ q, q ∈ Finset.Ico start (start + ell) ∧ c.Coprime q := by
      by_cases hlong : c ≤ ell
      · obtain ⟨q, hq, hcop⟩ :=
          exists_coprime_in_Ico_full_period (start := start) hcBounds.1
        refine ⟨q, ?_, hcop⟩
        have hqm := Finset.mem_Ico.mp hq
        exact Finset.mem_Ico.mpr ⟨hqm.1, by omega⟩
      · have hellc : ell < c := by omega
        have hphi : c - ell < c.totient := by
          by_contra hnot
          have htotle : c.totient ≤ c - ell := by omega
          have hcomp : c - ell ≤ 2 * t := by
            dsimp [ell]
            omega
          have homegaN :
              ArithmeticFunction.cardDistinctFactors c ≤ Nat.log 2 N :=
            (cardDistinctFactors_le_log_two c (Nat.ne_of_gt hcBounds.1)).trans
              (Nat.log_mono_right hcBounds.2)
          have hcUpper : c ≤ (Nat.log 2 N + 1) * (2 * t) := by
            calc
              c ≤ (ArithmeticFunction.cardDistinctFactors c + 1) * c.totient :=
                le_cardDistinctFactors_succ_mul_totient c
              _ ≤ (Nat.log 2 N + 1) * (c - ell) :=
                Nat.mul_le_mul (Nat.add_le_add_right homegaN 1) htotle
              _ ≤ (Nat.log 2 N + 1) * (2 * t) :=
                Nat.mul_le_mul_left (Nat.log 2 N + 1) hcomp
          have hNlt : N < 2 * c + t := by
            dsimp [ell] at hellc
            omega
          have hupper :
              2 * c + t ≤ (4 * (Nat.log 2 N + 1) + 1) * t := by
            nlinarith
          omega
        exact exists_coprime_in_Ico_of_complement_lt_totient hellc hphi
    obtain ⟨q, hq, hcop⟩ := hselector
    have hqmem := Finset.mem_Ico.mp hq
    apply twoHole_witness_of_coprime_modulus_above_height
      speeds hN hcBounds.1 hpos hbound hmissc
    refine ⟨q, ?_, ?_, ?_, hcop⟩
    · dsimp [start] at hqmem
      omega
    · rw [hsum] at hqmem
      omega
    · dsimp [start] at hqmem
      omega

/-- Standard stationary-runner specialization of
`logarithmicHeight_family_witness`, with `N=n+1` visible in the statement. -/
theorem logarithmicHeight_stationary_witness
    {n t : Nat} (speeds : Fin n → Nat) (ht : 0 < t)
    (hpos : ∀ i, 0 < speeds i) (hinj : Function.Injective speeds)
    (hbound : ∀ i, speeds i ≤ n + 1 + t)
    (hgrowth : (4 * (Nat.log 2 (n + 1) + 1) + 1) * t ≤ n + 1) :
    ∃ tau : Real, ∀ i,
      (((n + 1 : Nat) : Real)⁻¹) ≤
        circleNorm (tau * (speeds i : Real)) := by
  exact logarithmicHeight_family_witness speeds rfl ht hpos hinj hbound hgrowth

end LonelyRunner
