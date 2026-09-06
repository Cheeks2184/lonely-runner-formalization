# Uniform colour-critical cover screen

Status: bounded manuscript result, not a Lean theorem or an LRC resolution.
Task: `/root/uniform_colour_critical_cover`, requested Astra/xhigh, using the
existing `/root/uniform_seed_coupling` session. Task source checkpoint:
`970295eb9ebe88498b3faa9831bac775548a7b43`; the readback while writing was
`073a7a15b063c55c7683c51d9294b2362a0969ab`, after concurrent root publication.
Only this report is worker-owned. The two approaches below exhaust this task.

The first gives a necessary arithmetic connectivity condition for a hypothetical
counterexample with deletion seeds. The second shows that several proposed
topological and quantitative substitutes for integer periodicity coexist with
a full cover. It is an abstract circle-cover construction, not an integer-speed
counterexample.

## Setting and exact source bindings

Let `n=N-1 >= 3`, and let `v_1,...,v_n` be distinct positive integers. Work on
the common time circle `T=R/Z`, with circular distance `d_T`. Put

```text
delta = 1/N,       gamma = 1/n,
A(i,k) = {t : d_T(t,k/v_i) < 1/(N v_i)},  0 <= k < v_i,
U_i = union_k A(i,k),       U = union_i U_i,
H = T \ U = {t : ||v_i t|| >= delta for every i},
S_p = {s : ||v_i s|| >= gamma for every i != p}.
```

All bad arcs are open. Thus their missing endpoints remain eligible full
closed-margin witnesses. In particular, strict overlap inequalities below
must not be replaced by weak inequalities.

The hypothesis for Approach 1 is `H=empty` and `S_p` nonempty for every p.
The weaker seed hypothesis `intersection_(i!=p) (T\U_i)` nonempty for every p
actually suffices. Under `H=empty`, each such seed lies in `U_p` and no other
`U_i`: it is a private point of colour p. This elementary observation is
background supplied and checked by root; it is not claimed as the new result.

The original arc graph has one vertex for each `A(i,k)`, coloured by i, and
an edge exactly when two open arcs intersect. Distinct same-colour arcs are
disjoint. A finite union of connected arcs is connected exactly when its
intersection graph is connected: graph paths connect their unions, whereas
distinct graph components give disjoint relatively open unions separating the
total union.

Prior contracts used or checked:

| Source | SHA-256 | Relevant scope |
| --- | --- | --- |
| `research/astra-uniform-endpoint-euler-screen.md` | `00f37303fc266b1843964293500a1be112e3a9d8439d3dcad65a662d60be1b25` | Original periodic arc graph, strict arithmetic overlap, reflection/disconnection |
| `research/astra-uniform-endpoint-euler-review.md` | `b3dd8f9923bd77814cff6c8171ca1a930df5058cbf123cdfe165ec9591102aec` | Independent acceptance of that manuscript's stated scope |
| `research/astra-uniform-seed-coupling.md` | `b52f92b8dca3de5b0ba9f41c24c2dc6bd83a27329a035d40a1273a0401f215ea` | Local relabelling limitations |
| `research/astra-uniform-seed-coupling-review.md` | `537c008719aa858c9d97ab46acb5b5cd197b873a78d0266aeae6c05950c7c0bb` | A local label cycle does not refute a globally coupled claim |

The coincident-center reduction below is proved directly. It does not depend
on the longer maximal-containment pruning manuscript under separate review.

## Approach 1: an arithmetic graph on labels must be connected

Define a simple graph C on the n speed labels by

```text
{i,j} is an edge of C  iff  v_i + v_j > N gcd(v_i,v_j).
```

**Proposition.** If `H=empty` and every deletion has a weak delta-good seed,
then C is connected. Consequently the proposition applies under all the
own-gamma seed hypotheses `S_p != empty`.

**Proof.** At each rational center appearing among the primitive arcs, retain
only the arc of largest radius, equivalently the one of smallest speed. Speeds
are distinct, so this choice is unique. Every removed arc is contained in the
retained arc with the same center. Hence the retained arcs still have union U.
Call their intersection graph G*.

Every colour p occurs in G*. Indeed, choose a private seed s of p and an arc
`A(p,k)` containing s. If this arc were removed in favour of a different
colour's arc with the same center, that retained arc would also contain s,
contradicting privacy. The argument needs no strict gamma-delta slack.

Since `U=T`, G* is connected. Its distinct vertices have distinct centers.
Consider any edge, with speeds a,b and centers k/a,l/b. The edge has different
colours because same-colour primitive arcs are disjoint. Set

```text
d = min_(z in Z) |b k - a l - z a b|.
```

The integer d is positive because the centers are distinct modulo one. It
is a multiple of `g=gcd(a,b)`, so `d>=g`. Circular center distance is `d/(ab)`.
The triangle inequality applied to an intersection point of the two open
arcs gives

