import LonelyRunner.RationalShiftOrbits
import Mathlib.Tactic

/-!
# Reduced rational shift orbits

Dividing the speed and denominator by their gcd identifies the actual
coprime orbit. Its sharp mesh margin is at least one quarter whenever
the original speed is not divisible by the denominator.
-/

namespace LonelyRunner

theorem exists_nat_rational_shift_circleNorm_ge_mesh
    (ell d : ℕ) (hell : 2 ≤ ell) (hnot : ¬ ell ∣ d) (x : ℝ) :
    let n : ℕ := ell / Nat.gcd ell d
    ∃ k : ℕ, k < n ∧ k < ell ∧
      ((n : ℝ) - 1) / (2 * (n : ℝ)) ≤
        circleNorm (x + (k : ℝ) * (d : ℝ) / (ell : ℝ)) := by
  let g := Nat.gcd ell d
  let n := ell / g
  let c := d / g
  have hellpos : 0 < ell := by omega
  have hg : 0 < g := by
    dsimp [g]
    exact Nat.gcd_pos_of_pos_left d hellpos
  have hge : g ∣ ell := by exact Nat.gcd_dvd_left _ _
  have hgd : g ∣ d := by exact Nat.gcd_dvd_right _ _
  have helleq : ell = g * n := by
    dsimp [n]
    exact (Nat.mul_div_cancel' hge).symm
  have hdeq : d = g * c := by
    dsimp [c]
    exact (Nat.mul_div_cancel' hgd).symm
  have hnpos : 0 < n := by
    dsimp [n]
    exact Nat.div_pos (Nat.le_of_dvd hellpos hge) hg
  have hnnotone : n ≠ 1 := by
    intro hn
    apply hnot
    rw [helleq, hn]
    simpa [Nat.mul_one] using hgd
  have hntwo : 2 ≤ n := by omega
  have hnle : n ≤ ell := by
    rw [helleq]
    exact Nat.le_mul_of_pos_left n hg
  have hcop : Nat.Coprime c n := by
    simpa [c, n, g] using (Nat.coprime_div_gcd_div_gcd hg).symm
  obtain ⟨k, hk, hmesh⟩ := exists_nat_coprime_grid_circleNorm_ge x c n hnpos hcop
  refine ⟨k, hk, hk.trans_le hnle, ?_⟩
  have hgR : (g : ℝ) ≠ 0 := by exact_mod_cast hg.ne'
  have hphase : (d : ℝ) / (ell : ℝ) = (c : ℝ) / (n : ℝ) := by
    rw [hdeq, helleq]
    push_cast
    field_simp [hgR]
  rw [mul_div_assoc, hphase, ← mul_div_assoc]
  exact hmesh

theorem exists_nat_rational_shift_circleNorm_ge_quarter
    (ell d : ℕ) (hell : 2 ≤ ell) (hnot : ¬ ell ∣ d) (x : ℝ) :
    ∃ k : ℕ, k < ell ∧ (1 : ℝ) / 4 ≤
      circleNorm (x + (k : ℝ) * (d : ℝ) / (ell : ℝ)) := by
  obtain ⟨k, hk, hkell, hmesh⟩ :=
    exists_nat_rational_shift_circleNorm_ge_mesh ell d hell hnot x
  refine ⟨k, hkell, ?_⟩
  apply le_trans ?_ hmesh
  let g := Nat.gcd ell d
  let n := ell / g
  have hg : 0 < g := by
    exact Nat.gcd_pos_of_pos_left d (by omega)
  have hge : g ∣ ell := Nat.gcd_dvd_left _ _
  have helleq : ell = g * n := by
    dsimp [n]
    exact (Nat.mul_div_cancel' hge).symm
  have hn : 2 ≤ n := by
    have hnpos : 0 < n := by
      dsimp [n]
      exact Nat.div_pos (Nat.le_of_dvd (by omega) hge) hg
    have hnnotone : n ≠ 1 := by
      intro hnone
      apply hnot
      rw [helleq, hnone]
      simpa only [Nat.mul_one] using (Nat.gcd_dvd_right ell d)
    omega
  have hnR : (2 : ℝ) ≤ (n : ℝ) := by exact_mod_cast hn
  change (1 : ℝ) / 4 ≤ ((n : ℝ) - 1) / (2 * (n : ℝ))
  apply (le_div_iff₀ (by positivity : (0 : ℝ) < 2 * (n : ℝ))).2
  nlinarith [hnR]

end LonelyRunner
