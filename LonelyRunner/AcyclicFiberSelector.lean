import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Data.Finset.Lattice.Fold
import Mathlib.Data.Fintype.EquivFin

/-!
# Acyclic selectors and order credits

This file isolates the finite combinatorial equivalence used by the acyclic-selector
approach.  A token belongs to a child vertex and may select one eligible parent.
An order receives, token by token, the largest weight of an eligible predecessor.

Rather than tying the statement to one graph library, acyclicity is represented by
its finite topological-numbering certificate: every selected parent has smaller rank
than the child owning the token.  The reverse construction below refines such a rank
to an injective natural-valued order by a finite tie-breaker.
-/

namespace LonelyRunner

open scoped BigOperators

section

variable {V T : Type*} [Fintype V] [DecidableEq V] [Fintype T]

/-- A finite linear order encoded by distinct natural-number keys. -/
structure VertexOrder (V : Type*) where
  key : V → ℕ
  key_injective : Function.Injective key

/-- A token selector either declines the token or assigns it a parent vertex. -/
abbrev FiberSelector (V T : Type*) := T → Option V

/-- The directed support selected by `s`: an edge goes from a selected parent to
the child that owns the corresponding token. -/
def selectorSupport (owner : T → V) (s : FiberSelector V T) (parent child : V) : Prop :=
  ∃ τ, owner τ = child ∧ s τ = some parent

/-- A topological-numbering certificate for the directed selector support.  On a
finite vertex type this is the usual DAG condition in certificate form. -/
def SelectorAcyclic (owner : T → V) (s : FiberSelector V T) : Prop :=
  ∃ rank : V → ℕ, ∀ ⦃parent child⦄,
    selectorSupport owner s parent child → rank parent < rank child

/-- A selector may only choose an eligible parent. -/
def SelectorValid (eligible : V → T → Prop) (s : FiberSelector V T) : Prop :=
  ∀ τ parent, s τ = some parent → eligible parent τ

/-- The weight earned by one selected token. -/
def selectedTokenWeight (weight : V → T → ℕ) (s : FiberSelector V T) (τ : T) : ℕ :=
  match s τ with
  | none => 0
  | some parent => weight parent τ

/-- Total weight of a selector. -/
def selectorWeight (weight : V → T → ℕ) (s : FiberSelector V T) : ℕ :=
  ∑ τ, selectedTokenWeight weight s τ

/-- Weight offered by `parent` for `τ`, truncated to zero unless it is eligible and
strictly precedes the token's owner. -/
noncomputable def predecessorWeight (owner : T → V) (eligible : V → T → Prop)
    (weight : V → T → ℕ) (o : VertexOrder V) (τ : T) (parent : V) : ℕ :=
  by
    classical
    exact if eligible parent τ ∧ o.key parent < o.key (owner τ) then weight parent τ else 0

/-- The best predecessor weight available to a token in an order. -/
noncomputable def orderedTokenCredit (owner : T → V) (eligible : V → T → Prop)
    (weight : V → T → ℕ) (o : VertexOrder V) (τ : T) : ℕ :=
  Finset.univ.sup (predecessorWeight owner eligible weight o τ)

/-- Total order credit, obtained by independently taking the best predecessor for
each token. -/
noncomputable def orderCredit (owner : T → V) (eligible : V → T → Prop)
    (weight : V → T → ℕ) (o : VertexOrder V) : ℕ :=
  ∑ τ, orderedTokenCredit owner eligible weight o τ

theorem selectedTokenWeight_le_orderedTokenCredit
    (owner : T → V) (eligible : V → T → Prop) (weight : V → T → ℕ)
    (o : VertexOrder V) (s : FiberSelector V T)
    (valid : SelectorValid eligible s)
    (before : ∀ τ parent, s τ = some parent → o.key parent < o.key (owner τ))
    (τ : T) :
    selectedTokenWeight weight s τ ≤ orderedTokenCredit owner eligible weight o τ := by
  classical
  cases hsel : s τ with
  | none =>
      simp only [selectedTokenWeight, hsel]
      exact Nat.zero_le _
  | some parent =>
      have heligible : eligible parent τ := valid τ parent hsel
      have hbefore : o.key parent < o.key (owner τ) := before τ parent hsel
      simpa [selectedTokenWeight, hsel, orderedTokenCredit, predecessorWeight,
        heligible, hbefore] using
        (Finset.le_sup (s := Finset.univ) (f := predecessorWeight owner eligible weight o τ)
          (Finset.mem_univ parent))

