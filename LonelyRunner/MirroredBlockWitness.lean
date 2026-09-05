import LonelyRunner.StructuredClasses

/-!
# Explicit witness for a mirrored consecutive block

This is the accepted two-case phase construction for the speeds
`1, ..., m, p-m, ..., p`. It is deliberately pointwise.
-/

namespace LonelyRunner

noncomputable def mirroredBlockTime (m p : ℕ) : ℝ :=
  let N := 2 * m + 2
  let k := p / N
  let r := p % N
  if m + 1 ≤ r then (N : ℝ)⁻¹
  else ((k : ℝ) + (N : ℝ)⁻¹) / ((p - m : ℕ) : ℝ)

private theorem mirrored_phase_cell {m p : ℕ} (hm : 1 ≤ m) (hp : 2 * m + 1 ≤ p)
    (t δ y : ℝ) (k : ℤ)
    (hδ : δ = ((2 * m + 2 : ℕ) : ℝ)⁻¹)
    (htlower : δ ≤ t) (htupper : t ≤ 2 * δ)
    (hphase : (p : ℝ) * t = (k : ℝ) + y)
    (hylower : (m : ℝ) * t + δ ≤ y) (hyupper : y ≤ 1 - δ) :
    δ ≤ circleNorm (t * (p : ℝ)) ∧
      ∀ i : ℕ, 1 ≤ i → i ≤ m →
        δ ≤ circleNorm (t * (i : ℝ)) ∧
          δ ≤ circleNorm (t * ((p - i : ℕ) : ℝ)) := by
  have hNpos : (0 : ℝ) < ((2 * m + 2 : ℕ) : ℝ) := by positivity
  have hNfour : (4 : ℝ) ≤ ((2 * m + 2 : ℕ) : ℝ) := by
    norm_num
    exact_mod_cast (show 4 ≤ 2 * m + 2 by omega)
  have hδpos : 0 < δ := by rw [hδ]; positivity
  have hNδ : ((2 * m + 2 : ℕ) : ℝ) * δ = 1 := by
    rw [hδ]
    field_simp
  have hδhalf : δ ≤ (1 : ℝ) / 2 := by nlinarith
  have hNexpand : ((2 * m + 2 : ℕ) : ℝ) = 2 * (m : ℝ) + 2 := by
    push_cast
    ring
  have hmnonneg : 0 ≤ (m : ℝ) := by positivity
  have htpos : 0 ≤ t := le_trans (le_of_lt hδpos) htlower
  constructor
  · apply circleNorm_ge_of_int_band k (t * (p : ℝ)) δ (le_of_lt hδpos) hδhalf
    · calc
        (k : ℝ) + δ ≤ (k : ℝ) + y := by nlinarith [hylower]
        _ = (p : ℝ) * t := hphase.symm
        _ = t * (p : ℝ) := by ring
    · calc
        t * (p : ℝ) = (p : ℝ) * t := by ring
        _ = (k : ℝ) + y := hphase
        _ ≤ (k : ℝ) + 1 - δ := by linarith
  intro i hi him
  have hiR : (1 : ℝ) ≤ (i : ℝ) := by exact_mod_cast hi
  have himR : (i : ℝ) ≤ (m : ℝ) := by exact_mod_cast him
  have hip : i ≤ p := by omega
  have hsub : ((p - i : ℕ) : ℝ) = (p : ℝ) - (i : ℝ) := by
    rw [Nat.cast_sub hip]
  constructor
  · apply circleNorm_ge_of_int_band 0 (t * (i : ℝ)) δ (le_of_lt hδpos) hδhalf
    · have hmul : δ * (i : ℝ) ≤ t * (i : ℝ) :=
        mul_le_mul_of_nonneg_right htlower (by positivity)
      have hδi : δ ≤ δ * (i : ℝ) := by
        simpa using (mul_le_mul_of_nonneg_left hiR (le_of_lt hδpos))
      norm_num
      exact le_trans hδi hmul
    · have hit : (i : ℝ) * t ≤ (m : ℝ) * (2 * δ) :=
        mul_le_mul himR htupper htpos (by positivity)
      rw [show t * (i : ℝ) = (i : ℝ) * t by ring]
      have hbound : (m : ℝ) * (2 * δ) ≤ 1 - δ := by
        nlinarith [hNδ, hNexpand]
      norm_num
      exact le_trans hit hbound
  · apply circleNorm_ge_of_int_band k (t * ((p - i : ℕ) : ℝ)) δ
      (le_of_lt hδpos) hδhalf
    · calc
        (k : ℝ) + δ ≤ (k : ℝ) + (y - (i : ℝ) * t) := by
          have hit : (i : ℝ) * t ≤ (m : ℝ) * t :=
            mul_le_mul_of_nonneg_right himR htpos
          linarith
        _ = (p : ℝ) * t - (i : ℝ) * t := by rw [hphase]; ring
        _ = t * ((p : ℝ) - (i : ℝ)) := by ring
        _ = t * ((p - i : ℕ) : ℝ) := by rw [hsub]
    · calc
        t * ((p - i : ℕ) : ℝ) = t * ((p : ℝ) - (i : ℝ)) := by rw [hsub]
        _ = (p : ℝ) * t - (i : ℝ) * t := by ring
        _ = (k : ℝ) + (y - (i : ℝ) * t) := by rw [hphase]; ring
        _ ≤ (k : ℝ) + 1 - δ := by
          have hit : 0 ≤ (i : ℝ) * t := mul_nonneg (by positivity) htpos
          linarith

