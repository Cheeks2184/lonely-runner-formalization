# Independent endpoint-label review

Reviewer `/root/guard_internal_cover_audit`, requested Astra/xhigh, 2026-09-05.
Review base: `e371af814f023bf2761e7b25de980b763347d049`.
Only this review file is owned; no Lean/source, cache, state, or Git changes.
Current project workflow/policy/state were read and structural validation passed.

Frozen author manuscript: `research/astra-endpoint-label-audit.md`, SHA-256
`667b9bcdebf30333c551badf6e9ef6c861e5e1ca1095808ece5354733745e44d`.
Its first embedded program has SHA-256
`a229711e8e32b4eb197473e8e2711f2893eef229a87f1aeb0ca7dc2821cc58b2`.
Both Python blocks and the entire mathematical manuscript were read.
The author confirmed all search/control processes stopped before freezing.

## Quantifiers and least-count application

Write P(a) for coverage of the complete actual a-row by the other original
labels at the original denominator N. Since both owner sets are nonempty,
C_all is equivalent to `(all a in E_L, not P(a)) or
(all b in E_R, not P(b))`. Its failure means there is a covered left owner
and a covered right owner. C_some instead means that the union of the two
owner sets contains a noncovered owner; its failure means every owner in
that union is covered. The program's `fail_all` and `fail_some` implement
exactly these respective negations. C_all implies C_some, but ties can make
the implication strict. Absence of ties in the finite fixtures does not
remove this distinction from either candidate's quantifiers.

For a least-count positive-integer failure at N>=4, deletion of the actual
maximum leaves N-2 moving speeds. Minimality supplies a seed at 1/(N-1).
The full tuple's failure makes every actual pivot row covered, and every
old-good component containing a stronger seed must lie in one open p-bad
interval: it is a connected closed interval, and every point in it has all
old speeds good. Either universal candidate would supply a noncovered
endpoint-owner row and hence a full witness, a contradiction. This uses
least positive-integer count after the all-dimensional canonical equivalence;
it assumes no unproved count-preserving BHK reduction. The candidates remain
unproved, so this conditional implication is not an LRC result.

The component endpoints are attained maxima/minima of finitely many bands;
stronger margin puts the seed strictly inside the component. A common owner
of both endpoints would give width `(N-2)/(N*a)`, which exceeds
`2/(N*p)` since N>=4 and a<p. Strict trapping therefore makes E_L and E_R
disjoint, as the manuscript and audit code require. The argument covers
negative times and closed seed equality; it does not discard singleton
stronger-witness components.

## Same-row common-divisor proof

For finite nonempty positive old speeds, D=gcd(V)>0 and g=gcd(D,p)>0.
Thus m=D/g is positive, and condition 2m<=N(m-1) forces m>=2.
The phase orbit under shifts j/D has size exactly m, since
`gcd(p/g,D/g)=1`. It is a translate of the m-point uniform circle grid.
A point lies within 1/(2m) of the antipode, hence has norm at least
`(m-1)/(2m)>=1/N`. Every old phase is unchanged modulo one.
The two cited declarations in `LonelyRunner/DivisorInsertion.lean` have
exactly this closed mesh bound and arbitrary real starting phase; the extra
same-row conclusion is a manuscript proof, not a new compiled theorem.

If the starting time on the actual old a-row is r/(N*a), the shifted
signed numerator is `u=r+N*(a/D)*j`. The integer a/D exists because D divides
every old speed. Therefore u is congruent to r modulo N. Reduction modulo
positive N*a produces r' in the original a-row, not an auxiliary row.
Writing u=q*N*a+r' shows that every original integer phase changes by q*v;
all full-tuple norm bounds survive. This handles negative r/u and does not
require j to be nonnegative. A representative 0<=j<m may also be chosen.

