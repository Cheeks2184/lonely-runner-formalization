import Mathlib.Data.Rat.Cast.Order
import Mathlib.Analysis.Fourier.AddCircleMulti

/-!
# The adjacent-ratio combination in the BHK reduction

This file isolates the finite ordered-field calculation used to manufacture a
rational vector with no zero coordinate and a repeated absolute value.
-/

namespace LonelyRunner

/-- Given adjacent distinct coordinate ratios `s i / r i < s j / r j`, the
BHK combination

`w = (r i + r j) s - (s i + s j) r`

has no zero coordinate and satisfies `w i = -w j`.  Adjacency is expressed by
the absence of any coordinate ratio strictly between the selected pair. -/
theorem bhk_adjacentRatioCombination {m : ℕ}
    (r s : Fin m → ℚ) (hr : ∀ k, 0 < r k)
    (i j : Fin m)
    (hratio : s i / r i < s j / r j)
    (hadjacent : ∀ k, ¬ (s i / r i < s k / r k ∧
      s k / r k < s j / r j)) :
    let w : Fin m → ℚ := fun k =>
      (r i + r j) * s k - (s i + s j) * r k
    (∀ k, w k ≠ 0) ∧ w i = -w j := by
  let w : Fin m → ℚ := fun k =>
    (r i + r j) * s k - (s i + s j) * r k
  have hri : 0 < r i := hr i
  have hrj : 0 < r j := hr j
  have hcross : s i * r j < s j * r i := by
    exact (div_lt_div_iff₀ hri hrj).mp hratio
  have hsum : 0 < r i + r j := add_pos hri hrj
  have hmean_left :
      s i / r i < (s i + s j) / (r i + r j) := by
    apply (div_lt_div_iff₀ hri hsum).mpr
    calc
      s i * (r i + r j) = s i * r i + s i * r j := by ring
      _ < s i * r i + s j * r i :=
        add_lt_add_right hcross (s i * r i)
      _ = (s i + s j) * r i := by ring
  have hmean_right :
      (s i + s j) / (r i + r j) < s j / r j := by
    apply (div_lt_div_iff₀ hsum hrj).mpr
    calc
      (s i + s j) * r j = s i * r j + s j * r j := by ring
      _ < s j * r i + s j * r j :=
        add_lt_add_left hcross (s j * r j)
      _ = s j * (r i + r j) := by ring
  have hw_nonzero : ∀ k, w k ≠ 0 := by
    intro k hw
    have hrk : 0 < r k := hr k
    have hratio_mean : s k / r k =
        (s i + s j) / (r i + r j) := by
      apply (div_eq_div_iff hrk.ne' hsum.ne').mpr
      dsimp [w] at hw
      simpa [mul_comm] using (sub_eq_zero.mp hw)
    apply hadjacent k
    constructor
    · rw [hratio_mean]
      exact hmean_left
    · rw [hratio_mean]
      exact hmean_right
  have hw_opposite : w i = -w j := by
    dsimp [w]
    ring
  exact ⟨hw_nonzero, hw_opposite⟩

end LonelyRunner
