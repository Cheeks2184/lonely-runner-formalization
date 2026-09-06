# Exact real assembly for Renault 6.1 and 6.4

The real argument is complete conditional on the finite interfaces listed below.
No new geometric classification, search, or candidate family is needed. This is
an implementation plan, not a compiled real-assembly module or an independent
rerun of the finite proofs. Root has now accepted both frozen finite modules
after direct focused checks; their source bindings and receipt are below.
Only this report is owned. Current instructions,
policy and focused state were read: research/in_progress,
`/root/remaining_phase_real_assembly_plan`, checkpoint `a4e324a`, requested
Astra/xhigh, observed metadata null. The workflow validator exited 0 with
`workflow structural validation passed; it cannot certify mathematical validity.`
No Lean, numerical verification, generation, source change or state change ran.

The exact target statements are copied from sections 4–5 of the accepted
[one-three-divisible manuscript](astra-one-three-divisible-plan.md):

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

Both allow repeated, negative, and otherwise arbitrary real phases. The 6.4
premise is initial **norm** safety; it is not assumed that the real phases
themselves lie in the middle unit interval. Its third alternative permits b=0.
Neither theorem states a runner-count result.

## 1. Fixed data interface and exact finite obligations

The [assessment](astra-remaining-phase-certificate-assessment.md) fixes 24 mixed
candidates and 15 initially-safe candidates. The independent
[supplied-data review](astra-remaining-phase-data-review.md) checked all 6975
band entries, 321 dominations, 37926 mixed and 3276 fully sorted safe witnesses.
It did not prove minimality or validate the reported containment-test count.
Neither property is needed below.

The following public names and exact types were checked against the now-frozen
`RemainingPhaseData`/`RemainingPhaseFacts` source. Root accepted the literal
transcription, snapshots, streams and artifacts. The delivered receipt records
direct source-check exits 0 for Data and Facts (2.296 s and 71.884 s), with
unchanged source; earlier invocation/startup failures remain in that receipt.
I read the concrete decoders and all consumed public interfaces, without
rechecking the numerical tables or reexecuting their proofs.

| Type | Atoms / core | Cut function | Slope / effective shift / strictness |
| --- | --- | --- | --- |
| mixed weight 2 | `Fin 120` / `Fin 42` | `renaultPhaseCuts` | `remainingSixOneSlopes c`, `remainingSixOneWeightTwoShift c`, `remainingSixOneStrict c` |
| mixed weight 1 | `Fin 120` / `Fin 42` | `renaultPhaseCuts` | same slope/flag, `remainingSixOneWeightOneShift c` |
| initially safe | `Fin 81` / `Fin 26` | `remainingSixFourCuts` | `remainingSixFourSlopes c`, `remainingSixFourShifts c`, `remainingSixFourStrict c` |

Each row's atom/core/representative/domination functions have respectively the
suffixes `AtomMasks`, `CoreMasks`, `CoreAtoms`, `Dominators`, after the prefixes
`remainingSixOneWeightTwo`, `remainingSixOneWeightOne`, `remainingSixFour`.
Atom and core masks are natural numbers; representatives and dominators have
the indicated finite codomains. The candidate index types are `Fin 24` for
the two mixed types and `Fin 15` for the safe type.

The mixed slope/shift vectors decode as follows: indices c<20 give
A=2+c/5, b=1+c%5, strict=false; indices 20≤c<24 give A=1,
b=1+(c-20), strict=true. Effective shifts are literally 2*b and b;
do not reduce 2*b modulo six or replace its natural numerator by a signed one.
The safe decoder has c=0 giving (A,b,s)=(2,0,true), c=1,2 giving
(1,1,true),(1,5,true), and c=3..14 giving
A=3+2*((c-3)/6), b=(c-3)%6, s=false. These are descriptions of the
supplied literal vectors, not alternate unlinked definitions.

Required finite facts are exactly:

1. `remainingSixOneSlope_pos` and `remainingSixFourSlope_pos`, for every
   typed candidate. Both positive slopes are essential in open-atom soundness.
