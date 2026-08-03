import Mathlib.Data.Finset.Card
import Mathlib.Data.Finset.Image
import Mathlib.Logic.Relation

namespace LonelyRunner

open Finset

section Matching

variable {L R : Type*} [Fintype L] [DecidableEq L]
  [Fintype R] [DecidableEq R]

/-- The right neighborhood of a finite left subset. -/
def neighborhood (adj : L → R → Prop) [DecidableRel adj]
    (A : Finset L) : Finset R :=
  Finset.univ.filter fun r => ∃ x ∈ A, adj x r

/-- The matching image of a finite left subset. -/
def matchingImage (matching : L → R) (A : Finset L) : Finset R :=
  A.image matching

/-- `x → y` when `x` sees the right vertex matched to `y`. -/
def dependency (adj : L → R → Prop) (matching : L → R) (x y : L) : Prop :=
  adj x (matching y)

/-- A left vertex is bad when it sees a globally unmatched right vertex. -/
def badVertex (adj : L → R → Prop) [DecidableRel adj]
    (matching : L → R) (x : L) : Prop :=
  ∃ r, adj x r ∧ r ∉ (Finset.univ.image matching : Finset R)

def SuccessorClosed (adj : L → R → Prop) (matching : L → R)
    (A : Finset L) : Prop :=
  ∀ x, x ∈ A → ∀ y, dependency adj matching x y → y ∈ A

def AvoidsBad (adj : L → R → Prop) [DecidableRel adj]
    (matching : L → R) (A : Finset L) : Prop :=
  ∀ x, x ∈ A → ¬ badVertex adj matching x

omit [Fintype L] [DecidableEq L] in
theorem matchingImage_subset_neighborhood
    (adj : L → R → Prop) [DecidableRel adj] (matching : L → R)
    (hmatch : ∀ x, adj x (matching x)) (A : Finset L) :
    matchingImage matching A ⊆ neighborhood adj A := by
  intro r hr
  obtain ⟨x, hx, rfl⟩ := Finset.mem_image.mp hr
  simp only [neighborhood, Finset.mem_filter, Finset.mem_univ, true_and]
  exact ⟨x, hx, hmatch x⟩

omit [Fintype L] [DecidableEq L] [Fintype R] in
theorem card_matchingImage (matching : L → R) (hinj : Function.Injective matching)
    (A : Finset L) :
    (matchingImage matching A).card = A.card := by
  exact Finset.card_image_iff.mpr hinj.injOn

