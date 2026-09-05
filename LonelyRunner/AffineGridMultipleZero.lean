import LonelyRunner.AffineShiftArithmetic

/-!
# A common shifted grid for several vanishing slopes

The ordinary field rows are padded only inside the avoidance argument.  Every
zero row is an original speed and is restored by the same positive correction.
The conclusion keeps all original coordinates and their closed `1 / N` bound,
including the case in which the ordinary index type is empty.
-/

namespace LonelyRunner

/-- Padding with harmless nonzero slopes extends the exact-cardinality field
theorem to any smaller family, including an empty family. -/
theorem affine_avoidance_card_le_sub_two
    (N : ℕ) [Fact N.Prime] (hodd : Odd N)
    {I : Type*} [Fintype I] (hcard : Fintype.card I ≤ N - 2)
    (a v : I → ZMod N) (ha : ∀ i, a i ≠ 0) :
    ∃ r s : ZMod N, r ≠ 0 ∧ s ≠ 0 ∧
      ∀ i, s * v i + r * a i ≠ 0 ∧ s * v i + r * a i ≠ -1 := by
  classical
  let K := I ⊕ Fin (N - 2 - Fintype.card I)
  let b : K → ZMod N := Sum.elim a (fun _ => 1)
  let w : K → ZMod N := Sum.elim v (fun _ => 0)
  have hK : Fintype.card K = N - 2 := by
    simp only [K, Fintype.card_sum, Fintype.card_fin]
    omega
  have hb : ∀ k, b k ≠ 0 := by
    intro k
    cases k with
    | inl i => exact ha i
    | inr j => exact one_ne_zero
  obtain ⟨r, s, hr, hs, havoid⟩ :=
    affine_avoidance_card_sub_two N hodd hK b w hb
  exact ⟨r, s, hr, hs, fun i => havoid (Sum.inl i)⟩

/-- The range size inequality makes the largest zero base smaller than the
modulus and keeps its scaled correction below the top closed good boundary. -/
private theorem affine_shift_range_bounds (N M L H beta : ℕ)
    (hN : 2 ≤ N) (hM : 0 < M) (hL : 0 < L) (hH : 0 < H)
    (hspan : H < (N - 1) * L)
    (hsize : N * H * L ≤ ((N - 1) * L - H) * M)
    (hshiftUpper : L * beta < M + N * L) :
    H < M ∧ H * beta < (N - 1) * M := by
  have hDlt : (N - 1) * L - H < N * L := by
    exact (Nat.sub_le _ _).trans_lt
      ((Nat.mul_lt_mul_right hL).mpr (by omega : N - 1 < N))
  have hHM : H < M := by
    apply Nat.lt_of_mul_lt_mul_left (a := N * L)
    calc
      (N * L) * H = N * H * L := by ring
      _ ≤ ((N - 1) * L - H) * M := hsize
      _ < (N * L) * M := (Nat.mul_lt_mul_right hM).mpr hDlt
  have hsum : N * H * L + H * M ≤ ((N - 1) * L) * M := by
    calc
      N * H * L + H * M ≤ ((N - 1) * L - H) * M + H * M :=
        Nat.add_le_add_right hsize _
      _ = ((N - 1) * L) * M := by
        rw [← Nat.add_mul, Nat.sub_add_cancel hspan.le]
  have hmul := Nat.mul_lt_mul_of_pos_left hshiftUpper hH
  have hfinal : L * (H * beta) < L * ((N - 1) * M) := by
    calc
      L * (H * beta) = H * (L * beta) := by ring
      _ < H * (M + N * L) := hmul
      _ = N * H * L + H * M := by ring
      _ ≤ ((N - 1) * L) * M := hsum
      _ = L * ((N - 1) * M) := by ring
  exact ⟨hHM, Nat.lt_of_mul_lt_mul_left hfinal⟩

