import LonelyRunner.DivisorInsertion
import LonelyRunner.PivotBoundary
import LonelyRunner.SmallDimensions

/-!
# An exact induction interface for the positive-integer problem

This file combines four independently sound ways to extend a positive natural
speed family: fast-runner insertion, codimension-one divisor insertion, the
minimum-scale residue bands, and an exact modular-pivot certificate.  The
result isolates the genuinely open statement as a covering principle saying
that one of those four cases occurs for every appended injective family.

The covering principle is not asserted.  Proving it would prove
`PositiveIntegerConjecture`; bounded computation is not used in this file.
-/

namespace LonelyRunner

/-- Append one natural speed at the final `Fin` index. -/
def appendNatSpeed {n : ℕ} (old : Fin n → ℕ) (new : ℕ) : Fin (n + 1) → ℕ :=
  Fin.lastCases new old

@[simp] theorem appendNatSpeed_last {n : ℕ} (old : Fin n → ℕ) (new : ℕ) :
    appendNatSpeed old new (Fin.last n) = new := by
  simp [appendNatSpeed]

@[simp] theorem appendNatSpeed_castSucc {n : ℕ} (old : Fin n → ℕ)
    (new : ℕ) (i : Fin n) :
    appendNatSpeed old new i.castSucc = old i := by
  simp [appendNatSpeed]

/-- The new speed is large enough for quantitative fast-runner insertion. -/
def FastInsertionCase {n : ℕ} (old : Fin n → ℕ) (new : ℕ) : Prop :=
  ∀ i, (n + 1) * old i ≤ new

/-- Arithmetic data for codimension-one divisor insertion.  The old speeds
are all `D` times a lower-dimensional tuple, and the reduced orbit of the new
speed has enough mesh points for the new loneliness threshold. -/
def DivisorInsertionCase {n : ℕ} (old : Fin n → ℕ) (new : ℕ) : Prop :=
  ∃ (divided : Fin n → ℕ) (D g c m : ℕ),
    (∀ i, old i = D * divided i) ∧
    0 < g ∧ 0 < m ∧ D = g * m ∧ new = g * c ∧
    Nat.Coprime c m ∧ 2 * m ≤ (n + 2) * (m - 1)

