# Independent final source review: canonical six runners

**Accept all four exact declarations and their complete proofs.** The frozen
sources establish the positive five-moving-speed theorem at closed margin
`1/6`, remove primitivity without requiring distinct natural speeds, supply
the correctly bounded `H_7`, and prove the canonical theorem for every selected
runner in an injective six-speed real family. No mathematical defect, missing
branch, hidden hypothesis, loss of a closed endpoint, or circular dependency
was found. The final exact-scope review gate for N=6 is satisfied.

This reviewer authored the accepted final assembly **review**, and earlier
one-three-divisible/three-even manuscripts, but neither the root final assembly
plan nor these new Lean proofs. This is an independent implementation-source
review, with that earlier manuscript/review authorship disclosed. Both parity
implementations already have separate accepted source reviews, bound below.

Current project configuration, workflow, policy and focused state were read.
The task is `/root/six_runner_final_source_review`, requested Astra/XHIGH at
checkpoint `34afe4f`; observed model/effort and usage are unavailable.
`python3 -B scripts/validate_workflow.py` actually exited 0 with
`workflow structural validation passed; it cannot certify mathematical validity.`
Only this report was written. All inspection was static: no Lean invocation,
import/axiom probe, numerical experiment, source/Git/state edit or cache operation.

## Exact declarations and canonical expansion

These are the complete four public types in namespace `LonelyRunner`; the
modules have no ambient hypotheses. They match the accepted assembly review.

```lean
theorem fiveMovingNaturalRunners_of_primitive
    (v : Fin 5 → ℕ) (hpos : ∀ i, 0 < v i)
    (hprimitive : Finset.univ.gcd v = 1) :
    ∃ t : ℝ, 0 < t ∧ ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ))

theorem fiveMovingNaturalRunners
    (v : Fin 5 → ℕ) (hpos : ∀ i, 0 < v i) :
    ∃ t : ℝ, 0 < t ∧ ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ))

theorem lowerCountPositiveIntegerHypothesis_seven :
    LowerCountPositiveIntegerHypothesis 7

theorem sixRunners (speeds : Fin 6 → ℝ)
    (hinj : Function.Injective speeds) (runner : Fin 6) :
    ∃ t : ℝ, LonelyAt speeds runner t
```

The actual `LowerCountPositiveIntegerHypothesis 7` definition expands to
all naturals `d` with `1 ≤ d ≤ 5`, all injective positive `Fin d → ℕ`
families, and one real time with every norm at least `1/(d+1)`.
Its injectivity premise belongs to that existing bounded-supply interface;
the new five-moving theorem itself does not require it. `H_7` means a supply
through five moving speeds, not a theorem for seven total runners.

The actual `Definitions.lean` expansion of the final conclusion is

```lean
∃ t : ℝ, ∀ other : Fin 6, other ≠ runner →
  (6 : ℝ)⁻¹ ≤
    dist (position (speeds runner) t) (position (speeds other) t)
```

Here `position speed t = ((t * speed : ℝ) : AddCircle (1 : ℝ))`.
Thus the distance is the shorter circular distance on a unit track, and
equality at `1/6` is included. Quantification is
`∀ speeds, Injective speeds → ∀ runner, ∃ t, ∀ other ≠ runner`.
The time is common to all five other runners for that selected runner; it
may depend on the selected runner. All speeds are arbitrary reals, including
negative, zero, and irrational values, subject only to canonical injectivity.
The canonical time domain is all reals, exactly as in `Conjecture`; the
positive-natural witness theorems additionally return strictly positive time.

## Complete proof assessment

**Primitive dispatcher.** Its temporary `hno` negates the existence of any
real common closed-sixth witness. This exactly matches
`six_total_divisor_count_bounds`, whose assumptions include positive speeds,
gcd one, and `2 ≤ ell ≤ 6`. The source obtains counts between one and three
at denominators three, six and two only within this justified contradiction
context. The four-line repair merely makes the existing bounds explicit for
the local filter abbreviation `S`; it changes no proposition or hypothesis.

If the three-divisible count is at least two, the actual
`fiveMovingNaturalRunners_of_primitive_at_least_two_divisible_three` supplies
a witness. Its source splits exact two from primitive at least three and calls
the already checked corresponding branches. It does not invoke a nonprimitive
all-five-divisible claim or the new final theorem.

