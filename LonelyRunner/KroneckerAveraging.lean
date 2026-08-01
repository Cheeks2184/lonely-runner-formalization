import Mathlib.Analysis.Fourier.AddCircleMulti

/-!
# Haar averaging over a closed finite-torus subgroup

This file isolates the analytic averaging lemma needed by the Fourier route
to the finite-torus character-separation theorem.
-/

namespace LonelyRunner

noncomputable section

open Set
open MeasureTheory

/-- Haar probability measure on a closed subgroup of a finite unit torus.
Compactness comes from closedness inside the compact ambient torus. -/
noncomputable def closedSubgroupHaar {m : ℕ}
    (H : AddSubgroup (UnitAddTorus (Fin m)))
    (hH : IsClosed (H : Set (UnitAddTorus (Fin m)))) : Measure H := by
  letI : CompactSpace H := isCompact_iff_compactSpace.mp hH.isCompact
  exact Measure.addHaarMeasure ⊤

theorem closedSubgroupHaar_univ {m : ℕ}
    (H : AddSubgroup (UnitAddTorus (Fin m)))
    (hH : IsClosed (H : Set (UnitAddTorus (Fin m)))) :
    closedSubgroupHaar H hH Set.univ = 1 := by
  letI : CompactSpace H := isCompact_iff_compactSpace.mp hH.isCompact
  change Measure.addHaarMeasure
      (⊤ : TopologicalSpace.PositiveCompacts H) Set.univ = 1
  simpa using
    (Measure.addHaarMeasure_self
      (K₀ := (⊤ : TopologicalSpace.PositiveCompacts H)))

/-- Restricting a continuous torus function to a translate of a closed
subgroup is integrable for normalized subgroup Haar measure. -/
theorem integrable_add_closedSubgroup {m : ℕ}
    (H : AddSubgroup (UnitAddTorus (Fin m)))
    (hH : IsClosed (H : Set (UnitAddTorus (Fin m))))
    (f : C(UnitAddTorus (Fin m), ℂ))
    (x : UnitAddTorus (Fin m)) :
    Integrable (fun h : H => f (x + (h : UnitAddTorus (Fin m))))
      (closedSubgroupHaar H hH) := by
  letI : CompactSpace H := isCompact_iff_compactSpace.mp hH.isCompact
  let μH : Measure H := closedSubgroupHaar H hH
  have hμH_univ : μH Set.univ = 1 := by
    simpa [μH] using closedSubgroupHaar_univ H hH
  letI : IsProbabilityMeasure μH := IsProbabilityMeasure.mk hμH_univ
  apply Integrable.of_bound
    (f.continuous.comp
      (continuous_const.add continuous_subtype_val)).aestronglyMeasurable
    ‖f‖
  filter_upwards [] with h
  exact f.norm_coe_le_norm (x + (h : UnitAddTorus (Fin m)))

/-- Averaging a continuous complex-valued function over a closed subgroup of
a finite unit torus is continuous in the translating point. -/
theorem continuous_integral_add_closedSubgroup {m : ℕ}
    (H : AddSubgroup (UnitAddTorus (Fin m)))
    (hH : IsClosed (H : Set (UnitAddTorus (Fin m))))
    (f : C(UnitAddTorus (Fin m), ℂ)) :
    Continuous fun y : UnitAddTorus (Fin m) =>
      ∫ h : H, f (y + (h : UnitAddTorus (Fin m))) ∂closedSubgroupHaar H hH := by
  letI : CompactSpace H := isCompact_iff_compactSpace.mp hH.isCompact
  let μH : Measure H := Measure.addHaarMeasure ⊤
  have hμH : closedSubgroupHaar H hH = μH := by
    rfl
  rw [hμH]
  have hμH_univ : μH Set.univ = 1 := by
    simpa [μH] using
      (Measure.addHaarMeasure_self
        (K₀ := (⊤ : TopologicalSpace.PositiveCompacts H)))
  letI : IsProbabilityMeasure μH := IsProbabilityMeasure.mk hμH_univ
  apply MeasureTheory.continuous_of_dominated
      (bound := fun _ : H => ‖f‖)
  · intro y
    exact (f.continuous.comp
      (continuous_const.add continuous_subtype_val)).aestronglyMeasurable
  · intro y
    filter_upwards [] with h
    exact f.norm_coe_le_norm (y + (h : UnitAddTorus (Fin m)))
  · exact integrable_const ‖f‖
  · filter_upwards [] with h
    exact f.continuous.comp (continuous_id.add continuous_const)

end

end LonelyRunner
