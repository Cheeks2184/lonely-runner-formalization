# Consecutive-speed obstructions to bounded correlation depth

## Result and scope

Let `n>=4`, `N=n+1`, and take the structured speed tuple

```text
A_n=(1,2,...,n).
```

This note proves that every fixed depth of the Response 39 correlation
hierarchy fails on infinitely many such tuples, even though every tuple has
the explicit Lonely Runner certificate `t=1/N`.  This disproves a uniform
fixed-depth correlation strategy; it does **not** disprove the Lonely Runner
Conjecture and does not rule out a depth growing with `n`.

The standalone exact verifier is
`scripts/audit_correlation_obstructions.py`, with regression tests in
`tests/test_correlation_obstructions.py`.

## Definitions

For pivot speed `j`, enumerate residues

```text
1 <= r < N*j,  with N not dividing r,
```

representing the candidate time `t=r/(N*j)`.  Let `k(j,r)` be the number of
speeds `i in {1,...,n}` for which

```text
rho_(N*j)(i*r) < j.
```

For `d>=1` and `0<=k<=n-1`, define

```text
P_(n,d)(k)
 = sum_(q=0)^(2d-1) (-1)^q C(k,q)
   + (2d/(n-1))*C(k,2d),

L_(n,d)(A_n) = sum_j sum_r P_(n,d)(k(j,r)).
```

The already-audited polynomial identity gives

```text
P_(n,d)(0)=1,
P_(n,d)(k)
 = -((n-1-k)/(n-1))*C(k-1,2d-1) <= 0
```

for `1<=k<=n-1`.

## The exact safe-incidence count

**Lemma 1.** The only times `t in R/Z` satisfying

```text
||i*t|| >= 1/N  for every 1<=i<=n
```

are `t=m/N` with `gcd(m,N)=1`.

**Proof.** Consider the `N` points `0,t,...,n*t` on the circle.  The
difference of any two is `i*t` for some `1<=i<=n`, up to sign, so every two
points have circular distance at least `1/N`.  Order the points cyclically.
Each of the `N` consecutive gaps is at least `1/N`; because their sum is one,
every gap is exactly `1/N`.  Since one point is zero, the point set is the
`N`-grid.  In particular `t=m/N`.  The `N` multiples are distinct, so
`gcd(m,N)=1`.  Conversely, multiplication by such an `m` permutes the
nonzero residues modulo `N`, proving every required distance is at least
`1/N`.  QED.

**Lemma 2.** If `D_0` denotes the number of safe pivot-grid incidences, then

```text
D_0 = n*phi(N).
```

**Proof.** Lemma 1 gives exactly `phi(N)` safe times.  Every such `m/N`
occurs exactly once on every pivot grid: its pivot-`j` numerator is `m*j`,
and `N` cannot divide `m*j` because `gcd(m,N)=1` and `1<=j<N`.
Conversely, a safe pivot incidence represents one of Lemma 1's times.  Thus
each safe time has multiplicity `n`.  QED.

## A rigorous upper bound

**Theorem 3.** Whenever `1<=d` and `2d<=n-1`,

```text
L_(n,d)(A_n)
 <= n*phi(n+1) - (2/(n-1))*C(n-1,2d+1).       (1)
```

**Proof.** For every pivot `j`, the two candidate residues `r=1` and
`r=N*j-1` have

```text
k(j,r)=j-1.
```

Indeed, at `r=1` the circular numerator for speed `i` is `i`; it is strictly
below the threshold `j` exactly when `i<j`.  At `r=N*j-1` it is the negative
of `i`, with the same circular distance.  The latter assertion also uses
`N*j-i>=j`, immediate from `i<=n` (and valid at `j=1` as well).

Decompose `L` into the `D_0` safe terms, each equal to one, and all remaining
terms, each nonpositive.  Retaining only the two displayed nonpositive terms
for `2<=j<=n-1` gives

```text
L <= D_0
     - (2/(n-1))*sum_(j=2)^(n-1)
         (n-j)*C(j-2,2d-1).
```

