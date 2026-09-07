# Forced arcs admit two disjoint completions

Task `/root/forced_arc_completion`; assignment checkpoint
`4ee48f74a1a2c7cfd163f42f4143c3d961bc2036`. Requested route: Astra/xhigh;
observed model, effort, elapsed time and usage: null. This is a bounded hand
derivation awaiting independent review, not a kernel theorem.

The positive result is an actual completion and exchange: the complete
nonforced alpha-arc family can be partitioned into two classes, each of which
completes the forced arcs to a full circle cover. Choices between the classes
can be made independently between consecutive actual private points. The
resulting exact cost bound still lacks a sharp arithmetic saving. A second
approach gives a stricter determinant window for forced overlaps, including
a speed-1 divisibility restriction, but does not supply that saving or a
missing adjacency. No unrestricted contradiction or failure counterexample
is claimed.

## Setting and the supplied forced-arc bridge

Let V be n distinct positive primitive integer speeds in a hypothetical
ordinary strict failure, chosen by least moving count and then least sum.
Use

`n>=3`, `N=n+1`, `alpha=1/N`, `0<mu=max_t min_{v in V}||vt||<alpha`.

Here `T=R/Z` and `||x||=dist(x,Z)`. Positivity of mu follows by choosing
`0<t<1/(2 max V)`. The complete open alpha-arc family is

`A_(v,k)={t:dist_T(t,k/v)<alpha/v}`, `0<=k<v`.

It covers T. Its reciprocal cost is n: each speed contributes v arcs of
cost `1/v`. Same-speed arcs are disjoint. For each speed v retain the whole
deletion-good set `W_v={t:||wt||>=alpha for every w!=v}`. Least count gives
a deletion witness at `1/n>alpha`, so each W_v is nonempty. On all W_v,
`||vt||<=mu`. Let K_v contain every nearest collision index attained there,
modulo v, including indices from singleton components. Set

`F={A_(v,k):k in K_v}`, `f=cost(F)=sum_v |K_v|/v`.

The basic bridge, being developed separately, is restated only to specify the
input. Each arc A in F has an actual point p_A in W_v inside its closed
mu-core and outside **every other original open alpha-arc**. Conversely, any
original arc that is the only original arc covering some point has that
point in W_v; strict failure puts its collision in K_v. Thus F is exactly
the family of individually indispensable original alpha-arcs. Its members
remain indispensable in every full-grid delta-subcover for `mu<delta<alpha`,
using the same points. This does not license simultaneous deletion of all
other arcs. No control for that already assigned bridge is repeated here.

## First approach: private-point barriers and a complete exchange

Choose one such private point per forced arc. They are distinct, since each
is contained in only its own original arc. There are at least n of them.
List them cyclically as `p_1,...,p_r`, extend by `p_(j+r)=p_j+1`, and let
A_j be the forced arc owning p_j. Its lift through p_j has endpoints L_j,R_j
with

`p_(j-1)<=L_j<p_j<R_j<=p_(j+1)`.                                     (1)

Indeed A_j contains neither neighboring private point, and is a connected
proper circle arc. A **nonforced** original arc contains none of the private
points, so is wholly contained in a unique component

`I_j=(p_j,p_(j+1))` of `T\{p_1,...,p_r}`.                              (2)

This is why the circle can be cut into independent interval problems without
translating any grid or discarding any original arc. Endpoints of such an arc
may equal private points, which the open arc then omits.

Only A_j and A_(j+1) among the forced arcs can meet I_j. If `R_j>L_(j+1)`,
set G_j empty: their tails cover I_j. Otherwise the part outside the forced
union is exactly the closed gap

`G_j=[R_j,L_(j+1)] subset I_j`.                                      (3)

Equality gives a singleton gap and is retained. Every point of G_j is covered
by at least two nonforced original arcs in I_j: it is covered by some original
arc because the complete family covers; a unique such arc would be forced
by the bridge, contrary to the definition of G_j. This argument includes
both closed endpoints, where the neighboring forced open arcs are absent.

Consequently the minimum full-grid cover cost has an exact decomposition.
Let kappa_j be the minimum reciprocal cost of a subfamily of nonforced arcs
in I_j covering the closed G_j, and set kappa_j=0 when the gap is empty.
These minima exist by finiteness and coverage. Every full cover contains F,
and only nonforced arcs in I_j can fill G_j, giving the lower bound
`f+sum_j kappa_j`. Taking F together with a minimizing cover in each cell
attains that bound. Hence

`minimum full-grid cover cost = f + sum_j kappa_j`.                    (3a)

This includes singleton gaps and the cell crossing zero through periodic
lifts. No arc is translated, and there
is no interaction between the completion choices in different cells. This
factorization is an exact completion interface, not a bound on the sum.

### Topology check

