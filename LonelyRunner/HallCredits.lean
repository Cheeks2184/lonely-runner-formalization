import Mathlib.Combinatorics.Hall.Finite
import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Data.Finset.Sigma
import Mathlib.Data.Fintype.Sigma

/-!
# Capacitated Hall certificates for ordered overlap credit

Pairwise intersection sizes cannot simply be added when several earlier bad
sets are used as parents: the same residue may lie in several intersections.
This file gives the exact repair.  A quota `weight i` attached to parent `i`
can be realized by pairwise distinct eligible residues if and only if every
collection of parents satisfies the corresponding capacitated Hall cut.

The proof reduces the capacitated statement to the finite Hall marriage
theorem by replacing parent `i` with `weight i` indistinguishable-neighborhood
quota units.  The resulting injection is the disjoint allocation needed by an
ordered bad-set certificate.
-/

namespace LonelyRunner

open Finset

/-- A quota unit is a parent together with one of its requested credit slots. -/
abbrev HallQuotaUnit {ι : Type*} (weight : ι → ℕ) := Σ i, Fin (weight i)

/-- Every subset of cloned quota units has at most the total capacity of the
parents represented in that subset. -/
private theorem card_quotaUnits_le_sum_image_fst {ι : Type*} [Fintype ι]
    [DecidableEq ι] (weight : ι → ℕ)
    (units : Finset (HallQuotaUnit weight)) :
    units.card ≤ ∑ i ∈ units.image Sigma.fst, weight i := by
  let allUnits : Finset (HallQuotaUnit weight) :=
    (units.image Sigma.fst).sigma fun i => Finset.univ
  have hsubset : units ⊆ allUnits := by
    intro unit hunit
    apply mem_sigma.mpr
    exact ⟨mem_image.mpr ⟨unit, hunit, rfl⟩, mem_univ _⟩
  refine (card_le_card hsubset).trans_eq ?_
  dsimp [allUnits]
  rw [← disjiUnion_map_sigma_mk, card_disjiUnion]
  simp

/-- The union of eligibility sets represented by cloned units is the same as
the union indexed by the represented parents. -/
private theorem biUnion_quotaUnits_eq_biUnion_image_fst
    {ι α : Type*} [Fintype ι] [DecidableEq ι] [DecidableEq α]
    (eligible : ι → Finset α) (weight : ι → ℕ)
    (units : Finset (HallQuotaUnit weight)) :
    units.biUnion (fun unit => eligible unit.1) =
      (units.image Sigma.fst).biUnion eligible := by
  ext x
  simp

/-- **Capacitated finite Hall theorem.**  Parent `i` requests `weight i`
distinct credits from `eligible i`.  Such credits can be chosen injectively
across all parents exactly when every parent subset has enough eligible
residues in its union.

