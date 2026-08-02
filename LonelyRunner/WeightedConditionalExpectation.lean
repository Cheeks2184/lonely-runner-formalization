import Mathlib.Algebra.BigOperators.Field
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Data.Finset.Card
import Mathlib.Data.List.FinRange
import Mathlib.Tactic

/-!
# Weighted conditional expectation over finite choices

This file isolates the algebraic derandomization step used by conditional
expectation arguments.  If the potential at a state is the normalized
weighted average of the potentials at its possible next states, and every
weight is strictly positive, at least one next state has no larger potential.

The second theorem iterates this choice while removing the selected item from
a finite set.  It produces a duplicate-free removal order containing exactly
the original choices and whose terminal potential is no larger than the
initial potential.

No exponential potential, modular intersection formula, or arithmetic
uniformity claim is stated or assumed here.  In particular, this module is
independent of `GCD-CLOCK-UNIF`.
-/

namespace LonelyRunner

open scoped BigOperators

/-- Positive weights have positive total weight on a nonempty finite set. -/
theorem sum_weight_pos
    {ι : Type*} [DecidableEq ι]
    (choices : Finset ι) (weight : ι → ℚ)
    (hne : choices.Nonempty)
    (hpos : ∀ i ∈ choices, 0 < weight i) :
    0 < ∑ i ∈ choices, weight i := by
  exact Finset.sum_pos (fun i hi => hpos i hi) hne

/-- **One-step weighted conditional expectation.**  If `current` is the
normalized positive-weight average of the next potentials, some admissible
choice has next potential at most `current`. -/
theorem exists_nextPotential_le_of_eq_weightedAverage
    {ι : Type*} [DecidableEq ι]
    (choices : Finset ι) (weight nextPotential : ι → ℚ)
    (current : ℚ)
    (hne : choices.Nonempty)
    (hpos : ∀ i ∈ choices, 0 < weight i)
    (haverage :
      current =
        (∑ i ∈ choices, weight i * nextPotential i) /
          ∑ i ∈ choices, weight i) :
    ∃ i ∈ choices, nextPotential i ≤ current := by
  by_contra h
  push Not at h
  have hstrict :
      ∑ i ∈ choices, weight i * current <
        ∑ i ∈ choices, weight i * nextPotential i := by
    exact Finset.sum_lt_sum_of_nonempty hne fun i hi =>
      mul_lt_mul_of_pos_left (h i hi) (hpos i hi)
  have hweight : (∑ i ∈ choices, weight i) ≠ 0 :=
    (sum_weight_pos choices weight hne hpos).ne'
  have hcurrent :
      (∑ i ∈ choices, weight i) * current =
        ∑ i ∈ choices, weight i * nextPotential i := by
    rw [haverage]
    field_simp
  have hleft :
      (∑ i ∈ choices, weight i * current) =
        (∑ i ∈ choices, weight i) * current := by
    rw [Finset.sum_mul]
  rw [hleft, hcurrent] at hstrict
  exact (lt_irrefl _ hstrict)

/-- A state transition driven by a list of choices. -/
def followChoices {ι σ : Type*}
    (step : σ → ι → σ) (initial : σ) (order : List ι) : σ :=
  order.foldl step initial

/-- **Finite-horizon derandomization by removals.**

At every nonterminal state and remaining choice set, the current potential is
the normalized positive-weight average of the potentials obtained by choosing
one remaining item.  There is therefore an ordering of all initial choices
whose successive deterministic removals never need to increase the terminal
potential above its initial value.

The hypotheses are intentionally global in `state` and `remaining`, which
makes the result reusable for any concrete process closed under the specified
transition and removal operation. -/
theorem exists_removalOrder_terminalPotential_le
    {ι σ : Type*} [DecidableEq ι]
    (weight : σ → Finset ι → ι → ℚ)
    (step : σ → ι → σ)
    (potential : σ → ℚ)
    (hpos : ∀ state remaining i, i ∈ remaining →
      0 < weight state remaining i)
    (haverage : ∀ state remaining, remaining.Nonempty →
      potential state =
        (∑ i ∈ remaining,
            weight state remaining i * potential (step state i)) /
          ∑ i ∈ remaining, weight state remaining i)
    (initial : σ) (choices : Finset ι) :
    ∃ order : List ι,
      order.Nodup ∧
      order.toFinset = choices ∧
      potential (followChoices step initial order) ≤ potential initial := by
  classical
  induction choices using Finset.strongInduction generalizing initial with
  | H choices ih =>
      by_cases hempty : choices = ∅
      · subst choices
        exact ⟨[], by simp [followChoices]⟩
      · have hne : choices.Nonempty := Finset.nonempty_iff_ne_empty.mpr hempty
        obtain ⟨i, hi, hiPotential⟩ :=
          exists_nextPotential_le_of_eq_weightedAverage choices
            (weight initial choices) (fun j => potential (step initial j))
            (potential initial) hne (hpos initial choices)
            (haverage initial choices hne)
        have herase : choices.erase i ⊂ choices :=
          Finset.erase_ssubset hi
        obtain ⟨tail, htailNodup, htailChoices, htailPotential⟩ :=
          ih (choices.erase i) herase (step initial i)
        refine ⟨i :: tail, ?_, ?_, ?_⟩
        · rw [List.nodup_cons]
          refine ⟨?_, htailNodup⟩
          intro hitail
          have hiTailFinset : i ∈ tail.toFinset := by simpa using hitail
          rw [htailChoices] at hiTailFinset
          exact (Finset.mem_erase.mp hiTailFinset).1 rfl
        · simp only [List.toFinset_cons]
          rw [htailChoices, Finset.insert_erase hi]
        · change potential (followChoices step (step initial i) tail) ≤
            potential initial
          exact htailPotential.trans hiPotential

/-!
To apply the path theorem to additive runner orders, a separate arithmetic
interface must supply a concrete state, the remaining runners, positive
rational transition weights, and an exact weighted-average identity for the
chosen potential.  This module proves only the consequent algebraic
derandomization.  It gives no such identity for pair fibers or gcd clocks and
does not imply the false or unproved arithmetic uniformity principles studied
elsewhere in the repository.
-/

end LonelyRunner
