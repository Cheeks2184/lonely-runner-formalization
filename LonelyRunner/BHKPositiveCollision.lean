import LonelyRunner.BHKAdjacentPair
import LonelyRunner.BHKBridgeAssembly
import LonelyRunner.BHKNongenericRow
import LonelyRunner.PositiveRationalRelation

/-!
# The finite BHK collision witness for an irrational positive velocity tuple

This module closes the finite-dimensional algebraic portion of the BHK
real-to-rational reduction.  Only the topological transfer from the resulting
lower-dimensional rational tuple back to the original orbit remains separate.
-/

namespace LonelyRunner

noncomputable section

/-- A positive real velocity tuple containing an irrational coordinate ratio
admits a nowhere-zero rational relation-compatible tuple with strictly fewer
distinct absolute coordinate values. -/
theorem exists_bhk_collisionWitness_of_irrational {m : ℕ}
    (u : Fin m → ℝ) (hu : ∀ k, 0 < u k)
    {p q : Fin m} (hirr : Irrational (u p / u q)) :
    ∃ w : Fin m → ℚ,
      (∀ k, w k ≠ 0) ∧
      (∀ a : Fin m → ℤ,
        (∑ k, (a k : ℝ) * u k = 0) → ∑ k, (a k : ℚ) * w k = 0) ∧
      (∀ a : Fin m → ℤ,
        (∑ k, (a k : ℝ) * u k = 0) → ∑ k, (a k : ℝ) * (w k : ℝ) = 0) ∧
      (∃ i j : Fin m, i ≠ j ∧ |w i| = |w j|) ∧
      (Finset.univ.image (fun k => |w k|)).card < m := by
  letI : Nonempty (Fin m) := ⟨p⟩
  obtain ⟨r, hrpos, hrrel⟩ :=
    exists_positive_rational_of_integer_relations u hu
  obtain ⟨row, hrowratio⟩ :=
    exists_rationalRow_ratio_ne_of_irrational u r hrpos (hu q).ne' hirr
  let s : Fin m → ℚ := rationalRow u row
  have hsrel : ∀ a : Fin m → ℤ,
      (∑ k, (a k : ℝ) * u k = 0) → ∑ k, (a k : ℚ) * s k = 0 := by
    intro a ha
    exact integer_relation_annihilates_row u a ha row
  obtain ⟨i, j, hratio, hadjacent⟩ :=
    exists_adjacent_image_values (fun k => s k / r k) ⟨p, q, hrowratio⟩
  refine ⟨bhkCombination r s i j, ?_⟩
  exact bhk_collisionWitness_of_adjacentRatios
    u r s hrpos i j hratio hadjacent hrrel hsrel

end

end LonelyRunner
