# Parent reductions repair entire zero-only maximum arcs

Task `/root/zero_only_parent_reduction`; assignment checkpoint
`efc49c3806584c607d98c006927fb116442d9fc0`. Requested route: Astra/xhigh;
observed model, effort, elapsed time and usage: null. Only this manuscript
is owned. The new deductions require independent review.

Every nonprimitive parent of a zero-only maximum arc supplies fresh positive
frequencies strictly bad on the WHOLE closed maximum arc. This includes all
common divisors of the parent speed and its actual lifted numerator. The
result is stronger than repair at a private point, and can apply when the
maximum collision center itself is primitive. A common reduction across
all attained arcs gives a genuine one-slot height descent. No theorem
supplies that common choice or even a nonprimitive parent at every arc.
The exact controls below delimit those gaps; unrestricted LRC is unresolved.

## Hypotheses and accepted zero-only data

Assume n>=3 distinct positive primitive integer speeds V in a hypothetical
canonical strict failure, least by moving count and then primitive sum.
Write

    N=n+1, alpha=1/N, m=max V,
    0<mu=max_(t in R/Z) min_(v in V)||vt||<alpha,
    W_m={t:||vt||>=alpha for every v in V\{m}}.

Least count makes W_m nonempty. Full failure places ALL of it inside the
open m-alpha arcs. Retain every attained nearest index k modulo m in K.
Assume every such maximum arc is zero-only. The accepted source gives
unique original endpoint parents, with fixed real lifts

    l/a < c=k/m < r/b,       a+b=m, l+r=k,
    s=min(a,b), D=ar-bl=ak-ml=mr-bk>0,
    alpha*m<=D<=mu(m+s)<alpha(m+s),                           (1)
    A_k=(c-alpha/m,c+alpha/m),
    W_(m,k)=[(l+alpha)/a,(r-alpha)/b].                        (2)

The labels a,b are distinct and below m. Only these two retained arcs
meet A_k, its private interval is nonempty, and its center belongs to W_m.
Endpoints in (2) are included. These facts concern every attained arc,
not selected centers or a nearest-index extension outside the bad arcs.

The corrected amplification manuscript and its accepted review establish
that `D/(m+s)` is the exact full local contact maximum; they do not improve
(1) or supply global amplification. Their corrected sign after equation
(6) is retained. No such recurrence is used here.

## First approach: a uniform reduction of either parent

Take an integer h>=2 dividing BOTH b and r. Put u=b/h and j=r/h, so
the new u-arc is centered at the SAME rational point as the right parent:

    j/u=r/b,       B_u=(r/b-alpha/u,r/b+alpha/u).

Its radius is h*alpha/b. The farthest point of closure(A_k) from this
right-parent center is the left endpoint, at distance

    D/(bm)+alpha/m=(D+b*alpha)/(bm).

Strict containment in B_u is therefore exactly

    D<alpha(hm-b).                                           (3)

It follows automatically from (1), because s<=a and h>=2:

    D<alpha(m+s)<=alpha(m+a)=alpha(2m-b)<=alpha(hm-b).

The other endpoint is closer and introduces no additional condition.
Equivalently, for every t in the WHOLE closure(A_k), put e=mt-k,
|e|<=alpha. Then

    ut-j=(b e-D)/(hm),
    ||ut||<alpha,
    ||ut||<=(D+b*alpha)/(hm)
          <=alpha-[(alpha-mu)(m+s)]/(hm)<alpha.               (4)

For the last weak estimate, use
`hm-b>=m+s` and `D<=mu(m+s)`. The time-lift interval has been explicitly
contained in one open u-bad component; projection to R/Z preserves it.
Neither an endpoint tangency nor a possible circle wrap is omitted.

The left parent is symmetric. If h>=2 divides both a and l, u=a/h has
center (l/h)/u=l/a, the right endpoint is farthest, and

    D<alpha(hm-a),
    ||ut||<=(D+a*alpha)/(hm)<alpha on closure(A_k).            (5)

Thus every such u is positive and <m/2. It is FRESH: if retained, its
original alpha-arc at the displayed integer center would contain every
point of the nonempty W_(m,k), contradicting old goodness there.
The actual global bound in (1) supplies the quantitative margin in (4);
strict containment alone already follows from the two strict parent
overlaps `D<alpha(m+s)`. Global failure will be essential for transporting
these local repairs over all times.

