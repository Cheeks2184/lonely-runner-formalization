# Independent review of coupled divisor bundles

Task `/root/coupled_divisor_review`, executed in the existing
`/root/coordinate_cancellation_review` session. Requested route:
`gpt-6-astra/xhigh`; observed model, effort, elapsed time and usage: `null`.
Assignment checkpoint: `eade37d00c179fe6cc7837c4960cd58add0d572e`.
Only this review is owned; the frozen author and all other files are preserved.

**Accepted at manuscript scope, with no correction required.** The prime
bundle preserves a whole-circle cover at the original margin, with the stated
freshness, primitivity, count and sum. All removal-set and private-point
arguments are valid. The exact mixed cover has every label indispensable.
The weighted controls refute the generic numerical-budget implication only;
they do not refute the special bundle pattern or actual minimal failure.
No admissible extraction, alternative descent or unrestricted LRC result is
established.

## Whole deletion set, hitting primes and admissibility

Assume a positive distinct primitive set V of n moving integer speeds,
`n>=2`, is a strict failure, minimal first by count and then by primitive
sum. Put `N=n+1`, `alpha=1/N<1/2` and
`mu=max_(t in T) min_(v in V)||vt||<alpha`, where `T=R/Z`.
Fix `m in V`, `m>1`, and write

```text
V0=V\{m},
W={t : ||vt||>=alpha for every v in V0}.
```

Least count supplies the deletion's own margin `beta=1/n>alpha`, after gcd
normalization and time rescaling if necessary. Thus W is nonempty and has
an interval; its finite closed-component decomposition may also contain
singletons. On ALL of W, the deleted norm is the full minimum, so
`||mt||<=mu`. The representation `mt=k+e`, `|e|<=mu`, has unique integer k
because `2mu<1`. Integer time shifts change k by a multiple of m. Let K
contain every attained residue modulo m, including every component.

If a smaller positive u were strictly alpha-bad on all W, replacing m by u
would leave every time blocked: use u on W and an old row outside W. The
continuous new minimum attains its maximum on compact T; its pointwise
strict bound therefore gives a maximum strictly below alpha. A retained u
cannot satisfy this condition, since W is nonempty and u is good there.
A fresh u lowers the sum, and dividing the new common gcd preserves the
maximum and cannot increase that smaller sum. Minimality excludes it. This
is the already accepted full-set replacement argument, not a new minimality
principle. In particular, a prime p dividing m cannot divide every attained k:
otherwise `u=m/p` has norm at most `mu/p<alpha` on all W.

Now impose the branch hypothesis that every attained k has `gcd(k,m)>1`.
The active primes dividing some attained k form a finite hitting family.
An inclusion-minimal hitting subset P exists. Write `b=|P|` and
`sigma=sum_(p in P)1/p`. Nonempty K and the exclusion of a common collision
prime imply `b>=2`. For each p, removing p from P fails to hit some attained
`k_p`; hence p divides `k_p` and no other prime in P does.

Every active frequency `m/p` is fresh relative to V0. At an actual p-divisible
collision, a retained `m/p` would have norm at least alpha, while

```text
||(m/p)t||=||k/p+e/p||=|e|/p<=mu/p<alpha.
```

This contradiction also checks the actual time and phase, rather than just
the residue list. The b frequencies in `U={m/p:p in P}` are positive,
distinct, below m, and outside V0. Therefore `V_B=V0 union U` has exactly
`n+b-1` speeds. It is primitive: any common divisor of V0 and U divides m
through one member of U, and would divide all original speeds. These claims
do not require assuming a new gcd-one property of V0 alone.

## Count obstruction, common-margin private points and exchanges

At each t in W, a hitting prime p gives `||(m/p)t||<=mu/p<alpha`; outside
W some retained norm is strictly below alpha. Compactness therefore proves

```text
max_t min_(v in V_B)||vt|| < alpha,
|V_B|=n+b-1,
sum(V_B)=sum(V)-m+m sigma.
```

Only the alpha-cover is transported. The argument does not give a maximum
at most mu: outside W, a retained norm can lie between mu and alpha, and K
does not describe all collisions there. The new native margin is
`1/(n+b)<1/(n+1)=alpha`, so the transported bound is insufficient for a
native failure. With two distinct primes, `sigma<=1/2+1/3=5/6` lowers the
sum but increases the count by one; lexicographic minimality does not apply.
The exact value `1/2+1/3+1/5=31/30` shows that even the sum comparison is
not automatic for larger bundles. No occurrence of those primes in an
actual minimal failure is asserted.

