import LonelyRunner.StructuredClasses
import Mathlib.Data.Finset.Card

/-!
# Modular pivot residues

This file formalizes the residue model behind the modular-pivot certificates.
For a denominator `M`, `cyclicResidueDistance M x` is the shorter of the two
integer distances from `x % M` to zero.  For pivot speed `a`, the candidate
residues are `0 ≤ r < N * a` with `N ∤ r`; the pivot coordinate is therefore
good.  A coordinate is bad only when its cyclic residue distance is *strictly*
less than `a`, so equality at the Lonely Runner boundary remains good.
-/

namespace LonelyRunner

open Finset

/-- Shorter cyclic distance of the residue of `x` modulo `M` from zero. -/
def cyclicResidueDistance (M x : ℕ) : ℕ :=
  min (x % M) (M - x % M)

/-- Candidate pivot residues below `N * a` which are not divisible by `N`. -/
def pivotCandidates (N a : ℕ) : Finset ℕ :=
  (Finset.range (N * a)).filter fun r => ¬N ∣ r

/-- Residues at which speed `other` misses the closed target band for pivot
speed `pivot`.  The ambient candidate filter is included so every bad set is
automatically a subset of `pivotCandidates`. -/
def pivotBadResidues (N pivot other : ℕ) : Finset ℕ :=
  (pivotCandidates N pivot).filter fun r =>
    cyclicResidueDistance (N * pivot) (r * other) < pivot

theorem mem_pivotCandidates {N a r : ℕ} :
    r ∈ pivotCandidates N a ↔ r < N * a ∧ ¬N ∣ r := by
  simp [pivotCandidates]

theorem mem_pivotBadResidues {N pivot other r : ℕ} :
    r ∈ pivotBadResidues N pivot other ↔
      r ∈ pivotCandidates N pivot ∧
        cyclicResidueDistance (N * pivot) (r * other) < pivot := by
  simp [pivotBadResidues]

theorem pivotBadResidues_subset (N pivot other : ℕ) :
    pivotBadResidues N pivot other ⊆ pivotCandidates N pivot := by
  exact Finset.filter_subset _ _

/-- The multiples of a positive `N` below `N * a` are precisely
`N * q` for `q < a`. -/
theorem filter_range_dvd_eq_image (N a : ℕ) (hN : 0 < N) :
    (Finset.range (N * a)).filter (fun r => N ∣ r) =
      (Finset.range a).image (fun q => N * q) := by
  ext r
  simp only [Finset.mem_filter, Finset.mem_range, Finset.mem_image]
  constructor
  · rintro ⟨hr, ⟨q, rfl⟩⟩
    refine ⟨q, ?_, rfl⟩
    exact (Nat.mul_lt_mul_left hN).mp (by simpa [Nat.mul_comm] using hr)
  · rintro ⟨q, hq, rfl⟩
    constructor
    · exact (Nat.mul_lt_mul_left hN).mpr (by simpa [Nat.mul_comm] using hq)
    · exact dvd_mul_right N q

/-- Exactly `(N - 1) * a` pivot candidates remain.  The theorem also covers
`a = 0`; only positivity of `N` is needed. -/
theorem card_pivotCandidates (N a : ℕ) (hN : 0 < N) :
    (pivotCandidates N a).card = (N - 1) * a := by
  classical
  have himage : ((Finset.range a).image (fun q => N * q)).card = a := by
    rw [Finset.card_image_iff.mpr]
    · simp
    · intro x hx y hy hxy
      exact Nat.mul_left_cancel hN hxy
  have hsplit := Finset.card_filter_add_card_filter_not
    (s := Finset.range (N * a)) (p := fun r => N ∣ r)
  have hmult : ((Finset.range (N * a)).filter (fun r => N ∣ r)).card = a := by
    rw [filter_range_dvd_eq_image N a hN, himage]
  have hcand : a + (pivotCandidates N a).card = N * a := by
    simpa only [pivotCandidates, hmult, Finset.card_range] using hsplit
  have hprod : N * a = a + (N - 1) * a := by
    calc
      N * a = ((N - 1) + 1) * a := by
        congr 1
        exact (Nat.sub_add_cancel hN).symm
      _ = a + (N - 1) * a := by
        rw [Nat.add_mul, Nat.one_mul, Nat.add_comm]
  rw [hprod] at hcand
  exact Nat.add_left_cancel hcand

