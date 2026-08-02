import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Data.Finset.Card
import Mathlib.Tactic

/-!
# Weighted finite zero counts

This file isolates the finite double-counting step behind correlation
arguments.  It deliberately makes the positive-multiplicity slice explicit:
a bound on `count x` is required only when `x` occurs in at least one
candidate slice.  Points of multiplicity zero contribute zero to both sums.

No arithmetic property of runner speeds, no common-LCM construction, and no
claim that a particular polynomial gives a useful positive lower bound is
assumed here.
-/

namespace LonelyRunner

open scoped BigOperators

/-- The number of indexed candidate slices containing a point. -/
def candidateMultiplicity
    {α ι : Type*} [DecidableEq α] [DecidableEq ι]
    (indices : Finset ι) (candidates : ι → Finset α) (x : α) : Nat :=
  (indices.filter fun i => x ∈ candidates i).card

/-- The part of one candidate slice on which the counting statistic vanishes. -/
def zeroCandidateSlice
    {α ι : Type*} [DecidableEq α]
    (points : Finset α) (candidates : ι → Finset α)
    (count : α → Nat) (i : ι) : Finset α :=
  points.filter fun x => x ∈ candidates i ∧ count x = 0

/-- Double counting the pairs `(i,x)` with `x` in candidate slice `i` and
`count x = 0` gives the weighted zero-count identity. -/
theorem sum_card_zeroCandidateSlice_eq_weighted_zero_count
    {α ι : Type*} [DecidableEq α] [DecidableEq ι]
    (points : Finset α) (indices : Finset ι)
    (candidates : ι → Finset α) (count : α → Nat) :
    (∑ i ∈ indices, (zeroCandidateSlice points candidates count i).card) =
      ∑ x ∈ points,
        candidateMultiplicity indices candidates x *
          (if count x = 0 then 1 else 0) := by
  simp only [zeroCandidateSlice, Finset.card_filter, candidateMultiplicity]
  rw [Finset.sum_comm]
  apply Finset.sum_congr rfl
  intro x hx
  by_cases hzero : count x = 0
  · simp [hzero]
  · simp [hzero]

/-- The rational weighted sum of a statistic evaluated at `count x`. -/
def weightedStatisticSum
    {α : Type*} [DecidableEq α]
    (points : Finset α) (weight count : α → Nat)
    (statistic : Nat → ℚ) : ℚ :=
  ∑ x ∈ points, (weight x : ℚ) * statistic (count x)

/-- The weighted zero indicator.  It is the rational coercion of a weighted
zero count, written in a form convenient for pointwise comparison. -/
def weightedZeroIndicatorSum
    {α : Type*} [DecidableEq α]
    (points : Finset α) (weight count : α → Nat) : ℚ :=
  ∑ x ∈ points, (weight x : ℚ) * if count x = 0 then 1 else 0

/-- Rational form of the candidate-slice double count. -/
theorem cast_sum_card_zeroCandidateSlice_eq_weightedZeroIndicatorSum
    {α ι : Type*} [DecidableEq α] [DecidableEq ι]
    (points : Finset α) (indices : Finset ι)
    (candidates : ι → Finset α) (count : α → Nat) :
    ((∑ i ∈ indices,
        (zeroCandidateSlice points candidates count i).card : Nat) : ℚ) =
      weightedZeroIndicatorSum points
        (candidateMultiplicity indices candidates) count := by
  rw [sum_card_zeroCandidateSlice_eq_weighted_zero_count]
  unfold weightedZeroIndicatorSum
  push_cast
  rfl

/-- A pointwise zero-indicator bound yields its weighted finite-sum bound.

The upper bound `count x ≤ n-1` is required only on the positive-weight
slice.  This is the precise guard needed in applications where the pointwise
polynomial inequality may fail at `count x = n`, but every such point has
weight zero. -/
theorem weightedStatisticSum_le_weightedZeroIndicatorSum
    {α : Type*} [DecidableEq α]
    (points : Finset α) (weight count : α → Nat)
    (statistic : Nat → ℚ) (n : Nat)
    (hcount : ∀ x ∈ points, 0 < weight x → count x ≤ n - 1)
    (hzero : statistic 0 ≤ 1)
    (hpositive : ∀ k, 1 ≤ k → k ≤ n - 1 → statistic k ≤ 0) :
    weightedStatisticSum points weight count statistic ≤
      weightedZeroIndicatorSum points weight count := by
  unfold weightedStatisticSum weightedZeroIndicatorSum
  apply Finset.sum_le_sum
  intro x hx
  by_cases hweight : weight x = 0
  · simp [hweight]
  have hweightNonneg : (0 : ℚ) ≤ weight x := by positivity
  by_cases hcountZero : count x = 0
  · simp only [hcountZero, if_pos]
    exact mul_le_mul_of_nonneg_left hzero hweightNonneg
  · simp only [if_neg hcountZero]
    have hweightPos : 0 < weight x := Nat.pos_of_ne_zero hweight
    have hcountPos : 1 ≤ count x := Nat.one_le_iff_ne_zero.mpr hcountZero
    have hstat : statistic (count x) ≤ 0 :=
      hpositive (count x) hcountPos (hcount x hx hweightPos)
    simpa only [mul_zero] using
      mul_nonpos_of_nonneg_of_nonpos hweightNonneg hstat

/-- Candidate multiplicity can be used directly as the weight.  Crucially,
the cardinality hypothesis is needed only for points belonging to at least
one candidate slice. -/
theorem weightedCandidateStatisticSum_le_weightedZeroIndicatorSum
    {α ι : Type*} [DecidableEq α] [DecidableEq ι]
    (points : Finset α) (indices : Finset ι)
    (candidates : ι → Finset α) (count : α → Nat)
    (statistic : Nat → ℚ) (n : Nat)
    (hcount : ∀ x ∈ points,
      0 < candidateMultiplicity indices candidates x → count x ≤ n - 1)
    (hzero : statistic 0 ≤ 1)
    (hpositive : ∀ k, 1 ≤ k → k ≤ n - 1 → statistic k ≤ 0) :
    weightedStatisticSum points
        (candidateMultiplicity indices candidates) count statistic ≤
      weightedZeroIndicatorSum points
        (candidateMultiplicity indices candidates) count :=
  weightedStatisticSum_le_weightedZeroIndicatorSum
    points (candidateMultiplicity indices candidates) count statistic n
    hcount hzero hpositive

/-- Complete abstract bridge from a pointwise statistic inequality to the
total number of zero-statistic points across all candidate slices. -/
theorem weightedCandidateStatisticSum_le_cast_sum_card_zeroCandidateSlice
    {α ι : Type*} [DecidableEq α] [DecidableEq ι]
    (points : Finset α) (indices : Finset ι)
    (candidates : ι → Finset α) (count : α → Nat)
    (statistic : Nat → ℚ) (n : Nat)
    (hcount : ∀ x ∈ points,
      0 < candidateMultiplicity indices candidates x → count x ≤ n - 1)
    (hzero : statistic 0 ≤ 1)
    (hpositive : ∀ k, 1 ≤ k → k ≤ n - 1 → statistic k ≤ 0) :
    weightedStatisticSum points
        (candidateMultiplicity indices candidates) count statistic ≤
      ((∑ i ∈ indices,
          (zeroCandidateSlice points candidates count i).card : Nat) : ℚ) := by
  rw [cast_sum_card_zeroCandidateSlice_eq_weightedZeroIndicatorSum]
  exact weightedCandidateStatisticSum_le_weightedZeroIndicatorSum
    points indices candidates count statistic n hcount hzero hpositive

end LonelyRunner
