# Independent review of cardinality-adaptive endpoint transfer

2026-09-05. Requested route: GPT-6 Astra / xhigh, task
`/root/cluster_limit_review-adaptive-margin-review`, assignment checkpoint
`cdfe75237327e3cc87671de30ca579f3a6fb8612`. Runtime model and effort metadata
were not independently exposed. The current project configuration, workflow,
policy and state were read; `python3 -B scripts/validate_workflow.py` passed.
Research remains active and the unrestricted LRC goal remains unresolved.

**Disposition: accept the conditional adaptive transfer, universal denominator
folding for valid packets, and complete five-runner packet obstruction in the
frozen manuscript.** No substantive defect was found. This is an independent
mathematical manuscript review, not a new kernel-checked theorem or a proof of
finite-family supply. The frozen manuscript is
`research/astra-cardinality-adaptive-affine-audit.md`, SHA-256
`a71e55b71e6e6a8a7893c5b3523859d9e51255078c2b17de0ea5cb6b5439a101`.

One incidental sentence requires a precise qualification: “Adjacency of the
ratios is sufficient for nonvanishing” means **distinct adjacent ratio values**.
Equal adjacent entries give zero collision coordinates and are not sufficient.
For example the supplied positive fixture has equal ratios U1/W1=U2/W2=0;
its pair (1,2) is rejected. The theorem, folding proof, and complete certificate
all explicitly require every collision coordinate to be nonzero, so none of
those conclusions relies on the unqualified adjacency sentence. This was
reported to the parent, which retained the original manuscript freeze and
agreed to record the qualification here.

## Independent derivation and scope

Let I be the original comparison labels i distinct from the chosen r. There
are exactly N-1 such labels. Integer endpoint data give positive rational
p=H/q and v_i=(q s_i-H u_i)/q, with q positive and H at least N-1 at least 2.
For each i in I, multiplying the original relative speed, coefficient and
error by sign(s_i-s_r) gives W_i>0, U_i in the integers and V_i rational, with
W_i=p U_i+V_i. This sign change does not merge or discard comparison labels.

For a distinct comparison pair a,b, set alpha=-(U_a+U_b), beta=W_a+W_b.
Then w_i=alpha W_i+beta U_i is integral and
w_a=W_b U_a-W_a U_b=-w_b. Under the explicit nowhere-zero assumption the
positive set D={|w_i|:i in I} is nonempty and has exact size c satisfying
1<=c<=N-2. The upper bound uses the repeated magnitude of two distinct labels;
it is not the size of the signed value set and not a freely chosen bound.
Enumerating this set invokes H_N at d=c. Its threshold is exactly 1/(c+1),
so the available loss is epsilon=1/(c+1)-1/N, which is positive. No premise
at N-1 moving runners or at the original N-runner problem is introduced.
The H_N witness time need not be positive: subsequent phase normalization
will supply a positive original time independently of its sign.

Set x=(alpha p+beta)t0 and y_raw=alpha t0. Direct substitution gives
U_i x+V_i y_raw=t0 w_i. This is an algebraic construction of simultaneous
phases; it does not assume their density on a torus, orbit compatibility,
or the original tuple's witness. In the integer endpoint setting t0 is the
H_N witness itself. If rational w is cleared by a positive integer L,
H_N applies to {|Lw_i|}, whose size remains c, and t0=L tau. Dividing tau by
L would give the wrong phase. This supplementary clearing statement is not
an extension of endpoint folding to arbitrary noninteger actual speeds.

Normalize y=y_raw-q floor(y_raw/q)+q. Then q<=y<2q and y-y_raw is an
integer multiple of q. Since q(v_i-v_r)=R_i-R_r is integral, every original
unsigned relative phase changes by an integer. This uses the actual common
period q; replacing q with 1 is invalid in general. Neither negative t0 nor
negative y_raw causes a problem, and x stays fixed.

For either nearest integer j to p y-x, define t=(j+x)/p. Rounding gives
|t-y|<=1/(2p). For each original comparison label, writing dU=u_i-u_r and
dV=v_i-v_r gives the exact identity

```text
(s_i-s_r)t = dU*j + (dU*x+dV*y) + dV*(t-y).
```

The first term is integral. Sign invariance and period normalization supply
margin 1/(c+1) in the middle term. The circle norm is 1-Lipschitz, so the
closed hypothesis |dV|/(2p)<=epsilon gives the closed target 1/N, including
both choices at rounding ties. Finally

