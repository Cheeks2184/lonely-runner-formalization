# Minimal sum: finite endpoint descent and Euclidean reuse obstruction

Task `/root/endpoint_label_audit-minimal-height`, requested in-session
Astra/xhigh, 2026-09-05. Frozen main source:
`98cdd1c1ab8d6c0cbac73bff3f0385a1f9970dbf`.
The worker read the current project configuration, workflow, policy, state,
and relevant canonical, induction, and insertion source; workflow validation
passed. Only this evidence file is owned. No Lean, dependency/cache, shared
state, Git, or publication changes were made by the worker.

**Disposition: a manuscript theorem selecting old endpoints from supplied
replacement witnesses under complete original largest-row coverage; a precise
finite descent invariant for a hypothetical count-and-sum minimum; and an
exact all-choice obstruction to raw Euclidean witness reuse.** The existence
of a decreasing replacement satisfying the descent criterion remains
unproved. No unrestricted LRC proof, disproof, or new kernel declaration is
claimed. Independent review is required.

## 1. Exact minimum and honest induction premises

`LonelyRunner.conjecture_iff_positiveIntegerConjecture` in
`BHKRealReduction.lean` is a global, all-dimensions equivalence. If the
canonical conjecture fails, first use that equivalence to obtain failure of
`PositiveIntegerConjecture`. Then choose the smallest moving count `n`
admitting a positive injective integer failure, and among those failures
choose a tuple with smallest natural sum of speeds.

This does not claim that a prescribed real counterexample can be converted
to integers while preserving its moving count. The minimum is chosen only
after entering the positive-integer formulation. The stationary runner stays
at speed zero throughout this audit.

Write the selected set of moving speeds as

```text
A=V union {p},       p=max(A),       |A|=n,       N=n+1,
|V|=n-1=N-2,        H(A)=sum_(a in A) a.
```

The stationary runner contributes one to `N` and zero to `H`. Positivity
and injectivity are retained as properties of finite sets of speeds. The
existing one- and two-moving-runner theorems imply `n>=3`, hence `N>=4`.
Set

```text
delta=1/N,
G_N(W)={t in R : ||w*t||>=delta for every w in W}.
```

The selected failure means `G_N(A)=empty`, with a **closed** good threshold.
Count minimality supplies a witness at `1/(m+1)` for every positive
injective integer set of size `m<n`, regardless of its sum. Sum minimality
supplies a witness at `1/N` for every size-`n` such set with smaller sum.
These are distinct premises.

For any `0<q<p`, put `B_q=V union {q}`. If `q notin V`, then `|B_q|=n`
and `H(B_q)=H(A)-p+q<H(A)`; its honest guarantee is `G_N(B_q) nonempty`.
If `q in V`, deduplication gives `B_q=V`, with `n-1` moving speeds and
guaranteed threshold `1/n=1/(N-1)`. One cannot apply the injective
same-count theorem to a tuple containing the repeated speed. The stronger
smaller-count guarantee also implies nonemptiness at the weaker threshold
`1/N`, but the two witness sets need not be equal.

That witness supply alone is routine minimality, not the new endpoint
selector proved next.

## 2. A fixed finite set of old endpoints

This section is an unconditional geometric implication. Let `N>=3` be an
integer, let `V` be any nonempty finite set of positive integer speeds, and
let `p` be a positive integer reference pivot speed. Assume the **actual p-row** at denominator `N`
is completely covered by `V`. Allowing `p in V` does not add any spoiling
candidate, since that coordinate is good on its own row. No original
failure or count minimality is a premise here, and the lemma itself needs
no prescribed cardinality or speed ordering.

The row candidates are `r/(N*p)`, with integer `r` not divisible by `N`.
Complete coverage is equivalent to the old-good set missing every one of
these candidate times. Reduction modulo `N*p` and integer-speed periodicity
give this equivalence directly. Consecutive candidate times have gaps of
length `1/(N*p)` or `2/(N*p)`, the latter across the omitted multiples of
`N`. Every connected old-good component is therefore a closed interval
strictly inside one such gap. In particular

