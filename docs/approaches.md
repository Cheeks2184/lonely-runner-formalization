# Candidate approaches

This is a research map, not a list of claimed proofs. Each route terminates at
an obligation that is currently open in general.

## A. Modular witnesses, finite checking, and sieving

For a prime or modulus `p`, search for one shared numerator `a` such that all
least absolute residues of `a v_i` are large enough. A modular witness gives
the real witness `t = a/p`.

The current concrete version chooses a tuple speed `a_j` as pivot, uses
denominator `(n+1)a_j`, and represents every other runner's violating
numerators as a finite bad set. Exact gcd/ceiling formulas count individual
bad sets, while a two-parent certificate retains selected pair/triple overlap.
The candidate/bad residue model, explicit real witness bridge, and abstract
union and ordered-overlap implications now compile in Lean; see
`docs/modular-pivot-certificates.md`. The exact gcd/ceiling count for each bad
set also compiles in Lean. The remaining certificate trust boundary is the
selected-parent intersection data and its per-tuple encoding.

Dependencies:

1. Exact floor/ceiling conventions for the central forbidden residues.
2. A proved implication from a modular certificate to the real inequality.
3. Treatment of coordinates divisible by `p` and primitive gcd normalization.
4. A finite-height theorem for a minimal counterexample in each dimension.
5. Proof-carrying exhaustive certificates for the remaining tuples.
6. A uniform structural result in the dimension, without which this proves
   only finitely many dimensions one at a time.

The [twenty-fifth checkpoint](astra-research-25.md) now supplies item 4 for
primitive sorted configurations under the exact lower-count hypothesis H_N:
all heights above [N(N-1)]^(N-2) have a kernel-checked canonical witness for
every chosen runner. The retained inclusive finite assertion F_N remains
unproved uniformly in N. The [twenty-sixth checkpoint](astra-research-26.md) now formalizes general
signed normalization, original-label/time transport, and count induction,
proving canonical LRC equivalent to all inclusive F_N. It does not supply
items 5 or 6. The accompanying reviewed endpoint-packet audit also proves
that this specified small-error mechanism cannot cover all retained tuples,
even though its large-height application is valid.

The Pass 27 reviewed audits sharpen this boundary: fixed and adaptive endpoint
packets, even with exact retained-margin rounding, do not supply every case.
Free exact-loss selection is equivalent to an actual witness and therefore is
not an independent supply principle. These results do not exclude unions with
the existing height or insertion methods; a viable route must add a genuinely
new supply argument.

Pass 29 adds an accepted conditional exact two-anchor constructor: a stronger
mixed witness plus a nonzero second-anchor inequality yields an exact packet
with true count `c=N-2`. Here mixed means that every original norm is at least
`1/N` and the fastest norm is at least `1/(N-1)`. For `N>=3`, an independently
reviewed manuscript proves that stationary exact `S` is equivalent to the
mixed condition over both real and rational witnesses; its `N=3` all-half
case supplies the zero-loss packet. This is not a uniform supply theorem. The
accepted one-deletion family `W={1,...,N} minus {a}`, for `N>=4`, `2<=a`, and
`2a<=N`, gives both signs over the frozen author's full analytical ranges,
with a separate `N=2a` boundary formula. It is already within the verified
bounded-height ordinary-witness class, so it adds no ordinary LRC coverage.

Pass 30 kernel-checks a sharper finite-height reduction with total count `N`
and inclusive finite cutoff `B=choose(N,2)^(N-2)`. The large-height branch is
stationary and uses `B<H`; normalization preserves the zero label, while
strong count induction makes canonical LRC equivalent to
`AllSharperInclusivePrimitiveFiniteFamilies`. This replaces no uniform supply:
the all-count finite-family premise remains open. It is a factor `2^(N-2)`
smaller than the previous cutoff, while preserving the older public API.

Pass 31 rules out a local route to direct-or-mixed supply. The raw N=3 union
fails exactly for `(a,2a)` with `3` dividing `a`, but primitive N=3 still
succeeds. A complete ordinary-good component without a mixed point has a sharp
endpoint-owner lattice: positive width forces every oriented right upper owner
to be at least `N`, while `s=0` is singleton-only. The primitive family
`{3,...,N} union {N^2-2N-1}` realizes the bound but has a mixed witness in a
different component. This direct-or-mixed route must account for normalization and cannot rely
on staying in a supplied component. Primitive uniform supply and LRC remain
unresolved.

Pass 32 kernel-checks a zero-residual strengthening of the affine transport
pipeline. With `N=m+2>=3` and `B=choose(N,2)^(N-2)`, under the lower-count
hypothesis a sorted primitive stationary tuple with `B<H` has a single
positive time at which every norm
is at least `1/N` and the fastest is at least `1/(N-1)`. The old ordinary
theorems remain projection wrappers, and under the same lower-count, sorted,
stationary, and primitive hypotheses a no-mixed premise implies `H<=B`.
This does not give an arbitrary-runner cutoff or remove the finite-family
supply obligation. Its independent exact-patch review and guarded root replay
passed.

