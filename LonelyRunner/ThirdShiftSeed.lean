import LonelyRunner.ThirdShiftExceptions
import LonelyRunner.RationalShiftOrbits
import Mathlib.Tactic

namespace LonelyRunner

/-- A single third-grid shift preserves every seeded divisible label and is
simultaneously safe for up to two nondivisible exceptional labels. -/
theorem exists_third_shift_of_seeded_divisible
    (v : Fin 5 → ℕ) (t₀ : ℝ)
    (hseed : ∀ i, 3 ∣ v i →
      (1 : ℝ) / 6 ≤ circleNorm (t₀ * (v i : ℝ)))
    (hexceptions :
      ((Finset.univ : Finset (Fin 5)).filter
        (fun i => ¬ 3 ∣ v i)).card ≤ 2) :
    ∃ k : Fin 3, ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm
        ((t₀ + (k.val : ℝ) / 3) * (v i : ℝ)) := by
  classical
  let E : Finset (Fin 5) := Finset.univ.filter (fun i => ¬ 3 ∣ v i)
  let X := {i : Fin 5 // i ∈ E}
  have hcard : Fintype.card X ≤ 2 := by
    simpa only [X, Fintype.card_coe] using hexceptions
  have hnot : ∀ i : X, ¬ 3 ∣ v i.val := by
    intro i
    exact (Finset.mem_filter.mp i.property).2
  obtain ⟨k, hk⟩ := exists_third_shift_safe_nondivisible_family
    (fun i : X => t₀ * (v i.val : ℝ)) (fun i : X => v i.val) hnot hcard
  refine ⟨k, ?_⟩
  intro i
  by_cases hdiv : 3 ∣ v i
  · have hpres := circleNorm_time_add_nat_div_of_dvd 3 (v i) k.val (by decide) hdiv t₀
    norm_num only [Nat.cast_ofNat] at hpres
    rw [hpres]
    exact hseed i hdiv
  · let j : X := ⟨i, by
      apply Finset.mem_filter.mpr
      exact ⟨Finset.mem_univ _, hdiv⟩⟩
    have hphase :
        (t₀ + (k.val : ℝ) / 3) * (v i : ℝ) =
          t₀ * (v j.val : ℝ) + (k.val : ℝ) * (v j.val : ℝ) / 3 := by
      dsimp [j]
      ring
    rw [hphase]
    exact hk j

end LonelyRunner
