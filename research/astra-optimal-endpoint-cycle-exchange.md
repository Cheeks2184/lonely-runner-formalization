# Replacement paths and potentials give the same optimality constraint

Task `/root/optimal_endpoint_cycle_exchange`; recorded checkpoint
`1e4a89034bcab452949734f0d0d689d7de5e27f2`. Requested route:
`gpt-6-astra/xhigh`; observed model, effort, elapsed time and usage: null.
Only this manuscript is owned. These bounded hand arguments require
independent review; no kernel theorem or unrestricted resolution is claimed.

The exact replacement-path inequality includes a full minimum-cycle cost
for every additional winding. The finite potential formulation is equivalent
to that optimality constraint, rather than stronger. At the target N/2 it
already has an explicit strictly feasible constant potential on EVERY native
edge. The proposed grid averaging supplies no additional inequality: the
only translations preserving every original speed grid are trivial modulo
one. No arithmetic upper cost or admissible failure transport was found in
these two methods. This is a bounded limitation, not a disproof of a native
uniform implication using additional information.

## Full graph and exact hypotheses

Assume a hypothetical canonical strict failure V of n=N-1>=5 distinct
positive primitive integer speeds, least by moving count and then primitive
sum. Put alpha=1/N, m=max V, and retain the ACTUAL maximum

    0<mu=max_t min_(v in V)||vt||<alpha,
    W_v={t:||ut||>=alpha for every u in V\{v}}.

Every W_v is retained in full, with all attained original collision indices
K_v. The forced family F has an actual private point for every one of its
indexed arcs, outside every other original open alpha-arc. Each original
speed owns at least one member of F by least count.

Use the accepted auxiliary bound

    mu_hat=max(mu,alpha-1/(N*m))<alpha.

The graph G has ALL original indexed alpha-arcs A=(a,k), 0<=k<a, as
vertices. An edge A->B is equivalent both to R_A belonging to the closed
mu_hat-core of B and to B being an original open alpha-cover of R_A.
Here R_A=(k+alpha)/a modulo one. This equivalence follows from native
integer spacing; it is not asserted for the graph at actual mu.

For each edge, choose the compatible lifted target index l and put

    e=b*R_A-l, D=a*l-b*k, r=b-N*D=N*a*e,
    Delta(A,B)=(alpha-e)/b=(a-r)/(N*a*b)>0,
    w(A,B)=1/b.                                           (1)

Delta is the unique positive lifted advance of the target right endpoint;
it is less than 2alpha/b<1. The source-index congruence
r=b*(Nk+1)-Na*l, actual speed labels, and |r|<a are never discarded.

Every simple directed cycle covers the circle, contains all F, and winds
exactly once. Its cost is the sum of w over edges, equivalently one
reciprocal label per indexed vertex. Let C be a minimum-cost cycle and
c=cost(C). The accepted saturation bridge gives

    c=minimum cost of a full original open alpha-subcover.

These graph facts were independently accepted before this manuscript was
frozen. No additional all-zero branch is needed for the present arguments.
Multiple-cover endpoints remain outside all W_v, even when one of their
covering arcs is selected on C.

## First method: exact replacement paths, including additional turns

Let A_i,A_j be vertices of C. Its forward segment from i to j has lifted
endpoint displacement d_ij in [0,1) and cost c_ij, counting target vertices
and including A_j. For i=j choose the empty segment, so d_ii=c_ii=0;
its complementary segment is the whole cycle.

Take ANY finite directed path P in G from A_i to A_j. Its edges may use
unused original arcs, several occurrences of a label, repeated indexed
vertices, and endpoints with several original covers. Sum their actual
positive advances from (1). The initial and final circle endpoints match
those of the C-segment, so

    displacement(P)=d_ij+h, h in Z_(>=0).                 (2)

Splice P with the complementary segment of C, from j back to i. The
resulting directed closed walk has winding h+1 and cost

    cost(P)+c-c_ij.

Decompose a finite closed walk into simple directed cycles by successively
removing the segment between a repeated vertex. Edge costs and advances
add exactly under this decomposition. Every resulting simple cycle has
winding one, by the full original private-point theorem. There are
therefore exactly h+1 cycles, each of cost at least c. Hence

    cost(P)>=c_ij+h*c.                                    (3)

