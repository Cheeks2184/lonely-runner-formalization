# Pass 92: exact zero-only contacts and deletion amplification

In the all-zero maximum-speed branch, the determinant bound is already
the exact local contact bound. For a forced m-arc with complementary
parents a+b=m and determinant D, the full original minimum on the whole
closed arc has its two contact maxima at

`(k+l)/(m+a)` and `(k+r)/(m+b)`,

with values `D/(m+a)` and `D/(m+b)`. Every nonparent is alpha-good there,
so the local maximum is exactly `D/(m+min(a,b))`. At either contact both
m and the contacting parent are below alpha. No single-deletion good set
contains that contact, so coordinate minimality cannot be propagated
from it as though it were a deletion witness.

Let nu be the maximum margin after deleting m. A nu-maximizer lies in
one of the complete private portions, where `nu<=D/m`. This recovers
`nu<=mu*(1+min(a,b)/m)` and does not establish the proposed stronger
recurrence `nu<=mu/(1-mu)`. Taking the maximum over all contact arcs and
their entire complement supplies no missing lower bound by itself.

The complete control `V={1,3,4,7}` has actual maximum mu=1/5 and deletion
maximum nu=2/7, violating that stronger recurrence. At every working width
strictly between 1/5 and 1/4, its full deletion set lies in two reflected
maximum-speed arcs with unique complementary parents 3 and 4. Thus all
attained maximum arcs are zero-only, all original times are covered, and
every coordinate deletion has a witness at margin 1/4. These broader data
still do not imply amplification.

The omitted hypotheses are explicit: the native maximum equals the native
threshold, and the fresh speed 2 is strictly bad on the entire deletion
set at the larger working width. Replacing 7 by 2 gives a smaller-sum
failure at that width. The control therefore violates native strictness
and replacement minimality; it is not a counterexample to canonical LRC
or to the recurrence with all minimal-failure assumptions restored.

The next mathematical obligation is to use those additional assumptions
to force improved contact or an actual larger value elsewhere. The
independent review and integration receipt establish the acceptance
status of these manuscript calculations. No new kernel theorem or
unrestricted LRC resolution is claimed.

The preceding checkpoint was delivered in PR #90, merged at
`fcfae157223d221734d248f62b413cd33d382e93` on 2026-09-07. Both required
CI checks passed on head `efc49c3806584c607d98c006927fb116442d9fc0`;
remote-main verification checked sixteen source hashes and head/parent
ancestry. This pass preserves the independent review correction: in a
maximizing gap, the right side of the proposed improvement inequality is
strictly positive, but the required lower bound remains missing.
