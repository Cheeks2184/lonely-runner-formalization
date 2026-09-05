# Independent first-blocker width review

Reviewer `/root/guard_internal_cover_audit`, requested Astra/xhigh, 2026-09-05.
Source checkpoint: `b246af6f15198b5aee95ad5c5b4d84f4cc6ffd83`.
Current project configuration, workflow, policy, and state were read, and
workflow structural validation passed. Only this review file is owned.

Frozen manuscript: `research/astra-first-blocker-width-audit.md`, SHA-256
`79638a6e7ff3454ac0efd8bcd7a13b73a42a22a989b4f25d7c8a52f0e16646df`.
Its control JSON is bound to
`2aa24ca0d4c50b21bb5c15ab3d12cc0105306d15f65a5248adc70cc50bd5a67e`.
The entire manuscript, full fixture inventory, and stored checker were read.
No author, Lean, cache, shared-state, or Git edits are part of this review.

## Fixed-set dichotomy and quantifiers

The fixed-set result is sound for N>=4 and every nonempty finite positive
integer old set V whose closed old-good set S is nonempty. No canonical
cardinality, reference pivot, largest-row coverage, or stronger seed is used.
All components and all their endpoints are required, including isolated
points. Integer times are old-bad; hence the finite interval inventory in
[0,1] lies in (0,1) and represents all real times by periodicity.

Each endpoint is an attained boundary of an old good band, so its rational
denominator divides T=N*lcm(V). The endpoint set is nonempty, T spoils it
strictly, and a least positive strict blocker b exists. It is the least
positive q with every endpoint norm strictly below 1/N; it is not assumed
to make the phases integral.

For a component [L,R] and any q spoiling both endpoints, the two bad arcs
containing L and R are unique because N>=4. If their integer centers agree,
strict containment gives q(R-L)<2/N. If the centers differ, ordered centers
j<k imply
L<(j+1/N)/q and R>(k-1/N)/q>=(j+1-1/N)/q.
Consequently q(R-L)>(N-2)/N, and the component contains a closed q-good
band. These are strict inequalities: attained strictly bad endpoints cannot
sit on either boundary of an open bad arc.

At q=b every component obeys one of these alternatives. There are finitely
many, so if all are short their attained maximum W satisfies bW<2/N.
Otherwise one is long and bW>(N-2)/N. Since 2/N<=(N-2)/N for N>=4,
the alternatives are disjoint and exclude every equality or intermediate
value. In the low case no component can cross between two bad arcs, so
all of S is b-bad and the b-extension fails. Singleton components fit the
short alternative, including the case W=0.

In the high case fix a component of maximum width W. For each q>=b its
width is strictly greater than 2/(N*q). A connected closed interval this
wide cannot be contained in the union of disjoint open q-bad arcs: if it
were, connectedness would place it in one arc, whose length is too small.
It therefore contains a q-good point. For each 1<=q<b, minimality of b
supplies a q-good old endpoint, with equality accepted as good. Thus the
three displayed fixed-set assertions are equivalent. The quantifier is
`for every positive q, there exists a possibly q-dependent witness`;
no common time for all q is supplied. One widest component works as the
search region for all q>=b, not necessarily as a single common witness.

## Uniform equivalence and canonical scope

The forward argument from unrestricted positive-integer LRC is correct.
For an old set of N-2 moving speeds, every fresh q gives N-1 moving speeds
and therefore margin 1/N. Repeated q adds no condition, and the assumed
old-good nonemptiness already suffices. The fixed-set theorem forces the
high case. If a=max(V), each old component lies inside one a-good band,
so W<=(N-2)/(N*a). With (N-2)/N positive, bW>(N-2)/N then forces b>a.
The bound is closed on W and strict on b; no division by a possibly zero
width is needed.

Conversely, assume a positive-integer failure and choose a least failing
moving count n. The checked one- and two-moving-speed cases give n>=3,
hence N=n+1>=4. Delete the minimum speed a. The remaining V has N-2
positive distinct speeds, and count minimality supplies its stronger
1/(N-1) witness. Thus its S and endpoint set at 1/N are nonempty.
Original failure makes a strictly bad at every old endpoint, so b<=a.
Every member of V is greater than a, whereas U requires b>max(V), a
contradiction. Deleting the minimum is essential to this inequality chain;
this proof does not delete the maximum or require minimum speed sum.

The reduction first takes a positive-integer failure via the global
`conjecture_iff_positiveIntegerConjecture`, then minimizes that integer
moving count. It asserts no preservation of the count of a specified real
counterexample. Together with the existing small cases, U quantified over
all canonical old counts and sets is therefore equivalent to unrestricted
integer LRC, and hence to the canonical real statement via the existing
global equivalence. For a single V the review asserts no converse from
b>max(V) alone. The uniform quantifier cannot be discarded.

