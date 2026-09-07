# Independent review: zero-only parent reductions

Task `/root/zero_only_parent_reduction_review`; assigned source checkpoint
`f102e7ec81958ef064555f1b470499b5a075fe72`. Requested route:
`gpt-6-astra` / `xhigh`, the existing in-session independent review route.
Observed model, effort, elapsed time and usage: null. This review is the
sole owned file; root owns state and publication.

**Accepted without correction** for author SHA-256
`9b67661ec12a1b51e6de9405c04f3a0d071b3a5630b6ad772d19da18baf99d71`.
The parent reductions cover entire closed maximum arcs with a strict
margin. The specified-parent-center family, its lcm coherence criterion,
and the proper-parent-divisor residual predicate are exact within their
stated domains. A common candidate gives a genuine conditional descent.
Neither common supply nor a contradiction from its absence is established.
The controls respect that distinction and give no LRC counterexample.

## Hypotheses, inherited scope and the divisor margin

The argument assumes a hypothetical canonical strict failure V of n>=3
distinct positive primitive integer speeds, least by moving count and then
primitive sum. Put N=n+1, alpha=1/N, m=max V, and
0<mu=max_t min_(v in V)||vt||<alpha. Lower-count validity supplies a
nonempty whole deletion set W_m, and full failure traps ALL of that set
inside the open m-alpha arcs. Every attained index is retained in K.
The assumption is zero-only at every such actual arc, with the original
endpoint parents, not at selected nearest indices outside the bad arcs.

The accepted inputs supply fixed lifts and the exact data

    l/a < k/m < r/b, a+b=m, l+r=k, s=min(a,b),
    D=ar-bl=ak-ml=mr-bk>0,
    alpha*m<=D<=mu*(m+s)<alpha*(m+s),
    A_k=(k/m-alpha/m,k/m+alpha/m),
    W_(m,k)=[(l+alpha)/a,(r-alpha)/b].

The parents are distinct and smaller than m; W_(m,k) is nonempty and
closed; its center is retained-good. The earlier reviewed full-contact
identity D/(m+s) does not strengthen the displayed bound on D. The
amplification input is bound in its corrected form; its previously rejected
sign sentence is not reused. The other unchanged inputs retain their
earlier reviewed scopes, including the distinction between whole W_m and
a larger collection of nearest-index portions.

For h>=2 dividing both b and r, let u=b/h and j=r/h. The right-parent
center j/u=r/b is an actual u-grid center. For |e|<=alpha, e=mt-k,

    ut-j=(b e-D)/(h m),
    max_(closure A_k) |ut-j|=(D+alpha*b)/(h m).

The farthest point from this center is the left endpoint. Thus the whole
closed time interval is contained in the displayed open u-bad component
exactly when D<alpha*(h*m-b). This holds because

    D<alpha*(m+s)<=alpha*(m+a)=alpha*(2m-b)
      <=alpha*(h*m-b).

Moreover h*m-b>=m+s and D<=mu*(m+s) give the quantitative margin

    alpha*h*m-D-alpha*b
      >=alpha*(m+s)-D>=(alpha-mu)*(m+s)>0,
    ||ut||<=(D+alpha*b)/(h*m)
           <=alpha-(alpha-mu)*(m+s)/(h*m)<alpha.

For the left parent the corresponding phase is
ut-j=(D+a e)/(h m); its right endpoint is farthest and the same proof
uses h*m-a>=m+s. These are estimates on closure(A_k), including both
endpoints, and not merely on its smaller private interval. They exhibit
one real open bad component containing the entire interval. Projection
to the circle preserves containment and its strict endpoints.

Each u is positive and u<=p/2<m/2 for its parent p. If u were already
retained, its norm would be at least alpha on the nonempty W_(m,k),
contradicting this strict bound there. Thus freshness follows from actual
privacy; it is not an extra arithmetic assumption. The same argument will
apply to every later whole-arc candidate.

