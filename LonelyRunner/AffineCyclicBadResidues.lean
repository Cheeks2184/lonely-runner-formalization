import LonelyRunner.AffineGridCyclic
import Mathlib.Data.ZMod.Basic
import Mathlib.Tactic.LinearCombination

/-!
# Exact bad residues for a cyclic affine correction

Write `a*beta = M*k + e`, with `e < M`. After all complete wraps, the
phase numerator is `((h+k) % N)*M + e`. When `e=0`, both closed endpoints
are good, so only residue `-k` is bad. When `e>0`, the upper endpoint is
crossed at residue `-k-1`, producing exactly the two displayed bad residues.
No primality, parity, height or correction-size bound is needed.

Boundary controls use `(N,M,a,beta)=(5,7,2,7)`: residues 4 and 2 attain
the lower and upper endpoints. Changing `beta` to 8 makes residue 2 bad.
For `N=2`, a nonintegral correction excludes both residues. An actual-offset
control uses `(N,M,s,r0,r,beta,a,u)=(5,7,4,1,3,8,2,9)`: the actual phase
fails, whereas the incorrect offset `(s+r0)*a` would pass the bad-set test.
-/

namespace LonelyRunner

/-- The exact cyclic bad set; integral corrections exclude only one residue. -/
noncomputable def affineCyclicBadResidues (N M a beta : ℕ) : Finset (ZMod N) := by
  classical
  exact if a * beta % M = 0 then
    {-((a * beta / M : ℕ) : ZMod N)}
  else
    {-((a * beta / M : ℕ) : ZMod N), -((a * beta / M : ℕ) : ZMod N) - 1}

/-- A ring form of membership, retaining the special integral endpoint. -/
theorem not_mem_affineCyclicBadResidues_iff (N M a beta : ℕ) (h : ZMod N) :
    h ∉ affineCyclicBadResidues N M a beta ↔
      h + (a * beta / M : ℕ) ≠ 0 ∧
      (a * beta % M = 0 ∨ h + (a * beta / M : ℕ) ≠ -1) := by
  classical
  have hz : h = -((a * beta / M : ℕ) : ZMod N) ↔
      h + (a * beta / M : ℕ) = 0 := eq_neg_iff_add_eq_zero
  have hn : h = -((a * beta / M : ℕ) : ZMod N) - 1 ↔
      h + (a * beta / M : ℕ) = -1 := by
    constructor <;> intro he <;> linear_combination he
  by_cases he : a * beta % M = 0 <;>
    simp [affineCyclicBadResidues, he, hz, hn]

private theorem cyclic_correction_mod (N M h x : ℕ)
    (hN : 0 < N) (hM : 0 < M) :
    (h * M + x) % (N * M) = ((h + x / M) % N) * M + x % M := by
  let H := h + x / M
  have hcalc : h * M + x =
      (N * M) * (H / N) + (H % N * M + x % M) := by
    calc
      h * M + x = H * M + x % M := by
        dsimp [H]
        nlinarith [Nat.div_add_mod x M]
      _ = (N * (H / N) + H % N) * M + x % M := by
        rw [Nat.div_add_mod]
      _ = (N * M) * (H / N) + (H % N * M + x % M) := by ring
  have hr := Nat.mod_lt H hN
  have he := Nat.mod_lt x hM
  have hsmall : H % N * M + x % M < N * M := by
    have hstep := Nat.mul_le_mul_right M (show H % N + 1 ≤ N by omega)
    nlinarith
  rw [hcalc, Nat.add_mod]
  simp [Nat.mod_eq_of_lt hsmall, H]

