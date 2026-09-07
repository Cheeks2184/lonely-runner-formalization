# Independent review: minimal-failure deletion adapter

Accepted without corrections. The complete frozen manuscript, its definition
and all three proposed signatures have been independently checked. Their
derivations preserve the original minimal-failure family and produce one shared
actual margin, positive deletion intervals, strictly positive contracted radii,
and exclusion of every maximizing real time. This is contract acceptance for
implementation; these new declarations have not been elaborated in this review.

Task: `/root/minimal_failure_deletion_contract_review`. Assigned checkpoint:
`7147fd8d9d12bfb3599f931a117f8e27d84f24af`. Requested route: existing in-session
`gpt-6-astra`, `xhigh`. Observed model, effort, elapsed time and usage: `null`.
Only this review is owned; the author and all other files remain unchanged.

## Exact interfaces and deletion count

The proposed ordinary definition

`retainedMaxSpeed v i = ((Finset.univ : Finset (Fin n)).erase i).sup v`

is the natural supremum over exactly the retained indices. The empty supremum
is zero. The definition needs no positivity hypothesis; all divisions in the
proposed theorems occur only after proving that this supremum is positive.
There is no change of the original speed tuple, normalization or sorting.

The first theorem assumes `hv : MinimalPositiveIntegerFailure v` and concludes
`2<=n`. Its `count_pos` excludes zero. For `n=1`, `oneMovingRunner` at the
positive speed `v 0` gives a closed `1/2` witness. Every `Fin 1` index is zero,
so this contradicts the full failure predicate at native margin
`1/(1+1)=1/2`. No inductive or higher-count theorem is needed.

For the seed theorem, write `n=d+1` with `d>=1` within the proof, and restrict
to `old j = v (i.succAbove j)` on `Fin d`. Injectivity follows by composing
the two injections; positivity is inherited. The stored previous-count result
applies at `d<n`, giving a single time `s` with all old norms at least
`1/(d+1)=1/n`. The exact enumeration lemma supplies a preimage for every
original `j!=i`, so the same `s` works for all retained original labels.
This does not replace `1/n` by `1/(n-1)` or silently change `Fin` domains.
The theorem returns its statements about the original `Fin n` family.

Let `Q_i=retainedMaxSpeed v i`. Every retained speed is at most `Q_i` by
membership in the erased finite set and `Finset.le_sup`. A retained index
exists because `d>=1`; for instance `i.succAbove 0` is not `i`. Its positive
speed gives `Q_i>0`. `Finset.sup_le` verifies the least-upper-bound property.
Thus this is the sharp retained maximum, not a bound that also includes the
target. The source examples for `sup`, `succAbove` injectivity, exclusion and
enumeration were read at their actual types; no new finite-cardinality theorem
is needed for these claims.

## Exact interval and shared quantifiers

Put `alpha=1/(n+1)`, `beta=1/n`, `Q=(Q_i:Real)`, and
`epsilon=(beta-alpha)/Q`. Since `n>=2`, `beta>alpha` and `Q>0`, so
`epsilon>0`. For every real `t` in the displayed open interval around `s`,
`|t-s|<epsilon`. Natural-speed Lipschitzness gives, for every retained label,

`||v_j*t|| >= ||v_j*s||-v_j*|t-s|`

`             >= beta-Q*|t-s| > beta-Q*epsilon = alpha`.

This proves the signature's closed-safe subset claim and, in fact, strict
retained safety on the whole open interval. The seed may attain `beta` exactly.
The interval contains `s` and has positive radius; it certifies nonempty
interior of the full deletion set without a separate interior structure.
No assertion of strict safety at the interval's endpoints or restriction of
the interval to `[0,1]` is used. This verifies every clause of
`deletion_seed_interval`: positive real `Q`, positive exact `epsilon`, the
closed beta-seed, and the precise open-interval inclusion.

