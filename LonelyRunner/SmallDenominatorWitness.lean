import LonelyRunner.PivotResidues
import Mathlib.Tactic

/-!
# Small-denominator witnesses

If no speed is divisible by a denominator `q ≤ N`, then time `1 / q` is an
immediate closed-boundary Lonely Runner witness.  The final theorem records
the contrapositive divisor-cover obstruction for positive integer speeds.
-/

namespace LonelyRunner

/-- Nondivisibility by a positive modulus forces positive cyclic residue
distance. -/
theorem one_le_cyclicResidueDistance_of_not_dvd {q a : Nat}
    (hq : 0 < q) (hnot : ¬q ∣ a) :
    1 ≤ cyclicResidueDistance q a := by
  apply one_le_cyclicResidueDistance_of_mod_ne_zero hq
  exact fun hmod => hnot (Nat.dvd_iff_mod_eq_zero.mpr hmod)

/-- The exact small-denominator witness inequality.  Notice the direction:
`q ≤ N` implies `1 / N ≤ 1 / q`. -/
theorem smallDenominator_circleNorm_ge {N q a : Nat}
    (hN : 0 < N) (hq : 0 < q) (hqN : q ≤ N) (hnot : ¬q ∣ a) :
    (N : Real)⁻¹ ≤ circleNorm ((a : Real) / (q : Real)) := by
  have hres : 1 ≤ cyclicResidueDistance q a :=
    one_le_cyclicResidueDistance_of_not_dvd hq hnot
  have hcircle := circleNorm_nat_div_ge hq hres
  have hqReal : (0 : Real) < (q : Real) := by exact_mod_cast hq
  have hNReal : (0 : Real) < (N : Real) := by exact_mod_cast hN
  have hqNReal : (q : Real) ≤ (N : Real) := by exact_mod_cast hqN
  have hinv : (N : Real)⁻¹ ≤ (q : Real)⁻¹ := by
    exact (inv_le_inv₀ hNReal hqReal).2 hqNReal
  have hcircle' : (q : Real)⁻¹ ≤ circleNorm ((a : Real) / (q : Real)) := by
    simpa [one_div] using hcircle
  exact hinv.trans hcircle'

/-- A common denominator missed by every speed supplies one time witnessing
the closed circle-distance bound for the entire finite family. -/
theorem smallDenominator_family_witness {n N q : Nat}
    (speeds : Fin n → Nat) (hN : 0 < N) (hq : 0 < q) (hqN : q ≤ N)
    (hmiss : ∀ i, ¬q ∣ speeds i) :
    ∃ t : Real, ∀ i,
      (N : Real)⁻¹ ≤ circleNorm (t * (speeds i : Real)) := by
  refine ⟨(q : Real)⁻¹, fun i => ?_⟩
  have hi := smallDenominator_circleNorm_ge hN hq hqN (hmiss i)
  convert hi using 1
  field_simp

/-- Specialization with the standard stationary-runner denominator `n+1`.
This conclusion is definitionally the witness clause of the positive-integer
formulation, so no separate encoding convention is hidden here. -/
theorem smallDenominator_stationary_witness {n q : Nat}
    (speeds : Fin n -> Nat) (hq : 2 <= q) (hqN : q <= n + 1)
    (hmiss : ∀ i, ¬ q ∣ speeds i) :
    exists t : Real, forall i,
      (((n + 1 : Nat) : Real)⁻¹) <=
        ‖((t * (speeds i : Real) : Real) : UnitCircle)‖ := by
  obtain ⟨t, ht⟩ := smallDenominator_family_witness
    speeds (N := n + 1) (q := q) (by omega) (by omega) hqN hmiss
  exact ⟨t, fun i => by simpa [circleNorm] using ht i⟩

/-- Contrapositive divisor-cover obstruction.  If no real time witnesses the
closed bound, then every integer denominator `q` from `2` through `N` divides
at least one speed.  This condition is necessary, not sufficient. -/
theorem divisor_cover_of_no_small_witness {n N : Nat}
    (speeds : Fin n → Nat) (hN : 0 < N)
    (hNoWitness : ¬∃ t : Real, ∀ i,
      (N : Real)⁻¹ ≤ circleNorm (t * (speeds i : Real))) :
    ∀ q, 2 ≤ q → q ≤ N → ∃ i, q ∣ speeds i := by
  intro q hq hqN
  by_contra hcover
  have hmiss : ∀ i, ¬q ∣ speeds i := by
    simpa only [not_exists] using hcover
  exact hNoWitness
    (smallDenominator_family_witness speeds hN (by omega) hqN hmiss)

end LonelyRunner
