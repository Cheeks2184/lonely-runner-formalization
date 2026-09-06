import LonelyRunner.PivotResidues
import LonelyRunner.FiveAdicCarry
import LonelyRunner.FiveAdicFiltering
import Mathlib.Tactic

/-!
# Natural five-adic hard-pattern adapter

This module contains modulus-independent cyclic-distance normalization together
with the natural carry-state adapter used by the five-adic hard pattern.  It
depends on the checked carry and filtering arithmetic interfaces.
-/

namespace LonelyRunner

/-- Cyclic distance depends only on the residue modulo its modulus. -/
theorem cyclicResidueDistance_eq_of_mod_eq (P x y : Nat)
    (h : x % P = y % P) :
    cyclicResidueDistance P x = cyclicResidueDistance P y := by
  unfold cyclicResidueDistance
  rw [h]

/-- Residues whose sum is zero modulo a positive modulus have the same cyclic
distance.  This includes the zero-residue and half-modulus boundary cases. -/
theorem cyclicResidueDistance_eq_of_add_mod_eq_zero (P X Y : Nat)
    (hP : 0 < P) (h : (X + Y) % P = 0) :
    cyclicResidueDistance P X = cyclicResidueDistance P Y := by
  have hX : X % P < P := Nat.mod_lt _ hP
  have hY : Y % P < P := Nat.mod_lt _ hP
  have hmod : (X % P + Y % P) % P = 0 := by
    simpa [Nat.add_mod] using h
  by_cases hlt : X % P + Y % P < P
  · have hsmall : (X % P + Y % P) % P = X % P + Y % P :=
      Nat.mod_eq_of_lt hlt
    rw [hsmall] at hmod
    have hzeroX : X % P = 0 := by omega
    have hzeroY : Y % P = 0 := by omega
    simp [cyclicResidueDistance, hzeroX, hzeroY]
  · have hle : P ≤ X % P + Y % P := Nat.le_of_not_gt hlt
    have hsum_lt : X % P + Y % P < P + P := by omega
    have hlarge : (X % P + Y % P) % P = X % P + Y % P - P := by
      calc
        (X % P + Y % P) % P = (X % P + Y % P - P) % P :=
          Nat.mod_eq_sub_mod hle
        _ = X % P + Y % P - P := Nat.mod_eq_of_lt (by omega)
    rw [hlarge] at hmod
    have hsum : X % P + Y % P = P := by omega
    unfold cyclicResidueDistance
    have hcompX : P - X % P = Y % P := by omega
    have hcompY : P - Y % P = X % P := by omega
    rw [hcompX, hcompY, Nat.min_comm]

/-- Replacing a residue by its natural complement preserves cyclic distance
after every natural multiplier; no cancellation or unit hypothesis is used. -/
theorem cyclicResidueDistance_mul_complement (P s A : Nat)
    (hP : 0 < P) (hs : s ≤ P) :
    cyclicResidueDistance P (A * (P - s)) =
      cyclicResidueDistance P (A * s) := by
  apply cyclicResidueDistance_eq_of_add_mod_eq_zero P _ _ hP
  have hsum : A * (P - s) + A * s = A * P := by
    rw [← Nat.mul_add, Nat.sub_add_cancel hs]
  rw [hsum]
  exact Nat.mod_eq_zero_of_dvd (dvd_mul_left P A)

