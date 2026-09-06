import LonelyRunner.PivotResidues

/-!
# Kernel-checked finite certificate for four-runner mixed witnesses

The table contains only the fixed rational endpoints selected from the frozen
bounded-domain controls.  A missing key falls through the existential search
and makes the finite kernel check fail.
-/

namespace LonelyRunner

/-- The 34 endpoint candidates selected deterministically from the frozen
`H <= 36` positive witness rows. -/
def fourRunnerMixedCandidates : Fin 34 → ℕ × ℕ :=
  ![(1, 3), (1, 54), (1, 8), (3, 8), (1, 4), (5, 12), (1, 20), (22, 51),
    (9, 64), (22, 63), (5, 48), (2, 27), (13, 63), (13, 45), (4, 21),
    (11, 36), (1, 12), (1, 6), (14, 51), (9, 28), (7, 18), (1, 36),
    (7, 15), (21, 80), (1, 15), (3, 20), (13, 60), (13, 27), (5, 56),
    (4, 9), (5, 21), (9, 52), (22, 69), (13, 33)]

/-- The six exact natural residue bands for a mixed four-runner witness. -/
def fourRunnerMixedRowOK (a b H p q : ℕ) : Bool :=
  (0 < p) && (0 < q) &&
  (q <= 4 * ((a * p) % q)) && (4 * ((a * p) % q) <= 3 * q) &&
  (q <= 4 * ((b * p) % q)) && (4 * ((b * p) % q) <= 3 * q) &&
  (q <= 3 * ((H * p) % q)) && (3 * ((H * p) % q) <= 2 * q)

private abbrev fourRunnerMixedCoverageAt (H : Fin 37) : Prop :=
  ∀ a b : Fin 37,
    0 < a.1 → a.1 < b.1 → b.1 < H.1 →
    Nat.gcd a.1 (Nat.gcd b.1 H.1) = 1 →
    ¬ (a.1 = 1 ∧ b.1 = 2 ∧ H.1 = 3) →
    ∃ k : Fin 34,
      fourRunnerMixedRowOK a.1 b.1 H.1 (fourRunnerMixedCandidates k).1
        (fourRunnerMixedCandidates k).2 = true

section

set_option maxRecDepth 100000
set_option maxHeartbeats 0
private theorem fourRunnerMixed_coverageAt_0 : fourRunnerMixedCoverageAt ⟨0, by decide⟩ := by
  decide

private theorem fourRunnerMixed_coverageAt_1 : fourRunnerMixedCoverageAt ⟨1, by decide⟩ := by
  decide

private theorem fourRunnerMixed_coverageAt_2 : fourRunnerMixedCoverageAt ⟨2, by decide⟩ := by
  decide

private theorem fourRunnerMixed_coverageAt_3 : fourRunnerMixedCoverageAt ⟨3, by decide⟩ := by
  decide

private theorem fourRunnerMixed_coverageAt_4 : fourRunnerMixedCoverageAt ⟨4, by decide⟩ := by
  decide

private theorem fourRunnerMixed_coverageAt_5 : fourRunnerMixedCoverageAt ⟨5, by decide⟩ := by
  decide

private theorem fourRunnerMixed_coverageAt_6 : fourRunnerMixedCoverageAt ⟨6, by decide⟩ := by
  decide

private theorem fourRunnerMixed_coverageAt_7 : fourRunnerMixedCoverageAt ⟨7, by decide⟩ := by
  decide

private theorem fourRunnerMixed_coverageAt_8 : fourRunnerMixedCoverageAt ⟨8, by decide⟩ := by
  decide

private theorem fourRunnerMixed_coverageAt_9 : fourRunnerMixedCoverageAt ⟨9, by decide⟩ := by
  decide

private theorem fourRunnerMixed_coverageAt_10 : fourRunnerMixedCoverageAt ⟨10, by decide⟩ := by
  decide

private theorem fourRunnerMixed_coverageAt_11 : fourRunnerMixedCoverageAt ⟨11, by decide⟩ := by
  decide

