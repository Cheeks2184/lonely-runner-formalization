import LonelyRunner.KroneckerCharacters
import LonelyRunner.KroneckerOrbit
import LonelyRunner.KroneckerSeparationSetup

/-!
# Integer-character separation for closed finite-torus subgroups

The main result of this file separates a point from a closed subgroup of a
finite unit torus by one of the standard integer Fourier characters.  This is
the finite-dimensional harmonic-analysis input needed for the reverse
direction of generalized Kronecker approximation.
-/

namespace LonelyRunner

noncomputable section

open Set
open MeasureTheory
open Submodule

/-- Difference between Haar averages over `H` and its translate by `x`, as a
complex-linear functional on continuous functions. -/
noncomputable def subgroupIntegralDifferenceLinear {m : ℕ}
    (H : AddSubgroup (UnitAddTorus (Fin m)))
    (hH : IsClosed (H : Set (UnitAddTorus (Fin m))))
    (x : UnitAddTorus (Fin m)) :
    C(UnitAddTorus (Fin m), ℂ) →ₗ[ℂ] ℂ where
  toFun f :=
    (∫ h : H, f (x + (h : UnitAddTorus (Fin m))) ∂closedSubgroupHaar H hH) -
      ∫ h : H, f (h : UnitAddTorus (Fin m)) ∂closedSubgroupHaar H hH
  map_add' f g := by
    have hfx := integrable_add_closedSubgroup H hH f x
    have hgx := integrable_add_closedSubgroup H hH g x
    have hf0 : Integrable (fun h : H =>
        f (h : UnitAddTorus (Fin m))) (closedSubgroupHaar H hH) := by
      simpa using integrable_add_closedSubgroup H hH f 0
    have hg0 : Integrable (fun h : H =>
        g (h : UnitAddTorus (Fin m))) (closedSubgroupHaar H hH) := by
      simpa using integrable_add_closedSubgroup H hH g 0
    simp only [ContinuousMap.add_apply]
    rw [MeasureTheory.integral_add hfx hgx, MeasureTheory.integral_add hf0 hg0]
    ring
  map_smul' c f := by
    simp only [ContinuousMap.smul_apply, smul_eq_mul,
      MeasureTheory.integral_const_mul, RingHom.id_apply]
    ring

/-- The difference functional has operator bound two for normalized Haar
measure. -/
theorem norm_subgroupIntegralDifferenceLinear_le {m : ℕ}
    (H : AddSubgroup (UnitAddTorus (Fin m)))
    (hH : IsClosed (H : Set (UnitAddTorus (Fin m))))
    (x : UnitAddTorus (Fin m)) (f : C(UnitAddTorus (Fin m), ℂ)) :
    ‖subgroupIntegralDifferenceLinear H hH x f‖ ≤ 2 * ‖f‖ := by
  letI : CompactSpace H := isCompact_iff_compactSpace.mp hH.isCompact
  let μH : Measure H := closedSubgroupHaar H hH
  have hμH_univ : μH Set.univ = 1 := by
    simpa [μH] using closedSubgroupHaar_univ H hH
  letI : IsProbabilityMeasure μH := IsProbabilityMeasure.mk hμH_univ
  have htranslated :
      ‖∫ h : H, f (x + (h : UnitAddTorus (Fin m))) ∂μH‖ ≤ ‖f‖ := by
    have hbound := norm_integral_le_of_norm_le_const (μ := μH)
      (f := fun h : H => f (x + (h : UnitAddTorus (Fin m))))
      (C := ‖f‖) (Filter.Eventually.of_forall fun h =>
        f.norm_coe_le_norm (x + (h : UnitAddTorus (Fin m))))
    simpa using hbound
  have horiginal :
      ‖∫ h : H, f (h : UnitAddTorus (Fin m)) ∂μH‖ ≤ ‖f‖ := by
    have hbound := norm_integral_le_of_norm_le_const (μ := μH)
      (f := fun h : H => f (h : UnitAddTorus (Fin m)))
      (C := ‖f‖) (Filter.Eventually.of_forall fun h =>
        f.norm_coe_le_norm (h : UnitAddTorus (Fin m)))
    simpa using hbound
  change ‖(∫ h : H, f (x + (h : UnitAddTorus (Fin m))) ∂μH) -
    ∫ h : H, f (h : UnitAddTorus (Fin m)) ∂μH‖ ≤ 2 * ‖f‖
  calc
    _ ≤ ‖∫ h : H, f (x + (h : UnitAddTorus (Fin m))) ∂μH‖ +
        ‖∫ h : H, f (h : UnitAddTorus (Fin m)) ∂μH‖ := norm_sub_le _ _
    _ ≤ ‖f‖ + ‖f‖ := add_le_add htranslated horiginal
    _ = 2 * ‖f‖ := by ring

