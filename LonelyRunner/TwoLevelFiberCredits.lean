import LonelyRunner.FiberCredits

/-!
# Two-level fiberwise overlap credits

This module strengthens `fiberCredit` by choosing an anchor parent and then
partitioning every child fiber into subfibers.  In a subfiber `S`, the anchor
receives the exact credit `|S ∩ A|`; outside the anchor, one other parent may
receive the largest available credit

`max_P |(S \ A) ∩ P|`.

The two credited parts are disjoint.  Disjointness of the subfiber partition
therefore makes the total a sound lower bound on the child's actual overlap
with all parents.  Maximizing this sound quantity over the anchor choice is
still sound.  It is also at least the one-level credit from
`LonelyRunner.FiberCredits`.
-/

namespace LonelyRunner

open scoped BigOperators

/-- Credit obtained from one anchor and an anchor-dependent subfiber
partition.  The other-parent maximum is taken only outside the anchor, so no
point can be credited twice. -/
def anchoredSubfiberCredit
    {α κ ι ν : Type*} [DecidableEq α] [DecidableEq ι]
    (fiberIndices : Finset κ) (subfiberIndices : κ → Finset ν)
    (subfibers : κ → ν → Finset α) (parents : Finset ι)
    (parent : ι → Finset α) (anchor : ι) : ℕ :=
  ∑ x ∈ fiberIndices, ∑ y ∈ subfiberIndices x,
    (((subfibers x y) ∩ parent anchor).card +
      (parents.erase anchor).sup fun i =>
        (((subfibers x y) \ parent anchor) ∩ parent i).card)

/-- Maximize the sound anchored credit over all possible anchor parents. -/
def twoLevelFiberCredit
    {α κ ι ν : Type*} [DecidableEq α] [DecidableEq ι]
    (fiberIndices : Finset κ)
    (subfiberIndices : ι → κ → Finset ν)
    (subfibers : ι → κ → ν → Finset α)
    (parents : Finset ι) (parent : ι → Finset α) : ℕ :=
  parents.sup fun anchor => anchoredSubfiberCredit fiberIndices
    (subfiberIndices anchor) (subfibers anchor) parents parent anchor

/-- Within one subfiber, anchor credit plus the best non-anchor credit is
bounded by that subfiber's intersection with the complete parent union. -/
private theorem subfiber_anchor_add_sup_le_card_inter_biUnion
    {α ι : Type*} [DecidableEq α] [DecidableEq ι]
    (subfiber : Finset α) (parents : Finset ι)
    (parent : ι → Finset α) (anchor : ι) (hanchor : anchor ∈ parents) :
    (subfiber ∩ parent anchor).card +
        (parents.erase anchor).sup (fun i =>
          ((subfiber \ parent anchor) ∩ parent i).card) ≤
      (subfiber ∩ parents.biUnion parent).card := by
  classical
  let otherUnion : Finset α := (parents.erase anchor).biUnion parent
  have hsup :
      (parents.erase anchor).sup (fun i =>
          ((subfiber \ parent anchor) ∩ parent i).card) ≤
        ((subfiber \ parent anchor) ∩ otherUnion).card := by
    apply Finset.sup_le
    intro i hi
    apply Finset.card_le_card
    intro a ha
    refine Finset.mem_inter.mpr ⟨(Finset.mem_inter.mp ha).1, ?_⟩
    exact Finset.mem_biUnion.mpr ⟨i, hi, (Finset.mem_inter.mp ha).2⟩
  have hdisjoint : Disjoint (subfiber ∩ parent anchor)
      ((subfiber \ parent anchor) ∩ otherUnion) := by
    rw [Finset.disjoint_left]
    intro a haAnchor haOther
    exact (Finset.mem_sdiff.mp (Finset.mem_inter.mp haOther).1).2
      (Finset.mem_inter.mp haAnchor).2
  have hunionSubset :
      (subfiber ∩ parent anchor) ∪
          ((subfiber \ parent anchor) ∩ otherUnion) ⊆
        subfiber ∩ parents.biUnion parent := by
    intro a ha
    rcases Finset.mem_union.mp ha with haAnchor | haOther
    · refine Finset.mem_inter.mpr ⟨(Finset.mem_inter.mp haAnchor).1, ?_⟩
      exact Finset.mem_biUnion.mpr
        ⟨anchor, hanchor, (Finset.mem_inter.mp haAnchor).2⟩
    · refine Finset.mem_inter.mpr
        ⟨(Finset.mem_sdiff.mp (Finset.mem_inter.mp haOther).1).1, ?_⟩
      obtain ⟨i, hi, hai⟩ :=
        Finset.mem_biUnion.mp (Finset.mem_inter.mp haOther).2
      exact Finset.mem_biUnion.mpr
        ⟨i, Finset.mem_of_mem_erase hi, hai⟩
  calc
    (subfiber ∩ parent anchor).card +
        (parents.erase anchor).sup (fun i =>
          ((subfiber \ parent anchor) ∩ parent i).card)
        ≤ (subfiber ∩ parent anchor).card +
            ((subfiber \ parent anchor) ∩ otherUnion).card :=
      Nat.add_le_add_left hsup _
    _ = ((subfiber ∩ parent anchor) ∪
          ((subfiber \ parent anchor) ∩ otherUnion)).card := by
      symm
      exact Finset.card_union_of_disjoint hdisjoint
    _ ≤ (subfiber ∩ parents.biUnion parent).card :=
      Finset.card_le_card hunionSubset

