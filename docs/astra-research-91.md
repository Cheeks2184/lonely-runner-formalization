# Pass 91: positive candidates and global coherence

The maximum-speed endpoint argument has exact arithmetic constraints.
At a private collision k/m, with residue R_a(k) of ak modulo m,
the complete left endpoint labels satisfy `0<R_a(k)<(m+a)/(n+1)`;
the right labels satisfy the reflected inequality. No retained speed can
be divisible by the reduced denominator q of k/m.

A single common time shift `1/[q(m+Q)]`, where Q is the largest retained
speed, then gives margin at least `m/[q(m+Q)]` for the entire original
tuple. Thus a hypothetical strict failure must satisfy

`q >= m/[mu(m+Q)] > (n+1)m/(m+Q) > (n+1)/2`.

Reflection exchanges the endpoint families and preserves their positive
candidate sets. Consequently a failure with positive candidates everywhere
but no common choice needs at least two distinct reflected pairs of
collisions, and at least two missing positive speeds below m. These are
necessary restrictions, not a general selection theorem.

The exact native-width control `V={1,5,6,7,8}` at alpha=1/6 shows why
local information remains insufficient. Its actual private collisions
are 2,3,5,6 modulo 8. Collisions 2 and 6 offer the fresh replacement 4;
collisions 3 and 5 offer the fresh replacement 3. Each replacement is
strictly bad on its entire associated private interval, yet their common
intersection is empty. Every smaller positive speed also has a suitable
witness in some actual private interval.

The full deletion set has two further components outside all maximum-speed
bad arcs. One contains the original-tuple witness 11/24, with minimum
margin 5/24>1/6. The control therefore refutes private-local coherence,
including freshness and separate replacement witnesses; it does not
satisfy the full strict-failure hypothesis. Both actual private-arc indices
and the larger nearest-index set are recorded, with no components omitted.

The remaining uniform task is to use the full-failure condition to obtain
a common positive replacement or another valid descent. The zero-only
branch likewise still needs a global argument. Independent review and
the integration receipt record acceptance of these manuscript results;
no new Lean theorem or unrestricted LRC resolution is asserted.

Pass 90 merged through PR89 at `7d5e9677d56d6ff4d04268c0829f0ee6cbade6c0`.
Both required CI checks passed. Fetched main passed seventeen file hash
checks and head/parent ancestry verification. No local build or dependency
cache restoration was needed for this manuscript checkpoint.
