import LonelyRunner.Formulations
import LonelyRunner.Normalization
import Mathlib.Data.Rat.Cast.Order

namespace LonelyRunner

noncomputable def rationalCommonDenominator {n : ℕ} (speeds : Fin n → ℚ) : ℕ :=
  ∏ i, (speeds i).den

theorem rational_den_dvd_common {n : ℕ} (speeds : Fin n → ℚ) (i : Fin n) :
    (speeds i).den ∣ rationalCommonDenominator speeds := by
  apply Finset.dvd_prod_of_mem (f := fun j => (speeds j).den)
  simp

theorem rationalCommonDenominator_pos {n : ℕ} (speeds : Fin n → ℚ) :
    0 < rationalCommonDenominator speeds := by
  apply Finset.prod_pos
  intro i hi
  exact (speeds i).den_pos

noncomputable def clearRationalSpeed {n : ℕ} (speeds : Fin n → ℚ) (i : Fin n) : ℕ :=
  (speeds i).num.natAbs * (rationalCommonDenominator speeds / (speeds i).den)

theorem clearRationalSpeed_cast {n : ℕ} (speeds : Fin n → ℚ)
    (hpos : ∀ i, 0 < speeds i) (i : Fin n) :
    (clearRationalSpeed speeds i : ℝ) =
      (rationalCommonDenominator speeds : ℝ) * (speeds i : ℝ) := by
  let D := rationalCommonDenominator speeds
  let den := (speeds i).den
  let q := D / den
  have hnum : (0 : ℤ) < (speeds i).num := Rat.num_pos.mpr (hpos i)
  have hden : den ≠ 0 := (speeds i).den_nz
  have hdvd : den ∣ D := rational_den_dvd_common speeds i
  have hfactor : q * den = D := Nat.div_mul_cancel hdvd
  have hnatabs : (((speeds i).num.natAbs : ℕ) : ℝ) = ((speeds i).num : ℝ) := by
    calc
      (((speeds i).num.natAbs : ℕ) : ℝ) =
          (((((speeds i).num.natAbs : ℕ) : ℤ)) : ℝ) := by norm_num
      _ = ((speeds i).num : ℝ) := by
        rw [Int.natAbs_of_nonneg hnum.le]
  change (((speeds i).num.natAbs * q : ℕ) : ℝ) = (D : ℝ) * (speeds i : ℝ)
  rw [Nat.cast_mul, hnatabs, Rat.cast_def]
  change ((speeds i).num : ℝ) * (q : ℝ) =
    (D : ℝ) * (((speeds i).num : ℝ) / (den : ℝ))
  have hfactorReal : (q : ℝ) * (den : ℝ) = (D : ℝ) := by
    exact_mod_cast hfactor
  field_simp [show (den : ℝ) ≠ 0 by exact_mod_cast hden]
  exact hfactorReal

theorem clearRationalSpeed_pos {n : ℕ} (speeds : Fin n → ℚ)
    (hpos : ∀ i, 0 < speeds i) (i : Fin n) :
    0 < clearRationalSpeed speeds i := by
  apply Nat.mul_pos
  · exact Int.natAbs_pos.mpr (Rat.num_pos.mpr (hpos i)).ne'
  · apply Nat.div_pos
    · exact Nat.le_of_dvd (rationalCommonDenominator_pos speeds)
        (rational_den_dvd_common speeds i)
    · exact (speeds i).den_pos

theorem clearRationalSpeed_injective {n : ℕ} (speeds : Fin n → ℚ)
    (hinjective : Function.Injective speeds) (hpos : ∀ i, 0 < speeds i) :
    Function.Injective (clearRationalSpeed speeds) := by
  intro i j hij
  have hcast : (clearRationalSpeed speeds i : ℝ) =
      (clearRationalSpeed speeds j : ℝ) := by exact_mod_cast hij
  rw [clearRationalSpeed_cast speeds hpos i,
    clearRationalSpeed_cast speeds hpos j] at hcast
  have hD : (rationalCommonDenominator speeds : ℝ) ≠ 0 := by
    exact_mod_cast (rationalCommonDenominator_pos speeds).ne'
  have hratCast : (speeds i : ℝ) = (speeds j : ℝ) := by
    exact mul_left_cancel₀ hD hcast
  apply hinjective
  exact Rat.cast_injective hratCast

/-- The fixed-dimensional positive rational formulation with distinct speeds. -/
def DistinctPositiveRationalConjecture : Prop :=
  ∀ (n : ℕ), 1 ≤ n →
    ∀ speeds : Fin n → ℚ,
      Function.Injective speeds → (∀ i, 0 < speeds i) →
        ∃ time : ℝ, ∀ i,
          (((n + 1 : ℕ) : ℝ)⁻¹) ≤
            circleNorm (time * (speeds i : ℝ))

/-- Clearing a common denominator is an exact equivalence between the
distinct positive-rational and positive-natural formulations. -/
theorem positiveIntegerConjecture_iff_distinctPositiveRationalConjecture :
    PositiveIntegerConjecture ↔ DistinctPositiveRationalConjecture := by
  constructor
  · intro hInteger n hn speeds hinjective hpos
    let cleared : Fin n → ℕ := clearRationalSpeed speeds
    have hclearedInjective : Function.Injective cleared :=
      clearRationalSpeed_injective speeds hinjective hpos
    have hclearedPos : ∀ i, 0 < cleared i :=
      clearRationalSpeed_pos speeds hpos
    obtain ⟨time, htime⟩ :=
      hInteger n hn cleared hclearedInjective hclearedPos
    refine ⟨time * (rationalCommonDenominator speeds : ℝ), fun i => ?_⟩
    have hi := htime i
    rw [clearRationalSpeed_cast speeds hpos i] at hi
    simpa [circleNorm, mul_assoc] using hi
  · intro hRational n hn speeds hinjective hpos
    let rationalSpeeds : Fin n → ℚ := fun i => (speeds i : ℚ)
    have hrationalInjective : Function.Injective rationalSpeeds := by
      intro i j hij
      apply hinjective
      change (speeds i : ℚ) = (speeds j : ℚ) at hij
      exact_mod_cast hij
    have hrationalPos : ∀ i, 0 < rationalSpeeds i := by
      intro i
      change (0 : ℚ) < (speeds i : ℚ)
      exact_mod_cast hpos i
    obtain ⟨time, htime⟩ :=
      hRational n hn rationalSpeeds hrationalInjective hrationalPos
    refine ⟨time, fun i => ?_⟩
    simpa [circleNorm, rationalSpeeds] using htime i

end LonelyRunner
