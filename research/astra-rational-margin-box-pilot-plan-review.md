# Independent review of the rational-margin box pilot plan

2026-09-06. Requested Astra/xhigh reviewer `/root/mss_published_bound_audit`;
the route is assigned, not independently attested. The current configuration,
workflow, policy and active task record were read and the structural validator
passed. Base checkpoint: `d1ac311bef74afad9220e19cb76077cc97f60b6f`.
Only this review is owned. No Lean/build/cache command, source edit, Git/state
write, certificate discovery or speed-tuple enumeration is part of this review.

Semantic verdict: accepted for the bounded implementation described below,
with no blocking correction. The reviewed author artifact is
`research/astra-rational-margin-box-pilot-plan.md`, SHA-256
`0c1eecb6872e4c202643e5fdf237747b8262a06ed2de4cc7fea2bd84acf8a67a`.
Its typed generic tree and exactly the supplied two leaves are the scope.
This is future work excluded from Pass36, not a compiled box theorem,
resource measurement or finite K5 coverage certificate.

## Independent mathematical assessment

For each contained coordinate w, monotonicity transfers both endpoint checks
to w because p and the denominator are nonnegative naturals. Dividing the
cast inequalities by the positive denominator product gives
`k+delta<=x` and `x+delta<=k+1`, where delta=num/den and x=p*w/q.
Adding these inequalities derives delta<=1/2 for this coordinate; delta>=0
comes from the natural numerator. The actual closed
`LonelyRunner.circleNorm_ge_of_int_band` accepts zero and half margins,
including an integer upper endpoint. Applying
`LonelyRunner.rationalMarginRowOK_circleNorm_iff` then returns the exact
residue row with the original positive q and coordinate denominators.
The source import path through PivotResidues exposes both interfaces.

The band index must retain the proposed meaning. With delta=0, k=0 and x=1,
the point belongs to the closed band although its floor is 1. No step may
replace the band index by an asserted floor. The plan's real-band argument
does not make that replacement, nor use natural subtraction. Neither reduced
fractions nor p<q is required. Positive p and q provide the leaf's one common
positive time for every row in that leaf. Speeds can be zero or repeated;
no sortedness, injectivity or positive-speed hypothesis is hidden.

The raw leaf-to-row theorem remains valid without well-formedness: on an
empty box there is no contained row to which it applies. The direct common-time
statement is also true there because positivity of p/q is checked separately.
Half-margin bounds are forced only when a contained row exists, so a global
extra half guard would unnecessarily restrict this raw API. At the public
root, well-formedness makes lo itself a contained row, preventing empty-box
acceptance from concealing impossible margins. For n=0 the box has its unique
empty row, well-formedness is vacuous and a positive-time leaf remains valid.
A split is unconstructible because it would need a Fin 0 coordinate.

For any parent row, w_i<=cut places it in the derived left child; otherwise
natural discreteness gives cut+1<=w_i and places it in the derived right child.
The other coordinates are unchanged. The split guard lo_i<=cut<hi_i proves
both child-to-parent inclusions, disjointness and child well-formedness when
the parent is well formed. Cut and cut+1 are retained on opposite sides.
This proves exact natural coverage without independently trusted child bounds.
Structural induction generalizing the current box and row proves the core
soundness; requiring both child checks is essential. No tree leaf can bypass
the root domain merely by naming a smaller rectangle.

The principal row conclusion correctly retains an existential positive
numerator and a passing rational row. Its positive denominator is already
encoded by the row checker. The leaf statement has one common time for the
whole leaf; the tree conclusion has `forall row, exists time`, with the time
possibly selected from different leaves. It asserts neither a single time
for the entire tree nor strict margins. The typed syntax enforces dimensions
and two children structurally; the illustrative Python controls are not an
implemented external decoder or a substitute for the Lean induction proof.

## Exact two-leaf scope and implementation recommendation

