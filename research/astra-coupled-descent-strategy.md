# Simultaneous replacement and the missing overlap regions

Task `/root/coupled_descent_strategy`; source checkpoint
`eade37d00c179fe6cc7837c4960cd58add0d572e`. Requested route: Astra/xhigh;
observed model, effort, elapsed time, and usage: null. Only this manuscript is
owned. New claims await independent review and are not kernel theorems.

This bounded attempt does not produce a usable uniform descent. It tests one
mechanism: combine coordinate changes so that the new speeds repair every
old deletion-good set, then transport the old cover. An exact integer-speed
control refutes that last inference. The lost information concerns times with
several old bad labels, not just which collision centers are attained. A useful
bridge to the accepted winding geometry is retained, with its limits explicit.

## 1. Hypotheses and the selected mechanism

Assume a primitive positive distinct integer tuple `v=(v_1,...,v_n)` is an
ordinary strict failure, chosen first by least moving count and then least
sum among primitive failures. Put

`N=n+1`, `alpha=1/N`, `mu=max_(t in R/Z) min_i ||v_i t|| < alpha`.

The active unrestricted branch has `N>=7`; no subsequent fixed count is a
research target. Retain the entire closed sets

`W_i={t : ||v_j t||>=alpha for every j!=i}`.

The accepted minimal-frequency manuscript supplies their nonemptiness,
`||v_i t||<=mu` on `W_i`, and all smaller-frequency witness constraints.
Those results, including the residue and gcd consequences, are inputs and
are not reproved here.

A single lowering cannot preserve the cover: its own `W_i` contains a
witness for that lowering. The selected possible remedy was simultaneous
replacement: another new speed could cover that witness while the first
change repairs the second speed's old private region. For a proposed new
tuple `w=(w_1,...,w_n)`, the complete private-region repair condition is

`for every i and every t in W_i, some j has ||w_j t||<alpha`.          (R)

This is much more than checking one chosen witness for each coordinate.
The desired inference from (R) to global coverage nevertheless fails as a
general transport rule. Neither a directed list of repairs nor the individual
minimality constraints justify it. Sections 2--3 identify the exact gap and
give an actual common-time falsifier. No divisor-bundle construction is used.

## 2. What the collision data preserves, and what (R) omits

Write `K_i` for all collision indices attained by `W_i`, modulo `m=v_i`.
Choose any `mu<delta<alpha`. For each `k in K_i`, its original grid arc is

`I_(i,k)(delta)={t : |m t-k|<delta}`, interpreted on the circle.

This arc is forced in **every** subcover of the full original delta-bad
family. To prove this, choose its actual realizing `t in W_i`. The i-norm is
at most mu, hence strictly delta-bad in this unique i-arc; every other old
label has norm at least alpha, hence is delta-good. No other original arc
covers t. The original full family covers because its global maximum is mu.
Thus every subcover must include this particular indexed arc.

In particular, a primitive collision from the prime-power corollary supplies
a forced primitive arc. Its center need not belong to `W_i`. Choosing a
minimum-cost subcover and applying the accepted winding result shows that
these forced arcs have no triple overlap. This inherits the source's interval
geometry; it does not supply unit determinants or primitive collisions for
general composite speeds.

Both forcing and absence of triple overlap extend to the open width alpha
arcs. The same private points force them. If three shared a point x, choose
delta larger than mu and their three norms at x, but strictly below alpha.
They would share x already at this delta,
contradicting the preceding result. Moreover no forced alpha-arc is contained
in the union of the other forced arcs: its original private point excludes
that containment. This gives literal positional restrictions on the family;
it does not assert that the forced family covers the entire circle.

Consequently `(v_i,K_i)` retains actual grid positions `k/v_i` and the forced
arcs at every such delta. It would be inaccurate to say that it discards all
interval positioning. What a residue-only replacement argument omits is the
realizing offset set

`E_(i,k)={v_i t-k : t in W_i with this collision lift}`,

and, more fundamentally, the common-time regions where several old labels
are bad. These sets are of course determined by the full original speeds;
the omission is in the proposed invariant, not a claim of nonidentifiability
from the complete tuple.

For an exact description at the canonical alpha, define

`A(t)={i : ||v_i t||<alpha}`,
`U_S={t : A(t)=S}` for nonempty label sets S.

