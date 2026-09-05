import LonelyRunner.PivotResidues

/-!
# Arithmetic bands for rounded affine grids

This is the real-arithmetic endpoint of the affine-grid construction.  Its
hypotheses are entirely integral; the conclusion is a closed circle-distance
bound for the corresponding rational phase.
-/

namespace LonelyRunner

theorem circleNorm_ge_of_affine_grid_band
    (N M s r0 r beta a u : ℕ)
    (hN : 2 ≤ N) (hM : 0 < M) (hu : u ≡ a [MOD M])
    (hr : N * r = M * r0 + beta) (hbeta : beta ≤ N - 1)
    (ha : (N - 1) * a < M)
    (hlower : 1 ≤ (s * u + r0 * a) % N)
    (hupper : (s * u + r0 * a) % N ≤ N - 2) :
    ((N : ℝ)⁻¹) ≤ circleNorm (((s : ℝ) / (N : ℝ) + (r : ℝ) / (M : ℝ)) *
      (u : ℝ)) := by
  have hNpos : 0 < N := by omega
  have haM : a < M := by
    have : 1 ≤ N - 1 := by omega
    nlinarith
  have huMod : u % M = a := by
    have := hu
    rw [Nat.ModEq] at this
    simpa [Nat.mod_eq_of_lt haM] using this
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
        (k : ℝ) + (h : ℝ) / (N : ℝ) +
          ((a : ℝ) * (beta : ℝ)) / ((N : ℝ) * (M : ℝ)) := by
    have hNreal : (N : ℝ) ≠ 0 := by exact_mod_cast hNpos.ne'
    have hMreal : (M : ℝ) ≠ 0 := by exact_mod_cast hM.ne'
    have hrReal : (N : ℝ) * (r : ℝ) = (M : ℝ) * (r0 : ℝ) + (beta : ℝ) := by
      exact_mod_cast hr
    have huReal : (u : ℝ) = (M : ℝ) * ((u / M : ℕ) : ℝ) + (a : ℝ) := by
      exact_mod_cast huDecomp
    have hHReal : (H : ℝ) = (N : ℝ) * ((H / N : ℕ) : ℝ) + (h : ℝ) := by
      exact_mod_cast hHdecomp
    have hHexpand : (H : ℝ) = (s : ℝ) *
        ((M : ℝ) * ((u / M : ℕ) : ℝ) + (a : ℝ)) + (r0 : ℝ) * (a : ℝ) := by
      dsimp [H]
      push_cast
      rw [huReal]
    have hclear :
        ((s : ℝ) * (M : ℝ) + (N : ℝ) * (r : ℝ)) * (u : ℝ) =
          (M : ℝ) * ((N : ℝ) *
            (((H / N : ℕ) : ℝ) + ((u / M : ℕ) : ℝ) * (r : ℝ)) + (h : ℝ)) +
            (a : ℝ) * (beta : ℝ) := by
      calc
        ((s : ℝ) * (M : ℝ) + (N : ℝ) * (r : ℝ)) * (u : ℝ) =
            (M : ℝ) * (H : ℝ) + (M : ℝ) * ((u / M : ℕ) : ℝ) *
              ((N : ℝ) * (r : ℝ)) + (a : ℝ) * (beta : ℝ) := by
                rw [huReal, hHexpand, hrReal]
                ring
        _ = (M : ℝ) * ((N : ℝ) *
            (((H / N : ℕ) : ℝ) + ((u / M : ℕ) : ℝ) * (r : ℝ)) + (h : ℝ)) +
            (a : ℝ) * (beta : ℝ) := by
              rw [hHReal]
              ring
    dsimp [k]
    field_simp
    simpa only [Nat.cast_add, Nat.cast_mul] using hclear
  have hdelta0 : (0 : ℝ) ≤ (N : ℝ)⁻¹ := by positivity
  have hdeltaHalf : (N : ℝ)⁻¹ ≤ (1 : ℝ) / 2 := by
    have hNreal : (0 : ℝ) < (N : ℝ) := by exact_mod_cast hNpos
    rw [inv_eq_one_div]
    exact one_div_le_one_div_of_le (by norm_num) (by exact_mod_cast hN)
  rw [hphase]
  refine circleNorm_ge_of_int_band (k : ℤ)
    ((k : ℝ) + (h : ℝ) / (N : ℝ) +
      ((a : ℝ) * (beta : ℝ)) / ((N : ℝ) * (M : ℝ)))
    ((N : ℝ)⁻¹) hdelta0 hdeltaHalf ?_ ?_
  · have hh : 1 ≤ h := by simpa [H, h] using hlower
    have hcorr : 0 ≤ ((a : ℝ) * (beta : ℝ)) / ((N : ℝ) * (M : ℝ)) := by positivity
    have hNreal : (0 : ℝ) < (N : ℝ) := by exact_mod_cast hNpos
    have hhReal : (1 : ℝ) ≤ (h : ℝ) := by exact_mod_cast hh
    have hfrac : (1 : ℝ) / (N : ℝ) ≤ (h : ℝ) / (N : ℝ) :=
      (div_le_div_iff_of_pos_right hNreal).mpr hhReal
    change (k : ℝ) + (N : ℝ)⁻¹ ≤ _
    rw [inv_eq_one_div]
    nlinarith
  · have hh : h ≤ N - 2 := by simpa [H, h] using hupper
    have habeta : a * beta < M := by
      have hleft : a * beta ≤ a * (N - 1) := Nat.mul_le_mul_left a hbeta
      nlinarith [ha]
    have hcorr : ((a : ℝ) * (beta : ℝ)) / ((N : ℝ) * (M : ℝ)) <
        (N : ℝ)⁻¹ := by
      have hMreal : (0 : ℝ) < (M : ℝ) := by exact_mod_cast hM
      have hNreal : (0 : ℝ) < (N : ℝ) := by exact_mod_cast hNpos
      have habetaReal : (a : ℝ) * (beta : ℝ) < (M : ℝ) := by
        exact_mod_cast habeta
      rw [inv_eq_one_div]
      field_simp
      nlinarith
    have hhReal : (h : ℝ) ≤ (N : ℝ) - 2 := by exact_mod_cast hh
    change _ ≤ (k : ℝ) + 1 - (N : ℝ)⁻¹
    rw [inv_eq_one_div]
    have hNreal : (0 : ℝ) < (N : ℝ) := by exact_mod_cast hNpos
    have hfrac : (h : ℝ) / (N : ℝ) ≤ 1 - 2 / (N : ℝ) := by
      calc
        (h : ℝ) / (N : ℝ) ≤ ((N : ℝ) - 2) / (N : ℝ) :=
          (div_le_div_iff_of_pos_right hNreal).mpr hhReal
        _ = 1 - 2 / (N : ℝ) := by field_simp
    have hsum : (h : ℝ) / (N : ℝ) +
        ((a : ℝ) * (beta : ℝ)) / ((N : ℝ) * (M : ℝ)) <
          1 - 1 / (N : ℝ) := by
      have htwo : (2 : ℝ) / (N : ℝ) = 2 * (1 / (N : ℝ)) := by ring
      have hcorr' := hcorr
      have hinv : (N : ℝ)⁻¹ = 1 / (N : ℝ) := by rw [inv_eq_one_div]
      rw [hinv] at hcorr'
      rw [htwo] at hfrac
      linarith
    linarith

end LonelyRunner
