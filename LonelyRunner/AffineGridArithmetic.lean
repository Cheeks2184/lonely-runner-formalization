import LonelyRunner.PivotResidues

/-!
# Arithmetic bands for rounded affine grids

This is the real-arithmetic endpoint of the affine-grid construction.  Its
hypotheses are entirely integral; the conclusion is a closed circle-distance
bound for the corresponding rational phase.
-/

namespace LonelyRunner


/-- The combined residue-band form of the affine-grid arithmetic.  It keeps
the correction `a * beta` with the residue, which is useful when a slope
vanishes and the separate strict correction estimate is unavailable. -/
theorem circleNorm_ge_of_affine_grid_residue_band
    (N M s r0 r beta a u : ℕ)
    (hN : 2 ≤ N) (hM : 0 < M) (hu : u ≡ a [MOD M])
    (hr : N * r = M * r0 + beta) (haM : a < M)
    (hlower : M ≤ ((s * u + r0 * a) % N) * M + a * beta)
    (hupper : ((s * u + r0 * a) % N) * M + a * beta ≤ (N - 1) * M) :
    ((N : ℝ)⁻¹) ≤ circleNorm (((s : ℝ) / (N : ℝ) + (r : ℝ) / (M : ℝ)) *
      (u : ℝ)) := by
  have hNpos : 0 < N := by omega
  have huMod : u % M = a := by
    rw [Nat.ModEq] at hu
    simpa [Nat.mod_eq_of_lt haM] using hu
  have huDecomp : u = M * (u / M) + a := by
    rw [← huMod]
    simpa [Nat.mul_comm] using (Nat.div_add_mod u M).symm
  let H := s * u + r0 * a
  let h := H % N
  let k := H / N + (u / M) * r
  have hHdecomp : H = N * (H / N) + h := by
    dsimp [h]
    simpa [Nat.mul_comm] using (Nat.div_add_mod H N).symm
  have hphase :
      ((s : ℝ) / (N : ℝ) + (r : ℝ) / (M : ℝ)) * (u : ℝ) =
        (k : ℝ) + ((h : ℝ) * (M : ℝ) + (a : ℝ) * (beta : ℝ)) /
          ((N : ℝ) * (M : ℝ)) := by
    have hNreal : (N : ℝ) ≠ 0 := by exact_mod_cast hNpos.ne'
    have hMreal : (M : ℝ) ≠ 0 := by exact_mod_cast hM.ne'
    have hrReal : (N : ℝ) * (r : ℝ) = (M : ℝ) * (r0 : ℝ) + (beta : ℝ) := by exact_mod_cast hr
    have huReal : (u : ℝ) = (M : ℝ) * ((u / M : ℕ) : ℝ) + (a : ℝ) := by exact_mod_cast huDecomp
    have hHReal : (H : ℝ) = (N : ℝ) * ((H / N : ℕ) : ℝ) + (h : ℝ) := by exact_mod_cast hHdecomp
    have hHexpand : (H : ℝ) = (s : ℝ) * ((M : ℝ) * ((u / M : ℕ) : ℝ) + (a : ℝ)) + (r0 : ℝ) * (a : ℝ) := by
      dsimp [H]
      push_cast
      rw [huReal]
    have hclear :
        ((s : ℝ) * (M : ℝ) + (N : ℝ) * (r : ℝ)) * (u : ℝ) =
          (M : ℝ) * ((N : ℝ) * (((H / N : ℕ) : ℝ) + ((u / M : ℕ) : ℝ) * (r : ℝ)) + (h : ℝ)) +
            (a : ℝ) * (beta : ℝ) := by
      calc
        ((s : ℝ) * (M : ℝ) + (N : ℝ) * (r : ℝ)) * (u : ℝ) =
            (M : ℝ) * (H : ℝ) + (M : ℝ) * ((u / M : ℕ) : ℝ) * ((N : ℝ) * (r : ℝ)) + (a : ℝ) * (beta : ℝ) := by
              rw [huReal, hHexpand, hrReal]
              ring
        _ = (M : ℝ) * ((N : ℝ) * (((H / N : ℕ) : ℝ) + ((u / M : ℕ) : ℝ) * (r : ℝ)) + (h : ℝ)) +
            (a : ℝ) * (beta : ℝ) := by rw [hHReal]; ring
    dsimp [k]
    field_simp
    have := hclear
    push_cast
    nlinarith
  have hNMpos : (0 : ℝ) < (N : ℝ) * (M : ℝ) := mul_pos (by exact_mod_cast hNpos) (by exact_mod_cast hM)
  have hlowReal : (M : ℝ) ≤ (h : ℝ) * (M : ℝ) + (a : ℝ) * (beta : ℝ) := by
    exact_mod_cast (by simpa [H, h] using hlower)
  have huppReal : (h : ℝ) * (M : ℝ) + (a : ℝ) * (beta : ℝ) ≤ ((N : ℝ) - 1) * (M : ℝ) := by
    have huppNat : h * M + a * beta ≤ (N - 1) * M := by simpa [H, h] using hupper
    have hcast : ((h * M + a * beta : ℕ) : ℝ) ≤ (((N - 1) * M : ℕ) : ℝ) := by
      exact_mod_cast huppNat
    push_cast [Nat.cast_sub (by omega : 1 ≤ N)] at hcast
    exact hcast
  rw [hphase]
  refine circleNorm_ge_of_int_band (k : ℤ)
    ((k : ℝ) + ((h : ℝ) * (M : ℝ) + (a : ℝ) * (beta : ℝ)) / ((N : ℝ) * (M : ℝ)))
    ((N : ℝ)⁻¹) (by positivity) ?_ ?_ ?_
  · rw [inv_eq_one_div]
    exact one_div_le_one_div_of_le (by norm_num) (by exact_mod_cast hN)
  · push_cast
    rw [inv_eq_one_div]
    change (k : ℝ) + 1 / (N : ℝ) ≤ _
    apply (add_le_add_iff_left _).mpr
    have hunit : (1 : ℝ) / (N : ℝ) = (M : ℝ) / ((N : ℝ) * (M : ℝ)) := by
      field_simp
    rw [hunit]
    apply (div_le_div_iff_of_pos_right hNMpos).mpr
    nlinarith
  · push_cast
    rw [inv_eq_one_div]
    change _ ≤ (k : ℝ) + 1 - 1 / (N : ℝ)
    have htop : (1 : ℝ) - 1 / (N : ℝ) =
        ((N : ℝ) - 1) * (M : ℝ) / ((N : ℝ) * (M : ℝ)) := by
      field_simp
    have hfrac : ((h : ℝ) * (M : ℝ) + (a : ℝ) * (beta : ℝ)) /
        ((N : ℝ) * (M : ℝ)) ≤ (1 : ℝ) - 1 / (N : ℝ) := by
      rw [htop]
      apply (div_le_div_iff_of_pos_right hNMpos).mpr
      nlinarith
    linarith

