# Actual collision cardinality does not give universal endpoint packets

2026-09-05. Requested Astra xhigh, task
`/root/guard_internal_cover_audit-cardinality-adaptive-affine`. Assignment
checkpoint `bf31ea82629c4101755e950faeb6e406fae7c1c9`. Current configuration,
workflow, policy, and state were read, and workflow validation passed.
Runtime model/effort metadata was not independently exposed. Only this note
and the small temporary exact-control program were written.

**Result: the cardinality-adaptive conditional transfer is valid, but universal
endpoint-packet supply is false already for N=5, s=(0,1,2,3,4), chosen r=0.**
This statement quantifies over every positive integer q and every integer
endpoint row u, and tests every pair whose collision row is nowhere zero.
The reduction to eight rows and 48 unordered pairs is proved below, so this
is not a negative search over an arbitrary denominator cutoff. The original
time 1/5 witnesses every runner of that tuple. Neither F_N nor LRC is refuted.
This is a manuscript result requiring separate independent review; no new
Lean theorem or unrestricted solution is claimed.

## Conditional transfer with the actual count

Fix N>=3 and distinct sorted integers `0=s0<...<s_(N-1)=H`. Fix a chosen
runner r and an endpoint packet

```text
q is a positive integer; u_i are integers; u0=0; u_last=q;
p=H/q>0; v_i=s_i-p*u_i; R_i=q*s_i-H*u_i=q*v_i.
```

For i!=r put sigma_i=sign(s_i-s_r),
`W_i=|s_i-s_r|>0`, `U_i=sigma_i*(u_i-u_r)`, and
`V_i=sigma_i*(v_i-v_r)`. Thus W_i=p*U_i+V_i. For any distinct comparison
labels a,b define

```text
alpha=-(U_a+U_b); beta=W_a+W_b;
w_i=beta*U_i+alpha*W_i;
c=card { |w_i| : i!=r }.
```

Assume **every** w_i is nonzero. Expansion gives w_a=-w_b, so
`1<=c<=N-2`. Adjacency of the ratios is sufficient for nonvanishing but is
not required here. This audit allows every pair satisfying the stated
nonvanishing test. Reversing a,b gives the same row; a diagonal pair has
w_a=0 and cannot qualify.

Assume H_N exactly as defined by
`LowerCountPositiveIntegerHypothesis N`: all positive distinct integer
moving tuples with d<=N-2 have a witness at their own threshold 1/(d+1).
The cardinality-adaptive sufficient condition is

```text
epsilon(c,N)=1/(c+1)-1/N;
|v_i-v_r|/(2p) <= epsilon(c,N)             for every i.       (A)
```

Under H_N, (A) and the nowhere-zero collision imply a positive canonical
1/N witness for this chosen r. Here is the complete transfer.

The present W,U,w are integral, so the positive distinct magnitude set
D={|w_i|} is itself an H_N input of size c. It supplies tau with every
`||tau*w_i||>=1/(c+1)`. More generally, if the same algebra is used for
rational actual speeds, clear w by a positive integer L. The set
`{|L*w_i|}` still has exactly c elements; its integer witness tau gives
`t0=L*tau`, not tau/L. In this endpoint theorem L=1 and t0=tau.

Set `x=(alpha*p+beta)*t0`, `y_raw=alpha*t0`. Then

```text
t0*w_i = U_i*x+V_i*y_raw
       = sigma_i*((u_i-u_r)*x+(v_i-v_r)*y_raw).
```

Circle-norm sign invariance preserves the margin. Normalize
`y=y_raw-q*floor(y_raw/q)+q`, so q<=y<2q. Since
`q*(v_i-v_r)=R_i-R_r` is integral, this changes every unsigned relative
phase by an integer. Period one cannot replace q in general. The formula
works for negative or zero y_raw and does not change x.

Take j nearest to p*y-x and t=(j+x)/p. The generic affine identity is

```text
|t-y|<=1/(2p);
(s_i-s_r)*t = (u_i-u_r)*j +
  ((u_i-u_r)*x+(v_i-v_r)*y) + (v_i-v_r)*(t-y).
```

The first term is integral. The 1-Lipschitz property gives
`||(s_i-s_r)*t||>=1/(c+1)-|v_i-v_r|/(2p)>=1/N`.
All inequalities are closed, including nearest-integer ties. Also
`t>=q-1/(2p)=q*(1-1/(2H))>0`, since H>=N-1>=2. Thus this endpoint
statement permits every q>0 even when p<=1. Alternatively the folding lemma
below first gives p'>1 for the earlier rational affine interface. No orbit
relation-compatibility premise is omitted: this is the explicit phase
construction and rounding identity, not an application of the
relation-compatible BHK wrapper.

