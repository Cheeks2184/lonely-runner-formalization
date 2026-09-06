import LonelyRunner.RationalShiftGcd
import LonelyRunner.FiveRunnerOrdinary

/-!
# Reciprocal-divisor shifts with one exceptional speed

The rational shift supplies a quarter-margin for the exceptional coordinate
while retaining exact circle norms for every coordinate divisible by the
denominator.
-/

namespace LonelyRunner

theorem exists_nat_shift_preserving_divisible_family {ι : Type*}
    (v : ι → ℕ) (ell d : ℕ) (hell : 2 ≤ ell) (hnot : ¬ ell ∣ d)
    (hdiv : ∀ i, ell ∣ v i) (t : ℝ) :
    ∃ k : ℕ, k < ell ∧
      (1 : ℝ) / 4 ≤ circleNorm ((t + (k : ℝ) / (ell : ℝ)) * (d : ℝ)) ∧
      ∀ i, circleNorm ((t + (k : ℝ) / (ell : ℝ)) * (v i : ℝ)) =
        circleNorm (t * (v i : ℝ)) := by
  obtain ⟨k, hk, hquarter⟩ :=
    exists_nat_rational_shift_circleNorm_ge_quarter ell d hell hnot
      (t * (d : ℝ))
  refine ⟨k, hk, ?_, ?_⟩
  · have hphase : (t + (k : ℝ) / (ell : ℝ)) * (d : ℝ) =
        t * (d : ℝ) + (k : ℝ) * (d : ℝ) / (ell : ℝ) := by
      ring
    rw [hphase]
    exact hquarter
  · intro i
    exact circleNorm_time_add_nat_div_of_dvd ell (v i) k (by omega) (hdiv i) t

theorem fiveMovingNaturalRunners_of_four_divisible
    (v : Fin 5 → ℕ) (hpos : ∀ i, 0 < v i)
    (ell : ℕ) (hell : 2 ≤ ell) (p : Fin 5)
    (hnot : ¬ ell ∣ v p) (hdiv : ∀ i, i ≠ p → ell ∣ v i) :
    ∃ t : ℝ, 0 < t ∧ ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ)) := by
  let old : Fin 4 → ℕ := fun j => v (p.succAbove j)
  have holdpos : ∀ j, 0 < old j := by
    intro j
    exact hpos _
  obtain ⟨t₀, ht₀, hold⟩ := fourMovingNaturalRunners old holdpos
  obtain ⟨k, hk, hquarter, hpreserve⟩ :=
    exists_nat_shift_preserving_divisible_family old ell (v p) hell hnot
      (by
        intro j
        exact hdiv _ (Fin.succAbove_ne p j)) t₀
  have hellpos : 0 < ell := by omega
  refine ⟨t₀ + (k : ℝ) / (ell : ℝ), by positivity, ?_⟩
  intro i
  by_cases hip : i = p
  · subst i
    exact le_trans (by norm_num : (1 : ℝ) / 6 ≤ (1 : ℝ) / 4) hquarter
  · obtain ⟨j, hj⟩ := Fin.exists_succAbove_eq hip
    subst i
    calc
      (1 : ℝ) / 6 ≤ (5 : ℝ)⁻¹ := by norm_num
      _ ≤ circleNorm (t₀ * (old j : ℝ)) := hold j
      _ = circleNorm ((t₀ + (k : ℝ) / (ell : ℝ)) *
          (v (p.succAbove j) : ℝ)) := (hpreserve j).symm

end LonelyRunner
