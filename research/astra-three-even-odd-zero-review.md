# Independent source review: three-even odd-zero obstruction

Accepted: the frozen `ThreeEvenRunners.lean` implements exactly the odd-zero
contract from section 3 of the accepted plan, with no mathematical defect or
weakened hypothesis/conclusion found. This review covers the public abbreviation,
both private helper proofs and the complete public theorem proof. It does not
cover the future fixed-role witness or cardinality adapter, which are not yet
part of this frozen source.

The reviewer authored the three-even manuscript but did not author this Lean
implementation. This is an independent implementation-source review, with that
manuscript authorship disclosed. Project instructions/policy and focused state
were read; the assigned checkpoint is `34afe4f`, and only this report is owned.
The required workflow validator actually returned exit 0 and
`workflow structural validation passed; it cannot certify mathematical validity.`
No new Lean/compiler/probe, numerical experiment, source edit, Git/state change
or cache operation was performed. Source and retained execution evidence were
read and checked statically.

## Exact accepted public scope

Both declarations are in namespace `LonelyRunner`:

```lean
abbrev ThreeEvenFiveSafe (A E F U W : ℕ) (t : ℝ) : Prop :=
  (1 : ℝ) / 6 ≤ circleNorm (t * (A : ℝ)) ∧
  (1 : ℝ) / 6 ≤ circleNorm (t * (E : ℝ)) ∧
  (1 : ℝ) / 6 ≤ circleNorm (t * (F : ℝ)) ∧
  (1 : ℝ) / 6 ≤ circleNorm (t * (U : ℝ)) ∧
  (1 : ℝ) / 6 ≤ circleNorm (t * (W : ℝ))

theorem three_even_at_odd_zero
    (A E F U W : ℕ)
    (hA6 : 6 ∣ A) (hE2 : 2 ∣ E) (hF2 : 2 ∣ F)
    (hU2 : ¬ 2 ∣ U) (hW2 : ¬ 2 ∣ W)
    (hE3 : ¬ 3 ∣ E) (hF3 : ¬ 3 ∣ F)
    (hU3 : ¬ 3 ∣ U) (hW3 : ¬ 3 ∣ W)
    (hno : ¬ ∃ s : ℝ, ThreeEvenFiveSafe A E F U W s)
    (t : ℝ) (hzero : Int.fract (t * (U : ℝ)) = 0)
    (hp : (1 : ℝ) / 6 ≤ circleNorm (t * (A : ℝ))) :
    (1 : ℝ) / 6 < circleNorm (t * (E : ℝ)) ∧
    (1 : ℝ) / 6 < circleNorm (t * (F : ℝ)) ∧
    (1 : ℝ) / 3 < circleNorm (t * (W : ℝ))
```

Static extraction matched the plan's complete abbreviation and theorem after
changing the private planned name `FiveSafe` to public `ThreeEvenFiveSafe` and
ignoring whitespace/visibility. There are no ambient hypotheses. In particular
the theorem does not assume positivity, tuple gcd 1, distinct speed values,
or a supplied lonely witness. The time t and the quantified times in hno are
arbitrary reals. Repeated values permitted by the residue hypotheses are allowed.
The zero value of A is not excluded syntactically, though hp then cannot hold.
No hidden strengthening of hno to a restricted interval or positive times occurs.

## Complete proof assessment

The abbreviation is exactly the five closed inequalities at one common time,
in order A,E,F,U,W. It adds no parity assumptions of its own.

The private `threeEven_signed_fract_circleNorm` states
`N(σ*fract q)=N(q)` for every real q and integer sign σ=±1. At σ=1 it uses
the checked natural-multiple fractional-part identity at n=1; at σ=-1 it
also uses `circleNorm_neg`. Thus negative q and integral phases are covered.
The private `threeEven_odd_sixth_safe` states
`1/6≤N(σ*b/6)` when σ=±1 and natural `1≤b≤5`. It removes the sign and
applies the checked closed integer-band lemma to `[1/6,5/6]`. Both endpoint
values b=1 and b=5 are correctly retained. Its name does not add an odd-speed
hypothesis: it is a scalar signed-phase lemma.

The main proof independently chooses centered residues
`E=6*zE+2*σE`, `F=6*zF+2*σF`, `U=6*zU+σU`, `W=6*zW+σW` with signs ±1,
using the exact parity/non-three-divisibility hypotheses. It sets
`x=σE*fract(t*E)`, `y=σF*fract(t*F)`, `z=σW*fract(t*W)`.
These are signed fractional parts, not folded norms substituted as phases.
The first private helper proves `N(x)=N(t*E)` and `N(y)=N(t*F)`.
The zero hypothesis and n=1 fractional norm identity give `N(t*U)=0`.

