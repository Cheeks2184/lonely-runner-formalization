# Rank-three transport leaves a bounded index and a coordinate problem

Pass75 merged through PR74 at
`93cdc554c4b15337aa6aa29450e88e7a628251d5`. Both CI jobs passed. Fetched main
matched the reviewed head, three source files, the verification receipt and
eight dependencies.

The new audit starts in the nonzero-fold case of a hypothetical ordinary
failure minimal by count and speed sum. Its old closest odd lift is `n`;
the smaller fold is `w=v-2n`. A global closest odd lift `m` for that fold
lies outside `span(v,n)`. In the saturated rank-three lattice, extend
`v,n` to a basis `v,n,u` and write `m=A*v+B*n+C*u`, with `C>0`.
Parity makes `A,C` even and `B` odd. Original global optimality forces
`B=-1 mod C`, permitting a normalized basis with `B=-1`.

The integer midpoint `(m+n)/2` is nonzero and has every coordinate between
zero and `v_i/2`, strictly below the latter. It therefore gives another
smaller tuple after the necessary normalization. Its plane with `v`
contains no odd integer vector, so it is not an improved old odd lift.

The divided primitive direction `U(u)` is short when `C` is large. Applying
the previously reviewed ordinary fibre criterion, with its half-cube
normalization retained, gives the strict restriction

    2 <= C < (R+r*|theta|)*d*(d+1)/2 <= R*d*(d+1) <= d*(d-1),

where `d=N-1`, `r` is the old radius, `R` the folded radius, and
`theta=2*tau-1` for the folded lift time. The index is even. This excludes
a uniform range of configurations; it does not bound all velocities or
settle the remaining indices.

Every old odd vector in this rank-three lattice has an explicit residual
at a valid common time. The best triangle upper bound using only `r`, `R`
and `theta` is exactly `r`, even after considering all such vectors.
Consequently a proof by this route needs actual coordinate cancellation
or a different retained invariant. The first-fold zero case also remains
unresolved. No failure-preserving iteration follows from the decreasing
speed sums.

Independent review accepted the complete manuscript without corrections.
Root read both reports and checked ten dependency bindings. Exact receipts
are in `research/astra-pass76-verification.json`. No Lean source, mathematical
program or dependency cache changed. The active coordinate-cancellation and
zero-restoration manuscripts are excluded from this checkpoint. The
unrestricted canonical proof/disproof gate remains unmet.
