import LonelyRunner.Definitions

/-!
# Quantitative fast-runner insertion

This file formalizes the metric and phase-adjustment ingredients for the
coordinatewise insertion theorem described in `docs/fast-runner-insertion.md`.
All inequalities are closed; signs of speeds are retained.
-/

namespace LonelyRunner

/-- Distance of a real phase to the origin in `ℝ / ℤ`. -/
noncomputable def circleNorm (x : ℝ) : ℝ :=
  ‖(x : UnitCircle)‖

theorem circleNorm_eq_abs_sub_round (x : ℝ) :
    circleNorm x = |x - (round x : ℝ)| := by
  exact UnitAddCircle.norm_eq

theorem circleNorm_eq_abs_of_abs_le_half {x : ℝ} (hx : |x| ≤ (1 : ℝ) / 2) :
    circleNorm x = |x| := by
  exact (AddCircle.norm_coe_eq_abs_iff (1 : ℝ) one_ne_zero).mpr (by simpa using hx)

theorem circleNorm_add_int (z : ℤ) (x : ℝ) :
    circleNorm ((z : ℝ) + x) = circleNorm x := by
  unfold circleNorm
  rw [AddCircle.coe_add]
  have hz : (((z : ℝ) : UnitCircle)) = 0 := by
    exact (AddCircle.coe_eq_zero_iff (p := (1 : ℝ))).mpr ⟨z, by simp⟩
  rw [hz, zero_add]

/-- The distance-to-nearest-integer function is 1-Lipschitz. -/
theorem abs_circleNorm_sub_circleNorm_le (x y : ℝ) :
    |circleNorm x - circleNorm y| ≤ |x - y| := by
  calc
    |circleNorm x - circleNorm y| ≤
        ‖(x : UnitCircle) - (y : UnitCircle)‖ :=
      abs_norm_sub_norm_le _ _
    _ = ‖((x - y : ℝ) : UnitCircle)‖ := by rw [AddCircle.coe_sub]
    _ = |(x - y) - (round (x - y) : ℝ)| := UnitAddCircle.norm_eq
    _ ≤ |x - y| := by simpa using (round_le (x - y) 0)

/-- A one-sided form convenient for perturbation estimates. -/
theorem circleNorm_sub_abs_le_circleNorm (x y : ℝ) :
    circleNorm x - |x - y| ≤ circleNorm y := by
  have h := abs_circleNorm_sub_circleNorm_le x y
  linarith [le_abs_self (circleNorm x - circleNorm y)]

/-- Any phase can be moved into the closed `δ`-good part of the circle by a
real shift of magnitude at most `δ`, provided `0 ≤ δ ≤ 1/2`. -/
theorem exists_small_shift_circleNorm_ge (x δ : ℝ) (hδ0 : 0 ≤ δ)
    (hδhalf : δ ≤ (1 : ℝ) / 2) :
    ∃ s : ℝ, |s| ≤ δ ∧ δ ≤ circleNorm (x + s) := by
  let r : ℝ := x - (round x : ℝ)
  have hnormx : circleNorm x = |r| := by
    simpa [r] using circleNorm_eq_abs_sub_round x
  by_cases hgood : δ ≤ |r|
  · refine ⟨0, by simpa using hδ0, ?_⟩
    simpa [hnormx] using hgood
  have hrlt : |r| < δ := lt_of_not_ge hgood
  by_cases hr0 : 0 ≤ r
  · refine ⟨δ - r, ?_, ?_⟩
    · rw [abs_of_nonneg]
      · linarith
      · simpa [abs_of_nonneg hr0] using hrlt.le
    · have hphase : x + (δ - r) = (round x : ℝ) + δ := by
        dsimp [r]
        ring
      rw [hphase, circleNorm_add_int]
      rw [circleNorm_eq_abs_of_abs_le_half]
      · simp [abs_of_nonneg hδ0]
      · simpa [abs_of_nonneg hδ0] using hδhalf
  · have hrneg : r < 0 := lt_of_not_ge hr0
    have hsum0 : 0 ≤ δ + r := by
      rw [abs_of_neg hrneg] at hrlt
      linarith
    refine ⟨-δ - r, ?_, ?_⟩
    · rw [show -δ - r = -(δ + r) by ring, abs_neg, abs_of_nonneg hsum0]
      linarith
    · have hphase : x + (-δ - r) = (round x : ℝ) + (-δ) := by
        dsimp [r]
        ring
      rw [hphase, circleNorm_add_int]
      rw [circleNorm_eq_abs_of_abs_le_half]
      · simp [abs_of_nonneg hδ0]
      · simpa [abs_of_nonneg hδ0] using hδhalf

