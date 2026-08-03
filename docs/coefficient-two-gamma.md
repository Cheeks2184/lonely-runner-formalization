# Coefficient-two complementary-hole charging

Status: the forcing lemmas and four finite repairs are audited mathematics.
The uniform Hall selector below is **conjectural**. Exact computation through
`N=300` is evidence only; no coefficient-two or unrestricted LRC theorem is
claimed.

## Complementary-extra neighborhoods

Let `H=N+t`, with `4<=N`, `0<t`, and `2*t<=N`. For a base height `c`, define

```text
Auto(c) iff there exists d with H<d, c+d<=2N, and gcd(c,d)=1.

Gamma(c)={d : N<d<=H, H<c+d<=2N, gcd(c,d)=1}.
```

For `c<=N` and `2c<=H`, the raw interval underlying `Gamma(c)` is

```text
[max(N+1,H-c+1), min(H,2N-c)],
```

with exactly `min(c,t,N-c)` integers before filtering by coprimality.

Suppose `c` is a missing base height. If `Auto(c)` holds, choose its `d` and
put `q=c+d`. Then `N<q<=2N`, every selected speed is at most `H<d<q`, both
`c` and `q-c=d` are missing, and `gcd(c,q)=gcd(c,d)=1`. The existing two-hole
denominator theorem gives the closed `1/N` witness.

Likewise, if `d in Gamma(c)` is missing, `q=c+d` has `H<q<=2N` and gives the
same witness. Therefore a hypothetical no-witness family must satisfy

```text
Gamma(c) subset E
```

for every missing base height `c`, where `E` is the occupied-extra set in
`(N,H]`.

## Exact selector conjecture

Let `C(N,t)` consist of the `c` satisfying

```text
1<=c<=N,
2c<=H,
N-c-t < 2^omega(c),
not Auto(c),
```

and either `3*(N-t)<4c` or `(N,t,c)` belongs to the audited 22-triple
short-hole table.

Except for

```text
(N,t)=(4,2),(5,2),(8,4),(11,5),
```

the conjectural arithmetic statement is that the family `Gamma(c)`,
`c in C(N,t)`, has a system of distinct representatives. Equivalently,

```text
for every A subset C(N,t),
  |A| <= |union_{c in A} Gamma(c)|.
```

This one statement would close coefficient two. Under no witness, every
missing base height lies in `C(N,t)`: the reciprocal branch forces `2c<=H`,
the Kanold branch forces the short-interval inequality, the 22-case classifier
gives the generic-or-exception alternative, and `Auto(c)` has just been
eliminated. A selector restricted to the actual missing set `M`, together with
`Gamma(M) subset E`, would inject `M` into `E`, contradicting the already
verified identity `|M|=|E|+1`.

No proof of this selector theorem is known.

The lower bound `4<=N` is essential to this exact exception list. At
`(N,t)=(3,1)`, one has `C={2}` and `Gamma(2)=empty`, so the unqualified
selector fails. That row is already covered by the Lean-verified
coefficient-three theorem because `3*t<=N` (and it also has a direct
reciprocal repair). The deterministic verifier below intentionally starts at
`N=4`.

## Degree and minimal-deficiency reduction

There is a useful stronger description under `not Auto(c)`. The coprime part
of `Gamma(c)` is unchanged if its raw interval is extended above `H`:

```text
K(c)=[max(N+1,H-c+1), 2N-c].
```

Indeed, the added suffix is exactly the interval tested by `Auto(c)`, and by
hypothesis it contains no integer coprime to `c`. The length of `K(c)` is
`N-max(c,t)`. Partitioning it into disjoint blocks of length `2^omega(c)` and
applying the Lean-verified Kanold interval theorem gives

```text
|Gamma(c)| >= floor((N-max(c,t))/2^omega(c)).
```

For a generic candidate, the original raw interval has length
`min(c,t,N-c)>=ceil(c/3)`. Elementary prime-factor arithmetic gives
`3*2^omega(c)<=c` for `c>=7`, except `c=10`, whose interval still has length
at least four. Hence the only empty candidate neighborhood is
`(N,t,c)=(8,4,6)`.

Likewise, `6*2^omega(c)>c` holds exactly for

```text
{1,2,3,4,5,6,7,8,9,10,11,12,14,15,18,20,21,22,30,42}.
```

Thus every generic candidate with `c>=43` has at least two neighbors. A
generic singleton must have `c<=42`; the generic band then forces `N<=111`.
The nongeneric table already has `N<=18`, so the following exact finite
classification is globally complete, not a search extrapolation:

