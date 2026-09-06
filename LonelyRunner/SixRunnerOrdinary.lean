import LonelyRunner.SixTotalDivisorCounts
import LonelyRunner.TwoDivisibleNormalization
import LonelyRunner.OneEvenRunners
import LonelyRunner.TwoEvenRunners
import LonelyRunner.ThreeEvenRunners
import LonelyRunner.FiveRunnerOrdinary
import Mathlib.Algebra.GCDMonoid.Finset
import Mathlib.Tactic

/-!
# Ordinary witnesses for five moving speeds

This module is the final finite `Fin 5` assembly needed by the six-total-runner
transition milestone.  The primitive dispatcher uses divisor counts only under
an all-real missing-witness assumption.  GCD normalization is deliberately
separate: it transports the resulting common time and never needs to preserve
the intermediate divisibility counts.
-/

namespace LonelyRunner

/-- A primitive positive five-speed tuple has a common closed sixth-margin
witness.  Repeated speed values are permitted throughout this finite result. -/
theorem fiveMovingNaturalRunners_of_primitive
    (v : Fin 5 → ℕ) (hpos : ∀ i, 0 < v i)
    (hprimitive : Finset.univ.gcd v = 1) :
    ∃ t : ℝ, 0 < t ∧ ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ)) := by
  classical
  have hall : ∃ t : ℝ, ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ)) := by
    by_contra hno
    let S : ℕ → Finset (Fin 5) := fun ell =>
      (Finset.univ : Finset (Fin 5)).filter (fun i => ell ∣ v i)
    have hthree := six_total_divisor_count_bounds v hpos hprimitive hno 3
      (by omega) (by omega)
    have hthreeS : 1 ≤ (S 3).card ∧ (S 3).card ≤ 3 := by
      simpa [S] using hthree
    by_cases htwo : 2 ≤ (S 3).card
    · obtain ⟨t, _htpos, ht⟩ :=
        fiveMovingNaturalRunners_of_primitive_at_least_two_divisible_three
          v hpos hprimitive (by simpa [S] using htwo)
      exact hno ⟨t, ht⟩
    · have hcard3 : (S 3).card = 1 := by omega
      obtain ⟨p, hS3⟩ := Finset.card_eq_one.mp hcard3
      have hone : ∀ i, 3 ∣ v i ↔ i = p := by
        intro i
        have hi : i ∈ S 3 ↔ i = p := by
          rw [hS3]
          simp
        simpa [S] using hi
      have hsixBounds := six_total_divisor_count_bounds v hpos hprimitive hno 6
        (by omega) (by omega)
      obtain ⟨q, hq⟩ := Finset.one_le_card.mp hsixBounds.1
      have hq6 : 6 ∣ v q := by
        simpa [S] using hq
      have hqp : q = p :=
        (hone q).mp (dvd_trans (by norm_num : 3 ∣ 6) hq6)
      have hsix : 6 ∣ v p := by simpa [hqp] using hq6
      have htwoBounds := six_total_divisor_count_bounds v hpos hprimitive hno 2
        (by omega) (by omega)
      have htwoS : 1 ≤ (S 2).card ∧ (S 2).card ≤ 3 := by
        simpa [S] using htwoBounds
      have hcard2 : (S 2).card = 1 ∨ (S 2).card = 2 ∨ (S 2).card = 3 := by
        omega
      rcases hcard2 with hcard2 | hcard2 | hcard2
      · obtain ⟨t, _htpos, ht⟩ := one_three_divisible_one_even_witness
          v hpos p hsix hone (by simpa [S] using hcard2)
        exact hno ⟨t, ht⟩
      · obtain ⟨t, _htpos, ht⟩ := one_three_divisible_two_even_witness
          v hpos p hone (by simpa [S] using hcard2)
        exact hno ⟨t, ht⟩
      · obtain ⟨t, _htpos, ht⟩ := one_three_divisible_three_even_witness
          v hpos p hone (by simpa [S] using hcard2)
        exact hno ⟨t, ht⟩
  obtain ⟨u, hu⟩ := hall
  have hune : u ≠ 0 := by
    intro hu0
    have hzero := hu 0
    rw [hu0] at hzero
    norm_num [circleNorm] at hzero
  rcases lt_or_gt_of_ne hune with huneg | hupos
  · refine ⟨-u, neg_pos.mpr huneg, ?_⟩
    intro i
    rw [show (-u) * (v i : ℝ) = -(u * (v i : ℝ)) by ring, circleNorm_neg]
    exact hu i
  · exact ⟨u, hupos, hu⟩

/-- Every positive five-speed natural tuple has a common closed sixth-margin
witness.  Dividing by the tuple GCD preserves positivity and makes the finite
primitive dispatcher applicable; rescaling time restores the original tuple. -/
theorem fiveMovingNaturalRunners
    (v : Fin 5 → ℕ) (hpos : ∀ i, 0 < v i) :
    ∃ t : ℝ, 0 < t ∧ ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ)) := by
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
  obtain ⟨t, htpos, ht⟩ :=
    fiveMovingNaturalRunners_of_primitive w hwpos hwprimitive
  refine ⟨t / (g : ℝ), by positivity, ?_⟩
  intro i
  rw [hfactor i, Nat.cast_mul]
  have hgR : (g : ℝ) ≠ 0 := by exact_mod_cast hgpos.ne'
  rw [show t / (g : ℝ) * ((g : ℝ) * (w i : ℝ)) =
    t * (w i : ℝ) by field_simp [hgR]]
  exact ht i

/-- The lower-count positive-integer supply through five moving speeds.
This is `H_7`; it is the bounded input for six total runners. -/
theorem lowerCountPositiveIntegerHypothesis_seven :
    LowerCountPositiveIntegerHypothesis 7 := by
  intro d hd hdmax speeds hinj hpos
  by_cases hsmall : d ≤ 4
  · exact lowerCountPositiveIntegerHypothesis_six
      d hd (by omega) speeds hinj hpos
  · have hd5 : d = 5 := by omega
    subst d
    obtain ⟨t, _htpos, ht⟩ := fiveMovingNaturalRunners speeds hpos
    exact ⟨t, by simpa [one_div] using ht⟩

end LonelyRunner
