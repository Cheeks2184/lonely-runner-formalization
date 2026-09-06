# Independent source review: first one-three-divisible helpers

Semantic decision: **accept all five exact public contracts** in the four frozen
sources below. The complete proofs preserve strict dilation, weak third-shift
rescue and the global oriented complement maximum. Execution is a separate
claim, recorded only in the final evidence section. These helpers support the
remaining canonical N=6 work; they do not finish that branch or unrestricted LRC.

I independently reviewed the underlying manuscript by another Astra but authored
none of these Lean sources. Root assembled `ThreeWeakExceptions`; the other
three modules were Terra drafts, with root's cast normalization correction to
`BadSixthDilate`. This source review owns only this report. Other sources,
reports, state, Git, imports and caches are preserved. No source build, numerical
fixture, mathematical search or enumeration is part of this task.

The project config, complete workflow and policy, and focused state were read.
State records research/in_progress, checkpoint `84d14b3`, this review task and
requested Astra/xhigh; observed model/effort are not exposed. The validator
actually exited 0 with `workflow structural validation passed; it cannot certify
mathematical validity.` The standing priority remains verified canonical N=6,
then a uniform arbitrary-N mechanism, without successive-count milestones.

## Inputs and exact scope

| Frozen source | SHA-256 | Public declaration(s) |
| --- | --- | --- |
| `LonelyRunner/BadSixthDilate.lean` | `5031f198c72e9b248962d7c91c263a7d4b1f6d5d4c55a01fd927ab769d8e3b96` | `exists_bad_sixth_dilate` |
| `LonelyRunner/NonzeroThirdShift.lean` | `fc8bdba703053b9e13b07b273ed9110345a51815422352e7e42d0a5552e13611` | `third_shift_safe_of_weak_bad`, `exists_nonzero_third_shift_safe` |
| `LonelyRunner/OneSixthComplementMaximizer.lean` | `5a7011ca680b8a2b26c7bad466a8ee4008cf47507eb8b700846f296894bb90a1` | `exists_one_sixth_complement_maximizer` |
| `LonelyRunner/ThreeWeakExceptions.lean` | `bdb75b5254a4a8bacb01f29ebdef34b40aa966c96de2b69285290ec03bb43d33` | `third_shift_of_three_weak_exceptions` |

The accepted manuscript is `research/astra-one-three-divisible-plan.md`, SHA
`9da230600af3a0a0bc8223de3daca2575f8d41f447142687ca64db53ced4ae9e`;
its frozen independent review is `research/astra-one-three-divisible-review.md`,
SHA `8f720fbd8002918adaaa0d36fc7774c450eeb5dba84dd555552d24b5e57e6078`.
The public dilation, maximum and three-weak-label contracts preserve the exact
manuscript scopes. The two nonzero-third-shift declarations are separately
proved elementary dependencies of the reviewed three-label argument.

The five universal assignments in the probe below expose every quantifier and
hypothesis. `ComplementSafe` is expanded in both occurrences in the maximum
assignment, so the probe checks the actual inequalities and all-real maximum.
No private abbreviation, weaker threshold, existence of a seed, speed ordering,
primitivity, or injectivity is hidden by these assignments.

## Complete proof review

Write N(x)=circleNorm(x) and δ=1/6. All interval calculations in this discussion
are source reasoning, not executed numerical controls.

**Dilation (`BadSixthDilate.lean:21`).** The private integer-band helper removes
q+1 from a phase y in (q+5/6,q+7/6). Its residual lies strictly between -1/6
and 1/6, hence within the closed half interval required by the absolute-value
circle-norm identity. It works for every integer q, including negative q;
`push_cast` exposes the integer sum in both the norm and half-bound goals.

The public proof sets u=N(x), obtains 0≤u≤1/2 from the exact distance to round(x),
and specializes `circleNorm_nat_mul_add_int_half x a 0` to N(a*x)=N(a*u).
That checked lift accounts for arbitrary signed real x and either orientation.
The ordered partition is exhaustive and sends every equality to the next row:

| Actual interval for u | a | Open band for a*u |
| --- | --- | --- |
| (1/6,7/30) | 5 | (5/6,7/6) |
| [7/30,7/24) | 4 | (5/6,7/6) |
| [7/24,7/18) | 3 | (5/6,7/6) |
| [7/18,13/30) | 5 | (11/6,13/6) |
| [13/30,1/2] | 2 | (5/6,7/6) |

The lower bounds in the last four rows are respectively 14/15, 7/8, 35/18
and 13/15, strictly above the applicable band endpoints. The last upper bound
is 1<7/6, so u=1/2 is included. All produced norms are strictly below δ.
The hypothesis is strictly above δ; replacing it by a weak bound would be
invalid, as the symbolic phase x=1/6 has no strictly bad dilation in 2..5.
The theorem bounds a as a natural number and assumes no preferred phase lift.

