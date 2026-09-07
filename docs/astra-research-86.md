# Pass 86: private regions and exact forced-arc completions

For a hypothetical strict failure, minimal by moving count and then primitive
speed sum, this pass connects the actual deletion-good sets to a constructive
cover decomposition. The argument uses n>=3 moving speeds. Every attained
collision forces its specific original arc into
every cover at an intermediate width, and also at the open target width
`alpha=1/(n+1)`. The remaining arcs can complete that forced family in two
disjoint classes. This is a uniform manuscript result; the arithmetic saving
needed for a contradiction remains unproved.

Choose one actual private point in each forced arc. No other original arc
contains that point. These points cut the circle into independent interval
problems: every nonforced arc lies in one cell, and only the two neighboring
forced arcs enter it. The uncovered part of each cell is either empty or one
closed interval, including the possibility of a singleton. If f is the
reciprocal cost of the forced arcs and kappa_j is the minimum nonforced
interval-cover cost for that gap, then the exact full-grid optimum is

`f + sum_j kappa_j`.

The forced intersection graph consists of paths or a single circle-covering
cycle. Every uncovered gap has multiplicity at least two in the remaining
family: an arc that alone covered a point would itself be forced. Sorting
intervals by left endpoint and assigning the next interval to the color with
the smaller current maximum right endpoint gives two colors covering every
such point. The proof handles open endpoints, ties and singleton gaps.

Thus two full original-grid covers share exactly the forced arcs and partition
all other arcs. Choosing the cheaper color separately in each cell gives
an actual cover of cost `(n+f-B)/2`, where B is the sum of the absolute
cellwise cost differences. No center or speed is changed in this construction.

The cost gap remains substantive. With full bad multiplicity M and full
maximum `mu<alpha`, private-region measure is
`2alpha + integral (M-2)_+` and is at most `2mu*f`. Hence `f>1`.
The coarse two-cover estimate cannot reach `(n+1)/2` by assuming `f<=1`.
A proof that the cellwise saving B reaches `f-1` would contradict the strict
cost bound for an open cover, but no such arithmetic inequality is supplied.

Actual private points also sharpen the arithmetic of overlapping forced arcs.
For labels a,b and their positive determinant D,
`alpha*abs(a-b) < D < alpha*(a+b)`.
If speed 1 is present, a forced neighbor must have speed divisible by n+1.
Neither the presence of speed 1 nor a needed forced adjacency is established.
These restrictions do not yet bound all nonforced completion costs.

An exact control explains why repairing only deletion-good sets is insufficient.
At test margin `5/12`, `(5,8)` covers both complete private regions of the
old tuple `(1,2)`, but leaves a robust hole at `t=5/16`, where both old speeds
were bad. The test margin exceeds the native margin `1/3` and the replacement
increases the sum, so this does not refute a descending replacement under
canonical strict failure. It identifies the overlap regions that a valid
descent must control; the completion construction handles those regions.

Independent review accepted both manuscripts without corrections, and root
read both authors and reviews in full. The integration receipt binds their
sources and checks. These are manuscript proofs, not kernel verification.
No new Lean declaration, numerical search, local
build or dependency restoration is part of this pass. The unrestricted
canonical proof/disproof goal remains unresolved.

Pass 85 merged through PR84 at `9f276366960df7a55c1f934d4f52fae1169a62fb`.
Both required remote checks passed, followed by thirteen fetched-main file
hashes and head/parent ancestry checks.
