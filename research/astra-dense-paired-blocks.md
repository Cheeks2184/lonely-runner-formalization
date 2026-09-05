# Phase cells for dense endpoint clusters with holes

Requested Astra xhigh derivation, 2026-09-05. Source checkpoint:
`a637d343d7bcc3b1f308de21241d1556126fd690`.
Status: candidate manuscript requiring separate independent review; no new
Lean theorem or unrestricted LRC resolution is claimed. The root proposed
the paired phase-cell interval and a sufficient large-p bound. This audit
independently derives that interval, sharpens the bound by its exact residue
test, and verifies the root's subsequent extension to unequal endpoint
clusters. No literature-novelty claim is made.

Current configuration, workflow, policy, and state were read; the structural
validator passed. The accepted mirrored core and all-runner manuscripts,
their reviews, and both Lean sources were read. Reference source hashes:

| File | SHA-256 |
| --- | --- |
| `LonelyRunner/MirroredBlockWitness.lean` | `70d94cf55b457f49dcfa8c22bf8a3404abb4db1aec5e43254749ea73711da9c1` |
| `LonelyRunner/MirroredBlockFamily.lean` | `670b27d5e0083cf84999ad81410c9def4437f6d23fca7390374ffd2926169272` |
| `research/astra-mirrored-formal-review.md` | `32bb2549037452f012cd972ad3c80e1b649da97726a3b4816101b42e02d22a45` |
| `LonelyRunner/CoefficientThreeHeight.lean` | `f903274ade7d4daea6737b9f28fe967934348fdd4d857fc270471dc0dc07d56e` |
| `LonelyRunner/StructuredClasses.lean` | `5328a7a88d2b42f86ffc3f0f0418ca22c761219e8fa3e5822bda5a18ac286e8c` |

## Exact cell criterion

Let N>=4, 1<=a0<=M<p be integers, delta=1/N, and define real numbers

```text
L = delta/a0,                  U = (1-2*delta)/M,
ell = p*L-(1-delta),           h = p*U-(1-delta).
```

The following equivalence concerns this particular cell, not arbitrary
lonely-runner witnesses:

```text
exists integer k and real t,y with
  L <= t <= U,  p*t=k+y,  M*t+delta <= y <= 1-delta
if and only if
  [ell,h] contains an integer.                                (1)
```

An interval whose lower endpoint exceeds its upper endpoint is empty.
For every integer k in that interval an explicit witness is

```text
t = max(L, (k+delta)/(p-M)),    y = p*t-k.                       (2)
```

To prove necessity, the upper bound on y gives
`k>=p*t-(1-delta)>=ell`. The lower bound gives
`k<=(p-M)*t-delta<=(p-M)*U-delta=h`, where the last identity uses
`M*U=1-2*delta`.

For sufficiency, first ell<=k<=h implies L<=U. Put
`a=(k+delta)/(p-M)` and `b=(k+1-delta)/p`. All denominators are positive.
The lower interval bound gives L<=b, and the upper gives a<=U. Moreover,

```text
a <= b  iff  M*k <= p*(1-2*delta)-M*(1-delta)
         iff  k <= h.
```

Consequently `max(L,a)<=min(U,b)`. This proves all cell inequalities for
(2). Its time is positive because L>0. Also `delta<y<=1-delta<1`, since
M*t>0. Thus the integer k is actually floor(p*t). Although (1) permits
arbitrary integers, ell>-1 and hence every admitted integer k is nonnegative.

The cell supplies the following pointwise norm bounds without any count
assumption on the containing intervals:

```text
||a*t|| >= delta              for every real a in [a0,M],
||(p-b)*t|| >= delta          for every real b in [0,M].        (3)
```

