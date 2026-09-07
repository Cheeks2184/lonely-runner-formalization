# Native endpoint spacing and an exact cover-to-cycle cost bridge

Task `/root/native_endpoint_cycle_arithmetic`; recorded checkpoint
`eded4ca55ca867517f10d3ed30c2ef0a0eba2062`. Requested route:
`gpt-6-astra/xhigh`; observed model, effort, elapsed time and usage: null.
Only this manuscript is owned. The new hand derivations require independent
review and do not constitute a kernel theorem or unrestricted LRC resolution.

Native integer spacing gives an explicit residue-class correction to cycle
cost. It also supplies a useful missing bridge: after choosing a specified
auxiliary global upper bound below alpha, minimum endpoint-cycle cost equals
minimum original alpha-subcover cost. Thus the earlier completion bounds
really do apply to this graph. Cost minimality then excludes contained cores
and forces positive center determinants. These statements do not provide the
additional arithmetic saving or admissible descent needed for contradiction.

## Setting and inherited scope

Assume a hypothetical canonical strict failure V of n>=5 distinct positive
primitive integer speeds, least by moving count and then primitive sum. Set

    N=n+1, alpha=1/N, m=max V, s=max(V\{m}),
    mu=max_t min_(v in V)||vt|| in (0,alpha),
    W_v={t:||ut||>=alpha for every u in V\{v}},
    Q_v=max(V\{v}).

All original arcs A_(v,k) have center k/v and open radius alpha/v, with
0<=k<v. F is the complete family of forced indexed arcs attained on the
whole W_v; every member has an actual private point outside EVERY other
original alpha-arc. Write f_F=sum_v |K_v|/v. Minimum count supplies these
nonempty deletion sets. Retain the all-zero branch at every attained maximum
arc when invoking the parent bonus below; the integer and cost-bridge
arguments themselves do not need that branch assumption.

The accepted graph construction works with a global upper bound below
alpha: an edge A->B means that B's closed core at that bound contains the
right endpoint R_A. Every simple cycle covers the circle, contains F, and
winds once. The proof uses positive lifted endpoint increments and counts
copies of an actual forced private point in a half-open interval; no
arbitrary phase labels or reduced-denominator replacements are permitted.

## First method: native integer spacing with full index compatibility

Consider ANY original alpha-arc of label b covering the right endpoint of
A=(a,k). Choose compatible integer l for its lift. Put

    R_A=(Nk+1)/(Na), e=b*R_A-l,
    D=a*l-b*k, r=b-N*D=N*a*e.

These are the actual labels and lifted indices. Since |e|<alpha,

    r in Z, |r|<a, hence |r|<=a-1.                         (1)

More precisely, with g=gcd(a,b), A=a/g and B=b/g,

    D in gZ, r in gZ, |r|<=a-g,
    r/g = B-N*(D/g), so r/g congruent B modulo N.           (2)

The reduced ratio A,B in (2) is notation for this gcd calculation; it
does not replace either original arc by an enlarged reduced-denominator
arc. The stronger source-index congruence must also be retained:

    r congruent b*(Nk+1) modulo Na,
    l=[b*(Nk+1)-r]/(Na) in Z.                              (3)

For fixed original source index and target label there is at most one r
in (-a,a) satisfying (3), because that interval has length 2a<Na.
Conditions (1)--(2) alone are not sufficient to construct an edge at a
specified k.

The positive lifted endpoint step is

    R_B-R_A=(a-r)/(N*a*b).                                 (4)

On an actual winding-one simple cycle C, the lifted indices close with
k_final=k_initial+v_initial, and no original pair (v,k mod v) is repeated.
Summing (4), using those actual compatible indices, yields

    N=sum_edges (a-r)/(a*b)
     =2*f_C-sum_edges (a+r)/(a*b),
    f_C=sum_vertices 1/v.                                  (5)

There are exactly n=N-1 available distinct labels, though a label may own
several distinct cycle vertices. Arbitrary residue choices satisfying a
scalar sum are not substituted for this closed original-grid cycle.

Let rho_N(z) be the least POSITIVE integer congruent to z modulo N, with
values in {1,...,N}. The integer gamma=a+r is positive by (1), divisible
by g, and gamma/g congruent A+B modulo N. Consequently

    gamma>=g*rho_N(A+B),
    Gamma_C=sum_edges rho_N(A+B)/lcm(a,b)>0,
    N<=2*f_C-Gamma_C.                                      (6)

