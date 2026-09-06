# Independent implementation review: three-even orbit helpers

The eight complete proofs in the frozen `LonelyRunner/ThreeEvenOrbit.lean`
are mathematically accepted, with no contract defect found. All eight public
types match the accepted plan's private contracts exactly after removing the
`threeEven_` name prefix and normalizing whitespace. This source implements
scalar and conditional orbit infrastructure; it does not implement the
five-label three-even branch or a new runner-count theorem.

The reviewer authored `astra-three-even-assembly-plan.md`, but did not author
this Lean source. This is an independent implementation-source review, not an
independent re-review of the reviewer's own manuscript. Current project
configuration, workflow, policy and focused state were read. The active review
owns only this report. The structural validator actually exited 0 with
`workflow structural validation passed; it cannot certify mathematical validity.`
Only source/receipt reading and static extraction/hash comparisons were used;
no new Lean invocation, numerical experiment, source edit, Git/state action,
or cache change occurred.

## Exact accepted declarations

All declarations are in namespace `LonelyRunner`. These are the full source
contracts; no ambient variable or hidden section hypothesis is present.

```lean
theorem threeEven_exists_even_unit_sixth_residue (d : ℕ)
    (h2 : 2 ∣ d) (h3 : ¬ 3 ∣ d) :
    ∃ z σ : ℤ, (d : ℤ) = 6 * z + 2 * σ ∧ (σ = 1 ∨ σ = -1)

theorem threeEven_exists_odd_unit_sixth_residue (d : ℕ)
    (h2 : ¬ 2 ∣ d) (h3 : ¬ 3 ∣ d) :
    ∃ z σ : ℤ, (d : ℤ) = 6 * z + σ ∧ (σ = 1 ∨ σ = -1)

theorem threeEven_circleNorm_nat_mul_fract (x : ℝ) (n : ℕ) :
    circleNorm ((n : ℝ) * x) =
      circleNorm ((n : ℝ) * Int.fract x)

theorem threeEven_circleNorm_sixth_weighted_shift
    (t : ℝ) (d w b : ℕ) (z σ : ℤ)
    (hd : (d : ℤ) = 6 * z + (w : ℤ) * σ)
    (hσ : σ = 1 ∨ σ = -1) :
    circleNorm ((t + (b : ℝ) / 6) * (d : ℝ)) =
      circleNorm ((σ : ℝ) * Int.fract (t * (d : ℝ)) +
        (w : ℝ) * (b : ℝ) / 6)

theorem threeEven_small_phase_double_four_safe (x : ℝ)
    (hx : (((1 : ℝ) / 12 ≤ Int.fract x ∧
      Int.fract x ≤ (1 : ℝ) / 6) ∨ Int.fract x = (1 : ℝ) / 5)) :
    (1 : ℝ) / 6 ≤ circleNorm (2 * x) ∧
    (1 : ℝ) / 6 ≤ circleNorm (4 * x)

theorem threeEven_circleNorm_double_lt_third (x : ℝ)
    (hx : (1 : ℝ) / 3 < circleNorm x) :
    circleNorm (2 * x) < (1 : ℝ) / 3

theorem threeEven_dvd_of_large_partner_at_zeros
    (A U W : ℕ) (hU : 0 < U) (hcop : Nat.Coprime U 6)
    (hlarge : ∀ t : ℝ, Int.fract (t * (U : ℝ)) = 0 →
      (1 : ℝ) / 6 ≤ circleNorm (t * (A : ℝ)) →
      (1 : ℝ) / 3 < circleNorm (t * (W : ℝ))) :
    U ∣ A

theorem threeEven_small_sixth_dilate_norm (A U : ℝ) (a : ℕ)
    (hA : 0 < A) (hU : 0 ≤ U) (hsmall : 6 * U ≤ A) (ha : a ≤ 5) :
    circleNorm (((a : ℝ) * (1 / (6 * A))) * U) < (1 : ℝ) / 6
```

## Proof-by-proof assessment

