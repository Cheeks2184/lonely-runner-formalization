# Independent review: optimal endpoint paths and finite potentials

Task `/root/optimal_endpoint_cycle_exchange_review`; recorded checkpoint
`20ec10f1093b10962ddebd59732723c2ab3ff40e`. Requested route:
`gpt-6-astra/xhigh`; observed model, effort, elapsed time and usage: null.
Only this review is owned; root owns shared state and publication.

**Accepted without correction** for author SHA-256
`efb3fcd3117d363c4d9f9413a67b837e5e5986a3c519f0163fcaf0dcfeaaffb2`.
The all-path inequality correctly charges additional winding, and the finite
potential theorem has the stated direction and equality cases. The native
constant potential is a lower-cost certificate. The translation obstruction
is valid for the specified label-preserving shifts, with no claim against
all symmetries or stronger arithmetic. No uniform contradiction, fresh
lowering or new falsifier of the actual failure hypotheses is obtained.

## Exact inherited graph contract

Assume n=N-1>=5 distinct positive primitive integer speeds V in a hypothetical
canonical strict failure, least by count and then primitive sum. Let
alpha=1/N, m=max V and 0<mu=max_t min_(v in V)||vt||<alpha. Each full W_v
requires all other original labels to have norm at least alpha. Least count
makes these sets nonempty, so the complete forced family F has at least one
indexed arc of every label and actual private points relative to ALL original
open alpha-arcs. No restriction to one selected seed is made.

The accepted bound mu_hat=max(mu,alpha-1/(Nm))<alpha makes its closed-core
endpoint graph exactly the full original open-alpha endpoint graph. This
does not identify that graph with the actual-mu graph. Every simple cycle
is an original alpha-cover, contains F and winds once. Its positive reciprocal
vertex cost equals its edge cost when an edge is charged for its target.
The minimum simple-cycle cost c equals the minimum original alpha-cover cost.
These are the unchanged accepted inputs, not new assumptions of optimality
for an arbitrary selection.

For an edge A=(a,k)->B=(b,l mod b), its compatible lifted index is fixed by
|b R_A-l|<=mu_hat. With the actual lifted indices,

    r=b-N*(a*l-b*k), |r|<a,
    Delta(A,B)=(a-r)/(N*a*b)>0, w(A,B)=1/b.

Delta is the canonical advance of right endpoints in (0,1), fixed by that
core-containing lift; indeed Delta<2alpha/b<1. Adding an integer to the
source time lift shifts both arc indices by their respective labels and
leaves Delta and r unchanged. Thus advances can be added edge by edge in
paths, even when indexed vertices repeat, without selecting inconsistent
target lifts. No independently favorable residue is substituted for an edge.

## Every path and every extra winding

Fix a minimum simple cycle C and vertices A_i,A_j on it. Its forward segment
has displacement d_ij and cost c_ij, with targets counted once per edge.
For i!=j, positivity of every step and total winding one give 0<d_ij<1.
For i=j the chosen segment is empty, so d_ii=c_ii=0; its complementary
segment is the full cycle. In both cases the complementary segment has
displacement 1-d_ij and cost c-c_ij.

For ANY finite directed path P from A_i to A_j, possibly with repeated
vertices, its displacement differs from d_ij by an integer h because the
initial and final circle endpoints agree. This h is nonnegative:

* If i!=j, P is nonempty, its advance is positive, and
  h=displacement(P)-d_ij>-1; integrality gives h>=0.
* If i=j, the advance is a nonnegative integer. The empty path has h=0;
  a nonempty path has h>=1.

Concatenating P with the complementary C-segment gives a directed closed
walk of displacement h+1 and cost cost(P)+c-c_ij. Repeated vertices cause
no problem. At the first repeated vertex in a traversal, remove the segment
between its two occurrences to extract a simple cycle, then continue with
the remaining closed walk. Finitely many
steps exhaust the edges. Each occurrence of an edge contributes its original
cost and advance exactly once to this decomposition. Each extracted simple
cycle has winding one by the accepted private-point argument, so there are
exactly h+1 cycles. Every one costs at least c. Therefore

    cost(P)+c-c_ij>=(h+1)*c,
    cost(P)>=c_ij+h*c.                                    (R1)

Costs here count target occurrences, not the cost of the set of distinct
vertices visited by P. This distinction is necessary for repeated turns.
Equality is attained by h complete copies of C based at A_i followed by
its forward i-to-j segment, including h=0 and the empty case. No strict
inequality at equal costs is warranted.

