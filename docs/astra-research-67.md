# Adapted-grid arithmetic and exact forward insertion

Pass66 merged through PR65 at
`600287d55a01d3c8c2d3bf4e4114eee4f9c1271e`; both required CI jobs passed
and fetched main contains the verified head. This checkpoint records
independently reviewed manuscript results about one proposed uniform finite
candidate family. No new Lean declaration or unrestricted LRC result is claimed.

For N total runners, the ordinary adapted grid uses times
`sum_i k_i/(N*v_i)`, with each digit between zero and N-1. The ambient
lattice of denominator `N*lcm(v)` contains a full witness whenever one
exists, but this does not give a representation with the bounded digits.
The new audit makes that distinction exact. For pairwise coprime speeds
at least N, all assignments give distinct times modulo one, no nonzero
multiple of 1/N belongs to the grid, and exactly two assignments per label
contact its canonical boundary. Each such assignment contacts only that label.

A tight tuple in this arithmetic class would therefore defeat the grid:
a full witness at an attained optimal margin below 1/2 needs contacts with
opposing slopes. No actual tuple satisfying both conditions is supplied.
The recursive family `v_1=N+1`, `v_i=N*product_(j<i)(v_j)+1` illustrates
the distinction constructively. It omits every supplied witness p/N from
the grid, yet its all-ones assignment is an explicit strict grid witness.
The exact bad-fiber incidence identity likewise isolates a missing overlap
bound, without proving it.

A separate root lemma turns a necessary grid condition into an exact
insertion test. For m old positive integer speeds, put
`L=lcm(v)`, `M=max(v)`, and `D=N*L`. An old grid assignment is
forward-good when every fractional phase lies in `[1/N,1-1/N)`.
For every displacement `0<tau<1/(D*M)`, the moved time is closed-good
for all old speeds if and only if that assignment is forward-good.
The common integer lattice prevents a bad phase from reaching a good
boundary or wrapping during that displacement.

If a new speed w is a multiple of D and satisfies
`w>(N-1)*L*M`, its phase at every old candidate is integral. Appending
the new digit gives a full closed-good assignment exactly when the old
assignment is forward-good and the new digit is nonzero. Thus the number
of full good assignments is N-1 times the number of forward-good old
assignments. The explicit choice `w=N*L*M` meets all conditions and
preserves distinctness. With `m=N-2`, an old forward-grid failure would
therefore give a complete adapted-grid failure on an admissible N-runner
tuple. It would refute this candidate family, not LRC.

The half-open condition has exactly two bad points on every N-point
coordinate fiber. The ordinary zero assignment supplies overlap redundancy
m-1, giving at least `(N-2*m)*N^(m-1)+m-1` forward-good assignments.
This is positive for `2*m<=N`, including equality. It does not supply the
necessary condition for `m=N-2` at general N. The result keeps the old
upper endpoint excluded and the inserted full target closed.

Both manuscripts have source-bound independent Astra reviews and root
full reads. A single bounded Terra High run tests their exact integer
predicate. It found a forward-good candidate for every one of the 1,140
increasing triples from 1..20 at N=5, and every one of the 1,820 increasing
quadruples from 1..16 at N=6. These domains test one necessary condition
for the uniform adapted-grid mechanism. They are bounded nonfindings;
no appended-grid obstruction or full-witness verification branch was
triggered, and no domain expansion follows from this result.
The retained executable performs integer tests and Fraction endpoint checks
using the same modular residues. Root read the frozen source and complete
output without rerunning the screen. Its first execution succeeded; one
patch-transport packaging retry and one Astra metadata clarification are
recorded separately. Total worker time and per-model usage are unmeasured.

The distinct analytical investigation of uniform forward supply remains
ongoing and is not incorporated as an accepted result here. A sufficient
condition on separated speeds would still require a proof that it, or an
alternative mechanism, covers arbitrary admissible tuples.

The canonical N=6 theorem remains established. Research continues toward
a uniform arbitrary-N mechanism. Conditional lemmas and finite controls
do not satisfy the unrestricted completion gate or justify restoring the
Lean cache by themselves.