The current `exists_lowerCount_rational_collision` discards some information
by comparing 1/(c+1) with 1/(N-1). To retain the stronger margin, use H_N
on the enumerated magnitude set itself, or its existing
`lowerCountPositiveIntegerHypothesis_rational` adapter at d=c. The current
fixed-budget signed/positive affine theorems alone do not assert this new
cardinality-sensitive conclusion. `exists_affinePhaseTransfer` and
`exists_normalized_affine_second_phase` provide its generic metric and period
ingredients without such a downgrade.

## Folding q modulo H is complete for this class

Condition (A) is exactly

```text
|R_i-R_r| <= 2H*epsilon(c,N).                               (B)
```

Because c>=1, `epsilon(c,N)<=1/2-1/N<1/2`; in particular the bound in
(B) is strictly less than H. If H divides q, each R_i-R_r is an integer
multiple of H and therefore vanishes. Using R0=0 shows all R_i=0. Write
q=kH; then u_i=k*s_i, hence U_i=k*W_i and every w_i=0, a contradiction.
This uses the actual nonvanishing condition, not an assumed rank premise.

Now write q=kH+q0 with `0<q0<H` and set `u'_i=u_i-k*s_i`.
Both endpoints are retained, and

```text
q0*s_i-H*u'_i=R_i;
p'=H/q0>1; v'_i=R_i/q0; p'*u'_i+v'_i=s_i.
```

For any chosen r the signed relative row changes by U'_i=U_i-k*W_i.
Consequently

```text
(W_a+W_b)*U'_i-(U'_a+U'_b)*W_i = w_i.
```

Every collision coordinate, its nonvanishing, and c are exactly unchanged.
The normalized error is also unchanged:
`|v'_i-v'_r|/(2p')=|R_i-R_r|/(2H)=|v_i-v_r|/(2p)`.
Thus a valid packet at any q>0 would give a valid packet with q in 1..H-1
for the same actual tuple, chosen label, and collision pair. This is only
an auxiliary parameter reduction; the original count and height do not fall.
The argument does not require primitivity.

## The complete five-runner obstruction

Take N=5, H=4, s_i=i, r=0. This tuple is strictly increasing and primitive,
and H=4<=20^3=8000 is in the inclusive retained family. Since c>=1, any
valid packet must satisfy the weaker envelope

```text
|q*i-4*u_i| <= 8*(1/2-1/5)=12/5,            i=1,2,3.
```

The left side is integral, so it is at most 2. Folding restricts q to
1,2,3. For each internal i the exact possible integers lie in
`ceil((q*i-12/5)/4)..floor((q*i+12/5)/4)`. Explicitly:

| q | u1 | u2 | u3 |
| ---: | --- | --- | --- |
| 1 | 0 | 0 or 1 | 1 |
| 2 | 0 or 1 | 1 | 1 or 2 |
| 3 | 1 | 1 or 2 | 2 |

These are all eight rows; endpoints are always u0=0 and u4=q. Every row
has max_i |R_i|=2, so its normalized error about r=0 is exactly 1/4.
Since epsilon(2,5)=2/15 and epsilon(3,5)=1/20, success would require c=1.

The following literal certificate covers all six unordered comparison pairs.
An entry `Z` means some collision coordinate is zero; a numeric entry is
the exact cardinality c of the nonzero row's distinct absolute values.
The reproducer prints every full collision vector as well.

| q | (u1,u2,u3) | R=(R0,...,R4) | (1,2) | (1,3) | (1,4) | (2,3) | (2,4) | (3,4) |
| ---: | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | (0,0,1) | (0,1,2,-1,0) | Z | Z | 2 | 2 | 3 | 3 |
| 1 | (0,1,1) | (0,1,-2,-1,0) | Z | Z | 3 | 3 | Z | 3 |
| 2 | (0,1,1) | (0,2,0,2,0) | Z | 3 | 2 | 2 | Z | 3 |
| 2 | (0,1,2) | (0,2,0,-2,0) | 3 | Z | 3 | 3 | Z | 3 |
| 2 | (1,1,1) | (0,-2,0,2,0) | 3 | Z | 3 | 3 | Z | 3 |
| 2 | (1,1,2) | (0,-2,0,-2,0) | Z | 3 | 2 | 2 | Z | 3 |
| 3 | (1,1,2) | (0,-1,2,1,0) | Z | Z | 3 | 3 | Z | 3 |
| 3 | (1,2,2) | (0,-1,-2,1,0) | Z | Z | 2 | 2 | 3 | 3 |

For instance q=1,u=(0,0,0,1,1),pair(1,4) gives
`w=(-1,-2,2,1)`, c=2; its required budget 2/15 is less than the actual
error 1/4. Overall 18 pairs have a zero coordinate, eight have c=2, and
22 have c=3. No pair has c=1. Hence all 48 fail, exhausting every possible
q,u,pair by the envelope and folding proof. This also refutes the proposed
universal supply when a separate packet may be selected for every chosen r:
already the single label r=0 has no packet in this class.

