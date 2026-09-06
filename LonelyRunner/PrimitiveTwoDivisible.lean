import LonelyRunner.SixTotalDivisorCounts
import LonelyRunner.TwoDivisibleBoundary
import LonelyRunner.BoundaryZeroDivisibility
import LonelyRunner.TwoDivisibleCover

/-!
# Primitive two-divisible configurations

Divisor counts provide the two auxiliary parity and six-divisibility inputs;
the boundary-zero divisibility alternative is then exactly the supplied cover.
-/

namespace LonelyRunner

theorem primitive_two_divisible_no_witness_contradiction
    (v : Fin 5 → ℕ) (hpos : ∀ i, 0 < v i)
    (hprimitive : Finset.univ.gcd v = 1)
    (htwo : ((Finset.univ : Finset (Fin 5)).filter (fun i => 3 ∣ v i)).card = 2)
    (hno : ¬ ∃ t : ℝ, ∀ i, (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ))) : False := by
  classical
  let S : Finset (Fin 5) := Finset.univ.filter (fun i => 3 ∣ v i)
  obtain ⟨p, q, hpq, hS⟩ := Finset.card_eq_two.mp (by simpa [S] using htwo)
  change S = {p, q} at hS
  have hdiv : ∀ i, 3 ∣ v i ↔ i = p ∨ i = q := by
    intro i
    constructor
    · intro hi
      have himem : i ∈ S := Finset.mem_filter.mpr ⟨Finset.mem_univ _, hi⟩
      rw [hS] at himem
      simpa using himem
    · intro hi
      have himem : i ∈ S := by
        rw [hS]
        simpa using hi
      exact (Finset.mem_filter.mp himem).2
  have h6bounds := six_total_divisor_count_bounds v hpos hprimitive hno 6 (by omega) (by omega)
  obtain ⟨i, hi⟩ := Finset.one_le_card.mp h6bounds.1
  have hi6 : 6 ∣ v i := (Finset.mem_filter.mp hi).2
  have hsix : 6 ∣ v p ∨ 6 ∣ v q := by
    rcases (hdiv i).mp (dvd_trans (by norm_num : 3 ∣ 6) hi6) with rfl | rfl
    · exact Or.inl hi6
    · exact Or.inr hi6
  have h2bounds := six_total_divisor_count_bounds v hpos hprimitive hno 2 (by omega) (by omega)
  have heven : ((Finset.univ : Finset (Fin 5)).filter (fun i => 2 ∣ v i)).card ≤ 3 :=
    h2bounds.2
  have hcover : ∀ r, r ≠ p → r ≠ q → 6 * v r ∣ v p ∨ 6 * v r ∣ v q := by
    intro r hrp hrq
    apply dvd_or_dvd_of_five_sixths_pair_zero (v p) (v q) (v r) (hpos r)
    intro t ht
    exact two_divisible_boundary_min_eq_zero v hpos p q r hpq hrp hrq
      hdiv hsix heven hno t ht
  obtain ⟨t, htpos, ht⟩ := fiveMovingNaturalRunners_of_two_divisible_cover
    v hpos p q hpq hdiv hcover
  exact hno ⟨t, ht⟩

theorem fiveMovingNaturalRunners_of_primitive_two_divisible_three
    (v : Fin 5 → ℕ) (hpos : ∀ i, 0 < v i)
    (hprimitive : Finset.univ.gcd v = 1)
    (htwo : ((Finset.univ : Finset (Fin 5)).filter (fun i => 3 ∣ v i)).card = 2) :
    ∃ t : ℝ, 0 < t ∧ ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ)) := by
  by_contra hpositive
  apply primitive_two_divisible_no_witness_contradiction v hpos hprimitive htwo
  intro hall
  rcases hall with ⟨t, ht⟩
  apply hpositive
  refine ⟨Int.fract t + 1, ?_, ?_⟩
  · have hfract : 0 ≤ Int.fract t := Int.fract_nonneg t
    linarith
  · intro i
    rw [show (Int.fract t + 1) * (v i : ℝ) =
        ((v i : ℤ) : ℝ) + Int.fract t * (v i : ℝ) by push_cast; ring,
      circleNorm_add_int]
    simpa only [circleNorm_fract_mul_nat] using ht i

end LonelyRunner
