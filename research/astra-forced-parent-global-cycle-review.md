# Independent review: the full original endpoint cycle

Task `/root/full_endpoint_cycle_review`; recorded checkpoint
`eded4ca55ca867517f10d3ed30c2ef0a0eba2062`. Requested route:
`gpt-6-astra/xhigh`; observed model, effort, elapsed time and usage: null.
Only this review is owned; root owns shared state and publication.

**Accepted without correction** for author SHA-256
`e265c08b2e0204a8d539e1577ff9907c754287902e6474f043b42be6f5de7bae`.
The larger-parent separation, full finite endpoint graph, winding-one
argument, signed residual identities and mandatory parent contributions
are valid at their stated scopes. They do not provide an upper cost bound,
an admissible descent or an unrestricted LRC proof/disproof. Acceptance is
of the complete hand manuscript, not a kernel theorem.

## Hypotheses and the information retained

Assume a hypothetical canonical strict failure V of n>=5 distinct positive
primitive integer speeds, least by moving count and then primitive sum.
Set alpha=1/(n+1)<=1/6, m=max V, s=max(V\{m}), and

    0<mu=max_t min_(v in V)||vt||<alpha, epsilon=alpha-mu>0,
    W_v={t:||ut||>=alpha for every retained u!=v},
    Q_v=max(V\{v}).

All times are on R/Z, with compatible real lifts when endpoints are used.
Least count gives a stronger deletion witness at 1/n, hence nonempty W_v.
The accepted contraction holds on EVERY point of its closed domain:

    ||vt||<=mu-v*epsilon/Q_v for every t in W_v.              (R1)

The original indexed open arcs A_(v,k) have center k/v and radius alpha/v;
their closed mu-cores H_(v,k) have radius mu/v. Every point is in some
closed core because the full minimum is at most the actual global mu.
There is no assertion that the open mu-arcs cover.

K_v includes every index attained on W_v, including singleton portions.
Under strict failure, W_v is precisely the region where v is the only
strictly alpha-bad label. Since same-speed arcs are disjoint, the family
F of these attained indexed arcs is exactly the original arcs possessing
a private point outside EVERY other original alpha-arc. In particular F
is nonempty, with at least one member for each speed. This is stronger
than indispensability relative to a conveniently selected subcover.

Assume the accepted all-zero data at every attained maximum arc. This is
an additional branch hypothesis, not a deduction from strict failure in
general. The new full-graph cycle argument uses the core cover and private
points; its compulsory parent bonus additionally uses these all-zero data.
No sum-minimality consequence is silently added to either argument.

## Larger parents avoid every other original maximum arc

Reflect one configuration so the larger parent is left, and use the
accepted lifted data

    a>b>0, a+b=m, l+r=k, D=ar-bl=ak-ml,
    alpha*m<=D<=mu*(m+b)<alpha*(m+b),
    A=(L,R)=((k-alpha)/m,(k+alpha)/m),
    I=(P,Q)=((l-alpha)/a,(l+alpha)/a).

The predecessor supplies L in W_a, R in W_b, Q in W_m, Q strictly inside
A, and both parents forced. Put h=(D-alpha*m)/a and
Y=(D+alpha*m)/a. Direct substitution gives

    0<=h<alpha*b/a<alpha,
    2alpha<Y<alpha*(2+3b/a)<5alpha,
    mI=(k-Y,k-h) subset (k-1+alpha,k].                     (R2)

The last inclusion uses 5alpha<=1-alpha; its left endpoint remains strict
when alpha=1/6. Every open m-bad interval except that about k is disjoint
from this range. In particular the interval about k-1 ends at k-1+alpha.
There is no missing wrapped index: these are periodic real lifts of ALL
integer-centered intervals. Since Q lies inside A, points of I just left
of Q lie in A too, so the intersection with the assigned arc is real.
Reflection proves the other orientation.

This excludes nonforced as well as forced maximum arcs and is a genuine
strengthening of the predecessor. It again gives an injection from K_m
to the indexed forced parents with labels in (m/2,m), yielding the stated
count inequality. It gives no injection into speed labels, no recursive
maximum hypothesis after deletion, and no upper reciprocal-cost bound.

The repeated far-endpoint formula is also exact. For any original arc C
covering P, its lift has C.left<P<C.right<=L. With
T=v*l-a*h_0 and G=v*k-m*h_0,

    a*G=m*T+v*D, G>=alpha*(m+v).

For a closed mu-cover, |T-v*alpha|<=a*mu. Only original uniqueness at P
places P in W_v and permits the contracted version with Q_v=m.
Dividing the identity by a*m*v gives
G/(m*v)=T/(a*v)+D/(a*m), exactly the addition of the two center gaps.
It supplies no further positive term after those gaps have been charged.