/-- A five-unit has a representative below `5 * 5^m` with residue one or two.
The resulting representative preserves cyclic distance for every multiplier. -/
theorem fiveAdic_normalize_unit (m d : Nat) (hd : ¬ 5 ∣ d) :
    ∃ x : Nat, 0 < x ∧ x < 5 * 5^m ∧ (x % 5 = 1 ∨ x % 5 = 2) ∧
      ∀ A : Nat,
        cyclicResidueDistance (5 * 5^m) (A * x) =
          cyclicResidueDistance (5 * 5^m) (A * d) := by
  let P := 5 * 5^m
  let s := d % P
  have hP : 0 < P := by
    dsimp [P]
    positivity
  have hfiveP : 5 ∣ P := by
    dsimp [P]
    exact dvd_mul_right 5 (5 ^ m)
  have hslt : s < P := by
    dsimp [s]
    exact Nat.mod_lt _ hP
  have hsmod : s % 5 = d % 5 := by
    dsimp [s]
    exact Nat.mod_mod_of_dvd d hfiveP
  have hdmod : d % 5 ≠ 0 := by
    intro hzero
    apply hd
    exact Nat.dvd_iff_mod_eq_zero.mpr hzero
  have hsmod_ne : s % 5 ≠ 0 := by simpa [hsmod] using hdmod
  have hspos : 0 < s := by
    by_contra hnot
    have hzero : s = 0 := Nat.eq_zero_of_not_pos hnot
    apply hsmod_ne
    simp [hzero]
  by_cases hsmall : s % 5 = 1 ∨ s % 5 = 2
  · refine ⟨s, hspos, hslt, hsmall, ?_⟩
    intro A
    apply cyclicResidueDistance_eq_of_mod_eq
    change (A * (d % P)) % P = (A * d) % P
    simp [Nat.mul_mod]
  · have hsmod_lt : s % 5 < 5 := Nat.mod_lt _ (by omega)
    have hsres : s % 5 = 3 ∨ s % 5 = 4 := by omega
    refine ⟨P - s, ?_, ?_, ?_, ?_⟩
    · omega
    · omega
    · have hsum : (P - s) + s = P := Nat.sub_add_cancel hslt.le
      have hsum_mod : ((P - s) + s) % 5 = 0 := by
        rw [hsum]
        exact Nat.dvd_iff_mod_eq_zero.mp hfiveP
      have hmod : ((P - s) % 5 + s % 5) % 5 = 0 := by
        simpa [Nat.add_mod] using hsum_mod
      have hxlt : (P - s) % 5 < 5 := Nat.mod_lt _ (by omega)
      rcases hsres with hs3 | hs4 <;> omega
    · intro A
      calc
        cyclicResidueDistance P (A * (P - s)) =
            cyclicResidueDistance P (A * s) :=
          cyclicResidueDistance_mul_complement P s A hP hslt.le
        _ = cyclicResidueDistance P (A * d) := by
          apply cyclicResidueDistance_eq_of_mod_eq
          change (A * (d % P)) % P = (A * d) % P
          simp [Nat.mul_mod]

/-- The coupled tag for the carries of one, two, and three copies of a
remainder.  Strict comparisons deliberately put each equality on the upper
closed interval. -/
def fiveAdicCarryTag (R z : Nat) : Fin 4 :=
  if 3 * z < R then 0 else if 2 * z < R then 1 else
    if 3 * z < 2 * R then 2 else 3