**Both nonzero third-shift results (`NonzeroThirdShift.lean:9,20`).** For 3∤d,
`circleNorm_third_shift_sub_ge` separates distinct Fin 3 shifts by at least 1/3.
Its read proof orders the natural indices before subtracting, proves the positive
index difference is below 3, applies prime-three nondivisibility to its product
with d, and then reflects for the other order. Thus no natural-subtraction
underflow or phase-sign condition enters the caller.

The weak-bad theorem compares k≠0 with zero. The subtraction triangle inequality
gives 1/3≤N(new)+N(x); N(x)≤1/6 therefore gives N(new)≥1/6. Equality is safe.
The existence theorem tries k=1 and then k=2; if both closed bounds fail, both
norms are strictly below 1/6, contrary to their 1/3 separation and the same
triangle inequality. The branch choices are actual nonzero Fin 3 elements.
Both results accept arbitrary real x and natural d with only 3∤d. This latter
hypothesis already excludes d=0; no explicit positivity or gcd assumption is
needed or inserted. These are phase statements, not positive-time statements.

**Maximum wrapper (`OneSixthComplementMaximizer.lean:6`).** The source defines
old(j)=v(p.succAbove(j)) on Fin 4, carrying positivity directly. The checked
`fourMovingNaturalRunners` supplies one time s with all four norms at least 1/5.
For every j≠p, `Fin.exists_succAbove_eq` gives an actual preimage under the same
p.succAbove, so 1/6<1/5≤N(s*v(j)) supplies a simultaneous *strict* complement
seed. The source does not infer a strict seed from a merely closed-sixth witness.
The seed theorem allows repeated speeds, and reindexing removes only the pivot
label, not all occurrences of its value. Its extra positive-s fact is harmless
and is not needed by the generic maximum API.

The read `exists_oriented_complement_maximizer` has exactly the all-real
nonexistence premise used here. Its proof takes the maximum on [0,1] intersected
with the closed complement-safe set. Integer-speed periodicity maps every real
time through fract(t), making the maximum global. A strict seed permits a
positive objective even if its pivot phase initially is an integer, by finite
positive forward slack. Positive objective excludes the two time endpoints.
Nonexistence gives objective<δ; reflection t↦1-t, when required, preserves all
norms and orients the pivot fractional part to that positive norm. If every
other phase were strictly below 1-δ, the same finite forward-slack argument
would increase the pivot while preserving all closed complement bounds. The
contradiction produces an actual other label at the upper face, not just a
supremum or a disjunction of lower and upper faces.

The new wrapper applies that theorem with δ=1/6, its exact strict seed and hno,
and rewrites 1-1/6 as 5/6. The result includes 0<τ<1, complement safety at τ,
comparison against *every real complement-safe t*, pivot fractional part equal
to its norm in (0,1/6), and one r≠p with fractional part exactly 5/6. There is
no three-divisibility, gcd-one, speed-distinctness or additional seed premise.
This is conditional on all-real hno; it does not by itself construct a full
five-moving witness or contradict hno.

**Three weak exceptions (`ThreeWeakExceptions.lean:10`).** E is exactly the four
nonpivot labels; B consists of their weakly bad norms N≤δ. B⊆E and |B|≥3 imply
C=E\B has at most one label. The cardinality subtraction is justified by B⊆E;
no assertion of |B|=3 or exactly one leftover is made. When C is empty the proof
chooses k=1; otherwise it picks q∈C, uses `exists_nonzero_third_shift_safe` once
for q, and `Finset.card_le_one` identifies every i∈C with q. This places the
single choice of k before the final universal label quantifier.

For the pivot, the read `circleNorm_time_add_nat_div_of_dvd 3 (v p) k.val`
removes its integral shift using 3∣v(p). For each other label, real distributivity
identifies the shifted-time phase with its base phase plus k*v(i)/3. Membership
in B invokes the weak-bad theorem at that same nonzero k; nonmembership puts
it in C and invokes the already chosen common bound. Thus the same time works
for all five labels, including the case of four weak exceptions and all closed
ties. Repeated speed values are allowed; the argument counts labels only.

No positivity, primitivity, ordering or nonexistence premise is assumed. The
pivot may be natural zero in the formal domain, although hp is then impossible;
this is not an omitted hypothesis. Every nonpivot speed is nonzero because
3∤v(i). The theorem accepts negative t and concludes a real shifted time, without
claiming it is positive. Internally k is nonzero, while the public conclusion
retains the manuscript's weaker existential Fin 3 form exactly.

