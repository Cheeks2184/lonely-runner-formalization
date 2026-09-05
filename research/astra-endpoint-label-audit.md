# Endpoint-label candidate audit

Task `/root/endpoint_label_audit`, requested in-session Astra/xhigh, 2026-09-05.
Frozen source: `963544eab50cc8c7cdbb24e733ec7d1a30947d09`.
The worker read the current project configuration, workflow, policy, state,
Pass 19, and the dense manuscript and review. Workflow validation passed.
Only this repository evidence file is owned. No Lean or cache work, shared
state edit, Git mutation, or publication is part of this task.

**Disposition: a rigorous common-divisor scope at manuscript level, an exact
counterexample after dropping the largest-row hypothesis, and bounded
negative evidence for the actual candidate. No proof or counterexample to
the actual candidate was obtained.** The full canonical Lonely Runner
Conjecture is unresolved. Independent review of this note is still required.

## Exact candidate and tie quantifiers

For `N>=4`, take `N-2` distinct positive integer speeds `V`, a largest speed
`p>max(V)`, and put `A=V union {p}`. Assume the actual pivot row `R(N,p)` is
covered by `V`. For `t in G_(N-1)(V)`, let `[L,R]` be its full component in
`G_N(V)` and assume strict containment in one open `p`-bad interval.
Define the nonempty endpoint-owner sets

```text
E_L = {a in V : L=(floor(a*t)+1/N)/a},
E_R = {b in V : R=(floor(b*t)+1-1/N)/b}.
```

The strong version under audit is

```text
for every a in E_L and b in E_R,
  not PivotCovered(N,A,a) or not PivotCovered(N,A,b).          (C_all)
```

Equivalently, at least one whole endpoint-owner set has no covered owner.
The weaker version is

```text
there exist a in E_L and b in E_R such that
  not PivotCovered(N,A,a) or not PivotCovered(N,A,b),          (C_some)
```

equivalently, at least one endpoint has some noncovered owner. Both would
exclude the relevant hypothetical all-covered minimal-count counterexample.
All original labels and denominator `N` remain fixed in each coverage test.
The known component-width argument gives `E_L intersect E_R = empty` here.

For clarity the literal predicates are

```text
G_k(V) = {t : ||v*t|| >= 1/k for every v in V},
R(N,a) = {r in Z : 0 <= r < N*a and N does not divide r},
PivotCovered(N,A,a) iff for every r in R(N,a) there is b in A\{a}
  with min(b*r mod(N*a), -b*r mod(N*a)) < a.
```

The largest-row hypothesis is `PivotCovered(N,A,p)`. Merely knowing that
`p` is the largest speed, or that it alone spoils each endpoint, does not
give this hypothesis. The bad inequality remains strict throughout.

## Proven scope: the old-period orbit preserves pivot labels

The worker and orchestrator independently derived the following reduction.
Its mesh estimate is already kernel-checked in
`LonelyRunner/DivisorInsertion.lean`, as
`exists_int_grid_circleNorm_ge` and
`exists_int_coprime_grid_circleNorm_ge`. The additional preservation of the
original old pivot row is proved here at manuscript level; no new Lean
declaration was implemented or compiled for this audit.

**Proposition.** Let `V` be any finite nonempty set of positive integer
speeds, `D=gcd(V)`, `p>0`, `g=gcd(D,p)`, and `m=D/g`. Fix `N>=2` satisfying

```text
2*m <= N*(m-1).                                             (M)
```

For every `a in V` and every `r in R(N,a)` whose time `r/(N*a)` is good for
all old speeds at threshold `1/N`, there exists another candidate in the
**same actual a-row** good for every speed in `V union {p}` at `1/N`.
In particular every endpoint owner of every old-good component is noncovered
in the full tuple whenever it has such a boundary candidate. The original
runner count, order of speeds, stronger seed, and largest-row coverage are
not premises of this proposition.

**Proof.** Put `t=r/(N*a)` and consider `t_j=t+j/D`, for integer `j`.
For every old speed `v`, the change `v*j/D` is an integer, so all old norms
are fixed. The new phase is