/-- For a fixed anchor, the two-level credit is bounded by the child's true
intersection with the union of every parent. -/
theorem anchoredSubfiberCredit_le_card_inter_biUnion
    {α κ ι ν : Type*} [DecidableEq α] [DecidableEq ι]
    (child : Finset α) (fiberIndices : Finset κ)
    (fibers : κ → Finset α) (subfiberIndices : κ → Finset ν)
    (subfibers : κ → ν → Finset α) (parents : Finset ι)
    (parent : ι → Finset α) (anchor : ι) (hanchor : anchor ∈ parents)
    (hfiberDecomp : fiberIndices.biUnion fibers = child)
    (hfiberDisjoint : ∀ x ∈ fiberIndices, ∀ z ∈ fiberIndices, x ≠ z →
      Disjoint (fibers x) (fibers z))
    (hsubfiberDecomp : ∀ x ∈ fiberIndices,
      (subfiberIndices x).biUnion (subfibers x) = fibers x)
    (hsubfiberDisjoint : ∀ x ∈ fiberIndices,
      ∀ y ∈ subfiberIndices x, ∀ z ∈ subfiberIndices x, y ≠ z →
        Disjoint (subfibers x y) (subfibers x z)) :
    anchoredSubfiberCredit fiberIndices subfiberIndices subfibers
        parents parent anchor ≤
      (child ∩ parents.biUnion parent).card := by
  classical
  let parentUnion : Finset α := parents.biUnion parent
  have hperFiber : ∀ x ∈ fiberIndices,
      (∑ y ∈ subfiberIndices x,
        (((subfibers x y) ∩ parent anchor).card +
          (parents.erase anchor).sup (fun i =>
            (((subfibers x y) \ parent anchor) ∩ parent i).card))) ≤
        (fibers x ∩ parentUnion).card := by
    intro x hx
    calc
      (∑ y ∈ subfiberIndices x,
          (((subfibers x y) ∩ parent anchor).card +
            (parents.erase anchor).sup (fun i =>
              (((subfibers x y) \ parent anchor) ∩ parent i).card)))
          ≤ ∑ y ∈ subfiberIndices x,
              (subfibers x y ∩ parentUnion).card :=
        Finset.sum_le_sum fun y _ =>
          subfiber_anchor_add_sup_le_card_inter_biUnion
            (subfibers x y) parents parent anchor hanchor
      _ = ((subfiberIndices x).biUnion
            (fun y => subfibers x y ∩ parentUnion)).card := by
        symm
        apply card_biUnion_eq_sum_card_of_pairwise_disjoint
        intro y hy z hz hyz
        exact (hsubfiberDisjoint x hx y hy z hz hyz).mono
          Finset.inter_subset_left Finset.inter_subset_left
      _ = (fibers x ∩ parentUnion).card := by
        congr 1
        ext a
        simp only [Finset.mem_biUnion, Finset.mem_inter]
        constructor
        · rintro ⟨y, hy, hay, haParent⟩
          refine ⟨?_, haParent⟩
          rw [← hsubfiberDecomp x hx]
          exact Finset.mem_biUnion.mpr ⟨y, hy, hay⟩
        · rintro ⟨haFiber, haParent⟩
          rw [← hsubfiberDecomp x hx] at haFiber
          obtain ⟨y, hy, hay⟩ := Finset.mem_biUnion.mp haFiber
          exact ⟨y, hy, hay, haParent⟩
  have hinterFiberDisjoint :
      ∀ x ∈ fiberIndices, ∀ z ∈ fiberIndices, x ≠ z →
        Disjoint (fibers x ∩ parentUnion) (fibers z ∩ parentUnion) := by
    intro x hx z hz hxz
    exact (hfiberDisjoint x hx z hz hxz).mono
      Finset.inter_subset_left Finset.inter_subset_left
  calc
    anchoredSubfiberCredit fiberIndices subfiberIndices subfibers
        parents parent anchor =
      ∑ x ∈ fiberIndices, ∑ y ∈ subfiberIndices x,
        (((subfibers x y) ∩ parent anchor).card +
          (parents.erase anchor).sup (fun i =>
            (((subfibers x y) \ parent anchor) ∩ parent i).card)) := rfl
    _ ≤ ∑ x ∈ fiberIndices, (fibers x ∩ parentUnion).card :=
      Finset.sum_le_sum hperFiber
    _ = (fiberIndices.biUnion fun x => fibers x ∩ parentUnion).card := by
      symm
      exact card_biUnion_eq_sum_card_of_pairwise_disjoint fiberIndices
        (fun x => fibers x ∩ parentUnion) hinterFiberDisjoint
    _ = (child ∩ parents.biUnion parent).card := by
      congr 1
      ext a
      simp only [Finset.mem_biUnion, Finset.mem_inter]
      constructor
      · rintro ⟨x, hx, hax, haParent⟩
        refine ⟨?_, by simpa [parentUnion] using haParent⟩
        rw [← hfiberDecomp]
        exact Finset.mem_biUnion.mpr ⟨x, hx, hax⟩
      · rintro ⟨haChild, haParent⟩
        rw [← hfiberDecomp] at haChild
        obtain ⟨x, hx, hax⟩ := Finset.mem_biUnion.mp haChild
        exact ⟨x, hx, hax, by simpa [parentUnion] using haParent⟩

