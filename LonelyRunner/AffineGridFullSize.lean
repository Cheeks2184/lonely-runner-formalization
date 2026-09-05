import LonelyRunner.AffineGrid

/-!
# Product-free full-size affine grids

There are `N - 1` original speeds throughout this construction.  Allowing
the affine scale to be zero removes the slope-product hypothesis: a missing
unit among the slopes supplies the zero-scale branch.  When every offset is
nonzero, a separate boundary witness is required instead of two-hole avoidance.
-/

namespace LonelyRunner

open scoped BigOperators

/-- Mixed offsets admit affine avoidance for arbitrary nonzero slopes when
the scale `s` is allowed to vanish.  The slope map either omits a unit, which
gives a direct `s = 0` construction, or enumerates every unit exactly once,
which supplies the product premise of the existing affine theorem. -/
theorem affine_avoidance_allow_zero_scale
    (N : ℕ) [Fact N.Prime] (hodd : Odd N)
    {I : Type*} [Fintype I] (hcard : Fintype.card I = N - 1)
    (a v : I → ZMod N) (ha : ∀ i, a i ≠ 0)
    (hvzero : ∃ i, v i = 0) (hvnonzero : ∃ i, v i ≠ 0) :
    ∃ r s : ZMod N, r ≠ 0 ∧
      ∀ i, s * v i + r * a i ≠ 0 ∧ s * v i + r * a i ≠ -1 := by
  classical
  let f : I → (ZMod N)ˣ := fun i => Units.mk0 (a i) (ha i)
  by_cases hsurj : Function.Surjective f
  · have hbij : Function.Bijective f :=
      (Fintype.bijective_iff_surjective_and_card f).mpr
        ⟨hsurj, hcard.trans (ZMod.card_units N).symm⟩
    have hunitProduct : (∏ x : (ZMod N)ˣ, (x : ZMod N)) = -1 := by
      have h := congrArg (Units.coeHom (ZMod N))
        (FiniteField.prod_univ_units_id_eq_neg_one (K := ZMod N))
      simpa only [map_prod, Units.coeHom_apply, Units.val_neg, Units.val_one] using h
    have hproduct : ∏ i, a i = -1 := by
      calc
        (∏ i, a i) = ∏ x : (ZMod N)ˣ, (x : ZMod N) :=
          Fintype.prod_bijective f hbij _ _ (fun _ => rfl)
        _ = -1 := hunitProduct
    obtain ⟨r, s, hr, _, havoid⟩ := affine_avoidance_of_slope_product
      N hodd hcard a v ha hproduct hvzero hvnonzero
    exact ⟨r, s, hr, havoid⟩
  · simp only [Function.Surjective, not_forall, not_exists] at hsurj
    obtain ⟨x, hx⟩ := hsurj
    have hr : -(x : ZMod N)⁻¹ ≠ 0 := neg_ne_zero.mpr (inv_ne_zero x.ne_zero)
    refine ⟨-(x : ZMod N)⁻¹, 0, hr, ?_⟩
    intro i
    simp only [zero_mul, zero_add]
    refine ⟨mul_ne_zero hr (ha i), ?_⟩
    intro h
    have hval : a i = (x : ZMod N) := by
      apply mul_left_cancel₀ hr
      rw [h]
      simp only [neg_mul, inv_mul_cancel₀ x.ne_zero]
    exact hx i (Units.ext hval)

/-- All `N - 1` original speeds admit a closed `1 / N` witness on the
`N * M` grid.  There is no slope-product assumption and no nonzero-scale
requirement.  At least one original speed must be nonzero modulo `N`;
deleting that premise would make the fixed-grid assertion false. -/
theorem affine_grid_full_size_witness
    (N M : ℕ) [Fact N.Prime] (hodd : Odd N)
    {I : Type*} [Fintype I] (hcard : Fintype.card I = N - 1)
    (a u : I → ℕ) (hM : 0 < M)
    (_ha : ∀ i, 0 < a i)
    (haN : ∀ i, ¬ N ∣ a i)
    (hu : ∀ i, Nat.ModEq M (u i) (a i))
    (hsize : ∀ i, (N - 1) * a i < M)
    (hnonzero : ∃ i, ¬ N ∣ u i) :
    ∃ s r : ℕ, s < N ∧ ∀ i, (N : ℝ)⁻¹ ≤ circleNorm
      (((s : ℝ) / N + (r : ℝ) / M) * (u i : ℝ)) := by
  classical
  have hprime : N.Prime := Fact.out
  have hN : 2 ≤ N := hprime.two_le
  have hNpos : 0 < N := hprime.pos
  by_cases hzero : ∃ i, N ∣ u i
  · have haslopes : ∀ i, (a i : ZMod N) ≠ 0 := by
      intro i hi
      exact haN i ((ZMod.natCast_eq_zero_iff (a i) N).mp hi)
    have hvzero : ∃ i, (u i : ZMod N) = 0 := by
      obtain ⟨i, hi⟩ := hzero
      exact ⟨i, (ZMod.natCast_eq_zero_iff (u i) N).mpr hi⟩
    have hvnonzero : ∃ i, (u i : ZMod N) ≠ 0 := by
      obtain ⟨i, hi⟩ := hnonzero
      exact ⟨i, fun hz => hi ((ZMod.natCast_eq_zero_iff (u i) N).mp hz)⟩
    obtain ⟨rF, sF, _, havoid⟩ := affine_avoidance_allow_zero_scale
      N hodd hcard (fun i => (a i : ZMod N)) (fun i => (u i : ZMod N))
      haslopes hvzero hvnonzero
    let s := sF.val
    let r0 := rF.val
    have hslt : s < N := ZMod.val_lt sF
    obtain ⟨r, beta, hr, hbeta⟩ := exists_affine_grid_rounding N M r0 hNpos
    refine ⟨s, r, hslt, ?_⟩
    intro i
    have hcast : ((s * u i + r0 * a i : ℕ) : ZMod N) =
        sF * (u i : ZMod N) + rF * (a i : ZMod N) := by
      simp only [Nat.cast_add, Nat.cast_mul, s, r0, ZMod.natCast_zmod_val]
    have hband : 1 ≤ (s * u i + r0 * a i) % N ∧
        (s * u i + r0 * a i) % N ≤ N - 2 := by
      apply nat_mod_band_of_zmod_avoidance N _ hN
      · rw [hcast]
        exact (havoid i).1
      · rw [hcast]
        exact (havoid i).2
    exact circleNorm_ge_of_affine_grid_band N M s r0 r beta (a i) (u i)
      hN hM (hu i) hr hbeta (hsize i) hband.1 hband.2
  · -- Here every original speed is already good at `1 / N`, including
    -- values exactly on the upper closed boundary.  No affine band is needed.
    refine ⟨1, 0, by omega, ?_⟩
    intro i
    have hmod : u i % N ≠ 0 := by
      intro hi
      exact hzero ⟨i, Nat.dvd_of_mod_eq_zero hi⟩
    have hdist := circleNorm_nat_div_ge hNpos
      (one_le_cyclicResidueDistance_of_mod_ne_zero hNpos hmod)
    simpa [div_eq_mul_inv, mul_comm] using hdist

end LonelyRunner
