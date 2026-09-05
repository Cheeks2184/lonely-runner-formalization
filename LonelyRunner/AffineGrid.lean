import LonelyRunner.AffineAvoidance
import LonelyRunner.AffineGridArithmetic

/-!
# Witnesses from an affine grid and an actual pivot speed

The finite-field avoidance result handles `N - 2` labelled speeds.  The
remaining original speed is a multiple of the external modulus `M`; the
nonzero affine scale makes that speed good as well.  Consequently the
conclusion retains the full `N`-runner distance threshold `1 / N`.
-/

namespace LonelyRunner

/-- Round `M * r0 / N` upward and retain the exact integral error.  This
arithmetic fact is independent of primality and of the number of speeds. -/
theorem exists_affine_grid_rounding (N M r0 : ℕ) (hN : 0 < N) :
    ∃ r beta : ℕ, N * r = M * r0 + beta ∧ beta ≤ N - 1 := by
  let x := M * r0
  let r := (x + (N - 1)) / N
  have hdecomp : (x + (N - 1)) % N + N * r = x + (N - 1) := by
    exact Nat.mod_add_div (x + (N - 1)) N
  have hrem : (x + (N - 1)) % N < N := Nat.mod_lt _ hN
  have hlower : x ≤ N * r := by omega
  have hupper : N * r ≤ x + (N - 1) := by omega
  refine ⟨r, N * r - x, ?_, ?_⟩
  · change N * r = x + (N * r - x)
    omega
  · omega

/-- Avoiding the two field endpoints gives an ordinary natural residue
in the exact band used by the real-arithmetic grid helper. -/
theorem nat_mod_band_of_zmod_avoidance (N x : ℕ) [NeZero N]
    (hN : 2 ≤ N) (hzero : (x : ZMod N) ≠ 0)
    (hneg : (x : ZMod N) ≠ -1) :
    1 ≤ x % N ∧ x % N ≤ N - 2 := by
  have hNpos : 0 < N := by omega
  have hlt : x % N < N := Nat.mod_lt x hNpos
  have hmod0 : x % N ≠ 0 := by
    intro hx
    apply hzero
    exact (ZMod.natCast_eq_zero_iff x N).mpr (Nat.dvd_of_mod_eq_zero hx)
  have hnegval : (-1 : ZMod N).val = N - 1 := by
    obtain ⟨k, rfl⟩ := Nat.exists_eq_succ_of_ne_zero hNpos.ne'
    exact ZMod.val_neg_one k
  have hmodLast : x % N ≠ N - 1 := by
    intro hx
    apply hneg
    apply ZMod.val_injective N
    rw [ZMod.val_natCast, hnegval]
    exact hx
  omega

private theorem circleNorm_affine_grid_pivot
    (N M c s r : ℕ) (hN : 0 < N) (hM : 0 < M)
    (hnot : ¬ N ∣ s * (c * M)) :
    (N : ℝ)⁻¹ ≤ circleNorm
      (((s : ℝ) / N + (r : ℝ) / M) * (c * M : ℕ)) := by
  have hmod : (s * (c * M)) % N ≠ 0 := by
    intro h
    exact hnot (Nat.dvd_of_mod_eq_zero h)
  have hdist := circleNorm_nat_div_ge hN
    (one_le_cyclicResidueDistance_of_mod_ne_zero hN hmod)
  have hMreal : (M : ℝ) ≠ 0 := by exact_mod_cast hM.ne'
  have hNreal : (N : ℝ) ≠ 0 := by exact_mod_cast hN.ne'
  have hphase :
      ((s : ℝ) / N + (r : ℝ) / M) * (c * M : ℕ) =
        ((s * (c * M) : ℕ) : ℝ) / N + ((r * c : ℕ) : ℝ) := by
    push_cast
    field_simp
  rw [hphase]
  have hperiod := circleNorm_add_int ((r * c : ℕ) : ℤ)
    (((s * (c * M) : ℕ) : ℝ) / N)
  have hperiod' :
      circleNorm (((s * (c * M) : ℕ) : ℝ) / N + ((r * c : ℕ) : ℝ)) =
        circleNorm (((s * (c * M) : ℕ) : ℝ) / N) := by
    simpa only [Int.cast_natCast, add_comm] using hperiod
  rw [hperiod']
  simpa only [Nat.cast_one, one_div] using hdist

/-- An actual speed `c * M` restores the coordinate omitted by the `N - 2`
affine theorem.  Both that speed and every remaining speed meet the closed
`1 / N` distance bound at the same explicit rational grid time.  The external
modulus `M` is not assumed prime, and the offsets have no extra restriction. -/
theorem affine_grid_pivot_witness
    (N M c : ℕ) [Fact N.Prime] (hodd : Odd N)
    {I : Type*} [Fintype I] (hcard : Fintype.card I = N - 2)
    (a u : I → ℕ) (hM : 0 < M)
    (_ha : ∀ i, 0 < a i)
    (haN : ∀ i, ¬ N ∣ a i)
    (hu : ∀ i, Nat.ModEq M (u i) (a i))
    (hsize : ∀ i, (N - 1) * a i < M)
    (hpivot : ¬ N ∣ c * M) :
    ∃ s r : ℕ, 0 < s ∧ s < N ∧
      (N : ℝ)⁻¹ ≤ circleNorm
        (((s : ℝ) / N + (r : ℝ) / M) * (c * M : ℕ)) ∧
      ∀ i, (N : ℝ)⁻¹ ≤ circleNorm
        (((s : ℝ) / N + (r : ℝ) / M) * (u i : ℝ)) := by
  have hprime : N.Prime := Fact.out
  have hN : 2 ≤ N := hprime.two_le
  have hNpos : 0 < N := hprime.pos
  have haslopes : ∀ i, (a i : ZMod N) ≠ 0 := by
    intro i hi
    exact haN i ((ZMod.natCast_eq_zero_iff (a i) N).mp hi)
  obtain ⟨rF, sF, hrF, hsF, havoid⟩ :=
    affine_avoidance_card_sub_two N hodd hcard
      (fun i => (a i : ZMod N)) (fun i => (u i : ZMod N)) haslopes
  let s := sF.val
  let r0 := rF.val
  have hspos : 0 < s := by
    exact Nat.pos_of_ne_zero ((ZMod.val_ne_zero sF).mpr hsF)
  have hslt : s < N := ZMod.val_lt sF
  obtain ⟨r, beta, hr, hbeta⟩ := exists_affine_grid_rounding N M r0 hNpos
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
  have hsnot : ¬ N ∣ s := by
    intro h
    have := Nat.le_of_dvd hspos h
    omega
  have hpivotnot : ¬ N ∣ s * (c * M) := by
    intro h
    exact (hprime.dvd_mul.mp h).elim hsnot hpivot
  refine ⟨s, r, hspos, hslt,
    circleNorm_affine_grid_pivot N M c s r hNpos hM hpivotnot, ?_⟩
  intro i
  exact circleNorm_ge_of_affine_grid_band N M s r0 r beta (a i) (u i)
    hN hM (hu i) hr hbeta (hsize i) (hband i).1 (hband i).2

end LonelyRunner