The accepted strict-to-mixed audit gives necessary conditions for a separate
global question, not a supply theorem. A possible counterexample has primitive
lower core. At `N=4`, it must be pairwise coprime `a<b<H` with `b>=4` and
`b<H<4b`; 2,330 narrowly direct-eligible tuples are exact diagnostics only.
There is no proof of the global condition K or unrestricted LRC.

Pair-sum completeness is now proved for each already witnessed positive
integer tuple: a finite floor-cell minimum returns an exact certificate without
discarding repeated labels or closed endpoints. This replaces the former
fixed-tuple formalization gap, but leaves the uniform certificate supply open.

Obstruction: CRT does not allow a different favorable numerator for each
coordinate; all conditions share one time. This route has been highly effective
through the currently verified finite boxes but gives no known uniform
argument for all dimensions. In particular, exhaustive two-parent success for
primitive tuples of 3--6 moving speeds through maximum speed 30 supplies
neither a minimal-counterexample height bound nor an unbounded-speed theorem.

The boundary-pivot lemma in `docs/round6-strategies.md` shows that these pivot
grids are complete for a fixed positive-integer instance: if any witness
exists, a safe-set boundary point is a witness on one of the grids. This
removes the concern that the grids are an ansatz, but it is logically
conditional on the instance already having a witness and therefore does not
prove the conjecture.

## B. Fourier, measure, and inclusion-exclusion

For a threshold `eta`, integrate the product of the good-arc indicators
`1_[eta,1-eta](v_i t)` over one period for integer speeds. Positive integral at
a subcritical threshold supplies a witness, and compactness can then approach
the closed boundary for a fixed integer tuple.

Dependencies:

1. A rigorous trigonometric minorant or Riesz product.
2. Exact retention of every resonance `sum h_i v_i = 0` after integration.
3. A uniform lower bound on the full signed resonant contribution.
4. Positivity for every threshold below `1/(n+1)`.

Obstruction: at the exact threshold a tight tuple may have only isolated good
times, so positive measure is stronger than LRC. Pairwise independence is also
false because the orbit is one-dimensional. Known analytic methods improve the
elementary `1/(2n)` scale but do not reach `1/(n+1)`.

## C. Torus and lonely-runner zonotopes

For primitive integer velocities, quotient the cube along the velocity line to
obtain a lattice zonotope. The original problem becomes a lattice-point
question in one distinguished coset.

Dependencies:

1. Formal Smith-normal-form/lattice quotient construction.
2. Both directions of the exact time/lattice-point equivalence.
3. Projection and degeneration lemmas.
4. A lattice-point theorem at the exact factor, including equality cases.

Obstruction: replacing the distinguished-coset claim by a universal
covering-radius claim is the shifted LRC, which is false. Existing zonotope
theory yields powerful finite checking and spectrum structure, not the missing
uniform lattice-point theorem.

## D. Quantitative fast-runner induction

Assume the `(k-1)`-coordinate theorem and take a witness with old threshold
`1/k`. Circle distance is Lipschitz, so a time interval around that witness
retains the weaker threshold `1/(k+1)`. If the new speed is sufficiently larger
than every old speed, that interval cannot lie entirely inside one of the new
runner's bad intervals and therefore contains a full `k`-coordinate witness.

Dependencies:

1. One-Lipschitz circle distance in Lean.
2. The robust witness interval and exact slack calculation.
3. The fast-runner insertion lemma with audited endpoint constant.
4. A reduction or classification of the remaining comparable-speed tuples.

This is the most immediate route to a nontrivial formally verified partial
theorem. Its obstruction is also precise: primitive comparable tuples are not
bounded merely by normalizing their gcd.

## E. Exact computation and interval certificates

For a fixed integer tuple, `min_i ||v_i t||` is continuous and piecewise linear
on `[0,1]`. Its maximum occurs in a finite, explicitly enumerable superset of
triangular-wave peaks and intersections. A disproof certificate would instead
be an exact rational interval cover by the bad-time sets.

Dependencies:

1. A proved finite-extrema or interval-cover certificate theorem.
2. Exact rational generation and checking.
3. Lean verification of each certificate format.

This lane is decisive for a fixed tuple or finite search box. It does not turn
finite checking for each `n` into a proof of `forall n`.

## F. Pair-sum critical spectrum

For a positive integer tuple with at least two entries, the new finite-cell
theorem proves witness/candidate completeness: any supplied closed witness
gives a time `r/(a_p+a_q)` for distinct original indices, including repeated
speeds and the half-cell fallback. This is kernel checked and makes the
pair-sum candidate search complete for a fixed witnessed tuple.

Candidate denominators are bounded by `max_{p<q}(a_p+a_q)`. For a sorted
pairwise-distinct tuple this is `a_(n-1)+a_n <= 2a_n-1`.