If E is at most 1/6, `sixth_shift_weak_even x y z` returns **one** b in
`{1,2,4,5}` making `x+2b/6`, `y+2b/6` and `z+b/6` all closed-safe.
The source obtains `1≤b≤5` by disjunction cases. At the single actual time
`t+b/6`, A is preserved since `6∣A`. The checked weighted-shift identity
with weights 2,2,1 transfers the three returned bounds to E,F,W respectively.
It permits each residue sign to be chosen independently and still uses that
same actual time shift. At U the weight-one identity gives

`N((t+b/6)*U)=N(σU*fract(t*U)+b/6)=N(b/6)`.

Consequently the final source correctly invokes the scalar safety helper with
sign **1** here. The weighted identity has already absorbed the original σU
by reflection; multiplying the residual b/6 by σU again would not match this
expression. All five conjuncts of `ThreeEvenFiveSafe` hold, contradicting hno.
The same argument for F calls `sixth_shift_weak_even y x z` and restores the
returned E/F bounds in the right order. Each contradiction uses one common b;
the E and F contradiction proofs need not share a b with each other. Therefore
both original even-phase norms are strictly greater than 1/6, including exclusion
of equality.

For the last conclusion, suppose `N(t*W)≤1/3`. At the single time `t+1/2`,
the even phases A,E,F are preserved by
`circleNorm_time_add_nat_div_of_dvd` with denominator 2 and numerator 1;
`2∣A` follows from `6∣A`. Their old closed safety follows from hp and the two
strict conclusions. The odd-half-time identity followed by `circleNorm_add_half`
makes U's norm exactly `1/2-N(t*U)=1/2` and makes W's norm
`1/2-N(t*W)≥1/6`. Thus all five are closed-safe, contradicting hno again.
At `N(t*W)=1/3` the new W norm is exactly 1/6 and remains a valid contradiction;
the resulting conclusion is correctly strict `N(t*W)>1/3`. No step assumes
t, t+b/6 or t+1/2 is positive. The optional weaker odd-sixth rescue from the
manuscript is unnecessary and the source does not claim to use it.

The proof is acyclic: it uses the already supplied residue/weighted-shift
helpers, weak-even phase theorem, and divisor/half-time identities. It never
uses the later five-moving or canonical six-runner theorem. The imported orbit
helpers' mathematical review remains separately bound below; this review does
not repair or erase their historical receipt limitations.

## Retained focused evidence, independently checked

The frozen receipt is 54440 bytes, SHA-256
`c390e9fed0877536b62615de5c82f9ea653f9f0af2358bf80c92388b33a11b7c`.
The reviewer actually verified all three physical before-source files against
their embedded bytes, byte counts and hashes; all nine physical stdout, stderr
and time-v files against their embedded bytes/counts/hashes; each recorded
before/after source hash equality; final source equality; and both current
artifact hashes/counts. All static checks passed. Both source repair diffs and
all raw diagnostics were read. No historical input was reconstructed.

| Attempt | Input SHA-256 | Actual exit | Wall seconds from time-v | Stdout / stderr bytes |
| --- | --- | --- | --- | --- |
| 1 | `a70eb467b17d20ee29ceb20d4e777fb3ba360a8c5df549d03a67244e9e4effe3` | 1 | 2.40 | 9561 / 0 |
| 2 | `caa120e1763ef36f02529e5cc0b7f5cd2b2463cdb67e06fb887f94f381453111` | 1 | 2.90 | 510 / 0 |
| 3 | `22351370ee5c81f7e07d86aa76fe1a2656dc0a02d76687fb86722c246a2f08f7` | 0 | 2.98 | 969 / 0 |

These are the worker's historical executions, not new reviewer checks.
Each recorded command exports the Elan PATH prefix, locks
`.lake/verification.lock`, and runs `/usr/bin/time -v` around
`timeout --preserve-status 180s prlimit --as=8589934592 --cpu=179:180
lake env lean -j1 -s65536 LonelyRunner/ThreeEvenRunners.lean`
with explicit shared `.olean`/`.ilean` outputs. Exact full command strings and
the attempt-specific `/tmp/astra-three-even-odd-zero-check-0N*` paths are in
the receipt. Actual controls are 8 GiB address space, CPU soft/hard 179/180
seconds and a 180-second wall limit. No separate per-stream cap is claimed.
The successful time-v stream records user/system CPU 2.40/0.59 seconds and
maximum resident set 3329660 KiB.

