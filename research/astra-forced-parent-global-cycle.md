# A full endpoint cycle retains strict depth but does not supply cheap cost

Task `/root/forced_parent_global_cycle`; assigned checkpoint
`7147fd8d9d12bfb3599f931a117f8e27d84f24af`. Requested route:
`gpt-6-astra/xhigh`. Observed model, effort, elapsed time and usage: null.
Only this manuscript is owned. These hand derivations require independent
review; they are not kernel theorems or an unrestricted LRC resolution.

There is a global completion of the endpoint relation if every original
closed-mu cover is retained. Every simple directed cycle of this finite
relation winds exactly once and contains every forced indexed alpha-arc.
Its signed residuals give a strict-depth cost bound, with a compulsory
contribution from the all-zero maximum-parent transitions. Multiple covers
remain outside the deletion-good domain; their contribution is kept without
an unjustified contraction. No upper cost bound or fresh blocker closes the
resulting inequality. A separate local strengthening excludes ALL other
original maximum arcs from a larger parent, including nonforced ones.

## Hypotheses

Let V be a hypothetical canonical strict failure of n>=5 distinct positive
primitive integer speeds, least by moving count and then primitive sum. Put

    alpha=1/(n+1)<=1/6, m=max V, s=max(V\{m}),
    0<mu=max_(t in R/Z) min_(v in V)||vt||<alpha,
    epsilon=alpha-mu>0,
    W_v={t:||ut||>=alpha for every u in V\{v}},
    Q_v=max(V\{v}).

Minimum count supplies nonempty W_v. The accepted contraction on their
ENTIRE closed domains is

    ||vt||<=mu-v*epsilon/Q_v  for every t in W_v.             (1)

In particular private points cannot be global maximizers. The complete
original open arcs and their closed cores are

    A_(v,k)={t:dist_T(t,k/v)<alpha/v},
    H_(v,k)={t:dist_T(t,k/v)<=mu/v},       0<=k<v.

All H_(v,k) together cover the circle. Let K_v be every collision index
attained on W_v, and F={A_(v,k):k in K_v}. Each member of F has an actual
private point outside EVERY other original open alpha-arc. Conversely every
uniquely covering original alpha-arc belongs to F. All indices and actual
speed labels are retained, even when their centers reduce as fractions.

Assume every attained maximum arc is zero-only, with the exact parent data
from the bound predecessor. The assertions below use full mu-coverage,
actual private points, (1), and those all-zero data. They do not use sum
minimality to manufacture another inequality. Its available consequence
still concerns ALL admissible positive distinct n-label replacements with
smaller sum: gcd normalization would give a smaller primitive failure, so
each such replacement must have a closed alpha-witness.

## First approach: sharpen the actual parent incidence

Reflect one maximum arc so its larger parent is on the left. In compatible
real lifts write

    a>b>0, a+b=m, l+r=k,
    D=ar-bl=ak-ml,
    alpha*m<=D<=mu*(m+b)<alpha*(m+b),
    A=(L,R), L=(k-alpha)/m, R=(k+alpha)/m,
    I=(P,Q), P=(l-alpha)/a, Q=(l+alpha)/a.

The accepted endpoint domains are L in W_a, R in W_b and Q in W_m;
I and the right parent J are forced actual arcs. The predecessor proves

    mP=k-Y,  Y=(D+m*alpha)/a in (2alpha,5alpha).

Set h=(D-alpha*m)/a. Then 0<=h<alpha*b/a<alpha and mQ=k-h.
Since 5alpha<=1-alpha, the ENTIRE open interval mI satisfies

    mI=(k-Y,k-h) subset (k-1+alpha,k].                       (2)

Only the bad interval about integer k can meet this interval. The interval
about k-1 ends at k-1+alpha, strictly below it, and that about k+1 starts
above k. Also Q lies strictly in A, so I really does intersect A. Hence
I meets precisely its assigned ORIGINAL m-alpha arc and no other original
m-alpha arc, whether forced or nonforced. Reflection gives the larger-right
case. This strengthens the earlier forced-only intersection statement.

