import LonelyRunner.WeakSixthShifts
import LonelyRunner.SmallPhaseOrbits
import LonelyRunner.SixthAffinePhase
import LonelyRunner.OddHalfTimeShift
import LonelyRunner.FoldedCirclePhase
import Mathlib.Tactic

/-!
# Scalar orbit helpers for the three-even five-speed branch

These public helpers isolate the residue, folded-norm, and reciprocal-orbit
calculations used by the subsequent labelled three-even assembly.  Their
hypotheses deliberately allow arbitrary real times and zero dilate indices.
-/

namespace LonelyRunner

/-- An even speed prime to three has signed residue `±2` modulo six. -/
theorem threeEven_exists_even_unit_sixth_residue (d : ℕ)
    (h2 : 2 ∣ d) (h3 : ¬ 3 ∣ d) :
    ∃ z σ : ℤ, (d : ℤ) = 6 * z + 2 * σ ∧ (σ = 1 ∨ σ = -1) := by
  obtain ⟨z, e, hd, he⟩ := exists_centered_sixth_residue_of_not_dvd_three d h3
  rcases he with he | he | he | he
  · exfalso
    have hdiv : (2 : ℤ) ∣ (d : ℤ) := by exact_mod_cast h2
    rcases hdiv with ⟨v, hv⟩
    omega
  · exfalso
    have hdiv : (2 : ℤ) ∣ (d : ℤ) := by exact_mod_cast h2
    rcases hdiv with ⟨v, hv⟩
    omega
  · exact ⟨z, 1, by linarith [hd, he], Or.inl rfl⟩
  · exact ⟨z, -1, by linarith [hd, he], Or.inr rfl⟩

/-- An odd speed prime to three has signed residue `±1` modulo six. -/
theorem threeEven_exists_odd_unit_sixth_residue (d : ℕ)
    (h2 : ¬ 2 ∣ d) (h3 : ¬ 3 ∣ d) :
    ∃ z σ : ℤ, (d : ℤ) = 6 * z + σ ∧ (σ = 1 ∨ σ = -1) := by
  obtain ⟨z, e, hd, he⟩ := exists_centered_sixth_residue_of_not_dvd_three d h3
  rcases he with he | he | he | he
  · exact ⟨z, 1, by linarith [hd, he], Or.inl rfl⟩
  · exact ⟨z, -1, by linarith [hd, he], Or.inr rfl⟩
  · exfalso
    apply h2
    have hdiv : (2 : ℤ) ∣ (d : ℤ) := by
      refine ⟨3 * z + 1, ?_⟩
      linarith [hd, he]
    exact_mod_cast hdiv
  · exfalso
    apply h2
    have hdiv : (2 : ℤ) ∣ (d : ℤ) := by
      refine ⟨3 * z - 1, ?_⟩
      linarith [hd, he]
    exact_mod_cast hdiv

/-- Folding is unchanged when an integral part of a phase is discarded before
multiplying by a natural number. -/
theorem threeEven_circleNorm_nat_mul_fract (x : ℝ) (n : ℕ) :
    circleNorm ((n : ℝ) * x) =
      circleNorm ((n : ℝ) * Int.fract x) := by
  have hfloor := Int.floor_add_fract x
  have hphase : (n : ℝ) * x =
      (((n : ℤ) * ⌊x⌋ : ℤ) : ℝ) + (n : ℝ) * Int.fract x := by
    push_cast
    nlinarith [hfloor]
  rw [hphase, circleNorm_add_int]

