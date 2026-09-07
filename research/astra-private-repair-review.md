# Independent review of private-region repair

Task `/root/private_repair_review`, executed in the existing
`/root/coordinate_cancellation_review` session. Requested route:
`gpt-6-astra/xhigh`; observed model, effort, elapsed time and usage: `null`.
Assignment checkpoint: `4ee48f74a1a2c7cfd163f42f4143c3d961bc2036`.
Only this review is owned. The frozen author and all other files are preserved.

**Accepted at manuscript scope, with no correction required.** Actual collision
indices force their specific original arcs, and the open-alpha limit preserves
the stated geometric restrictions. The simultaneous-replacement witness
constraints and complete two-speed control are exact. The control refutes
transport from repair of all private regions as a general rule; it is neither
a descending replacement nor a canonical strict-failure counterexample.
No global coverage theorem under the full minimum hypotheses is supplied.

## Forced indexed arcs and the information being used

Assume a positive distinct primitive integer n-tuple v is a strict ordinary
failure, minimal first by moving count and then by primitive sum. Put
`N=n+1`, `alpha=1/N` and `mu=max_t min_i ||v_i t||<alpha`, on `T=R/Z`.
The active branch has `N>=7`, hence `n>=6`. Use the entire deletion-good sets

```text
W_i={t : ||v_j t||>=alpha for all j!=i}.
```

The accepted minimal-frequency result supplies nonemptiness, the bound
`||v_i t||<=mu` on every point of W_i, and all smaller-frequency witness
constraints. Its collision residues K_i include all components, including
singletons. For `m=v_i`, an attained residue k has an actual realizing point
with a lift `mt=k+e`, `|e|<=mu<1/2`; changing a time lift changes k by a
multiple of m. None of these inputs is a statement about only chosen seeds.

Fix `mu<delta<alpha`. The individual arc indexed by `(i,k)` is

```text
I_(i,k)(delta)={t : dist_T(t,k/m)<delta/m}.
```

Its realizing point belongs strictly to this arc, while every other original
label has norm at least alpha and belongs to none of its delta-bad arcs.
The same-label arcs are disjoint because `delta<1/2`, so no second index of
label i contains the point either. This proves that EVERY subcover of the
complete original delta-family contains this particular arc index, not
merely some arc of label i. The complete family covers since `delta>mu`.
Thus a primitive collision for a prime-power speed gives a forced primitive
arc. It does not put its center in W_i or establish a unit transition.

Choose a minimum reciprocal-cost subcover. Every forced arc belongs to it.
The accepted winding geometry applies: its hypothesis `n>=3` holds, and
`delta<alpha<=1/7<1/4`. To check the substantive bound, at most one original
arc has label 1, while every other reciprocal label is at most `1/2`.
Any three distinct indices therefore have total arc length at most
`2delta(1+1/2+1/2)=4delta<1`. A cut outside three intersecting selected arcs
makes them real intervals. Containment, or the middle interval after ordering
their endpoints, would make one removable, contradicting positive-cost
minimality. Hence the selected subcover and its forced subfamily have no
triple intersection. This conclusion is not about all original arcs.

The same realizing points force the open width-alpha arcs: every other norm
is at least alpha and so is excluded from its open bad set, even at equality.
If three forced alpha-arcs met at x, each indexed phase error at x would be
strictly below alpha. Choose delta above the maximum of mu and these three
errors, and strictly below alpha. The same three indexed arcs would already meet at
that smaller width, contradicting the preceding result. Thus no triple
intersection appears at the OPEN alpha limit. This argument makes no claim
about triple contacts of closed alpha-arcs. Each forced alpha-arc also has
its original private point outside the union of all other forced arcs, so
it cannot be contained in that union.

The data `(v_i,K_i)` retains the actual grid centers `k/v_i` and their forced
arcs. It does not justify replacing the geometry by arbitrary residues.
What the proposed residue calculation does not use is the realizing offset
set `E_(i,k)={v_i t-k : t in W_i with the chosen collision lift}`, together
with the common-time regions where several old labels are bad. The full
original speeds still determine these sets; the report does not claim they
cannot be recovered from v. Nor does it claim the forced family always covers
the whole circle.

## Complete repair and all simultaneous-replacement witnesses

Let `A(t)={i:||v_i t||<alpha}` and `U_S={t:A(t)=S}`. Strict failure makes
A(t) nonempty at every time. Moreover

```text
W_i=U_{ {i} }.
```

