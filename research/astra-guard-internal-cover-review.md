# Independent one-guard internal-cover review

Requested Astra/xhigh review, 2026-09-05, task
`/root/vanishing_slope-guard-contract-review`. The project configuration,
workflow, policy, and active state were read; the structural validator passed.
Only this review note was edited. No Lean, Git, shared-state, dependency, or
cache changes were made. No timed search was repeated and no new search
domain or counterexample claim was introduced.

**Accepted without mathematical correction:** the entire frozen
`research/astra-guard-internal-cover-audit.md`, SHA-256
`b0139c276fa6f3f331b382796085d4972c73d3ef2e13dac92813fcd8d9490f70`.
Acceptance covers the conditional guard argument, literal proposition
interpretation, search algorithm, and reproduced compact controls. The two
original timed runs and their completed negative rectangles remain explicitly
**author-reported execution evidence**, not independently replayed negatives.
Their reported instance counts agree with the stated loop domains; their
node totals, no-hit outcomes, and elapsed times were not independently
verified here. There is no resulting counterexample to Prompt95 and no
general noncover or LRC theorem.

## 1. Literal proposition and conditional mathematics

I checked the relevant definitions in `PivotResidues.lean` and
`Prompt99Scaling.lean`. The bad predicate is strict distance less than the
pivot. The candidate filter excludes multiples of N. `PivotCovered` allows
all other original labels, whereas `IsInternalOwnerSet` permits only covered
labels other than the selected pivot. A maximum covered pivot is a maximum
among covered labels, not among all original speeds. Finally,
`MaxCoveredPivotInternalCoverRedundancy` is a proposition definition with
positive injective `a : Fin n -> Nat`, `n>=2`, and denominator `N=n+1`.

With c lower owners, one pivot, and one guard, there are c+2 moving speeds.
Therefore c=N-3 is necessary for this construction to address that exact
proposition. The known five-owner row at N=7 has c=N-2 and cannot supply
the missing input after a guard is added without changing N to 8.

For the conditional argument, take the stated natural pivot and speed
domain, N>=3, c=N-3, distinct positive lower owners, and
`A={d_1,...,d_c,p}`. The two independent premises are a lower-owner cover
of `R(N,p)` and a strict witness u/v, with integers `0<u<v`, for every
member of A. Positivity of p is part of the intended positive-speed domain;
even at the degenerate N=3,c=0 case, p=0 cannot satisfy the strict witness
premise. At N=3 the empty-owner cover of the nonempty pivot universe is
impossible, so that endpoint does not produce an overlooked counterexample.

Set L=lcm(A) and C=NLv. Since A contains the positive pivot and each of its
members divides L, L>=p and `Na|C` for every a in A. Also C>p. Thus the
full tuple has exactly N-1 distinct positive speeds. At every candidate of
the a-pivot row, the guard phase `rC/(Na)` is an integer. The guard alone
covers each label in A, using the actual full tuple as the definition requires.

For the guard row choose `r_C=N(C/v)u+1`. It is integral, congruent to 1
modulo N, and satisfies

```text
1 <= r_C <= NC - NC/v + 1 < NC,
```

because u<=v-1 and `NC/v=N^2 L>1`. Its time is exactly
`t_C=u/v+1/(NC)`, in the required canonical period. The guard phase is
an integer plus 1/N, so its circle distance is exactly 1/N for N>=3.
Closed safety, not strict safety, is the intended conclusion for this row.

For a in A, its original distance is `k_a/v` for an integer k_a, even if
u/v is unreduced. The positive integer `Nk_a-v` gives margin at least
`1/(Nv)`. Distance to the nearest integer is 1-Lipschitz, including across
integer and half-integer crossings. The phase shift is bounded by

```text
a/(NC) <= p/(N^2 L v) <= 1/(N^2 v) < 1/(Nv).
```

Every member of A therefore remains strictly above 1/N. Equivalently its
integer residue distance at r_C modulo NC is strictly greater than C.
No phase-wrap assumption, height cutoff, or enumeration of the guard grid
is needed. This proves the guard is noncovered and supplies an ordinary
closed witness for all N-1 original moving speeds.

There are no other labels, so covered labels are exactly A, under the
injective speed/label correspondence, and p is their largest speed. Choose
a minimum-cardinality covering subfamily of the finite lower-owner family.
It is internal. Deleting any selected member fails coverage: since that
member belongs to a complete cover, a missed candidate after deletion is
in its bad set and in none of the other selected bad sets. This gives the
claimed private point for each member. Hence that cover has no removable
owner and violates `InternalCoverRedundantAt` at the actual maximum covered
pivot. The argument does not confuse removal from an internal cover with
availability of the external guard.