The immediate dependencies and their source/olean hashes appear literally in
the launcher guards. In addition to all four target sources, the complete
FoldedCirclePhase, ThirdShiftSpacing, SeparatedPhaseFamily, ConstrainedMaximizer
proofs and the invoked FiveRunnerOrdinary and RationalShiftOrbits interfaces and
proofs were read. No new source-level circular dependency or trust shortcut was
found. The probe checks the compiled declarations' exact types and axiom closure;
it does not pretend to rebuild these source files.

## Earlier source-build evidence

Root's pass54 verification JSON was read at snapshot SHA
`f162b2c2e3560e4102d7d199263c42d20b2dcf0eaaba7ab2f29845df81e3032e`.
It retains the initial BadSixthDilate draft SHA
`367022aa2eead70f5394fefe4a3825913ecd86232aed617ef723c481150e79b0`
and exit-1 log: linarith could not normalize the real cast of q+1 in four
private-helper goals. The corrected source adds the cast normalization and
compiled successfully, 3001 jobs. NonzeroThirdShift (3004), the maximum wrapper
(3525), and ThreeWeakExceptions (3007) have recorded exit 0. The maximum build
replays pre-existing warnings/informational output from dependencies; these are
not new target proof failures. The worker's earlier no-source return for the
three-exception assembly and root's recovery are preserved in that same record.
These are root's build receipts, distinct from the one independent probe below.
The mutable integration receipt itself and mutable root/AxiomAudit sources are
not replay guards; their concurrent update cannot silently alter a guarded API.

## Fixed probe predeclaration and sole replay entry

The scope is exactly five universal assignments plus five full axiom prints,
with the four direct imports. There are no evaluated mathematical fixtures,
searches, source proof recompilations, extra formatting options or retries.
`ComplementSafe` is expanded in the assignment, as defined in the reviewed API.
The only Lean command is `lake env lean -j1 -s65536 --stdin`; the explicitly
single-thread environment and 65536-KiB stack are preserved. The controller uses
AS 8 GiB, CPU soft/hard 59/60 seconds, wall 60 seconds and regular-file stdout
and stderr limits of 128 KiB each; it disables core dumps and kills the process
group on timeout. Any error, nonzero exit, cap hit, unexpected output, missing
axiom report, forbidden axiom or changed guard makes the run fail. Failure is
retained verbatim, with no automatic retry or resource escalation.

All four source/olean pairs, their six other immediate project import pairs,
Mathlib.Tactic source/olean, toolchain/manifest/lakefile pins, the two actual
pinned runtime binaries and both manuscript inputs are checked before and after.
The pinned manifest selects mathlib `520045ab14e26149ee970e2e617ca04b09bde5d6`.
The complete current report is snapshotted, and its immutable pre-evidence
prefix is hashed before and after. The full report must be unchanged during
execution. Later appending actual evidence below the marker changes the full
snapshot for root's replay but preserves the proof/probe/launcher prefix.
The parser permits only the five expected complete axiom reports in order and
axioms among propext, Classical.choice, Quot.sound, with empty stderr.

Probe bytes: 2292

Probe SHA-256: `1dfd73c9ce6cf77ee5f29d651c1475c459e85f99e25805aac9ca14c36648dd31`

Launcher bytes: 10517

Launcher SHA-256: `509d22b98a8d9680ffd5c31340fe8478444c772cfa33713a91a67d96c0f90a19`

