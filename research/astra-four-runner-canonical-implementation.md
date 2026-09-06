# Four-total-runner canonical integration

Source checkpoint: `0e49249d9fcbba5e4a8312d845224bc11466db76`.

Added `LonelyRunner.fourRunners`:

```lean
theorem fourRunners (speeds : Fin 4 → ℝ) (hinj : Function.Injective speeds)
    (runner : Fin 4) : ∃ t : ℝ, LonelyAt speeds runner t
```

It is the direct `m = 3` specialization of `lonelyAt_of_lowerCount`, using
the proved `lowerCountPositiveIntegerHypothesis_five`.  The theorem covers all
real speed signs, every injective four-runner family, every selected label, and
all real times.  It is an ordinary closed-quarter result only; it does not
claim a fastest mixed margin, a positive-time refinement, or any count other
than four total runners.

Integration changes import the ordinary, bounded real, and canonical modules
from `LonelyRunner.lean`, and append the requested eight public axiom probes to
`LonelyRunner/AxiomAudit.lean`.

Focused verification with terminal exit `0`:

* `lake env lean LonelyRunner/FourRunnerCanonical.lean` followed by
  `lake build LonelyRunner.FourRunnerCanonical` built `[2995/2995]` (session
  `48747`);
* in-memory Lean control source (session `29617`) checked the exact
  `fourRunners` signature and axioms, and instantiated an injective real tuple
  `[0,1,2,3]` with runner label `1`.  Its relative magnitudes include the
  repeated value one, exercising the signed/repeated-magnitude generic path.
* `lake env lean LonelyRunner/AxiomAudit.lean` filtered to the eight new
  declarations exited `0` (session `41697`); every probe has only the allowed
  standard axioms.

The `fourRunners` axiom report contains only `propext`, `Classical.choice`, and
`Quot.sound`.

Final hashes:

* `LonelyRunner/FourRunnerCanonical.lean`:
  `353b116d04d464fb9aedb92437e7f56168992e087a862f934044bc9062761c38`;
* `LonelyRunner.lean`:
  `dae4d7c57a2cd80e33b8d087c62fa0ba64fb039012112078a2e4ef7c24c93756`;
* `LonelyRunner/AxiomAudit.lean`:
  `31ca9c8be208cca88007162b5a6941d90fdf901a21f55f2176fc0d51c9e43b4a`.

The requested full source build, trust audit, and final independent review
remain orchestrator-owned work.
