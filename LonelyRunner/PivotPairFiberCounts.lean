import LonelyRunner.FiberCredits
import LonelyRunner.PivotCounts
import LonelyRunner.SimultaneousCongruence

/-!
# Pivot target fibers and pair intersections

This module refines a modular-pivot bad set by the exact residue attained by
one speed.  The target set is the strict cyclic ball, so the strict bad-set
endpoint convention is preserved.  Intersections of two target fibers are
the candidate (non-`N`-divisible) solutions of two simultaneous linear
congruences.
-/

namespace LonelyRunner

open scoped BigOperators

/-- Candidate pivot residues at which `speed` attains the exact canonical
target residue modulo `N * pivot`. -/
def pivotTargetFiber (N pivot speed target : ℕ) : Finset ℕ :=
  (pivotCandidates N pivot).filter fun r =>
    (r * speed) % (N * pivot) = target

theorem mem_pivotTargetFiber {N pivot speed target r : ℕ} :
    r ∈ pivotTargetFiber N pivot speed target ↔
      r ∈ pivotCandidates N pivot ∧
        (r * speed) % (N * pivot) = target := by
  simp [pivotTargetFiber]

/-- Fibers belonging to distinct exact targets are disjoint. -/
theorem disjoint_pivotTargetFiber_of_ne
    (N pivot speed x y : ℕ) (hxy : x ≠ y) :
    Disjoint (pivotTargetFiber N pivot speed x)
      (pivotTargetFiber N pivot speed y) := by
  rw [Finset.disjoint_left]
  intro r hrx hry
  have hx := (mem_pivotTargetFiber.mp hrx).2
  have hy := (mem_pivotTargetFiber.mp hry).2
  exact hxy (hx.symm.trans hy)

/-- The strict-ball target fibers disjointly cover exactly one pivot bad set.
Both positivity hypotheses are explicit so reduction modulo `N * pivot` has
a positive modulus. -/
theorem biUnion_pivotTargetFiber_eq_pivotBadResidues
    (N pivot speed : ℕ) (hN : 0 < N) (hpivot : 0 < pivot) :
    (strictCyclicBall (N * pivot) pivot).biUnion
        (pivotTargetFiber N pivot speed) =
      pivotBadResidues N pivot speed := by
  have hM : 0 < N * pivot := Nat.mul_pos hN hpivot
  ext r
  simp only [Finset.mem_biUnion, mem_pivotTargetFiber,
    mem_pivotBadResidues]
  constructor
  · rintro ⟨x, hxBall, hrCandidate, hrTarget⟩
    refine ⟨hrCandidate, ?_⟩
    have hxDist : cyclicResidueDistance (N * pivot) x < pivot := by
      exact (Finset.mem_filter.mp hxBall).2
    have hxlt : x < N * pivot :=
      Finset.mem_range.mp (Finset.mem_filter.mp hxBall).1
    unfold cyclicResidueDistance at hxDist ⊢
    rw [hrTarget]
    simpa [Nat.mod_eq_of_lt hxlt] using hxDist
  · rintro ⟨hrCandidate, hrDist⟩
    let x := (r * speed) % (N * pivot)
    refine ⟨x, ?_, hrCandidate, rfl⟩
    apply Finset.mem_filter.mpr
    refine ⟨Finset.mem_range.mpr (Nat.mod_lt _ hM), ?_⟩
    simpa [x, cyclicResidueDistance, Nat.mod_mod] using hrDist

/-- The exact candidate solutions for a pair of target congruences. -/
def pivotPairTargetFiber
    (N pivot b c x y : ℕ) : Finset ℕ :=
  pivotTargetFiber N pivot b x ∩ pivotTargetFiber N pivot c y

/-- Cardinality of the candidate solutions of the two target congruences. -/
def candidateSimultaneousCongruenceCount
    (N pivot b c x y : ℕ) : ℕ :=
  (pivotPairTargetFiber N pivot b c x y).card

/-- Natural representatives below `M` solving two simultaneous congruences.
Unlike `pivotPairTargetFiber`, this raw fiber still contains representatives
divisible by the pivot-grid scale `N`. -/
def simultaneousCongruenceNatResidues
    (M b c x y : ℕ) : Finset ℕ :=
  (Finset.range M).filter fun r =>
    Nat.ModEq M (b * r) x ∧ Nat.ModEq M (c * r) y

theorem mem_simultaneousCongruenceNatResidues
    {M b c x y r : ℕ} :
    r ∈ simultaneousCongruenceNatResidues M b c x y ↔
      r < M ∧ Nat.ModEq M (b * r) x ∧
        Nat.ModEq M (c * r) y := by
  simp [simultaneousCongruenceNatResidues]

