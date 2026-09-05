import LonelyRunner.StructuredClasses

/-!
# Phase bands for two endpoint clusters

The first lemma isolates the real closed-band argument used by the later
uniform arithmetic witness. It intentionally has no finite-set layer.
-/

namespace LonelyRunner

/-- A phase cell for lows through M and highs P - i supplies the closed
circle-distance bound for every listed coordinate. -/
theorem twoClusterPhaseBand {M P : ℕ} (hMP : M ≤ P)
    (t δ y : ℝ) (k : ℤ)
    (hδ0 : 0 ≤ δ) (hδhalf : δ ≤ (1 : ℝ) / 2)
    (ht : δ ≤ t)
    (hphase : (P : ℝ) * t = (k : ℝ) + y)
    (hlo : (M : ℝ) * t + δ ≤ y) (hhi : y ≤ 1 - δ) :
    δ ≤ circleNorm (t * (P : ℝ)) ∧
      ∀ i : ℕ, 1 ≤ i → i ≤ M →
        δ ≤ circleNorm (t * (i : ℝ)) ∧
          δ ≤ circleNorm (t * ((P - i : ℕ) : ℝ)) := by
  have ht0 : 0 ≤ t := le_trans hδ0 ht
  have hM0 : 0 ≤ (M : ℝ) := by positivity
  have hMt0 : 0 ≤ (M : ℝ) * t := mul_nonneg hM0 ht0
  have hyδ : δ ≤ y := by linarith
  constructor
  · apply circleNorm_ge_of_int_band k (t * (P : ℝ)) δ hδ0 hδhalf
    · calc
        (k : ℝ) + δ ≤ (k : ℝ) + y := by linarith
        _ = (P : ℝ) * t := hphase.symm
        _ = t * (P : ℝ) := by ring
    · calc
        t * (P : ℝ) = (P : ℝ) * t := by ring
        _ = (k : ℝ) + y := hphase
        _ ≤ (k : ℝ) + 1 - δ := by linarith
  intro i hi hiM
  have hiR : (1 : ℝ) ≤ (i : ℝ) := by exact_mod_cast hi
  have hiMR : (i : ℝ) ≤ (M : ℝ) := by exact_mod_cast hiM
  have hiP : i ≤ P := le_trans hiM hMP
  have hsub : ((P - i : ℕ) : ℝ) = (P : ℝ) - (i : ℝ) := by
    rw [Nat.cast_sub hiP]
  have hit0 : 0 ≤ (i : ℝ) * t := mul_nonneg (by positivity) ht0
  constructor
  · apply circleNorm_ge_of_int_band 0 (t * (i : ℝ)) δ hδ0 hδhalf
    · have hδi : δ ≤ δ * (i : ℝ) := by
        simpa using (mul_le_mul_of_nonneg_left hiR hδ0)
      have hmul : δ * (i : ℝ) ≤ t * (i : ℝ) :=
        mul_le_mul_of_nonneg_right ht (by positivity)
      norm_num
      exact le_trans hδi hmul
    · have hit : (i : ℝ) * t ≤ (M : ℝ) * t :=
        mul_le_mul_of_nonneg_right hiMR ht0
      rw [show t * (i : ℝ) = (i : ℝ) * t by ring]
      norm_num
      linarith
  · apply circleNorm_ge_of_int_band k (t * ((P - i : ℕ) : ℝ)) δ hδ0 hδhalf
    · calc
        (k : ℝ) + δ ≤ (k : ℝ) + (y - (i : ℝ) * t) := by
          have hit : (i : ℝ) * t ≤ (M : ℝ) * t :=
            mul_le_mul_of_nonneg_right hiMR ht0
          linarith
        _ = (P : ℝ) * t - (i : ℝ) * t := by rw [hphase]; ring
        _ = t * ((P : ℝ) - (i : ℝ)) := by ring
        _ = t * ((P - i : ℕ) : ℝ) := by rw [hsub]
    · calc
        t * ((P - i : ℕ) : ℝ) = t * ((P : ℝ) - (i : ℝ)) := by rw [hsub]
        _ = (P : ℝ) * t - (i : ℝ) * t := by ring
        _ = (k : ℝ) + (y - (i : ℝ) * t) := by rw [hphase]; ring
        _ ≤ (k : ℝ) + 1 - δ := by linarith

