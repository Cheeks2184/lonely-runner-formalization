# Five-adic decomposition implementation

This note records the bounded implementation of the accepted positive Fin 4
adapter in `LonelyRunner/FiveAdicDecomposition.lean`.  It is not a proof of
the five-runner case or of the unrestricted Lonely Runner Conjecture.

The module exposes three contracts:

* `fiveAdic_positive_decomposition`: every `v : Nat` with `0 < v` is exactly
  `5^ell * u`, where `ell = padicValNat 5 v`, `u = v / 5^ell`, `0 < u`, and
  `5 ∤ u`.
* `fin4_level_dichotomy`: for `ell : Fin 4 -> Nat` bounded by an attained
  maximum `m`, either every layer `j < m` has cardinality at most two, or one
  `j < m` occupies precisely the three nonmaximum positions and the remaining
  position has label `m`.
* `fiveAdic_cyclicResidueDistance_mul_left`: scaling an argument and its modulus by a
  common natural `g` scales the cyclic residue distance by `g`, including
  `g = 0`.

The valuation proof uses the local `Fact (Nat.Prime 5)` instance and only the
natural `pow_padicValNat_dvd` and `pow_succ_padicValNat_not_dvd` APIs.  The
Fin 4 proof counts a crowded fiber inside `univ.erase p`; it does not enumerate
natural labels and assumes no speed distinctness, gcd normalization, or minimum
label.

## Focused reproducible check

The replay below first builds the named module, then supplies the complete
probe to Lean on standard input.  It was run with the pinned Lean `4.32.1`
toolchain and the repository's pinned mathlib revision
`520045ab14e26149ee970e2e617ca04b09bde5d6`.

```bash
set -euo pipefail
export PATH="$HOME/.elan/bin:$PATH"
lake build LonelyRunner.FiveAdicDecomposition
lake env lean --stdin <<'EOF'
import LonelyRunner.FiveAdicDecomposition

open Finset
open LonelyRunner

#check fiveAdic_positive_decomposition
#check fin4_level_dichotomy
#check fiveAdic_cyclicResidueDistance_mul_left

example (v : Nat) (hv : 0 < v) :
    v = 5 ^ fiveAdicExponent v * fiveAdicUnit v ∧
      0 < fiveAdicUnit v ∧ ¬ 5 ∣ fiveAdicUnit v :=
  fiveAdic_positive_decomposition v hv

example (ell : Fin 4 → Nat) (m : Nat) (hbound : ∀ i, ell i ≤ m)
    (hmax : ∃ p, ell p = m) :
    (∀ j, j < m → (univ.filter fun i => ell i = j).card ≤ 2) ∨
      ∃ j, j < m ∧ ∃ p : Fin 4, ell p = m ∧
        ∀ i, i ≠ p → ell i = j :=
  fin4_level_dichotomy ell m hbound hmax

example (g P x : Nat) :
    cyclicResidueDistance (g * P) (g * x) =
      g * cyclicResidueDistance P x :=
  fiveAdic_cyclicResidueDistance_mul_left g P x

/- The positive hypothesis excludes the zero valuation control. -/
example : ¬ (0 < (0 : Nat)) := by decide
example : 5 ∣ fiveAdicUnit 0 := by simp [fiveAdicUnit, fiveAdicExponent]

/- Repeated lower labels, all-top labels, and a crowded lower layer. -/
example : (univ.filter fun i : Fin 4 => (![0, 0, 2, 3] i : Nat) = 0).card = 2 := by decide
example : (univ.filter fun i : Fin 4 => (![3, 3, 3, 3] i : Nat) = 3).card = 4 := by decide
example : (univ.filter fun i : Fin 4 => (![1, 1, 1, 3] i : Nat) = 1).card = 3 := by decide
example :
    (∀ j, j < 3 →
      (univ.filter fun i : Fin 4 => (![0, 0, 2, 3] i : Nat) = j).card ≤ 2) ∨
      ∃ j, j < 3 ∧ ∃ p : Fin 4, (![0, 0, 2, 3] p : Nat) = 3 ∧
        ∀ i, i ≠ p → (![0, 0, 2, 3] i : Nat) = j := by
  exact fin4_level_dichotomy _ 3 (by decide) ⟨3, by decide⟩
example :
    (∀ j, j < 3 →
      (univ.filter fun i : Fin 4 => (![3, 3, 3, 3] i : Nat) = j).card ≤ 2) ∨
      ∃ j, j < 3 ∧ ∃ p : Fin 4, (![3, 3, 3, 3] p : Nat) = 3 ∧
        ∀ i, i ≠ p → (![3, 3, 3, 3] i : Nat) = j := by
  exact fin4_level_dichotomy _ 3 (by decide) ⟨0, by decide⟩
example :
    (∀ j, j < 3 →
      (univ.filter fun i : Fin 4 => (![1, 1, 1, 3] i : Nat) = j).card ≤ 2) ∨
      ∃ j, j < 3 ∧ ∃ p : Fin 4, (![1, 1, 1, 3] p : Nat) = 3 ∧
        ∀ i, i ≠ p → (![1, 1, 1, 3] i : Nat) = j := by
  exact fin4_level_dichotomy _ 3 (by decide) ⟨3, by decide⟩

example : cyclicResidueDistance (0 * 25) (0 * 7) =
    0 * cyclicResidueDistance 25 7 := fiveAdic_cyclicResidueDistance_mul_left 0 25 7
example : cyclicResidueDistance (5 * 25) (5 * 7) =
    5 * cyclicResidueDistance 25 7 := fiveAdic_cyclicResidueDistance_mul_left 5 25 7

#print axioms fiveAdic_positive_decomposition
#print axioms fin4_level_dichotomy
#print axioms fiveAdic_cyclicResidueDistance_mul_left
EOF
```

The command exits `0`.  The universal examples verify the full stated types,
not merely concrete instances.  The concrete controls cover the excluded zero
input (whose computed unit is divisible by five), repeated lower labels, an
all-top family, the three-at-one-lower-level alternative, and scaling at both
`g = 0` and `g = 5`.

Its exact `#print axioms` output is:

```text
'LonelyRunner.fiveAdic_positive_decomposition' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.fin4_level_dichotomy' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.fiveAdic_cyclicResidueDistance_mul_left' depends on axioms: [propext]
```

The final source SHA-256 is
`049da0b10b478fe2cdb0a6239ebc97a60317022f15263c317d5aa56415a7357e`.
The exact probe program between `EOF` markers has SHA-256
`7f8d47af4b2cf523ebf9d473f701c61003ce9992807ccd42953e101d6b36646c`.
The final build and stdin probe had exit status `0`.  Their SHA-256 stdout
hashes are respectively `ba7bbaddb4ef474f118cdedd6496b70a807d9216d8b72acb7e44d9ae5ca42305`
and `5f78dba9514e77639c6ac6b475f6062ddf67813db595ddf2604db544a161f276`.

An earlier version of this note named an external `/tmp` file and listed the
probe before the module build.  That sequence was not a valid standalone
reproducer because a stale module artifact could be selected.  This was a
documentation-only failed attempt; the source was not changed.
