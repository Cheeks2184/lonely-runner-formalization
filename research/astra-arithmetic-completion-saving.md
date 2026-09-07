# Coincident-center saving for private-cell completion

Task `/root/arithmetic_completion_saving`; assigned checkpoint
`9f276366960df7a55c1f934d4f52fae1169a62fb`. Requested route: Astra/xhigh;
observed model, effort, elapsed time, and usage: null. Only this manuscript
is owned. The new derivations below await independent review; they are not
kernel theorems or an unrestricted LRC proof/disproof.

There is a uniform arithmetic saving: truncate every nonforced chain of arcs
with exactly the same center to its two largest arcs, and remove all inner
arcs beneath a forced arc at that center. This preserves double coverage of
every actual completion gap. Its exact cost is quantified below. The saving
from third and later arcs alone is provably insufficient under actual strict
failure. A second, motivated control gives the exact minimum cover cost
`sum_(q<=n) phi(q)/q` for all consecutive-speed tuples at widths just above
their canonical threshold. That control limits the stronger pruning shortcut;
it does not satisfy canonical strict failure.

## 1. Actual minimum and the completion interface

Assume V consists of n positive distinct primitive integer speeds in an
ordinary strict failure, chosen first by moving count and then by primitive
sum. Put `N=n+1`, `alpha=1/N` and

`0<mu=max_(t in R/Z) min_(v in V)||vt||<alpha`.

Use `n>=3`; the active unrestricted branch is already beyond the six-total-
runner milestone. The full original open arcs have centers `k/v`, radius
`alpha/v`, and reciprocal cost `1/v`. Their total cost is n. Let F be the
individually indispensable arcs, equivalently all collision arcs attained
by the complete deletion-good sets, and write `f=cost(F)`.

The bound completion source supplies actual private points for F. Cutting
at one per forced arc gives cells I_j. Each nonforced original arc lies in
one cell, and the part of that cell outside F is one closed gap G_j, possibly
a singleton or empty. Every point of a nonempty G_j has at least two
nonforced covering arcs: a uniquely covering original arc would belong to F.
These statements concern the full original grid and all gap endpoints.

If kappa_j is the minimum cost needed to cover G_j by its nonforced arcs,
then the exact full-cover minimum is `f+sum_j kappa_j`. A finite family of
open intervals admits a two-coloring in which every doubly covered point
has both colors: process increasing left endpoints and assign each next
interval to the color with the smaller current maximum right endpoint.
The maxima retain the two greatest processed right endpoints. The prefix
whose left endpoints are strictly below a target point proves coverage with
the correct open signs. These invoked gap and coloring facts were checked
against the complete source and its subsequently available independent review.

## 2. First attempt: exact-center chains admit safe truncation

Let C be the finite set of distinct original grid centers on the circle.
At a center c, list its available owning speeds as

`a_1(c)<a_2(c)<...<a_(r_c)(c)`.

Its arcs are strictly nested in this order, since their common-center radii
are `alpha/a_s(c)`. Only the outer arc, owned by a_1(c), can belong to F:
each inner arc is contained in that original outer arc and has no private
point. Write `C_F` for the centers whose outer arc is forced.

Perform exactly the following structured deletion of nonforced arcs:

* At each `c in C_F`, delete every inner arc, with indices `s>=2`.
* At each `c not in C_F`, retain only the outer two arcs, or the sole arc
  if `r_c=1`; delete indices `s>=3`.

This is not arbitrary deletion of contained arcs. Its multiplicity guarantee
is pointwise. Fix any `t in G_j`. A chain whose outer arc is forced cannot
cover t at all, so deleting its inner arcs has no effect there. For any other
center c, let `m_c(t)` count its covering arcs before deletion. Membership
is a prefix of the nested chain, including at open endpoints; keeping the
outer two changes this contribution to exactly `min(2,m_c(t))`. Since

`sum_c m_c(t)>=2  implies  sum_c min(2,m_c(t))>=2`,

double coverage of every G_j survives. The remaining arcs are still original
arcs within their original cells. No grid is translated and no gap endpoint
is discarded. All nonforced arcs at the same center lie in the same cell,
since they contain that center and avoid every private point. Apply the
two-color construction to this remaining family.

