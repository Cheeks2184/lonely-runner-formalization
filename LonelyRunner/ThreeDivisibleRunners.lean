import LonelyRunner.ThirdShiftSeed
import LonelyRunner.FiveRunnerOrdinary
import Mathlib.Algebra.GCDMonoid.Finset

/-!
# Positive five-speed witnesses from three-divisible labels

Three or four labels divisible by three provide a four-label fifth-margin
seed; the remaining at-most-two labels are handled by one common third shift.
-/

namespace LonelyRunner

theorem fiveMovingNaturalRunners_of_three_or_four_divisible_three
    (v : Fin 5 → ℕ) (hpos : ∀ i, 0 < v i)
    (hlower : 3 ≤
      ((Finset.univ : Finset (Fin 5)).filter (fun i => 3 ∣ v i)).card)
    (hupper :
      ((Finset.univ : Finset (Fin 5)).filter (fun i => 3 ∣ v i)).card ≤ 4) :
    ∃ t : ℝ, 0 < t ∧ ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ)) := by
  classical
  let S : Finset (Fin 5) := Finset.univ.filter (fun i => 3 ∣ v i)
  have hSlt : S.card < (Finset.univ : Finset (Fin 5)).card := by
    dsimp [S]
    simp only [Fintype.card_fin]
    exact lt_of_le_of_lt hupper (by decide)
  obtain ⟨p, _hpU, hpS⟩ := Finset.exists_mem_notMem_of_card_lt_card hSlt
  have hnotp : ¬ 3 ∣ v p := by
    intro hp
    apply hpS
    exact Finset.mem_filter.mpr ⟨Finset.mem_univ _, hp⟩
  let old : Fin 4 → ℕ := fun j => v (p.succAbove j)
  have holdpos : ∀ j, 0 < old j := fun j => hpos _
  obtain ⟨t₀, ht₀, hold⟩ := fourMovingNaturalRunners old holdpos
  have hseed : ∀ i, 3 ∣ v i →
      (1 : ℝ) / 6 ≤ circleNorm (t₀ * (v i : ℝ)) := by
    intro i hdiv
    have hip : i ≠ p := by
      intro hip
      subst i
      exact hnotp hdiv
    obtain ⟨j, hj⟩ := Fin.exists_succAbove_eq hip
    subst i
    exact le_trans (by norm_num : (1 : ℝ) / 6 ≤ (5 : ℝ)⁻¹) (hold j)
  let E : Finset (Fin 5) := Finset.univ.filter (fun i => ¬ 3 ∣ v i)
  have hsplit := Finset.card_filter_add_card_filter_not
    (s := (Finset.univ : Finset (Fin 5))) (p := fun i => 3 ∣ v i)
  have hEcard : E.card ≤ 2 := by
    dsimp [S, E]
    simp only [Finset.card_univ, Fintype.card_fin] at hsplit
    omega
  obtain ⟨k, hk⟩ := exists_third_shift_of_seeded_divisible v t₀ hseed hEcard
  refine ⟨t₀ + (k.val : ℝ) / 3, by positivity, ?_⟩
  exact hk

theorem fiveMovingNaturalRunners_of_primitive_three_divisible_three
    (v : Fin 5 → ℕ) (hpos : ∀ i, 0 < v i)
    (hprimitive : Finset.univ.gcd v = 1)
    (hthree : 3 ≤
      ((Finset.univ : Finset (Fin 5)).filter (fun i => 3 ∣ v i)).card) :
    ∃ t : ℝ, 0 < t ∧ ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ)) := by
  classical
  let S : Finset (Fin 5) := Finset.univ.filter (fun i => 3 ∣ v i)
  obtain ⟨p, hnotp⟩ : ∃ p : Fin 5, ¬ 3 ∣ v p := by
    by_contra hnone
    push Not at hnone
    have hdvd : 3 ∣ Finset.univ.gcd v :=
      Finset.dvd_gcd fun i _ => hnone i
    rw [hprimitive] at hdvd
    norm_num at hdvd
  have hsubset : S ⊆ (Finset.univ : Finset (Fin 5)).erase p := by
    intro i hi
    have hdiv : 3 ∣ v i := (Finset.mem_filter.mp hi).2
    refine Finset.mem_erase.mpr ⟨?_, Finset.mem_univ _⟩
    intro hip
    subst i
    exact hnotp hdiv
  have hupper : S.card ≤ 4 := by
    calc
      S.card ≤ ((Finset.univ : Finset (Fin 5)).erase p).card :=
        Finset.card_le_card hsubset
      _ = 4 := by simp
  apply fiveMovingNaturalRunners_of_three_or_four_divisible_three v hpos
  · simpa [S] using hthree
  · simpa [S] using hupper

end LonelyRunner
