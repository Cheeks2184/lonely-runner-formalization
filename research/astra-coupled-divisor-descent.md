# Coupled divisor bundles and the count obstruction

Task `/root/coupled_divisor_descent`; assigned checkpoint
`37fbe1db726985a3254eac1ee7afcdc050e1faeb`. Requested route: Astra/xhigh;
observed model, effort, elapsed time, and token usage: null. This is a bounded
hand derivation awaiting independent review, not a kernel theorem.

Replacing one speed by a suitable bundle of its prime-divisor frequencies
does preserve a cover of the **whole** time circle. The bundle has more labels,
however, and does not automatically preserve failure at their native margin.
The exact mixed-threshold version is irredundant at every label, including
the retained original labels. The two approaches checked below yield no
extraction or alternative coordinate descent. A generic weighted-budget
shortcut is refuted; the full minimal-failure hypotheses are not refuted.

## 1. Hypotheses and the admissible prime bundle

Write `||x|| = dist(x,Z)` and `T = R/Z`. Assume that a positive distinct
primitive integer set `V` of n speeds is a strict ordinary failure, with least
moving count and then least sum among primitive failures of that count. Set

`n >= 2`, `N=n+1`, `alpha=1/N`, `mu=max_t min_{v in V} ||vt|| < alpha`.

Fix `m in V`, `m>1`, put `V0=V\{m}`, and use the entire deletion-good set

`W={t in T : ||vt|| >= alpha for all v in V0}`.

Least count supplies a point with all retained margins at least
`beta=1/n>alpha`, so W is nonempty and contains an interval. On all of W,
`||mt||<=mu`: every retained margin exceeds the full maximum. For a real
lift of t there is therefore a unique nearest integer k such that

`mt=k+e`, `|e|<=mu<1/2`.

Let K be **all** attained k modulo m, including collisions from singleton
components of W. It is finite and nonempty; divisibility by any p dividing m
does not depend on the lift. Assume the branch hypothesis

`gcd(k,m)>1 for every k in K`.                                         (1)

We briefly rederive the minimality used here. If `1<=u<m` were strictly
alpha-bad on all W, replacing m by u would preserve the full alpha-cover:
the new row blocks W and a retained row blocks its complement. Compactness
would make the replacement's maximum strictly below alpha. A duplicated u
is impossible because W is nonempty; otherwise gcd normalization preserves
the maximum and decreases the primitive sum. This contradicts minimality.
Consequently each smaller u has an alpha-good point in W. In particular no
prime p dividing m divides every k in K, since then `u=m/p` has norm at most
`mu/p` everywhere on W. Equivalently, `gcd(m,K)=1`.

Let `P_act` consist of the primes p dividing m that divide at least one
attained k. If `m/p` were already in V0, an attained p-divisible collision
would give both `||(m/p)t||>=alpha` and `||(m/p)t||=|e|/p<=mu/p<alpha`.
Thus every active bundle frequency is absent from the retained speeds.

By (1), some subset P of `P_act` hits every k by divisibility. Choose P
inclusion-minimal and put `b=|P|`, `sigma=sum_{p in P} 1/p`. Then:

* `b>=2`, because a singleton hitting set would give a common collision prime.
* For each p in P there is an attained `k_p` divisible by p and by no other
  prime in P. This follows by removing p from a minimal hitting set.
* `U={m/p : p in P}` contains b distinct positive speeds below m, all outside
  V0. Therefore `V_B=V0 union U` has exactly `n+b-1` speeds.
* `V_B` is already primitive. A common divisor of V0 and U divides m through
  any one member of U, hence divides all original speeds and is 1.

These facts use actual attained collisions, not an arbitrary residue model.

## 2. First approach: whole-time transport followed by count extraction

For t in W choose p in P dividing its collision k. Then

`||(m/p)t||=|e|/p<=mu/p<alpha`.                                        (2)

For t outside W an old retained speed is strictly alpha-bad. Hence

`max_t min_{v in V_B} ||vt|| < alpha`.                                 (3)

The strict maximum follows from continuity on the compact circle after
proving pointwise strict coverage. This is the exact global transport.
It does **not** give a maximum at most mu: K only describes W, leaving times
where the retained minimum is between mu and alpha uncontrolled at level mu.

The native margin of `V_B` is `1/(n+b)<alpha`. Thus (3) alone does not make
`V_B` an ordinary failure. Its speed sum is exactly

`sum(V_B)=sum(V)-m+m sigma`.                                          (4)