Define the two parts of the exact discarded cost by

`C_3=sum_(c in C) sum_(s>=3) 1/a_s(c)`,
`C_(2,F)=sum_(c in C_F, r_c>=2) 1/a_2(c)`.

Then the structured deletion has cost

`S_c=C_3+C_(2,F)`.                                                   (1)

The remaining nonforced cost is `R=n-f-S_c`. In cell j, let the two remaining
color costs be `c_j^0,c_j^1` and put

`B_c=sum_j |c_j^0-c_j^1|`.

Choosing the cheaper class in each cell produces a genuine original-grid
cover with exact constructed cost

`f+sum_j min(c_j^0,c_j^1)=(n+f-S_c-B_c)/2`.                           (2)

In particular, if `s_j` is the deleted cost in I_j and `d_j` its original
nonforced cost, then

`kappa_j <= (d_j-s_j-|c_j^0-c_j^1|)/2`.

This is an upper bound on the exact kappa_j, not an assertion of weighted
optimality of either color. Empty gaps can be omitted completely; (2) remains
a valid construction even if it keeps unnecessary intervals in their cells.
Further certified deletions can improve it but are not part of (1).

The saving is genuinely arithmetic and quantitatively positive. The zero
center is shared by every original speed. If `v_(1)<...<v_(n)` are the
ordered speeds, then

`S_c>=C_3>=sum_(s=3)^n 1/v_(s)>0`.                                  (3)

More explicitly, at a reduced center of denominator q the owning speeds
are exactly the elements of V divisible by q. There are phi(q) such centers,
with `phi(1)=1` for center zero. Thus C_3 is determined entirely by these
ordered divisibility lists; C_(2,F) additionally uses which centers are
actually forced. No domain enumeration is used in this formula.

At a center whose outer arc is not forced, the same tail deletion has a
certificate in the uncompressed nonforced color scan. When its third or
later member is processed, its two outer ancestors were processed earlier
and both have larger right endpoints. Both current color maxima therefore
exceed its right endpoint. In either assigned color it is contained in an
earlier interval of that color. This is the specific non-record case, not
permission to delete a singly dominated arc across colors. Inner arcs beneath
a forced ancestor instead use the separate gap-disjointness argument. The
direct multiplicity proof above explains why structured truncation before
coloring is safe.

### The automatic tail saving is already charged by full multiplicity

Let `M(t)` be the complete original arc multiplicity and set
`T_3=integral (M-2)_+`, with normalized circle measure. Decompose it by centers:

`M(t)=sum_c M_c(t)`.

For nonnegative integers, the positive-part function here is superadditive:

`(sum_c M_c-2)_+ >= sum_c (M_c-2)_+`.

One can verify this for two summands by whether each exceeds two, then
induct. Nestedness gives the exact pointwise identity

`(M_c-2)_+=sum_(s>=3) 1_(A_(a_s(c),c))`.

Integrating, including all actual overlaps between different centers, yields

`T_3>=2alpha C_3`.                                                   (4)

The private-mass identity from the completion source is also exact:
`P=measure{M=1}=2alpha+T_3`, while private points lie in the forced mu-cores,
so `P<=2mu f`. For clarity, the first equality follows by integrating
`1_(M=1)=2-M+(M-2)_+` and `integral M=2n alpha`; it uses the actual cover
`M>=1`. The second is the sum-of-core-lengths bound.

Put `rho=mu/alpha<1` and
`E=T_3/(2alpha)-C_3>=0`. Combining with (4) gives

`rho f>=1+C_3+E`,
`f-1-C_3 >= (1-rho)f+E > 0`.                                       (5)

Thus removing all third-and-later coincident arcs alone can never supply
the required saving `f-1` in a hypothetical actual strict failure. The
positive saving (3) is real, but its entire C_3 part is already paid for by
the original excess-multiplicity term. Only the additional forced-center
second arcs, color imbalance, or other justified savings could bridge the
remaining positive gap. No lower bound on those additional contributions
is obtained here. This is a limitation of the selected mechanism, not an
assertion that the hypothetical minimum exists.

## 3. Second attempt: an exact consecutive-family control

Take any integer `n>=3`, let `V_n={1,...,n}`, and now use a test width a with

