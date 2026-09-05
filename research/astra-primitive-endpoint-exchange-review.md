# Independent primitive endpoint-exchange review

Reviewer `/root/guard_internal_cover_audit`, requested Astra/xhigh, 2026-09-05.
Current base: `98cdd1c1ab8d6c0cbac73bff3f0385a1f9970dbf`.
Current project configuration, workflow, policy, and state were read;
`python3 scripts/validate_workflow.py` passed. Only this review is owned.

Frozen manuscript: `research/astra-primitive-endpoint-exchange.md`, SHA-256
`53646c4ddfbc0b25ceb6027503434b22072ec5782bed68bf5bba50beeaffe24f`.
The manuscript and its complete executable block were read. The referenced
endpoint audit remains bound to
`667b9bcdebf30333c551badf6e9ef6c861e5e1ca1095808ece5354733745e44d`.
No author-file, Lean, cache, shared-state, or Git edits are part of this review.

## Separation and preservation contracts

The separation equivalence is correct. At any signed candidate time
r/(N*p), the actual pivot is already good because its phase is r/N and
N does not divide r. Being old-good is therefore exactly being a safe
representative of that actual row. Reduction modulo N*p preserves every
integer-speed norm and the nonzero residue modulo N. This proves the
infinite-grid/finite-row equivalence in both directions, including negative r.

A nonempty component of the closed old-good set is bounded: it lies inside
one bounded good band of any positive old speed. It is a closed interval
(possibly a point). A connected set avoiding the discrete, two-sided candidate
grid lies in one open gap. Its attained endpoints therefore lie strictly
inside that gap. No unjustified assertion about an unbounded component or
an unattained endpoint is needed. Across an omitted N-multiple the gap is
exactly the open p-bad interval of length 2/(N*p); the remaining gaps have
length 1/(N*p) and are entirely p-good. Thus coverage permits full witnesses
in good gaps away from the candidate grid; it does not imply that every
old-good component is p-bad.

For a trapped interval and its neighboring candidate x on the left,
0<a*(L-x)<2*a/(N*p)<2/N. The endpoint owner's phase at L is 1/N, so the
phase at x is within distance strictly less than 1/N of an integer. This
proves that owner already spoils x. The upper owner gives the symmetric
right statement. These two local failures follow from trapping itself and
do not substitute for coverage of the complete p-row.

With old gcd one, preservation of every old phase by a shift s forces
v*s integral for every old v; a Bezout combination gives s integral. Such
shifts preserve the new integer phase too. Requiring every old norm to be
preserved globally is also a stronger restriction than set preservation:
evaluation at x=0 forces v*s integral for an isometry epsilon*x+s that
preserves each norm everywhere. Neither statement rules out changes of old
phases or norms at a single selected endpoint.

## Six components and the topological step

The exact interval inventory can be certified without sampling an unbounded
time domain: intersect every combination of the finitely many closed good
phase bands in [0,1]. The independent replay below uses this method, separate
from the author's arrangement-endpoint/midpoint method. The complete old set
has six positive-length components; there are no isolated good points or
components crossing 0 modulo one. The full tuple's good set consists exactly
of the two shortest components.

For a translation preserving the old set on the circle, connected components
are permuted and lengths are retained. The two shortest components, of width
1/294, must therefore be permuted. Orientation preservation sends their left
endpoints to left endpoints modulo one. Fixing either endpoint forces an
integral shift. Swapping them forces twice their separation to be integral,
which is impossible because the separation is 113/294 and its double is
113/147. This argument classifies every real shift; the finite endpoint test
is a complete necessary test, not an enumeration of selected rational shifts.

One-sided inclusion suffices here as well. Work on the circle, with finite
arc-length measure (not the infinite periodic subset of the real line).
An isometry preserves this measure, and its image of the six-interval set is
compact and closed. If the inclusion were proper, a point of the old set
outside the closed image would have a neighborhood disjoint from that image.
The old set is the closure of its interior because each of its six intervals
has positive length. The neighborhood therefore contains a positive-length
subinterval of the old set outside the image. This contradicts equal finite
measure. This regular-closed argument applies to this set; no corresponding
claim for arbitrary non-isometric maps is being used.

