# Independent review of the five-runner certificate design

2026-09-05. Assigned Astra/xhigh reviewer `/root/mss_published_bound_audit`;
routing is requested, not independently attested. Review source checkpoint:
`6ac2e9f46c9aeb376ea140de00b40a6be03d3a95` (subsequently merged as
`d1ac311bef74afad9220e19cb76077cc97f60b6f`). Project configuration, workflow,
policy and active state were read; the structural validator passed. Only this
review is owned. No Lean, cache restoration, source/state/Git edit, literature
expansion, certificate discovery or speed-tuple enumeration is used.

Accepted: the mathematical contracts and resource distinctions are sound,
and the guarded arithmetic reproducer passed with terminal exit 0. The
frozen author is `research/astra-five-runner-certificate-design.md`, SHA-256
`cc7990790d3ca8ddd50d36dc64d80af74b1f82d45b64ba20e31fbbc0b78fc403`.
The recommendation is to implement reusable checker/completeness interfaces
first. No finite coverage certificate, K5, ordinary universal N5 or unrestricted
LRC theorem has been obtained by this design.

## Exact target and source interfaces

Q is strict ordinary existence, O is closed ordinary existence, and M requires
one positive time with the original three fifth margins and fastest quarter.
Positive common-gcd normalization preserves each statement and its negation
by exact time scaling. The proved H5 and stationary large-height mixed theorem
at m=3 cover normalized maximum greater than 1000. Consequently the stated
primitive inclusive finite FK implication is equivalent to global K5, with
the H=1000 boundary retained. No raw, unnormalized maximum is substituted.

An M or not-Q outcome on every finite row suffices for FK. A not-Q outcome
supplies no ordinary O witness: it permits either an empty ordinary set or
ordinary boundary points only. The consecutive N5 example has not Q and M;
it does not produce an N5 no-M family. To refute FK requires both strict Q
and global mixed absence. A failed time or component is insufficient.

I checked the actual declarations `LonelyRunner.circleNorm_nat_div_eq`,
`exists_pairSum_time_of_witness`, `primitive_sorted_noMixed_height_le`,
`lowerCountPositiveIntegerHypothesis_five`, `SharperInclusivePrimitiveFiniteFamily`
and `lonelyAt_of_lowerCount`. The module prefixes used descriptively in the
manuscript are source-file references; the Lean declarations live in
`LonelyRunner`. Existing ordinary completeness does not retain a separate
quarter margin at the maximum. The all-label finite-family contract also
must not be confused with a stationary-only finite certificate.

## Row arithmetic, strict pair times and mixed endpoints

For r=(wp)%q, q>0 and d>0, margin n/d at p/q is exactly equivalent to
`nq<=dr` and `dr+nq<=dq`. This follows from the exact circular residue norm,
not an approximate band test. Both inequalities are needed; their additive
form avoids truncated natural subtraction. Zero n and p are valid for this
pointwise equivalence. Positive p is needed to turn this particular time into
a positive-time witness. No speed positivity or distinctness is needed for
row soundness; those assumptions belong to the completeness wrappers.

For strict pair completeness, choose the attained minimum mu of the finitely
many norms at a strict witness. Then mu>delta>0 and all old norms are at least
mu. Applying the existing arbitrary-margin pair-sum completeness to mu
preserves a strict delta margin at a positive rational pair time. The returned
pair consists of distinct labels, not necessarily distinct values unless
injectivity is assumed. The proposed i<j formulation is sound by swapping
labels; the generic core should use p!=q and permit repeated speeds.
Reflection replaces r by q-r, preserving all integer-speed norms. Thus the
half-range is exact; equality in `5*distance<=q` is a valid rejection of
strict Q. In the sorted H<=1000 domain q<=1999 and fewer than 6000 candidates
suffice. This argument concerns a uniform strict margin, not M.

