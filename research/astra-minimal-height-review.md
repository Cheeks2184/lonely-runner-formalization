# Independent minimal-count and minimal-sum review

Reviewer `/root/guard_internal_cover_audit`, requested Astra/xhigh, 2026-09-05.
Review base: `b246af6f15198b5aee95ad5c5b4d84f4cc6ffd83`.
Current project configuration, workflow, policy, and state were read;
workflow structural validation passed. Only this review file is owned.

Frozen manuscript: `research/astra-minimal-height-audit.md`, SHA-256
`40e59ba4539eb931a07612e9b972999d3b48006d39ef4760c0e493d08e734325`.
The full manuscript and its single Python block were read. The canonical
formulation, global BHK equivalence, small-dimensional theorems, and the
integer-induction interface were inspected. No Lean, cache, shared-state,
Git, or author-file edits are part of this review.

## General endpoint selector

The theorem is sound for its stated generalized contract: N>=3; a nonempty
finite set of positive integer old speeds V; arbitrary positive reference p
and test frequency q; actual p-row coverage by V; and 2q<=(N-2)p.
It needs no old-speed ordering, prescribed cardinality, original failure,
stronger seed, or exclusion of p from V. The p coordinate is automatically
good at its candidate times, so including it in V cannot supply a spoiler
or invalidate the finite-row/grid-separation equivalence.

Every old-good component is closed and bounded, lying inside a good band of
any positive old speed. Complete p-row coverage separates it from the
signed p-candidate grid. Consecutive grid points are at distance 1/(N*p)
or 2/(N*p), and the attained component endpoints lie strictly inside one
gap. Thus even the longest possible old component has length strictly below
2/(N*p). This conclusion applies to good p-gaps as well as bad p-gaps;
coverage alone supplies no full-tuple failure.

Since N>=3, every q-good component is a closed interval of positive length
(N-2)/(N*q). The numerical bound makes that length at least 2/(N*p).
If an old component contains a q-good point but both of its endpoints are
q-bad, the q-good band containing the point must lie strictly between those
endpoints. Its length would be strictly less than that old component,
contradicting the preceding comparison. A singleton old component instead
satisfies the conclusion immediately. The proof retains equality in the
numerical bound and closed goodness throughout. No nearest-point or stronger
witness premise is being silently used.

Every integer time is old-bad, so any old component can be translated as a
whole into (0,1). Periodicity preserves both the old and q norms. This
justifies the equivalence with the fixed finite endpoint set for arbitrary
real, including negative, witnesses. If the old-good set is empty, both
sides of the existential equivalence are false; the theorem does not assume
otherwise.

The endpoint formula is exact. Each component endpoint is attained by an old
phase-band boundary because there are finitely many old bands. Its numerator
on that actual owner's grid is congruent to +1 or -1 modulo N. Conversely,
an old-good point on such a boundary has a strict old-bad interval immediately
on one side and cannot be interior to an old-good component. Isolated
components are included and repeated endpoint values are identified. Signed
normalization preserves the same original owner grid and its nonzero class;
the finite set is defined before q is selected.

The precise integer frequency cap is floor((N-2)p/2). For N>=4 it includes
all 1<=q<=p. Larger integer frequencies occur when that cap is at least p+1;
N>4 alone makes the real cap larger than p, but, for example, N=5,p=1 has
no additional integer frequency. This is a clarification of the manuscript's
informal "some q>p" remark, not a defect in its explicit inequality or theorem.

## Canonical minimum and descent

The global `LonelyRunner.conjecture_iff_positiveIntegerConjecture` first
provides a positive-integer failure under a hypothetical canonical failure.
Well-order moving counts among such failures, then well-order the natural
speed sums at that count. This requires no count-preserving real-to-integer
BHK theorem. The checked one- and two-moving-speed cases exclude n=1,2,
so the chosen n is at least 3 and N=n+1 is at least 4. Finite positive speed
sets can be enumerated injectively without changing the stationary zero,
common-witness predicate, count, or sum.

