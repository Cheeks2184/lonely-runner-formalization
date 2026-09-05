# Shifted integer rounding with vanishing affine slopes

Status: complete manuscript derivations and exact bounded checks. The Nat
one-zero theorem with `(C-size)` is now compiled in
`LonelyRunner/AffineGridVanishing.lean`, supported by
`LonelyRunner/AffineShiftArithmetic.lean`. The manuscript was independently
reviewed in `research/astra-pass3-review.md`; exact source review of the new
one-zero declaration is being completed. The signed and exact-size variants,
explicit family specialization, and multiple-zero extension remain manuscript
results. Original research worker: `/root/vanishing_slope`.
Requested routing: `gpt-6-astra` / `xhigh`; independently
observed runtime model metadata is unavailable. Source checkpoint:
`ed94a47061aa03167fa430d20368dc4684235932`, together with
`research/astra-affine-grid.md`. Current config, workflow policy/state, and
project workflow were read; `python3 scripts/validate_workflow.py` passed.
No source build, cleanup, state edit, or Lean edit was performed for this note.

The result below extends the admissible conditional grid families. It does
not provide a normalization theorem for arbitrary speed tuples, an induction
closing all remaining cases, or a proof/disproof of unrestricted LRC.

## 1. Exact one-zero-slope statement

Let `N` be an odd prime. There are `N-1` labelled original integer speeds:
one distinguished speed `U`, and `N-2` speeds `u_i`. Suppose positive integer
bases `A,a_i` and a positive integer `M` satisfy

```text
N | A,       N | U,       U == A (mod M),
0 < a_i < A,             N does not divide a_i,
u_i == a_i (mod M).
```

Here the distinguished coordinate is an original speed, not a dummy added
to the finite-field problem. A sufficient size condition is

```text
(N-2)*M >= N*A,
(A-a_i)*M >= N*a_i*A                       for every i.      (C-size)
```

Equivalently, `M` is at least the ceiling of

```text
max( N*A/(N-2),  max_i N*a_i*A/(A-a_i) ).
```

Then there exists an integer `0 <= n < N*M` for which every one of the
`N-1` original speeds has cyclic residue distance at least `M` modulo
`N*M`. Thus `t=n/(N*M)` is a witness for the full closed `1/N` threshold.
No primality or coprimality assumption on `M` is required. Positivity or
distinctness of original speeds is unnecessary for this arithmetic result;
the displayed family below has both.

### Construction and proof

Apply the kernel-checked `affine_avoidance_card_sub_two` to slopes
`a_i mod N` and offsets `u_i mod N`. Choose integer representatives

```text
1 <= r0,s <= N-1,
h_i = (s*u_i+r0*a_i) mod N,       1 <= h_i <= N-2.
```

Set

```text
r = ceil(M*r0/N + M/(N*A)),
beta = N*r-M*r0,
n0 = s*M+N*r,                    n = n0 mod (N*M).
```

The ceiling gives the exact half-open bound

```text
M/A <= beta < M/A+N.                                      (round)
```

In particular `A*beta >= M`. The distinguished upper bound must also be
proved: `(C-size)` and `(round)` give

```text
A*beta < M+N*A <= (N-1)*M.                                (star)
```

For every other coordinate,

```text
a_i*beta < a_i*M/A+N*a_i <= M.                            (small)
```

The second inequality is precisely the second line of `(C-size)`, after
multiplication by `A>0`. Importantly, the non-strict size assumptions still
give strict upper bounds because the ceiling bound is strict.

For any congruent speed/base pair `u==a (mod M)`, integer `r` gives

```text
n*u == M*(s*u+r0*a)+a*beta                       (mod N*M).
```

Indeed `n*u == s*M*u+N*r*a`, and `N*r=M*r0+beta`. For ordinary rows the
representative is therefore `h_i*M+a_i*beta`, lying in
`[M,(N-1)*M)`. For the distinguished row,
`s*U+r0*A == 0 (mod N)`, so its representative is `A*beta`, which lies
in `[M,(N-1)*M)` by `(star)`. These are actual least nonnegative residues;
there is no unaccounted wrap. Their distances from both endpoints of the
`N*M` interval are at least `M`.

