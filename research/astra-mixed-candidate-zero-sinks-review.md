# Independent review of mixed positive candidates and zero-only sinks

Task `/root/mixed_candidate_zero_sinks_review`; reviewer session
`/root/coordinate_cancellation_review`; assigned checkpoint
`f34b3bbaec88672616b4a6acd7fe8b30dc47a590`. Requested route:
`gpt-6-astra/xhigh`; observed model, effort, elapsed time and usage: `null`.
Only this review is owned.

**Accept the complete frozen manuscript below without correction.** The
zero-only interval and contact argument are local and remain valid in the
mixed branch. The directional boundary criterion, integral restrictions
and residue-free lower bound on the actual global maximum are sound.
The exact control refutes only the stated local parent-reduction shortcut;
it is native LRC-good. Neither a uniform descent nor a contradiction under
full canonical strict failure is proved. No kernel theorem is claimed.

## Hypotheses and the local zero-only interval

Assume n>=5 distinct positive integer speeds V, least first by moving
count and then sum among ALL same-count strict failures. This implies
primitivity. Set N=n+1, alpha=1/N, beta=1/n, m=max V, Q=max(V\{m}),
and use the single actual maximum
`0<mu=max_t min_(v in V)||vt||<alpha`. Retain the full closed deletion
set W for m and every attained collision index. The accepted contraction
gives `|mt-k|<=mu_m=mu-m(alpha-mu)/Q<mu`; positivity of mu_m follows
from the interval in W supplied by a stronger beta deletion witness.

For any attained maximum arc A_h, a retained arc meeting it is longer.
It cannot contain A_h because A_h has a private point, and cannot lie
inside A_h because it is longer. Their total length is less than one,
so a common proper interval lift exists. Consequently it crosses exactly
one endpoint of A_h. External tangency is not an intersection of open
arcs; an endpoint equality that contains A_h is excluded by privacy.
Taking the furthest endpoint of the left covers and the nearest endpoint
of the right covers proves W_h is one closed interval, possibly a singleton.

If C_h is empty, all cross-pairs of endpoint labels sum to m. Fixing
either side makes the other side unique; same-speed arcs cannot cover the
same endpoint twice. The two labels c,d are distinct and below m. The
accepted cancellation at a private time gives the integral relation
`l_h+r_h=h`, as well as `c+d=m`. With the actual endpoint lifts,

`D=c*r_h-d*l_h=c*h-m*l_h=m*r_h-d*h>0`.

Only these two retained arcs meet A_h. For a private time, put
`e=mt-h`, `x=ct-l_h>=alpha`, `y=r_h-dt>=alpha`. Then
`D=dx+cy>=alpha*m`. Unique endpoint ownership permits contraction
for the parent c at A_h's left endpoint and for d at its right endpoint;
the retained maximum for each parent is m. This yields

`alpha*m<=D<=mu*(m+s)<alpha*(m+s)`, where `s=min(c,d)`.

Writing `z=D-alpha*m`, direct subtraction of the two open parent arcs gives

`W_h=[(l_h+alpha)/c,(r_h-alpha)/d]`,
`{mt-h:t in W_h}=[-z/c,z/d]`, `0<=z<alpha*s`.

The endpoints remain because the parent arcs are open; z=0 gives the
allowed singleton. In particular h/m belongs to W_h. Every nonparent
retained speed is alpha-good throughout A_h. None of these deductions
requires any other collision to be zero-only, or a beta-seed in this
particular interval. This validates the local use of the earlier sources
whose later globalization sometimes assumes every collision is zero-only.

At a positive source collision, the inherited full-portion cancellation
makes u=|a+b-m| positive, fresh and less than m. A same-count smaller-sum
replacement gives some u-good point of W. A globally bad replacement
would have an attained maximum below alpha by compactness and contradict
minimality, with gcd normalization if needed. The current task conditions
on one such point lying in the zero-only W_h. It does not supply that
target, strengthen its witness to beta, or assume every escape ends there.

## Actual full-minimum contacts and exact directional crossing

Near h, the parent representatives are
`x=(D+c*e)/m`, `y=(D-d*e)/m`. At `e_+=D/(m+d)`, the representatives
for m,d,c are respectively e_+, e_+, 2e_+. Strict parent overlap gives
D<alpha(m+s), hence 0<e_+<alpha. Conversely D>=alpha*m and d<m imply
2e_+>alpha. Since 2e_+<2alpha<=1/3<1/2, all these representatives give
the actual norms. The time lies inside A_h, so all nonparents are
alpha-good and the full original minimum is exactly e_+.
At `e_-=-D/(m+c)` the corresponding minimum is D/(m+c), with the
other parent norm twice that value. Thus the same actual global maximum
satisfies `mu>=D/(m+s)`. These times are outside W because a parent is
strictly alpha-bad; no deletion-domain contraction was applied there.
This recovers the inherited contact bound rather than amplifying it.