It follows again that assigning a maximum arc to its larger INDEXED parent
is injective, so

    |K_m|<=sum_(v in V, m/2<v<m)|K_v|.                      (3)

This counts indices, not labels. It gives no recursive inequality for a
truncated family: the original larger speeds remain present at the next
endpoint. Nor does it by itself bound reciprocal cover cost from above.

The accepted far-endpoint arithmetic remains exact for every original arc
C=(h_0/v-alpha/v,h_0/v+alpha/v) covering P. Its lift satisfies
C.left<P<C.right<=L. With

    T=v*l-a*h_0, G=v*k-m*h_0,

one has

    a*G=m*T+v*D,     G>=alpha*(m+v).                        (4)

For a mu-cover, |T-v*alpha|<=a*mu. Only when C is the unique ORIGINAL
alpha-cover can (1) sharpen this to
|T-v*alpha|<=a*(mu-v*epsilon/m). The identity in (4), divided by a*m*v,
is exactly addition of the two actual center gaps. Summing it does not
create an extra positive term after the center gaps have already been
included in winding. This is the limitation of the proposed weighted
incidence count; the next approach retains its actual global cycle instead.

## Second approach: every original mu-cover, with exact winding

Make a finite directed graph whose vertices are ALL original indexed
alpha-arcs, not just F. For A=(v,k) let R_A=(k+alpha)/v modulo one.
Put an edge A->B precisely when the closed mu-core of B contains R_A.
Every vertex has an outgoing edge by full mu-coverage. The label v cannot
cover its own endpoint at mu, so every edge changes label. No choice among
multiple covers is discarded in defining the graph.

For an edge with B of label w, choose the unique lift of its integer index
l for which

    e_AB=w*R_A-l in [-mu,mu].

Its lifted right endpoint satisfies

    R_B-R_A=(alpha-e_AB)/w>0.                               (5)

Also R_A lies strictly inside B's alpha-arc. Thus the entire half-open
interval [R_A,R_B) is covered by that lifted B. This statement does not
assume that the centers increase or that selected arcs are nonnested.

### Every simple directed cycle is a full cover of winding one

A finite graph with every outdegree positive has a simple directed cycle.
Take ANY such cycle A_0,A_1,...,A_(r-1),A_r=A_0 and lift its endpoints
successively by (5). Positivity gives

    R_(A_r)=R_(A_0)+winding,    winding in Z_(>0).

The lifted arcs A_1,...,A_r cover [R_(A_0),R_(A_0)+winding): each covers
the corresponding half-open step interval. Projecting gives a full original
alpha-cover. Consequently every forced indexed arc belongs to the cycle,
by its actual private point.

The winding is exactly one, not merely positive. Fix a private point p of
any forced arc B. A half-open interval of integer length winding contains
exactly winding points of p+Z, including the starting endpoint and excluding
the final endpoint if these coincide with that orbit. Each is covered by
one of A_1,...,A_r. Only the original arc B can cover any such point. The
simple cycle contains B exactly once, and its one chosen lift has length
2alpha/label(B)<1, so can contain at most one member of p+Z. Therefore
winding<=1. The same argument covers a private point equal to a transition
endpoint: that endpoint is in the next open arc by (5).

Thus multiple original covers do not prevent a full cycle. What fails to
propagate through them is deletion-goodness, not circle coverage.

### Integer determinants and signed depth on that cycle

Use indices i cyclically, with edge A_i->A_(i+1), labels v_i,v_(i+1),
and the compatible lifted integer indices k_i,k_(i+1). Define

    D_i=v_i*k_(i+1)-v_(i+1)*k_i,
    e_i=v_(i+1)*R_(A_i)-k_(i+1).

No fraction is reduced. In particular D_i is an integer divisible by
gcd(v_i,v_(i+1)), and

    e_i=(alpha*v_(i+1)-D_i)/v_i,
    R_(A_(i+1))-R_(A_i)
      =D_i/(v_i*v_(i+1))+alpha*(1/v_(i+1)-1/v_i).