2. Each type's `AtomMasks_lt` and `CoreMasks_lt`: masks fit below 2^24 or
   2^15. The generic common-bit theorem uses only the first core-mask bound;
   retain all bounds as literal-data integrity facts.
3. Each `CoreAtoms_masks`: `AtomMasks (CoreAtoms i) = CoreMasks i`.
   Each `Dominators_and`: `CoreMasks (Dominators a) &&& AtomMasks a =
   CoreMasks (Dominators a)`. The direction is core subset of atom.
4. For each atom a and typed c whose atom-mask bit is true, the corresponding
   `...AtomBandFact` has type
   `AffineSixthBandFact C a.val (Slopes c) (EffectiveShift c) (Strict c)`.
   These are the public names
   `remainingSixOneWeightTwoAtomBandFact`,
   `remainingSixOneWeightOneAtomBandFact`, `remainingSixFourAtomBandFact`.
5. The frozen intersection interfaces are:

```lean
remainingMixedCoreIntersections : ∀ i j k : Fin 42, j ≤ k →
  (remainingSixOneWeightTwoCoreMasks i &&&
    remainingSixOneWeightOneCoreMasks j &&&
    remainingSixOneWeightOneCoreMasks k) ≠ 0

remainingSafeCoreIntersections : ∀ i j k : Fin 26, j ≤ k →
  (remainingSixFourCoreMasks i &&& remainingSixFourCoreMasks j &&&
    remainingSixFourCoreMasks k) ≠ 0
```

The second interface is stronger in index coverage than the independently
verified safe witness stream, which had i≤j≤k. Do not cite that stream as
already checking all rows of this stronger statement: its ordinary
kernel proof in the frozen Facts module supplies the difference. No corresponding stronger premise is needed
mathematically. The mixed statement must leave i arbitrary: coordinate zero's
weight-two row cannot be sorted among the two unit-weight rows.

`AffineSixthBandFact` already checks exact singleton remainder inequalities:
120<P%720<600 for true strictness, and closed inequalities otherwise.
For odd atoms its two closed endpoint inequalities imply strict interior
goodness by positive A. False bits need no real theorem. No separate proof
that the cuts include every possible phase breakpoint is required for soundness:
coverage plus these individual band implications is sufficient.

## 2. Small decoder and normalization lemmas

Implement `LonelyRunner/RemainingPhaseLemma.lean`, exporting exactly the two
public manuscript declarations above. Later signed wrappers should import
`LonelyRunner.RemainingPhaseLemma`. Use the following local definitions; import
`RemainingPhaseFacts`, `FiniteMaskSubset`, and `ConstrainedMaximizer` (the latter
supplies the checked fractional-norm identity). The generic band/coverage APIs
are available from `AffinePhaseCertificate`; import it directly if needed.

```lean
private def RemainingGood (A S : ℕ) (s : Bool) (u : ℝ) : Prop :=
  if s then (1 : ℝ) / 6 < circleNorm ((A : ℝ) * u + (S : ℝ) / 6)
  else (1 : ℝ) / 6 ≤ circleNorm ((A : ℝ) * u + (S : ℝ) / 6)

private def MixedShift (j : Fin 3) (c : Fin 24) : ℕ :=
  if j = 0 then remainingSixOneWeightTwoShift c
  else remainingSixOneWeightOneShift c

private def MixedGood (j : Fin 3) (c : Fin 24) (u : ℝ) : Prop :=
  RemainingGood (remainingSixOneSlopes c) (MixedShift j c)
    (remainingSixOneStrict c) u

private def SafeGood (c : Fin 15) (u : ℝ) : Prop :=
  RemainingGood (remainingSixFourSlopes c) (remainingSixFourShifts c)
    (remainingSixFourStrict c) u
```

Prove the following decoder classifications from the supplied literal vectors
once, by `fin_cases c` and simplification of these short definitions. These are
24/15 definition cases in the future proof, not a new search or band-table check.