```lean
import LonelyRunner.BadSixthDilate
import LonelyRunner.NonzeroThirdShift
import LonelyRunner.OneSixthComplementMaximizer
import LonelyRunner.ThreeWeakExceptions

open LonelyRunner

example : ∀ x : ℝ, (1 : ℝ) / 6 < circleNorm x →
    ∃ a : ℕ, 2 ≤ a ∧ a ≤ 5 ∧ circleNorm ((a : ℝ) * x) < (1 : ℝ) / 6 :=
  LonelyRunner.exists_bad_sixth_dilate

example : ∀ (x : ℝ) (d : ℕ), ¬ 3 ∣ d →
    circleNorm x ≤ (1 : ℝ) / 6 → ∀ k : Fin 3, k ≠ 0 →
      (1 : ℝ) / 6 ≤ circleNorm (x + (k.val : ℝ) * (d : ℝ) / 3) :=
  LonelyRunner.third_shift_safe_of_weak_bad

example : ∀ (x : ℝ) (d : ℕ), ¬ 3 ∣ d →
    ∃ k : Fin 3, k ≠ 0 ∧
      (1 : ℝ) / 6 ≤ circleNorm (x + (k.val : ℝ) * (d : ℝ) / 3) :=
  LonelyRunner.exists_nonzero_third_shift_safe

example : ∀ v : Fin 5 → ℕ, (∀ i, 0 < v i) → ∀ p : Fin 5,
    (¬ ∃ t : ℝ, ∀ i, (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ))) →
    ∃ τ : ℝ, 0 < τ ∧ τ < 1 ∧
      (∀ j, j ≠ p → (1 : ℝ) / 6 ≤ circleNorm (τ * (v j : ℝ))) ∧
      (∀ t : ℝ, (∀ j, j ≠ p → (1 : ℝ) / 6 ≤ circleNorm (t * (v j : ℝ))) →
        circleNorm (t * (v p : ℝ)) ≤ circleNorm (τ * (v p : ℝ))) ∧
      0 < Int.fract (τ * (v p : ℝ)) ∧
      Int.fract (τ * (v p : ℝ)) < (1 : ℝ) / 6 ∧
      Int.fract (τ * (v p : ℝ)) = circleNorm (τ * (v p : ℝ)) ∧
      ∃ r, r ≠ p ∧ Int.fract (τ * (v r : ℝ)) = (5 : ℝ) / 6 :=
  LonelyRunner.exists_one_sixth_complement_maximizer

example : ∀ (v : Fin 5 → ℕ) (p : Fin 5), 3 ∣ v p →
    (∀ i, i ≠ p → ¬ 3 ∣ v i) → ∀ t : ℝ,
    (1 : ℝ) / 6 ≤ circleNorm (t * (v p : ℝ)) →
    3 ≤ ((Finset.univ : Finset (Fin 5)).filter
      (fun i => i ≠ p ∧ circleNorm (t * (v i : ℝ)) ≤ (1 : ℝ) / 6)).card →
    ∃ k : Fin 3, ∀ i, (1 : ℝ) / 6 ≤ circleNorm
      ((t + (k.val : ℝ) / 3) * (v i : ℝ)) :=
  LonelyRunner.third_shift_of_three_weak_exceptions

#print axioms LonelyRunner.exists_bad_sixth_dilate
#print axioms LonelyRunner.third_shift_safe_of_weak_bad
#print axioms LonelyRunner.exists_nonzero_third_shift_safe
#print axioms LonelyRunner.exists_one_sixth_complement_maximizer
#print axioms LonelyRunner.third_shift_of_three_weak_exceptions
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
report = root / 'research/astra-one-three-first-helpers-source-review.md'
text = report.read_text()
marker = '\n<!-- ACTUAL EVIDENCE -->\n'
assert text.count(marker) == 1
prefix = text.split(marker, 1)[0].encode()
fence = chr(96) * 3
probe = text.split(fence + 'lean\n', 1)[1].split(fence, 1)[0].encode()
launcher = text.split(fence + 'bash\n', 1)[1].split(fence, 1)[0].encode()
out = Path(tempfile.mkdtemp(prefix='astra-one-three-first-helpers-review-'))
(out / 'stdin.bin').write_bytes(probe)
(out / 'launcher.sh').write_bytes(launcher)
(out / 'report-snapshot.md').write_bytes(text.encode())
guards = {'LonelyRunner/BadSixthDilate.lean': '5031f198c72e9b248962d7c91c263a7d4b1f6d5d4c55a01fd927ab769d8e3b96', '.lake/build/lib/lean/LonelyRunner/BadSixthDilate.olean': 'fd5cf9737372abf708047befaa7bde190d2307d37bb6d4bca40782402758e499', 'LonelyRunner/NonzeroThirdShift.lean': 'fc8bdba703053b9e13b07b273ed9110345a51815422352e7e42d0a5552e13611', '.lake/build/lib/lean/LonelyRunner/NonzeroThirdShift.olean': 'fe70d8a9609b15e9a3a1b12357025a6632a2f8316a957365b42ee8ec0f1ffd18', 'LonelyRunner/OneSixthComplementMaximizer.lean': '5a7011ca680b8a2b26c7bad466a8ee4008cf47507eb8b700846f296894bb90a1', '.lake/build/lib/lean/LonelyRunner/OneSixthComplementMaximizer.olean': '478c4c4899a0b4b0154c6be49ac35daf4d292706c79552adf9b990e3ae92d293', 'LonelyRunner/ThreeWeakExceptions.lean': 'bdb75b5254a4a8bacb01f29ebdef34b40aa966c96de2b69285290ec03bb43d33', '.lake/build/lib/lean/LonelyRunner/ThreeWeakExceptions.olean': '43d48c41f7559a4dbbbfccdd782324cbc8311891702787403e4f292cefbf3117', 'LonelyRunner/FoldedCirclePhase.lean': '957606878108847d5ceff47be621ff0fc9c0a0d976568b5f5ef3dbb6db10481e', '.lake/build/lib/lean/LonelyRunner/FoldedCirclePhase.olean': '3032bbcf8e5c414daea831a7a415a40b4f254e5b72428b6fa078742e891afc06', 'LonelyRunner/ThirdShiftSpacing.lean': '146cdfd80495aced0eb93bc322559cf7e950a80b0d01534b2a57cce7129debaa', '.lake/build/lib/lean/LonelyRunner/ThirdShiftSpacing.olean': '7bc4793433826271b91dd77e0eb635951c899f55acf5962b94ed3802a2b8c885', 'LonelyRunner/SeparatedPhaseFamily.lean': '28c5db2425eef754156e57c284959ff02da743f1fde424e053c4eae0c721b6bd', '.lake/build/lib/lean/LonelyRunner/SeparatedPhaseFamily.olean': 'eff265763238a85323240590e528ff8514eef2f4bdb405f0742e0f0a67f6ba41', 'LonelyRunner/ConstrainedMaximizer.lean': '2ef07e6b83b8675a22184571c31d2a71dab9d5c072e3cd165cb8382957b46e92', '.lake/build/lib/lean/LonelyRunner/ConstrainedMaximizer.olean': '443a61889184bd7fc7ea52a85ebcfa3fc0ba6f1e458b34824afb166812f38170', 'LonelyRunner/FiveRunnerOrdinary.lean': '662d0116f13971bce85e76c503e2f3be4fdc6291ba8113aeda43957e38354ffe', '.lake/build/lib/lean/LonelyRunner/FiveRunnerOrdinary.olean': '408abf21f2b4e3c356ae528f92762826556887d7e5068283399a79d6ca72ef31', 'LonelyRunner/RationalShiftOrbits.lean': 'cf615dd6c6b3cf091cd5d31ac641f4f994c1c50d95e0120c311d3ac129b88591', '.lake/build/lib/lean/LonelyRunner/RationalShiftOrbits.olean': '8194c5c6ac0b8495146728fcac70a6a1e9d317f9e7689c4759f22ed33c14340f', '.lake/packages/mathlib/Mathlib/Tactic.lean': 'c6f2c548596b635a3d5c8aff8b19cbdeb60dd54e41bb89a1cd03b1a54d335fa5', '.lake/packages/mathlib/.lake/build/lib/lean/Mathlib/Tactic.olean': '0534ef12e7aaf8ffbb6e520a91f922da4469d0dca2b54c87b4458e1faa28a6a2', 'lean-toolchain': '8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af', 'lakefile.toml': 'bdcbaaa18d518409619215e8acf7892452c1fa5c6e80ba742ce67f7380682a26', 'lake-manifest.json': '887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218', '/home/joshua/.elan/toolchains/leanprover--lean4---v4.32.1/bin/lean': 'e8baaa71855a616dc351028f3ad2200051b0671f423a1696a100e809302d5550', '/home/joshua/.elan/toolchains/leanprover--lean4---v4.32.1/bin/lake': '60330ab6f07dce20f3fa9ebb08e8b984ea9549eac172afeb15d9d2227060e2b3', 'research/astra-one-three-divisible-plan.md': '9da230600af3a0a0bc8223de3daca2575f8d41f447142687ca64db53ced4ae9e', 'research/astra-one-three-divisible-review.md': '8f720fbd8002918adaaa0d36fc7774c450eeb5dba84dd555552d24b5e57e6078'}
argv = ['lake', 'env', 'lean', '-j1', '-s65536', '--stdin']
limits = {'address_space_bytes': 8 * 1024**3, 'cpu_seconds': [59, 60],
          'wall_seconds': 60, 'stream_bytes': 128 * 1024}
symbols = ['LonelyRunner.exists_bad_sixth_dilate', 'LonelyRunner.third_shift_safe_of_weak_bad', 'LonelyRunner.exists_nonzero_third_shift_safe', 'LonelyRunner.exists_one_sixth_complement_maximizer', 'LonelyRunner.third_shift_of_three_weak_exceptions']
allowed = {'propext', 'Classical.choice', 'Quot.sound'}
receipt = {'argv': argv, 'limits': limits, 'guards': guards,
           'environment': {'LEAN_NUM_THREADS': '1', 'LEAN_STACK_SIZE_KB': '65536'},
           'exit': None, 'timed_out': False, 'error': None,
           'guards_before': False, 'guards_after': False,
           'predeclarations_match': False, 'axioms': None,
           'report_prefix_before_sha256': hashlib.sha256(prefix).hexdigest(),
           'report_unchanged_during_run': False,
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
    text_after = report.read_text()
    receipt['report_prefix_after_sha256'] = sha(text_after.split(marker, 1)[0].encode())
    receipt['report_unchanged_during_run'] = text_after == text
    assert receipt['report_unchanged_during_run'], 'report changed during run'
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
                         and receipt['report_unchanged_during_run']
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

<!-- ACTUAL EVIDENCE -->

## Actual evidence and disposition

The first and only authorized import-only invocation passed. Both Lean and the
exact fenced Bash exited 0. All five expanded universal assignments checked;
each full axiom list is exactly propext, Classical.choice, Quot.sound. There
were no warnings, errors, signals, retries, missing reports or cap hits in this
probe. All 29 guards matched before and after, and the report was unchanged
throughout execution. No source build or numerical test was run by this review.

The inner wall time was 1.9740277229866479 seconds, child CPU user/system time
1.335656/0.64225 seconds and peak child RSS 3,646,536 KiB. The raw Lean stdout
is 530 bytes, SHA `29ac5be3743281f89c2abe17bbae0a755d069009690e01b52348c2ac7c0aea74`;
stderr is empty, SHA
`e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.
The complete receipt is SHA
`0b4e8ea9068ea4634e1721e49b8c4d86c2624fe47a0a10be7ce3e8e8d00eb31b`.
Its original files remain in
`/tmp/astra-one-three-first-helpers-review-b_nmi362`.

