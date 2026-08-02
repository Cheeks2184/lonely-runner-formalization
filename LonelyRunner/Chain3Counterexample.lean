import LonelyRunner.PivotResidues

/-!
# Kernel-checked direct witness for the CHAIN3 counterexample tuple

The tuple below refutes only the three-step chain sufficient condition, which
is audited by the exact external certificate.  This module independently
kernel-checks the important scope guard: the tuple itself has the lonely time
`13 / 80`, including the allowed equality endpoint for speed `56`.
-/

namespace LonelyRunner

/-- The primitive nine-speed tuple rejecting `CHAIN3-UNIF`. -/
def chain3CounterexampleSpeeds : Fin 9 → ℕ :=
  ![8, 15, 35, 40, 48, 56, 75, 132, 147]

/-- The exact pivot residue `13` at speed `8` witnesses distance at least
`1 / 10` for every speed in the tuple. -/
theorem chain3Counterexample_directWitness :
    ∀ i : Fin 9, (10 : ℝ)⁻¹ ≤
      circleNorm (((13 : ℝ) / 80) * (chain3CounterexampleSpeeds i : ℝ)) := by
  intro i
  have hphase (speed : ℕ) :
      circleNorm (((13 : ℝ) / 80) * (speed : ℝ)) =
        (cyclicResidueDistance 80 (13 * speed) : ℝ) / 80 := by
    rw [← circleNorm_nat_div_eq 80 (13 * speed)]
    congr 1
    push_cast
    ring
  rw [hphase]
  fin_cases i <;>
    norm_num [chain3CounterexampleSpeeds, cyclicResidueDistance]

end LonelyRunner