Each left endpoint owner has signed numerator N*floor(a*t)+1, and each
right owner has N*(floor(a*t)+1)-1. These are nonmultiples of N, including
for negative floors. Since the endpoint lies in the closed old-good set,
normalization supplies the proposition's old-safe starting candidate.
Consequently every tied owner on both sides is noncovered under the mesh
condition. More generally adding p preserves old-row coverage status:
coverage is monotone on adding a potential spoiler, while the orbit map
preserves every old noncoverage certificate in the reverse direction.

For N>=4,m>=2 the mesh inequality holds, including equality at N=4,m=2.
Equality yields closed goodness only; the two antipodal phases 1/4 and 3/4
show why a strict improvement cannot be inserted.

Common positive scaling preserves every full row: the scaled phase at r is
`r*(h*v)/(N*h*a)=r*v/(N*a)`, and reducing r modulo N*a preserves its
nonzero N-class and all norms. Conversely every unscaled representative is
already in the larger row. Times/components scale by 1/h with corresponding
stronger seeds and owner labels. Dividing by H=gcd(V union {p})=gcd(D,p)
gives old gcd D/H and new pivot p/H, which are coprime. Thus every primitive
case with old gcd greater than one is covered by the proposition. Restriction
of the remaining problem to old gcd one is valid and does not solve it.

## Solver and provenance boundary

The half-row masks are complete because r and N*p-r have the same candidate
status and badness for every integer owner. Rare-uncovered-point branching
partitions solutions by the first selected available owner of that point;
removing previous branch owners prevents duplicate outputs. Union and top-k
gain bounds are safe pruning rules. Once all points are covered, all remaining
size-k completions are emitted, retaining covers containing redundant owners.
The explicit oracle compares complete output sets, not merely counts.

Closed band intersections retain zero-width stronger components. The weak
component's seeded interior keeps each floor fixed; selecting one seed does
not lose endpoint ties. Strict containment in a single open new bad arc is
checked with exact rational endpoints. Actual covered labels always refer to
the entire original tuple. The primitive filter is applied only after a
complete largest-row cover has been found, using the valid scaling symmetry.

The 381-instance first search and the second run's 564 completed instances,
24 total covers, node count, and elapsed times are author-reported timed-run
provenance, not independently rerun discovery. The claimed completed second
prefix is all feasible N=6..10,p<=118 plus N=6..9,p=119; (10,119) is unfinished.
Nothing beyond that prefix is certified exhausted. The two runs overlap and
must not be added. Deadline checks occur periodically in DFS and between
yielded covers, so the time arguments are not hard process kill deadlines;
the recorded finite domains and explicit unfinished-instance exclusions are
what support the stated bounded scope. No discovery search is run here.

The independent replay below checks the frozen small oracle and positive
certificates, plus separate rational row/component calculations and tie logic.
These computations support the explicit fixtures only; they do not prove the
candidate universally or independently authenticate timed-search history.

## Exact independent reproducer

Run this block from the repository root with standard Python. It checks the
frozen hashes, loads the author program in memory without invoking `search`,
and runs the author's unaltered control calculations (only replacing the
three-line temporary-file loader by that in-memory module). The additional
verifier obtains all components by testing the arrangement of rational band
endpoints, rather than using the author's interval-intersection algorithm.
It tests full original rows using rational norms, including the pivot.

