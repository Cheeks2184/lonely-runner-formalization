import LonelyRunner.PairSumCompleteness
import Mathlib.Data.Finset.Max

/-!
# Endpoint completeness for closed natural-speed witnesses

A closed witness can be reflected into the half period.  The maximum left floor
band endpoint remains feasible for every speed and is owned by one coordinate.
-/

namespace LonelyRunner

/-- A closed witness for positive natural speeds has a feasible left floor-band
endpoint in the half period. -/
theorem exists_endpoint_time_of_witness {n : ℕ} (hn : 0 < n)
    (speeds : Fin n → ℕ) (hspeeds : ∀ i, 0 < speeds i)
    (margins : Fin n → ℝ) (hmargins : ∀ i, 0 < margins i)
    (hhalf : ∀ i, margins i ≤ (1 : ℝ) / 2)
    (time : ℝ) (hwitness : ∀ i,
      margins i ≤ circleNorm (time * (speeds i : ℝ))) :
    ∃ p : Fin n, ∃ k : ℕ, k < (speeds p + 1) / 2 ∧
      let T : ℝ := ((k : ℝ) + margins p) / (speeds p : ℝ)
      0 < T ∧ T ≤ (1 : ℝ) / 2 ∧ ∀ i,
        margins i ≤ circleNorm (T * (speeds i : ℝ)) := by
  classical
  let x : ℝ := Int.fract time
  let seed : ℝ := if x ≤ (1 : ℝ) / 2 then x else 1 - x
  have hseed0 : 0 ≤ seed := by
    dsimp [seed]
    split <;> linarith [Int.fract_nonneg time, Int.fract_lt_one time]
  have hseedhalf : seed ≤ (1 : ℝ) / 2 := by
    dsimp [seed]
    split <;> linarith [Int.fract_nonneg time, Int.fract_lt_one time]
  have hseedgood : ∀ i, margins i ≤ circleNorm (seed * (speeds i : ℝ)) := by
    intro i
    dsimp [seed]
    split
    · rw [circleNorm_fract_mul_nat time (speeds i)]
      exact hwitness i
    · rw [show (1 - x) * (speeds i : ℝ) =
          ((speeds i : ℤ) : ℝ) + -(x * (speeds i : ℝ)) by push_cast; ring,
        circleNorm_add_int, circleNorm_neg,
        circleNorm_fract_mul_nat time (speeds i)]
      exact hwitness i
  let z : Fin n → ℕ := fun i => ⌊seed * (speeds i : ℝ)⌋₊
  let L : Fin n → ℝ := fun i => ((z i : ℝ) + margins i) / (speeds i : ℝ)
  have hnonempty : (Finset.univ : Finset (Fin n)).Nonempty :=
    ⟨⟨0, hn⟩, Finset.mem_univ _⟩
  obtain ⟨p, hp, hpmax⟩ := Finset.exists_max_image Finset.univ L hnonempty
  have hfloorlo : ∀ i, (z i : ℝ) ≤ seed * (speeds i : ℝ) := by
    intro i; exact Nat.floor_le (mul_nonneg hseed0 (by positivity))
  have hfloorhi : ∀ i, seed * (speeds i : ℝ) ≤ (z i : ℝ) + 1 := by
    intro i; exact (Nat.lt_floor_add_one _).le
  have hband : ∀ i, (z i : ℝ) + margins i ≤ seed * (speeds i : ℝ) ∧
      seed * (speeds i : ℝ) ≤ (z i : ℝ) + 1 - margins i := by
    intro i
    exact int_band_of_circleNorm_ge (z i : ℤ) _ _ (by exact_mod_cast hfloorlo i)
      (by exact_mod_cast hfloorhi i) (hseedgood i)
  let T : ℝ := L p
  have hTseed : T ≤ seed := by
    dsimp [T, L]
    exact (div_le_iff₀ (by exact_mod_cast hspeeds p)).mpr (hband p).1
  have hTall : ∀ i, margins i ≤ circleNorm (T * (speeds i : ℝ)) := by
    intro i
    have hL : L i ≤ L p := hpmax i (Finset.mem_univ _)
    have hupper : T * (speeds i : ℝ) ≤ (z i : ℝ) + 1 - margins i := by
      have := (hband i).2
      dsimp [T, L] at hL ⊢
      nlinarith [hTseed, this]
    apply circleNorm_ge_of_int_band (z i : ℤ) _ _ (le_of_lt (hmargins i)) (hhalf i)
    · exact (div_le_iff₀ (by exact_mod_cast hspeeds i)).mp (by simpa [T, L] using hL)
    · exact hupper
  refine ⟨p, z p, ?_, ?_, hTseed.trans hseedhalf, hTall⟩
  · have hT_half : T ≤ (1 : ℝ) / 2 := hTseed.trans hseedhalf
    have hzt : (z p : ℝ) + margins p ≤ (speeds p : ℝ) / 2 := by
      dsimp [T, L] at hT_half
      have hpR : 0 < (speeds p : ℝ) := by exact_mod_cast hspeeds p
      rw [div_le_iff₀ hpR] at hT_half
      nlinarith
    have hz2 : 2 * z p < speeds p := by
      exact_mod_cast (show 2 * (z p : ℝ) < (speeds p : ℝ) by
        nlinarith [hmargins p])
    omega
  · apply div_pos
    · exact add_pos_of_nonneg_of_pos (Nat.cast_nonneg _) (hmargins p)
    · exact_mod_cast hspeeds p

end LonelyRunner
