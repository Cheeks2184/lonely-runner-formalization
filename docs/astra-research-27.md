# Twenty-seventh Astra checkpoint: finite-family frontier and packet limits

Pass 26 merged the kernel-checked equivalence
`LonelyRunner.Conjecture ↔ LonelyRunner.AllInclusivePrimitiveFiniteFamilies`
(PR 25). Neither side is independently proved: the unrestricted Lonely Runner
Conjecture and the all-count bounded primitive finite-family obligation remain
open. This checkpoint records later manuscript audits only; it adds no Lean
theorem and does not change the previous source build or trust audit.

## Accepted adaptive transfer and its limit

The frozen [cardinality-adaptive audit](../research/astra-cardinality-adaptive-affine-audit.md)
(SHA-256 `a71e55b7…`) and its [independent review](../research/astra-cardinality-adaptive-affine-review.md)
(SHA-256 `09dd14f8…`) establish a conditional construction.  A nowhere-zero
collision row with `c` distinct positive magnitudes receives the sharper
lower-count margin `1/(c+1)`, rather than a fixed `1/(N-1)` margin. Under the
exact lower-count hypothesis `H_N`, the stated error bound transfers this to a
canonical `1/N` witness for the chosen runner. The construction preserves
closed inequalities and supplies positive time.

Only **distinct adjacent ratio values** imply collision nonvanishing. Equal
adjacent ratios can give a zero coordinate; the accepted theorem itself
explicitly requires every collision coordinate to be nonzero.

This conditional result does not provide a universal endpoint packet. For
`N=5`, consecutive speeds `(0,1,2,3,4)`, and chosen runner `0`, folding reduces
all denominators to eight rows and 48 comparison pairs. Eighteen pairs have a
zero coordinate, eight have `c=2`, and 22 have `c=3`; all fail the adaptive
budget. The original tuple still has the direct witness `t=1/5`, so this is
not a counterexample to `F_N` or to LRC. Separately, `(0,1,2,7,8)` at runner
`0` has error `1/8`, accepted by the adaptive budget `2/15` but above the old
fixed budget `1/20`; this is a concrete additional fixture covered by the
adaptive transfer.

## Two proposed supply routes fail at their stated scope

The frozen [combined audit](../research/astra-combined-affine-supply-audit.md)
(SHA-256 `87fd780d4…`) and [independent review](../research/astra-combined-affine-supply-review.md)
(SHA-256 `857ab982…`) refute the specific
disjunction: a reciprocal time `1/d` for `2 ≤ d ≤ N`, or an adaptive endpoint
packet. For `N=4`, `(0,1,3,4)`, and runner `0`, folding yields six rows and 18
pairs: four have a zero collision coordinate and the other 14 have `c=2` but
insufficient margin. The reciprocal branch also fails. Yet `5/12` and `3/7`
are actual witnesses, and the tuple belongs to an existing bounded-height
covered class. This does not address any disjunction augmented with existing
height or insertion methods, nor does it identify a minimal counterexample.

The [exact-rounding audit](../research/astra-exact-rounding-scope-audit.md)
(SHA-256 `ba16410b…`) and [independent review](../research/astra-exact-rounding-scope-review.md)
(SHA-256 `37c5d7c3…`) establish the exact rounding displacement
`|t-y| = ‖βτ‖/p`. Free exact-loss selection
is equivalent to ordinary witness existence through a binary-cut pair-sum
encoding; retaining the collision’s own-count margin is a different contract.
For four consecutive speeds, the latter endpoint-packet supply fails for all
`q`, `u`, and `τ`: `‖H t‖ = ‖w_last τ‖` would demand at least `1/3`, while the
only closed `1/4` witnesses modulo one are `1/4` and `3/4`, with endpoint norm
`1/4`. These are accepted manuscript results, not Lean theorems.

A bounded [screen of Kumar’s March 22, 2026 Zenodo proof candidate](../research/astra-kumar-proof-screen.md)
rejects its strict target at `N=3` and a separate finite nesting claim at
`p=2`, including an `n=11` control. It does not assess LRC itself.

The next justified work is a supply argument outside these refuted packet
classes, while preserving the exact finite-family and chosen-runner scope.