/-- A positive residue modulo `M` is at cyclic distance at least one. -/
theorem one_le_cyclicResidueDistance_of_mod_ne_zero {M x : ℕ}
    (hM : 0 < M) (hx : x % M ≠ 0) :
    1 ≤ cyclicResidueDistance M x := by
  unfold cyclicResidueDistance
  have hremPos : 1 ≤ x % M := Nat.one_le_iff_ne_zero.mpr hx
  have hremLt : x % M < M := Nat.mod_lt x hM
  omega

/-- Arithmetic residue bands imply the corresponding closed circle-distance
bound.  This is the reusable bridge between an exact natural-number
certificate and the real unit-circle model. -/
theorem circleNorm_nat_div_ge {M x b : ℕ} (hM : 0 < M)
    (hb : b ≤ cyclicResidueDistance M x) :
    ((b : ℝ) / (M : ℝ)) ≤ circleNorm ((x : ℝ) / (M : ℝ)) := by
  have hMreal : (0 : ℝ) < (M : ℝ) := by exact_mod_cast hM
  have hremLt : x % M < M := Nat.mod_lt x hM
  have hbLower : b ≤ x % M := hb.trans (min_le_left _ _)
  have hbUpper : b ≤ M - x % M := hb.trans (min_le_right _ _)
  have hxDecomp : (x : ℝ) / (M : ℝ) =
      (x / M : ℕ) + ((x % M : ℕ) : ℝ) / (M : ℝ) := by
    have hxnat : M * (x / M) + x % M = x := Nat.div_add_mod x M
    have hxcast : (x : ℝ) =
        (M : ℝ) * ((x / M : ℕ) : ℝ) + ((x % M : ℕ) : ℝ) := by
      exact_mod_cast hxnat.symm
    calc
      (x : ℝ) / (M : ℝ) =
          ((M : ℝ) * ((x / M : ℕ) : ℝ) + ((x % M : ℕ) : ℝ)) /
            (M : ℝ) := by rw [hxcast]
      _ = (x / M : ℕ) + ((x % M : ℕ) : ℝ) / (M : ℝ) := by
        field_simp
  have hδ0 : (0 : ℝ) ≤ (b : ℝ) / (M : ℝ) := by positivity
  have hδhalf : (b : ℝ) / (M : ℝ) ≤ (1 : ℝ) / 2 := by
    have htwob : 2 * b ≤ M := by
      have := Nat.add_le_add hbLower hbUpper
      omega
    have htwobReal : (2 : ℝ) * (b : ℝ) ≤ (M : ℝ) := by exact_mod_cast htwob
    rw [div_le_iff₀ hMreal]
    nlinarith
  refine circleNorm_ge_of_int_band (Int.ofNat (x / M))
    ((x : ℝ) / (M : ℝ)) ((b : ℝ) / (M : ℝ)) hδ0 hδhalf ?_ ?_
  · rw [hxDecomp]
    change ((x / M : ℕ) : ℝ) + (b : ℝ) / (M : ℝ) ≤
      ((x / M : ℕ) : ℝ) + ((x % M : ℕ) : ℝ) / (M : ℝ)
    have hbLowerReal : (b : ℝ) ≤ ((x % M : ℕ) : ℝ) := by exact_mod_cast hbLower
    have hfracLower := (div_le_div_iff_of_pos_right hMreal).mpr hbLowerReal
    linarith
  · rw [hxDecomp]
    change ((x / M : ℕ) : ℝ) + ((x % M : ℕ) : ℝ) / (M : ℝ) ≤
      ((x / M : ℕ) : ℝ) + 1 - (b : ℝ) / (M : ℝ)
    have hsum : ((x % M : ℕ) : ℝ) + (b : ℝ) ≤ (M : ℝ) := by
      exact_mod_cast (by omega : x % M + b ≤ M)
    have hfrac : ((x % M : ℕ) : ℝ) / (M : ℝ) +
        (b : ℝ) / (M : ℝ) ≤ 1 := by
      rw [← add_div]
      exact (div_le_one hMreal).mpr hsum
    linarith

