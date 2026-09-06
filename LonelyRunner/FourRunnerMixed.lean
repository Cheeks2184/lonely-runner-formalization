import LonelyRunner.FourRunnerMixedCertificate
import LonelyRunner.FiniteHeightReduction
import LonelyRunner.BaseCases
import LonelyRunner.SmallDimensions
import LonelyRunner.PairSumCompleteness

/-!
# Four-total-runner mixed witnesses

This module combines the kernel-checked finite certificate with the
large-height theorem, elementary phase exclusion, and gcd normalization to
classify every positive increasing triple.
-/

namespace LonelyRunner

/-- A positive time where the two lower speeds meet the quarter threshold and
the fastest speed meets the stronger third threshold. -/
def FourRunnerMixed (a b H : ℕ) : Prop :=
  ∃ t : ℝ, 0 < t ∧
    ((4 : ℕ) : ℝ)⁻¹ ≤ circleNorm (t * (a : ℝ)) ∧
    ((4 : ℕ) : ℝ)⁻¹ ≤ circleNorm (t * (b : ℝ)) ∧
    ((3 : ℕ) : ℝ)⁻¹ ≤ circleNorm (t * (H : ℝ))

/-- The already-proved lower-count hypothesis needed by the large-height branch. -/
theorem fourRunnerMixed_lowerCount4 : LowerCountPositiveIntegerHypothesis 4 := by
  intro d hd hdmax speeds hinj hpos
  interval_cases d
  · obtain ⟨t, ht⟩ := oneMovingRunner (speeds 0 : ℝ)
      (by exact_mod_cast (Nat.ne_of_gt (hpos 0)))
    refine ⟨t, ?_⟩
    intro i
    have hi : i = 0 := Fin.eq_zero i
    subst i
    simpa [circleNorm] using ht
  · obtain ⟨t, ht⟩ := twoMovingRunners (fun i => (speeds i : ℝ))
      (fun i => by exact_mod_cast (Nat.ne_of_gt (hpos i)))
    refine ⟨t, ?_⟩
    intro i
    simpa [circleNorm] using ht i

/-- The literal finite endpoint certificate covers every nonexceptional
primitive increasing triple of height at most 36. -/
theorem primitive_fourRunnerMixed_of_le_36 {a b H : ℕ}
    (ha : 0 < a) (hab : a < b) (hbH : b < H) (hH : H ≤ 36)
    (hprimitive : Nat.gcd a (Nat.gcd b H) = 1)
    (hexception : ¬ (a = 1 ∧ b = 2 ∧ H = 3)) :
    FourRunnerMixed a b H := by
  let hfin : Fin 37 := ⟨H, by omega⟩
  let afin : Fin 37 := ⟨a, by omega⟩
  let bfin : Fin 37 := ⟨b, by omega⟩
  obtain ⟨k, hk⟩ := fourRunnerMixed_finiteCoverage hfin afin bfin ha hab hbH
    hprimitive hexception
  exact fourRunnerMixedRowOK_sound hk

/-- Primitive triples above the finite certificate height have mixed witnesses. -/
theorem primitive_fourRunnerMixed_of_gt_36 {a b H : ℕ}
    (ha : 0 < a) (hab : a < b) (hbH : b < H)
    (hprimitive : Nat.gcd a (Nat.gcd b H) = 1) (hH : 36 < H) :
    FourRunnerMixed a b H := by
  let s : Fin 4 → ℕ := ![0, a, b, H]
  have hsmono : StrictMono s := by
    intro i j hij
    fin_cases i <;> fin_cases j <;> simp [s] at hij ⊢ <;> omega
  have hs0 : s 0 = 0 := by simp [s]
  have hsgcd : Finset.univ.gcd s = 1 := by
    apply Nat.dvd_one.mp
    rw [← hprimitive]
    apply Nat.dvd_gcd
    · simpa [s] using (Finset.gcd_dvd (s := (Finset.univ : Finset (Fin 4)))
        (f := s) (Finset.mem_univ (1 : Fin 4)))
    · apply Nat.dvd_gcd
      · simpa [s] using (Finset.gcd_dvd (s := (Finset.univ : Finset (Fin 4)))
          (f := s) (Finset.mem_univ (2 : Fin 4)))
      · simpa [s] using (Finset.gcd_dvd (s := (Finset.univ : Finset (Fin 4)))
          (f := s) (Finset.mem_univ (3 : Fin 4)))
  have hheight : (Nat.choose (2 + 2) 2) ^ 2 < s (Fin.last 3) := by
    simp [s]
    exact hH
  obtain ⟨t, ht, hl, hfast⟩ := primitive_sorted_largeHeight_stationary_mixed
    (m := 2) (by omega) fourRunnerMixed_lowerCount4 s hsmono hs0 hsgcd hheight
  refine ⟨t, ht, ?_, ?_, ?_⟩
  · have h := (lonelyAt_iff_relativeLonelyAt (fun i => (s i : ℝ)) 0 t).mp hl 1 (by decide)
    simpa [circleNorm, s] using h
  · have h := (lonelyAt_iff_relativeLonelyAt (fun i => (s i : ℝ)) 0 t).mp hl 2 (by decide)
    simpa [circleNorm, s] using h
  · simpa [s] using hfast

