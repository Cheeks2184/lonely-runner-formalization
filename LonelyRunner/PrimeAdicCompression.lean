import LonelyRunner.PrimeAdicArithmetic
import Mathlib.Tactic

/-!
# General-prime distinct-level compression

This module prescribes two digits at distinct live levels and compresses
three anchored residues into two cyclically adjacent digits. Natural and
signed inputs share the same oriented residue contract. These are supporting
arithmetic results, not a simultaneous safety theorem for all runners.
-/

namespace LonelyRunner

/-- A below-top correction is a prime unit. -/
theorem primeAdicCorrection_not_dvd (p m j k : ℕ)
    (hp : Nat.Prime p) (hj : j < m) :
    ¬ p ∣ primeAdicCorrection p m j k := by
  intro h
  have hz := Nat.mod_eq_zero_of_dvd h
  rw [primeAdicCorrection_mod_prime p m j k hp.two_le hj] at hz
  omega

/-- Prescribe one digit, treating the top level with a scalar and every
lower level with a unit correction. The multiplier need not yet be bounded. -/
theorem primeAdic_one_target_unbounded (p m j u target : ℕ)
    (hp : Nat.Prime p) (hj : j ≤ m) (hu : ¬ p ∣ u)
    (htarget : target < p) (htop : j = m → 0 < target) :
    ∃ A : ℕ, ¬ p ∣ A ∧
      primeAdicDigit p m (A * (p ^ j * u)) = target := by
  by_cases heq : j = m
  · subst j
    obtain ⟨A, _, _, hA, hd⟩ :=
      primeAdic_top_exists_target p m u target hp hu htarget (htop rfl)
    exact ⟨A, hA, hd⟩
  · have hjlt : j < m := by omega
    obtain ⟨k, hk⟩ := primeAdicCorrection_exists_target p m j 1 u target hp
      hjlt hp.not_dvd_one hu htarget
    exact ⟨primeAdicCorrection p m j k.val,
      primeAdicCorrection_not_dvd p m j k.val hp hjlt, by simpa using hk⟩

/-- Solve the higher level first. The lower correction preserves its entire
residue while using the current multiplier in its own digit coefficient. -/
private theorem primeAdic_ordered_targets (p m a b u v tx ty : ℕ)
    (hp : Nat.Prime p) (hab : a < b) (hb : b ≤ m)
    (hu : ¬ p ∣ u) (hv : ¬ p ∣ v) (htx : tx < p) (hty : ty < p)
    (htopy : b = m → 0 < ty) :
    ∃ A : ℕ, ¬ p ∣ A ∧
      primeAdicDigit p m (A * (p ^ a * u)) = tx ∧
      primeAdicDigit p m (A * (p ^ b * v)) = ty := by
  obtain ⟨A, hA, hhigh⟩ :=
    primeAdic_one_target_unbounded p m b v ty hp hb hv hty htopy
  have ha : a < m := lt_of_lt_of_le hab hb
  obtain ⟨k, hk⟩ := primeAdicCorrection_exists_target p m a A u tx hp ha hA hu htx
  let C := primeAdicCorrection p m a k.val
  have hC : ¬ p ∣ C := primeAdicCorrection_not_dvd p m a k.val hp ha
  refine ⟨C * A, ?_, ?_, ?_⟩
  · intro hd
    exact (hp.dvd_mul.mp hd).elim hC hA
  · simpa [C, mul_assoc] using hk
  · calc
      primeAdicDigit p m (C * A * (p ^ b * v)) =
          primeAdicDigit p m (A * (p ^ b * v)) := by
        apply primeAdicDigit_of_mod_eq
        simpa [C, mul_assoc] using
          primeAdicCorrection_higher_residue p m a b k.val A v hab hb
      _ = ty := hhigh

