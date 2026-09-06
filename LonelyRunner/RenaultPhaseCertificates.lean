import LonelyRunner.FastRunnerInsertion
import Mathlib.Tactic

namespace LonelyRunner

def PhaseGood (k : Fin 23) (x : ℝ) : Prop :=
  if k.val < 20 then
    (1 : ℝ) / 6 ≤ circleNorm
      (((2 + k.val / 5 : ℕ) : ℝ) * x +
        ((1 + k.val % 5 : ℕ) : ℝ) / 6)
  else
    (1 : ℝ) / 6 < circleNorm
      (x + ((if k.val = 20 then 1 else if k.val = 21 then 2 else 4 : ℕ) : ℝ) / 6)

theorem phase_certificate_sound
    (AtomMem : Fin 120 → ℝ → Prop)
    (mask : Fin 120 → Finset (Fin 23))
    (m : ℕ) (core : Fin m → Fin 120) (dom : Fin 120 → Fin m)
    (hpartition : ∀ x : ℝ, 0 ≤ x → x < 1 → ∃ a, AtomMem a x)
    (hsound : ∀ a k, k ∈ mask a → ∀ x, AtomMem a x → PhaseGood k x)
    (hdom : ∀ a, mask (core (dom a)) ⊆ mask a)
    (htriples : ∀ i j k : Fin m, i ≤ j → j ≤ k →
      ∃ c : Fin 23, c ∈ mask (core i) ∧ c ∈ mask (core j) ∧ c ∈ mask (core k)) :
    ∀ x : Fin 3 → ℝ, (∀ j, 0 ≤ x j ∧ x j < 1) →
      ∃ c : Fin 23, ∀ j, PhaseGood c (x j) := by
  intro x hx
  obtain ⟨a0, ha0⟩ := hpartition (x 0) (hx 0).1 (hx 0).2
  obtain ⟨a1, ha1⟩ := hpartition (x 1) (hx 1).1 (hx 1).2
  obtain ⟨a2, ha2⟩ := hpartition (x 2) (hx 2).1 (hx 2).2
  have hmem (a : Fin 120) : mask (core (dom a)) ⊆ mask a := hdom a
  obtain ⟨c, hc0, hc1, hc2⟩ : ∃ c : Fin 23,
      c ∈ mask (core (dom a0)) ∧ c ∈ mask (core (dom a1)) ∧ c ∈ mask (core (dom a2)) := by
    rcases le_total (dom a0) (dom a1) with h01 | h10
    · rcases le_total (dom a1) (dom a2) with h12 | h21
      · exact htriples _ _ _ h01 h12
      · rcases le_total (dom a0) (dom a2) with h02 | h20
        · rcases htriples (dom a0) (dom a2) (dom a1) h02 h21 with ⟨c,h0,h2,h1⟩
          exact ⟨c,h0,h1,h2⟩
        · rcases htriples (dom a2) (dom a0) (dom a1) h20 h01 with ⟨c,h2,h0,h1⟩
          exact ⟨c,h0,h1,h2⟩
    · rcases le_total (dom a0) (dom a2) with h02 | h20
      · rcases htriples (dom a1) (dom a0) (dom a2) h10 h02 with ⟨c,h1,h0,h2⟩
        exact ⟨c,h0,h1,h2⟩
      · rcases le_total (dom a1) (dom a2) with h12 | h21
        · rcases htriples (dom a1) (dom a2) (dom a0) h12 h20 with ⟨c,h1,h2,h0⟩
          exact ⟨c,h0,h1,h2⟩
        · rcases htriples (dom a2) (dom a1) (dom a0) h21 h10 with ⟨c,h2,h1,h0⟩
          exact ⟨c,h0,h1,h2⟩
  refine ⟨c, ?_⟩
  have hg0 := hsound a0 c (hmem a0 hc0) (x 0) ha0
  have hg1 := hsound a1 c (hmem a1 hc1) (x 1) ha1
  have hg2 := hsound a2 c (hmem a2 hc2) (x 2) ha2
  intro j
  fin_cases j
  · exact hg0
  · exact hg1
  · exact hg2

end LonelyRunner
