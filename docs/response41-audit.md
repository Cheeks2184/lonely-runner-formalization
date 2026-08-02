# Response 41 audit: adaptive depth, Chebyshev certificates, and divisibility

## Status

Response 41 contains several correct partial theorems.  None proves or
disproves the Lonely Runner Conjecture.  The supplied Python attachment was
downloaded from the signed-in Sol Pro conversation; its SHA-256 is

```text
5f49c4d72b964a327d94b5e3124132f8403b7e5548df94ad01c07dcd0905cc66
```

which exactly matches the hash stated in the response.  Its finite outputs
were reproduced independently.  Repository acceptance relies additionally on
`scripts/audit_response41.py`, independent proofs, three adversarial reviews,
and the Lean kernels described below.

## 1. Sharper depth threshold

For the consecutive tuple `A_n=(1,...,n)`, put `N=n+1`, `m=n-1`, and let
`D_k` count all pivot candidates having exactly `k` strict bad incidences.
The Response 39 score is

```text
L_(n,d) = D_0
          - (1/m) sum_(k>=2d) D_k (m-k) C(k-1,2d-1).
```

For every pivot `j` and `1<=s<=j-1`, the two candidates `r=+s,-s` have
exact bad count

```text
k_j(+/-s)=floor((j-1)/s).
```

Indeed `i*s <= n*(j-1) < n*j = N*j-j`, so no upper wrap can enter the
strict bad interval, and `rho_(N*j)(i*s)<j` is equivalent to `i*s<j`.

At depth one, the exact `+/-1` debt together with the selected residues
`+/-s`, `s=2,...,5`, is at least

```text
B_1(n)=(4151*n^2-48071*n+170760)/3600.
```

The difference `B_1(n)-n^2` is positive at `n=84` and increasing thereafter.
For `d>=2` with `m-2d>=5`, the `+/-1` debt and binomial unimodality give

```text
L_(n,d) <= n^2 - (n-2)(n-3)(n-4)/12 < 0.
```

Combining this with the previously audited exact high-layer identity improves
the complete adaptive-depth classification from `n>=90` to `n>=84`.  It is a
classification of one sufficient polynomial on an already-solved family, not
an LRC theorem.

## 2. Chebyshev polynomial

Assume `n>=3`, put `m=n-1`, and for `r>=1` define

```text
x(k)=1+2(1-k)/(m-1),       x_0=(m+1)/(m-1),
epsilon=1/T_r(x_0),
P_r(k)=(T_r(x(k))/T_r(x_0)-epsilon)/(1-epsilon).
```

For integer `1<=k<=m`, `x(k)` lies in `[-1,1]`; hence

```text
P_r(0)=1,
-2*epsilon/(1-epsilon) <= P_r(k) <= 0.
```

The coefficients are rational and the degree is exactly `r`.  Expressing the
polynomial in the binomial basis evaluates its histogram score from
`H_0,...,H_r`; either restrict `r<=m` or define `H_q=0` beyond `m`.

For consecutive speeds, choosing

```text
r >= ceil(sqrt(n-1) * log(4*n*(n+1)) / 2)
```

makes `epsilon<=1/(2*n*(n+1))`.  With
`H_0=n^2(n+1)/2` and the already-known `D_0=n*phi(n+1)>=n`, the score is
strictly positive.  The argument is correct, but it uses the safe mass `D_0`
obtained from the explicit lonely times.  It therefore shows that not every
sublinear-degree polynomial suffers the alternating-hierarchy obstruction; it
does not independently locate or prove a safe candidate.

`ChebyshevMoment.lean` formalizes the rational Chebyshev recurrence and exact
degree, transports the `[-1,1]` bound from mathlib, proves affine-grid
feasibility, and composes the abstract histogram inequality into
`chebyshevMomentHistogramScore_pos`. The analytic estimate proving the
particular logarithmic degree meets its growth hypothesis remains a paper
lemma; the finite algebraic kernel does not assume it as an axiom.

## 3. Small-denominator witness

For positive integer speeds and `N=n+1`, if some `2<=q<=N` divides none of
the speeds, then `t=1/q` is lonely.  A nonzero residue modulo `q` has circular
residue at least one, so

```text
||a_i/q|| >= 1/q >= 1/N.
```

Thus a positive-integer counterexample would have to cover every modulus
`2,...,N` by divisibility.  This is necessary only.  The tuple `(2,3,4,5)`
covers those moduli but is not a counterexample; for example, `t=1/7` works.
`smallDenominator_stationary_witness` states the result directly with the
standard total-runner denominator and unit-circle norm.

## 4. Cross-pivot scaling

If `a_k=q*a_j` and `gcd(q,N)=1`, multiplication by `q` injects the pivot-`j`
candidate grid into the pivot-`k` grid.  The identities

```text
N divides q*r  iff  N divides r,
rho_(q*M)(q*x)=q*rho_M(x)
```

show that every strict bad/safe component is preserved along the image.  This
is an exact arithmetic cross-pivot restriction, but it neither exhausts the
larger grid nor creates a safe point from an empty source safe set.

## 5. Comparable largest-speed descent

Let `0<a_1<...<a_n`, `N=n+1`, and `a_n<n*a_(n-1)`.  A signed-divisor
replacement of `a_n` by `b` exists exactly when there is

```text
2<=q<=N-2,  gcd(q,N)=1,
b=N*a_(n-1)/(q+1),  a_n=q*b,
```

with integral `b`, and for every `j<=n-2`,

```text
a_j divides a_(n-1)  or  N*a_j divides (q-1)*b.
```

At the second-largest pivot, the positive sign is too small to be a nonzero
multiple of `N*a_(n-1)`.  The negative sign and the interval below twice that
modulus force `a_n+b=N*a_(n-1)`.  All remaining alternatives then follow by
expanding the two signs.  Conversely, the displayed divisibilities construct
the required signs.  Since `b/a_(n-1)=N/(q+1)>1`, positivity and distinctness
are automatic.

The resulting restriction on a sum-minimal counterexample depends on the
already formalized completeness of pivot certificates.  Without that bridge,
the descent conclusion concerns only failure of the certificate property.

`ComparableSignedDivisor.lean` kernel-checks the full arithmetic iff as
`comparable_signedDivisor_iff`, its ordered-family sufficiency corollary, and
strict sum decrease. Instantiating its abstract lower family with the sorted
tuple and composing it with the earlier certificate-transport theorem remain
separate formal obligations.

## Reproduction

From the repository root:

```bash
PYTHONPATH=scripts python3 scripts/audit_response41.py
PYTHONPATH=scripts python3 -m unittest -v tests/test_response41.py
```

The first command's stdout must equal
`certificates/response41_expected.txt` byte-for-byte.

```text
cbb1078450e0c1eb9422250500601852f01895ddf22b3cb2488d30dc38429734  audit_response41.py
88b6a760deae6bd0cbd99741ede6a8fb76d55f03449c301419f1c24a6bc445db  response41_expected.txt
```

The exact audit reproduces Chebyshev degrees `37` and `47` at `n=59` and
`n=84`, verifies strict positivity of both rational scores, checks the
small-denominator and cross-pivot examples, compares the descent
characterization to a literal signed-congruence search, and confirms that the
stress tuple `G` has no eligible largest-speed descent.

## Remaining obstruction

The open problem is to prove a growing-order moment score positive directly
from generalized-CRT intersection tables, without assuming `D_0>0`, or to use
the divisor-cover and cross-pivot constraints to eliminate the residual
signed-descent-irreducible class.  Neither implication is presently known.
