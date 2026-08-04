import LonelyRunner.Prompt99Scaling
import LonelyRunner.DeletionPivotLifting
import Mathlib.Algebra.GCDMonoid.Finset

/-!
# Primitive normalization of the Prompt95 cover-redundancy route

Every nonempty positive natural speed family is a common positive scaling of
its primitive part.  Combining that factorization with the exact common-scale
invariance in `Prompt99Scaling` identifies the honest arithmetic split behind
Prompts 98 and 99:

* the unrestricted nondivisible maximum-pivot branch; and
* the **primitive** divisible maximum-pivot branch.

Their conjunction is equivalent to the unrestricted Prompt95 redundancy
proposition.  This module proves only normalization and scope equivalences.  It
does not prove either branch, Prompt95, or the Lonely Runner Conjecture.
-/

namespace LonelyRunner

open Finset

/-- The greatest common divisor of all labelled speeds. -/
def speedGCD {n : Nat} (a : Fin n → Nat) : Nat :=
  Finset.univ.gcd a

/-- Divide every labelled speed by the common gcd. -/
def primitivePart {n : Nat} (a : Fin n → Nat) : Fin n → Nat :=
  fun i => a i / speedGCD a

theorem speedGCD_dvd {n : Nat} (a : Fin n → Nat) (i : Fin n) :
    speedGCD a ∣ a i := by
  exact Finset.gcd_dvd (s := Finset.univ) (f := a) (Finset.mem_univ i)

/-- The repository's divisor formulation of primitivity is exactly gcd one. -/
theorem primitiveSpeedFamily_iff_speedGCD_eq_one {n : Nat} (a : Fin n → Nat) :
    PrimitiveSpeedFamily a ↔ speedGCD a = 1 := by
  constructor
  · intro h
    exact h (speedGCD a) (speedGCD_dvd a)
  · intro hg d hd
    apply Nat.dvd_one.mp
    rw [← hg]
    exact Finset.dvd_gcd fun i _ => hd i

theorem speedGCD_pos {n : Nat} (hn : 0 < n) (a : Fin n → Nat)
    (ha : ∀ i, 0 < a i) :
    0 < speedGCD a := by
  apply Nat.pos_of_ne_zero
  rw [speedGCD, Finset.gcd_ne_zero_iff]
  let i0 : Fin n := ⟨0, hn⟩
  exact ⟨i0, Finset.mem_univ i0, (ha i0).ne'⟩

theorem primitivePart_pos {n : Nat} (hn : 0 < n) (a : Fin n → Nat)
    (ha : ∀ i, 0 < a i) :
    ∀ i, 0 < primitivePart a i := by
  intro i
  exact Nat.div_pos
    (Nat.le_of_dvd (ha i) (speedGCD_dvd a i))
    (speedGCD_pos hn a ha)

