# Full deletion-set contraction: Lean contract and direct proof

Task `/root/strict_core_kernel_contract`; assignment checkpoint
`ae64785d3e3a61281bd5baaff773916d72383a78`. Requested route Astra/xhigh;
observed model, effort, elapsed time and usage are null. Only this manuscript
is owned. No Lean file or compilation is authorized in this pass.

The accepted contraction admits a direct proof from the nearest-integer
residual, with no connected-component or endpoint-limit infrastructure.
It holds on EVERY `ComplementSafe` time under a global upper bound for
the full minimum. The bound need not be the attained maximum. Count and
sum minimality are needed for later applications, not for this theorem.
The proof below is a proposed formal contract awaiting independent review;
it is not a new kernel result or a resolution of unrestricted LRC.

## Exact proposed theorem

In `namespace LonelyRunner`, a proposed module
`LonelyRunner/StrictCoreContraction.lean` can import
`LonelyRunner.ConstrainedMaximizer`. That imports the required finite-minimum
and norm APIs. The following is a declaration signature, not created Lean code.

```lean
theorem strict_core_bound_of_global_minimum
    {n : ℕ} (v : Fin n → ℕ) (anchor i : Fin n)
    (alpha mu Q : ℝ)
    (hi : 0 < v i) (hQ : 0 < Q)
    (hretained : ∀ j : Fin n, j ≠ i → (v j : ℝ) ≤ Q)
    (hgap : mu < alpha) (hhalf : alpha ≤ (1 : ℝ) / 2)
    (hglobal : ∀ s : ℝ,
      minimumCircleNorm (fun j => (v j : ℝ)) anchor s ≤ mu)
    (t : ℝ) (ht : ComplementSafe v i alpha t) :
    circleNorm (t * (v i : ℝ)) + (v i : ℝ) * (alpha - mu) / Q ≤ mu
```

`anchor` is independent of the distinguished index `i`; it matches the
anchor already used to certify a global margin. No anchor-change lemma
is needed. `Q` is a positive REAL bound on the retained natural speeds;
it need not equal their maximum. Natural speeds supply nonnegativity for
the Lipschitz calculation. Only the distinguished speed is required to
be positive. Generalizing all speeds to real values would require absolute
speed bounds and a changed deletion predicate; that expansion is unnecessary.

There is no assumption that the deletion-safe set is nonempty, that `t`
belongs to its interior, or that its component is an interval. The theorem
is a pointwise implication for arbitrary real `t`; it includes negative
times, closed deletion endpoints and any singleton private portion.
Positivity of `mu` and `alpha` is not an extra premise. At a supplied
deletion-safe time, the proof derives `0≤q≤mu<alpha`, where `q` is the
distinguished norm. The final bound in fact implies `q<mu`, because its
added term is positive. If there are no deletion-safe times, the theorem
makes no existence assertion.

The input `hglobal` concerns the full minimum at ALL real times. It cannot
be replaced by a bound on one coordinate restricted to `ComplementSafe`,
or by a bound at selected seeds. After a shift the retained coordinates
stay above `mu`, but need not stay above `alpha`.

## Direct proof with every strictness and sign explicit

Fix `t` satisfying `ht`. Abbreviate

    m=(v i:ℝ)>0,     q=circleNorm(t*m),
    delta=(alpha-mu)/Q>0,
    F(s)=minimumCircleNorm (fun j => (v j:ℝ)) anchor s.

**1. Extract the low coordinate.** At any real `s`,
`exists_eq_minimumCircleNorm` provides an actual label `j` whose norm
equals `F(s)≤mu`. Therefore whenever all retained norms at `s` are
strictly above `mu`, that label must be `i`, giving

    circleNorm(s*m)≤mu.                                      (1)

At `s=t`, retained norms are at least `alpha>mu`, so (1) gives `q≤mu`.
As a norm, `q≥0`. Consequently `mu≥0`, `alpha>0`, and
`mu<1/2`. No strict positivity of the initial residual is assumed.

