# Lower-count supply forces full bounded-relation rank

Task `/root/large_block_minimality`; assigned checkpoint
`52758d2e85ca73f7daa1b579dc55dc8dc69c193a`. Requested route:
`gpt-6-astra/xhigh`; observed model, effort, elapsed task time and usage:
null. Only this manuscript is owned. These are hand derivations awaiting
independent review, not new kernel declarations or an unrestricted LRC
result. No literature novelty is claimed.

The tested mechanism is global phase transfer from preservation of bounded
integer relations. It has a substantive positive consequence: under the
actual lower-count supply, a tuple without a strict native witness has
n-1 independent relations with a quartic coefficient bound. This also
settles the attempted descent negatively at that depth. Their common
annihilator is only the original rational line, so a fresh smaller integer
tuple cannot preserve them all. The proposed proper-half-core residual is
likewise impossible at its suggested depth. The unresolved case requires
transport that changes a bounded relation, not another compatible projection.

## 1. Exact original hypotheses and source interfaces

Let v=(v_1,...,v_n) be positive distinct integer speeds, n>=6, with

    N=n+1, alpha=1/N, beta=1/n,
    mu=max_(t in T) min_i ||v_i*t||, T=R/Z.

For the intended application assume the full `MinimalPositiveIntegerFailure`
contract: least moving count, then least sum among ALL positive distinct
same-count failures, and hence gcd(v)=1 and 0<mu<alpha. The lower-count
premise actually used for the main theorem is

    for every 1<=d<n and every d distinct positive integer speeds,
    some common real time has all norms >=1/(d+1).          (LC)

The rank conclusion will hold already under (LC) and mu<=alpha. Its proof
does not pretend that sum minimality was needed where lower count suffices.

The exact source contracts were inspected:

* `MinimalCounterexample.lean:12,18` defines all-real strict failure and
  the full minimum, including `previous_counts` and unrestricted
  same-count `sum_minimal`. `witness_of_sum_lt` at line 198 supplies a
  CLOSED alpha-witness for every positive injective lower-sum tuple.
  `exists_attained_strict_failure_margin` at line 276 supplies the same
  attained global mu for all times.
* `MinimalFailureDeletion.lean:84,130` supplies a beta seed and an open
  interval in each complete deletion-good set, and contraction using the
  same mu and sharp retained maximum. It also excludes a global maximizer
  from every deletion-good set. None of these is a simultaneous witness
  for a changed block; the proof below does not substitute those sets for
  the entire time circle.
* `exists_bhk_adjacentRatioCombination` in `BHKAdjacentPair.lean:46`,
  using `BHKAdjacentRatios.lean:20`, supplies the exact nowhere-zero
  rational combination with two opposite entries. Only this finite algebra
  is reused. The all-relations orbit-closure wrapper in
  `BHKCollisionToWitness.lean` is not invoked with a truncated premise.

The private-repair, parity-coset and same-parity pair holds were checked
at their relevant scopes. A lower-sum witness cannot be assumed to repair
the original tuple; all old multiply-bad regions and all original labels
must survive the comparison. This motivates the following whole-orbit
approximation, rather than selection of a tracked gauge or deletion seed.

## 2. A quantitative finite-relation phase lemma

Set

    epsilon=beta-alpha=1/[n*(n+1)],
    M=n*(n+1), P=2*n^2,
    E=P*(M-1)=2*n^2*(n*(n+1)-1).                            (1)

For a positive integer tuple v define

    R_E(v)={r in Z^n: |r_i|<=E for every i, sum_i r_i*v_i=0}.

**Phase lemma.** If x in T^n satisfies

    sum_i r_i*x_i=0 in T for every r in R_E(v),              (2)

then some actual common time t satisfies

    ||v_i*t-x_i||<epsilon for EVERY i.                      (3)

The condition uses the same coefficients, not only their supports. It is
imposed on all bounded relations, without a support-size restriction.
No independent choice of a time for each original label is permitted.