An alpha-covering subset Q would contradict minimality if it had fewer than
n labels, or n labels and sum smaller than `sum(V)`. In the first case its
native margin is larger than alpha; in the second it is alpha. Gcd division
preserves the maximum, distinctness and count, and cannot increase the sum.
An empty Q cannot cover. When `sigma<1`, every subset of V_B already has
smaller sum, so extracting an alpha-cover with at most n labels would suffice.
No such extraction has been supplied.

Choose an actual `t_p in W` for `k_p`. For q in P different from p,
nondivisibility gives `||k_p/q||>=1/q`. The reverse triangle inequality gives

```text
||(m/q)t_p|| >= (1-mu)/q.
```

If every prime in P is at most n, this is strictly greater than
`(1-alpha)/q=n/(Nq)>=alpha`. The p-row is alpha-bad and all old rows are
alpha-good. Thus every new bundle label is indispensable in the common-alpha
cover under that prime-size condition. Any extraction to at most n labels
must keep U and remove at least `b-1` old labels. For larger primes this
argument need not reach alpha; no unconditional common-alpha privateness
is inferred.

For `R subset V0`, define the entire remaining good set

```text
G_R={t : ||ut||>=alpha for all u in U,
          ||vt||>=alpha for all v in V0\R}.
```

The full bundle gives `G_empty=empty`. If G_R is nonempty, every point in it
has some removed row alpha-bad, since the full bundle still covers that point.
For EVERY `J subset V0` with `|J|=b-1` and
`m+sum(J)>m sigma`, the candidate `U union (V0\J)` has exactly n distinct
labels and sum `sum(V)-m-sum(J)+m sigma<sum(V)`. Minimality, including any
necessary gcd normalization, supplies a closed alpha-witness. Hence G_J is
nonempty and some member of J is bad at that witness. The point may depend
on J. If `b-1>n-1`, there is no such J; this quantifier is then empty.

For b=2 the sum inequality holds for every singleton J, since `sigma<=5/6`.
An immediate corollary supplied by root during this review is valid: deleting
any one old label produces a common-alpha witness, at which the full bundle
cover forces exactly that deleted old label to be bad. Thus every retained
old label is common-alpha indispensable for b=2. If both hitting primes are
also at most n, the new-label argument makes the entire `n+1`-label
common-alpha cover irredundant. This is a direct consequence of the author's
statements, not a correction or an extraction theorem.

For arbitrary `P' subset P` and `R subset V0`, freshness gives the stated
candidate count `n-1-|R|+|P'|` and sum
`sum(V)-m-sum(R)+m sum_(p in P')1/p`. A successful descent still needs its
entire common-alpha good set to be empty AND the relevant count/sum
comparison. The original collision hitting condition only controlled W;
it gives no coverage of the enlarged sets after old rows are removed.

## Mixed thresholds and all-label irredundancy

Write `B_w(a)={t:||wt||<a}` and
`B_(m,k)(alpha)={t:dist_T(t,k/m)<alpha/m}`.
For each p dividing m, the complete grid of `m/p` has centers `pl/m` and,
at norm threshold `alpha/p`, radius exactly `alpha/m`. Consequently

```text
B_(m/p)(alpha/p)
  = union_(k mod m, p|k) B_(m,k)(alpha) subset B_m(alpha).
```

This is an equality of open sets on the actual time circle. Original
individual arcs are disjoint because their radius is `alpha/m<1/(2m)`.
No new phase, independent coordinate choice or closed endpoint is inserted.

Give old rows threshold alpha and the p-row threshold `alpha/p`. On W,
the selected hit satisfies `||(m/p)t||<=mu/p<alpha/p`; off W an old row is
bad. Hence this mixed family covers T. At `t_p`, all old rows are good and
every other q-row has norm at least `(1-mu)/q>alpha/q`, because
`1-mu>alpha`. Each bundle label has a private point, without a prime-size
restriction.

Every retained original coordinate j has its own private point too. Its ORIGINAL
deletion witness `s_j` makes all other original rows, including m, at least
beta-good. Failure forces `||v_j s_j||<=mu<alpha`. For every p in P, the
integer-multiple norm inequality yields

```text
||(m/p)s_j|| >= ||m s_j||/p >= beta/p > alpha/p.
```

All other retained rows are at least beta-good, so only j is mixed-bad at
`s_j`. This checks every original label using its actual deletion witness,
not a witness from W with another row renamed. The mixed cover therefore
has `n+b-1` indispensable labels. Raising all bundle thresholds to alpha can
make these old private points bad for bundle rows too; the lower bound
`beta/p` does not preserve their common-alpha privacy in general.

