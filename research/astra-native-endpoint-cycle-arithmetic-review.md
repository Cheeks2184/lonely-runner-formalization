# Independent review: native spacing and minimum endpoint-cycle cost

Task `/root/native_endpoint_cycle_arithmetic_review`; recorded checkpoint
`1e4a89034bcab452949734f0d0d689d7de5e27f2`. Requested route:
`gpt-6-astra/xhigh`; observed model, effort, elapsed time and usage: null.
Only this review is owned; root owns shared state and publication.

**Accepted without correction** for author SHA-256
`2c80cee9d9f84f1850bda7aa1fc7798e890d7471b09d89578494cf208997257e`.
Native spacing does saturate the endpoint graph at the specified auxiliary
bound, and its minimum cycle cost equals minimum original alpha-subcover
cost. The residue corrections, minimum-cycle shortcuts, divisibility bounds
and resulting necessary deficits are valid. The explicit family is native
LRC-good and refutes neither the complete failure hypotheses nor the desired
uniform contradiction. This is manuscript acceptance, not a kernel theorem.

## Exact hypotheses and graph scope

Use n>=5 distinct positive primitive integer speeds V in a hypothetical
canonical strict failure, least by moving count and then primitive sum.
Put N=n+1, alpha=1/N, m=max V, s=max(V\{m}), and let
0<mu=max_t min_(v in V)||vt||<alpha be the ACTUAL maximum on R/Z.
For each v, W_v requires every other original norm to be at least alpha,
and Q_v=max(V\{v}). All W_v and all their attained collision indices K_v
are retained. Least count supplies nonemptiness. The forced family F is
exactly the original indexed alpha-arcs having private points outside
EVERY other original alpha-arc; write f_F=sum_v |K_v|/v.

The earlier endpoint-cycle proof requires a full closed-core cover at a
bound eta<alpha, together with these actual private points. It does not
require eta to equal the attained maximum: positive lifted right-endpoint
increments still give a full alpha-cover, and a forced private point still
forces winding one for a simple cycle. Every such cycle contains F.
This justifies its use with eta=mu_hat below. The indexed alpha-arcs,
private points and W_v do not change when the auxiliary cores change.

The all-zero condition at EVERY attained maximum arc is needed only for
the compulsory parent contribution. It is not a general consequence of
strict failure, nor an input to the native-spacing and minimum-cost bridge.
No all-admissible minimum-sum bound on cover cost is assumed.

## Native residues, gcd division and compatible winding

For an original b-arc covering the right endpoint of (a,k), choose the
actual lifted index l and set

    R_A=(Nk+1)/(Na), e=b*R_A-l,
    D=a*l-b*k, r=b-N*D=N*a*e.

Here |e|<1/N, so r is an integer with |r|<a. With g=gcd(a,b),
A=a/g and B=b/g, divisibility gives D,r in gZ. Hence

    |r|<=a-g, r/g congruent B modulo N.                    (R1)

There is no lost source-index constraint:

    r=b*(Nk+1)-Na*l,
    l=[b*(Nk+1)-r]/(Na) in Z.                             (R2)

For fixed k and b, at most one r in (-a,a) has this congruence modulo Na,
since 2a<Na. The weaker congruence in (R1) cannot create an edge at a
specified index. A and B are only gcd-quotient notation; no original speed
or radius is replaced by a reduced denominator.

Direct endpoint subtraction gives

    R_B-R_A=(a-r)/(N*a*b)>0.                              (R3)

For an actual compatible simple cycle, the final lifted index equals its
initial index plus its speed, by winding one. A cyclic shift preserves
the multiset of reciprocal labels even when a label occurs at several
different vertices. Thus summing (R3) gives both exact forms

    N=sum_edges (a-r)/(a*b)
     =2*f_C-sum_edges (a+r)/(a*b),
    f_C=sum_vertices 1/v.                                 (R4)

There are n=N-1 available labels, not necessarily n vertices in the cycle.
No original indexed vertex repeats. These facts, rather than independent
choices of residues satisfying a scalar identity, underlie (R4).

