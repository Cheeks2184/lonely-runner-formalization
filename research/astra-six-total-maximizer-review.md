# Independent review of constrained maximizers and the six-total plan

2026-09-06. Task `/root/six_total_maximizer_review`, requested Astra/xhigh,
reusing agent `/root/seven_adic_expanded_falsifier`; runtime model and effort
are not independently attested. Assigned current-main checkpoint
`f1d45fdf95af26f31cffcc92485fc5951c4b0169`. Current project configuration,
workflow, policy and focused state were read. Research is authorized and
`python3 -B scripts/validate_workflow.py` passed. Only this report is owned.
The independent PrimeAdic implementation is outside this review.

**Verdict: accept P, M and D at manuscript scope, with their proposed Lean
contracts unchanged.** The strict-seed counterexample, unsigned/signed phase
interfaces, and the proposed 5.1 atom/mask bounds are also sound at the
stated scopes. This does not establish any phase coverage theorem, divisibility
assembly, new runner count, or unrestricted LRC result.

The author manuscript was read in full: 437 lines, 22,181 bytes,
`research/astra-six-total-maximizer-plan.md`, SHA-256
`ef0b17914b831106650ff0f09152054131fcaba58ce47a10a0bf36c0fdccb100`.
This pass performed source reading, source hashing, primary-PDF inspection
and handwritten mathematical review only. There was no enumeration,
search, solver, arithmetic experiment, Lean execution, or cache work.
No measured arithmetic result or executed finite coverage is claimed.

## Independent derivation of the accepted contracts

For a real z, write r=frac(z), so `z=floor(z)+r` and `0<=r<1`.
Integer periodicity reduces the circle norm to r. If r<=1/2, its norm
is r; otherwise translate by -1 to obtain norm 1-r. Therefore

    circleNorm(z)=min(r,1-r).

For `0<delta<1/2`, its closed and strict lower bounds correspond exactly
to the closed and open bands with endpoints delta and 1-delta. This
argument never asserts global continuity of fractional part.

For P, define the capacity of label i as `(1/2-x_i)/v_i` and that of
each other label j as `(1-delta-x_j)/v_j`. All capacities are positive:
the numerators follow from P's phase hypotheses and all natural speeds
are positive. The finite index type is nonempty because it contains i.
Thus its minimum c is positive. With epsilon=c/2, every increment
`epsilon*v_j` is positive and strictly below the corresponding capacity
numerator. Retain the original integer floor of `s*v_j`; the updated
remainder stays in `[0,1)`. The distinguished remainder stays below 1/2
and strictly increases, while every other remainder remains between delta
and 1-delta. This proves P, including lower-band equality and arbitrary
real s. Its stated lower bound on the distinguished phase is automatic
from `Int.fract`; it is not a missing hypothesis.

For M, the strict complement seed is feasible. If its distinguished norm
vanishes, its fractional phase is zero, so P supplies a feasible point
with positive norm. Otherwise the seed already has positive objective.
Each norm function is continuous, and integer speeds make all of them
periodic with period one. Consequently the complement-safe set T is
closed, and `T intersect [0,1]` is a nonempty compact set containing a
positive-objective point after fractional-time normalization. Its norm
maximum M is attained. Every real feasible time normalizes into this
set with the same objective, so the maximum is global over T.

The endpoints 0 and 1 have zero objective, hence cannot maximize this
positive value. At a feasible maximizer, a distinguished norm at least
delta would give a full closed witness. The no-witness premise therefore
gives `0<M<delta<1/2`. Its distinguished phase is either M or 1-M.
In the second case use `tau=1-u`: every norm is preserved by evenness
and integer periodicity, and the nonzero distinguished phase reflects
to M. Thus `0<tau<1`, tau is still globally maximizing, and its phase
equals its norm in `(0,delta)`. Reflecting according to time rather than
phase would not justify that conclusion.

If no actual other label had phase 1-delta at tau, complement safety
would put every other phase in `[delta,1-delta)`. P would increase the
distinguished objective at a feasible real time, contradicting global
maximality. This proves the actual upper-face label in M. A lower face
alone is insufficient to obstruct forward motion. A singleton index type
causes no hidden empty-minimum failure: the capacities include i, and its
no-full-witness premise is itself impossible at delta<1/2.

The strict seed is essential for the proposed positive-maximum conclusion.
For speeds `(3,1,2)`, distinguished speed 3 and delta=1/3, speed 1 is safe
modulo one on `[1/3,2/3]`. Speed 2 is safe on
`[1/6,1/3] union [2/3,5/6]`. Their intersection is exactly the two
points 1/3 and 2/3, where speed 3 has norm zero. Hence T is nonempty
but its maximum objective is zero and there is no full closed witness.
This is a handwritten refutation of weakening the seed premise, not a
counterexample at the ordinary LRC threshold.

