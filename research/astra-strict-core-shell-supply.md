# Strict depth contracts private cores but does not supply shell savings

Task `/root/strict_core_shell_supply`; assigned checkpoint
`33b5b430b443014241f99030dacb2cb66576feea`. Requested route: Astra/xhigh;
observed model, effort, elapsed time and usage: null. This bounded hand
derivation awaits independent review; it is not a kernel theorem.

The strict depth gives a quantitative contraction of every complete
deletion-good set. It also sharpens the previous obstruction: **all** the
coincident-center saving, including second arcs under forced owners, leaves
a strictly positive deficit. Cross-center coverage of the outer shells does
not by itself supply a removable arc: an exact family has every shell covered
by other forced cores. That family is a control at a larger test width, not
a canonical strict failure. No sharper global saving or descending transport
was established in these two attempts.

## 1. Setting and the precise shell demand

Let V be n distinct positive primitive integer speeds in a hypothetical
ordinary strict failure, chosen by least moving count and then least sum.
Put

`n>=3`, `N=n+1`, `alpha=1/N`, `0<mu=max_t min_{v in V}||vt||<alpha`,
`rho=mu/alpha`, `T=R/Z`.

Positivity follows at any `0<t<1/(2 max V)`. Retain every point of each
closed set `W_m={t:||vt||>=alpha for all v!=m}`. Least count gives a
deletion witness at `1/n>alpha`, so W_m contains an interval. On W_m,
`||mt||<=mu`. Its complete attained collision set is K_m modulo m.

The forced original open alpha-arcs are precisely
`F={A_(m,k):k in K_m}`, where

`A_(m,k)={t:dist_T(t,k/m)<alpha/m}`.

Each has an actual point in W_m outside every other original open alpha-arc.
Write `f=sum_m |K_m|/m`. For a forced arc A centered at c=k/m, let H_A be
its **closed** mu-core of radius `mu/m`.

At reduced center c=r/q, a different original q-divisible speed v has integer
phase at c. At A's actual private point, `t=c+e/m`, `|e|<=mu`, so

`alpha<=||vt||<=v|e|/m<=v mu/m`.

Therefore its entire coincident alpha-arc has radius
`alpha/v<=mu/m` and lies in H_A. This is the accepted owner restriction.
If a second speed at c exists, denote the smallest such speed by a_2(c),
and its open alpha-arc by J_A; otherwise set J_A empty. All other coincident
arcs lie inside J_A, and `J_A subset H_A`.

Every point of the open outer shell `A\H_A` has its m-norm strictly above
mu. The full original family covers at **closed** width mu by definition of
the maximum, so another original closed mu-arc covers it. That covering arc
cannot be centered at c: even the coincident alpha-arcs are inside H_A.
Thus every shell point really has cross-center coverage at level mu.
This assertion neither makes shell points private nor assumes that the open
mu-family covers. All subsequent uses retain this closed boundary.

## 2. First approach: contract the cores and account for the whole pruning

For each m define

`Q_m=max(V\{m})`, `eta_m=(alpha-mu)/Q_m>0`.

Fix **any** `t in W_m`. For every `|s|<eta_m` and every v other than m,

`||v(t+s)|| >= alpha-v|s| >= alpha-Q_m|s| > mu`.

The full maximum consequently forces `||m(t+s)||<=mu` throughout this open
time interval. In a real lift, the closed m-mu bad intervals are disjoint
because `mu<1/2`. Connectedness keeps the entire interval in one such
component, the one containing t. Taking endpoint limits in that closed
component proves the exact contraction

`||mt||+m eta_m<=mu` for every `t in W_m`.                             (1)

No private point was assumed to be strictly mu-bad. Its strict interior
bound is derived from the global maximum and the other coordinates' actual
alpha margins. Equality in (1) is permitted; closed W_m endpoints and
singleton collision components are retained. In particular every private
point for A lies in the contracted core H'_A of radius

`h'_m=mu/m-eta_m>=0`.

The inequality follows from nonemptiness of the corresponding private set;
in fact nonempty interior of W_m makes `h'_m>0`. This is the same Lipschitz
trapping mechanism as the earlier divisor manuscript's Proposition 5, now
applied to all W_m with the actual maximum mu as the trapping width. It is
not promoted to a new escape principle or a fixed margin independent of speed.

If J_A exists, an actual private point lies in H'_A and outside J_A. Their
centers coincide, so its radius must satisfy

`alpha/a_2(c) <= mu/m-eta_m < mu/m`.                                 (2)

The first comparison can be equality, leaving a private endpoint. It is
stronger than simply placing J_A in the original mu-core.

### An exact core-capacity identity

For each distinct original grid center c, list its speeds increasingly as
`a_1(c)<...<a_(r_c)(c)`. Let C_F be the centers of forced arcs and set

