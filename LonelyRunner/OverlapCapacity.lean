import Mathlib.Data.Finset.Card
import Mathlib.Data.Finset.Union
import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Algebra.Order.BigOperators.Group.Finset

/-!
# Duplicate-incidence capacity for overlap blocks

This file isolates the finite double-counting principle behind whole-overlap
packing.  It makes no claim that any modular instance admits a packing of a
specified size.
-/

namespace LonelyRunner

open scoped BigOperators

variable {R I E : Type*} [Fintype R] [Fintype I] [Fintype E]
  [DecidableEq R]

/-- Number of bad sets containing a point. -/
noncomputable def incidenceMultiplicity (bad : I -> Finset R) (point : R) : Nat := by
  classical
  exact Finset.univ.sum (fun i : I => if point ∈ bad i then 1 else 0)

/-- Number of selected overlap blocks using a point. -/
noncomputable def overlapPointUse (blocks : E -> Finset R) (point : R) : Nat := by
  classical
  exact Finset.univ.sum (fun e : E => if point ∈ blocks e then 1 else 0)

/-- Double-counting bad-set incidences by sets or by points gives the same
total. -/
theorem sum_card_bad_eq_sum_incidenceMultiplicity (bad : I -> Finset R) :
    Finset.univ.sum (fun i : I => (bad i).card) =
      Finset.univ.sum (incidenceMultiplicity bad) := by
  classical
  calc
    Finset.univ.sum (fun i : I => (bad i).card) =
        Finset.univ.sum (fun i : I =>
          Finset.univ.sum (fun point : R => if point ∈ bad i then 1 else 0)) := by
            apply Finset.sum_congr rfl
            intro i _
            simp
    _ = Finset.univ.sum (fun point : R =>
          Finset.univ.sum (fun i : I => if point ∈ bad i then 1 else 0)) := by
            exact Finset.sum_comm
    _ = Finset.univ.sum (incidenceMultiplicity bad) := by
          simp [incidenceMultiplicity]

/-- Double-counting selected-block uses by blocks or by points gives the same
total. -/
theorem sum_card_blocks_eq_sum_overlapPointUse (blocks : E -> Finset R) :
    Finset.univ.sum (fun e : E => (blocks e).card) =
      Finset.univ.sum (overlapPointUse blocks) := by
  classical
  calc
    Finset.univ.sum (fun e : E => (blocks e).card) =
        Finset.univ.sum (fun e : E =>
          Finset.univ.sum (fun point : R => if point ∈ blocks e then 1 else 0)) := by
            apply Finset.sum_congr rfl
            intro e _
            simp
    _ = Finset.univ.sum (fun point : R =>
          Finset.univ.sum (fun e : E => if point ∈ blocks e then 1 else 0)) := by
            exact Finset.sum_comm
    _ = Finset.univ.sum (overlapPointUse blocks) := by
          simp [overlapPointUse]

omit [Fintype R] in
theorem incidenceMultiplicity_pos_of_mem_biUnion
    (bad : I -> Finset R) {point : R}
    (hpoint : point ∈ Finset.univ.biUnion bad) :
    0 < incidenceMultiplicity bad point := by
  classical
  obtain ⟨i, -, hi⟩ := Finset.mem_biUnion.mp hpoint
  have hsingle : (if point ∈ bad i then 1 else 0) <=
      Finset.univ.sum (fun j : I => if point ∈ bad j then 1 else 0) := by
    exact Finset.single_le_sum
      (fun j _ => Nat.zero_le (if point ∈ bad j then 1 else 0))
      (Finset.mem_univ i)
  rw [incidenceMultiplicity]
  exact lt_of_lt_of_le (by simp [hi]) hsingle

omit [Fintype R] in
theorem incidenceMultiplicity_eq_card_filter (bad : I -> Finset R) (point : R) :
    incidenceMultiplicity bad point =
      (Finset.univ.filter (fun i : I => point ∈ bad i)).card := by
  classical
  rw [incidenceMultiplicity, ← Finset.sum_filter]
  simp