1. **Even centered residue.** The existing centered-residue theorem supplies
   `d = 6*z + e` with `e` one of `1,-1,2,-2`. The proof retains `h2` and
   converts natural divisibility into integer divisibility. Its integer witness
   makes either odd residue impossible by `omega`. The two surviving cases
   yield signs `1,-1` and the exact displayed identity. No nonnegative quotient
   assumption is made about `z`, and `h3` correctly excludes zero speeds.

2. **Odd centered residue.** The same four cases now keep `±1`. For either
   even residue, `3*z+1` or `3*z-1` is an integer witness that 2 divides the
   natural speed after casting back with `exact_mod_cast`, contradicting `h2`.
   Divisibility is transported across casts, not inferred from a signed witness
   being natural. No primality claim about a composite modulus is involved.

3. **Natural multiple of a fractional part.** `Int.floor_add_fract x` gives
   `n*x = ((n:ℤ)*floor x:ℤ) + n*fract x` after real casts. The discarded
   quantity is exactly an integer, so `circleNorm_add_int` applies. Negative
   `x`, integral `x`, and `n=0` are all covered. This preserves the oriented
   fractional part; it does not replace it by the folded norm.

4. **Signed weighted common shift.** `fract_sixth_affine_time` is applied with
   integer multiplier 1, integer shift numerator `b`, and residue `w*σ`.
   The proof explicitly normalizes the casts and converts both fractional-part
   expressions to their circle norms using helper 3 at `n=1`. This establishes
   `N((t+b/6)*d)=N(fract(t*d)+b*w*σ/6)`. At `σ=1` ring identities give the
   target; at `σ=-1`, the target argument is the negative of the preceding
   argument, so `circleNorm_neg` applies. The actual time shift remains `b/6`
   for every label, independent of its sign. All natural `w,b`, including zero,
   all real `t`, and every `d` satisfying the residue identity are allowed.
   No positivity, oddness or nondivisibility premise is silently used here.

5. **Small phase, double and quadruple.** Helper 3 reduces to `r=fract x`.
   In the closed band, `2r` lies in `[1/6,1/3]` and `4r` in `[1/3,2/3]`.
   At the alternative `r=1/5`, the corresponding phases are `2/5` and `4/5`.
   Each lies in the closed integer band `[1/6,5/6]`, and
   `circleNorm_ge_of_int_band 0` has all its premises supplied. The lower
   endpoint `r=1/12` really permits equality for the double, so the source
   correctly returns a closed bound. Negative original phases pose no problem.

6. **Strict double-norm obstruction.** With `u=N(x)`, the round formula gives
   `0≤u≤1/2`; the hypothesis gives `u>1/3`. The inspected
   `circleNorm_nat_mul_add_int_half x 2 0` gives `N(2x)=N(2u)` for any signed
   `x`. Subtracting the integer 1 leaves `2u-1` in `(-1/3,0]`, whose absolute
   value is at most `1/2`. The small-absolute-phase formula therefore gives
   `N(2x)=1-2u<1/3`. The endpoint `u=1/2` gives zero and remains valid; the
   excluded endpoint `u=1/3` would not give the strict conclusion.

7. **Conditional orbit-to-divisibility bridge.** Under `¬U∣A`, the existing
   `exists_reciprocal_time_small_phase A U hU hcop` supplies `k<U` and the
   prescribed fractional band or exact fifth phase. Its reduced-orbit theorem
   supports composite `U`; it does not assume every nonzero composite residue
   is a unit. Put `s=k/U`. Positivity of `U` supplies the nonzero denominator
   needed for every field cancellation. Helper 5 makes the pivot safe at the
   two actual times `2*s` and `4*s`. At those times the U-phases are exactly
   the natural integers `2*k` and `4*k`, so their fractional parts vanish.
   Applying the displayed all-real `hlarge` twice gives partner norms greater
   than `1/3` at both times. Helper 6 applied to the first partner phase gives
   a norm less than `1/3` at the second, using the exact ring identity
   `2*((2*s)*W)=(4*s)*W`. This contradiction proves `U∣A`.
   The unused bound `k<U` is harmless: only existence of a reciprocal time
   with the prescribed phase is needed here. Neither `k>0` nor `s>0` is
   required, because `hlarge` covers all real times. Positivity of `A` or `W`,
   a gcd assumption on a whole tuple, and a supplied five-speed witness are
   not introduced. The all-real conditional hypothesis remains explicit; this
   theorem does not establish it.