The earlier block-exchange manuscript treats an actual original arc replacing
a consecutive block in a minimum subcover, with a strict integer window and
a possibly singleton uncovered gap. The present statement concerns arbitrary
valid endpoint paths and extra winding; both are consequences of actual
cover optimality. Neither statement supplies the cheaper replacement whose
existence would contradict that optimality. The present proof does not reuse
the older working-width control as a native strict-failure example.

## The finite potential theorem and equality on the optimum

For any real lambda put

    L_lambda(A,B)=w(A,B)-lambda*Delta(A,B).

Every simple cycle Z has total L_lambda-weight cost(Z)-lambda because its
winding is one. If lambda<=c, every such sum is nonnegative. Decomposition
of closed walks then gives nonnegativity for every closed walk. Conversely
the minimum cycle has weight c-lambda, so closed-walk nonnegativity implies
lambda<=c. This includes negative lambda without any extra assumption.

For lambda<=c, add one auxiliary source with a zero-weight edge to every
original vertex and no incoming edges. Every vertex is reachable from it,
so no strong connectivity of the original graph is needed. In a source-to-B
path, removing a closed subwalk of nonnegative weight cannot increase the
weight. Hence every such path can be shortened to a simple path of no larger
weight. There are finitely many simple paths in this finite augmented graph,
and at least one to each B. Their minimum p(B) is therefore also the minimum
over all finite paths to B. Appending an original edge yields

    p(B)-p(A)<=L_lambda(A,B) for every original edge.        (R2)

This also handles zero-weight cycles: removing them preserves rather than
strictly decreases weight, which suffices for attainment. Conversely, summing
(R2) on a minimum cycle gives 0<=c-lambda. The claimed equivalence is exact:

    a finite real potential satisfying (R2) exists
      if and only if lambda<=c.                           (R3)

At lambda=c, each edge of C has nonnegative slack
L_c(A,B)-(p(B)-p(A)). Their sum is c-c=0; thus every slack on C is zero.
Summing along its chosen forward segment gives

    p(A_j)-p(A_i)=c_ij-c*d_ij.

Summing (R2) along an arbitrary P, including repeated vertices, instead
gives p(A_j)-p(A_i)<=cost(P)-c*(d_ij+h). Combining proves exactly (R1).
The potential theorem certifies the same minimum-cycle optimality and
replacement-path restriction. Passing to a potential has not supplied a
new upper bound or a graph-compatible alternative path.

## Native threshold: an explicit lower-cost certificate

At lambda=N/2, direct substitution on EVERY original edge gives

    L_(N/2)=1/b-(a-r)/(2*a*b)=(a+r)/(2*a*b)>0.             (R4)

Strict positivity follows from the native edge condition r>-a. The zero
potential therefore satisfies every edge inequality strictly. This is local
integer spacing; it needs no choice of optimum or arithmetic averaging.
Summing (R4) on a cycle gives a strict positive gap above cost N/2, consistent
with the earlier native residue correction and open-cover cost requirement.
The feasible-potential implication in (R3) is lambda<=c, never c<=lambda.

Thus potential feasibility at N/2 cannot supply the desired opposing upper
cost bound: its explicit certificate is already available. This statement
does not exclude additional arithmetic constraints on potentials, new
constructions using actual V, or another argument contradicting the graph's
existence under the full failure hypotheses. No linear-programming theorem
or computation is needed for the finite proof above.

## Exact translation scope and endpoint compatibility

The a-grid is the subgroup {k/a mod 1}. Translation by tau preserves that
grid exactly iff a*tau is an integer: necessity follows by translating its
zero center, and sufficiency follows by shifting every numerator by the
integer a*tau. To preserve EACH original speed grid, all v*tau must be
integers. Since gcd(V)=1, integer Bezout coefficients z_v with sum z_v*v=1
give tau=sum z_v*(v*tau) in Z. Therefore the common label-preserving
translation group is trivial modulo one.

This argument also applies to a proposed translation of an entire selected
cycle into the original labeled grids: C contains F and therefore uses
every original label. Having even one translated center in the same grid
already forces v*tau integral for that label. The conclusion concerns
translations preserving the original labels and radii, not every possible
accidental graph automorphism, permutation, or arithmetic construction.

For a path whose used labels have common divisor g, shifts by multiples of
1/g do preserve its indexed original arcs and translate its valid edge
relations. They generally move BOTH endpoint vertices, however. Applying
(R1) requires the specified endpoints on C and the corresponding lifted
displacement; those conditions need a new check after translation. A shift
by 1/a sends a b-index l to l+b/a, which is integral exactly when a divides
b. Replacing it by another integer changes the arc and residual and demands
a fresh original cover test. Independent shifts in different speed grids
therefore cannot be treated as established cross-label graph symmetries.