/-- A real interval supply for the two-cluster phase cell. The arithmetic
inputs are deliberately scaled real inequalities; quotient/remainder facts
are supplied later by a separate natural-number wrapper. -/
theorem twoClusterPhaseSupply {M P : ℕ} (hMP : M < P)
    (δ : ℝ) (k : ℤ) (hδpos : 0 < δ) (hδhalf : δ ≤ (1 : ℝ) / 2)
    (hbase : (P : ℝ) * δ ≤ (k : ℝ) + 1 - δ)
    (hcross : (M : ℝ) * (k : ℝ) ≤
      (P : ℝ) * (1 - 2 * δ) - (M : ℝ) * (1 - δ)) :
    ∃ t : ℝ, 0 < t ∧
      δ ≤ circleNorm (t * (P : ℝ)) ∧
      ∀ i : ℕ, 1 ≤ i → i ≤ M →
        δ ≤ circleNorm (t * (i : ℝ)) ∧
          δ ≤ circleNorm (t * ((P - i : ℕ) : ℝ)) := by
  have hPpos : (0 : ℝ) < (P : ℝ) := by
    exact_mod_cast (show 0 < P by omega)
  have hPMpos : (0 : ℝ) < (P : ℝ) - (M : ℝ) := by
    have h : (M : ℝ) < (P : ℝ) := by exact_mod_cast hMP
    linarith
  let A : ℝ := ((k : ℝ) + δ) / ((P : ℝ) - (M : ℝ))
  let B : ℝ := ((k : ℝ) + 1 - δ) / (P : ℝ)
  let t : ℝ := max δ A
  have hδB : δ ≤ B := by
    dsimp [B]
    apply (le_div_iff₀ hPpos).mpr
    nlinarith [hbase]
  have hAB : A ≤ B := by
    dsimp [A, B]
    apply (div_le_div_iff₀ hPMpos hPpos).mpr
    nlinarith [hcross]
  have htB : t ≤ B := max_le hδB hAB
  have hAt : A ≤ t := le_max_right _ _
  have htδ : δ ≤ t := le_max_left _ _
  have htpos : 0 < t := lt_of_lt_of_le hδpos htδ
  have hupper : (P : ℝ) * t ≤ (k : ℝ) + 1 - δ := by
    have := mul_le_mul_of_nonneg_left htB (le_of_lt hPpos)
    dsimp [B] at this
    field_simp [hPpos.ne'] at this
    nlinarith
  have hlower : (k : ℝ) + δ ≤ ((P : ℝ) - (M : ℝ)) * t := by
    have := (div_le_iff₀ hPMpos).mp hAt
    nlinarith
  let y : ℝ := (P : ℝ) * t - (k : ℝ)
  have hphase : (P : ℝ) * t = (k : ℝ) + y := by
    dsimp [y]
    ring
  have hylo : (M : ℝ) * t + δ ≤ y := by
    dsimp [y]
    nlinarith [hlower]
  have hyhi : y ≤ 1 - δ := by
    dsimp [y]
    linarith
  obtain ⟨hP, hcoords⟩ := twoClusterPhaseBand (le_of_lt hMP) t δ y k
    (le_of_lt hδpos) hδhalf htδ hphase hylo hyhi
  exact ⟨t, htpos, hP, hcoords⟩

/-- The reviewed residue-independent arithmetic condition supplies a phase
cell at denominator N for endpoint width M. -/
theorem twoClusterPhaseCellWitness (N M P : ℕ) (hN : 4 ≤ N) (hM : 1 ≤ M)
    (hMN : M < N - 2) (hP : M + 1 ≤ P)
    (hg : M * (N - 1) ≤ P * (N - 2 - M)) :
    ∃ t : ℝ, 0 < t ∧
      ((N : ℝ)⁻¹) ≤ circleNorm (t * (P : ℝ)) ∧
      ∀ i : ℕ, 1 ≤ i → i ≤ M →
        ((N : ℝ)⁻¹) ≤ circleNorm (t * (i : ℝ)) ∧
          ((N : ℝ)⁻¹) ≤ circleNorm (t * ((P - i : ℕ) : ℝ)) := by
  let q : ℕ := P / N
  let r : ℕ := P % N
  let δ : ℝ := (N : ℝ)⁻¹
  have hNpos : 0 < N := by omega
  have hNR : (0 : ℝ) < (N : ℝ) := by exact_mod_cast hNpos
  have hδpos : 0 < δ := by exact inv_pos.mpr hNR
  have hNδ : (N : ℝ) * δ = 1 := by simp [δ, hNR.ne']
  have hdiv : N * q + r = P := by
    dsimp [q, r]
    exact Nat.div_add_mod P N
  have hdivR : (P : ℝ) = (N : ℝ) * (q : ℝ) + (r : ℝ) := by
    exact_mod_cast hdiv.symm
  have hrlt : r < N := Nat.mod_lt P hNpos
  have hPδ : (P : ℝ) * δ = (q : ℝ) + (r : ℝ) * δ := by
    calc
      (P : ℝ) * δ = ((N : ℝ) * (q : ℝ) + (r : ℝ)) * δ := by rw [hdivR]
      _ = (N : ℝ) * δ * (q : ℝ) + (r : ℝ) * δ := by ring
      _ = (q : ℝ) + (r : ℝ) * δ := by rw [hNδ]; ring
  have hδhalf : δ ≤ (1 : ℝ) / 2 := by
    have hNRfour : (4 : ℝ) ≤ (N : ℝ) := by exact_mod_cast hN
    nlinarith [hNδ]
  have hrδ : (r : ℝ) * δ ≤ 1 - δ := by
    have hrN : r + 1 ≤ N := Nat.succ_le_iff.mpr hrlt
    have hrNR : (r : ℝ) + 1 ≤ (N : ℝ) := by exact_mod_cast hrN
    have hmul := mul_le_mul_of_nonneg_right hrNR (le_of_lt hδpos)
    nlinarith [hNδ]
  have hbase : (P : ℝ) * δ ≤ (q : ℤ) + 1 - δ := by
    push_cast
    nlinarith [hPδ, hrδ]
  have hgR : (M : ℝ) * ((N : ℝ) - 1) ≤
      (P : ℝ) * ((N : ℝ) - 2 - (M : ℝ)) := by
    have hcast : (M : ℝ) * ((N - 1 : ℕ) : ℝ) ≤
        (P : ℝ) * ((N - 2 - M : ℕ) : ℝ) := by exact_mod_cast hg
    have hN1 : ((N - 1 : ℕ) : ℝ) = (N : ℝ) - 1 := by
      rw [Nat.cast_sub (by omega : 1 ≤ N)]
      norm_num
    have hN2M : ((N - 2 - M : ℕ) : ℝ) = (N : ℝ) - 2 - (M : ℝ) := by
      rw [Nat.cast_sub (by omega : M ≤ N - 2), Nat.cast_sub (by omega : 2 ≤ N)]
      norm_num
    rw [hN1, hN2M] at hcast
    exact hcast
  have hbudget : (M : ℝ) * (1 - δ) ≤
      (P : ℝ) * (1 - 2 * δ - (M : ℝ) * δ) := by
    have hmul := mul_le_mul_of_nonneg_right hgR (le_of_lt hδpos)
    nlinarith [hNδ]
  have hrδ0 : 0 ≤ (r : ℝ) * δ := mul_nonneg (by positivity) (le_of_lt hδpos)
  have hqle : (q : ℝ) ≤ (P : ℝ) * δ := by nlinarith [hPδ]
  have hM0 : 0 ≤ (M : ℝ) := by positivity
  have hMq : (M : ℝ) * (q : ℝ) ≤ (M : ℝ) * (P : ℝ) * δ := by
    have := mul_le_mul_of_nonneg_left hqle hM0
    nlinarith
  have hcross : (M : ℝ) * (q : ℤ) ≤
      (P : ℝ) * (1 - 2 * δ) - (M : ℝ) * (1 - δ) := by
    push_cast
    nlinarith [hbudget, hMq]
  obtain ⟨t, ht, htop, hcoords⟩ :=
    twoClusterPhaseSupply (show M < P by omega) δ (q : ℤ) hδpos hδhalf hbase hcross
  exact ⟨t, ht, htop, hcoords⟩

end LonelyRunner
