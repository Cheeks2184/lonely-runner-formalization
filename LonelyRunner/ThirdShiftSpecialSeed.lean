import LonelyRunner.ThirdShiftRescues
import LonelyRunner.SpecialSixthPhase

/-!
# Special-sixth seeded third shifts

An exceptional runner at an odd-sixth phase is safe for every third shift,
so the checked single-safe-exception rescue applies directly.
-/

namespace LonelyRunner

/-- An exceptional odd-sixth seed supplies the uniform safety required by the
single-exception third-shift rescue. -/
theorem exists_third_shift_of_special_sixth_seeded_divisible
    (v : Fin 5 → ℕ) (t : ℝ)
    (hseed : ∀ i, 3 ∣ v i →
      (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ)))
    (hexceptions :
      ((Finset.univ : Finset (Fin 5)).filter (fun i => ¬ 3 ∣ v i)).card ≤ 3)
    (r : Fin 5) (hr : ¬ 3 ∣ v r)
    (hx : Int.fract (t * (v r : ℝ)) = (1 : ℝ) / 6 ∨
      Int.fract (t * (v r : ℝ)) = (1 : ℝ) / 2 ∨
      Int.fract (t * (v r : ℝ)) = (5 : ℝ) / 6) :
    ∃ k : Fin 3, ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm
        ((t + (k.val : ℝ) / 3) * (v i : ℝ)) := by
  refine exists_third_shift_of_safe_exception_seeded_divisible
    v t hseed hexceptions r hr ?_
  intro k
  have hsafe := circleNorm_third_shift_of_special_sixth
    (t * (v r : ℝ)) (v r) k hx
  have hphase : (t + (k.val : ℝ) / 3) * (v r : ℝ) =
      t * (v r : ℝ) + (k.val : ℝ) * (v r : ℝ) / 3 := by
    ring
  rw [hphase]
  exact hsafe

end LonelyRunner
