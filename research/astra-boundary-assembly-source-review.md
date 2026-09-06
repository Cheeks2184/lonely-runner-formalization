# Independent source review: odd complement, even anchor and boundary zero

Semantic decision: **accept all three exact auxiliary contracts**. Complete
source review found no mathematical defect or hidden strengthening of a premise.
The single fixed import-only probe also passed; its exact predeclarations,
complete receipts and original streams are preserved below. These declarations do not by themselves establish
an unconditional runner-count theorem or unrestricted LRC.

I authored the earlier boundary assembly manuscript, but none of these three
source implementations. Terra drafted TwoOddOutsideThree and EvenAnchorThreeTimes;
root corrected their elaboration steps and authored TwoDivisibleBoundary.
A different Astra reviewer independently accepted the manuscript. This review
therefore independently checks the implementation, while disclosing my part in
the underlying design.

Only this report is owned. No source, state, Git, root import, cache or other
report is edited. No source build, numerical fixture, enumeration or solver is
run. Current project config, workflow, policy and focused state were read.
The task records checkpoint `a233f95`, requested Astra/xhigh and unavailable
observed model/effort, with phase research and goal in_progress. The actual
`python3 scripts/validate_workflow.py` exited 0:
`workflow structural validation passed; it cannot certify mathematical validity.`

## Frozen sources and exact comparison

| Input | SHA-256 |
| --- | --- |
| `LonelyRunner/TwoOddOutsideThree.lean` | `6b2c9fb02bffe58cdd2383246c56dfca3f91fe3b88c1a2902486b4d90cae6735` |
| `LonelyRunner/EvenAnchorThreeTimes.lean` | `5fbaaa745630ff16ae02249f1a52032b7f63f7453d1c853fbffba0a88182e2f7` |
| `LonelyRunner/TwoDivisibleBoundary.lean` | `5a3dc7ca4c0d777ba38d47e2f2b86a1036f9d6080f03f473ad87f6d31c1ca66c` |
| Original `research/astra-two-divisible-boundary-assembly.md` | `f282ced2c133f1bb607b2d5f6ca94d6b27bb8591605b445ee6de60b422a9800c` |
| Independent `research/astra-boundary-assembly-review.md` | `c5ad3f1e191f72561af6ae9f5a09a95b938a65762e0532ee1d61dab56f9e856f` |

The complete three source files and their directly used project interfaces were
read. Their scopes match the frozen manuscript and independent review. A static
comparison confirms the full boundary declaration equals the manuscript target
modulo whitespace. The complement theorem extracts exactly the label argument
used in the manuscript; the fallback has the identical three-time disjunction.
The probe below expands private `AllSafe` in all three alternatives into a
universal closed inequality. It retains the public FoldedPairSafeBands premise
and all hypotheses verbatim in meaning, without local specializations.

## 1. Exact odd-label complement

`exists_two_odd_outside_three` assumes three pairwise distinct labels p,q,r
whose speeds are even and a bound of at most three even labels in Fin 5.
There is no positivity, gcd, three-divisibility or injectivity assumption.
The theorem returns distinct labels u,w, their oddness, and a five-way equality
disjunction covering every label. Although nonmembership in {p,q,r} is not
separately printed in the conclusion, oddness and the supplied evenness force
it; the proof actually obtains u,w from the complement.

Set K={p,q,r}, E=the even-label filter. The three label inequalities give
card K=3; the three evenness premises give K⊆E. Reexpressing heven as
`E.card ≤ 3` makes the let-defined finset explicit to the arithmetic tactic.
Then card monotonicity gives card E=3 and
`Finset.eq_of_subset_of_card_le` gives K=E. The complement O=univ\E has
cardinality 2 by `Finset.card_sdiff_of_subset`. The final ordinary `decide`
only closes the fixed equality card(Fin 5)-3=2 inside the already-built proof;
this review does not reexecute it or enumerate label assignments.

`Finset.card_eq_two` gives O={u,w} with u≠w. Membership in the set difference
makes both labels odd. For any i, membership in E gives i=p,q or r, embedded
explicitly into the larger conclusion disjunction. Otherwise membership in O
gives i=u or w. This counts labels, not distinct speed values, so repeated
natural speeds remain allowed. Zero speeds are even and cause no difficulty
in this purely combinatorial theorem when the premises hold.

## 2. One common time for all five labels

`both_six_even_anchor_three_time_witness` assumes distinct p,q,r, six-divisible
pair speeds, an even anchor, the same even-label upper bound, arbitrary real τ
with fract(τ*v r)=5/6, and supplied folded bands for the pair. It assumes neither
hno nor positivity nor exact three-divisibility. Its conclusion is precisely
AllSafe at 2τ, or at 2τ+1/2, or at 4τ+1/2. Each alternative quantifies over all
five labels; it is not a separate choice of time for each label.

Six-divisibility implies evenness, so the first theorem supplies odd u,w and
the complete label disjunction. The local folding identity uses
`circleNorm_nat_mul_add_int_half` with zero half-shift and preserves the actual
real phases. H.left_two/right_two prove pair safety at 2τ, and
H.left_four/right_four prove it at 4τ. Even-speed half-time preservation from
`circleNorm_time_add_nat_div_of_dvd` with ell=2,k=1 supplies the shifted versions.
No invalid general sixth-shift folding is invoked.

`fract_int_dilate_eq` with multipliers 2 and 4 turns the anchor phases into
fract(10/6)=2/3 and fract(20/6)=1/3. The source presents both numerator and
denominator explicitly as natural casts before the existing modulo rewrite.
`circleNorm_eq_min_fract` gives norm 1/3 at each phase, hence closed safety.
Since the anchor is even, these bounds survive the same half-time additions.
Thus p,q,r are safe at each of the three stated candidate times.

