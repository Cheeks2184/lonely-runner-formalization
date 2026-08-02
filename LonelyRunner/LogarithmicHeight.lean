import Mathlib.Data.Nat.Log
import Mathlib.Data.Nat.Totient
import Mathlib.NumberTheory.ArithmeticFunction.Misc
import Mathlib.Tactic
import LonelyRunner.BoundedHeight

/-!
Arithmetic interfaces for the logarithmic bounded-height argument.

This file proves the elementary `omega(c) ≤ log₂(c)` component and exposes
the exact selector interface needed to reuse the kernel-checked two-hole
denominator theorem.  The sharp totient estimate and the interval selector
remain separate proof obligations; no theorem here assumes either one
silently as part of a claimed Lonely Runner result.
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

/-- This conditional bridge records precisely where the still-unformalized
sharp inequality `c ≤ (omega(c)+1) * phi(c)` enters the logarithmic proof. -/
theorem log_totient_bound_of_cardDistinctFactors_totient_bound
    (c : Nat) (hc : c ≠ 0)
    (hsharp : c ≤ (ArithmeticFunction.cardDistinctFactors c + 1) * c.totient) :
    c ≤ (Nat.log 2 c + 1) * c.totient := by
  calc
    c ≤ (ArithmeticFunction.cardDistinctFactors c + 1) * c.totient := hsharp
    _ ≤ (Nat.log 2 c + 1) * c.totient :=
      Nat.mul_le_mul_right c.totient
        (Nat.add_le_add_right (cardDistinctFactors_le_log_two c hc) 1)

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