/-- Two distinct live levels can receive independently prescribed digits.
A top-level target must be nonzero, since a unit cannot erase that digit. -/
theorem primeAdic_two_distinct_targets
    (p m x y a b u v tx ty : ℕ) (hp : Nat.Prime p)
    (hx : x = p ^ a * u) (hy : y = p ^ b * v)
    (ha : a ≤ m) (hb : b ≤ m) (hab : a ≠ b)
    (hu : ¬ p ∣ u) (hv : ¬ p ∣ v)
    (htx : tx < p) (hty : ty < p)
    (htopx : a = m → 0 < tx) (htopy : b = m → 0 < ty) :
    ∃ lam : ℕ, 0 < lam ∧ lam < p ^ (m + 1) ∧ ¬ p ∣ lam ∧
      primeAdicDigit p m (lam * x) = tx ∧
      primeAdicDigit p m (lam * y) = ty := by
  have hraw : ∃ A : ℕ, ¬ p ∣ A ∧
      primeAdicDigit p m (A * x) = tx ∧
      primeAdicDigit p m (A * y) = ty := by
    rcases lt_or_gt_of_ne hab with hlt | hgt
    · simpa [hx, hy] using
        primeAdic_ordered_targets p m a b u v tx ty hp hlt hb hu hv htx hty htopy
    · obtain ⟨A, hA, hy', hx'⟩ :=
        primeAdic_ordered_targets p m b a v u ty tx hp hgt ha hv hu hty htx htopx
      exact ⟨A, hA, by simpa [hx] using hx', by simpa [hy] using hy'⟩
  obtain ⟨A, hA, hAx, hAy⟩ := hraw
  obtain ⟨hpos, hlt, hunit, _, hres⟩ := primeAdic_unit_representative p m A hp hA
  refine ⟨A % (p * p ^ m), hpos, ?_, hunit, ?_, ?_⟩
  · simpa [pow_succ, mul_comm] using hlt
  · exact (primeAdicDigit_of_mod_eq p m _ _ (hres x)).trans hAx
  · exact (primeAdicDigit_of_mod_eq p m _ _ (hres y)).trans hAy

/-- The oriented difference from `b` to `a`, reduced without truncated
subtraction. The modulus added before subtraction dominates `b`'s residue. -/
def primeAdicDifference (p m a b : ℕ) : ℕ :=
  let P := p ^ (m + 1)
  (a % P + P - b % P) % P

/-- Collapsed differences are admitted separately; two live differences must
have distinct levels at most `m`. -/
def PrimeAdicDifferenceSeparated (p m x y : ℕ) : Prop :=
  x = 0 ∨ y = 0 ∨
  ∃ a b u v : ℕ,
    a ≤ m ∧ b ≤ m ∧ a ≠ b ∧
    x = p ^ a * u ∧ y = p ^ b * v ∧ ¬ p ∣ u ∧ ¬ p ∣ v

theorem primeAdicDifference_add_anchor (p m a b : ℕ) (hp : 0 < p) :
    (b + primeAdicDifference p m a b) % p ^ (m + 1) = a % p ^ (m + 1) := by
  let P := p ^ (m + 1)
  have hP : 0 < P := pow_pos hp _
  have hb : b % P < P := Nat.mod_lt _ hP
  change (b + (a % P + P - b % P) % P) % P = a % P
  calc
    _ = (b % P + (a % P + P - b % P)) % P := by simp [Nat.add_mod]
    _ = (a % P + P) % P := by congr 1; omega
    _ = a % P := by simp

/-- A last digit added to an anchor leaves its digit unchanged or decreases
it by one cyclically. The carry case includes the closed lower endpoint. -/
theorem primeAdicDigit_add_last (p m c d : ℕ) (hp : Nat.Prime p)
    (hd : primeAdicDigit p m d = p - 1) :
    primeAdicDigit p m (c + d) = primeAdicDigit p m c ∨
    primeAdicDigit p m (c + d) = (primeAdicDigit p m c + p - 1) % p := by
  have hp1 : 1 ≤ p := hp.one_lt.le
  have hsplit := Nat.add_div (a := c) (b := d) (pow_pos hp.pos m)
  change (d / p ^ m) % p = p - 1 at hd
  unfold primeAdicDigit
  rw [hsplit]
  split_ifs with hcarry
  · left
    calc
      _ = ((c / p ^ m) % p + (p - 1) + 1) % p := by simp [Nat.add_mod, hd]
      _ = ((c / p ^ m) % p + p) % p := by congr 1; omega
      _ = (c / p ^ m) % p := by simp
  · right
    simp only [add_zero]
    calc
      _ = ((c / p ^ m) % p + (p - 1)) % p := by simp [Nat.add_mod, hd]
      _ = ((c / p ^ m) % p + p - 1) % p := by congr 1; omega

