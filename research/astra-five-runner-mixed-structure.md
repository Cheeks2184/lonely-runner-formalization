# Five-total-runner mixed structure from the four-runner seed

Requested Astra/xhigh task `/root/five_runner_mixed_structure`, 2026-09-05.
Source base `0e49249d9fcbba5e4a8312d845224bc11466db76`; only this manuscript
is owned. Project configuration, workflow, policy and active state were read;
`python3 -B scripts/validate_workflow.py` passed. Runtime routing is requested,
not independently attested. No Lean execution, dependency/cache access, source
edit, state edit or Git operation belongs to this task.

**Result: a sharper sufficient mixed insertion criterion, including an exact
three-pair arithmetic version, and a fixed obstruction to integer-multiple
conversion of a strict seed. K5 remains unresolved.** The interval-width and
determinant mechanisms are already in the accepted dense-pivot audit/review.
The additional input here is the now-proved four-runner mixed classification;
its unequal seed margins give a stronger five-runner parameter criterion.

## Quantifiers and inspected inputs

Fix natural `0<a<b<c<H`, `W=(a,b,c,H)`, and write `||x||` for circle norm.
K5 says that `exists t, all_w ||wt||>1/5` implies a possibly different `T>0`
with lower norms at least `1/5` and `||HT||>=1/4` at this same time. Write M
for that conclusion. Common positive integer scaling preserves both predicates.
None of the sufficient constructions below needs K5's strict premise.

The exact source theorem `LonelyRunner.fourRunnerMixed_iff`, for `0<a<b<c`, is
`FourRunnerMixed a b c iff not (b=2a and c=3a)`. Its predicate supplies one
positive time with margins `(1/4,1/4,1/3)`. `FourRunnerOrdinary.lean` supplies
`lowerCountPositiveIntegerHypothesis_five`. With this H5, the existing
`primitive_sorted_noMixed_height_le` gives the inclusive primitive bound
`H<=choose(5,2)^3=1000`; equality belongs to the unresolved finite side.
These are inspected repository interfaces, not new formal proofs in this note.

The accepted strict-to-mixed, modular units, published-family, deletion-gcd,
and stationary exact-supply equivalence audits/reviews were consulted. They
do not prove K5. The closed gcd branch and the published-family screen are not
reopened. The current failed-approach record rules out treating a trapped
component, one failed pivot formula, or a fixed global isometry as global
witness failure. No external mathematical result is imported here.

## Unequal seed margins and the stronger insertion criterion

Assume first `(b,c)!=(2a,3a)` and choose a four-runner mixed seed `t0` for
`(a,b,c)`. Put `d_a=d_b=1/4`, `d_c=1/3`, and `k_w=floor(w*t0)`.
The closed weak-good component containing this seed is the band intersection

```text
[L,R] = intersection_{w=a,b,c} [(k_w+1/5)/w,(k_w+4/5)/w].
```

It contains an open neighborhood of `t0`. If it contains no M time, every
point has `||Ht||<1/4`, so connectedness puts this closed interval inside
one open H-bad interval of length `1/(2H)`. Thus `R-L<1/(2H)` strictly.
This reasoning is conditional on the entire component missing M; it does
not infer global failure from a component. If one speed w owns both ends,
`R-L=3/(5w)>1/(2H)` since `w<=c<H`, a contradiction.

Otherwise let u own L and v own R, with u and v distinct. Their seed margins
give `t0-L>=(d_u-1/5)/u` and `R-t0>=(d_v-1/5)/v`. The three buffers are

```text
r_a=1/(20a),  r_b=1/(20b),  r_c=2/(15c).
```

Hence `R-L>=r_u+r_v`. All endpoint ties are harmless: choose any pair of
owners; the same-owner case was handled separately. Since `r_a>=r_b`, it
suffices that both `r_a+r_b` and `r_b+r_c` reach `1/(2H)`. Consequently

```text
H >= F(a,b,c) := max(10ab/(a+b), 30bc/(3c+8b))              (1)
```

