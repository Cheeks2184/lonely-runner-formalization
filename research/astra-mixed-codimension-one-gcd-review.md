# Independent review of mixed supply from a deletion gcd

Assigned Astra/xhigh review by `/root/mss_published_bound_audit`, source
`0e49249d9fcbba5e4a8312d845224bc11466db76`. This review and the separate
canonical-plan review are the only owned files. Current project instructions,
policy and active state were read; workflow validation passed. Requested
routing is recorded without claiming independent runtime attestation.

**Verdict: accept the conditional deduction and close this redundant branch.**
No mathematical correction is required. Under H_N, N>=5, a deletion gcd
larger than the full gcd supplies a single positive time with every original
norm at least 1/(N-1), and hence a fastest-mixed time. This is a necessary
filter on potential mixed failure, not a sufficient criterion for failure,
new ordinary coverage, a resolution of the gcd-one remainder, or an LRC result.
No new formal wrapper is justified without a concrete downstream caller.

## Counts, effective grid and shared margins

Let W have N-1 distinct positive integer speeds, remove any h, and write
I=W minus {h}. Its N-2 entries are positive and distinct, so the exact H_N
definition supplies an I-witness at alpha=1/(N-1). The seed time may be any
real number. Write D=gcd(I)>0 and G=gcd(W)=gcd(D,h)>0. Since G divides D
and h, the reduced pair h/G,D/G is coprime. Put m=D/G.

At times T0+j/D every speed in I changes phase by an integer. Thus its full
alpha margin is preserved, including equality and any fastest speed retained
in I. The omitted phase changes by j*(h/G)/m; coprimality makes its orbit
exactly a translated uniform m-point grid. The existing coprime-grid lemma
gives an integer j for which that norm is at least (m-1)/(2m).
The condition

```
2*m <= (N-1)*(m-1)
```

is exactly the comparison of this uniform mesh guarantee with alpha.
It is sufficient, not necessary for a particular tuple or seed to succeed.
For N>=5 and D>G, m>=2 and (m-1)/(2m)>=1/4>=alpha. The retained speeds
and the omitted speed therefore all meet alpha at one time S. The integer
time shift T=S+1-floor(S) lies in [1,2), and positive integer speeds make
every phase change an integer. Positivity and all simultaneous inequalities
are therefore preserved. The omitted speed need not be the maximum.

Primitivity specializes G to one. Thus any primitive no-mixed tuple at
N>=5 under H_N must have gcd one after every deletion. Without normalization,
every deletion gcd must equal G: it is already a positive multiple of G,
and a larger one would supply mixed. Positive scaling preserves D/G and
transports witnesses by the inverse scale. Raw D>1 is not enough when G>1.
The lower-count premise is used only to obtain the stronger seed; an explicit
seed for I at alpha can replace it.

## Closed boundaries and negative controls

N=5,m=2 is a closed equality case: the translated grid {1/4,3/4} has maximum
norm exactly 1/4. No strict alpha conclusion follows. At N=4 the mesh
condition requires m>=3, with equality at m=3. The m=2 mesh gives only 1/4,
below alpha=1/3.

For W=(1,2,6), I=(2,6), both lower norms at T0=1/4 are 1/2, but the omitted
two-point orbit has both norms 1/4. The stronger all-third claim is globally
false: norm(T)>=1/3 and norm(2T)>=1/3 force fractional part T to be either
1/3 or 2/3, at which norm(6T)=0. Nevertheless T=5/18 is mixed, with norms
(5/18,4/9,1/3). This is a counterexample to the overstrong all-coordinate
claim at N=4,m=2, not a mixed or ordinary counterexample.

For W=(2,4,6,8), I=(2,4,6), D=G=2 and the given quarter seed T0=1/8 is
valid. An all-quarter time would separate the five points
0,2T,4T,6T,8T pairwise by at least 1/4, since each nonzero pair difference
is one of the four listed speeds up to sign. The five cyclic gaps would
sum to at least 5/4, contradicting circumference one. This proves the global
negative all-quarter claim analytically; failure of its one-point orbit is
not being used as proof of global absence. The tuple is mixed at T=1/5,
with norms (2/5,1/5,1/5,2/5), independently confirming the scope distinction.

