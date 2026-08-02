import LonelyRunner.AcyclicFiberSelector

/-!
# Unit threshold layers and soft-feedback cores

This file records the finite combinatorial bookkeeping behind the full-weight
soft-feedback formulation.  Thresholds are zero-indexed: layer `q` means the
positive threshold `q + 1`, and a parent supports that layer exactly when
`q < weight parent token`.  This convention makes zero weights and empty
eligible-parent sets definitionally harmless.

Eligibility below is always strengthened by `parent != owner token`.  Thus an
owner can never support its own token, independently of the caller's
eligibility predicate.  Tied maximum weights cause no choice of a distinguished
maximizer: a layer records the existential support of all tied parents.
-/

namespace LonelyRunner

open scoped BigOperators

section ThresholdLayers

variable {V T : Type*} [Fintype V] [DecidableEq V] [Fintype T]

/-- The usable-parent predicate, with owner exclusion made explicit. -/
def strictEligibleParent (owner : T -> V) (eligible : V -> T -> Prop)
    (parent : V) (token : T) : Prop :=
  eligible parent token /\ parent ≠ owner token

/-- A parent's potential contribution, before imposing an order. -/
noncomputable def potentialParentWeight (owner : T -> V) (eligible : V -> T -> Prop)
    (weight : V -> T -> Nat) (token : T) (parent : V) : Nat := by
  classical
  exact if strictEligibleParent owner eligible parent token then weight parent token else 0

/-- The largest usable parent weight.  It is zero when no usable parent exists. -/
noncomputable def tokenPotential (owner : T -> V) (eligible : V -> T -> Prop)
    (weight : V -> T -> Nat) (token : T) : Nat :=
  Finset.univ.sup (potentialParentWeight owner eligible weight token)

/-- Layer `q` (positive threshold `q+1`) has an earlier supporting parent. -/
def orderUnitLayerMet (owner : T -> V) (eligible : V -> T -> Prop)
    (weight : V -> T -> Nat) (o : VertexOrder V) (token : T) (q : Nat) : Prop :=
  exists parent : V,
    strictEligibleParent owner eligible parent token /\
      o.key parent < o.key (owner token) /\ q < weight parent token

/-- The met layers of one token.  The ambient range is its unrestricted potential. -/
noncomputable def metOrderUnitLayers (owner : T -> V) (eligible : V -> T -> Prop)
    (weight : V -> T -> Nat) (o : VertexOrder V) (token : T) : Finset Nat := by
  classical
  exact (Finset.range (tokenPotential owner eligible weight token)).filter
    (orderUnitLayerMet owner eligible weight o token)

/-- The trapped layers of one token: no usable earlier parent meets the threshold. -/
noncomputable def trappedOrderUnitLayers (owner : T -> V) (eligible : V -> T -> Prop)
    (weight : V -> T -> Nat) (o : VertexOrder V) (token : T) : Finset Nat := by
  classical
  exact (Finset.range (tokenPotential owner eligible weight token)).filter
    (fun q => ¬ orderUnitLayerMet owner eligible weight o token q)

theorem orderUnitLayerMet_iff_lt_orderedTokenCredit
    (owner : T -> V) (eligible : V -> T -> Prop) (weight : V -> T -> Nat)
    (o : VertexOrder V) (token : T) (q : Nat) :
    orderUnitLayerMet owner eligible weight o token q <->
      q < orderedTokenCredit owner eligible weight o token := by
  classical
  simp only [orderUnitLayerMet, orderedTokenCredit, Finset.lt_sup_iff,
    Finset.mem_univ, true_and, predecessorWeight]
  constructor
  · rintro ⟨parent, ⟨heligible, hne⟩, hbefore, hweight⟩
    exact ⟨parent, by simp [heligible, hbefore, hweight]⟩
  · rintro ⟨parent, hparent⟩
    by_cases hcondition : eligible parent token /\ o.key parent < o.key (owner token)
    · refine ⟨parent, ⟨hcondition.1, ?_⟩, hcondition.2, ?_⟩
      · intro heq
        subst parent
        exact (Nat.lt_irrefl _ hcondition.2)
      · simpa [hcondition] using hparent
    · simp [hcondition] at hparent

