import LonelyRunner.CoefficientTwoRectangle
import Mathlib.Tactic

namespace LonelyRunner

/-- Conditional two-translation map for the active coefficient-two band. -/
def gammaTwoTranslation (N t c : Nat) : Nat :=
  if c ≤ t then N + c else N - t + c

/-- The conditional two-translation class gives a Gamma SDR. The theorem
assumes the branchwise gcd conditions and explicitly excludes the only
possible cross-branch collision; it makes no claim that these hypotheses hold
uniformly. -/
theorem gammaTwoTranslation_isSdr
    {N t : Nat} (_hN : 4 ≤ N) (_ht : 0 < t)
    (h2t : 2 * t ≤ N) (hactive : N < 3 * t)
    (A : Finset Nat)
    (hpos : ∀ c ∈ A, 0 < c)
    (hgeneric : ∀ c ∈ A, inGenericGammaBand N t c)
    (hcopLow : ∀ c ∈ A, c ≤ t → Nat.Coprime c N)
    (hcopHigh : ∀ c ∈ A, t < c → Nat.Coprime c (N - t))
    (hcross : ∀ c₀ ∈ A, c₀ ≤ t →
      ∀ c₁ ∈ A, t < c₁ → c₁ ≠ c₀ + t) :
    Set.InjOn (gammaTwoTranslation N t) (↑A : Set Nat) ∧
      ∀ c ∈ A, gammaTwoTranslation N t c ∈ gammaNeighborhood N t c := by
  constructor
  · intro x hx y hy hxy
    have hxA : x ∈ A := hx
    have hyA : y ∈ A := hy
    by_cases hxlow : x ≤ t
    · by_cases hylow : y ≤ t
      · simp [gammaTwoTranslation, hxlow, hylow] at hxy
        omega
      · have hyhigh : t < y := Nat.lt_of_not_ge hylow
        have hne := hcross x hxA hxlow y hyA hyhigh
        simp [gammaTwoTranslation, hxlow, hylow] at hxy
        have htN : t ≤ N := by omega
        apply (hne (by omega)).elim
    · have hxhigh : t < x := Nat.lt_of_not_ge hxlow
      by_cases hylow : y ≤ t
      · have hne := hcross y hyA hylow x hxA hxhigh
        simp [gammaTwoTranslation, hxlow, hylow] at hxy
        have htN : t ≤ N := by omega
        apply (hne (by omega)).elim
      · simp [gammaTwoTranslation, hxlow, hylow] at hxy
        omega
  · intro c hcA
    have hcpos := hpos c hcA
    have hcgen := hgeneric c hcA
    dsimp [inGenericGammaBand] at hcgen
    by_cases hclow : c ≤ t
    · have hcop : Nat.Coprime c (N + c) :=
        (Nat.coprime_add_self_right).2 (hcopLow c hcA hclow)
      rw [mem_gammaNeighborhood]
      simp only [gammaTwoTranslation, if_pos hclow]
      constructor
      · omega
      constructor
      · omega
      constructor
      · omega
      constructor
      · omega
      · exact hcop
    · have hchigh : t < c := Nat.lt_of_not_ge hclow
      have hcop : Nat.Coprime c (N - t + c) :=
        (Nat.coprime_add_self_right).2 (hcopHigh c hcA hchigh)
      rw [mem_gammaNeighborhood]
      simp only [gammaTwoTranslation, if_neg hclow]
      constructor
      · omega
      constructor
      · omega
      constructor
      · omega
      constructor
      · omega
      · exact hcop

end LonelyRunner

#print axioms LonelyRunner.gammaTwoTranslation_isSdr