/-- Multiplying the primitive part by the common gcd recovers every label. -/
theorem scaleSpeeds_speedGCD_primitivePart {n : Nat} (_hn : 0 < n)
    (a : Fin n → Nat) (_ha : ∀ i, 0 < a i) :
    a = scaleSpeeds (speedGCD a) (primitivePart a) := by
  funext i
  exact (Nat.mul_div_cancel' (speedGCD_dvd a i)).symm

theorem primitiveSpeedFamily_primitivePart {n : Nat} (hn : 0 < n)
    (a : Fin n → Nat) (ha : ∀ i, 0 < a i) :
    PrimitiveSpeedFamily (primitivePart a) := by
  apply (primitiveSpeedFamily_iff_speedGCD_eq_one (primitivePart a)).2
  let i0 : Fin n := ⟨0, hn⟩
  change Finset.univ.gcd (fun j => a j / Finset.univ.gcd a) = 1
  exact Finset.gcd_div_eq_one (s := Finset.univ) (f := a)
    (i := i0) (Finset.mem_univ i0) (ha i0).ne'

/-- Canonical positive primitive factorization of a positive nonempty family. -/
theorem exists_scaleSpeeds_primitive {n : Nat} (hn : 0 < n)
    (a : Fin n → Nat) (ha : ∀ i, 0 < a i) :
    ∃ (g : Nat) (b : Fin n → Nat),
      0 < g ∧
      (∀ i, 0 < b i) ∧
      PrimitiveSpeedFamily b ∧
      a = scaleSpeeds g b := by
  exact ⟨speedGCD a, primitivePart a,
    speedGCD_pos hn a ha,
    primitivePart_pos hn a ha,
    primitiveSpeedFamily_primitivePart hn a ha,
    scaleSpeeds_speedGCD_primitivePart hn a ha⟩

/-- Prompt95 restricted to primitive positive speed families. -/
def PrimitiveMaxCoveredPivotInternalCoverRedundancy : Prop :=
  ∀ (n : Nat), 2 ≤ n →
    ∀ a : Fin n → Nat,
      (∀ i, 0 < a i) → Function.Injective a → PrimitiveSpeedFamily a →
      ∀ j : Fin n,
        IsMaximumCoveredPivot (n + 1) a j →
        InternalCoverRedundantAt (n + 1) a j

/-- The primitive branch where the maximum covered speed is divisible by
`n + 1`.  Unlike the unnormalized Prompt99 condition, common scaling cannot
force this premise while preserving primitivity. -/
def PrimitiveMaxCoveredDivisiblePivotInternalCoverRedundancy : Prop :=
  ∀ (n : Nat), 2 ≤ n →
    ∀ a : Fin n → Nat,
      (∀ i, 0 < a i) → Function.Injective a → PrimitiveSpeedFamily a →
      ∀ j : Fin n,
        IsMaximumCoveredPivot (n + 1) a j →
        (n + 1) ∣ a j →
        InternalCoverRedundantAt (n + 1) a j

/-- The complementary primitive nondivisible branch. -/
def PrimitiveMaxCoveredNondivisiblePivotInternalCoverRedundancy : Prop :=
  ∀ (n : Nat), 2 ≤ n →
    ∀ a : Fin n → Nat,
      (∀ i, 0 < a i) → Function.Injective a → PrimitiveSpeedFamily a →
      ∀ j : Fin n,
        IsMaximumCoveredPivot (n + 1) a j →
        ¬(n + 1) ∣ a j →
        InternalCoverRedundantAt (n + 1) a j

/-- Prompt98's nondivisible branch, with no primitivity restriction. -/
def MaxCoveredNondivisiblePivotInternalCoverRedundancy : Prop :=
  ∀ (n : Nat), 2 ≤ n →
    ∀ a : Fin n → Nat,
      (∀ i, 0 < a i) → Function.Injective a →
      ∀ j : Fin n,
        IsMaximumCoveredPivot (n + 1) a j →
        ¬(n + 1) ∣ a j →
        InternalCoverRedundantAt (n + 1) a j

/-- Gcd normalization loses no Prompt95 instances. -/
theorem primitiveMaxCovered_iff_unrestricted :
    PrimitiveMaxCoveredPivotInternalCoverRedundancy ↔
      MaxCoveredPivotInternalCoverRedundancy := by
  constructor
  · intro hprimitive n hn a ha hinjective j hj
    obtain ⟨g, b, hg, hb, hbPrimitive, hscale⟩ :=
      exists_scaleSpeeds_primitive (Nat.zero_lt_of_lt hn) a ha
    have hbInjective : Function.Injective b := by
      intro i k hik
      apply hinjective
      rw [hscale]
      simp only [scaleSpeeds, hik]
    have hN : 0 < n + 1 := by omega
    have hjScaled : IsMaximumCoveredPivot (n + 1) (scaleSpeeds g b) j := by
      simpa [hscale] using hj
    have hjPrimitive : IsMaximumCoveredPivot (n + 1) b j :=
      (isMaximumCoveredPivot_scale_iff hN hb hg).1 hjScaled
    have hredundantPrimitive :=
      hprimitive n hn b hb hbInjective hbPrimitive j hjPrimitive
    have hredundantScaled :=
      (internalCoverRedundantAt_scale_iff hN hb hg).2 hredundantPrimitive
    simpa [hscale] using hredundantScaled
  · intro hunrestricted n hn a ha hinjective _ j hj
    exact hunrestricted n hn a ha hinjective j hj

/-- On the normalized domain, divisibility gives an honest exhaustive split. -/
theorem primitiveMaxCovered_split_iff :
    PrimitiveMaxCoveredPivotInternalCoverRedundancy ↔
      PrimitiveMaxCoveredDivisiblePivotInternalCoverRedundancy ∧
        PrimitiveMaxCoveredNondivisiblePivotInternalCoverRedundancy := by
  constructor
  · intro h
    constructor
    · intro n hn a ha hinjective hprimitive j hj _
      exact h n hn a ha hinjective hprimitive j hj
    · intro n hn a ha hinjective hprimitive j hj _
      exact h n hn a ha hinjective hprimitive j hj
  · rintro ⟨hdivisible, hnondivisible⟩ n hn a ha hinjective hprimitive j hj
    by_cases hdiv : (n + 1) ∣ a j
    · exact hdivisible n hn a ha hinjective hprimitive j hj hdiv
    · exact hnondivisible n hn a ha hinjective hprimitive j hj hdiv

/-- The unrestricted nondivisible branch is equivalent to its primitive
restriction.  If `n + 1` does not divide `g * b_j`, it cannot divide `b_j`. -/
theorem maxCoveredNondivisible_iff_primitiveNondivisible :
    MaxCoveredNondivisiblePivotInternalCoverRedundancy ↔
      PrimitiveMaxCoveredNondivisiblePivotInternalCoverRedundancy := by
  constructor
  · intro h n hn a ha hinjective _ j hj hnot
    exact h n hn a ha hinjective j hj hnot
  · intro hprimitive n hn a ha hinjective j hj hnot
    obtain ⟨g, b, hg, hb, hbPrimitive, hscale⟩ :=
      exists_scaleSpeeds_primitive (Nat.zero_lt_of_lt hn) a ha
    have hbInjective : Function.Injective b := by
      intro i k hik
      apply hinjective
      rw [hscale]
      simp only [scaleSpeeds, hik]
    have hN : 0 < n + 1 := by omega
    have hjScaled : IsMaximumCoveredPivot (n + 1) (scaleSpeeds g b) j := by
      simpa [hscale] using hj
    have hjPrimitive : IsMaximumCoveredPivot (n + 1) b j :=
      (isMaximumCoveredPivot_scale_iff hN hb hg).1 hjScaled
    have hnotPrimitive : ¬(n + 1) ∣ b j := by
      intro hdvd
      apply hnot
      rw [hscale]
      exact dvd_mul_of_dvd_right hdvd g
    have hredundantPrimitive :=
      hprimitive n hn b hb hbInjective hbPrimitive j hjPrimitive hnotPrimitive
    have hredundantScaled :=
      (internalCoverRedundantAt_scale_iff hN hb hg).2 hredundantPrimitive
    simpa [hscale] using hredundantScaled

/-- Exact corrected Prompt98/Prompt99 scope theorem.  Full Prompt95 is the
conjunction of Prompt98's unrestricted nondivisible branch and the genuinely
narrower primitive divisible branch.  The conjunction is not proved here. -/
theorem maxCovered_iff_primitiveDivisible_and_nondivisible :
    MaxCoveredPivotInternalCoverRedundancy ↔
      PrimitiveMaxCoveredDivisiblePivotInternalCoverRedundancy ∧
        MaxCoveredNondivisiblePivotInternalCoverRedundancy := by
  rw [← primitiveMaxCovered_iff_unrestricted]
  rw [primitiveMaxCovered_split_iff]
  rw [maxCoveredNondivisible_iff_primitiveNondivisible]

end LonelyRunner