Now suppose `||u*h/m||<alpha`. Its nearest integer j is unique. Let
`R=u*h-m*j`, `rho=|R|<alpha*m`. Across the ENTIRE closed W_h the fixed
representative of ut-j is `(R+u*e)/m`, with numerator interval

`[R-u*z/c, R+u*z/d]`.

Each endpoint shift is strictly smaller than alpha*m: z<alpha*s,
s<=c,d and u<m. Therefore the representative stays inside
(-2alpha,2alpha), a subset of (-1/2,1/2). Its norm is exactly its absolute
value. Reaching the closed good set is consequently equivalent to

`u*z>=min(d*(alpha*m-R), c*(alpha*m+R))`.

If R>0, the negative boundary requires a shift alpha*m+R, beyond the
available strict bound; only the positive boundary can be reached. If
R<0, only the negative boundary is reachable. If R=0, neither is.
An actual center-bad escape therefore has rho>0 and satisfies exactly

`u*(D-alpha*m)>=p*(alpha*m-rho)`,
`p=d` for R>0 and `p=c` for R<0.

Equality is allowed: a witness can be at the closed endpoint of W_h.
Reflection negates R and swaps c,d, hence swaps direction consistently.
An integer time translation changes h,j,l_h,r_h compatibly and preserves
R,D. No independent reflection of u was used to erase p.

Combining this necessary crossing with D<=mu(m+s) gives

`mu>=[alpha*m+(p/u)*(alpha*m-rho)]/(m+s)`,
`alpha*m-rho<=(u/p)*[mu*(m+s)-alpha*m]`.

The bracket is nonnegative, since it bounds z from above. As p>=s and
s<=Q, its right side is at most
`u*[mu-m*(alpha-mu)/s]<=u*mu_m`. The comparison therefore has the
claimed direction and improves the elementary contracted-radius bound
for this specified sink. It is a necessary restriction, not edge supply.

## Integer coupling and the global margin restriction

Set `Z=N*D-m`, `A=m-N*rho`. They are integers with A>0 and 0<=Z<s.
The exact crossing is `u*Z>=p*A`. Hence Z>0, and
`u>p*A/s>=A`. For g=gcd(m,u), both rho and A are divisible by g;
thus u/g>A/g>=1, so the integer u/g is at least two. In particular a
divisor u of m cannot make this center-bad escape. The singleton z=0
is also excluded. This is the stated transfer of boundary quantization.

For the stronger coupling, take `G=gcd(m,c,u)=gcd(c,d,u)`. Because
d=m-c, G divides either directional parent p. It also divides
`D=c*h-m*l_h` and `rho=|u*h-m*j|`. The inequality
`D>=m/N>rho` makes D-rho a positive multiple of G, hence at least G.
Therefore

`A+Z=N*(D-rho)>=N*G`,
`(u+p)*Z>=p*(A+Z)>=N*p*G`.

Using the STRICT upper bound Z<s gives
`(u+p)/G>N*p/s>=N`. G divides u+p, so this is precisely the integer
restriction `(u+p)/G>=N+1`. No coprimality assumption on the original
parents or replacement was introduced.

The contact bound also gives `Z<=N*mu*(m+s)-m`. Combining it with
`Z>=N*p*G/(u+p)` proves the residue-free restriction

`mu>=[alpha*m+p*G/(u+p)]/(m+s)`.

This final lower bound is weak, as written; strictness was needed in
Z<s to obtain the preceding integer threshold. It concerns a center-bad
incoming replacement and its directional sink parent, not arbitrary
original label pairs. It uses the full global-mu bound in addition to
local integer geometry. If the candidate is already alpha-good at h/m,
including equality, then the center is an escape and A need not be
positive; none of these crossing restrictions is asserted in that case.
The old maximum norm is zero there, so this is not a full-tuple witness.

## Parent-center repair and the exact mixed control

For a sink parent p with index j_p, let q_p=p/gcd(p,j_p). Its specified
rational center is a v-grid center exactly when q_p divides v. The
farthest point of the closed maximum arc from this parent center has
distance `(D+alpha*p)/(p*m)`. This is its actual circle distance:
`D+alpha*p<alpha*(m+s+p)<=2alpha*m`, so it is less than
2alpha/p<=1/3<1/2. Thus the chosen lift stays the nearest unit translate.
The open v-arc strictly covers the entire closed maximum arc exactly when

`q_p|v`, `0<v<B_p=p*m/(N*D+p)`.

The strict sign retains closed target endpoints. D>=alpha*m implies
`B_p<=p*m/(m+p)<p`. Primitive parents therefore give empty specified-center
families. This does not characterize other grid centers, all smaller
frequencies, or repairs of the smaller private interval.

