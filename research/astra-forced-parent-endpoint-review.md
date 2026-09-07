# Independent review: forced-parent endpoint propagation

Task `/root/forced_parent_endpoint_review`; assigned checkpoint
`598f969732186d9ee39641d343d5e79ddeb1eb77`. Requested route:
`gpt-6-astra` / `xhigh`, the existing in-session review route. Observed
model, effort, elapsed time and usage: null. This review is the sole owned
file; root owns workflow state and publication.

**Accepted without correction** for author SHA-256
`822154740aab96a1e5f3d4a18761c0596d8bde4c2337bd6bef67d33571e15fcb`.
The far-endpoint norm exclusion, all-cover determinant restrictions and
injective assignment to larger indexed parents are valid for the stated
uniform range n>=5. Unique covers give actual deletion-good points;
multiple covers do not. The exact outward chain refutes the stated local
height shortcut, while its tuple is LRC-good. No global walk, common
replacement supply, or canonical contradiction has been established.

## Exact hypotheses and endpoint domains

Assume a hypothetical canonical strict failure V of n>=5 distinct positive
primitive integer speeds, least by moving count and then primitive sum.
Put alpha=1/(n+1)<=1/6, m=max V, 0<mu=max_t min_(v in V)||vt||<alpha,
and epsilon=alpha-mu>0. The whole closed deletion sets W_v are nonempty
by lower-count validity. Under full failure, every point of W_v lies
inside an actual forced v-alpha arc, with its actual nearest index.

The accepted contraction is pointwise on ALL W_v:

    ||vt||<=mu-v*epsilon/Q_v, Q_v=max(V\{v}).

Its domain includes endpoints where another original norm equals alpha.
The bound comes from the whole connected mu-bad component during a
short time interval in which every retained norm stays above mu. Neither
a convenient test value for mu nor merely a chosen seed suffices. The
unchanged source and its prior reviewed scope are retained here.

Assume all attained maximum arcs are zero-only. Reflect a selected arc,
if necessary, so its larger parent is the left one. The exact lifted data
are

    a>b>0, a+b=m, l+r=k,
    l/a<k/m<r/b,
    D=ar-bl=ak-ml=mr-bk,
    alpha*m<=D<=mu*(m+b)<alpha*(m+b),
    A=(L,R), L=(k-alpha)/m, R=(k+alpha)/m,
    I=(P,Q), P=(l-alpha)/a, Q=(l+alpha)/a.

The right parent J begins at S=(r-alpha)/b. The accepted whole private
portion is [Q,S]. In particular S-Q=(D-alpha*m)/(a*b)>=0, so equality
and singleton portions are allowed. Also

    Q-L=(alpha*(m+a)-D)/(a*m)>0,
    k/m-Q=(D-alpha*m)/(a*m)>=0,
    S-k/m=(D-alpha*m)/(b*m)>=0.

Thus Q lies strictly inside A, and the corresponding statement holds for
S. The larger-parent far endpoint P lies strictly to the left of L.
Only I and J meet A. An open original arc covering L must also meet A,
so I is its unique cover; J cannot cover L because S>=Q>L. Hence L is
in W_a. Similarly R is in W_b. At Q and S the original maximum arc is
the unique cover, so these points lie in W_m. Both parents are therefore
actual forced indexed arcs. All of these are original single-deletion
statements, distinct from the two-bad-label contact times in the accepted
amplification manuscript.

## Actual far-endpoint norms

At P, substitution into the two determinant identities gives

    bP=r-X, X=(D+b*alpha)/a,
    mP=k-Y, Y=(D+m*alpha)/a.

With z=b/a in (0,1), the lower and upper bounds on D yield

    alpha*(1+2z)<=X<alpha*(1+3z)<4alpha,
    2alpha*(1+z)<=Y<alpha*(2+3z)<5alpha.

In particular X>alpha and Y>2alpha. Since alpha<=1/6,
4alpha<1-alpha and 5alpha<=1-alpha. The strict upper bound for Y also
handles alpha=1/6. Thus X,Y both lie strictly in (alpha,1-alpha), and

    ||bP||=min(X,1-X)>alpha,
    ||mP||=min(Y,1-Y)>alpha,
    ||aP||=||l-alpha||=alpha.

