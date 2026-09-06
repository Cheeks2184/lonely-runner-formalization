# Resource-bounded design for a five-runner certificate

Requested Astra/xhigh task `/root/five_runner_certificate_design`.
Frozen base `5a621b8065fdbc69694168e6d406824b1fa23cff`; pending Pass35 source
interfaces are separately hash-bound below. Only this manuscript is owned.
Current configuration, workflow, policy and state were read, and
`python3 -B scripts/validate_workflow.py` passed. The goal is active and
unrestricted LRC remains unresolved. Routing is requested, not independently
attested. This task runs no Lean, accesses no compiled dependencies, installs
nothing, and changes no source, state, Git or cache.

**Recommendation: do not scale the four-runner flat finite check to Fin 1001.
First build a reusable rational-margin checker, a nonuniform endpoint helper
and a strict pair-sum completeness wrapper, then assess a compressed coverage
certificate.** The
height theorem makes the target finite; it does not make a row-by-row kernel
proof affordable, establish K5, or supply any missing finite certificate.
If a positive certificate of comparable size is available, proving ordinary
five-runner supply directly is more useful than proving K5 alone.

## Exact finite targets and normalization

For `W=(a,b,c,H)` with natural `0<a<b<c<H`, write O for existence of a real
time with every norm at least `1/5`, Q for existence with every norm strictly
greater than `1/5`, and M for one positive time with lower norms at least
`1/5` and fastest norm at least `1/4`. K5 is `Q -> M` for every such W.

Set `G=gcd(a,b,c,H)>0` and `V=W/G`, coordinatewise. V is positive, strictly
increasing and primitive. For every real t, `||(G*v)t||=||v*(G*t)||`;
the inverse time substitution divides by G and preserves positivity. Hence
O, Q and M, and each of their negations, are invariant under normalization.
The direct denominator predicate is not scaling invariant and must be tested
on V when used as a primitive filter.

`lowerCountPositiveIntegerHypothesis_five` supplies H5. With `m=3` and the
stationary tuple `(0,V)`, `primitive_sorted_largeHeight_stationary_mixed`
gives M when `H(V)>choose(5,2)^3=1000`. Its converse
`primitive_sorted_noMixed_height_le` retains **H<=1000**, including equality.
Thus K5 is equivalent, under this established H5 input, to

```text
for every primitive 0<a<b<c<H<=1000: Q(W) -> M(W).             (FK)
```

A sound finite proof may return either an M certificate or a proof of not Q
for each row. Checking M for every bounded row is a stronger sufficient
target, not the definition of FK. Finding a counterexample to FK requires
both a strict Q witness and a complete proof of global M absence.

Closed O and strict Q must remain distinct. `(1,2,3,4)` has only ordinary
times k/5 with k a unit modulo 5, so Q is false, but M holds at 2/5.
The accepted global no-M consecutive families occur at total counts 3,4,6;
they have no strict ordinary point. They do not establish an N=5 no-M family.
No classification of tight N=5 tuples, or uniform N=5 mixed existence, is
assumed. A not-Q certificate alone permits O to be empty or to consist only
of boundary points; it does not prove ordinary LRC for that row.

## Reusable checkers and missing wrappers

At a rational time `p/q`, take `p>0`, `q>0`, and `r_w=(w*p)%q`. The mixed
certificate consists of eight natural inequalities:

```text
q <= 5r_w <= 4q   (w=a,b,c),       q <= 4r_H <= 3q.          (R)
```

Replacing the final 4,3 by 5,4 certifies O. A generic checker parameterized
by the four denominator thresholds can share one soundness proof using
`PivotResidues.circleNorm_nat_div_eq`. `fourRunnerMixedRowOK_sound` is a
working fixed-threshold implementation pattern, but its private quarter/third
helpers and three-coordinate conclusion are not the N=5 checker already.
For the longer-lived implementation, root suggests rational margins n_i/d_i:
check `n_i*q<=d_i*r_i` and `d_i*r_i+n_i*q<=d_i*q`, with positive denominators.
This avoids natural subtraction and specializes to (R) at n_i=1. Positive
numerators are required by the positive-endpoint completeness statement;
row soundness itself also permits zero margins.