Here is a complete finite-kernel proof. Let

    K_M(s)=|sum_(j=0)^(M-1) exp(2*pi*i*j*s)|^2/M,
    c=integral_T K_M(s)^P ds, J=K_M^P/c.

The coefficients of K_M are `1-|j|/M` for |j|<M and zero otherwise.
They are nonnegative real numbers. Thus J also has nonnegative real
Fourier coefficients, degree E, and coefficient one at zero. J is
nonnegative and has integral one.

For an explicit normalization bound, take |s|<=1/(8*P*M) in a centered
circle lift. Every angle 2*pi*j*s has absolute value at most
pi/(4P)<1/P. The elementary inequality cos(y)>=1-y^2/2 gives

    K_M(s)>=M*(1-1/(2P^2))^2>=M*(1-1/P^2),
    K_M(s)^P>=M^P*(1-1/P)>=M^P/2.

The last step uses Bernoulli and P>=2. Integrating over the interval of
length 1/(4PM) gives

    c>=M^(P-1)/(8P).                                       (4)

The usual finite geometric sum, with sin(pi*q)>=2q for q=||s||<=1/2,
also gives K_M(s)<=1/(4M*q^2) when q>0; the global bound is K_M<=M.
Consequently

    J(s)<=8PM,
    J(s)<=8P/[4^P*M^(2P-1)*epsilon^(2P)] if ||s||>=epsilon.
                                                               (5)

Choose any real representatives of x and consider the nonnegative finite
polynomial

    F_x(t)=product_(i=1)^n J(v_i*t-x_i).

Expanding and integrating on the actual one-dimensional time circle,
only r in R_E(v) survive. By (2), the corresponding phase multiplier
`exp(-2*pi*i*sum r_i*x_i)` equals one. Every surviving coefficient is
nonnegative, and the all-zero coefficient contributes one. Hence

    integral_T F_x>=1.                                     (6)

This is not independence of the original phases. All their bounded
relations contribute, with their actual coefficients and multiplicities.

If (3) failed at every t, at least one factor would satisfy the second
bound in (5). Combining it with the peak bound for the other n-1 factors
would give, pointwise everywhere,

    F_x(t)<=(8P)^n/[4^P*M^(2P-n)*epsilon^(2P)]
           =[16*n^3*(n+1)/16^n]^n < 1.                    (7)

For the equality use M*epsilon=1 and P=2n^2. To verify the strict sign
uniformly, `2^n>=n^2` for n>=4 follows by induction from n=4 and
`2n^2>=(n+1)^2`. Thus `16^n>=n^8`, while for n>=6,
`16n^3(n+1)<=32n^4<n^8`. The right side of (7) is one fixed constant
strictly below one. Its integral contradicts (6), proving (3).

This proof treats a distance equal to epsilon as part of the excluded
region, so the resulting approximation is strict. Circle wraps, negative
original times and different real representatives of x do not alter it.
All Fourier operations are finite; no mathematical program or analytic
limit argument was used.

## 3. Rank defect gives an actual original witness

Let L_E(v) be the rational linear span of R_E(v). Since v is nonzero,

    L_E(v) subset v^perp, dim L_E(v)<=n-1.

Assume for contradiction that its dimension is at most n-2. Its rational
annihilator W then has dimension at least two and contains v. Choose
z in W not proportional to v. The ratios z_i/v_i are not constant.

Choose adjacent distinct attained ratios at labels a,b and define

    w_i=(v_a+v_b)*z_i-(z_a+z_b)*v_i.                       (8)

The same-coefficient relation compatibility is immediate: every r in
R_E(v) annihilates both v and z, hence annihilates w. The existing
adjacent-ratio algebra gives w_i!=0 for every i and w_a=-w_b. Briefly,
a zero entry would put z_i/v_i at the weighted mean
`(z_a+z_b)/(v_a+v_b)`, strictly between the two adjacent ratios. The
opposite-entry equality follows by expansion.

