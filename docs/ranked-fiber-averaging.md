# Random-order averaging for one-level fiber credits

This note gives a new exact generic inequality for the one-level additive
fiber-credit certificate and audits the arithmetic statement that would be
needed to turn it into a uniform Lonely Runner proof. The generic averaging
lemma is proved below on paper and independently checked by literal
permutation enumeration. The proposed strict modular inequality is now
rejected by an exact nine-speed counterexample; the optimized deterministic
ordering problem remains open.

## 1. Setup

Fix a pivot speed `A` in an `n`-speed tuple and put `N=n+1`. There are
`m=n-1` nonpivot bad sets `B_b` in the candidate universe

\[
 R=\{r\pmod{NA}:N\nmid r\},\qquad |R|=nA.
\]

For each child `b`, its strict bad set is partitioned into multiplication
fibers `F_{b,x}`. If `P` is the collection of parents preceding `b`, its
one-level credit is

\[
 L(b,P)=\sum_x\max_{c\in P}|F_{b,x}\cap B_c|.
\]

For an order `pi`, the Lean-checked additive upper bound is

\[
 U(\pi)=\sum_b\bigl(|B_b|-L(b,P_b(\pi))\bigr).
\]

Strict inequality `U(pi)<|R|` is sufficient for a pivot candidate outside all
bad sets.

## 2. A coarse pairwise average and its exact failure

Since maximum is at least average,

\[
 L(b,P)\geq \frac1{|P|}\sum_{c\in P}|B_b\cap B_c|.
\]

For a uniformly random order, an unordered pair whose later member occupies
position `ell` contributes coefficient `1/(ell-1)`. Since

\[
 \Pr(\max(\operatorname{pos}(b),\operatorname{pos}(c))=\ell)
 =\frac{2(\ell-1)}{m(m-1)},
\]

its expected coefficient is `2/m`. Consequently some order satisfies the
generic set-system inequality

\[
 \boxed{
 U(\pi)\leq
 \sum_b|B_b|-\frac2m\sum_{b<c}|B_b\cap B_c|.}
\tag{PAIR-AVG}
\]

This is not strong enough arithmetically. The lexicographically first
primitive failure in the tested five-speed box is

```text
(1,2,5,6,8).
```

For every pivot, the right side of `PAIR-AVG` is at least `|R|`. The exact
cross-multiplied data `(m sum|B| - 2 sum intersections, m|R|)` are

```text
pivot 1: (22,20)   pivot 2: (40,40)   pivot 5: (106,100)
pivot 6: (124,120) pivot 8: (164,160).
```

Nevertheless the actual additive criterion certifies the tuple at pivot `5`
with order `(1,2,6,8)` and insertion costs `(8,5,4,6)`, totaling `23<25`.
Thus `PAIR-AVG` fails on the genuine arithmetic bad-set family, not merely on
an artificial set system.

## 3. Exact ranked-fiber expectation

Fix one child `b` and one fiber `F=F_{b,x}`. Sort its intersections with all
other nonpivot bad sets:

\[
 y_1\geq y_2\geq\cdots\geq y_{m-1},\qquad
 y_j=|F\cap B_{c_j}|.
\]

Ties make it unsafe to assign a disjoint event directly to each ranked
parent.  Instead, for every integer height `t>=1`, let

\[
 c_t=|\{j:y_j\geq t\}|.
\]

The credited maximum is at least `t` exactly when at least one of these
`c_t` parents occurs before `b`.  Among `b` and those parents, `b` is first
with probability `1/(c_t+1)`, so

\[
 \Pr(\text{credited maximum}\geq t)=\frac{c_t}{c_t+1}.
\]

The integer tail-sum formula and telescoping, with `y_m=0`, therefore give

\[
 \mathbb E\max_{c\in P_b}|F\cap B_c|
 =\sum_{t\geq1}\frac{c_t}{c_t+1}
 =\sum_{j=1}^{m-1}(y_j-y_{j+1})\frac{j}{j+1}
 =\sum_{j=1}^{m-1}\frac{y_j}{j(j+1)}.
\]

This proof remains valid when several `y_j` are equal.

Linearity of expectation across all fibers and children gives an exact
formula despite dependencies among their predecessor events. In particular,
some order satisfies

\[
 \boxed{
 U(\pi)\leq
 \sum_b|B_b|-
 \sum_{b,x}\sum_{j=1}^{m-1}\frac{y_{b,x,j}}{j(j+1)}.}
\tag{RANK-FIBER-AVG}
\]

This is a generic finite-set theorem: it needs only the stated fiber
partitions. `tests/test_fiber_average.py` literally enumerates every order of
the tuple `(1,2,5,6,8)` at pivot `5` and confirms that both the computed
expectation and the formula equal `23`.

## 4. A falsified arithmetic strengthening

The random-order theorem reduces UNIF-06 to the following falsifiable
number-theoretic inequality:

> **RF-UNIF.** For every distinct positive integer speed tuple with at least
> three entries, some pivot `A` satisfies
> \[
> \sum_b|B_b|-\sum_{b,x}\sum_j
> \frac{y_{b,x,j}}{j(j+1)}<nA.
> \]

