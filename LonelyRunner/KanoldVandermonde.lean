import Mathlib.LinearAlgebra.Vandermonde
import LonelyRunner.KanoldHeight

/-!
Kanold's interval bound via a roots-of-unity filter and a Vandermonde system.

For a finite set `s` of distinct primes, expand the product
`prod p in s, (1 - zeta^(M/p*x))`, where `M` is their product. If every one
of `2^|s|` consecutive integers were divisible by a prime in `s`, this
product would vanish at `2^|s|` consecutive exponents. Its expansion has
`2^|s|` distinct characteristic roots and a nonzero coefficient, contrary
to the invertibility of the corresponding Vandermonde matrix.
-/

open Finset

namespace LonelyRunner

/-- The exponent attached to a subset in the roots-of-unity expansion. -/
def subsetExponent (s T : Finset Nat) : Nat :=
  ∑ p ∈ T, ∏ q ∈ s.erase p, q

/-- Distinct subsets of a finite prime set give distinct exponents modulo
the product of the primes. The proof isolates a prime in the symmetric
difference and reduces the two exponent sums modulo that prime. -/
theorem subsetExponent_mod_injective
    (s : Finset Nat) (hprime : ∀ p ∈ s, p.Prime) :
    Function.Injective fun T : ↥s.powerset ↦
      subsetExponent s T.1 % (∏ p ∈ s, p) := by
  classical
  intro T U hmod
  have mismatch_false : ∀ (A B : ↥s.powerset) (p : Nat),
      subsetExponent s A.1 % (∏ q ∈ s, q) =
        subsetExponent s B.1 % (∏ q ∈ s, q) →
      p ∈ A.1 → p ∉ B.1 → False := by
    intro A B p hAB hpA hpB
    have hpS : p ∈ s := Finset.mem_powerset.mp A.2 hpA
    have hpPrime : p.Prime := hprime p hpS
    letI : Fact p.Prime := ⟨hpPrime⟩
    have hpM : p ∣ ∏ q ∈ s, q := by
      exact Finset.dvd_prod_of_mem (fun q : Nat ↦ q) hpS
    have hModM : Nat.ModEq (∏ q ∈ s, q)
        (subsetExponent s A.1) (subsetExponent s B.1) := hAB
    have hModP : Nat.ModEq p (subsetExponent s A.1) (subsetExponent s B.1) :=
      Nat.ModEq.of_dvd hpM hModM
    have hcast : (subsetExponent s A.1 : ZMod p) =
        (subsetExponent s B.1 : ZMod p) :=
      (ZMod.natCast_eq_natCast_iff _ _ p).2 hModP
    have hterm_zero : ∀ q ∈ s, q ≠ p →
        (∏ x ∈ s.erase q, (x : ZMod p)) = 0 := by
      intro q hqS hqp
      apply Finset.prod_eq_zero (i := p)
      · exact Finset.mem_erase.mpr ⟨Ne.symm hqp, hpS⟩
      · exact ZMod.natCast_self p
    have hcastA : (subsetExponent s A.1 : ZMod p) =
        ↑(∏ x ∈ s.erase p, x) := by
      rw [subsetExponent]
      push_cast
      rw [Finset.sum_eq_single p]
      · intro q hqA hqp
        exact hterm_zero q (Finset.mem_powerset.mp A.2 hqA) hqp
      · intro hpnot
        exact (hpnot hpA).elim
    have hcastB : (subsetExponent s B.1 : ZMod p) = 0 := by
      rw [subsetExponent]
      push_cast
      apply Finset.sum_eq_zero
      intro q hqB
      exact hterm_zero q (Finset.mem_powerset.mp B.2 hqB) (by
        intro hqp
        subst q
        exact hpB hqB)
    have hprodzero : (↑(∏ x ∈ s.erase p, x) : ZMod p) = 0 := by
      rw [← hcastA, hcast, hcastB]
    push_cast at hprodzero
    obtain ⟨q, hq, hqzero⟩ := Finset.prod_eq_zero_iff.mp hprodzero
    have hqS : q ∈ s := Finset.mem_of_mem_erase hq
    have hqp : q ≠ p := (Finset.mem_erase.mp hq).1
    have hqPrime : q.Prime := hprime q hqS
    have hModQP : Nat.ModEq p q 0 :=
      (ZMod.natCast_eq_natCast_iff q 0 p).1 (by simpa using hqzero)
    have hpq : p ∣ q := by simpa [Nat.modEq_zero_iff_dvd] using hModQP
    exact hqp ((hqPrime.dvd_iff_eq hpPrime.ne_one).mp hpq)
  apply Subtype.ext
  apply Finset.ext
  intro p
  by_cases hpT : p ∈ T.1
  · by_cases hpU : p ∈ U.1
    · simp [hpT, hpU]
    · exact False.elim (mismatch_false T U p hmod hpT hpU)
  · by_cases hpU : p ∈ U.1
    · exact False.elim (mismatch_false U T p hmod.symm hpU hpT)
    · simp [hpT, hpU]