```lean
private theorem mixed_decoder (c : Fin 24) :
    (2 ≤ remainingSixOneSlopes c ∧ remainingSixOneSlopes c ≤ 5 ∧
      1 ≤ remainingSixOneShifts c ∧ remainingSixOneShifts c ≤ 5 ∧
      remainingSixOneStrict c = false) ∨
    (remainingSixOneSlopes c = 1 ∧ 1 ≤ remainingSixOneShifts c ∧
      remainingSixOneShifts c ≤ 4 ∧ remainingSixOneStrict c = true)

private theorem safe_decoder (c : Fin 15) :
    (remainingSixFourSlopes c = 2 ∧ remainingSixFourShifts c = 0 ∧
      remainingSixFourStrict c = true) ∨
    (remainingSixFourSlopes c = 1 ∧
      (remainingSixFourShifts c = 1 ∨ remainingSixFourShifts c = 5) ∧
      remainingSixFourStrict c = true) ∨
    ((remainingSixFourSlopes c = 3 ∨ remainingSixFourSlopes c = 5) ∧
      remainingSixFourShifts c ≤ 5 ∧ remainingSixFourStrict c = false)

private theorem mixed_shift_cast (j : Fin 3) (c : Fin 24) :
    (MixedShift j c : ℝ) / 6 =
      (if j = 0 then (2 : ℝ) else 1) *
        (remainingSixOneShifts c : ℝ) / 6

private theorem remainingGood_fract (A S : ℕ) (s : Bool) (u : ℝ) :
    RemainingGood A S s (Int.fract u) ↔ RemainingGood A S s u

private theorem sixth_safe_fract_band (u : ℝ) :
    (1 : ℝ) / 6 ≤ circleNorm u ↔
      (1 : ℝ) / 6 ≤ Int.fract u ∧ Int.fract u ≤ (5 : ℝ) / 6
```

`mixed_shift_cast` splits on j=0 and uses the two effective-shift definitions
and `Nat.cast_mul`; its right side is the manuscript's exact real-valued
weight. `remainingGood_fract` unfolds the definition and rewrites by
`circleNorm_nat_affine_fract A ((S : ℝ)/6) u`; both strictness branches
therefore retain the identical inequality. There is no sign restriction on u.
For `sixth_safe_fract_band`, rewrite `circleNorm_eq_min_fract` and
`le_min_iff`. The result is δ≤fract u and δ≤1−fract u; elementary linear
arithmetic turns the second inequality into fract u≤5/6 and conversely.
This is a proof of the exact equivalence, including equality at both endpoints.

## 3. Coverage, core-row soundness and one common candidate

The proposed normalized intermediate contracts are:

```lean
private theorem mixed_normalized (x : Fin 3 → ℝ)
    (hx : ∀ j, 0 ≤ x j ∧ x j < 1) :
    ∃ c : Fin 24, ∀ j, MixedGood j c (x j)

private theorem safe_normalized (x : Fin 3 → ℝ)
    (hx : ∀ j, (1 : ℝ) / 6 ≤ x j ∧ x j ≤ (5 : ℝ) / 6) :
    ∃ c : Fin 15, ∀ j, SafeGood c (x j)
```

For each mixed coordinate use the existing
`cutAtomMem_covers_unit_interval 60 360` with positive n,D and
`renaultPhaseBandFacts.first`/`.last` from the checked 5.1 concrete data.
It returns a : Fin 120 with `CutAtomMem renaultPhaseCuts 360 a.val u`.
Atom 0 is singleton zero; atom 119 is the open interval ending at one.
There is no singleton one: Int.fract is always <1. Do not use the closed
cover and silently coerce its possible Fin 121 endpoint into Fin 120.

The safe cut function is literally
`remainingSixFourCuts i = renaultPhaseCuts (i+10)`. Establish
`remainingSixFourCuts 0 = 60` and `remainingSixFourCuts 40 = 300`
by reduction of the checked cut literals. Invoke
`cutAtomMem_covers_closed_interval 40 360` at u; its lower and upper
hypotheses are the normalized δ≤u≤5/6 after these endpoint rewrites.
The result is a : Fin 81. The last index 80 is singleton 5/6, not an open
interval; its separate strict/closed singleton certificate is required.
Neither cover demands a new monotonicity or breakpoint-enumeration proof.