For x=(2τ)*v u and y=(2τ)*v w, the checked `two_phase_half_choices x y` gives
one common alternative: the original pair, their half-translates, or their
doubled half-translates. The odd half-time identity identifies those with the
actual phases of u,w at the three candidate times. The third branch explicitly
rewrites `(4τ)*d+1/2 = 2*((2τ)*d)+1/2`; it does not rely on an unproved
associativity normalization. Branch substitutions use the surviving label i
with the appropriately rewritten oddness hypothesis.

The proof chooses an outer disjunction branch before introducing an arbitrary
label i, then resolves the five-way label decomposition. Consequently the
returned alternative is uniform over all five labels. All inequalities are
closed at 1/6; strict failure is used only inside the already-checked two-phase
choice lemma, where equality stays on the safe side. Equal speed values and
negative τ are allowed. No positive-time statement is concluded. An anchor
speed zero is inconsistent with its supplied phase, and zero pair speeds are
inconsistent with the bands; no hidden explicit positivity assumption is added.

## 3. Boundary minimum at every anchored real time

The public boundary theorem retains positive Fin 5 natural speeds, distinct
p,q,r, the exact classification `3∣v i ↔ i=p ∨ i=q`, at least one six-divisible
pair label, at most three even labels, nonexistence of an all-real closed-sixth
witness, and an arbitrary queried real t with anchor phase 5/6. No primitive gcd,
ratio, divisibility-cover, strict seed or preexisting positive maximum appears.
The uniform hpos assumption is retained even though only hpos r is used by the
finite maximizer. The queried t need not be positive or normalized.

The private `pair_special_rescue` proves a real witness from pair safety and
anchor phase 1/6 or 5/6. The exact hdiv supplies safety for every divisible label.
The independent `three_exceptions_of_two_divisible_labels` gives exactly three
nondivisible labels, hence the required upper bound. The helper embeds 1/6 or
5/6 into the special-sixth disjunction and applies
`exists_third_shift_of_special_sixth_seeded_divisible`. Its single k : Fin 3
works for all labels at s+k.val/3. This use does not require s positive.
The exception-count theorem is proved solely by finite-set cardinality; the
small-pair witness theorem elsewhere in its imported module is not called.

The second private helper takes the supplied ordered band packet and splits
on `6∣v p ∧ 6∣v q ∧ 2∣v r`. The even case gives an AllSafe witness at one of
the three explicit times above. In the other case the exact five-row selector
gives a common n,σ, a safe pair and a special anchor at nτ+σ/6. The private
rescue then supplies one witness for all labels. Both branches contradict the
actual all-real hno. Negative σ or negative resulting times cause no gap;
positive-time nonexistence would require an additional bridge and is not
silently substituted here.

The finite maximizer requires only positive anchor speed c=v r. It considers
c normalized times `(j+5/6)/c` indexed by Fin c, chooses a maximum of the pair
minimum using `Finset.exists_max_image`, and returns τ∈(0,1) at the anchor.
Its proof reduces any real time, including a negative one, to its fractional
part, preserves natural-speed norms, and uses the floor of that normalized
anchor phase to obtain an index in Fin c. Thus its bound covers *all* real
anchored times. This is a mathematical finite-maximum proof, not a search
performed during this review, and it imposes no positivity on the objective.

Let M=min(N(τ*v p),N(τ*v q)). Norm nonnegativity gives M≥0. If M≥1/6, both
pair labels are safe, and `pair_special_rescue` at τ contradicts hno. Hence
M<1/6. Only after assuming M≠0 inside a contradiction branch does the proof
obtain M>0 from nonnegativity. It never asks a strict-seed maximizer to produce
such a positive M.

Total order of the two norms supplies two branches. In the p≤q branch,
`min_eq_left` identifies M with N(τ*v p) in the positive/small facts and in
the *entire* global fiber bound. The exact bound, ordering and phase go into
`foldedPairSafeBands_of_five_sixths_pair_bound`, whose source derives the scalar
constraints by transport to 3τ and 5τ and then the ten safe bands.

In the reverse branch, `min_eq_right` identifies M with N(τ*v q). For every
anchored s the proof first rewrites the left side by `min_comm`, then rewrites
the right bound using the order at τ. It exchanges p,q in the band constructor,
uses `or_comm` to build the exact swapped hdiv, reverses the six-divisibility
disjunction and p≠q, and exchanges r's two inequalities. The even count and τ
are unchanged. No actual phase is replaced by its folded orientation, and the
smaller-norm label is not presumed six-divisible. Equal norms are covered by
non-strict total order without needing a unique maximizer or tie rule.

In either ordering the private contradiction helper rules out M>0. Thus M=0.
Finally, the *original* maximum bound at the arbitrary queried t gives its pair
minimum ≤0, while norm nonnegativity gives ≥0. `le_antisymm` proves equality.
The final result is therefore about every real 5/6 fiber time, not only τ.

The dependency route uses the cardinality/third-shift lemmas, finite maximum,
transport/scalar bands, selector and even-anchor fallback. It does not invoke
the separate cover-to-witness finisher or BoundaryZeroDivisibility, nor does it
assume this boundary theorem in a seed. The import of ConstrainedMaximizer
through norm APIs supplies identities; its strict-seed maximizer is not called.
The three universal public types below preserve all these boundaries.

## Source-build history versus this review

Root's `research/astra-pass52-verification.json` was read at SHA-256
`adab55d644912d3800784d562a6bac61621d2bf8c88bb84d76dd94e622e93c3c`.
Its complete source/log records remain separate from this review's own probe.
The initial complement proof exited 1 because let-defined cardinalities were
not normalized for omega and a three-way disjunction needed explicit embedding.
The corrections give E.card≤3 explicitly, use the exact set-difference cardinal
rewrite, and inject each label equality. The successful focused build exited 0
at 2,997 jobs.

