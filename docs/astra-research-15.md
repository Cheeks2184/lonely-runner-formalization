# Fifteenth Astra research checkpoint

The arbitrary-height three-owner result now has a complete Lean implementation:
`LonelyRunner.threeLowerOwner_noncover_seven`. For every natural-number tuple
`0<a<b<c<p`, it supplies a candidate on the actual pivot's denominator-seven
row that is outside all three strict bad sets. The companion declaration
`threeLowerOwner_circleNorm_witness_seven` gives the same closed `1/7` witness
for `p,a,b,c`. Independent Astra review accepts the exact implementation.
The full build passed 3,613 jobs and the trust audit accepted 364 theorem
reports using only the permitted standard axioms.

The proof retains the reviewed exceptional-row argument. Exact gcd
normalization gives the ordinary row bounds. If an owner equals `7p/8`, each
other owner's contribution outside that row is strictly below `15p/8`.
The six exceptional normalized pairs are checked by Lean's kernel at small
base pivots, and a proved common-scaling identity supplies every positive
multiple. If no owner is exceptional, the three raw counts are at most `2p`
each, and their shared bad candidate `1` makes the union strictly smaller
than the `6p` candidate row. No finite search substitutes for the unbounded
pivot quantifier.

Supporting modules add five exact normalized-count arithmetic lemmas and
three general periodic counting lemmas. The latter include the exact count
`(N-1)*(p/L)*|S|` for candidates whose residue modulo `L` belongs to a supplied
subset `S`, provided `L|p`, `gcd(L,N)=1`, and `S` lies within that period.
The actual pivot need not be coprime to `N`; zero pivots and `N=1` are included
in this helper's stated domain. These counting interfaces do not supply an
arbitrary bad-set pattern on their own.

The separate sparse-owner audit proves at independently reviewed manuscript
scope that four distinct genuine lower owners cannot cover at denominator
nine, again without a speed-height cutoff. Its proof classifies four possible
exceptional owners and all 68 relevant normalized pairs. A tuple with pivot
`6160` demonstrates a sufficient case beyond the earlier numerical owner
criterion. This theorem is not yet part of the published Lean result.

The attempted generalization still needs a new argument. At denominator 15,
the pair with pivot `272` and speeds `255,240` defeats the proposed uniform
bound on each individual remainder. The larger family in that audit has an
explicit safe candidate, so this refutes only the sufficient pair bound.
Neither the general sparse-owner claim nor unrestricted LRC is resolved.

A separate guard audit verifies a conditional way to turn a correctly sized
lower-owner cover and a strict witness into a counterexample to the internal
redundancy proposal. No such input was found. Its solver semantics and 440
small oracle comparisons were independently checked; the larger timed-search
negatives remain explicitly author-reported and are not a general theorem.

Evidence and exact theorem contracts:

- [Three-owner source](../LonelyRunner/ThreeLowerOwnerSeven.lean) and
  [implementation record](../research/astra-three-owner-formalization.md), with
  [independent formal review](../research/astra-three-owner-formal-review.md).
- [Periodic counts](../LonelyRunner/PeriodicPivotCounts.lean),
  [arithmetic helpers](../LonelyRunner/ThreeOwnerSevenArithmetic.lean), and
  [independent helper review](../research/astra-periodic-arithmetic-review.md).
- [Four-owner manuscript](../research/astra-sparse-owner-supply-audit.md) and
  [independent review](../research/astra-sparse-owner-supply-review.md).
- [Conditional guard audit](../research/astra-guard-internal-cover-audit.md) and
  [qualified independent review](../research/astra-guard-internal-cover-review.md).

The formalized result protects precisely three lower speeds and their pivot.
It does not protect additional arbitrary speeds or declare the unrestricted
canonical conjecture or its negation.
