# Independent review of the cover-selection obstructions

Task `/root/cover_selection_review`; requested `gpt-6-astra/xhigh` on the
existing reviewer session. Observed model, effort, elapsed time and usage:
`null`. Assignment checkpoint `9aa78b83ad709d611fc0100fa8cb4f8f33b89223`.
Only this review is owned. The two complete frozen authors are bound below.

**Accept without corrections at their stated manuscript scopes.** The prime
family has every claimed deletion witness, no cheap closed subcover at the
sharp threshold, and one positive enlargement range excluding every cheap
subset. The three-speed open minimum is exactly 13/6. These examples have
`mu=alpha`; they refute the deletion/essentiality-only selection shortcut,
not a selection theorem using strict failure essentially. Shelving (E) is
a strategic branch decision, not a mathematical refutation of (E).

## Prime maximum and all deletion witnesses

Fix any prime `p>=7`, `n=p-1`, `v=(1,...,p-1)`, `alpha=1/p`, and
`beta=1/(p-1)`. The tuple is positive, distinct and primitive. A repeated
point among `0,t,...,(p-1)t` gives a zero norm. Otherwise their shortest
cyclic gap has length at most 1/p and joins indices with a nonzero absolute
difference in `{1,...,p-1}`. The corresponding norm is no larger than that
gap. At `t=1/p` every speed has norm at least 1/p. Hence exactly `mu=alpha`.

Deleting speed `p-1` leaves the witness `t=1/(p-1)`, with all phases in
`[beta,1-beta]`. For each other deleted label `1<=i<=p-2`, let `s=p-i>=2`,
choose the inverse `1<=k<p` with `ik=1 mod p`, and put

    t_i=k/p-1/[p(p-1)s].                                   (1)

This lies in `(0,1)`: the subtraction is less than `1/p`, and `k/p<1`.
Multiplication by k permutes the nonzero residues. The removed label has
residue 1; the distinct remaining label s has residue p-1 because p is odd.
Its fractional phase after (1) is exactly

    (p-1)/p-1/[p(p-1)]=(p-2)/(p-1)=1-beta.

Every other remaining label j has residue `2<=m<=p-2`. After subtracting
its original integer part, its phase is

    m/p-j/[p(p-1)s].

Since `j<=p-1` and `s>=2`, this is at least
`2/p-1/(ps)>=3/(2p)>=beta`; it is less than
`(p-2)/p<1-beta`. These positive bounds below one establish the claimed
unchanged integer part, not just a formal residue computation. Together
with the special s coordinate they prove every deletion's actual common
beta-witness. No lower-count conjecture or separately chosen row phases
enter this construction.

## Equality in the closed length budget, including the circular endpoint

For speed j and center `k/j`, the closed arc at width alpha has radius
`1/(pj)` and length `2/(pj)`. It is a proper positive-length circular arc.
The full closed family covers because `mu=alpha`. If an indexed subfamily
S covers and has cost `sum_S 1/j<=p/2`, then

    1 <= sum_S length(C_(j,k))=(2/p)cost(S)<=1.              (2)

Thus the sum of lengths is exactly the measure of the union. An overlap
of two interiors would have positive measure and contradict (2); all
selected interiors are disjoint.

This equality does force a single circular tiling. No selected endpoint
can lie in another selected interior, since then a one-sided neighborhood
would give an interior overlap. Cut the circle at a selected endpoint.
The arcs lift to intervals with disjoint interiors covering `[0,1]`.
In their increasing order each end equals the next start: a strict gap
contradicts coverage, and a reversed inequality contradicts disjointness.
There cannot be two successors at one endpoint, for the same reason.
Restoring the cut yields one cyclic chain, including its last-to-first edge.

For adjacent labels v,w with centers `k/v,l/w`, that edge gives

    (pk+1)/(pv)=(pl-1)/(pw) mod 1.

Clearing denominators, including a possible wrap integer m, yields

    p(kw-lv)+v+w=mpvw.

Consequently `v+w` is divisible by p. Since it is between 2 and `2p-2`,
it equals p. All labels on the one chain therefore alternate between a
single pair `{v,p-v}`; these labels differ because p is odd. The argument
does not discard the edge across the origin or allow unrelated cycles.

Such a pair cannot cover by its closed bad sets at `1/p<1/3`. Indeed for
any positive integer speeds `a<=b`, if `b<=2a`, then `t=1/(a+b)` gives both
norms `a/(a+b)>=1/3`. If `b>2a`, the interval
`[1/(3a),2/(3a)]` is entirely a-good at margin 1/3. Its length exceeds
`2/(3b)`. Were b bad with norm strictly below 1/3 throughout that connected
interval, the whole interval would lie in one real open b-bad component,
whose length is only `2/(3b)`, a contradiction. The resulting common
1/3-witness is strictly outside both closed bad sets of width 1/p.