One direction uses `||v_i t||<=mu<alpha` on W_i; the other is immediate
from the good conditions on every other coordinate. This equality retains
the closed old-good boundaries. It is stronger than an informal description
of a selected seed neighborhood.

For a proposed new tuple w, condition (R) states that every point of every
W_i is strictly alpha-bad for some new coordinate. Thus it guarantees coverage
of all regions with one old bad label. It does not assert coverage at times
with two or more old bad labels.

Now suppose w is positive, distinct, has n coordinates and smaller sum than
v, and agrees with v outside a changed index set I. If it had no closed
alpha-witness, continuity on compact T would give a strict failure. Dividing
its common gcd preserves the ordinary maximum and count and cannot increase
its already smaller sum, contradicting height minimality. Hence a new
closed alpha-witness exists. For EVERY such witness t, an old bad label
outside I would remain new-bad, so `A(t) subset I`. If (R) also holds, A(t)
cannot be a singleton, since t would belong to a repaired W_i. Therefore

```text
A(t) subset I,   |A(t)|>=2.
```

No common witness independent of the proposed replacement is asserted.
For exactly two changed coordinates i,j this gives `A(t)={i,j}` and

```text
||w_l t||>=alpha for every l,
||v_i t||<alpha,   ||v_j t||<alpha,
min(||v_i t||,||v_j t||)<=mu.
```

The unchanged old coordinates are all at least alpha, hence exceed mu; the
old global maximum therefore bounds the minimum of the two changed old
norms. It does not bound both individually. These are witness-location
constraints under actual minimum hypotheses, not a contradiction and not
a construction of a repair satisfying (R).

The joint-seed maximum audit has a different two-bad-label statement: at
specified times reached from an extremal strong seed, in particular in its
fastest-maximizing-pivot case, at least two retained labels are bad at the
stronger deletion margin. The present statement uses canonical alpha and
every new witness after simultaneous replacement and full private repair.
Neither assertion supplies an original deletion seed at that time. The two
thresholds and two witness domains cannot be interchanged.

## Exact full-private-repair control

Use the separate test width `a=5/12` and the old tuple `(1,2)`.
Its maximum is exactly `1/3`: where `||t||<=1/3` use speed 1; otherwise the
representative lies in `[1/3,2/3]`, and `||2t||<=1/3` there. At `t=1/3`
both norms equal `1/3`. Thus the old open a-bad sets cover. Every positive
one-speed tuple has maximum `1/2>a`, and two distinct positive integers have
sum at least 3. Hence this primitive old tuple really is least by count and
sum among covers at the FIXED test width a. Its only smaller positive
replacement for speed 2 is the retained speed 1, which is good on W_2;
speed 1 has no smaller positive replacement. The one-coordinate conditions
at this test width hold, with no fresh lowering available.

Solving the retained good inequalities gives the complete sets

```text
W_1=[5/24,7/24] union [17/24,19/24],
W_2=[5/12,7/12].
```

All displayed intervals use real representatives in one period. For the new
tuple `(5,8)`, speed 8 sends the two W_1 intervals to real phase intervals
`[5/3,7/3]` and `[17/3,19/3]`. Their nearest integers are 2 and 6,
respectively, with error at most `1/3<a`. Thus speed 8 alone repairs ALL
of W_1, including its endpoints.

On W_2, `5t` ranges over `[25/12,35/12]` within the same integer phase band.
The exact a-good portion requires `5t in [29/12,31/12]`, hence
`t in [29/60,31/60]`. On that entire closed portion,
`8t in [58/15,62/15]`, giving `||8t||<=2/15<a`. Everywhere else in W_2,
speed 5 is strictly a-bad. The two points where its norm equals a are
included in the speed-8 repair. Therefore the new tuple satisfies (R) on
BOTH entire old deletion-good sets, with all endpoint signs correct.

Nevertheless, at `t0=5/16`, the exact old and new norms are

```text
old: (5/16,3/8),   both < 5/12;
new: (7/16,1/2),   both > 5/12.
```

This is a common-time witness missed by both private sets, lying in the
two-old-bad region. Also `5/16<1/3<3/8`: only one old norm is at most the
old maximum, illustrating why a bound on both would be invalid.

The new minimum at t0 exceeds a by exactly `1/48`. Both new norms are
8-Lipschitz or better, so whenever `|h|<1/384`,

```text
min(||5(t0+h)||,||8(t0+h)||)>=7/16-8|h|>5/12.
```

Both old norms stay strictly bad on this neighborhood too: their maximum
is at most `3/8+2|h|<3/8+1/192<5/12`. Thus the hole contains an open
interval and is not caused by a singleton or boundary convention.