## Full graph, compatible lifts and winding one

Take ALL indexed original arcs as vertices, and A->B iff H_B contains
the right endpoint R_A modulo one. This is a finite graph of positive
outdegree. The source label cannot cover its own endpoint at mu because
its norm there is alpha; consequently every edge changes label.

Given a lift R_A and a successor label w, the edge has a unique lifted
integer l satisfying e=w*R_A-l in [-mu,mu], since 2mu<1. This fixes
the lift of B, and

    R_B-R_A=(alpha-e)/w>0.                                (R3)

Also R_A is strictly inside B's open alpha-arc. Therefore B covers the
ENTIRE half-open interval [R_A,R_B), even if B is nested relative to A
or its center does not advance. Neither center monotonicity nor cover
irredundancy is needed.

Following outgoing edges in a finite graph and stopping at the first
repeat supplies a simple directed cycle. For ANY simple cycle
A_0,...,A_r=A_0, lift endpoints successively using (R3). Its final right
endpoint differs from the initial one by an integer w: the final arc has
the same original label and index modulo that label. The positive
increments give w>0. The chosen lifts A_1,...,A_r cover
[R_(A_0),R_(A_0)+w) by their half-open step intervals. Projection is a
full original alpha-cover, so every forced indexed arc is in the cycle.

To prove w=1, fix a private point p of a forced arc B. A half-open interval
of integer length w contains exactly w translates of p by integers.
Each is covered by one of the chosen arc lifts. Its projection can only
be covered by the original arc B, by privacy relative to the FULL family.
Simplicity puts B exactly once among A_1,...,A_r. Its single chosen lift
has length 2alpha/label(B)<1, so it can contain at most one translate of
p. Hence w<=1 and therefore w=1.

There is no lost boundary case here. A translate of p at an internal step
endpoint lies in the next open arc by (R3). A translate at the initial
endpoint is counted and covered; one at the final endpoint is omitted.
Thus exactly w translates, rather than w-1 or w+1, are counted. The
existence of a forced private point is essential to this proof and is
supplied by the stated hypotheses.

This resolves the earlier existence/winding gap for the enlarged endpoint
relation. It does not assert that the cycle consists only of forced arcs,
that it is an irredundant cover, or that all its endpoints are private.

## Signed determinants and both residual identities

For successive lifted indices k_i,k_(i+1) and labels v_i,v_(i+1), direct
expansion gives

    D_i=v_i*k_(i+1)-v_(i+1)*k_i,
    e_i=(alpha*v_(i+1)-D_i)/v_i,
    R_(i+1)-R_i=D_i/(v_i*v_(i+1))
                   +alpha*(1/v_(i+1)-1/v_i).

Each D_i is an integer divisible by gcd(v_i,v_(i+1)). It is not replaced
by a determinant of reduced denominators. Summing and using winding one
cancels the reciprocal endpoint terms and proves

    sum_i D_i/(v_i*v_(i+1))=1.                            (R4)

Positivity is asserted for R_(i+1)-R_i, not for D_i. The formulas retain
signed determinants and remain valid for nested transitions; no unproved
positive-determinant restriction is used.

Let u_i indicate that R_i has exactly one ORIGINAL open alpha-cover.
If u_i=1, its chosen successor is that unique arc and R_i belongs to the
successor's full W_v. Equation (R1) then gives

    |e_i|<=mu-v_(i+1)*epsilon/Q_(v_(i+1)).

If u_i=0 there are at least two original covering arcs, since an outgoing
mu-edge always exists. Their labels differ. Such a point is in no W_v,
so only |e_i|<=mu may be used. A forced successor at some different private
point does not improve this bound. Uniqueness within the chosen cycle
would not suffice either.

Write f_C=sum_i 1/v_i and q_C=sum_i u_i/Q_(v_(i+1)). Summing (R3) gives
1=alpha*f_C-sum_i e_i/v_(i+1). Adding and subtracting mu*f_C gives BOTH
identities exactly as stated:

    1=(alpha+mu)*f_C-sum_i (mu+e_i)/v_(i+1)
     =epsilon*f_C+sum_i (mu-e_i)/v_(i+1).                 (R5)

Both residual sums are nonnegative. At each u_i=1, each residual is at
least epsilon/Q_(v_(i+1)). This proves the two weak inequalities

    epsilon*(f_C+q_C)<=1<=(alpha+mu)*f_C-epsilon*q_C.       (R6)

Equality in the local contraction or at a closed mu-core endpoint is
permitted, so no unjustified strict sign has entered (R6).

## The all-zero transitions give the claimed compulsory bonus

Now use the all-zero data in the fixed circle orientation; do not reflect
individual configurations when counting right-endpoint edges. Each forced
maximum arc A has a unique original right-endpoint cover, its right parent
J. Hence A->J is its only outgoing graph edge. Since J has label less
than m, Q_(label J)=m, so this source vertex contributes 1/m to q_C.

