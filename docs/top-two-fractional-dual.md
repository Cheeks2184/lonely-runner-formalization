# Fixed top-two fractional dual

## Status

**Exact fixed-instance certificate and rejected proof invariant.** This note
proves a statement only for positive injective integer seven-speed families
with `n=7`, `N=8`, and numerical top speeds `14,16` (so the five lower speeds
are distinct members of `1,...,13`). The existence of analogous fractional
weights for arbitrary top speeds is conjectural. Nothing here proves
unrestricted top-two pivot existence or LRC.

## Two-grid model

Take the disjoint union of the pivot-candidate grids for `14` and `16`, and
remove candidates already bad for the other top speed. There are exactly 168
remaining vertices, 84 from each grid. For a vertex `v`, its bad signature is

```text
C_v = {x in {1,...,13} : lower speed x is strictly bad at v}.
```

An earlier candidate proof invariant asked for `n-1=6` vertices with pairwise
disjoint signatures. Exhaustive dynamic programming over all 13-bit signature
unions proves that the maximum is only five. The verifier sees 43 distinct
nonzero signatures and 1,186 reachable union states. One maximum packing is

```text
(14,39), (14,15), (14,30), (14,46), (16,60).
```

Thus pairwise-disjoint private candidates cannot be the uniform proof.
This failure does not refute the top-two conjecture.

## Exact fractional certificate

Assign weight `1` to `(14,30)` and weight `1/2` to

```text
(14,5), (14,13), (14,15), (14,19), (14,22),
(14,34), (14,36), (14,47), (16,60).
```

Every listed residue is a valid pivot candidate and is good for the other top
speed. The total weight is

```text
1 + 9/2 = 11/2 > 5 = n-2.
```

For every possible lower speed `x=1,...,13`, the exact total weight of listed
vertices at which `x` is strictly bad is exactly one. Consequently any five
lower speeds cover weighted mass at most five, strictly less than `11/2`.
At least one positively weighted vertex remains good for both top speeds and
all five lower speeds. Therefore every positive injective integer seven-speed
family whose two numerical largest speeds are `14` and `16` has a top-two
pivot certificate.

This is a fractional set-cover dual argument. The proposed global invariant
would require such nonnegative weights for every `n>=2` and every admissible
pair `B<A`, with total weight greater than `n-2` and bad weight at most one for
each possible lower speed `x<B`. That invariant would imply the top-two pivot
conjecture, but it remains unproved and must be labelled `conjectural`.

## Reproduction

Run:

```bash
bash scripts/audit_top_two_fractional_dual.sh
python3 -m unittest tests.test_top_two_fractional_dual -v
```

The verifier uses only integer arithmetic, `fractions.Fraction`, and an exact
finite bitmask DP. It compares output byte-for-byte and checks both hashes:

```text
output  00e788ea07f8facbba61e24c51738f3326adaa02dc7d159127735716eedaeeea
source  c3a06c8d8843604c8f61ee871bc752a0578cf5c241b9030450c75fc2d83b7339
```
