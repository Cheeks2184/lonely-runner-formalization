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

The arithmetic core of a pair-fiber count is now formalized independently in
`SimultaneousCongruence.lean`.  With `g=gcd(M,b,c)`,
`simultaneousCongruenceCompatible_iff_nonempty` proves that the two equations
`b*r=x` and `c*r=y` modulo positive `M` have a solution exactly when `g`
divides both targets and `c*x=b*y` modulo `M*g`.
`card_simultaneousCongruenceResidues` proves that a compatible fiber has
exactly `g` residues and an incompatible fiber is empty.  Congruence only
modulo `M` is insufficient, as `(M,b,c,x,y)=(8,2,4,2,0)` shows.  The remaining
pivot specialization is in `PivotPairFiberCounts.lean`.
`biUnion_pivotTargetFiber_eq_pivotBadResidues` decomposes a strict pivot bad
set into disjoint exact-target fibers without changing its open bad endpoint,
and `card_pivotTargetFiber_inter_pivotBadResidues` writes a target fiber's
overlap with a second bad set as the sum of candidate simultaneous-congruence
counts over the second strict target ball.  The raw natural-representative
count is also transferred from the exact gcd theorem.
`divisibleSimultaneousCongruenceNatResidues_eq_image` proves the explicit
`q -> N*q` image bijection for the divisible part, and
`candidateSimultaneousCongruenceCount_exact` subtracts its smaller-modulus
compatibility/gcd count from the raw count.  Finally,
`card_pivotTargetFiber_inter_pivotBadResidues_exact` substitutes this closed
expression into every strict-ball summand.  Thus pair-fiber evaluation is now
kernel-checked; no ordering or uniform overlap inequality is inferred from it.

`TripleCongruence.lean` supplies the next bounded-depth arithmetic layer.  For
three equations modulo positive `M`, it defines
`g=gcd(M,a,b,c)` and proves compatibility exactly when `g` divides all three
targets and all three pairwise cross congruences hold modulo `M*g`.
`tripleCongruenceCompatible_iff_nonempty` proves this is necessary and
sufficient, while `card_tripleCongruenceResidues` gives cardinality `g` in the
compatible branch and zero otherwise.  The proof includes an explicit
four-term Bézout construction and handles zero coefficients.  It evaluates
the raw triple congruence fiber needed by the repaired two-level anchor lane.
`PivotTripleFiberCounts.lean` completes the specialization.  Its explicit
`q -> N*q` image theorem subtracts the divisible smaller-modulus fiber;
`candidateTripleCongruenceCount_exact` gives the closed compatibility/gcd
formula for candidate residues; and the pair-target intersection theorem is
the exact cell interface needed by the repaired anchored construction.  None
of these theorems proves that a bounded anchor set always exists.

Finally, `docs/ranked-fiber-averaging.md` derives an exact random-order
identity for the one-level score.  If the possible-parent intersection sizes
inside one child fiber are sorted as `nu_1 >= ... >= nu_p`, the expected
credit is `sum_q nu_q/(q*(q+1))`.  The proof uses integer tail probabilities
and telescoping, so ties are harmless.  Literal permutation enumeration and
exact rational computations reproduce the identity and the documented hard
tuples.  This generic identity is currently `proved-math`, not yet
fully kernel-checked.  Its per-fiber core is formalized by
`average_rankedTailCredit`, and
`exists_code_cost_lt_of_rankedTailAverage` gives the corresponding strict
insertion-code witness.  Decoding those marginal insertion codes to one
shared permutation for all children and fibers remains unformalized.  Its
proposed arithmetic premise `RF-UNIF`--that some pivot
has ranked expected union bound strictly below its candidate count--is false.
The exact primitive tuple `(2,3,7,9,10,12,15,16,19)` fails it at every
pivot.  This does not reject the deterministic additive route: pivot `3` has
an optimized additive bound `25<27` and the explicit lonely time `7/30`.

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
gives the stronger ranked inequality `RF-UNIF`, now rejected by the exact
nine-speed tuple above because a favorable order can be much better than the
uniform-order average.  A still
coarser pairwise-average inequality is genuinely false at every pivot of
`(1,2,5,6,8)`, even though the ranked and optimized bounds both succeed at
pivot `5`.  The remaining gap is therefore an arithmetic construction of a
suitably biased or adaptive order, or a stronger bounded-depth overlap
certificate, not the generic finite union argument.

