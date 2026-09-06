# Thirty-first Astra checkpoint: direct-or-mixed component obstructions

Pass 31 records accepted manuscript analysis and exact finite replay evidence.
It adds no Lean source or proof of unrestricted LRC. Pass 30
remains the latest Lean checkpoint: its pinned full build passed 3,638 jobs and
its trust audit accepted 432 permitted-only axiom reports. No fresh build was
run for this documentation checkpoint.

## Two-hole family and fixed controls

The [two-hole author manuscript](../research/astra-two-hole-mixed-supply.md),
[independent review](../research/astra-two-hole-mixed-review.md), and
[fixed controls](../research/astra-two-hole-mixed-controls.md) are accepted at
their stated scope. For `N>=4`, `N-1` distinct positive speeds with maximum
`H<=N+1` have either a direct reciprocal certificate or a mixed witness: every
ordinary norm is at least `1/N` and the fastest is at least `1/(N-1)`.

The root replayed the guarded controls exactly: 16 positive rows, 3 direct
rows, 13 mixed rows, 81 ordinary coordinate comparisons, and 2 range guards.
They are finite evidence; the family was already ordinarily covered by
`boundedHeight_stationary_witness`, so this is no new ordinary coverage or
unrestricted supply theorem.

## Accepted uniform audit

The [uniform author audit](../research/astra-uniform-direct-mixed-audit.md) and
its [independent Astra review](../research/astra-uniform-direct-mixed-review.md)
are accepted at manuscript scope. The guarded author artifact has SHA-256
`6054472d7412bdb9c5a3c258191f58cf260d50c6240d81eecce05f3be3ba138b`;
its sole program and exact replayed stdout have SHA-256
`cf160dd62d224fa675219fd36efac9c4b6703f9f799c656449d1cee00dd0dc4e` and
`e0697cefe8f43ed0554396fc9bb4e7977cd5619e02c4c88c600115de2bfce486`.
The exact diagnostic domains have 351, 1,506, and 2,406 eligible primitive,
direct-covered tuples at total counts 4, 5, and 6 respectively. Four raw
failures, four residue fixtures, and six sharp-family fixtures are recorded;
these are diagnostics, not an unbounded enumeration theorem.

At total count `N=3`, raw direct-or-mixed failure occurs exactly for
`W=(a,2a)` with `3` dividing `a`; these pairs retain an ordinary witness.
Primitive N=3 succeeds, so the raw classification is neither a primitive-union
failure nor a counterexample to LRC. It makes no claim that this N=3 form
classifies failures at higher counts.

For a complete ordinary-good component without a mixed point, an oriented
right upper owner `a<H` has the integer endpoint invariant

```text
0 <= s < a/(N-1),     s congruent to -(H+a) mod N.
```

Here `s=0` forces a singleton component; positive width forces `s>=1` and
therefore `a>=N`. The bound is sharp. For every `N>=4`, the primitive family
`W={3,...,N} union {H}`, with `H=N^2-2N-1`, has a trapped positive-width
component with owner `a=N` and `s=1`, yet an explicit global mixed witness in
another component. It refutes component-preserving conversion, not primitive
uniform supply.

The remaining research obligation is to normalize and compare across
components. General LRC and primitive global direct-or-mixed supply remain
unresolved. The separate strict-to-mixed audit is ongoing research and is
excluded from this checkpoint.
