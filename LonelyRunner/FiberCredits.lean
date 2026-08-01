import Mathlib.Data.Finset.Card
import Mathlib.Data.Finset.Lattice.Fold
import Mathlib.Data.Finset.Union
import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Algebra.Order.BigOperators.Group.Finset

/-!
# Fiberwise overlap credits

This file isolates the finite combinatorics behind a fiberwise ordered-union
certificate.  A new finite set is partitioned into disjoint fibers.  In each
fiber we credit only its largest intersection with one previously processed
parent.  Because different fibers are disjoint, these local credits cannot
double-count an element.  Their sum is therefore bounded by the new set's
actual intersection with the union of all parents.

The results are deliberately independent of the modular-pivot arithmetic that
will eventually supply the fibers and their exact intersection counts.
-/

namespace LonelyRunner

open scoped BigOperators

/-- Earlier members of a naturally indexed ordered family. -/
def earlierFinsetUnion {α : Type*} [DecidableEq α]
    (sets : ℕ → Finset α) (k : ℕ) : Finset α :=
  (Finset.range k).biUnion sets

/-- The union of the first `m` members of a naturally indexed ordered family. -/
def initialFinsetUnion {α : Type*} [DecidableEq α]
    (sets : ℕ → Finset α) (m : ℕ) : Finset α :=
  (Finset.range m).biUnion sets

/-- The fiberwise credit: in every selected fiber, retain only the largest
intersection cardinality with a selected parent, then sum those maxima.

`Finset.sup` makes the contribution zero when `parents` is empty. -/
def fiberCredit {α κ ι : Type*} [DecidableEq α]
    (fiberIndices : Finset κ) (fibers : κ → Finset α)
    (parents : Finset ι) (parent : ι → Finset α) : ℕ :=
  ∑ x ∈ fiberIndices,
    parents.sup fun i => ((fibers x) ∩ parent i).card

/-- Cardinality is additive over a finite family of pairwise disjoint
finsets.  The explicit hypothesis avoids imposing a global decidable-equality
or `PairwiseDisjoint` interface on the index type. -/
theorem card_biUnion_eq_sum_card_of_pairwise_disjoint
    {α κ : Type*} [DecidableEq α]
    (indices : Finset κ) (pieces : κ → Finset α)
    (hdisjoint : ∀ x ∈ indices, ∀ y ∈ indices, x ≠ y →
      Disjoint (pieces x) (pieces y)) :
    (indices.biUnion pieces).card = ∑ x ∈ indices, (pieces x).card := by
  classical
  induction indices using Finset.induction_on with
  | empty => simp
  | @insert x indices hx ih =>
      have hxDisjoint : Disjoint (pieces x) (indices.biUnion pieces) := by
        rw [Finset.disjoint_left]
        intro a hax haUnion
        obtain ⟨y, hy, hay⟩ := Finset.mem_biUnion.mp haUnion
        have hxy : x ≠ y := by
          intro h
          subst y
          exact hx hy
        exact Finset.disjoint_left.mp
          (hdisjoint x (Finset.mem_insert_self _ _) y
            (Finset.mem_insert_of_mem hy) hxy) hax hay
      rw [Finset.biUnion_insert, Finset.sum_insert hx,
        Finset.card_union_of_disjoint hxDisjoint]
      congr 1
      exact ih fun a ha b hb hab =>
        hdisjoint a (Finset.mem_insert_of_mem ha) b
          (Finset.mem_insert_of_mem hb) hab