If RF-UNIF holds, `RANK-FIBER-AVG` supplies a concrete order whose one-level
additive credit is strict, and the existing Lean theorem
`exists_mem_avoiding_of_fiberCredit_sum_lt_card` supplies a pivot witness.

RF-UNIF is false.  The primitive tuple

```text
(2,3,7,9,10,12,15,16,19)
```

has the following exact values at every pivot.  Here `E=S-Q` is the uniform-
order expected additive upper bound.

| pivot | `|R|` | `S` | `Q` | `E` |
|---:|---:|---:|---:|---:|
| 2 | 18 | 24 | 6 | 18 |
| 3 | 27 | 42 | 251/20 | 589/20 |
| 7 | 63 | 98 | 4517/140 | 9203/140 |
| 9 | 81 | 114 | 1933/60 | 4907/60 |
| 10 | 90 | 134 | 2531/60 | 5509/60 |
| 12 | 108 | 156 | 597/14 | 1587/14 |
| 15 | 135 | 206 | 7061/105 | 14569/105 |
| 16 | 144 | 224 | 4741/60 | 8699/60 |
| 19 | 171 | 266 | 39491/420 | 72229/420 |

Thus `E>=|R|` at every pivot, with equality only at pivot `2`.  Nevertheless
the deterministic additive criterion succeeds at pivot `3` with order

```text
(10,15,2,16,7,9,12,19)
```

and insertion costs `(9,8,2,2,0,0,2,2)`, totaling `25<27`.  The explicit
time `t=7/30` has exact distances

```text
(7/15,3/10,11/30,1/10,1/3,1/5,1/2,4/15,13/30),
```

so the tuple itself satisfies the target `1/10`.  RF-UNIF's failure therefore
rejects only uniform random ordering: a rare coordinated order can outperform
its average substantially.  The optimized additive claim remains open.

This distinction is essential. The averaging theorem alone cannot imply
strictness for arbitrary set systems: if every `B_b=R` and each child has one
fiber, the expected bound is exactly `|R|`, as it must be because the union
covers `R`.  The arithmetic counterexample shows that even multiplication
modulo `NA`, the strict central interval, distinct speeds, and pivot selection
do not rescue uniform averaging.

## 5. Audit trail and reproduction

Before the counterexample was located, the exact natural-mask implementation
in `scripts/search_fiber_average.py` found:

- no RF-UNIF failure in the complete primitive boxes with three speeds through
  `40`, four through `30`, five through `20`, six through `15`, and seven
  through `12` (55,265 tuples in total); the previously recorded complete
  three-through-eight-speed boxes in `1,...,15` also remain clean;
- no failure in 250 deterministic primitive ten-speed samples through speed
  `100` with seed `37`;
- no failure in 100 deterministic primitive twelve-speed samples through
  speed `200` with seed `41`;
- successful certificates for the previously documented difficult tuples
  `(1,2,5,7,9,11,12,13)` and `(1,5,7,8,9,11,13,15)`.

These bounded successes illustrate why they could not be promoted to a
uniform claim: the first recorded failure lies outside all those boxes.

Further exact diagnostics expose useful symmetries but do not prove
strictness.  Multiplying every speed by `d` multiplies each bad-set size,
fiber intersection, additive bound, ranked score, candidate count, and margin
by `d`.  At a fixed pivot, each bad mask depends on a nonpivot speed only up
to sign and residue modulo `N*A`.  The optimized additive bound is at most the
ranked expectation because some order is no worse than the average.  Finally,
the ranked inequality is genuinely pivot-sensitive: for consecutive tuples
the largest-speed pivot first fails in the tested cases at 14 and 15 speeds,
with ranked excesses `-37/20` and `-7597/1260`, while other pivots in each
tuple have positive best excess `8`.

Reproduce the exact computations with:

```sh
python3 scripts/search_fiber_average.py --tuple 1 2 5 6 8
python3 scripts/search_fiber_average.py --tuple 2 3 7 9 10 12 15 16 19
python3 scripts/search_fiber_hall.py --tuple 2 3 7 9 10 12 15 16 19 --objective additive --show-all-pivots
python3 scripts/search_fiber_average.py --criterion ranked-fiber --runners 8 --max-speed 15
python3 scripts/search_fiber_average.py --criterion ranked-fiber --runners 10 --max-speed 100 --samples 250 --seed 37
python3 scripts/search_fiber_average.py --criterion ranked-fiber --runners 12 --max-speed 200 --samples 100 --seed 41
python3 -m unittest tests.test_fiber_average -v
```

The next mathematical obligation is no longer RF-UNIF.  It is to explain why
a suitably biased or adaptive global order satisfies the additive bound, or
to find a counterexample to that optimized-order statement.  Exact gcd/CRT
formulas for pair and triple fibers may support such an adaptive rule.
Formalizing the valid generic permutation-expectation lemma in Lean is also
pending and does not assume RF-UNIF.