Equivalently, write `u=a+M*q`. At the unreduced time `s/N+r/M`, the term
`r*q` is an integer. This is why shifting the ceiling is legitimate while
an arbitrary real perturbation would lose lift periodicity. Reducing time
modulo one preserves every integer-speed phase. The full runner count and
the closed boundary are unchanged.

If `N` does not divide `M`, the distinguished congruence and divisibilities
imply `U=A+N*M*k` for some integer `k`. If `N|M`, every integer lift
`U=A+M*k` is already divisible by `N`. Neither observation is an additional
premise of the theorem.

## 2. Exact rounding bounds and closed endpoint improvements

The coarse `(C-size)` bounds are convenient, not necessary. For the chosen
affine pair, the following conditions suffice for the same proof:

```text
a_i*beta <= M                   for every ordinary row,
M <= A*beta <= (N-1)*M.                                  (C-exact)
```

Ordinary upper equality puts a row with `h_i=N-2` exactly on the good
boundary `(N-1)*M`; it must not be rejected. Lower equality for `A*beta`
is also good. More generally, for a known pair one may allow
`a_i*beta <= (N-1-h_i)*M`; `(C-exact)` reserves only one complete floor
interval uniformly over all possible `h_i`.

There is an exact pair-independent bound if desired. Let

```text
L = ceil(M/A).
beta(r0) = L + ((-M*r0-L) mod N).
```

This follows because `beta` is the least integer at least `M/A` in the
residue class `-M*r0 mod N`. Always `beta <= L+N-1`. Consequently

```text
a_i*(L+N-1) <= M,
A*(L+N-1) <= (N-1)*M
```

is another sufficient uniform criterion. It can be made exact for the
worst possible nonzero `r0`:

* If `N|M`, every `r0` gives the same
  `B=N*ceil(M/(N*A))`.
* If `N` does not divide `M`, put `B0=L+N-1`. Then
  `B=B0` when `N` does not divide `B0`, and `B=B0-1` otherwise.

For the second claim, primeness makes `-M*r0`, as `r0` runs through the
nonzero field members, run through every nonzero residue. Among the `N`
consecutive integers from `L` to `L+N-1`, exactly the multiple of `N` is
excluded. Thus `B=max beta(r0)` exactly. The inequalities
`a_i*B<=M` and `A*B<=(N-1)*M` are necessary and sufficient for this
uniform one-interval certificate for every possible `r0`; they are not
necessary conditions for an LRC witness or for a better affine pair.

An exact closed-boundary fixture is

```text
N=3, M=2, A=U=3, a=u=2, r0=s=1,
r=1, beta=1, n=5, denominator=6.
```

The ordinary row has residue `4=(N-1)*M`, and the distinguished row has
residue 3. Both meet the `1/3` threshold. This fixture satisfies
`(C-exact)` but fails the coarse `(C-size)` bounds.

The distinguished upper bound cannot be dropped. Consider

```text
N=5, M=20, A=U=100, a=u=(1,2,3), r0=2, s=4.
```

All ordinary field residues are `(1,2,3)`. Shifted rounding gives
`r=9,beta=5,n=25` modulo 100. All ordinary corrections are at most `M`,
and `A*beta>=M`, but the distinguished phase is integral because
`A*beta=500`. The four cyclic distances are `(25,50,25,0)`. In fact
speed 100 is integral on every point of this particular grid. This is a
failure of an omitted hypothesis, not an LRC counterexample.

## 3. Why the unlifted case is elementary

When `u_i=a_i` and `U=A`, no external modulus or affine theorem is needed.
There are `N-2` forbidden unit values `-a_i^(-1)` among `N-1` field units.
Choose a remaining unit `k`. Then

```text
h_i=(k*a_i) mod N is in {1,...,N-2},
t0=k/N+1/(N*A).
```

The distinguished phase is an integer plus `1/N`, and each ordinary
phase has representative `h_i/N+a_i/(N*A)`, strictly between `h_i/N`
and `(h_i+1)/N`. This proves the closed threshold directly because
`0<a_i<A`. For example `(2,3,4,5)` at `N=5` has `k=4` and witness
`21/25`; the shifted finite grid with `M=100` gives exactly this time.