`alpha_n=1/(n+1) < a < 1/n`.                                        (6)

The width a is not the canonical alpha of a strict failure. All following
arc and private-point statements in this section use a unless stated otherwise.

First, `mu(V_n)=alpha_n` follows from the elementary progression packing
argument. Among the `n+1` points `0,t,...,nt` on the circle, either two
coincide or a shortest cyclic gap has length at most `1/(n+1)`. The index
difference supplies a speed in V_n with norm at most that gap. Conversely
`t=1/(n+1)` makes every original norm at least alpha_n. This proves the
maximum without any premise about LRC at arbitrary smaller counts.
Consequently the full open a-family covers T.

We claim its forced arcs are **exactly** the primitive-center arcs: for each
`1<=q<=n`, the arc of speed q centered at reduced `k/q`, with `0<=k<q` and
`gcd(k,q)=1` (including `k=0,q=1`). A nonprimitive arc reduces to such a
center with smaller denominator q in V_n, and is contained in that q-arc,
so it is not forced. It remains to give a private point for every listed arc.

If `q>n/2`, use the center itself. No other original speed is divisible by q.
Every other norm is therefore at least `1/q>=1/n>a`, while the q-norm is zero.

If `q<=n/2`, use the actual common time

`t=k/q+a/(2q)` modulo one.                                         (7)

The q-norm is `a/2<a`. For any other multiple `v=rq`, `r>=2`, its norm is
exactly `r a/2>=a`: indeed

`r a/2<=n a/(2q)<1/(2q)<=1/2`,

so no wrap changes this norm. For a speed v not divisible by q, coprimality
at the center and the norm Lipschitz bound give

`||vt|| >= 1/q-v a/(2q) >= 1/q-n a/(2q)
        > 1/(2q) >= 1/n > a`.

This includes q=1, when there are no nonmultiples; all other speeds are
handled by the preceding multiple calculation. Thus (7) is private with
the correct open/closed inequalities for every primitive-center arc.

Writing `phi(q)` for Euler's totient and `phi(1)=1`, the exact forced cost is

`f_n=sum_(q=1)^n phi(q)/q`.                                         (8)

Every nonforced arc is inside its forced primitive ancestor. Removing all
of them preserves the full cover, so the forced family already covers T.
All completion gaps are empty, every kappa_j is zero, and

`minimum original-grid open a-cover cost = f_n`,
`S_c=n-f_n`, `R=0`, `B_c=0`.                                       (9)

No more expensive completion can improve the indispensable cost f_n.

### A quantitative strict cost excess

At the **closed** canonical width alpha_n, the same primitive index family
still covers: the progression maximum supplies the complete closed cover,
and each nonprimitive closed arc remains contained in its primitive ancestor.
The primitive arcs centered at `1/n` and `1/(n-1)` overlap in a real interval
of length

`ell=alpha_n(1/n+1/(n-1))-1/[n(n-1)]
    =(n-2)/[(n+1)n(n-1)]>0`.

Neither arc contains the other: their radius difference is strictly smaller
than their center separation. Hence the displayed length is their actual
overlap length. Summing all primitive arc lengths counts the whole circle
and this overlap at least twice, so

`2alpha_n f_n >= 1+ell`,
`f_n >= (n+1)/2 + (n-2)/[2n(n-1)] > (n+1)/2`.                       (10)

This proof needs no totient asymptotic, Farey theorem, or computation.
Since the entire nonforced budget is `n-f_n`, any deletion/color construction
has total discard plus remaining imbalance at most `n-f_n`. Equations
(9)--(10) show the required saving fails by at least

`(f_n-1)-(n-f_n)=2f_n-n-1 >= (n-2)/[n(n-1)]>0`.                    (11)

Thus actual complete integer grids, exact forced positioning, and exhaustive
coincident-center pruning do not force the target saving at these widths.

### Scope relative to the earlier progression obstruction

The prime-progression manuscript and its review already proved no cheap
subcover for `n=p-1`, primes `p>=7`, on a positive range above alpha_n,
with explicit own-margin deletion witnesses. The exact cost `13/6` for
`n=3` was also known. Equations (7)--(11) add the complete forced-arc
classification, the exact totient cost for **every n>=3**, and the whole
width interval (6). They do not turn those controls into strict failures.

