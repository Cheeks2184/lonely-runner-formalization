# A conditional finite-height reduction by rational affine approximation

Requested Astra xhigh audit, 2026-09-05. Source checkpoint:
`7a5d0d69520a1d290c1dd6c85902488283394d1e`.
Root proposed the affine and simultaneous-approximation argument. This note
independently derives it, retaining the proposed bound without a correction.
Status: candidate manuscript requiring separate independent review and formal
translation. No bounded box is certified here, and unrestricted LRC is not
claimed. No literature-novelty claim is made.

Current configuration, workflow, policy, and state were read; workflow
structural validation passed. Relevant frozen source references read in full:

| File | SHA-256 |
| --- | --- |
| `LonelyRunner/BHKAdjacentRatios.lean` | `677c365618fc612a5ee7d3d9e9696273da2d9e775b77487d0b3e208cea9d6733` |
| `LonelyRunner/BHKAdjacentPair.lean` | `3d36d812db7ed18db8fce521b2505d5904a8387d8e315c6e7d08d9eb7dc75708` |
| `LonelyRunner/BHKBridgeCore.lean` | `43d0371d3fa213daa895d5431e9cfdd28d79d2de4ba89e02d9a9da93273678a3` |
| `LonelyRunner/BHKCollisionToWitness.lean` | `42e7665af7981ef336ab4e1826ff3f096e6d6855b50440f76e2ede7a538f7f87` |
| `LonelyRunner/BHKRealReduction.lean` | `98d7c878eef7e4a3b7f7c504c882cf35191c1343816a59d731193ac8a207ed26` |

## Exact result and its remaining premise

Fix an integer N>=3 and put Q=N*(N-1). Assume H_N: for every nonempty
finite set D of distinct positive integers with |D|<=N-2, some real tau
satisfies

```text
||tau*d|| >= 1/(|D|+1)             for all d in D.             (H_N)
```

This is LRC for total runner counts below N only, in the positive-integer
stationary formulation. The proposed finite-height conclusion is valid:

**Conditional theorem.** Every primitive integer configuration

```text
0=s0<s1<...<s_(N-1)=H,      gcd(s1,...,s_(N-1))=1,
H > [N*(N-1)]^(N-2)                                         (1)
```

has, for each chosen runner r, a positive real time t with

```text
||t*(s_i-s_r)|| >= 1/N          for every i!=r.               (2)
```

The times may depend on r. Thus under H_N any primitive N-runner integer
counterexample has height at most Q^(N-2), including that boundary. The
argument below does not prove that the configurations below this cutoff
are lonely, uniformly or even by exhaustive verification at a fixed N.

## Step 1: a rational affine approximation lemma

Let u=(u_i) be an integer vector and v=(v_i) a rational vector on N labels,
with u0=v0=0. Let p>1 be rational, and suppose the actual rational speeds

```text
s_i = p*u_i+v_i
```

are pairwise distinct. Suppose the two vectors u,v are linearly independent
over the rationals. Choose a positive integer q such that every q*v_i is
an integer. This common denominator need not be minimal.

For a fixed chosen r, assume

```text
max_i |v_i-v_r| <= 2*p/Q.                                   (3)
```

Then H_N supplies a positive time satisfying (2). In particular, this holds
for every chosen runner if max(v)-min(v)<=2*p/Q; the stronger condition
`|v_i|<=p/Q` for all i is enough.

Here is the construction and proof. For each i!=r write

```text
U_i=u_i-u_r, V_i=v_i-v_r, sigma_i=sign(s_i-s_r) in {1,-1},
R_i=sigma_i*(s_i-s_r)>0,       S_i=sigma_i*U_i.
```

The ratios S_i/R_i are not constant. Otherwise, for some rational lambda,

```text
(1-lambda*p)*U_i-lambda*V_i=0       for every i!=r.
```

The coefficient pair is nonzero. Including the zero relative vector at r
and using the original label (u0,v0)=(0,0) shows the same linear relation
holds for every original pair (u_i,v_i), contradicting rank two. Conversely,
if the original vectors have rank at most one, their points lie on a line
through the origin. Actual distinctness means the functional p*u+v does
not vanish on that line, so U is proportional to p*U+V and these ratios
are constant. Thus the rank/ratio issue is valid for every chosen runner,
not merely for r=0. Repeated u-coordinates are allowed.

Choose indices a,b with adjacent distinct values S_a/R_a<S_b/R_b. Define