```text
(4,1,2;5), (4,2,2;5), (4,2,3;5),
(5,2,2;7), (5,2,3;7),
(6,2,4;7), (6,3,2;9), (6,3,4;7),
(7,2,4;9), (7,3,4;9),
(9,3,6;11), (9,4,6;11),
(11,2,6;13), (11,3,6;13), (11,4,6;13),
(11,5,6;13), (11,5,8;13),
(14,6,10;17), (14,7,10;17),
(17,7,12;19), (17,8,12;19),
(19,9,14;23).
```

The entry after the semicolon is the unique neighbor. The public verifier now
asserts and prints this list. It also confirms that the only two-vertex Hall
defects are the shared-neighbor rows at `(4,2)`, `(5,2)`, and `(11,5)`.

Consequently, outside the four repaired parameter pairs, any
inclusion-minimal Hall-deficient set `A` would satisfy

```text
N>=20,
|A|>=3,
|Gamma(A)|=|A|-1,
```

and its induced bipartite incidence graph would be connected with minimum
degree at least two on both sides. The equality follows by deleting any one
left vertex and using minimality. A right vertex of degree one would make that
deletion deficient again. The finite classification supplies the left-degree
claim. These properties do not themselves contradict deficiency; abstract
connected critical cores with these parameters exist.

Several stronger exact consequences survive adversarial review. If
`m=|A|`, `e` is the number of incidence edges, and
`p=sum_d binom(deg(d),2)` is the pair-intersection energy, then

```text
e>=2*m,
p>=e-(m-1)>=m+1,
cycle_rank=e-2*m+2>=2.
```

For every nonempty right subset `B`, deletion-perfect matchings give the
strict dual Hall inequality `|N_A(B)|>=|B|+1`. Every ordered prefix of the
left vertices is crossed by an actual shared Gamma neighbor. Moreover, every
portion of a raw or extended interval which belongs to only one left vertex
must be coprime-free for that vertex, and hence has length below its Kanold
threshold. In particular, if `c1<c2<...`, then

```text
c2-c1 < 2^omega(c1).
```

Here the `N>=20` and left-degree conclusions use the globally bounded
empty/singleton classification and the finite exclusion of smaller selector
failures; they do not follow from abstract graph minimality alone. Also, only
the unfiltered interval supports are monotone. Gcd filtering does not preserve
biconvexity.

Equivalently, writing `R={N+1,...,N+t}`, the exact remaining theorem is

```text
for nonempty A subset C and T subset R,
|A|+|T|>=t+1
implies some c in A, d in T satisfy
H<c+d<=2N and gcd(c,d)=1.
```

This is precisely Hall's condition after taking `T=R\Gamma(A)`. It makes
clear why scalar degree estimates alone cannot finish the proof.

A proposed strict pair-energy closure is now refuted. At `(N,t)=(14,6)`,
take `A={6,8,9,10}`. Its neighborhoods are

```text
6:{17,19}, 8:{15,17,19}, 9:{16,17,19}, 10:{17}.
```

Every proper subset is Hall-good, but `m=4`, `e=9`, and `p=9`, so
`e^2=(m-1)*(e+2*p)=81` exactly rather than strictly. The full set is also
Hall-good because its union has size four. Thus this refutes only
`ENERGY-EXCLUSION`, not the Gamma selector.

## Four finite repairs

Assume the no-witness consequences `M subset C`, `Gamma(M) subset E`,
nonempty `M`, and `|E|=|M|-1`. Exact finite deductions leave only:

```text
(4,2):  M={2,3},     E={5};
(5,2):  M={2,3},     E={7};
(8,4):  M={6},       E=empty,
         or M={4,5,6}, E={9,11};
(11,5): M={6,8},     E={13}.
```

Every configuration has a reciprocal witness. Use `c=3`, `c=3`, `c=6` or
`c=5`, and `c=6`, respectively: no selected speed in the corresponding
configuration is divisible by that missing height. Thus these four parameter
pairs are repairs to the proposed selector theorem, not exceptions to the
coefficient-two target.

## Reproducible evidence

The deterministic verifier checks every `4<=N<=300` and
`1<=t<=floor(N/2)`. The only full-candidate selector failures are the four
pairs above; it also enumerates every compatible finite repair configuration
and checks a collision counterexample to a simpler charge. Reproduce with

```bash
bash scripts/audit_coefficient_two_gamma.sh
```

The exact Python source SHA-256 is

```text
ba277ba8bcf9783415a68eae955384bb3afbadea3af2af36e466060a1618f970
```

and the expected-output SHA-256 is

```text
ea0f5e2ca58259e6a644323abe1a8743392b8178ae57a27366edabed602a57ca.
```

The expanded public replay under Python 3.14.4 completed in 8.50 seconds. It
now also prints the bounded singleton/empty-neighborhood classification. This
finite range cannot promote the selector conjecture.

## Refuted simpler charges

