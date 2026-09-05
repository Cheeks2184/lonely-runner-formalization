# Arbitrary fixed clusters at large separation, conditional on fewer runners

Requested Astra xhigh derivation, 2026-09-05. Source checkpoint:
`7a5d0d69520a1d290c1dd6c85902488283394d1e`.
Status: candidate manuscript requiring independent review. No new Lean
declaration or unrestricted LRC resolution is claimed. No literature-novelty
claim is made. Root supplied the free-phase formulation and requested an
audit of its lower-count supply; the collision construction below supplies
that missing compatibility, rather than assuming it.

Current project configuration, workflow, policy, and state were read, and
the workflow validator passed. Relevant source references read:

| File | SHA-256 |
| --- | --- |
| `LonelyRunner/BHKRealReduction.lean` | `98d7c878eef7e4a3b7f7c504c882cf35191c1343816a59d731193ac8a207ed26` |
| `LonelyRunner/Formulations.lean` | `0c3328e975bee236ff66862d3a5cadeb58fbc7c804fa953e53701ba466b9d788` |
| `LonelyRunner/IntegerInduction.lean` | `7b315fe9ea7f8639eb45e376365f1c3795c52e2f93e608db578390c1083a5753` |
| `LonelyRunner/StructuredClasses.lean` | `5328a7a88d2b42f86ffc3f0f0418ca22c761219e8fa3e5822bda5a18ac286e8c` |
| `LonelyRunner/FastRunnerInsertion.lean` | `dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5` |

## Exact conditional theorem

Let A,B be finite sets of integers, each containing 0, with

```text
N=|A|+|B| >= 3,          delta=1/N.
```

Offsets in either cluster may be negative. Assume the following genuinely
smaller-count hypothesis H_N: for every nonempty finite set D of distinct
positive integers with |D|<=N-2, there exists a real w such that

```text
||v*w|| >= 1/(|D|+1)    for every v in D.                     (H_N)
```

Thus H_N is the positive-integer stationary LRC for total runner counts
2 through N-1 only. Define the fixed cluster quantities

```text
K = max(diam(A),diam(B)),   R=max(max(A),max(B)),
C_N = N*(N-1)/2,
```

where diam(E)=max(E)-min(E). For every integer p satisfying

```text
p >= R+C_N*K,                                                (1)
```

the configuration T_p=A union {p-b:b in B} has exactly N distinct runners,
and for every chosen r in T_p there exists a real t>0 such that

```text
||t*(s-r)|| >= 1/N       for every s in T_p with s!=r.          (2)
```

The witnesses may depend on r and p. No density, consecutive-block,
coprimality, supplied original-cluster witness, or same-cardinality LRC
hypothesis is imposed. Bound (1) depends on the fixed internal widths;
it is not a height bound for arbitrary N-runner configurations. No sharpness
claim is made for the coefficient C_N.

## Transfer of a supplied simultaneous phase with an explicit margin

Fix r in A and put P=p-r>0. Suppose a real t0>0 and a real y0 satisfy,
for some epsilon>0,

```text
||(a-r)*t0|| >= delta+epsilon    (a in A, a!=r),
||y0-b*t0|| >= delta+epsilon     (b in B).                     (3)
```

Let K_r bound both every |a-r| and every |b| in those lines. Choose an
integer q nearest to P*t0-y0, and set

```text
t_p = (q+y0)/P,       |t_p-t0| <= 1/(2P).                     (4)
```

For a lower comparison the phase error is at most |a-r|/(2P). For an upper
comparison, the exact identity is

```text
(P-b)*t_p = q + (y0-b*t0) - b*(t_p-t0).                      (5)
```

Subtracting integer q and using the 1-Lipschitz property of circle distance
bounds its loss by |b|/(2P), not by the large speed |P-b|/(2P).
Consequently (2) for this r follows whenever

```text
P >= K_r/(2*epsilon),         P > 1/(2*t0).                  (6)
```

