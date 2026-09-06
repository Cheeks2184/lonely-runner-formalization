# Five-adic natural normalization implementation

2026-09-06. This is the bounded routine implementation owned by
`/root/five_adic_natural_normalization`, requested as Terra/medium.  The
assigned source checkpoint was `f55744833dd2876e582f0e4e0726614b6b527a54`
on `codex/astra-five-adic-filtering`.  Workflow configuration, policy, and
state were read and `python3 scripts/validate_workflow.py` passed before
implementation.  No workflow state, Git metadata, root audit, Carry, or
Filtering file was edited.

## Scope and source contract

The implementation is [LonelyRunner/FiveAdicHardPattern.lean](../LonelyRunner/FiveAdicHardPattern.lean).
It imports exactly:

```lean
import LonelyRunner.PivotResidues
import Mathlib.Tactic
```

It deliberately does not import `LonelyRunner.FiveAdicCarry` or
`LonelyRunner.FiveAdicFiltering`, whose implementations remain independently
active and mutable.  The module proves only the accepted natural distance
adapter prefix:

* `cyclicResidueDistance_eq_of_mod_eq` unfolds the existing definition.
* `cyclicResidueDistance_eq_of_add_mod_eq_zero` splits the bounded residue
  sum into the zero and modulus cases.  The latter identifies each remainder
  with the other's natural complement before applying `min_comm`.
* `cyclicResidueDistance_mul_complement` applies that symmetry to
  `A * (P - s) + A * s = A * P`, requiring only `s ≤ P`; `A` may be zero or
  nonunit.
* `fiveAdic_normalize_unit` takes `s = d % (5 * 5^m)`, retains it at residues
  one or two, and otherwise uses its natural complement.  Its conclusion
  preserves the distance for every `A : Nat`, and it has no `m ≥ 1` premise.

The author plan and independent review were read in full before coding and
matched their requested SHA-256 values:

| Artifact | SHA-256 |
| --- | --- |
| `research/astra-five-adic-hard-adapter-plan.md` | `f2d5e74769d86dc729d0f63f098654a9a538bf690e0c47d952272259bba37eef` |
| `research/astra-five-adic-hard-adapter-plan-review.md` | `579b1ea58b05788dc388cba4bcabb26aa152bf23fdebc919c497815973e2303f` |
| `LonelyRunner/FiveAdicHardPattern.lean` after verification | `1ca9b35f3e642639dfebc87a96b45894bbea3536f9a28f018c71a61292fa7904` |

No carry tag/state/digit construction, correction, conditional assembly,
filtering descent, full five-runner theorem, or canonical LRC claim is made.

## Reproducible verification

The following complete probe was run from the repository root after the named
module build.  It checks the explicit universal theorem types, the P=1 and
composite-modulus symmetry controls, zero/nonunit multiplier complement
controls, the necessary `s ≤ P` countercontrol, and the `m=0` normalizer.