For any of the three types, write K for its core masks, A for atom masks,
D for dominators, and C for cuts. Coverage gives a and atom membership.
Choose core row i=D a. If c belongs to `maskCandidates B (K i)`, the checked
subset API applied to `K(D a) &&& A a = K(D a)` gives membership in
`maskCandidates B (A a)`. Apply `mem_maskCandidates.mp` to get the true
bit, its `...AtomBandFact`, and then `affineSixthBandFact_sound` with the
positive slope and the *actual* atom membership. This proves every selected
candidate in that core row good at u. The core representative atom need not
contain u; using its geometric membership here would be an error. Its checked
mask equality is an integrity link, not the transfer argument. Using K directly
means the representatives are not a logical dependency of this real proof.

In exact code shape, one row's final step is:

```lean
have hbit := mem_maskCandidates.mp
  (maskCandidates_subset_of_and_eq B (K (D a)) (A a) (hdom a) hc)
exact affineSixthBandFact_sound C a.val (Slope c) (Shift c) (Strict c)
  (hpos c) (hband a c hbit) u hau
```

Here the symbols denote that row's functions from the table above, and the
goal has unfolded `RemainingGood`. Instantiate separately for mixed weight
two, mixed weight one and the safe type. This is three short wrappers over
one checked implication, not three new real-band arguments.

Next turn each ordered intersection fact into an actual common candidate via
`exists_common_mask_candidate B K₀ K₁ K₂ hbound hintersection`.
For mixed indices i,j,k, split `le_total j k`. In the j≤k branch use the
fact at i,j,k. Otherwise use i,k,j and exchange the final two membership
proofs: ⟨c,h₂,hₖ,hⱼ⟩ becomes ⟨c,h₂,hⱼ,hₖ⟩. The i argument stays in
the weight-two core. The same two-case construction works for the frozen
safe intersection signature. It uses only the first core-mask bound and
does not require a numerically chosen witness or the least common bit.

The fixed-23-candidate `RenaultPhaseCertificates.phase_certificate_sound` is
a proof pattern, not a directly applicable generic theorem. The new typed
assembly below preserves the different candidate counts. Equal indices remain
valid in every order branch.

Finally instantiate the checked `typed_phase_certificate_sound` exactly:

| Parameter | Mixed | Safe |
| --- | --- | --- |
| B | 24 | 15 |
| m | `fun _ => 42` | `fun _ => 26` |
| M j i | `maskCandidates 24 (if j=0 then remainingSixOneWeightTwoCoreMasks i else remainingSixOneWeightOneCoreMasks i)` | `maskCandidates 15 (remainingSixFourCoreMasks i)` |
| Domain j u | `0≤u ∧ u<1` | `1/6≤u ∧ u≤5/6` over ℝ |
| Good j c u | `MixedGood j c u` | `SafeGood c u` |

For hrow split j=0 in the mixed case and use the corresponding row wrapper;
the safe case is independent of j. Constant m=42 avoids dependent casts even
though the two mixed core families remain different functions. For hcommon,
apply the unsorted common-candidate helper to i 0,i 1,i 2, then `fin_cases j`
and return the corresponding membership proof. The theorem selects one core
per coordinate, chooses c **once**, and applies that c to all three rows.
Repeated phases and repeated core indices require no special branch.

## 4. All-real transport and exact case decoding

Define f j := Int.fract (x j). For 6.1,
`Int.fract_nonneg` and `Int.fract_lt_one` supply all hypotheses of
`mixed_normalized f`. For 6.4, apply `sixth_safe_fract_band (x j)` to hx j
and use `safe_normalized f`. In either case, transfer the returned common
c coordinatewise by `remainingGood_fract`; no candidate is reselected during
this transfer. The shift offset is a fixed real constant for each j,c, so
the natural affine periodicity theorem applies even when x j is negative.
For 6.4 do **not** substitute `circleNorm (x j)` for f j: folding reflects
some phases and generally changes an affine sixth shift. Fractional reduction
preserves orientation modulo an integer and is the correct normalization.