Otherwise the count is exactly one. `Finset.card_eq_one` identifies an actual
label `p`, and filter/singleton membership proves `3 ∣ v i ↔ i = p` for every
label. The lower count at six supplies `q` with `6 ∣ v q`; since `3 ∣ 6`,
uniqueness forces `q=p`. Thus `6 ∣ v p` is proved, including the parity of the
unique pivot. The count at two is exactly one, two or three, so the three
actual parity adapters exhaust the remaining cases. No pivot-odd branch is
silently discarded.

I checked the current signatures and count-adapter bodies against the accepted
parity sources/reviews. All take `v : Fin 5 → ℕ`, positivity, a label `p`,
the above uniqueness equivalence, and their respective even-count equality;
all return the same positive common closed-sixth conclusion. Only
`one_three_divisible_one_even_witness` additionally takes `6 ∣ v p`.
The two/three adapters derive it internally from the independent small-
denominator cover under all-real nonexistence. Their label permutations are
exhaustive and do not assert distinct speed values. The final dispatcher
passes exactly these differing argument lists, retaining their common time.
Both formerly planned parity inputs are now actual compiled, source-reviewed
theorems; no future theorem premise remains in the dispatcher.

The resulting all-real witness `u` cannot be zero: its bound at label zero
would give `1/6 ≤ 0`. If negative, `-u` is positive and `circleNorm_neg`
preserves every bound; otherwise `u` is already positive. Positivity does
not restrict the contradiction hypothesis or the candidate times inside it.

**Gcd removal.** For `g = Finset.univ.gcd v`, each `g ∣ v i` follows from
`Finset.gcd_dvd`. Positivity at label zero and `gcd_ne_zero_iff` give `g>0`.
The exact natural quotients `w i = v i / g` satisfy `v i = g * w i`, are
positive by `Nat.div_pos`, and have gcd one by `Finset.gcd_div_eq_one`.
Applying the primitive theorem to `w` and returning `t/(g:ℝ)` gives
`(t/g) * (v i:ℝ) = t * (w i:ℝ)` for every label. The cast and field
identity use the proved nonzero denominator. This removes every common
factor without attempting to preserve intermediate parity/divisor counts.
Repeated natural values remain allowed; there is no injectivity or sorting
premise anywhere in this theorem.

**Bounded supply.** For `d≤4`, the body calls
`lowerCountPositiveIntegerHypothesis_six` at the same `d`, with its original
threshold `1/(d+1)`. Otherwise `d≤7-2` forces `d=5`, and the new unconditional
positive-natural theorem gives exactly the required inverse sixth threshold.
It does not downgrade the smaller cases to `1/6`. These stronger lower-count
margins are the input needed by the irrational branch of the real reduction.

**Canonical bridge.** The complete final proof applies
`lonelyAt_of_lowerCount (m := 5)` to `lowerCountPositiveIntegerHypothesis_seven`.
I read the actual definitions and all three bodies in `BoundedRealReduction`.
Its only supply hypothesis is `H_(m+2)`, so here exactly `H_7` suffices.
There is no all-dimensional or real-speed conjecture premise.

For positive real speeds with an irrational ratio, the existing BHK relation
construction supplies a nonzero rational collision vector with at most `m-1`
distinct magnitudes. Restricting `H_(m+2)` to `H_(m+1)` yields margin `1/m`,
strictly greater than `1/(m+1)`; relation-based transfer supplies a strict
target witness, which is then weakened to closed. If all ratios are rational,
the source normalizes by one positive speed, uses at most `m` rational
magnitudes and `H_(m+2)`, and rescales one common time. Repeated magnitudes
are handled by a finite image and label pullback in `LowerCountSupply`;
no injectivity of the positive real tuple is required.

`stationaryWitness_of_lowerCount` applies this result to absolute values of
arbitrary nonzero relative speeds and restores each sign by circle-norm
symmetry. Finally `runner.succAbove` enumerates exactly the other labels;
injectivity of the original real speeds gives nonzero relative differences.
`lonelyAt_iff_relativeLonelyAt` translates their common stationary witness
back to the original circle distances. Absolute relative speeds may coincide,
even for injective original speeds, and the checked bridge permits that.
All these operations preserve the selected-runner quantifier and closed bound.

A static walk of the actual local import ancestry of the parity, normalization,
lower-count and real-bridge prerequisites found 118 acyclic modules, containing
neither `SixRunnerOrdinary` nor `SixRunnerCanonical`. Combined with their
explicit source contracts and root's theorem-axiom audit, this rules out an
assumed final assembly in the reviewed dependency chain.