The old set is invariant under x -> -x by evenness of every defining norm.
Consequently x -> s-x preserves it exactly when translation by s does;
composition with that fixed reflection proves both implications. Hence all
preserving circle isometries are x -> x+j or x -> -x+j with integer j.
Both preserve the norm of the new integer speed 11. As every point in the
specified trapped component is 11-bad, no such isometry can move either
endpoint, or any other point of that component, to a full witness.

## Exact candidate scope and strategic value

The fixed example has N=7, five distinct positive old speeds (1,4,5,6,7),
old gcd one, and new maximum 11. Its actual largest row is covered; this
is not the previous dropped-largest-row example. The seed 13/36 is old-good
at 1/6, with speed 6 exactly at that closed stronger boundary. Its weak
component is [5/14,13/35], strictly inside (27/77,29/77), and the unique
endpoint owners are 6 and 5. Thus all actual endpoint-candidate premises
are retained when the stronger global-isometry mechanism fails.

Nevertheless the original 6-row has the full witness 29/42, whose numerator
29 is congruent to 1 modulo 7. It equals the left endpoint plus 1/3 and
has the original-speed norms displayed in the manuscript, including the
closed speed-6 boundary 1/7. At the right endpoint, the same shift produces
74/105, where speed 7 has norm 1/15<1/7. Thus this successful selected-point
exchange explicitly changes the global old-good set. C_some is satisfied
here. The covered-label set {1,4,5,11} also confirms that owner 6 is
noncovered, while owner 5 is covered.

A shift by j/a preserves the old endpoint owner's signed numerator class
modulo N, hence restricting to these shifts imposes a fixed-class witness
requirement beyond unrestricted row noncoverage. The manuscript does not
silently replace the actual endpoint candidate by that stronger condition.

This is a valid stopping certificate for the particular global translation/
reflection mechanism. It supplies no positive exchange theorem in the
primitive case and no refutation of endpoint-specific exchanges or C_some.
The reusable structural information is the global candidate-gap separation;
the endpoint-row existence step remains open. Further exclusions of stronger
mechanisms would not by themselves establish that missing step or advance the
unrestricted proof to completion.

## Independent replay

The following block executes the single frozen author control, then checks
the component inventory by an independent phase-band intersection method.
The domain is only this fixed tuple: 840 old phase-band combinations and
9,240 full-tuple combinations, six translation candidates justified by the
component-permutation argument, and 264 signed candidate-grid representatives.
No speed discovery search or Lean compilation is invoked.

