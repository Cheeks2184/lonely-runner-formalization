import Mathlib.Analysis.Fourier.AddCircleMulti

noncomputable section

open scoped ComplexConjugate Real

open Finset

namespace LonelyRunner

/-- The linear orbit with velocity vector `u`, reduced coordinatewise modulo one. -/
def orbitHom {m : ℕ} (u : Fin m → ℝ) : ℝ →ₜ+ UnitAddTorus (Fin m) where
  toFun t i := (↑(t * u i) : UnitAddCircle)
  map_zero' := by
    ext i
    simp
  map_add' s t := by
    ext i
    simp [add_mul]
  continuous_toFun := by
    fun_prop

@[simp]
theorem orbitHom_apply {m : ℕ} (u : Fin m → ℝ) (t : ℝ) (i : Fin m) :
    orbitHom u t i = (↑(t * u i) : UnitAddCircle) :=
  rfl

/-- The image of the real one-parameter orbit, before taking a topological closure. -/
def orbitRange {m : ℕ} (u : Fin m → ℝ) : AddSubgroup (UnitAddTorus (Fin m)) :=
  (orbitHom u).toAddMonoidHom.range

/-- The topological closure of the real one-parameter orbit.  This deliberately uses
`AddSubgroup.topologicalClosure`, not an algebraic closure operation. -/
def orbitTopologicalClosure {m : ℕ} (u : Fin m → ℝ) :
    AddSubgroup (UnitAddTorus (Fin m)) :=
  (orbitRange u).topologicalClosure

theorem mFourier_orbitHom_apply {m : ℕ} (u : Fin m → ℝ) (a : Fin m → ℤ) (t : ℝ) :
    UnitAddTorus.mFourier a (orbitHom u t) =
      Complex.exp (2 * Real.pi * Complex.I *
        ((t : ℂ) * ((∑ i, (a i : ℝ) * u i : ℝ) : ℂ))) := by
  rw [show (2 * Real.pi * Complex.I *
      ((t : ℂ) * ((∑ i, (a i : ℝ) * u i : ℝ) : ℂ))) =
      ∑ i, 2 * Real.pi * Complex.I * (a i : ℂ) * (t * u i : ℂ) / (1 : ℂ) by
    push_cast
    rw [mul_sum, mul_sum]
    apply Finset.sum_congr rfl
    intro i hi
    ring]
  rw [Complex.exp_sum]
  simp only [UnitAddTorus.mFourier, ContinuousMap.coe_mk]
  apply Finset.prod_congr rfl
  intro i hi
  change fourier (a i) (↑(t * u i) : UnitAddCircle) = _
  rw [fourier_coe_apply]
  congr 1
  push_cast
  rfl

/-- A Fourier character is identically one along the orbit exactly when its integer index is a
real linear relation among the velocities. -/
theorem mFourier_orbitHom_eq_one_iff {m : ℕ} (u : Fin m → ℝ) (a : Fin m → ℤ) :
    (∀ t : ℝ, UnitAddTorus.mFourier a (orbitHom u t) = 1) ↔
      ∑ i, (a i : ℝ) * u i = 0 := by
  constructor
  · intro h
    by_contra hs
    let S : ℝ := ∑ i, (a i : ℝ) * u i
    have hS : S ≠ 0 := by
      simpa [S] using hs
    have ht := h (1 / (2 * S))
    rw [mFourier_orbitHom_apply] at ht
    have hmul :
        (((1 / (2 * S) : ℝ) : ℂ) * (S : ℂ)) = (1 / 2 : ℂ) := by
      push_cast
      field_simp [hS]
    change Complex.exp (2 * Real.pi * Complex.I *
      (((1 / (2 * S) : ℝ) : ℂ) * (S : ℂ))) = 1 at ht
    rw [hmul] at ht
    have hexp : Complex.exp (2 * Real.pi * Complex.I * (1 / 2 : ℂ)) = -1 := by
      rw [show 2 * Real.pi * Complex.I * (1 / 2 : ℂ) = Real.pi * Complex.I by ring]
      exact Complex.exp_pi_mul_I
    rw [hexp] at ht
    norm_num at ht
  · intro h t
    rw [mFourier_orbitHom_apply, h]
    simp

end LonelyRunner
