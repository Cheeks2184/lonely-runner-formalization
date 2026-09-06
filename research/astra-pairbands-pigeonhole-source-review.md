# Independent source review: anchored pair bands and pigeonhole

**Source verdict: accept both exact public contracts and their complete proofs.**
This review found no missing essential hypothesis, hidden existence claim, or
mathematical defect. The single predeclared bounded import check passed;
its complete actual outcome is retained at the end of this report.

Task ownership is only this report. Requested route is Astra/xhigh; independent
runtime model/effort attestation is unavailable. Current task state records
research/in_progress and checkpoint cd15103. Config, workflow, policy, and
focused state were read; `python3 scripts/validate_workflow.py` actually exited
0 with complete stdout:

```text
workflow structural validation passed; it cannot certify mathematical validity.
```

The target sources are frozen as follows:

- `LonelyRunner/AnchoredPairSafeBands.lean`:
  `14212e32cdd3a343b286dd0fc370cefa6c33c145541f61afdf42e8e5290bc306`.
- `LonelyRunner/ThreeLabelPigeonhole.lean`:
  `430cb0a6e32e79f78271bea9243500125eaafb097c4099efc7a372b73f259ea3`.

Root authored the pair theorem. Terra drafted the pigeonhole source and root
corrected the implicit Finset argument. This reviewer authored neither source.
Root reports focused builds passed at these exact bytes; historical root
builds and corrections are not new executions by this reviewer.

## Contracts and independent proof review

The exact complete universal assignments below are also the executable
contract probes. The first theorem quantifies over all natural a,b,c and all
real t. It retains 3∣a, 3∣b, 3∤c, the anchor fract(tc)=5/6,
0<N(ta)<1/6, the order N(ta)≤N(tb), and the supplied bound on **every real**
s satisfying the same anchor. Its conclusion is the ten-field
`FoldedPairSafeBands (N(ta)) (N(tb))` proposition, not a witness-existence
claim. No positivity of t, speed distinctness, primitivity, maximizing seed
existence, or strict global maximum is asserted. Zero natural arguments are
allowed syntactically; incompatible zero cases are ruled out by the existing
phase/positivity/order premises. Negative real t and s are fully included.

Put A=N(ta), B=N(tb). Here is the independent justification of every stage
in the complete pair proof:

1. Integer dilation of fractional parts gives
   fract(3tc)=fract(3·5/6)=1/2 and
   fract(5tc)=fract(5·5/6)=1/6. The source first rewrites the product with
   an explicitly cast integer multiplier and applies `fract_int_dilate_eq`.
   Its fractional quotient reductions are in ℝ: the fractions 15/6 and
   25/6 are real quotients of cast naturals, reduced by the exact
   `Int.fract_div_natCast_eq_div_natCast_mod` identity. This is not natural
   division followed by a real cast. Integer-turn removal is valid for
   arbitrary signed real t, without a [0,1) restriction.
2. The supplied five-sixths fiber bound transfers to each of 3t and 5t by
   `pair_min_le_of_special_sixth_fiber_bound`. That dependency chooses
   a third shift to put the c-phase at 5/6; 3∤c supplies that transport.
   The same shift preserves both a and b phases because 3 divides both.
   It then applies the bound at the transported real time. In this proof
   the bound is instantiated with M=A. Separate transport shifts for 3t
   and 5t are harmless: both steps only establish inequalities at their
   original times, not a simultaneous time witness.
3. The local hfold specializes
   `circleNorm_nat_mul_add_int_half (t*d) n 0`, removes the zero
   half-shift, and reassociates multiplication. It gives
   N((nt)d)=N(nN(td)) for each natural n,d. Thus the transported
   inequalities become min(N(3A),N(3B))≤A and
   min(N(5A),N(5B))≤A. Folding respects either orientation of the
   signed phase; there is no assumption ta or tb equals its folded norm.
4. Since 0<A<1/6, `small_folded_three_five_improve` gives
   A<N(3A) and A<N(5A). This follows from the strict integer band
   A<3A<1−A and A<5A<1−A. Each use of `min_le_iff`
   has two branches; the A-coordinate branch contradicts its strict
   improvement. The remaining branch gives N(3B)≤A or N(5B)≤A.
   The supplied bound is weak; the strictness needed for contradiction
   comes entirely from these improvements.
5. The universal norm bound B≤1/2 follows from
   `circleNorm_eq_abs_sub_round` and `abs_sub_round`.
   Together with A>0, A<1/6, A≤B and the two inequalities above,
   the exact scalar dependency `two_divisible_folded_band` gives
   A≥1/8 and 11/30<B<7/18. Its rounded integers are forced to 1
   for 3B and 2 for 5B, yielding
   1−A≤3B≤1+A and 2−A≤5B≤2+A. Comparing
   3(2−A)≤5(1+A) gives A≥1/8. The two strict B endpoints
   use A<1/6. This dependency needs the order premise; it is retained.