```text
t >= y-1/(2p) >= q-1/(2p) = q*(1-1/(2H)) > 0.
```

This argument requires p>0, not p>1. It proves the chosen runner's positive
canonical witness for every positive integer q. It does not assert a common
time for different chosen runners, or that every tuple supplies a packet.
All comparison signs, including when r is the largest original label, are
accounted for before returning to the original signed differences.

## Universal folding within the exact packet class

The relative normalized error is precisely |R_i-R_r|/(2H), independent of q
once the residual row is fixed. Since c>=1, 2H epsilon<=H(1-2/N)<H. If H
were to divide q, each R_i-R_r would be a multiple of H with absolute value
less than H, hence zero. The comparison with index 0 and R0=0 force every
R_i=0. Writing q=kH then gives u_i=k s_i and U_i=k W_i, so w is identically
zero. This contradicts the explicit nonvanishing premise. No primitivity or
separate rank assumption is needed. Both nonvanishing and the error bound
are essential to this exclusion; the controls below test their omission.

Thus q=kH+q0 with 0<q0<H. For u'_i=u_i-k s_i, endpoints become 0 and q0,
residuals stay exactly R_i, and p'=H/q0>1, v'_i=R_i/q0 still reconstruct the
same actual s_i. Relative signed coefficients satisfy U'_i=U_i-k W_i.
Therefore alpha'=alpha+k beta and

```text
alpha'*W_i + beta*U'_i = alpha*W_i + beta*U_i.
```

The full collision row, not just its cardinality, is unchanged. The true c,
nonvanishing and each relative normalized error are preserved. Conversely,
adding any nonnegative integer k times the actual speed row lifts a folded
packet to q0+kH with the same invariants. Consequently existence over all
q>0 is equivalent to existence over 1<=q<H for this class. Neither the actual
height, the runner count, nor the chosen label descends. This gives no
reverse implication from packet absence to an actual counterexample.

## Independent complete certificate for N=5

The proof of completeness starts anew from the adaptive margin. For s_i=i,
H=4 and r=0, c>=1 implies |R_i|<=12/5. Since residuals are integral, all
lie in {-2,-1,0,1,2}. Folding gives q in {1,2,3}. The congruence R_i=q i
modulo 4 gives exactly these internal residual choices:

| q | R1 | R2 | R3 |
| --- | --- | --- | --- |
| 1 | 1 | -2 or 2 | -1 |
| 2 | -2 or 2 | 0 | -2 or 2 |
| 3 | -1 | -2 or 2 | 1 |

There are exactly eight rows; u_i=(q i-R_i)/4 uniquely reconstructs them.
Every row has maximum absolute residual 2, hence actual normalized error
1/4. The independent checker calculates collision coordinates directly as

```text
w_i = ((R_a+R_b)*i-(a+b)*R_i)/4,    i=1,2,3,4,
```

and separately verifies equality with the original U,W definition. This is
a residual-congruence enumeration, not the author's ceiling/floor interval
program. Sorted by q and the internal u row, the independently obtained tags
in pair order (1,2),(1,3),(1,4),(2,3),(2,4),(3,4) are:

| q | (u1,u2,u3) | Six tags |
| --- | --- | --- |
| 1 | (0,0,1) | Z Z 2 2 3 3 |
| 1 | (0,1,1) | Z Z 3 3 Z 3 |
| 2 | (0,1,1) | Z 3 2 2 Z 3 |
| 2 | (0,1,2) | 3 Z 3 3 Z 3 |
| 2 | (1,1,1) | 3 Z 3 3 Z 3 |
| 2 | (1,1,2) | Z 3 2 2 Z 3 |
| 3 | (1,1,2) | Z Z 3 3 Z 3 |
| 3 | (1,2,2) | Z Z 2 2 3 3 |

Z means a zero coordinate, which is forbidden even if other magnitudes look
favorable. All 48 possibilities are accounted for: 18 zero rejections, 8
with true c=2 and 22 with true c=3. Their allowed losses 2/15 and 1/20 are
both strictly smaller than 1/4. No c=1 row exists. Reversing the pair leaves
w unchanged; all diagonal pairs have a zero coordinate. Thus the certificate
covers every pair allowed by the manuscript, not just a selected adjacent
pair. The analytic envelope and folding proof cover every integer endpoint
row and every positive integer q, so the conclusion has no arbitrary search
cutoff. The prior fixed-budget obstruction is not used as its proof.

