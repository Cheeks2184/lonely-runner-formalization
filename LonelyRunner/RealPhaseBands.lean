import LonelyRunner.StructuredClasses

/-!
# Strict real phase bands

Generic strict residue-band and periodicity facts used by finite phase
certificates.  They introduce no finite certificate data.
-/

namespace LonelyRunner

/-- A point strictly inside an integer residue band has circular distance
strictly greater than the band margin. -/
theorem circleNorm_gt_of_int_band (q : ℤ) (y δ : ℝ)
    (hδ0 : 0 ≤ δ)
    (hlower : (q : ℝ) + δ < y)
    (hupper : y < (q : ℝ) + 1 - δ) :
    δ < circleNorm y := by
  let ε : ℝ := min (y - (q : ℝ)) ((q : ℝ) + 1 - y)
  have hleft : δ < y - (q : ℝ) := by linarith
  have hright : δ < (q : ℝ) + 1 - y := by linarith
  have hδε : δ < ε := by
    dsimp [ε]
    exact lt_min hleft hright
  have hε0 : 0 ≤ ε := le_trans hδ0 hδε.le
  have hεleft : ε ≤ y - (q : ℝ) := by
    exact min_le_left _ _
  have hεright : ε ≤ (q : ℝ) + 1 - y := by
    exact min_le_right _ _
  have hεhalf : ε ≤ (1 : ℝ) / 2 := by
    nlinarith [hεleft, hεright]
  have hεlower : (q : ℝ) + ε ≤ y := by linarith
  have hεupper : y ≤ (q : ℝ) + 1 - ε := by linarith
  exact lt_of_lt_of_le hδε
    (circleNorm_ge_of_int_band q y ε hε0 hεhalf hεlower hεupper)

/-- Strict interior membership in an affine interval transfers closed endpoint
residue bounds to a strict circular-distance bound. -/
theorem circleNorm_gt_of_affine_open_band
    (q : ℤ) (A B L U x δ : ℝ)
    (hA : 0 < A) (hδ0 : 0 ≤ δ)
    (hlower : (q : ℝ) + δ ≤ A * L + B)
    (hupper : A * U + B ≤ (q : ℝ) + 1 - δ)
    (hxL : L < x) (hxU : x < U) :
    δ < circleNorm (A * x + B) := by
  apply circleNorm_gt_of_int_band q (A * x + B) δ hδ0
  · have hinterior : A * L + B < A * x + B := by
      nlinarith [mul_lt_mul_of_pos_left hxL hA]
    exact lt_of_le_of_lt hlower hinterior
  · have hinterior : A * x + B < A * U + B := by
      nlinarith [mul_lt_mul_of_pos_left hxU hA]
    exact lt_of_lt_of_le hinterior hupper

/-- Replacing a real phase by its fractional part preserves every natural
affine phase, including the zero slope. -/
theorem circleNorm_nat_affine_fract (A : ℕ) (B x : ℝ) :
    circleNorm ((A : ℝ) * Int.fract x + B) =
      circleNorm ((A : ℝ) * x + B) := by
  have hdecomp : x = (⌊x⌋ : ℤ) + Int.fract x :=
    (Int.floor_add_fract x).symm
  have hphase : (A : ℝ) * x + B =
      (((A : ℤ) * ⌊x⌋ : ℤ) : ℝ) + ((A : ℝ) * Int.fract x + B) := by
    nth_rw 1 [hdecomp]
    push_cast
    ring
  rw [hphase, circleNorm_add_int]

end LonelyRunner