Choose a positive integer q clearing the denominators of w. The set of
distinct positive integers `S={|q*w_i|:1<=i<=n}` has cardinality d with
1<=d<=n-1. Applying (LC) to its injective enumeration supplies tau with

    ||tau*s||>=1/(d+1)>=1/n for every s in S.

Put t_0=q*tau. Then `||t_0*w_i||>=beta` for every ORIGINAL index i.
The factor is q, not 1/q; signs and repeated magnitudes disappear only
in supplying the smaller-count seed and are restored in all n phases.

Take x_i=t_0*w_i modulo one. Every r in R_E(v) has sum r_i*w_i=0 over
the rationals, so (2) holds. The phase lemma supplies an actual original
time t with, for every i,

    ||v_i*t|| >= ||x_i||-||v_i*t-x_i||
               > beta-epsilon=alpha.                     (9)

Thus rank defect gives a strict common native witness under (LC). It is
incompatible with the full original global bound mu<=alpha, in particular
with actual strict failure. We have proved the uniform structural result

    (LC) and mu<=alpha imply dim_Q L_E(v)=n-1.              (10)

Equivalently, such a tuple has n-1 rationally independent integer zero
relations, every coefficient bounded by the quartic E in (1). This is
generation of the relation SPACE over Q, not an assertion that the bounded
relations generate the entire integer relation lattice integrally.

Equation (9) keeps all original coordinates at one time, including points
that any proposed smaller tuple might place in multiply-bad old regions.
The closed beta seed is sufficient because (3) is strict. The one common
actual mu is used for the final contradiction, without promoting a
constrained maximum to a global one or assigning different maxima to
different blocks. The argument uses lower count rather than an unproved
same-count rational LRC hypothesis.

## 4. What this settles for block splitting and sum descent

Let D>=E and suppose a partition into b nonempty blocks splits every
D-bounded relation as in the frozen positive-block source. Then every
r in L_E(v) satisfies one separate zero equation on each block. Those
b equations are linearly independent, since their supports are disjoint
and each block contains a positive speed. Therefore

    dim L_E(v)<=n-b.

Under (10) this forces b=1. In particular, at the suggested half-block
depth

    D_half=1568*n^2*(n+1)^2-2 > E,                         (11)

the finest splitting partition is the single FULL original block. The
inequality follows directly from (1), or from
`D_half-E=2n^2(n+1)*(784(n+1)-n)+2n^2-2>0`.

Thus a proposed residual consisting of a proper >n/2 core plus an outside
complement cannot occur in this actual lower-count obstruction class at
D_half. Its hypothetical two-block mass estimate is not a route to the
remaining case. This conclusion requires no unreviewed positivity variant
at D_half: it only uses the definition of splitting and the new rank
theorem. The original quadratic positive-block theorem stays intact.
At its degree D_0=6272n^2-2, the same conclusion follows only when D_0>=E;
that comparison does not hold uniformly in n, so no universal collapse
at D_0 is asserted.

The original attempt to use full sum minimality also has a precise
obstruction. By (10), a rational w preserving every E-bounded relation
must lie in W=Q*v. If v is primitive and w is integer, write w=lambda*v
and take integer Bezout coefficients a_i with sum a_i*v_i=1. Then

    lambda=sum a_i*w_i is an integer.

Positivity makes lambda>=1; hence sum w>=sum v. No positive lower-sum
integer replacement preserving all these relations exists. If even one
positive original coordinate outside a proposed changed block is kept
fixed, lambda=1, so the replacement is exactly v, without needing
primitivity for this last conclusion.

Full `witness_of_sum_lt` remains valid for EVERY admissible lower-sum
tuple; it does not make such a tuple relation-compatible. Nor may its
closed alpha seed be substituted for the closed beta seed in (9): without
extra slack that would lose the required native margin. This is why the
successful conditional reduction uses the lower-count collision (8).
Once (10) holds, the compatible-collision direction is itself absent.

