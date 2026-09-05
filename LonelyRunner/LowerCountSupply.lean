import LonelyRunner.RationalReduction

/-!
# Bounded lower-count supply

This module keeps the lower-dimensional hypothesis explicitly bounded by a
fixed total-runner count.  It only transfers that hypothesis through common
denominator clearing and through the finite set of distinct absolute values of
a rational collision vector; it makes no global positive-integer assumption.
-/

namespace LonelyRunner

noncomputable section

open Finset

/-- `H_N`: every nonempty positive, distinct integer tuple with at most
`N - 2` moving runners has its stationary witness at its own threshold. -/
def LowerCountPositiveIntegerHypothesis (N : ℕ) : Prop :=
  ∀ d : ℕ, 1 ≤ d → d ≤ N - 2 →
    ∀ speeds : Fin d → ℕ,
      Function.Injective speeds → (∀ i, 0 < speeds i) →
        ∃ time : ℝ, ∀ i,
          (((d + 1 : ℕ) : ℝ)⁻¹) ≤
            circleNorm (time * (speeds i : ℝ))

/-- Common-denominator clearing transfers `H_N` to a fixed tuple of distinct
positive rational speeds without changing its number of coordinates. -/
theorem lowerCountPositiveIntegerHypothesis_rational {N d : ℕ}
    (hLower : LowerCountPositiveIntegerHypothesis N)
    (hdpos : 1 ≤ d) (hdLower : d ≤ N - 2)
    (speeds : Fin d → ℚ) (hinjective : Function.Injective speeds)
    (hpos : ∀ i, 0 < speeds i) :
    ∃ time : ℝ, ∀ i,
      (((d + 1 : ℕ) : ℝ)⁻¹) ≤ circleNorm (time * (speeds i : ℝ)) := by
  let cleared : Fin d → ℕ := clearRationalSpeed speeds
  have hclearedInjective : Function.Injective cleared :=
    clearRationalSpeed_injective speeds hinjective hpos
  have hclearedPos : ∀ i, 0 < cleared i :=
    clearRationalSpeed_pos speeds hpos
  obtain ⟨time, htime⟩ :=
    hLower d hdpos hdLower cleared hclearedInjective hclearedPos
  refine ⟨time * (rationalCommonDenominator speeds : ℝ), fun i => ?_⟩
  have hi := htime i
  rw [clearRationalSpeed_cast speeds hpos i] at hi
  simpa [circleNorm, mul_assoc] using hi

/-- A nonzero rational collision vector whose absolute values use at most
`N - 2` magnitudes has a witness at the `N - 1` stationary threshold, under
the explicitly bounded hypothesis `H_N`. -/
theorem exists_lowerCount_rational_collision {N m : ℕ}
    (hN : 3 ≤ N) (hm : 0 < m) (w : Fin m → ℚ)
    (hw : ∀ i, w i ≠ 0)
    (hcard : (Finset.univ.image (fun i => |w i|)).card ≤ N - 2)
    (hLower : LowerCountPositiveIntegerHypothesis N) :
    ∃ t : ℝ, ∀ i,
      (((N - 1 : ℕ) : ℝ)⁻¹) ≤ circleNorm (t * (w i : ℝ)) := by
  classical
  let magnitudes : Finset ℚ := Finset.univ.image fun i => |w i|
  let d : ℕ := magnitudes.card
  let enumerate : Fin d ≃ {q : ℚ // q ∈ magnitudes} :=
    by simpa [d] using (Fintype.equivFin {q : ℚ // q ∈ magnitudes}).symm
  let rationalSpeeds : Fin d → ℚ := fun j => (enumerate j : ℚ)
  let first : Fin m := ⟨0, hm⟩
  have hmagnitudes : magnitudes.Nonempty := by
    refine ⟨|w first|, ?_⟩
    exact Finset.mem_image.mpr ⟨first, Finset.mem_univ _, rfl⟩
  have hdpos : 1 ≤ d := Finset.card_pos.mpr hmagnitudes
  have hdLower : d ≤ N - 2 := by
    simpa [d, magnitudes] using hcard
  have hrationalInjective : Function.Injective rationalSpeeds := by
    intro a b hab
    apply enumerate.injective
    apply Subtype.ext
    exact hab
  have hrationalPos : ∀ j, 0 < rationalSpeeds j := by
    intro j
    have hjmem : (enumerate j : ℚ) ∈ magnitudes := (enumerate j).property
    rcases Finset.mem_image.mp hjmem with ⟨i, _hi, habs⟩
    change 0 < (enumerate j : ℚ)
    rw [← habs]
    exact abs_pos.mpr (hw i)
  obtain ⟨tau, htau⟩ := lowerCountPositiveIntegerHypothesis_rational
    hLower hdpos hdLower rationalSpeeds hrationalInjective hrationalPos
  have hdSuccLe : d + 1 ≤ N - 1 := by omega
  have hbound : (((N - 1 : ℕ) : ℝ)⁻¹) ≤ (((d + 1 : ℕ) : ℝ)⁻¹) := by
    apply inv_anti₀
    · positivity
    · exact_mod_cast hdSuccLe
  refine ⟨tau, fun i => ?_⟩
  let occurrence : {q : ℚ // q ∈ magnitudes} :=
    ⟨|w i|, Finset.mem_image.mpr ⟨i, Finset.mem_univ _, rfl⟩⟩
  let j : Fin d := enumerate.symm occurrence
  have hspeed : rationalSpeeds j = |w i| := by
    change (enumerate (enumerate.symm occurrence) : ℚ) = |w i|
    simp [occurrence]
  calc
    (((N - 1 : ℕ) : ℝ)⁻¹) ≤ (((d + 1 : ℕ) : ℝ)⁻¹) := hbound
    _ ≤ circleNorm (tau * (rationalSpeeds j : ℝ)) := htau j
    _ = circleNorm (tau * |(w i : ℝ)|) := by
      rw [hspeed]
      norm_cast
    _ = circleNorm (tau * (w i : ℝ)) := circleNorm_mul_abs_right tau (w i : ℝ)

end

end LonelyRunner