/-- Simultaneous zero slopes have a common shifted-grid witness when their
positive bases lie in the stated range.  The explicit cardinality equation
retains exactly `N - 1` original speeds.  No nonzero-offset condition or
ordinary-row nonemptiness is assumed. -/
theorem affine_grid_multiple_zero_witness
    (N M L H : ℕ) [Fact N.Prime] (hodd : Odd N)
    {I : Type*} {J : Type*} [Fintype I] [Fintype J]
    (hcard : Fintype.card I + Fintype.card J = N - 1) (hJ : Nonempty J)
    (a u : I → ℕ) (A U : J → ℕ)
    (hM : 0 < M) (hL : 0 < L) (hH : 0 < H)
    (hAL : ∀ j, L ≤ A j) (hAH : ∀ j, A j ≤ H)
    (hAN : ∀ j, N ∣ A j) (hUN : ∀ j, N ∣ U j)
    (hU : ∀ j, Nat.ModEq M (U j) (A j))
    (ha : ∀ i, 0 < a i) (haL : ∀ i, a i < L)
    (haN : ∀ i, ¬ N ∣ a i)
    (hu : ∀ i, Nat.ModEq M (u i) (a i))
    (hspan : H < (N - 1) * L)
    (hsizeH : N * H * L ≤ ((N - 1) * L - H) * M)
    (hsize : ∀ i, N * a i * L ≤ (L - a i) * M) :
    ∃ s r : ℕ, 0 < s ∧ s < N ∧
      (∀ j, (N : ℝ)⁻¹ ≤ circleNorm
        (((s : ℝ) / N + (r : ℝ) / M) * (U j : ℝ))) ∧
      ∀ i, (N : ℝ)⁻¹ ≤ circleNorm
        (((s : ℝ) / N + (r : ℝ) / M) * (u i : ℝ)) := by
  classical
  have hprime : N.Prime := Fact.out
  have hN : 2 ≤ N := hprime.two_le
  have hNthree : 3 ≤ N := by
    obtain ⟨k, hk⟩ := hodd
    omega
  have hJpos : 0 < Fintype.card J := Fintype.card_pos_iff.mpr hJ
  have hcardI : Fintype.card I ≤ N - 2 := by omega
  have hLH : L ≤ H := by
    obtain ⟨j⟩ := hJ
    exact (hAL j).trans (hAH j)
  have haslopes : ∀ i, (a i : ZMod N) ≠ 0 := by
    intro i hi
    exact haN i ((ZMod.natCast_eq_zero_iff (a i) N).mp hi)
  obtain ⟨rF, sF, _hrF, hsF, havoid⟩ :=
    affine_avoidance_card_le_sub_two N hodd hcardI
      (fun i => (a i : ZMod N)) (fun i => (u i : ZMod N)) haslopes
  let s := sF.val
  let r0 := rF.val
  have hspos : 0 < s :=
    Nat.pos_of_ne_zero ((ZMod.val_ne_zero sF).mpr hsF)
  have hslt : s < N := ZMod.val_lt sF
  -- One integer rounding supplies all zero coordinates simultaneously, while
  -- its exact equality preserves every original quotient modulo M.
  obtain ⟨r, beta, hr, hshiftLower, hshiftUpper⟩ :=
    exists_affine_shift_rounding N M L r0 hprime.pos hL hM
  obtain ⟨hHM, hzeroUpper⟩ :=
    affine_shift_range_bounds N M L H beta hN hM hL hH hspan hsizeH hshiftUpper
  have hLM : L < M := hLH.trans_lt hHM
  have hordinary : ∀ i, a i < M ∧ a i * beta < M := by
    intro i
    refine ⟨(haL i).trans hLM, ?_⟩
    exact affine_shift_ordinary_correction_bound N M L (a i) beta hNthree hL hM
      (ha i) (haL i) (hsize i) hshiftUpper
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
  refine ⟨s, r, hspos, hslt, ?_, ?_⟩
  · intro j
    have hzero : (s * U j + r0 * A j) % N = 0 := by
      simp [Nat.add_mod, Nat.mul_mod, Nat.mod_eq_zero_of_dvd (hUN j),
        Nat.mod_eq_zero_of_dvd (hAN j)]
    have hlo : M ≤ A j * beta :=
      hshiftLower.trans (Nat.mul_le_mul_right beta (hAL j))
    have hup : A j * beta ≤ (N - 1) * M :=
      ((Nat.mul_le_mul_right beta (hAH j)).trans_lt hzeroUpper).le
    apply circleNorm_ge_of_affine_grid_residue_band N M s r0 r beta (A j) (U j)
      hN hM (hU j) hr ((hAH j).trans_lt hHM)
    · simpa only [hzero, zero_mul, zero_add] using hlo
    · simpa only [hzero, zero_mul, zero_add] using hup
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
        ((s * u i + r0 * a i) % N) * M + a i * beta ≤ (N - 2) * M + M :=
          Nat.add_le_add hprod (hordinary i).2.le
        _ = (N - 1) * M := by rw [hNsub, Nat.add_mul, Nat.one_mul]

end LonelyRunner
