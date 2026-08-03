import Mathlib.Data.Finset.Card
import Mathlib.Logic.Relation
import Mathlib.Tactic

namespace LonelyRunner

namespace HallDependency

variable {L R : Type*} [Fintype L] [Fintype R]

/-- Right neighborhood of a finite left set. -/
noncomputable def neighbors (adj : L → R → Prop) (S : Finset L) : Finset R := by
  classical
  exact Finset.univ.filter fun y => ∃ x ∈ S, adj x y

@[simp] theorem mem_neighbors (adj : L → R → Prop) (S : Finset L) (y : R) :
    y ∈ neighbors adj S ↔ ∃ x ∈ S, adj x y := by
  classical
  simp [neighbors]

/-- Dependency edge induced by a fixed left-saturating matching:
`x → z` when `x` is adjacent to the right vertex matched to `z`. -/
def dependency (adj : L → R → Prop) (mate : L → R) (x z : L) : Prop :=
  adj x (mate z)

/-- A left vertex is bad when it has an adjacent right vertex outside the
image of the fixed matching. -/
def isBad (adj : L → R → Prop) (mate : L → R) (x : L) : Prop :=
  ∃ y, adj x y ∧ y ∉ Set.range mate

def SuccessorClosed (adj : L → R → Prop) (mate : L → R)
    (S : Finset L) : Prop :=
  ∀ ⦃x⦄, x ∈ S → ∀ ⦃z⦄, dependency adj mate x z → z ∈ S

def AvoidsBad (adj : L → R → Prop) (mate : L → R)
    (S : Finset L) : Prop :=
  ∀ ⦃x⦄, x ∈ S → ¬ isBad adj mate x

def ReachesBad (adj : L → R → Prop) (mate : L → R) (x : L) : Prop :=
  ∃ y, Relation.ReflTransGen (dependency adj mate) x y ∧ isBad adj mate y

private theorem image_mate_subset_neighbors
    (adj : L → R → Prop) (mate : L → R)
    (hmatch : ∀ x, adj x (mate x)) (S : Finset L) :
    S.image mate ⊆ neighbors adj S := by
  classical
  intro y hy
  rcases Finset.mem_image.mp hy with ⟨x, hx, rfl⟩
  exact (mem_neighbors adj S (mate x)).2 ⟨x, hx, hmatch x⟩

private theorem card_image_mate
    (mate : L → R) (hinj : Function.Injective mate) (S : Finset L) :
    (S.image mate).card = S.card := by
  classical
  rw [Finset.card_image_iff.mpr]
  intro x _ y _ hxy
  exact hinj hxy

/-- Tight Hall subsets are exactly the successor-closed subsets avoiding all
bad vertices in the dependency digraph of a fixed saturating matching. -/
theorem card_neighbors_eq_card_iff
    (adj : L → R → Prop) (mate : L → R)
    (hinj : Function.Injective mate)
    (hmatch : ∀ x, adj x (mate x))
    (S : Finset L) :
    (neighbors adj S).card = S.card ↔
      SuccessorClosed adj mate S ∧ AvoidsBad adj mate S := by
  classical
  have himageSub : S.image mate ⊆ neighbors adj S :=
    image_mate_subset_neighbors adj mate hmatch S
  have hcardImage : (S.image mate).card = S.card :=
    card_image_mate mate hinj S
  constructor
  · intro hcard
    have hcardLe : (neighbors adj S).card ≤ (S.image mate).card := by
      rw [hcard, hcardImage]
    have heq : S.image mate = neighbors adj S :=
      Finset.eq_of_subset_of_card_le himageSub hcardLe
    constructor
    · intro x hx z hxz
      have hzN : mate z ∈ neighbors adj S :=
        (mem_neighbors adj S (mate z)).2 ⟨x, hx, hxz⟩
      have hzI : mate z ∈ S.image mate := by simpa [heq] using hzN
      rcases Finset.mem_image.mp hzI with ⟨z', hz', hzz⟩
      have : z' = z := hinj hzz
      simpa [this] using hz'
    · intro x hx hbad
      rcases hbad with ⟨y, hxy, hyNot⟩
      apply hyNot
      have hyN : y ∈ neighbors adj S :=
        (mem_neighbors adj S y).2 ⟨x, hx, hxy⟩
      have hyI : y ∈ S.image mate := by simpa [heq] using hyN
      rcases Finset.mem_image.mp hyI with ⟨z, _hz, hzy⟩
      exact ⟨z, hzy⟩
  · rintro ⟨hclosed, havoid⟩
    have hneighSub : neighbors adj S ⊆ S.image mate := by
      intro y hy
      rcases (mem_neighbors adj S y).1 hy with ⟨x, hx, hxy⟩
      have hyRange : y ∈ Set.range mate := by
        by_contra hnot
        exact (havoid hx) ⟨y, hxy, hnot⟩
      rcases hyRange with ⟨z, rfl⟩
      exact Finset.mem_image.mpr ⟨z, hclosed hx hxy, rfl⟩
    have heq : neighbors adj S = S.image mate :=
      Finset.Subset.antisymm hneighSub himageSub
    rw [heq, hcardImage]