The second inequality makes t_p>0; the first permits equality because the
target distance is closed. Negative b, a-r, or y0 cause no change to these
identities or bounds. Nearest-integer ties may be resolved either way.
This proves the transfer lemma with the chosen witness's actual margin.
It remains to supply (3) without circularly assuming the N-runner theorem.

## Supply by colliding two comparison speeds

Suppose |A|>=2. Choose any a1 in A\{r} and put d=a1-r!=0. If d>0,
take b0=max(B); if d<0, take b0=min(B). Put c=b0+d. Then c lies strictly
outside B, on the selected side. Define two finite sets of signed speeds

```text
E1 = {a-r : a in A, a!=r},       E2 = {c-b : b in B},
E  = E1 union E2.
```

Neither E1 nor E2 contains zero: the first excludes r, and c is not in B.
Both contain d, since c-b0=d. Their individual cardinalities are |A|-1
and |B|, by injectivity of translation/reflection. Thus

```text
1 <= |E| <= (|A|-1)+|B|-1 = N-2.                             (7)
```

The colliding labels are both comparisons with the chosen runner. Nothing
collides with that chosen runner's zero phase. This distinction is essential.

Let D={|e|:e in E}. It is a nonempty set of distinct positive integers,
with |D|<=N-2; absolute values can only further reduce its cardinality.
Apply H_N to D and use sign invariance of the norm. It supplies w with
every E-coordinate norm at least

```text
1/(|D|+1) >= 1/(N-1) = delta + 1/(N*(N-1)).                  (8)
```

All speeds in E are integers. Replacing w by
`t0=w-floor(w)+1` preserves those norms and gives 1<=t0<2. Set y0=c*t0.
Then (8) gives both lines of (3) at the same time, with

```text
epsilon = 1/(N*(N-1)).                                      (9)
```

There is no assumption that two positive-measure sets of times intersect,
nor an appeal to LRC for E as a tuple of the original N-1 moving labels.
Its actual deduplicated positive set has at most N-2 moving speeds. The
auxiliary set and c depend only on fixed A,B,r, not on p. Its magnitudes
are also at most diam(A)+diam(B), though H_N needs no height hypothesis.

## Singleton and upper-cluster cases; verification of the uniform bound

If A={0}, the chosen runner in this cluster is r=0 and there are no lower
comparisons. Use t0=1 and y0=1/2. For every integer b in B,
`||1/2-b||=1/2>=1/(N-1)`. Thus (3) again holds with (9), since N>=3,
without invoking H_N for N-1 moving speeds. This is the separate singleton
argument; trying to apply H_N to all |B|=N-1 translated speeds would be
out of range.

Because 0 belongs to each cluster, every absolute element of A or B is at
most its diameter. Hence K_r<=K. Also R>=0, R<=K, and K>=1: with N>=3
at least one integer cluster has two distinct elements. We have C_N>=3.
Under (1), for every r in A,

```text
P=p-r >= p-R >= C_N*K >= 3.
```

Equations (9) and this bound imply both inequalities in (6), since
t0>=1 and K_r/(2*epsilon)<=C_N*K. The lower-cluster witnesses are proved.

The bound also establishes actual disjointness, rather than assuming it:

```text
p-max(A)-max(B) >= C_N*K-R >= (C_N-1)*K > 0.
```

Thus min(p-B)=p-max(B)>max(A), and the original count is exactly N.

For an upper chosen runner r=p-b with b in B, reflect every speed by
x->p-x. This is a bijection from T_p(A,B) to T_p(B,A), with unchanged
N,K,R and bound (1). Apply the lower-cluster proof to the swapped sets and
chosen b. The identity
`(p-s)-(p-r)=-(s-r)` transfers every norm back to the original labels.
Equal clusters are not required. This proves all of (2).

