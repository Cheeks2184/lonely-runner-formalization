# Five-adic hard-pattern assembly implementation

2026-09-06. This transferred routine implementation owns only this receipt and `LonelyRunner/FiveAdicHardPattern.lean`. It preserves the four existing normalization declarations and the already compiled tag/state/digit helper layer. The workflow validator passed before source work. No workflow state, cache, dependency, Carry, Filtering, Git, or unrelated evidence file was changed.

## Result

The source now declares the settled conditional theorem `fiveAdic_hard_pattern_of_carry` with the exact supplied `hcarry` contract, and `fiveAdic_hard_pattern`, its direct specialization by `fiveCarryTriple`. For each input unit, it obtains the pre-existing normalized representative, constructs its already compiled carry state, invokes `hcarry` once, and uses the common selected `u,k`. The product `(u.val + 1) * (1 + k.val * 5^m)` is proved a five-unit from `m >= 1`, then reduced by the pre-existing unit representative theorem. The three normalized distances transfer through the universal normalization equality; the top-level speed uses `fiveAdic_top_distance`, including its digit-four boundary.

No sorting, injectivity, gcd, maximum-speed, strict seed, or additional hypothesis was added. The conditional theorem remains conditional only on the specified carry contract. The helpers retain their valid `m = 0` scope; the assembly uses `m >= 1` solely for the correction's modulo-five unit fact.

## Focused reproducer

Run this from the repository root. It builds the named module before the stdin probe, checks the complete public shapes, and prints the exact axiom sets. It performs no source edits, searches, or computational shortcut.

```bash
set -euo pipefail
export PATH="$HOME/.elan/bin:$PATH"
lake build LonelyRunner.FiveAdicHardPattern
lake env lean --stdin <<'EOF'
import LonelyRunner.FiveAdicHardPattern
namespace LonelyRunner
example :
    ∀ (hcarry : ∀ s : Fin 3 → FiveCarryState,
      ∃ u : Fin 3, ∃ k : Fin 5, ∀ i,
        (fiveCarryDigit (s i) u k).val ∈ ({1, 2, 3} : Finset Nat))
      (m : Nat) (_ : 1 ≤ m) (d : Fin 3 → Nat)
      (_ : ∀ i, ¬ 5 ∣ d i) (v : Nat) (_ : ¬ 5 ∣ v),
    ∃ lam : Nat, 0 < lam ∧ lam < 5 * 5^m ∧ ¬ 5 ∣ lam ∧
      (∀ i, 5^m ≤ cyclicResidueDistance (5 * 5^m) (lam * d i)) ∧
      5^m ≤ cyclicResidueDistance (5 * 5^m) (lam * (5^m * v)) :=
  fiveAdic_hard_pattern_of_carry
example : ∀ (m : Nat) (_ : 1 ≤ m) (d : Fin 3 → Nat)
    (_ : ∀ i, ¬ 5 ∣ d i) (v : Nat) (_ : ¬ 5 ∣ v),
    ∃ lam : Nat, 0 < lam ∧ lam < 5 * 5^m ∧ ¬ 5 ∣ lam ∧
      (∀ i, 5^m ≤ cyclicResidueDistance (5 * 5^m) (lam * d i)) ∧
      5^m ≤ cyclicResidueDistance (5 * 5^m) (lam * (5^m * v)) :=
  fiveAdic_hard_pattern
#print axioms LonelyRunner.fiveAdic_hard_pattern_of_carry
#print axioms LonelyRunner.fiveAdic_hard_pattern
end LonelyRunner
EOF
sha256sum LonelyRunner/FiveAdicHardPattern.lean \
  LonelyRunner/FiveAdicCarry.lean LonelyRunner/FiveAdicFiltering.lean
```

## Terminal receipt

The source build passed before this exact stdin probe. The source was then frozen: no cosmetic or proof edit followed the verification.

| Item | SHA-256 or result |
| --- | --- |
| Assembly source | `b6caced5772fb4b33a7bb6d26792aaa49f5287557f3165c862edeaf7d69daeca` |
| Carry source | `f91d747198374da76ff9e62435db20a8917856d5b9dc52229ce576353cc11d81` |
| Filtering source | `1a210e70383e9b00d1a3aec321e9e1a838efcd26c24ca180101964e8c6e71429` |
| Probe program | `9dae8abcf963efc80258377c1cfa8fd1309cad94ec6d53609b026f0c898960c8` |
| Raw probe stdout | `b8d6cf6ddabfdac7c9dc9249cb121e7a6cadc6fad232571f5a88da94689d3f1d` |
| `lake build LonelyRunner.FiveAdicHardPattern` | exit 0 |
| `lake env lean --stdin` | exit 0 |

The probe printed exactly these two results:

```text
'LonelyRunner.fiveAdic_hard_pattern_of_carry' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.fiveAdic_hard_pattern' depends on axioms: [propext, Classical.choice, Quot.sound]
```

The only probe diagnostic was Lean's unused proof-binder linter warning for the first example's `hcarry`; it did not affect checking. No `sorry`, `admit`, custom axiom, `native_decide`, or non-allowed axiom appears in the owned declarations.