Already r=0 lacks an adaptive packet, so universal supply fails even if a
separate packet may be selected for each chosen runner. The original tuple
still has the positive time 1/5 for every runner: every nonzero signed
comparison is k/5 with 1<=|k|<=4. The checker verifies all 20 original
ordered comparisons, 10 exactly at 1/5. This primitive tuple lies in the
inclusive retained family since 4<=20^3=8000. These facts refute the proposed
packet supply only, not F_5, any other retained family, or LRC. No unsupplied
minimal-counterexample premise can change that scope.

## Source support and independent controls

The following exact source bodies were read and their hashes rechecked. No
Lean invocation was made and no kernel-checking result is asserted here.

| Source | SHA-256 |
| --- | --- |
| `LonelyRunner/LowerCountSupply.lean` | `0705291adc53011fb72fc718a7260876512b092741442d6a6cceb4b76eb5ccf4` |
| `LonelyRunner/AffinePhaseTransfer.lean` | `069d7f05229f517639284a58d9bb10f6fd6ee8d949efc3d377361424e7381776` |
| `LonelyRunner/AffinePhasePeriod.lean` | `340c4dd29276544566175cf791307ca42753ddc964345aa793d33abef1e9b176` |
| `LonelyRunner/SignedAffineWitness.lean` | `19018618fdb454ddbdb199a29db8672bd4729bf68052736133c1d708cc26f3e5` |
| `LonelyRunner/PositiveAffineWitness.lean` | `ed9e66d5a8944f3b5862be66f96c30abe7829c063e866504ca9e9ac1989e2e03` |

`LowerCountPositiveIntegerHypothesis N` explicitly supplies nonempty,
injective positive natural-speed rows at d<=N-2 and their own threshold
1/(d+1). Its rational adapter retains that threshold and multiplies time by
the common denominator. `exists_lowerCount_rational_collision` instead
returns only 1/(N-1); calling that theorem alone would lose the improvement.
`exists_affinePhaseTransfer` has a general margin/loss and requires p>0 and
y>1/(2p), both supplied above. `exists_normalized_affine_second_phase` needs
only a positive common period and preserves every coordinate's norm. The
signed and positive witness wrappers retain their explicit fixed loss
1/[N(N-1)] and p>1. They do not themselves formalize the present adaptive
claim. The manuscript correctly distinguishes these interfaces.

The supplied positive fixture (0,1,2,7,8), q=1, u=(0,0,0,1,1), r=0,
pair (1,4) gives w=(-1,-2,2,1), c=2, error 1/8, strictly above the old
1/20 but below 2/15. The independent calculation obtains x=1/3,
y_raw=-1/3, y=5/3, j=13, t=5/3; all four original norms are 1/3.
It therefore checks the actual transfer, not just the adaptive inequality.

A second fixed control is derived directly by choosing N=3, s=(0,2,3),
u=(0,1,1), q=1 and its only comparison pair. Then w=(1,-1), c=1,
error=epsilon=1/6, tau=1/2, x=-1/2 and y=1. The nearest-integer argument
has the exact tie p y-x=7/2. Both j=3 and j=4 give valid positive times,
5/6 and 7/6. Their two norms are 1/3 and 1/2. This verifies closed error,
closed target and both tie choices simultaneously, without tuple discovery.

The full fixed control domain is precisely the two foregoing analytic
fixtures, scales 1 and 2, optional reflection about the height with reversed
labels, denominator lifts k in {0,2,5}, and three supplied signed lower-count
times. For the five-runner fixture their multipliers are {-1,1,2}/(3*scale);
for the three-runner fixture {-1,1,3}/(2*scale). Reflection transports the
chosen endpoint and comparison pair explicitly. Scaling provides nonprimitive
instances. These are algebraic controls, not searches for new tuples or
witness times. They yield 72 valid packets and 108 rounded times, including
36 tie packets, 36 exact-budget packets, 48 packets with p<1, 24 negative
lower-count times, and 36 packets with negative original relative speeds.
There are 216 period/sign checks, 288 actual signed comparisons and 72
closed target equalities.