The fallback first exited 1 on missing explicit Nat denominator casts and
label names removed by branch substitution; its second attempt exited 1 on
the two doubled-phase reassociations. The final source fixes those points.
Static header comparison with all three preserved failed drafts confirms the
public complement/fallback contracts unchanged. The combined fallback/boundary
focused build exited 0 at 3,034 jobs. Boundary passed its first actual compile,
retaining two `linter.unnecessarySimpa` warnings at lines 56 and 88. These
warnings and the replayed informational ring suggestions are preserved in root's
history, not misreported as a warning-free source build.

| Prior failed source | Source SHA-256 | Full stored log SHA-256 |
| --- | --- | --- |
| Complement initial, exit 1 | `83982dd56039d8d06457f73f6210e4b4e4ea8dff66d4c699eb3a8e1649a19833` | `a8b58ae2e1f032e16c12e083b9b9843591957f2e52b1df4ed5da45511823104e` |
| Fallback initial, exit 1 | `5eaffd7216e2bf0baec0d1d826e33eb60a80e918ff068997e48744bd15763557` | `5808b1e58073678d0d7af8fd782ee37071509ab9be2b29a7c944af03130c962f` |
| Fallback second, exit 1 | `434c286eecdd025feef8fa6185ae969bd533f40977b2a1ee10d80d7b35cabf5e` | `59d01a6f38a5aaca98bdd99c4d01b8f60fbd4e4a44edbd1aebdb14358fc32dde` |

The first root-module integration exited 1 because imports were appended after
the module documentation. Root corrected their ordering; this was not a failed
boundary theorem. Root's subsequent full build exited 0 at 3,708 jobs, full log
SHA `e8eef1816f4088702033c3c555dd295064d60f94df3bf9e18ff86ddda57e2e13`.
Root's separate trust command exited 0 with 639 axiom-list reports and eight
axiom-free reports, full log SHA
`5f1de48e596e9a0354b4587256d59e472ede6fa4a726efa0b4abc9d55767f08b`.
This reviewer does not rerun a build or trust audit. The three imports below
produce independent exact type/axiom evidence for the reviewed artifacts.

## Predeclared fixed probe and sole replay entry

The exact payload has three direct imports, three complete universal type
assignments and three full axiom prints. The private AllSafe abbreviation is
expanded separately in each disjunction branch. No local numerical controls,
proof experiment, case enumeration or formatting option is included. SHA-256
covers each exact UTF-8 fence, including its final newline, before execution.

Probe SHA-256: `f0c4ac8940b1b70e3e613bc7e95008541c53b6e2c071ecfbbd917d96d5be1d63`
Launcher SHA-256: `0be6e48f6675db21c21d5987760f8448657a285a4851f4577ca6aee5cfacc228`

The complete Python controller is embedded in the single Bash entry below.
Its 39 guards bind the three target source/olean pairs, all nine other direct
project dependencies, four relevant norm/band/special-rescue source/olean pairs,
Mathlib.Tactic, three project pins and both pinned runtime binaries. The
manifest pins mathlib to `520045ab14e26149ee970e2e617ca04b09bde5d6`.
PATH and resolved-executable checks select the guarded Lean/Lake v4.32.1 binaries.
All input guards are checked before and after the actual run. Both fence
predeclarations are checked against the fixed bytes read at startup.

Only `lake env lean -j1 -s65536 --stdin` is invoked, with explicit environment
threads 1 and stack 65536 KiB. Limits: AS 8 GiB; CPU soft/hard 59/60 seconds;
wall 60 seconds; each regular stdout/stderr file 128 KiB; core dumps disabled.
Timeout kills the child's process group. Errors, signals, timeouts, cap hits
or guard changes fail the run while preserving the complete status and streams.
There is no automatic retry, build or resource escalation. The parser requires
exactly the three named axiom reports, in order, no other stdout or stderr,
and only propext, Classical.choice, Quot.sound.

A complete pre-run report snapshot is retained. Root's later replay necessarily
snapshots the report after its actual evidence is appended; the probe, launcher,
guards, caps and output contract stay frozen.

```lean
import LonelyRunner.TwoOddOutsideThree
import LonelyRunner.EvenAnchorThreeTimes
import LonelyRunner.TwoDivisibleBoundary

open LonelyRunner

example :
    ∀ (v : Fin 5 → ℕ) (p q r : Fin 5),
      p ≠ q → r ≠ p → r ≠ q →
      2 ∣ v p → 2 ∣ v q → 2 ∣ v r →
      ((Finset.univ : Finset (Fin 5)).filter (fun i => 2 ∣ v i)).card ≤ 3 →
      ∃ u w : Fin 5, u ≠ w ∧ ¬ 2 ∣ v u ∧ ¬ 2 ∣ v w ∧
        ∀ i : Fin 5, i = p ∨ i = q ∨ i = r ∨ i = u ∨ i = w :=
  LonelyRunner.exists_two_odd_outside_three

example :
    ∀ (v : Fin 5 → ℕ) (p q r : Fin 5),
      p ≠ q → r ≠ p → r ≠ q →
      6 ∣ v p → 6 ∣ v q → 2 ∣ v r →
      ((Finset.univ : Finset (Fin 5)).filter (fun i => 2 ∣ v i)).card ≤ 3 →
      ∀ τ : ℝ, Int.fract (τ * (v r : ℝ)) = (5 : ℝ) / 6 →
        FoldedPairSafeBands (circleNorm (τ * (v p : ℝ)))
          (circleNorm (τ * (v q : ℝ))) →
        (∀ i : Fin 5, (1 : ℝ) / 6 ≤ circleNorm ((2 * τ) * (v i : ℝ))) ∨
          (∀ i : Fin 5, (1 : ℝ) / 6 ≤ circleNorm ((2 * τ + 1 / 2) * (v i : ℝ))) ∨
          (∀ i : Fin 5, (1 : ℝ) / 6 ≤ circleNorm ((4 * τ + 1 / 2) * (v i : ℝ))) :=
  LonelyRunner.both_six_even_anchor_three_time_witness

example :
    ∀ v : Fin 5 → ℕ, (∀ i, 0 < v i) →
      ∀ p q r : Fin 5, p ≠ q → r ≠ p → r ≠ q →
        (∀ i, 3 ∣ v i ↔ i = p ∨ i = q) →
        (6 ∣ v p ∨ 6 ∣ v q) →
        ((Finset.univ : Finset (Fin 5)).filter (fun i => 2 ∣ v i)).card ≤ 3 →
        (¬ ∃ t : ℝ, ∀ i, (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ))) →
        ∀ t : ℝ, Int.fract (t * (v r : ℝ)) = (5 : ℝ) / 6 →
          min (circleNorm (t * (v p : ℝ)))
            (circleNorm (t * (v q : ℝ))) = 0 :=
  LonelyRunner.two_divisible_boundary_min_eq_zero

#print axioms LonelyRunner.exists_two_odd_outside_three
#print axioms LonelyRunner.both_six_even_anchor_three_time_witness
#print axioms LonelyRunner.two_divisible_boundary_min_eq_zero
```