Four natural state-local adaptive rules are already insufficient at a fixed
pivot, even after optimizing globally over every tied choice; the exact
counterexamples are in `docs/adaptive-order-heuristics.md`.  A more structured
proposal assigns exponential-clock rate `gcd(a_i,(n+1)A)` to child `i`.
Tail probabilities give an exact rational expected credit, and exponential
memorylessness derandomizes it by choosing a nonincreasing conditional-
expectation branch.  The implementation checks that recurrence at every
step and repairs the first nine-speed uniform-average failure.  It is not
uniform: `(8,15,35,40,48,56,63,75,78)` makes the exact GCD-clock expected
cost exceed the candidate count at every pivot.  The closest failure is at
pivot `8`, with margin `-306535/6748764`.  Yet the deterministic order
`(75,48,40,15,78,35,63,56)` costs `70<72`, and `t=13/80` is an explicit
lonely witness.  Thus the counterexample rejects this fixed-rate law, not the
optimized additive route or LRC.  The algebraic derandomization core remains
valid and is now in Lean:
`exists_nextPotential_le_of_eq_weightedAverage` gives a nonincreasing branch
of any exact positive rational weighted average, and
`exists_removalOrder_terminalPotential_le` iterates the choice to a complete
duplicate-free order.  The exponential-clock tail formula and the exact
identification of the runner potential with that weighted recurrence remain
paper/computational interfaces, not hidden hypotheses of the Lean theorem and
no longer a candidate uniform completion under the GCD rates.

A subsequent targeted search found the simpler primitive fixed-rate failure
`(6,8,15,21,28,35,40,48,75)`.  Exact regression checks all nine negative
clock margins; at pivot `75` the same conditional-expectation greedy procedure
nevertheless yields deterministic cost `643<675`.  This strengthens the
rejection of the fixed expectation while leaving the optimized additive
principle unchanged.

One further state-dependent candidate uses two-sided one-item relocations of
an order.  `prefixDependentCost_relocate` proves the exact block identity for
any insertion cost depending only on the set of earlier entries, including
formal cancellation of every suffix term.  The finite theorem
`exists_cost_lt_of_decreasing_move` proves that if every order at or above the
candidate bound has a strictly cheaper allowed neighbor, then some order is
strictly below the bound.  Exact enumeration verifies this local-minimum
property on the recorded hard tuples only.  The arithmetic statement
`RELOC-UNIF` asserting an appropriate pivot for every tuple is open and is not
an assumption of either Lean theorem.

Sol Pro's first three-anchor formula was malformed: it left the target set and
the full anchor-fiber range undefined, so two advertised costs could not arise
from the then-stated construction.  After this objection, Response 27 repaired
the definition using the complete anchor residue partition.  Strict-target
subfibers are covered by the anchor; complementary subfibers credit the best
other fixed anchor.  This is precisely the sound construction already proved
in `TwoLevelFiberCredits.lean`.  Independent exact recomputation reproduces all
six repaired tables, including totals `70<72` and `48<54` on the two
fixed-clock failures.
`exists_mem_avoiding_of_twoLevelFiberCredit_sum_lt_card_of_parent_subset`
then gives the generic ordered-union certificate with an explicit condition
that every selected parent is earlier.  This formally justifies ignoring
previous nonanchors for each tail child.  The statement that three anchors
always suffice was still open at that stage; it is now rejected by the exact
tuple and audit recorded below. Full definitions and the repaired Response 27
tables are in `docs/response26-audit.md`.

Response 28 further averages over the choices of second and third anchors.
For a first anchor `h`, its score `Xi_j(h)` combines its pair degree, the
average exact second-anchor gain, and the conditional average third-anchor
gain.  If `Xi_j(h) > S_j-n*A`, two successive average arguments select a
three-anchor certificate.  Independent exact computation verifies the
identity, nonnegative third gain, all six rational stress rows, and the
zero-target divisor/cross-pivot formulas.  No failure appears in the recorded
complete primitive boxes through `(runners,maxSpeed)=(4,12),(5,15),(6,12)`.
This is finite evidence only.  `ANCHOR-STAR-UNIF` is stronger than the already
then-open three-anchor assertion. Its uncontrolled term was the average
nonzero-target triple compatibility gain. The later exact counterexample
below rejects both this uniform premise and the stronger dispersion closure.
See `docs/anchor-star-audit.md`.

