import LonelyRunner.LogarithmicHeight

/-!
Conditional linear-height consequence of Kanold's Jacobsthal bound.

The literature theorem itself is deliberately retained as the explicit
proposition `KanoldIntervalBound`; this file does not import it as an axiom.
All interval arithmetic, including the `c ≤ 6` branch and the inclusive
upper endpoint `q = 2 * N`, is proved below.
-/

open scoped ArithmeticFunction.omega
open Finset

namespace LonelyRunner

theorem cardDistinctFactors_one : ArithmeticFunction.cardDistinctFactors 1 = 0 := by
  rw [cardDistinctFactors_eq_primeFactors_card, Nat.primeFactors_one]
  simp

theorem cardDistinctFactors_prime_pow {p k : Nat} (hk : k ≠ 0) (hp : p.Prime) :
    ArithmeticFunction.cardDistinctFactors (p ^ k) = 1 := by
  rw [cardDistinctFactors_eq_primeFactors_card,
    Nat.primeFactors_prime_pow hk hp]
  simp

theorem cardDistinctFactors_six : ArithmeticFunction.cardDistinctFactors 6 = 2 := by
  rw [cardDistinctFactors_eq_primeFactors_card]
  have hpf2 : (2 : Nat).primeFactors = {2} := by
    simpa using
      Nat.primeFactors_prime_pow (p := 2) (k := 1) (by norm_num) (by norm_num)
  have hpf3 : (3 : Nat).primeFactors = {3} := by
    simpa using
      Nat.primeFactors_prime_pow (p := 3) (k := 1) (by norm_num) (by norm_num)
  rw [show (6 : Nat) = 2 * 3 by norm_num,
    Nat.primeFactors_mul (by norm_num) (by norm_num), hpf2, hpf3]
  norm_num

/-- For `c ≥ 7`, the Kanold interval length is at most `2*c/5`.
This includes nonsquarefree values of `c`. -/
theorem five_mul_two_pow_omega_le_two_mul (c : Nat) (hc7 : 7 ≤ c) :
    5 * 2 ^ ArithmeticFunction.cardDistinctFactors c ≤ 2 * c := by
  rw [cardDistinctFactors_eq_primeFactors_card]
  let s := c.primeFactors
  by_cases hcard : s.card ≤ 2
  · have hp4 : 2 ^ s.card ≤ 4 := by
      exact Nat.pow_le_pow_right (by omega) hcard
    by_cases hc10 : 10 ≤ c
    · nlinarith
    · have hpf8 : (8 : Nat).primeFactors.card = 1 := by
        rw [show (8 : Nat) = 2 ^ 3 by norm_num,
          Nat.primeFactors_prime_pow (by norm_num) (by norm_num)]
        simp
      have hpf9 : (9 : Nat).primeFactors.card = 1 := by
        rw [show (9 : Nat) = 3 ^ 2 by norm_num,
          Nat.primeFactors_prime_pow (by norm_num) (by norm_num)]
        simp
      interval_cases c <;> norm_num [hpf8, hpf9]
  · have hcard3 : 3 ≤ s.card := by omega
    have hsne : s.Nonempty := Finset.card_pos.mp (by omega)
    let m := s.max' hsne
    let r := s.erase m
    have hm_mem : m ∈ s := by simpa [m] using Finset.max'_mem s hsne
    have hm5 : 5 ≤ m := by
      by_contra hmnot
      have hm_lt : m < 5 := by omega
      have hsub : s ⊆ {2, 3} := by
        intro p hp
        have hpprime : p.Prime :=
          Nat.prime_of_mem_primeFactors (by simpa [s] using hp)
        have hple : p ≤ m := Finset.le_max' s p hp
        have hp2 := hpprime.two_le
        have hp5 : p < 5 := lt_of_le_of_lt hple hm_lt
        have hp23 : p = 2 ∨ p = 3 := by
          have hp4 : p ≠ 4 := by
            intro hp
            subst p
            norm_num at hpprime
          omega
        simp [hp23]
      have := Finset.card_le_card hsub
      norm_num at this
      omega
    have hcardr : r.card + 1 = s.card := by
      simpa [r] using Finset.card_erase_add_one hm_mem
    have hrest : 2 ^ r.card ≤ ∏ p ∈ r, p := by
      apply Finset.pow_card_le_prod
      intro p hp
      exact (Nat.prime_of_mem_primeFactors
        (by simpa [s] using Finset.mem_of_mem_erase hp)).two_le
    have hprod : (∏ p ∈ r, p) * m = ∏ p ∈ s, p := by
      simpa [r] using Finset.prod_erase_mul s (fun p : Nat => p) hm_mem
    have hrad_dvd : (∏ p ∈ s, p) ∣ c := by
      simpa [s] using Nat.prod_primeFactors_dvd c
    have hrad_le : (∏ p ∈ s, p) ≤ c :=
      Nat.le_of_dvd (by omega) hrad_dvd
    have hpow : 2 ^ s.card = 2 * 2 ^ r.card := by
      rw [← hcardr, pow_succ]
      ring
    have hmul : 5 * 2 ^ r.card ≤ m * ∏ p ∈ r, p :=
      Nat.mul_le_mul hm5 hrest
    calc
      5 * 2 ^ s.card = 2 * (5 * 2 ^ r.card) := by rw [hpow]; ring
      _ ≤ 2 * ((∏ p ∈ r, p) * m) := by
        rw [Nat.mul_comm (∏ p ∈ r, p) m]
        exact Nat.mul_le_mul_left 2 hmul
      _ = 2 * ∏ p ∈ s, p := by rw [hprod]
      _ ≤ 2 * c := Nat.mul_le_mul_left 2 hrad_le

