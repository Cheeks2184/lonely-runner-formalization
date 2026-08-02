# Anchor-star failure search, round 2

This is an independently implemented, exact search for failures of three
nested sufficient conditions.  It is not a search for a counterexample to the
Lonely Runner Conjecture.  In decreasing order of strength, the conditions are:

1. `DISPERSION-STAR`: the explicit cell-dispersion lower bound for `Gamma`
   makes the fixed-first-anchor inequality strict;
2. `ANCHOR-STAR`: the exact average corrected three-anchor cost is strictly
   below the pivot candidate-universe size;
3. `3-ANCHOR`: at least one corrected three-anchor cost is strictly below that
   size.

A failure of the first condition need not fail the second, and a failure of
the second need not fail the third.  Even failure of all three would reject
only these certificate schemes, not the conjecture.

## Independent optimized evaluator

[`scripts/search_anchor_star_failures.py`](../scripts/search_anchor_star_failures.py)
constructs the literal strict bad-residue masks modulo `(n+1)*a_j`.  For each
three-anchor set it computes the exact prefix union and the corrected
residual-subfiber credit.  Each child fiber is split by the full image of the
distinguished anchor, exactly as in `audit_anchor_star.py`.

Every unordered three-anchor cost is computed once.  The two weaker decisions
then use integer comparisons:

```text
3-ANCHOR succeeds
  iff min_H U_j(H) < n*a_j for some pivot j;

ANCHOR-STAR succeeds
  iff sum_(H containing h) U_j(H)
         < C(n-2,2) * n*a_j
      for some pivot j and first anchor h.
```

The second comparison is the audited double-average identity, with its
denominator cleared.  `DISPERSION-STAR` is imported from
`audit_gamma_dispersion.py`; it retains exact `Fraction` arithmetic.  A
putative failure is recomputed with the slower reference functions before it
is retained.

The optimized implementation was compared with `anchor_cost` for every triple
at every pivot of all six recorded stress tuples.  It was also compared with
the reference all-pivot decisions on seeded tuples.  The regression suite
checks that the sign of each scaled margin agrees with its reference
predicate.

## Complete primitive boxes

No all-pivot failure of any of the three conditions was found in the following
complete boxes of increasing, positive, primitive integer tuples:

| runners | maximum speed | tuples checked |
|---:|---:|---:|
| 4 | 30 | 25,819 |
| 5 | 20 | 15,246 |
| 6 | 16 | 7,980 |
| 7 | 12 | 792 |
| 8 | 12 | 495 |
| 9 | 12 | 220 |

Reproduce one row, including all three decisions, with for example:

```sh
python3 scripts/search_anchor_star_failures.py complete --runners 6 --maximum 16
```

## Structured and seeded searches

The structured generator includes arithmetic progressions, quadratic gaps,
clusters around multiples of `n+1`, one-exceptional shared-divisor families,
smooth selections, and truncated geometric progressions.  After primitive
normalization and deduplication, the complete generated cohorts through speed
60 contained:

| runners | structured tuples checked |
|---:|---:|
| 4 | 853 |
| 5 | 539 |
| 6 | 324 |
| 7 | 234 |
| 8 | 182 |

No all-pivot failure of any condition was found.  The following deterministic
mixed-distribution samples also had no failure:

| runners | maximum | samples | seed |
|---:|---:|---:|---:|
| 4 | 300 | 250 | 381904 |
| 5 | 200 | 150 | 381905 |
| 6 | 150 | 100 | 381906 |
| 7 | 100 | 50 | 381907 |
| 8 | 80 | 25 | 381908 |

These samples mix uniform choices, one-exceptional shared-divisor tuples,
near-`(n+1)` multiples, and square-heavy tuples.  The cohorts may overlap, so
their counts are not combined into a claim about a number of unique tuples.

## Closest recorded structured margins

For comparison within a fixed runner count, the script can clear the fixed
denominators and report exact integer margins.  A condition succeeds exactly
when its margin is positive.  In each structured cohort through speed 30, the
smallest all-pivot margins occurred at the consecutive tuple `(1,...,n)`:

| runners | tuples | dispersion margin, scale `(n-2)(n-3)` | anchor-star margin, scale `C(n-2,2)` | raw three-anchor margin |
|---:|---:|---:|---:|---:|
| 4 | 289 | 8 | 4 | 4 |
| 5 | 169 | 12 | 6 | 2 |
| 6 | 78 | 72 | 36 | 6 |
| 7 | 52 | 80 | 40 | 4 |
| 8 | 43 | 180 | 90 | 6 |

Thus no equality case occurred in these cohorts.  The margins are not directly
comparable between different runner counts because their scaling denominators
differ.

## Failed and excluded runs

Exploratory structured searches through speed 500 and a complete 7-runner box
through speed 14 exceeded their orchestration time limits.  Wrapper
termination initially left several Python child processes running; those
processes were identified by the exact script command line and terminated.
No partial counts or implied outcomes from those runs are included above.

The first version of the small regression test expected 65 primitive
4-tuples through speed 8; the generator correctly returned 69.  The test
expectation was repaired, and the complete combined scan remains part of the
suite.

Run the bounded regression checks with:

```sh
python3 -m unittest tests.test_anchor_star_search_round2 -v
```

## Conclusion

This round found no counterexample to `DISPERSION-STAR`, `ANCHOR-STAR`, or
`3-ANCHOR`.  The result is finite computational evidence only.  In particular,
it supplies no uniform lower bound for the nonzero-target compatibility term
and does not close any unbounded proof obligation.