```sh
export PATH="$HOME/.elan/bin:$PATH"
lake env lean /dev/stdin <<'EOF'
import LonelyRunner.FiveAdicHardPattern

open LonelyRunner

example (P x y : Nat) (h : x % P = y % P) :
    cyclicResidueDistance P x = cyclicResidueDistance P y :=
  cyclicResidueDistance_eq_of_mod_eq P x y h

example (P X Y : Nat) (hP : 0 < P) (h : (X + Y) % P = 0) :
    cyclicResidueDistance P X = cyclicResidueDistance P Y :=
  cyclicResidueDistance_eq_of_add_mod_eq_zero P X Y hP h

example (P s A : Nat) (hP : 0 < P) (hs : s ≤ P) :
    cyclicResidueDistance P (A * (P - s)) = cyclicResidueDistance P (A * s) :=
  cyclicResidueDistance_mul_complement P s A hP hs

example (m d : Nat) (hd : ¬ 5 ∣ d) :
    ∃ x : Nat, 0 < x ∧ x < 5 * 5^m ∧ (x % 5 = 1 ∨ x % 5 = 2) ∧
      ∀ A : Nat, cyclicResidueDistance (5 * 5^m) (A*x) =
        cyclicResidueDistance (5 * 5^m) (A*d) :=
  fiveAdic_normalize_unit m d hd

example : cyclicResidueDistance 1 0 = cyclicResidueDistance 1 0 := by
  norm_num [cyclicResidueDistance]
example : cyclicResidueDistance 6 14 = cyclicResidueDistance 6 4 := by
  apply cyclicResidueDistance_eq_of_add_mod_eq_zero 6 14 4 <;> norm_num
example : cyclicResidueDistance 6 3 = cyclicResidueDistance 6 3 := by
  apply cyclicResidueDistance_eq_of_add_mod_eq_zero 6 3 3 <;> norm_num
example : cyclicResidueDistance 6 (5 * (6 - 0)) = cyclicResidueDistance 6 (5 * 0) := by
  exact cyclicResidueDistance_mul_complement 6 0 5 (by norm_num) (by norm_num)
example : cyclicResidueDistance 6 (0 * (6 - 6)) = cyclicResidueDistance 6 (0 * 6) := by
  exact cyclicResidueDistance_mul_complement 6 6 0 (by norm_num) (by norm_num)
example : cyclicResidueDistance 6 (5 * (6 - 2)) = cyclicResidueDistance 6 (5 * 2) := by
  exact cyclicResidueDistance_mul_complement 6 2 5 (by norm_num) (by norm_num)
example : cyclicResidueDistance 6 (5 * (6 - 6)) = cyclicResidueDistance 6 (5 * 6) := by
  exact cyclicResidueDistance_mul_complement 6 6 5 (by norm_num) (by norm_num)
example : cyclicResidueDistance 6 (6 - 8) ≠ cyclicResidueDistance 6 8 := by
  norm_num [cyclicResidueDistance]
example : ∃ x : Nat, 0 < x ∧ x < 5 * 5^0 ∧ (x % 5 = 1 ∨ x % 5 = 2) ∧
    ∀ A : Nat, cyclicResidueDistance (5 * 5^0) (A*x) =
      cyclicResidueDistance (5 * 5^0) (A*13) := by
  exact fiveAdic_normalize_unit 0 13 (by norm_num)

#print axioms LonelyRunner.cyclicResidueDistance_eq_of_mod_eq
#print axioms LonelyRunner.cyclicResidueDistance_eq_of_add_mod_eq_zero
#print axioms LonelyRunner.cyclicResidueDistance_mul_complement
#print axioms LonelyRunner.fiveAdic_normalize_unit
EOF
```

Actual terminal outcomes, all exit 0:

```text
$ lake env lean LonelyRunner/FiveAdicHardPattern.lean
(no output)

$ lake build LonelyRunner.FiveAdicHardPattern
✔ [3001/3001] Built LonelyRunner.FiveAdicHardPattern (1.7s)
Build completed successfully (3001 jobs).

$ lake env lean /dev/stdin < complete probe above
'LonelyRunner.cyclicResidueDistance_eq_of_mod_eq' does not depend on any axioms
'LonelyRunner.cyclicResidueDistance_eq_of_add_mod_eq_zero' depends on axioms: [propext, Quot.sound]
'LonelyRunner.cyclicResidueDistance_mul_complement' depends on axioms: [propext, Quot.sound]
'LonelyRunner.fiveAdic_normalize_unit' depends on axioms: [propext, Classical.choice, Quot.sound]

$ python3 scripts/validate_workflow.py
workflow structural validation passed; it cannot certify mathematical validity.

$ git diff --check -- LonelyRunner/FiveAdicHardPattern.lean
(no output)
```

The probe was first launched in parallel with the named build and failed only
because the just-built `.olean` was not yet present.  It was rerun sequentially
as recorded above and passed.  This is a build-order race, not a theorem or
source error.

The axiom reports are within the project completion allowlist
`propext`, `Classical.choice`, and `Quot.sound`.  This is a verified auxiliary
normalization checkpoint only; unrestricted LRC remains unresolved.
