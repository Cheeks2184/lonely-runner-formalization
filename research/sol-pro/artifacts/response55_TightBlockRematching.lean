import Mathlib.Data.Finset.Card
import Mathlib.Tactic

namespace LonelyRunner

namespace TightBlock

variable {L R : Type*} [Fintype L] [Fintype R]
  [DecidableEq L] [DecidableEq R]

noncomputable def neighbors (adj : L → R → Prop) (S : Finset L) : Finset R := by
  classical
  exact Finset.univ.filter fun y => ∃ x ∈ S, adj x y

@[simp] theorem mem_neighbors (adj : L → R → Prop) (S : Finset L) (y : R) :
    y ∈ neighbors adj S ↔ ∃ x ∈ S, adj x y := by
  classical
  simp [neighbors]

private theorem matching_image_subset_neighbors
    (adj : L → R → Prop) (mate : L → R)
    (hmatch : ∀ x, adj x (mate x)) (S : Finset L) :
    S.image mate ⊆ neighbors adj S := by
  classical
  intro y hy
  rcases Finset.mem_image.mp hy with ⟨x, hx, rfl⟩
  exact (mem_neighbors adj S (mate x)).2 ⟨x, hx, hmatch x⟩

/-- A graph-theoretically tight left block uses its entire neighborhood under
any injective matching saturating the full left type. -/
theorem image_eq_neighbors_of_tight
    (adj : L → R → Prop) (mate : L → R)
    (hinj : Function.Injective mate)
    (hmatch : ∀ x, adj x (mate x))
    (S : Finset L)
    (htight : (neighbors adj S).card = S.card) :
    S.image mate = neighbors adj S := by
  classical
  have hsub := matching_image_subset_neighbors adj mate hmatch S
  have hcardImage : (S.image mate).card = S.card := by
    rw [Finset.card_image_iff.mpr]
    intro x _ y _ hxy
    exact hinj hxy
  apply Finset.eq_of_subset_of_card_le hsub
  rw [htight, hcardImage]

/-- Internal or global rematching cannot dissolve a tight block: under every
injective saturating matching the block is successor-closed and every one of
its neighbors is matched to an owner inside the block. -/
theorem persists_under_saturating_rematching
    (adj : L → R → Prop) (mate : L → R)
    (hinj : Function.Injective mate)
    (hmatch : ∀ x, adj x (mate x))
    (S : Finset L)
    (htight : (neighbors adj S).card = S.card) :
    (∀ ⦃x⦄, x ∈ S → ∀ ⦃z⦄, adj x (mate z) → z ∈ S) ∧
    (∀ ⦃x⦄, x ∈ S → ∀ ⦃y⦄, adj x y →
      ∃ z ∈ S, mate z = y) := by
  classical
  have heq := image_eq_neighbors_of_tight adj mate hinj hmatch S htight
  constructor
  · intro x hx z hxz
    have hzN : mate z ∈ neighbors adj S :=
      (mem_neighbors adj S (mate z)).2 ⟨x, hx, hxz⟩
    have hzI : mate z ∈ S.image mate := by simpa [heq] using hzN
    rcases Finset.mem_image.mp hzI with ⟨z', hz', hmate⟩
    have : z' = z := hinj hmate
    simpa [this] using hz'
  · intro x hx y hxy
    have hyN : y ∈ neighbors adj S :=
      (mem_neighbors adj S y).2 ⟨x, hx, hxy⟩
    have hyI : y ∈ S.image mate := by simpa [heq] using hyN
    rcases Finset.mem_image.mp hyI with ⟨z, hz, hzy⟩
    exact ⟨z, hz, hzy⟩

end TightBlock

end LonelyRunner
