# All-deletion own-margin seed screen

**Disposition: complete exact finite decision reduction and positive bounded
screen; the proposed arbitrary-N supply remains unresolved.** No counterexample
to the all-deletion claim and no uniform proof was obtained. The two requested
tuples satisfy it, including deletions that the held fastest-only route does
not allow. A separate exact control demonstrates the conservative radius's
loss relative to a whole weak component, without refuting the all-deletion
claim. Finite positive evidence must not be promoted to a theorem for all N.

Only this file is owned; the prior affine screen remains unchanged.
Checkpoint supplied by root:
`76d51525dddaac5613e1bb613b7bb9dc7605dabe`. Current focused state and the
divisor manuscript were read; workflow validation passed at startup. No Lean,
cache, Git or shared-state changes were made. This is manuscript mathematics
and exact rational computation, not kernel verification.

## Precise open contract

For every N>=4 and distinct positive integers v_0,...,v_(N-2), assume that
for each p the own-margin deletion seed set

`S_p = {t in R : every i!=p has ||t*v_i|| >= 1/(N-1)}`

is nonempty. The proposed conclusion Q is that there exist one label p and
one common time s in S_p such that

`||s*v_p|| + v_p * min_(i!=p) (||s*v_i||-1/N)/v_i >= 1/N`.

Primitivity can be imposed without loss by common integer scaling, but the
displayed decision procedure does not need it. Every candidate uses actual
common times; coordinate phases are never chosen independently. Research
after the completed six-runner milestone concerns arbitrary N>=7; finite
N=7 controls here only screen this uniform mechanism.

Writing rho for the displayed minimum, Lipschitz continuity proves every old
coordinate stays 1/N-good throughout [s-rho,s+rho]. The maximum pivot norm
on that interval is `min(1/2,||s*v_p||+v_p*rho)`: move away from the nearest
integer until the antipode is reached, and use the Lipschitz upper bound.
Thus Q is exactly sufficient for a full witness in one of these protected
balls. A full witness somewhere else is not an established converse. The
negative search sought a tuple with every S_p nonempty and every exact
maximum strictly below 1/N; it did not search for an LRC counterexample.

## Finite decision reduction, derived before discovery

For N>=4, put delta=1/N, gamma=1/(N-1). For each distinguished label p,
let S_p be the all-real set where every other speed has norm at least gamma.
On S_p define rho_p(t)=min_(i!=p)(norm(v_i*t)-delta)/v_i and
F_p(t)=norm(v_p*t)+v_p*rho_p(t). Every old coordinate is 1-Lipschitz after
dividing its norm by its speed, hence rho_p is 1-Lipschitz. Therefore F_p
is nondecreasing on every rising half-period of the pivot norm and
nonincreasing on every falling half-period. On each closed seed interval,
the maximum is attained at an endpoint or a pivot antipode (2k+1)/(2v_p).
This includes singleton seed intervals and all equality cases. No sampling
or approximation of min-function breakpoints is involved.

Integer-speed periodicity reduces all real times to [0,1]. A speed d's
closed gamma-good bands on that period are exactly
[(k+gamma)/d,(k+1-gamma)/d], 0<=k<d. Intersecting the finite ordered lists
for every old speed gives every seed component. Two-pointer intersections
retain equality and merge touching closed pieces.

For a weak old-safe component [L,R] containing a strong seed s, its unique
phase bands give the exact identity rho_p(s)=min(s-L,R-s). Thus this is the
largest symmetric safe radius, rather than merely a coarse speed-based
bound. If a strong component is [l,r] inside [L,R], the union of the protected
balls over all its seeds is [max(L,2l-R),min(R,2r-L)]. It can be smaller than
the full weak component. This distinction will be tested separately.

To justify that identity, let each actual old band be [L_i,R_i]. Inside it,
`(||v_i*s||-delta)/v_i = min(s-L_i,R_i-s)`. Taking the minimum over i gives
`min(s-max L_i,min R_i-s)`, with `L=max L_i` and `R=min R_i`. Strong
and weak intervals share the same phase-band labels because gamma>delta.
Each nonempty strong interval lies in the interior of exactly one weak
component. The protected-ball endpoints are continuous nondecreasing
functions of the seed s, and their intervals overlap locally, proving the
displayed union formula even when the strong interval is a singleton.

For completeness of the maximum calculation, whenever u>=t lie on a rising
pivot half-period, `||v_p*u||-||v_p*t||=v_p*(u-t)`, while
`rho(u)-rho(t)>=-(u-t)`. Hence F_p(u)>=F_p(t). On a falling half-period,
use the opposite Lipschitz inequality to get F_p(u)<=F_p(t). Partition each
seed interval at the finitely many pivot integers and antipodes. The integers
are minima between the adjacent monotone pieces; consequently endpoints and
antipodes include a maximizer. It is unnecessary to enumerate switches of
the active minimum defining rho. Closed interval intersections, singleton
seeds and threshold equalities are all retained by the implementation.