```text
alpha=-(S_a+S_b),        beta=R_a+R_b>0,
w_i=alpha*R_i+beta*S_i.
```

The exact existing `exists_bhk_adjacentRatioCombination` gives that every
w_i is nonzero and w_a=-w_b. Independently, a zero w_i would make S_i/R_i
equal the weighted mean `(S_a+S_b)/(R_a+R_b)`, strictly between the adjacent
ratios; this is impossible. The opposite-value identity follows by expansion.
The collision is an absolute-value collision, which is all the count
reduction requires; the signed values need not coincide.

Choose a positive integer L clearing all denominators of the w_i and put
`D={|L*w_i|:i!=r}`. It is nonempty, contains only positive integers, and
has at most N-2 distinct elements. By H_N choose tau and set t0=L*tau.
Then

```text
||w_i*t0|| >= 1/(|D|+1) >= 1/(N-1).                         (4)
```

The multiplication by L in t0 is essential: `(L*w_i)*tau=w_i*(L*tau)`.
No same-count stationary theorem with N-1 moving speeds is invoked.

Set x=(alpha*p+beta)*t0 and y_raw=alpha*t0. The exact sign-sensitive identity
is

```text
w_i*t0 = sigma_i*(U_i*x+V_i*y_raw).
```

Normalize the second free phase by its actual lattice period:

```text
y = y_raw-q*floor(y_raw/q)+q,       q <= y < 2*q.              (5)
```

Since q*V_i is integral, replacing y_raw by y changes U_i*x+V_i*y_raw by
an integer. Sign and integer-period invariance therefore retain (4) for
every phase U_i*x+V_i*y. This normalization works even if alpha=0 or y_raw
is negative; x stays fixed. Using period one in (5) without integral v
would be incorrect.

Choose an integer j nearest to p*y-x and define

```text
t=(j+x)/p,        |t-y| <= 1/(2*p).                          (6)
```

Because y>=q>=1 and p>1, t>=1-1/(2*p)>0. For every comparison,

```text
(s_i-s_r)*t = U_i*j + (U_i*x+V_i*y) + V_i*(t-y).             (7)
```

Here U_i*j is an integer. The norm's 1-Lipschitz bound, (3), and (4) give

```text
||(s_i-s_r)*t|| >= 1/(N-1)-|V_i|/(2*p)
                 >= 1/(N-1)-1/Q = 1/N.
```

All endpoints and nearest-integer ties are permitted. This proves Step 1.
It uses the affine coefficients' integer/rational lattice, not a claim
that w preserves all integer relations of the actual rational speed tuple.
The relation-compatible BHK wrapper would need an extra premise unavailable
here; the adjacent-ratio algebra itself requires no such premise.

Rank one is a real exception to this supply. For example v=lambda*u gives
s=(p+lambda)*u, leaving the same-count integer problem after rescaling.
If rank one were simply dropped, one could even set u=0 and keep an arbitrary
unknown rational tuple in v, taking p as large as desired to satisfy (3).
The affine lemma is therefore not a same-count proof in disguise.

## Step 2: simultaneous approximation of a primitive integer tuple

Let the integer configuration satisfy (1), and let d=N-2 be its number of
internal indices. Consider the Q^d+1 points

```text
({k*s1/H},...,{k*s_(N-2)/H}),      0<=k<=Q^d,
```

in [0,1)^d. Partition that cube into Q^d half-open boxes of side 1/Q.
Two points, at indices k<ell, occupy the same box. Put q=ell-k, so
`1<=q<=Q^d`. For each internal index let

```text
u_i=floor(ell*s_i/H)-floor(k*s_i/H).
```

Then

```text
|q*s_i/H-u_i| < 1/Q.                                       (8)
```

The strict inequality follows from membership in the same half-open box;
its weak form is all the subsequent proof needs. There are exactly d
approximated coordinates. Define the two endpoint values separately as
u0=0 and u_(N-1)=q, which give zero error at both endpoints.

Set

```text
p=H/q>1,           v_i=s_i-p*u_i.
```

These are rational values, and

```text
q*v_i=q*s_i-H*u_i is integral,
v0=v_(N-1)=0,       |v_i|<=p/Q.                              (9)
```

Consequently every relative error satisfies (3). Actual speeds are the
original distinct integers, regardless of any repetitions among the u_i.

