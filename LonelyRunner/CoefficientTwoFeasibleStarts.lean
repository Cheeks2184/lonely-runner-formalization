import LonelyRunner.CoefficientTwoRectangle
import Mathlib.Tactic

namespace LonelyRunner

open Finset

def rectangleGenericLower (N t : Nat) : Nat :=
  3 * (N - t) / 4 + 1

def rectangleC0At (t s : Nat) : Finset Nat :=
  Finset.Ico s (s + rectangleEll t)

def rectangleC1At (t s : Nat) : Finset Nat :=
  Finset.Ico (s + rectangleEll t) (s + 2 * rectangleEll t)

def rectangleStartLower (N t : Nat) : Nat :=
  max (t - rectangleEll t)
    (rectangleB N t + 1 - 2 * rectangleEll t)

def rectangleStartUpper (N t : Nat) : Nat :=
  min (rectangleGenericLower N t)
    (N + 1 - 3 * rectangleEll t)

/-- Full elementary feasibility predicate for a variable rectangle start. -/
def rectangleStartFeasible (N t s : Nat) : Prop :=
  Finset.Icc (rectangleGenericLower N t) (rectangleB N t) ⊆
      rectangleC0At t s ∪ rectangleC1At t s ∧
  rectangleD0 N t ⊆ Finset.Icc (N + 1) (N + t) ∧
  rectangleD1 N t ⊆ Finset.Icc (N + 1) (N + t) ∧
  (∀ c ∈ rectangleC0At t s, ∀ d ∈ rectangleD1 N t,
      N + t < c + d ∧ c + d ≤ 2 * N) ∧
  (∀ c ∈ rectangleC1At t s, ∀ d ∈ rectangleD0 N t,
      N + t < c + d ∧ c + d ≤ 2 * N)

private theorem variable_rectangle_division_facts (N t : Nat) :
    4 * (t / 4) + t % 4 = t ∧
    t % 4 < 4 ∧
    2 * ((N + t) / 2) + (N + t) % 2 = N + t ∧
    (N + t) % 2 < 2 := by
  constructor
  · simpa [Nat.mul_comm] using Nat.div_add_mod t 4
  constructor
  · exact Nat.mod_lt _ (by norm_num)
  constructor
  · simpa [Nat.mul_comm] using Nat.div_add_mod (N + t) 2
  · exact Nat.mod_lt _ (by norm_num)

private theorem mem_rectangleC0At_union_C1At {t s c : Nat} :
    c ∈ rectangleC0At t s ∪ rectangleC1At t s ↔
      s ≤ c ∧ c < s + 2 * rectangleEll t := by
  simp [rectangleC0At, rectangleC1At]
  omega

/-- Exact feasible-start interval for the active nonempty generic band.
Natural subtractions are guarded by `t >= 16`, `2*t <= N`, and the explicit
nonemptiness hypothesis on the generic integer interval. -/
theorem rectangleStartFeasible_iff
    {N t s : Nat} (ht : 16 ≤ t) (h2t : 2 * t ≤ N)
    (hband : rectangleGenericLower N t ≤ rectangleB N t) :
    rectangleStartFeasible N t s ↔
      rectangleStartLower N t ≤ s ∧
      s ≤ rectangleStartUpper N t := by
  obtain ⟨htdiv, htmod, hbdiv, hbmod⟩ :=
    variable_rectangle_division_facts N t
  have hellPos : 0 < rectangleEll t := by
    dsimp [rectangleEll, rectangleQ]
    omega
  have hellLe : rectangleEll t ≤ t := by
    dsimp [rectangleEll, rectangleQ]
    omega
  have h2ell : 2 * rectangleEll t ≤ t := by
    dsimp [rectangleEll, rectangleQ]
    omega
  have h3ell : 3 * rectangleEll t ≤ N + 1 := by
    dsimp [rectangleEll, rectangleQ]
    omega
  have h2ellB : 2 * rectangleEll t ≤ rectangleB N t + 1 := by
    dsimp [rectangleEll, rectangleQ, rectangleB]
    omega
  constructor
  · rintro ⟨hcover, _hD0, _hD1, hcross0, _hcross1⟩
    have haMem : rectangleGenericLower N t ∈
        Finset.Icc (rectangleGenericLower N t) (rectangleB N t) :=
      Finset.mem_Icc.mpr ⟨le_rfl, hband⟩
    have hbMem : rectangleB N t ∈
        Finset.Icc (rectangleGenericLower N t) (rectangleB N t) :=
      Finset.mem_Icc.mpr ⟨hband, le_rfl⟩
    have haCover := (mem_rectangleC0At_union_C1At).1 (hcover haMem)
    have hbCover := (mem_rectangleC0At_union_C1At).1 (hcover hbMem)
    have hcFirst : s ∈ rectangleC0At t s := by
      apply Finset.mem_Ico.mpr
      constructor
      · exact le_rfl
      · omega
    have hdFirst : N + rectangleEll t + 1 ∈ rectangleD1 N t := by
      apply Finset.mem_Ico.mpr
      omega
    have hlowerBand := (hcross0 s hcFirst
      (N + rectangleEll t + 1) hdFirst).1
    have hcLast : s + rectangleEll t - 1 ∈ rectangleC0At t s := by
      apply Finset.mem_Ico.mpr
      constructor <;> omega
    have hdLast : N + 2 * rectangleEll t ∈ rectangleD1 N t := by
      apply Finset.mem_Ico.mpr
      omega
    have hupperBand := (hcross0 (s + rectangleEll t - 1) hcLast
      (N + 2 * rectangleEll t) hdLast).2
    have hsLower : rectangleStartLower N t ≤ s := by
      dsimp [rectangleStartLower]
      rw [max_le_iff]
      constructor <;> omega
    have hsUpper : s ≤ rectangleStartUpper N t := by
      dsimp [rectangleStartUpper]
      rw [le_min_iff]
      constructor <;> omega
    exact ⟨hsLower, hsUpper⟩
  · rintro ⟨hsLower, hsUpper⟩
    have hsLowOne : t - rectangleEll t ≤ s :=
      (le_max_left _ _).trans hsLower
    have hsLowTwo : rectangleB N t + 1 - 2 * rectangleEll t ≤ s :=
      (le_max_right _ _).trans hsLower
    have hsUpOne : s ≤ rectangleGenericLower N t :=
      hsUpper.trans (min_le_left _ _)
    have hsUpTwo : s ≤ N + 1 - 3 * rectangleEll t :=
      hsUpper.trans (min_le_right _ _)
    have htLower : t ≤ s + rectangleEll t := by omega
    have hbUpper : rectangleB N t < s + 2 * rectangleEll t := by omega
    have hsumUpper : s + 3 * rectangleEll t ≤ N + 1 := by omega
    refine ⟨?_, rectangleD0_subset_extra h2ell,
      rectangleD1_subset_extra h2ell, ?_, ?_⟩
    · intro c hc
      have hcData := Finset.mem_Icc.mp hc
      apply (mem_rectangleC0At_union_C1At).2
      exact ⟨hsUpOne.trans hcData.1, hcData.2.trans_lt hbUpper⟩
    · intro c hc d hd
      have hcData := Finset.mem_Ico.mp hc
      have hdData := Finset.mem_Ico.mp hd
      constructor <;> omega
    · intro c hc d hd
      have hcData := Finset.mem_Ico.mp hc
      have hdData := Finset.mem_Ico.mp hd
      constructor <;> omega

end LonelyRunner
