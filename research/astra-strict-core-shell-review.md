# Independent review of strict core contraction and shell supply

Task `/root/strict_core_shell_review`; reviewer session
`/root/coordinate_cancellation_review`; assigned checkpoint
`c40889087108333dbe948221b045553fd44a5b0d`. Requested route:
`gpt-6-astra/xhigh`; observed model, effort, elapsed time, and usage: `null`.
Only this review is owned.

**Accept the complete frozen source below without a mathematical correction.**
The all-deletion-set contraction and exact indexed-core accounting are valid.
They show that the entire specified coincident-center saving leaves a positive
deficit under canonical strict failure. The consecutive-speed control shows
that cross-center shell coverage can be supplied entirely by forced cores
at a larger test width. It is not a native strict-failure counterexample.
These are hand-reviewed manuscript results, not kernel theorems or a proof
or disproof of unrestricted LRC.

## Exact hypotheses and the contraction

Assume n>=3 distinct positive primitive integer speeds V in a hypothetical
ordinary strict failure, chosen by least moving count and then least
primitive sum. Put N=n+1, alpha=1/N and
`0<mu=max_(t in T) min_(v in V)||vt||<alpha`, with T=R/Z. Positivity of mu
follows at any `0<t<1/(2 max V)`. For each m, use the entire closed set
`W_m={t:||vt||>=alpha for all v!=m}`. Least count supplies a deletion witness
at 1/n>alpha; continuity therefore gives a nonempty open interval in W_m.
Throughout W_m the remaining coordinate satisfies ||mt||<=mu.

The accepted forced-arc interface identifies F exactly with all original
open alpha-arcs attained by these W_m, including singleton components.
Each A=(m,k) has an actual private point in W_m, and all points uniquely
covered by the original family belong to such an arc. Write K_m for all
attained indices and `f=sum_m |K_m|/m`. An arc at center c=k/m has closed
mu-core H_A of radius mu/m. These are original indexed arcs and cores;
reducing the center does not replace its speed.

Let `Q_m=max(V\{m})` and `eta_m=(alpha-mu)/Q_m>0`. Fix any t in W_m.
For every real s with |s|<eta_m and every other v,

`||v(t+s)||>=alpha-v|s|>=alpha-Q_m|s|>mu`.

The definition of the full maximum then forces ||m(t+s)||<=mu on the
entire open time interval. In a real lift, the m-bad set at closed width mu
is the disjoint union of intervals `[(k-mu)/m,(k+mu)/m]`, separated by
positive gaps because mu<1/2. A connected interval contained in this union
stays in one component. This is the component containing t. If e=mt-k,
the endpoint limits in this closed component give
`|e-m eta_m|<=mu` and `|e+m eta_m|<=mu`. Since |e|=||mt|| and
`max(|e-m eta_m|,|e+m eta_m|)=|e|+m eta_m`, this proves exactly

`||mt||+m eta_m<=mu` for every t in W_m.

The weak sign is essential: the limiting times need not keep the other
norms strictly above mu. The argument does not assume that the initial
private point is strictly mu-bad, that its component has interior, or that
the open mu-family covers.

Thus each indexed private set is inside its concentric contracted closed
core H'_A of radius `h'_m=mu/m-eta_m`. Nonemptiness gives h'_m>=0. In fact
h'_m>0: if h'_m=0, the displayed inequality would put all of W_m at the
finitely many centers k/m, contradicting its nonempty interval. This uses
interior of the full W_m, not interior of every indexed portion.

If another original speed v shares A's center, then at any actual private
point `t=c+e/m`, |e|<=mu,
`alpha<=||vt||<=v|e|/m`. Consequently v>=alpha m/mu>m; A is the outer
arc in its coincident chain. Let J_A be the open alpha-arc of its smallest
other owner a_2(c), or the empty set if there is none. Its radius is at most
mu/m. Applying the contracted bound to an actual private point outside
J_A improves this to

`alpha/a_2(c)<=h'_m<mu/m`.

The first inequality may be equality: a private point can be on the other
open arc's boundary. Hence J_A is contained in H'_A, and all later
coincident arcs are inside J_A.

## Exact indexed-core identity and the positive deficit

At each original center c list actual owners in increasing order. Only the
outermost arc can be forced. Retain the frozen definitions

`C_3=sum_c sum_(s>=3) 1/a_s(c)`,
`C_(2,F)=sum_(c forced, r_c>=2) 1/a_2(c)`,
`S_c=C_3+C_(2,F)`.

