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

One further state-dependent candidate used two-sided one-item relocations of
an order.  `prefixDependentCost_relocate` proves the exact block identity for
any insertion cost depending only on the set of earlier entries, including
formal cancellation of every suffix term.  The finite theorem
`exists_cost_lt_of_decreasing_move` proves that if every order at or above the
candidate bound has a strictly cheaper allowed neighbor, then some order is
strictly below the bound.  The uniform arithmetic premise is false.  On the
clean-room OPT-ADD counterexample
`G=(15,21,40,48,56,105,126,280,1200)`, the exact global minimum additive cost
is at least the candidate bound at every pivot.  Every global minimum is
automatically a two-sided relocation-local minimum.  An independent
regression evaluates the displayed optimal orders in the relocation tables
and obtains minimum move delta zero in every row.  This rejects
`RELOC-UNIF`, while both generic Lean theorems remain valid.  The tuple has a
direct lonely witness, so it is not an LRC counterexample.

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
At this stage unrestricted optimized additive uniformity remained open; the
later counterexample below rejects it while leaving LRC open.
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
target at this stage was unrestricted optimized additive uniformity, with the
exact pivot-certificate proposition still strictly stronger at a fixed pivot.

The generic repeated-block implication is kernel-checked in
`BlockPeeling.lean`. It tracks valid prefixes and exact remaining sets, forces
each block to have length `min(k,|Q|)`, and proves both non-strict and strict
global loss bounds from their corresponding local block hypotheses. The
strict theorem makes nonemptiness explicit. A separate equality theorem shows
that blocks which merely regroup descending one-step bounds have exactly the
ordinary peeling budget. These declarations validate the finite deduction
used above; they do not assert the rejected cross-pivot arithmetic premise.

For one fixed pivot, the full Bellman optimum has an exact subset-DAG flow
dual. Give every arc `Q -> Q\{i}` its external-deficit cost `delta_i(Q)`.
Unit flows from the full set to the empty set decompose into weighted order
paths, so their minimum cost is the optimized soft loss `Lambda*`. After
normalizing `y_empty=0`, the dual constraints are

```text
y_Q - y_(Q\{i}) <= delta_i(Q).
```

Every feasible potential telescopes below the cost of every order, while the
Bellman value function is feasible and attains `y_full=Lambda*`. Thus
fixed-pivot success is exactly `Lambda*<beta`, and failure is exactly a
feasible potential with top value at least `beta`. This exposes the remaining
quantifier issue: all-pivot failure would provide a different feasible
potential for every pivot modulus, with no canonical shared dual object.
`BellmanPeeling.lean` kernel-checks the potential weak duality, exact recursive
optimum, feasibility, attainment by a complete order, minimum-order
characterization, and greatest-feasible-potential theorem. The flow language
is an equivalent human-readable reformulation; no linear-programming axiom is
imported.

The most direct linear cross-pivot closures already fail on `F`. Its optimized
margins `beta-Lambda*` are

```text
(0,4,16,-6,-30,-18,40,-54,-27).
```

Their unweighted sum is `-75`. With `ell=lcm(F)=646800`, the natural common
subgroup-density weighting gives `sum (ell/a_j)M_j=-279450`, equivalently
`sum M_j/a_j=-1863/4312`. A viable common-modulus inequality must retain
nonlinear correlations among subgroup intersections and pivot-dependent
Bellman choices.

An exact finite search around `F` checked five exhaustive domains: 2,619
single replacements through speed 300, 3,428 valid two-coordinate radius-5
perturbations, 5,376 three-coordinate radius-2 perturbations, 291 one-speed
extensions, and all nine deletions. No all-pivot optimized-additive failure was
found; the smallest best-pivot surplus was `+16`. The counts are per defined
domain and may overlap, and the result has no unbounded consequence.

The unrestricted additive uniform statement is nevertheless false. The
primitive tuple

```text
G=(15,21,40,48,56,105,126,280,1200)
```

has optimized additive surpluses

```text
(0,-31,0,-32,-2,-2,-62,-48,-24)
```

in pivot order. Hence every pivot is nonstrict; equality at pivots `15` and
`40` still fails the required strict inequality. Two independent exact
implementations reproduce every `(S,F*,soft optimum,Dopt,9A)` row. A
clean-room literal oracle also enumerates all `8!` orders per pivot, for
`362,880` pivot-order pairs total, and agrees with the subset DP.

This is not a counterexample to the exact pivot certificate or LRC. At pivot
`48`, residue `39` corresponds to `t=39/480=13/160`. Its circular-distance
numerators modulo `480` are

```text
(105,141,120,48,216,225,114,120,240),
```

all at least `48`. The closed `1/10` boundary is attained by speed `48`.
`OptAddCounterexample.lean` kernel-checks this exact witness. Thus the live
finite target is now the exact pivot-certificate proposition, already proved
in Lean equivalent to the positive-integer conjecture.

There is a direct fixed-pivot certificate strictly stronger than additive
ordering. Partition each bad set into target fibers and select whole
fiber-parent intersections, at most one parent per token. If the number of
selected blocks using residue `r` is at most its duplicate-incidence capacity
`mu(r)-1`, summing the exact identity

```text
S - |union B_i| = sum_r (mu(r)-1)_+
```

over bad residues proves that total selected credit is at most the available
overlap debt. Every additive order induces a legal acyclic packing, but the
capacity condition also permits directed cycles. On `F` at pivot `8`, an
independent literal audit verifies 24 whole blocks with credit `34`, exceeding
the additive credit `32`. It proves

```text
|union B_i| <= 104 - 34 = 70 < 72;
```

the literal union size is `68`, with good residues `13,29,51,67`. This is a
genuine fixed-pivot separation, but a literal capacity audit already contains
enough residue information to find a witness directly. Its unbounded value
would require a symbolic CRT theorem constructing such a packing.
`OverlapCapacity.lean` kernel-checks the two incidence double counts, the
subtraction-free union-plus-credit inequality, its natural-subtraction
corollary, and an abstract ordered-parent route to the pointwise capacity.

The exact packing optimization is a multiple-choice hypergraph `b`-matching:
choose at most one whole parent block per token and respect every residue
capacity. Its linear relaxation is not integral in general. With unit
capacities and blocks `{a,b}`, `{b,c}`, and `{c,a}`, the integer optimum is
`2` while taking half of every block has fractional value `3`. Ordinary
max-flow is therefore exact only in special cases such as singleton blocks;
splitting a nonsingleton block into independent residue flows illegally trims
the arithmetic block. Any uniform result must obtain additional balanced or
integral structure from the congruence cosets themselves.

A reproducible componentwise integer packer gives rigorous initial evidence
for this stronger route. For `G`, a replayed pivot-`56` packing has credit
`400>392`; pivots `105` and `1200` also have strict replayed witnesses. Exact
optima are proved at pivots `15`, `21`, `40`, `48`, and `126`; the remaining
hard rows are reported only as certified lower/upper intervals. The same audit
finds a strict packing pivot for each of eleven fixed tuples (`F`, `G`, and
nine earlier stress cases). Its pruning is independently checkable: nonbinding
residue elimination, conflict-component decomposition, combinatorial upper
bounds, a grid LP-dual upper bound, and memoization all preserve validity, and
every lower-bound solution is replayed against the literal blocks and
capacities. This finite collection does not imply a uniform theorem.

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

## 23. A common-LCM correlation certificate

For positive distinct integer speeds `a_1,...,a_n`, set `N=n+1`, let `ell`
be their least common multiple, and use the common modulus `L=N*ell`. The
pivot-`j` candidate `r` embeds as `(ell/a_j)r` modulo `L`. Denote the image
slice by `C_j`. At `s` in the common group, let `d(s)` count the slices `C_j`
containing `s` and let `k(s)` count the strict bad-runner conditions.
Injectivity of every embedding gives the exact finite identity

```text
sum_j (# safe candidates at pivot j)
  = sum_s d(s) * 1[k(s)=0].
```

For positive depth `d`, define the low moments
`H_q=sum_s d(s) C(k(s),q)`. On any point with `d(s)>0`, the pivot runner for
one containing slice is automatically good, so `k(s)<=n-1`. Points with
`d(s)=0` contribute zero. The relevant polynomial is therefore bounded by
the zero indicator because, for `1<=k<=n-1`,

```text
(n-1) * sum_(q<2d) (-1)^q C(k,q) + 2d*C(k,2d)
  = -(n-1-k) C(k-1,2d-1) <= 0.
```

The exact Lean correspondence is:

- `alternatingChoosePrefix_succ`: alternating-binomial prefix identity;
- `correlationPolynomial_cleared_eq`: the displayed cleared equality;
- `correlationPolynomial_cleared_nonpos`: its signed consequence;
- `correlationPolynomial_zero`: the separate zero case;
- `correlationPolynomial_le_zeroIndicator`: the division-safe rational bound.

These declarations formalize only the universal algebraic kernel. They do not
assert the common-LCM combinatorics or the Lonely Runner Conjecture. The
independent exact audit gives `L_(9,2)=3305/2>0` on `G`, but its full histogram
also contains the desired safe count. At depth `2d>=n-1`, the formula becomes
exact inclusion--exclusion. A general proof still requires direct CRT
formulas and estimates for low moments at a non-tautological depth.

## 24. One-directional signed-divisor descent

Let the `k`th speed be `a_k=q*b`, with `0<b<a_k`, `gcd(q,N)=1`, and the
replacement preserving positivity and distinctness. Assume additionally that
for each unchanged pivot `a_j`, the new speed is congruent to either `a_k` or
`-a_k` modulo `N*a_j`. The strict bad sets on every unchanged pivot then
agree. If `r` certifies the changed pivot `b`, the numerator `q*r` certifies
the old pivot `a_k`: candidate exclusion is preserved by coprimality and the
represented time is unchanged. Hence a certificate for the replaced tuple
implies a certificate for the original tuple.

Only the unchanged pivots are equivalent in both directions. The changed
pivot transport has no proved reverse because an arbitrary old numerator need
not be divisible by `q`. The rule supports a valid minimal-counterexample
contrapositive, but no theorem yet forces such a replacement. The exact audit
checks `(1,2,3,24)->(1,2,3,6)` and finds no eligible replacement in `G`. This
section currently has no Lean declaration and is not used by the formal
equivalence chain.

## 25. Direct generalized-CRT formulas for the moments

The moment formula itself need not pass through the full bad-multiplicity
histogram. Expanding `C(k(s),q)` as the square-free sum over `q`-element
runner-index subsets and then expanding slice multiplicity gives

```text
H_q = sum_j sum_(|I|=q) T(j,I),
```

where `T(j,I)` counts pivot-`j` candidates simultaneously bad for every
runner in `I`. For pivot speed `A`, modulus `M=N*A`, and runner `i`, the strict
bad ball is the disjoint set of targets `h` with `-(A-1)<=h<=A-1`. Solving
`a_i*r=h (mod M)` reduces by `gcd(a_i,M)` to disjoint classes. A vector of
these classes has a common solution exactly under the generalized pairwise
CRT compatibility conditions. Its class count modulo `M` is `M/m_I`, where
`m_I` is the lcm of the reduced moduli. Intersecting once more with
`r=0 (mod N)` gives the exact number of excluded pivot multiples, which is
subtracted. Empty subsets give `n*A`, a subset containing the pivot gives
zero, and repeated numerical speeds remain separate indices.