Indeed `delta<=a*t<=M*t<=1-2*delta<=1-delta`. For the high speeds,
subtract the same integer k: `y-b*t` lies in `[delta,1-delta]`, by
`y>=M*t+delta` and `b>=0`. The endpoint b=0 includes p itself. The displayed
representatives already lie in the closed good band; no wrap is inferred
without checking it. In applications N is fixed by the original runner
count, and (3) merely bounds every required coordinate at that same delta.

If U>L and `p*(U-L)>=1`, a closed interval of length at least one contains
an integer, for example `ceil(ell)`. This is sufficient, not necessary.
Here

```text
U-L = ((N-2)*a0-M)/(N*M*a0).
```

If M=(N-2)*a0, the cell has only the possible time L=U. It exists exactly
when

```text
p == (N-1)*a0  (mod N*a0).                                    (4)
```

This follows by requiring `p/(N*a0)-(N-1)/N` to be an integer. If
M>(N-2)*a0, then U<L and this cell is impossible. Neither statement is a
claim that ordinary witnesses outside this cell cannot exist.

## Exact residue test when a0=1

Write p=N*q+rho with `0<=rho<N`. Then

```text
ell = q + (rho-N+1)/N,     q-1 < ell <= q,
```

so the least possible integer k is precisely q=floor(p/N). Thus (1) is
equivalent to the completely explicit condition

```text
p*(N-2-M) >= M*(N-1-rho),     rho=p mod N.                     (5)
```

This follows by substituting q=(p-rho)/N into q<=h and multiplying by
positive N*M. If (5) holds, use

```text
t = max(1/N, (floor(p/N)+1/N)/(p-M)).                          (6)
```

When rho>=M+1 the maximum is 1/N; otherwise it is the second entry.
This is the earlier mirrored formula with M controlling the width and
the independently fixed N controlling the threshold.

For M<N-2 a residue-independent sufficient condition is

```text
p*(N-2-M) >= M*(N-1).                                        (7)
```

It improves the interval-length condition `p*(N-2-M)>=N*M` by using the
location of ell relative to the integer grid. Equality is included in (5)
and (7); these are closed-boundary arguments. For M=N-2, condition (5)
reduces to rho=N-1, agreeing with (4).

## All chosen runners in two possibly unequal clusters

Let M>=1 and let A,B be arbitrary subsets of `{1,...,M}`. Define

```text
N = |A|+|B|+2 >= 4,
T = {0} union A union {p-b : b in B} union {p},
```

where p is an integer satisfying

```text
p >= 2*M+1,       M < N-2,
(p-M)*(N-2-M) >= M*(N-1).                                    (8)
```

**Theorem.** For each r in T there exists a real t>0 such that

```text
for every s in T with s!=r,   ||t*(s-r)|| >= 1/N.              (9)
```

Proof of count: `{0} union A` lies in [0,M], and the other cluster lies
in [p-M,p], whose minimum is at least M+1. The map b->p-b is injective;
positive b prevents it from producing p. Hence the two clusters have
exactly |A|+1 and |B|+1 distinct labels and |T|=N.

First take r in `{0} union A` and put P=p-r. Then
`P>=p-M>=M+1`. Differences from other lower labels have nonzero absolute
magnitude in [1,M]. Differences from upper labels are positive and of the
form `P-b`, with b in `{0} union B`, a subset of [0,M]. Since N-2-M>0,
(8) gives `P*(N-2-M)>=M*(N-1)`. Apply (6) at p=P and a0=1; (3) gives
all these norms at the original 1/N. Norm invariance under negation handles
the negative lower differences. Repeated absolute magnitudes never alter N.

For upper r, reflect all speeds by s->p-s. This sends T(A,B) bijectively
onto T(B,A), with the same N,M,p and all hypotheses unchanged. The reflected
chosen speed is in `{0} union B`. Apply the lower-runner argument, which
was proved for arbitrary ordered pairs of sets, to (B,A). The identity
`(p-s)-(p-r)=-(s-r)` proves (9) for the original labels. If A!=B, the
reflected set need not equal T; the proof deliberately uses the swapped
configuration. Thus no unjustified symmetry of unequal clusters is assumed.

