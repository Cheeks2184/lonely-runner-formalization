# Two divisible labels: supplied cover gives a positive witness

Disposition: accept the exact conditional contract below for implementation.
This is a manuscript derivation extracted from the terminal argument in the
accepted [two-divisible plan](astra-two-divisible-three-reduction-plan.md),
independently reviewed in [4d499c](astra-two-divisible-three-plan-review.md).
I authored that larger plan; this task extracts and simplifies its terminal
dependency, without repeating the Proposition 3.1 review. The focused state
records source checkpoint `d90f1d8`, research/in_progress, requested Astra/xhigh,
and no exposed observed-model metadata. Only this report is owned by this task.

The supplied cover is an explicit hypothesis. Establishing it from the still
separate boundary-minimum-zero argument is not part of this result. No gcd,
maximizer, strict seed, parity bound, or unrestricted five-moving sixth-margin
theorem is assumed here. Repeated speed values are permitted: all selections
and cardinalities concern labels. This is not a new unconditional runner-count
theorem or completion of the unrestricted conjecture.

## Exact proposed public contract

All declarations below are proposals in namespace `LonelyRunner`, not compiled
source. The public statement preserves the factor six and the closed margin.

```lean
theorem fiveMovingNaturalRunners_of_two_divisible_cover
    (v : Fin 5 → ℕ) (hpos : ∀ i, 0 < v i)
    (p q : Fin 5) (hpq : p ≠ q)
    (hdiv : ∀ i, 3 ∣ v i ↔ i = p ∨ i = q)
    (hcover : ∀ i, i ≠ p → i ≠ q →
      6 * v i ∣ v p ∨ 6 * v i ∣ v q) :
    ∃ t : ℝ, 0 < t ∧ ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ))
```

Write `W(t)` for the universal norm bound in the conclusion. A direct
contradiction proof may assume `¬ ∃ t, 0 < t ∧ W(t)`. This is sufficient for
both uses of fast insertion, since its checked wrapper returns positive time.
An implementation using the older all-real `¬ ∃ t, W(t)` context may instead
use the argument as a contradiction there; every terminal witness below is
positive independently. Do not silently derive all-real nonexistence from
positive-time nonexistence without the usual nonzero/reflection argument.

## Complete proof and bounded decomposition

**1. Count the exceptions once.** Let
`S = univ.filter (fun i => 3 ∣ v i)` and
`E = univ.filter (fun i => ¬ 3 ∣ v i)`.
By `hdiv`, `S = {p,q}`; since `p ≠ q`, `S.card = 2`. The filter partition of
`univ : Finset (Fin 5)` gives `S.card + E.card = 5`, hence `E.card = 3`.
Membership in E is equivalent to being unequal to p and q. This supplies both
the pigeonhole domain and the rescue theorem's exception-count bound. No
`Fin 3` reindexing or sorting of speed values is necessary.

**2. Exclude both fast ratios before selecting the pair.** Under the assumed
absence of a positive witness, prove
`v p < 5 * v q` and `v q < 5 * v p`.
For the first, suppose `5 * v q ≤ v p`. Every label i unequal to p satisfies
`5 * v i ≤ v p`: the case i=q is the supposition; otherwise apply `hcover`.
If `6 * v i ∣ v p`, positivity of the target gives `6 * v i ≤ v p`.
If `6 * v i ∣ v q`, it gives `6 * v i ≤ v q ≤ 5 * v q ≤ v p`.
In either case `5 * v i ≤ v p`. The checked
`fiveMovingNaturalRunners_of_fast_speed v hpos p` yields a positive witness,
contradiction. Repeat with p and q exchanged, reversing the cover disjunction,
to exclude `5 * v p ≤ v q`. Equality is covered by the fast theorem's weak
inequality. Neither ratio can be inferred from a generic fast-speed exclusion
alone; this proof uses the entire supplied cover.

**3. Choose two labels with a common target.** The following elementary helper
can be private, or reusable if an existing suitable interface is not chosen:

```lean
theorem exists_two_same_side_of_three {ι : Type*} [DecidableEq ι]
    (S : Finset ι) (hS : 3 ≤ S.card) (P Q : ι → Prop)
    (hcover : ∀ i ∈ S, P i ∨ Q i) :
    (∃ u ∈ S, ∃ w ∈ S, u ≠ w ∧ P u ∧ P w) ∨
    (∃ u ∈ S, ∃ w ∈ S, u ≠ w ∧ Q u ∧ Q w)
```

