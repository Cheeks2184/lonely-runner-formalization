import Mathlib.Analysis.Fourier.AddCircleMulti
import Mathlib.Topology.UrysohnsLemma

/-!
# Continuous separation of a closed torus subgroup and a translated coset

This file supplies the topological prefix of a later Fourier separation
argument.  A point outside a closed subgroup of a finite-dimensional unit
additive torus determines a disjoint translated coset.  Urysohn's lemma then
provides a bounded real-valued continuous separator, which is also packaged as
a complex-valued continuous map for Fourier approximation.
-/

namespace LonelyRunner

open Set

variable {d : Type*}

/-- The translate of `H` whose elements differ from `x` by an element of `H`.

With this orientation, `x` itself belongs to the coset because `x - x = 0`.
-/
def translatedSubgroupCoset (H : AddSubgroup (UnitAddTorus d))
    (x : UnitAddTorus d) : Set (UnitAddTorus d) :=
  {y | y - x ∈ H}

/-- A translate of a closed torus subgroup is closed. -/
theorem isClosed_translatedSubgroupCoset (H : AddSubgroup (UnitAddTorus d))
    (x : UnitAddTorus d) (hH : IsClosed (H : Set (UnitAddTorus d))) :
    IsClosed (translatedSubgroupCoset H x) := by
  change IsClosed ((fun y : UnitAddTorus d => y - x) ⁻¹' (H : Set (UnitAddTorus d)))
  exact hH.preimage (continuous_id.sub continuous_const)

/-- A subgroup and the translate selected by a point outside it are disjoint. -/
theorem disjoint_subgroup_translatedSubgroupCoset
    (H : AddSubgroup (UnitAddTorus d)) (x : UnitAddTorus d)
    (hx : x ∉ H) :
    Disjoint (H : Set (UnitAddTorus d)) (translatedSubgroupCoset H x) := by
  rw [Set.disjoint_left]
  intro y hyH hyCoset
  apply hx
  have hsub : y - (y - x) ∈ H := H.sub_mem hyH hyCoset
  simpa only [sub_sub_cancel] using hsub

variable [Fintype d]

/-- Urysohn separation of a closed subgroup from a disjoint translated coset.

The separator is zero on `H`, one on the coset, and takes values in `[0, 1]`
everywhere.  The interval condition records the boundedness needed later.
-/
theorem exists_closedSubgroupCosetSeparatorReal
    (H : AddSubgroup (UnitAddTorus d)) (x : UnitAddTorus d)
    (hH : IsClosed (H : Set (UnitAddTorus d))) (hx : x ∉ H) :
    ∃ f : C(UnitAddTorus d, ℝ),
      Set.EqOn f 0 (H : Set (UnitAddTorus d)) ∧
      Set.EqOn f 1 (translatedSubgroupCoset H x) ∧
      ∀ y, f y ∈ Set.Icc (0 : ℝ) 1 := by
  exact exists_continuous_zero_one_of_isClosed hH
    (isClosed_translatedSubgroupCoset H x hH)
    (disjoint_subgroup_translatedSubgroupCoset H x hx)

/-- A chosen bounded real-valued separator for a closed subgroup and its
translated coset. -/
noncomputable def closedSubgroupCosetSeparatorReal
    (H : AddSubgroup (UnitAddTorus d)) (x : UnitAddTorus d)
    (hH : IsClosed (H : Set (UnitAddTorus d))) (hx : x ∉ H) :
    C(UnitAddTorus d, ℝ) :=
  (exists_closedSubgroupCosetSeparatorReal H x hH hx).choose

theorem closedSubgroupCosetSeparatorReal_eq_zero
    (H : AddSubgroup (UnitAddTorus d)) (x : UnitAddTorus d)
    (hH : IsClosed (H : Set (UnitAddTorus d))) (hx : x ∉ H)
    {y : UnitAddTorus d} (hy : y ∈ H) :
    closedSubgroupCosetSeparatorReal H x hH hx y = 0 :=
  (exists_closedSubgroupCosetSeparatorReal H x hH hx).choose_spec.1 hy

theorem closedSubgroupCosetSeparatorReal_eq_one
    (H : AddSubgroup (UnitAddTorus d)) (x : UnitAddTorus d)
    (hH : IsClosed (H : Set (UnitAddTorus d))) (hx : x ∉ H)
    {y : UnitAddTorus d} (hy : y ∈ translatedSubgroupCoset H x) :
    closedSubgroupCosetSeparatorReal H x hH hx y = 1 :=
  (exists_closedSubgroupCosetSeparatorReal H x hH hx).choose_spec.2.1 hy

theorem closedSubgroupCosetSeparatorReal_mem_Icc
    (H : AddSubgroup (UnitAddTorus d)) (x : UnitAddTorus d)
    (hH : IsClosed (H : Set (UnitAddTorus d))) (hx : x ∉ H)
    (y : UnitAddTorus d) :
    closedSubgroupCosetSeparatorReal H x hH hx y ∈ Set.Icc (0 : ℝ) 1 :=
  (exists_closedSubgroupCosetSeparatorReal H x hH hx).choose_spec.2.2 y

/-- Complexification of the Urysohn separator, ready for Fourier
approximation on `UnitAddTorus d`. -/
noncomputable def closedSubgroupCosetSeparator
    (H : AddSubgroup (UnitAddTorus d)) (x : UnitAddTorus d)
    (hH : IsClosed (H : Set (UnitAddTorus d))) (hx : x ∉ H) :
    C(UnitAddTorus d, ℂ) where
  toFun y := (closedSubgroupCosetSeparatorReal H x hH hx y : ℂ)
  continuous_toFun := Complex.continuous_ofReal.comp
    (closedSubgroupCosetSeparatorReal H x hH hx).continuous

/-- The complex separator vanishes on the closed subgroup. -/
theorem closedSubgroupCosetSeparator_eq_zero
    (H : AddSubgroup (UnitAddTorus d)) (x : UnitAddTorus d)
    (hH : IsClosed (H : Set (UnitAddTorus d))) (hx : x ∉ H)
    {y : UnitAddTorus d} (hy : y ∈ H) :
    closedSubgroupCosetSeparator H x hH hx y = 0 := by
  change ((closedSubgroupCosetSeparatorReal H x hH hx y : ℝ) : ℂ) = 0
  rw [closedSubgroupCosetSeparatorReal_eq_zero H x hH hx hy]
  norm_num

/-- The complex separator is one on the translated coset. -/
theorem closedSubgroupCosetSeparator_eq_one
    (H : AddSubgroup (UnitAddTorus d)) (x : UnitAddTorus d)
    (hH : IsClosed (H : Set (UnitAddTorus d))) (hx : x ∉ H)
    {y : UnitAddTorus d} (hy : y ∈ translatedSubgroupCoset H x) :
    closedSubgroupCosetSeparator H x hH hx y = 1 := by
  change ((closedSubgroupCosetSeparatorReal H x hH hx y : ℝ) : ℂ) = 1
  rw [closedSubgroupCosetSeparatorReal_eq_one H x hH hx hy]
  norm_num

end LonelyRunner
