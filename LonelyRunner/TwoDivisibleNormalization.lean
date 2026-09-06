import LonelyRunner.PrimitiveTwoDivisible
import LonelyRunner.ThreeDivisibleRunners
import Mathlib.Algebra.GCDMonoid.Finset

/-!
# Two-divisible normalization

Primitivity permits combining the two-label and at-least-three-label branches.
For an unnormalized family, the exact count of two prevents the common gcd
from being divisible by three, so division preserves that exact count.
-/

namespace LonelyRunner

theorem fiveMovingNaturalRunners_of_primitive_at_least_two_divisible_three
    (v : Fin 5 → ℕ) (hpos : ∀ i, 0 < v i)
    (hprimitive : Finset.univ.gcd v = 1)
    (hlower : 2 ≤ ((Finset.univ : Finset (Fin 5)).filter (fun i => 3 ∣ v i)).card) :
    ∃ t : ℝ, 0 < t ∧ ∀ i, (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ)) := by
  by_cases htwo : ((Finset.univ : Finset (Fin 5)).filter (fun i => 3 ∣ v i)).card = 2
  · exact fiveMovingNaturalRunners_of_primitive_two_divisible_three v hpos hprimitive htwo
  · have hthree : 3 ≤ ((Finset.univ : Finset (Fin 5)).filter (fun i => 3 ∣ v i)).card := by omega
    exact fiveMovingNaturalRunners_of_primitive_three_divisible_three v hpos hprimitive hthree

theorem fiveMovingNaturalRunners_of_exactly_two_divisible_three
    (v : Fin 5 → ℕ) (hpos : ∀ i, 0 < v i)
    (htwo : ((Finset.univ : Finset (Fin 5)).filter (fun i => 3 ∣ v i)).card = 2) :
    ∃ t : ℝ, 0 < t ∧ ∀ i, (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ)) := by
  classical
  let g : ℕ := Finset.univ.gcd v
  have hgdvd (i : Fin 5) : g ∣ v i := Finset.gcd_dvd (Finset.mem_univ i)
  have hgpos : 0 < g := by
    apply Nat.pos_of_ne_zero
    change Finset.univ.gcd v ≠ 0
    rw [Finset.gcd_ne_zero_iff]
    exact ⟨0, Finset.mem_univ _, (hpos 0).ne'⟩
  let w : Fin 5 → ℕ := fun i => v i / g
  have hfactor (i : Fin 5) : v i = g * w i := by
    dsimp [w]
    exact (Nat.mul_div_cancel' (hgdvd i)).symm
  have hwpos (i : Fin 5) : 0 < w i := by
    dsimp [w]
    exact Nat.div_pos (Nat.le_of_dvd (hpos i) (hgdvd i)) hgpos
  have hwprimitive : Finset.univ.gcd w = 1 := by
    change Finset.univ.gcd (fun i => v i / Finset.univ.gcd v) = 1
    exact Finset.gcd_div_eq_one (s := Finset.univ) (f := v)
      (i := 0) (Finset.mem_univ _) (hpos 0).ne'
  -- The exact count excludes a common factor of three before normalization.
  have hnotg : ¬ 3 ∣ g := by
    intro hg
    have hall : ∀ i, 3 ∣ v i := by
      intro i
      exact dvd_trans hg (hgdvd i)
    have hfull : (Finset.univ : Finset (Fin 5)).filter (fun i => 3 ∣ v i) = Finset.univ :=
      Finset.filter_eq_self.mpr (fun i _ => hall i)
    rw [hfull] at htwo
    norm_num at htwo
  have hdiviff (i : Fin 5) : 3 ∣ v i ↔ 3 ∣ w i := by
    rw [hfactor i]
    constructor
    · intro h
      rcases Nat.prime_three.dvd_mul.mp h with hg | hw
      · exact False.elim (hnotg hg)
      · exact hw
    · intro h
      exact dvd_mul_of_dvd_right h g
  have htwow : ((Finset.univ : Finset (Fin 5)).filter (fun i => 3 ∣ w i)).card = 2 := by
    have hfilter : (Finset.univ : Finset (Fin 5)).filter (fun i => 3 ∣ w i) =
        (Finset.univ : Finset (Fin 5)).filter (fun i => 3 ∣ v i) := by
      ext i
      simp only [Finset.mem_filter, Finset.mem_univ, true_and]
      exact (hdiviff i).symm
    rw [hfilter]
    exact htwo
  obtain ⟨t, htpos, ht⟩ := fiveMovingNaturalRunners_of_primitive_two_divisible_three
    w hwpos hwprimitive htwow
  refine ⟨t / (g : ℝ), by positivity, ?_⟩
  intro i
  rw [hfactor i]
  have hgR : (g : ℝ) ≠ 0 := by exact_mod_cast hgpos.ne'
  rw [Nat.cast_mul]
  rw [show t / (g : ℝ) * ((g : ℝ) * (w i : ℝ)) =
    t * (w i : ℝ) by field_simp]
  exact ht i

end LonelyRunner
