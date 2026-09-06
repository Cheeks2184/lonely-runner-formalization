import LonelyRunner.BufferedRunnerInsertion
import LonelyRunner.FourRunnerMixed
import LonelyRunner.FiveRunnerMixed
import Mathlib.Tactic

/-!
# Buffered five-runner mixed witnesses

This module combines a mixed four-runner seed with the finite-band buffered
insertion theorem.  The two numerical hypotheses are exactly the two distinct
endpoint-pair width bounds for the seed margins `(1/4, 1/4, 1/3)`.
-/

namespace LonelyRunner

private theorem same_width_bound {w c H : ℕ} (hw : 0 < w) (hwc : w ≤ c)
    (hcH : c < H) :
    (2 * ((4 : ℝ)⁻¹)) / (H : ℝ) ≤
      (1 - 2 * ((5 : ℝ)⁻¹)) / (w : ℝ) := by
  have hwR : 0 < (w : ℝ) := by exact_mod_cast hw
  have hwcR : (w : ℝ) ≤ c := by exact_mod_cast hwc
  have hcHR : (c : ℝ) < H := by exact_mod_cast hcH
  rw [show (2 : ℝ) * (4 : ℝ)⁻¹ = 1 / 2 by norm_num,
    show 1 - 2 * ((5 : ℝ)⁻¹) = 3 / 5 by norm_num]
  rw [div_div, div_div]
  apply (div_le_div_iff₀ (by nlinarith [hcHR] : 0 < (2 : ℝ) * H)
    (by nlinarith [hwR] : 0 < (5 : ℝ) * w)).mpr
  nlinarith

private theorem pair_width_ab {a b H : ℕ} (ha : 0 < a) (hb : 0 < b) (hH : 0 < H)
    (hAB : 10 * a * b ≤ H * (a + b)) :
    (2 * ((4 : ℝ)⁻¹)) / (H : ℝ) ≤
      (((4 : ℝ)⁻¹) - (5 : ℝ)⁻¹) / (a : ℝ) +
        (((4 : ℝ)⁻¹) - (5 : ℝ)⁻¹) / (b : ℝ) := by
  have haR : 0 < (a : ℝ) := by exact_mod_cast ha
  have hbR : 0 < (b : ℝ) := by exact_mod_cast hb
  have hHR : 0 < (H : ℝ) := by exact_mod_cast hH
  have hABR : (10 : ℝ) * a * b ≤ H * (a + b) := by exact_mod_cast hAB
  norm_num
  field_simp
  nlinarith

private theorem pair_width_bc {b c H : ℕ} (hb : 0 < b) (hc : 0 < c) (hH : 0 < H)
    (hBC : 30 * b * c ≤ H * (3 * c + 8 * b)) :
    (2 * ((4 : ℝ)⁻¹)) / (H : ℝ) ≤
      (((4 : ℝ)⁻¹) - (5 : ℝ)⁻¹) / (b : ℝ) +
        (((3 : ℝ)⁻¹) - (5 : ℝ)⁻¹) / (c : ℝ) := by
  have hbR : 0 < (b : ℝ) := by exact_mod_cast hb
  have hcR : 0 < (c : ℝ) := by exact_mod_cast hc
  have hHR : 0 < (H : ℝ) := by exact_mod_cast hH
  have hBCR : (30 : ℝ) * b * c ≤ H * (3 * c + 8 * b) := by exact_mod_cast hBC
  norm_num
  field_simp
  nlinarith