Use `gcd(p,j)=gcd(p,|j|)>0` for p>0, including gcd(p,0)=p. Integer
translation of time changes (k,l,r) to (k+mz,l+az,r+bz), preserving the
two parent gcds and every candidate speed. Reflection negates the lifted
indices and swaps the parents; the gcds and candidate speeds are again
unchanged. No claim that k itself is primitive is needed.

### Divisor reductions and the full family at either parent center

Write

    g_a=gcd(a,l), q_a=a/g_a,    g_b=gcd(b,r), q_b=b/g_b.

All divisors and candidate frequencies below are positive integers. The
complete family of proper DIVISOR reductions that keep a parent center is

    P_k={a/h:h|g_a,h>=2} union {b/h:h|g_b,h>=2}
       ={u:u|a,q_a|u,u<a} union {u:u|b,q_b|u,u<b}.            (6)

Every member repairs closure(A_k) by (4)--(5). In particular P_k is empty
exactly when both parents are primitive. The two parent gcds divide D,
since D=ar-bl. Consequently D=1 is one sufficient condition for emptiness;
D>1 does not force nonemptiness.

There are also same-center candidates that need not divide the parent
speed. For parent p with index j and q=p/gcd(p,j), its rational center
j/p is an original grid center for frequency u exactly when q divides u.
Define

    B_p=alpha*p*m/(D+alpha*p)=p*m/(N*D+p).

The farthest endpoint of closure(A_k) is at distance
`(D+alpha*p)/(p*m)` from that parent center. Therefore the COMPLETE family
of frequencies whose arc at EITHER parent center covers closure(A_k) is

    R_k={u:q_a|u, 0<u<B_a} union {u:q_b|u, 0<u<B_b}.         (6a)

The inequality is strict because the target is closed and the covering
arc open. Sufficiency and necessity both use that specified parent-center
arc; no different grid center is substituted. The chosen parent lift is
the nearest unit translate throughout A: its farthest endpoint distance is
less than `alpha/p+2alpha/m<=5/12<1/2`, using s<=p, p>=1 and m>=3.
Thus a circular wrap cannot add another containment case. Equation (1) gives

    p/2<B_p<=p*m/(m+p)<m/2,       B_p<p.                     (6b)

For the first bound use D<alpha(m+s) and s<=m-p, so
D+alpha*p<2alpha*m. For the others use D>=alpha*m and p<m.
Thus all R_k members are fresh and below m/2, by the same privacy argument.
All P_k members belong to R_k. The family R_k is nonempty exactly when
at least one parent is nonprimitive: then q<=p/2<B_p, whereas primitive
q=p exceeds B_p. Divisibility into p is NOT required in (6a).

For completeness, a proper divisor of a parent need not preserve its
center. The exact family of ALL whole-closed-arc divisor repairs contains P_k:

    P_hat_k={p/h:p in {a,b}, h|p, h>=2,
                 dist(pk,hm Z)+alpha*p<alpha*h*m}.            (7)

Indeed the u=p/h phase of closure(A_k) is a connected interval centered
at pk/(hm), with radius alpha*p/(hm). It is inside an open alpha-bad
component exactly when the inequality in (7) holds. Thus (7) is necessary
and sufficient for this specified whole-closure repair, including endpoints;
it is not asserted necessary for repair of the smaller W_(m,k).
Every member is fresh, below m/2, and P_k is a subset of P_hat_k.

Small division factors give no additional noncoincident candidates. If
h does not divide the corresponding parent index j (l or r), then (1)
and N>=4 imply D<m/2, and

    dist(pk,hm Z)>=m-D.

This follows from `pk=mj+D` or `mj-D`, since every nonzero integer
j-hz has absolute value at least one. If (7) held, it would give

    m<D+alpha(hm-p)<alpha((h+1)m+s-p)<=alpha(h+1)m.

Hence h>=N. For 2<=h<N, a whole-closure parent-divisor repair must therefore
preserve the parent center and is already in (6). Large h may satisfy
(7), but no supply of them is proved. The predicate in (7) is an exact
checkable characterization, not a new global selection theorem.