implies M. Equality is admitted because the hypothetical bad interval is
open. A real witness S is made positive by `S+1-floor(S) in [1,2)`; this
integer shift preserves every original phase. No separate coordinate times
or strict conclusion are introduced.

In particular, `3H>=22b` implies (1). The first term is `<5b<22b/3`.
For the second, `3H>=22b` gives
`H(3c+8b)-30bc >= 8b(H-c)>0`. Thus the simple bound is also closed.

## Exact determinant refinement: three integer comparisons

For a distinct endpoint pair u,v, set
`K=u*(k_v+1)-v*k_u` and `g=gcd(u,v)`. The seed inequalities imply
`K>=v*d_u+u*d_v`, while g divides K, and

```text
R-L = (5K-u-v)/(5uv).
D_uv = 5g*ceil((v*d_u+u*d_v)/g)-u-v > 0.
```

The formula is symmetric in u,v; reversing the endpoint roles changes
neither seed-weight sum nor bound. Negative floors cause no exception.
Therefore M follows from the three closed comparisons

```text
2H*D_ab >= 5ab,   2H*D_ac >= 5ac,   2H*D_bc >= 5bc.         (2)
```

Here `D_ab=5g*ceil((a+b)/(4g))-a-b`; for `u in {a,b}`,
`D_uc=5g*ceil((3c+4u)/(12g))-u-c`. All ceilings can be evaluated by integer
division, without searching times or tuples. Criterion (2) is at least as
strong as (1), since `D_uv/(5uv)>=r_u+r_v`. It is sufficient, not necessary.
Both criteria scale correctly; so does the exact ceiling expression.

This reuses the accepted dense-pivot determinant proof. Its ordinary
insertion statement has an H-bad interval of length `2/(5H)`; here the
required fastest quarter changes that length to `1/(2H)`, and the c-seed
margin changes from quarter to third. Neither change may be omitted.

## The exceptional lower triple is completely covered

Suppose `(a,b,c)=(a,2a,3a)`. Divide W by `G=gcd(a,H)` and write the normalized
tuple `(A,2A,3A,K)`, where `gcd(A,K)=1` and `K>3A`. If `A>1`, the explicit
seed `1/(4A)` gives the lower three norms `(1/4,1/2,1/4)`. Shifts by j/A
preserve them and the coprime grid gives the outside norm at least `1/4`.
This uses an explicit seed; it does not require an unproved higher-count input.

If `A=1`, an admissible direct denominator exists unless both 4 and 5 divide
K: use 4 when `4` does not divide K, and otherwise 5 when `5` does not divide
K. The accepted N=5 modular theorem makes either case mixed. In the remaining
case `20|K`, take `T=1/4+1/(4K)`. The fastest norm is `1/4`; the three lower
norms are `1/4+1/(4K)`, `1/2-1/(2K)`, `1/4-3/(4K)`, respectively, all at
least `1/5` because `K>=20`. Rescale time by 1/G. Thus every such W is mixed,
and (1) or (2) need not be imposed on this exceptional family.

## Coverage comparison and remaining domain

An ordinary quarter seed and the small-shift lemma give M for `H>=5c`, with
closed equality: move the H-phase to quarter by at most `1/(4H)`, losing at
most `c/(4H)<=1/20` on each lower norm. The public `fastRunnerInsertion`
theorem only promises an ordinary fifth for the new coordinate; its stronger
fastest conclusion here follows from the inspected phase-adjustment lemma.
The preexisting interval mechanism with an ordinary quarter seed improves
this to `H>=10bc/(b+c)`. Replacing the c-buffer by `2/(15c)` yields (1),
which is no larger: the (a,b) term is bounded by the old (b,c) term, and
`30bc/(3c+8b)<10bc/(b+c)`.

