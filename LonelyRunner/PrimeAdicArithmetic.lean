import LonelyRunner.PivotResidues
import Mathlib.Tactic

/-!
# General-prime digit arithmetic

The definitions and residue identities in this file are the arithmetic layer
for unequal-level compression.  They deliberately use natural residues modulo
`p^(m+1)`; signed inputs are handled by the adapter in
`PrimeAdicCompression`.
-/

namespace LonelyRunner

/-- The base-`p` digit selected at level `m`. -/
def primeAdicDigit (p m x : ℕ) : ℕ := (x / p ^ m) % p

/-- The unit correction at a level strictly below `m`. -/
def primeAdicCorrection (p m j k : ℕ) : ℕ := 1 + k * p ^ (m - j)

/-- A correction is positive without any condition on its base. -/
theorem primeAdicCorrection_pos (p m j k : ℕ) :
    0 < primeAdicCorrection p m j k := by
  simp [primeAdicCorrection]

/-- Below the top level, the correction is one modulo the prime base. -/
theorem primeAdicCorrection_mod_prime (p m j k : ℕ)
    (hp : 2 ≤ p) (hj : j < m) :
    primeAdicCorrection p m j k % p = 1 := by
  unfold primeAdicCorrection
  have hpow : p ∣ p ^ (m - j) := dvd_pow_self p (by omega)
  rw [Nat.add_mod, Nat.mul_mod, Nat.mod_eq_zero_of_dvd hpow]
  simp only [Nat.zero_mod, mul_zero, add_zero]
  rw [Nat.mod_mod]
  exact Nat.mod_eq_of_lt (by omega)

/-- The next-prime-power residue splits into its selected digit and lower
residue. -/
theorem primeAdic_residue_decomposition (p m x : ℕ) :
    x % (p * p ^ m) = p ^ m * primeAdicDigit p m x + x % p ^ m := by
  unfold primeAdicDigit
  simpa [Nat.mul_comm, Nat.add_comm] using
    (Nat.mod_mul (x := x) (a := p ^ m) (b := p))

/-- At its selected level a correction adds one level-`m` block with the
current coefficient retained. -/
theorem primeAdicCorrection_selected_product (p m j k A u : ℕ)
    (hj : j ≤ m) :
    primeAdicCorrection p m j k * (A * (p ^ j * u)) =
      A * (p ^ j * u) + k * p ^ m * (A * u) := by
  unfold primeAdicCorrection
  have hpow : p ^ (m - j) * p ^ j = p ^ m := Nat.pow_sub_mul_pow p hj
  calc
    (1 + k * p ^ (m - j)) * (A * (p ^ j * u)) =
        A * (p ^ j * u) + k * (p ^ (m - j) * p ^ j) * (A * u) := by ring
    _ = A * (p ^ j * u) + k * p ^ m * (A * u) := by rw [hpow]

/-- The selected digit shifts by the actual current coefficient. -/
theorem primeAdicCorrection_selected_digit (p m j k A u : ℕ)
    (hp : 0 < p) (hj : j ≤ m) :
    primeAdicDigit p m
        (primeAdicCorrection p m j k * (A * (p ^ j * u))) =
      (primeAdicDigit p m (A * (p ^ j * u)) + k * ((A * u) % p)) % p := by
  rw [primeAdicCorrection_selected_product p m j k A u hj]
  unfold primeAdicDigit
  rw [show k * p ^ m * (A * u) = p ^ m * (k * (A * u)) by ring,
    Nat.add_mul_div_left _ _ (pow_pos hp _)]
  simp [Nat.add_mod, Nat.mul_mod]

/-- Corrections below a higher level preserve its full residue modulo the next
prime power. -/
theorem primeAdicCorrection_higher_residue (p m j ell k A u : ℕ)
    (hjell : j < ell) (hell : ell ≤ m) :
    (primeAdicCorrection p m j k * (A * (p ^ ell * u))) % (p * p ^ m) =
      (A * (p ^ ell * u)) % (p * p ^ m) := by
  unfold primeAdicCorrection
  have hexp : m - j + ell = (m + 1) + (ell - j - 1) := by omega
  have hpow : p ^ (m - j) * p ^ ell =
      (p * p ^ m) * p ^ (ell - j - 1) := by
    calc
      p ^ (m - j) * p ^ ell = p ^ (m - j + ell) := by rw [← Nat.pow_add]
      _ = p ^ ((m + 1) + (ell - j - 1)) := by rw [hexp]
      _ = p ^ (m + 1) * p ^ (ell - j - 1) := by rw [Nat.pow_add]
      _ = (p * p ^ m) * p ^ (ell - j - 1) := by rw [pow_succ]; ring
  have hprod : (1 + k * p ^ (m - j)) * (A * (p ^ ell * u)) =
      A * (p ^ ell * u) + (p * p ^ m) *
        (k * p ^ (ell - j - 1) * (A * u)) := by
    calc
      _ = A * (p ^ ell * u) + k * (p ^ (m - j) * p ^ ell) * (A * u) := by ring
      _ = _ := by rw [hpow]; ring
  rw [hprod]
  exact Nat.add_mul_mod_self_left _ _ _

