# Independent review of the affine finite-height reduction

2026-09-05. Requested role: GPT-6 Astra xhigh, independent mathematical
review. The runtime did not independently expose model/effort metadata to
this worker. Registered task: `/root/cluster_limit_review-affine-finite-height`.
Review source checkpoint: `48282c65d59a58e5b8c0dccce2935fcb567c9c79`.
The author's earlier source checkpoint is recorded in its frozen manuscript;
the exact byte hashes below bind this review.

**Disposition: accepted as a conditional manuscript theorem, without a
correction to the proposed cutoff.** Assuming H_N, every primitive sorted
integer N-runner configuration of height H>[N(N-1)]^(N-2) has a positive
closed 1/N witness for every chosen runner. This is a global conditional
finite-height reduction. It is not a proof of H_N, the remaining finite
families F_N, or unrestricted LRC, and it is not a kernel-checked theorem.
No novelty or literature-priority claim is made.

At task startup the current configuration, workflow document, policy, and
state were read, and `python3 scripts/validate_workflow.py` passed. The state
authorizes research and assigns this file only to the reviewer. The author
was initially unfrozen; final acceptance was withheld until the root supplied
the final hash and it matched the bytes independently read here. No author,
root, or other worker's checker was executed or used as mathematical proof.

## Frozen source and supported interfaces

| File | SHA-256 |
| --- | --- |
| `research/astra-affine-finite-height-audit.md` | `6b676a05eb3a0036cd69e779150a5f1a868024d089ea75c142daeddccede938f` |
| `LonelyRunner/BHKAdjacentRatios.lean` | `677c365618fc612a5ee7d3d9e9696273da2d9e775b77487d0b3e208cea9d6733` |
| `LonelyRunner/BHKAdjacentPair.lean` | `3d36d812db7ed18db8fce521b2505d5904a8387d8e315c6e7d08d9eb7dc75708` |
| `LonelyRunner/BHKBridgeCore.lean` | `43d0371d3fa213daa895d5431e9cfdd28d79d2de4ba89e02d9a9da93273678a3` |
| `LonelyRunner/BHKCollisionToWitness.lean` | `42e7665af7981ef336ab4e1826ff3f096e6d6855b50440f76e2ede7a538f7f87` |
| `LonelyRunner/BHKRealReduction.lean` | `98d7c878eef7e4a3b7f7c504c882cf35191c1343816a59d731193ac8a207ed26` |
| `LonelyRunner/Formulations.lean` | `0c3328e975bee236ff66862d3a5cadeb58fbc7c804fa953e53701ba466b9d788` |
| `LonelyRunner/IntegerInduction.lean` | `7b315fe9ea7f8639eb45e376365f1c3795c52e2f93e608db578390c1083a5753` |

`exists_bhk_adjacentRatioCombination` accepts a positive rational reference
vector and a rational vector with nonconstant coordinate ratios. It returns
a nowhere-zero combination with two opposite coordinates. The manuscript
uses exactly this algebra, after sign normalization of relative actual speeds.
It does not need the stronger relation-preserving hypotheses of
`exists_bhk_relationCompatible_collision`.

`exists_stationaryWitness_of_rational_collision` also requires every integer
relation of the original speed vector to annihilate its rational collision
vector and consumes the all-dimensional `PositiveRationalConjecture`.
Neither condition is asserted for the present affine construction. Its direct
phase rounding is a separate transfer, so the absent relation premise is not
silently discarded from an invoked theorem. `conjecture_iff_positiveIntegerConjecture`
is a global equivalence and is used only after a hypothetical proof in every
integer count. Its exposed type does not prove H_N or preserve a least failing
real count. The inspected insertion interface likewise retains its covering
premise; it does not discharge the finite families introduced here.

The source references support the collision algebra and comparison with
existing proof mechanisms. They do not already supply the complete affine
or finite-height theorem. The documented coefficient-three height-compression
target is stronger than this exponential cutoff and remains open. No broad
negative literature-search conclusion is part of this review.