This is the permitted complete-grid path exchange. When h=0, a cheaper
path would improve the selected cycle. When h>0, ignoring the extra term
h*c would lose the winding cost. The old segment with h complete copies
of C attains equality, so the statement includes its correct weak boundary.

The argument treats actual paths, not lists of favorable pairwise residue
conditions. For a translated or newly proposed sequence one must still
prove every original integer index and edge, its ending vertex, and (2).
The accepted single-arc block exchange is the corresponding local special
case of cover optimality; (3) handles longer paths and additional winding
but supplies no path of smaller cost. It also does not lower any speed.

### Why the available grid translations do not supply such a path

A time translation tau carries every center of the original a-grid to
that same grid exactly when a*tau is an integer. Consequently a translation
preserving EACH original speed grid satisfies

    v*tau in Z for every v in V.

Since gcd(V)=1, an integer Bezout combination of the speeds gives
tau in Z. Thus the common translation group is trivial on the circle.
This concerns label-preserving translations; it is not a classification
of every possible accidental graph symmetry.

For an individual path using labels with common divisor g, translations
by multiples of 1/g do preserve its original arc indices. They give paths
with translated endpoints, which are not automatically the two selected
cycle vertices required for an exchange. For example translation by 1/a
changes the index of an adjacent b-arc from l to l+b/a. This is an
original b-grid index only if a divides b. Choosing a different nearest
integer instead changes the edge residual and requires a new cover test.

Accordingly independent cyclic averages within each label's grid cannot
be applied to the cross-label edge inequalities as though they were graph
automorphisms. Whole-cycle translation is unavailable because the cycle
contains F and hence every original label. Reflection preserves the original
arcs but sends right endpoints to left endpoints; it gives the reflected
left-endpoint problem of the same cost, not a second inequality with an
opposite sign. No matched alternative path or positive smaller-sum tuple
is supplied by these actual symmetries.

## Second method: the exact finite potential and its direction

For a real parameter lambda define the edge weight

    L_lambda(A,B)=1/b-lambda*Delta(A,B).                    (4)

For every simple cycle Z,

    sum_Z L_lambda=cost(Z)-lambda,

because its winding is one. Thus all directed closed walks have nonnegative
L_lambda-weight exactly when lambda<=c. For such a lambda there is a
potential p on ALL original indexed vertices satisfying

    p(B)-p(A)<=L_lambda(A,B) for every edge A->B.            (5)

Here is a finite proof without assuming a stronger dual theorem. Add an
auxiliary source with a zero-cost edge to each vertex. Define p(B) as the
minimum weight of a path from that source to B. A closed subwalk has
nonnegative weight, so removing it cannot increase the path weight. The
minimum is therefore attained among finitely many simple paths. Appending
an edge proves (5). Conversely summing (5) around a minimum cycle gives
0<=c-lambda, proving

    a potential (5) exists  iff  lambda<=c.                (6)

For lambda=c, every inequality on C is an equality, since their nonnegative
slacks sum to zero. Summing along its i-to-j segment yields

    p(A_j)-p(A_i)=c_ij-c*d_ij.

Applying (5) to any path P and using (2) now gives exactly (3). Thus this
potential encodes the replacement-path constraint; it has not strengthened
the optimization problem by passing to a dual description.

### At the desired threshold the constant potential already works

The native arithmetic makes the direction especially explicit. Substituting
lambda=N/2 into (1)--(4) gives, for EVERY original edge,

    L_(N/2)(A,B)=(a+r)/(2*a*b)>0.                         (7)

Therefore p=0 is a strictly feasible potential in (5). This needs no
choice of cycle, no averaging, no count bound on its vertices, and no
failure minimality beyond the graph being considered. The strict sign is
the same local native spacing that gives the accepted cost correction.

Equation (6) is a LOWER-cost certificate, so feasibility at N/2 does not
give an upper bound c<N/2. Indeed the proposed potential test at that
threshold already has the explicit certificate (7). Any contradiction
would need additional arithmetic information showing the full native
graph cannot have the required form; potential feasibility alone supplies
no such information. Applying allowed graph symmetries to (5), when they
exist, only averages valid inequalities of the same direction.

No linear-programming computation was used. The finite proof shows exactly
what the potential can and cannot add here; it does not claim an
impossibility theorem for stronger mathematics involving the original V.