## 5. Existing reduction, scope and the first remaining inference

The adjacent-ratio construction and collision/deduplication mechanism are
existing project ingredients. `BHKCollisionToWitness.lean` transfers via
ALL integer relations and consumes its stated rational-witness premise.
For a primitive integer v, full relation preservation already confines an
integer replacement to integer multiples of v. The new work here is the
explicit finite-degree approximation (2)--(7) and the resulting quartic
rank restriction from bounded relation preservation. No incompatible
vector is fed into the existing all-relations wrapper.

The actual sharper source theorem
`primitive_sorted_largeHeight_stationary_lonelyAt` at
`FiniteHeightReduction.lean:233`, together with lower counts, already
places a primitive stationary failure inside

    max v<=H, H=C^(n-1), C=binom(n+1,2).

The remaining universal finite-family obligation is retained by
`conjecture_iff_allSharperInclusivePrimitiveFiniteFamilies` at
`FiniteFamilyEquivalence.lean:215`. No bounded-domain supply follows from
the rank theorem. These inspected source statements are not being
recompiled or replaced.

The new depth is smaller than that inclusive height cutoff for every
n>=6: E<4n^2*C, whereas
`C^(n-2)>=C^4>=n^8/16>4n^2`, so E<H. It is therefore not automatically
the trivial regime in which all primitive pair relations fit merely
because max(v)<=H. For an individual tuple with E>=max(v), however,
the primitive pair relations DO fit and already span v^perp. That case
must not be advertised as a new restriction.

Extracting height from (10) is weaker than the existing cutoff. Select
n-1 independent bounded rows and use their integer cofactor null vector.
Its coordinates are bounded by `(n-1)!*E^(n-1)` by the finite determinant
expansion; after dividing its gcd it equals v up to sign. This upper bound
exceeds H, since E>C. No height improvement or finite-count program is
proposed. The rank result's immediate use is to remove the impossible
proper-half-core and fully compatible descent branches, not to replace
the completed finite-height reduction.

Full rank itself is compatible with native goodness. The already accepted
sharp progression v=(1,...,n) has mu=alpha, and the bounded relations
`2v_1-v_2=0` and `v_1+v_j-v_(j+1)=0` for 2<=j<n are n-1 independent
relations. No new control family or claim of a strict failure is needed.
The theorem does not distinguish a strict hypothetical failure from every
sharp boundary case; its exact role is the conditional reduction (9).

The FIRST UNRESOLVED useful transport inference is now explicit: an
admissible smaller tuple must change at least one E-bounded relation,
and a proof must control that changed relation's phase at an actual
supplied witness strongly enough to transfer ALL original coordinates.
Neither complete sum minimality nor the reviewed private/parity arguments
supplies such control. Requiring preservation of all those relations is
not a merely unproved candidate condition here; (10) proves that it cannot
yield a fresh lowering in the remaining class. Simply postulating rank
defect again would restate an excluded branch, not solve it.

The next executable action is independent review of the exact phase/rank
contract and recording the two eliminated branches. No new Lean Fourier
infrastructure is warranted yet: the remaining full-rank case has no
supported relation-changing transport contract in this bounded attempt.
This is a substantive structural and strategy result, with a precise
remaining inference, rather than a claimed uniform contradiction.
Unrestricted LRC remains unresolved.

## 6. Evidence and checks

Current config, workflow, policy and focused state were read; the gate was
research/in_progress with explicit start authorization
`2026-09-05T04:12:25.208107+00:00`. Startup validation passed. The complete
minimal-counterexample and deletion modules and the actual adjacent-ratio
algebra were read; finite-height/equivalence and prior hold comparisons
were inspected at the exact scopes above. Historical mathematical control
programs were not executed. The frozen original positive-block source was
preserved throughout its independent review/publication work.