This improves the unit correction to at least sum 1/lcm(a,b), and retains
the additional residue modulo N. The corresponding positive a-r is in
the class g*(A-B) modulo Ng; thus sum rho_N(A-B)/lcm(a,b)<=N as well.
Neither inequality asserts existence of compatible indices or an upper
cost bound. In particular (6) is a LOWER requirement on the cost.

## Second method: saturate endpoint edges, then optimize legitimately

The following choice and bridge were supplied by root and checked here:

    mu_hat=max(mu, alpha-1/(N*m)),
    epsilon_hat=alpha-mu_hat>0.                             (7)

This is an auxiliary global upper bound, not the actual maximum mu.
For any alpha-cover at any original endpoint of source label a, (1) gives

    ||b R_A||<=alpha-1/(Na)
              <=alpha-1/(Nm)<=mu_hat.                     (8)

Conversely a closed mu_hat-core cover is an open alpha-cover, since
mu_hat<alpha. Hence the endpoint graph at mu_hat equals EXACTLY the full
original alpha endpoint graph. Closed equality in (8) is included. No
equality between the actual-mu graph and this graph is claimed.

The original strict-core proof also works at this upper bound. For t in
W_v and |h|<epsilon_hat/Q_v, every retained norm at t+h is above mu_hat.
The global bound then keeps v(t+h) in one connected closed mu_hat-bad
component. Taking endpoint limits gives

    ||vt||<=mu_hat-v*epsilon_hat/Q_v on ALL W_v.             (9)

The actual W_v, K_v, alpha-arcs and private points are unchanged. No
private point at alpha is promoted to a new deletion-good domain.

### Exact equality of the two minimum costs

Let c_alpha be minimum reciprocal cost of an original open alpha-subcover,
and c_cycle minimum cost of a simple cycle in the graph at mu_hat. These
minima exist by finiteness and the cover hypothesis.

Every such cycle is an alpha-cover by the accepted lifted construction,
so c_alpha<=c_cycle. Conversely take ANY original alpha-subcover S. The
right endpoint of each A in S is covered by another member of S. By (8),
that is an edge in the graph at mu_hat. Its restriction to S has positive
outdegree and therefore a simple cycle of cost at most cost(S). Taking a
minimum subcover proves the reverse inequality. Thus

    c_cycle=c_alpha.                                       (10)

This repairs the earlier missing transfer of a cost upper bound. It is
specific to the chosen auxiliary bound and native spacing; an arbitrary
alpha-subcover need not support an actual-mu endpoint cycle.

### Safe shortcuts, positive determinants and divisibility jumps

Choose a minimum-cost cycle at mu_hat. No selected closed mu_hat-core can
be contained in another selected core. If H_B subset H_O with B!=O,
the predecessor A of B has R_A in H_B, hence an edge A->O. The vertex O
cannot equal A, because R_A is outside its own mu_hat-core. Following the
old cycle from O to A and using this new edge gives a simple cycle omitting
B and possibly more vertices. Every cost is positive, contradicting the
chosen minimum. This is an exchange inside the complete original graph.

In particular every center determinant on this minimum cycle is POSITIVE.
Indeed if an edge a->b had D<=0, its nonnegative residual would give

    e=(alpha*b+|D|)/a<=mu_hat<alpha,
    a>b, |D|<=mu_hat*a-alpha*b<mu_hat*(a-b).

The actual center separation |D|/(ab) is strictly smaller than the
difference mu_hat/b-mu_hat/a of the two core radii. Thus the source core
is strictly contained in the target core, contrary to the shortcut rule.
These compatible intervals have separation less than mu_hat/b<1/2, so
the same containment is valid on the circle. Therefore D>=g, and (2) gives

    N*g<=N*D=b-r<=a+b-g,
    (a+b)/g>=N+1.                                         (11)

For an upward divisibility edge a|b, (2) forces r=0, and D in aZ then
forces b to be a positive multiple of N*a. For a downward divisibility
edge b|a, (11) forces a/b>=N. Thus every divisibility edge of a minimum
cycle changes speed by a factor at least N. The special case a=1 forces
N|b. There is no reason supplied here that the minimum failure contains
speed 1 or that its cycle must contain a divisibility edge.