An explicit per-runner rule is to set u=r for a lower runner and u=p-r
for an upper runner, put P=p-u, and use (6). All natural subtractions
are justified by 0<=u<=M<p and 0<=s,r<=p. Signed relative differences in
(9) are integer/real differences, not truncated natural subtraction.

The theorem also has an exact, potentially weaker sufficient test: for each
u in `{0} union A union B`, check (5) at P=p-u. The cell exists at each
such P exactly when that test holds. Passing all these tests supplies the
corresponding per-runner times, but failing a test does not disprove (9).

Both unequal membership and unequal cluster cardinalities are allowed.
For example M=2,A={1},B={1,2},p=10 gives N=5 and equality in (8).
More generally every total count N>=4 occurs in this class: take
M=N-3, A={1,...,M}, B={1}, and any p>=N*(N-3). These choices satisfy
(8) and p>=2M+1. This is a specified family for each count, not every
configuration of that count, nor one simultaneous time for all runners.

## Paired corollary and failure of the cell as a necessary LRC test

Take A=B=S, |S|=m>=1 and S subset `{1,...,M}`. Then N=2m+2 and
the all-runner theorem applies whenever

```text
p>=2M+1,   M<2m,   (p-M)*(2m-M)>=M*(2m+1).                    (10)
```

In particular the originally proposed, stronger lower bound with
`(2m+2)*M` on the right is valid. Arbitrary holes are permitted so long
as M<2m; m is the actual number of low speeds, not their maximum.
For a designated zero runner one may instead use a0=min(S) and the more
general criterion (1), including its zero-width condition M=2m*a0.

For S={1,5}, m=2, M=5, p=11, the first-band cell has
L=1/6>U=2/15. Nonetheless the original six-runner configuration
`{0,1,5,6,10,11}` has a designated-zero witness t=1/4: its five nonzero
norms are respectively `1/4,1/4,1/2,1/2,1/4`, all at least 1/6.
This example concerns the zero-runner witness only. It refutes necessity
of this particular cell for that witness, not the all-runner theorem or LRC.

## Relation to existing formal contracts and the remaining gap

The inspected `threeHeight_family_witness` assumes original height at most
N+t and `3*t<=N`, not height at most 3N. For fixed N its allowed height is
at most `N+floor(N/3)`. Here p is unbounded even with N,M,A,B fixed, and
the stationary-zero tuple includes p. For example N=7,M=4,
A={1,2,4},B={1,3},p=28 satisfies (8), while p exceeds the height cap 9.
The other inspected bounded-height interfaces likewise have explicit upper
height hypotheses; they do not directly supply this full contract.

The existing mirrored theorem requires complete matching blocks. Replacing
its block length by M would generally give only 1/(2M+2), not the required
1/N for these smaller configurations. Its original complete-block family
already has a stronger all-p guarantee than the coarse bound (8); this new
bound broadens the permitted shapes rather than improving every old case.

`minimumScaleResidueBands` and `circleNorm_ge_of_int_band` are reusable
formal ingredients. Their band premises still need the new interval/witness
calculation; selecting a base after constructing (6) is a use of those
ingredients, not an existing unconditional theorem supplying (8).
`fastRunnerInsertion` requires a supplied old witness and a factor separation
between the newly inserted speed and every old speed. The comparable high
speeds here do not automatically meet that separation for successive
insertions. No inspected existing contract trivially subsumes (8). This is
a scoped source comparison, not a claim about every theorem or the literature.

The useful extension is explicit control of every required coordinate for
dense clusters with holes and even for unmatched clusters at the original
count. The unsupplied ingredient toward arbitrary configurations is a
replacement for the positive-width first-band cell when M>=N-2 (or its
proper minimum-scale analogue), and control of families that do not have
two such clusters. No reduction of arbitrary configurations or least
counterexamples to (8) is proved. Neither auxiliary endpoint availability
nor unrestricted LRC is settled by this manuscript.