`C_3=sum_c sum_(s>=3) 1/a_s(c)`,
`C_(2,F)=sum_(c in C_F, r_c>=2) 1/a_2(c)`,
`S_c=C_3+C_(2,F)`.

S_c is the full structured saving in the frozen arithmetic-completion input:
delete every inner arc below a forced arc, and at other centers keep the
outer two. For a completion gap no forced ancestor covers it, and truncating
each other nested chain preserves its multiplicity capped at two. Thus the
operation preserves double coverage of those gaps. The present argument
uses this precise saving, not arbitrary deletion of contained intervals.

Let M be the complete original open alpha-arc multiplicity, put

`P=measure{M=1}`, `T_3=integral(M-2)_+`,
`E=T_3/(2alpha)-C_3>=0`.

Here M>=1 everywhere and `integral M=2n alpha`. Hence the pointwise identity
`1_(M=1)=2-M+(M-2)_+` yields

`P=2alpha+T_3`.                                                     (3)

For completeness E is nonnegative without a sign assumption: decompose
`M=sum_c M_c` by centers. Then
`(sum_c M_c-2)_+>=sum_c(M_c-2)_+`; if there are any positive terms on the
right, subtracting two once is no larger a deduction than subtracting it
for each such center. Nestedness gives
`(M_c-2)_+=sum_(s>=3)1_(A_(a_s(c),c))`, so integration proves
`T_3>=2alpha C_3`.

Let U_A be the points with M=1 owned by the indexed forced arc A. They are
exactly its portion of W_m and lie in H'_A. The U_A are disjoint over A,
with total measure P. U_A and J_A are disjoint subsets of H_A: the second
arc makes any of its points nonprivate. Define the nonnegative remainder

`R=sum_(A in F) measure(H_A\(U_A union J_A))`.

Decomposing each indexed core separately gives the **exact** identity

`2mu f=P+2alpha C_(2,F)+R`,
and therefore `rho f=1+S_c+E+R/(2alpha)`.                             (4)

Overlap between different cores causes no error: each is counted separately
on both sides of the decomposition, whereas the private U_A are disjoint.
The open boundary of J_A and closed boundary of H_A have zero measure.
The remainder also records cross-center loss of private capacity. Indeed
after excluding J_A, any point of H_A that is not private must belong to an
alpha-arc centered elsewhere. All other coincident arcs lie inside J_A.

The contraction makes R quantitatively positive. By (1), U_A is inside H'_A;
by (2), J_A is also inside H'_A (or empty). The two boundary strips
`H_A\H'_A`, of total length `2eta_m`, therefore contribute to R for every
forced arc of label m. This works even when U_A is a singleton. With

`L=sum_m |K_m|/Q_m`,

we obtain

`R >= 2(alpha-mu)L`,
`f-1-S_c = (1-rho)f+E+R/(2alpha)
           >= (1-rho)(f+L)+E > 0`.                                 (5)

The exact identity (4), proposed by root and checked here, strengthens the
frozen input's C_3-only obstruction to **all** of S_c. The strips strengthen
its quantitative deficit further. Cross-center coverage already consuming
these strips increases this remainder; it does not, just from this identity,
produce a removable cost or an imbalance between completion colors. No
unproved global charge sign or new positivity criterion is being assumed.

## 3. Second approach: must shell coverage use nonforced arcs?

One tempting next step is that coverage from different centers must provide
new nonforced arcs that can be discarded, or obstruct a cycle of forced
arcs. That inference is false if it uses only strict depth at a working
width, the whole closed mu-cover, actual forced positions, and coordinate
least-frequency conditions. The following uniform analytic control isolates
the missing canonical hypothesis; it is not a hypothetical failure example.

For any n>=3, take `V_n={1,...,n}`, let `mu_n=1/(n+1)`, and use a separate
test width

`mu_n<a<1/n`.

The actual maximum is mu_n: among `0,t,...,nt`, a coincidence gives norm
zero, or a shortest cyclic gap is at most `1/(n+1)` and is realized by an
index difference from 1 through n. Conversely `t=1/(n+1)` makes every
original norm at least mu_n. Thus the full closed mu_n-family covers.

The forced arcs at test width a are exactly those of label q centered at
reduced k/q, for `1<=q<=n`, including center zero with q=1. Here is the
needed direct check from the frozen input. Every nonprimitive arc is
contained in its smaller primitive-denominator ancestor and cannot be forced.
For a primitive center with `q>n/2`, the center itself is private: no other
speed is divisible by q, and the other norms are at least `1/q>=1/n>a`.
For `q<=n/2`, use `t=k/q+a/(2q)`. The q-norm is `a/2<a`. Every other
multiple v=rq has norm exactly `ra/2>=a`, since
`ra/2<=na/(2q)<1/(2q)<=1/2`. For a nonmultiple v,