```text
p*t_j = p*t + j*(p/g)/m,        gcd(p/g,m)=1.
```

Thus these phases modulo one run through a translated `m`-point equally
spaced grid. Some phase is within `1/(2*m)` of `1/2` modulo one, and its
norm is at least `(m-1)/(2*m) >= 1/N`, where the last inequality is (M).
This is exactly the cited existing mesh bound.

For that integer `j`, the same old pivot has signed numerator

```text
u = N*a*t_j = r + N*(a/D)*j.
```

It is an integer and is not divisible by `N`. Reduce it to
`r'=u mod(N*a)`. Since `N*a` is a multiple of `N`, `r'` is still not
divisible by `N` and satisfies `0<=r'<N*a`. Every original integer-speed
phase changes by an integer under this reduction, so `r'` protects every
label of the full original tuple. This proves noncoverage on the original
`a`-row, without relabelling an auxiliary speed or changing denominator.
QED.

An endpoint owner's signed numerator is `N*floor(a*t)+1` on the left or
`N*(floor(a*t)+1)-1` on the right. It therefore gives the old-safe candidate
required by the proposition after normalization, including negative times.
The result holds for **every tied endpoint owner**, and for both endpoints.
More generally, under (M) the covered labels among old speeds are unchanged
when `p` is added: adding a spoiling label preserves coverage in one
direction, while the proposition preserves every old noncoverage certificate
in the other direction.

For the audited candidate, `N>=4` and `m>=2` imply (M), including the equality
case `N=4,m=2`. The equality is a closed-boundary statement: it cannot be
silently strengthened to strict goodness.

Common positive scaling preserves this entire candidate. For pivot `h*a`,
the scaled phase at residue `r` is `r*(h*v)/(N*h*a)=r*v/(N*a)`; reducing `r`
modulo `N*a` preserves its nonzero class modulo `N`, so each scaled row has
the same cover status. Times and good components scale by `1/h`, and
stronger seeds and endpoint labels correspond. Divide all speeds by
`gcd(V union {p})`. In this primitive normalization `gcd(D,p)=1`, so the
proposition handles every `D>1`. The actual unresolved candidate can
therefore be restricted to **`gcd(V)=1`**. This reduction is not a proof in
that remaining case.

## Exact near-control: largest-row coverage cannot simply be omitted

Take the correctly counted original tuple

```text
N=7,   V=(2,5,7,12,17),   p=19,   t=31/85.
```

The old norms at this seed are
`(23/85,3/17,38/85,32/85,1/5)`, all greater than `1/6`. Its full weak-good
component and the containing open new-speed bad interval are

```text
[L,R] = [43/119,13/35] strictly inside (48/133,50/133).
```

The unique left and right endpoint owners are respectively `17` and `5`.
Both are covered in the **original** six-speed tuple at denominator 7;
indeed its entire covered-label set is `{5,17}`. Thus this example refutes
both `C_all` and `C_some` after only the largest-row hypothesis is dropped.
It is not a counterexample to either fully stated candidate.

Specifically, the actual largest row has exactly the safe residues
`[13,41,92,120]` modulo `133`. Thus it is noncovered. For example `13/133`
is an ordinary full witness, with original-speed norms
`(26,65,42,23,45,19)/133`; the last speed attains the closed `1/7` boundary.
The positive exact certificate is preserved below; no general negative claim
is drawn from the auxiliary discovery enumeration that found it.

## Finite search results and stopping point

The first search used `6 11 70 120` and completed in 13.636652 seconds:
all 381 feasible pairs with `6<=N<=11`, `p<=70`, and `p-1>=N-2` were
exhausted. It found ten covers, five primitive tuples, and 24 trapped seeded
components. None violated either candidate, and none had tied owners.

