# Nonzero-target Gamma dispersion audit

This note gives a rigorous lower bound for the nonzero-target term left open
by the anchor-star double average.  It narrows the arithmetic obstruction but
does **not** prove `ANCHOR-STAR-UNIF`, `3-ANCHOR-UNIF`, or the Lonely Runner
Conjecture.

## Setup

Fix a pivot `j`, put `A=a_j`, `M=N*A`, and let `I` be the `m` nonpivot
indices.  The candidate residues are the canonical `r mod M` with `N ∤ r`.
For `s in I`, let `B_s` be the strict bad mask

```text
a_s r mod M < A  or  a_s r mod M > M-A.
```

Thus both boundary targets `A` and `M-A` are nonbad.  Write `L_i(H)` for the
corrected two-level credit of anchor set `H` on child `i`, and `U(H)` for the
anchor-prefix functional in `anchor-star-audit.md`.  Explicitly,

```text
U(H) = |union_{s in H} B_s|
       + sum_{i in I \ H} (|B_i| - L_i(H)).
```

Throughout the averaging argument assume `m>=3`.  Hence both factors in
`(m-1)(m-2)` are positive.  (The full LRC project separately includes the
smaller-runner base cases.)

Fix the first anchor `h`.  For every child `i != h`, partition `B_i` into
cells `C=C(i,x,y)` by both the canonical child target
`a_i r = x (mod M)` and the full anchor image `a_h r = y (mod M)`.  Retain
only cells with nonbad `h`-image `A <= y <= M-A`.  For another possible
anchor `q`, define

```text
c_q(C) = |C intersect B_q|.
```

These are precisely the nonzero- and nonbad-target compatibility counts that
the zero-target gcd estimate does not see.

## Exact cancellation when the third anchor is added

For two anchors the corrected credit is exact:

```text
L_i({h,q}) = |B_i intersect (B_h union B_q)|.                 (1)
```

Indeed, distinguish `h`.  Every `h`-bad cell is credited completely, while in
each other cell the only available parent is `q`; this partitions the literal
intersection with the union.  Maximizing over the two distinguished anchors
does not change the result.

Now add a third anchor `r`, distinct from `h,q`, and put
`P=B_h union B_q`.  The prefix union grows by
`|B_r \ (B_h union B_q)|`.  The old tail term for `r` is removed, and by (1)
it is exactly

```text
|B_r| - L_r({h,q}) = |B_r \ (B_h union B_q)|.
```

Writing out both anchor costs makes the signs explicit:

```text
U({h,q}) - U({h,q,r})
  = |P| - |P union B_r| + |B_r| - L_r({h,q})
    + sum_{i in I \ {h,q,r}} (L_i({h,q,r})-L_i({h,q}))
  = -|B_r \ P| + |B_r \ P|
    + sum_{i in I \ {h,q,r}} (L_i({h,q,r})-L_i({h,q})).
```

Thus those changes cancel.  The third-anchor gain has the exact identity

```text
G(r | h,q)
  = sum_{i in I \ {h,q,r}} (L_i({h,q,r}) - L_i({h,q})).      (2)
```

No union-bound slack or sign argument is hidden in (2).

## Cellwise dispersion lower bound

In a retained cell `C`, use `h` as the distinguished anchor for the triple.
The pair credit in that cell is `c_q(C)`, while the available triple credit is
at least `max(c_q(C),c_r(C))`.  Equations (1) and (2) give

```text
G(r | h,q) >=
  sum_{i in I \ {h,q,r}} sum_{C=C(i,x,y), y nonbad}
    (c_r(C)-c_q(C))_+.                                      (3)
```

Let

```text
Gamma(h) = 1/((m-1)(m-2))
  * sum_{q != h} sum_{r != h,q} G(r | h,q).
```

For fixed `i` and `C`, the child occurs in (3) only when neither `q` nor `r`
equals `i`.  Hence the eligible comparison anchors are exactly
`K=I \ {h,i}`.  Pairing the two orientations of each unordered pair gives

```text
sum_{q != r in K} (c_r(C)-c_q(C))_+
  = sum_{{q,r} subset K}
      ((c_r(C)-c_q(C))_+ + (c_q(C)-c_r(C))_+)
  = sum_{{q,r} subset K} |c_q(C)-c_r(C)|.
```

Every ordered `(q,r)` in `Gamma` has weight
`1/((m-1)(m-2))`: there are `m-1` choices for `q` after excluding `h`, then
`m-2` choices for `r` after excluding `h,q`.  Reordering the finite sums and
using the exact eligibility set `K` therefore introduces no extra factor of
two.

Consequently

