import LonelyRunner.PivotResidues

/-!
# Deletion-pivot lifting

This module verifies the sound implication behind deletion-pivot lifting and
records the corrected lifting principle as an explicit contract. It does not
assert that the contract's selector exists.
-/

namespace LonelyRunner

/-- A finite speed family is primitive when its only common natural divisor is
one. This is the divisibility characterization of finite-family gcd one. -/
def PrimitiveSpeedFamily {n : ℕ} (speeds : Fin n → ℕ) : Prop :=
  ∀ d : ℕ, (∀ i, d ∣ speeds i) → d = 1

/-- A canonical speed-valued pivot certificate for the tuple obtained by
deleting one coordinate. The original tuple has `n` speeds, so the deletion
has target threshold `1 / n`. -/
structure DeletionPivotCertificate {n : ℕ} (speeds : Fin n → ℕ)
    (deleted : Fin n) where
  pivot : Fin n
  pivot_ne_deleted : pivot ≠ deleted
  r : ℕ
  r_mem : r ∈ pivotCandidates n (speeds pivot)
  surviving_good : ∀ i, i ≠ deleted →
    speeds pivot ≤ cyclicResidueDistance (n * speeds pivot) (r * speeds i)

/-- The exact closed inequality needed for a deletion certificate to protect
the exceptional deleted coordinate at the weaker full-tuple threshold
`1 / (n + 1)`. -/
def DeletionPivotCertificate.ExceptionalGood {n : ℕ}
    {speeds : Fin n → ℕ} {deleted : Fin n}
    (cert : DeletionPivotCertificate speeds deleted) : Prop :=
  n * speeds cert.pivot ≤
    (n + 1) * cyclicResidueDistance (n * speeds cert.pivot)
      (cert.r * speeds deleted)

/-- A deletion certificate satisfying the exceptional-coordinate inequality
gives an explicit full witness at time `r / (n * pivot)`. This is the sound
lifting direction only. -/
theorem DeletionPivotCertificate.exists_full_witness_of_exceptionalGood
    {n : ℕ} {speeds : Fin n → ℕ} {deleted : Fin n}
    (hn : 0 < n) (hpos : ∀ i, 0 < speeds i)
    (cert : DeletionPivotCertificate speeds deleted)
    (hexceptional : cert.ExceptionalGood) :
    ∃ time : ℝ, ∀ i,
      (((n + 1 : ℕ) : ℝ)⁻¹) ≤ circleNorm (time * (speeds i : ℝ)) := by
  let M : ℕ := n * speeds cert.pivot
  have hM : 0 < M := Nat.mul_pos hn (hpos cert.pivot)
  have hMReal : (0 : ℝ) < (M : ℝ) := by exact_mod_cast hM
  have hnOneReal : (0 : ℝ) < ((n + 1 : ℕ) : ℝ) := by positivity
  refine ⟨(cert.r : ℝ) / (M : ℝ), ?_⟩
  intro i
  have hphase :
      ((cert.r : ℝ) / (M : ℝ)) * (speeds i : ℝ) =
        ((cert.r * speeds i : ℕ) : ℝ) / (M : ℝ) := by
    push_cast
    ring
  rw [hphase, circleNorm_nat_div_eq]
  by_cases hi : i = deleted
  · subst i
    have hcross : (1 : ℝ) * (M : ℝ) ≤
        (cyclicResidueDistance M (cert.r * speeds deleted) : ℝ) *
          ((n + 1 : ℕ) : ℝ) := by
      have hcast : (M : ℝ) ≤
          (((n + 1) * cyclicResidueDistance M
            (cert.r * speeds deleted) : ℕ) : ℝ) := by
        exact_mod_cast hexceptional
      simpa [Nat.cast_mul, mul_comm] using hcast
    simpa [one_div] using
      ((div_le_div_iff₀ hnOneReal hMReal).2 hcross)
  · have hsurviving := cert.surviving_good i hi
    have hcross : (1 : ℝ) * (M : ℝ) ≤
        (speeds cert.pivot : ℝ) * ((n + 1 : ℕ) : ℝ) := by
      have hnat : M ≤ speeds cert.pivot * (n + 1) := by
        simpa [M, Nat.mul_comm] using
          Nat.mul_le_mul_left (speeds cert.pivot) (Nat.le_succ n)
      have hcast : (M : ℝ) ≤
          (speeds cert.pivot : ℝ) * ((n + 1 : ℕ) : ℝ) := by
        exact_mod_cast hnat
      simpa only [one_mul] using hcast
    have hthreshold : (((n + 1 : ℕ) : ℝ)⁻¹) ≤
        (speeds cert.pivot : ℝ) / (M : ℝ) := by
      simpa [one_div] using
        ((div_le_div_iff₀ hnOneReal hMReal).2 hcross)
    have hsurvivingReal : (speeds cert.pivot : ℝ) ≤
        (cyclicResidueDistance M (cert.r * speeds i) : ℝ) := by
      exact_mod_cast hsurviving
    have hresidueFraction : (speeds cert.pivot : ℝ) / (M : ℝ) ≤
        (cyclicResidueDistance M (cert.r * speeds i) : ℝ) / (M : ℝ) :=
      (div_le_div_iff_of_pos_right hMReal).2 hsurvivingReal
    exact hthreshold.trans hresidueFraction