The fixed tuple `(4,5,11,30)` is primitive, covers every denominator 2..5,
and every deletion has gcd 1. It fails `H>=5c` and the old harmonic bound
`275/8`, while the new terms are `200/9` and `1650/73`, both below 30.
Even the old uniform-quarter determinant width, adapted to the **mixed**
fastest-quarter target, fails on (5,11): its `D=4` requires `H>=275/8`.
The original ordinary determinant criterion already passes, with maximum
required height `55/2<30`; this is no new ordinary coverage. The improvement
compares mixed sufficient tests and exceeds the coarse insertion comparison.
Seed `2/15` has
lower norms `(7/15,1/3,7/15)` and integral fastest phase; `T=17/120` is
mixed with norms `(13/30,7/24,53/120,1/4)`.

Root's alternative `(9,10,40,67)` also passes (1) while failing basic and
old harmonic bounds, but the old determinant refinement already passes
(its largest required mixed height is `225/4`). It is a calibration control,
not evidence that the new criterion expands that old refined test.
This is improved *parameter coverage*, not a new interval method or proof
that every tuple beyond those compared filters was previously unresolved.

For completeness, the elementary first-lap interval gives M if `4H<=15a`:
take `T=max(1/(5a),1/(4H))`, so all lower phases lie in `[1/5,3/4]` and
the fastest phase lies in `[1/4,3/4]`. This is existing elementary coverage.

Consequently a primitive counterexample to K5 must satisfy all of:
`H<=1000`, `c>=5`, `15a<4H`, `H<F(a,b,c)` (hence `3H<22b` and `H<5c`),
failure of at least one comparison (2), gcd 1 after every deletion, and a
retained multiple of each of 3,4,5. It must have an ordinary component of
positive width and have no M time anywhere. The `c>=5` condition is the
accepted positive-width endpoint obstruction; it is not a new deduction here.
These necessary conditions are not a classification or an enumeration.

## A strict seed need not convert through any integer multiple

Take `W=(3,4,5,11)` and `t0=1/9`. Its norms are
`(1/3,4/9,4/9,2/9)`, all strictly greater than `1/5`. For integer multiples
k*t0, the fastest residue is 2k modulo 9. Its norm reaches quarter only
for `k=2,3,6,7 mod 9`. At 2,7 speed 4 has residue +/-1, below fifth; at
3,6 speed 3 has residue zero. Hence no integer multiple of this strict seed
is mixed. Nonetheless `T=1/8` is mixed, with norms `(3/8,1/2,3/8,3/8)`.
This refutes only conversion of an arbitrary strict seed by integer dilation.
It is distinct from, and does not repair, the previously retired isometry
route; it gives no evidence of global M failure.

K5 is still plausible in the limited sense that these deductions yield no
counterexample, but that is not positive evidence for its truth. The unresolved
step is global existence in the remaining bounded region, not certificate
construction once M is known (the accepted stationary S/M equivalence handles
that). A useful next action is to assess a resource-bounded certificate design
using the three exact pair comparisons as a cheap prefilter, before authorizing
any enumeration. Further growth of this seed-width argument alone has no
established route to the global statement. This bounded branch stops here.

## Fixed verification and provenance

The closed-boundary fixture `(12,20,24,75)` has lower mixed seed `3/16` and
weak component `[11/60,19/100]`, of width `1/150=1/(2H)`. Both endpoints
are M times; all interior points have fastest norm below quarter. The pair
(12,20) attains equality in (2). This tests the strict/open distinction.

The sole program checks six explicitly named tuples: the stronger comparison,
root's calibrated comparison, the closed-boundary fixture, the modulus-nine
obstruction, and lower-exception cases `(2,4,6,7)` and `(1,2,3,20)`.
It checks all nine residues only for the named modulus-nine orbit. The printed
source hashes guard all four relevant Lean interfaces and the consulted
manuscripts/reviews; the program reads source bytes, not compiled dependencies.
No tuple enumeration, imported source-program replay, or background work occurs.

