# Global strict-ordinary-to-mixed implication: audit

2026-09-05. Requested Astra/xhigh task `/root/strict_to_mixed_audit`, source
checkpoint `0b0a033e9655b5f9d2fa0b57ac0f61729b2db123`. Only this manuscript is
owned. The workflow, configuration, policy, current state and relevant insertion
interfaces were read; `python3 -B scripts/validate_workflow.py` passed. Research
is authorized, observed runtime model/effort are not independently exposed, and
the canonical goal remains unresolved. This work is outside Pass31.

## Exact target and initial deductions

K: for N>=4 and N-1 distinct positive integer speeds W with gcd 1 and H=max W,
if some real T has every ||wT||>1/N, then some real S has every ||wS||>=1/N
and ||HS||>=1/(N-1). The times and connected components may differ.
This is not an assertion that every ordinary witness has a mixed continuation.

Both sides are invariant under common positive integer scaling, by replacing
time t with gt. Thus restricting K to primitive tuples loses no mathematical
generality. The direct-divisibility branch is absent from this question.

For these finite positive-speed tuples, strict ordinary existence is equivalent
to the ordinary closed good set having a component of positive width. A strict
point has a common open neighborhood by continuity. Conversely, a positive-width
component lies in fixed integer-floor bands for every speed; at any interior
point each band inequality is strict, since equality at either affine endpoint
would preclude an interval on one side. Equivalently one may avoid the finitely
many phase-boundary times. Singleton components do not imply a strict point.

The accepted uniform audit at SHA-256
`6054472d7412bdb9c5a3c258191f58cf260d50c6240d81eecce05f3be3ba138b`
proves a necessary condition for any ordinary component missing mixed. Reflect
the component so the fastest phase increases below half; at its right endpoint
an upper owner a<H has `h=1/N+s/(Na)`, where s is an integer satisfying
`0<=s<a/(N-1)` and `s == -(H+a) (mod N)`. If s=0 the component is a singleton.
Consequently a counterexample to K would need at least one positive-width
component, every such component would have all oriented upper owners a>=N,
and every ordinary component globally would miss mixed. A single trapped
component does not suffice; the accepted infinite trap family has mixed
witnesses elsewhere and is not a counterexample to K.

One immediate sufficient case of K is already rigorous: if every lower speed
is <=N-1, a positive-width component cannot satisfy the blocker condition,
so that component itself contains a mixed witness, regardless of H.

The existing `DivisorInsertion.lean` contains the coprime-grid margin and
codimension-one ordinary insertion theorem; `FastRunnerInsertion.lean` contains
the quantitative perturbation theorem. Their ordinary insertion coverage is
not being repackaged as a new result. No period-shift argument is assumed to
preserve the mixed endpoint without its exact margin being checked.

## The lower core can be required primitive

Let g be the gcd of all N-2 lower speeds. Primitivity gives gcd(g,H)=1.
Starting from any ordinary witness T, the shifts T+j/g preserve every lower
phase and let the fastest phase traverse a translated g-point grid. The saved
coprime-grid lemma guarantees a fastest norm at least (g-1)/(2g).
For N>=5 and g>=2 this is >=1/4>=1/(N-1). Thus ordinary already implies
mixed in this case, without a lower-count hypothesis or strictness premise.
For N=4 the same argument applies when g>=3.

For N=4,g=2, first use an ordinary 1/3 witness for the two lower speeds.
Such a witness is elementary: the accepted N=3 classification either gives
a half-endpoint witness or reduces the pair to ratio 1:2 with witness 1/3.
Shift by j/2 so the fastest norm is >=1/4. If it is below 1/3, perturb time
toward its antipode until that norm reaches 1/3, costing at most 1/(12H).
Each lower speed is <H, so each lower norm loses strictly less than 1/12
and remains >1/4. This proves mixed outright for this exceptional grid case.
Hence every counterexample to K has gcd(lower core)=1, for every N>=4.
The use of the existing grid theorem is a mixed-margin application; it does
not claim new ordinary divisor-insertion coverage.

## Stronger restrictions at N=4

Write W=(a,b,H), a<b<H. If gcd(a,H)=g>1, then gcd(b,g)=1. Every pair a<H
has a time with ||Ht||=1/2 and ||at||>=1/4: after dividing by gcd(a,H),
the coprime half-phase residue argument gives maximum >=(H'-1)/(2H')>=1/4,
where H'>=2. Shifts by j/g preserve these two phases and can make the b norm
at least (g-1)/(2g)>=1/4. Therefore mixed exists. The identical argument
works when gcd(b,H)>1. Together with the lower-core argument, any N=4
counterexample to K must have all three speeds pairwise coprime.

