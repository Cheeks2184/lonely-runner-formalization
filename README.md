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
counts. Strict pivot target fibers now kernel-check as a disjoint decomposition
of each bad set, and their pair overlaps are exactly a finite sum of candidate
simultaneous-congruence counts. The explicit `q -> N*q` bijection now subtracts
the raw solutions divisible by the pivot-grid scale and yields a closed exact
compatibility/gcd formula for every pair-target count and overlap sum.
The corresponding three-equation theorem is also kernel-checked: compatibility
uses the four-way gcd and all three cross congruences modulo the strengthened
product modulus, and a compatible triple fiber has exactly that gcd many
residues. This supplies the raw arithmetic core for depth-two triple
intersections. The pivot specialization is now kernel-checked too: an explicit
`q -> N*q` bijection subtracts the divisible smaller-modulus fiber, producing a
closed exact candidate triple-target count and pair-target intersection
interface. No three-anchor uniformity is asserted.
An exact random-order calculation further reduces the search for a useful
order to a ranked sum of child-fiber/parent intersection counts.  The identity
and extensive exact tests are recorded.  Its proposed uniform strict modular
inequality is now rejected by an exact nine-speed counterexample, while the
stronger optimized-order certificate remains open.  The tie-safe per-fiber
tail identity and deterministic average extraction are kernel-checked; the
remaining shared-permutation bridge is documented but not yet formalized.
A GCD-rate exponential-clock bias repairs the first known uniform-average
failure and derandomizes by conditional expectation, but its cross-pivot
uniformity is now rejected by an exact primitive nine-speed counterexample.
The generic positive-weight conditional-expectation step and finite complete-
order extraction are kernel-checked; the exact GCD-clock potential identity
remains a paper/computational identity rather than a route to uniformity.
The generic finite relocation-descent implication and an exact block-
relocation identity for prefix-dependent costs are kernel-checked. Exact
enumeration supports a two-sided relocation criterion on the recorded hard
tuples, but its uniform arithmetic premise remains open; a proposed
three-anchor formula was malformed as first stated, then repaired into the
existing sound two-level pattern. All repaired fixed-instance tables reproduce
exactly. The selected-earlier-parent ordered-union and avoidance theorem is
now kernel-checked too, so tail children may soundly ignore non-anchor
predecessors; cross-tuple three-anchor uniformity remains open.
The stronger anchor-star double average is algebraically verified and all
reported exact values reproduce. Its generic strict-average selection step is
now kernel-checked, including the eligibility and pairwise-distinctness of all
three anchors. A new exact cellwise-dispersion lemma lower-bounds the otherwise
uncontrolled third-anchor gain by absolute differences of candidate-filtered
triple-congruence profiles. It is independently audited and succeeds on every
recorded hard tuple. The one-cell two-parent equality, positive-part/max
identity, symmetric pair dispersion, safe additive cost cancellation, and
ordered-average monotonicity are now kernel-checked in
`AnchorStarDispersion.lean`. The concrete global cell reindexing and the
cross-pivot `DISPERSION-STAR` inequality remain open, not theorems.
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
  coverage, and the smallest counterexample to the balanced common-credit
  strengthening.
- `docs/ranked-fiber-averaging.md`: tie-safe random-order identity, exact
  tests, and the all-pivot counterexample to its proposed uniform premise.
- `docs/adaptive-order-heuristics.md`: exact failures of four local rules and
  the all-pivot rejection of the GCD-rate conditional-expectation proposal.
- `docs/response26-audit.md`: exact reconstruction of relocation minima, the
  malformed first anchor formula, and the verified repaired construction.
- `docs/anchor-star-audit.md`: exact double-averaging identities, divisor
  input, stress tables, and bounded complete-box audit.
- `docs/gamma-arithmetic-audit.md`: exact residual-profile dispersion bound
  for the nonzero-target third-anchor gain, equality cases, and the remaining
  cross-pivot obligation.
- `docs/anchor-star-search-round2.md`: independent optimized evaluator,
  complete/structured/seeded search boundaries, and exact closest margins for
  the nested dispersion, anchor-star, and three-anchor conditions.
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
- `scripts/search_fiber_average.py`: exact ranked-average and regression
  counterexample calculations.
- `scripts/search_adaptive_orders.py`: exact adaptive-order, exponential-clock,
  and conditional-potential calculations.
- `scripts/audit_relocation_descent.py`: exact two-sided/left-only relocation
  enumeration and delta verification.
- `scripts/audit_three_anchor.py`: maximal sound reading of the rejected
  first formula and exact verification of the repaired full-fiber tables.
- `scripts/audit_triangle_lp.py`: minimal exact integrality gap for the
  clause/triangle ordering relaxation.
- `scripts/audit_anchor_star.py`: exact anchor-star values and complete-box
  scans for the stronger three-anchor average.
- `scripts/audit_gamma_dispersion.py`: exact cellwise-dispersion values,
  nested lower-bound checks, and bounded `DISPERSION-STAR` scans.
- `scripts/adversarial_gamma_dispersion.py`: independent finite-set and
  modular reconstruction of the dispersion inequality.
- `scripts/search_anchor_star_failures.py`: exact optimized all-pivot search
  for the three nested bounded-anchor sufficient conditions.
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
