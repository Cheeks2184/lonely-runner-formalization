# Exact optimization of binomial-moment zero bounds

## Scope

This note replaces the choice of one correlation polynomial by the exact
finite linear program over **all** polynomials of a prescribed degree.  It
derives the primal and dual, classifies the primal vertices, and records exact
tests on literal pivot grids.  The optimization improves several finite
examples, but a theorem below shows that every fixed moment order still fails
on infinitely many consecutive-speed tuples.  Nothing here proves or
disproves the Lonely Runner Conjecture.

The standalone rational-arithmetic verifier is
`scripts/audit_moment_lp.py`; its tests are in `tests/test_moment_lp.py`.

## The finite primal and dual

Fix `m>=1`.  Let `D_0,...,D_m` be a nonnegative bad-count histogram and let

```text
H_q = sum_(k=0)^m D_k*C(k,q),       0<=q<=r,
```

where `1<=r<=m`.  In the common-slice application `m=n-1`: a slice with
positive pivot multiplicity omits at least its pivot runner from the strict
bad set.  In the verifier, every reported `D` is instead constructed directly
from the literal candidate residues on explicit integer pivot grids.

For coefficients `c_0,...,c_r`, put

```text
P(k)=sum_(q=0)^r c_q*C(k,q).
```

The best degree-`r` lower bound obtainable solely in this way is the primal LP

```text
maximize    sum_q c_q H_q
subject to  P(0)<=1,
            P(k)<=0,                 1<=k<=m,
            c_q unrestricted in sign.
```

Indeed,

```text
sum_q c_q H_q = sum_k D_k P(k) <= D_0.
```

Writing one nonnegative dual variable `y_k` for each pointwise constraint
gives the exact dual

```text
minimize    y_0
subject to  sum_(k=0)^m y_k*C(k,q)=H_q,   0<=q<=r,
            y_k>=0.
```

Thus the optimum is the least zero mass among all nonnegative
**pseudo-histograms** matching the supplied moments.  The actual histogram
`D` makes the dual feasible, so the primal is bounded; ordinary finite LP
duality gives equality and attainment.  This interpretation is deliberately
not an arithmetic-realizability claim: a dual pseudo-histogram need not arise
from any speed tuple.

## Complete classification of primal vertices

The zero polynomial is a vertex when `r<m` (and remains a harmless feasible
comparison point when `r=m`).  Every nonzero vertex has `P(0)=1` and exactly
`r` distinct roots

```text
1=s_1<s_2<...<s_r<=m.
```

To see this, a vertex needs `r+1` independent active point constraints.  If
the constraint at zero is not active, the polynomial has at least `r+1`
positive roots and is therefore zero.  Otherwise it has `r` positive roots,
has full degree, and is exactly

```text
P(k)=product_(i=1)^r (1-k/s_i).
```

Feasibility on the integer grid is equivalent to

```text
s_1=1,
s_(2i+1)=s_(2i)+1 whenever 2i+1<=r,
s_r=m when r is even.
```

The first condition prevents a positive value before the first root.  After
each even-numbered root the sign is positive until the next root, so those
two roots must be consecutive grid points.  For even degree the sign after
the last root is positive, forcing that root to be `m`.  These conditions are
also sufficient.  Consequently exact optimization needs no numerical LP
solver: enumerate these root sets, evaluate their rational objectives, and
compare with the zero polynomial.

The verifier independently enumerates all root subsets for every `m<=10` and
checks that the sign test gives exactly the classified list.  For every
positive reported optimum it also solves the complementary dual on support
`{0,s_1,...,s_r}` and verifies nonnegativity, all moment equations, and equal
primal/dual objectives.

The Response 39 degree-`2d` polynomial is the particular vertex with roots

```text
1,2,...,2d-1,m.
```

It is therefore always dominated by the optimized degree-`2d` LP, but need
not be optimal.

## Exact realizable data

All rows in this section come from literal enumeration of the pivot modulus
`(n+1)*a_j`, excluding exactly the residues divisible by `n+1`, with strict
bad boundary `rho<a_j`.

For

```text
G=(15,21,40,48,56,105,126,280,1200),
```

the aggregate histogram is

```text
(2272,6134,5610,2208,584,180,7,16,8).
```