theorem mirroredConsecutiveBlockWitness (m p : ℕ) (hm : 1 ≤ m)
    (hp : 2 * m + 1 ≤ p) :
    ∃ t : ℝ, 0 < t ∧
      (((2 * m + 2 : ℕ) : ℝ)⁻¹) ≤ circleNorm (t * (p : ℝ)) ∧
      ∀ i : ℕ, 1 ≤ i → i ≤ m →
        (((2 * m + 2 : ℕ) : ℝ)⁻¹) ≤ circleNorm (t * (i : ℝ)) ∧
          (((2 * m + 2 : ℕ) : ℝ)⁻¹) ≤ circleNorm (t * ((p - i : ℕ) : ℝ)) := by
  let N : ℕ := 2 * m + 2
  let k : ℕ := p / N
  let r : ℕ := p % N
  let δ : ℝ := (N : ℝ)⁻¹
  have hNpos : 0 < N := by dsimp [N]; omega
  have hNreal : (0 : ℝ) < (N : ℝ) := by exact_mod_cast hNpos
  have hNexpand : (N : ℝ) = 2 * (m : ℝ) + 2 := by
    dsimp [N]
    push_cast
    ring
  have hdecomp : N * k + r = p := by
    dsimp [k, r]
    exact Nat.div_add_mod p N
  have hdecompR : (p : ℝ) = (N : ℝ) * (k : ℝ) + (r : ℝ) := by
    exact_mod_cast hdecomp.symm
  have hrlt : r < N := Nat.mod_lt p hNpos
  have hδ : δ = ((2 * m + 2 : ℕ) : ℝ)⁻¹ := by
    dsimp [δ, N]
  by_cases hfirst : m + 1 ≤ r
  · refine ⟨δ, ?_, ?_⟩
    · rw [hδ]
      positivity
    apply mirrored_phase_cell hm hp δ δ ((r : ℝ) * δ) (k : ℤ) hδ le_rfl ?_ ?_ ?_ ?_
    · have hδpos : 0 < δ := by rw [hδ]; positivity
      nlinarith
    · have hNδ : (N : ℝ) * δ = 1 := by simp [δ]
      calc
        (p : ℝ) * δ = ((N : ℝ) * (k : ℝ) + (r : ℝ)) * δ := by rw [hdecompR]
        _ = (N : ℝ) * δ * (k : ℝ) + (r : ℝ) * δ := by ring
        _ = (k : ℝ) + (r : ℝ) * δ := by rw [hNδ]; ring
    · have hrR : (m : ℝ) + 1 ≤ (r : ℝ) := by exact_mod_cast hfirst
      have hδpos : 0 < δ := by simp [δ]; positivity
      have hNδ : (N : ℝ) * δ = 1 := by simp [δ]
      have hmult := mul_le_mul_of_nonneg_right hrR (le_of_lt hδpos)
      nlinarith [hNδ]
    · have hrR : (r : ℝ) + 1 ≤ (N : ℝ) := by exact_mod_cast (Nat.succ_le_iff.mpr hrlt)
      have hδpos : 0 < δ := by simp [δ]; positivity
      have hNδ : (N : ℝ) * δ = 1 := by simp [δ]
      have hmult := mul_le_mul_of_nonneg_right hrR (le_of_lt hδpos)
      nlinarith [hNδ]
  · have hsecond : r ≤ m := by omega
    let t : ℝ := ((k : ℝ) + δ) / ((p - m : ℕ) : ℝ)
    have hpm : m ≤ p := by omega
    have hqpos : 0 < p - m := by omega
    have hqR : (0 : ℝ) < ((p - m : ℕ) : ℝ) := by exact_mod_cast hqpos
    have hsubR : ((p - m : ℕ) : ℝ) = (p : ℝ) - (m : ℝ) := by
      rw [Nat.cast_sub hpm]
    have hmain : ((p - m : ℕ) : ℝ) * t = (k : ℝ) + δ := by
      dsimp [t]
      field_simp
    have hδpos : 0 < δ := by simp [δ]; positivity
    have hNδ : (N : ℝ) * δ = 1 := by simp [δ]
    have hpδ : (p : ℝ) * δ = (k : ℝ) + (r : ℝ) * δ := by
      calc
        (p : ℝ) * δ = ((N : ℝ) * (k : ℝ) + (r : ℝ)) * δ := by rw [hdecompR]
        _ = (N : ℝ) * δ * (k : ℝ) + (r : ℝ) * δ := by ring
        _ = (k : ℝ) + (r : ℝ) * δ := by rw [hNδ]; ring
    have hqdiff : ((p - m : ℕ) : ℝ) * (t - δ) =
        δ * ((m + 1 - r : ℕ) : ℝ) := by
      rw [mul_sub, hmain, hsubR]
      have hcast : ((m + 1 - r : ℕ) : ℝ) = (m : ℝ) + 1 - (r : ℝ) := by
        rw [Nat.cast_sub (by omega : r ≤ m + 1)]
        push_cast
        rfl
      rw [hcast]
      nlinarith [hpδ]
    have hnumpos : 0 < m + 1 - r := by omega
    have hnumposR : 0 < ((m + 1 - r : ℕ) : ℝ) := by exact_mod_cast hnumpos
    have ht_delta : δ < t := by
      rw [← sub_pos]
      have hpos : 0 < ((p - m : ℕ) : ℝ) * (t - δ) := by
        rw [hqdiff]
        positivity
      rcases (mul_pos_iff.mp hpos) with h | h
      · exact h.2
      · exact False.elim ((not_lt_of_ge (le_of_lt hqR)) h.1)
    have htupper : t ≤ 2 * δ := by
      have hnumle : m + 1 - r ≤ p - m := by omega
      have hnumleR : ((m + 1 - r : ℕ) : ℝ) ≤ ((p - m : ℕ) : ℝ) := by
        exact_mod_cast hnumle
      have hdiffle : t - δ ≤ δ := (mul_le_mul_iff_left₀ hqR).mp (by
        rw [show (t - δ) * ((p - m : ℕ) : ℝ) =
          ((p - m : ℕ) : ℝ) * (t - δ) by ring, hqdiff]
        nlinarith [mul_le_mul_of_nonneg_left hnumleR (le_of_lt hδpos)])
      linarith
    refine ⟨t, lt_trans hδpos ht_delta, ?_⟩
    apply mirrored_phase_cell hm hp t δ (δ + (m : ℝ) * t) (k : ℤ) hδ
      (le_of_lt ht_delta) htupper ?_ ?_ ?_
    · rw [show (p : ℝ) = ((p - m : ℕ) : ℝ) + (m : ℝ) by rw [hsubR]; ring]
      rw [add_mul, hmain]
      push_cast
      ring
    · linarith
    · have hNδ : (N : ℝ) * δ = 1 := by
        dsimp [δ]
        field_simp
      have hmR : 0 ≤ (m : ℝ) := by positivity
      nlinarith [hNexpand]

end LonelyRunner
