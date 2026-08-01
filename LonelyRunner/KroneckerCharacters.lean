import LonelyRunner.KroneckerAveraging

/-!
# Characters on closed subgroups of a finite torus

This file records the spatial multiplicativity and Haar orthogonality facts
needed by the Fourier proof of closed-subgroup character separation.
-/

namespace LonelyRunner

noncomputable section

open Set
open MeasureTheory

/-- A multivariate Fourier monomial is a character in its torus argument. -/
theorem mFourier_add_argument {m : ℕ} (a : Fin m → ℤ)
    (x y : UnitAddTorus (Fin m)) :
    UnitAddTorus.mFourier a (x + y) =
      UnitAddTorus.mFourier a x * UnitAddTorus.mFourier a y := by
  simp only [UnitAddTorus.mFourier, Pi.add_apply, ContinuousMap.coe_mk,
    fourier_apply, zsmul_add, AddCircle.toCircle_add, Circle.coe_mul,
    Finset.prod_mul_distrib]

/-- A multivariate Fourier character that is nontrivial on a closed subgroup
has Haar integral zero on that subgroup. -/
theorem integral_mFourier_closedSubgroup_eq_zero_of_exists_ne_one {m : ℕ}
    (H : AddSubgroup (UnitAddTorus (Fin m)))
    (hH : IsClosed (H : Set (UnitAddTorus (Fin m))))
    (a : Fin m → ℤ)
    (hnontrivial : ∃ h : H,
      UnitAddTorus.mFourier a (h : UnitAddTorus (Fin m)) ≠ 1) :
    ∫ h : H, UnitAddTorus.mFourier a
      (h : UnitAddTorus (Fin m)) ∂closedSubgroupHaar H hH = 0 := by
  letI : CompactSpace H := isCompact_iff_compactSpace.mp hH.isCompact
  let μH : Measure H := closedSubgroupHaar H hH
  have hμH : μH = Measure.addHaarMeasure
      (⊤ : TopologicalSpace.PositiveCompacts H) := by
    rfl
  haveI : μH.IsAddLeftInvariant := by
    rw [hμH]
    infer_instance
  obtain ⟨h₀, hh₀⟩ := hnontrivial
  let χ : H → ℂ := fun h =>
    UnitAddTorus.mFourier a (h : UnitAddTorus (Fin m))
  let I : ℂ := ∫ h : H, χ h ∂μH
  have htranslate : (∫ h : H, χ (h₀ + h) ∂μH) = I := by
    simpa [I] using
      (MeasureTheory.integral_add_left_eq_self (μ := μH) χ h₀)
  have hcharacter : ∀ h : H, χ (h₀ + h) = χ h₀ * χ h := by
    intro h
    exact mFourier_add_argument a
      (h₀ : UnitAddTorus (Fin m)) (h : UnitAddTorus (Fin m))
  have hfactor : χ h₀ * I = I := by
    calc
      χ h₀ * I = ∫ h : H, χ h₀ * χ h ∂μH := by
        change χ h₀ * (∫ h : H, χ h ∂μH) =
          ∫ h : H, χ h₀ * χ h ∂μH
        exact (MeasureTheory.integral_const_mul (μ := μH) (χ h₀) χ).symm
      _ = ∫ h : H, χ (h₀ + h) ∂μH := by
        apply integral_congr_ae
        filter_upwards [] with h
        exact (hcharacter h).symm
      _ = I := htranslate
  have hproduct : (χ h₀ - 1) * I = 0 := by
    rw [sub_mul, one_mul, hfactor, sub_self]
  have hχ : χ h₀ - 1 ≠ 0 := sub_ne_zero.mpr hh₀
  have hI : I = 0 := (mul_eq_zero.mp hproduct).resolve_left hχ
  simpa [I, χ, μH] using hI

/-- A multivariate Fourier character that is trivial on a closed subgroup has
normalized Haar integral one on that subgroup. -/
theorem integral_mFourier_closedSubgroup_eq_one_of_forall_eq_one {m : ℕ}
    (H : AddSubgroup (UnitAddTorus (Fin m)))
    (hH : IsClosed (H : Set (UnitAddTorus (Fin m))))
    (a : Fin m → ℤ)
    (htrivial : ∀ h : H,
      UnitAddTorus.mFourier a (h : UnitAddTorus (Fin m)) = 1) :
    ∫ h : H, UnitAddTorus.mFourier a
      (h : UnitAddTorus (Fin m)) ∂closedSubgroupHaar H hH = 1 := by
  letI : CompactSpace H := isCompact_iff_compactSpace.mp hH.isCompact
  let μH : Measure H := closedSubgroupHaar H hH
  have hμH_univ : μH Set.univ = 1 := by
    simpa [μH] using closedSubgroupHaar_univ H hH
  letI : IsProbabilityMeasure μH := IsProbabilityMeasure.mk hμH_univ
  change (∫ h : H, UnitAddTorus.mFourier a
    (h : UnitAddTorus (Fin m)) ∂μH) = 1
  rw [integral_congr_ae (Filter.Eventually.of_forall htrivial)]
  simp

/-- Translating a Fourier character before integrating over a subgroup pulls
out its value at the translating point. -/
theorem integral_mFourier_add_closedSubgroup {m : ℕ}
    (H : AddSubgroup (UnitAddTorus (Fin m)))
    (hH : IsClosed (H : Set (UnitAddTorus (Fin m))))
    (a : Fin m → ℤ) (x : UnitAddTorus (Fin m)) :
    (∫ h : H, UnitAddTorus.mFourier a
      (x + (h : UnitAddTorus (Fin m))) ∂closedSubgroupHaar H hH) =
      UnitAddTorus.mFourier a x *
        ∫ h : H, UnitAddTorus.mFourier a
          (h : UnitAddTorus (Fin m)) ∂closedSubgroupHaar H hH := by
  rw [← MeasureTheory.integral_const_mul]
  apply integral_congr_ae
  filter_upwards [] with h
  exact mFourier_add_argument a x (h : UnitAddTorus (Fin m))

end

end LonelyRunner
