import LonelyRunner.BHKBridgeAssembly
import LonelyRunner.KroneckerSeparation
import LonelyRunner.RationalReduction

/-!
# From a rational collision vector to a real stationary witness

This file formalizes the endpoint-safe topological half of the BHK reduction.
A nowhere-zero rational vector with fewer than `m` distinct magnitudes is
solved in its smaller cardinality.  The resulting `1 / (d + 1)` bound is at
least `1 / m`, hence is strictly stronger than the desired `1 / (m + 1)`
bound.  Generalized Kronecker approximation and openness then turn the target
point into an actual point of the original real orbit.
-/

namespace LonelyRunner

noncomputable section

open Finset Set
open scoped BigOperators

/-- A compatible rational collision vector converts the all-dimensional
positive-rational conjecture into a witness for the given real tuple. -/
theorem exists_stationaryWitness_of_rational_collision {m : ℕ}
    (hm : 2 ≤ m) (u : Fin m → ℝ) (w : Fin m → ℚ)
    (hwzero : ∀ i, w i ≠ 0)
    (hcard : (Finset.univ.image (fun i => |w i|)).card < m)
    (hrelations : ∀ a : Fin m → ℤ,
      (∑ i, (a i : ℝ) * u i = 0) →
        ∑ i, (a i : ℝ) * (w i : ℝ) = 0)
    (hRational : PositiveRationalConjecture) :
    ∃ time : ℝ, ∀ i,
      (((m + 1 : ℕ) : ℝ)⁻¹) ≤ circleNorm (time * u i) := by
  classical
  let magnitudes : Finset ℚ := Finset.univ.image fun i => |w i|
  let d : ℕ := magnitudes.card
  let enumerate : Fin d ≃ {q : ℚ // q ∈ magnitudes} :=
    by simpa [d] using (Fintype.equivFin {q : ℚ // q ∈ magnitudes}).symm
  let rationalSpeeds : Fin d → ℚ := fun j => (enumerate j : ℚ)
  have hmpos : 0 < m := lt_of_lt_of_le (by omega) hm
  let first : Fin m := ⟨0, hmpos⟩
  have hmagnitudes : magnitudes.Nonempty := by
    refine ⟨|w first|, ?_⟩
    exact Finset.mem_image.mpr ⟨first, Finset.mem_univ _, rfl⟩
  have hdpos : 1 ≤ d := by
    exact (Finset.card_pos.mpr hmagnitudes)
  have hdlt : d < m := by
    simpa [d, magnitudes] using hcard
  have hrationalPos : ∀ j, 0 < rationalSpeeds j := by
    intro j
    have hjmem : (enumerate j : ℚ) ∈ magnitudes := (enumerate j).property
    rcases Finset.mem_image.mp hjmem with ⟨i, _hi, habs⟩
    change 0 < (enumerate j : ℚ)
    rw [← habs]
    exact abs_pos.mpr (hwzero i)
  obtain ⟨τ, hτ⟩ :=
    hRational d hdpos rationalSpeeds hrationalPos
  have hmRealPos : (0 : ℝ) < m := by exact_mod_cast hmpos
  have hmSuccRealPos : (0 : ℝ) < ((m + 1 : ℕ) : ℝ) := by positivity
  have hdSuccLe : d + 1 ≤ m := by omega
  have hdSuccRealPos : (0 : ℝ) < ((d + 1 : ℕ) : ℝ) := by positivity
  have htargetStrict : ∀ i,
      (((m + 1 : ℕ) : ℝ)⁻¹) < circleNorm (τ * (w i : ℝ)) := by
    intro i
    let occurrence : {q : ℚ // q ∈ magnitudes} :=
      ⟨|w i|, Finset.mem_image.mpr ⟨i, Finset.mem_univ _, rfl⟩⟩
    let j : Fin d := enumerate.symm occurrence
    have hspeed : rationalSpeeds j = |w i| := by
      change (enumerate (enumerate.symm occurrence) : ℚ) = |w i|
      simp [occurrence]
    have hmiddle : ((m : ℝ)⁻¹) ≤ (((d + 1 : ℕ) : ℝ)⁻¹) := by
      apply inv_anti₀ hdSuccRealPos
      exact_mod_cast hdSuccLe
    have hstrict : ((((m + 1 : ℕ) : ℝ))⁻¹) < (m : ℝ)⁻¹ := by
      apply (inv_lt_inv₀ hmSuccRealPos hmRealPos).2
      exact_mod_cast Nat.lt_succ_self m
    calc
      (((m + 1 : ℕ) : ℝ)⁻¹) < (m : ℝ)⁻¹ := hstrict
      _ ≤ (((d + 1 : ℕ) : ℝ)⁻¹) := hmiddle
      _ ≤ circleNorm (τ * (rationalSpeeds j : ℝ)) := hτ j
      _ = circleNorm (τ * |(w i : ℝ)|) := by
        rw [hspeed]
        norm_cast
      _ = circleNorm (τ * (w i : ℝ)) := circleNorm_mul_abs_right τ (w i : ℝ)
  let c : ℝ := (((m + 1 : ℕ) : ℝ)⁻¹)
  let good : Set (UnitAddTorus (Fin m)) := {x | ∀ i, c < ‖x i‖}
  have hopen : IsOpen good := by
    rw [show good = ⋂ i : Fin m, {x | c < ‖x i‖} by
      ext x
      simp [good]]
    apply isOpen_iInter_of_finite
    intro i
    exact isOpen_lt continuous_const (continuous_apply i).norm
  let wReal : Fin m → ℝ := fun i => (w i : ℝ)
  have htargetGood : orbitHom wReal τ ∈ good := by
    intro i
    change c < ‖((τ * wReal i : ℝ) : UnitAddCircle)‖
    simpa [c, wReal, circleNorm] using htargetStrict i
  have htargetClosure : orbitHom wReal τ ∈ closure (Set.range (orbitHom u)) :=
    orbitHom_mem_closure_range_of_relations u wReal τ hrelations
  obtain ⟨x, hxgood, hxrange⟩ :=
    (mem_closure_iff.mp htargetClosure) good hopen htargetGood
  rcases hxrange with ⟨time, rfl⟩
  refine ⟨time, fun i => le_of_lt ?_⟩
  have hi := hxgood i
  simpa [good, c, circleNorm] using hi

end

end LonelyRunner