```python
from pathlib import Path
from hashlib import sha256
from fractions import Fraction as F
from itertools import product
import re

p = Path('research/astra-primitive-endpoint-exchange.md')
assert sha256(p.read_bytes()).hexdigest() == \
    '53646c4ddfbc0b25ceb6027503434b22072ec5782bed68bf5bba50beeaffe24f'
assert sha256(Path('research/astra-endpoint-label-audit.md').read_bytes()).hexdigest() == \
    '667b9bcdebf30333c551badf6e9ef6c861e5e1ca1095808ece5354733745e44d'
blocks = re.findall(r'^```python\n(.*?)^```[ \t]*$', p.read_text(), re.M|re.S)
assert len(blocks) == 1
ns = {}
exec(compile(blocks[0], str(p), 'exec'), ns)

def norm(x):
    return min(x%1, (-x)%1)

def good(V, N, x):
    return all(norm(v*x) >= F(1,N) for v in V)

def band_intersections(V, N):
    bands = [[(F(N*k+1,N*v), F(N*(k+1)-1,N*v)) for k in range(v)]
             for v in V]
    found = []
    tested = 0
    for choice in product(*bands):
        tested += 1
        L = max(x for x,y in choice)
        R = min(y for x,y in choice)
        if L <= R:
            found.append((L,R))
    assert len(found) == len(set(found))
    return sorted(found),tested

N,V,pivot = 7,(1,4,5,6,7),11
A = V+(pivot,)
S,old_boxes = band_intersections(V,N)
full,full_boxes = band_intersections(A,N)
assert old_boxes == 840 and full_boxes == 9240
assert S == ns['expected'] and full == [S[0],S[-1]]
assert all(x<y for x,y in S)
assert sum(y-x for x,y in S) == F(97,1470)

# Enumerate every shift permitted even by the full left-endpoint set.
# The proof above explains why every preserving real shift occurs here.
lefts = {x for x,y in S}
shifts = {(x-S[0][0])%1 for x in lefts}
assert len(shifts) == 6

def shifted(S, s):
    pieces = []
    for x,y in S:
        L = (x+s)%1
        R = L+(y-x)
        if R < 1:
            pieces.append((L,R))
        else:
            pieces += [(L,F(1)),(F(0),R-1)]
    return sorted(pieces)

assert {s for s in shifts if shifted(S,s)==S} == {F(0)}
assert sorted((1-y,1-x) for x,y in S) == S

# Check every representative in two periods on either side of zero.
M = N*pivot
signed = [r for r in range(-2*M,2*M+1) if r%N]
assert len(signed) == 264
for r in signed:
    t = F(r,M)
    r0 = r%M
    assert r0%N == r%N and 0<=r0<M
    assert norm(pivot*t) >= F(1,N)
    assert not good(V,N,t)
    assert all(norm(v*t)==norm(F(v*r0,M)) for v in A)

# Independent integer-residue verification of the full original tuple rows.
def safe_row(a):
    M = N*a
    return [r for r in range(M) if r%N and
            all(min((r*v)%M,(-r*v)%M) >= a for v in A)]
assert {a for a in A if not safe_row(a)} == {1,4,5,11}
assert 29 in safe_row(6)
L,R = F(5,14),F(13,35)
assert good(V,6,F(13,36)) and norm(6*F(13,36)) == F(1,6)
assert L+F(1,3)==F(29,42) and good(A,N,F(29,42))
assert R+F(1,3)==F(74,105)
assert norm(7*(R+F(1,3)))==F(1,15) and not good(V,N,R+F(1,3))
print(dict(old_band_boxes=old_boxes,full_band_boxes=full_boxes,
           components=len(S),total_circle_length=str(F(97,1470)),
           possible_translation_shifts=len(shifts),signed_grid_controls=len(signed),
           original_rows=len(A),pointwise_exchange='passed',discovery_searches=0))
```

Executed with:

```bash
PYTHONDONTWRITEBYTECODE=1 python3 - <<'REVIEW_REPLAY'
from pathlib import Path
import re
p = Path('research/astra-primitive-endpoint-exchange-review.md')
blocks = re.findall(r'^```python\n(.*?)^```[ \t]*$', p.read_text(), re.M|re.S)
assert len(blocks) == 1
exec(compile(blocks[0], str(p), 'exec'))
REVIEW_REPLAY
```

Observed result: exit 0. The author block reported six old components,
covered labels [1,4,5,11], widths 1/294, 1/70, 3/196, shortest separation
113/294 and its double 113/147; both named controls passed. The independent
replay reported:

```text
{'old_band_boxes': 840, 'full_band_boxes': 9240, 'components': 6, 'total_circle_length': '97/1470', 'possible_translation_shifts': 6, 'signed_grid_controls': 264, 'original_rows': 6, 'pointwise_exchange': 'passed', 'discovery_searches': 0}
```

**Disposition: accepted within the stated scope, with no required manuscript
correction.** The grid-separation lemma and the exact global-isometry
obstruction are sound. The six-component inventory supplies a complete
argument for all real translations and reflections, not just sampled shifts.
The original-row witness and failed global +1/3 shift preserve the distinction
between global set symmetries and exchanges chosen for one endpoint.

This stops that sufficient-mechanism branch. It proves no primitive endpoint
exchange theorem and refutes neither C_some nor the unrestricted conjecture.
The missing step is still an actual safe point on an endpoint owner's original
row under all candidate hypotheses. All review commands stopped; no discovery
search, Lean build, dependency restoration, or shared-state mutation ran.
