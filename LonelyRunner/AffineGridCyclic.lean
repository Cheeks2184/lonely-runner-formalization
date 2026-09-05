import LonelyRunner.PivotResidues

/-!
# Exact cyclic bands for affine grid phases

The correction may wrap around the circle arbitrarily many times. Reducing
the complete integral numerator modulo `N*M` retains precisely the closed
good band; no primality or small-correction hypothesis is used.
-/

namespace LonelyRunner

open scoped BigOperators

private theorem affine_grid_numerator_mod
    (N M s r0 r beta a u : ℕ)
    (_hM : 0 < M) (hu : u ≡ a [MOD M])
    (hr : N * r = M * r0 + beta) (ha : a < M) :
    ((s * M + N * r) * u) % (N * M) =
      (((s * u + r0 * a) % N) * M + a * beta) % (N * M) := by
  have humod : u % M = a := by
    rw [Nat.ModEq] at hu
    simpa [Nat.mod_eq_of_lt ha] using hu
  have huq : u = M * (u / M) + a := by
    rw [← humod]
    simpa [Nat.mul_comm] using (Nat.div_add_mod u M).symm
  let H := s * u + r0 * a
  have hH : H = N * (H / N) + H % N := by
    dsimp [H]
    simpa [Nat.mul_comm] using (Nat.div_add_mod (s * u + r0 * a) N).symm
  -- Keep the actual speed in H; only its lifted multiple of M disappears.
  have hcalc : (s * M + N * r) * u =
      N * M * (H / N + r * (u / M)) + (H % N * M + a * beta) := by
    calc
      (s * M + N * r) * u = M * (s * u) + N * r * u := by ring
      _ = M * (s * u) + N * r * (M * (u / M) + a) := by
        exact congrArg (fun x => M * (s * u) + N * r * x) huq
      _ = M * (s * u) + N * M * (r * (u / M)) + (N * r) * a := by ring
      _ = M * H + N * M * (r * (u / M)) + a * beta := by
        rw [hr]
        dsimp [H]
        ring
      _ = N * M * (H / N + r * (u / M)) + (H % N * M + a * beta) := by
        nth_rewrite 1 [hH]
        ring
  rw [hcalc, Nat.add_mod]
  simp
  rfl

/-- Exact wrapped closed-band form of the affine grid phase. -/
theorem circleNorm_affine_grid_iff_modular_band
    (N M s r0 r beta a u : ℕ)
    (hN : 2 ≤ N) (hM : 0 < M) (hu : u ≡ a [MOD M])
    (hr : N * r = M * r0 + beta) (ha : a < M) :
    ((N : ℝ)⁻¹) ≤ circleNorm (((s : ℝ) / N + (r : ℝ) / M) * u) ↔
      M ≤ (((s * u + r0 * a) % N * M + a * beta) % (N * M)) ∧
      (((s * u + r0 * a) % N * M + a * beta) % (N * M)) ≤ (N - 1) * M := by
  have hN0 : 0 < N := by omega
  have hNM0 : 0 < N * M := Nat.mul_pos hN0 hM
  let Y := (s * M + N * r) * u
  let X := ((s * u + r0 * a) % N) * M + a * beta
  have hmod : Y % (N * M) = X % (N * M) := by
    exact affine_grid_numerator_mod N M s r0 r beta a u hM hu hr ha
  have hphase : (((s : ℝ) / N + (r : ℝ) / M) * u) = (Y : ℝ) / (N * M : ℕ) := by
    dsimp [Y]
    push_cast
    field_simp
  have hNMreal : (0 : ℝ) < ((N * M : ℕ) : ℝ) := by exact_mod_cast hNM0
  have hthreshold : (N : ℝ)⁻¹ = (M : ℝ) / ((N * M : ℕ) : ℝ) := by
    rw [inv_eq_one_div]
    have hNreal : (N : ℝ) ≠ 0 := by exact_mod_cast hN0.ne'
    push_cast
    field_simp
  rw [hphase, circleNorm_nat_div_eq]
  rw [cyclicResidueDistance, hmod]
  change (N : ℝ)⁻¹ ≤ (min (X % (N*M)) ((N*M) - X % (N*M)) : ℕ) / ((N*M : ℕ) : ℝ) ↔
    M ≤ X % (N*M) ∧ X % (N*M) ≤ (N-1)*M
  have hrem := Nat.mod_lt X hNM0
  have hprod : N*M = (N-1)*M+M := by
    have hs : N = (N-1)+1 := by omega
    calc
      N*M = ((N-1)+1)*M := congrArg (fun x => x*M) hs
      _ = (N-1)*M+M := by ring
  -- Equality at either endpoint is good, including after multiple wraps.
  rw [hthreshold, div_le_div_iff_of_pos_right hNMreal]
  have hcast : (M : ℝ) ≤ (min (X % (N*M)) ((N*M)-X%(N*M)) : ℕ) ↔
      M ≤ min (X % (N*M)) ((N*M)-X%(N*M)) := by norm_cast
  rw [hcast, le_min_iff]
  omega

end LonelyRunner
