import LonelyRunner.PositiveAffineWitness

/-!
# Signed rational affine witness

Coordinatewise sign normalization reduces a nowhere-zero rational affine row
to the positive affine witness theorem while preserving every ratio, period,
error bound, and circle norm.
-/

namespace LonelyRunner

noncomputable section

/-- The positive affine witness extends coordinatewise to every nowhere-zero
rational affine speed row by sign normalization. -/
theorem exists_signedAffine_witness {N m : ℕ}
    (hN : 3 ≤ N) (hm : 0 < m) (hmN : m ≤ N - 1)
    (U : Fin m → ℤ) (V : Fin m → ℚ) (p : ℚ) (hp : 1 < p)
    (q : ℝ) (hq : 1 ≤ q)
    (hperiod : ∀ i, ∃ z : ℤ, q * (V i : ℝ) = (z : ℝ))
    (hactual : ∀ i, p * (U i : ℚ) + V i ≠ 0)
    (hnonconstant : ∃ a b,
      (U a : ℚ) / (p * (U a : ℚ) + V a) ≠
        (U b : ℚ) / (p * (U b : ℚ) + V b))
    (herr : ∀ i, |(V i : ℝ)| / (2 * (p : ℝ)) ≤
      ((N * (N - 1) : ℕ) : ℝ)⁻¹)
    (hLower : LowerCountPositiveIntegerHypothesis N) :
    ∃ t : ℝ, 0 < t ∧ ∀ i,
      (N : ℝ)⁻¹ ≤ circleNorm
        (t * ((p : ℝ) * (U i : ℝ) + (V i : ℝ))) := by
  let c : Fin m → ℚ := fun i => p * (U i : ℚ) + V i
  let U' : Fin m → ℤ := fun i => if 0 < c i then U i else -U i
  let V' : Fin m → ℚ := fun i => if 0 < c i then V i else -V i
  have hpos : ∀ i, 0 < p * (U' i : ℚ) + V' i := by
    intro i
    by_cases hc : 0 < c i
    · simp [U', V', hc, c]
    · have hcneg : c i < 0 := lt_of_le_of_ne (le_of_not_gt hc) (hactual i)
      rw [show p * (U' i : ℚ) + V' i = -c i by simp [U', V', hc, c]; ring]
      exact neg_pos.mpr hcneg
  have hratio : ∀ i,
      (U' i : ℚ) / (p * (U' i : ℚ) + V' i) =
        (U i : ℚ) / (p * (U i : ℚ) + V i) := by
    intro i
    by_cases hc : 0 < c i
    · simp [U', V', hc]
    · simp only [U', V', if_neg hc, Int.cast_neg]
      rw [show p * -((U i : ℚ)) + -V i =
        -(p * (U i : ℚ) + V i) by ring]
      exact neg_div_neg_eq _ _
  have hnonconstant' : ∃ a b,
      (U' a : ℚ) / (p * (U' a : ℚ) + V' a) ≠
        (U' b : ℚ) / (p * (U' b : ℚ) + V' b) := by
    obtain ⟨a, b, hab⟩ := hnonconstant
    refine ⟨a, b, ?_⟩
    rw [hratio a, hratio b]
    exact hab
  have hperiod' : ∀ i, ∃ z : ℤ, q * (V' i : ℝ) = (z : ℝ) := by
    intro i
    obtain ⟨z, hz⟩ := hperiod i
    by_cases hc : 0 < c i
    · exact ⟨z, by simpa [V', hc] using hz⟩
    · refine ⟨-z, ?_⟩
      rw [show (V' i : ℝ) = -(V i : ℝ) by simp [V', hc]]
      rw [show ((-z : ℤ) : ℝ) = -(z : ℝ) by norm_num]
      linarith
  have herr' : ∀ i, |(V' i : ℝ)| / (2 * (p : ℝ)) ≤
      ((N * (N - 1) : ℕ) : ℝ)⁻¹ := by
    intro i
    by_cases hc : 0 < c i
    · simpa [V', hc] using herr i
    · simpa [V', hc, abs_neg] using herr i
  obtain ⟨t, htpos, ht⟩ := exists_positiveAffine_witness
    hN hm hmN U' V' p hp q hq hperiod' hpos hnonconstant' herr' hLower
  refine ⟨t, htpos, fun i => ?_⟩
  have hti := ht i
  by_cases hc : 0 < c i
  · simpa [U', V', hc] using hti
  · have hphase : t * ((p : ℝ) * (U' i : ℝ) + (V' i : ℝ)) =
        -(t * ((p : ℝ) * (U i : ℝ) + (V i : ℝ))) := by
      simp [U', V', hc]
      ring
    rw [hphase, circleNorm_neg] at hti
    exact hti

end

end LonelyRunner
