import LonelyRunner.PivotResidues

/-!
# Kernel-checked scope guard for the OPT-ADD counterexample tuple

The external exact certificate shows that the tuple below rejects the
optimized-additive sufficient condition at every pivot.  This module proves a
separate and crucial fact inside Lean's kernel: the tuple itself has an exact
Lonely Runner witness, so failure of that sufficient condition is not confused
with failure of the pivot-certificate statement or the conjecture.
-/

namespace LonelyRunner

/-- The primitive nine-speed tuple rejecting `OPT-ADD-UNIF`. -/
def optAddCounterexampleSpeeds : Fin 9 → ℕ :=
  ![15, 21, 40, 48, 56, 105, 126, 280, 1200]

/-- Pivot speed `48` and residue `39` give time `39/480 = 13/160`; every
coordinate has circular distance at least `1/10`, with speed `48` attaining
the allowed boundary exactly. -/
theorem optAddCounterexample_directWitness :
    ∀ i : Fin 9, (10 : ℝ)⁻¹ ≤
      circleNorm (((39 : ℝ) / 480) * (optAddCounterexampleSpeeds i : ℝ)) := by
  intro i
  have hphase (speed : ℕ) :
      circleNorm (((39 : ℝ) / 480) * (speed : ℝ)) =
        (cyclicResidueDistance 480 (39 * speed) : ℝ) / 480 := by
    calc
      circleNorm (((39 : ℝ) / 480) * (speed : ℝ)) =
          circleNorm (((39 * speed : ℕ) : ℝ) / (480 : ℝ)) := by
            congr 1
            push_cast
            ring
      _ = (cyclicResidueDistance 480 (39 * speed) : ℝ) / 480 :=
        circleNorm_nat_div_eq 480 (39 * speed)
  rw [hphase]
  fin_cases i <;>
    norm_num [optAddCounterexampleSpeeds, cyclicResidueDistance]

end LonelyRunner