The accepted arithmetic-completion source proves that S_c is exactly the
cost removed by deleting all inner arcs at forced centers and keeping only
the outer two at other centers. This preserves double coverage of every
closed completion gap: forced-center chains contribute zero there, and
each other chain's multiplicity changes to its minimum with two. This
pointwise reason also handles open endpoints and singleton gaps. The
present source charges that exact structured saving, not an arbitrary
discard of contained intervals.

Let M be the full original open alpha multiplicity. It satisfies M>=1 and
integral M=2n alpha. With P=measure{M=1} and T_3=integral(M-2)_+,
the exact pointwise identity `1_(M=1)=2-M+(M-2)_+` gives

`P=2-2n alpha+T_3=2alpha+T_3`.

To check E without a sign assumption, decompose M into center counts M_c.
For nonnegative x,y,
`(x+y-2)_+>=(x-2)_++(y-2)_+`: if both exceed two the difference is two,
if only one does the other contributes nonnegatively, and otherwise the
right side is zero. Induction and nestedness therefore give

`(M-2)_+>=sum_c(M_c-2)_+`,
`(M_c-2)_+=sum_(s>=3)1_(A_(a_s(c),c))`,
`T_3>=2alpha C_3`.

Thus `E=T_3/(2alpha)-C_3>=0` includes any further excess from different
centers. It is not computed from forced-family multiplicity.

For each forced indexed arc A let U_A be the points uniquely covered by
A in the full original family. These are precisely that index's part of
W_m, lie in H'_A, and are disjoint over all A. Their total measure is P.
U_A and J_A are disjoint subsets of H_A: any J_A point is covered by both
its own arc and A. Define

`R=sum_(A in F) measure(H_A\(U_A union J_A))`.

For each index separately, H_A is the disjoint union of U_A, J_A, and that
remainder. Each H_A has length 2mu/m; each nonempty J_A has length
2alpha/a_2(c). Summing those exact decompositions proves

`2mu f=P+2alpha C_(2,F)+R`.

Different cores may overlap. This creates no subtraction error because
both the left side and the remainder count cores with their indices. The
U_A are disjoint across indices, and each forced center has only one forced
outer owner, so their total and the J_A total are respectively P and
2alpha C_(2,F). Endpoints of the closed H_A or open J_A do not change
their lengths. No assertion that the union of cores has measure 2mu f
is being made.

Also, a point of H_A outside U_A and J_A is covered by A but is not private,
so another original alpha-arc covers it. That arc must have a different
center: all other coincident arcs lie inside J_A. This validates the stated
interpretation of the remainder without changing its indexed definition.

Put rho=mu/alpha. Substituting P and E in the exact decomposition gives

`rho f=1+S_c+E+R/(2alpha)`.

Since both U_A and J_A lie in H'_A, the two strips H_A\H'_A contribute
their full combined length `2(mu/m-h'_m)=2eta_m` to A's remainder. Even
when U_A is a singleton, these strips are present. With
`L=sum_m |K_m|/Q_m>0`, summing indexed strip lengths gives

`R>=2(alpha-mu)L`,
`f-1-S_c=(1-rho)f+E+R/(2alpha)`
`             >=(1-rho)(f+L)+E>0`.

Strictness uses rho<1 and f>0. This is a valid strengthening of the frozen
C_3-only obstruction: all of S_c is insufficient by itself. The inequality
does not supply a color imbalance, a removable cross-center arc, or a
bound on optimal completion cost that closes the remaining gap.

## Closed shell coverage and its control

For t in A\H_A, the owner norm is strictly above mu and strictly below
alpha. The full maximum gives a different original speed with norm at most
mu. Thus a different original **closed** mu-core covers t. It cannot have
the same center c: its alpha-arc already lies in H_A, and its smaller
closed mu-core lies there too. This is pointwise cross-center demand on
the open shell, with closed covering sets. It does not assert open
mu-coverage or private status of shell points.

The control uses V_n={1,...,n}, n>=3, at the separate working width
`mu_n=1/(n+1)<a<1/n`. Among 0,t,...,nt a coincidence gives a zero norm;
otherwise a shortest cyclic gap of length at most 1/(n+1) has an available
difference speed. At t=1/(n+1) every speed has norm at least that value.
Hence the exact maximum is mu_n and the full closed mu_n-family covers.

Its forced open a-arcs are exactly the primitive-center arcs of label q
at reduced k/q, including zero for q=1. Nonprimitive arcs are contained in
their smaller primitive-denominator ancestor. The required private points
are checked directly:

* For q>n/2, k/q is private: no other speed is divisible by q, and every
  other norm is at least 1/q>=1/n>a.
