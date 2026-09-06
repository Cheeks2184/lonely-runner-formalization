# Independent source review: remaining real phase assembly

Accepted, with no mathematical or contract defect found in the frozen
`LonelyRunner/RemainingPhaseLemma.lean`. This review covers all private definitions
and proofs and both public declarations. The public types match the original
accepted manuscript after whitespace normalization. The supplied focused receipt
binds the successful elaboration to this exact source and reports only `propext`,
`Classical.choice`, and `Quot.sound` for both declarations.

The reviewer authored neither this Lean source nor its real-assembly plan. The
reviewer authored the earlier one-three-divisible manuscript and certificate
assessment; the original manuscript has its separate independent review. Thus
this is an independent implementation-source review, with that earlier
mathematical authorship disclosed.

Current project configuration, workflow, policy and focused state were read.
State authorizes this separate owned report, with the finite review remaining
frozen. `python3 scripts/validate_workflow.py` actually returned exit 0 and
`workflow structural validation passed; it cannot certify mathematical validity.`
No Lean invocation, numerical calculation, table evaluation, source edit, state
edit, Git operation or cache modification was performed for this review. Complete
focused worker receipts were accepted under the current delivery policy; the
inspection disclosed no unresolved concern requiring another import probe.

## Exact accepted public contracts

Both declarations are in namespace `LonelyRunner`:

```lean
theorem renault_phase_six_one (x : Fin 3 → ℝ) :
    (∃ a b : ℕ, 2 ≤ a ∧ a ≤ 5 ∧ 1 ≤ b ∧ b ≤ 5 ∧
      ∀ j, (1 : ℝ) / 6 ≤ circleNorm
        ((a : ℝ) * x j +
          (if j = 0 then (2 : ℝ) else 1) * (b : ℝ) / 6)) ∨
    (∃ b : ℕ, 1 ≤ b ∧ b ≤ 4 ∧
      ∀ j, (1 : ℝ) / 6 < circleNorm
        (x j + (if j = 0 then (2 : ℝ) else 1) * (b : ℝ) / 6))

theorem renault_phase_six_four (x : Fin 3 → ℝ)
    (hx : ∀ j, (1 : ℝ) / 6 ≤ circleNorm (x j)) :
    (∀ j, (1 : ℝ) / 6 < circleNorm (2 * x j)) ∨
    (∃ b : ℕ, (b = 1 ∨ b = 5) ∧
      ∀ j, (1 : ℝ) / 6 < circleNorm (x j + (b : ℝ) / 6)) ∨
    (∃ a b : ℕ, (a = 3 ∨ a = 5) ∧ b ≤ 5 ∧
      ∀ j, (1 : ℝ) / 6 ≤
        circleNorm ((a : ℝ) * x j + (b : ℝ) / 6))
```

The first theorem is unconditional for three arbitrary real phases. The second
retains exactly its initial closed norm hypothesis. Both permit negative,
integral and repeated phases. The candidate is shared by all three coordinates;
neither statement chooses separate alternatives or parameters for each phase.
The closed alternative in 6.4 includes `b = 0`. Neither declaration states a
runner-count result or assumes one.

## Complete proof assessment

**Normalization.** `remainingGood_fract` transports both strict and closed
predicates using `circleNorm_nat_affine_fract`. For a natural slope `A`, replacing
`u` by `Int.fract u` subtracts the integer `A * Int.floor u` from its affine
argument; arbitrary real shifts and negative inputs are therefore allowed.
This is fractional-part normalization, not replacement by the folded circle
norm, which would lose the sign of a phase. The private
`sixth_safe_fract_band` obtains the exact equivalence
`1/6 ≤ circleNorm u ↔ 1/6 ≤ Int.fract u ∧ Int.fract u ≤ 5/6`
from the minimum formula. It retains both endpoints and is used only when `hx`
is available. Unconditional 6.1 instead uses `0 ≤ fract u < 1`.

**Actual containing atoms.** Each mixed row calls
`cutAtomMem_covers_unit_interval 60 360` with the checked first and last cuts,
so its actual phase lies in a `Fin 120` atom. Atom 119 is the final open
interval; 1 is excluded, consistently with fractional normalization. The safe
row verifies the endpoint cuts 60 and 300 and invokes
`cutAtomMem_covers_closed_interval 40 360`, obtaining a `Fin 81` atom and
including singleton 80 at `5/6`. The initial singleton at `1/6` is also included.
The generic covering lemmas and positive-denominator premises match these uses;
no unproved coverage, sortedness or rounding assumption is supplied.

**Domination and real soundness.** From the actual atom `a`, the row selects its
recorded dominator `i`. The equation `core(i) &&& atom(a) = core(i)` and
`maskCandidates_subset_of_and_eq` send membership in the core to membership in
that actual atom. The proof never treats the phase as belonging to a
representative atom chosen for the core. A true bit then gives the corresponding
`AffineSixthBandFact`, and `affineSixthBandFact_sound` uses the actual atom
membership to establish `RemainingGood`. Only one-way true-bit soundness is
needed; maximal masks and a converse are unnecessary.