## Independent proof audit

Fix N>=3, Q=N(N-1), and epsilon=1/Q. H_N means that every nonempty finite
set D of distinct positive integers with |D|<=N-2 has a real witness at
the closed threshold 1/(|D|+1). These are precisely total runner counts
2 through N-1 in the positive stationary integer formulation. H_N has no
height restriction. Throughout, ||x|| denotes distance to the nearest integer.

### Relative rank, signs, and collision

Let u be integer, v rational, u0=v0=0, p>1 rational, and s=p*u+v have N
distinct coordinates. Assume u,v are linearly independent over Q. Fix any
chosen r and let U_i=u_i-u_r, V_i=v_i-v_r for i!=r. If a nonzero rational
pair (A,B) annihilated every relative pair, then A*u_i+B*v_i would be
constant in i. Evaluating at the original zero label makes that constant
zero. This would contradict the original rank assumption. Thus the relative
pairs have rank two for every chosen r, including interior and upper runners.

Set sigma_i=sign(s_i-s_r), R_i=sigma_i*(s_i-s_r)>0 and S_i=sigma_i*U_i.
The ratio S_i/R_i equals U_i/(p*U_i+V_i). If all ratios were a constant
lambda, the nonzero coefficient pair (1-lambda*p,-lambda) would annihilate
all relative pairs. This is impossible. No distinctness of u or positivity
of its coordinates is needed. The signs are attached to the actual relative
speeds; omitting those signs would invalidate the positive-reference premise.

Select adjacent distinct attained ratios S_a/R_a<S_b/R_b and define
alpha=-(S_a+S_b), beta=R_a+R_b>0. The weighted mean
(S_a+S_b)/(R_a+R_b) is strictly between these two values. Hence

`w_i=alpha*R_i+beta*S_i`

never vanishes: a zero would place an attained ratio at that forbidden mean.
Expansion gives w_a=S_a*R_b-S_b*R_a and w_b=-w_a. This is a nonzero
opposite-sign pair, not a claimed equality of signed speeds. Consequently
absolute-value deduplication removes at least one of the N-1 comparison
slots. A positive integer L clearing all rational denominators gives a
nonempty set D={|L*w_i|} of at most N-2 distinct positive integers.

H_N supplies tau, and the correctly scaled time is t0=L*tau. Indeed
w_i*t0=(L*w_i)*tau, so every collision norm is at least 1/(N-1).
Division by L here would be wrong. Neither t0 nor tau needs to be positive;
the later phase normalization supplies positivity of the final witness.

### The two phases and exact perturbation

Put x=(alpha*p+beta)*t0 and y_raw=alpha*t0. Direct expansion gives

`w_i*t0 = sigma_i*(U_i*x+V_i*y_raw)`.

If q is any positive integer with q*v_i integral for all i, then q*V_i
is integral as well. Set

`y=y_raw-q*floor(y_raw/q)+q`, so `q<=y<2q`.

The difference y-y_raw is an integer multiple of q, so changing the second
phase to y preserves every norm. Period one is not generally valid. There
is no need to reduce x, and no bound on alpha, beta, x, or the original real
lift y_raw is used. The formula also handles y_raw=0 and either sign of
y_raw. A nonminimal common denominator is permitted.

Choose a nearest integer j to p*y-x and set t=(j+x)/p. Then
|t-y|<=1/(2p), including either nearest-integer tie, and
t>=q-1/(2p)>=1-1/(2p)>0. For each actual signed comparison,

`(s_i-s_r)*t = U_i*j + (U_i*x+V_i*y) + V_i*(t-y)`.

The first term is an integer. The circle norm is 1-Lipschitz with respect
to the real lift, so under |V_i|<=2p/Q,

`||(s_i-s_r)*t|| >= 1/(N-1)-|V_i|/(2p) >= 1/(N-1)-1/Q = 1/N`.

This loss depends on V_i rather than the possibly large actual relative
speed. No incompatible affine relation is fed to a BHK orbit-closure
theorem, and no limiting witness is substituted for a witness at this p.
The closed target is essential at equality. The resulting time is allowed
to depend on r. This proves the stated rational affine lemma.