/-- A common sixth-time shift transports each signed residue phase to its
weighted affine phase. -/
theorem threeEven_circleNorm_sixth_weighted_shift
    (t : ℝ) (d w b : ℕ) (z σ : ℤ)
    (hd : (d : ℤ) = 6 * z + (w : ℤ) * σ)
    (hσ : σ = 1 ∨ σ = -1) :
    circleNorm ((t + (b : ℝ) / 6) * (d : ℝ)) =
      circleNorm ((σ : ℝ) * Int.fract (t * (d : ℝ)) +
        (w : ℝ) * (b : ℝ) / 6) := by
  have hfract := fract_sixth_affine_time t d 1 (b : ℤ) z ((w : ℤ) * σ) hd
  have hleft : circleNorm ((t + (b : ℝ) / 6) * (d : ℝ)) =
      circleNorm (Int.fract (((t + (b : ℝ) / 6) * (d : ℝ))) ) := by
    simpa using (threeEven_circleNorm_nat_mul_fract
      ((t + (b : ℝ) / 6) * (d : ℝ)) 1)
  have hright : circleNorm
      (Int.fract (t * (d : ℝ)) +
        (((b : ℤ) * ((w : ℤ) * σ) : ℤ) : ℝ) / 6) =
      circleNorm (Int.fract
        (Int.fract (t * (d : ℝ)) +
          (((b : ℤ) * ((w : ℤ) * σ) : ℤ) : ℝ) / 6)) := by
    simpa using (threeEven_circleNorm_nat_mul_fract
      (Int.fract (t * (d : ℝ)) +
        (((b : ℤ) * ((w : ℤ) * σ) : ℤ) : ℝ) / 6) 1)
  have hfract' : Int.fract ((t + (b : ℝ) / 6) * (d : ℝ)) =
      Int.fract (Int.fract (t * (d : ℝ)) +
        (((b : ℤ) * ((w : ℤ) * σ) : ℤ) : ℝ) / 6) := by
    convert hfract using 1 <;> push_cast <;> ring
  have hbase : circleNorm ((t + (b : ℝ) / 6) * (d : ℝ)) =
      circleNorm (Int.fract (t * (d : ℝ)) +
        (((b : ℤ) * ((w : ℤ) * σ) : ℤ) : ℝ) / 6) := by
    calc
      circleNorm ((t + (b : ℝ) / 6) * (d : ℝ)) =
          circleNorm (Int.fract ((t + (b : ℝ) / 6) * (d : ℝ))) := hleft
      _ = circleNorm (Int.fract (Int.fract (t * (d : ℝ)) +
          (((b : ℤ) * ((w : ℤ) * σ) : ℤ) : ℝ) / 6)) := by rw [hfract']
      _ = circleNorm (Int.fract (t * (d : ℝ)) +
          (((b : ℤ) * ((w : ℤ) * σ) : ℤ) : ℝ) / 6) := hright.symm
  rcases hσ with hσ | hσ
  · subst σ
    convert hbase using 1 <;> push_cast <;> ring
  · subst σ
    calc
      circleNorm ((t + (b : ℝ) / 6) * (d : ℝ)) =
          circleNorm (Int.fract (t * (d : ℝ)) - (w : ℝ) * (b : ℝ) / 6) := by
            convert hbase using 1 <;> push_cast <;> ring
      _ = circleNorm (-Int.fract (t * (d : ℝ)) +
          (w : ℝ) * (b : ℝ) / 6) := by
            rw [show -Int.fract (t * (d : ℝ)) + (w : ℝ) * (b : ℝ) / 6 =
              -(Int.fract (t * (d : ℝ)) - (w : ℝ) * (b : ℝ) / 6) by ring,
              circleNorm_neg]
      _ = circleNorm (((-1 : ℤ) : ℝ) * Int.fract (t * (d : ℝ)) +
          (w : ℝ) * (b : ℝ) / 6) := by norm_num

/-- The closed twelfth-to-sixth band (and its fifth exception) remains safe
under the prescribed double and quadruple phase maps. -/
theorem threeEven_small_phase_double_four_safe (x : ℝ)
    (hx : (((1 : ℝ) / 12 ≤ Int.fract x ∧
      Int.fract x ≤ (1 : ℝ) / 6) ∨ Int.fract x = (1 : ℝ) / 5)) :
    (1 : ℝ) / 6 ≤ circleNorm (2 * x) ∧
    (1 : ℝ) / 6 ≤ circleNorm (4 * x) := by
  rcases hx with hband | hfifth
  · constructor
    · have htwo : circleNorm (2 * x) = circleNorm (2 * Int.fract x) := by
        convert threeEven_circleNorm_nat_mul_fract x 2 using 1 <;> norm_num
      rw [htwo]
      apply circleNorm_ge_of_int_band 0 (2 * Int.fract x) ((1 : ℝ) / 6) <;>
        norm_num at * <;> linarith [hband.1, hband.2]
    · have hfour : circleNorm (4 * x) = circleNorm (4 * Int.fract x) := by
        convert threeEven_circleNorm_nat_mul_fract x 4 using 1 <;> norm_num
      rw [hfour]
      apply circleNorm_ge_of_int_band 0 (4 * Int.fract x) ((1 : ℝ) / 6) <;>
        norm_num at * <;> linarith [hband.1, hband.2]
  · constructor
    · have htwo : circleNorm (2 * x) = circleNorm (2 * Int.fract x) := by
        convert threeEven_circleNorm_nat_mul_fract x 2 using 1 <;> norm_num
      rw [htwo]
      apply circleNorm_ge_of_int_band 0 (2 * Int.fract x) ((1 : ℝ) / 6) <;>
        norm_num [hfifth]
    · have hfour : circleNorm (4 * x) = circleNorm (4 * Int.fract x) := by
        convert threeEven_circleNorm_nat_mul_fract x 4 using 1 <;> norm_num
      rw [hfour]
      apply circleNorm_ge_of_int_band 0 (4 * Int.fract x) ((1 : ℝ) / 6) <;>
        norm_num [hfifth]

/-- Doubling a phase whose folded norm exceeds one third gives folded norm
strictly below one third. -/
theorem threeEven_circleNorm_double_lt_third (x : ℝ)
    (hx : (1 : ℝ) / 3 < circleNorm x) :
    circleNorm (2 * x) < (1 : ℝ) / 3 := by
  let u : ℝ := circleNorm x
  have hu0 : 0 ≤ u := by
    dsimp [u]
    rw [circleNorm_eq_abs_sub_round]
    exact abs_nonneg _
  have huhalf : u ≤ (1 : ℝ) / 2 := by
    dsimp [u]
    rw [circleNorm_eq_abs_sub_round]
    exact abs_sub_round _
  have hfold : circleNorm (2 * x) = circleNorm (2 * u) := by
    dsimp [u]
    simpa using (circleNorm_nat_mul_add_int_half x 2 0)
  calc
    circleNorm (2 * x) = circleNorm (2 * u) := hfold
    _ = circleNorm ((1 : ℤ) + (2 * u - 1)) := by
      congr 1
      push_cast
      ring
    _ = circleNorm (2 * u - 1) := by rw [circleNorm_add_int]
    _ = |2 * u - 1| := by
      rw [circleNorm_eq_abs_of_abs_le_half]
      rw [abs_of_nonpos (by dsimp [u] at hx ⊢; linarith)]
      dsimp [u] at hx ⊢
      linarith
    _ = 1 - 2 * u := by
      rw [abs_of_nonpos (by dsimp [u] at hx ⊢; linarith)]
      ring
    _ < (1 : ℝ) / 3 := by
      dsimp [u] at hx ⊢
      linarith

/-- If every zero of a reduced odd speed has a large partner phase whenever a
pivot is safe, then that odd speed divides the pivot. -/
theorem threeEven_dvd_of_large_partner_at_zeros
    (A U W : ℕ) (hU : 0 < U) (hcop : Nat.Coprime U 6)
    (hlarge : ∀ t : ℝ, Int.fract (t * (U : ℝ)) = 0 →
      (1 : ℝ) / 6 ≤ circleNorm (t * (A : ℝ)) →
      (1 : ℝ) / 3 < circleNorm (t * (W : ℝ))) :
    U ∣ A := by
  by_contra hnot
  obtain ⟨k, hk, hphase⟩ :=
    exists_reciprocal_time_small_phase A U hU hcop hnot
  let s : ℝ := (k : ℝ) / (U : ℝ)
  have hUR : (U : ℝ) ≠ 0 := by exact_mod_cast hU.ne'
  have hsphase : s * (A : ℝ) = (k : ℝ) * (A : ℝ) / (U : ℝ) := by
    dsimp [s]
    field_simp [hUR] <;> ring
  have hsafes := threeEven_small_phase_double_four_safe (s * (A : ℝ)) (by
    rw [hsphase]
    exact hphase)
  have hsafes' : (1 : ℝ) / 6 ≤ circleNorm ((2 * s) * (A : ℝ)) ∧
      (1 : ℝ) / 6 ≤ circleNorm ((4 * s) * (A : ℝ)) := by
    constructor
    · simpa [mul_assoc, mul_left_comm, mul_comm] using hsafes.1
    · simpa [mul_assoc, mul_left_comm, mul_comm] using hsafes.2
  have hsafe2 : (1 : ℝ) / 6 ≤ circleNorm ((2 * s) * (A : ℝ)) := hsafes'.1
  have hsafe4 : (1 : ℝ) / 6 ≤ circleNorm ((4 * s) * (A : ℝ)) := hsafes'.2
  have hzero2 : Int.fract ((2 * s) * (U : ℝ)) = 0 := by
    have htime : (2 * s) * (U : ℝ) = ((2 * k : ℕ) : ℝ) := by
      dsimp [s]
      field_simp [hUR]
      push_cast
      ring
    rw [htime, Int.fract_natCast]
  have hzero4 : Int.fract ((4 * s) * (U : ℝ)) = 0 := by
    have htime : (4 * s) * (U : ℝ) = ((4 * k : ℕ) : ℝ) := by
      dsimp [s]
      field_simp [hUR]
      push_cast
      ring
    rw [htime, Int.fract_natCast]
  have hlarge2 := hlarge (2 * s) hzero2 hsafe2
  have hlarge4 := hlarge (4 * s) hzero4 hsafe4
  have hsmall := threeEven_circleNorm_double_lt_third ((2 * s) * (W : ℝ)) hlarge2
  have hsame : 2 * ((2 * s) * (W : ℝ)) = (4 * s) * (W : ℝ) := by ring
  rw [hsame] at hsmall
  linarith

/-- Every bounded sixth dilate of a speed at most one sixth of a positive
pivot is strictly within a sixth of an integer phase. -/
theorem threeEven_small_sixth_dilate_norm (A U : ℝ) (a : ℕ)
    (hA : 0 < A) (hU : 0 ≤ U) (hsmall : 6 * U ≤ A) (ha : a ≤ 5) :
    circleNorm (((a : ℝ) * (1 / (6 * A))) * U) < (1 : ℝ) / 6 := by
  have hden : 0 < 6 * A := by positivity
  have hbase : 0 ≤ (1 / (6 * A)) * U ∧
      (1 / (6 * A)) * U ≤ (1 : ℝ) / 36 := by
    constructor
    · positivity
    · rw [show (1 / (6 * A)) * U = U / (6 * A) by ring]
      apply (div_le_iff₀ hden).2
      nlinarith
  have haR : (a : ℝ) ≤ 5 := by exact_mod_cast ha
  have hphase0 : 0 ≤ ((a : ℝ) * (1 / (6 * A))) * U := by
    nlinarith [hbase.1]
  have hphase : ((a : ℝ) * (1 / (6 * A))) * U < (1 : ℝ) / 6 := by
    nlinarith [hbase.2]
  rw [circleNorm_eq_abs_of_abs_le_half]
  · rw [abs_of_nonneg hphase0]
    exact hphase
  · rw [abs_of_nonneg hphase0]
    linarith

end LonelyRunner