/-- Maximizing the anchored construction over anchors remains bounded by the
true overlap with the parent union. -/
theorem twoLevelFiberCredit_le_card_inter_biUnion
    {α κ ι ν : Type*} [DecidableEq α] [DecidableEq ι]
    (child : Finset α) (fiberIndices : Finset κ)
    (fibers : κ → Finset α)
    (subfiberIndices : ι → κ → Finset ν)
    (subfibers : ι → κ → ν → Finset α)
    (parents : Finset ι) (parent : ι → Finset α)
    (hfiberDecomp : fiberIndices.biUnion fibers = child)
    (hfiberDisjoint : ∀ x ∈ fiberIndices, ∀ z ∈ fiberIndices, x ≠ z →
      Disjoint (fibers x) (fibers z))
    (hsubfiberDecomp : ∀ anchor ∈ parents, ∀ x ∈ fiberIndices,
      (subfiberIndices anchor x).biUnion (subfibers anchor x) = fibers x)
    (hsubfiberDisjoint : ∀ anchor ∈ parents, ∀ x ∈ fiberIndices,
      ∀ y ∈ subfiberIndices anchor x, ∀ z ∈ subfiberIndices anchor x,
        y ≠ z → Disjoint (subfibers anchor x y) (subfibers anchor x z)) :
    twoLevelFiberCredit fiberIndices subfiberIndices subfibers parents parent ≤
      (child ∩ parents.biUnion parent).card := by
  classical
  apply Finset.sup_le
  intro anchor hanchor
  exact anchoredSubfiberCredit_le_card_inter_biUnion child fiberIndices fibers
    (subfiberIndices anchor) (subfibers anchor) parents parent anchor hanchor
    hfiberDecomp hfiberDisjoint (hsubfiberDecomp anchor hanchor)
    (hsubfiberDisjoint anchor hanchor)

/-- One subfiber's two-level contribution dominates its intersection with any
single parent. -/
private theorem card_inter_parent_le_subfiber_anchor_add_sup
    {α ι : Type*} [DecidableEq α] [DecidableEq ι]
    (subfiber : Finset α) (parents : Finset ι) (parent : ι → Finset α)
    (anchor p : ι) (hp : p ∈ parents) :
    (subfiber ∩ parent p).card ≤
      (subfiber ∩ parent anchor).card +
        (parents.erase anchor).sup (fun i =>
          ((subfiber \ parent anchor) ∩ parent i).card) := by
  classical
  by_cases hpa : p = anchor
  · subst p
    exact Nat.le_add_right _ _
  · let outsidePart := (subfiber \ parent anchor) ∩ parent p
    have hsubset : subfiber ∩ parent p ⊆
        (subfiber ∩ parent anchor) ∪ outsidePart := by
      intro a ha
      by_cases haAnchor : a ∈ parent anchor
      · exact Finset.mem_union_left _
          (Finset.mem_inter.mpr ⟨(Finset.mem_inter.mp ha).1, haAnchor⟩)
      · exact Finset.mem_union_right _ (Finset.mem_inter.mpr
          ⟨Finset.mem_sdiff.mpr ⟨(Finset.mem_inter.mp ha).1, haAnchor⟩,
            (Finset.mem_inter.mp ha).2⟩)
    have hdisjoint : Disjoint (subfiber ∩ parent anchor) outsidePart := by
      rw [Finset.disjoint_left]
      intro a haAnchor haOutside
      exact (Finset.mem_sdiff.mp (Finset.mem_inter.mp haOutside).1).2
        (Finset.mem_inter.mp haAnchor).2
    calc
      (subfiber ∩ parent p).card ≤
          ((subfiber ∩ parent anchor) ∪ outsidePart).card :=
        Finset.card_le_card hsubset
      _ = (subfiber ∩ parent anchor).card + outsidePart.card :=
        Finset.card_union_of_disjoint hdisjoint
      _ ≤ (subfiber ∩ parent anchor).card +
          (parents.erase anchor).sup (fun i =>
            ((subfiber \ parent anchor) ∩ parent i).card) := by
        apply Nat.add_le_add_left
        exact Finset.le_sup
          (f := fun i => ((subfiber \ parent anchor) ∩ parent i).card)
          (Finset.mem_erase.mpr ⟨hpa, hp⟩)