The older global-maximum identity for `min_i ||a_i t||` remains a manuscript
statement, not a new kernel declaration. Its finite spectrum has no uniform
speed bound, so neither result supplies certificates in every dimension. See
`docs/round6-strategies.md` and the [formal completeness checkpoint](astra-research-28.md).

## G. Codimension-one divisor insertion

If deleting one speed leaves gcd `D`, lower-dimensional LRC can be lifted by
shifts of size `1/D`. The exceptional coordinate visits an equally spaced
orbit of size `m = D/gcd(D,a_j)`, and the exact sufficient inequality is
`(n+1)(m-1) >= 2m`. This covers a rigorously identifiable arithmetic class.

Obstruction: it requires the lower-dimensional theorem. The deletion-gcd-one
conclusion is valid for a minimal-dimensional primitive counterexample (or
after the previous dimension has been established), not for an arbitrary
counterexample. The insertion theorem and its translated coprime-grid lemmas
are formalized in `LonelyRunner/DivisorInsertion.lean`; see
`docs/round6-strategies.md` for the corrected corollary.

## Current priority

The project is now in **FULL-PROOF PRIORITY MODE**. The authoritative ranking
is the contract table in `docs/full-proof-roadmap.md`:

1. deletion-pivot lifting (DPLP);
2. integral top-two, then unrestricted all-pivot certificates;
3. minimal-counterexample height compression.

DPLP is the closest new induction bridge. For an original `n`-speed tuple and
`N=n+1`, lower-dimensional LRC gives each deletion an exact pivot certificate
at threshold `1/n`. DPLP asks whether, when some original speed is divisible
by `N`, one may choose a deletion certificate whose deleted coordinate also
satisfies the closed `1/N` inequality. If so, the same rational time witnesses
the full tuple. The other two branches handle maximum at most
`N+floor(N/3)` by the verified coefficient-three theorem and tuples with no
`N`-divisible speed by the direct time `1/N`. This would close induction.

The statement is conjectural. Exact finite enumeration finds zero failures in
243,973 premise-satisfying tuples, but raw lifting is false at `(1,3,4,7)`
outside the divisibility premise. The single missing step is a uniform
cross-deletion correlation theorem; nonemptiness of the deletion certificate
sets alone does not provide it. The earlier relocation-uniformity route is
rejected because every global additive optimum is relocation-local, and the
known all-pivot additive counterexample has no subthreshold global optimum.

The coefficient-two Gamma material below is retained as an audited milestone,
not a primary optimization program. Its continuation rule is recorded in the
roadmap.

Completed milestones are the canonical and stationary equivalences, the
one-moving-runner base case, the quantitative fast-runner insertion theorem,
and the exact fixed-tuple checker. The live priorities are now:

1. Attack the positive-integer formulation now proved exactly equivalent to
   the canonical real conjecture. The entire BHK real-to-rational reduction,
   including its endpoint topology and finite-dimensional collision argument,
   now compiles.
2. Use the now-complete exact pair-fiber arithmetic specialization. Lean
   decomposes every strict pivot bad set into exact-target fibers, transfers
   the raw simultaneous-congruence gcd count, subtracts exactly the raw
   residues divisible by `N` via `q -> N*q`, and sums the resulting closed
   counts. The analogous exact three-equation compatibility and gcd count is
   also kernel-checked, including the pivot-candidate subtraction and exact
   pair-target/triple-target cell used by the two-level construction. The
   remaining obstacle is an ordering or bounded-depth inequality, not
   evaluation of a pair or triple intersection.