For nonuniform endpoint completeness, fold a supplied time modulo one and
reflect to a seed tau in (0,1/2]. Nonemptiness of the positive-speed index set
and strictly positive margins exclude tau=0. Each label's floor band is
closed and contains tau. Its maximum left endpoint T is at most tau, hence
at most every right endpoint, and is therefore still good for every original
margin. The active left owner p gives `T=(k+d_p)/w_p>0`. Since T<=1/2 and
d_p>0, `2k<w_p`, equivalently `k<(w_p+1)/2` in natural arithmetic.
This covers singleton intersections, ties, repeated speeds, negative starting
times, and the half-period boundary. It uses no positive-width hypothesis.

When the margins are 1/5,1/5,1/5,1/4, the endpoint forms are exactly E.
For each speed there are ceil(w/2) half-period candidates before duplicates:
positive margins at most one half give precisely that count for odd and even
w. The four largest possible ordered speeds are 997,998,999,1000, whose
counts sum to 1998; the unreduced denominators are bounded by
`max(5c,4H)<=4995`, so reduction cannot exceed that bound. Positive endpoint
completeness needs positive margins; row soundness may still allow zeros.

## Counts, geometric filters and cost

A direct failure need only cover divisors 3,4,5: a retained multiple of four
already covers two. The nested inclusion-exclusion correctly counts four-
element subsets meeting all divisor classes. Under a common factor g,
`d | gv` is equivalent to `d/gcd(d,g) | v`; this is the necessary transformed
divisor list in the Möbius sum. A reduced divisor one imposes no restriction.
The sum stops at g=250 because four distinct positive multiples require
4g<=1000. It counts primitive direct failures, not all-deletion or geometric
survivors. All six reported numerical domains have the meanings stated.

For the first-lap and coarse filters, L=ceil(4H/15)>K=floor(3H/22), so
`a>=L` and `b<=K` cannot overlap when a<b. The former count is choose(H-L,3).
The latter equals the one-index sum of `(b-1)(H-1-b)` through K, yielding
`K(K-1)(3H-2K-5)/6`, including K=0,1. This proves formula G. These geometric
and divisor counts are different filters, not consecutive residual sizes.

For the stronger geometric count, if 10b<=H both buffer inequalities hold
automatically. Otherwise put D=10b-H>0: failure is exactly
`a>Hb/D` or `c>8Hb/(3D)`. The two tail rectangles have union
`A1*C0+(A0-A1)*C1`, with strict tails starting after the floor of each
threshold. This correctly retains equality cases as covered. The fully
combined residual with divisors, deletion gcds and determinants has not been
counted. Neither its smallness nor a billions-sized lower bound follows from
the separate counts. No tuple enumeration is needed for these formulas.

The 1001^4 key count, choose(1000,4) ordered count and hypothetical four-byte
storage estimate describe different costs. A shared time catalogue does not
itself eliminate tuple traversal or provide a common time for every triple.
For a witness box, one fixed floor index per coordinate and rational band
checks at both speed endpoints suffice by linearity. Partition completeness
and a sound proof of every leaf remain essential. Not-Q or analytic leaves
must not conceal another full tuple traversal. Leaf count alone is not a
runtime guarantee. The proposed 256 leaves, 64 KiB, 60 seconds and 4 GiB are
unmeasured stop conditions; no small full-domain partition is supplied. The
historical N4 certificate measurements are not new pilot benchmarks.

## Settled minimal implementation interfaces

Implement only these reusable cores first, retaining current public APIs:

1. A finite natural rational-margin row checker with positive q and all d_i,
   testing `n_i*q<=d_i*r_i` and `d_i*r_i+n_i*q<=d_i*q`. Prove exact pointwise
   iff, then a positive-time corollary with p>0. Permit zero n_i. A strict
   rational specialization may replace both comparisons by strict ones.