There is useful existing completeness for **strict ordinary**. The theorem
`PairSumCompleteness.exists_pairSum_time_of_witness` takes any real margin
delta>0 and preserves it at a positive time `r/(u+v)`, with distinct retained
speeds u,v and `0<r<u+v`. Given Q, the minimum of the four attained norms is
some delta>1/5; apply that theorem. Therefore a short additional wrapper proves

```text
Q(W) iff some pair u<v and 0<r<u+v has
        5*cyclicResidueDistance(u+v,r*w) > u+v for every w.   (Qfinite)
```

Its reverse direction is the same residue identity. Failure can be certified
by checking that for every such pair/r, some coordinate satisfies `5*dist<=q`.
Equality is accepted in the rejection test because Q is strict. There are six
pairs, each denominator at most 1999. Reflection permits `1<=r<=floor(q/2)`;
the total is below 6000 candidates per row. This needs a new small wrapper,
not a new extremal argument. The existing ordinary pair-sum completeness
theorem must not be read as preserving the special fastest quarter margin.

For complete M decision, fix floors at any normalized M time. The nonempty
closed intersection of its four rational good bands has a rational left
endpoint, which is one of

```text
(5k+1)/(5w),  w in {a,b,c}, 0<=k<w;
(4k+1)/(4H), 0<=k<H.                                      (E)
```

That endpoint is still M, even for a singleton intersection. Periodicity and
reflection ensure some left endpoint lies in `(0,1/2]`; each speed contributes
exactly ceil(w/2) candidates before duplicates. Thus at H<=1000 there are at
most 1998 candidates, and reduced denominators are at most
`max(5c,4H)<=4995`. No approximation of a strict point is needed.
This finite-endpoint completeness wrapper is not currently a public Lean
theorem. It is needed for complete negative M certificates or total decision,
but positive rows using (R) need only soundness.

`PivotBoundary.exists_witness_iff_exists_pivot_certificate` and
`PairSumCompleteness.exists_witness_iff_pairSumCertificate` already give
complete **ordinary** finite formulations. `ModularCertificates` and
`KernelCoverCertificates` supply sound finite-union estimates, not a complete
mixed checker or a universal supply of successful union bounds. Their mere
presence is not permission to assume every row has a certificate of that form.

## Filters and algebraic resource accounting

There are `choose(1000,4)` increasing positive quadruples before primitivity.
The existing N=4 pattern quantifies over all `Fin 37` keys and short-circuits
invalid ones. Its literal N=5 analogue visits `1001^4` keys before checking
ordering or arithmetic filters; that is not an appropriate design.

The pending Pass35 public source includes `fiveRunnerMixed_exceptional` and
`fiveRunnerMixed_of_buffer_inequalities`, with the latter requiring

```text
10ab <= H(a+b),        30bc <= H(3c+8b).
```

Its closed coarse corollary is `22b<=3H`. The accepted manuscript-only
additional filters are direct D (equivalently a missing divisor among 3,4,5),
a deletion gcd greater than the full gcd, the first-lap condition `4H<=15a`,
and the stronger ceiling/determinant comparisons. Generic public mixed
wrappers for these filters are not all already implemented. A kernel coverage
checker may omit a row only after calling a proved sufficient theorem; a
Python predicate or accepted manuscript alone is not a kernel exclusion.

Several exact counts can be obtained without examining quadruples. For a
bound B, let C(B;D) count four-element subsets that contain a multiple of
every d in a finite divisor list D. Inclusion-exclusion gives

