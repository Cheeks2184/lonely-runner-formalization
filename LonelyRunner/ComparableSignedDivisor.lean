import Mathlib.Data.Nat.GCD.Basic
import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Tactic

/-!
# Comparable largest-speed signed-divisor replacements

This module formalizes the arithmetic characterization used in Response 41.
`A` is the second-largest speed, `a` the largest speed, `b` its proposed
replacement, and `q` the quotient `a / b`.  A signed compatibility at a lower
speed `x` means either `b ≡ a` or `b ≡ -a` modulo `N*x`, written without
integer subtraction by using the positive difference `a - b` and sum `a+b`.
-/

namespace LonelyRunner

/-- The two allowed congruence signs at a lower speed `x`.  In applications
`b < a`, so the first divisibility is exactly `b ≡ a (mod N*x)`. -/
def SignedDivisorCompatible (N x a b : Nat) : Prop :=
  N * x ∣ a - b ∨ N * x ∣ a + b

/-- Complete signed compatibility with the second-largest speed `A` and all
remaining lower speeds. -/
def SignedDivisorCompatibleFamily {ι : Type*}
    (N A a b : Nat) (lower : ι → Nat) : Prop :=
  SignedDivisorCompatible N A a b ∧
    ∀ i, SignedDivisorCompatible N (lower i) a b

/-- A positive proper multiple has quotient at least two. -/
theorem two_le_quotient_of_mul_eq
    {a b q : Nat} (_hb : 0 < b) (hba : b < a) (ha : a = q * b) :
    2 ≤ q := by
  subst a
  nlinarith

/-- A positive multiple strictly below twice its positive modulus equals the
modulus. -/
theorem eq_of_dvd_of_pos_of_lt_two_mul
    {m x : Nat} (hm : 0 < m) (hx : 0 < x) (hdvd : m ∣ x)
    (hlt : x < 2 * m) :
    x = m := by
  obtain ⟨c, rfl⟩ := hdvd
  have hc : 0 < c := by
    by_contra hc0
    have : c = 0 := Nat.eq_zero_of_not_pos hc0
    subst c
    simp at hx
  have hclt : c < 2 := by
    apply (Nat.mul_lt_mul_left hm).mp
    simpa only [Nat.mul_assoc, Nat.mul_left_comm, Nat.mul_comm] using hlt
  have : c = 1 := by omega
  subst c
  simp

/-- At the second-largest pivot, signed compatibility forces the negative
sign and hence the exact top equation `a+b=N*A`. -/
theorem top_signed_forces_sum
    {N A a b : Nat} (hN : 2 ≤ N) (hA : 0 < A)
    (hb : 0 < b) (hba : b < a)
    (hcomp : a < (N - 1) * A)
    (hsigned : SignedDivisorCompatible N A a b) :
    a + b = N * A := by
  have hm : 0 < N * A := Nat.mul_pos (by omega) hA
  have hAN : (N - 1) * A < N * A := by
    exact (Nat.mul_lt_mul_right hA).2 (by omega)
  rcases hsigned with hplus | hminus
  · have hdiffPos : 0 < a - b := Nat.sub_pos_of_lt hba
    have hdiffLt : a - b < N * A := by omega
    have hmle : N * A ≤ a - b := Nat.le_of_dvd hdiffPos hplus
    omega
  · have hsumPos : 0 < a + b := by omega
    have hsumLt : a + b < 2 * (N * A) := by
      have hab : a + b < 2 * a := by omega
      have haM : a < N * A := hcomp.trans hAN
      omega
    exact eq_of_dvd_of_pos_of_lt_two_mul hm hsumPos hminus hsumLt

/-- The forced top equation and comparability put the replacement strictly
above the second-largest speed. -/
theorem secondLargest_lt_replacement
    {N A a b : Nat} (hN : 2 ≤ N)
    (hcomp : a < (N - 1) * A) (htop : a + b = N * A) :
    A < b := by
  have hNsplit : N = (N - 1) + 1 := by omega
  have hlt0 : a + b < (N - 1) * A + b :=
    Nat.add_lt_add_right hcomp b
  have hlt : N * A < (N - 1) * A + b := by rwa [htop] at hlt0
  have hform : N * A = (N - 1) * A + A := by
    calc
      N * A = ((N - 1) + 1) * A := congrArg (fun z => z * A) hNsplit
      _ = (N - 1) * A + A := by rw [Nat.add_mul, Nat.one_mul]
  rw [hform] at hlt
  exact Nat.add_lt_add_iff_left.mp hlt