2. A positive-natural-speed endpoint helper for nonempty Fin n and real
   margins `0<d_i<=1/2`: from a supplied real witness return an owner p and
   natural k with `k<(w_p+1)/2`, and prove all margins at
   `T=(k+d_p)/w_p` with `0<T<=1/2`. Sorting and injectivity are unnecessary.
   The rational endpoint row and N5 candidate adapters then follow by exact
   numerator/denominator algebra.
3. A strict pair-sum iff for n>=2, positive natural speeds and real delta>0,
   retaining distinct labels p!=q, `0<r<w_p+w_q` and the common strict
   delta margin at that pair time. Use the existing closed arbitrary-margin
   theorem at the finite minimum; add the rational/half-range adapter after.

A conditional bounded FK wrapper is then straightforward via gcd normalization
and the established high-height mixed theorem. It is not necessary to build
a partition tree or launch any scan to finish the three bounded core tasks.
For an ordinary N5 theorem, a finite stationary O certificate plus H5 supplies
all natural four-moving rows; combine them as H6 and call
`LonelyRunner.lonelyAt_of_lowerCount` at m=4. This has the correct five-label
count and needs no all-dimensional conjecture premise. FK's not-Q leaves do
not provide the missing O rows. Both finite coverage obligations remain open.

## Guarded exact reproducer

The author block is fully read before this in-memory replay. It guards fifteen
source/manuscript files and evaluates only its stated arithmetic sums and
three named tuple controls. The extra checks below use a size/mask DP over at
most twelve individual integers, three one-index height counts, four fixed
rectangle counts, three endpoint fixtures and five rational rows. They never
enumerate quadruples, run Lean, read compiled dependencies or start a process.