Integer time translation changes a parent index j to j+p*z. With
gcd(p,j)=gcd(p,|j|), including gcd(p,0)=p, its gcd and reduced denominator
are invariant. Reflection t->-t swaps the parents and negates their
indices, preserving their gcds, D and all candidate frequencies. There is
no required primitivity of the maximum center k/m.

## Exact center-preserving families and circle boundaries

For a parent (p,j), write g=gcd(p,j) and q=p/g. The two descriptions of
proper divisor reductions agree:

    {p/h:h|g,h>=2}={u:u|p,q|u,u<p}.

Indeed p=qg, so h|g gives u=q(g/h). Conversely u=qv dividing p implies
g=v*h with h=p/u, and u<p makes h>=2. Thus P_k in (6) is the complete
family of proper parent divisors preserving one of the two parent centers.
It is empty exactly when both parent gcds are one. Both gcds divide D
by D=ak-ml=mr-bk, so D=1 forces emptiness. The converse is not asserted.

For arbitrary positive integer u, j/p is a u-grid center exactly when
uj/p is an integer, equivalently q|u. The distance from that fixed parent
center to the farthest endpoint of closure(A_k) is

    d_p=(D+alpha*p)/(p*m).

The specified parent-center arc of radius alpha/u covers this closed
interval exactly when u*d_p<alpha. Hence its complete family is

    q|u, 0<u<B_p, B_p=alpha*p*m/(D+alpha*p)=p*m/(N*D+p).

Taking the union over the two parents is precisely R_k. These frequencies
need not divide p. The characterization concerns the arc at that specified
rational center; it does not classify arbitrary smaller frequencies whose
different grid components might repair the private interval.

For necessity on the circle, the chosen real parent lift is the nearest
unit translate throughout A_k. Indeed, using s<=p,

    d_p<alpha/p+2alpha/m<=1/4+1/6=5/12<1/2.

The same bound holds on the closure, because the farthest endpoint was
included in d_p and the first inequality is strict. Since alpha/u<=1/4,
a different unit translate cannot add a circular containment case. If
u=B_p, the farthest endpoint is exactly on the open arc's boundary and
is not covered. This is why the threshold in R_k is strict.

The threshold bounds in (6b) also hold with the stated directions:

    D+alpha*p<alpha*(m+s+p)<=2alpha*m
      implies B_p>p/2;
    D+alpha*p>=alpha*(m+p)
      implies B_p<=p*m/(m+p)<m/2 and B_p<p.

Here s<=m-p and p<m. Every R_k candidate is therefore positive, fresh
and below m/2. A proper common-divisor reduction has u<=p/2<B_p, proving
P_k subset R_k. If g>=2, the smallest multiple q<=p/2 is already a
candidate. If g=1, every positive q-multiple is at least p>B_p. Thus R_k
is nonempty exactly when at least one parent is nonprimitive, as claimed.

## Proper divisors at other grid centers

Fix a parent p and h|p, h>=2, but do not assume h|j. For u=p/h, the phase
image of closure(A_k) is the connected closed interval with center
pk/(h*m) and radius alpha*p/(h*m). The preimage of ||x||<alpha is a
disjoint union of open intervals centered at integers. A connected interval
lying wholly in that union must lie in a single component. Consequently
whole-closure repair is equivalent to

    dist(pk,h*m*Z)+alpha*p<alpha*h*m.

This proves both directions of (7), including its strict endpoints and
possible phase wrapping. It characterizes ALL such proper-parent-divisor
whole-arc repairs, not repair only on W_(m,k). Every member is fresh and
below m/2. The already proved coincident-center containment gives
P_k subset P_hat_k. No inclusion between all of R_k and P_hat_k is needed.

If h does not divide j, every j-h*z is a nonzero integer. Since
pk=m*j+D or m*j-D,

    |pk-h*m*z|>=m*|j-h*z|-D>=m-D.

