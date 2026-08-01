import LonelyRunner.PivotResidues
import LonelyRunner.Formulations
import Mathlib.Topology.Order.IntermediateValue

/-!
# Boundary pivots

This file isolates the topological boundary argument behind pivot-grid
completeness.  It is intentionally not imported by the root module until the
argument has been independently audited.
-/

namespace LonelyRunner

/-- The distance-to-the-nearest-integer function is continuous. -/
theorem continuous_circleNorm : Continuous circleNorm := by
  apply (show LipschitzWith 1 circleNorm from ?_).continuous
  rw [lipschitzWith_iff_dist_le_mul]
  intro x y
  simpa [Real.dist_eq] using abs_circleNorm_sub_circleNorm_le x y

/-- The least circle distance attained by a nonempty finite speed family.
The anchor supplies nonemptiness and has no mathematical effect. -/
noncomputable def minimumCircleNorm {n : ℕ} (speeds : Fin n → ℝ)
    (anchor : Fin n) (time : ℝ) : ℝ :=
  Finset.univ.inf' ⟨anchor, Finset.mem_univ anchor⟩ fun i =>
    circleNorm (time * speeds i)

private theorem continuous_finset_inf' {ι X : Type*} [TopologicalSpace X]
    (s : Finset ι) (hs : s.Nonempty) (f : ι → X → ℝ)
    (hf : ∀ i ∈ s, Continuous (f i)) :
    Continuous fun x => s.inf' hs fun i => f i x := by
  classical
  induction s using Finset.induction_on with
  | empty => simp at hs
  | @insert a s ha ih =>
      by_cases hsn : s.Nonempty
      · simpa only [Finset.inf'_insert hsn] using
          (hf a (by simp)).min
            (ih hsn fun i hi => hf i (Finset.mem_insert_of_mem hi))
      · have hsempty : s = ∅ := Finset.not_nonempty_iff_eq_empty.mp hsn
        subst s
        simpa using hf a (by simp)

theorem continuous_minimumCircleNorm {n : ℕ} (speeds : Fin n → ℝ)
    (anchor : Fin n) : Continuous (minimumCircleNorm speeds anchor) := by
  apply continuous_finset_inf'
  intro i _
  exact continuous_circleNorm.comp (continuous_id.mul continuous_const)

theorem minimumCircleNorm_le {n : ℕ} (speeds : Fin n → ℝ)
    (anchor i : Fin n) (time : ℝ) :
    minimumCircleNorm speeds anchor time ≤ circleNorm (time * speeds i) := by
  exact Finset.inf'_le _ (Finset.mem_univ i)

theorem le_minimumCircleNorm {n : ℕ} (speeds : Fin n → ℝ)
    (anchor : Fin n) (time lower : ℝ)
    (h : ∀ i, lower ≤ circleNorm (time * speeds i)) :
    lower ≤ minimumCircleNorm speeds anchor time := by
  apply Finset.le_inf'
  intro i _
  exact h i

theorem minimumCircleNorm_zero {n : ℕ} (speeds : Fin n → ℝ)
    (anchor : Fin n) : minimumCircleNorm speeds anchor 0 = 0 := by
  apply le_antisymm
  · simpa [circleNorm] using minimumCircleNorm_le speeds anchor anchor 0
  · apply le_minimumCircleNorm
    intro i
    simp [circleNorm]

theorem exists_eq_minimumCircleNorm {n : ℕ} (speeds : Fin n → ℝ)
    (anchor : Fin n) (time : ℝ) :
    ∃ i, circleNorm (time * speeds i) = minimumCircleNorm speeds anchor time := by
  let values : Set ℝ := Set.range fun i : Fin n => circleNorm (time * speeds i)
  have hclosed : ∀ x ∈ values, ∀ y ∈ values, min x y ∈ values := by
    rintro x ⟨i, rfl⟩ y ⟨j, rfl⟩
    by_cases hle : circleNorm (time * speeds i) ≤ circleNorm (time * speeds j)
    · exact ⟨i, min_eq_left hle |>.symm⟩
    · exact ⟨j, min_eq_right (le_of_not_ge hle) |>.symm⟩
  have hmem : minimumCircleNorm speeds anchor time ∈ values := by
    exact Finset.inf'_mem values hclosed Finset.univ
      ⟨anchor, Finset.mem_univ anchor⟩
      (fun i => circleNorm (time * speeds i))
      (fun i _ => ⟨i, rfl⟩)
  rcases hmem with ⟨i, hi⟩
  exact ⟨i, hi⟩

/-- Any finite nonempty family that is simultaneously at closed distance at
least `δ` at some time has a (possibly earlier, along the straight segment
from zero) safe time at which one coordinate is exactly on the boundary.

This is the topology-only core of boundary-pivot completeness. -/
theorem exists_boundary_witness {n : ℕ} (speeds : Fin n → ℝ)
    (anchor : Fin n) (δ witness : ℝ) (hδ : 0 ≤ δ)
    (hwitness : ∀ i, δ ≤ circleNorm (witness * speeds i)) :
    ∃ time : ℝ,
      (∀ i, δ ≤ circleNorm (time * speeds i)) ∧
      ∃ pivot, circleNorm (time * speeds pivot) = δ := by
  let margin : ℝ → ℝ := fun s => minimumCircleNorm speeds anchor (s * witness)
  have hmargin : Continuous margin := by
    exact (continuous_minimumCircleNorm speeds anchor).comp
      (continuous_id.mul continuous_const)
  have hzero : margin 0 = 0 := by
    simpa [margin] using minimumCircleNorm_zero speeds anchor
  have hone : δ ≤ margin 1 := by
    dsimp [margin]
    simpa using le_minimumCircleNorm speeds anchor witness δ hwitness
  have hδrange : δ ∈ Set.Icc (margin 0) (margin 1) := by
    constructor
    · simpa [hzero] using hδ
    · exact hone
  obtain ⟨s, hs, hmarginEq⟩ :=
    intermediate_value_Icc (show (0 : ℝ) ≤ 1 by norm_num)
      hmargin.continuousOn hδrange
  refine ⟨s * witness, ?_, ?_⟩
  · intro i
    rw [← hmarginEq]
    exact minimumCircleNorm_le speeds anchor i (s * witness)
  · obtain ⟨pivot, hpivot⟩ :=
      exists_eq_minimumCircleNorm speeds anchor (s * witness)
    exact ⟨pivot, hpivot.trans hmarginEq⟩

/-- Boundary-pivot completeness for positive natural speeds.  The threshold is
`1 / N`; `N ≥ 2` includes the antipodal endpoint `N = 2` without a separate
argument. -/
theorem exists_boundary_pivot_nat {n N : ℕ} (speeds : Fin n → ℕ)
    (anchor : Fin n) (hN : 2 ≤ N) (witness : ℝ)
    (hwitness : ∀ i,
      (N : ℝ)⁻¹ ≤ circleNorm (witness * (speeds i : ℝ))) :
    ∃ time : ℝ,
      (∀ i, (N : ℝ)⁻¹ ≤ circleNorm (time * (speeds i : ℝ))) ∧
      ∃ pivot, circleNorm (time * (speeds pivot : ℝ)) = (N : ℝ)⁻¹ := by
  have hδ : (0 : ℝ) ≤ (N : ℝ)⁻¹ := by positivity
  exact exists_boundary_witness (fun i => (speeds i : ℝ)) anchor
    (N : ℝ)⁻¹ witness hδ hwitness

/-- An exact pivot boundary for a positive natural speed lies on one of the
two signed `N * pivot` grids.  This is the arithmetic half of the usual
boundary-pivot reduction; reducing the signed numerator modulo `N * pivot`
is deliberately kept separate from the topological theorem above. -/
theorem boundary_time_eq_signed_grid {N pivot : ℕ} (hN : 0 < N)
    (hpivot : 0 < pivot) (time : ℝ)
    (hboundary :
      circleNorm (time * (pivot : ℝ)) = (N : ℝ)⁻¹) :
    ∃ q ε : ℤ, (ε = 1 ∨ ε = -1) ∧
      time = (((N : ℤ) * q + ε : ℤ) : ℝ) /
        ((N * pivot : ℕ) : ℝ) := by
  have hNreal : (N : ℝ) ≠ 0 := by exact_mod_cast hN.ne'
  have hpivotReal : (pivot : ℝ) ≠ 0 := by exact_mod_cast hpivot.ne'
  have hden : ((N * pivot : ℕ) : ℝ) ≠ 0 := by positivity
  rw [circleNorm_eq_abs_sub_round] at hboundary
  have hinvNonneg : (0 : ℝ) ≤ (N : ℝ)⁻¹ := by positivity
  rcases (abs_eq hinvNonneg).mp hboundary with hplus | hminus
  · refine ⟨round (time * (pivot : ℝ)), 1, Or.inl rfl, ?_⟩
    apply (eq_div_iff hden).2
    push_cast
    field_simp [hNreal] at hplus
    nlinarith
  · refine ⟨round (time * (pivot : ℝ)), -1, Or.inr rfl, ?_⟩
    apply (eq_div_iff hden).2
    push_cast
    field_simp [hNreal] at hminus
    nlinarith

/-- Taking the fractional part of time preserves every natural-speed circle
phase.  This puts a boundary witness in `[0,1)` before its signed numerator is
converted to the canonical natural residue. -/
theorem circleNorm_fract_mul_nat (time : ℝ) (speed : ℕ) :
    circleNorm (Int.fract time * (speed : ℝ)) =
      circleNorm (time * (speed : ℝ)) := by
  have hphase : time * (speed : ℝ) =
      ((⌊time⌋ * (speed : ℤ) : ℤ) : ℝ) +
        Int.fract time * (speed : ℝ) := by
    have hdecomp := Int.floor_add_fract time
    push_cast
    nlinarith
  rw [hphase, circleNorm_add_int]

/-- A safe normalized time with one tight positive natural coordinate yields
an actual member of `pivotCandidates`.  The two signs of the nearest-integer
equation are handled separately; the argument includes `N = 2`. -/
theorem exists_pivot_residue_of_tight_normalized {n N : ℕ}
    (hN : 2 ≤ N) (speeds : Fin n → ℕ) (hspeeds : ∀ i, 0 < speeds i)
    (time : ℝ) (htime0 : 0 ≤ time) (htime1 : time < 1)
    (pivot : Fin n)
    (hgood : ∀ i, ((N : ℝ)⁻¹) ≤
      circleNorm (time * (speeds i : ℝ)))
    (htight : circleNorm (time * (speeds pivot : ℝ)) = (N : ℝ)⁻¹) :
    ∃ r, r ∈ pivotCandidates N (speeds pivot) ∧
      ∀ i, ((N : ℝ)⁻¹) ≤
        circleNorm (((r : ℝ) / ((N * speeds pivot : ℕ) : ℝ)) *
          (speeds i : ℝ)) := by
  let y : ℝ := time * (speeds pivot : ℝ)
  let z : ℤ := round y
  have hNpos : 0 < N := by omega
  have hNreal : (0 : ℝ) < (N : ℝ) := by exact_mod_cast hNpos
  have haReal : (0 : ℝ) < (speeds pivot : ℝ) := by
    exact_mod_cast hspeeds pivot
  have hδ0 : (0 : ℝ) ≤ (N : ℝ)⁻¹ := by positivity
  have habs : |y - (z : ℝ)| = (N : ℝ)⁻¹ := by
    simpa [y, z, circleNorm_eq_abs_sub_round] using htight
  rcases (abs_eq hδ0).mp habs with hplus | hminus
  · let q : ℤ := (N : ℤ) * z + 1
    have hNinv : (N : ℝ) * (N : ℝ)⁻¹ = 1 := by
      exact mul_inv_cancel₀ hNreal.ne'
    have hqPhase : (q : ℝ) = (N : ℝ) * y := by
      dsimp [q]
      push_cast
      nlinarith
    have hy0 : 0 ≤ y := by
      dsimp [y]
      positivity
    have hya : y < (speeds pivot : ℝ) := by
      dsimp [y]
      nlinarith
    have hq0Real : (0 : ℝ) ≤ (q : ℝ) := by rw [hqPhase]; positivity
    have hq0 : (0 : ℤ) ≤ q := by exact_mod_cast hq0Real
    have hqLtReal : (q : ℝ) < ((N * speeds pivot : ℕ) : ℝ) := by
      rw [hqPhase]
      push_cast
      nlinarith
    have hqLt : q < ((N * speeds pivot : ℕ) : ℤ) := by
      exact_mod_cast hqLtReal
    let r : ℕ := q.toNat
    have hrCastInt : (r : ℤ) = q := by
      simpa [r] using Int.toNat_of_nonneg hq0
    have hrCastReal : (r : ℝ) = (q : ℝ) := by exact_mod_cast hrCastInt
    have hrLt : r < N * speeds pivot := by
      exact (Int.toNat_lt hq0).2 hqLt
    have hrNotDvd : ¬N ∣ r := by
      intro hdiv
      have hdivInt : (N : ℤ) ∣ q := by
        rw [← hrCastInt]
        exact_mod_cast hdiv
      have hNz : (N : ℤ) ∣ (N : ℤ) * z := dvd_mul_right _ _
      have honeInt : (N : ℤ) ∣ 1 := by
        have hsub := dvd_sub hdivInt hNz
        simpa [q] using hsub
      have honeNat : N ∣ 1 := by
        exact Int.natCast_dvd_natCast.mp (by simpa using honeInt)
      have : N = 1 := Nat.dvd_one.mp honeNat
      omega
    have hrCandidate : r ∈ pivotCandidates N (speeds pivot) :=
      mem_pivotCandidates.mpr ⟨hrLt, hrNotDvd⟩
    have htimeEq :
        (r : ℝ) / ((N * speeds pivot : ℕ) : ℝ) = time := by
      rw [hrCastReal, hqPhase]
      push_cast
      field_simp
      dsimp [y]
      ring
    refine ⟨r, hrCandidate, ?_⟩
    intro i
    rw [htimeEq]
    exact hgood i
  · let q : ℤ := (N : ℤ) * z - 1
    have hNinv : (N : ℝ) * (N : ℝ)⁻¹ = 1 := by
      exact mul_inv_cancel₀ hNreal.ne'
    have hqPhase : (q : ℝ) = (N : ℝ) * y := by
      dsimp [q]
      push_cast
      nlinarith
    have hy0 : 0 ≤ y := by
      dsimp [y]
      positivity
    have hya : y < (speeds pivot : ℝ) := by
      dsimp [y]
      nlinarith
    have hq0Real : (0 : ℝ) ≤ (q : ℝ) := by rw [hqPhase]; positivity
    have hq0 : (0 : ℤ) ≤ q := by exact_mod_cast hq0Real
    have hqLtReal : (q : ℝ) < ((N * speeds pivot : ℕ) : ℝ) := by
      rw [hqPhase]
      push_cast
      nlinarith
    have hqLt : q < ((N * speeds pivot : ℕ) : ℤ) := by
      exact_mod_cast hqLtReal
    let r : ℕ := q.toNat
    have hrCastInt : (r : ℤ) = q := by
      simpa [r] using Int.toNat_of_nonneg hq0
    have hrCastReal : (r : ℝ) = (q : ℝ) := by exact_mod_cast hrCastInt
    have hrLt : r < N * speeds pivot := by
      exact (Int.toNat_lt hq0).2 hqLt
    have hrNotDvd : ¬N ∣ r := by
      intro hdiv
      have hdivInt : (N : ℤ) ∣ q := by
        rw [← hrCastInt]
        exact_mod_cast hdiv
      have hNz : (N : ℤ) ∣ (N : ℤ) * z := dvd_mul_right _ _
      have honeInt : (N : ℤ) ∣ 1 := by
        have hsub := dvd_sub hNz hdivInt
        simpa [q] using hsub
      have honeNat : N ∣ 1 := by
        exact Int.natCast_dvd_natCast.mp (by simpa using honeInt)
      have : N = 1 := Nat.dvd_one.mp honeNat
      omega
    have hrCandidate : r ∈ pivotCandidates N (speeds pivot) :=
      mem_pivotCandidates.mpr ⟨hrLt, hrNotDvd⟩
    have htimeEq :
        (r : ℝ) / ((N * speeds pivot : ℕ) : ℝ) = time := by
      rw [hrCastReal, hqPhase]
      push_cast
      field_simp
      dsimp [y]
      ring
    refine ⟨r, hrCandidate, ?_⟩
    intro i
    rw [htimeEq]
    exact hgood i

/-- Combined topological and arithmetic boundary-pivot theorem. -/
theorem exists_safe_signed_pivot_grid {n N : ℕ} (speeds : Fin n → ℕ)
    (anchor : Fin n) (hN : 2 ≤ N) (hspeeds : ∀ i, 0 < speeds i)
    (witness : ℝ)
    (hwitness : ∀ i,
      (N : ℝ)⁻¹ ≤ circleNorm (witness * (speeds i : ℝ))) :
    ∃ (pivot : Fin n) (q ε : ℤ) (time : ℝ),
      (ε = 1 ∨ ε = -1) ∧
      time = (((N : ℤ) * q + ε : ℤ) : ℝ) /
        ((N * speeds pivot : ℕ) : ℝ) ∧
      ∀ i, (N : ℝ)⁻¹ ≤ circleNorm (time * (speeds i : ℝ)) := by
  obtain ⟨time, hsafe, pivot, hpivot⟩ :=
    exists_boundary_pivot_nat speeds anchor hN witness hwitness
  obtain ⟨q, ε, hε, htime⟩ :=
    boundary_time_eq_signed_grid (lt_of_lt_of_le Nat.zero_lt_two hN)
      (hspeeds pivot) time hpivot
  exact ⟨pivot, q, ε, time, hε, htime, hsafe⟩

/-- Normalize either signed boundary grid modulo its positive pivot speed.
The resulting natural residue is exactly a `pivotCandidates` member, and the
two real grid times differ by an integer. -/
theorem signed_grid_normalizes_to_pivotCandidate {N pivot : ℕ}
    (hN : 2 ≤ N) (hpivot : 0 < pivot) (q ε : ℤ)
    (hε : ε = 1 ∨ ε = -1) :
    ∃ (r : ℕ) (z : ℤ),
      r ∈ pivotCandidates N pivot ∧
      ((((N : ℤ) * q + ε : ℤ) : ℝ) /
          ((N * pivot : ℕ) : ℝ) =
        (z : ℝ) + (r : ℝ) / ((N * pivot : ℕ) : ℝ)) := by
  have hpivotZ : (pivot : ℤ) ≠ 0 := by exact_mod_cast hpivot.ne'
  have hpivotNat : pivot ≠ 0 := hpivot.ne'
  have hden : ((N * pivot : ℕ) : ℝ) ≠ 0 := by positivity
  rcases hε with rfl | rfl
  · let u : ℕ := q.natMod (pivot : ℤ)
    let z : ℤ := q / (pivot : ℤ)
    let r : ℕ := N * u + 1
    have huLt : u < pivot := by
      exact Int.natMod_lt hpivotNat
    have hremNonneg : 0 ≤ q % (pivot : ℤ) :=
      Int.emod_nonneg q hpivotZ
    have huCast : (u : ℤ) = q % (pivot : ℤ) := by
      exact Int.toNat_of_nonneg hremNonneg
    have hq : z * (pivot : ℤ) + (u : ℤ) = q := by
      simpa [z, huCast] using Int.ediv_mul_add_emod q (pivot : ℤ)
    have hrLt : r < N * pivot := by
      have hmul : N * (u + 1) ≤ N * pivot :=
        Nat.mul_le_mul_left N (Nat.add_one_le_iff.mpr huLt)
      dsimp [r]
      simp only [Nat.mul_add, Nat.mul_one] at hmul
      omega
    have hrNotDvd : ¬N ∣ r := by
      intro hd
      have hd1 : N ∣ 1 := by
        apply (Nat.dvd_add_iff_left (dvd_mul_right N u)).mpr
        simpa [r, Nat.add_comm] using hd
      have := Nat.le_of_dvd Nat.one_pos hd1
      omega
    refine ⟨r, z, mem_pivotCandidates.mpr ⟨hrLt, hrNotDvd⟩, ?_⟩
    apply (div_eq_iff hden).2
    rw [add_mul, div_mul_cancel₀ _ hden]
    push_cast
    exact_mod_cast (show (N : ℤ) * q + 1 =
      z * ((N : ℤ) * (pivot : ℤ)) + ((r : ℕ) : ℤ) by
        dsimp [r]
        rw [← hq]
        ring)
  · let u : ℕ := (q - 1).natMod (pivot : ℤ)
    let z : ℤ := (q - 1) / (pivot : ℤ)
    let r : ℕ := N * u + (N - 1)
    have huLt : u < pivot := by
      exact Int.natMod_lt hpivotNat
    have hremNonneg : 0 ≤ (q - 1) % (pivot : ℤ) :=
      Int.emod_nonneg (q - 1) hpivotZ
    have huCast : (u : ℤ) = (q - 1) % (pivot : ℤ) := by
      exact Int.toNat_of_nonneg hremNonneg
    have hq : z * (pivot : ℤ) + (u : ℤ) = q - 1 := by
      simpa [z, huCast] using Int.ediv_mul_add_emod (q - 1) (pivot : ℤ)
    have hrLt : r < N * pivot := by
      have hmul : N * (u + 1) ≤ N * pivot :=
        Nat.mul_le_mul_left N (Nat.add_one_le_iff.mpr huLt)
      dsimp [r]
      simp only [Nat.mul_add, Nat.mul_one] at hmul
      omega
    have hrNotDvd : ¬N ∣ r := by
      intro hd
      have hdNm1 : N ∣ N - 1 := by
        apply (Nat.dvd_add_iff_left (dvd_mul_right N u)).mpr
        simpa [r, Nat.add_comm] using hd
      have hpos : 0 < N - 1 := by omega
      have := Nat.le_of_dvd hpos hdNm1
      omega
    refine ⟨r, z, mem_pivotCandidates.mpr ⟨hrLt, hrNotDvd⟩, ?_⟩
    apply (div_eq_iff hden).2
    rw [add_mul, div_mul_cancel₀ _ hden]
    push_cast
    exact_mod_cast (show (N : ℤ) * q + -1 =
      z * ((N : ℤ) * (pivot : ℤ)) + ((r : ℕ) : ℤ) by
        dsimp [r]
        have hNsub : ((N - 1 : ℕ) : ℤ) = (N : ℤ) - 1 := by
          omega
        rw [hNsub]
        calc
          (N : ℤ) * q + -1 = (N : ℤ) * (q - 1) + ((N : ℤ) - 1) := by ring
          _ = (N : ℤ) * (z * (pivot : ℤ) + (u : ℤ)) +
              ((N : ℤ) - 1) := by rw [hq]
          _ = z * ((N : ℤ) * (pivot : ℤ)) +
              ((N : ℤ) * (u : ℤ) + ((N : ℤ) - 1)) := by ring)

/-- Pivot grids are complete for every fixed nonempty positive-natural speed
family: any witness can be replaced by the canonical natural residue used by
the modular certificate layer. -/
theorem exists_safe_pivot_residue {n N : ℕ} (speeds : Fin n → ℕ)
    (anchor : Fin n) (hN : 2 ≤ N) (hspeeds : ∀ i, 0 < speeds i)
    (witness : ℝ)
    (hwitness : ∀ i,
      (N : ℝ)⁻¹ ≤ circleNorm (witness * (speeds i : ℝ))) :
    ∃ (pivot : Fin n) (r : ℕ),
      r ∈ pivotCandidates N (speeds pivot) ∧
      ∀ i, (N : ℝ)⁻¹ ≤
        circleNorm (((r : ℝ) / ((N * speeds pivot : ℕ) : ℝ)) *
          (speeds i : ℝ)) := by
  obtain ⟨pivot, q, ε, time, hε, htime, hsafe⟩ :=
    exists_safe_signed_pivot_grid speeds anchor hN hspeeds witness hwitness
  obtain ⟨r, z, hr, hnormalize⟩ :=
    signed_grid_normalizes_to_pivotCandidate hN (hspeeds pivot) q ε hε
  refine ⟨pivot, r, hr, ?_⟩
  intro i
  have htimeNormalize : time =
      (z : ℝ) + (r : ℝ) / ((N * speeds pivot : ℕ) : ℝ) :=
    htime.trans hnormalize
  have hphase : time * (speeds i : ℝ) =
      ((z * (speeds i : ℤ) : ℤ) : ℝ) +
        ((r : ℝ) / ((N * speeds pivot : ℕ) : ℝ)) *
          (speeds i : ℝ) := by
    rw [htimeNormalize]
    push_cast
    ring
  have hi := hsafe i
  rw [hphase, circleNorm_add_int] at hi
  exact hi

/-- Exact fixed-instance equivalence between an arbitrary real witness and a
canonical pivot residue avoiding every strict non-pivot bad set. -/
theorem exists_witness_iff_exists_pivot_certificate {n N : ℕ}
    (speeds : Fin n → ℕ) (anchor : Fin n) (hN : 2 ≤ N)
    (hspeeds : ∀ i, 0 < speeds i) :
    (∃ time : ℝ, ∀ i,
      (N : ℝ)⁻¹ ≤ circleNorm (time * (speeds i : ℝ))) ↔
    ∃ (pivot : Fin n) (r : ℕ),
      r ∈ pivotCandidates N (speeds pivot) ∧
      ∀ i, i ≠ pivot →
        r ∉ pivotBadResidues N (speeds pivot) (speeds i) := by
  have hNpos : 0 < N := by omega
  constructor
  · rintro ⟨time, htime⟩
    obtain ⟨pivot, r, hr, hsafe⟩ :=
      exists_safe_pivot_residue speeds anchor hN hspeeds time htime
    refine ⟨pivot, r, hr, ?_⟩
    intro i hi
    exact (not_mem_pivotBadResidues_iff_circleNorm_ge
      hNpos (hspeeds pivot) hr).2 (hsafe i)
  · rintro ⟨pivot, r, hr, havoid⟩
    refine ⟨(r : ℝ) / ((N * speeds pivot : ℕ) : ℝ), ?_⟩
    exact pivotResidueWitness speeds pivot hNpos hspeeds r hr havoid

/-- Positive-integer LRC restated entirely as existence of one finite modular
pivot certificate.  Injectivity remains because this proposition mirrors
`PositiveIntegerConjecture` exactly. -/
def PositiveIntegerPivotCertificateConjecture : Prop :=
  ∀ (n : ℕ), 1 ≤ n →
    ∀ speeds : Fin n → ℕ,
      Function.Injective speeds → (∀ i, 0 < speeds i) →
        ∃ (pivot : Fin n) (r : ℕ),
          r ∈ pivotCandidates (n + 1) (speeds pivot) ∧
          ∀ i, i ≠ pivot →
            r ∉ pivotBadResidues (n + 1) (speeds pivot) (speeds i)

/-- The finite modular-certificate proposition is exactly equivalent to the
positive-integer formulation.  This theorem does not perform the separate
real-to-integer reduction. -/
theorem positiveIntegerConjecture_iff_pivotCertificateConjecture :
    PositiveIntegerConjecture ↔ PositiveIntegerPivotCertificateConjecture := by
  unfold PositiveIntegerConjecture PositiveIntegerPivotCertificateConjecture
  constructor
  · intro h n hn speeds hinjective hspeeds
    let anchor : Fin n := ⟨0, hn⟩
    have hwitness := h n hn speeds hinjective hspeeds
    exact (exists_witness_iff_exists_pivot_certificate speeds anchor
      (by omega) hspeeds).mp hwitness
  · intro h n hn speeds hinjective hspeeds
    let anchor : Fin n := ⟨0, hn⟩
    have hcertificate := h n hn speeds hinjective hspeeds
    exact (exists_witness_iff_exists_pivot_certificate speeds anchor
      (by omega) hspeeds).mpr hcertificate

end LonelyRunner