For D, let `x=frac(t*d)` with `0<x<1/N`, and `2<=alpha<N`, N>=3.
Then x<1/2, `0<alpha*x<1`, and both

    alpha*x > x,
    1-alpha*x > x

hold; the second follows from `(alpha+1)*x<=N*x<1`. Thus the norm
of alpha*x strictly exceeds x even if it has crossed one half. Write
`d=N*q`. Expanding the new product separates the integer
`alpha*floor(t*d)+beta*q` from alpha*x, proving the reciprocal-shift
conclusion for every signed integer beta. The proposed natural d=0
case is excluded automatically by the positive fractional-phase premise.
No positivity hypothesis on beta, primality hypothesis on N, or extra
phase monotonicity assumption is missing. Alpha=1 preserves the
distinguished norm; it needs P for a later strict improvement.

## Exact accepted Lean interfaces

These are the author's exact proposed declaration types, copied for the
implementation contract. Proof bodies are absent; none is claimed to have
been kernel-checked by this review.

```lean
def ComplementSafe {I : Type*} (v : I → ℕ) (i : I)
    (δ t : ℝ) : Prop :=
  ∀ j, j ≠ i → δ ≤ circleNorm (t * (v j : ℝ))

theorem exists_forward_complement_improvement
    {I : Type*} [Fintype I] [DecidableEq I]
    (v : I → ℕ) (i : I) (hv : ∀ j, 0 < v j)
    (δ s : ℝ) (hδ : 0 < δ) (hδhalf : δ < (1 : ℝ) / 2)
    (hi : Int.fract (s * (v i : ℝ)) < (1 : ℝ) / 2)
    (hbands : ∀ j, j ≠ i →
      δ ≤ Int.fract (s * (v j : ℝ)) ∧
      Int.fract (s * (v j : ℝ)) < 1 - δ) :
    ∃ ε : ℝ, 0 < ε ∧ ComplementSafe v i δ (s + ε) ∧
      circleNorm (s * (v i : ℝ)) <
        circleNorm ((s + ε) * (v i : ℝ))

theorem exists_oriented_complement_maximizer
    {I : Type*} [Fintype I] [DecidableEq I]
    (v : I → ℕ) (i : I) (hv : ∀ j, 0 < v j)
    (δ : ℝ) (hδ : 0 < δ) (hδhalf : δ < (1 : ℝ) / 2)
    (hstrict : ∃ s : ℝ, ∀ j, j ≠ i →
      δ < circleNorm (s * (v j : ℝ)))
    (hno : ¬ ∃ t : ℝ, ∀ j, δ ≤ circleNorm (t * (v j : ℝ))) :
    ∃ τ : ℝ, 0 < τ ∧ τ < 1 ∧ ComplementSafe v i δ τ ∧
      (∀ t : ℝ, ComplementSafe v i δ t →
        circleNorm (t * (v i : ℝ)) ≤ circleNorm (τ * (v i : ℝ))) ∧
      0 < Int.fract (τ * (v i : ℝ)) ∧
      Int.fract (τ * (v i : ℝ)) < δ ∧
      Int.fract (τ * (v i : ℝ)) = circleNorm (τ * (v i : ℝ)) ∧
      ∃ j, j ≠ i ∧ Int.fract (τ * (v j : ℝ)) = 1 - δ

theorem reciprocal_dilate_shift_improves
    (N d α : ℕ) (β : ℤ) (t : ℝ) (hN : 3 ≤ N)
    (hdiv : N ∣ d) (hα : 2 ≤ α) (hαN : α < N)
    (hx : 0 < Int.fract (t * (d : ℝ)))
    (hxN : Int.fract (t * (d : ℝ)) < (N : ℝ)⁻¹) :
    circleNorm (t * (d : ℝ)) <
      circleNorm (((α : ℝ) * t + (β : ℝ) / (N : ℝ)) * (d : ℝ))
```

P and M retain positive natural speeds. Their upper-face orientation must
not be reused unchanged for negative speeds. Signed phase normalizations
below are separate algebraic adapters, not a weakening of this condition.

## Primary phase contracts and signed adapters