/-- A sum of `m` exponentials with distinct nodes and at least one nonzero
coefficient cannot vanish at all exponents `0, ..., m-1`. -/
theorem exponential_sum_not_vanish_consecutively
    {α : Type} [Fintype α] [DecidableEq α]
    (lam coeff : α → ℂ) (hlam : Function.Injective lam)
    (hcoeff : ∃ a, coeff a ≠ 0) :
    ¬ ∀ i : Fin (Fintype.card α),
      ∑ a : α, coeff a * lam a ^ (i : Nat) = 0 := by
  intro hzero
  let e : α ≃ Fin (Fintype.card α) := Fintype.equivFin α
  let f : Fin (Fintype.card α) → ℂ := fun j => lam (e.symm j)
  let v : Fin (Fintype.card α) → ℂ := fun j => coeff (e.symm j)
  have hf : Function.Injective f := hlam.comp e.symm.injective
  have hvzero : v = 0 := by
    apply Matrix.eq_zero_of_forall_pow_sum_mul_pow_eq_zero hf
    intro i
    dsimp [v, f]
    calc
      (∑ j, coeff (e.symm j) * lam (e.symm j) ^ (i : Nat)) =
          ∑ a, coeff a * lam a ^ (i : Nat) :=
        e.symm.sum_comp (fun a : α => coeff a * lam a ^ (i : Nat))
      _ = 0 := hzero i
  obtain ⟨a, ha⟩ := hcoeff
  have hz := congrFun hvzero (e a)
  simp [v] at hz
  exact ha hz

/-- A primitive root transfers injectivity of exponents modulo its order to
injectivity of the corresponding powers. -/
theorem primitiveRoot_subset_nodes_injective
    {α R : Type} [CommMonoid R] {M : Nat} {zeta : R}
    (hM : 0 < M) (hzeta : IsPrimitiveRoot zeta M)
    (exponent : α → Nat)
    (hexponent : ∀ a b, exponent a % M = exponent b % M → a = b) :
    Function.Injective (fun a => zeta ^ exponent a) := by
  have hpowmod : ∀ x : Nat, zeta ^ x = zeta ^ (x % M) := by
    intro x
    conv_lhs => rw [show x = M * (x / M) + x % M by
      simpa [Nat.add_comm] using (Nat.mod_add_div x M).symm]
    rw [pow_add, pow_mul, hzeta.pow_eq_one]
    simp
  intro a b hab
  apply hexponent a b
  apply hzeta.pow_inj (Nat.mod_lt _ hM) (Nat.mod_lt _ hM)
  rw [← hpowmod, ← hpowmod]
  exact hab

