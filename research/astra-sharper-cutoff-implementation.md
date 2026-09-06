# Sharper stationary finite-height reduction implementation

Source checkpoint: `5e7d690e6606ad096bf4a2319be0328f9c6d2e68`.
Requested assignment routing: Astra High, explicitly authorized by the user.

This additive implementation targets total runner count `N = m + 2`, `m >= 1`,
and inclusive finite cutoff `B = (Nat.choose (m + 2) 2)^m`. The large-height
branch requires `B < H` and produces a witness for the stationary minimum label
only. The original arbitrary-label theorem and old cutoff API remain available.

The endpoint approximation uses `Q = choose N 2`, `q <= Q^m < H` and `p=H/q>1`.
Its residual at label zero is exactly zero, so `|v_i-v_0| <= p/Q =
2p/(N(N-1))`, with no arbitrary-label triangle inequality. Rank, periodicity,
and the closed affine-witness threshold are inherited from checked lemmas.

Implemented bridge: append stationary zero to positive injective integer speeds;
normalize by sorting, translation, and gcd; prove translation zero and the
stationary label maps to normalized index zero; use strong count induction,
with the existing one-moving-runner (`N=2`) base and canonical real reduction.

Status: the three mathematical modules passed the pinned focused build, and
all five new theorem axiom probes passed. Full-source verification and the
global trust audit also passed.
No LRC resolution is claimed. No gcd-subset theorem or zonotope geometry is
asserted.

## Exact additive API

- `primitive_sorted_largeHeight_stationary_lonelyAt`: under the lower-count
  positive-integer hypothesis, every sorted primitive natural tuple beginning
  at zero with `B < H` has a positive-time lonely witness at label zero.
- `SharperInclusivePrimitiveFiniteFamily m`: every sorted primitive tuple
  beginning at zero with `H <= B` has a real-time witness for each label.
- `AllSharperInclusivePrimitiveFiniteFamilies`: the preceding obligation for
  every `m >= 1`.
- `nonnegative_integer_stationary_lonelyAt_of_lower_and_sharperFiniteFamily`:
  the lower-count and finite-family premises supply a witness for any zero label
  of an injective nonnegative integer tuple.
- `positiveIntegerAtCount_of_lower_and_sharperFiniteFamily`: the same two
  premises establish the stationary positive-integer statement at `m+1` moving
  runners.
- `positiveIntegerConjecture_of_allSharperInclusivePrimitiveFiniteFamilies`:
  strong induction supplies every positive moving count.
- `conjecture_iff_allSharperInclusivePrimitiveFiniteFamilies`: exactly
  `LonelyRunner.Conjecture ↔ AllSharperInclusivePrimitiveFiniteFamilies`.

The old API declarations and proofs remain byte-for-byte unchanged. The new
normalization bridge is conservative: nonnegativity forces `c >= 0`; evaluating
the factorization at the zero label forces `c <= 0`; hence `c = 0`. Injectivity
then identifies that label with `e 0`, and therefore `e.symm r = 0`.
The inverse scaling transports time as `T/g`, with `g > 0`.

## Boundary and scope checks

The case split is exactly `H <= B` versus `B < H`, so equality stays in the
finite family. No endpoint is lost. The affine error inequality is closed,
and `LonelyAt` retains the canonical closed distance threshold `1/N`. The
finite-family theorem does not assert a positive time; this is compatible with
the canonical conjecture's existential real time. The large-height branch
provides the stronger positive-time conclusion already furnished by the affine
lemma.

The all-count assumption begins at `m=1` (`N=3`). Total count `N=2` is handled
independently by `oneMovingRunner` in the strong induction. No arbitrary-label
version with the halved approximation base is asserted. The all-label finite
family is sufficient because the reverse direction consumes only its label-zero
instance after positive stationary normalization. Arbitrary real tuples enter
through the existing checked `conjecture_iff_positiveIntegerConjecture` bridge.

## Verification evidence

