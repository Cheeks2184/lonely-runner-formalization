# Independent review: minimal positive-integer failure contract

Task `/root/minimal_failure_kernel_contract_review`; assigned checkpoint
`598f969732186d9ee39641d343d5e79ddeb1eb77`. Requested route:
`gpt-6-astra` / `xhigh`, the existing in-session independent review route.
Observed model, effort, elapsed time and usage: null. This review is the
sole owned file; root owns state, implementation assignment and publication.

**Accepted without correction** as a mathematical and proposed Lean contract,
for manuscript SHA-256
`17067b1cfc7ebc5d473769fa03821eb7a203cfc53bc8936d95653d71cf253de8`.
The hypotheses are sufficient, both selections and the normalization are
noncircular, and the analytic addition gives an attained positive ACTUAL
global margin. No structural error was found in the proposed public types
against the named source declarations. The signatures and proof plan have
not been elaborated or kernel-checked here. Their implementation remains
outstanding, and their conclusion is conditional on failure of LRC.

## Predicate, canonical bridge and public types

For v : Fin n -> Nat, write alpha=((n+1 : Nat) : Real)^(-1). The proposed
failure predicate is

    forall t : Real, exists i : Fin n, circleNorm(t*v_i)<alpha.

Classical quantifier negation and the real-order equivalence
not(alpha<=x) iff x<alpha identify this EXACTLY with

    not exists t : Real, forall i : Fin n, alpha<=circleNorm(t*v_i).

The strict inequality belongs in failure, while equality belongs in a
closed witness. This logical helper does not need positive or injective
speeds, or an inhabited index type. At n=0 the existential coordinate
predicate is false, while a closed witness is vacuously available at every
time, so both sides of the proposed equivalence are false.

I read the actual canonical definition: `Conjecture` quantifies over all
total counts at least two, injective REAL speeds and every chosen runner,
at all real times, with closed distance threshold. `circleNorm` in
`FastRunnerInsertion.lean` is the norm of the phase in the same unit
`AddCircle 1`, not a different distance convention. `PositiveIntegerConjecture`
and `PositiveIntegerAtCount` use n positive injective NATURAL moving speeds
and the native total-count threshold 1/(n+1). Their displayed witness
formulas agree after unfolding `circleNorm`.

The actual source theorem `conjecture_iff_positiveIntegerConjecture` in
`BHKRealReduction.lean` has no hypothesis such as a finite-family theorem
or LRC itself. Its proof composes the existing exact stationary and
rational/integer equivalences. Thus applying its reverse implication
contrapositively to `not Conjecture` supplies failure of the all-count
positive-integer formulation. The finite-family induction elsewhere in
`FiniteFamilyEquivalence.lean` DOES have a finite-family premise; that
theorem is not used in this selection argument.

The proposed structure is proposition-valued, and all its fields are
propositions. Its external parameter v retains the entire Fin n index
type. `count_pos` provides nonemptiness; `positive` and `injective` are
explicit; `previous_counts` stores each smaller positive count at its
OWN native threshold. The sum-minimality field quantifies over ALL
positive injective same-count failures. It imposes no primitivity or
sorting restriction on competitors. The minimality direction is correctly
sum(v)<=sum(w). The final gcd-one field is a consequence to be constructed,
not a premise of that minimization.

All public thresholds explicitly cast the NATURAL total count to Real
before inverse. The proposed theorem signatures preserve their hypotheses,
index types and real-time domains. `Finset.univ.gcd v` has the same form
as the current natural normalization source. A namespace method named
`MinimalPositiveIntegerFailure.witness_of_sum_lt` can use the structure
proof as its receiver without introducing a new assumption. These are
source-level type checks; the displayed signatures are intentionally not
complete theorem implementations.

## The two minima and exact gcd division

From failure of the all-count formulation, classical negation gives

    exists d : Nat, 1<=d and not PositiveIntegerAtCount d.

Minimize this inhabited predicate on NATURAL NUMBERS. Its minimum n has
1<=n and a failed count statement. If 1<=d<n, a failed statement at d
would violate leastness, so `PositiveIntegerAtCount d` holds. This proves
exactly `previous_counts`, with no appeal to a conjectural uniform theorem.