The standalone exact evaluator gives

```text
(H_0,H_1,H_2,H_3,H_4)
  = (17019,27432,18203,7492,2709)
```

for `G` without constructing a safe set or `D_0`. An independent literal
pivot-grid sum verifies the same values but is used only as an audit.

The finite summation kernel is formalized abstractly as follows:

- `sum_card_zeroCandidateSlice_eq_weighted_zero_count` proves the exact
  slice-incidence double count;
- `cast_sum_card_zeroCandidateSlice_eq_weightedZeroIndicatorSum` casts it to
  the rational form used by the polynomial;
- `weightedStatisticSum_le_weightedZeroIndicatorSum` proves the summed
  inequality while requiring `count<=n-1` only where the weight is positive;
- `weightedCandidateStatisticSum_le_cast_sum_card_zeroCandidateSlice`
  combines the two steps.

These Lean declarations are arithmetic-agnostic. The generalized-CRT term
formula is proved and independently computed but is not yet formalized in
Lean.

## 26. Infinite obstructions to prescribed correlation depth

Consider the consecutive tuple `A_n=(1,...,n)`. A time is lonely for all its
speeds exactly when it is `m/(n+1)` with `gcd(m,n+1)=1`: the `n+1` points
`0,t,...,n*t` must have all circular gaps at least `1/(n+1)`, hence all gaps
are equal. Every such time occurs once on each pivot grid, giving total safe
incidence `n*phi(n+1)`.

At pivot `j`, the two candidate residues `+1` and `-1` have bad multiplicity
exactly `j-1`. Retaining only these nonpositive polynomial terms and applying
a weighted hockey-stick identity yields

```text
L_(n,d)(A_n)
  <= n*phi(n+1) - (2/(n-1))*C(n-1,2d+1).
```

For every fixed positive `d`, the binomial term eventually dominates on an
infinite congruence class, so the lower bound is strictly negative infinitely
often. More strongly, if `n congruent to 59 mod 60` and `d=(n-3)/4`, the
central-binomial lower bound makes the score negative for every such `n`.
Nevertheless `t=1/(n+1)` is an explicit lonely time for every consecutive
tuple. Thus fixed depth and this linear sub-tautological rule are genuinely
rejected as sufficient strategies; LRC is not.

The arithmetic histogram construction and infinite number-theoretic
consequences remain human-checked and exact-computation-checked. The formal
files establish the polynomial, weighted summation, hockey-stick, and abstract
cleared-histogram kernels used in the proof.

## 27. Optimal fixed-order moment certificates

Fix moment order `r` and write a candidate polynomial in the binomial basis,

```text
P(k)=sum_(q=0)^r c_q C(k,q).
```

The strongest zero-indicator lower bound using only these moments is the
finite LP maximizing `sum_q c_q H_q` subject to `P(0)<=1` and `P(k)<=0` for
`1<=k<=n-1`. Its dual minimizes the zero mass of a nonnegative
pseudo-histogram matching `H_0,...,H_r`. Pseudo-histograms need not be
arithmetically realizable; they certify only what the numerical moments can
force.

Every nonzero primal vertex has `P(0)=1` and exactly `r` positive integer
roots. Sign feasibility forces the first root to be 1, every interval where
the sign would otherwise be positive to be closed by adjacent roots, and the
last root to be `n-1` in even degree. This classifies the exact finite search.
Complementary dual masses on the active roots independently certify every
reported positive optimum.

For the stress tuple `G`, roots `(1,3,4)` give the degree-3 value `6061/6`;
at pivot 56 alone they give `38/3`. T10 and T11 first become positive by
degree 5 among the checked orders, with values `29/9` and `59/9`. These improve
the fixed Response 39 polynomial and confirm that its coefficients were not
always optimal.

No fixed order is uniform. For a fixed `r`, take a feasible nonzero vertex and
look at middle multiplicities separated from all its roots. There are
linearly many such integer points, and the polynomial is uniformly negative
there by a quantity proportional to `n`. Consecutive tuples provide two
literal incidences at each such multiplicity. Choosing `n+1` divisible by a
fixed squarefree product with sufficiently small Euler ratio makes the exact
safe mass smaller than this forced negative contribution. Every nonzero
vertex objective is then negative, while the zero polynomial has objective
zero. Hence the optimized degree-`r` value is exactly zero for infinitely many
actual consecutive tuples, despite the lonely time `1/(n+1)`.

The corresponding Lean declarations are:

- `weighted_hockey_stick` and `consecutive_extreme_debt_sum` for the exact
  binomial sum;
- `clearedCorrelationWeight_zero` and
  `clearedCorrelationWeight_eq_debt` for the histogram weights;
- `clearedCorrelationHistogram_le` and
  `clearedCorrelationHistogram_le_of_zeroMass` for the abstract obstruction.

They assume the zero mass and the two-incidence lower bounds as histogram
inputs. Formalizing the consecutive pivot histogram, its totient zero mass,
and the asymptotic low-totient construction remains future work. No
declaration asserts a failure of LRC.

## 28. Exact adaptive depth on consecutive speeds

For `A_n=(1,...,n)`, let `d_min(n)` be the least depth at which the original
correlation score is positive, and put `c=floor(n/2)`. The tautological exact
inclusion--exclusion depth is `c`. For every `n>=84`, one has

```text
n even:  d_min=c-2;

n odd:   d_min=c-2  if 3*n*phi(n+1)>(n-2)(n-3),
         d_min=c-1  otherwise.
```

The key structural fact is exact: every bad-count layer `D_k` with
`k>floor(n/2)` contains only the two incidences represented by residues
`+1,-1` at pivot `k+1`. A set of more than half the consecutive speed indices
contains adjacent indices; subtracting their strict bad representatives
forces the signed candidate numerator below twice the pivot. Direct interval
analysis then excludes every numerator except `+/-1`. This turns every
high-depth score into

```text
n*phi(n+1) - (2/(n-1))*C(n-1,2d+1).
```

At `d=c-2` and `c-1`, this gives the displayed classification. To prove
minimality rather than merely compare two late depths, binomial unimodality
makes every depth `2<=d<=c-3` negative. Depth one is handled separately by
retaining the distinct candidate residues `+/-s` for `1<=s<=5`; their exact
bad count is `floor((p-1)/s)`, and a closed floor-free debt bound exceeds
`n^2` from `n=84` onward.

The cutoff gap is therefore always one or two in this range. Multiples of 30
in `n+1` give infinitely many gap-one cases, while even `n` and
`n=2^a-1` give infinitely many gap-two cases. The exact scan covers every
smaller `n` separately. This result is not currently in Lean beyond the
abstract histogram kernel of Section 27, and it proves nothing new about the
already-lonely consecutive tuples themselves.

## 29. Response 41 arithmetic and Chebyshev kernels

For `n>=3`, a shifted Chebyshev polynomial gives a rational feasible
zero-indicator minorant of degree `O(sqrt(n) log n)`. It equals one at zero
and is bounded below by `-2*epsilon/(1-epsilon)` on every positive
multiplicity. Applied to consecutive speeds, the exact total candidate mass
and the previously classified safe mass make its score positive. This is not
an independent proof for the consecutive tuple: the inequality uses
`D_0=n*phi(n+1)>=n`, which already records the known safe times. It proves
only that the near-tautological obstruction in Section 28 is specific to the
alternating polynomial.

The corresponding finite algebra is kernel-checked by
`momentHistogramScore_ge_zero_sub_tail`, `rationalChebyshevValue_bounds`,
`chebyshevMomentGrid_boundedZeroTest`, and
`chebyshevMomentHistogramScore_pos`. The final declaration assumes the exact
Chebyshev growth inequality transparently; formalizing the analytic
`arcosh`/exponential estimate that discharges it is still open.

Two new Lean modules encode arithmetic restrictions that do not assume a safe
mass. `SmallDenominatorWitness.lean` proves that if some `2<=q<=N` divides no
speed, then `t=1/q` satisfies the closed lonely boundary, and hence every
integer counterexample would have to cover all those moduli by divisibility.
`CrossPivotScaling.lean` proves the exact circular-residue scaling identity
and uses coprimality to inject the safe candidates of a pivot into those of a
multiple pivot while preserving every strict bad predicate along the image.

On paper, the signed-divisor descent is also completely characterized when
`a_n<n*a_(n-1)`: its replacement must have
`a_n=q*b`, `b=N*a_(n-1)/(q+1)`, `2<=q<=N-2`, together with the lower-pivot
divisor alternatives. This is a necessary irreducibility condition on a
sum-minimal counterexample, not a contradiction. The remaining task is to
derive a positive growing-order CRT-moment score without using `D_0`, or to
show that the divisor-cover, cross-pivot, and descent constraints exclude the
irreducible class.

The arithmetic characterization itself is kernel-checked by
`top_signed_forces_sum`, `comparable_signedDivisor_necessary`,
`comparable_signedDivisor_sufficient`, `comparable_signedDivisor_iff`, and
`replacement_sum_lt`. The minimal-counterexample composition is deliberately
not packaged as a theorem until the sorted-family and certificate-transport
interfaces are connected explicitly.

## 30. A bounded-height theorem and an exact CRT Chebyshev score

Let `n>=2` and put `N=n+1`. If `n` distinct positive integer speeds are all
at most `n+2=N+1`, exactly two values `c<d` are missing from `[1,N+1]`.
The following two-hole observation is the arithmetic core. Suppose
`N<q<=2N`, `0<c<q`, `gcd(c,q)=1`, and neither `c` nor `q-c` occurs as a
speed. Choose `0<r<q` with `cr congruent 1 (mod q)`. If a speed had circular
residue zero or one at numerator `r`, multiplication by `c` would force that
speed to be congruent to `0`, `c`, or `q-c`; the range below `q` excludes all
three. Every circular residue is therefore at least two, and

```text
||a_i r/q|| >= 2/q >= 1/N.
```

The two holes always construct the required situation. When `d=N+1`, use
`t=1/N` if `c=N`, use `t=1/c` if `2c>N`, and otherwise choose
`u congruent 1 (mod c)` in `[N+1,2N-c]` and set `q=c+u`. When `d<=N`, use
`t=1/d` if `2d>N+1`; otherwise choose the representative in
`[N+2,2N-c]`. The interval lengths are at least `c`, so the representative
exists. This proves that maximum speed at most `n+2` is sufficient. Hence an
integer counterexample would have maximum at least `n+3`. `BoundedHeight.lean`
kernel-checks the denominator construction, all four cases, and the
finite-family two-hole extraction with positivity and all closed endpoint
hypotheses explicit. The final declaration is
`boundedHeight_stationary_witness` for the nontrivial range `n>=3`.

A separate result evaluates a growing-degree certificate without using a
known safe count. For `n>=3`, `r>=1`, define

```text
P_(n,r)(k)=(T_r((n-2k)/(n-2))-1)/(T_r(n/(n-2))-1).
```

This is one at `k=0` and nonpositive at every `1<=k<=n-1`. Its forward
Newton expansion expresses the pivot score using only intersection moments
through order `min(r,n-1)`, and the direct generalized-CRT formula evaluates
those moments without constructing `D_0` or the full bad-multiplicity
histogram. A strictly positive score proves that pivot has a lonely candidate.
Exact finite searches find such a pivot in five stated near-consecutive boxes
and a 4,276-tuple mutation family. They do not prove uniform positivity.