I inspected Renault's research paper, DOI `10.1016/j.disc.2004.06.008`, in
the linked hosted PDF. Its displayed statements agree with the manuscript:
5.1 uses weights `(1,1,1)`; 6.1 uses `(2,1,1)`; both have twenty closed
alternatives with alpha=2,...,5 and beta=1,...,5. Their alpha=1 alternatives
are strict, with beta sets `{1,2,4}` and `{1,2,3,4}` respectively. In 6.4
the input band is closed; doubling and beta=1,5 shifts have strict output,
while alpha=3,5 and beta=0,...,5 have closed output. Signed/reflected
variants retain these distinctions. These are matches of exact statement
scope, not independent proofs of the phase lemmas. See
[Renault, Lemmas 5.1-5.3 and 6.1-6.5, pp. 97-100](https://compmath.wordpress.com/wp-content/uploads/2008/08/view-obstruction_a_shorter_proof_for_6_lonely-runners.pdf#page=5).

Here is the independent adapter justification. For epsilon_j in {1,-1},
let `y_j=frac(epsilon_j*x_j)` and let w_j be the positive weight 1 or 2.
Because alpha is integral,

    alpha*y_j+w_j*beta/6
      congruent to epsilon_j*(alpha*x_j+epsilon_j*w_j*beta/6)
      modulo integers.

Periodicity and evenness of the norm transfer both strict and closed
predicates. For the reflected choice `y_j=frac(-epsilon_j*x_j)`, use
`beta'=6-beta`, obtaining strict beta sets `{2,4,5}` and `{2,3,4,5}`.
For a domain including beta=0, use the representative `(-beta) mod 6`
if reflection is desired; the ordinary signed 6.5 adapter needs no such
reflection. Fractional normalization is necessary before applying a
statement whose hypothesis explicitly requires phases in `[0,1)`.

The forward-improvement compatibility is exact. Let the distinguished
speed be divisible by 6 and an actual upper-face label have residue e=+/-1.
The shift `tau+e/6` puts that label at phase zero and preserves the
distinguished phase. In a subsequent alpha=1 alternative, its phase is
`beta/6` for e=1 or `(6-beta)/6` for e=-1. The respective strict beta sets
above put this phase in `[1/6,5/6)`, while the other three phases are
strictly inside the safe band. Hence P applies to the actual positive
speeds. For alpha>=2, the selected label is closed-safe and D applies.

If the actual upper-face label instead has residue +/-2, the 6.4 choices
keep it safe as well: alpha=2,beta=0 puts it at 4/6; alpha odd with an
integer beta gives an odd sixth; alpha=1,beta=1 or 5 puts it at 1/6 or
1/2. Thus its alpha=1 branch is below the upper endpoint, as P requires.
These phase identities validate the proposed interfaces for later assembly;
they do not discharge the earlier divisibility cases.

## Hand audit of the finite atom and mask plan

This audit concerns the 5.1 candidate family unless stated otherwise.
There are `4*5+3=23` candidate predicates per coordinate: twenty closed
predicates and three distinct strict predicates. Keeping their bits
separate is necessary; intersecting coordinate masks must select one
common candidate with its prescribed strictness.

Every boundary of `circleNorm(alpha*x+beta/6)>=1/6` or its strict variant
has the form

    x=(6*n+c-beta)/(6*alpha),  c in {1,5}.

The relevant denominator grids are U12,U18,U24,U30, plus U6 for alpha=1.
U12 is contained in U24 and U6 is contained in each remaining grid. For
`C=U18 union U24 union U30`, the identity
`Ua intersect Ub=U_gcd(a,b)` gives U6 for all pairwise and the triple
intersections. Inclusion-exclusion therefore gives

    |C|=18+24+30-3*6+6=60.

These are 60 distinct points on the circle. Splitting into the singleton
points and successive open arcs gives 120 atoms. On `[0,1)`, the last
open atom ends at 1, with no extra singleton at 1; zero is already a cut.
Wrap points also belong to these grids. On each open atom every predicate
is constant, since no relevant boundary or wrap can be crossed. The cut
itself must be evaluated separately: replacing a closed endpoint by a
midpoint would lose the distinction between strict and closed safety.

Consequently 120 representatives require `120*23=2760` rational predicate
evaluations in a future run. This is an upper bound independent of how
many distinct masks occur. The finite table and its coverage do not follow
from the partition calculation alone.

The inclusion-minimal-mask reduction is valid in the stated direction.
After quotienting equality, every realized good mask A contains an
inclusion-minimal realized mask B. For three original masks, choose
such B independently in each coordinate. A point in the intersection
of their three B masks lies in the intersection of the original masks.
Thus checking all triples of retained minimal masks is sufficient.
Discarding subsets instead would reverse the implication and be unsound.
An empty retained mask would already prevent the coverage claim.

At most `120*119=14280` ordered comparisons of distinct raw indices
determine all inclusions and equality classes; equality can be read from
inclusion in both directions. No additional candidate predicate calls
are needed for this step. At most 120 minimal masks remain. Because the
three coordinates in 5.1 have identical roles, intersections are symmetric
under permutations. The number of unordered triples with repetition is

    choose(120+2,3)=122*121*120/6=295240.

Repetitions cannot be omitted: phases and realized masks can coincide.
The raw ordered bound `120^3=1728000` is also correct. These are handwritten
combinatorial bounds, not executed comparisons or observed mask counts.

The same cuts suffice for 6.1 and 6.4, but the 23-bit count and full triple
symmetry are specific to 5.1. In 6.1 the first coordinate has a different
weight and must retain its role; its candidate family has 24 bits. In 6.4
there are 15 output candidates, and its closed input condition must be
retained, either as a domain restriction or an additional predicate.
Neither theorem is established by a successful future 5.1 table alone.

A future exact certificate needs separately proved atom coverage and
predicate constancy, a faithful table of good predicates, and a kernel proof
of every required mask intersection. No table, minimal-mask count, resource
pilot, coverage result or executable search was produced in this review.
Wall/memory/output limits must be fixed for any separately assigned run;
operation-count bounds alone are not measured runtime evidence.

## Integration disposition and remaining scope

The present four-moving-natural theorem allows repetitions and gives margin
1/5. Reindexing the four-label complement of a Fin5 label therefore supplies
M's strict 1/6 seed. This is the only seed weakening used: a stronger
available margin implies a strict weaker one. It does not replace the
actual strict-seed hypothesis in generic M.

The proposed proof order is accepted: norm/fractional-band helper, P, compact
global maximizer and orientation M, then reciprocal scalar/shift D. Their
module and proofs can be independent of six-specific masks and divisibility.
The exact compact-extremum library invocation is a later implementation
check; no pinned-library API or kernel outcome was inferred in this pass.

Gcd normalization and rescaling, divisibility/shift orbits, the two-multiples-
of-three argument, the parity branch, signed phase theorems and label
assembly remain separate obligations. In the preliminary composite-modulus
orbit argument, a nonzero residue may have orbit length
`l/gcd(l,v)` rather than l. Gcd normalization excludes the all-divisible
case; the proof must not assume nonzero residues modulo composite l are
units. The factor-five fast-speed theorem has the required closed margin
at n=4, but its hypotheses and complement reindexing must still be supplied.

Only a full five-moving-natural conclusion at 1/6 can fill d=5 in H7 and
support the stated canonical six-total bridge. H6 currently covers d<=4.
H8 additionally requires d=6 at 1/7 while retaining d=5 at 1/6. Neither
M nor a weaker-margin result for a duplicated tuple supplies that missing
stronger-margin case. All these assembly and canonical gaps remain explicit.
The unrestricted conjecture is unchanged.

## Read-only verification provenance

The author hash above was checked before review. Relevant project source
declarations were inspected at these frozen hashes:

```text
0e56cab74d30ef8b537ed4ec24503aae875bd8aadc369d26da99ba882cc3603f  LonelyRunner/PivotBoundary.lean
a135f5c41ead308a2a4250f07535bf3e32f78c88599497bf79bb632cd1e05f0a  LonelyRunner/BufferedRunnerInsertion.lean
838a3bcec806b0e9d01cd117e64e5348de58a05127a3f7bef5dbe2d879ff292f  LonelyRunner/PairSumCompleteness.lean
662d0116f13971bce85e76c503e2f3be4fdc6291ba8113aeda43957e38354ffe  LonelyRunner/FiveRunnerOrdinary.lean
dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5  LonelyRunner/FastRunnerInsertion.lean
5328a7a88d2b42f86ffc3f0f0418ca22c761219e8fa3e5822bda5a18ac286e8c  LonelyRunner/StructuredClasses.lean
0e3f10f64daf41bedebf31bb71cb6b93ffa5358615c6c30ec941b01fc97b9d57  LonelyRunner/EndpointCompleteness.lean
0705291adc53011fb72fc718a7260876512b092741442d6a6cceb4b76eb5ccf4  LonelyRunner/LowerCountSupply.lean
7eae68d2c46041b39c3e18f9a1e105c75680352f8e4b4edf65e0dd2a92becb72  LonelyRunner/BoundedRealReduction.lean
```

The existing continuity, half-unit norm, integer periodicity, evenness,
fractional-time normalization, floor-band and fast-insertion APIs have the
uses stated in the author map. Their current source was read or its frozen
bytes checked against source already read in this session. No fresh compiled
availability is claimed. The hosted nine-page research PDF identifies
Renault, Discrete Mathematics 287 (2004), pages 93-101 and the DOI above.
I used that original-paper content; no independently fetched publisher-byte
hash is asserted. Static integrity checks of this report are distinct from
the prohibited mathematical experiments.

At final assembly, the workflow validator passed again and a read-only
text comparison confirmed that the sole Lean fence matches the author's
contract fence byte for byte. Its SHA-256, including its final newline, is
`0e19594732b8f089a475172b33be6e31497bee9f3cae6b3ce9f163af5933732b`.
The author hash remained unchanged and the report had no trailing
whitespace (terminal chunk `975d16`, exit 0). These checks establish only
document integrity and workflow consistency. No mathematical executable
or Lean process was launched, and no additional artifact is retained.
