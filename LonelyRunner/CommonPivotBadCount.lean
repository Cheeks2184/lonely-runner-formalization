import LonelyRunner.CrossPivotScaling
import LonelyRunner.ModularCertificates
import LonelyRunner.PivotCounts
import Mathlib.Tactic

/-!
# A common-grid top-two certificate

If two proposed top pivots are coprime-to-`N` multiples of one positive
base pivot `g`, their scaled numerators represent the same time.  An exact
union bound for the lower-speed bad sets on the `g`-grid therefore produces
canonical certificates at both top pivots simultaneously.

This module proves only the stated sufficient criterion.  It does not assert
that its strict bad-count hypothesis holds for every speed family.
-/

namespace LonelyRunner

open scoped BigOperators

/-- The exact cardinality of the strict bad set for `v` on the common
`g`-pivot grid, written in the gcd/ceiling form from `PivotCounts`. -/
def commonPivotBadCount (N g v : Nat) : Nat :=
  Nat.gcd v (N * g) *
      (2 * (g ⌈/⌉ Nat.gcd v (N * g)) - 1) -
    Nat.gcd v g *
      (2 * (g ⌈/⌉ (N * Nat.gcd v g)) - 1)

/-- `commonPivotBadCount` is not an estimate: it is exactly the cardinality
of the canonical strict bad set. -/
theorem commonPivotBadCount_eq_card (N g v : Nat)
    (hN : 2 ≤ N) (hg : 0 < g) :
    commonPivotBadCount N g v = (pivotBadResidues N g v).card := by
  simpa [commonPivotBadCount] using
    (card_pivotBadResidues_exact N g v hN hg).symm

/-- A strict sum of the exact bad counts leaves a common candidate which is
closed-good for every member of the lower-speed family. -/
theorem exists_commonPivotCandidate_of_sum_badCount_lt
    {m N g : Nat} (lower : Fin m → Nat)
    (hN : 2 ≤ N) (hg : 0 < g)
    (hcount :
      ∑ i, commonPivotBadCount N g (lower i) < g * (N - 1)) :
    ∃ u ∈ pivotCandidates N g,
      ∀ i, u ∉ pivotBadResidues N g (lower i) := by
  apply exists_mem_avoiding_of_sum_card_lt_card
      (pivotCandidates N g) (fun i => pivotBadResidues N g (lower i))
  · intro i
    exact pivotBadResidues_subset N g (lower i)
  · have hsum :
        ∑ i, (pivotBadResidues N g (lower i)).card < g * (N - 1) := by
      simpa only [commonPivotBadCount_eq_card N g _ hN hg] using hcount
    rw [card_pivotCandidates N g (by omega)]
    simpa [Nat.mul_comm] using hsum

/-- A common-grid candidate is automatically closed-good for a speed which
is `g` times a unit modulo `N`. -/
theorem commonPivotCandidate_avoids_unitMultiple
    {N g q u : Nat} (hN : 2 ≤ N) (_hg : 0 < g)
    (_hq : 0 < q) (hcop : Nat.Coprime q N)
    (hu : u ∈ pivotCandidates N g) :
    u ∉ pivotBadResidues N g (g * q) := by
  intro hbad
  have huNotDvd : ¬ N ∣ u := (mem_pivotCandidates.mp hu).2
  have hquNotDvd : ¬ N ∣ q * u :=
    (not_dvd_mul_iff_of_coprime hcop).mpr huNotDvd
  have hNpos : 0 < N := by omega
  have hremPos : 0 < (q * u) % N := by
    apply Nat.pos_of_ne_zero
    intro hzero
    exact hquNotDvd (Nat.dvd_of_mod_eq_zero hzero)
  have hremLt : (q * u) % N < N := Nat.mod_lt _ hNpos
  have hdistPos : 0 < cyclicResidueDistance N (q * u) := by
    unfold cyclicResidueDistance
    exact lt_min hremPos (Nat.sub_pos_of_lt hremLt)
  have hscale :
      cyclicResidueDistance (N * g) (u * (g * q)) =
        g * cyclicResidueDistance N (q * u) := by
    simpa only [Nat.mul_assoc, Nat.mul_left_comm, Nat.mul_comm] using
      cyclicResidueDistance_mul_left g N (q * u)
  have hlt := (mem_pivotBadResidues.mp hbad).2
  rw [hscale] at hlt
  have hge : g ≤ g * cyclicResidueDistance N (q * u) := by
    have := Nat.mul_le_mul_left g hdistPos
    simpa using this
  exact (Nat.not_lt_of_ge hge) hlt