If N=2, the hypotheses 0 in A,B force A=B={0}. For every positive integer
p, the two-runner configuration {0,p} has time 1/(2p), giving both chosen
runners exact distance 1/2. This case is separate: a margin strictly above
1/2 cannot be supplied by any phase construction.

## Why ordinary separate witness supply was insufficient

For fixed t, the opposite cluster forbids |B| arcs in the y-circle, each
of length 2/N. When 2|B|<N, their total length is less than one and there
is room with a positive margin. At equality a closed good point exists,
but strict slack need not: B={0,1} at t=1/2 gives two equally spaced points,
whose best possible distance from a free y is 1/4. This is the balanced
N=4 target with no strict margin at that particular t.

A lower-cluster LRC witness alone can also fail the majority-cluster test.
Take A={0,4}, B={0,1,...,7}, N=10, r=0, t=1/8. Its sole lower distance is
1/2, a valid two-runner LRC witness. The B-phases form the eight-point grid;
every y is within 1/16 of one of them, strictly below 1/10. This is an exact
obstruction to reusing that supplied time, not to simultaneous existence.
The collision method instead takes d=4,b0=7,c=11 and E={4,...,11}; the
explicit choice t0=16/15 gives all those norms at least 4/15. It illustrates
how the joint witness avoids the failed original time. The universal supply
in the theorem is H_N applied to (7), not this finite example.

## Scope toward the unrestricted problem

The positive-integer hypothesis H_N is explicit and strictly lower-count.
It is suitable for a strong-induction branch. This manuscript does not use
the all-dimensional real-to-integer equivalence as an index-preserving
theorem. The inspected `bhk_adjacentRatioCombination` already constructs a
nowhere-zero vector with two equal absolute values from adjacent ratios;
`exists_bhk_relationCompatible_collision` additionally preserves the required
integer relations. `exists_stationaryWitness_of_rational_collision` then
uses deduplication, a smaller cardinality, strict margin, and orbit closure.
Thus collision plus lower-count slack is an existing project mechanism, not
a new general principle claimed here.

Those public interfaces do not directly supply this theorem for a fixed
integer p. In particular, the constructed E-vector is not asserted to preserve
all integer relations of the actual speed vector at that p. The latter has
only rational speed ratios. Here the free phase and explicit approximation
(4)-(5), with a height condition, replace that unavailable compatibility.
The public all-dimensional rational premise is not substituted for H_N.

For a normalized sorted integer configuration
`0=x1<x2<...<xN=p`, a split after xj gives

```text
A={x1,...,xj},       B={p-xN,...,p-x(j+1)},
K=max(xj,p-x(j+1)),  R=K.
```

Under H_N this split is certified whenever `p>=(C_N+1)*K`. Therefore a
least-count integer counterexample must fail that inequality at every split.
This excludes configurations separated into two sufficiently narrow clusters,
with arbitrary internal holes. It does not show that an arbitrary tuple has
such a split, bound its integer height after normalization, or handle all
possible multiscale arrangements. Comparable internal widths can grow with
p, preventing (1). That global supply remains missing. Neither this branch
nor its finite controls complete the project's unrestricted goal.

## Fixed exact controls

The following controls use literal rational witnesses, not a search for a
counterexample or a proof of H_N. They verify the auxiliary cardinality and
uniform margin 1/(N-1), then the actual signed original phases at three
fixed separations per configuration. The literal times need not achieve the
strongest 1/(|D|+1) margin promised by H_N; the transfer consumes only the
displayed uniform margin. Fixed signed clusters, a majority opposite cluster,
singletons, and shapes outside the preceding dense-cluster contract occur.

