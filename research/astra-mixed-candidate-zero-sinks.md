# Incoming positive candidates at zero-only maximum gaps

Task `/root/mixed_candidate_zero_sinks`; assigned source checkpoint
`afebb4bfdc5e00b0ac4c756583f812a58271e81d`. Requested route:
`gpt-6-astra/xhigh`; observed model, effort, elapsed time and usage: null.
Only this manuscript is owned. New hand deductions await independent review.

A candidate entering a zero-only gap whose center is still candidate-bad
must pay an explicit directional determinant cost. The actual global
maximum bounds that cost through the two parent/max contact times. This
gives a necessary restriction, not a supply theorem. Candidates already
good at the sink center avoid the restriction. An exact native-good mixed
control realizes that latter behavior with primitive parents and empty
parent-reduction families. Neither tested mechanism yields a uniform
contradiction or a smaller failure.

## 1. Complete hypotheses and the mixed transition

Let V be a hypothetical canonical strict failure of n>=5 positive distinct
integer speeds, least by moving count and then by sum among ALL positive
distinct failures at that count. Its gcd is one. Put

    N=n+1, alpha=1/N, beta=1/n, m=max V, Q=max(V\{m}),
    0<mu=max_(t in R/Z) min_(v in V)||vt||<alpha,
    epsilon=alpha-mu, mu_m=mu-m*epsilon/Q,
    W={t:||vt||>=alpha for every v in V\{m}}.

The same attained global mu is used throughout. Least count supplies a
retained beta-witness and hence nonempty interior of W. The accepted
contraction gives `0<mu_m<mu` and traps ALL of W at `||mt||<=mu_m`.
Let K contain every attained maximum collision index modulo m. For fixed
real lifts write

    A_k=((k-alpha)/m,(k+alpha)/m), W_k=W intersect A_k.

The maximum-owner interval theorem makes each W_k one nonempty closed
interval, possibly a singleton. All of W is the union of these portions;
there is no nearest-index extension outside the original bad arcs.

For every pair of ORIGINAL arcs covering the left and right endpoints of
A_k, with labels a,b and compatible indices l,r, the accepted cancellation
gives a candidate `u=|a+b-m|`. If u>0 it is fresh, u<m, and strictly
alpha-bad on the WHOLE W_k. Let C_k contain every such positive candidate.
Both endpoint-cover families are retained in this definition.

Fix u in C_k. Full sum minimality supplies some t in W with
`||ut||>=alpha`: otherwise replacing m by u leaves a strictly alpha-bad
coordinate at every time, and compactness makes the replacement a smaller
strict failure. Gcd normalization preserves count, distinctness, positivity
and the maximum if needed. The witness need not occur at a prescribed
collision. This task considers the conditional mixed transition where
one such witness is in W_h with C_h empty. It does not infer that every
candidate has a zero-only target or that its target carries a beta-seed.

At this zero-only h the accepted LOCAL conclusions give unique original
parents with labels c,d and indices l_h,r_h:

    c+d=m, l_h+r_h=h, c!=d,
    l_h/c < h/m < r_h/d,
    D=c*r_h-d*l_h=c*h-m*l_h=m*r_h-d*h,
    s=min(c,d), z=D-alpha*m,
    alpha*m<=D<=mu*(m+s)<alpha*(m+s),
    W_h=[(l_h+alpha)/c,(r_h-alpha)/d],
    {mt-h:t in W_h}=[-z/c,z/d].                              (1)

Only these two retained arcs meet A_h. Every other original retained
label is alpha-good throughout A_h. In particular h/m belongs to W_h.
These are local consequences at h; other collisions may be positive.
The assumption that ALL collisions are zero-only, used for globalization
in some bound sources, is unnecessary for (1).

The pending positive escape-cycle manuscript was read as context for
avoiding its carry-cancellation and stronger-seed-domain gaps. Its review
was pending at assignment. No new theorem from that manuscript is needed
here; the inherited transition above follows from the accepted cancellation
and replacement sources directly.

## 2. First attempt: center a candidate escape, charging its parent contacts

First check exactly where the actual global bound enters. With e=mt-h,
the two parent representatives near this gap are

    x=(D+c*e)/m, y=(D-d*e)/m.

