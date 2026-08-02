# Top-parent rescue audit

## Exact soft-feedback identity

Fix a pivot and its strict modular candidate universe. For every nonempty bad
child-target fiber `e=(i,x)`, let

\[
w_e(p)=|F_i(x)\cap B_p|,\qquad
W_e=\max_p w_e(p),\qquad
T_e=\{p:w_e(p)=W_e\}.
\]

For a vertex order `o`, write `P_o(i)` for the parents before child `i`. The
top-only and unrestricted credits of the token are

\[
C_e^{\rm top}(o)=
  W_e\,1_{T_e\cap P_o(i)\ne\varnothing},
\qquad
C_e(o)=\max(\{w_e(p):p\in P_o(i)\}\cup\{0\}).
\]

Define its second-best rescue by

\[
R_e(o)=
\begin{cases}
0,&T_e\cap P_o(i)\ne\varnothing,\\
C_e(o),&T_e\cap P_o(i)=\varnothing.
\end{cases}
\]

Then, token by token and including every tie and zero weight,

\[
C_e(o)=C_e^{\rm top}(o)+R_e(o).
\]

After summing, let `S` be the bad-set multiplicity sum, `F_top=sum_e W_e`,
and `L_top(o)=F_top-C_top(o)`. The additive cost has the exact form

\[
\boxed{D(o)=S-F_{\rm top}+L_{\rm top}(o)-R(o).}
\]

Thus the top-parent argument is the result of discarding the nonnegative
rescue term. If `o_top` realizes the minimum top loss `tau_top`, the strictly
stronger sufficient test is

\[
S-F_{\rm top}+\tau_{\rm top}-R(o_{\rm top})<nA.
\]

Equivalently, a backward top edge need not be deleted at its full weight: it
may be redirected to an earlier second-best parent, paying only the weight
deficit. This is a soft feedback problem rather than an ordinary feedback-arc
problem.

## Exact fixed-pivot separations

The self-contained script `scripts/audit_top_parent_rescue.py` rebuilds
candidates, strict bad sets, fibers, and weights literally, then enumerates
all `8! = 40,320` nonpivot orders. It imports no earlier certificate or DP
implementation.

| row and pivot | `nA` | `S` | `F_top` | `tau_top` | top cost | rescue in a top-optimal order | full cost in that same order | full optimum |
|---|---:|---:|---:|---:|---:|---:|---:|---:|
| `(8,15,35,40,48,56,63,75,78)`, `A=40` | 360 | 554 | 224 | 34 | 364 | 6 | 358 | 358 |
| `(8,15,35,40,48,56,68,75,78)`, `A=56` | 504 | 814 | 368 | 76 | 522 | 22 | 500 | 498 |

The inequalities are deliberately non-strict on the top side and strict on
the unrestricted side. Equality would not suffice for the avoidance theorem.
These are fixed-pivot separations: they prove that the top-parent relaxation
is genuinely stricter than unrestricted additive ordering, but do not refute
the existential cross-pivot statement by themselves.

For the first row, the top-optimal order is

```text
(48,75,15,8,35,56,63,78).
```

The same order is unrestricted-optimal. Its top cost misses the threshold by
four, while second-best redirection supplies six and wins strictly by two.

For the second row, one top-optimal order is

```text
(35,40,48,15,8,68,75,78).
```

Its unrestricted cost is already `500<504`; moving `75` before `8` improves
the unrestricted optimum to `498` without changing maximum top credit.

## All-pivot counterexample to `TOP-CYCLE-UNIF`

The later tuple

```text
E = (5,28,35,40,68,88,108,148,165)
```

does refute the existential top-parent premise. The full-prefix endpoint of
the exact recurrence below gives the complete top-only DP at every pivot. A
separate clean-room run also enumerated all `40,320` orders at every pivot and
reproduced the same top values; pass `--exhaustive-top-counterexample` to the
audit script to repeat that slower check. The unrestricted column comes from
the same literal exhaustive enumeration.

| pivot `A` | `nA` | `S` | `F_top` | `tau_top` | top cost | unrestricted optimum |
|---:|---:|---:|---:|---:|---:|---:|
| 5 | 45 | 50 | 6 | 1 | 45 | 45 |
| 28 | 252 | 360 | 148 | 46 | 258 | 250 |
| 35 | 315 | 500 | 245 | 60 | 315 | 299 |
| 40 | 360 | 562 | 322 | 122 | 362 | 344 |
| 68 | 612 | 958 | 480 | 146 | 624 | 606 |
| 88 | 792 | 1254 | 568 | 124 | 810 | 786 |
| 108 | 972 | 1544 | 756 | 194 | 982 | 940 |
| 148 | 1332 | 2110 | 1040 | 294 | 1364 | 1334 |
| 165 | 1485 | 2360 | 1086 | 215 | 1489 | 1439 |

Every top cost is at least `nA`; equality occurs exactly at pivots `5` and
`35`, and equality still fails the strict avoidance criterion. Therefore
`TOP-CYCLE-UNIF` is false. At pivot `28`, however, unrestricted additive cost
is `250<252`, so the stronger counterexample does not refute optimized
additive uniformity or LRC. The top-optimal order

```text
(40,88,5,35,68,108,148,165)
```

has rescue `4` and full cost `254`, while the different unrestricted-optimal
order

```text
(35,40,68,5,165,88,108,148)
```

reaches `250`. This shows that merely adding rescue to one chosen top-optimal
order is not itself an exact optimization principle.

Finally, the direct candidate `r=6` for `A=28`, `M=280` gives time
`t=6/280=3/140`. The modular images and circular-distance numerators are

```text
images:    30,168,210,240,128,248,88,48,150
distances: 30,112, 70, 40,128, 32,88,48,130.
```