```text
C(B;D) = sum_{S subset D} (-1)^|S| choose(A(B;S),4),
A(B;S) = sum_{T subset S} (-1)^|T| floor(B/lcm(T)), lcm(empty)=1.
```

Then C(1000;{3,4,5}) counts raw direct failures exactly. Primitivity can also
be imposed algebraically, despite D's failure of scaling invariance:

```text
sum_{g=1}^{250} mu(g) C(floor(1000/g);
                     {d/gcd(d,g): d=3,4,5}).               (P)
```

A reduced divisor 1 is automatic. Formula (P) is ordinary Möbius inversion
of the common-gcd condition; it is an arithmetic count, not a tuple scan.
It does not impose every-deletion gcd one or the geometric tests.

For the first-lap and coarse-buffer filters together, put
`L=ceil(4H/15)`, `K=floor(3H/22)`. They exclude disjoint regions because
`L>K`: respectively a>=L and b<=K. The exact remaining ordered count is

```text
sum_{H=4}^{1000} [choose(H-1,3)-choose(H-L,3)
                  -K(K-1)(3H-2K-5)/6].                   (G)
```

The stronger two-inequality filter also admits an exact counting formula.
For each H,b, first impose `1<=a<=min(b-1,L-1)` and `b+1<=c<=H-1`.
If `10b<=H`, no pair in these ranges survives the buffer criterion. Otherwise
survival means `a>Hb/(10b-H)` **or** `c>8Hb/(30b-3H)`.
The union is two rectangles in the (a,c) integer grid, so its count is
`A1*C0+(A0-A1)*C1`, where A0,C0 are full interval sizes and A1,C1 count the
respective strict tails. Summing over H,b counts this geometric residual
without visiting quadruples. It still does not incorporate divisibility or
all deletion gcds. No value for the fully filtered count is claimed here.

The sole program below evaluates (P), (G), and their elementary inputs:

| Counted domain, B=1000 | Exact count |
| --- | ---: |
| Literal `Fin 1001` four-coordinate keys | 1,004,006,004,001 |
| Increasing positive quadruples | 41,417,124,750 |
| Primitive increasing quadruples | 38,291,807,495 |
| Raw direct failures | 13,420,342,515 |
| Primitive direct failures | 12,052,892,146 |
| First-lap and coarse-buffer residual, before gcd/divisor filters | 23,010,550,937 |

The last two rows are separate filtered counts, not consecutive stages. Their
minimum is an upper bound on a jointly filtered residual, not its exact count
or a lower bound. The full two-inequality, deletion-gcd and determinant filters
have not been counted here. Do not report billions as their proven remaining
size or report the residual as small without additional counting. A hypothetical
four-byte witness packet for every raw increasing row would occupy
165,668,499,000 bytes before indices or proof overhead; a shared catalogue can
avoid that storage but cannot itself eliminate flat finite-key traversal.
None of these arithmetic counts is a certificate that M exists on any row.

## Compression and concrete next step

A global catalogue of rational times can be much smaller than one witness
per tuple, but a small catalogue alone does not avoid traversing every tuple:
the current four-runner certificate still kernel-checks every finite key.
For fixed H, each candidate t with `||Ht||>=1/4` covers all lower triples
drawn from `S_t={w<H:||wt||>=1/5}`. This is coverage of a three-uniform
hypergraph, not merely coverage of individual speeds or pairs. Pair coverage
alone leaves a three-way common-time obligation.

A possible compressed certificate is a partition tree of integer parameter
boxes, with leaves marked invalid-order, proved analytic filter, explicit
rational witness, or (for FK only) proved not-Q. For a witness leaf, retain
one floor index per coordinate and verify the linear residue-band inequalities
at both coordinate interval endpoints; every integer speed between then has
the required band. A split must partition its parent completely. A kernel
checker can prove the root domain by structural induction, with cost tied to
leaf count rather than to 41 billion singleton rows. Residue-class leaves can
similarly share a witness if their modular soundness is proved.