theorem card_le_neighbors
    (adj : L → R → Prop) (mate : L → R)
    (hinj : Function.Injective mate)
    (hmatch : ∀ x, adj x (mate x))
    (S : Finset L) :
    S.card ≤ (neighbors adj S).card := by
  classical
  rw [← card_image_mate mate hinj S]
  exact Finset.card_le_card
    (image_mate_subset_neighbors adj mate hmatch S)

private theorem mem_of_reachable_of_successorClosed
    (adj : L → R → Prop) (mate : L → R)
    (S : Finset L) (hclosed : SuccessorClosed adj mate S)
    {x y : L} (hx : x ∈ S)
    (hxy : Relation.ReflTransGen (dependency adj mate) x y) :
    y ∈ S := by
  induction hxy with
  | refl => exact hx
  | tail _ hyz ih => exact hclosed ih hyz

/-- Strict Hall expansion for every nonempty left subset is equivalent to
every dependency vertex reaching a bad vertex. -/
theorem strictHall_iff_every_reachesBad
    (adj : L → R → Prop) (mate : L → R)
    (hinj : Function.Injective mate)
    (hmatch : ∀ x, adj x (mate x)) :
    (∀ S : Finset L, S.Nonempty →
      S.card < (neighbors adj S).card) ↔
    ∀ x, ReachesBad adj mate x := by
  classical
  constructor
  · intro hstrict x
    by_contra hnot
    push_neg at hnot
    let S : Finset L :=
      Finset.univ.filter fun y =>
        Relation.ReflTransGen (dependency adj mate) x y
    have hxS : x ∈ S := by
      simp [S]
    have hclosed : SuccessorClosed adj mate S := by
      intro y hy z hyz
      have hyReach :
          Relation.ReflTransGen (dependency adj mate) x y := by
        simpa [S] using hy
      have hzReach := hyReach.tail hyz
      simpa [S] using hzReach
    have havoid : AvoidsBad adj mate S := by
      intro y hy
      have hyReach :
          Relation.ReflTransGen (dependency adj mate) x y := by
        simpa [S] using hy
      exact hnot y hyReach
    have htight :
        (neighbors adj S).card = S.card :=
      (card_neighbors_eq_card_iff adj mate hinj hmatch S).2
        ⟨hclosed, havoid⟩
    have hlt := hstrict S ⟨x, hxS⟩
    omega
  · intro hreach S hS
    have hle := card_le_neighbors adj mate hinj hmatch S
    by_contra hnot
    have hrev : (neighbors adj S).card ≤ S.card := Nat.le_of_not_gt hnot
    have heq : (neighbors adj S).card = S.card :=
      Nat.le_antisymm hrev hle
    rcases (card_neighbors_eq_card_iff adj mate hinj hmatch S).1 heq with
      ⟨hclosed, havoid⟩
    rcases hS with ⟨x, hx⟩
    rcases hreach x with ⟨y, hxy, hyBad⟩
    have hy : y ∈ S :=
      mem_of_reachable_of_successorClosed adj mate S hclosed hx hxy
    exact (havoid hy) hyBad

end HallDependency

end LonelyRunner
