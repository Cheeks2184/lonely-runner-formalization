import Mathlib.Data.Finset.Sort

namespace LonelyRunner

/-- Reindex an injective finite tuple so its values increase with the new
index.  The equivalence points from sorted positions back to the original
labels, preserving the label needed by later runner transports. -/
theorem exists_strictMono_reindex {n : ℕ} {α : Type*} [LinearOrder α]
    (a : Fin n → α) (hinj : Function.Injective a) :
    ∃ e : Fin n ≃ Fin n, StrictMono (fun j => a (e j)) := by
  classical
  let S : Finset α := Finset.univ.image a
  let rangeEquiv : Fin n ≃ {x : α // x ∈ S} :=
    Equiv.ofBijective (fun i => ⟨a i, Finset.mem_image.mpr ⟨i, Finset.mem_univ _, rfl⟩⟩) (by
      constructor
      · intro i j h
        apply hinj
        exact congrArg Subtype.val h
      · intro x
        rcases Finset.mem_image.mp x.property with ⟨i, _hi, hai⟩
        refine ⟨i, ?_⟩
        apply Subtype.ext
        exact hai)
  have hcard : S.card = n := by
    dsimp [S]
    rw [Finset.card_image_iff.mpr]
    · simp
    · intro i _i j _j hij
      exact hinj hij
  let sorted : Fin n ≃o {x : α // x ∈ S} := S.orderIsoOfFin hcard
  refine ⟨sorted.toEquiv.trans rangeEquiv.symm, ?_⟩
  intro i j hij
  have hsorted : sorted i < sorted j := sorted.strictMono hij
  change (rangeEquiv (rangeEquiv.symm (sorted i)) : α) <
    (rangeEquiv (rangeEquiv.symm (sorted j)) : α)
  rw [rangeEquiv.apply_symm_apply, rangeEquiv.apply_symm_apply]
  exact hsorted

end LonelyRunner
