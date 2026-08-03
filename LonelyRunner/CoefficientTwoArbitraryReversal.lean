import LonelyRunner.CoefficientTwoFeasibleStarts
import Mathlib.Tactic

namespace LonelyRunner

open Finset

/-- Reversal total attached to an arbitrary rectangle start. -/
def rectangleReversalTotalAt (N t s : Nat) : Nat :=
  N + s + 2 * rectangleEll t

/-- Reversal attached to an arbitrary rectangle start. -/
def rectangleReversalAt (N t s c : Nat) : Nat :=
  rectangleReversalTotalAt N t s - c

theorem mem_genericInterval_of_inGenericGammaBand
    {N t c : Nat} (hc : inGenericGammaBand N t c) :
    c ∈ Finset.Icc (rectangleGenericLower N t) (rectangleB N t) := by
  have halign := Nat.div_add_mod (3 * (N - t)) 4
  have hamod := Nat.mod_lt (3 * (N - t)) (by norm_num : 0 < 4)
  have hbalign := Nat.div_add_mod (N + t) 2
  have hbmod := Nat.mod_lt (N + t) (by norm_num : 0 < 2)
  dsimp [inGenericGammaBand] at hc
  apply Finset.mem_Icc.mpr
  dsimp [rectangleGenericLower, rectangleB]
  constructor <;> omega

theorem rectangleReversalAt_C0_mem_D1
    {N t s c : Nat} (hc : c ∈ rectangleC0At t s) :
    rectangleReversalAt N t s c ∈ rectangleD1 N t := by
  have h := Finset.mem_Ico.mp hc
  apply Finset.mem_Ico.mpr
  dsimp [rectangleReversalAt, rectangleReversalTotalAt,
    rectangleC0At, rectangleD1] at h ⊢
  omega

theorem rectangleReversalAt_C1_mem_D0
    {N t s c : Nat} (hc : c ∈ rectangleC1At t s) :
    rectangleReversalAt N t s c ∈ rectangleD0 N t := by
  have h := Finset.mem_Ico.mp hc
  apply Finset.mem_Ico.mpr
  dsimp [rectangleReversalAt, rectangleReversalTotalAt,
    rectangleC1At, rectangleD0] at h ⊢
  omega

private theorem le_rectangleReversalTotalAt_of_C0
    {N t s c : Nat} (hc : c ∈ rectangleC0At t s) :
    c ≤ rectangleReversalTotalAt N t s := by
  have h := Finset.mem_Ico.mp hc
  dsimp [rectangleC0At, rectangleReversalTotalAt] at h ⊢
  omega

private theorem le_rectangleReversalTotalAt_of_C1
    {N t s c : Nat} (hc : c ∈ rectangleC1At t s) :
    c ≤ rectangleReversalTotalAt N t s := by
  have h := Finset.mem_Ico.mp hc
  dsimp [rectangleC1At, rectangleReversalTotalAt] at h ⊢
  omega

theorem coprime_rectangleReversalAt
    {N t s c : Nat}
    (hcQ : Nat.Coprime c (rectangleReversalTotalAt N t s))
    (hc : c ∈ rectangleC0At t s ∨ c ∈ rectangleC1At t s) :
    Nat.Coprime c (rectangleReversalAt N t s c) := by
  have hle : c ≤ rectangleReversalTotalAt N t s := by
    rcases hc with hc0 | hc1
    · exact le_rectangleReversalTotalAt_of_C0 hc0
    · exact le_rectangleReversalTotalAt_of_C1 hc1
  exact (Nat.coprime_sub_self_right hle).2 hcQ

