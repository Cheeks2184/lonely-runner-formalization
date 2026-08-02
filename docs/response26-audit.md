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

## The displayed three-anchor formula

The response displayed a term of the form

```text
sum_(y in A) |F_i(x) intersection F_h(y)|
  + sum_(y notin A) max_(p in H minus {h})
      |F_i(x) intersection F_h(y) intersection B_p|,
```

but did not define `A`.  Regardless of that omission, every summand in the
second sum is a subset of the corresponding full pair cell in the first sum.
The `h`-target fibers are disjoint.  Consequently, for every possible `A`,
the displayed quantity is at most

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
the displayed formula.  A revised proposal needs a new, well-defined credit
whose soundness and prefix accounting are stated explicitly.

## Reproduction

```bash
python3 scripts/audit_relocation_descent.py
python3 scripts/audit_three_anchor.py
python3 -m unittest tests.test_response26_audit -v
```