/-- Exact circle distance for a natural rational phase.  This complements
`circleNorm_nat_div_ge`: the cyclic residue model is not merely a sufficient
lower bound, but computes the unit-circle norm exactly. -/
theorem circleNorm_nat_div_eq (M x : ℕ) :
    circleNorm ((x : ℝ) / (M : ℝ)) =
      (cyclicResidueDistance M x : ℝ) / (M : ℝ) := by
  simpa [circleNorm, cyclicResidueDistance] using
    (AddCircle.norm_div_natCast (p := (1 : ℝ)) (m := x) (n := M))

/-- At a fixed candidate residue, membership in a coordinate's strict bad set
is exactly failure of the corresponding closed Lonely Runner inequality. -/
theorem mem_pivotBadResidues_iff_circleNorm_lt {N pivot other r : ℕ}
    (hN : 0 < N) (hpivot : 0 < pivot)
    (hr : r ∈ pivotCandidates N pivot) :
    r ∈ pivotBadResidues N pivot other ↔
      circleNorm (((r : ℝ) / ((N * pivot : ℕ) : ℝ)) * (other : ℝ)) <
        (N : ℝ)⁻¹ := by
  have hM : 0 < N * pivot := Nat.mul_pos hN hpivot
  have hMreal : (0 : ℝ) < ((N * pivot : ℕ) : ℝ) := by
    exact_mod_cast hM
  have hphase : ((r * other : ℕ) : ℝ) / ((N * pivot : ℕ) : ℝ) =
      ((r : ℝ) / ((N * pivot : ℕ) : ℝ)) * (other : ℝ) := by
    push_cast
    ring
  have hbound : (pivot : ℝ) / ((N * pivot : ℕ) : ℝ) = (N : ℝ)⁻¹ := by
    have hNreal : (N : ℝ) ≠ 0 := by exact_mod_cast hN.ne'
    have hpivotReal : (pivot : ℝ) ≠ 0 := by exact_mod_cast hpivot.ne'
    push_cast
    field_simp
  rw [mem_pivotBadResidues, and_iff_right hr]
  rw [← hphase, circleNorm_nat_div_eq, ← hbound]
  rw [div_lt_div_iff_of_pos_right hMreal]
  norm_cast

/-- Closed-good counterpart of `mem_pivotBadResidues_iff_circleNorm_lt`.
The strict bad-set boundary is essential: equality at distance `1 / N`
remains a valid Lonely Runner witness. -/
theorem not_mem_pivotBadResidues_iff_circleNorm_ge {N pivot other r : ℕ}
    (hN : 0 < N) (hpivot : 0 < pivot)
    (hr : r ∈ pivotCandidates N pivot) :
    r ∉ pivotBadResidues N pivot other ↔
      (N : ℝ)⁻¹ ≤
        circleNorm (((r : ℝ) / ((N * pivot : ℕ) : ℝ)) * (other : ℝ)) := by
  rw [mem_pivotBadResidues_iff_circleNorm_lt hN hpivot hr]
  exact not_lt