Let rho_N(z) be the least POSITIVE residue in {1,...,N}. The positive
integer gamma=a+r is divisible by g and satisfies
gamma/g congruent A+B modulo N. Therefore

    gamma>=g*rho_N(A+B),
    Gamma_C=sum_edges rho_N(A+B)/lcm(a,b)>0,
    N<=2*f_C-Gamma_C.                                     (R5)

The denominator is correct because lcm(a,b)=ab/g. In particular the zero
congruence class contributes N, not zero. Similarly the positive a-r
has quotient congruent A-B, giving the stated companion inequality
sum rho_N(A-B)/lcm(a,b)<=N. Both are necessary inequalities on compatible
cycles; neither supplies an upper cost bound or compatible lifted indices.

## Exact auxiliary saturation and equality of minimum costs

Define mu_hat=max(mu,alpha-1/(Nm)) and epsilon_hat=alpha-mu_hat.
Both entries of the maximum are strictly below alpha, and mu>0, so

    0<mu<=mu_hat<alpha, epsilon_hat>0.

For ANY original alpha-cover of an original endpoint, integer spacing
already gives |r|<=a-1. Since the chosen error is in (-alpha,alpha), it
is the actual nearest-integer norm there. Consequently

    ||b R_A||=|r|/(Na)<=alpha-1/(Na)
                   <=alpha-1/(Nm)<=mu_hat.                (R6)

The middle direction uses a<=m. The converse holds because mu_hat<alpha.
Thus the closed-mu_hat endpoint graph equals exactly the FULL original
open-alpha endpoint graph, including equality in (R6). This equality is
not asserted for the actual-mu graph.

The full minimum is bounded by mu_hat at all real times. For t in W_v and
|h|<epsilon_hat/Q_v, every retained norm at t+h is strictly greater than
mu_hat. Hence the target norm stays at most mu_hat throughout this open
interval. Connectedness keeps it in one closed target-core component,
since mu_hat<1/2. Limits at both interval endpoints give

    ||vt||<=mu_hat-v*epsilon_hat/Q_v on ALL W_v.             (R7)

The weak sign and the closed domains are correct. This derives the bound
from full-time coverage; it does not substitute a merely local test value
for a global bound or infer that any selected endpoint is deletion-good.

Let c_alpha be minimum cost of an original alpha-subcover and c_cycle
minimum cost of a simple cycle in the graph at mu_hat. Both minima exist
in finite nonempty collections. Every cycle is an alpha-cover, so
c_alpha<=c_cycle. Conversely, in ANY alpha-subcover S the right endpoint
of each member is covered by another member. Its own arc omits that point;
same-label arcs cannot cover it either. Equation (R6) turns these covers
into edges inside S. The restricted finite graph therefore has positive
outdegree and a simple cycle whose positive vertex cost is at most cost(S).
Taking a minimum subcover proves

    c_cycle=c_alpha.                                     (R8)

The accepted winding-one proof applies even to cycles found in S, because
they are cycles of the full graph and retain the same original private
points. In its half-open lifted interval, every transition endpoint is
covered by the next open arc. There is no extra boundary assumption in
the reverse cost inequality. This is an actual repair of the earlier
missing transfer of alpha-cover upper bounds to the cycle class.

## Minimum-cycle exchange and positive determinants

Choose a minimum-cost simple cycle at mu_hat. Suppose selected distinct
cores satisfy H_B subset H_O. If A precedes B, then R_A in H_B gives
A->O. The vertex O cannot be A, because R_A has its own norm alpha and
is outside H_A. It is not B by assumption. Following the old cycle from
O through A and closing with A->O makes a simple cycle omitting B and
possibly more vertices. All costs are positive, contradicting minimality.
This justifies the shortcut for closed cores, including containment with
endpoint equality. A two-vertex cycle cannot be an exceptional case:
then O would necessarily be A, already excluded.

For a minimum-cycle edge a->b with D<=0, its compatible residual is

    e=(alpha*b+|D|)/a<=mu_hat<alpha.

