# Independent review of strict ordinary to mixed supply

2026-09-05. Requested independent Astra/xhigh review by
`/root/mss_published_bound_audit`, assigned source checkpoint
`fd99b6f550bcb931f101ef2186168f1fc09aec4d`. Only this review is owned.
The project configuration, workflow, policy, active assignment and validator
were read. Research is authorized and the canonical goal remains unresolved.
Requested routing is recorded; observed model/effort were not independently
exposed. `python3 -B scripts/validate_workflow.py` passed. The initial combined
read also requested an absent `AGENTS.md` and returned exit 1 for that path;
the actual project entry point explicitly uses `.codex/config.toml` and requires
no `AGENTS.md`. No instruction or source file was created to remedy that.

## Verdict and exact scope

**Accept the frozen manuscript's deductions and diagnostic interpretation; no
mathematical correction is required.** This is a manuscript review, not a new
Lean theorem or a proof/refutation of its global target K.

K has N>=4 total runners and N-1 distinct positive integer moving speeds W,
with gcd(W)=1 and H=max W. Its premise is existence of a real T with every
`||wT||>1/N`. Its conclusion is existence of a possibly different real S with
every `||wS||>=1/N` and `||HS||>=1/(N-1)` **at that same S**. The conclusion
does not have to lie in the original ordinary connected component. Neither the
strict premise nor the fastest-specific stronger conclusion may be deleted.
Both existence predicates are invariant under common positive integer scaling:
for W=gV, the phase identity is `(gv)t=v(gt)`, with inverse time substitution
t=s/g. Thus the primitive restriction loses no generality for K itself.
This differs from the previously refuted raw direct-or-mixed union, whose
divisibility alternative is not invariant under scaling.

The deductions in this frozen manuscript alone leave K unresolved. In
particular, its statement that the N=4 narrowing gives no finite bound on b is
correct for the reductions it presents. A subsequently proposed finite-height
route is separate work and is not evidence imported into this review.

## Independent derivation checks

For positive integer speeds, the closed ordinary good set modulo one is a
finite union of closed interval intersections. On an ordinary component each
speed stays inside one band `[j+1/N,j+1-1/N]`, since crossing an integer would
leave the good set. A strict point has a common open neighborhood. Conversely,
in a component of positive width, every interior point has all band inequalities
strict: a positive slope attaining either endpoint there would violate that
inequality on one side. This proves the strict-point/positive-width equivalence
and excludes the diagnostic singleton exceptions from K's premise.

The accepted endpoint obstruction is used in its correct scope. If an entire
component misses mixed, its fastest phase cannot cross a half-integer. Reflect
the entire component when necessary so its fastest fractional phase increases
below one half. Its right endpoint has an upper owner a<H. For every such owner,
including ties, the exact integer s satisfies

```
h = 1/N + s/(N*a),
0 <= s < a/(N-1),        s == -(H+a) (mod N).
```

If s=0, the fastest phase equals 1/N at the right endpoint, so every time
immediately to its left is bad; the component is a singleton. Positive width
therefore forces s>=1 and a>N-1, equivalently a>=N. Consequently if all lower
speeds are <=N-1, a strict ordinary point supplies a component containing mixed.
A single trapped component cannot negate the global conclusion of K.

Let g be the gcd of the lower N-2 speeds. Primitivity gives gcd(g,H)=1.
At shifts `T+j/g`, lower phases change by integers, while the fastest traverses
a translate of the full g-point grid. The actual saved theorem
`exists_int_coprime_grid_circleNorm_ge` supplies an integer j with fastest norm
at least `(g-1)/(2g)`. It does not impose an extra positivity or residue-range
hypothesis; reducing j modulo g preserves the phases if a finite range is wanted.
For N>=5 and g>=2 this is at least 1/4>=1/(N-1). For N=4 and g>=3 it is at
least 1/3. Thus an ordinary witness already suffices in these cases, with every
lower margin preserved exactly at the chosen shared time.