The third signature fixes the caller's anchor, defines `F` as its full finite
minimum, and places `exists mu tau` before all target indices. Invoke
`exists_attained_strict_failure_margin` once with that anchor and the positivity
and failure fields of the same `hv`. It returns `tau in [0,1]`,
`0<mu<alpha`, `F(tau)=mu`, and `F(t)<=mu` for every real `t`.
Neither the original minimal tuple nor `mu` is selected anew for each deletion.
The seed times are allowed to depend on the target index.

For every `i`, the sharp positive real cast of `Q_i`, the target's positivity,
the retained-speed bounds, `mu<alpha<=1/2`, and that same all-real bound match
the exported `strict_core_bound_of_global_minimum` arguments exactly. The result
is the full closed-safe, all-time inequality

`||v_i*t|| + v_i*(alpha-mu)/Q_i <= mu`.

The generic theorem is now compiled at the bound source digest and has an
accepted final review. The author's references to its implementation being
pending describe the earlier assignment stage, not an additional mathematical
premise. The adapter can reuse that actual exported theorem directly.

## Strict radius and exclusion of all maximizers

Write `m=v_i>0`, `delta=(alpha-mu)/Q_i>0`, and `R_i=mu/m-delta`.
A safe point alone gives only `R_i>=0`. The proposed proof correctly supplies
a safe point with positive target norm using the entire seed interval.
If its center already has positive norm, use it. Otherwise norm nonnegativity
and the exact round formula give `m*s=z` for the integer `z=round(m*s)`.
Set `h=min(epsilon,1/(2*m))/2`. Both entries of the minimum are positive,
so `0<h<epsilon` and `0<m*h<=1/4<1/2`. Hence `s+h` is inside the safe
interval, and periodicity plus the half-interval formula give
`||m*(s+h)||=||z+m*h||=m*h>0`.

In either case contraction at a safe point with norm `q>0` yields
`R_i >= q/m > 0`. The proof preserves the signature's **strict** radius
positivity. It assumes neither nonzero target norm at every safe point nor
interior of every individual collision portion. Integer translations, negative
seeds and shifts through an integer time are all covered by the real-time domain.

The final clause quantifies over every real `t` satisfying `F(t)=mu`, followed
by every target `i`. The compiled
`not_complementSafe_of_global_maximum` has exactly these arguments with the
same `v`, anchor, `alpha`, `mu`, and positive `Q_i`. Equivalently, hypothetical
safety would give target norm strictly below `mu` because contraction adds a
positive term, whereas `minimumCircleNorm_le` gives target norm at least
`F(t)=mu`. Thus every global maximizing time is excluded, not merely the chosen
attainer `tau`. No equality between two coordinate norms is asserted.

The third signature therefore retains all its clauses: actual attained margin,
all-real upper bound, positive natural retained maximum and strictly positive
radius for each target, contraction on every full deletion-safe time, and the
universal maximizer exclusion. There is no hidden added hypothesis or replacement
of strict radius positivity by a weak inequality.

## Additional consequences, control and remaining scope

The brief beta-width observation is valid. At the same deletion seed, apply
generic contraction with width `beta<=1/2`; `mu<alpha<beta` supplies its gap.
Dropping the nonnegative target norm gives
`v_i/Q_i <= mu/(beta-mu)`. With positive denominator, the strict comparison
`mu/(1/n-mu)<n` is exactly `(n+1)*mu<1`, supplied by `mu<alpha`.
This yields a ratio restriction only. It is not a contradiction, new wrapper,
or replacement for the proposed interval proof.

The control correctly separates nonempty deletion sets from interiors. For
`(1,2)`, actual maximum `1/3`, target `2`, and separate working width `1/2`,
the retained speed `1` is safe exactly at `t=1/2 mod 1`. Thus `Q=1`, target
norm is zero and contraction is equality, with radius
`(1/3)/2-(1/2-1/3)=0`. The full real safe set is discrete; modulo one it is
a singleton. This is an LRC-good tuple at native width `1/3`, and does not
falsify the adapter's native-width positive-interval conclusion. No counterexample
was found to any exact proposed signature.

The remaining formal work is bounded assembly and checking of these unchanged
declarations. Starting from `not Conjecture`, the existing selection theorem
supplies one `n,v,hv`, to which all three would apply. The first unresolved
uniform mathematical implication remains a contradiction or a valid common-time
selection/descent argument under this full minimal-failure hypothesis. The
adapter alone supplies neither that implication nor a resolution of LRC.

