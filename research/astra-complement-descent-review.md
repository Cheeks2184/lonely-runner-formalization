# Independent speed-complement descent review

Reviewer `/root/guard_internal_cover_audit`, requested Astra/xhigh, 2026-09-05.
Review source: `8db7eb32fb0aec5f1a62d18f93a72c5096d76743`.
Current project configuration, workflow, policy, and state were read;
workflow structural validation passed. Only this review file is owned.

Frozen manuscript: `research/astra-complement-descent-audit.md`, SHA-256
`0bc27e0ae760565769407c3024b9f10064f00d11b0ab6351ffb40ebbd7affeb8`.
The entire manuscript and its sole control block were read. The accepted
endpoint-selector contract was rechecked in the unchanged minimal-height
audit `40e59ba4539eb931a07612e9b972999d3b48006d39ef4760c0e493d08e734325`
and review `4570fa22f788a0e832165dd4ec5da613003a0181b0200267fcc30b44d9776e92`.
No author, Lean, cache, shared-state, or Git edits are part of this review.

## Exact descent scope

For D contained in the old speeds below p, the map a -> p-a is injective,
positive, and has image Q strictly below p. The retained set A minus D
still contains p. Inclusion-exclusion gives
|B|=|A|-|D|+|Q|-|Q intersect (A minus D)|=n-|C|.
The sum is H(A)-sum(D)+sum(Q)-sum(C), exactly the displayed formula.
C must use the retained set: a complement reinserted into D itself is not
an overlap with A minus D. No hidden multiset or repeated-label count is used.

For each a>p/2 the change p-2a is strictly negative. A nonempty subset of
such high speeds strictly decreases the sum, and subtracting the positive
collision speeds cannot undo that decrease. Count never rises. This is a
valid descent operation if such a subset is selected; no theorem here says
that every hypothetical minimum has a high old speed.

The subsequent minimality witness supply is correctly used for a verified
descending choice, in particular a nonempty high subset. It must not be read
as applying to every arbitrary D: the empty choice, or swapping the selected
complement pair {4,7} at p=11, can leave A unchanged. More generally a
count decrease invokes count minimality regardless of sum; with unchanged
count, the sum must decrease. The general formula alone does not assert
these conditions. This qualification makes explicit the manuscript's
surrounding descent context.

For an eligible choice, the honest canonical margin is alpha=1/(|B|+1).
If C is empty it is only delta=1/(n+1); if C is nonempty it is the stronger
smaller-count margin. Positivity, injectivity after deduplication, and the
stationary zero are preserved. The global BHK equivalence is applied before
choosing the positive-integer count/sum minimum; no count-preserving real
reduction is assumed.

## Scalar identity, boundaries, and global limits

Under 0<delta<=alpha<=1/2 and strict a-badness, there is exactly one
integer j with x=a*t-j in (-delta,delta). Even when delta=1/2, strictness
excludes the half-integer tie. The retained p-good phase y lies in
[alpha,1-alpha]. Hence
alpha-delta<y-x<1-alpha+delta, with bounding values in [0,1].
The inequalities on y-x remain strict even when alpha=delta, so it is
indeed the fractional part of (p-a)*t with no hidden wrap.

In (0,1), closed alpha-goodness is equivalent to phase in [alpha,1-alpha].
Rearranging gives exactly the closed strip
[y-1+alpha,y-alpha] for x, with the two strict complementary wedges.
Each wedge requires the indicated strict near-boundary condition on y.
If y instead lies in [alpha+delta,1-alpha-delta], strict x bounds place
y-x strictly in (alpha,1-alpha), proving strict alpha-goodness. This
central interval is empty when alpha+delta>1/2. At equality it may be a
single point; at alpha=1/2 it is necessarily empty because delta>0.
No time meeting the central condition is manufactured by this calculation.

For one eligible removed a, all retained-good times make every other
original coordinate delta-good. Original failure therefore makes a
strictly delta-bad, so the scalar hypotheses apply throughout that
retained-good domain. Failure of B would require all those times to avoid
the closed strip. Original failure supplies only x in (-delta,delta),
not that strip avoidance. Minimality supplies a transformed witness in
the strip rather than a contradiction. The biconditional involving x,y is
under these retained-good hypotheses; outside them membership in B already
fails because the retained set is a subset of B.

For general D, a transformed witness guarantees goodness of A minus D.
Original failure would force at least one bad original label in D, whose
complement is good in B. That is consistent with the same strip calculation.
No claim that the scalar phases can be chosen independently, or that a
local compatible point satisfies all hypothetical global-failure constraints,
is justified or made. A partial complement is not generally a change of
one distinguished runner.

