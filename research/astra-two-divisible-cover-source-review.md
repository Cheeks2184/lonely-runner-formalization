# Independent source review: supplied two-divisible cover

**Accept all four exact contracts and the complete frozen source proofs.**
No semantic defect or dropped essential hypothesis was found. This is a
source-level review against the already accepted manuscript, not a second
manuscript derivation. The single predeclared import probe passed; its
complete actual result is retained at the end of this report.

Only this report is owned and edited. Requested role is Astra/xhigh;
independent runtime model/effort attestation is unavailable. Focused state
records research/in_progress and source checkpoint f7c77c8. Project config,
workflow, policy, and focused state were read. The actual command
`python3 scripts/validate_workflow.py` exited 0, with complete stdout:

```text
workflow structural validation passed; it cannot certify mathematical validity.
```

## Frozen targets and accepted contract correspondence

| Source | SHA-256 |
| --- | --- |
| SmallSixthSeeds.lean | dcd429006413b0403dac4584355fa2ef2aebe4008aec69212ef1a1b707dd5b41 |
| TwoDivisibleSmallPair.lean | ff40734821aae9abff43fdfc17c4275f4b5d045b4757b254dc11d24e695e8821 |
| TwoDivisibleCover.lean | 5438e044cb9026dadefb754aab18c22f7ad8eb9ce457f7ad9be3dedb3aff4d81 |

All three paths have prefix LonelyRunner/. Root authored the count and
local finisher; Terra drafted the scalar lemma and cover wrapper, followed
by root's elaboration corrections. This reviewer authored none of these
sources. Complete proofs in all three files were read.

The supplied-cover manuscript e37d2149 and its accepted review 4b71ee43
remain explicit guarded inputs. The public wrapper has exactly the accepted
natural-speed Fin 5 contract: every speed positive, two distinct labels
p,q characterized as exactly the labels divisible by three, and the supplied
factor-six divisibility cover for every other label. The conclusion retains
a single real t>0 with the closed sixth margin for all labels.

The local finisher retains its complete accepted contract, including both
strict reciprocal factor-five ratios, two distinct small labels u,w, and
both factor-six inequalities. It is now public so the wrapper can use it;
only visibility changed from the manuscript's private proposal. Neither
speed-value distinctness nor nondivisibility of u,w was added or silently
assumed. The cardinality helper separately proves equality to three, with
no speed positivity premise. The scalar helper works for arbitrary
positive **real** A,U under 6U≤A, not just natural values. All four exact
universal types are preserved in the executable probe below.

## Review of the actual source proofs

**SmallSixthSeeds.** The proof obtains 6A>0 before applying
`div_le_iff₀`. The ring rewrite of (1/(6A))U as U/(6A)
is valid without any division/cast ambiguity; all operations are real.
The smallness premise gives positive first phase at most 1/36 and
positive fifth phase at most 5/36. For each norm rewrite the source
first removes the absolute value by the phase's weak nonnegativity,
then proves its absolute value is at most 1/2. The resulting norm
equals the phase by `circleNorm_eq_abs_of_abs_le_half`.
Both numerical constants are strictly below 1/6, so the conclusion
is strict even when 6U=A. No hidden fractional wrap, natural quotient,
or equality-case exclusion appears.

**Exact exception cardinality.** Extensionality reduces the divisible
filter's membership to the supplied iff and identifies it with {a,b}.
The predicate complement partition gives its cardinality plus the
nondivisible cardinality equal to card(Fin 5). Distinct labels give
card{a,b}=2, hence the latter cardinality is exactly 3. The proof
counts labels, not distinct speed values; repeated speeds cause no
loss. It does not require hpos or a gcd hypothesis. The source's
`.le` use in the finisher is the correctly oriented upper bound;
the wrapper's later `.ge` use is the correctly oriented lower bound.

**Local finisher and both seed branches.** Explicit `exact_mod_cast`
steps transfer positive speeds, both reciprocal ratios, and each
smallness inequality to ℝ. The real reciprocal seed is
t₀=1/(6·v_a)>0. The scalar lemma supplies u and w strict badness at
both t₀ and 5t₀. The local `band` helper uses the existing closed
integer-band theorem with integer 0 and δ=1/6, discharging both
δ bounds and both closed endpoints.

The local `rescue` receives a positive real seed s, safe a,b, and
strictly bad distinct u,w. For every divisible label the exact hdiv
iff reduces it to a or b, establishing the whole divisible seed.
The checked adapter takes that seed, the exception count≤3, the
original two label inequalities and their distinctness. Its conclusion
provides **one k:Fin 3 for all five labels**. The finisher retains
that same k in t=s+k.val/3. The source proves k.val/3≥0 and combines
it with s>0; it never obtains five separately chosen shifts.

It is legitimate that the finisher's u,w parameters have no explicit
outside-label premise. In the adapter, safe divisibility plus strict
badness proves 3∤v_u and 3∤v_w before building the exceptional subtypes.
Thus no incompatible labeling can silently enter the collision theorem.

The exact identity t₀v_a=1/6 is obtained with real field arithmetic,
whose nonzero denominator follows from the earlier positive cast.
The first branch is the full closed safety test for b at t₀; if it
holds, rescue uses the first scalar bounds. In the other branch,
put x=t₀v_b. The proof first establishes x(6v_a)=v_b. Both
`mul_lt_mul_iff_left₀` applications cancel the same positive
factor 6v_a; hBAR gives x<5/6 and hABR gives x>1/30.
If x≥1/6, the local closed band contradicts the branch assumption,
so x<1/6. The strict lower endpoint and this strict upper endpoint
put 5x in (1/6,5/6). Reassociation to
(5t₀)v_b=5x is supplied by an explicit ring equality rather than
a false definitional equality. The a-phase at the second seed is
exactly 5/6; the b-phase is closed-safe by the band helper.
The second scalar bounds supply strict badness again, and rescue
at the positive seed 5t₀ finishes. Equality to a safe boundary in
the first branch is retained; neither t₀ nor 5t₀ can be zero.