/-- For every chosen anchor, its two-level subfiber credit dominates the
one-level maximum-parent credit on the same child fibers. -/
theorem fiberCredit_le_anchoredSubfiberCredit
    {α κ ι ν : Type*} [DecidableEq α] [DecidableEq ι]
    (fiberIndices : Finset κ) (fibers : κ → Finset α)
    (subfiberIndices : κ → Finset ν) (subfibers : κ → ν → Finset α)
    (parents : Finset ι) (parent : ι → Finset α) (anchor : ι)
    (hsubfiberDecomp : ∀ x ∈ fiberIndices,
      (subfiberIndices x).biUnion (subfibers x) = fibers x)
    (hsubfiberDisjoint : ∀ x ∈ fiberIndices,
      ∀ y ∈ subfiberIndices x, ∀ z ∈ subfiberIndices x, y ≠ z →
        Disjoint (subfibers x y) (subfibers x z)) :
    fiberCredit fiberIndices fibers parents parent ≤
      anchoredSubfiberCredit fiberIndices subfiberIndices subfibers
        parents parent anchor := by
  classical
  change (∑ x ∈ fiberIndices,
      parents.sup fun p => (fibers x ∩ parent p).card) ≤
    ∑ x ∈ fiberIndices, ∑ y ∈ subfiberIndices x,
      (((subfibers x y) ∩ parent anchor).card +
        (parents.erase anchor).sup fun i =>
          (((subfibers x y) \ parent anchor) ∩ parent i).card)
  apply Finset.sum_le_sum
  intro x hx
  apply Finset.sup_le
  intro p hp
  have hunionInter :
      (subfiberIndices x).biUnion (fun y => subfibers x y ∩ parent p) =
        fibers x ∩ parent p := by
    ext a
    simp only [Finset.mem_biUnion, Finset.mem_inter]
    constructor
    · rintro ⟨y, hy, hay, hap⟩
      refine ⟨?_, hap⟩
      rw [← hsubfiberDecomp x hx]
      exact Finset.mem_biUnion.mpr ⟨y, hy, hay⟩
    · rintro ⟨haFiber, hap⟩
      rw [← hsubfiberDecomp x hx] at haFiber
      obtain ⟨y, hy, hay⟩ := Finset.mem_biUnion.mp haFiber
      exact ⟨y, hy, hay, hap⟩
  calc
    (fibers x ∩ parent p).card =
        ∑ y ∈ subfiberIndices x, (subfibers x y ∩ parent p).card := by
      rw [← congrArg Finset.card hunionInter]
      exact card_biUnion_eq_sum_card_of_pairwise_disjoint
        (subfiberIndices x) (fun y => subfibers x y ∩ parent p)
        (fun y hy z hz hyz =>
          (hsubfiberDisjoint x hx y hy z hz hyz).mono
            Finset.inter_subset_left Finset.inter_subset_left)
    _ ≤ ∑ y ∈ subfiberIndices x,
        (((subfibers x y) ∩ parent anchor).card +
          (parents.erase anchor).sup (fun i =>
            (((subfibers x y) \ parent anchor) ∩ parent i).card)) :=
      Finset.sum_le_sum fun y _ =>
        card_inter_parent_le_subfiber_anchor_add_sup
          (subfibers x y) parents parent anchor p hp

/-- The maximized two-level credit dominates the original one-level credit.
When there are parents, the proof may choose any anchor; when there are none,
both suprema are zero. -/
theorem fiberCredit_le_twoLevelFiberCredit
    {α κ ι ν : Type*} [DecidableEq α] [DecidableEq ι]
    (fiberIndices : Finset κ) (fibers : κ → Finset α)
    (subfiberIndices : ι → κ → Finset ν)
    (subfibers : ι → κ → ν → Finset α)
    (parents : Finset ι) (parent : ι → Finset α)
    (hsubfiberDecomp : ∀ anchor ∈ parents, ∀ x ∈ fiberIndices,
      (subfiberIndices anchor x).biUnion (subfibers anchor x) = fibers x)
    (hsubfiberDisjoint : ∀ anchor ∈ parents, ∀ x ∈ fiberIndices,
      ∀ y ∈ subfiberIndices anchor x, ∀ z ∈ subfiberIndices anchor x,
        y ≠ z → Disjoint (subfibers anchor x y) (subfibers anchor x z)) :
    fiberCredit fiberIndices fibers parents parent ≤
      twoLevelFiberCredit fiberIndices subfiberIndices subfibers parents parent := by
  classical
  by_cases hparents : parents.Nonempty
  · obtain ⟨anchor, hanchor⟩ := hparents
    exact (fiberCredit_le_anchoredSubfiberCredit fiberIndices fibers
      (subfiberIndices anchor) (subfibers anchor) parents parent anchor
      (hsubfiberDecomp anchor hanchor)
      (hsubfiberDisjoint anchor hanchor)).trans
        (by
          change anchoredSubfiberCredit fiberIndices
              (subfiberIndices anchor) (subfibers anchor) parents parent anchor ≤
            parents.sup (fun a => anchoredSubfiberCredit fiberIndices
              (subfiberIndices a) (subfibers a) parents parent a)
          exact Finset.le_sup
            (f := fun a => anchoredSubfiberCredit fiberIndices
              (subfiberIndices a) (subfibers a) parents parent a) hanchor)
  · have hparentsEmpty : parents = ∅ := Finset.not_nonempty_iff_eq_empty.mp hparents
    simp [hparentsEmpty, fiberCredit, twoLevelFiberCredit]

