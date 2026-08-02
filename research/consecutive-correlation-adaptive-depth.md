# Exact adaptive correlation depth for consecutive speeds

## Scope and result

Put `A_n=(1,...,n)`, `N=n+1`, and let `L_(n,d)` be the Response 39
correlation score defined in `docs/correlation-obstruction-family.md`.  Define

```text
d_min(n) = min { d>=1 : L_(n,d)(A_n)>0 },
c(n) = floor(n/2).
```

The cutoff `c(n)` is tautological: at that depth the polynomial sees the
zero-count exactly.  This note determines `d_min` for every `n>=90`:

```text
n even: d_min(n)=c(n)-2.

n odd and 3*n*phi(n+1) > (n-2)*(n-3): d_min(n)=c(n)-2.

n odd and 3*n*phi(n+1) <= (n-2)*(n-3): d_min(n)=c(n)-1.       (A)
```

Consequently the distance `c(n)-d_min(n)` is always one or two for `n>=90`.
It equals two for every even `n`, and both values occur infinitely often
among odd `n`.  Thus

```text
liminf (c(n)-d_min(n)) = 1,
limsup (c(n)-d_min(n)) = 2.
```

This is a theorem about one sufficient correlation certificate on the very
special tuple `A_n`.  Every `A_n` already has the elementary lonely time
`1/(n+1)`.  Formula (A) neither proves a new case of LRC nor gives a uniform
argument for arbitrary speed tuples.

## Score in terms of the weighted histogram

Write `D_k` for the number of pivot-grid incidences having exactly `k` bad
runners.  The audited polynomial identity gives

```text
L_(n,d) = D_0
 - (1/(n-1))*sum_(k=2d)^(n-2)
       D_k*(n-1-k)*C(k-1,2d-1).                         (1)
```

The circle-packing argument in `docs/correlation-obstruction-family.md`
proves

```text
D_0=n*phi(n+1).                                         (2)
```

## Classification of the high bad-count layers

**Lemma.** For `n>=4` and `floor(n/2)<k<=n-1`,

```text
D_k=2.
```

**Proof.** Consider pivot `p`, modulus `M=Np`, and a candidate numerator
`r`.  Let `S` be the set of speeds `1<=i<=n` whose least circular residue
`i*r (mod M)` is strictly below `p`.  Thus `|S|=k`, and `p` itself is not in
`S` because `N` does not divide `r`.

Replace `r` by its signed least residue and write its absolute value as `s`.
If `S` contains two consecutive integers, subtraction of their signed bad
representatives gives `s<2p`.  If `n` is even, any subset of `{1,...,n}` of
size greater than `floor(n/2)` contains consecutive integers.  If `n` is
odd, the only counterexample at that size is the set of all odd indices.  In
that exceptional pattern `1` is bad, hence `s<p`; for `s>=2` the calculation
in the next paragraph makes `S` an initial interval, which contains
consecutive indices.  Therefore either `s=1`, or `2<=s<2p`.

Suppose first that `2<=s<=p`.  Since `i<=N-1`, one has
`0<i*s<=M-p`; hence no wraparound bad interval is reached and

```text
S={i : i*s<p}.
```

It has `ceil(p/s)-1<=floor(n/2)` elements.  Suppose instead that
`p<s<2p`.  The initial bad interval is empty.  The only possible bad indices
lie in

```text
(M-p)/s < i < (M+p)/s,
```

an open interval of length `2p/s<2`, so there are at most two.  The bad
interval just below `2M` cannot occur, because

```text
(N-1)s <= (N-1)(2p-1) < 2Np-p.
```

For `n>=4`, two is at most `floor(n/2)`, a contradiction.  Thus `s=1`.
The two numerators are exactly `r=1,M-1`; at pivot `p` each makes precisely
the speeds `i<p` bad, so `k=p-1`.  For every high `k` there is one pivot
`p=k+1` and exactly these two incidences.  QED.

It follows from (1), the lemma, and the weighted hockey-stick identity that
whenever `2d>floor(n/2)`, the score has the exact closed form