6. The final call `foldedPairSafeBands_of_bounds` uses exactly those
   scalar bounds and A<1/6. The conclusion's fields, in source order,
   are the closed sixth-margin bounds at the following folded phases:

| Left phases | Right phases |
| --- | --- |
| 2A | B |
| 3A | 2B |
| 4A | 4B |
| A+1/2 | 2B+1/2 |
| 2A+1/2 | 3B+1/2 |

The left phases and the first two right phases lie in [1/6,5/6];
the last three right phases lie in [7/6,11/6]. For example
4B lies strictly between 22/15 and 14/9, and 2A+1/2 lies in
[3/4,5/6). The source uses the two closed integer bands, preserving
the permitted endpoint A=1/8 and the closed norm threshold. The table
records the exact structure fields rather than a weaker scalar surrogate.

These are dependency applications inside this theorem, not a duplicate
independent review/probe of the seven upstream affine, folded, and transport
declarations being reviewed by the other agent. Their current source
interfaces and needed proof steps were read to verify this composition.

The pigeonhole theorem is universe-generic over `Type u`, retains
`[DecidableEq ι]`, and only assumes a finite S with card≥3. P and Q
are arbitrary propositions; their cover need not be exclusive. Its proof
works classically, setting A=S.filter P. If card A≥2,
`Finset.one_lt_card` returns two distinct members, and
`Finset.mem_filter` supplies membership in S and both P proofs.
Otherwise, set B=S.filter (¬P). The exact partition identity with
`(s := S)` gives card A+card B=card S, so card B≥2.
Two distinct B-members belong to S, have ¬P, and therefore satisfy Q
by the supplied cover. It counts labels, so repeated speed values in an
application are irrelevant. There is no global Fintype or DecidablePred
premise, and no fixed finite enumeration. Empty and smaller finite sets
simply cannot satisfy the stated cardinality premise.

The helper matches the accepted cover manuscript exactly, including
quantifier order and both distinctness/membership conclusions.

## Dependency and execution boundary

All direct project imports of the two targets are guarded with their oleans:
AnchoredPairTransport, FoldedPairSafeBands, and TwoDivisibleFoldedBand.
The launcher additionally binds the needed folded/affine phase, special-sixth,
rational-shift, norm, and real-band sources; Mathlib.Tactic, the Finset
cardinality source, and fractional-quotient source with their oleans;
both dependency pins; and the two accepted manuscript/review pairs.
There are 36 guarded paths, all explicit in EXPECTED below.

This is an import-only check of the exported declarations at frozen oleans.
It relies on root's separately reported focused builds for source-to-olean
correspondence and does not rebuild source or hash every transitive dependency.
Root integration files, audit files, workflow state and other concurrent
work are deliberately outside the guard set.

A read-only rg command initially included a guessed nonexistent path
`LonelyRunner/ScalarPhaseAffine.lean`; it exited 2 with
`rg: LonelyRunner/ScalarPhaseAffine.lean: No such file or directory (os error 2)`.
The actual import is SixthAffinePhase, subsequently read and guarded.
This was source discovery, not a failed theorem check.

## Predeclared single import verification

Exactly two full universal type assignments and two full axiom prints are
authorized. The two target modules are imported directly; there are no
display options, extra probes, numerical fixtures, searches, source builds,
cache operations, state/Git edits, or retries.

Child argv: `/home/joshua/.elan/bin/lake env lean -j1 -s65536 --stdin`.
Process-local environment: LEAN_NUM_THREADS=1 and LEAN_STACK_SIZE_KB=65536.
Limits: 8 GiB address space, CPU soft/hard 59/60 seconds, child alarm 60
seconds, parent process-group kill at 60 seconds wall time, no core dumps.
Stdin and both streams use regular temporary files; each output file is
capped at 128 KiB. The report retains complete output as UTF-8 and base64
with hashes and byte counts. Temporary stream files are anonymous scratch
capture, not source/cache edits.

Pass requires actual child exit 0, no timeout, uncapped capture, empty
stderr, all guards and both executable blocks unchanged, and exactly the
two complete axiom lists in the declared order, using only propext,
Classical.choice and Quot.sound. Any failure is retained without retry.

## Exact universal probe