Negating the failed count statement at n gives a positive injective tuple
with no closed witness, hence with the strict failure predicate. Minimize
the inhabited natural predicate

    Q(s): exists w : Fin n -> Nat,
      Injective(w) and (forall i, 0<w_i) and Failure(w)
      and sum(w)=s.

Selecting a realizer of its least value s0 gives a tuple v with sum(v)=s0.
Every admissible failing competitor w witnesses Q(sum(w)); leastness gives
s0<=sum(w), which is precisely the public sum-minimality field. Both
minima are taken over Nat. No well-order on functions, decidability of
failure, finite search, or height bound is assumed. Classical decidability
and choice may be used inside the proof; they do not turn it into an
algorithm for locating a failure.

To prove primitivity, use 1<=n to choose an anchor in Fin n and define

    g=Finset.univ.gcd v, w_i=v_i/g.

The named gcd source supplies g|v_i. A positive coordinate at the anchor
ensures g!=0 through `Finset.gcd_ne_zero_iff`, hence g>0. Exact division
then gives v_i=g*w_i for every i. The quotient is positive: g|v_i and
v_i>0 imply g<=v_i, and division by positive g has positive quotient.
This is exactly the `Nat.div_pos` proof pattern shown in the existing
natural normalization source. Equality w_i=w_j implies equality v_i=v_j
by factorization, and original injectivity then gives i=j. All labels and
the moving count are preserved.

The proposed scaling helper has the correct directions. For arbitrary
real time t and g>0,

    (t/g)*(v_i:Real)=t*(w_i:Real),
    ((g:Real)*t)*(w_i:Real)=t*(v_i:Real).

Failure of v at t/g therefore proves failure of w at t. Failure of w at
g*t proves failure of v at t. The phases are exactly equal after casting
the natural factorization, with the SAME index type and threshold. Neither
positivity nor injectivity of the tuples is needed for this helper; g>0
is sufficient for the inverse time change. The analogous fixed-Fin-5
source restores a quotient witness at t/g, confirming the time direction
without using that source's finite-count theorem as a uniform premise.

If g>1, positivity of every w_i gives w_i<g*w_i=v_i at every coordinate.
The nonempty finite sum is strictly smaller. The scaling helper makes w
a failure at the same native count, so the already established minimality
gives the contradictory inequality sum(v)<=sum(w). Thus g=1. The proof
has not assumed the selected tuple's primitive field or the quotient's
gcd. Computing that quotient gcd is unnecessary because the minimum was
taken among ALL admissible failures, including nonprimitive ones.

For the smaller-sum witness theorem, suppose a positive injective
same-count w with sum(w)<sum(v) had no closed witness. The first logical
helper gives Failure(w), contradicting minimality. Classical negation
therefore yields the promised real time with every norm at least alpha.
This covers arbitrary admissible same-count competitors, not only one-slot
replacements. A duplicated retained label fails the stated injectivity
premise and needs separate deletion/reindexing reasoning. There is no
hidden duplicate exception or primitive-only competitor restriction.

## The attained actual global margin

The separate analytic theorem assumes only an explicit anchor : Fin n,
positive natural speeds, and the strict failure predicate. It does not
need minimality, distinctness, primitivity or a lower-count witness. The
anchor supplies exactly the nonempty finite index set required by the
existing `minimumCircleNorm` definition.

Let S=sum_i v_i. Positivity at the anchor gives S>=1, and every coordinate
satisfies 1<=v_i<=S. For t0=1/(2*(S:Real)),

    0<t0<=1/2,
    t0<=t0*(v_i:Real)<=1/2.

The existing closed half-interval formula for circle norm therefore gives
circleNorm(t0*v_i)=t0*v_i>=t0. Applying `le_minimumCircleNorm` yields
F(t0)>=t0>0, where F is the finite minimum in the proposed contract.
In particular t0 belongs to [0,1]. This lower bound uses the actual speed
sum and has no claim to equal the native Lonely Runner threshold.

The actual definition in `PivotBoundary.lean` is a nonempty Finset infimum
over ALL coordinates. The source provides its continuity, both comparison
directions, and an attained minimizing coordinate. Continuity and compact
nonemptiness of [0,1] provide tau in that interval with F(t)<=F(tau) for
every t there. Set mu=F(tau). The positive time gives mu>=F(t0)>0.

For arbitrary real t, including negative t, `Int.fract t` lies in [0,1).
The actual source identity `circleNorm_fract_mul_nat` states

    circleNorm(Int.fract(t)*v_i)=circleNorm(t*v_i)

