# Audit of relocation and bounded-anchor proposals

This note records an independent reconstruction of the first and second lanes
in Sol Pro Response 26.  It is an arithmetic audit, not a proof of the
optimized additive ordering assertion.

## Relocation identity and neighborhood convention

Let `C(i,P)` be the one-level fiber insertion cost of child `i` after the
predecessor set `P`, and put

```text
g(i -> k; P) = C(k,P) - C(k,P union {i}).
```

Suppose an order contains a prefix `P`, then the contiguous block
`T=(t_1,...,t_m)`, then `i`.  Moving `i` immediately before `T` changes the
total cost by

```text
C(i,P) - C(i,P union T)
  - sum_h g(i -> t_h; P union {t_1,...,t_(h-1)}).
```

This is an exact telescoping identity.  The audit program checks it against a
direct full-order recomputation for every relocation it enumerates.

There is an important convention hidden in the response.  Its reported local-
minimum counts are reproduced exactly only when a local move may insert an
item either to the left or to the right:

| speeds; pivot | two-sided local minima | costs |
|---|---:|---:|
| `(2,3,7,9,10,12,15,16,19)`; `3` | 3144 | 25, 26 |
| `(8,15,35,40,48,56,63,75,78)`; `40` | 48 | 358 |
| `(1,2,5,7,9,11,12,13)`; `7` | 2100 | 50 |
| `(1,5,7,8,9,11,13,15)`; `8` | 2100 | 56 |
| `(1,2,3,5)`; `3` | 6 | 10 |

If “relocation” means only the displayed operation of moving an item left,
the first two stress instances have non-strict local minima at or above the
required threshold.  For the first tuple, the order
`(7,9,12,15,2,10,16,19)` is left-local with cost `28 >= 27`.  For the second,
`(8,75,48,15,35,56,63,78)` is left-local with cost `360`.  Therefore any
future `RELOC-UNIF` statement must explicitly use the two-sided insertion
neighborhood; the right-moving delta can be obtained by applying the displayed
identity to the inverse move.

These finite computations support the listed examples only.  They do not
prove that every tuple has a pivot whose two-sided relocation-local minima are
strictly below the candidate-universe size.

## The malformed Response 26 three-anchor formula

The response displayed a term of the form

```text
sum_(y in A) |F_i(x) intersection F_h(y)|
  + sum_(y notin A) max_(p in H minus {h})
      |F_i(x) intersection F_h(y) intersection B_p|,
```

but did not define `A` or say that `F_h(y)` ranged over a new full residue
partition rather than the strict bad-target fibers already used in the
repository.  Under that only then-available interpretation, every summand in
the second sum is a subset of the corresponding full pair cell in the first
sum.  The `h`-target fibers are disjoint.  Consequently the displayed
quantity is at most

```text
|F_i(x) intersection B_h|.
```

Maximizing over `h` therefore gives no more credit than the existing one-level
fiber rule.  Taking `A` to contain every target is the maximal reading and
reduces exactly to that rule.

Under this maximal reading, front-loading the claimed anchors gives costs
`26`, `82` or `84`, `52`, `58` or `60`, and `10` on the five listed instances.
Even replacing the prefix bound by the exact union cardinality of the anchor
masks gives respectively `26`, `82`, `52`, `58`, and `10`.  Thus the claimed
costs `25` for the first instance and `70` for the second cannot arise from
that interpretation.  This was a defect in the Response 26 specification,
not a refutation of every possible depth-two construction.

## Repaired Response 27 full-fiber construction

Response 27 supplied the missing distinction.  Write `T_A` for the strict
bad-target residues modulo `M=(n+1)A`.  For an anchor `h`, the **full** fibers

```text
G_h(z) = {r : h*r = z (mod M)}
```

range over every residue `z`, not merely `z in T_A`, and partition each child
fiber `F_i(x)`.  On a subfiber `S=F_i(x) intersection G_h(z)`:

- if `z in T_A`, all of `S` lies in `B_h` and is credited;
- if `z notin T_A`, `S` is disjoint from `B_h`, and the largest intersection
  with one other fixed anchor is credited.

The two pieces are disjoint, so this is exactly the finite arithmetic pattern
formalized by `anchoredSubfiberCredit_le_card_inter_biUnion` in
`LonelyRunner/TwoLevelFiberCredits.lean`.  The fixed anchor set is inserted
first.  For each later child, previous non-anchors are deliberately ignored;
this keeps the tail bound dependent only on the fixed anchor set and makes its
order irrelevant.

Independent literal-mask recomputation verifies every supplied step:

| speeds; pivot | fixed anchors and complete order | step costs | total / threshold |
|---|---|---|---:|
| `(2,3,7,9,10,12,15,16,19)`; `3` | anchors `(15,16)`, then `(2,7,9,10,12,19)` | `(12,3,2,0,0,4,2,2)` | `25 / 27` |
| `(8,15,35,40,48,56,63,75,78)`; `8` | anchors `(35,63,78)`, then `(15,40,48,56,75)` | `(14,12,8,6,20,4,0,6)` | `70 / 72` |
| `(1,2,5,7,9,11,12,13)`; `7` | anchors `(1,11,12)`, then `(2,5,9,13)` | `(12,10,10,2,6,6,6)` | `52 / 56` |
| `(1,5,7,8,9,11,13,15)`; `8` | anchors `(5,11,15)`, then `(1,7,9,13)` | `(14,12,8,6,6,6,6)` | `58 / 64` |
| `(1,2,3,5)`; `3` | anchors `(1,2)`, then `(5)` | `(4,2,4)` | `10 / 12` |
| `(6,8,15,21,28,35,40,48,75)`; `6` | anchors `(8,15,21)`, then `(28,35,40,48,75)` | `(10,10,4,4,6,10,4,0)` | `48 / 54` |

The program also checks at every evaluated insertion that the corrected credit
does not exceed the literal intersection with the anchor union and that it
dominates the corresponding one-level credit.  These are valid bounded-depth
certificates for the six instances, including both nine-speed fixed-average
failures.  They do not prove `3-ANCHOR-UNIF`, which remains an arithmetic
uniformity obligation over all speed tuples.

## Triangle-LP direction

For each child-fiber threshold clause, let `z_c` be its relaxed satisfied
credit and let `x_(p,i)` indicate that parent `p` precedes child `i`. Pair
equalities and triangle inequalities contain every total order, while

```text
z_c <= 1,
z_c <= sum_(qualifying p) x_(p,i)
```

allow a fractional solution to over-credit clauses. Minimizing total raw bad
size minus `sum_c z_c` therefore gives a lower bound on the true optimal
additive cost. Consequently an LP optimum at least `n*A` really does certify
fixed-pivot additive failure. An LP value below `n*A` proves nothing about the
existence of a strict order. Pair and triangle constraints do not make the
linear-order relaxation integral, so the proposed `SHORT-CYCLE-LP`
completeness statement remains unsupported.

There is already an integrality gap with three items. Give each child one
clause qualified by either of the other two items. Every total order leaves
the first item's clause unsatisfied, so every integral cost is `1`. The
fractional assignment `x_(i,j)=1/2` for every distinct pair and `z_c=1` for
all three clauses satisfies the pair equations, every directed triangle
inequality, and `z_c <= sum x_(p,i)`, but has relaxed cost `0`. Thus the
proposed clause/triangle relaxation is not complete even in this minimal
abstract instance.

## Reproduction

```bash
python3 scripts/audit_relocation_descent.py
python3 scripts/audit_three_anchor.py
python3 scripts/audit_triangle_lp.py
python3 -m unittest tests.test_response26_audit -v
```