The stronger seed matters when the fastest speed remains in I. As an extra
fixed control, W=(1,2,6,10) is ordinarily good at T0=2/9, but its fastest
norm is 2/9<1/4. Removing h=1 gives gcd(I)=2; every shift by j/2 preserves
that inadequate fastest norm. Thus this orbit cannot upgrade that weak seed
to mixed. This does not refute existence elsewhere or the H_N deduction.
By contrast, the scaled tuple (5,10,30,50) has D=10>G=5 and all-alpha at
T=1/20, with norms (1/4,1/2,1/2,1/2). These controls use fixed tuples only.

## Existing interfaces and research disposition

`exists_int_grid_circleNorm_ge` and its coprime variant have the exact closed
mesh estimate for every real starting phase, with an integer shift and no
positivity condition on that shift. The proof of
`codimensionOneDivisorInsertion` retains old phases by an explicit integer
identity, but weakens their 1/(n+1) seed in its public conclusion to 1/(n+2).
It cannot be applied as if its public type already asserted the stronger
conclusion here.

In the primitive specialization, let g0=gcd(I). The existing insertion
parameters are n=N-2, dividedSpeeds=w/g0, D=m=g0, factor g=1, c=h,
exceptional=h, and s=g0*T0. Its old threshold is alpha; its public closure
condition is 2*g0<=N*(g0-1). The stronger comparison in this manuscript is
2*g0<=(N-1)*(g0-1). Using the coprime-grid helper directly and retaining
the old alpha margins proves the stated claim. An optional later extraction
could return the old margins and new mesh estimate together, but should keep
all old public types intact and be driven by a concrete caller.

The accepted endpoint-label audit/review already derive the effective orbit
D/gcd(D,h), exact preservation of old phases and arbitrary allowed mesh
thresholds. Their extra same-row certificate preservation is not needed here.
The accepted strict-to-mixed audit/review handle deletion of the maximum,
where ordinary seed margins suffice for the lower coordinates; the present
arbitrary-deletion statement correctly retains the stronger alpha seed when
the maximum may stay in I. Nothing in this argument extends the ordinary
coverage provided by the existing divisor method. The all-deletions filter
records the correct remaining domain and closes this research branch.

## Reproducible fixed checks and provenance

The frozen author manuscript has SHA-256
`8c97c3362518d753624e0dad27bd605f2b5e73452adf37d0310e33686c91b3e7`.
Its sole program SHA is
`089485ecefa835cc260c52d96361e36a8f1fed21c7cee05a589e05523a47bcb1`;
its independently reproduced stdout SHA is
`361ecfdaeec0fdcb4e505b851eb4557f69e06bb714b23fd7d6357fe93fcff8a8`.
The six source guards passed. Exactly the author's four named fixtures and
eight orbit points were replayed. The negative representative normalization
is correctly [1,2), and the two successful fixtures retain the actual maximum
inside I. The three extra fixed controls above are separate and are not
included in the author's four-fixture/eight-point totals.

Run the following sole Python block from the repository root with
`python3 -B`. It guards and replays the author's block in memory, then checks
the three specified additional controls. It writes no file and launches no
child process. The global negative claims rest on the analytic proofs above.