In a hypothetical count-and-sum minimum deleting the maximum instead gives
b=p; since that p-extension fails, the fixed-set dichotomy gives pW<2/N.
This is consistent with the earlier covered-row bound and provides no blocker
below p. Rephrasing the unrestricted problem as U or uniform exclusion of
the low case does not establish either statement.

## Independently derived low and boundary fixtures

At N=4, V=(1,2,4) has exactly
[5/16,3/8] and [5/8,11/16] as its old-good components. Intersecting the
1-, 2-, and 4-good bands gives these directly. The maximum width is 1/16.
Frequencies 1 and 2 are not strict blockers (they are old speeds); frequency
3 spoils all four endpoints, with norms 1/16 and 1/8 and their reflections.
Thus b=3 and bW=3/16<1/2: this is a positive-width low case, and adding
speed 3 produces no witness at threshold 1/4.

At N=4, V=(1,2,3) has exactly the singleton components {1/4} and {3/4}.
For q=1,2,3 their norms are respectively 1/4,1/2,1/4; these are good,
including equality for q=1,3. Frequency 4 spoils both, so b=4 and W=0.
The b-extension is empty. Both fixtures have three old speeds instead of
the canonical N-2=2, so neither refutes U or LRC. They verify why arbitrary
old cardinality and retained singletons matter in the fixed-set theorem.

The two equality cutoffs cannot be attained with both endpoints strictly
bad. In one bad arc, the maximum possible endpoint separation 2/(N*q)
requires its two boundary points, which are good. Between consecutive bad
arcs, their nearest possible endpoint separation (N-2)/(N*q) is attained
only at the intervening closed good-band boundaries, also good. More
formally the strict endpoint inequalities already proved the two strict
width alternatives; this excludes equality for all real endpoints, not only
for the rational controls below. At N=4 the cutoffs coincide, and the same
argument still applies.

## Supplied controls and period shortcut

The supplied three-fixture checker recomputes all closed components, tests
every positive q before the claimed b, and verifies full witness intervals.
It does not merely check that the listed b is a blocker. Its full-witness
search is over the b good bands against the fixed old components and remains
a bounded verification of the stated fixtures.

For N=4,V=(2,5), endpoint 1/4 forces a strict blocker to be divisible by 4.
The value 4 fails at endpoint 1/8, while 8 spoils all eight listed endpoints.
Thus b=8 is established without a search inference. Endpoint phases at 3/20
and 7/20 have norm 1/5, not zero, and their least common denominator with
the other endpoints is 40. This refutes the unconditional endpoint-integrality
shortcut. The period used here is a common denominator for joint endpoint
phases; it should not be confused with a proved least period of the Boolean
blocking predicate. The full witness 3/10 has norms (2/5,1/2,2/5).

For the third fixture, all 56 phases at b=903 are nonintegral and strictly
bad, while bW=387/196 is high. Its associated p=58 row is covered, but
903>58; coverage is not being confused with endpoint blocking or original
failure. The second fixture's integral phases at b=T=2940 are only one
pattern, not evidence for a general integrality theorem.

## Exact replay

The following standard-library block executes the immutable JSON checker
in memory, then verifies the derived low/singleton cases with complete
phase-band intersections. It tests only the five fixed old sets discussed
above and elementary exact boundary controls; no tuple discovery runs.

