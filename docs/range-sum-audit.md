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

There is also an exact decomposition of this margin.  For a candidate residue
let `k(r)` be its number of bad nonpivot masks and let `Unc` count the residues
with `k=0`.  In a retained child/anchor cell `C`, let `z(r)=k(r)-1` be the
number of comparison parents containing `r`.  With `r_0=m-2` comparison
parents, define

```text
Theta(C) = sum_{r in C} z(r)(r_0-z(r)),
lambda(C) = Theta(C)-w(c(C)),
Loss(h) = sum_C lambda(C),
Debt(h) = sum_{r notin B_h, 2<=k(r)<=m-3}
  (k(r)-1)(m-k(r)-1)(m-k(r)-2).
```

Pointwise, `Theta(C)` is the sum of pairwise symmetric-difference sizes of
the comparison-parent subsets of `C`.  Triangle inequality gives
`Theta(C)>=V(c(C))>=w(c(C))`, so every `lambda(C)` is nonnegative.

The fixed-first-anchor pair part has residue contribution `k-1` when `h` is
bad and `k(k-1)/(m-1)` when `h` is nonbad.  After subtracting `S-|R|`, a
nonbad-`h` residue of multiplicity `k>=1` therefore contributes
`-(k-1)(m-k-1)/(m-1)`.  It occurs in `k` retained child cells, whose total
`Theta` contribution is `k(k-1)(m-k-1)`.  Clearing
`(m-1)(m-2)` and combining leaves exactly the negative debt summand.  An
uncovered residue instead contributes `+1`.  Replacing `Theta` by `w`
subtracts `Loss`.  This proves the exact identity

```text
pairPart(h)+W(h)-(S-|R|)
  = Unc - (Debt(h)+Loss(h))/((m-1)(m-2)).             (2)
```

The implementation checks `Theta>=V>=w` cell by cell and (2) numerically on
every pivot--anchor row of all six stress tuples and the strict failure below.

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

Three primitive, positive, distinct tuples fail both `RANGE-SUM-STAR` and the
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

Therefore `RANGE-SUM-STAR`, `DISPERSION-STAR`, and (on the latter two tuples)
`ANCHOR-STAR` are rejected only as uniform sufficient premises.  The exact
three-anchor and optimized additive assertions remain open.

The strongest strict failure found in this audit is

```text
(8,15,35,40,48,56,68,75,78).
```

For pivots in tuple order, its best range, dispersion, and anchor-star margins
(`threshold - best average` for the last column) are:

| pivot | range | dispersion | anchor-star |
|---:|---:|---:|---:|
| 8 | `-76/21` | `-76/21` | `-24/7` |
| 15 | `-76/21` | `-76/21` | `-32/21` |
| 35 | `-284/21` | `-12` | `-200/21` |
| 40 | `-464/21` | `-464/21` | `-418/21` |
| 48 | `-668/21` | `-662/21` | `-494/21` |
| 56 | `-74/3` | `-488/21` | `-430/21` |
| 68 | `-64/3` | `-352/21` | `-104/7` |
| 75 | `-718/21` | `-212/7` | `-500/21` |
| 78 | `-928/21` | `-878/21` | `-192/7` |

All entries are strictly negative.  The best range/dispersion row is pivot
`15`, first anchor `75`.  Its identity data are

```text
Unc=10, Debt=484, Loss=88, denominator=42,
margin = 10-(484+88)/42 = -76/21.
```

The best anchor-star row is also pivot `15`, first anchor `75`, with margin
`-32/21`.  Nonetheless the tuple has a three-anchor certificate at pivot
`15`, anchors `(35,48,75)`, cost `133<135`.  It also has an optimized additive
certificate at pivot `35`, bound `285<315`, order

```text
(56,75,15,40,8,48,68,78),
```

with insertion costs `(63,56,40,46,30,28,14,8)`.  This strictly rejects all
three averaging premises while again leaving the constructive routes and LRC
untouched.

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
python3 scripts/audit_range_sum.py --deep-tuple 8,15,35,40,48,56,68,75,78
python3 scripts/audit_range_sum.py --scan-runners 9 --max-speed 12
python3 scripts/audit_range_sum.py --scan-runners 9 --max-speed 120 --structured
python3 scripts/audit_range_sum.py --near-nine --max-speed 60
python3 -m unittest tests.test_range_sum -v
```