/-- The natural representatives and the `Fin M` representatives used by
`simultaneousCongruenceResidues` are the same finite fiber. -/
def simultaneousCongruenceNatResiduesEquiv
    (M b c x y : ℕ) :
    {r // r ∈ simultaneousCongruenceNatResidues M b c x y} ≃
      {r // r ∈ simultaneousCongruenceResidues M b c x y} where
  toFun r := ⟨⟨r.1, (mem_simultaneousCongruenceNatResidues.mp r.2).1⟩, by
    rw [mem_simultaneousCongruenceResidues]
    exact (mem_simultaneousCongruenceNatResidues.mp r.2).2⟩
  invFun r := ⟨r.1.1, by
    rw [mem_simultaneousCongruenceNatResidues]
    exact ⟨r.1.2, mem_simultaneousCongruenceResidues.mp r.2⟩⟩
  left_inv r := by
    apply Subtype.ext
    rfl
  right_inv r := by
    apply Subtype.ext
    apply Fin.ext
    rfl

theorem card_simultaneousCongruenceNatResidues
    (M b c x y : ℕ) :
    (simultaneousCongruenceNatResidues M b c x y).card =
      (simultaneousCongruenceResidues M b c x y).card := by
  simpa only [Fintype.card_coe] using
    Fintype.card_congr (simultaneousCongruenceNatResiduesEquiv M b c x y)

/-- The exact raw natural-representative count, transferred from the audited
simultaneous-congruence theorem. -/
theorem card_simultaneousCongruenceNatResidues_exact
    (M b c x y : ℕ) (hM : 0 < M) :
    (simultaneousCongruenceNatResidues M b c x y).card =
      if SimultaneousCongruenceCompatible M b c x y then
        M.gcd (b.gcd c)
      else 0 := by
  rw [card_simultaneousCongruenceNatResidues]
  exact card_simultaneousCongruenceResidues M b c x y hM

theorem mem_pivotPairTargetFiber_iff_modEq
    {N pivot b c x y r : ℕ} (_hM : 0 < N * pivot)
    (hx : x < N * pivot) (hy : y < N * pivot) :
    r ∈ pivotPairTargetFiber N pivot b c x y ↔
      r < N * pivot ∧ ¬N ∣ r ∧
        Nat.ModEq (N * pivot) (b * r) x ∧
        Nat.ModEq (N * pivot) (c * r) y := by
  simp only [pivotPairTargetFiber, Finset.mem_inter,
    mem_pivotTargetFiber, mem_pivotCandidates]
  constructor
  · rintro ⟨⟨⟨hrlt, hrN⟩, hb⟩, ⟨-, hc⟩⟩
    refine ⟨hrlt, hrN, ?_, ?_⟩
    · change (b * r) % (N * pivot) = x % (N * pivot)
      simpa [Nat.mul_comm, Nat.mod_eq_of_lt hx] using hb
    · change (c * r) % (N * pivot) = y % (N * pivot)
      simpa [Nat.mul_comm, Nat.mod_eq_of_lt hy] using hc
  · rintro ⟨hrlt, hrN, hb, hc⟩
    refine ⟨⟨⟨hrlt, hrN⟩, ?_⟩, ⟨⟨hrlt, hrN⟩, ?_⟩⟩
    · change (b * r) % (N * pivot) = x % (N * pivot) at hb
      simpa [Nat.mul_comm, Nat.mod_eq_of_lt hx] using hb
    · change (c * r) % (N * pivot) = y % (N * pivot) at hc
      simpa [Nat.mul_comm, Nat.mod_eq_of_lt hy] using hc

/-- A target fiber's overlap with another pivot bad set is the sum of the
exact candidate simultaneous-congruence counts over all strict-ball targets
of the second speed. -/
theorem card_pivotTargetFiber_inter_pivotBadResidues
    (N pivot b c x : ℕ) (hN : 0 < N) (hpivot : 0 < pivot) :
    (pivotTargetFiber N pivot b x ∩
        pivotBadResidues N pivot c).card =
      ∑ y ∈ strictCyclicBall (N * pivot) pivot,
        candidateSimultaneousCongruenceCount N pivot b c x y := by
  classical
  let targets := strictCyclicBall (N * pivot) pivot
  let pieces := fun y => pivotPairTargetFiber N pivot b c x y
  have hdecomp : targets.biUnion pieces =
      pivotTargetFiber N pivot b x ∩ pivotBadResidues N pivot c := by
    rw [← biUnion_pivotTargetFiber_eq_pivotBadResidues N pivot c hN hpivot]
    ext r
    simp only [targets, pieces, pivotPairTargetFiber,
      Finset.mem_biUnion, Finset.mem_inter]
    aesop
  have hdisjoint : ∀ y ∈ targets, ∀ z ∈ targets, y ≠ z →
      Disjoint (pieces y) (pieces z) := by
    intro y hy z hz hyz
    exact (disjoint_pivotTargetFiber_of_ne N pivot c y z hyz).mono
      Finset.inter_subset_right Finset.inter_subset_right
  rw [← hdecomp]
  exact card_biUnion_eq_sum_card_of_pairwise_disjoint targets pieces hdisjoint

/-!
## Remaining subtraction bridge

The next arithmetic lemma should identify each candidate count with the raw
modulus-`N * pivot` count minus its `N`-divisible part.  For positive `N` and
`pivot`, and canonical targets `x,y < N * pivot`, the intended exact formula
is

`candidateSimultaneousCongruenceCount N pivot b c x y =`
`  card (simultaneousCongruenceNatResidues (N * pivot) b c x y) -`
`  if N ∣ x ∧ N ∣ y then`
`    card (simultaneousCongruenceNatResidues pivot b c (x / N) (y / N))`
`  else 0`.

Its remaining proof obligation is the explicit bijection `q ↦ N * q`
between the smaller-modulus fiber and the `N`-divisible part of the raw
fiber, using `Nat.ModEq.mul_left_cancel_iff'`.  No ordering or uniformity
claim is needed for that finite subtraction step.
-/

end LonelyRunner