/-- The complete two-level comparison in one statement: the new credit
dominates the one-level maximum-parent credit and is bounded by the child's
actual overlap with the parent union. -/
theorem fiberCredit_le_twoLevelFiberCredit_le_card_inter_biUnion
    {α κ ι ν : Type*} [DecidableEq α] [DecidableEq ι]
    (child : Finset α) (fiberIndices : Finset κ)
    (fibers : κ → Finset α)
    (subfiberIndices : ι → κ → Finset ν)
    (subfibers : ι → κ → ν → Finset α)
    (parents : Finset ι) (parent : ι → Finset α)
    (hfiberDecomp : fiberIndices.biUnion fibers = child)
    (hfiberDisjoint : ∀ x ∈ fiberIndices, ∀ z ∈ fiberIndices, x ≠ z →
      Disjoint (fibers x) (fibers z))
    (hsubfiberDecomp : ∀ anchor ∈ parents, ∀ x ∈ fiberIndices,
      (subfiberIndices anchor x).biUnion (subfibers anchor x) = fibers x)
    (hsubfiberDisjoint : ∀ anchor ∈ parents, ∀ x ∈ fiberIndices,
      ∀ y ∈ subfiberIndices anchor x, ∀ z ∈ subfiberIndices anchor x,
        y ≠ z → Disjoint (subfibers anchor x y) (subfibers anchor x z)) :
    fiberCredit fiberIndices fibers parents parent ≤
        twoLevelFiberCredit fiberIndices subfiberIndices subfibers parents parent ∧
      twoLevelFiberCredit fiberIndices subfiberIndices subfibers parents parent ≤
        (child ∩ parents.biUnion parent).card := by
  exact ⟨fiberCredit_le_twoLevelFiberCredit fiberIndices fibers
      subfiberIndices subfibers parents parent hsubfiberDecomp
      hsubfiberDisjoint,
    twoLevelFiberCredit_le_card_inter_biUnion child fiberIndices fibers
      subfiberIndices subfibers parents parent hfiberDecomp hfiberDisjoint
      hsubfiberDecomp hsubfiberDisjoint⟩

/-! ## Monotonicity and bounded-anchor costs

The two-level construction is monotone when more parents are made available.
This is the finite bookkeeping needed for bounded front-loaded anchor sets:
adding a new anchor can only improve every remaining child's credit, while
soundness pays for the increase of the prefix union by removing the new
anchor's former tail cost.
-/