theorem selectorWeight_le_orderCredit
    (owner : T → V) (eligible : V → T → Prop) (weight : V → T → ℕ)
    (o : VertexOrder V) (s : FiberSelector V T)
    (valid : SelectorValid eligible s)
    (before : ∀ τ parent, s τ = some parent → o.key parent < o.key (owner τ)) :
    selectorWeight weight s ≤ orderCredit owner eligible weight o := by
  classical
  exact Finset.sum_le_sum fun τ _ ↦
    selectedTokenWeight_le_orderedTokenCredit owner eligible weight o s valid before τ

/-- For one token, the finite supremum is either zero (attained by declining the
token) or is attained by an eligible predecessor. -/
theorem exists_option_realizing_orderedTokenCredit
    (owner : T → V) (eligible : V → T → Prop) (weight : V → T → ℕ)
    (o : VertexOrder V) (τ : T) :
    ∃ choice : Option V,
      (∀ parent, choice = some parent →
        eligible parent τ ∧ o.key parent < o.key (owner τ)) ∧
      (match choice with
        | none => 0
        | some parent => weight parent τ) =
        orderedTokenCredit owner eligible weight o τ := by
  classical
  by_cases hzero : orderedTokenCredit owner eligible weight o τ = 0
  · exact ⟨none, by simp, by simpa [hzero]⟩
  · have huniv : (Finset.univ : Finset V).Nonempty := ⟨owner τ, Finset.mem_univ _⟩
    obtain ⟨parent, -, hsup⟩ := Finset.exists_mem_eq_sup Finset.univ huniv
      (predecessorWeight owner eligible weight o τ)
    have hsup' : orderedTokenCredit owner eligible weight o τ =
        predecessorWeight owner eligible weight o τ parent := by
      simpa only [orderedTokenCredit] using hsup
    have hcondition : eligible parent τ ∧ o.key parent < o.key (owner τ) := by
      by_contra hnot
      have hpredzero : predecessorWeight owner eligible weight o τ parent = 0 := by
        simp [predecessorWeight, hnot]
      exact hzero (hsup'.trans hpredzero)
    refine ⟨some parent, ?_, ?_⟩
    · intro other heq
      cases heq
      exact hcondition
    · simpa [predecessorWeight, hcondition] using hsup'.symm

/-- The order-to-selector direction.  Independent tokenwise maximizers form an
acyclic selector because every chosen support edge follows the given order. -/
theorem exists_acyclicSelector_with_weight_eq_orderCredit
    (owner : T → V) (eligible : V → T → Prop) (weight : V → T → ℕ)
    (o : VertexOrder V) :
    ∃ s : FiberSelector V T,
      SelectorValid eligible s ∧ SelectorAcyclic owner s ∧
      selectorWeight weight s = orderCredit owner eligible weight o := by
  classical
  have hchoice : ∀ τ : T, ∃ choice : Option V,
      (∀ parent, choice = some parent →
        eligible parent τ ∧ o.key parent < o.key (owner τ)) ∧
      (match choice with
        | none => 0
        | some parent => weight parent τ) =
        orderedTokenCredit owner eligible weight o τ :=
    fun τ ↦ exists_option_realizing_orderedTokenCredit owner eligible weight o τ
  choose s hs using hchoice
  refine ⟨s, ?_, ?_, ?_⟩
  · intro τ parent hselected
    exact (hs τ).1 parent hselected |>.1
  · refine ⟨o.key, ?_⟩
    rintro parent child ⟨τ, rfl, hselected⟩
    exact (hs τ).1 parent hselected |>.2
  · simp only [selectorWeight, orderCredit, selectedTokenWeight]
    exact Finset.sum_congr rfl fun τ _ ↦ (hs τ).2

/-- Refining a topological rank with a finite tie-breaker gives a genuine vertex
order and preserves every strict rank inequality. -/
noncomputable def orderOfRank (rank : V → ℕ) : VertexOrder V where
  key v := rank v * Fintype.card V + (Fintype.equivFin V) v
  key_injective := by
    intro a b hab
    have hmod := congrArg (fun n : ℕ ↦ n % Fintype.card V) hab
    have hcard : 0 < Fintype.card V := Fintype.card_pos_iff.mpr ⟨a⟩
    have ha_lt : (Fintype.equivFin V a : ℕ) < Fintype.card V := (Fintype.equivFin V a).isLt
    have hb_lt : (Fintype.equivFin V b : ℕ) < Fintype.card V := (Fintype.equivFin V b).isLt
    simp only [Nat.mul_add_mod_self_right, Nat.mod_eq_of_lt ha_lt,
      Nat.mod_eq_of_lt hb_lt] at hmod
    exact (Fintype.equivFin V).injective (Fin.ext hmod)

theorem orderOfRank_lt_of_lt (rank : V → ℕ) {a b : V} (h : rank a < rank b) :
    (orderOfRank rank).key a < (orderOfRank rank).key b := by
  dsimp [orderOfRank]
  have hcard : 0 < Fintype.card V := Fintype.card_pos_iff.mpr ⟨a⟩
  have hindex : (Fintype.equivFin V a : ℕ) < Fintype.card V := (Fintype.equivFin V a).isLt
  have hstep : rank a * Fintype.card V + (Fintype.equivFin V a : ℕ) <
      (rank a + 1) * Fintype.card V := by
    have := Nat.add_lt_add_left hindex (rank a * Fintype.card V)
    simpa [Nat.add_mul] using this
  have hrank : rank a + 1 ≤ rank b := h
  exact hstep.trans_le <|
    (Nat.mul_le_mul_right (Fintype.card V) hrank).trans (Nat.le_add_right _ _)

/-- Every valid acyclic selector can be placed in a vertex order in which every
selected parent precedes its child. -/
theorem exists_order_realizing_acyclicSelector
    (owner : T → V) (s : FiberSelector V T)
    (acyclic : SelectorAcyclic owner s) :
    ∃ o : VertexOrder V,
      ∀ τ parent, s τ = some parent → o.key parent < o.key (owner τ) := by
  rcases acyclic with ⟨rank, hrank⟩
  refine ⟨orderOfRank rank, ?_⟩
  intro τ parent hsel
  apply orderOfRank_lt_of_lt rank
  exact hrank ⟨τ, rfl, hsel⟩

/-- The selector-to-order direction: a valid acyclic selector never earns more
than the order credit of some topological linearization. -/
theorem exists_order_with_selectorWeight_le
    (owner : T → V) (eligible : V → T → Prop) (weight : V → T → ℕ)
    (s : FiberSelector V T) (valid : SelectorValid eligible s)
    (acyclic : SelectorAcyclic owner s) :
    ∃ o : VertexOrder V,
      selectorWeight weight s ≤ orderCredit owner eligible weight o := by
  rcases exists_order_realizing_acyclicSelector owner s acyclic with ⟨o, before⟩
  exact ⟨o, selectorWeight_le_orderCredit owner eligible weight o s valid before⟩

/-- Exact optimization equivalence, expressed without choosing a maximum: every
natural threshold is achievable by an order exactly when it is achievable by a
valid acyclic selector. -/
theorem exists_orderCredit_ge_iff_exists_acyclicSelectorWeight_ge
    (owner : T → V) (eligible : V → T → Prop) (weight : V → T → ℕ) (threshold : ℕ) :
    (∃ o : VertexOrder V,
        threshold ≤ orderCredit owner eligible weight o) ↔
      ∃ s : FiberSelector V T,
        SelectorValid eligible s ∧ SelectorAcyclic owner s ∧
        threshold ≤ selectorWeight weight s := by
  constructor
  · rintro ⟨o, hthreshold⟩
    obtain ⟨s, valid, acyclic, heq⟩ :=
      exists_acyclicSelector_with_weight_eq_orderCredit owner eligible weight o
    exact ⟨s, valid, acyclic, heq.symm ▸ hthreshold⟩
  · rintro ⟨s, valid, acyclic, hthreshold⟩
    obtain ⟨o, hle⟩ :=
      exists_order_with_selectorWeight_le owner eligible weight s valid acyclic
    exact ⟨o, hthreshold.trans hle⟩

/-- Equivalent universal upper-bound formulation of the same maxima equality. -/
theorem orderCredit_le_iff_acyclicSelectorWeight_le
    (owner : T → V) (eligible : V → T → Prop) (weight : V → T → ℕ) (bound : ℕ) :
    (∀ o : VertexOrder V, orderCredit owner eligible weight o ≤ bound) ↔
      ∀ s : FiberSelector V T,
        SelectorValid eligible s → SelectorAcyclic owner s → selectorWeight weight s ≤ bound := by
  constructor
  · intro horder s valid acyclic
    obtain ⟨o, hle⟩ :=
      exists_order_with_selectorWeight_le owner eligible weight s valid acyclic
    exact hle.trans (horder o)
  · intro hselector o
    obtain ⟨s, valid, acyclic, heq⟩ :=
      exists_acyclicSelector_with_weight_eq_orderCredit owner eligible weight o
    exact heq ▸ hselector s valid acyclic

end

end LonelyRunner