/-- The sum of the largest single-parent intersection in each disjoint fiber
is no larger than the child's intersection with the whole parent union. -/
theorem fiberCredit_le_card_inter_biUnion
    {α κ ι : Type*} [DecidableEq α]
    (child : Finset α) (fiberIndices : Finset κ)
    (fibers : κ → Finset α) (parents : Finset ι)
    (parent : ι → Finset α)
    (hdecomp : fiberIndices.biUnion fibers = child)
    (hdisjoint : ∀ x ∈ fiberIndices, ∀ y ∈ fiberIndices, x ≠ y →
      Disjoint (fibers x) (fibers y)) :
    fiberCredit fiberIndices fibers parents parent ≤
      (child ∩ parents.biUnion parent).card := by
  classical
  let parentUnion : Finset α := parents.biUnion parent
  have hpiece : ∀ x ∈ fiberIndices,
      parents.sup (fun i => ((fibers x) ∩ parent i).card) ≤
        ((fibers x) ∩ parentUnion).card := by
    intro x hx
    apply Finset.sup_le
    intro i hi
    apply Finset.card_le_card
    intro a ha
    refine Finset.mem_inter.mpr ⟨(Finset.mem_inter.mp ha).1, ?_⟩
    exact Finset.mem_biUnion.mpr ⟨i, hi, (Finset.mem_inter.mp ha).2⟩
  have hinterDisjoint :
      ∀ x ∈ fiberIndices, ∀ y ∈ fiberIndices, x ≠ y →
        Disjoint (fibers x ∩ parentUnion) (fibers y ∩ parentUnion) := by
    intro x hx y hy hxy
    exact (hdisjoint x hx y hy hxy).mono Finset.inter_subset_left
      Finset.inter_subset_left
  have hunionInter :
      fiberIndices.biUnion (fun x => fibers x ∩ parentUnion) =
        child ∩ parentUnion := by
    ext a
    simp only [Finset.mem_biUnion, Finset.mem_inter]
    constructor
    · rintro ⟨x, hx, hax, haParent⟩
      refine ⟨?_, haParent⟩
      rw [← hdecomp]
      exact Finset.mem_biUnion.mpr ⟨x, hx, hax⟩
    · rintro ⟨haChild, haParent⟩
      rw [← hdecomp] at haChild
      obtain ⟨x, hx, hax⟩ := Finset.mem_biUnion.mp haChild
      exact ⟨x, hx, hax, haParent⟩
  calc
    fiberCredit fiberIndices fibers parents parent =
        ∑ x ∈ fiberIndices,
          parents.sup (fun i => ((fibers x) ∩ parent i).card) := rfl
    _ ≤ ∑ x ∈ fiberIndices, ((fibers x) ∩ parentUnion).card :=
      Finset.sum_le_sum fun x hx => hpiece x hx
    _ = (fiberIndices.biUnion fun x => fibers x ∩ parentUnion).card := by
      symm
      exact card_biUnion_eq_sum_card_of_pairwise_disjoint
        fiberIndices (fun x => fibers x ∩ parentUnion) hinterDisjoint
    _ = (child ∩ parents.biUnion parent).card := by
      simpa [parentUnion] using congrArg Finset.card hunionInter

