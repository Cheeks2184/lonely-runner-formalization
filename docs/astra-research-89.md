# Pass 89: maximum-speed endpoint cancellation

The new argument supplies actual smaller-frequency candidates on entire
private collision portions. In a hypothetical minimum-count, minimum-sum
canonical strict failure, let m be the maximum speed. Each forced m-arc has
both endpoints covered by original arcs of smaller speeds a and b. Neither
covering arc can contain the opposite endpoint, since that would also cover
the forced arc's private point. Their centers lie on the appropriate sides,
and the labels are distinct. The neighboring arcs need not be forced.

At any point of the whole indexed private portion, write
`e=mt-k`, `x=at-l>=alpha`, and `y=r-bt>=alpha`. The strict overlap bounds
and the contracted bound on e imply that

`(a+b-m)t-(l+r-k) = x-y-e`

lies strictly inside `(-alpha,alpha)`, with an explicit positive margin.
Consequently `u=|a+b-m|<m` is strictly alpha-bad on every point of that
portion. If positive, u is automatically absent from the retained speeds,
which are alpha-good there. This conclusion retains all components and
closed private boundaries, rather than treating one private point as a
substitute for the entire portion.

Consider all endpoint-covering choices for every attained maximum-speed
collision. If their positive candidate sets have a common u, it is bad on
the whole deletion-good set W_m. Outside W_m a retained speed is already
bad. Replacing m by u therefore preserves strict failure, with the same
number of distinct positive speeds and smaller sum. Compactness and gcd
normalization complete a genuine one-slot descent. What remains unproved
is existence of that common positive choice.

There is a precise alternative when a collision has only zero choices.
Each endpoint then has exactly one covering owner, with complementary
speeds `a+b=m`. Both endpoints are actual private points of those owners,
so the neighboring arcs are forced. Their lifted numerators satisfy
`l+r=k`, and their common determinant D obeys

`alpha*m <= D <= mu*(m+min(a,b))`.

The upper bound uses the full private-core contraction at the two endpoints;
it implies that the adjacent closed mu-cores meet the m-core. It does not
exclude this zero-only case or supply a positive replacement.

For every consecutive family `1,...,m`, at a test width strictly between
`1/(m+1)` and `1/m`, each primitive maximum-speed center has unique endpoint
owners given by complementary modular inverses. Their sum is m, so every
choice is zero. The actual maximum is the native `1/(m+1)`: this control is
LRC-good and only refutes an automatic nonzero-supply claim at larger widths.

Independent review and the integration receipt record the verification of
the frozen source. These are manuscript results, not kernel theorems. The
unrestricted proof/disproof remains unresolved. The next uniform issue is
positive candidate coherence, or a contradiction from the zero-only and
incoherent alternatives using canonical strict failure essentially.

Pass 88 merged through PR87 at `c63ea896f8218dce44ac270883867d7808c01a51`.
Both required remote checks passed; fetched main passed eighteen file-hash
and head/parent ancestry checks. No local build or cache restoration was
needed for this manuscript checkpoint.
