import LonelyRunner.FiveRunnerOrdinary
import LonelyRunner.FastRunnerInsertion
import Mathlib.Tactic

namespace LonelyRunner

/-- A speed at least five times every other labelled speed can be inserted
into a four-runner fifth-margin witness, yielding the closed sixth margin. -/
theorem fiveMovingNaturalRunners_of_fast_speed (v : Fin 5 → ℕ)
    (hpos : ∀ i, 0 < v i) (p : Fin 5)
    (hfast : ∀ i, i ≠ p → 5 * v i ≤ v p) :
    ∃ t : ℝ, 0 < t ∧ ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ)) := by
  let old : Fin 4 → Nat := fun i => v (p.succAbove i)
  have holdpos : ∀ i, 0 < old i := fun i => hpos _
  obtain ⟨t₀, _ht₀, hold⟩ := fourMovingNaturalRunners old holdpos
  have hpne : (v p : ℝ) ≠ 0 := by exact_mod_cast (hpos p).ne'
  have hfastR : ∀ i : Fin 4, (5 : ℝ) * |(old i : ℝ)| ≤ |(v p : ℝ)| := by
    intro i
    have hne : p.succAbove i ≠ p := Fin.succAbove_ne p i
    have h := hfast (p.succAbove i) hne
    have hcast : (5 : ℝ) * (old i : ℝ) ≤ (v p : ℝ) := by exact_mod_cast h
    rw [abs_of_nonneg (by positivity), abs_of_nonneg (by positivity)]
    exact hcast
  obtain ⟨u, _huclose, hpbound, hother⟩ :=
    fastRunnerInsertion (fun i : Fin 4 => (old i : ℝ)) t₀ (v p : ℝ) hold hpne hfastR
  have huzero : u ≠ 0 := by
    intro hu
    have : circleNorm (u * (v p : ℝ)) = 0 := by simp [hu, circleNorm]
    rw [this] at hpbound
    norm_num at hpbound
  rcases lt_or_gt_of_ne huzero with hu | hu
  · refine ⟨-u, neg_pos.mpr hu, ?_⟩
    intro i
    by_cases hip : i = p
    · subst i
      rw [show (-u) * (v p : ℝ) = -(u * (v p : ℝ)) by ring, circleNorm_neg]
      simpa [one_div] using hpbound
    · obtain ⟨j, rfl⟩ := Fin.exists_succAbove_eq hip
      rw [show (-u) * (old j : ℝ) = -(u * (old j : ℝ)) by ring, circleNorm_neg]
      simpa [one_div] using hother j
  · refine ⟨u, hu, ?_⟩
    intro i
    by_cases hip : i = p
    · subst i
      simpa [one_div] using hpbound
    · obtain ⟨j, rfl⟩ := Fin.exists_succAbove_eq hip
      simpa [old, one_div] using hother j

end LonelyRunner
