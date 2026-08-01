# Random-order averaging for one-level fiber credits

This note gives a new exact generic inequality for the one-level additive
fiber-credit certificate and audits the arithmetic statement that would be
needed to turn it into a uniform Lonely Runner proof. The generic averaging
lemma is proved below on paper and independently checked by literal
permutation enumeration. The remaining strict modular inequality is open.

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

In a uniformly random order, the credited maximum equals `y_j` exactly when
parent `c_j` precedes `b` and the `j-1` better-ranked parents follow `b`.
Among `b,c_1,...,c_j`, this requires `c_j` first and `b` second. Hence

\[
 \Pr(\text{credited maximum}=y_j)=\frac{(j-1)!}{(j+1)!}
 =\frac1{j(j+1)}.
\]

The remaining event, of probability `1/m`, has no preceding parent and
credit zero. Therefore

\[
 \mathbb E\max_{c\in P_b}|F\cap B_c|
 =\sum_{j=1}^{m-1}\frac{y_j}{j(j+1)}.
\]

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

## 4. The genuinely arithmetic conjecture

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

The distinction is essential. The averaging theorem alone cannot imply
strictness for arbitrary set systems: if every `B_b=R` and each child has one
fiber, the expected bound is exactly `|R|`, as it must be because the union
covers `R`. Any proof of RF-UNIF must use multiplication modulo `NA`, the
strict central interval, distinct speeds, or pivot selection. It cannot be a
pure Hall or random-order argument.

## 5. Exact evidence

The exact natural-mask implementation in
`scripts/search_fiber_average.py` found:

- no RF-UNIF failure among every primitive tuple with three through eight
  speeds selected from `1,...,15`;
- no failure in 250 deterministic primitive ten-speed samples through speed
  `100` with seed `37`;
- no failure in 100 deterministic primitive twelve-speed samples through
  speed `200` with seed `41`;
- successful certificates for the previously documented difficult tuples
  `(1,2,5,7,9,11,12,13)` and `(1,5,7,8,9,11,13,15)`.

This is evidence only. No height bound or uniform proof of RF-UNIF is known.

Reproduce the exact computations with:

```sh
python3 scripts/search_fiber_average.py --tuple 1 2 5 6 8
python3 scripts/search_fiber_average.py --criterion ranked-fiber --runners 8 --max-speed 15
python3 scripts/search_fiber_average.py --criterion ranked-fiber --runners 10 --max-speed 100 --samples 250 --seed 37
python3 scripts/search_fiber_average.py --criterion ranked-fiber --runners 12 --max-speed 200 --samples 100 --seed 41
python3 -m unittest tests.test_fiber_average -v
```

The next proof obligation is to express the ranked intersection values in
terms of gcds and short centered arithmetic progressions, then prove RF-UNIF
for at least one pivot. Formalizing the generic permutation-expectation lemma
in Lean is also pending.
