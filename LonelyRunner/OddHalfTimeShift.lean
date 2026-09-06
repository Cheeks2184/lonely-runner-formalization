import LonelyRunner.FoldedCirclePhase

namespace LonelyRunner

/-- For an odd natural speed, adding half a unit of time adds a half-turn
to its phase, up to an integral number of turns. -/
theorem circleNorm_time_add_half_of_not_dvd_two
    (t : ℝ) (d : ℕ) (hodd : ¬ 2 ∣ d) :
    circleNorm ((t + (1 : ℝ) / 2) * (d : ℝ)) =
      circleNorm (t * (d : ℝ) + (1 : ℝ) / 2) := by
  have hmod : d % 2 = 1 := by
    have hlt : d % 2 < 2 := Nat.mod_lt _ (by omega)
    have hne : d % 2 ≠ 0 := fun h => hodd (Nat.dvd_iff_mod_eq_zero.mpr h)
    omega
  have hd : d = 2 * (d / 2) + 1 := by omega
  have hdR : (d : ℝ) = 2 * ((d / 2 : ℕ) : ℝ) + 1 := by exact_mod_cast hd
  have hphase : (t + (1 : ℝ) / 2) * (d : ℝ) =
      ((d / 2 : ℕ) : ℤ) + (t * (d : ℝ) + (1 : ℝ) / 2) := by
    rw [Int.cast_natCast]
    nlinarith
  rw [hphase, circleNorm_add_int]

end LonelyRunner
