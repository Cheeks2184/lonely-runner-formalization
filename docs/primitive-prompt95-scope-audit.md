# Primitive Prompt95 scope audit

Task: `VER-PRIMITIVE-P95-SCOPE-341`

Base commit: `10bf0da8e1fa7e389d1f67fba6e44cb92eb69d32`

Formal branch: `research/primitive-prompt95-scope`

## Disposition

`ACCEPT` at exact normalization-and-scope level.

The audited result proves no cover-redundancy branch and no instance of the
Lonely Runner Conjecture. It proves that the unrestricted Prompt95 proposition
is equivalent to the conjunction of:

1. its primitive, maximum-pivot-`N`-divisible restriction; and
2. its unrestricted maximum-pivot-`N`-nondivisible restriction.

The second factor is exactly Prompt98's frozen theorem. Both factors remain
open.

## Mathematical audit

For a positive family `a : Fin n -> Nat`, let

```text
g = gcd_i a(i),
b(i) = a(i)/g.
```

The family is nonempty in every application (`2 <= n`), so `g>0`. The finite
gcd divides every coordinate, `a=scaleSpeeds g b`, every `b(i)` is positive,
and injectivity of `b` follows by multiplying an equality by `g` and using
injectivity of `a`. The gcd of the quotient family is one, exactly the existing
`PrimitiveSpeedFamily` predicate.

The already proved common-scaling equivalences preserve every labelled cover,
the covered-pivot set, maximum-covered-pivot status, internality, and coverwise
redundancy. Therefore primitive Prompt95 is equivalent to unrestricted
Prompt95.

Divisibility is split only after normalization. This order is essential:
`N | a(j)` need not imply `N | b(j)`. Conversely,

```text
N does not divide g*b(j)  ->  N does not divide b(j),
```

so the unrestricted and primitive nondivisible branches are equivalent.
Combining these facts gives the formal theorem
`maxCovered_iff_primitiveDivisible_and_nondivisible`.

Two independently enumerated controls show both normalized arithmetic domains
are inhabited:

- `(1,4,16)` at `n=3`, `N=4` has covered speeds `{1,4}` and divisible maximum
  covered speed `4`;
- `(1,2,3,5)` at `n=4`, `N=5` has covered speeds `{1,2}` and nondivisible
  maximum covered speed `2`.

Neither fixture has an internal complete cover, so neither is a Prompt95 or
LRC counterexample. The tuple `(4,8,16)` normalizes to `(1,2,4)` and explicitly
refutes the claim that maximum-pivot `N`-divisibility survives gcd
normalization.

## Declaration audit

The source review checked:

- exact equation orientation `a = scaleSpeeds g (primitivePart a)`;
- the finite-gcd universal property in both directions;
- positivity and nonempty-family hypotheses;
- injectivity transport without assuming division is injective;
- strict use of the existing scaling theorems rather than a new residue map;
- the valid direction of nondivisibility descent;
- normalization before branch splitting; and
- exact retention of all Prompt95 coverwise quantifiers.

No hypothesis was strengthened, no conclusion was weakened, and no strict
boundary convention was changed.

## Replay

The source checkpoint was replayed in a separate WSL-native verification clone
at the formal branch commit. The pinned cache restored 8,638 artifacts. These
commands passed:

```text
lake build LonelyRunner.Prompt99Scaling LonelyRunner.DeletionPivotLifting
lake env lean LonelyRunner/PrimitivePrompt95.lean
lake build LonelyRunner.PrimitivePrompt95
lake build LonelyRunner
lake env lean LonelyRunner/AxiomAudit.lean
```

The six new axiom probes report only Lean's standard foundations
`propext`, `Classical.choice`, and `Quot.sound`. The source contains no
`sorry`, `admit`, `unsafe`, `native_decide`, or new axiom.

## Remaining obstruction

The exact remaining branch package is:

```text
PrimitiveMaxCoveredDivisiblePivotInternalCoverRedundancy
  AND
MaxCoveredNondivisiblePivotInternalCoverRedundancy.
```

Prompt98 attacks the second factor. The first factor is a genuine normalized
subdomain but has no proof or counterexample. Proving the scope equivalence
does not shorten either branch internally; it removes a semantic defect and
identifies the correct complementary edge.
