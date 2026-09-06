import LonelyRunner.BHKTwoPhaseSupply
import LonelyRunner.AffinePhasePeriod
import LonelyRunner.AffinePhaseTransfer

/-!
# Positive rational affine witness

This composes the bounded BHK free-phase supply, common-period normalization,
and nearest-integer transport for a positive rational affine row.  It is the
positive core only: no signed or original-orbit reduction is included.
-/

namespace LonelyRunner

noncomputable section

/-- A positive rational affine row has a positive witness, retaining the
stronger free-phase margin at zero residual coordinates. -/
theorem exists_positiveAffine_witness_with_zeroResidual {N m : ℕ}
    (hN : 3 ≤ N) (hm : 0 < m) (hmN : m ≤ N - 1)
    (U : Fin m → ℤ) (V : Fin m → ℚ) (p : ℚ) (hp : 1 < p)
    (q : ℝ) (hq : 1 ≤ q)
    (hperiod : ∀ i, ∃ z : ℤ, q * (V i : ℝ) = (z : ℝ))
    (hpos : ∀ i, 0 < p * (U i : ℚ) + V i)
    (hnonconstant : ∃ a b,
      (U a : ℚ) / (p * (U a : ℚ) + V a) ≠
        (U b : ℚ) / (p * (U b : ℚ) + V b))
    (herr : ∀ i, |(V i : ℝ)| / (2 * (p : ℝ)) ≤
      ((N * (N - 1) : ℕ) : ℝ)⁻¹)
    (hLower : LowerCountPositiveIntegerHypothesis N) :
    ∃ t : ℝ, 0 < t ∧
      (∀ i, (N : ℝ)⁻¹ ≤ circleNorm
        (t * ((p : ℝ) * (U i : ℝ) + (V i : ℝ)))) ∧
      ∀ i, V i = 0 → (((N - 1 : ℕ) : ℝ)⁻¹) ≤ circleNorm
        (t * ((p : ℝ) * (U i : ℝ) + (V i : ℝ))) := by
  let R : Fin m → ℚ := fun i => p * (U i : ℚ) + V i
  let S : Fin m → ℚ := fun i => (U i : ℚ)
  have hRpos : ∀ i, 0 < R i := by
    intro i
    exact hpos i
  have hRatios : ∃ a b, S a / R a ≠ S b / R b := by
    simpa [R, S] using hnonconstant
  obtain ⟨a, b, hab⟩ :=
    exists_bhk_twoPhase_margin hN hm hmN R S hRpos hRatios hLower
  let X : ℝ := (p : ℝ) * a + b
  let Y0 : ℝ := a
  have hfree : ∀ i,
      (R i : ℝ) * a + (S i : ℝ) * b =
        (U i : ℝ) * X + (V i : ℝ) * Y0 := by
    intro i
    dsimp [R, S, X, Y0]
    push_cast
    ring
  have hqpos : 0 < q := lt_of_lt_of_le zero_lt_one hq
  obtain ⟨Y, hYlower, _hYupper, hYnorm⟩ :=
    exists_normalized_affine_second_phase
      (fun i => (U i : ℝ) * X) (fun i => (V i : ℝ)) q Y0 hqpos hperiod
  have hpReal : 1 < (p : ℝ) := by exact_mod_cast hp
  have hpRealPos : 0 < (p : ℝ) := by linarith
  have hhalf : (1 : ℝ) / (2 * (p : ℝ)) < 1 := by
    apply (div_lt_iff₀ (by positivity : 0 < 2 * (p : ℝ))).mpr
    nlinarith
  have hYlarge : (1 : ℝ) / (2 * (p : ℝ)) < Y := by
    linarith
  have hNpos : 0 < (N : ℝ) := by exact_mod_cast (by omega : 0 < N)
  have hNpredPos : 0 < ((N - 1 : ℕ) : ℝ) := by
    exact_mod_cast (by omega : 0 < N - 1)
  have hproductCast : (((N * (N - 1) : ℕ) : ℝ)) =
      (N : ℝ) * ((N - 1 : ℕ) : ℝ) := by norm_num
  have hNpred : (N : ℝ) = ((N - 1 : ℕ) : ℝ) + 1 := by
    exact_mod_cast (Nat.sub_add_cancel (by omega : 1 ≤ N)).symm
  have hmarginEq : (N : ℝ)⁻¹ + (((N * (N - 1) : ℕ) : ℝ)⁻¹) =
      (((N - 1 : ℕ) : ℝ)⁻¹) := by
    rw [hproductCast]
    field_simp
    linarith
  have hmargin : ∀ i,
      (N : ℝ)⁻¹ + (((N * (N - 1) : ℕ) : ℝ)⁻¹) ≤
        circleNorm ((U i : ℝ) * X + (V i : ℝ) * Y) := by
    intro i
    calc
      (N : ℝ)⁻¹ + (((N * (N - 1) : ℕ) : ℝ)⁻¹) =
          (((N - 1 : ℕ) : ℝ)⁻¹) := hmarginEq
      _ ≤ circleNorm ((R i : ℝ) * a + (S i : ℝ) * b) := hab i
      _ = circleNorm ((U i : ℝ) * X + (V i : ℝ) * Y0) := by rw [hfree i]
      _ = circleNorm ((U i : ℝ) * X + (V i : ℝ) * Y) := (hYnorm i).symm
  obtain ⟨t, htpos, _htshift, ht, hzero⟩ :=
    exists_affinePhaseTransfer_with_zeroResidual U (fun i => (V i : ℝ)) (p : ℝ) X Y
      (N : ℝ)⁻¹ (((N * (N - 1) : ℕ) : ℝ)⁻¹)
      hpRealPos hYlarge hmargin herr
  refine ⟨t, htpos, ?_, ?_⟩
  · intro i
    have hti := ht i
    simpa [mul_comm] using hti
  · intro i hVi
    have hti := hzero i (by exact_mod_cast hVi)
    rw [hmarginEq] at hti
    simpa [mul_comm] using hti

/-- The original positive affine contract is the ordinary projection of the
zero-residual-preserving witness theorem. -/
theorem exists_positiveAffine_witness {N m : ℕ}
    (hN : 3 ≤ N) (hm : 0 < m) (hmN : m ≤ N - 1)
    (U : Fin m → ℤ) (V : Fin m → ℚ) (p : ℚ) (hp : 1 < p)
    (q : ℝ) (hq : 1 ≤ q)
    (hperiod : ∀ i, ∃ z : ℤ, q * (V i : ℝ) = (z : ℝ))
    (hpos : ∀ i, 0 < p * (U i : ℚ) + V i)
    (hnonconstant : ∃ a b,
      (U a : ℚ) / (p * (U a : ℚ) + V a) ≠
        (U b : ℚ) / (p * (U b : ℚ) + V b))
    (herr : ∀ i, |(V i : ℝ)| / (2 * (p : ℝ)) ≤
      ((N * (N - 1) : ℕ) : ℝ)⁻¹)
    (hLower : LowerCountPositiveIntegerHypothesis N) :
    ∃ t : ℝ, 0 < t ∧ ∀ i,
      (N : ℝ)⁻¹ ≤ circleNorm
        (t * ((p : ℝ) * (U i : ℝ) + (V i : ℝ))) := by
  obtain ⟨t, ht, hord, _⟩ :=
    exists_positiveAffine_witness_with_zeroResidual hN hm hmN U V p hp q hq hperiod hpos
      hnonconstant herr hLower
  exact ⟨t, ht, hord⟩

end

end LonelyRunner