The reciprocal endpoint terms telescope, giving the full arithmetic winding
identity

    sum_i D_i/(v_i*v_(i+1))=1.                              (6)

D_i need not be asserted positive: a selected mu-transition can involve
nested original arcs. It is the endpoint increment (5) that is positive.

Let u_i=1 when R_(A_i) has exactly one ORIGINAL open alpha-cover, and 0
otherwise. In the first case its chosen successor is that unique cover,
R_(A_i) belongs to W_(v_(i+1)), and (1) gives

    |e_i|<=mu-v_(i+1)*epsilon/Q_(v_(i+1)).

In the second case at least two distinct original labels are alpha-bad,
so R_(A_i) belongs to no W_v. Retain only |e_i|<=mu there, even if its
chosen successor happens to be forced for a different private point. Put

    f_C=sum_i 1/v_i,
    q_C=sum_i u_i/Q_(v_(i+1)).

The exact signed residual identities, before any inequality, are

    1=(alpha+mu)*f_C-sum_i (mu+e_i)/v_(i+1)
     =epsilon*f_C+sum_i (mu-e_i)/v_(i+1).                   (7)

Each residual sum is nonnegative; each unique-cover edge contributes at
least epsilon/Q_(v_(i+1)). Therefore EVERY simple cycle satisfies

    epsilon*(f_C+q_C)<=1<=(alpha+mu)*f_C-epsilon*q_C.        (8)

This keeps every multiple-cover edge and its actual signed residual. It
does not assign contraction to a convenient selected subcover's notion of
uniqueness. The latter would be a different and invalid domain assertion.

### A compulsory contribution from the all-zero parents

Write r_m=|K_m|. Every forced maximum arc A has a unique ORIGINAL right
endpoint cover, its right parent J. Hence its outgoing graph edge is A->J,
and it contributes 1/m to q_C in every cycle containing A.

Every such A also has a forced left parent I whose RIGHT near endpoint Q
is uniquely covered by A. Distinct maximum arcs have distinct indexed left
parents: a fixed right endpoint Q cannot belong to two disjoint original
m-arcs. Thus there are r_m distinct such source vertices I, all different
from the maximum vertices. Every cycle contains them and must use I->A.
Each contributes 1/Q_m=1/s. Consequently

    q_C>=r_m*(1/m+1/s),
    1<=(alpha+mu)*f_C-epsilon*q_C
       <=(alpha+mu)*f_C-epsilon*r_m*(1/m+1/s).              (9)

This left-parent injection uses fixed near endpoints. It is different from
the larger-parent whole-arc separation (2)--(3). Smaller left parents may
meet another maximum arc at their other endpoint, without contradicting
either statement. Equation (9) is a legitimate weighted double count on a
global cycle; no recursive smaller-maximum hypothesis was used.

## What this supplies, and the first remaining implication

The original selected-cover/winding interface did not require selected
neighbors to cover endpoints at CLOSED mu. This graph does, and its cycles
therefore satisfy the additional residual budget (7)--(9). They are a
subclass of original alpha-covers, so their minimum cost is at least the
minimum among all alpha-subcovers. A construction of a cheap alpha-subcover
does not automatically construct a cycle in this graph.

The only immediate cost upper bound here is f_C<=n, because the cycle has
distinct original indices. No bound reaches the opposite side of (8).
In particular f_C<=1/(2alpha) would give
(alpha+mu)f_C-epsilon*q_C<1, but that cost shortcut was already unavailable:
every finite open alpha-cover has cost strictly greater than 1/(2alpha).
The earlier private-cell completion and coincident-center pruning bounds
do not provide a mu-transition cycle of sufficiently small cost. The
strict-core capacity identity already leaves a positive deficit after
all of that coincident-center saving. Nothing in (2), (3), or (9) supplies
the missing upper bound or a new saving with a proved sign.

