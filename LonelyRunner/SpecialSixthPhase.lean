import LonelyRunner.ConstrainedMaximizer
import Mathlib.Tactic

/-!
# Odd sixth phases under third shifts

Euclidean division reduces each phase to three possible residues. Odd sixth
phases stay closed-safe; a nondivisible speed permutes them and reaches 5/6.
-/

namespace LonelyRunner

private theorem fract_add_nat_div_three (x : ℝ) (n : ℕ) :
    Int.fract (x + (n : ℝ) / 3) =
      Int.fract (Int.fract x + ((n % 3 : ℕ) : ℝ) / 3) := by
  apply Int.fract_eq_fract.mpr
  refine ⟨⌊x⌋ + ((n / 3 : ℕ) : ℤ), ?_⟩
  have hfloor := Int.floor_add_fract x
  have hdiv : (3 : ℝ) * ((n / 3 : ℕ) : ℝ) + ((n % 3 : ℕ) : ℝ) = (n : ℝ) := by
    exact_mod_cast (Nat.div_add_mod n 3)
  rw [Int.cast_add, Int.cast_natCast]
  linarith

private theorem circleNorm_ge_sixth_of_fract_special (y : ℝ)
    (hy : Int.fract y = (1 : ℝ) / 6 ∨ Int.fract y = (1 : ℝ) / 2 ∨
      Int.fract y = (5 : ℝ) / 6) :
    (1 : ℝ) / 6 ≤ circleNorm y := by
  rw [circleNorm_eq_min_fract]
  rcases hy with hy | hy | hy <;> rw [hy] <;> norm_num

/-- Every natural speed preserves the odd-sixth safe set under third shifts. -/
theorem circleNorm_third_shift_of_special_sixth
    (x : ℝ) (d : ℕ) (k : Fin 3)
    (hx : Int.fract x = (1 : ℝ) / 6 ∨ Int.fract x = (1 : ℝ) / 2 ∨
      Int.fract x = (5 : ℝ) / 6) :
    (1 : ℝ) / 6 ≤ circleNorm
      (x + (k.val : ℝ) * (d : ℝ) / 3) := by
  apply circleNorm_ge_sixth_of_fract_special
  have hphase : x + (k.val : ℝ) * (d : ℝ) / 3 =
      x + ((k.val * d : ℕ) : ℝ) / 3 := by
    push_cast
    ring
  rw [hphase, fract_add_nat_div_three]
  generalize hrdef : (k.val * d) % 3 = r
  have hr : r < 3 := by
    rw [← hrdef]
    exact Nat.mod_lt _ (by decide)
  interval_cases r <;> rcases hx with hx | hx | hx <;>
    (rw [hx]; norm_num [Int.fract_div_natCast_eq_div_natCast_mod])

/-- A speed nonzero modulo three can move any odd-sixth phase to exactly 5/6. -/
theorem exists_third_shift_fract_five_sixths
    (x : ℝ) (d : ℕ) (hnot : ¬ 3 ∣ d)
    (hx : Int.fract x = (1 : ℝ) / 6 ∨ Int.fract x = (1 : ℝ) / 2 ∨
      Int.fract x = (5 : ℝ) / 6) :
    ∃ k : Fin 3, Int.fract
      (x + (k.val : ℝ) * (d : ℝ) / 3) = (5 : ℝ) / 6 := by
  have hphase (k : Fin 3) : x + (k.val : ℝ) * (d : ℝ) / 3 =
      x + ((k.val * d : ℕ) : ℝ) / 3 := by
    push_cast
    ring
  let r := d % 3
  have hr : r < 3 := by exact Nat.mod_lt _ (by decide)
  have hrne : r ≠ 0 := by
    intro hz
    apply hnot
    exact Nat.dvd_iff_mod_eq_zero.mpr hz
  have hrCases : r = 1 ∨ r = 2 := by omega
  rcases hx with hx | hx | hx <;> rcases hrCases with hr | hr
  · refine ⟨2, ?_⟩
    rw [hphase, fract_add_nat_div_three]
    norm_num [Nat.mul_mod, hx, r, hr, Int.fract_div_natCast_eq_div_natCast_mod]
  · refine ⟨1, ?_⟩
    rw [hphase, fract_add_nat_div_three]
    norm_num [Nat.mul_mod, hx, r, hr, Int.fract_div_natCast_eq_div_natCast_mod]
  · refine ⟨1, ?_⟩
    rw [hphase, fract_add_nat_div_three]
    norm_num [Nat.mul_mod, hx, r, hr, Int.fract_div_natCast_eq_div_natCast_mod]
  · refine ⟨2, ?_⟩
    rw [hphase, fract_add_nat_div_three]
    norm_num [Nat.mul_mod, hx, r, hr, Int.fract_div_natCast_eq_div_natCast_mod]
  · exact ⟨0, by simpa using hx⟩
  · exact ⟨0, by simpa using hx⟩

end LonelyRunner
