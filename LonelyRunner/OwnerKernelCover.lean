import LonelyRunner.PivotZeroKernel
import LonelyRunner.KernelCoverCertificates

/-!
# Pivot-row zero-kernel cover adapters

This module instantiates the labelled finite-family certificate with literal
pivot bad sets and their zero-product kernels.  Labels need not be distinct
and no cardinality or injectivity premise is imposed on the speed map.
-/

namespace LonelyRunner

open Finset

/-- A labelled family of genuine lower speeds cannot cover a pivot candidate
row when its zero kernels are dominated by representatives in `E` and the
reviewed numerical budget holds. -/
theorem exists_pivotCandidate_avoiding_ownerKernel_family
    {ι : Type*} [DecidableEq ι] (N p : ℕ) (C E : Finset ι) (d : ι → ℕ)
    (hN : 3 ≤ N) (hp : 0 < p)
    (hd : ∀ i ∈ C, 0 < d i) (hdp : ∀ i ∈ C, d i < p)
    (hEsub : E ⊆ C)
    (hdom : ∀ i ∈ C, (pivotZeroResidues N p (d i)).Nonempty →
      ∃ j ∈ E, pivotZeroResidues N p (d i) ⊆ pivotZeroResidues N p (d j))
    (hnum : 2 * (N + 1) * C.card + (N - 2) * E.card ≤ N * (N + 1)) :
    ∃ r ∈ pivotCandidates N p, ∀ i ∈ C, r ∉ pivotBadResidues N p (d i) := by
  classical
  let A := (N - 1) * p
  let R := pivotCandidates N p
  let B : ι → Finset ℕ := fun i => pivotBadResidues N p (d i)
  let Z : ι → Finset ℕ := fun i => pivotZeroResidues N p (d i)
  have hNpos : 0 < N := by omega
  have hA : A = R.card := by
    dsimp [A, R]
    exact (card_pivotCandidates N p hNpos).symm
  have hRpos : 0 < R.card := by
    rw [← hA]
    exact Nat.mul_pos (by omega) hp
  have hBsub : ∀ i ∈ C, B i ⊆ R := by
    intro i hi
    exact pivotBadResidues_subset N p (d i)
  have hZsub : ∀ i ∈ C, Z i ⊆ B i := by
    intro i hi
    exact pivotZeroResidues_subset_pivotBadResidues N p (d i) hp
  have hscalar : ∀ i ∈ C,
      N * (B i).card ≤ 2 * A + (N - 2) * (Z i).card := by
    intro i hi
    have hbound := pivotBadResidues_ownerKernel_bound N p (d i)
      (by omega) hp (hd i hi) (hdp i hi)
    rw [← card_pivotZeroResidues N p (d i) hNpos hp] at hbound
    simpa [A, B, Z, Nat.mul_assoc] using hbound
  have hcapacity : ∀ i ∈ C, (N + 1) * (Z i).card ≤ A := by
    intro i hi
    have hbound := pivotZeroResidues_capacity N p (d i)
      (by omega) hp (hd i hi) (hdp i hi)
    simpa [A, Z] using hbound
  have hdom' : ∀ i ∈ C, (Z i).Nonempty → ∃ j ∈ E, Z i ⊆ Z j := by
    intro i hi hnonempty
    simpa [Z] using hdom i hi hnonempty
  -- The generic theorem handles an empty label family itself.  The common
  -- pair is supplied pointwise below, so no arbitrary label is selected.
  have hxy : (1 : ℕ) ≠ N * p - 1 := by
    have : 3 ≤ N * p := by nlinarith
    omega
  apply exists_candidate_avoiding_kernel_family N A R C E B Z hN hA hRpos
    hEsub hBsub hZsub hscalar hcapacity hdom' 1 (N * p - 1) hxy
  · intro i hi
    have hpair := one_and_last_mem_pivotBadResidues_sdiff_pivotZeroResidues N p
      (d i) hN hp (hd i hi) (hdp i hi)
    exact ⟨hpair.1, hpair.2.1⟩
  · simpa [A] using hnum

/-- A gcd-divisibility formulation of zero-kernel domination. -/
theorem exists_pivotCandidate_avoiding_ownerKernel_family_of_gcd_dvd
    {ι : Type*} [DecidableEq ι] (N p : ℕ) (C E : Finset ι) (d : ι → ℕ)
    (hN : 3 ≤ N) (hp : 0 < p)
    (hd : ∀ i ∈ C, 0 < d i) (hdp : ∀ i ∈ C, d i < p)
    (hEsub : E ⊆ C)
    (hdom : ∀ i ∈ C, (pivotZeroResidues N p (d i)).Nonempty →
      ∃ j ∈ E, Nat.gcd (d i) (N * p) ∣ Nat.gcd (d j) (N * p))
    (hnum : 2 * (N + 1) * C.card + (N - 2) * E.card ≤ N * (N + 1)) :
    ∃ r ∈ pivotCandidates N p, ∀ i ∈ C, r ∉ pivotBadResidues N p (d i) := by
  apply exists_pivotCandidate_avoiding_ownerKernel_family N p C E d hN hp hd hdp hEsub
    (fun i hi hnonempty => by
      rcases hdom i hi hnonempty with ⟨j, hj, hdvd⟩
      exact ⟨j, hj, pivotZeroResidues_subset_of_gcd_dvd N p (d i) (d j) hdvd⟩) hnum

/-- The residue supplied by the kernel-family certificate gives a closed
circle-distance witness simultaneously for the pivot speed and every labelled
lower speed. -/
theorem exists_ownerKernel_circleNorm_witness
    {ι : Type*} [DecidableEq ι] (N p : ℕ) (C E : Finset ι) (d : ι → ℕ)
    (hN : 3 ≤ N) (hp : 0 < p)
    (hd : ∀ i ∈ C, 0 < d i) (hdp : ∀ i ∈ C, d i < p)
    (hEsub : E ⊆ C)
    (hdom : ∀ i ∈ C, (pivotZeroResidues N p (d i)).Nonempty →
      ∃ j ∈ E, pivotZeroResidues N p (d i) ⊆ pivotZeroResidues N p (d j))
    (hnum : 2 * (N + 1) * C.card + (N - 2) * E.card ≤ N * (N + 1)) :
    ∃ r ∈ pivotCandidates N p,
      ((N : ℝ)⁻¹) ≤ circleNorm (((r : ℝ) / ((N * p : ℕ) : ℝ)) * (p : ℝ)) ∧
      ∀ i ∈ C, ((N : ℝ)⁻¹) ≤
        circleNorm (((r : ℝ) / ((N * p : ℕ) : ℝ)) * (d i : ℝ)) := by
  rcases exists_pivotCandidate_avoiding_ownerKernel_family N p C E d hN hp hd hdp
    hEsub hdom hnum with ⟨r, hr, havoid⟩
  refine ⟨r, hr, pivot_circleNorm_ge (by omega) hp hr, ?_⟩
  intro i hi
  exact outside_pivotBadResidues_circleNorm_ge (by omega) hp hr (havoid i hi)

end LonelyRunner
