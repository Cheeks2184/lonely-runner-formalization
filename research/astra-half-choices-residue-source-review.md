# Independent source review: half choices and sixth residues

**Accept all three exact contracts and complete frozen proofs.** No missing
essential hypothesis, changed quantifier, or mathematical defect was found.
The single predeclared import probe passed; its complete actual result is
retained at the end of this report.

Only this report is edited. Requested role is Astra/xhigh; independent
runtime model/effort attestation is unavailable. Focused state records
research/in_progress and checkpoint 1156abc. Config, workflow, policy, and
focused task state were read. The actual command
`python3 scripts/validate_workflow.py` exited 0, with complete stdout:

```text
workflow structural validation passed; it cannot certify mathematical validity.
```

## Frozen source and exact scopes

| Source, under LonelyRunner/ | SHA-256 |
| --- | --- |
| SixthAffineFoldedNorm.lean | 4ce24ac7955800ccc5ff5220de83d1972bb624d9e9b7e29237ac84874bd5396d |
| TwoPhaseHalfChoices.lean | cb5c23225a130c8613c1897a749eaa7834c14b3de504ae8b51f1744c53624acc |
| ThreeResidueModSix.lean | 5df5d3b25175ea631032a8acd567449442ec4d6e56408ab271d6601dec527dfa |

This reviewer authored none of the target source files. All three complete
proofs were read, along with the needed folded-circle, half-complement,
strict doubled-half, integer-periodicity and band interfaces.

The first contract quantifies over arbitrary real t, natural d,n, and
arbitrary signed integers β,z,ε. Its sole premise is the actual integer
equality d=6z+3ε. It does not restrict ε to 0 or 1 or require positive
t,d,n. The conclusion is an exact circle-norm equality under an integral
half-shift. Its complete type below retains the natural multiplier n;
it makes no claim for arbitrary nonintegral multipliers.

The second contract is unconditional for **any two real phases** x,y.
It asserts one of three paired conjunctions, with the same transformation
applied to both phases: identity, translation by 1/2, or doubling followed
by translation by 1/2. It is not a pair of independently chosen alternatives.
All six output inequalities have the closed threshold 1/6.

The third contract assumes only natural d with 3∣d. Its one existential
pair z,ε simultaneously satisfies the integer decomposition, ε∈{0,1},
and 6∣d iff ε=0. It does not assume d positive. The exact full
universal assignments below retain all of these quantifiers and conjuncts.

## Complete proof review

**Sixth-affine folded norm.** The first source step casts the supplied
integer equality to ℝ. After distributing the affine time product,
the extra term is βd/6=βz+βε/2, so the source establishes

    ((n·t)+β/6)·d = (βz : ℤ) + (n·(t·d)+(βε : ℤ)/2),

with the integer terms explicitly cast into ℝ. The products βz and βε
are integral before casting; ring normalization and the cast equality
justify the displayed identity for negative as well as positive inputs.
The integer shift βz is removed by `circleNorm_add_int`.
Then `circleNorm_nat_mul_add_int_half` is applied to phase td,
natural multiplier n, and integer half-shift coefficient βε.

That dependency uses the nearest-integer lift with either orientation:
td=r+N(td) or td=r−N(td). In the second orientation, changing
n(td)+m/2 to its folded expression changes sign and adds the integer
nr+m. Evenness and integer periodicity preserve the norm. Thus the
current source does not mistakenly treat a negative residual as the
positive folded norm without compensating its half-shift. No fractional
interval assumption, chosen sign, positivity, or boundary tie restriction
is needed. Cases n=0 or d=0 remain legitimate under the same supplied
decomposition; arbitrary signed β,z,ε cause no additional obligation.
The theorem is an identity, not a numerical distance lower bound.

**Two common half choices.** The source's outer split tests closed safety
of x. If x and y are both originally safe, the first disjunct is returned.
When x is safe and y is bad, N(y)<1/6 follows by order negation and
`circleNorm_add_half` gives N(y+1/2)=1/2−N(y)>1/3,
hence the weak safety needed for the second choice. If x+1/2 is also
safe, both translated phases form the second disjunct.

