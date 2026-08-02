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
lower-dimensional premise explicit. Pivot-grid completeness is now
kernel-checked for every nonempty fixed positive-integer instance: existence
of an arbitrary real witness is equivalent to existence of a canonical finite
modular pivot certificate. Consequently the global positive-integer
formulation is kernel-checked as exactly equivalent to the corresponding
uniform certificate proposition. This does not supply that uniform
certificate. Exact common-denominator clearing and finite-range deduplication
are also kernel-checked, giving an equivalence between the positive-natural
formulation and both the distinct and repeated positive-rational formulations.
The full Bohman--Holzman--Kleitman real-to-rational reduction is now
kernel-checked, including the one-way multidimensional Kronecker theorem,
rational relation-space construction, collision/cardinality drop, strict
open-neighborhood transfer, rational-collinear branch, and sign normalization.
Consequently `Conjecture ↔ PositiveIntegerConjecture` is a compiled theorem.
This equivalence does not prove either proposition; the uniform positive-
integer arithmetic problem remains open.
The four existing integer induction branches are now combined in Lean, and
the sharp divisor-or-uncovered-pivot covering principle is proved equivalent
to `PositiveIntegerConjecture`; this isolates rather than resolves the open
uniform covering obstruction.
Capacitated Hall overlap allocation and exact finite pair-sum certificates
are now kernel-checked too. Full Hall-cut inequalities and unrestricted
pair-sum existence remain open arithmetic obligations.
One- and two-level disjoint-fiber overlap lower bounds are kernel-checked. The
sharper additive one-level certificate has no counterexample in the recorded
exhaustive and deterministic-random searches, but its uniform arithmetic
premise remains unproved.
The exact two-equation simultaneous-congruence compatibility criterion and
fiber cardinality are kernel-checked as the arithmetic core for pair-fiber
counts; pivot-candidate subtraction and the full modular specialization remain
to be connected.
An exact random-order calculation further reduces the search for a useful
order to a ranked sum of child-fiber/parent intersection counts.  The identity
and extensive exact tests are recorded.  Its proposed uniform strict modular
inequality is now rejected by an exact nine-speed counterexample, while the
stronger optimized-order certificate remains open.  The tie-safe per-fiber
tail identity and deterministic average extraction are kernel-checked; the
remaining shared-permutation bridge is documented but not yet formalized.
The bounded search and its selected-parent intersection data are not
end-to-end Lean proofs.
The general conjecture remains open, and this repository makes no proof or
disproof claim.

## Repository map

- `LonelyRunner/`: Lean definitions, formulations, proved equivalences, base
  cases through three total runners, normalization and modular-certificate
  layers, rational denominator clearing, the fast-runner insertion theorem,
  and the explicit axiom audit.
- `docs/canonical-statement.md`: exact quantifiers, indexing, and boundary
  conventions.
- `docs/literature.md`: primary-source literature and current known results.
- `docs/approaches.md`: candidate strategies and their blocking obligations.
- `docs/proof-obligations.md`: live proof-obligation ledger.
- `docs/failed-approaches.md`: rejected arguments and explicit counterexamples.
- `docs/structured-classes.md`: two audited comparable-speed class results and
  their residual obstruction.
- `docs/real-to-integer-reduction.md`: the completed exact BHK reduction and
  its lower-dimensional and endpoint dependencies.
- `docs/modular-pivot-certificates.md`: exact modular bad-set counts, generic
  Lean-checked certificate soundness, bounded audits, and the uniform gap.
- `docs/fourier-pivot-badsets.md`: exact candidate-filter and gcd-pullback
  Fourier coefficients, with the remaining uniform spectral obstruction.
- `docs/round6-strategies.md`: audited boundary-pivot, pair-sum, and divisor
  insertion lemmas, plus the failed two-parent extrapolation at eight speeds.
- `docs/integer-induction-cover.md`: exact combined induction interface,
  finite counterexamples to simpler covers, and the residual covering
  dichotomy.
- `docs/hall-overlap-credits.md`: capacitated Hall accounting, exact cut
  counterexamples, and the remaining arithmetic cut inequalities.
- `docs/fiberwise-hall-audit.md`: exact fiber-credit certificates, bounded
  coverage, and the smallest counterexample to their uniformity.
- `docs/pair-sum-geometry.md`: exact pair-sum certificates, restricted-selector
  counterexamples, and bounded unrestricted searches.
- `docs/manuscript.md`: human-readable text mapped to Lean declarations.
- `scripts/check_integer_tuple.py`: exact-rational fixed-instance optimizer and
  deterministic certificate verifier.
- `scripts/check_bad_sets.py`: exact rational interval-union and
  inclusion--exclusion audit utilities.
- `scripts/search_residual.py`: exact residual-class, pivot, overlap, and
  half-period searches, including complete primitive speed-30 audits through
  six moving runners.
- `scripts/search_induction_cover.py`: exact bounded audit of the combined
  fast/band/divisor/pivot induction branches.
- `scripts/search_hall_credits.py`: exact matching and truncated Hall-cut
  counterexample search.
- `scripts/search_fiber_hall.py`: exact optimized fiber-credit search and
  brute-order regression audit.
- `scripts/search_pair_sum_geometry.py`: exact finite pair-selection search.
- `scripts/check_fourier_badsets.py`: deterministic numerical regression audit
  of the fixed-pivot Fourier formulas and strict endpoint conventions.
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