## Exact all-real control results

The following maxima are over **all** real own-margin seed times, computed
using the proved periodic finite reduction. Each deletion seed set is
nonempty. The finite code below replays every row.

| Tuple | Pivot speed | Number of seed intervals on [0,1] | Maximum F_p |
| --- | --- | --- | --- |
| (1,4,5,6,7,11) | 1 | 4 | 6/49 |
| same | 4 | 4 | 10/77 |
| same | 5 | 4 | 9/77 |
| same | 6 | 4 | 8/49 |
| same | 7 | 4 | 1/6 |
| same | 11 | 4 | 3/28 |
| (2,5,7,12,17,19) | 2 | 8 | 1/7 |
| same | 5 | 6 | 16/119 |
| same | 7 | 6 | 3/19 |
| same | 12 | 8 | 23/133 |
| same | 17 | 6 | 18/133 |
| same | 19 | 6 | 4/21 |

For the held fastest-deletion tuple, selecting pivot 6 at seed 29/42 gives
8/49>1/7; selecting pivot 7 at seed 25/36 gives 1/6>1/7. Its failed
pivot-11 branch therefore does not refute Q. In the second tuple, pivot 2
already reaches the exact target 1/7 at seed 67/72. Discarding equality
would incorrectly reject that valid branch.

The tight control (1,2,3,4,5,6) has maxima
`(1/7,1/7,1/7,1/7,1/7,1/35)`. It further checks the closed boundary and
shows why small unsuccessful margins on one deletion carry little evidence
about the quantified all-deletion statement.

## A genuine local radius loss, with the quantifiers kept separate

Take N=7, v=(1,2,3,4,6,11), and delete the speed 6. The seed s=1/6 is
an isolated own-margin seed in its local weak component: the speed 1 forces
s>=1/6 and speed 11 forces s<=1/6 in their current strong bands.
The surrounding weak component is exactly

`[L,R]=[1/7,13/77]`.

Its endpoint owners are 1 and 11. The exact symmetric radius is
`rho(s)=1/462`, so the protected ball is

`[s-rho,s+rho]=[38/231,13/77]`.

The pivot has norm zero at s, and F_6(s)=1/77<1/7. However the same weak
component contains the full witness u=1/7, whose norms are
`(1,2,3,3,1,3)/7`. That witness lies strictly left of the protected ball.
Thus the loss can arise from the symmetric-radius restriction alone, even
when moving within the whole weak component succeeds.

This is **not** a counterexample to Q: other seeds and other deletions of
this tuple succeed (indeed the all-seed pivot-6 maximum is 4/7). It is also
not a new refutation of the already held fastest-only component strategy.
The exact local example merely separates the two candidate mechanisms.

## Bounded discovery and remaining gap

After deriving the complete finite reduction, two bounded discovery passes
were run, with early termination as soon as any deletion supplied Q:

* 512 cases: three specified controls followed by 509 fixed-seed pseudorandom
  six-speed subsets of 1..40, with nonprimitive cases skipped by the same
  gcd filter. This completed in 0.810657 measured seconds. These are 512
  generated cases, not a claim of 512 primitive successes.
* Every six-speed subset of 1..16, exactly 8,008 cases, with nonprimitive
  tuples skipped. This completed in 4.864576 measured seconds.

Both passes had a declared 45-second deadline and finished their complete
finite case lists. Neither found a negative certificate. The second bound
is reproduced exactly below; it is not an unbounded exhaustive result.
Nonprimitive omission is harmless to the stated primitive screen, and Q is
also invariant under scaling all speeds by their gcd with time rescaled
inversely. No deduplication claim is made for the pseudorandom case list.

Separate controls (1,2,3,4,5,7), (1,2,3,4,6,8), (1,2,3,4,6,12),
the root-proposed residue tuple (1,6,8,13,15,20), and the analytically
selected (1,5,6,11,17,23) also satisfied Q. The residue tuple has isolated
full witnesses, but has other full intervals and does not trap all deletions.
These checks do not justify continuing a progressively larger search.

The surviving question is precisely a uniform lower bound of 1/N on at
least one of these all-deletion seed maxima, from the actual common-time
structure and nonempty seed sets. No implication establishing that bound
was found. The necessary trapping condition in Proposition 5 of the divisor
manuscript remains sound; this screen neither proves its converse nor
refutes the universal supply Q. A subsequent task should bring a new
structural argument or a motivated analytic family, not treat the finite
positive record as an induction step.

