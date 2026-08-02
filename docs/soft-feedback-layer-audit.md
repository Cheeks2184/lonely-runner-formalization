# Exact full-weight threshold layers and soft feedback

## Scope

This note retains every eligible parent weight in the optimized additive
fiber-credit objective. It gives an exact loss representation, two sound
conditional bounds, and a necessary core obstruction for failure. It does
not prove that some pivot satisfies the strict additive threshold uniformly.

Fix a pivot and let `V` be the nonpivot runners. A token `e` is one child
target fiber, with owner `c(e)`. For eligible parent `p != c(e)`, write

```text
w_e(p) = |F_e intersect B_p|,
W_e    = max_p w_e(p).
```

The maximum is zero when there is no positive eligible weight.

## Unit threshold expansion

For each natural level `q<W_e`, define

```text
P_(e,q) = {p : q < w_e(p)}.
```

For every predecessor set `Q`,

```text
max ({w_e(p) : p in Q} union {0})
  = sum_(q<W_e) 1[P_(e,q) intersects Q].
```

Indeed, if the left side is `u`, exactly the levels `q=0,...,u-1` are met.
This proof is insensitive to ties. A zero-weight token creates no level, and
an empty predecessor set meets none.

Equivalently, list the distinct positive weights
`0=a_0<a_1<...<a_k=W_e`, give the nested parent set
`{p:w_e(p)>=a_j}` weight `a_j-a_(j-1)`, and aggregate consecutive unit
levels. The unit form is preferable for Lean because it needs no sorting or
tie choices.

## Exact soft loss and Bellman recurrence

For an order `o`, let `Earlier_o(i)` be the vertices preceding `i`. Its soft
loss is

```text
Lambda(o) = sum_e (W_e - max_(p in Earlier_o(c(e))) w_e(p)).
```

By the layer identity, this is exactly the number, with multiplicity, of unit
layers whose parent set does not meet the owner's earlier set.

For an unplaced set `Q` and `i in Q`, put

```text
delta_i(Q)
  = sum_(e owned by i) (W_e - max_(p outside Q) w_e(p)).
```

If an order repeatedly removes `i_k` from the current set `Q_k`, then

```text
Lambda(o) = sum_k delta_(i_k)(Q_k).
```

Thus, for `h(empty)=0`, the exact recurrence is

```text
h(Q) = min_(i in Q)
  (h(Q without i)
   + sum_(layers owned by i,
          P_layer intersects (Q without i) = empty) layerWeight).
```

For the full vertex set, `h(V)` is the unrestricted soft optimum and

```text
minimum additive cost = S - F_top + h(V).
```

The notation `F_top` here is the sum of every token's maximum weight; only the
loss term uses lower-ranked parents. Orderwise, soft loss is at most top-only
loss. It is strictly smaller on a token precisely when the earlier set
contains a positive lower-ranked parent but no maximum-weight parent.

## Budgeted peeling and critical cores

Let `b_1,...,b_|V|` be natural budgets. If every nonempty `Q` of size `q`
contains `i` with `delta_i(Q)<=b_q`, greedy deletion produces an order with

```text
Lambda(o) <= sum_q b_q.
```

This follows immediately by summing the exact stage deficits. Let the strict
integer budget be

```text
beta = F_top - (S - n*A).
```

If `beta<=0`, no additive order can be strict at this pivot. If `beta>0`, a
failing pivot must, by contraposition, contain a nonempty set `Q` such that
all its stage deficits exceed any budget sequence totaling at most `beta-1`.
In particular, with

```text
lambda = ceil(beta / |V|),
```

failure implies a nonempty `lambda`-soft core satisfying
`delta_i(Q)>=lambda` for every `i in Q`.

The deficit is monotone upward with `Q`, so unions of `lambda`-cores are
cores. Repeatedly deleting vertices of deficit below `lambda` therefore gives
a unique maximal core, independent of deletion order.

Every core vertex owns at least `lambda` distinct labelled trapped unit
layers. Choose one supporting parent inside the core for each selected layer
and draw a labelled edge `parent -> owner`. The resulting directed multigraph
has minimum indegree at least `lambda`, no self-loops, and may have parallel
edges. It contains at least `lambda` edge-disjoint directed cycles: remove one
cycle, observe that every vertex loses at most one incoming edge, and induct.
This is a necessary obstruction only. The cycles' layers remain coupled by
their common original tokens.

## Prefix expectation and SCC refinement

Fix a prefix vertex set `Q` and an order on it attaining `h(Q)`. Uniformly
randomizing the tail gives the exact expected loss

```text
B_soft(Q) = h(Q)
  + sum_(active tail layers) layerWeight / (|P_layer|+1),
```

where a tail layer is active when its owner is outside `Q` and no supporting
parent lies in `Q`.

Build the active support graph with all edges `p -> owner`. Topologically
order its strongly connected component condensation. Every active layer with
a parent outside its owner's component is then certainly satisfied. Random
ordering only within components yields the sharper upper bound

```text
B_core(Q) = h(Q)
  + sum_(active layers supported entirely inside the owner's SCC)
      layerWeight / (|P_layer|+1).
```

Replacing each SCC's random term by its exact internal Bellman optimum gives
the exact best continuation after the prefix: restriction of any continuation
lower-bounds each internal optimum, while concatenating optimal SCC orders in
topological order satisfies every cross-component layer.

## Exact audit on the top-only counterexample

For

```text
E = (5,28,35,40,68,88,108,148,165),
```

the strict budgets `T_A=nA-S_A+F_A` and exact soft losses are:

| pivot | `T_A` | exact soft loss |
|---:|---:|---:|
| 5 | 1 | 1 |
| 28 | 40 | 38 |
| 35 | 60 | 44 |
| 40 | 120 | 104 |
| 68 | 134 | 128 |
| 88 | 106 | 100 |
| 108 | 184 | 152 |
| 148 | 262 | 264 |
| 165 | 211 | 165 |

At pivot `28`, the prefix `(35,40,88)` has loss `24`. The residual SCCs are

```text
{5,165}, {68,108}, {148},
```

with edges from the first component to both later components. Their internal
loss totals `14`, so `B_core=38<40`. One resulting optimal order is

```text
(35,40,88,5,165,68,108,148),
```

giving additive cost `360-148+38=250<252`.

An independent implementation checked the threshold identity on all 4,328
tokens and 5,113 compressed layers from the nine `E` pivots and eight prior
stress rows, covering 537,700 predecessor subsets. Every earlier stress row
has a strict SCC certificate using at most one prefix vertex. These are exact
fixed-instance checks, not a uniform theorem.

## Remaining obstruction

Unconditioned soft random order is not enough: at `E` pivot `28`, its bound is
`784/15>46`, even though the exact soft optimum is `38`. The active support
graph there is initially one SCC, and no prefix of size one or two gives a
strict SCC bound; the best values are `42` and `41` against budget `40`.

The open arithmetic obligation is to prove that every primitive injective
tuple has some pivot and prefix `Q` with

```text
B_core(Q) < n*A - S_A + F_A,
```

or to replace `B_core` by a stronger token-coupled bound with a provable
cross-pivot inequality. Divisor data alone cannot determine this quantity,
and failure of this sufficient route would imply neither failure of the exact
pivot certificate nor failure of LRC.
