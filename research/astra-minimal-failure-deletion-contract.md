# Minimal failure: deletion interiors and one common global margin

Task `/root/minimal_failure_deletion_contract`; checkpoint
`7147fd8d9d12bfb3599f931a117f8e27d84f24af`. Requested route Astra/xhigh;
observed model, effort, elapsed time and usage: null. Only this manuscript
is owned. These are proposed signatures and hand proofs, not new Lean code
or a compiled adapter. Independent review remains required.

One small assembly module can connect the existing minimal-failure normal
form to all deletion sets. Use the sharp maximum retained speed, obtain
a lower-count seed and an explicit interval for every deletion, choose
ONE attained global margin with ONE anchor, and specialize the accepted
contraction. Each contracted radius is strictly positive because the full
deletion set has interior. Every global maximizing time lies outside every
deletion set. This does not supply the missing uniform contradiction.

## Smallest proposed interface

Propose `LonelyRunner/MinimalFailureDeletion.lean`, importing
`LonelyRunner.MinimalCounterexample`, the separately implemented
`LonelyRunner.StrictCoreContraction`, and the existing base case as needed.
No new structure is needed: preserve `MinimalPositiveIntegerFailure v`.
Use one ordinary definition for the sharp retained maximum and three public
theorems. The auxiliary maximum and interval arithmetic can remain private.

```lean
def retainedMaxSpeed {n : ℕ} (v : Fin n → ℕ) (i : Fin n) : ℕ :=
  ((Finset.univ : Finset (Fin n)).erase i).sup v

theorem MinimalPositiveIntegerFailure.two_le_count
    {n : ℕ} {v : Fin n → ℕ} (hv : MinimalPositiveIntegerFailure v) :
    2 ≤ n

theorem MinimalPositiveIntegerFailure.deletion_seed_interval
    {n : ℕ} {v : Fin n → ℕ} (hv : MinimalPositiveIntegerFailure v)
    (i : Fin n) :
    let alpha : ℝ := (((n + 1 : ℕ) : ℝ)⁻¹)
    let Q : ℝ := (retainedMaxSpeed v i : ℝ)
    let epsilon : ℝ := ((n : ℝ)⁻¹ - alpha) / Q
    0 < Q ∧ 0 < epsilon ∧ ∃ s : ℝ,
      (∀ j : Fin n, j ≠ i →
        (n : ℝ)⁻¹ ≤ circleNorm (s * (v j : ℝ))) ∧
      Set.Ioo (s - epsilon) (s + epsilon) ⊆
        {t : ℝ | ComplementSafe v i alpha t}

theorem MinimalPositiveIntegerFailure.exists_common_deletion_margin
    {n : ℕ} {v : Fin n → ℕ} (hv : MinimalPositiveIntegerFailure v)
    (anchor : Fin n) :
    let alpha : ℝ := (((n + 1 : ℕ) : ℝ)⁻¹)
    let F : ℝ → ℝ := minimumCircleNorm (fun i => (v i : ℝ)) anchor
    ∃ mu tau : ℝ,
      tau ∈ Set.Icc (0 : ℝ) 1 ∧
      0 < mu ∧ mu < alpha ∧ F tau = mu ∧
      (∀ t : ℝ, F t ≤ mu) ∧
      (∀ i : Fin n,
        0 < retainedMaxSpeed v i ∧
        0 < mu / (v i : ℝ) -
          (alpha - mu) / (retainedMaxSpeed v i : ℝ) ∧
        ∀ t : ℝ, ComplementSafe v i alpha t →
          circleNorm (t * (v i : ℝ)) +
            (v i : ℝ) * (alpha - mu) /
              (retainedMaxSpeed v i : ℝ) ≤ mu) ∧
      (∀ t : ℝ, F t = mu →
        ∀ i : Fin n, ¬ ComplementSafe v i alpha t)
```

These signatures are proposed inside `namespace LonelyRunner`. The seed
theorem's explicit positive open interval is a certificate that
`interior {t : ℝ | ComplementSafe v i alpha t}` is nonempty: the interval
is open, contains its center, and is contained in that set. There is no
need for a second interior-data structure or a wrapper duplicating this
certificate. The proof below actually keeps the retained norms strictly
above alpha throughout the displayed open interval.