V_n is positive, distinct, primitive, and has the absolutely smallest sum
among n distinct positive integers. At width a all its coordinate
least-frequency conditions hold: every smaller positive replacement is
already a retained label and is good throughout the corresponding deletion
set. There are no fresh smaller frequencies. This is fixed-count minimum
sum, not a claim of height minimality among canonical failures. Uniform
least-count minimality at width a is not proved or assumed. The earlier prime
subfamily retains its separately proved deletion witnesses.
Most decisively, the actual maximum is `mu=alpha_n`, whereas (6) uses
`a>alpha_n`; the hypothetical strict-failure ratio `mu/alpha<1` from (5)
does not apply at the native threshold of this control.

## 4. Result and first unresolved implication

The positive contribution is the justified arithmetic deletion (1) and its
actual completion bound (2), with the explicit lower saving (3). Arbitrary
global removal of a contained interval has not been used: same-center
multiplicity was truncated to two, while arcs deleted beneath a forced
ancestor meet no completion gap.

Equation (5) explains why the automatic coincidence tails cannot be the
whole sharp argument under canonical strict failure. The remaining problem
is a justified lower bound on the additional savings in the actual private
cells, using the full strict-failure and minimum-sum hypotheses. No such bound
on C_(2,F), the color imbalance, or exact kappa_j is supplied. The control
refutes a broader grid/minimal-frequency shortcut, not an implication using
those full hypotheses essentially. These two bounded attempts stop here;
unrestricted LRC remains unresolved, with no finite-count ladder or narrower
formalization proposed.

## Source bindings and checks

The full completion source was provisional at assignment. Its invoked parts
were checked by hand here; the subsequently available independent review was
read in full and accepts its unchanged source without corrections. That
acceptance does not promote this new manuscript, which still awaits review.
The prime-progression source and cover-selection review were read in full
for the comparison above. Earlier accepted private-region and minimum-
frequency facts retain their scope; no prior computation was rerun.

| Input | SHA-256 |
| --- | --- |
| `research/astra-forced-arc-completion.md` | `e48f80297a70e6630e76fe2b905ed86372383a5d170a539abccdba3decdd98a1` |
| `research/astra-forced-completion-review.md` | `8e72687760576dc0e8524ecbae0bad81bcf3e8cd33f180219848da86a23adb02` |
| `research/astra-coupled-descent-strategy.md` | `d9a029cb16c866a45741f97841f3b007d4823f86712fe827e899801208289bb2` |
| `research/astra-private-repair-review.md` | `a8aaec8468969723207dc12e9ff2c112a4560c1f51e97f13b43f4e342c849512` |
| `research/astra-prime-progression-cover-cost.md` | `e5e26e0cffff1031dd1b14cd88f127ac5b624c2c798d22b0d0baa51e89a7ccd7` |
| `research/astra-cover-selection-review.md` | `a0fe2ed43372520ac30caec3844bbc90dc145089a8ba9113be4bba8b9bbab770` |
| `.codex/config.toml` | `28212a53cf42cdc377df1f7dab040732d657e59d7bb97ee78791256d01d4bb2c` |
| `docs/project-workflow.md` | `2b42a133352b6b53ba2106fc73882733f176e04a0deffbb183b4c16eefd9cd67` |
| `research/workflow-policy.json` | `833c397b61d1ffdb994fb115019f6d60d6c1a62ff85f19cdd2c9f8ac3a979c8b` |
| `scripts/validate_workflow.py` | `250a3ce2a080f5835ac4fd2e4b2803568424c777cda5d421f9fe92efd34d5383` |

Current config, workflow, policy, and focused live state were read. The gate
was `research/in_progress`, with explicit start authorization recorded at
`2026-09-05T04:12:25.208107+00:00` and this task's sole owned file.
`python3 -B scripts/validate_workflow.py` exited 0 with
`workflow structural validation passed; it cannot certify mathematical validity.`
All mathematics was hand-checked; source bindings used `sha256sum`. No
mathematical program, enumeration, solver, Lean/build/cache operation, extra
agent, external model, Git/shared-state edit, memory write, or other-file
edit was performed. The full owned text and frozen hash are returned after
final readback. New mathematics remains pending independent review.