```python
from fractions import Fraction as Q
from hashlib import sha256
from itertools import combinations
from math import floor, gcd
from pathlib import Path
sources = '''
ae47b419c5b4cebfa72a325bdb50cd32e03444c39850a74b885037d83e312a5c LonelyRunner/FourRunnerMixed.lean
2fb2f5c9c0742daa3278ee0ddeacd8643e1e22f8c885de95f5f38e10734b29f6 LonelyRunner/FourRunnerOrdinary.lean
dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5 LonelyRunner/FastRunnerInsertion.lean
cb41059260b943411e2ab5360b84b59cd13f2ddf352c3c50a0b3715b9b9987d6 LonelyRunner/FiniteHeightReduction.lean
6267ff6fb165ba01d5f982fd4931342c3e594d1ca1ca765d0aa41f0813598446 research/astra-dense-pivot-induction.md
151b0cdb8c701610e2c2e2e0508e11a9a630ae93f7c57e1d5010227b7187887b research/astra-dense-pivot-review.md
c7559719cc61d715a47958ab8d1a844faf021c53e08ee3e87c1d0d54e0fb5f2f research/astra-strict-to-mixed-audit.md
6f0ba11b6640b662eb72a86326a1b7d429444e61a1a78b60a8d1b8b8e06a466d research/astra-strict-to-mixed-review.md
a9ac1da5754a1ef8921ad22f3f28785a4dc841e2a2cfa1bd3a04f338224fcb01 research/astra-direct-to-mixed-units.md
c424fc7970ade6a65e5388e0b3f60a34e091c01f2603f154646301bb5b9c96f5 research/astra-direct-to-mixed-units-review.md
717995d2f3adfdea64d09f8022493c31e2a606262c5361fee37ca1fc9879a7c4 research/astra-tight-family-mixed-audit.md
21f054285e1d2103b961598d1da00fdf51afcc96c672057ad9b435bf51fb80da research/astra-tight-family-mixed-review.md
8c97c3362518d753624e0dad27bd605f2b5e73452adf37d0310e33686c91b3e7 research/astra-mixed-codimension-one-gcd.md
9f7f0e43e17f10a679e67a6945ab24b494dd2bf59d4e300233933371b4e3eb32 research/astra-mixed-codimension-one-gcd-review.md
f340c0a311ed6e04d802ee8edfb407a84bc329145bc7e9b446d692cd4e52430a research/astra-mixed-supply-equivalence-review.md
0403daa0e9cde6458575d16b2173a1178ee4f2842c21b9a688ba791417f02cbb docs/failed-approaches.md
'''
for line in sources.strip().splitlines():
    digest, path = line.split()
    assert sha256(Path(path).read_bytes()).hexdigest() == digest
def norm(x): return min(x % 1, (-x) % 1)
def mixed(W, t):
    return t > 0 and all(norm(w*t) >= Q(1,5) for w in W) and norm(W[-1]*t) >= Q(1,4)
def ceilings(V, upgraded):
    d = {w: Q(1,3) if upgraded and w == V[-1] else Q(1,4) for w in V}
    out = []
    for u, v in combinations(V, 2):
        g = gcd(u,v); x = (v*d[u]+u*d[v])/g
        K = g*((x.numerator+x.denominator-1)//x.denominator)
        D = 5*K-u-v
        assert D > 0
        out.append(Q(5*u*v,2*D))
    return max(out)
W=(4,5,11,30); a,b,c,H=W
assert gcd(*W)==1 and all(gcd(*(W[:i]+W[i+1:]))==1 for i in range(4))
assert all(any(w%d==0 for w in W) for d in range(2,6))
assert H<5*c and H<Q(10*b*c,b+c) and 4*H>15*a and 3*H<22*b
assert (Q(10*a*b,a+b),Q(30*b*c,3*c+8*b))==(Q(200,9),Q(1650,73))
assert ceilings(W[:-1],True)==Q(275,18)<H<ceilings(W[:-1],False)==Q(275,8)
assert Q(4,5)*ceilings(W[:-1],False)==Q(55,2)<H
assert [norm(w*Q(2,15)) for w in W]==[Q(7,15),Q(1,3),Q(7,15),Q(0)]
assert [norm(w*Q(17,120)) for w in W]==[Q(13,30),Q(7,24),Q(53,120),Q(1,4)]
assert mixed(W,Q(17,120))
print('new mixed coverage: ordinary bound=55/2; old mixed bound=275/8; new exact bound=275/18')
W=(9,10,40,67)
assert ceilings(W[:-1],False)==Q(225,4)<W[-1]
assert max(Q(900,19),Q(60))<67<Q(80) and mixed(W,Q(9,268))
print('calibration: old determinant mixed bound=225/4 already passes')
W=(12,20,24,75); seed=Q(3,16)
assert all(norm(w*seed)>=Q(1,4) for w in W[:-1]) and norm(24*seed)>=Q(1,3)
L=max((floor(w*seed)+Q(1,5))/w for w in W[:-1])
R=min((floor(w*seed)+Q(4,5))/w for w in W[:-1])
assert (L,R,R-L)==(Q(11,60),Q(19,100),Q(1,150))
assert ceilings(W[:-1],True)==75 and mixed(W,L) and mixed(W,R)
assert norm(75*L)==norm(75*R)==Q(1,4) and not mixed(W,seed)
S=L-2; T=S+1-floor(S)
assert 1<=T<2 and mixed(W,T)
print('closed boundary: component=[11/60,19/100]; width=1/150; exact pair equality')
W=(3,4,5,11); seed=Q(1,9)
assert all(norm(w*seed)>Q(1,5) for w in W)
assert [k for k in range(9) if norm(11*k*seed)>=Q(1,4)]==[2,3,6,7]
assert not any(mixed(W,k*seed) for k in range(9)) and mixed(W,Q(1,8))
print('integer dilation: 9 residues excluded; global mixed witness=1/8')
assert mixed((2,4,6,7),Q(5,8)) and mixed((1,2,3,20),Q(21,80))
print('lower exception: explicit gcd-grid and 20-divisible controls passed')
print('PASS: 16 source guards; 6 named tuples; no tuple search')
```

