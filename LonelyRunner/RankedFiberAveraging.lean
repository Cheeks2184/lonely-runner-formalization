import LonelyRunner.FiberCredits
import Mathlib.Algebra.BigOperators.Fin
import Mathlib.Algebra.BigOperators.Expect
import Mathlib.Data.Fintype.BigOperators
import Mathlib.Data.Nat.Factorial.BigOperators
import Mathlib.Tactic

/-!
# Ranked random-order averaging

This file formalizes the finite averaging mechanism behind the ranked
one-level fiber bound.  It does **not** state or assume the arithmetic claim
`RF-UNIF`, which is false.

We use the standard insertion-code encoding of a uniformly random order of a
distinguished child and `n` parents ranked from best to worst.  Coordinate
`j : Fin n` records one of `j + 2` insertion slots when parent `j` is added.
There is no predecessor among the first `c` parents precisely when all of the
first `c` coordinates are nonzero.  Thus that event has probability
`1 / (c + 1)`, and the complementary tail event has probability
`c / (c + 1)`.

The tail-event formulation is essential when intersection counts have ties:
we never claim that the `q`th ranked parent is uniquely the maximizing parent.
-/

namespace LonelyRunner

open scoped BigOperators

/-- Insertion codes for orders of one distinguished child and `n` ranked
parents.  The `j`th parent has `j + 2` possible insertion slots. -/
abbrev RankedOrderCode (n : ℕ) := (j : Fin n) → Fin (j.1 + 2)

/-- Coordinate choices for codes in which none of the first `c` parents is
inserted before the child. -/
def noTopPredecessorChoices (c : ℕ) {n : ℕ} (j : Fin n) :
    Finset (Fin (j.1 + 2)) :=
  if j.1 < c then Finset.univ.erase 0 else Finset.univ

/-- All insertion codes in which no parent of rank `< c` precedes the child. -/
def noTopPredecessorCodes (n c : ℕ) : Finset (RankedOrderCode n) :=
  Fintype.piFinset fun j => noTopPredecessorChoices c j

/-- The complementary insertion-code event: at least one of the first `c`
ranked parents precedes the child. -/
def hasTopPredecessorCodes (n c : ℕ) : Finset (RankedOrderCode n) :=
  Finset.univ \ noTopPredecessorCodes n c

theorem card_noTopPredecessorCodes (n c : ℕ) :
    (noTopPredecessorCodes n c).card =
      ∏ j : Fin n, if j.1 < c then j.1 + 1 else j.1 + 2 := by
  classical
  rw [noTopPredecessorCodes, Fintype.card_piFinset]
  apply Fintype.prod_congr
  intro j
  by_cases hj : j.1 < c
  · simp [noTopPredecessorChoices, hj]
  · simp [noTopPredecessorChoices, hj]

/-- The elementary telescoping product underlying the random-order
probability. -/
theorem rankedChoiceProduct_mul (n c : ℕ) (hc : c ≤ n) :
    (c + 1) *
      (∏ j ∈ Finset.range n, if j < c then j + 1 else j + 2) =
      Nat.factorial (n + 1) := by
  induction n generalizing c with
  | zero =>
      have hc0 : c = 0 := by omega
      subst c
      simp
  | succ n ih =>
      by_cases hcn : c = n + 1
      · subst c
        have hprod :
            (∏ j ∈ Finset.range (n + 1),
                if j < n + 1 then j + 1 else j + 2) =
              Nat.factorial (n + 1) := by
          calc
            (∏ j ∈ Finset.range (n + 1),
                if j < n + 1 then j + 1 else j + 2) =
                ∏ j ∈ Finset.range (n + 1), (j + 1) := by
              refine Finset.prod_congr rfl (fun j hj => ?_)
              rw [if_pos (Finset.mem_range.mp hj)]
            _ = Nat.factorial (n + 1) := by
              rw [Finset.prod_range_add_one_eq_factorial]
        rw [hprod]
        simpa [Nat.add_assoc] using (Nat.factorial_succ (n + 1)).symm
      · have hcle : c ≤ n := by omega
        rw [Finset.prod_range_succ, if_neg (by omega : ¬n < c)]
        rw [Nat.factorial_succ]
        calc
          (c + 1) *
              ((∏ j ∈ Finset.range n, if j < c then j + 1 else j + 2) *
                (n + 2)) =
              ((c + 1) *
                ∏ j ∈ Finset.range n, if j < c then j + 1 else j + 2) *
                (n + 2) := by ac_rfl
          _ = Nat.factorial (n + 1) * (n + 2) := by rw [ih c hcle]
          _ = (n + 2) * Nat.factorial (n + 1) := by ac_rfl

