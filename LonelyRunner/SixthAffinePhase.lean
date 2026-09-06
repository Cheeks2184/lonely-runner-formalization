import Mathlib.Tactic

namespace LonelyRunner

/-- Reducing a sixth-affine phase depends only on the fractional input phase
and the signed residue of the speed modulo six. -/
theorem fract_sixth_affine_time (t : ℝ) (d : ℕ) (α β z e : ℤ)
    (hd : (d : ℤ) = 6 * z + e) :
    Int.fract (((α : ℝ) * t + (β : ℝ) / 6) * (d : ℝ)) =
      Int.fract ((α : ℝ) * Int.fract (t * (d : ℝ)) + ((β * e : ℤ) : ℝ) / 6) := by
  apply Int.fract_eq_fract.mpr
  refine ⟨α * ⌊t * (d : ℝ)⌋ + β * z, ?_⟩
  have hdR : (d : ℝ) = 6 * (z : ℝ) + (e : ℝ) := by exact_mod_cast hd
  have hfloor := Int.floor_add_fract (t * (d : ℝ))
  have ha := congrArg (fun y : ℝ => (α : ℝ) * y) hfloor
  have hb := congrArg (fun y : ℝ => (β : ℝ) * y) hdR
  push_cast
  nlinarith [ha, hb]

/-- A natural speed not divisible by three has one of the four centered
signed residues modulo six, using its natural Euclidean quotient. -/
theorem exists_centered_sixth_residue_of_not_dvd_three (d : ℕ)
    (hnot : ¬ 3 ∣ d) :
    ∃ z e : ℤ, (d : ℤ) = 6 * z + e ∧
      (e = 1 ∨ e = -1 ∨ e = 2 ∨ e = -2) := by
  let q : ℕ := d / 6
  let r : ℕ := d % 6
  have hdecomp : d = 6 * q + r := by
    dsimp [q, r]
    omega
  have hrlt : r < 6 := by
    dsimp [r]
    exact Nat.mod_lt _ (by omega)
  have hrnot0 : r ≠ 0 := by
    intro hr
    apply hnot
    rw [hdecomp, hr]
    refine ⟨2 * q, by ring⟩
  have hrnot3 : r ≠ 3 := by
    intro hr
    apply hnot
    rw [hdecomp, hr]
    refine ⟨2 * q + 1, by ring⟩
  have hrcases : r = 1 ∨ r = 2 ∨ r = 4 ∨ r = 5 := by omega
  rcases hrcases with hr | hr | hr | hr
  · refine ⟨q, 1, ?_, Or.inl rfl⟩
    rw [hdecomp, hr]
    norm_num
  · refine ⟨q, 2, ?_, Or.inr (Or.inr (Or.inl rfl))⟩
    rw [hdecomp, hr]
    norm_num
  · refine ⟨(q : ℤ) + 1, -2, ?_, Or.inr (Or.inr (Or.inr rfl))⟩
    rw [hdecomp, hr]
    push_cast
    ring
  · refine ⟨(q : ℤ) + 1, -1, ?_, Or.inr (Or.inl rfl)⟩
    rw [hdecomp, hr]
    push_cast
    ring

end LonelyRunner
