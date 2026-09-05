# Primitive endpoint exchange: a global symmetry obstruction

Task `/root/endpoint_label_audit-primitive-exchange`, requested in-session
Astra/xhigh, 2026-09-05. Frozen source:
`e371af814f023bf2761e7b25de980b763347d049`, together with the immutable
endpoint audit SHA-256
`667b9bcdebf30333c551badf6e9ef6c861e5e1ca1095808ece5354733745e44d`.
Current project configuration, workflow, policy, and active state were read;
`python3 scripts/validate_workflow.py` passed. Only this evidence file is
owned. No Lean, dependency/cache, shared state, Git, or publication changes
were made by the worker. Root publication and cleanup proceeded separately.

**Disposition: exact refutation of one sufficient global transport mechanism,
not a proof or refutation of the actual endpoint-label candidate.** The
obstruction applies to translations and reflections preserving the entire
old-good set. It does not rule out a shift chosen for a single endpoint,
an exchange that changes other old-good times, or `C_some`. The full
unrestricted Lonely Runner Conjecture remains unresolved. This new
manuscript requires independent review.

## 1. Fixed target and the genuinely global coverage premise

Keep the notation of the frozen endpoint audit:

```text
N>=4; V consists of N-2 distinct positive integer speeds;
gcd(V)=1; p>max(V); A=V union {p};
G_k(V) = {t in R : ||v*t|| >= 1/k for every v in V}.
```

Assume the original `p`-row is completely covered by `V` at denominator `N`.
Take a supplied `t in G_(N-1)(V)` whose full component `I=[L,R]` in
`G_N(V)` is strictly inside a single open `p`-bad interval. The unresolved
candidate `C_some` says that at least one owner of either endpoint is
noncovered in the **original tuple A at the same denominator N**. Endpoint
owner ties remain allowed in the general target.

The earlier divisor orbit handles old gcd greater than one after primitive
normalization. In the present gcd-one case, a shift `s` preserving every old
phase modulo one must be integral: write 1 as an integer combination of the
old speeds and multiply by `s`. Such a shift also preserves the new integer
speed's phase. That rules out the exact common-period mechanism, not a
pointwise inequality-preserving exchange. The orchestrator independently
identified this boundary during the continuation.

The complete `p`-row premise does have the following global consequence.
Define all actual `p`-grid candidate times on the real line by

```text
T_p = {r/(N*p) : r in Z and N does not divide r}.
```

**Separation lemma.** `PivotCovered(N,A,p)` is equivalent to
`G_N(V) intersect T_p = empty`. Consequently every connected component of
`G_N(V)` lies strictly between consecutive elements of `T_p`.

**Proof.** A time in `T_p` already protects `p`, and all old coordinates are
good there exactly when its numerator is safe against all owners on the
`p`-row. Reduce the integer numerator modulo `N*p` to pass between the
infinite time grid and the original finite residue row. Integer-speed
periodicity preserves every norm and the numerator's nonzero class modulo
`N`. This proves the equivalence. The old-good set is closed, while `T_p`
is a discrete grid with positive spacing. A component disjoint from the
grid cannot cross any of its points, so it lies in one intervening open
gap; its closed endpoints remain strictly inside that gap. QED.

There are two kinds of consecutive-candidate gap:

* Across an omitted multiple of `N`, the gap is a `p`-bad interval of length
  `2/(N*p)`.
* Every other gap has length `1/(N*p)` and consists of `p`-good times.

Thus full row coverage separates **all** old-good components into these
gaps, including components that contain no stronger seed. It does not say
that every old-good component lies in a bad gap. In particular it permits
full witnesses in good gaps away from the entire `p` candidate grid.
No ordinary full-count witness was assumed in deriving this lemma.

The coverage of just the two grid points adjacent to a trapped component is
weaker and automatic: a left endpoint owner strictly spoils the grid point
on the left, and a right owner spoils the point on the right. For example,
if the left grid point is `x`, then
`0<a*(L-x)<2*a/(N*p)<2/N`; since `a*L` has phase `1/N`, `a*x` is strictly
within `1/N` of an integer. The right argument is symmetric. Hence those
two points alone do not use the complete row premise. This observation was
also independently supplied by the orchestrator and is not an additional
exchange theorem.

