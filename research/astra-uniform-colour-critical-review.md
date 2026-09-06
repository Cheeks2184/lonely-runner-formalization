# Independent review of the colour-critical cover screen

Date: 2026-09-06. Task `/root/uniform_colour_critical_review`, executed by
`/root/uniform_screen_review`; requested Astra/xhigh. Runtime model, effort
and usage are not independently exposed. Root supplied checkpoint
`073a7a15b063c55c7683c51d9294b2362a0969ab`. Only this review file is owned.

**Accepted at manuscript scope.** The stated conditional arithmetic graph
proposition, prime redundancy argument, abstract cover and reduction warning
are sound. The deletion-seed hypothesis in the arithmetic proposition can
in fact be removed by the intrinsic surviving-centre observation below.
The abstract example has no integer-speed realization of the required form.
Neither result supplies the unresolved unrestricted witness theorem or Q.

The complete starting manuscript was read. Its actual hash and all four
declared input bindings matched the following readback:

```text
84b7f417a73dd8e580300390a3e1081f61904ad1860215487f03f7c1a51e578f  research/astra-uniform-colour-critical-cover.md
00f37303fc266b1843964293500a1be112e3a9d8439d3dcad65a662d60be1b25  research/astra-uniform-endpoint-euler-screen.md
b3dd8f9923bd77814cff6c8171ca1a930df5058cbf123cdfe165ec9591102aec  research/astra-uniform-endpoint-euler-review.md
b52f92b8dca3de5b0ba9f41c24c2dc6bd83a27329a035d40a1273a0401f215ea  research/astra-uniform-seed-coupling.md
537c008719aa858c9d97ab46acb5b5cd197b873a78d0266aeae6c05950c7c0bb  research/astra-uniform-seed-coupling-review.md
```

The reviewer did not author that starting manuscript. The unconditional
survival observation and more precise description of the abstract colour
measures were supplied during this review. They are distinguished from the
author's original claims rather than attributed to an earlier source.

**Arithmetic graph, closed boundary and seed scope.** Here `n=N-1>=3`,
the speeds are positive distinct integers, and the primitive bad arcs have
radius `1/(Nv_i)`. Their endpoints are excluded. Same-colour arcs are
disjoint because their centre spacing is `1/v_i>2/(Nv_i)`. Every arc is
connected, and finiteness makes connectedness of its union equivalent to
connectedness of the intersection graph, including arcs crossing the period
cut.

Keeping the unique widest arc at each coincident centre preserves the bad
union exactly. Under the originally stated hypotheses, a deletion weak seed
is a private point of its deleted colour: `H=empty` puts it in that colour's
open bad set, and its closed weak inequalities exclude every other colour.
An arc containing this point cannot be discarded for another colour's arc
at the same centre. Thus the manuscript's representation argument works even
when a seed is on another colour's boundary; no strict seed slack is needed.

For an edge of the reduced graph, the distinct centres `k/a,l/b` have
circular distance `d/(ab)`, where
`d=min_z |bk-al-zab|` is a positive integer multiple of `gcd(a,b)`.
An intersection point of the two open arcs gives the strict bound

```text
gcd(a,b)/(ab) <= d/(ab) < (a+b)/(Nab).
```

Consequently each reduced graph edge projects to an edge of the label graph
`C`, defined by `a+b>N gcd(a,b)`. A path projects to a label walk; repeated
labels along the walk cause no problem. Coverage makes the reduced graph
connected, so representation of every label gives connected C. Equality
`a+b=N gcd(a,b)` is correctly a nonedge. The cut obstruction therefore uses
the weak opposite inequality and supplies a closed-margin witness.

There is a simpler representation argument specific to complete integer
grids. For any speed `v>1`, its centre `1/v` appears in another speed's grid
exactly when that speed is an integer multiple of v. Hence v itself is the
smallest speed representing that centre and retains its arc. If speed 1
occurs, it retains the widest arc at centre 0. Every colour therefore survives
coincident-only merging without any deletion seed. The same graph proof gives

```text
H=empty => C connected,
C disconnected => H nonempty.
```

This does not claim that every colour has a private point, nor that every
colour survives subsequent maximal-containment pruning. It is a bounded
strengthening of the reviewed proposition, not a missing justification in
its original conditional proof.

For prime N, a nonedge implies `a/g+b/g<=N`. Unequal N-adic valuations would
make one reduced quotient at least N and the other at least one. Thus every
cross-component pair in a disconnected C has equal valuation. A vertex in
another component then forces equal valuations within each component too.
Primitivity and the presence of a multiple of N contradict that conclusion.
The stated prime redundancy follows; no corresponding composite-N
independence or classification is established. The positive control
`N=4, v=(1,4,5), t=1/3` has all three norms `1/3` and all three label edges,
so connectedness alone is not a witness criterion.

