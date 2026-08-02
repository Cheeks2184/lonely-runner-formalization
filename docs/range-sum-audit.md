# Range--sum residual-profile audit

This note independently audits the range--sum majorization proposed in Sol
Pro Response 30.  The majorization is correct, but its proposed uniform
application is false.  In fact, the search found exact failures of the
stronger `DISPERSION-STAR` premise as well.  Neither result is a counterexample
to the three-anchor certificate, optimized additive ordering, or the Lonely
Runner Conjecture.

## The profile inequality

Let `c=(c_1,...,c_r)` be one retained residual profile, and put

```text
ell = min c_i,       u = max c_i,       R = u-ell,
s = sum_i c_i,       V(c) = sum_{p<q} |c_p-c_q|.
```

Define `w(c)=0` when `r<=1` or `R=0`, and `w(c)=R` when `r=2`.  For `r>=3`,
put

```text
k = r-2,
T = s-r*ell-R = q*k+eta,       0 <= eta < k,
w(c) = (r-1)R + eta(k-eta).
```

Then `V(c)>=w(c)`.  Here is a direct proof.  Subtract `ell`, then remove one
zero and one entry equal to `R`.  Call the remaining `k` entries `y_i`.  The
removed minimum--maximum pair contributes `R`, and each `y_i` contributes

```text
|y_i-0| + |R-y_i| = R.
```

Consequently

```text
V(c) = (k+1)R + sum_{p<q}|y_p-y_q|
     = (r-1)R + sum_{p<q}|y_p-y_q|.                 (1)
```

Among integer vectors of length `k` and sum `T`, pairwise `L1` dispersion is
minimized by balancing: replacing entries `a<b-1` by `a+1,b-1` strictly
decreases the dispersion.  At a minimum, `k-eta` entries equal `q` and `eta`
entries equal `q+1`, giving residual dispersion `eta(k-eta)`.  These balanced
values remain in `[0,R]` because the original residual values do and have the
same average.  Substitution in (1) proves the bound.

Equality is automatic for `r<=3`.  For `r>=4`, equality holds exactly when,
after deleting one minimum and one maximum, all remaining values differ by at
most one.  Repeated extrema cause no ambiguity: deleting any one copy leaves
the same remaining multiset.  The test suite exhausts every profile of length
at most seven with entries in `0..5` and confirms both the inequality and this
if-and-only-if criterion.

## From cells to the modular certificate

In the notation of `gamma-arithmetic-audit.md`, sum `w(c(C))` over every
retained child/first-anchor cell and divide by `(m-1)(m-2)`.  Call the result
`W_j(h)`.  The exact cell dispersion is `V_j(h)=Delta_j(h)`.  The profile
inequality term-by-term proves

```text
V_j(h) >= W_j(h).
```

Thus the following is sufficient for `DISPERSION-STAR`, but is strictly
stronger:

```text
pairPart_j(h) + W_j(h) > S_j-n*a_j.               (RANGE-SUM-STAR)
```

The strict inequality matters.  A maximum margin of zero is a failure of the
certificate, not a certificate at the boundary.

All six mandatory stress rows reproduce exactly:

| case | `W` | `pairPart+W-(S-nA)` |
|---|---:|---:|
| RF | `4/3` | `13/21` |
| first GCD-clock failure | `142/21` | `4/21` |
| simpler GCD-clock failure | `394/21` | `10/21` |
| `(1,2,3,5)` | `0` | `2` |
| hard A | `76/15` | `2/5` |
| hard B | `92/15` | `4/5` |

The inequality can be lossy.  For
`(2,4,8,16,18,26,27)`, pivot `18`, first anchor `4`, the exact values are
`V=52/5` and `W=51/5`.  The entire loss comes from two child-`26` cells
`(child target,h-image)=(10,68),(134,76)`, each with profile `(0,2,2,0)`.

## Exact all-pivot failures

Two primitive, positive, distinct tuples fail both `RANGE-SUM-STAR` and the
stronger `DISPERSION-STAR`.  A separate literal oracle enumerates candidate
residues as Python sets/lists, reconstructs every cell from its two modular
images, and recounts every anchor membership without using the bit masks or
`child_fibers` implementation.  It agrees on `W` and `V` for all 72 ordered
pivot--anchor rows of each tuple.  Every three-anchor result below was also
checked against the slower `anchor_cost` oracle, and every optimized additive
result was reconstructed by direct order evaluation.

For the arithmetic progression

```text
(1,14,27,40,53,66,79,92,105),
```