The optimized order-3 bound is

```text
6061/6 > 0,       roots (1,3,4),
P(k)=1-C(k,1)+(5/6)C(k,2)-(1/2)C(k,3).
```

Thus moments only through `H_3` already prove a safe pivot incidence exists
for this tuple.  The fixed order-4 Response 39 score is `3305/2`; it is the
order-4 optimum here.  The individual safe-pivot counts, independently
enumerated, are

```text
(0,10,0,16,48,142,156,382,1518).
```

At pivot `56` alone, the order-3 polynomial with roots `(1,3,4)` gives the
strict lower bound `38/3`.

Two nearby structured rows also improve:

```text
T10=(1,2,3,4,5,6,7,8,9,11):
  first positive optimized order <=6 is order 5,
  score 29/9, roots (1,2,3,8,9).

T11=(1,2,3,4,5,6,7,8,9,11,12):
  first positive optimized order <=6 is order 5,
  score 59/9, roots (1,3,4,8,9).
```

By comparison, the fixed hierarchy first gives `4` at order 6 for `T10` and
is still zero at order 6 for `T11`.

The complete bounded scan covers consecutive tuples `(1,...,n)` for
`4<=n<=35`, powers-of-two tuples `(1,2,...,2^(n-1))` for `4<=n<=13`, and
orders at most six.  It is bounded evidence only.  For example, the powers
rows all have a positive bound by order three in that range.  Among the
consecutive rows, no order-at-most-six bound is positive at `n=19,21` or any
`23<=n<=35`; this is not a statement about higher orders.

## Infinite obstruction to every fixed optimized order

Let

```text
A_n=(1,2,...,n),   N=n+1,   m=n-1.
```

As proved in `docs/correlation-obstruction-family.md`, its safe-incidence
count is

```text
D_0=n*phi(N).
```

**Theorem.** For each fixed `r>=1`, infinitely many tuples `A_n` have optimal
degree-`r` moment bound equal to zero, despite the explicit Lonely Runner
certificate `t=1/N`.

**Proof.** Consider a nonzero degree-`r` vertex `P` from the classification
above and suppose

```text
m>=12(r+1),       delta=1/(12r).
```

Among the integer points in `[ceil(m/3),floor(2m/3)]`, remove every point at
distance less than `delta*m` from one of the `r` roots.  The original interval
has at least `m/3-1` points, while the removed union has at most
`2r*delta*m+r=m/6+r` points.  At least `m/12` points remain.

At each remaining point `k`, the factor belonging to the root `1` has
absolute value `k-1>=m/4`.  Every other normalized factor has absolute value
at least `delta`, since its root is at most `m`.  Feasibility supplies the
negative sign, so

```text
-P(k) >= (m/4)*delta^(r-1).
```

For every such `k`, pivot `j=k+1` has two distinct candidate residues `1` and
`N*j-1`, each with exactly `k=j-1` bad runners.  Keeping only these
nonpositive contributions yields

```text
sum_k D_k P(k)
 <= D_0 - [m^2/(24*(12r)^(r-1))].                 (1)
```

Choose a squarefree product `Q` of sufficiently many primes that

```text
phi(Q)/Q < 1/[96*(12r)^(r-1)].
```

Such a finite product exists by the classical fact that the finite Euler
products `product_(p<=x)(1-1/p)` tend to zero.  Take arbitrarily large
multiples `N` of `Q`.  Then `phi(N)/N<=phi(Q)/Q`; since `N=m+2<=2m` for
`m>=2`, this makes

```text
D_0=(N-1)phi(N) < m^2/[24*(12r)^(r-1)].
```

Equation (1) is strictly negative for every nonzero vertex.  The zero
polynomial has objective zero, hence the exact LP optimum is zero.  Finally,
`t=1/N` is a direct certificate for `A_n`.  QED.

This theorem concerns actual arithmetic pivot histograms, not arbitrary
moment twins.  It rules out every uniform fixed-order strategy based only on
these moments, even after optimizing the polynomial separately for each
tuple.  It does not rule out an order growing with `n` or additional
arithmetic information beyond the moments.

## Reproduction

```bash
python3 scripts/audit_moment_lp.py
python3 -m unittest -v tests.test_moment_lp
```
