# Pass 84: global collision residues and height descent

This pass extracts arithmetic consequences of full replacement minimality in
a hypothetical strict counterexample with minimum moving count and minimum
primitive speed sum. The argument retains every component of each deletion's
good set. It gives a sufficient condition for lowering a speed, but does not
yet prove that some speed satisfies it. Unrestricted LRC remains unresolved.

Write `N=n+1`, `alpha=1/N`, and let the full tuple's maximum be `mu<alpha`.
For a deleted speed m, every deletion-good point has `m*t=k+e` with
`|e|<=mu`. Let K contain all attained collision residues modulo m. Minimum
sum forces every smaller positive frequency u to have a good point in the
whole deletion set, hence

`max_(k in K) dist(u*k,m*Z) >= m*alpha-u*mu > (m-u)/N`.

The left side is integral, giving the corresponding strict integer rounding.
Comparing u with m-u strengthens the lower bound to `max(u,m-u)/N`.
Conversely, a single u whose distances are all at most `(m-u)/N` blocks
the entire deletion set and transports failure to a smaller primitive tuple.
No such u is supplied by this pass.

In particular, `gcd(m,K)=1`: a common divisor g would allow replacement
by m/g on every component. For each divisor g of m there is an attained
residue at distance at least `ceil(g/N)` from `g*Z`. If m is a prime power,
some attained collision is individually coprime to m. This does not place
the collision center inside the deletion-good set or establish the unit
determinants needed by the earlier winding argument.

The distinction between collective and individual coprimality is essential.
For retained speeds `(1,5)` at test width `3/10`, the least covering
frequency is 6, but its attained collisions are exactly `{2,3,4}`.
All deletion components have positive length; every smaller frequency has
a strict good witness. A second exact control at width `1/3` checks the
closed boundary and singleton components.

These controls concern a single deletion. The tuple `(1,5,6)` is good at
its native margin `1/4`; moreover, at width `3/10`, its speed 5 can be
replaced by 2 while retaining full coverage. Thus the controls do not
refute a synthesis using all coordinate-minimality conditions together.
That coupled implication remains the research target.

Independent review accepted the manuscript without corrections. Root read
both complete documents and checked their hashes, dependencies, formatting,
workflow state and storage status. These are hand proofs and exact controls,
not new Lean declarations. No numerical search, local build or dependency
restoration was performed. The integration receipt records the exact checks.

Pass 83 merged through PR82 at
`37fbe1db726985a3254eac1ee7afcdc050e1faeb` after both required CI checks.
Fetched main passed seventeen file hashes and head/parent ancestry checks.
The active goal remains a full canonical proof or disproof for arbitrary N.