private theorem cyclic_remainder_band (N M d e : ℕ)
    (hN : 2 ≤ N) (_hM : 0 < M) (hd : d < N) (he : e < M) :
    (M ≤ d * M + e ∧ d * M + e ≤ (N - 1) * M) ↔
      d ≠ 0 ∧ (e = 0 ∨ d ≠ N - 1) := by
  constructor
  · rintro ⟨hlo, hup⟩
    constructor
    · intro hz
      subst d
      simp only [zero_mul, zero_add] at hlo
      omega
    · by_cases hz : e = 0
      · exact Or.inl hz
      · right
        intro hlast
        rw [hlast] at hup
        omega
  · rintro ⟨hd0, hcases⟩
    constructor
    · have : 1 ≤ d := by omega
      nlinarith
    · rcases hcases with rfl | hlast
      · simpa using Nat.mul_le_mul_right M (show d ≤ N - 1 by omega)
      · have hstep := Nat.mul_le_mul_right M (show d + 1 ≤ N - 1 by omega)
        nlinarith

/-- Exact bad-residue avoidance is equivalent to the complete wrapped band.
The natural residue input `h` is unrestricted; it need not already be below `N`. -/
theorem affineCyclicBadResidues_not_mem_iff_modular_band
    (N M a beta h : ℕ) (hN : 2 ≤ N) (hM : 0 < M) :
    (h : ZMod N) ∉ affineCyclicBadResidues N M a beta ↔
      M ≤ (h * M + a * beta) % (N * M) ∧
      (h * M + a * beta) % (N * M) ≤ (N - 1) * M := by
  letI : NeZero N := ⟨by omega⟩
  have hz : ((h : ZMod N) + (a * beta / M : ℕ) ≠ 0) ↔
      (h + a * beta / M) % N ≠ 0 := by
    rw [← Nat.cast_add]
    exact not_congr (by rw [ZMod.natCast_eq_zero_iff, Nat.dvd_iff_mod_eq_zero])
  have hnegval : (-1 : ZMod N).val = N - 1 := by
    obtain ⟨n, rfl⟩ := Nat.exists_eq_succ_of_ne_zero (show N ≠ 0 by omega)
    simp [ZMod.val_neg_one]
  have hn : ((h : ZMod N) + (a * beta / M : ℕ) = -1) ↔
      (h + a * beta / M) % N = N - 1 := by
    rw [← Nat.cast_add]
    constructor
    · intro he
      have hv := congrArg ZMod.val he
      simpa only [ZMod.val_natCast, hnegval] using hv
    · intro he
      apply ZMod.val_injective N
      rw [ZMod.val_natCast, hnegval, he]
  have hn' : ((h : ZMod N) + (a * beta / M : ℕ) ≠ -1) ↔
      (h + a * beta / M) % N ≠ N - 1 := not_congr hn
  rw [not_mem_affineCyclicBadResidues_iff, hz, hn',
    cyclic_correction_mod N M h (a * beta) (by omega) hM]
  exact (cyclic_remainder_band N M ((h + a * beta / M) % N)
    (a * beta % M) hN hM (Nat.mod_lt _ (by omega)) (Nat.mod_lt _ hM)).symm

/-- Exact actual-speed affine phase criterion. The offset is `s*u`, using
the actual speed rather than replacing it with the congruent base `a`. -/
theorem circleNorm_affine_grid_iff_not_mem_bad_residues
    (N M s r0 r beta a u : ℕ)
    (hN : 2 ≤ N) (hM : 0 < M) (hu : u ≡ a [MOD M])
    (hr : N * r = M * r0 + beta) (ha : a < M) :
    (N : ℝ)⁻¹ ≤ circleNorm (((s : ℝ) / N + (r : ℝ) / M) * u) ↔
      ((s * u + r0 * a : ℕ) : ZMod N) ∉ affineCyclicBadResidues N M a beta := by
  rw [circleNorm_affine_grid_iff_modular_band N M s r0 r beta a u hN hM hu hr ha]
  have hb := affineCyclicBadResidues_not_mem_iff_modular_band
    N M a beta ((s * u + r0 * a) % N) hN hM
  simpa only [ZMod.natCast_mod] using hb.symm

end LonelyRunner