Pinned toolchain: `leanprover/lean4:v4.32.1`.
Pinned mathlib revision: `520045ab14e26149ee970e2e617ca04b09bde5d6`.
One shared dependency cache was restored using `lake exe cache get`; the pinned
manifest was retained.

- `lake build LonelyRunner.FiniteFamilyEquivalence`: passed, 3514 jobs.
  Log: `/tmp/astra-sharper-cutoff-build.log`.
- `lake env lean /tmp/astra-sharper-cutoff-axioms.lean`: passed. The probe imports
  `LonelyRunner.FiniteFamilyEquivalence`, runs `#check` and `#print axioms` for
  each of the five new theorems above, and prints the two finite-family
  definitions. Every theorem reports exactly `[propext, Classical.choice,
  Quot.sound]`. Log: `/tmp/astra-sharper-cutoff-axioms.log`.
- The repository's lexical trust scanner passed all three changed mathematical
  modules; `git diff --check` passed.
- Permanent axiom probes were added to `LonelyRunner/AxiomAudit.lean` after the
  orchestrator explicitly expanded ownership to this file.

Independent semantic review is maintained separately by the orchestrator and
reviewer in `research/astra-sharper-cutoff-review.md`. No independent acceptance
is asserted here before that review is delivered.

Stable mathematical source hashes (SHA-256, supplied for independent review):

| File | SHA-256 |
| --- | --- |
| `LonelyRunner/FiniteHeightReduction.lean` | `d6ebb1974372dd8356c76b57ce322a6a7ca076404c7049b968cad207469f3406` |
| `LonelyRunner/FinitePrimitiveFamilies.lean` | `023b39b29e7939dd18b29a51217c3e3fcf353ee5843f3bc3effb27012137e9f0` |
| `LonelyRunner/FiniteFamilyEquivalence.lean` | `475a46b9e10226f3de30628e595073a9765a8c03cb0ab071bdcc10acb6446be3` |
| `LonelyRunner/AxiomAudit.lean` | `c500b0996ad5defd4bbab337d17b8b9a448d7f2b9e901b3f11e53e25084452aa` |

The preserved original prefix and closing namespace/section suffix of each of
the three mathematical files were compared byte-for-byte with Git object
`5e7d690e6606ad096bf4a2319be0328f9c6d2e68`; all matched.

Final mechanical verification:

- `lake build`: passed, 3638 jobs. The restored project source dependency graph
  compiled successfully; existing linter suggestions did not block the build.
  Log: `/tmp/astra-sharper-cutoff-full-build.log`.
- `python3 scripts/audit_lean_trust.py`: passed the global lexical source scan
  and accepted 432 theorem reports. This includes the five new permanent probes;
  no report used axioms beyond `propext`, `Classical.choice`, `Quot.sound`.
  Log: `/tmp/astra-sharper-cutoff-trust.log`.
- Final `git diff --check`: passed.

Verification log SHA-256 values:

- `/tmp/astra-sharper-cutoff-build.log`: `853539e3920d549ea08652c2284bdf22f9198f5f08832ed0ba021717e192a65e`.
- `/tmp/astra-sharper-cutoff-axioms.log`: `f2698c2ae4dbd0c4f52be6b5893cfe5816e2f18fb07cb82bce5b58d28347f99a`.
- `/tmp/astra-sharper-cutoff-full-build.log`: `0f8d3f628d63198d98fae9e5d411e758f0a1e9573a2d7d62d33c568b1d7e1df7`.
- `/tmp/astra-sharper-cutoff-trust.log`: `b1cceb67c7bdfbf9d2e84e46dd2804b80f52a22d3ea5af3d543109a0f3fa2f87`.

This assignment's reduction/equivalence implementation is kernel checked. The
finite-family premise remains an unresolved mathematical obligation, so this
checkpoint does not prove or disprove the unrestricted Lonely Runner Conjecture.
No Git mutation, publication, workflow-state write, or cache cleanup was carried
out by this implementation worker. The orchestrator owns review integration,
publication, and the later coordinated cleanup.