**Cover wrapper and both fast-ratio exclusions.** The outer
`by_contra hnowitness` negates precisely the positive-time
conclusion. To prove v_p<5v_q, `Nat.lt_of_not_ge` assumes
5v_q≤v_p. For each i≠p, the source separates i=q. For other labels,
both inequalities needed by hcover are available. A divisor of
the positive dividend v_p has 6v_i≤v_p. A divisor of positive
v_q has 6v_i≤v_q, and then
5v_i≤6v_i≤v_q≤5v_q≤v_p.
The source's omega calls close exactly these linear natural
inequalities. Positivity is supplied to `Nat.le_of_dvd` at the
dividend, with the correct p or q in every branch.
The checked fast wrapper then supplies the forbidden positive witness.

For v_q<5v_p the source separately treats i=p and applies the
same complete cover to all remaining labels. The branch targeting p
uses 6v_i≤v_p and 5v_p≤v_q; the branch targeting q uses
6v_i≤v_q directly. Thus both strict ratios follow before any
pigeonhole selection. Equality in either extreme ratio is correctly
handled by the weak fast-speed hypothesis. The whole supplied cover
is essential to these deductions and is actually used.

The exceptional set E is the filter of nondivisible labels. Its exact
cardinality theorem supplies card E≥3 with Eq.ge. Membership in E
proves i≠p and i≠q via the reverse direction of hdiv, so the
supplied cover restricts to E. The generic pigeonhole helper chooses
distinct labels u,w with the same target. Its separate membership
proofs become unused only because the local finisher needs their
smallness and distinctness, while its adapter derives their required
nondivisibility. No speed values are identified.

For the p-target branch, the wrapper passes p,q, both ratios in their
original order, and the two positive-dividend divisor bounds.
For the q-target branch, it swaps p,q, uses hpq.symm, swaps the
ratios, and transports hdiv with `or_comm`; the bounds both use
positive v_q. These are the exact required local hypotheses.
Both returned positive witnesses contradict hnowitness.

**Dependency and scope checks.** The used rescue, fast wrapper, norm-band
and pigeonhole source interfaces were reread. The fast wrapper deletes
one label using succAbove, applies the previously checked
fourMovingNaturalRunners fifth-margin theorem, and inserts the fast speed.
It proves the insertion time nonzero and reflects a negative time while
preserving all norms; its public conclusion already includes positivity.
Consequently the current cover proof never confuses no-positive-witness
with no-all-real-witness. It does not recursively use a five-moving
sixth-margin theorem, normalize gcd, or manufacture hcover.

All target conclusions permit arbitrary repeated positive speed values
where their hypotheses hold. The wrapper excludes all-five-divisible
inputs through its exact two-label hdiv premise, not through a circular
reduction. Factor six, both ratio conditions at the local interface,
the strict bad-set threshold, and the closed final threshold are intact.

## Provenance and guard boundary

Root's historical Pass50 record reports successful focused source builds
for SmallSixthSeeds (2999 jobs), TwoDivisibleSmallPair (3012), and
TwoDivisibleCover (3538), each exit 0. It also preserves earlier root
small-pair and cover compilation failures, each exit 1. The final
corrections use the positive-factor multiplication iff, an explicit
reassociation equality, and Eq.ge for the exception lower bound.
Those historical runs are not executions of this review, and are not
replayed here. The frozen final sources, not the failed drafts, are reviewed.

The import probe binds 38 exact paths below: thirteen project source/olean
pairs, three mathlib source/olean pairs, both pins, the accepted cover
manuscript/review, and the earlier source reviews for pigeonhole and rescue.
This covers all direct imports of the target modules and the specifically
used inherited interfaces. It is not a complete byte audit of every
transitive import. Root's focused builds establish source-to-olean
correspondence; this import-only probe checks exported types and axioms.
Root integration, audit, mutable verification JSON, workflow state, and
other concurrent files are unguarded and untouched.

## Predeclared single import verification

Exactly four complete universal direct type assignments and four complete
axiom prints, with the three target modules imported directly. No display
options, extra probes, numeric fixtures, search, source build, cache action,
state/Git edit, or retry is authorized in this review.

The child command is
`/home/joshua/.elan/bin/lake env lean -j1 -s65536 --stdin`,
with process-local LEAN_NUM_THREADS=1 and LEAN_STACK_SIZE_KB=65536.
Limits are 8 GiB address space, CPU soft/hard 59/60 seconds, a child
60-second alarm, parent process-group kill at 60 seconds wall time,
and disabled core dumps. Stdin and both output streams use regular
temporary files. Each stream has a 128 KiB file cap; all retained
output is complete in UTF-8/base64 with exact byte counts and hashes.

Pass requires child exit 0, no timeout, uncapped complete streams,
empty stderr, unchanged guards/probe/launcher, and exactly four
complete axiom reports in the declared order using only propext,
Classical.choice, Quot.sound. Failure is retained without retry.

## Exact universal probe