/-- Scaling a common-grid numerator does not change the represented real
time.  Positivity hypotheses make both denominators nonzero. -/
theorem scaledCommonPivotTime_eq
    {N g q u : Nat} (hN : 0 < N) (hg : 0 < g) (hq : 0 < q) :
    ((q * u : Nat) : Real) / ((N * (q * g) : Nat) : Real) =
      (u : Real) / ((N * g : Nat) : Real) := by
  field_simp
  push_cast
  ring

/-- Response 51's gcd-stratified common-pivot theorem.

The lower family is Fin-indexed and positive.  No injectivity hypothesis is
needed for this sufficient union bound.  The strict count inequality finds
one `u` on the `g`-grid.  Multiplying it by `alpha` and `beta` gives canonical
candidate numerators at both ordered top pivots, preserves every lower-speed
closed-good decision, and makes the other top speed closed-good by coprime
cancellation modulo `N`. -/
theorem simultaneousTopTwo_of_commonPivotBadCount
    {m N g alpha beta : Nat} (lower : Fin m → Nat)
    (hN : 2 ≤ N) (hg : 0 < g)
    (_hlowerPos : ∀ i, 0 < lower i)
    (halpha : 0 < alpha) (hbeta : 0 < beta) (_haltb : alpha < beta)
    (halphaCop : Nat.Coprime alpha N)
    (hbetaCop : Nat.Coprime beta N)
    (hcount :
      ∑ i, commonPivotBadCount N g (lower i) < g * (N - 1)) :
    ∃ u,
      u ∈ pivotCandidates N g ∧
      alpha * u ∈ pivotCandidates N (g * alpha) ∧
      beta * u ∈ pivotCandidates N (g * beta) ∧
      (∀ i, alpha * u ∉ pivotBadResidues N (g * alpha) (lower i)) ∧
      (∀ i, beta * u ∉ pivotBadResidues N (g * beta) (lower i)) ∧
      alpha * u ∉ pivotBadResidues N (g * alpha) (g * beta) ∧
      beta * u ∉ pivotBadResidues N (g * beta) (g * alpha) ∧
      ((alpha * u : Nat) : Real) /
          ((N * (g * alpha) : Nat) : Real) =
        (u : Real) / ((N * g : Nat) : Real) ∧
      ((beta * u : Nat) : Real) /
          ((N * (g * beta) : Nat) : Real) =
        (u : Real) / ((N * g : Nat) : Real) := by
  obtain ⟨u, hu, huLower⟩ :=
    exists_commonPivotCandidate_of_sum_badCount_lt lower hN hg hcount
  have halphaCandidate :
      alpha * u ∈ pivotCandidates N (g * alpha) := by
    simpa [Nat.mul_comm] using
      (mem_pivotCandidates_mul_iff halpha halphaCop).mpr hu
  have hbetaCandidate :
      beta * u ∈ pivotCandidates N (g * beta) := by
    simpa [Nat.mul_comm] using
      (mem_pivotCandidates_mul_iff hbeta hbetaCop).mpr hu
  have halphaLower :
      ∀ i, alpha * u ∉ pivotBadResidues N (g * alpha) (lower i) := by
    intro i
    simpa [Nat.mul_comm] using
      (not_mem_pivotBadResidues_mul_iff halpha halphaCop).mpr (huLower i)
  have hbetaLower :
      ∀ i, beta * u ∉ pivotBadResidues N (g * beta) (lower i) := by
    intro i
    simpa [Nat.mul_comm] using
      (not_mem_pivotBadResidues_mul_iff hbeta hbetaCop).mpr (huLower i)
  have huBeta : u ∉ pivotBadResidues N g (g * beta) :=
    commonPivotCandidate_avoids_unitMultiple hN hg hbeta hbetaCop hu
  have huAlpha : u ∉ pivotBadResidues N g (g * alpha) :=
    commonPivotCandidate_avoids_unitMultiple hN hg halpha halphaCop hu
  have halphaTop :
      alpha * u ∉ pivotBadResidues N (g * alpha) (g * beta) := by
    simpa [Nat.mul_comm] using
      (not_mem_pivotBadResidues_mul_iff halpha halphaCop).mpr huBeta
  have hbetaTop :
      beta * u ∉ pivotBadResidues N (g * beta) (g * alpha) := by
    simpa [Nat.mul_comm] using
      (not_mem_pivotBadResidues_mul_iff hbeta hbetaCop).mpr huAlpha
  refine ⟨u, hu, halphaCandidate, hbetaCandidate,
    halphaLower, hbetaLower, halphaTop, hbetaTop, ?_, ?_⟩
  · simpa [Nat.mul_comm] using
      (scaledCommonPivotTime_eq (N := N) (g := g) (q := alpha) (u := u)
        (by omega) hg halpha)
  · simpa [Nat.mul_comm] using
      (scaledCommonPivotTime_eq (N := N) (g := g) (q := beta) (u := u)
        (by omega) hg hbeta)

end LonelyRunner
