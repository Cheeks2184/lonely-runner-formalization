import LonelyRunner.FiveAdicFiltering
import LonelyRunner.FiveAdicDecomposition
import LonelyRunner.FiveAdicHardPattern
import LonelyRunner.FourRunnerOrdinary
import Mathlib.Data.Finset.Max
import Mathlib.Tactic

/-!
# Ordinary witnesses for four moving natural speeds

This module assembles the frozen five-adic lower-layer filter and its crowded
three-lower-layer complement into the bounded `H_6` supply.  The result is
only a four-moving-speed statement; the five-total-runner specialization lives
in `FiveRunnerCanonical`.
-/

namespace LonelyRunner

/-- A fixed-level five-adic multiplier for four positive natural speeds. -/
theorem fiveAdic_four_label_multiplier
    (d ell u : Fin 4 → Nat) (m : Nat)
    (hd : ∀ i, 0 < d i)
    (hdecomp : ∀ i, d i = 5 ^ (ell i) * u i)
    (hu : ∀ i, ¬ 5 ∣ u i)
    (hell : ∀ i, ell i ≤ m)
    (hmax : ∃ p, ell p = m) :
    ∃ lam : Nat, 0 < lam ∧ lam < 5 * 5^m ∧ ¬ 5 ∣ lam ∧
      ∀ i, 5^m ≤ cyclicResidueDistance (5 * 5^m) (lam * d i) := by
  classical
  rcases fin4_level_dichotomy ell m hell hmax with hfiltered | hhard
  · rcases exists_five_adic_filtered_multiplier d ell u m hd hdecomp hu hell hfiltered with
      ⟨lam, hlampos, hlamlt, _hlamone, hlamunit, _hlower, _htop, hlamdist⟩
    exact ⟨lam, hlampos, hlamlt, hlamunit, hlamdist⟩
  · rcases hhard with ⟨j, hjm, p, hp, hlow⟩
    let lower : Fin 3 → Nat := fun q => u (p.succAbove q)
    let top : Nat := u p
    let g : Nat := 5 ^ j
    let m' : Nat := m - j
    have hjle : j ≤ m := by omega
    have hsum : j + m' = m := by
      dsimp [m']
      omega
    have hmpos : 1 ≤ m' := by
      dsimp [m']
      omega
    have hpow : 5 ^ m = g * 5 ^ m' := by
      dsimp [g, m']
      rw [← pow_add, hsum]
    have hlowerunit : ∀ q, ¬ 5 ∣ lower q := by
      intro q
      exact hu _
    have htopunit : ¬ 5 ∣ top := hu p
    rcases fiveAdic_hard_pattern m' hmpos lower hlowerunit top htopunit with
      ⟨lam, hlampos, hlamlt, hlamunit, hlowerdist, htopdist⟩
    refine ⟨lam, hlampos, ?_, hlamunit, ?_⟩
    · have hPle : 5 * 5 ^ m' ≤ 5 * 5 ^ m := by
        rw [hpow]
        have hg : 1 ≤ g := by
          dsimp [g]
          exact Nat.one_le_iff_ne_zero.mpr (pow_ne_zero _ (by decide))
        apply Nat.mul_le_mul_left 5
        simpa using Nat.mul_le_mul_right (5 ^ m') hg
      simpa [hpow, Nat.mul_assoc] using hlamlt.trans_le hPle
    · intro i
      by_cases hip : i = p
      · subst i
        have hdtop : d p = g * (5 ^ m' * top) := by
          rw [hdecomp p, hp, hpow]
          simp only [g, top]
          ring
        rw [hdtop]
        rw [show 5 * 5 ^ m = g * (5 * 5 ^ m') by rw [hpow]; ring]
        rw [show lam * (g * (5 ^ m' * top)) = g * (lam * (5 ^ m' * top)) by ring]
        rw [fiveAdic_cyclicResidueDistance_mul_left]
        have hg : 1 ≤ g := by
          dsimp [g]
          exact Nat.one_le_iff_ne_zero.mpr (pow_ne_zero _ (by decide))
        nlinarith [htopdist]
      · obtain ⟨q, hq⟩ := Fin.exists_succAbove_eq hip
        subst i
        have hdlower : d (p.succAbove q) = g * lower q := by
          rw [hdecomp]
          have hlevel := hlow (p.succAbove q) (Fin.succAbove_ne p q)
          rw [hlevel]
        rw [hdlower]
        rw [show 5 * 5 ^ m = g * (5 * 5 ^ m') by rw [hpow]; ring]
        rw [show lam * (g * lower q) = g * (lam * lower q) by ring]
        rw [fiveAdic_cyclicResidueDistance_mul_left]
        have hg : 1 ≤ g := by
          dsimp [g]
          exact Nat.one_le_iff_ne_zero.mpr (pow_ne_zero _ (by decide))
        nlinarith [hlowerdist q]

/-- Every four-label positive natural family has a five-adic multiplier at
its attained maximum five-adic exponent. -/
theorem fourMovingNaturalMultiplier (speeds : Fin 4 → Nat)
    (hpos : ∀ i, 0 < speeds i) :
    ∃ m lam : Nat, 0 < lam ∧ lam < 5 * 5^m ∧ ¬ 5 ∣ lam ∧
      ∀ i, 5^m ≤ cyclicResidueDistance (5 * 5^m) (lam * speeds i) := by
  classical
  let ell : Fin 4 → Nat := fun i => fiveAdicExponent (speeds i)
  let u : Fin 4 → Nat := fun i => fiveAdicUnit (speeds i)
  have hdec : ∀ i, speeds i = 5 ^ ell i * u i := by
    intro i
    simpa [ell, u] using (fiveAdic_positive_decomposition (speeds i) (hpos i)).1
  have hunit : ∀ i, ¬ 5 ∣ u i := by
    intro i
    simpa [u] using (fiveAdic_positive_decomposition (speeds i) (hpos i)).2.2
  obtain ⟨p, _hp, hmax⟩ := Finset.exists_max_image (Finset.univ : Finset (Fin 4)) ell
    (by simp)
  refine ⟨ell p, ?_⟩
  apply fiveAdic_four_label_multiplier speeds ell u (ell p) hpos hdec hunit
  · intro i
    exact hmax i (Finset.mem_univ _)
  · exact ⟨p, rfl⟩

/-- Four positive moving natural speeds have a positive ordinary fifth-margin
witness.  Repetitions are permitted because this statement is used as a
lower-count supply after rational magnitude consolidation. -/
theorem fourMovingNaturalRunners (speeds : Fin 4 → Nat)
    (hpos : ∀ i, 0 < speeds i) :
    ∃ t : ℝ, 0 < t ∧ ∀ i,
      (5 : ℝ)⁻¹ ≤ circleNorm (t * (speeds i : ℝ)) := by
  rcases fourMovingNaturalMultiplier speeds hpos with
    ⟨m, lam, hlampos, hlamlt, _hlamunit, hlamdist⟩
  let R : Nat := 5 ^ m
  let P : Nat := 5 * R
  have hR : 0 < R := by
    dsimp [R]
    positivity
  have hP : 0 < P := by
    dsimp [P]
    positivity
  refine ⟨(lam : ℝ) / (P : ℝ), by positivity, ?_⟩
  intro i
  have hcircle := circleNorm_nat_div_ge hP (show R ≤ cyclicResidueDistance P (lam * speeds i) by
    simpa [P, R] using hlamdist i)
  have hratio : ((R : ℝ) / (P : ℝ)) = (5 : ℝ)⁻¹ := by
    dsimp [P]
    field_simp
    simp [Nat.cast_mul, mul_comm]
  calc
    (5 : ℝ)⁻¹ = (R : ℝ) / (P : ℝ) := hratio.symm
    _ ≤ circleNorm ((lam * speeds i : ℕ) / (P : ℕ)) := hcircle
    _ = circleNorm ((lam : ℝ) / (P : ℝ) * (speeds i : ℝ)) := by
      congr 1
      push_cast
      field_simp

/-- The lower-count positive-integer hypothesis through four moving speeds.
This is exactly `H_6`, not a six-runner theorem. -/
theorem lowerCountPositiveIntegerHypothesis_six :
    LowerCountPositiveIntegerHypothesis 6 := by
  intro d hd hdmax speeds hinj hpos
  by_cases hsmall : d ≤ 3
  · exact lowerCountPositiveIntegerHypothesis_five d hd (by omega) speeds hinj hpos
  · have hd4 : d = 4 := by omega
    subst d
    obtain ⟨t, _htpos, ht⟩ := fourMovingNaturalRunners speeds hpos
    exact ⟨t, by simpa using ht⟩

end LonelyRunner