<!-- BEGIN PROBE -->
```lean
import LonelyRunner.SmallSixthSeeds
import LonelyRunner.TwoDivisibleSmallPair
import LonelyRunner.TwoDivisibleCover

open LonelyRunner

example : ∀ (A U : ℝ), 0 < A → 0 < U → 6 * U ≤ A →
    circleNorm ((1 / (6 * A)) * U) < (1 : ℝ) / 6 ∧
      circleNorm ((5 * (1 / (6 * A))) * U) < (1 : ℝ) / 6 :=
  small_sixth_seed_norms

example : ∀ (v : Fin 5 → ℕ) (a b : Fin 5), a ≠ b →
    (∀ i, 3 ∣ v i ↔ i = a ∨ i = b) →
    ((Finset.univ : Finset (Fin 5)).filter (fun i => ¬ 3 ∣ v i)).card = 3 :=
  three_exceptions_of_two_divisible_labels

example : ∀ (v : Fin 5 → ℕ), (∀ i, 0 < v i) →
    ∀ (a b : Fin 5), a ≠ b →
    (∀ i, 3 ∣ v i ↔ i = a ∨ i = b) →
    v a < 5 * v b → v b < 5 * v a →
    ∀ (u w : Fin 5), u ≠ w → 6 * v u ≤ v a → 6 * v w ≤ v a →
    ∃ t : ℝ, 0 < t ∧ ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ)) :=
  two_divisible_pair_small_witness

example : ∀ (v : Fin 5 → ℕ), (∀ i, 0 < v i) →
    ∀ (p q : Fin 5), p ≠ q →
    (∀ i, 3 ∣ v i ↔ i = p ∨ i = q) →
    (∀ i, i ≠ p → i ≠ q → 6 * v i ∣ v p ∨ 6 * v i ∣ v q) →
    ∃ t : ℝ, 0 < t ∧ ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ)) :=
  fiveMovingNaturalRunners_of_two_divisible_cover

#print axioms LonelyRunner.small_sixth_seed_norms
#print axioms LonelyRunner.three_exceptions_of_two_divisible_labels
#print axioms LonelyRunner.two_divisible_pair_small_witness
#print axioms LonelyRunner.fiveMovingNaturalRunners_of_two_divisible_cover
```
<!-- END PROBE -->

## Exact bounded launcher

<!-- BEGIN LAUNCHER -->
```python
import base64
import hashlib
import json
import os
from pathlib import Path
import re
import resource
import signal
import subprocess
import tempfile
import time

REPORT = Path('research/astra-two-divisible-cover-source-review.md')
EXPECTED = {
    "LonelyRunner/SmallSixthSeeds.lean": "dcd429006413b0403dac4584355fa2ef2aebe4008aec69212ef1a1b707dd5b41",
    ".lake/build/lib/lean/LonelyRunner/SmallSixthSeeds.olean": "8d13d9d18808aa4e643156c5a3350bf2897d7da5a248d77d18472b5d74cbbc8e",
    "LonelyRunner/TwoDivisibleSmallPair.lean": "ff40734821aae9abff43fdfc17c4275f4b5d045b4757b254dc11d24e695e8821",
    ".lake/build/lib/lean/LonelyRunner/TwoDivisibleSmallPair.olean": "84c69092542b315e611aad9498aa57dc5e56e442b10b2a37d6c4836f8ce24af9",
    "LonelyRunner/TwoDivisibleCover.lean": "5438e044cb9026dadefb754aab18c22f7ad8eb9ce457f7ad9be3dedb3aff4d81",
    ".lake/build/lib/lean/LonelyRunner/TwoDivisibleCover.olean": "d364d5542397637ccd437a0bb6b773e94d576e79564c074e06302a63ca79a99b",
    "LonelyRunner/FastRunnerInsertion.lean": "dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5",
    ".lake/build/lib/lean/LonelyRunner/FastRunnerInsertion.olean": "121edfbaed0d7b9fed32bacf891de838142988e48dcb4e7f2bed0c488ea49136",
    "LonelyRunner/ThirdShiftRescues.lean": "829db12405e64ad88da5501ddb167d650ad82cf92295a88fd2374d9e08281732",
    ".lake/build/lib/lean/LonelyRunner/ThirdShiftRescues.olean": "f43015c4f1d03a823ae6987b979d1ea09a5d972e2ee8c7cc953c149d666d2e94",
    "LonelyRunner/StructuredClasses.lean": "5328a7a88d2b42f86ffc3f0f0418ca22c761219e8fa3e5822bda5a18ac286e8c",
    ".lake/build/lib/lean/LonelyRunner/StructuredClasses.olean": "4ada0ca2f0a5f20a8c83c3c2e58256e931c3b283882a88a074aeedb02d7e048f",
    "LonelyRunner/ThreeLabelPigeonhole.lean": "430cb0a6e32e79f78271bea9243500125eaafb097c4099efc7a372b73f259ea3",
    ".lake/build/lib/lean/LonelyRunner/ThreeLabelPigeonhole.olean": "ea0984a008110463f9690b40b506015d515cdb3103e93d1feea5ce751885f43c",
    "LonelyRunner/FiveMovingFast.lean": "cc203315c6d36be23b7cdcfc9706785fb05e6d5406c84714a9fea42bdfce7212",
    ".lake/build/lib/lean/LonelyRunner/FiveMovingFast.olean": "4cf670a69bb776af9038f6ea85c53e58543bebb58616919bd299b8de02292b52",
    "LonelyRunner/ThirdShiftSeed.lean": "3c8b90583658df1cfdbe00e4444157e08d8ae7b4a74b986d5770e9f750429b46",
    ".lake/build/lib/lean/LonelyRunner/ThirdShiftSeed.olean": "5305c6fd2737c6a611abdb710e5e7659bdccdb35c346b7e386c0733a592686be",
    "LonelyRunner/ThirdShiftCollision.lean": "5b984687f89ea16bad34453d3c048ceb974f999af9cd1969f73d56ce30e13cec",
    ".lake/build/lib/lean/LonelyRunner/ThirdShiftCollision.olean": "66e46c34df46e2a5350489acb7195991b6f332820fc6ec1535f40f4f186d4ef6",
    "LonelyRunner/FiveRunnerOrdinary.lean": "662d0116f13971bce85e76c503e2f3be4fdc6291ba8113aeda43957e38354ffe",
    ".lake/build/lib/lean/LonelyRunner/FiveRunnerOrdinary.olean": "408abf21f2b4e3c356ae528f92762826556887d7e5068283399a79d6ca72ef31",
    "LonelyRunner/RationalShiftOrbits.lean": "cf615dd6c6b3cf091cd5d31ac641f4f994c1c50d95e0120c311d3ac129b88591",
    ".lake/build/lib/lean/LonelyRunner/RationalShiftOrbits.olean": "8194c5c6ac0b8495146728fcac70a6a1e9d317f9e7689c4759f22ed33c14340f",
    "LonelyRunner/ThirdShiftExceptions.lean": "85590988cd0e104dc93fd51bc79aa326fe2799974eae426b7ea3336853872073",
    ".lake/build/lib/lean/LonelyRunner/ThirdShiftExceptions.olean": "d9c38deec30bda66014ed4d3e4de79fe5934f323e44e39771d353667ce47c7f9",
    ".lake/packages/mathlib/Mathlib/Tactic.lean": "c6f2c548596b635a3d5c8aff8b19cbdeb60dd54e41bb89a1cd03b1a54d335fa5",
    ".lake/packages/mathlib/.lake/build/lib/lean/Mathlib/Tactic.olean": "0534ef12e7aaf8ffbb6e520a91f922da4469d0dca2b54c87b4458e1faa28a6a2",
    ".lake/packages/mathlib/Mathlib/Data/Finset/Card.lean": "87c674ba5464c7868fb3e253e58a695821bf8841bb4e076bac5d570236dc6229",
    ".lake/packages/mathlib/.lake/build/lib/lean/Mathlib/Data/Finset/Card.olean": "44040732dc2bd596defca539de0564321aedb38782e179e9bd52f9c1d4c92a9a",
    ".lake/packages/mathlib/Mathlib/Data/Fintype/Card.lean": "2307820b0dee2080bd8245e268974bd02678d76067a6efc8878d004f7b8ed774",
    ".lake/packages/mathlib/.lake/build/lib/lean/Mathlib/Data/Fintype/Card.olean": "5574bbb259614ae208b68ffa3f0e2439d08e1316b7e1e60a42e677b4f73f9208",
    "lean-toolchain": "8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af",
    "lake-manifest.json": "887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218",
    "research/astra-two-divisible-cover-contract.md": "e37d214985a28e2622c3f9615bf4354f35d9baf481adf3acf22e5b15a4ea2766",
    "research/astra-two-divisible-cover-review.md": "4b71ee4374d032c0aeed46b2b571a7f45eb4d8d0543461103341cbf89b2a29ea",
    "research/astra-pairbands-pigeonhole-source-review.md": "e60208e27557f91cfd432b49e5632698aafc190655b82f79c2fd032d6c6f53db",
    "research/astra-seeded-special-source-review.md": "ca7159847d9ea1ed8f56370b7f19eda2989aa744da301ea94540cf34c3fd4250"
}

def sha(data):
    return hashlib.sha256(data).hexdigest()

def guard():
    observed = {p: sha(Path(p).read_bytes()) for p in EXPECTED}
    return observed, observed == EXPECTED

def section(report, name, language):
    start = '<!-- BEGIN ' + name + ' -->\n```' + language + '\n'
    end = '\n```\n<!-- END ' + name + ' -->'
    assert report.count(start) == 1 and report.count(end) == 1
    return (report.split(start, 1)[1].split(end, 1)[0] + '\n').encode('utf-8')

