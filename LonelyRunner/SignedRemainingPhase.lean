import LonelyRunner.RemainingPhaseLemma

namespace LonelyRunner

private theorem circleNorm_reflect_signed_weighted_sixth (y : ℝ) (e w : ℤ)
    (b : ℕ) (hb : b ≤ 6) :
    circleNorm (y + ((-e : ℤ) : ℝ) * (w : ℝ) * (b : ℝ) / 6) =
      circleNorm (y + (e : ℝ) * (w : ℝ) * ((6 - b : ℕ) : ℝ) / 6) := by
  have hphase : y + ((-e : ℤ) : ℝ) * (w : ℝ) * (b : ℝ) / 6 =
      ((-(e * w) : ℤ) : ℝ) +
        (y + (e : ℝ) * (w : ℝ) * ((6 - b : ℕ) : ℝ) / 6) := by
    rw [Nat.cast_sub hb]
    push_cast
    ring
  rw [hphase, circleNorm_add_int]

theorem renault_phase_six_one_signed (x : Fin 3 → ℝ) (e : Fin 3 → ℤ)
    (he : ∀ j, e j = 1 ∨ e j = -1) :
    (∃ a b : ℕ, 2 ≤ a ∧ a ≤ 5 ∧ 1 ≤ b ∧ b ≤ 5 ∧
      ∀ j, (1 : ℝ) / 6 ≤ circleNorm
        ((a : ℝ) * x j + (e j : ℝ) *
          (if j = 0 then (2 : ℝ) else 1) * (b : ℝ) / 6)) ∨
    (∃ b : ℕ, 1 ≤ b ∧ b ≤ 4 ∧
      ∀ j, (1 : ℝ) / 6 < circleNorm
        (x j + (e j : ℝ) *
          (if j = 0 then (2 : ℝ) else 1) * (b : ℝ) / 6)) := by
  rcases renault_phase_six_one (fun j => (e j : ℝ) * x j) with h | h
  · left
    rcases h with ⟨a, b, ha0, ha1, hb0, hb1, h⟩
    refine ⟨a, b, ha0, ha1, hb0, hb1, ?_⟩
    intro j
    rcases he j with hsign | hsign
    · have hj := h j
      rw [hsign] at hj ⊢
      simpa using hj
    · have hj := h j
      rw [hsign] at hj ⊢
      rw [show ((a : ℝ) * (((-1 : ℤ) : ℝ) * x j) +
          (if j = 0 then (2 : ℝ) else 1) * (b : ℝ) / 6) =
          -((a : ℝ) * x j + ((-1 : ℤ) : ℝ) *
            (if j = 0 then (2 : ℝ) else 1) * (b : ℝ) / 6) by ring,
        circleNorm_neg] at hj
      simpa using hj
  · right
    rcases h with ⟨b, hb0, hb1, h⟩
    refine ⟨b, hb0, hb1, ?_⟩
    intro j
    rcases he j with hsign | hsign
    · have hj := h j
      rw [hsign] at hj ⊢
      simpa using hj
    · have hj := h j
      rw [hsign] at hj ⊢
      rw [show (((-1 : ℤ) : ℝ) * x j +
          (if j = 0 then (2 : ℝ) else 1) * (b : ℝ) / 6) =
          -(x j + ((-1 : ℤ) : ℝ) *
            (if j = 0 then (2 : ℝ) else 1) * (b : ℝ) / 6) by ring,
        circleNorm_neg] at hj
      simpa using hj

