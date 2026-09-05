import LonelyRunner.ModularCertificates
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Tactic

/-!
# Zero-kernel family cover certificates

This module contains only the finite, labelled-family part of the
zero-kernel obstruction.  Arithmetic facts about particular pivot bad sets are
inputs: keeping them external makes the certificate reusable without assuming
that labels represent distinct speeds.
-/

namespace LonelyRunner

open scoped BigOperators

/-- Removing two distinct points common to every member of a nonempty labelled
family saves two points for every label after the first. -/
private theorem card_biUnion_le_sum_card_sub_two_common {α ι : Type*}
    [DecidableEq α] (C : Finset ι) (T : ι → Finset α) (x y : α)
    (hxy : x ≠ y) (hcommon : ∀ i ∈ C, x ∈ T i ∧ y ∈ T i) :
    (C.biUnion T).card + 2 * (C.card - 1) ≤ C.sum (fun i => (T i).card) := by
  classical
  induction C using Finset.induction_on with
  | empty => simp
  | @insert i C hi ih =>
      by_cases hC : C = ∅
      · subst C
        simp
      · have hcardC : 0 < C.card := Finset.card_pos.mpr (Finset.nonempty_iff_ne_empty.mpr hC)
        rcases Finset.nonempty_iff_ne_empty.mpr hC with ⟨j, hj⟩
        have hcommonC : ∀ j ∈ C, x ∈ T j ∧ y ∈ T j := by
          intro j hj
          exact hcommon j (by simp [hj])
        have hih := ih hcommonC
        have hinter : ({x, y} : Finset α) ⊆ T i ∩ C.biUnion T := by
          intro a ha
          simp only [Finset.mem_inter]
          rcases Finset.mem_insert.mp ha with hax | hay
          · subst a
            exact ⟨(hcommon i (by simp)).1,
              Finset.mem_biUnion.mpr ⟨j, hj, (hcommon j (by simp [hj])).1⟩⟩
          · have hay' : a = y := Finset.mem_singleton.mp hay
            subst a
            exact ⟨(hcommon i (by simp)).2,
              Finset.mem_biUnion.mpr ⟨j, hj, (hcommon j (by simp [hj])).2⟩⟩
        have hinterCard : 2 ≤ (T i ∩ C.biUnion T).card := by
          have := Finset.card_le_card hinter
          simpa [hxy] using this
        have hunion : (T i ∪ C.biUnion T).card + 2 ≤
            (T i).card + (C.biUnion T).card := by
          have hcardUnion := Finset.card_union_add_card_inter (T i) (C.biUnion T)
          omega
        rw [Finset.biUnion_insert, Finset.sum_insert hi]
        rw [Finset.card_insert_of_notMem hi]
        omega