The same shortcut gives at most one selected arc at each circle center.
If m(q) is the smallest original speed divisible by q, define

    S(V)=sum_(q dividing some v in V) phi(q)/m(q), phi(1)=1.

This is the cost of all outermost original arcs, one at each rational
center. They still cover at closed mu_hat: every removed coincident inner
core lies in its retained ancestor. Thus their endpoint graph has positive
outdegree too, or one can use the at-most-one-center rule directly, to get

    c_cycle<=S(V).                                         (12)

This is a valid upper bound for the cycle class, but no sharp bound on
S(V) follows from (11). Positive center winding recovers the previously
known small-denominator divisibility profile; it does not force unit
determinants or replace actual speed labels by their reduced denominators.

### The earlier completion upper bound now really applies

Use the accepted notation S_c for the complete structured coincident-center
saving and B_c for the sum of absolute remaining color-cost imbalances.
Private-cell completion constructs an actual alpha-cover of cost

    U=(n+f_F-S_c-B_c)/2.

By (10), choose a minimum cycle C with f_C=c_alpha<=U. Equation (6) gives
the legitimate joint restriction

    f_F-1-S_c-B_c>=Gamma_C>0.                              (13)

The continuous strict-depth inequality also applies at mu_hat. If q_C
sums 1/Q_target exactly over edges with a UNIQUE ORIGINAL alpha-cover,
and r_m=|K_m|, the accepted all-zero parent count gives

    1<=(alpha+mu_hat)*f_C-epsilon_hat*q_C,
    q_C>=r_m*(1/m+1/s).

Combining with U and N(alpha+mu_hat)=2-N*epsilon_hat gives

    f_F-1-S_c-B_c
      >=epsilon_hat*(N+2*q_C)/(alpha+mu_hat)
      >=epsilon_hat*(N+2*r_m*(1/m+1/s))/(alpha+mu_hat).      (14)

Multiple-cover edges receive no private-set bonus. The actual-mu
contraction remains available at unique endpoints, but is not needed to
justify (14). Equations (13)--(14) restrict the saving from ABOVE; they do
not supply an extra saving. The accepted strict-core capacity identity
already leaves a positive deficit after S_c. No reverse estimate for
that deficit or for B_c has been derived here.

## One exact control for the limits of these two methods

Fix any odd N>=7 and odd integer a>1. Set b=(N-1)a+1 and

    V_a={a} union {b+2j:0<=j<=N-3}.

There are exactly n=N-1 distinct positive labels; gcd(a,b)=1 makes the
tuple primitive. Every label is odd, so at t=1/2 every norm equals 1/2.
Its actual maximum is therefore 1/2, and it is NATIVE-GOOD. It supplies
no strict-failure example, saturated strict-bound graph, or closed cycle.

Nevertheless the actual local original alpha-cover
(a,0)->(b,1), at R=1/(Na), has

    D=a, r=1-a, e=-(a-1)/(Na), g=1,
    gamma=a+r=1=rho_N(a+b).

Thus the integer correction is exactly sharp at a compatible native grid
edge. Its relative loss gamma/a=1/a tends to zero; a fixed fractional
improvement cannot follow from this local rounding alone. Global cycle
closure and actual failure minimality are absent and are not refuted.

The same family limits the outer-cost bound. For its labels, pairwise gcds
are at most 2N-5: gcd(a,b+2j)=gcd(a,1+2j), and the gcd of b+2i and b+2j
divides 2|j-i|. At any one center, the total cost removed by retaining only
the outer arc is at most the sum, over pairs there, of the reciprocal of
the larger speed. A pair v,w shares exactly gcd(v,w) centers. Therefore

    0<=n-S(V_a)<=sum_(v<w in V_a) gcd(v,w)/w
                <=binom(n,2)*(2N-5)/a.

For fixed odd N, S(V_a) tends to n=N-1 as a grows, above N/2. Thus
distinctness, primitivity, native width and exact pair divisibility alone
do not make (12) sharp enough. This is one hand family testing local
arithmetic and an unconditional cost formula; it is not an instance of
the complete hypotheses of (10), (13) or (14).

## Remaining implication and verification scope