/-- The bounded difference functional. -/
noncomputable def subgroupIntegralDifference {m : ℕ}
    (H : AddSubgroup (UnitAddTorus (Fin m)))
    (hH : IsClosed (H : Set (UnitAddTorus (Fin m))))
    (x : UnitAddTorus (Fin m)) :
    C(UnitAddTorus (Fin m), ℂ) →L[ℂ] ℂ :=
  (subgroupIntegralDifferenceLinear H hH x).mkContinuous 2
    (norm_subgroupIntegralDifferenceLinear_le H hH x)

/-- If a Fourier character is either nontrivial on `H` or takes value one at
`x`, the difference functional kills that character. -/
theorem subgroupIntegralDifference_mFourier_eq_zero {m : ℕ}
    (H : AddSubgroup (UnitAddTorus (Fin m)))
    (hH : IsClosed (H : Set (UnitAddTorus (Fin m))))
    (x : UnitAddTorus (Fin m)) (a : Fin m → ℤ)
    (hnoSeparation :
      (∀ h : H, UnitAddTorus.mFourier a
        (h : UnitAddTorus (Fin m)) = 1) →
        UnitAddTorus.mFourier a x = 1) :
    subgroupIntegralDifference H hH x (UnitAddTorus.mFourier a) = 0 := by
  change
    (∫ h : H, UnitAddTorus.mFourier a
      (x + (h : UnitAddTorus (Fin m))) ∂closedSubgroupHaar H hH) -
      ∫ h : H, UnitAddTorus.mFourier a
        (h : UnitAddTorus (Fin m)) ∂closedSubgroupHaar H hH = 0
  rw [integral_mFourier_add_closedSubgroup]
  by_cases htrivial : ∀ h : H, UnitAddTorus.mFourier a
      (h : UnitAddTorus (Fin m)) = 1
  · rw [integral_mFourier_closedSubgroup_eq_one_of_forall_eq_one H hH a htrivial,
      hnoSeparation htrivial]
    ring
  · have hnontrivial : ∃ h : H, UnitAddTorus.mFourier a
        (h : UnitAddTorus (Fin m)) ≠ 1 := by
      simpa only [not_forall] using htrivial
    rw [integral_mFourier_closedSubgroup_eq_zero_of_exists_ne_one
      H hH a hnontrivial]
    ring

/-- Under the assumption that no integer character separates `x` from `H`,
the difference functional vanishes on the Fourier span. -/
theorem span_mFourier_le_ker_subgroupIntegralDifference {m : ℕ}
    (H : AddSubgroup (UnitAddTorus (Fin m)))
    (hH : IsClosed (H : Set (UnitAddTorus (Fin m))))
    (x : UnitAddTorus (Fin m))
    (hnoSeparation : ∀ a : Fin m → ℤ,
      (∀ h : H, UnitAddTorus.mFourier a
        (h : UnitAddTorus (Fin m)) = 1) →
        UnitAddTorus.mFourier a x = 1) :
    span ℂ (Set.range UnitAddTorus.mFourier) ≤
      LinearMap.ker (subgroupIntegralDifference H hH x).toLinearMap := by
  rw [span_le]
  intro f hf
  rcases hf with ⟨a, rfl⟩
  exact subgroupIntegralDifference_mFourier_eq_zero H hH x a
    (hnoSeparation a)

