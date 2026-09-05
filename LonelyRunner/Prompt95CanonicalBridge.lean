import LonelyRunner.Prompt99Scaling
import LonelyRunner.BHKRealReduction
import LonelyRunner.PivotBoundary

/-!
# Conditional Prompt95 bridge to the canonical conjecture

This module records two finite wrappers around the maximum-covered-pivot
redundancy premise.  It deliberately keeps that premise explicit: the results
below do not establish Prompt95 or the Lonely Runner Conjecture on their own.
-/

namespace LonelyRunner

open Finset

/-- On a nonempty pivot row, coverwise internal redundancy is exactly the
absence of an internal complete cover.  The forward implication repeatedly
erases a redundant owner; finiteness prevents this from continuing to the
empty cover. -/
theorem internalCoverRedundantAt_iff_no_internal_complete_cover
    {n N : Nat} {a : Fin n → Nat} {j : Fin n}
    (hCandidates : (pivotCandidates N (a j)).Nonempty) :
    InternalCoverRedundantAt N a j ↔
      ∀ C : Finset (Fin n),
        IsInternalOwnerSet N a j C → ¬ PivotCompleteCover N a j C := by
  constructor
  · intro hredundant C hinternal hcover
    have hEmptyNotCover : ¬ PivotCompleteCover N a j ∅ := by
      intro hEmptyCover
      obtain ⟨r, hr⟩ := hCandidates
      obtain ⟨i, hi, -⟩ := hEmptyCover.2 r hr
      simp at hi
    have hnoCover : ∀ C : Finset (Fin n),
        IsInternalOwnerSet N a j C → PivotCompleteCover N a j C → False := by
      intro D
      induction D using Finset.strongInduction with
      | H D ih =>
          intro hDinternal hDcover
          by_cases hDempty : D = ∅
          · exact hEmptyNotCover (by simpa [hDempty] using hDcover)
          · obtain ⟨i, hiD, hDeraseCover⟩ := hredundant D hDinternal hDcover
            have hDeraseInternal : IsInternalOwnerSet N a j (D.erase i) := by
              intro k hk
              exact hDinternal (Finset.erase_subset i D hk)
            exact ih (D.erase i) (Finset.erase_ssubset hiD)
              hDeraseInternal hDeraseCover
    exact hnoCover C hinternal hcover
  · intro hnoCover C hinternal hcover
    exact False.elim (hnoCover C hinternal hcover)

/-- The universal maximum-covered-pivot internal-cover redundancy premise
implies the positive-integer Lonely Runner formulation.  The premise remains
an explicit hypothesis because its truth is not established here. -/
theorem positiveIntegerConjecture_of_maxCoveredPivotInternalCoverRedundancy
    (h : MaxCoveredPivotInternalCoverRedundancy) :
    PositiveIntegerConjecture := by
  apply positiveIntegerConjecture_iff_pivotCertificateConjecture.mpr
  intro n hn speeds hinjective hpositive
  by_cases hnOne : n = 1
  · subst n
    let j : Fin 1 := ⟨0, by omega⟩
    refine ⟨j, 1, ?_, ?_⟩
    · rw [mem_pivotCandidates]
      constructor
      · have hp := hpositive j
        omega
      · omega
    · intro i hi
      exact False.elim (hi (Subsingleton.elim i j))
  · have hnTwo : 2 ≤ n := by omega
    by_contra hnoCertificate
    have hcovered : ∀ j : Fin n, PivotCovered (n + 1) speeds j := by
      intro j
      by_contra hnotCovered
      unfold PivotCovered at hnotCovered
      have hnotFull : ¬ ∀ r ∈ pivotCandidates (n + 1) (speeds j),
          ∃ i ∈ Finset.univ.erase j,
            r ∈ pivotBadResidues (n + 1) (speeds j) (speeds i) := by
        intro hfull
        exact hnotCovered ⟨Finset.Subset.rfl, hfull⟩
      push Not at hnotFull
      obtain ⟨r, hr, havoid⟩ := hnotFull
      apply hnoCertificate
      refine ⟨j, r, hr, ?_⟩
      intro i hij
      exact havoid i (by simp [hij])
    have hUnivNonempty : (Finset.univ : Finset (Fin n)).Nonempty := by
      exact ⟨⟨0, by omega⟩, Finset.mem_univ _⟩
    obtain ⟨j, -, hmax⟩ :=
      Finset.exists_max_image Finset.univ speeds hUnivNonempty
    have hjMaximum : IsMaximumCoveredPivot (n + 1) speeds j := by
      constructor
      · simp [coveredPivots, hcovered]
      · intro k hk
        exact hmax k (Finset.mem_univ k)
    have hfullInternal :
        IsInternalOwnerSet (n + 1) speeds j (Finset.univ.erase j) := by
      intro k hk
      rw [Finset.mem_erase] at hk ⊢
      exact ⟨hk.1, by simp [coveredPivots, hcovered]⟩
    have hfullCover : PivotCompleteCover (n + 1) speeds j (Finset.univ.erase j) :=
      hcovered j
    have hCandidates : (pivotCandidates (n + 1) (speeds j)).Nonempty := by
      refine ⟨1, ?_⟩
      rw [mem_pivotCandidates]
      constructor
      · have hp := hpositive j
        exact lt_of_lt_of_le (by omega)
          (Nat.le_mul_of_pos_right (n + 1) hp)
      · exact Nat.not_dvd_of_pos_of_lt (by omega) (by omega)
    have hredundant := h n hnTwo speeds hpositive hinjective j hjMaximum
    exact (internalCoverRedundantAt_iff_no_internal_complete_cover hCandidates).mp
      hredundant (Finset.univ.erase j) hfullInternal hfullCover

/-- The conditional Prompt95 bridge reaches the canonical real-speed
formulation through the checked positive-integer equivalence. -/
theorem conjecture_of_maxCoveredPivotInternalCoverRedundancy
    (h : MaxCoveredPivotInternalCoverRedundancy) : Conjecture :=
  conjecture_iff_positiveIntegerConjecture.mpr
    (positiveIntegerConjecture_of_maxCoveredPivotInternalCoverRedundancy h)

end LonelyRunner