The exact Bash entry's outer capture exited 0 after 2.018867246020818 seconds;
its full stdout is 6702 bytes with SHA
`6f862b92a3b700facae715d8ef98fd050d330917333c78fb5cbec556e822c793`
and empty stderr. The outer capture invokes the exact frozen Bash bytes through
`subprocess.Popen(['bash', '-c', program.decode()])`, with regular-file captures,
the same AS/CPU/file/core bounds and a 65-second outer watchdog surrounding the
inner 60-second limit. Its manifest is preserved in full below, SHA
`ef268bf766d2c9c45378eadba28f23341a9fbb3cdbc23f35b71886015e77213a`;
original files remain in `/tmp/astra-one-three-first-helpers-entry-ogayheh1`.
The outer capture is not an additional Lean invocation.

The full pre-run report was 25,714 bytes with SHA
`8e9fceaf49ef6a44e23f07afa01db686304377272524442c6bb08370ba2c4f85`.
The exact pre-evidence prefix has SHA
`beb05120f5308a8ed965e2c77bcdd1e13dc16b7d3de49d7239002a1bcbf52ca0`
before execution, after execution and after this evidence append. Probe and
Bash bytes remain the predeclared bytes. Root's replay may have a different
full report snapshot hash and temporary directory/timing, but must preserve
this prefix, all guards, exact stdin, output contracts and resource bounds.