8. **Small sixth dilates.** The assumptions yield
   `0≤U/(6*A)≤1/36`, with `A>0` justifying division. Multiplication by the
   nonnegative natural cast `a≤5` puts the actual phase in `[0,5/36]`,
   strictly below `1/6` and hence below `1/2`. Its circle norm equals that
   nonnegative phase. The strict result includes `6*U=A`, `a=5`, `a=0` and
   `U=0`; it needs no artificial strict speed inequality or lower bound on a.
   `A,U` are arbitrary reals subject to the stated inequalities.

The immediate imported semantic interfaces were inspected in
`SmallPhaseOrbits`, `SixthAffinePhase`, `FoldedCirclePhase`,
`FastRunnerInsertion` and `StructuredClasses`; the other two direct imports
are `WeakSixthShifts` and `OddHalfTimeShift`. There is no circular dependency
on the subsequent three-even witness assembly. The final source contains
exactly these eight public theorems and their complete proofs.

## Evidence bindings

Paths are relative to `/home/joshua/lonely-runner-formalization`.
Static checks actually matched all eight plan types and the following source,
artifact and pin hashes. Mutable root imports/audit files are not guarded.

| Path | SHA-256 |
| --- | --- |
| `LonelyRunner/ThreeEvenOrbit.lean` | `2d2cbdd51dc51f1e23985feb9c7826ce5bb944118f01c8c7719e5ad25de4e088` |
| `.lake/build/lib/lean/LonelyRunner/ThreeEvenOrbit.olean` | `034caf4b00e47490dd1987ae394680b7ecd2b4ca9a186391aca7267177750363` |
| `.lake/build/lib/lean/LonelyRunner/ThreeEvenOrbit.ilean` | `2c7cd31c2a4af9596b57bc70bcba540cc191b388f3f4c25ee471dca1814cdaa2` |
| `research/astra-three-even-assembly-plan.md` | `66a9bac477d1e985d23f6188197ca7af6f0d90ad29df38ab8e710ed417cf510a` |
| `LonelyRunner/WeakSixthShifts.lean` | `8c2ba998a08976ffc33f6af0226908a1bc068c322bac793e071210c49b1ce61b` |
| `LonelyRunner/SmallPhaseOrbits.lean` | `033d7c9f84e924ab7f66ad0f37cfddf7b22c395a596d7fef57b273b2459a0e97` |
| `LonelyRunner/SixthAffinePhase.lean` | `76e420713079ec0c3979e9b169cd78ecb6a932d6dc790ea7d9711adbb64b7d4b` |
| `LonelyRunner/OddHalfTimeShift.lean` | `ea274daeadc4bf2242399663cd5da914b1c096f62b58cb43fdffa2e625af6b5c` |
| `LonelyRunner/FoldedCirclePhase.lean` | `957606878108847d5ceff47be621ff0fc9c0a0d976568b5f5ef3dbb6db10481e` |
| `LonelyRunner/FastRunnerInsertion.lean` | `dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5` |
| `LonelyRunner/StructuredClasses.lean` | `5328a7a88d2b42f86ffc3f0f0418ca22c761219e8fa3e5822bda5a18ac286e8c` |
| `lean-toolchain` | `8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af` |
| `lake-manifest.json` | `887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218` |
| `research/astra-three-even-orbit-implementation.json` | `5e5998be0436540b2ca544264594aa4dd4ce5230ce7b7a1b9e11f94dbe692caf` |

## Reported focused checks and explicit provenance limitations

The corrected, frozen receipt reports the following worker executions. These
were not repeated by the reviewer. Its `raw_output` values are **transcriptions
from the task transcript**, not original file-backed stdout/stderr bytes.