omit [Fintype R] in
theorem overlapPointUse_eq_card_filter (blocks : E -> Finset R) (point : R) :
    overlapPointUse blocks point =
      (Finset.univ.filter (fun e : E => point ∈ blocks e)).card := by
  classical
  rw [overlapPointUse, ← Finset.sum_filter]
  simp

omit [Fintype R] in
/-- An injective owner assignment consumes at most duplicate-incidence
capacity when every used point has some bad-set owner that is not selected at
that point.  This is the abstract indegree-at-most-one counting lemma. -/
theorem overlapPointUse_le_capacity_of_injectiveOwner_of_unowned
    (bad : I -> Finset R) (blocks : E -> Finset R) (owner : E -> I)
    (hownerInjective : Function.Injective owner)
    (hownerBad : forall (e : E) (point : R), point ∈ blocks e -> point ∈ bad (owner e))
    (hunowned : forall point : R, point ∈ Finset.univ.biUnion bad ->
      exists missing : I, point ∈ bad missing /\
        forall e : E, point ∈ blocks e -> owner e ≠ missing) :
    forall point : R,
      overlapPointUse blocks point <= incidenceMultiplicity bad point - 1 := by
  classical
  intro point
  by_cases hpoint : point ∈ Finset.univ.biUnion bad
  · obtain ⟨missing, hmissingBad, hmissing⟩ := hunowned point hpoint
    let used := Finset.univ.filter (fun e : E => point ∈ blocks e)
    let badAt := Finset.univ.filter (fun i : I => point ∈ bad i)
    have hmissingMem : missing ∈ badAt := by simp [badAt, hmissingBad]
    have himage : used.image owner ⊆ badAt.erase missing := by
      intro imageOwner hmem
      obtain ⟨e, heUsed, rfl⟩ := Finset.mem_image.mp hmem
      have heBlock : point ∈ blocks e := (Finset.mem_filter.mp heUsed).2
      exact Finset.mem_erase.mpr ⟨hmissing e heBlock, by
        simp [badAt, hownerBad e point heBlock]⟩
    have husedCard : used.card <= badAt.card - 1 := by
      calc
        used.card = (used.image owner).card :=
          (Finset.card_image_iff.mpr hownerInjective.injOn).symm
        _ <= (badAt.erase missing).card := Finset.card_le_card himage
        _ = badAt.card - 1 := Finset.card_erase_of_mem hmissingMem
    rw [overlapPointUse_eq_card_filter, incidenceMultiplicity_eq_card_filter]
    exact husedCard
  · have hnblock : forall e : E, point ∉ blocks e := by
      intro e he
      apply hpoint
      exact Finset.mem_biUnion.mpr
        ⟨owner e, Finset.mem_univ _, hownerBad e point he⟩
    have hnbad : forall i : I, point ∉ bad i := by
      intro i hi
      apply hpoint
      exact Finset.mem_biUnion.mpr ⟨i, Finset.mem_univ _, hi⟩
    simp [overlapPointUse, incidenceMultiplicity, hnblock, hnbad]

omit [Fintype R] in
/-- A strict owner order supplies the unowned bad set: a minimum-key bad
owner cannot receive a selected block from a strictly earlier bad parent.
Injectivity of `owner` is the abstract indegree-at-most-one hypothesis. -/
theorem overlapPointUse_le_capacity_of_ordered_injectiveOwner
    (bad : I -> Finset R) (blocks : E -> Finset R)
    (owner parent : E -> I) (key : I -> Nat)
    (hownerInjective : Function.Injective owner)
    (hownerBad : forall (e : E) (point : R), point ∈ blocks e -> point ∈ bad (owner e))
    (hparentBad : forall (e : E) (point : R), point ∈ blocks e -> point ∈ bad (parent e))
    (hbefore : forall e : E, key (parent e) < key (owner e))
    (hminimum : forall point : R, point ∈ Finset.univ.biUnion bad ->
      exists first : I, point ∈ bad first /\
        forall i : I, point ∈ bad i -> key first <= key i) :
    forall point : R,
      overlapPointUse blocks point <= incidenceMultiplicity bad point - 1 := by
  apply overlapPointUse_le_capacity_of_injectiveOwner_of_unowned
    bad blocks owner hownerInjective hownerBad
  intro point hpoint
  obtain ⟨first, hfirstBad, hfirstMin⟩ := hminimum point hpoint
  refine ⟨first, hfirstBad, ?_⟩
  intro e heBlock heq
  have hparentMin := hfirstMin (parent e) (hparentBad e point heBlock)
  rw [← heq] at hparentMin
  exact (Nat.not_lt_of_ge hparentMin) (hbefore e)

