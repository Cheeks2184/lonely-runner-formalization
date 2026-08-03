import LonelyRunner.MatchingDependency
import Mathlib.Logic.Equiv.Fintype

namespace LonelyRunner

open Finset

section Contraction

variable {L R : Type*} [Fintype L] [DecidableEq L]
  [Fintype R] [DecidableEq R]

/-- Vertices which do not reach any vertex with a globally unmatched
neighbor, relative to the fixed matching. -/
noncomputable def nonReachingSet
    (adj : L → R → Prop) [DecidableRel adj]
    (matching : L → R) : Finset L := by
  classical
  exact Finset.univ.filter fun x =>
    ¬ ∃ b, Relation.ReflTransGen (dependency adj matching) x b ∧
      badVertex adj matching b

omit [DecidableEq L] [Fintype R] in
theorem mem_nonReachingSet_iff
    (adj : L → R → Prop) [DecidableRel adj]
    (matching : L → R) (x : L) :
    x ∈ nonReachingSet adj matching ↔
      ¬ ∃ b, Relation.ReflTransGen (dependency adj matching) x b ∧
        badVertex adj matching b := by
  classical
  simp [nonReachingSet]

omit [DecidableEq L] [Fintype R] in
theorem not_mem_nonReachingSet_of_reaches_bad
    (adj : L → R → Prop) [DecidableRel adj]
    (matching : L → R) {x b : L}
    (hxb : Relation.ReflTransGen (dependency adj matching) x b)
    (hbad : badVertex adj matching b) :
    x ∉ nonReachingSet adj matching := by
  rw [mem_nonReachingSet_iff]
  exact fun hnone => hnone ⟨b, hxb, hbad⟩

omit [DecidableEq L] [Fintype R] in
/-- The non-reaching set is closed under the fixed-matching dependency
relation. -/
theorem nonReachingSet_successorClosed
    (adj : L → R → Prop) [DecidableRel adj]
    (matching : L → R) :
    SuccessorClosed adj matching (nonReachingSet adj matching) := by
  intro x hx y hxy
  rw [mem_nonReachingSet_iff] at hx ⊢
  rintro ⟨b, hyb, hbad⟩
  exact hx ⟨b, hyb.head hxy, hbad⟩

omit [DecidableEq L] [Fintype R] in
/-- No non-reaching vertex is itself marked. -/
theorem nonReachingSet_avoidsBad
    (adj : L → R → Prop) [DecidableRel adj]
    (matching : L → R) :
    AvoidsBad adj matching (nonReachingSet adj matching) := by
  intro x hx hbad
  rw [mem_nonReachingSet_iff] at hx
  exact hx ⟨x, Relation.ReflTransGen.refl, hbad⟩

omit [DecidableEq L] in
/-- The entire non-reaching region is one (possibly empty) Hall-tight set. -/
theorem nonReachingSet_tight
    (adj : L → R → Prop) [DecidableRel adj]
    (matching : L → R)
    (hinj : Function.Injective matching)
    (hmatch : ∀ x, adj x (matching x)) :
    (neighborhood adj (nonReachingSet adj matching)).card =
      (nonReachingSet adj matching).card := by
  apply (tight_iff_successorClosed_and_avoidsBad
    adj matching hinj hmatch (nonReachingSet adj matching)).2
  exact ⟨nonReachingSet_successorClosed adj matching,
    nonReachingSet_avoidsBad adj matching⟩