The finite selection part of this argument is now kernel-checked in
`AnchorStarAveraging.lean`. `exists_secondaryAnchors_of_anchorStar_gt` turns
an exact ordered-pair average below a strict threshold into two distinct
secondary choices. `exists_threeDistinctAnchors_of_anchorStar_gt_of_card`
adds an eligible fixed first anchor and proves that all three returned anchors
belong to the eligible set and are pairwise distinct. These theorems assume
the concrete average identity and strict star inequality; they do not assume
their uniform arithmetic validity.

The remaining third-anchor term has also been narrowed mathematically. For a
fixed pivot and first anchor, partition each child bad target fiber by the full
first-anchor image. On every nonbad first-anchor cell `C`, let `c_q(C)` be its
intersection count with a possible second anchor `q`. Exact two-anchor credit
equals literal coverage by the two anchors. When a third anchor is added, the
growth of the prefix union cancels exactly with removal of that anchor's old
tail cost. Continuing to distinguish the first anchor therefore increases the
credit on `C` by at least `(c_r(C)-c_q(C))_+`. Summing both orientations of
every unordered pair gives `|c_q(C)-c_r(C)|`, with no factor of two. Thus the
averaged gain satisfies `Gamma_j(h) >= Delta_j(h)`, where `Delta` is the
normalized cellwise profile dispersion. Every profile value is a strict-ball
sum of `candidateTripleCongruenceCount`, so the obstruction is an explicit
gcd/congruence expression rather than informal compatibility mass. An
independent implementation exhaustively checked arbitrary finite-set models
and direct modular instances. `AnchorStarDispersion.lean` kernel-checks the
reusable local ingredients: exact two-parent cell coverage, the positive-part
to maximum identity, both orientations to symmetric dispersion, additive
cost cancellation without unsafe natural subtraction, and ordered-average
monotonicity. The concrete modular global cancellation and cell reindexing
are not yet formalized. The proposed uniform conclusion is nevertheless now
refuted computationally: for `(8,15,35,40,48,56,68,75,78)`, exact literal
enumeration gives a negative best pair-part-plus-`Delta` margin at every
pivot. See `docs/gamma-arithmetic-audit.md` and the range-sum audit. This
rejects the stronger sufficient condition, not the sound `Gamma >= Delta`
lemma and not the Lonely Runner Conjecture.

A second compression keeps the profile minimum, maximum, and sum. Choosing
one minimum and maximum contributes `(r-1)(max-min)` to pairwise `L1`; after
removing them, integer balancing of the remaining fixed-sum entries contributes
the residue energy `eta*(r-2-eta)`. This `w(c)` lower bound equals exact
profile dispersion through length three, hence through six runners, and its
normalized `W_j(h)` remains strictly sufficient on all mandatory stress
rows. It is not exact in general: at pivot `18`, anchor `4` of
`(2,4,8,16,18,26,27)`, two profiles `(0,2,2,0)` cause
`Delta-W=1/5`. The nine-speed tuple above strictly refutes the resulting
`RANGE-SUM-STAR-UNIF` premise as well.

The reusable algebraic core is partly kernel-checked in
`ResidualVariationEnergy.lean`. In particular,
`pairMultiplicityContribution_num` proves the denominator-free pointwise
multiplicity identity, `residueEnergy_sum_mod_le` proves modular energy
balancing, and `rangeProfileDispersion_eq` proves the exact min/max endpoint
contribution. `rangeSumProfileLowerBound_of_cutDecomposition` is deliberately
conditional on an explicit cut decomposition; existence of the standard
layer-cake cuts and their exact internal-`L1` energy identity remain
paper-level obligations, so Lean does not yet assert the unconditional
range-sum profile theorem.

The exact fixed-row debt algebra is separately kernel-checked in
`ResidualVariationDebt.lean`. The declaration
`fixedRow_pairDeficit_add_binary_eq_neg_debt` proves the pointwise polynomial
identity after clearing denominators; its finite-sum version and
`fixedRowCellLoss_nonneg` handle aggregation and the compression loss.
`fixedRow_debt_loss_decomposition` exposes, rather than assumes away, the two
application hypotheses identifying the pair numerator and reindexing exact
cell dispersion by point multiplicity. Proving those hypotheses for the
concrete modular cells, then splitting the polynomial sum into uncovered and
restricted debt terms, remains a formal proof obligation.

