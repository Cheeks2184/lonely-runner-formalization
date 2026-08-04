import LonelyRunner.CrossPivotScaling

/-!
# Common scaling of complete pivot rows

This module formalizes the common-scaling symmetry exposed by the independent
audit of Prompt99.  Every speed is multiplied by the same positive natural
factor.  Unlike `CrossPivotScaling`, which scales a pivot numerator and keeps
the owner speed fixed, the relevant map here reduces an arbitrary candidate
in the enlarged grid modulo the original modulus.

The main result is a scope theorem: the unrestricted maximum-covered-pivot
redundancy statement is equivalent to its apparently narrower restriction in
which `n + 1` divides the maximum covered speed.  This does not prove either
redundancy statement or the Lonely Runner Conjecture.
-/

namespace LonelyRunner

open Finset

/-- Multiply every labelled speed by the same natural factor. -/
def scaleSpeeds {n : Nat} (t : Nat) (a : Fin n → Nat) : Fin n → Nat :=
  fun i => t * a i

/-- A labelled owner set completely covers one canonical strict pivot row.
The subset condition excludes the pivot label itself. -/
def PivotCompleteCover {n : Nat} (N : Nat) (a : Fin n → Nat)
    (j : Fin n) (C : Finset (Fin n)) : Prop :=
  C ⊆ Finset.univ.erase j ∧
    ∀ r ∈ pivotCandidates N (a j),
      ∃ i ∈ C, r ∈ pivotBadResidues N (a j) (a i)

/-- A pivot row is covered when all nonpivot labels are available as owners. -/
def PivotCovered {n : Nat} (N : Nat) (a : Fin n → Nat) (j : Fin n) : Prop :=
  PivotCompleteCover N a j (Finset.univ.erase j)

/-- The finite set of covered pivot labels. -/
noncomputable def coveredPivots {n : Nat} (N : Nat) (a : Fin n → Nat) :
    Finset (Fin n) :=
  by
    classical
    exact Finset.univ.filter (PivotCovered N a)

/-- A covered pivot whose speed is maximal among all covered pivots. -/
def IsMaximumCoveredPivot {n : Nat} (N : Nat) (a : Fin n → Nat)
    (j : Fin n) : Prop :=
  j ∈ coveredPivots N a ∧
    ∀ k ∈ coveredPivots N a, a k ≤ a j

/-- Every owner is a covered pivot distinct from the row being covered. -/
def IsInternalOwnerSet {n : Nat} (N : Nat) (a : Fin n → Nat)
    (j : Fin n) (C : Finset (Fin n)) : Prop :=
  C ⊆ (coveredPivots N a).erase j

/-- Coverwise redundancy at one pivot.  The quantifier ranges over every
labelled internal complete cover, not over one selected cover. -/
def InternalCoverRedundantAt {n : Nat} (N : Nat) (a : Fin n → Nat)
    (j : Fin n) : Prop :=
  ∀ C : Finset (Fin n),
    IsInternalOwnerSet N a j C →
    PivotCompleteCover N a j C →
    ∃ i ∈ C, PivotCompleteCover N a j (C.erase i)