for every natural speed. Its proof uses the integer floor-times-speed
phase difference. Equality of all coordinate values gives equality of the
same finite minimum at t and Int.fract(t). Thus the compact maximum bounds
F at EVERY real time. Combined with F(tau)=mu, this makes mu the actual
global maximum, not merely an upper bound or a constrained coordinate
objective.

Finally Failure(v) applied AT tau supplies a coordinate with norm below
alpha. The source inequality `minimumCircleNorm_le` gives
mu=F(tau)<=that norm<alpha. This obtains the strict upper bound from
attainment. Taking a supremum of pointwise strict inequalities without
an attainer would not justify it. The public contract needs only
tau in the closed interval, and does not assert uniqueness or rationality
of the attainer.

The downstream deletion observation is also exact. The existing
`ComplementSafe v i alpha t` means that every j!=i has norm at least
alpha. Choose a coordinate attaining the finite minimum at t, using
`exists_eq_minimumCircleNorm`. Its value is F(t)<=mu<alpha, so it cannot
be a retained coordinate j!=i. Hence it is i, proving

    circleNorm(t*v_i)=F(t)<=mu.

This holds on the WHOLE deletion-safe set, including closed boundaries.
It uses the global minimum objective; the distinguished-coordinate
constrained maximum from `ConstrainedMaximizer.lean` cannot substitute
for it. The author correctly leaves this downstream lemma outside the
required initial module interface.

## Source reuse, implementation limits and falsification status

The proposed direct imports expose the relevant existing declarations:
`FiniteFamilyEquivalence` supplies the count proposition and canonical
equivalence import chain; `PivotBoundary` supplies the finite minimum and
integer-speed fractional-part identity; the explicit finite-gcd module
matches current normalization usage. The separate labelled transport
theorem is valid but unnecessary for the direct stationary factorization.
The finite-family induction, sorted zero-appended normalization and
fixed-count divisibility theorem are not silently treated as unconditioned
uniform inputs.

`LowerCountPositiveIntegerHypothesis (n+1)` has the same native smaller-
count quantifiers as `previous_counts`. The existing adapter additionally
asks for 2<=n. The source count-one theorem excludes n=1, so this extra
bound can be proved afterward, or the bounded supply can be assembled
directly. The source H_7 covers moving counts through five and can later
exclude n<=5. Neither finite-case corollary is required to construct the
uniform normal form or its positive margin.

I found no missing mathematical assumption or circularity. The actual
source confirms the cited gcd, positive quotient, strict finite-sum,
single-summand comparison, finite-minimum and compactness proof patterns.
The proposed `Nat.find` import and precise argument forms, and the final
assembly/elaboration of the new declarations, remain implementation work.
No Lean execution or transitive trust audit was performed in this review;
source inspection cannot certify their eventual compiled bodies or axioms.
No historical successful build is substituted for a focused check of the
new module.

The stated falsification checks pass by hand. At n=0 the failure predicate
is false and the analytic theorem has no possible anchor. For one speed
1, the closed antipodal time 1/2 is good; changing failure to a weak bad
inequality would wrongly classify it as a failure. Scaling (1,2) to
(2,4) takes the quotient witness 1/3 to the original witness 1/6, as the
inverse time change requires. A tuple with a zero coordinate would invalidate
the positive-margin conclusion, and is excluded explicitly by hpos.

The mathematical proof plan is complete for the advertised conditional
normal form and analytic addition. Implementation, focused compilation,
axiom inspection and final code review remain outstanding. Even after
those checks, the first unresolved LRC implication is to contradict the
resulting minimal failure or construct an actual failure. The normal form
itself does neither and is not unrestricted LRC resolution.

## Bound sources and actual checks

I fully read the frozen manuscript and the cited canonical/count/minimum
definitions and relevant proof bodies. The normalization, metric,
constrained-maximizer, lower-count, base-case, finite-sum and transport
source passages used above were read directly. The declared toolchain and
manifest were read: Lean v4.32.1 and mathlib revision
`520045ab14e26149ee970e2e617ca04b09bde5d6`. These are pinned-source facts,
not runtime or compilation receipts. All twenty-three current bindings
below include the manuscript and its twenty-two inspected inputs.