## Focused receipt and integration evidence

The bound 46,068-byte implementation receipt contains three complete generated
driver objects. I compared each with its retained physical capture JSON,
checked all six embedded source objects against their sizes/hashes, checked
all three physical before-source snapshots and all six physical raw streams,
and checked both successful source snapshots against the current final files.
Every comparison passed. Historical initial `source_after` bytes were checked
from their embedded payload, not incorrectly against the subsequently repaired
source path. The exact initial-to-final diff adds only the four explicit
`hthreeS`/`htwoS` lines described above.

| Actual focused check | Exit | Seconds | Stdout/stderr bytes |
| --- | --- | --- | --- |
| Ordinary initial | 1 | 2.281953774014255 | 555 / 0 |
| Ordinary repair 1 | 0 | 2.4904172670212574 | 0 / 0 |
| Canonical initial | 0 | 1.9855758259946015 | 0 / 0 |

The full initial stdout was read: two `omega could not prove the goal`
diagnostics at original lines 42 and 61, where the local `S` bounds were not
explicit. Its SHA-256 is
`76999a63c45886eb6a112c8085601a0101fc2afe335a6b0ffbab4a35873e890f`.
All other streams are exactly empty, SHA-256
`e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.
These are actual failed/successful checks, not a new reviewer execution.

The retained captures are `/tmp/astra-six-runner-ordinary-initial.json`
(17,574 bytes, `2095f1a300149700f1538a5779379073de38a1157ef4156ee3aceef159aade63`),
`/tmp/astra-six-runner-ordinary-repair1.json`
(17,938 bytes, `f0e8c666262fc67273d37cbff22511de8338d4026cf2339bd99d653baba034b1`),
and `/tmp/astra-six-runner-canonical-initial.json`
(4,697 bytes, `c548a071899d571c79b28071a8962ce9a256539996592298b1abb4f85e87ce49`).
Their complete snapshots and streams are also embedded in the bound receipt.

Each actual argv used `flock -n .lake/verification.lock`,
`timeout --preserve-status 180s`, `prlimit --as=8589934592 --cpu=179:180`,
and `lake env lean -j1 -s65536` on the owned source with explicit `.olean` and
`.ilean` output paths. Cwd was this repository and `/home/joshua/.elan/bin`
was prepended to PATH. There was one worker repair, zero Astra repairs/direct
lines, and 6.757946867030114 seconds of summed check duration; total worker
elapsed time and task usage remain null.

Successful focused artifact records are historical: Ordinary `.olean`
267,152 bytes / `1cc7af44ec4d0d06d52c53db6161dbb217fa165a023016fc00ab7d208335baf2`,
`.ilean` 11,319 / `988b3bfeca9e0b09b22492ff0bcdb567b7043903c0f6326acc3947dd9a3d592a`;
Canonical `.olean` 19,312 / `e98232b0526e8a7a6b42f6d6140922e9fa01308384fa02728404a9ca41748bae`,
`.ilean` 1,369 / `61c129b2a3c3fe7109445e6db52b39999ba172b41f961fada832b0a74fc460da`.
These records match the retained capture objects. Root had physically checked
the focused artifacts before integration; I do not claim their hashes must
still describe artifacts regenerated by the subsequent full Lake build.

During this review root completed the normal full integration and trust checks,
reporting actual exit 0 for each. I statically read and hashed the retained logs:

| Log | Bytes | SHA-256 | Actual retained conclusion |
| --- | --- | --- | --- |
| `/tmp/astra-pass58-full-build.log` | 42082 | `c7a3f40c0fa194c0dc006cea15da5ca4d33d144b65f09d4a51bd2ab08d2c643d` | `Build completed successfully (3728 jobs).` |
| `/tmp/astra-pass58-trust.log` | 75034 | `35a98a4e9ebe22b8da577793c9348e0bfdd0af1c82de2ce94a8dd10bab7c8039` | `Trust audit accepted 700 theorem reports.` |

The full build explicitly includes both final modules and the root module.
The complete final four axiom reports in the trust log are:

```text
'LonelyRunner.fiveMovingNaturalRunners_of_primitive' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.fiveMovingNaturalRunners' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.lowerCountPositiveIntegerHypothesis_seven' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.sixRunners' depends on axioms: [propext, Classical.choice, Quot.sound]
```

No separate focused axiom probe was claimed or repeated. Earlier missing
historical raw evidence in the orbit/two-even worker attempts remains disclosed
in their acceptance reports; it was not reconstructed here. The fresh normal
integration/trust now covers the final source chain. Source-scope acceptance,
focused receipt validation and the normal integration audit are distinct evidence.

## Frozen source and review bindings

Paths are relative to `/home/joshua/lonely-runner-formalization`. All listed
SHA-256 values were checked against actual bytes in this review.

| File | SHA-256 |
| --- | --- |
| `LonelyRunner/SixRunnerOrdinary.lean` | `8da5bb6f35373ab4da8d0ab8e2a1040376a74b028efdc7e00d006ee91eb25755` |
| `LonelyRunner/SixRunnerCanonical.lean` | `8c530436d6916655f5c132178ae9f1cf69b31ee992adb141002afaaa53cac2d3` |
| `research/astra-six-runner-final-assembly-plan.md` | `e2fd7e78c03e6baf227e2061fde87713c520518ffedd0da5caa7e61a6d0d387a` |
| `research/astra-six-runner-final-assembly-review.md` | `ee7fa64a311908e2bdeaad5477a2da56d5b4ec1ce6af38db5444a5ec8c825148` |
| `research/astra-six-runner-final-implementation.json` | `8e4cb6be9364d02ea5dad0450a69ba6b2e4f3907a87a927d32c35c8285f5553d` |
| `LonelyRunner/SixTotalDivisorCounts.lean` | `0b62ef724eb8c24db4085e247e9f16f650ec450291c7ccac2b0ad0981f148727` |
| `LonelyRunner/TwoDivisibleNormalization.lean` | `d812237f06d63e67c8739122c76a5e67daa470402575ccafcdcee4c41d950286` |
| `LonelyRunner/PrimitiveTwoDivisible.lean` | `873916a4fd815c75731c7327de419d96efde4c40fe74ed15d011b40b577f678d` |
| `LonelyRunner/ThreeDivisibleRunners.lean` | `614dc7bbf75143da6960d74b3eef5427ef93c9c8b3cbe51ec5cd5c6ca47376a3` |
| `LonelyRunner/OneEvenRunners.lean` | `5bf5f01d7b31b410b680d646a832b273890cc267dc7a4775fea37eac5c58b810` |
| `LonelyRunner/TwoEvenRunners.lean` | `d7c40736c944dc8f66a0b04def3035dd34cf20248afa86986a11942133bdf524` |
| `LonelyRunner/ThreeEvenRunners.lean` | `6089c1920a69127b113ecf3a0d6cc57c6f080d46a6bf81b15b855e2eec77dc6c` |
| `research/astra-two-even-source-review.md` | `bff8a4e22a49a269801f1727ef17780b2de9307180a0c6504aac1603e32ccd7e` |
| `research/astra-three-even-witness-source-review.md` | `ee53583c9656a4c7aa633b5a222705ed70d14fc7f308f8160b0a49173323eef6` |
| `LonelyRunner/FiveRunnerOrdinary.lean` | `662d0116f13971bce85e76c503e2f3be4fdc6291ba8113aeda43957e38354ffe` |
| `LonelyRunner/LowerCountSupply.lean` | `0705291adc53011fb72fc718a7260876512b092741442d6a6cceb4b76eb5ccf4` |
| `LonelyRunner/BoundedRealReduction.lean` | `7eae68d2c46041b39c3e18f9a1e105c75680352f8e4b4edf65e0dd2a92becb72` |
| `LonelyRunner/Definitions.lean` | `5f0258a6ab99950fc7045b2200d6708fe7603d3caa4d62855ef2b19a330c95aa` |
| `LonelyRunner/StationaryEquivalence.lean` | `12dce8930c34b211bc01e2dc21e932087270726bce2bf127fa2d8d6594544b49` |
| `.lake/packages/mathlib/Mathlib/Algebra/GCDMonoid/Finset.lean` | `e0e320bd1f4a5a9e79da9fde6e2e3691ebbbccea8a4fba5765bda3b56e715568` |
| `lean-toolchain` | `8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af` |
| `lake-manifest.json` | `887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218` |

This accepts the canonical **N=6** source result and its exact scope alongside
the retained passing normal build/trust evidence. Publication and the formal
milestone/transition record remain root-owned. No unrestricted declaration
`LonelyRunner.Conjecture` or its negation has been established. After root
declares the N=6 milestone, the standing next direction is a uniform arbitrary-N
mechanism, not successive runner-count milestones. This review starts no such
research and makes no claim that the unrestricted goal is resolved.
