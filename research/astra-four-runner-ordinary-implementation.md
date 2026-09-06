# Four-runner ordinary natural bridge

Source checkpoint: `0e49249d9fcbba5e4a8312d845224bc11466db76` on
`codex/astra-four-runner-canonical-bridges`.

Implemented only steps 1--2 of the accepted bridge plan
`9f752fa91fcbf56bb80d1a8a424697801e21b78262bc1315c138431c2e160f0c`:

* `threeMovingNaturalSpeeds` supplies a positive ordinary quarter witness for
  every positive strictly increasing natural triple.  The nonexceptional case
  weakens the mixed fastest-third bound.  The exceptional `(a, 2a, 3a)` case
  uses `(4a)⁻¹`, with exact phases `1/4`, `1/2`, and `3/4`.
* `threeMovingNaturalRunners` sorts an arbitrary injective positive `Fin 3`
  natural tuple via `exists_strictMono_reindex`, then transports the ordinary
  witness through the sorting equivalence.
* `lowerCountPositiveIntegerHypothesis_five` combines the existing H4 supply
  for dimensions one and two with the new triple theorem for dimension three.

Focused verification used the shared pinned cache:

* `lake env lean LonelyRunner/FourRunnerOrdinary.lean` — terminal exit `0`
  (session `39555`);
* `lake build LonelyRunner.FourRunnerOrdinary` — terminal exit `0`, target
  `[2993/2993]` built (session `42345`);
* an in-memory Lean control source — terminal exit `0` (session `67274`).
  It instantiates the scaled exception `(17,34,51)`, an unsorted positive
  natural `Fin 3` tuple `[51,17,34]`, and prints axioms for all three new
  declarations.  Each uses only `propext`, `Classical.choice`, and
  `Quot.sound`.

Final hashes:

* `LonelyRunner/FourRunnerOrdinary.lean`:
  `2fb2f5c9c0742daa3278ee0ddeacd8643e1e22f8c885de95f5f38e10734b29f6`;
* accepted plan:
  `9f752fa91fcbf56bb80d1a8a424697801e21b78262bc1315c138431c2e160f0c`.

This is the H5 bounded-supply milestone only.  It makes no fixed-five or
unrestricted Lonely Runner claim, and does not implement the plan's real-speed
or canonical bridges.
