# Exact rounding: free-time equivalence and a retained-margin obstruction

2026-09-05. Requested Astra xhigh semantic task
`/root/endpoint_label_audit-exact-rounding-scope`, checkpoint
`cdfe75237327e3cc87671de30ca579f3a6fb8612`. Runtime model/effort metadata is
not independently attested. Current project configuration, workflow, policy,
and state were read; `python3 -B scripts/validate_workflow.py` passed. Research
is active; canonical completion remains null. Only this manuscript and small
temporary deterministic controls were written. No Lean/source, state, Git,
build, or cache changes were made.

**Disposition: three manuscript results, pending independent review.** The
exact rounding improvement is valid. With collision time freely selected to
satisfy the resulting inequalities, endpoint-packet existence is equivalent
to ordinary witness existence; zero-rounding packets already suffice for that
equivalence. Keeping the stronger own-count collision margin is a different
contract. That standalone universal supply claim is **false**, even with exact
rounding, for `N=4, s=(0,1,2,3), r=0`. This is an obstruction to the method,
not to LRC or to a disjunction with existing witness methods. No new uniform
finite-family supply or unrestricted resolution is proved.

## Frozen inputs and notation

| Input | SHA-256 |
| --- | --- |
| `research/astra-cardinality-adaptive-affine-audit.md` | `a71e55b71e6e6a8a7893c5b3523859d9e51255078c2b17de0ea5cb6b5439a101` |
| `docs/round6-strategies.md` | `962fbce708f3c21ca4c2d745b2ebe789c48fc1081520d763447809dcd4d287e9` |
| `LonelyRunner/AffinePhaseTransfer.lean` | `069d7f05229f517639284a58d9bb10f6fd6ee8d949efc3d377361424e7381776` |
| `LonelyRunner/AffinePhasePeriod.lean` | `340c4dd29276544566175cf791307ca42753ddc964345aa793d33abef1e9b176` |
| `LonelyRunner/LowerCountSupply.lean` | `0705291adc53011fb72fc718a7260876512b092741442d6a6cceb4b76eb5ccf4` |

The adaptive manuscript was treated as a proposed derivation under separate
review. The identities needed here are derived below rather than assumed
from its status. The historical round-6 note's **section 2** supplies the
pair-sum argument; it explicitly describes that theorem as a paper proof.
No Lean pair-sum completeness theorem is assumed. Historical statements in
other sections about then-unfinished global reductions are not current status
claims. No external literature or novelty claim is needed.

Fix `N>=3` and actual sorted integer labels
`0=s0<...<s_(N-1)=H`. Fix one original chosen label `r`. An endpoint packet
has integer `q>0`, integer `u`, `u0=0`, `u_last=q`, `p=H/q>0`, and
`v_i=s_i-p*u_i`, so both endpoint residuals vanish. For each comparison
label `i!=r`, define

```text
sigma_i=sign(s_i-s_r),  W_i=|s_i-s_r|>0,
U_i=sigma_i*(u_i-u_r),  V_i=sigma_i*(v_i-v_r).
```

Thus `W_i=p*U_i+V_i`, and `q*V_i` is integral. The positive magnitudes `W_i`
may repeat; original labels are not deduplicated. Choose distinct comparison
labels `a,b` and put

```text
beta=W_a+W_b>0, alpha=-(U_a+U_b),
w_i=beta*U_i+alpha*W_i,
c=card { |w_i| : i!=r }.
```

All `W_i,U_i,w_i,alpha,beta` are integers. Require every `w_i!=0`.
Since `w_a=-w_b`, the actual collision count satisfies `1<=c<=N-2`.
Pairs in the proofs are **label pairs**; speed-pair notation in supplied
examples is identified explicitly below.

## Exact rounding identity and conditional transfer

For arbitrary real `tau`, set

```text
x=(alpha*p+beta)*tau, y0=alpha*tau,
n=1-floor(y0/q), y=y0+q*n, D=p*y-x,
j any nearest integer to D, t=(j+x)/p.
```

Then `q<=y<2q`. The key exact equality is

```text
D=H*n-beta*tau,
|t-y|=|j-D|/p=||beta*tau||/p.                         (1)
```