```text
Gamma(h) >= Delta(h),                                       (4)

Delta(h) = 1/((m-1)(m-2))
  * sum_{i != h}
      sum_{C=C(i,x,y), y nonbad}
        sum_{{q,r} subset I\{h,i}} |c_q(C)-c_r(C)|.
```

The formula also covers `m=3`: every innermost unordered-pair sum is empty,
and both the third-anchor tail gain and `Delta` are zero.

Combining (4) with Response 28 yields the following strictly sufficient
arithmetic obligation:

```text
D_j(h) + (1/(m-1)) * sum_{q != h} E_j(q|h) + Delta_j(h)
  > S_j - n*A                                                (DISPERSION-STAR)
```

for some pivot `j` and first anchor `h`.  If this holds, then
`Xi_j(h)>S_j-n*A`, hence some three-anchor functional is strictly below
`n*A`.  The universal existence of such `j,h` remains unproved.

## Reduction to exact triple-congruence arithmetic

For canonical target representatives, each cell count is

```text
c_q(C(i,x,y)) =
  sum_{z strict-bad} candidateTripleCongruenceCount
    N A a_i a_h a_q x y z.
```

Thus `Delta` is a finite sum of absolute differences of quantities already
covered by the Lean declarations
`candidateTripleCongruenceCount_exact` and
`pivotTripleTargetFiber_eq_pair_inter_target` in
`LonelyRunner/PivotTripleFiberCounts.lean`.  Compatibility of each raw triple
fiber is characterized in `LonelyRunner/TripleCongruence.lean`.  This removes
the informal word “compatibility” from the obstruction: what is missing is a
cross-pivot lower bound for an explicit gcd/congruence expression with
absolute values.

## Exact stress results

The table separates the pair part of `Xi`, the exact `Gamma`, a coarser bound
obtained after collapsing all nonbad `h`-target cells, the cellwise `Delta`,
and the strict surplus proved using `Delta`.

| case | pair part | exact `Gamma` | collapsed | `Delta` | `pair+Delta-(S-nA)` |
|---|---:|---:|---:|---:|---:|
| RF | `100/7` | `4/3` | `25/21` | `4/3` | `13/21` |
| GCD-clock failure | `668/7` | `58/7` | `68/21` | `142/21` | `4/21` |
| simpler GCD-clock failure | `614/7` | `470/21` | `8` | `58/3` | `22/21` |
| `(1,2,3,5)` | `2` | `0` | `0` | `0` | `2` |
| hard A | `64/3` | `76/15` | `8/3` | `76/15` | `2/5` |
| hard B | `68/3` | `92/15` | `14/5` | `92/15` | `4/5` |

The margins `4/21`, `2/5`, and `4/5` show that strictness at the final
threshold has been preserved.

## Tightness and failed simplifications

- Equality `Gamma(h)=Delta(h)` holds on RF, `(1,2,3,5)`, hard A, and hard B.
  It is not an identity: the two GCD-clock cases have gaps `32/21` and
  `64/21`.
- Even retaining the better of distinguished anchors `h` and `q` is not
  always exact.  The remaining gaps are `2/21` and `3/7` on the two
  GCD-clock cases, so the third distinguished anchor can be essential.
- Collapsing the target cells before applying absolute values is a valid
  triangle-inequality lower bound expressible using only aggregate pair and
  triple intersections.  It is too weak for the intended certificate: its
  surpluses are `-10/3`, `-72/7`, `-2`, and `-38/15` on the GCD-clock,
  simpler GCD-clock, hard A, and hard B cases.  Nonzero-target cell structure
  is therefore genuinely necessary for this route.

No all-pivot failure of `DISPERSION-STAR` was found in the following complete
primitive boxes.  These are finite checks, not a universal theorem.

| runners | maximum speed | tuples checked |
|---:|---:|---:|
| 4 | 12 | 479 |
| 5 | 15 | 2,981 |
| 6 | 12 | 923 |
| 7 | 12 | 792 |
| 8 | 12 | 495 |
| 9 | 12 | 220 |

Reproduce the identities, stress values, and searches with:

```sh
python3 scripts/audit_gamma_dispersion.py
python3 scripts/audit_gamma_dispersion.py --certificate-only --scan-runners 5 --max-speed 15
python3 scripts/audit_gamma_dispersion.py --certificate-only --scan-runners 9 --max-speed 12
python3 -m unittest tests.test_gamma_dispersion -v
```

The remaining mathematical obligation is to prove `DISPERSION-STAR` for some
pivot and anchor in every primitive positive integer speed tuple, or to find
an exact tuple where it fails at every pivot.  Failure would refute only this
sufficient anchor-star route, not optimized additive ordering and not the
Lonely Runner Conjecture.
