# Pass 88: strict depth and the remaining completion deficit

The whole deletion-good set is more tightly confined than its original
maximum-based bound suggests. For a hypothetical canonical strict failure,
let `alpha=1/(n+1)`, let mu be the actual maximum of the minimum norm,
and let Q_m be the largest speed other than m. Every point t in W_m satisfies

`||mt|| + m*(alpha-mu)/Q_m <= mu`.

The proof uses the whole interval of shifts of radius `(alpha-mu)/Q_m`:
all other norms remain strictly above mu there, so the m-norm must stay in
one closed mu-bad component. Taking endpoint limits gives the contraction.
This applies to all W_m points, including closed boundaries and singleton
collision components. It refines the existing Lipschitz trapping argument;
it does not supply a new common time or a descending replacement.

This contraction strengthens the previous pruning obstruction. For each
forced arc A, let H_A be its closed mu-core, U_A its unique-private portion,
and J_A its second same-center alpha-arc, if one exists. Both U_A and J_A
lie in the contracted core and are disjoint. If R sums the remaining measure
in the indexed cores, their exact capacity identity is

`2mu*f = P + 2alpha*C2F + R`.

Here f is the forced reciprocal cost, P is total private measure, and C2F
is the reciprocal cost of those second arcs. Combining this with the full
multiplicity identity and the tail cost C3 gives

`rho*f = 1 + S + E + R/(2alpha)`,

where `rho=mu/alpha<1`, `S=C3+C2F` is the entire same-center pruning saving,
and E is nonnegative. The contracted cores leave two boundary strips per
forced arc. With `L=sum_m |K_m|/Q_m`, those strips imply

`f-1-S >= (1-rho)*(f+L)+E > 0`.

Thus the whole nesting-based saving is insufficient, including the second
arcs not charged by the earlier C3-only estimate. No lower bound on the
additional color imbalance or a better completion is supplied.

Every outer alpha-minus-mu shell really is covered at closed width mu by an
arc at a different center. That fact alone does not give another removable
arc. For the uniform control `V={1,...,n}` at test width
`1/(n+1)<a<1/n`, the forced primitive cores already cover the entire circle
at the native closed maximum `mu=1/(n+1)`. Every shell is therefore covered
by other forced cores, while all nonforced arcs are same-center descendants.
The larger test width is essential: this is not a canonical strict failure.

Independent review accepted the frozen source without corrections; root read
the complete source and review. The integration receipt records their hashes
and the source checks. This checkpoint contains manuscript mathematics only.
The unrestricted Lean proof/disproof remains unresolved; neither a forced-cycle
exclusion nor a valid smaller-sum failure transport has been established.

Pass 87 merged through PR86 at `653c532a3d3a98816b4de63ceefce191c4c19c3c`.
Both required remote checks passed; fetched main passed sixteen file-hash
checks and head/parent ancestry checks. No local build or cache restoration
was needed for this manuscript checkpoint.
