import LonelyRunner.AcyclicFiberSelector
import LonelyRunner.PivotPairFiberCounts
import Mathlib.Data.Fintype.Sort

/-!
# Concrete modular acyclic fiber selectors

This module instantiates `AcyclicFiberSelector.lean` with the strict target
fibers at one fixed modular pivot.  A vertex is a nonpivot runner.  A token is
a child vertex together with one strict target, including targets whose child
fiber is empty.  Its possible parents are the other nonpivot runners, and the
parent weight is exactly the candidate-filtered overlap of the child's target
fiber with the parent's strict bad set.

No positivity or distinct-speed assumption is needed for this finite
combinatorial identification.  Such hypotheses enter only when a modular
certificate is transported to the Lonely Runner statement.  In particular,
the definitions below retain both conventions definitionally:

* `pivotTargetFiber` excludes multiples of `N` through `pivotCandidates`;
* `strictPivotTargets` is the strict cyclic ball, so boundary targets remain
  good rather than bad.
-/

namespace LonelyRunner

open scoped BigOperators

/-- Strict canonical targets for a fixed pivot speed.  This is a named alias
for the target set already used by the exact pair-fiber decomposition. -/
def strictPivotTargets (N pivotSpeed : ℕ) : Finset ℕ :=
  strictCyclicBall (N * pivotSpeed) pivotSpeed