<!-- BEGIN PROBE -->
```lean
import LonelyRunner.AnchoredPairSafeBands
import LonelyRunner.ThreeLabelPigeonhole

open LonelyRunner

universe u

example : ∀ (a b c : ℕ), 3 ∣ a → 3 ∣ b → ¬ 3 ∣ c →
    ∀ t : ℝ, Int.fract (t * (c : ℝ)) = (5 : ℝ) / 6 →
    0 < circleNorm (t * (a : ℝ)) →
    circleNorm (t * (a : ℝ)) < (1 : ℝ) / 6 →
    circleNorm (t * (a : ℝ)) ≤ circleNorm (t * (b : ℝ)) →
    (∀ s : ℝ, Int.fract (s * (c : ℝ)) = (5 : ℝ) / 6 →
      min (circleNorm (s * (a : ℝ))) (circleNorm (s * (b : ℝ))) ≤
        circleNorm (t * (a : ℝ))) →
    FoldedPairSafeBands (circleNorm (t * (a : ℝ)))
      (circleNorm (t * (b : ℝ))) :=
  foldedPairSafeBands_of_five_sixths_pair_bound

example : ∀ {ι : Type u} [DecidableEq ι] (S : Finset ι),
    3 ≤ S.card → ∀ (P Q : ι → Prop),
    (∀ i ∈ S, P i ∨ Q i) →
    (∃ u ∈ S, ∃ w ∈ S, u ≠ w ∧ P u ∧ P w) ∨
      (∃ u ∈ S, ∃ w ∈ S, u ≠ w ∧ Q u ∧ Q w) :=
  @exists_two_same_side_of_three

#print axioms LonelyRunner.foldedPairSafeBands_of_five_sixths_pair_bound
#print axioms LonelyRunner.exists_two_same_side_of_three
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

REPORT = Path('research/astra-pairbands-pigeonhole-source-review.md')
EXPECTED = {
    "LonelyRunner/AnchoredPairSafeBands.lean": "14212e32cdd3a343b286dd0fc370cefa6c33c145541f61afdf42e8e5290bc306",
    ".lake/build/lib/lean/LonelyRunner/AnchoredPairSafeBands.olean": "1457a21fc39aa4ad489891c9b19cb8be2a74bfc9164fbccb5574c7a61b451a86",
    "LonelyRunner/ThreeLabelPigeonhole.lean": "430cb0a6e32e79f78271bea9243500125eaafb097c4099efc7a372b73f259ea3",
    ".lake/build/lib/lean/LonelyRunner/ThreeLabelPigeonhole.olean": "ea0984a008110463f9690b40b506015d515cdb3103e93d1feea5ce751885f43c",
    "LonelyRunner/AnchoredPairTransport.lean": "63414c3ccb6c12c1ed8775cb7e18dccc84c30da42cd4be089ac336df75ceca43",
    ".lake/build/lib/lean/LonelyRunner/AnchoredPairTransport.olean": "5254122c6d4ab3e583adf5676fe05aa7268dfa3412e2aee7889fbacc3832a07e",
    "LonelyRunner/FoldedPairSafeBands.lean": "00903bcb0c131fdb31ab87d55cea809249dfacbbd5861f82ab3a987d39b74b5f",
    ".lake/build/lib/lean/LonelyRunner/FoldedPairSafeBands.olean": "d000b970290ec9072f02465f527b817f32bb72113ed7fa09bd43c9f0a47287c8",
    "LonelyRunner/TwoDivisibleFoldedBand.lean": "de4ec95f1dee0215cb0ded1092eca0147093131d2c76d6e96c1320432274e029",
    ".lake/build/lib/lean/LonelyRunner/TwoDivisibleFoldedBand.olean": "6432ad040c0145fbc6fee736d1aa4709e7b659a69c026d79f3608f87b46da21c",
    "LonelyRunner/FoldedCirclePhase.lean": "957606878108847d5ceff47be621ff0fc9c0a0d976568b5f5ef3dbb6db10481e",
    ".lake/build/lib/lean/LonelyRunner/FoldedCirclePhase.olean": "3032bbcf8e5c414daea831a7a415a40b4f254e5b72428b6fa078742e891afc06",
    "LonelyRunner/SixthAffinePhase.lean": "76e420713079ec0c3979e9b169cd78ecb6a932d6dc790ea7d9711adbb64b7d4b",
    ".lake/build/lib/lean/LonelyRunner/SixthAffinePhase.olean": "9a0cbfec2825c4b98fc7897835dc726929daabb3328a2d45818765c568cf47b3",
    "LonelyRunner/SpecialSixthPhase.lean": "677372ee3dc86520051f4bcc037f685a3f5fd8748c737ef9e1d2bfc5ac0072d8",
    ".lake/build/lib/lean/LonelyRunner/SpecialSixthPhase.olean": "2e4951ab757b0fa22574e72381abd7be6cca5c971f9e38967cf24f0991532537",
    "LonelyRunner/RationalShiftOrbits.lean": "cf615dd6c6b3cf091cd5d31ac641f4f994c1c50d95e0120c311d3ac129b88591",
    ".lake/build/lib/lean/LonelyRunner/RationalShiftOrbits.olean": "8194c5c6ac0b8495146728fcac70a6a1e9d317f9e7689c4759f22ed33c14340f",
    "LonelyRunner/FastRunnerInsertion.lean": "dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5",
    ".lake/build/lib/lean/LonelyRunner/FastRunnerInsertion.olean": "121edfbaed0d7b9fed32bacf891de838142988e48dcb4e7f2bed0c488ea49136",
    "LonelyRunner/RealPhaseBands.lean": "7f70467bad6bb5a8a859bff8947af1dc73e685910b69157b49bab259b3c02ca0",
    ".lake/build/lib/lean/LonelyRunner/RealPhaseBands.olean": "7442f9f49d9f1e2d214460557f6a891ba13717ededff679876033793ac2c6504",
    "LonelyRunner/StructuredClasses.lean": "5328a7a88d2b42f86ffc3f0f0418ca22c761219e8fa3e5822bda5a18ac286e8c",
    ".lake/build/lib/lean/LonelyRunner/StructuredClasses.olean": "4ada0ca2f0a5f20a8c83c3c2e58256e931c3b283882a88a074aeedb02d7e048f",
    ".lake/packages/mathlib/Mathlib/Tactic.lean": "c6f2c548596b635a3d5c8aff8b19cbdeb60dd54e41bb89a1cd03b1a54d335fa5",
    ".lake/packages/mathlib/.lake/build/lib/lean/Mathlib/Tactic.olean": "0534ef12e7aaf8ffbb6e520a91f922da4469d0dca2b54c87b4458e1faa28a6a2",
    ".lake/packages/mathlib/Mathlib/Data/Finset/Card.lean": "87c674ba5464c7868fb3e253e58a695821bf8841bb4e076bac5d570236dc6229",
    ".lake/packages/mathlib/.lake/build/lib/lean/Mathlib/Data/Finset/Card.olean": "44040732dc2bd596defca539de0564321aedb38782e179e9bd52f9c1d4c92a9a",
    ".lake/packages/mathlib/Mathlib/Algebra/Order/Floor/Ring.lean": "11f61aaf83c406b6b0accc6d34bdb4f77a1566fbdc63eae4d704728b9acf038c",
    ".lake/packages/mathlib/.lake/build/lib/lean/Mathlib/Algebra/Order/Floor/Ring.olean": "7321187722159060ef5bba522dcb0fa44c87cd3b6933c2cedfd27f63b35a9080",
    "lean-toolchain": "8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af",
    "lake-manifest.json": "887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218",
    "research/astra-two-divisible-three-reduction-plan.md": "07f27873785c463d7f9b2e8c2074510f42fcd973d07cc6e73ea62e5b3bac0ad6",
    "research/astra-two-divisible-three-plan-review.md": "4d499c4477e80445646c6f82fcb72e36009ed1b9fc35b0023dd278f399598f71",
    "research/astra-two-divisible-cover-contract.md": "e37d214985a28e2622c3f9615bf4354f35d9baf481adf3acf22e5b15a4ea2766",
    "research/astra-two-divisible-cover-review.md": "4b71ee4374d032c0aeed46b2b571a7f45eb4d8d0543461103341cbf89b2a29ea"
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
    "foldedPairSafeBands_of_five_sixths_pair_bound",
    "exists_two_same_side_of_three"
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

This entry runs Lean once; it is not the separate static-only preflight.
Run from /home/joshua/lonely-runner-formalization. It extracts the fixed
launcher from this report. The complete executable hashes are recorded
below before invoking this entry.

```bash
python3 -I - <<'PY'
from pathlib import Path
p = Path('research/astra-pairbands-pigeonhole-source-review.md')
s = p.read_text(encoding='utf-8')
start = '<!-- BEGIN LAUNCHER -->\n```python\n'
end = '\n```\n<!-- END LAUNCHER -->'
assert s.count(start) == 1 and s.count(end) == 1
code = s.split(start, 1)[1].split(end, 1)[0] + '\n'
exec(compile(code, str(p) + ':launcher', 'exec'))
PY
```

The supplied fiber bound and its positive smaller folded norm remain
hypotheses. This theorem does not supply a maximizing seed, establish the
pending boundary-zero cover, complete the two-divisible branch, prove a
new canonical runner count, or resolve unrestricted LRC.

## Pre-invocation static freeze

Static Python AST parsing, all 36 file guards, the two expected probe/axiom
counts, and the exact Bash-entry extraction passed before Lean execution.
Only the Bash Python prefix was evaluated for this static extraction;
its final exec call was excluded. The static command actually exited 0,
with complete stdout below and no stderr. This is not a Lean result.
The fixed executable sections and their hashes will remain unchanged.

```json
{
  "static_only": true,
  "guard_count": 36,
  "guards_match": true,
  "bash_entry_extraction_matches": true,
  "probe_bytes": 1146,
  "probe_sha256": "52886146c4394cd65d85ac85eebbddac6dec12ec7001ef25e421a9d429c00ab1",
  "launcher_bytes": 9435,
  "launcher_sha256": "273a13bae67354e75708d9cd0fe5cd88195e590c001ecdcd3e96b3786c3c2aff",
  "bash_bytes": 382,
  "bash_sha256": "e05fe3ddda9fc9e90eb0d5a77e0d11c6725f00973eb594c909951b62322c26e9",
  "lean_invocations": 0
}
```

## Actual execution and final verdict

Both exact universal type assignments elaborated, including the generic
universe and all premises. Both complete axiom reports contain only
propext, Classical.choice and Quot.sound. Accept these two frozen source
theorems at their stated conditional scope.

The single Lean child and outer Bash launcher both actually exited 0.
The capture wrapper also exited 0; outer stderr was empty. There was no
timeout, retry, extra probe, numeric experiment, or source build.
Wall time was 1.8499765219748951 seconds, child user/system CPU
1.231673/0.617852 seconds,
and Linux child peak RSS 3285900 KiB. Peak RSS is
a resident-memory measurement, separate from the 8 GiB address-space cap.
Stdout was exactly 224 bytes, stderr exactly zero.
All 36 guards and both complete executable blocks remained unchanged.

Complete human-readable child stdout, with no omitted warnings or lines:

```text
'LonelyRunner.foldedPairSafeBands_of_five_sixths_pair_bound' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.exists_two_same_side_of_three' depends on axioms: [propext, Classical.choice, Quot.sound]
```

The exact complete launcher stdout follows as JSON. It retains both full
child streams in UTF-8 and base64, their byte counts and hashes, before/after
bindings, both executable hashes, actual limits, times and exit code.
Together with the empty outer stderr and outer exit 0 above, this preserves
the full actual invocation result.

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
      "foldedPairSafeBands_of_five_sixths_pair_bound",
      "propext, Classical.choice, Quot.sound"
    ],
    [
      "exists_two_same_side_of_three",
      "propext, Classical.choice, Quot.sound"
    ]
  ],
  "axioms_ok": true,
  "capture_ok": true,
  "child_maxrss_kib": 3285900,
  "child_system_seconds": 0.617852,
  "child_user_seconds": 1.231673,
  "cwd": "/home/joshua/lonely-runner-formalization",
  "executable_unchanged": true,
  "exit_code": 0,
  "guards_after": {
    ".lake/build/lib/lean/LonelyRunner/AnchoredPairSafeBands.olean": "1457a21fc39aa4ad489891c9b19cb8be2a74bfc9164fbccb5574c7a61b451a86",
    ".lake/build/lib/lean/LonelyRunner/AnchoredPairTransport.olean": "5254122c6d4ab3e583adf5676fe05aa7268dfa3412e2aee7889fbacc3832a07e",
    ".lake/build/lib/lean/LonelyRunner/FastRunnerInsertion.olean": "121edfbaed0d7b9fed32bacf891de838142988e48dcb4e7f2bed0c488ea49136",
    ".lake/build/lib/lean/LonelyRunner/FoldedCirclePhase.olean": "3032bbcf8e5c414daea831a7a415a40b4f254e5b72428b6fa078742e891afc06",
    ".lake/build/lib/lean/LonelyRunner/FoldedPairSafeBands.olean": "d000b970290ec9072f02465f527b817f32bb72113ed7fa09bd43c9f0a47287c8",
    ".lake/build/lib/lean/LonelyRunner/RationalShiftOrbits.olean": "8194c5c6ac0b8495146728fcac70a6a1e9d317f9e7689c4759f22ed33c14340f",
    ".lake/build/lib/lean/LonelyRunner/RealPhaseBands.olean": "7442f9f49d9f1e2d214460557f6a891ba13717ededff679876033793ac2c6504",
    ".lake/build/lib/lean/LonelyRunner/SixthAffinePhase.olean": "9a0cbfec2825c4b98fc7897835dc726929daabb3328a2d45818765c568cf47b3",
    ".lake/build/lib/lean/LonelyRunner/SpecialSixthPhase.olean": "2e4951ab757b0fa22574e72381abd7be6cca5c971f9e38967cf24f0991532537",
    ".lake/build/lib/lean/LonelyRunner/StructuredClasses.olean": "4ada0ca2f0a5f20a8c83c3c2e58256e931c3b283882a88a074aeedb02d7e048f",
    ".lake/build/lib/lean/LonelyRunner/ThreeLabelPigeonhole.olean": "ea0984a008110463f9690b40b506015d515cdb3103e93d1feea5ce751885f43c",
    ".lake/build/lib/lean/LonelyRunner/TwoDivisibleFoldedBand.olean": "6432ad040c0145fbc6fee736d1aa4709e7b659a69c026d79f3608f87b46da21c",
    ".lake/packages/mathlib/.lake/build/lib/lean/Mathlib/Algebra/Order/Floor/Ring.olean": "7321187722159060ef5bba522dcb0fa44c87cd3b6933c2cedfd27f63b35a9080",
    ".lake/packages/mathlib/.lake/build/lib/lean/Mathlib/Data/Finset/Card.olean": "44040732dc2bd596defca539de0564321aedb38782e179e9bd52f9c1d4c92a9a",
    ".lake/packages/mathlib/.lake/build/lib/lean/Mathlib/Tactic.olean": "0534ef12e7aaf8ffbb6e520a91f922da4469d0dca2b54c87b4458e1faa28a6a2",
    ".lake/packages/mathlib/Mathlib/Algebra/Order/Floor/Ring.lean": "11f61aaf83c406b6b0accc6d34bdb4f77a1566fbdc63eae4d704728b9acf038c",
    ".lake/packages/mathlib/Mathlib/Data/Finset/Card.lean": "87c674ba5464c7868fb3e253e58a695821bf8841bb4e076bac5d570236dc6229",
    ".lake/packages/mathlib/Mathlib/Tactic.lean": "c6f2c548596b635a3d5c8aff8b19cbdeb60dd54e41bb89a1cd03b1a54d335fa5",
    "LonelyRunner/AnchoredPairSafeBands.lean": "14212e32cdd3a343b286dd0fc370cefa6c33c145541f61afdf42e8e5290bc306",
    "LonelyRunner/AnchoredPairTransport.lean": "63414c3ccb6c12c1ed8775cb7e18dccc84c30da42cd4be089ac336df75ceca43",
    "LonelyRunner/FastRunnerInsertion.lean": "dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5",
    "LonelyRunner/FoldedCirclePhase.lean": "957606878108847d5ceff47be621ff0fc9c0a0d976568b5f5ef3dbb6db10481e",
    "LonelyRunner/FoldedPairSafeBands.lean": "00903bcb0c131fdb31ab87d55cea809249dfacbbd5861f82ab3a987d39b74b5f",
    "LonelyRunner/RationalShiftOrbits.lean": "cf615dd6c6b3cf091cd5d31ac641f4f994c1c50d95e0120c311d3ac129b88591",
    "LonelyRunner/RealPhaseBands.lean": "7f70467bad6bb5a8a859bff8947af1dc73e685910b69157b49bab259b3c02ca0",
    "LonelyRunner/SixthAffinePhase.lean": "76e420713079ec0c3979e9b169cd78ecb6a932d6dc790ea7d9711adbb64b7d4b",
    "LonelyRunner/SpecialSixthPhase.lean": "677372ee3dc86520051f4bcc037f685a3f5fd8748c737ef9e1d2bfc5ac0072d8",
    "LonelyRunner/StructuredClasses.lean": "5328a7a88d2b42f86ffc3f0f0418ca22c761219e8fa3e5822bda5a18ac286e8c",
    "LonelyRunner/ThreeLabelPigeonhole.lean": "430cb0a6e32e79f78271bea9243500125eaafb097c4099efc7a372b73f259ea3",
    "LonelyRunner/TwoDivisibleFoldedBand.lean": "de4ec95f1dee0215cb0ded1092eca0147093131d2c76d6e96c1320432274e029",
    "lake-manifest.json": "887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218",
    "lean-toolchain": "8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af",
    "research/astra-two-divisible-cover-contract.md": "e37d214985a28e2622c3f9615bf4354f35d9baf481adf3acf22e5b15a4ea2766",
    "research/astra-two-divisible-cover-review.md": "4b71ee4374d032c0aeed46b2b571a7f45eb4d8d0543461103341cbf89b2a29ea",
    "research/astra-two-divisible-three-plan-review.md": "4d499c4477e80445646c6f82fcb72e36009ed1b9fc35b0023dd278f399598f71",
    "research/astra-two-divisible-three-reduction-plan.md": "07f27873785c463d7f9b2e8c2074510f42fcd973d07cc6e73ea62e5b3bac0ad6"
  },
  "guards_before": {
    ".lake/build/lib/lean/LonelyRunner/AnchoredPairSafeBands.olean": "1457a21fc39aa4ad489891c9b19cb8be2a74bfc9164fbccb5574c7a61b451a86",
    ".lake/build/lib/lean/LonelyRunner/AnchoredPairTransport.olean": "5254122c6d4ab3e583adf5676fe05aa7268dfa3412e2aee7889fbacc3832a07e",
    ".lake/build/lib/lean/LonelyRunner/FastRunnerInsertion.olean": "121edfbaed0d7b9fed32bacf891de838142988e48dcb4e7f2bed0c488ea49136",
    ".lake/build/lib/lean/LonelyRunner/FoldedCirclePhase.olean": "3032bbcf8e5c414daea831a7a415a40b4f254e5b72428b6fa078742e891afc06",
    ".lake/build/lib/lean/LonelyRunner/FoldedPairSafeBands.olean": "d000b970290ec9072f02465f527b817f32bb72113ed7fa09bd43c9f0a47287c8",
    ".lake/build/lib/lean/LonelyRunner/RationalShiftOrbits.olean": "8194c5c6ac0b8495146728fcac70a6a1e9d317f9e7689c4759f22ed33c14340f",
    ".lake/build/lib/lean/LonelyRunner/RealPhaseBands.olean": "7442f9f49d9f1e2d214460557f6a891ba13717ededff679876033793ac2c6504",
    ".lake/build/lib/lean/LonelyRunner/SixthAffinePhase.olean": "9a0cbfec2825c4b98fc7897835dc726929daabb3328a2d45818765c568cf47b3",
    ".lake/build/lib/lean/LonelyRunner/SpecialSixthPhase.olean": "2e4951ab757b0fa22574e72381abd7be6cca5c971f9e38967cf24f0991532537",
    ".lake/build/lib/lean/LonelyRunner/StructuredClasses.olean": "4ada0ca2f0a5f20a8c83c3c2e58256e931c3b283882a88a074aeedb02d7e048f",
    ".lake/build/lib/lean/LonelyRunner/ThreeLabelPigeonhole.olean": "ea0984a008110463f9690b40b506015d515cdb3103e93d1feea5ce751885f43c",
    ".lake/build/lib/lean/LonelyRunner/TwoDivisibleFoldedBand.olean": "6432ad040c0145fbc6fee736d1aa4709e7b659a69c026d79f3608f87b46da21c",
    ".lake/packages/mathlib/.lake/build/lib/lean/Mathlib/Algebra/Order/Floor/Ring.olean": "7321187722159060ef5bba522dcb0fa44c87cd3b6933c2cedfd27f63b35a9080",
    ".lake/packages/mathlib/.lake/build/lib/lean/Mathlib/Data/Finset/Card.olean": "44040732dc2bd596defca539de0564321aedb38782e179e9bd52f9c1d4c92a9a",
    ".lake/packages/mathlib/.lake/build/lib/lean/Mathlib/Tactic.olean": "0534ef12e7aaf8ffbb6e520a91f922da4469d0dca2b54c87b4458e1faa28a6a2",
    ".lake/packages/mathlib/Mathlib/Algebra/Order/Floor/Ring.lean": "11f61aaf83c406b6b0accc6d34bdb4f77a1566fbdc63eae4d704728b9acf038c",
    ".lake/packages/mathlib/Mathlib/Data/Finset/Card.lean": "87c674ba5464c7868fb3e253e58a695821bf8841bb4e076bac5d570236dc6229",
    ".lake/packages/mathlib/Mathlib/Tactic.lean": "c6f2c548596b635a3d5c8aff8b19cbdeb60dd54e41bb89a1cd03b1a54d335fa5",
    "LonelyRunner/AnchoredPairSafeBands.lean": "14212e32cdd3a343b286dd0fc370cefa6c33c145541f61afdf42e8e5290bc306",
    "LonelyRunner/AnchoredPairTransport.lean": "63414c3ccb6c12c1ed8775cb7e18dccc84c30da42cd4be089ac336df75ceca43",
    "LonelyRunner/FastRunnerInsertion.lean": "dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5",
    "LonelyRunner/FoldedCirclePhase.lean": "957606878108847d5ceff47be621ff0fc9c0a0d976568b5f5ef3dbb6db10481e",
    "LonelyRunner/FoldedPairSafeBands.lean": "00903bcb0c131fdb31ab87d55cea809249dfacbbd5861f82ab3a987d39b74b5f",
    "LonelyRunner/RationalShiftOrbits.lean": "cf615dd6c6b3cf091cd5d31ac641f4f994c1c50d95e0120c311d3ac129b88591",
    "LonelyRunner/RealPhaseBands.lean": "7f70467bad6bb5a8a859bff8947af1dc73e685910b69157b49bab259b3c02ca0",
    "LonelyRunner/SixthAffinePhase.lean": "76e420713079ec0c3979e9b169cd78ecb6a932d6dc790ea7d9711adbb64b7d4b",
    "LonelyRunner/SpecialSixthPhase.lean": "677372ee3dc86520051f4bcc037f685a3f5fd8748c737ef9e1d2bfc5ac0072d8",
    "LonelyRunner/StructuredClasses.lean": "5328a7a88d2b42f86ffc3f0f0418ca22c761219e8fa3e5822bda5a18ac286e8c",
    "LonelyRunner/ThreeLabelPigeonhole.lean": "430cb0a6e32e79f78271bea9243500125eaafb097c4099efc7a372b73f259ea3",
    "LonelyRunner/TwoDivisibleFoldedBand.lean": "de4ec95f1dee0215cb0ded1092eca0147093131d2c76d6e96c1320432274e029",
    "lake-manifest.json": "887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218",
    "lean-toolchain": "8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af",
    "research/astra-two-divisible-cover-contract.md": "e37d214985a28e2622c3f9615bf4354f35d9baf481adf3acf22e5b15a4ea2766",
    "research/astra-two-divisible-cover-review.md": "4b71ee4374d032c0aeed46b2b571a7f45eb4d8d0543461103341cbf89b2a29ea",
    "research/astra-two-divisible-three-plan-review.md": "4d499c4477e80445646c6f82fcb72e36009ed1b9fc35b0023dd278f399598f71",
    "research/astra-two-divisible-three-reduction-plan.md": "07f27873785c463d7f9b2e8c2074510f42fcd973d07cc6e73ea62e5b3bac0ad6"
  },
  "launcher_after_sha256": "273a13bae67354e75708d9cd0fe5cd88195e590c001ecdcd3e96b3786c3c2aff",
  "launcher_bytes": 9435,
  "launcher_sha256": "273a13bae67354e75708d9cd0fe5cd88195e590c001ecdcd3e96b3786c3c2aff",
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
  "probe_after_sha256": "52886146c4394cd65d85ac85eebbddac6dec12ec7001ef25e421a9d429c00ab1",
  "probe_bytes": 1146,
  "probe_sha256": "52886146c4394cd65d85ac85eebbddac6dec12ec7001ef25e421a9d429c00ab1",
  "runtime_env": {
    "LEAN_NUM_THREADS": "1",
    "LEAN_STACK_SIZE_KB": "65536"
  },
  "status": "passed",
  "stderr_base64": "",
  "stderr_bytes": 0,
  "stderr_sha256": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
  "stderr_utf8": "",
  "stdout_base64": "J0xvbmVseVJ1bm5lci5mb2xkZWRQYWlyU2FmZUJhbmRzX29mX2ZpdmVfc2l4dGhzX3BhaXJfYm91bmQnIGRlcGVuZHMgb24gYXhpb21zOiBbcHJvcGV4dCwgQ2xhc3NpY2FsLmNob2ljZSwgUXVvdC5zb3VuZF0KJ0xvbmVseVJ1bm5lci5leGlzdHNfdHdvX3NhbWVfc2lkZV9vZl90aHJlZScgZGVwZW5kcyBvbiBheGlvbXM6IFtwcm9wZXh0LCBDbGFzc2ljYWwuY2hvaWNlLCBRdW90LnNvdW5kXQo=",
  "stdout_bytes": 224,
  "stdout_sha256": "04d3ed6328bd0fdac67f127a72360dc615deb345c0aca0137d1a01c2a0341a99",
  "stdout_utf8": "'LonelyRunner.foldedPairSafeBands_of_five_sixths_pair_bound' depends on axioms: [propext, Classical.choice, Quot.sound]\n'LonelyRunner.exists_two_same_side_of_three' depends on axioms: [propext, Classical.choice, Quot.sound]\n",
  "timed_out": false,
  "wall_seconds": 1.8499765219748951
}
```

No remaining correction was identified within these two contracts. Root's
independent full report read and exact replay, plus its normal source build
and integration/trust checks, remain separate publication obligations.
Mathematically, establishing the maximizing seed and the boundary-zero
cover remain outside these declarations.