/-- Under comparability, the quotient in a signed replacement is at most
`N-2`. -/
theorem quotient_le_N_sub_two
    {N A a b q : Nat} (hN : 2 ≤ N)
    (hcomp : a < (N - 1) * A) (htop : a + b = N * A)
    (ha : a = q * b) :
    q ≤ N - 2 := by
  have hAb : A < b := secondLargest_lt_replacement hN hcomp htop
  by_contra hq
  have hqge : N - 1 ≤ q := by omega
  have hpos : 0 < N - 1 := by omega
  have hmul : (N - 1) * A < (N - 1) * b :=
    (Nat.mul_lt_mul_left hpos).2 hAb
  have hle : (N - 1) * b ≤ q * b :=
    Nat.mul_le_mul_right b hqge
  rw [← ha] at hle
  omega

/-- Cancellation of the common positive factor `N` in the negative-sign
lower-pivot divisibility. -/
theorem dvd_secondLargest_of_scaled_dvd
    {N x A : Nat} (hN : 0 < N) (hdiv : N * x ∣ N * A) :
    x ∣ A := by
  obtain ⟨c, hc⟩ := hdiv
  refine ⟨c, ?_⟩
  apply Nat.mul_left_cancel hN
  simpa only [Nat.mul_assoc] using hc

/-- Necessity of the complete arithmetic characterization. -/
theorem comparable_signedDivisor_necessary {ι : Type*}
    {N A a b q : Nat} {lower : ι → Nat}
    (hN : 2 ≤ N) (hA : 0 < A) (hb : 0 < b) (hba : b < a)
    (ha : a = q * b) (hcop : Nat.Coprime q N)
    (hcomp : a < (N - 1) * A)
    (hsigned : SignedDivisorCompatibleFamily N A a b lower) :
    2 ≤ q ∧ q ≤ N - 2 ∧ Nat.Coprime q N ∧
      q + 1 ∣ N * A ∧ b = (N * A) / (q + 1) ∧
      a = q * b ∧
      ∀ i, lower i ∣ A ∨ N * lower i ∣ (q - 1) * b := by
  have hq : 2 ≤ q := two_le_quotient_of_mul_eq hb hba ha
  have htop : a + b = N * A :=
    top_signed_forces_sum hN hA hb hba hcomp hsigned.1
  have hqtop : (q + 1) * b = N * A := by
    rw [← htop, ha]
    ring
  have hqle : q ≤ N - 2 := quotient_le_N_sub_two hN hcomp htop ha
  have hdiv : q + 1 ∣ N * A := ⟨b, hqtop.symm⟩
  have hbformula : b = (N * A) / (q + 1) := by
    rw [← hqtop]
    simp
  refine ⟨hq, hqle, hcop, hdiv, hbformula, ha, ?_⟩
  intro i
  rcases hsigned.2 i with hplus | hminus
  · right
    have hdiff : a - b = (q - 1) * b := by
      rw [ha, Nat.sub_mul, Nat.one_mul]
    rwa [hdiff] at hplus
  · left
    apply dvd_secondLargest_of_scaled_dvd (by omega : 0 < N)
    have hsum : a + b = (q + 1) * b := by
      rw [ha]
      ring
    rw [hsum, hqtop] at hminus
    exact hminus

/-- Sufficiency of the lower-divisor alternatives and the displayed top
equations for all signed congruences. -/
theorem comparable_signedDivisor_sufficient {ι : Type*}
    {N A a b q : Nat} {lower : ι → Nat}
    (hA : 0 < A) (hq : 2 ≤ q) (hqle : q ≤ N - 2)
    (ha : a = q * b) (htop : (q + 1) * b = N * A)
    (hlower : ∀ i, lower i ∣ A ∨ N * lower i ∣ (q - 1) * b) :
    0 < b ∧ A < b ∧ b < a ∧
      SignedDivisorCompatibleFamily N A a b lower := by
  have hN : 2 ≤ N := by omega
  have hqpos : 0 < q + 1 := by omega
  have hNA : 0 < N * A := Nat.mul_pos (by omega) hA
  have hb : 0 < b := by
    have hprod : 0 < (q + 1) * b := by rw [htop]; exact hNA
    by_contra hbnot
    have hbzero : b = 0 := Nat.eq_zero_of_not_pos hbnot
    rw [hbzero, Nat.mul_zero] at hprod
    omega
  have hba : b < a := by
    rw [ha]
    have hfactor : 1 < q := by omega
    simpa using (Nat.mul_lt_mul_right hb).2 hfactor
  have hAb : A < b := by
    have hfactor : q + 1 < N := by omega
    have hmulA : (q + 1) * A < N * A :=
      (Nat.mul_lt_mul_right hA).2 hfactor
    have hmul : (q + 1) * A < (q + 1) * b := by
      rw [htop]
      exact hmulA
    exact (Nat.mul_lt_mul_left hqpos).mp hmul
  have hdiff : a - b = (q - 1) * b := by
    rw [ha, Nat.sub_mul, Nat.one_mul]
  have hsum : a + b = (q + 1) * b := by
    rw [ha]
    ring
  refine ⟨hb, hAb, hba, ?_⟩
  constructor
  · unfold SignedDivisorCompatible
    right
    rw [hsum, htop]
  · intro i
    unfold SignedDivisorCompatible
    rcases hlower i with hdiv | hdiv
    · right
      rw [hsum, htop]
      obtain ⟨c, rfl⟩ := hdiv
      exact ⟨c, by simp [Nat.mul_assoc]⟩
    · left
      rwa [hdiff]