Nevertheless t=1/5 gives every original signed difference k/5 with
1<=|k|<=4 norm at least 1/5. No original runner fails LRC. In particular,
no missing-packet argument may silently insert a minimal-counterexample
premise or treat this example as an actual counterexample.

## A fixed control that distinguishes the stronger condition

The adaptive criterion is genuinely broader than the old fixed budget.
For the literal tuple s=(0,1,2,7,8), chosen r=0, take
q=1,u=(0,0,0,1,1),p=8,v=(0,1,2,-1,0),pair(1,4). Then
`w=(-1,-2,2,1)`, c=2, and the error is 1/8: above the old 1/20 but below
the adaptive 2/15. D={1,2} has the explicit witness tau=1/3. The phase
construction gives x=1/3,y_raw=-1/3,y=5/3,j=13,t=5/3, with all four
original comparison norms equal to 1/3. This is one supplied fixture,
not another search or an all-chosen claim for that packet.

The valid conditional criterion survives. Its universal endpoint supply
does not. A complete F_N argument must handle primitive tuples outside
this class or justify a genuinely stronger transfer/supply condition;
neither packet absence nor unsupplied minimality closes that gap. No further
tuple search or extension was undertaken after the first exact obstruction.

## Reproduction and frozen inputs

Read prior packet manuscript
`research/astra-uniform-finite-supply-audit.md`, SHA-256
`ab8838edae5de0e1b08fabb72a091f141387ba84ecb37ce7c3465c992c5320f5`, and
accepted review `research/astra-uniform-finite-supply-review.md`, SHA-256
`2ca0787135fcb15220b4dedf8f7b77d79b0d7aee666880e63c69e43a5a8053de`.
Their fixed-budget obstruction explicitly did not cover this stronger
cardinality-dependent condition. Neither frozen file was edited.
Current `LowerCountSupply.lean` was read at SHA-256
`0705291adc53011fb72fc718a7260876512b092741442d6a6cceb4b76eb5ccf4`;
the existing signed witness and generic phase interfaces were also inspected.

The following complete program has only the declared eight-row candidate
domain, the single positive fixture, three fixed denominator lifts, and the
original consecutive witness checks. It uses exact integers and fractions.
The full program is also saved at `/tmp/astra-cardinality-adaptive-controls.py`.

