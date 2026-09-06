# The geometric lift requires a selected lattice fibre

Pass72 merged through PR71 at
`c97ae49e6e2787acb48ed8f5a13ca9dd8856f5b4`. Both required checks passed.
Root verified the exact reviewed head on fetched main, three frozen source
hashes, eight dependency hashes, and the previous main's ancestry.

The geometric audit keeps ordinary LRC's particular central lattice coset.
A lower-count witness in a projection has a nonempty interval above it,
but an original witness requires that interval to meet its affine lattice.
The published short-direction estimate supplies enough interval length in
its stated range. Lower-count existence alone does not select a successful
fibre outside that range. A short fibre also does not make the projected
tuple a counterexample.

For the special central fibre, parity gives an exact simpler condition.
However, finding a primitive direction with both the required parity and
the required length is equivalent to finding the original witness. That
condition is retained as an equivalence, with no new supply claim.

The new rigidity argument rules out a specified method of transporting
witnesses. An integral affine map taking the entire smaller contracted cube
into the larger one while preserving the ordinary half-integer coset must
have one signed coordinate entry in each row. This holds for every lower
moving count of at least two. Compatibility with the velocity lines would
then force duplicate absolute speeds. At equal primitive count, the same
conditions force a permutation and preserve the speed sum. Thus this class
of maps cannot implement count or sum descent. The one-moving-speed case
is explicitly excluded; it permits the already solved all-odd class.

The result does not exclude maps that work only after taking the quotient,
maps depending on a chosen witness, or other operations preserving failure.
Those methods still need an actual successful lift or smaller counterexample.
The independent review accepted the complete audit without corrections,
including source dimensions, fibre constants, parity, translations, closed
boundaries and the exact scope of the rigidity theorem. Root read both
reports. Source bindings and administrative checks are retained in
`research/astra-pass73-verification.json`.

These are manuscript results. No Lean source, dependency cache, numerical
experiment, or fixed-count milestone changed. The existing finite-family
premise remains unresolved. A separate active investigation now studies
global optimality of the closest point in the required lattice coset; that
unfinished work is excluded from this checkpoint. Unrestricted LRC remains
the formal completion requirement.