This explicitly checks the possible passage of X or Y through 1/2. A
lower bound on a signed phase alone would not suffice. Reflection proves
the corresponding far-right-endpoint statement when the larger parent
is on the right. No extension to n=3 or n=4 is claimed.

The actual full bound F(P)<=mu supplies an ORIGINAL label v with
||vP||<=mu. None of a,b,m can be that label. More strongly, every original
open alpha-arc covering P has a label outside {a,b,m}, since all three
excluded norms are at least alpha. Each possible new owner is smaller
than m, but is already a retained label.

## Every cover, selected mu-covers and uniqueness

Let C be ANY original alpha-arc covering P, of label v and actual lifted
index h. Choose its lift containing P. Since L belongs to W_a and v!=a,
C cannot contain L. It follows that

    C.left<P<C.right<=L<Q.

There is no missed circle lift: a>=3, v>=1 and alpha<=1/6 give
length(I)+length(C)<=2alpha*(1/3+1)<1. Their intersecting union therefore
has a proper interval lift. If C.right were greater than L, the same
component would contain L. The possibility C.right=L is an external
tangency to A and is correctly kept. Comparing both endpoints of C with
those of I also gives h/v<l/a<k/m.

Define the positive integers T=v*l-a*h and G=v*k-m*h. Direct substitution
proves

    a*G=m*T+v*D,
    vP-h=(T-v*alpha)/a,
    vL-h=(G-v*alpha)/m.

Thus the exact cover condition and right-endpoint restriction give

    |T-v*alpha|<a*alpha,
    G>=alpha*(m+v).

The last bound is weak precisely because C.right=L is allowed. Also
gcd(a,v) divides T and gcd(m,v) divides G. These statements retain the
actual original label v and actual lifted h, including when the rational
center has a smaller reduced denominator.

For a selected mu-cover, its unique alpha-bad component has
|vP-h|=||vP||<=mu, so the middle determinant bound sharpens to
|T-v*alpha|<=a*mu. Since

    L-P=(D+b*alpha)/(a*m)=X/m,
    vL-h>=alpha, vP-h<=mu,

one gets v*X>=m*epsilon. The global mu-cover supplies at least one such
label; an arbitrary alpha-cover is not automatically a mu-cover.

If EXACTLY ONE original alpha-arc covers P, all other original norms are
at least alpha. Therefore P belongs to W_v, C has an actual private point
and is forced, and Q_v=m because v!=m. Applying the full contraction on
that precise domain gives

    |T-v*alpha|<=a*(mu-v*epsilon/m),
    v*X/m>=(alpha-mu)+v*epsilon/m,
    v*(X-epsilon)>=m*epsilon.

These are the two claims in (7). Closed goodness at other labels, including
the equality ||aP||=alpha, does not prevent applying the contraction.

If there are at least two original alpha-covers at P, their labels differ:
arcs of one speed are disjoint because 2alpha<1. At least two different
labels are strictly bad. Deleting any single original label leaves one
bad, so P belongs to NO W_w. An arbitrary selected cover at that point
need not be forced and cannot inherit the W_v contraction. This is a
domain obstruction, not an arbitrary choice among interchangeable seeds.
Even after a unique cover, its other endpoint requires a fresh check of
the entire original family; the maximum-speed zero-only theorem cannot
simply be reapplied to the smaller label v.

## Injectivity for indexed parents and the finite relation