Every distance numerator is at least `28`, including the boundary convention,
so this tuple has a direct lonely time and is not a counterexample to LRC.

## Reciprocal two-cycle audit

For any fixed choice of one top parent per positive token, aggregate its
directed edge weights as `E_uv`. Put

\[
c_{uv}=\min(E_{uv},E_{vu}),\qquad
C_2=\sum_{u<v}c_{uv}.
\]

Every order pays exactly `c_uv` from the symmetric part of each unordered
pair. Cancelling these parts leaves an oriented weighted graph `E'`, so the
feedback identity is exact:

\[
\tau(E)=C_2+\tau(E').
\]

A random order gives only `tau(E') <= |E'|/2`. Conditioning a vertex `v` to
be first or last improves this to

\[
\tau(E')\le \frac{|E'|-|\operatorname{out}(v)-
  \operatorname{in}(v)|}{2}.
\]

The separating selector constructed from the first row has
`C_2=34=tau_top`: all of its optimal top loss is forced reciprocal weight and
the residual oriented graph costs zero. Therefore no sharper analysis of
longer residual top cycles can repair that fixed-pivot top failure. The six
units of second-best rescue are genuinely necessary. On the second row,
`C_2=74`, `tau_top=76`, and only two units come from residual longer cycles.

## Conditioned random-order lemma

There is also a selector-free bound that uses top-parent ties exactly. Choose
one vertex `v`, fix it first or last, and uniformly permute all other
vertices. For a positive token of weight `W`, owner `i`, and top set `T`:

- with `v` first, its loss probability is `1` if `i=v`, `0` if `i!=v` and
  `v in T`, and `1/(|T|+1)` otherwise;
- with `v` last, its loss probability is `0` if `i=v`, `1/|T|` if `i!=v`
  and `v in T`, and `1/(|T|+1)` otherwise.

Taking the minimum of these exact expectations proves an upper bound for
`tau_top`. No integrality rounding or independence assumption is used; a
finite average contains at least one order no worse than its mean.

| row | conditioned bound | required strict upper bound | result |
|---|---:|---:|---|
| RF | `3113/70` | 48 | succeeds |
| GCD1 | `2293/15` | 105 | too weak |
| GCD2 | `4571/30` | 107 | too weak |
| hard A | 28 | 36 | succeeds |
| hard B | 39 | 46 | succeeds |
| small | 2 | 4 | succeeds |
| D | `52337/210` | 243 | too weak |
| C | `5149/30` | 129 | too weak |

This improves unconditioned random ordering, including repairing RF, but it
does not supply the missing cross-pivot theorem.

## Prefix-conditioned peeling hierarchy

The one-vertex calculation extends to an exact partial-peeling hierarchy.
For a prefix set `P`, let `H(P)` be the minimum deterministic top loss among
orders of exactly those prefix vertices. Appending `i` last gives the exact
recurrence

\[
H(P)=\min_{i\in P}\left[
  H(P\setminus\{i\})+
  \sum_{\substack{e:\operatorname{owner}(e)=i\\
                    T_e\cap(P\setminus\{i\})=\varnothing}} W_e
\right].
\]

After fixing a prefix order realizing `H(P)`, uniformly permute the remaining
vertices. Its expected top loss is

\[
B(P)=H(P)+
\sum_{\substack{e:\operatorname{owner}(e)\notin P\\
                  T_e\cap P=\varnothing}}
\frac{W_e}{|T_e|+1}.
\]

Therefore `tau_top <= B(P)` for every `P`. The two endpoints are exact:
`B(empty)` is the tie-aware random-order bound, while
`B(V)=H(V)=tau_top`. Minimizing `B(P)` separately among sets of each size
interpolates from the generic probabilistic estimate to the complete top-only
subset DP.

| row | first prefix size giving a strict certificate | bound | required bound |
|---|---:|---:|---:|
| RF | 1 | `3113/70` | 48 |
| GCD1 | 4 | 96 | 105 |
| GCD2 | 4 | 103 | 107 |
| hard A | 0 | `917/30` | 36 |
| hard B | 0 | `128/3` | 46 |
| small | 0 | 2 | 4 |
| D | 2 | `3074/15` | 243 |
| C | 3 | `362/3` | 129 |

Thus a prefix of size at most four certifies all eight established stress
rows. This is a useful compact finite certificate pattern, not a uniform
theorem: no argument currently proves that four vertices, or any fixed number
independent of `n`, suffice for some pivot of every speed tuple. At full
prefix size the method is simply the exact `TOP-CYCLE` DP, so its endpoint
does not evade a counterexample to that stronger premise.

## Divisor-only obstruction

Individual fixed-pivot gcd data do not determine top credit. For `n=5`,
`A=10`, and `M=60`, compare

```text
(1,4,10,29,30)   nonpivot gcds with M: (1,4,1,30)
(1,10,28,29,30)  nonpivot gcds with M: (1,4,1,30)
```

The gcds agree in the displayed speed order. Both rows have `nA=50`, `S=70`,
and `tau_top=8`, but their top totals and costs differ:

```text
F_top=32, top cost=46<50;
F_top=28, top cost=50=50.
```

Hence a cross-pivot proof based only on the individual divisor profile
`gcd(a_i,(n+1)A)` cannot determine even fixed-pivot top success. It must retain
finer congruence information controlling the fiberwise parent maxima.

## Reproduction

From the repository root under WSL:

```text
PYTHONPATH=scripts python3 scripts/audit_top_parent_rescue.py
PYTHONPATH=scripts python3 -m unittest tests/test_top_parent_rescue.py -v
PYTHONPATH=scripts python3 scripts/audit_top_parent_rescue.py \
  --exhaustive-top-counterexample
```
