import LonelyRunner.BHKAdjacentRatios
import Mathlib.Data.Finset.Max

/-!
# Adjacent values of a finite nonconstant family

This is the finite-order selection step in the BHK real-to-rational reduction.
It deliberately records adjacency among values of the indexed family, rather
than relying on a sorted-list representation with additional bookkeeping.
-/

namespace LonelyRunner

/-- A nonconstant function on a finite nonempty type has two attained values
with no attained value strictly between them. -/
theorem exists_adjacent_image_values
    {ι α : Type*} [Fintype ι] [Nonempty ι] [LinearOrder α]
    (f : ι → α) (hnonconstant : ∃ a b, f a ≠ f b) :
    ∃ i j, f i < f j ∧ ∀ k, ¬ (f i < f k ∧ f k < f j) := by
  classical
  obtain ⟨i, -, hi⟩ := Finset.exists_min_image Finset.univ f Finset.univ_nonempty
  have habove : ∃ k, f i < f k := by
    by_contra h
    push Not at h
    obtain ⟨a, b, hab⟩ := hnonconstant
    apply hab
    have ha : f a = f i :=
      le_antisymm (h a) (hi a (Finset.mem_univ a))
    have hb : f b = f i :=
      le_antisymm (h b) (hi b (Finset.mem_univ b))
    exact ha.trans hb.symm
  let upper : Finset ι := Finset.univ.filter fun k => f i < f k
  have hupper : upper.Nonempty := by
    obtain ⟨k, hk⟩ := habove
    exact ⟨k, Finset.mem_filter.mpr ⟨Finset.mem_univ k, hk⟩⟩
  obtain ⟨j, hjupper, hjmin⟩ := Finset.exists_min_image upper f hupper
  have hij : f i < f j := (Finset.mem_filter.mp hjupper).2
  refine ⟨i, j, hij, ?_⟩
  intro k hk
  have hkupper : k ∈ upper :=
    Finset.mem_filter.mpr ⟨Finset.mem_univ k, hk.1⟩
  exact (not_lt_of_ge (hjmin k hkupper)) hk.2

/-- Applied to coordinate ratios, the adjacent-value lemma supplies exactly
the hypotheses required by `bhk_adjacentRatioCombination`. -/
theorem exists_bhk_adjacentRatioCombination {m : ℕ} [Nonempty (Fin m)]
    (r s : Fin m → ℚ) (hr : ∀ k, 0 < r k)
    (hnonconstant : ∃ a b, s a / r a ≠ s b / r b) :
    ∃ i j, i ≠ j ∧
      let w : Fin m → ℚ := fun k =>
        (r i + r j) * s k - (s i + s j) * r k
      (∀ k, w k ≠ 0) ∧ w i = -w j := by
  obtain ⟨i, j, hij, hadjacent⟩ :=
    exists_adjacent_image_values (fun k => s k / r k) hnonconstant
  have hne : i ≠ j := by
    intro h
    subst j
    exact (lt_irrefl _ hij)
  exact ⟨i, j, hne,
    bhk_adjacentRatioCombination r s hr i j hij hadjacent⟩

end LonelyRunner
