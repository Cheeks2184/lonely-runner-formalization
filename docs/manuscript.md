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
positive-integer formulation.  It is a definition, not an assumption; the
equivalence with the canonical real-speed statement is proved in Section 4.

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

Second, a candidate time on a pair-sum grid `r/(a_p+a_q)` is encoded by
`PairSumCertificate`.  `pairSumCertificate_iff_pair_time` proves its exact
equivalence with the corresponding circle inequalities, including the closed
boundary, and
`positiveIntegerPairSumCertificateConjecture_imp_positiveIntegerConjecture`
proves that universal existence of such certificates would imply the
positive-integer conjecture.  Universal existence remains open; exact small
counterexamples reject four restricted pair-selection rules without rejecting
unrestricted pairs.  Third, a runner can be inserted over a common divisor of
all other speeds when the exact orbit-size inequality holds, conditional on
lower-dimensional LRC. The third result is
formalized by `exists_int_grid_circleNorm_ge`,
`exists_int_coprime_grid_circleNorm_ge`, and
`codimensionOneDivisorInsertion` in `LonelyRunner/DivisorInsertion.lean`.
These results clarify finite candidate sets and an inductive arithmetic class
but do not bound the speed height of a counterexample.

The current induction branches are synthesized in
`LonelyRunner/IntegerInduction.lean`. For an appended positive natural speed,
`exists_appended_witness_of_integerInsertionCover` proves that any of fast
insertion, divisor insertion, the minimum-scale bands, or an uncovered pivot
candidate yields a witness, assuming the previous dimension where required.
The finite obstruction `AllPivotCandidatesCovered` is exactly negated by
`PivotInsertionCase`. Strong induction then proves
`positiveIntegerConjecture_of_divisorOrUncoveredPivotPrinciple`, and the
converse supplied by pivot completeness gives
`positiveIntegerConjecture_iff_divisorOrUncoveredPivotPrinciple`. This is an
exact map of the residual integer obstruction, not a proof of it. The finite
audit and the first counterexample `(1,3,4)` to exhaustiveness of the three
non-pivot structural branches are documented in
`docs/integer-induction-cover.md`.

The finite overlap layer has three additional kernel-checked interfaces.
`HallCredits.lean` proves the exact finite capacitated Hall criterion and
sound ordered-union overlap allocation; bounded arithmetic examples show that
small cut sizes do not replace the full cut family.  `FiberCredits.lean`
partitions a child bad set into disjoint target fibers and, in each fiber,
credits only the largest intersection with one earlier parent.
`fiberCredit_le_card_inter_biUnion` proves that these credits never
double-count, and `exists_mem_avoiding_of_fiberCredit_sum_lt_card` converts a
strict sum of net insertion costs into an uncovered pivot candidate.
`TwoLevelFiberCredits.lean` refines each child fiber by an anchor parent;
`fiberCredit_le_twoLevelFiberCredit_le_card_inter_biUnion` proves that the
anchored score dominates the one-level score and remains below the true
overlap.  None of these generic set-system theorems supplies the missing
uniform modular inequality.

Finally, `docs/ranked-fiber-averaging.md` derives an exact random-order
identity for the one-level score.  If the possible-parent intersection sizes
inside one child fiber are sorted as `nu_1 >= ... >= nu_p`, the expected
credit is `sum_q nu_q/(q*(q+1))`.  The proof uses integer tail probabilities
and telescoping, so ties are harmless.  Literal permutation enumeration and
exact rational computations reproduce the identity and the documented hard
tuples.  This generic identity is currently `proved-math`, not yet
kernel-checked.  Its proposed arithmetic premise `RF-UNIF`--that some pivot
has ranked expected union bound strictly below its candidate count--is open.

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

The strongest surviving overlap route is the optimized additive one-level
fiber certificate.  Exact subset dynamic programming finds no failure in the
documented complete boxes through ten speeds or in the larger deterministic
samples, but no ordering theorem proves this for all tuples.  Random ordering
reduces it to the stronger, falsifiable ranked inequality `RF-UNIF`; this too
has no bounded counterexample in the recorded search and no proof.  A still
coarser pairwise-average inequality is genuinely false at every pivot of
`(1,2,5,6,8)`, even though the ranked and optimized bounds both succeed at
pivot `5`.  The remaining gap is therefore arithmetic control of ranked
simultaneous congruence counts across at least one pivot, not the generic
finite union argument.
