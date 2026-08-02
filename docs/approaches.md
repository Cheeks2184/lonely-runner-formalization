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

For a positive integer tuple with at least two entries, a global maximum of
`min_i ||a_i t||` occurs at `t = r/(a_p+a_q)` for two distinct indices. The
audited proof uses opposite slopes among active triangular waves, with the
value `1/2` handled separately. This gives a second finite candidate spectrum
whose invariant denominator bound is `max_{p<q}(a_p+a_q)`; the sharper
`2a_n-1` bound requires a sorted pairwise-distinct tuple.

Obstruction: the spectrum is finite only after the speeds are fixed. No bound
on a minimal counterexample's speeds follows from it. Formalization of the
piecewise-linear maximum argument remains open; see
`docs/round6-strategies.md`.

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
   orders survive on those tuples. Two-sided one-item relocation descent is
   the current precise state-adaptive candidate: its finite descent and block-
   cost identity are kernel-checked, and exact enumeration supports the hard
   tuples, but `RELOC-UNIF` is open. A completion still needs arithmetic
   control of every expensive local minimum, a sound stronger bounded-depth
   credit, or a counterexample to the optimized principle itself.
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
   `3/140` is lonely. Thus the surviving finite-cover target is unrestricted
   `OPT-ADD-UNIF`, not the rejected top-parent restriction, and neither this
   target nor LRC is proved.
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
4. Prove or refute the exact uniform pivot-certificate proposition now known
   in Lean to be equivalent to the positive-integer conjecture. Pivot-grid
   completeness is no longer an assumption; the remaining issue is uniform
   avoidance of the finite arithmetic bad-set union. The bounded computation
   is evidence only.
5. Formalize the two irrational rank-one-block theorem using a torus-density
   lemma.
6. State and test the exact distinguished-coset zonotope equivalence without
   strengthening it to the false shifted problem.

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
