import LonelyRunner.RenaultPhaseBandFacts
import LonelyRunner.FiniteMaskCertificates

/-!
# Real soundness of Renault phase-band facts

The finite natural predicates in `PhaseBandFacts` are sufficient to certify
every true mask bit on its singleton or open cut atom.
-/

namespace LonelyRunner

theorem phaseBandFacts_sound (C : ℕ → ℕ) (M : Fin 120 → ℕ)
    (h : PhaseBandFacts C M) :
    ∀ (a : Fin 120) (k : Fin 23), k ∈ maskCandidates 23 (M a) →
      ∀ x : ℝ, CutAtomMem C 360 a.val x → PhaseGood k x := by
  intro a k hmem x hx
  have hbit : (M a).testBit k.val = true := mem_maskCandidates.mp hmem
  rw [phaseGood_iff]
  by_cases hk : k.val < 20
  · rw [if_pos hk]
    by_cases ha : a.val % 2 = 0
    · have hxsingle : x = (C (a.val / 2) : ℝ) / 360 := by
        simpa [CutAtomMem, ha] using hx
      let N : ℕ := phaseNumerator C a k
      let Q : ℕ := N / 720
      let R : ℕ := N % 720
      have hN : N = phaseSlope k * (2 * C (a.val / 2)) +
          120 * phaseShift k := by
        simp [N, phaseNumerator, phaseRepresentative, ha]
      have hdiv : 720 * Q + R = N := by
        simp only [Q, R]
        simpa [Nat.mul_comm] using (Nat.div_add_mod N 720)
      have hdivR : (720 : ℝ) * (Q : ℝ) + (R : ℝ) = (N : ℝ) := by
        exact_mod_cast hdiv
      have hphase : (phaseSlope k : ℝ) * x +
          (phaseShift k : ℝ) / 6 = (Q : ℝ) + (R : ℝ) / 720 := by
        rw [hxsingle]
        norm_num [hN] at hdivR ⊢
        nlinarith [hdivR]
      have hrem := h.singleton a k ha hbit
      rw [if_pos hk] at hrem
      have hRlower : (120 : ℝ) ≤ (R : ℝ) := by exact_mod_cast hrem.1
      have hRupper : (R : ℝ) ≤ 600 := by exact_mod_cast hrem.2
      rw [hphase]
      apply circleNorm_ge_of_int_band (Q : ℤ)
        ((Q : ℝ) + (R : ℝ) / 720) ((1 : ℝ) / 6)
      · norm_num
      · norm_num
      · norm_num
        nlinarith [hRlower]
      · norm_num
        nlinarith [hRupper]
    · obtain ⟨hxlower, hxupper⟩ :
          (C (a.val / 2) : ℝ) / 360 < x ∧
            x < (C (a.val / 2 + 1) : ℝ) / 360 := by
        simpa [CutAtomMem, ha] using hx
      let Q : ℕ := phaseQuotient C a k
      have hinterval := h.interval a k ha hbit
      have hlowerNat : 360 * Q + 60 ≤
          phaseSlope k * C (a.val / 2) + 60 * phaseShift k := by
        simpa [Q] using hinterval.1
      have hupperNat :
          phaseSlope k * C (a.val / 2 + 1) + 60 * phaseShift k ≤
            360 * Q + 300 := by
        simpa [Q] using hinterval.2
      have hlowerReal : (360 : ℝ) * (Q : ℝ) + 60 ≤
          (phaseSlope k : ℝ) * (C (a.val / 2) : ℝ) +
            60 * (phaseShift k : ℝ) := by
        exact_mod_cast hlowerNat
      have hupperReal :
          (phaseSlope k : ℝ) * (C (a.val / 2 + 1) : ℝ) +
            60 * (phaseShift k : ℝ) ≤ (360 : ℝ) * (Q : ℝ) + 300 := by
        exact_mod_cast hupperNat
      have hlowerBand : ((Q : ℤ) : ℝ) + (1 : ℝ) / 6 ≤
          (phaseSlope k : ℝ) * ((C (a.val / 2) : ℝ) / 360) +
            (phaseShift k : ℝ) / 6 := by
        norm_num
        nlinarith [hlowerReal]
      have hupperBand :
          (phaseSlope k : ℝ) * ((C (a.val / 2 + 1) : ℝ) / 360) +
              (phaseShift k : ℝ) / 6 ≤
            ((Q : ℤ) : ℝ) + 1 - (1 : ℝ) / 6 := by
        norm_num
        nlinarith [hupperReal]
      exact le_of_lt (circleNorm_gt_of_affine_open_band (Q : ℤ)
        (phaseSlope k : ℝ) ((phaseShift k : ℝ) / 6)
        ((C (a.val / 2) : ℝ) / 360)
        ((C (a.val / 2 + 1) : ℝ) / 360) x ((1 : ℝ) / 6)
        (by exact_mod_cast phaseSlope_pos k) (by norm_num)
        hlowerBand hupperBand hxlower hxupper)
  · rw [if_neg hk]
    by_cases ha : a.val % 2 = 0
    · have hxsingle : x = (C (a.val / 2) : ℝ) / 360 := by
        simpa [CutAtomMem, ha] using hx
      let N : ℕ := phaseNumerator C a k
      let Q : ℕ := N / 720
      let R : ℕ := N % 720
      have hN : N = phaseSlope k * (2 * C (a.val / 2)) +
          120 * phaseShift k := by
        simp [N, phaseNumerator, phaseRepresentative, ha]
      have hdiv : 720 * Q + R = N := by
        simp only [Q, R]
        simpa [Nat.mul_comm] using (Nat.div_add_mod N 720)
      have hdivR : (720 : ℝ) * (Q : ℝ) + (R : ℝ) = (N : ℝ) := by
        exact_mod_cast hdiv
      have hphase : (phaseSlope k : ℝ) * x +
          (phaseShift k : ℝ) / 6 = (Q : ℝ) + (R : ℝ) / 720 := by
        rw [hxsingle]
        norm_num [hN] at hdivR ⊢
        nlinarith [hdivR]
      have hrem := h.singleton a k ha hbit
      rw [if_neg hk] at hrem
      have hRlower : (120 : ℝ) < (R : ℝ) := by exact_mod_cast hrem.1
      have hRupper : (R : ℝ) < 600 := by exact_mod_cast hrem.2
      rw [hphase]
      apply circleNorm_gt_of_int_band (Q : ℤ)
        ((Q : ℝ) + (R : ℝ) / 720) ((1 : ℝ) / 6)
      · norm_num
      · norm_num
        nlinarith [hRlower]
      · norm_num
        nlinarith [hRupper]
    · obtain ⟨hxlower, hxupper⟩ :
          (C (a.val / 2) : ℝ) / 360 < x ∧
            x < (C (a.val / 2 + 1) : ℝ) / 360 := by
        simpa [CutAtomMem, ha] using hx
      let Q : ℕ := phaseQuotient C a k
      have hinterval := h.interval a k ha hbit
      have hlowerNat : 360 * Q + 60 ≤
          phaseSlope k * C (a.val / 2) + 60 * phaseShift k := by
        simpa [Q] using hinterval.1
      have hupperNat :
          phaseSlope k * C (a.val / 2 + 1) + 60 * phaseShift k ≤
            360 * Q + 300 := by
        simpa [Q] using hinterval.2
      have hlowerReal : (360 : ℝ) * (Q : ℝ) + 60 ≤
          (phaseSlope k : ℝ) * (C (a.val / 2) : ℝ) +
            60 * (phaseShift k : ℝ) := by
        exact_mod_cast hlowerNat
      have hupperReal :
          (phaseSlope k : ℝ) * (C (a.val / 2 + 1) : ℝ) +
            60 * (phaseShift k : ℝ) ≤ (360 : ℝ) * (Q : ℝ) + 300 := by
        exact_mod_cast hupperNat
      have hlowerBand : ((Q : ℤ) : ℝ) + (1 : ℝ) / 6 ≤
          (phaseSlope k : ℝ) * ((C (a.val / 2) : ℝ) / 360) +
            (phaseShift k : ℝ) / 6 := by
        norm_num
        nlinarith [hlowerReal]
      have hupperBand :
          (phaseSlope k : ℝ) * ((C (a.val / 2 + 1) : ℝ) / 360) +
              (phaseShift k : ℝ) / 6 ≤
            ((Q : ℤ) : ℝ) + 1 - (1 : ℝ) / 6 := by
        norm_num
        nlinarith [hupperReal]
      exact circleNorm_gt_of_affine_open_band (Q : ℤ)
        (phaseSlope k : ℝ) ((phaseShift k : ℝ) / 6)
        ((C (a.val / 2) : ℝ) / 360)
        ((C (a.val / 2 + 1) : ℝ) / 360) x ((1 : ℝ) / 6)
        (by exact_mod_cast phaseSlope_pos k) (by norm_num)
        hlowerBand hupperBand hxlower hxupper

end LonelyRunner
