import LonelyRunner.SixthAffinePhase
import LonelyRunner.SpecialSixthPhase
import LonelyRunner.RationalShiftOrbits

/-!
# Transport from a five-sixths fibre

The first lemma removes integral turns before dilating a fractional phase.  The
second uses a third shift to transport a bound on the five-sixths fibre to all
three odd-sixth phases while preserving two divisible speeds.
-/

namespace LonelyRunner

/-- Integral dilation depends only on the fractional part, for arbitrary
signed multipliers and real inputs. -/
theorem fract_int_dilate_eq (n : ℤ) (x : ℝ) :
    Int.fract ((n : ℝ) * x) = Int.fract ((n : ℝ) * Int.fract x) := by
  simpa using fract_sixth_affine_time x 1 n 0 0 1 (by norm_num)

/-- A bound on the five-sixths fibre transfers to every odd-sixth phase when
the two measured speeds are divisible by three. -/
theorem pair_min_le_of_special_sixth_fiber_bound
    (a b c : ℕ) (ha : 3 ∣ a) (hb : 3 ∣ b) (hc : ¬ 3 ∣ c) (M : ℝ)
    (hmax : ∀ s : ℝ, Int.fract (s * (c : ℝ)) = (5 : ℝ) / 6 →
      min (circleNorm (s * (a : ℝ))) (circleNorm (s * (b : ℝ))) ≤ M)
    (t : ℝ)
    (ht : Int.fract (t * (c : ℝ)) = (1 : ℝ) / 6 ∨
      Int.fract (t * (c : ℝ)) = (1 : ℝ) / 2 ∨
      Int.fract (t * (c : ℝ)) = (5 : ℝ) / 6) :
    min (circleNorm (t * (a : ℝ))) (circleNorm (t * (b : ℝ))) ≤ M := by
  obtain ⟨k, hk⟩ := exists_third_shift_fract_five_sixths
    (t * (c : ℝ)) c hc ht
  let s : ℝ := t + (k.val : ℝ) / 3
  have hphaseC : s * (c : ℝ) =
      t * (c : ℝ) + (k.val : ℝ) * (c : ℝ) / 3 := by
    dsimp [s]
    ring
  have hanchor : Int.fract (s * (c : ℝ)) = (5 : ℝ) / 6 := by
    rw [hphaseC]
    exact hk
  have hbound := hmax s hanchor
  have hpresA := circleNorm_time_add_nat_div_of_dvd 3 a k.val
    (by norm_num) ha t
  have hpresB := circleNorm_time_add_nat_div_of_dvd 3 b k.val
    (by norm_num) hb t
  norm_num only [Nat.cast_ofNat] at hpresA hpresB
  dsimp [s] at hbound
  rw [hpresA, hpresB] at hbound
  exact hbound

end LonelyRunner