```bash
#!/usr/bin/env bash
set -euo pipefail
cd /home/joshua/lonely-runner-formalization
export PATH="/home/joshua/.elan/toolchains/leanprover--lean4---v4.32.1/bin:$HOME/.elan/bin:$PATH"
export LEAN_NUM_THREADS=1
export LEAN_STACK_SIZE_KB=65536
python3 - <<'PY'
import hashlib
import json
import os
from pathlib import Path
import re
import resource
import signal
import shutil
import subprocess
import tempfile
import time

root = Path('/home/joshua/lonely-runner-formalization')
report = root / 'research/astra-boundary-assembly-source-review.md'
text = report.read_text()
fence = chr(96) * 3
probe = text.split(fence + 'lean\n', 1)[1].split(fence, 1)[0].encode()
launcher = text.split(fence + 'bash\n', 1)[1].split(fence, 1)[0].encode()
out = Path(tempfile.mkdtemp(prefix='astra-boundary-assembly-review-'))
(out / 'stdin.bin').write_bytes(probe)
(out / 'launcher.sh').write_bytes(launcher)
(out / 'report-snapshot.md').write_bytes(text.encode())
guards = {
    'LonelyRunner/TwoOddOutsideThree.lean': '6b2c9fb02bffe58cdd2383246c56dfca3f91fe3b88c1a2902486b4d90cae6735',
    '.lake/build/lib/lean/LonelyRunner/TwoOddOutsideThree.olean': '2c7c09847be7e443da28e4439c21e2966d20777a5cb60d9cf7ea908c9b1eb255',
    'LonelyRunner/EvenAnchorThreeTimes.lean': '5fbaaa745630ff16ae02249f1a52032b7f63f7453d1c853fbffba0a88182e2f7',
    '.lake/build/lib/lean/LonelyRunner/EvenAnchorThreeTimes.olean': '1091b721112207b70cca7316b32e607e15aee98b5813f66af13f280aeb55d18b',
    'LonelyRunner/TwoDivisibleBoundary.lean': '5a3dc7ca4c0d777ba38d47e2f2b86a1036f9d6080f03f473ad87f6d31c1ca66c',
    '.lake/build/lib/lean/LonelyRunner/TwoDivisibleBoundary.olean': 'affcd1c846fe099c66b978e2873fd0261ea324b872b46a3d4a4c86d9c182395d',
    'LonelyRunner/OddHalfTimeShift.lean': 'ea274daeadc4bf2242399663cd5da914b1c096f62b58cb43fdffa2e625af6b5c',
    '.lake/build/lib/lean/LonelyRunner/OddHalfTimeShift.olean': '728fdb322e3fe2f10c3c693bc17dd460b302cca2ee42a7bd835ca1a6231e572c',
    'LonelyRunner/TwoPhaseHalfChoices.lean': 'cb5c23225a130c8613c1897a749eaa7834c14b3de504ae8b51f1744c53624acc',
    '.lake/build/lib/lean/LonelyRunner/TwoPhaseHalfChoices.olean': '13bc283e5024b6af7d999c107a03ccca7ddf387ddb0c522cefd058a422b13517',
    'LonelyRunner/AnchoredPairTransport.lean': '63414c3ccb6c12c1ed8775cb7e18dccc84c30da42cd4be089ac336df75ceca43',
    '.lake/build/lib/lean/LonelyRunner/AnchoredPairTransport.olean': '5254122c6d4ab3e583adf5676fe05aa7268dfa3412e2aee7889fbacc3832a07e',
    'LonelyRunner/RationalShiftOrbits.lean': 'cf615dd6c6b3cf091cd5d31ac641f4f994c1c50d95e0120c311d3ac129b88591',
    '.lake/build/lib/lean/LonelyRunner/RationalShiftOrbits.olean': '8194c5c6ac0b8495146728fcac70a6a1e9d317f9e7689c4759f22ed33c14340f',
    'LonelyRunner/AnchoredPairMaximizer.lean': '050888f1d9017183661dbca6e2e61bfeb518849c339bc77b43605a6b3918bdd8',
    '.lake/build/lib/lean/LonelyRunner/AnchoredPairMaximizer.olean': '0e567db35d8ae412e8688f6bfacf1e2d70a30cad24fd3a3bca34575b4b101d00',
    'LonelyRunner/AnchoredPairSafeBands.lean': '14212e32cdd3a343b286dd0fc370cefa6c33c145541f61afdf42e8e5290bc306',
    '.lake/build/lib/lean/LonelyRunner/AnchoredPairSafeBands.olean': '1457a21fc39aa4ad489891c9b19cb8be2a74bfc9164fbccb5574c7a61b451a86',
    'LonelyRunner/PairSafeSixthAffine.lean': '290b5844fd7e3a11baf1c51d724a904362a41d76e31c3e78c45c7818b9763737',
    '.lake/build/lib/lean/LonelyRunner/PairSafeSixthAffine.olean': '2c62c951e8945d12a7945d2c41bfc9213f008d43dfc8482e5d238e9f0954a745',
    'LonelyRunner/TwoDivisibleSmallPair.lean': 'ff40734821aae9abff43fdfc17c4275f4b5d045b4757b254dc11d24e695e8821',
    '.lake/build/lib/lean/LonelyRunner/TwoDivisibleSmallPair.olean': '84c69092542b315e611aad9498aa57dc5e56e442b10b2a37d6c4836f8ce24af9',
    'LonelyRunner/ThirdShiftSpecialSeed.lean': 'ffbab991e23c45a1cd0abb2f692c30f35665f04ae5843a70898da00c69ab6187',
    '.lake/build/lib/lean/LonelyRunner/ThirdShiftSpecialSeed.olean': 'f0c65f1e1d6e4f2982a645bdbc116d690f2508223de02e31ac4e479445536f58',
    'LonelyRunner/ThirdShiftRescues.lean': '829db12405e64ad88da5501ddb167d650ad82cf92295a88fd2374d9e08281732',
    '.lake/build/lib/lean/LonelyRunner/ThirdShiftRescues.olean': 'f43015c4f1d03a823ae6987b979d1ea09a5d972e2ee8c7cc953c149d666d2e94',
    'LonelyRunner/SpecialSixthPhase.lean': '677372ee3dc86520051f4bcc037f685a3f5fd8748c737ef9e1d2bfc5ac0072d8',
    '.lake/build/lib/lean/LonelyRunner/SpecialSixthPhase.olean': '2e4951ab757b0fa22574e72381abd7be6cca5c971f9e38967cf24f0991532537',
    'LonelyRunner/FoldedCirclePhase.lean': '957606878108847d5ceff47be621ff0fc9c0a0d976568b5f5ef3dbb6db10481e',
    '.lake/build/lib/lean/LonelyRunner/FoldedCirclePhase.olean': '3032bbcf8e5c414daea831a7a415a40b4f254e5b72428b6fa078742e891afc06',
    'LonelyRunner/FoldedPairSafeBands.lean': '00903bcb0c131fdb31ab87d55cea809249dfacbbd5861f82ab3a987d39b74b5f',
    '.lake/build/lib/lean/LonelyRunner/FoldedPairSafeBands.olean': 'd000b970290ec9072f02465f527b817f32bb72113ed7fa09bd43c9f0a47287c8',
    '.lake/packages/mathlib/Mathlib/Tactic.lean': 'c6f2c548596b635a3d5c8aff8b19cbdeb60dd54e41bb89a1cd03b1a54d335fa5',
    '.lake/packages/mathlib/.lake/build/lib/lean/Mathlib/Tactic.olean': '0534ef12e7aaf8ffbb6e520a91f922da4469d0dca2b54c87b4458e1faa28a6a2',
    'lean-toolchain': '8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af',
    'lakefile.toml': 'bdcbaaa18d518409619215e8acf7892452c1fa5c6e80ba742ce67f7380682a26',
    'lake-manifest.json': '887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218',
    '/home/joshua/.elan/toolchains/leanprover--lean4---v4.32.1/bin/lean': 'e8baaa71855a616dc351028f3ad2200051b0671f423a1696a100e809302d5550',
    '/home/joshua/.elan/toolchains/leanprover--lean4---v4.32.1/bin/lake': '60330ab6f07dce20f3fa9ebb08e8b984ea9549eac172afeb15d9d2227060e2b3',
}
argv = ['lake', 'env', 'lean', '-j1', '-s65536', '--stdin']
limits = {'address_space_bytes': 8 * 1024**3, 'cpu_seconds': [59, 60],
          'wall_seconds': 60, 'stream_bytes': 128 * 1024}
symbols = [
    'LonelyRunner.exists_two_odd_outside_three',
    'LonelyRunner.both_six_even_anchor_three_time_witness',
    'LonelyRunner.two_divisible_boundary_min_eq_zero',
]
allowed = {'propext', 'Classical.choice', 'Quot.sound'}
receipt = {'argv': argv, 'limits': limits, 'guards': guards,
           'environment': {'LEAN_NUM_THREADS': '1', 'LEAN_STACK_SIZE_KB': '65536'},
           'exit': None, 'timed_out': False, 'error': None,
           'guards_before': False, 'guards_after': False,
           'predeclarations_match': False, 'axioms': None,
           'axiom_output_valid': False}

def sha(data):
    return hashlib.sha256(data).hexdigest()

def check_guards():
    for name, expected in guards.items():
        assert sha((root / name).read_bytes()) == expected, name

def capped_child():
    resource.setrlimit(resource.RLIMIT_AS, (limits['address_space_bytes'],) * 2)
    resource.setrlimit(resource.RLIMIT_CPU, tuple(limits['cpu_seconds']))
    resource.setrlimit(resource.RLIMIT_FSIZE, (limits['stream_bytes'],) * 2)
    resource.setrlimit(resource.RLIMIT_CORE, (0, 0))

before = resource.getrusage(resource.RUSAGE_CHILDREN)
start = time.monotonic()
proc = None
try:
    probe_expected = re.search(r'^Probe SHA-256: `([0-9a-f]{64})`$', text, re.M)
    launcher_expected = re.search(r'^Launcher SHA-256: `([0-9a-f]{64})`$', text, re.M)
    assert probe_expected and launcher_expected, 'missing predeclarations'
    assert sha(probe) == probe_expected.group(1), 'probe bytes'
    assert sha(launcher) == launcher_expected.group(1), 'launcher bytes'
    receipt['predeclarations_match'] = True
    check_guards()
    receipt['resolved_executables'] = {name: str(Path(shutil.which(name)).resolve())
                                       for name in ['lake', 'lean']}
    for name, path in receipt['resolved_executables'].items():
        assert path == '/home/joshua/.elan/toolchains/leanprover--lean4---v4.32.1/bin/' + name, name
    receipt['guards_before'] = True
    env = os.environ.copy()
    env.update(receipt['environment'])
    with (out / 'stdin.bin').open('rb') as stdin, \
            (out / 'stdout.bin').open('wb') as stdout, \
            (out / 'stderr.bin').open('wb') as stderr:
        proc = subprocess.Popen(argv, cwd=root, stdin=stdin, stdout=stdout,
                                stderr=stderr, env=env, start_new_session=True,
                                preexec_fn=capped_child)
        try:
            receipt['exit'] = proc.wait(timeout=limits['wall_seconds'])
        except subprocess.TimeoutExpired:
            receipt['timed_out'] = True
            os.killpg(proc.pid, signal.SIGKILL)
            receipt['exit'] = proc.wait()
    check_guards()
    receipt['guards_after'] = True
    output = (out / 'stdout.bin').read_text()
    pattern = r"'([^']+)' depends on axioms:\s*\[([^\]]*)\]\s*"
    matches = list(re.finditer(pattern, output))
    if (''.join(m.group(0) for m in matches) == output
            and [m.group(1) for m in matches] == symbols):
        axioms = {m.group(1): [x.strip() for x in m.group(2).split(',') if x.strip()]
                  for m in matches}
        receipt['axioms'] = axioms
        receipt['axiom_output_valid'] = all(
            len(a) == len(set(a)) and set(a) <= allowed for a in axioms.values())
except BaseException as exc:
    receipt['error'] = repr(exc)
    if proc is not None and proc.poll() is None:
        os.killpg(proc.pid, signal.SIGKILL)
        receipt['exit'] = proc.wait()
finally:
    after = resource.getrusage(resource.RUSAGE_CHILDREN)
    receipt['wall_seconds'] = time.monotonic() - start
    receipt['child_user_seconds'] = after.ru_utime - before.ru_utime
    receipt['child_system_seconds'] = after.ru_stime - before.ru_stime
    receipt['child_max_rss_kib'] = after.ru_maxrss
    for name in ['stdout.bin', 'stderr.bin']:
        if not (out / name).exists():
            (out / name).write_bytes(b'')
    receipt['files'] = {}
    for name in ['stdin.bin', 'stdout.bin', 'stderr.bin', 'launcher.sh', 'report-snapshot.md']:
        data = (out / name).read_bytes()
        receipt['files'][name] = {'bytes': len(data), 'sha256': sha(data)}
    receipt['stream_cap_hit'] = any(receipt['files'][name]['bytes'] >= limits['stream_bytes']
                                    for name in ['stdout.bin', 'stderr.bin'])
    receipt['passed'] = (receipt['exit'] == 0 and receipt['error'] is None
                         and receipt['guards_before'] and receipt['guards_after']
                         and receipt['predeclarations_match']
                         and receipt['axiom_output_valid']
                         and receipt['files']['stderr.bin']['bytes'] == 0
                         and not receipt['timed_out'] and not receipt['stream_cap_hit'])
    encoded = (json.dumps(receipt, sort_keys=True, indent=2) + '\n').encode()
    (out / 'receipt.json').write_bytes(encoded)
    print('EVIDENCE_DIR', out)
    print('RECEIPT_SHA256', sha(encoded))
    print(encoded.decode(), end='')
    print('STDOUT-BEGIN')
    print((out / 'stdout.bin').read_text(errors='replace'), end='')
    print('STDOUT-END')
    print('STDERR-BEGIN')
    print((out / 'stderr.bin').read_text(errors='replace'), end='')
    print('STDERR-END')
raise SystemExit(0 if receipt['passed'] else 1)
PY
```

