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
predecessors. Cross-tuple three-anchor uniformity is now rejected by the exact
primitive tuple `(10,37,45,51,54,56,61,71,91)`: every corrected triple cost
is at least the strict pivot threshold. The same tuple still has an adaptive
full-order cost `84 < 90` and direct lonely time `3/100`. The generic theorem
that enlarging a sound bounded-anchor set cannot increase its total cost is
kernel-checked in `TwoLevelFiberCredits.lean`; it confirms that smaller anchor
sets cannot evade the triple obstruction once the concrete credit is
instantiated.
The surviving optimized additive objective has an exact finite reformulation:
its maximum achieved credit is the maximum weight of a selector choosing at
most one parent for each child target fiber subject to acyclic parent-to-child
support. Restricting every token to globally best parents gives a computable
weighted feedback-cycle sufficient condition. Its cross-pivot premise is now
exactly rejected by `(5,28,35,40,68,88,108,148,165)`: every top-only row is
nonstrict, with equality at pivots `5` and `35`. Two independent literal
implementations reproduce the complete table. This does not reject the
unrestricted objective: at pivot `28` its optimum is `250 < 252`, and
`t=3/140` is a direct lonely time. Both directions of the abstract finite
selector/order equivalence are kernel-checked in `AcyclicFiberSelector.lean`,
and `ModularAcyclicSelector.lean` now instantiates its tokens, owners,
eligibility, and exact candidate-filtered weights. It also kernel-checks the
deterministic bridge from a strict modular order-credit bound, through ordered
fiber-union avoidance, to an explicit real lonely-time witness. Unrestricted
optimized additive uniformity remains open.
Retaining all lower-ranked parents gives a stronger exact threshold-layer
model. A token of maximum weight `W` contributes one unit layer for every
`q<W`, supported by all parents of weight greater than `q`; its lost credit is
exactly the number of layers with no earlier supporting parent. This produces
the unrestricted Bellman recurrence, budgeted soft-core obstructions, and an
SCC-conditioned prefix bound. An independent audit checked 537,700
predecessor subsets. On the tuple above, prefix `(35,40,88)` at pivot `28`
has exact soft loss `38<40`, recovering optimized cost `250<252`. All eight
prior stress rows also pass the SCC bound with at most one prefix vertex.
There is still no theorem forcing such a prefix at some pivot uniformly.
The unit-layer potential/credit identity, generic budgeted peeling theorem,
and critical-core contrapositive are now kernel-checked in
`SoftFeedbackLayers.lean`. Independently, the nested three-deletion bound
`B_3` is proved mathematically and exhaustively audited; it is strictly tighter
than the one-step cardinality sum and passes every mandatory stress row. At
`E` pivot `165`, `B_3=187<211` while the exact soft optimum is `165`.
Nevertheless, `CHAIN3-UNIF` is false. The primitive tuple
`(8,15,35,40,48,56,75,132,147)` has `B_3>=beta` at every pivot, with equality
at pivot `75`; two independent exact implementations reproduce the complete
table. This rejects only the bounded-depth sufficient condition. At pivot
`15`, unrestricted optimized additive cost is `131<135`, and `t=13/80` is a
direct lonely time. `BlockPeeling.lean` kernel-checks the generic
non-strict and strict repeated-block implications, the exact short-final-block
cardinality, and equality with ordinary peeling when a block merely regroups
one-step bounds; it assumes no arithmetic uniformity premise.
The still stronger unrestricted condition `OPT-ADD-UNIF` is also false. The
primitive tuple `(15,21,40,48,56,105,126,280,1200)` has optimized additive
cost at least the strict threshold at every pivot, with equality only at
pivots `15` and `40`. A clean-room literal verifier agrees with the prior
subset DP after enumerating all `9*8!=362,880` pivot-order pairs. This rejects
only the additive-order sufficient condition: pivot `48`, residue `39`, gives
the exact lonely time `13/160`, now kernel-checked in
`OptAddCounterexample.lean`.
The fixed-pivot Bellman potential dual, its exact recursive optimum,
attainment, and greatest-feasible-potential characterization are kernel-checked
in `BellmanPeeling.lean`. They explain the failure certificate but do not force
a shared potential across pivot moduli. A capacity-respecting whole-overlap
packing is strictly stronger at a fixed pivot: on the earlier tuple at pivot
`8`, 24 whole token-parent blocks have credit `34>32`, proving union size at
most `70<72` even though additive cost is exactly `72`. The duplicate-incidence
identity, subtraction-free capacity bound, and abstract order-dominance route
are kernel-checked in `OverlapCapacity.lean`. The remaining live
finite target is the exact pivot-certificate proposition already proved in
Lean equivalent to the positive-integer conjecture, not another ordering
surrogate.
An exact componentwise 0-1 packer also rescues the OPT counterexample `G`:
at pivot `56`, a replayed packing has credit `400>392`; pivots `105` and
`1200` have separate strict witnesses. Exact optima are proved for five other
`G` pivots, while the hard residual rows are recorded only as certified
intervals. Eleven fixed stress tuples have a strict packing pivot, but this is
bounded evidence rather than a uniform theorem.
Response 39 adds two exact reformulations and one descent rule, without
closing that uniform gap. Exempt-owner colorings exactly characterize the
whole-block packing optimum. A common-LCM embedding expresses the sum of all
safe pivot candidates as a weighted zero-count and gives alternating-binomial
lower bounds from its moments. The denominator-cleared polynomial identity
and its zero-indicator inequality are kernel-checked in
`CorrelationPolynomial.lean`. The bound is nontrivial only below maximal
depth: once `2*d >= n-1` it is exact inclusion--exclusion, while computing the
complete weighted histogram already computes the safe count. Exact audits
nevertheless verify a genuinely low-depth positive value `3305/2` on the
OPT-ADD stress tuple. Turning this into an unbounded result requires direct
CRT formulas and estimates for only the low moments, not safe-residue
enumeration. A signed-divisor replacement also transports certificates from
the smaller tuple to the original tuple, but only in that direction at the
replaced pivot; the OPT-ADD stress tuple admits no such replacement.
The first noncircular low-moment step is now complete: every `H_q` is an
explicit finite sum of generalized-CRT intersection counts over pivot slices
and `q`-element runner-index subsets. Candidate multiples are subtracted by a
second gcd/lcm compatibility test, and strict boundary points are excluded.
For `G`, this direct formula gives
`(H_0,...,H_4)=(17019,27432,18203,7492,2709)` without constructing `D_0`, a
safe set, or the full multiplicity histogram. `WeightedZeroCount.lean`
kernel-checks the abstract slice double count and the summed polynomial bound,
including the necessary positive-weight guard.
This still does not provide uniform positivity. In fact, the consecutive
family `(1,...,n)` proves an infinite obstruction: every fixed depth is
negative infinitely often, and the linear rule `d=(n-3)/4` fails for all
`n congruent to 59 mod 60`, although `t=1/(n+1)` is always an exact lonely
time. Thus any surviving correlation proof must use an adaptive depth nearer
the exact cutoff, a different polynomial, or additional cross-pivot CRT
structure. No proof or disproof of LRC follows.
Optimizing the zero-indicator polynomial does improve finite certificates:
degree 3 gives `6061/6>0` on `G`, and degree 5 rescues T10 and T11. The exact
finite primal/dual LP and all grid-feasible polynomial vertices are classified
in `docs/moment-lp-audit.md`. Nevertheless, coefficient choice does not repair
uniform fixed order. For every fixed degree `r`, infinitely many actual
consecutive-speed pivot histograms have optimized LP value exactly zero even
though `t=1/(n+1)` is lonely. `ConsecutiveCorrelationObstruction.lean`
kernel-checks the weighted hockey-stick identity and the abstract cleared
histogram inequality underlying these obstruction arguments. The remaining
arithmetic histogram construction and asymptotic number theory are stated as
explicit formalization obligations.
The stronger anchor-star double average is algebraically verified and all
reported exact values reproduce. Its generic strict-average selection step is
now kernel-checked, including the eligibility and pairwise-distinctness of all
three anchors. A new exact cellwise-dispersion lemma lower-bounds the otherwise
uncontrolled third-anchor gain by absolute differences of candidate-filtered
triple-congruence profiles. It is independently audited and succeeds on every
recorded hard tuple. The one-cell two-parent equality, positive-part/max
identity, symmetric pair dispersion, safe additive cost cancellation, and
ordered-average monotonicity are now kernel-checked in
`AnchorStarDispersion.lean`. These implications are sound, but their proposed
uniform premises are false. Exact literal and optimized audits of
`(8,15,35,40,48,56,68,75,78)` find strictly negative best margins at every
pivot for both `ANCHOR-STAR` and `DISPERSION-STAR`.
A further range-sum majorization replaces each full profile by its minimum,
maximum, and sum. It is exact through six runners and keeps every mandatory
stress certificate strict, but the same nine-speed tuple strictly refutes its
`RANGE-SUM-STAR` premise. The exact three-anchor certificate still succeeds on
that particular tuple (`133 < 135`), as does an optimized additive order
(`285 < 315`); the separate tuple above is needed to reject three-anchor
uniformity.
Independent audits reject two tempting simplifications: first/second profile
moments fail on an exact all-pivot tuple, and deletion is not monotone for a
fixed pivot-anchor row. The new denominator-free debt polynomial, its finite
sum, nonnegative cell loss, and an abstract debt/loss decomposition with
explicit pair/reindexing hypotheses are kernel-checked in
`ResidualVariationDebt.lean`; the concrete modular reindexing remains open.
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
- `docs/rv-energy-audit.md`: exact pair-multiplicity identity, valid integer
  moment bounds, and the all-pivot rejection of their profile-free closure.