The common-margin theorem quantifies `mu,tau` BEFORE every target index;
the same `F`, anchor and actual global maximum serve all deletions.
Its final clause excludes EVERY maximizing real time, not just `tau`.
The lower-count seed times may differ across target indices, as they must
be allowed to do. The interval and common-margin theorems use the SAME
original tuple and the SAME existing minimal-failure hypothesis.

`retainedMaxSpeed` is a finite supremum in the natural numbers. It is the
exact retained maximum when the complement is nonempty, not an unspecified
larger speed bound. Its definition also exists for an empty complement,
where it is zero; the new theorems exclude that case before any division.
No speed sorting, normalization, relabelling of the selected tuple, or
change of its moving count is part of this interface.

## Count, deletion reindexing and finite continuity

**Exclude one moving speed.** The stored `count_pos` rules out `n=0`.
If `n=1`, positivity of `v 0` allows the existing `oneMovingRunner` theorem
to supply a time with norm at least `1/2`. Every `j : Fin 1` equals zero,
so this is a full closed native witness, contradicting `hv.failure` (or
its no-witness equivalence). Therefore `2≤n`. The threshold here is total
count TWO: `((1+1:ℕ):ℝ)⁻¹=1/2`. The proof uses no higher-count result.

**Delete exactly one label.** For this proof only, express `n=d+1`, with
`1≤d`. The selected tuple has type `Fin (d+1) → ℕ`. For each target
`i : Fin (d+1)` put

    old : Fin d → ℕ := fun j => v (i.succAbove j).

The map `i.succAbove` is injective and enumerates exactly the original
labels other than `i`. Compose its injectivity with `hv.injective`;
restrict `hv.positive` to obtain positivity of `old`. Apply

    hv.previous_counts d (1≤d) (d<d+1)

to this positive injective tuple. Its native margin is
`1/(d+1)=1/n`, which will be called beta. It is NOT `1/d` and not the
original native `alpha=1/(d+2)=1/(n+1)`. For each original `j≠i`,
`Fin.exists_succAbove_eq` supplies the actual preimage in `Fin d` and
transports that SAME seed time back to `v j`. This proves the first seed
clause. No gcd normalization or distinct-value collapse is needed:
deleting from the already injective tuple preserves exact count.

Successor elimination here is only a proof-level rewrite of `n`; return
the theorem with the original `Fin n` domain. Do not append a zero or
silently use `succAbove` with a mismatched `Fin (n-1)` domain before
establishing `n=(n-1)+1`.

**Sharp retained maximum.** For `j≠i`, membership in `Finset.univ.erase i`
and `Finset.le_sup` give `v j≤Q_i`, where `Q_i=retainedMaxSpeed v i`.
The maximum is positive: in the successor presentation choose
`j=i.succAbove ⟨0,0<d⟩`; it differs from `i`, and
`0<v j≤Q_i`. Its real cast `Q` is therefore positive. `Finset.sup_le`
gives the least-upper-bound property, so this is exactly the sharp maximum.
The point is not to use the target speed or the maximum of the full tuple
as an unannounced weaker bound.

**Explicit interval from finite continuity.** Now beta=`1/n` is strictly
above alpha=`1/(n+1)`. At the seed `s`, all retained norms are at least
beta. Set `epsilon=(beta-alpha)/Q>0`, exactly as in the signature. For
`t∈(s-epsilon,s+epsilon)` we have `|t-s|<epsilon`. Every retained label
satisfies the existing one-sided norm Lipschitz bound

    ||v_j t|| ≥ ||v_j s|| - v_j |t-s|
               ≥ beta - Q |t-s|
               > beta-Q*epsilon = alpha.                    (1)

Thus the whole open interval is in `ComplementSafe` at the original
native width. This is a uniform modulus for finitely many continuous
coordinate functions, using their sharp maximum Lipschitz constant.
It implements the finite-continuity argument directly, without building
a separate finite intersection of neighborhoods. The seed itself may
have retained coordinates exactly at beta. Interval endpoints are not
asserted strictly safe; the public `ComplementSafe` predicate remains
closed. No restriction to times in `[0,1]` is imposed on the interval.

## Shared maximum, contraction and positive radius