There is also an independent contradiction using the deletion witnesses:
the seed for label i excludes every other label's closed bad set at alpha,
since `beta>alpha`. Thus every closed subcover must contain every label;
a two-label tiling cannot do so when `p-1>2`. Both closing arguments are
valid. No closed subcover at alpha has cost at most p/2.

## A single enlargement excludes all cheap subsets

The full index set has size `sum_{j=1}^{p-1}j=p(p-1)/2`, so its cheap
subsets form a finite family. For each nonempty cheap S, choose a point
t_S outside its closed union at alpha and set

    r_S=min_((j,k) in S) [j dist_T(t_S,k/j)-alpha]>0.

Strict positivity holds because the selected union is closed and the
chosen point is outside every selected arc; the minimum is finite. There
is at least one nonempty cheap subset, for example a single arc. Hence

    eta_p=(1/2) min(beta-alpha, min_nonempty_cheap_S r_S)>0,
    alpha+eta_p<beta.

For every `alpha<delta<alpha+eta_p`, each t_S remains outside all selected
closed arcs, as `j dist_T(t_S,k/j)>=alpha+r_S>delta`. The empty subset
never covers. Thus one and the same eta_p excludes every cheap subset,
even for closed coverage, and therefore for open coverage as well.

The full open family does cover at each such delta: every time has some
norm at most alpha and hence strictly below delta. The beta-witnesses are
independent of delta; all other labels remain outside their bad sets since
`delta<beta`. Each label is indispensable. This proves the full claimed
quantifier order without enumeration. No exact minimum cost for general p,
quantitative eta_p, or positive lower bound for eta_p uniform in p is asserted.
Unbounded primes make this one counterfamily at unbounded moving counts.

## Exact three-speed open minimum

For `v=(1,2,3)`, `n=3`, and `1/4<delta<1/3`, there are six original open
arcs. Those centered at zero for speeds 2 and 3 are contained in the
speed-one arc. Four arcs are forced individually in every subcover:

| Center and speed | Exclusive witness | Reason |
| --- | --- | --- |
| `0`, speed 1 | `1/6` | Norms are `(1/6,1/3,1/2)` |
| `1/3`, speed 3 | `1/3` | The other two norms equal `1/3` |
| `1/2`, speed 2 | `1/2` | The other two norms equal `1/2` |
| `2/3`, speed 3 | `2/3` | The other two norms equal `1/3` |

The indicated arc contains its witness strictly; all other arcs exclude it.
The four selected centers have cyclic gaps `1/3,1/6,1/6,1/3`, including
the wrap to zero. Their neighboring radius sums are
`4delta/3,5delta/6,5delta/6,4delta/3`. Each is strictly larger than its
gap, so these four open arcs themselves cover, without uncovered touching
endpoints. They are all forced, proving the exact minimum

    min_S cost(S)=1+1/3+1/2+1/3=13/6>2.                    (3)

The three actual deletion witnesses are `1/5` for `(2,3)`, with margin
`2/5`; `1/2` for `(1,3)`, with margin `1/2`; and `1/3` for `(1,2)`, with
margin `1/3`. These meet the native deletion target beta=1/3.
The full maximum is 1/4: on the half-period the author's intervals
`[0,1/4]`, `[1/4,5/12]`, `[5/12,1/2]` are bounded by speeds 1, 3, 2,
respectively, at margin 1/4, and time 1/4 attains it. Reflection covers
the other half. At delta=1/4 the open family misses the maximizing times,
so that excluded endpoint cannot be silently included in the covering claim.

## Hypothetical failure and the strategic disposition

The strategy's conditional setup is correct. A count-minimal positive
distinct primitive failure with `mu<alpha=1/(n+1)` has an actual beta=1/n
witness after each deletion. Otherwise a failing deletion, after removing
its common divisor by time scaling, contradicts count minimality; the
one-speed base case is direct. Height minimality is retained but not used
to derive any further structural fact in this attempt.

For `mu<delta<alpha`, the original open bad arcs cover, and every subcover
must retain each label because of those deletion witnesses. If the proposed
selection cost were at most `(n+1)/2`, its total length would be at most
`delta(n+1)<1`, contradicting coverage. This is a valid conditional
contradiction, not a derived selection theorem.

Both counterexamples instead have `mu=alpha`, and their open-cover widths
are above alpha. They therefore refute selection from actual open coverage,
label essentiality and deletion witnesses alone, but do not satisfy strict
failure or the complete minimal-failure profile. The smallest possible sum
of the three positive distinct speeds is not height minimality among failures.
A stronger selection implication using the full failure hypotheses remains
unresolved, as the authors explicitly state.