Finally, the largest-speed comparison used by the signed-descent route needs
a corrected quantifier. Deleting the largest speed invokes the conjecture in
one lower dimension, so `a_n<n*a_(n-1)` follows for a least counterexample
dimension (or under an explicit lower-dimensional hypothesis), not from
fixed-dimension sum minimality alone. Under that correction the height, lcm,
divisor-cover, and signed-descent conditions remain compatible. No complete
proof or disproof follows from this section.

## 31. Four holes improve the height bound

Put `N=n+1` and `H=N+3=n+4`. An `(N-1)`-element speed set in `[1,H]` has
four holes, and at least one hole `c` lies at most `N`. If `2c>H`, `t=1/c`
works because no selected speed is divisible by `c`.

Assume `2c<=H` and `N>=12`. The interval

```text
I=[N+c+4,2N]
```

has `L=N-c-3` elements. Every `q in I` has `q>H`, `q-c>H`, and `q<=2N`.
Thus any `q` coprime to `c` makes the inverse of `c` a two-hole witness. If
`L>=c`, the interval contains a complete residue system. Otherwise its
residue complement has size

```text
c-L=2c-N+3<=6.
```

Consequently `phi(c)>6` forces a unit in the interval. The exact exceptions
are `{1,2,3,4,5,6,7,8,9,10,12,14,18}`; a short explicit `(N,q)` table
handles their residual ranges. Independent review regenerated the
classification, every table row, and all eligible pairs through `N=1000`.

For `N=4,...,11`, an exact certificate enumerates all 2,982 four-hole sets
and verifies reciprocal, two-residue, or three-residue inverse witnesses by
the integer inequality `N*rho_q(r*a)>=q`. Together with the elementary
`N=2` case and the kernel-checked two-moving-runner theorem at `N=3`, this
proves the computer-assisted structured result

```text
max_i a_i <= n+4  implies a lonely time exists.
```

Hence an integer counterexample would have maximum at least `n+5`. The exact
finite certificate is `verify_height_n_plus_4.py`; the full proof and audit
are in `docs/height-n-plus-4.md`. The large-`N` theorem and small certificate
have not yet been combined into one Lean declaration, so this section is not
claimed `proved-lean`. A conditional large-`N` wrapper was attempted, but its
elaboration did not finish promptly after decomposition and it was removed;
the runner bridge and arithmetic selector remain formal obligations.

## 32. Five holes and an unbounded height gain

Put `H=N+4=n+5`. An `(N-1)`-element subset of `[1,H]` has five holes, so one
hole `c` lies at most `N`. The reciprocal witness applies when `2c>H`.
Otherwise consider

```text
I=[N+c+5,2N],             |I|=N-c-4.
```

For `N>=20`, this interval is nonempty. Every denominator in it exceeds the
height bound, its complementary residue `q-c` also exceeds the height bound,
and `q<=2N`. If the interval has at least `c` terms it contains a complete
residue system modulo `c`. Otherwise its residue complement has size at most
eight, so a coprime denominator exists unless `phi(c)<=8`. The exact exception
set is

```text
{1,2,3,4,5,6,7,8,9,10,12,14,15,16,18,20,24,30},
```

and a checked 70-row table covers its residual ranges. The inverse of `c`
modulo the chosen denominator avoids residues `0,+1,-1`; hence every speed has
scaled circular residue at least two and meets the closed `1/N` boundary.

An exact certificate covers all 134,568 five-hole configurations for
`N=4,...,19`; three require direct rational witnesses beyond the reciprocal
and `C_b` patterns. Together with the base cases this proves

```text
max_i a_i<=n+5  implies a lonely time exists,
```

so an integer counterexample would have maximum at least `n+6`.

More generally, for positive integers `N,t`, the same interval has a residue
complement of size at most `2t`. Since `phi(c)>=sqrt(c/2)`, the hypothesis

```text
16*t^2+t<=N
```

forces a suitable denominator. Therefore, with

```text
T_N=max(4,floor((sqrt(64N+1)-1)/32)),
```

maximum at most `N+T_N` is sufficient. This is an unbounded constructive gain
of order `sqrt(N)/4`, still far from the unrestricted conjecture. The full
proof, table, hashes, and independent reviews are in
`docs/height-n-plus-5.md` and `docs/response44-audit.md`.

## 33. Corrected residual restrictions remain compatible

A minimal-counterexample analysis must choose the least counterexample
dimension before choosing a primitive sum-minimal tuple. Only then does
deletion invoke the lower-dimensional theorem and yield the comparable-top
restriction. Divisor cover plus deletion-gcd-one also implies

```text
1<=#{i:d divides a_i}<=n-2       for 2<=d<=N.
```

These restrictions do not contradict one another. For every `N>=5`,

```text
U_N=(3,4,...,N,N+4)
```

is primitive, has deletion gcd one in every coordinate, covers every required
divisor, satisfies the lcm/product and comparable-top bounds, and admits no
accepted signed-compatible downward replacement. It is nevertheless lonely
at `t=1/(3N)`. Thus a proof still needs genuinely new control of total pivot
coverage; the current height and descent restrictions alone cannot close the
argument.

## 34. An elementary logarithmic height gain

The missing-height denominator construction admits a sharper elementary
estimate than the square-root totient bound. Let `N,t>=1`, let
`K=Nat.log 2 N`, and suppose

```text
(4*(K+1)+1)*t<=N.
```

Choose a missing `c<=N`. The reciprocal branch works when `2c>N+t`.
Otherwise use

```text
I=[N+c+t+1,2N],             L=N-c-t.
```

If `I` has no number coprime to `c`, the only nontrivial case is `L<c`.
The `L` residues are distinct, so all `phi(c)` unit residues lie in a
complement of size `c-L=2c+t-N<=2t`. If the distinct prime divisors of `c`
are `p_1<...<p_k`, then `p_i>=i+1`, whence

```text
c/phi(c)=product_i p_i/(p_i-1)<=product_i (i+1)/i=k+1.
```

Moreover `2^k<=rad(c)<=c<=N`, so `k<=K`. Therefore `c<=2t(K+1)`, while
the short-interval condition gives

```text
N<2c+t<=(4*(K+1)+1)*t<=N,
```

a contradiction. A coprime denominator therefore exists, and the previously
formalized inverse-residue theorem supplies the lonely time. Combining this
with the five-hole theorem gives

```text
T_N=max(4,N div (4*(Nat.log 2 N+1)+1)),
max A<=N+T_N  implies A is lonely.
```

This gain is asymptotic to `N/(4*log_2 N)`. Exact audits cover 553,106
arithmetic cases and all 361,220 admissible hole configurations through
`N=60`. In Lean, `LogarithmicHeight.lean` proves the sharp totient product,
both interval-selector branches, missing-height extraction, the reciprocal
case, and the closed inverse-residue witness. The declarations
`logarithmicHeight_family_witness`, `logarithmicHeight_stationary_witness`, and
`logarithmicHeightGain_stationary_witness` correspond to the theorem and its
explicit integer-gain corollary.
`logarithmicHeightGain_positiveInteger_witness` gives the identical conclusion
using the canonical `UnitCircle` norm. This bounded-height result is
`proved-lean`.

## 35. The quadratic Chebyshev shortcut fails

The pointwise quadratic minorant of the exact Chebyshev polynomial remains
valid, but it is not uniformly decisive. For the primitive tuple

```text
(1,3,5,6,7),
```

the five scaled values of `H_0-H_1+alpha_5*H_2` are

```text
(-14722,0,-324,-486,-972).
```

Thus every pivot fails the required strict inequality. This is not a failure
of the full score: its exact numerators have signs `(-,0,+,+,+)`, and the
direct time `7/30` has distances

```text
7/30, 3/10, 1/6, 2/5, 11/30,
```

all at least `1/6`. The computation therefore rejects only the quadratic
sufficient condition. It neither refutes the full Chebyshev route nor proves
or disproves LRC.

## 36. Exact primorial coefficient: formalized boundary

Let `P_N` be the largest primorial not exceeding `N`, and put
`Q_N=phi(P_N)`, equivalently the product of `p-1` over the primes dividing
`P_N`. The exact arithmetic input required by the primorial improvement is

```text
c*Q_N <= phi(c)*P_N                 for every 0<c<=N.
```

Assuming this inequality, absence of a coprime in the short interval gives
`phi(c)<=c-L`, where `L=N-c-t`. Combining this with `2c<=N+t` eliminates `c`
and gives

```text
N*Q_N <= (4*P_N-Q_N)*t.
```

Therefore the strict reverse inequality forces a coprime denominator and a
common witness at the closed `1/N` boundary. Equality gives no conclusion.
The largest integral gain satisfying the strict inequality is exactly

```text
floor((N*Q_N-1)/(4*P_N-Q_N)).
```

`PrimorialHeight.lean` maps these steps to
`rational_short_interval_bound`,
`rationalCoefficientHeight_family_witness`,
`rationalCoefficientHeightGain_spec`, and
`rationalCoefficientHeightGain_maximal`. The declarations
`boundedPrimorial_le` and `primorial_le_boundedPrimorial` verify that the
chosen `P_N` is genuinely the largest primorial value at most `N`, while
`totient_primorial_eq_prod_primesLE_pred` identifies `Q_N`.

The uniform ratio inequality is also now kernel-checked. For a finite set of
prime divisors that is not an initial segment of the primes, choose its
largest member `p` and a missing smaller prime `q`. Replacing `p` by `q`
strictly decreases the radical and, because

```text
p*(q-1) <= (p-1)*q,
```

can only increase the radical divided by the predecessor product. Strong
induction therefore produces a primorial no larger than the original radical
whose Euler ratio dominates it. Enlarging that primorial to `P_N` only adds
factors `(r-1)/r<=1`; Euler's product formula transfers the comparison from
the radical to the original `c`. This is
`boundedPrimorial_ratio_dominates`. The declaration
`boundedPrimorial_ratio_maximum` packages the uniform comparison, verifies
`0<P_N<=N`, and proves attainment at `c=P_N`.

Consequently `boundedPrimorialHeight_family_witness` and
`boundedPrimorialHeight_stationary_witness` are unconditional.
`boundedPrimorialHeightGain_family_witness` gives the exact integral gain;
the general ratio-premise interface remains available as
`boundedPrimorialRatioHeight_family_witness`. The complete primorial
bounded-height theorem is therefore `proved-lean`. It remains only a
bounded-height partial result and does not prove unrestricted LRC.

## 37. Kanold/Jacobsthal linear height

For a positive natural `c`, consider the exact interval assertion

```text
every Ico(start, start + 2^omega(c)) contains q coprime to c.
```