For V_*=(1,5,11,13,16), alpha=1/6, the four retained norm numerators at
the source and sink endpoints, in label order (1,5,11,13), are:

| Endpoint | Numerators over 96 | Unique original open cover |
| --- | --- | --- |
| 23/96 | (23,19,35,11) | (13,3) |
| 25/96 | (25,29,13,37) | (11,3) |
| 41/96 | (41,13,29,43) | (5,2) |
| 43/96 | (43,23,7,17) | (11,5) |

Threshold alpha is 16/96; the m-norm equals it at each endpoint and
therefore supplies no open cover. All retained labels were checked.

At source center 1/4, the nonparent 1- and 5-norms are both 24/96,
strictly above their disjointness bounds 17/96 and 21/96. For the two
parents the other integer lifts have phase distance at least 3/4, beyond
their overlap bounds 29/96 and 27/96. Thus only the displayed parents
meet A_4. Their complements give exactly

`W_4=[19/78,17/66]`, `C_4={8}`.

This nonempty interval is strictly inside (23/96,25/96). Throughout it,
`8t-2` ranges from -2/39 to 2/33, proving strict repair by fresh 8 on
the whole portion, including both endpoints.

At sink center 7/16, the nonparent norms for 1 and 13 are 42/96 and
30/96, strictly above 17/96 and 29/96. Other parent lifts have phase
distance at least 13/16, beyond both overlap windows. Thus only the
displayed parents meet A_7. They have c=5,d=11,l_h=2,r_h=5 and D=3,
giving exactly

`W_7=[13/30,29/66]`, `C_7` empty,
`{16t-7:t in W_7}=[-1/15,1/33]`.

Here z=3-16/6=1/3. The 8-norm at the center is 1/2; on all W_7 its
minimum is 7/15. This is an actual positive-to-zero local transition.
Reflection supplies the transition from index 12 to index 9. No global
classification of the other private intervals is used or claimed.

The gcds gcd(5,2), gcd(11,5), gcd(16,7) are all one. The thresholds
are B_5=80/23<5 and B_11=176/29<11, so both complete specified-center
repair families are empty. The only smaller proper divisor frequency of
either prime parent is 1, whose norm is above alpha throughout W_7;
allowing another center for that divisor cannot repair W_7 or the whole arc.

Nevertheless fresh frequency 2 repairs the entire CLOSED A_7: its phase
ranges from 41/48 to 43/48, so its norm has maximum 7/48<1/6. It does
not repair all W, since 1/4 lies in W_4 and has 2-norm 1/2. Empty parent
families are thus not being mistaken for absence of any local continuation.

Finally every original speed is congruent to 1 or 2 modulo 3. At t=1/3
all five norms are exactly 1/3>alpha. The full W has an untrapped point,
and the actual maximum is at least 1/3. No strict-failure value of mu,
global contraction, or coupled replacement minimality is assigned to
this native-good control. It refutes positive local arrival forcing parent
reduction, with the complete original endpoint geometry retained. It does
not refute an implication using the absent full-failure premises.

## Remaining implication, bindings and actual checks

The first unresolved implication is to control center-good zero sinks,
or center-bad sinks meeting the displayed necessary bounds, using full W
and all replacement constraints. No contradiction or subsequent common
repair is supplied. A repair at one sink must still hold across every
attained portion before the one-slot descent applies. The manuscript
neither proves nor falsifies that uniform step; unrestricted LRC remains
unresolved. The earlier positive-cycle manuscript is context only and
its phase/carry conclusions are not premises of this review.

The complete frozen author was read and hand-checked. The zero-only gap
source was fully reread, its accepted review and the parent-reduction
source were checked at the invoked portions, and unchanged earlier full
reviews were reused. All fifteen author input hashes matched current
bytes. The following sixteen bindings include the author and every input.

| Input | SHA-256 |
| --- | --- |
| `research/astra-mixed-candidate-zero-sinks.md` | `c51b493cadda81760e221b8bc747df465d3865e8aa39361e581c3de1672c18eb` |
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

Current config, workflow, policy and focused state were read. The gate
was research/in_progress with explicit start authorization recorded at
`2026-09-05T04:12:25.208107+00:00`; the active task matched this route,
checkpoint and sole owned path. `python3 -B scripts/validate_workflow.py`
exited 0 with `workflow structural validation passed; it cannot certify
mathematical validity.` Full final readback, sixteen source/input bindings,
newline/whitespace and final workflow checks passed before the frozen hash
reported separately. Mathematics and all displayed fractions were checked
by hand; only administrative commands ran. No mathematical program, sweep,
solver, Lean execution, build, cache/dependency operation, extra agent,
external model, Git/shared-state/memory write or other-file edit occurred.
The author remained frozen; no correction was required.