Missing: a small complete partition/catalogue for the remaining domain.
Neither the height bound, a heuristic set cover, nor a collection of sampled
successful boxes proves that such a small certificate exists. Do not launch
the full search on that assumption. A soundness theorem and measured leaf
cost must precede a resource budget for certificate discovery.

The immediate executable work is bounded: implement the generic natural
residue-row checker/soundness lemma, the nonuniform endpoint helper (E), and
the strict pair-sum wrapper, validating only the fixed examples below with
ordinary kernel reduction and retaining all current public theorem types.
`int_band_of_circleNorm_ge`, `circleNorm_ge_of_int_band` and a finite maximum
of left endpoints supply (E); no new analytic theorem is needed. Then prototype
the partition checker on a small explicit hand-written tree. Proposed pilot
caps are 256 leaves, 64 KiB of proof data, 60 seconds per kernel check and
4 GiB maximum process RSS. These are stop conditions, not measured guarantees;
revise the representation instead of silently increasing the pilot budget.
Any full-domain discovery needs a separately reviewed measured budget. This
manuscript authorizes no such scan.

Prefer a direct ordinary certificate when cost is comparable. A stationary
ordinary certificate for all primitive H<=1000, together with H5 and the
existing high-height theorem, gives ordinary supply for every natural four-
moving tuple by normalization. Package that result with H5 as H6 and call
`BoundedRealReduction.lonelyAt_of_lowerCount (m:=4)` to obtain arbitrary real
five-total-runner ordinary LRC for any chosen label. The generic bounded real
bridge is already present; no all-dimensional conjecture premise is needed.
The public `SharperInclusivePrimitiveFiniteFamily 3` asks for every label;
a new narrower stationary wrapper avoids unnecessarily strengthening a
stationary certificate to that public contract. By contrast FK's not-Q
branches do not supply those ordinary rows. Neither route resolves full LRC.

## Precise proposed wrapper contracts

For an ordered positive natural `W : Fin 4 -> Nat`, use the existing
`FiveRunnerMixed (W 0) (W 1) (W 2) (W 3)` as the M conclusion. The new
strict predicate is exactly `exists t : Real, forall i, (1/5)<||t*W i||`.
Suggested additional contracts, not declarations already implemented:

```text
strictWitness_iff_strictPairSum:
  (forall i, 0<W i) ->
  [Q(W) iff exists i<j, exists 0<r<W i+W j,
     forall k, W i+W j < 5*cyclicResidueDistance(W i+W j,r*W k)].

mixedWitness_iff_endpointRow:
  StrictMono W -> (forall i, 0<W i) ->
  [M(W) iff some row from E(W) passes R(W,p,q)].

fiveRunnerStrictToMixed_of_bounded:
  [forall 0<a<b<c<H<=1000 with gcd(a,b,c,H)=1, Q(W)->M(W)] ->
  [forall 0<a<b<c<H, Q(W)->M(W)].
```

The last contract discharges H5 from the existing theorem. A total FK row
checker can return either a passing mixed endpoint or a complete rejection
of the strict pair-sum candidates; its domain-coverage proof remains separate.
The N=4 certificate review records a source check of 28.49 seconds and peak
3,985,760 KiB RSS for the much smaller `Fin 37`/34-candidate certificate.
That is recorded historical evidence, not a benchmark performed here or a
justification for linear extrapolation. It reinforces the need to measure
the new representation before choosing an overall budget.

## Sole arithmetic resource count and fixed controls

The program below evaluates only the displayed finite sums: 250 gcd divisors,
the subsets of {3,4,5}, and 997 height summands. It does not enumerate speed
quadruples or evaluate the two-index stronger geometric count. The three
named speed tuples are `(1,2,3,4)`, `(3,4,5,11)` and `(4,5,11,30)`;
their tiny pair/endpoint families are the only witness candidates inspected.
A named integer box at time 1/10 is verified through eight endpoint checks,
with a failing enlarged box as a guard. All arithmetic is exact.

