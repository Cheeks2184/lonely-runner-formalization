import LonelyRunner.PivotResidues

/-!
# Abstract two-sided top-pivot transversals

This file formalizes the sound finite implication behind the multi-affine
transversal approach.  It deliberately does not assert that a useful pair
family exists uniformly.  That arithmetic construction remains open.

The strict bad sets are the canonical `pivotBadResidues`; membership in the
robust set means that the other top runner is good, including equality at the
closed Lonely Runner boundary.
-/

namespace LonelyRunner

open Finset

/-- Candidate residues at `pivot` for which `otherTop` is already good. -/
def topRobustCandidates (N pivot otherTop : ℕ) : Finset ℕ :=
  (pivotCandidates N pivot).filter fun r =>
    r ∉ pivotBadResidues N pivot otherTop

theorem mem_topRobustCandidates {N pivot otherTop r : ℕ} :
    r ∈ topRobustCandidates N pivot otherTop ↔
      r ∈ pivotCandidates N pivot ∧
        r ∉ pivotBadResidues N pivot otherTop := by
  simp [topRobustCandidates]

/-- A lower-speed set spoils both endpoints of a selected top-pivot pair.
The spoilers at the two endpoints may be different speeds. -/
def twoSidedSpoils (N A B : ℕ) (lower : Finset ℕ) (p : ℕ × ℕ) : Prop :=
  (∃ v ∈ lower, p.1 ∈ pivotBadResidues N A v) ∧
    ∃ v ∈ lower, p.2 ∈ pivotBadResidues N B v

/-- Every selected robust pair is spoiled at both endpoints. -/
def IsTwoSidedTransversal (N A B : ℕ) (lower : Finset ℕ)
    (pairs : Finset (ℕ × ℕ)) : Prop :=
  ∀ p ∈ pairs, twoSidedSpoils N A B lower p

/-- Covering both complete robust top grids makes a lower-speed set a
two-sided transversal for every selected family of robust pairs. -/
theorem isTwoSidedTransversal_of_covers
    {N A B : ℕ} {lower : Finset ℕ} {pairs : Finset (ℕ × ℕ)}
    (hpairs : ∀ p ∈ pairs,
      p.1 ∈ topRobustCandidates N A B ∧
        p.2 ∈ topRobustCandidates N B A)
    (hcoverA : ∀ r ∈ topRobustCandidates N A B,
      ∃ v ∈ lower, r ∈ pivotBadResidues N A v)
    (hcoverB : ∀ r ∈ topRobustCandidates N B A,
      ∃ v ∈ lower, r ∈ pivotBadResidues N B v) :
    IsTwoSidedTransversal N A B lower pairs := by
  intro p hp
  exact ⟨hcoverA p.1 (hpairs p hp).1, hcoverB p.2 (hpairs p hp).2⟩

/-- If a selected robust-pair family is not a two-sided transversal, one
endpoint is a complete certificate against all lower speeds and the other top
runner.  This is the exact logical bridge used by a finite affine certificate;
the unproved work is to construct pair families forcing nontransversality for
all lower sets of the required size. -/
theorem exists_top_certificate_of_not_isTwoSidedTransversal
    {N A B : ℕ} {lower : Finset ℕ} {pairs : Finset (ℕ × ℕ)}
    (hpairs : ∀ p ∈ pairs,
      p.1 ∈ topRobustCandidates N A B ∧
        p.2 ∈ topRobustCandidates N B A)
    (hnot : ¬ IsTwoSidedTransversal N A B lower pairs) :
    (∃ r,
      r ∈ pivotCandidates N A ∧
        r ∉ pivotBadResidues N A B ∧
          ∀ v ∈ lower, r ∉ pivotBadResidues N A v) ∨
      ∃ r,
        r ∈ pivotCandidates N B ∧
          r ∉ pivotBadResidues N B A ∧
            ∀ v ∈ lower, r ∉ pivotBadResidues N B v := by
  classical
  have hex : ∃ p, p ∈ pairs ∧ ¬twoSidedSpoils N A B lower p := by
    by_contra hnone
    apply hnot
    intro p hp
    by_contra hspoils
    exact hnone ⟨p, hp, hspoils⟩
  obtain ⟨p, hp, hspoils⟩ := hex
  have hrobust := hpairs p hp
  have hrobustA := mem_topRobustCandidates.mp hrobust.1
  have hrobustB := mem_topRobustCandidates.mp hrobust.2
  by_cases hleft : ∃ v ∈ lower, p.1 ∈ pivotBadResidues N A v
  · right
    refine ⟨p.2, hrobustB.1, hrobustB.2, ?_⟩
    intro v hv hbad
    exact hspoils ⟨hleft, ⟨v, hv, hbad⟩⟩
  · left
    refine ⟨p.1, hrobustA.1, hrobustA.2, ?_⟩
    intro v hv hbad
    exact hleft ⟨v, hv, hbad⟩

end LonelyRunner
