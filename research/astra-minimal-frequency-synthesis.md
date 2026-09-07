# Full replacement minimality and collision residues

Task `/root/minimal_frequency_synthesis`; assigned source checkpoint
`0f92e9a2f29ab5beccc22059baa916a2f82ce897`. Requested route: Astra/xhigh;
observed model, effort, elapsed time, and token usage: null. This is a bounded
manuscript derivation awaiting independent review, not a kernel theorem.

The positive result is an arithmetic restriction involving **every** collision
component of a deletion-good set. A common collision divisor permits a global
height descent; more generally every smaller frequency must escape an explicit
residue bound. Prime-power deleted speeds consequently have a primitive
collision. An exact control defeats promotion from a single least-frequency
condition to a primitive collision for general composite speeds. It does not
satisfy all the coupled minimality hypotheses. No unrestricted contradiction
or full LRC proof/disproof is obtained.

## 1. Actual failure hypotheses and the existing minimality reduction

Write `||x|| = dist(x,Z)` on `T = R/Z`. Assume a positive, distinct, primitive
integer tuple `v = (v_1,...,v_n)` is an ordinary strict failure, chosen with
least moving count and then least sum among primitive failures at that count.
Set

`N = n+1`, `alpha = 1/N`, `mu = max_t min_j ||v_j t|| < alpha`.

We use `n >= 2`, so `alpha < 1/2`; the derivation imposes no upper bound on N.
Fix i, put `m = v_i`, and retain the **whole** set

`W_i = {t in T : ||v_j t|| >= alpha for every j != i}`.                 (1)

Least count supplies a deletion witness with margin `1/n > alpha` (normalize
its gcd and rescale time if needed). Continuity gives a nonempty interval in
`W_i`. Each individual closed good set is a finite union of closed intervals,
so the same is true of `W_i`, allowing additional singleton components.
On every point of `W_i`,

`||m t|| <= mu`.                                                        (2)

Indeed all retained margins are at least alpha, strictly above the full tuple's
maximum mu. Thus the deleted coordinate must realize the full minimum there.

For each integer `1 <= u < m`, there is a point `t in W_i` with
`||u t|| >= alpha`. If u is a retained speed, every point of `W_i` works.
Otherwise replacing m by u gives a positive distinct tuple of smaller sum.
Dividing its common gcd preserves its ordinary maximum, since multiplication
by that gcd maps T onto T; its primitive sum is still smaller. Height
minimality therefore supplies its alpha-witness, which belongs to `W_i`.

This least-frequency statement is not itself a new reduction. In particular,
section 3 of `astra-joint-seed-maximum-audit.md` already records a stronger
endpoint version in its applicable N range. The work below extracts explicit
arithmetic consequences without replacing all components by a selected seed.

The reverse implication is the global transport used throughout: if some
`1 <= u < m` satisfies `||u t|| < alpha` on **all** of `W_i`, then the tuple
with m replaced by u has no alpha-witness. On `W_i` the new coordinate blocks
one; outside `W_i` a retained coordinate does. Its continuous minimum attains
a maximum on T, so that maximum is strictly below alpha. If u duplicates a
retained speed, nonemptiness of `W_i` already contradicts this strict bound.
Otherwise gcd normalization gives a smaller primitive strict failure,
contradicting height minimality. A change valid on just one component would
not justify this argument.

## 2. First approach: a residue condition for global descent

For a real lift of `t in W_i`, (2) gives a unique integer k with
`m t = k+e`, `|e| <= mu`. Uniqueness follows from `mu < 1/2`. Changing the
lift changes k by a multiple of m. Let `K_i` be **all** resulting residues
in `Z/mZ`. The map to these residues is constant on each connected component
of `W_i`: its image is confined to the disjoint closed mu-bad arcs. Thus
`K_i` is finite and nonempty and accounts for every component, including
singletons. Several components may give the same residue. Representatives
of residues do not affect any gcd or distance below.

For `1 <= u < m`, define the nonnegative integer

`D_u(k) = dist(u k, m Z) = m ||u k/m||`.

At the replacement witness from section 1, the circle triangle inequality
and (2) give

`alpha <= ||u t|| <= D_u(k)/m + u mu/m`.

Consequently, for every smaller positive u,

`max_{k in K_i} D_u(k) >= m alpha - u mu > (m-u)/N`,                    (3)

and in particular

`max_{k in K_i} D_u(k) >= floor((m-u)/N)+1`.                           (4)

The strict inequality uses the actual gap `mu < alpha` and `u > 0`.
The witnessing residue may depend on u; no common residue is asserted.
Also `D_{m-u}(k)=D_u(k)`. Applying (3) to both multipliers gives