/-- The two buffered endpoint-width inequalities give a five-runner mixed
witness for every positive increasing natural quadruple. -/
theorem fiveRunnerMixed_of_buffer_inequalities (a b c H : ℕ)
    (ha : 0 < a) (hab : a < b) (hbc : b < c) (hcH : c < H)
    (hAB : 10 * a * b ≤ H * (a + b))
    (hBC : 30 * b * c ≤ H * (3 * c + 8 * b)) :
    FiveRunnerMixed a b c H := by
  by_cases hexception : b = 2 * a ∧ c = 3 * a
  · obtain ⟨hb, hc⟩ := hexception
    subst b
    subst c
    exact fiveRunnerMixed_exceptional a H ha (by omega)
  · obtain ⟨seed, hseed, hA, hB, hC⟩ :=
      (fourRunnerMixed_iff ha hab hbc).mpr hexception
    let speeds : Fin 3 → ℝ := ![(a : ℝ), (b : ℝ), (c : ℝ)]
    let margins : Fin 3 → ℝ := ![(4 : ℝ)⁻¹, (4 : ℝ)⁻¹, (3 : ℝ)⁻¹]
    have hH : 0 < H := by omega
    obtain ⟨time, htime, hfast, hold⟩ := bufferedRunnerInsertion (n := 3) (by omega)
      speeds (by
        intro i
        fin_cases i <;> simp [speeds]
        · exact_mod_cast ha
        · exact_mod_cast (by omega : 0 < b)
        · exact_mod_cast (by omega : 0 < c))
      seed hseed (H : ℝ) (by exact_mod_cast hH)
      ((5 : ℝ)⁻¹) ((4 : ℝ)⁻¹) (by norm_num) (by norm_num) (by norm_num) (by norm_num)
      margins (by
        intro i
        fin_cases i <;> norm_num [margins])
      (by
        intro i
        fin_cases i
        · simpa [speeds, margins] using hA
        · simpa [speeds, margins] using hB
        · simpa [speeds, margins] using hC)
      (by
        intro i
        fin_cases i
        · simpa [speeds] using same_width_bound ha (by omega : a ≤ c) hcH
        · simpa [speeds] using same_width_bound (by omega : 0 < b) (by omega : b ≤ c) hcH
        · simpa [speeds] using same_width_bound (by omega : 0 < c) (by omega : c ≤ c) hcH)
      (by
        have habWidth := pair_width_ab ha (by omega : 0 < b) hH hAB
        have hbcWidth := pair_width_bc (by omega : 0 < b) (by omega : 0 < c) hH hBC
        have hba : (((4 : ℝ)⁻¹ - (5 : ℝ)⁻¹) / (b : ℝ)) ≤
            ((4 : ℝ)⁻¹ - (5 : ℝ)⁻¹) / (a : ℝ) := by
          norm_num
          rw [div_div, div_div]
          apply one_div_le_one_div_of_le
          · positivity
          · nlinarith [show (a : ℝ) < b by exact_mod_cast hab]
        have hacWidth : (2 * ((4 : ℝ)⁻¹)) / (H : ℝ) ≤
            (((4 : ℝ)⁻¹) - (5 : ℝ)⁻¹) / (a : ℝ) +
              (((3 : ℝ)⁻¹) - (5 : ℝ)⁻¹) / (c : ℝ) := by
          linarith
        intro i j hij
        fin_cases i <;> fin_cases j
        · exact (hij rfl).elim
        · simpa [speeds, margins] using habWidth
        · simpa [speeds, margins, add_comm] using hacWidth
        · simpa [speeds, margins, add_comm] using habWidth
        · exact (hij rfl).elim
        · simpa [speeds, margins] using hbcWidth
        · simpa [speeds, margins, add_comm] using hacWidth
        · simpa [speeds, margins, add_comm] using hbcWidth
        · exact (hij rfl).elim)
    refine ⟨time, htime, ?_, ?_, ?_, ?_⟩
    · simpa [speeds] using hold 0
    · simpa [speeds] using hold 1
    · simpa [speeds] using hold 2
    · simpa using hfast

/-- The coarse height condition `22 b ≤ 3 H` implies the two buffered
endpoint-width inequalities. -/
theorem fiveRunnerMixed_of_three_mul_height_ge (a b c H : ℕ)
    (ha : 0 < a) (hab : a < b) (hbc : b < c) (hcH : c < H)
    (hheight : 22 * b ≤ 3 * H) :
    FiveRunnerMixed a b c H := by
  apply fiveRunnerMixed_of_buffer_inequalities a b c H ha hab hbc hcH
  · have hfive : 5 * b ≤ H := by omega
    nlinarith [Nat.mul_le_mul_left a hfive,
      Nat.mul_le_mul_left (5 * b) (Nat.le_of_lt hab)]
  · have hcH' : c ≤ H := Nat.le_of_lt hcH
    have h1 := Nat.mul_le_mul_right c hheight
    have h2 := Nat.mul_le_mul_left (8 * b) hcH'
    nlinarith

end LonelyRunner
