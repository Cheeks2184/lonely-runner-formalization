# A formal investigation of the Lonely Runner Conjecture

## Status

This manuscript does **not** claim a proof or disproof of the general Lonely
Runner Conjecture. It is maintained in lockstep with the Lean sources. Any
result described as formal below must name the corresponding declaration and
must build without `sorry`, `admit`, or added axioms.

## 1. The circle and runner positions

The track is the additive quotient `R / Z` with circumference one. A runner of
speed `v` is at the quotient class of `t*v` at time `t`. The quotient metric is
the shorter circular distance. This is represented by:

- `LonelyRunner.UnitCircle`
- `LonelyRunner.position`
- `LonelyRunner.circleDistance`

in `LonelyRunner/Definitions.lean`.

## 2. The conjecture

For `N >= 2` total runners with an injective real speed assignment, the
canonical target requires that for every chosen runner there is a real time at
which its distance from every other runner is at least `1/N`. The closed
boundary and the order `forall runner, exists time` are essential.

The Lean declarations are:

- `LonelyRunner.LonelyAt`
- `LonelyRunner.Conjecture`

The canonical declaration uses unrestricted real time.
`LonelyRunner.NonnegativeTimeConjecture` records the common nonnegative-time
variant, and `LonelyRunner.conjecture_iff_nonnegativeTimeConjecture` proves the
equivalence by time reversal.

## 3. Relative velocities

Subtracting the chosen runner's speed makes it stationary. Circular distance is
translation invariant, and the other runners have velocities `v_j-v_i`. The
Lean declarations are:

- `LonelyRunner.RelativeLonelyAt`
- `LonelyRunner.RelativeConjecture`
- `LonelyRunner.lonelyAt_iff_relativeLonelyAt`
- `LonelyRunner.conjecture_iff_relativeConjecture`

The conventional formulation has `N-1` distinct nonzero moving speeds and one
stationary runner. The exact finite reindexing is formalized using
`runner.succAbove : Fin (N-1) → Fin N`, whose range is precisely the complement
of the chosen runner. In the other direction, `Fin.lastCases` appends a
zero-speed runner at the final index. The denominator is preserved as the
identity `(N-1)+1=N`; no cardinality or quantifier change is hidden. The Lean
declarations are:

- `LonelyRunner.DistinctStationaryConjecture`
- `LonelyRunner.injective_lastCases_zero`
- `LonelyRunner.injective_relative_succAbove`
- `LonelyRunner.relative_succAbove_ne_zero`
- `LonelyRunner.conjecture_iff_distinctStationaryConjecture`

`LonelyRunner.StationaryConjecture` separately allows repeated moving speeds.
The declaration
`LonelyRunner.distinctStationaryConjecture_iff_stationaryConjecture` proves
that this does not strengthen the global conjecture: it enumerates the finite
range of the tuple, applies the distinct statement in that lower dimension,
and weakens the resulting stronger denominator bound. Thus the formal chain is

`Conjecture ↔ DistinctStationaryConjecture ↔ StationaryConjecture`.

The composed declaration is
`LonelyRunner.conjecture_iff_stationaryConjecture`.

`LonelyRunner.PositiveIntegerConjecture` records the pairwise-distinct
positive-integer formulation; no real-to-integer reduction is assumed.

## 4. Verified partial mathematics

The statement-equivalence layer builds cleanly, and its axiom audit reports
only `propext`, `Classical.choice`, and `Quot.sound`. The quantitative insertion
theorem is formalized as `LonelyRunner.fastRunnerInsertion`: a new relative
speed of magnitude at least `k` times each of the `k-1` old speed magnitudes can
be inserted by perturbing the old witness within the exact available slack.

The one-moving-runner base case is formalized as
`LonelyRunner.oneMovingRunner`: for nonzero relative speed `v`, the explicit
time `1/(2v)` places the runner at circular distance exactly `1/2`.

The full two-moving-runner case, corresponding to three total runners, is
formalized as `LonelyRunner.twoMovingSpeeds` and
`LonelyRunner.twoMovingRunners`. After ordering magnitudes, a ratio at least
two is handled by `fastRunnerInsertion` from the one-moving-runner witness; the
complementary ratio interval `[1,2]` is the first closed residue band. No
density or integer reduction is used.

Fixed-instance sign and common-scale reductions are formalized in
`LonelyRunner/Normalization.lean`. They justify replacing individual speeds
by magnitudes and dividing out a common nonzero factor, while making no claim
that arbitrary real ratios can be converted to rational ones.

The elementary rational-to-integer step is formalized separately in
`LonelyRunner/RationalReduction.lean`. For a distinct positive rational tuple,
`rationalCommonDenominator` is the product of its reduced denominators and
`clearRationalSpeed` gives positive natural speeds. The cast, positivity, and
injectivity lemmas culminate in
`positiveIntegerConjecture_iff_distinctPositiveRationalConjecture`. This theorem
rescales time in the exact direction and uses the closed boundary. The finite
range of a repeated positive rational tuple is then enumerated explicitly;
the stronger bound for its smaller distinct range is weakened to the original
tuple's bound. This gives
`distinctPositiveRationalConjecture_iff_positiveRationalConjecture` and the
composed `positiveIntegerConjecture_iff_positiveRationalConjecture`.