private theorem fourRunnerMixed_coverageAt_12 : fourRunnerMixedCoverageAt ⟨12, by decide⟩ := by
  decide

private theorem fourRunnerMixed_coverageAt_13 : fourRunnerMixedCoverageAt ⟨13, by decide⟩ := by
  decide

private theorem fourRunnerMixed_coverageAt_14 : fourRunnerMixedCoverageAt ⟨14, by decide⟩ := by
  decide

private theorem fourRunnerMixed_coverageAt_15 : fourRunnerMixedCoverageAt ⟨15, by decide⟩ := by
  decide

private theorem fourRunnerMixed_coverageAt_16 : fourRunnerMixedCoverageAt ⟨16, by decide⟩ := by
  decide

private theorem fourRunnerMixed_coverageAt_17 : fourRunnerMixedCoverageAt ⟨17, by decide⟩ := by
  decide

private theorem fourRunnerMixed_coverageAt_18 : fourRunnerMixedCoverageAt ⟨18, by decide⟩ := by
  decide

private theorem fourRunnerMixed_coverageAt_19 : fourRunnerMixedCoverageAt ⟨19, by decide⟩ := by
  decide

private theorem fourRunnerMixed_coverageAt_20 : fourRunnerMixedCoverageAt ⟨20, by decide⟩ := by
  decide

private theorem fourRunnerMixed_coverageAt_21 : fourRunnerMixedCoverageAt ⟨21, by decide⟩ := by
  decide

private theorem fourRunnerMixed_coverageAt_22 : fourRunnerMixedCoverageAt ⟨22, by decide⟩ := by
  decide

private theorem fourRunnerMixed_coverageAt_23 : fourRunnerMixedCoverageAt ⟨23, by decide⟩ := by
  decide

private theorem fourRunnerMixed_coverageAt_24 : fourRunnerMixedCoverageAt ⟨24, by decide⟩ := by
  decide

private theorem fourRunnerMixed_coverageAt_25 : fourRunnerMixedCoverageAt ⟨25, by decide⟩ := by
  decide

private theorem fourRunnerMixed_coverageAt_26 : fourRunnerMixedCoverageAt ⟨26, by decide⟩ := by
  decide

private theorem fourRunnerMixed_coverageAt_27 : fourRunnerMixedCoverageAt ⟨27, by decide⟩ := by
  decide

private theorem fourRunnerMixed_coverageAt_28 : fourRunnerMixedCoverageAt ⟨28, by decide⟩ := by
  decide

private theorem fourRunnerMixed_coverageAt_29 : fourRunnerMixedCoverageAt ⟨29, by decide⟩ := by
  decide

private theorem fourRunnerMixed_coverageAt_30 : fourRunnerMixedCoverageAt ⟨30, by decide⟩ := by
  decide

private theorem fourRunnerMixed_coverageAt_31 : fourRunnerMixedCoverageAt ⟨31, by decide⟩ := by
  decide

private theorem fourRunnerMixed_coverageAt_32 : fourRunnerMixedCoverageAt ⟨32, by decide⟩ := by
  decide

private theorem fourRunnerMixed_coverageAt_33 : fourRunnerMixedCoverageAt ⟨33, by decide⟩ := by
  decide

private theorem fourRunnerMixed_coverageAt_34 : fourRunnerMixedCoverageAt ⟨34, by decide⟩ := by
  decide

private theorem fourRunnerMixed_coverageAt_35 : fourRunnerMixedCoverageAt ⟨35, by decide⟩ := by
  decide

private theorem fourRunnerMixed_coverageAt_36 : fourRunnerMixedCoverageAt ⟨36, by decide⟩ := by
  decide