Attempt 1 failed on casts of one/numeral denominators, fraction-bound conversion,
the explicit norm-zero simplification, weight-one residue shapes and a half-shift
inequality. Repair 1 corrected these representations without altering the public
contract. Attempt 2 exposed exactly the two U-phase mismatches described above;
repair 2 changed the scalar safety calls from σU to sign 1 after the weighted
transport. No mathematical assumption, chosen common shift or endpoint changed.
Attempt 3 completed with five style warnings only, at lines 97,120,141,145,149
about `<;>` where `;` would suffice. No warnings were suppressed.

Final stdout SHA-256 is
`345f9d55f8f4313805f6480dd2469a7f5ca3d1ddce944a5b002df27d11ae24ed`;
its complete bytes remain in the receipt and physical stream file. Every stderr
is empty with SHA-256
`e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.
Final source is 7801 bytes. Final `.olean` is 335272 bytes, SHA-256
`9d542a844f5153c950d85e3434007fbbf4ee6986999e6f6548205f7cf9178d08`;
final `.ilean` is 15894 bytes, SHA-256
`40912821a687f2acc062fae67aeacbdb4da24cacebac704b8d7e19ffdcfc9245`.

The receipt explicitly has `axiom_probe: null`; no separate axiom list for this
new declaration is claimed. Root's normal later integration and trust/axiom audit
remain required. The complete focused source check and semantic review disclose
no distinct concern requiring a duplicate probe now. Delivery metrics correctly
retain first-check failure, two worker repair rounds, zero Astra repairs/lines,
and null total worker elapsed time/usage where not exposed.

## Frozen source and API bindings

Paths are relative to `/home/joshua/lonely-runner-formalization`. Mutable root
imports, audit files and state are not frozen by this report. A later extension
of `ThreeEvenRunners.lean` requires its own source checkpoint review; the exact
current source is also retained in the bound successful input snapshot.

| Path | SHA-256 |
| --- | --- |
| `LonelyRunner/ThreeEvenRunners.lean` | `22351370ee5c81f7e07d86aa76fe1a2656dc0a02d76687fb86722c246a2f08f7` |
| `research/astra-three-even-odd-zero-implementation.json` | `c390e9fed0877536b62615de5c82f9ea653f9f0af2358bf80c92388b33a11b7c` |
| `research/astra-three-even-assembly-plan.md` | `66a9bac477d1e985d23f6188197ca7af6f0d90ad29df38ab8e710ed417cf510a` |
| `LonelyRunner/ThreeEvenOrbit.lean` | `2d2cbdd51dc51f1e23985feb9c7826ce5bb944118f01c8c7719e5ad25de4e088` |
| `research/astra-three-even-orbit-source-review.md` | `69e38074735e7480e5fca33dbc15a0b5d81faf9a1048860d270f39f792b841b6` |
| `LonelyRunner/WeakSixthShifts.lean` | `8c2ba998a08976ffc33f6af0226908a1bc068c322bac793e071210c49b1ce61b` |
| `LonelyRunner/OddHalfTimeShift.lean` | `ea274daeadc4bf2242399663cd5da914b1c096f62b58cb43fdffa2e625af6b5c` |
| `LonelyRunner/FoldedCirclePhase.lean` | `957606878108847d5ceff47be621ff0fc9c0a0d976568b5f5ef3dbb6db10481e` |
| `LonelyRunner/RationalShiftOrbits.lean` | `cf615dd6c6b3cf091cd5d31ac641f4f994c1c50d95e0120c311d3ac129b88591` |
| `LonelyRunner/FastRunnerInsertion.lean` | `dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5` |
| `LonelyRunner/StructuredClasses.lean` | `5328a7a88d2b42f86ffc3f0f0418ca22c761219e8fa3e5822bda5a18ac286e8c` |
| `lean-toolchain` | `8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af` |
| `lake-manifest.json` | `887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218` |

The accepted result is this exact local obstruction with its all-real hno
hypothesis. Fixed-role witness assembly, its count adapter and canonical N=6
remain separate obligations. N=6 remains a transition to uniform arbitrary-N
research, not a completion claim for unrestricted LRC.