The first-anchor-averaged pair term also has an exact multiplicity formula:
uncovered candidate residues contribute positively, while points belonging to
an intermediate number of bad sets contribute an explicit cubic deficit.
Integer balancing and quadratic energy provide valid lower bounds for the
cell dispersion, but their combined profile-free closure fails at every pivot
of the first fixed-clock tuple, with best margin `-2/3`. Full `Delta` repairs
that row to `4/21`. Common scaling of all speeds is exactly homogeneous and
permits primitive normalization; signed residue normalization is valid only
at a fixed pivot. Deletion is not monotone even for a fixed speed-valued row:
the RF example changes from `42/5` after deleting speed `2` to `-41/7` in the
full tuple. These exact failures delimit the surviving cross-pivot problem.

The strict counterexample audit also separates the nested certificate
schemes. All best `ANCHOR-STAR`, `DISPERSION-STAR`, and `RANGE-SUM-STAR`
margins for `(8,15,35,40,48,56,68,75,78)` are negative. Nonetheless, at pivot
`15` the three anchors `(35,48,75)` have corrected two-level cost `133 < 135`,
and at pivot `35` an optimized additive order has cost `285 < 315`. The tuple
also has the direct lonely-runner witness `t=1/30`. Thus the audit closes the
three averaging premises without refuting any later scheme.

Fixed three-anchor selection is not uniform either. For
`(10,37,45,51,54,56,61,71,91)`, independent literal enumeration of all
`9*choose(8,3)=504` corrected triple costs gives per-pivot minima

```text
92/90, 333/333, 407/405, 461/459, 492/486,
504/504, 553/549, 645/639, 827/819,
```

where each fraction is minimum cost over strict threshold. Equality at pivots
`37` and `56` is still failure because the avoidance theorem requires strict
cost `< n*a_j`. Direct enumeration of all one- and two-anchor sets also finds
no rescue. Abstractly, `twoLevelFiberCredit_mono_parents` and
`boundedAnchorCost_insert_le` prove in Lean that enlarging a sound anchor set
cannot increase its bounded cost. Instantiating these generic declarations
with the concrete modular target-fiber data still requires the existing
saturation/decomposition bridge. Nevertheless, at pivot `10` the adaptive full order
`(45,56,37,51,54,61,71,91)` has insertion costs
`(10,16,12,10,12,8,6,10)`, totaling `84 < 90`, and `t=3/100` is a direct
lonely time. Thus `3-ANCHOR-UNIF` is rejected while optimized additive
ordering, the exact pivot-certificate theorem, and LRC remain open.

The remaining optimized additive cost has an exact graph interpretation. For
each nonempty bad child-target fiber `(i,x)`, make a token whose possible
parent `p` has weight `|F_i(x) intersect B_p|`. A selector chooses at most one
parent per token. An order produces an acyclic selector by choosing a
maximum-weight earlier parent; conversely, a topological order of any acyclic
selector earns at least its selected weight. Therefore

```text
minimum additive order cost
  = S_j - maximum weight of an acyclic fiber-parent selector.
```