Reflection sends the arc centered at k/a to that centered at -k/a and sends
its right endpoint to the reflected arc's LEFT endpoint. It transports the
problem to the reflected left-endpoint graph with unchanged costs; it does
not reverse the potential inequality into an upper-cost estimate. Averaging
valid symmetry-transformed inequalities preserves their direction. This
does not classify all usable symmetry arguments or show that none could
contribute to a stronger proof.

## Verdict, first gap and source bindings

All new derivations are correct at their stated scopes. The precise positive
statement is the winding-sensitive all-path optimality inequality and its
finite potential representation. The two investigated shortcuts supply no
new path or speed tuple: independent grid translations need endpoint and
index compatibility, and the threshold potential already certifies a lower
bound. No new arithmetic obstruction under complete native failure has been
proved or falsified.

The first unresolved implication remains an additional construction, using
the full original arithmetic and failure minimality, that would violate
(R1), or an admissible positive injective smaller tuple with whole-time
failure transport. Replacing selected arc indices keeps V fixed and is not
a smaller-sum speed replacement. A fresh u<v would have to be strictly
alpha-bad on ALL W_v; simultaneous private-region repair still leaves the
multiply-bad regions identified in the accepted review. No uniform LRC
conclusion or runner-count ladder follows from these optimization facts.

The frozen author was fully read. The older block-exchange author/review
were read in full for their exact comparison. The unchanged native and full
endpoint-cycle interfaces had already been independently reviewed in this
session and retain their bound scopes. All fourteen sources below (author
plus its thirteen inputs) were verified against current bytes.

| Bound source | SHA-256 |
| --- | --- |
| `research/astra-optimal-endpoint-cycle-exchange.md` | `efb3fcd3117d363c4d9f9413a67b837e5e5986a3c519f0163fcaf0dcfeaaffb2` |
| `research/astra-native-endpoint-cycle-arithmetic.md` | `2c80cee9d9f84f1850bda7aa1fc7798e890d7471b09d89578494cf208997257e` |
| `research/astra-native-endpoint-cycle-arithmetic-review.md` | `098c4da30496a606b3d4b9ff0bd41933d6b55f61f9c5da4f085b5e412a889404` |
| `research/astra-forced-parent-global-cycle.md` | `e265c08b2e0204a8d539e1577ff9907c754287902e6474f043b42be6f5de7bae` |
| `research/astra-forced-parent-global-cycle-review.md` | `eaf481831b74dc031f697481a8f133e12646dc4c7282ff67dfcc9cbb16d566ca` |
| `research/astra-arithmetic-winding-exchange.md` | `6fbd8b96223e1697c33d5e187c25fb9f93707c880f2794892dfa16ca0ab2d6d4` |
| `research/astra-arithmetic-winding-review.md` | `45eca69dd2c8b48a0cec68ca737262b9f1a616b08f85046629c9c4e632618243` |
| `research/astra-minimal-frequency-synthesis.md` | `03cf038021f0bc1a2328bb77a02f6ab4fe649f5d3626d7bc368a67cd6c7b0000` |
| `research/astra-minimal-frequency-review.md` | `b26182c2e482e7f83480eab9904779b958eb8b8b753c70bc45c6fabec55b747d` |
| `research/astra-private-repair-review.md` | `a8aaec8468969723207dc12e9ff2c112a4560c1f51e97f13b43f4e342c849512` |
| `.codex/config.toml` | `28212a53cf42cdc377df1f7dab040732d657e59d7bb97ee78791256d01d4bb2c` |
| `docs/project-workflow.md` | `2b42a133352b6b53ba2106fc73882733f176e04a0deffbb183b4c16eefd9cd67` |
| `research/workflow-policy.json` | `833c397b61d1ffdb994fb115019f6d60d6c1a62ff85f19cdd2c9f8ac3a979c8b` |
| `scripts/validate_workflow.py` | `250a3ce2a080f5835ac4fd2e4b2803568424c777cda5d421f9fe92efd34d5383` |

Current configuration, workflow, policy and focused state were read. The
state was research/in_progress with explicit start authorization
`2026-09-05T04:12:25.208107+00:00` and this sole owned review path.
Initial `python3 -B scripts/validate_workflow.py` exited 0 with
`workflow structural validation passed; it cannot certify mathematical validity.`
Full owned readback, final binding/whitespace/newline checks, final workflow
validation and frozen review hash are returned at handoff. Administrative
file/hash checks are distinct from this hand mathematical review. No
mathematical program, enumeration, solver, build/cache/dependency operation,
new agent, external model, Git/shared-state/memory edit or other-file write
was performed. Unrestricted LRC remains unresolved.
