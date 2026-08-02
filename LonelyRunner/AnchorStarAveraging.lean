import Mathlib.Algebra.BigOperators.Field
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Data.Finset.Card
import Mathlib.Tactic

/-!
# Abstract anchor-star double averaging

This module isolates the finite averaging implication behind the proposed
three-anchor (`ANCHOR-STAR`) certificate.  For a fixed first anchor, let `Q`
be the possible second anchors.  We average over ordered pairs

`q in Q`, `r in Q.erase q`.

If that average cost is strictly below a threshold, one ordered pair has cost
strictly below the threshold.  Equivalently, an exact identity saying that
the average cost is `total - star` converts the strict anchor-star inequality
`total - threshold < star` into a three-anchor certificate.

This file proves only that abstract implication.  It does not supply the
unresolved arithmetic lower bound on `star` and does not assert
`ANCHOR-STAR-UNIF`.
-/

namespace LonelyRunner

open scoped BigOperators

/-- Sum a function over ordered pairs of distinct elements of `choices`.
The nested representation keeps the multiplicity in the double average
explicit: every first element has exactly `choices.card - 1` partners. -/
def orderedDistinctPairSum
    {ι R : Type*} [DecidableEq ι] [AddCommMonoid R]
    (choices : Finset ι) (value : ι → ι → R) : R :=
  ∑ q ∈ choices, ∑ r ∈ choices.erase q, value q r

/-- Subtraction distributes through the ordered-distinct-pair sum. -/
theorem orderedDistinctPairSum_sub
    {ι R : Type*} [DecidableEq ι] [AddCommGroup R]
    (choices : Finset ι) (left right : ι → ι → R) :
    orderedDistinctPairSum choices (fun q r => left q r - right q r) =
      orderedDistinctPairSum choices left -
        orderedDistinctPairSum choices right := by
  simp only [orderedDistinctPairSum, Finset.sum_sub_distrib]

/-- A term depending only on the first coordinate occurs once for every
distinct possible second coordinate. -/
theorem orderedDistinctPairSum_left
    {ι R : Type*} [DecidableEq ι] [CommRing R]
    (choices : Finset ι) (value : ι → R) :
    orderedDistinctPairSum choices (fun q _ => value q) =
      (choices.card - 1 : ℕ) • ∑ q ∈ choices, value q := by
  classical
  simp only [orderedDistinctPairSum]
  calc
    (∑ q ∈ choices, ∑ _r ∈ choices.erase q, value q) =
        ∑ q ∈ choices, (choices.card - 1 : ℕ) • value q := by
      apply Finset.sum_congr rfl
      intro q hq
      rw [Finset.sum_const, Finset.card_erase_of_mem hq]
    _ = (choices.card - 1 : ℕ) • ∑ q ∈ choices, value q := by
      rw [Finset.smul_sum]

/-- A strict bound on an ordered-distinct-pair average is witnessed by one
ordered pair.  The cardinality assumption is exactly what makes the averaging
denominator positive. -/
theorem exists_orderedDistinctPair_lt_of_average_lt
    {ι : Type*} [DecidableEq ι]
    (choices : Finset ι) (value : ι → ι → ℚ) (threshold : ℚ)
    (hcard : 2 ≤ choices.card)
    (haverage :
      orderedDistinctPairSum choices value /
          ((choices.card : ℚ) * (choices.card - 1 : ℕ)) < threshold) :
    ∃ q ∈ choices, ∃ r ∈ choices.erase q, value q r < threshold := by
  by_contra h
  push Not at h
  have hsum :
      ∑ q ∈ choices, ∑ _r ∈ choices.erase q, threshold ≤
        orderedDistinctPairSum choices value := by
    unfold orderedDistinctPairSum
    exact Finset.sum_le_sum fun q hq =>
      Finset.sum_le_sum fun r hr => h q hq r hr
  have hcardPos : (0 : ℚ) < choices.card := by
    exact_mod_cast (lt_of_lt_of_le (by decide : 0 < 2) hcard)
  have hpredPos : (0 : ℚ) < (choices.card - 1 : ℕ) := by
    exact_mod_cast Nat.sub_pos_of_lt (lt_of_lt_of_le (by decide : 1 < 2) hcard)
  have hdenPos :
      (0 : ℚ) < (choices.card : ℚ) * (choices.card - 1 : ℕ) :=
    mul_pos hcardPos hpredPos
  rw [div_lt_iff₀ hdenPos] at haverage
  have hconstant :
      (∑ q ∈ choices, ∑ _r ∈ choices.erase q, threshold) =
        threshold * ((choices.card : ℚ) * (choices.card - 1 : ℕ)) := by
    calc
      (∑ q ∈ choices, ∑ _r ∈ choices.erase q, threshold) =
          ∑ _q ∈ choices, (choices.card - 1 : ℕ) • threshold := by
        apply Finset.sum_congr rfl
        intro q hq
        rw [Finset.sum_const, Finset.card_erase_of_mem hq]
      _ = choices.card • ((choices.card - 1 : ℕ) • threshold) := by
        rw [Finset.sum_const]
      _ = threshold * ((choices.card : ℚ) * (choices.card - 1 : ℕ)) := by
        ring
  rw [hconstant] at hsum
  exact (not_lt_of_ge hsum haverage)

