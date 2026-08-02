import LonelyRunner.AnchorStarAveraging
import LonelyRunner.TwoLevelFiberCredits

/-!
# Abstract cellwise dispersion for anchor-star gains

This module formalizes the elementary finite-set and arithmetic facts behind
the cellwise lower bound for the anchor-star third-anchor gain.

For exactly two parents, the anchored contribution on one cell is the exact
intersection with their union.  Adding a third competing count can improve
the cell credit from `a` to `max a b`, whose improvement is `b - a`.  An
additive cancellation identity for the global costs then turns any lower
bound for the gain into a cost decrease, and pointwise gain bounds may be
summed over ordered distinct pairs.

The concrete modular argument must still identify its target cells, prove the
global cancellation identity, and establish the cross-pivot arithmetic
inequality.  No version of `DISPERSION-STAR` or `ANCHOR-STAR-UNIF` is asserted
here.
-/

namespace LonelyRunner

open scoped BigOperators

/-- On one cell and with exactly two distinct parents, the anchored
two-level contribution is the literal intersection with their union. -/
theorem subfiber_pair_anchor_credit_eq_card_inter_union
    {α ι : Type*} [DecidableEq α] [DecidableEq ι]
    (subfiber : Finset α) (parent : ι → Finset α)
    (anchor other : ι) (hne : anchor ≠ other) :
    (subfiber ∩ parent anchor).card +
        (({anchor, other} : Finset ι).erase anchor).sup (fun i =>
          ((subfiber \ parent anchor) ∩ parent i).card) =
      (subfiber ∩ (parent anchor ∪ parent other)).card := by
  classical
  have herase : ({anchor, other} : Finset ι).erase anchor = {other} := by
    ext i
    simp [hne]
  rw [herase]
  simp only [Finset.sup_singleton]
  have hdisjoint : Disjoint (subfiber ∩ parent anchor)
      ((subfiber \ parent anchor) ∩ parent other) := by
    rw [Finset.disjoint_left]
    intro a haAnchor haOther
    exact (Finset.mem_sdiff.mp (Finset.mem_inter.mp haOther).1).2
      (Finset.mem_inter.mp haAnchor).2
  have hunion :
      (subfiber ∩ parent anchor) ∪
          ((subfiber \ parent anchor) ∩ parent other) =
        subfiber ∩ (parent anchor ∪ parent other) := by
    ext a
    simp only [Finset.mem_union, Finset.mem_inter, Finset.mem_sdiff]
    aesop
  rw [← hunion]
  exact (Finset.card_union_of_disjoint hdisjoint).symm

/-- The improvement from a cell count `old` to a competing count `new` is
the positive part `new - old`. -/
theorem add_natSub_eq_max (old new : ℕ) :
    old + (new - old) = max old new := by
  omega

/-- Cellwise version of `add_natSub_eq_max`, summed over any finite cell
partition. -/
theorem sum_add_directionalGain_eq_sum_max
    {κ : Type*} (cells : Finset κ) (old new : κ → ℕ) :
    (∑ cell ∈ cells, old cell) +
        ∑ cell ∈ cells, (new cell - old cell) =
      ∑ cell ∈ cells, max (old cell) (new cell) := by
  rw [← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro cell _
  exact add_natSub_eq_max (old cell) (new cell)

/-- Symmetric pairwise dispersion of two natural-number cell counts. -/
def natPairwiseDispersion (a b : ℕ) : ℕ :=
  max a b - min a b

/-- The two orientations of a positive-part difference add to the symmetric
pairwise dispersion. -/
theorem directionalGains_add_reverse_eq_natPairwiseDispersion (a b : ℕ) :
    (b - a) + (a - b) = natPairwiseDispersion a b := by
  unfold natPairwiseDispersion
  omega

/-- Safe natural-number form of the anchor-prefix/tail cancellation.  Stating
the identity additively first avoids using truncated subtraction before the
monotonicity `newCost ≤ oldCost` has been established. -/
theorem cost_gain_of_additiveCancellation
    (oldCost newCost gain : ℕ)
    (hcancel : oldCost = newCost + gain) :
    newCost ≤ oldCost ∧ oldCost - newCost = gain := by
  omega

/-- Pointwise lower bounds for ordered-pair gains sum without changing the
ordered-distinct-pair multiplicities. -/
theorem orderedDistinctPairSum_mono_nat
    {ι : Type*} [DecidableEq ι]
    (choices : Finset ι) (lower gain : ι → ι → ℕ)
    (hpointwise : ∀ q ∈ choices, ∀ r ∈ choices.erase q,
      lower q r ≤ gain q r) :
    orderedDistinctPairSum choices lower ≤
      orderedDistinctPairSum choices gain := by
  unfold orderedDistinctPairSum
  exact Finset.sum_le_sum fun q hq =>
    Finset.sum_le_sum fun r hr => hpointwise q hq r hr

/-- The preceding ordered-sum bound remains valid after casting to rationals
and normalizing by any nonnegative denominator.  Concrete anchor-star
applications use `(m-1)(m-2)` as this denominator. -/
theorem orderedDistinctPairAverage_mono_of_nat
    {ι : Type*} [DecidableEq ι]
    (choices : Finset ι) (lower gain : ι → ι → ℕ)
    (denominator : ℚ) (hdenominator : 0 ≤ denominator)
    (hpointwise : ∀ q ∈ choices, ∀ r ∈ choices.erase q,
      lower q r ≤ gain q r) :
    (orderedDistinctPairSum choices lower : ℕ) / denominator ≤
      (orderedDistinctPairSum choices gain : ℕ) / denominator := by
  apply div_le_div_of_nonneg_right _ hdenominator
  exact_mod_cast orderedDistinctPairSum_mono_nat choices lower gain hpointwise

end LonelyRunner