Thus the unlifted theorem is an elementary perturbation of a prime grid.
The point of Section 1 is to preserve the quotient terms for arbitrary
congruent lifted speeds whose offsets `u_i mod N` differ from their
slopes. The generic lifted result uses the already proved affine theorem;
its arithmetic alone should not be advertised as a new unrestricted
mechanism.

For comparison, the directly checked primary source,
[Sungkawichai–Trakulthongchai, Section 4 and Proposition 1.4](https://arxiv.org/html/2604.23906v2#S4),
treats bases `1,...,N-1` with odd prime `N` and a sufficiently large
external prime. Its stated hypotheses exclude the vanishing base here.
This is a comparison of sufficient hypotheses. No comprehensive literature
novelty claim is made, and exclusion by these hypotheses says nothing about
the applicability of other results or computational sieves in that paper.

## 4. A primitive lifted family beyond every A/B normalization

For every prime `N>=7`, choose

```text
M >= N^2*(N-1),
H = 1+M*ell,                 ell >= 1,
speeds = (2,3,N,4*H,5*H,...,(N-1)*H).
```

Use distinguished base/speed `A=U=N`, with ordinary bases
`2,3,4,...,N-1`. Their largest base is `N-1`, so the largest ordinary
size requirement is exactly `M>=N^2*(N-1)`; the distinguished size
requirement is weaker. Section 1 applies for every such `ell`, with
arbitrary resulting offsets. The speeds are positive, distinct, and
primitive because 2 and 3 remain present. Every integer denominator
`2,...,N` is blocked by a speed divisible by it.

Here “dense” refers to the existing maximal-pivot comparison: all `N-2`
other coordinates are lower owners at the maximal speed `(N-1)*H`.
It does not mean positive asymptotic density among all speed tuples.
The earlier owner-kernel numeric sufficient condition fails there for
every possible zero-dominator count `q>=0`, since its left-hand side is
at least `2*(N+1)*(N-2)>N*(N+1)`. No failure of full ordered/two-parent
certificates, or of every pivot, is asserted.

### A small core forces the normalization obstruction

Let `N>=7`, let `K>0` be **any** external modulus, and let `c` be a unit
modulo `K`. Suppose independent signs produce positive representatives
for the three speeds `(2,3,N)` with

```text
0 < b_j < K/(N-1),       b_j == +/- c*j (mod K),  j=2,3,N.
```

Write `w=min(c mod K,(-c) mod K)`, `x=w/K`, and
`epsilon=1/(N-1)<=1/6`. Positivity gives `0<x<=1/2`. Since all displayed
representatives are less than `K/2`, necessarily
`b_j/K=||j*x||`.

The inequality `||2*x||<epsilon` implies either
`x<epsilon/2` or `x>(1-epsilon)/2>=5/12`. The latter is impossible:
then `3*x` lies in `(5/4,3/2]`, so `||3*x||>1/4>epsilon`.
Thus `x<epsilon/2`. Now `3*x<3*epsilon/2<=1/4`, and the speed-3
inequality sharpens this to `x<epsilon/3`. Consequently

```text
N*x < N/(3*(N-1)) <= 7/18 < 1/2.
```

There is no wrap in the speed-`N` absolute residue: `b_N=N*w`.
In particular **`N|b_N`**. Therefore no normalization of the whole
lifted family into Theorem A's positive, small, nonvanishing bases exists,
for any modulus, coordinate signs, or common modular unit. This is a
symbolic obstruction, not merely a bounded search result.

Theorem B cannot evade it by selecting a different actual pivot. Its
small positive bases require `K>N-1`. Selecting original speed 2 or 3
as the pivot would require `K|2` or `K|3`, impossible. Selecting speed
`N` violates its requirement that the pivot not be divisible by `N`.
Any remaining pivot leaves the whole `(2,3,N)` core among the ordinary
coordinates, where the preceding argument forces a vanishing base.
Common unit transport preserves `K|w` for a proposed pivot `w`; choosing
a lift of that unit does not evade this argument.

This establishes strict enlargement beyond the exact normalization
contracts of Theorems A and B in `astra-affine-grid.md`. It does not
establish novelty relative to all LRC results.

### Explicit witnesses also cover composite runner counts

A subfamily admits a pair without any finite-field existence theorem.
For **every integer `N>=7`**, set

```text
M=N^2*(N-1)+1,
ell=1+N*z,                   z >= 0,
H=1+M*ell,
U_N=(2,3,N,4*H,...,(N-1)*H).
```

Take `r0=3` and `s=N-2`. Since `M==1 (mod N)` and `H==2 (mod N)`,
the two fixed ordinary rows have `h_2=2,h_3=3`; every row `j>=4` has

```text
h_j = (2*s+r0)*j mod N = N-j,            1 <= h_j <= N-4.
```

The shifted ceiling can be evaluated exactly:

```text
M*r0/N + M/N^2
  = 3*N*(N-1)+(N-1)+3/N+1/N^2,
0 < 3/N+1/N^2 < 1,
r=N*(3*N-2),                 beta=N^2-3.
```

Its reduced grid numerator is

```text
n=N^3-2,                     denominator=N*M.
```

Indeed `(N-2)*M+N^2*(3*N-2)=N*M+(N^3-2)`, with `0<n<N*M`.
All arithmetic bounds in Section 1 hold. That arithmetic did not use
primality: the only prime-dependent step was finding the affine pair,
which has just been supplied explicitly. Thus the displayed subfamily
has a witness for every integer runner count `N>=7`, even and composite
included. The normalization-obstruction proof likewise required only
`N>=7`.

Two exact fixtures (`z=0`) are:

| N | Speeds | Witness | Minimum circle distance |
|---|---|---|---|
| 7 | `(2,3,7,1184,1480,1776)` | `341/2065` | `322/2065 > 1/7` |
| 11 | `(2,3,11,4848,6060,7272,8484,9696,10908,12120)` | `1329/13321` | `1298/13321 > 1/11` |

These are lifted, divisor-covering, primitive examples with a uniform
certificate and a universal A/B normalization obstruction. The explicit
formula avoids a search even within this conditional family.

## 5. Several vanishing slopes: a valid simultaneous extension

Here `N` is again an odd prime, `M>0`, and the full original tuple has
`N-1` labelled speeds. Assume `1<=k<=N-1`, with `k` distinguished zero
rows and `N-1-k` ordinary rows. All congruences in this section are modulo
the same external modulus `M`: `U_j == A_j (mod M)` and
`u_i == a_i (mod M)` for every corresponding row.

Suppose the distinguished zero rows have positive bases
`A_j`, all divisible by `N`, and congruent original speeds `U_j` also
divisible by `N`. Let

```text
L=min_j A_j,       H=max_j A_j,
0 < a_i < L,      N does not divide a_i,
H < (N-1)*L.
```

There are `N-1-k <= N-2` ordinary rows. The avoidance theorem still
applies after padding to exactly `N-2` rows with arbitrary nonzero
dummy slopes and offsets, then restricting its conclusion. The dummy
rows are solely algebraic; the eventual distance conclusion is for the
original `N-1` speeds. This works even if there are no ordinary rows.

Choose

```text
r=ceil(M*r0/N+M/(N*L)),       beta=N*r-M*r0.
```

Sufficient size bounds are

```text
((N-1)*L-H)*M >= N*H*L,
(L-a_i)*M >= N*a_i*L                      for every ordinary row.
```

Then `M/L<=beta<M/L+N`. Every zero row has

```text
M <= L*beta <= A_j*beta <= H*beta < (N-1)*M,
```

and all ordinary corrections satisfy `a_i*beta<M`. The same residue
proof gives the full `1/N` witness. Thus multiple zero slopes are
possible when handled simultaneously in a common interval.

At the exact borderline `H=(N-1)*L`, the first good bands have the single
common point `beta=M/L`. It can work only with exact grid alignment:
`beta` must be an integer congruent to `-M*r0 mod N`. Since `N|L`, this
forces `N|M`, and then the congruence requires `N|beta`. Equivalently
`N*L|M`. Conversely that divisibility makes shifted rounding hit the
point for every `r0`, with both closed zero-row endpoints good. This
borderline is deliberately excluded from the robust positive-width bound.

## 6. Why this cannot simply be iterated

Choosing the largest zero base first generally leaves smaller zero bases
below the lower threshold. For example

```text
N=5, M=1001, zero bases/speeds (5,10), ordinary bases/speeds (1,2).
```

The valid ordinary affine pair `r0=1,s=2`, rounded using `A=10`, gives
`r=221,beta=104,n=3107` modulo 5005. The ordinary rows and speed 10 are
good, but speed 5 has distance `520/5005<1/5`. Re-rounding from the
smallest base repairs this particular example; choosing the largest
sequentially does not prove a multi-zero induction.

More fundamentally, under the uniform ordinary-row correction condition
`a_i*beta<=M`, the common first-band interval is

```text
M/L <= beta <= min((N-1)*M/H, M/max_i a_i).
```

It is empty if `H>(N-1)*L`, regardless of `M`. Allowing the zero rows
to wrap into later bands sometimes helps, but it does not remove the
obstruction uniformly while retaining the same ordinary-row protection.
There is an exact real-interval negative control:

```text
N=5, ordinary bases/speeds (1,9), zero bases/speeds (10,50).
```

Put `tau=beta/M`. Ordinary protection gives `0<=tau<=1/9`.
The zero-row phases, modulo integers, are `2*tau` and `10*tau`.
Since `0<=2*tau<=2/9<1/2`, the speed-10 inequality forces
`tau>=1/10`. But then `10*tau` lies in `[1,10/9]`, whose distance
from the integers is at most `1/9<1/5`. Thus **no real correction**
in the allowed interval can make both zero rows good. Increasing `M`,
changing `r0,s`, or choosing a different rounding residue cannot repair
this specific conservative correction contract.

This does not refute a broader construction that uses the actual
`h_i`-dependent room, allows other ordinary floor patterns, changes
representatives, or uses another time. For example at `N=5` the actual
phase margin of a row with `h_i=2` permits correction up to 2 rather
than 1. The obstruction is to the asserted automatic induction, not to
the tuple's LR property or to all affine-grid methods.

## 7. Exact remaining gap and potential formal interfaces

The one-zero theorem requires a representation in which every other
base is smaller than the distinguished multiple of `N`, together with
compatible modular offsets and the quantitative size bounds. No theorem
has supplied such a representation for arbitrary original speed tuples.
The several-zero theorem adds a range restriction and has an exact
counterexample to removing it while keeping the same uniform ordinary
correction rule. The general existence step still assumes prime `N`;
the explicit composite-inclusive family is a separate special case.

Useful formalization targets, without changing their hypotheses, are:

1. A ceiling lemma giving `M/A<=beta<M/A+N` and integer `r`.
2. A zero-residue circle-band lemma allowing
   `M<=A*beta<=(N-1)*M`, together with the ordinary closed band.
3. A full `N-1`-speed theorem with `N-2` nonzero slopes plus one
   explicitly labelled actual speed divisible by `N`.
4. The explicit `N>=7` lifted family, whose final witness formula needs
   no finite-field algebra or primality theorem.

These are conditional theorems and family certificates. They do not
complete the unrestricted canonical declaration.

## 8. Exact checks and compact reproducer

Fresh Python standard-library checks on 2026-09-05 used exact integers and
fractions only:

| Check | Domain and outcome |
|---|---|
| Single zero row | 94,560 exhaustive constructions: `N=3,5`, `A=N,2N`, labelled ordinary bases from `1,...,min(A-1,N+1)` excluding multiples of `N`, `M` at the coarse bound and one above, all ordinary lifts modulo `N`, two distinguished lifts. All full-grid inequalities passed. |
| Explicit lifted family | 776 instances: every integer `7<=N<=200`, `z=0,1,2,17`. Distinctness, primitivity, all small denominator blocks, and all full-grid inequalities passed. |
| Normalization core | 304,460 modular units: `N=7,11,13,17`, `2<=K<=500`. All 6,334 strictly compressed `(2,3,N)` cores had their `N`-base divisible by `N`. |
| Multiple zero rows | 5,200 lifted constructions for `N=5,7`, zero bases `(N,2N)`, `(2N,3N)`, `(N,2N,3N)`, and all ordinary offset classes. All passed. |
| Negative controls | Missing distinguished upper bound gives distance zero; largest-first two-zero rounding leaves speed 5 below threshold; periodic zero-row rescue fails on the exact real interval described above. |

These are corroborating checks, not proof or kernel evidence. The full
derivations above, including negative interval controls, do not depend on
search completeness. To rerun the compact checks, extract the following
block and execute it with `python3`:

```python
from fractions import Fraction as F
from itertools import product
from math import gcd

def ceil(q): return -(-q.numerator // q.denominator)
def rho(m, x): return min(x % m, (-x) % m)
def bound(N, A, a):
    return ceil(max([F(N*A, N-2)] + [F(N*x*A, A-x) for x in a]))

def construct(N, M, A, a, u, U):
    r0, s = next((r, s) for r in range(1, N) for s in range(1, N)
        if all((s*x+r*y) % N not in (0, N-1) for x, y in zip(u, a)))
    r = ceil(F(M*(A*r0+1), N*A))
    beta = N*r-M*r0
    n = (s*M+N*r) % (N*M)
    assert M <= A*beta <= (N-1)*M
    assert all(x*beta <= M for x in a)
    assert all(rho(N*M, n*x) >= M for x in u+[U])
    return r0, s, r, beta, n

count = 0
for N in (3, 5):
    for A in (N, 2*N):
        bases = [x for x in range(1, min(A, N+2)) if x % N]
        for a in product(bases, repeat=N-2):
            for M in (bound(N, A, a), bound(N, A, a)+1):
                for q in product(range(N), repeat=N-2):
                    u = [x+M*y for x, y in zip(a, q)]
                    for k in (0, 1):
                        construct(N, M, A, a, u, A+N*M*k)
                        count += 1
assert count == 94560

families = 0
for N in range(7, 201):
    M = N*N*(N-1)+1
    for z in (0, 1, 2, 17):
        H = 1+M*(1+N*z)
        U = [2, 3, N] + [j*H for j in range(4, N)]
        n, D = N**3-2, N*M
        assert len(U) == len(set(U)) == N-1 and gcd(*U) == 1
        assert all(rho(D, n*x) >= M for x in U)
        assert all(any(x % d == 0 for x in U) for d in range(2, N+1))
        families += 1
assert families == 776

units = compressed = 0
for N in (7, 11, 13, 17):
    for K in range(2, 501):
        for c in range(1, K):
            if gcd(c, K) != 1: continue
            units += 1
            b = [rho(K, c*x) for x in (2, 3, N)]
            if min(b) > 0 and (N-1)*max(b) < K:
                compressed += 1
                assert b[2] % N == 0
assert (units, compressed) == (304460, 6334)

clustered = 0
for N in (5, 7):
    for Z in ([N, 2*N], [2*N, 3*N], [N, 2*N, 3*N]):
        a = list(range(1, N-len(Z)))
        L, H = min(Z), max(Z)
        M = ceil(max([F(N*H*L, (N-1)*L-H)]
                     + [F(N*x*L, L-x) for x in a]))
        for q in product(range(N), repeat=len(a)):
            u = [x+M*y for x, y in zip(a, q)]
            r0, s = next((r, s) for r in range(1, N) for s in range(1, N)
                if all((s*x+r*y) % N not in (0, N-1)
                       for x, y in zip(u, a)))
            r = ceil(F(M*(L*r0+1), N*L))
            beta = N*r-M*r0
            n = (s*M+N*r) % (N*M)
            U = u + [x+N*M*(j+1) for j, x in enumerate(Z)]
            assert all(x*beta <= M for x in a)
            assert all(M <= x*beta <= (N-1)*M for x in Z)
            assert all(rho(N*M, n*x) >= M for x in U)
            clustered += 1
assert clustered == 5200

# Both closed endpoints are good.
assert rho(6, 5*2) == 2 and rho(6, 5*3) == 3
# Dropping the distinguished upper bound produces an integral phase.
assert [rho(100, 25*x) for x in (1, 2, 3, 100)] == [25, 50, 25, 0]
# Largest-first rounding does not protect the smaller zero row.
assert [rho(5005, 3107*x) for x in (1, 2, 5, 10)] == [1898, 1209, 520, 1040]
# Exact constants in the interval-wide multi-zero obstruction.
assert F(2, 9) < F(1, 2) and F(1, 9) < F(1, 5)
print('All shifted-rounding checks passed.')
```