* For q<=n/2, use t=k/q+a/(2q). The owner norm is a/2<a. Every other
  multiple v=rq has exact norm `ra/2>=a`, since
  `ra/2<=na/(2q)<1/(2q)<=1/2`; no wrap occurs. For a nonmultiple,
  `||vt||>=1/q-va/(2q)>=1/q-na/(2q)>1/(2q)>=1/n>a`.
  The q=1 nonmultiple case is empty; equality at a for r=2 correctly
  excludes its open arc.

At closed width mu_n every nonprimitive indexed core is likewise inside
its primitive ancestor. The primitive index family consequently covers
the entire circle at closed mu_n. For a point in a forced primitive arc's
a-minus-mu_n shell, that covering primitive core cannot be its own core
and must have a different center, since there is one primitive owner per
center. Every such shell is therefore covered entirely by other forced
primitive cores. No nonforced core is needed.

Every nonforced open a-arc is a coincident inner descendant. The accepted
structured pruning removes them all and leaves the forced family covering
the circle; its explicit private points prevent removal of any remaining
arc. This establishes the claimed obstruction to inferring additional
removable cost from shell coverage alone.

The tuple is positive, distinct, primitive, and has absolutely smallest
sum for n distinct positive integers. Every lower positive replacement of
one speed is already retained and is good throughout the corresponding
deletion-good set. These coordinate conditions hold at a, and mu_n<a
gives strict depth at that working width. Nevertheless the native maximum
equals the canonical threshold, not a smaller value. Neither canonical
strict failure nor uniform least-count minimality at a is supplied. In
particular the native identity `2-2n alpha=2alpha` cannot be preserved by
substituting a>1/(n+1). This family cannot refute a shell implication using
the missing canonical hypothesis essentially.

## Dependency scope and first unresolved implication

The earlier divisor manuscript's Proposition 5 traps every own-margin
lower-count seed: it preserves other norms at the canonical width on a
closed interval and forces that interval into one open bad component,
giving a strict endpoint inequality. The new proof uses the same Lipschitz
and connectedness mechanism on all W_m, with the actual maximum as the
closed trapping width; its endpoint conclusion is weak. This broader
domain and depth-dependent contraction are justified here, but are not a
new uniform escape principle. No statement about arbitrary unseeded phases
or a speed-independent contraction is inferred.

The unchanged arithmetic-completion author and accepted review supply the
precise pruning and control. Their deficit bound covered C_3 only; the new
indexed identity now adds C_(2,F) and the strip term. This is new reviewed
content of the present source, not a correction silently inserted into the
frozen earlier manuscript. The accepted private-repair control still shows
that repairing all full W_m does not alone establish global transport;
regions where multiple original coordinates are bad remain necessary.

The first unresolved implication is conversion of cross-center coverage
into a sufficient additional saving, an exclusion of the actual forced
cycle, or a valid smaller-sum transport under the full canonical hypotheses.
The source proves none of these. It instead establishes the stated
contraction, a stronger conditional deficit, and a precisely scoped
noncanonical control. No full LRC claim follows.

## Bindings and actual checks

The full frozen author was read and hand-checked. Its eleven bindings were
verified unchanged; prior full reads and independent reviews of the reused
inputs were retained at their original scope. The divisor Proposition 5
was reread for the exact comparison, without rerunning its historical code.
The accepted arithmetic-completion review is an additional bound input.

| Input | SHA-256 |
| --- | --- |
| `research/astra-strict-core-shell-supply.md` | `5cc9866b3c8a516494ad998355265335a5edd15158cf9701c7d814843b97210e` |
| `research/astra-arithmetic-completion-saving.md` | `abfb14f274fb5c72461ce884b7fc44fb89367e056091f628933a601f52a33403` |
| `research/astra-arithmetic-completion-review.md` | `568e9a678777f93de6a4adace739d1b443177662ba7a95e231be30ef2551c019` |
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

Current config, workflow, policy, and focused state were read. The gate was
research/in_progress with explicit start authorization at
`2026-09-05T04:12:25.208107+00:00`; the active task recorded this review's
route, checkpoint, and sole owned file. Observed runtime metadata stayed
null. `python3 -B scripts/validate_workflow.py` exited 0 with
`workflow structural validation passed; it cannot certify mathematical validity.`

The full owned text was read back. All thirteen table bindings were checked
with `sha256sum` and final byte-hash comparison; final newline/whitespace
and workflow checks passed. These administrative checks do not establish
mathematical validity; the arguments above are the independent semantic
review. No mathematical program, enumeration, solver, build, Lean/cache
operation, new agent, external model, Git/state edit, memory write, or
other-file edit was used. The author and all other inputs remained frozen.
No mathematical error or requested author correction occurred. The final
review hash is returned separately.
