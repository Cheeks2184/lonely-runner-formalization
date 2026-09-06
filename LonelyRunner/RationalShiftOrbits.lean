import LonelyRunner.DivisorInsertion
import Mathlib.Tactic

namespace LonelyRunner

/-- A coprime rational orbit has a natural-index representative with the same
closed grid margin.  The reduction uses Euclidean `natMod`, so it also covers
negative integer witnesses. -/
theorem exists_nat_coprime_grid_circleNorm_ge (x : ℝ) (c n : ℕ)
    (hn : 0 < n) (hc : Nat.Coprime c n) :
    ∃ k : ℕ, k < n ∧
      ((n : ℝ) - 1) / (2 * (n : ℝ)) ≤
        circleNorm (x + (k : ℝ) * (c : ℝ) / (n : ℝ)) := by
  obtain ⟨K, hK⟩ := exists_int_coprime_grid_circleNorm_ge x c n hn hc
  let k : ℕ := K.natMod n
  have hk : k < n := by
    dsimp [k]
    exact Int.natMod_lt hn.ne'
  refine ⟨k, hk, ?_⟩
  have hmod := Int.emod_add_mul_ediv K (n : ℤ)
  have hrem : (k : ℤ) = K % (n : ℤ) := by
    dsimp [k, Int.natMod]
    exact Int.toNat_of_nonneg
      (Int.emod_nonneg _ (by exact_mod_cast hn.ne'))
  have hcast : (k : ℤ) + (n : ℤ) * (K / (n : ℤ)) = K := by
    rw [hrem]
    exact hmod
  have hphase :
      x + (K : ℝ) * (c : ℝ) / (n : ℝ) =
        ((K / (n : ℤ) * (c : ℤ) : ℤ) : ℝ) +
          (x + (k : ℝ) * (c : ℝ) / (n : ℝ)) := by
    have hnR : (n : ℝ) ≠ 0 := by exact_mod_cast hn.ne'
    have hcastR := congrArg (fun z : ℤ => (z : ℝ)) hcast
    push_cast at hcastR
    have hmul := congrArg (fun z : ℝ => z * (c : ℝ)) hcastR
    push_cast
    field_simp [hnR]
    nlinarith [hmul]
  rw [hphase, circleNorm_add_int] at hK
  exact hK

/-- Shifting time by a reciprocal divisor leaves that runner's circle phase
unchanged; the integer shift may be zero. -/
theorem circleNorm_time_add_nat_div_of_dvd (ell a k : ℕ)
    (hell : 0 < ell) (hdiv : ell ∣ a) (t : ℝ) :
    circleNorm ((t + (k : ℝ) / (ell : ℝ)) * (a : ℝ)) =
      circleNorm (t * (a : ℝ)) := by
  obtain ⟨r, rfl⟩ := hdiv
  have hellR : (ell : ℝ) ≠ 0 := by exact_mod_cast hell.ne'
  have hphase :
      (t + (k : ℝ) / (ell : ℝ)) * ((ell * r : ℕ) : ℝ) =
        (k * r : ℤ) + t * ((ell * r : ℕ) : ℝ) := by
    rw [Nat.cast_mul]
    field_simp
    push_cast
    ring
  rw [hphase, circleNorm_add_int]

end LonelyRunner
