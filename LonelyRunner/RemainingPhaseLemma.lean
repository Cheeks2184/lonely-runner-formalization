import LonelyRunner.RemainingPhaseFacts
import LonelyRunner.FiniteMaskSubset
import LonelyRunner.ConstrainedMaximizer
import LonelyRunner.AffinePhaseCertificate
import Mathlib.Tactic

/-!
# Real assembly for the fixed remaining phase tables

The finite tables certify individual atom bands and common core bits.  This
module assembles those checked facts over actual cut atoms; it adds no table
search, coverage claim, or runner-count theorem.
-/

namespace LonelyRunner

private def RemainingGood (A S : ℕ) (s : Bool) (u : ℝ) : Prop :=
  if s then (1 : ℝ) / 6 < circleNorm ((A : ℝ) * u + (S : ℝ) / 6)
  else (1 : ℝ) / 6 ≤ circleNorm ((A : ℝ) * u + (S : ℝ) / 6)

private def MixedShift (j : Fin 3) (c : Fin 24) : ℕ :=
  if j = 0 then remainingSixOneWeightTwoShift c
  else remainingSixOneWeightOneShift c

private def MixedGood (j : Fin 3) (c : Fin 24) (u : ℝ) : Prop :=
  RemainingGood (remainingSixOneSlopes c) (MixedShift j c)
    (remainingSixOneStrict c) u

private def SafeGood (c : Fin 15) (u : ℝ) : Prop :=
  RemainingGood (remainingSixFourSlopes c) (remainingSixFourShifts c)
    (remainingSixFourStrict c) u

private theorem mixed_decoder (c : Fin 24) :
    (2 ≤ remainingSixOneSlopes c ∧ remainingSixOneSlopes c ≤ 5 ∧
      1 ≤ remainingSixOneShifts c ∧ remainingSixOneShifts c ≤ 5 ∧
      remainingSixOneStrict c = false) ∨
    (remainingSixOneSlopes c = 1 ∧ 1 ≤ remainingSixOneShifts c ∧
      remainingSixOneShifts c ≤ 4 ∧ remainingSixOneStrict c = true) := by
  fin_cases c <;> norm_num [remainingSixOneSlopes, remainingSixOneShifts,
    remainingSixOneStrict]

private theorem safe_decoder (c : Fin 15) :
    (remainingSixFourSlopes c = 2 ∧ remainingSixFourShifts c = 0 ∧
      remainingSixFourStrict c = true) ∨
    (remainingSixFourSlopes c = 1 ∧
      (remainingSixFourShifts c = 1 ∨ remainingSixFourShifts c = 5) ∧
      remainingSixFourStrict c = true) ∨
    ((remainingSixFourSlopes c = 3 ∨ remainingSixFourSlopes c = 5) ∧
      remainingSixFourShifts c ≤ 5 ∧ remainingSixFourStrict c = false) := by
  fin_cases c <;> norm_num [remainingSixFourSlopes, remainingSixFourShifts,
    remainingSixFourStrict]

private theorem mixed_shift_cast (j : Fin 3) (c : Fin 24) :
    (MixedShift j c : ℝ) / 6 =
      (if j = 0 then (2 : ℝ) else 1) *
        (remainingSixOneShifts c : ℝ) / 6 := by
  by_cases hj : j = 0
  · subst j
    simp [MixedShift, remainingSixOneWeightTwoShift]
  · simp [MixedShift, hj, remainingSixOneWeightOneShift]

private theorem remainingGood_fract (A S : ℕ) (s : Bool) (u : ℝ) :
    RemainingGood A S s (Int.fract u) ↔ RemainingGood A S s u := by
  unfold RemainingGood
  cases s <;> simp only [Bool.false_eq_true, ↓reduceIte]
  · rw [circleNorm_nat_affine_fract]
  · rw [circleNorm_nat_affine_fract]

private theorem sixth_safe_fract_band (u : ℝ) :
    (1 : ℝ) / 6 ≤ circleNorm u ↔
      (1 : ℝ) / 6 ≤ Int.fract u ∧ Int.fract u ≤ (5 : ℝ) / 6 := by
  rw [circleNorm_eq_min_fract, le_min_iff]
  constructor
  · intro h
    constructor
    · exact h.1
    · linarith [h.2]
  · intro h
    constructor
    · exact h.1
    · linarith [h.2]