`max_{k in K_i} D_u(k) > max(u,m-u)/N`,
so `max_{k in K_i} ||u k/m|| > 1/(2N)` for every `1 <= u < m`.          (4a)

This symmetric consequence still allows different escaping collisions for
different multipliers; it does not construct a lowering frequency.

There is also an explicit sufficient descent criterion. If for some smaller u

`D_u(k) <= (m-u)/N for every k in K_i`,                                (5)

then for every `t in W_i`, using its own collision residue,

`||u t|| <= (m-u)/(mN) + u mu/m < 1/N`.

Section 1 then transports failure to a smaller tuple. This proves that (5)
is forbidden in a minimal failure; it does not supply a u satisfying (5).
The inequalities are consequences of complete replacement minimality, not a
claim that arbitrary residue sets have the required simultaneous geometry.

### Collective gcd and divisor spread

Let `g = gcd(m, {k : k in K_i})`. If `g > 1`, choose `u = m/g < m`.
For every actual collision lift, `k/g` is an integer, and hence

`||u t|| = ||k/g+e/g|| <= mu/g < alpha` on all of `W_i`.

The global transport proves

`gcd(m, K_i) = 1`.                                                     (6)

This is a joint assertion about all deletion components, not a claim that
each attained collision is coprime to m.

More generally fix any divisor `g | m`, `g >= 2`, and apply (3) to `u=m/g`.
Since `D_u(k) = (m/g) dist(k,g Z)`, some attained residue satisfies

`dist(k,g Z) > (g-1)/N`,
and thus `dist(k,g Z) >= ceil(g/N)`.                                   (7)

The final equality in integer rounding is
`floor((g-1)/N)+1 = ceil(g/N)`. For `g > N`, (7) requires more than a
nonzero residue modulo g. It is an explicit strengthening of the common-gcd
exclusion, while remaining a consequence of the existing full minimality.

Two immediate consequences of (6), for `m > 1`, are:

* If `m=p^r` is a prime power, at least one attained k is not divisible by p,
  hence `gcd(k,m)=1`.
* In general, at most `omega(m)` attained residues suffice to have collective
  gcd 1 with m: for each distinct prime dividing m, select one residue not
  divisible by that prime, and discard repetitions.

In the prime-power case an actual deletion component lies in the collision
arc about a primitive grid point `k/m`. This does not say the grid point
itself lies in `W_i`, that every component is primitive, or that a selected
winding cover uses that component. It supplies no unit transition determinant.
For `m=1`, (6) is tautological and there is no smaller positive replacement.

## 3. Second approach: testing primitive synthesis from one deletion set

Keep a test width `a` separate from the actual `alpha=1/N`. For a nonempty
set W, call m its least covering frequency at width a when

`W subset {t : ||m t|| < a}`
and `for every 1 <= u < m, some t in W has ||u t|| >= a`.              (8)

The tempting inference is that if W is the intersection of the retained
integer-speed good sets, (8) supplies an attained collision k with
`gcd(k,m)=1`. The following exact controls refute this single-set inference.

Take retained speeds `(1,5)` and deleted speed `m=6`. At `a=1/3`, intersect
`[1/3,2/3]` with the five-speed good intervals
`[(3j+1)/15,(3j+2)/15]`, `j=0,...,4`. The result is exactly

`W = {1/3} union [7/15,8/15] union {2/3}`.

At the singleton points, `6t` is 2 or 4. On the middle interval it ranges
from `14/5` to `16/5`, so its nearest integer is 3 and its norm is at most
`1/5 < a`. All attained collision residues are therefore

`K = {2,3,4}`, `gcd(6,K)=1`, but `gcd(6,k)>1` for every `k in K`.       (9)

For `u=1,3,5`, the point `t=1/2` belongs to W and has `||u t||=1/2`.
For `u=2,4`, the point `t=1/3` belongs to W and has `||u t||=1/3=a`.
These equalities are good for the closed witness convention; they exclude
containment in the **open** bad set. Thus 6 really is the least frequency
in (8), not merely a cover with an arbitrary nonprimitive residue list.

The phenomenon persists with intervals and strict smaller-frequency witnesses.
At `a=3/10`, direct intersection gives

`W = [3/10,17/50] union [23/50,27/50] union [33/50,7/10]`.             (10)

On these three intervals, `6t` ranges respectively over

`[9/5,51/25]`, `[69/25,81/25]`, `[99/25,21/5]`.

The nearest integers are respectively 2, 3, and 4; the maximum norm on the
three intervals is respectively `1/5`, `6/25`, and `1/5`. Therefore
`max_W ||6t|| = 6/25 < 3/10`, with the same K as (9). The preceding smaller
frequencies still have witnesses at `1/2` or `1/3`, now strictly above a.
All three components have positive length.