The intersection graph of F has edges only between cyclic neighbors in the
private-point order. Its degree is therefore at most two, so its components
are paths (including isolated vertices) or cycles. A cycle component requires
all cyclic adjacencies and all vertices: it covers T and is the whole graph.
Otherwise there are only path components; their closures can touch at omitted
points. There is no triangle. The total length of any three original arcs
is at most `2alpha(1+1/2+1/2)=4alpha<=1`, while three pairwise overlapping
arcs in such a cycle would cover T with a positive overlap and require total
length strictly above one. Thus a cycle has at least four vertices.

This also proves no triple overlap directly from the private-point barriers:
away from the p_j only the two neighboring forced arcs can occur, and at p_j
only its own arc occurs. It agrees with the winding no-triple lemma by taking
delta below alpha and above mu and the three hypothetical norms. The topology
is a structural fact; a cycle has not been excluded under strict failure.

### Interval coloring with exact open endpoints

The following elementary lemma supplies completion. Any finite family of open
real intervals can be colored with two colors so that every point covered at
least twice is covered by both colors. Sort intervals by left endpoint, with
arbitrary order among ties. Keep for each color the largest right endpoint
of its already colored intervals, initially `-infinity`. Assign the next
interval to a color with the smaller maximum, and update that maximum.

The two maxima are, with multiplicities, the two largest right endpoints
seen so far. To check the invariant, write them `s<=t` and let the new right
endpoint be b: if `b<=s` they stay `s,t`; if `s<b<=t` they become `b,t`;
if `b>t` they become `t,b`. These are precisely the new two largest values.
For any real x consider the prefix with left endpoint **strictly below x**.
If at least two intervals contain x, its two largest right endpoints are both
strictly above x. The invariant gives an interval of each color containing
x. Intervals starting at x are not in the prefix, and those ending at x do
not contribute a right endpoint above x. This handles nested intervals,
coincident endpoints, ties, and singleton target gaps. The coloring lemma
and its proof were supplied by root and independently checked here.

Apply the lemma to all nonforced arcs in each I_j, using their actual lifts.
Let `E_j^0,E_j^1` partition that cell's nonforced arcs. Each class covers G_j
whenever it exists. Consequently

`C^epsilon=F union (union_j E_j^epsilon)`, `epsilon=0,1`,                (4)

are full original-grid alpha-covers, with

`C^0 intersection C^1=F`, `C^0 union C^1=the complete original family`.

If F already covers T, this remains true and completion is vacuous; any
partition of the remaining arcs works. More generally, one may select color
0 or 1 separately in **each** I_j and still obtain a full cover. This is an
actual exchange in the original family, preserving every center and label.
No nonforced arc can interfere with a different cell through a private point.

Write `c_j^epsilon=cost(E_j^epsilon)`. Choosing the less costly class separately
in every cell gives an actual cover C_* with exact cost

`cost(C_*)=f+sum_j min(c_j^0,c_j^1)
          =(n+f-B)/2`, `B=sum_j |c_j^0-c_j^1|>=0`.                    (5)

In particular some completion has cost at most `(n+f)/2`. Further deletion
of redundant arcs could improve a cover, but no such saving is assumed.

### The cost gap is real under the stated hypotheses

Let `M(t)=#{v:||vt||<alpha}`, and use normalized length on T. Under strict
failure `M>=1` everywhere and `integral M=2n alpha`. Put

`P=measure{M=1}`, `T_3=integral (M-2)_+`.

The pointwise identity `1_(M=1)=2-M+(M-2)_+` proves

`P=2-2n alpha+T_3=2alpha+T_3`.                                      (6)

Every point with M=1 lies in its unique owner's W_v, hence in one of the
forced closed mu-cores. Those cores have total length `2mu f`; overlaps can
only decrease their union's measure. Therefore

`f >= alpha/mu + T_3/(2mu) > 1`.                                    (7)

This identity and bound were suggested by root and checked here. Complete
family multiplicity is being used in (6), not forced-family multiplicity;
no-triple overlap for F does not imply `T_3=0`.

Thus the coarse bound `(n+f)/2` cannot reach `N/2` through `f<=1`. Every
finite open alpha-cover has cost **strictly greater** than `N/2`: its arc
lengths sum to `2alpha cost`, and an endpoint of any chosen arc must lie in
another open chosen arc, giving an overlap of positive length. The sum of
lengths is consequently strictly above the circle's length one.
In particular (5) forces the exact compatibility condition

`B<f-1`                                                            (8)

for every cell coloring used above, if the hypothetical failure exists.
A lower bound `B>=f-1` from arithmetic would contradict it, but none is
proved. Stating this required saving is not a supply theorem or a replacement
for the old cheap-cover gap. The completion theorem (4)--(5), rather than
the unproved bound on B, is the positive result of this approach.

## Second approach: the actual depth sharpens forced-edge arithmetic

Consider overlapping forced arcs with actual labels a,b. Their centers are
distinct and neither arc contains the other, since each has a private point.
Their union is proper: the total length of any two distinct original arcs is
at most `2alpha(1+1/2)<=3/4<1`. Cut outside their union and choose lifts

`c_a=k/a<c_b=l/b`, `d=c_b-c_a>0`, `D=al-bk=ab d`.