```text
length(I)<2/(N*p)             for every component I of G_N(V).       (1)
```

Components consisting of a single point are allowed. Complete row coverage
does not say that every gap is p-bad: old-good components in the shorter
good gaps may supply full witnesses for `V union {p}`.

Let `E=E_N(V)` be the finite set of endpoints of all components in one
period `[0,1]`, with duplicate endpoints identified. Neither 0 nor 1 is old
good because `V` is nonempty and consists of integers. Equivalently,

```text
E = union over a in V of
    { r/(N*a) : 0<=r<N*a, r=1 or -1 modulo N,
                 and ||v*r/(N*a)||>=1/N for every v in V }.          (2)
```

To see (2), an endpoint is attained by at least one old phase-band boundary.
Conversely, an old-good point at such a boundary has that owner's strict
bad interval immediately on one side, so it cannot be interior to an old
good component. At an isolated component both sides may be obstructed.
Thus this is one fixed finite set of genuine old pivot candidates, not a
new speed family or a replacement-dependent endpoint inventory.

## 3. Endpoint selector with its full quantitative range

**Theorem.** Under the complete-row hypotheses of section 2, let `q` be a
positive integer satisfying

```text
2*q <= (N-2)*p.                                                  (3)
```

If an old-good component `I=[L,R]` contains any q-good point, then at least
one of `L,R` is q-good. Consequently

```text
G_N(V union {q}) is nonempty
  iff there exists e in E_N(V) with ||q*e||>=1/N.                   (4)
```

**Proof.** A closed connected q-good band has length

```text
(N-2)/(N*q) >= 2/(N*p) > R-L,                                  (5)
```

using (3) and (1). Suppose some point of `I` is q-good but both endpoints
are q-bad. The connected q-good band containing that point must then lie
strictly between `L` and `R`: if it extended past either endpoint, that
endpoint would itself be q-good. Its length would be less than `R-L`,
contradicting (5). Thus an endpoint is q-good. If `L=R`, the conclusion is
immediate. This proves the pointwise component assertion. Integer translation
normalizes any component to the chosen period without changing norms;
conversely an endpoint in (4) is already old-good. This proves (4). QED.

Equality in (3) is allowed. The proof compares a closed q-good band with a
strictly shorter old component; it never replaces `>=1/N` by `>1/N`.
The argument applies to negative times by the same periodic normalization.

For `N>=4`, every integer `0<q<=p` satisfies (3). For `N>4` the theorem
also reaches some `q>p`; those values may be useful for endpoint selection
but do not supply a smaller-sum descent. The positive selector (4) requires
an existing witness, supplied independently or by justified induction. It
does not construct an unconditional witness from row coverage alone.

This strengthens the initial version derived by the worker under original
failure: the orchestrator pointed out that complete p-row coverage alone
already gives (1), including when original full witnesses exist. The
manuscript records the stronger exact contract and rederives its proof.

## 4. The finite descent invariant supplied by sum minimality

Return to the hypothetical minimum in section 1. Original failure implies
complete coverage of its p-row, so the theorem applies. Deleting `p` and
using count minimality gives `G_(N-1)(V) nonempty`, hence `E_N(V)` is
nonempty. Failure also gives

```text
||p*e||<1/N             for every e in E_N(V).                     (6)
```

**Descent criterion.** If there is a positive integer `q<p` such that

```text
||q*e||<1/N             for every e in the fixed set E_N(V),       (7)
```

then `B_q=V union {q}` is a smaller counterexample.

Indeed, the contrapositive of (4) gives `G_N(B_q)=empty`. In the fresh case
this is a canonical failure at the same moving count, with the strictly
decreased natural sum `H(A)-p+q`. In the duplicate case it is failure even
at the weaker threshold `1/N`; therefore it also fails at its own larger
canonical threshold `1/(N-1)`. Its moving count is smaller, and its sum
is `H(A)-p<H(A)`. In both cases positivity and the stationary runner are
preserved, the moving count never increases, and **the natural sum strictly
decreases**. These are the explicit invariant and measure for this descent.

Consequently the selected minimum must satisfy the nontrivial common-endpoint
condition

