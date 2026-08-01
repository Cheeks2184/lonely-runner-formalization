import LonelyRunner.RationalRelationSpace
import Mathlib.Data.Finset.Max
import Mathlib.LinearAlgebra.Dual.Lemmas
import Mathlib.LinearAlgebra.FiniteDimensional.Basic

/-!
# Dual separation and adjacent values for the BHK reduction

This file isolates two finite-dimensional facts used in the real-to-rational
bridge.  First, a spanning finite family in a vector space of dimension at
least two admits a dual functional which is not proportional to a prescribed
nonzero dual.  If the prescribed dual is nonzero on every generator, the
quotients of the two dual values cannot all be equal.  Second, every
nonconstant finite tuple in a linear order contains a pair of adjacent values.
-/

noncomputable section

open Finset

namespace LonelyRunner

/-- The velocities, regarded as elements of their rational span, generate the
whole rational span.  This is the interface between `rationalSpan` and the
abstract dual-separation lemmas below. -/
theorem velocityInRationalSpan_span_eq_top {m : ℕ} (u : Fin m → ℝ) :
    Submodule.span ℚ (Set.range (velocityInRationalSpan u)) = ⊤ := by
  apply Submodule.eq_top_iff'.2
  rintro ⟨x, hx⟩
  induction hx using Submodule.span_induction with
  | mem x hx =>
      obtain ⟨i, rfl⟩ := hx
      exact Submodule.subset_span (Set.mem_range_self i)
  | zero => exact Submodule.zero_mem _
  | add x y hx hy hx' hy' => exact Submodule.add_mem _ hx' hy'
  | smul c x hx hx' => exact Submodule.smul_mem _ c hx'

section DualSeparation

variable {K V ι : Type*}
variable [Field K] [AddCommGroup V] [Module K V]

/-- In dimension at least two, no one-dimensional span exhausts the dual. -/
theorem exists_dual_not_proportional
    (hfinrank : 2 ≤ Module.finrank K V) (phi : Module.Dual K V) (hphi : phi ≠ 0) :
    ∃ psi : Module.Dual K V, ∀ c : K, psi ≠ c • phi := by
  have hspan_ne_top : K ∙ phi ≠ (⊤ : Submodule K (Module.Dual K V)) := by
    intro htop
    have hrank_span : Module.finrank K (K ∙ phi) = 1 :=
      finrank_span_singleton hphi
    have hrank_dual : Module.finrank K (Module.Dual K V) = 1 := by
      rw [← finrank_top, ← htop]
      exact hrank_span
    have hrank_V : Module.finrank K V = 1 := by
      rw [← Subspace.dual_finrank_eq]
      exact hrank_dual
    omega
  have hexists : ∃ psi : Module.Dual K V, psi ∉ K ∙ phi := by
    by_contra h
    push Not at h
    apply hspan_ne_top
    exact Submodule.eq_top_iff'.2 h
  obtain ⟨psi, hpsi⟩ := hexists
  refine ⟨psi, fun c heq => ?_⟩
  apply hpsi
  rw [heq]
  exact Submodule.smul_mem _ c (Submodule.mem_span_singleton_self phi)

/-- A dual not proportional to `phi` has nonconstant pointwise quotients on
any spanning family on which `phi` is nonzero. -/
theorem dual_ratios_nonconstant
    [Nonempty ι]
    (u : ι → V) (hspan : Submodule.span K (Set.range u) = ⊤)
    (phi psi : Module.Dual K V) (hphi : ∀ i, phi (u i) ≠ 0)
    (hpsi : ∀ c : K, psi ≠ c • phi) :
    ∃ i j : ι, psi (u i) / phi (u i) ≠ psi (u j) / phi (u j) := by
  by_contra h
  push Not at h
  let i₀ : ι := Classical.choice inferInstance
  let c : K := psi (u i₀) / phi (u i₀)
  have hagree : ∀ i, psi (u i) = (c • phi) (u i) := by
    intro i
    have hratio : psi (u i) / phi (u i) = c := h i i₀
    dsimp [c] at hratio ⊢
    field_simp [hphi i, hphi i₀] at hratio ⊢
    exact hratio
  have heq : psi = c • phi := LinearMap.ext_on_range hspan hagree
  exact hpsi c heq

/-- Combined dual-separation statement in the form needed by BHK. -/
theorem exists_dual_with_nonconstant_ratios
    [Nonempty ι]
    (hfinrank : 2 ≤ Module.finrank K V)
    (u : ι → V) (hspan : Submodule.span K (Set.range u) = ⊤)
    (phi : Module.Dual K V) (hphi : ∀ i, phi (u i) ≠ 0) :
    ∃ psi : Module.Dual K V,
      ∃ i j : ι, psi (u i) / phi (u i) ≠ psi (u j) / phi (u j) := by
  have hphi_ne : phi ≠ 0 := by
    intro heq
    let i₀ : ι := Classical.choice inferInstance
    exact hphi i₀ (by simp [heq])
  obtain ⟨psi, hpsi⟩ := exists_dual_not_proportional hfinrank phi hphi_ne
  exact ⟨psi, dual_ratios_nonconstant u hspan phi psi hphi hpsi⟩

