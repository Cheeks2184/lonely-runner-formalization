import LonelyRunner.BHKBridgeCore
import Mathlib.NumberTheory.Real.Irrational

/-!
# A rational coordinate row detecting an irrational speed ratio

This avoids constructing a second abstract dual functional.  Once a positive
rational compatible tuple `r` is known, irrationality forces at least one row
of the fixed rational basis coordinates to have a different coordinate ratio.
-/

namespace LonelyRunner

theorem exists_rationalRow_ratio_ne_of_irrational {m : ℕ}
    (u : Fin m → ℝ) (r : Fin m → ℚ) (hr : ∀ k, 0 < r k)
    {i j : Fin m} (huj : u j ≠ 0) (hirr : Irrational (u i / u j)) :
    ∃ k : Fin (Module.finrank ℚ (rationalSpan u)),
      rationalRow u k i / r i ≠ rationalRow u k j / r j := by
  by_contra h
  push Not at h
  have hcrossQ : ∀ k : Fin (Module.finrank ℚ (rationalSpan u)),
      rationalRow u k i * r j = rationalRow u k j * r i := by
    intro k
    exact (div_eq_div_iff (hr i).ne' (hr j).ne').mp (h k)
  have hcrossR : ∀ k : Fin (Module.finrank ℚ (rationalSpan u)),
      (rationalRow u k i : ℝ) * (r j : ℝ) =
        (rationalRow u k j : ℝ) * (r i : ℝ) := by
    intro k
    exact_mod_cast hcrossQ k
  have huCross : u i * (r j : ℝ) = u j * (r i : ℝ) := by
    rw [velocity_reconstruction u i, velocity_reconstruction u j]
    rw [Finset.sum_mul, Finset.sum_mul]
    apply Finset.sum_congr rfl
    intro k _
    calc
      ((rationalRow u k i : ℝ) *
          ((rationalBasis u k : rationalSpan u) : ℝ)) * (r j : ℝ) =
          ((rationalRow u k i : ℝ) * (r j : ℝ)) *
            ((rationalBasis u k : rationalSpan u) : ℝ) := by ring
      _ = ((rationalRow u k j : ℝ) * (r i : ℝ)) *
            ((rationalBasis u k : rationalSpan u) : ℝ) := by
              rw [hcrossR k]
      _ = ((rationalRow u k j : ℝ) *
          ((rationalBasis u k : rationalSpan u) : ℝ)) * (r i : ℝ) := by ring
  have hrjR : (r j : ℝ) ≠ 0 := Rat.cast_ne_zero.mpr (hr j).ne'
  have hratio : u i / u j = (r i : ℝ) / (r j : ℝ) := by
    apply (div_eq_div_iff huj hrjR).mpr
    simpa [mul_comm] using huCross
  apply hirr
  refine ⟨r i / r j, ?_⟩
  rw [Rat.cast_div]
  exact hratio.symm

end LonelyRunner