Thus a>b and
|D|<=mu_hat*a-alpha*b<mu_hat*(a-b). The center separation in these lifts
is |D|/(ab), strictly less than mu_hat/b-mu_hat/a. Hence the source core
is contained in the target core, contradicting the shortcut. The chosen
separation is below mu_hat/b<1/2; containment of the compatible real
intervals projects to containment on the circle. Therefore D>0 and its
gcd divisibility gives D>=g. Combining with (R1) yields

    N*g<=N*D=b-r<=a+b-g,
    (a+b)/g>=N+1.                                        (R9)

This positivity belongs to a minimum cycle. It is not imposed on every
edge of the full graph or on the earlier arbitrary simple cycles.

If a divides b, then g=a and (R1) forces r=0. Since D=b/N is a positive
multiple of a, b is a positive multiple of N*a. If b divides a, then
g=b and (R9) gives a/b>=N. Thus every divisibility edge changes speed by
a factor at least N, with the stated special case a=1 implying N|b.
There is no claim that speed 1 or any divisibility edge must occur.

The shortcut also permits at most one selected arc per circle center.
At reduced denominator q the available owners are exactly the original
q-divisible speeds; retaining their smallest speed m(q) keeps the largest
core at that center. All omitted coincident cores lie inside it. There
are phi(q) such centers, with phi(1)=1 for zero, so the retained cost is

    S(V)=sum_q phi(q)/m(q).

These outer cores still cover at closed mu_hat. Their endpoint graph has
positive outdegree, and a contained simple cycle proves c_cycle<=S(V).
Alternatively a minimum cycle's at-most-one-center rule bounds its cost
by this same sum, since a selected owner v>=m(q) has 1/v<=1/m(q).
No reduced center is silently turned into an unavailable original speed.

## Applying the old completion bound: necessary deficits only

The accepted private-cell pruning/coloring construction gives an actual
alpha-cover with cost U=(n+f_F-S_c-B_c)/2. Equation (R8) now legitimately
gives a minimum cycle C with f_C<=U. Write
Delta=f_F-1-S_c-B_c, so 2U=N+Delta. Equation (R5) implies

    N<=2*f_C-Gamma_C<=N+Delta-Gamma_C,
    Delta>=Gamma_C>0.                                    (R10)

The count n=N-1 is essential in this rearrangement. This inequality
requires a positive deficit in the available saving; it supplies no new
discardable cost or imbalance.

For an edge whose endpoint has a UNIQUE ORIGINAL alpha-cover, (R7) gives
the private-set bonus epsilon_hat/Q_target. An endpoint with multiple
original covers lies in no W_v; uniqueness only within the selected cycle
does not license the bonus. With q_C counting precisely the original-unique
edges, the accepted residual identity gives

    1<=(alpha+mu_hat)*f_C-epsilon_hat*q_C.

Since N(alpha+mu_hat)=2-N*epsilon_hat and f_C<=U=(N+Delta)/2,
multiplying by two and rearranging yields exactly

    Delta>=epsilon_hat*(N+2*q_C)/(alpha+mu_hat).            (R11)

Under the separately assumed all-zero condition at every attained maximum
arc, the original forced parents and their unique endpoint covers are
unchanged. Their distinct maximum and left-parent source vertices give
q_C>=|K_m|*(1/m+1/s), as previously reviewed. Substitution gives the last
bound in the author's (14). Both weak inequalities have the correct
direction. Actual-mu contraction remains valid at original-unique endpoints,
but need not apply to a selected successor at a multiple-cover endpoint.

The previous strict-core capacity identity already leaves a positive
deficit after the complete S_c saving. Equations (R10)--(R11) do not reverse
that obstruction. They are additional necessary lower bounds on Delta,
equivalently upper restrictions on S_c+B_c. No contradictory upper bound
on Delta is derived from full count or sum minimality.

## Complete hand check of the one native-good control