/-- A single bounded residue can be collapsed already, or can be sent to
the last digit by a positive bounded unit. -/
theorem primeAdic_zero_or_last_target (p m x : ℕ) (hp : Nat.Prime p)
    (hx : x < p ^ (m + 1)) :
    ∃ lam : ℕ, 0 < lam ∧ lam < p ^ (m + 1) ∧ ¬ p ∣ lam ∧
      (x = 0 ∨ primeAdicDigit p m (lam * x) = p - 1) := by
  by_cases hz : x = 0
  · refine ⟨1, by omega, ?_, hp.not_dvd_one, Or.inl hz⟩
    exact one_lt_pow₀ hp.one_lt (by omega)
  · obtain ⟨a, u, ha, hxu, hu⟩ :=
      primeAdic_positive_bounded_residue_decomposition p m x hp (Nat.pos_of_ne_zero hz) hx
    obtain ⟨A, hA, hd⟩ := primeAdic_one_target_unbounded p m a u (p - 1) hp ha hu
      (by have := hp.pos; omega) (by intro _; have := hp.two_le; omega)
    obtain ⟨hpos, hlt, hunit, _, hres⟩ := primeAdic_unit_representative p m A hp hA
    refine ⟨A % (p * p ^ m), hpos, ?_, hunit, Or.inr ?_⟩
    · simpa [pow_succ, mul_comm] using hlt
    · exact (primeAdicDigit_of_mod_eq p m _ _ (hres x)).trans (by simpa [hxu] using hd)

private theorem primeAdic_separated_last_targets (p m x y : ℕ) (hp : Nat.Prime p)
    (hx : x < p ^ (m + 1)) (hy : y < p ^ (m + 1))
    (hsep : PrimeAdicDifferenceSeparated p m x y) :
    ∃ lam : ℕ, 0 < lam ∧ lam < p ^ (m + 1) ∧ ¬ p ∣ lam ∧
      (x = 0 ∨ primeAdicDigit p m (lam * x) = p - 1) ∧
      (y = 0 ∨ primeAdicDigit p m (lam * y) = p - 1) := by
  rcases hsep with hz | hz | ⟨a, b, u, v, ha, hb, hab, hxu, hyv, hu, hv⟩
  · obtain ⟨lam, hpos, hlt, hunit, hy'⟩ := primeAdic_zero_or_last_target p m y hp hy
    exact ⟨lam, hpos, hlt, hunit, Or.inl hz, hy'⟩
  · obtain ⟨lam, hpos, hlt, hunit, hx'⟩ := primeAdic_zero_or_last_target p m x hp hx
    exact ⟨lam, hpos, hlt, hunit, hx', Or.inl hz⟩
  · have hlast : 0 < p - 1 := by have := hp.two_le; omega
    have hlastlt : p - 1 < p := by omega
    obtain ⟨lam, hpos, hlt, hunit, hdx, hdy⟩ :=
      primeAdic_two_distinct_targets p m x y a b u v (p - 1) (p - 1) hp
        hxu hyv ha hb hab hu hv hlastlt hlastlt (fun _ => hlast) (fun _ => hlast)
    exact ⟨lam, hpos, hlt, hunit, Or.inr hdx, Or.inr hdy⟩

/-- Anchored compression of three residues into two consecutive cyclic
digits. Collapsed differences, top-level differences and equality endpoints
are retained explicitly. -/
theorem primeAdic_triple_compression
    (p m : ℕ) (hp : Nat.Prime p) (b : Fin 3 → ℕ)
    (hsep : PrimeAdicDifferenceSeparated p m
      (primeAdicDifference p m (b 0) (b 2))
      (primeAdicDifference p m (b 1) (b 2))) :
    ∃ lam : ℕ, 0 < lam ∧ lam < p ^ (m + 1) ∧ ¬ p ∣ lam ∧
      ∀ i : Fin 3,
        primeAdicDigit p m (lam * b i) = primeAdicDigit p m (lam * b 2) ∨
        primeAdicDigit p m (lam * b i) =
          (primeAdicDigit p m (lam * b 2) + p - 1) % p := by
  have hP : 0 < p ^ (m + 1) := pow_pos hp.pos _
  let d := fun i : Fin 3 => primeAdicDifference p m (b i) (b 2)
  have hdlt : ∀ i, d i < p ^ (m + 1) := by
    intro i; exact Nat.mod_lt _ hP
  obtain ⟨lam, hpos, hlt, hunit, hd0, hd1⟩ :=
    primeAdic_separated_last_targets p m (d 0) (d 1) hp (hdlt 0) (hdlt 1) hsep
  refine ⟨lam, hpos, hlt, hunit, ?_⟩
  have hrow (i : Fin 3) (hd : d i = 0 ∨ primeAdicDigit p m (lam * d i) = p - 1) :
      primeAdicDigit p m (lam * b i) = primeAdicDigit p m (lam * b 2) ∨
      primeAdicDigit p m (lam * b i) =
        (primeAdicDigit p m (lam * b 2) + p - 1) % p := by
    have hbase := primeAdicDifference_add_anchor p m (b i) (b 2) hp.pos
    have hres : (lam * b i) % p ^ (m + 1) =
        (lam * b 2 + lam * d i) % p ^ (m + 1) := by
      rw [← mul_add]
      conv_lhs => rw [Nat.mul_mod]
      conv_rhs => rw [Nat.mul_mod]
      change _ = (lam % p ^ (m + 1) *
        ((b 2 + primeAdicDifference p m (b i) (b 2)) % p ^ (m + 1))) % _
      rw [hbase]
    have heq : primeAdicDigit p m (lam * b i) =
        primeAdicDigit p m (lam * b 2 + lam * d i) :=
      primeAdicDigit_of_mod_eq p m _ _ (by simpa [pow_succ, mul_comm] using hres)
    rw [heq]
    rcases hd with hz | hl
    · left; simp [hz]
    · exact primeAdicDigit_add_last p m (lam * b 2) (lam * d i) hp hl
  intro i
  fin_cases i
  · exact hrow 0 hd0
  · exact hrow 1 hd1
  · exact Or.inl rfl