```python
from pathlib import Path
from hashlib import sha256
from types import ModuleType
from fractions import Fraction as F
from itertools import product
import re

path = Path('research/astra-endpoint-label-audit.md')
raw = path.read_bytes()
assert sha256(raw).hexdigest() == \
    '667b9bcdebf30333c551badf6e9ef6c861e5e1ca1095808ece5354733745e44d'
blocks = re.findall(r'^```python\n(.*?)^```[ \t]*$', raw.decode(), re.M|re.S)
assert len(blocks) == 2
assert sha256(blocks[0].encode()).hexdigest() == \
    'a229711e8e32b4eb197473e8e2711f2893eef229a87f1aeb0ca7dc2821cc58b2'
module = ModuleType('endpoint')
exec(compile(blocks[0], 'frozen-endpoint-program', 'exec'), module.__dict__)
loader = "s=spec_from_file_location('endpoint','/tmp/lrc_endpoint_audit.py')\n" \
         "e=module_from_spec(s);s.loader.exec_module(e)"
assert blocks[1].count(loader) == 1
controls = blocks[1].replace(loader, 'e=review_module')
ns = {'review_module': module}
exec(compile(controls, 'frozen-endpoint-controls', 'exec'), ns)

# This independent verifier uses real phase fractions at all arrangement
# endpoints/midpoints, retaining isolated good points and merging good cells.
def norm(x):
    return min(x % 1, (-x) % 1)

def good(V, N, t):
    return all(norm(v*t) >= F(1,N) for v in V)

def literal_components(V, N):
    points = {F(0), F(1)}
    for v in V:
        for j in range(v):
            points.add((F(j)+F(1,N))/v)
            points.add((F(j+1)-F(1,N))/v)
    points = sorted(points)
    cells = [(x,x) for x in points if good(V,N,x)]
    cells += [(x,y) for x,y in zip(points,points[1:])
              if good(V,N,(x+y)/2)]
    merged = []
    for L,R in sorted(cells):
        if merged and L <= merged[-1][1]:
            merged[-1] = (merged[-1][0], max(R,merged[-1][1]))
        else:
            merged.append((L,R))
    return merged

def literal_safe(N, A, a):
    return [r for r in range(N*a) if r % N and good(A,N,F(r,N*a))]

fixture_rows = fixture_traps = 0
for N,V,p,C,count in ns['fixtures']:
    A = V+(p,)
    assert len(A) == len(set(A)) == N-1 and max(V) < p
    covered = {a for a in A if not literal_safe(N,A,a)}
    assert covered == set(C)
    fixture_rows += len(A)
    strong = literal_components(V,N-1)
    weak = literal_components(V,N)
    assert strong == module.components(V,N-1)
    assert weak == module.components(V,N)
    trapped = []
    for L,R in weak:
        if not any(max(L,x) <= min(R,y) for x,y in strong):
            continue
        if not any(F(N*j-1,N*p) < L <= R < F(N*j+1,N*p)
                   for j in range(p+1)):
            continue
        EL = {a for a in V if (a*L)%1 == F(1,N)}
        ER = {a for a in V if (a*R)%1 == 1-F(1,N)}
        assert EL and ER and not EL & ER
        assert not ((EL & covered) and (ER & covered))
        assert len(EL) == len(ER) == 1
        trapped.append((L,R))
    assert len(trapped) == count
    fixture_traps += count
assert fixture_rows == 70 and fixture_traps == 60

# All Boolean coverage assignments for nonempty owner sets of sizes 1..3.
tie_cases = 0
strict_tie_example = False
for lsize,rsize in product(range(1,4), repeat=2):
    EL = set(range(lsize))
    ER = set(range(lsize,lsize+rsize))
    for flags in product((False,True), repeat=lsize+rsize):
        covered = {i for i,c in enumerate(flags) if c}
        c_all = all(a not in covered or b not in covered for a in EL for b in ER)
        c_some = any(a not in covered or b not in covered for a in EL for b in ER)
        assert c_all == (not (EL & covered) or not (ER & covered))
        assert c_some == (not ((EL | ER) <= covered))
        assert not c_all or c_some
        strict_tie_example |= c_some and not c_all
        tie_cases += 1
assert tie_cases == 196 and strict_tie_example

# Independently certify the dropped-largest-row control and its negative copy.
N,V,p = 7,(2,5,7,12,17),19
A = V+(p,)
assert {a for a in A if not literal_safe(N,A,a)} == {5,17}
assert literal_safe(N,A,p) == [13,41,92,120]
for t in (F(31,85), -F(31,85)):
    assert good(V,N-1,t)
    floors = {a:(a*t).numerator//(a*t).denominator for a in V}
    L = max((F(floors[a])+F(1,N))/a for a in V)
    R = min((F(floors[a]+1)-F(1,N))/a for a in V)
    EL = {a for a in V if (a*L)%1 == F(1,N)}
    ER = {a for a in V if (a*R)%1 == 1-F(1,N)}
    assert EL | ER == {5,17} and len(EL) == len(ER) == 1
    for x,owners in ((L,EL),(R,ER)):
        assert good(V,N,x) and norm(p*x) < F(1,N)
        for a in owners:
            u = N*a*x
            assert u.denominator == 1
            r = int(u) % (N*a)
            assert r%N in (1,N-1) and good(V,N,F(r,N*a))
            assert not good(A,N,F(r,N*a))

assert sum(70-N+2 for N in range(6,12)) == 381
assert sum(118-N+2 for N in range(6,11))+4 == 564
print(dict(independent_fixture_rows=fixture_rows,
           independent_trapped_components=fixture_traps,
           tie_assignments=tie_cases, signed_near_control='passed',
           completed_prefix_arithmetic='passed', discovery_runs=0))
```