The larger parent I intersects its assigned maximum arc A, with Q in A.
Consider another forced m-arc A' intersecting I. Their total length is
at most 2alpha*(1/3+1/5)<=8/45<1, so the intersection can be treated in
compatible real interval lifts. A' cannot be contained in I: its actual
private point would then lie in another original bad arc. Nor can A'
contain I, because length(A')=2alpha/m<2alpha/a=length(I).

For two intersecting intervals with neither containment, an endpoint of
I lies strictly in A'. This remains true when one examines all possible
endpoint equalities: an equal-endpoint nested case is a containment,
whereas an external tangency gives no intersection of the open arcs.
The endpoint Q already belongs to A, and distinct original m-arcs are
disjoint. The far endpoint P is strictly m-good, so belongs to no open
m-arc at all. Neither endpoint can lie in A', proving that I intersects
no forced m-arc other than A.

If two maximum arcs had the same larger indexed parent, that parent would
intersect both, contrary to this result. The assignment is therefore
injective. Each parent label is in (m/2,m), and its index belongs to the
complete forced set K_v, giving

    |K_m|<=sum_(v in V, m/2<v<m) |K_v|.

This is an assignment of original INDEXED arcs, not an injection into
speed labels. Different arcs of the same larger speed can be assigned
to different maximum arcs. External tangencies are not excluded by the
incidence claim, and are not counted as intersections.

For the endpoint relation, an edge is admitted only when the endpoint's
unique ORIGINAL alpha-cover is the next arc. Such an endpoint is an
actual deletion-good point for that next owner, hence the next arc is
forced. The accepted endpoint domains already give reciprocal edges
A->I at L and I->A at Q, and the analogous pair for J. Therefore label
height cannot strictly decrease along every edge of this full relation.

If an outward walk instead uses the other endpoint after entering an
arc, uniqueness must be checked anew. Two distinct forced arcs cannot
contain one another, by their private points. At a rightward step their
endpoint orders therefore put the next center strictly to the right;
leftward steps have the reflected order. These ordered real lifts do
not prevent repetition of an indexed arc after integer winding on the
circle. Multiple-cover endpoints may also stop the deletion-good walk.
The earlier accepted cyclic-neighbor restriction on forced overlaps is
consistent with both limitations; it supplies no new exclusion of winding
cycles. No complete closed global walk is asserted or constructed here.

## Complete outward-chain control

Use the native local control V={1,4,5,11,16}, n=5, alpha=1/6. The two
original parents of (16,7) are (5,2) and (11,5), with D=3, and its actual
private portion is [13/30,29/66]. Reflection supplies the corresponding
portion at (16,9). These previously checked facts are local statements;
they do not assert full trapping of W_16 or zero-only behavior at every
other maximum index.

I checked ALL five actual norms at each transition time, in label order
1,4,5,11,16:

| Time | Five norms | Unique original alpha-cover |
| --- | --- | --- |
| 43/96 | (43,20,23,7,16)/96 | (11,5) |
| 31/66 | (31,8,23,11,32)/66 | (4,2) |
| 13/24 | (11,4,7,1,8)/24 | (11,6) |
| 37/66 | (29,16,13,11,2)/66 | (16,9) |

For example, at 31/66 the speed-16 phase is 496/66, whose nearest-integer
distance is 32/66, and the speed-4 phase is 124/66, whose distance is
8/66. At 13/24 the speed-11 phase is 143/24, at distance 1/24 from 6.
At 37/66 the speed-16 phase is 592/66, at distance 2/66 from 9. The
remaining displayed entries follow from the same direct integer residues.
These verify the actual norms and grid indices, rather than only signs
of convenient lifted phases.

The times are respectively

    (7+alpha)/16, (5+alpha)/11, (2+alpha)/4, (6+alpha)/11.

At each time the preceding owner's norm is exactly alpha, the displayed
new owner is strictly bad, and every other original label is good. Thus
each next arc is forced by that actual private point. Each time is the
right endpoint of the preceding arc; after the first transition it is
the endpoint OTHER than the side through which that arc was entered.
The complete checked chain is

    (16,7)->(11,5)->(4,2)->(11,6)->(16,9).

Its centers increase as 7/16<5/11<1/2<6/11<9/16. Its speeds decrease
16,11,4 and then increase 11,16. The two speed-11 arcs have different
original indices, so neither the return in speed nor the final speed-16
arc is a backward step or an identified duplicate vertex.

The far endpoint of the larger parent in the first step is 31/66. In
the reflected orientation of the new formula, X=23/66 while Y=34/66;
the actual maximum-speed norm is 1-Y=32/66>alpha. This directly illustrates
why the proof must handle the crossing of 1/2 rather than treating Y
itself as the norm.

Finally t=1/3 gives norm 1/3 for EVERY original speed, since all five
labels have nonzero residue modulo three. Thus this tuple is LRC-good
and cannot be assigned a true global mu<alpha. The chain refutes strict
outward speed decrease from the displayed local uniqueness and grid
geometry alone. It does not refute an invariant using additional full
canonical failure hypotheses, and it neither completes nor claims a
global winding cycle.

## Scope, unresolved implication and evidence

The new endpoint owner is an original retained speed. It is alpha-good
on ALL W_m by definition and is not a fresh frequency bad on W_m. Thus
even common endpoint ownership would not by itself give the one-slot
replacement required by minimum sum. The accepted candidate and lcm
results from the parent-reduction manuscript are not assumed as supply.

The first unresolved implication is how to continue or exploit the
endpoint relation when an outward endpoint has several original covers,
and how even a chain of unique covers could yield a valid global potential
or a common fresh blocker. The determinant bounds and injective incidence
count supply neither. The actual native implication remains unproved and
unrefuted by this control. No new failure transport, uniform contradiction,
Lean theorem, or unrestricted LRC proof/disproof is accepted by this review.

The frozen author was fully read. The unchanged predecessor mathematics
and reviewed scopes were reused with current hash verification; the new
endpoint, incidence and control derivations above were independently
checked by hand. The fourteen current bindings below include the author
and all thirteen of its inputs.

| Bound source | SHA-256 |
| --- | --- |
| `research/astra-forced-parent-endpoint-propagation.md` | `822154740aab96a1e5f3d4a18761c0596d8bde4c2337bd6bef67d33571e15fcb` |
| `research/astra-zero-only-deletion-amplification.md` | `a28465087b02b4763833ffa43263a899b4db262f076b60dffd2342d9a51b5ba0` |
| `research/astra-zero-only-deletion-amplification-review.md` | `ef37fc563a75ea59b5b57b9fd3af43b3f09f7763971059268cf7878cfa8ffdb4` |
| `research/astra-zero-only-maximum-gaps.md` | `f21fc1de78ee9802ecf8992677395507984d26894b220b9890849054077546da` |
| `research/astra-zero-only-maximum-gaps-review.md` | `df1898cb979bc683f172a61e429e9ab48f01f1846bba0821097bdd4979161d4e` |
| `research/astra-forced-cycle-frequency-exchange.md` | `4ac28414ec9043c9ed11d69b7cc8520a2a1acc3b74168147acfc38091959046f` |
| `research/astra-maximum-frequency-exchange-review.md` | `9cd1282b49034073ad59e8df183df7e7b2cc65ce359d8ec8b088c6c032ab9515` |
| `research/astra-forced-arc-completion.md` | `e48f80297a70e6630e76fe2b905ed86372383a5d170a539abccdba3decdd98a1` |
| `research/astra-strict-core-shell-supply.md` | `5cc9866b3c8a516494ad998355265335a5edd15158cf9701c7d814843b97210e` |
| `research/astra-zero-only-parent-reduction.md` | `9b67661ec12a1b51e6de9405c04f3a0d071b3a5630b6ad772d19da18baf99d71` |
| `.codex/config.toml` | `28212a53cf42cdc377df1f7dab040732d657e59d7bb97ee78791256d01d4bb2c` |
| `docs/project-workflow.md` | `2b42a133352b6b53ba2106fc73882733f176e04a0deffbb183b4c16eefd9cd67` |
| `research/workflow-policy.json` | `833c397b61d1ffdb994fb115019f6d60d6c1a62ff85f19cdd2c9f8ac3a979c8b` |
| `scripts/validate_workflow.py` | `250a3ce2a080f5835ac4fd2e4b2803568424c777cda5d421f9fe92efd34d5383` |

Current project config, workflow, policy and focused state were read.
The gate was research / in_progress, with explicit start authorization
`2026-09-05T04:12:25.208107+00:00` and this sole recorded owned path.
`python3 -B scripts/validate_workflow.py` exited 0 with
`workflow structural validation passed; it cannot certify mathematical validity.`
The author and thirteen bound inputs passed administrative SHA-256
verification. Full owned-file readback, final bindings, whitespace/newline
checks, workflow validation and the frozen review hash are reported at
handoff. No mathematical program, sweep, solver, build, dependency/cache
operation, additional agent, external model, Git/shared-state/memory write
or other-file edit was performed.