The exceptional N=4, g=2 argument also works, without strictness or an ordinary
premise. Obtain a common 1/3 witness for the two lower speeds, then shift by j/2
to make the fastest norm c>=1/4. If c<1/3, move its signed fractional phase away
from the nearest integer until its norm is exactly 1/3. The required time change
has magnitude `(1/3-c)/H <= 1/(12H)`. This is valid on both sides of the circle;
the new phase stays at distance <=1/3<1/2 from that integer. By the saved
1-Lipschitz bound, each lower w<H finishes with norm at least
`1/3-w/(12H)>1/4`. If c>=1/3 no perturbation is needed. Every counterexample
to K must therefore have primitive lower core, for all N>=4.

The elementary two-speed input does not assume an unresolved lower-count LRC.
For a<H, reduce to coprime a',H'. At an H'-half time, a' times the odd residues
modulo 2H' gives maximum norm 1/2 when both are odd, and
`(H'-1)/(2H')` otherwise. This is >=1/3 for H'>=3. The only remaining reduced
case is (1,2), whose ordinary 1/3 witness is immediate. Rescaling proves a common
1/3 witness for every positive integer pair. The independently inspected
`SmallDimensions.twoMovingSpeeds` and `twoMovingRunners` also already provide
that closed 1/3 input, in the stronger nonzero-real-speed setting.

For N=4 write a<b<H. If g=gcd(a,H)>1, then gcd(b,g)=1 by overall primitivity.
The same half-phase calculation supplies `||Ht||=1/2` and `||at||>=1/4`:
now H'>=2 suffices, and the reduced (1,2) case attains exactly 1/4.
Shifts by j/g preserve both phases and supply `||b(t+j/g)|| >=
(g-1)/(2g) >=1/4`. The fastest remains exactly at one half, so this is mixed.
Exchanging a and b proves the corresponding gcd(b,H) exclusion. Together with
the lower-core argument, a possible N=4 counterexample must be pairwise coprime.

Finally, from a lower-pair 1/3 witness, the elementary phase-adjustment theorem
at delta=1/3 moves the fastest into its closed 1/3-good set with time change at
most 1/(3H). If H>=4b, every lower norm finishes at least
`1/3-b/(3H) >= 1/4`. Equality H=4b is admitted. This derives the stronger
fastest margin directly; it is not read out of `fastRunnerInsertion`, whose
generic conclusion has the ordinary new threshold. Combined with the endpoint
owner bound, a possible N=4 counterexample must satisfy b>=4 and b<H<4b,
as well as pairwise coprimality and a globally empty mixed set.

K permits real times without a sign restriction. If a positive-time interface
is later wanted, an integer shift after the entire construction makes the final
time positive and preserves all integer-speed phases simultaneously. No step
requires separately chosen times for different margins. All conclusion
inequalities are closed; strictness is used only where stated above.

## Exact diagnostic audit and evidence separation

I read the author's entire sole Python block and verified its SHA-256. It
enumerates increasing tuples by choosing N-2 values in `range(1,H)` and appending
H. Eligibility is gcd 1 and existence of an uncovered divisor d in 2,...,N.
Thus it is exactly the new direct-eligible domain, not all primitive tuples.
Its two-pointer intersection processes sorted disjoint closed rational bands;
the `<=` test retains singleton contacts and the equal-endpoint advancement
loses no interval. For a speed w on `[0,1/2]`, band indices 0,...,floor(w/2)
include every possible good phase. Integer periodicity and reflection justify
this half-period restriction for ordinary and mixed predicates alike.

Every nonempty mixed intersection is checked again using exact `Fraction`
norms at a common endpoint. If mixed is empty, the program explicitly requires
nonempty ordinary cells and checks that all are singleton. The expected lists
then identify the only exceptions. It checks exactly 643 tuples at N=4,H=3..20;
1,185 at N=5,H=4..16; and 502 at N=6,H=5..12, totaling 2,330. The mixed-empty
tuples are respectively (1,2,3), none, and (1,2,3,4,5); their ordinary half-period
sets are {1/4} and {1/6}. No larger or divisor-covered domain follows from this
program. The five author's margin fixtures and its separate four-speed
countercontrol are correctly described.

The orchestrator replayed the full author's program. I independently read and
hash-checked its saved exact stdout at
`/tmp/astra-strict-to-mixed-root-replay.json`; I did not rerun the tuple sweep.
My separate controls below use a Cartesian-product band construction for just
the two singleton tuples, four different fixed margin fixtures, and one strict
trapped-component fixture with a mixed time elsewhere. They are checks on
analytic boundaries, not evidence for any unbounded assertion.

