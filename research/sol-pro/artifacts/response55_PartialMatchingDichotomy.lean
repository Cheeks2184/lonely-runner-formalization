import Mathlib.Combinatorics.Hall.Finite
import Mathlib.Data.Finset.Card
import Mathlib.Tactic

namespace LonelyRunner

open Finset

namespace PartialMatching

variable {L R : Type*} [Fintype L] [Fintype R]
  [DecidableEq L] [DecidableEq R]

noncomputable def choices (adj : L → R → Prop) [DecidableRel adj]
    (x : L) : Finset R :=
  Finset.univ.filter fun y => adj x y

@[simp] theorem mem_choices (adj : L → R → Prop) [DecidableRel adj]
    (x : L) (y : R) :
    y ∈ choices adj x ↔ adj x y := by
  simp [choices]

/-- A partial matching on `P`, when one new left vertex `x` is added, either
extends to all of `insert x P` or there is a nonempty left subset with exact
deficiency one.  The disjunction makes no claim that the two existential
properties are mutually exclusive in the ambient graph. -/
theorem extension_or_deficiency_one
    (adj : L → R → Prop) [DecidableRel adj]
    (P : Finset L) (x : L) (hx : x ∉ P)
    (mate : L → R)
    (hinj : Set.InjOn mate (↑P : Set L))
    (hmatch : ∀ z ∈ P, adj z (mate z)) :
    (∃ f : {z // z ∈ insert x P} → R,
        Function.Injective f ∧ ∀ z, adj z.1 (f z)) ∨
      ∃ T : Finset {z // z ∈ insert x P},
        T.Nonempty ∧
        (T.biUnion fun z => choices adj z.1).card = T.card - 1 := by
  classical
  let I := {z // z ∈ insert x P}
  let family : I → Finset R := fun z => choices adj z.1
  by_cases hext : ∃ f : I → R,
      Function.Injective f ∧ ∀ z, adj z.1 (f z)
  · exact Or.inl hext
  · right
    have hnotHall : ¬ ∀ T : Finset I,
        T.card ≤ (T.biUnion family).card := by
      intro hHall
      rcases (Finset.all_card_le_biUnion_card_iff_existsInjective'
        family).1 hHall with ⟨f, hf, hmem⟩
      apply hext
      refine ⟨f, hf, ?_⟩
      intro z
      simpa [family] using hmem z
    obtain ⟨T, hTnot⟩ := Classical.not_forall.mp hnotHall
    have hlt : (T.biUnion family).card < T.card :=
      Nat.lt_of_not_ge hTnot
    have hTnonempty : T.Nonempty := by
      rw [← Finset.card_pos]
      omega
    let xI : I := ⟨x, Finset.mem_insert_self x P⟩
    let E : Finset I := T.erase xI
    have hpred : T.card - 1 ≤ E.card := by
      simpa [E] using
        (Finset.pred_card_le_card_erase (s := T) (a := xI))
    have hval_mem_P : ∀ z ∈ E, z.1 ∈ P := by
      intro z hzE
      have hzData := Finset.mem_erase.mp hzE
      have hzInsert : z.1 ∈ insert x P := z.2
      rcases Finset.mem_insert.mp hzInsert with hzx | hzP
      · exfalso
        apply hzData.1
        apply Subtype.ext
        simpa [xI] using hzx
      · exact hzP
    have himageCard :
        (E.image fun z => mate z.1).card = E.card := by
      rw [Finset.card_image_iff.mpr]
      intro z hz w hw hzw
      apply Subtype.ext
      exact hinj (hval_mem_P z hz) (hval_mem_P w hw) hzw
    have himageSub :
        E.image (fun z => mate z.1) ⊆ T.biUnion family := by
      intro y hy
      rcases Finset.mem_image.mp hy with ⟨z, hzE, rfl⟩
      have hzData := Finset.mem_erase.mp hzE
      apply Finset.mem_biUnion.mpr
      refine ⟨z, hzData.2, ?_⟩
      simpa [family] using hmatch z.1 (hval_mem_P z hzE)
    have hlower : T.card - 1 ≤ (T.biUnion family).card := by
      calc
        T.card - 1 ≤ E.card := hpred
        _ = (E.image fun z => mate z.1).card := himageCard.symm
        _ ≤ (T.biUnion family).card := Finset.card_le_card himageSub
    refine ⟨T, hTnonempty, ?_⟩
    change (T.biUnion family).card = T.card - 1
    omega

end PartialMatching

end LonelyRunner