This establishes exactly the conditional refutation mechanism. It supplies
neither premise. Padding a smaller cover preserves its cover predicate,
but the strict witness must be rechecked for the entire padded family.
Continuity supplies a rational strict witness from a separately known strict
real witness; it does not justify presuming one exists.

## 2. Exact solver semantics

The embedded solver bytes, including their final newline, have the stated
SHA-256 `f18d0b4aa467189e7b10258cb52edb9059eaea9cdaa95ba1af697543937dc049`.
I reviewed the whole solver and replayed it directly from those frozen bytes.
Its decision contract on the specified domains is existence of a cover with
at most k distinct speeds in `1,...,p-1`.

- Reflection sends r to Np-r and preserves both candidate status and each
  owner's distance. The stored half-range contains one representative of
  every orbit; a possible midpoint is included once. Zero is not a candidate.
- At a recursive node, the uncovered bitset is exact. Owners with zero
  remaining gain can never be useful for that node. An insufficient union
  proves impossibility. The sum of the k largest gains is an upper bound on
  coverage achievable by k owners, even though overlaps are counted twice;
  its pruning inequality cannot remove a solution.
- Every completion must choose an owner of the selected uncovered point.
  The ordered branches assign that completion to its first such owner.
  Earlier branch owners and the current owner are removed for the recursive
  call; later branch owners remain available. Integer bitsets are passed by
  value, so deeper mutations do not remove options from unrelated siblings.
  All useful owners of the selected point appear in the branch list.
- A recursive success returns distinct owners and an actual cover; the k=1
  shortcut requires an owner to cover the entire remaining universe. On the
  tested domains the returned list is nonempty, so the caller's truth-value
  test is appropriate. Empty-family or invalid-input API generalizations
  are not claimed by the program.
- Timeout raises `TimeoutError`, never `None`. It is checked once per 16,384
  nodes, not continuously, and preprocessing is outside that check; elapsed
  time can exceed the requested duration. A search that nevertheless finishes
  is an exact completed decision. On an exception the driver prints an
  unfinished instance and exits 2 before adding its nodes or decision to the
  completed totals. Thus timeout is not negative evidence for that instance.

The comparison with exactly-k literal subsets is legitimate for all 440
test cases because k<=p-1. A smaller cover can be padded with unused owners.
It makes no assertion about strict witnesses after padding. The main search
skips instances lacking enough distinct lower speeds for its counted tuple.

## 3. Independently reproduced controls

Both the author's compact comparison block and the independent reproducer
below passed: 440 decisions, including 101 positive and 339 negative cases,
for N=3..10, p=2..14, and k=1..min(5,p-1). Every solver-positive output
was additionally validated as a distinct actual cover over the **full**
candidate universe, independently of reflection and bitset construction.

The positive solver control `(7,11,5)` returns `[1,7,6,5,4]`;
`(7,11,4)` and `(9,18,6)` return no cover. The old N=7 five-owner cover
has all five private points as stated. For the correctly counted N=8 guard
control, the strict rational distances, guard size, canonical numerator,
all six owner distances, and guard equality match exactly. Every small
original pivot row was also enumerated with the actual guard: all are
covered. At pivot 11 the eight internal safe residues are exactly the
listed ones. Hence this control does not refute the redundancy proposition.

The separate N=9 tuple's guard noncoverage certificate and all its
divisibilities were independently checked, establishing its maximum covered
pivot is 18. Its internal r=56 control has distance exactly 18 for speed 9;
that equality is safe. It too is not an internal complete cover.

The original timed rectangles were **not rerun**. Their loop cardinalities
771 and 851 were independently recomputed, including the specified partial
final p rows. This verifies only consistency of the reported domains and
instance counts, not their no-hit outcomes or branch-node totals. The
overlapping rectangles cannot be added as disjoint negative instances.
Even accepting the author's reports gives only finite negative evidence.

All four frozen input hashes in the manuscript were verified: the two Lean
definition sources, `docs/internal-pair-overlap-supply-refutation.md`, and
`research/astra-next-bridge-audit.md`. No Lean declaration was built or axiom
checked for this manuscript-only review. The guard proof does not depend on
the N=7 three-owner theorem or on quarantined historical search artifacts.

## 4. Compact independent reproducer

Run this code from the repository root. It reads the exact frozen solver
into memory, creates no temporary program or search artifact, and uses
literal full-residue sets for the independent oracle. It does not run either
timed search invocation.