**2. Trap every short time shift.** If `|s|<delta` and `j≠i`, use the
existing norm Lipschitz inequality to obtain

    circleNorm((t+s)*(v j:ℝ))
      ≥ circleNorm(t*(v j:ℝ)) - (v j:ℝ)*|s|
      ≥ alpha - Q*|s|
      > mu.                                                 (2)

The first step uses
`|t*(v j:ℝ)-(t+s)*(v j:ℝ)|=(v j:ℝ)*|s|`.
The second uses `ht`, `hretained` and `|s|≥0`. The last is strict because
`Q>0`, `|s|<(alpha-mu)/Q`, and `Q*delta=alpha-mu`.
Combining (1) and (2) gives

    |s|<delta  →  circleNorm((t+s)*m)≤mu.                     (3)

This implication does not require `(t+s)` to remain deletion-safe at
width `alpha`. Its source is the global full-minimum bound.

**3. Contradict a failed contracted inequality.** Suppose

    mu < q+m*delta.

Both `1/2` and `q+m*delta` are strictly above `mu`. Put

    c=min (1/2) (q+m*delta),        r=(mu+c)/2.

Then

    q≤mu<r<c≤1/2,       r<q+m*delta.

In particular `0<r<1/2`. Let `z=round(t*m):ℤ` and use the actual residual
`e=t*m-(z:ℝ)`. The existing round formula gives `|e|=q`.
Choose the direction `sigma=1` if `0≤e`, and `sigma=-1` otherwise.
Thus `e=sigma*q`. When `e=0` we explicitly choose `sigma=1`;
using a sign convention with `sign 0=0` would not prove the escape.

Set

    h=(r-q)/m>0,        s=sigma*h.

We have `|s|=h<delta`, using `m>0` and `r<q+m*delta`. Exact real phase
algebra gives

    (t+s)*m = (z:ℝ)+sigma*r.

Integer periodicity and the half-interval norm formula imply

    circleNorm((t+s)*m)=circleNorm(sigma*r)=|sigma*r|=r>mu,

contradicting (3). This works with either sign of `t` and either sign of
the old residual. The integer lift is the ORIGINAL `round(t*m)`; no claim
about how a newly rounded phase behaves is needed, since `r<1/2` directly
justifies the norm calculation.

Therefore `q+m*delta≤mu`. Reassociating real multiplication/division gives
exactly the proposed conclusion. The perturbation uses a strict interior
shift, so no limiting endpoint or continuity argument is hidden. Equality
in the final inequality remains allowed.

## Small missing helpers and existing API evidence

Only elementary assembly is missing. The first useful private helper is
the natural-speed specialization of the existing one-sided Lipschitz bound:

```lean
private theorem circleNorm_time_shift_lower
    (a : ℕ) (t s : ℝ) :
    circleNorm (t * (a : ℝ)) - (a : ℝ) * |s| ≤
      circleNorm ((t + s) * (a : ℝ))
```

Apply `circleNorm_sub_abs_le_circleNorm` to the two displayed phases;
factor the difference as `-(s*(a:ℝ))`, then use `abs_neg`, `abs_mul`
and nonnegativity of the natural cast. Do not reprove norm Lipschitzness.

A second private helper may isolate Step 3's exact radial adjustment:

```lean
private theorem exists_radial_time_shift
    (a : ℕ) (ha : 0 < a) (t r : ℝ)
    (hqr : circleNorm (t * (a : ℝ)) < r)
    (hrhalf : r < (1 : ℝ) / 2) :
    ∃ s : ℝ,
      |s| = (r - circleNorm (t * (a : ℝ))) / (a : ℝ) ∧
      circleNorm ((t + s) * (a : ℝ)) = r
```

The full proof is the `round` residual and two-sign construction above.
Its hypotheses imply `r>0`; no additional positivity axiom is needed.
This helper is an option for proof organization, not an extra research
obligation or public infrastructure expansion. The minimizing-label
argument in (1) can be local to the main proof. Basic ordered-field
arithmetic settles the midpoint, positive denominator and strict shift.