3. Attack the optimized additive ordering principle without a fixed-rate
   surrogate. Uniform random ordering and the GCD-rate exponential clock now
   both have exact all-pivot counterexamples, while favorable deterministic
   orders survive on those tuples. Two-sided one-item relocation descent has
   a kernel-checked finite descent and block-cost identity, but its uniform
   arithmetic premise is now rejected. The later OPT-ADD counterexample `G`
   has global minimum cost at least the strict threshold at every pivot; each
   such global minimum is automatically two-sided relocation-local. A
   regression cross-checks the clean-room exhaustive optima against the
   independent relocation tables. Progress therefore requires a criterion
   stronger than additive-order cost, not another local-search rule for that
   same objective.
   A separate repaired front-loaded construction uses at most three fixed
   anchors and the Lean-checked two-level residual-subfiber credit. Exact
   tables cover the earlier hard tuples, but `3-ANCHOR-UNIF` is false:
   `(10,37,45,51,54,56,61,71,91)` has minimum corrected three-anchor costs
   at or above `n*a_j` at every pivot. One- and two-anchor sets do no better.
   The same tuple has an adaptive full-order certificate `84 < 90`, so the
   fixed-anchor failure does not close optimized additive ordering.
   Double averaging the second- and third-anchor gains gives the stronger
   `ANCHOR-STAR-UNIF` inequality. Its generic implication and exact values are
   independently verified, and the abstract strict-average selection theorem
   is now in Lean. The third-anchor term has a rigorous cellwise
   lower bound `Gamma_j(h) >= Delta_j(h)`: `Delta` is the normalized sum of
   pairwise absolute differences between exact candidate-filtered triple-
   congruence profiles inside every nonbad first-anchor subfiber. This avoids
   the failed zero-target-only and aggregate-cell bounds. However,
   `(8,15,35,40,48,56,68,75,78)` has strictly negative best margins at every
   pivot for both `ANCHOR-STAR` and the stronger sufficient
   `DISPERSION-STAR` premise. These averaging routes are therefore closed.
   A min/max/sum range-sum bound is exact through six runners and narrows this
   to `RANGE-SUM-STAR`, but it becomes lossy at seven runners and is strictly
   refuted by the same nine-speed tuple. Averaging the pair part gives an exact
   point-multiplicity deficit identity. Attempts to pay that deficit using only
   first and second profile moments fail on a mandatory fixed-clock tuple, and
   fixed-row deletion is nonmonotone. The averaging counterexample does have
   a pivot-15 triple of cost `133 < 135`, but the later exact counterexample
   shows that exceptional triples are not uniform. Any completion of this
   finite-cover lane must now use genuinely adaptive full orders or a
   different state-adaptive cross-pivot principle.
   For the full-order objective, each bad child-target fiber can be treated as
   a token selecting one earlier parent with its exact intersection weight.
   Valid orders are exactly maximum-weight selectors whose parent-to-child
   support is acyclic. Both optimization directions and their exact modular
   instantiation are now kernel-checked. Restricting tokens to globally best
   parents gives a weighted feedback-cycle sufficient condition, but
   `TOP-CYCLE-UNIF` is false: the primitive tuple
   `(5,28,35,40,68,88,108,148,165)` has no strict top-only pivot. Independent
   literal implementations reproduce every row, including equality at pivots
   `5` and `35`. Lower-ranked parents matter: at pivot `28`, unrestricted
   cost is `250 < 252` although top-only cost is `258`. The direct time
   `3/140` is lonely. Thus unrestricted `OPT-ADD-UNIF` was the next stronger
   target after the top-parent restriction; it is itself rejected below,
   without rejecting LRC.
   The exact full-weight refinement expands each token into nested unit
   threshold layers. Its loss is the number of layers whose entire supporting
   parent set remains later, so it retains every lower-ranked rescue and gives
   the unrestricted Bellman recurrence without choosing ties. Conditioning on
   a prefix and topologically ordering the SCC condensation of the active
   layer-support graph yields a sound `B_core` bound. It repairs the tuple
   above at pivot `28`: prefix `(35,40,88)` has prefix loss `24`, residual SCC
   loss `14`, and total `38<40`. A third implementation checked the layer
   identity over 537,700 predecessor subsets. The remaining obstruction is
   arithmetic rather than graph-theoretic: no proof forces some pivot to have
   a prefix with `B_core` below its strict budget, and large SCCs can make the
   randomized compression much weaker than the exact Bellman optimum.
   A three-step block bound retains a short nested deletion chain while
   remaining much cheaper than the full Bellman DP. Its exact theorem gives
   `B_3<=B_1`; an independent exhaustive subset verifier matches every stress
   row. At the difficult tuple above, pivot `165` has `B_3=187<211` although
   the one- and two-step bounds are `259` and `219`. This bounded-depth route
   is not uniform: the primitive tuple
   `(8,15,35,40,48,56,75,132,147)` has `B_3>=beta` at every pivot, with the
   sole equality at pivot `75`. Independent literal implementations reproduce
   the complete table. At fixed pivot `15`, the three-step bound fails while
   unrestricted additive cost is `131<135`; at fixed pivot `8`, additive cost
   is exactly the threshold while residue `13` is an exact pivot witness.
   These are fixed-pivot separations only, not separations of the existential
   uniform statements. At this stage the frontier returned to `OPT-ADD-UNIF`
   and the still stronger exact pivot-certificate proposition. The generic block
   concatenation, strict/non-strict budget propagation, exact final-block
   length, and comparison with one-step peeling are kernel-checked in
   `BlockPeeling.lean`; the rejected modular uniform premise is not encoded.
   For the full fixed-pivot objective, the subset Bellman DAG has an exact
   unit-flow formulation and potential dual. With `V(empty)=0`, dual
   feasibility is `V(Q)-V(Q\{i})<=delta_i(Q)`, and Bellman's value attains the
   maximum. Thus failure at pivot `j` is exactly a pivot-specific feasible
   potential with top value at least `beta_j`. This reformulates, rather than
   removes, the uniform quantifier obstruction: simultaneous failure supplies
   a different potential for every modulus. On `F`, the full margins are
   `(0,4,16,-6,-30,-18,40,-54,-27)`. Their sum is `-75`, and with
   `ell=lcm(F)=646800`, the natural common-subgroup weighting gives
   `sum_j (ell/a_j) M_j=-279450`, equivalently
   `sum_j M_j/a_j=-1863/4312`. Any viable cross-pivot argument must therefore
   retain nonlinear incidence correlations rather than only normalized
   per-pivot margins.
   The exact unrestricted uniform condition is now rejected by
   `(15,21,40,48,56,105,126,280,1200)`. Its pivotwise optimized surpluses are
   `(0,-31,0,-32,-2,-2,-62,-48,-24)` in speed order: every value is
   nonpositive, and equality at pivots `15` and `40` is insufficient. Two
   independent literal implementations reproduce the full
   `(S,F*,soft-optimum,Dopt,9A)` table, and one enumerates all `8!` orders at
   every pivot. The direct residue `39` at pivot `48` gives time `13/160`, so
   this rejects only `OPT-ADD-UNIF`.
   A sound direct strengthening drops global acyclicity but retains whole
   token-parent overlap blocks. If their use count at every residue is at most
   its duplicate-incidence capacity `mu(r)-1`, then their total credit is
   bounded by `S-|union B_i|`. Every additive order induces such a packing,
   but cycles are allowed. On the earlier tuple `F` at pivot `8`, a verified
   24-block packing has credit `34`, versus additive credit `32`, and proves
   `|union B_i|<=70<72` (the literal union is `68`). Turning this fixed-instance
   packing into a uniform CRT theorem is open. `OverlapCapacity.lean`
   kernel-checks the incidence double counts, subtraction-free capacity
   inequality, and an abstract ordered-parent dominance theorem. The exact
   optimization is a multiple-choice hypergraph b-matching, not generally a
   max-flow problem: three unit-capacity two-point blocks on a triangle have
   integer credit `2` but fractional credit `3`. The active frontier is therefore
   the exact pivot-certificate proposition, equivalent in Lean to the
   positive-integer conjecture.
   A reproducible exact/interval packer decomposes the conflict hypergraph,
   removes provably nonbinding residues, and uses replay-checked integral lower
   bounds with combinatorial and grid-dual upper bounds. It rescues `G` at
   pivot `56` with credit `400>392`, and also at pivots `105` and `1200`.
   Five other `G` pivots have proved exact optima; remaining rows are explicitly
   intervals. Every one of eleven fixed stress tuples has some strict packing
   pivot. This is evidence for the stronger route, not a cross-pivot theorem.