For b=2, distinct primes give `sigma<=1/2+1/3=5/6<1`, so the sum decreases,
but the count increases by one. Least-count-then-sum minimality cannot compare
these two tuples. For b>=3, even the sum need not decrease: the prime set
`{2,3,5}` has reciprocal sum `31/30`. This last calculation is not an assertion
that this prime set occurs in a minimal failure.

The precise desired extraction would be a subset Q of `V_B` still giving an
open alpha-cover, with either `|Q|<n`, or `|Q|=n` and `sum(Q)<sum(V)`.
In the first case its native margin is at least alpha, contradicting least
count after gcd normalization. In the second case normalization contradicts
least sum. If `sigma<1`, every subset already satisfies the sum comparison,
so any alpha-cover using at most n of the new labels would be enough. This
specifies the missing theorem; minimizing a subcover does not prove it.

There is a concrete obstruction to the simplest deletion attempt. For each
p choose an actual t_p in W with collision `k_p`. For q in P other than p,
the reverse triangle inequality gives

`||(m/q)t_p|| >= ||k_p/q||-|e|/q >= (1-mu)/q`.                         (5)

If every prime in P is at most n, then
`(1-mu)/q > (1-alpha)/q = n/(Nq) >= alpha`.
Thus at t_p only the p-bundle label is alpha-bad: all old labels are good by
membership in W. Every new bundle label is therefore indispensable in the
full common-alpha cover. Any extraction to n labels must retain U and remove
at least `b-1` original retained labels. No claim of common-alpha privateness
is made for a prime exceeding n; nondivisibility then need not ensure (5)
reaches alpha.

For an old-label removal set `R subset V0`, the candidate `U union (V0\R)`
can develop new holes at

`G_R={t : ||ut||>=alpha for all u in U,
           ||vt||>=alpha for all v in V0\R}`.                         (6)

The transport proves only `G_empty=empty`. Every point of a nonempty G_R
must have at least one removed old label alpha-bad, by the full bundle cover.
There is an exact all-removal-set consequence of minimality. For any
`J subset V0` with `|J|=b-1` and

`m+sum(J)>m sigma`,

the replacement `U union (V0\J)` has n distinct labels and smaller sum.
Gcd normalization cannot increase its sum and preserves its maximum, so
minimality supplies an alpha-witness: `G_J` is nonempty. At that witness at
least one member of J is alpha-bad. For b=2 the sum condition holds for
every one-element J, since `sigma<=5/6`. Thus minimality supplies new holes
for **every** such admissible removal, not a common point or an R whose holes
are absent. This is an exchange constraint, not a contradiction or a new
uniform witness-supply theorem. When `b-1>n-1` there is no J of this size.

More generally a subbundle `P' subset P` and removal set R give a candidate
with count `n-1-|R|+|P'|` and sum `sum(V)-m-sum(R)+m sum_{p in P'}1/p`.
Extraction requires its entire common-alpha good set to be empty as well as
the count/sum comparisons above. When some primes exceed n, (5) does not
force every divisor label to remain; no subbundle extraction is established.

The collision hypothesis (1) does not itself provide coverage on the enlarged
deletion sets in (6). All coordinate-minimality conditions concern replacements
retaining every other original label; their
witnesses may depend on the coordinate and replacement. They supply neither
an R with `G_R=empty` nor a different single lowering frequency. In particular,
under the full hypotheses and `sigma<1`, any such successful extraction would
contradict minimality, rather than follow from minimality without further
arithmetic input. No counterexample satisfying those full hypotheses is
constructed here.

## 3. Second approach: exact mixed thresholds and their limits

For a speed w write `B_w(a)={t:||wt||<a}`. Let
`B_{m,k}(alpha)={t:dist_T(t,k/m)<alpha/m}` be an original individual grid arc.
For every prime p dividing m there is the exact set identity

`B_{m/p}(alpha/p)
   = union_{k mod m, p|k} B_{m,k}(alpha) subset B_m(alpha)`.            (7)

Indeed the left-hand grid centers are `l/(m/p)=pl/m` and their radius is
`(alpha/p)/(m/p)=alpha/m`. The original arcs are disjoint because
`alpha<1/2`; equivalently their nearest collision index is unique. Equation
(7) retains the whole original grid and its actual time coordinate.

Assign threshold alpha to each retained speed and alpha/p to each m/p.
At t in W, (2) is strictly below alpha/p; outside W an old row is bad.
Thus these mixed open bad sets also cover T. At a p-private collision t_p,
the p-label is bad while, for every q other than p,