/-- Insert a new relative speed `newSpeed` while perturbing a witness for `n`
old moving speeds.  Equality is retained in both the speed hypothesis and every
conclusion, and `newSpeed` may be negative. -/
theorem fastRunnerInsertion {n : ℕ} (speeds : Fin n → ℝ) (time₀ newSpeed : ℝ)
    (hold : ∀ i,
      (((n + 1 : ℕ) : ℝ)⁻¹) ≤ circleNorm (time₀ * speeds i))
    (hnewSpeed : newSpeed ≠ 0)
    (hfast : ∀ i,
      (((n + 1 : ℕ) : ℝ) * |speeds i|) ≤ |newSpeed|) :
    ∃ time : ℝ,
      |time - time₀| ≤ (((n + 2 : ℕ) : ℝ)⁻¹) / |newSpeed| ∧
      (((n + 2 : ℕ) : ℝ)⁻¹) ≤ circleNorm (time * newSpeed) ∧
      ∀ i, (((n + 2 : ℕ) : ℝ)⁻¹) ≤ circleNorm (time * speeds i) := by
  let a : ℝ := ((n + 1 : ℕ) : ℝ)
  let b : ℝ := ((n + 2 : ℕ) : ℝ)
  let δ : ℝ := b⁻¹
  have ha : 0 < a := by
    dsimp [a]
    positivity
  have hb : 0 < b := by
    dsimp [b]
    positivity
  have hab : b = a + 1 := by
    dsimp [a, b]
    norm_cast
  have hδ0 : 0 ≤ δ := inv_nonneg.mpr hb.le
  have hbge : (2 : ℝ) ≤ b := by
    dsimp [b]
    norm_num
  have hδb : δ * b = 1 := by
    exact inv_mul_cancel₀ hb.ne'
  have hδhalf : δ ≤ (1 : ℝ) / 2 := by
    have hmul := mul_le_mul_of_nonneg_left hbge hδ0
    nlinarith
  obtain ⟨s, hs, hnew⟩ :=
    exists_small_shift_circleNorm_ge (time₀ * newSpeed) δ hδ0 hδhalf
  refine ⟨time₀ + s / newSpeed, ?_, ?_, ?_⟩
  · rw [add_sub_cancel_left, abs_div]
    exact div_le_div_of_nonneg_right hs (abs_nonneg newSpeed)
  · have hphase : (time₀ + s / newSpeed) * newSpeed =
        time₀ * newSpeed + s := by
      field_simp
    rw [hphase]
    simpa [δ, b] using hnew
  · intro i
    have hu : |speeds i| ≤ |newSpeed| / a := by
      apply (le_div_iff₀ ha).mpr
      simpa [a, mul_comm] using hfast i
    have hnewAbs : 0 < |newSpeed| := abs_pos.mpr hnewSpeed
    have hperturb :
        |time₀ * speeds i - (time₀ + s / newSpeed) * speeds i| ≤
          a⁻¹ - b⁻¹ := by
      calc
        |time₀ * speeds i - (time₀ + s / newSpeed) * speeds i| =
            |s| * |speeds i| / |newSpeed| := by
          rw [show time₀ * speeds i - (time₀ + s / newSpeed) * speeds i =
              -(s / newSpeed * speeds i) by ring]
          rw [abs_neg, abs_mul, abs_div]
          ring
        _ ≤ δ * (|newSpeed| / a) / |newSpeed| := by
          gcongr
        _ = δ / a := by
          dsimp [δ]
          field_simp
        _ = a⁻¹ - b⁻¹ := by
          dsimp [δ]
          rw [hab]
          field_simp
          ring
    have hlip := circleNorm_sub_abs_le_circleNorm
      (time₀ * speeds i) ((time₀ + s / newSpeed) * speeds i)
    have holdi : a⁻¹ ≤ circleNorm (time₀ * speeds i) := by
      simpa [a] using hold i
    have : b⁻¹ ≤ circleNorm ((time₀ + s / newSpeed) * speeds i) := by
      linarith
    simpa [b] using this

end LonelyRunner
