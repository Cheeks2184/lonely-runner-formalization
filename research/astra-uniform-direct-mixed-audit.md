# Uniform direct-or-mixed supply: normalization obstruction and further audit

2026-09-05. Requested Astra/xhigh novel-mathematics assignment, owned file only.
Observed runtime model/effort were not independently exposed.
Read the project workflow, configuration, policy and current state. Research is
authorized; the full canonical LRC goal is unresolved. The startup structural
validator exited 1: a separate research/high task has an explicit user override,
while the validator currently permits only research/xhigh. This mismatch was
reported to the orchestrator; no policy, state, Git, Lean or cache was changed.

## Exact question and immediate obstruction

Fix N>=3 and N-1 sorted distinct positive integer moving speeds W, with
stationary chosen runner zero and H=max W. Write delta=1/N, delta0=1/(N-1).
Ordinary means some T satisfies every ||wT||>=delta. Direct means some integer
2<=d<=N divides no retained speed. Mixed means some T is ordinary and also
||HT||>=delta0. Direct implies ordinary at T=1/d; mixed implies ordinary.

**The direct-or-mixed converse is false on the stated unnormalized domain.**
For every positive integer m take N=3 and W=(6m,12m). Both d=2 and d=3 divide
6m, so direct fails. Put x=6mT modulo one. The ordinary conditions are
||x||>=1/3 and ||2x||>=1/3. The first restricts x to [1/3,2/3], while the
second restricts it to [1/6,1/3] union [2/3,5/6]. Their closed intersection
is exactly {1/3,2/3}. Thus an ordinary witness exists, for example T=1/(18m),
but its fastest norm is always 1/3<1/2. No mixed witness exists, including
at any other real time. By the reviewed stationary equivalence, no exact S
packet exists either, regardless of q, u, anchor pair or real collision time.
This is an auxiliary-method counterexample, not an LRC counterexample.

The mechanism is structural: common scaling preserves ordinary and mixed
existence by the bijective time substitution T -> gT, but direct divisibility
does not survive scaling. If g is a multiple of lcm(2,...,N), every d is covered
by every scaled speed. Thus any ordinary-but-not-mixed tuple generates an
infinite scaled family refuting unnormalized direct-or-mixed supply.
Primitive normalization repairs this particular failure: W/gcd(W)=(1,2)
has direct d=3. The primitive-only union therefore needs separate analysis;
the counterexample above must not be presented as settling that narrower target.

## Complete two-moving-speed classification

For N=3, divide (a,H) by g=gcd(a,H), writing coprime (a',H') with H'>=2.
Mixed existence is unchanged. It forces H'T=(2k+1)/2; thus inspect the residues
a'(2k+1) modulo 2H', for k=0,...,H'-1. If a' is odd, multiplication by a'
permutes the odd residues modulo 2H'. When H' is odd, residue H' is available
and gives norm 1/2. When H' is even, residues H'-1,H'+1 are available and
give norm (H'-1)/(2H'). If a' is even, H' is odd, and these phases instead
run through all even residues modulo 2H'; H'-1,H'+1 again give that norm.
Therefore H'>=3 always supplies norm at least 1/3 at an H'-half time.
For H'=2, coprimality and 0<a'<H' force a'=1, whose H'-half phases have
norm 1/4. Consequently mixed fails **exactly** for H=2a.

Every primitive N=3 tuple therefore has direct or mixed: the exceptional
(1,2) has direct d=3. On the raw integer domain the failures are exactly
(a,2a) with 3|a: d=2 is always covered by 2a, and d=3 is covered exactly
when 3|a. Each has ordinary witness T=1/(3a). This classifies an unbounded
family and isolates normalization as the entire N=3 obstruction.

## Bounded primitive diagnostic and ongoing obstruction analysis

