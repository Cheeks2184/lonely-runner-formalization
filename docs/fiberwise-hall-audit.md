# Fiberwise single-parent Hall audit

## 1. Exact criterion checked

Fix a positive integer speed tuple with `n` moving runners, put `N=n+1`,
and choose a pivot speed `A`.  The candidate residues are

\[
R=\{r\pmod {NA}:N\nmid r\},\qquad |R|=nA.
\]

For each nonpivot speed `b`, the script imports the repository's literal
strict-boundary mask `B_b` from `scripts/search_residual.py`.  It independently
partitions that mask into the congruence fibers

\[
F_b(x)=\{r\in R:br\equiv x\pmod {NA}\},
\qquad -A+1\le x\le A-1.
\]

Given an earlier parent set `P`, the only overlap lower bound used is

\[
L(b,P)=\sum_x\max_{c\in P}|F_b(x)\cap B_c|.
\]

This is intentionally **not** the full-union quantity
`sum_x |F_b(x) intersection union_(c in P) B_c|`.  The fibers are disjoint,
and each selected single-parent intersection lies inside the corresponding
full-union intersection, so

\[
L(b,P)\le |B_b\cap\bigcup_{c\in P}B_c|.
\]

Consequently, for an order `i_1,...,i_(n-1)`, the proposed sufficient
balanced-growth certificate is

\[
 |B_{i_1}|+(n-2)q<|R|,
 \qquad |B_{i_k}|-L(i_k,\{i_1,\ldots,i_{k-1}\})\le q
 \quad(k\ge2).
\]

It is a sound sufficient condition for pivot noncoverage.  It is not a
uniform property of all positive integer tuples.

## 2. Audit of the two reported hard tuples

For `(1,2,5,7,9,11,12,13)`, pivot `A=9`, and order

```text
(1,2,12,11,13,5,7)
```

the reported `q=9` certificate is exact.  The first bad-set size is `16`,
`|R|=72`, and the subsequent `(bad size, required overlap, fiber lower bound)`
rows are

```text
(16,7,8), (12,3,4), (16,7,8), (16,7,8), (16,7,8), (16,7,8).
```

Thus its stated bound is `16+6*9=70<72`.  The exhaustive order search also
finds that this same order works with the stronger value `q=8`, giving
`16+6*8=64<72`.

For `(1,5,7,8,9,11,13,15)`, pivot `A=8`, order

```text
(5,9,15,7,11,1,13)
```

and `q=8`, the first bad-set size is `14`, `|R|=64`, and the remaining rows
are exactly

```text
(8,0,0), (14,6,6), (14,6,6), (14,6,6), (14,6,8), (14,6,10).
```

The resulting bound is `14+6*8=62<64`.

## 3. Exact failure of the proposed uniform criterion

The primitive structural residual tuple

```text
(1,2,3,5)
```

has no balanced-growth certificate of this form.  The subset dynamic program
tests every pivot, every first child, and every order.  Its globally optimal
attempts are:

| pivot | best order | least `q` for that order | best bound | `|R|` |
|---:|---|---:|---:|---:|
| 1 | `(5,2,3)` | 0 | 4 | 4 |
| 2 | `(5,1,3)` | 2 | 8 | 8 |
| 3 | `(1,2,5)` | 4 | 12 | 12 |
| 5 | `(1,2,3)` | 6 | 20 | 20 |

Every optimum is equality, whereas the certificate requires strict
inequality.  This is only a counterexample to the proposed proof criterion,
not to the Lonely Runner Conjecture: exact optimization gives the tuple the
witness `t=1/4`, with minimum circular distance `1/4 > 1/5`.

Within complete primitive boxes, there is no failure for two or three runners
with speeds at most `10`; among four-runner tuples with speeds at most `5`,
`(1,2,3,5)` is the unique failure.  Thus it is the first failure in the
explicitly stated bounded search ordered by runner count, maximum speed, and
then lexicographically.  No unbounded minimality claim is made.

Broader searches over the repository's structural residuals gave:

| runners | maximum speed | residual tuples | certified | uncertified | first failure |
|---:|---:|---:|---:|---:|---|
| 4 | 20 | 1,206 | 1,205 | 1 | `(1,2,3,5)` |
| 5 | 20 | 4,821 | 4,813 | 8 | `(1,3,9,12,13)` |
| 6 | 20 | 13,265 | 11,545 | 1,720 | `(1,2,3,4,5,7)` |
| 7 | 15 | 2,067 | 2,032 | 35 | `(1,2,3,4,5,7,8)` |
| 8 | 15 | 1,716 | 1,519 | 197 | `(1,2,3,4,5,6,7,9)` |

The criterion is therefore useful on some difficult instances but cannot be
the missing uniform integer theorem.

## 4. Reproduction and independent checks

`scripts/search_fiber_hall.py` builds the literal fibers, asserts that they
partition each imported bad mask, and minimizes the balanced bound by subset
dynamic programming.  With a fixed first child, the DP state records the
least possible maximum insertion cost; this is enough because the objective
depends on an order only through that bottleneck.

Run the reported examples and the counterexample with:

```sh
python3 scripts/search_fiber_hall.py --tuple 1 2 5 7 9 11 12 13
python3 scripts/search_fiber_hall.py --tuple 1 5 7 8 9 11 13 15
python3 scripts/search_fiber_hall.py --tuple 1 2 3 5 --show-all-pivots
python3 -m unittest tests.test_fiber_hall -v
```

The broader table is reproduced by:

```sh
python3 scripts/search_fiber_hall.py --runners 4 --max-speed 20
python3 scripts/search_fiber_hall.py --runners 5 --max-speed 20
python3 scripts/search_fiber_hall.py --runners 6 --max-speed 20
python3 scripts/search_fiber_hall.py --runners 7 --max-speed 15
python3 scripts/search_fiber_hall.py --runners 8 --max-speed 15
```

The tests additionally compare the subset DP with explicit enumeration of
every permutation for every pivot of every primitive four-speed tuple in
`1..7`.  Another regression uses a synthetic fiber where two disjoint parents
each contribute one point: the audited lower bound is asserted to be `1`,
while a prohibited full-union implementation would return `2`.