Also, every two-speed lower tuple has a 1/3 witness. Move this time by at most
1/(3H) to make the fastest norm at least 1/3. If H>=4b, each lower norm loses
at most b/(3H)<=1/12, hence stays >=1/4. This supplies mixed regardless of
strict ordinary existence. This explicitly checks the stronger fastest margin;
it is not inferred from the ordinary fast-insertion theorem's conclusion.
Thus a remaining N=4 counterexample must have b>=4, b<H<4b, pairwise
coprimality, and globally empty mixed set despite an ordinary interval.
There is no finite bound on b in this reduction.

## Targeted finite diagnostic

To avoid repeating the accepted divisor-covered sweeps, the new diagnostics
examined only primitive tuples for which some d=2,...,N divides no speed.
The other speeds ran over every increasing choice below H in these domains:

| N | H range | Eligible tuples | Empty mixed sets |
| --- | --- | --- | --- |
| 4 | 3 through 20 | 643 | only (1,2,3) |
| 5 | 4 through 16 | 1,185 | none |
| 6 | 5 through 12 | 502 | only (1,2,3,4,5) |

Closed rational band intersection on [0,1/2] gives ordinary sets {1/4} and
{1/6}, respectively, for the two exceptions. Integer periodicity and reflection
give their complete sets modulo one, so neither exception has a strict point.
Every other eligible tuple had an exactly checked mixed witness. These finite
results do not prove K or classify arbitrary primitive N=4 tuples.

Current disposition: K is neither proved nor refuted by this audit. Its exact
unresolved content is whether a primitive lower core can have ordinary interior
while every ordinary component is globally trapped below the fastest margin.
At N=4 the additional pairwise-coprime and H<4b reductions apply. The next
conceptual target is classification in this remaining infinite N=4 domain,
or an exact structured counterexample at a larger count; no broader blind
enumeration is justified by these controls. Unrestricted LRC is still unresolved.

