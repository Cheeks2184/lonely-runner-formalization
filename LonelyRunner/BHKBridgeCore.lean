import LonelyRunner.BHKAdjacentPair
import LonelyRunner.RationalRelationSpace

/-!
# Algebraic assembly of the BHK collision vector

This module packages the exact relation-preservation property needed by the
one-way Kronecker theorem and proves that it is preserved by the adjacent-ratio
construction.
-/

namespace LonelyRunner

/-- Every integer linear relation of `u` also annihilates the rational tuple
`w`.  This is the precise interface to the generalized Kronecker theorem. -/
def RationalRelationCompatible {m : ℕ} (u : Fin m → ℝ) (w : Fin m → ℚ) : Prop :=
  ∀ a : Fin m → ℤ,
    (∑ i, (a i : ℝ) * u i = 0) →
      ∑ i, (a i : ℚ) * w i = 0

theorem rationalRow_relationCompatible {m : ℕ} (u : Fin m → ℝ)
    (k : Fin (Module.finrank ℚ (rationalSpan u))) :
    RationalRelationCompatible u (rationalRow u k) := by
  intro a ha
  exact integer_relation_annihilates_row u a ha k

/-- Two compatible rational tuples, one positive and with nonconstant
coordinate ratios, yield a compatible nowhere-zero tuple with two equal
absolute values. -/
theorem exists_bhk_relationCompatible_collision {m : ℕ} [Nonempty (Fin m)]
    (u : Fin m → ℝ) (r s : Fin m → ℚ)
    (hr : ∀ k, 0 < r k)
    (hrelr : RationalRelationCompatible u r)
    (hrels : RationalRelationCompatible u s)
    (hnonconstant : ∃ a b, s a / r a ≠ s b / r b) :
    ∃ w : Fin m → ℚ,
      RationalRelationCompatible u w ∧
      (∀ k, w k ≠ 0) ∧
      ∃ i j, i ≠ j ∧ |w i| = |w j| := by
  obtain ⟨i, j, hij, hw_nonzero, hw_opposite⟩ :=
    exists_bhk_adjacentRatioCombination r s hr hnonconstant
  let w : Fin m → ℚ := fun k =>
    (r i + r j) * s k - (s i + s j) * r k
  have hrelw : RationalRelationCompatible u w := by
    intro a ha
    have hrs := hrels a ha
    have hrr := hrelr a ha
    calc
      ∑ k, (a k : ℚ) * w k =
          (r i + r j) * (∑ k, (a k : ℚ) * s k) -
            (s i + s j) * (∑ k, (a k : ℚ) * r k) := by
              calc
                ∑ k, (a k : ℚ) * w k =
                    ∑ k, ((r i + r j) * ((a k : ℚ) * s k) -
                      (s i + s j) * ((a k : ℚ) * r k)) := by
                        apply Finset.sum_congr rfl
                        intro k _
                        dsimp [w]
                        ring
                _ = (∑ k, (r i + r j) * ((a k : ℚ) * s k)) -
                    ∑ k, (s i + s j) * ((a k : ℚ) * r k) := by
                      rw [Finset.sum_sub_distrib]
                _ = _ := by
                  rw [← Finset.mul_sum, ← Finset.mul_sum]
      _ = 0 := by rw [hrs, hrr]; ring
  refine ⟨w, hrelw, hw_nonzero, i, j, hij, ?_⟩
  have hwopw : w i = -w j := by simpa [w] using hw_opposite
  rw [hwopw, abs_neg]

end LonelyRunner