/-- Exact necessity-and-sufficiency package, with integrality expressed by
`q+1 ∣ N*A` and the quotient formula for `b`. -/
theorem comparable_signedDivisor_iff {ι : Type*}
    {N A a b q : Nat} {lower : ι → Nat}
    (hN : 2 ≤ N) (hA : 0 < A)
    (hcomp : a < (N - 1) * A) :
    (0 < b ∧ b < a ∧ a = q * b ∧ Nat.Coprime q N ∧
        SignedDivisorCompatibleFamily N A a b lower) ↔
      (2 ≤ q ∧ q ≤ N - 2 ∧ Nat.Coprime q N ∧
        q + 1 ∣ N * A ∧ b = (N * A) / (q + 1) ∧
        a = q * b ∧
        ∀ i, lower i ∣ A ∨ N * lower i ∣ (q - 1) * b) := by
  constructor
  · rintro ⟨hb, hba, ha, hcop, hsigned⟩
    exact comparable_signedDivisor_necessary hN hA hb hba ha hcop hcomp hsigned
  · rintro ⟨hq, hqle, hcop, hdiv, hbformula, ha, hlower⟩
    have htop : (q + 1) * b = N * A := by
      rw [hbformula]
      exact Nat.mul_div_cancel' hdiv
    obtain ⟨hb, _hAb, hba, hsigned⟩ :=
      comparable_signedDivisor_sufficient hA hq hqle ha htop hlower
    exact ⟨hb, hba, ha, hcop, hsigned⟩

/-- Any lower speed bounded by `A` remains strictly below the replacement. -/
theorem lower_lt_replacement_of_le_secondLargest
    {x A b : Nat} (hx : x ≤ A) (hAb : A < b) :
    x < b := hx.trans_lt hAb

/-- Ordered-family corollary of sufficiency: every old lower speed remains
strictly below `b`, so the replacement is positive, distinct from the entire
lower family, above `A`, and below `a`. -/
theorem comparable_signedDivisor_sufficient_ordered {ι : Type*}
    {N A a b q : Nat} {lower : ι → Nat}
    (hA : 0 < A) (hq : 2 ≤ q) (hqle : q ≤ N - 2)
    (ha : a = q * b) (htop : (q + 1) * b = N * A)
    (hlower : ∀ i, lower i ∣ A ∨ N * lower i ∣ (q - 1) * b)
    (hlowerOrder : ∀ i, lower i ≤ A) :
    0 < b ∧ (∀ i, lower i < b) ∧ A < b ∧ b < a ∧ b ∣ a ∧
      SignedDivisorCompatibleFamily N A a b lower := by
  obtain ⟨hb, hAb, hba, hsigned⟩ :=
    comparable_signedDivisor_sufficient hA hq hqle ha htop hlower
  refine ⟨hb, fun i => (hlowerOrder i).trans_lt hAb, hAb, hba, ?_, hsigned⟩
  exact ⟨q, by rw [ha, Nat.mul_comm]⟩

/-- Replacing `a` by the strictly smaller `b` strictly decreases total sum. -/
theorem replacement_sum_lt {ι : Type*} [DecidableEq ι]
    (I : Finset ι) (lower : ι → Nat) {a b : Nat} (hba : b < a) :
    I.sum lower + b < I.sum lower + a :=
  Nat.add_lt_add_left hba _

end LonelyRunner
