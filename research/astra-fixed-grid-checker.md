# Fixed-modulus A/B/R checker

`scripts/grid_normalization.py` decides the three predicates from Section 4 of
`astra-union-supply-audit.md` for exactly one supplied `(N, V, M, c)`. On its
accepted domain—odd-prime `N`, primitive pairwise-distinct positive tuple `V`
of length `N-1`, and valid `M`/unit `c`—`None` means precisely that A, B, and R
all fail for that fixed pair. It never makes an all-modulus claim. Invalid
inputs also return `None`; those are rejected inputs, not nonexistence evidence.
Pairwise distinctness is an intentional checker restriction even though the
manuscript's broader residue reduction can discuss repeated tuples.

The R search visits each attainable positive signed zero residue as `L`.  With
`D = N*L + M`, a row has a zero option iff `N | z`, `z >= L`, and
`z*D <= (N-1)*L*M`; it has an ordinary option iff `N ∤ z` and `z*D <= L*M`.
A row with base exactly `L` is forced zero.  This is the Section 4 inequality
system rewritten without signed-assignment enumeration, and is quadratic in
the number of rows.

Certificates include signs, common lift, positive actual transformed speeds,
and either the prescribed affine grid parameters or A's direct `1/N` witness.
The affine avoidance check uses the exact residue
`s * actual_i + r0 * base_i (mod N)`: a base and its transformed actual speed
need not agree modulo `N`. `verify_certificate` repeats input validation,
congruences, branch inequalities, lift conditions, affine arithmetic, and the
original-speed closed distance calculation without calling the finder. If a
proved residue predicate cannot be reconstructed as an affine witness, the
finder raises an internal error rather than reporting `None`.