This is the precise missing condition in pairwise-overlap accounting: taking
only singleton cuts checks `weight i ≤ |eligible i|`, but does not prevent two
parents from trying to spend the same residue. -/
theorem capacitatedHall_iff_existsInjective
    {ι α : Type*} [Fintype ι] [DecidableEq ι] [DecidableEq α]
    (eligible : ι → Finset α) (weight : ι → ℕ) :
    (∀ parents : Finset ι,
        ∑ i ∈ parents, weight i ≤ (parents.biUnion eligible).card) ↔
      ∃ assign : HallQuotaUnit weight → α,
        Function.Injective assign ∧
          ∀ unit, assign unit ∈ eligible unit.1 := by
  constructor
  · intro hHall
    rw [← Finset.all_card_le_biUnion_card_iff_existsInjective']
    intro units
    calc
      units.card ≤ ∑ i ∈ units.image Sigma.fst, weight i :=
        card_quotaUnits_le_sum_image_fst weight units
      _ ≤ ((units.image Sigma.fst).biUnion eligible).card :=
        hHall (units.image Sigma.fst)
      _ = (units.biUnion fun unit => eligible unit.1).card := by
        rw [biUnion_quotaUnits_eq_biUnion_image_fst]
  · rintro ⟨assign, hinjective, heligible⟩ parents
    let units : Finset (HallQuotaUnit weight) :=
      parents.sigma fun i => Finset.univ
    have hunitsCard : units.card = ∑ i ∈ parents, weight i := by
      dsimp [units]
      rw [← disjiUnion_map_sigma_mk, card_disjiUnion]
      simp
    have himageSubset : units.image assign ⊆ parents.biUnion eligible := by
      intro x hx
      obtain ⟨unit, hunit, rfl⟩ := mem_image.mp hx
      have hparent : unit.1 ∈ parents := by
        simpa [units] using hunit
      exact mem_biUnion.mpr ⟨unit.1, hparent, heligible unit⟩
    calc
      ∑ i ∈ parents, weight i = units.card := hunitsCard.symm
      _ = (units.image assign).card :=
        (card_image_iff.mpr (hinjective.injOn)).symm
      _ ≤ (parents.biUnion eligible).card := card_le_card himageSubset

/-- A Hall-feasible collection of edge quotas supplies a sound scalar overlap
credit.  This is just the full-parent cut, separated out because it is the
only consequence needed by the ordered-union cardinality induction. -/
theorem sum_weight_le_card_biUnion_of_capacitatedHall
    {ι α : Type*} [Fintype ι] [DecidableEq ι] [DecidableEq α]
    (eligible : ι → Finset α) (weight : ι → ℕ)
    (hHall : ∀ parents : Finset ι,
      ∑ i ∈ parents, weight i ≤ (parents.biUnion eligible).card) :
    ∑ i, weight i ≤ (Finset.univ.biUnion eligible).card := by
  simpa using hHall Finset.univ

/-- Specialize the full Hall cut to overlap eligibility.  When every selected
parent lies in `covered`, the total realizable quota is no larger than the
actual overlap of the new set with everything covered so far. -/
theorem sum_weight_le_card_inter_covered_of_capacitatedHall
    {ι α : Type*} [Fintype ι] [DecidableEq ι] [DecidableEq α]
    (covered new : Finset α) (parent : ι → Finset α) (weight : ι → ℕ)
    (hparent : ∀ i, parent i ⊆ covered)
    (hHall : ∀ parents : Finset ι,
      ∑ i ∈ parents, weight i ≤
        (parents.biUnion fun i => new ∩ parent i).card) :
    ∑ i, weight i ≤ (new ∩ covered).card := by
  refine (sum_weight_le_card_biUnion_of_capacitatedHall
    (fun i => new ∩ parent i) weight hHall).trans ?_
  apply card_le_card
  intro x hx
  obtain ⟨i, _, hxi⟩ := mem_biUnion.mp hx
  exact mem_inter.mpr ⟨(mem_inter.mp hxi).1, hparent i (mem_inter.mp hxi).2⟩

/-- Hall-feasible edge quotas give the corresponding one-step ordered union
bound without any double counting. -/
theorem card_union_add_sum_weight_le
    {ι α : Type*} [Fintype ι] [DecidableEq ι] [DecidableEq α]
    (covered new : Finset α) (parent : ι → Finset α) (weight : ι → ℕ)
    (hparent : ∀ i, parent i ⊆ covered)
    (hHall : ∀ parents : Finset ι,
      ∑ i ∈ parents, weight i ≤
        (parents.biUnion fun i => new ∩ parent i).card) :
    (covered ∪ new).card + ∑ i, weight i ≤ covered.card + new.card := by
  have hcredit := sum_weight_le_card_inter_covered_of_capacitatedHall
    covered new parent weight hparent hHall
  calc
    (covered ∪ new).card + ∑ i, weight i ≤
        (covered ∪ new).card + (new ∩ covered).card :=
      Nat.add_le_add_left hcredit _
    _ = covered.card + new.card := by
      simpa [inter_comm] using card_union_add_card_inter covered new

/-- Union of an ordered list of finite bad sets.  The head is regarded as the
last set inserted, so its selected full-history parent is the tail union. -/
def orderedFinsetUnion {α : Type*} [DecidableEq α] :
    List (Finset α) → Finset α
  | [] => ∅
  | set :: sets => set ∪ orderedFinsetUnion sets

/-- Total exact overlap credit obtained by using the complete earlier union at
each insertion step. -/
def orderedOverlapCredit {α : Type*} [DecidableEq α] :
    List (Finset α) → ℕ
  | [] => 0
  | set :: sets =>
      (set ∩ orderedFinsetUnion sets).card + orderedOverlapCredit sets

/-- Full-history overlap accounting is exact, not merely an upper bound.  The
identity also explains the limitation of the Hall route: quotas attaining
this total encode exactly the redundancy already present in the union. -/
theorem card_orderedFinsetUnion_add_orderedOverlapCredit
    {α : Type*} [DecidableEq α] (sets : List (Finset α)) :
    (orderedFinsetUnion sets).card + orderedOverlapCredit sets =
      (sets.map Finset.card).sum := by
  induction sets with
  | nil => simp [orderedFinsetUnion, orderedOverlapCredit]
  | cons set sets ih =>
      change
        (set ∪ orderedFinsetUnion sets).card +
            ((set ∩ orderedFinsetUnion sets).card + orderedOverlapCredit sets) =
          set.card + (sets.map Finset.card).sum
      calc
        _ = ((set ∪ orderedFinsetUnion sets).card +
              (set ∩ orderedFinsetUnion sets).card) +
              orderedOverlapCredit sets := by
            rw [Nat.add_assoc]
        _ = (set.card + (orderedFinsetUnion sets).card) +
              orderedOverlapCredit sets := by
            rw [card_union_add_card_inter]
        _ = set.card + ((orderedFinsetUnion sets).card +
              orderedOverlapCredit sets) := by
            rw [Nat.add_assoc]
        _ = set.card + (sets.map Finset.card).sum := by rw [ih]

end LonelyRunner