A first exact diagnostic considered every primitive N=4 tuple (a,b,H) with
1<=a<b<H and 6<=H<=20 for which each d=2,3,4 divides some speed.
All 351 such tuples had a mixed witness. The computation intersected closed
rational bands on [0,1/2] and retained singleton intervals; it was neither an
asymptotic argument nor a proof of the primitive uniform statement.
This domain starts beyond the separately investigated height N+1 family.
Two further bounded diagnostics found mixed witnesses for all 1,506 eligible
primitive N=5 tuples with 7<=H<=20 and all 2,406 eligible primitive N=6 tuples
with 8<=H<=18. In each case the other speeds run over every increasing choice
below H and eligibility requires that every d=2,...,N divides some speed.
No tuple enumeration beyond these three finite domains has been performed.

## An exact lattice obstruction at a component endpoint

Let I=[L,R] be a complete nonempty connected component of the ordinary good
set on the time circle, represented within a unit interval. Suppose it contains
no mixed witness. The fastest phase cannot cross a half-integer within I.
Reflect the whole component if needed so its fastest fractional phases are
below 1/2. Then h=HR-floor(HR) is its maximum fastest norm and
delta<=h<delta0. At R, some upper endpoint owner a has fractional phase
1-delta; H cannot own that endpoint. Thus 0<a<H, and for integers n,k,
R=(n+1-1/N)/a and h=HR-k. Consequently

```
s := N*a*h-a = N*H*(n+1)-H-N*a*k-a
is an integer,    0<=s<a/(N-1),    s == -(H+a) (mod N),
h = 1/N + s/(N*a).
```

These are necessary conditions for every upper endpoint owner, including ties.
If s=0, h=delta. Since the fastest phase increases with time, no point strictly
left of R can then remain ordinary; I must be a singleton. Thus a component
of positive width without mixed witnesses requires s>0 and in particular
**every right upper owner satisfies a>=N**. For a<=N-1 the integer interval
0<=s<a/(N-1)<=1 forces s=0. This is a precise arithmetic blocker criterion,
not a proof that the other components of the same tuple are blocked.

In particular, if all lower speeds are <=N-1, every positive-width ordinary
component contains a mixed witness. More generally, any positive-width
component whose oriented upper endpoint has an owner a with no integer
0<s<a/(N-1), s==-(H+a) modulo N, must contain a mixed witness.
This is a conditional transformation beyond a maximum-height restriction;
it does not assume that a supplied ordinary component has positive width.

## A primitive covered tuple with a trapped ordinary component

Take N=4 and W=(5,12,14), gcd 1. Every d=2,3,4 divides a retained speed,
so direct fails. In the fixed floor cell (4,11,13), the ordinary bands are

```
speed 5:  [17/20,19/20],
speed 12: [15/16,47/48],
speed 14: [53/56,55/56].
intersection: I=[53/56,19/20].
```

At the left endpoint speed 14 is exactly 1/4 and immediately to its left it
is bad; at the right endpoint speed 5 is exactly 1/4 and immediately to its
right it is bad. Therefore I is a full ordinary connected component, not an
arbitrarily truncated subinterval. Throughout I the fastest norm is 14T-13,
ranging over [1/4,3/10], strictly below 1/3. No continuous deformation staying
ordinary in this component reaches mixed. The endpoint criterion has owner
a=5 and s=1, with 1<5/3 and 1==-(14+5) modulo 4, as required.

Nevertheless T=3/28 is mixed: the three norms are (13/28,2/7,1/2).
This fixture therefore refutes component-preserving ordinary-to-mixed supply
even for primitive divisor-covered tuples, while confirming that it does
not refute the global union. A proof of primitive uniform supply must justify
selecting another component or another global mechanism.

## An infinite sharp family of primitive component traps

The bound a>=N above is sharp, even within the divisor-covered primitive domain.
For every N>=4 set `H=N^2-2N-1` and `W={3,4,...,N} union {H}`.
There are N-1 distinct positive speeds, H>N, and gcd(W)=1 because 3,4 survive.
Every d=3,...,N is retained, and d=2 divides 4, so direct fails. Put
`R=(N-1)/N^2`, `L=R-1/(N^2*H)`. The complete ordinary component [L,R]
has fastest fractional phases from 1/N to (N+1)/N^2, since
`H*R=N-3+(N+1)/N^2`. Its upper fastest norm is strictly below 1/(N-1).
For every retained lower k, `k*R<=N*R=1-1/N`, with equality only at k=N.
Also `L>(N-2)/N^2`, so `k*L>=3L>1/N` for N>=4. All lower phases are
therefore good throughout [L,R], and all except N are strictly good at R.
Immediately left of L the fastest is bad; immediately right of R speed N is
bad. This proves the interval is a whole positive-width component. Its owner
a=N has s=1, showing the endpoint owner's lower bound cannot be increased.