The second search used `6 10 180 150` and stopped at 150.096109 seconds,
inside `(N,p)=(10,119)`. It completed all feasible pairs with
`6<=N<=10,p<=118`, plus `N=6,7,8,9,p=119`: **564 completed instances**.
It found 24 covers including common scalings, ten primitive tuples, and
60 trapped seeded components, with no violation and no tied owner.
The unfinished `(10,119)` and the rest of the invocation up to `p=180`
are excluded from every exhaustion claim. Its 7,548,928 visited branch
nodes include the unfinished instance. The runs overlap; their counts
must not be added. No further search was launched after this bounded pass.

The ten primitive positive cover certificates from the second run are:

| N | V | p | gcd(V) | covered original speeds | trapped seeded components |
| --- | --- | --- | --- | --- | --- |
| 7 | 1,4,5,6,7 | 11 | 1 | 1,4,5,11 | 4 |
| 6 | 6,18,24,30 | 37 | 6 | 37 | 4 |
| 10 | 5,10,15,25,30,35,40,45 | 46 | 5 | 46 | 4 |
| 8 | 8,16,24,32,40,56 | 57 | 8 | 57 | 4 |
| 7 | 7,21,28,35,49 | 58 | 7 | 7,21,58 | 8 |
| 8 | 8,32,40,48,56,88 | 89 | 8 | 89 | 4 |
| 8 | 8,16,40,48,56,64 | 89 | 8 | 8,89 | 12 |
| 8 | 8,32,40,48,56,88 | 99 | 8 | 99 | 4 |
| 10 | 10,20,30,50,60,70,80,90 | 103 | 10 | 103 | 8 |
| 8 | 16,48,56,64,80,104 | 113 | 8 | 113 | 8 |

Every newly found primitive tuple has old gcd greater than one and is
therefore handled by the proved orbit scope. The sole old-gcd-one tuple is
the previously known example. This sharply limits the mathematical value of
the finite misses: they provide no new global evidence in the hard case.

The all-cover enumerator, including its handling of covers of size less than
the prescribed budget, was compared with literal full-residue enumeration
of every size-`k` lower subset for `3<=N<=10`, `2<=p<=15`, and
`1<=k<=min(5,p-1)`. All **480** complete cover-set comparisons passed,
including equality of the entire sets of answers and absence of duplicates.
These are computational controls, not a kernel proof of the search engine.

The remaining mathematical task is precisely to prove `C_all` or the
weaker `C_some`, or give an exact counterexample, for the fixed hypotheses
above with primitive old tuple `gcd(V)=1`. A proof must relate entire original
pivot rows; the endpoint's one private candidate does not establish row
noncoverage, and the near-control rules out dropping the largest-row
hypothesis. The common-divisor proposition and the bounded misses do not
settle that remaining statement or the unrestricted LRC.

## Bounded discovery and exact checking program

The following standard-library program searches largest-row covers by exact
bitsets and rare-uncovered-point branching. It preserves closed phase-band
intersections, singleton stronger witnesses, every endpoint tie, and the
full original tuple in all pivot checks. A timeout records an incomplete
instance, never an exhausted domain. Scaled tuples are skipped only after
their coverage is established, since common scaling preserves all predicates.
The command-line limits bound `N`, `p`, and elapsed search time explicitly.