```text
for every integer 0<q<p, some e in the same E_N(V) has ||q*e||>=1/N,
whereas every e in E_N(V) has ||p*e||<1/N.                         (8)
```

The finite set is fixed before choosing `q`. The content beyond ordinary
replacement-witness existence is the proved reduction to old endpoints,
using complete p-row coverage and the q-band width. It is not a theorem
that some decreasing `q` satisfies (7).

One can express (8) arithmetically. Let `T=N*lcm(V)`. Every endpoint in
(2) has denominator dividing `T`, so `T*e` is integral. Thus the set of
positive integers spoiling every endpoint is nonempty and periodic modulo
`T`. Under the minimum's hypotheses, `p` is its **least positive element**.
The trivial blocker `T` supplies no descent: it can be much larger than
`p`. Producing a blocker below `p`, or otherwise ruling out this minimum
pattern, is exactly the missing step of this chosen route.

## 5. Every elementary Euclidean choice can defeat raw witness reuse

Consider the elementary decreasing operation `p -> p-a`, for `a in V`.
It preserves zero as the stationary speed and decreases the natural sum
after deduplication. Smaller-count or smaller-sum induction honestly
supplies a witness for the new set. The unsupported inference is that some
choice of `a`, and some witness at that new set's canonical threshold,
can simply be reused for the original tuple, or followed inside its entire
old-good component to an original witness.

The following fixed positive example defeats **all** such choices and all
of their guaranteed witness times:

```text
N=7, n=6, V=(1,4,5,6,7), p=11, H(A)=34.
```

This tuple is not a counterexample to LRC or a hypothetical minimum: it has
ordinary full witnesses. Its role is only to refute the proposed generic
witness-transfer inference.

For `a=1`, the new speed is `q=10`, which is fresh. The set
`B=(1,4,5,6,7,10)` has six distinct moving speeds, sum 33, and canonical
threshold `1/7`. Its complete witness set in one period is

```text
G_7(B) = [5/14,13/35] union [22/49,13/28]
       union [15/28,27/49] union [22/35,9/14].
```

Each interval is an entire component of `G_7(V)`, strictly contained in a
single open 11-bad interval. Therefore every same-count smaller-sum witness
fails for the original tuple, even if one may move anywhere inside its
whole old-good component. The smaller tuple even has stronger `1/6`
witnesses; mere availability of some extra margin does not fix this control.

For the other choices the reduced speed duplicates an old speed:

```text
a=4,5,6,7      gives q=7,6,5,4 respectively.
```

After deduplication every resulting set is `V`, with five moving speeds
and guaranteed threshold `1/6`. Its **entire** canonical witness set is

```text
G_6(V) = [13/36,11/30] union [19/42,11/24]
       union [13/24,23/42] union [19/30,23/36].
```

Each lies inside one of the same four trapped components. Thus all five
Euclidean choices fail under raw reuse of every witness at the correctly
counted new tuple's canonical threshold, including movement inside the
full old-good component at denominator 7.

The original full witness set is instead

```text
G_7(A) = [15/49,13/42] union [29/42,34/49].
```

These are the other two old-good components. Speed 10 is strictly bad on
both, and neither meets `G_6(V)`. The endpoint sets selected by the original
speed 11 and the fresh reduced speed 10 are therefore disjoint here.
This control does not contradict (4): the reduced witnesses do select old
endpoints, but those endpoints remain spoiled by the original speed.

Using arbitrary `1/7` witnesses after duplicate reduction would be a
different claim: `G_7(V)` includes the original witness components. The
all-choice obstruction specifically concerns the guaranteed canonical
`1/6` witness set for the five-speed reduced tuple, not an assertion that
the weaker set is unavailable or empty.

The quantitative range of the endpoint selector cannot simply be dropped.
For the same fixed `V` and covered reference `p=11`, take
`q=7*lcm(V)=2940`. Every old endpoint has integral q-phase, so all are
q-bad. Nevertheless

```text
w=5/14+1/(2*q)=2101/5880
```