I independently checked all sixteen listed endpoint inequalities and their
equivalent rational bands. The root size is algebraically
`2*2*1*3=12`, not an enumerated sample size. Its coordinate-3 split at 7
produces exactly H=6..7 and H=8. Time 1/10 retains lower-speed fifth equality
at speed 2; time 5/32 retains fastest quarter equality at speed 8 with band 1.
The root includes repeated lower coordinates, as the generic contracts permit.
The unsplit 1/10 candidate fails at H=8 with the stated `42<=40` failure
and circle norm 1/5. The invalid cuts, failing child, wrong band and two
named gap controls have the interpretations stated by the author.

Ready for Terra implementation: an additive typed box/leaf/tree module,
the raw leaf row and common-time lemmas, derived split coverage and guarded
tree soundness, then this fixed two-leaf acceptance and the stated edge
controls. Preserve the existing row API and prove all acceptance with
ordinary kernel evaluation. No tuple iterator, discovery code or global
certificate is needed. An external decoder, if later added, still needs its
own total rejection behavior and must feed the same checked typed structure.

The limits of 256 leaves, 64 KiB explicit certificate data, 60 seconds per
whole check and 4 GiB peak RSS are prospective hard limits, not measurements.
A full binary tree with 256 leaves has at most 511 nodes. Source-data size
does not bound elaborated proof size or runtime; enforce and report resource
limits on the entire acceptance or soundness-instance command. No claim that
the remaining normalized N5 region admits a small tree follows from these
two leaves. Finite K5/global supply and unrestricted LRC remain unresolved.

## Guarded exact replay and independent fixed controls

The sole program replays the author's fully read block in memory, binding
its source, program and stdout hashes. Its seven guarded source/design inputs
are the author's six plus the actual PivotResidues import bridge. The extra
work rechecks only the two supplied leaves in rational bands, three coordinate
positions around their split, and two scalar zero/empty-box edge cases.
There is no speed-tuple loop, subprocess, Lean invocation or cache access.

```python
from contextlib import redirect_stdout
from fractions import Fraction as Q
from hashlib import sha256
from math import floor, prod
from pathlib import Path
import io, json, re

author = Path('research/astra-rational-margin-box-pilot-plan.md')
author_hash = '0c1eecb6872e4c202643e5fdf237747b8262a06ed2de4cc7fea2bd84acf8a67a'
program_hash = '6297f1298e7df800ade421f63cb2ec57e4239cf7d6177e08904044352d39814b'
stdout_hash = 'b1f17b7de8ae306ed47efc9cf740772115dadf35d2be841c5bb8e4f8a0f3c946'
raw = author.read_bytes()
assert sha256(raw).hexdigest() == author_hash
f = chr(96)*3
blocks = re.findall(rf'^{f}python\n(.*?)^{f}[ \t]*$',raw.decode(),re.M|re.S)
assert len(blocks) == 1 and sha256(blocks[0].encode()).hexdigest() == program_hash
out, ns = io.StringIO(), {}
with redirect_stdout(out):
    exec(compile(blocks[0],'<guarded-box-plan>','exec'),ns)
assert sha256(out.getvalue().encode()).hexdigest() == stdout_hash
bridge = Path('LonelyRunner/PivotResidues.lean')
assert sha256(bridge.read_bytes()).hexdigest() == '362da5ab923f22e900ae7ac821dd4cf4aab91dfe70889987bc9e5a05d19c276a'
assert 'import LonelyRunner.StructuredClasses\n' in bridge.read_text()
assert 'import LonelyRunner.PivotResidues\n' in Path('LonelyRunner/RationalMarginCertificates.lean').read_text()

def norm(x):
    f = x-floor(x)
    return min(f,1-f)

# Exactly two supplied boxes, with only coordinate endpoint checks.
named = (
    ((2,3,5,6),(3,4,5,7),1,10,(0,0,0,0)),
    ((2,3,5,8),(3,4,5,8),5,32,(0,0,0,1)),
)
num,den = (1,1,1,1),(5,5,5,4)
endpoint_checks = 0
for lo,hi,p,q,band in named:
    assert p>0 and q>0
    for l,h,a,b,k in zip(lo,hi,num,den,band):
        delta,xlo,xhi = Q(a,b),Q(p*l,q),Q(p*h,q)
        assert k+delta<=xlo<=xhi<=k+1-delta
        assert delta<=norm(xlo) and delta<=norm(xhi)
        endpoint_checks += 2
assert endpoint_checks == 16
assert prod(h-l+1 for l,h in zip((2,3,5,6),(3,4,5,8))) == 12
for H in (6,7,8):
    assert (6<=H<=8) == ((6<=H<=7) or (8<=H<=8))
    assert not ((6<=H<=7) and (8<=H<=8))
assert norm(Q(8,10)) == Q(1,5) < Q(1,4)

# A zero-margin upper integer is valid without being the claimed floor.
assert 0<=Q(1)<=1 and norm(Q(1)) == 0 and floor(Q(1)) != 0
# Empty raw scope can even admit an impossible margin; public well-formedness
# rejects it. This is one scalar edge control, not a new region or a search.
assert ns['leaf']((1,),(0,),(2,),(1,),4,1,(1,))
assert not ns['check']((1,),(0,),(2,),(1,),('leaf',4,1,(1,)))

assert sha256(author.read_bytes()).hexdigest() == author_hash
for path,digest in ns['guards'].items():
    assert sha256(Path(path).read_bytes()).hexdigest() == digest
print(out.getvalue(),end='')
print(json.dumps({
    'result':'PASS','author_sha256':author_hash,
    'author_program_sha256':program_hash,'author_stdout_sha256':stdout_hash,
    'source_guards':7,'named_leaves':2,'independent_endpoint_checks':16,
    'root_rows_product':12,'split_coordinate_controls':3,
    'scalar_edge_controls':2,'tuple_enumeration':False,'lean_execution':False,
},sort_keys=True))
```

