# Prime progressions: an unbounded cover-cost counterfamily

Task `/root/prime_cover_cost_control`; requested `gpt-6-astra/xhigh`.
Observed model, effort, elapsed time and usage: `null`. Assignment checkpoint:
`965b44907280f7775e7dcd2cad4d5bbfda2fecff`. Only this manuscript is owned.
The orchestrator proposed the argument; it is checked and completed here.
Status: new manuscript proof awaiting independent review, not a kernel theorem.

**Result.** For every prime `p>=7`, put `n=p-1`, `v=(1,...,p-1)`,
`alpha=1/p` and `beta=1/(p-1)`. There exists `eta_p>0`, with
`alpha+eta_p<beta`, such that for every

    alpha < delta < alpha+eta_p,

the full open bad-arc family covers the circle, every deletion has an actual
common beta-witness, and every subcover has cost strictly greater than
`p/2=(n+1)/2`. The cost of an arc of speed j is `1/j`.
This refutes the essentiality-only cost bound at unbounded moving counts,
including counts beyond the six-total-runner milestone. The actual maximum
is `mu=alpha`, so the family does not satisfy strict failure `mu<alpha`.

## Maximum and every deletion witness

All speeds are positive, distinct and primitive. For any time t, a shortest
cyclic gap among the p points `0,t,...,(p-1)t` has length at most `1/p`.
If two points coincide the conclusion is immediate; otherwise the gap joins
two indices whose absolute difference is in `1,...,p-1`. That difference
speed has circle norm at most the gap. Conversely, at `t=1/p` every speed
has norm at least `1/p`. Hence exactly

    max_t min_(1<=j<p) ||j t|| = alpha.                     (1)

Now delete a speed i. If `i=p-1`, use `t=1/(p-1)`: the remaining phases
`j/(p-1)`, `1<=j<=p-2`, lie in `[beta,1-beta]`.

If `1<=i<p-1`, put `s=p-i>=2`, choose `1<=k<p` with `ik=1 mod p`, and set

    t_i=k/p - 1/[p(p-1)s].                                (2)

The time lies in `(0,1)`. Multiplication by k permutes the nonzero residues
modulo p. The deleted speed i has residue 1. Since p is odd, `s!=i`, and
this remaining speed has residue `p-1`. Its fractional phase after the
subtraction is

    (p-1)/p - s/[p(p-1)s] = 1-beta.

For every other remaining speed j, its residue m is in `2,...,p-2`.
Its phase, after removing the unchanged integer part, is

    m/p - j/[p(p-1)s].

It is bounded below by

    2/p - 1/(ps) >= 3/(2p) >= 1/(p-1)=beta,

and bounded above by `(p-2)/p < 1-beta`. Thus there is no integer crossing,
and every remaining norm is at least beta. These inequalities hold for the
stated primes, with the last lower inequality already valid for `p>=3`.
Equations (1)--(2) establish every deletion's own-margin witness directly;
no unproved lower-count theorem or independent phase choice is used.

## A cheap closed subcover would be an exact tiling

Write `dist_T` for distance on the unit circle. For each speed `1<=j<p`
and `0<=k<j`, define the closed arc and its open counterpart by

    C_(j,k)(delta)={t: dist_T(t,k/j)<=delta/j},
    O_(j,k)(delta)={t: dist_T(t,k/j)< delta/j}.

For `0<delta<1/2`, each has length `2delta/j`. Their respective unions over
k are the closed and open bad sets for speed j. For an index subset S put

    cost(S)=sum_((j,k) in S) 1/j.

At `delta=alpha`, the full CLOSED family covers by (1). Suppose a subfamily
S also covers and `cost(S)<=p/2`. Then

    1 <= sum_(S) length(C_(j,k)(alpha))
      = (2/p)cost(S) <= 1.

Equality holds throughout. In particular, no two selected arcs overlap on
an interval of positive length: such overlap would make the sum of lengths
strictly greater than the length of their union. All arcs have positive
length less than one. A finite cover by such closed arcs with disjoint
interiors is a cyclic tiling. To check the endpoint issue, every terminal
endpoint must be the initial endpoint of an arc immediately following it;
otherwise finiteness leaves a gap. Two arcs cannot both follow it, or their
interiors would overlap. This gives one cyclic chain around the circle.

Let consecutive arcs in this chain have speeds v,w and centers `k/v,l/w`.
Their oriented end and start match modulo one:

    (pk+1)/(pv) = (pl-1)/(pw) mod 1.

For some integer m, clearing denominators gives

    p(kw-lv)+v+w = mpvw.

Thus `v+w=0 mod p`. Since `1<=v,w<=p-1`, necessarily `v+w=p`.
Each successor label is therefore the complement of its predecessor.
The entire tiling uses only one pair `{v,p-v}`; oddness of p excludes
coincidence of the two labels. This argument includes the endpoint across
the chosen origin because its equality was explicitly taken modulo one.