### Simultaneous approximation and the height bound

Now let 0=s0<...<s_(N-1)=H be a primitive integer tuple and assume
H>Q^(N-2). There are d=N-2 internal coordinates. The Q^d+1 fractional-part
vectors for indices 0 through Q^d occupy Q^d half-open boxes of side 1/Q
in [0,1)^d. Finite pigeonhole gives indices k<ell in one box, not merely
an informal approximation with an unspecified denominator.

For q=ell-k, 1<=q<=Q^d. Set each internal integer coordinate to
u_i=floor(ell*s_i/H)-floor(k*s_i/H). Subtracting the fractional parts
shows |q*s_i/H-u_i|<1/Q. The inequality is strict because both coordinates
belong to the same half-open interval of width 1/Q. Define endpoints
u0=0 and u_(N-1)=q separately, with exactly zero error.

Put p=H/q and v_i=s_i-p*u_i. Then p>1, q*v_i=q*s_i-H*u_i is integral,
both endpoint offsets vanish, and |v_i|<=p/Q. Thus |v_i-v_r|<=2p/Q for
every chosen r. The actual speeds remain the original distinct integers.
No distinctness, ordering, or primitivity of the approximating u is claimed.

If u,v had rank at most one, the nonzero endpoint u_(N-1)=q and the zero
endpoint v_(N-1)=0 would force v=0. Therefore H*u_i=q*s_i for every i.
By primitivity there are integer coefficients z_i with sum z_i*s_i=1,
giving q=H*sum z_i*u_i. This says H divides q, contradicting 0<q<H.
It does not require any individual s_i to be coprime to H. Rank two holds,
and the affine lemma applies separately to every chosen runner.

At H=Q^d, q=H and p=1 are possible, so that height must remain in the
retained finite family. Dropping primitivity would allow rank-one exact
approximations even for arbitrarily large H. The correct preprocessing of
an arbitrary integer configuration is translation by its minimum and
division by the gcd g>0 of the resulting speeds. A witness time T for the
primitive tuple transfers back at T/g; all pairwise differences scale by g.

### Completion boundary

For each fixed N, F_N asserts witnesses for every primitive sorted tuple
with H<=Q^(N-2), including equality. This is a finite collection of
configuration obligations. H_N plus F_N supplies all integer configurations
of that count by the preceding reduction. Strong induction over total count,
starting with the exact two-runner case, would then prove all integer counts
if F_N were established for every N>=3. Only then can the global BHK
equivalence produce the canonical real statement.

The manuscript supplies neither those F_N nor a uniform proof of them.
Their cutoff grows with N, so proving finitely many fixed-count instances
does not close the induction. The reduction is broader than a fixed-cluster
exclusion, but it remains conditional and does not meet the project's
completion gate.

## Independent exact controls and declared domain

The sole Python block below is newly authored from the derivation. It uses
four literal rational-affine fixtures and four primitive integer tuples with
literal same-box pairs. For the latter it checks only the two specified
fractional-part vectors, not an orbit search or all Q^d+1 points. These pairs
include k>0 and a negative error, nonconsecutive speeds, and a primitive
tuple in which neither internal speed is coprime to H.

Every chosen runner is checked for each fixture, with denominator multiples
1 and 2 and auxiliary integer-time shifts -1 and 0. At a nearest-integer
tie both choices are checked. The auxiliary witness table is literal and
verified exactly for each used reduced D; it is not a search or a proof of
H_N. All arithmetic is rational. Separate fixed controls test an incorrect
denominator period, incorrect division by L, rank-one and cutoff exclusions,
the offset-bound requirement, half-open box boundaries, and gcd/time scaling.
There is no exhaustive finite-box verification or new tuple-discovery loop.