Indeed `p*q=H` is an integer. Integer translation and sign reversal preserve
circle norm; a nearest representative has absolute value at most `1/2`, so
its absolute value is exactly that norm. Equation (1) holds for either nearest
integer at a tie. It applies to negative, zero, or positive `y0`, without
changing period `q` to period one. Also

```text
t >= q-1/(2p) = q*(1-1/(2H)) > 0,
```

because `H>=N-1>=2`. There is no additional requirement `p>1`.

The signed comparison identity is

```text
w_i*tau = U_i*x+V_i*y0,
W_i*t = U_i*j + (U_i*x+V_i*y) + V_i*(t-y).
```

Both `U_i*j` and `V_i*(y-y0)=q*V_i*n` are integers. The circle norm is
1-Lipschitz, hence the original comparison at the single time `t` obeys

```text
||(s_i-s_r)*t||
  >= ||w_i*tau|| - (|v_i-v_r|/p)*||beta*tau||.        (2)
```

Consequently these **free exact-loss inequalities** suffice for a positive
canonical witness:

```text
||w_i*tau|| - (|v_i-v_r|/p)*||beta*tau|| >= 1/N
for every i!=r.                                      (E)
```

The coefficient may equivalently be written `|R_i-R_r|/H`, with
`R_i=q*s_i-H*u_i`. No bound on `tau`, approximation error, or actual height
was used to prove (1)-(2). This is a manuscript refinement of the generic
metric transfer; the existing Lean wrapper is not claimed to state (1).

## Free time and retained own-count time are different contracts

Let `E_r` mean that some endpoint packet, comparison pair, and real `tau`
satisfy (E), with nowhere-zero collision. Let `S_r` additionally require

```text
||w_i*tau|| >= 1/(c+1) for every i!=r.                (C)
```

The lower-count hypothesis `H_N` supplies a time satisfying (C) for each
fixed nowhere-zero collision magnitude set, because its actual count is
`c<=N-2`. It does **not** say that such a time also satisfies (E).
Conversely, a free time satisfying (E) need not satisfy (C). Removing (C)
changes the retained-induction method; it cannot be silently removed and
then used to label that stronger method an equivalent restatement.

Always `S_r => E_r =>` an original witness. The next equivalence concerns
`E_r`, and does not use `H_N` or claim the same equivalence for `S_r`.

## Zero-rounding packets already give free-time completeness

If `beta*tau=k` is integral, (1) gives `t=y`, and

```text
t == alpha*tau (mod Z),
w_i*tau == alpha*W_i*tau (mod Z).                    (3)
```

Here `y-y0=q*n` is an integer because `q` is an integer. Thus in the
zero-rounding subclass (E) is just the original set of inequalities at
`alpha*tau` modulo one. This observation alone does not supply a packet.
The following construction does supply it **from an existing pair-sum
witness**, preserving all endpoints and original labels.

Suppose `T=k0/beta`, `0<T<1`, is an actual witness for original runner `r`,
where `beta=W_a+W_b` for distinct comparison labels `a,b`. Set

```text
q=1, u_j=0 if j<=min(a,b), and u_j=1 otherwise.
```

The tuple is sorted, so this binary cut has `u0=0`, `u_last=1`, and

```text
U_i = sigma_i*(u_i-u_r) = |u_i-u_r| in {0,1}.
```

The cut separates `a,b`. Exactly one of their binary values differs from
`u_r`, giving `U_a+U_b=1`. Therefore `alpha=-1` and
`gcd(alpha,beta)=1`. This is valid for stationary `r=0`, for `r=last`, and
for an internal original runner with comparisons of both signs.

Now `w_i=beta*U_i-W_i`. It cannot be zero when `U_i=0`, since `W_i>0`.
When `U_i=1`, vanishing would require `W_i=beta`, but then
`W_i*T=k0` would be integral, contradicting the supplied positive `1/N`
margin. Hence the collision is nowhere zero and `1<=c<=N-2`.
If a rank-two condition on the absolute rows `u,v` is additionally retained,
this construction supplies it too: an internal speed strictly between `0,H`
has `v_i=s_i-H*u_i!=0`, while the last coordinate is `(u,v)=(1,0)`.

