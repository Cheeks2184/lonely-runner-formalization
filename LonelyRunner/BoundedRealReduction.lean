import LonelyRunner.LowerCountSupply
import LonelyRunner.BHKPositiveCollision
import LonelyRunner.BHKCollisionToWitness
import LonelyRunner.StationaryEquivalence
import Mathlib.NumberTheory.Real.Irrational

/-!
# Bounded reduction from real stationary tuples

This module uses only the count-local lower hypothesis `H_(m + 2)`.  It does
not introduce an all-dimensional rational or real conjecture premise.
-/

namespace LonelyRunner

noncomputable section

open Finset
open scoped BigOperators

/-- A count-local positive-integer supply through `m` moving speeds yields an
ordinary witness for every positive real `Fin m` tuple. -/
theorem positiveRealWitness_of_lowerCount {m : ℕ} (hm : 1 ≤ m)
    (hLower : LowerCountPositiveIntegerHypothesis (m + 2))
    (u : Fin m → ℝ) (hu : ∀ i, 0 < u i) :
    ∃ t : ℝ, ∀ i,
      (((m + 1 : ℕ) : ℝ)⁻¹) ≤ circleNorm (t * u i) := by
  classical
  by_cases hirrational : ∃ p q : Fin m, Irrational (u p / u q)
  · obtain ⟨p, q, hpqIrrational⟩ := hirrational
    have hpq : p ≠ q := by
      intro hpq
      subst q
      have hratio : u p / u p = 1 := div_self (hu p).ne'
      rw [hratio] at hpqIrrational
      exact not_irrational_one hpqIrrational
    have hmTwo : 2 ≤ m := by
      have hcard : 1 < Fintype.card (Fin m) :=
        Fintype.one_lt_card_iff.mpr ⟨p, q, hpq⟩
      have : 1 < m := by simpa using hcard
      omega
    obtain ⟨w, hwzero, _hwrelQ, hwrelR, _hwcollision, hwcard⟩ :=
      exists_bhk_collisionWitness_of_irrational u hu hpqIrrational
    have hLowerSmall : LowerCountPositiveIntegerHypothesis (m + 1) := by
      intro d hd hdmax speeds hinj hpos
      exact hLower d hd (by omega) speeds hinj hpos
    obtain ⟨τ, hτ⟩ := exists_lowerCount_rational_collision
      (N := m + 1) (m := m) (by omega) (by omega) w hwzero (by omega) hLowerSmall
    have hmpos : 0 < m := by omega
    have hmRealPos : (0 : ℝ) < m := by exact_mod_cast hmpos
    have hmSuccRealPos : (0 : ℝ) < ((m + 1 : ℕ) : ℝ) := by positivity
    have hstrictMargin : (((m + 1 : ℕ) : ℝ)⁻¹) < (m : ℝ)⁻¹ := by
      apply (inv_lt_inv₀ hmSuccRealPos hmRealPos).2
      exact_mod_cast Nat.lt_succ_self m
    obtain ⟨t, ht⟩ := exists_stationaryStrictWitness_of_relations
      u (fun i => (w i : ℝ)) (((m + 1 : ℕ) : ℝ)⁻¹) τ hwrelR
      (fun i => hstrictMargin.trans_le (hτ i))
    exact ⟨t, fun i => (ht i).le⟩
  · push Not at hirrational
    have hmpos : 0 < m := Nat.zero_lt_of_lt hm
    let first : Fin m := ⟨0, hmpos⟩
    have hfirst : u first ≠ 0 := (hu first).ne'
    have hratioRational : ∀ i, ¬ Irrational (u i / u first) := by
      intro i
      exact hirrational i first
    choose q hq using fun i => exists_rat_of_not_irrational (hratioRational i)
    have hqnonzero : ∀ i, q i ≠ 0 := by
      intro i hzero
      have hratiozero : u i / u first = 0 := by simpa [hzero] using hq i
      have huzero : u i = 0 := (div_eq_zero_iff.mp hratiozero).resolve_right hfirst
      exact (hu i).ne' huzero
    have hcard : (Finset.univ.image (fun i => |q i|)).card ≤ (m + 2) - 2 := by
      have hle : (Finset.univ.image (fun i => |q i|)).card ≤ (Finset.univ : Finset (Fin m)).card :=
        Finset.card_image_le
      simpa using hle
    obtain ⟨τ, hτ⟩ := exists_lowerCount_rational_collision
      (N := m + 2) (m := m) (by omega) hmpos q hqnonzero hcard hLower
    refine ⟨τ / u first, fun i => ?_⟩
    have hphase : (τ / u first) * u i = τ * (u i / u first) := by
      field_simp [hfirst]
    rw [hphase, hq i]
    exact hτ i

/-- The same count-local supply applies to arbitrary nonzero real stationary
tuples after coordinatewise sign normalization. -/
theorem stationaryWitness_of_lowerCount {m : ℕ} (hm : 1 ≤ m)
    (hLower : LowerCountPositiveIntegerHypothesis (m + 2))
    (v : Fin m → ℝ) (hv : ∀ i, v i ≠ 0) :
    ∃ t : ℝ, ∀ i,
      (((m + 1 : ℕ) : ℝ)⁻¹) ≤ circleNorm (t * v i) := by
  let positive : Fin m → ℝ := fun i => |v i|
  have hpositive : ∀ i, 0 < positive i := fun i => abs_pos.mpr (hv i)
  obtain ⟨t, ht⟩ := positiveRealWitness_of_lowerCount hm hLower positive hpositive
  refine ⟨t, fun i => ?_⟩
  simpa [positive, circleNorm_mul_abs_right] using ht i

/-- The count-local stationary witness yields a labelled ordinary witness for
any selected runner in an injective real family of size `m + 1`. -/
theorem lonelyAt_of_lowerCount {m : ℕ} (hm : 1 ≤ m)
    (hLower : LowerCountPositiveIntegerHypothesis (m + 2))
    (speeds : Fin (m + 1) → ℝ) (hinj : Function.Injective speeds)
    (runner : Fin (m + 1)) : ∃ t : ℝ, LonelyAt speeds runner t := by
  let relative : Fin m → ℝ := fun i => speeds (runner.succAbove i) - speeds runner
  have hrelativeNonzero : ∀ i, relative i ≠ 0 := by
    simpa [relative] using relative_succAbove_ne_zero hinj runner
  obtain ⟨t, ht⟩ := stationaryWitness_of_lowerCount hm hLower relative hrelativeNonzero
  refine ⟨t, (lonelyAt_iff_relativeLonelyAt speeds runner t).mpr ?_⟩
  intro other hother
  obtain ⟨i, rfl⟩ := Fin.exists_succAbove_eq hother
  simpa [relative, circleNorm] using ht i

end

end LonelyRunner