```text
L_(n,d)=n*phi(n+1) - (2/(n-1))*C(n-1,2d+1).             (3)
```

This is an identity, not an estimate from finite data.

## Excluding every earlier depth

It remains important not to infer `d_min` merely from the two near-top
values.  We prove every `d<=c(n)-3` nonpositive once `n>=90`.

For `d>=2`, retain only the two extreme residues at every pivot, as in the
earlier obstruction theorem.  This gives

```text
L_(n,d) <= n*phi(n+1) - (2/(n-1))*C(n-1,2d+1).          (4)
```

If `n` is even and `2<=d<=c(n)-3`, binomial symmetry and unimodality give
`C(n-1,2d+1)>=C(n-1,4)`.  If `n` is odd they give the stronger endpoint
bound `C(n-1,2d+1)>=C(n-1,5)`.  The even bound already exceeds `n^2` after
multiplication by `2/(n-1)` for `n>=20`; the odd bound does so for `n>=14`.
Since `n*phi(n+1)<=n^2`, (4) is then strictly negative.

Depth one needs more incidences.  At every pivot `p`, retain the distinct
candidate pairs `r=+/-s` for `1<=s<=4` and `s<p`.  Their bad count is exactly

```text
k=floor((p-1)/s).                                       (5)
```

For `s=1`, summing their debt gives `(n-2)(n-3)/3`.  For `2<=s<=4`, use

```text
(p-1)/s - 1 <= k <= (p-1)/s
```

and the fact that `(n-1-k)(k-1)` is increasing up to the midpoint.  Summing
from `p=2s+1` gives the following floor-free lower bound for the selected
depth-one debt:

```text
B(n)=(490*n^3-5865*n^2+24383*n-29064)/(432*(n-1)).      (6)
```

Direct subtraction yields

```text
B(n)-n^2
 =(58*n^3-5433*n^2+24383*n-29064)/(432*(n-1)).          (7)
```

The numerator is `440106>0` at `n=90`.  Its forward difference is

```text
174*n^2-10692*n+19008,
```

which is positive and increasing for `n>=90`.  Hence `B(n)>n^2` for every
`n>=90`, and (1), (2), and the selected incidences show `L_(n,1)<0`.

Together these arguments exclude *all* earlier depths, without assuming
monotonicity of `L_(n,d)` in `d`.

## Evaluation of the two possible depths

Let `c=floor(n/2)`.  Formula (3) applies to `d=c-2` and `d=c-1` for
`n>=90`.

If `n` is even, at `d=c-2` it gives

```text
L=n*phi(n+1)-(n-2)>0.
```

If `n` is odd, at `d=c-2` it gives

```text
L=n*phi(n+1)-(n-2)*(n-3)/3,
```

whose strict positivity is exactly the condition in (A).  If that condition
fails, then `d=c-1` gives `L=n*phi(n+1)-2>0`.  This proves (A).

For infinitely many gap-one examples take `n+1` divisible by `30`.  Then
`phi(n+1)<=4(n+1)/15`, and the gap-two inequality fails for all sufficiently
large such `n` (in fact from `n=29`).  For infinitely many odd gap-two
examples take `n=2^a-1`; then `phi(n+1)=(n+1)/2`, and the inequality is
strict.  Even values already supply another infinite gap-two family.

## Exact finite audit

`scripts/analyze_consecutive_correlation_depth.py` literally enumerates every
pivot incidence and uses `Fraction` arithmetic.  Complete exact scans give:

```text
n        4  5  6  7  8  9 10 11 12 13 14 15 16 17 18
d_min    1  1  1  2  2  2  2  3  2  4  4  5  5  6  6
```

For `19<=n<=89`, `d_min=floor(n/2)-2`, except

```text
n=29,41,59,65,77,83,89,
```

where it is `floor(n/2)-1`.  These bounded rows are computational facts; the
unbounded classification for `n>=90` follows from the proofs above.

Reproduce a chosen range with, for example,

```bash
python3 scripts/analyze_consecutive_correlation_depth.py --first 4 --last 35
PYTHONPATH=scripts python3 -m unittest -v \
  tests.test_consecutive_correlation_depth
```