Take `tau=-T`. Then

```text
beta*tau=-k0, y0=T, y=T+1,
x=(H-beta)*T, D=j=H+k0, t=T+1,
w_i*tau=W_i*T-k0*U_i.
```

These identities prove zero rounding and exactly preserve the original
circle norms. The returned time is positive and differs by an integer
from the supplied witness. No time is borrowed from a different runner,
no labels are lost, and no lower-count witness is assumed in this encoding.
It guarantees (E), but only gives collision margin `>=1/N`; it does not
in general give (C).

For completeness, the needed pair-sum result has the following elementary
paper proof, with precisely the hypotheses used here. For at least two
positive integer comparison speeds `W_i`, including possible repetitions,
`F(T)=min_i ||W_i*T||` has a maximum on the period-one circle. A sufficiently
small positive time makes all its terms positive. If the maximum is `1/2`,
every comparison phase is half-integral, so the sum of any two is integral.
Otherwise each active triangular wave at a maximizer has a nonzero local
slope `+W_i` or `-W_i`, and inactive waves retain strict slack nearby. Local
maximality forces active slopes of both signs. Two distinct active labels
then have phases `m+M` and `n+1-M`; their sum gives
`(W_a+W_b)*T` integral. Period reduction puts `0<T<1`; the endpoints would
have value zero. If an original witness exists, this maximizer has value at
least `1/N`, so it is a pair-sum witness of the required kind.

This independently checks the relevant round-6 paper argument without
assuming an unproved Lean declaration. It first proves, for a stationary
positive integer tuple with `N-1>=2` moving speeds,

```text
ordinary witness <=> pair-sum witness
                 <=> some free zero-rounding endpoint packet
                 <=> E_0.                            (4)
```

The binary-cut proof above also gives (4) pointwise for **each original
chosen label `r`** of the sorted tuple. Apply the same pair-sum argument to
`|s_i-s_r|`, retaining repeated magnitudes and all original comparisons.
Its denominator is then `|s_a-s_r|+|s_b-s_r|`, not generally `s_a+s_b`.
Packet choices and witness times may depend on `r`; no common time for all
chosen runners is asserted. This is not an unrestricted real-speed reduction.

## Retaining the own-count margin: a universal obstruction

There is an additional exact endpoint invariant for stationary `r=0`:

```text
U_last=q, V_last=0,
w_last=beta*q+alpha*H,
H*t=q*j+w_last*tau,
||H*t||=||w_last*tau||.                              (5)
```

This follows directly from `t=(j+x)/p` and `p*q=H`. It holds for every
integer `j`, not only nearest rounding, and all positive `q`. Therefore
(E) together with (C) forces an original canonical witness for which the
last speed has margin at least `1/(c+1)>=1/(N-1)`.

For `N=4, s=(0,1,2,3), r=0`, the exact closed witness set modulo one is
`{1/4,3/4}`. Here is a complete interval certificate, with no time sampling:

```text
G4(1) intersect G4(2) = [1/4,3/8] union [5/8,3/4],
G4(3) = [1/12,1/4] union [5/12,7/12] union [3/4,11/12].
```

Their intersection consists precisely of those two singleton endpoints.
At either time, `||3*t||=1/4`. But `c<=N-2=2`, so (5) and (C) would
require `||3*t||>=1/3>1/4`, a contradiction.

Thus **no** `q,u,pair,tau` can satisfy `S_0` for this tuple. There is no
unbounded-denominator remainder and no finite packet search behind this
conclusion. It leaves the conditional transfer (1)-(2) valid, and is
strictly about endpoint packets retaining the own-count margin. The tuple
is primitive, already has the explicit witness `1/4`, and lies well inside
the finite-height family (`H=3<=12^2`). It is covered by elementary existing
methods. This does not refute a disjunction with those methods, or any
claim restricted to a legitimately minimal counterexample that they exclude.

## Supplied fixtures and exact controls

The four-runner tuple `(0,1,3,4)` with `r=0`, `q=1`, `u=(0,0,1,1)`, and
speed pair `(1,4)` (label pair `(1,3)`) has