```python
from pathlib import Path
from hashlib import sha256
from itertools import combinations
from math import lcm
from fractions import Fraction as F
from time import monotonic
import re

path = Path('research/astra-guard-internal-cover-audit.md')
assert sha256(path.read_bytes()).hexdigest() == (
    'b0139c276fa6f3f331b382796085d4972c73d3ef2e13dac92813fcd8d9490f70')
code = re.findall(r'```python\n(.*?)\n```',path.read_text(),re.S)[0]
assert sha256((code+'\n').encode()).hexdigest() == (
    'f18d0b4aa467189e7b10258cb52edb9059eaea9cdaa95ba1af697543937dc049')
ns = {'__name__':'reviewed_guard_solver'}
exec(compile(code,'frozen_guard_solver','exec'),ns)

def dist(M,x):
    r = x % M
    return min(r,M-r)

def candidates(N,p):
    return {r for r in range(N*p) if r % N}

def bad(N,p,d):
    return {r for r in candidates(N,p) if dist(N*p,r*d)<p}

count = positive = negative = 0
for N in range(3,11):
    for p in range(2,15):
        R = candidates(N,p)
        B = {d:bad(N,p,d) for d in range(1,p)}
        for k in range(1,min(p,6)):
            expected = next((D for D in combinations(B,k)
                             if set().union(*(B[d] for d in D)) == R),None)
            actual,_ = ns['solve'](N,p,k,monotonic()+60)
            assert (expected is None) == (actual is None)
            if actual is not None:
                assert len(set(actual)) == len(actual) <= k
                assert set(actual) <= set(B)
                assert set().union(*(B[d] for d in actual)) == R
                positive += 1
            else:
                negative += 1
            count += 1
assert (count,positive,negative) == (440,101,339)
assert ns['solve'](7,11,5,monotonic()+60)[0] == [1,7,6,5,4]
assert ns['solve'](7,11,4,monotonic()+60)[0] is None
assert ns['solve'](9,18,6,monotonic()+60)[0] is None

owners = (1,4,5,6,7)
B = [bad(7,11,d) for d in owners]
assert set.union(*B) == candidates(7,11)
for i,r in enumerate((3,18,15,13,11)):
    assert r in B[i] and all(r not in X for j,X in enumerate(B) if j!=i)

N,A,u,v = 8,(1,4,5,6,7,11),13,42
C = N*lcm(*A)*v
r = N*(C//v)*u+1
M = N*C
assert len(set(A+(C,))) == N-1
assert (C,r,M) == (1552320,3843841,12418560)
assert tuple(F(dist(v,a*u),v) for a in A) == (
    F(13,42),F(5,21),F(19,42),F(1,7),F(1,6),F(17,42))
assert all(N*dist(v,a*u)>v for a in A)
assert all(C % (N*a) == 0 for a in A)
assert 0<r<M and r % N == 1
assert tuple(dist(M,r*a) for a in A) == (
    3843841,2956804,5617915,1774074,2069767,5026571)
assert all(dist(M,r*a)>C for a in A) and dist(M,r*C)==C
for p in A:
    assert bad(N,p,C) == candidates(N,p)
safe = sorted(candidates(8,11)-set.union(*(bad(8,11,d) for d in owners)))
assert safe == [11,27,33,41,47,55,61,77]

V = (7,8,9,10,11,13,18,3243240)
C,r = V[-1],15285851
assert len(V)+1 == 9 and 0<r<9*C and r % 9
assert all(C % (9*a) == 0 for a in V[:-1])
assert tuple(dist(9*C,r*a) for a in V[:-1]) == (
    9755683,5530168,8373141,6912710,6990599,5608057,12442878)
assert all(dist(9*C,r*a)>=C for a in V[:-1])
assert tuple(dist(162,56*a) for a in V[:-2]) == (68,38,18,74,32,80)
assert 56 % 9 and all(dist(162,56*a)>=18 for a in V[:-2])

# Count reported completed domains only: no negative decisions are replayed.
first = sum(p-1>=N-3 for p in range(2,104) for N in range(7,15))+7
second = sum(p-1>=N-3 for p in range(2,289) for N in range(7,10))+2
assert (first,second) == (771,851)
print({'decisions':count,'positive':positive,'negative':negative,
       'exact_controls':'passed','timed_runs':'author-reported, not rerun',
       'reported_domain_counts_only':(first,second)})
```

The bounded branch ends with a correct conditional mechanism and no supplied
input realizing it. A future counterexample would still need a correctly
counted lower-owner cover and a strict witness for the complete smaller
family, followed by the actual labelled proposition check. The canonical
Lonely Runner goal remains unresolved.
