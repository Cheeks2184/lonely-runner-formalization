import LonelyRunner.SeparatedPhaseFamily
import LonelyRunner.ThirdShiftSpacing
import LonelyRunner.ModularCertificates

/-!
# A common third shift for at most two exceptions

Each exceptional label forbids at most one shift, so their finite union
cannot cover all three candidates when there are at most two labels.
-/

namespace LonelyRunner

theorem exists_third_shift_safe_nondivisible_family {ι : Type*} [Fintype ι]
    (x : ι → ℝ) (d : ι → ℕ)
    (hnot : ∀ i, ¬ 3 ∣ d i) (hcard : Fintype.card ι ≤ 2) :
    ∃ k : Fin 3, ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm
        (x i + (k.val : ℝ) * (d i : ℝ) / 3) := by
  classical
  let R : Finset (Fin 3) := Finset.univ
  let B : ι → Finset (Fin 3) := fun i =>
    Finset.univ.filter (fun k =>
      circleNorm (x i + (k.val : ℝ) * (d i : ℝ) / 3) < (1 : ℝ) / 6)
  have hBsubset : ∀ i, B i ⊆ R := by
    intro i k _
    exact Finset.mem_univ k
  have hBcard : ∀ i, (B i).card ≤ 1 := by
    intro i
    apply Finset.card_le_one.mpr
    intro k hk l hl
    have hsep : ∀ k l : Fin 3, k ≠ l →
        2 * ((1 : ℝ) / 6) ≤ circleNorm
          ((x i + (k.val : ℝ) * (d i : ℝ) / 3) -
            (x i + (l.val : ℝ) * (d i : ℝ) / 3)) := by
      intro k l hkl
      have hthird := circleNorm_third_shift_sub_ge (x i) (d i) (hnot i) k l hkl
      nlinarith [hthird]
    have hsub := circleNorm_bad_subsingleton_of_separated
      (fun k : Fin 3 => x i + (k.val : ℝ) * (d i : ℝ) / 3)
      ((1 : ℝ) / 6) hsep
    apply hsub
    · simpa [B] using (Finset.mem_filter.mp hk).2
    · simpa [B] using (Finset.mem_filter.mp hl).2
  have hsum : Finset.univ.sum (fun i => (B i).card) < R.card := by
    calc
      Finset.univ.sum (fun i => (B i).card) ≤ Finset.univ.sum (fun _ => 1) :=
        Finset.sum_le_sum fun i _ => hBcard i
      _ = Fintype.card ι := by simp
      _ ≤ 2 := hcard
      _ < R.card := by simp [R]
  obtain ⟨k, _hkR, hkavoid⟩ :=
    exists_mem_avoiding_of_sum_card_lt_card R B hBsubset hsum
  refine ⟨k, ?_⟩
  intro i
  apply le_of_not_gt
  intro hbad
  apply hkavoid i
  exact Finset.mem_filter.mpr ⟨Finset.mem_univ _, hbad⟩

end LonelyRunner