```python
from contextlib import redirect_stdout
from fractions import Fraction as Q
from hashlib import sha256
from itertools import combinations
from math import comb, floor, gcd
from pathlib import Path
import io, json, re

path = 'research/astra-five-runner-certificate-design.md'
author_hash = 'cc7990790d3ca8ddd50d36dc64d80af74b1f82d45b64ba20e31fbbc0b78fc403'
author_program_hash = '1f70819cca181bd17a630e7dcf417c9591c8f9b53444ac9ef8247dcfe4e4b7fb'
author_stdout_hash = '41817670c8a496155affbadd86f2738a64830bbe9b7d46e5c84135841adb37e0'
raw = Path(path).read_bytes()
assert sha256(raw).hexdigest() == author_hash
fence = chr(96)*3
blocks = re.findall(rf'^{fence}python\n(.*?)^{fence}[ \t]*$', raw.decode(), re.M | re.S)
assert len(blocks) == 1 and sha256(blocks[0].encode()).hexdigest() == author_program_hash
out, ns = io.StringIO(), {}
with redirect_stdout(out):
    exec(compile(blocks[0], 'guarded-certificate-design-counts', 'exec'), ns)
assert sha256(out.getvalue().encode()).hexdigest() == author_stdout_hash
for source, digest in {
    'LonelyRunner/StructuredClasses.lean':'5328a7a88d2b42f86ffc3f0f0418ca22c761219e8fa3e5822bda5a18ac286e8c',
    'LonelyRunner/LowerCountSupply.lean':'0705291adc53011fb72fc718a7260876512b092741442d6a6cceb4b76eb5ccf4',
}.items():
    assert sha256(Path(source).read_bytes()).hexdigest() == digest

# An independent subset-count DP: states are size and divisor-coverage mask.
# It visits at most twelve integers, never enumerates quadruples.
def mask_count(B, divisors):
    D = sorted(set(divisors)-{1})
    dp = [[0]*(1<<len(D)) for _ in range(5)]
    dp[0][0] = 1
    for w in range(1,B+1):
        mask = sum(1<<i for i,d in enumerate(D) if w%d == 0)
        for size in range(4,0,-1):
            for oldmask in range(1<<len(D)):
                dp[size][oldmask|mask] += dp[size-1][oldmask]
    return dp[4][-1]
count_controls = ((12,(3,4,5)),(12,(3,5)),(12,(2,5)),(3,(1,)))
mask_results = [mask_count(B,D) for B,D in count_controls]
assert all(value == ns['covered'](B,D) for (B,D),value in zip(count_controls,mask_results))
assert tuple(d//gcd(d,4) for d in (3,4,5)) == (3,1,5)
assert tuple(d//gcd(d,6) for d in (3,4,5)) == (1,2,5)

# One-index ordered counts, not enumeration of tuples.
choose = ns['choose']
geometric_controls = []
for H in (4,30,75):
    L,K = (4*H+14)//15, 3*H//22
    closed = choose(H-1,3)-choose(H-L,3)-K*(K-1)*(3*H-2*K-5)//6
    direct_sum = sum(min(b-1,L-1)*(H-1-b) for b in range(1,H) if b>K)
    assert L>K and closed == direct_sum
    geometric_controls.append(closed)
rectangle_controls = []
for H,b in ((20,5),(30,5),(75,20),(50,5)):
    L = (4*H+14)//15
    A0,C0 = max(0,min(b-1,L-1)), H-b-1
    D = 10*b-H
    if D <= 0:
        value = 0
    else:
        A1 = max(0,A0-(H*b)//D)
        C1 = max(0,H-1-max(b,(8*H*b)//(3*D)))
        value = A1*C0+(A0-A1)*C1
        one_index = sum(C0 if 10*a*b>H*(a+b) else C1 for a in range(1,A0+1))
        assert value == one_index
    rectangle_controls.append(value)
assert rectangle_controls == [47,36,882,0]

def norm(x):
    f = x-floor(x)
    return min(f,1-f)

# Generic unequal real-margin endpoint arithmetic at three fixed seeds.
def left_endpoint(W, margins, seed):
    f = seed-floor(seed)
    t = min(f,1-f)
    assert 0<t<=Q(1,2)
    assert all(0<d<=Q(1,2) and d<=norm(w*t) for w,d in zip(W,margins))
    floors = [floor(w*t) for w in W]
    left = [(k+d)/w for w,k,d in zip(W,floors,margins)]
    right = [(k+1-d)/w for w,k,d in zip(W,floors,margins)]
    L,R = max(left),min(right)
    owner = left.index(L)
    assert 0<L<=t<=R and L<=Q(1,2)
    assert all(d<=norm(w*L) for w,d in zip(W,margins))
    assert 2*floors[owner]<W[owner]
    assert floors[owner]<(W[owner]+1)//2
    return L,R
mixed_margins = (Q(1,5),Q(1,5),Q(1,5),Q(1,4))
assert left_endpoint((1,2,3,4),mixed_margins,Q(2,5)) == (Q(2,5),Q(2,5))
assert left_endpoint((4,5,11,30),mixed_margins,-Q(17,120)) == (Q(17,120),Q(19,120))
assert left_endpoint((3,3),(Q(1,2),Q(1,4)),-Q(1,2)) == (Q(1,2),Q(1,2))
top = (997,998,999,1000)
assert sum((w+1)//2 for w in top) == 1998
assert max(5*top[2],4*top[3]) == 4995
assert sum((u+v)//2 for u,v in combinations(top,2)) == 5989 < 6000

# Generic rational margins, including zero margins/p=0 and a rejected upper band.
def row(W, nums, dens, p, q):
    return q>0 and all(d>0 and n*q<=d*((w*p)%q) and
        d*((w*p)%q)+n*q<=d*q for w,n,d in zip(W,nums,dens))
row_controls = (
    ((0,1,2),(0,1,0),(1,4,7),1,4,True),
    ((1,),(1,),(2,),1,2,True),
    ((1,),(1,),(3,),2,3,True),
    ((1,),(1,),(3,),3,4,False),
    ((0,3),(0,0),(1,5),0,7,True),
)
for W,nums,dens,p,q,expected in row_controls:
    checked = row(W,nums,dens,p,q)
    semantic = all(Q(n,d)<=norm(Q(p*w,q)) for w,n,d in zip(W,nums,dens))
    assert checked == semantic == expected
assert not row((1,),(0,),(0,),1,2)
assert not row((1,),(0,),(1,),1,0)

print(json.dumps({
    'result':'PASS',
    'author_sha256':author_hash,
    'author_program_sha256':author_program_hash,
    'author_stdout_sha256':author_stdout_hash,
    'author_source_guards':15,
    'additional_source_guards':2,
    'mask_count_controls':mask_results,
    'geometric_height_controls':geometric_controls,
    'rectangle_controls':rectangle_controls,
    'endpoint_controls':3,
    'rational_row_controls':5,
    'mixed_candidate_bound':1998,
    'mixed_denominator_bound':4995,
    'quadruple_scan':False,
    'lean_executed':False,
},sort_keys=True))
```

