import LonelyRunner.CoefficientTwoRectangle
import Mathlib.Tactic

namespace LonelyRunner

open Finset

def rectangleReversalTotal (N t : Nat) : Nat :=
  N + rectangleA0 N t + 2 * rectangleEll t

def rectangleReversal (N t c : Nat) : Nat :=
  rectangleReversalTotal N t - c

theorem rectangleReversal_C0_mem_D1
    {N t c : Nat} (hc : c ∈ rectangleC0 N t) :
    rectangleReversal N t c ∈ rectangleD1 N t := by
  have h := Finset.mem_Ico.mp hc
  apply Finset.mem_Ico.mpr
  dsimp [rectangleReversal, rectangleReversalTotal,
    rectangleC0, rectangleD1] at h ⊢
  omega

theorem rectangleReversal_C1_mem_D0
    {N t c : Nat} (hc : c ∈ rectangleC1 N t) :
    rectangleReversal N t c ∈ rectangleD0 N t := by
  have h := Finset.mem_Ico.mp hc
  apply Finset.mem_Ico.mpr
  dsimp [rectangleReversal, rectangleReversalTotal,
    rectangleC1, rectangleD0] at h ⊢
  omega

private theorem le_rectangleReversalTotal_of_C0
    {N t c : Nat} (hc : c ∈ rectangleC0 N t) :
    c ≤ rectangleReversalTotal N t := by
  have h := Finset.mem_Ico.mp hc
  dsimp [rectangleC0, rectangleReversalTotal] at h ⊢
  omega

private theorem le_rectangleReversalTotal_of_C1
    {N t c : Nat} (hc : c ∈ rectangleC1 N t) :
    c ≤ rectangleReversalTotal N t := by
  have h := Finset.mem_Ico.mp hc
  dsimp [rectangleC1, rectangleReversalTotal] at h ⊢
  omega

theorem coprime_rectangleReversal
    {N t c : Nat} (hcQ : Nat.Coprime c (rectangleReversalTotal N t))
    (hc : c ∈ rectangleC0 N t ∨ c ∈ rectangleC1 N t) :
    Nat.Coprime c (rectangleReversal N t c) := by
  have hle : c ≤ rectangleReversalTotal N t := by
    rcases hc with hc0 | hc1
    · exact le_rectangleReversalTotal_of_C0 hc0
    · exact le_rectangleReversalTotal_of_C1 hc1
  exact (Nat.coprime_sub_self_right hle).2 hcQ

private theorem rectangleReversal_injective_C0
    {N t : Nat} :
    ∀ {x y}, x ∈ rectangleC0 N t → y ∈ rectangleC0 N t →
      rectangleReversal N t x = rectangleReversal N t y → x = y := by
  intro x y hx hy hxy
  have hxle := le_rectangleReversalTotal_of_C0 hx
  have hyle := le_rectangleReversalTotal_of_C0 hy
  dsimp [rectangleReversal] at hxy
  omega

private theorem rectangleReversal_injective_C1
    {N t : Nat} :
    ∀ {x y}, x ∈ rectangleC1 N t → y ∈ rectangleC1 N t →
      rectangleReversal N t x = rectangleReversal N t y → x = y := by
  intro x y hx hy hxy
  have hxle := le_rectangleReversalTotal_of_C1 hx
  have hyle := le_rectangleReversalTotal_of_C1 hy
  dsimp [rectangleReversal] at hxy
  omega

/-- Response 53's fixed-total reversal criterion, built on the compiled
coefficient-two rectangle core.  Coprimality is required only for the actual
candidate set `A`, not for every point of the ambient rectangles. -/
theorem rectangleReversal_gives_sdr
    {N t : Nat} (ht : 16 ≤ t) (h2t : 2 * t ≤ N)
    (A : Finset Nat)
    (hA : ∀ c ∈ A, inGenericGammaBand N t c)
    (hcop : ∀ c ∈ A,
      Nat.Coprime c (rectangleReversalTotal N t)) :
    ∃ f : Nat → Nat,
      Set.InjOn f (↑A : Set Nat) ∧
      ∀ c ∈ A, f c ∈ gammaNeighborhood N t c := by
  classical
  let f : Nat → Nat := rectangleReversal N t
  refine ⟨f, ?_, ?_⟩
  · intro x hx y hy hxy
    have hxA : x ∈ A := hx
    have hyA : y ∈ A := hy
    have hxcover :=
      mem_rectangleC0_union_C1_of_generic ht h2t (hA x hxA)
    have hycover :=
      mem_rectangleC0_union_C1_of_generic ht h2t (hA y hyA)
    have hxle : x ≤ rectangleReversalTotal N t := by
      rcases Finset.mem_union.mp hxcover with hx0 | hx1
      · exact le_rectangleReversalTotal_of_C0 hx0
      · exact le_rectangleReversalTotal_of_C1 hx1
    have hyle : y ≤ rectangleReversalTotal N t := by
      rcases Finset.mem_union.mp hycover with hy0 | hy1
      · exact le_rectangleReversalTotal_of_C0 hy0
      · exact le_rectangleReversalTotal_of_C1 hy1
    dsimp [f, rectangleReversal] at hxy
    omega
  · intro c hcA
    have hcover :=
      mem_rectangleC0_union_C1_of_generic ht h2t (hA c hcA)
    have h2ell : 2 * rectangleEll t ≤ t := by
      have hdiv := Nat.div_add_mod t 4
      have hmod := Nat.mod_lt t (by norm_num : 0 < 4)
      dsimp [rectangleEll, rectangleQ]
      omega
    have hcopRev :
        Nat.Coprime c (rectangleReversal N t c) :=
      coprime_rectangleReversal (hcop c hcA) (Finset.mem_union.mp hcover)
    rcases Finset.mem_union.mp hcover with hc0 | hc1
    · have hd := rectangleReversal_C0_mem_D1 hc0
      have hdomain := rectangleD1_subset_extra h2ell hd
      have hband := rectangleC0_D1_band ht h2t hc0 hd
      rw [mem_gammaNeighborhood]
      have hdIcc := Finset.mem_Icc.mp hdomain
      simpa [f] using
        (show N < rectangleReversal N t c ∧
            rectangleReversal N t c ≤ N + t ∧
            N + t < c + rectangleReversal N t c ∧
            c + rectangleReversal N t c ≤ 2 * N ∧
            Nat.Coprime c (rectangleReversal N t c) from
          ⟨by omega, hdIcc.2, hband.1, hband.2, hcopRev⟩)
    · have hd := rectangleReversal_C1_mem_D0 hc1
      have hdomain := rectangleD0_subset_extra h2ell hd
      have hband := rectangleC1_D0_band ht h2t hc1 hd
      rw [mem_gammaNeighborhood]
      have hdIcc := Finset.mem_Icc.mp hdomain
      simpa [f] using
        (show N < rectangleReversal N t c ∧
            rectangleReversal N t c ≤ N + t ∧
            N + t < c + rectangleReversal N t c ∧
            c + rectangleReversal N t c ≤ 2 * N ∧
            Nat.Coprime c (rectangleReversal N t c) from
          ⟨by omega, hdIcc.2, hband.1, hband.2, hcopRev⟩)

end LonelyRunner