Otherwise x+1/2 and y are both strictly bad. The dependency
`circleNorm_double_half_gt_of_small` applied to those two inputs
gives strict safety of their doubled half translates. The first one is

    2(x+1/2)+1/2 = 1 + (2x+1/2).

The source supplies this ring identity, removes the one full turn, and
pairs the resulting safety of 2x+1/2 with that of 2y+1/2.
It weakens both strict bounds only when constructing the final closed
third disjunct.

If x itself is bad, x+1/2 is safe by the same complement identity.
The code then tests y+1/2. If safe, it returns the common half-translation.
If bad, apply the strict doubled-half lemma to x and y+1/2; remove
the extra full turn from the latter. Again both components belong to
the same third transformation. These branches exhaust all real x,y.

The doubled-half dependency folds any phase with norm r<1/6, where
0≤r, to 2r+1/2 in [1/2,5/6). This interval lies strictly inside
the sixth-safe integer band, including r=0, so the strict conclusion
used above is valid. The actual source obtains it from the generic
strict band lemma. All equality cases N(x)=1/6 or N(x+1/2)=1/6
go to a safe branch; none are incorrectly made strictly bad.
Zero phases, negative phases, repeated phases x=y, and half-integer
ties are covered by the same proof. This supplies no chosen physical
time or speed hypothesis; any later time application must supply its
own phase identities and other runners' bounds.

**Natural three-residue classification.** The source first splits on 6∣d.
In the true branch a natural quotient witness k with d=6k is extracted.
It returns integer z=k and ε=0; cast simplification proves the decomposition.
For the reverse implication of the final iff the original divisibility
witness is reconstructed as ⟨k,hk⟩. It does not attempt to use a
hypothesis already consumed by destructuring. This branch includes d=0.

In the false branch it extracts a natural k with d=3k. If k%2=0,
the natural quotient k/2 would give d=6(k/2), contradicting 6∤d.
Thus k%2≠0. Together with k%2<2 this gives k%2=1. Natural
Euclidean division then yields

    d = 6·(k/2) + 3.

The source proves that identity in ℕ, using the decomposition d=3k
and the remainder fact. Only afterward does `exact_mod_cast` transfer
it into the required ℤ equality, with
z=((k/2 : ℕ) : ℤ) and ε=1. Consequently it neither rewrites d
globally inside a quotient nor swaps natural division with an
unjustified integer/real quotient operation. The ε alternative is
explicit. In the final iff, a putative 6∣d contradicts the branch
hypothesis; a putative ε=0 contradicts 1≠0. Both directions use
the same returned pair. No enumeration of speeds or computational
certificate is involved; omega discharges symbolic natural arithmetic.

The code uses ε=0/1 when constructing this classification, while the
first theorem deliberately permits any supplied signed ε. These two
interfaces therefore compose without weakening either.

## Provenance and verification boundary

The historical root Pass51 JSON records focused successful builds at
these exact target hashes: folded norm 3001 jobs, half choices 3003,
and residue classification 2997, each exit 0. The first two Terra drafts
passed unchanged after root's source read. The same JSON preserves an
earlier residue compilation failure, exit 1, followed by the witness,
quotient-cast, and rewrite corrections described above. Those historical
root executions are not new runs of this independent review.

The launcher contains 20 literal guards: eight project source/olean
pairs covering the targets, direct imports and relevant norm/band
dependencies; Mathlib.Tactic source/olean; and both dependency pins.
All current target hashes match the assigned frozen values.
This import-only probe checks exported types and full transitive axiom
reports under those oleans. Root's focused builds provide the separate
source-to-olean correspondence. This is not a hash audit of every
transitive import. Root integration, audit, mutable verification JSON,
state, and concurrent assembly work are outside the guard set.

## Predeclared one-run protocol