These tuples nevertheless have explicit global mixed witnesses. For N>=7 use
`T=1/(N+2)`: the lower residues 3,...,N and the fastest residue
`H == 7 (mod N+2)` all have distance at least 2 from zero modulo N+2.
Every norm is therefore at least `2/(N+2)>=1/(N-1)`. For N=4,5,6 use
T=1/12, 3/28, 3/46 respectively. Their fastest norms are 5/12, 1/2, 1/2;
their smallest lower norms are 1/4, 9/28, 9/46, respectively, at least 1/N.
For N=4 the sharp trap is W=(3,4,7), I=[5/28,3/16], with fastest norms
[1/4,5/16]. Thus this family gives component-preserving failures at unbounded
runner counts and heights, with global mixed supply separately proved.

Current disposition: the raw uniform union is false; its primitive version
remains unresolved here. The reviewed exact S equivalence transfers both
the raw obstruction and the global primitive gap faithfully. No canonical
LRC conclusion follows. Next useful question: prove that a primitive covered
tuple with ordinary witnesses has at least one component escaping the lattice
blockers (including all singleton cases), or construct a tuple where none does.

## Sole exact reproducer

The only imported mathematical result is the stationary S/mixed equivalence,
read at `research/astra-mixed-supply-equivalence-review.md`, SHA-256
`f340c0a311ed6e04d802ee8edfb407a84bc329145bc7e9b446d692cd4e52430a`.
The program guards that source and uses Python standard-library rationals.
The three tuple sweeps reproduce exactly the finite domains above; each
successful intersection is independently checked at its first endpoint.
Four raw failures, four residue fixtures, the full trapped component, and six
fixed members (N=4,5,6,7,10,20) of the analytic sharp family are also checked.
No external facts, new Lean result, or tuple oracle is assumed.

