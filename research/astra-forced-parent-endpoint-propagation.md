# Forced-parent endpoints: a new-label alternative and its propagation limit

Task `/root/forced_parent_endpoint_propagation`; assigned checkpoint
`f102e7ec81958ef064555f1b470499b5a075fe72`. Requested route: Astra/xhigh.
Observed model, effort, elapsed time and usage: null. Only this manuscript
is owned. The new hand derivations require independent review.

For n>=5, the far endpoint of the larger parent of an all-zero maximum arc
is strictly alpha-good for both the maximum label and the other parent.
Every original arc covering that endpoint therefore has a label outside
the original triple. A unique cover supplies a legitimate new deletion-good
point; multiple covers supply none. Moreover each larger indexed parent
intersects exactly one forced maximum arc, giving an injective assignment
of maximum arcs to larger parents. These are necessary restrictions under
native strict failure. No global descent or contradiction follows here.

## Hypotheses and actual endpoints

Assume a hypothetical canonical strict failure V of n distinct positive
primitive integer speeds, least by moving count and then primitive sum.
The new escape statement uses the uniform range n>=5; it makes no claim
for n=3,4. Put

    alpha=1/(n+1)<=1/6, m=max V,
    0<mu=max_t min_(v in V)||vt||<alpha, epsilon=alpha-mu>0,
    W_v={t:||wt||>=alpha for every w in V\{v}}.

Every W_v is nonempty by least count. All its attained indexed arcs are
forced, with actual private points. The accepted full-time contraction is

    ||vt||<=mu-v*epsilon/Q_v on W_v,
    Q_v=max(V\{v}).                                         (1)

It holds on every point, including closed endpoints; no test constant is
substituted for the true maximum mu.

Assume EVERY attained maximum arc is zero-only. Reflect time if necessary
so that the larger parent is the left parent. The accepted exact data are

    a>b>0, a+b=m, l+r=k,
    l/a<k/m<r/b, D=ar-bl=ak-ml=mr-bk,
    alpha*m<=D<=mu*(m+b)<alpha*(m+b),
    A=(L,R), L=(k-alpha)/m, R=(k+alpha)/m,
    I=(P,Q), P=(l-alpha)/a, Q=(l+alpha)/a,
    J=((r-alpha)/b,(r+alpha)/b).

The endpoints have the real order

    P<L<Q<=k/m< R,       Q< R.

More precisely Q<=(r-alpha)/b, with equality permitted. The original
endpoint L belongs to W_a, R belongs to W_b, and both near-parent
endpoints Q and (r-alpha)/b belong to W_m. Thus I and J are actual forced
indexed arcs. No retained arc other than I,J intersects A.

These are genuine single-deletion-good points. The separate contact times
in the amplification manuscript have two bad labels and lie in no W_v;
they are not used as propagation seeds here.

## First approach: the far endpoint and every possible cover

At the other endpoint P of I, integer-label identities give

    bP=r-X, mP=k-Y,
    X=(D+b*alpha)/a,       Y=(D+m*alpha)/a.

Writing t=b/a in (0,1), the exact determinant window implies

    X>=alpha*(1+2t)>alpha,
    X< alpha*(1+3t)<4alpha,
    Y>=2alpha*(1+t)>2alpha,
    Y< alpha*(2+3t)<5alpha.                                 (2)

Since alpha<=1/6, both X and Y lie strictly between alpha and 1-alpha.
Consequently

    ||bP||>alpha,       ||mP||>alpha,       ||aP||=alpha.      (3)

This checks the actual circle norms, including the possible crossing of
1/2. In particular a bound on signed distance was not mistaken for a
lower bound on the norm. Reflection proves the corresponding statement
at the far RIGHT endpoint when the larger parent is on the right.

The complete family covers P at closed width mu. Therefore at least one
ORIGINAL speed v outside {a,b,m} satisfies ||vP||<=mu. Every original
open alpha-arc covering P has its label outside that triple, not only
the selected mu-cover. This is the new-label alternative; all such v<m.