Fix the caller's `anchor` once. Call
`exists_attained_strict_failure_margin v anchor hv.positive hv.failure`
ONCE, before the target-index quantifier. It supplies `mu,tau` with the
exact attained/global clauses in the signature. As `n≥2`, alpha is at
most `1/2`; `0<mu<alpha` gives a strict positive gap. For every `i`,
use `hv.positive i`, the positive sharp `Q_i` and its retained bound to
apply the separately accepted `strict_core_bound_of_global_minimum`.
The same `hglobal : ∀ t, F t≤mu` matches it verbatim for every index.
This yields the full-time closed contraction, including all deletion
endpoints and all private portions:

    ||v_i t|| + v_i*(alpha-mu)/Q_i ≤ mu
    whenever ComplementSafe v i alpha t.                    (2)

The generic contraction is being implemented in a separate task. Do not
duplicate or modify that proof in this adapter; depend on its reviewed,
checked delivery. Its accepted mathematical contract and review are the
bound inputs here, not an assumed hash for a file still under development.

**Strict positivity needs the interval.** Write `m=(v i:ℝ)>0` and
`delta=(alpha-mu)/(Q_i:ℝ)>0`. Equation (2) alone at a nonempty safe point
only proves the radius `R_i=mu/m-delta` is nonnegative. Use the seed
interval to find a safe point with POSITIVE target norm as follows.

If `||m s||>0`, the center `s` is such a point. Otherwise norm
nonnegativity gives `||m s||=0`. Set `z=round(m*s)`; the exact round formula
gives `m*s=z` as reals. With the positive seed-interval radius epsilon,
choose

    h = min(epsilon, 1/(2*m)) / 2.

Then `0<h<epsilon` and `0<m*h≤1/4<1/2`. The point `s+h` is in the safe
interval, and integer periodicity plus the half-interval norm formula give

    ||m*(s+h)|| = ||z+m*h|| = m*h > 0.

In either case a safe point `u` has `q=||m u||>0`. Applying (2) there and
dividing by `m>0` proves

    R_i=mu/m-delta ≥ q/m > 0.                                (3)

This handles an initially zero target phase without assuming every safe
point has nonzero norm, without a finite-zero-set theorem, and without
assuming every collision portion has interior. The argument uses the
interior of the FULL deletion set supplied above. Negative seeds and
shifts across an integer time cause no change, because all-time safety
and integer phase periodicity were retained.

**Exclude all global maximizing times.** Let `F(t)=mu`. If `t` were in
the deletion-safe set for any `i`, (2) and its positive added term would
give `||v_i t||<mu`. But `minimumCircleNorm_le` gives
`mu=F(t)≤||v_i t||`, a contradiction. This is exactly the immediate
exclusion consequence independently accepted with the generic contract;
reuse its exported corollary once frozen, or apply these two inequalities
inside the assembly if it is not exported. This is no new exclusion
mechanism, and no equality of two coordinate norms is asserted.

## One hypothetical tuple and the first remaining implication

Starting with `hnot : ¬ Conjecture`, first call the existing
`exists_minimalPositiveIntegerFailure` to obtain ONE `n,v,hv`. Choose
an anchor from `hv.count_pos` and invoke the three proposed theorems on
that same `hv`. This retains the original count and sum minimality fields;
the adapter does not choose a different minimizer for each deletion.
The only new common choice is the single attained global margin.

The stronger native deletion seed is useful beyond existence of interior.
As a brief consequence, put beta=`1/n≤1/2` and apply the SAME generic
contraction at that seed with working width beta. Since `mu<alpha<beta`,

    q_i + v_i*(beta-mu)/Q_i ≤ mu,
    v_i/Q_i ≤ mu/(beta-mu) < n.                              (4)

The last strict inequality is equivalent to `(n+1)*mu<1`, already supplied
by native strict failure. This is a ratio restriction, not a witness or
contradiction. It needs no additional implementation wrapper and does not
replace the interior-based proof of (3).

For an endpoint control distinguishing (2) from (3), the LRC-good tuple
`(1,2)` has actual maximum `1/3`. At a SEPARATE working width `1/2`, deleting
speed `2` leaves the singleton safe set `{1/2 mod 1}`. Here `Q=1`, the
target norm is zero and (2) is equality, so
`mu/2-(1/2-mu)=1/6-1/6=0`. Nonemptiness plus pointwise contraction therefore
does not justify strict radius. This does not falsify the proposed adapter:
its original width is the native `1/(n+1)`, and lower-count supply gives
the strictly positive beta-minus-alpha interval. The actual maximum for
`(1,2)` and the weak contraction endpoint convention are checked in the
bound strict-core review; no numerical program is used here.