/-- Subtraction-free duplicate-incidence capacity theorem. -/
theorem card_biUnion_add_sum_card_blocks_le_sum_card_bad
    (bad : I -> Finset R) (blocks : E -> Finset R)
    (hcapacity : forall point : R,
      overlapPointUse blocks point <= incidenceMultiplicity bad point - 1) :
    (Finset.univ.biUnion bad).card +
        Finset.univ.sum (fun e : E => (blocks e).card) <=
      Finset.univ.sum (fun i : I => (bad i).card) := by
  classical
  let U := Finset.univ.biUnion bad
  have hpoint : forall point : R,
      (if point ∈ U then 1 else 0) + overlapPointUse blocks point <=
        incidenceMultiplicity bad point := by
    intro point
    by_cases hmem : point ∈ U
    · have hpos : 0 < incidenceMultiplicity bad point :=
        incidenceMultiplicity_pos_of_mem_biUnion bad hmem
      simp only [if_pos hmem]
      have hcap := hcapacity point
      omega
    · simp only [if_neg hmem, zero_add]
      exact (hcapacity point).trans (Nat.sub_le _ _)
  have hsum := Finset.sum_le_sum (fun point (_ : point ∈ (Finset.univ : Finset R)) =>
    hpoint point)
  rw [Finset.sum_add_distrib] at hsum
  have hUcard : Finset.univ.sum (fun point : R => if point ∈ U then 1 else 0) =
      U.card := by simp
  rw [hUcard, ← sum_card_blocks_eq_sum_overlapPointUse blocks,
    ← sum_card_bad_eq_sum_incidenceMultiplicity bad] at hsum
  exact hsum

/-! The additive form above is the form used by adapters: the total bad-set
cardinality must pay both for the covered ambient points and for the supplied
overlap blocks. -/

/-- A supplied overlap packing leaves a point outside every bad set whenever
its subtraction-free total threshold is strict. -/
theorem exists_avoiding_of_overlapCapacity
    (bad : I -> Finset R) (blocks : E -> Finset R)
    (hcapacity : forall point : R,
      overlapPointUse blocks point <= incidenceMultiplicity bad point - 1)
    (hstrict : Finset.univ.sum (fun i : I => (bad i).card) <
      Fintype.card R + Finset.univ.sum (fun e : E => (blocks e).card)) :
    exists point : R, forall i, point ∉ bad i := by
  classical
  have hbound :=
    card_biUnion_add_sum_card_blocks_le_sum_card_bad bad blocks hcapacity
  by_contra havoid
  have huniv_subset : (Finset.univ : Finset R) ⊆ Finset.univ.biUnion bad := by
    intro point hpoint
    by_contra hnot
    apply havoid
    refine ⟨point, ?_⟩
    intro i hbad
    exact hnot (Finset.mem_biUnion.mpr ⟨i, Finset.mem_univ _, hbad⟩)
  have hcard : Fintype.card R ≤ (Finset.univ.biUnion bad).card := by
    simpa using Finset.card_le_card huniv_subset
  omega

/-- Requested truncated-subtraction form of the capacity theorem. -/
theorem card_biUnion_le_sum_card_bad_sub_sum_card_blocks
    (bad : I -> Finset R) (blocks : E -> Finset R)
    (hcapacity : forall point : R,
      overlapPointUse blocks point <= incidenceMultiplicity bad point - 1) :
    (Finset.univ.biUnion bad).card <=
      Finset.univ.sum (fun i : I => (bad i).card) -
        Finset.univ.sum (fun e : E => (blocks e).card) := by
  have h := card_biUnion_add_sum_card_blocks_le_sum_card_bad bad blocks hcapacity
  omega

end LonelyRunner
