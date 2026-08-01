import LonelyRunner.FastRunnerInsertion

/-!
# Codimension-one divisor insertion

The main theorem in this file inserts one exceptional positive-natural speed
into a witnessed tuple whose other speeds share a common divisor.  Its
arithmetic hypothesis is stated using the reduced coprime step of the
exceptional runner's orbit; this keeps the exact orbit size visible and avoids
any implicit appeal to a finite enumeration.
-/

namespace LonelyRunner

/-- A translate of the `m`-point rational grid contains a point within half a
mesh of the antipode.  The displayed lower bound is
`1 / 2 - 1 / (2m)`, written without a nested subtraction. -/
theorem exists_int_grid_circleNorm_ge (x : ℝ) (m : ℕ) (hm : 0 < m) :
    ∃ q : ℤ,
      ((m : ℝ) - 1) / (2 * (m : ℝ)) ≤
        circleNorm (x + (q : ℝ) / (m : ℝ)) := by
  let y : ℝ := (m : ℝ) * ((1 : ℝ) / 2 - x)
  let q : ℤ := ⌊y + (1 : ℝ) / 2⌋
  have hq_upper : (q : ℝ) - y ≤ (1 : ℝ) / 2 := by
    have h := Int.floor_le (y + (1 : ℝ) / 2)
    change (q : ℝ) ≤ y + (1 : ℝ) / 2 at h
    linarith
  have hq_lower : -((1 : ℝ) / 2) ≤ (q : ℝ) - y := by
    have h := Int.lt_floor_add_one (y + (1 : ℝ) / 2)
    change y + (1 : ℝ) / 2 < (q : ℝ) + 1 at h
    linarith
  have hq : |(q : ℝ) - y| ≤ (1 : ℝ) / 2 :=
    (abs_le).2 ⟨hq_lower, hq_upper⟩
  have hmR : 0 < (m : ℝ) := by exact_mod_cast hm
  have herror :
      |(1 : ℝ) / 2 - (x + (q : ℝ) / (m : ℝ))| ≤
        1 / (2 * (m : ℝ)) := by
    have hid :
        (1 : ℝ) / 2 - (x + (q : ℝ) / (m : ℝ)) =
          (y - (q : ℝ)) / (m : ℝ) := by
      dsimp [y]
      field_simp
      ring
    rw [hid, abs_div, abs_sub_comm]
    rw [div_le_iff₀ (abs_pos.mpr hmR.ne')]
    rw [abs_of_pos hmR]
    calc
      |(q : ℝ) - y| ≤ (1 : ℝ) / 2 := hq
      _ = 1 / (2 * (m : ℝ)) * (m : ℝ) := by field_simp
  refine ⟨q, ?_⟩
  have hlip := circleNorm_sub_abs_le_circleNorm
    ((1 : ℝ) / 2) (x + (q : ℝ) / (m : ℝ))
  have hhalf : circleNorm ((1 : ℝ) / 2) = (1 : ℝ) / 2 := by
    simpa [circleNorm] using
      (AddCircle.norm_half_period_eq (p := (1 : ℝ)))
  rw [hhalf] at hlip
  have halgebra :
      ((m : ℝ) - 1) / (2 * (m : ℝ)) =
        (1 : ℝ) / 2 - 1 / (2 * (m : ℝ)) := by
    field_simp
  rw [halgebra]
  linarith

/-- Multiplying the mesh step by a number coprime to `m` only permutes the
grid modulo one.  The witnessing shift is an integer and need not be chosen in
a particular residue range. -/
theorem exists_int_coprime_grid_circleNorm_ge (x : ℝ) (c m : ℕ)
    (hm : 0 < m) (hc : Nat.Coprime c m) :
    ∃ k : ℤ,
      ((m : ℝ) - 1) / (2 * (m : ℝ)) ≤
        circleNorm (x + (k : ℝ) * (c : ℝ) / (m : ℝ)) := by
  obtain ⟨q, hq⟩ := exists_int_grid_circleNorm_ge x m hm
  let u : ℤ := Nat.gcdA c m
  let v : ℤ := Nat.gcdB c m
  let k : ℤ := q * u
  have hbez : (1 : ℤ) = (c : ℤ) * u + (m : ℤ) * v := by
    have h := Nat.gcd_eq_gcd_ab c m
    rw [hc.gcd_eq_one] at h
    simpa [u, v, mul_comm] using h
  have hphase :
      x + (k : ℝ) * (c : ℝ) / (m : ℝ) =
        ((-q * v : ℤ) : ℝ) + (x + (q : ℝ) / (m : ℝ)) := by
    have hmR : (m : ℝ) ≠ 0 := by exact_mod_cast hm.ne'
    have hbezR : (1 : ℝ) = (c : ℝ) * (u : ℝ) + (m : ℝ) * (v : ℝ) := by
      exact_mod_cast hbez
    dsimp [k]
    push_cast
    field_simp
    have hmul := congrArg (fun z : ℝ ↦ (q : ℝ) * z) hbezR
    ring_nf at hmul ⊢
    linarith
  refine ⟨k, ?_⟩
  rw [hphase, circleNorm_add_int]
  exact hq

/-- Insert an exceptional speed into `n` old moving speeds.

`D = g*m` is the common divisor of the old speeds, while the exceptional
speed is `g*c` with `c` coprime to `m`.  Thus `m` is exactly the size of its
orbit under the integer shifts `(s+k)/D`.  A supplied witness for the divided
old tuple at threshold `1/(n+1)`, together with the closed mesh inequality,
produces a witness for all `n+1` moving speeds at threshold `1/(n+2)`. -/
theorem codimensionOneDivisorInsertion {n : ℕ}
    (dividedSpeeds : Fin n → ℕ) (exceptional D g c m : ℕ)
    (s : ℝ)
    (hg : 0 < g) (hm : 0 < m)
    (hD : D = g * m) (hexceptional : exceptional = g * c)
    (hc : Nat.Coprime c m)
    (hold : ∀ i,
      (((n + 1 : ℕ) : ℝ)⁻¹) ≤
        circleNorm (s * (dividedSpeeds i : ℝ)))
    (hclosed : 2 * m ≤ (n + 2) * (m - 1)) :
    ∃ time : ℝ,
      (((n + 2 : ℕ) : ℝ)⁻¹) ≤
        circleNorm (time * (exceptional : ℝ)) ∧
      ∀ i,
        (((n + 2 : ℕ) : ℝ)⁻¹) ≤
          circleNorm (time * ((D * dividedSpeeds i : ℕ) : ℝ)) := by
  have hgR : 0 < (g : ℝ) := by exact_mod_cast hg
  have hmR : 0 < (m : ℝ) := by exact_mod_cast hm
  have hDR : 0 < (D : ℝ) := by
    rw [hD, Nat.cast_mul]
    positivity
  let x : ℝ := s * (exceptional : ℝ) / (D : ℝ)
  obtain ⟨k, hk⟩ :=
    exists_int_coprime_grid_circleNorm_ge x c m hm hc
  let time : ℝ := (s + (k : ℝ)) / (D : ℝ)
  have hexceptionalPhase :
      time * (exceptional : ℝ) =
        x + (k : ℝ) * (c : ℝ) / (m : ℝ) := by
    dsimp [time, x]
    rw [hD, hexceptional, Nat.cast_mul, Nat.cast_mul]
    field_simp
  have hmesh :
      (((n + 2 : ℕ) : ℝ)⁻¹) ≤
        ((m : ℝ) - 1) / (2 * (m : ℝ)) := by
    have hnR : 0 < (((n + 2 : ℕ) : ℝ)) := by positivity
    have hclosedR :
        (2 : ℝ) * (m : ℝ) ≤
          ((n + 2 : ℕ) : ℝ) * ((m : ℝ) - 1) := by
      have hmone : 1 ≤ m := hm
      have hmsub : ((m - 1 : ℕ) : ℝ) = (m : ℝ) - 1 := by
        rw [Nat.cast_sub hmone]
        norm_num
      have hclosedCast :
          ((2 * m : ℕ) : ℝ) ≤ (((n + 2) * (m - 1) : ℕ) : ℝ) := by
        exact_mod_cast hclosed
      simpa only [Nat.cast_mul, Nat.cast_ofNat, hmsub] using hclosedCast
    rw [inv_eq_one_div]
    apply (div_le_div_iff₀ hnR
      (by positivity : 0 < (2 : ℝ) * (m : ℝ))).2
    nlinarith
  refine ⟨time, ?_, ?_⟩
  · rw [hexceptionalPhase]
    exact hmesh.trans hk
  · intro i
    have holdWeak :
        (((n + 2 : ℕ) : ℝ)⁻¹) ≤
          circleNorm (s * (dividedSpeeds i : ℝ)) := by
      apply le_trans ?_ (hold i)
      apply inv_anti₀
      · positivity
      · norm_num
    have hphase :
        time * ((D * dividedSpeeds i : ℕ) : ℝ) =
          (k * (dividedSpeeds i : ℤ) : ℤ) +
            s * (dividedSpeeds i : ℝ) := by
      dsimp [time]
      rw [Nat.cast_mul]
      field_simp
      push_cast
      ring
    rw [hphase, circleNorm_add_int]
    exact holdWeak

end LonelyRunner