There is likewise no new one-slot lowering. Endpoint owners are ORIGINAL
labels. Every owner other than m is retained and alpha-good on all W_m;
m itself is not a lowering. To invoke the available all-admissible sum
minimality for replacing m, one would need an
actual fresh integer 0<u<m which is strictly alpha-bad on ALL W_m. Neither
the cycle nor the additive determinant identity supplies such a frequency.
Changing several original labels and repairing private points would still
leave the multiply-bad regions identified in the accepted private-repair
review; this manuscript makes no such transport inference.

The positive new statements are (2) and the full original-grid cycle
construction with (6)--(9). They close the existence/winding issue for the
cover relation. The unresolved implication is an arithmetic bound on these
cycles that contradicts their required cost, or a justified common fresh
blocker; neither has been derived. The desired native global contradiction
is not refuted either. No new control or search is needed for this bounded
disposition. The accepted 16->11->4->11->16 control remains only a native-good
local obstruction to speed monotonicity, and the consecutive-speed controls
remain equality-at-native-margin examples used at a larger working width.
Neither is promoted to an actual strict-failure counterexample.

## Bindings and checks

The accepted endpoint author and independent review were read in full.
The invoked complete-family topology, contraction, and cost interfaces were
checked against the focused bound sources; the private-repair review was
read for its exact domain limitation. All new calculations above are hand
derivations. The two approaches stop at the stated missing implication.

| Input | SHA-256 |
| --- | --- |
| `research/astra-forced-parent-endpoint-propagation.md` | `822154740aab96a1e5f3d4a18761c0596d8bde4c2337bd6bef67d33571e15fcb` |
| `research/astra-forced-parent-endpoint-review.md` | `b2d1d8e6ef81a6e8d450cfb74f0d74477773b359f06eb3cf3b39cb70b2816eef` |
| `research/astra-forced-arc-completion.md` | `e48f80297a70e6630e76fe2b905ed86372383a5d170a539abccdba3decdd98a1` |
| `research/astra-forced-completion-review.md` | `8e72687760576dc0e8524ecbae0bad81bcf3e8cd33f180219848da86a23adb02` |
| `research/astra-strict-core-shell-supply.md` | `5cc9866b3c8a516494ad998355265335a5edd15158cf9701c7d814843b97210e` |
| `research/astra-strict-core-shell-review.md` | `dd733c2910f1f4579846c1c945ecac8e83d140eb29917b81dc11d2b1b119b95f` |
| `research/astra-arithmetic-completion-saving.md` | `abfb14f274fb5c72461ce884b7fc44fb89367e056091f628933a601f52a33403` |
| `research/astra-coupled-descent-strategy.md` | `d9a029cb16c866a45741f97841f3b007d4823f86712fe827e899801208289bb2` |
| `research/astra-private-repair-review.md` | `a8aaec8468969723207dc12e9ff2c112a4560c1f51e97f13b43f4e342c849512` |
| `research/astra-minimal-frequency-synthesis.md` | `03cf038021f0bc1a2328bb77a02f6ab4fe649f5d3626d7bc368a67cd6c7b0000` |
| `.codex/config.toml` | `28212a53cf42cdc377df1f7dab040732d657e59d7bb97ee78791256d01d4bb2c` |
| `docs/project-workflow.md` | `2b42a133352b6b53ba2106fc73882733f176e04a0deffbb183b4c16eefd9cd67` |
| `research/workflow-policy.json` | `833c397b61d1ffdb994fb115019f6d60d6c1a62ff85f19cdd2c9f8ac3a979c8b` |
| `scripts/validate_workflow.py` | `250a3ce2a080f5835ac4fd2e4b2803568424c777cda5d421f9fe92efd34d5383` |

Current config, workflow, policy and focused state were read. The gate was
research/in_progress with explicit start authorization
`2026-09-05T04:12:25.208107+00:00` and this sole owned path. Initial and
final `python3 -B scripts/validate_workflow.py` checks, full owned readback,
all fourteen source bindings, whitespace/final-newline check and the frozen
owned hash are reported at handoff. The validator checks structure, not
mathematics. No mathematical program, solver, sweep, Lean/build/cache work,
new agent, external model, Git/shared-state/memory edit or other-file write
was performed. Independent manuscript review is still required.