Apply `mixed_decoder c` once to the all-real common-candidate conclusion.
In its first case choose a=`remainingSixOneSlopes c`,
b=`remainingSixOneShifts c`; retain the four supplied natural bounds,
unfold `MixedGood`/`RemainingGood`, rewrite the false flag and
`mixed_shift_cast`, and use the coordinatewise common goodness. In its second
case choose that same b, rewrite slope=1 and the true flag, and obtain the
strict b∈[1,4] alternative. Equality at δ can only enter a closed candidate;
there is no conversion of closed goodness to strict goodness here.

Apply `safe_decoder c` once for 6.4. The first case rewrites A=2,b=0 and
the true flag, yielding strict doubling. The second rewrites A=1 and returns
the common b=1 or 5 with strict goodness. The third chooses A,b from the
literal decoder and returns A=3 or 5, b≤5, and closed goodness. Natural b
already implies b≥0. In particular b=0 remains available, with no imposed
lower bound. The exact nested disjunction matches the manuscript statement.

## 5. Signed extensions: separate transport, no new certificates

No sign hypothesis is needed for the two unsigned all-real targets. Later
signed applications may copy the source pattern in `SignedRenaultFiveOne`.
For a natural weight w, natural a,b and integer e=±1, the exact identity is

`N(a*(e*x)+w*b/6) = N(a*x+e*w*b/6)`.

For e=1 it is arithmetic equality. For e=-1 the left real expression is the
negative of the right, so `circleNorm_neg` applies. Cast e from ℤ and w,a,b
from ℕ separately. Applying 6.1 to `(e j : ℝ)*x j` gives signed weights
e j*(if j=0 then 2 else 1) while preserving the same a,b across all labels.
Applying 6.4 to the same signed inputs is valid because their initial norms
equal the original norms. Strict doubling then transports back to 2*x j;
the two shift alternatives acquire the signed offset and retain their bounds.

If the reflected 6.1 strict range [2,5] is needed, apply the signed lemma with
-e and set b'=6-b. With b≤6, `Nat.cast_sub` is legitimate. The phase with
offset (-e)*w*b/6 differs from the phase with offset e*w*(6-b)/6 by the
integer -e*w, so integer periodicity preserves both kinds of inequality.
Closed b∈[1,5] maps to itself; strict b∈[1,4] maps to [2,5]. This is a
single uniform choice b', not three independently reflected shifts. Do not
blindly perform the same replacement in 6.4's closed b∈[0,5] branch: b=0
would give 6. The unreflected signed 6.4 contract already suffices and keeps
zero. Any separately requested reflected version must explicitly normalize
that endpoint by its integer period. The helper in SignedRenaultFiveOne is
private, so its proof pattern, not an inaccessible theorem name, is reusable.

## Delivery order and remaining gate

With the finite interface now frozen and root-accepted, implement the decoder,
fractional-band and Good-periodicity helpers,
the three atom-to-core row wrappers and the two common-mask wrappers. Finish
the two normalized assemblies, all-real common-candidate transport and exact
public decoders. These form one bounded real-assembly module; signed adapters
can follow separately without changing the tables. Root retains independent
source review, focused receipts and the integration/trust gate. There is no
remaining mathematical gap in this conditional assembly; the real-assembly
Lean implementation and subsequent verification are concrete outstanding work.

The present goal remains active. Canonical N=6 is a transition milestone;
the subsequent research priority is a uniform arbitrary-N mechanism, not
successive isolated runner counts.

## Static source and data bindings

The following hashes bind the exact sources/API inputs read and the already
verified fixed data. Hashing is static file integrity only. The two new finite
sources are frozen, but this plan is not their separate full source review.
The durable data copies match the original three temporary-file hashes in the
supplied-data review.