```python
from fractions import Fraction as F
from math import gcd, lcm, floor
from collections import Counter
from pathlib import Path
from hashlib import sha256
import json

AUTHOR_SHA = '6b676a05eb3a0036cd69e779150a5f1a868024d089ea75c142daeddccede938f'
assert sha256(Path('research/astra-affine-finite-height-audit.md').read_bytes()).hexdigest() == AUTHOR_SHA

def norm(x):
    f = F(x) % 1
    return min(f,1-f)

def rank_two(u,v):
    return any(u[i]*v[j] != u[j]*v[i]
               for i in range(len(u)) for j in range(i))

def nearest(x):
    n = floor(x)
    side = 2*(x-n)
    return (n,) if side < 1 else ((n+1,) if side > 1 else (n,n+1))

# Each value is a literal witness for the actual reduced positive speed set.
table = {(1,):F(1,2), (1,2):F(1,3), (1,3):F(1,2),
         (1,2,4):F(1,3), (1,3,7):F(1,2), (2,3,4):F(1,8)}
for D,tau in table.items():
    assert all(norm(d*tau) >= F(1,len(D)+1) for d in D)

counts = Counter()
used_reduced_sets = set()

def collision(p,u,v,r):
    N = len(u)
    assert N >= 3 and p > 1 and u[0] == v[0] == 0
    assert all(isinstance(a,int) for a in u) and rank_two(u,v)
    s = tuple(p*a+b for a,b in zip(u,v))
    assert len(set(s)) == N
    I = [i for i in range(N) if i != r]
    U = {i:u[i]-u[r] for i in I}
    V = {i:v[i]-v[r] for i in I}
    assert any(U[i]*V[j] != U[j]*V[i] for i in I for j in I)
    sigma = {i:1 if s[i] > s[r] else -1 for i in I}
    R = {i:sigma[i]*(s[i]-s[r]) for i in I}
    S = {i:sigma[i]*U[i] for i in I}
    ratios = {i:S[i]/R[i] for i in I}
    assert all(R[i] > 0 for i in I) and len(set(ratios.values())) >= 2
    a = min(I,key=lambda i:(ratios[i],i))
    b = min((i for i in I if ratios[i] > ratios[a]),key=lambda i:(ratios[i],i))
    assert all(not (ratios[a] < ratios[i] < ratios[b]) for i in I)
    alpha, beta = -(S[a]+S[b]), R[a]+R[b]
    w = {i:alpha*R[i]+beta*S[i] for i in I}
    assert beta > 0 and all(w[i] != 0 for i in I) and w[a] == -w[b]
    L = lcm(*(w[i].denominator for i in I))
    assert L >= 1 and all((L*w[i]).denominator == 1 for i in I)
    D = tuple(sorted({abs(int(L*w[i])) for i in I}))
    assert 1 <= len(D) <= N-2 and min(D) >= 1
    g = gcd(*D)
    reduced = tuple(d//g for d in D)
    tau = table[reduced]/g
    assert all(norm(d*tau) >= F(1,len(D)+1) for d in D)
    return dict(s=s,I=I,U=U,V=V,sigma=sigma,alpha=alpha,beta=beta,w=w,
                L=L,D=D,reduced=reduced,tau=tau)

def transfer(p,u,v,q,r,time_shift,require_error=True):
    c = collision(p,u,v,r)
    N,Q = len(u),len(u)*(len(u)-1)
    assert isinstance(q,int) and q >= 1
    assert all((q*a).denominator == 1 for a in v)
    I,U,V = c['I'],c['U'],c['V']
    tau = c['tau']+time_shift
    assert all(norm(d*tau) >= F(1,len(c['D'])+1) for d in c['D'])
    t0 = c['L']*tau
    x = (c['alpha']*p+c['beta'])*t0
    raw = c['alpha']*t0
    y = raw-q*floor(raw/q)+q
    assert q <= y < 2*q and ((y-raw)/q).denominator == 1
    for i in I:
        assert c['w'][i]*t0 == c['sigma'][i]*(U[i]*x+V[i]*raw)
        assert (V[i]*(y-raw)).denominator == 1
        assert norm(U[i]*x+V[i]*y) == norm(c['w'][i]*t0) >= F(1,N-1)
    choices = nearest(p*y-x)
    times = {(j+x)/p for j in choices}
    for j in choices:
        t = (j+x)/p
        e = t-y
        assert abs(e) <= F(1,2)/p and t >= q-F(1,2)/p > 0
        for i in I:
            actual = (c['s'][i]-c['s'][r])*t
            base = U[i]*x+V[i]*y
            assert actual == U[i]*j+base+V[i]*e
            assert norm(actual) >= norm(base)-abs(V[i]*e)
            if require_error:
                assert abs(V[i]) <= 2*p/Q
                assert norm(actual) >= F(1,N-1)-abs(V[i])/(2*p) >= F(1,N)
                counts['original_signed_comparisons'] += 1
                counts['negative_comparisons'] += c['s'][i] < c['s'][r]
                counts['zero_relative_u_comparisons'] += U[i] == 0
                counts['closed_target_equalities'] += norm(actual) == F(1,N)
        if require_error:
            counts['rounding_lifts'] += 1
    if require_error:
        used_reduced_sets.add(c['reduced'])
        counts['chosen_runner_inputs'] += 1
        counts['nearest_tie_inputs'] += len(choices) == 2
        counts['nontrivial_clearing_inputs'] += c['L'] > 1
        counts['negative_raw_phase_inputs'] += raw < 0
        counts['negative_auxiliary_time_inputs'] += t0 < 0
        counts['error_bound_equality_inputs'] += max(map(abs,V.values())) == 2*p/Q
    return dict(c=c,t0=t0,x=x,raw=raw,y=y,times=times)

affine = [
    ('rational_denominator',F(9,4),(0,1,3),(F(0),F(1,5),F(0)),5),
    ('negative_speed',F(5,2),(0,-2,1),(F(0),F(1,7),F(-1,7)),7),
    ('repeated_slope',F(7,3),(0,0,2),(F(0),F(1,9),F(0)),9),
    ('closed_transfer',F(6),(0,2,3),(F(0),F(2),F(0)),1),
]

def box_point(k,s,Q):
    f = tuple(F(k*a,s[-1]) % 1 for a in s[1:-1])
    box = tuple(floor(Q*x) for x in f)
    assert all(0 <= b < Q and F(b,Q) <= x < F(b+1,Q) for b,x in zip(box,f))
    return box,f

# Literal same-box pairs and Bezout coefficients; no search for pairs is run.
primitive = [
    ((0,2,11),0,6,(0,6,-1)),
    ((0,2,87,174),0,2,(0,-43,1,0)),
    ((0,1,2006,4011,8021),0,4,(0,1,0,0,0)),
    ((0,4,13),1,4,(0,-3,1)),
]
certificates = []
for s,k,ell,z in primitive:
    N,Q,H = len(s),len(s)*(len(s)-1),s[-1]
    d,bound = N-2,Q**(N-2)
    assert s[0] == 0 and all(a < b for a,b in zip(s,s[1:]))
    assert gcd(*s) == 1 and sum(a*b for a,b in zip(s,z)) == 1 and H > bound
    assert 0 <= k < ell <= bound
    box1,f1 = box_point(k,s,Q)
    box2,f2 = box_point(ell,s,Q)
    assert box1 == box2
    q = ell-k
    u = (0,)+tuple(floor(F(ell*a,H))-floor(F(k*a,H)) for a in s[1:-1])+(q,)
    assert all(F(q*a,H)-b == y-x and abs(y-x) < F(1,Q)
               for a,b,x,y in zip(s[1:-1],u[1:-1],f1,f2))
    p = F(H,q)
    v = tuple(F(a)-p*b for a,b in zip(s,u))
    assert 1 <= q <= bound < H and p > 1 and v[0] == v[-1] == 0
    assert all((q*b).denominator == 1 and q*b == q*a-H*c
               for a,b,c in zip(s,v,u))
    assert all(abs(b) <= p/Q for b in v)
    assert rank_two(u,v) and q % H != 0
    assert q-H*sum(a*b for a,b in zip(z,u)) == q*sum(a*b for a,b in zip(z,v))
    affine.append(('height_'+str(H),p,u,v,q))
    certificates.append(dict(s=s,pair=[k,ell],box=box1,bound=bound,q=q,p=str(p),
                             u=u,v=list(map(str,v))))
    counts['same_box_point_vectors_checked'] += 2
    counts['primitive_height_fixtures'] += 1

assert gcd(2,174) > 1 and gcd(87,174) > 1 and gcd(2,87,174) == 1
for name,p,u,v,q in affine:
    for r in range(len(u)):
        for multiple in [1,2]:
            for shift in [-1,0]:
                transfer(p,u,v,multiple*q,r,shift)
    counts['all_runner_fixtures'] += 1

# Concrete failures of two incorrect phase/scaling substitutions.
name,p,u,v,q = affine[0]
c = collision(p,u,v,0)
assert c['L'] == 5
assert all(norm(w*c['L']*c['tau']) == F(1,2) for w in c['w'].values())
assert all(norm(w*c['tau']/c['L']) == F(1,50) for w in c['w'].values())
counts['wrong_clearing_direction_controls'] += 1
r = 1
out = transfer(p,u,v,q,r,0)
wrong_y = out['raw']-floor(out['raw'])+1
assert norm(out['c']['U'][0]*out['x']+out['c']['V'][0]*out['y']) == F(1,2)
assert norm(out['c']['U'][0]*out['x']+out['c']['V'][0]*wrong_y) == F(3,10) < F(1,3)
counts['wrong_period_controls'] += 1

# Zero alpha is harmless for phase supply, but omitting the offset bound is not.
out = transfer(F(3),(0,1,-1),(F(0),F(0),F(8)),1,0,0,False)
assert out['c']['alpha'] == 0 and out['raw'] == 0 and out['y'] == 1
assert max(map(abs,out['c']['V'].values())) == 8 > F(2*3,6)
assert out['times'] == {F(5,6),F(7,6)}
assert all(min(norm(s*t) for s in out['c']['s'][1:]) == F(1,6) for t in out['times'])
assert all(norm(s*F(1,8)) >= F(1,3) for s in out['c']['s'][1:])
counts['missing_error_bound_controls'] += 1

# Rank-one data can obey the error bound but cannot supply nonconstant ratios.
u,v,p = (0,1,2),(F(0),F(1),F(2)),F(100)
assert not rank_two(u,v) and max(v) <= 2*p/6
assert {F(a)/(p*a+b) for a,b in zip(u[1:],v[1:])} == {F(1,101)}
counts['rank_one_affine_controls'] += 1

# Boundary and nonprimitive exact approximations invalidate the rank argument.
for s,q,u,expected_p in [((0,5,6),6,(0,5,6),F(1)),
                         ((0,35,70),2,(0,1,2),F(35))]:
    H = s[-1]
    p = F(H,q)
    v = tuple(F(a)-p*b for a,b in zip(s,u))
    assert p == expected_p and v == (0,0,0) and not rank_two(u,v)
    assert box_point(0,s,6)[0] == box_point(q,s,6)[0]
    counts['excluded_exact_approximation_controls'] += 1
assert 6 == 6**(3-2) and gcd(5,6) == 1
assert 70 > 6**(3-2) and gcd(35,70) == 35 and 0 < 2 < 70 and 2 % 70 != 0

# Half-open boxes separate points exactly one box-width apart.
assert floor(6*F(0)) == 0 and floor(6*F(1,6)) == 1
counts['half_open_boundary_controls'] += 1

# Translation and division by gcd use inverse, not direct, time scaling.
small,large,g,T = (0,1,2),(-101,-66,-31),35,F(1,3)
for r in range(3):
    for i in range(3):
        if i != r:
            assert large[i]-large[r] == g*(small[i]-small[r])
            assert norm((large[i]-large[r])*(T/g)) == norm((small[i]-small[r])*T) == F(1,3)
            counts['gcd_time_scaling_comparisons'] += 1
for p in [2,7]:
    assert norm(p*F(1,2*p)) == F(1,2)
    counts['two_runner_base_controls'] += 1

assert counts['all_runner_fixtures'] == 8 and counts['primitive_height_fixtures'] == 4
assert counts['same_box_point_vectors_checked'] == 8
# One additional valid chosen input above isolates the wrong-period substitution.
assert counts['chosen_runner_inputs'] == 4*sum(len(u) for _,_,u,_,_ in affine)+1 == 109
assert counts['nontrivial_clearing_inputs'] > 0 and counts['nearest_tie_inputs'] > 0
assert counts['error_bound_equality_inputs'] > 0 and counts['closed_target_equalities'] > 0
assert counts['zero_relative_u_comparisons'] > 0 and counts['negative_auxiliary_time_inputs'] > 0
print(json.dumps(dict(counts=dict(sorted(counts.items())),
                     reduced_speed_sets=sorted(used_reduced_sets),
                     primitive_certificates=certificates),sort_keys=True))
```