private theorem mixed_weight_two_row (u : ℝ) (hu : 0 ≤ u ∧ u < 1) :
    ∃ i : Fin 42, ∀ c, c ∈ maskCandidates 24 (remainingSixOneWeightTwoCoreMasks i) →
      MixedGood 0 c u := by
  obtain ⟨a, ha⟩ := cutAtomMem_covers_unit_interval 60 360 (by norm_num)
    (by norm_num) renaultPhaseCuts renaultPhaseBandFacts.first
    renaultPhaseBandFacts.last u hu.1 hu.2
  refine ⟨remainingSixOneWeightTwoDominators a, ?_⟩
  intro c hc
  have hmem := maskCandidates_subset_of_and_eq 24
    (remainingSixOneWeightTwoCoreMasks (remainingSixOneWeightTwoDominators a))
    (remainingSixOneWeightTwoAtomMasks a)
    (remainingSixOneWeightTwoDominators_and a) hc
  have hbit := mem_maskCandidates.mp hmem
  unfold MixedGood RemainingGood MixedShift
  simp only [Fin.isValue, ↓reduceIte]
  exact affineSixthBandFact_sound renaultPhaseCuts a
    (remainingSixOneSlopes c) (remainingSixOneWeightTwoShift c)
    (remainingSixOneStrict c) (remainingSixOneSlope_pos c)
    (remainingSixOneWeightTwoAtomBandFact a c hbit) u ha

private theorem mixed_weight_one_row (j : Fin 3) (hj : j ≠ 0)
    (u : ℝ) (hu : 0 ≤ u ∧ u < 1) :
    ∃ i : Fin 42, ∀ c, c ∈ maskCandidates 24 (remainingSixOneWeightOneCoreMasks i) →
      MixedGood j c u := by
  obtain ⟨a, ha⟩ := cutAtomMem_covers_unit_interval 60 360 (by norm_num)
    (by norm_num) renaultPhaseCuts renaultPhaseBandFacts.first
    renaultPhaseBandFacts.last u hu.1 hu.2
  refine ⟨remainingSixOneWeightOneDominators a, ?_⟩
  intro c hc
  have hmem := maskCandidates_subset_of_and_eq 24
    (remainingSixOneWeightOneCoreMasks (remainingSixOneWeightOneDominators a))
    (remainingSixOneWeightOneAtomMasks a)
    (remainingSixOneWeightOneDominators_and a) hc
  have hbit := mem_maskCandidates.mp hmem
  unfold MixedGood RemainingGood MixedShift
  simp only [hj, ↓reduceIte]
  exact affineSixthBandFact_sound renaultPhaseCuts a
    (remainingSixOneSlopes c) (remainingSixOneWeightOneShift c)
    (remainingSixOneStrict c) (remainingSixOneSlope_pos c)
    (remainingSixOneWeightOneAtomBandFact a c hbit) u ha

private theorem safe_row (u : ℝ)
    (hu : (1 : ℝ) / 6 ≤ u ∧ u ≤ (5 : ℝ) / 6) :
    ∃ i : Fin 26, ∀ c, c ∈ maskCandidates 15 (remainingSixFourCoreMasks i) →
      SafeGood c u := by
  have hfirst : remainingSixFourCuts 0 = 60 := by
    decide
  have hlast : remainingSixFourCuts 40 = 300 := by
    decide
  obtain ⟨a, ha⟩ := cutAtomMem_covers_closed_interval 40 360 (by norm_num)
    remainingSixFourCuts u (by norm_num [hfirst]; exact hu.1)
    (by norm_num [hlast]; exact hu.2)
  refine ⟨remainingSixFourDominators a, ?_⟩
  intro c hc
  have hmem := maskCandidates_subset_of_and_eq 15
    (remainingSixFourCoreMasks (remainingSixFourDominators a))
    (remainingSixFourAtomMasks a) (remainingSixFourDominators_and a) hc
  have hbit := mem_maskCandidates.mp hmem
  unfold SafeGood RemainingGood
  exact affineSixthBandFact_sound remainingSixFourCuts a
    (remainingSixFourSlopes c) (remainingSixFourShifts c)
    (remainingSixFourStrict c) (remainingSixFourSlope_pos c)
    (remainingSixFourAtomBandFact a c hbit) u ha