theorem renault_phase_six_one_signed_reflected (x : Fin 3 → ℝ) (e : Fin 3 → ℤ)
    (he : ∀ j, e j = 1 ∨ e j = -1) :
    (∃ a b : ℕ, 2 ≤ a ∧ a ≤ 5 ∧ 1 ≤ b ∧ b ≤ 5 ∧
      ∀ j, (1 : ℝ) / 6 ≤ circleNorm
        ((a : ℝ) * x j + (e j : ℝ) *
          (if j = 0 then (2 : ℝ) else 1) * (b : ℝ) / 6)) ∨
    (∃ b : ℕ, 2 ≤ b ∧ b ≤ 5 ∧
      ∀ j, (1 : ℝ) / 6 < circleNorm
        (x j + (e j : ℝ) *
          (if j = 0 then (2 : ℝ) else 1) * (b : ℝ) / 6)) := by
  have hneg : ∀ j, -e j = 1 ∨ -e j = -1 := by
    intro j
    rcases he j with h | h <;> simp [h]
  rcases renault_phase_six_one_signed x (fun j => -e j) hneg with h | h
  · left
    rcases h with ⟨a, b, ha0, ha1, hb0, hb1, h⟩
    have hb6 : b ≤ 6 := by omega
    refine ⟨a, 6 - b, ha0, ha1, by omega, by omega, ?_⟩
    intro j
    rw [show circleNorm ((a : ℝ) * x j + (e j : ℝ) *
        (if j = 0 then (2 : ℝ) else 1) * ((6 - b : ℕ) : ℝ) / 6) =
        circleNorm ((a : ℝ) * x j + ((-e j : ℤ) : ℝ) *
          (if j = 0 then (2 : ℝ) else 1) * (b : ℝ) / 6) by
        simpa [Int.cast_neg, mul_assoc] using
          (circleNorm_reflect_signed_weighted_sixth ((a : ℝ) * x j) (e j)
            (if j = 0 then 2 else 1) b hb6).symm]
    simpa [mul_assoc] using h j
  · right
    rcases h with ⟨b, hb0, hb1, h⟩
    refine ⟨6 - b, by omega, by omega, ?_⟩
    intro j
    have hb6 : b ≤ 6 := by omega
    rw [show circleNorm (x j + (e j : ℝ) *
        (if j = 0 then (2 : ℝ) else 1) * ((6 - b : ℕ) : ℝ) / 6) =
        circleNorm (x j + ((-e j : ℤ) : ℝ) *
          (if j = 0 then (2 : ℝ) else 1) * (b : ℝ) / 6) by
        simpa [Int.cast_neg, mul_assoc] using
          (circleNorm_reflect_signed_weighted_sixth (x j) (e j)
            (if j = 0 then 2 else 1) b hb6).symm]
    simpa [mul_assoc] using h j

theorem renault_phase_six_four_signed (x : Fin 3 → ℝ) (e : Fin 3 → ℤ)
    (he : ∀ j, e j = 1 ∨ e j = -1)
    (hx : ∀ j, (1 : ℝ) / 6 ≤ circleNorm (x j)) :
    (∀ j, (1 : ℝ) / 6 < circleNorm (2 * x j)) ∨
    (∃ b : ℕ, (b = 1 ∨ b = 5) ∧
      ∀ j, (1 : ℝ) / 6 < circleNorm (x j + (e j : ℝ) * (b : ℝ) / 6)) ∨
    (∃ a b : ℕ, (a = 3 ∨ a = 5) ∧ b ≤ 5 ∧
      ∀ j, (1 : ℝ) / 6 ≤ circleNorm
        ((a : ℝ) * x j + (e j : ℝ) * (b : ℝ) / 6)) := by
  have hsafety : ∀ j, (1 : ℝ) / 6 ≤ circleNorm ((e j : ℝ) * x j) := by
    intro j
    rcases he j with hsign | hsign
    · rw [hsign]
      simpa using hx j
    · rw [hsign, show ((-1 : ℤ) : ℝ) * x j = -(x j) by ring, circleNorm_neg]
      exact hx j
  rcases renault_phase_six_four (fun j => (e j : ℝ) * x j) hsafety with h | h | h
  · left
    intro j
    rcases he j with hsign | hsign
    · have hj := h j
      rw [hsign] at hj
      simpa using hj
    · have hj := h j
      rw [hsign,
        show 2 * (((-1 : ℤ) : ℝ) * x j) = -(2 * x j) by ring,
        circleNorm_neg] at hj
      simpa using hj
  · right
    left
    rcases h with ⟨b, hb, h⟩
    refine ⟨b, hb, ?_⟩
    intro j
    rcases he j with hsign | hsign
    · have hj := h j
      rw [hsign] at hj ⊢
      simpa using hj
    · have hj := h j
      rw [hsign] at hj ⊢
      rw [show (((-1 : ℤ) : ℝ) * x j + (b : ℝ) / 6) =
          -(x j + ((-1 : ℤ) : ℝ) * (b : ℝ) / 6) by ring,
        circleNorm_neg] at hj
      simpa using hj
  · right
    right
    rcases h with ⟨a, b, ha, hb, h⟩
    refine ⟨a, b, ha, hb, ?_⟩
    intro j
    rcases he j with hsign | hsign
    · have hj := h j
      rw [hsign] at hj ⊢
      simpa using hj
    · have hj := h j
      rw [hsign] at hj ⊢
      rw [show ((a : ℝ) * (((-1 : ℤ) : ℝ) * x j) + (b : ℝ) / 6) =
          -((a : ℝ) * x j + ((-1 : ℤ) : ℝ) * (b : ℝ) / 6) by ring,
        circleNorm_neg] at hj
      simpa using hj

end LonelyRunner