`||(m/q)t_p|| >= (1-mu)/q > alpha/q`,

since `1-mu>alpha`. All old labels are good. Hence each bundle label has a
private point for this mixed cover, with no restriction p<=n.

All the original retained labels have private points as well. Fix j with
`v_j in V0`. Least count supplies a time s_j where every original row other
than j has margin at least beta. Original failure gives `||v_j s_j||<=mu`.
In particular `||m s_j||>=beta`, and for each p,

`||(m/p)s_j|| >= ||m s_j||/p >= beta/p > alpha/p`,                     (8)

using `||px||<=p||x||`. All other retained old rows exceed alpha. Thus j
alone is mixed-bad at s_j. This uses all original deletion sets: the mixed
cover has **n+b-1 indispensable labels**. Deleting labels from this same mixed
family cannot lower its count at all. Enlarging bundle thresholds to alpha
does not preserve the guarantee in (8), which does not settle (6).

The total threshold sum and largest threshold are

`S=alpha(n-1+sigma)`, `a_max=alpha`,
so `S+a_max=alpha(n+sigma)<=1` whenever `sigma<=1`.                    (9)

There is no valid generic implication from this numerical budget to a
simultaneous weighted witness. An exact control, supplied by the orchestrator
and checked here, is the primitive speed tuple `(1,2,3)` with thresholds

`(a_1,a_2,a_3)=(13/50,11/50,13/50)`.

Their sum plus maximum is 1. The first constraint restricts t modulo 1 to
`[13/50,37/50]`. The third has good intervals
`[(k+13/50)/3,(k+37/50)/3]`, `k=0,1,2`. The k=0 interval ends at
`37/150<13/50`; the k=2 interval begins at `113/150>37/50`. Their common
good set is consequently exactly `[21/50,29/50]`, where

`||2t||<=4/25<11/50`.

There is no weighted closed witness, and the mixed open bad sets cover T.
Even a strict numerical budget is insufficient: changing only a_2 to 9/50
keeps `4/25<9/50` and gives `S+a_max=24/25<1`.
These are unequal-threshold controls, not ordinary strict LRC failures and
not counterexamples to the special prime-bundle threshold pattern. They
exclude precisely the generic budget rule that would otherwise be used on
(9). A theorem for the special pattern would require further arithmetic
content; no such theorem is established here.

## 4. Outcome and checks

The new proved transport is (2)--(4), with exact count, distinctness, and
primitivity. The full-grid mixed identity (7) and private-point arguments
(5), (8) explain why straightforward label pruning does not close the descent.
The first unresolved implication is an admissible extraction in section 2
under the full coupled hypotheses, or an actual alternative single-coordinate
lowering. No implication of that strength was established in this attempt.
The weighted numerical shortcut is false in its stated generic scope; the
ordinary failure branch and unrestricted LRC remain unresolved.

The preceding minimal-frequency input was frozen at the hash below and under
independent review when assigned. Its used minimality facts are rederived in
section 1; no review status or kernel status is self-promoted here. Earlier
divisor minimality supplies context only, not an additional unproved premise.
All mathematics above was checked by hand; no mathematical program, solver,
build, cache operation, external model, new agent, Git operation, or shared
state edit was performed. Only this owned manuscript was written.

Current project instructions and the focused research/in-progress state were
read at startup and resumption. `python3 -B scripts/validate_workflow.py`
exited 0 with `workflow structural validation passed; it cannot certify
mathematical validity.` Source hashes were read with `sha256sum`:

| Input | SHA-256 |
| --- | --- |
| `.codex/config.toml` | `28212a53cf42cdc377df1f7dab040732d657e59d7bb97ee78791256d01d4bb2c` |
| `docs/project-workflow.md` | `2b42a133352b6b53ba2106fc73882733f176e04a0deffbb183b4c16eefd9cd67` |
| `research/workflow-policy.json` | `833c397b61d1ffdb994fb115019f6d60d6c1a62ff85f19cdd2c9f8ac3a979c8b` |
| `scripts/validate_workflow.py` | `250a3ce2a080f5835ac4fd2e4b2803568424c777cda5d421f9fe92efd34d5383` |
| `research/astra-minimal-frequency-synthesis.md` | `03cf038021f0bc1a2328bb77a02f6ab4fe649f5d3626d7bc368a67cd6c7b0000` |
| `research/astra-uniform-divisor-minimality.md` | `8c4b6ee094f0f311f360d3abf371e95f731e28cee997d3810dd3218ff6f25746` |