## Reproducer and evidence

The standard-library-only block below proves no unbounded theorem by
computation. Its algorithm is complete for each supplied tuple by the
manuscript reduction above. It retains no generated certificate tables.
Run the sole Python block with `python3 -B`; it replays the exact controls
and the two bounded case lists. No Lean invocation is involved.

```python
from fractions import Fraction as F
from functools import reduce
from math import gcd

def norm(y):
    z=y%1
    return min(z,1-z)

def intersect(A,B):
    out=[]
    i=j=0
    while i<len(A) and j<len(B):
        l=max(A[i][0],B[j][0]); r=min(A[i][1],B[j][1])
        if l<=r:
            if out and l<=out[-1][1]:
                out[-1]=(out[-1][0],max(r,out[-1][1]))
            else:
                out.append((l,r))
        if A[i][1]<B[j][1]:
            i+=1
        else:
            j+=1
    return out

def bands(v,margin):
    A=[(F(0),F(1))]
    for d in v:
        A=intersect(A,[(F(k,d)+margin/d,F(k+1,d)-margin/d) for k in range(d)])
    return A

def candidates(intervals,d):
    C={x for I in intervals for x in I}
    C.update(F(2*k+1,2*d) for k in range(d)
             if any(a<=F(2*k+1,2*d)<=b for a,b in intervals))
    return C

def audit(v,p,details=False):
    N=len(v)+1; delta=F(1,N); gamma=F(1,N-1)
    d=v[p]; old=v[:p]+v[p+1:]
    S=bands(old,gamma)
    if not S:
        return None
    def score(t):
        return norm(d*t)+d*min((norm(x*t)-delta)/x for x in old)
    best=max((score(t),t) for t in candidates(S,d))
    if not details:
        return best
    W=bands(old,delta)
    seeded=[(a,b) for a,b in W if any(a<=y and x<=b for x,y in S)]
    whole=max((norm(d*t),t) for t in candidates(seeded,d))
    balls=[]
    for l,r in S:
        containing=[(L,R) for L,R in W if L<=l<=r<=R]
        assert len(containing)==1
        L,R=containing[0]
        balls.append((max(L,2*l-R),min(R,2*r-L)))
    return S,best,seeded,whole,balls

v=(1,4,5,6,7,11)
expected=[F(6,49),F(10,77),F(9,77),F(8,49),F(1,6),F(3,28)]
for p,target in enumerate(expected):
    S,best,seeded,whole,balls=audit(v,p,True)
    assert len(S)==4 and best[0]==target
assert audit(v,3)[1]==F(29,42) and audit(v,4)[1]==F(25,36)
v=(2,5,7,12,17,19)
expected=[F(1,7),F(16,119),F(3,19),F(23,133),F(18,133),F(4,21)]
counts=[8,6,6,8,6,6]
for p,target in enumerate(expected):
    S,best,seeded,whole,balls=audit(v,p,True)
    assert len(S)==counts[p] and best[0]==target
assert audit(v,0)[1]==F(67,72)
v=(1,2,3,4,5,6)
assert [audit(v,p)[0] for p in range(6)]==[F(1,7)]*5+[F(1,35)]

v=(1,2,3,4,6,11)
S,best,seeded,whole,balls=audit(v,4,True)
assert S[0]==(F(1,6),F(1,6))
assert seeded[0]==(F(1,7),F(13,77))
assert balls[0]==(F(38,231),F(13,77))
rho=min((norm(d*F(1,6))-F(1,7))/d for d in v if d!=6)
assert rho==F(1,462) and 6*rho==F(1,77)
assert [norm(F(d,7)) for d in v]==[F(k,7) for k in (1,2,3,3,1,3)]
assert F(1,7)<balls[0][0] and best[0]==F(4,7)

from itertools import combinations
from random import Random
def has_Q(v):
    for p in range(len(v)):
        m=audit(v,p)
        if m is not None and m[0]>=F(1,len(v)+1):
            return True
    return False

rng=Random(20260906)
cases=[(1,2,3,4,5,6),(1,4,5,6,7,11),(2,5,7,12,17,19)]
cases += [tuple(sorted(rng.sample(range(1,41),6))) for _ in range(509)]
assert len(cases)==512
assert all(has_Q(v) for v in cases if reduce(gcd,v)==1)
count=primitive=0
for v in combinations(range(1,17),6):
    count+=1
    if reduce(gcd,v)==1:
        primitive+=1
        assert has_Q(v)
assert count==8008
for v in [(1,2,3,4,5,7),(1,2,3,4,6,8),(1,2,3,4,6,12),
          (1,6,8,13,15,20),(1,5,6,11,17,23)]:
    assert has_Q(v)
print('PASS: all-real exact maxima controls; local radius-loss control; '
      '512 fixed random/control cases; 8008 bounded tuples,',primitive,'primitive.')
```