Full failure makes `A(t)` nonempty everywhere. Also `W_i=U_{ {i} }`:
on `W_i` the i-norm is at most mu, while all other norms are alpha-good.
Thus (R) asserts coverage of all the strata with one old bad label. It does
not assert coverage on any `U_S` with `|S|>=2`.

There is a precise consequence under the *actual* minimum hypotheses. Let
w be a positive distinct n-tuple with smaller sum, agreeing with v outside
a changed index set I. Gcd normalization and height minimality give a closed
alpha-witness for w. If (R) holds, every such witness t satisfies

`A(t) subset I`, `|A(t)|>=2`.                                         (1)

Indeed an old bad label outside I remains new-bad; a singleton old bad set
would put t in a set `W_i` covered by (R). This uses global least sum to
supply the simultaneous-replacement witness, not merely the separate
one-coordinate statements. For a replacement of exactly two coordinates
i,j, it forces an actual common time satisfying

`||w_l t||>=alpha` for every l,
`||v_i t||<alpha`, `||v_j t||<alpha`,
`min(||v_i t||,||v_j t||)<=mu`.                                       (2)

The last bound comes from the original global maximum. It bounds at least
one of the two old norms by mu, not necessarily both. Equations (1)--(2)
locate the obstruction to a proposed repair; they do not exclude it or
prove that any repair (R) exists in a hypothetical minimum.

The earlier joint-seed maximum audit already found two old bad labels at
certain transported times. There the threshold is the stronger deletion
margin and the time arises from a specified extremal seed movement. Here
the claim concerns every new witness after simultaneous replacement and
complete coverage of all `W_i(alpha)`. Neither statement supplies a new
original deletion seed. Counting the two bad labels as a contradiction would
repeat the same unsupported inference.

## 3. Exact falsifier for transport from all private regions

Here use an abstract test width `a=5/12`, kept separate from the native
canonical threshold. The original tuple is `(1,2)`.

Its actual maximum is `1/3`: if `||t||<=1/3`, use speed 1; otherwise the
representative t lies in `[1/3,2/3]`, on which `||2t||<=1/3`. At `t=1/3`
both norms are `1/3`. Thus the original open a-bad family covers the circle.
This is a genuine least-count, least-sum cover at width a: every one-speed
tuple has maximum `1/2>a`, and sum 3 is the smallest sum of two positive
distinct integers. The tuple is primitive. Every one-coordinate least-
frequency condition at a holds; for speed 2 the only smaller frequency is
the retained speed 1, and speed 1 has no smaller positive replacement.
There are no fresh lower frequencies in this control.

Its complete deletion-good sets are

`W_1=[5/24,7/24] union [17/24,19/24]`,
`W_2=[5/12,7/12]`.                                                   (3)

Now replace the tuple by `(5,8)`. On the first interval of `W_1`, the phase
8t ranges over `[5/3,7/3]`; on the second it ranges over `[17/3,19/3]`.
Both have distance at most `1/3<a` from their middle integer. Thus speed 8
alone strictly covers all of `W_1`.

On `W_2`, the exact portion where speed 5 is a-good is

`[29/60,31/60]`.

To see this, `5t` ranges from `25/12` to `35/12`, and a-goodness requires
it to belong to `[2+5/12,3-5/12]`. On the displayed subinterval,
`8t in [58/15,62/15]`, so `||8t||<=2/15<a`. Everywhere else in `W_2`,
speed 5 is strictly a-bad. The boundary points of that subinterval are
covered by speed 8. The new tuple therefore satisfies the full strict
repair condition (R), with a replacing alpha, on **both entire sets**.

Nevertheless at the actual common time `t=5/16`, the original norms are

`(||t||,||2t||)=(5/16,3/8)`, both `<5/12`,

whereas the new norms are

`(||5t||,||8t||)=(7/16,1/2)`, both `>5/12`.                           (4)

The missed point is in `U_{ {1,2} }`, so neither private set detects it.
This is a robust hole: the new minimum exceeds a by `1/48`; the 8-Lipschitz
bound keeps both new norms strictly above a whenever
`|t-5/16|<1/384`. On that neighborhood both old norms also stay below a.
In particular the problem is not a singleton or an open/closed endpoint error.

