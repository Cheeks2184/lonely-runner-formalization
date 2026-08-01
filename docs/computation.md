# Exact finite-instance computation

The script `scripts/check_integer_tuple.py` is a reproducible exact-arithmetic
checker for a **fixed, nonempty tuple of positive integer speeds**. If the tuple
has `n` entries, it checks the stationary-runner target `1/(n+1)`. Repeated
speeds are accepted by the single-instance checker; the exhaustive command
uses distinct speeds because that is the standard integer formulation.

## Why the search is finite

For positive integer `v`, the function

\[
  d_v(t)=\lVert vt\rVert_{\mathbb R/\mathbb Z}
\]

is periodic with period one and is affine between consecutive points
`k/(2v)`, for `0 <= k <= 2v`. Form the sorted union of these breakpoints for
all speeds. On each resulting closed cell, every `d_v` has an affine formula,
so their pointwise minimum is a concave piecewise-affine function. Its maximum
on that cell occurs at an endpoint or at an intersection of two affine pieces.
The checker enumerates a superset of exactly those rational points and compares
their values using Python `Fraction`. Thus no floating-point tolerance or grid
resolution affects the result.

This also proves the reported optimum for the supplied finite tuple, subject to
the small checker and the elementary finite-search argument above. The JSON
certificate verifier deterministically regenerates the candidate set with the
same implementation, validates field types, and requires every field to match
the canonical recomputation. It is not an independent second algorithm.

## Reproduction

From the repository root, with Python 3.10 or newer:

```sh
python3 scripts/check_integer_tuple.py check 1 2 3
python3 scripts/check_integer_tuple.py check 1 2 3 --certificate /tmp/lr-123.json
python3 scripts/check_integer_tuple.py verify /tmp/lr-123.json
python3 scripts/check_integer_tuple.py exhaustive --max-runners 4 --max-speed 8
python3 scripts/search_residual.py --runners 3 --max-speed 30 --primitive-only --sol-pivot-counts
python3 scripts/search_residual.py --runners 4 --max-speed 30 --primitive-only --sol-pivot-counts
python3 scripts/search_residual.py --runners 5 --max-speed 30 --primitive-only --sol-pivot-counts
python3 -m unittest discover -s tests -v
```

The committed regression suite checks the tight consecutive tuples
`(1)`, `(1,2)`, ..., `(1,2,3,4,5,6)`, for which the exact optimum is
`1/(n+1)`. It also exhausts all 162 distinct increasing tuples with one through
four entries selected from speeds `1,...,8`. The corresponding committed,
recomputed-on-test outputs are `certificates/integer-1-2-3.json` and
`certificates/exhaustive-4-of-8.json`.

## Scope and limitations

The computation proves existence of a suitable rational time for each tuple
it actually checks, and its complete candidate enumeration proves the reported
maximum for each such tuple. It does **not** prove any of the following:

- the integer conjecture for unbounded speeds or arbitrarily many runners;
- the reduction from arbitrary real speeds to integer speeds;
- the full Lonely Runner Conjecture;
- correctness of Python, its `Fraction` implementation, or this checker inside
  Lean's trusted kernel.

In particular, these are executable certificates checked by an ordinary Python
program, not Lean-formalized certificates. They may support testing and
counterexample search, but they cannot be labeled `proved-lean`.

## Residual modular-certificate audit

`scripts/search_residual.py` partitions primitive increasing tuples by the
formal fast-insertion inequality, the minimum-scale residue bands, and the
remaining residual class. On that residual class it constructs the modular
bad sets described in `docs/modular-pivot-certificates.md`, compares every
literal bad-set cardinality with the gcd/ceiling formula, and searches all
pivots, runner orderings, and allowable one- or two-parent choices. The three
commands above reproduce the complete speed-30 table in that note. The script
also exposes exact fastest-half-period and anchor-grid searches used to reject
overstrong candidate lemmas.

The regression tests compare the count formula with literal residue sets,
check certificate soundness on small boxes, and preserve counterexamples to
minimum-grid, fastest-half-period, fastest-pivot, and false criterion-
subsumption claims. These are independent executable checks of formulas and
finite data, not a formal enumeration or an all-dimensional result.

## Exact bad-set interval audit

The companion module `scripts/check_bad_sets.py` performs rational interval
union and intersection calculations for
`{t in [0,1] : ||v*t|| < delta}`. Its regression test for speeds `(1,2,3,4)`
at `delta=1/5` independently records every pair and triple intersection, the
fourfold intersection, the full union, and the exact safe boundary points.
Endpoint membership is checked by evaluating the circle-distance inequality;
it is not inferred from measure-zero interval endpoints.

Writing `A_v = {t in [0,1] : ||v*t|| < 1/5}`, the audited pair measures are

| intersection | `A_1 A_2` | `A_1 A_3` | `A_1 A_4` | `A_2 A_3` | `A_2 A_4` | `A_3 A_4` |
|---|---:|---:|---:|---:|---:|---:|
| measure | `1/5` | `2/15` | `1/10` | `2/15` | `1/5` | `1/6` |

Their sum is `14/15`. The four triple measures, in lexicographic order, are
`2/15, 1/10, 1/10, 1/10`, with sum `13/30`; the fourfold measure is `1/10`.
Since every individual bad set has measure `2/5`, full inclusion-exclusion is

`8/5 - 14/15 + 13/30 - 1/10 = 1`.

A separate direct interval-union calculation also returns measure `1`. Under
the strict bad-set and closed safe-set conventions, the safe set is exactly
`{1/5, 2/5, 3/5, 4/5}`; these four isolated points explain why full bad-set
measure does not contradict existence of a Lonely Runner witness.