/-- **Abstract anchor-star implication.**

Suppose the exact double-average identity for a fixed first anchor is

`average cost = total - star`.

Then the strict anchor-star inequality `total - threshold < star` selects two
distinct secondary anchors whose resulting three-anchor cost is below the
threshold.  Supplying the identity and the strict inequality is deliberately
left to the concrete modular arithmetic argument. -/
theorem exists_secondaryAnchors_of_anchorStar_gt
    {ι : Type*} [DecidableEq ι]
    (choices : Finset ι) (cost : ι → ι → ℚ)
    (total star threshold : ℚ)
    (hcard : 2 ≤ choices.card)
    (haverage :
      orderedDistinctPairSum choices cost /
          ((choices.card : ℚ) * (choices.card - 1 : ℕ)) = total - star)
    (hstar : total - threshold < star) :
    ∃ q ∈ choices, ∃ r ∈ choices.erase q, cost q r < threshold := by
  apply exists_orderedDistinctPair_lt_of_average_lt choices cost threshold hcard
  rw [haverage]
  linarith

/-- With a fixed eligible anchor, two remaining eligible choices exist
exactly when the complete eligible set has at least three elements. -/
theorem two_le_card_erase_anchor_iff_three_le_card
    {ι : Type*} [DecidableEq ι]
    (indices : Finset ι) (anchor : ι) (hanchor : anchor ∈ indices) :
    2 ≤ (indices.erase anchor).card ↔ 3 ≤ indices.card := by
  rw [Finset.card_erase_of_mem hanchor]
  omega

/-- Version exposing a fixed first anchor `anchor` and a complete eligible
anchor set `indices`.  The first hypothesis certifies that the fixed anchor is
eligible.  Membership in `indices.erase anchor` then records both eligibility
of the selected secondary anchors and pairwise distinctness of all three. -/
theorem exists_threeDistinctAnchors_of_anchorStar_gt
    {ι : Type*} [DecidableEq ι]
    (indices : Finset ι) (anchor : ι) (cost : ι → ι → ℚ)
    (total star threshold : ℚ)
    (hanchor : anchor ∈ indices)
    (hcard : 2 ≤ (indices.erase anchor).card)
    (haverage :
      orderedDistinctPairSum (indices.erase anchor) cost /
          (((indices.erase anchor).card : ℚ) *
            ((indices.erase anchor).card - 1 : ℕ)) = total - star)
    (hstar : total - threshold < star) :
    anchor ∈ indices ∧
      ∃ q ∈ indices, q ≠ anchor ∧
        ∃ r ∈ indices, r ≠ anchor ∧ r ≠ q ∧ cost q r < threshold := by
  obtain ⟨q, hq, r, hr, hcost⟩ :=
    exists_secondaryAnchors_of_anchorStar_gt (indices.erase anchor) cost
      total star threshold hcard haverage hstar
  have hq' := Finset.mem_erase.mp hq
  have hrq := Finset.mem_erase.mp hr
  have hr' := Finset.mem_erase.mp hrq.2
  exact ⟨hanchor, q, hq'.2, hq'.1, r, hr'.2, hr'.1, hrq.1,
    hcost⟩

/-- Cardinality-`3` interface to the fixed-anchor theorem.  The preceding
equivalence shows that this is exactly the same size condition as requiring
two secondary choices after erasing an eligible fixed anchor. -/
theorem exists_threeDistinctAnchors_of_anchorStar_gt_of_card
    {ι : Type*} [DecidableEq ι]
    (indices : Finset ι) (anchor : ι) (cost : ι → ι → ℚ)
    (total star threshold : ℚ)
    (hanchor : anchor ∈ indices)
    (hcard : 3 ≤ indices.card)
    (haverage :
      orderedDistinctPairSum (indices.erase anchor) cost /
          (((indices.erase anchor).card : ℚ) *
            ((indices.erase anchor).card - 1 : ℕ)) = total - star)
    (hstar : total - threshold < star) :
    anchor ∈ indices ∧
      ∃ q ∈ indices, q ≠ anchor ∧
        ∃ r ∈ indices, r ≠ anchor ∧ r ≠ q ∧ cost q r < threshold := by
  apply exists_threeDistinctAnchors_of_anchorStar_gt indices anchor cost
    total star threshold hanchor
  · exact (two_le_card_erase_anchor_iff_three_le_card
      indices anchor hanchor).2 hcard
  · exact haverage
  · exact hstar

end LonelyRunner