The left parent I of A is forced and its right near endpoint Q is uniquely
covered by A. Thus I->A is also the only outgoing edge from I and contributes
1/Q_m=1/s. For two different maximum indices, their left parents cannot
be the same indexed arc: that fixed arc would have the same right endpoint
Q inside two disjoint original m-arcs. There are consequently |K_m|
distinct left-parent source vertices, all different from the maximum
source vertices. Every simple cycle contains all of them because they
are forced. Counting these disjoint source sets proves

    q_C>=|K_m|*(1/m+1/s),
    1<=(alpha+mu)*f_C-epsilon*q_C
       <=(alpha+mu)*f_C-epsilon*|K_m|*(1/m+1/s).           (R7)

This counts indexed arcs, not distinct parent labels. A left parent could
also be a right parent in another configuration without changing this
count. The left-parent injection uses its fixed near endpoint; it is
separate from the larger-parent whole-arc separation (R2). No assertion
that every smaller parent avoids all other maximum arcs is required.

## New content, older cost holds and the first unresolved implication

The new content is (R2), and a guaranteed winding-one full original-grid
cycle whose closed-mu endpoint transitions obey (R4)--(R7). Enlarging the
graph repairs coverage propagation through multiple-cover endpoints while
correctly retaining the loss of deletion-goodness at those endpoints.
These results go beyond the predecessor's partial unique-cover relation.

The earlier private-cell theorem gives the minimum among ALL original
alpha-covers as f+sum_j kappa_j, with f=cost(F). It also gives two-color
completions; coincident-center pruning improves their constructed cost to
(n+f-S_c-B_c)/2. Those are actual alpha-covers, but they need not satisfy
the closed-mu endpoint-transition condition. An upper bound on that larger
class's minimum is not an upper bound on the minimum cost of these cycles.
The author keeps this direction correct.

Moreover the accepted strict-core capacity identity already proves

    f-1-S_c >= (1-mu/alpha)*(f+L)+E>0,
    L=sum_v |K_v|/Q_v, E>=0.

Thus the complete specified coincident-center saving does not supply the
missing sharp upper cost, and the new cycle bonus is a further LOWER
requirement, not an uncharged saving. The immediate upper bound f_C<=n
only uses that a simple cycle contains at most v indices of each label v.
Every finite open alpha-cover has cost strictly greater than 1/(2alpha):
its total arc length covers the circle, and a chosen arc's endpoint is
inside another chosen open arc, giving positive-length overlap. Thus
asserting f_C<=1/(2alpha) would already demand a contradiction, not provide
one. No such bound is derived from minimum sum.

Full minimum-sum transport still requires an admissible smaller tuple.
In particular a fresh 0<u<m strictly bad on ALL W_m would give one-slot
descent, because outside W_m a retained old label is already bad. Original
endpoint owners cannot supply that blocker: every retained label is
alpha-good on W_m. For simultaneous changes, repair on all private sets
still leaves multiply-bad regions, as the accepted private-repair review
shows. The present graph does not control new phases in those regions.

The first unresolved implication is an arithmetic upper cost or other
cycle restriction contradicting (R6)--(R7), or an actual common fresh
blocker. Neither is established or refuted under the full native-failure
hypotheses. The reused native-good endpoint chain and the larger-width
consecutive-family controls retain their earlier limited scopes. This
review introduces no new example, search or research mechanism.

## Bindings and actual checks

The author and accepted endpoint author/review were fully read. The invoked
completion, arithmetic-pruning, private-repair and contraction/capacity
arguments were checked against the bound sources at their exact domains.
The unchanged earlier manuscripts are not re-audited wholesale; the new
claims above were independently checked by hand. All fifteen bindings
(author and its fourteen inputs) were verified administratively.

| Bound source | SHA-256 |
| --- | --- |
| `research/astra-forced-parent-global-cycle.md` | `e265c08b2e0204a8d539e1577ff9907c754287902e6474f043b42be6f5de7bae` |
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

Current config, workflow, policy and focused state were read. The state was
research/in_progress with explicit start authorization
`2026-09-05T04:12:25.208107+00:00` and this sole review path recorded.
Initial `python3 -B scripts/validate_workflow.py` exited 0, reporting
`workflow structural validation passed; it cannot certify mathematical validity.`
Full owned readback, final binding/whitespace/newline checks, final workflow
validation and frozen review hash are returned at handoff. Administrative
file/hash checks are not mathematical computation. No mathematical program,
enumeration, search, solver, Lean/build/cache work, new agent, external model,
Git/shared-state/memory edit or other-file write was performed. Unrestricted
LRC remains unresolved.