omit [DecidableEq L] in
/-- Exact fixed-matching characterization of tight Hall subsets. -/
theorem tight_iff_successorClosed_and_avoidsBad
    (adj : L → R → Prop) [DecidableRel adj] (matching : L → R)
    (hinj : Function.Injective matching) (hmatch : ∀ x, adj x (matching x))
    (A : Finset L) :
    (neighborhood adj A).card = A.card ↔
      SuccessorClosed adj matching A ∧ AvoidsBad adj matching A := by
  have himageSubset := matchingImage_subset_neighborhood adj matching hmatch A
  have himageCard := card_matchingImage matching hinj A
  constructor
  · intro htight
    have hEq : matchingImage matching A = neighborhood adj A := by
      apply Finset.eq_of_subset_of_card_le himageSubset
      rw [himageCard, htight]
    constructor
    · intro x hx y hxy
      have hneighbor : matching y ∈ neighborhood adj A := by
        simp only [neighborhood, Finset.mem_filter, Finset.mem_univ, true_and]
        exact ⟨x, hx, hxy⟩
      have himage : matching y ∈ matchingImage matching A := by
        rw [hEq]
        exact hneighbor
      obtain ⟨z, hz, hzy⟩ := Finset.mem_image.mp himage
      have hzy' : z = y := hinj hzy
      simpa [hzy'] using hz
    · intro x hx hbad
      obtain ⟨r, hxr, hunmatched⟩ := hbad
      have hneighbor : r ∈ neighborhood adj A := by
        simp only [neighborhood, Finset.mem_filter, Finset.mem_univ, true_and]
        exact ⟨x, hx, hxr⟩
      have himage : r ∈ matchingImage matching A := by
        rw [hEq]
        exact hneighbor
      obtain ⟨y, hy, hyr⟩ := Finset.mem_image.mp himage
      apply hunmatched
      exact Finset.mem_image.mpr ⟨y, Finset.mem_univ _, hyr⟩
  · rintro ⟨hclosed, havoids⟩
    have hneighborSubset : neighborhood adj A ⊆ matchingImage matching A := by
      intro r hr
      simp only [neighborhood, Finset.mem_filter, Finset.mem_univ, true_and] at hr
      obtain ⟨x, hx, hxr⟩ := hr
      by_cases hglobal : r ∈ (Finset.univ.image matching : Finset R)
      · obtain ⟨y, _, hyr⟩ := Finset.mem_image.mp hglobal
        have hy : y ∈ A :=
          hclosed x hx y (by simpa [dependency, hyr] using hxr)
        exact Finset.mem_image.mpr ⟨y, hy, hyr⟩
      · exact (havoids x hx ⟨r, hxr, hglobal⟩).elim
    have hEq : neighborhood adj A = matchingImage matching A :=
      Finset.Subset.antisymm hneighborSubset himageSubset
    rw [hEq, himageCard]

noncomputable def reachableSet (adj : L → R → Prop) [DecidableRel adj]
    (matching : L → R) (x : L) : Finset L := by
  classical
  exact Finset.univ.filter fun y =>
    Relation.ReflTransGen (dependency adj matching) x y

omit [DecidableEq L] [Fintype R] [DecidableEq R] in
theorem mem_reachableSet_iff
    (adj : L → R → Prop) [DecidableRel adj]
    (matching : L → R) (x y : L) :
    y ∈ reachableSet adj matching x ↔
      Relation.ReflTransGen (dependency adj matching) x y := by
  classical
  simp [reachableSet]

omit [DecidableEq L] [Fintype R] [DecidableEq R] in
theorem reachableSet_nonempty
    (adj : L → R → Prop) [DecidableRel adj]
    (matching : L → R) (x : L) :
    (reachableSet adj matching x).Nonempty := by
  refine ⟨x, (mem_reachableSet_iff adj matching x x).mpr ?_⟩
  exact Relation.ReflTransGen.refl

omit [DecidableEq L] [Fintype R] [DecidableEq R] in
theorem reachableSet_successorClosed
    (adj : L → R → Prop) [DecidableRel adj]
    (matching : L → R) (x : L) :
    SuccessorClosed adj matching (reachableSet adj matching x) := by
  intro y hy z hyz
  rw [mem_reachableSet_iff] at hy ⊢
  exact hy.tail hyz

omit [Fintype L] [DecidableEq L] [Fintype R] [DecidableEq R] in
theorem mem_of_reflTransGen_of_successorClosed
    (adj : L → R → Prop) (matching : L → R) (A : Finset L)
    (hclosed : SuccessorClosed adj matching A) {x y : L}
    (hx : x ∈ A) (hxy : Relation.ReflTransGen (dependency adj matching) x y) :
    y ∈ A := by
  induction hxy with
  | refl => exact hx
  | tail hxy hyz ih => exact hclosed _ ih _ hyz

omit [DecidableEq L] in
/-- Strict Hall for every nonempty left subset is equivalent to every left
vertex reaching a vertex with a globally unmatched neighbor. -/
theorem strictHall_iff_every_vertex_reaches_bad
    (adj : L → R → Prop) [DecidableRel adj] (matching : L → R)
    (hinj : Function.Injective matching) (hmatch : ∀ x, adj x (matching x)) :
    (∀ A : Finset L, A.Nonempty → A.card < (neighborhood adj A).card) ↔
      ∀ x, ∃ b, Relation.ReflTransGen (dependency adj matching) x b ∧
        badVertex adj matching b := by
  constructor
  · intro hstrict x
    by_contra hnone
    have hnone' : ∀ b,
        Relation.ReflTransGen (dependency adj matching) x b →
          ¬ badVertex adj matching b := by
      intro b hxb hbad
      exact hnone ⟨b, hxb, hbad⟩
    let A := reachableSet adj matching x
    have hnonempty : A.Nonempty := reachableSet_nonempty adj matching x
    have hclosed : SuccessorClosed adj matching A :=
      reachableSet_successorClosed adj matching x
    have havoids : AvoidsBad adj matching A := by
      intro y hy
      exact hnone' y ((mem_reachableSet_iff adj matching x y).mp hy)
    have htight : (neighborhood adj A).card = A.card :=
      (tight_iff_successorClosed_and_avoidsBad adj matching hinj hmatch A).mpr
        ⟨hclosed, havoids⟩
    have := hstrict A hnonempty
    exact (Nat.ne_of_lt this) htight.symm
  · intro hreach A hnonempty
    have hle : A.card ≤ (neighborhood adj A).card := by
      rw [← card_matchingImage matching hinj A]
      exact Finset.card_le_card
        (matchingImage_subset_neighborhood adj matching hmatch A)
    by_contra hnlt
    have htight : (neighborhood adj A).card = A.card :=
      Nat.le_antisymm (Nat.le_of_not_gt hnlt) hle
    obtain ⟨hclosed, havoids⟩ :=
      (tight_iff_successorClosed_and_avoidsBad adj matching hinj hmatch A).mp htight
    obtain ⟨x, hx⟩ := hnonempty
    obtain ⟨b, hxb, hbad⟩ := hreach x
    have hb : b ∈ A :=
      mem_of_reflTransGen_of_successorClosed adj matching A hclosed hx hxb
    exact (havoids b hb) hbad

end Matching

end LonelyRunner

#print axioms LonelyRunner.tight_iff_successorClosed_and_avoidsBad
#print axioms LonelyRunner.strictHall_iff_every_vertex_reaches_bad