/-- Exact powerset expansion of the roots-of-unity product. -/
theorem roots_product_expansion (s : Finset Nat) (zeta : ℂ) (x : Nat) :
    (∏ p ∈ s, (1 - (zeta ^ (∏ q ∈ s.erase p, q)) ^ x)) =
      ∑ T ∈ s.powerset,
        ((-1 : ℂ) ^ T.card) * (zeta ^ subsetExponent s T) ^ x := by
  rw [Finset.prod_sub]
  simp only [Finset.prod_const_one, mul_one]
  apply Finset.sum_congr rfl
  intro T hT
  rw [Finset.prod_pow, Finset.prod_pow_eq_pow_sum]
  rfl

/-- If a selected prime divides `x`, its factor makes the roots-of-unity
product vanish. -/
theorem roots_product_eq_zero_of_dvd
    (s : Finset Nat) (p x : Nat) (hp : p ∈ s) (hpx : p ∣ x)
    (zeta : ℂ) (hzeta : IsPrimitiveRoot zeta (∏ q ∈ s, q)) :
    (∏ q ∈ s, (1 - (zeta ^ (∏ r ∈ s.erase q, r)) ^ x)) = 0 := by
  have hdiv : (∏ q ∈ s, q) ∣ (∏ r ∈ s.erase p, r) * x := by
    obtain ⟨k, rfl⟩ := hpx
    refine ⟨k, ?_⟩
    rw [← mul_assoc, Finset.prod_erase_mul s (fun q : Nat ↦ q) hp]
  apply Finset.prod_eq_zero hp
  rw [sub_eq_zero]
  rw [← pow_mul]
  exact ((hzeta.pow_eq_one_iff_dvd _).2 hdiv).symm

/-- Every interval of `2^|s|` consecutive natural numbers contains an
integer divisible by none of the distinct primes in `s`. -/
theorem exists_avoiding_prime_set
    (s : Finset Nat) (hprime : ∀ p ∈ s, p.Prime) (start : Nat) :
    ∃ x ∈ Finset.Ico start (start + 2 ^ s.card), ∀ p ∈ s, ¬ p ∣ x := by
  classical
  have hM : 0 < ∏ p ∈ s, p := by
    apply Finset.prod_pos
    intro p hp
    exact (hprime p hp).pos
  let zeta : ℂ := Complex.exp (2 * (Real.pi : ℂ) * Complex.I /
    ((∏ p ∈ s, p : Nat) : ℂ))
  have hzeta : IsPrimitiveRoot zeta (∏ p ∈ s, p) := by
    dsimp [zeta]
    exact Complex.isPrimitiveRoot_exp _ hM.ne'
  have hnode : Function.Injective
      (fun T : ↥s.powerset ↦ zeta ^ subsetExponent s T.1) :=
    primitiveRoot_subset_nodes_injective hM hzeta _
      (subsetExponent_mod_injective s hprime)
  have hcoeff : ∃ T : ↥s.powerset,
      ((-1 : ℂ) ^ T.1.card) *
        (zeta ^ subsetExponent s T.1) ^ start ≠ 0 := by
    refine ⟨⟨∅, by simp⟩, ?_⟩
    simp [subsetExponent]
  by_contra hnone
  push Not at hnone
  apply (exponential_sum_not_vanish_consecutively
    (fun T : ↥s.powerset ↦ zeta ^ subsetExponent s T.1)
    (fun T : ↥s.powerset ↦
      ((-1 : ℂ) ^ T.1.card) *
        (zeta ^ subsetExponent s T.1) ^ start)
    hnode hcoeff)
  intro i
  have hi : (i : Nat) < 2 ^ s.card := by
    simpa using i.isLt
  have hxmem : start + (i : Nat) ∈
      Finset.Ico start (start + 2 ^ s.card) := by
    simp only [Finset.mem_Ico]
    omega
  obtain ⟨p, hpS, hpdiv⟩ := hnone (start + (i : Nat)) hxmem
  have hzero := roots_product_eq_zero_of_dvd s p (start + (i : Nat))
    hpS hpdiv zeta hzeta
  rw [roots_product_expansion] at hzero
  calc
    (∑ T : ↥s.powerset,
        (((-1 : ℂ) ^ T.1.card) *
          (zeta ^ subsetExponent s T.1) ^ start) *
          (zeta ^ subsetExponent s T.1) ^ (i : Nat)) =
      ∑ T : ↥s.powerset,
        ((-1 : ℂ) ^ T.1.card) *
          (zeta ^ subsetExponent s T.1) ^ (start + (i : Nat)) := by
            apply Finset.sum_congr rfl
            intro T hT
            rw [pow_add]
            ring
    _ = ∑ T ∈ s.powerset,
        ((-1 : ℂ) ^ T.card) *
          (zeta ^ subsetExponent s T) ^ (start + (i : Nat)) := by
            rw [← Finset.attach_eq_univ (s := s.powerset)]
            exact Finset.sum_attach s.powerset (fun T ↦
              ((-1 : ℂ) ^ T.card) *
                (zeta ^ subsetExponent s T) ^ (start + (i : Nat)))
    _ = 0 := hzero