report_before = REPORT.read_text(encoding='utf-8')
probe = section(report_before, 'PROBE', 'lean')
launcher = section(report_before, 'LAUNCHER', 'python')
before, before_ok = guard()
if not before_ok:
    print(json.dumps({'status': 'precondition-failed', 'guards_before': before}, sort_keys=True))
    raise SystemExit(2)

CAP = 128 * 1024
WALL = 60.0
AS = 8 * 1024 ** 3

def child_limits():
    resource.setrlimit(resource.RLIMIT_AS, (AS, AS))
    resource.setrlimit(resource.RLIMIT_CPU, (59, 60))
    resource.setrlimit(resource.RLIMIT_FSIZE, (CAP, CAP))
    resource.setrlimit(resource.RLIMIT_CORE, (0, 0))
    signal.alarm(60)

argv = ['/home/joshua/.elan/bin/lake', 'env', 'lean', '-j1', '-s65536', '--stdin']
env = os.environ.copy()
env['LEAN_NUM_THREADS'] = '1'
env['LEAN_STACK_SIZE_KB'] = '65536'
env['PATH'] = '/home/joshua/.elan/bin:' + env.get('PATH', '')
usage_before = resource.getrusage(resource.RUSAGE_CHILDREN)
started = time.monotonic()
timed_out = False
with tempfile.TemporaryFile() as inp, tempfile.TemporaryFile() as out, tempfile.TemporaryFile() as err:
    inp.write(probe)
    inp.seek(0)
    child = subprocess.Popen(argv, stdin=inp, stdout=out, stderr=err,
        env=env, preexec_fn=child_limits, start_new_session=True)
    while child.poll() is None:
        if time.monotonic() - started >= WALL:
            timed_out = True
            try:
                os.killpg(child.pid, signal.SIGKILL)
            except ProcessLookupError:
                pass
            break
        time.sleep(0.02)
    exit_code = child.wait()
    wall = time.monotonic() - started
    out.seek(0)
    err.seek(0)
    stdout = out.read(CAP + 1)
    stderr = err.read(CAP + 1)
usage_after = resource.getrusage(resource.RUSAGE_CHILDREN)
after, after_ok = guard()
report_after = REPORT.read_text(encoding='utf-8')
probe_after = section(report_after, 'PROBE', 'lean')
launcher_after = section(report_after, 'LAUNCHER', 'python')
executable_unchanged = probe_after == probe and launcher_after == launcher
capture_ok = len(stdout) < CAP and len(stderr) < CAP
text_out = stdout.decode('utf-8', errors='replace')
axiom_records = re.findall(
    r"'LonelyRunner\.([^']+)' (?:depends on axioms: \[([^\]]*)\]|does not depend on any axioms)",
    text_out)
names = [
    "small_sixth_seed_norms",
    "three_exceptions_of_two_divisible_labels",
    "two_divisible_pair_small_witness",
    "fiveMovingNaturalRunners_of_two_divisible_cover"
]
allowed = {'propext', 'Classical.choice', 'Quot.sound'}
axioms_ok = [name for name, _ in axiom_records] == names and all(
    set(filter(None, (x.strip() for x in body.split(',')))) <= allowed
    for _, body in axiom_records)