```python
from fractions import Fraction as F
from itertools import combinations
from math import floor, gcd
from time import monotonic
import json, sys

def distance(M,x):
    return min(x%M,(-x)%M)

def safe_residues(N,A,p):
    return [r for r in range(N*p) if r%N and
            all(distance(N*p,r*a)>=p for a in A if a!=p)]

def covered_labels(N,A):
    return tuple(a for a in A if not safe_residues(N,A,a))

def components(V,N):
    out=[(F(0),F(1))]
    for a in V:
        bands=[(F(N*j+1,N*a),F(N*(j+1)-1,N*a)) for j in range(a)]
        new=[]; i=j=0
        while i<len(out) and j<len(bands):
            L=max(out[i][0],bands[j][0]); R=min(out[i][1],bands[j][1])
            if L<=R:new.append((L,R))
            if out[i][1]<bands[j][1]:i+=1
            else:j+=1
        out=new
    return out

def audit(N,V,p):
    A=tuple(sorted(V))+(p,)
    assert len(A)==N-1 and len(set(A))==N-1 and p>max(V)>0
    C=set(covered_labels(N,A))
    assert p in C
    strong=components(V,N-1)
    weak=components(V,N)
    trapped=[]
    for L,R in weak:
        seeds=[(max(L,x),min(R,y)) for x,y in strong if max(L,x)<=min(R,y)]
        if not seeds:continue
        m=floor(p*(L+R)/2+F(1,2))
        if not F(N*m-1,N*p)<L<=R<F(N*m+1,N*p):continue
        t=sum(seeds[0])/2
        left=tuple(a for a in V if (F(floor(a*t))+F(1,N))/a==L)
        right=tuple(a for a in V if (F(floor(a*t))+1-F(1,N))/a==R)
        assert left and right and not set(left)&set(right)
        fail_all=bool(set(left)&C) and bool(set(right)&C)
        fail_some=set(left+right)<=C
        trapped.append(dict(L=str(L),R=str(R),t=str(t),m=m,left=left,right=right,
                            fail_all=fail_all,fail_some=fail_some))
    return dict(N=N,V=sorted(V),p=p,covered=sorted(C),strong=len(strong),
                weak=len(weak),trapped=trapped)

def cover_sets(N,p,k,deadline,stats):
    # Reflection preserves both the candidate predicate and each bad set.
    R=[r for r in range(1,N*p//2+1) if r%N]
    B=[sum(1<<i for i,r in enumerate(R) if distance(N*p,r*a)<p)
       for a in range(1,p)]
    rows=[sum(1<<a for a,b in enumerate(B) if b>>i&1) for i in range(len(R))]
    def dfs(uncovered,allowed,k,chosen):
        stats['nodes']+=1
        if stats['nodes']%4096==0 and monotonic()>deadline:raise TimeoutError
        if not uncovered:
            pool=[i+1 for i in range(p-1) if allowed>>i&1]
            for tail in combinations(pool,k):yield tuple(sorted(chosen+tail))
            return
        if k<=0 or allowed.bit_count()<k:return
        gains=[]; rest=allowed; union=0
        while rest:
            bit=rest&-rest;rest-=bit;i=bit.bit_length()-1
            gain=B[i]&uncovered
            if gain:gains.append((gain.bit_count(),i));union|=gain
        if union!=uncovered:return
        gains.sort(reverse=True)
        if sum(n for n,i in gains[:k])<uncovered.bit_count():return
        if k==1:
            for n,i in gains:
                if n==uncovered.bit_count():yield tuple(sorted(chosen+(i+1,)))
            return
        rest=uncovered;branch=None;best=p
        while rest:
            bit=rest&-rest;rest-=bit;i=bit.bit_length()-1
            options=rows[i]&allowed;n=options.bit_count()
            if n<best:best=n;branch=options
            if best<=1:break
        for n,i in gains:
            if not branch>>i&1:continue
            allowed&=~(1<<i)
            yield from dfs(uncovered&~B[i],allowed,k-1,chosen+(i+1,))
    yield from dfs((1<<len(R))-1,(1<<(p-1))-1,k,())

def search(lo,hi,pmax,seconds):
    start=monotonic();deadline=start+seconds
    stats=dict(nodes=0,instances=0,covers=0,primitive=0,trapped=0,tied=0)
    for p in range(2,pmax+1):
      for N in range(lo,hi+1):
        if p-1<N-2:continue
        try:
          seen=set()
          for V in cover_sets(N,p,N-2,deadline,stats):
            assert V not in seen;seen.add(V);stats['covers']+=1
            if gcd(*V,p)>1:continue
            result=audit(N,V,p);stats['primitive']+=1
            stats['trapped']+=len(result['trapped'])
            stats['tied']+=sum(len(x['left'])+len(x['right'])>2 for x in result['trapped'])
            print(json.dumps(dict(status='cover_audit',**result)),flush=True)
            if any(x['fail_all'] for x in result['trapped']):
                print(json.dumps(dict(status='counterexample',stats=stats,seconds=monotonic()-start)),flush=True)
                return
            if monotonic()>deadline:raise TimeoutError
        except TimeoutError:
            print(json.dumps(dict(status='timeout',incomplete=[N,p],stats=stats,seconds=monotonic()-start)),flush=True)
            return
        stats['instances']+=1
      if p%10==0:
        print(json.dumps(dict(status='progress',p_completed=p,stats=stats,seconds=monotonic()-start)),flush=True)
    print(json.dumps(dict(status='exhausted',domain=[lo,hi,pmax],stats=stats,seconds=monotonic()-start)),flush=True)

if __name__=='__main__':
    search(*map(int,sys.argv[1:]))
```