## 2. The one mechanism attempted

The proposed sufficient mechanism was to use the global candidate-gap
pattern to transport an old endpoint by a circle isometry

```text
F(x) = epsilon*x+s modulo 1,       epsilon in {1,-1},
```

which preserves the entire old-good set. Such a map would allow jumps
between different old-good components while preserving the old inequalities
for every old-good time. It is less restrictive than preserving each old
norm. If it sent one endpoint to a `p`-good point on that owner's original
pivot grid, it would prove the desired owner noncoverage.

The unproved step would have been:

> Complete largest-row coverage and a trapped stronger-seed component force
> such a global old-good-set isometry that makes at least one endpoint good
> for the new speed.

The next section refutes even the weaker conclusion that either transported
endpoint is merely a full good time, without imposing the additional original
endpoint-row requirement. This is a failed **sufficient mechanism**; it was
never equivalent to `C_some`. The finite control tests precisely this step
on one supplied tuple. No new tuple enumeration or broad search was run.

## 3. Exact global obstruction under every actual candidate hypothesis

Use the existing correctly counted primitive example

```text
N=7, V=(1,4,5,6,7), p=11, t=13/36.
```

The old gcd is one, the largest speed is 11, and its original row is covered
at denominator 7. The supplied seed belongs to `G_6(V)`. Its weak component
and containing open new-speed bad interval are

```text
I=[5/14,13/35] strictly inside (27/77,29/77).
```

The unique left and right owners are 6 and 5. Thus every premise of the
actual endpoint candidate holds here. The complete old-good set in one
period is the following disjoint union:

| Component | Exact width |
| --- | --- |
| `[15/49,13/42]` | `1/294` |
| `[5/14,13/35]` | `1/70` |
| `[22/49,13/28]` | `3/196` |
| `[15/28,27/49]` | `3/196` |
| `[22/35,9/14]` | `1/70` |
| `[29/42,34/49]` | `1/294` |

This entire interval inventory, not only the trapped component, determines
the symmetry obstruction. Each width occurs exactly twice and
`1/294<1/70<3/196`. The two shortest components have left endpoints

```text
e0=15/49,       e1=29/42,
e1-e0=113/294,       2*(e1-e0)=113/147 not in Z.
```

**Claim.** The only translations preserving this old-good set modulo one
are integral translations.

**Proof.** A translation preserving a finite union of separated closed
intervals permutes its connected components and preserves their lengths.
It must therefore permute the two shortest components, hence their left
endpoints modulo one. If it fixes either endpoint, its shift is integral.
Otherwise it swaps the two endpoints. The first image forces
`s=e1-e0 mod 1`, and the second forces `2*(e1-e0)=0 mod 1`, contrary to
the displayed value `113/147`. These exhaust the permutations of two
objects, so only integral shifts survive. QED.

The conclusion also applies if “preserves” was intended merely to mean
`F(G_7(V)) subset G_7(V)`. Both sets have the same finite measure. If this
containment were proper, the difference would contain a point of the old
set outside the closed image. Since the old set is the closure of its
interior, some interval of positive length would then also lie outside the
image, contradicting equality of measure. Thus containment implies equality
for this explicit six-interval set. No such statement about arbitrary
non-isometric maps is asserted.

The old-good set is invariant under `x -> -x` because every defining norm
is even. If `x -> s-x` preserves it, composing with this known reflection
shows that translation by `s` preserves it. The preceding claim forces
`s` to be integral. Consequently **all** its circle-isometry symmetries are

```text
x -> x+j   or   x -> -x+j,       j in Z.
```

For integer speed 11 both kinds preserve the new norm as well:
`||11*(epsilon*x+j)||=||11*x||`. The two endpoint new-speed norms are

```text
||11*(5/14)|| = 1/14 < 1/7,
||11*(13/35)|| = 3/35 < 1/7.
```