## Endpoint selector and full reflection

After deleting high a, the reference pivot for the accepted selector is a,
and the old set for that selector is S=A minus {a}. Original failure covers
the actual a-row by S. Since q=p-a<a and N>=4,
2q<2a<=(N-2)a, so the selector bound holds although a is not the maximum
of S union {a}. A supplied B witness gives a weak delta witness, hence a
q-good endpoint of G_delta(S). It need not retain alpha, and its actual
endpoint-owner grid belongs to a retained label in S, not necessarily the
a-row used to bound the component width. It does not protect a or transfer
the witness to A.

For D=V, Q has n-1 distinct speeds and does not contain p. There are no
retained collisions, |F|=n, and
H(F)=p+sum_(a in V)(p-a)=N*p-H(A).
The strict decrease condition is exactly 2H(A)>N*p. The map s -> p-s
reflects the entire N-runner configuration, sending original runner p to
new zero and original zero to new runner p. A stationary witness for F
therefore means original p is lonely. It does not assert that original zero
is lonely. Testing the new runner p instead gives the original absolute
relative speeds A and its original height. Minimum height is attached to
that stationary relative-speed problem, so no smaller-height contradiction
follows from the relabelled configuration.

## Controls and their quantifiers

The author replay passed all three failed-reuse and two successful-reuse
controls. It checks every nonempty subset of the fixed high set {6,7}, with
actual distinct counts 5,5,4 and margins 1/6,1/6,1/5. Its negative claim is
exactly: for each of those three choices there exists a transformed
canonical witness that fails original reuse. It does not say every witness
fails; the two successful controls explicitly show otherwise for two choices.
The original tuple has witnesses and is not an actual minimum. The controls
therefore do not refute an implication using additional global consequences
of original failure or an existential strategic choice of witness.

Additional fixed controls below test both closed strip edges, central-phase
boundary equality, negative times, and the alpha=delta=1/2 scalar limit.
A hand-specified fresh complement uses A={2,7,11}, D={7}: B={2,4,11}
has the same count, sum 17<20, and margin 1/4. At t=1/8, B is good while
removed speed 7 has norm 1/8. This supplements the author's collision-only
controls without claiming a minimum or universal failed reuse.

A full-reflection control uses A={4,5,7}, N=4, p=7. Its complement is
F={2,3,7}, with sum 12=28-16<16. At t=1/4, F is good at 1/4 whereas
original speed 4 has phase zero. Original runner 7 is lonely at that time;
original zero is not. This directly checks the distinguished-runner limit
in a case where the raw speed sum strictly decreases.

## Exact reproduction

This standard-library block executes the frozen author test and only the
additional fixed controls described above. There is no tuple or witness
search.