private theorem mixed_common (i : Fin 3 → Fin 42) :
    ∃ c : Fin 24, ∀ j, c ∈
      (if j = 0 then maskCandidates 24 (remainingSixOneWeightTwoCoreMasks (i j))
       else maskCandidates 24 (remainingSixOneWeightOneCoreMasks (i j))) := by
  rcases le_total (i 1) (i 2) with h12 | h21
  · obtain ⟨c, hc0, hc1, hc2⟩ := exists_common_mask_candidate 24
      (remainingSixOneWeightTwoCoreMasks (i 0))
      (remainingSixOneWeightOneCoreMasks (i 1))
      (remainingSixOneWeightOneCoreMasks (i 2))
      (remainingSixOneWeightTwoCoreMasks_lt (i 0))
      (remainingMixedCoreIntersections (i 0) (i 1) (i 2) h12)
    refine ⟨c, ?_⟩
    intro j
    fin_cases j <;> simp [hc0, hc1, hc2]
  · obtain ⟨c, hc0, hc2, hc1⟩ := exists_common_mask_candidate 24
      (remainingSixOneWeightTwoCoreMasks (i 0))
      (remainingSixOneWeightOneCoreMasks (i 2))
      (remainingSixOneWeightOneCoreMasks (i 1))
      (remainingSixOneWeightTwoCoreMasks_lt (i 0))
      (remainingMixedCoreIntersections (i 0) (i 2) (i 1) h21)
    refine ⟨c, ?_⟩
    intro j
    fin_cases j <;> simp [hc0, hc1, hc2]

private theorem safe_common (i : Fin 3 → Fin 26) :
    ∃ c : Fin 15, ∀ j, c ∈ maskCandidates 15 (remainingSixFourCoreMasks (i j)) := by
  rcases le_total (i 1) (i 2) with h12 | h21
  · obtain ⟨c, hc0, hc1, hc2⟩ := exists_common_mask_candidate 15
      (remainingSixFourCoreMasks (i 0)) (remainingSixFourCoreMasks (i 1))
      (remainingSixFourCoreMasks (i 2)) (remainingSixFourCoreMasks_lt (i 0))
      (remainingSafeCoreIntersections (i 0) (i 1) (i 2) h12)
    exact ⟨c, fun j => by fin_cases j <;> assumption⟩
  · obtain ⟨c, hc0, hc2, hc1⟩ := exists_common_mask_candidate 15
      (remainingSixFourCoreMasks (i 0)) (remainingSixFourCoreMasks (i 2))
      (remainingSixFourCoreMasks (i 1)) (remainingSixFourCoreMasks_lt (i 0))
      (remainingSafeCoreIntersections (i 0) (i 2) (i 1) h21)
    exact ⟨c, fun j => by fin_cases j <;> assumption⟩

private theorem mixed_normalized (x : Fin 3 → ℝ)
    (hx : ∀ j, 0 ≤ x j ∧ x j < 1) :
    ∃ c : Fin 24, ∀ j, MixedGood j c (x j) := by
  refine typed_phase_certificate_sound 24 (fun _ => 42)
    (fun j i => if j = 0 then
      maskCandidates 24 (remainingSixOneWeightTwoCoreMasks i)
    else maskCandidates 24 (remainingSixOneWeightOneCoreMasks i))
    (fun _ u => 0 ≤ u ∧ u < 1) MixedGood ?_ mixed_common x hx
  intro j u hu
  by_cases hj : j = 0
  · subst j
    exact mixed_weight_two_row u hu
  · simpa [hj] using mixed_weight_one_row j hj u hu