For 0<q<p=max(A), replacement B_q=V union {q} is positive and injective
as a set. If q is fresh, it has n moving speeds and natural sum
H(A)-p+q<H(A), so sum minimality supplies only the closed 1/N margin.
If q duplicates an old speed, B_q=V has n-1 moving speeds; count minimality
supplies the stronger canonical margin 1/(N-1), regardless of sum.
Calling this a same-count repeated tuple would violate injectivity; the
manuscript explicitly deduplicates instead.

In the hypothetical minimum, original failure supplies p-row coverage and
spoils every fixed old endpoint. Count minimality after deleting p makes the
old-good set and hence its endpoint set nonempty. All q<p satisfy the
selector bound. If one such q spoils every endpoint, the selector implies
G_N(B_q) is empty. The fresh case is a smaller-sum failure at the same count.
The duplicate case fails even at the weaker 1/N threshold, hence also at
its own stronger 1/(N-1) threshold, giving a smaller-count failure. Its
sum H(A)-p strictly decreases as well. These are the correct failure direction
and well-founded measures; positivity and stationary zero are preserved.

Thus minimality implies that every positive q<p is good at some endpoint
of the same fixed set, whereas p is bad at all of them. Each endpoint
has denominator dividing T=N*lcm(V). Simultaneous endpoint badness is
periodic modulo T, contains positive blocker T, and in the hypothetical
minimum has least positive blocker p. Periodicity supplies no blocker below
p. That existence or a contradiction to the first-blocker pattern is still
missing; neither count nor sum minimality proves it.

The nearest-grid contract cannot import extra margin into this argument:
with alpha=1/N and a positive transported coordinate d, its required
1/N<=alpha-d/(2*N*p) is false. The separate fast/divisor/insertion conditions
also remain explicit premises, not consequences of height minimality.

## All-choice control and outside-range control

The five Euclidean replacements are counted correctly. For old
V=(1,4,5,6,7), p=11, replacing p by 10 yields six moving speeds, sum 33,
and canonical threshold 1/7. Every other p-a duplicates an old speed,
yielding V with five moving speeds, sum 23, and threshold 1/6.
The complete witness inventories in one period place all witnesses at these
respective canonical thresholds in the four entirely 11-bad old components.
Integer periodicity extends this assertion to every real time. It remains
true if the witness can move anywhere within its entire old component.
The two other old components are exactly the original full-witness set.

This is an obstruction to generic raw reuse, not a counterexample to LRC or
to a hypothetical minimum: the original example has full witnesses. In the
duplicate case arbitrary weaker 1/7 witnesses can include those full-good
components. The manuscript limits its all-choice claim to each replacement's
correct canonical witness set and does not deny those weaker witnesses.
The selected original-speed and fresh-q endpoint sets are disjoint in this
example, so the valid endpoint selector does not itself transfer a witness
back to the original tuple.

For q=2940=7*lcm(1,4,5,6,7), every old endpoint has integral q-phase.
Nevertheless 2101/5880=5/14+1/(2q) lies strictly inside an old component,
with q-phase an integer plus 1/2. Hence endpoint selection fails when the
frequency restriction is omitted. The value violates 2q<=(N-2)p and says
nothing about optimality of the stated sufficient bound.

## Replay provenance

The frozen author block independently passed all five Euclidean choices,
twelve fixed endpoints, and 72 signed component checks, including equality,
singletons, negative periods, literal owner grids, and q=2940.

The separately preserved root selector script was read from the completed
`/root/endpoint_label_audit-minimal-height` task record, not inferred from
reported counts. Its SHA-256 is
`ad9c4072faeaa2174d821d6695806d36b4d66b5996ad61d4e981b92b0ccd0348`.
The input corpus JSON is bound to
`dad76cc7ddfc078fbd5eb3528c441cdadd555d68513ad07f9f45fb24089eff2c`,
and its imported endpoint program is the first code block of the endpoint
audit bound to
`667b9bcdebf30333c551badf6e9ef6c861e5e1ca1095808ece5354733745e44d`.
This is a fixed-fixture verification, not discovery over new tuples.