## Second approach: what full minimum sum forces globally

These candidate families satisfy

    P_(m-k)=P_k, R_(m-k)=R_k, P_hat_(m-k)=P_hat_k.            (8)

For P and R this follows from the gcd invariance, with D and the parent
labels preserved. For P_hat, h|p implies pm is a multiple of hm; reflection
therefore negates pk modulo hm and preserves the distance. The same
reflection maps all of W_(m,k) to the reflected portion.

If a positive u lies in every R_k union P_hat_k, it is strictly alpha-bad
on ALL W_m by (4)--(7). Outside W_m some retained label is already strictly alpha-bad.
Replacing m by u therefore leaves no closed-alpha witness anywhere on
R/Z. Continuity and compactness make its attained maximum strictly below
alpha. Freshness preserves n distinct positive speeds. Dividing by the
new tuple's gcd preserves this maximum, because integer multiplication
of time is onto R/Z, and gives a primitive tuple of strictly smaller sum.
This contradicts minimum sum. Consequently an actual minimum must satisfy

    intersection_(k in K) (R_k union P_hat_k) empty,           (9)

and in particular each separate family has empty global intersection.

The positive result is the repaired whole arc supplied locally, followed
by this genuine conditional descent. Equation (9) does not supply its
opposite. A single reflection pair with a nonempty R union P_hat already gives
a contradiction; several orbits need a common speed across them.
For any local candidate u, minimum sum supplies an alpha-good u-point
elsewhere in W_m. Its attained arc is one where u is not in R union P_hat.
Those individual escape witnesses do not locate a new common reduction.

For the full parent-center family (6a), coherence has an exact description.
Choose one parent p_k with lifted index j_k at each k, and put

    q_k=p_k/gcd(p_k,j_k), L0=lcm_(k in K) q_k,
    B_k=p_k*m/(N*D_k+p_k).

A common repair centered at one parent per arc exists if and only if some such
choice satisfies

    L0<min_(k in K) B_k.                                    (10)

For sufficiency choose u=L0: it is a multiple of every q_k and below
every strict coverage threshold. For necessity, a common u chooses a
parent at each k with q_k|u and u<B_k; then L0|u and L0<=u<min B_k.
No divisibility into the p_k is needed. Thus minimum sum rules out every choice satisfying
(10). It does not prove that such a choice exists. Keeping several
different repair frequencies instead can increase moving count, and is
not the required one-slot descent.

This differs from reducing the maximum center itself. That older operation
uses a common divisor of m and k, and retains center k/m. Here the new arc
retains a DIFFERENT parent center l/a or r/b and expands far enough to
contain closure(A_k). The parent candidate can exist even when gcd(m,k)=1.
The positive-coherence control from the accepted preceding pass concerns
different candidate sets; it warns against inferring common supply, but is
not itself a counterexample to coherence of these parent families in the all-zero branch.

## Exact controls and their limitations

### Parent reduction supplies the missing repair in the complete working-width example

Use the accepted full control V={1,3,4,7}, native alpha_0=1/5, and a
SEPARATE working width 1/5<delta<1/4. Its actual maximum is 1/5 and its
whole retained delta-good set is

    J_delta=[(1+delta)/3,(2-delta)/4] and its reflection.

These are exactly the private portions at k=3,4 for m=7. At k=3 the
unique original parents are (a,l)=(3,1), (b,r)=(4,2), with D=2;
reflection swaps them at k=4. Thus

    gcd(7,3)=gcd(7,4)=1,       P_3=P_4=R_3=R_4={2}.

For R, the primitive parent 3 gives no candidate; the parent 4 has
q=2 and threshold `28/(2/delta+4)` strictly between 2 and 7/3.

The parent-4 reduction has new center 1/2, and its bound on BOTH whole
closed maximum arcs is

    ||2t||<=(2+4delta)/14=(1+2delta)/7<delta.

The last strict inequality is exactly delta>1/5. So the common reduction
repairs all W_delta and replaces 7 by 2, yielding the smaller tuple
{1,2,3,4} with test-width failure. This gives the geometric origin of the
previously accepted full-W repair, even though neither maximum collision
center has a proper same-center reduction. The original control fails
replacement minimality at delta, and has equality, not strict failure,
at its native threshold. At delta=1/5 the displayed closure bound loses
strictness and the native W gains the isolated points 1/5,4/5, where
||2t||=2/5. No native global repair is inferred.

