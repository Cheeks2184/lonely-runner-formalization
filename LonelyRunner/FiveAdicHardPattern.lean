import LonelyRunner.PivotResidues
import Mathlib.Tactic

/-!
# Natural five-adic normalization

This module contains only the modulus-independent cyclic-distance symmetry and
the natural representative normalization used by the later hard-pattern
adapter.  It deliberately has no dependency on the carry or filtering modules.
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

end LonelyRunner
