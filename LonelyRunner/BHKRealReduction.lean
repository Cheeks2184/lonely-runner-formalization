import LonelyRunner.BHKCollisionToWitness
import LonelyRunner.BHKPositiveCollision
import LonelyRunner.RepeatedStationaryEquivalence
import Mathlib.NumberTheory.Real.Irrational

/-!
# Exact BHK reduction from real to rational velocities

This file completes the real-to-rational reduction without asserting the
Lonely Runner Conjecture itself.  In the irrational-ratio branch, the finite
BHK construction supplies a compatible rational collision vector and the
strict lower-dimensional margin transfers through orbit closure.  If every
ratio is rational, the real tuple is a common nonzero real multiple of a
positive rational tuple and time rescaling is exact.
-/

namespace LonelyRunner

noncomputable section

open Finset
open scoped BigOperators

/-- Assuming the all-dimensional positive-rational conjecture, every positive
real stationary tuple has the required witness. -/
theorem positiveRationalConjecture_implies_positiveRealWitness
    (hRational : PositiveRationalConjecture) {m : ℕ} (hm : 1 ≤ m)
    (u : Fin m → ℝ) (hu : ∀ i, 0 < u i) :
    ∃ time : ℝ, ∀ i,
      (((m + 1 : ℕ) : ℝ)⁻¹) ≤ circleNorm (time * u i) := by
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
    exact exists_stationaryWitness_of_rational_collision
      hmTwo u w hwzero hwcard hwrelR hRational
  · push Not at hirrational
    have hmpos : 0 < m := Nat.zero_lt_of_lt hm
    let first : Fin m := ⟨0, hmpos⟩
    have hfirst : u first ≠ 0 := (hu first).ne'
    have hratioRational : ∀ i, ¬ Irrational (u i / u first) := by
      intro i
      exact hirrational i first
    choose rationalSpeeds hratio using fun i =>
      exists_rat_of_not_irrational (hratioRational i)
    have hrationalPositive : ∀ i, 0 < rationalSpeeds i := by
      intro i
      have hcast : (0 : ℝ) < (rationalSpeeds i : ℝ) := by
        rw [← hratio i]
        exact div_pos (hu i) (hu first)
      exact_mod_cast hcast
    obtain ⟨τ, hτ⟩ :=
      hRational m hm rationalSpeeds hrationalPositive
    refine ⟨τ / u first, fun i => ?_⟩
    have hphase : (τ / u first) * u i = τ * (u i / u first) := by
      field_simp [hfirst]
    rw [hphase, hratio i]
    exact hτ i

/-- The BHK reduction, including coordinatewise sign normalization: the
all-dimensional positive-rational formulation implies the ordinary stationary
real formulation. -/
theorem positiveRationalConjecture_implies_stationaryConjecture :
    PositiveRationalConjecture → StationaryConjecture := by
  intro hRational n hn speeds hnonzero
  let positiveSpeeds : Fin n → ℝ := fun i => |speeds i|
  have hpositive : ∀ i, 0 < positiveSpeeds i := by
    intro i
    exact abs_pos.mpr (hnonzero i)
  obtain ⟨time, htime⟩ :=
    positiveRationalConjecture_implies_positiveRealWitness
      hRational hn positiveSpeeds hpositive
  refine ⟨time, fun i => ?_⟩
  have hi := htime i
  change (((n + 1 : ℕ) : ℝ)⁻¹) ≤ circleNorm (time * |speeds i|) at hi
  rw [circleNorm_mul_abs_right] at hi
  simpa [circleNorm] using hi

/-- Specializing a stationary real theorem to positive rational speeds gives
the converse implication. -/
theorem stationaryConjecture_implies_positiveRationalConjecture :
    StationaryConjecture → PositiveRationalConjecture := by
  intro hStationary n hn speeds hpositive
  have hnonzero : ∀ i, (speeds i : ℝ) ≠ 0 := by
    intro i
    exact Rat.cast_ne_zero.mpr (ne_of_gt (hpositive i))
  obtain ⟨time, htime⟩ :=
    hStationary n hn (fun i => (speeds i : ℝ)) hnonzero
  refine ⟨time, fun i => ?_⟩
  simpa [circleNorm] using htime i

/-- Exact equivalence of the real stationary and positive-rational
all-dimensional formulations. -/
theorem stationaryConjecture_iff_positiveRationalConjecture :
    StationaryConjecture ↔ PositiveRationalConjecture :=
  ⟨stationaryConjecture_implies_positiveRationalConjecture,
    positiveRationalConjecture_implies_stationaryConjecture⟩

/-- The canonical labelled real formulation is exactly equivalent to the
positive-integer formulation.  This is a reduction theorem, not a proof of
either equivalent proposition. -/
theorem conjecture_iff_positiveIntegerConjecture :
    Conjecture ↔ PositiveIntegerConjecture :=
  conjecture_iff_stationaryConjecture.trans
    (stationaryConjecture_iff_positiveRationalConjecture.trans
      positiveIntegerConjecture_iff_positiveRationalConjecture.symm)

end

end LonelyRunner