/-- Reducing a candidate in the commonly scaled grid modulo the original
modulus gives exactly an original candidate.  The explicit range conjunct is
essential for arbitrary naturals outside the finite scaled grid. -/
theorem mem_pivotCandidates_scale_reduce_iff
    {N p t r' : Nat} (hN : 0 < N) (hp : 0 < p) (_ht : 0 < t) :
    r' ∈ pivotCandidates N (t * p) ↔
      r' < t * (N * p) ∧
        r' % (N * p) ∈ pivotCandidates N p := by
  rw [mem_pivotCandidates, mem_pivotCandidates]
  have hM : 0 < N * p := Nat.mul_pos hN hp
  constructor
  · rintro ⟨hrange, hnot⟩
    refine ⟨?_, Nat.mod_lt r' hM, ?_⟩
    · simpa only [Nat.mul_assoc, Nat.mul_left_comm, Nat.mul_comm] using hrange
    · intro hmod
      apply hnot
      obtain ⟨k, hk⟩ := hmod
      refine ⟨p * (r' / (N * p)) + k, ?_⟩
      calc
        r' = (N * p) * (r' / (N * p)) + r' % (N * p) :=
          (Nat.div_add_mod r' (N * p)).symm
        _ = N * (p * (r' / (N * p)) + k) := by rw [hk]; ring
  · rintro ⟨hrange, hmodRange, hmodNot⟩
    constructor
    · simpa only [Nat.mul_assoc, Nat.mul_left_comm, Nat.mul_comm] using hrange
    · intro hdvd
      apply hmodNot
      obtain ⟨k, rfl⟩ := hdvd
      rw [Nat.mul_mod_mul_left]
      exact dvd_mul_right N (k % p)

/-- Circular distance after scaling the pivot and owner is the scale factor
times the original distance at the residue reduced modulo the old grid. -/
theorem cyclicResidueDistance_scale_all_reduce
    (N p t b r' : Nat) :
    cyclicResidueDistance (N * (t * p)) (r' * (t * b)) =
      t * cyclicResidueDistance (N * p) ((r' % (N * p)) * b) := by
  calc
    cyclicResidueDistance (N * (t * p)) (r' * (t * b)) =
        cyclicResidueDistance (t * (N * p)) (t * (r' * b)) := by
          congr 1 <;> ring
    _ = t * cyclicResidueDistance (N * p) (r' * b) :=
      cyclicResidueDistance_mul_left t (N * p) (r' * b)
    _ = t * cyclicResidueDistance (N * p) ((r' % (N * p)) * b) := by
      congr 1
      have hcong : Nat.ModEq (N * p) ((r' % (N * p)) * b) (r' * b) :=
        (Nat.mod_modEq r' (N * p)).mul_right b
      rw [Nat.ModEq] at hcong
      unfold cyclicResidueDistance
      rw [hcong]

/-- Strict badness is preserved exactly under common scaling and reduction to
the original sheet.  Equality at the boundary remains safe. -/
theorem mem_pivotBadResidues_scale_reduce_iff
    {N p t b r' : Nat} (hN : 0 < N) (hp : 0 < p) (ht : 0 < t) :
    r' ∈ pivotBadResidues N (t * p) (t * b) ↔
      r' < t * (N * p) ∧
        r' % (N * p) ∈ pivotBadResidues N p b := by
  rw [mem_pivotBadResidues, mem_pivotBadResidues]
  rw [mem_pivotCandidates_scale_reduce_iff hN hp ht]
  rw [cyclicResidueDistance_scale_all_reduce]
  constructor
  · rintro ⟨⟨hrange, hcand⟩, hbad⟩
    exact ⟨hrange, hcand, (Nat.mul_lt_mul_left ht).mp hbad⟩
  · rintro ⟨hrange, hcand, hbad⟩
    exact ⟨⟨hrange, hcand⟩, (Nat.mul_lt_mul_left ht).mpr hbad⟩

theorem scaleSpeeds_pos {n t : Nat} {a : Fin n → Nat}
    (ht : 0 < t) (ha : ∀ i, 0 < a i) :
    ∀ i, 0 < scaleSpeeds t a i := by
  intro i
  exact Nat.mul_pos ht (ha i)

theorem scaleSpeeds_injective {n t : Nat} {a : Fin n → Nat}
    (ht : 0 < t) (ha : Function.Injective a) :
    Function.Injective (scaleSpeeds t a) := by
  intro i k hik
  apply ha
  exact Nat.mul_left_cancel ht hik

/-- Every labelled complete cover is preserved in both directions.  The
forward direction reduces an arbitrary scaled candidate; the reverse
direction uses the original candidate in the first sheet. -/
theorem pivotCompleteCover_scale_iff
    {n N t : Nat} {a : Fin n → Nat} {j : Fin n} {C : Finset (Fin n)}
    (hN : 0 < N) (hp : 0 < a j) (ht : 0 < t) :
    PivotCompleteCover N (scaleSpeeds t a) j C ↔
      PivotCompleteCover N a j C := by
  constructor
  · rintro ⟨hsubset, hcover⟩
    refine ⟨hsubset, ?_⟩
    intro r hr
    have hrange : r < t * (N * a j) := by
      have hrBase := (mem_pivotCandidates.mp hr).1
      have htOne : 1 ≤ t := ht
      calc
        r < N * a j := hrBase
        _ = 1 * (N * a j) := by simp
        _ ≤ t * (N * a j) := Nat.mul_le_mul_right (N * a j) htOne
    have hmod : r % (N * a j) = r :=
      Nat.mod_eq_of_lt (mem_pivotCandidates.mp hr).1
    have hrScaled : r ∈ pivotCandidates N (scaleSpeeds t a j) := by
      rw [scaleSpeeds]
      exact (mem_pivotCandidates_scale_reduce_iff hN hp ht).2
        ⟨hrange, by simpa [hmod] using hr⟩
    obtain ⟨i, hiC, hiBad⟩ := hcover r hrScaled
    refine ⟨i, hiC, ?_⟩
    have hreduce := (mem_pivotBadResidues_scale_reduce_iff
      (b := a i) hN hp ht).1 (by simpa [scaleSpeeds] using hiBad)
    simpa [hmod] using hreduce.2
  · rintro ⟨hsubset, hcover⟩
    refine ⟨hsubset, ?_⟩
    intro r hr
    have hreduce := (mem_pivotCandidates_scale_reduce_iff hN hp ht).1
      (by simpa [scaleSpeeds] using hr)
    obtain ⟨i, hiC, hiBad⟩ := hcover (r % (N * a j)) hreduce.2
    refine ⟨i, hiC, ?_⟩
    have hscaled := (mem_pivotBadResidues_scale_reduce_iff
      (b := a i) hN hp ht).2 ⟨hreduce.1, hiBad⟩
    simpa [scaleSpeeds] using hscaled

theorem pivotCovered_scale_iff
    {n N t : Nat} {a : Fin n → Nat} {j : Fin n}
    (hN : 0 < N) (hp : 0 < a j) (ht : 0 < t) :
    PivotCovered N (scaleSpeeds t a) j ↔ PivotCovered N a j := by
  exact pivotCompleteCover_scale_iff hN hp ht

theorem coveredPivots_scale
    {n N t : Nat} {a : Fin n → Nat}
    (hN : 0 < N) (ha : ∀ i, 0 < a i) (ht : 0 < t) :
    coveredPivots N (scaleSpeeds t a) = coveredPivots N a := by
  classical
  apply Finset.ext
  intro j
  simp only [coveredPivots, Finset.mem_filter, Finset.mem_univ, true_and]
  exact pivotCovered_scale_iff hN (ha j) ht

theorem isMaximumCoveredPivot_scale_iff
    {n N t : Nat} {a : Fin n → Nat} {j : Fin n}
    (hN : 0 < N) (ha : ∀ i, 0 < a i) (ht : 0 < t) :
    IsMaximumCoveredPivot N (scaleSpeeds t a) j ↔
      IsMaximumCoveredPivot N a j := by
  rw [IsMaximumCoveredPivot, IsMaximumCoveredPivot,
    coveredPivots_scale hN ha ht]
  constructor
  · rintro ⟨hj, hmax⟩
    refine ⟨hj, ?_⟩
    intro k hk
    exact (Nat.mul_le_mul_left_iff ht).mp (by simpa [scaleSpeeds] using hmax k hk)
  · rintro ⟨hj, hmax⟩
    refine ⟨hj, ?_⟩
    intro k hk
    exact (by simpa [scaleSpeeds] using (Nat.mul_le_mul_left_iff ht).mpr (hmax k hk))

theorem isInternalOwnerSet_scale_iff
    {n N t : Nat} {a : Fin n → Nat} {j : Fin n} {C : Finset (Fin n)}
    (hN : 0 < N) (ha : ∀ i, 0 < a i) (ht : 0 < t) :
    IsInternalOwnerSet N (scaleSpeeds t a) j C ↔
      IsInternalOwnerSet N a j C := by
  rw [IsInternalOwnerSet, IsInternalOwnerSet, coveredPivots_scale hN ha ht]

theorem internalCoverRedundantAt_scale_iff
    {n N t : Nat} {a : Fin n → Nat} {j : Fin n}
    (hN : 0 < N) (ha : ∀ i, 0 < a i) (ht : 0 < t) :
    InternalCoverRedundantAt N (scaleSpeeds t a) j ↔
      InternalCoverRedundantAt N a j := by
  constructor
  · intro h C hinternal hcover
    have hresult := h C
      ((isInternalOwnerSet_scale_iff hN ha ht).2 hinternal)
      ((pivotCompleteCover_scale_iff hN (ha j) ht).2 hcover)
    obtain ⟨i, hiC, hiCover⟩ := hresult
    exact ⟨i, hiC, (pivotCompleteCover_scale_iff hN (ha j) ht).1 hiCover⟩
  · intro h C hinternal hcover
    have hresult := h C
      ((isInternalOwnerSet_scale_iff hN ha ht).1 hinternal)
      ((pivotCompleteCover_scale_iff hN (ha j) ht).1 hcover)
    obtain ⟨i, hiC, hiCover⟩ := hresult
    exact ⟨i, hiC, (pivotCompleteCover_scale_iff hN (ha j) ht).2 hiCover⟩

/-- The unrestricted maximum-covered-pivot internal-cover redundancy theorem.
This is a proposition, not an asserted theorem. -/
def MaxCoveredPivotInternalCoverRedundancy : Prop :=
  ∀ (n : Nat), 2 ≤ n →
    ∀ a : Fin n → Nat,
      (∀ i, 0 < a i) → Function.Injective a →
      ∀ j : Fin n,
        IsMaximumCoveredPivot (n + 1) a j →
        InternalCoverRedundantAt (n + 1) a j

/-- The same universal theorem restricted to tuples whose maximum covered
pivot speed is divisible by `n + 1`.  It is defined independently of the
unrestricted proposition. -/
def MaxCoveredDivisiblePivotInternalCoverRedundancy : Prop :=
  ∀ (n : Nat), 2 ≤ n →
    ∀ a : Fin n → Nat,
      (∀ i, 0 < a i) → Function.Injective a →
      ∀ j : Fin n,
        IsMaximumCoveredPivot (n + 1) a j →
        (n + 1) ∣ a j →
        InternalCoverRedundantAt (n + 1) a j

/-- Common scaling by `n + 1` shows that the apparently narrower divisible
branch is equivalent to the full redundancy theorem.  Neither side is proved
by this equivalence. -/
theorem maxCoveredDivisible_iff_unrestricted :
    MaxCoveredDivisiblePivotInternalCoverRedundancy ↔
      MaxCoveredPivotInternalCoverRedundancy := by
  constructor
  · intro hdiv n hn a ha hinj j hj
    have hN : 0 < n + 1 := by omega
    let scaled : Fin n → Nat := scaleSpeeds (n + 1) a
    have hscaledPos : ∀ i, 0 < scaled i := scaleSpeeds_pos hN ha
    have hscaledInj : Function.Injective scaled := scaleSpeeds_injective hN hinj
    have hjScaled : IsMaximumCoveredPivot (n + 1) scaled j :=
      (isMaximumCoveredPivot_scale_iff hN ha hN).2 hj
    have hdivScaled : (n + 1) ∣ scaled j := by
      exact dvd_mul_right (n + 1) (a j)
    have hscaledRedundant :=
      hdiv n hn scaled hscaledPos hscaledInj j hjScaled hdivScaled
    exact (internalCoverRedundantAt_scale_iff hN ha hN).1 hscaledRedundant
  · intro hall n hn a ha hinj j hj _
    exact hall n hn a ha hinj j hj

end LonelyRunner