| Check | Reported source hash | Reported exit | Reported seconds |
| --- | --- | --- | --- |
| initial focused source | `827b74b018d25e3a98bf511e01c09e5d5b5474b942017e2d384bf95e320c40da` | 1 | 3.494255023 |
| repair 1 focused source | `2d2cbdd51dc51f1e23985feb9c7826ce5bb944118f01c8c7719e5ad25de4e088` | 0 | 4.470107668 |
| subsequent axiom audit | no separately retained stdin input | 0 | 1.702674986 |

The exact recorded command for both source checks is:

```text
flock -n .lake/verification.lock bash -lc 'ulimit -v 8388608; timeout 180 lake env lean -j1 -s65536 -o .lake/build/lib/lean/LonelyRunner/ThreeEvenOrbit.olean -i .lake/build/lib/lean/LonelyRunner/ThreeEvenOrbit.ilean LonelyRunner/ThreeEvenOrbit.lean'
```

The recorded axiom-audit command substitutes `lake env lean -j1 -s65536
/dev/stdin` after the same lock, address-space limit and `timeout 180` wrapper.
Its heredoc input was not retained. The actual recorded controls are 8 GiB
address space, a 180-second wall timeout and Lean `-j1 -s65536`. **No separate
CPU-time quota was applied or measured.** `-j1` is a Lean thread setting, not
a CPU-time limit. No per-stream cap, complete-stream metadata or empty stderr
claim can be established from these transcriptions.

The failed initial transcript reports consumed/unknown `h2`, parity
contradiction failures, fractional and natural-cast rewrite mismatches,
unsolved signed ring identities, and a redundant tactic after a closed goal.
The failed source itself was not retained, so an exact repair diff cannot be
reviewed or reconstructed. The final source independently contains the correct
eight original contracts and complete proofs reviewed above. The successful
source-check transcription contains four `ring_nf` suggestions beginning
`The ring tactic failed to close the goal`, four `<;>` style warnings and two
warnings about an unexecuted/no-op `ring` at line 203. These messages are
preserved in the receipt; its reported final exit is 0. This review does not
replace the missing original streams with an invented clean output.

The complete reported axiom-audit transcription is:

```text
'LonelyRunner.threeEven_exists_even_unit_sixth_residue' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.threeEven_exists_odd_unit_sixth_residue' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.threeEven_circleNorm_nat_mul_fract' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.threeEven_circleNorm_sixth_weighted_shift' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.threeEven_small_phase_double_four_safe' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.threeEven_circleNorm_double_lt_third' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.threeEven_dvd_of_large_partner_at_zeros' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.threeEven_small_sixth_dilate_norm' depends on axioms: [propext, Classical.choice, Quot.sound]
```

The reviewer verified that the current source (10969 bytes), `.olean` (852008
bytes) and `.ilean` (27267 bytes) match the final recorded hashes. That is a
present-artifact binding, not an independently preserved historical input/output
chain. The initial snapshot has only its reported pre-check hash. The repaired
snapshot likewise has no separately retained historical bytes, even though its
reported hash agrees with the current source. Raw stream files, their original
stdout/stderr separation, and the axiom stdin cannot be recovered from this
receipt. No missing historical evidence was reconstructed or re-executed.

Delivery metrics correctly retain first-check failure, one worker repair round,
zero reported Astra repair rounds/lines, and null overall worker time/usage.
The post-hoc provenance correction does not add a source check or repair round.

## Verdict and remaining checkpoint obligation

Accept the final source's eight exact contracts and their mathematical proofs.
The reported focused success and eight permitted-axiom lists are supportive
historical evidence with the limitations above; they are not a complete raw
execution receipt. No new mathematical defect or distinct concern requiring an
independent import probe was found. Root requires the normal fresh full
integration build and trust audit for these helpers in their own later source
checkpoint; the current Phase 57 integration excludes `ThreeEvenOrbit` and
must not be cited as verifying it.

The odd-zero obstruction, common-shift five-label assembly, positive-witness
wrapper and cardinality adapter remain separate source obligations. This
conditional orbit bridge does not manufacture its `hlarge` premise or prove a
five-speed witness by itself. The goal remains active: establish canonical
N = 6, then transition to a uniform arbitrary-N mechanism, without promoting
these helpers to a completed runner-count or unrestricted theorem.
