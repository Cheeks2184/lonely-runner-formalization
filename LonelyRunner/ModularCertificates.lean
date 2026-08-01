import Mathlib.Data.Finset.Card
import Mathlib.Data.Finset.Union
import Mathlib.Algebra.BigOperators.Group.Finset.Basic

/-!
# Finite union certificates

This file isolates the finite combinatorics used by modular-cover arguments.
It deliberately makes no claim about how the individual bad-set cardinalities
are obtained; number-theoretic counting formulas belong in a separate layer.
-/

namespace LonelyRunner

open scoped BigOperators

/-- The cardinality of a finite union is at most the sum of the cardinalities
of its indexed pieces.  This version has an explicit finite index set, which
is useful when a certificate only uses some of the available constraints. -/
theorem card_biUnion_le_sum_card {α ι : Type*} [DecidableEq α]
    (I : Finset ι) (B : ι → Finset α) :
    (I.biUnion B).card ≤ I.sum (fun i => (B i).card) := by
  classical
  induction I using Finset.induction_on with
  | empty => simp
  | @insert i I hi ih =>
      rw [Finset.biUnion_insert, Finset.sum_insert hi]
      exact (Finset.card_union_le (B i) (I.biUnion B)).trans
        (Nat.add_le_add_left ih (B i).card)

/-- A finite bad-set union cannot cover the candidate set when the sum of the
bad-set cardinalities is strictly smaller than the candidate cardinality. -/
theorem exists_mem_avoiding_of_sum_card_lt_card {α ι : Type*}
    [DecidableEq α] [Fintype ι] (R : Finset α) (B : ι → Finset α)
    (hB : ∀ i, B i ⊆ R)
    (hcard : Finset.univ.sum (fun i => (B i).card) < R.card) :
    ∃ r ∈ R, ∀ i, r ∉ B i := by
  classical
  let U : Finset α := Finset.univ.biUnion B
  have hU_subset : U ⊆ R := by
    intro r hr
    rcases Finset.mem_biUnion.mp hr with ⟨i, -, hri⟩
    exact hB i hri
  have hU_card : U.card < R.card :=
    (card_biUnion_le_sum_card Finset.univ B).trans_lt hcard
  by_contra havoid
  have hR_subset : R ⊆ U := by
    intro r hrR
    by_contra hrU
    apply havoid
    refine ⟨r, hrR, ?_⟩
    intro i hri
    exact hrU (Finset.mem_biUnion.mpr ⟨i, Finset.mem_univ i, hri⟩)
  exact (Nat.not_lt_of_ge (Finset.card_le_card hR_subset)) hU_card

/-- Replacing the full set of previously covered candidates by a selected
parent subset gives a sound (possibly weaker) upper bound for the next union. -/
theorem card_union_le_card_add_selected_remainder {α : Type*}
    [DecidableEq α] (covered new parent : Finset α)
    (hparent : parent ⊆ covered) :
    (covered ∪ new).card ≤ covered.card + (new \ parent).card := by
  have hdiff : new \ covered ⊆ new \ parent := by
    intro r hr
    have hrNew : r ∈ new := (Finset.mem_sdiff.mp hr).1
    have hrNotCovered : r ∉ covered := (Finset.mem_sdiff.mp hr).2
    exact Finset.mem_sdiff.mpr ⟨hrNew, fun hrParent => hrNotCovered (hparent hrParent)⟩
  calc
    (covered ∪ new).card = (new \ covered).card + covered.card := by
      rw [Finset.union_comm, Finset.card_sdiff_add_card]
    _ ≤ (new \ parent).card + covered.card :=
      Nat.add_le_add_right (Finset.card_le_card hdiff) covered.card
    _ = covered.card + (new \ parent).card := Nat.add_comm _ _

/-- An ordered overlap certificate.

`covered k` is the union after the first `k` bad sets have been processed.
For each step, `parent k` may be any selected subset of the already-covered
set.  Bounding only the genuinely new part relative to that parent suffices to
bound the final union.  The theorem is intentionally phrased with natural
indices so externally generated certificates do not need dependent vectors. -/
theorem card_ordered_union_le_sum_selected_remainders {α : Type*}
    [DecidableEq α] (n : ℕ) :
    ∀ (covered new parent : ℕ → Finset α) (bound : ℕ → ℕ),
      covered 0 = ∅ →
      (∀ k < n, covered (k + 1) = covered k ∪ new k) →
      (∀ k < n, parent k ⊆ covered k) →
      (∀ k < n, (new k \ parent k).card ≤ bound k) →
      (covered n).card ≤ (Finset.range n).sum bound := by
  induction n with
  | zero =>
      intro covered new parent bound hzero _ _ _
      simp [hzero]
  | succ n ih =>
      intro covered new parent bound hzero hstep hparent hbound
      have hprefix : (covered n).card ≤ (Finset.range n).sum bound :=
        ih covered new parent bound hzero
          (fun k hk => hstep k (Nat.lt_succ_of_lt hk))
          (fun k hk => hparent k (Nat.lt_succ_of_lt hk))
          (fun k hk => hbound k (Nat.lt_succ_of_lt hk))
      have hlastStep : covered (n + 1) = covered n ∪ new n :=
        hstep n (Nat.lt_succ_self n)
      have hlastParent : parent n ⊆ covered n :=
        hparent n (Nat.lt_succ_self n)
      have hlastBound : (new n \ parent n).card ≤ bound n :=
        hbound n (Nat.lt_succ_self n)
      rw [hlastStep, Finset.sum_range_succ]
      exact (card_union_le_card_add_selected_remainder
        (covered n) (new n) (parent n) hlastParent).trans
        ((Nat.add_le_add hprefix hlastBound))

/-- A strict ordered-union bound leaves a candidate outside the final covered
set.  This is the existential last step used by modular certificates after the
incremental cardinality bound has been checked. -/
theorem exists_mem_avoiding_ordered_of_sum_lt_card {α : Type*}
    [DecidableEq α] (R : Finset α) (n : ℕ)
    (covered new parent : ℕ → Finset α) (bound : ℕ → ℕ)
    (hzero : covered 0 = ∅)
    (hstep : ∀ k < n, covered (k + 1) = covered k ∪ new k)
    (hparent : ∀ k < n, parent k ⊆ covered k)
    (hbound : ∀ k < n, (new k \ parent k).card ≤ bound k)
    (hcard : (Finset.range n).sum bound < R.card) :
    ∃ r ∈ R, r ∉ covered n := by
  classical
  have hcovered : (covered n).card ≤ (Finset.range n).sum bound :=
    card_ordered_union_le_sum_selected_remainders n covered new parent bound
      hzero hstep hparent hbound
  have hlt : (covered n).card < R.card := hcovered.trans_lt hcard
  by_contra havoid
  have hR_subset : R ⊆ covered n := by
    intro r hrR
    by_contra hrCovered
    exact havoid ⟨r, hrR, hrCovered⟩
  exact (Nat.not_lt_of_ge (Finset.card_le_card hR_subset)) hlt

end LonelyRunner