4. Prove or refute the exact uniform pivot-certificate proposition now known
   in Lean to be equivalent to the positive-integer conjecture. Pivot-grid
   completeness is no longer an assumption; the remaining issue is uniform
   avoidance of the finite arithmetic bad-set union. The bounded computation
   is evidence only.
5. Formalize the two irrational rank-one-block theorem using a torus-density
   lemma.
6. State and test the exact distinguished-coset zonotope equivalence without
   strengthening it to the false shifted problem.

## Common-LCM correlation hierarchy and signed replacement

Put every pivot candidate grid into `Z/(N*ell)Z`, where
`ell=lcm(a_1,...,a_n)`. If `d(s)` is the number of pivot candidate slices
containing `s` and `k(s)` is the number of strict bad events at `s`, then

```text
sum_j safeCandidates(j) = sum_s d(s) * 1[k(s)=0].
```

Writing `H_q=sum_s d(s) C(k(s),q)`, the alternating polynomial of positive
depth `d` gives

```text
L_(n,d) = sum_(q<2d) (-1)^q H_q + (2d/(n-1)) H_(2d)
          <= sum_j safeCandidates(j).
```

The pointwise proof must separate `d(s)>0` from `d(s)=0`: only on a candidate
slice is `k(s)<=n-1`. After clearing the positive denominator, the exact
identity is kernel-checked by `correlationPolynomial_cleared_eq`, with the
nonpositivity and rational indicator consequences in the same module. On
`G`, exact arithmetic gives the genuinely sub-tautological value
`L_(9,2)=3305/2>0`. This is a valid fixed-tuple proof of at least one exact
pivot certificate. It is not yet a uniform argument, because the verifier's
full histogram contains the desired zero-count already. Moreover, whenever
`2d>=n-1`, all relevant nonzero coefficients vanish and the hierarchy reduces
to exact inclusion--exclusion. The live route is therefore to obtain and
bound the low moments directly from CRT-compatible runner intersections.

Separately, suppose `a_k=q*b`, `gcd(q,N)=1`, and for every unchanged pivot
`j` one has `b congruent to +a_k or -a_k (mod N*a_j)`, while positivity and
distinctness survive. Old-pivot strict bad sets agree. A new-pivot
certificate for `b` maps to one for `a_k` by `r -> q*r`. Thus certificate
existence for the replaced tuple implies it for the original tuple, and an
all-pivot counterexample descends contrapositively. This is not bidirectional
at the changed pivot. The example `(1,2,3,24)->(1,2,3,6)` audits exactly;
the tuple `G` has no eligible replacement. Progress by this lane needs a
structural theorem forcing an eligible replacement in every minimal
counterexample or sharply classifying the irreducible remainder.