Run from the repository root:

```bash
python3 -B - <<'AFFINE_HEIGHT_INDEPENDENT_REVIEW'
from pathlib import Path
import re
p=Path('research/astra-affine-finite-height-review.md')
blocks=re.findall(r'^```python\n(.*?)^```[ \t]*$',p.read_text(),re.M|re.S)
assert len(blocks)==1
exec(compile(blocks[0],str(p),'exec'),{})
AFFINE_HEIGHT_INDEPENDENT_REVIEW
```

Observed result: exit zero on the first execution of this exact saved block.
The extracted Python block has SHA-256
`9996caf21270e689924d2745a15192e48079685ecc14492f4c2bf1c997668489`.

```text
all_runner_fixtures: 8
primitive_height_fixtures: 4
same_box_point_vectors_checked: 8
chosen_runner_inputs: 109
rounding_lifts: 143
original_signed_comparisons: 358
negative_comparisons: 165
zero_relative_u_comparisons: 32
nearest_tie_inputs: 34
closed_target_equalities: 16
error_bound_equality_inputs: 12
nontrivial_clearing_inputs: 37
negative_raw_phase_inputs: 55
negative_auxiliary_time_inputs: 54
wrong_clearing_direction_controls: 1
wrong_period_controls: 1
missing_error_bound_controls: 1
rank_one_affine_controls: 1
excluded_exact_approximation_controls: 2
half_open_boundary_controls: 1
gcd_time_scaling_comparisons: 6
two_runner_base_controls: 2
```