Since `n>=2`, at least one old row retains threshold alpha, the largest
threshold. Their exact budget is

```text
S=alpha(n-1+sigma),   a_max=alpha,
S+a_max=alpha(n+sigma)<=1 when sigma<=1.
```

The generic weighted implication from this budget is false. For speeds
`(1,2,3)` and thresholds `(13,11,13)/50`, the budget is exactly one.
The speed-1 good interval is `[13/50,37/50]`. The speed-3 good intervals
have endpoints `(k+13/50)/3,(k+37/50)/3`, `k=0,1,2`. The outer intervals
miss the speed-1 interval because `37/150<13/50` and `113/150>37/50`;
the middle interval gives the exact common good set `[21/50,29/50]`.
There `2t` ranges from `21/25` to `29/25`, so `||2t||<=4/25=8/50<11/50`.
There is no simultaneous closed weighted witness, and the open bad sets
cover the whole circle.

Changing only the middle threshold to `9/50` keeps `8/50<9/50` and makes
the budget `(13+9+13+13)/50=24/25<1`. Both controls therefore exclude the
generic budget rule, including its strict version. The speeds themselves
have the ordinary canonical witness `t=1/4`, with norms `(1/4,1/2,1/4)`.
The controls are unequal-threshold examples and do not instantiate the
special original-alpha/prime-divisor threshold pattern or its full coupled
failure hypotheses. They refute neither that special possibility nor LRC.

## First gap, source bindings and actual checks

The first missing implication remains an admissible common-alpha extraction
under the full coupled hypotheses, or an actual alternative lowering of one
coordinate. Minimality's supplied exchange witnesses are holes in potential
extractions, not a proof that any extraction covers. The mixed cover is
irredundant, and its numerical budget does not by itself supply a weighted
witness. No theorem for the special divisor pattern or unrestricted LRC is
established, and no actual minimal-failure counterexample is constructed.

The complete frozen author was read and independently checked by hand. The
minimal-frequency source and accepted review were fully read in the preceding
task; their unchanged bindings were verified here and their invoked whole-set
transport was rechecked above. The divisor-minimality source was also fully
read in that preceding task and remains unchanged. It is context only; no
unproved arithmetic supply, whole-good-set closure or runner-switch failure
is imported from it. Earlier programs and entire earlier audits were not rerun.

| Input | SHA-256 |
| --- | --- |
| `research/astra-coupled-divisor-descent.md` | `df7717b031d827d622a00ce1b60074e1f737ce864fc3dd81838b227a0fe8a4c3` |
| `research/astra-minimal-frequency-synthesis.md` | `03cf038021f0bc1a2328bb77a02f6ab4fe649f5d3626d7bc368a67cd6c7b0000` |
| `research/astra-minimal-frequency-review.md` | `b26182c2e482e7f83480eab9904779b958eb8b8b753c70bc45c6fabec55b747d` |
| `research/astra-uniform-divisor-minimality.md` | `8c4b6ee094f0f311f360d3abf371e95f731e28cee997d3810dd3218ff6f25746` |
| `.codex/config.toml` | `28212a53cf42cdc377df1f7dab040732d657e59d7bb97ee78791256d01d4bb2c` |
| `docs/project-workflow.md` | `2b42a133352b6b53ba2106fc73882733f176e04a0deffbb183b4c16eefd9cd67` |
| `research/workflow-policy.json` | `833c397b61d1ffdb994fb115019f6d60d6c1a62ff85f19cdd2c9f8ac3a979c8b` |
| `scripts/validate_workflow.py` | `250a3ce2a080f5835ac4fd2e4b2803568424c777cda5d421f9fe92efd34d5383` |

Current project config, workflow, policy and focused state were read. The
state recorded `research/in_progress`, explicit 2026-09-05 start authorization,
this task, requested route, assignment checkpoint and sole owned file.
`python3 -B scripts/validate_workflow.py` exited 0 with complete output:

```text
workflow structural validation passed; it cannot certify mathematical validity.
```

`sha256sum` matched all eight displayed bindings. Final administrative Python
checks verified those bindings again, a final newline and no trailing
whitespace, and returned this review's frozen hash separately. The review
was read back in full. All commands exited 0; no mathematical error or author
repair request occurred. No mathematical program, search, solver, build,
cache operation, external model, new agent, Git mutation, shared-state edit,
memory write or other-file edit was performed. This acceptance is independent
manuscript evidence, not a kernel-checked theorem or project completion.
