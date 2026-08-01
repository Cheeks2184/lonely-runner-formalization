# Lonely Runner formalization

This repository records a proof-oriented investigation of the Lonely Runner
Conjecture in Lean 4. The theorem named as the conjecture is a statement to be
proved, not evidence that a proof has been found.

Current result: the canonical statement, its nonnegative-time, relative-speed,
distinct-stationary, and repeated-stationary equivalences, the one-moving-runner
and two-moving-runner base cases, a quantitative fast-runner insertion theorem,
and a minimum-scale residue-band structured class are kernel-checked. Sign and
common-scale normalization, the modular pivot residue model and witness bridge,
the exact individual bad-set gcd count, and generic finite union and
ordered-overlap certificate soundness are also kernel-checked. A conditional
codimension-one divisor-insertion theorem is kernel-checked with its
lower-dimensional premise explicit. The bounded search and its selected-parent
intersection data are not end-to-end Lean proofs.
The general conjecture remains open, and this repository makes no proof or
disproof claim.

## Repository map

- `LonelyRunner/`: Lean definitions, formulations, proved equivalences, base
  cases through three total runners, normalization and modular-certificate
  layers, the fast-runner insertion theorem, and the explicit axiom audit.
- `docs/canonical-statement.md`: exact quantifiers, indexing, and boundary
  conventions.
- `docs/literature.md`: primary-source literature and current known results.
- `docs/approaches.md`: candidate strategies and their blocking obligations.
- `docs/proof-obligations.md`: live proof-obligation ledger.
- `docs/failed-approaches.md`: rejected arguments and explicit counterexamples.
- `docs/structured-classes.md`: two audited comparable-speed class results and
  their residual obstruction.
- `docs/real-to-integer-reduction.md`: the exact BHK reduction, its
  lower-dimensional dependency, and the formalization gap.
- `docs/modular-pivot-certificates.md`: exact modular bad-set counts, generic
  Lean-checked certificate soundness, bounded audits, and the uniform gap.
- `docs/round6-strategies.md`: audited boundary-pivot, pair-sum, and divisor
  insertion lemmas, plus the failed two-parent extrapolation at eight speeds.
- `docs/manuscript.md`: human-readable text mapped to Lean declarations.
- `scripts/check_integer_tuple.py`: exact-rational fixed-instance optimizer and
  deterministic certificate verifier.
- `scripts/check_bad_sets.py`: exact rational interval-union and
  inclusion--exclusion audit utilities.
- `scripts/search_residual.py`: exact residual-class, pivot, overlap, and
  half-period searches, including complete primitive speed-30 audits through
  six moving runners.
- `certificates/`: reproducible finite-search outputs.
- `research/`: Lean build history and archived GPT-5.6 Sol Pro sessions.

## Reproducible build

The project pins Lean and mathlib to `v4.32.1`.

```sh
lake update
lake exe cache get
lake build
lake env lean LonelyRunner/AxiomAudit.lean
```

`LonelyRunner.Conjecture` is the canonical unrestricted-real-time statement.
`LonelyRunner.NonnegativeTimeConjecture` is kept separate, and their
equivalence is proved rather than silently built into the canonical statement.

Run the exact computational regression suite with:

```sh
python3 -m unittest discover -s tests -v
```
