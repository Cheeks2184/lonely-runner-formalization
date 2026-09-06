import Mathlib.Tactic

namespace LonelyRunner

/-- Among three labelled elements covered by two predicates, two distinct
labels share one predicate.  Predicate overlap is allowed. -/
theorem exists_two_same_side_of_three {ι : Type*} [DecidableEq ι]
    (S : Finset ι) (hS : 3 ≤ S.card) (P Q : ι → Prop)
    (hcover : ∀ i ∈ S, P i ∨ Q i) :
    (∃ u ∈ S, ∃ w ∈ S, u ≠ w ∧ P u ∧ P w) ∨
      (∃ u ∈ S, ∃ w ∈ S, u ≠ w ∧ Q u ∧ Q w) := by
  classical
  let A := S.filter P
  by_cases hA : 2 ≤ A.card
  · left
    obtain ⟨u, hu, w, hw, hne⟩ := Finset.one_lt_card.mp (by omega : 1 < A.card)
    refine ⟨u, (Finset.mem_filter.mp hu).1, w, (Finset.mem_filter.mp hw).1, hne,
      (Finset.mem_filter.mp hu).2, (Finset.mem_filter.mp hw).2⟩
  · right
    let B := S.filter (fun i => ¬ P i)
    have hsum : A.card + B.card = S.card := by
      simpa [A, B] using (Finset.card_filter_add_card_filter_not (s := S) P)
    have hB : 2 ≤ B.card := by omega
    obtain ⟨u, hu, w, hw, hne⟩ := Finset.one_lt_card.mp (by omega : 1 < B.card)
    have huS := (Finset.mem_filter.mp hu).1
    have hwS := (Finset.mem_filter.mp hw).1
    have huP := (Finset.mem_filter.mp hu).2
    have hwP := (Finset.mem_filter.mp hw).2
    refine ⟨u, huS, w, hwS, hne, ?_, ?_⟩
    · exact (hcover u huS).resolve_left huP
    · exact (hcover w hwS).resolve_left hwP

end LonelyRunner