### Native local zero-only arithmetic need not supply any parent reduction

Take the positive distinct primitive tuple

    V={1,4,5,11,16}, n=5, alpha=1/6,
    m=16,k=7, a=5,l=2,b=11,r=5,D=3.

Here all three centers are primitive:
`gcd(16,7)=gcd(5,2)=gcd(11,5)=1`. Also
`alpha*m=8/3<=3<7/2=alpha(m+min(a,b))`.
The maximum-arc endpoints are L=41/96 and R=43/96. The retained norms,
in label order 1,4,5,11, are

    L: (41,28,13,29)/96,
    R: (43,20,23,7)/96.

Only the original (5,2) arc covers L and only the original (11,5) arc
covers R, because alpha=16/96. The nonparent center norms at c=7/16
are 7/16 and 1/4, greater than the corresponding nonintersection bounds
17/96 and 5/24. No other parent arc can enter A: their signed center
distances in parent phase are 3/16 from the displayed indices and at
least 13/16 from any other index, beyond the required overlap windows.
Thus direct intersection of the two parent complements gives the entire
actual private portion

    W_(16,7)=[13/30,29/66],
    {16t-7:t in W_(16,7)}=[-1/15,1/33].                      (11)

It is nonempty and lies strictly inside A. P_7, R_7 and P_hat_7 are empty:
the parents are primitive, and the only proper divisor of either prime
parent speed is u=1, which is alpha-good throughout (11). In particular
D>1 and a primitive maximum center do not force nonprimitive parents or
some other whole-arc proper-parent-divisor repair.

The full tuple is LRC-good: t=1/3 gives norm 1/3 for EVERY original label.
This is a native-width LOCAL control. No assertion is made that every
maximum arc is zero-only, or that its full deletion set is globally trapped,
or that the tuple has minimum-failure status. It refutes supply from the
displayed local zero-only arithmetic and actual privacy alone, not supply
using the missing canonical global hypotheses.

The accepted consecutive family {1,...,m}, at the larger working width
1/(m+1)<delta<1/m, separately shows that empty coincident-parent families
can persist across a COMPLETE all-zero configuration: its two parent
determinants at every primitive maximum center are 1. Both parent gcds
therefore equal 1, so all P_k and R_k are empty. The tuple has the absolute
minimum primitive sum for its fixed count. Its native maximum is 1/(m+1);
the working width is not the canonical strict-failure threshold. This
reuses the bound source's exact family without a new search or a claim
about P_hat at its noncanonical width.

## Disposition, bindings and actual checks

The established new local result is (3)--(6b): nonprimitive parents supply
fresh reductions repairing entire CLOSED maximum arcs strictly. Equations
(7) and (10) describe further local checks and exact parent-center coherence,
while (9) is a valid minimum-sum consequence. Neither a nonempty family
at every actual arc nor a common reduction across all arcs was derived
from native strict failure. The first unresolved implication is precisely
that global supply, or a contradiction from its absence using additional
canonical information. The controls establish their explicitly limited
failures of local or noncanonical supply; none is an LRC counterexample.

Root supplied the initial parent-containment observation, the full
parent-center extension and its lcm criterion, and the native primitive-parent
control. They were checked here. The all-common-divisor extension, exact
noncoincident divisor predicate and its h>=N restriction were derived here.
The accepted amplification source is bound only in its
corrected form. No new claim has been independently reviewed yet.

| Bound input | SHA-256 |
| --- | --- |
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

Current config, workflow, policy and focused state were read; the gate was
research/in_progress with explicit start authorization at
`2026-09-05T04:12:25.208107+00:00` and this sole owned file.
`python3 -B scripts/validate_workflow.py` exited 0 with
`workflow structural validation passed; it cannot certify mathematical validity.`
Mathematics was checked by hand. Full owned readback, all source bindings,
newline/whitespace and final workflow validation are checked at handoff.
No mathematical program, sweep, solver, build, cache operation, extra agent,
external model, Git/state edit, memory write or other-file edit was used.
Independent review remains required; the unrestricted goal remains unresolved.