/-- Every nonexceptional primitive positive increasing triple has a mixed witness. -/
theorem primitive_fourRunnerMixed {a b H : ℕ}
    (ha : 0 < a) (hab : a < b) (hbH : b < H)
    (hprimitive : Nat.gcd a (Nat.gcd b H) = 1)
    (hexception : ¬ (a = 1 ∧ b = 2 ∧ H = 3)) : FourRunnerMixed a b H := by
  by_cases hH : H ≤ 36
  · exact primitive_fourRunnerMixed_of_le_36 ha hab hbH hH hprimitive hexception
  · exact primitive_fourRunnerMixed_of_gt_36 ha hab hbH hprimitive (by omega)

/-! The remaining argument isolates the unique closed-boundary obstruction.
The phase is first folded into the half interval around the nearest integer. -/

private theorem circleNorm_nat_mul_eq_circleNorm_abs_residual (t : ℝ) (k : ℕ) :
    circleNorm (t * (k : ℝ)) =
      circleNorm (|t - (round t : ℝ)| * (k : ℝ)) := by
  let x : ℝ := t - (round t : ℝ)
  have hphase : t * (k : ℝ) = ((round t * (k : ℤ) : ℤ) : ℝ) + x * (k : ℝ) := by
    dsimp [x]
    push_cast
    ring
  rw [hphase, circleNorm_add_int, ← circleNorm_abs]
  have hk : |(k : ℝ)| = (k : ℝ) := abs_of_nonneg (Nat.cast_nonneg k)
  rw [abs_mul, hk]