### Exact lifted constraints and the uniqueness distinction

Retain every original arc C of label v covering P, and write its lift as
C=(h/v-alpha/v,h/v+alpha/v). Since L in W_a and v!=a,

    C.left<P<C.right<=L<Q.                                  (4)

Indeed a cover through P extending past L would also contain L. These
lifts are compatible: I and C have total length below one, and (4) makes
their intersecting union a proper interval. Their centers are ordered
h/v<l/a<k/m. Put

    T=v*l-a*h>0,       G=v*k-m*h>0.

These are integers satisfying the genuine two-step identity and bounds

    a*G=m*T+v*D,
    |T-v*alpha|<a*alpha,
    G>=alpha*(m+v).                                         (5)

The middle inequality is exactly that C covers P. The last is exactly
C.right<=L, retaining equality at an external tangency to A. In particular
gcd(a,v) divides T and gcd(m,v) divides G; the actual grid label v is
never replaced by a reduced denominator. These are all-cover statements.

For a cover whose norm at P is at most mu, the middle bound sharpens to
|T-v*alpha|<=a*mu. Also L-P=X/m and vL-h>=alpha, whereas
vP-h<=mu. Hence every such mu-cover obeys

    v*X>=m*epsilon.                                         (6)

The full cover supplies at least one such label. It does not give the
mu-bound for every alpha-cover.

If EXACTLY ONE original alpha-arc C covers P, then P belongs to W_v;
C is forced and Q_v=m. Equation (1) gives the additional bound

    |T-v*alpha|<=a*(mu-v*epsilon/m),
    v*(X-epsilon)>=m*epsilon.                               (7)

The second inequality follows as in (6), using the contracted upper bound
on vP-h. If two or more original alpha-arcs cover P, their labels differ
(same-speed arcs are disjoint), and P lies in NO W_w: deleting any one
label leaves another bad label. Such covers need not be forced, and (7)
cannot be applied to them. This is exactly where endpoint propagation
can cease to preserve the deletion-good domain.

Even in the unique case, the other endpoint of C is not automatically
deletion-good. C is no longer a maximum-speed arc, so shorter original
arcs can occur inside it. Its endpoints must be checked against the full
family again. The special all-zero statement for m supplies no all-zero
statement for v.

## Second approach: the legitimate finite relation

There is one immediate global consequence of (3). Assign each forced
maximum arc to its larger INDEXED parent I. That parent intersects no
other forced m-arc. To prove this, any forced m-arc meeting I cannot be
contained in I, by its own private point. It cannot contain I because
its length is smaller. Thus it contains an endpoint of I. The original
A already contains Q. No distinct m-arc can contain Q, since same-speed
open arcs are disjoint. The other endpoint P is strictly m-good by (3),
so no m-arc contains it. This excludes every other forced m-arc that
INTERSECTS I; an external tangency is not an intersection of open arcs.

The assignment is therefore injective. With K_v denoting the complete
attained forced indices for each label, one consequence is

    |K_m|<=sum_(v in V, m/2<v<m) |K_v|.                     (8)

The incidence statement is stronger than its count. Neither gives a bound
that contradicts the hypotheses or selects a common replacement frequency.

Define the actual endpoint relation on forced indexed arcs as follows:
an endpoint of A points to B only if B is its UNIQUE original alpha-cover.
Then that endpoint lies in W_(label B), so B is forced. The original
zero-only configuration has A->I at L and I->A at Q, as well as the
corresponding right-parent pair. Thus allowing either endpoint already
has reciprocal edges under the full hypotheses; label height cannot be
strictly decreasing along every such edge.

For an outward walk, follow the other endpoint of the newly reached arc
and test uniqueness anew. The interval orders give strictly ordered
centers on the real lift. The finite circle relation may nevertheless
stop at an endpoint with several covers, or repeat after winding around
the circle. Ordered real lifts are not a well-founded circle potential.
The accepted private-point barriers put forced overlaps only between
cyclic neighbors, but do not exclude such winding cycles. No new cover-cost
or unit-determinant premise is inserted to rule them out.