Proof: work classically. If `(S.filter P).card ≥ 2`, use `Finset.one_lt_card`
to choose distinct members. Otherwise this card is at most one. The filter
partition identity gives `(S.filter (fun i => ¬ P i)).card ≥ 2`; choose two
distinct members there. For each, `hcover` and `¬ P` imply Q. There is no
assumption that the choices are exclusive; overlap is resolved by the P filter.

Apply this to E with `P i := 6 * v i ∣ v p` and
`Q i := 6 * v i ∣ v q`. Let a be the common target label and b the other one
of the original p,q. Obtain distinct u,w with `6 * v u ∣ v a` and
`6 * v w ∣ v a`. Positive divisibility gives
`6 * v u ≤ v a` and `6 * v w ≤ v a`. The ratios of step 2 hold in either
orientation. Both branches can call the following single local finisher:

```lean
private theorem two_divisible_pair_small_witness
    (v : Fin 5 → ℕ) (hpos : ∀ i, 0 < v i)
    (a b : Fin 5) (hab : a ≠ b)
    (hdiv : ∀ i, 3 ∣ v i ↔ i = a ∨ i = b)
    (hAB : v a < 5 * v b) (hBA : v b < 5 * v a)
    (u w : Fin 5) (huw : u ≠ w)
    (hu : 6 * v u ≤ v a) (hw : 6 * v w ≤ v a) :
    ∃ t : ℝ, 0 < t ∧ ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ))
```

This local contract only needs inequalities for u,w. It need not add explicit
nondivisibility assumptions for them: in each rescue call, the checked adapter
derives their nondivisibility from the safe divisible seed and strict badness.
The public cover remains unchanged; the local weakening is just the precise
interface needed by the final analytic argument.

**4. Prove the local finisher.** Put `A = (v a : ℝ) > 0`,
`B = (v b : ℝ) > 0`, and `t₀ = 1 / (6 * A) > 0`.
The two small-speed inequalities give

`0 < t₀ * v u ≤ 1/36`, and `0 < t₀ * v w ≤ 1/36`.

At time `5 * t₀`, the corresponding phases are in `(0,5/36]`. Each of these
four phases lies in `[0,1/2]`, so
`circleNorm_eq_abs_of_abs_le_half` followed by `abs_of_nonneg` identifies its
circle norm with the phase. Thus u and w are strictly bad at both times,
because `5/36 < 1/6`. These inequalities follow by multiplying by the positive
denominator `6*A` and casting the natural inequalities; no floor, residue
calculation, or finite test is needed. The factor six in the supplied cover is
what produces this bound; it must not be dropped in the public statement.

At t₀, label a has phase exactly 1/6, hence is closed-safe. Set
`x = t₀ * B = B/(6*A)`. The ratio `B < 5*A` gives `0 < x < 5/6`.
If label b is also safe, all divisible labels are safe by `hdiv`.
The two-bad seeded rescue (exact API below) gives one `k : Fin 3` safe for all
five labels at `t₀ + (k.val : ℝ)/3`. This time is positive since t₀>0 and
the shift is nonnegative, so it is the required witness.

Otherwise `circleNorm x < 1/6`. If `1/6 ≤ x`, the already known `x < 5/6`
and `circleNorm_ge_of_int_band 0 x (1/6)` would give `1/6 ≤ circleNorm x`,
contradiction. Consequently `x < 1/6`. The other ratio `A < 5*B` gives
`1/30 < x`; multiply this pair of strict inequalities by five to obtain
`1/6 < 5*x < 5/6`.
At `5*t₀`, label a has phase exactly 5/6 and label b has phase 5*x.
The same closed band theorem proves both safe, including a's endpoint.
The two selected labels are still strictly bad, as established above.
Apply the same rescue to get one k safe for every label at
`5*t₀ + (k.val : ℝ)/3 > 0`. This proves the local finisher and therefore the
public cover theorem.

The third outside label needs no phase estimate; it is included in the same
rescue theorem's universal conclusion. An individual safe shift per label
would not suffice. Repeated values do not identify u and w: their label
inequality is preserved throughout. No output positivity is presumed from the
rescue API itself; it is proved from these particular positive seeds. The
fast-speed wrapper handles its own possible negative insertion time by
reflection, so the public proof needs no additional sign conversion.

## Existing interfaces and implementation boundary

The decisive checked interface is in `ThirdShiftRescues.lean:16`:

```lean
theorem exists_third_shift_of_two_bad_seeded_divisible
    (v : Fin 5 → ℕ) (t : ℝ)
    (hseed : ∀ i, 3 ∣ v i →
      (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ)))
    (hexceptions :
      ((Finset.univ : Finset (Fin 5)).filter (fun i => ¬ 3 ∣ v i)).card ≤ 3)
    (u w : Fin 5) (huw : u ≠ w)
    (hu : circleNorm (t * (v u : ℝ)) < (1 : ℝ) / 6)
    (hw : circleNorm (t * (v w : ℝ)) < (1 : ℝ) / 6) :
    ∃ k : Fin 3, ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm
        ((t + (k.val : ℝ) / 3) * (v i : ℝ))
```

