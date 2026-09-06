import LonelyRunner.FourRunnerMixed
import LonelyRunner.FiniteTupleSorting

/-!
# Ordinary witnesses for three moving natural speeds

The mixed four-runner classification supplies the ordinary quarter witness for
all nonexceptional ordered triples.  This file handles its exceptional family,
then transports the result to arbitrary labels and packages the resulting
bounded lower-count supply.
-/

namespace LonelyRunner

/-- Every positive strictly increasing natural triple has a positive ordinary
quarter witness. -/
theorem threeMovingNaturalSpeeds (a b H : ℕ)
    (ha : 0 < a) (hab : a < b) (hbH : b < H) :
    ∃ t : ℝ, 0 < t ∧
      (4 : ℝ)⁻¹ ≤ circleNorm (t * (a : ℝ)) ∧
      (4 : ℝ)⁻¹ ≤ circleNorm (t * (b : ℝ)) ∧
      (4 : ℝ)⁻¹ ≤ circleNorm (t * (H : ℝ)) := by
  by_cases hexception : b = 2 * a ∧ H = 3 * a
  · obtain ⟨hb, hH⟩ := hexception
    subst b
    subst H
    refine ⟨(4 * (a : ℝ))⁻¹, by positivity, ?_, ?_, ?_⟩
    · have hphase : (4 * (a : ℝ))⁻¹ * (a : ℝ) = (1 : ℝ) / 4 := by
        field_simp
      rw [hphase, circleNorm_eq_abs_of_abs_le_half]
      · norm_num
      · norm_num
    · have hphase : (4 * (a : ℝ))⁻¹ * ((2 * a : ℕ) : ℝ) = (1 : ℝ) / 2 := by
        push_cast
        field_simp
        norm_num
      rw [hphase, circleNorm_eq_abs_of_abs_le_half]
      · norm_num
      · norm_num
    · have hphase : (4 * (a : ℝ))⁻¹ * ((3 * a : ℕ) : ℝ) = (3 : ℝ) / 4 := by
        push_cast
        field_simp
      rw [hphase]
      have hshift : (3 : ℝ) / 4 = ((1 : ℤ) : ℝ) + (-(1 : ℝ) / 4) := by norm_num
      rw [hshift, circleNorm_add_int]
      have hneg : (-1 : ℝ) / 4 = -((1 : ℝ) / 4) := by ring
      rw [hneg, circleNorm_neg,
        circleNorm_eq_abs_of_abs_le_half]
      · norm_num
      · norm_num
  · obtain ⟨t, ht, hta, htb, htH⟩ :=
      (fourRunnerMixed_iff ha hab hbH).mpr hexception
    refine ⟨t, ht, ?_, ?_, ?_⟩
    · simpa using hta
    · simpa using htb
    · norm_num at htH ⊢
      linarith

/-- Any injective positive natural tuple indexed by `Fin 3` has a positive
ordinary quarter witness, independently of its input labelling. -/
theorem threeMovingNaturalRunners (speeds : Fin 3 → ℕ)
    (hinj : Function.Injective speeds) (hpos : ∀ i, 0 < speeds i) :
    ∃ t : ℝ, 0 < t ∧ ∀ i,
      (4 : ℝ)⁻¹ ≤ circleNorm (t * (speeds i : ℝ)) := by
  obtain ⟨e, he⟩ := exists_strictMono_reindex speeds hinj
  obtain ⟨t, ht, ht0, ht1, ht2⟩ := threeMovingNaturalSpeeds
    (speeds (e 0)) (speeds (e 1)) (speeds (e 2))
    (hpos (e 0)) (he (by decide)) (he (by decide))
  refine ⟨t, ht, fun i => ?_⟩
  obtain ⟨j, rfl⟩ := e.surjective i
  fin_cases j
  · exact ht0
  · exact ht1
  · exact ht2

/-- The lower-count positive-integer hypothesis through three moving speeds.
This is the exact bounded input `H_5`, not a five-total-runner theorem. -/
theorem lowerCountPositiveIntegerHypothesis_five :
    LowerCountPositiveIntegerHypothesis 5 := by
  intro d hd hdmax speeds hinj hpos
  interval_cases d
  · exact fourRunnerMixed_lowerCount4 1 (by omega) (by omega) speeds hinj hpos
  · exact fourRunnerMixed_lowerCount4 2 (by omega) (by omega) speeds hinj hpos
  · obtain ⟨t, ht, hquarter⟩ := threeMovingNaturalRunners speeds hinj hpos
    refine ⟨t, fun i => ?_⟩
    simpa using hquarter i

end LonelyRunner