The two forced old arcs here are the speed-1 arc centered at 0, of radius
`5/12`, and the speed-2 arc centered at `1/2`, of radius `5/24`. They already
cover the circle: the speed-1 good interval `[5/12,7/12]` lies strictly
inside the second arc. The remaining speed-2 arc, centered at 0, is contained
in the first. The missed point `5/16` lies in the overlap of the two forced
arcs. Thus even in this concrete case where the forced arcs cover the circle,
repairing their private regions does not control their overlap.

The scope is essential. The old tuple's native margin is `1/3`, equal to
its maximum, while the test width a is larger. The new sum is `13>3`, so
this is not a descending replacement. It refutes the raw implication
“repair all private sets implies transport the cover,” even with all
coordinate minimality conditions at the test width. It does not refute a
theorem using the canonical strict-failure gap and the arithmetic direction
of a height decrease essentially. No such theorem is established here.

## 4. Bounded disposition and the missing invariant

The selected simultaneous-repair mechanism has no surviving global coverage
step. Adding (R) to all the one-coordinate constraints still leaves exactly
the strata in (1). Any valid descent through this mechanism needs control
of simultaneous loss of old coverage there: the relative signed old phases
and the new phases at the **same** time, including times in none of the
deletion-good sets. Separate residue escape witnesses, collective gcd one,
and forced primitive arcs do not supply that control.

This is a need for information about overlapping bad regions, not another
proposed positivity budget or an assertion that their existence is impossible.
The exact forbidden-overlap statement for an admissible lowering remains
unproved. The inherited no-triple-overlap property concerns arcs in a chosen
subcover and does not remove points with two old bad labels; (4) illustrates
why those points matter. No full uniform contradiction was found in this
bounded attempt. Unrestricted LRC remains unresolved, and no narrower
formalization or runner-count ladder is proposed.

## Inputs and verification

The accepted minimal-frequency review and the joint-seed audit were read in
full in this task. The frozen minimal-frequency author and winding inputs
were already fully read; their unchanged bindings were checked. The forced-
arc bridge supplied by root is verified above from the actual realizing
points; no unreviewed divisor-bundle premise is used.

| Input | SHA-256 |
| --- | --- |
| `research/astra-minimal-frequency-synthesis.md` | `03cf038021f0bc1a2328bb77a02f6ab4fe649f5d3626d7bc368a67cd6c7b0000` |
| `research/astra-minimal-frequency-review.md` | `b26182c2e482e7f83480eab9904779b958eb8b8b753c70bc45c6fabec55b747d` |
| `research/astra-arithmetic-winding-exchange.md` | `6fbd8b96223e1697c33d5e187c25fb9f93707c880f2794892dfa16ca0ab2d6d4` |
| `research/astra-arithmetic-winding-review.md` | `45eca69dd2c8b48a0cec68ca737262b9f1a616b08f85046629c9c4e632618243` |
| `research/astra-joint-seed-maximum-audit.md` | `ac73e29474e272167403c91db34331236bb3832f7ce916b2997d7c2f0d6b46ac` |
| `.codex/config.toml` | `28212a53cf42cdc377df1f7dab040732d657e59d7bb97ee78791256d01d4bb2c` |
| `docs/project-workflow.md` | `2b42a133352b6b53ba2106fc73882733f176e04a0deffbb183b4c16eefd9cd67` |
| `research/workflow-policy.json` | `833c397b61d1ffdb994fb115019f6d60d6c1a62ff85f19cdd2c9f8ac3a979c8b` |
| `scripts/validate_workflow.py` | `250a3ce2a080f5835ac4fd2e4b2803568424c777cda5d421f9fe92efd34d5383` |

Current config, workflow, policy, and focused live state were read. The gate
was `research/in_progress`, with explicit start authorization recorded at
`2026-09-05T04:12:25.208107+00:00` and this task's sole owned manuscript.
`python3 -B scripts/validate_workflow.py` exited 0, printing
`workflow structural validation passed; it cannot certify mathematical validity.`
Displayed mathematics was checked by hand only. No mathematical program,
enumeration, solver, Lean build, cache operation, extra agent, external model,
Git/shared-state edit, memory write, or other-file edit was used.
