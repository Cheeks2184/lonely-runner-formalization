# Twenty-third Astra checkpoint: a constructive mirrored-block family

Unrestricted Lonely Runner remains unresolved. This checkpoint supplies an
unconditional witness construction for a structured family with unbounded
integer height and unbounded even runner count. It also closes the audit of
a proposed speed-complement descent without claiming that descent succeeds.

## Exact family and formal scope

For integers m>=1 and p>=2m+1, take the full configuration

    T = {0,...,m} union {p-m,...,p}.

Its two blocks are disjoint and contain exactly N=2m+2 runners. The new
formal development supplies a positive real time for each chosen runner,
with distance at least 1/N from every other original runner. The time may
depend on the chosen runner. The boundary is closed, the label map is
injective, and no earlier witness or conjectural induction premise is
assumed. The canonical bridge uses the existing `LonelyAt` definition.

The [core source](../LonelyRunner/MirroredBlockWitness.lean) constructs the
stationary-zero witness. Writing p=N*k+r, it chooses 1/N when r>=m+1,
and (k+1/N)/(p-m) otherwise. The proof checks every original speed directly
through a closed integer phase band. `mirroredBlockTime` records this formula,
but the current public theorem states existence; there is no separate public
correctness theorem for that named definition.

The [family source](../LonelyRunner/MirroredBlockFamily.lean) verifies the
cardinality, signed relative differences, reflection, and the labelled
canonical statement. For a lower chosen runner r, put P=p-r. All nonzero
relative magnitudes lie in [1,m] or [P-m,P]. If P<=2m+1, time 1/N works
directly; otherwise the core construction applies. Reflection s -> p-s
handles the upper chosen runners. Repeated absolute magnitudes retain the
original denominator N.

The [core manuscript](../research/astra-mirrored-block-witness.md) and its
[review](../research/astra-mirrored-block-review.md), followed by the
[all-runner extension](../research/astra-mirrored-block-all-runners.md) and
[review](../research/astra-mirrored-all-runners-review.md), give the complete
mathematical derivation. Frozen manuscript headers retain their original
submission status; the later independent reviews record acceptance.

## What the complement audit establishes

Replacing a selected speed a by p-a can decrease the speed sum, with an
additional decrease in count when duplicates appear. The
[complement audit](../research/astra-complement-descent-audit.md) calculates
both changes exactly and retains the resulting tuple's actual canonical
threshold. Its [independent review](../research/astra-complement-descent-review.md)
accepts the scalar witness-transfer strip and the limitations of raw reuse.

Fixed exact examples have both reusable and unusable replacement witnesses.
Thus they defeat an assertion that every replacement witness transfers,
while leaving strategically chosen witnesses open. Complementing the full
configuration makes the original runner at speed p lonely; it does not by
itself make the original zero runner lonely. No general decreasing
counterexample replacement follows from this audit.

## Verification and remaining value

The full Lean build passed 3,618 jobs. The integrated source and axiom audit
accepted 378 reports, allowing only `propext`, `Classical.choice`, and
`Quot.sound`. All 58 focused workflow, storage, ledger, and trust-scanner
tests passed. The [independent formal review](../research/astra-mirrored-formal-review.md)
accepted both frozen files and checked a generic nonvacuous finite labelling.
Root reproduced both fresh-source probes, including 26 concrete phase
inequalities, 14 chosen-runner instances, and seven labelled/cardinality
fixtures. No reviewed source changed during integration.

Exact rational controls checked 162,537 original-speed comparisons in
3,381 core fixtures and 193,200 relative comparisons across 6,608 chosen
runners. Independent manuscript controls additionally checked 20,562 core
comparisons and 11,930 signed comparisons. These finite checks support the
formal proof and boundary review; they do not establish universal parameters
by themselves. The complement review's fixed positive, negative, scalar,
and distinguished-runner controls also replayed successfully.

The [verification record](../research/astra-pass23-verification.json) binds
the source hashes, commands, results, routing recovery, and scope. The first
Terra arithmetic attempt failed; the same Terra medium worker completed the
proof with concrete normalization guidance and smaller implementation steps.
The root goal remained active. After all local verifiers and workers stopped,
the storage cleaner removed 7,712,253,201 bytes of rebuildable project cache,
retaining source, Git history, the pinned toolchain, and unique evidence.

The positive construction is useful as a checked example of adapting the
reference phase while protecting every original speed. Its decisive
assumption is the consecutive low block, whose maximum m also determines
the runner count. Sparse low speeds, unpaired configurations, arbitrary odd
runner counts, and arbitrary real speed assignments are outside this family
contract. No literature novelty is asserted. Further research must establish
an unconditional supply beyond this structure or exclude a genuine minimum
counterexample; restating the family theorem cannot finish the full goal.
