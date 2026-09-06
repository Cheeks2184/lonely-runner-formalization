import LonelyRunner.RationalShiftInsertion
import LonelyRunner.SmallDenominatorWitness
import Mathlib.Algebra.GCDMonoid.Finset

/-!
# Divisor counts under a missing sixth-margin witness

The upper bound uses the four-divisible reciprocal shift.  The lower bound is
the independent small-denominator obstruction.
-/

namespace LonelyRunner

theorem primitive_no_sixth_witness_divisor_count_le_three
    (v : Fin 5 → ℕ) (hpos : ∀ i, 0 < v i)
    (hprimitive : Finset.univ.gcd v = 1)
    (hno : ¬ ∃ t : ℝ, ∀ i, (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ)))
    (ell : ℕ) (hell : 2 ≤ ell) :
    ((Finset.univ : Finset (Fin 5)).filter (fun i => ell ∣ v i)).card ≤ 3 := by
  classical
  let S : Finset (Fin 5) := Finset.univ.filter (fun i => ell ∣ v i)
  obtain ⟨p, hnotp⟩ : ∃ p : Fin 5, ¬ ell ∣ v p := by
    by_contra hnone
    push Not at hnone
    have hdvd : ell ∣ Finset.univ.gcd v :=
      Finset.dvd_gcd fun i _ => hnone i
    rw [hprimitive] at hdvd
    have hellone : ell = 1 := Nat.dvd_one.mp hdvd
    omega
  by_contra hbound
  have hfour : 4 ≤ S.card := by
    dsimp [S] at hbound ⊢
    omega
  have hsubset : S ⊆ (Finset.univ : Finset (Fin 5)).erase p := by
    intro i hi
    have hdivi : ell ∣ v i := (Finset.mem_filter.mp hi).2
    refine Finset.mem_erase.mpr ⟨?_, Finset.mem_univ _⟩
    intro hip
    subst i
    exact hnotp hdivi
  have hcarderase : ((Finset.univ : Finset (Fin 5)).erase p).card = 4 := by
    simp
  have heq : S = (Finset.univ : Finset (Fin 5)).erase p := by
    apply Finset.eq_of_subset_of_card_le hsubset
    rw [hcarderase]
    exact hfour
  have hdiv : ∀ i, i ≠ p → ell ∣ v i := by
    intro i hip
    have hiS : i ∈ S := by
      rw [heq]
      exact Finset.mem_erase.mpr ⟨hip, Finset.mem_univ _⟩
    exact (Finset.mem_filter.mp hiS).2
  obtain ⟨t, _htpos, ht⟩ :=
    fiveMovingNaturalRunners_of_four_divisible v hpos ell hell p hnotp hdiv
  exact hno ⟨t, ht⟩

theorem six_total_divisor_count_bounds
    (v : Fin 5 → ℕ) (hpos : ∀ i, 0 < v i)
    (hprimitive : Finset.univ.gcd v = 1)
    (hno : ¬ ∃ t : ℝ, ∀ i, (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ)))
    (ell : ℕ) (hell : 2 ≤ ell) (hell6 : ell ≤ 6) :
    1 ≤ ((Finset.univ : Finset (Fin 5)).filter (fun i => ell ∣ v i)).card ∧
    ((Finset.univ : Finset (Fin 5)).filter (fun i => ell ∣ v i)).card ≤ 3 := by
  constructor
  · obtain ⟨i, hi⟩ := divisor_cover_of_no_small_witness v (N := 6) (by decide)
      (by simpa [one_div] using hno) ell hell hell6
    apply Finset.one_le_card.mpr
    exact ⟨i, Finset.mem_filter.mpr ⟨Finset.mem_univ _, hi⟩⟩
  · exact primitive_no_sixth_witness_divisor_count_le_three
      v hpos hprimitive hno ell hell

end LonelyRunner