### An exact existing control for outward height monotonicity

Reuse the native LOCAL control in the parent-reduction manuscript:

    V={1,4,5,11,16}, n=5, alpha=1/6.

At (m,k)=(16,7), the two original endpoint parents are (5,2),(11,5),
with D=3. Its actual private portion is [13/30,29/66]. Reflecting gives
the corresponding zero-only portion at (16,9). Both facts can also be
checked directly from the original endpoint norms; no all-zero assertion
at any other maximum index is made.

There is the following actual UNIQUE-cover outward chain:

    (16,7) -> (11,5) -> (4,2) -> (11,6) -> (16,9).           (9)

Here each pair is (speed, original grid index). All five-label norm checks
at the transition times are given below, in increasing speed order.

| Endpoint time | Five norms | Unique original alpha-cover |
| --- | --- | --- |
| 43/96 | (43,20,23,7,16)/96 | (11,5) |
| 31/66 | (31,8,23,11,32)/66 | (4,2) |
| 13/24 | (11,4,7,1,8)/24 | (11,6) |
| 37/66 | (29,16,13,11,2)/66 | (16,9) |

These times are respectively the right endpoints of the preceding arcs:
(7+alpha)/16, (5+alpha)/11, (2+alpha)/4, (6+alpha)/11.
In each row the preceding label is exactly alpha-good, the displayed
new owner is strictly bad, and every other original label is good.
Thus all reached arcs really are forced, and (9) uses the OTHER endpoint
each time, with no backward step or deleted index. Speeds first decrease
16,11,4 and then increase 11,16.

This tests only the proposed strict decrease of label height from exact
outward uniqueness and actual grid positions. The tuple is LRC-good:
t=1/3 gives norm 1/3 for every original speed. It has no native strict
failure, no asserted full trapping of W_16, and no assumed all-zero
condition beyond the two displayed reflected portions. Thus (9) does
not refute an additional monotone invariant using the missing full-failure
hypotheses essentially. It is one reused exact control, not a new sweep.

Finally, every new endpoint owner in the first approach is an ORIGINAL
retained speed. It is alpha-good throughout W_m, so it cannot itself be
the smaller blocker required to replace m. Common endpoint coverage,
even if available, would concern the wrong points and the wrong badness
property. A new frequency strictly bad on ALL W_m would give the known
minimum-sum descent, but no such frequency is supplied by (5)--(9).

## Disposition, bindings and checks

The new positive implications are (3), the complete new-label endpoint
alternative with (5)--(7), and the injective indexed-parent relation (8).
The first missing step is to continue or exploit the relation when far
endpoints have multiple original covers; those points are outside all
deletion-good sets. Even a chain of unique covers has no proved outward
height potential or common fresh blocker. The control checks the precise
height shortcut, while leaving the actual native implication unrefuted.
No uniform contradiction, one-slot failure transport, or unrestricted
canonical proof is claimed.

The endpoint ranges and incidence theorem were hand-derived here and
checked by root during the bounded task. The two-step determinants and
all four chain rows were hand-checked here. The parent-reduction source
was under independent review at assignment; only its displayed LOCAL
control is reused and checked directly. Its candidate and lcm theorems
are not assumed as supply. Earlier accepted sources retain their scopes.

| Bound input | SHA-256 |
| --- | --- |
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

Current config, workflow, policy and focused state were read. The gate was
research/in_progress with explicit start authorization
`2026-09-05T04:12:25.208107+00:00` and this sole owned path.
`python3 -B scripts/validate_workflow.py` exited 0 with
`workflow structural validation passed; it cannot certify mathematical validity.`
Source bindings used `sha256sum`; full readback and final hash, binding,
newline/whitespace and workflow checks are reported at handoff. No
mathematical program, solver, sweep, build, cache operation, extra agent,
external model, Git/shared-state/memory write or other-file edit occurred.
Independent review remains required; the unrestricted goal is unresolved.