Bézout arithmetic cannot fix the missing primitive collision by itself.
For example `3-2=1`, but the realizing collision times `1/2` and `1/3`
have difference `1/6`, which is not in either W: the speed-1 norm is too
small. The deletion-good set is not assumed closed under time addition or
subtraction. Synthesizing residues does not synthesize a common good time.

### The control fails the coupled hypothesis explicitly

The control is not a minimal failure at the canonical threshold. Its native
moving count is 3 and its native alpha is `1/4`; at `t=2/7`, the three norms
for `(1,5,6)` are `(2/7,3/7,2/7)`, all above `1/4`. Both test widths used
above exceed that native alpha.

It also fails joint least-frequency minimality even at `a=3/10`. Deleting 5
instead gives the exact retained `(1,6)` good set

`W_5 = [23/60,9/20] union [11/20,37/60]`.

Indeed these are the only six-speed good intervals intersecting the speed-1
good interval `[3/10,7/10]`. Throughout them, respectively
`2t in [23/30,9/10]` and `2t in [11/10,37/30]`, so

`||2t|| <= 7/30 < 3/10` on all of `W_5`.

Thus replacing 5 by 2 preserves failure at the test width. This precise
violation matters: (9)--(10) refute promotion from **one** least-frequency
condition, not an implication exploiting all coordinate conditions together
under the actual strict-failure hypotheses.

## 4. Disposition and first unresolved implication

The proved manuscript consequences are (3)--(7), with explicit transport of
failure using all components. Their arithmetic formulation is not stated in
the four focused source manuscripts; the underlying full replacement
minimality and its endpoint strengthening were already available. No claim
of independence from those stronger source invariants is made.

The attempted general primitive-collision promotion fails under the precise
single-set hypothesis (8), even robustly. Its version using the entire coupled
family of actual `W_i(alpha)` remains unproved and is not refuted by this
control. In particular, nothing here forces a violation of (4), constructs
a coordinate and smaller frequency satisfying (5), or supplies primitive
owners and unit transitions for the winding argument. Turning collectively
primitive collision data from different components into one usable common
time remains the first unresolved synthesis step; addition of their times
is not justified. The bounded attempt stops here. The unrestricted goal
remains unresolved; no finite-count ladder or narrower formalization is proposed.

## Source bindings and checks

All four mathematical inputs were read in full. The arithmetic-winding input
was used to identify its stated gap, without duplicating its separate review.
SHA-256 values checked from current files:

| Path | SHA-256 |
| --- | --- |
| `research/astra-arithmetic-winding-exchange.md` | `6fbd8b96223e1697c33d5e187c25fb9f93707c880f2794892dfa16ca0ab2d6d4` |
| `research/astra-uniform-divisor-minimality.md` | `8c4b6ee094f0f311f360d3abf371e95f731e28cee997d3810dd3218ff6f25746` |
| `research/astra-joint-seed-maximum-audit.md` | `ac73e29474e272167403c91db34331236bb3832f7ce916b2997d7c2f0d6b46ac` |
| `research/astra-uniform-global-seed-geometry.md` | `3a4a825f3f801282eb39b469571bbd4cac3a4e1f768d58542b7c1555cd725524` |
| `.codex/config.toml` | `28212a53cf42cdc377df1f7dab040732d657e59d7bb97ee78791256d01d4bb2c` |
| `docs/project-workflow.md` | `2b42a133352b6b53ba2106fc73882733f176e04a0deffbb183b4c16eefd9cd67` |
| `research/workflow-policy.json` | `833c397b61d1ffdb994fb115019f6d60d6c1a62ff85f19cdd2c9f8ac3a979c8b` |
| `scripts/validate_workflow.py` | `250a3ce2a080f5835ac4fd2e4b2803568424c777cda5d421f9fe92efd34d5383` |

Current config, workflow, policy, and focused live state were read at startup
and after compaction. The gate was `research / in_progress`, with recorded
explicit start authorization `2026-09-05T04:12:25.208107+00:00`; the active
task bound this sole owned file and the requested Astra/xhigh route.
`python3 -B scripts/validate_workflow.py` exited 0 at both gate reads, printing
`workflow structural validation passed; it cannot certify mathematical validity.`
The focused prior-claim text search used
`rg -n -i 'collision.{0,70}gcd|gcd.{0,70}collision|component.{0,70}gcd|least.{0,40}frequen|residue.{0,40}gcd' research/astra-*md`;
it did not locate an earlier collision-gcd theorem. This is a bounded source
comparison, not a literature novelty claim.

All mathematical checks here are the displayed hand derivations. No numerical
program, search sweep, solver, Lean check, dependency operation, external model,
additional agent, or shared-state/Git write was used. Only this manuscript was
written. New mathematics awaits independent review.