For both base fixtures, scales {1,2}, lifts {0,2,5}, all original chosen
labels and all unordered pairs give 198 fold identities and 756 relative
error identities, including invalid packets. Separately, the five-runner
fixture at scales {1,2}, q=kH for k in {1,4}, chosen r in {0,2,4}, and
all six pairs gives 72 zero-error but zero-collision invalid-premise controls.
The fixed perturbation u=(0,3,4,14,16), q=16 has a nonzero collision at
H|q but error 1/2, showing why the budget cannot be omitted. Single controls
also reject the wrong period, reversed clearing direction, an invented
c=1, and equal adjacent ratios. These controls are sanity checks supporting
the written universal derivations; finite computation does not replace those
derivations or supply H_N in arbitrary dimensions.

## Complete reproducer and execution record

The sole Python block below is the complete independent program. It asserts
all six frozen input hashes and uses only exact integers and `Fraction`.
It prints every residual row and collision vector, representative transfers,
and all counts as deterministic JSON. It neither reads nor executes the
author's checker. The temporary copy is
`/tmp/astra-adaptive-independent-review.py` (10,566 bytes), SHA-256
`4ef3ba962d0ece40f79f13dc8df9d81fdfbcf6a46996ee90f0cd240c6c67ac2d`.
The complete output, including its newline, is
`/tmp/astra-adaptive-independent-review.json` (3,424 bytes), SHA-256
`a33c35ae3a0c2740619027a36461cebc059bd3f44ed003b9946fcf578676ccc6`.
The embedded block is the durable evidence; temporary paths are conveniences.

