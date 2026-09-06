# Independent review of the remaining finite phase sources

Accept the frozen Data and Facts modules without correction. Their 19 public
finite theorems have the intended scope and bind to the supplied literal data.
I authored neither module nor the separate real assembly plan. I did author the
earlier certificate-method assessment; this is independent implementation-source
review, not independent rediscovery of that method.

This review accepts the complete retained focused compilation evidence. It
performs source/receipt inspection and static transcription checks only: no Lean
invocation, predicate evaluation, numerical/table verification or regeneration.
No concrete unresolved type or axiom concern justifies another import probe.
Full integration and trust validation remain root-owned.

## Data and exact endpoint semantics

All 18 literal vectors match the corresponding fields of the frozen metadata
by token-for-token static comparison: six slope/shift/strictness vectors, three
atom-mask vectors, three core-mask vectors, three representative vectors and
three dominator vectors. The other three definitions are the two effective
shifts and the closed-interval cut offset.

The mixed 24-candidate decoder has twenty closed choices with slopes 2–5 and
base shifts 1–5, followed by four strict slope-one choices with shifts 1–4.
`remainingSixOneWeightTwoShift k = 2 * remainingSixOneShifts k`; the weight-one
shift is unchanged. Thus the weight-two coordinate uses the same affine slope
and twice the **shift**, not twice the entire phase. Its natural numerator is
not reduced modulo six. Both weight types share the same candidate index and
strictness flag.

The safe 15-candidate decoder has strict `(slope,shift)` pairs `(2,0)`, `(1,1)`,
`(1,5)`, followed by closed slope 3 or 5 with shifts 0–5. The zero-shift closed
choices are retained. The comment describing the first three candidates as
having strict singleton bands does not limit their strictness to singletons;
open-atom soundness is also strict.

The mixed cut function is the existing 61-entry `renaultPhaseCuts`, on scale
360. Even atom indices are singletons, odd indices are open intervals.
`Fin 120` includes singleton 0 and final **open** atom 119, between cuts 59 and
60; it excludes singleton 1. For 6.4,
`remainingSixFourCuts i = renaultPhaseCuts (i+10)`. Its cuts 0 and 40 are 60 and
300, so `Fin 81` ends with singleton atom 80 at 5/6 and covers the intended
closed [1/6,5/6] interval once the separate cover lemma is applied. Odd atom 79
uses cuts 39 and 40. The final even atom does not use an extra interval beyond
5/6. These are domain descriptions, not a coverage theorem exported by Facts.

The inspected generic definitions are
`P = A * affineSixthRepresentative C a + 120*S`, `Q=P/720`, where the
representative is `2*C(a/2)` for a singleton and `C(a/2)+C(a/2+1)` for an open
atom. At a singleton, `P/720` is precisely `A*C(a/2)/360+S/6`. The finite
fact requires remainder strictly between 120 and 600 for a strict candidate,
and allows equality otherwise. All three row templates preserve that test.

For an open atom, both endpoints must lie in the **same** closed affine band:

`360*Q+60 ≤ A*C(a/2)+60*S`,
`A*C(a/2+1)+60*S ≤ 360*Q+300`.

Positive A makes every actual interior phase strictly between the corresponding
band faces, even when an endpoint is equal. This justifies the identical open
conditions for strict and closed candidates. The separate universal
`remainingSixOneSlope_pos` and `remainingSixFourSlope_pos` supply positivity.
The generic `AffineSixthBandFact` itself does not claim soundness for slope zero.
The midpoint-selected quotient need not be independently trusted: the stated
two inequalities certify the entire interval in that particular band.

All three public band interfaces are exactly the following (with the source's
standard coercion of the finite atom to its natural value):

```lean
remainingSixOneWeightTwoAtomBandFact (a : Fin 120) (k : Fin 24)
  (hbit : (remainingSixOneWeightTwoAtomMasks a).testBit k.val = true) :
  AffineSixthBandFact renaultPhaseCuts a (remainingSixOneSlopes k)
    (remainingSixOneWeightTwoShift k) (remainingSixOneStrict k)

remainingSixOneWeightOneAtomBandFact (a : Fin 120) (k : Fin 24)
  (hbit : (remainingSixOneWeightOneAtomMasks a).testBit k.val = true) :
  AffineSixthBandFact renaultPhaseCuts a (remainingSixOneSlopes k)
    (remainingSixOneWeightOneShift k) (remainingSixOneStrict k)

remainingSixFourAtomBandFact (a : Fin 81) (k : Fin 15)
  (hbit : (remainingSixFourAtomMasks a).testBit k.val = true) :
  AffineSixthBandFact remainingSixFourCuts a (remainingSixFourSlopes k)
    (remainingSixFourShifts k) (remainingSixFourStrict k)
```