/-- Fourier density promotes vanishing on every integer character to
vanishing on every continuous function. -/
theorem subgroupIntegralDifference_eq_zero_of_no_separation {m : ℕ}
    (H : AddSubgroup (UnitAddTorus (Fin m)))
    (hH : IsClosed (H : Set (UnitAddTorus (Fin m))))
    (x : UnitAddTorus (Fin m))
    (hnoSeparation : ∀ a : Fin m → ℤ,
      (∀ h : H, UnitAddTorus.mFourier a
        (h : UnitAddTorus (Fin m)) = 1) →
        UnitAddTorus.mFourier a x = 1)
    (f : C(UnitAddTorus (Fin m), ℂ)) :
    subgroupIntegralDifference H hH x f = 0 := by
  have hspan : span ℂ (Set.range UnitAddTorus.mFourier) ≤
      LinearMap.ker (subgroupIntegralDifference H hH x).toLinearMap :=
    span_mFourier_le_ker_subgroupIntegralDifference H hH x hnoSeparation
  have hclosure :
      (span ℂ (Set.range UnitAddTorus.mFourier)).topologicalClosure ≤
        LinearMap.ker (subgroupIntegralDifference H hH x).toLinearMap :=
    Submodule.topologicalClosure_minimal _ hspan
      (subgroupIntegralDifference H hH x).isClosed_ker
  rw [UnitAddTorus.span_mFourier_closure_eq_top] at hclosure
  exact hclosure (Submodule.mem_top)

/-- The Urysohn separator has difference integral exactly one. -/
theorem subgroupIntegralDifference_separator_eq_one {m : ℕ}
    (H : AddSubgroup (UnitAddTorus (Fin m)))
    (hH : IsClosed (H : Set (UnitAddTorus (Fin m))))
    (x : UnitAddTorus (Fin m)) (hx : x ∉ H) :
    subgroupIntegralDifference H hH x
      (closedSubgroupCosetSeparator H x hH hx) = 1 := by
  letI : CompactSpace H := isCompact_iff_compactSpace.mp hH.isCompact
  let μH : Measure H := closedSubgroupHaar H hH
  have hμH_univ : μH Set.univ = 1 := by
    simpa [μH] using closedSubgroupHaar_univ H hH
  letI : IsProbabilityMeasure μH := IsProbabilityMeasure.mk hμH_univ
  have htranslate : ∀ h : H,
      closedSubgroupCosetSeparator H x hH hx
        (x + (h : UnitAddTorus (Fin m))) = 1 := by
    intro h
    apply closedSubgroupCosetSeparator_eq_one H x hH hx
    change x + (h : UnitAddTorus (Fin m)) - x ∈ H
    convert h.property using 1
    abel
  have honH : ∀ h : H,
      closedSubgroupCosetSeparator H x hH hx
        (h : UnitAddTorus (Fin m)) = 0 := by
    intro h
    exact closedSubgroupCosetSeparator_eq_zero H x hH hx h.property
  change
    (∫ h : H, closedSubgroupCosetSeparator H x hH hx
      (x + (h : UnitAddTorus (Fin m))) ∂μH) -
      ∫ h : H, closedSubgroupCosetSeparator H x hH hx
        (h : UnitAddTorus (Fin m)) ∂μH = 1
  rw [integral_congr_ae (Filter.Eventually.of_forall htranslate),
    integral_congr_ae (Filter.Eventually.of_forall honH)]
  simp

