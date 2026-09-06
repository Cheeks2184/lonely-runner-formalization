# A finite horizon at the critical shifted margin

**Proved at manuscript scope:** for every integer b>=2, positive real
frequencies w_1,...,w_b, arbitrary real phases theta_1,...,theta_b, and every
real A, there is a common time t in

`[A,A+P]`, where `P=sum_(i=1)^b 1/w_i`,

such that `||theta_i+w_i*t||>=1/(2b)` for every i. Consequently the proposed
H_b holds with `C_b=b` whenever every w_i>=W>0. The period-sum horizon P
is the sharper parameter-dependent statement. No commensurability, integer
frequency, distinctness, gcd, or initial-phase restriction is needed.

This resolves the requested critical finite-horizon claim, not unrestricted
LRC. The result is the weak shifted margin 1/(2b), not 1/(b+1). A conditional
multiple-fast insertion corollary below reaches the boundary 2b=N and retains
equality. No unconditional scale-selection or induction argument is supplied.

Date: 2026-09-06. Task `/root/uniform_critical_interval_horizon`, using the
existing `/root/uniform_affine_phase_screen` session, requested Astra/xhigh.
Source checkpoint: `8b9ea58d8a477a0fad733c3cf6674c307c1f9782`.
Only this report is owned. Current project config, workflow, policy and
focused research/in-progress state were read; the structural validator passed.
Other workers' reports, shared state, Git, caches and Lean sources were not
modified. Independent mathematical review remains required.

## 1. Full-period averaging with compact common support

Write `||x||=dist(x,Z)`. For fixed frequencies put `p_i=1/w_i>0` and consider
the box

`K=product_(i=1)^b [0,p_i]`,

equipped with the product of the normalized Lebesgue measures on its factors.
Equivalently, let U_i be independent uniforms on [0,p_i]. Define the one
shared real time

`T=A+sum_i U_i`.

Every realization of T lies in the compact interval I=[A,A+P]. The auxiliary
increments U_i are independent; the runner phases are not being chosen
independently. Every bad event below is evaluated at that same T on the same
probability space.

For any `0<d<1/2`, define

`E_i(d)={u in K : ||theta_i+w_i*T(u)||<d}`.

These events are measurable because the phase maps and circle norm are
continuous. Fix all coordinates except u_i. As u_i traverses [0,1/w_i], the
phase `theta_i+w_i*T` traverses a real interval of length exactly one.
The 1-periodic strict bad set `{x:||x||<d}` has length 2d in every complete
unit interval. Normalizing the u_i interval therefore gives conditional
probability exactly 2d, independently of the fixed remaining coordinates.
Integrating them out gives

`Prob(E_i(d))=2d` for every i.                         (1)

This is a finite product-integration calculation. Different frequencies
need not share any actual temporal period. The common support length is P
because the auxiliary increments are added, not because the w_i are assumed
to have a common period.

If `d<1/(2b)`, the union bound now gives

`Prob(every i has ||theta_i+w_i*T||>=d) >= 1-2b*d > 0`. (2)

Thus there is a common d-good time in I for every strictly smaller margin d.
The support interval I is the same for all those margins.

## 2. The exact critical boundary

The finite minimum

`g(t)=min_i ||theta_i+w_i*t||`

is continuous on the nonempty compact interval I. Let G be its attained
maximum. Suppose `G<1/(2b)`. Since G>=0, choose

`d=(G+1/(2b))/2`, so `0<d<1/(2b)` and `G<d`.

Equation (2) supplies a time t in I with g(t)>=d, contradicting the definition
of G. Therefore `G>=1/(2b)`, and a maximizing time supplies the required
closed-margin witness.

This compactness step varies the margin for one fixed tuple and one fixed
compact support interval. It does not assume uniform strict slack over
changing frequency ratios or near-tiling configurations. There is no inference
from probability zero to nonexistence at the critical margin. Critical good
times may have measure zero; continuity and attainment retain them.

For a closed interval J of any length at least P, apply the result to its
initial subinterval of length P. Since `w_i>=W` implies
`P<=b/W`, every closed interval of length `b/W` works, proving H_b with the
uniform finite constant C_b=b. The sharper period-sum result also covers
intervals shorter than b/W when some frequencies are larger than W.

Provenance: this worker derived the product-full-period distribution and
its critical open-cover argument. Root supplied the simpler compact-maximum
upgrade in this section, which avoids convolution-density and open-cover
infrastructure. The proof above uses the same exact marginal calculation and
has been checked algebraically by this worker. It is not a novelty claim.

## 3. Boundary and horizon scope controls

The claim holds for arbitrary real phases, repeated or distinct positive
real frequencies, and arbitrary translated intervals. It therefore includes
distinct positive integer frequencies as a specialization. Positivity is
essential to the stated reciprocal-period parameterization; no zero frequency
is allowed. All conclusions use the closed inequality >=.

For equal frequencies w_i=W and equally spaced phases
`theta_i=(i-1)/b`, the strict bad arcs at margin 1/(2b) partition the phase
circle up to their endpoints. The common good times are precisely

`W*t=(2k+1)/(2b)` modulo 1, for `k=0,...,b-1`.

They have no strict margin surplus and occur with temporal spacing 1/(bW).
This demonstrates why strict-slack compactness over all configurations would
be inappropriate. It also shows the threshold cannot be increased uniformly
for arbitrary phases: for every real phase x, one of the b equally spaced
points `x+(i-1)/b` has distance at most 1/(2b) from an integer. For b>=2,
the stronger shifted target 1/(b+1) exceeds this bound and is not asserted.