/-- There are `(n + 1)!` insertion codes, as expected for orders of the child
and `n` parents. -/
theorem card_rankedOrderCode (n : ℕ) :
    Fintype.card (RankedOrderCode n) = Nat.factorial (n + 1) := by
  classical
  rw [Fintype.card_pi]
  calc
    (∏ j : Fin n, Fintype.card (Fin (j.1 + 2))) =
        ∏ j ∈ Finset.range n, (j + 2) := by
      rw [Finset.prod_range]
      simp
    _ = Nat.factorial (n + 1) := by
      have h := rankedChoiceProduct_mul n 0 (Nat.zero_le n)
      simpa [Nat.one_mul] using h

/-- Exact cross-multiplied probability that none of the first `c` parents
precedes the child.  Division is postponed so the statement stays in `ℕ`. -/
theorem card_noTopPredecessorCodes_mul (n c : ℕ) (hc : c ≤ n) :
    (noTopPredecessorCodes n c).card * (c + 1) =
      Nat.factorial (n + 1) := by
  classical
  rw [card_noTopPredecessorCodes]
  rw [← Finset.prod_range (fun j => if j < c then j + 1 else j + 2)]
  simpa [Nat.mul_comm] using rankedChoiceProduct_mul n c hc

/-- Exact rational probability of the no-predecessor tail event. -/
theorem noTopPredecessor_probability (n c : ℕ) (hc : c ≤ n) :
    ((noTopPredecessorCodes n c).card : ℚ) /
        Fintype.card (RankedOrderCode n) =
      1 / (c + 1 : ℚ) := by
  have hcard := card_noTopPredecessorCodes_mul n c hc
  have htotal : (0 : ℚ) < Fintype.card (RankedOrderCode n) := by positivity
  have hcpos : (0 : ℚ) < c + 1 := by positivity
  have hcardQ : ((noTopPredecessorCodes n c).card : ℚ) * (c + 1) =
      Fintype.card (RankedOrderCode n) := by
    rw [card_rankedOrderCode]
    exact_mod_cast hcard
  rw [(eq_div_iff hcpos.ne').2 hcardQ]
  field_simp

/-- Exact rational probability that at least one of the first `c` parents
precedes the child. -/
theorem hasTopPredecessor_probability (n c : ℕ) (hc : c ≤ n) :
    ((hasTopPredecessorCodes n c).card : ℚ) /
        Fintype.card (RankedOrderCode n) =
      (c : ℚ) / (c + 1 : ℚ) := by
  classical
  have hsubset : noTopPredecessorCodes n c ⊆
      (Finset.univ : Finset (RankedOrderCode n)) := Finset.subset_univ _
  have hdiff : (hasTopPredecessorCodes n c).card =
      Fintype.card (RankedOrderCode n) -
        (noTopPredecessorCodes n c).card := by
    simp [hasTopPredecessorCodes, Finset.card_sdiff]
  rw [hdiff]
  have hno := noTopPredecessor_probability n c hc
  have htotal : (0 : ℚ) < Fintype.card (RankedOrderCode n) := by positivity
  have hcpos : (0 : ℚ) < c + 1 := by positivity
  have hle : (noTopPredecessorCodes n c).card ≤
      Fintype.card (RankedOrderCode n) := by
    simpa using Finset.card_le_card hsubset
  rw [Nat.cast_sub hle, sub_div, hno]
  field_simp
  ring

/-- The ranked coefficients telescope to the tail coefficient `c/(c+1)`.
Ranks are zero-based here. -/
theorem sum_rankedCoefficients (c : ℕ) :
    (∑ j ∈ Finset.range c,
        (1 : ℚ) / ((j + 1 : ℚ) * (j + 2 : ℚ))) =
      (c : ℚ) / (c + 1 : ℚ) := by
  induction c with
  | zero => simp
  | succ c ih =>
      rw [Finset.sum_range_succ, ih]
      have hc1 : (c + 1 : ℚ) ≠ 0 := by positivity
      have hc2 : (c + 2 : ℚ) ≠ 0 := by positivity
      push_cast
      field_simp
      ring

/-- Tail-sum credit attached to an insertion code.  At threshold `t`,
`count t` is the number of top-ranked parents whose intersection count reaches
that threshold.  The indicator is one exactly on the corresponding
predecessor event. -/
def rankedTailCredit (n height : ℕ) (count : ℕ → ℕ)
    (code : RankedOrderCode n) : ℚ :=
  ∑ t ∈ Finset.range height,
    if code ∈ hasTopPredecessorCodes n (count t) then 1 else 0

/-- **Tie-safe per-fiber expected-credit identity.**  Averaging the integer
tail indicators over all insertion codes gives the sum of the exact tail
probabilities `c_t/(c_t+1)`.  Equal intersection counts cause no problem,
because `count t` counts every parent reaching threshold `t`. -/
theorem average_rankedTailCredit
    (n height : ℕ) (count : ℕ → ℕ)
    (hcount : ∀ t < height, count t ≤ n) :
    (∑ code : RankedOrderCode n, rankedTailCredit n height count code) /
        Fintype.card (RankedOrderCode n) =
      ∑ t ∈ Finset.range height,
        (count t : ℚ) / (count t + 1 : ℚ) := by
  classical
  calc
    (∑ code : RankedOrderCode n, rankedTailCredit n height count code) /
          Fintype.card (RankedOrderCode n) =
        (∑ t ∈ Finset.range height,
          ∑ code : RankedOrderCode n,
            if code ∈ hasTopPredecessorCodes n (count t) then (1 : ℚ) else 0) /
          (Fintype.card (RankedOrderCode n) : ℚ) := by
      congr 1
      simp only [rankedTailCredit]
      exact Finset.sum_comm
    _ = ∑ t ∈ Finset.range height,
          (∑ code : RankedOrderCode n,
            if code ∈ hasTopPredecessorCodes n (count t) then (1 : ℚ) else 0) /
            (Fintype.card (RankedOrderCode n) : ℚ) := by
      rw [Finset.sum_div]
    _ = ∑ t ∈ Finset.range height,
          (count t : ℚ) / (count t + 1 : ℚ) := by
      apply Finset.sum_congr rfl
      intro t ht
      have hprob := hasTopPredecessor_probability n (count t)
        (hcount t (Finset.mem_range.mp ht))
      convert hprob using 1
      simp

/-- Some member of a nonempty finite family is no larger than its exact
rational average.  This is the deterministic extraction used after an
expected additive upper bound has been established. -/
theorem exists_le_rational_average
    {Ω : Type*} [Fintype Ω] [Nonempty Ω]
    (cost : Ω → ℚ) :
    ∃ ω, cost ω ≤ (∑ x, cost x) / Fintype.card Ω := by
  classical
  by_contra h
  push Not at h
  have hsum :
      (Fintype.card Ω : ℚ) *
          ((∑ x, cost x) / Fintype.card Ω) <
        ∑ x, cost x := by
    simpa [Finset.mul_sum] using
      Finset.sum_lt_sum_of_nonempty Finset.univ_nonempty
        (fun x _ => h x)
  have hcard : (Fintype.card Ω : ℚ) ≠ 0 := by positivity
  have heq : (Fintype.card Ω : ℚ) *
      ((∑ x, cost x) / Fintype.card Ω) = ∑ x, cost x := by
    field_simp
  rw [heq] at hsum
  exact (lt_irrefl _ hsum)

/-- A strict average bound therefore yields a deterministic strict witness. -/
theorem exists_lt_of_rational_average_lt
    {Ω : Type*} [Fintype Ω] [Nonempty Ω]
    (cost : Ω → ℚ) (bound : ℚ)
    (haverage : (∑ x, cost x) / Fintype.card Ω < bound) :
    ∃ ω, cost ω < bound := by
  obtain ⟨ω, hω⟩ := exists_le_rational_average cost
  exact ⟨ω, hω.trans_lt haverage⟩

/-- A strict tail-average bound produces a deterministic insertion code with
strictly smaller cost.  This is the finite deterministic conclusion needed
once a concrete fiber system has supplied its threshold counts. -/
theorem exists_code_cost_lt_of_rankedTailAverage
    (n height : ℕ) (count : ℕ → ℕ)
    (hcount : ∀ t < height, count t ≤ n)
    (total bound : ℚ)
    (hstrict : total -
        (∑ t ∈ Finset.range height,
          (count t : ℚ) / (count t + 1 : ℚ)) < bound) :
    ∃ code : RankedOrderCode n,
      total - rankedTailCredit n height count code < bound := by
  have havg := average_rankedTailCredit n height count hcount
  apply exists_lt_of_rational_average_lt
    (fun code : RankedOrderCode n =>
      total - rankedTailCredit n height count code) bound
  have havgCost :
      (∑ code : RankedOrderCode n,
          (total - rankedTailCredit n height count code)) /
          Fintype.card (RankedOrderCode n) =
        total - ∑ t ∈ Finset.range height,
          (count t : ℚ) / (count t + 1 : ℚ) := by
    rw [Finset.sum_sub_distrib, Finset.sum_const, nsmul_eq_mul]
    rw [Finset.card_univ, sub_div, havg]
    have hcard : (Fintype.card (RankedOrderCode n) : ℚ) ≠ 0 := by positivity
    field_simp
  rw [havgCost]
  exact hstrict

/-!
The remaining interface to obtain the full repository-facing
`RANK-FIBER-AVG` theorem is to decode `RankedOrderCode` into a permutation and
prove that, for every threshold, `hasTopPredecessorCodes n c` is exactly the
event that at least one of the `c` parents whose intersection count reaches
that threshold precedes the child.  The cardinal/probability calculation and
the deterministic extraction are completed above.  The false arithmetic
uniformity claim `RF-UNIF` is neither needed nor hidden in this remaining
combinatorial interface.
-/

end LonelyRunner
