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

Consequently, for an order `i_1,...,i_(n-1)`, direct ordered-union induction
gives the additive upper bound

\[
 U_{\rm add}=|B_{i_1}|+
 \sum_{k=2}^{n-1}\bigl(|B_{i_k}|-
 L(i_k,\{i_1,\ldots,i_{k-1}\})\bigr).
\]

The Lean-facing fiber-credit certificate is the sufficient condition
`U_add < |R|`.  A stronger hypothesis, and therefore a weaker proof method,
is the common-`q` balanced-growth condition

\[
 |B_{i_1}|+(n-2)q<|R|,
 \qquad |B_{i_k}|-L(i_k,\{i_1,\ldots,i_{k-1}\})\le q
 \quad(k\ge2).
\]

The common-`q` condition replaces all actual insertion costs by their maximum,
giving

\[
U_{\rm add}\le |B_{i_1}|+(n-2)q.
\]

Both tests are sound sufficient conditions for pivot noncoverage, but they
are different objectives.  The computation below disproves uniformity only
for the common-`q` version.  No counterexample to the sharper additive
criterion was found.

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

## 3. Exact failure of common-`q` balancing

The primitive structural residual tuple

```text
(1,2,3,5)
```

has no common-`q` balanced-growth certificate.  The subset dynamic program
tests every pivot, every first child, and every order.  Its globally optimal
attempts are:

| pivot | best order | least `q` for that order | best bound | `|R|` |
|---:|---|---:|---:|---:|
| 1 | `(5,2,3)` | 0 | 4 | 4 |
| 2 | `(5,1,3)` | 2 | 8 | 8 |
| 3 | `(1,2,5)` | 4 | 12 | 12 |
| 5 | `(1,2,3)` | 6 | 20 | 20 |

Every balanced optimum is equality, whereas the certificate requires strict
inequality.  However, the additive objective certifies the same tuple at
pivot `3` and order `(1,2,5)`: its `(bad size, fiber lower bound, insertion
cost)` rows are

```text
(4,0,4), (4,2,2), (4,0,4),
```

so `U_add=4+2+4=10<12`.  Pivot `5` also works with additive bound `18<20`.
Thus `(1,2,3,5)` rejects only the balancing shortcut; it does not reject the
Lean-checked additive fiber-credit interface.  It is also not a Lonely Runner
counterexample: exact optimization gives the witness `t=1/4`, with minimum
circular distance `1/4 > 1/5`.

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

These rows concern only the balanced objective.  They show that a common
insertion cap is useful on some difficult instances but cannot be the missing
uniform integer theorem.

## 4. Additive optimization and bounded evidence

For the additive objective the program uses a second exact subset DP.  Its
state value is the least accumulated insertion cost for any ordering of that
state; adding child `b` contributes exactly `|B_b|-L(b,state)`.  Initial
singleton states have cost `|B_first|`.  This tests every first child and every
order without enumerating permutations.

No additive-criterion failure was found in the following complete primitive
boxes:

| scope | runners | maximum speed | checked | certified |
|---|---:|---:|---:|---:|
| all primitive | 2 | 20 | 127 | 127 |
| all primitive | 3 | 20 | 997 | 997 |
| all primitive | 4 | 30 | 25,819 | 25,819 |
| all primitive | 5 | 20 | 15,246 | 15,246 |
| all primitive | 6 | 15 | 4,998 | 4,998 |
| all primitive | 7 | 12 | 792 | 792 |
| structural residual | 4 | 50 | 58,680 | 58,680 |
| structural residual | 5 | 30 | 45,172 | 45,172 |
| structural residual | 6 | 25 | 61,900 | 61,900 |
| structural residual | 7 | 20 | 27,334 | 27,334 |
| structural residual | 8 | 18 | 20,811 | 20,811 |
| structural residual | 9 | 16 | 3,431 | 3,431 |
| structural residual | 10 | 15 | 1,287 | 1,287 |

A deterministic pseudorandom search with seed `21`, maximum speed `200`, and
the structural-residual filter found no failure among a further 2,000 tuples
at six runners, 2,000 at eight runners, 1,000 at ten runners, and 500 at
twelve runners.

This evidence does not prove additive uniformity.  In particular, “smallest
additive failure” remains **none found in the stated bounds**, not a theorem
that none exists.  The additive arithmetic inequality remains the substantive
open obligation behind the Lean-checked fiber-credit certificate.

## 5. Reproduction and independent checks

`scripts/search_fiber_hall.py` builds the literal fibers, asserts that they
partition each imported bad mask, and minimizes both objectives by subset
dynamic programming.  With a fixed first child, the balanced DP state records
the least possible maximum insertion cost; this is enough because that
objective depends on an order only through the bottleneck.  The additive DP
instead records the least accumulated insertion cost.

Run the reported examples and the balanced counterexample with:

```sh
python3 scripts/search_fiber_hall.py --tuple 1 2 5 7 9 11 12 13
python3 scripts/search_fiber_hall.py --tuple 1 5 7 8 9 11 13 15
python3 scripts/search_fiber_hall.py --tuple 1 2 3 5 --show-all-pivots
python3 scripts/search_fiber_hall.py --tuple 1 2 3 5 --objective additive --show-all-pivots
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

Representative additive searches use `--objective additive`; for example:

```sh
python3 scripts/search_fiber_hall.py --runners 4 --max-speed 30 --all-tuples --objective additive
python3 scripts/search_fiber_hall.py --runners 8 --max-speed 18 --objective additive
python3 scripts/search_fiber_hall.py --runners 12 --max-speed 200 --objective additive --samples 500 --seed 21
```

The tests additionally compare both subset DPs with explicit enumeration of
every permutation for every pivot of every primitive four-speed tuple in
`1..7`.  Another regression uses a synthetic fiber where two disjoint parents
each contribute one point: the audited lower bound is asserted to be `1`,
while a prohibited full-union implementation would return `2`.