Save that block with a trailing newline as `/tmp/lrc_endpoint_audit.py`.
Its executed SHA-256 was
`a229711e8e32b4eb197473e8e2711f2893eef229a87f1aeb0ca7dc2821cc58b2`.
The exact discovery commands were:

```bash
python3 /tmp/lrc_endpoint_audit.py 6 11 70 120
python3 /tmp/lrc_endpoint_audit.py 6 10 180 150 > /tmp/lrc_endpoint_search2.jsonl
```

The output records the completed prefix and the unfinished instance;
timeout positions and elapsed times depend on the machine. The preserved
positive certificates below do not depend on reproducing a timeout.

## Exact controls and solver oracle

The following block checks the full cover-set output against brute force,
all ten positive certificates, the label-preserving divisor shift, its closed
equality case, and the near-control. The near-control's coverage computation
uses rational norms directly, separately from the searcher's integer masks.

```python
from importlib.util import spec_from_file_location, module_from_spec
from itertools import combinations
from fractions import Fraction as F
from math import floor, gcd
from time import monotonic

s=spec_from_file_location('endpoint','/tmp/lrc_endpoint_audit.py')
e=module_from_spec(s);s.loader.exec_module(e)

comparisons=0
for N in range(3,11):
    for p in range(2,16):
        for k in range(1,min(p,6)):
            actual=list(e.cover_sets(N,p,k,monotonic()+60,{'nodes':0}))
            literal=[V for V in combinations(range(1,p),k)
                     if not e.safe_residues(N,V+(p,),p)]
            assert len(actual)==len(set(actual))
            assert set(actual)==set(literal)
            comparisons+=1
assert comparisons==480

fixtures=[
 (7,(1,4,5,6,7),11,(1,4,5,11),4),
 (6,(6,18,24,30),37,(37,),4),
 (10,(5,10,15,25,30,35,40,45),46,(46,),4),
 (8,(8,16,24,32,40,56),57,(57,),4),
 (7,(7,21,28,35,49),58,(7,21,58),8),
 (8,(8,32,40,48,56,88),89,(89,),4),
 (8,(8,16,40,48,56,64),89,(8,89),12),
 (8,(8,32,40,48,56,88),99,(99,),4),
 (10,(10,20,30,50,60,70,80,90),103,(103,),8),
 (8,(16,48,56,64,80,104),113,(113,),8),
]
traps=0; shifted=0
for N,V,p,C,count in fixtures:
    answer=e.audit(N,V,p)
    assert tuple(answer['covered'])==C and len(answer['trapped'])==count
    assert not any(z['fail_all'] or z['fail_some'] for z in answer['trapped'])
    assert all(len(z['left'])==len(z['right'])==1 for z in answer['trapped'])
    traps+=count
assert traps==60

# Test every old-safe candidate in the nine nontrivial-orbit certificates,
# plus a nonprimitive scaled copy and the sharp N=4,m=2 boundary control.
orbit_cases=[(N,V,p) for N,V,p,C,c in fixtures if gcd(*V)>1]
orbit_cases += [(6,(12,36,48,60),74),(4,(2,6),1)]
for N,V,p in orbit_cases:
    D=gcd(*V);g=gcd(D,p);m=D//g
    assert m>=2 and 2*m<=N*(m-1)
    for a in V:
        oldsafe=e.safe_residues(N,V,a)
        for r in oldsafe:
            j=next(j for j in range(m)
                   if e.distance(N*a,p*(r+N*(a//D)*j))>=a)
            for signed in (r,r-N*a):
                u=signed+N*(a//D)*j;rp=u%(N*a)
                assert rp%N and rp%N==r%N
                assert all(e.distance(N*a,rp*v)>=a for v in V+(p,))
            shifted+=1
        assert bool(oldsafe)==bool(e.safe_residues(N,V+(p,),a))
assert [min((F(1,4)+F(j,2))%1,(-F(1,4)-F(j,2))%1)
        for j in range(2)]==[F(1,4),F(1,4)]

def norm(x):
    return min(x%1,(-x)%1)
def good(V,N,t):
    return all(norm(v*t)>=F(1,N) for v in V)
def rational_safe(N,A,a):
    return [r for r in range(N*a) if r%N and
            good(A,N,F(r,N*a))]

N,V,p=7,(2,5,7,12,17),19;A=V+(p,);t=F(31,85)
assert len(set(A))==len(A)==N-1 and p>max(V) and gcd(*V)==1
assert [norm(a*t) for a in V]==[F(23,85),F(3,17),F(38,85),F(32,85),F(1,5)]
assert good(V,N-1,t)
left={a:(F(floor(a*t))+F(1,N))/a for a in V}
right={a:(F(floor(a*t))+1-F(1,N))/a for a in V}
L=max(left.values());R=min(right.values())
assert (L,R)==(F(43,119),F(13,35))
assert [a for a in V if left[a]==L]==[17]
assert [a for a in V if right[a]==R]==[5]
assert F(48,133)<L<t<R<F(50,133)
assert good(V,N,L) and good(V,N,R)
assert {a for a in A if not rational_safe(N,A,a)}=={5,17}
assert rational_safe(N,A,p)==[13,41,92,120]
assert [norm(F(13*a,133)) for a in A]==[F(x,133) for x in (26,65,42,23,45,19)]
print(dict(solver_comparisons=comparisons,positive_covers=len(fixtures),
           trapped_components=traps,shifted_old_candidates=shifted,
           closed_mesh_equality='passed',near_control='passed'))
```

