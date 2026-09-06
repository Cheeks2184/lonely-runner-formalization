import LonelyRunner.RenaultPhaseCertificates
import LonelyRunner.RealPhaseBands
import LonelyRunner.FiniteCutCover

/-!
# Generic Renault phase-band facts

This module decodes the fixed candidate indices and states the natural
arithmetic facts required of a concrete phase-mask certificate.
-/

namespace LonelyRunner

/-- The affine slope represented by a candidate index. -/
def phaseSlope (k : Fin 23) : ℕ :=
  if k.val < 20 then 2 + k.val / 5 else 1

/-- The affine sixth-turn shift represented by a candidate index. -/
def phaseShift (k : Fin 23) : ℕ :=
  if k.val < 20 then 1 + k.val % 5
  else if k.val = 20 then 1 else if k.val = 21 then 2 else 4

theorem phaseSlope_pos (k : Fin 23) : 0 < phaseSlope k := by
  unfold phaseSlope
  split <;> omega

/-- The representative numerator of a singleton or open cut atom. -/
def phaseRepresentative (C : ℕ → ℕ) (a : Fin 120) : ℕ :=
  if a.val % 2 = 0 then 2 * C (a.val / 2)
  else C (a.val / 2) + C (a.val / 2 + 1)

/-- The scaled phase numerator used by the finite natural checker. -/
def phaseNumerator (C : ℕ → ℕ) (a : Fin 120) (k : Fin 23) : ℕ :=
  phaseSlope k * phaseRepresentative C a + 120 * phaseShift k

/-- The natural quotient used to select an integer residue band. -/
def phaseQuotient (C : ℕ → ℕ) (a : Fin 120) (k : Fin 23) : ℕ :=
  phaseNumerator C a k / 720

/-- The finite true-bit arithmetic needed to transfer each atom mask to a
real phase band. -/
structure PhaseBandFacts (C : ℕ → ℕ) (M : Fin 120 → ℕ) : Prop where
  first : C 0 = 0
  last : C 60 = 360
  singleton : ∀ (a : Fin 120) (k : Fin 23),
    a.val % 2 = 0 → (M a).testBit k.val = true →
      if k.val < 20 then
        120 ≤ phaseNumerator C a k % 720 ∧
          phaseNumerator C a k % 720 ≤ 600
      else
        120 < phaseNumerator C a k % 720 ∧
          phaseNumerator C a k % 720 < 600
  interval : ∀ (a : Fin 120) (k : Fin 23),
    a.val % 2 ≠ 0 → (M a).testBit k.val = true →
      360 * phaseQuotient C a k + 60 ≤
          phaseSlope k * C (a.val / 2) + 60 * phaseShift k ∧
        phaseSlope k * C (a.val / 2 + 1) + 60 * phaseShift k ≤
          360 * phaseQuotient C a k + 300

/-- `PhaseGood` agrees with the uniform affine decoding of a candidate. -/
theorem phaseGood_iff (k : Fin 23) (x : ℝ) :
    PhaseGood k x ↔
      if k.val < 20 then
        (1 : ℝ) / 6 ≤ circleNorm
          ((phaseSlope k : ℝ) * x + (phaseShift k : ℝ) / 6)
      else
        (1 : ℝ) / 6 < circleNorm
          ((phaseSlope k : ℝ) * x + (phaseShift k : ℝ) / 6) := by
  by_cases hk : k.val < 20
  · simp [PhaseGood, phaseSlope, phaseShift, hk]
  · simp [PhaseGood, phaseSlope, phaseShift, hk]

/-- Candidate goodness is unchanged when an arbitrary real phase is replaced
by its fractional part. -/
theorem phaseGood_fract (k : Fin 23) (x : ℝ) :
    PhaseGood k (Int.fract x) ↔ PhaseGood k x := by
  rw [phaseGood_iff, phaseGood_iff]
  by_cases hk : k.val < 20
  · simp only [if_pos hk]
    rw [circleNorm_nat_affine_fract]
  · simp only [if_neg hk]
    rw [circleNorm_nat_affine_fract]

end LonelyRunner