```text
p=4, v=(0,1,-1,0), alpha=-1, beta=5,
w=(-1,2,1), c=2, tau=1/3.
```

Its collision norms are all `1/3`, so (C) holds. Exact rounding has
`||beta*tau||=1/3`, `x=1/3`, `y=5/3`, `j=6`, `t=19/12`, and
`|t-y|=1/12`. The three lower bounds in (E) are `(1/4,1/4,1/3)`;
the actual original norms are `(5/12,1/4,1/3)`. The worst-case loss `1/8`
would exceed the available slack `1/3-1/4=1/12`. This is a genuine
positive example of the strengthened conditional criterion.

For `(0,1,2,3,4)`, `r=0`, `q=1`, `u=(0,0,0,1,1)`, pair `(1,4)`, we have
`alpha=-1`, `beta=5`, `w=(-1,-2,2,1)`, `c=2`. At `tau=1/5`, zero rounding
returns `t=9/5` and the collision margin is only `1/5`, so (E) holds and
(C) fails. For this fixed packet, **every** time satisfying (C) is congruent
to `1/3` or `2/3` modulo one: intersecting `||tau||>=1/3` with
`||2*tau||>=1/3` gives exactly these two points. At either, the speed-two
lower bound is `1/3-(1/2)*(1/3)=1/6<1/5`, so (E) fails. This is a separate
fixed-packet observation; the universal obstruction above uses the four-runner
tuple and excludes all packets analytically.

The deterministic program below checks 14 rounding instances, 50 full phase
identities/inequalities, 11 endpoint equalities, both nearest-integer tie
choices, negative and zero raw phase, and a nonminimal period `q=5` with
`p=4/5`. Five explicitly supplied pair-sum witnesses on the consecutive
five-label tuple test the binary-cut encoding at each chosen label, including
both signs and repeated relative magnitudes. Exact closed-band intersections
verify the two complete interval certificates. No tuple, packet, denominator,
or witness discovery is performed. The program passed on its first run.

## Complete replay

Run the sole Python block below from the repository root. It first verifies
the five frozen input hashes. The source program has SHA-256
`574ed2179ecdbb72e6a87edba04b3de604b3e235dceece0a55fa4bf4fd6eee19`. Its full single-line JSON output, including the trailing
newline, has SHA-256 `b173bc182367da50400fa5407ed8ba97ad8aaf3f77fe4ba4eaa3c93821f95963`.