The half-open interval contains exactly `2^omega(c)` integers. Thus this is
the same convention as the Jacobsthal function `g(c)` being the least length
that forces a coprime in every sequence of consecutive integers and the
literature inequality `g(c)<=2^omega(c)`. The primary source is H.-J. Kanold,
[“Über eine zahlentheoretische Funktion von
Jacobsthal”](https://doi.org/10.1007/BF01350607), *Mathematische Annalen* 170
(1967), 314–326, Theorem 4.

`KanoldHeight.lean` names this assertion `KanoldIntervalBound`, keeping the
arithmetic reduction separate from the number-theoretic proof.
`KanoldVandermonde.lean` proves the assertion as follows.

Let `P` be the finite set of prime factors of `c`, let
`M=product_(p in P) p`, and choose a primitive `M`-th complex root `zeta`.
For `T subset P`, define

```text
e_T = sum_(p in T) product_(q in P, q != p) q,
lambda_T = zeta^e_T.
```

`subsetExponent_mod_injective` proves that the residues `e_T mod M` are
pairwise distinct. If `p` belongs to exactly one of `T,U`, reduction modulo
`p` kills every summand except `M/p` on that side. That remaining product is
nonzero modulo `p`, since every other factor is a distinct prime.
`primitiveRoot_subset_nodes_injective` transfers residue injectivity to the
complex nodes `lambda_T`.

For a natural `x`, set

```text
F(x) = product_(p in P) (1 - (zeta^(M/p))^x).
```

`roots_product_expansion` checks the exact identity

```text
F(x) = sum_(T subset P) (-1)^|T| * lambda_T^x.
```

If a prime `p in P` divides `x`, `roots_product_eq_zero_of_dvd` proves that
the `p` factor is zero, hence `F(x)=0`. Suppose every integer `start+i`, for
`0<=i<2^|P|`, were divisible by a prime in `P`. After absorbing
`lambda_T^start` into the coefficients, the expanded sum would vanish at all
exponents `i=0,...,2^|P|-1`. The nodes are distinct and the empty-subset
coefficient is nonzero. `exponential_sum_not_vanish_consecutively` applies
Mathlib's Vandermonde kernel to contradict simultaneous vanishing. This is
`exists_avoiding_prime_set`.

Finally, `coprime_of_avoids_primeFactors` converts avoidance of every prime
factor into `Nat.Coprime`; positivity of `c` supplies `c != 0`. The resulting
theorem is exactly `kanoldIntervalBound_vandermonde : KanoldIntervalBound`.
It also covers `c=1`, where the prime set is empty and the interval has length
one, and `start=0`; no boundary convention changes.

Combining this result with the height reduction gives the following
unconditional theorem. Let `n+1=N`, let `t>0`, and let
`a : Fin n -> Nat` be positive and injective. If

```text
max_i a_i <= N+t       and       17*t <= 3*N,
```

then there is a real `tau` for which every runner has circular distance at
least the closed threshold `1/N`.

The proof selects a missing `c` in `[1,N]`. The reciprocal branch is the
already verified small-denominator argument. Otherwise `2*c<=N+t`, and the
inverse-denominator interval has

```text
start = N+c+t+1,       ell = N-c-t,
start+ell = 2*N+1.
```

For `c>=7`, Lean proves `5*2^omega(c)<=2*c`; the height inequalities give
`2*c<=5*ell`, hence `2^omega(c)<=ell`. For `c<=6`, Lean computes the exact
values `omega(1),...,omega(6)=(0,1,1,1,1,2)` and proves the same length bound
directly. The verified Kanold theorem supplies a coprime `q` in the initial
subinterval.
Because the full upper endpoint is `2*N+1`, the allowed integer `q=2*N` is
retained. The existing two-hole inverse bridge then gives the closed witness.

The declarations `subsetExponent_mod_injective`,
`exponential_sum_not_vanish_consecutively`, `roots_product_expansion`,
`exists_avoiding_prime_set`, `kanoldIntervalBound_vandermonde`,
`five_mul_two_pow_omega_le_two_mul`,
`small_modulus_power_le_interval_seventeen`, and
`seventeenThirdsHeight_family_witness` are all `proved-lean`.
`sixHeight_family_witness` is an unconditional corollary. The earlier
`*_of_kanold` declarations remain available and expose the dependency split.
Axiom probes for the algebraic proof and final height theorem report only
`propext`, `Classical.choice`, and `Quot.sound`.

This proves a uniform linear bounded-height region. It does not bound
arbitrary integer speeds, so it does not prove unrestricted LRC.

## 38. Coefficient-five bounded height

The preceding argument can be sharpened from `17*t<=3*N` to

```text
5*t <= N.
```

The chosen missing `c` is still arbitrary. In the nonreciprocal branch put
`ell=N-c-t`. The first new arithmetic input is
`three_mul_two_pow_omega_le`: if `c>=7` and `c!=10`, then

```text
3 * 2^omega(c) <= c.
```

For at most two prime factors this is direct, with `c=10` isolated. For at
least three prime factors, remove the largest prime from the radical. If it
is at least seven, the remaining prime product dominates the required power
of two; if it is five, the prime-factor set is exactly `{2,3,5}`. Euler's
radical divisibility then transfers the bound to `c`.

Assume `2*c<=N+t`; otherwise the reciprocal branch already works. If
`c<=3*t`, then `N>=5*t` gives `ell>=4*t-c` and hence `3*ell>=c`. If
`3*t<=c`, the lower bound `N>=2*c-t` gives `ell>=c-2*t` and again
`3*ell>=c`. Therefore `ell<2^omega(c)` is impossible for `c>=7`, except
possibly `c=10`. Lean checks `c=10` and `c=1,...,6` exactly. The declaration
`five_short_interval_exception_classification` proves that the complete
exception list is

```text
(N,t,c) = (5,1,3), (10,2,6), (11,2,6).
```

`five_witness_or_exception` packages this classification with the reciprocal
and Kanold/inverse branches. If the selected missing value is not exceptional,
it already returns the common closed `1/N` witness.

The exceptional families are repaired without changing the original
quantifiers:

- At `(10,2,6)`, the denominator `q=19` satisfies
  `N<q<=2*N`, `N+t+c<q`, and `Coprime 6 19`.
- At `(5,1,3)`, if speed 6 is missing then no selected speed is divisible by
  3 and the reciprocal witness works. If speed 6 occurs,
  `exists_second_missing_of_extra_speed` supplies a second missing
  `d in [1,5]`, `d!=3`; rerunning the generic selector at `d` cannot return
  any listed exception.
- At `(11,2,6)`, if speed 12 is missing then the reciprocal witness works.
  If 12 occurs but 13 is missing, `q=19` avoids the two forbidden heights
  `6` and `19-6=13`. If both occur, the same cardinality lemma supplies a
  second missing `d in [1,11]`, `d!=6`, and rerunning the selector cannot
  return the sole `(11,2,_)` exception.

The cardinality lemma uses only injectivity and `n+1=N`: if every member of
`[1,N]` except `c` occurred and one additional speed `e>N` occurred, the
image would contain `N` distinct values despite having cardinality `N-1`.
No minimality, uniqueness, or optimized choice of `c` is assumed.

`fiveHeight_family_witness` assembles these branches. It retains `t>0`,
positivity and injectivity of the speeds, `n+1=N`, maximum speed `N+t`, and
the closed circular-distance threshold `1/N`. Its axiom report contains only
`propext`, `Classical.choice`, and `Quot.sound`. This is `proved-lean`, but it
still covers only a bounded-height region and therefore does not prove
unrestricted LRC.

## 39. Fastest-pivot ratio criterion

Let `N>=2`, and let `B` be the largest member of a positive integer speed
family. Suppose every speed `s` satisfies

```text
B <= (N-1)*s.
```

Use the `B`-pivot grid and numerator `r=N-1`. The candidate time is

```text
tau = (N-1)/(N*B).
```

The factor `N` in this denominator is essential. For example, when
`(N,B,s)=(4,10,4)`, the phase is `3*4/40=3/10`, not `3*4/10`; it is at
distance `3/10>=1/4`. This exact check is the theorem
`fastestPivot_normalization_regression`.

Candidate membership follows from `N-1<N*B` and `N` not dividing `N-1`.
For each speed, maximality and the ratio hypothesis give

```text
B <= (N-1)*s <= (N-1)*B = N*B-B < N*B.
```

Thus reduction modulo `N*B` changes nothing, while both the residue and its
complement are at least `B`. In the repository's notation,

```text
B <= cyclicResidueDistance (N*B) ((N-1)*s).
```

Because a pivot bad set uses the strict inequality `<B`, equality at either
endpoint remains good. The declarations
`N_sub_one_mem_pivotCandidates`,
`pivot_le_cyclicResidueDistance_N_sub_one_mul`, and
`N_sub_one_not_mem_fastestPivotBadResidues` formalize these three steps.
`exists_fastestPivotCertificate_of_ratio` assembles the finite certificate,
and `fastestPivot_family_witness` passes it through `pivotResidueWitness` to
obtain the common closed `1/N` real witness.

Taking the contrapositive, if the fastest pivot has no modular certificate,
some speed satisfies `(N-1)*s<B`. If `a_min` and `a_max=B` are chosen
minimum and maximum indices, monotonicity gives

```text
(N-1)*a_min < a_max.
```

This is `slowest_fastest_gap_of_no_fastestPivotCertificate`. A failure of the
top-two strategy in particular includes failure at the fastest pivot, so it
obeys the same necessary spread condition. The theorem does not show that a
fastest or top-two pivot always succeeds and does not prove unrestricted LRC.

## 40. Coefficient-four bounded height

The missing-height selector can be sharpened once more. Assume the same
positive injective integer family, `n+1=N`, maximum speed at most `N+t`, and

```text
4*t <= N.
```

For a selected missing `c`, the reciprocal branch works when `N+t<2*c`.
Otherwise put `ell=N-c-t`. The inequalities `2*c<=N+t` and `4*t<=N`
imply

```text
c <= 5*ell.
```

The declaration `five_mul_two_pow_omega_le_of_40_le` proves

```text
5 * 2^omega(c) <= c
```

for every `c>=40`. If `omega(c)<=2`, this follows directly from `c>=40`.
For at least three prime factors, remove the largest prime. If it is at least
ten, the remaining product contributes `2^(omega(c)-1)` and the largest
prime contributes the required factor ten. If it is below ten, every prime
factor lies in `{2,3,5,7}`; the cases of at most three factors again use
`c>=40`, while four factors give radical `210`.

Consequently a short Kanold interval forces `c<40`. Lean evaluates
`omega(c)` for those finitely many natural numbers with kernel-checked
`norm_num`, not `native_decide`, and `four_short_interval_exception_classification`
proves that the complete list is

```text
(4,1,2),   (5,1,3),   (8,2,5),   (10,2,6),
(11,2,6),  (12,3,6),  (16,4,10), (17,4,10),
(20,5,12), (24,6,15), (48,12,30),(49,12,30).
```

`four_witness_or_exception` combines this classification with the reciprocal
and Kanold branches. Nine exceptions have an explicit modulus strictly above
both forbidden heights:

```text
(5,1,3)->10,   (8,2,5)->16,   (10,2,6)->19,
(12,3,6)->23,  (16,4,10)->31, (17,4,10)->33,
(24,6,15)->46, (48,12,30)->91,(49,12,30)->97.
```

Each modulus satisfies `N<q<=2*N`, `N+t+c<q`, and `Coprime c q`, so
`twoHole_witness_of_coprime_modulus_above_height` supplies the common closed
`1/N` witness.

The remaining three use a complementary boundary hole:

```text
(N,t,c,q,q-c) = (4,1,2,7,5),
                  (11,2,6,19,13),
                  (20,5,12,37,25).
```

Here `q-c=N+t`. If that top height is missing,
`twoHoleDenominator_family_witness` applies directly to the two explicit
missing values. If it occurs, it lies strictly above `N`, so
`exists_second_missing_of_extra_speed` produces another missing
`d in [1,N]` with `d!=c`. Rerunning `four_witness_or_exception` at `d`
cannot return an exception: for each of these fixed pairs `(N,t)`, the table
contains only the original value `c`.

`fourHeight_family_witness` assembles all branches without changing the
original quantifiers. Its exact assumptions are `n+1=N`, `t>0`, positivity,
injectivity, maximum speed `N+t`, and `4*t<=N`; its conclusion is a common
real time at the closed circular-distance threshold `1/N`. This remains a
bounded-height region and does not prove unrestricted LRC.

## 41. Saturated lower-interval top-two certificate

Fix `N>=4`, put `A=N-2`, and let `B>A`. For the speed family

```text
1,2,...,A,B,
```

there is a canonical pivot certificate at one of the two largest speeds.
The three exhaustive divisibility cases use:

```text
N∤B:                 pivot A, residue A;
B=N*k and A∤k:       pivot A, residue N-1;
B=N*A*k:             pivot B, residue (N-1)*N*k-1.
```

For the first residue, multiplication by each `1<=a<=A` stays in the
interval from `A` to `N*A-A`; multiplication by `B` reduces to `A*(B mod N)`,
whose nonzero residue has cyclic distance at least `A`. For the second,
`(N-1)*a` lies from `A` to `N*A-A`, while the top coordinate reduces to
`N*(k mod A)` and `A∤k` makes both cyclic sides at least `A`. In the last
case every lower product lies between `B` and `N*B-B`; the residue is not
divisible by `N`, so the pivot coordinate is good as well.

`SaturatedTopTwoPivotCertificate` records the non-strict cyclic-distance
statement. `saturatedTopTwoPivotCertificate` proves it by exactly these three
cases. `saturatedTopTwo_avoids_pivotBadResidues` then translates every lower
coordinate and `B` to the repository's canonical strict bad-set formulation.
Equality at cyclic distance equal to the pivot remains good throughout. This
is a proof for one structured family only and supplies neither the unrestricted
top-two conjecture nor unrestricted LRC.

## 41A. Coefficient-three bounded height

Let `speeds : Fin n -> Nat`, and assume

```text
n+1=N,  t>0,  0<speeds_i,  speeds is injective,
speeds_i<=N+t,  and  3*t<=N.
```

The theorem `threeHeight_family_witness` proves that one real `tau` satisfies

```text
(N:Real)^-1 <= circleNorm (tau * speeds_i)
```

for every index `i`. The proof still uses
`kanoldIntervalBound_vandermonde`, so no Jacobsthal or interval statement is
assumed as an axiom. The new step is a global count over every missing base
height; an arbitrary single missing height need not have a sufficiently long
Kanold interval in this coefficient range.

For a missing `c in [1,N]`, first use the reciprocal witness if
`N+t<2*c`. Otherwise set

```text
ell = N-c-t.
```

The hypotheses `2*c<=N+t` and `3*t<=N` guard the subtraction by giving
`c+t<=N`. If `2^omega(c)<=ell`, the verified Kanold theorem supplies a
coprime integer in

```text
[N+c+t+1, 2*N],
```

and the existing two-hole bridge gives the common closed `1/N` witness.

It remains to classify a short interval. For `c>=11`, the already verified
inequality

```text
3 * 2^omega(c) <= c
```

applies (`c=10` is outside this range). If also `2*c<=N`, then the three
inequalities `3*t<=N`, `2*c<=N`, and
`N-c-t<2^omega(c)` contradict that bound. Hence every such unrepaired hole
satisfies `N<2*c`. Lean evaluates `omega(c)` exactly for `c<11` and proves in
`three_short_interval_large_or_exception` that the only non-large cases are

```text
(N,t,c) = (4,1,2), (6,2,3), (12,3,6),
            (12,4,6), (13,4,6).
```

`three_witness_or_large_or_exception` combines this classification with the
reciprocal, Kanold, and two-hole branches. Its first disjunct is the complete
common-witness existential, not a coordinatewise or hole-dependent surrogate.

Now let `S` be the image of the speed family and define

```text
U = [1,N],       M = U \ S,       E = S \ U.
```

Injectivity gives `|S|=n=N-1`, while `|U|=N`. Applying the finite-set
difference/intersection cardinality identity in both orders gives exactly

```text
|M| = |E| + 1.
```

Assume, for contradiction, that no common witness exists. Take any `c in M`
outside the special parameter pairs. The selector cannot return a witness,
so its classification gives `N<2*c`. If speed `2*c` were absent, then no
selected speed would be divisible by `c`: positivity excludes multiplier
zero, `c` itself is missing, `2*c` is absent, and every multiplier at least
three exceeds the height bound because

```text
3*t<=N<2*c  implies  t<c  and  N+t<3*c.
```

The reciprocal `1/c` would then be a common witness, a contradiction.
Therefore speed `2*c` occurs. Since `N<2*c`, it belongs to `E`. The map
`c |-> 2*c` is injective on naturals, so Lean obtains

```text
(M.image (fun c => 2*c)).card = |M|
and
M.image (fun c => 2*c) subset E.
```

This would give `|M|<=|E|`, contradicting `|M|=|E|+1`.

Three parameter pairs require local repairs before that global injection can
be applied.

- For `(N,t)=(6,2)`, every missing base height lies in `{3,4}`. If `4` is
  missing and speed `8` is absent, the reciprocal `1/4` works. If `8` occurs,
  the exact identity `|M|=|E|+1` forces both `3` to be missing and `7` to be
  absent. If `4` is not missing, the same identity again forces `3` and `7`
  to be missing. In both remaining cases `q=10` has complementary holes
  `3` and `7`, is coprime to `3`, and satisfies `N<q<=2*N`.

- For `(N,t)=(12,4)`, every missing base height lies in `{6,7,8}`. A missing
  `7` or `8` forces the extra speed `14` or `16`, respectively. Mapping every
  missing value other than `6` to its double and comparing cardinalities
  first forces `6 in M`. Put `D=(M.erase 6).image (fun c => 2*c)`. Lean proves
  `D subset E` and `|D|+1=|M|`, hence `|D|=|E|`. If speed `13` occurred, the
  odd value `13` would lie in `E` but outside `D`, contradicting those equal
  cardinalities. Thus `6` and `13` are missing, and `q=19` supplies the
  two-hole witness.

- For `(N,t)=(13,4)`, the short classification reduces `M` to `{6,8}`; the
  apparent large case `c=7` fails its exact short-interval inequality. A
  missing `8` forces speed `16`. The identity `|M|=|E|+1` then forces
  `6 in M` and, whether or not `8` is missing, forces speed `17` to be absent.
  The modulus `q=23` has complementary holes `6` and `17` and gives the
  witness.

The remaining two small triples, `(4,1,2)` and `(12,3,6)`, satisfy
`4*t<=N` and are discharged by `fourHeight_family_witness`. The final source
therefore retains exactly the original positivity, injectivity, height, and
closed-boundary quantifiers. Targeted axiom reports for
`three_short_interval_large_or_exception`,
`three_witness_or_large_or_exception`, and `threeHeight_family_witness` contain
only `propext`, `Classical.choice`, and `Quot.sound`.

This proves a larger bounded-height region than the coefficient-four theorem.
It does not bound arbitrary positive integer speeds and does not prove or
disprove unrestricted LRC.

## 42. Response 49 global top-two reductions

Let

```text
0<a_1<...<a_(n-1)=A<a_n=B,  N=n+1.
```

Two independently audited manuscript lemmas narrow the global top-two
frontier without closing it.

First, suppose an integer `r` satisfies

```text
N∤r,  B<=r*a_1,  r*A<=(N-1)*B.
```

Then every nonpivot product at the fastest pivot lies in the closed interval

```text
B <= r*a_i <= N*B-B.
```

It follows directly that `r` is a canonical fastest-pivot certificate. Put

```text
L=ceil(B/a_1),  U=floor((N-1)*B/A).
```

If pivot `B` fails, `[L,U]` contains no integer not divisible by `N`. Since
two consecutive integers cannot both be multiples of `N>=2`, failure forces
`U<L`, or the singleton case `U=L` with `N|L`. The earlier numerator `N-1`
is the special case `B<=(N-1)*a_1`; failure there gives the large-gap
condition `(N-1)*a_1<B`. The closed-band certificate is mapped to
`pivot_le_cyclicResidueDistance_mul_of_band` and
`exists_fastestPivotCertificate_of_extremal_band` and is `proved-lean` after
an independent ext4 compile and axiom audit. The exact interval conversion is
`exists_fastestPivotCertificate_of_mem_extremal_interval`: positivity of
`a_1` changes `L<=r` into `B<=r*a_1`, while positivity of `A` changes `r<=U`
into `r*A<=(N-1)*B`. The failure dichotomy is
`extremal_interval_compression_of_no_fastestPivotCertificate`. Its only new
arithmetic step is that, for `N>=2`, `N|L` implies `N∤L+1`; otherwise `N`
would divide `1`. These declarations are `proved-lean` after standalone
compilation, an ext4 target build, and axiom/trust probes. The earlier
closed-band core passed the full authoritative integration replay; the next
full replay containing these interval declarations is pending.

Second, write

```text
g=gcd(A,B),  A=g*alpha,  B=g*beta.
```

For

```text
C={u:0<=u<N*g, N∤alpha*u, N∤beta*u},
```

the two numerators `r_A=alpha*u` and `r_B=beta*u` are candidates on their
respective top grids and give the identical time

```text
r_A/(N*A)=r_B/(N*B)=u/(N*g).
```

If `d_A=gcd(N,alpha)` and `d_B=gcd(N,beta)`, kernel counting modulo `N`
gives

```text
|C|=g*(N-d_A-d_B+1).
```

For each lower speed `s`, let

```text
D_s={u in C: cyclicResidueDistance (N*g) (s*u)<g}.
```

The sets `D_s` have exact generalized-CRT counts. Consequently

```text
sum_s |D_s| < |C|
```

leaves one common time outside every lower bad set and is a sufficient
top-two certificate. The identity, cardinality, and union criterion are all
`proved-math`, not a global theorem.

The exact obstruction is already present at `(N,A,B)=(7,98,187)`. Here
`g=1`, `d_A=7`, and `d_B=1`, so `|C|=0`; the common-grid method is vacuous.
Interval compression likewise supplies no theorem forcing pivot `A` in its
residual regime.

Two almost-saturated examples explain why the verified Section 41 formulas
cannot simply be reused after insertion. At `N=5`, the prescribed pivot-`4`
residue `4` fails on `(2,3,4,5)`, and the prescribed pivot-`20` residue `19`
fails on `(1,3,4,20)` because its distance at speed `1` is only `19`.
Finally, coarse top divisibility data cannot select a pivot: the `N=7`
families

```text
(1,4,5,6,7,11),
(1,3,4,5,7,18)
```

have matching basic top residue and divisibility flags, but their exact safe
profiles are respectively

```text
pivot 7: [15,34], pivot 11: [];
pivot 7: [],      pivot 18: [57,58,68,69].
```

These examples refute only the naive extension and coarse classification.
They are not top-two counterexamples. A global proof still requires a finer
integral-cover or signed cross-pivot theorem, and unrestricted LRC remains
open. The exact Response 49 recovery, attachment failures, and audit boundary
are recorded in `docs/response49-audit.md`.

## 43. Affine common-LCM fibers and their first exact obstruction

The common slice can be enlarged by allowing a fixed signed phase difference.
Write `A=g*alpha`, `B=g*beta`, with `g=gcd(A,B)`, and put

```text
H=lcm(A,B)=g*alpha*beta,  Q=N*H.
```

For `epsilon` equal to `+1` or `-1`, the homomorphism

```text
(r_A,r_B) |-> beta*r_A-epsilon*alpha*r_B mod Q
```

from `Z/(N*A) x Z/(N*B)` is well-defined and surjective.  Every fiber has
size `N*g`.  If `d_A=gcd(N,alpha)` and `d_B=gcd(N,beta)`, then the exact
number of points in phase `k` at which both numerators are pivot candidates is

```text
g*(N - 1_[d_A|k]*d_A - 1_[d_B|k]*d_B + 1_[N|k]).
```

The proof is elementary kernel counting followed by inclusion-exclusion.
Scaling the strict cyclic-distance inequalities to modulus `Q` gives

```text
A-bad(s) iff rho_Q(s*(epsilon*alpha*r_B+k))<H,
B-bad(s) iff rho_Q(s*alpha*r_B)<H.
```

On the both-candidate part of a fiber, let `E_A` and `E_B` be the unions of
all nonpivot bad sets for the respective grids, including the other top speed.
Then

```text
|E_A intersect E_B|
 <= sum_(i!=p_A,j!=p_B) |D^A_i intersect D^B_j|.
```

A strict right-hand side below the fiber size therefore gives a certificate
at one of the two pivots.  This implication is sound, but it is not uniform.

Indeed, for `(N,A,B,epsilon,k)=(7,98,187,+1,1)`, the six both-candidate
pairs are

```text
(87,166), (185,353), (283,540),
(381,727), (479,914), (577,1101).
```

The cross-top distances are `(195,295,99,97,293,197)` on the `A`-grid and
constantly `560` on the `B`-grid.  The fourth `A`-grid pair is therefore
cross-top strict-bad (`97<98`), while the other five and all six `B`-grid
cross-top conditions are good.  Lower speed `63` gives the stronger uniform
obstruction: its distances are constantly `7<98` and `14<187` on the two
grids.  It jointly covers all six pairs and defeats the strict
double-intersection criterion on this row.

The constant obstruction has an exact quotient explanation.  For
`r=u+j*P`, write `u*s=q*P+v` and `h=(q+j*s) mod N`.  When `N>=2`,

```text
rho_(N*P)(r*s)<P iff h=0 or (v>0 and h=N-1).
```

The guard `v>0` preserves the closed boundary: `v=0,h=N-1` has distance
exactly `P`.  For the bases `87,166` and speed `63`, both quotients are
`55=6 mod 7`, both remainders are positive, and `63=0 mod 7`; all lifts are
therefore bad on both grids.  Candidate lifts themselves number `N-d` when
`d=gcd(N,P)` divides `u`, and `N` otherwise.

These affine and quotient statements are independently audited
`proved-math`, not Lean-verified.  The hard row refutes only that particular
rescue and its strict-sum certificate.  Other phases and stronger ways of
combining them remain open, as does the global top-two conjecture.  Full
details are in `docs/top-two-affine-fibers.md`.

## 44. The coefficient-two short-hole frontier

The next bounded-height target would replace `3*t<=N` by `2*t<=N`.  The
arithmetic part can be isolated exactly.  Suppose

```text
0<t,  0<c<=N,  2*t<=N,  2*c<=N+t,
N-c-t<2^omega(c).
```

Then either

```text
3*(N-t)<4*c
```

or `(N,t,c)` belongs to the following list:

```text
(4,1,2), (5,2,2), (6,3,2),
(5,1,3), (6,2,3), (7,3,3), (8,4,3),
(10,2,6), (11,2,6), (11,3,6), (12,3,6),
(12,4,6), (13,4,6), (13,5,6), (14,5,6),
(14,6,6), (15,6,6), (15,7,6), (16,7,6),
(16,8,6), (17,8,6), (18,9,6).
```

Indeed, failure of the displayed band gives `4*c<=3*(N-t)`.  Together with
`2*t<=N`, this implies `c+t<=N`.  Put `ell=N-c-t`.  Direct substitution then
gives

```text
c<=3*ell<3*2^omega(c).
```

The audited bound `3*2^omega(c)<=c` eliminates every `c>=7` except `c=10`;
that exception is also impossible because `omega(10)=2` forces
`3*ell<=9<10`.  Thus `c<=6`, and the remaining inequalities leave exactly

```text
(c,ell)=(2,1),(3,1),(6,2),(6,3).
```

Substituting `N=c+t+ell` and imposing the two height inequalities yields the
22 triples above.  An independent exact enumeration through `N=500`
reproduced the table, but the preceding argument is uniform.  This
classification is `proved-math`, not Lean-verified.

The already Lean-verified coefficient-three theorem handles the nine rows
with `3*t<=N`.  The exact residual table has 13 rows:

```text
(5,2,2), (6,3,2), (7,3,3), (8,4,3),
(13,5,6), (14,5,6), (14,6,6), (15,6,6),
(15,7,6), (16,7,6), (16,8,6), (17,8,6),
(18,9,6).
```

In the generic band, `2*t<=N` and `3*(N-t)<4*c` imply `c>3*N/8`, hence
`3*c>N` and `4*c>N+t`.  The only possible occupied positive multiples of a
missing `c` below the allowed height are consequently `2*c` and `3*c`.
Here `3*c` is necessarily an extra speed, but `2*c` may be a base speed.
That distinction prevents the coefficient-three injection from carrying
over.

In fact the natural extra-blocker Hall relation fails in an infinite family.
For `u>=1`, let

```text
N=4*u,  t=2*u,
S=([1,4*u] minus {2*u,3*u}) union {6*u}.
```

There are `N-1` distinct positive speeds, the maximum is `N+t`, and the two
base holes `{2*u,3*u}` have the same singleton extra neighborhood `{6*u}`:

```text
6*u=3*(2*u)=2*(3*u).
```

Thus Hall fails on the two-hole set.  The smaller hole is also blocked by the
occupied base speed `4*u`.  This rigorously refutes the proposed matching
proof, but not the coefficient-two theorem.

Indeed, the same family has a direct two-hole certificate.  Take

```text
q=6*u+1,  c=2*u,  d=q-c=4*u+1.
```

Then `N<q<=2*N`, `gcd(c,q)=1` because `q-3*c=1`, and every selected speed is
less than `q`.  The two complementary heights `c` and `d` are both missing:
`c` was deleted, while `4*u<d<6*u` and `6*u` is the only selected speed above
`4*u`.  The existing two-hole denominator theorem therefore supplies a
closed `1/N` witness.  This confirms that the infinite construction is only
a proof-method obstruction.

What remains is a family-level repair of the 13 finite rows and a generic
argument that accounts for occupied base blockers or complementary missing
heights.  No coefficient-two bounded-height theorem, and no unrestricted
Lonely Runner theorem, follows from this section.  The complete audit is in
`docs/coefficient-two-frontier.md`.

## 45. A finite multi-shift certificate for the hard top pair

This section records reproducible finite evidence, not a uniform theorem. For
`(N,A,B)=(7,98,187)`, fix the fourteen affine shifts

```text
128273,80,71,151,128210,150,25,
1156,114,87,149,2946,24,128252.
```

On each affine fiber, retain only numerator pairs that are candidates at both
top pivots and for which the other top runner is on or outside the closed safe
boundary.  A lower-speed set jointly spoils such a pair only when it contains
a speed in the strict bad set at each endpoint.  Across the fourteen fibers
there are 64 resulting two-sided constraints, with per-shift counts

```text
5,5,5,4,5,4,5,4,4,5,4,4,5,5.
```

Exact enumeration rejects all `C(97,4)=3,464,840` four-element subsets of
`[1,97]`.  The five-element set `{7,63,70,77,84}` meets both sides of every
constraint.  Upward closure therefore proves that this fixed constraint
family has exact transversal number five. Since `5>N-3=4`, every four-speed
lower set leaves a selected robust pair with at least one unspoiled endpoint,
which is a top-pivot certificate for that fixed instance.

The recovered GPT-5.6 Sol Pro verifier and an independent implementation that
directly enumerates both numerator coordinates reproduce the same result.
Their exact hashes, outputs, endpoint audit, and replay command are in
`docs/response50-audit.md`.  The missing theorem is a uniform construction of
such a shift family for arbitrary `(N,A,B)`, or a proof that another finite
family always yields the required transversal inequality.  Nothing here
proves the top-two conjecture or unrestricted Lonely Runner.

## 46. The corrected affine-transversal bridge

For top speeds `0<A<B`, let `R_A` be the canonical `A`-pivot candidates at
which runner `B` is not strict-bad, and define `R_B` symmetrically.  Given any
finite pair family `C subset R_A x R_B`, a lower-speed set `S` is a two-sided
transversal if every pair has an `A`-bad member of `S` at its first endpoint
and a `B`-bad member, possibly different, at its second endpoint.

The logical certificate bridge is now formal.  In
`TopTwoTransversal.lean`, `isTwoSidedTransversal_of_covers` proves that a set
covering both complete robust grids is a transversal for every such `C`.
Conversely,
`exists_top_certificate_of_not_isTwoSidedTransversal` proves that failure of
transversality supplies one endpoint which is a pivot candidate, is good for
the other top speed, and avoids every lower runner's canonical strict bad set.
It is therefore a complete certificate at `A` or `B`.  This theorem assumes no
affine arithmetic and does not assert that a useful `C` exists.

The unconditional paired target is false.  At

```text
N=4, A=2, B=8,
```

every `A`-candidate has `rho_8(8*r)=0<2`; hence `R_A` and every robust pair
family are empty.  The empty lower set is a transversal, so every paired
transversal number is zero.  Nevertheless `(1,2,8)` has a `B`-pivot
certificate at numerator `9`, with cyclic distances `(9,14,8)` modulo `32`.
This refutes only unconditional paired-fiber existence.

The surviving sufficient frontier is disjunctive.  With `k=N-3`, one must
show that the individual `A` robust grid needs more than `k` lower speeds to
cover, or the individual `B` grid does, or both grids are nonempty and some
selected pair family has transversal number greater than `k`.  Taking all
affine shifts does not solve the problem: it selects the entire Cartesian
product and merely restates the minimum common-cover question.  The exact
audit and remaining obligation are in `docs/affine-transversal-frontier.md`.

## 47. Complementary-hole charging at coefficient two

Let `H=N+t`, with `2*t<=N`.  For a missing base height `c`, define the
coprime complementary-extra neighborhood

```text
Gamma(c)={d:N<d<=H, H<c+d<=2N, gcd(c,d)=1}.
```

This relation has a direct no-witness interpretation.  If any `d in Gamma(c)`
were also missing, then `q=c+d` would satisfy `H<q<=2N`; all selected speeds
would lie below `q`; the complementary heights `c,q-c` would be missing; and
`gcd(c,q)=1`.  The verified two-hole denominator theorem would give the
closed `1/N` witness.  The same argument applies immediately when a coprime
complement exists above `H`.  Thus a hypothetical no-witness family forces
every member of `Gamma(c)` to be an occupied extra.

Combining the reciprocal branch, Kanold branch, coefficient-two 22-case
classifier, and above-height complement elimination produces an exact finite
candidate set `C(N,t)` containing every missing base height.  A system of
distinct representatives for the neighborhoods `Gamma(c)`, `c in C(N,t)`,
would restrict to an injection from the actual missing set `M` into occupied
extras `E`, contradicting `|M|=|E|+1`.

The required selector theorem remains conjectural.  A deterministic exact
search through `N=300` finds only four parameter failures:

```text
(4,2),(5,2),(8,4),(11,5).
```

Under the forced-neighborhood and cardinality conditions, those rows have
only five total configurations, and each has an explicit reciprocal witness.
This proves the finite repairs but not the all-`N` selector.  The simpler rule
choosing one of `3c+1,3c-1,2c` is exactly refuted at `N=19,t=9`; the same
families have the complementary two-hole witness `(q,c,q-c)=(29,9,20)`.

The exact definitions, configurations, source/output hashes, and primary
coprime-matching references are in `docs/coefficient-two-gamma.md`.  Existing
rectangular interval-matching results do not directly prove this sliding,
truncated Hall condition.  The coefficient-two theorem remains open at that
uniform selector obligation.

## 48. A Lean-verified common-grid top-two class

Let the two proposed top speeds be `alpha*g` and `beta*g`, where `g>0`,
`0<alpha<beta`, and both `alpha` and `beta` are coprime to `N`. On the
canonical `g`-pivot grid define `b(N,g,v)` by the exact gcd/ceiling expression
for the cardinality of `pivotBadResidues N g v`.

For a Fin-indexed lower-speed family, assume

```text
sum_i b(N,g,lower_i) < g*(N-1).
```

There are exactly `g*(N-1)` common-grid candidates. The strict finite union
bound therefore leaves a numerator `u` which is closed-good for every lower
speed. A candidate `u` is also automatically good for `q*g` whenever `q` is
a unit modulo `N`: nondivisibility of `u` is preserved by `q`, so the scaled
cyclic distance is a positive multiple of `g`.

The numerators `alpha*u` and `beta*u` are consequently candidates at the two
top pivots, remain good for every lower speed, and are mutually top-good.
Both represent exactly the same real time:

```text
(alpha*u)/(N*alpha*g) = u/(N*g) = (beta*u)/(N*beta*g).
```

Every step is kernel-checked in `CommonPivotBadCount.lean`. The final
declaration is `simultaneousTopTwo_of_commonPivotBadCount`; the supporting
declarations identify the exact count, extract `u`, prove unit-multiple
safety, and prove the real-time scaling identity. Strict badness and closed
safe equality are inherited from the canonical definitions. This is a
genuine nonsaturated special class, but its strict sum hypothesis is only a
sufficient condition. The declaration deliberately accepts an arbitrary
Fin-indexed lower family; distinctness and the facts that its entries lie
below the two proposed pivots are outer hypotheses in a literal top-two
instantiation. It does not prove the unrestricted top-two conjecture.

## 49. Critical Gamma cores and the asymptotic active frontier

Under `not Auto(c)`, the coprime portion of `Gamma(c)` is unchanged when its
interval is extended through `2*N-c`; the added suffix is precisely the
coprime-free `Auto` interval. The extended interval has length
`N-max(c,t)`. Applying the verified Kanold theorem to disjoint blocks gives

```text
|Gamma(c)| >= floor((N-max(c,t))/2^omega(c)).
```

Together with elementary bounds on `2^omega(c)`, this proves that every
generic candidate `c>=43` has at least two neighbors. A complete bounded
classification finds one empty row, `(8,4,6)`, and 22 singleton rows, all
with `N<=19`. The expanded deterministic Gamma verifier prints and checks the
exact list. Therefore, outside the four repaired parameter pairs, a minimal
Hall-deficient set would have `N>=20`, at least three left vertices,
deficiency exactly one, connected incidence, and minimum degree at least two
on both sides. Abstract graphs with those properties exist, so a new
arithmetic incidence lemma is still needed.

There is also a uniform asymptotic advance. Set

```text
a=floor(3*(N-t)/4)+1,  b=floor((N+t)/2),
q=floor(t/4),          ell=2*q,
a0=max(t-ell,b-2*ell+1).
```

The generic candidates lie in `[a,b]`. For `t>=16`, the two adjacent
length-`ell` intervals starting at `a0` cover this band, and the two disjoint
extra intervals `[N+1,N+ell]` and `[N+ell+1,N+2*ell]` lie in `(N,N+t]`.
Cross the first left interval with the second extra interval and vice versa.
The inequalities `a0+ell>=t` and `a0+3*ell-1<=N` prove exactly the strict
lower and closed upper Gamma sum boundaries. Each block has even length
`ell=2*q`, so Pomerance's published coprime-interval matching theorem supplies
the two disjoint bijections once `q` exceeds its logarithmic threshold.

Consequently there exists an `N0` such that the full Gamma selector holds for
every `N>=N0` and `0<t, 2*t<=N<3*t`. The cutoff is existential because the
published constant and ambient threshold used here are not explicit, and the
rectangle reduction is manuscript mathematics rather than Lean code. The
exact all-`N` selector, coefficient-two height theorem, and unrestricted LRC
remain open.

## 50. Formal crossed-rectangle splice

The elementary part of the preceding asymptotic reduction is now
kernel-checked. `CoefficientTwoRectangle.lean` defines `gammaNeighborhood`
with the exact four conditions

```text
N < d <= N+t,
N+t < c+d <= 2*N,
Coprime c d.
```

It also defines `rectangleC0`, `rectangleC1`, `rectangleD0`, and
`rectangleD1` using half-open finite intervals. The formal generic-band
predicate records the two cleared denominator inequalities used above.
`mem_rectangleC0_union_C1_of_generic` proves that every generic candidate is
in the union of the left rectangles. `rectangleD0_disjoint_D1` and the two
subset theorems prove that the right blocks are disjoint extras.
`rectangleC0_D1_band` and `rectangleC1_D0_band` preserve the strict lower and
closed upper sum boundaries.

Finally, `rectangle_coprime_injections_give_sdr` accepts explicit functions
from the two left rectangles into their crossed right rectangles, together
with injection and coprimality hypotheses. It selects the first function on
`C0` and the second on `C1`. Same-block collisions are excluded by the
supplied injections; crossed collisions are excluded by disjointness of
`D1,D0`. The band lemmas and coprimality hypotheses put every image in the
exact Gamma neighborhood. Thus the combined map is an SDR on every actual
generic subset.

The theorem deliberately stops there. It neither states nor imports
Pomerance's analytic matching theorem, and it does not assert that the two
coprime injections exist for arbitrary parameters. The unmodified Sol Pro
attachment failed Lean at five redundant `dsimp` calls. The tracked source
removes only those calls and renames one unused private hypothesis; its seven
direct axiom probes report only Lean's standard foundations. See
`docs/response53-audit.md` for the exact compiler record.

## 51. Matching dependencies and the remaining arithmetic step

Let `L,R` be finite sets, let `E(x,r)` be a decidable bipartite relation, and
fix an injective map `M:L->R` satisfying `E(x,M(x))`. For `A subset L`, write
`N(A)` for its right neighborhood. Direct `x` to `y` when `E(x,M(y))`, and
call `x` marked when it sees a right vertex outside the global image of `M`.

The matched image `M(A)` is always contained in `N(A)` and has cardinality
`|A|`. If `|N(A)|=|A|`, these two finite sets are equal. Hence every matched
neighbor seen from `A` is matched to another member of `A`, so `A` is
successor-closed, and no member of `A` sees an unmatched vertex. Conversely,
if `A` is successor-closed and avoids marked vertices, every neighbor of `A`
is matched to a member of `A`. Therefore `N(A)=M(A)` and `A` is tight.

This is `tight_iff_successorClosed_and_avoidsBad` in
`MatchingDependency.lean`. It includes `A=empty`, which is correctly tight.
The strict theorem quantifies only over nonempty subsets.

For any `x`, let `Reach(x)` be the vertices reachable by the reflexive-
transitive closure of the dependency relation. If `x` reaches no marked
vertex, `Reach(x)` is nonempty, successor-closed, and mark-free, hence tight.
Conversely, if a nonempty tight set contains `x`, successor closure keeps
every dependency path from `x` inside the set, so such a path cannot end at a
marked vertex. Thus

```text
every nonempty A has |A|<|N(A)|
iff
every x reaches a marked vertex.
```

Lean proves this as `strictHall_iff_every_vertex_reaches_bad`, with direct
axiom reports limited to `propext`, `Classical.choice`, and `Quot.sound`.

The criterion makes a fixed finite strict-Hall audit linear after a matching
and adjacency lists are known. The public hardened sweep constructs and
validates matchings on three exact finite grids; its separate
`N=20000, t=10000` mode applies the reachability criterion and finds no strict
Hall failure. This does not close the conjecture: completing this particular
dependency route uniformly would still need a canonical arithmetic matching,
or a bounded explicit family of matchings, for which reachability can be
proved from the sliding interval and coprimality structure. Finite results and
exact replay commands are in `docs/gamma-dependency-sweep.md`.

## 52. Feasible starts and a Lean-verified fixed reversal

Keep `q=floor(t/4)`, `ell=2q`, and let the exact generic band be `[a,b]`,
where

```text
a=floor(3*(N-t)/4)+1,
b=floor((N+t)/2).
```

Assume `16<=t`, `2*t<=N`, and `a<=b`, so the generic band is nonempty.

For an arbitrary natural start `s`, the union of the two adjacent left
rectangles is `[s,s+2*ell-1]`. It covers `[a,b]` exactly when
`s<=a` and `b<s+2*ell`. The minimum crossed sum is
`N+s+ell+1`, so the strict lower Gamma boundary is exactly
`t<=s+ell`. The maximum crossed sum is `N+s+3*ell-1`, so the closed upper
boundary is exactly `s+3*ell<=N+1`. Finally, the right blocks lie below the
height ceiling exactly when `2*ell<=t`.

Consequently the complete interval of feasible starts is

```text
max(t-ell,b+1-2*ell) <= s <= min(a,N+1-3*ell).
```

The division bounds and `2*t<=N` imply the natural-subtraction guards. The
start `rectangleA0` used by the formal rectangle module is the left endpoint
of this interval.

For any feasible start, set `Q_s=N+s+2*ell`. Subtraction from `Q_s` reverses
`C0(s)` onto `D1` and `C1(s)` onto `D0`, and

```text
gcd(c,Q_s-c)=gcd(c,Q_s).
```

Thus a total coprime to every actual candidate gives an injective Gamma SDR.
The unchanged Sol Pro attachment for the least feasible start compiles as
`CoefficientTwoReversal.lean`. `rectangleReversal_C0_mem_D1` and
`rectangleReversal_C1_mem_D0` verify the images;
`coprime_rectangleReversal` verifies the gcd identity with natural
subtraction guarded by rectangle membership; and
`rectangleReversal_gives_sdr` combines coverage, injectivity, exact extra
bounds, and the strict/closed band theorem.

`CoefficientTwoFeasibleStarts.rectangleStartFeasible_iff` Lean-verifies the
full feasible-start interval under the three hypotheses above.
`CoefficientTwoArbitraryReversal.rectangleReversalAt_isSdr_of_feasible` now
Lean-verifies the arbitrary-start reversal-to-SDR implication, and its
interval corollary discharges feasibility through that exact interval. The
result remains conditional on candidatewise coprimality to one fixed total.
Combining several totals is not automatic because

```text
Q-c=Q'-c' iff c'-c=Q'-Q.
```

The resulting `DIAGONAL-HALL` statement is an exact testable obligation; the
next section rejects it. Endpoint coprime-free strips satisfy exact prime-cover
union bounds, but no theorem yet forces one strip to exceed its available
prime cover. This is an endpoint-synchronization obstruction, not a completion
claim.

## 53. Exact obstruction to diagonal Hall

The `DIAGONAL-HALL` statement is false. Take `N=36`, `t=16`, so `H=52` and
`ell=8`. The complete feasible-start interval is `{11,12,13}`, giving totals
`{63,64,65}`. The exact actual generic candidate set is
`C={20,21,22,23,24,25,26}`. For each `c`, retain `Q-c` precisely when
`gcd(c,Q)=1`. The resulting rows are

```text
20:{43}       21:{43,44}    22:{41,43}    23:{40,41,42}
24:{41}       25:{38,39}    26:{37}.
```

Although every row is nonempty, the subset `{20,22,24}` has neighborhood
`{41,43}`. Hall's inequality fails because `2<3`. This is a genuine collision
obstruction, not merely an individually blocked row.

It is not a Gamma-Hall counterexample. The full exact Gamma graph admits

```text
20->41, 21->40, 22->45, 23->39, 24->43, 25->38, 26->37.
```

The images are distinct; direct calculation gives `52<c+d<=72` and
`gcd(c,d)=1` in every row. Hence the missing edges are precisely useful
non-diagonal Gamma edges. Exact enumeration from the minimal parameter
`N=32` through this row proves that `(36,16)` is the first lexicographic
failure with every diagonal row nonempty. The public expected-output test also
checks the script hash. Therefore feasible reversal totals remain useful
conditional matchings, but their bare union cannot be the uniform selector.

## 54. Canonical contraction of a fixed matching

Continue with a finite bipartite relation `E` and an injective matching `M`
which saturates every left vertex. Let `U` consist of exactly those left
vertices from which no dependency path reaches a vertex seeing a globally
unmatched right vertex.

If `x` belongs to `U` and `x` has a dependency edge to `y`, then any path from
`y` to a marked vertex would extend to one from `x`; hence `y` also belongs to
`U`. A member of `U` cannot itself be marked because the reflexive path would
witness reachability. Thus `U` is successor-closed and mark-free. By
`tight_iff_successorClosed_and_avoidsBad`,

```text
|N(U)|=|U|.
```

This is `nonReachingSet_tight` in `MatchingContraction.lean`.

Delete `U` on the left and the matched image `M(U)` on the right. Injectivity
ensures that restricting `M` gives a well-defined injective matching of every
residual left vertex. A globally unmatched right vertex cannot lie in `M(U)`
and remains unmatched by the residual matching. Moreover, every dependency
path ending at a vertex which reaches a global mark stays outside `U`:
otherwise its suffix would contradict membership in `U`. The path therefore
lifts to the residual subtype and ends at a residual marked vertex.

Consequently every residual left vertex reaches a residual mark. Applying the
already verified fixed-matching equivalence gives

```text
for every nonempty residual A, |A|<|N_residual(A)|.
```

Lean proves the path lifting as
`residual_reflTransGen_of_reflTransGen_reaches_bad`, the reachability statement
as `residual_every_vertex_reaches_bad`, and the final expansion as
`residual_strictHall`. Their axiom probes report only `propext`,
`Classical.choice`, and `Quot.sound`.

This is a canonical decomposition of a graph for which a saturating matching
is already known. It cannot prove Gamma Hall by itself: a hypothetical
deficient Gamma graph supplies no saturating matching to begin with, and
contracting a tight block destroys the clean sliding-interval form. The exact
remaining arithmetic question cannot be phrased as exclusion of an
unannotated atomic core: the next section shows that endpoint is always a
trivial singleton.

The companion `PartialMatchingDichotomy.lean` formalizes the exact local
alternative used when building a matching. After a left vertex is inserted,
either the enlarged left subtype admits some saturating matching, possibly
after rematching every old vertex, or finite Hall produces a nonempty subset
with deficiency at least one. Deleting the inserted vertex from that subset
and using the old matching bounds the deficit by one, so the neighborhood size
is exactly `|T|-1`. The theorem does not assume that the vertex was absent, so
insertion can leave the subtype unchanged. This exposes a critical block but
does not prove that Gamma arithmetic can augment through it.

## 55. Atomic collapse, coatomic contraction, and total layers

Let `A` be a nonempty critical deficiency-one left set: its full neighborhood
has cardinality `|A|-1`, while every nonempty proper subset is Hall-good. If
`|A|>=2` and `a in A`, then `A\{a}` has cardinality `|A|-1`; its neighborhood
is contained in the full neighborhood and Hall gives the reverse cardinality
bound. Hence every co-singleton is tight. Lean formalizes this as
`criticalCore_coSingleton_tight` and derives
`atomicCriticalCore_card_eq_one`. Thus unrestricted contraction until no
proper tight block remains always loses all arithmetic information and ends
at one isolated left vertex.

A meaningful repair contracts only nonspanning tight blocks, equivalently
tight blocks of size at most `|A|-2`. A contraction sequence retains one
original certificate `(K,D)` with `D=N(K)`, `|D|=|K|`, and every residual row
equal to its original row with the common puncture `D` removed. Terminals are
not canonical: the critical graph with rows

```text
0:{0,1,2}, 1:{1,2}, 2:{1,2}, 3:{0}
```

has maximal nonspanning tight blocks leading to residuals of sizes three and
two. No argument may assume an order-independent terminal size or interval
shape. In a terminal with `m>=2`, every subset of size at most `m-2` has
strict expansion, every co-singleton spans the residual right side, and an
ordered cut count gives the necessary bound

```text
sum_d (maxNeighborIndex(d)-minNeighborIndex(d)) >= 3*m-5.
```

For two totals `Q0<Q1`, collisions decompose candidates into arithmetic
chains of step `Delta=Q1-Q0`. Each chain is a path-slot graph, so Hall reduces
exactly to its contiguous blocks. At `(36,16)`, totals 63 and 65 orient the
chain `20,22,24` inward and leave only rights `{41,43}`. This explains why
rowwise coprimality does not control Hall collisions. The reverse arithmetic
estimate excluding every punctured coatomic Gamma core remains open.

`GammaTwoTranslation.gammaTwoTranslation_isSdr` Lean-verifies the conditional
two-branch J1 map. An independent finite audit rejects small fixed extensions:
every fixed shift family of cardinality at most three fails one of the four
active `N=20` instances, and the four size-four survivors there fail at
`(21,9)`. These are restrictions on one translation scheme, not Gamma-Hall or
LRC counterexamples.

## 56. Conditional deletion-pivot induction bridge

This section records a new unrestricted implication chain, not a proof of its
one arithmetic premise. Let the original tuple `a` have `n` positive distinct
integer speeds and write `N=n+1`. For a positive pivot speed `p`, set
`M=n*p` and

```text
rho_M(x)=min(x mod M, M-(x mod M)).
```

For a deleted index `k`, a deletion certificate consists of a surviving pivot
speed `p` and an integer `0<=r<M` such that `n` does not divide `r` and

```text
rho_M(r*a_i) >= p                       for every i != k.
```

This is exactly the canonical speed-valued pivot certificate for the
`(n-1)`-speed deletion at threshold `1/n`. At the rational time
`tau=r/(n*p)`, each surviving coordinate therefore has circle distance at
least `p/(n*p)=1/n`, hence at least `1/N`.

The certificate lifts to the deleted coordinate precisely under the closed
integer inequality

```text
N * rho_M(r*a_k) >= n*p.
```

Indeed division by the positive denominator `N*n*p` gives
`rho_M(r*a_k)/(n*p) >= 1/N`. Thus one lifting deletion certificate is already
a full closed `1/N` witness; no limiting or open-boundary argument is involved.

The conjectural deletion-pivot lifting principle (DPLP) says that for a
primitive tuple above the coefficient-three height cutoff, if some speed is
divisible by `N` and every deletion has at least one certificate, then some
deletion certificate satisfies this final inequality. Its implication to
unrestricted positive-integer LRC is exact. Assume a least counterexample in
moving dimension and divide by its common gcd. Put `t=floor(N/3)`.

- If the maximum speed is at most `N+t`, then `t>0`, `3*t<=N`, and
  `threeHeight_family_witness` gives the contradiction.
- If no speed is divisible by `N`, time `1/N` is a witness: every nonzero
  residue modulo `N` has cyclic distance at least one.
- In the remaining case, lower-dimensional LRC and
  `positiveIntegerConjecture_iff_pivotCertificateConjecture` give a deletion
  certificate for every `k`. DPLP selects one that lifts, and the preceding
  calculation contradicts the original tuple.

The base dimensions are already verified separately. Consequently DPLP would
prove `PositiveIntegerConjecture`, and
`conjecture_iff_positiveIntegerConjecture` would then prove the standard real
conjecture.

The first unsupported statement is DPLP's cross-deletion correlation. A
finite exact audit found no failure in 243,973 primitive premise-satisfying
tuples, but this is `computed` evidence only. The stronger raw lifting claim is
false at `(1,3,4,7)` for `N=5`; no speed there is divisible by five and the
separate time `1/5` branch works. This counterexample fixes the premise but
does not prove the corrected principle or LRC.

`DeletionPivotLifting.lean` now maps the sound calculation exactly.
`DeletionPivotCertificate` retains the surviving pivot, canonical candidate,
and every surviving closed inequality.
`DeletionPivotCertificate.ExceptionalGood` is the displayed exceptional
cross-multiplication.
`DeletionPivotCertificate.exists_full_witness_of_exceptionalGood` constructs
the explicit time. `CorrectedDeletionPivotLiftingPrinciple` records the exact
`n>=2`, positivity, injectivity, primitivity, strict-height, divisibility, and
all-deletions contract, while
`exists_full_witness_of_corrected_deletionPivotLiftingPrinciple` checks its
selector order and derives the witness conditionally. These implications are
`proved-lean`; the contract is an open proposition, and no declaration proves
that DPLP holds.

There is also an exact single-coordinate count useful for attacking the
missing correlation. Put `m=n*p`, `g=gcd(a,m)`, and `h=gcd(a,p)`. Among
canonical candidates, the strict deep-hole set

```text
N*rho_m(r*a) < m
```

has cardinality

```text
g*(1+2*floor((m-1)/(N*g)))
  - h*(1+2*floor((p-1)/(N*h))).
```

The ordinary deletion-bad set `rho_m(r*a)<p` has cardinality

```text
g*(1+2*floor((p-1)/g))
  - h*(1+2*floor((p-1)/(n*h))).
```

Multiplication by `a/g` permutes the quotient residues modulo `m/g`, with
exactly `g` preimages per image. Subtracting the candidates `r=n*s` uses
`rho_(n*p)(n*s*a)=n*rho_p(s*a)` and introduces `h`. Their difference is the
exact shell capacity. This is `proved-math`, not yet Lean-formalized. It does
not count residues bad for exactly one coordinate, so the weighted
shell-surplus inequality across different pivots remains open.