## Checks and frozen bindings

The entire author and all fifteen author input bindings were checked. Existing
normal-form and contraction evidence was reused with current hash verification;
the newly invoked `sup` and deletion API source passages and the exported
contraction/corollary signatures were read. No mathematical program or Lean
execution was performed. Current configuration, workflow, policy and focused
active state were read; research is authorized and remains in progress.
`python3 -B scripts/validate_workflow.py` passed at startup and handoff.
Full review readback, all nineteen direct bindings below, and author/review
whitespace and final-newline checks passed. These checks are administrative,
not a claim that the new adapter has been kernel checked. No other file, Git,
shared state, memory, build or cache was changed; no new agent was launched.

| Input | SHA-256 |
| --- | --- |
| `research/astra-minimal-failure-deletion-contract.md` | `76bdf41ee81543c9251f3f5c3236082c20a0d62afd81d854a0f44be5227ba880` |
| `LonelyRunner/MinimalCounterexample.lean` | `b0c13b2212abd6bca49fe59f16b0c9d5b124e07e85226e35c14378baa1ffd539` |
| `research/astra-minimal-counterexample-final-review.md` | `ea2ecd4b04cf2f5db060be84087619bdc9b6712ed2c8fd508bbe48fdc1a7ddbf` |
| `LonelyRunner/StrictCoreContraction.lean` | `b26dbff907c02e5874dbf635fdd5f9406e7d080045238818090d6b7149c91daf` |
| `research/astra-strict-core-final-review.md` | `1fcb97cf90eeacc4d4d5765d1310e255fb146efa4f7e2fd01827a3aac3b62834` |
| `research/astra-strict-core-kernel-contract.md` | `2e531b5a040bdd4d48c6a4f2237c27d485b6f08ffb6ac83841da936cb643de8c` |
| `research/astra-strict-core-kernel-contract-review.md` | `f9b8bf75a66df74e1b8d95fd957d4f8dab145dd0fbc36d825ba23bb2e13ea75e` |
| `LonelyRunner/BaseCases.lean` | `31e2c328e060c077c6c9928e3fb431601326e4e54a949ee5148aed5cd3687d1f` |
| `LonelyRunner/StationaryEquivalence.lean` | `12dce8930c34b211bc01e2dc21e932087270726bce2bf127fa2d8d6594544b49` |
| `LonelyRunner/OneSixthComplementMaximizer.lean` | `5a7011ca680b8a2b26c7bad466a8ee4008cf47507eb8b700846f296894bb90a1` |
| `LonelyRunner/ConstrainedMaximizer.lean` | `2ef07e6b83b8675a22184571c31d2a71dab9d5c072e3cd165cb8382957b46e92` |
| `LonelyRunner/PivotBoundary.lean` | `0e56cab74d30ef8b537ed4ec24503aae875bd8aadc369d26da99ba882cc3603f` |
| `LonelyRunner/FastRunnerInsertion.lean` | `dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5` |
| `LonelyRunner/FiniteFamilyEquivalence.lean` | `475a46b9e10226f3de30628e595073a9765a8c03cb0ab071bdcc10acb6446be3` |
| `LonelyRunner/SoftFeedbackLayers.lean` | `723a97470b0514ddcf23594f04dfe938a4c4deb862046d700383429540abbf14` |
| `.codex/config.toml` | `28212a53cf42cdc377df1f7dab040732d657e59d7bb97ee78791256d01d4bb2c` |
| `docs/project-workflow.md` | `2b42a133352b6b53ba2106fc73882733f176e04a0deffbb183b4c16eefd9cd67` |
| `research/workflow-policy.json` | `833c397b61d1ffdb994fb115019f6d60d6c1a62ff85f19cdd2c9f8ac3a979c8b` |
| `scripts/validate_workflow.py` | `250a3ce2a080f5835ac4fd2e4b2803568424c777cda5d421f9fe92efd34d5383` |