| Bound source | SHA-256 |
| --- | --- |
| `research/astra-minimal-failure-kernel-contract.md` | `17067b1cfc7ebc5d473769fa03821eb7a203cfc53bc8936d95653d71cf253de8` |
| `LonelyRunner/Definitions.lean` | `5f0258a6ab99950fc7045b2200d6708fe7603d3caa4d62855ef2b19a330c95aa` |
| `LonelyRunner/Formulations.lean` | `0c3328e975bee236ff66862d3a5cadeb58fbc7c804fa953e53701ba466b9d788` |
| `LonelyRunner/BHKRealReduction.lean` | `98d7c878eef7e4a3b7f7c504c882cf35191c1343816a59d731193ac8a207ed26` |
| `LonelyRunner/FiniteFamilyEquivalence.lean` | `475a46b9e10226f3de30628e595073a9765a8c03cb0ab071bdcc10acb6446be3` |
| `LonelyRunner/PrimitiveTupleNormalization.lean` | `cac3351bf8c755c0bd354d0330e766f49c255d7ef21637d0975a8d8633cd94b0` |
| `LonelyRunner/TwoDivisibleNormalization.lean` | `d812237f06d63e67c8739122c76a5e67daa470402575ccafcdcee4c41d950286` |
| `LonelyRunner/FastRunnerInsertion.lean` | `dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5` |
| `LonelyRunner/PivotBoundary.lean` | `0e56cab74d30ef8b537ed4ec24503aae875bd8aadc369d26da99ba882cc3603f` |
| `LonelyRunner/ConstrainedMaximizer.lean` | `2ef07e6b83b8675a22184571c31d2a71dab9d5c072e3cd165cb8382957b46e92` |
| `LonelyRunner/LowerCountSupply.lean` | `0705291adc53011fb72fc718a7260876512b092741442d6a6cceb4b76eb5ccf4` |
| `LonelyRunner/BaseCases.lean` | `31e2c328e060c077c6c9928e3fb431601326e4e54a949ee5148aed5cd3687d1f` |
| `LonelyRunner/SixRunnerOrdinary.lean` | `8da5bb6f35373ab4da8d0ab8e2a1040376a74b028efdc7e00d006ee91eb25755` |
| `LonelyRunner/LonelyAtTransport.lean` | `6596481a6087174f7f7bb7d5140e339d0a571b05bc369fd3a9f0c432875ee1ee` |
| `LonelyRunner/WeightedConditionalExpectation.lean` | `72745fdfb1d779d9956b9bd0e515b1b3a971ddebe4c217db862fddffa6dcfe8b` |
| `LonelyRunner/OverlapCapacity.lean` | `2048568e30b8754b5a6d2807860105e957b8c2b353daa0ec6c72d8c895ca8ca6` |
| `lean-toolchain` | `8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af` |
| `lakefile.toml` | `bdcbaaa18d518409619215e8acf7892452c1fa5c6e80ba742ce67f7380682a26` |
| `lake-manifest.json` | `887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218` |
| `.codex/config.toml` | `28212a53cf42cdc377df1f7dab040732d657e59d7bb97ee78791256d01d4bb2c` |
| `docs/project-workflow.md` | `2b42a133352b6b53ba2106fc73882733f176e04a0deffbb183b4c16eefd9cd67` |
| `research/workflow-policy.json` | `833c397b61d1ffdb994fb115019f6d60d6c1a62ff85f19cdd2c9f8ac3a979c8b` |
| `scripts/validate_workflow.py` | `250a3ce2a080f5835ac4fd2e4b2803568424c777cda5d421f9fe92efd34d5383` |

Current config, workflow, policy and focused active state were read. The
gate was research / in_progress with explicit start authorization
`2026-09-05T04:12:25.208107+00:00` and this sole owned review path.
`python3 -B scripts/validate_workflow.py` exited 0 with
`workflow structural validation passed; it cannot certify mathematical validity.`
An initially truncated combined manuscript output was replaced by a full
untruncated read before review. File hashes used administrative Python
SHA-256 checks; all twenty-two author bindings matched. Final full review
readback, current-source binding, newline/whitespace and workflow checks,
and the frozen review hash are reported at handoff. No Lean file or author
edit, Lean execution, build, cache/dependency operation, mathematical program,
additional agent, external model, Git/shared-state/memory write or other-file
edit was performed. The author's historical cache-absence receipt is not
being promoted to a current cache or runtime claim.