Jensen is not a mathematical dependency of these deductions. I checked the
manuscript imports no theorem from that paper; its `(1,2,3,4),T=2/5`
countercontrol follows directly from the displayed norms. The external
literature-wide statement that a paper does not settle K was not used to
establish any verdict here, and this review does not certify that separate
literature comparison.

## Reproducible fixed controls

Run the following sole Python block from the repository root with `python3 -B`.
It writes no file, runs no Lean command and creates no dependency cache.

```python
from fractions import Fraction as Q
from itertools import product
from math import floor, gcd
from pathlib import Path
from hashlib import sha256
import json

guards = {
    'research/astra-strict-to-mixed-audit.md': 'c7559719cc61d715a47958ab8d1a844faf021c53e08ee3e87c1d0d54e0fb5f2f',
    'research/astra-uniform-direct-mixed-audit.md': '6054472d7412bdb9c5a3c258191f58cf260d50c6240d81eecce05f3be3ba138b',
    'LonelyRunner/DivisorInsertion.lean': '212fa6d879bab6d70f09a4a43b2027b96724b5e5ac4a22cdf4b368509973166f',
    'LonelyRunner/FastRunnerInsertion.lean': 'dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5',
}
for p, h in guards.items():
    assert sha256(Path(p).read_bytes()).hexdigest() == h

def norm(x):
    f = x-floor(x)
    return min(f, 1-f)

def mixed(W, t):
    N = len(W)+1
    return all(norm(w*t) >= Q(1, N) for w in W) and norm(W[-1]*t) >= Q(1, N-1)

def cartesian_cells(W, stronger):
    N = len(W)+1
    lists = []
    for w in W:
        d = Q(1, N-1) if stronger and w == W[-1] else Q(1, N)
        lists.append([((j+d)/w, (j+1-d)/w) for j in range(w//2+1)])
    answer = set()
    for bands in product(*lists):
        l = max(Q(0), *(a for a, b in bands))
        r = min(Q(1, 2), *(b for a, b in bands))
        if l <= r:
            answer.add((l, r))
    return sorted(answer)

for N in (4, 6):
    W = tuple(range(1, N))
    assert cartesian_cells(W, False) == [(Q(1, N), Q(1, N))]
    assert cartesian_cells(W, True) == []

# At N=5,g=2 the grid margin exactly equals the fastest target 1/4.
W = (2, 6, 14, 17); t = Q(1, 4)
assert gcd(*W) == 1 and gcd(*W[:-1]) == 2
assert max(norm(W[-1]*(t+Q(j, 2))) for j in range(2)) == Q(1, 4)
assert mixed(W, t)

# N=4,g=2: an upper-half fastest phase must move in the negative direction.
W = (2, 10, 11); t = Q(1, 4); u = t-Q(1, 12*W[-1])
assert norm(W[-1]*t) == Q(1, 4) and norm(W[-1]*u) == Q(1, 3)
assert all(norm(w*t) >= Q(1, 3) and norm(w*u) > Q(1, 4) for w in W[:-1])
assert mixed(W, u)

# The reduced 1:2 half-phase case retains a lower norm exactly 1/4.
W = (1, 2, 4); t = Q(1, 8); u = t+Q(1, 2)
assert gcd(W[1], W[2]) == 2 and norm(W[0]*t) < Q(1, 4)
assert [norm(w*u) for w in W] == [Q(3, 8), Q(1, 4), Q(1, 2)]
assert mixed(W, u)

# Fast-insertion boundary H=4b, with a nonzero adjustment from fastest phase 0.
W = (3, 5, 20); t = Q(1, 2); u = t+Q(1, 3*W[-1])
assert W[-1] == 4*W[-2] and norm(W[-1]*t) == 0
assert all(norm(w*t) >= Q(1, 3) for w in W[:-1]) and mixed(W, u)

# Strictness does not force the starting component to reach mixed.
W = (3, 4, 7); L, R = Q(5, 28), Q(3, 16); t = (L+R)/2
assert all(norm(w*t) > Q(1, 4) for w in W)
assert norm(W[-1]*L) == Q(1, 4) and norm(W[-1]*R) == Q(5, 16) < Q(1, 3)
assert mixed(W, Q(1, 12))
print(json.dumps({'status': 'PASS', 'singleton_tuples': 2, 'margin_fixtures': 4,
                  'strict_trap_fixture': 1, 'source_guards': len(guards)},
                 sort_keys=True, separators=(',', ':')))
```

