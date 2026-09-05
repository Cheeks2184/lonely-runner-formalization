# Astra research checkpoint 2

The full unrestricted Lonely Runner Conjecture remains unresolved. This pass
formalizes the previously reviewed zero-kernel family criterion and develops a
separate, restricted affine-grid bridge. The automatic operating instructions
remain project-local in `.codex/config.toml`; no `AGENTS.md` or global instruction
change is involved.

## Formal zero-kernel family result

`LonelyRunner/PivotZeroKernel.lean` defines the literal candidate-filtered zero
set and proves its exact size

`|Z(N,p,d)| = gcd(d,N*p) - gcd(d,p)`.

For `N>=2` and `0<d<p`, it proves `(N+1)|Z| <= (N-1)p`. Divisibility between
the modulus gcds gives inclusion of zero sets. For `N>=3`, the two distinct
residues `1` and `N*p-1` belong to every lower speed's bad set outside its zero
set. These are actual finite-set statements, not surrogates for the residues.

`LonelyRunner/KernelCoverCertificates.lean` combines the scalar bounds with
zero-set domination and that common pair. It handles empty and singleton
families as well as larger labelled families.

`LonelyRunner/OwnerKernelCover.lean` supplies the actual pivot-row adapter. If
`C` consists of positive speeds below `p`, `E` is a subset of its labels, every
nonempty zero set is contained in a zero set labelled by `E`, and

`2*(N+1)*|C| + (N-2)*|E| <= N*(N+1)`,

then the bad sets cannot cover the candidate row. A gcd-divisibility wrapper
provides a sufficient arithmetic domination premise. The final corollary
supplies the real time `r/(N*p)` and closed distance at least `1/N` for the pivot
and every labelled speed. Label injectivity is unnecessary; the numerical
condition still explicitly depends on the number of labels.

The original scalar bounds and generic finite-set infrastructure are reused.
No claim is made that a full hypothetical internal cover must satisfy this
criterion. In particular, `2*|C|>N` is beyond its reach even when `E` is empty.

## Exact fixtures

The following literal finite-set checks were repeated during integration.
They check interpretation and usefulness; the uniform result comes from Lean.

| N | Pivot | Lower speeds | Dominators | Criterion | Safe residues |
| --- | --- | --- | --- | --- | --- |
| 11 | 72 | 22,33,55,66,70 | 1 | 129 <= 132 | 256 |
| 7 | 24 | 7,10,14 | 1 | 53 <= 56 | 56 |
| 6 | 24 | 6,7,12 | 0 | 42 <= 42 | 48 |
| 7 | 11 | 1,4,5,6,7 | 1 | 85 > 56 | 0 |

The last row is a negative control for the fixed pivot, not an LRC
counterexample. For the first row the raw bad-set sizes sum to 728 against 720
candidates; subtracting only the common two-point duplication gives equality.
Thus the zero-kernel criterion supplies a strict conclusion beyond those two
simpler estimates.
Only the listed owners and pivot are controlled by this corollary. For example,
the first row controls six moving speeds at threshold `1/11`; it does not add
the four missing moving speeds of an eleven-runner instance. Other labels need
separate control before this local certificate can resolve a full instance.

## Affine route and verification

The separate manuscript is `research/astra-affine-grid.md`. Its field lemmas
were already proved in Lean in the first pass. The new Nat actual-pivot
application is now compiled as `affine_grid_pivot_witness` in
`LonelyRunner/AffineGrid.lean`, using the general arithmetic helper in
`LonelyRunner/AffineGridArithmetic.lean`. It distinguishes the odd field prime
from the external modulus and restores a real pivot coordinate when using the
`N-2` affine lemma. Its conclusion controls all `N-1` original moving speeds at
the required closed `1/N` threshold. The external modulus need not be prime.

The manuscript also supplies a dense family with an explicit witness for every
odd runner count at least five, including composite counts. This explicit
family argument does not remove the prime hypothesis from the general affine
theorem. The family specialization and product-free full-size Theorem A remain
manuscript results; the compiled actual-pivot theorem is a distinct contract.

The proposed universal small-base normalization is false: the tuple
`(2,3,4,5)` at `N=5` obstructs it for every external modulus, unit multiplier,
and independent coordinate signs. This tuple itself has the witness `1/7`.
Integration repeated 48,677 unit-multiplier checks for moduli 2 through 400;
the manuscript gives the uniform argument. This is a limitation of the route,
not a disproof of the conjecture.

Exact build, trust, source-hash and independent-review evidence is recorded in
`research/astra-pass2-verification.json`. The shared Lean cache remains needed
for the immediately queued extension to shifted grids and vanishing slopes.
No duplicate cache or large research dataset was created.