No mathematical gap remains in these adapter derivations beyond the
elementary assembly specified above. Their implementation and independent
review remain outstanding. The first unresolved uniform mathematical
implication is still a contradiction from this one minimal failure, or a
valid new common-time cover/descent mechanism under its full hypotheses.
Interior, contracted radii and exclusion of global maximizers do not supply
that implication or prove/disprove unrestricted LRC. No count ladder or
new finite search is proposed.

## API evidence and implementation readiness

| Bound source and lines | Exact use |
| --- | --- |
| `MinimalCounterexample.lean:18-29,168-208` | Existing normal form and its selection; keep its same original tuple and stronger all-admissible sum minimum. |
| `MinimalCounterexample.lean:276-306` | One attained global margin, independent anchor, all-real bound. |
| `BaseCases.lean:15-22` | Antipodal one-moving witness; `Fin.eq_zero` handles every `Fin 1` label. |
| `FiniteFamilyEquivalence.lean:18-30` | Exact own-count reciprocal and smaller-count interface. |
| `StationaryEquivalence.lean:42-57` | Source usage of `Fin.succAbove_right_injective` and `Fin.succAbove_ne`; restriction here omits the relative-speed subtraction. |
| `OneSixthComplementMaximizer.lean:17-25` | Source deletion enumeration and `Fin.exists_succAbove_eq` transport at a shared seed. Its fixed-count theorem is not used as a uniform result. |
| `SoftFeedbackLayers.lean:89-100` | Source usage of natural `Finset.sup_le` and `Finset.le_sup`. |
| `ConstrainedMaximizer.lean:46-47` | Exact full deletion-good predicate, with closed boundary. |
| `PivotBoundary.lean:45-59` | Continuous finite minimum and minimum-coordinate comparison. |
| `FastRunnerInsertion.lean:17-48` | Actual round residual, half-interval norm, integer periodicity and Lipschitz continuity. |
| Accepted strict-core contract and review | Exact full-W contraction plus the directly reviewed maximizing-time exclusion. Its implementation remains owned by the separate task. |

The relevant source bodies and fresh exact minimal-counterexample source
were read; focused searches found no existing adapter with these combined
interfaces. No absence claim rests on names alone. No new general topology,
gcd, sorting, finite-set cardinality or component theory is required.
Routine details still to elaborate are the successor rewrite, erased-set
supremum membership, casts/reciprocals, open-interval absolute-value bound
and the zero-residual perturbation. A private lemma stating that a positive
speed has a nonzero norm somewhere in any nonempty open interval may help,
but its complete elementary proof is already given above.

After independent review and successful delivery of the generic contraction,
this is ready for ONE cohesive Terra/high implementation with its focused
compile/repair receipt. Do not split off new mathematical exploration or
reprove the existing common-margin/strict-core theorems. Preserve the exact
public statements; report any semantic obstacle instead of weakening native
margins, injectivity, all-time coverage, or strict radius positivity.
No Lean edit, build, cache operation or implementation launch is performed
by this manuscript task.

## Bindings and actual checks

| Input | SHA-256 |
| --- | --- |
| `LonelyRunner/MinimalCounterexample.lean` | `b0c13b2212abd6bca49fe59f16b0c9d5b124e07e85226e35c14378baa1ffd539` |
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

Current configuration, project workflow, policy and focused state were read;
the gate is authorized `research/in_progress`, with start authorization
`2026-09-05T04:12:25.208107+00:00` and this sole owned manuscript.
`python3 -B scripts/validate_workflow.py` exited 0 with
`workflow structural validation passed; it cannot certify mathematical validity.`
The full owned text, all fifteen input hashes, final newline/whitespace and
final workflow validation are checked at handoff. All new mathematics was
checked by hand. The accepted strict-core contract/review and original
compiled normal-form source remain unchanged. No Lean file, other manuscript,
shared state, Git history or memory was edited; no build, cache operation,
mathematical program, sweep, solver, external model or extra agent was used.