/-- A labelled finite family with dominated zero kernels cannot cover its
candidate set under the reviewed numerical condition.  No injectivity of the
labels is assumed. -/
theorem exists_candidate_avoiding_kernel_family_two_or_more
    {α ι : Type*} [DecidableEq α] [DecidableEq ι]
    (N A : ℕ) (R : Finset α) (C E : Finset ι)
    (B Z : ι → Finset α)
    (hN : 3 ≤ N) (hA : A = R.card) (hRpos : 0 < R.card)
    (hCcard : 2 ≤ C.card) (hEsub : E ⊆ C)
    (hBsub : ∀ i ∈ C, B i ⊆ R)
    (hZsub : ∀ i ∈ C, Z i ⊆ B i)
    (hscalar : ∀ i ∈ C,
      N * (B i).card ≤ 2 * A + (N - 2) * (Z i).card)
    (hcapacity : ∀ i ∈ C, (N + 1) * (Z i).card ≤ A)
    (hdom : ∀ i ∈ C, (Z i).Nonempty → ∃ j ∈ E, Z i ⊆ Z j)
    (x y : α) (hxy : x ≠ y)
    (hcommon : ∀ i ∈ C, x ∈ B i \ Z i ∧ y ∈ B i \ Z i)
    (hnum : 2 * (N + 1) * C.card + (N - 2) * E.card ≤ N * (N + 1)) :
    ∃ r ∈ R, ∀ i ∈ C, r ∉ B i := by
  classical
  let T : ι → Finset α := fun i => B i \ Z i
  have hN2 : 2 ≤ N := by omega
  have hTbound : ∀ i ∈ C, N * (T i).card + 2 * (Z i).card ≤ 2 * A := by
    intro i hi
    have hcard : (T i).card + (Z i).card = (B i).card := by
      calc
        (T i).card + (Z i).card = (B i ∪ Z i).card := by
          dsimp [T]
          exact Finset.card_sdiff_add_card (B i) (Z i)
        _ = (B i).card := by rw [Finset.union_eq_left.2 (hZsub i hi)]
    have hs := hscalar i hi
    have hid : (N - 2) * (Z i).card + 2 * (Z i).card = N * (Z i).card := by
      rw [← Nat.add_mul, Nat.sub_add_cancel hN2]
    rw [← hcard, Nat.mul_add, ← hid] at hs
    have hs' : (N * (T i).card + 2 * (Z i).card) + (N - 2) * (Z i).card ≤
        2 * A + (N - 2) * (Z i).card := by
      simpa [Nat.add_assoc, Nat.add_left_comm, Nat.add_comm] using hs
    exact Nat.le_of_add_le_add_right hs'
  have hsum : N * C.sum (fun i => (T i).card) +
      2 * C.sum (fun i => (Z i).card) ≤ 2 * C.card * A := by
    have h := Finset.sum_le_sum (fun i hi => hTbound i hi)
    simpa [Finset.mul_sum, Finset.sum_add_distrib, Nat.mul_assoc,
      Nat.mul_left_comm, Nat.mul_comm] using h
  have hTcommon : ∀ i ∈ C, x ∈ T i ∧ y ∈ T i := by
    intro i hi
    simpa [T] using hcommon i hi
  have hTunion := card_biUnion_le_sum_card_sub_two_common C T x y hxy hTcommon
  have hZunion : (C.biUnion Z).card ≤ E.sum (fun i => (Z i).card) := by
    apply le_trans (Finset.card_le_card ?_) (card_biUnion_le_sum_card E Z)
    intro a ha
    rcases Finset.mem_biUnion.mp ha with ⟨i, hi, hai⟩
    rcases hdom i hi ⟨a, hai⟩ with ⟨j, hj, hij⟩
    exact Finset.mem_biUnion.mpr ⟨j, hj, hij hai⟩
  have hEsum : E.sum (fun i => (Z i).card) ≤ C.sum (fun i => (Z i).card) :=
    Finset.sum_le_sum_of_subset hEsub
  have hcapacitySum : (N + 1) * E.sum (fun i => (Z i).card) ≤ E.card * A := by
    have h := Finset.sum_le_sum (fun i hi => hcapacity i (hEsub hi))
    simpa [Finset.mul_sum, Finset.sum_const_nat, Nat.mul_assoc,
      Nat.mul_left_comm, Nat.mul_comm] using h
  have hBunionSub : C.biUnion B ⊆ C.biUnion T ∪ C.biUnion Z := by
    intro a ha
    rcases Finset.mem_biUnion.mp ha with ⟨i, hi, hai⟩
    by_cases hzi : a ∈ Z i
    · exact Finset.mem_union_right _ (Finset.mem_biUnion.mpr ⟨i, hi, hzi⟩)
    · exact Finset.mem_union_left _
        (Finset.mem_biUnion.mpr ⟨i, hi, Finset.mem_sdiff.mpr ⟨hai, hzi⟩⟩)
  have hBunion : (C.biUnion B).card ≤ (C.biUnion T).card + (C.biUnion Z).card :=
    (Finset.card_le_card hBunionSub).trans (Finset.card_union_le _ _)
  have hfirst : N * (C.biUnion B).card + 2 * N * (C.card - 1) ≤
      N * C.sum (fun i => (T i).card) + N * E.sum (fun i => (Z i).card) := by
    have hleft := Nat.mul_le_mul_left N hBunion
    have hmiddle := Nat.mul_le_mul_left N hTunion
    have hright := Nat.mul_le_mul_left N hZunion
    simp only [Nat.mul_add, Nat.mul_assoc, Nat.mul_left_comm, Nat.mul_comm] at hleft hmiddle hright ⊢
    omega
  have hsecond : N * C.sum (fun i => (T i).card) +
      N * E.sum (fun i => (Z i).card) ≤
        2 * C.card * A + (N - 2) * E.sum (fun i => (Z i).card) := by
    have htwo : 2 * E.sum (fun i => (Z i).card) ≤
        2 * C.sum (fun i => (Z i).card) := Nat.mul_le_mul_left 2 hEsum
    have hbase : N * C.sum (fun i => (T i).card) +
        2 * E.sum (fun i => (Z i).card) ≤ 2 * C.card * A := by
      exact (Nat.add_le_add_left htwo _).trans hsum
    have hid : (N - 2) * E.sum (fun i => (Z i).card) +
        2 * E.sum (fun i => (Z i).card) =
          N * E.sum (fun i => (Z i).card) := by
      rw [← Nat.add_mul, Nat.sub_add_cancel hN2]
    have hbase' : (N * C.sum (fun i => (T i).card) +
        2 * E.sum (fun i => (Z i).card)) +
          (N - 2) * E.sum (fun i => (Z i).card) ≤
        2 * C.card * A + (N - 2) * E.sum (fun i => (Z i).card) :=
      Nat.add_le_add_right hbase _
    calc
      N * C.sum (fun i => (T i).card) + N * E.sum (fun i => (Z i).card) =
          (N * C.sum (fun i => (T i).card) + 2 * E.sum (fun i => (Z i).card)) +
            (N - 2) * E.sum (fun i => (Z i).card) := by
              rw [← hid]
              ac_rfl
      _ ≤ 2 * C.card * A + (N - 2) * E.sum (fun i => (Z i).card) := hbase'
  have hfamily : N * (C.biUnion B).card + 2 * N * (C.card - 1) ≤
      2 * C.card * A + (N - 2) * E.sum (fun i => (Z i).card) :=
    hfirst.trans hsecond
  have hscaled := Nat.mul_le_mul_left (N + 1) hfamily
  have hcoverBound : (N + 1) *
      (2 * C.card * A + (N - 2) * E.sum (fun i => (Z i).card)) ≤
        N * (N + 1) * A := by
    nlinarith
  have hstrict : (C.biUnion B).card < R.card := by
    have hchain := hscaled.trans hcoverBound
    have hfactorPos : 0 < N + 1 := by omega
    have hreduced : N * (C.biUnion B).card + 2 * N * (C.card - 1) ≤ N * A := by
      apply Nat.le_of_mul_le_mul_left (c := N + 1) _ hfactorPos
      simpa [Nat.mul_assoc, Nat.mul_left_comm, Nat.mul_comm] using hchain
    have hpredPos : 0 < C.card - 1 := Nat.sub_pos_of_lt (by omega)
    have hcorrectionPos : 0 < 2 * N * (C.card - 1) := by
      exact Nat.mul_pos (Nat.mul_pos (by omega) (by omega)) hpredPos
    have hmul : N * (C.biUnion B).card < N * A := by omega
    have hunion : (C.biUnion B).card < A :=
      Nat.lt_of_mul_lt_mul_left hmul
    simpa [hA] using hunion
  have hUnionSub : C.biUnion B ⊆ R := by
    intro r hr
    rcases Finset.mem_biUnion.mp hr with ⟨i, hi, hri⟩
    exact hBsub i hi hri
  have havoid : ∃ r ∈ R, r ∉ C.biUnion B := by
    by_contra h
    have hsub : R ⊆ C.biUnion B := by
      intro r hr
      by_contra hnot
      exact h ⟨r, hr, hnot⟩
    exact (Nat.not_lt_of_ge (Finset.card_le_card hsub)) hstrict
  rcases havoid with ⟨r, hr, hrbad⟩
  refine ⟨r, hr, ?_⟩
  intro i hi hri
  exact hrbad (Finset.mem_biUnion.mpr ⟨i, hi, hri⟩)