The vectors u,v have rank two. Indeed u_(N-1)=q!=0 and v_(N-1)=0, so rank
at most one would force v to be identically zero. Then H*u_i=q*s_i for
all i. Primitivity gives integer Bezout coefficients z_i with
`sum_i z_i*s_i=1`; multiplication by q yields

```text
q = H*sum_i z_i*u_i,
```

so H divides q. But `0<q<=Q^d<H`, a contradiction. This is the precise
role of primitivity, and it does not require coprimality of each speed
with H. Step 1 now applies to every chosen runner, proving (2).

If H=Q^d, the argument allows q=H and p=1; the preceding contradiction
is unavailable. Hence the retained finite box is inclusive. If the original
tuple is not primitive, exact rational-direction approximation can give
rank one even at arbitrarily large H. One must first divide by its gcd,
which preserves all relative norm questions by inverse time rescaling.

## What the finite reduction supplies, and what it does not

For each N let F_N assert (2) for every primitive sorted N-label integer
configuration of height at most Q^(N-2). It is a finite statement. Under
H_N, Step 2 plus F_N gives all integer configurations of that count:
subtract the smallest speed, divide all resulting integers by their positive
common gcd, apply the primitive result, and divide the resulting time by
that gcd. These operations preserve the count and every relative distance.

If F_N were proved for every N>=3, ordinary strong induction with the exact
two-runner base would establish all positive-integer stationary cases, hence
the canonical real conjecture through the existing all-dimensional BHK
equivalence. Neither all F_N nor their required certificates are supplied
by this audit. Fixed controls below are not exhaustive finite-box checks.
No index-preserving use of an all-dimensional real-to-integer theorem is
needed for the conditional integer theorem above.

The reviewed code already contains the adjacent-ratio collision and the
deduplication/strict-margin mechanism. This note does not claim to discover
those ingredients. Searches of live Lean files and the available research
and documentation for finite-height and simultaneous-approximation routes
did not locate this identical quantitative conclusion. `docs/approaches.md`
lists a finite-height theorem among the missing ingredients. The historical
`HEIGHT-DESCENT`/`MinimalCounterexampleHeightCompression` target in
`docs/full-proof-roadmap.md` is substantially stronger: it seeks compression
to the coefficient-three height regime, not to Q^(N-2). That target remains
unproved. The source comparison is scoped, and no literature-priority claim
is made.

The useful change from the previous fixed-cluster argument is that (8)
produces a suitable affine representation for every sufficiently tall
primitive tuple. The remaining obstruction is now the bounded family F_N,
with a rapidly growing cutoff, and a uniform proof across N. This manuscript
is a conditional finite reduction, not completion of that uniform step.

## Fixed exact controls

These controls use exact fractions and a literal table of witnesses for the
small auxiliary sets that occur. There is no search over original tuples or
finite height boxes. Four fixed primitive tuples are passed through the
actual half-open-box algorithm, whose declared domain is at most 8,001 points
for these fixtures; it stops at its first repeated box. The table checks do
not replace H_N in the theorem.