```text
g/(ab) <= d/(ab) < 1/(Na) + 1/(Nb) = (a+b)/(Nab).
```

Therefore `a+b>Ng`, which is an edge of C. Project a G* path between any two
represented colours to its sequence of colours. This is a walk in C; every
colour is represented, so C is connected. QED.

Root's simplification to merging coincident centers alone is adopted here;
removing all contained arcs is unnecessary for the proposition.

The cut form is useful and precise: for every nonempty proper label subset A,
there are `i in A`, `j not in A` such that

```text
(v_i + v_j) / gcd(v_i,v_j) > N.                 (1)
```

Contrapositively, given every deletion's weak seed, a cut with

```text
v_i + v_j <= N gcd(v_i,v_j)  for every cross pair i,j
```

supplies `H != empty`. Equality is included in this obstruction because bad
arcs are open. This is a small arithmetic necessary condition on a putative
least-count counterexample, using only n label vertices rather than all
`sum_i v_i` primitive arcs.

Its limitation is substantive. No contradiction between (1), actual distinct
integer speeds, and all deletion seeds has been proved. No independence from
all existing arithmetic or divisor restrictions is claimed. C can be connected
in positive cases: for `N=4`, speeds `(1,4,5)` give `C=K_3`, while `t=1/3` is
a full gamma witness and hence supplies H and all deletion seeds. This direct
rational example only separates the necessary condition from a witness test;
it is not an additional runner-count milestone or a computational experiment.

Root supplied a further redundancy check. If N is prime, `gcd(v_1,...,v_n)=1`,
and some speed is divisible by N, then C is already connected without using
any seeds. To prove this, a nonedge a,b has `a/g+b/g<=N`, where `g=gcd(a,b)`.
If the N-adic valuations of a and b differed, one of these positive reduced
quotients would be divisible by N and hence at least N, while the other is
at least one, a contradiction. Thus all cross-component pairs, were C
disconnected, would have equal N-adic valuations. A vertex in another
component then shows that any two vertices in the same component have equal
valuations as well. All speeds would have the same valuation. The presence
of one multiple of N would make every speed divisible by N, contradicting
primitivity. Consequently the earlier primitive and denominator-N obstruction
profile already implies this graph condition for prime N. Independence from
the full earlier profile for composite N remains unestablished here; no
composite-N classification is attempted.

### Reduction does not commute with deleting a colour

For the original graph, the previous reflection argument gives: if a deletion
retains an even speed, its weak witness implies its graph is disconnected.
Thus, with at least two even speeds, every single-colour deletion disconnects
the original graph under the present hypotheses. With exactly one even speed,
this conclusion is asserted only for deletion of an odd speed. All-odd speeds
already have the full witness `t=1/2`.

These deletion assertions must not be transferred to G* without further
proof. If a deleted colour owned the widest arc at a coincident center, a
narrower arc of a surviving colour must be restored when the remaining union
is reconstructed. Deleting vertices from the already reduced full graph can
therefore lose pieces of the surviving union. One must retain the original
graph or redo the coincident-center reduction after each deletion. The next
construction illustrates this failure exactly.

## Approach 2: colour-critical cover with common fixed points and seed slack

This tests a particular proposed abstraction-level contradiction: can a finite
reflection-invariant circle cover with same-colour disjoint arcs, all-colour
cliques at 0 and 1/2, and every colour essential even at its own stronger margin
exist? The answer is yes. The construction also explains which integer-speed
information that abstraction discards.

For any `n>=4`, take `N=n+1` and put

```text
K = 2(n-1),       R = 3/(4K),       epsilon = 1/(32K),
lambda = gamma/delta = (n+1)/n,     x = 1/(20K).
```

Place a main open arc of radius R at each `c_j=j/K`, `0<=j<K`, and give it
colour

```text
p(j) = 1 + min(j,K-j).
```

The cyclic colour sequence is `1,2,...,n-1,n,n-1,...,2`. In addition, for
every colour put an open arc of radius epsilon at 0 and another at 1/2.
Within each colour discard a small arc if it shares a center with that
colour's main arc. Define its abstract gamma-bad arcs by multiplying each
remaining radius by lambda. These are definitions of this abstract model;
no integer speed is attached to a colour.

**Coverage and symmetry.** The main centers have spacing `1/K`, and
`R>1/(2K)`, so the main open arcs cover T strictly. Their intersection graph
is exactly `C_K`: neighbouring centers overlap because `2R>1/K`, and all
nonneighbours are at least `2/K>2R` apart. Each colour is preserved by
`t -> -t`. Every colour covers both 0 and 1/2, giving a clique of n colours
at each of these fixed points in the original graph.

