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
python3 scripts/search_residual.py --runners 6 --max-speed 30 --primitive-only --sol-pivot-counts
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
subsumption claims. The complete six-runner speed-30 run additionally checks
588,559 primitive tuples, including 239,928 residual tuples, all of which pass
the unrestricted two-parent certificate. These are independent executable
checks of formulas and finite data, not a formal enumeration or an
all-dimensional result.

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

## Max-speed and Response 44 audits

The following deterministic commands reproduce the latest exact outputs:

```bash
bash scripts/audit_height_n_plus_5.sh
bash scripts/audit_response44.sh
bash scripts/audit_response42_cheb_multi.sh
bash scripts/audit_residual_compatibility_family.sh
bash scripts/audit_logarithmic_height.sh
bash scripts/audit_quadratic_chebyshev_failure.sh
```

The first exhausts 134,568 five-hole configurations for `N=4,...,19` and
checks all returned rational witnesses with integer inequalities. The second
replays both byte-exact Prompt 44 artifacts: 18,536 alternate small-height
configurations, 92 exceptional rows, and 190,488 adversarial Chebyshev tuples.
The third checks 374,850 two-coordinate mutations and 297,847 new
divisor-covering three-coordinate mutations. The last verifies the compatible
family `U_N` for `N=5,...,500`, including every deletion gcd, divisor-incidence
bound, signed replacement, and its explicit lonely time. The logarithmic-height
audit checks 553,106 nonreciprocal arithmetic triples through `N=500`, including
15,955 short intervals, and all 361,220 admissible hole configurations through
`N=60`. The final command reproduces the exact tuple `(1,3,5,6,7)` and all
five nonpositive quadratic bounds. The optional several-minute command
`scripts/audit_quadratic_chebyshev_calibration.sh` exhausts 126,768,878
primitive lower-dimensional tuples through maximum 240 and checks 288,879
additional adversarial tuples; this finite calibration is not a minimality
proof.

All of these are finite executable audits. The bounded-height proof outside
the finite range is deductive, while the full conjecture remains open.

## Deletion-pivot lifting audit

The deterministic command

```bash
python3 scripts/audit_deletion_pivot_lift.py
```

tests the corrected deletion-pivot lifting principle (DPLP) with exact integer
arithmetic. For an original tuple of `n` speeds, each deletion is tested at
the lower threshold `1/n` on every surviving speed-valued pivot grid. A lower
certificate lifts only when its exceptional deleted coordinate also satisfies
the cross-multiplied closed `1/(n+1)` inequality. The script preserves the
essential quantifier order: every deletion must have a lower certificate, but
the conclusion may choose the deletion and the certificate that lift.

The complete primitive increasing boxes are

```text
(n,max)=(3,60),(4,35),(5,25),(6,24),
        (7,20),(8,18),(9,16),(10,16).
```

They contain 405,013 primitive tuples. Of the 402,517 tuples above the
verified coefficient-three cutoff, 158,544 have no speed divisible by
`N=n+1` and therefore take the direct time `1/N`. The remaining 243,973 meet
DPLP's divisibility premise. Every deletion has a lower pivot certificate and
at least one certificate lifts in every such tuple; the audit reports zero
failures. The smallest failure of the deliberately stronger raw lifting
statement is `(1,3,4,7)` at `N=5`; no speed is divisible by five, and time
`1/5` directly witnesses that tuple.

Reproducibility metadata:

- Python `3.14.4`, deterministic enumeration, no random seed;
- tracked source SHA-256
  `a152a8ed58f8257d2ce5f46f00a89d25bc9c4c9f4bc60d7b738a131f812ace1f`;
- expected stdout SHA-256
  `c2f7de1da569d246fab40075ff74a43e797ff0ad9bd2d085c4fe7b0737f934f8`;
- canonical output `certificates/deletion_pivot_lift_expected.txt`;
- regression `tests/test_deletion_pivot_lift.py`.

This is **computed finite evidence only**. It does not prove DPLP, an
induction theorem, positive-integer LRC, or unrestricted LRC. The single open
mathematical step is a uniform correlation theorem across the family of
deletion certificate sets.
