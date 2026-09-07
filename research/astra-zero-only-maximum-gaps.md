# Zero-only maximum-speed gaps and stronger deletion witnesses

Task `/root/zero_only_maximum_gaps`; assignment checkpoint
`c63ea896f8218dce44ac270883867d7808c01a51`. Requested route: Astra/xhigh.
Observed model, effort, elapsed time and usage: null. Only this manuscript
is owned. These new hand derivations require independent review.

Every maximum-speed private collision portion is a single closed interval.
In the zero-only endpoint branch it contains the exact collision center.
A deletion witness at margin 1/n forces both complementary endpoint owners
above m/n. Centering that witness preserves the stronger margin for every
nonparent speed at least m/n and for every divisor of m. A remaining center
blocker must be a small nondivisor satisfying an explicit residue inequality.
The local centering assertion without that exception is false on an exact
LRC-good control. Neither a uniform contradiction nor a smaller failure is
obtained.

## Hypotheses and retained inputs

Let V be n>=3 distinct positive primitive integer speeds in a hypothetical
canonical strict failure, chosen by least moving count and then least
primitive sum. Put

    N=n+1, alpha=1/N, beta=1/n,
    0<mu=max_(t in R/Z) min_(v in V)||vt||<alpha,
    m=max V, Q=max(V\{m}),
    W_m={t:||vt||>=alpha for every retained v!=m}.

All deletion sets are closed. Least count supplies at least one common
beta-witness for V\{m}, hence a nonempty interval in W_m. Full failure
implies ||mt||<=mu on the ENTIRE W_m. Every attained nearest collision
index k modulo m is retained in K_m. Write

    c=k/m, L=c-alpha/m, R=c+alpha/m,
    A=(L,R), W_(m,k)=W_m intersect A,
    mu_m=mu-m(alpha-mu)/Q,  0<mu_m<mu.

The strict-core result gives |mt-k|<=mu_m throughout W_(m,k). Its argument
uses the whole-time failure: for |s|<(alpha-mu)/Q, all retained norms at
t+s exceed mu, so the m-phase remains in one closed mu-bad component.
Taking endpoint limits contracts its radius by m(alpha-mu)/Q. Positivity
follows because W_m contains an interval. This applies to every point of
every portion, including singleton portions.

The bound cancellation source was under independent review at assignment
and was subsequently accepted without correction in the bound review below.
The particular facts used here are also checked directly: all arcs are original
grid arcs, the maximum arc's endpoints have smaller original covers, and
the zero-only branch has unique complementary endpoint owners. No assertion
about a beta-witness in each collision is imported. Minimum sum also gives,
for every positive u<m, some u-good point in W_m at margin alpha; those
points are not specified to lie in this particular portion or at a center.

## First approach: the exact gap and its stronger-margin restriction

Any original lower-speed alpha-arc B meeting A has greater length than A.
It cannot contain A, because A has an actual private W_(m,k) point. It
cannot be contained in A, by its greater length. Therefore B contains
exactly one of L,R. This is a statement about open intervals, so an arc
merely touching A externally is not an exception. The circle causes no
second intersection component: the two arc lengths sum to at most
2alpha(1+1/m)<1, and their intersecting union has a proper interval lift.
Lifts of B meeting (L,R) therefore have one of the endpoint orders

    B.left<L<B.right<R,       L<B.left<R<B.right.

Both endpoint-cover families are nonempty: the full open alpha-family
covers L and R, while no m-arc does. Let ell be the largest right endpoint
among all left covers and rgt the smallest left endpoint among all right
covers. Every actual private point is between them, so ell<=rgt. Every
other arc meeting A is one of these covers. Consequently

    W_(m,k)=[ell,rgt].                                        (1)

The endpoints are included because the original bad arcs are open. They
are strictly inside A. This proves connectedness only for a MAXIMUM owner;
it does not discard singleton portions or assert anything analogous for
a smaller owner.

Now assume this collision is zero-only: every cross-pair of endpoint
labels a,b has a+b=m. Fixing a label on either side makes the opposite
label unique. Same-label original open arcs are disjoint, so there are
unique endpoint arcs I,J, with lifted centers l/a<c<r/b. Their labels
are distinct: if equal, their center separation is at least 1/a, whereas
their overlap with A would give 1<2alpha(1+a/m)<4alpha<=1.

For a private time put e=mt-k, x=at-l>=alpha, y=r-bt>=alpha.
The strict endpoint overlap bounds give

    x<alpha+(a/m)(alpha+e),
    y<alpha+(b/m)(alpha-e).

Since a+b=m and |e|<alpha, these imply |x-y-e|<alpha.
But x-y-e=k-l-r is an integer. Thus l+r=k, and the common positive
integer determinant is

    D=ar-bl=ak-ml=mr-bk,        D=bx+ay>=alpha*m.