**Same-colour disjointness.** An interior colour has two main centers whose
circular separation is at least `2/K`. A main center and a distinct small
center of the same colour are at least `1/K` apart. Since `n>=4`,

```text
lambda R <= 15/(16K),       lambda epsilon <= 5/(128K),
2 lambda R <= 15/(8K) < 2/K,
lambda (R+epsilon) <= 125/(128K) < 1/K.
```

The two small centers are separated by 1/2, also more than their diameter.
Thus the remaining arcs of each colour are pairwise disjoint even after
inflation, and in particular at the base threshold.

**Strong private seeds.** For an interior colour `2<=p<=n-1`, choose
`s_p=(p-1)/K`. This is its own main center. Every different main center is
at distance at least `1/K>lambda R`. Both small fixed-point centers are at
distance at least `1/K>lambda epsilon`. Hence s_p is outside every other
colour's inflated arcs and inside its own base arc.

For colour 1 choose `s_1=x`; for colour n choose `s_n=1/2-x`. At either seed,
the distance to the nearest other main center is at least

```text
(1-1/20)/K = 19/(20K) > 15/(16K) >= lambda R.
```

The nearest other-colour small arcs are centered at the nearby fixed point,
and their distance is

```text
x = 1/(20K) > 5/(128K) >= lambda epsilon.
```

The opposite fixed point is still farther away. Each seed lies in its own
main arc because `x<R`. Thus every colour has a strict deletion seed outside
all other inflated arcs, with exactly the same threshold ratio
`lambda=gamma/delta` used in the integer problem.

**Deletion disconnects the original graph.** Every s_p lies strictly between
0 and 1/2. After deleting colour p, both s_p and `1-s_p` lie outside the
remaining union, by the seed inequalities and reflection symmetry. Every
other colour still covers both 0 and 1/2, through its small or main arcs.
Removing the two seed points separates 0 from 1/2 on the circle. The remaining
union is therefore disconnected, and so is its intersection graph. This
holds for every p, despite full coverage before deletion.

The reduction warning is visible here. Merging coincident centers across
colours discards every small arc in favour of the main arc at 0 or 1/2, leaving
just the main `C_K`. Deleting colour 1 from this already reduced graph leaves
a connected path. In the original graph, surviving small arcs at 0 form a
separate component after that deletion: they cannot meet the nearest main
arcs, since `R+epsilon=25/(32K)<1/K`. Redoing the reduction restores them.

**Exact scope of the obstruction.** This construction proves the consistency
of full coverage, colour-preserving reflection, common-origin and half-period
cliques, same-colour disjointness, every colour deletion disconnecting the
original graph, and strict deletion seeds under the prescribed radius
inflation. Therefore those properties alone do not contradict a cover.

It is not realizable by one positive integer speed per colour. In the integer
problem, a colour consists of the entire regular orbit `k/v_i`, with exactly
`v_i` centers, all radii equal to `1/(Nv_i)`, and total bad-set measure `2/N`.
Here a colour uses two different radius scales and an incomplete, nonuniform
center pattern, and generally has a different total measure. The actual
width/frequency/complete-orbit relation has been omitted. The construction
retains the common origin; it is not presented as a shifted-speed tuple, a
zero-start LRC counterexample, or a Q counterexample.

## Remaining obligation and verification limit

The new actual-integer consequence is the connectedness of C, equivalently
the strict reduced pair-sum condition (1) across every label cut. It uses
zero-start arithmetic through positive gcd-multiple separation after merging
coincident centers. It does not use the quantitative gamma-delta seed margin.

The remaining supply obligation is to rule out an actual integer tuple with
`H=empty` and all deletion seeds, including the connected label graph case,
by exploiting additional coupled arithmetic. A graph or winding proof based
only on the abstract properties listed above cannot do this. Treating colour
deletion as deletion in a previously reduced graph is also invalid.

All arguments for Approach 1 assume full absence of a delta witness. Q failure
allows witnesses outside all protected seed unions and does not imply that
assumption. Neither the arithmetic cut corollary nor the existence of H by
itself proves the protected-seed assertion Q.

The arithmetic connectivity proposition has a plausible finite-graph Lean
contract, conditional on deletion witness supply, with strict intersection
and exact gcd separation as its substantive ingredients. No implementation
or cache restoration is requested by this report. The abstract construction
is a scope control for potential proof contracts, not an implementation
priority. No independence from previously accepted arithmetic restrictions,
new arbitrary-N supply theorem, or formal canonical advance is claimed.

Verification consists of the displayed exact arguments and source-hash
readback. No mathematical program, finite enumeration, Lean check, or external
literature inference was used for these two approaches. The workflow validator
passed at startup and after the continuation readback; it verifies workflow
structure only. Independent mathematical review of this report remains
required before promotion. This bounded branch ends with these two results;
the unrestricted project goal remains open.