The two forced old arcs at width a are the speed-1 arc centered at zero,
radius `5/12`, and the speed-2 arc centered at `1/2`, radius `5/24`.
Private points in the displayed W_1 and W_2 force their respective indices.
They cover the circle because the full speed-1 good interval
`[5/12,7/12]` lies strictly inside the second arc
`(7/24,17/24)`. The other speed-2 arc, centered at zero, is contained in
the speed-1 arc. The missed t0 lies in both forced arcs:
`5/16<5/12` and `|5/16-1/2|=3/16<5/24`. Even when the forced family
covers, repairing only its private regions therefore does not repair its
overlaps. This direct two-arc calculation does not invoke the small-width
winding lemma outside that lemma's hypotheses.

The scope restrictions are substantive. The old tuple's native canonical
margin is `1/3`, equal to its maximum, so it is LRC-good. The test width is
larger, and the new sum is `5+8=13>1+2=3`. The control therefore refutes
only the general implication from (R) to cover transport, even with fixed-
test-width minimality. It does not refute an argument that essentially uses
canonical strict failure and a smaller-sum replacement.

## First gap, bindings and actual checks

The first unresolved implication is control of common-time overlap regions
for an admissible lowering: repairing all W_i does not account for times with
multiple old bad labels. The forced-arc restrictions do not exclude two-old-
bad regions, and the no-triple statement concerns the forced subfamily or a
chosen irredundant subcover, not the entire original family. No independent
argument excluding the new witnesses located above has been supplied.
Unrestricted LRC remains open; no narrower formalization is established.

The complete frozen author was read and independently checked by hand. All
five mathematical inputs below had already been read in full in this same
session; their unchanged hashes were checked here. Their invoked collision,
winding and joint-seed claims were checked at the exact scopes described
above. No divisor-bundle manuscript or unreviewed bundle premise is needed
for any conclusion in this review. Earlier whole audits and mathematical
programs were not rerun.

| Input | SHA-256 |
| --- | --- |
| `research/astra-coupled-descent-strategy.md` | `d9a029cb16c866a45741f97841f3b007d4823f86712fe827e899801208289bb2` |
| `research/astra-minimal-frequency-synthesis.md` | `03cf038021f0bc1a2328bb77a02f6ab4fe649f5d3626d7bc368a67cd6c7b0000` |
| `research/astra-minimal-frequency-review.md` | `b26182c2e482e7f83480eab9904779b958eb8b8b753c70bc45c6fabec55b747d` |
| `research/astra-arithmetic-winding-exchange.md` | `6fbd8b96223e1697c33d5e187c25fb9f93707c880f2794892dfa16ca0ab2d6d4` |
| `research/astra-arithmetic-winding-review.md` | `45eca69dd2c8b48a0cec68ca737262b9f1a616b08f85046629c9c4e632618243` |
| `research/astra-joint-seed-maximum-audit.md` | `ac73e29474e272167403c91db34331236bb3832f7ce916b2997d7c2f0d6b46ac` |
| `.codex/config.toml` | `28212a53cf42cdc377df1f7dab040732d657e59d7bb97ee78791256d01d4bb2c` |
| `docs/project-workflow.md` | `2b42a133352b6b53ba2106fc73882733f176e04a0deffbb183b4c16eefd9cd67` |
| `research/workflow-policy.json` | `833c397b61d1ffdb994fb115019f6d60d6c1a62ff85f19cdd2c9f8ac3a979c8b` |
| `scripts/validate_workflow.py` | `250a3ce2a080f5835ac4fd2e4b2803568424c777cda5d421f9fe92efd34d5383` |

Current project config, workflow, policy and focused state were read. The
state recorded `research/in_progress`, explicit 2026-09-05 start authorization,
this task, its requested route, assignment checkpoint and sole owned file.
`python3 -B scripts/validate_workflow.py` exited 0 with complete output:

```text
workflow structural validation passed; it cannot certify mathematical validity.
```

`sha256sum` matched all ten displayed bindings. Final administrative Python
checks verified them again, a final newline and no trailing whitespace,
and returned this review's frozen hash separately. The review was read back
in full. All commands exited 0; no mathematical error or author correction
was found. No mathematical program, enumeration, search, solver, build,
cache operation, external model, new agent, Git mutation, shared-state edit,
memory write or other-file edit was performed. This is independent manuscript
acceptance, not a kernel-checked theorem or project completion.