```python
from fractions import Fraction as F
from math import floor, gcd, lcm
from collections import Counter
from pathlib import Path
from hashlib import sha256
import json

assert sha256(Path('LonelyRunner/BHKAdjacentRatios.lean').read_bytes()).hexdigest() == \
    '677c365618fc612a5ee7d3d9e9696273da2d9e775b77487d0b3e208cea9d6733'
assert sha256(Path('LonelyRunner/BHKAdjacentPair.lean').read_bytes()).hexdigest() == \
    '3d36d812db7ed18db8fce521b2505d5904a8387d8e315c6e7d08d9eb7dc75708'

def norm(x):
    return min(x%1,(-x)%1)

def rank_two(u,v):
    return any(u[i]*v[j]!=u[j]*v[i] for i in range(len(u)) for j in range(len(u)))

# Directly checked rational witnesses for the listed reduced auxiliary sets.
small={(1,):F(1,2),(1,2):F(1,3),(1,3):F(1,2),
       (2,3):F(1,5),(1,4):F(1,3),(1,3,4):F(5,12),
       (2,3,4):F(1,8),(1,2,4):F(1,3),(1,2,5):F(1,3)}
for D,tau in small.items():
    assert all(norm(d*tau)>=F(1,len(D)+1) for d in D)

c=Counter()
def chosen(p,u,v,q,r,require_error=True):
    N=len(u);Q=N*(N-1)
    assert N>=3 and p>1 and q>=1 and u[0]==v[0]==0
    assert all(isinstance(a,int) for a in u)
    assert all((q*a).denominator==1 for a in v)
    s=[p*a+b for a,b in zip(u,v)]
    assert len(set(s))==N and rank_two(u,v)
    J=[i for i in range(N) if i!=r]
    U={i:u[i]-u[r] for i in J}; V={i:v[i]-v[r] for i in J}
    assert any(U[i]*V[j]!=U[j]*V[i] for i in J for j in J)
    sigma={i:1 if s[i]>s[r] else -1 for i in J}
    R={i:sigma[i]*(s[i]-s[r]) for i in J}
    S={i:sigma[i]*U[i] for i in J}
    assert all(R[i]>0 for i in J)
    order=sorted(J,key=lambda i:(S[i]/R[i],i))
    a=order[0]; b=next(i for i in order if S[i]/R[i]>S[a]/R[a])
    assert all(not (S[a]/R[a]<S[i]/R[i]<S[b]/R[b]) for i in J)
    alpha=-(S[a]+S[b]); beta=R[a]+R[b]
    w={i:alpha*R[i]+beta*S[i] for i in J}
    assert all(w[i]!=0 for i in J) and w[a]==-w[b]
    L=lcm(*(w[i].denominator for i in J))
    D=sorted({abs(int(L*w[i])) for i in J})
    assert 1<=len(D)<=N-2
    g=gcd(*D); reduced=tuple(d//g for d in D)
    tau=small[reduced]/g
    assert all(norm(d*tau)>=F(1,len(D)+1) for d in D)
    t0=L*tau
    x=(alpha*p+beta)*t0; raw=alpha*t0
    y=raw-q*floor(raw/q)+q
    assert q<=y<2*q
    for i in J:
        assert w[i]*t0==sigma[i]*(U[i]*x+V[i]*raw)
        assert (V[i]*(y-raw)).denominator==1
        assert norm(U[i]*x+V[i]*y)>=F(1,N-1)
    j=floor(p*y-x+F(1,2))
    t=(j+x)/p
    assert abs(t-y)<=1/(2*p) and t>0
    err=max(abs(V[i]) for i in J)
    if require_error:
        assert err<=2*p/Q
        # Under this small-error hypothesis the signed integer slopes are nonnegative.
        assert all(S[i]>=0 for i in J) and alpha<0
        for i in J:
            actual=(s[i]-s[r])*t
            assert actual==U[i]*j+(U[i]*x+V[i]*y)+V[i]*(t-y)
            assert norm(actual)>=F(1,N-1)-abs(V[i])/(2*p)>=F(1,N)
            c['signed_comparisons']+=1
            c['negative_actual_comparisons']+=s[i]<s[r]
            c['zero_relative_u']+=U[i]==0
            c['closed_target_equalities']+=norm(actual)==F(1,N)
        c['chosen_runner_lifts']+=1
        c['denominator_clearings_gt_one']+=L>1
        c['error_bound_equalities']+=err==2*p/Q
        c['nearest_ties']+=abs(j-(p*y-x))==F(1,2)
    return dict(s=s,U=U,V=V,alpha=alpha,x=x,raw=raw,y=y,t=t,err=err)

affine=[(F(13,2),(0,1,2),(F(0),F(1,3),F(0)),3),
        (F(7),(0,1,-1),(F(0),F(1,2),F(1,2)),2),
        (F(3),(0,1,2),(F(0),F(1),F(0)),1)]
for p,u,v,q in affine:
    for r in range(len(u)):
        chosen(p,u,v,q,r)
    c['standalone_affine_fixtures']+=1

# Wrong phase-period control: q=3 cannot be silently replaced by one.
z=chosen(*affine[0],0,require_error=False)
wrong=z['raw']-floor(z['raw'])+1
assert norm(z['U'][1]*z['x']+z['V'][1]*wrong)==F(1,6)<F(1,3)
assert norm(z['U'][1]*z['x']+z['V'][1]*z['y'])==F(1,2)
# Alpha=0 is valid in free-phase supply, but these data fail the transfer bound.
z=chosen(F(2),(0,1,-1),(F(0),F(0),F(5)),1,0,require_error=False)
assert z['alpha']==0 and z['raw']==0 and z['y']==1
assert z['err']>F(4,6)
assert min(norm(s*z['t']) for s in z['s'][1:])==F(1,4)<F(1,3)
assert all(norm(s*F(1,5))>=F(1,3) for s in z['s'][1:])

def approximate(s):
    N=len(s);Q=N*(N-1);d=N-2;H=s[-1]
    assert N>=3 and s[0]==0 and all(a<b for a,b in zip(s,s[1:]))
    domain=Q**d+1
    assert domain<=8001
    seen={}
    for ell in range(domain):
        box=tuple(floor(Q*(F(ell*a,H)%1)) for a in s[1:-1])
        if box in seen:
            k=seen[box];q=ell-k
            u=[0]+[floor(F(ell*a,H))-floor(F(k*a,H)) for a in s[1:-1]]+[q]
            assert 1<=q<=Q**d
            assert all(abs(F(q*a,H)-b)<F(1,Q) for a,b in zip(s[1:-1],u[1:-1]))
            p=F(H,q);v=[F(a)-p*b for a,b in zip(s,u)]
            assert v[0]==v[-1]==0 and u[-1]==q
            assert all((q*a).denominator==1 for a in v)
            assert all(abs(a)<=p/Q for a in v)
            c['pigeonhole_points_examined']+=ell+1
            return p,tuple(u),tuple(v),q,[k,ell]
        seen[box]=ell
    raise AssertionError('pigeonhole violation')

certificates=[]
for s in [(0,1,7),(0,1,75,149),(0,1,200,401),(0,1,2670,5339,8009)]:
    N=len(s);Q=N*(N-1);H=s[-1]
    assert gcd(*s)==1 and H>Q**(N-2)
    p,u,v,q,pair=approximate(s)
    assert 0<q<H and p>1 and rank_two(u,v)
    for r in range(N):
        chosen(p,u,v,q,r)
    certificates.append(dict(s=s,Q=Q,bound=Q**(N-2),q=q,p=str(p),u=u,
                             v=[str(a) for a in v],same_box_indices=pair))
    c['primitive_height_fixtures']+=1

# Inclusive cutoff and nonprimitive rank-one controls are excluded, not proved by Step 2.
p,u,v,q,pair=approximate((0,1,6))
assert q==6 and p==1 and not rank_two(u,v)
assert 6==6**1
p,u,v,q,pair=approximate((0,100,200))
assert q==2 and p==100 and not rank_two(u,v) and gcd(100,200)==100
assert all(q*a==200*b for a,b in zip((0,100,200),u))
assert 200%q==0 and q%200!=0
assert c['standalone_affine_fixtures']==3 and c['primitive_height_fixtures']==4
assert c['chosen_runner_lifts']==25 and c['signed_comparisons']==68
assert c['negative_actual_comparisons']==34
assert c['denominator_clearings_gt_one']>0 and c['zero_relative_u']>0
assert c['error_bound_equalities']>0 and c['closed_target_equalities']>0
print(json.dumps(dict(counts=dict(c),primitive_certificates=certificates),sort_keys=True))
```