/-- One tag realizes all three quotient carries at once.  This statement is
generic in the positive denominator, including the equality boundaries. -/
theorem fiveAdicCarryTag_spec (R z : Nat) (hR : 0 < R) (hz : z < R) :
    ∀ u : Fin 3,
      fiveCarryCarry (fiveAdicCarryTag R z) u = ((u.val + 1) * z) / R := by
  intro u
  have hu : u.val = 0 ∨ u.val = 1 ∨ u.val = 2 := by omega
  rcases hu with hu | hu | hu
  · have : u = (0 : Fin 3) := Fin.ext hu
    subst u
    have hzero : fiveCarryCarry (fiveAdicCarryTag R z) 0 = 0 := by
      unfold fiveAdicCarryTag
      split_ifs <;> decide
    rw [hzero]
    simpa using (Nat.div_eq_of_lt hz).symm
  · have : u = (1 : Fin 3) := Fin.ext hu
    subst u
    by_cases h3 : 3 * z < R
    · simp [fiveAdicCarryTag, fiveCarryCarry, h3]
      exact (Nat.div_eq_of_lt (by omega)).symm
    · by_cases h2 : 2 * z < R
      · simp [fiveAdicCarryTag, fiveCarryCarry, h3, h2]
        exact (Nat.div_eq_of_lt h2).symm
      · by_cases h32 : 3 * z < 2 * R
        · simp [fiveAdicCarryTag, fiveCarryCarry, h3, h2, h32]
          have hq : 2 * z / R = 1 := by
            simpa using Nat.div_eq_of_lt_le (show 1 * R ≤ 2 * z by omega)
              (show 2 * z < (1 + 1) * R by omega)
          exact hq.symm
        · simp [fiveAdicCarryTag, fiveCarryCarry, h3, h2, h32]
          have hq : 2 * z / R = 1 := by
            simpa using Nat.div_eq_of_lt_le (show 1 * R ≤ 2 * z by omega)
              (show 2 * z < (1 + 1) * R by omega)
          exact hq.symm
  · have : u = (2 : Fin 3) := Fin.ext hu
    subst u
    by_cases h3 : 3 * z < R
    · simp [fiveAdicCarryTag, fiveCarryCarry, h3]
      exact (Nat.div_eq_of_lt h3).symm
    · by_cases h2 : 2 * z < R
      · simp [fiveAdicCarryTag, fiveCarryCarry, h3, h2]
        have hq : 3 * z / R = 1 := by
          simpa using Nat.div_eq_of_lt_le (show 1 * R ≤ 3 * z by omega)
            (show 3 * z < (1 + 1) * R by omega)
        exact hq.symm
      · by_cases h32 : 3 * z < 2 * R
        · simp [fiveAdicCarryTag, fiveCarryCarry, h3, h2, h32]
          have hq : 3 * z / R = 1 := by
            simpa using Nat.div_eq_of_lt_le (show 1 * R ≤ 3 * z by omega)
              (show 3 * z < (1 + 1) * R by omega)
          exact hq.symm
        · simp [fiveAdicCarryTag, fiveCarryCarry, h3, h2, h32]
          have hq : 3 * z / R = 2 := by
            simpa using Nat.div_eq_of_lt_le (show 2 * R ≤ 3 * z by omega)
              (show 3 * z < (2 + 1) * R by omega)
          exact hq.symm

/-- Decode the two normalized residue classes into the zero-based field used
by `FiveCarryState`. -/
def fiveAdicCarryResidue (x : Nat) (hr : x % 5 = 1 ∨ x % 5 = 2) : Fin 2 :=
  if h : x % 5 = 1 then 0 else 1

/-- The carry state attached to a normalized natural representative. -/
def fiveAdicCarryState (m x : Nat) (hx : x < 5 * 5^m)
    (hr : x % 5 = 1 ∨ x % 5 = 2) : FiveCarryState :=
  { top := ⟨x / 5^m, by
      have hR : 0 < 5^m := pow_pos (by omega) _
      rw [Nat.div_lt_iff_lt_mul hR]
      simpa [Nat.mul_comm] using hx⟩
    residue := fiveAdicCarryResidue x hr
    carry := fiveAdicCarryTag (5^m) (x % 5^m) }

theorem fiveAdicCarryState_top (m x : Nat) (hx : x < 5 * 5^m)
    (hr : x % 5 = 1 ∨ x % 5 = 2) :
    (fiveAdicCarryState m x hx hr).top.val = x / 5^m := rfl

theorem fiveAdicCarryState_residue (m x : Nat) (hx : x < 5 * 5^m)
    (hr : x % 5 = 1 ∨ x % 5 = 2) :
    (fiveAdicCarryState m x hx hr).residue.val + 1 = x % 5 := by
  simp [fiveAdicCarryState, fiveAdicCarryResidue]
  split <;> omega

theorem fiveAdicCarryState_carry (m x : Nat) (hx : x < 5 * 5^m)
    (hr : x % 5 = 1 ∨ x % 5 = 2) (u : Fin 3) :
    fiveCarryCarry (fiveAdicCarryState m x hx hr).carry u =
      ((u.val + 1) * (x % 5^m)) / 5^m := by
  apply fiveAdicCarryTag_spec
  · positivity
  · exact Nat.mod_lt _ (pow_pos (by omega) _)

