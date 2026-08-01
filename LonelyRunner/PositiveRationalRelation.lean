import LonelyRunner.RationalRelationSpace
import Mathlib.Topology.Algebra.Order.Archimedean
import Mathlib.Topology.Constructions
import Mathlib.Topology.Instances.Real.Lemmas
import Mathlib.Topology.NhdsWithin

noncomputable section

open Finset Set
open scoped BigOperators

namespace LonelyRunner

/--
Positive real velocities yield a positive rational vector satisfying every integer
linear relation satisfied by the velocities.

The proof writes the velocities in a rational basis.  The actual real values of the
basis vectors give coefficients whose rational-row combination is positive.  This
condition is an open subset of the finite real coefficient space, so density of
rational coefficient vectors supplies rational coefficients with the same property.
-/
theorem exists_positive_rational_of_integer_relations {m : ℕ} (u : Fin m → ℝ)
    (hu : ∀ i, 0 < u i) :
    ∃ r : Fin m → ℚ,
      (∀ i, 0 < r i) ∧
      ∀ a : Fin m → ℤ,
        (∑ i, (a i : ℝ) * u i = 0) →
          ∑ i, (a i : ℚ) * r i = 0 := by
  let n := Module.finrank ℚ (rationalSpan u)
  let positiveCoefficients : Set (Fin n → ℝ) :=
    {d | ∀ i, 0 < ∑ k, d k * (rationalRow u k i : ℝ)}
  have hopen : IsOpen positiveCoefficients := by
    rw [show positiveCoefficients = ⋂ i : Fin m,
        {d : Fin n → ℝ | 0 < ∑ k, d k * (rationalRow u k i : ℝ)} by
      ext d
      simp [positiveCoefficients]]
    apply isOpen_iInter_of_finite
    intro i
    apply isOpen_lt continuous_const
    exact continuous_finsetSum _ fun k _ =>
      (continuous_apply k).mul continuous_const
  let actualCoefficients : Fin n → ℝ :=
    fun k => ((rationalBasis u k : rationalSpan u) : ℝ)
  have hactual : actualCoefficients ∈ positiveCoefficients := by
    intro i
    rw [show (∑ k, actualCoefficients k * (rationalRow u k i : ℝ)) = u i by
      simpa [actualCoefficients, mul_comm] using (velocity_reconstruction u i).symm]
    exact hu i
  have hdense : DenseRange
      (Pi.map (fun _ : Fin n => ((↑) : ℚ → ℝ))) :=
    DenseRange.piMap fun _ => Rat.denseRange_cast
  obtain ⟨q, hq⟩ := hdense.exists_mem_open hopen ⟨actualCoefficients, hactual⟩
  let r : Fin m → ℚ := fun i => ∑ k, q k * rationalRow u k i
  refine ⟨r, ?_, ?_⟩
  · intro i
    have hqi : 0 < ∑ k, (q k : ℝ) * (rationalRow u k i : ℝ) := hq i
    exact_mod_cast hqi
  · intro a ha
    calc
      ∑ i, (a i : ℚ) * r i =
          ∑ k, q k * ∑ i, (a i : ℚ) * rationalRow u k i := by
            simp only [r, mul_sum]
            rw [Finset.sum_comm]
            apply Finset.sum_congr rfl
            intro k hk
            apply Finset.sum_congr rfl
            intro i hi
            ring
      _ = 0 := by
        simp [integer_relation_annihilates_row u a ha]

end LonelyRunner