The abstract finite equivalence is kernel-checked in
`AcyclicFiberSelector.lean`. `exists_acyclicSelector_with_weight_eq_orderCredit`
constructs tokenwise maximizers from an order;
`exists_order_with_selectorWeight_le` refines an acyclic rank and realizes a
selector in an order; and
`exists_orderCredit_ge_iff_exists_acyclicSelectorWeight_ge` states the exact
threshold equivalence. `ModularAcyclicSelector.lean` supplies the concrete
finite-optimization instantiation. Its token type pairs a nonpivot child with
every strict target; empty fibers merely have zero weight. `modularFiberWeight` is exactly the
cardinality of the candidate-filtered child fiber intersected with the
parent's strict bad set. `orderedTokenCredit_modular_eq` and
`orderCredit_modular_eq_fiberCredit_sum` identify the abstract and modular
credits, while
`exists_modularOrderFiberCredit_ge_iff_exists_acyclicSelectorWeight_ge`
specializes the threshold equivalence. Candidate exclusion and strict target
endpoints are inherited from `pivotTargetFiber` and `strictCyclicBall`.
The remaining deterministic application plumbing is now kernel-checked.
`vertexOrderAt_eq`, `image_range_vertexOrderAt_eq_predecessors`, and
`fiberCredit_modularOrdered_eq_selectedEarlierParentFiberCredit` enumerate the
order and identify every earlier prefix. Fiber decomposition, disjointness,
and natural-subtraction bookkeeping feed
`exists_pivotCandidate_avoiding_of_modularOrderFiberCredit`, while
`exists_real_witness_of_modularOrderFiberCredit` produces the corresponding
real time. Its hypotheses explicitly include `N>0`, positive speeds, a
nonempty nonpivot type, and the strict cost bound. It does not assert that a
suitable pivot and order always exist.

This preserves the single-parent-per-fiber rule and is not the earlier
tautological union/Hall relaxation. Restricting each positive token to one of
its globally best parents gives total weight `F_top`. For a top selector, let
`tau_top` be the least aggregate weight of backward edges over all vertex
orders, minimized over choices among top-parent ties. Removing those edges
and topologically ordering proves

```text
minimum additive cost <= S_j - F_top + tau_top.
```

Hence `tau_top < F_top-(S_j-n*a_j)` is sufficient; equality is not. The exact
top-only subset recurrence must maximize over the last child `i` and add the
weights of its tokens whose top-parent set meets the predecessor state. The
short recurrence in Sol Response 33 omitted that outer maximum and state
subtraction; the audit records the corrected formula.

The top-only condition is not uniform. For the primitive tuple

```text
(5,28,35,40,68,88,108,148,165),
```

the top-only costs minus their strict thresholds are
`(0,6,0,2,12,18,10,32,4)`. Hence no pivot satisfies the strict condition;
equality at pivots `5` and `35` is still failure. Two independent literal
residue/fiber implementations reproduce every row. One also exhaustively
enumerates all `8!` vertex orders at every pivot. This proves the finite
counterexample to `TOP-CYCLE-UNIF`, not a counterexample to the conjecture.

Indeed, lower-ranked rescue separates the two objectives. At pivot `28`, the
top-only cost is `258 >= 252`, but unrestricted additive cost is `250 < 252`.
The candidate `r=6` corresponds to `t=3/140`; the distance numerators modulo
`280` are `(30,112,70,40,128,32,88,48,130)`, all at least `28`.
Consequently unrestricted optimized additive uniformity and LRC remain open.
For every fixed order the exact identity

```text
D(o) = S - F_top + L_top(o) - R(o)
```

measures the lower-ranked rescue `R`. The prefix-conditioned bound in
`docs/top-parent-rescue-audit.md` interpolates exactly from tie-aware random
ordering to the full top-only DP, but its endpoint cannot evade this
counterexample.

The unrestricted loss itself has a tie-safe threshold-layer expansion. For a
token `e` of maximum parent weight `W_e`, make one unit layer for every natural
`q<W_e`, supported by

```text
P_(e,q) = {p : q < w_e(p)}.
```

For any earlier-parent set, its maximum weight is exactly the number of
supported layers it meets. Thus a token's lost credit is exactly the number
of its layers having no earlier parent, including the empty-earlier case;
zero-weight tokens create no layers. If `Q` is the unplaced vertex set, define

```text
delta_i(Q) = sum_(e owned by i) (W_e - max_(p outside Q) w_e(p)).
```

Repeatedly removing vertices from `Q` gives the exact unrestricted loss as
the sum of their `delta` values. This is the unrestricted Bellman recurrence,
not a relaxation. It yields a budgeted peeling theorem and a necessary
critical-soft-core condition for any failing pivot. A core of minimum deficit
`lambda` also contains `lambda` edge-disjoint cycles in the labelled directed
multigraph of threshold supports; parallel labelled layers are retained.