For singleton atoms, the strict bit has strictly interior endpoint inequalities;
closed bits allow equality. For open atoms, the checked closed endpoint band
and strictly positive slope place every interior phase strictly inside the safe
band, so strict bits remain justified even if a limiting endpoint is at the
threshold. The finite review separately accepted these exact band contracts.
No endpoint is silently discarded or promoted from a closed hypothesis to a
strict conclusion at a singleton.

**Mixed coordinates.** `MixedShift` uses the weight-two shift precisely at
coordinate 0 and the weight-one shift at coordinates 1 and 2. The private cast
identity proves the natural effective shift divided by 6 is
`(if j = 0 then 2 else 1) * b / 6` over the reals. It does not double the slope.
The two row lemmas apply their respective finite masks and band facts, with the
same candidate encoding. `mixed_normalized` dispatches on `j = 0`; its explicit
`simpa [hj]` supplies the correct conditional mask family in the other branch.

**One shared candidate.** `mixed_common` compares only the two weight-one core
indices. It keeps the weight-two index first and arbitrary, then applies
`remainingMixedCoreIntersections` with only the required `j ≤ k` premise.
In the reversed case the returned memberships are reordered back to their
original coordinates. Thus it never sorts the weight-two row into the wrong
family. `safe_common` likewise leaves its first index arbitrary, as allowed by
the stronger checked safe intersection contract, and sorts only the other two.
Equal row indices are allowed throughout. The finite first-mask bounds and
nonzero intersections give a single candidate through
`exists_common_mask_candidate`. `typed_phase_certificate_sound` then selects a
row for each actual phase and obtains that same candidate for all coordinates.

**Decoding and final alternatives.** The private decoders check the literal
candidate definitions by `fin_cases` and `norm_num`. The mixed decoder gives
exactly the 20 closed `(a,b)` possibilities with `2 ≤ a ≤ 5`, `1 ≤ b ≤ 5`,
or the four strict unit-slope shifts with `1 ≤ b ≤ 4`. The safe decoder gives
strict double with shift zero, strict unit-slope shift 1 or 5, or closed slope
3 or 5 with shift at most 5. Each public proof first restores all original
real phases, then decodes the common candidate once. The Bool flag is unfolded
in the corresponding branch, preserving its strict or closed inequality.
There is no hidden phase-range hypothesis, speed restriction or witness premise.

## Focused-check provenance and operational history

The following are historical worker executions, not new reviewer executions.
The frozen JSON retains the complete initial and repaired source snapshots,
commands, raw stdout/stderr and `/usr/bin/time -v` streams with byte counts and
hashes. The reviewer read both outputs and the three-hunk source repair and
statically validated the embedded final source, both physical snapshots, six
raw stream records and both final artifacts against their recorded bytes and
SHA-256 values. Each source-before/source-after pair agrees and both captures
are complete. A separate static extraction confirmed the two declaration types
match the original manuscript after whitespace normalization.

Both recorded commands use `flock -n .lake/verification.lock`, then
`/usr/bin/time -v -o /tmp/remaining-phase-real-ATTEMPT/time-v.txt`, then
`lake env lean -j1 -s65536` on the absolute source path with explicit `.olean`
and `.ilean` outputs in the shared build directory. `ATTEMPT` is `initial` or
`repair-1`; exact argv arrays are retained in the bound receipt. Environment:
Elan bin PATH prefix, `LEAN_NUM_THREADS=1`, `LEAN_STACK_SIZE_KB=65536`. Actual
recorded caps: 8 GiB address space, CPU 179/180 seconds, wall 180 seconds and
1 MiB per stream. These are the worker's focused-source checks, not the older
60-second import-probe protocol.

| Attempt | Source SHA-256 | Exit | Wall seconds | Stdout / stderr bytes |
| --- | --- | --- | --- | --- |
| initial | `96e01764056b3fad316222c864b52a9f4d672036821031033b287b66b5fcebb9` | 1 | 3.31716218899237 | 1506 / 0 |
| repair-1 | `4523603cd6f8f88546f09017b8cee3159c65683237af81dd61fb66fd452cb4db` | 0 | 3.534830710006645 | 193 / 0 |

The initial attempt had an already-closed goal followed by redundant tactics,
a conditional-mask elaboration mismatch and a wrong conjunction projection in
the safe strict-shift branch. Its failed elaboration printed `sorryAx` in both
axiom lists; that output is retained and is not accepted as theorem evidence.
The repair removed the two redundant tactics, changed the weight-one dispatcher
to `simpa [hj] using ...`, and corrected `hshift.2.2.2` to `hshift.2.2`.
No declaration type or mathematical hypothesis changed. The complete successful
stdout is:

```text
'LonelyRunner.renault_phase_six_one' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.renault_phase_six_four' depends on axioms: [propext, Classical.choice, Quot.sound]
```

Successful stdout SHA-256:
`51334fcb4fd847678d180fd0708f340c45853257c20d906f1363375618a45039`.
Both empty stderr streams have SHA-256
`e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.
Initial stdout SHA-256:
`3e99d67608ad40bb28632ccee7ec57fc7bb33880ead70c29995978a941856616`.
Final `.olean`: 1607832 bytes,
`185898e4d37778510e766fee8b05f6809d7aa42896ff88fd3a0592247b205f00`;
final `.ilean`: 41431 bytes,
`4205a30e4b345cb814e195ae0dc5bd78b19fda30cd4ea46ff8fdd02f38505094`.
Delivery metrics retain first-check failure, one worker repair round, zero Astra
repair rounds/lines, and null worker elapsed time/usage where not exposed.

## Frozen source and mathematical bindings

All paths below are relative to `/home/joshua/lonely-runner-formalization`.
Mutable root imports, audit sources and workflow state are not part of the
frozen source contract. The finite source review remains a separate artifact.

| Path | SHA-256 |
| --- | --- |
| `LonelyRunner/RemainingPhaseLemma.lean` | `4523603cd6f8f88546f09017b8cee3159c65683237af81dd61fb66fd452cb4db` |
| `research/astra-remaining-phase-real-implementation.json` | `2e57c3e111ec656e039fc86db1132d150a176386d93b74a6f0ee781d45a2b920` |
| `research/astra-remaining-phase-real-assembly-plan.md` | `b692f4e07ca724c168eafe624f3b0f1e8d88261faa11f92f2ebb11ad377e9979` |
| `research/astra-one-three-divisible-plan.md` | `9da230600af3a0a0bc8223de3daca2575f8d41f447142687ca64db53ced4ae9e` |
| `research/astra-one-three-divisible-review.md` | `8f720fbd8002918adaaa0d36fc7774c450eeb5dba84dd555552d24b5e57e6078` |
| `research/astra-remaining-phase-finite-source-review.md` | `b0beeb0dcd252eceac2b6d3eafd43f5680e5c588822913197800fc7bd106fc7e` |
| `LonelyRunner/RemainingPhaseData.lean` | `df27b8fb7bf80335582230abd20df9ac46fdb8821576d8313cb2917834f88448` |
| `LonelyRunner/RemainingPhaseFacts.lean` | `dc605d224f3d1855da5030ed491dbf1b672871efd1ed983385dc657026b34a8d` |
| `research/astra-remaining-phase-full-tables.json` | `b2f01a2c1627ca2475e45b07a09510490c0d34314e4f7fe966590022f6746db9` |
| `LonelyRunner/AffinePhaseCertificate.lean` | `175fe8208166387b2fd0d4da15e3742ed2c9ca5f6d687aedced8f6130f3249eb` |
| `LonelyRunner/FiniteMaskCertificates.lean` | `72629bc0780161890a31dd705b744c7ce2a77c884a915d7eaf4b3d69855b181e` |
| `LonelyRunner/FiniteMaskSubset.lean` | `8a7dec857dc4a9c4f2b5d4360389e97487163bd69d2d01ed3408b1335f162c3e` |
| `LonelyRunner/RealPhaseBands.lean` | `7f70467bad6bb5a8a859bff8947af1dc73e685910b69157b49bab259b3c02ca0` |
| `LonelyRunner/FiniteCutCover.lean` | `b7e7e50834bc86d13ffde759e3d0c2dc4d2480a03ec61eb88a70ca215fcc1011` |
| `LonelyRunner/RenaultPhaseBandFacts.lean` | `c775da2dfb8d3c6ff24f6d66c49d7b690f3422cc7dc95b410c064cc08c78d721` |
| `LonelyRunner/RenaultPhaseConcreteData.lean` | `1d5709da3631bc51d60bb4dbeb94fa2668da5cdbf5a63007e7b4ebd96a5b6c17` |
| `LonelyRunner/ConstrainedMaximizer.lean` | `2ef07e6b83b8675a22184571c31d2a71dab9d5c072e3cd165cb8382957b46e92` |
| `lean-toolchain` | `8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af` |
| `lake-manifest.json` | `887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218` |

The accepted result is the two exact real phase declarations above, with the
supplied successful source check and an independent semantic review. Root still
owns the checkpoint integration build and trust audit. Canonical six-runner
assembly and its exact bridge remain separate obligations; these phase results
do not establish that milestone by themselves. The standing roadmap remains
canonical N = 6, then a uniform arbitrary-N mechanism for the unrestricted goal.