| Source and lines | Exact reuse / limitation |
| --- | --- |
| `FastRunnerInsertion.lean:14-23` | Norm definition, exact round residual, and the half-interval formula. |
| `FastRunnerInsertion.lean:25-48` | Integer periodicity, 1-Lipschitz estimate, and its one-sided form. |
| `PivotBoundary.lean:24-27,51-87` | Finite full minimum, comparisons, and an actual minimizing coordinate. No component or interval API is required. |
| `ConstrainedMaximizer.lean:46-47` | `ComplementSafe` is exactly the full closed deletion predicate. |
| `ConstrainedMaximizer.lean:150-162,183-188` | Existing public maximizer controls one coordinate ONLY on deletion-safe times. It does not supply this theorem's global full-minimum premise. |
| `MinimalCounterexample.lean:18-29,168-196` | New normal form stores positivity, injectivity, strict failure, all smaller-count supply, all-admissible sum minimality and primitivity. None is an extra hypothesis of the generic contraction. |
| `MinimalCounterexample.lean:276-306` | Attained positive strict global margin, with an independent anchor and an ALL-REAL global bound exactly matching `hglobal`. |
| `FiniteFamilyEquivalence.lean:18-30` | Smaller-count statements and the bounded lower-count adapter. |
| `OneSixthComplementMaximizer.lean:17-25` | Existing `succAbove` / `Fin.exists_succAbove_eq` deletion reindexing and strict-seed pattern. This is source guidance, not invocation of its fixed-count result as a uniform theorem. |

Focused source searches found no existing contraction/radial-adjustment
theorem in the inspected norm, boundary and constrained-maximizer files;
the relevant proof bodies were read. No project-wide absence claim is
inferred solely from names. No new rounding, norm, component, topology or
continuity theorem is missing for the proposed proof. Source signatures
are checked here; no new declaration was elaborated.

## Specialization and nonemptiness are separate obligations

The frozen `MinimalCounterexample.lean` supplies, conditionally on
`¬ Conjecture`, `n,v` with `MinimalPositiveIntegerFailure v`. Choose any
anchor and call `exists_attained_strict_failure_margin` using its positivity
and failure fields. It returns the actual global maximum `mu`, its
attainer and `0<mu<alpha` for `alpha=1/(n+1)`. The stored `1≤n` gives
`alpha≤1/2`. Use that SAME `mu` and anchor for all target indices.
For each target choose a positive bound `Q` on retained speeds and apply
the proposed theorem to every time in its full `ComplementSafe` set.

In the research notation, when there is at least one retained label,
take `Q=(Q_i:ℝ)`, where `Q_i` is the maximum retained speed. Positivity
of all original speeds makes it positive. Choosing instead any larger
positive bound is valid but gives a weaker contraction. The generic
theorem requires neither attainment nor equality of its supplied `mu`
to the actual maximum: any all-real upper bound below `alpha` suffices.
In the canonical application, the returned `mu` is actual and attained.

The contraction by itself does not prove the deletion set nonempty.
For the minimal-failure application with `n≥2`, restrict the injective
positive tuple to the `n-1` retained labels and explicitly reindex it by
`Fin (n-1)`. Stored smaller-count supply gives a common witness at
`1/n>1/(n+1)=alpha`. Every retained coordinate is then strictly alpha-good;
finite continuity gives a neighborhood contained in the full deletion
set. The existing `succAbove` pattern can implement this after expressing
the positive count as a successor. The trivial count-one case can be
excluded using the existing base theorem; no new runner-count ladder is
needed. This nonemptiness/seed adapter is separate from the contraction
unit and must not be silently added as a premise or conclusion there.

For any supplied deletion-safe point the theorem yields the nonnegative
contracted radius `mu/(v i:ℝ)-(alpha-mu)/Q≥0`. Strict positivity of that
radius needs additional information such as interior of the full deletion
set. Neither a pointwise strict final inequality nor interior of every
collision portion is part of this contract.

## Endpoint control, disposition and bounded handoff

The final weak inequality is sharp in the stated generality. Take natural
speeds `(1,2)`, target speed `1`, `Q=2`, working width `alpha=2/5`, and
actual maximum `mu=1/3`. To check the latter, put `x=||t||∈[0,1/2]`:
`||2t||=min(2x,1-2x)`, so if `x≤1/3` the first speed bounds the full
minimum, and otherwise the second does. Time `1/3` attains `1/3`.
At `t=3/10`, the retained norm is exactly `2/5`, so this is a CLOSED
deletion endpoint, and

    q=3/10,   delta=(2/5-1/3)/2=1/30,
    q+1*delta=1/3=mu.