The historical energy and phase descriptions retain their limited scopes.
The accepted support and chamber obstructions do not refute (E); the cyclic
claim is independently accepted in the bound predecessor review. The strategy's
statement that this review was pending at its assignment is historical context.
Normalized phase averaging survives, while its coefficient, first-order
signal and fixed-density limitations supply no general actual-cover theorem.
The older seed-radius and arithmetic-profile sources explicitly leave their
uniform supply implications open. Their finite controls were not rerun or
treated as uniform proofs here.

Accordingly, the recommendation to shelve (E) records the absence of a sharp
step in this bounded route; it is not a proof that (E), all energy methods,
or all actual-cover methods fail. The first missing mathematical implication
is a sharp contradiction using an actual subcritical cover and justified
minimality essentially. These manuscripts supply exact obstructions to a
stronger shortcut, not that implication or an unrestricted formal result.

## Complete bindings and actual checks

Both frozen authors were read completely. Their 16 distinct declared input
bindings were checked against current bytes. Prior accepted results were
retained at their existing scope; the actually invoked phase and older
seed/profile claims were read at the relevant sections, without repeating
their old computational audits. Direct review bindings are:

| Complete source | SHA-256 |
| --- | --- |
| `research/astra-prime-progression-cover-cost.md` | `e5e26e0cffff1031dd1b14cd88f127ac5b624c2c798d22b0d0baa51e89a7ccd7` |
| `research/astra-uniform-strategy-after-energy.md` | `ee253b7ade891196bdf213250badac0ddf5992937eba32b625dbc9adb79f506e` |
| `research/astra-cyclic-global-compensation.md` | `06b3eabe5f9b8031801faa9d8f6aedd5a7d43f048bbd90656b0804943f8b3088` |
| `research/astra-cyclic-global-review.md` | `556974a0b6c0e31d5ea97569460893c86e5b13adc0941479f3a9322c400c5e03` |
| `research/astra-uniform-strategy-after-fold.md` | `e569596af4ebab9f9d5e1c796d8da435bc433c1c238bc10f9901e644f9f49871` |
| `research/astra-slack-energy-review.md` | `1c526b214e7772088555642447d5fa2f93030f40195fd4aaca7a79bb1f6bd573` |
| `research/astra-slack-energy-global-compensation.md` | `8032d020e4beccc1112b025c8b85f6be6c2ec5cb67cdd763d4ae62a029627cb9` |
| `research/astra-slack-energy-global-review.md` | `c6416983efcbeeb909449a372be2ff316647f0ab6d92ba4d199429bd35e75e79` |
| `research/astra-rational-cell-compensation.md` | `3304bb071092c71e6516b5c1e16b0d47d918f1c21042f7c47592865d2ac10076` |
| `research/astra-rational-cell-review.md` | `d6f17b4cb2188aa2b552fa30ac7643822dadf45c50dec63479737cc58decf62d` |
| `research/astra-phase-riesz-global-contract.md` | `66c83f09a66f169ef9e212d5e5d4ca32acc2fa3732c94def184d4015061ef848` |
| `research/astra-normalized-phase-signal.md` | `55f23f7eaed77263ef713783ef4d3083fd444f6b1c4f3ea398974afd81ef3a4e` |
| `research/astra-uniform-all-deletion-seed-screen.md` | `b2b6acd00dae3c8ed777bc3da4227fab0254016eec035c2c100f8d346a398f1b` |
| `research/astra-uniform-label-cut-profile.md` | `05b89f854f5076ffcfb139a19ea34a8ed6d9481c893211560aa443881bc89326` |
| `.codex/config.toml` | `28212a53cf42cdc377df1f7dab040732d657e59d7bb97ee78791256d01d4bb2c` |
| `docs/project-workflow.md` | `2b42a133352b6b53ba2106fc73882733f176e04a0deffbb183b4c16eefd9cd67` |
| `research/workflow-policy.json` | `833c397b61d1ffdb994fb115019f6d60d6c1a62ff85f19cdd2c9f8ac3a979c8b` |
| `scripts/validate_workflow.py` | `250a3ce2a080f5835ac4fd2e4b2803568424c777cda5d421f9fe92efd34d5383` |

Current config, workflow, policy and focused state were read; the gate was
`research/in_progress` with recorded 2026-09-05 start authorization and this
review active. `python3 -B scripts/validate_workflow.py` exited zero:
`workflow structural validation passed; it cannot certify mathematical validity.`
Final administrative readback checks the 18 bindings, newline, whitespace
and owned hash. No mathematical program, sweep, build, cache operation,
external model, additional agent, Git mutation, shared-state write, other-file
edit or memory edit was used. No correction to either frozen author is required.
