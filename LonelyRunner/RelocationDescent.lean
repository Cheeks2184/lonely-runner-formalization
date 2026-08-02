import Mathlib.Data.Finset.Max
import Mathlib.Data.List.Defs
import Mathlib.Tactic

/-!
# Finite relocation descent

This file isolates the order-theoretic core of a relocation argument.  A
finite nonempty state space has a state of minimum natural-valued cost.  Thus,
if every state whose cost is at least a target bound admits an allowed move to
a strictly cheaper state, some state must already have cost below the bound.

The final part records a generic exact identity for moving one entry past a
contiguous middle block in a list.  Costs may depend on the *set* of earlier
entries.  The suffix contributes the same amount to both orders because its
prefix set is unchanged by the relocation.

No arithmetic statement about lonely-runner fibers is made here.  In
particular, the hypothesis that every expensive runner order has a decreasing
relocation is the unresolved `RELOC-UNIF` obligation, not a theorem of this
module.
-/

namespace LonelyRunner

/-- A state realizes the minimum cost among the members of `states`. -/
def IsCostMinimizer {σ : Type*} [DecidableEq σ]
    (states : Finset σ) (cost : σ → ℕ) (state : σ) : Prop :=
  state ∈ states ∧ ∀ other ∈ states, cost state ≤ cost other

/-- A state is locally minimal for the allowed moves that remain in `states`. -/
def IsLocalCostMinimum {σ : Type*} [DecidableEq σ]
    (states : Finset σ) (move : σ → σ → Prop)
    (cost : σ → ℕ) (state : σ) : Prop :=
  state ∈ states ∧
    ∀ other ∈ states, move state other → cost state ≤ cost other

/-- A nonempty finite state space has a global natural-valued cost minimizer. -/
theorem exists_costMinimizer
    {σ : Type*} [DecidableEq σ]
    (states : Finset σ) (cost : σ → ℕ) (hne : states.Nonempty) :
    ∃ state, IsCostMinimizer states cost state := by
  obtain ⟨state, hstate, hminimal⟩ :=
    Finset.exists_min_image states cost hne
  exact ⟨state, hstate, hminimal⟩

/-- Every global minimum is a local minimum for any specified move relation. -/
theorem IsCostMinimizer.isLocalCostMinimum
    {σ : Type*} [DecidableEq σ]
    {states : Finset σ} {move : σ → σ → Prop} {cost : σ → ℕ} {state : σ}
    (h : IsCostMinimizer states cost state) :
    IsLocalCostMinimum states move cost state := by
  exact ⟨h.1, fun other hother _ => h.2 other hother⟩

/-- A nonempty finite state space has a local minimum for any move relation. -/
theorem exists_localCostMinimum
    {σ : Type*} [DecidableEq σ]
    (states : Finset σ) (move : σ → σ → Prop)
    (cost : σ → ℕ) (hne : states.Nonempty) :
    ∃ state, IsLocalCostMinimum states move cost state := by
  obtain ⟨state, hstate⟩ := exists_costMinimizer states cost hne
  exact ⟨state, hstate.isLocalCostMinimum⟩

/-- **Finite relocation descent.**

If every state of cost at least `bound` has an allowed strictly
cost-decreasing move to another state in the finite search space, then the
search space contains a state of cost strictly less than `bound`.
-/
theorem exists_cost_lt_of_decreasing_move
    {σ : Type*} [DecidableEq σ]
    (states : Finset σ) (move : σ → σ → Prop) (cost : σ → ℕ)
    (bound : ℕ) (hne : states.Nonempty)
    (hdecrease : ∀ state ∈ states, bound ≤ cost state →
      ∃ other ∈ states, move state other ∧ cost other < cost state) :
    ∃ state ∈ states, cost state < bound := by
  obtain ⟨state, hstate, hminimal⟩ :=
    Finset.exists_min_image states cost hne
  refine ⟨state, hstate, ?_⟩
  by_contra hnot
  have hbound : bound ≤ cost state := Nat.le_of_not_gt hnot
  obtain ⟨other, hother, _, hdecreased⟩ :=
    hdecrease state hstate hbound
  exact (not_lt_of_ge (hminimal other hother)) hdecreased

/-- Total cost of a list when the cost of its next entry may depend on the set
of entries already present in the prefix. -/
def prefixDependentCost {ι : Type*} [DecidableEq ι]
    (entryCost : Finset ι → ι → ℕ) (initial : Finset ι) : List ι → ℕ
  | [] => 0
  | entry :: suffix =>
      entryCost initial entry +
        prefixDependentCost entryCost (insert entry initial) suffix

/-- Splitting a list shifts the initial prefix set for the second part by the
set of entries occurring in the first part. -/
theorem prefixDependentCost_append
    {ι : Type*} [DecidableEq ι]
    (entryCost : Finset ι → ι → ℕ)
    (initial : Finset ι) (first second : List ι) :
    prefixDependentCost entryCost initial (first ++ second) =
      prefixDependentCost entryCost initial first +
        prefixDependentCost entryCost (initial ∪ first.toFinset) second := by
  induction first generalizing initial with
  | nil => simp [prefixDependentCost]
  | cons entry rest ih =>
      simp only [List.cons_append, prefixDependentCost, List.toFinset_cons]
      rw [ih]
      have hprefix :
          insert entry initial ∪ rest.toFinset =
            initial ∪ insert entry rest.toFinset := by
        ext value
        simp only [Finset.mem_insert, Finset.mem_union]
        tauto
      rw [hprefix]
      omega

/-- Exact block-cost identity for relocating `entry` from before `middle` to
after it.  Adding the cost of the opposite middle block to each total avoids
subtraction in `ℕ`.

The two suffix prefix sets are equal: both contain `initial`, all entries of
`leading` and `middle`, and `entry`.  Consequently all suffix costs cancel in
the displayed identity.  No nodup hypothesis is required because costs depend
only on prefix sets.
-/
theorem prefixDependentCost_relocate
    {ι : Type*} [DecidableEq ι]
    (entryCost : Finset ι → ι → ℕ) (initial : Finset ι)
    (leading middle suffix : List ι) (entry : ι) :
    let beforeMiddle := initial ∪ leading.toFinset
    let oldBlock :=
      entryCost beforeMiddle entry +
        prefixDependentCost entryCost (insert entry beforeMiddle) middle
    let newBlock :=
      prefixDependentCost entryCost beforeMiddle middle +
        entryCost (beforeMiddle ∪ middle.toFinset) entry
    prefixDependentCost entryCost initial
          (leading ++ entry :: middle ++ suffix) + newBlock =
      prefixDependentCost entryCost initial
          (leading ++ middle ++ entry :: suffix) + oldBlock := by
  dsimp only
  rw [prefixDependentCost_append, prefixDependentCost_append]
  simp only [prefixDependentCost]
  rw [prefixDependentCost_append]
  rw [prefixDependentCost_append]
  simp only [prefixDependentCost]
  have holdSuffix :
      initial ∪ (leading ++ entry :: middle).toFinset =
        insert entry ((initial ∪ leading.toFinset) ∪ middle.toFinset) := by
    ext value
    simp only [List.toFinset_append, List.toFinset_cons,
      Finset.mem_union, Finset.mem_insert]
    tauto
  have hnewEntry :
      initial ∪ (leading ++ middle).toFinset =
        (initial ∪ leading.toFinset) ∪ middle.toFinset := by
    ext value
    simp only [List.toFinset_append, Finset.mem_union]
    tauto
  rw [holdSuffix, hnewEntry]
  omega

end LonelyRunner