## Bounded disposition and the remaining implication

The proved consequence is the winding-sensitive all-path inequality (3)
and its exact potential characterization (5)--(6). The symmetry check
identifies why independent grid translations do not produce new valid
replacement paths. Equation (7) explicitly disposes of treating the
potential at N/2 as a new upper-cost mechanism. These are exact optimization
facts, not a new uniform supply theorem or another unexplained deficit.

Count and all-admissible sum minimality still concern different objects.
A replacement by a fresh positive u<v must be shown alpha-bad on ALL W_v
to transport failure while retaining the other labels. If several labels
change, repairing the original private sets leaves the accepted
multiply-bad-region gap. Path exchanges replace selected arc indices at
fixed V; they do not perform either whole-time speed replacement. Original
endpoint owners are original labels and cannot be relabeled fresh speeds.

The first unresolved step is a graph-compatible arithmetic construction
that actually violates (3), or a positive injective smaller tuple with
proved whole-time failure transport. Neither was obtained. The strict
canonical hypotheses are not refuted, and no actual failure example or
new numerical control is asserted. The older working-width controls retain
their nonnative scope. This bounded branch stops without an additional
method, count ladder or generic research menu.

## Bindings and administrative checks

The native author was frozen at the start and preserved; its independently
accepted review became available during this task. The invoked graph,
spacing and cost contracts were checked against those sources. The earlier
full block-exchange argument was read to distinguish (3) from its local
case; the bound private-repair and minimal-frequency scopes are unchanged.

| Input | SHA-256 |
| --- | --- |
| `research/astra-native-endpoint-cycle-arithmetic.md` | `2c80cee9d9f84f1850bda7aa1fc7798e890d7471b09d89578494cf208997257e` |
| `research/astra-native-endpoint-cycle-arithmetic-review.md` | `098c4da30496a606b3d4b9ff0bd41933d6b55f61f9c5da4f085b5e412a889404` |
| `research/astra-forced-parent-global-cycle.md` | `e265c08b2e0204a8d539e1577ff9907c754287902e6474f043b42be6f5de7bae` |
| `research/astra-forced-parent-global-cycle-review.md` | `eaf481831b74dc031f697481a8f133e12646dc4c7282ff67dfcc9cbb16d566ca` |
| `research/astra-arithmetic-winding-exchange.md` | `6fbd8b96223e1697c33d5e187c25fb9f93707c880f2794892dfa16ca0ab2d6d4` |
| `research/astra-arithmetic-winding-review.md` | `45eca69dd2c8b48a0cec68ca737262b9f1a616b08f85046629c9c4e632618243` |
| `research/astra-minimal-frequency-synthesis.md` | `03cf038021f0bc1a2328bb77a02f6ab4fe649f5d3626d7bc368a67cd6c7b0000` |
| `research/astra-minimal-frequency-review.md` | `b26182c2e482e7f83480eab9904779b958eb8b8b753c70bc45c6fabec55b747d` |
| `research/astra-private-repair-review.md` | `a8aaec8468969723207dc12e9ff2c112a4560c1f51e97f13b43f4e342c849512` |
| `.codex/config.toml` | `28212a53cf42cdc377df1f7dab040732d657e59d7bb97ee78791256d01d4bb2c` |
| `docs/project-workflow.md` | `2b42a133352b6b53ba2106fc73882733f176e04a0deffbb183b4c16eefd9cd67` |
| `research/workflow-policy.json` | `833c397b61d1ffdb994fb115019f6d60d6c1a62ff85f19cdd2c9f8ac3a979c8b` |
| `scripts/validate_workflow.py` | `250a3ce2a080f5835ac4fd2e4b2803568424c777cda5d421f9fe92efd34d5383` |

Current config, workflow, policy and focused state were read. The gate was
research/in_progress with start authorization
`2026-09-05T04:12:25.208107+00:00` and this sole owned path. Initial and
final workflow checks, all thirteen bound hashes, full readback, whitespace
and final-newline checks, and the frozen hash are reported at handoff.
Administrative file checks do not certify the mathematics. No mathematical
program, solver, sweep, build/cache/dependency access, additional agent,
external model, Git/shared-state/memory edit or other-file write was used.
Independent manuscript review remains required.