/-- A candidate residue makes the pivot coordinate itself good. -/
theorem pivot_circleNorm_ge {N pivot r : ℕ} (hN : 0 < N)
    (hpivot : 0 < pivot) (hr : r ∈ pivotCandidates N pivot) :
    ((N : ℝ)⁻¹) ≤
      circleNorm (((r : ℝ) / ((N * pivot : ℕ) : ℝ)) * (pivot : ℝ)) := by
  have hmod : r % N ≠ 0 := by
    intro hz
    exact (mem_pivotCandidates.mp hr).2 (Nat.dvd_iff_mod_eq_zero.mpr hz)
  have hcyc : 1 ≤ cyclicResidueDistance N r :=
    one_le_cyclicResidueDistance_of_mod_ne_zero hN hmod
  have hbridge := circleNorm_nat_div_ge hN hcyc
  have hNreal : (N : ℝ) ≠ 0 := by exact_mod_cast hN.ne'
  have hpReal : (pivot : ℝ) ≠ 0 := by exact_mod_cast hpivot.ne'
  have hphase : (((r : ℝ) / ((N * pivot : ℕ) : ℝ)) * (pivot : ℝ)) =
      (r : ℝ) / (N : ℝ) := by
    push_cast
    field_simp
  rw [hphase]
  simpa [one_div] using hbridge

/-- Avoiding a coordinate's strict bad set gives the required closed circle
distance for that coordinate. -/
theorem outside_pivotBadResidues_circleNorm_ge {N pivot other r : ℕ}
    (hN : 0 < N) (hpivot : 0 < pivot)
    (hr : r ∈ pivotCandidates N pivot)
    (hgood : r ∉ pivotBadResidues N pivot other) :
    ((N : ℝ)⁻¹) ≤
      circleNorm (((r : ℝ) / ((N * pivot : ℕ) : ℝ)) * (other : ℝ)) := by
  have hres : pivot ≤ cyclicResidueDistance (N * pivot) (r * other) := by
    by_contra hlt
    exact hgood (mem_pivotBadResidues.mpr ⟨hr, Nat.lt_of_not_ge hlt⟩)
  have hM : 0 < N * pivot := Nat.mul_pos hN hpivot
  have hbridge := circleNorm_nat_div_ge hM hres
  have hNreal : (N : ℝ) ≠ 0 := by exact_mod_cast hN.ne'
  have hpReal : (pivot : ℝ) ≠ 0 := by exact_mod_cast hpivot.ne'
  have hbound : (pivot : ℝ) / ((N * pivot : ℕ) : ℝ) = (N : ℝ)⁻¹ := by
    push_cast
    field_simp
  have hphase : ((r * other : ℕ) : ℝ) / ((N * pivot : ℕ) : ℝ) =
      ((r : ℝ) / ((N * pivot : ℕ) : ℝ)) * (other : ℝ) := by
    push_cast
    ring
  rw [hbound, hphase] at hbridge
  exact hbridge

/-- Complete modular-pivot witness bridge for a positive natural speed family.
The pivot is handled by candidate membership; every other coordinate is
handled by avoiding its strict bad set. -/
theorem pivotResidueWitness {n N : ℕ} (speeds : Fin n → ℕ) (pivot : Fin n)
    (hN : 0 < N) (hspeeds : ∀ i, 0 < speeds i)
    (r : ℕ) (hr : r ∈ pivotCandidates N (speeds pivot))
    (havoid : ∀ i, i ≠ pivot →
      r ∉ pivotBadResidues N (speeds pivot) (speeds i)) :
    ∀ i, ((N : ℝ)⁻¹) ≤
      circleNorm (((r : ℝ) / ((N * speeds pivot : ℕ) : ℝ)) * (speeds i : ℝ)) := by
  intro i
  by_cases hi : i = pivot
  · subst i
    exact pivot_circleNorm_ge hN (hspeeds pivot) hr
  · exact outside_pivotBadResidues_circleNorm_ge hN (hspeeds pivot) hr (havoid i hi)

end LonelyRunner