theorem orderedTokenCredit_le_tokenPotential
    (owner : T -> V) (eligible : V -> T -> Prop) (weight : V -> T -> Nat)
    (o : VertexOrder V) (token : T) :
    orderedTokenCredit owner eligible weight o token <=
      tokenPotential owner eligible weight token := by
  classical
  refine Finset.sup_le ?_
  intro parent hparent
  by_cases hcondition : eligible parent token /\ o.key parent < o.key (owner token)
  · have hne : parent ≠ owner token := by
      intro heq
      subst parent
      exact Nat.lt_irrefl _ hcondition.2
    have hstrict : strictEligibleParent owner eligible parent token := ⟨hcondition.1, hne⟩
    simpa [predecessorWeight, potentialParentWeight, tokenPotential, hcondition, hstrict] using
      (Finset.le_sup (s := (Finset.univ : Finset V))
        (f := potentialParentWeight owner eligible weight token)
        (Finset.mem_univ parent))
  · simp [predecessorWeight, hcondition]

/-- Tie-safe threshold expansion of the best predecessor weight. -/
theorem orderedTokenCredit_eq_card_metOrderUnitLayers
    (owner : T -> V) (eligible : V -> T -> Prop) (weight : V -> T -> Nat)
    (o : VertexOrder V) (token : T) :
    orderedTokenCredit owner eligible weight o token =
      (metOrderUnitLayers owner eligible weight o token).card := by
  classical
  have hle := orderedTokenCredit_le_tokenPotential owner eligible weight o token
  have hlayers : metOrderUnitLayers owner eligible weight o token =
      Finset.range (orderedTokenCredit owner eligible weight o token) := by
    ext q
    simp only [metOrderUnitLayers, Finset.mem_filter, Finset.mem_range]
    rw [orderUnitLayerMet_iff_lt_orderedTokenCredit]
    omega
  rw [hlayers, Finset.card_range]

/-- Potential equals realized predecessor credit plus the exact number of
trapped unit layers.  This additive form deliberately avoids truncated
subtraction. -/
theorem tokenPotential_eq_orderedTokenCredit_add_card_trapped
    (owner : T -> V) (eligible : V -> T -> Prop) (weight : V -> T -> Nat)
    (o : VertexOrder V) (token : T) :
    tokenPotential owner eligible weight token =
      orderedTokenCredit owner eligible weight o token +
        (trappedOrderUnitLayers owner eligible weight o token).card := by
  classical
  let s := Finset.range (tokenPotential owner eligible weight token)
  let p : Nat -> Prop := orderUnitLayerMet owner eligible weight o token
  have hdisjoint : Disjoint (s.filter p) (s.filter fun q => ¬ p q) := by
    exact Finset.disjoint_filter_filter_not s s p
  have hunion : s.filter p ∪ s.filter (fun q => ¬ p q) = s := by
    ext q
    by_cases hq : p q <;> simp [hq]
  have hpartition : (s.filter p).card + (s.filter fun q => ¬ p q).card = s.card := by
    rw [← Finset.card_union_of_disjoint hdisjoint, hunion]
  have hmet : (s.filter p).card = orderedTokenCredit owner eligible weight o token := by
    symm
    exact orderedTokenCredit_eq_card_metOrderUnitLayers owner eligible weight o token
  simpa [s, p, metOrderUnitLayers, trappedOrderUnitLayers, hmet,
    Nat.add_comm] using hpartition.symm

/-- Total unrestricted potential over all tokens. -/
noncomputable def orderPotential (owner : T -> V) (eligible : V -> T -> Prop)
    (weight : V -> T -> Nat) : Nat :=
  Finset.univ.sum (fun token : T => tokenPotential owner eligible weight token)

/-- Total soft loss of an order, counted as trapped unit layers. -/
noncomputable def orderSoftLoss (owner : T -> V) (eligible : V -> T -> Prop)
    (weight : V -> T -> Nat) (o : VertexOrder V) : Nat :=
  Finset.univ.sum
    (fun token : T => (trappedOrderUnitLayers owner eligible weight o token).card)