At `N=19,t=9`, take `M={9,14}` and `E={28}`. Both reciprocals are blocked,
but the one-output rule collides because

```text
3*9+1=28=2*14.
```

This is not an LRC counterexample: `q=29`, `c=9`, and `q-c=20` give an exact
two-hole witness. A second collision with `M={9,13,14}`, `E={26,28}` defeats
even the two affine alternatives `3*9-1` and `3*9+1`. Again the missing height
`20` repairs the family. The full `Gamma` relation records complementary
heights rather than choosing one affine output prematurely.

## Relation to known coprime matching work

Bohman and Peng prove an asymptotic coprime mapping theorem for two equal
intervals and use it to establish LRC for sufficiently large `n` when the
maximum speed is below `(2-epsilon)n`. Pomerance improves the interval-length
requirement to order `(log n)^2`. These primary results concern rectangular
interval matchings; they do not directly give the exact all-`N`, sliding,
candidate-dependent `Gamma` Hall condition or the needed Lean bridge. See
[Bohman--Peng](https://arxiv.org/abs/2109.09860) and
[Pomerance](https://arxiv.org/abs/2111.07157).

There is nevertheless a rigorous asymptotic specialization. Pomerance proves
that, for a sufficiently large ambient bound, two consecutive intervals of
the same even length have a coprime matching once half their length exceeds
`c*(log n)^2`. His corollary also treats odd length when the least elements
have opposite parity. The constant and ambient cutoff are existential in the
published statement used here.

For a direct even-interval reduction, write

```text
a=floor(3*(N-t)/4)+1,
b=floor((N+t)/2),
q=floor(t/4),
ell=2*q,
a0=max(t-ell,b-2*ell+1).
```

The generic candidates are contained in `[a,b]`. When `t>=16` and
`2*t<=N`, the adjacent length-`ell` intervals

```text
C0=[a0,a0+ell-1],
C1=[a0+ell,a0+2*ell-1]
```

cover `[a,b]`. The nontrivial width estimate is

```text
b-a+1 <= (5*t-N)/4+1 <= 3*t/4+1 <= t-3 <= 2*ell,
```

while `t-ell<=a` puts the left endpoint in the right place. Define disjoint
extra intervals

```text
D0=[N+1,N+ell],
D1=[N+ell+1,N+2*ell].
```

They lie in `(N,N+t]` because `2*ell<=t`. Every pair in `C0 x D1` and
`C1 x D0` is a Gamma-eligible sum pair. The strict lower endpoint follows
from `a0+ell>=t`, giving `c+d>N+t`. For the closed upper endpoint, it is
enough to show `a0+3*ell-1<=N`; the two branches in the maximum defining
`a0` give respectively `t+2*ell-1<N` and `b+ell<=N`.

All four intervals have the same even length `ell=2*q`. Apply Pomerance to
`(C0,D1)` and `(C1,D0)`. The two right images are disjoint, so the union of
the bijections, restricted to actual generic candidates, is a Gamma system of
distinct representatives. On the active branch `N<3*t`,
`q=floor(t/4)>N/12-1`, and every value is at most `H=N+t<=3*N/2`.

It follows from Pomerance's theorem that there exists `N0` such that, for
every `N>=N0` and `t` with

```text
0<t, 2*t<=N<3*t,
```

the complete generic candidate family has a Gamma system of distinct
representatives. All 22 nongeneric triples have `N<=18`, so enlarging `N0`
gives the full candidate selector on this active asymptotic frontier. This is
audited manuscript mathematics using a primary published theorem; it is not
Lean-verified, its cutoff is not explicit, and it does not settle the exact
all-`N` selector. The `3*t<=N` branch is already bypassed for the
coefficient-two LRC objective by the Lean-verified coefficient-three theorem.

The published proof does not expose a numerical cutoff. Its first missing
datum is the absolute constant `c1` imported from Iwaniec's interval-sieve
estimate; it subsequently uses an unspecified `c2`, sets
`c=3*c1*c2^2`, and invokes further unnamed constants and sufficiently-large
thresholds. No inherently ineffective input was identified, but obtaining a
number would require a new explicit reworking of those estimates. If explicit
Pomerance constants `(cP,nP)` were supplied, any `N0>=max(45,nP)` satisfying
`N/12-1>cP*(log(3*N/2))^2` thereafter would suffice for this geometric
reduction.

A tempting stronger reduction—matching the entire containing rectangle—is
false at `(N,t)=(17,7)`: the intervals `[8,12]` and `[18,22]` both have an
even majority and cannot be coprime-matched. Candidate pruning removes `8`
and `9`, leaving `{10,11,12}`, which does match. Exact finite control of this
pruning, or a direct triangular coprime-pair theorem for the critical cores,
is the remaining task.
