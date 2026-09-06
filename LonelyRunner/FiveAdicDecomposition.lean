import LonelyRunner.PivotResidues
import Mathlib.Tactic

/-!
# Five-adic decomposition adapters

This module isolates the two elementary adapters needed before the five-adic
filter can be applied to four positive natural speeds.  It deliberately does
not assemble a hard-pattern theorem or a Lonely Runner theorem.
-/

namespace LonelyRunner

/-- The exponent of five in a positive natural speed. -/
def fiveAdicExponent (v : ℕ) : ℕ := padicValNat 5 v

/-- The five-adic unit part of a natural speed. -/
def fiveAdicUnit (v : ℕ) : ℕ := v / 5 ^ fiveAdicExponent v

/-- A positive natural has its exact five-adic decomposition at five. -/
theorem fiveAdic_positive_decomposition (v : ℕ) (hv : 0 < v) :
    v = 5 ^ fiveAdicExponent v * fiveAdicUnit v ∧
      0 < fiveAdicUnit v ∧ ¬ 5 ∣ fiveAdicUnit v := by
  letI : Fact (Nat.Prime 5) := ⟨by decide⟩
  have hv0 : v ≠ 0 := hv.ne'
  have hpow : 5 ^ fiveAdicExponent v ∣ v := by
    exact pow_padicValNat_dvd
  have hfactor : 5 ^ fiveAdicExponent v * fiveAdicUnit v = v := by
    exact Nat.mul_div_cancel' hpow
  refine ⟨hfactor.symm, ?_, ?_⟩
  · apply Nat.pos_of_ne_zero
    intro hu
    have : v = 0 := by simpa [hu] using hfactor.symm
    exact hv0 this
  · intro hunit
    have hnot : ¬ 5 ^ (padicValNat 5 v + 1) ∣ v :=
      pow_succ_padicValNat_not_dvd (p := 5) hv0
    apply hnot
    rw [pow_succ]
    conv_rhs => rw [← hfactor]
    change 5 ^ fiveAdicExponent v * 5 ∣
      5 ^ fiveAdicExponent v * fiveAdicUnit v
    have hdvd : 5 ^ fiveAdicExponent v * 5 ∣
        5 ^ fiveAdicExponent v * fiveAdicUnit v :=
      Nat.mul_dvd_mul_left _ hunit
    exact hdvd

/-- Scaling both modulus and argument by the same natural scales cyclic
distance exactly.  The equality includes the degenerate `g = 0` case. -/
theorem fiveAdic_cyclicResidueDistance_mul_left (g P x : ℕ) :
    cyclicResidueDistance (g * P) (g * x) =
      g * cyclicResidueDistance P x := by
  unfold cyclicResidueDistance
  rw [Nat.mul_mod_mul_left, ← Nat.mul_sub_left_distrib]
  by_cases h : x % P ≤ P - x % P
  · rw [Nat.min_eq_left h]
    exact Nat.min_eq_left (Nat.mul_le_mul_left g h)
  · have h' : P - x % P ≤ x % P := Nat.le_of_not_ge h
    rw [Nat.min_eq_right h']
    exact Nat.min_eq_right (Nat.mul_le_mul_left g h')

/-- For four labels, either every layer strictly below an attained maximum has
at most two members, or a crowded lower layer consists of exactly the three
nonmaximum positions. -/
theorem fin4_level_dichotomy (ell : Fin 4 → ℕ) (m : ℕ)
    (_hbound : ∀ i, ell i ≤ m) (hmax : ∃ p, ell p = m) :
    (∀ j, j < m → (Finset.univ.filter fun i => ell i = j).card ≤ 2) ∨
      ∃ j, j < m ∧ ∃ p : Fin 4, ell p = m ∧
        ∀ i, i ≠ p → ell i = j := by
  classical
  by_cases hfiltered : ∀ j, j < m →
      (Finset.univ.filter fun i => ell i = j).card ≤ 2
  · exact Or.inl hfiltered
  · right
    push Not at hfiltered
    obtain ⟨j, hjm, hjcard⟩ := hfiltered
    obtain ⟨p, hp⟩ := hmax
    let S : Finset (Fin 4) := Finset.univ.filter fun i => ell i = j
    have hpnot : p ∉ S := by
      simp only [S, Finset.mem_filter, Finset.mem_univ, true_and]
      intro h
      omega
    have hsub : S ⊆ Finset.univ.erase p := by
      intro i hi
      simp only [Finset.mem_erase, Finset.mem_univ, and_true]
      intro hip
      subst i
      exact hpnot hi
    have herasecard : (Finset.univ.erase p : Finset (Fin 4)).card = 3 := by
      rw [Finset.card_erase_of_mem (Finset.mem_univ p)]
      simp
    have hScard : S.card = 3 := by
      have hle : S.card ≤ 3 := by
        rw [← herasecard]
        exact Finset.card_le_card hsub
      have hgt : 2 < S.card := by simpa [S] using hjcard
      omega
    have hsets : S = Finset.univ.erase p := by
      apply Finset.eq_of_subset_of_card_le hsub
      rw [hScard, herasecard]
    refine ⟨j, hjm, p, hp, ?_⟩
    intro i hip
    have hiS : i ∈ S := by
      rw [hsets]
      simp [hip]
    simpa [S] using hiS

end LonelyRunner