/-- Exact full-order soft-loss identity. -/
theorem orderPotential_eq_orderCredit_add_orderSoftLoss
    (owner : T -> V) (eligible : V -> T -> Prop) (weight : V -> T -> Nat)
    (o : VertexOrder V) :
    orderPotential owner eligible weight =
      orderCredit owner eligible weight o + orderSoftLoss owner eligible weight o := by
  classical
  simp only [orderPotential, orderCredit, orderSoftLoss]
  calc
    Finset.univ.sum (fun token : T => tokenPotential owner eligible weight token) =
        Finset.univ.sum (fun token : T => (orderedTokenCredit owner eligible weight o token +
          (trappedOrderUnitLayers owner eligible weight o token).card)) := by
            apply Finset.sum_congr rfl
            intro token htoken
            exact tokenPotential_eq_orderedTokenCredit_add_card_trapped
              owner eligible weight o token
    _ = _ := Finset.sum_add_distrib

end ThresholdLayers

section SetLayers

variable {V T : Type*} [Fintype V] [DecidableEq V] [Fintype T]

/-- A threshold layer supported by a parent in an explicitly supplied earlier set. -/
def setUnitLayerMet (owner : T -> V) (eligible : V -> T -> Prop)
    (weight : V -> T -> Nat) (earlier : Finset V) (token : T) (q : Nat) : Prop :=
  exists parent : V,
    parent ∈ earlier /\ strictEligibleParent owner eligible parent token /\
      q < weight parent token

/-- Unit layers trapped relative to an explicitly supplied earlier set. -/
noncomputable def trappedSetUnitLayers (owner : T -> V) (eligible : V -> T -> Prop)
    (weight : V -> T -> Nat) (earlier : Finset V) (token : T) : Finset Nat := by
  classical
  exact (Finset.range (tokenPotential owner eligible weight token)).filter
    (fun q => ¬ setUnitLayerMet owner eligible weight earlier token q)

/-- When `remaining` is the current unpeeled set, this is the exact number of
trapped layers owned by `vertex`; the earlier vertices are its complement. -/
noncomputable def softVertexDeficit (owner : T -> V) (eligible : V -> T -> Prop)
    (weight : V -> T -> Nat) (remaining : Finset V) (vertex : V) : Nat := by
  classical
  exact (Finset.univ.filter (fun token : T => owner token = vertex)).sum
    (fun token =>
      (trappedSetUnitLayers owner eligible weight (Finset.univ \ remaining) token).card)

end SetLayers

section BudgetedPeeling

variable {V : Type*} [Fintype V] [DecidableEq V]

/-- Loss accumulated by deleting the head of a list from its current remaining set. -/
def peelingLoss (deficit : Finset V -> V -> Nat) : List V -> Nat
  | [] => 0
  | vertex :: rest =>
      deficit (insert vertex rest.toFinset) vertex + peelingLoss deficit rest

/-- Sum of the budgets for nonempty core sizes `1,...,n`. -/
def peelingBudget (budget : Nat -> Nat) (n : Nat) : Nat :=
  (Finset.range n).sum (fun k => budget (k + 1))

theorem peelingBudget_succ (budget : Nat -> Nat) (n : Nat) :
    peelingBudget budget (n + 1) = peelingBudget budget n + budget (n + 1) := by
  simpa [peelingBudget] using
    (Finset.sum_range_succ (fun k => budget (k + 1)) n)