/-- Signed phases use Euclidean residues, so negative inputs retain their
orientation rather than being replaced by absolute values. -/
def signedPrimeAdicDigit (p m : ℕ) (z : ℤ) : ℕ :=
  primeAdicDigit p m (z.natMod (p ^ (m + 1) : ℤ))

private theorem primeAdic_natMod_cast (p m : ℕ) (hp : Nat.Prime p) (z : ℤ) :
    (z.natMod (p ^ (m + 1) : ℤ) : ℤ) = z % (p ^ (m + 1) : ℤ) := by
  unfold Int.natMod
  apply Int.toNat_of_nonneg
  apply Int.emod_nonneg
  have hp0 : (0 : ℤ) < (p : ℤ) := by exact_mod_cast hp.pos
  have : (0 : ℤ) < (p ^ (m + 1) : ℤ) := by positivity
  exact this.ne'

/-- Multiplying a signed input and then reducing gives the same digit as
multiplying its natural Euclidean residue. -/
theorem signedPrimeAdicDigit_mul (p m lam : ℕ) (hp : Nat.Prime p) (z : ℤ) :
    signedPrimeAdicDigit p m ((lam : ℤ) * z) =
      primeAdicDigit p m (lam * z.natMod (p ^ (m + 1) : ℤ)) := by
  unfold signedPrimeAdicDigit
  apply primeAdicDigit_of_mod_eq
  have heq : (((lam : ℤ) * z).natMod (p ^ (m + 1) : ℤ)) =
      (lam * z.natMod (p ^ (m + 1) : ℤ)) % p ^ (m + 1) := by
    apply Int.natCast_inj.mp
    rw [primeAdic_natMod_cast p m hp, Int.natCast_emod, Nat.cast_mul]
    rw [primeAdic_natMod_cast p m hp]
    push_cast
    simp [Int.mul_emod]
  rw [heq]
  simp [pow_succ, mul_comm]

/-- The same anchored compression for arbitrary integer inputs. Its
separation premise is stated on the oriented reduced differences exactly
as in the natural theorem. -/
theorem primeAdic_triple_compression_int
    (p m : ℕ) (hp : Nat.Prime p) (b : Fin 3 → ℤ)
    (hsep : PrimeAdicDifferenceSeparated p m
      (primeAdicDifference p m
        ((b 0).natMod (p ^ (m + 1) : ℤ))
        ((b 2).natMod (p ^ (m + 1) : ℤ)))
      (primeAdicDifference p m
        ((b 1).natMod (p ^ (m + 1) : ℤ))
        ((b 2).natMod (p ^ (m + 1) : ℤ)))) :
    ∃ lam : ℕ, 0 < lam ∧ lam < p ^ (m + 1) ∧ ¬ p ∣ lam ∧
      ∀ i : Fin 3,
        signedPrimeAdicDigit p m ((lam : ℤ) * b i) =
          signedPrimeAdicDigit p m ((lam : ℤ) * b 2) ∨
        signedPrimeAdicDigit p m ((lam : ℤ) * b i) =
          (signedPrimeAdicDigit p m ((lam : ℤ) * b 2) + p - 1) % p := by
  obtain ⟨lam, hpos, hlt, hunit, hd⟩ := primeAdic_triple_compression p m hp
    (fun i => (b i).natMod (p ^ (m + 1) : ℤ)) hsep
  refine ⟨lam, hpos, hlt, hunit, ?_⟩
  intro i
  simpa only [signedPrimeAdicDigit_mul p m lam hp] using hd i

end LonelyRunner
