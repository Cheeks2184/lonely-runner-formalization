import LonelyRunner.ThirdShiftSeed
import LonelyRunner.ThirdShiftCollision
import Mathlib.Data.Fintype.Card

/-!
# Seeded third-shift rescue adapters

Divisible labels retain their seed at every third shift. A collision of two
bad exceptional labels, or one exception safe at every shift, reduces the
remaining constraints to the checked common-shift lemmas.
-/

namespace LonelyRunner

/-- Two distinct bad labels share their only forbidden shift. -/
theorem exists_third_shift_of_two_bad_seeded_divisible
    (v : Fin 5 → ℕ) (t : ℝ)
    (hseed : ∀ i, 3 ∣ v i →
      (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ)))
    (hexceptions :
      ((Finset.univ : Finset (Fin 5)).filter (fun i => ¬ 3 ∣ v i)).card ≤ 3)
    (u w : Fin 5) (huw : u ≠ w)
    (hu : circleNorm (t * (v u : ℝ)) < (1 : ℝ) / 6)
    (hw : circleNorm (t * (v w : ℝ)) < (1 : ℝ) / 6) :
    ∃ k : Fin 3, ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm
        ((t + (k.val : ℝ) / 3) * (v i : ℝ)) := by
  classical
  let E : Finset (Fin 5) := Finset.univ.filter (fun i => ¬ 3 ∣ v i)
  let X := {i : Fin 5 // i ∈ E}
  have hXcard : Fintype.card X ≤ 3 := by
    simpa only [X, Fintype.card_coe] using hexceptions
  have huND : ¬ 3 ∣ v u := by
    intro hdiv
    exact (not_le_of_gt hu) (hseed u hdiv)
  have hwND : ¬ 3 ∣ v w := by
    intro hdiv
    exact (not_le_of_gt hw) (hseed w hdiv)
  let uX : X := ⟨u, Finset.mem_filter.mpr ⟨Finset.mem_univ _, huND⟩⟩
  let wX : X := ⟨w, Finset.mem_filter.mpr ⟨Finset.mem_univ _, hwND⟩⟩
  have huXwX : uX ≠ wX := by
    intro h
    apply huw
    exact congrArg Subtype.val h
  obtain ⟨k, hk⟩ := exists_third_shift_safe_of_two_bad
    (fun i : X => t * (v i.val : ℝ)) (fun i : X => v i.val)
    (fun i => (Finset.mem_filter.mp i.property).2) hXcard uX wX huXwX
    (by simpa [uX] using hu) (by simpa [wX] using hw)
  refine ⟨k, ?_⟩
  intro i
  by_cases hdiv : 3 ∣ v i
  · have hpres := circleNorm_time_add_nat_div_of_dvd 3 (v i) k.val (by decide) hdiv t
    norm_num only [Nat.cast_ofNat] at hpres
    rw [hpres]
    exact hseed i hdiv
  · let iX : X := ⟨i, Finset.mem_filter.mpr ⟨Finset.mem_univ _, hdiv⟩⟩
    have hphase : (t + (k.val : ℝ) / 3) * (v i : ℝ) =
        t * (v iX.val : ℝ) + (k.val : ℝ) * (v iX.val : ℝ) / 3 := by
      dsimp [iX]
      ring
    rw [hphase]
    exact hk iX

/-- An exceptional label safe at every shift can be removed from avoidance. -/
theorem exists_third_shift_of_safe_exception_seeded_divisible
    (v : Fin 5 → ℕ) (t : ℝ)
    (hseed : ∀ i, 3 ∣ v i →
      (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ)))
    (hexceptions :
      ((Finset.univ : Finset (Fin 5)).filter (fun i => ¬ 3 ∣ v i)).card ≤ 3)
    (r : Fin 5) (hr : ¬ 3 ∣ v r)
    (hsafe : ∀ k : Fin 3,
      (1 : ℝ) / 6 ≤ circleNorm
        ((t + (k.val : ℝ) / 3) * (v r : ℝ))) :
    ∃ k : Fin 3, ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm
        ((t + (k.val : ℝ) / 3) * (v i : ℝ)) := by
  classical
  let E : Finset (Fin 5) := Finset.univ.filter (fun i => ¬ 3 ∣ v i)
  let X := {i : Fin 5 // i ∈ E}
  have hXcard : Fintype.card X ≤ 3 := by
    simpa only [X, Fintype.card_coe] using hexceptions
  let rX : X := ⟨r, Finset.mem_filter.mpr ⟨Finset.mem_univ _, hr⟩⟩
  let Y := {i : X // i.val ≠ r}
  have hYcard : Fintype.card Y ≤ 2 := by
    have hlt : Fintype.card Y < Fintype.card X :=
      Fintype.card_subtype_lt (by simp [rX] : ¬ (rX.val ≠ r))
    omega
  obtain ⟨k, hk⟩ := exists_third_shift_safe_nondivisible_family
    (fun i : Y => t * (v i.val.val : ℝ)) (fun i : Y => v i.val.val)
    (fun i => (Finset.mem_filter.mp i.val.property).2) hYcard
  refine ⟨k, ?_⟩
  intro i
  by_cases hdiv : 3 ∣ v i
  · have hpres := circleNorm_time_add_nat_div_of_dvd 3 (v i) k.val (by decide) hdiv t
    norm_num only [Nat.cast_ofNat] at hpres
    rw [hpres]
    exact hseed i hdiv
  · by_cases hir : i = r
    · subst i
      exact hsafe k
    · let iX : X := ⟨i, Finset.mem_filter.mpr ⟨Finset.mem_univ _, hdiv⟩⟩
      let iY : Y := ⟨iX, by simpa [iX] using hir⟩
      have hphase : (t + (k.val : ℝ) / 3) * (v i : ℝ) =
          t * (v iY.val.val : ℝ) + (k.val : ℝ) * (v iY.val.val : ℝ) / 3 := by
        dsimp [iY, iX]
        ring
      rw [hphase]
      exact hk iY

end LonelyRunner