The root suite was independently executed from that exact stored script and
passed: 12 fixtures, 2,188 frequencies, 280,528 signed component tests,
234,648 good-component tests, ten equality contracts, and 188 singleton
components, with the q=2940 control also passing. These are reproduced
finite controls, not a proof of the generalized theorem.

The author and preserved root replays can be reproduced together as follows:

```python
from pathlib import Path
from hashlib import sha256
import json,re

p=Path('research/astra-minimal-height-audit.md')
assert sha256(p.read_bytes()).hexdigest()== \
    '40e59ba4539eb931a07612e9b972999d3b48006d39ef4760c0e493d08e734325'
blocks=re.findall(r'^```python\n(.*?)^```[ \t]*$',p.read_text(),re.M|re.S)
assert len(blocks)==1
exec(compile(blocks[0],str(p),'exec'),{})
state=json.loads(Path('research/workflow-state.json').read_text())
task=next(t for t in state['completed_tasks']
          if t['id']=='/root/endpoint_label_audit-minimal-height')
record=task['root_selector_controls']
assert sha256(record['script'].encode()).hexdigest()== \
    'ad9c4072faeaa2174d821d6695806d36b4d66b5996ad61d4e981b92b0ccd0348'
assert sha256(Path('research/astra-cover-corpus-inventory.json').read_bytes()).hexdigest()== \
    'dad76cc7ddfc078fbd5eb3528c441cdadd555d68513ad07f9f45fb24089eff2c'
assert sha256(Path('research/astra-endpoint-label-audit.md').read_bytes()).hexdigest()== \
    '667b9bcdebf30333c551badf6e9ef6c861e5e1ca1095808ece5354733745e44d'
ns={}
exec(compile(record['script'],'frozen-root-selector','exec'),ns)
assert all(ns['c'][k]==v for k,v in record['counts'].items())
```

A separate fixed-fixture verifier below checks the generalized cases where
p belongs to V and is not its maximum, where the old-good set is empty,
and where components are singletons. It uses exhaustive intersections of
closed old phase bands, separate from the root suite's merge-intersection
implementation. It also independently inventories the original/fresh/duplicate
Euclidean witness sets and verifies signed actual endpoint-owner numerators.
Its only tuples are the stated controls; there is no discovery search.

```python
from fractions import Fraction as F
from itertools import product
from math import floor

def norm(x):return min(x%1,(-x)%1)
def good(V,N,t):return all(norm(v*t)>=F(1,N) for v in V)
def boxes(V,N):
    bands=[[(F(N*j+1,N*a),F(N*(j+1)-1,N*a)) for j in range(a)] for a in V]
    out=[]
    for choice in product(*bands):
        L=max(x for x,y in choice);R=min(y for x,y in choice)
        if L<=R:out.append((L,R))
    assert len(out)==len(set(out))
    return sorted(out)
def covered(V,N,p):
    return not any(good(V,N,F(r,N*p)) for r in range(N*p) if r%N)

base=(1,4,5,6,7);A=base+(11,)
trapped=[(F(5,14),F(13,35)),(F(22,49),F(13,28)),
         (F(15,28),F(27,49)),(F(22,35),F(9,14))]
full=[(F(15,49),F(13,42)),(F(29,42),F(34,49))]
strong=[(F(13,36),F(11,30)),(F(19,42),F(11,24)),
        (F(13,24),F(23,42)),(F(19,30),F(23,36))]
assert boxes(A,7)==full
assert boxes(base+(10,),7)==trapped
assert boxes(base,6)==strong
assert all(any(L<=x<=y<=R for L,R in trapped) for x,y in strong)

fixtures=[(7,tuple(reversed(A)),4,(1,4,9,10)),
          (3,(1,2,3),3,(1,)),
          (3,(1,2),3,(1,)),
          (4,(1,2,3),4,(2,4)),
          (7,tuple(2*a for a in base),22,(55,))]
checks=singletons=endpoint_owner_checks=equality_good=0
for N,V,p,qs in fixtures:
    assert covered(V,N,p)
    S=boxes(V,N)
    E={x for I in S for x in I}
    literal={F(r,N*a) for a in V for r in range(N*a)
             if r%N in (1,N-1) and good(V,N,F(r,N*a))}
    assert E==literal
    singletons+=sum(L==R for L,R in S)
    for e in E:
        owners=[a for a in V if (a*e)%1 in (F(1,N),1-F(1,N))]
        assert owners
        for a in owners:
            for shift in (-1,0,1):
                u=N*a*(e+shift)
                assert u.denominator==1
                r=int(u)%(N*a)
                assert r%N in (1,N-1) and good(V,N,F(r,N*a))
                endpoint_owner_checks+=1
    for q in qs:
        assert 0<q and 2*q<=(N-2)*p
        any_component=False
        for L,R in S:
            assert R-L<F(2,N*p)
            for shift in (-1,0,1):
                l,r=L+shift,R+shift
                meets=any(max(q*l,F(j)+F(1,N))<=min(q*r,F(j+1)-F(1,N))
                          for j in range(floor(q*l)-1,floor(q*r)+2))
                endpoints=norm(q*l)>=F(1,N) or norm(q*r)>=F(1,N)
                assert meets==endpoints
                any_component|=meets
                equality_good+=meets and 2*q==(N-2)*p
                checks+=1
        assert any_component==any(norm(q*e)>=F(1,N) for e in E)
assert fixtures[0][2] in fixtures[0][1] and fixtures[0][2]<max(fixtures[0][1])
assert boxes((1,2,3),3)==[]
assert checks==78 and singletons==4 and equality_good>0
print(dict(additional_fixed_fixtures=len(fixtures),signed_component_checks=checks,
           singleton_components=singletons,signed_endpoint_owner_checks=endpoint_owner_checks,
           equality_good_cases=equality_good,p_in_old_nonmaximum='passed',
           empty_old_good='passed',independent_euclidean_inventories='passed'))
```