Noncontainment makes both endpoint orders increase. The actual private point
of the a-arc lies within its mu-core and outside the b-arc, so it is at or
left of `c_b-alpha/b`. Similarly the b-private point is at or right of
`c_a+alpha/a`. The same lifted private points are in the cores because the
alpha-arcs themselves are lifted and `mu<alpha`. Hence

`d>=alpha/b-mu/a`, `d>=alpha/a-mu/b`.

Multiplication by ab and the strict overlap condition give the sharper window

`max(alpha a-mu b,alpha b-mu a) <= D < alpha(a+b)`,
so `alpha |a-b| < D < alpha(a+b)`.                                  (9)

The left strictness uses the positive additional term
`(alpha-mu)min(a,b)`. Same-label distinct arcs never overlap. The root-supplied
window is valid including private points on the other arc's boundary.

Let `g=gcd(a,b)`, and put `A=max(a,b)/g`, `B_0=min(a,b)/g`, `h=D/g`.
The integer h is positive. Equation (9) implies the integral restriction

`|A-Nh|<B_0`.                                                       (10)

In particular, if speed 1 is present, its sole arc is forced by nonemptiness
of W_1. A forced arc overlapping it must have label a divisible by N:
`|a-Nh|<1` forces `a=Nh`. Its center is `1/N` or `-1/N` modulo one,
according to the side of the speed-1 arc. There is no assertion that speed 1
is present or that either forced adjacency exists. A path endpoint may be
completed by nonforced arcs, to which the two-private-point bound does not
apply.

There is also a direct owner restriction. If a forced arc of label m is
centered at reduced `r/q`, any other original label v divisible by q obeys,
at that arc's private point with `mt=k+e` and `|e|<=mu`, since v times the
center is an integer,

`alpha <= ||vt|| <= v|e|/m <= v mu/m`.

Thus `v>=alpha m/mu>m`: a forced owner is the smallest original q-divisible
speed, with the displayed stronger separation from every other such speed.
If e=0, no other q-divisible label can exist. This is a consequence of actual
private-point geometry, not a claim that all reduced denominators are present
as original labels. It neither produces a new adjacency nor changes a speed.

No implication from these overlap windows, the owner condition, or the full
coordinate replacement conditions to the saving missing in (8) was derived.
They restrict forced neighbors; they do not control the nonforced completion
costs in all private-point cells. This is where the second approach stops.

## Scope, bindings and checks

The first unresolved step is a sufficient arithmetic saving for the genuine
completions (5), or an alternative admissible exchange using full coordinate
minimality. The present arguments do not establish either. Their completion
part uses the actual full family and private points, while the coloring lemma
is valid for arbitrary real intervals. No literature novelty is asserted.
The stronger minimum-sum conditions remain available inputs, not a claimed
source of an unproved bound. No finite-count ladder, auxiliary numerical
control, disconnected formalization, or LRC completion is proposed.

The minimal-frequency and winding manuscripts and reviews were read at these
unchanged bindings. Their accepted manuscript facts delimit the deletion and
circle topology inputs; their earlier controls were not rerun. The joint-seed
endpoint strengthening was not needed for this bounded derivation.

| Input | SHA-256 |
| --- | --- |
| `research/astra-minimal-frequency-synthesis.md` | `03cf038021f0bc1a2328bb77a02f6ab4fe649f5d3626d7bc368a67cd6c7b0000` |
| `research/astra-minimal-frequency-review.md` | `b26182c2e482e7f83480eab9904779b958eb8b8b753c70bc45c6fabec55b747d` |
| `research/astra-arithmetic-winding-exchange.md` | `6fbd8b96223e1697c33d5e187c25fb9f93707c880f2794892dfa16ca0ab2d6d4` |
| `research/astra-arithmetic-winding-review.md` | `45eca69dd2c8b48a0cec68ca737262b9f1a616b08f85046629c9c4e632618243` |
| `.codex/config.toml` | `28212a53cf42cdc377df1f7dab040732d657e59d7bb97ee78791256d01d4bb2c` |
| `docs/project-workflow.md` | `2b42a133352b6b53ba2106fc73882733f176e04a0deffbb183b4c16eefd9cd67` |
| `research/workflow-policy.json` | `833c397b61d1ffdb994fb115019f6d60d6c1a62ff85f19cdd2c9f8ac3a979c8b` |
| `scripts/validate_workflow.py` | `250a3ce2a080f5835ac4fd2e4b2803568424c777cda5d421f9fe92efd34d5383` |

Current project instructions and focused state were read, confirming the
research/in-progress gate, recorded start authorization, and this sole owned
file. `python3 -B scripts/validate_workflow.py` exited 0 with
`workflow structural validation passed; it cannot certify mathematical validity.`
All mathematics was checked by hand. Source bindings used `sha256sum`.
No mathematical program, numerical search, solver, build, cache operation,
external model, extra agent, Git operation, shared-state edit, memory write,
or other-file edit was performed. Final manuscript readback and frozen hash
are returned separately; independent mathematical review remains required.