/-- If `credit k` is bounded by the actual overlap of the `k`th set with all
earlier sets, then the ordered union is bounded by the sum of the net
increments `|B_k| - credit k`. -/
theorem card_initialFinsetUnion_le_sum_card_sub_credit
    {α : Type*} [DecidableEq α]
    (sets : ℕ → Finset α) (credit : ℕ → ℕ) (m : ℕ)
    (hcredit : ∀ k < m, credit k ≤
      (sets k ∩ earlierFinsetUnion sets k).card) :
    (initialFinsetUnion sets m).card ≤
      ∑ k ∈ Finset.range m, ((sets k).card - credit k) := by
  classical
  induction m with
  | zero => simp [initialFinsetUnion]
  | succ m ih =>
      have ih' : (initialFinsetUnion sets m).card ≤
          ∑ k ∈ Finset.range m, ((sets k).card - credit k) :=
        ih fun k hk => hcredit k (Nat.lt_succ_of_lt hk)
      have hc := hcredit m (Nat.lt_succ_self m)
      have hcSet : credit m ≤ (sets m).card :=
        hc.trans (Finset.card_le_card Finset.inter_subset_left)
      have hcardIdentity :
          (initialFinsetUnion sets m ∪ sets m).card +
              (sets m ∩ initialFinsetUnion sets m).card =
            (initialFinsetUnion sets m).card + (sets m).card := by
        simpa [Finset.inter_comm] using
          Finset.card_union_add_card_inter
            (initialFinsetUnion sets m) (sets m)
      have hstep :
          (initialFinsetUnion sets m ∪ sets m).card ≤
            (initialFinsetUnion sets m).card +
              ((sets m).card - credit m) := by
        change credit m ≤
          (sets m ∩ initialFinsetUnion sets m).card at hc
        omega
      rw [Finset.sum_range_succ]
      have hunionSucc : initialFinsetUnion sets (m + 1) =
          initialFinsetUnion sets m ∪ sets m := by
        ext a
        simp only [initialFinsetUnion, Finset.mem_biUnion,
          Finset.mem_range, Finset.mem_union]
        constructor
        · rintro ⟨k, hk, hak⟩
          by_cases hkm : k = m
          · exact Or.inr (hkm ▸ hak)
          · exact Or.inl ⟨k, by omega, hak⟩
        · rintro (⟨k, hk, hak⟩ | ham)
          · exact ⟨k, by omega, hak⟩
          · exact ⟨m, Nat.lt_succ_self m, ham⟩
      rw [hunionSucc]
      exact hstep.trans (Nat.add_le_add_right ih' _)

/-- Specialize the ordered-union bound to credits computed from disjoint
fiber decompositions and the actual earlier sets as parents. -/
theorem card_initialFinsetUnion_le_sum_card_sub_fiberCredit
    {α κ : Type*} [DecidableEq α]
    (sets : ℕ → Finset α) (fiberIndices : ℕ → Finset κ)
    (fibers : ℕ → κ → Finset α) (m : ℕ)
    (hdecomp : ∀ k < m,
      (fiberIndices k).biUnion (fibers k) = sets k)
    (hdisjoint : ∀ k < m, ∀ x ∈ fiberIndices k, ∀ y ∈ fiberIndices k,
      x ≠ y → Disjoint (fibers k x) (fibers k y)) :
    (initialFinsetUnion sets m).card ≤
      ∑ k ∈ Finset.range m,
        ((sets k).card - fiberCredit (fiberIndices k) (fibers k)
          (Finset.range k) sets) := by
  apply card_initialFinsetUnion_le_sum_card_sub_credit
  intro k hk
  exact fiberCredit_le_card_inter_biUnion
    (sets k) (fiberIndices k) (fibers k) (Finset.range k) sets
    (hdecomp k hk) (hdisjoint k hk)

/-- The sharp fiber-credit sum criterion: if the sum of certified net
increments is smaller than the candidate set, some candidate avoids every
one of the first `m` sets. -/
theorem exists_mem_avoiding_of_fiberCredit_sum_lt_card
    {α κ : Type*} [DecidableEq α]
    (candidate : Finset α) (sets : ℕ → Finset α)
    (fiberIndices : ℕ → Finset κ) (fibers : ℕ → κ → Finset α) (m : ℕ)
    (hdecomp : ∀ k < m,
      (fiberIndices k).biUnion (fibers k) = sets k)
    (hdisjoint : ∀ k < m, ∀ x ∈ fiberIndices k, ∀ y ∈ fiberIndices k,
      x ≠ y → Disjoint (fibers k x) (fibers k y))
    (hcard : (∑ k ∈ Finset.range m,
      ((sets k).card - fiberCredit (fiberIndices k) (fibers k)
        (Finset.range k) sets)) < candidate.card) :
    ∃ a ∈ candidate, ∀ k < m, a ∉ sets k := by
  classical
  have hunionCard : (initialFinsetUnion sets m).card < candidate.card :=
    (card_initialFinsetUnion_le_sum_card_sub_fiberCredit
      sets fiberIndices fibers m hdecomp hdisjoint).trans_lt hcard
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

/-- A numerical lemma converting balanced per-step growth into the sharp
sum-of-net-increments bound. -/
theorem sum_card_sub_fiberCredit_le_balanced
    {α κ : Type*} [DecidableEq α]
    (sets : ℕ → Finset α) (fiberIndices : ℕ → Finset κ)
    (fibers : ℕ → κ → Finset α) (m q : ℕ) (hm : 0 < m)
    (hbalanced : ∀ k < m, 0 < k →
      (sets k).card ≤ q + fiberCredit (fiberIndices k) (fibers k)
        (Finset.range k) sets) :
    (∑ k ∈ Finset.range m,
      ((sets k).card - fiberCredit (fiberIndices k) (fibers k)
        (Finset.range k) sets)) ≤
      (sets 0).card + (m - 1) * q := by
  obtain ⟨n, rfl⟩ := Nat.exists_eq_succ_of_ne_zero (Nat.ne_of_gt hm)
  induction n with
  | zero =>
      simp [fiberCredit]
  | succ n ih =>
      rw [Finset.sum_range_succ]
      have ih' :
          (∑ k ∈ Finset.range (n + 1),
            ((sets k).card - fiberCredit (fiberIndices k) (fibers k)
              (Finset.range k) sets)) ≤
            (sets 0).card + n * q := by
        simpa using ih (Nat.succ_pos n) (fun k hk hkpos =>
          hbalanced k (Nat.lt_succ_of_lt hk) hkpos)
      have hlast := hbalanced (n + 1) (Nat.lt_succ_self _) (Nat.succ_pos _)
      have hnet :
          (sets (n + 1)).card -
              fiberCredit (fiberIndices (n + 1)) (fibers (n + 1))
                (Finset.range (n + 1)) sets ≤ q := by
        omega
      calc
        (∑ k ∈ Finset.range (n + 1),
            ((sets k).card - fiberCredit (fiberIndices k) (fibers k)
              (Finset.range k) sets)) +
              ((sets (n + 1)).card -
                fiberCredit (fiberIndices (n + 1)) (fibers (n + 1))
                  (Finset.range (n + 1)) sets)
            ≤ ((sets 0).card + n * q) + q :=
              Nat.add_le_add ih' hnet
        _ = (sets 0).card + (n + 1) * q := by
          simp [Nat.add_mul, Nat.add_assoc]

/-- **Balanced fiberwise ordered-union certificate.**

Suppose the first bad set plus `m - 1` increments of size `q` is smaller than
the candidate set.  If every later bad set has size at most `q` plus its
fiberwise credit against all earlier bad sets, then some candidate avoids all
`m` bad sets. -/
theorem exists_mem_avoiding_of_balanced_fiberCredit
    {α κ : Type*} [DecidableEq α]
    (candidate : Finset α) (sets : ℕ → Finset α)
    (fiberIndices : ℕ → Finset κ) (fibers : ℕ → κ → Finset α)
    (m q : ℕ) (hm : 0 < m)
    (hdecomp : ∀ k < m,
      (fiberIndices k).biUnion (fibers k) = sets k)
    (hdisjoint : ∀ k < m, ∀ x ∈ fiberIndices k, ∀ y ∈ fiberIndices k,
      x ≠ y → Disjoint (fibers k x) (fibers k y))
    (hbalanced : ∀ k < m, 0 < k →
      (sets k).card ≤ q + fiberCredit (fiberIndices k) (fibers k)
        (Finset.range k) sets)
    (hcard : (sets 0).card + (m - 1) * q < candidate.card) :
    ∃ a ∈ candidate, ∀ k < m, a ∉ sets k := by
  apply exists_mem_avoiding_of_fiberCredit_sum_lt_card
    candidate sets fiberIndices fibers m hdecomp hdisjoint
  exact (sum_card_sub_fiberCredit_le_balanced
    sets fiberIndices fibers m q hm hbalanced).trans_lt hcard

end LonelyRunner