Source bindings read for this task:

| Input | SHA-256 |
| --- | --- |
| `research/astra-uniform-divisor-minimality.md` | `8c4b6ee094f0f311f360d3abf371e95f731e28cee997d3810dd3218ff6f25746` |
| `LonelyRunner/FastRunnerInsertion.lean` | `dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5` |
| `research/astra-dense-pivot-induction.md` | `6267ff6fb165ba01d5f982fd4931342c3e594d1ca1ca765d0aa41f0813598446` |
| `research/astra-dense-pivot-review.md` | `151b0cdb8c701610e2c2e2e0508e11a9a630ae93f7c57e1d5010227b7187887b` |

The relevant existing Lean contract is `abs_circleNorm_sub_circleNorm_le`;
its proof was read. No new Lean formalization was attempted. Discovery
elapsed times above are actual measured search durations, not total worker
time. Total task elapsed time and per-model token usage are unmeasured/null.

Execution receipt for the persisted code: the complete block reached its final
PASS line after all assertions, reporting 7,980 primitive cases among the
8,008 bounded tuples. The surrounding metadata Python process then exited 1:
its unrestricted `exec` namespace let the block's integer loop variable `p`
overwrite the launcher's Path named `p`, so the subsequent `p.stat()` failed.
This occurred after the complete mathematical check, not inside it. A separate
metadata-only command succeeded, and the small control prefix was then run in
an isolated namespace with exit 0. The broad case lists were not repeated.
The enclosing shell subsequently ran the workflow validator and returned 0;
that shell status does not erase the preceding Python process's exit 1.

Exact final check output before that outer launcher failure:

`PASS: all-real exact maxima controls; local radius-loss control; 512 fixed random/control cases; 8008 bounded tuples, 7980 primitive.`

The frozen full Python block is 3,427 bytes, SHA-256
`ea6253ce7de5eed7e7c3f477858e09dcc2293f1fb0d93cf7656fd440c5e4d065`;
its small prefix before `from itertools import combinations` is 2,548 bytes,
SHA-256 `06763233c17ccd066245b00fffe001028d0b1f8b8aa225816941f2efe4b4b43f`. That prefix
replays all table maxima, closed-boundary and local-radius controls without
the discovery lists. Both hashes exclude code fences and the newline before
the closing fence. Final workflow validation exited 0. No research process
remains running; this task needs no `.lake` artifact or dependency source.

Complete first persisted-reproducer launcher, verbatim:

```bash
python3 -B - <<'PY'
from pathlib import Path
from hashlib import sha256
p=Path('research/astra-uniform-all-deletion-seed-screen.md')
s=p.read_text();exec(compile(s.split('```python\n',1)[1].split('\n```',1)[0],str(p)+':reproducer','exec'))
print('bytes',p.stat().st_size,'SHA256',sha256(p.read_bytes()).hexdigest())
PY
python3 scripts/validate_workflow.py
```

Complete returned output:

```text
PASS: all-real exact maxima controls; local radius-loss control; 512 fixed random/control cases; 8008 bounded tuples, 7980 primitive.
Traceback (most recent call last):
  File "<stdin>", line 5, in <module>
AttributeError: 'int' object has no attribute 'stat'
workflow structural validation passed; it cannot certify mathematical validity.
```

Complete small-prefix launcher, Python exit 0:

```bash
python3 -B - <<'PY'
from pathlib import Path
from hashlib import sha256
task_report=Path('research/astra-uniform-all-deletion-seed-screen.md')
source=task_report.read_text()
block=source.split('```python\n',1)[1].split('\n```',1)[0]
small=block.split('\nfrom itertools import combinations',1)[0]
exec(compile(small,str(task_report)+':small-controls','exec'),{})
print('small frozen controls passed')
print('full block bytes',len(block.encode()),'SHA256',sha256(block.encode()).hexdigest())
print('small block bytes',len(small.encode()),'SHA256',sha256(small.encode()).hexdigest())
PY
```

Complete returned output:

```text
small frozen controls passed
full block bytes 3427 SHA256 ea6253ce7de5eed7e7c3f477858e09dcc2293f1fb0d93cf7656fd440c5e4d065
small block bytes 2548 SHA256 06763233c17ccd066245b00fffe001028d0b1f8b8aa225816941f2efe4b4b43f
```