/-- The neutral cross-deletion selector contract. It is deliberately
independent of the sufficient hypotheses of the corrected principle. -/
def DeletionPivotSelector {n : ℕ} (speeds : Fin n → ℕ) : Prop :=
  (∀ deleted, Nonempty (DeletionPivotCertificate speeds deleted)) →
    ∃ (deleted : Fin n) (cert : DeletionPivotCertificate speeds deleted),
      cert.ExceptionalGood

/-- The corrected pointwise deletion-pivot lifting contract. The selector is
only required for dimensions at least two and for positive, injective,
primitive families satisfying the large-speed cutoff and divisibility
premise. -/
def CorrectedDeletionPivotLiftingPrincipleAt {n : ℕ}
    (speeds : Fin n → ℕ) : Prop :=
  (∀ i, 0 < speeds i) →
  Function.Injective speeds →
  PrimitiveSpeedFamily speeds →
  (∃ i, n + 1 + (n + 1) / 3 < speeds i) →
  (∃ i, (n + 1) ∣ speeds i) →
  (∀ deleted, Nonempty (DeletionPivotCertificate speeds deleted)) →
  ∃ (deleted : Fin n) (cert : DeletionPivotCertificate speeds deleted),
    cert.ExceptionalGood

/-- The corrected deletion-pivot lifting contract, quantified pointwise over
every finite size and speed family. -/
def CorrectedDeletionPivotLiftingPrinciple : Prop :=
  ∀ n : ℕ, 2 ≤ n → ∀ speeds : Fin n → ℕ,
    CorrectedDeletionPivotLiftingPrincipleAt speeds

/-- If every deletion has a certificate and the neutral selector holds, the
tuple has a full closed witness. -/
theorem exists_full_witness_of_all_deletions_and_selector
    {n : ℕ} {speeds : Fin n → ℕ}
    (hn : 0 < n) (hpos : ∀ i, 0 < speeds i)
    (hall : ∀ deleted, Nonempty (DeletionPivotCertificate speeds deleted))
    (hselector : DeletionPivotSelector speeds) :
    ∃ time : ℝ, ∀ i,
      (((n + 1 : ℕ) : ℝ)⁻¹) ≤ circleNorm (time * (speeds i : ℝ)) := by
  obtain ⟨deleted, cert, hexceptional⟩ := hselector hall
  exact cert.exists_full_witness_of_exceptionalGood hn hpos hexceptional

/-- The corrected contract supplies the selected deletion and certificate at
the same pointwise `(n, speeds)` instance, preserving the documented
quantifier order. -/
theorem exists_full_witness_of_corrected_deletionPivotLiftingPrinciple
    {n : ℕ} {speeds : Fin n → ℕ}
    (hn : 2 ≤ n)
    (hpos : ∀ i, 0 < speeds i)
    (hinjective : Function.Injective speeds)
    (hprimitive : PrimitiveSpeedFamily speeds)
    (hlarge : ∃ i, n + 1 + (n + 1) / 3 < speeds i)
    (hdivisible : ∃ i, (n + 1) ∣ speeds i)
    (hall : ∀ deleted, Nonempty (DeletionPivotCertificate speeds deleted))
    (hcorrected : CorrectedDeletionPivotLiftingPrinciple) :
    ∃ time : ℝ, ∀ i,
      (((n + 1 : ℕ) : ℝ)⁻¹) ≤ circleNorm (time * (speeds i : ℝ)) := by
  obtain ⟨deleted, cert, hexceptional⟩ :=
    hcorrected n hn speeds hpos hinjective hprimitive hlarge hdivisible hall
  have hnpos : 0 < n := Nat.zero_lt_of_lt hn
  exact cert.exists_full_witness_of_exceptionalGood hnpos hpos hexceptional

end LonelyRunner