```python
from fractions import Fraction as Q
from itertools import combinations
from math import gcd, floor
from pathlib import Path
from hashlib import sha256
import json
assert sha256(Path('research/astra-mixed-supply-equivalence-review.md').read_bytes()).hexdigest() == 'f340c0a311ed6e04d802ee8edfb407a84bc329145bc7e9b446d692cd4e52430a'
def norm(x):
    f=x-floor(x)
    return min(f,1-f)
def covered(W):
    return all(any(w%d == 0 for w in W) for d in range(2,len(W)+2))
def good(W,mixed,end=Q(1,2)):
    N=len(W)+1
    cells=[(Q(0),end)]
    for w in W:
        d=Q(1,N-1) if mixed and w == W[-1] else Q(1,N)
        bands=[((j+d)/w,(j+1-d)/w) for j in range(floor(w*end)+1)]
        out=[];i=j=0
        while i<len(cells) and j<len(bands):
            l,r=cells[i];a,b=bands[j]
            if max(l,a)<=min(r,b):out.append((max(l,a),min(r,b)))
            if r<b:i+=1
            elif b<r:j+=1
            else:i+=1;j+=1
        cells=out
        if not cells:break
    return cells
def verify_mixed(W,T):
    N=len(W)+1
    assert all(norm(w*T)>=Q(1,N) for w in W)
    assert norm(W[-1]*T)>=Q(1,N-1)
for a in (3,6,9,12):
    W=(a,2*a)
    assert covered(W) and good(W,False) and not good(W,True)
    assert all(norm(w*Q(1,3*a)) == Q(1,3) for w in W)
for a,H in ((1,2),(1,3),(1,4),(2,3)):
    phases=[norm(Q(a*(2*k+1),2*H)) for k in range(H)]
    expected=Q(1,2) if a%2 and H%2 else Q(H-1,2*H)
    assert gcd(a,H)==1 and max(phases)==expected
    assert (max(phases)>=Q(1,3)) == (H>=3)
W=(5,12,14);N=4;H=14;I=(Q(53,56),Q(19,20))
assert gcd(*W)==1 and covered(W) and I in good(W,False,Q(1))
bands=[(Q(17,20),Q(19,20)),(Q(15,16),Q(47,48)),(Q(53,56),Q(55,56))]
assert (max(x[0] for x in bands),min(x[1] for x in bands)) == I
assert [H*T-13 for T in I] == [Q(1,4),Q(3,10)]
assert not good(W,True,Q(1)) == []
assert all(R<I[0] or L>I[1] for L,R in good(W,True,Q(1)))
verify_mixed(W,Q(3,28))
a=5;h=H*I[1]-floor(H*I[1]);s=N*a*h-a
assert s==1 and 0<s<Q(a,N-1) and (int(s)+H+a)%N==0
for N in (4,5,6,7,10,20):
    H=N*N-2*N-1;W=tuple(range(3,N+1))+(H,)
    R=Q(N-1,N*N);L=R-Q(1,N*N*H)
    assert len(W)==N-1 and gcd(*W)==1 and covered(W) and H>N and L<R
    bands=[((floor(w*L)+Q(1,N))/w,(floor(w*L)+1-Q(1,N))/w) for w in W]
    assert (max(b[0] for b in bands),min(b[1] for b in bands))==(L,R)
    assert [norm(H*T) for T in (L,R)]==[Q(1,N),Q(N+1,N*N)]
    assert norm(H*R)<Q(1,N-1) and N*N*norm(H*R)-N==1
    T={4:Q(1,12),5:Q(3,28),6:Q(3,46)}.get(N,Q(1,N+2))
    verify_mixed(W,T)
counts=[]
for N,lo,hi,want in ((4,6,20,351),(5,7,20,1506),(6,8,18,2406)):
    count=0
    for H in range(lo,hi+1):
        for tail in combinations(range(1,H),N-2):
            W=tail+(H,)
            if gcd(*W)!=1 or not covered(W):continue
            count+=1
            intervals=good(W,True)
            assert intervals, (N,W)
            verify_mixed(W,intervals[0][0])
    assert count==want
    counts.append({'N':N,'H_min':lo,'H_max':hi,'eligible':count})
print(json.dumps({'status':'PASS','raw_failures':4,'residue_fixtures':4,'trapped_component':['53/56','19/20'],'sharp_family_fixed_N':[4,5,6,7,10,20],'primitive_diagnostics':counts},sort_keys=True,separators=(',',':')))
```

The saved program exited 0 and reproduced every displayed count and fixed
control. Program SHA-256: `cf160dd62d224fa675219fd36efac9c4b6703f9f799c656449d1cee00dd0dc4e`.
Exact stdout SHA-256: `e0697cefe8f43ed0554396fc9bb4e7977cd5619e02c4c88c600115de2bfce486`.
Both hashes include the final newline. Reproduce from the repository root:

```sh
python3 -B - <<'UNIFORM_DIRECT_MIXED'
from pathlib import Path
from hashlib import sha256
from contextlib import redirect_stdout
import io,re
b=re.findall(r'^```python\n(.*?)^```[ \t]*$',Path('research/astra-uniform-direct-mixed-audit.md').read_text(),re.M|re.S)
assert len(b)==1 and sha256(b[0].encode()).hexdigest()=='cf160dd62d224fa675219fd36efac9c4b6703f9f799c656449d1cee00dd0dc4e'
out=io.StringIO()
with redirect_stdout(out):exec(compile(b[0],'uniform-direct-mixed-audit','exec'),{})
assert sha256(out.getvalue().encode()).hexdigest()=='e0697cefe8f43ed0554396fc9bb4e7977cd5619e02c4c88c600115de2bfce486'
print(out.getvalue(),end='')
UNIFORM_DIRECT_MIXED
```

Proof and material findings were saved before their controls. The final workflow
validator replay passed; this worker edited neither validator nor state. The
saved-block replay and final readback passed. All owned commands are stopped
at handoff; no cache, background search or verifier remains active. The final
artifact SHA-256 is reported separately, avoiding a self-referential hash.
This proposed manuscript still needs the orchestrator's independent review.