/-- The same certificate with the empty and singleton label cases discharged
separately.  The two-point overlap is only used when there are at least two
labels; keeping one uniform interface is convenient for residue adapters. -/
theorem exists_candidate_avoiding_kernel_family
    {α ι : Type*} [DecidableEq α] [DecidableEq ι]
    (N A : ℕ) (R : Finset α) (C E : Finset ι)
    (B Z : ι → Finset α)
    (hN : 3 ≤ N) (hA : A = R.card) (hRpos : 0 < R.card)
    (hEsub : E ⊆ C)
    (hBsub : ∀ i ∈ C, B i ⊆ R)
    (hZsub : ∀ i ∈ C, Z i ⊆ B i)
    (hscalar : ∀ i ∈ C,
      N * (B i).card ≤ 2 * A + (N - 2) * (Z i).card)
    (hcapacity : ∀ i ∈ C, (N + 1) * (Z i).card ≤ A)
    (hdom : ∀ i ∈ C, (Z i).Nonempty → ∃ j ∈ E, Z i ⊆ Z j)
    (x y : α) (hxy : x ≠ y)
    (hcommon : ∀ i ∈ C, x ∈ B i \ Z i ∧ y ∈ B i \ Z i)
    (hnum : 2 * (N + 1) * C.card + (N - 2) * E.card ≤ N * (N + 1)) :
    ∃ r ∈ R, ∀ i ∈ C, r ∉ B i := by
  classical
  by_cases htwo : 2 ≤ C.card
  · exact exists_candidate_avoiding_kernel_family_two_or_more N A R C E B Z
      hN hA hRpos htwo hEsub hBsub hZsub hscalar hcapacity hdom x y hxy hcommon hnum
  have hCsmall : C.card ≤ 1 := by omega
  by_cases hCempty : C = ∅
  · subst C
    rcases Finset.card_pos.mp hRpos with ⟨r, hr⟩
    exact ⟨r, hr, by simp⟩
  have hCpos : 0 < C.card := Finset.card_pos.mpr (Finset.nonempty_iff_ne_empty.mpr hCempty)
  have hCone : C.card = 1 := by omega
  rcases Finset.card_eq_one.mp hCone with ⟨i, hi⟩
  subst C
  have hApos : 0 < A := by simpa [hA] using hRpos
  have hsingle := hscalar i (by simp)
  have hcap := hcapacity i (by simp)
  have hN2 : 2 ≤ N := by omega
  have hsingleBound : (N + 1) * (B i).card ≤ 3 * A := by
    have hsingleScaled := Nat.mul_le_mul_left (N + 1) hsingle
    have hcapScaled := Nat.mul_le_mul_left (N - 2) hcap
    have hbig : (N + 1) * (N * (B i).card) ≤ 3 * N * A := by
      calc
        (N + 1) * (N * (B i).card) ≤
            (N + 1) * (2 * A + (N - 2) * (Z i).card) := hsingleScaled
        _ = 2 * A * (N + 1) + (N - 2) * ((N + 1) * (Z i).card) := by ring
        _ ≤ 2 * A * (N + 1) + (N - 2) * A :=
          Nat.add_le_add_left hcapScaled _
        _ = 3 * N * A := by
          have hid : 2 * (N + 1) + (N - 2) = 3 * N := by omega
          calc
            2 * A * (N + 1) + (N - 2) * A =
                (2 * (N + 1) + (N - 2)) * A := by ring
            _ = 3 * N * A := by rw [hid]
    apply Nat.le_of_mul_le_mul_left (c := N) _ (by omega)
    simpa [Nat.mul_assoc, Nat.mul_left_comm, Nat.mul_comm] using hbig
  have hBlt : (B i).card < R.card := by
    rw [← hA]
    nlinarith
  have hexists : ∃ r ∈ R, r ∉ B i := by
    by_contra h
    have hcover : R ⊆ B i := by
      intro r hr
      by_contra hrB
      exact h ⟨r, hr, hrB⟩
    exact (Nat.not_lt_of_ge (Finset.card_le_card hcover)) hBlt
  rcases hexists with ⟨r, hr, hrB⟩
  exact ⟨r, hr, by simpa using hrB⟩

end LonelyRunner