Executed from the repository root with:

```bash
PYTHONDONTWRITEBYTECODE=1 python3 - <<'REVIEW_REPLAY'
from pathlib import Path
import re
p = Path('research/astra-endpoint-label-review.md')
blocks = re.findall(r'^```python\n(.*?)^```[ \t]*$', p.read_text(), re.M|re.S)
assert len(blocks) == 1
exec(compile(blocks[0], str(p), 'exec'))
REVIEW_REPLAY
```

Observed final result: exit 0, with the exact two outputs:

```text
{'solver_comparisons': 480, 'positive_covers': 10, 'trapped_components': 60, 'shifted_old_candidates': 2448, 'closed_mesh_equality': 'passed', 'near_control': 'passed'}
{'independent_fixture_rows': 70, 'independent_trapped_components': 60, 'tie_assignments': 196, 'signed_near_control': 'passed', 'completed_prefix_arithmetic': 'passed', 'discovery_runs': 0}
```

The initial independent harness mistakenly expected 71 fixture rows. Summing
the ten original tuple sizes gives 70; only that reviewer assertion was
corrected before the complete successful replay. No author program,
certificate, or manuscript correction was required.

The dropped-largest-row example is exactly as stated: its stronger seed is
31/85, its closed weak component is [43/119,13/35], and its unique owners
are 17 and 5. Both owners are covered, but the actual 19-row has the four
safe residues [13,41,92,120]. Thus it refutes both tie versions after deleting
only largest-row coverage; it refutes neither actual candidate. Negative-time
reflection and signed endpoint normalization were independently checked.

Inspected source bindings, also verified by SHA-256:

```text
212fa6d879bab6d70f09a4a43b2027b96724b5e5ac4a22cdf4b368509973166f  LonelyRunner/DivisorInsertion.lean
362da5ab923f22e900ae7ac821dd4cf4aab91dfe70889987bc9e5a05d19c276a  LonelyRunner/PivotResidues.lean
49131a7f9690042d1b16cbc876417f9d9ce1b53cc6565f87b6d1b53c4e3340cd  LonelyRunner/Prompt99Scaling.lean
```

**Disposition: accepted as a scoped mathematical audit.** The common-divisor
same-row proposition, endpoint normalization, primitive reduction, and exact
dropped-hypothesis counterexample are sound. The candidate contracts and their
conditional least-count application retain the correct labels and quantifiers.
The positive certificates and small oracle have been independently reproduced;
the timed discovery history remains author-reported with the stated limits.

Neither C_all nor C_some has been proved or refuted under all its hypotheses
in the remaining primitive old-gcd-one case. A proof must control complete
original pivot rows using the largest-row hypothesis; one spoiled endpoint
alone supplies no noncoverage certificate. The universal LRC remains
unresolved. No new Lean theorem, build, dependency restoration, or discovery
search was performed. All reviewer commands have stopped.