```python
from collections import Counter
from fractions import Fraction as Q
from hashlib import sha256
from itertools import combinations, product
import json
from pathlib import Path

ROOT = Path('/home/joshua/lonely-runner-formalization')
FROZEN = {
    'research/astra-cardinality-adaptive-affine-audit.md': 'a71e55b71e6e6a8a7893c5b3523859d9e51255078c2b17de0ea5cb6b5439a101',
    'LonelyRunner/LowerCountSupply.lean': '0705291adc53011fb72fc718a7260876512b092741442d6a6cceb4b76eb5ccf4',
    'LonelyRunner/AffinePhaseTransfer.lean': '069d7f05229f517639284a58d9bb10f6fd6ee8d949efc3d377361424e7381776',
    'LonelyRunner/AffinePhasePeriod.lean': '340c4dd29276544566175cf791307ca42753ddc964345aa793d33abef1e9b176',
    'LonelyRunner/SignedAffineWitness.lean': '19018618fdb454ddbdb199a29db8672bd4729bf68052736133c1d708cc26f3e5',
    'LonelyRunner/PositiveAffineWitness.lean': 'ed9e66d5a8944f3b5862be66f96c30abe7829c063e866504ca9e9ac1989e2e03',
}
for name, digest in FROZEN.items():
    assert sha256((ROOT / name).read_bytes()).hexdigest() == digest, name

counts = Counter()
def floor(z):
    z = Q(z)
    return z.numerator // z.denominator
def norm(z):
    z = Q(z) - floor(z)
    return min(z, 1-z)
def nearest(z):
    lo = floor(z)
    return tuple(j for j in (lo, lo+1) if abs(z-j) <= Q(1,2))
def eps(n,c):
    return Q(1,c+1) - Q(1,n)
def packet(s,u,q,r,a,b):
    n,h = len(s),s[-1]
    assert n >= 3 and s[0] == 0 and all(s[i] < s[i+1] for i in range(n-1))
    assert isinstance(q,int) and q>0 and u[0]==0 and u[-1]==q
    assert all(isinstance(z,int) for z in s+u)
    ix = tuple(i for i in range(n) if i != r)
    assert a in ix and b in ix
    residual = tuple(q*s[i]-h*u[i] for i in range(n))
    sign = {i: 1 if i>r else -1 for i in ix}
    wabs = {i: abs(s[i]-s[r]) for i in ix}
    coeff = {i: sign[i]*(u[i]-u[r]) for i in ix}
    alpha,beta = -(coeff[a]+coeff[b]), wabs[a]+wabs[b]
    w = tuple(alpha*wabs[i]+beta*coeff[i] for i in ix)
    rho = {i: sign[i]*(residual[i]-residual[r]) for i in ix}
    # Independent residual determinant, valid with either sign of s_i-s_r.
    wr = tuple(Q((rho[a]+rho[b])*wabs[i]-beta*rho[i],h) for i in ix)
    assert w == wr and w[ix.index(a)] == -w[ix.index(b)]
    c = len(set(map(abs,w))) if all(w) else None
    if c is not None:
        assert 1 <= c <= n-2
    p = Q(h,q)
    v = tuple(Q(z,q) for z in residual)
    error = max(abs(z-residual[r]) for z in residual) / Q(2*h)
    assert error == max(abs(z-v[r]) for z in v)/(2*p)
    return ix,residual,w,c,alpha,beta,p,v,error

# Complete finite certificate: enumerate residues, not rounded u intervals.
s = (0,1,2,3,4)
rows = []
for q in (1,2,3):
    options = [tuple(z for z in (-2,-1,0,1,2) if (z-q*i)%4==0) for i in (1,2,3)]
    for mid in product(*options):
        residual = (0,)+mid+(0,)
        u = tuple((q*i-residual[i])//4 for i in range(5))
        assert all(q*i-4*u[i]==residual[i] for i in range(5))
        row = {'q':q,'u':u,'residual':residual,'pairs':[]}
        assert max(map(abs,residual))==2
        for a,b in combinations((1,2,3,4),2):
            # Compute the certificate directly from residuals first.
            raw = tuple((residual[a]+residual[b])*i-(a+b)*residual[i] for i in (1,2,3,4))
            assert all(z%4==0 for z in raw)
            w = tuple(z//4 for z in raw)
            data = packet(s,u,q,0,a,b)
            assert w==data[2] and data[8]==Q(1,4)
            c = data[3]
            assert c is None or Q(1,4)>eps(5,c)
            tag = 'Z' if c is None else c
            counts['certificate_pairs']+=1
            counts['zero_rows' if c is None else 'count_'+str(c)+'_rejections']+=1
            assert packet(s,u,q,0,b,a)[2]==w
            counts['reversed_pair_identities']+=1
            row['pairs'].append([a,b,w,tag])
        for a in (1,2,3,4):
            assert packet(s,u,q,0,a,a)[2][a-1]==0
            counts['diagonal_pair_rejections']+=1
        rows.append(row)
rows.sort(key=lambda x:(x['q'],x['u']))
expected = [
    ['Z','Z',2,2,3,3], ['Z','Z',3,3,'Z',3],
    ['Z',3,2,2,'Z',3], [3,'Z',3,3,'Z',3],
    [3,'Z',3,3,'Z',3], ['Z',3,2,2,'Z',3],
    ['Z','Z',3,3,'Z',3], ['Z','Z',2,2,3,3],
]
assert [[p[-1] for p in row['pairs']] for row in rows]==expected
assert len(rows)==8 and counts['certificate_pairs']==48
assert (counts['zero_rows'],counts['count_2_rejections'],counts['count_3_rejections'])==(18,8,22)
counts['certificate_endpoint_rows']=len(rows)
# Arbitrarily declaring c=1 would give a false acceptance for a genuine c=2 row.
assert Q(1,4) <= eps(5,1) and Q(1,4) > eps(5,2)
counts['incorrect_cardinality_control']=1

# Two fixed analytic controls. The second puts both the budget and target
# boundary at equality, obtained by the three-runner choice (0,2,3), u=(0,1,1).
BASE = (
    ((0,1,2,7,8),(0,0,0,1,1),(1,4),3,'adaptive_only'),
    ((0,2,3),(0,1,1),(1,2),2,'closed_boundary'),
)
records=[]
for base_s,base_u,pair,den,label in BASE:
    for scale,reflect,k,mult in product((1,2),(False,True),(0,2,5),(-1,1,3) if den==2 else (-1,1,2)):
        ss=tuple(scale*z for z in base_s)
        uu=base_u
        aa,bb=pair
        rr=0
        if reflect:
            ss=tuple(ss[-1]-z for z in reversed(ss))
            uu=tuple(1-z for z in reversed(uu))
            rr=len(ss)-1
            aa,bb=len(ss)-1-aa,len(ss)-1-bb
        h,n=ss[-1],len(ss)
        q=1+k*h
        uu=tuple(uu[i]+k*ss[i] for i in range(n))
        tau=Q(mult,den*scale)
        ix,res,w,c,alpha,beta,p,v,error=packet(ss,uu,q,rr,aa,bb)
        assert c is not None and error<=eps(n,c)
        margin=Q(1,c+1)
        assert all(norm(tau*z)>=margin for z in w)
        if label=='adaptive_only':
            assert c==2 and Q(1,n*(n-1))<error==Q(1,8)
        else:
            assert error==eps(n,c)==Q(1,6)
            counts['closed_budget_packets']+=1
        x=(alpha*p+beta)*tau
        yraw=alpha*tau
        y=yraw-q*floor(yraw/q)+q
        assert q<=y<2*q and q-Q(1,2*p)>0
        z=p*y-x
        js=nearest(z)
        assert js
        for i,wi in zip(ix,w):
            old=(uu[i]-uu[rr])*x+(v[i]-v[rr])*yraw
            new=(uu[i]-uu[rr])*x+(v[i]-v[rr])*y
            assert (new-old).denominator==1
            assert norm(old)==norm(tau*wi)==norm(new)
            counts['period_and_sign_checks']+=1
        counts['packet_instances']+=1
        counts['negative_tau_instances']+=int(tau<0)
        counts['p_below_one_instances']+=int(p<1)
        counts['negative_relative_packet_instances']+=int(reflect)
        counts['nonprimitive_packet_instances']+=int(scale==2)
        counts['nearest_tie_packets']+=int(len(js)==2)
        for j in js:
            t=(j+x)/p
            assert t>=q*(1-Q(1,2*h))>0 and abs(t-y)<=Q(1,2*p)
            for i in ix:
                basephase=(uu[i]-uu[rr])*x+(v[i]-v[rr])*y
                perturb=(v[i]-v[rr])*(t-y)
                actual=(ss[i]-ss[rr])*t
                assert actual==(uu[i]-uu[rr])*j+basephase+perturb
                assert abs(perturb)<=error<=eps(n,c)
                assert norm(actual)>=norm(basephase)-abs(perturb)>=Q(1,n)
                counts['actual_signed_comparisons']+=1
                counts['closed_target_equalities']+=int(norm(actual)==Q(1,n))
            counts['transported_times']+=1
            if scale==1 and not reflect and k==0 and mult==1:
                records.append(dict(label=label,q=q,w=w,c=c,error=str(error),tau=str(tau),x=str(x),yraw=str(yraw),y=str(y),j=j,t=str(t),norms=[str(norm((ss[i]-ss[rr])*t)) for i in ix]))
assert counts['closed_target_equalities']>0 and counts['nearest_tie_packets']>0
assert counts['p_below_one_instances']>0

# All chosen labels and every pair, including invalid packets: exact folding
# identities use neither primitiveness nor a favorable collision/budget.
for bs,bu,pair,den,label in BASE:
    for scale,k in product((1,2),(0,2,5)):
        ss=tuple(scale*z for z in bs)
        h,n=ss[-1],len(ss)
        q=1+k*h
        uu=tuple(bu[i]+k*ss[i] for i in range(n))
        assert q%h==1 and tuple(uu[i]-k*ss[i] for i in range(n))==bu
        for r in range(n):
            for a,b in combinations([i for i in range(n) if i!=r],2):
                old=packet(ss,bu,1,r,a,b)
                lifted=packet(ss,uu,q,r,a,b)
                assert old[1:4]==lifted[1:4] and old[8]==lifted[8]
                counts['all_chosen_fold_pairs']+=1
                for i in old[0]:
                    assert Q(abs(lifted[1][i]-lifted[1][r]),2*h)==Q(abs(old[1][i]-old[1][r]),2*h)
                    counts['fold_relative_errors']+=1

# H divides q: dropping nonvanishing leaves zero-error rank-one packets.
bs=(0,1,2,7,8)
for scale,k in product((1,2),(1,4)):
    ss=tuple(scale*z for z in bs)
    h=ss[-1]
    q=k*h
    uu=tuple(k*z for z in ss)
    for r in (0,2,4):
        for a,b in combinations([i for i in range(5) if i!=r],2):
            data=packet(ss,uu,q,r,a,b)
            assert data[1]==(0,)*5 and data[2]==(0,)*4 and data[3] is None and data[8]==0
            counts['missing_nonzero_controls']+=1
# Dropping the budget admits a nonzero collision even when H divides q.
u_bad=(0,3,4,14,16)
bad=packet(bs,u_bad,16,0,1,4)
assert bad[2]==(8,-2,-7,-8) and bad[3]==3 and bad[8]==Q(1,2)>eps(5,3)
counts['missing_budget_control']=1

# A q-period is required: period one changes the supplied phase margin.
ul=tuple(b+2*a for a,b in zip(bs,(0,0,0,1,1)))
ix,res,w,c,alpha,beta,p,v,error=packet(bs,ul,17,0,1,4)
tau=Q(1,3)
x=(alpha*p+beta)*tau
yraw=alpha*tau
y_wrong=yraw-floor(yraw)+1
i=1
assert norm((ul[i]-ul[0])*x+(v[i]-v[0])*yraw)==Q(1,3)
assert norm((ul[i]-ul[0])*x+(v[i]-v[0])*y_wrong)==Q(7,51)<Q(1,3)
counts['wrong_period_control']=1

# Rational magnitude clearing multiplies the witness time by L.
wrat=tuple(Q(z,3) for z in (-1,-2,2,1))
L,tau=3,Q(1,3)
assert len(set(abs(L*z) for z in wrat))==2
assert all(norm((L*tau)*z)>=Q(1,3) for z in wrat)
assert any(norm((tau/L)*z)<Q(1,3) for z in wrat)
counts['clearing_direction_control']=1

# Equal adjacent ratios are not sufficient: the nowhere-zero premise rejects.
s_eq,u_eq=(0,1,2,7,8),(0,0,0,1,1)
assert Q(u_eq[1],s_eq[1])==Q(u_eq[2],s_eq[2])==0
assert packet(s_eq,u_eq,1,0,1,2)[3] is None
counts['equal_adjacent_ratio_control']=1

for r,i in product(range(5),repeat=2):
    if i!=r:
        d=norm(Q(i-r,5))
        assert d>=Q(1,5)
        counts['original_witness_comparisons']+=1
        counts['original_witness_equalities']+=int(d==Q(1,5))
assert 4 <= 20**3
print(json.dumps({'counts':dict(sorted(counts.items())),'certificate':rows,'representative_transfers':records,'frozen':FROZEN},sort_keys=True,separators=(',',':')))
```