/-- An arbitrary feasible start gives a fixed-total reversal SDR whenever
that total is coprime to every actual generic candidate. -/
theorem rectangleReversalAt_isSdr_of_feasible
    {N t s : Nat} (hfeasible : rectangleStartFeasible N t s)
    (A : Finset Nat)
    (hA : ∀ c ∈ A, inGenericGammaBand N t c)
    (hcop : ∀ c ∈ A, Nat.Coprime c (rectangleReversalTotalAt N t s)) :
    Set.InjOn (rectangleReversalAt N t s) (↑A : Set Nat) ∧
      ∀ c ∈ A,
        rectangleReversalAt N t s c ∈ gammaNeighborhood N t c := by
  classical
  rcases hfeasible with ⟨hcover, hD0, hD1, hcross0, hcross1⟩
  constructor
  · intro x hx y hy hxy
    have hxA : x ∈ A := hx
    have hyA : y ∈ A := hy
    have hxcover := hcover (mem_genericInterval_of_inGenericGammaBand (hA x hxA))
    have hycover := hcover (mem_genericInterval_of_inGenericGammaBand (hA y hyA))
    have hxle : x ≤ rectangleReversalTotalAt N t s := by
      rcases Finset.mem_union.mp hxcover with hx0 | hx1
      · exact le_rectangleReversalTotalAt_of_C0 hx0
      · exact le_rectangleReversalTotalAt_of_C1 hx1
    have hyle : y ≤ rectangleReversalTotalAt N t s := by
      rcases Finset.mem_union.mp hycover with hy0 | hy1
      · exact le_rectangleReversalTotalAt_of_C0 hy0
      · exact le_rectangleReversalTotalAt_of_C1 hy1
    dsimp [rectangleReversalAt] at hxy
    omega
  · intro c hcA
    have hcoverC := hcover
      (mem_genericInterval_of_inGenericGammaBand (hA c hcA))
    have hcopRev : Nat.Coprime c (rectangleReversalAt N t s c) :=
      coprime_rectangleReversalAt (hcop c hcA) (Finset.mem_union.mp hcoverC)
    rcases Finset.mem_union.mp hcoverC with hc0 | hc1
    · have hd := rectangleReversalAt_C0_mem_D1 (N := N) hc0
      have hdomain := hD1 hd
      have hband := hcross0 c hc0 (rectangleReversalAt N t s c) hd
      rw [mem_gammaNeighborhood]
      have hdIcc := Finset.mem_Icc.mp hdomain
      simpa using
        (show N < rectangleReversalAt N t s c ∧
            rectangleReversalAt N t s c ≤ N + t ∧
            N + t < c + rectangleReversalAt N t s c ∧
            c + rectangleReversalAt N t s c ≤ 2 * N ∧
            Nat.Coprime c (rectangleReversalAt N t s c) from
          ⟨by omega, hdIcc.2, hband.1, hband.2, hcopRev⟩)
    · have hd := rectangleReversalAt_C1_mem_D0 (N := N) hc1
      have hdomain := hD0 hd
      have hband := hcross1 c hc1 (rectangleReversalAt N t s c) hd
      rw [mem_gammaNeighborhood]
      have hdIcc := Finset.mem_Icc.mp hdomain
      simpa using
        (show N < rectangleReversalAt N t s c ∧
            rectangleReversalAt N t s c ≤ N + t ∧
            N + t < c + rectangleReversalAt N t s c ∧
            c + rectangleReversalAt N t s c ≤ 2 * N ∧
            Nat.Coprime c (rectangleReversalAt N t s c) from
          ⟨by omega, hdIcc.2, hband.1, hband.2, hcopRev⟩)

/-- Interval-form corollary: the exact feasibility inequalities discharge
all rectangle coverage, range, and strict/closed sum-band obligations. -/
theorem rectangleReversalAt_isSdr_of_mem_startInterval
    {N t s : Nat} (ht : 16 ≤ t) (h2t : 2 * t ≤ N)
    (hband : rectangleGenericLower N t ≤ rectangleB N t)
    (hs : rectangleStartLower N t ≤ s ∧ s ≤ rectangleStartUpper N t)
    (A : Finset Nat)
    (hA : ∀ c ∈ A, inGenericGammaBand N t c)
    (hcop : ∀ c ∈ A, Nat.Coprime c (rectangleReversalTotalAt N t s)) :
    Set.InjOn (rectangleReversalAt N t s) (↑A : Set Nat) ∧
      ∀ c ∈ A,
        rectangleReversalAt N t s c ∈ gammaNeighborhood N t c := by
  apply rectangleReversalAt_isSdr_of_feasible
    ((rectangleStartFeasible_iff ht h2t hband).2 hs) A hA hcop

end LonelyRunner

#print axioms LonelyRunner.rectangleReversalAt_isSdr_of_feasible
#print axioms LonelyRunner.rectangleReversalAt_isSdr_of_mem_startInterval