At `e_+=D/(m+d)`, the m- and d-norms equal e_+, while the c-norm
equals 2e_+. Strict parent overlap gives `D<alpha*(m+s)`, so
`0<e_+<alpha`; also D>=alpha*m and d<m give 2e_+>alpha.
Since 2e_+<2alpha<1/2, these are actual norms, with no wrap. Every
nonparent norm is at least alpha there because this time is inside A_h.
Thus the full original minimum at this specific time is exactly e_+.
At `e_-=-D/(m+c)` the symmetric full minimum is D/(m+c).
Consequently the SAME actual global maximum satisfies

    mu>=max(D/(m+c),D/(m+d))=D/(m+s).                         (2)

These times need not belong to W: one parent has norm below alpha there.
The derivation uses the global full minimum, not a contraction applied
outside its deletion domain. Equation (2) recovers the accepted contact
bound; it is not by itself new amplification.

Now suppose u is bad at the sink center: `||u*h/m||<alpha`. Choose its
unique nearest integer j and define the SIGNED integral numerator

    R=u*h-m*j, rho=|R|<alpha*m.

On the entire interval (1), the representative of ut-j is
`(R+u*e)/m`. Before excluding either direction, existence of an alpha-good
point in this interval is exactly

    u*z >= min(d*(alpha*m-R), c*(alpha*m+R)).                 (3)

Indeed the phase numerator runs from R-u*z/c to R+u*z/d. Since
`0<=z<alpha*s` and u<m, either endpoint shift has magnitude
strictly below alpha*m. Together with |R|<alpha*m this keeps the
representative in (-2alpha,2alpha), hence strictly inside (-1/2,1/2).
The norm is its absolute value, and (3) tests reaching either CLOSED
alpha boundary. Equality is allowed, with a witness at a W_h endpoint.

The same strict shift bound rules out the farther boundary. If R>0,
reaching -alpha*m would require a shift of alpha*m+R, which exceeds
the available shift. If R<0, reaching +alpha*m is equally impossible.
If R=0, neither boundary can be reached at all. Therefore a center-bad
escape has rho>0 and, with

    p=d when R>0, p=c when R<0,

its exact directional criterion is

    u*(D-alpha*m) >= p*(alpha*m-rho).                         (4)

The candidate cannot be silently reflected without also swapping its
parent direction. Under t->-t, R changes sign and c,d swap, preserving
(3)--(4). Integer time translation preserves R and D.

Combining the necessary (4) with the ACTUAL contact bound (2) yields
the incoming-candidate restriction

    mu >= [alpha*m+(p/u)*(alpha*m-rho)]/(m+s),                (5)

or equivalently

    alpha*m-rho <= (u/p)*[mu*(m+s)-alpha*m].                  (6)

This retains the directional parent and the available determinant excess,
instead of using only the general radius mu_m. Its right-hand side is at
most u*mu_m: use p>=s and
`[mu*(m+s)-alpha*m]/s=mu-m*epsilon/s<=mu-m*epsilon/Q`.
Thus (6) strengthens that elementary radius estimate at this sink.

There is a useful integral form. Set

    Z=N*D-m, A=m-N*rho.

They are integers, with `A>0`, `0<=Z<s`, and (4) is exactly

    u*Z>=p*A.                                                (7)

In particular Z must be positive and

    u>p*A/s>=A.                                              (8)

For g=gcd(m,u), the integer rho is divisible by g, so A is too.
Equation (8) implies u/g>=2; in particular a divisor u of m cannot
make this center-bad escape. This last divisor consequence is the native
alpha version of the existing beta boundary-quantization method, not new
supply. Equations (5)--(7) add the exact directional parent/contact cost.
They can exclude a specified incoming edge, but no argument makes every
actual edge violate them. A singleton z=0 has no center-bad escape.

Root supplied a further integral coupling, checked here. Let
`G=gcd(m,c,u)=gcd(c,d,u)`. This positive integer divides both
`D=c*h-m*l_h` and `rho=|u*h-m*j|`. Moreover

    A+Z=N*(D-rho), D>=m/N>rho,

so D-rho is a positive integer divisible by G and is at least G.
Using (7) gives

    (u+p)*Z >= p*(A+Z) >= N*p*G.

Since Z<s, and since G also divides p, this implies the reduced-pair
restriction

    (u+p)/G > N*p/s >= N,
    (u+p)/G >= N+1.                                          (8a)

Combining the same inequality with
`Z<=N*mu*(m+s)-m` gives a residue-free contact restriction

    mu >= [alpha*m+p*G/(u+p)]/(m+s).                         (8b)