Run from the repository root:

```bash
python3 -B - <<'AFFINE_HEIGHT_REPLAY'
from pathlib import Path
import re
p=Path('research/astra-affine-finite-height-audit.md')
blocks=re.findall(r'^```python\n(.*?)^```[ \t]*$',p.read_text(),re.M|re.S)
assert len(blocks)==1
exec(compile(blocks[0],str(p),'exec'),{})
AFFINE_HEIGHT_REPLAY
```

Observed replay: exit zero. Three standalone rational-affine fixtures and
four primitive-height fixtures yielded 25 chosen-runner lifts and 68 signed
comparisons, including 34 negative comparisons, eight zero relative slopes,
three nontrivial denominator clearings, three error-bound equalities, three
attained target equalities, and seven nearest-integer ties. The six fixed
half-open-box controls examined 24 points in total; four produce the positive
height certificates and two exercise the inclusive-boundary/nonprimitive
rank-one exclusions. The wrong-period and alpha-zero/failed-error-bound
controls passed with their stated exact failures. These checks are finite
author evidence supporting the derivation, not verification of any F_N.

Only this manuscript was written. All author commands completed; no
background process was started. No Lean build, dependency or cache mutation,
shared-state write, or Git operation was performed. The original proposed
cutoff `[N*(N-1)]^(N-2)` is retained. Independent semantic review is the next
required step before accepting the candidate or formalizing it. H_N and the
unverified bounded statements F_N remain explicit, and unrestricted LRC
remains unresolved.