The bound D<alpha*(m+s), s<=m/2 and alpha<=1/4 implies D<m/2, so this
is positive. If the residual predicate held, it would force

    m<D+alpha*(h*m-p)
      <alpha*((h+1)*m+s-p)<=alpha*(h+1)*m.

Thus N<h+1, and integrality gives h>=N. The weak/strict endpoints are
essential: h=N-1 is excluded. For 2<=h<N, the division factor h of an
admissible whole-closure repair must divide the parent index as well;
the candidate therefore already belongs to P_k. The manuscript makes no
supply claim for the remaining large h.
This restriction uses the native alpha=1/N; it must not be imported
unchanged into a control at a different working width.

## Reflection, whole-time descent and the lcm condition

Reflection sends k to m-k modulo m and W_(m,k) to the corresponding
reflected portion. P and R are preserved by the parent swap, gcd and D
invariance. For P_hat, p*(m-k)=p*m-p*k, and h|p makes p*m a multiple
of h*m. Hence the residual distance is preserved too. The same divisibility
also proves invariance under changing the integer lift of k.

Suppose one positive u belongs to R_k union P_hat_k for EVERY k in K.
The union of all the corresponding portions is the whole W_m, so u is
strictly alpha-bad everywhere on W_m. Outside W_m some retained label
is already strictly bad. The replacement tuple therefore has no closed-
alpha witness at any time. Its minimum-norm function is continuous on
the compact circle and everywhere less than alpha, so its attained maximum
is strictly less than alpha. No bound of that maximum by the original mu
is required or inferred.

Freshness preserves n distinct positive integer speeds, and u<m/2<m
strictly reduces the sum before normalization. Dividing by the replacement
gcd preserves its maximum: multiplication of circle time by that positive
integer is onto. The resulting primitive tuple has strictly smaller sum
than V, contradicting the assumed minimality. This proves the empty
intersection conclusion (9); it supplies no reverse nonemptiness theorem.

If K consists of a single reflection orbit and its local family is
nonempty, invariance gives a common candidate and this descent. Multiple
orbits require one common frequency. For an individual local candidate, minimality supplies
an alpha-good replacement witness in W_m; that point must belong to an
attained arc where the frequency is absent from R union P_hat. These
separate witnesses do not identify a common repair.

For R alone, choose one parent at each of the finitely many nonempty
portions, and put q_k=p_k/gcd(p_k,j_k),
B_k=p_k*m/(N*D_k+p_k), and L0=lcm_k q_k. If

    L0<min_k B_k,

then u=L0 belongs to the specified parent family at every k. Conversely,
a common u in every R_k selects such a parent at each k; all q_k divide
u, so L0 divides u and 0<L0<=u<min_k B_k. This proves the exact existential
parent-choice criterion (10). The comparison remains strict at equality.
Divisibility of u into the parent labels is not used, and the criterion
is not asserted for the larger union with P_hat. No choice satisfying it
has been supplied from the canonical failure hypotheses.

## Exact controls

For V={1,3,4,7} at a separate 1/5<delta<1/4, the previously reviewed
complete deletion set is J_delta and its reflection, where

    J_delta=[(1+delta)/3,(2-delta)/4].

Its actual private indices are exactly 3 and 4. At index 3 the parents
are (3,1) and (4,2), with D=2; reflection swaps them at index 4. Both
maximum-center gcds are one, while the parent-4 gcd is two. Thus P_3=P_4
is {2}. For R, the primitive parent 3 supplies nothing. The parent-4
threshold is

    B_4=28/(2/delta+4), 2<B_4<7/3.

The inequalities follow directly from 1/5<delta<1/4. Its positive
q=2 multiples below the threshold consist only of 2. Therefore all four
displayed families P_3,P_4,R_3,R_4 equal {2}.

The common reduced center is 1/2. On BOTH closed maximum arcs,

    ||2t||<=(2+4delta)/14=(1+2delta)/7<delta,