```python
from pathlib import Path
from hashlib import sha256
from fractions import Fraction as F
from itertools import product
import json

note=Path('research/astra-first-blocker-width-audit.md')
assert sha256(note.read_bytes()).hexdigest()== \
    '79638a6e7ff3454ac0efd8bcd7a13b73a42a22a989b4f25d7c8a52f0e16646df'
p=Path('research/astra-first-blocker-controls.json')
assert sha256(p.read_bytes()).hexdigest()== \
    '2aa24ca0d4c50b21bb5c15ab3d12cc0105306d15f65a5248adc70cc50bd5a67e'
data=json.loads(p.read_text())
code='\n'.join(data['checker']['code_lines'])+'\n'
assert sha256(code.encode()).hexdigest()== \
    '35f1521292973a9413e975dd86cc13ffb1f7b44767b55f9d3d2f4a41c2a0a8ef'
exec(compile(code,'frozen-first-blocker-checker','exec'),{})

def norm(x):return min(x%1,(-x)%1)
def good(V,N,t):return all(norm(v*t)>=F(1,N) for v in V)
def components(V,N):
    bands=[[(F(N*j+1,N*v),F(N*(j+1)-1,N*v)) for j in range(v)] for v in V]
    out=[]
    for choice in product(*bands):
        L=max(x for x,y in choice);R=min(y for x,y in choice)
        if L<=R:out.append((L,R))
    assert len(out)==len(set(out))
    return sorted(out)

low_cases=[((1,2,4),[(F(5,16),F(3,8)),(F(5,8),F(11,16))],3,F(1,16)),
           ((1,2,3),[(F(1,4),F(1,4)),(F(3,4),F(3,4))],4,F(0))]
for V,expected,b,W in low_cases:
    S=components(V,4)
    assert S==expected and max(R-L for L,R in S)==W
    E={z for I in S for z in I}
    assert all(norm(b*e)<F(1,4) for e in E)
    assert all(any(norm(q*e)>=F(1,4) for e in E) for q in range(1,b))
    assert b*W<F(2,4)
    assert not components(tuple(sorted(set(V+(b,)))),4)
    assert all(components(tuple(sorted(set(V+(q,)))),4) for q in range(1,b))
    # Negative-period copies keep the same endpoint strictness.
    assert all(norm(b*(e-1))<F(1,4) for e in E)

# Exact equality controls at the same-arc and consecutive-arc limits.
equality_controls=0
for N,q,j in product((4,7),(1,3),(-2,0,1)):
    delta=F(1,N)
    L,R=(F(j)-delta)/q,(F(j)+delta)/q
    assert q*(R-L)==2*delta
    assert norm(q*L)==norm(q*R)==delta
    L,R=(F(j)+delta)/q,(F(j+1)-delta)/q
    assert q*(R-L)==1-2*delta
    assert norm(q*L)==norm(q*R)==delta
    equality_controls+=2
assert equality_controls==24

# Independently check the false-integrality witness and covered reference.
assert good((2,5,8),4,F(3,10))
assert [norm(v*F(3,10)) for v in (2,5,8)]==[F(2,5),F(1,2),F(2,5)]
assert norm(8*F(3,20))==norm(8*F(7,20))==F(1,5)
V=(7,21,28,35,49);N=7;p=58
assert not any(good(V,N,F(r,N*p)) for r in range(N*p) if r%N)
third=data['fixtures'][2]
assert all(F(x)!=0 for x in third['endpoint_phases_mod_one'])
assert third['b']==903>p
print(dict(low_fixed_sets=2,singleton_components=2,equality_controls=equality_controls,
           signed_low_controls='passed',false_period_shortcut='passed',
           covered_reference_p58='passed',discovery_searches=0))
```

Executed from the repository root with:

```bash
PYTHONDONTWRITEBYTECODE=1 python3 - <<'REVIEW_REPLAY'
from pathlib import Path
import re
p=Path('research/astra-first-blocker-width-review.md')
blocks=re.findall(r'^```python\n(.*?)^```[ \t]*$',p.read_text(),re.M|re.S)
assert len(blocks)==1
exec(compile(blocks[0],str(p),'exec'))
REVIEW_REPLAY
```

Observed outcome: exit 0. The supplied checker reproduced b=8,2940,903,
the corresponding periods 40,2940,20580, products 4/5,45,387/196, and all
three specified full-witness intervals and points. The additional verifier
returned exactly:

```text
{'low_fixed_sets': 2, 'singleton_components': 2, 'equality_controls': 24, 'signed_low_controls': 'passed', 'false_period_shortcut': 'passed', 'covered_reference_p58': 'passed', 'discovery_searches': 0}
```

The current canonical bridge and small bases were also checked directly at
their source declarations: `oneMovingRunner` has threshold 1/2,
`twoMovingSpeeds` has threshold 1/3 for arbitrary nonzero real speeds, and
`conjecture_iff_positiveIntegerConjecture` is the global proposition
equivalence. Current source hashes match
`e4933da3551792130eebf1ede4701bff3296f59eb696dfb7b6276e16d940d699`
for `SmallDimensions.lean` and
`98d7c878eef7e4a3b7f7c504c882cf35191c1343816a59d731193ac8a207ed26`
for `BHKRealReduction.lean`. No new Lean compilation was run.

**Disposition: accepted, with no required correction.** The fixed-set
dichotomy and extension equivalence, uniform U equivalence, and false
endpoint-integrality shortcut are sound at their exact stated scopes.
Neither the finite controls nor the equivalence establishes U. The uniform
exclusion of the low case at canonical old counts remains precisely an
unrestricted LRC bottleneck; the arbitrary-count low fixtures do not refute
that uniform canonical statement. This audit must be retained as a reduction
and scope check, not promoted as a completed proof or induction step.

All review commands stopped. No discovery, author/source edit, shared-state
mutation, Git operation, Lean build, or cache work was performed.
