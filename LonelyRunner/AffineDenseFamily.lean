import LonelyRunner.AffineGridArithmetic

/-!
# An explicit lifted family for every runner count at least seven

The displayed rational time treats the three fixed speeds and every lifted
speed at once.  Its phase decompositions use integer periodicity directly;
neither primality nor parity of the runner count is required.
-/

namespace LonelyRunner

/-- Convert a closed numerator band to a circle-distance bound, retaining
the integer part of the original speed's phase. -/
private theorem circleNorm_ge_of_fraction_band
    (N M R : ℝ) (k : ℤ) (hN : 2 ≤ N) (hM : 0 < M)
    (hlower : M ≤ R) (hupper : R ≤ (N - 1) * M) :
    N⁻¹ ≤ circleNorm ((k : ℝ) + R / (N * M)) := by
  have hNpos : 0 < N := by linarith
  have hNM : 0 < N * M := mul_pos hNpos hM
  have hunit : N⁻¹ = M / (N * M) := by
    rw [inv_eq_one_div]
    field_simp
  have htop : 1 - N⁻¹ = (N - 1) * M / (N * M) := by
    rw [inv_eq_one_div]
    field_simp
  refine circleNorm_ge_of_int_band k _ _ (by positivity) ?_ ?_ ?_
  · rw [inv_eq_one_div]
    exact one_div_le_one_div_of_le (by norm_num) hN
  · apply (add_le_add_iff_left _).mpr
    rw [hunit]
    exact (div_le_div_iff_of_pos_right hNM).mpr hlower
  · have hfrac : R / (N * M) ≤ 1 - N⁻¹ := by
      rw [htop]
      exact (div_le_div_iff_of_pos_right hNM).mpr hupper
    linarith

