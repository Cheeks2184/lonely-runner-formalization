# Exact failure of `TOP-CYCLE-UNIF`

## Scope

The primitive nine-speed tuple

```text
E = (5, 28, 35, 40, 68, 88, 108, 148, 165)
```

fails the strict top-parent sufficient condition at every pivot.  It does
**not** disprove the Lonely Runner Conjecture.  The unrestricted additive
optimizer succeeds at pivot `28`, and the explicit time `t=3/140` is lonely.

The acceptance oracle is `scripts/audit_top_cycle_failure.py`.  It does not
import the search implementation.  It combines two pre-existing independent
literal reconstructions:

- `audit_top_parent_cycles.py` builds residue sets and solves the top-only and
  unrestricted objectives by subset dynamic programming;
- `audit_top_parent_rescue.py` rebuilds the sets and fibers independently and
  exhaustively enumerates all `8!` orders on the key pivots `5` and `28`.

All comparisons use strict bad arcs.  Images equal to `A` or `M-A` are good.

## Exact fixed-pivot rows

For a pivot `A`, let `S` be the sum of strict bad-set sizes, `F_top` the total
globally best-parent token weight, `tau_top` the minimum feedback loss, and

```text
D_top = S - F_top + tau_top.
```

Let `D_opt` be the unrestricted additive optimum and `nA=9A` the candidate
count.  A strict top-parent certificate would require `D_top < nA`.

| pivot | `S` | `F_top` | `tau_top` | `D_top` | `D_opt` | `nA` |
|---:|---:|---:|---:|---:|---:|---:|
| 5 | 50 | 6 | 1 | 45 | 45 | 45 |
| 28 | 360 | 148 | 46 | 258 | 250 | 252 |
| 35 | 500 | 245 | 60 | 315 | 299 | 315 |
| 40 | 562 | 322 | 122 | 362 | 344 | 360 |
| 68 | 958 | 480 | 146 | 624 | 606 | 612 |
| 88 | 1254 | 568 | 124 | 810 | 786 | 792 |
| 108 | 1544 | 756 | 194 | 982 | 940 | 972 |
| 148 | 2110 | 1040 | 294 | 1364 | 1334 | 1332 |
| 165 | 2360 | 1086 | 215 | 1489 | 1439 | 1485 |

Thus all nine strict top-parent surpluses `nA-D_top` are nonpositive:

```text
(0, -6, 0, -2, -12, -18, -10, -32, -4).
```

The two equality cases at pivots `5` and `35` still fail because the
certificate inequality is strict.  The unrestricted optimizer is strict at
pivots `28,35,40,68,88,108,165`; it is equality at `5` and fails at `148`.
This is therefore a genuine separation of `TOP-CYCLE-UNIF` from the surviving
unrestricted additive route.

## Top ties, explicit selectors, and soft rescue

For each deterministic top-optimal order, the acceptance oracle chooses one
top parent per positive token.  It prefers an earlier top parent when one
exists; otherwise it chooses the least-speed top parent.  The resulting
backward weight equals `tau_top` on every row.  This is an explicit selector
check independent of merely subtracting the DP optimum.

Top-parent ties are retained, not broken prematurely.  The numbers of tied
positive tokens among all positive tokens are respectively

```text
6/6, 46/67, 68/140, 56/122, 112/191,
162/230, 178/277, 288/419, 336/620.
```

On the same selected top-optimal orders, unrestricted second-best rescue and
the corresponding full bounds are

| pivot | rescue | full bound on the top-optimal order |
|---:|---:|---:|
| 5 | 0 | 45 |
| 28 | 4 | 254 |
| 35 | 16 | 299 |
| 40 | 18 | 344 |
| 68 | 18 | 606 |
| 88 | 24 | 786 |
| 108 | 32 | 950 |
| 148 | 30 | 1334 |
| 165 | 38 | 1451 |

At pivot `28`, rescue on the chosen top-optimal order is not enough
(`254 >= 252`), but a different unrestricted order succeeds.  One exact
optimal order and its insertion costs are

```text
order = (40, 35, 88, 165, 148, 108, 68, 5)
costs = (36, 24, 42, 36, 24, 30, 30, 28)
sum   = 250 < 252.
```

The standalone exhaustive oracle checks all `40320` orders at pivots `5` and
`28`, obtaining `(D_top,D_opt)=(45,45)` and `(258,250)` respectively.

## Candidate count, endpoints, and direct witness

For every pivot, the literal candidate universe is

```text
{r in {0,...,10A-1} : r is not divisible by 10},
```

of cardinality `9A`.  The endpoint audit encounters both images `A` and
`10A-A` on every row and verifies that none is placed in a bad set.  The
low/high endpoint hit counts are

```text
(10,10), (12,12), (10,10), (23,23), (12,12),
(16,16), (12,12), (12,12), (10,10).
```

At pivot `A=28`, take candidate residue `r=6` modulo `280`.  This is
`t=6/280=3/140`.  The nine exact circular distances are

```text
(3/28, 2/5, 1/4, 1/7, 16/35, 4/35, 11/35, 6/35, 13/28).
```

Their minimum is `3/28 > 1/10`, so `E` has an independently checked lonely
time.

## Search provenance

The separate exact search implementation is
`scripts/search_top_cycle_failures.py`.  Before receiving the tuple above, it
established the following deterministic boundaries and near-obstructions:

- complete primitive `n=9` box containing speed `1`, maximum speed `17`:
  `12870` tuples, no all-pivot failure, minimum worst surplus `+4`;
- exact one-coordinate descent produced
  `(1,2,3,4,5,6,7,8,9,11,60)` for `n=11`, with worst surplus `+2`;
- the full normalized two-coordinate radius-`10` neighborhood of that tuple
  (`2122` tuples) contained no improvement;
- a three-coordinate radius-`10` neighborhood (`25189` normalized tuples) of
  the `n=9` near-obstruction `(1,2,3,5,6,7,8,9,30)` contained no improvement
  below `+4`.

These are finite search statements only.  They are recorded to make the route
to the separating tuple reproducible, not as evidence for a universal claim.

## Reproduction

```bash
python3 scripts/audit_top_cycle_failure.py
PYTHONPATH=scripts python3 -m unittest -v tests.test_top_cycle_failure
python3 scripts/search_top_cycle_failures.py \
  --tuple 5,28,35,40,68,88,108,148,165
```

The tests assert every row, both equality cases, all strict conventions, the
proposed pivot-`28` order and costs, the exhaustive key-row optima, and the
explicit lonely time.