## Actual evidence and final disposition

The first and only authorized import-only invocation passed. Lean and the
complete Bash entry both exited 0. All three expanded universal types checked,
and all three full axiom lists are exactly `propext`, `Classical.choice`,
`Quot.sound`. Both predeclarations matched; all 39 guards passed before and
after. There was no stderr, timeout, cap hit, runtime error, retry, source build
or resource change.

The inner invocation took 1.825049912004033 seconds wall time, 1.22629 seconds
child user time and 0.569711 seconds child system time. Recorded maximum child
RSS was 3,288,720 KiB. Lean stdout is 326 bytes, SHA-256
`5e788042c0723b83341d6706cc6aa5c40aeb89e132fbba8a3faae19c12fe8497`.
The full inner receipt SHA-256 is
`50bb95d02b83dddfea91ad18d61620b75aa11591b41e97717e9748c508107c7e`.

The Bash entry was itself launched by a file-captured outer Python wrapper with
the same AS/CPU/regular-stream caps and a 65-second outer wall bound, allowing
five seconds to write the receipt after the inner 60-second Lean limit. This
does not extend Lean's limit. The actual outer wall time was 1.8682905639871024
seconds, exit 0. Its complete stdout is 7,271 bytes, SHA-256
`940baba4dea60b1adb11920259fb0ee7f6566029613b59d0d52dde7dde2f72b9`.
Both inner and outer stderr are zero bytes, each with SHA-256
`e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

The pre-run report snapshot is 29,228 bytes, SHA-256
`903eecc1ccbc5e4c1146ec3a748cfccf87c0510ca8552e61dae45dca3665de89`.
The two temporary directories retain exact stdin, launcher, report snapshot,
receipts and original regular streams. This report also embeds both complete
receipts and every stdout/stderr byte, so the actual result is reviewable
without relying on temporary-directory persistence. No diagnostic is omitted.

Full outer receipt, SHA-256
`4fdf0a3a3aa079c140484e2ee359b576e66e51436ea2e9116afb245a66373c8d`:

```json
{
  "address_space_bytes": 8589934592,
  "argv": [
    "bash",
    "/tmp/astra-boundary-assembly-entry-oe3779ta/entry.sh"
  ],
  "cpu_seconds": [
    59,
    60
  ],
  "error": null,
  "exit": 0,
  "files": {
    "entry.sh": {
      "bytes": 11232,
      "sha256": "0be6e48f6675db21c21d5987760f8448657a285a4851f4577ca6aee5cfacc228"
    },
    "stderr.bin": {
      "bytes": 0,
      "sha256": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
    },
    "stdout.bin": {
      "bytes": 7271,
      "sha256": "940baba4dea60b1adb11920259fb0ee7f6566029613b59d0d52dde7dde2f72b9"
    }
  },
  "outer_wall_limit_note": "60-second inner Lean limit plus 5-second receipt-writing grace",
  "outer_wall_limit_seconds": 65,
  "passed": true,
  "stream_bytes": 131072,
  "stream_cap_hit": false,
  "timed_out": false,
  "wall_seconds": 1.8682905639871024
}
```

Complete original Bash stdout, including the full inner receipt and the entire
Lean stdout/stderr between explicit markers:

```text
EVIDENCE_DIR /tmp/astra-boundary-assembly-review-5pfdpzdq
RECEIPT_SHA256 50bb95d02b83dddfea91ad18d61620b75aa11591b41e97717e9748c508107c7e
{
  "argv": [
    "lake",
    "env",
    "lean",
    "-j1",
    "-s65536",
    "--stdin"
  ],
  "axiom_output_valid": true,
  "axioms": {
    "LonelyRunner.both_six_even_anchor_three_time_witness": [
      "propext",
      "Classical.choice",
      "Quot.sound"
    ],
    "LonelyRunner.exists_two_odd_outside_three": [
      "propext",
      "Classical.choice",
      "Quot.sound"
    ],
    "LonelyRunner.two_divisible_boundary_min_eq_zero": [
      "propext",
      "Classical.choice",
      "Quot.sound"
    ]
  },
  "child_max_rss_kib": 3288720,
  "child_system_seconds": 0.569711,
  "child_user_seconds": 1.22629,
  "environment": {
    "LEAN_NUM_THREADS": "1",
    "LEAN_STACK_SIZE_KB": "65536"
  },
  "error": null,
  "exit": 0,
  "files": {
    "launcher.sh": {
      "bytes": 11232,
      "sha256": "0be6e48f6675db21c21d5987760f8448657a285a4851f4577ca6aee5cfacc228"
    },
    "report-snapshot.md": {
      "bytes": 29228,
      "sha256": "903eecc1ccbc5e4c1146ec3a748cfccf87c0510ca8552e61dae45dca3665de89"
    },
    "stderr.bin": {
      "bytes": 0,
      "sha256": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
    },
    "stdin.bin": {
      "bytes": 2056,
      "sha256": "f0c4ac8940b1b70e3e613bc7e95008541c53b6e2c071ecfbbd917d96d5be1d63"
    },
    "stdout.bin": {
      "bytes": 326,
      "sha256": "5e788042c0723b83341d6706cc6aa5c40aeb89e132fbba8a3faae19c12fe8497"
    }
  },
  "guards": {
    ".lake/build/lib/lean/LonelyRunner/AnchoredPairMaximizer.olean": "0e567db35d8ae412e8688f6bfacf1e2d70a30cad24fd3a3bca34575b4b101d00",
    ".lake/build/lib/lean/LonelyRunner/AnchoredPairSafeBands.olean": "1457a21fc39aa4ad489891c9b19cb8be2a74bfc9164fbccb5574c7a61b451a86",
    ".lake/build/lib/lean/LonelyRunner/AnchoredPairTransport.olean": "5254122c6d4ab3e583adf5676fe05aa7268dfa3412e2aee7889fbacc3832a07e",
    ".lake/build/lib/lean/LonelyRunner/EvenAnchorThreeTimes.olean": "1091b721112207b70cca7316b32e607e15aee98b5813f66af13f280aeb55d18b",
    ".lake/build/lib/lean/LonelyRunner/FoldedCirclePhase.olean": "3032bbcf8e5c414daea831a7a415a40b4f254e5b72428b6fa078742e891afc06",
    ".lake/build/lib/lean/LonelyRunner/FoldedPairSafeBands.olean": "d000b970290ec9072f02465f527b817f32bb72113ed7fa09bd43c9f0a47287c8",
    ".lake/build/lib/lean/LonelyRunner/OddHalfTimeShift.olean": "728fdb322e3fe2f10c3c693bc17dd460b302cca2ee42a7bd835ca1a6231e572c",
    ".lake/build/lib/lean/LonelyRunner/PairSafeSixthAffine.olean": "2c62c951e8945d12a7945d2c41bfc9213f008d43dfc8482e5d238e9f0954a745",
    ".lake/build/lib/lean/LonelyRunner/RationalShiftOrbits.olean": "8194c5c6ac0b8495146728fcac70a6a1e9d317f9e7689c4759f22ed33c14340f",
    ".lake/build/lib/lean/LonelyRunner/SpecialSixthPhase.olean": "2e4951ab757b0fa22574e72381abd7be6cca5c971f9e38967cf24f0991532537",
    ".lake/build/lib/lean/LonelyRunner/ThirdShiftRescues.olean": "f43015c4f1d03a823ae6987b979d1ea09a5d972e2ee8c7cc953c149d666d2e94",
    ".lake/build/lib/lean/LonelyRunner/ThirdShiftSpecialSeed.olean": "f0c65f1e1d6e4f2982a645bdbc116d690f2508223de02e31ac4e479445536f58",
    ".lake/build/lib/lean/LonelyRunner/TwoDivisibleBoundary.olean": "affcd1c846fe099c66b978e2873fd0261ea324b872b46a3d4a4c86d9c182395d",
    ".lake/build/lib/lean/LonelyRunner/TwoDivisibleSmallPair.olean": "84c69092542b315e611aad9498aa57dc5e56e442b10b2a37d6c4836f8ce24af9",
    ".lake/build/lib/lean/LonelyRunner/TwoOddOutsideThree.olean": "2c7c09847be7e443da28e4439c21e2966d20777a5cb60d9cf7ea908c9b1eb255",
    ".lake/build/lib/lean/LonelyRunner/TwoPhaseHalfChoices.olean": "13bc283e5024b6af7d999c107a03ccca7ddf387ddb0c522cefd058a422b13517",
    ".lake/packages/mathlib/.lake/build/lib/lean/Mathlib/Tactic.olean": "0534ef12e7aaf8ffbb6e520a91f922da4469d0dca2b54c87b4458e1faa28a6a2",
    ".lake/packages/mathlib/Mathlib/Tactic.lean": "c6f2c548596b635a3d5c8aff8b19cbdeb60dd54e41bb89a1cd03b1a54d335fa5",
    "/home/joshua/.elan/toolchains/leanprover--lean4---v4.32.1/bin/lake": "60330ab6f07dce20f3fa9ebb08e8b984ea9549eac172afeb15d9d2227060e2b3",
    "/home/joshua/.elan/toolchains/leanprover--lean4---v4.32.1/bin/lean": "e8baaa71855a616dc351028f3ad2200051b0671f423a1696a100e809302d5550",
    "LonelyRunner/AnchoredPairMaximizer.lean": "050888f1d9017183661dbca6e2e61bfeb518849c339bc77b43605a6b3918bdd8",
    "LonelyRunner/AnchoredPairSafeBands.lean": "14212e32cdd3a343b286dd0fc370cefa6c33c145541f61afdf42e8e5290bc306",
    "LonelyRunner/AnchoredPairTransport.lean": "63414c3ccb6c12c1ed8775cb7e18dccc84c30da42cd4be089ac336df75ceca43",
    "LonelyRunner/EvenAnchorThreeTimes.lean": "5fbaaa745630ff16ae02249f1a52032b7f63f7453d1c853fbffba0a88182e2f7",
    "LonelyRunner/FoldedCirclePhase.lean": "957606878108847d5ceff47be621ff0fc9c0a0d976568b5f5ef3dbb6db10481e",
    "LonelyRunner/FoldedPairSafeBands.lean": "00903bcb0c131fdb31ab87d55cea809249dfacbbd5861f82ab3a987d39b74b5f",
    "LonelyRunner/OddHalfTimeShift.lean": "ea274daeadc4bf2242399663cd5da914b1c096f62b58cb43fdffa2e625af6b5c",
    "LonelyRunner/PairSafeSixthAffine.lean": "290b5844fd7e3a11baf1c51d724a904362a41d76e31c3e78c45c7818b9763737",
    "LonelyRunner/RationalShiftOrbits.lean": "cf615dd6c6b3cf091cd5d31ac641f4f994c1c50d95e0120c311d3ac129b88591",
    "LonelyRunner/SpecialSixthPhase.lean": "677372ee3dc86520051f4bcc037f685a3f5fd8748c737ef9e1d2bfc5ac0072d8",
    "LonelyRunner/ThirdShiftRescues.lean": "829db12405e64ad88da5501ddb167d650ad82cf92295a88fd2374d9e08281732",
    "LonelyRunner/ThirdShiftSpecialSeed.lean": "ffbab991e23c45a1cd0abb2f692c30f35665f04ae5843a70898da00c69ab6187",
    "LonelyRunner/TwoDivisibleBoundary.lean": "5a3dc7ca4c0d777ba38d47e2f2b86a1036f9d6080f03f473ad87f6d31c1ca66c",
    "LonelyRunner/TwoDivisibleSmallPair.lean": "ff40734821aae9abff43fdfc17c4275f4b5d045b4757b254dc11d24e695e8821",
    "LonelyRunner/TwoOddOutsideThree.lean": "6b2c9fb02bffe58cdd2383246c56dfca3f91fe3b88c1a2902486b4d90cae6735",
    "LonelyRunner/TwoPhaseHalfChoices.lean": "cb5c23225a130c8613c1897a749eaa7834c14b3de504ae8b51f1744c53624acc",
    "lake-manifest.json": "887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218",
    "lakefile.toml": "bdcbaaa18d518409619215e8acf7892452c1fa5c6e80ba742ce67f7380682a26",
    "lean-toolchain": "8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af"
  },
  "guards_after": true,
  "guards_before": true,
  "limits": {
    "address_space_bytes": 8589934592,
    "cpu_seconds": [
      59,
      60
    ],
    "stream_bytes": 131072,
    "wall_seconds": 60
  },
  "passed": true,
  "predeclarations_match": true,
  "resolved_executables": {
    "lake": "/home/joshua/.elan/toolchains/leanprover--lean4---v4.32.1/bin/lake",
    "lean": "/home/joshua/.elan/toolchains/leanprover--lean4---v4.32.1/bin/lean"
  },
  "stream_cap_hit": false,
  "timed_out": false,
  "wall_seconds": 1.825049912004033
}
STDOUT-BEGIN
'LonelyRunner.exists_two_odd_outside_three' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.both_six_even_anchor_three_time_witness' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.two_divisible_boundary_min_eq_zero' depends on axioms: [propext, Classical.choice, Quot.sound]
STDOUT-END
STDERR-BEGIN
STDERR-END
```

Complete outer stderr (zero bytes):

```text
```

Final disposition: accept all three exact implemented contracts. No source
correction is requested. The boundary statement is conditional on its explicit
all-real nonexistence, exact divisible-label classification, six-divisibility
and even-count hypotheses. This review does not claim those premises for an
arbitrary family, an unconditional five-moving 1/6 theorem, or unrestricted LRC.