/-- The selected top digit agrees exactly with the finite carry digit.  The
current multiplier is retained in the correction coefficient, so the term is
`(u.val + 1) * k.val * (x % 5)`. -/
theorem fiveAdicCarryState_digit (m x : Nat) (hx : x < 5 * 5^m)
    (hr : x % 5 = 1 ∨ x % 5 = 2) (u : Fin 3) (k : Fin 5) :
    fiveAdicDigit m (((u.val+1)*(1+k.val*5^m))*x) =
      (fiveCarryDigit (fiveAdicCarryState m x hx hr) u k).val := by
  have hR : 0 < 5 ^ m := pow_pos (by omega) _
  have hdiv : ((u.val + 1) * x) / 5 ^ m =
      (u.val + 1) * (x / 5 ^ m) + ((u.val + 1) * (x % 5 ^ m)) / 5 ^ m := by
    calc
      ((u.val + 1) * x) / 5 ^ m =
          ((u.val + 1) * (x % 5 ^ m + 5 ^ m * (x / 5 ^ m))) / 5 ^ m := by
            rw [Nat.mod_add_div]
      _ = ((u.val + 1) * (x % 5 ^ m) +
          5 ^ m * ((u.val + 1) * (x / 5 ^ m))) / 5 ^ m := by ring
      _ = ((u.val + 1) * (x % 5 ^ m)) / 5 ^ m +
          (u.val + 1) * (x / 5 ^ m) := by rw [Nat.add_mul_div_left _ _ hR]
      _ = _ := by omega
  rw [show ((u.val + 1) * (1 + k.val * 5 ^ m)) * x =
      (1 + k.val * 5 ^ m) * ((u.val + 1) * x) by ring]
  rw [show 1 + k.val * 5 ^ m = fiveAdicCorrection m 0 k.val by simp [fiveAdicCorrection]]
  have hselected := fiveAdicCorrection_selected_digit m 0 k.val (u.val + 1) x (by omega)
  rw [show fiveAdicDigit m (fiveAdicCorrection m 0 k.val * ((u.val + 1) * x)) =
      (fiveAdicDigit m ((u.val + 1) * x) + k.val * (((u.val + 1) * x) % 5)) % 5 by
    simpa using hselected]
  unfold fiveAdicDigit
  rw [hdiv]
  change (((u.val + 1) * (x / 5 ^ m) + ((u.val + 1) * (x % 5 ^ m)) / 5 ^ m) % 5 +
      k.val * ((u.val + 1) * x % 5)) % 5 =
    (((u.val + 1) * (x / 5 ^ m) +
      fiveCarryCarry (fiveAdicCarryTag (5 ^ m) (x % 5 ^ m)) u +
      (u.val + 1) * k.val * ((fiveAdicCarryResidue x hr).val + 1)) % 5)
  rw [fiveAdicCarryTag_spec (5 ^ m) (x % 5 ^ m) (pow_pos (by omega) _) (Nat.mod_lt _ (pow_pos (by omega) _))]
  have hres : (fiveAdicCarryResidue x hr).val + 1 = x % 5 := by
    simp [fiveAdicCarryResidue]
    split <;> omega
  rw [hres]
  rw [show ((u.val + 1) * x) % 5 = ((u.val + 1) * (x % 5)) % 5 by
    simp [Nat.mul_mod]]
  simp [Nat.mul_mod, Nat.add_mod, Nat.mul_assoc, Nat.mul_comm]