/-- Avoiding every prime factor of a positive natural number is equivalent
to being coprime to that number; this direction is the one needed below. -/
theorem coprime_of_avoids_primeFactors
    {c x : Nat} (hc : c ≠ 0)
    (havoid : ∀ p ∈ c.primeFactors, ¬ p ∣ x) : c.Coprime x := by
  by_contra hcop
  rw [Nat.Prime.not_coprime_iff_dvd] at hcop
  obtain ⟨p, hpPrime, hpc, hpx⟩ := hcop
  have hpFactors : p ∈ c.primeFactors := by
    exact Nat.mem_primeFactors.mpr ⟨hpPrime, hpc, hc⟩
  exact havoid p hpFactors hpx

/-- Kanold's half-open interval bound, fully proved in Lean. -/
theorem kanoldIntervalBound_vandermonde : KanoldIntervalBound := by
  intro c start hc
  obtain ⟨q, hq, havoid⟩ := exists_avoiding_prime_set c.primeFactors
    (fun p hp ↦ Nat.prime_of_mem_primeFactors hp) start
  refine ⟨q, ?_, coprime_of_avoids_primeFactors hc.ne' havoid⟩
  simpa [cardDistinctFactors_eq_primeFactors_card] using hq

/-- Unconditional `17/3` bounded-height theorem obtained by combining the
Kanold interval bound with the already verified interval reduction. -/
theorem seventeenThirdsHeight_family_witness
    {n N t : Nat} (speeds : Fin n → Nat)
    (hnN : n + 1 = N) (ht : 0 < t)
    (hpos : ∀ i, 0 < speeds i) (hinj : Function.Injective speeds)
    (hbound : ∀ i, speeds i ≤ N + t)
    (hgrowth : 17 * t ≤ 3 * N) :
    ∃ tau : Real, ∀ i,
      (N : Real)⁻¹ ≤ circleNorm (tau * (speeds i : Real)) := by
  exact seventeenThirdsHeight_family_witness_of_kanold
    kanoldIntervalBound_vandermonde speeds hnN ht hpos hinj hbound hgrowth

/-- The unconditional coefficient-six corollary. -/
theorem sixHeight_family_witness
    {n N t : Nat} (speeds : Fin n → Nat)
    (hnN : n + 1 = N) (ht : 0 < t)
    (hpos : ∀ i, 0 < speeds i) (hinj : Function.Injective speeds)
    (hbound : ∀ i, speeds i ≤ N + t)
    (hgrowth : 6 * t ≤ N) :
    ∃ tau : Real, ∀ i,
      (N : Real)⁻¹ ≤ circleNorm (tau * (speeds i : Real)) := by
  exact sixHeight_family_witness_of_kanold
    kanoldIntervalBound_vandermonde speeds hnN ht hpos hinj hbound hgrowth

#print axioms subsetExponent_mod_injective
#print axioms exponential_sum_not_vanish_consecutively
#print axioms exists_avoiding_prime_set
#print axioms kanoldIntervalBound_vandermonde
#print axioms seventeenThirdsHeight_family_witness

end LonelyRunner