with the last inequality equivalent to delta>1/5. This is stronger in
domain than the prior whole-W estimate and gives the same complete
replacement {1,2,3,4}. The accepted original extrema are mu=1/5 and
deletion maximum 2/7, so the original tuple is strictly bad at the chosen
working delta and equality-good at its native threshold. At native
delta=1/5 the closure bound loses strictness, and the full retained good
set gains the isolated points 1/5,4/5, where ||2t||=2/5. No native global
repair or primitive reduction of the centers 3/7,4/7 is inferred.

For the native LOCAL control V={1,4,5,11,16}, n=5, alpha=1/6, the data
m=16,k=7,(a,l)=(5,2),(b,r)=(11,5) give D=25-22=3 and
8/3<=3<7/2. The two maximum-arc endpoints are 41/96 and 43/96.
I checked all retained norms in label order:

| Endpoint | Speed 1 | Speed 4 | Speed 5 | Speed 11 |
| --- | --- | --- | --- | --- |
| 41/96 | 41/96 | 28/96 | 13/96 | 29/96 |
| 43/96 | 43/96 | 20/96 | 23/96 | 7/96 |

With alpha=16/96, only (5,2) covers the left endpoint and only (11,5)
covers the right. The speed-16 norm equals alpha at both, hence is not
an open endpoint cover. At c=7/16 the two nonparent norms are 7/16 and
1/4, strictly greater than alpha*(1+1/16)=17/96 and
alpha*(1+4/16)=5/24. The norm Lipschitz bound therefore keeps these labels
strictly alpha-good on the whole closed maximum arc.

For each parent its displayed index has phase distance 3/16 at c; any
other integer index has distance at least 13/16. The overlap thresholds
are alpha*(1+5/16)=21/96 and alpha*(1+11/16)=27/96, both smaller than
13/16. No other parent arc enters. Intersecting the two parent complements
thus gives the ENTIRE actual private portion in this arc:

    [(2+1/6)/5,(5-1/6)/11]=[13/30,29/66],
    16t-7 in [-1/15,1/33].

This is a nonempty closed interval strictly inside the maximum arc. The
three gcds gcd(16,7), gcd(5,2), gcd(11,5) all equal one, so P_7 and R_7
are empty. Each parent speed is prime; the only candidate proper-divisor
frequency for P_hat is 1. It is alpha-good throughout this private interval,
so cannot repair the whole closure. Thus P_hat_7 is also empty.

At t=1/3 all five original labels have norm 1/3, by their nonzero residues
modulo three. This certifies full LRC goodness and prevents assigning the
control a global strict-failure maximum. The example disproves local supply
from the displayed zero-only arithmetic and actual privacy, even with D>1;
it does not claim a globally trapped deletion set or all-zero status at
every other arc.

Finally the cited consecutive family V={1,...,m}, m>=3, at
1/(m+1)<delta<1/m has actual maximum 1/(m+1): the shortest circular gap
among 0,t,...,mt supplies an available nonzero difference speed of norm
at most that value, and t=1/(m+1) attains it. Nonprimitive maximum centers
have a smaller reduced-denominator arc containing their m-arc; primitive
centers have every retained norm at least 1/m>delta and are private.
These are exactly the attained maximum arcs.

At a primitive k/m every endpoint determinant is a positive integer
less than delta*(m+p)<2, hence one. The unique endpoint labels solve
pk=1 and pk=-1 modulo m and are complementary; their actual parents
therefore have gcd one. This is the accepted complete all-zero family.
It gives P_k empty at all arcs. R_k is empty as well: for a primitive
parent q=p, its raw working-width threshold is
delta*p*m/(1+delta*p)<p because delta*(m-p)<1. Thus no positive
q-multiple qualifies, without transferring a native-width estimate to
delta. The tuple has the absolute minimum sum for its count, but its
native maximum equals its native threshold. It refutes the asserted
broader supply of coincident parent reductions only. The manuscript makes
no claim about P_hat at this noncanonical width, and neither do I.

## Remaining implication and check receipt