The quantifiers still concern a center-bad incoming escape. Here u is a
fresh replacement and p its directional sink parent; this is not an
assertion about every pair of original labels or a new endpoint-cycle
edge. Equations (8a)--(8b) are consequences of the actual transition and
its contact geometry, not a theorem supplying a transition that violates
them. The global-mu comparison in (8b) retains the full-failure use beyond
local integer geometry.

If instead `||u*h/m||>=alpha`, the center itself is already an escape
witness, including equality. No boundary crossing, positive A, or condition
(4) is required. Centering in that case gives a retained witness where
the old maximum has norm zero, not an original-tuple witness or a repair.
This is the unresolved alternative in the first attempt.

## 3. Second attempt: restart at a sink using its parent reductions

The accepted parent-reduction construction is local enough to apply here.
For parent p with numerator j_p, put

    q_p=p/gcd(p,j_p), B_p=p*m/(N*D+p).

The frequencies whose specified parent-center arc strictly covers the
WHOLE closure of A_h are exactly `q_p|v` and `0<v<B_p`. The farthest
endpoint has distance `(D+alpha*p)/(p*m)` from that parent center,
which proves the strict bound. Since D>=alpha*m, one has B_p<p.
Consequently both primitive parents give an empty such repair family.
This does not characterize every smaller frequency or every repair of W_h.

The tempting continuation claim tested here is that an actual positive
candidate escaping into a zero-only private interval must make at least
one parent reducible, providing another repair from this construction.
The following ONE exact native-width control refutes that local claim.

Take

    V_*={1,5,11,13,16}, n=5, alpha=1/6, m=16.

It is positive, distinct and primitive. At k=4 the maximum endpoints are
23/96 and 25/96. The retained norms, in order 1,5,11,13, are

    left:  (23,19,35,11)/96,
    right: (25,29,13,37)/96.

The threshold is 16/96; hence the unique original endpoint covers are
(13,3) on the left and (11,3) on the right. At center 1/4 the two
nonparent norms are 1/4, larger than their nonintersection bounds 17/96
and 21/96. Other indices of each parent are farther away, and cannot
meet this maximum arc. Intersecting the two parent complements gives
the complete actual private portion

    W_4=[19/78,17/66] subset (23/96,25/96), C_4={8}.

The fresh candidate 8 has representative `8t-2` ranging from -2/39 to
2/33 there, so it is strictly bad on the WHOLE portion.

At h=7 the maximum endpoints are 41/96 and 43/96. The same retained
norms are

    left:  (41,13,29,43)/96,
    right: (43,23,7,17)/96.

Only (5,2) covers the left endpoint and only (11,5) covers the right.
Their labels sum to 16, their indices to 7, and D=3. At center 7/16
the nonparent norms are 7/16 and 5/16, strictly larger than 17/96 and
29/96 respectively. The other parent indices have phase distance at
least 13/16 there, beyond their overlap windows. Thus no additional
retained arc enters A_7, and the complete actual private interval is

    W_7=[13/30,29/66], C_7 empty,
    {16t-7:t in W_7}=[-1/15,1/33].                            (9)

This is a genuine positive-to-zero transition between actual private
arcs, not a raw nearest-index assignment. At 7/16 the 8-norm is 1/2;
in fact it is at least 7/15 on all of (9). Reflection gives the same
transition between indices 12 and 9. No classification of all other
private portions is needed or claimed.

Here `gcd(5,2)=gcd(11,5)=gcd(16,7)=1`. The parent-center thresholds
are B_5=80/23<5 and B_11=176/29<11, so both complete specified-center
families are empty. The parents are prime; their only smaller proper
divisor frequency is 1, which is alpha-good throughout (9). Thus even
allowing a different center for a proper parent divisor gives no repair.

There ARE other possible repairs: for example frequency 2 is strictly
bad on the whole closed A_7, with maximum norm 7/48<1/6. This explicit
check prevents misreading empty parent families as absence of any positive
continuation. It does not make frequency 2 bad on all W; already W_4
contains 1/4, where its norm is 1/2.

Finally, t=1/3 gives norm 1/3 for EVERY original speed in V_*. Thus
the tuple is native LRC-good, and its full W contains an untrapped point
with m-norm 1/3. Its actual mu is at least 1/3, not below alpha. No
hypothetical mu_m, whole-W contraction, full minimum-failure status, or
all-coordinate replacement minimality is assigned to this control.
It refutes only positive local escape plus exact zero-parent geometry
forcing parent reduction. It does not refute a theorem using the absent
canonical full-failure hypotheses essentially. The earlier control
(1,5,6,7,8) is not used as a strict failure or as evidence about zero sinks.