The preservation route and kernel rank deduction were developed here;
root independently identified the full-rank obstruction and a positive
collision alternative using a rational chamber vertex. The proof above
uses the already checked adjacent-ratio algebra, not that alternative.
All new kernel inequalities and constants were checked by hand. No
external theorem beyond the displayed elementary finite Fourier, linear
algebra and trigonometric inequalities is invoked.

Full owned readback, actual input hashes, final newline/whitespace and
`python3 -B scripts/validate_workflow.py` are checked at handoff; the frozen
hash is reported separately. Workflow validation checks structure, not
mathematical validity. No mathematical program, enumeration, solver,
Lean build, dependency/cache operation, new agent, external model,
Git/shared-state/memory write or other-file edit was made. Observed
runtime metadata remains null. New claims await independent review.

| Bound input | SHA-256 |
| --- | --- |
| `LonelyRunner/MinimalCounterexample.lean` | `b0c13b2212abd6bca49fe59f16b0c9d5b124e07e85226e35c14378baa1ffd539` |
| `LonelyRunner/MinimalFailureDeletion.lean` | `2c9b11be2996fec5ef56278d6df0acda3723669a30f4003be374300d4a10342c` |
| `LonelyRunner/BHKAdjacentRatios.lean` | `677c365618fc612a5ee7d3d9e9696273da2d9e775b77487d0b3e208cea9d6733` |
| `LonelyRunner/BHKAdjacentPair.lean` | `3d36d812db7ed18db8fce521b2505d5904a8387d8e315c6e7d08d9eb7dc75708` |
| `LonelyRunner/BHKCollisionToWitness.lean` | `e5175b1f55a2d73e850ffd3e5a5dab140b6e4d84f0cefd94ebf6d7663d3a0d6a` |
| `LonelyRunner/FiniteHeightReduction.lean` | `cb41059260b943411e2ab5360b84b59cd13f2ddf352c3c50a0b3715b9b9987d6` |
| `LonelyRunner/FiniteFamilyEquivalence.lean` | `475a46b9e10226f3de30628e595073a9765a8c03cb0ab071bdcc10acb6446be3` |
| `research/astra-positive-block-transport.md` | `ced2c8cfac1bcc529e73a5ee8eef4af3595d30ebfa7db49273aa3ebd6f39f232` |
| `research/astra-uniform-global-transport-strategy.md` | `c6d433ea553cc5507a0faa97387fba75108d15bece45ac14489c879c2078d618` |
| `research/astra-private-repair-review.md` | `a8aaec8468969723207dc12e9ff2c112a4560c1f51e97f13b43f4e342c849512` |
| `research/astra-same-parity-pair-descent.md` | `9ccb99d3ef297b5e1e3bb1f0dd6bc20234ff895ebcbe40d362098aaf72903a35` |
| `research/astra-parity-coset-minimum-review.md` | `fda600dd2cdbf2f470bc18e24baeab0bb4b9a90616f34b10d160ba3fa86b3360` |
| `research/astra-affine-finite-height-audit.md` | `6b676a05eb3a0036cd69e779150a5f1a868024d089ea75c142daeddccede938f` |
| `research/astra-affine-finite-height-review.md` | `eb0fb96e22096175fa3b68dc70a1b7981f39356aaf1377863dcaa95b6a510876` |
| `.codex/config.toml` | `28212a53cf42cdc377df1f7dab040732d657e59d7bb97ee78791256d01d4bb2c` |
| `docs/project-workflow.md` | `2b42a133352b6b53ba2106fc73882733f176e04a0deffbb183b4c16eefd9cd67` |
| `research/workflow-policy.json` | `833c397b61d1ffdb994fb115019f6d60d6c1a62ff85f19cdd2c9f8ac3a979c8b` |
| `scripts/validate_workflow.py` | `250a3ce2a080f5835ac4fd2e4b2803568424c777cda5d421f9fe92efd34d5383` |
