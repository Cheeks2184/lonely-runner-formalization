# Twenty-eighth Astra checkpoint: pair-sum completeness

The new [PairSumCompleteness module](../LonelyRunner/PairSumCompleteness.lean)
proves a fixed-instance completeness result for finite pair-sum certificates.
The final source build passed 3,638 jobs; the trust audit accepted 427 reports;
and the independent exact-source review accepted 24 permitted-only axiom
reports. The unrestricted Lonely Runner Conjecture remains unproved and
undisproved.

## Formal finite-cell bridge

For at least two positive natural speeds, an arbitrary real witness with a
positive closed margin is normalized by its fractional part and placed in its
natural floor cell. The module chooses a minimum over **all ordered pairs** of
cell faces, including diagonal pairs. Its balanced helper returns a distinct
original pair, a positive numerator `r` strictly below the pair-sum denominator,
and a rational time preserving every closed band. Repeated speeds are allowed.

When the minimum is diagonal, its margin is one half. The proof then replaces
the diagonal labels by original labels `0` and `1`, retaining labels rather
than deduplicating speed values. This produces the same balanced equations and
the required distinct pair. The construction is finite: it makes no topology,
continuity, or global-maximizer claim.

Specialized to threshold `1/N`, with `n >= 2` and `N > 0`, the result proves
that a witness exists exactly when the existing `PairSumCertificate N speeds`
exists. The numerator has `0 < r < speeds p + speeds q`, and the closed
threshold is retained. Together with the existing BHK reduction and its
one-moving-runner base case, the module adds

```text
LonelyRunner.Conjecture ↔ PositiveIntegerPairSumCertificateConjecture.
```

Neither side of this equivalence is proved. The earlier canonical equivalence with all inclusive primitive finite
families also remains valid; neither uniform finite-family witnesses nor a
uniform pair-sum certificate supply has been established. The source,
[implementation record](../research/astra-pair-sum-implementation.md), and
[finite-cell contract](../research/astra-pair-sum-cell-contract.md) preserve
the exact scope. The [formal source review](../research/astra-pair-sum-formal-review.md)
is frozen at SHA-256 `7f4a4c4e…`.

## Reviewed single-anchor manuscript result

The [single-anchor completeness manuscript](../research/astra-single-anchor-completeness-audit.md)
(SHA-256 `206e70ab…`) and [independent review](../research/astra-single-anchor-completeness-review.md)
(SHA-256 `eb7190b…`) prove that its one-anchor packet conditions are equivalent
to a fixed positive-integer stationary witness: `E` is the exact rounding
bound and `C` retains the collision's own-count margin. Removing the final
anchor changes the packet class and gives an explicit constructor from an
already supplied balanced witness. The prior two-anchor counterexample remains
valid. The result does not choose an `H_N` time or provide a uniform witness,
and the packet theorem is not Lean. The new balanced cell helper is compatible
with the needed premise, but no full packet formalization is claimed.

The next obligation remains a uniform supply argument that can produce the
finite certificates or the finite-family witnesses in every dimension.