The weighted hockey-stick identity

```text
sum_(x=0)^R (R+1-x)*C(x,m) = C(R+2,m+2)
```

(obtain it by interchanging the two sums after writing
`R+1-x=sum_(y=x)^R 1`) turns the sum into `C(n-1,2d+1)`.  Substitute Lemma 2
to obtain (1).  QED.

## Infinite failure at depth one

**Corollary 4.** If `N` is a positive multiple of `30` and `n=N-1` (hence
`n>=29`), then

```text
L_(n,1)(A_n) < 0.
```

**Proof.** Divisibility by `2`, `3`, and `5` gives

```text
phi(N) <= N*(1-1/2)*(1-1/3)*(1-1/5) = 4N/15.
```

At `d=1`, inequality (1) and `N=n+1` give

```text
L <= 4n(n+1)/15 - (n-2)(n-3)/3
   = (-n^2+29n-30)/15 < 0.
```

The last inequality holds at `n=29` and decreases thereafter.  QED.

## Every fixed depth fails infinitely often

**Corollary 5.** For each fixed integer `d>=1`, infinitely many consecutive
tuples `A_n` have `L_(n,d)(A_n)<0` while possessing the certificate
`t=1/(n+1)`.

**Proof.** Depth one is Corollary 4.  Let `d>=2`, put `k=2d+1`, and choose
arbitrarily large `n==29 (mod 30)` satisfying

```text
n-1 >= 2k,
(n-1)^(k-3) > 2^(k+1)*k!.                    (2)
```

Such values exist because `k-3>=2`.  The first inequality in (2) gives

```text
C(n-1,k) >= ((n-1)/2)^k/k!.
```

The second, together with `n<=2(n-1)`, implies

```text
2*C(n-1,k) > n^2*(n-1).
```

Using only `phi(n+1)<=n` in (1) now yields `L_(n,d)(A_n)<0`.  Finally,
`t=1/(n+1)` is a direct certificate because
`min(i,n+1-i)>=1` for every `1<=i<=n`.  QED.

This is an actual infinite theorem, not an inference from the computation.
The exact finite scan is only an independent audit of the definitions and
identities.

## A linearly growing sub-tautological depth also fails

**Corollary 6.** For every `n==59 (mod 60)`, set

```text
d=(n-3)/4.
```

Then `L_(n,d)(A_n)<0`.  In particular this obstruction depth grows linearly,
while remaining asymptotically half of the tautological depth `(n-1)/2`.

**Proof.** Here `2d+1=(n-1)/2`, so the binomial coefficient in (1) is the
central coefficient in row `n-1`.  Because the largest of the `n`
coefficients in that row is at least their average,

```text
C(n-1,(n-1)/2) >= 2^(n-1)/n.
```

Also `2^n>n^3*(n-1)` for `n>=59`.  Direct integer comparison proves this at
`n=59`; thereafter the ratio `2^n/(n^3*(n-1))` increases, since

```text
2*n^2*(n-1) > (n+1)^3
```

for `n>=6`.  (After expansion, the difference is
`n^3-5n^2-3n-1`; it is positive at six and its forward difference
`3n^2-7n-7` is then positive.)  Therefore the negative term in (1) is
strictly larger than `n^2`.  Since `n*phi(n+1)<=n^2`, the score is negative.
The congruence condition makes `d` integral; it also supplies infinitely many
values of `n`.  QED.

## Complete bounded evidence

The verifier completely enumerates all pivot-grid incidences for

```text
4 <= n <= 35
```

and every depth `1<=d<=floor((n-1)/2)`.  Among its regression rows are

```text
n=7,  d=1:  L=-32/3
n=10, d=2:  L=544/9
n=11, d=2:  L=-156/5
n=29, d=1:  L=-110027/14
```

This bounded enumeration is explicitly not claimed as an exhaustive search
over other speed tuples or over unbounded `n`.

## Reproduction

```bash
python3 scripts/audit_correlation_obstructions.py
PYTHONPATH=scripts python3 -m unittest -v tests.test_correlation_obstructions
```