```python
from fractions import Fraction as Q
from hashlib import sha256
from itertools import combinations
from math import comb, gcd, lcm
from pathlib import Path
sources='''
1e27f19d8906ee0d71b452758a38a7c44fff54e0b1b3c1e08dd5354921eb1eb0 LonelyRunner/FiveRunnerMixed.lean
70f690a2300e122da3e9646e48d2f4e9c6af630c16da89d403e8508cb16b6d04 LonelyRunner/FiveRunnerBuffered.lean
2fb2f5c9c0742daa3278ee0ddeacd8643e1e22f8c885de95f5f38e10734b29f6 LonelyRunner/FourRunnerOrdinary.lean
cb41059260b943411e2ab5360b84b59cd13f2ddf352c3c50a0b3715b9b9987d6 LonelyRunner/FiniteHeightReduction.lean
3fee16348b510ed25fd75194d59ed24ec5ffb6d02a3af1318761b772be167c56 LonelyRunner/FourRunnerMixedCertificate.lean
362da5ab923f22e900ae7ac821dd4cf4aab91dfe70889987bc9e5a05d19c276a LonelyRunner/PivotResidues.lean
0e56cab74d30ef8b537ed4ec24503aae875bd8aadc369d26da99ba882cc3603f LonelyRunner/PivotBoundary.lean
838a3bcec806b0e9d01cd117e64e5348de58a05127a3f7bef5dbe2d879ff292f LonelyRunner/PairSumCompleteness.lean
3bc47a6f1a77950577edc54b571e9809bb03bffd37575ebc10bae0fcfcab9384 LonelyRunner/PairSumGeometry.lean
023b39b29e7939dd18b29a51217c3e3fcf353ee5843f3bc3effb27012137e9f0 LonelyRunner/FinitePrimitiveFamilies.lean
475a46b9e10226f3de30628e595073a9765a8c03cb0ab071bdcc10acb6446be3 LonelyRunner/FiniteFamilyEquivalence.lean
7eae68d2c46041b39c3e18f9a1e105c75680352f8e4b4edf65e0dd2a92becb72 LonelyRunner/BoundedRealReduction.lean
8e82088a40db9104237ece65d86900e9cf50b6ffe8e5ec39164fbf8b808473ac research/astra-five-runner-mixed-structure.md
ce3e6ecf5bb454ece9e9b71901db9504556a5ecd5c63888e3cb5a963fea9ff5f research/astra-five-runner-mixed-structure-review.md
07ce0bc6831899c3ac3f00482f7143b5daaff5ea0dacee284d0038c12742ca4b research/astra-four-runner-mixed-formal-review.md
'''
for line in sources.strip().splitlines():
    digest,path=line.split()
    assert sha256(Path(path).read_bytes()).hexdigest()==digest
def choose(n,k): return comb(n,k) if n>=k>=0 else 0
def subsets(D):
    return [s for k in range(len(D)+1) for s in combinations(D,k)]
def covered(B,D):
    D=tuple(sorted(set(D)-{1})); answer=0
    for S in subsets(D):
        allowed=sum((-1)**len(T)*(B//lcm(*T)) for T in subsets(S))
        answer+=(-1)**len(S)*choose(allowed,4)
    return answer
def mu(n):
    sign=1; p=2
    while p*p<=n:
        if n%p==0:
            n//=p; sign=-sign
            if n%p==0: return 0
        p+=1
    return -sign if n>1 else sign
B=1000
raw=comb(B,4)
primitive=sum(mu(g)*choose(B//g,4) for g in range(1,B//4+1))
raw_covered=covered(B,(3,4,5))
primitive_covered=sum(mu(g)*covered(B//g,tuple(d//gcd(d,g) for d in (3,4,5)))
                      for g in range(1,B//4+1))
geometric=0
for H in range(4,B+1):
    L=(4*H+14)//15; K=3*H//22
    assert L>K
    low_second=K*(K-1)*(3*H-2*K-5)//6
    geometric+=choose(H-1,3)-choose(H-L,3)-low_second
assert 0<primitive_covered<=raw_covered<=raw and primitive_covered<=primitive<=raw
assert 0<geometric<raw
print('keys='+str((B+1)**4)+'; increasing_quadruples='+str(raw))
print('primitive_quadruples='+str(primitive)+'; raw_direct_failures='+str(raw_covered))
print('primitive_direct_failures='+str(primitive_covered))
print('after_first_lap_and_coarse_buffer='+str(geometric))
def norm(x): return min(x%1,(-x)%1)
def row(W,p,q,ds):
    return p>0 and q>0 and all(q<=d*((w*p)%q)<=(d-1)*q for w,d in zip(W,ds))
def strict_pair(W):
    return any(all(5*norm(Q(r*w,u+v))>1 for w in W)
               for u,v in combinations(W,2) for r in range(1,(u+v)//2+1))
def endpoints(W):
    return [Q(d*k+1,d*w) for w,d in zip(W,(5,5,5,4)) for k in range((w+1)//2)]
W=(1,2,3,4)
assert not strict_pair(W) and row(W,2,5,(5,5,5,5)) and row(W,2,5,(5,5,5,4))
assert Q(2,5) in endpoints(W)
W=(3,4,5,11)
assert all(norm(Q(w,9))>Q(1,5) for w in W) and strict_pair(W)
assert row(W,1,8,(5,5,5,4))
W=(4,5,11,30)
assert row(W,17,120,(5,5,5,4)) and Q(17,120) in endpoints(W)
def zero_floor_box(intervals,ds):
    return all(10<=d*lo and d*hi<=(d-1)*10 for (lo,hi),d in zip(intervals,ds))
assert zero_floor_box(((2,3),(3,4),(5,5),(6,7)),(5,5,5,4))
assert not zero_floor_box(((2,3),(3,4),(5,5),(7,8)),(5,5,5,4))
print('PASS: 15 source guards; 3 named tuples; one valid box and one rejected enlargement; no tuple scan')
```