Thus replacing the conclusion by `<mu` would be false. This control uses
a working threshold above the tuple's native `1/3`; it is not a canonical
failure or an LRC counterexample. The residual-zero branch, negative
times, and possible shifts across 0 or 1 are handled directly in the proof,
not excluded by this endpoint check. The midpoint construction also handles
`q+m*delta≥1/2` without crossing the antipode.

No falsifier was found for the exact proposed contract. Root supplied the
component-free residual argument, which is checked and scoped above;
the accepted manuscript and review establish the contraction by a different
connectedness proof. New formal work remains implementation, kernel/axiom
checks and independent semantic review of the exact declaration. No claim
about additional shell savings, common candidate selection or height
descent is supplied. Those uniform mathematical gaps remain; LRC is
unresolved. Do not expand this unit into arc bookkeeping or finite controls.

## Input bindings and actual checks

| Input | SHA-256 |
| --- | --- |
| `research/astra-strict-core-shell-supply.md` | `5cc9866b3c8a516494ad998355265335a5edd15158cf9701c7d814843b97210e` |
| `research/astra-strict-core-shell-review.md` | `dd733c2910f1f4579846c1c945ecac8e83d140eb29917b81dc11d2b1b119b95f` |
| `LonelyRunner/MinimalCounterexample.lean` | `b0c13b2212abd6bca49fe59f16b0c9d5b124e07e85226e35c14378baa1ffd539` |
| `LonelyRunner/ConstrainedMaximizer.lean` | `2ef07e6b83b8675a22184571c31d2a71dab9d5c072e3cd165cb8382957b46e92` |
| `LonelyRunner/PivotBoundary.lean` | `0e56cab74d30ef8b537ed4ec24503aae875bd8aadc369d26da99ba882cc3603f` |
| `LonelyRunner/FastRunnerInsertion.lean` | `dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5` |
| `LonelyRunner/FiniteFamilyEquivalence.lean` | `475a46b9e10226f3de30628e595073a9765a8c03cb0ab071bdcc10acb6446be3` |
| `LonelyRunner/OneSixthComplementMaximizer.lean` | `5a7011ca680b8a2b26c7bad466a8ee4008cf47507eb8b700846f296894bb90a1` |
| `.codex/config.toml` | `28212a53cf42cdc377df1f7dab040732d657e59d7bb97ee78791256d01d4bb2c` |
| `docs/project-workflow.md` | `2b42a133352b6b53ba2106fc73882733f176e04a0deffbb183b4c16eefd9cd67` |
| `research/workflow-policy.json` | `833c397b61d1ffdb994fb115019f6d60d6c1a62ff85f19cdd2c9f8ac3a979c8b` |
| `scripts/validate_workflow.py` | `250a3ce2a080f5835ac4fd2e4b2803568424c777cda5d421f9fe92efd34d5383` |

Current project configuration, workflow, policy and focused live state were
read; gate `research/in_progress`, explicit start authorization
`2026-09-05T04:12:25.208107+00:00`, and this sole owned file were confirmed.
`python3 -B scripts/validate_workflow.py` exited 0 with
`workflow structural validation passed; it cannot certify mathematical validity.`
The full frozen minimal-counterexample source was read and its supplied
hash matched. Root reports successful compilation and axiom checks in
chunks `94cfb3` / `5ab0af`; these are root-supplied receipts, not executions
repeated here. Its final independent review was in progress at assignment.
The strict-core source has the accepted independent manuscript review bound
above. That manuscript acceptance is not a kernel proof.

The new proof was checked by hand. Full owned readback, all input hashes,
final newline/whitespace and workflow validation are checked at handoff.
No Lean file, shared state, other manuscript, Git history or memory was
changed; no build, cache operation, mathematical program, sweep, solver,
extra agent or external model was used. Root owns independent review and
any later implementation/publication authorization.