/-- Exact half-open-interval formulation of Kanold's bound. The interval has
exactly `2^omega(c)` natural numbers. This proposition is open in the local
formal development and is never introduced as an axiom. -/
def KanoldIntervalBound : Prop :=
  ∀ (c start : Nat), 0 < c →
    ∃ q, q ∈ Finset.Ico start
      (start + 2 ^ ArithmeticFunction.cardDistinctFactors c) ∧ c.Coprime q

/-- The complete `c = 1, ..., 6` interval-length arithmetic under the
linear-height hypotheses. -/
theorem small_modulus_power_le_interval
    {N t c : Nat} (ht : 0 < t) (hc : 0 < c) (hc6 : c ≤ 6)
    (hgrowth : 6 * t ≤ N) (h2c : 2 * c ≤ N + t) :
    2 ^ ArithmeticFunction.cardDistinctFactors c ≤ N - c - t := by
  have hw1 : ArithmeticFunction.cardDistinctFactors 1 = 0 :=
    cardDistinctFactors_one
  have hw2 : ArithmeticFunction.cardDistinctFactors 2 = 1 := by
    simpa using
      cardDistinctFactors_prime_pow (p := 2) (k := 1) (by norm_num) (by norm_num)
  have hw3 : ArithmeticFunction.cardDistinctFactors 3 = 1 := by
    simpa using
      cardDistinctFactors_prime_pow (p := 3) (k := 1) (by norm_num) (by norm_num)
  have hw4 : ArithmeticFunction.cardDistinctFactors 4 = 1 := by
    simpa using
      cardDistinctFactors_prime_pow (p := 2) (k := 2) (by norm_num) (by norm_num)
  have hw5 : ArithmeticFunction.cardDistinctFactors 5 = 1 := by
    simpa using
      cardDistinctFactors_prime_pow (p := 5) (k := 1) (by norm_num) (by norm_num)
  have hw6 : ArithmeticFunction.cardDistinctFactors 6 = 2 :=
    cardDistinctFactors_six
  interval_cases c <;> norm_num [hw1, hw2, hw3, hw4, hw5, hw6] <;> omega