The low-moment formula obligation is now closed. Expanding
`C(k(s),q)` over square-free `q`-subsets of runner indices reduces `H_q` to
pivotwise intersections. Each strict bad condition is a disjoint family of
linear congruence classes; generalized CRT compatibility counts the common
class, and adjoining `r=0 (mod N)` subtracts the excluded pivot candidates.
The formula handles empty subsets, self-pivot zero terms, repeated numerical
speeds as distinct indices, and closed good endpoints. Its primary evaluator
reproduces `G`'s first five moments without constructing a zero count or full
histogram. The abstract finite double count and pointwise-to-weighted-sum
deduction are kernel-checked in `WeightedZeroCount.lean`, where the
`weight>0` hypothesis explicitly guards the `k<=n-1` premise.

Uniform fixed depth is rigorously impossible for this polynomial. For
`A_n=(1,...,n)`, exact safe times are the primitive fractions `m/(n+1)`, so
the total safe pivot-incidence count is `n*phi(n+1)`. The two residues
`r=+1,-1` at pivot `j` have bad multiplicity `j-1`, which yields

```text
L_(n,d)(A_n)
  <= n*phi(n+1) - (2/(n-1))*C(n-1,2d+1).
```

Consequently every fixed `d` gives negative scores for infinitely many `n`.
Even `d=(n-3)/4` is negative for every `n congruent to 59 mod 60`, while
`t=1/(n+1)` remains an explicit certificate. This rejects fixed depth and one
substantial linear rule only. It does not exclude arbitrary adaptive depths,
other feasible moment polynomials, or a cross-pivot theorem using more than
the numerical moments.

Allowing every feasible polynomial of a prescribed degree gives an exact
finite LP rather than a new heuristic. In the binomial basis, the primal
maximizes `sum_q c_q H_q` subject to `P(0)<=1` and `P(k)<=0` for every positive
grid value. Its dual minimizes zero mass among nonnegative pseudo-histograms
matching the available moments. Every nonzero degree-`r` primal vertex has
`P(0)=1` and `r` positive integer roots with an explicit adjacent-pair sign
pattern. Exact enumeration therefore supplies rational primal and dual
certificates without a floating-point solver. It improves `G` to a positive
degree-3 bound and T10/T11 to degree-5 bounds.

Even this optimized closure fails uniformly at fixed order. For any fixed
`r`, low-totient consecutive tuples can be chosen so that the safe mass is
smaller than the forced negative contribution of the literal `+/-1` pivot
incidences for every nonzero feasible vertex. All nonzero vertex objectives
are then negative, while the zero polynomial has value zero, proving that the
exact optimized LP value is zero. This is an infinite arithmetic theorem, not
an arbitrary moment-twin construction. A surviving route must let the order
grow with `n` or use CRT table information discarded by the numerical
moments. `ConsecutiveCorrelationObstruction.lean` formalizes the weighted
hockey-stick identity and the abstract denominator-cleared histogram bound;
the consecutive histogram and totient estimates remain outside Lean.

The original polynomial's adaptive-depth behavior is now exact on the tight
consecutive family. Let `c=floor(n/2)`. For every `n>=84`, the first positive
depth is `c-2` for even `n`; for odd `n` it is `c-2` exactly when
`3*n*phi(n+1)>(n-2)*(n-3)`, and otherwise `c-1`. The proof classifies every
bad-count layer above `floor(n/2)` as having multiplicity exactly two, derives
the two near-cutoff scores in closed form, and uses additional `+/-1,...,+/-5`
incidences to rule out depth one without assuming score monotonicity. All
intermediate depths are excluded by binomial unimodality. Both cutoff gaps one
and two occur infinitely often. Hence this adaptive polynomial is
near-tautological even on `(1,...,n)`; a useful general bridge must use a
different growing-order shape or retain more arithmetic structure.

Response 41 supplies such a different shape for this test family. A shifted
Chebyshev polynomial of degree `O(sqrt(n) log n)` is one at multiplicity zero
and lies in a short nonpositive interval at every positive multiplicity. Its
score on the consecutive histogram is therefore positive. The derivation,
however, explicitly uses `D_0=n*phi(n+1)>=n`, already obtained from the known
lonely times, so it is not a noncircular proof of pivot noncoverage. The live
question is whether its binomial-moment objective can be proved positive for
arbitrary tuples directly from the generalized-CRT intersection formula.

Two arithmetic constraints are also exact. If some `2<=q<=N` divides no
speed, `t=1/q` is immediately lonely; a counterexample must therefore cover
every such modulus. If one pivot speed is a coprime integer multiple of
another, scaling the candidate numerator injects the smaller pivot grid into
the larger while preserving its entire strict bad vector along the image.
Both kernels are formalized in `SmallDenominatorWitness.lean` and
`CrossPivotScaling.lean`. Neither constraint by itself forces a safe point.

