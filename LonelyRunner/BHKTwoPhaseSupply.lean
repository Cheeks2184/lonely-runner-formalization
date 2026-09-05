import LonelyRunner.BHKAdjacentPair
import LonelyRunner.LowerCountSupply

/-!
# Lower-count supply for BHK free phases

The adjacent-ratio construction supplies a rational collision vector.  Under
the bounded lower-count hypothesis, its stationary witness gives two free
phases with the same `1 / (N - 1)` margin.  No compatibility with an original
real orbit is asserted here.
-/

namespace LonelyRunner

noncomputable section

/-- The BHK adjacent-pair collision, combined only with `H_N`, supplies free
real phases for the rational rows `r` and `s`. -/
theorem exists_bhk_twoPhase_margin {N m : ℕ}
    (hN : 3 ≤ N) (hm : 0 < m) (hmN : m ≤ N - 1)
    (r s : Fin m → ℚ) (hr : ∀ i, 0 < r i)
    (hnonconstant : ∃ a b, s a / r a ≠ s b / r b)
    (hLower : LowerCountPositiveIntegerHypothesis N) :
    ∃ a b : ℝ, ∀ i,
      (((N - 1 : ℕ) : ℝ)⁻¹) ≤
        circleNorm ((r i : ℝ) * a + (s i : ℝ) * b) := by
  classical
  letI : Nonempty (Fin m) := ⟨⟨0, hm⟩⟩
  obtain ⟨i, j, hij, hw⟩ :=
    exists_bhk_adjacentRatioCombination r s hr hnonconstant
  let w : Fin m → ℚ := fun k =>
    (r i + r j) * s k - (s i + s j) * r k
  change (∀ k, w k ≠ 0) ∧ w i = -w j at hw
  rcases hw with ⟨hwzero, hwopposite⟩
  have habs : |w i| = |w j| := by
    rw [hwopposite, abs_neg]
  have hcardle : (Finset.univ.image (fun k => |w k|)).card ≤ m := by
    simpa using Finset.card_image_le (s := (Finset.univ : Finset (Fin m)))
      (f := fun k => |w k|)
  have hcardne : (Finset.univ.image (fun k => |w k|)).card ≠ m := by
    intro hcard
    have hinjOn : Set.InjOn (fun k : Fin m => |w k|)
        ((Finset.univ : Finset (Fin m)) : Set (Fin m)) := by
      apply Finset.card_image_iff.mp
      simpa using hcard
    exact hij (hinjOn (by simp) (by simp) habs)
  have hcardlt : (Finset.univ.image (fun k => |w k|)).card < m :=
    lt_of_le_of_ne hcardle hcardne
  have hcard : (Finset.univ.image (fun k => |w k|)).card ≤ N - 2 := by
    omega
  obtain ⟨t, ht⟩ :=
    exists_lowerCount_rational_collision hN hm w hwzero hcard hLower
  let a : ℝ := -((s i + s j : ℚ) : ℝ) * t
  let b : ℝ := ((r i + r j : ℚ) : ℝ) * t
  refine ⟨a, b, fun k => ?_⟩
  have hphase : t * (w k : ℝ) = (r k : ℝ) * a + (s k : ℝ) * b := by
    dsimp [w, a, b]
    push_cast
    ring
  rw [← hphase]
  exact ht k

end

end LonelyRunner