## 4. Bounded disposition and evidence

The first attempt yields the exact directional criterion (4), the
actual-global-margin restrictions (5)--(8b), and the reduced-pair bound
(8a) for center-bad escapes. The
second shows that a center-good escape can coexist with primitive parents
and empty parent-reduction families in an actual native-good mixed local
configuration. No contradiction, common repair, or admissible smaller
failure has been derived under all canonical hypotheses.

The first missing implication is to control those center-good zero sinks,
or the remaining center-bad sinks satisfying (5), using the simultaneous
whole-W and full replacement constraints. Neither the contact bounds nor
the arrival of a candidate forces the needed next repair. Even a fresh
repair at a sink must be bad across ALL attained portions before the
one-slot height argument applies. A graph ending at a zero vertex and
a collection of unrelated local repairs do not establish that condition.
No claim that all continuation mechanisms are impossible is made.

This stops the two bounded attempts. The native boundary method is credited
as a transfer of the existing method; the directional contact restriction
and mixed control were hand-derived here. Root independently checked the
directional criterion and requested the explicit farther-boundary exclusion,
which is included above. New claims still await independent review.
Unrestricted LRC remains unresolved; no successive-count program is proposed.

| Bound input | SHA-256 |
| --- | --- |
| `research/astra-zero-only-maximum-gaps.md` | `f21fc1de78ee9802ecf8992677395507984d26894b220b9890849054077546da` |
| `research/astra-zero-only-maximum-gaps-review.md` | `df1898cb979bc683f172a61e429e9ab48f01f1846bba0821097bdd4979161d4e` |
| `research/astra-forced-cycle-frequency-exchange.md` | `4ac28414ec9043c9ed11d69b7cc8520a2a1acc3b74168147acfc38091959046f` |
| `research/astra-maximum-frequency-exchange-review.md` | `9cd1282b49034073ad59e8df183df7e7b2cc65ce359d8ec8b088c6c032ab9515` |
| `research/astra-positive-candidate-escape-cycles.md` | `d7c8ff0d24f43ce30c272b4eed93686eeaad8b7dfca41449d1f1b22781e7ad49` |
| `research/astra-zero-only-parent-reduction.md` | `9b67661ec12a1b51e6de9405c04f3a0d071b3a5630b6ad772d19da18baf99d71` |
| `research/astra-zero-only-parent-reduction-review.md` | `959a7c42d4a8c37bf9dc50e09ab6b6b00527690b8cfcd76e90848e2f9ebf2a7a` |
| `research/astra-minimal-frequency-synthesis.md` | `03cf038021f0bc1a2328bb77a02f6ab4fe649f5d3626d7bc368a67cd6c7b0000` |
| `research/astra-minimal-frequency-review.md` | `b26182c2e482e7f83480eab9904779b958eb8b8b753c70bc45c6fabec55b747d` |
| `research/astra-strict-core-shell-supply.md` | `5cc9866b3c8a516494ad998355265335a5edd15158cf9701c7d814843b97210e` |
| `research/astra-strict-core-shell-review.md` | `dd733c2910f1f4579846c1c945ecac8e83d140eb29917b81dc11d2b1b119b95f` |
| `.codex/config.toml` | `28212a53cf42cdc377df1f7dab040732d657e59d7bb97ee78791256d01d4bb2c` |
| `docs/project-workflow.md` | `2b42a133352b6b53ba2106fc73882733f176e04a0deffbb183b4c16eefd9cd67` |
| `research/workflow-policy.json` | `833c397b61d1ffdb994fb115019f6d60d6c1a62ff85f19cdd2c9f8ac3a979c8b` |
| `scripts/validate_workflow.py` | `250a3ce2a080f5835ac4fd2e4b2803568424c777cda5d421f9fe92efd34d5383` |

Current instructions, policy and focused state were read. The gate was
research/in_progress with explicit start authorization at
`2026-09-05T04:12:25.208107+00:00` and this sole owned path recorded.
`python3 -B scripts/validate_workflow.py` exited 0 with
`workflow structural validation passed; it cannot certify mathematical validity.`
Full owned readback, fifteen input bindings, final newline/whitespace and
workflow validation are checked at handoff, with the frozen hash reported
separately. Mathematics and rational endpoint values were checked by hand.
Only administrative checks were run: no mathematical program, sweep, solver,
build, cache/dependency operation, extra agent, external model, Git/state/
memory write or other-file edit was performed.