## Verification and final disposition

Finalized 2026-09-06. The first reviewer execution completed with terminal
exit 0 (tool chunk `4d8331`), with all fifteen author source guards, the two
additional source guards and the controls above passing. The author's exact
stdout also matched its frozen hash. The structural workflow validator
completed with exit 0 before finalization. It does not certify mathematics.

Run the sole Python block from the repository root with the exact command
used for this review:

```bash
python3 -B - <<'PY'
from pathlib import Path
from hashlib import sha256
from contextlib import redirect_stdout
import re,io
f=chr(96)*3
raw=Path('research/astra-five-runner-certificate-design-review.md').read_text()
blocks=re.findall(rf'^{f}python\n(.*?)^{f}[ \t]*$',raw,re.M|re.S)
assert len(blocks)==1
out=io.StringIO()
try:
 with redirect_stdout(out):
  exec(compile(blocks[0],'certificate-design-independent-review','exec'),{})
finally:
 print(out.getvalue(),end='')
print('review_program_sha256='+sha256(blocks[0].encode()).hexdigest())
print('review_stdout_sha256='+sha256(out.getvalue().encode()).hexdigest())
PY
```

| Frozen evidence | SHA-256 |
| --- | --- |
| Author manuscript | `cc7990790d3ca8ddd50d36dc64d80af74b1f82d45b64ba20e31fbbc0b78fc403` |
| Author sole program | `1f70819cca181bd17a630e7dcf417c9591c8f9b53444ac9ef8247dcfe4e4b7fb` |
| Author raw stdout | `41817670c8a496155affbadd86f2738a64830bbe9b7d46e5c84135841adb37e0` |
| Reviewer sole program | `b8cdf01759b31074e23c8672164866b3840ef52384d6d0dd1ffbeacd329c7835` |
| Reviewer raw stdout | `25ba84e81c44805a10986b6c89adf89b34e3104934d1eb3adebd4c1afbce85fe` |

The reviewer stdout reports PASS, mask counts `[153,230,275,0]`, geometric
counts `[1,1960,35589]`, rectangle counts `[47,36,882,0]`, three endpoint
controls, five rational rows, candidate bound 1998 and denominator bound 4995.
Its `lean_executed` and `quadruple_scan` fields are both false. Source hashes
are reproduced by the guarded author block and the two extra guards; mutable
root imports, the trust-audit file and concurrent new modules are not guards
or reviewed implementation evidence here.

There is no blocking mathematical or design correction. The precise generic
contracts above are ready for implementation: distinct labels in the strict
pair result, positive real margins for positive endpoint completeness, and
zero numerators permitted by pointwise row soundness. No implementation,
resource pilot or finite-domain certificate is claimed by this manuscript
review. The stronger finite K5 and ordinary finite coverage obligations, and
unrestricted LRC, remain unresolved. The reviewer used no Lean or dependency
cache and has stopped all commands at handoff.