```python
from fractions import Fraction as F
from math import gcd
from collections import Counter
from hashlib import sha256
from pathlib import Path
import json

bindings={
 'research/astra-cardinality-adaptive-affine-audit.md':'a71e55b71e6e6a8a7893c5b3523859d9e51255078c2b17de0ea5cb6b5439a101',
 'docs/round6-strategies.md':'962fbce708f3c21ca4c2d745b2ebe789c48fc1081520d763447809dcd4d287e9',
 'LonelyRunner/AffinePhaseTransfer.lean':'069d7f05229f517639284a58d9bb10f6fd6ee8d949efc3d377361424e7381776',
 'LonelyRunner/AffinePhasePeriod.lean':'340c4dd29276544566175cf791307ca42753ddc964345aa793d33abef1e9b176',
 'LonelyRunner/LowerCountSupply.lean':'0705291adc53011fb72fc718a7260876512b092741442d6a6cceb4b76eb5ccf4',
}
for path,wanted in bindings.items():
    assert sha256(Path(path).read_bytes()).hexdigest()==wanted,path
counts=Counter()
records=[]
def norm(x):
    f=F(x)%1
    return min(f,1-f)
def floor(x): return x.numerator//x.denominator

def inspect(name,s,q,u,r,pair,tau,tie_lower=False):
    N,H=len(s),s[-1]
    assert N>=3 and s[0]==u[0]==0 and u[-1]==q>0
    assert all(a<b for a,b in zip(s,s[1:]))
    p=F(H,q); tau=F(tau)
    v=[F(a)-p*b for a,b in zip(s,u)]
    I=[i for i in range(N) if i!=r]
    sigma={i:1 if s[i]>s[r] else -1 for i in I}
    W={i:abs(s[i]-s[r]) for i in I}
    U={i:sigma[i]*(u[i]-u[r]) for i in I}
    V={i:sigma[i]*(v[i]-v[r]) for i in I}
    a,b=pair
    assert a!=b and a in I and b in I
    beta=W[a]+W[b]; alpha=-(U[a]+U[b])
    w={i:beta*U[i]+alpha*W[i] for i in I}
    assert all(w.values()) and w[a]==-w[b]
    c=len({abs(z) for z in w.values()})
    assert 1<=c<=N-2
    x=(alpha*p+beta)*tau; y0=alpha*tau
    n=1-floor(y0/q); y=y0+q*n
    D=p*y-x; d=norm(beta*tau)
    assert q<=y<2*q and D==H*n-beta*tau
    j=floor(D+F(1,2))
    if tie_lower:
        assert d==F(1,2)
        j-=1
    assert abs(D-j)==d
    t=(j+x)/p
    assert abs(t-y)==d/p and t>=q-F(1,2)/p>0
    L={i:norm(w[i]*tau)-abs(V[i])*d/p for i in I}
    free=all(z>=F(1,N) for z in L.values())
    own=all(norm(w[i]*tau)>=F(1,c+1) for i in I)
    for i in I:
        assert W[i]==p*U[i]+V[i]
        assert (q*V[i]).denominator==1
        assert V[i]*(y-y0)==q*V[i]*n
        assert W[i]*t==U[i]*j+w[i]*tau+V[i]*(y-y0)+V[i]*(t-y)
        assert norm((s[i]-s[r])*t)>=L[i]
        if free: assert norm((s[i]-s[r])*t)>=F(1,N)
        counts['rounding_phase_comparisons']+=1
    if r in (0,N-1):
        endpoint=N-1 if r==0 else 0
        assert H*t==q*j+w[endpoint]*tau
        assert norm(H*t)==norm(w[endpoint]*tau)
        counts['endpoint_equalities']+=1
    counts['rounding_instances']+=1
    counts['free_successes']+=free
    counts['own_margin_times']+=own
    counts['retained_margin_successes']+=free and own
    record=dict(name=name,q=q,r=r,alpha=alpha,beta=beta,w=[w[i] for i in I],c=c,
                tau=str(tau),rounding=str(d),shift=str(abs(t-y)),time=str(t),
                lower_bounds=[str(L[i]) for i in I],free=free,own=own)
    records.append(record)
    return record

# Supplied four-runner fixture: exact loss repairs the worst-case bound.
s4=(0,1,3,4);u4=(0,0,1,1)
z=inspect('N4 exact success',s4,1,u4,0,(1,3),F(1,3))
assert z['w']==[-1,2,1] and z['c']==2 and z['free'] and z['own']
assert z['rounding']=='1/3' and z['shift']=='1/12' and z['time']=='19/12'
assert F(1,8)>F(1,3)-F(1,4)==F(1,12)
inspect('negative tau',s4,1,u4,0,(1,3),F(-1,3))
inspect('nonminimal period p below one',s4,5,tuple(a+b for a,b in zip(s4,u4)),0,(1,3),F(1,3))
inspect('upper nearest tie',s4,1,u4,0,(1,3),F(1,10))
inspect('lower nearest tie',s4,1,u4,0,(1,3),F(1,10),True)
inspect('zero phase input',s4,1,u4,0,(1,3),F(0))
counts['tie_branches']=2

# Supplied five-runner packet: free zero-rounding does not retain its own margin.
s5=(0,1,2,3,4);u5=(0,0,0,1,1)
z=inspect('N5 free zero rounding',s5,1,u5,0,(1,4),F(1,5))
assert z['w']==[-1,-2,2,1] and z['c']==2
assert z['free'] and not z['own'] and z['rounding']=='0'

# Complete closed-band intersection, not time sampling.
def intersect(xs,ys):
    return [(max(a,c),min(b,d)) for a,b in xs for c,d in ys if max(a,c)<=min(b,d)]
def bands(speed,delta):
    return [(F(k+delta,speed),F(k+1-delta,speed)) for k in range(speed)]
def good(speeds,delta):
    out=[(F(0),F(1))]
    for speed in speeds: out=intersect(out,bands(speed,delta))
    return sorted(set(out))
own_times=good((1,2),F(1,3))
assert own_times==[(F(1,3),F(1,3)),(F(2,3),F(2,3))]
for lo,hi in own_times:
    assert lo==hi
    z=inspect('N5 own-margin rejection '+str(lo),s5,1,u5,0,(1,4),lo)
    assert z['own'] and not z['free'] and z['lower_bounds'][1]=='1/6'
counts['complete_own_margin_intersections']=1

# Five fixed pair-sum witnesses test the monotone binary cut with all chosen signs.
for r,pair,T in [(0,(1,4),F(1,5)),(1,(3,4),F(1,5)),
                 (2,(0,1),F(1,3)),(3,(0,1),F(1,5)),(4,(0,3),F(1,5))]:
    cut=min(pair)
    u=tuple(int(i>cut) for i in range(5))
    beta=sum(abs(s5[i]-s5[r]) for i in pair)
    assert 0<T<1 and (beta*T).denominator==1
    assert all(norm((a-s5[r])*T)>=F(1,5) for i,a in enumerate(s5) if i!=r)
    z=inspect('binary cut chosen '+str(r),s5,1,u,r,pair,-T)
    assert z['alpha']==-1 and gcd(z['alpha'],z['beta'])==1
    assert z['rounding']=='0' and F(z['time'])==1+T and z['free']
    counts['binary_cut_encodings']+=1

# Universal retained-margin obstruction: original witness set is two singletons.
G12=good((1,2),F(1,4))
G3=good((3,),F(1,4))
G123=good((1,2,3),F(1,4))
assert G12==[(F(1,4),F(3,8)),(F(5,8),F(3,4))]
assert G3==[(F(1,12),F(1,4)),(F(5,12),F(7,12)),(F(3,4),F(11,12))]
assert G123==[(F(1,4),F(1,4)),(F(3,4),F(3,4))]
for t,_ in G123:
    assert norm(3*t)==F(1,4)<F(1,3)
    assert all(norm(k*t)>=F(1,4) for k in (1,2,3))
counts['universal_obstruction_interval_certificates']=1
assert counts['rounding_instances']==14 and counts['rounding_phase_comparisons']==50
assert counts['endpoint_equalities']==11 and counts['binary_cut_encodings']==5
assert counts['free_successes']==9 and counts['own_margin_times']==6
assert counts['retained_margin_successes']==4
print(json.dumps(dict(counts=dict(sorted(counts.items())),records=records,
                     consecutive_G4=[[str(a),str(b)] for a,b in G123]),sort_keys=True))
```