Complete original outer receipt:

```json
{
  "exit": 0,
  "files": {
    "entry.sh": {
      "bytes": 10517,
      "sha256": "509d22b98a8d9680ffd5c31340fe8478444c772cfa33713a91a67d96c0f90a19"
    },
    "stderr.bin": {
      "bytes": 0,
      "sha256": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
    },
    "stdout.bin": {
      "bytes": 6702,
      "sha256": "6f862b92a3b700facae715d8ef98fd050d330917333c78fb5cbec556e822c793"
    }
  },
  "kind": "one exact fenced Bash invocation; outer capture only",
  "launcher_sha256": "509d22b98a8d9680ffd5c31340fe8478444c772cfa33713a91a67d96c0f90a19",
  "timed_out": false,
  "wall_seconds": 2.018867246020818
}
```

Complete original Bash stdout, including the full inner receipt and raw Lean
stdout/stderr with exact delimiters (no omissions):

```text
EVIDENCE_DIR /tmp/astra-one-three-first-helpers-review-b_nmi362
RECEIPT_SHA256 0b4e8ea9068ea4634e1721e49b8c4d86c2624fe47a0a10be7ce3e8e8d00eb31b
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
    "LonelyRunner.exists_bad_sixth_dilate": [
      "propext",
      "Classical.choice",
      "Quot.sound"
    ],
    "LonelyRunner.exists_nonzero_third_shift_safe": [
      "propext",
      "Classical.choice",
      "Quot.sound"
    ],
    "LonelyRunner.exists_one_sixth_complement_maximizer": [
      "propext",
      "Classical.choice",
      "Quot.sound"
    ],
    "LonelyRunner.third_shift_of_three_weak_exceptions": [
      "propext",
      "Classical.choice",
      "Quot.sound"
    ],
    "LonelyRunner.third_shift_safe_of_weak_bad": [
      "propext",
      "Classical.choice",
      "Quot.sound"
    ]
  },
  "child_max_rss_kib": 3646536,
  "child_system_seconds": 0.64225,
  "child_user_seconds": 1.335656,
  "environment": {
    "LEAN_NUM_THREADS": "1",
    "LEAN_STACK_SIZE_KB": "65536"
  },
  "error": null,
  "exit": 0,
  "files": {
    "launcher.sh": {
      "bytes": 10517,
      "sha256": "509d22b98a8d9680ffd5c31340fe8478444c772cfa33713a91a67d96c0f90a19"
    },
    "report-snapshot.md": {
      "bytes": 25714,
      "sha256": "8e9fceaf49ef6a44e23f07afa01db686304377272524442c6bb08370ba2c4f85"
    },
    "stderr.bin": {
      "bytes": 0,
      "sha256": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
    },
    "stdin.bin": {
      "bytes": 2292,
      "sha256": "1dfd73c9ce6cf77ee5f29d651c1475c459e85f99e25805aac9ca14c36648dd31"
    },
    "stdout.bin": {
      "bytes": 530,
      "sha256": "29ac5be3743281f89c2abe17bbae0a755d069009690e01b52348c2ac7c0aea74"
    }
  },
  "guards": {
    ".lake/build/lib/lean/LonelyRunner/BadSixthDilate.olean": "fd5cf9737372abf708047befaa7bde190d2307d37bb6d4bca40782402758e499",
    ".lake/build/lib/lean/LonelyRunner/ConstrainedMaximizer.olean": "443a61889184bd7fc7ea52a85ebcfa3fc0ba6f1e458b34824afb166812f38170",
    ".lake/build/lib/lean/LonelyRunner/FiveRunnerOrdinary.olean": "408abf21f2b4e3c356ae528f92762826556887d7e5068283399a79d6ca72ef31",
    ".lake/build/lib/lean/LonelyRunner/FoldedCirclePhase.olean": "3032bbcf8e5c414daea831a7a415a40b4f254e5b72428b6fa078742e891afc06",
    ".lake/build/lib/lean/LonelyRunner/NonzeroThirdShift.olean": "fe70d8a9609b15e9a3a1b12357025a6632a2f8316a957365b42ee8ec0f1ffd18",
    ".lake/build/lib/lean/LonelyRunner/OneSixthComplementMaximizer.olean": "478c4c4899a0b4b0154c6be49ac35daf4d292706c79552adf9b990e3ae92d293",
    ".lake/build/lib/lean/LonelyRunner/RationalShiftOrbits.olean": "8194c5c6ac0b8495146728fcac70a6a1e9d317f9e7689c4759f22ed33c14340f",
    ".lake/build/lib/lean/LonelyRunner/SeparatedPhaseFamily.olean": "eff265763238a85323240590e528ff8514eef2f4bdb405f0742e0f0a67f6ba41",
    ".lake/build/lib/lean/LonelyRunner/ThirdShiftSpacing.olean": "7bc4793433826271b91dd77e0eb635951c899f55acf5962b94ed3802a2b8c885",
    ".lake/build/lib/lean/LonelyRunner/ThreeWeakExceptions.olean": "43d48c41f7559a4dbbbfccdd782324cbc8311891702787403e4f292cefbf3117",
    ".lake/packages/mathlib/.lake/build/lib/lean/Mathlib/Tactic.olean": "0534ef12e7aaf8ffbb6e520a91f922da4469d0dca2b54c87b4458e1faa28a6a2",
    ".lake/packages/mathlib/Mathlib/Tactic.lean": "c6f2c548596b635a3d5c8aff8b19cbdeb60dd54e41bb89a1cd03b1a54d335fa5",
    "/home/joshua/.elan/toolchains/leanprover--lean4---v4.32.1/bin/lake": "60330ab6f07dce20f3fa9ebb08e8b984ea9549eac172afeb15d9d2227060e2b3",
    "/home/joshua/.elan/toolchains/leanprover--lean4---v4.32.1/bin/lean": "e8baaa71855a616dc351028f3ad2200051b0671f423a1696a100e809302d5550",
    "LonelyRunner/BadSixthDilate.lean": "5031f198c72e9b248962d7c91c263a7d4b1f6d5d4c55a01fd927ab769d8e3b96",
    "LonelyRunner/ConstrainedMaximizer.lean": "2ef07e6b83b8675a22184571c31d2a71dab9d5c072e3cd165cb8382957b46e92",
    "LonelyRunner/FiveRunnerOrdinary.lean": "662d0116f13971bce85e76c503e2f3be4fdc6291ba8113aeda43957e38354ffe",
    "LonelyRunner/FoldedCirclePhase.lean": "957606878108847d5ceff47be621ff0fc9c0a0d976568b5f5ef3dbb6db10481e",
    "LonelyRunner/NonzeroThirdShift.lean": "fc8bdba703053b9e13b07b273ed9110345a51815422352e7e42d0a5552e13611",
    "LonelyRunner/OneSixthComplementMaximizer.lean": "5a7011ca680b8a2b26c7bad466a8ee4008cf47507eb8b700846f296894bb90a1",
    "LonelyRunner/RationalShiftOrbits.lean": "cf615dd6c6b3cf091cd5d31ac641f4f994c1c50d95e0120c311d3ac129b88591",
    "LonelyRunner/SeparatedPhaseFamily.lean": "28c5db2425eef754156e57c284959ff02da743f1fde424e053c4eae0c721b6bd",
    "LonelyRunner/ThirdShiftSpacing.lean": "146cdfd80495aced0eb93bc322559cf7e950a80b0d01534b2a57cce7129debaa",
    "LonelyRunner/ThreeWeakExceptions.lean": "bdb75b5254a4a8bacb01f29ebdef34b40aa966c96de2b69285290ec03bb43d33",
    "lake-manifest.json": "887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218",
    "lakefile.toml": "bdcbaaa18d518409619215e8acf7892452c1fa5c6e80ba742ce67f7380682a26",
    "lean-toolchain": "8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af",
    "research/astra-one-three-divisible-plan.md": "9da230600af3a0a0bc8223de3daca2575f8d41f447142687ca64db53ced4ae9e",
    "research/astra-one-three-divisible-review.md": "8f720fbd8002918adaaa0d36fc7774c450eeb5dba84dd555552d24b5e57e6078"
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
  "report_prefix_after_sha256": "beb05120f5308a8ed965e2c77bcdd1e13dc16b7d3de49d7239002a1bcbf52ca0",
  "report_prefix_before_sha256": "beb05120f5308a8ed965e2c77bcdd1e13dc16b7d3de49d7239002a1bcbf52ca0",
  "report_unchanged_during_run": true,
  "resolved_executables": {
    "lake": "/home/joshua/.elan/toolchains/leanprover--lean4---v4.32.1/bin/lake",
    "lean": "/home/joshua/.elan/toolchains/leanprover--lean4---v4.32.1/bin/lean"
  },
  "stream_cap_hit": false,
  "timed_out": false,
  "wall_seconds": 1.9740277229866479
}
STDOUT-BEGIN
'LonelyRunner.exists_bad_sixth_dilate' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.third_shift_safe_of_weak_bad' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.exists_nonzero_third_shift_safe' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.exists_one_sixth_complement_maximizer' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.third_shift_of_three_weak_exceptions' depends on axioms: [propext, Classical.choice, Quot.sound]
STDOUT-END
STDERR-BEGIN
STDERR-END
```

