import Mathlib.FieldTheory.Finite.Basic

/-!
# Weighted homogeneous affine avoidance

This module separates the two finite counting stages.  A nonzero direction
avoids the zero forbidden value, then unit scaling avoids the remaining
forbidden weights.  Neither stage needs distinct forms or nonzero slopes.
-/

namespace LonelyRunner

open scoped BigOperators
open Finset

/-- A weighted homogeneous affine avoidance lemma over a prime field.  The
bad-direction hypothesis itself rules out any row with both coefficients zero.
The conclusion deliberately includes the prime-two and empty-index cases. -/
theorem weighted_affine_avoidance
    (p : ℕ) [Fact p.Prime] {I : Type*} [Fintype I]
    (a v : I → ZMod p) (F : I → Finset (ZMod p))
    (_hzero : ∀ i, 0 ∈ F i)
    (hdir : ((Finset.univ : Finset (ZMod p)).filter fun m =>
      m ≠ 0 ∧ ∃ i, v i + m * a i = 0).card ≤ p - 2)
    (hweight : Finset.univ.sum (fun i => ((F i).erase 0).card) ≤ p - 2) :
    ∃ r s : ZMod p, r ≠ 0 ∧ s ≠ 0 ∧
      ∀ i, s * v i + r * a i ∉ F i := by
  classical
  let U : Finset (ZMod p) := Finset.univ.erase 0
  let D : Finset (ZMod p) := {m : ZMod p | m ≠ 0 ∧ ∃ i, v i + m * a i = 0}
  have hp2 : 2 ≤ p := (Fact.out : p.Prime).two_le
  have hU : U.card = p - 1 := by
    simp [U, ZMod.card]
  have hDlt : D.card < U.card := by
    rw [hU]
    exact (hdir.trans_lt (by omega))
  have hm : ∃ m ∈ U, m ∉ D := by
    by_contra h
    push Not at h
    have hsub : U ⊆ D := by
      intro x hx
      exact h x hx
    exact (Nat.not_lt_of_ge (Finset.card_le_card hsub)) hDlt
  obtain ⟨m, hmU, hmD⟩ := hm
  have hm0 : m ≠ 0 := by simpa [U] using hmU
  have hw : ∀ i, v i + m * a i ≠ 0 := by
    intro i hi
    apply hmD
    simp only [D, Finset.mem_filter, Finset.mem_univ, true_and]
    exact ⟨hm0, ⟨i, hi⟩⟩
  let w : I → ZMod p := fun i => v i + m * a i
  let B : I → Finset (ZMod p) := fun i =>
    U.filter fun s => s * w i ∈ (F i).erase 0
  have hBsubset : ∀ i, B i ⊆ U := by
    intro i x hx
    exact (Finset.mem_filter.mp hx).1
  have hBcard : ∀ i, (B i).card ≤ ((F i).erase 0).card := by
    intro i
    refine Finset.card_le_card_of_injOn (fun s : ZMod p => s * w i) ?_ ?_
    · intro s hs
      exact (Finset.mem_filter.mp hs).2
    · intro x hx y hy hxy
      exact (mul_right_cancel₀ (hw i) hxy)
  have hsumB : Finset.univ.sum (fun i => (B i).card) ≤ p - 2 :=
    (Finset.sum_le_sum fun i _ => hBcard i).trans hweight
  have hsumBlt : Finset.univ.sum (fun i => (B i).card) < U.card := by
    rw [hU]
    exact hsumB.trans_lt (by omega)
  let T : Finset (ZMod p) := Finset.univ.biUnion B
  have hTsubset : T ⊆ U := by
    intro x hx
    obtain ⟨i, -, hxi⟩ := Finset.mem_biUnion.mp hx
    exact hBsubset i hxi
  have hTlt : T.card < U.card :=
    Finset.card_biUnion_le.trans_lt hsumBlt
  have hs : ∃ s ∈ U, s ∉ T := by
    by_contra h
    push Not at h
    have hsub : U ⊆ T := by
      intro x hx
      exact h x hx
    exact (Nat.not_lt_of_ge (Finset.card_le_card hsub)) hTlt
  obtain ⟨s, hsU, hsT⟩ := hs
  have hs0 : s ≠ 0 := by simpa [U] using hsU
  refine ⟨s * m, s, mul_ne_zero hs0 hm0, hs0, ?_⟩
  intro i hbad
  have hscaled : s * w i ∈ F i := by
    simpa [w, mul_add, mul_assoc, mul_left_comm, mul_comm] using hbad
  have hnonzero : s * w i ≠ 0 := mul_ne_zero hs0 (hw i)
  have herase : s * w i ∈ (F i).erase 0 := Finset.mem_erase.mpr ⟨hnonzero, hscaled⟩
  apply hsT
  exact Finset.mem_biUnion.mpr ⟨i, Finset.mem_univ i,
    Finset.mem_filter.mpr ⟨hsU, herase⟩⟩

/-- The coefficient-swapped, author-oriented presentation of
`weighted_affine_avoidance`.  This has direction equation `a + m*v = 0`, while
retaining the output convention `s*v + r*a`. -/
theorem weighted_affine_avoidance_author
    (p : ℕ) [Fact p.Prime] {I : Type*} [Fintype I]
    (a v : I → ZMod p) (F : I → Finset (ZMod p))
    (hzero : ∀ i, 0 ∈ F i)
    (hdir : ((Finset.univ : Finset (ZMod p)).filter fun m =>
      m ≠ 0 ∧ ∃ i, a i + m * v i = 0).card ≤ p - 2)
    (hweight : Finset.univ.sum (fun i => ((F i).erase 0).card) ≤ p - 2) :
    ∃ r s : ZMod p, r ≠ 0 ∧ s ≠ 0 ∧
      ∀ i, s * v i + r * a i ∉ F i := by
  obtain ⟨r, s, hr, hs, havoid⟩ :=
    weighted_affine_avoidance p v a F hzero hdir hweight
  refine ⟨s, r, hs, hr, ?_⟩
  intro i hi
  apply havoid i
  simpa [add_comm] using hi

end LonelyRunner