```python
from pathlib import Path
from hashlib import sha256
from fractions import Fraction as F
from math import floor
import re

p=Path('research/astra-complement-descent-audit.md')
assert sha256(p.read_bytes()).hexdigest()== \
    '0bc27e0ae760565769407c3024b9f10064f00d11b0ab6351ffb40ebbd7affeb8'
blocks=re.findall(r'^```python\n(.*?)^```[ \t]*$',p.read_text(),re.M|re.S)
assert len(blocks)==1
exec(compile(blocks[0],str(p),'exec'),{})

def norm(x):return min(x%1,(-x)%1)
def good(A,alpha,t):return all(norm(a*t)>=alpha for a in A)
def complement(A,p,D):
    assert p==max(A) and D<=A-{p}
    Q={p-a for a in D};C=Q&(A-D);B=(A-D)|Q
    assert len(Q)==len(D) and all(0<q<p for q in Q)
    assert len(B)==len(A)-len(C)
    assert sum(B)==sum(A)+sum(p-2*a for a in D)-sum(C)
    assert p in B and max(B)==p
    return B,Q,C

# A selected complement pair may be removed and reinserted unchanged.
A={1,4,5,6,7,11}
B,Q,C=complement(A,11,{4,7})
assert B==A and Q=={4,7} and C==set()
assert complement(A,11,set())[0]==A

scalar_cases=[(1,3,F(1,8),F(1,4),F(1,4)),
              (1,3,F(-1,8),F(1,4),F(1,4)),
              (1,4,F(1,8),F(1,4),F(1,4)),
              (1,4,F(-1,8),F(1,4),F(1,4)),
              (3,13,F(1,42),F(1,7),F(1,6)),
              (3,13,F(-1,42),F(1,7),F(1,6)),
              (2,3,F(1,2),F(1,2),F(1,2)),
              (1,2,F(1,4),F(1,2),F(1,2))]
strip_edges=central_cases=0
for a,p,t,delta,alpha in scalar_cases:
    assert 0<a<p and 0<delta<=alpha<=F(1,2)
    assert norm(a*t)<delta and norm(p*t)>=alpha
    js=[j for j in range(floor(a*t)-1,floor(a*t)+3)
        if -delta<a*t-j<delta]
    assert len(js)==1
    x=a*t-js[0];y=(p*t)%1
    assert alpha-delta<y-x<1-alpha+delta and 0<y-x<1
    assert ((p-a)*t)%1==y-x
    strip=y-1+alpha<=x<=y-alpha
    wedges=x>y-alpha or x<y-1+alpha
    assert (norm((p-a)*t)>=alpha)==strip
    assert (norm((p-a)*t)<alpha)==wedges
    if x>y-alpha:assert y<alpha+delta
    if x<y-1+alpha:assert y>1-alpha-delta
    if alpha+delta<=y<=1-alpha-delta:
        assert norm((p-a)*t)>alpha
        central_cases+=1
    if x in (y-1+alpha,y-alpha):
        assert norm((p-a)*t)==alpha
        strip_edges+=1
assert strip_edges==3 and central_cases==4
# A half-integer would lose uniqueness if strict badness were weakened.
assert norm(F(1,2))==F(1,2)
assert [j for j in (0,1) if -F(1,2)<=F(1,2)-j<=F(1,2)]==[0,1]

A={2,7,11};B,Q,C=complement(A,11,{7})
assert B=={2,4,11} and C==set() and len(B)==len(A)==3
assert sum(B)==17<20==sum(A)
assert good(B,F(1,4),F(1,8)) and not good(A,F(1,4),F(1,8))
assert norm(7*F(1,8))==F(1,8)

A={4,5,7};p=7;N=len(A)+1
Fset,Q,C=complement(A,p,A-{p})
assert Fset=={2,3,7} and len(Fset)==len(A)
assert sum(Fset)==N*p-sum(A)==12<16==sum(A)
t=F(1,4)
assert good(Fset,F(1,N),t) and not good(A,F(1,N),t)
assert all(norm((p-s)*t)>=F(1,N) for s in A|{0} if s!=p)
assert norm(4*t)==0
assert {abs(v-p) for v in Fset|{0} if v!=p}==A
print(dict(scalar_cases=len(scalar_cases),closed_strip_edges=strip_edges,
           central_boundary_cases=central_cases,fresh_complement='passed',
           unchanged_pair_control='passed',decreasing_full_reflection='passed',
           distinguished_runner='passed',discovery_searches=0))
```

Executed from the repository root with:

```bash
PYTHONDONTWRITEBYTECODE=1 python3 - <<'REVIEW_REPLAY'
from pathlib import Path
import re
p=Path('research/astra-complement-descent-review.md')
blocks=re.findall(r'^```python\n(.*?)^```[ \t]*$',p.read_text(),re.M|re.S)
assert len(blocks)==1
exec(compile(blocks[0],str(p),'exec'))
REVIEW_REPLAY
```

Observed outcome: exit 0, with exactly:

```text
3 failed-reuse and 2 successful-reuse fixed controls passed
{'scalar_cases': 8, 'closed_strip_edges': 3, 'central_boundary_cases': 4, 'fresh_complement': 'passed', 'unchanged_pair_control': 'passed', 'decreasing_full_reflection': 'passed', 'distinguished_runner': 'passed', 'discovery_searches': 0}
```

**Disposition: accepted for the stated high-subset/verified-descent scope,
with the witness-supply qualification made explicit above.** The general
set identities, strict high-subset decrease, honest canonical margin,
signed no-wrap scalar strip, central condition, existing endpoint-selector
application, and full-reflection runner interpretation are sound. The
negative and positive controls carry exactly the manuscript's limited
quantifiers; no additional global failure statement follows from them.

The remaining step is a global proof that some eligible decreasing B_D
fails, or a justified choice/transport of one of its witnesses to the
original stationary-runner tuple. Neither the local strip nor complementation
provides that step, and no actual minimum or unrestricted LRC statement is
refuted. All review commands stopped. No discovery, author/source edit,
shared-state mutation, Git operation, Lean build, or cache work ran.