/-- Equal residues modulo the next prime-adic power have the same digit. -/
theorem primeAdicDigit_of_mod_eq (p m x y : ℕ)
    (h : x % (p * p ^ m) = y % (p * p ^ m)) :
    primeAdicDigit p m x = primeAdicDigit p m y := by
  unfold primeAdicDigit
  have h' := congrArg (fun z : ℕ => z / p ^ m) h
  simpa [Nat.mod_mul_left_div_self] using h'

/-- Reduction modulo `p^(m+1)` preserves a prime unit and all product
residues. -/
theorem primeAdic_unit_representative (p m A : ℕ)
    (hp : Nat.Prime p) (hA : ¬ p ∣ A) :
    0 < A % (p * p ^ m) ∧ A % (p * p ^ m) < p * p ^ m ∧
      ¬ p ∣ A % (p * p ^ m) ∧ (A % (p * p ^ m)) % p = A % p ∧
        ∀ d : ℕ, ((A % (p * p ^ m)) * d) % (p * p ^ m) =
          (A * d) % (p * p ^ m) := by
  have hp0 : 0 < p := hp.pos
  have hM : 0 < p * p ^ m := by positivity
  have hdiv : p ∣ p * p ^ m := Nat.dvd_mul_right p (p ^ m)
  have hmodp : (A % (p * p ^ m)) % p = A % p := Nat.mod_mod_of_dvd A hdiv
  refine ⟨?_, Nat.mod_lt _ hM, ?_, hmodp, fun d => ?_⟩
  · apply Nat.pos_of_ne_zero
    intro hz
    apply hA
    apply Nat.dvd_iff_mod_eq_zero.mpr
    rw [← hmodp, hz]
    simp
  · intro hd
    apply hA
    apply Nat.dvd_iff_mod_eq_zero.mpr
    rw [← hmodp, Nat.mod_eq_zero_of_dvd hd]
  · simp [Nat.mul_mod]

/-- A positive residue below `p^(m+1)` has an exact prime-adic decomposition
at a level at most `m`.  The explicit bound keeps valuation-at-zero out of
the interface used by compression. -/
theorem primeAdic_positive_bounded_residue_decomposition (p m x : ℕ)
    (hp : Nat.Prime p) (hx : 0 < x) (hxlt : x < p ^ (m + 1)) :
    ∃ ell u : ℕ, ell ≤ m ∧ x = p ^ ell * u ∧ ¬ p ∣ u := by
  letI : Fact (Nat.Prime p) := ⟨hp⟩
  let ell := padicValNat p x
  let u := x / p ^ ell
  have hx0 : x ≠ 0 := hx.ne'
  have hpow : p ^ ell ∣ x := pow_padicValNat_dvd
  have hfactor : p ^ ell * u = x := Nat.mul_div_cancel' hpow
  have hunit : ¬ p ∣ u := by
    intro hdiv
    have hnot : ¬ p ^ (ell + 1) ∣ x := by
      simpa [ell] using (pow_succ_padicValNat_not_dvd (p := p) hx0)
    apply hnot
    rw [pow_succ]
    conv_rhs => rw [← hfactor]
    exact Nat.mul_dvd_mul_left _ hdiv
  have hell : ell ≤ m := by
    by_contra hnot
    have hm : m + 1 ≤ ell := by omega
    have hle : p ^ (m + 1) ≤ p ^ ell :=
      Nat.pow_le_pow_right hp.pos hm
    have hxge : p ^ ell ≤ x := Nat.le_of_dvd hx (by simpa [hfactor] using hpow)
    omega
  exact ⟨ell, u, hell, hfactor.symm, hunit⟩

