import LonelyRunner.ModularAcyclicSelector
import LonelyRunner.OverlapCapacity

/-!
# Supplied packing adapter for canonical pivot certificates

This module accepts a finite family of already supplied overlap blocks.  The
blocks are never constructed here: the overlap-capacity theorem only converts
their certified pointwise use into one canonical pivot residue outside all
strict nonpivot bad sets.
-/

namespace LonelyRunner

open scoped BigOperators

/-- A canonical pivot residue is a natural residue together with its candidate
membership proof.  Finiteness comes from the candidate predicate itself. -/
def CanonicalPivotResidue (N pivotSpeed : ℕ) :=
  {r : ℕ // r ∈ pivotCandidates N pivotSpeed}

instance instDecidableEqCanonicalPivotResidue (N pivotSpeed : ℕ) :
    DecidableEq (CanonicalPivotResidue N pivotSpeed) := by
  unfold CanonicalPivotResidue
  infer_instance

noncomputable instance instFintypeCanonicalPivotResidue (N pivotSpeed : ℕ) :
    Fintype (CanonicalPivotResidue N pivotSpeed) := by
  unfold CanonicalPivotResidue
  exact Fintype.ofFinset (pivotCandidates N pivotSpeed) (by
    intro r
    rfl)

/-- The raw bad residues, transported into the canonical candidate subtype. -/
def canonicalPivotBadResidues (N pivotSpeed other : ℕ) :
    Finset (CanonicalPivotResidue N pivotSpeed) :=
  (pivotBadResidues N pivotSpeed other).attach.map
    { toFun := fun r =>
        (⟨r.1, pivotBadResidues_subset N pivotSpeed other r.2⟩ :
          CanonicalPivotResidue N pivotSpeed)
      inj' := by
        intro a b hab
        have hval : a.1 = b.1 := by
          exact congrArg (fun r : CanonicalPivotResidue N pivotSpeed => r.1) hab
        exact Subtype.ext hval }

/-- Membership in a canonical bad set is exactly raw bad-residue membership. -/
theorem mem_canonicalPivotBadResidues
    {N pivotSpeed other : ℕ} {r : CanonicalPivotResidue N pivotSpeed} :
    r ∈ canonicalPivotBadResidues N pivotSpeed other ↔
      r.1 ∈ pivotBadResidues N pivotSpeed other := by
  classical
  unfold canonicalPivotBadResidues
  constructor
  · intro h
    obtain ⟨a, ha, har⟩ := Finset.mem_map.mp h
    have haBad : a.1 ∈ pivotBadResidues N pivotSpeed other := by
      simpa using ha
    have hval : a.1 = r.1 := by
      exact congrArg (fun z : CanonicalPivotResidue N pivotSpeed => z.1) har
    simpa [hval] using haBad
  · intro hr
    apply Finset.mem_map.mpr
    let a : {x : ℕ // x ∈ pivotBadResidues N pivotSpeed other} := ⟨r.1, hr⟩
    refine ⟨a, ?_, ?_⟩
    · simp [a]
    · apply Subtype.ext
      rfl

/-- Transporting a bad set into the candidate subtype preserves its cardinality. -/
theorem card_canonicalPivotBadResidues (N pivotSpeed other : ℕ) :
    (canonicalPivotBadResidues N pivotSpeed other).card =
      (pivotBadResidues N pivotSpeed other).card := by
  classical
  simp [canonicalPivotBadResidues]

/-- The candidate subtype has exactly as many points as the candidate finset. -/
theorem card_canonicalPivotResidue (N pivotSpeed : ℕ) :
    Fintype.card (CanonicalPivotResidue N pivotSpeed) =
      (pivotCandidates N pivotSpeed).card := by
  classical
  simp [CanonicalPivotResidue]

/-- A supplied canonical overlap packing certifies a finite pivot certificate.

The capacity premise is stated on canonical candidate-subtype points, while
the strict threshold is stated in the raw residue cardinalities used by the
existing pivot-certificate interface.  No packing, parent assignment, or
uniform selection is existentially introduced. -/
theorem exists_pivot_certificate_of_overlapPacking
    {n N : ℕ} (speeds : Fin n → ℕ) (pivot : Fin n)
    (blocks : ModularFiberToken N speeds pivot →
      Finset (CanonicalPivotResidue N (speeds pivot)))
    (hcapacity : ∀ point : CanonicalPivotResidue N (speeds pivot),
      overlapPointUse blocks point ≤
        incidenceMultiplicity
          (fun child : NonpivotVertex pivot =>
            canonicalPivotBadResidues N (speeds pivot) (speeds child.1)) point - 1)
    (hstrict :
      (∑ child : NonpivotVertex pivot,
        (pivotBadResidues N (speeds pivot) (speeds child.1)).card) <
        (pivotCandidates N (speeds pivot)).card +
          ∑ token : ModularFiberToken N speeds pivot, (blocks token).card) :
    ∃ r ∈ pivotCandidates N (speeds pivot),
      ∀ i, i ≠ pivot →
        r ∉ pivotBadResidues N (speeds pivot) (speeds i) := by
  classical
  let bad : NonpivotVertex pivot →
      Finset (CanonicalPivotResidue N (speeds pivot)) := fun child =>
    canonicalPivotBadResidues N (speeds pivot) (speeds child.1)
  have hbadcard :
      (∑ child : NonpivotVertex pivot, (bad child).card) =
        ∑ child : NonpivotVertex pivot,
          (pivotBadResidues N (speeds pivot) (speeds child.1)).card := by
    apply Finset.sum_congr rfl
    intro child hchild
    exact card_canonicalPivotBadResidues N (speeds pivot) (speeds child.1)
  have hstrict' :
      (∑ child : NonpivotVertex pivot, (bad child).card) <
        Fintype.card (CanonicalPivotResidue N (speeds pivot)) +
          ∑ token : ModularFiberToken N speeds pivot, (blocks token).card := by
    rw [hbadcard, card_canonicalPivotResidue]
    exact hstrict
  obtain ⟨point, hpoint⟩ :=
    exists_avoiding_of_overlapCapacity bad blocks (by
      simpa [bad] using hcapacity) hstrict'
  refine ⟨point.1, point.2, ?_⟩
  intro i hi
  let child : NonpivotVertex pivot := ⟨i, hi⟩
  intro hbadRaw
  have hnot := hpoint child
  exact hnot ((mem_canonicalPivotBadResidues).2 hbadRaw)

end LonelyRunner