/-- The finite carry alternative supplies one five-adic hard-pattern
multiplier for three arbitrary five-units and one top-level five-unit. -/
theorem fiveAdic_hard_pattern_of_carry
    (hcarry : ∀ s : Fin 3 → FiveCarryState,
      ∃ u : Fin 3, ∃ k : Fin 5, ∀ i,
        (fiveCarryDigit (s i) u k).val ∈ ({1, 2, 3} : Finset Nat))
    (m : Nat) (hm : 1 ≤ m) (d : Fin 3 → Nat)
    (hd : ∀ i, ¬ 5 ∣ d i) (v : Nat) (hv : ¬ 5 ∣ v) :
    ∃ lam : Nat, 0 < lam ∧ lam < 5 * 5^m ∧ ¬ 5 ∣ lam ∧
      (∀ i, 5^m ≤ cyclicResidueDistance (5 * 5^m) (lam * d i)) ∧
      5^m ≤ cyclicResidueDistance (5 * 5^m) (lam * (5^m * v)) := by
  classical
  choose x hxpos hxbound hxres hnorm using
    fun i => fiveAdic_normalize_unit m (d i) (hd i)
  let s : Fin 3 → FiveCarryState := fun i =>
    fiveAdicCarryState m (x i) (hxbound i) (hxres i)
  obtain ⟨u, k, hgood⟩ := hcarry s
  let A : Nat := (u.val + 1) * (1 + k.val * 5^m)
  have hgood_distance : ∀ i, 5^m ≤ cyclicResidueDistance (5 * 5^m) (A * x i) := by
    intro i
    apply fiveAdicGoodDigit_distance
    unfold FiveAdicGoodDigit
    have hdigit : fiveAdicDigit m (A * x i) =
        (fiveCarryDigit (s i) u k).val := by
      change fiveAdicDigit m (((u.val + 1) * (1 + k.val * 5^m)) * x i) = _
      exact fiveAdicCarryState_digit m (x i) (hxbound i) (hxres i) u k
    rw [hdigit]
    have hmem := hgood i
    simp only [Finset.mem_insert, Finset.mem_singleton] at hmem
    omega
  have hm0 : 0 < m := by omega
  have hcorr : (1 + k.val * 5^m) % 5 = 1 := by
    simpa [fiveAdicCorrection] using fiveAdicCorrection_mod_five m 0 k.val hm0
  have hu_lt : u.val + 1 < 5 := by omega
  have hAmod : A % 5 = u.val + 1 := by
    dsimp [A]
    simp [Nat.mul_mod, hcorr, Nat.mod_eq_of_lt hu_lt]
  have hAunit : ¬ 5 ∣ A := by
    intro hdiv
    have : A % 5 = 0 := Nat.dvd_iff_mod_eq_zero.mp hdiv
    rw [hAmod] at this
    omega
  have htopunit : ¬ 5 ∣ A * v := by
    intro hdiv
    rcases (Nat.Prime.dvd_mul (by norm_num : Nat.Prime 5)).mp hdiv with hA | hv'
    · exact hAunit hA
    · exact hv hv'
  rcases fiveAdic_unit_representative m A hAunit with
    ⟨hlpos, hlllt, hlunit, hlmod, hproduct⟩
  refine ⟨A % (5 * 5^m), hlpos, hlllt, hlunit, ?_, ?_⟩
  · intro i
    have horiginal : 5^m ≤ cyclicResidueDistance (5 * 5^m) (A * d i) := by
      rw [← hnorm i A]
      exact hgood_distance i
    rw [cyclicResidueDistance_eq_of_mod_eq _ _ _ (hproduct (d i))]
    exact horiginal
  · have htop := fiveAdic_top_distance m A v htopunit
    rw [cyclicResidueDistance_eq_of_mod_eq _ _ _ (hproduct (5^m * v))]
    exact htop

/-- The checked finite carry theorem supplies the carry premise unconditionally. -/
theorem fiveAdic_hard_pattern (m : Nat) (hm : 1 ≤ m) (d : Fin 3 → Nat)
    (hd : ∀ i, ¬ 5 ∣ d i) (v : Nat) (hv : ¬ 5 ∣ v) :
    ∃ lam : Nat, 0 < lam ∧ lam < 5 * 5^m ∧ ¬ 5 ∣ lam ∧
      (∀ i, 5^m ≤ cyclicResidueDistance (5 * 5^m) (lam * d i)) ∧
      5^m ≤ cyclicResidueDistance (5 * 5^m) (lam * (5^m * v)) := by
  exact fiveAdic_hard_pattern_of_carry fiveCarryTriple m hm d hd v hv

end LonelyRunner
