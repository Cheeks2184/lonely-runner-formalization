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

1. Complete the real-to-integer reduction. Exact denominator clearing and the
   all-dimensional repeated-rational bridge now compile; the live central
   piece is the one-way multidimensional Kronecker orbit-closure theorem.
2. Make bounded modular certificates kernel-checkable by encoding and checking
   selected-parent intersection data.
3. Prove or refute the exact uniform pivot-certificate proposition now known
   in Lean to be equivalent to the positive-integer conjecture. Pivot-grid
   completeness is no longer an assumption; the remaining issue is uniform
   avoidance of the finite arithmetic bad-set union. The bounded computation
   is evidence only.
4. Formalize the two irrational rank-one-block theorem using a torus-density
   lemma.
5. State and test the exact distinguished-coset zonotope equivalence without
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