/-- The original separated residue hypotheses imply the combined closed band.
This compatibility wrapper preserves the earlier public interface. -/
theorem circleNorm_ge_of_affine_grid_band
    (N M s r0 r beta a u : ℕ)
    (hN : 2 ≤ N) (hM : 0 < M) (hu : u ≡ a [MOD M])
    (hr : N * r = M * r0 + beta) (hbeta : beta ≤ N - 1)
    (ha : (N - 1) * a < M)
    (hlower : 1 ≤ (s * u + r0 * a) % N)
    (hupper : (s * u + r0 * a) % N ≤ N - 2) :
    ((N : ℝ)⁻¹) ≤ circleNorm (((s : ℝ) / (N : ℝ) + (r : ℝ) / (M : ℝ)) *
      (u : ℝ)) := by
  have haM : a < M := by
    have hNm1 : 1 ≤ N - 1 := by omega
    nlinarith
  have habeta : a * beta < M := by
    have hleft : a * beta ≤ a * (N - 1) := Nat.mul_le_mul_left a hbeta
    nlinarith [ha]
  apply circleNorm_ge_of_affine_grid_residue_band N M s r0 r beta a u
    hN hM hu hr haM
  · have hprod : M ≤ ((s * u + r0 * a) % N) * M := by
      simpa [Nat.mul_comm] using Nat.le_mul_of_pos_right M hlower
    exact hprod.trans (Nat.le_add_right _ _)
  · have hh : (s * u + r0 * a) % N * M ≤ (N - 2) * M :=
      Nat.mul_le_mul_right M hupper
    have hcorr : a * beta ≤ M - 1 := by omega
    calc
      (s * u + r0 * a) % N * M + a * beta ≤ (N - 2) * M + (M - 1) :=
        Nat.add_le_add hh hcorr
      _ = (N - 1) * M - 1 := by
        have hMone : 1 ≤ M := by omega
        have hNsub : N - 1 = (N - 2) + 1 := by omega
        rw [hNsub, Nat.add_mul]
        simp only [Nat.one_mul]
        omega
      _ ≤ (N - 1) * M := Nat.pred_le _

end LonelyRunner
