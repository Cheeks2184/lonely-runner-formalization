import LonelyRunner.ThirdShiftExceptions
import Mathlib.Data.Fintype.Card

/-!
# Third-shift collision rescue

When two distinct labels are already bad at the zero shift, dropping either
one leaves at most two labels for the finite avoidance theorem.  The other
bad label then forces the selected shift away from zero, which protects the
dropped label as well.
-/

namespace LonelyRunner

theorem exists_third_shift_safe_of_two_bad {ι : Type*} [Fintype ι]
    (x : ι → ℝ) (d : ι → ℕ) (hnot : ∀ i, ¬ 3 ∣ d i)
    (hcard : Fintype.card ι ≤ 3) (p q : ι) (hpq : p ≠ q)
    (hp : circleNorm (x p) < (1 : ℝ) / 6)
    (hq : circleNorm (x q) < (1 : ℝ) / 6) :
    ∃ k : Fin 3, ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm
        (x i + (k.val : ℝ) * (d i : ℝ) / 3) := by
  classical
  let J := {i : ι // i ≠ p}
  have hJcard : Fintype.card J ≤ 2 := by
    have hlt : Fintype.card J < Fintype.card ι :=
      Fintype.card_subtype_lt (by simp : ¬ (p ≠ p))
    omega
  obtain ⟨k, hk⟩ := exists_third_shift_safe_nondivisible_family
    (fun i : J => x i) (fun i : J => d i) (fun i => hnot i) hJcard
  let qJ : J := ⟨q, hpq.symm⟩
  have hkq : (1 : ℝ) / 6 ≤ circleNorm
      (x q + (k.val : ℝ) * (d q : ℝ) / 3) := by
    simpa [qJ] using hk qJ
  have hkne : k ≠ 0 := by
    intro hkzero
    subst k
    norm_num at hkq
    exact (not_le_of_gt hq) hkq
  have hsep : ∀ u v : Fin 3, u ≠ v →
      2 * ((1 : ℝ) / 6) ≤ circleNorm
        ((x p + (u.val : ℝ) * (d p : ℝ) / 3) -
          (x p + (v.val : ℝ) * (d p : ℝ) / 3)) := by
    intro u v huv
    have hthird := circleNorm_third_shift_sub_ge (x p) (d p) (hnot p) u v huv
    nlinarith [hthird]
  have hsub := circleNorm_bad_subsingleton_of_separated
    (fun u : Fin 3 => x p + (u.val : ℝ) * (d p : ℝ) / 3)
    ((1 : ℝ) / 6) hsep
  have hkp : (1 : ℝ) / 6 ≤ circleNorm
      (x p + (k.val : ℝ) * (d p : ℝ) / 3) := by
    apply le_of_not_gt
    intro hkbad
    have hzero : circleNorm
        (x p + ((0 : Fin 3).val : ℝ) * (d p : ℝ) / 3) < (1 : ℝ) / 6 := by
      simpa using hp
    have hkeq : k = 0 := hsub hkbad hzero
    exact hkne hkeq
  refine ⟨k, ?_⟩
  intro i
  by_cases hip : i = p
  · subst i
    exact hkp
  · exact hk ⟨i, hip⟩

end LonelyRunner