`||vt|| >= 1/q-va/(2q) >= 1/q-na/(2q)
         > 1/(2q) >= 1/n > a`.

These are actual private points with all endpoint signs correct. At closed
width mu_n, every nonprimitive core is likewise contained in its primitive
ancestor. Removing all such inner cores therefore leaves the primitive
index family covering the **entire circle** at closed mu_n.

Consequently every outer a-minus-mu_n shell of every forced primitive arc is
covered by another forced primitive closed mu_n-core. The covering center is
different because there is only one primitive ancestor per center, and the
point lies outside its own core. No nonforced arc is needed for this shell
coverage. Meanwhile every nonforced a-arc is a coincident inner descendant,
so the structured same-center pruning removes all of them. The remaining
forced family already covers the circle and none of its arcs can be removed:
each has the explicit private point just proved. Hence this cross-center
coverage does not itself supply any further removable nonforced cost.

V_n is positive, distinct, primitive, and has the smallest possible sum for
n distinct positive integers. Every smaller positive replacement of a label
is already retained, so all coordinate least-frequency conditions at a hold
on the entire corresponding deletion-good sets. Uniform least-count
minimality at a is not assumed. Most decisively, its native canonical margin
is mu_n itself: `mu(V_n)=1/(n+1)`, not a strictly smaller value. It violates
the central canonical strict-failure premise. Thus the control refutes only
the stated broader shell-to-removability inference, not an implication using
that missing premise essentially. No successive-count theorem is pursued.

## 4. Exact remaining step and checks

The best positive geometric implication is (1)--(2), on all actual W_m;
the exact strengthened obstruction is (4)--(5). Shell coverage is genuinely
cross-center, but can be supplied by other forced cores rather than a
discardable family. No argument here converts that coverage into a sharp
additional saving under the canonical hypotheses, excludes the actual
forced-cycle case, or transports failure to a smaller-sum tuple.

That is the first unresolved implication. The accepted private-repair
control already excludes inferring full transport from repair on all W_m:
multiply-bad regions remain necessary. The contraction does not change this
fact or control new phases there. This bounded branch stops without another
weighted target, generic roadmap, or claim of LRC resolution.

The arithmetic-completion input was frozen and under independent review at
assignment. Its needed definitions and control facts were checked directly
above; no status of that whole manuscript is self-promoted. The accepted
completion and private-repair sources/reviews were read; the unchanged
minimal-frequency source and the relevant divisor-trapping section were
checked without replaying earlier programs. Source bindings:

| Input | SHA-256 |
| --- | --- |
| `research/astra-arithmetic-completion-saving.md` | `abfb14f274fb5c72461ce884b7fc44fb89367e056091f628933a601f52a33403` |
| `research/astra-forced-arc-completion.md` | `e48f80297a70e6630e76fe2b905ed86372383a5d170a539abccdba3decdd98a1` |
| `research/astra-forced-completion-review.md` | `8e72687760576dc0e8524ecbae0bad81bcf3e8cd33f180219848da86a23adb02` |
| `research/astra-coupled-descent-strategy.md` | `d9a029cb16c866a45741f97841f3b007d4823f86712fe827e899801208289bb2` |
| `research/astra-private-repair-review.md` | `a8aaec8468969723207dc12e9ff2c112a4560c1f51e97f13b43f4e342c849512` |
| `research/astra-minimal-frequency-synthesis.md` | `03cf038021f0bc1a2328bb77a02f6ab4fe649f5d3626d7bc368a67cd6c7b0000` |
| `research/astra-uniform-divisor-minimality.md` | `8c4b6ee094f0f311f360d3abf371e95f731e28cee997d3810dd3218ff6f25746` |
| `.codex/config.toml` | `28212a53cf42cdc377df1f7dab040732d657e59d7bb97ee78791256d01d4bb2c` |
| `docs/project-workflow.md` | `2b42a133352b6b53ba2106fc73882733f176e04a0deffbb183b4c16eefd9cd67` |
| `research/workflow-policy.json` | `833c397b61d1ffdb994fb115019f6d60d6c1a62ff85f19cdd2c9f8ac3a979c8b` |
| `scripts/validate_workflow.py` | `250a3ce2a080f5835ac4fd2e4b2803568424c777cda5d421f9fe92efd34d5383` |

Current config, workflow, policy and focused state were read, confirming the
research/in-progress gate and the recorded start authorization and ownership.
`python3 -B scripts/validate_workflow.py` exited 0 with `workflow structural
validation passed; it cannot certify mathematical validity.` Hash bindings
used `sha256sum`. All mathematics was checked by hand. No mathematical
program, search sweep, solver, Lean/build/cache operation, new agent, external
model, Git/shared-state operation, memory write, or other-file edit was used.
Full final readback and the frozen hash are returned separately. Independent
mathematical review remains required; unrestricted LRC remains unresolved.