| Input | Bytes | SHA-256 |
| --- | ---: | --- |
| `research/astra-remaining-phase-certificate-assessment.md` | 11728 | `16ad698faeac6f3469c391094806f8bc301bc46fdfe294caefbf557051ba0589` |
| `research/astra-remaining-phase-data-review.md` | 15218 | `5501a0eab4988a912e2a2788d2c00dfa7d65d5c1b872fc647f65dccfb7ba362c` |
| `research/astra-one-three-divisible-plan.md` | 40112 | `9da230600af3a0a0bc8223de3daca2575f8d41f447142687ca64db53ced4ae9e` |
| `research/astra-one-three-divisible-review.md` | 33535 | `8f720fbd8002918adaaa0d36fc7774c450eeb5dba84dd555552d24b5e57e6078` |
| `LonelyRunner/AffinePhaseCertificate.lean` | 9777 | `175fe8208166387b2fd0d4da15e3742ed2c9ca5f6d687aedced8f6130f3249eb` |
| `LonelyRunner/FiniteMaskCertificates.lean` | 1944 | `72629bc0780161890a31dd705b744c7ce2a77c884a915d7eaf4b3d69855b181e` |
| `LonelyRunner/FiniteMaskSubset.lean` | 612 | `8a7dec857dc4a9c4f2b5d4360389e97487163bd69d2d01ed3408b1335f162c3e` |
| `LonelyRunner/FiniteCutCover.lean` | 1995 | `b7e7e50834bc86d13ffde759e3d0c2dc4d2480a03ec61eb88a70ca215fcc1011` |
| `LonelyRunner/RealPhaseBands.lean` | 2559 | `7f70467bad6bb5a8a859bff8947af1dc73e685910b69157b49bab259b3c02ca0` |
| `LonelyRunner/ConstrainedMaximizer.lean` | 13143 | `2ef07e6b83b8675a22184571c31d2a71dab9d5c072e3cd165cb8382957b46e92` |
| `LonelyRunner/RenaultPhaseLemma.lean` | 3404 | `1ceac85438299dffdd48d57fb0052b598a9bd5eda995cabff0256885529d89cb` |
| `LonelyRunner/RenaultPhaseConcreteData.lean` | 17285 | `1d5709da3631bc51d60bb4dbeb94fa2668da5cdbf5a63007e7b4ebd96a5b6c17` |
| `LonelyRunner/RenaultPhaseCertificates.lean` | 2623 | `36b58c04e0c755d462f32bae3388c30d744d97ccb20a3bc27aa0daa99b7e49f0` |
| `LonelyRunner/SignedRenaultFiveOne.lean` | 3158 | `6971e02483c2b1e6f3d717ed5d4784fd8decfbdba6f6bdc9d8aca0dff2f4f3fc` |
| `lean-toolchain` | 25 | `8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af` |
| `lake-manifest.json` | 3131 | `887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218` |
| `research/remaining-phase-fixed-v1/metadata.json` | 7619 | `4fad760e1ce3231e0d66e8ef53b9eb401c6f7d2abf8403ed6f168a79fcdb01a9` |
| `research/remaining-phase-fixed-v1/six_one_witnesses.bin` | 37926 | `0f56b854ddef56e49731684bc4ccd9d15366d13bd337e4a2e0c194734e9aa0ce` |
| `research/remaining-phase-fixed-v1/six_four_witnesses.bin` | 3276 | `b68a691032caeed3ac4f71ea0967affc1946c19358774b928db53608e3846037` |
| `LonelyRunner/RemainingPhaseData.lean` | 9247 | `df27b8fb7bf80335582230abd20df9ac46fdb8821576d8313cb2917834f88448` |
| `LonelyRunner/RemainingPhaseFacts.lean` | 75741 | `dc605d224f3d1855da5030ed491dbf1b672871efd1ed983385dc657026b34a8d` |
| `research/astra-remaining-phase-full-tables.json` | 136334 | `b2f01a2c1627ca2475e45b07a09510490c0d34314e4f7fe966590022f6746db9` |

The two target declarations were compared statically against the original
manuscript after whitespace normalization and matched exactly. No mathematical
program was executed for this check.
