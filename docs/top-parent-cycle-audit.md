# Top-parent cycle audit

## Scope

This is an independent exact audit of Sol Response 33's fixed-pivot
top-parent criterion.  The implementation in
`scripts/audit_top_parent_cycles.py` rebuilds the candidate residues, strict
bad sets, fibers, and dynamic programs literally; it imports no earlier
certificate code.

For `n` speeds, pivot speed `A`, and `M=(n+1)A`, the candidates are

\[
R=\{0\le r<M:(n+1)\nmid r\}.
\]

The strict bad targets are the residues `x` with `x<A` or `x>M-A`.  Thus the
boundary targets `A` and `M-A` are excluded.  For a nonpivot child `i`, a bad
target `x`, and another nonpivot parent `p`, the script directly counts

\[
w_{i,x}(p)=|\{r\in R:a_i r=x\pmod M,\ r\in B_p\}|.
\]

Write `W_(i,x)=max_p w_(i,x)(p)` and let `T_(i,x)` contain every maximizing
parent.  A token retains `W_(i,x)` in an order exactly when some member of
`T_(i,x)` precedes `i`.  Subset DP maximizes retained top credit over all
orders.  Equivalently, choosing a maximizing parent for every token gives a
weighted directed multigraph, and the lost credit is the minimum feedback
weight.  The script constructs a selector from the optimal order and checks
that its backward-edge weight is exactly the DP loss.

## Recomputed rows

The five displayed quantities are `S=sum_i |B_i|`, total top credit `F_top`,
minimum feedback loss `tau_top`, `D_top=S-F_top+tau_top`, and the candidate
threshold `nA`.

| case | pivot | `S` | `F_top` | `tau_top` | `D_top < nA` | `D_opt` |
|---|---:|---:|---:|---:|---:|---:|
| RF | 16 | 224 | 128 | 36 | `132 < 144` | 132 |
| GCD1 | 75 | 1057 | 487 | 87 | `657 < 675` | 647 |
| GCD2 | 75 | 1057 | 489 | 81 | `649 < 675` | 643 |
| hard A | 9 | 108 | 72 | 28 | `64 < 72` | 64 |
| hard B | 15 | 174 | 100 | 34 | `108 < 120` | 108 |
| small | 3 | 12 | 4 | 2 | `10 < 12` | 10 |
| D `(10,37,45,51,54,56,61,71,91)` | 91 | 1309 | 733 | 160 | `736 < 819` | 727 |
| C `(8,15,35,40,48,56,68,75,78)` | 75 | 1060 | 514 | 97 | `643 < 675` | 631 |

All eight claimed rows are reproduced exactly.

## Relation to unrestricted additive optimization

A second, separate subset DP gives each token the largest intersection with
*any* preceding parent, rather than either its full top value or zero.  For
each state and possible next child this is computed afresh from the literal
fiber intersections.  Therefore every order's unrestricted credit dominates
its top-only credit, and the optimized additive bound must satisfy

\[
D_{\mathrm{opt}}\le D_{\mathrm{top}}.
\]

The program checks this inequality and the displayed exact optimized values
on every row.  The top-parent
criterion is consequently a sufficient relaxation of the existing optimized
additive DP, not an identity with it and not a proof of a uniform pivot.

## Reproduction

From the repository root under WSL:

```text
PYTHONPATH=scripts python3 scripts/audit_top_parent_cycles.py
PYTHONPATH=scripts python3 -m unittest tests/test_top_parent_cycles.py -v
```