```python
from fractions import Fraction as F
from math import floor
from collections import Counter
from hashlib import sha256
from pathlib import Path
import json

assert sha256(Path('LonelyRunner/BHKRealReduction.lean').read_bytes()).hexdigest() == \
    '98d7c878eef7e4a3b7f7c504c882cf35191c1343816a59d731193ac8a207ed26'
assert sha256(Path('LonelyRunner/FastRunnerInsertion.lean').read_bytes()).hexdigest() == \
    'dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5'

def norm(x):
    return min(x % 1, (-x) % 1)

def nearest(x):
    return floor(x+F(1,2))

def diameter(S):
    return max(S)-min(S)

def data(A,B,r,t0):
    N=len(A)+len(B)
    assert 0 in A and 0 in B and N>=3 and r in A
    if len(A)==1:
        assert r==0 and t0==1
        return F(1,2),None
    a1=min(A-{r},key=lambda a:(abs(a-r),a))
    d=a1-r
    b0=max(B) if d>0 else min(B)
    c=b0+d
    E1={a-r for a in A-{r}}
    E2={c-b for b in B}
    E=E1|E2
    D={abs(e) for e in E}
    assert c not in B and d in E1&E2 and 0 not in E
    assert len(E1)==len(A)-1 and len(E2)==len(B)
    assert 1<=len(D)<=len(E)<=N-2
    assert max(D)<=diameter(A)+diameter(B)
    assert all(norm(e*t0)>=F(1,N-1) for e in E)
    return c*t0,(c,D)

counts=Counter()
def check_lift(A,B,r,t0,p):
    N=len(A)+len(B)
    delta,epsilon=F(1,N),F(1,N*(N-1))
    eta,aux=data(A,B,r,t0)
    K=max(diameter(A),diameter(B))
    R=max(max(A),max(B))
    C=N*(N-1)//2
    assert K>=1 and 0<=R<=K and p>=R+C*K
    assert p-max(A)-max(B)>0
    T=A|{p-b for b in B}
    assert len(T)==N
    assert 1<=t0<2
    assert all(norm((a-r)*t0)>=delta+epsilon for a in A-{r})
    assert all(norm(eta-b*t0)>=delta+epsilon for b in B)
    P=p-r
    q=nearest(P*t0-eta)
    t=(q+eta)/P
    assert P>=C*K>=3 and t>0
    assert abs(t-t0)<=F(1,2*P)
    assert F(K,2*P)<=epsilon
    for a in A-{r}:
        assert norm((a-r)*t)>=delta
    for b in B:
        assert (P-b)*t==q+eta-b*t0-b*(t-t0)
        assert norm((P-b)*t)>=delta
    assert all(norm((s-r)*t)>=delta for s in T-{r})
    # All phases are unchanged if a different real lift of eta is chosen.
    shifted=eta+10**6
    assert (nearest(P*t0-shifted)+shifted)/P==t
    counts['lift_cases']+=1
    counts['original_signed_comparisons']+=N-1
    counts['singleton_lifts']+=aux is None
    counts['negative_c_lifts']+=aux is not None and aux[0]<0
    counts['nearest_ties']+=abs(q-(P*t0-eta))==F(1,2)
    counts['closed_original_equalities']+=sum(norm((s-r)*t)==delta for s in T-{r})
    return t

# (A,B, times for each lower A runner, times for each lower B runner).
fixtures=[
    ({0,1},{0,1},{0:F(4,3),1:F(4,3)},{0:F(4,3),1:F(4,3)}),
    ({0,1},{0,1,2,3},{0:F(6,5),1:F(6,5)},
     {0:F(6,5),1:F(6,5),2:F(6,5),3:F(6,5)}),
    ({0,1},{0,2,5},{0:F(11,8),1:F(5,4)},
     {0:F(5,4),2:F(6,5),5:F(8,7)}),
    ({-2,0,3},{-1,0,2},{-2:F(8,7),0:F(5,4),3:F(9,8)},
     {-1:F(6,5),0:F(6,5),2:F(6,5)}),
    ({0},{0,2,5},{0:F(1)},{0:F(4,3),2:F(6,5),5:F(9,8)}),
    ({0},{0,1},{0:F(1)},{0:F(3,2),1:F(3,2)}),
]
for A,B,ta,tb in fixtures:
    N=len(A)+len(B)
    K=max(diameter(A),diameter(B))
    R=max(max(A),max(B))
    bound=R+N*(N-1)//2*K
    assert set(ta)==A and set(tb)==B
    for p in [bound,bound+1,bound+10**6]:
        T=A|{p-b for b in B}
        chosen=set()
        for r,t0 in ta.items():
            t=check_lift(A,B,r,t0,p)
            chosen.add(r)
        for b,t0 in tb.items():
            t=check_lift(B,A,b,t0,p)
            r=p-b
            assert {p-s for s in T}==B|{p-a for a in A}
            assert all(norm((s-r)*t)>=F(1,N) for s in T-{r})
            chosen.add(r)
        assert chosen==T
        counts['full_configuration_separations']+=1
    counts['fixed_full_configurations']+=1

# Additional designated-runner controls, not an all-runner replay of these sets.
for A,B,t0 in [({0,4},set(range(8)),F(16,15)),
               ({0,1,5},{0,2,9},F(4,3))]:
    N=len(A)+len(B)
    bound=max(max(A),max(B))+N*(N-1)//2*max(diameter(A),diameter(B))
    for p in [bound,bound+1]:
        check_lift(A,B,0,t0,p)
    counts['additional_designated_fixtures']+=1

def max_free_distance(B,t):
    points=sorted({(b*t)%1 for b in B})
    gaps=[points[i+1]-points[i] for i in range(len(points)-1)]
    gaps.append(points[0]+1-points[-1])
    return max(gaps)/2

assert norm(4*F(1,8))==F(1,2)
assert max_free_distance(set(range(8)),F(1,8))==F(1,16)<F(1,10)
assert max_free_distance({0,1},F(1,2))==F(1,4)
# A non-extreme offset can collide with the chosen runner and is invalid.
assert 0 in {1-b for b in {0,1,2}}
for p in [1,2,17]:
    T={0,p}
    for r in T:
        assert all(norm(F(s-r,2*p))==F(1,2) for s in T-{r})
        counts['N2_chosen_runner_controls']+=1
assert counts['fixed_full_configurations']==6
assert counts['full_configuration_separations']==18
assert counts['lift_cases']==88 and counts['original_signed_comparisons']==358
assert counts['N2_chosen_runner_controls']==6
assert counts['singleton_lifts']>0 and counts['negative_c_lifts']>0
assert counts['nearest_ties']>0
print(json.dumps(dict(counts),sort_keys=True))
```

