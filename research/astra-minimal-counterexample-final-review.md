# Minimal counterexample: independent final source review

Accepted without corrections for the exact conditional bridge below. The entire
frozen `LonelyRunner/MinimalCounterexample.lean` was read, including its private
lemmas, and compared with the accepted contract and independent contract review.
All five public signatures preserve that contract. This acceptance establishes
neither a contradiction from the resulting minimal failure nor unrestricted LRC.

Task: `/root/minimal_counterexample_final_review`. Source checkpoint:
`ae64785d3e3a61281bd5baaff773916d72383a78`; the file hashes below identify the
reviewed working sources. Requested route: `gpt-6-astra`, `xhigh`, existing
in-session reviewer. Observed model, observed effort, task elapsed time and usage:
`null`. Only this review file is owned and written by the reviewer.

## Exact predicates and the two minima

Write `alpha = 1/(n+1)` and `F_v(t) = min_i circleNorm(t*v_i)`. In the source the
natural number `n+1` is cast to the reals before inversion. `PositiveIntegerFailure
v` is exactly `forall t : Real, exists i : Fin n, circleNorm(t*v_i) < alpha`.
The first theorem proves equivalence with the negation of a real-time witness
whose every coordinate has norm **at least** `alpha`. No closed/strict endpoint
is lost, and the existential bad coordinate may depend on time. This equivalence
needs neither positivity nor injectivity. When `n=0`, the failure predicate is
false, consistently with the vacuous closed witness.

The existence theorem assumes only `not Conjecture`. It uses the existing,
unconditional `conjecture_iff_positiveIntegerConjecture` in the correct direction:
the positive integer conjecture would imply the canonical conjecture. It then
extracts a failed positive count. There is no added finite-family hypothesis or
assumption that some minimal failure already exists. The unchanged canonical
reduction and count formulation were checked in the bound contract review;
their current source hashes match that evidence.

The first `Nat.find` minimizes the natural count among
`1 <= n and not PositiveIntegerAtCount n`. Its strict minimality yields
`PositiveIntegerAtCount d` for every `1 <= d < n`, with that smaller count's own
closed threshold `1/(d+1)`. At the chosen count, the second `Nat.find` minimizes
the natural sum among **all** positive, injective failing maps `Fin n -> Nat`.
The witness set for this second minimum is nonempty by the first extraction.
`Nat.find_min'` gives `sum v <= sum w`, using `sum v = s` in the correct direction.
The search does not restrict competitors to primitive, ordered, bounded-height,
or single-coordinate modifications. Both minimum assertions in the structure
therefore have their stated quantifiers; the gcd field is proved afterward.

## Division, primitivity and the smaller-sum witness

For `g>0` and `v_i=g*w_i`, failure of `v` at time `t/g` implies failure of `w`
at time `t`; failure of `w` at time `g*t` implies failure of `v` at time `t`.
The two phase identities in `positiveIntegerFailure_factor_iff` implement these
directions exactly. Count and threshold do not change, and arbitrary real times
are essential to this rescaling.

For `g = gcd_i v_i`, the positive count supplies an index and its positive speed
makes `g>0`. Divisibility gives `v_i=g*(v_i/g)` and positive quotients. Equality
of two quotients implies equality of the original speeds, so the quotient family
is injective. The factor theorem transports failure to this admissible same-count
family. If `g>1`, every positive quotient is strictly smaller than its original
speed; summing over the nonempty finite index set gives `sum(v/g) < sum v`.
The already established minimum over all failures contradicts this. Together
with `g>0`, this proves `g=1` without assuming primitivity of a competitor or of
the selected family.

`MinimalPositiveIntegerFailure.witness_of_sum_lt` takes any positive injective
`w : Fin n -> Nat` with `sum w < sum v`. Negating its claimed closed witness gives
exactly `PositiveIntegerFailure w`; the minimum then gives the contradictory
reverse weak inequality. No gcd assumption is imposed on `w`. Families with
duplicate or zero speeds are excluded by explicit hypotheses, not silently
normalized within this theorem. Thus this is the general same-count exchange
consequence required by the contract.

## Attained positive margin and the all-real bound

`exists_attained_strict_failure_margin` requires a positive natural-speed family,
an explicit `anchor : Fin n`, and its failure predicate. It does not require
injectivity, minimality, or primitivity. The anchor excludes an empty minimum.
The imported `minimumCircleNorm` is the actual finite coordinate minimum;
`minimumCircleNorm_le`, `le_minimumCircleNorm`, and
`exists_eq_minimumCircleNorm` are used with their original meanings.

Let `S=sum v_i`. Positivity and the anchor give `S>0`. The source constructs
`t=1/(2*S)` in `[0,1]`. Every speed satisfies `1 <= v_i <= S`, hence
`t <= t*v_i <= 1/2`. The exact half-interval norm formula gives
`circleNorm(t*v_i)=t*v_i >= t>0`, so `F_v(t)>0`. The repaired use of
`t*S=1/2` substitutes into the upper bound in the correct orientation.

