import Mathlib.Tactic

namespace LonelyRunner

/-- A natural multiple of three has signed sixth residue zero or three; the
chosen residue records exactly whether it is divisible by six. -/
theorem exists_three_residue_mod_six (d : ℕ) (h3 : 3 ∣ d) :
    ∃ z ε : ℤ, (d : ℤ) = 6 * z + 3 * ε ∧
      (ε = 0 ∨ ε = 1) ∧ (6 ∣ d ↔ ε = 0) := by
  by_cases h6 : 6 ∣ d
  · obtain ⟨k, hk⟩ := h6
    refine ⟨k, 0, ?_, Or.inl rfl, ?_⟩
    · rw [hk]
      norm_num
    · constructor
      · intro _; rfl
      · intro _; exact ⟨k, hk⟩
  · obtain ⟨k, hk⟩ := h3
    have hkodd : k % 2 ≠ 0 := by
      intro hzero
      apply h6
      refine ⟨k / 2, ?_⟩
      omega
    have hkmod : k % 2 = 1 := by
      have hlt : k % 2 < 2 := Nat.mod_lt _ (by omega)
      omega
    refine ⟨((k / 2 : ℕ) : ℤ), 1, ?_, Or.inr rfl, ?_⟩
    · have hdNat : d = 6 * (k / 2) + 3 := by omega
      exact_mod_cast hdNat
    · constructor
      · intro hd
        exact (h6 hd).elim
      · intro he
        norm_num at he

end LonelyRunner
