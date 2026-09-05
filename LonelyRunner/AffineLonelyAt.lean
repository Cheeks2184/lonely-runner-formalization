import LonelyRunner.SignedAffineWitness
import LonelyRunner.RationalPairRank

namespace LonelyRunner

noncomputable section

theorem rational_affine_lonelyAt {m : ℕ} (hm : 1 ≤ m)
    (hLower : LowerCountPositiveIntegerHypothesis (m + 2))
    (u : Fin (m + 2) → ℤ) (v : Fin (m + 2) → ℚ)
    (p : ℚ) (hp : 1 < p) (q : ℕ) (hq : 0 < q)
    (hu0 : u 0 = 0) (hv0 : v 0 = 0)
    (hrank : RationalPairRankTwo u v)
    (hinj : Function.Injective (fun i => p * (u i : ℚ) + v i))
    (hperiod : ∀ i, ∃ z : ℤ, (q : ℚ) * v i = (z : ℚ))
    (r : Fin (m + 2))
    (herr : ∀ i, |v i - v r| ≤
      2 * p / (((m + 2) * (m + 1) : ℕ) : ℚ)) :
    ∃ t : ℝ, 0 < t ∧
      LonelyAt (fun i => ((p * (u i : ℚ) + v i : ℚ) : ℝ)) r t := by
  let U : Fin (m + 1) → ℤ := fun a => u (r.succAbove a) - u r
  let V : Fin (m + 1) → ℚ := fun a => v (r.succAbove a) - v r
  have hnonconstant := relative_ratio_nonconstant_of_rankTwo u v p hu0 hv0 hrank hinj r
  have hactual : ∀ a, p * (U a : ℚ) + V a ≠ 0 := by
    intro a hzero
    apply Fin.succAbove_ne r a
    apply hinj
    dsimp [U, V] at hzero
    push_cast at hzero
    linarith
  have hperiodRel : ∀ a, ∃ z : ℤ, (q : ℝ) * (V a : ℝ) = (z : ℝ) := by
    intro a
    obtain ⟨za, hza⟩ := hperiod (r.succAbove a)
    obtain ⟨zr, hzr⟩ := hperiod r
    refine ⟨za - zr, ?_⟩
    dsimp [V]
    have hrat : (q : ℚ) * (v (r.succAbove a) - v r) = ((za - zr : ℤ) : ℚ) := by
      rw [mul_sub, hza, hzr]
      norm_num
    exact_mod_cast hrat
  have herrRel : ∀ a, |(V a : ℝ)| / (2 * (p : ℝ)) ≤
      (((m + 2) * (m + 1) : ℕ) : ℝ)⁻¹ := by
    intro a
    have hp0 : 0 < (p : ℝ) := by exact_mod_cast (by linarith : 0 < p)
    have haR : |(V a : ℝ)| ≤
        (2 * (p : ℝ)) / (((m + 2) * (m + 1) : ℕ) : ℝ) := by
      dsimp [V]
      exact_mod_cast (herr (r.succAbove a))
    apply (div_le_iff₀ (by positivity : 0 < 2 * (p : ℝ))).mpr
    calc
      |(V a : ℝ)| ≤ (2 * (p : ℝ)) / (((m + 2) * (m + 1) : ℕ) : ℝ) := haR
      _ = (((m + 2) * (m + 1) : ℕ) : ℝ)⁻¹ * (2 * (p : ℝ)) := by ring
  obtain ⟨t, ht, hcomparisons⟩ := exists_signedAffine_witness
    (N := m + 2) (m := m + 1) (by omega) (by omega) (by omega)
    U V p hp (q : ℝ) (by exact_mod_cast (by omega : 1 ≤ q)) hperiodRel hactual
    hnonconstant herrRel hLower
  refine ⟨t, ht, ?_⟩
  apply (lonelyAt_iff_relativeLonelyAt _ r t).mpr
  intro other hother
  obtain ⟨a, rfl⟩ := Fin.exists_succAbove_eq hother
  have ha := hcomparisons a
  change ((m + 2 : ℕ) : ℝ)⁻¹ ≤
    circleNorm (t * (((p * (u (r.succAbove a) : ℚ) + v (r.succAbove a) : ℚ) : ℝ) -
      ((p * (u r : ℚ) + v r : ℚ) : ℝ)))
  convert ha using 1 <;> dsimp [U, V] <;> push_cast <;> ring

end

end LonelyRunner