The first exact execution was:

```bash
python3 -B /tmp/astra-adaptive-independent-review.py > /tmp/astra-adaptive-independent-review.json
```

It passed on its first run with exit code 0. After embedding, this independent
replay also passed with exit code 0:

```bash
python3 -B - <<'PY' > /tmp/astra-adaptive-independent-review-replay.json
from pathlib import Path
from hashlib import sha256
import re
p=Path('research/astra-cardinality-adaptive-affine-review.md')
blocks=re.findall(r'^```python\n(.*?)^```[ \t]*$',p.read_text(),re.M|re.S)
assert len(blocks)==1
assert sha256(blocks[0].encode()).hexdigest()=='4ef3ba962d0ece40f79f13dc8df9d81fdfbcf6a46996ee90f0cd240c6c67ac2d'
exec(compile(blocks[0],str(p),'exec'),{})
PY
```

The replay JSON has the same 3,424 bytes and output hash stated above. The
full exact counts are:

```text
actual_signed_comparisons=288; all_chosen_fold_pairs=198;
certificate_endpoint_rows=8; certificate_pairs=48;
clearing_direction_control=1; closed_budget_packets=36;
closed_target_equalities=72; count_2_rejections=8; count_3_rejections=22;
diagonal_pair_rejections=32; equal_adjacent_ratio_control=1;
fold_relative_errors=756; incorrect_cardinality_control=1;
missing_budget_control=1; missing_nonzero_controls=72;
nearest_tie_packets=36; negative_relative_packet_instances=36;
negative_tau_instances=24; nonprimitive_packet_instances=36;
original_witness_comparisons=20; original_witness_equalities=10;
p_below_one_instances=48; packet_instances=72;
period_and_sign_checks=216; reversed_pair_identities=48;
transported_times=108; wrong_period_control=1; zero_rows=18.
```

Other commands were read-only configuration/state/manuscript/source reads,
SHA-256 and JSON inspection, and workflow validation; the latter passed on
startup and after context recovery. The only repository file written was this
review. Small temporary prose, program and exact-output files were created
under `/tmp`. There were no failed mathematical assertions or stopped searches.
No dependency restoration, Lean invocation, Git mutation, source edit, state
edit, cache operation, external research, or new tuple search was performed.
The shared `.lake` directory was absent. All owned command processes completed
before the final freeze; none remains running. The review's final SHA-256 is
reported externally to avoid a self-referential digest.

The accepted result is exactly the conditional transfer and failure of its
universal endpoint-packet supply at the supplied five-runner tuple, with the
distinct-adjacent-values qualification stated above. H_N remains an explicit
premise, inclusive finite-family supply remains unsolved, and this review
makes no novelty or unrestricted LRC completion claim.