/-- Specialization of dual separation to the rational span of a real velocity
tuple. -/
theorem exists_rationalSpan_dual_with_nonconstant_ratios {m : ℕ}
    [Nonempty (Fin m)] (u : Fin m → ℝ)
    (hfinrank : 2 ≤ Module.finrank ℚ (rationalSpan u))
    (phi : Module.Dual ℚ (rationalSpan u))
    (hphi : ∀ i, phi (velocityInRationalSpan u i) ≠ 0) :
    ∃ psi : Module.Dual ℚ (rationalSpan u), ∃ i j : Fin m,
      psi (velocityInRationalSpan u i) / phi (velocityInRationalSpan u i) ≠
        psi (velocityInRationalSpan u j) / phi (velocityInRationalSpan u j) := by
  exact exists_dual_with_nonconstant_ratios hfinrank
    (velocityInRationalSpan u) (velocityInRationalSpan_span_eq_top u) phi hphi

end DualSeparation

section AdjacentValues

variable {α ι : Type*} [LinearOrder α] [Fintype ι] [Nonempty ι]

/-- A nonconstant finite tuple has two values with no tuple value strictly
between them. -/
theorem exists_adjacent_pair_of_nonconstant (f : ι → α)
    (h : ∃ a b, f a ≠ f b) :
    ∃ i j, f i < f j ∧ ∀ k, ¬ (f i < f k ∧ f k < f j) := by
  obtain ⟨i, hi_mem, hi_min⟩ :=
    Finset.exists_min_image (Finset.univ : Finset ι) f Finset.univ_nonempty
  have habove_nonempty : (Finset.univ.filter fun k => f i < f k).Nonempty := by
    obtain ⟨a, b, hab⟩ := h
    by_cases hai : f a = f i
    · refine ⟨b, Finset.mem_filter.2 ⟨Finset.mem_univ _, ?_⟩⟩
      exact lt_of_le_of_ne (hi_min b (Finset.mem_univ b))
        (fun hib => hab (hai.trans hib))
    · refine ⟨a, Finset.mem_filter.2 ⟨Finset.mem_univ _, ?_⟩⟩
      exact lt_of_le_of_ne (hi_min a (Finset.mem_univ a))
        (fun hia => hai hia.symm)
  obtain ⟨j, hj_mem, hj_min⟩ := Finset.exists_min_image
    (Finset.univ.filter fun k => f i < f k) f habove_nonempty
  have hij : f i < f j := (Finset.mem_filter.1 hj_mem).2
  refine ⟨i, j, hij, fun k hk => ?_⟩
  have hk_mem : k ∈ Finset.univ.filter fun x => f i < f x :=
    Finset.mem_filter.2 ⟨Finset.mem_univ _, hk.1⟩
  exact (not_lt_of_ge (hj_min k hk_mem)) hk.2

end AdjacentValues

/-- The rational-speed-span specialization with the adjacent pair already
selected.  This conclusion supplies exactly the ordering hypotheses consumed
by `bhk_adjacentRatioCombination`. -/
theorem exists_rationalSpan_dual_with_adjacent_ratios {m : ℕ}
    [Nonempty (Fin m)] (u : Fin m → ℝ)
    (hfinrank : 2 ≤ Module.finrank ℚ (rationalSpan u))
    (phi : Module.Dual ℚ (rationalSpan u))
    (hphi : ∀ i, phi (velocityInRationalSpan u i) ≠ 0) :
    ∃ psi : Module.Dual ℚ (rationalSpan u), ∃ i j : Fin m,
      psi (velocityInRationalSpan u i) / phi (velocityInRationalSpan u i) <
          psi (velocityInRationalSpan u j) / phi (velocityInRationalSpan u j) ∧
        ∀ k, ¬
          (psi (velocityInRationalSpan u i) / phi (velocityInRationalSpan u i) <
              psi (velocityInRationalSpan u k) / phi (velocityInRationalSpan u k) ∧
            psi (velocityInRationalSpan u k) / phi (velocityInRationalSpan u k) <
              psi (velocityInRationalSpan u j) / phi (velocityInRationalSpan u j)) := by
  obtain ⟨psi, a, b, hab⟩ :=
    exists_rationalSpan_dual_with_nonconstant_ratios u hfinrank phi hphi
  obtain ⟨i, j, hij, hadjacent⟩ := exists_adjacent_pair_of_nonconstant
    (fun k => psi (velocityInRationalSpan u k) / phi (velocityInRationalSpan u k))
    ⟨a, b, hab⟩
  exact ⟨psi, i, j, hij, hadjacent⟩

end LonelyRunner