/-- A fixed anchor's credit cannot decrease when its available parent set is
enlarged.  The fiber/subfiber data are unchanged; only the supremum over
non-anchor parents grows. -/
theorem anchoredSubfiberCredit_mono_parents
    {α κ ι ν : Type*} [DecidableEq α] [DecidableEq ι]
    (fiberIndices : Finset κ) (subfiberIndices : κ → Finset ν)
    (subfibers : κ → ν → Finset α) (parents parents' : Finset ι)
    (parent : ι → Finset α) (anchor : ι)
    (hparents : parents ⊆ parents') :
    anchoredSubfiberCredit fiberIndices subfiberIndices subfibers
        parents parent anchor ≤
      anchoredSubfiberCredit fiberIndices subfiberIndices subfibers
        parents' parent anchor := by
  classical
  apply Finset.sum_le_sum
  intro x hx
  apply Finset.sum_le_sum
  intro y hy
  apply Nat.add_le_add_left
  apply Finset.sup_le
  intro i hi
  exact Finset.le_sup
    (f := fun i => (((subfibers x y) \ parent anchor) ∩ parent i).card)
    (Finset.mem_erase.mpr
      ⟨(Finset.mem_erase.mp hi).1, hparents (Finset.mem_erase.mp hi).2⟩)

/-- Maximized two-level credit is monotone under enlargement of the parent
set.  This theorem has no cardinality restriction on the parent sets. -/
theorem twoLevelFiberCredit_mono_parents
    {α κ ι ν : Type*} [DecidableEq α] [DecidableEq ι]
    (fiberIndices : Finset κ)
    (subfiberIndices : ι → κ → Finset ν)
    (subfibers : ι → κ → ν → Finset α)
    (parents parents' : Finset ι) (parent : ι → Finset α)
    (hparents : parents ⊆ parents') :
    twoLevelFiberCredit fiberIndices subfiberIndices subfibers parents parent ≤
      twoLevelFiberCredit fiberIndices subfiberIndices subfibers parents' parent := by
  classical
  apply Finset.sup_le
  intro anchor hanchor
  exact (anchoredSubfiberCredit_mono_parents fiberIndices
    (subfiberIndices anchor) (subfibers anchor) parents parents' parent anchor
    hparents).trans (Finset.le_sup
      (f := fun a => anchoredSubfiberCredit fiberIndices
        (subfiberIndices a) (subfibers a) parents' parent a)
      (hparents hanchor))

/-- Abstract total cost of a front-loaded anchor set.  Anchors pay their
literal union cardinality.  Every selected non-anchor pays its cardinality
minus a certified overlap credit against the anchors. -/
def boundedAnchorCost
    {α ι : Type*} [DecidableEq α] [DecidableEq ι]
    (indices : Finset ι) (sets : ι → Finset α)
    (credit : ι → Finset ι → ℕ) (anchors : Finset ι) : ℕ :=
  (anchors.biUnion sets).card +
    (indices \ anchors).sum (fun i => (sets i).card - credit i anchors)

/-- Adding an anchor does not increase the abstract bounded-anchor cost,
provided (1) every remaining child's credit is monotone and (2) the new
anchor's old credit is sound for its true overlap with the old anchor union.

The proof is exact finite-set bookkeeping.  In particular, it does not use a
bound such as `|anchors ∪ {q}| ≤ 3`; that restriction belongs only to a later
uniform existence problem. -/
theorem boundedAnchorCost_insert_le
    {α ι : Type*} [DecidableEq α] [DecidableEq ι]
    (indices : Finset ι) (sets : ι → Finset α)
    (credit : ι → Finset ι → ℕ) (anchors : Finset ι) (q : ι)
    (hqIndices : q ∈ indices) (hqAnchors : q ∉ anchors)
    (hmono : ∀ i ∈ (indices \ insert q anchors),
      credit i anchors ≤ credit i (insert q anchors))
    (hsound : credit q anchors ≤
      (sets q ∩ anchors.biUnion sets).card) :
    boundedAnchorCost indices sets credit (insert q anchors) ≤
      boundedAnchorCost indices sets credit anchors := by
  classical
  let oldUnion := anchors.biUnion sets
  let remaining := indices \ insert q anchors
  have hsdiff : indices \ anchors = insert q remaining := by
    ext i
    by_cases hiq : i = q
    · subst i
      simp [remaining, hqIndices, hqAnchors]
    · simp [remaining, hiq]
  have hqRemaining : q ∉ remaining := by
    simp [remaining]
  have htail :
      remaining.sum (fun i =>
          (sets i).card - credit i (insert q anchors)) ≤
        remaining.sum (fun i => (sets i).card - credit i anchors) := by
    apply Finset.sum_le_sum
    intro i hi
    have hcredit := hmono i hi
    omega
  have hsoundSet : credit q anchors ≤ (sets q).card :=
    hsound.trans (Finset.card_le_card Finset.inter_subset_left)
  have hunionCard :
      ((insert q anchors).biUnion sets).card +
          (sets q ∩ oldUnion).card =
        (sets q).card + oldUnion.card := by
    rw [Finset.biUnion_insert]
    simpa [oldUnion, Finset.inter_comm] using
      Finset.card_union_add_card_inter (sets q) oldUnion
  have hsound' : credit q anchors ≤ (sets q ∩ oldUnion).card := by
    simpa [oldUnion] using hsound
  have hprefix :
      ((insert q anchors).biUnion sets).card ≤
        oldUnion.card + ((sets q).card - credit q anchors) := by
    omega
  change
    ((insert q anchors).biUnion sets).card +
        remaining.sum (fun i =>
          (sets i).card - credit i (insert q anchors)) ≤
      oldUnion.card +
        (indices \ anchors).sum
          (fun i => (sets i).card - credit i anchors)
  rw [hsdiff, Finset.sum_insert hqRemaining]
  calc
    ((insert q anchors).biUnion sets).card +
        remaining.sum (fun i =>
          (sets i).card - credit i (insert q anchors)) ≤
      ((insert q anchors).biUnion sets).card +
        remaining.sum (fun i => (sets i).card - credit i anchors) :=
      Nat.add_le_add_left htail _
    _ ≤ (oldUnion.card + ((sets q).card - credit q anchors)) +
        remaining.sum (fun i => (sets i).card - credit i anchors) :=
      Nat.add_le_add_right hprefix _
    _ = oldUnion.card +
        ((sets q).card - credit q anchors +
          remaining.sum (fun i => (sets i).card - credit i anchors)) := by
      omega

/-! ## Ordered-union certificates

The preceding soundness theorem is local to one child.  The next results
compose those local certificates along an ordering.  We deliberately allow
each child to retain only a selected subset of its earlier parents.  This is
the interface needed by front-loaded-anchor arguments: omitting a predecessor
can weaken the numerical credit, but cannot make the resulting union bound
unsound.
-/

/-- Additive ordered-union bound from two-level credits computed against an
arbitrary selected subset of the earlier sets.

All fiber and subfiber decompositions are explicit.  No modular-arithmetic or
uniformity hypothesis is hidden in this finite statement. -/
theorem card_initialFinsetUnion_le_sum_card_sub_twoLevelFiberCredit_of_parent_subset
    {α κ ν : Type*} [DecidableEq α]
    (sets : ℕ → Finset α) (fiberIndices : ℕ → Finset κ)
    (fibers : ℕ → κ → Finset α)
    (subfiberIndices : ℕ → ℕ → κ → Finset ν)
    (subfibers : ℕ → ℕ → κ → ν → Finset α)
    (parents : ℕ → Finset ℕ) (m : ℕ)
    (hparents : ∀ k < m, parents k ⊆ Finset.range k)
    (hfiberDecomp : ∀ k < m,
      (fiberIndices k).biUnion (fibers k) = sets k)
    (hfiberDisjoint : ∀ k < m,
      ∀ x ∈ fiberIndices k, ∀ z ∈ fiberIndices k, x ≠ z →
        Disjoint (fibers k x) (fibers k z))
    (hsubfiberDecomp : ∀ k < m, ∀ anchor ∈ parents k,
      ∀ x ∈ fiberIndices k,
        (subfiberIndices k anchor x).biUnion
          (subfibers k anchor x) = fibers k x)
    (hsubfiberDisjoint : ∀ k < m, ∀ anchor ∈ parents k,
      ∀ x ∈ fiberIndices k,
      ∀ y ∈ subfiberIndices k anchor x,
      ∀ z ∈ subfiberIndices k anchor x, y ≠ z →
        Disjoint (subfibers k anchor x y) (subfibers k anchor x z)) :
    (initialFinsetUnion sets m).card ≤
      ∑ k ∈ Finset.range m,
        ((sets k).card - twoLevelFiberCredit (fiberIndices k)
          (subfiberIndices k) (subfibers k) (parents k) sets) := by
  classical
  apply card_initialFinsetUnion_le_sum_card_sub_credit
  intro k hk
  have hlocal :
      twoLevelFiberCredit (fiberIndices k) (subfiberIndices k)
          (subfibers k) (parents k) sets ≤
        (sets k ∩ (parents k).biUnion sets).card :=
    twoLevelFiberCredit_le_card_inter_biUnion
      (sets k) (fiberIndices k) (fibers k)
      (subfiberIndices k) (subfibers k) (parents k) sets
      (hfiberDecomp k hk) (hfiberDisjoint k hk)
      (hsubfiberDecomp k hk) (hsubfiberDisjoint k hk)
  refine hlocal.trans (Finset.card_le_card ?_)
  intro a ha
  refine Finset.mem_inter.mpr ⟨(Finset.mem_inter.mp ha).1, ?_⟩
  obtain ⟨i, hi, hai⟩ := Finset.mem_biUnion.mp (Finset.mem_inter.mp ha).2
  exact Finset.mem_biUnion.mpr ⟨i, hparents k hk hi, hai⟩

/-- The ordered-union bound when every earlier set is retained as a parent. -/
theorem card_initialFinsetUnion_le_sum_card_sub_twoLevelFiberCredit
    {α κ ν : Type*} [DecidableEq α]
    (sets : ℕ → Finset α) (fiberIndices : ℕ → Finset κ)
    (fibers : ℕ → κ → Finset α)
    (subfiberIndices : ℕ → ℕ → κ → Finset ν)
    (subfibers : ℕ → ℕ → κ → ν → Finset α) (m : ℕ)
    (hfiberDecomp : ∀ k < m,
      (fiberIndices k).biUnion (fibers k) = sets k)
    (hfiberDisjoint : ∀ k < m,
      ∀ x ∈ fiberIndices k, ∀ z ∈ fiberIndices k, x ≠ z →
        Disjoint (fibers k x) (fibers k z))
    (hsubfiberDecomp : ∀ k < m, ∀ anchor ∈ Finset.range k,
      ∀ x ∈ fiberIndices k,
        (subfiberIndices k anchor x).biUnion
          (subfibers k anchor x) = fibers k x)
    (hsubfiberDisjoint : ∀ k < m, ∀ anchor ∈ Finset.range k,
      ∀ x ∈ fiberIndices k,
      ∀ y ∈ subfiberIndices k anchor x,
      ∀ z ∈ subfiberIndices k anchor x, y ≠ z →
        Disjoint (subfibers k anchor x y) (subfibers k anchor x z)) :
    (initialFinsetUnion sets m).card ≤
      ∑ k ∈ Finset.range m,
        ((sets k).card - twoLevelFiberCredit (fiberIndices k)
          (subfiberIndices k) (subfibers k) (Finset.range k) sets) := by
  exact card_initialFinsetUnion_le_sum_card_sub_twoLevelFiberCredit_of_parent_subset
    sets fiberIndices fibers subfiberIndices subfibers
    (fun k => Finset.range k) m (fun _ _ => Finset.Subset.rfl)
    hfiberDecomp hfiberDisjoint hsubfiberDecomp hsubfiberDisjoint

/-- Sharp avoidance criterion for selected-parent two-level credits.  In
particular, later children may ignore any non-anchor predecessors, provided
the retained parent indices are still earlier in the ordering. -/
theorem exists_mem_avoiding_of_twoLevelFiberCredit_sum_lt_card_of_parent_subset
    {α κ ν : Type*} [DecidableEq α]
    (candidate : Finset α) (sets : ℕ → Finset α)
    (fiberIndices : ℕ → Finset κ) (fibers : ℕ → κ → Finset α)
    (subfiberIndices : ℕ → ℕ → κ → Finset ν)
    (subfibers : ℕ → ℕ → κ → ν → Finset α)
    (parents : ℕ → Finset ℕ) (m : ℕ)
    (hparents : ∀ k < m, parents k ⊆ Finset.range k)
    (hfiberDecomp : ∀ k < m,
      (fiberIndices k).biUnion (fibers k) = sets k)
    (hfiberDisjoint : ∀ k < m,
      ∀ x ∈ fiberIndices k, ∀ z ∈ fiberIndices k, x ≠ z →
        Disjoint (fibers k x) (fibers k z))
    (hsubfiberDecomp : ∀ k < m, ∀ anchor ∈ parents k,
      ∀ x ∈ fiberIndices k,
        (subfiberIndices k anchor x).biUnion
          (subfibers k anchor x) = fibers k x)
    (hsubfiberDisjoint : ∀ k < m, ∀ anchor ∈ parents k,
      ∀ x ∈ fiberIndices k,
      ∀ y ∈ subfiberIndices k anchor x,
      ∀ z ∈ subfiberIndices k anchor x, y ≠ z →
        Disjoint (subfibers k anchor x y) (subfibers k anchor x z))
    (hcard : (∑ k ∈ Finset.range m,
      ((sets k).card - twoLevelFiberCredit (fiberIndices k)
        (subfiberIndices k) (subfibers k) (parents k) sets)) <
      candidate.card) :
    ∃ a ∈ candidate, ∀ k < m, a ∉ sets k := by
  classical
  have hunionCard : (initialFinsetUnion sets m).card < candidate.card :=
    (card_initialFinsetUnion_le_sum_card_sub_twoLevelFiberCredit_of_parent_subset
      sets fiberIndices fibers subfiberIndices subfibers parents m hparents
      hfiberDecomp hfiberDisjoint hsubfiberDecomp
      hsubfiberDisjoint).trans_lt hcard
  by_contra havoid
  have hsubset : candidate ⊆ initialFinsetUnion sets m := by
    intro a haCandidate
    by_contra haUnion
    apply havoid
    refine ⟨a, haCandidate, ?_⟩
    intro k hk hak
    exact haUnion (Finset.mem_biUnion.mpr
      ⟨k, Finset.mem_range.mpr hk, hak⟩)
  exact (Nat.not_lt_of_ge (Finset.card_le_card hsubset)) hunionCard

/-- Sharp avoidance criterion using every earlier set as a parent. -/
theorem exists_mem_avoiding_of_twoLevelFiberCredit_sum_lt_card
    {α κ ν : Type*} [DecidableEq α]
    (candidate : Finset α) (sets : ℕ → Finset α)
    (fiberIndices : ℕ → Finset κ) (fibers : ℕ → κ → Finset α)
    (subfiberIndices : ℕ → ℕ → κ → Finset ν)
    (subfibers : ℕ → ℕ → κ → ν → Finset α) (m : ℕ)
    (hfiberDecomp : ∀ k < m,
      (fiberIndices k).biUnion (fibers k) = sets k)
    (hfiberDisjoint : ∀ k < m,
      ∀ x ∈ fiberIndices k, ∀ z ∈ fiberIndices k, x ≠ z →
        Disjoint (fibers k x) (fibers k z))
    (hsubfiberDecomp : ∀ k < m, ∀ anchor ∈ Finset.range k,
      ∀ x ∈ fiberIndices k,
        (subfiberIndices k anchor x).biUnion
          (subfibers k anchor x) = fibers k x)
    (hsubfiberDisjoint : ∀ k < m, ∀ anchor ∈ Finset.range k,
      ∀ x ∈ fiberIndices k,
      ∀ y ∈ subfiberIndices k anchor x,
      ∀ z ∈ subfiberIndices k anchor x, y ≠ z →
        Disjoint (subfibers k anchor x y) (subfibers k anchor x z))
    (hcard : (∑ k ∈ Finset.range m,
      ((sets k).card - twoLevelFiberCredit (fiberIndices k)
        (subfiberIndices k) (subfibers k) (Finset.range k) sets)) <
      candidate.card) :
    ∃ a ∈ candidate, ∀ k < m, a ∉ sets k := by
  exact exists_mem_avoiding_of_twoLevelFiberCredit_sum_lt_card_of_parent_subset
    candidate sets fiberIndices fibers subfiberIndices subfibers
    (fun k => Finset.range k) m (fun _ _ => Finset.Subset.rfl)
    hfiberDecomp hfiberDisjoint hsubfiberDecomp hsubfiberDisjoint hcard

/-- In the modularly saturated case, an anchor-target subfiber is either
entirely inside the anchor or disjoint from it.  The robust contribution then
simplifies to “full subfiber cardinality” in the first case and “best
non-anchor intersection” in the second. -/
theorem subfiber_anchor_add_sup_eq_if_of_saturated
    {α ι : Type*} [DecidableEq α] [DecidableEq ι]
    (subfiber : Finset α) (parents : Finset ι) (parent : ι → Finset α)
    (anchor : ι)
    (hsaturated : subfiber ⊆ parent anchor ∨
      Disjoint subfiber (parent anchor)) :
    (subfiber ∩ parent anchor).card +
        (parents.erase anchor).sup (fun i =>
          ((subfiber \ parent anchor) ∩ parent i).card) =
      if subfiber ⊆ parent anchor then subfiber.card
      else (parents.erase anchor).sup fun i =>
        (subfiber ∩ parent i).card := by
  classical
  by_cases hcovered : subfiber ⊆ parent anchor
  · simp [hcovered, Finset.inter_eq_left.mpr hcovered,
      Finset.sdiff_eq_empty_iff_subset.mpr hcovered]
  · rcases hsaturated with hsubset | hdisjoint
    · exact (hcovered hsubset).elim
    · have hinter : subfiber ∩ parent anchor = ∅ :=
        Finset.disjoint_iff_inter_eq_empty.mp hdisjoint
      have hsdiff : subfiber \ parent anchor = subfiber := by
        exact Finset.sdiff_eq_self_of_disjoint hdisjoint
      simp [hcovered, hinter, hsdiff]

end LonelyRunner
