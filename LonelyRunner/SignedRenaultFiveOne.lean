import LonelyRunner.RenaultPhaseLemma

namespace LonelyRunner

private theorem circleNorm_reflect_signed_sixth (y : ℝ) (e : ℤ) (b : ℕ)
    (hb : b ≤ 6) :
    circleNorm (y + ((-e : ℤ) : ℝ) * (b : ℝ) / 6) =
      circleNorm (y + (e : ℝ) * ((6 - b : ℕ) : ℝ) / 6) := by
  have hphase : y + ((-e : ℤ) : ℝ) * (b : ℝ) / 6 =
      ((-e : ℤ) : ℝ) +
        (y + (e : ℝ) * ((6 - b : ℕ) : ℝ) / 6) := by
    rw [Nat.cast_sub hb]
    push_cast
    ring
  rw [hphase, circleNorm_add_int]

theorem renault_phase_five_one_signed (x : Fin 3 → ℝ) (e : Fin 3 → ℤ)
    (he : ∀ j, e j = 1 ∨ e j = -1) :
    (∃ a b : ℕ, 2 ≤ a ∧ a ≤ 5 ∧ 1 ≤ b ∧ b ≤ 5 ∧ ∀ j,
      (1 : ℝ) / 6 ≤ circleNorm ((a : ℝ) * x j + (e j : ℝ) * (b : ℝ) / 6)) ∨
    (∃ b : ℕ, (b = 1 ∨ b = 2 ∨ b = 4) ∧ ∀ j,
      (1 : ℝ) / 6 < circleNorm (x j + (e j : ℝ) * (b : ℝ) / 6)) := by
  rcases renault_phase_five_one (fun j => (e j : ℝ) * x j) with h | h
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
      rw [show ((a : ℝ) * (((-1 : ℤ) : ℝ) * x j) + (b : ℝ) / 6) =
          -((a : ℝ) * x j + ((-1 : ℤ) : ℝ) * (b : ℝ) / 6) by ring,
        circleNorm_neg] at hj
      simpa using hj
  · right
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

theorem renault_phase_five_one_signed_reflected (x : Fin 3 → ℝ) (e : Fin 3 → ℤ)
    (he : ∀ j, e j = 1 ∨ e j = -1) :
    (∃ a b : ℕ, 2 ≤ a ∧ a ≤ 5 ∧ 1 ≤ b ∧ b ≤ 5 ∧ ∀ j,
      (1 : ℝ) / 6 ≤ circleNorm ((a : ℝ) * x j + (e j : ℝ) * (b : ℝ) / 6)) ∨
    (∃ b : ℕ, (b = 2 ∨ b = 4 ∨ b = 5) ∧ ∀ j,
      (1 : ℝ) / 6 < circleNorm (x j + (e j : ℝ) * (b : ℝ) / 6)) := by
  have hneg : ∀ j, -e j = 1 ∨ -e j = -1 := by
    intro j
    rcases he j with h | h <;> simp [h]
  rcases renault_phase_five_one_signed x (fun j => -e j) hneg with h | h
  · left
    rcases h with ⟨a, b, ha0, ha1, hb0, hb1, h⟩
    have hb6 : b ≤ 6 := by omega
    refine ⟨a, 6 - b, ha0, ha1, by omega, by omega, ?_⟩
    intro j
    rw [← circleNorm_reflect_signed_sixth ((a : ℝ) * x j) (e j) b hb6]
    exact h j
  · right
    rcases h with ⟨b, hb, h⟩
    refine ⟨6 - b, ?_, ?_⟩
    · rcases hb with rfl | rfl | rfl
      · exact Or.inr (Or.inr rfl)
      · exact Or.inr (Or.inl rfl)
      · exact Or.inl rfl
    · intro j
      have hb6 : b ≤ 6 := by rcases hb with rfl | rfl | rfl <;> omega
      have hj := h j
      rw [← circleNorm_reflect_signed_sixth (x j) (e j) b hb6]
      exact hj

end LonelyRunner