Fix odd N>=7 and odd a>1. Set b=(N-1)*a+1 and
V_a={a} union {b+2j:0<=j<=N-3}. The progression contains N-2 labels;
together with a this gives exactly n=N-1 distinct positive speeds.
They are all odd, and gcd(a,b)=1 makes the tuple primitive. At t=1/2
every norm is 1/2; since no circle norm exceeds 1/2, the actual maximum
is EXACTLY 1/2. In particular mu<alpha fails decisively.

At the native width alpha=1/N, the compatible local edge (a,0)->(b,1)
has endpoint R=1/(Na) and

    bR=1-(a-1)/(Na), D=a,
    r=1-a, e=-(a-1)/(Na), gcd(a,b)=1,
    a+r=1=rho_N(a+b), since a+b=Na+1.

Its residual has magnitude strictly below alpha, so it really is an
original alpha endpoint edge. The correction is exactly attained and
its relative size (a+r)/a=1/a tends to zero. This checks sharpness of
the LOCAL residue bound; no compatible full cycle is claimed.

For the outer-cost limit, gcd(a,b+2j)=gcd(a,1+2j)<=2N-5. Two different
progression labels have gcd dividing 2|i-j|<=2N-6, so the stated uniform
bound 2N-5 is valid for every pair. A pair of speeds v,w shares exactly
gcd(v,w) grid centers, including zero. At one center with increasingly
ordered owners v_1,...,v_h, the discarded cost is sum_(j>=2)1/v_j,
whereas its pair charge is sum_(j>=2)(j-1)/v_j, which is at least that
discarded cost. Summing over centers therefore proves

    0<=n-S(V_a)<=sum_(v<w) gcd(v,w)/w
                <=binom(n,2)*(2N-5)/a.

Every denominator w is at least a. For fixed odd N, this tends to zero
as odd a grows, so S(V_a) tends to n=N-1>N/2. The definition and counting
formula for S(V) make sense without a cover. The family consequently
limits this unconditional cost estimate; it is not an instance of the
strict-bound graph, minimum-cost equality, or deficit inequalities under
the failure hypotheses. No native strict-failure counterexample is present.

## Verdict, remaining implication and bindings

The positive advance is the explicit native-spacing bridge (R6)--(R8),
allowing the actual completion upper bound to enter the cycle arithmetic.
Minimum-cost exchange then yields positive determinants and the stated
divisibility restrictions. All new claims and their endpoint scopes pass
independent hand review without correction.

The first unresolved implication is a further arithmetic constraint on
FULL compatible cycles under failure minimality that opposes (R10)--(R11),
or supplies an admissible fresh smaller tuple with whole-time failure
transport. A phase numerator r at one endpoint is not such a frequency;
it can be zero or duplicate a retained speed and gives no bound on all W_a.
Likewise, simultaneous private-region repair still omits multiply-bad
regions. The control does not falsify the missing canonical implication.
No count ladder, new search or additional research mechanism is introduced.

The frozen author, the accepted full-cycle review and the arithmetic-saving
review were fully read. Other unchanged invoked interfaces retain the
previously reviewed scopes, with current hash verification. The author and
all fifteen input bindings below were checked; earlier full audits and
mathematical programs were not rerun.

| Bound source | SHA-256 |
| --- | --- |
| `research/astra-native-endpoint-cycle-arithmetic.md` | `2c80cee9d9f84f1850bda7aa1fc7798e890d7471b09d89578494cf208997257e` |
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

Current configuration, workflow, policy and focused state were read. The
gate was research/in_progress with recorded start authorization
`2026-09-05T04:12:25.208107+00:00` and this sole owned review path.
Initial `python3 -B scripts/validate_workflow.py` exited 0 with
`workflow structural validation passed; it cannot certify mathematical validity.`
Full owned readback, final sixteen-source binding and whitespace/newline
checks, final workflow validation and frozen review hash are returned at
handoff. Administrative file/hash checks do not certify the mathematics.
No mathematical program, enumeration, solver, build, Lean/cache operation,
additional agent, external model, Git/shared-state/memory edit, program
change or other-file write was performed. Unrestricted LRC remains unresolved.
