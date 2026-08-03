import Mathlib.Data.Finset.Card
import Mathlib.Tactic

namespace LonelyRunner

open Finset

variable {L R : Type*} [DecidableEq L]

/-- Every co-singleton of a nontrivial critical deficiency-one left set is
tight. The neighborhood operator is abstract; only monotonicity is used. -/
theorem criticalCore_coSingleton_tight
    (nbr : Finset L → Finset R) (A : Finset L)
    (hdef : (nbr A).card + 1 = A.card)
    (hmono : ∀ ⦃X⦄, X ⊆ A → nbr X ⊆ nbr A)
    (hhall : ∀ ⦃X⦄, X ⊂ A → X.Nonempty → X.card ≤ (nbr X).card)
    (htwo : 2 ≤ A.card) :
    ∀ ⦃a⦄, a ∈ A → (nbr (A.erase a)).card = (A.erase a).card := by
  intro a ha
  have hproper : A.erase a ⊂ A := Finset.erase_ssubset ha
  have hcard : (A.erase a).card = A.card - 1 := Finset.card_erase_of_mem ha
  have hnonempty : (A.erase a).Nonempty := Finset.card_pos.mp (by omega)
  have hlo : (A.erase a).card ≤ (nbr (A.erase a)).card :=
    hhall hproper hnonempty
  have hsub : nbr (A.erase a) ⊆ nbr A := hmono hproper.subset
  have hhi : (nbr (A.erase a)).card ≤ (nbr A).card :=
    Finset.card_le_card hsub
  omega

/-- A critical deficiency-one set with no nonempty proper tight subset has
exactly one left vertex. Thus unrestricted tight-block contraction has no
nontrivial "atomic critical core" endpoint. -/
theorem atomicCriticalCore_card_eq_one
    (nbr : Finset L → Finset R) (A : Finset L)
    (hA : A.Nonempty)
    (hdef : (nbr A).card + 1 = A.card)
    (hmono : ∀ ⦃X⦄, X ⊆ A → nbr X ⊆ nbr A)
    (hhall : ∀ ⦃X⦄, X ⊂ A → X.Nonempty → X.card ≤ (nbr X).card)
    (hatomic : ∀ ⦃X⦄, X ⊂ A → X.Nonempty → (nbr X).card ≠ X.card) :
    A.card = 1 := by
  by_contra hne
  have htwo : 2 ≤ A.card := by
    have hpos : 0 < A.card := Finset.card_pos.mpr hA
    omega
  obtain ⟨a, ha⟩ := hA
  have htight := criticalCore_coSingleton_tight nbr A hdef hmono hhall htwo ha
  have hproper : A.erase a ⊂ A := Finset.erase_ssubset ha
  have hnonempty : (A.erase a).Nonempty := Finset.card_pos.mp (by
    rw [Finset.card_erase_of_mem ha]
    omega)
  exact hatomic hproper hnonempty htight

end LonelyRunner

#print axioms LonelyRunner.criticalCore_coSingleton_tight
#print axioms LonelyRunner.atomicCriticalCore_card_eq_one