The new results prove local whole-closure repair, exact candidate-family
descriptions and a conditional one-slot descent. They do not establish
either a nonprimitive parent at every actual arc or compatible candidates
across all arcs under native strict failure. The first unresolved implication
is precisely that global supply, or a contradiction from its absence using
additional canonical information. The earlier positive-coherence control
concerns different candidate sets and is not silently reused as a
counterexample to these parent families. No recurrence, uniform selection
theorem, Lean implementation, or unrestricted LRC proof/disproof is accepted
by this review.

I fully read the frozen author. Previously reviewed unchanged inputs were
reused at their accepted scopes and checked against current hashes; the
invoked consecutive-family source passage was also read directly. All
fourteen current bindings follow, including the author and its thirteen
inputs. No changing workflow-state hash is treated as mathematical evidence.

| Bound source | SHA-256 |
| --- | --- |
| `research/astra-zero-only-parent-reduction.md` | `9b67661ec12a1b51e6de9405c04f3a0d071b3a5630b6ad772d19da18baf99d71` |
| `research/astra-zero-only-maximum-gaps.md` | `f21fc1de78ee9802ecf8992677395507984d26894b220b9890849054077546da` |
| `research/astra-zero-only-maximum-gaps-review.md` | `df1898cb979bc683f172a61e429e9ab48f01f1846bba0821097bdd4979161d4e` |
| `research/astra-zero-only-deletion-amplification.md` | `a28465087b02b4763833ffa43263a899b4db262f076b60dffd2342d9a51b5ba0` |
| `research/astra-zero-only-deletion-amplification-review.md` | `ef37fc563a75ea59b5b57b9fd3af43b3f09f7763971059268cf7878cfa8ffdb4` |
| `research/astra-positive-candidate-coherence.md` | `a5c01c2ebbaa8b008787f61e9ec51aa1fcc2e01c7865409d775af0a5e5b8beea` |
| `research/astra-positive-candidate-coherence-review.md` | `5624364765087862f67f41b24e8c5ea0c7d5a08fa7ff449a00b799f9707bbc67` |
| `research/astra-forced-cycle-frequency-exchange.md` | `4ac28414ec9043c9ed11d69b7cc8520a2a1acc3b74168147acfc38091959046f` |
| `research/astra-maximum-frequency-exchange-review.md` | `9cd1282b49034073ad59e8df183df7e7b2cc65ce359d8ec8b088c6c032ab9515` |
| `research/astra-minimal-frequency-synthesis.md` | `03cf038021f0bc1a2328bb77a02f6ab4fe649f5d3626d7bc368a67cd6c7b0000` |
| `.codex/config.toml` | `28212a53cf42cdc377df1f7dab040732d657e59d7bb97ee78791256d01d4bb2c` |
| `docs/project-workflow.md` | `2b42a133352b6b53ba2106fc73882733f176e04a0deffbb183b4c16eefd9cd67` |
| `research/workflow-policy.json` | `833c397b61d1ffdb994fb115019f6d60d6c1a62ff85f19cdd2c9f8ac3a979c8b` |
| `scripts/validate_workflow.py` | `250a3ce2a080f5835ac4fd2e4b2803568424c777cda5d421f9fe92efd34d5383` |

Current config, workflow, policy and focused state were read. The gate was
research / in_progress with explicit start authorization
`2026-09-05T04:12:25.208107+00:00` and the recorded sole owned review path.
`python3 -B scripts/validate_workflow.py` exited 0 with
`workflow structural validation passed; it cannot certify mathematical validity.`
Hand derivations, file reads and administrative SHA-256 checks were used.
Full owned-file readback, final source-binding/whitespace/newline checks,
workflow validation and the frozen review hash are reported at handoff.
No mathematical program, sweep, solver, build, dependency/cache operation,
additional agent, external model, Git/state/memory write or other-file edit
was performed. The optional Lean inventory was not needed for this bounded
mathematical review.