/-- The scaled `(1, 2, 3)` family cannot meet the mixed closed margins. -/
theorem not_fourRunnerMixed_one_two_three (a : ℕ) :
    ¬ FourRunnerMixed a (2 * a) (3 * a) := by
  intro h
  obtain ⟨t, ht, ha, hb, hH⟩ := h
  let T : ℝ := t * (a : ℝ)
  let f : ℝ := |T - (round T : ℝ)|
  have hfhalf : f ≤ (1 : ℝ) / 2 := by
    dsimp [f]
    exact abs_sub_round T
  have ha' : (1 : ℝ) / 4 ≤ circleNorm T := by
    simpa [T] using ha
  have hphase2 : T * (2 : ℝ) = t * ((2 * a : ℕ) : ℝ) := by
    dsimp [T]
    push_cast
    ring
  have hphase3 : T * (3 : ℝ) = t * ((3 * a : ℕ) : ℝ) := by
    dsimp [T]
    push_cast
    ring
  have hb' : (1 : ℝ) / 4 ≤ circleNorm (T * (2 : ℝ)) := by
    rw [hphase2]
    norm_num at hb ⊢
    exact hb
  have hH' : (1 : ℝ) / 3 ≤ circleNorm (T * (3 : ℝ)) := by
    rw [hphase3]
    norm_num at hH ⊢
    exact hH
  rw [circleNorm_eq_abs_sub_round] at ha'
  change (1 : ℝ) / 4 ≤ f at ha'
  have hfold2 : circleNorm (T * 2) = circleNorm (f * 2) := by
    simpa [f] using circleNorm_nat_mul_eq_circleNorm_abs_residual T 2
  have hfold3 : circleNorm (T * 3) = circleNorm (f * 3) := by
    simpa [f] using circleNorm_nat_mul_eq_circleNorm_abs_residual T 3
  rw [hfold2] at hb'
  rw [hfold3] at hH'
  have hf : (1 : ℝ) / 4 ≤ f := ha'
  have htwo : circleNorm (f * (2 : ℝ)) ≤ 1 - 2 * f := by
    calc
      circleNorm (f * (2 : ℝ)) ≤ |f * (2 : ℝ) - (1 : ℤ)| :=
        circleNorm_le_abs_sub_int _ 1
      _ = 1 - 2 * f := by
        rw [abs_of_nonpos]
        · ring
        · norm_num at hfhalf ⊢
          linarith
  have hfthree : f ≤ (3 : ℝ) / 8 := by
    linarith [hb'.trans htwo]
  have hthree : circleNorm (f * (3 : ℝ)) ≤ (1 : ℝ) / 4 := by
    calc
      circleNorm (f * (3 : ℝ)) ≤ |f * (3 : ℝ) - (1 : ℤ)| :=
        circleNorm_le_abs_sub_int _ 1
      _ ≤ (1 : ℝ) / 4 := by
        rw [abs_le]
        constructor <;> linarith
  linarith [hH'.trans hthree]


/-- Every nonexceptional positive increasing triple has a mixed witness. -/
theorem fourRunnerMixed_of_not_exception {a b H : ℕ}
    (ha : 0 < a) (hab : a < b) (hbH : b < H)
    (hexception : ¬ (b = 2 * a ∧ H = 3 * a)) : FourRunnerMixed a b H := by
  let g := Nat.gcd a (Nat.gcd b H)
  let A := a / g
  let B := b / g
  let C := H / g
  have hga : g ∣ a := Nat.gcd_dvd_left _ _
  have hgb : g ∣ b := (Nat.gcd_dvd_right _ _).trans (Nat.gcd_dvd_left _ _)
  have hgH : g ∣ H := (Nat.gcd_dvd_right _ _).trans (Nat.gcd_dvd_right _ _)
  have hgpos : 0 < g := Nat.gcd_pos_of_pos_left _ ha
  have hfacA : a = g * A := by
    exact (Nat.mul_div_cancel' hga).symm
  have hfacB : b = g * B := by
    exact (Nat.mul_div_cancel' hgb).symm
  have hfacC : H = g * C := by
    exact (Nat.mul_div_cancel' hgH).symm
  have hApos : 0 < A := Nat.div_pos (Nat.le_of_dvd ha hga) hgpos
  have hAB : A < B := by
    apply (Nat.mul_lt_mul_left hgpos).mp
    simpa [← hfacA, ← hfacB] using hab
  have hBC : B < C := by
    apply (Nat.mul_lt_mul_left hgpos).mp
    simpa [← hfacB, ← hfacC] using hbH
  have hprimitive : Nat.gcd A (Nat.gcd B C) = 1 := by
    have hfactor : Nat.gcd a (Nat.gcd b H) = g * Nat.gcd A (Nat.gcd B C) := by
      rw [hfacA, hfacB, hfacC, Nat.gcd_mul_left, Nat.gcd_mul_left]
    have hself : g = g * Nat.gcd A (Nat.gcd B C) := by
      simpa [g] using hfactor
    have : g * Nat.gcd A (Nat.gcd B C) = g * 1 := by simpa using hself.symm
    exact Nat.eq_of_mul_eq_mul_left hgpos this
  have hnormalizedException : ¬ (A = 1 ∧ B = 2 ∧ C = 3) := by
    rintro ⟨hA, hB, hC⟩
    apply hexception
    constructor
    · rw [hfacA, hfacB, hA, hB]
      omega
    · rw [hfacA, hfacC, hA, hC]
      omega
  obtain ⟨u, hu, huA, huB, huC⟩ :=
    primitive_fourRunnerMixed hApos hAB hBC hprimitive hnormalizedException
  refine ⟨u / (g : ℝ), div_pos hu (by exact_mod_cast hgpos), ?_, ?_, ?_⟩
  · have hphase : (u / (g : ℝ)) * (a : ℝ) = u * (A : ℝ) := by
      rw [hfacA]
      push_cast
      field_simp
    rwa [hphase]
  · have hphase : (u / (g : ℝ)) * (b : ℝ) = u * (B : ℝ) := by
      rw [hfacB]
      push_cast
      field_simp
    rwa [hphase]
  · have hphase : (u / (g : ℝ)) * (H : ℝ) = u * (C : ℝ) := by
      rw [hfacC]
      push_cast
      field_simp
    rwa [hphase]

/-- Complete classification of mixed witnesses for positive increasing triples. -/
theorem fourRunnerMixed_iff {a b H : ℕ} (ha : 0 < a) (hab : a < b) (hbH : b < H) :
    FourRunnerMixed a b H ↔ ¬ (b = 2 * a ∧ H = 3 * a) := by
  constructor
  · intro h hexception
    obtain ⟨hb, hH⟩ := hexception
    rw [hb, hH] at h
    exact not_fourRunnerMixed_one_two_three a h
  · exact fourRunnerMixed_of_not_exception ha hab hbH

/-- The scaled `(1, 2, 3)` family has no strict ordinary quarter witness. -/
theorem not_strict_ordinary_one_two_three (a : ℕ) :
    ¬ ∃ t : ℝ,
      (1 : ℝ) / 4 < circleNorm (t * (a : ℝ)) ∧
      (1 : ℝ) / 4 < circleNorm (t * ((2 * a : ℕ) : ℝ)) ∧
      (1 : ℝ) / 4 < circleNorm (t * ((3 * a : ℕ) : ℝ)) := by
  rintro ⟨t, ha, hb, hH⟩
  let T : ℝ := t * (a : ℝ)
  let f : ℝ := |T - (round T : ℝ)|
  have hfhalf : f ≤ (1 : ℝ) / 2 := by
    dsimp [f]
    exact abs_sub_round T
  have ha' : (1 : ℝ) / 4 < circleNorm T := by
    simpa [T] using ha
  have hphase2 : T * (2 : ℝ) = t * ((2 * a : ℕ) : ℝ) := by
    dsimp [T]
    push_cast
    ring
  have hphase3 : T * (3 : ℝ) = t * ((3 * a : ℕ) : ℝ) := by
    dsimp [T]
    push_cast
    ring
  have hb' : (1 : ℝ) / 4 < circleNorm (T * (2 : ℝ)) := by
    rw [hphase2]
    norm_num at hb ⊢
    exact hb
  have hH' : (1 : ℝ) / 4 < circleNorm (T * (3 : ℝ)) := by
    rw [hphase3]
    norm_num at hH ⊢
    exact hH
  rw [circleNorm_eq_abs_sub_round] at ha'
  change (1 : ℝ) / 4 < f at ha'
  have hfold2 : circleNorm (T * 2) = circleNorm (f * 2) := by
    simpa [f] using circleNorm_nat_mul_eq_circleNorm_abs_residual T 2
  have hfold3 : circleNorm (T * 3) = circleNorm (f * 3) := by
    simpa [f] using circleNorm_nat_mul_eq_circleNorm_abs_residual T 3
  rw [hfold2] at hb'
  rw [hfold3] at hH'
  have hf : (1 : ℝ) / 4 < f := ha'
  have htwo : circleNorm (f * (2 : ℝ)) ≤ 1 - 2 * f := by
    calc
      circleNorm (f * (2 : ℝ)) ≤ |f * (2 : ℝ) - (1 : ℤ)| :=
        circleNorm_le_abs_sub_int _ 1
      _ = 1 - 2 * f := by
        rw [abs_of_nonpos]
        · ring
        · norm_num at hfhalf ⊢
          linarith
  have hfthree : f < (3 : ℝ) / 8 := by
    linarith [hb'.trans_le htwo]
  have hthree : circleNorm (f * (3 : ℝ)) < (1 : ℝ) / 4 := by
    calc
      circleNorm (f * (3 : ℝ)) ≤ |f * (3 : ℝ) - (1 : ℤ)| :=
        circleNorm_le_abs_sub_int _ 1
      _ < (1 : ℝ) / 4 := by
        rw [abs_lt]
        constructor <;> linarith
  exact (not_lt_of_ge hthree.le) hH'

/-- A strict ordinary quarter witness yields a positive mixed witness. -/
theorem strict_ordinary_witness_implies_fourRunnerMixed {a b H : ℕ}
    (ha : 0 < a) (hab : a < b) (hbH : b < H)
    (hstrict : ∃ t : ℝ,
      (1 : ℝ) / 4 < circleNorm (t * (a : ℝ)) ∧
      (1 : ℝ) / 4 < circleNorm (t * (b : ℝ)) ∧
      (1 : ℝ) / 4 < circleNorm (t * (H : ℝ))) :
    FourRunnerMixed a b H := by
  apply (fourRunnerMixed_iff ha hab hbH).mpr
  rintro ⟨hb, hH⟩
  subst b
  subst H
  exact not_strict_ordinary_one_two_three a hstrict

end LonelyRunner