the best `RANGE-SUM-STAR` and `DISPERSION-STAR` margins at successive pivots
are the same displayed rationals:

```text
 1:    0          14:  -2/3       27: -52/7
40: -122/7        53: -98/3       66: -604/21
79:  -71/3        92: -86/3      105: -160/7.
```

The overall zero occurs at pivot `1`, first anchor `40`, and therefore does
not meet the required strict inequality.  This tuple does **not** reject the
later routes:

```text
ANCHOR-STAR: pivot 14, h=105, average 2644/21 < 126
  (strict margin 2/21);
three anchors: pivot 14, (79,92,105), cost 118 < 126;
optimized additive: pivot 14, bound 108 < 126,
  order (40,105,66,92,1,27,53,79),
  costs (18,24,18,16,8,8,8,8).
```

For

```text
(1,4,5,7,8,9,10,11,17),
```

the successive best margins are

```text
 1:    0           4: -40/21       5:  -8/21
 7: -16/3          8: -76/21       9: -92/21
10: -24/7         11: -16/3       17: -202/21.
```

The zero is at pivot `1`, first anchor `10`.  More strongly, this tuple also
fails `ANCHOR-STAR` at every pivot.  Its global best row is the equality case
at pivot `1`, `h=10`, with average `9`, so strictness again fails.  For
reference, the best pivot-`5` row is `h=17`, with average `953/21 > 45`
(margin `-8/21`).  It still has both stronger constructive certificates:

```text
three anchors: pivot 5, (4,7,17), cost 41 < 45;
optimized additive: pivot 5, bound 41 < 45,
  order (1,4,7,8,9,10,11,17),
  costs (8,7,8,4,4,4,6,0).
```

Therefore `RANGE-SUM-STAR`, `DISPERSION-STAR`, and (on the second tuple)
`ANCHOR-STAR` are rejected only as uniform sufficient premises.  The exact
three-anchor and optimized additive assertions remain open.

## Search boundary

Before the targeted failures were found, complete primitive scans found no
`RANGE-SUM-STAR` failure in:

| runners | maximum speed | tuples |
|---:|---:|---:|
| 4 | 30 | 25,819 |
| 5 | 20 | 15,246 |
| 6 | 16 | 7,980 |
| 7 | 12 | 792 |
| 8 | 12 | 495 |
| 9 | 12 | 220 |

No tuple in those boxes was certified by `DISPERSION-STAR` but not by
`RANGE-SUM-STAR`.  Deterministic arithmetic-cluster, near-multiple,
divisor-rich, and lacunary cohorts through speed `120` contained no failure
for seven runners (910 tuples) or eight runners (756 tuples).  The nine-runner
cohort found the arithmetic-progression failure above as its fourteenth
primitive tuple.  A one-speed mutation cohort around the closest complete-box
tuple found the second failure as its sixtieth tuple.  These search positions
depend on the documented deterministic generators and are not minimality
claims.

## Fixed-pivot coprime common-divisor descent

Fix pivot speed `A`, modulus `M=(n+1)A`, and suppose a positive integer `D`
divides every nonpivot speed and `gcd(D,M)=1`.  Replace every nonpivot `a_i`
by `a_i/D`.  Multiplication by `D` permutes residues modulo `M`; because
`gcd(D,n+1)=1`, it also preserves the candidate condition

```text
(n+1) does not divide r  <=>  (n+1) does not divide D*r.
```

For every nonpivot,

```text
(a_i/D)(D*r) = a_i*r (mod M),
```

so `r -> D*r` pulls back every strict bad mask and hence the entire fixed-
pivot set system.  The claim is correct, including strict boundary behavior.

It is not a global descent.  The divisor condition and modulus change with
the pivot, and division can make a nonpivot speed equal to the unchanged
pivot (for example `(5,2,6,10)` at pivot `5`, divisor `2`).  The divided data
may therefore cease to be a valid distinct-speed LRC instance even though the
fixed-pivot set-system isomorphism remains true.

## Reproduction

```sh
python3 scripts/audit_range_sum.py
python3 scripts/audit_range_sum.py --deep-tuple 1,14,27,40,53,66,79,92,105
python3 scripts/audit_range_sum.py --deep-tuple 1,4,5,7,8,9,10,11,17
python3 scripts/audit_range_sum.py --scan-runners 9 --max-speed 12
python3 scripts/audit_range_sum.py --scan-runners 9 --max-speed 120 --structured
python3 scripts/audit_range_sum.py --near-nine --max-speed 60
python3 -m unittest tests.test_range_sum -v
```