private theorem safe_normalized (x : Fin 3 → ℝ)
    (hx : ∀ j, (1 : ℝ) / 6 ≤ x j ∧ x j ≤ (5 : ℝ) / 6) :
    ∃ c : Fin 15, ∀ j, SafeGood c (x j) := by
  refine typed_phase_certificate_sound 15 (fun _ => 26)
    (fun _ i => maskCandidates 15 (remainingSixFourCoreMasks i))
    (fun _ u => (1 : ℝ) / 6 ≤ u ∧ u ≤ (5 : ℝ) / 6)
    (fun _ c u => SafeGood c u) ?_ safe_common x hx
  intro _ u hu
  exact safe_row u hu

/-- Renault's fixed 6.1 phase certificate, valid for arbitrary real phases. -/
theorem renault_phase_six_one (x : Fin 3 → ℝ) :
    (∃ a b : ℕ, 2 ≤ a ∧ a ≤ 5 ∧ 1 ≤ b ∧ b ≤ 5 ∧
      ∀ j, (1 : ℝ) / 6 ≤ circleNorm
        ((a : ℝ) * x j +
          (if j = 0 then (2 : ℝ) else 1) * (b : ℝ) / 6)) ∨
    (∃ b : ℕ, 1 ≤ b ∧ b ≤ 4 ∧
      ∀ j, (1 : ℝ) / 6 < circleNorm
        (x j + (if j = 0 then (2 : ℝ) else 1) * (b : ℝ) / 6)) := by
  obtain ⟨c, hc⟩ := mixed_normalized (fun j => Int.fract (x j)) (fun j =>
    ⟨Int.fract_nonneg _, Int.fract_lt_one _⟩)
  have hall : ∀ j, MixedGood j c (x j) := fun j =>
    (remainingGood_fract _ _ _ _).mp (hc j)
  rcases mixed_decoder c with hclosed | hstrict
  · left
    refine ⟨remainingSixOneSlopes c, remainingSixOneShifts c,
      hclosed.1, hclosed.2.1, hclosed.2.2.1, hclosed.2.2.2.1, ?_⟩
    intro j
    simpa [MixedGood, RemainingGood, hclosed.2.2.2.2, mixed_shift_cast] using hall j
  · right
    refine ⟨remainingSixOneShifts c, hstrict.2.1, hstrict.2.2.1, ?_⟩
    intro j
    simpa [MixedGood, RemainingGood, hstrict.1, hstrict.2.2.2,
      mixed_shift_cast] using hall j

/-- Renault's fixed initially-safe 6.4 phase certificate, valid for arbitrary
real phases satisfying the stated initial circle-norm condition. -/
theorem renault_phase_six_four (x : Fin 3 → ℝ)
    (hx : ∀ j, (1 : ℝ) / 6 ≤ circleNorm (x j)) :
    (∀ j, (1 : ℝ) / 6 < circleNorm (2 * x j)) ∨
    (∃ b : ℕ, (b = 1 ∨ b = 5) ∧
      ∀ j, (1 : ℝ) / 6 < circleNorm (x j + (b : ℝ) / 6)) ∨
    (∃ a b : ℕ, (a = 3 ∨ a = 5) ∧ b ≤ 5 ∧
      ∀ j, (1 : ℝ) / 6 ≤
        circleNorm ((a : ℝ) * x j + (b : ℝ) / 6)) := by
  obtain ⟨c, hc⟩ := safe_normalized (fun j => Int.fract (x j)) (fun j =>
    sixth_safe_fract_band _ |>.mp (hx j))
  have hall : ∀ j, SafeGood c (x j) := fun j =>
    (remainingGood_fract _ _ _ _).mp (hc j)
  rcases safe_decoder c with hdouble | hshift | hclosed
  · left
    intro j
    simpa [SafeGood, RemainingGood, hdouble.1, hdouble.2.1, hdouble.2.2] using hall j
  · right; left
    refine ⟨remainingSixFourShifts c, hshift.2.1, ?_⟩
    intro j
    simpa [SafeGood, RemainingGood, hshift.1, hshift.2.2] using hall j
  · right; right
    refine ⟨remainingSixFourSlopes c, remainingSixFourShifts c,
      hclosed.1, hclosed.2.1, ?_⟩
    intro j
    simpa [SafeGood, RemainingGood, hclosed.2.2] using hall j

#print axioms renault_phase_six_one
#print axioms renault_phase_six_four

end LonelyRunner