/-- The primitive lifted family `(2, 3, N, 4*H, ..., (N-1)*H)` has the
explicit witness `(N^3-2)/(N*M)` for every integer runner count `N ≥ 7`.
All `N-1` original speeds appear in the conclusion, with the closed `1/N`
threshold and arbitrary nonnegative lift parameter `z`. -/
theorem affine_dense_family_witness (N z : ℕ) (hN : 7 ≤ N) :
    let M := N ^ 2 * (N - 1) + 1
    let H := 1 + M * (1 + N * z)
    let t : ℝ := ((N ^ 3 - 2 : ℕ) : ℝ) / ((N : ℝ) * (M : ℝ))
    (N : ℝ)⁻¹ ≤ circleNorm (t * 2) ∧
    (N : ℝ)⁻¹ ≤ circleNorm (t * 3) ∧
    (N : ℝ)⁻¹ ≤ circleNorm (t * (N : ℝ)) ∧
    ∀ j : ℕ, 4 ≤ j → j < N →
      (N : ℝ)⁻¹ ≤ circleNorm (t * (j * H : ℕ)) := by
  let M := N ^ 2 * (N - 1) + 1
  let H := 1 + M * (1 + N * z)
  let n := N ^ 3 - 2
  let b : ℝ := (N : ℝ) ^ 2 - 3
  let t : ℝ := (n : ℝ) / ((N : ℝ) * (M : ℝ))
  change (N : ℝ)⁻¹ ≤ circleNorm (t * 2) ∧
    (N : ℝ)⁻¹ ≤ circleNorm (t * 3) ∧
    (N : ℝ)⁻¹ ≤ circleNorm (t * (N : ℝ)) ∧
    ∀ j : ℕ, 4 ≤ j → j < N →
      (N : ℝ)⁻¹ ≤ circleNorm (t * (j * H : ℕ))
  have hNr : (7 : ℝ) ≤ N := by exact_mod_cast hN
  have hNpos : (0 : ℝ) < N := by linarith
  have hNtwo : (2 : ℝ) ≤ N := by linarith
  have hMposNat : 0 < M := by dsimp [M]; omega
  have hMpos : (0 : ℝ) < M := by exact_mod_cast hMposNat
  have hMc : (M : ℝ) = (N : ℝ) ^ 2 * ((N : ℝ) - 1) + 1 := by
    dsimp [M]
    push_cast [Nat.cast_sub (by omega : 1 ≤ N)]
    ring
  have hnPow : 2 ≤ N ^ 3 := by
    have := Nat.pow_le_pow_left hN 3
    norm_num at this
    omega
  have hnc : (n : ℝ) = (N : ℝ) ^ 3 - 2 := by
    dsimp [n]
    push_cast [Nat.cast_sub hnPow]
    ring
  have hn : (n : ℝ) = (M : ℝ) + b := by
    rw [hnc, hMc]
    dsimp [b]
    ring
  have hbpos : 0 < b := by dsimp [b]; nlinarith
  have hcorrTop : ((N : ℝ) - 1) * b < M := by
    rw [hMc]
    dsimp [b]
    nlinarith
  have hcorr : ∀ a : ℝ, 0 ≤ a → a ≤ (N : ℝ) - 1 → a * b < M := by
    intro a _ha haN
    exact (mul_le_mul_of_nonneg_right haN hbpos.le).trans_lt hcorrTop
  -- Every ordinary row stays within one good floor interval.  This uniform
  -- estimate is used for both fixed rows and all lifted indices.
  have hband : ∀ a h : ℝ, 0 ≤ a → a ≤ (N : ℝ) - 1 →
      1 ≤ h → h ≤ (N : ℝ) - 2 →
      (M : ℝ) ≤ h * M + a * b ∧ h * M + a * b ≤ ((N : ℝ) - 1) * M := by
    intro a h ha haN hh hhN
    have hc := hcorr a ha haN
    have hc0 := mul_nonneg ha hbpos.le
    have hlo := mul_le_mul_of_nonneg_right hh hMpos.le
    have hup := mul_le_mul_of_nonneg_right hhN hMpos.le
    constructor <;> nlinarith
  have hfixed : ∀ a : ℝ, 1 ≤ a → a ≤ 3 →
      (N : ℝ)⁻¹ ≤ circleNorm (t * a) := by
    intro a ha ha3
    have hphase : t * a = (0 : ℤ) + (a * M + a * b) / ((N : ℝ) * M) := by
      dsimp [t]
      rw [hn]
      push_cast
      ring
    rw [hphase]
    obtain ⟨hlo, hup⟩ := hband a a (by linarith) (by linarith) ha (by linarith)
    exact circleNorm_ge_of_fraction_band N M _ 0 hNtwo hMpos hlo hup
  have hstarLower : (M : ℝ) ≤ (N : ℝ) * b := by
    rw [hMc]
    dsimp [b]
    nlinarith
  have hstarUpper : (N : ℝ) * b ≤ ((N : ℝ) - 1) * M := by
    have hmLarge : (2 : ℝ) * b ≤ M := by
      have := mul_le_mul_of_nonneg_right (show (2 : ℝ) ≤ (N : ℝ) - 1 by linarith) hbpos.le
      linarith
    have := mul_le_mul_of_nonneg_right hmLarge (show (0 : ℝ) ≤ (N : ℝ) - 1 by linarith)
    nlinarith
  have hstarPhase : t * (N : ℝ) = (1 : ℤ) +
      ((N : ℝ) * b) / ((N : ℝ) * M) := by
    dsimp [t]
    rw [hn]
    push_cast
    field_simp
  refine ⟨hfixed 2 (by norm_num) (by norm_num),
    hfixed 3 (by norm_num) (by norm_num), ?_, ?_⟩
  · rw [hstarPhase]
    exact circleNorm_ge_of_fraction_band N M _ 1 hNtwo hMpos hstarLower hstarUpper
  · intro j hj hjN
    have hjr : (4 : ℝ) ≤ j := by exact_mod_cast hj
    have hjNr : (j : ℝ) < N := by exact_mod_cast hjN
    have hjLast : (j : ℝ) ≤ (N : ℝ) - 1 := by
      have : j + 1 ≤ N := by omega
      have hr : (j : ℝ) + 1 ≤ N := by exact_mod_cast this
      linarith
    let k : ℤ := (j : ℤ) * ((N : ℤ) ^ 2 + (z : ℤ) * (n : ℤ)) - 1
    have hHc : (H : ℝ) = 1 + (M : ℝ) * (1 + (N : ℝ) * z) := by
      dsimp [H]
      push_cast
      ring
    -- The integer part retains the entire lift coefficient, so the argument
    -- applies to every z without restricting the size of the lifted speeds.
    have hphase : t * (j * H : ℕ) = (k : ℝ) +
        (((N : ℝ) - j) * M + (j : ℝ) * b) / ((N : ℝ) * M) := by
      dsimp [t, k]
      push_cast
      rw [hHc]
      field_simp
      rw [hnc, hMc]
      dsimp [b]
      ring
    rw [hphase]
    obtain ⟨hlo, hup⟩ := hband j ((N : ℝ) - j)
      (by linarith) hjLast (by linarith) (by linarith)
    exact circleNorm_ge_of_fraction_band N M _ k hNtwo hMpos hlo hup

end LonelyRunner
