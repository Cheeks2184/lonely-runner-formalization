import LonelyRunner.BHKAdjacentRatios
import LonelyRunner.RationalRelationSpace
import Mathlib.Data.Finset.Card

/-!
# Assembly of the finite BHK collision witness

This file packages the exact interface between the rational linear-algebra
construction and generalized Kronecker approximation.  The hypotheses say
that two rational vectors annihilate every integer relation of the original
real velocity vector.  An adjacent pair of distinct coordinate ratios then
produces a rational vector which has no zero coordinate, still annihilates
all those relations, and has two equal absolute coordinate values.  The last
fact is also recorded as the strict finite-range cardinality bound needed for
the lower-dimensional Lonely Runner invocation.
-/

namespace LonelyRunner

noncomputable section

open Finset
open scoped BigOperators

/-- A rational linear combination of the basis-coordinate rows of `u`. -/
def rationalRowCombination {m : ℕ} (u : Fin m → ℝ)
    (c : Fin (Module.finrank ℚ (rationalSpan u)) → ℚ) : Fin m → ℚ :=
  fun i => ∑ k, c k * rationalRow u k i

/-- Every rational combination of the coordinate rows annihilates every
integer relation among the original real velocities. -/
theorem integer_relation_annihilates_rowCombination {m : ℕ}
    (u : Fin m → ℝ)
    (c : Fin (Module.finrank ℚ (rationalSpan u)) → ℚ)
    (a : Fin m → ℤ) (ha : ∑ i, (a i : ℝ) * u i = 0) :
    ∑ i, (a i : ℚ) * rationalRowCombination u c i = 0 := by
  calc
    ∑ i, (a i : ℚ) * rationalRowCombination u c i =
        ∑ i, ∑ k, (a i : ℚ) * (c k * rationalRow u k i) := by
      apply Finset.sum_congr rfl
      intro i _hi
      simp only [rationalRowCombination, Finset.mul_sum]
    _ = ∑ k, ∑ i, (a i : ℚ) * (c k * rationalRow u k i) :=
      Finset.sum_comm
    _ = ∑ k, c k * (∑ i, (a i : ℚ) * rationalRow u k i) := by
      apply Finset.sum_congr rfl
      intro k _hk
      rw [Finset.mul_sum]
      apply Finset.sum_congr rfl
      intro i _hi
      ring
    _ = 0 := by
      simp only [integer_relation_annihilates_row u a ha, mul_zero,
        Finset.sum_const_zero]

/-- The rational vector used in the Bohman--Holzman--Kleitman reduction. -/
def bhkCombination {m : ℕ} (r s : Fin m → ℚ) (i j : Fin m) : Fin m → ℚ :=
  fun k => (r i + r j) * s k - (s i + s j) * r k

/-- Integer-relation compatibility is closed under the BHK linear
combination.  The result is stated over `ℚ`, before casting to the real form
used by generalized Kronecker approximation. -/
theorem bhkCombination_preserves_integer_relations {m : ℕ}
    (u : Fin m → ℝ) (r s : Fin m → ℚ) (i j : Fin m)
    (hr : ∀ a : Fin m → ℤ,
      (∑ k, (a k : ℝ) * u k = 0) → ∑ k, (a k : ℚ) * r k = 0)
    (hs : ∀ a : Fin m → ℤ,
      (∑ k, (a k : ℝ) * u k = 0) → ∑ k, (a k : ℚ) * s k = 0) :
    ∀ a : Fin m → ℤ,
      (∑ k, (a k : ℝ) * u k = 0) →
        ∑ k, (a k : ℚ) * bhkCombination r s i j k = 0 := by
  intro a ha
  have hra := hr a ha
  have hsa := hs a ha
  calc
    ∑ k, (a k : ℚ) * bhkCombination r s i j k =
        ∑ k, ((r i + r j) * ((a k : ℚ) * s k) -
          (s i + s j) * ((a k : ℚ) * r k)) := by
      apply Finset.sum_congr rfl
      intro k _hk
      simp only [bhkCombination]
      ring
    _ = (r i + r j) * (∑ k, (a k : ℚ) * s k) -
        (s i + s j) * (∑ k, (a k : ℚ) * r k) := by
      rw [Finset.sum_sub_distrib, Finset.mul_sum, Finset.mul_sum]
    _ = 0 := by rw [hsa, hra]; ring

