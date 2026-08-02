# RV energy and majorization audit

This note attacks `DISPERSION-STAR` by averaging its pair part and replacing
the full residual-profile `L1` variation by rigorous integer moment bounds.
It obtains two reusable lemmas, but the resulting profile-free sufficient
condition has an exact all-pivot counterexample.  This does **not** refute
`DISPERSION-STAR`, the three-anchor route, or the Lonely Runner Conjecture.

## Exact multiplicity identity for the pair part

Fix a pivot and let `B_1,...,B_m` be its nonpivot bad masks in the candidate
universe `U`.  Put `S=sum_i |B_i|` and let `k(x)` be the number of masks
containing `x`.  For first anchor `h`, retain the notation

```text
P(h) = D(h) + 1/(m-1) sum_{q != h} E(q|h).
```

At a point of multiplicity `k`, summing over `h` gives

```text
sum_h P(h)[x] = k(k-1)(2m-k-1)/(m-1).
```

Indeed, each of the `k` containing anchors contributes `k-1`.  Each of the
`m-k` noncontaining anchors contributes `k(k-1)/(m-1)`.  Since
`S-|U|=sum_x(k(x)-1)`, factoring the difference proves the exact identity

```text
1/m sum_h P(h) - (S-|U|)
 = u_0
   - 1/(m(m-1))
       sum_{x: 2 <= k(x) <= m-2}
         (k(x)-1)(m-k(x))(m-k(x)-1),                 (PAIR-MULT)
```

where `u_0` is the number of uncovered candidate residues.  Multiplicities
`1`, `m-1`, and `m` make zero contribution.  This pinpoints the obstruction
to selecting `h` from the pair part: intermediate multiplicities create the
entire deficit, while uncovered residues pay it one-for-one.

The script verifies `PAIR-MULT` exhaustively for every system of three or four
masks on a three-point universe, and directly at every pivot of the stress
tuple below.

## Integer majorization and energy bounds

In one retained child/first-anchor cell, write

```text
c = (c_1,...,c_K),   T = sum_q c_q,   Q = sum_q c_q^2,
L = |cell|,          0 <= c_q <= L.
```

Let `V(c)=sum_{q<r}|c_q-c_r|`, the exact numerator used by `Delta`.  Three
independent lower bounds are valid:

```text
V(c) >= r(K-r),                    r = T mod K,              (BAL)
V(c) >= ceil((KQ-T^2)/L),                                    (BE)
V(c) >= ceil(sqrt(KQ-T^2)).                                  (CE)
```

For `(BAL)`, among integer vectors with fixed sum, pairwise `L1` dispersion is
minimized when all entries differ by at most one; then exactly `r(K-r)` pairs
differ by one.  For the other two, use

```text
KQ-T^2 = sum_{q<r}(c_q-c_r)^2.
```

Every difference has absolute value at most `L`, proving `(BE)`, while the
square of a sum of nonnegative absolute differences dominates the sum of
their squares, proving `(CE)`.  Integrality gives the ceilings.  Therefore
the cellwise maximum of these three expressions is a rigorous lower bound for
`Delta`.  All ingredients are finite expressions in the exact candidate-
filtered triple counts `c_q`.

The regression test exhausts all profiles of length at most six with entries
between zero and four.

The equality cases are informative.  A constant profile has `T` divisible by
`K`, zero energy, and both the lower bound and exact `V` equal to zero.
Integer balancing is exact whenever all entries differ by at most one.  First
and second moments cannot determine the exact `L1` term: the two profiles

```text
(0,1,3,3) and (1,1,1,4)
```

both have `T=7`, `Q=19`, and may be placed in a cell of size `L=4`, but their
exact dispersions are respectively `11` and `9`.  The combined moment bound
is `7` for both.  Thus loss of ordered profile information is intrinsic, not
an artifact of the chosen proof of `(BE)`.

## Exact failure of the profile-free closure

Consider the mandatory fixed-clock stress tuple

```text
(8,15,35,40,48,56,63,75,78).
```

At every pivot and first anchor, replace each cell's exact `V(c)` by the
maximum of `(BAL)`, `(BE)`, and `(CE)`.  The best resulting
`pair part + bound - (S-nA)` margin is

```text
-2/3, attained at pivot 15 and first anchor 75.
```

Thus even this combined first/second-moment majorization principle fails at
every pivot.  At the best row its normalized energy-majorization term is
`124/21`, whereas the exact cellwise `L1` term is `142/21`.  Retaining that
full term repairs the row and gives the already audited strict margin `4/21`.

For completeness, the selected rows of all six mandatory stress instances
give:

| case | energy-majorization | exact `Delta` | resulting energy margin |
|---|---:|---:|---:|
| RF | `4/3` | `4/3` | `13/21` |
| GCD-clock failure | `124/21` | `142/21` | `-2/3` |
| simpler GCD-clock failure | `52/3` | `58/3` | `-20/21` |
| `(1,2,3,5)` | `0` | `0` | `2` |
| hard A | `76/15` | `76/15` | `2/5` |
| hard B | `92/15` | `92/15` | `4/5` |

The simpler GCD-clock tuple still has a different successful pivot/anchor
row for the moment bound (margin `4/3`).  The first GCD-clock tuple does not:
the displayed `-2/3` is its maximum over all rows.

This counterexample has a precise scope.  It rejects the proposed
profile-free energy closure, not `RV-UNIF`/`DISPERSION-STAR`: the latter uses
the full ordered profile and succeeds here.  Any viable cross-pivot argument
must preserve more than the cell total and quadratic energy, or exploit new
arithmetic relations between the ordered candidate-filtered triple counts.

Reproduce the audit with:

```sh
python3 scripts/audit_rv_energy.py
python3 -m unittest tests.test_rv_energy -v
```