/-- A common divisor of all old speeds which is coprime to the new speed gives
the divisor-insertion data with reduced orbit size exactly `D`. -/
theorem divisorInsertionCase_of_coprime_commonDivisor {n : ℕ}
    (old : Fin n → ℕ) (new D : ℕ) (hD : 0 < D)
    (hfactor : ∀ i, D ∣ old i) (hcoprime : Nat.Coprime new D)
    (hmesh : 2 * D ≤ (n + 2) * (D - 1)) :
    DivisorInsertionCase old new := by
  refine ⟨(fun i ↦ old i / D), D, 1, new, D, ?_, by omega, hD,
    by simp, by simp, hcoprime, hmesh⟩
  intro i
  exact (Nat.mul_div_cancel' (hfactor i)).symm

/-- In old dimension at least two, every coprime common divisor `D ≥ 2`
automatically has enough orbit mesh for divisor insertion. -/
theorem divisorInsertionCase_of_coprime_commonDivisor_two_le {n : ℕ}
    (hn : 2 ≤ n) (old : Fin n → ℕ) (new D : ℕ) (hD : 2 ≤ D)
    (hfactor : ∀ i, D ∣ old i) (hcoprime : Nat.Coprime new D) :
    DivisorInsertionCase old new := by
  apply divisorInsertionCase_of_coprime_commonDivisor old new D (by omega)
    hfactor hcoprime
  calc
    2 * D ≤ 4 * (D - 1) := by omega
    _ ≤ (n + 2) * (D - 1) :=
      Nat.mul_le_mul_right (D - 1) (by omega)

/-- The full appended tuple lies in the explicit minimum-scale residue bands.
The old dimension is assumed positive when this case is consumed, so the
band theorem's two-moving-speed premise is automatic. -/
def ResidueBandInsertionCase {n : ℕ} (old : Fin n → ℕ) (new : ℕ) : Prop :=
  ∃ base : ℝ, 0 < base ∧
    ∀ i : Fin (n + 1), ∃ q : ℕ,
      (((q * ((n + 1) + 1) + 1 : ℕ) : ℝ) ≤
          |(appendNatSpeed old new i : ℝ)| / base) ∧
      (|(appendNatSpeed old new i : ℝ)| / base ≤
          ((q * ((n + 1) + 1) + (n + 1) : ℕ) : ℝ))

/-- A complete finite modular-pivot certificate for the appended tuple. -/
def PivotInsertionCase {n : ℕ} (old : Fin n → ℕ) (new : ℕ) : Prop :=
  ∃ (pivot : Fin (n + 1)) (r : ℕ),
    r ∈ pivotCandidates (n + 2) (appendNatSpeed old new pivot) ∧
    ∀ i, i ≠ pivot →
      r ∉ pivotBadResidues (n + 2) (appendNatSpeed old new pivot)
        (appendNatSpeed old new i)

/-- Every candidate in every pivot grid is spoiled by at least one other
coordinate.  By the exact boundary-pivot theorem, this is precisely the
finite obstruction to a witness for the fixed appended tuple. -/
def AllPivotCandidatesCovered {n : ℕ} (old : Fin n → ℕ) (new : ℕ) : Prop :=
  ∀ (pivot : Fin (n + 1)) (r : ℕ),
    r ∈ pivotCandidates (n + 2) (appendNatSpeed old new pivot) →
      ∃ i, i ≠ pivot ∧
        r ∈ pivotBadResidues (n + 2) (appendNatSpeed old new pivot)
          (appendNatSpeed old new i)

/-- An uncovered pivot candidate is exactly a modular-pivot certificate. -/
theorem pivotInsertionCase_iff_not_allPivotCandidatesCovered {n : ℕ}
    (old : Fin n → ℕ) (new : ℕ) :
    PivotInsertionCase old new ↔ ¬AllPivotCandidatesCovered old new := by
  classical
  constructor
  · rintro ⟨pivot, r, hr, havoid⟩ hcovered
    obtain ⟨i, hi, hbad⟩ := hcovered pivot r hr
    exact havoid i hi hbad
  · intro hnotCovered
    by_contra hnotCertificate
    apply hnotCovered
    intro pivot r hr
    by_contra hnone
    apply hnotCertificate
    refine ⟨pivot, r, hr, ?_⟩
    intro i hi hbad
    exact hnone ⟨i, hi, hbad⟩

/-- The four-way covering statement sufficient for one induction step.  The
first two alternatives use the previous dimension; the last two directly
construct a witness for the full tuple. -/
def IntegerInsertionCover {n : ℕ} (old : Fin n → ℕ) (new : ℕ) : Prop :=
  FastInsertionCase old new ∨
    DivisorInsertionCase old new ∨
      ResidueBandInsertionCase old new ∨ PivotInsertionCase old new

/-- A fixed appended tuple has a witness whenever one of the four certified
induction branches applies and the positive-integer theorem is known in the
previous dimension. -/
theorem exists_appended_witness_of_integerInsertionCover {n : ℕ} (hn : 1 ≤ n)
    (old : Fin n → ℕ) (new : ℕ)
    (hfullInjective : Function.Injective (appendNatSpeed old new))
    (hfullPositive : ∀ i, 0 < appendNatSpeed old new i)
    (hprevious : ∀ speeds : Fin n → ℕ,
      Function.Injective speeds → (∀ i, 0 < speeds i) →
        ∃ time : ℝ, ∀ i,
          (((n + 1 : ℕ) : ℝ)⁻¹) ≤
            circleNorm (time * (speeds i : ℝ)))
    (hcover : IntegerInsertionCover old new) :
    ∃ time : ℝ, ∀ i,
      (((n + 2 : ℕ) : ℝ)⁻¹) ≤
        circleNorm (time * (appendNatSpeed old new i : ℝ)) := by
  have holdInjective : Function.Injective old := by
    intro i j hij
    have hcast : i.castSucc = j.castSucc :=
      hfullInjective (by simpa using hij)
    exact Fin.castSucc_inj.mp hcast
  have holdPositive : ∀ i, 0 < old i := by
    intro i
    simpa using hfullPositive i.castSucc
  rcases hcover with hfast | hdivisor | hbands | hpivot
  · obtain ⟨time₀, htime₀⟩ := hprevious old holdInjective holdPositive
    have hnewPositive : 0 < new := by
      simpa using hfullPositive (Fin.last n)
    have hfastReal : ∀ i,
        (((n + 1 : ℕ) : ℝ) * |(old i : ℝ)|) ≤ |(new : ℝ)| := by
      intro i
      rw [abs_of_nonneg (Nat.cast_nonneg _), abs_of_nonneg (Nat.cast_nonneg _)]
      exact_mod_cast hfast i
    obtain ⟨time, _hclose, hnewTime, holdTime⟩ :=
      fastRunnerInsertion (fun i ↦ (old i : ℝ)) time₀ (new : ℝ)
        htime₀ (by exact_mod_cast hnewPositive.ne') hfastReal
    refine ⟨time, ?_⟩
    intro i
    cases i using Fin.lastCases with
    | last => simpa using hnewTime
    | cast i => simpa using holdTime i
  · obtain ⟨divided, D, g, c, m, hfactor, hg, hm, hD, hnew,
        hcoprime, hclosed⟩ := hdivisor
    have hDPositive : 0 < D := by
      rw [hD]
      exact Nat.mul_pos hg hm
    have hdividedPositive : ∀ i, 0 < divided i := by
      intro i
      have hi := holdPositive i
      rw [hfactor i] at hi
      apply Nat.pos_of_ne_zero
      intro hz
      simp [hz] at hi
    have hdividedInjective : Function.Injective divided := by
      intro i j hij
      apply holdInjective
      rw [hfactor i, hfactor j, hij]
    obtain ⟨s, hs⟩ :=
      hprevious divided hdividedInjective hdividedPositive
    obtain ⟨time, hnewTime, holdTime⟩ :=
      codimensionOneDivisorInsertion divided new D g c m s hg hm hD hnew
        hcoprime hs hclosed
    refine ⟨time, ?_⟩
    intro i
    cases i using Fin.lastCases with
    | last => simpa using hnewTime
    | cast i => simpa [hfactor i] using holdTime i
  · obtain ⟨base, hbase, hbands⟩ := hbands
    let fullReal : Fin (n + 1) → ℝ :=
      fun i ↦ (appendNatSpeed old new i : ℝ)
    have hbandWitness := minimumScaleResidueBands (n := n + 1) (by omega)
      fullReal base hbase (by simpa [fullReal] using hbands)
    refine ⟨(((((n + 1) + 1 : ℕ) : ℝ) * base)⁻¹), ?_⟩
    intro i
    simpa [fullReal, Nat.add_assoc] using hbandWitness i
  · obtain ⟨pivot, r, hr, havoid⟩ := hpivot
    refine ⟨(r : ℝ) /
      ((((n + 2) * appendNatSpeed old new pivot : ℕ) : ℝ)), ?_⟩
    exact pivotResidueWitness (appendNatSpeed old new) pivot (by omega)
      hfullPositive r hr havoid

/-- The exact all-dimensional covering principle left open by the combined
induction route. -/
def PositiveIntegerInsertionCoveringPrinciple : Prop :=
  ∀ (n : ℕ), 1 ≤ n → ∀ (old : Fin n → ℕ) (new : ℕ),
    Function.Injective (appendNatSpeed old new) →
    (∀ i, 0 < appendNatSpeed old new i) →
      IntegerInsertionCover old new

/-- The sharp induction dichotomy suggested by divisor insertion and pivot
completeness: either a codimension-one divisor orbit inserts one coordinate,
or not all pivot grids are covered. -/
def DivisorOrUncoveredPivotPrinciple : Prop :=
  ∀ (n : ℕ), 1 ≤ n → ∀ (old : Fin n → ℕ) (new : ℕ),
    Function.Injective (appendNatSpeed old new) →
    (∀ i, 0 < appendNatSpeed old new i) →
      DivisorInsertionCase old new ∨
        ¬AllPivotCandidatesCovered old new

/-- If the four-way covering principle is established uniformly, ordinary
strong induction proves the positive-integer Lonely Runner Conjecture.  This
is a reduction theorem, not a proof of the covering principle. -/
theorem positiveIntegerConjecture_of_insertionCoveringPrinciple
    (hcover : PositiveIntegerInsertionCoveringPrinciple) :
    PositiveIntegerConjecture := by
  intro n hn
  induction n using Nat.strong_induction_on with
  | h n ih =>
      intro speeds hspeeds hpositive
      by_cases hnone : n = 1
      · subst n
        obtain ⟨time, htime⟩ := oneMovingRunner (speeds 0 : ℝ)
          (by exact_mod_cast (hpositive 0).ne')
        refine ⟨time, ?_⟩
        intro i
        have hi : i = 0 := Subsingleton.elim _ _
        subst i
        simpa [circleNorm] using htime
      · obtain ⟨k, rfl⟩ : ∃ k, n = k + 1 := by
          exact ⟨n - 1, by omega⟩
        have hk : 1 ≤ k := by omega
        let old : Fin k → ℕ := fun i ↦ speeds i.castSucc
        let new : ℕ := speeds (Fin.last k)
        have happend : appendNatSpeed old new = speeds := by
          funext i
          cases i using Fin.lastCases with
          | last => simp [old, new]
          | cast i => simp [old, new]
        have hfullInjective : Function.Injective (appendNatSpeed old new) := by
          simpa [happend] using hspeeds
        have hfullPositive : ∀ i, 0 < appendNatSpeed old new i := by
          simpa [happend] using hpositive
        have hprevious : ∀ previous : Fin k → ℕ,
            Function.Injective previous → (∀ i, 0 < previous i) →
              ∃ time : ℝ, ∀ i,
                (((k + 1 : ℕ) : ℝ)⁻¹) ≤
                  circleNorm (time * (previous i : ℝ)) := by
          exact ih k (by omega) hk
        have hbranch := hcover k hk old new hfullInjective hfullPositive
        simpa [circleNorm, happend, Nat.add_assoc] using
          (exists_appended_witness_of_integerInsertionCover hk old new
            hfullInjective hfullPositive hprevious hbranch)

/-- The divisor-or-uncovered-pivot dichotomy is sufficient for the full
positive-integer conjecture. -/
theorem positiveIntegerConjecture_of_divisorOrUncoveredPivotPrinciple
    (hcover : DivisorOrUncoveredPivotPrinciple) :
    PositiveIntegerConjecture := by
  apply positiveIntegerConjecture_of_insertionCoveringPrinciple
  intro n hn old new hinjective hpositive
  rcases hcover n hn old new hinjective hpositive with hdivisor | hpivot
  · exact Or.inr (Or.inl hdivisor)
  · exact Or.inr (Or.inr (Or.inr
      ((pivotInsertionCase_iff_not_allPivotCandidatesCovered old new).2 hpivot)))

/-- Conversely, the positive-integer conjecture supplies an uncovered pivot
for every appended tuple.  Hence the sharp dichotomy is an exact reformulation
of the remaining integer problem, not an independently easier theorem. -/
theorem positiveIntegerConjecture_iff_divisorOrUncoveredPivotPrinciple :
    PositiveIntegerConjecture ↔ DivisorOrUncoveredPivotPrinciple := by
  constructor
  · intro hconjecture n hn old new hinjective hpositive
    right
    apply (pivotInsertionCase_iff_not_allPivotCandidatesCovered old new).1
    have hpivotConjecture : PositiveIntegerPivotCertificateConjecture :=
      positiveIntegerConjecture_iff_pivotCertificateConjecture.mp hconjecture
    simpa [PivotInsertionCase, Nat.add_assoc] using
      hpivotConjecture (n + 1) (by omega) (appendNatSpeed old new)
        hinjective hpositive
  · exact positiveIntegerConjecture_of_divisorOrUncoveredPivotPrinciple

end LonelyRunner
