import LonelyRunner.Definitions

/-!
# Verified base cases

Small cases are proved directly and do not import or assume the general
conjecture.
-/

namespace LonelyRunner

/-- One nonzero moving runner relative to a stationary runner reaches the
antipode.  Since there are two runners in total, this is exactly the sharp
`1 / 2` loneliness threshold. -/
theorem oneMovingRunner (speed : ℝ) (hspeed : speed ≠ 0) :
    ∃ time : ℝ,
      (2 : ℝ)⁻¹ ≤ ‖((time * speed : ℝ) : UnitCircle)‖ := by
  refine ⟨(2 * speed)⁻¹, ?_⟩
  have hphase : (2 * speed)⁻¹ * speed = (1 : ℝ) / 2 := by
    field_simp
  rw [hphase, AddCircle.norm_half_period_eq]
  norm_num

end LonelyRunner
