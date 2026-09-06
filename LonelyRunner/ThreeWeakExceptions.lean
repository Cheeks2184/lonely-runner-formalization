import LonelyRunner.NonzeroThirdShift
import LonelyRunner.RationalShiftOrbits
import Mathlib.Tactic

namespace LonelyRunner

/-- Three weakly bad nondivisible labels leave at most one further exception.
Both nonzero third shifts rescue the three; one of them rescues the last label
as well, while the divisible pivot keeps its original safe phase. -/
theorem third_shift_of_three_weak_exceptions
    (v : Fin 5 → ℕ) (p : Fin 5)
    (hdiv : 3 ∣ v p) (hother : ∀ i, i ≠ p → ¬ 3 ∣ v i)
    (t : ℝ) (hp : (1 : ℝ) / 6 ≤ circleNorm (t * (v p : ℝ)))
    (hbad : 3 ≤ ((Finset.univ : Finset (Fin 5)).filter
      (fun i => i ≠ p ∧ circleNorm (t * (v i : ℝ)) ≤ (1 : ℝ) / 6)).card) :
    ∃ k : Fin 3, ∀ i, (1 : ℝ) / 6 ≤ circleNorm
      ((t + (k.val : ℝ) / 3) * (v i : ℝ)) := by
  classical
  let E : Finset (Fin 5) := Finset.univ.erase p
  let B : Finset (Fin 5) := Finset.univ.filter
    (fun i => i ≠ p ∧ circleNorm (t * (v i : ℝ)) ≤ (1 : ℝ) / 6)
  let C : Finset (Fin 5) := E \ B
  have hBE : B ⊆ E := by
    intro i hi
    exact Finset.mem_erase.mpr ⟨(Finset.mem_filter.mp hi).2.1, Finset.mem_univ _⟩
  have hEcard : E.card = 4 := by simp [E]
  have hBcard : 3 ≤ B.card := hbad
  have hCcard : C.card ≤ 1 := by
    have hc : C.card = E.card - B.card := Finset.card_sdiff_of_subset hBE
    omega
  -- Choose one common shift using the sole possible label outside the bad set.
  have hchoose : ∃ k : Fin 3, k ≠ 0 ∧ ∀ i ∈ C,
      (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ) + (k.val : ℝ) * (v i : ℝ) / 3) := by
    by_cases hne : C.Nonempty
    · obtain ⟨q, hq⟩ := hne
      have hqp : q ≠ p := (Finset.mem_erase.mp (Finset.mem_sdiff.mp hq).1).1
      obtain ⟨k, hk, hsafe⟩ := exists_nonzero_third_shift_safe
        (t * (v q : ℝ)) (v q) (hother q hqp)
      refine ⟨k, hk, ?_⟩
      intro i hi
      have hiq : i = q := Finset.card_le_one.mp hCcard i hi q hq
      simpa only [hiq] using hsafe
    · refine ⟨1, by decide, ?_⟩
      intro i hi
      exact (hne ⟨i, hi⟩).elim
  obtain ⟨k, hk, hsafe⟩ := hchoose
  refine ⟨k, ?_⟩
  intro i
  by_cases hip : i = p
  · subst i
    have hpres := circleNorm_time_add_nat_div_of_dvd 3 (v p) k.val (by decide) hdiv t
    norm_num only [Nat.cast_ofNat] at hpres
    rw [hpres]
    exact hp
  · have hphase : (t + (k.val : ℝ) / 3) * (v i : ℝ) =
        t * (v i : ℝ) + (k.val : ℝ) * (v i : ℝ) / 3 := by ring
    rw [hphase]
    by_cases hiB : i ∈ B
    · exact third_shift_safe_of_weak_bad (t * (v i : ℝ)) (v i)
        (hother i hip) (Finset.mem_filter.mp hiB).2.2 k hk
    · exact hsafe i (Finset.mem_sdiff.mpr ⟨Finset.mem_erase.mpr
        ⟨hip, Finset.mem_univ _⟩, hiB⟩)

end LonelyRunner