Finally, in the comparable regime `a_n<n*a_(n-1)`, the largest-speed signed
replacement exists exactly when `a_n=q*b`, `b=N*a_(n-1)/(q+1)`,
`2<=q<=N-2`, and every lower pivot satisfies one of two explicit divisor
conditions. This sharply describes the descent-irreducible remainder but does
not eliminate it. See `docs/response41-audit.md`.

Response 42 makes the Chebyshev computation noncircular for arbitrary integer
tuples: its forward-Newton score is evaluated entirely through the direct CRT
moments, with no `D_0` or full histogram. Exact finite searches find some
positive pivot in five near-consecutive boxes and a 4,276-tuple mutation
family. The missing step is still uniform: no accepted CRT-table inequality
forces a positive pivot for every tuple.

Its separate two-hole argument is a genuine unbounded structured theorem.
Every distinct positive-integer `n`-tuple with maximum at most `n+2` is
lonely. The proof selects a denominator between `n+2` and `2n+2` whose two
residues adjacent to zero are exactly the missing speeds. This now supplies a
height restriction `max>=n+3` on any integer counterexample. Extending the
construction to more than two holes is a live route. See
`docs/response42-audit.md`.

That live route now yields a stronger partial theorem. With four holes in
`[1,N+3]`, choose one `c<=N`. Either `1/c` works, or the interval
`[N+c+4,2N]` contains a number coprime to `c`. The only obstruction to the
simple residue-count proof is `phi(c)<=6`; the complete exceptional list and
a finite `(N,q)` table close every `N>=12` case. An exact 2,982-case
certificate closes `N=4..11`, using a three-residue inverse witness in two
small configurations. Therefore maximum `n+4` is sufficient and a
positive-integer counterexample would have maximum at least `n+5`. The
computer-assisted small range is not yet Lean-formalized; see
`docs/height-n-plus-4.md`.

The fourth Sol Pro round produced two valid but limited structured-class
lemmas. The fifth produced exact modular certificates and a bounded dataset,
then retracted an incorrect claim that the simple union bound subsumed the
band theorem. The sixth produced three independently audited finite-structure
lemmas but no all-dimensional implication; its proposed two-parent pattern
already has two exact failures at eight moving speeds.

## H. Exact boundary-to-pivot reduction

For a nonempty finite family of positive integer speeds and `N >= 2`, follow
the segment from time zero to any safe witness and take the finite minimum of
the circle norms. Continuity and the intermediate value theorem give a safe
boundary time at which some pivot coordinate has norm exactly `1/N`. The two
signed grid forms are normalized by integer Euclidean remainder modulo
`N * a_j`; integer phase invariance then gives a canonical candidate residue.

This argument is kernel-checked in `LonelyRunner/PivotBoundary.lean` as
`exists_safe_pivot_residue` and the exact bidirectional interface
`exists_witness_iff_exists_pivot_certificate`. Its specialization
`positiveIntegerConjecture_iff_pivotCertificateConjecture` copies the
quantifiers of `PositiveIntegerConjecture`, including positivity,
injectivity, `1 <= n`, and denominator `n+1`. The reverse implication is the
previously checked `pivotResidueWitness`. Thus the grid ansatz is complete;
the open step is the all-tuples modular certificate theorem itself.

## I. Fixed-pivot Fourier expansion

The candidate filter and each strict cyclic bad-set indicator have sparse,
explicit normalized Fourier transforms. Multiplication by another speed
restricts Fourier support according to `gcd(a_i, N*a_j)` and reduces the
remaining coefficient to a Dirichlet kernel on the quotient cycle. Pointwise
multiplication by the nondivisibility filter is an explicit `N`-term
convolution. The complete formulas and strict-endpoint audit are in
`docs/fourier-pivot-badsets.md`.

Obstruction: the elementary Dirichlet bound does not control the combined
nonzero spectrum of the product of all good-set indicators at the sharp
threshold. More strongly, factorwise absolute main-term domination fails at
the certified tuple `(1,2,3)` and can change truth value under algebraically
equivalent factorizations. A uniform signed-cancellation estimate,
positive-definite/Riesz-product construction, or an arithmetic pivot-selection
lemma remains open.

## J. Exact integer induction cover

`LonelyRunner/IntegerInduction.lean` now packages fast insertion,
codimension-one divisor insertion, the minimum-scale bands, and exact pivot
noncoverage into one checked induction interface. The sharp residual
dichotomy is: either divisor insertion applies, or some pivot candidate is
uncovered. Lean proves that this principle is equivalent to
`PositiveIntegerConjecture`, so it identifies the exact obstruction but does
not reduce its logical strength. Exact finite searches, counterexamples to
simpler structural and bounded-overlap covers, and reproduction commands are
in `docs/integer-induction-cover.md`.

