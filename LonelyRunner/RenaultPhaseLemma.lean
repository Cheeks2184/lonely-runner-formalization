import LonelyRunner.RenaultPhaseConcreteData
import LonelyRunner.RenaultPhaseBandSoundness
import LonelyRunner.FiniteMaskSubset

/-!
# Renault phase-certificate assembly

This module joins the checked finite data to the generic real phase bridge.
-/

namespace LonelyRunner

private theorem renault_phase_normalized (x : Fin 3 → ℝ)
    (hx : ∀ j, 0 ≤ x j ∧ x j < 1) :
    ∃ c : Fin 23, ∀ j, PhaseGood c (x j) := by
  apply phase_certificate_sound
    (AtomMem := fun a y => CutAtomMem renaultPhaseCuts 360 a.val y)
    (mask := fun a => maskCandidates 23 (renaultPhaseAtomMasks a))
    (m := 41) (core := renaultPhaseCoreAtoms) (dom := renaultPhaseDominators)
  · intro y hy0 hy1
    exact cutAtomMem_covers_unit_interval 60 360 (by decide) (by decide)
      renaultPhaseCuts renaultPhaseBandFacts.first renaultPhaseBandFacts.last y hy0 hy1
  · intro a k hk y hay
    exact phaseBandFacts_sound renaultPhaseCuts renaultPhaseAtomMasks
      renaultPhaseBandFacts a k hk y hay
  · intro a k hk
    rw [renaultPhaseCoreAtoms_masks] at hk
    exact maskCandidates_subset_of_and_eq 23
      (renaultPhaseCoreMasks (renaultPhaseDominators a))
      (renaultPhaseAtomMasks a) (renaultPhaseDominators_and a) hk
  · intro i j k _hij hjk
    obtain ⟨c, hc0, hc1, hc2⟩ :=
      renaultPhaseCoreMasks_common_candidate i j k hjk
    refine ⟨c, ?_, ?_, ?_⟩
    · simpa only [renaultPhaseCoreAtoms_masks] using hc0
    · simpa only [renaultPhaseCoreAtoms_masks] using hc1
    · simpa only [renaultPhaseCoreAtoms_masks] using hc2
  · exact hx

/-- Every three real phases have one common Renault candidate. -/
theorem renault_phase_common_candidate (x : Fin 3 → ℝ) :
    ∃ c : Fin 23, ∀ j, PhaseGood c (x j) := by
  obtain ⟨c, hc⟩ := renault_phase_normalized (fun j => Int.fract (x j))
    (fun j => ⟨Int.fract_nonneg _, Int.fract_lt_one _⟩)
  refine ⟨c, ?_⟩
  intro j
  exact (phaseGood_fract c (x j)).mp (hc j)

/-- The common candidate decodes either to one closed slope-two-through-five
phase, or to one of the three strict slope-one phases. -/
theorem renault_phase_five_one (x : Fin 3 → ℝ) :
    (∃ a b : ℕ, 2 ≤ a ∧ a ≤ 5 ∧ 1 ≤ b ∧ b ≤ 5 ∧
      ∀ j, (1 : ℝ) / 6 ≤
        circleNorm ((a : ℝ) * x j + (b : ℝ) / 6)) ∨
    (∃ b : ℕ, (b = 1 ∨ b = 2 ∨ b = 4) ∧
      ∀ j, (1 : ℝ) / 6 < circleNorm (x j + (b : ℝ) / 6)) := by
  obtain ⟨c, hc⟩ := renault_phase_common_candidate x
  by_cases hsmall : c.val < 20
  · left
    refine ⟨2 + c.val / 5, 1 + c.val % 5, by omega, by omega,
      by omega, by omega, ?_⟩
    intro j
    have hgood := hc j
    rw [phaseGood_iff] at hgood
    simpa [phaseSlope, phaseShift, hsmall] using hgood
  · right
    have hcases : c.val = 20 ∨ c.val = 21 ∨ c.val = 22 := by omega
    rcases hcases with h20 | h21 | h22
    · refine ⟨1, Or.inl rfl, ?_⟩
      intro j
      have hgood := hc j
      rw [phaseGood_iff] at hgood
      simpa [phaseSlope, phaseShift, hsmall, h20] using hgood
    · refine ⟨2, Or.inr (Or.inl rfl), ?_⟩
      intro j
      have hgood := hc j
      rw [phaseGood_iff] at hgood
      simpa [phaseSlope, phaseShift, hsmall, h21] using hgood
    · refine ⟨4, Or.inr (Or.inr rfl), ?_⟩
      intro j
      have hgood := hc j
      rw [phaseGood_iff] at hgood
      simpa [phaseSlope, phaseShift, hsmall, h22] using hgood

end LonelyRunner