But no two-speed closed bad sets cover at width `1/p<1/3`. Here is a direct
proof of the stronger common margin `1/3` for any positive speeds `a<=b`.
If `b<=2a`, take `t=1/(a+b)`: both norms equal `a/(a+b)>=1/3`.
If `b>2a`, all points in

    J=[1/(3a),2/(3a)]

are a-good at `1/3`. This interval has length `1/(3a)>2/(3b)`.
If every point of J had `||bt||<1/3`, connectedness would place J inside
one real bad component `((k-1/3)/b,(k+1/3)/b)`, whose length is only
`2/(3b)`. This is impossible. Some point therefore has both norms at least
`1/3`, strictly above `1/p`, and lies outside both closed bad sets.

Alternatively, the deletion witnesses already show that every original label
must occur in any closed subcover at alpha: all other labels have norm at
least `beta>alpha` at its deletion witness. A tiling using only two labels
cannot satisfy that necessity when `p-1>2`. Either argument completes the
contradiction. Hence

    no closed subcover at alpha has cost <= p/2.            (3)

## One enlargement range works for every cheap subset

There are only `p(p-1)/2` arc indices, so there are finitely many index
subsets with cost at most `p/2`. No enumeration or quantitative estimate
is required. Ignore the empty subset, which never covers.

For each nonempty such S, (3) supplies a point `t_S` outside its closed
union at alpha. Its slack from every selected closed arc is strictly positive.
Define the slack in threshold units by

    r_S=min_((j,k) in S) [j dist_T(t_S,k/j)-alpha] > 0.

The collection of nonempty cheap subsets is nonempty (it includes any
single arc). Let

    eta_p=(1/2) min(beta-alpha, min_(nonempty cheap S) r_S).

This is positive and satisfies `alpha+eta_p<beta`. If
`alpha<delta<alpha+eta_p`, each point t_S remains outside its selected
closed arcs, since `j dist_T(t_S,k/j)>=alpha+r_S>delta`.
Thus every cheap S still fails even closed coverage, and in particular
fails open coverage. Taking a minimum across all such subsets is essential;
a separate enlargement for each S would not prove the asserted quantifiers.

On the other hand, (1) implies that the full OPEN family covers whenever
`delta>alpha`: at each time some norm is at most alpha, hence strictly below
delta. The beta-witnesses from (2) and the special last deletion do not depend
on delta. Since `delta<beta`, each label is indispensable in this open cover.
This proves the result with all endpoints and quantifiers as stated.

## Exact scope and remaining implication

Primes p are unbounded, so this is a single parameterized counterfamily,
not a sequence of individual runner-count milestones. It strengthens the
previous three-speed control: actual open coverage and every own-margin
deletion witness do not force cost `<= (n+1)/2`, even at unbounded counts.
No exact minimum cost or quantitative eta is asserted.

The family has the sharp closed witness `mu=alpha`; its open covers here
use `delta>alpha`. It does not satisfy a hypothetical failure `mu<alpha`,
nor supply the complete minimal-failure profile. Therefore it does not
refute a selection implication using those full hypotheses essentially.
Deriving such a sharp implication remains unresolved; no positive
replacement mechanism, proof or disproof of unrestricted LRC, or new
formal implementation follows from this obstruction.

## Source bindings and actual checks

The root derivation was read in the assignment and focused
`prime_cover_root_derivation` state record. Its full mathematics is preserved
above, with independent hand checks here; a separate review is still required.
The preceding strategy manuscript was verified unchanged.

| Input | SHA-256 |
| --- | --- |
| `research/astra-uniform-strategy-after-energy.md` | `ee253b7ade891196bdf213250badac0ddf5992937eba32b625dbc9adb79f506e` |
| `.codex/config.toml` | `28212a53cf42cdc377df1f7dab040732d657e59d7bb97ee78791256d01d4bb2c` |
| `docs/project-workflow.md` | `2b42a133352b6b53ba2106fc73882733f176e04a0deffbb183b4c16eefd9cd67` |
| `research/workflow-policy.json` | `833c397b61d1ffdb994fb115019f6d60d6c1a62ff85f19cdd2c9f8ac3a979c8b` |
| `scripts/validate_workflow.py` | `250a3ce2a080f5835ac4fd2e4b2803568424c777cda5d421f9fe92efd34d5383` |

Read current configuration, workflow, policy and focused task. The state was
`research/in_progress`, with explicit 2026-09-05 start authorization.
`python3 -B scripts/validate_workflow.py` exited zero with
`workflow structural validation passed; it cannot certify mathematical validity.`
Complete hashes were checked with `sha256sum`. No mathematical program,
sweep, build, cache operation, Git operation, shared-state edit, additional
agent, external model, external retrieval or memory write was used. Only this
manuscript changed; all earlier evidence remains frozen.