**Abstract cover and all stated constants.** The construction requires
`n>=4`, hence `K=2(n-1)>=6` and `lambda=(n+1)/n<=5/4`.
The main centres have spacing `1/K`, with `2R=3/(2K)` strictly between
`1/K` and `2/K`. Thus their open arcs cover the circle and their graph is
exactly `C_K`, including the wraparound edge. The colour assignment is
preserved by reflection, and the added arcs give every colour a presence
at both fixed points 0 and `1/2`.

Same-colour main centres have circular separation at least `2/K`. A main
centre and a distinct fixed-point centre have separation at least `1/K`.
The inequalities

```text
2 lambda R <= 15/(8K) < 2/K,
lambda(R+epsilon) <= 125/(128K) < 1/K
```

are correct and strict at the required comparisons. The two small centres
are half a period apart, exceeding `2 lambda epsilon`. Hence all retained
arcs of a colour remain pairwise disjoint after inflation.

For an interior colour, its proposed seed `(p-1)/K` is a main centre in
`(0,1/2)`, at least `1/K` from every other main centre and either fixed
point. Since `lambda R<=15/(16K)<1/K`, it is strictly outside every other
colour's inflated arcs. At the two endpoint-colour seeds, the nearest
other main centre is at least `19/(20K)>15/(16K)` away; the nearest small
centre is `x=1/(20K)>5/(128K)>=lambda epsilon` away. The opposite fixed
point is farther away for `K>=6`. Both endpoint seeds lie in their own
base main arcs because `x<R`. These are strict inequalities, so the
construction meets the stronger deletion-seed condition with room at the
boundary, for every claimed n. No n=3 claim is needed.

After deleting colour p, both `s_p` and `1-s_p` are absent from the
remaining union, while 0 and `1/2` remain present. Because
`0<s_p<1/2<1-s_p<1`, the two missing points separate the retained fixed
points on the circle. The union, and therefore the original remaining
intersection graph, is disconnected. Full coverage before deletion is
entirely consistent with these facts.

**Why reduction and deletion do not commute.** Coincident-centre merging
of the full abstract family removes the small arcs at both fixed points
and leaves the main cycle. Removing colour 1 from that cycle removes only
the main vertex at 0, leaving a connected path. In the original graph,
other colours' small arcs at 0 survive. They cannot reach the nearest main
arcs because `R+epsilon=25/(32K)<1/K`, and give a separate component.
Reduction after deletion must restore those arcs. This demonstrates the
claimed failure exactly. The integer reflection lemma also remains limited
to deletions retaining an even speed; all-odd speeds already give the full
witness at `1/2`.

The abstract model omits the actual equal-radius, complete integer-frequency
grid relation. More precisely, endpoint colours have one main and one small
arc, and interior colours have two of each. Their base measures, using the
proved same-colour disjointness, are respectively

```text
2R+2epsilon = 25/(16K),
4R+4epsilon = 25/(8K).
```

They are unequal across colours, whereas every actual speed colour has
measure `2/N`. Every abstract colour also uses unequal radii. Centre patterns
should not be called nonuniform for every individual colour: endpoint
colours have the regular two-point grid `{0,1/2}`, and special interior
colours can have regular patterns too. This wording qualification does not
affect nonrealizability or any topological claim. The example is neither a
zero-start nor a shifted-speed LRC counterexample, and says nothing against
methods that retain the omitted arithmetic structure.

**Remaining obligation and verification.** One still needs a uniform
argument excluding an actual integer-speed full bad cover, including the
connected label-graph case, with all the required deletion seeds. No
independence from the complete existing arithmetic profile has been proved.
Q failure need not make H empty, and a full witness need not belong to a
protected seed union. The graph consequence and the abstract obstruction
therefore neither imply Q nor refute it. A possible finite-graph Lean
contract must keep the strict edge test and genuine periodic arc geometry;
it now need not request deletion seeds for label connectivity. No formal
theorem or canonical advance was checked here.

Current project configuration, workflow, policy and focused state were read.
Verification used source readback and the displayed algebraic arguments,
with no mathematical program, enumeration, external literature inference,
Lean invocation or cache restoration. The binding command was:

```sh
sha256sum research/astra-uniform-colour-critical-cover.md research/astra-uniform-endpoint-euler-screen.md research/astra-uniform-endpoint-euler-review.md research/astra-uniform-seed-coupling.md research/astra-uniform-seed-coupling-review.md
```

It exited 0 with the complete output reproduced above. The required
structural check command was:

```sh
python3 -B scripts/validate_workflow.py
```

Its complete output was:

```text
workflow structural validation passed; it cannot certify mathematical validity.
```

It exited 0. This validator result is workflow evidence only. No other file,
shared state, Git data or cache was modified by this review.