/-- Left vertices remaining after contraction. -/
abbrev ResidualLeft (U : Finset L) := {x : L // x ∉ U}

/-- Right vertices remaining after deleting the matching image of `U`. -/
abbrev ResidualRight (matching : L → R) (U : Finset L) :=
  {r : R // r ∉ matchingImage matching U}

noncomputable instance residualLeftFintype (U : Finset L) :
    Fintype (ResidualLeft U) :=
  Fintype.ofFinite _

noncomputable instance residualRightFintype
    (matching : L → R) (U : Finset L) :
    Fintype (ResidualRight matching U) :=
  Fintype.ofFinite _

/-- The induced residual bipartite relation. -/
def residualAdj (adj : L → R → Prop) (matching : L → R)
    (U : Finset L) :
    ResidualLeft U → ResidualRight matching U → Prop :=
  fun x r => adj x.1 r.1

instance residualAdjDecidable (adj : L → R → Prop) [DecidableRel adj]
    (matching : L → R) (U : Finset L) :
    DecidableRel (residualAdj adj matching U) := by
  intro x r
  exact inferInstanceAs (Decidable (adj x.1 r.1))

/-- The original matching restricted to the residual subtypes. -/
def residualMatching (matching : L → R)
    (hinj : Function.Injective matching) (U : Finset L) :
    ResidualLeft U → ResidualRight matching U := fun x =>
  ⟨matching x.1, by
    intro himage
    obtain ⟨u, hu, hux⟩ := Finset.mem_image.mp himage
    have hux' : u = x.1 := hinj hux
    exact x.2 (by simpa [hux'] using hu)⟩

omit [Fintype L] [DecidableEq L] [Fintype R] in
theorem residualMatching_injective
    (matching : L → R) (hinj : Function.Injective matching)
    (U : Finset L) :
    Function.Injective (residualMatching matching hinj U) := by
  intro x y hxy
  apply Subtype.ext
  apply hinj
  exact congrArg Subtype.val hxy

omit [Fintype L] [DecidableEq L] [Fintype R] in
theorem residualMatching_saturates
    (adj : L → R → Prop) (matching : L → R)
    (hinj : Function.Injective matching) (hmatch : ∀ x, adj x (matching x))
    (U : Finset L) :
    ∀ x, residualAdj adj matching U x (residualMatching matching hinj U x) := by
  intro x
  exact hmatch x.1

omit [DecidableEq L] [Fintype R] in
/-- An originally marked residual left vertex remains marked after deleting
`U` and its matching image. -/
theorem residual_bad_of_bad
    (adj : L → R → Prop) [DecidableRel adj]
    (matching : L → R) (hinj : Function.Injective matching)
    (U : Finset L) (x : ResidualLeft U)
    (hbad : badVertex adj matching x.1) :
    badVertex (residualAdj adj matching U)
      (residualMatching matching hinj U) x := by
  obtain ⟨r, hxr, hunmatched⟩ := hbad
  have hrU : r ∉ matchingImage matching U := by
    intro hr
    obtain ⟨u, hu, hur⟩ := Finset.mem_image.mp hr
    apply hunmatched
    exact Finset.mem_image.mpr ⟨u, Finset.mem_univ _, hur⟩
  let rr : ResidualRight matching U := ⟨r, hrU⟩
  refine ⟨rr, hxr, ?_⟩
  intro hrmatched
  obtain ⟨y, _, hyr⟩ := Finset.mem_image.mp hrmatched
  apply hunmatched
  exact Finset.mem_image.mpr
    ⟨y.1, Finset.mem_univ _, congrArg Subtype.val hyr⟩

omit [DecidableEq L] [Fintype R] in
/-- A dependency path whose endpoint can still reach a marked vertex lifts
to the residual graph: every vertex on the path is outside `U`. -/
theorem residual_reflTransGen_of_reflTransGen_reaches_bad
    (adj : L → R → Prop) [DecidableRel adj]
    (matching : L → R) (hinj : Function.Injective matching)
    {x y b : L}
    (hxy : Relation.ReflTransGen (dependency adj matching) x y)
    (hyb : Relation.ReflTransGen (dependency adj matching) y b)
    (hbad : badVertex adj matching b) :
    Relation.ReflTransGen
      (dependency (residualAdj adj matching (nonReachingSet adj matching))
        (residualMatching matching hinj (nonReachingSet adj matching)))
      (⟨x, not_mem_nonReachingSet_of_reaches_bad adj matching
        (hxy.trans hyb) hbad⟩ : ResidualLeft (nonReachingSet adj matching))
      (⟨y, not_mem_nonReachingSet_of_reaches_bad adj matching hyb hbad⟩ :
        ResidualLeft (nonReachingSet adj matching)) := by
  revert b
  induction hxy with
  | refl =>
      intro b hyb hbad
      exact Relation.ReflTransGen.refl
  | @tail z y hxz hzy ih =>
      intro b hyb hbad
      have hzb : Relation.ReflTransGen (dependency adj matching) z b :=
        hyb.head hzy
      have hp := ih hzb hbad
      apply hp.tail
      exact hzy

omit [DecidableEq L] [Fintype R] in
/-- **One-shot contraction theorem.** After deleting all vertices which do
not reach a marked vertex, together with their matched right vertices, every
remaining left vertex reaches a vertex marked in the residual graph. -/
theorem residual_every_vertex_reaches_bad
    (adj : L → R → Prop) [DecidableRel adj]
    (matching : L → R) (hinj : Function.Injective matching) :
    ∀ x : ResidualLeft (nonReachingSet adj matching),
      ∃ b,
        Relation.ReflTransGen
          (dependency
            (residualAdj adj matching (nonReachingSet adj matching))
            (residualMatching matching hinj (nonReachingSet adj matching))) x b ∧
        badVertex
          (residualAdj adj matching (nonReachingSet adj matching))
          (residualMatching matching hinj (nonReachingSet adj matching)) b := by
  intro x
  have hxreach : ∃ b,
      Relation.ReflTransGen (dependency adj matching) x.1 b ∧
        badVertex adj matching b := by
    by_contra hnone
    have hxU : x.1 ∈ nonReachingSet adj matching :=
      (mem_nonReachingSet_iff adj matching x.1).2 hnone
    exact x.2 hxU
  obtain ⟨b, hxb, hbad⟩ := hxreach
  have hbnot := not_mem_nonReachingSet_of_reaches_bad adj matching
    Relation.ReflTransGen.refl hbad
  let br : ResidualLeft (nonReachingSet adj matching) := ⟨b, hbnot⟩
  refine ⟨br, ?_, residual_bad_of_bad adj matching hinj _ br hbad⟩
  simpa [br] using
    (residual_reflTransGen_of_reflTransGen_reaches_bad
      adj matching hinj hxb Relation.ReflTransGen.refl hbad)

omit [DecidableEq L] in
/-- The residual induced graph has strict Hall expansion on every nonempty
left subset. -/
theorem residual_strictHall
    (adj : L → R → Prop) [DecidableRel adj]
    (matching : L → R) (hinj : Function.Injective matching)
    (hmatch : ∀ x, adj x (matching x)) :
    ∀ A : Finset (ResidualLeft (nonReachingSet adj matching)),
      A.Nonempty →
        A.card <
          (neighborhood
            (residualAdj adj matching (nonReachingSet adj matching)) A).card := by
  apply (strictHall_iff_every_vertex_reaches_bad
    (residualAdj adj matching (nonReachingSet adj matching))
    (residualMatching matching hinj (nonReachingSet adj matching))
    (residualMatching_injective matching hinj _)
    (residualMatching_saturates adj matching hinj hmatch _)).2
  exact residual_every_vertex_reaches_bad adj matching hinj

end Contraction

end LonelyRunner

#print axioms LonelyRunner.nonReachingSet_tight
#print axioms LonelyRunner.residual_every_vertex_reaches_bad
#print axioms LonelyRunner.residual_strictHall