## K. Missing-height denominators

For an `(N-1)`-element integer speed set in `[1,N+t]`, at least one missing
height `c` lies at most `N`. If `2c>N+t`, the reciprocal `1/c` is an immediate
witness. Otherwise denominators in `[N+c+t+1,2N]` make both residues adjacent
to zero correspond to absent heights. The interval omits at most `2t` residue
classes modulo `c`. The bound `phi(c)>=sqrt(c/2)` closes the construction
whenever `16*t^2+t<=N`.

At `t=4`, exact totient classification plus a finite certificate proves the
stronger all-dimensional max-speed `n+5` theorem. More strongly, the elementary
factorization estimate

```text
c/phi(c)<=omega(c)+1<=Nat.log 2 N+1
```

shows that `(4*(Nat.log 2 N+1)+1)*t<=N` is sufficient. This gives an
unconditional height gain asymptotic to `N/(4*log_2 N)`. Lean now checks the
whole logarithmic theorem: missing-height extraction, the reciprocal branch,
the sharp totient product, both interval-selector branches, and the closed
inverse-residue witness. See `docs/height-n-plus-5.md` and
`docs/height-logarithmic.md`.

## L. Quadratic Chebyshev moment test

The exact Chebyshev score admits the sound pointwise minorant

```text
P_n(k)>=1-k+alpha_n*choose(k,2),
```

where `alpha_n>0` is the minimum permitted coefficient. However, the primitive
tuple `(1,3,5,6,7)` has `H_0-H_1+alpha_5*H_2<=0` at every pivot, even though
three full Chebyshev scores are positive and `t=7/30` is a direct lonely
witness. Thus the quadratic sufficient condition is rejected as a uniform
route. The full score and exact pivot-certificate proposition remain open;
see `docs/quadratic-chebyshev-failure.md`.

## M. Complementary-hole Gamma incidence

For coefficient two, the sound relation sends a missing base height `c` to
every occupied-range complement `d` for which `c+d` is an above-height
two-hole denominator and `gcd(c,d)=1`. No-witness assumptions force all such
neighbors to be occupied extras. The exact remaining Hall condition is
equivalent to a triangular coprime-pair theorem for every large pair of
subsets of the candidate and extra intervals.

Kanold blocks now give an exact degree bound after extending through the
coprime-free `Auto` suffix. A bounded classification removes every empty and
singleton neighborhood above `N=19`; hence a new failure must be a connected
deficiency-one critical core with both incidence degrees at least two.

Pomerance's primary coprime-interval theorem also closes the generic active
range `2*t<=N<3*t` for all sufficiently large `N`, via two crossed even
rectangles of common length `2*floor(t/4)` and disjoint right images. The
cutoff is existential. The elementary rectangle coverage, strict/closed sum
bands, conditional coprime-injection splice, and fixed least-start reversal
class are now Lean-verified; Pomerance's analytic matching theorem is not
formalized or assumed in Lean. See
`docs/coefficient-two-gamma.md`.

For any fixed saturating matching, Lean now proves that tight left subsets are
exactly successor-closed subsets avoiding every vertex with an unmatched
right neighbor. Strict Hall is equivalent to every left vertex reaching such
a vertex. This gives a linear audit after constructing a matching, but it is
not yet a uniform arithmetic construction. A completed descending matching
already has a tight dependency block at `(N,t)=(20,10)`, despite the full
Gamma graph being matchable. Current work therefore attacks augmenting paths
with tight-block contraction, additional non-diagonal edges beyond the
feasible reversal totals, and endpoint prime-support overload. The bare
`DIAGONAL-HALL` statement is false at `(N,t)=(36,16)`: every diagonal row is
nonempty, yet `{20,22,24}` has only `{41,43}` as neighbors, while the full
Gamma graph has an explicit SDR. The exact surviving gaps are
`GAMMA-AUGMENT` and `ENDPOINT-OVERLOAD`; see `docs/response54-audit.md`.

Response 56 corrects the contraction route. Unrestricted contraction to a
core with no proper tight block is vacuous: every co-singleton of a nontrivial
critical deficiency-one set is tight, so it contracts immediately to one
isolated left vertex. The meaningful repair contracts only nonspanning tight
blocks and retains the original common-puncture certificate `(K,D)`. Its
terminals are noncanonical, and only necessary cut/span inequalities are
known. The active arithmetic target is now `COATOMIC-GAMMA-EXCLUSION`, with
the puncture data retained.

Two-total layer unions admit an exact chain decomposition: for
`Delta=Q1-Q0`, collisions lie in arithmetic `Delta`-chains and Hall is
equivalent to contiguous-block inequalities on each chain. This explains the
inward collision at `(36,16)` but does not select totals uniformly. The
conditional J1 class and every arbitrary feasible single-total reversal are
Lean-verified; fixed J1 shift families of size at most three already fail at
`N=20`, so current work requires adaptive backward/reflection choices or a
growing total family.