The hard reverse direction of the required multidimensional orbit theorem is
now formalized in the five `Kronecker*.lean` modules. Integer Fourier
characters separate a point from a closed finite-torus subgroup by normalized
Haar orthogonality, Urysohn separation, and the dense Fourier span. The final
declarations
`exists_mFourier_separating` and
`orbitHom_mem_closure_range_of_relations` prove that inclusion of integer
relation lattices implies the pointwise orbit-closure inclusion used by BHK.
The remaining BHK construction is now formalized as well.  A rational basis
of the finite `ℚ`-span of the velocities supplies coordinate rows.
`exists_positive_rational_of_integer_relations` uses density of rational
basis coefficients inside a finite open positivity cone.  If a selected real
speed ratio is irrational, `exists_rationalRow_ratio_ne_of_irrational` proves
that one basis row has nonconstant ratios relative to that positive rational
tuple.  Finite adjacent-ratio selection and the BHK linear combination then
produce a nowhere-zero compatible rational tuple whose magnitude image has
strictly smaller cardinality.

`exists_stationaryWitness_of_rational_collision` invokes the repeated
positive-rational conjecture on that smaller magnitude image.  Its bound is at
least `1/m`, strictly above the desired `1/(m+1)` threshold, so an open torus
neighborhood transfers through orbit closure without losing the endpoint.
`BHKRealReduction.lean` handles the rational-collinear alternative, removes
coordinate signs, and composes all earlier equivalences to prove
`conjecture_iff_positiveIntegerConjecture`.  This completes the reduction but
does not prove the equivalent positive-integer conjecture.

Two further structured classes are proved in `docs/structured-classes.md`.
The first uses the explicit time determined by a positive base scale when
every normalized magnitude lies in one of a family of closed residue bands.
It is formalized as `LonelyRunner.minimumScaleResidueBands`, supported by
`circleNorm_neg`, `circleNorm_abs`, `circleNorm_ge_of_int_band`, and
`circleNorm_ge_of_abs_int_band`. The second treats two rational rank-one blocks
whose scales have irrational ratio and whose internal multiplier spreads are
small; it uses nonempty open good arcs and the exact two-torus density
criterion. The second result is not yet a Lean declaration and is not used by
any formal theorem in this manuscript.

For fixed positive integer tuples, `docs/modular-pivot-certificates.md`
develops exact finite bad sets on grids with denominator `(n+1)a_j`. The
purely finite implications are formalized as
`LonelyRunner.card_biUnion_le_sum_card`,
`LonelyRunner.exists_mem_avoiding_of_sum_card_lt_card`,
`LonelyRunner.card_union_le_card_add_selected_remainder`, and
`LonelyRunner.card_ordered_union_le_sum_selected_remainders`, followed by
`LonelyRunner.exists_mem_avoiding_ordered_of_sum_lt_card`. These prove that a
strict cardinality or ordered-overlap certificate leaves an uncovered finite
candidate.
The actual residue model and its connection to `circleNorm` are formalized by
`pivotCandidates`, `pivotBadResidues`, `card_pivotCandidates`,
`circleNorm_nat_div_ge`, and `pivotResidueWitness`. The exact gcd/ceiling
formula for individual bad-set sizes is formalized as
`card_pivotBadResidues_exact`, supported by the strict cyclic-ball and uniform
multiplication-fiber results in `LonelyRunner/PivotCounts.lean`. What remains
outside the kernel is the bounded search's selected-parent intersection data
and per-tuple certificate encoding.

Three further fixed-integer structural lemmas are audited in
`docs/round6-strategies.md`. First, every nonempty integer safe set has a
boundary witness on a pivot grid. This is now formalized in
`LonelyRunner/PivotBoundary.lean`: `continuous_minimumCircleNorm` and
`exists_boundary_witness` produce an active equality,
`boundary_time_eq_signed_grid` and `signed_grid_normalizes_to_pivotCandidate`
normalize both signs (including `N=2`), and `exists_safe_pivot_residue`
preserves every phase. With the exact bad-set equivalence from
`LonelyRunner/PivotResidues.lean`,
`exists_witness_iff_exists_pivot_certificate` proves the fixed-instance iff.
Finally, `positiveIntegerConjecture_iff_pivotCertificateConjecture` states the
same equivalence under all quantifiers of the positive-integer conjecture.
It neither proves the certificate proposition nor reduces real speeds to
integers.

Second, the global maximum of
`min_i ||a_i t||` occurs on a pair-sum grid `r/(a_p+a_q)`. Third, a runner can
be inserted over a common divisor of all other speeds when the exact orbit-size
inequality holds, conditional on lower-dimensional LRC. The third result is
formalized by `exists_int_grid_circleNorm_ge`,
`exists_int_coprime_grid_circleNorm_ge`, and
`codimensionOneDivisorInsertion` in `LonelyRunner/DivisorInsertion.lean`; the
pair-sum result remains a paper proof. These results clarify finite candidate sets and
an inductive arithmetic class but do not bound the speed height of a
counterexample.

## 5. Remaining obstruction

No audited route currently controls all primitive integer tuples in all
dimensions. Fast-runner induction leaves comparable speeds; finite checking
still requires a separate finite computation in every dimension; Fourier
methods do not reach the sharp constant; and the universal shifted-zonotope
strengthening is false. These are mathematical obstructions, not Lean syntax
issues. In particular, the two-parent modular certificate succeeds throughout
the audited primitive speed-30 boxes for 3--6 moving runners, but no theorem
forces such a certificate for unbounded speeds.

The fixed-pivot Fourier formulas are exact, but factorwise absolute
main-term domination is already non-necessary at `(1,2,3)` and depends on the
chosen algebraic factorization of the same good-count function. Thus a Fourier
completion would need signed cancellation, a positive-definite construction,
or a new arithmetic correlation theorem rather than a triangle inequality.

The two-parent pattern also stops being universal in the next audited box: it
fails for exactly two of the 1,716 residual eight-speed tuples through speed
15. Both failures admit three-parent certificates. Thus even the strengthened
half-parent rule remains only a computational conjecture.
