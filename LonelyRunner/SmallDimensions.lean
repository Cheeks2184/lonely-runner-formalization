import LonelyRunner.BaseCases
import LonelyRunner.StructuredClasses

/-!
# Further verified small dimensions

The two-moving-runner case splits at the exact factor `2`: comparable
magnitudes are covered by the first residue band, while a ratio at least `2`
is covered by quantitative fast-runner insertion from the one-moving-runner
base case.
-/

namespace LonelyRunner

/-- Two nonzero moving speeds, ordered by magnitude, have a common stationary
witness at the sharp three-total-runner threshold. -/
theorem twoMovingSpeeds_of_abs_le (u v : ℝ) (hu : u ≠ 0) (hv : v ≠ 0)
    (huv : |u| ≤ |v|) :
    ∃ time : ℝ,
      (3 : ℝ)⁻¹ ≤ circleNorm (time * u) ∧
      (3 : ℝ)⁻¹ ≤ circleNorm (time * v) := by
  by_cases hfast : (2 : ℝ) * |u| ≤ |v|
  · obtain ⟨time₀, htime₀⟩ := oneMovingRunner u hu
    let old : Fin 1 → ℝ := fun _ ↦ u
    have hold : ∀ i, (((1 + 1 : ℕ) : ℝ)⁻¹) ≤ circleNorm (time₀ * old i) := by
      intro i
      simpa [old, circleNorm] using htime₀
    have hfast' : ∀ i, (((1 + 1 : ℕ) : ℝ) * |old i|) ≤ |v| := by
      intro i
      simpa [old] using hfast
    obtain ⟨time, _hclose, hvtime, hutime⟩ :=
      fastRunnerInsertion old time₀ v hold hv hfast'
    refine ⟨time, ?_, ?_⟩
    · simpa using hutime (0 : Fin 1)
    · simpa using hvtime
  · have huabs : 0 < |u| := abs_pos.mpr hu
    have hlower : (1 : ℝ) ≤ |v| / |u| := by
      rw [le_div_iff₀ huabs]
      simpa using huv
    have hupper : |v| / |u| ≤ (2 : ℝ) := by
      rw [div_le_iff₀ huabs]
      exact (lt_of_not_ge hfast).le
    let speeds : Fin 2 → ℝ := ![u, v]
    have hbands : ∀ i, ∃ q : ℕ,
        (((q * (2 + 1) + 1 : ℕ) : ℝ) ≤ |speeds i| / |u|) ∧
        (|speeds i| / |u| ≤ ((q * (2 + 1) + 2 : ℕ) : ℝ)) := by
      intro i
      fin_cases i
      · refine ⟨0, ?_, ?_⟩
        · simp [speeds, huabs.ne']
        · simp [speeds, huabs.ne']
      · refine ⟨0, ?_, ?_⟩
        · simpa [speeds] using hlower
        · simpa [speeds] using hupper
    have hband := minimumScaleResidueBands (n := 2) (by omega) speeds |u| huabs hbands
    refine ⟨((((2 + 1 : ℕ) : ℝ) * |u|)⁻¹), ?_, ?_⟩
    · simpa [speeds] using hband (0 : Fin 2)
    · simpa [speeds] using hband (1 : Fin 2)

/-- The complete stationary form of the three-total-runner theorem: any two
nonzero real relative speeds, with arbitrary signs or order, have a common
time at circle distance at least `1/3`. -/
theorem twoMovingSpeeds (u v : ℝ) (hu : u ≠ 0) (hv : v ≠ 0) :
    ∃ time : ℝ,
      (3 : ℝ)⁻¹ ≤ circleNorm (time * u) ∧
      (3 : ℝ)⁻¹ ≤ circleNorm (time * v) := by
  rcases le_total |u| |v| with huv | hvu
  · exact twoMovingSpeeds_of_abs_le u v hu hv huv
  · obtain ⟨time, hvtime, hutime⟩ :=
      twoMovingSpeeds_of_abs_le v u hv hu hvu
    exact ⟨time, hutime, hvtime⟩

/-- Finite-indexed version matching `StationaryConjecture` in moving
dimension two. -/
theorem twoMovingRunners (speeds : Fin 2 → ℝ) (hne : ∀ i, speeds i ≠ 0) :
    ∃ time : ℝ, ∀ i,
      (3 : ℝ)⁻¹ ≤ circleNorm (time * speeds i) := by
  obtain ⟨time, hzero, hone⟩ :=
    twoMovingSpeeds (speeds 0) (speeds 1) (hne 0) (hne 1)
  refine ⟨time, ?_⟩
  intro i
  fin_cases i
  · exact hzero
  · exact hone

end LonelyRunner