is old-good and has q-phase equal to an integer plus `1/2`. It is a full
witness for `V union {2940}` in the interior of the old component
`[5/14,13/35]`. Here `2*q=5880>55=(N-2)*p`. This is an exact counterexample
to endpoint selection without any upper-frequency restriction, supplied
independently by the orchestrator and verified below. It does not establish
that the particular bound (3) is optimal.

## 6. Exact fixed controls

The single standard-library block below checks the fixed all-choice
obstruction, the selector at its equality range, isolated components,
negative periods, and actual endpoint grids. It enumerates phase bands
only for the displayed fixed tuples, not a speed domain. The arbitrary-count
singleton fixture tests the geometric theorem only; its denominator must
not be presented as the canonical count of its enlarged tuple.

```python
from fractions import Fraction as F
from math import floor, gcd, lcm

def norm(x):return min(x%1,(-x)%1)
def good(V,N,t):return all(norm(v*t)>=F(1,N) for v in V)
def components(V,N):
    out=[(F(0),F(1))]
    for a in V:
        bands=[(F(N*k+1,N*a),F(N*(k+1)-1,N*a)) for k in range(a)]
        out=[(max(x,l),min(y,r)) for x,y in out for l,r in bands
             if max(x,l)<=min(y,r)]
    return sorted(set(out))
def safe(N,A,a):
    return [r for r in range(N*a) if r%N and good(A,N,F(r,N*a))]

N=7;V=(1,4,5,6,7);p=11;A=V+(p,)
S=components(V,N)
trapped=[(F(5,14),F(13,35)),(F(22,49),F(13,28)),
         (F(15,28),F(27,49)),(F(22,35),F(9,14))]
full=[(F(15,49),F(13,42)),(F(29,42),F(34,49))]
strong=[(F(13,36),F(11,30)),(F(19,42),F(11,24)),
        (F(13,24),F(23,42)),(F(19,30),F(23,36))]
assert len(A)==N-1 and gcd(*A)==1 and sum(A)==34
assert S==[full[0]]+trapped+[full[1]] and safe(N,A,p)==[]
assert components(A,N)==full and components(V,N-1)==strong
assert components(V+(10,),N)==trapped
assert components(V+(10,),N-1)==strong
arcs=[(F(27,77),F(29,77)),(F(34,77),F(36,77)),
      (F(41,77),F(43,77)),(F(48,77),F(50,77))]
for (x,y),(u,v) in zip(trapped,arcs):assert u<x<y<v
choices=[]
for a in V:
    q=p-a;B=tuple(sorted(set(V+(q,))))
    assert all(b>0 for b in B) and len(B)<=len(A) and sum(B)<sum(A)
    guaranteed_N=len(B)+1
    W=components(B,guaranteed_N)
    assert W==(trapped if a==1 else strong)
    assert all(any(l<=x<=y<=r for l,r in trapped) for x,y in W)
    assert all(not good(A,N,(x+y)/2) for x,y in W)
    choices.append((a,q,len(B),sum(B),guaranteed_N))
assert choices==[(1,10,6,33,7),(4,7,5,23,6),(5,6,5,23,6),
                 (6,5,5,23,6),(7,4,5,23,6)]

E={z for I in S for z in I}
Ep={e for e in E if norm(p*e)>=F(1,N)}
Eq={e for e in E if norm(10*e)>=F(1,N)}
assert Ep=={z for I in full for z in I}
assert Eq=={z for I in trapped for z in I} and not Ep&Eq
assert len(E)==12 and all((N*lcm(*V)*e).denominator==1 for e in E)

# The third fixture is an arbitrary-cardinality geometric control:
# at N=4, old V=(1,2,3) has exactly two isolated old-good points.
fixtures=[(7,V,11,(1,10,11)),
          (7,tuple(2*a for a in V),22,(55,)),
          (4,(1,2,3),4,(2,4)),
          (3,(1,2),3,(1,))]
component_checks=0
for N,V,p,qs in fixtures:
    assert safe(N,V+(p,),p)==[]
    S=components(V,N);E={z for I in S for z in I}
    literal={F(r,N*a) for a in V for r in range(N*a)
             if r%N in (1,N-1) and good(V,N,F(r,N*a))}
    assert E==literal
    for q in qs:
        assert q>0 and 2*q<=(N-2)*p
        assert bool(components(tuple(sorted(set(V+(q,)))),N)) == \
               any(norm(q*e)>=F(1,N) for e in E)
        for L,R in S:
            assert R-L<F(2,N*p)
            for shift in (0,-1):
                l,r=L+shift,R+shift
                meets=any(max(l,F(N*k+1,N*q))<=min(r,F(N*(k+1)-1,N*q))
                          for k in range(-q,q))
                if meets:assert norm(q*l)>=F(1,N) or norm(q*r)>=F(1,N)
                component_checks+=1
assert 2*55==(7-2)*22 and 2*4==(4-2)*4
assert components((1,2,3),4)==[(F(1,4),F(1,4)),(F(3,4),F(3,4))]
assert components((1,2),3)==[(F(1,3),F(1,3)),(F(2,3),F(2,3))]
N=7;V=(1,4,5,6,7);p=11;q=N*lcm(*V)
E={z for I in components(V,N) for z in I}
w=F(5,14)+F(1,2*q)
assert q==2940 and w==F(2101,5880) and 2*q>(N-2)*p
assert all((q*e).denominator==1 for e in E)
assert good(V+(q,),N,w) and norm(q*w)==F(1,2)
assert F(5,14)<w<F(13,35)
print({'euclidean_choices':choices,'original_endpoints':12,
       'pointwise_component_checks':component_checks,
       'equality_singleton_negative_period_controls':'passed',
       'omitted_frequency_bound_countercontrol':'passed'})
```