The four primitive certificates are:

| Original tuple | Bound | Same-box indices | q | u | v |
| --- | ---: | --- | ---: | --- | --- |
| (0,2,11) | 6 | (0,6) | 6 | (0,1,6) | (0,1/6,0) |
| (0,2,87,174) | 144 | (0,2) | 2 | (0,0,1,2) | (0,2,0,0) |
| (0,1,2006,4011,8021) | 8000 | (0,4) | 4 | (0,0,1,2,4) | (0,1,3/4,1/2,0) |
| (0,4,13) | 6 | (1,4) | 3 | (0,1,3) | (0,-1/3,0) |

The reduced auxiliary sets used by the replay are exactly {1}, {1,2},
{1,3}, {1,2,4}, {1,3,7}, and {2,3,4}. This finite table tests the construction;
it does not replace H_N for arbitrary auxiliary sets or certify any F_N.

All owned commands completed normally. No background process was launched,
no search was interrupted, and no owned command remains running at handoff.
Only this review file was written. No Lean invocation, trust audit, build,
dependency/cache mutation, Git operation, or shared-state edit was performed.
Acceptance rests on the independent mathematical derivation, with exact
controls checking its implemented identities and edge cases. The next
possible step is formalization of the accepted conditional theorem; the
unproved F_N and the unrestricted canonical goal remain separate obligations.