The complete control block was executed successfully from this note. It
reported 480 solver comparisons, ten positive covers, 60 trapped components,
and **2,448 shifted old-safe candidates**; the closed mesh equality and
near-control passed. Final workflow structural validation also passed.
All owned search and control processes terminated before this note was frozen.

## Source bindings and review boundary

The exact source hashes inspected for the mathematical contracts were:

```text
6267ff6fb165ba01d5f982fd4931342c3e594d1ca1ca765d0aa41f0813598446  research/astra-dense-pivot-induction.md
151b0cdb8c701610e2c2e2e0508e11a9a630ae93f7c57e1d5010227b7187887b  research/astra-dense-pivot-review.md
362da5ab923f22e900ae7ac821dd4cf4aab91dfe70889987bc9e5a05d19c276a  LonelyRunner/PivotResidues.lean
49131a7f9690042d1b16cbc876417f9d9ce1b53cc6565f87b6d1b53c4e3340cd  LonelyRunner/Prompt99Scaling.lean
212fa6d879bab6d70f09a4a43b2027b96724b5e5ac4a22cdf4b368509973166f  LonelyRunner/DivisorInsertion.lean
```

The root reported Pass 19's verified merge to main
`e371af814f023bf2761e7b25de980b763347d049` while this audit was running, with
the frozen `963544eab50cc8c7cdbb24e733ec7d1a30947d09` tree preserved. This
worker did not perform publication. The common-divisor scope is based on a
written proof and existing source contracts; its extra endpoint wrapper is
not a new kernel-checked result. Search outputs and a passing workflow
validator do not establish unrestricted mathematical truth.
