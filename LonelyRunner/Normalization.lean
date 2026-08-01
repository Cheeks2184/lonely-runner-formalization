import LonelyRunner.StructuredClasses

/-!
# Sign and common-scale normalization

These lemmas isolate the elementary normalization steps that are safe for a
fixed stationary instance.  They do not assert the nontrivial reduction from
arbitrary real speeds to rational or integer speeds.
-/

namespace LonelyRunner

/-- Replacing one speed by its absolute value does not change its phase
distance at any fixed time. -/
theorem circleNorm_mul_abs_right (time speed : ℝ) :
    circleNorm (time * |speed|) = circleNorm (time * speed) := by
  rw [← circleNorm_abs (time * |speed|), ← circleNorm_abs (time * speed)]
  simp [abs_mul]

/-- Multiplying every speed by a common nonzero real scale can be undone by
dividing the witnessing time by that scale. -/
theorem circleNorm_div_time_mul_scale (time scale speed : ℝ)
    (hscale : scale ≠ 0) :
    circleNorm ((time / scale) * (scale * speed)) =
      circleNorm (time * speed) := by
  congr 1
  field_simp

/-- A fixed stationary tuple has a witness at threshold `δ` exactly when its
coordinatewise absolute-value tuple does.  The same time works in both
directions. -/
theorem exists_stationaryWitness_abs_iff {n : ℕ} (δ : ℝ)
    (speeds : Fin n → ℝ) :
    (∃ time : ℝ, ∀ i, δ ≤ circleNorm (time * |speeds i|)) ↔
      ∃ time : ℝ, ∀ i, δ ≤ circleNorm (time * speeds i) := by
  constructor <;> rintro ⟨time, htime⟩ <;> refine ⟨time, fun i ↦ ?_⟩
  · simpa [circleNorm_mul_abs_right] using htime i
  · simpa [circleNorm_mul_abs_right] using htime i

/-- A common nonzero scaling of all stationary speeds preserves existence of
a witness at an arbitrary threshold. -/
theorem exists_stationaryWitness_scale_iff {n : ℕ} (δ scale : ℝ)
    (hscale : scale ≠ 0) (speeds : Fin n → ℝ) :
    (∃ time : ℝ, ∀ i, δ ≤ circleNorm (time * (scale * speeds i))) ↔
      ∃ time : ℝ, ∀ i, δ ≤ circleNorm (time * speeds i) := by
  constructor
  · rintro ⟨time, htime⟩
    refine ⟨time * scale, fun i ↦ ?_⟩
    simpa [mul_assoc] using htime i
  · rintro ⟨time, htime⟩
    refine ⟨time / scale, fun i ↦ ?_⟩
    rw [circleNorm_div_time_mul_scale time scale (speeds i) hscale]
    exact htime i

/-- In particular, multiplying positive-natural speeds by a common positive
natural factor preserves the stationary witness problem. -/
theorem exists_stationaryWitness_natScale_iff {n : ℕ} (δ : ℝ)
    (factor : ℕ) (hfactor : 0 < factor) (speeds : Fin n → ℕ) :
    (∃ time : ℝ, ∀ i,
      δ ≤ circleNorm (time * ((factor * speeds i : ℕ) : ℝ))) ↔
      ∃ time : ℝ, ∀ i, δ ≤ circleNorm (time * (speeds i : ℝ)) := by
  simpa [Nat.cast_mul] using
    (exists_stationaryWitness_scale_iff δ (factor : ℝ)
      (by exact_mod_cast hfactor.ne') (fun i ↦ (speeds i : ℝ)))

end LonelyRunner