- `docs/rv-descent-audit.md`: common-scale and fixed-pivot residue invariance,
  plus an exact obstruction to deletion monotonicity.
- `docs/range-sum-audit.md`: range-profile majorization, the exact
  uncovered/debt/loss identity, and independently checked all-pivot failures
  of the three averaging premises.
- `docs/top-parent-cycle-audit.md`: literal reconstruction of the top-parent
  feedback-cycle criterion and eight exact stress rows.
- `docs/top-parent-rescue-audit.md`: exact lower-ranked rescue identity and
  prefix-conditioned hierarchy between random order and the top-only DP.
- `docs/top-cycle-failure-audit.md`: two-oracle all-pivot rejection of
  `TOP-CYCLE-UNIF`, exhaustive reproductions, and logical separation from the
  unrestricted certificate and LRC.
- `docs/soft-feedback-layer-audit.md`: exact full-parent threshold layers,
  Bellman loss, critical cores, SCC-conditioned prefixes, and the remaining
  cross-pivot obstruction.
- `docs/pair-sum-geometry.md`: exact pair-sum certificates, restricted-selector
  counterexamples, and bounded unrestricted searches.
- `docs/lcm-slice-response39-audit.md`: independent reconstruction of the
  common-LCM histogram, low-depth moment bounds, direct witnesses, and the
  signed-divisor replacement example.