Their two structure fields are projected directly from the corresponding
universal atom-row theorem. There is no hidden phase premise or supplied band
hypothesis. Only true bits are asserted sound; false-bit completeness is neither
asserted nor necessary for the eventual real theorem.

## Subsets, common candidates and proof trust

The remaining finite statements are two positive-slope theorems, six bounds
placing atom/core masks below `2^24` or `2^15`, three representative equalities,
and three dominator equalities. Each representative equality is
`AtomMasks (CoreAtoms i) = CoreMasks i`. It does not prove first occurrence,
minimality or an antichain property. Those properties are unnecessary here.

Every domination has the exact direction
`CoreMasks (Dominators a) &&& AtomMasks a = CoreMasks (Dominators a)`.
The inspected `maskCandidates_subset_of_and_eq` therefore puts the core's
candidate set **inside** the atom's set. This is the direction needed to carry
a common core bit to each actual containing atom. Bounds on the natural masks
prevent the common bit from escaping the finite candidate type. The literal
finite indices also agree with the previously validated metadata; this is not
an inference that any natural numeral written at type `Fin n` is automatically
less than n before coercion.

The two exact intersection statements are:

```lean
remainingMixedCoreIntersections : ∀ i j k : Fin 42, j ≤ k →
  (remainingSixOneWeightTwoCoreMasks i &&&
    remainingSixOneWeightOneCoreMasks j &&&
    remainingSixOneWeightOneCoreMasks k) ≠ 0

remainingSafeCoreIntersections : ∀ i j k : Fin 26, j ≤ k →
  (remainingSixFourCoreMasks i &&& remainingSixFourCoreMasks j &&&
    remainingSixFourCoreMasks k) ≠ 0
```

Both leave i arbitrary and retain j=k, so repeated row choices are included.
For a reversed pair j>k, exchange only those two entries using associativity
and commutativity of `Nat.land`. In the mixed theorem one must not sort the
weight-two i among the two weight-one indices. The safe theorem is stronger
than the earlier supplied witness stream's `i≤j≤k` indexing; its current
ordinary kernel proofs establish this larger scope. That scope is not being
attributed to the older, narrower witness stream.

The inspected 321 private atom proofs have exactly their displayed atom-row
propositions, and all 68 private core proofs have the displayed universal
j,k proposition with only j≤k. A static full-source template/dispatch check
confirmed all indices and exact `by decide` bodies, and all five exhaustive
`fin_cases` dispatches use the matching row in order. This checks source
structure; it does not re-evaluate the arithmetic predicates. All public
proposition templates and their structure/dispatch wrappers were read directly.

The proofs use ordinary `decide`, not `native_decide`, new axioms, admissions or
an unsafe computational shortcut. Recursion/heartbeat options are elaboration
resource settings, not trust extensions. The retained Facts stdout prints the
five consumed band/intersection theorem axiom lists; each is exactly
`[propext, Classical.choice, Quot.sound]`. The other fourteen public theorems
are direct closed `by decide` proofs in the same successfully compiled source.
No claim of a fresh full transitive axiom audit is made in this review.

## Retained operational history and bindings

Workflow/config/policy and focused state were read: research/in_progress,
`/root/remaining_phase_finite_source_review`, checkpoint `830a626`, requested
Astra/xhigh. The required validator exited 0 with
`workflow structural validation passed; it cannot certify mathematical validity.`
An exploratory glob for `AffineSixthBand*.lean` failed; its actual definitions
are in `AffinePhaseCertificate.lean`. Large read outputs were narrowed to the
relevant source and receipt fields; no missing output is treated as inspected.

The receipt retains four actual attempts with unchanged final source bytes:

| Attempt | Exit | Recorded elapsed seconds | Outcome |
| --- | --- | --- | --- |
| `initial` | 1 | 0.03307487501297146 | `lake build -j1` rejected the unknown short option `-j` before Lean |
| `launcher-repair-1` | 1 | 3.556945050979266 | Lake's child failed to create a thread; child code 134, before elaboration |
| `direct-focused-remainingphasedata` | 0 | 2.2964511970058084 | Data compiled; stdout/stderr empty |
| `direct-focused-remainingphasefacts` | 0 | 71.88429277500836 | Facts compiled; 536-byte axiom stdout, empty stderr |