/-- Complete bounded coverage assembled from fixed-height kernel reductions. -/
theorem fourRunnerMixed_finiteCoverage : ∀ H a b : Fin 37,
    0 < a.1 → a.1 < b.1 → b.1 < H.1 →
    Nat.gcd a.1 (Nat.gcd b.1 H.1) = 1 →
    ¬ (a.1 = 1 ∧ b.1 = 2 ∧ H.1 = 3) →
    ∃ k : Fin 34,
      fourRunnerMixedRowOK a.1 b.1 H.1 (fourRunnerMixedCandidates k).1
        (fourRunnerMixedCandidates k).2 = true := by
  intro H a b ha hab hbH hprimitive hexception
  fin_cases H <;> first | exact fourRunnerMixed_coverageAt_0 a b ha hab hbH hprimitive hexception | exact fourRunnerMixed_coverageAt_1 a b ha hab hbH hprimitive hexception | exact fourRunnerMixed_coverageAt_2 a b ha hab hbH hprimitive hexception | exact fourRunnerMixed_coverageAt_3 a b ha hab hbH hprimitive hexception | exact fourRunnerMixed_coverageAt_4 a b ha hab hbH hprimitive hexception | exact fourRunnerMixed_coverageAt_5 a b ha hab hbH hprimitive hexception | exact fourRunnerMixed_coverageAt_6 a b ha hab hbH hprimitive hexception | exact fourRunnerMixed_coverageAt_7 a b ha hab hbH hprimitive hexception | exact fourRunnerMixed_coverageAt_8 a b ha hab hbH hprimitive hexception | exact fourRunnerMixed_coverageAt_9 a b ha hab hbH hprimitive hexception | exact fourRunnerMixed_coverageAt_10 a b ha hab hbH hprimitive hexception | exact fourRunnerMixed_coverageAt_11 a b ha hab hbH hprimitive hexception | exact fourRunnerMixed_coverageAt_12 a b ha hab hbH hprimitive hexception | exact fourRunnerMixed_coverageAt_13 a b ha hab hbH hprimitive hexception | exact fourRunnerMixed_coverageAt_14 a b ha hab hbH hprimitive hexception | exact fourRunnerMixed_coverageAt_15 a b ha hab hbH hprimitive hexception | exact fourRunnerMixed_coverageAt_16 a b ha hab hbH hprimitive hexception | exact fourRunnerMixed_coverageAt_17 a b ha hab hbH hprimitive hexception | exact fourRunnerMixed_coverageAt_18 a b ha hab hbH hprimitive hexception | exact fourRunnerMixed_coverageAt_19 a b ha hab hbH hprimitive hexception | exact fourRunnerMixed_coverageAt_20 a b ha hab hbH hprimitive hexception | exact fourRunnerMixed_coverageAt_21 a b ha hab hbH hprimitive hexception | exact fourRunnerMixed_coverageAt_22 a b ha hab hbH hprimitive hexception | exact fourRunnerMixed_coverageAt_23 a b ha hab hbH hprimitive hexception | exact fourRunnerMixed_coverageAt_24 a b ha hab hbH hprimitive hexception | exact fourRunnerMixed_coverageAt_25 a b ha hab hbH hprimitive hexception | exact fourRunnerMixed_coverageAt_26 a b ha hab hbH hprimitive hexception | exact fourRunnerMixed_coverageAt_27 a b ha hab hbH hprimitive hexception | exact fourRunnerMixed_coverageAt_28 a b ha hab hbH hprimitive hexception | exact fourRunnerMixed_coverageAt_29 a b ha hab hbH hprimitive hexception | exact fourRunnerMixed_coverageAt_30 a b ha hab hbH hprimitive hexception | exact fourRunnerMixed_coverageAt_31 a b ha hab hbH hprimitive hexception | exact fourRunnerMixed_coverageAt_32 a b ha hab hbH hprimitive hexception | exact fourRunnerMixed_coverageAt_33 a b ha hab hbH hprimitive hexception | exact fourRunnerMixed_coverageAt_34 a b ha hab hbH hprimitive hexception | exact fourRunnerMixed_coverageAt_35 a b ha hab hbH hprimitive hexception | exact fourRunnerMixed_coverageAt_36 a b ha hab hbH hprimitive hexception

end