/-- If every nonempty remaining set contains a vertex within the budget for
that set size, a complete finite peeling with the summed budget exists. -/
theorem exists_peelingList_of_localBudget
    (deficit : Finset V -> V -> Nat) (budget : Nat -> Nat)
    (hlocal : forall Q : Finset V, Q.Nonempty ->
      exists vertex, vertex ∈ Q /\ deficit Q vertex <= budget Q.card) :
    exists order : List V,
      order.Nodup /\ order.toFinset = Finset.univ /\
        peelingLoss deficit order <= peelingBudget budget (Fintype.card V) := by
  classical
  have build : forall Q : Finset V, exists order : List V,
      order.Nodup /\ order.toFinset = Q /\
        peelingLoss deficit order <= peelingBudget budget Q.card := by
    intro Q
    induction Q using Finset.strongInduction with
    | H Q ih =>
        by_cases hempty : Q = (∅ : Finset V)
        · subst Q
          exact ⟨[], by simp [peelingLoss, peelingBudget]⟩
        · have hnonempty : Q.Nonempty := Finset.nonempty_iff_ne_empty.mpr hempty
          obtain ⟨vertex, hvertex, hdeficit⟩ := hlocal Q hnonempty
          obtain ⟨rest, hnodup, hrest, hloss⟩ := ih (Q.erase vertex)
            (Finset.erase_ssubset hvertex)
          have hnotmem : vertex ∉ rest := by
            intro hmem
            have hmem' : vertex ∈ rest.toFinset := List.mem_toFinset.mpr hmem
            rw [hrest] at hmem'
            exact (Finset.mem_erase.mp hmem').1 rfl
          refine ⟨vertex :: rest, List.nodup_cons.mpr ⟨hnotmem, hnodup⟩, ?_, ?_⟩
          · simp [hrest, Finset.insert_erase hvertex]
          · have hcard : (Q.erase vertex).card + 1 = Q.card :=
              Finset.card_erase_add_one hvertex
            calc
              peelingLoss deficit (vertex :: rest) =
                  deficit Q vertex + peelingLoss deficit rest := by
                    simp [peelingLoss, hrest, Finset.insert_erase hvertex]
              _ <= budget Q.card + peelingBudget budget (Q.erase vertex).card :=
                    Nat.add_le_add hdeficit hloss
              _ = peelingBudget budget Q.card := by
                    rw [← hcard, peelingBudget_succ]
                    omega
  simpa only [Finset.card_univ] using build Finset.univ

/-- Contrapositive soft-core form.  If every complete peeling costs more than
the total budget, some nonempty remaining set has every vertex strictly over
its local budget. -/
theorem exists_criticalCore_of_budget_lt_every_peeling
    (deficit : Finset V -> V -> Nat) (budget : Nat -> Nat)
    (failure : forall order : List V, order.Nodup -> order.toFinset = Finset.univ ->
      peelingBudget budget (Fintype.card V) < peelingLoss deficit order) :
    exists Q : Finset V, Q.Nonempty /\
      forall vertex, vertex ∈ Q -> budget Q.card < deficit Q vertex := by
  classical
  by_contra hcore
  have hlocal : forall Q : Finset V, Q.Nonempty ->
      exists vertex, vertex ∈ Q /\ deficit Q vertex <= budget Q.card := by
    intro Q hQ
    by_contra hvertex
    apply hcore
    refine ⟨Q, hQ, ?_⟩
    intro vertex hmem
    have : ¬ (deficit Q vertex <= budget Q.card) := by
      intro hle
      apply hvertex
      exact ⟨vertex, hmem, hle⟩
    omega
  obtain ⟨order, hnodup, hcomplete, hloss⟩ :=
    exists_peelingList_of_localBudget deficit budget hlocal
  exact (Nat.not_lt_of_ge hloss) (failure order hnodup hcomplete)

end BudgetedPeeling

section SoftBudgetedPeeling

variable {V T : Type*} [Fintype V] [DecidableEq V] [Fintype T]

/-- The local-budget peeling theorem specialized to exact threshold-layer
deficits.  Its conclusion uses only natural-number upper bounds. -/
theorem exists_softPeeling_of_localBudget
    (owner : T -> V) (eligible : V -> T -> Prop) (weight : V -> T -> Nat)
    (budget : Nat -> Nat)
    (hlocal : forall Q : Finset V, Q.Nonempty ->
      exists vertex, vertex ∈ Q /\
        softVertexDeficit owner eligible weight Q vertex <= budget Q.card) :
    exists order : List V,
      order.Nodup /\ order.toFinset = Finset.univ /\
        peelingLoss (softVertexDeficit owner eligible weight) order <=
          peelingBudget budget (Fintype.card V) :=
  exists_peelingList_of_localBudget
    (softVertexDeficit owner eligible weight) budget hlocal

/-- Strict natural-number critical-core implication for the exact soft
deficit.  In particular, no expression of the form `beta - ...` is truncated. -/
theorem exists_criticalSoftCore_of_budget_lt_every_peeling
    (owner : T -> V) (eligible : V -> T -> Prop) (weight : V -> T -> Nat)
    (budget : Nat -> Nat)
    (failure : forall order : List V,
      order.Nodup -> order.toFinset = Finset.univ ->
        peelingBudget budget (Fintype.card V) <
          peelingLoss (softVertexDeficit owner eligible weight) order) :
    exists Q : Finset V, Q.Nonempty /\
      forall vertex, vertex ∈ Q ->
        budget Q.card < softVertexDeficit owner eligible weight Q vertex :=
  exists_criticalCore_of_budget_lt_every_peeling
    (softVertexDeficit owner eligible weight) budget failure

end SoftBudgetedPeeling

end LonelyRunner