/-- The same complete small-modulus arithmetic under the sharper integral
condition `17*t ≤ 3*N`. -/
theorem small_modulus_power_le_interval_seventeen
    {N t c : Nat} (ht : 0 < t) (hc : 0 < c) (hc6 : c ≤ 6)
    (hgrowth : 17 * t ≤ 3 * N) (h2c : 2 * c ≤ N + t) :
    2 ^ ArithmeticFunction.cardDistinctFactors c ≤ N - c - t := by
  have hw1 : ArithmeticFunction.cardDistinctFactors 1 = 0 :=
    cardDistinctFactors_one
  have hw2 : ArithmeticFunction.cardDistinctFactors 2 = 1 := by
    simpa using
      cardDistinctFactors_prime_pow (p := 2) (k := 1) (by norm_num) (by norm_num)
  have hw3 : ArithmeticFunction.cardDistinctFactors 3 = 1 := by
    simpa using
      cardDistinctFactors_prime_pow (p := 3) (k := 1) (by norm_num) (by norm_num)
  have hw4 : ArithmeticFunction.cardDistinctFactors 4 = 1 := by
    simpa using
      cardDistinctFactors_prime_pow (p := 2) (k := 2) (by norm_num) (by norm_num)
  have hw5 : ArithmeticFunction.cardDistinctFactors 5 = 1 := by
    simpa using
      cardDistinctFactors_prime_pow (p := 5) (k := 1) (by norm_num) (by norm_num)
  have hw6 : ArithmeticFunction.cardDistinctFactors 6 = 2 :=
    cardDistinctFactors_six
  interval_cases c <;> norm_num [hw1, hw2, hw3, hw4, hw5, hw6] <;> omega

/-- Conditional sharpened linear bounded-height theorem. Assuming the exact
Kanold interval statement, `17*t ≤ 3*N` suffices for a closed `1/N` witness. -/
theorem seventeenThirdsHeight_family_witness_of_kanold
    (hkanold : KanoldIntervalBound)
    {n N t : Nat} (speeds : Fin n → Nat)
    (hnN : n + 1 = N) (ht : 0 < t)
    (hpos : ∀ i, 0 < speeds i) (hinj : Function.Injective speeds)
    (hbound : ∀ i, speeds i ≤ N + t)
    (hgrowth : 17 * t ≤ 3 * N) :
    ∃ tau : Real, ∀ i,
      (N : Real)⁻¹ ≤ circleNorm (tau * (speeds i : Real)) := by
  classical
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
      have hpell :
          2 ^ ArithmeticFunction.cardDistinctFactors c ≤ ell := by
        by_cases hcsmall : c ≤ 6
        · dsimp [ell]
          exact small_modulus_power_le_interval_seventeen
            ht hcBounds.1 hcsmall hgrowth h2c
        · have hc7 : 7 ≤ c := by omega
          have h5ell : 2 * c ≤ 5 * ell := by
            dsimp [ell]
            omega
          have hp := five_mul_two_pow_omega_le_two_mul c hc7
          omega
      obtain ⟨q, hq, hcop⟩ := hkanold c start hcBounds.1
      refine ⟨q, ?_, hcop⟩
      have hqm := Finset.mem_Ico.mp hq
      exact Finset.mem_Ico.mpr ⟨hqm.1, by omega⟩
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

/-- The simpler coefficient-six corollary is retained as a stable public
interface. -/
theorem sixHeight_family_witness_of_kanold
    (hkanold : KanoldIntervalBound)
    {n N t : Nat} (speeds : Fin n → Nat)
    (hnN : n + 1 = N) (ht : 0 < t)
    (hpos : ∀ i, 0 < speeds i) (hinj : Function.Injective speeds)
    (hbound : ∀ i, speeds i ≤ N + t)
    (hgrowth : 6 * t ≤ N) :
    ∃ tau : Real, ∀ i,
      (N : Real)⁻¹ ≤ circleNorm (tau * (speeds i : Real)) := by
  apply seventeenThirdsHeight_family_witness_of_kanold
    hkanold speeds hnN ht hpos hinj hbound
  omega

end LonelyRunner