## Fixed rational controls

The program below checks the exact interval against direct fixed-k feasible
time intervals, plus original signed relative norms for a fixed list of
configurations. All arithmetic is rational. There is no tuple discovery,
floating-point optimization, Lean build, or dependency restoration.

```python
from fractions import Fraction as F
from math import ceil, floor
from collections import Counter
from hashlib import sha256
from pathlib import Path
import json

assert sha256(Path('LonelyRunner/MirroredBlockWitness.lean').read_bytes()).hexdigest() == \
    '70d94cf55b457f49dcfa8c22bf8a3404abb4db1aec5e43254749ea73711da9c1'
assert sha256(Path('LonelyRunner/MirroredBlockFamily.lean').read_bytes()).hexdigest() == \
    '670b27d5e0083cf84999ad81410c9def4437f6d23fca7390374ffd2926169272'

def norm(x):
    return min(x % 1, (-x) % 1)

def cell(N,a0,M,p):
    assert N>=4 and 1<=a0<=M<p
    delta=F(1,N)
    L,U=delta/a0,(1-2*delta)/M
    lo,hi=p*L-(1-delta),p*U-(1-delta)
    k=ceil(lo)
    if k>hi:
        return None
    t=max(L,(k+delta)/(p-M))
    y=p*t-k
    assert t>0 and L<=t<=U and M*t+delta<=y<=1-delta
    assert floor(p*t)==k
    return t,k,y

c=Counter()
# Explicit parameter controls only; direct-k domain -2,...,30 for each.
cells=[(4,1,1,3),(6,1,3,7),(6,1,3,12),(6,1,3,18),
       (8,1,4,10),(6,1,4,11),(6,1,4,9),(6,2,8,22),
       (6,2,8,21),(6,2,5,20),(6,1,5,11),(5,1,2,10),
       (5,1,2,8)]
for N,a0,M,p in cells:
    delta=F(1,N)
    L,U=delta/a0,(1-2*delta)/M
    lo,hi=p*L-(1-delta),p*U-(1-delta)
    direct=[]
    for k in range(-2,31):
        feasible=max(L,(k+delta)/(p-M))<=min(U,(k+1-delta)/p)
        assert feasible==(lo<=k<=hi)
        if feasible:
            direct.append(k)
        c['fixed_k_comparisons']+=1
    # Every feasible integer is in this direct domain by the proven bounds.
    assert lo>-2 and hi<30
    result=cell(N,a0,M,p)
    assert bool(direct)==(result is not None)
    if a0==1:
        exact=p*(N-2-M)>=M*(N-1-p%N)
        assert exact==(result is not None)
        if result:
            assert result[1]==p//N
        c['residue_equivalences']+=1
    if result:
        t,k,y=result
        assert all(norm(a*t)>=delta for a in range(a0,M+1))
        assert all(norm((p-b)*t)>=delta for b in range(M+1))
        c['cell_present']+=1
    else:
        c['cell_absent']+=1
    c['cell_fixtures']+=1

# Exact upper endpoint, interval length one, and zero-width congruences.
assert cell(8,1,4,10)==(F(3,16),1,F(7,8))
assert 18*(F(2,9)-F(1,6))==1 and cell(6,1,3,18)
assert 20*(F(2,15)-F(1,12))==1 and cell(6,2,5,20)
assert cell(6,2,8,22)==(F(1,12),1,F(5,6))
assert cell(6,2,8,21) is None
assert cell(6,1,4,11)==(F(1,6),1,F(5,6))
assert cell(6,1,4,9) is None
assert cell(6,1,5,11) is None
assert [norm(F(a,4)) for a in [1,5,6,10,11]]== \
    [F(1,4),F(1,4),F(1,2),F(1,2),F(1,4)]

# Fixed all-runner cases include holes, unequal cardinalities, and large p.
families=[(1,(1,),(1,),4),
          (2,(1,),(1,2),10),(2,(1,2),(2,),10),
          (3,(1,3),(1,3),18),
          (4,(1,2,4),(1,3),28),(4,(1,2,4),(2,4),28),
          (4,(1,2,4),(1,2,4),18),
          (3,(2,3),(1,2,3),12),
          (5,(1,4,5),(2,4,5),40),
          (6,(1,2,3,4,5,6),(2,),54),
          (5,(1,3,5),(1,3,5),40),
          (4,(1,2,4),(1,3),7*10**12),
          (4,(1,2,4),(1,3),7*10**12+6)]
for M,aa,bb,p in families:
    A,B=set(aa),set(bb)
    N=len(A)+len(B)+2
    delta=F(1,N)
    assert A and B and all(1<=a<=M for a in A|B)
    assert N>=4 and M<N-2 and p>=2*M+1
    assert (p-M)*(N-2-M)>=M*(N-1)
    lower={0}|A
    T=lower|{p-b for b in B}|{p}
    swapped={0}|B|{p-a for a in A}|{p}
    assert len(T)==N and {p-s for s in T}==swapped
    for r in sorted(T):
        u=r if r in lower else p-r
        P=p-u
        assert P>=p-M>M
        result=cell(N,1,M,P)
        assert result is not None
        t,k,y=result
        assert k==P//N
        for s in T-{r}:
            assert norm(t*(s-r))>=delta
            assert norm(t*((p-s)-(p-r)))==norm(t*(s-r))
            c['signed_relative_checks']+=1
            c['negative_relative_checks']+=s<r
            c['closed_relative_equalities']+=norm(t*(s-r))==delta
        c['chosen_runners']+=1
        c['repeated_magnitude_runners']+=len({abs(s-r) for s in T-{r}})<N-1
    c['all_runner_fixtures']+=1
    c['odd_count_fixtures']+=N%2
    c['uniform_bound_equalities']+=(p-M)*(N-2-M)==M*(N-1)
    c['unequal_cluster_fixtures']+=A!=B
assert c['cell_fixtures']==13 and c['fixed_k_comparisons']==429
assert c['all_runner_fixtures']==13
assert c['negative_relative_checks']*2==c['signed_relative_checks']
assert all(c[k]>0 for k in ['cell_present','cell_absent','odd_count_fixtures',
                           'uniform_bound_equalities','unequal_cluster_fixtures',
                           'repeated_magnitude_runners','closed_relative_equalities'])
print(json.dumps(dict(c),sort_keys=True))
```