Executed command, completed with exit 0:

```bash
python3 -B - <<'PY'
from pathlib import Path
from hashlib import sha256
from contextlib import redirect_stdout
import io,re
raw=Path('research/astra-five-runner-mixed-structure.md').read_text()
blocks=re.findall(r'^```python\n(.*?)^```[ \t]*$',raw,re.M|re.S)
assert len(blocks)==1
out=io.StringIO()
with redirect_stdout(out):
    exec(compile(blocks[0],'five-runner-fixed-controls','exec'),{})
print(out.getvalue(),end='')
print('program_sha256='+sha256(blocks[0].encode()).hexdigest())
print('stdout_sha256='+sha256(out.getvalue().encode()).hexdigest())
PY
```

Exact program stdout (including final newline):

```text
new mixed coverage: ordinary bound=55/2; old mixed bound=275/8; new exact bound=275/18
calibration: old determinant mixed bound=225/4 already passes
closed boundary: component=[11/60,19/100]; width=1/150; exact pair equality
integer dilation: 9 residues excluded; global mixed witness=1/8
lower exception: explicit gcd-grid and 20-divisible controls passed
PASS: 16 source guards; 6 named tuples; no tuple search
```

Raw extracted program SHA-256:
`a3ce150750a3bed484dbfb49db945916dec76b4c107fc14402edfb7a74925ff1`.
Raw stdout SHA-256:
`e07bfc14aa3e408b54da5646a5fd59fd0fe73bbde147d27dd9bea0d88a6c0021`.
Only the owned manuscript was written. All commands have stopped. Final raw
manuscript hash is reported at handoff, avoiding a self-referential digest.
This is a manuscript result awaiting independent review, not a Lean theorem
or a proof/refutation of K5. The unrestricted LRC goal remains unresolved.
