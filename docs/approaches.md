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
The abstract union and ordered-overlap implications now compile in Lean; see
`docs/modular-pivot-certificates.md`.

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
through the currently verified finite dimensions but gives no known uniform
argument for all dimensions. In particular, exhaustive two-parent success for
primitive tuples of 3--5 moving speeds through maximum speed 30 supplies
neither a minimal-counterexample height bound nor an unbounded-speed theorem.

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

## Current priority

Completed milestones are the canonical and stationary equivalences, the
one-moving-runner base case, the quantitative fast-runner insertion theorem,
and the exact fixed-tuple checker. The live priorities are now:

1. Formalize a precise real-to-integer reduction with its Kronecker and
   lower-dimensional dependencies exposed.
2. Complete the number-theoretic Lean layer for modular pivot certificates and
   make bounded certificates kernel-checkable.
3. Find or refute a uniform overlap theorem for the residual comparable-speed
   class; the speed-30 computation is evidence only.
4. Formalize the two irrational rank-one-block theorem using a torus-density
   lemma.
5. State and test the exact distinguished-coset zonotope equivalence without
   strengthening it to the false shifted problem.

The fourth Sol Pro round produced two valid but limited structured-class
lemmas. The fifth produced exact modular certificates and a bounded dataset,
then retracted an incorrect claim that the simple union bound subsumed the
band theorem. Their exact residual class is now a sharper target than the
undifferentiated phrase "comparable speeds."