The complete block was executed directly from this note and passed. It
reported all five Euclidean choices, twelve fixed original endpoints, and
72 signed component checks across the fixed selector fixtures. Equality,
singleton, negative-period, literal endpoint-grid, and omitted-frequency-bound
controls passed. Final workflow structural validation and owned-file
whitespace checks passed. No owned search or verifier remained running at
freeze. The orchestrator's larger independent fixed-fixture replay is
separate evidence, not counted as this worker's verification.

## 7. Status and precise remaining gap

The decreasing operation and natural measure are fully specified. Complete
row coverage gives a proved finite endpoint test in the quantitative range
(3), and minimality forces the first-blocker invariant (8). The missing
existence statement is a lower positive blocking speed satisfying (7), or
some separately justified exchange which produces a smaller failure. None
is supplied by the already proved insertion, divisor, or nearest-grid
contracts.

In particular same-count sum induction gives only the closed margin `1/N`.
Substituting `alpha=1/N` in the existing nearest-grid coordinate hypothesis
`1/N<=alpha-d/(2*N*p)` fails for a positive transported coordinate `d`.
It is therefore invalid to treat sum induction as a stronger-margin witness
or as an automatic application of that transport theorem. Duplicate reduction
does give `1/(N-1)`, but the all-choice control proves that this additional
margin alone does not authorize raw original-time reuse. Existing fast,
divisor, and dense insertion conditions remain additional explicit
hypotheses; height minimality has not proved any of them automatically.

This bounded branch stops at the endpoint selector, descent criterion, and
all-choice control. It does not promote the first-blocker reformulation as
an unrestricted supply theorem, and does not assume a witness for the
original moving count and original sum. The full canonical completion gate
is unchanged.

Inspected mathematical source bindings, SHA-256:

```text
0c3328e975bee236ff66862d3a5cadeb58fbc7c804fa953e53701ba466b9d788  LonelyRunner/Formulations.lean
98d7c878eef7e4a3b7f7c504c882cf35191c1343816a59d731193ac8a207ed26  LonelyRunner/BHKRealReduction.lean
e4933da3551792130eebf1ede4701bff3296f59eb696dfb7b6276e16d940d699  LonelyRunner/SmallDimensions.lean
7b315fe9ea7f8639eb45e376365f1c3795c52e2f93e608db578390c1083a5753  LonelyRunner/IntegerInduction.lean
ca5f8c1eb511a5be14d3eb50c887421ac7efa96426beb5135c0693a76b4f497b  LonelyRunner/NearestPivotGrid.lean
```
