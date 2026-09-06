# Thirtieth Astra checkpoint: sharper stationary finite-height reduction

Pass 30 updates four existing Lean files while preserving the older public API. It is a
kernel-checked reduction and equivalence, not a proof of the unrestricted
Lonely Runner Conjecture. Existing Pass 29 manuscript results are unchanged.

## Exact contract

Write `N=m+2`, with `m>=1`, and set

```text
B = choose(N,2)^(N-2).
```

The new stationary large-height branch applies when `B<H`, uses the stationary
zero label, and supplies the closed canonical witness there. The complementary
inclusive finite family uses `H<=B` and supplies witnesses for every label.
Zero-preserving normalization and strong count induction then establish

```text
LonelyRunner.Conjecture iff AllSharperInclusivePrimitiveFiniteFamilies.
```

`AllSharperInclusivePrimitiveFiniteFamilies` remains unresolved. Thus the
reduction recovers a maximum-height bound but neither supplies the finite
families uniformly nor proves or disproves LRC. It does not formalize the
published gcd-sum criterion.

The cutoff is a factor `2^(N-2)` smaller than the previous one:

| N | Previous cutoff | Sharper B |
| --- | ---: | ---: |
| 4 | 144 | 36 |
| 5 | 8,000 | 1,000 |
| 6 | 810,000 | 50,625 |

## Lean surface and verification

The additive implementation spans `FiniteHeightReduction.lean`,
`FinitePrimitiveFamilies.lean`, `FiniteFamilyEquivalence.lean`, and new probes
in `AxiomAudit.lean`. It preserves the old declarations while adding the
stationary large-height theorem, the inclusive all-runner finite family,
zero-preserving normalization, and the strong-induction canonical equivalence.

The pinned Lean 4.32.1 / mathlib `520045ab14e26149ee970e2e617ca04b09bde5d6`
full build passed 3,638 jobs. The trust audit accepted 432 permitted-only axiom
reports, and five new exact theorem probes reported only `propext`,
`Classical.choice`, and `Quot.sound`. The implementation record gives source
hashes and exact log hashes in
[the sharper-cutoff implementation artifact](../research/astra-sharper-cutoff-implementation.md).

The [independent Astra/xhigh review](../research/astra-sharper-cutoff-review.md)
gave semantic approval at this exact reduction and equivalence scope. It
confirms that the result does not supply the finite-family premise or resolve
LRC. No build was rerun for this documentation update.
