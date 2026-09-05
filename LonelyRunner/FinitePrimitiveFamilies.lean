import LonelyRunner.PrimitiveTupleNormalization
import LonelyRunner.FiniteHeightReduction
import LonelyRunner.LonelyAtTransport

/-!
# Inclusive primitive finite families

The finite family supplies the low-height branch, while the existing affine
reduction supplies the strict large-height branch.  Both are transported back
to the original signed integer labels through the exact normalization map.
-/

namespace LonelyRunner

noncomputable section

def InclusivePrimitiveFiniteFamily (m : ℕ) : Prop :=
  ∀ s : Fin (m + 2) → ℕ,
    StrictMono s → s 0 = 0 → Finset.univ.gcd s = 1 →
    s (Fin.last (m + 1)) ≤ ((m + 2) * (m + 1)) ^ m →
    ∀ r : Fin (m + 2), ∃ t : ℝ,
      LonelyAt (fun i => (s i : ℝ)) r t

def AllInclusivePrimitiveFiniteFamilies : Prop :=
  ∀ m : ℕ, 1 ≤ m → InclusivePrimitiveFiniteFamily m

theorem integer_lonelyAt_of_lower_and_finiteFamily {m : ℕ} (hm : 1 ≤ m)
    (hLower : LowerCountPositiveIntegerHypothesis (m + 2))
    (hFinite : InclusivePrimitiveFiniteFamily m)
    (a : Fin (m + 2) → ℤ) (hinj : Function.Injective a) :
    ∀ r : Fin (m + 2), ∃ t : ℝ,
      LonelyAt (fun i => (a i : ℝ)) r t := by
  obtain ⟨e, c, g, b, hg, hbmono, hbzero, hbgcd, hfactor⟩ :=
    exists_sorted_primitive_integer_normalization a hinj
  let Q : ℕ := ((m + 2) * (m + 1)) ^ m
  intro r
  have hnormalized : ∃ T : ℝ, LonelyAt (fun i => (b i : ℝ)) (e.symm r) T := by
    by_cases hlow : b (Fin.last (m + 1)) ≤ Q
    · exact hFinite b hbmono hbzero hbgcd (by simpa [Q] using hlow) (e.symm r)
    · have hhigh : ((m + 2) * (m + 1)) ^ m < b (Fin.last (m + 1)) := by
        simpa [Q] using Nat.lt_of_not_ge hlow
      obtain ⟨T, _hT, hT⟩ :=
        primitive_sorted_largeHeight_lonelyAt hm hLower b hbmono hbzero hbgcd hhigh (e.symm r)
      exact ⟨T, hT⟩
  obtain ⟨T, hT⟩ := hnormalized
  refine ⟨T / (g : ℝ), ?_⟩
  apply (lonelyAt_reindex_translate_scale_iff
    (fun i => (a i : ℝ)) (fun i => (b i : ℝ)) e (c : ℝ) (g : ℝ)
    (by exact_mod_cast hg.ne') ?_ r T).mpr hT
  intro j
  exact_mod_cast hfactor j

end

end LonelyRunner