Only I and J meet A. The endpoints L and R are private for a and b,
respectively, so the full strict-core contraction for those owners
(whose largest retained label is m) also applies. At L, the positive
a-residual is (D-a alpha)/m; contraction bounds it by
mu-a(alpha-mu)/m. The right endpoint gives the analogous b bound. Hence

    alpha*m<=D<=mu*(m+min(a,b)).                              (2)

Equation (1) gives the exact formula about c, with z=D-alpha*m>=0:

    W_(m,k)=[(l+alpha)/a, (r-alpha)/b],
    {mt-k:t in W_(m,k)}=[-z/a,z/b].                           (3)

In particular c itself belongs to W_m. No wrap is hidden: (3) uses the
endpoint lifts through L,R; integer time translation changes all lifted
numerators consistently. The equality case z=0 is the allowed singleton.

On this interval

    x=(D+a e)/m,       y=(D-b e)/m.

These are actual norms, not just signed representatives. For example x
is largest at the right endpoint, where (2) gives

    x<=(mu*(m+b)-a alpha)/b
      =2mu-a(alpha-mu)/b<2mu<1/2.

The same argument bounds y; both are already at least alpha. If a point
of (3) is a beta-witness for all retained labels, x,y>=beta, and therefore

    D>=beta*m,
    min(a,b)>=m*(beta/mu-1)>m/n.                              (4)

At c both parent norms equal D/m and are beta-good. If every maximum
collision is zero-only, least count ensures that (4) holds at at least
one of them. It does not ensure (4) at all collisions.

For a nonparent retained speed v, none of its alpha-arcs meets A.
At c the distance to every v-grid center is consequently at least
alpha/m+alpha/v, or

    ||vc||>=alpha*(1+v/m).                                   (5)

The distance assertion follows from disjoint open arcs with radii whose
sum is less than 1/2; equality is permitted. Thus every v>=m/n is
beta-good at c. A beta-seeded zero-only gap can lose the stronger margin
at its center only on a nonparent v<m/n.

Such small labels cannot be excluded by a height comparison. In fact any
actual strict failure must satisfy m>n*min(V): otherwise t=1/(m+min(V))
places every original phase in [alpha,1-alpha]. Thus at least one retained
label is below m/n, while neither parent of a seeded gap can be that label.
This is compatible information, not a contradiction.

## Second approach: exact arithmetic limits on center blockers

Let t0 be a beta-witness in this zero-only gap. Suppose a retained speed v
is beta-bad at c and beta-good at t0. By (4)--(5), v is a nonparent below
m/n. The segment from c to t0 remains in W_(m,k), by (3). It crosses a
beta boundary at some t*!=c, with

    vt*=j+sigma/n,  j in Z, sigma in {1,-1},
    e*=mt*-k=[m(nj+sigma)-n v k]/(n v),
    0<|e*|<=mu_m.                                            (6)

The numerator is a nonzero integer divisible by gcd(m,n v), yielding
|e*|>=gcd(m,n v)/(n v). A stronger simple residue version is available.
Put g=gcd(m,v), M=m/g, Vv=v/g, and define

    d_n(M)=dist(M,nZ) if n does not divide M,
           n          if n divides M.

The numerator in (6), divided by g, is congruent to sigma*M modulo n.
If that congruence is zero its nonzero absolute value is at least n;
otherwise it is at least dist(M,nZ). Therefore any center blocker obeys

    Vv>=d_n(M)/(n*mu_m).                                     (7)

Here d_n(M)>=gcd(M,n)>=1, so in particular Vv> (n+1)/n and Vv>=2.
A divisor v of m, for which Vv=1, cannot be such a blocker. More generally,
a small speed violating (7) preserves beta under this centering operation.
If every small retained speed violates (7), the center is a beta-witness
for the entire retained tuple. This is a sufficient condition, not a supply
theorem for the actual label set.

The residue test uses integer common-time phases. It does not presume a
translation preserving the other labels, nor relocate an arbitrary seed
to an unrelated collision. Even a center good for all retained speeds
has ||mc||=0, and does not by itself witness the original tuple or provide
a positive replacement for the zero frequency a+b-m.

### Exact limitation of local center rounding

The following single control tests the tempting assertion that a zero-only
gap carrying a beta-witness must have a beta-good center. It uses native
widths for its count, but it is NOT an actual strict failure:

    n=6, alpha=1/7, beta=1/6,
    V={2,5,7,22,27,49}, m=49, k=4,
    c=4/49, L=27/343, R=29/343.

In label order 2,5,7,22,27 the exact endpoint norms, with denominator 343,
are

    L: (54,135,154,92,43)/343,
    R: (58,145,140,48,97)/343.