Executed from the repository root, exit 0; no files or subprocesses are created:

```bash
python3 -B - <<'PY'
from pathlib import Path
from hashlib import sha256
from contextlib import redirect_stdout
import io,re
raw=Path('research/astra-five-runner-certificate-design.md').read_text()
blocks=re.findall(r'^```python\n(.*?)^```[ \t]*$',raw,re.M|re.S)
assert len(blocks)==1
out=io.StringIO()
with redirect_stdout(out):
    exec(compile(blocks[0],'five-runner-certificate-design-controls','exec'),{})
print(out.getvalue(),end='')
print('program_sha256='+sha256(blocks[0].encode()).hexdigest())
print('stdout_sha256='+sha256(out.getvalue().encode()).hexdigest())
PY
```

Exact program stdout, including final newline:

```text
keys=1004006004001; increasing_quadruples=41417124750
primitive_quadruples=38291807495; raw_direct_failures=13420342515
primitive_direct_failures=12052892146
after_first_lap_and_coarse_buffer=23010550937
PASS: 15 source guards; 3 named tuples; one valid box and one rejected enlargement; no tuple scan
```

Raw program SHA-256:
`1f70819cca181bd17a630e7dcf417c9591c8f9b53444ac9ef8247dcfe4e4b7fb`.
Raw stdout SHA-256:
`41817670c8a496155affbadd86f2738a64830bbe9b7d46e5c84135841adb37e0`.
Only this owned manuscript was written. All commands have stopped; none
depends on the shared build cache. Final raw manuscript hash is reported at
handoff. The design and counts await independent review; no finite coverage,
K5 proof/refutation, ordinary N=5 theorem or unrestricted resolution is claimed.