- `docs/crt-moment-formula.md`: the noncircular generalized-CRT formula for
  every fixed-order moment.
- `docs/correlation-obstruction-family.md`: infinite consecutive-speed
  obstructions to fixed and one linearly growing correlation depth.
- `docs/moment-lp-audit.md`: exact primal/dual optimization over all feasible
  fixed-order zero-indicator polynomials and its infinite fixed-order failure.
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
- `scripts/audit_rv_energy.py`: exact pair-multiplicity and integer-profile
  energy/majorization audit.
- `scripts/audit_rv_descent.py`: exact scaling, signed-residue, and deletion
  checks for residual variation.
- `scripts/audit_range_sum.py`: exact range/full-dispersion rows, slow literal
  residue oracle, debt-identity checks, and surviving certificate witnesses.
- `scripts/audit_top_parent_cycles.py`: independent exact top-parent and
  unrestricted additive subset dynamic programs.
- `scripts/audit_top_cycle_failure.py` and
  `scripts/search_top_cycle_failures.py`: independent exact reconstruction and
  search provenance for the all-pivot top-only counterexample.
- `scripts/search_opt_add_failures.js`: independent literal unrestricted
  subset-DP search across 9--11 speeds, including the complete primitive
  ten-speed box through maximum `22`; its bounded searches found no all-pivot
  failure and make no uniform inference.
- `scripts/audit_soft_chain_blocks.py`: exhaustive subset verifier for the
  nested `B_1,B_2,B_3` soft-peeling bounds and every reported stress row.
- `scripts/audit_lcm_slice_bounds.py`: clean-room common-LCM slice, polynomial,
  witness, and signed-replacement verifier.
- `scripts/audit_crt_moment_formula.py`: direct low-moment CRT evaluator with
  independent pivot-grid comparison.
- `scripts/audit_correlation_obstructions.py`: exact finite checks for the
  proved infinite correlation-obstruction family.
- `scripts/audit_moment_lp.py`: exact polynomial-vertex enumeration, rational
  primal/dual certificates, and structured-family audit.
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