Continuity of the finite minimum and compactness of `[0,1]` produce an actual
maximizer `tau`. Its value `mu=F_v(tau)` is positive by the preceding witness.
The private fractional-part lemma proves equality of the two finite minima by
choosing a minimizing coordinate in each direction and using
`circleNorm(fract(t)*v_i)=circleNorm(t*v_i)` for natural speeds. Since every real
fractional part lies in `[0,1]`, this gives `F_v(t) <= mu` for **every real** `t`,
including negative times. Finally, failure at `tau` supplies one coordinate
strictly below `alpha`, and the minimum is at most that coordinate. Therefore
`0 < mu < alpha`, with `F_v(tau)=mu` and the stated all-real upper bound.
The strict upper endpoint follows from attainment; the proof never infers a
strict supremum bound merely from pointwise strict inequalities.

## Integration, receipts and remaining scope

The root module imports `LonelyRunner.MinimalCounterexample`.
`LonelyRunner/AxiomAudit.lean`, which imports the root module, contains explicit
`#print axioms` probes for all five public declarations:

- `LonelyRunner.positiveIntegerFailure_iff_no_witness`
- `LonelyRunner.positiveIntegerFailure_factor_iff`
- `LonelyRunner.exists_minimalPositiveIntegerFailure`
- `LonelyRunner.MinimalPositiveIntegerFailure.witness_of_sum_lt`
- `LonelyRunner.exists_attained_strict_failure_margin`

The trust script requires all five names, rejects missing reports and axioms
outside `propext`, `Classical.choice`, and `Quot.sound`, and retains the project
source scan. These are checked source connections, not a claim that this reviewer
executed the audit. The complete new module contains no admitted proof, custom
axiom or computational trust shortcut.

Root reported a capped focused compile of precisely the bound Lean source:
chunk `94cfb3`, exit status `0`, empty stdout and stderr. This receipt is reused,
not replayed. The root-reported history records two unsuccessful Terra repair
rounds followed by root repairs to quotient calculation/hypothesis normalization,
the `htS` orientation, and the deprecated negation-pushing tactic. The final
source preserves the accepted statements. Root owns the focused axiom execution
and full integration; its verification JSON was still being completed at task
handoff and is deliberately not bound here. A subsequent root receipt can record
those execution outcomes without changing this semantic review.

The reviewer read the current configuration, workflow, policy and focused active
task record. Research is authorized and the unrestricted goal remains in
progress. `python3 -B scripts/validate_workflow.py` passed; this is structural
validation only. Final review readback, all sixteen file-hash comparisons, final
newline and trailing-whitespace checks passed. There was no reviewer Lean run,
mathematical program, new agent, Git operation, cache change or shared-state edit.

No counterexample or missing assumption was found in this conditional bridge.
The first unresolved mathematical implication is a contradiction from the
minimal failure and its actual strict global margin, or another complete
unrestricted argument. Merely obtaining this normal form does not supply that
implication and does not resolve LRC.

## Frozen source bindings

The accepted contract review supplies the unchanged earlier dependency audit;
this review checks the new source and its actual invoked interfaces. Mutable
workflow state is recorded by focused task identity above rather than frozen as
a mathematical dependency. The pinned toolchain is Lean `v4.32.1`; the manifest's
mathlib revision is `520045ab14e26149ee970e2e617ca04b09bde5d6`.

| Path | SHA-256 |
| --- | --- |
| `LonelyRunner/MinimalCounterexample.lean` | `b0c13b2212abd6bca49fe59f16b0c9d5b124e07e85226e35c14378baa1ffd539` |
| `research/astra-minimal-failure-kernel-contract.md` | `17067b1cfc7ebc5d473769fa03821eb7a203cfc53bc8936d95653d71cf253de8` |
| `research/astra-minimal-failure-kernel-contract-review.md` | `d891f197d6f232c3f4e255fb885e599527c8c14ab67c6562c8059af54edcc34a` |
| `LonelyRunner.lean` | `9bdb661179ab2b29af311271da6c688d76275e9cf116205001395e67d0b05a01` |
| `LonelyRunner/AxiomAudit.lean` | `959ddd972dbd984d82aa9b2f50067b0811e3d948609d083e4324fb62405aa75c` |
| `scripts/audit_lean_trust.py` | `42fd0592b63f6487fa8217f7e416923b3219dbd542b7e07c012553b360932b39` |
| `LonelyRunner/BHKRealReduction.lean` | `98d7c878eef7e4a3b7f7c504c882cf35191c1343816a59d731193ac8a207ed26` |
| `LonelyRunner/FiniteFamilyEquivalence.lean` | `475a46b9e10226f3de30628e595073a9765a8c03cb0ab071bdcc10acb6446be3` |
| `LonelyRunner/PivotBoundary.lean` | `0e56cab74d30ef8b537ed4ec24503aae875bd8aadc369d26da99ba882cc3603f` |
| `.codex/config.toml` | `28212a53cf42cdc377df1f7dab040732d657e59d7bb97ee78791256d01d4bb2c` |
| `docs/project-workflow.md` | `2b42a133352b6b53ba2106fc73882733f176e04a0deffbb183b4c16eefd9cd67` |
| `research/workflow-policy.json` | `833c397b61d1ffdb994fb115019f6d60d6c1a62ff85f19cdd2c9f8ac3a979c8b` |
| `scripts/validate_workflow.py` | `250a3ce2a080f5835ac4fd2e4b2803568424c777cda5d421f9fe92efd34d5383` |
| `lean-toolchain` | `8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af` |
| `lakefile.toml` | `bdcbaaa18d518409619215e8acf7892452c1fa5c6e80ba742ce67f7380682a26` |
| `lake-manifest.json` | `887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218` |