/-- Rational relation compatibility cast into the real scalar equation
expected by `orbitHom_mem_closure_range_of_relations`. -/
theorem real_relation_of_rational_relation {m : ℕ}
    (w : Fin m → ℚ) (a : Fin m → ℤ)
    (h : ∑ k, (a k : ℚ) * w k = 0) :
    ∑ k, (a k : ℝ) * (w k : ℝ) = 0 := by
  exact_mod_cast h

/-- Exact finite assembly of the BHK collision witness.

Besides the nowhere-zero and opposite-coordinate conclusions supplied by the
adjacent-ratio calculation, this theorem records both rational and real forms
of relation preservation, an explicit pair of distinct equal magnitudes, and
the strict cardinality drop of the magnitude range. -/
theorem bhk_collisionWitness_of_adjacentRatios {m : ℕ}
    (u : Fin m → ℝ) (r s : Fin m → ℚ) (hrpos : ∀ k, 0 < r k)
    (i j : Fin m)
    (hratio : s i / r i < s j / r j)
    (hadjacent : ∀ k, ¬ (s i / r i < s k / r k ∧
      s k / r k < s j / r j))
    (hr : ∀ a : Fin m → ℤ,
      (∑ k, (a k : ℝ) * u k = 0) → ∑ k, (a k : ℚ) * r k = 0)
    (hs : ∀ a : Fin m → ℤ,
      (∑ k, (a k : ℝ) * u k = 0) → ∑ k, (a k : ℚ) * s k = 0) :
    let w := bhkCombination r s i j
    (∀ k, w k ≠ 0) ∧
      (∀ a : Fin m → ℤ,
        (∑ k, (a k : ℝ) * u k = 0) → ∑ k, (a k : ℚ) * w k = 0) ∧
      (∀ a : Fin m → ℤ,
        (∑ k, (a k : ℝ) * u k = 0) → ∑ k, (a k : ℝ) * (w k : ℝ) = 0) ∧
      (∃ p q : Fin m, p ≠ q ∧ |w p| = |w q|) ∧
      (Finset.univ.image (fun k => |w k|)).card < m := by
  let w := bhkCombination r s i j
  have hadj := bhk_adjacentRatioCombination r s hrpos i j hratio hadjacent
  change (∀ k, w k ≠ 0) ∧ _ at hadj
  rcases hadj with ⟨hwzero, hwopposite⟩
  have hij : i ≠ j := by
    intro hij
    subst j
    exact (lt_irrefl (s i / r i)) hratio
  have habs : |w i| = |w j| := by
    change w i = -w j at hwopposite
    rw [hwopposite, abs_neg]
  have hrat := bhkCombination_preserves_integer_relations u r s i j hr hs
  have hreal : ∀ a : Fin m → ℤ,
      (∑ k, (a k : ℝ) * u k = 0) →
        ∑ k, (a k : ℝ) * (w k : ℝ) = 0 := by
    intro a ha
    exact real_relation_of_rational_relation w a (hrat a ha)
  have hcardle : (Finset.univ.image (fun k => |w k|)).card ≤ m := by
    simpa using Finset.card_image_le (s := (Finset.univ : Finset (Fin m)))
      (f := fun k => |w k|)
  have hcardne : (Finset.univ.image (fun k => |w k|)).card ≠ m := by
    intro hcard
    have hinjOn : Set.InjOn (fun k : Fin m => |w k|)
        ((Finset.univ : Finset (Fin m)) : Set (Fin m)) := by
      apply Finset.card_image_iff.mp
      simpa using hcard
    exact hij (hinjOn (by simp) (by simp) habs)
  have hcardlt : (Finset.univ.image (fun k => |w k|)).card < m :=
    lt_of_le_of_ne hcardle hcardne
  exact ⟨hwzero, hrat, hreal, ⟨i, j, hij, habs⟩, hcardlt⟩

end

end LonelyRunner