| Actual source interface | Use |
| --- | --- |
| `FiveMovingFast.lean:9`, `fiveMovingNaturalRunners_of_fast_speed` | Positive Nat `Fin 5`; chosen p; `∀ i ≠ p, 5*v i ≤ v p`; returns a positive closed sixth-margin witness. Both ratio exclusions. |
| `ThirdShiftCollision.lean:15`, `exists_third_shift_safe_of_two_bad` | Generic finite family of at most three nondivisible labels; two distinct bad labels; one common shift. Already used internally by the seeded adapter. |
| `FastRunnerInsertion.lean:21`, `circleNorm_eq_abs_of_abs_le_half` | `|x| ≤ 1/2 → circleNorm x = |x|`; four small phases. |
| `StructuredClasses.lean:28`, `circleNorm_ge_of_int_band` | For integer q, `0 ≤ δ ≤ 1/2` and `q+δ ≤ x ≤ q+1-δ`, obtain `δ ≤ circleNorm x`. Use q=0, δ=1/6 throughout. |
| `Mathlib/Data/Finset/Card.lean:643,733` | `card_filter_add_card_filter_not` and `one_lt_card`; exception counting and two-choice pair selection. |

A bounded implementation consists of the finite-set helper, the local finisher,
and the public wrapper with its two short fast-ratio contradictions. Import
`FiveMovingFast`, `ThirdShiftRescues`, `StructuredClasses`, and the finite-set
cardinality API explicitly as needed; no new scalar API is required. Keep casts
at the boundary of the local real argument (`exact_mod_cast`), use positive
denominator facts before `div_le_iff₀`/`lt_div_iff₀`, and prove the two phase
identities once by field arithmetic. The generic arithmetic step
`Nat.le_of_dvd (hpos target) hdivisor` needs positivity of the dividend target,
which is present here.

Small-denominator residue helpers belong to the preceding task of obtaining
the cover; they are unnecessary once it is supplied. The maximum, scalar,
special-phase transport, and Renault 5.1 modules have no role in this isolated
proof. Subsequent source implementation still needs its own focused build,
exact universal-type and allowed-axiom checks, and independent source review.

## Static bindings and actual checks

These SHA-256 values were read from the existing files during this task. They
bind the source interfaces and accepted manuscript context, not new compiler
evidence. Shared root verification remains separately recorded by the root.

| File | SHA-256 |
| --- | --- |
| `research/astra-two-divisible-three-reduction-plan.md` | `07f27873785c463d7f9b2e8c2074510f42fcd973d07cc6e73ea62e5b3bac0ad6` |
| `research/astra-two-divisible-three-plan-review.md` | `4d499c4477e80445646c6f82fcb72e36009ed1b9fc35b0023dd278f399598f71` |
| `LonelyRunner/FiveMovingFast.lean` | `cc203315c6d36be23b7cdcfc9706785fb05e6d5406c84714a9fea42bdfce7212` |
| `LonelyRunner/ThirdShiftRescues.lean` | `829db12405e64ad88da5501ddb167d650ad82cf92295a88fd2374d9e08281732` |
| `LonelyRunner/ThirdShiftCollision.lean` | `5b984687f89ea16bad34453d3c048ceb974f999af9cd1969f73d56ce30e13cec` |
| `LonelyRunner/FastRunnerInsertion.lean` | `dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5` |
| `LonelyRunner/StructuredClasses.lean` | `5328a7a88d2b42f86ffc3f0f0418ca22c761219e8fa3e5822bda5a18ac286e8c` |
| `.lake/packages/mathlib/Mathlib/Data/Finset/Card.lean` | `87c674ba5464c7868fb3e253e58a695821bf8841bb4e076bac5d570236dc6229` |
| `lean-toolchain` | `8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af` |
| `lake-manifest.json` | `887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218` |

The project instructions, policy, and focused task state were read. The actual
command `python3 scripts/validate_workflow.py` exited 0 and printed:
`workflow structural validation passed; it cannot certify mathematical validity.`
No Lean run, build, numerical fixture, search, finite experiment, certificate
generation, state/Git mutation, or cache change was performed. This report is a
complete conditional manuscript proof and implementation specification; the
public Lean declaration and the preceding cover-establishment argument remain
separate pending work.