/-- The finite type of runners other than the fixed pivot. -/
abbrev NonpivotVertex {n : ℕ} (pivot : Fin n) :=
  {i : Fin n // i ≠ pivot}

/-- A strict modular fiber token: its owner and one canonical strict target.
Keeping empty fibers as zero-weight tokens makes the type uniform. -/
abbrev ModularFiberToken {n : ℕ} (N : ℕ) (speeds : Fin n → ℕ)
    (pivot : Fin n) :=
  NonpivotVertex pivot ×
    {x : ℕ // x ∈ strictPivotTargets N (speeds pivot)}

/-- The child runner owning a modular fiber token. -/
def modularFiberOwner {n : ℕ} {N : ℕ} {speeds : Fin n → ℕ}
    {pivot : Fin n} (token : ModularFiberToken N speeds pivot) :
    NonpivotVertex pivot :=
  token.1

/-- Every nonpivot runner except the token's own child is an eligible parent. -/
def modularFiberEligible {n : ℕ} {N : ℕ} {speeds : Fin n → ℕ}
    {pivot : Fin n} (parent : NonpivotVertex pivot)
    (token : ModularFiberToken N speeds pivot) : Prop :=
  parent ≠ modularFiberOwner token

/-- Exact candidate-filtered overlap weight offered by a parent to one child
target fiber. -/
def modularFiberWeight {n : ℕ} (N : ℕ) (speeds : Fin n → ℕ)
    (pivot : Fin n) (parent : NonpivotVertex pivot)
    (token : ModularFiberToken N speeds pivot) : ℕ :=
  (pivotTargetFiber N (speeds pivot) (speeds token.1.1) token.2.1 ∩
      pivotBadResidues N (speeds pivot) (speeds parent.1)).card

/-- Nonpivot parents strictly preceding `child` in a vertex order. -/
def modularEarlierParents {n : ℕ} {pivot : Fin n}
    (o : VertexOrder (NonpivotVertex pivot)) (child : NonpivotVertex pivot) :
    Finset (NonpivotVertex pivot) :=
  Finset.univ.filter fun parent => o.key parent < o.key child

/-- The existing `fiberCredit` specialized to one child and the parents that
precede it in an order. -/
def selectedEarlierParentFiberCredit {n : ℕ} (N : ℕ)
    (speeds : Fin n → ℕ) (pivot : Fin n)
    (o : VertexOrder (NonpivotVertex pivot))
    (child : NonpivotVertex pivot) : ℕ :=
  fiberCredit (strictPivotTargets N (speeds pivot))
    (fun target =>
      pivotTargetFiber N (speeds pivot) (speeds child.1) target)
    (modularEarlierParents o child)
    (fun parent => pivotBadResidues N (speeds pivot) (speeds parent.1))

/-- Total selected-earlier-parent fiber credit of an order. -/
def modularOrderFiberCredit {n : ℕ} (N : ℕ)
    (speeds : Fin n → ℕ) (pivot : Fin n)
    (o : VertexOrder (NonpivotVertex pivot)) : ℕ :=
  ∑ child, selectedEarlierParentFiberCredit N speeds pivot o child

/-! ## Enumerating a vertex order by consecutive natural indices -/

/-- The canonical enumeration of a finite `VertexOrder`, in increasing order
of its injective natural-valued keys.  The temporary lifted order is used only
to construct the equivalence; the comparison theorem below states its exact
relationship with the original keys. -/
noncomputable def vertexOrderEquivFin {V : Type*} [Fintype V]
    (o : VertexOrder V) : Fin (Fintype.card V) ≃ V := by
  letI : LinearOrder V := LinearOrder.lift' o.key o.key_injective
  exact (monoEquivOfFin V rfl).toEquiv

/-- The canonical enumeration preserves and reflects strict key order. -/
theorem vertexOrderEquivFin_key_lt_iff {V : Type*} [Fintype V]
    (o : VertexOrder V) (a b : Fin (Fintype.card V)) :
    o.key (vertexOrderEquivFin o a) < o.key (vertexOrderEquivFin o b) ↔
      a < b := by
  letI : LinearOrder V := LinearOrder.lift' o.key o.key_injective
  change vertexOrderEquivFin o a < vertexOrderEquivFin o b ↔ a < b
  simpa [vertexOrderEquivFin] using
    (monoEquivOfFin V rfl).lt_iff_lt

/-- Total natural-indexed enumeration associated to a nonempty vertex order.
Modulo is used only to make the function total; below the cardinality it is
literally `vertexOrderEquivFin`. -/
noncomputable def vertexOrderAt {V : Type*} [Fintype V]
    (o : VertexOrder V) (hcard : 0 < Fintype.card V) (k : ℕ) : V :=
  vertexOrderEquivFin o ⟨k % Fintype.card V, Nat.mod_lt k hcard⟩

theorem vertexOrderAt_eq {V : Type*} [Fintype V]
    (o : VertexOrder V) (hcard : 0 < Fintype.card V) {k : ℕ}
    (hk : k < Fintype.card V) :
    vertexOrderAt o hcard k = vertexOrderEquivFin o ⟨k, hk⟩ := by
  simp [vertexOrderAt, Nat.mod_eq_of_lt hk]

/-- The first `k` vertices of the natural enumeration are exactly the
predecessors of its `k`th vertex. -/
theorem image_range_vertexOrderAt_eq_predecessors {V : Type*}
    [Fintype V] [DecidableEq V] (o : VertexOrder V)
    (hcard : 0 < Fintype.card V) {k : ℕ}
    (hk : k < Fintype.card V) :
    (Finset.range k).image (vertexOrderAt o hcard) =
      Finset.univ.filter (fun parent =>
        o.key parent < o.key (vertexOrderAt o hcard k)) := by
  classical
  ext parent
  constructor
  · intro hparent
    obtain ⟨j, hj, rfl⟩ := Finset.mem_image.mp hparent
    have hjk : j < k := Finset.mem_range.mp hj
    have hjcard : j < Fintype.card V := hjk.trans hk
    apply Finset.mem_filter.mpr
    refine ⟨Finset.mem_univ _, ?_⟩
    rw [vertexOrderAt_eq o hcard hjcard, vertexOrderAt_eq o hcard hk]
    exact (vertexOrderEquivFin_key_lt_iff o ⟨j, hjcard⟩ ⟨k, hk⟩).2 hjk
  · intro hparent
    have hkey := (Finset.mem_filter.mp hparent).2
    let j : Fin (Fintype.card V) := (vertexOrderEquivFin o).symm parent
    have hjk : j.1 < k := by
      rw [vertexOrderAt_eq o hcard hk] at hkey
      have hkey' :
          o.key (vertexOrderEquivFin o j) <
            o.key (vertexOrderEquivFin o ⟨k, hk⟩) := by
        simpa [j] using hkey
      exact (vertexOrderEquivFin_key_lt_iff o j ⟨k, hk⟩).1 hkey'
    apply Finset.mem_image.mpr
    refine ⟨j.1, Finset.mem_range.mpr hjk, ?_⟩
    rw [vertexOrderAt_eq o hcard (hjk.trans hk)]
    simp [j]

/-- The nonpivot bad sets listed in increasing order of `o.key`. -/
noncomputable def modularOrderedBadSet {n : ℕ} (N : ℕ)
    (speeds : Fin n → ℕ) (pivot : Fin n)
    (o : VertexOrder (NonpivotVertex pivot))
    (hcard : 0 < Fintype.card (NonpivotVertex pivot)) (k : ℕ) :
    Finset ℕ :=
  pivotBadResidues N (speeds pivot)
    (speeds (vertexOrderAt o hcard k).1)

/-- The target fibers of the nonpivot bad sets in increasing key order. -/
noncomputable def modularOrderedTargetFiber {n : ℕ} (N : ℕ)
    (speeds : Fin n → ℕ) (pivot : Fin n)
    (o : VertexOrder (NonpivotVertex pivot))
    (hcard : 0 < Fintype.card (NonpivotVertex pivot))
    (k target : ℕ) : Finset ℕ :=
  pivotTargetFiber N (speeds pivot)
    (speeds (vertexOrderAt o hcard k).1) target

theorem modularEarlierParents_vertexOrderAt {n : ℕ} {pivot : Fin n}
    (o : VertexOrder (NonpivotVertex pivot))
    (hcard : 0 < Fintype.card (NonpivotVertex pivot)) {k : ℕ}
    (hk : k < Fintype.card (NonpivotVertex pivot)) :
    (Finset.range k).image (vertexOrderAt o hcard) =
      modularEarlierParents o (vertexOrderAt o hcard k) := by
  simpa [modularEarlierParents] using
    image_range_vertexOrderAt_eq_predecessors o hcard hk

/-- At every valid position, the sequence-level fiber credit used by the
ordered-union theorem is exactly the concrete modular order credit of that
child. -/
theorem fiberCredit_modularOrdered_eq_selectedEarlierParentFiberCredit
    {n : ℕ} (N : ℕ) (speeds : Fin n → ℕ) (pivot : Fin n)
    (o : VertexOrder (NonpivotVertex pivot))
    (hcard : 0 < Fintype.card (NonpivotVertex pivot)) {k : ℕ}
    (hk : k < Fintype.card (NonpivotVertex pivot)) :
    fiberCredit (strictPivotTargets N (speeds pivot))
        (modularOrderedTargetFiber N speeds pivot o hcard k)
        (Finset.range k) (modularOrderedBadSet N speeds pivot o hcard) =
      selectedEarlierParentFiberCredit N speeds pivot o
        (vertexOrderAt o hcard k) := by
  classical
  unfold fiberCredit selectedEarlierParentFiberCredit
  apply Finset.sum_congr rfl
  intro target _
  rw [← Finset.sup_image]
  rw [modularEarlierParents_vertexOrderAt o hcard hk]
  rfl

/-- Tokenwise, the abstract predecessor supremum is exactly the largest
intersection with one earlier nonpivot parent. -/
theorem orderedTokenCredit_modular_eq
    {n : ℕ} (N : ℕ) (speeds : Fin n → ℕ) (pivot : Fin n)
    (o : VertexOrder (NonpivotVertex pivot))
    (token : ModularFiberToken N speeds pivot) :
    orderedTokenCredit modularFiberOwner modularFiberEligible
        (modularFiberWeight N speeds pivot) o token =
      (modularEarlierParents o token.1).sup fun parent =>
        (pivotTargetFiber N (speeds pivot) (speeds token.1.1) token.2.1 ∩
          pivotBadResidues N (speeds pivot) (speeds parent.1)).card := by
  classical
  apply Nat.le_antisymm
  · apply Finset.sup_le
    intro parent _
    by_cases h : modularFiberEligible parent token ∧
        o.key parent < o.key (modularFiberOwner token)
    · have hmem : parent ∈ modularEarlierParents o token.1 := by
        simpa [modularEarlierParents, modularFiberOwner] using h.2
      rw [predecessorWeight, if_pos h]
      exact Finset.le_sup
        (s := modularEarlierParents o token.1)
        (f := fun parent =>
          (pivotTargetFiber N (speeds pivot) (speeds token.1.1) token.2.1 ∩
            pivotBadResidues N (speeds pivot) (speeds parent.1)).card)
        hmem
    · rw [predecessorWeight, if_neg h]
      exact Nat.zero_le _
  · apply Finset.sup_le
    intro parent hparent
    have hbefore : o.key parent < o.key token.1 := by
      simpa [modularEarlierParents] using hparent
    have hne : parent ≠ token.1 := by
      intro heq
      subst parent
      exact (Nat.lt_irrefl _) hbefore
    have hcondition : modularFiberEligible parent token ∧
        o.key parent < o.key (modularFiberOwner token) := by
      simpa [modularFiberEligible, modularFiberOwner] using ⟨hne, hbefore⟩
    have hle := Finset.le_sup
      (s := (Finset.univ : Finset (NonpivotVertex pivot)))
      (f := predecessorWeight modularFiberOwner modularFiberEligible
        (modularFiberWeight N speeds pivot) o token)
      (Finset.mem_univ parent)
    rw [predecessorWeight, if_pos hcondition] at hle
    exact hle

/-- The abstract order credit unfolds exactly to the sum of the existing
selected-earlier-parent `fiberCredit`s, one for each nonpivot child. -/
theorem orderCredit_modular_eq_fiberCredit_sum
    {n : ℕ} (N : ℕ) (speeds : Fin n → ℕ) (pivot : Fin n)
    (o : VertexOrder (NonpivotVertex pivot)) :
    orderCredit modularFiberOwner modularFiberEligible
        (modularFiberWeight N speeds pivot) o =
      modularOrderFiberCredit N speeds pivot o := by
  classical
  simp only [orderCredit, modularOrderFiberCredit]
  rw [Fintype.sum_prod_type]
  apply Finset.sum_congr rfl
  intro child _
  simp only [selectedEarlierParentFiberCredit, fiberCredit,
    orderedTokenCredit_modular_eq]
  apply Finset.sum_bij (fun target _ => target.1)
  · intro target _
    exact target.2
  · intro left _ right _ heq
    exact Subtype.ext heq
  · intro target htarget
    exact ⟨⟨target, htarget⟩, Finset.mem_univ _, rfl⟩
  · intro target _
    rfl

/-- Concrete threshold form of the order/acyclic-selector equivalence.  This
is an exact finite optimization reformulation, not a uniform existence claim. -/
theorem exists_modularOrderFiberCredit_ge_iff_exists_acyclicSelectorWeight_ge
    {n : ℕ} (N : ℕ) (speeds : Fin n → ℕ) (pivot : Fin n)
    (threshold : ℕ) :
    (∃ o : VertexOrder (NonpivotVertex pivot),
        threshold ≤ modularOrderFiberCredit N speeds pivot o) ↔
      ∃ s : FiberSelector (NonpivotVertex pivot)
          (ModularFiberToken N speeds pivot),
        SelectorValid modularFiberEligible s ∧
          SelectorAcyclic modularFiberOwner s ∧
          threshold ≤ selectorWeight (modularFiberWeight N speeds pivot) s := by
  rw [← exists_orderCredit_ge_iff_exists_acyclicSelectorWeight_ge
    modularFiberOwner modularFiberEligible
      (modularFiberWeight N speeds pivot) threshold]
  constructor
  · rintro ⟨o, h⟩
    exact ⟨o, by simpa [orderCredit_modular_eq_fiberCredit_sum] using h⟩
  · rintro ⟨o, h⟩
    exact ⟨o, by simpa [orderCredit_modular_eq_fiberCredit_sum] using h⟩

end LonelyRunner
