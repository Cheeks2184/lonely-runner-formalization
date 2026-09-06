# Four-runner mixed classification implementation

Source checkpoint: `7e1b4073cfd0095a3e514df975313562feb82688`.

Implemented in `LonelyRunner/FourRunnerMixed.lean`:

* `fourRunnerMixed_iff` at the settled positive, strictly increasing natural
  triple contract;
* the public exceptional-family exclusion
  `not_fourRunnerMixed_one_two_three`;
* gcd normalization into the already proved primitive theorem; and
* `strict_ordinary_witness_implies_fourRunnerMixed`, whose strict witness is
  an arbitrary real time, as required.

The exception proof folds a phase into its nearest-integer residual.  The
second coordinate bounds that residual by `3/8`; two-sided absolute-value
bounds then force the third coordinate to be at most `1/4`.  The strict
version obtains a strict third-coordinate contradiction.  The normalization
proof factors every speed by `gcd a (gcd b H)`, proves the divided triple
primitive by cancellation, and rescales the primitive witness by `1 / g`.

Focused verification after the final correction:

* `lake env lean LonelyRunner/FourRunnerMixed.lean` — terminal exit `0`
  after final warning cleanup (session `99295`); and
* `lake build LonelyRunner.FourRunnerMixed` — terminal exit `0`, built target
  `[2991/2991]` (session `68119`).

`lake env lean LonelyRunner/AxiomAudit.lean | rg ...` exited `0` (session
`68119`) and reported only `propext`, `Classical.choice`, and `Quot.sound` for
the five added public classification/exclusion declarations.

The first local source check was incorrectly reported as successful before its
live process was polled.  The later terminal check exposed sign, rewrite,
normalization, and strict-time-contract defects; they were corrected before
the final checks above.  This report records only the final terminal evidence.

Final source hashes at this checkpoint:

* `LonelyRunner/FourRunnerMixed.lean`:
  `ae47b419c5b4cebfa72a325bdb50cd32e03444c39850a74b885037d83e312a5c`;
* `LonelyRunner/FourRunnerMixedCertificate.lean`:
  `3fee16348b510ed25fd75194d59ed24ec5ffb6d02a3af1318761b772be167c56`.

This is a focused four-runner milestone.  The unrestricted conjecture,
independent semantic review, full source build, and final trust audit remain
orchestrator-owned work.