The successful commands are recorded verbatim in the receipt: the serial lock,
`/usr/bin/time -v`, then `lake env lean -j1 -s65536` on each absolute source,
with its normal `-o` and `-i` paths. All four attempts record AS 8 GiB, CPU
179/180 seconds, wall 180 seconds and 1 MiB per stream, with process-local
`LEAN_NUM_THREADS=1` and `LEAN_STACK_SIZE_KB=65536`. These are historical caps,
not a newly authorized or executed check. No source repair was needed: metrics
record zero worker proof-repair rounds, one root launcher-guidance round and
zero root-edited source lines. Worker elapsed/usage remain null, not inferred.

Static receipt validation checked both embedded final sources, all four final
olean/ilean artifacts, all twelve stdout/stderr/time-v byte/hash records, all six
physical before-source snapshots across the four attempts, before/after source
bindings and both fixed-input bindings. Every check passed. The complete raw
streams and commands remain in that guarded receipt rather than being copied
or replayed here. Facts stdout SHA-256 is
`677b1315518165872f79131ef24dc59dc26bffec530f299cb6403c45f0a2b197`.

Only this report was edited. No real-phase theorem, cut coverage theorem, core
minimality result, canonical N=6 result or unrestricted LRC result is promoted
by this finite review. The separate real assembly still needs its own source
review and checkpoint integration.

| Binding | SHA-256 |
| --- | --- |
| `LonelyRunner/RemainingPhaseData.lean` | `df27b8fb7bf80335582230abd20df9ac46fdb8821576d8313cb2917834f88448` |
| `LonelyRunner/RemainingPhaseFacts.lean` | `dc605d224f3d1855da5030ed491dbf1b672871efd1ed983385dc657026b34a8d` |
| `research/astra-remaining-phase-full-tables.json` | `b2f01a2c1627ca2475e45b07a09510490c0d34314e4f7fe966590022f6746db9` |
| `research/remaining-phase-fixed-v1/metadata.json` | `4fad760e1ce3231e0d66e8ef53b9eb401c6f7d2abf8403ed6f168a79fcdb01a9` |
| `research/astra-remaining-phase-data-review.md` | `5501a0eab4988a912e2a2788d2c00dfa7d65d5c1b872fc647f65dccfb7ba362c` |
| `LonelyRunner/AffinePhaseCertificate.lean` | `175fe8208166387b2fd0d4da15e3742ed2c9ca5f6d687aedced8f6130f3249eb` |
| `LonelyRunner/RenaultPhaseConcreteData.lean` | `1d5709da3631bc51d60bb4dbeb94fa2668da5cdbf5a63007e7b4ebd96a5b6c17` |
| `LonelyRunner/FiniteCutCover.lean` | `b7e7e50834bc86d13ffde759e3d0c2dc4d2480a03ec61eb88a70ca215fcc1011` |
| `LonelyRunner/RealPhaseBands.lean` | `7f70467bad6bb5a8a859bff8947af1dc73e685910b69157b49bab259b3c02ca0` |
| `LonelyRunner/FiniteMaskCertificates.lean` | `72629bc0780161890a31dd705b744c7ce2a77c884a915d7eaf4b3d69855b181e` |
| `LonelyRunner/FiniteMaskSubset.lean` | `8a7dec857dc4a9c4f2b5d4360389e97487163bd69d2d01ed3408b1335f162c3e` |
| `lean-toolchain` | `8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af` |
| `lake-manifest.json` | `887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218` |
| `.lake/build/lib/lean/LonelyRunner/RemainingPhaseData.olean` | `38d651b0ed90052c37f53306c42777afb72ec36db1ae2a0e59dd146fdcb6d3d0` |
| `.lake/build/lib/lean/LonelyRunner/RemainingPhaseData.ilean` | `8e757c0633f9c964648799127aa3196094f28310c2cad4f054f46f982b904114` |
| `.lake/build/lib/lean/LonelyRunner/RemainingPhaseFacts.olean` | `025f09a152395541feca49f28a0eef45ac39a3f55b1d355d4884ffdeda72844e` |
| `.lake/build/lib/lean/LonelyRunner/RemainingPhaseFacts.ilean` | `241cfb79c43bd308c61195027c1fe220008151d8e73dbb48b9a1268a06f60f05` |