/-- Every point outside a closed subgroup of a finite unit torus is separated
from that subgroup by a standard integer Fourier character. -/
theorem exists_mFourier_separating {m : ℕ}
    (H : AddSubgroup (UnitAddTorus (Fin m)))
    (hH : IsClosed (H : Set (UnitAddTorus (Fin m))))
    (x : UnitAddTorus (Fin m)) (hx : x ∉ H) :
    ∃ a : Fin m → ℤ,
      (∀ h : H, UnitAddTorus.mFourier a
        (h : UnitAddTorus (Fin m)) = 1) ∧
      UnitAddTorus.mFourier a x ≠ 1 := by
  by_contra hnone
  have hnoSeparation : ∀ a : Fin m → ℤ,
      (∀ h : H, UnitAddTorus.mFourier a
        (h : UnitAddTorus (Fin m)) = 1) →
        UnitAddTorus.mFourier a x = 1 := by
    intro a htrivial
    by_contra hne
    exact hnone ⟨a, htrivial, hne⟩
  have hzero := subgroupIntegralDifference_eq_zero_of_no_separation
    H hH x hnoSeparation (closedSubgroupCosetSeparator H x hH hx)
  have hone := subgroupIntegralDifference_separator_eq_one H hH x hx
  rw [hone] at hzero
  norm_num at hzero

/-- The carrier of the algebraic range subgroup is the ordinary range of the
continuous orbit map. -/
theorem orbitRange_coe {m : ℕ} (u : Fin m → ℝ) :
    (orbitRange u : Set (UnitAddTorus (Fin m))) = Set.range (orbitHom u) := by
  ext x
  constructor
  · rintro ⟨t, rfl⟩
    exact ⟨t, rfl⟩
  · rintro ⟨t, rfl⟩
    exact ⟨t, rfl⟩

/-- Relation inclusion implies pointwise inclusion in the closed real orbit.
This is the one-way generalized Kronecker theorem needed by the
real-to-rational reduction. -/
theorem orbitHom_mem_orbitTopologicalClosure_of_relations {m : ℕ}
    (u w : Fin m → ℝ) (τ : ℝ)
    (hrelations : ∀ a : Fin m → ℤ,
      (∑ i, (a i : ℝ) * u i = 0) →
        ∑ i, (a i : ℝ) * w i = 0) :
    orbitHom w τ ∈ orbitTopologicalClosure u := by
  by_contra hnotmem
  obtain ⟨a, htrivial, hseparates⟩ :=
    exists_mFourier_separating (orbitTopologicalClosure u)
      (AddSubgroup.isClosed_topologicalClosure _) (orbitHom w τ) hnotmem
  have horbitTrivial : ∀ t : ℝ,
      UnitAddTorus.mFourier a (orbitHom u t) = 1 := by
    intro t
    let hpoint : orbitTopologicalClosure u :=
      ⟨orbitHom u t, AddSubgroup.le_topologicalClosure (orbitRange u)
        ⟨t, rfl⟩⟩
    exact htrivial hpoint
  have huRelation : ∑ i, (a i : ℝ) * u i = 0 :=
    (mFourier_orbitHom_eq_one_iff u a).mp horbitTrivial
  have hwRelation : ∑ i, (a i : ℝ) * w i = 0 :=
    hrelations a huRelation
  have htarget : UnitAddTorus.mFourier a (orbitHom w τ) = 1 :=
    (mFourier_orbitHom_eq_one_iff w a).mpr hwRelation τ
  exact hseparates htarget

/-- Set-theoretic form of
`orbitHom_mem_orbitTopologicalClosure_of_relations`. -/
theorem orbitHom_mem_closure_range_of_relations {m : ℕ}
    (u w : Fin m → ℝ) (τ : ℝ)
    (hrelations : ∀ a : Fin m → ℤ,
      (∑ i, (a i : ℝ) * u i = 0) →
        ∑ i, (a i : ℝ) * w i = 0) :
    orbitHom w τ ∈ closure (Set.range (orbitHom u)) := by
  have hmem := orbitHom_mem_orbitTopologicalClosure_of_relations
    u w τ hrelations
  change orbitHom w τ ∈
    ((orbitRange u).topologicalClosure : Set (UnitAddTorus (Fin m))) at hmem
  rw [AddSubgroup.topologicalClosure_coe, orbitRange_coe] at hmem
  exact hmem

end

end LonelyRunner