passed = (exit_code == 0 and not timed_out and capture_ok and not stderr
    and after_ok and executable_unchanged and axioms_ok)
receipt = {
    'status': 'passed' if passed else 'failed',
    'argv': argv,
    'runtime_env': {k: env[k] for k in ['LEAN_NUM_THREADS', 'LEAN_STACK_SIZE_KB']},
    'cwd': str(Path.cwd()),
    'exit_code': exit_code,
    'timed_out': timed_out,
    'wall_seconds': wall,
    'limits': {'address_space_bytes': AS, 'cpu_seconds': [59, 60],
        'wall_seconds': WALL, 'alarm_seconds': 60,
        'per_stream_bytes': CAP, 'combined_stream_bytes': 2 * CAP},
    'child_user_seconds': usage_after.ru_utime - usage_before.ru_utime,
    'child_system_seconds': usage_after.ru_stime - usage_before.ru_stime,
    'child_maxrss_kib': usage_after.ru_maxrss,
    'probe_bytes': len(probe),
    'probe_sha256': sha(probe),
    'probe_after_sha256': sha(probe_after),
    'launcher_bytes': len(launcher),
    'launcher_sha256': sha(launcher),
    'launcher_after_sha256': sha(launcher_after),
    'executable_unchanged': executable_unchanged,
    'guards_before': before,
    'guards_after': after,
    'capture_ok': capture_ok,
    'axiom_records': axiom_records,
    'axioms_ok': axioms_ok,
    'stdout_bytes': len(stdout),
    'stdout_sha256': sha(stdout),
    'stdout_base64': base64.b64encode(stdout).decode('ascii'),
    'stdout_utf8': text_out,
    'stderr_bytes': len(stderr),
    'stderr_sha256': sha(stderr),
    'stderr_base64': base64.b64encode(stderr).decode('ascii'),
    'stderr_utf8': stderr.decode('utf-8', errors='replace'),
}
print(json.dumps(receipt, sort_keys=True, indent=2))
raise SystemExit(0 if passed else 1)
```
<!-- END LAUNCHER -->

## Single Bash import replay entry

Run from /home/joshua/lonely-runner-formalization. This entry invokes
Lean once through the frozen launcher; it is distinct from the static
preflight that only parses and checks hashes.

```bash
python3 -I - <<'PY'
from pathlib import Path
p = Path('research/astra-two-divisible-cover-source-review.md')
s = p.read_text(encoding='utf-8')
start = '<!-- BEGIN LAUNCHER -->\n```python\n'
end = '\n```\n<!-- END LAUNCHER -->'
assert s.count(start) == 1 and s.count(end) == 1
code = s.split(start, 1)[1].split(end, 1)[0] + '\n'
exec(compile(code, str(p) + ':launcher', 'exec'))
PY
```

This source batch proves the supplied-cover implication and its helpers.
It does not establish the cover for arbitrary inputs, complete the
boundary-zero argument or full two-divisible branch, prove a new canonical
runner count, or resolve unrestricted LRC.

## Pre-invocation static freeze

Static AST parsing, all 38 file hashes, four universal assignment/axiom
print counts, and exact Bash-to-launcher extraction passed before any
Lean invocation. The extraction evaluated only the Bash Python prefix,
omitting its final exec call. The static command actually exited 0 with
the complete stdout below and empty stderr. Both executable sections are
now fixed; the following hashes precede the single authorized invocation.

```json
{
  "static_only": true,
  "guard_count": 38,
  "guards_match": true,
  "bash_entry_extraction_matches": true,
  "probe_bytes": 1562,
  "probe_sha256": "4a1ea22e999062c7f727565f910ce733214fba6fe0b9ffb59160c69b625dc1d1",
  "launcher_bytes": 9726,
  "launcher_sha256": "8ec14768225993f7601fb5c759c6c3208c2ee46070f23bb695039a7e87d53ecf",
  "bash_bytes": 381,
  "bash_sha256": "a426679348565c31092bd2d94be8480127293187d2e2b489cb5a3f720162bcf7",
  "lean_invocations": 0
}
```

## Actual execution and final verdict

All four complete universal assignments elaborated successfully at the frozen
imports. All four complete axiom reports use only propext, Classical.choice,
Quot.sound. Accept the four frozen source declarations at their exact
stated scope, including the public supplied-cover theorem.

The single Lean child, outer Bash launcher, and capture wrapper each actually
exited 0. Outer stderr was empty. No timeout, retry, extra Lean invocation,
source build, numerical experiment, or altered executable occurred.
Actual wall time was 2.0525885449897032 seconds; child user/system CPU
1.419304/0.6321669999999999 seconds; Linux child peak RSS
3646100 KiB. Peak RSS is a resident-memory measurement distinct
from the address-space cap. Stdout was exactly 443 bytes,
stderr exactly zero. All 38 guards and both full executable sections
were unchanged before/after. The axiom parser retained the last report's
multiline continuation through the closing bracket.

Complete child stdout, without omitted lines:

```text
'LonelyRunner.small_sixth_seed_norms' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.three_exceptions_of_two_divisible_labels' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.two_divisible_pair_small_witness' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.fiveMovingNaturalRunners_of_two_divisible_cover' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
```

The exact complete launcher stdout is retained below as JSON, including
full raw child streams in UTF-8 and base64, byte counts, hashes, actual
resource measurements and limits, before/after bindings, and exit code.
The outer Bash exit 0 and empty outer stderr recorded above complete
the invocation provenance.

```json
{
  "argv": [
    "/home/joshua/.elan/bin/lake",
    "env",
    "lean",
    "-j1",
    "-s65536",
    "--stdin"
  ],
  "axiom_records": [
    [
      "small_sixth_seed_norms",
      "propext, Classical.choice, Quot.sound"
    ],
    [
      "three_exceptions_of_two_divisible_labels",
      "propext, Classical.choice, Quot.sound"
    ],
    [
      "two_divisible_pair_small_witness",
      "propext, Classical.choice, Quot.sound"
    ],
    [
      "fiveMovingNaturalRunners_of_two_divisible_cover",
      "propext,\n Classical.choice,\n Quot.sound"
    ]
  ],
  "axioms_ok": true,
  "capture_ok": true,
  "child_maxrss_kib": 3646100,
  "child_system_seconds": 0.6321669999999999,
  "child_user_seconds": 1.419304,
  "cwd": "/home/joshua/lonely-runner-formalization",
  "executable_unchanged": true,
  "exit_code": 0,
  "guards_after": {
    ".lake/build/lib/lean/LonelyRunner/FastRunnerInsertion.olean": "121edfbaed0d7b9fed32bacf891de838142988e48dcb4e7f2bed0c488ea49136",
    ".lake/build/lib/lean/LonelyRunner/FiveMovingFast.olean": "4cf670a69bb776af9038f6ea85c53e58543bebb58616919bd299b8de02292b52",
    ".lake/build/lib/lean/LonelyRunner/FiveRunnerOrdinary.olean": "408abf21f2b4e3c356ae528f92762826556887d7e5068283399a79d6ca72ef31",
    ".lake/build/lib/lean/LonelyRunner/RationalShiftOrbits.olean": "8194c5c6ac0b8495146728fcac70a6a1e9d317f9e7689c4759f22ed33c14340f",
    ".lake/build/lib/lean/LonelyRunner/SmallSixthSeeds.olean": "8d13d9d18808aa4e643156c5a3350bf2897d7da5a248d77d18472b5d74cbbc8e",
    ".lake/build/lib/lean/LonelyRunner/StructuredClasses.olean": "4ada0ca2f0a5f20a8c83c3c2e58256e931c3b283882a88a074aeedb02d7e048f",
    ".lake/build/lib/lean/LonelyRunner/ThirdShiftCollision.olean": "66e46c34df46e2a5350489acb7195991b6f332820fc6ec1535f40f4f186d4ef6",
    ".lake/build/lib/lean/LonelyRunner/ThirdShiftExceptions.olean": "d9c38deec30bda66014ed4d3e4de79fe5934f323e44e39771d353667ce47c7f9",
    ".lake/build/lib/lean/LonelyRunner/ThirdShiftRescues.olean": "f43015c4f1d03a823ae6987b979d1ea09a5d972e2ee8c7cc953c149d666d2e94",
    ".lake/build/lib/lean/LonelyRunner/ThirdShiftSeed.olean": "5305c6fd2737c6a611abdb710e5e7659bdccdb35c346b7e386c0733a592686be",
    ".lake/build/lib/lean/LonelyRunner/ThreeLabelPigeonhole.olean": "ea0984a008110463f9690b40b506015d515cdb3103e93d1feea5ce751885f43c",
    ".lake/build/lib/lean/LonelyRunner/TwoDivisibleCover.olean": "d364d5542397637ccd437a0bb6b773e94d576e79564c074e06302a63ca79a99b",
    ".lake/build/lib/lean/LonelyRunner/TwoDivisibleSmallPair.olean": "84c69092542b315e611aad9498aa57dc5e56e442b10b2a37d6c4836f8ce24af9",
    ".lake/packages/mathlib/.lake/build/lib/lean/Mathlib/Data/Finset/Card.olean": "44040732dc2bd596defca539de0564321aedb38782e179e9bd52f9c1d4c92a9a",
    ".lake/packages/mathlib/.lake/build/lib/lean/Mathlib/Data/Fintype/Card.olean": "5574bbb259614ae208b68ffa3f0e2439d08e1316b7e1e60a42e677b4f73f9208",
    ".lake/packages/mathlib/.lake/build/lib/lean/Mathlib/Tactic.olean": "0534ef12e7aaf8ffbb6e520a91f922da4469d0dca2b54c87b4458e1faa28a6a2",
    ".lake/packages/mathlib/Mathlib/Data/Finset/Card.lean": "87c674ba5464c7868fb3e253e58a695821bf8841bb4e076bac5d570236dc6229",
    ".lake/packages/mathlib/Mathlib/Data/Fintype/Card.lean": "2307820b0dee2080bd8245e268974bd02678d76067a6efc8878d004f7b8ed774",
    ".lake/packages/mathlib/Mathlib/Tactic.lean": "c6f2c548596b635a3d5c8aff8b19cbdeb60dd54e41bb89a1cd03b1a54d335fa5",
    "LonelyRunner/FastRunnerInsertion.lean": "dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5",
    "LonelyRunner/FiveMovingFast.lean": "cc203315c6d36be23b7cdcfc9706785fb05e6d5406c84714a9fea42bdfce7212",
    "LonelyRunner/FiveRunnerOrdinary.lean": "662d0116f13971bce85e76c503e2f3be4fdc6291ba8113aeda43957e38354ffe",
    "LonelyRunner/RationalShiftOrbits.lean": "cf615dd6c6b3cf091cd5d31ac641f4f994c1c50d95e0120c311d3ac129b88591",
    "LonelyRunner/SmallSixthSeeds.lean": "dcd429006413b0403dac4584355fa2ef2aebe4008aec69212ef1a1b707dd5b41",
    "LonelyRunner/StructuredClasses.lean": "5328a7a88d2b42f86ffc3f0f0418ca22c761219e8fa3e5822bda5a18ac286e8c",
    "LonelyRunner/ThirdShiftCollision.lean": "5b984687f89ea16bad34453d3c048ceb974f999af9cd1969f73d56ce30e13cec",
    "LonelyRunner/ThirdShiftExceptions.lean": "85590988cd0e104dc93fd51bc79aa326fe2799974eae426b7ea3336853872073",
    "LonelyRunner/ThirdShiftRescues.lean": "829db12405e64ad88da5501ddb167d650ad82cf92295a88fd2374d9e08281732",
    "LonelyRunner/ThirdShiftSeed.lean": "3c8b90583658df1cfdbe00e4444157e08d8ae7b4a74b986d5770e9f750429b46",
    "LonelyRunner/ThreeLabelPigeonhole.lean": "430cb0a6e32e79f78271bea9243500125eaafb097c4099efc7a372b73f259ea3",
    "LonelyRunner/TwoDivisibleCover.lean": "5438e044cb9026dadefb754aab18c22f7ad8eb9ce457f7ad9be3dedb3aff4d81",
    "LonelyRunner/TwoDivisibleSmallPair.lean": "ff40734821aae9abff43fdfc17c4275f4b5d045b4757b254dc11d24e695e8821",
    "lake-manifest.json": "887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218",
    "lean-toolchain": "8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af",
    "research/astra-pairbands-pigeonhole-source-review.md": "e60208e27557f91cfd432b49e5632698aafc190655b82f79c2fd032d6c6f53db",
    "research/astra-seeded-special-source-review.md": "ca7159847d9ea1ed8f56370b7f19eda2989aa744da301ea94540cf34c3fd4250",
    "research/astra-two-divisible-cover-contract.md": "e37d214985a28e2622c3f9615bf4354f35d9baf481adf3acf22e5b15a4ea2766",
    "research/astra-two-divisible-cover-review.md": "4b71ee4374d032c0aeed46b2b571a7f45eb4d8d0543461103341cbf89b2a29ea"
  },
  "guards_before": {
    ".lake/build/lib/lean/LonelyRunner/FastRunnerInsertion.olean": "121edfbaed0d7b9fed32bacf891de838142988e48dcb4e7f2bed0c488ea49136",
    ".lake/build/lib/lean/LonelyRunner/FiveMovingFast.olean": "4cf670a69bb776af9038f6ea85c53e58543bebb58616919bd299b8de02292b52",
    ".lake/build/lib/lean/LonelyRunner/FiveRunnerOrdinary.olean": "408abf21f2b4e3c356ae528f92762826556887d7e5068283399a79d6ca72ef31",
    ".lake/build/lib/lean/LonelyRunner/RationalShiftOrbits.olean": "8194c5c6ac0b8495146728fcac70a6a1e9d317f9e7689c4759f22ed33c14340f",
    ".lake/build/lib/lean/LonelyRunner/SmallSixthSeeds.olean": "8d13d9d18808aa4e643156c5a3350bf2897d7da5a248d77d18472b5d74cbbc8e",
    ".lake/build/lib/lean/LonelyRunner/StructuredClasses.olean": "4ada0ca2f0a5f20a8c83c3c2e58256e931c3b283882a88a074aeedb02d7e048f",
    ".lake/build/lib/lean/LonelyRunner/ThirdShiftCollision.olean": "66e46c34df46e2a5350489acb7195991b6f332820fc6ec1535f40f4f186d4ef6",
    ".lake/build/lib/lean/LonelyRunner/ThirdShiftExceptions.olean": "d9c38deec30bda66014ed4d3e4de79fe5934f323e44e39771d353667ce47c7f9",
    ".lake/build/lib/lean/LonelyRunner/ThirdShiftRescues.olean": "f43015c4f1d03a823ae6987b979d1ea09a5d972e2ee8c7cc953c149d666d2e94",
    ".lake/build/lib/lean/LonelyRunner/ThirdShiftSeed.olean": "5305c6fd2737c6a611abdb710e5e7659bdccdb35c346b7e386c0733a592686be",
    ".lake/build/lib/lean/LonelyRunner/ThreeLabelPigeonhole.olean": "ea0984a008110463f9690b40b506015d515cdb3103e93d1feea5ce751885f43c",
    ".lake/build/lib/lean/LonelyRunner/TwoDivisibleCover.olean": "d364d5542397637ccd437a0bb6b773e94d576e79564c074e06302a63ca79a99b",
    ".lake/build/lib/lean/LonelyRunner/TwoDivisibleSmallPair.olean": "84c69092542b315e611aad9498aa57dc5e56e442b10b2a37d6c4836f8ce24af9",
    ".lake/packages/mathlib/.lake/build/lib/lean/Mathlib/Data/Finset/Card.olean": "44040732dc2bd596defca539de0564321aedb38782e179e9bd52f9c1d4c92a9a",
    ".lake/packages/mathlib/.lake/build/lib/lean/Mathlib/Data/Fintype/Card.olean": "5574bbb259614ae208b68ffa3f0e2439d08e1316b7e1e60a42e677b4f73f9208",
    ".lake/packages/mathlib/.lake/build/lib/lean/Mathlib/Tactic.olean": "0534ef12e7aaf8ffbb6e520a91f922da4469d0dca2b54c87b4458e1faa28a6a2",
    ".lake/packages/mathlib/Mathlib/Data/Finset/Card.lean": "87c674ba5464c7868fb3e253e58a695821bf8841bb4e076bac5d570236dc6229",
    ".lake/packages/mathlib/Mathlib/Data/Fintype/Card.lean": "2307820b0dee2080bd8245e268974bd02678d76067a6efc8878d004f7b8ed774",
    ".lake/packages/mathlib/Mathlib/Tactic.lean": "c6f2c548596b635a3d5c8aff8b19cbdeb60dd54e41bb89a1cd03b1a54d335fa5",
    "LonelyRunner/FastRunnerInsertion.lean": "dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5",
    "LonelyRunner/FiveMovingFast.lean": "cc203315c6d36be23b7cdcfc9706785fb05e6d5406c84714a9fea42bdfce7212",
    "LonelyRunner/FiveRunnerOrdinary.lean": "662d0116f13971bce85e76c503e2f3be4fdc6291ba8113aeda43957e38354ffe",
    "LonelyRunner/RationalShiftOrbits.lean": "cf615dd6c6b3cf091cd5d31ac641f4f994c1c50d95e0120c311d3ac129b88591",
    "LonelyRunner/SmallSixthSeeds.lean": "dcd429006413b0403dac4584355fa2ef2aebe4008aec69212ef1a1b707dd5b41",
    "LonelyRunner/StructuredClasses.lean": "5328a7a88d2b42f86ffc3f0f0418ca22c761219e8fa3e5822bda5a18ac286e8c",
    "LonelyRunner/ThirdShiftCollision.lean": "5b984687f89ea16bad34453d3c048ceb974f999af9cd1969f73d56ce30e13cec",
    "LonelyRunner/ThirdShiftExceptions.lean": "85590988cd0e104dc93fd51bc79aa326fe2799974eae426b7ea3336853872073",
    "LonelyRunner/ThirdShiftRescues.lean": "829db12405e64ad88da5501ddb167d650ad82cf92295a88fd2374d9e08281732",
    "LonelyRunner/ThirdShiftSeed.lean": "3c8b90583658df1cfdbe00e4444157e08d8ae7b4a74b986d5770e9f750429b46",
    "LonelyRunner/ThreeLabelPigeonhole.lean": "430cb0a6e32e79f78271bea9243500125eaafb097c4099efc7a372b73f259ea3",
    "LonelyRunner/TwoDivisibleCover.lean": "5438e044cb9026dadefb754aab18c22f7ad8eb9ce457f7ad9be3dedb3aff4d81",
    "LonelyRunner/TwoDivisibleSmallPair.lean": "ff40734821aae9abff43fdfc17c4275f4b5d045b4757b254dc11d24e695e8821",
    "lake-manifest.json": "887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218",
    "lean-toolchain": "8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af",
    "research/astra-pairbands-pigeonhole-source-review.md": "e60208e27557f91cfd432b49e5632698aafc190655b82f79c2fd032d6c6f53db",
    "research/astra-seeded-special-source-review.md": "ca7159847d9ea1ed8f56370b7f19eda2989aa744da301ea94540cf34c3fd4250",
    "research/astra-two-divisible-cover-contract.md": "e37d214985a28e2622c3f9615bf4354f35d9baf481adf3acf22e5b15a4ea2766",
    "research/astra-two-divisible-cover-review.md": "4b71ee4374d032c0aeed46b2b571a7f45eb4d8d0543461103341cbf89b2a29ea"
  },
  "launcher_after_sha256": "8ec14768225993f7601fb5c759c6c3208c2ee46070f23bb695039a7e87d53ecf",
  "launcher_bytes": 9726,
  "launcher_sha256": "8ec14768225993f7601fb5c759c6c3208c2ee46070f23bb695039a7e87d53ecf",
  "limits": {
    "address_space_bytes": 8589934592,
    "alarm_seconds": 60,
    "combined_stream_bytes": 262144,
    "cpu_seconds": [
      59,
      60
    ],
    "per_stream_bytes": 131072,
    "wall_seconds": 60.0
  },
  "probe_after_sha256": "4a1ea22e999062c7f727565f910ce733214fba6fe0b9ffb59160c69b625dc1d1",
  "probe_bytes": 1562,
  "probe_sha256": "4a1ea22e999062c7f727565f910ce733214fba6fe0b9ffb59160c69b625dc1d1",
  "runtime_env": {
    "LEAN_NUM_THREADS": "1",
    "LEAN_STACK_SIZE_KB": "65536"
  },
  "status": "passed",
  "stderr_base64": "",
  "stderr_bytes": 0,
  "stderr_sha256": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
  "stderr_utf8": "",
  "stdout_base64": "J0xvbmVseVJ1bm5lci5zbWFsbF9zaXh0aF9zZWVkX25vcm1zJyBkZXBlbmRzIG9uIGF4aW9tczogW3Byb3BleHQsIENsYXNzaWNhbC5jaG9pY2UsIFF1b3Quc291bmRdCidMb25lbHlSdW5uZXIudGhyZWVfZXhjZXB0aW9uc19vZl90d29fZGl2aXNpYmxlX2xhYmVscycgZGVwZW5kcyBvbiBheGlvbXM6IFtwcm9wZXh0LCBDbGFzc2ljYWwuY2hvaWNlLCBRdW90LnNvdW5kXQonTG9uZWx5UnVubmVyLnR3b19kaXZpc2libGVfcGFpcl9zbWFsbF93aXRuZXNzJyBkZXBlbmRzIG9uIGF4aW9tczogW3Byb3BleHQsIENsYXNzaWNhbC5jaG9pY2UsIFF1b3Quc291bmRdCidMb25lbHlSdW5uZXIuZml2ZU1vdmluZ05hdHVyYWxSdW5uZXJzX29mX3R3b19kaXZpc2libGVfY292ZXInIGRlcGVuZHMgb24gYXhpb21zOiBbcHJvcGV4dCwKIENsYXNzaWNhbC5jaG9pY2UsCiBRdW90LnNvdW5kXQo=",
  "stdout_bytes": 443,
  "stdout_sha256": "9101ced182ea110d797d4a549afb8e0d7f8ae362fb5327929dea0898898134d5",
  "stdout_utf8": "'LonelyRunner.small_sixth_seed_norms' depends on axioms: [propext, Classical.choice, Quot.sound]\n'LonelyRunner.three_exceptions_of_two_divisible_labels' depends on axioms: [propext, Classical.choice, Quot.sound]\n'LonelyRunner.two_divisible_pair_small_witness' depends on axioms: [propext, Classical.choice, Quot.sound]\n'LonelyRunner.fiveMovingNaturalRunners_of_two_divisible_cover' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n",
  "timed_out": false,
  "wall_seconds": 2.0525885449897032
}
```

No correction remains within this reviewed batch. Root's full report read,
exact replay, and normal source integration/build/trust checks remain
separate publication obligations. The mathematical remaining gap is
establishing the supplied cover in the pending boundary-zero argument;
this conditional source theorem does not establish that premise.