Exactly three complete universal type assignments and three complete
axiom prints, importing only the three target modules directly.
No extra probe, display option, source build, numeric fixture, search,
cache operation, Git/state change, or retry.

Child argv:
`/home/joshua/.elan/bin/lake env lean -j1 -s65536 --stdin`.
Process-local LEAN_NUM_THREADS=1 and LEAN_STACK_SIZE_KB=65536.
Limits: 8 GiB address space; CPU soft/hard 59/60 seconds; 60-second
child alarm; parent process-group kill at 60 seconds wall time;
disabled core dumps; 128 KiB per output file. Stdin and both streams
are regular anonymous temporary files. Complete streams are retained
in UTF-8/base64 with byte counts and SHA-256 hashes.

Passing requires exit 0, no timeout, uncapped capture, empty stderr,
unchanged guard/probe/launcher bytes, exactly three full axiom reports
in the declared order, and only propext, Classical.choice, Quot.sound.
A failed check is reported and retained without retry.

## Exact universal probe

<!-- BEGIN PROBE -->
```lean
import LonelyRunner.SixthAffineFoldedNorm
import LonelyRunner.TwoPhaseHalfChoices
import LonelyRunner.ThreeResidueModSix

open LonelyRunner

example : ∀ (t : ℝ) (d n : ℕ) (β z ε : ℤ),
    (d : ℤ) = 6 * z + 3 * ε →
    circleNorm (((n : ℝ) * t + (β : ℝ) / 6) * (d : ℝ)) =
      circleNorm ((n : ℝ) * circleNorm (t * (d : ℝ)) +
        ((β * ε : ℤ) : ℝ) / 2) :=
  circleNorm_sixth_affine_of_three_residue

example : ∀ (x y : ℝ),
    ((1 : ℝ) / 6 ≤ circleNorm x ∧ (1 : ℝ) / 6 ≤ circleNorm y) ∨
      (((1 : ℝ) / 6 ≤ circleNorm (x + 1 / 2) ∧
          (1 : ℝ) / 6 ≤ circleNorm (y + 1 / 2)) ∨
        ((1 : ℝ) / 6 ≤ circleNorm (2 * x + 1 / 2) ∧
          (1 : ℝ) / 6 ≤ circleNorm (2 * y + 1 / 2))) :=
  two_phase_half_choices

example : ∀ (d : ℕ), 3 ∣ d →
    ∃ z ε : ℤ, (d : ℤ) = 6 * z + 3 * ε ∧
      (ε = 0 ∨ ε = 1) ∧ (6 ∣ d ↔ ε = 0) :=
  exists_three_residue_mod_six

#print axioms LonelyRunner.circleNorm_sixth_affine_of_three_residue
#print axioms LonelyRunner.two_phase_half_choices
#print axioms LonelyRunner.exists_three_residue_mod_six
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

REPORT = Path('research/astra-half-choices-residue-source-review.md')
EXPECTED = {
    "LonelyRunner/SixthAffineFoldedNorm.lean": "4ce24ac7955800ccc5ff5220de83d1972bb624d9e9b7e29237ac84874bd5396d",
    ".lake/build/lib/lean/LonelyRunner/SixthAffineFoldedNorm.olean": "3cf896c376526144d1a3a9dd6d7584f9ca433e8a9b0afa073a3b4f3aab4bd91f",
    "LonelyRunner/TwoPhaseHalfChoices.lean": "cb5c23225a130c8613c1897a749eaa7834c14b3de504ae8b51f1744c53624acc",
    ".lake/build/lib/lean/LonelyRunner/TwoPhaseHalfChoices.olean": "13bc283e5024b6af7d999c107a03ccca7ddf387ddb0c522cefd058a422b13517",
    "LonelyRunner/ThreeResidueModSix.lean": "5df5d3b25175ea631032a8acd567449442ec4d6e56408ab271d6601dec527dfa",
    ".lake/build/lib/lean/LonelyRunner/ThreeResidueModSix.olean": "e0715460b7e829aaf6dd86bb477842d229e9c0f71caa2094116b127be56d38ea",
    "LonelyRunner/FoldedCirclePhase.lean": "957606878108847d5ceff47be621ff0fc9c0a0d976568b5f5ef3dbb6db10481e",
    ".lake/build/lib/lean/LonelyRunner/FoldedCirclePhase.olean": "3032bbcf8e5c414daea831a7a415a40b4f254e5b72428b6fa078742e891afc06",
    "LonelyRunner/FoldedPairSafeBands.lean": "00903bcb0c131fdb31ab87d55cea809249dfacbbd5861f82ab3a987d39b74b5f",
    ".lake/build/lib/lean/LonelyRunner/FoldedPairSafeBands.olean": "d000b970290ec9072f02465f527b817f32bb72113ed7fa09bd43c9f0a47287c8",
    "LonelyRunner/FastRunnerInsertion.lean": "dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5",
    ".lake/build/lib/lean/LonelyRunner/FastRunnerInsertion.olean": "121edfbaed0d7b9fed32bacf891de838142988e48dcb4e7f2bed0c488ea49136",
    "LonelyRunner/StructuredClasses.lean": "5328a7a88d2b42f86ffc3f0f0418ca22c761219e8fa3e5822bda5a18ac286e8c",
    ".lake/build/lib/lean/LonelyRunner/StructuredClasses.olean": "4ada0ca2f0a5f20a8c83c3c2e58256e931c3b283882a88a074aeedb02d7e048f",
    "LonelyRunner/RealPhaseBands.lean": "7f70467bad6bb5a8a859bff8947af1dc73e685910b69157b49bab259b3c02ca0",
    ".lake/build/lib/lean/LonelyRunner/RealPhaseBands.olean": "7442f9f49d9f1e2d214460557f6a891ba13717ededff679876033793ac2c6504",
    ".lake/packages/mathlib/Mathlib/Tactic.lean": "c6f2c548596b635a3d5c8aff8b19cbdeb60dd54e41bb89a1cd03b1a54d335fa5",
    ".lake/packages/mathlib/.lake/build/lib/lean/Mathlib/Tactic.olean": "0534ef12e7aaf8ffbb6e520a91f922da4469d0dca2b54c87b4458e1faa28a6a2",
    "lean-toolchain": "8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af",
    "lake-manifest.json": "887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218"
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
    "circleNorm_sixth_affine_of_three_residue",
    "two_phase_half_choices",
    "exists_three_residue_mod_six"
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
the fixed Lean probe once and is distinct from the static preflight.

```bash
python3 -I - <<'PY'
from pathlib import Path
p = Path('research/astra-half-choices-residue-source-review.md')
s = p.read_text(encoding='utf-8')
start = '<!-- BEGIN LAUNCHER -->\n```python\n'
end = '\n```\n<!-- END LAUNCHER -->'
assert s.count(start) == 1 and s.count(end) == 1
code = s.split(start, 1)[1].split(end, 1)[0] + '\n'
exec(compile(code, str(p) + ':launcher', 'exec'))
PY
```

These three reusable declarations do not establish a full five-speed
witness, any particular speed's lower bound from the affine identity
alone, a boundary-zero cover, a new canonical runner count, or LRC.
The larger boundary assembly is a separate task.

## Pre-invocation static freeze

Static AST parsing, all 20 hashes, the three universal assignment/axiom
print counts, and the exact Bash-to-launcher extraction passed before
Lean execution. Only the Bash Python prefix was evaluated, excluding
its final exec. The static command actually exited 0 with complete stdout
below and empty stderr. These executable hashes precede the sole
authorized invocation; both executable sections are now fixed.

```json
{
  "static_only": true,
  "guard_count": 20,
  "guards_match": true,
  "bash_entry_extraction_matches": true,
  "probe_bytes": 1140,
  "probe_sha256": "f7d738400408eebc465e8c50c37c88ba28727d63ddeb1286a85cb3eb65494f3a",
  "launcher_bytes": 7396,
  "launcher_sha256": "16056c472ff7d30cd241c896d54af02b52a7b5f2198912f3b1eef687d95ed091",
  "bash_bytes": 382,
  "bash_sha256": "bc1b4f5911269e93bad99673cf1ac8fff2fe57b224c91f5f06408e48d618792a",
  "lean_invocations": 0
}
```

## Actual execution and final verdict

The three complete universal assignments elaborated at the frozen imports.
All complete axiom reports are within the permitted set. The affine and
two-phase theorems use propext, Classical.choice, Quot.sound; the residue
theorem uses only propext and Quot.sound. Accept all three frozen source
contracts at the scopes stated above.

The single Lean child, outer Bash launcher, and capture wrapper each
actually exited 0. Outer stderr was empty. No timeout, retry, extra
probe, numerical experiment, source build or changed executable occurred.
Wall time was 1.8500455870234873 seconds, child user/system CPU
1.262524/0.579175 seconds, and Linux child
peak RSS 3283440 KiB. Peak RSS measures resident memory,
separately from the 8 GiB address-space cap. Complete stdout was
297 bytes; stderr was zero bytes. All 20 guards and both
complete executable sections were unchanged.

Complete child stdout, without omitted lines:

```text
'LonelyRunner.circleNorm_sixth_affine_of_three_residue' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.two_phase_half_choices' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.exists_three_residue_mod_six' depends on axioms: [propext, Quot.sound]
```

The exact complete launcher stdout follows. It preserves the full child
streams as UTF-8/base64, their byte counts and hashes, actual limits,
resource measurements, before/after guards and both executable hashes.
The outer exit 0 and empty outer stderr above complete the invocation
provenance.

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
      "circleNorm_sixth_affine_of_three_residue",
      "propext, Classical.choice, Quot.sound"
    ],
    [
      "two_phase_half_choices",
      "propext, Classical.choice, Quot.sound"
    ],
    [
      "exists_three_residue_mod_six",
      "propext, Quot.sound"
    ]
  ],
  "axioms_ok": true,
  "capture_ok": true,
  "child_maxrss_kib": 3283440,
  "child_system_seconds": 0.579175,
  "child_user_seconds": 1.262524,
  "cwd": "/home/joshua/lonely-runner-formalization",
  "executable_unchanged": true,
  "exit_code": 0,
  "guards_after": {
    ".lake/build/lib/lean/LonelyRunner/FastRunnerInsertion.olean": "121edfbaed0d7b9fed32bacf891de838142988e48dcb4e7f2bed0c488ea49136",
    ".lake/build/lib/lean/LonelyRunner/FoldedCirclePhase.olean": "3032bbcf8e5c414daea831a7a415a40b4f254e5b72428b6fa078742e891afc06",
    ".lake/build/lib/lean/LonelyRunner/FoldedPairSafeBands.olean": "d000b970290ec9072f02465f527b817f32bb72113ed7fa09bd43c9f0a47287c8",
    ".lake/build/lib/lean/LonelyRunner/RealPhaseBands.olean": "7442f9f49d9f1e2d214460557f6a891ba13717ededff679876033793ac2c6504",
    ".lake/build/lib/lean/LonelyRunner/SixthAffineFoldedNorm.olean": "3cf896c376526144d1a3a9dd6d7584f9ca433e8a9b0afa073a3b4f3aab4bd91f",
    ".lake/build/lib/lean/LonelyRunner/StructuredClasses.olean": "4ada0ca2f0a5f20a8c83c3c2e58256e931c3b283882a88a074aeedb02d7e048f",
    ".lake/build/lib/lean/LonelyRunner/ThreeResidueModSix.olean": "e0715460b7e829aaf6dd86bb477842d229e9c0f71caa2094116b127be56d38ea",
    ".lake/build/lib/lean/LonelyRunner/TwoPhaseHalfChoices.olean": "13bc283e5024b6af7d999c107a03ccca7ddf387ddb0c522cefd058a422b13517",
    ".lake/packages/mathlib/.lake/build/lib/lean/Mathlib/Tactic.olean": "0534ef12e7aaf8ffbb6e520a91f922da4469d0dca2b54c87b4458e1faa28a6a2",
    ".lake/packages/mathlib/Mathlib/Tactic.lean": "c6f2c548596b635a3d5c8aff8b19cbdeb60dd54e41bb89a1cd03b1a54d335fa5",
    "LonelyRunner/FastRunnerInsertion.lean": "dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5",
    "LonelyRunner/FoldedCirclePhase.lean": "957606878108847d5ceff47be621ff0fc9c0a0d976568b5f5ef3dbb6db10481e",
    "LonelyRunner/FoldedPairSafeBands.lean": "00903bcb0c131fdb31ab87d55cea809249dfacbbd5861f82ab3a987d39b74b5f",
    "LonelyRunner/RealPhaseBands.lean": "7f70467bad6bb5a8a859bff8947af1dc73e685910b69157b49bab259b3c02ca0",
    "LonelyRunner/SixthAffineFoldedNorm.lean": "4ce24ac7955800ccc5ff5220de83d1972bb624d9e9b7e29237ac84874bd5396d",
    "LonelyRunner/StructuredClasses.lean": "5328a7a88d2b42f86ffc3f0f0418ca22c761219e8fa3e5822bda5a18ac286e8c",
    "LonelyRunner/ThreeResidueModSix.lean": "5df5d3b25175ea631032a8acd567449442ec4d6e56408ab271d6601dec527dfa",
    "LonelyRunner/TwoPhaseHalfChoices.lean": "cb5c23225a130c8613c1897a749eaa7834c14b3de504ae8b51f1744c53624acc",
    "lake-manifest.json": "887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218",
    "lean-toolchain": "8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af"
  },
  "guards_before": {
    ".lake/build/lib/lean/LonelyRunner/FastRunnerInsertion.olean": "121edfbaed0d7b9fed32bacf891de838142988e48dcb4e7f2bed0c488ea49136",
    ".lake/build/lib/lean/LonelyRunner/FoldedCirclePhase.olean": "3032bbcf8e5c414daea831a7a415a40b4f254e5b72428b6fa078742e891afc06",
    ".lake/build/lib/lean/LonelyRunner/FoldedPairSafeBands.olean": "d000b970290ec9072f02465f527b817f32bb72113ed7fa09bd43c9f0a47287c8",
    ".lake/build/lib/lean/LonelyRunner/RealPhaseBands.olean": "7442f9f49d9f1e2d214460557f6a891ba13717ededff679876033793ac2c6504",
    ".lake/build/lib/lean/LonelyRunner/SixthAffineFoldedNorm.olean": "3cf896c376526144d1a3a9dd6d7584f9ca433e8a9b0afa073a3b4f3aab4bd91f",
    ".lake/build/lib/lean/LonelyRunner/StructuredClasses.olean": "4ada0ca2f0a5f20a8c83c3c2e58256e931c3b283882a88a074aeedb02d7e048f",
    ".lake/build/lib/lean/LonelyRunner/ThreeResidueModSix.olean": "e0715460b7e829aaf6dd86bb477842d229e9c0f71caa2094116b127be56d38ea",
    ".lake/build/lib/lean/LonelyRunner/TwoPhaseHalfChoices.olean": "13bc283e5024b6af7d999c107a03ccca7ddf387ddb0c522cefd058a422b13517",
    ".lake/packages/mathlib/.lake/build/lib/lean/Mathlib/Tactic.olean": "0534ef12e7aaf8ffbb6e520a91f922da4469d0dca2b54c87b4458e1faa28a6a2",
    ".lake/packages/mathlib/Mathlib/Tactic.lean": "c6f2c548596b635a3d5c8aff8b19cbdeb60dd54e41bb89a1cd03b1a54d335fa5",
    "LonelyRunner/FastRunnerInsertion.lean": "dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5",
    "LonelyRunner/FoldedCirclePhase.lean": "957606878108847d5ceff47be621ff0fc9c0a0d976568b5f5ef3dbb6db10481e",
    "LonelyRunner/FoldedPairSafeBands.lean": "00903bcb0c131fdb31ab87d55cea809249dfacbbd5861f82ab3a987d39b74b5f",
    "LonelyRunner/RealPhaseBands.lean": "7f70467bad6bb5a8a859bff8947af1dc73e685910b69157b49bab259b3c02ca0",
    "LonelyRunner/SixthAffineFoldedNorm.lean": "4ce24ac7955800ccc5ff5220de83d1972bb624d9e9b7e29237ac84874bd5396d",
    "LonelyRunner/StructuredClasses.lean": "5328a7a88d2b42f86ffc3f0f0418ca22c761219e8fa3e5822bda5a18ac286e8c",
    "LonelyRunner/ThreeResidueModSix.lean": "5df5d3b25175ea631032a8acd567449442ec4d6e56408ab271d6601dec527dfa",
    "LonelyRunner/TwoPhaseHalfChoices.lean": "cb5c23225a130c8613c1897a749eaa7834c14b3de504ae8b51f1744c53624acc",
    "lake-manifest.json": "887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218",
    "lean-toolchain": "8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af"
  },
  "launcher_after_sha256": "16056c472ff7d30cd241c896d54af02b52a7b5f2198912f3b1eef687d95ed091",
  "launcher_bytes": 7396,
  "launcher_sha256": "16056c472ff7d30cd241c896d54af02b52a7b5f2198912f3b1eef687d95ed091",
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
  "probe_after_sha256": "f7d738400408eebc465e8c50c37c88ba28727d63ddeb1286a85cb3eb65494f3a",
  "probe_bytes": 1140,
  "probe_sha256": "f7d738400408eebc465e8c50c37c88ba28727d63ddeb1286a85cb3eb65494f3a",
  "runtime_env": {
    "LEAN_NUM_THREADS": "1",
    "LEAN_STACK_SIZE_KB": "65536"
  },
  "status": "passed",
  "stderr_base64": "",
  "stderr_bytes": 0,
  "stderr_sha256": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
  "stderr_utf8": "",
  "stdout_base64": "J0xvbmVseVJ1bm5lci5jaXJjbGVOb3JtX3NpeHRoX2FmZmluZV9vZl90aHJlZV9yZXNpZHVlJyBkZXBlbmRzIG9uIGF4aW9tczogW3Byb3BleHQsIENsYXNzaWNhbC5jaG9pY2UsIFF1b3Quc291bmRdCidMb25lbHlSdW5uZXIudHdvX3BoYXNlX2hhbGZfY2hvaWNlcycgZGVwZW5kcyBvbiBheGlvbXM6IFtwcm9wZXh0LCBDbGFzc2ljYWwuY2hvaWNlLCBRdW90LnNvdW5kXQonTG9uZWx5UnVubmVyLmV4aXN0c190aHJlZV9yZXNpZHVlX21vZF9zaXgnIGRlcGVuZHMgb24gYXhpb21zOiBbcHJvcGV4dCwgUXVvdC5zb3VuZF0K",
  "stdout_bytes": 297,
  "stdout_sha256": "337911c23b62e9f6144cd40d690e3961399f69a2ee3fd735824f4a868c84bdfd",
  "stdout_utf8": "'LonelyRunner.circleNorm_sixth_affine_of_three_residue' depends on axioms: [propext, Classical.choice, Quot.sound]\n'LonelyRunner.two_phase_half_choices' depends on axioms: [propext, Classical.choice, Quot.sound]\n'LonelyRunner.exists_three_residue_mod_six' depends on axioms: [propext, Quot.sound]\n",
  "timed_out": false,
  "wall_seconds": 1.8500455870234873
}
```

No correction remains within the three reviewed contracts. Root's full
report read, exact replay, and normal integration/build/trust checks are
separate publication steps. Supplying the remaining runner bounds and
boundary-assembly argument remains outside this batch.