/-- At a non-top level, the affine correction can prescribe one digit.  The
coefficient is the current `A*u` residue, rather than the initial unit. -/
theorem primeAdicCorrection_exists_target (p m j A u target : ℕ)
    (hp : Nat.Prime p) (hj : j < m) (hA : ¬ p ∣ A) (hu : ¬ p ∣ u)
    (htarget : target < p) :
    ∃ k : Fin p,
      primeAdicDigit p m
          (primeAdicCorrection p m j k.val * (A * (p ^ j * u))) = target := by
  classical
  letI : Fact (Nat.Prime p) := ⟨hp⟩
  let q : Nat := primeAdicDigit p m (A * (p ^ j * u))
  let c : Nat := (A * u) % p
  have hc : (c : ZMod p) ≠ 0 := by
    intro hz
    apply hA
    have hprod : p ∣ A * u := (ZMod.natCast_eq_zero_iff (A * u) p).mp (by
      simpa [c, ZMod.natCast_mod] using hz)
    exact (hp.dvd_mul.mp hprod).resolve_right hu
  let K : ZMod p := ((target : ZMod p) - (q : ZMod p)) / (c : ZMod p)
  let k : Fin p := ⟨K.val, ZMod.val_lt K⟩
  refine ⟨k, ?_⟩
  rw [primeAdicCorrection_selected_digit p m j k.val A u hp.pos (Nat.le_of_lt hj)]
  have hK : (k.val : ZMod p) = K := by
    dsimp [k]
    exact ZMod.natCast_zmod_val K
  have hfield : (q : ZMod p) + (k.val : ZMod p) * (c : ZMod p) = target := by
    rw [hK]
    dsimp [K]
    field_simp
    ring
  have hcast :
      (((q + k.val * c) % p : Nat) : ZMod p) = (target : ZMod p) := by
    rw [ZMod.natCast_mod]
    simpa [Nat.cast_add, Nat.cast_mul] using hfield
  have hleft : (q + k.val * c) % p < p := Nat.mod_lt _ hp.pos
  have hval := congrArg ZMod.val hcast
  rw [ZMod.val_natCast, ZMod.val_natCast] at hval
  simpa [Nat.mod_mod, Nat.mod_eq_of_lt htarget] using hval

/-- At the top level, a nonzero target is selected by a nonzero scalar rather
than a correction of the form `1 + k`. -/
theorem primeAdic_top_exists_target (p m u target : ℕ)
    (hp : Nat.Prime p) (hu : ¬ p ∣ u) (htarget : target < p)
    (htargetpos : 0 < target) :
    ∃ A : ℕ, 0 < A ∧ A < p ∧ ¬ p ∣ A ∧
      primeAdicDigit p m (A * (p ^ m * u)) = target := by
  classical
  letI : Fact (Nat.Prime p) := ⟨hp⟩
  let U : ZMod p := (u : ZMod p)
  have hU : U ≠ 0 := by
    intro hz
    exact hu ((ZMod.natCast_eq_zero_iff u p).mp (by simpa [U] using hz))
  let J : ZMod p := (target : ZMod p) / U
  let A : Fin p := ⟨J.val, ZMod.val_lt J⟩
  have hAeq : primeAdicDigit p m (A.val * (p ^ m * u)) = target := by
    have hA : (A.val : ZMod p) = J := by
      dsimp [A]
      exact ZMod.natCast_zmod_val J
    have hfield : (A.val : ZMod p) * (u : ZMod p) = target := by
      calc
        (A.val : ZMod p) * (u : ZMod p) = J * U := by rw [hA]
        _ = (target : ZMod p) := by
          dsimp [J]
          exact div_mul_cancel₀ _ hU
    unfold primeAdicDigit
    rw [show A.val * (p ^ m * u) = p ^ m * (A.val * u) by ring,
      Nat.mul_div_cancel_left _ (pow_pos hp.pos _)]
    have hcast : (((A.val * u) % p : Nat) : ZMod p) = (target : ZMod p) := by
      rw [ZMod.natCast_mod]
      simpa [Nat.cast_mul] using hfield
    have hval := congrArg ZMod.val hcast
    rw [ZMod.val_natCast, ZMod.val_natCast] at hval
    simpa [Nat.mod_mod, Nat.mod_eq_of_lt htarget] using hval
  refine ⟨A.val, ?_, ZMod.val_lt J, ?_, hAeq⟩
  · apply Nat.pos_of_ne_zero
    intro hzero
    have hzeroDigit : primeAdicDigit p m (A.val * (p ^ m * u)) = 0 := by
      simp [hzero, primeAdicDigit]
    have htargetzero : target = 0 := hAeq.symm.trans hzeroDigit
    omega
  · intro hdiv
    have hmod : A.val % p = 0 := Nat.dvd_iff_mod_eq_zero.mp hdiv
    have : A.val = 0 := by
      rw [Nat.mod_eq_of_lt (ZMod.val_lt J)] at hmod
      exact hmod
    apply htargetpos.ne'
    rw [← hAeq, this]
    simp [primeAdicDigit]

end LonelyRunner