Extract and execute the saved block exactly:

```sh
python3 -B - <<'EXACT_ROUNDING_REPLAY'
from pathlib import Path
from hashlib import sha256
import re
text = Path('research/astra-exact-rounding-scope-audit.md').read_text()
blocks = re.findall(r'^```python\n(.*?)^```[ \t]*$', text, re.M | re.S)
assert len(blocks) == 1
assert sha256(blocks[0].encode()).hexdigest() == '574ed2179ecdbb72e6a87edba04b3de604b3e235dceece0a55fa4bf4fd6eee19'
exec(compile(blocks[0], 'exact-rounding-controls', 'exec'))
EXACT_ROUNDING_REPLAY
```

The exact saved-block replay exits zero and reproduces the output hash above.
Counts are `rounding_instances=14`, `rounding_phase_comparisons=50`,
`endpoint_equalities=11`, `tie_branches=2`, `binary_cut_encodings=5`,
`free_successes=9`, `own_margin_times=6`, and `retained_margin_successes=4`,
with one complete own-margin interval intersection and one universal-obstruction
interval certificate. These are fixed exact controls, not numerical evidence
for universal existence.

The proved manuscript scope is (1)-(2), free-time equivalence (4), and the
universal retained-margin endpoint obstruction (5) with its exact four-runner
certificate. No statement here has been newly formalized in Lean. Separate
independent review is required before promotion. The remaining finite-family
supply could use other methods or a proved covering disjunction; this audit
supplies neither. Unrestricted LRC remains unresolved. All owned commands have
stopped at handoff.