## Final verification record

The first and only reviewer replay completed with terminal exit 0, tool chunk
`f38c1b`. All 21 author controls and six author source guards passed, and its
exact stdout matched the frozen hash. The additional import guard, sixteen
independent rational endpoint checks, three split-coordinate checks and two
scalar edge controls also passed. There were no failed reviewer executions.

| Frozen evidence | SHA-256 |
| --- | --- |
| Author manuscript | `0c1eecb6872e4c202643e5fdf237747b8262a06ed2de4cc7fea2bd84acf8a67a` |
| Author sole program | `6297f1298e7df800ade421f63cb2ec57e4239cf7d6177e08904044352d39814b` |
| Author raw stdout | `b1f17b7de8ae306ed47efc9cf740772115dadf35d2be841c5bb8e4f8a0f3c946` |
| Reviewer sole program | `a426fd4c9522fd22f2d2deee7876a79909111e994bde124212210cef369b95aa` |
| Reviewer raw stdout | `ca40f6ddc2f72a189c94540b4fd47e0b5f56226975741bfb9f3d89b91519978a` |

The exact reviewer command, from the repository root, was:

```sh
python3 -B - <<'PY'
from pathlib import Path
from hashlib import sha256
from contextlib import redirect_stdout
import re,io
f=chr(96)*3
s=Path('research/astra-rational-margin-box-pilot-plan-review.md').read_text()
b=re.findall(rf'^{f}python\n(.*?)^{f}[ \t]*$',s,re.M|re.S)
assert len(b)==1
out=io.StringIO()
try:
 with redirect_stdout(out):
  exec(compile(b[0],'<box-pilot-independent-review>','exec'),{})
finally:
 print(out.getvalue(),end='')
 print('review_program_sha256='+sha256(b[0].encode()).hexdigest())
 print('review_stdout_sha256='+sha256(out.getvalue().encode()).hexdigest())
PY
```

The workflow validator also passed; its result concerns record consistency,
not mathematical correctness. Final verdict: the raw leaf, public root and
derived split contracts are accepted, and the exact two-leaf pilot is ready
for the proposed bounded Terra implementation. No additional premise or
source correction is required. All reviewer commands have stopped. No Lean,
build, cache, discovery or speed-tuple enumeration was performed, and no
global supply or LRC result is claimed.
