import LonelyRunner.StationaryEquivalence
import Mathlib.Data.Fintype.Card
import Mathlib.Data.Fintype.EquivFin
import Mathlib.Data.Set.Finite.Range

/-!
# Removing repeated stationary speeds

This file isolates the finite deduplication needed to pass from the stationary
formulation with pairwise-distinct moving speeds to the formulation in which
the input tuple may repeat speeds.  The key point is that the distinct tuple
has some cardinality `m ≤ n`; its stronger bound `1 / (m + 1)` implies the
requested bound `1 / (n + 1)` for every occurrence of a repeated speed.
-/

namespace LonelyRunner

/-- Allowing repeated nonzero speeds does not strengthen the all-dimensional
stationary Lonely Runner Conjecture. -/
theorem distinctStationaryConjecture_iff_stationaryConjecture :
    DistinctStationaryConjecture ↔ StationaryConjecture := by
  constructor
  · intro hDistinct n hn speeds hnonzero
    classical
    let speedRange := Set.range speeds
    letI : Fintype speedRange := (Set.finite_range speeds).fintype
    let m := Fintype.card speedRange
    let enumerate : Fin m ≃ speedRange := (Fintype.equivFin speedRange).symm
    let distinctSpeeds : Fin m → ℝ := fun j ↦ (enumerate j : ℝ)

    have hm_pos : 1 ≤ m := by
      let first : Fin n := ⟨0, Nat.zero_lt_of_lt hn⟩
      have hRangeNonempty : Nonempty speedRange :=
        ⟨⟨speeds first, ⟨first, rfl⟩⟩⟩
      have hm_zero_lt : 0 < m := by
        simpa [m] using (Fintype.card_pos_iff.mpr hRangeNonempty)
      omega

    have hDistinctSpeeds : Function.Injective distinctSpeeds := by
      intro a b hab
      apply enumerate.injective
      apply Subtype.ext
      exact hab

    have hDistinctNonzero : ∀ j, distinctSpeeds j ≠ 0 := by
      intro j
      rcases (enumerate j).property with ⟨i, hi⟩
      intro hj
      apply hnonzero i
      calc
        speeds i = (enumerate j : ℝ) := hi
        _ = distinctSpeeds j := rfl
        _ = 0 := hj

    obtain ⟨time, htime⟩ :=
      hDistinct m hm_pos distinctSpeeds hDistinctSpeeds hDistinctNonzero

    have hm_le_n : m ≤ n := by
      simpa [m, speedRange] using Fintype.card_range_le speeds

    have hbound : (((n + 1 : ℕ) : ℝ)⁻¹) ≤ (((m + 1 : ℕ) : ℝ)⁻¹) := by
      apply inv_anti₀
      · positivity
      · exact_mod_cast Nat.add_le_add_right hm_le_n 1

    refine ⟨time, ?_⟩
    intro i
    let occurrence : speedRange := ⟨speeds i, ⟨i, rfl⟩⟩
    let j : Fin m := enumerate.symm occurrence
    have hspeed : distinctSpeeds j = speeds i := by
      change ((enumerate (enumerate.symm occurrence) : speedRange) : ℝ) = speeds i
      simp [occurrence]
    calc
      (((n + 1 : ℕ) : ℝ)⁻¹) ≤ (((m + 1 : ℕ) : ℝ)⁻¹) := hbound
      _ ≤ ‖((time * distinctSpeeds j : ℝ) : UnitCircle)‖ := htime j
      _ = ‖((time * speeds i : ℝ) : UnitCircle)‖ := by rw [hspeed]
  · intro hStationary n hn speeds _hinjective hnonzero
    exact hStationary n hn speeds hnonzero

/-- The canonical labelled-runner formulation is exactly equivalent to the
usual stationary formulation even when its nonzero moving-speed tuple contains
repetitions.  The finite reindexing and deduplication steps are exposed in the
two component equivalences rather than hidden in this composition. -/
theorem conjecture_iff_stationaryConjecture :
    Conjecture ↔ StationaryConjecture := by
  exact conjecture_iff_distinctStationaryConjecture.trans
    distinctStationaryConjecture_iff_stationaryConjecture

end LonelyRunner
