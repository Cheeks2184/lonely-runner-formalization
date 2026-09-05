import LonelyRunner.AffineGrid
import LonelyRunner.AffineShiftArithmetic

/-!
# A shifted affine grid with one vanishing slope

The distinguished coordinate is an original speed divisible by the runner
denominator.  Its positive base is also divisible by that denominator and is
larger than the other bases.  Shifting the integral rounding moves this zero
field residue into the closed good band while keeping the other residues good.
-/

namespace LonelyRunner

/-- One actual speed with vanishing affine slope can be restored by shifting
the rounded grid.  The conclusion includes all `N - 1` original coordinates
at the unchanged closed `1 / N` threshold.  The external modulus need not be
prime or coprime to `N`; its required size is derived from the two displayed
coarse inequalities, rather than added as a normalization premise. -/
theorem affine_grid_one_zero_witness
    (N M A U : ℕ) [Fact N.Prime] (hodd : Odd N)
    {I : Type*} [Fintype I] (hcard : Fintype.card I = N - 2)
    (a u : I → ℕ) (hM : 0 < M) (hA : 0 < A)
    (hAN : N ∣ A) (hUN : N ∣ U) (hU : Nat.ModEq M U A)
    (ha : ∀ i, 0 < a i) (haA : ∀ i, a i < A)
    (haN : ∀ i, ¬ N ∣ a i)
    (hu : ∀ i, Nat.ModEq M (u i) (a i))
    (hsizeA : N * A ≤ (N - 2) * M)
    (hsize : ∀ i, N * a i * A ≤ (A - a i) * M) :
    ∃ s r : ℕ, 0 < s ∧ s < N ∧
      (N : ℝ)⁻¹ ≤ circleNorm
        (((s : ℝ) / N + (r : ℝ) / M) * (U : ℝ)) ∧
      ∀ i, (N : ℝ)⁻¹ ≤ circleNorm
        (((s : ℝ) / N + (r : ℝ) / M) * (u i : ℝ)) := by
  have hprime : N.Prime := Fact.out
  have hN : 2 ≤ N := hprime.two_le
  have hNpos : 0 < N := hprime.pos
  have hNthree : 3 ≤ N := by
    obtain ⟨k, hk⟩ := hodd
    omega
  have haslopes : ∀ i, (a i : ZMod N) ≠ 0 := by
    intro i hi
    exact haN i ((ZMod.natCast_eq_zero_iff (a i) N).mp hi)
  obtain ⟨rF, sF, _hrF, hsF, havoid⟩ :=
    affine_avoidance_card_sub_two N hodd hcard
      (fun i => (a i : ZMod N)) (fun i => (u i : ZMod N)) haslopes
  let s := sF.val
  let r0 := rF.val
  have hspos : 0 < s :=
    Nat.pos_of_ne_zero ((ZMod.val_ne_zero sF).mpr hsF)
  have hslt : s < N := ZMod.val_lt sF
  -- The integral shift preserves every quotient term in the original speeds.
  obtain ⟨r, beta, hr, hshiftLower, hshiftUpper⟩ :=
    exists_affine_shift_rounding N M A r0 hNpos hA hM
  obtain ⟨hAM, hstarUpper⟩ :=
    affine_shift_large_scalar_bounds N M A beta hNthree hA hM hsizeA hshiftUpper
  have hordinary : ∀ i, a i < M ∧ a i * beta < M := by
    intro i
    refine ⟨(haA i).trans hAM, ?_⟩
    exact affine_shift_ordinary_correction_bound N M A (a i) beta hNthree hA hM
      (ha i) (haA i) (hsize i) hshiftUpper
  have hband : ∀ i, 1 ≤ (s * u i + r0 * a i) % N ∧
      (s * u i + r0 * a i) % N ≤ N - 2 := by
    intro i
    have hcast : ((s * u i + r0 * a i : ℕ) : ZMod N) =
        sF * (u i : ZMod N) + rF * (a i : ZMod N) := by
      simp only [Nat.cast_add, Nat.cast_mul, s, r0, ZMod.natCast_zmod_val]
    apply nat_mod_band_of_zmod_avoidance N _ hN
    · rw [hcast]
      exact (havoid i).1
    · rw [hcast]
      exact (havoid i).2
  -- Unlike the other rows, the original distinguished row has field residue
  -- zero.  Its correction supplies the entire lower distance bound.
  have hstarZero : (s * U + r0 * A) % N = 0 := by
    simp [Nat.add_mod, Nat.mul_mod, Nat.mod_eq_zero_of_dvd hUN,
      Nat.mod_eq_zero_of_dvd hAN]
  refine ⟨s, r, hspos, hslt, ?_, ?_⟩
  · apply circleNorm_ge_of_affine_grid_residue_band N M s r0 r beta A U
      hN hM hU hr hAM
    · simpa only [hstarZero, zero_mul, zero_add] using hshiftLower
    · simpa only [hstarZero, zero_mul, zero_add] using hstarUpper.le
  · intro i
    apply circleNorm_ge_of_affine_grid_residue_band N M s r0 r beta (a i) (u i)
      hN hM (hu i) hr (hordinary i).1
    · have hprod : M ≤ ((s * u i + r0 * a i) % N) * M := by
        simpa [Nat.mul_comm] using Nat.le_mul_of_pos_right M (hband i).1
      exact hprod.trans (Nat.le_add_right _ _)
    · have hprod : ((s * u i + r0 * a i) % N) * M ≤ (N - 2) * M :=
        Nat.mul_le_mul_right M (hband i).2
      have hNsub : N - 1 = (N - 2) + 1 := by omega
      calc
        ((s * u i + r0 * a i) % N) * M + a i * beta ≤
            (N - 2) * M + M :=
          Nat.add_le_add hprod (hordinary i).2.le
        _ = (N - 1) * M := by rw [hNsub, Nat.add_mul, Nat.one_mul]

end LonelyRunner