Conditioning on a prefix and topologically ordering the SCC condensation of
the active support graph gives a stronger certified bound `B_core`. Cross-SCC
layers are certainly satisfied, while loss inside each SCC may be bounded by
random order or computed exactly. The layer identity was independently checked
on 4,328 tokens and 537,700 predecessor subsets. For the tuple above at pivot
`28`, prefix `(35,40,88)` has loss `24`; the residual SCC loss is `14`, so
the full soft loss is `38<40` and the resulting additive cost is `250<252`.
All eight prior stress rows pass `B_core` with at most one prefix vertex.

This exact full-weight model still does not prove uniformity. At pivot `148`
of the same tuple, the soft optimum is `264`, above its strict budget `262`;
and no arithmetic argument forces some other pivot to admit a sufficiently
cheap SCC prefix for every primitive tuple. The remaining obligation is the
cross-pivot modular incidence inequality, not the threshold expansion itself.

The reusable finite layer algebra is kernel-checked in
`SoftFeedbackLayers.lean`. In particular,
`orderedTokenCredit_eq_card_metOrderUnitLayers` proves the tie-safe threshold
count, `tokenPotential_eq_orderedTokenCredit_add_card_trapped` and
`orderPotential_eq_orderCredit_add_orderSoftLoss` give the exact loss
identities, and `exists_peelingList_of_localBudget` with
`exists_criticalCore_of_budget_lt_every_peeling` formalizes budgeted peeling
and its core contrapositive. Inducing a `VertexOrder` from the generic complete
peeling list and instantiating its deficit with the modular fibers remain
separate Lean obligations.

A stronger finite bound keeps three consecutive choices on one nested chain.
For `Q` and `k<=|Q|`, let `g_k(Q)` minimize the total external deficit along
an ordered deletion of `k` distinct vertices from `Q`, and let
`b_k(q)=max_(|Q|=q) g_(min(k,q))(Q)`. Removing optimal blocks gives

```text
B_k(m) = sum_(q=m,m-k,m-2k,...>0) b_(min(k,q))(q).
```

Every block is an actual deletion segment, so this is a sound order bound.
Successively bounding each step by the worst minimum at its current
cardinality proves `B_k<=B_1`; strict improvement is possible because one
block must follow a single nested chain. An independent exhaustive subset
verifier reproduces all recorded rows. At `E` pivot `165`,
`(B_1,B_2,B_3,opt)=(259,219,187,165)` against strict budget `211`.
The uniform conclusion is nevertheless false. For

```text
F=(8,15,35,40,48,56,75,132,147),
```

the exact pivotwise margins are
`B_3-beta=(2,1,6,16,50,24,0,96,72)`. Hence no pivot satisfies the required
strict inequality; equality at pivot `75` is not enough. Two independent
literal implementations reproduce all rows. This is only a failure of the
three-step sufficient condition: pivot `15` has unrestricted optimized
additive cost `131<135`, and the exact time `13/80` is lonely. The unresolved
finite target is therefore unrestricted optimized additive uniformity, with
the exact pivot-certificate proposition still strictly stronger at a fixed
pivot.

The generic repeated-block implication is kernel-checked in
`BlockPeeling.lean`. It tracks valid prefixes and exact remaining sets, forces
each block to have length `min(k,|Q|)`, and proves both non-strict and strict
global loss bounds from their corresponding local block hypotheses. The
strict theorem makes nonemptiness explicit. A separate equality theorem shows
that blocks which merely regroup descending one-step bounds have exactly the
ordinary peeling budget. These declarations validate the finite deduction
used above; they do not assert the rejected cross-pivot arithmetic premise.

The independent unrestricted search also completely checks every increasing
ten-speed tuple through maximum `22`: `646,646` tuples total, `646,635`
primitive, no all-pivot additive failure, and minimum best margin `+4` on
fourteen tuples. This finite result has no unbounded consequence.

The companion relocation calculation is also exact. If `F` is achieved
credit, `F_infinity` is full all-parent credit, `R_k` is nonnegative
later-parent redundancy, and `s_k` is the cost change when item `k` moves to
the front, then

```text
2*F = F_infinity + sum_k R_k + sum_k s_k.
```

At a move-to-front local minimum of cost, every `s_k` is nonnegative, but the
stress rows show that discarding these slacks is too weak. Fixed-pivot signed
residue replacement also preserves the complete additive objective. A valid
global minimal-counterexample descent needs global scaling invariance and a
simultaneous smaller signed representative for one coordinate across every
other pivot modulus; such a representative need not exist.