I also read the relevant definitions, two-speed proof and open questions in
[Jensen, Mixed thresholds in the Lonely Runner Conjecture, v1](https://arxiv.org/html/2605.27941v1).
Its thresholds are assigned to arbitrary ordered speed tuples; K ties the
larger threshold to the fastest speed and assumes strict ordinary existence.
The paper does not settle this exact question. No theorem from it is imported.
Its consecutive-speed argument alone cannot exclude a fastest-only increase:
(1,2,3,4), T=2/5 has norms (2/5,1/5,1/5,2/5).

## Sole exact reproducer

The program guards the accepted manuscript and the two inspected Lean sources.
It reruns only the three new finite domains above and fixed margin controls.
No covered sweep, external search, Lean build or cache operation is performed.

```python
from fractions import Fraction as Q
from itertools import combinations
from math import gcd,floor
from pathlib import Path
from hashlib import sha256
import json
guards={
 'research/astra-uniform-direct-mixed-audit.md':'6054472d7412bdb9c5a3c258191f58cf260d50c6240d81eecce05f3be3ba138b',
 'LonelyRunner/DivisorInsertion.lean':'212fa6d879bab6d70f09a4a43b2027b96724b5e5ac4a22cdf4b368509973166f',
 'LonelyRunner/FastRunnerInsertion.lean':'dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5',
}
for p,h in guards.items():assert sha256(Path(p).read_bytes()).hexdigest()==h
def norm(x):
 f=x-floor(x)
 return min(f,1-f)
def check(W,T):
 N=len(W)+1
 assert all(norm(w*T)>=Q(1,N) for w in W) and norm(W[-1]*T)>=Q(1,N-1)
def good(W,mixed):
 N=len(W)+1;cells=[(Q(0),Q(1,2))]
 for w in W:
  d=Q(1,N-1) if mixed and w==W[-1] else Q(1,N)
  bands=[((j+d)/w,(j+1-d)/w) for j in range(w//2+1)]
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
for W,T in (((2,6,10,13),Q(1,4)),((3,9,10),Q(5,6))):
 g=gcd(*W[:-1]);H=W[-1]
 assert gcd(g,H)==1 and all(norm(w*T)>=Q(1,len(W)+1) for w in W)
 U=max((T+Q(j,g) for j in range(g)),key=lambda u:norm(H*u))
 assert norm(H*U)>=Q(g-1,2*g)
 assert all(norm(w*U)==norm(w*T) for w in W[:-1]);check(W,U)
W=(2,6,7);T=Q(1,4);H=W[-1]
assert gcd(*W[:-1])==2 and all(norm(w*T)>=Q(1,3) for w in W[:-1])
assert max(norm(H*(T+Q(j,2))) for j in range(2))==Q(1,4)
U=T-Q(1,12*H)
assert U==Q(5,21) and all(norm(w*U)>Q(1,4) for w in W[:-1]);check(W,U)
W=(6,10,15);T=Q(1,10);g=gcd(W[0],W[-1])
assert g==3 and norm(W[0]*T)>=Q(1,4) and norm(W[-1]*T)==Q(1,2)
U=max((T+Q(j,g) for j in range(g)),key=lambda u:norm(W[1]*u))
assert norm(W[-1]*U)==Q(1,2);check(W,U)
W=(1,3,12);T=Q(1,2);U=T+Q(1,3*W[-1])
assert W[-1]==4*W[-2] and norm(W[-1]*T)==0
assert all(norm(w*T)>=Q(1,3) for w in W[:-1]);check(W,U)
assert [norm(w*Q(2,5)) for w in (1,2,3,4)]==[Q(2,5),Q(1,5),Q(1,5),Q(2,5)]
records=[]
for N,lo,hi,want in ((4,3,20,643),(5,4,16,1185),(6,5,12,502)):
 count=0;empty=[]
 for H in range(lo,hi+1):
  for low in combinations(range(1,H),N-2):
   W=low+(H,)
   covered=all(any(w%d==0 for w in W) for d in range(2,N+1))
   if gcd(*W)!=1 or covered:continue
   count+=1;M=good(W,True)
   if M:check(W,M[0][0])
   else:
    G=good(W,False)
    assert G and all(l==r for l,r in G)
    empty.append({'W':list(W),'ordinary_half_cells':[[str(l),str(r)] for l,r in G]})
 assert count==want
 expected=[] if N==5 else [{'W':list(range(1,N)),'ordinary_half_cells':[[str(Q(1,N)),str(Q(1,N))]]}]
 assert empty==expected
 records.append({'N':N,'H_min':lo,'H_max':hi,'eligible':count,'mixed_empty':empty})
print(json.dumps({'status':'PASS','domains':records,'fixed_margin_controls':5,'source_guards':3},sort_keys=True,separators=(',',':')))
```

The saved program exited 0: all 2,330 eligible tuples, five fixed margin
controls, the source-scope countercontrol, and three source guards passed.
Program SHA-256: `9d2275e0229d8a4b1346c317339ba7363337d04b9e6027d2046fc56c7182608b`.
Exact stdout SHA-256: `97671355d56908a2c06b4ad6ae9dc20cab31377c1c78968ea2f181fa462ed622`.
Both hashes include the final newline. Replay from the repository root:

```sh
python3 -B - <<'STRICT_TO_MIXED_REPLAY'
from pathlib import Path
from hashlib import sha256
from contextlib import redirect_stdout
import io,re
b=re.findall(r'^```python\n(.*?)^```[ \t]*$',Path('research/astra-strict-to-mixed-audit.md').read_text(),re.M|re.S)
assert len(b)==1 and sha256(b[0].encode()).hexdigest()=='9d2275e0229d8a4b1346c317339ba7363337d04b9e6027d2046fc56c7182608b'
out=io.StringIO()
with redirect_stdout(out):exec(compile(b[0],'strict-to-mixed-audit','exec'),{})
assert sha256(out.getvalue().encode()).hexdigest()=='97671355d56908a2c06b4ad6ae9dc20cab31377c1c78968ea2f181fa462ed622'
print(out.getvalue(),end='')
STRICT_TO_MIXED_REPLAY
```

Initial deductions and reductions were saved before their controls. The final
saved-block replay, readback and workflow structural validator passed. All owned
commands are stopped at handoff. Only this manuscript was written: no state,
Git, other source, Lean output or cache was changed. Its final artifact SHA-256
is reported separately. The new reductions require independent semantic review;
they do not establish K, uniform ordinary supply, or canonical LRC.
