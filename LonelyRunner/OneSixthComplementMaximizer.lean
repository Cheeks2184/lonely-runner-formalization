import LonelyRunner.ConstrainedMaximizer
import LonelyRunner.FiveRunnerOrdinary

namespace LonelyRunner

theorem exists_one_sixth_complement_maximizer
    (v : Fin 5 → ℕ) (hpos : ∀ i, 0 < v i) (p : Fin 5)
    (hno : ¬ ∃ t : ℝ, ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ))) :
    ∃ τ : ℝ, 0 < τ ∧ τ < 1 ∧ ComplementSafe v p ((1 : ℝ) / 6) τ ∧
      (∀ t : ℝ, ComplementSafe v p ((1 : ℝ) / 6) t →
        circleNorm (t * (v p : ℝ)) ≤ circleNorm (τ * (v p : ℝ))) ∧
      0 < Int.fract (τ * (v p : ℝ)) ∧
      Int.fract (τ * (v p : ℝ)) < (1 : ℝ) / 6 ∧
      Int.fract (τ * (v p : ℝ)) = circleNorm (τ * (v p : ℝ)) ∧
      ∃ r, r ≠ p ∧ Int.fract (τ * (v r : ℝ)) = (5 : ℝ) / 6 := by
  let old : Fin 4 → ℕ := fun j => v (p.succAbove j)
  have holdpos : ∀ j, 0 < old j := fun j => hpos _
  obtain ⟨s, hspos, hs⟩ := fourMovingNaturalRunners old holdpos
  have hstrict : ∃ s : ℝ, ∀ j, j ≠ p →
      (1 : ℝ) / 6 < circleNorm (s * (v j : ℝ)) := by
    refine ⟨s, ?_⟩
    intro j hj
    obtain ⟨k, rfl⟩ := Fin.exists_succAbove_eq hj
    exact lt_of_lt_of_le (by norm_num) (hs k)
  obtain ⟨τ, hτ0, hτ1, hsafe, hmax, hfractpos, hfractlt, hfract,
    r, hrp, hrface⟩ := exists_oriented_complement_maximizer v p hpos
      ((1 : ℝ) / 6) (by norm_num) (by norm_num) hstrict hno
  refine ⟨τ, hτ0, hτ1, hsafe, hmax, hfractpos, hfractlt, hfract, r, hrp, ?_⟩
  norm_num at hrface ⊢
  linarith

end LonelyRunner