No global old-good-set-preserving isometry can make either endpoint safe.
Indeed none can move any point of the trapped component to a full witness.
The complete largest row really is covered, so this is not the earlier
dropped-largest-row near-control. It refutes the exact global-isometry
supply step in section 2 with every original candidate hypothesis intact.

## 4. Why this is not a counterexample to the endpoint candidate

The actual covered-label set of the original tuple is `{1,4,5,11}`. The
left endpoint owner 6 is noncovered. A concrete full witness on its original
row is

```text
w=29/42 = 5/14 + 1/3,
r=29 in R(7,6),       r mod 7=1.
```

The original-speed norms at `w` are
`(13/42,5/21,19/42,1/7,1/6,17/42)`. This time gives the exact conclusion
of `C_some`. Its shift preserves the 6-phase because `6/3=2` is integral,
while changing other old phases and norms.

The same shift fails to preserve the entire old-good set: the right
endpoint `z=13/35` is old-good, whereas

```text
z+1/3=74/105,       ||7*(z+1/3)||=1/15<1/7.
```

Thus a shift selected for one endpoint succeeds exactly where the global
symmetry requirement fails. This distinction prevents the obstruction from
being misreported as a failure of arbitrary endpoint translations or of
`C_some`.

More generally an endpoint-preserving shift by `j/a` fixes its numerator
class modulo `N`: `N*a*(x+j/a)=N*a*x+N*j`. A left endpoint stays in the
`+1` class and a right endpoint in the `-1` class. Demanding a witness in
one of these fixed classes is stronger than unrestricted noncoverage of
that individual pivot row, whose safe numerator may have another nonzero
class. Any future orbit argument must justify that additional restriction;
the actual endpoint candidate does not provide it automatically.

## 5. Exact reproduction

The following standard-library block inventories all boundary points and
open cells for the **one fixed tuple**, including possible isolated good
points. It does not search a speed domain. It then verifies full original
pivot-row coverage, the seed and owners, every component width, the symmetry
marker obstruction, and the successful pointwise shift.