```python
from pathlib import Path
from hashlib import sha256
from contextlib import redirect_stdout
from fractions import Fraction as Q
from math import gcd
import io,re

p=Path("research/astra-mixed-codimension-one-gcd.md")
assert sha256(p.read_bytes()).hexdigest()=="8c97c3362518d753624e0dad27bd605f2b5e73452adf37d0310e33686c91b3e7"
fence=chr(96)*3
blocks=re.findall(r"^"+fence+r"python\n(.*?)^"+fence+r"[ \t]*$",p.read_text(),re.M|re.S)
assert len(blocks)==1
assert sha256(blocks[0].encode()).hexdigest()=="089485ecefa835cc260c52d96361e36a8f1fed21c7cee05a589e05523a47bcb1"
out=io.StringIO()
with redirect_stdout(out):
    exec(compile(blocks[0],"gcd-independent-review","exec"),{})
assert sha256(out.getvalue().encode()).hexdigest()=="361ecfdaeec0fdcb4e505b851eb4557f69e06bb714b23fd7d6357fe93fcff8a8"
print(out.getvalue(),end="")

def norm(x):
    return min(x%1,(-x)%1)

W=(1,2,6,10)
I=(2,6,10)
T0=Q(2,9)
assert gcd(*W)==1 and gcd(*I)==2
assert all(norm(w*T0)>=Q(1,5) for w in W)
assert norm(10*T0)==Q(2,9)<Q(1,4)
for j in (0,1):
    t=T0+Q(j,2)
    assert all(norm(w*t)==norm(w*T0) for w in I)
    assert norm(10*t)<Q(1,4)
print("PASS: a weak ordinary seed leaves the retained fastest norm below alpha")

W=(2,4,6,8)
T=Q(1,5)
assert gcd(*W)==gcd(*W[:-1])==2
assert all(norm(w*T)>=Q(1,5) for w in W)
assert norm(8*T)==Q(2,5)>=Q(1,4)
print("PASS: the D=G all-alpha obstruction still has a mixed time")

W=(5,10,30,50)
I=(10,30,50)
T=Q(1,20)
assert gcd(*I)==10 and gcd(*W)==5
assert gcd(*I)//gcd(*W)==2
assert all(norm(w*T)>=Q(1,4) for w in W)
assert [norm(w*T) for w in W]==[Q(1,4),Q(1,2),Q(1,2),Q(1,2)]
print("PASS: a nonprimitive D>G scale inherits all-alpha at one positive time")
```

| Inspected source | SHA-256 |
| --- | --- |
| `LonelyRunner/DivisorInsertion.lean` | `212fa6d879bab6d70f09a4a43b2027b96724b5e5ac4a22cdf4b368509973166f` |
| `LonelyRunner/LowerCountSupply.lean` | `0705291adc53011fb72fc718a7260876512b092741442d6a6cceb4b76eb5ccf4` |
| `research/astra-strict-to-mixed-audit.md` | `c7559719cc61d715a47958ab8d1a844faf021c53e08ee3e87c1d0d54e0fb5f2f` |
| `research/astra-strict-to-mixed-review.md` | `6f0ba11b6640b662eb72a86326a1b7d429444e61a1a78b60a8d1b8b8e06a466d` |
| `research/astra-endpoint-label-audit.md` | `667b9bcdebf30333c551badf6e9ef6c861e5e1ca1095808ece5354733745e44d` |
| `research/astra-endpoint-label-review.md` | `865f434052997ff1cd0b9d6fdd5c4a23c792feb409c9e3b492ccb009076e01e7` |

The final review program exited zero. Its exact source SHA-256, including
the final newline, is
`1bfa717c03552ed33ee9f3f6f0c14024cd4693bb23791747f934eadea4564f16`;
its stdout SHA-256 is
`339d287c83260d5cee891907647b6c85bc3d64d333962fd8e11387de116b1e4d`.
The stdout is:

```text
N5_g2_closed: orbit=2, outside_max=1/4
N4_g3_closed: orbit=3, outside_max=1/3
N4_g2_insufficient: orbit=2, outside_max=1/4
N5_nonprimitive: orbit=1, outside_max=0
PASS: 6 source guards; 4 fixed fixtures; 8 orbit points; no tuple search
PASS: a weak ordinary seed leaves the retained fastest norm below alpha
PASS: the D=G all-alpha obstruction still has a mixed time
PASS: a nonprimitive D>G scale inherits all-alpha at one positive time
```

Other commands were scoped source/interface reads, hash inspection and the
workflow validator. No new literature, tuple discovery or broad enumeration,
Lean command, build, Git mutation, shared-state change or cache operation was
performed. Only the two owned review artifacts were written for this assignment.
All processes stop at handoff. Final source guards, program hash and readback
precede freezing; this review's own hash is reported separately. The
unrestricted canonical LRC goal remains unresolved.
