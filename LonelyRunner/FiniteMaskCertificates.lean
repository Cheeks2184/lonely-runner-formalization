import Mathlib.Data.Nat.Bitwise
import Mathlib.Data.Finset.Card
import Mathlib.Tactic

namespace LonelyRunner

/-- Candidate positions are exactly the set bits of a bounded natural mask. -/
def maskCandidates (B n : Nat) : Finset (Fin B) :=
  Finset.univ.filter fun k => n.testBit k.val = true

theorem mem_maskCandidates {B n : Nat} {k : Fin B} :
    k ∈ maskCandidates B n ↔ n.testBit k.val = true := by
  simp [maskCandidates]

/-- A nonzero triple intersection has a bit below the bound forced by the
first mask's strict size bound. -/
theorem exists_common_mask_bit (B a b c : Nat) (ha : a < 2 ^ B)
    (h : (a &&& b &&& c) ≠ 0) :
    ∃ k : Fin B, a.testBit k.val = true ∧ b.testBit k.val = true ∧
      c.testBit k.val = true := by
  classical
  have hexists : ∃ k : Nat, (a &&& b &&& c).testBit k = true := by
    by_contra hnone
    apply h
    apply Nat.zero_of_testBit_eq_false
    intro k
    cases hk : (a &&& b &&& c).testBit k
    · rfl
    · exact False.elim (hnone ⟨k, hk⟩)
  obtain ⟨k, hk⟩ := hexists
  have hkbits : a.testBit k = true ∧ b.testBit k = true ∧ c.testBit k = true := by
    simpa only [Nat.testBit_land, Bool.and_eq_true, and_assoc] using hk
  have hkB : k < B := by
    by_contra hBk
    have hpow : 2 ^ B ≤ 2 ^ k := Nat.pow_le_pow_right (by omega) (by omega)
    have halt : a < 2 ^ k := lt_of_lt_of_le ha hpow
    have hfalse : a.testBit k = false := Nat.testBit_eq_false_of_lt halt
    exact Bool.noConfusion (hfalse.symm.trans hkbits.1)
  exact ⟨⟨k, hkB⟩, hkbits⟩

theorem exists_common_mask_candidate (B a b c : Nat) (ha : a < 2 ^ B)
    (h : (a &&& b &&& c) ≠ 0) :
    ∃ k : Fin B, k ∈ maskCandidates B a ∧ k ∈ maskCandidates B b ∧
      k ∈ maskCandidates B c := by
  obtain ⟨k, ha, hb, hc⟩ := exists_common_mask_bit B a b c ha h
  exact ⟨k, mem_maskCandidates.mpr ha, mem_maskCandidates.mpr hb,
    mem_maskCandidates.mpr hc⟩

end LonelyRunner