The same control implies only the lower bound `C_b>=1/b` on a possible
optimal uniform horizon: a shorter closed interval can be placed strictly
between two consecutive good times. The proved C_b=b is sufficient; no
optimality claim is made.

Root's b=2 observation gives a separate sharper bound in terms of the
slowest frequency w_min: a full good band for that frequency at margin 1/4
has length 1/(2w_min), and every interval of length 3/(2w_min) contains such
a band. If it contained no common witness, this connected closed band would
lie inside one strict bad component of the faster frequency. Such components
have length at most 1/(2w_min), and cannot contain a closed interval of that
length. Thus C_2=3/2 also works. This does not replace the parameter-dependent
P bound when P is smaller. No classification of tight configurations is
required for either proof.

## 4. Conditional multiple-fast insertion, including 2b=N

Let `N>=2b`, `b>=2`, and `m=N-1-b>=1`. Suppose there are m positive slow
speeds u_j with maximum M, and one common seed s satisfying

`||s*u_j||>=gamma=1/(N-b)` for every j.

Let the b fast speeds w_i be positive; ordinary zero-phase integer speeds
are the intended application, but fixed arbitrary fast phases theta_i are
also allowed. Put

`delta=1/N`,
`eta=gamma-delta=b/[N(N-b)]`,
`I=[s-eta/M,s+eta/M]`,
`L=length(I)=2b/[N(N-b)M]`.

For t in I, the 1-Lipschitz bound gives

`||t*u_j|| >= ||s*u_j||-u_j*|t-s| >= gamma-eta=delta`. (3)

If

`M*sum_i 1/w_i <= 2b/[N(N-b)],`                     (4)

then P<=L. Apply the period-sum theorem to the initial length-P subinterval
of I. It gives a single time t for which all fast norms are at least
1/(2b)>=1/N. Equation (3) keeps all slow coordinates good at the same t.
Thus (4) is a closed full-witness insertion criterion, conditional on the
supplied slow seed. Equality in P<=L or (4) is legitimate throughout.

In the critical case N=2b these formulas become

`m=b-1`, `gamma=1/b`, `L=1/(b*M)`,
`M*sum_i 1/w_i <= 1/b`.                             (5)

It suffices that every fast speed be at least `b^2*M`, since then
`sum_i1/w_i<=1/(b*M)`. This supplies a genuine positive finite-horizon
criterion at 2b=N, where the phase-uniform Lebesgue interval-discrepancy
estimate alone has no density slack. The proof does not need a common fast
gcd or an interval containing a common temporal period.

The slow witness remains a premise. In a least-count induction it can come
from the appropriate lower-count result, but this report does not establish
that every tuple admits a partition satisfying (4), or that every common
full witness belongs to a protected seed interval. The finite horizon closes
the stated critical local-supply issue, not that separate uniform selection
gap.

## 5. Relation to the subcritical discrepancy estimate

For comparison, the separately derived finite-interval pulse estimate gives,
when `2b<N`, the sufficient reciprocal-sum threshold

`D_(N,b)=b*(N-2b)/[(N-b)*(N-2)]`.

The threshold in (4) is `A_(N,b)=2b/[N*(N-b)]`. Their exact ratio is

`A_(N,b)/D_(N,b)=2(N-2)/[N(N-2b)]`.

For integer b>=2 and 2b<N, N>=5. Thus A is strictly larger, and hence the
period-sum criterion is weaker as a hypothesis, precisely when N-2b=1.
When N-2b>=2, D is strictly larger. At N=2b the discrepancy threshold is
zero and cannot hold for a nonempty fast group, while (5) remains positive.
The criteria can therefore be retained as complementary sufficient tests.
This comparison is ordered arithmetic only; the proof of the horizon theorem
does not depend on the separately authored discrepancy manuscript.

The original b=1 insertion theorem has a different and sharper single-speed
threshold than a naive period-sum substitution. No improvement of that
existing contract is claimed. The added result concerns simultaneous fast
groups at the density boundary and the adjacent subcritical case.

## Verification and implementation limits

All new reasoning is the displayed finite-product integration, compactness,
exact inequalities and hand scope controls. No numerical experiment, search,
mathematical Python program, external literature inference, Lean invocation,
dependency restoration or cache operation was used. No graph coloring or
abstract cover was substituted for an actual common-time orbit.

The slow-coordinate metric API was read in the current unchanged source:

`LonelyRunner/FastRunnerInsertion.lean`, SHA-256
`dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5`,

with `abs_circleNorm_sub_circleNorm_le` supplying (3). Its existing compiled
status is inherited project evidence; this task did not perform a new check.
The nearby multiple-fast report was read for parameter comparison but is not
a dependency of the period-sum proof and is being edited by its owner.

A future implementation can work directly with the finite product of uniform
interval measures, integrate each coordinate in its own period, and use the
maximum of the continuous finite minimum on [A,A+P]. It need not formalize a
convolution-density library, classify exact tilings, or build graph-cover
infrastructure. This is an implementation direction, not a settled claim
about available library declarations or a request to restore caches now.

The structural workflow validator reported:

```text
workflow structural validation passed; it cannot certify mathematical validity.
```

It exited 0. Task elapsed time and per-model token usage were not measured or
exposed and remain null. No independent review or kernel proof is claimed
here. Only this report was written; no `.lake` artifact or dependency source
is needed by the completed manuscript task.