Complete original Bash stderr is the empty byte string (0 bytes). The inner
stderr is likewise empty, as recorded by the complete receipt and delimiters.

Final disposition: **accept the five frozen source contracts and the successful
exact import/axiom probe**. Root's complete report read and inspection of the successful hash-bound receipt
remain the next checkpoint action; the user subsequently approved avoiding an
identical mechanical replay unless sources change, evidence is missing, or a
specific concern warrants it. These helpers are ready for that integration
process; they do not yet complete the one-three-divisible assembly,
canonical N=6, or unrestricted LRC. After verified canonical N=6, the standing
research transition is to a uniform arbitrary-N mechanism.

## Final workflow-validator observation

After appending the actual probe evidence, a separate final
`python3 scripts/validate_workflow.py` invocation returned exit 1, with the
complete output below. The startup invocation had returned exit 0. This final
observation concerns mutable shared routing configuration/state; none of those
files are owned or edited by this review, and they are deliberately outside the
frozen mathematical/probe guards. Root was notified. Its precise cause and
resolution belong to the concurrent orchestration audit. It is not a failure
of the completed import-only Lean probe and does not alter the source verdict.
No retry, state edit or routing change was performed by this reviewer.

```text
workflow validation error: policy.roles.routine must route to gpt-5.6-terra medium
workflow validation error: .codex/agents/implementer.toml must match policy routine routing
workflow validation error: active_tasks[2] routine routing must request gpt-5.6-terra medium
```

Root subsequently confirmed that the transient validator mismatch occurred
during the explicit user-approved migration of the routine Terra role to High,
with the worker-owned validator update in progress. The original failure above
is preserved rather than replaced by an invented later pass. The user also
approved avoiding duplicate mechanical checks: root will inspect this complete
successful receipt rather than repeat this exact import probe absent changed
source, missing evidence or a concrete concern. Independent mathematical review
and the full integrated source build/trust audit remain required. This routing
and verification-policy update changes neither the frozen source/probe bytes
nor their recorded acceptance; this reviewer performed no additional execution.