```python
from fractions import Fraction as F
from itertools import product, combinations
from collections import Counter
import json

N,H,s,r=5,4,(0,1,2,3,4),0
radius=2*H*(F(1,2)-F(1,N))
assert radius==F(12,5)
pairs=list(combinations(range(1,N),2))
rows=[]
counts=Counter()

def ceil(x): return -((-x.numerator)//x.denominator)
def floor(x): return x.numerator//x.denominator
def collision(s,u,r,a,b):
    I=[i for i in range(len(s)) if i!=r]
    sigma={i:1 if s[i]>s[r] else -1 for i in I}
    W={i:abs(s[i]-s[r]) for i in I}
    U={i:sigma[i]*(u[i]-u[r]) for i in I}
    w=tuple((W[a]+W[b])*U[i]-(U[a]+U[b])*W[i] for i in I)
    return I,w

for q in range(1,H):
    intervals=[range(ceil(F(q*s[i]-radius,H)),floor(F(q*s[i]+radius,H))+1)
               for i in range(1,N-1)]
    for middle in product(*intervals):
        u=(0,)+middle+(q,)
        R=tuple(q*a-H*b for a,b in zip(s,u))
        assert all(abs(x)<=radius for x in R)
        error=max(map(abs,R))/F(2*H)
        assert error==F(1,4)
        certificates=[]
        for a,b in pairs:
            I,w=collision(s,u,r,a,b)
            assert w[I.index(a)]==-w[I.index(b)]
            counts['pair_tests']+=1
            if 0 in w:
                counts['zero_coordinate_rejections']+=1
                certificates.append([a,b,list(w),'zero'])
                continue
            c=len(set(map(abs,w)))
            assert 1<=c<=N-2
            epsilon=F(1,c+1)-F(1,N)
            assert error>epsilon
            counts['count_'+str(c)+'_budget_rejections']+=1
            certificates.append([a,b,list(w),c])
        rows.append(dict(q=q,u=u,R=R,error=str(error),pairs=certificates))
        counts['endpoint_rows']+=1

expected_tags=[
 ['zero','zero',2,2,3,3], ['zero','zero',3,3,'zero',3],
 ['zero',3,2,2,'zero',3], [3,'zero',3,3,'zero',3],
 [3,'zero',3,3,'zero',3], ['zero',3,2,2,'zero',3],
 ['zero','zero',3,3,'zero',3], ['zero','zero',2,2,3,3],
]
assert [[p[-1] for p in row['pairs']] for row in rows]==expected_tags
assert counts['endpoint_rows']==8 and counts['pair_tests']==48
assert not counts['count_1_budget_rejections']

# Literal positive fixture: adaptive succeeds while the old fixed budget fails.
sp,up,qp=(0,1,2,7,8),(0,0,0,1,1),1
np,hp=len(sp),sp[-1]
I,w=collision(sp,up,0,1,4)
assert w==(-1,-2,2,1)
cp=len(set(map(abs,w)))
assert cp==2
vp=tuple(F(qp*a-hp*b,qp) for a,b in zip(sp,up))
pp=F(hp,qp)
err=max(map(abs,vp))/(2*pp)
eps=F(1,cp+1)-F(1,np)
assert F(1,np*(np-1))<err==F(1,8)<=eps==F(2,15)
tau=F(1,3)
def norm(x):
    z=x%1
    return min(z,1-z)
assert all(norm(tau*z)>=F(1,cp+1) for z in w)
alpha,beta=-1,9
x=(alpha*pp+beta)*tau
y0=alpha*tau
y=y0-qp*floor(y0/qp)+qp
j=floor(pp*y-x+F(1,2))
t=(j+x)/pp
assert (x,y0,y,j,t)==(F(1,3),F(-1,3),F(5,3),13,F(5,3))
assert t>0 and abs(t-y)<=1/(2*pp)
assert all(norm(t*a)>=F(1,np) for a in sp[1:])
counts['adaptive_only_positive_fixture']=1

# Three fixed denominator lifts, both signs of actual relative comparisons.
for k in (0,1,3):
    ql=qp+k*hp
    ul=tuple(b+k*a for a,b in zip(sp,up))
    assert ql%hp==qp and tuple(b-k*a for a,b in zip(sp,ul))==up
    assert tuple(ql*a-hp*b for a,b in zip(sp,ul))==tuple(qp*a-hp*b for a,b in zip(sp,up))
    for rr in (0,2,4):
        for a,b in combinations([i for i in range(np) if i!=rr],2):
            ii,ww=collision(sp,up,rr,a,b)
            jj,zz=collision(sp,ul,rr,a,b)
            assert ii==jj and ww==zz
            for i in ii:
                assert abs(ql*(sp[i]-sp[rr])-hp*(ul[i]-ul[rr]))==abs(qp*(sp[i]-sp[rr])-hp*(up[i]-up[rr]))
                counts['folded_signed_error_checks']+=1
            counts['collision_fold_checks']+=1

assert 4<=20**3 and s[0]==0 and s[-1]==4
for rr in range(N):
    for i in range(N):
        if i!=rr:
            assert norm(F(s[i]-s[rr],N))>=F(1,N)
            counts['original_consecutive_witness_checks']+=1

print(json.dumps(dict(counts=dict(sorted(counts.items())),rows=rows),sort_keys=True))
```


Reproduce the frozen block from the repository root without any Lean cache:

```bash
python3 -B - <<'ADAPTIVE_AFFINE_REPLAY'
from pathlib import Path
import re
p=Path('research/astra-cardinality-adaptive-affine-audit.md')
blocks=re.findall(r'^```python\n(.*?)^```[ \t]*$',p.read_text(),re.M|re.S)
assert len(blocks)==1
exec(compile(blocks[0],str(p),'exec'),{})
ADAPTIVE_AFFINE_REPLAY
```

Final exact replay passed, exit zero. The embedded program is byte-identical
to the saved temporary program, SHA-256
`6f1dfce71d07a231c2ccc29b5b8d0e1f32f820dee719a035831e518ba6f3b881`.
Its full single-line JSON, including every collision vector and the trailing
newline, is saved at `/tmp/astra-cardinality-adaptive-controls.json`, SHA-256
`54a091c697462cebc8b985ad581097471f9179ed1d14d670ace675084b98db9f`.
The embedded code is the durable reproducer; temporary files are conveniences.

```text
endpoint_rows=8; pair_tests=48; zero_coordinate_rejections=18;
count_2_budget_rejections=8; count_3_budget_rejections=22;
adaptive_only_positive_fixture=1;
collision_fold_checks=54; folded_signed_error_checks=216;
original_consecutive_witness_checks=20.
```

The 54 fold controls are exactly three supplied lifts k=0,1,3, three chosen
labels r=0,2,4 of the positive fixture, and six unordered comparison pairs;
they check algebraic invariance, not successful packets for those other
chosen labels. The program covers the literal eight-row certificate exactly.
No numerical tolerance, randomized input, tuple discovery, time search, or
unbounded process is used. No Lean/source, shared-state, Git, or cache change
was made. All owned commands have stopped. Separate independent mathematical
review remains required; this artifact does not resolve F_N or LRC.