The substantive new statements are native residue-class spacing (1)--(6),
the auxiliary-bound equality of costs (7)--(10), and the valid minimum-cycle
shortcuts leading to (11)--(14). The previously unavailable completion
upper bound now applies, but its arithmetic saving still falls short of
giving a contradiction. No uniform bound opposing (13)--(14) was found.

Nor does a smaller integer residue give an admissible smaller speed tuple.
The r in (1) is a phase numerator at ONE original endpoint, with its exact
dependence on k in (3). It gives no identity or norm bound for frequency
|r| on all W_a; it can be zero or duplicate a retained label. Original
endpoint owners are likewise original labels, not fresh replacements.
All-admissible sum minimality requires an actual positive injective smaller
tuple and full-time failure transport. Neither is constructed. Simultaneous
private-region repair still leaves the accepted multiply-bad-region gap.

The first unresolved step is additional arithmetic using full compatible
cycle closure and failure minimality that supplies a sufficiently large
completion saving or an actual fresh common blocker. This manuscript does
not promote that desired implication to a theorem or claim it is false.
There is no runner-count ladder, mathematical search or new numerical test.

## Source bindings and checks

The accepted global-cycle author and its independent review were read in
full. The completion/pruning and minimal-frequency interfaces were checked
against their bound sources; the unchanged strict-core and private-repair
scopes are retained. Root's auxiliary-bound proposal is proved here, not
assumed as an external theorem. All new mathematics is hand-derived.

| Input | SHA-256 |
| --- | --- |
| `research/astra-forced-parent-global-cycle.md` | `e265c08b2e0204a8d539e1577ff9907c754287902e6474f043b42be6f5de7bae` |
| `research/astra-forced-parent-global-cycle-review.md` | `eaf481831b74dc031f697481a8f133e12646dc4c7282ff67dfcc9cbb16d566ca` |
| `research/astra-arithmetic-completion-saving.md` | `abfb14f274fb5c72461ce884b7fc44fb89367e056091f628933a601f52a33403` |
| `research/astra-arithmetic-completion-review.md` | `568e9a678777f93de6a4adace739d1b443177662ba7a95e231be30ef2551c019` |
| `research/astra-forced-arc-completion.md` | `e48f80297a70e6630e76fe2b905ed86372383a5d170a539abccdba3decdd98a1` |
| `research/astra-forced-completion-review.md` | `8e72687760576dc0e8524ecbae0bad81bcf3e8cd33f180219848da86a23adb02` |
| `research/astra-strict-core-shell-supply.md` | `5cc9866b3c8a516494ad998355265335a5edd15158cf9701c7d814843b97210e` |
| `research/astra-strict-core-shell-review.md` | `dd733c2910f1f4579846c1c945ecac8e83d140eb29917b81dc11d2b1b119b95f` |
| `research/astra-minimal-frequency-synthesis.md` | `03cf038021f0bc1a2328bb77a02f6ab4fe649f5d3626d7bc368a67cd6c7b0000` |
| `research/astra-minimal-frequency-review.md` | `b26182c2e482e7f83480eab9904779b958eb8b8b753c70bc45c6fabec55b747d` |
| `research/astra-private-repair-review.md` | `a8aaec8468969723207dc12e9ff2c112a4560c1f51e97f13b43f4e342c849512` |
| `.codex/config.toml` | `28212a53cf42cdc377df1f7dab040732d657e59d7bb97ee78791256d01d4bb2c` |
| `docs/project-workflow.md` | `2b42a133352b6b53ba2106fc73882733f176e04a0deffbb183b4c16eefd9cd67` |
| `research/workflow-policy.json` | `833c397b61d1ffdb994fb115019f6d60d6c1a62ff85f19cdd2c9f8ac3a979c8b` |
| `scripts/validate_workflow.py` | `250a3ce2a080f5835ac4fd2e4b2803568424c777cda5d421f9fe92efd34d5383` |

Current config, workflow, policy and focused state were read. The gate was
research/in_progress with start authorization
`2026-09-05T04:12:25.208107+00:00` and this sole owned path. Initial and
final workflow validation, all fifteen source hashes, full owned readback,
whitespace/final-newline checks and the frozen hash are reported at handoff.
The validator checks structure, not mathematics. No mathematical program,
solver, sweep, Lean/build/cache work, additional agent, external model,
Git/shared-state/memory edit or other-file write was performed. Independent
mathematical review remains required.