Reproduce from the repository root:

```bash
python3 -B - <<'CLUSTER_LIMIT_REPLAY'
from pathlib import Path
import re
p=Path('research/astra-cluster-limit-audit.md')
blocks=re.findall(r'^```python\n(.*?)^```[ \t]*$',p.read_text(),re.M|re.S)
assert len(blocks)==1
exec(compile(blocks[0],str(p),'exec'),{})
CLUSTER_LIMIT_REPLAY
```

Observed result: exit zero. Six fixed full configurations were checked at
three separations each, including the displayed sufficient bound. Together
with two additional designated-runner fixtures at two separations each,
there were 88 lifts and 358 original signed comparison slots. Six lifts
used the singleton case, 48 used negative c, and ten attained a nearest-grid
tie. The target norms in these N>=3 fixtures were all strictly above 1/N;
the theorem's allowance for equality follows from (6), not an assertion of
sharpness for these examples. Six N=2 chosen-runner checks attained exact
distance 1/2. The balanced and majority free-phase obstructions and the
invalid zero-coordinate collision control also passed.

Only this manuscript was written. All author commands completed; no
background process was started. No Lean build, dependency or cache mutation,
shared-state write, or Git operation was performed. The next step is a
separate independent semantic review of the exact conditional theorem and
its smaller-count use. The hypothesis H_N remains an explicit premise;
unrestricted LRC remains unresolved.