Since alpha=49/343, L is covered only by the original (27,2) arc and R
only by the original (22,2) arc. The m-norm equals alpha at both endpoints.
Their labels sum to 49, their indices sum to 4, and D=27*2-22*2=10.
The three nonparent center norms have numerators (56,140,147)/343,
strictly greater than the respective disjointness bounds
(51,54,56)/343 from (5). No nonparent arc meets A. Directly intersecting
the two parent complements therefore gives the whole portion

    W_(49,4)=[5/63,13/154],
    {49t-4:t in W_(49,4)}=[-1/9,3/22].                        (8)

This also verifies actual privacy of the maximum arc. Other parent-grid
centers have phase distance from c at least 39/49, larger than both
alpha*(1+27/49) and alpha*(1+22/49), so their arcs cannot enter A.
At t0=1/12, which lies in (8), the retained norms are

    (1/6,5/12,5/12,1/6,1/4).

They are all beta-good. At c, however, ||2c||=8/49<1/6. Every other
retained label is beta-good there. The boundary crossing for v=2 is
t*=1/12, with e*=1/12; here M=49,Vv=2,d_6(M)=1, so the integer lower
bound d_6(M)/(6Vv) is attained exactly.

Finally t=1/6 is a full original witness: the six norms are
(1/3,1/6,1/6,1/3,1/2,1/6). Thus the true global maximum is at least
1/6>alpha. No value mu<alpha, whole-time failure transport, minimum-failure
claim, or contraction parameter mu_m is assigned to this control. It
refutes only local zero-only geometry plus a beta-seed implying center
rounding. In particular it does not refute that implication with all
actual minimal-failure hypotheses restored.

## Disposition and checks

The bounded positive results are the maximum-owner interval theorem (1),
the exact zero-only gap (3), the seeded owner restriction (4), and the
small-nondivisor residue restriction (7). The first unresolved implication
in the centering attempt is to handle those remaining small nondivisors
simultaneously using the actual full-failure and coordinate-minimality
data. That simultaneous implication is not supplied by (2), by existence
of a beta-seed somewhere in W_m, or by the individual replacement witnesses.
The tested stronger local assertion is false by (8). Even successful
centering would still need a justified escape or positive one-slot descent;
neither is inferred from m being zero at the center. The present branch
stops at these exact restrictions. No unrestricted LRC proof, disproof,
or hypothesis-complete failure counterexample is claimed.

The endpoint and spread refinements were supplied by root and checked
here; the center-blocker calculation was derived here and root sharpened
its integer bound, which was checked in (6)--(7). All new mathematics,
including the rational control, was hand derived. The prior divisor and
joint-seed sources were read to preserve their weaker-to-stronger endpoint
distinctions; their unproved common-seed transport is not used.

| Bound input | SHA-256 |
| --- | --- |
| `research/astra-forced-cycle-frequency-exchange.md` | `4ac28414ec9043c9ed11d69b7cc8520a2a1acc3b74168147acfc38091959046f` |
| `research/astra-maximum-frequency-exchange-review.md` | `9cd1282b49034073ad59e8df183df7e7b2cc65ce359d8ec8b088c6c032ab9515` |
| `research/astra-minimal-frequency-synthesis.md` | `03cf038021f0bc1a2328bb77a02f6ab4fe649f5d3626d7bc368a67cd6c7b0000` |
| `research/astra-uniform-divisor-minimality.md` | `8c4b6ee094f0f311f360d3abf371e95f731e28cee997d3810dd3218ff6f25746` |
| `research/astra-joint-seed-maximum-audit.md` | `ac73e29474e272167403c91db34331236bb3832f7ce916b2997d7c2f0d6b46ac` |
| `research/astra-strict-core-shell-supply.md` | `5cc9866b3c8a516494ad998355265335a5edd15158cf9701c7d814843b97210e` |
| `research/astra-strict-core-shell-review.md` | `dd733c2910f1f4579846c1c945ecac8e83d140eb29917b81dc11d2b1b119b95f` |
| `.codex/config.toml` | `28212a53cf42cdc377df1f7dab040732d657e59d7bb97ee78791256d01d4bb2c` |
| `docs/project-workflow.md` | `2b42a133352b6b53ba2106fc73882733f176e04a0deffbb183b4c16eefd9cd67` |
| `research/workflow-policy.json` | `833c397b61d1ffdb994fb115019f6d60d6c1a62ff85f19cdd2c9f8ac3a979c8b` |
| `scripts/validate_workflow.py` | `250a3ce2a080f5835ac4fd2e4b2803568424c777cda5d421f9fe92efd34d5383` |

Current config, workflow, policy and focused state were read, including
after compaction. The gate was research/in_progress, with explicit start
authorization `2026-09-05T04:12:25.208107+00:00` and this sole owned path.
`python3 -B scripts/validate_workflow.py` exited 0 with
`workflow structural validation passed; it cannot certify mathematical validity.`
Source bindings were checked with `sha256sum`. Full readback, final bindings
and validation, and the frozen manuscript hash are reported at handoff.
No mathematical program, search, solver, build, cache change, new agent,
external model, Git/shared-state/memory edit, or other-file change was made.