## Source guards and handoff

The assigned checkpoint is provenance supplied by the orchestrator; no Git
operation was run. The frozen mathematical sources and program were verified
by bytes:

| Artifact | SHA-256 |
| --- | --- |
| Author manuscript | `c7559719cc61d715a47958ab8d1a844faf021c53e08ee3e87c1d0d54e0fb5f2f` |
| Author sole Python block, including final newline | `9d2275e0229d8a4b1346c317339ba7363337d04b9e6027d2046fc56c7182608b` |
| Author stdout replayed by root, including final newline | `97671355d56908a2c06b4ad6ae9dc20cab31377c1c78968ea2f181fa462ed622` |
| Accepted uniform manuscript | `6054472d7412bdb9c5a3c258191f58cf260d50c6240d81eecce05f3be3ba138b` |
| `DivisorInsertion.lean` | `212fa6d879bab6d70f09a4a43b2027b96724b5e5ac4a22cdf4b368509973166f` |
| `FastRunnerInsertion.lean` | `dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5` |
| `SmallDimensions.lean` | `e4933da3551792130eebf1ede4701bff3296f59eb696dfb7b6276e16d940d699` |
| `.codex/config.toml` | `3d723356048f445685a6b4b977e755c3a2e60c70a134195b7cf39897ec9f9d4e` |
| `docs/project-workflow.md` | `49a1ca496880b250377bd0b61ab6deefc0036865dbe545169527eee2bf7439f7` |
| `research/workflow-policy.json` | `7b25a1b28b0c8cc45228fd7241cdb73ed6267d4f229773d1210a175f730f1242` |
| `scripts/validate_workflow.py` | `899cdf0b58eec8b960286565778b381b80ca07661516cce99c75156c35b4fc04` |

Read-only commands comprised scoped `cat`, `sed`, `rg`, Python JSON/hash reads,
the workflow validator and the fixed-control replay. The only write was this
review. No mathematical source, state, Git, dependency or cache was edited.

The saved reviewer block exited 0 with exact stdout:

```text
{"margin_fixtures":4,"singleton_tuples":2,"source_guards":4,"status":"PASS","strict_trap_fixture":1}
```

Reviewer program SHA-256, including final newline:
`56ace63f4c6d931fac8ab58df9cdb93077ce0a5b98a9ffeb07e4052950f984de`.
Reviewer exact stdout SHA-256, including final newline:
`a900838e456577093f71cd67cf378605f48cf5957f303566585cd3207af29f30`.
Replay precisely with:

```sh
python3 -B - <<'STRICT_TO_MIXED_REVIEW'
from pathlib import Path
from hashlib import sha256
from contextlib import redirect_stdout
import io,re
b=re.findall(r'^```python\n(.*?)^```[ \t]*$',Path('research/astra-strict-to-mixed-review.md').read_text(),re.M|re.S)
assert len(b)==1 and sha256(b[0].encode()).hexdigest()=='56ace63f4c6d931fac8ab58df9cdb93077ce0a5b98a9ffeb07e4052950f984de'
out=io.StringIO()
with redirect_stdout(out):exec(compile(b[0],'strict-to-mixed-review-fixed-controls','exec'),{})
assert sha256(out.getvalue().encode()).hexdigest()=='a900838e456577093f71cd67cf378605f48cf5957f303566585cd3207af29f30'
print(out.getvalue(),end='')
STRICT_TO_MIXED_REVIEW
```

The final workflow validator passed, and the frozen author's hash remained
unchanged. All reviewer commands are stopped at handoff. No Lean build was
needed for this manuscript-only review. The final review artifact hash is
reported separately to avoid a self-reference. The accepted result remains
the stated necessary conditions and sufficient cases for K; the global K
problem, primitive uniform supply, and canonical LRC are not resolved here.