```python
from fractions import Fraction as F
from math import floor, gcd

def norm(x):
    return min(x%1,(-x)%1)

def good(V,N,t):
    return all(norm(v*t)>=F(1,N) for v in V)

def cells(V,N):
    points={F(0),F(1)}
    for v in V:
        for k in range(v):
            points.update((F(N*k+1,N*v),F(N*(k+1)-1,N*v)))
    xs=sorted(points)
    pieces=[(x,x) for x in xs if good(V,N,x)]
    for x,y in zip(xs,xs[1:]):
        if good(V,N,(x+y)/2):
            assert good(V,N,x) and good(V,N,y)
            pieces.append((x,y))
    result=[]
    for x,y in sorted(pieces):
        if result and x<=result[-1][1]:
            result[-1]=(result[-1][0],max(y,result[-1][1]))
        else:
            result.append((x,y))
    return result

def safe(N,A,a):
    return [r for r in range(N*a) if r%N and good(A,N,F(r,N*a))]

N=7;V=(1,4,5,6,7);p=11;A=V+(p,);t=F(13,36)
assert len(set(A))==len(A)==N-1 and gcd(*V)==1 and p>max(V)
assert safe(N,A,p)==[]
assert {a for a in A if not safe(N,A,a)}=={1,4,5,11}
assert good(V,N-1,t)
left={a:(F(floor(a*t))+F(1,N))/a for a in V}
right={a:(F(floor(a*t))+1-F(1,N))/a for a in V}
L=max(left.values());R=min(right.values())
assert (L,R)==(F(5,14),F(13,35))
assert [a for a in V if left[a]==L]==[6]
assert [a for a in V if right[a]==R]==[5]
assert F(27,77)<L<t<R<F(29,77)
assert good(V,N,L) and good(V,N,R)
assert norm(p*L)==F(1,14) and norm(p*R)==F(3,35)

S=cells(V,N)
expected=[(F(15,49),F(13,42)),(F(5,14),F(13,35)),
          (F(22,49),F(13,28)),(F(15,28),F(27,49)),
          (F(22,35),F(9,14)),(F(29,42),F(34,49))]
assert S==expected
widths=[y-x for x,y in S]
assert widths==[F(1,294),F(1,70),F(3,196),F(3,196),F(1,70),F(1,294)]
assert F(1,294)<F(1,70)<F(3,196)
E={x for x,y in S if y-x==min(widths)}
assert E=={F(15,49),F(29,42)}
e0,e1=sorted(E);d=e1-e0
assert d==F(113,294) and 2*d==F(113,147)
assert (2*d).denominator!=1
# Every possible translation preserving E sends e0 to one of these two
# points. The manuscript proves that this finite necessary test is complete.
possible={(z-e0)%1 for z in E}
assert {s for s in possible if {(z+s)%1 for z in E}==E}=={F(0)}
assert sorted((1-y,1-x) for x,y in S)==S

# Check the global p-grid separation for all six old components.
P=sorted(F(r,N*p) for r in range(N*p+1) if r%N)
gaps=[]
for x,y in S:
    j=next(j for j in range(len(P)-1) if P[j]<x<=y<P[j+1])
    gap=(P[j],P[j+1]);gaps.append(gap)
    assert gap[1]-gap[0] in (F(1,N*p),F(2,N*p))
assert [y-x for x,y in gaps]==[F(1,77),F(2,77),F(2,77),
                             F(2,77),F(2,77),F(1,77)]
assert cells(A,N)==[S[0],S[-1]]

w=L+F(1,3)
assert w==F(29,42) and 0<29<N*6 and 29%N==1
assert good(A,N,w)
assert [norm(a*w) for a in A]==[F(13,42),F(5,21),F(19,42),
                                F(1,7),F(1,6),F(17,42)]
assert norm(7*(R+F(1,3)))==F(1,15) and not good(V,N,R+F(1,3))
print({'old_components':len(S),'covered_labels':[1,4,5,11],
       'three_widths':sorted(set(widths)),
       'shortest_separation':d,'twice_separation':2*d,
       'global_isometry_obstruction':'passed',
       'actual_endpoint_candidate_control':'passed'})
```

The block was executed directly from this manuscript and passed. It returned
six old components, covered labels `[1,4,5,11]`, the three displayed widths,
and the exact marker separation and double separation. Both the global
isometry obstruction and the actual endpoint-candidate positive control
passed. Final workflow structural validation and an owned-file whitespace
check passed. No owned process remained running at freeze.

## 6. Remaining gap and branch stop

The separation lemma uses complete coverage of the original largest row and
is valid beyond this example. The additional supply of a global old-good-set
isometry is false even under every stated candidate hypothesis. No attempt
was made to turn this refuted supply step into a Lean theorem.

This branch stops at that exact obstruction. It does not assert that all
global exchanges fail, or that the primitive endpoint candidate is false.
The unresolved step is still to construct a safe point on an actual endpoint
owner's original row, allowing the other old phases to change while proving
their required inequalities at the selected point, or to refute that
candidate with all of its premises. Complete row coverage supplies the
global gap separation, but no such pointwise exchange is proved here.
Invoking a full original-count LRC witness to supply it would be circular.

Inspected mathematical source bindings, SHA-256:

```text
667b9bcdebf30333c551badf6e9ef6c861e5e1ca1095808ece5354733745e44d  research/astra-endpoint-label-audit.md
6267ff6fb165ba01d5f982fd4931342c3e594d1ca1ca765d0aa41f0813598446  research/astra-dense-pivot-induction.md
151b0cdb8c701610e2c2e2e0508e11a9a630ae93f7c57e1d5010227b7187887b  research/astra-dense-pivot-review.md
362da5ab923f22e900ae7ac821dd4cf4aab91dfe70889987bc9e5a05d19c276a  LonelyRunner/PivotResidues.lean
49131a7f9690042d1b16cbc876417f9d9ce1b53cc6565f87b6d1b53c4e3340cd  LonelyRunner/Prompt99Scaling.lean
```
