import LonelyRunner.FastRunnerInsertion

/-!
# Structured comparable-speed classes

This file formalizes the elementary "minimum-scale residue bands" argument.
It deliberately keeps the closed endpoints: equality with the target circular
distance is permitted by the Lonely Runner Conjecture.
-/

namespace LonelyRunner

/-- Circular distance from zero is unchanged by reversing a real lift. -/
theorem circleNorm_neg (x : ℝ) : circleNorm (-x) = circleNorm x := by
  unfold circleNorm
  rw [AddCircle.coe_neg, norm_neg]

/-- Replacing a real lift by its absolute value does not change its circular
distance from zero. -/
theorem circleNorm_abs (x : ℝ) : circleNorm |x| = circleNorm x := by
  rcases le_total 0 x with hx | hx
  · rw [abs_of_nonneg hx]
  · rw [abs_of_nonpos hx, circleNorm_neg]

/-- Every point in the closed middle band `[q + δ, q + 1 - δ]` has
circular distance at least `δ`.  This is the basic reusable residue-band
lemma; `q` may be any integer. -/
theorem circleNorm_ge_of_int_band (q : ℤ) (x δ : ℝ)
    (hδ0 : 0 ≤ δ) (_hδhalf : δ ≤ (1 : ℝ) / 2)
    (hlower : (q : ℝ) + δ ≤ x)
    (hupper : x ≤ (q : ℝ) + 1 - δ) :
    δ ≤ circleNorm x := by
  let y : ℝ := x - (q : ℝ)
  have hyLower : δ ≤ y := by
    dsimp [y]
    linarith
  have hyUpper : y ≤ 1 - δ := by
    dsimp [y]
    linarith
  have hy0 : 0 ≤ y := le_trans hδ0 hyLower
  have hy1 : y ≤ 1 := by linarith
  have hperiod : circleNorm x = circleNorm y := by
    have hx : x = (q : ℝ) + y := by
      dsimp [y]
      ring
    rw [hx, circleNorm_add_int]
  rw [hperiod]
  by_cases hyHalf : y ≤ (1 : ℝ) / 2
  · rw [circleNorm_eq_abs_of_abs_le_half]
    · simpa [abs_of_nonneg hy0] using hyLower
    · simpa [abs_of_nonneg hy0] using hyHalf
  · have hyHalf' : (1 : ℝ) / 2 ≤ y := le_of_not_ge hyHalf
    have hshift : circleNorm y = circleNorm ((-1 : ℤ) + y) := by
      symm
      exact circleNorm_add_int (-1) y
    rw [hshift, circleNorm_eq_abs_of_abs_le_half]
    · rw [show ((-1 : ℤ) : ℝ) + y = -(1 - y) by norm_num; ring]
      rw [abs_neg, abs_of_nonneg]
      · linarith
      · linarith
    · rw [show ((-1 : ℤ) : ℝ) + y = -(1 - y) by norm_num; ring]
      rw [abs_neg, abs_of_nonneg]
      · linarith
      · linarith

/-- Sign-invariant version of `circleNorm_ge_of_int_band`.  It is convenient
when a speed is specified only through its absolute value. -/
theorem circleNorm_ge_of_abs_int_band (q : ℤ) (x δ : ℝ)
    (hδ0 : 0 ≤ δ) (hδhalf : δ ≤ (1 : ℝ) / 2)
    (hlower : (q : ℝ) + δ ≤ |x|)
    (hupper : |x| ≤ (q : ℝ) + 1 - δ) :
    δ ≤ circleNorm x := by
  rw [← circleNorm_abs x]
  exact circleNorm_ge_of_int_band q |x| δ hδ0 hδhalf hlower hupper

/-- Minimum-scale residue-band criterion with its explicit witness.

For `n` moving speeds, put `N = n + 1`.  If every normalized absolute speed
lies in one of the closed bands `[qN + 1, qN + n]`, then time
`1 / (N * base)` gives every coordinate circular distance at least `1 / N`.
The speeds may have arbitrary signs, and the normalized ratios need not be
rational. -/
theorem minimumScaleResidueBands {n : ℕ} (hn : 2 ≤ n)
    (speeds : Fin n → ℝ) (base : ℝ) (hbase : 0 < base)
    (hbands : ∀ i, ∃ q : ℕ,
      (((q * (n + 1) + 1 : ℕ) : ℝ) ≤ |speeds i| / base) ∧
      (|speeds i| / base ≤ ((q * (n + 1) + n : ℕ) : ℝ))) :
    ∀ i, (((n + 1 : ℕ) : ℝ)⁻¹) ≤
      circleNorm (((((n + 1 : ℕ) : ℝ) * base)⁻¹) * speeds i) := by
  intro i
  obtain ⟨q, hqLower, hqUpper⟩ := hbands i
  let N : ℝ := ((n + 1 : ℕ) : ℝ)
  let δ : ℝ := N⁻¹
  let time : ℝ := (N * base)⁻¹
  have hN : 0 < N := by
    dsimp [N]
    positivity
  have hδ0 : 0 ≤ δ := inv_nonneg.mpr hN.le
  have hNge : (2 : ℝ) ≤ N := by
    dsimp [N]
    exact_mod_cast (by omega : 2 ≤ n + 1)
  have hδN : δ * N = 1 := by
    dsimp [δ]
    exact inv_mul_cancel₀ hN.ne'
  have hδhalf : δ ≤ (1 : ℝ) / 2 := by
    have hmul := mul_le_mul_of_nonneg_right hNge hδ0
    nlinarith
  have htimeAbs : |time * speeds i| = |speeds i| / (N * base) := by
    rw [abs_mul, abs_inv, abs_mul, abs_of_pos hN, abs_of_pos hbase]
    field_simp
  have hscale : |speeds i| / (N * base) = (|speeds i| / base) / N := by
    field_simp
  have hqLower' : (q : ℝ) + δ ≤ |time * speeds i| := by
    rw [htimeAbs, hscale]
    rw [le_div_iff₀ hN]
    have hcast : (((q * (n + 1) + 1 : ℕ) : ℝ)) =
        (q : ℝ) * ((n + 1 : ℕ) : ℝ) + 1 := by norm_num
    rw [hcast] at hqLower
    calc
      ((q : ℝ) + δ) * N = (q : ℝ) * N + 1 := by
        rw [add_mul, hδN]
      _ ≤ |speeds i| / base := by simpa [N] using hqLower
  have hqUpper' : |time * speeds i| ≤ (q : ℝ) + 1 - δ := by
    rw [htimeAbs, hscale]
    rw [div_le_iff₀ hN]
    have hcast : (((q * (n + 1) + n : ℕ) : ℝ)) =
        (q : ℝ) * ((n + 1 : ℕ) : ℝ) + n := by norm_num
    rw [hcast] at hqUpper
    calc
      |speeds i| / base ≤ (q : ℝ) * N + (n : ℝ) := by
        simpa [N] using hqUpper
      _ = ((q : ℝ) + 1 - δ) * N := by
        rw [sub_mul, add_mul, hδN]
        dsimp [N]
        push_cast
        ring
  have hband := circleNorm_ge_of_abs_int_band (q : ℤ) (time * speeds i) δ
    hδ0 hδhalf (by simpa using hqLower') (by simpa using hqUpper')
  simpa [time, δ, N] using hband

end LonelyRunner