private theorem quarter_of_residue_band {x q : ℕ} (hq : 0 < q)
    (hlow : q ≤ 4 * (x % q)) (hhigh : 4 * (x % q) ≤ 3 * q) :
    ((4 : ℕ) : ℝ)⁻¹ ≤ circleNorm ((x : ℝ) / (q : ℝ)) := by
  have hcyclic : q ≤ 4 * cyclicResidueDistance q x := by
    unfold cyclicResidueDistance
    have hright : q ≤ 4 * (q - x % q) := by omega
    omega
  have hqR : (0 : ℝ) < q := by exact_mod_cast hq
  have hcyclicR : (q : ℝ) ≤ 4 * (cyclicResidueDistance q x : ℝ) := by
    exact_mod_cast hcyclic
  rw [circleNorm_nat_div_eq, inv_eq_one_div]
  apply (div_le_div_iff₀ (by norm_num : (0 : ℝ) < 4) hqR).mpr
  norm_num at hcyclicR ⊢
  linarith

private theorem third_of_residue_band {x q : ℕ} (hq : 0 < q)
    (hlow : q ≤ 3 * (x % q)) (hhigh : 3 * (x % q) ≤ 2 * q) :
    ((3 : ℕ) : ℝ)⁻¹ ≤ circleNorm ((x : ℝ) / (q : ℝ)) := by
  have hcyclic : q ≤ 3 * cyclicResidueDistance q x := by
    unfold cyclicResidueDistance
    have hright : q ≤ 3 * (q - x % q) := by omega
    omega
  have hqR : (0 : ℝ) < q := by exact_mod_cast hq
  have hcyclicR : (q : ℝ) ≤ 3 * (cyclicResidueDistance q x : ℝ) := by
    exact_mod_cast hcyclic
  rw [circleNorm_nat_div_eq, inv_eq_one_div]
  apply (div_le_div_iff₀ (by norm_num : (0 : ℝ) < 3) hqR).mpr
  norm_num at hcyclicR ⊢
  linarith

/-- A checked table row produces all three mixed inequalities at one positive
rational time. -/
theorem fourRunnerMixedRowOK_sound {a b H p q : ℕ}
    (hrow : fourRunnerMixedRowOK a b H p q = true) :
    ∃ t : ℝ, 0 < t ∧
      ((4 : ℕ) : ℝ)⁻¹ ≤ circleNorm (t * (a : ℝ)) ∧
      ((4 : ℕ) : ℝ)⁻¹ ≤ circleNorm (t * (b : ℝ)) ∧
      ((3 : ℕ) : ℝ)⁻¹ ≤ circleNorm (t * (H : ℝ)) := by
  have hrow' : 0 < p ∧ 0 < q ∧
      q ≤ 4 * ((a * p) % q) ∧ 4 * ((a * p) % q) ≤ 3 * q ∧
      q ≤ 4 * ((b * p) % q) ∧ 4 * ((b * p) % q) ≤ 3 * q ∧
      q ≤ 3 * ((H * p) % q) ∧ 3 * ((H * p) % q) ≤ 2 * q := by
    simpa [fourRunnerMixedRowOK, and_assoc] using hrow
  obtain ⟨hp, hq, ha0, ha1, hb0, hb1, hH0, hH1⟩ := hrow'
  have hpR : (0 : ℝ) < p := by exact_mod_cast hp
  refine ⟨(p : ℝ) / (q : ℝ), div_pos hpR (by exact_mod_cast hq), ?_, ?_, ?_⟩
  · rw [show ((p : ℝ) / (q : ℝ)) * (a : ℝ) = ((a * p : ℕ) : ℝ) / (q : ℝ) by
      push_cast; ring]
    exact quarter_of_residue_band hq ha0 ha1
  · rw [show ((p : ℝ) / (q : ℝ)) * (b : ℝ) = ((b * p : ℕ) : ℝ) / (q : ℝ) by
      push_cast; ring]
    exact quarter_of_residue_band hq hb0 hb1
  · rw [show ((p : ℝ) / (q : ℝ)) * (H : ℝ) = ((H * p : ℕ) : ℝ) / (q : ℝ) by
      push_cast; ring]
    exact third_of_residue_band hq hH0 hH1

end LonelyRunner