For exact reproduction, execute the two Python blocks independently from the
repository root, or use this extraction command:

```bash
PYTHONDONTWRITEBYTECODE=1 python3 - <<'REVIEW_REPLAY'
from pathlib import Path
import re
p=Path('research/astra-minimal-height-review.md')
blocks=re.findall(r'^```python\n(.*?)^```[ \t]*$',p.read_text(),re.M|re.S)
assert len(blocks)==2
for i,code in enumerate(blocks):
    exec(compile(code,f'{p}:block{i+1}','exec'),{})
REVIEW_REPLAY
```

Observed outcomes: the author replay, preserved root script, and separate
additional verifier all exited 0. The additional verifier returned exactly:

```text
{'additional_fixed_fixtures': 5, 'signed_component_checks': 78, 'singleton_components': 4, 'signed_endpoint_owner_checks': 108, 'equality_good_cases': 30, 'p_in_old_nonmaximum': 'passed', 'empty_old_good': 'passed', 'independent_euclidean_inventories': 'passed'}
```

Its equality-good cases ensure the equality tests are not all vacuous. The
p-in-V reference is 4 in old set (1,4,5,6,7,11), with nonempty old-good
components and no reference-maximum assumption. The empty-old-good fixture
uses N=3,V=(1,2,3),p=3; the singleton fixtures retain their arbitrary-count
geometric scope. They are not claims about incorrectly normalized canonical
runner counts.

**Disposition: accepted at the exact manuscript scope.** The generalized
selector, endpoint formula, count/sum minimum, strictly decreasing descent
criterion, all-five Euclidean raw-reuse obstruction, and outside-range control
are sound. The integer-cap clarification above does not change the explicit
selector hypothesis. No Lean implementation or unrestricted theorem is
claimed by this audit.

The positive existence of a lower blocker remains unsupplied. Periodic
simultaneous endpoint badness and a least positive blocker do not prove that
blocker is smaller than p; in the hypothetical minimum p is precisely the
first one. The raw-reuse control concerns an example that already has full
witnesses and cannot refute minimal-counterexample reasoning. The unrestricted
canonical conjecture remains unresolved. All review processes stopped; no
discovery, Lean build, cache restoration, or shared-state mutation ran.