Reproduce at repository root:

```bash
python3 -B - <<'DENSE_CLUSTER_REPLAY'
from pathlib import Path
import re
p=Path('research/astra-dense-paired-blocks.md')
blocks=re.findall(r'^```python\n(.*?)^```[ \t]*$',p.read_text(),re.M|re.S)
assert len(blocks)==1
exec(compile(blocks[0],str(p),'exec'),{})
DENSE_CLUSTER_REPLAY
```

Observed replay: exit zero. Thirteen scalar fixtures gave 429 fixed-k
equivalence checks, eight cells present, five absent, and ten exact residue
equivalence checks. The interval-length-one, endpoint, zero-width congruence,
and empty-cell/original-witness controls passed. Thirteen full configurations
gave 88 chosen-runner witnesses and 532 signed relative comparisons,
including 266 negative differences, 104 attained closed equalities, and
25 chosen runners with repeated absolute magnitudes. Eight configurations
had odd count, nine had unequal clusters, and eleven attained equality in
the uniform sufficient bound. These are this author's controls, separate
from any root replay or later independent review.

Only this manuscript was written. All author commands completed; no
background process was started. No Lean build, dependency or cache mutation,
state write, or Git operation was performed. A separate independent semantic review is required
before accepting this candidate or beginning its formal translation. The
unrestricted canonical goal remains unresolved.
