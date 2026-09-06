# Independent source review: anchored pair maximum and third-shift collision

Source review date: 2026-09-06. Requested role: Astra/xhigh; the runtime does
not independently expose model/effort attestation. These are Terra-authored
proofs with root cast/elaboration corrections. This reviewer authored neither
implementation. Only this report is edited.

## Semantic verdict and frozen scope

Accept both complete source proofs against the exact universal contracts in
the probe below. No omitted hypothesis, incorrect cast, or boundary defect
was found. The import-only type/axiom probe is predeclared here before execution;
its actual receipt will be appended without altering the executable sections.

The source targets are:

- `LonelyRunner/AnchoredPairMaximizer.lean`, SHA-256
  `050888f1d9017183661dbca6e2e61bfeb518849c339bc77b43605a6b3918bdd8`.
- `LonelyRunner/ThirdShiftCollision.lean`, SHA-256
  `5b984687f89ea16bad34453d3c048ceb974f999af9cd1969f73d56ce30e13cec`.

Both were read in full. The accepted mathematical specifications are bound to
`research/astra-two-divisible-three-reduction-plan.md`, SHA
`07f27873785c463d7f9b2e8c2074510f42fcd973d07cc6e73ea62e5b3bac0ad6`,
and its independent review, SHA
`4d499c4477e80445646c6f82fcb72e36009ed1b9fc35b0023dd278f399598f71`.
The maximum matches the manuscript's exact generic contract. The collision
source isolates the generic outside-label argument: at most three labels,
two distinct labels initially bad, and all speeds nondivisible by three.

The current config, project workflow, policy, and focused state were read.
State is research/in_progress, with this task assigned at checkpoint ed5fc6a.
The startup command `python3 scripts/validate_workflow.py` actually exited 0.
Its full stdout was:

```text
workflow structural validation passed; it cannot certify mathematical validity.
```

Root separately reported a full build passing 3685 jobs and a trust audit
passing 605 dependency reports plus eight axiom-free reports. Those are root's
source-build/audit evidence, not executions performed by this reviewer.
Integration files and other workers' ongoing sources remain outside the guards.

## Independent proof audit

Write N(x)=circleNorm x, the norm of x modulo the integers.

### The fiber maximum

The theorem quantifies over every natural a,b,c with only 0<c. It requires a
witness τ strictly between zero and one, anchor fraction 5/6, and a maximum
bound against **every real** anchored time. It has no positivity assumptions
on a,b and no positive-objective or strict-seed premise.

The proof defines T(j)=(j.val+5/6)/c and
F(j)=min(N(T(j)*a),N(T(j)*b)) for j:Fin c. The finite set is nonempty using
the literal index ⟨0,hc⟩. `Finset.exists_max_image` supplies a maximizing
index without enumerating an input-dependent family in this review.
Nonnegativity of j.val and c>0 give T(j)>0.
The integer-index fact j.val+1≤c implies j.val+5/6<c, so T(j)<1 strictly.
The anchor proof uses `Int.fract_eq_iff` with the integer j.val:
T(j)*c-5/6=j.val. Both fractional endpoints, 0≤5/6<1, are explicit.

For an arbitrary real t with anchor 5/6, the proof sets s=fract t.
The bounds 0≤s<1 are unconditional; no sign restriction on t is introduced.
The existing `circleNorm_fract_mul_nat` preserves both objective norms.
For the anchor, `Int.fract_eq_fract` uses the exact integer difference

    s*c - t*c = -floor(t)*c.

The negative integer witness is retained. Thus negative times are genuinely
covered rather than excluded during normalization.

Next n=floor(s*c) is an integer. Since 0≤s*c<c, the proof obtains n≥0 from
`Int.floor_nonneg` and n<c from `Int.floor_le` and the strict bound s*c<c.
Only after n≥0 is known does it introduce q:Fin c with q.val=n.toNat.
The natural index bound follows from those integer inequalities.
`Int.toNat_of_nonneg`, cast to the reals, gives (n.toNat:ℝ)=(n:ℝ);
there is no truncation of a negative integer.

The exact decomposition floor(s*c)+fract(s*c)=s*c and the anchor equality give
s*c=n+5/6. Dividing by positive c identifies s=T(q).
The final rewriting converts the original real-time objective to F(q), and
the finite maximum inequality proves the claimed bound.

This proof covers c=1, a=0, b=0, and a=b without adding a hidden assumption.
If the objective is identically zero, the same finite maximum construction
still works; no proof step asserts that it is positive. These are scope
consequences of the universal proof, not executed numerical fixtures.
The strict bounds exclude τ=0 and τ=1 while the comparison variable t remains
unrestricted. The source does not invoke the different constrained complement
maximizer or a six-total runner theorem.

### The collision theorem

The theorem is universe-generic in ι, assumes only a Fintype instance publicly,
and permits Fintype.card ι≤3. It gives one k:Fin 3 before the universal label
quantifier. The phase function x is arbitrary real-valued, and speed values or
phases may repeat. There is no public DecidableEq, injectivity, or positivity
premise. The nondivisibility assumptions imply that none of the d_i is zero,
but no stronger speed restriction is used.

Let J={i:ι // i≠p}. Since p is absent, `Fintype.card_subtype_lt` gives
card J<card ι; combining with card ι≤3 yields card J≤2.
The library lemma only needs the omitted witness p and a finite subtype,
both supplied using local classical instances. This is a cardinality proof
about labels, not a claim that their phase or speed values differ.
The supplied p,q and hpq imply there are at least two labels when the premises
hold; no separate nonempty premise is needed.

Apply `exists_third_shift_safe_nondivisible_family` to J with restricted
x,d,hnot. It yields a single shift k safe for every retained label.
The second bad label q belongs to J using hpq.symm.
If k=0, its retained-label safety would give N(x_q)≥1/6, contradicting
the explicit strict premise N(x_q)<1/6. Therefore k≠0.
Closed equality at the selected shift is harmless.

For the removed label p, the source rebuilds the separation bound using
`circleNorm_third_shift_sub_ge` and 2*(1/6)=1/3.
The existing `circleNorm_bad_subsingleton_of_separated` says its strictly
bad shifts form a subsingleton. Its zero shift is strictly bad by hp.
If the chosen nonzero k were bad, subsingletonness would force k=0, a
contradiction. Therefore p is closed-safe at k as well.
The final i=p / i≠p split returns that same k for every label.

This implements the manuscript's collision argument by dropping one duplicate
zero-shift obstruction. It is equivalent to combining the two singleton bad
sets; it does not apply a false sum-of-three-less-than-three bound.
Both initial inequalities must remain strict. With weak badness, q would not
force k≠0 and p's boundary phase would not be in the bad set.
The stated source retains strict badness and closed safety exactly.

## Dependency interfaces and trust boundary

Direct project imports are `PivotBoundary` and `ThirdShiftExceptions`.
Their used interfaces are the all-real natural-speed fractional-time norm
identity and the universe-generic at-most-two common-shift theorem.
The latter proof and its exported spacing/subsingleton dependencies were read
at the same frozen bindings. `FastRunnerInsertion` supplies the actual norm
definition. The direct mathlib imports are `Data.Finset.Max`,
`Data.Fintype.Card`, and `Tactic`; the used fractional-part definitions and
equivalences were inspected in `Algebra.Order.Floor.Ring`.

The read source signatures include:
`Finset.exists_max_image` for a nonempty finite set in a linear order,
`Fintype.card_subtype_lt` for a subtype omitting a known element,
`Int.fract_eq_iff` with both 0≤b and b<1 and an integer difference,
and `Int.fract_eq_fract` with an integer difference witness.
All hypotheses used above agree with those actual APIs.

The launcher guards 26 paths: seven project source/olean pairs (the two
targets, both immediate project dependencies, the spacing and separated-family
dependencies, and the norm-defining source); four mathlib source/olean pairs
(the three direct imports and the floor API); two manuscript files; and the
toolchain/manifest pins. The exact hashes appear in EXPECTED below.
The pin is Lean `leanprover/lean4:v4.32.1`.

The source-to-olean correspondence is supplied by root's separate frozen-source
build evidence. This independent import check verifies the exported exact
types and their reported axioms under the frozen oleans. It is not a fresh
source build and does not hash every transitive dependency. Root imports,
audit files, state, and ongoing unrelated source work are not guarded.

## Predeclared single import probe

Exactly one direct-import Lean invocation will check two universal direct type
assignments and print the two complete theorem axiom lists. No numeric fixture,
search, solver, source build, cache change, Git action, or state edit is included.
Static source reading, file hashes, report assembly, and workflow validation are
separate bookkeeping. No theorem-display option is added.

The command is exactly
`/home/joshua/.elan/bin/lake env lean -j1 -s65536 --stdin`.
Process-local `LEAN_NUM_THREADS=1` and `LEAN_STACK_SIZE_KB=65536` are set.
Child address space is limited to 8 GiB, CPU to 59/60 seconds soft/hard,
alarm to 60 seconds, and the parent kills the process group at a 60-second
wall timeout. Each regular output capture file has a 128 KiB file-size cap;
combined stream capacity is 256 KiB. Core dumps are disabled.
The probe enters through a regular temporary stdin file, with a final newline.
Stdout and stderr are fully retained in the eventual JSON receipt as UTF-8 and
base64, byte counts, and SHA-256 hashes; temporary files are then closed.

The launcher checks every guard before and after, and compares both complete
executable sections before and after. Precondition mismatch prevents Lean
from starting. Passing requires exit 0, no timeout, complete uncapped output,
empty stderr, unchanged guards and executable sections, exactly two complete
axiom reports in order, and only propext, Classical.choice, Quot.sound.
Multiline axiom lists are captured through their closing bracket. Any actual
failure is preserved and reported; no retry or budget increase is preauthorized.

## Exact universal probe

<!-- BEGIN PROBE -->
```lean
import LonelyRunner.AnchoredPairMaximizer
import LonelyRunner.ThirdShiftCollision

open LonelyRunner
universe u

example : ∀ (a b c : ℕ), 0 < c →
    ∃ τ : ℝ, 0 < τ ∧ τ < 1 ∧
      Int.fract (τ * (c : ℝ)) = (5 : ℝ) / 6 ∧
      ∀ t : ℝ, Int.fract (t * (c : ℝ)) = (5 : ℝ) / 6 →
        min (circleNorm (t * (a : ℝ))) (circleNorm (t * (b : ℝ))) ≤
          min (circleNorm (τ * (a : ℝ))) (circleNorm (τ * (b : ℝ))) :=
  exists_five_sixths_fiber_pair_maximizer

example : ∀ {ι : Type u} [Fintype ι] (x : ι → ℝ) (d : ι → ℕ),
    (∀ i, ¬ 3 ∣ d i) → Fintype.card ι ≤ 3 →
    ∀ (p q : ι), p ≠ q →
      circleNorm (x p) < (1 : ℝ) / 6 →
      circleNorm (x q) < (1 : ℝ) / 6 →
      ∃ k : Fin 3, ∀ i,
        (1 : ℝ) / 6 ≤ circleNorm
          (x i + (k.val : ℝ) * (d i : ℝ) / 3) :=
  @exists_third_shift_safe_of_two_bad

#print axioms LonelyRunner.exists_five_sixths_fiber_pair_maximizer
#print axioms LonelyRunner.exists_third_shift_safe_of_two_bad
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

REPORT = Path('research/astra-anchored-pair-collision-source-review.md')
EXPECTED = {
    "LonelyRunner/AnchoredPairMaximizer.lean": "050888f1d9017183661dbca6e2e61bfeb518849c339bc77b43605a6b3918bdd8",
    "LonelyRunner/ThirdShiftCollision.lean": "5b984687f89ea16bad34453d3c048ceb974f999af9cd1969f73d56ce30e13cec",
    "LonelyRunner/PivotBoundary.lean": "0e56cab74d30ef8b537ed4ec24503aae875bd8aadc369d26da99ba882cc3603f",
    "LonelyRunner/ThirdShiftExceptions.lean": "85590988cd0e104dc93fd51bc79aa326fe2799974eae426b7ea3336853872073",
    "LonelyRunner/SeparatedPhaseFamily.lean": "28c5db2425eef754156e57c284959ff02da743f1fde424e053c4eae0c721b6bd",
    "LonelyRunner/ThirdShiftSpacing.lean": "146cdfd80495aced0eb93bc322559cf7e950a80b0d01534b2a57cce7129debaa",
    "LonelyRunner/FastRunnerInsertion.lean": "dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5",
    ".lake/build/lib/lean/LonelyRunner/AnchoredPairMaximizer.olean": "0e567db35d8ae412e8688f6bfacf1e2d70a30cad24fd3a3bca34575b4b101d00",
    ".lake/build/lib/lean/LonelyRunner/ThirdShiftCollision.olean": "66e46c34df46e2a5350489acb7195991b6f332820fc6ec1535f40f4f186d4ef6",
    ".lake/build/lib/lean/LonelyRunner/PivotBoundary.olean": "85bf755552cc89ea4836b653f374ea9218e2c87e43e19665f2100623f514b573",
    ".lake/build/lib/lean/LonelyRunner/ThirdShiftExceptions.olean": "d9c38deec30bda66014ed4d3e4de79fe5934f323e44e39771d353667ce47c7f9",
    ".lake/build/lib/lean/LonelyRunner/SeparatedPhaseFamily.olean": "eff265763238a85323240590e528ff8514eef2f4bdb405f0742e0f0a67f6ba41",
    ".lake/build/lib/lean/LonelyRunner/ThirdShiftSpacing.olean": "7bc4793433826271b91dd77e0eb635951c899f55acf5962b94ed3802a2b8c885",
    ".lake/build/lib/lean/LonelyRunner/FastRunnerInsertion.olean": "121edfbaed0d7b9fed32bacf891de838142988e48dcb4e7f2bed0c488ea49136",
    ".lake/packages/mathlib/Mathlib/Data/Finset/Max.lean": "6a67c04a5ad263999707cf927121c15edf11bd66f7b5b48652c0e0e660a0d58c",
    ".lake/packages/mathlib/Mathlib/Data/Fintype/Card.lean": "2307820b0dee2080bd8245e268974bd02678d76067a6efc8878d004f7b8ed774",
    ".lake/packages/mathlib/Mathlib/Tactic.lean": "c6f2c548596b635a3d5c8aff8b19cbdeb60dd54e41bb89a1cd03b1a54d335fa5",
    ".lake/packages/mathlib/Mathlib/Algebra/Order/Floor/Ring.lean": "11f61aaf83c406b6b0accc6d34bdb4f77a1566fbdc63eae4d704728b9acf038c",
    ".lake/packages/mathlib/.lake/build/lib/lean/Mathlib/Data/Finset/Max.olean": "32e6e6e25473e9a32768ef1baf1d1b3b7d72906c62261e1adec9ab1158f54e26",
    ".lake/packages/mathlib/.lake/build/lib/lean/Mathlib/Data/Fintype/Card.olean": "5574bbb259614ae208b68ffa3f0e2439d08e1316b7e1e60a42e677b4f73f9208",
    ".lake/packages/mathlib/.lake/build/lib/lean/Mathlib/Tactic.olean": "0534ef12e7aaf8ffbb6e520a91f922da4469d0dca2b54c87b4458e1faa28a6a2",
    ".lake/packages/mathlib/.lake/build/lib/lean/Mathlib/Algebra/Order/Floor/Ring.olean": "7321187722159060ef5bba522dcb0fa44c87cd3b6933c2cedfd27f63b35a9080",
    "research/astra-two-divisible-three-reduction-plan.md": "07f27873785c463d7f9b2e8c2074510f42fcd973d07cc6e73ea62e5b3bac0ad6",
    "research/astra-two-divisible-three-plan-review.md": "4d499c4477e80445646c6f82fcb72e36009ed1b9fc35b0023dd278f399598f71",
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
    "exists_five_sixths_fiber_pair_maximizer",
    "exists_third_shift_safe_of_two_bad"
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

## Single Bash replay entry

Run from `/home/joshua/lonely-runner-formalization`. This entry is used for
the initial invocation and extracts exactly the launcher above.

```bash
python3 -I - <<'PY'
from pathlib import Path
p = Path('research/astra-anchored-pair-collision-source-review.md')
s = p.read_text(encoding='utf-8')
start = '<!-- BEGIN LAUNCHER -->\n```python\n'
end = '\n```\n<!-- END LAUNCHER -->'
assert s.count(start) == 1 and s.count(end) == 1
code = s.split(start, 1)[1].split(end, 1)[0] + '\n'
exec(compile(code, str(p) + ':launcher', 'exec'))
PY
```

## Pre-invocation executable freeze

Before any Lean invocation in this review, static Python parsing/extraction
confirmed all 26 guards and the exact Bash-to-launcher extraction. The static
command exited 0 with this complete stdout:

```json
{
  "static_only": true,
  "guards_count": 26,
  "guards_match": true,
  "bash_entry_extraction_matches": true,
  "probe_bytes": 1040,
  "probe_sha256": "092cbbd77e00c21c2b73fb2aa86a8351a935c7ff8be33bc7fc5f59c44329255a",
  "launcher_bytes": 8237,
  "launcher_sha256": "6a0ce4443757c384cea24142a778d69f904bde3de88d57350aa1a44a81e10442"
}
```

These complete-section byte counts and SHA-256 hashes are predeclared before
the single Lean invocation. The executable sections will remain unchanged.

## Actual execution and final verdict

Accepted: the single import-only invocation checked both exact universal types,
and both complete axiom reports contain only propext, Classical.choice,
Quot.sound. The Lean process and outer launcher both exited 0. No failure,
timeout, retry, source build, or numerical fixture occurred in this review.

Actual elapsed wall time was 1.8497347879747394 seconds. Child user CPU
was 1.284784 seconds and child system CPU was
0.5736589999999999 seconds. Linux child peak RSS was
3283896 KiB, a resident-memory measurement distinct from the
8 GiB address-space cap. Stdout was 223 bytes; stderr was empty.
All 26 guards, the complete probe, and the complete launcher stayed unchanged.

Tool provenance: initial chunk `0e5c11`, session `68717`,
initial output empty; completion chunk `2f20ab`, actual outer exit 0.
The complete launcher stdout below is retained without truncation, including
its final newline. Lean stdout is also rendered separately for convenience;
the base64 field in the receipt fixes its exact raw bytes.

<!-- BEGIN RECEIPT -->
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
      "exists_five_sixths_fiber_pair_maximizer",
      "propext, Classical.choice, Quot.sound"
    ],
    [
      "exists_third_shift_safe_of_two_bad",
      "propext, Classical.choice, Quot.sound"
    ]
  ],
  "axioms_ok": true,
  "capture_ok": true,
  "child_maxrss_kib": 3283896,
  "child_system_seconds": 0.5736589999999999,
  "child_user_seconds": 1.284784,
  "cwd": "/home/joshua/lonely-runner-formalization",
  "executable_unchanged": true,
  "exit_code": 0,
  "guards_after": {
    ".lake/build/lib/lean/LonelyRunner/AnchoredPairMaximizer.olean": "0e567db35d8ae412e8688f6bfacf1e2d70a30cad24fd3a3bca34575b4b101d00",
    ".lake/build/lib/lean/LonelyRunner/FastRunnerInsertion.olean": "121edfbaed0d7b9fed32bacf891de838142988e48dcb4e7f2bed0c488ea49136",
    ".lake/build/lib/lean/LonelyRunner/PivotBoundary.olean": "85bf755552cc89ea4836b653f374ea9218e2c87e43e19665f2100623f514b573",
    ".lake/build/lib/lean/LonelyRunner/SeparatedPhaseFamily.olean": "eff265763238a85323240590e528ff8514eef2f4bdb405f0742e0f0a67f6ba41",
    ".lake/build/lib/lean/LonelyRunner/ThirdShiftCollision.olean": "66e46c34df46e2a5350489acb7195991b6f332820fc6ec1535f40f4f186d4ef6",
    ".lake/build/lib/lean/LonelyRunner/ThirdShiftExceptions.olean": "d9c38deec30bda66014ed4d3e4de79fe5934f323e44e39771d353667ce47c7f9",
    ".lake/build/lib/lean/LonelyRunner/ThirdShiftSpacing.olean": "7bc4793433826271b91dd77e0eb635951c899f55acf5962b94ed3802a2b8c885",
    ".lake/packages/mathlib/.lake/build/lib/lean/Mathlib/Algebra/Order/Floor/Ring.olean": "7321187722159060ef5bba522dcb0fa44c87cd3b6933c2cedfd27f63b35a9080",
    ".lake/packages/mathlib/.lake/build/lib/lean/Mathlib/Data/Finset/Max.olean": "32e6e6e25473e9a32768ef1baf1d1b3b7d72906c62261e1adec9ab1158f54e26",
    ".lake/packages/mathlib/.lake/build/lib/lean/Mathlib/Data/Fintype/Card.olean": "5574bbb259614ae208b68ffa3f0e2439d08e1316b7e1e60a42e677b4f73f9208",
    ".lake/packages/mathlib/.lake/build/lib/lean/Mathlib/Tactic.olean": "0534ef12e7aaf8ffbb6e520a91f922da4469d0dca2b54c87b4458e1faa28a6a2",
    ".lake/packages/mathlib/Mathlib/Algebra/Order/Floor/Ring.lean": "11f61aaf83c406b6b0accc6d34bdb4f77a1566fbdc63eae4d704728b9acf038c",
    ".lake/packages/mathlib/Mathlib/Data/Finset/Max.lean": "6a67c04a5ad263999707cf927121c15edf11bd66f7b5b48652c0e0e660a0d58c",
    ".lake/packages/mathlib/Mathlib/Data/Fintype/Card.lean": "2307820b0dee2080bd8245e268974bd02678d76067a6efc8878d004f7b8ed774",
    ".lake/packages/mathlib/Mathlib/Tactic.lean": "c6f2c548596b635a3d5c8aff8b19cbdeb60dd54e41bb89a1cd03b1a54d335fa5",
    "LonelyRunner/AnchoredPairMaximizer.lean": "050888f1d9017183661dbca6e2e61bfeb518849c339bc77b43605a6b3918bdd8",
    "LonelyRunner/FastRunnerInsertion.lean": "dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5",
    "LonelyRunner/PivotBoundary.lean": "0e56cab74d30ef8b537ed4ec24503aae875bd8aadc369d26da99ba882cc3603f",
    "LonelyRunner/SeparatedPhaseFamily.lean": "28c5db2425eef754156e57c284959ff02da743f1fde424e053c4eae0c721b6bd",
    "LonelyRunner/ThirdShiftCollision.lean": "5b984687f89ea16bad34453d3c048ceb974f999af9cd1969f73d56ce30e13cec",
    "LonelyRunner/ThirdShiftExceptions.lean": "85590988cd0e104dc93fd51bc79aa326fe2799974eae426b7ea3336853872073",
    "LonelyRunner/ThirdShiftSpacing.lean": "146cdfd80495aced0eb93bc322559cf7e950a80b0d01534b2a57cce7129debaa",
    "lake-manifest.json": "887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218",
    "lean-toolchain": "8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af",
    "research/astra-two-divisible-three-plan-review.md": "4d499c4477e80445646c6f82fcb72e36009ed1b9fc35b0023dd278f399598f71",
    "research/astra-two-divisible-three-reduction-plan.md": "07f27873785c463d7f9b2e8c2074510f42fcd973d07cc6e73ea62e5b3bac0ad6"
  },
  "guards_before": {
    ".lake/build/lib/lean/LonelyRunner/AnchoredPairMaximizer.olean": "0e567db35d8ae412e8688f6bfacf1e2d70a30cad24fd3a3bca34575b4b101d00",
    ".lake/build/lib/lean/LonelyRunner/FastRunnerInsertion.olean": "121edfbaed0d7b9fed32bacf891de838142988e48dcb4e7f2bed0c488ea49136",
    ".lake/build/lib/lean/LonelyRunner/PivotBoundary.olean": "85bf755552cc89ea4836b653f374ea9218e2c87e43e19665f2100623f514b573",
    ".lake/build/lib/lean/LonelyRunner/SeparatedPhaseFamily.olean": "eff265763238a85323240590e528ff8514eef2f4bdb405f0742e0f0a67f6ba41",
    ".lake/build/lib/lean/LonelyRunner/ThirdShiftCollision.olean": "66e46c34df46e2a5350489acb7195991b6f332820fc6ec1535f40f4f186d4ef6",
    ".lake/build/lib/lean/LonelyRunner/ThirdShiftExceptions.olean": "d9c38deec30bda66014ed4d3e4de79fe5934f323e44e39771d353667ce47c7f9",
    ".lake/build/lib/lean/LonelyRunner/ThirdShiftSpacing.olean": "7bc4793433826271b91dd77e0eb635951c899f55acf5962b94ed3802a2b8c885",
    ".lake/packages/mathlib/.lake/build/lib/lean/Mathlib/Algebra/Order/Floor/Ring.olean": "7321187722159060ef5bba522dcb0fa44c87cd3b6933c2cedfd27f63b35a9080",
    ".lake/packages/mathlib/.lake/build/lib/lean/Mathlib/Data/Finset/Max.olean": "32e6e6e25473e9a32768ef1baf1d1b3b7d72906c62261e1adec9ab1158f54e26",
    ".lake/packages/mathlib/.lake/build/lib/lean/Mathlib/Data/Fintype/Card.olean": "5574bbb259614ae208b68ffa3f0e2439d08e1316b7e1e60a42e677b4f73f9208",
    ".lake/packages/mathlib/.lake/build/lib/lean/Mathlib/Tactic.olean": "0534ef12e7aaf8ffbb6e520a91f922da4469d0dca2b54c87b4458e1faa28a6a2",
    ".lake/packages/mathlib/Mathlib/Algebra/Order/Floor/Ring.lean": "11f61aaf83c406b6b0accc6d34bdb4f77a1566fbdc63eae4d704728b9acf038c",
    ".lake/packages/mathlib/Mathlib/Data/Finset/Max.lean": "6a67c04a5ad263999707cf927121c15edf11bd66f7b5b48652c0e0e660a0d58c",
    ".lake/packages/mathlib/Mathlib/Data/Fintype/Card.lean": "2307820b0dee2080bd8245e268974bd02678d76067a6efc8878d004f7b8ed774",
    ".lake/packages/mathlib/Mathlib/Tactic.lean": "c6f2c548596b635a3d5c8aff8b19cbdeb60dd54e41bb89a1cd03b1a54d335fa5",
    "LonelyRunner/AnchoredPairMaximizer.lean": "050888f1d9017183661dbca6e2e61bfeb518849c339bc77b43605a6b3918bdd8",
    "LonelyRunner/FastRunnerInsertion.lean": "dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5",
    "LonelyRunner/PivotBoundary.lean": "0e56cab74d30ef8b537ed4ec24503aae875bd8aadc369d26da99ba882cc3603f",
    "LonelyRunner/SeparatedPhaseFamily.lean": "28c5db2425eef754156e57c284959ff02da743f1fde424e053c4eae0c721b6bd",
    "LonelyRunner/ThirdShiftCollision.lean": "5b984687f89ea16bad34453d3c048ceb974f999af9cd1969f73d56ce30e13cec",
    "LonelyRunner/ThirdShiftExceptions.lean": "85590988cd0e104dc93fd51bc79aa326fe2799974eae426b7ea3336853872073",
    "LonelyRunner/ThirdShiftSpacing.lean": "146cdfd80495aced0eb93bc322559cf7e950a80b0d01534b2a57cce7129debaa",
    "lake-manifest.json": "887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218",
    "lean-toolchain": "8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af",
    "research/astra-two-divisible-three-plan-review.md": "4d499c4477e80445646c6f82fcb72e36009ed1b9fc35b0023dd278f399598f71",
    "research/astra-two-divisible-three-reduction-plan.md": "07f27873785c463d7f9b2e8c2074510f42fcd973d07cc6e73ea62e5b3bac0ad6"
  },
  "launcher_after_sha256": "6a0ce4443757c384cea24142a778d69f904bde3de88d57350aa1a44a81e10442",
  "launcher_bytes": 8237,
  "launcher_sha256": "6a0ce4443757c384cea24142a778d69f904bde3de88d57350aa1a44a81e10442",
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
  "probe_after_sha256": "092cbbd77e00c21c2b73fb2aa86a8351a935c7ff8be33bc7fc5f59c44329255a",
  "probe_bytes": 1040,
  "probe_sha256": "092cbbd77e00c21c2b73fb2aa86a8351a935c7ff8be33bc7fc5f59c44329255a",
  "runtime_env": {
    "LEAN_NUM_THREADS": "1",
    "LEAN_STACK_SIZE_KB": "65536"
  },
  "status": "passed",
  "stderr_base64": "",
  "stderr_bytes": 0,
  "stderr_sha256": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
  "stderr_utf8": "",
  "stdout_base64": "J0xvbmVseVJ1bm5lci5leGlzdHNfZml2ZV9zaXh0aHNfZmliZXJfcGFpcl9tYXhpbWl6ZXInIGRlcGVuZHMgb24gYXhpb21zOiBbcHJvcGV4dCwgQ2xhc3NpY2FsLmNob2ljZSwgUXVvdC5zb3VuZF0KJ0xvbmVseVJ1bm5lci5leGlzdHNfdGhpcmRfc2hpZnRfc2FmZV9vZl90d29fYmFkJyBkZXBlbmRzIG9uIGF4aW9tczogW3Byb3BleHQsIENsYXNzaWNhbC5jaG9pY2UsIFF1b3Quc291bmRdCg==",
  "stdout_bytes": 223,
  "stdout_sha256": "7e22a81e27ed59db24c33f9f9af33eb9ee7b7a7e1092ca14cbf1e955bdbdb86e",
  "stdout_utf8": "'LonelyRunner.exists_five_sixths_fiber_pair_maximizer' depends on axioms: [propext, Classical.choice, Quot.sound]\n'LonelyRunner.exists_third_shift_safe_of_two_bad' depends on axioms: [propext, Classical.choice, Quot.sound]\n",
  "timed_out": false,
  "wall_seconds": 1.8497347879747394
}
```
<!-- END RECEIPT -->

Complete Lean stdout, 223 bytes including final newline:

<!-- BEGIN STDOUT -->
```text
'LonelyRunner.exists_five_sixths_fiber_pair_maximizer' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.exists_third_shift_safe_of_two_bad' depends on axioms: [propext, Classical.choice, Quot.sound]
```
<!-- END STDOUT -->

Complete Lean stderr is the empty byte string, SHA-256
`e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.
Stdout SHA-256 is
`7e22a81e27ed59db24c33f9f9af33eb9ee7b7a7e1092ca14cbf1e955bdbdb86e`.

The maximum theorem is accepted with a,b permitted to be zero, c>0,
τ strictly in (0,1), and its bound over every real anchored comparison time.
The collision theorem is accepted for universe-generic Fintype labels of
cardinality at most three, arbitrary real phases, repeated values, and two
distinct strictly bad labels, with one common closed-safe shift.
Neither artifact completes the two-divisible branch assembly, a full
five-moving sixth-margin theorem, a canonical new runner count, H8, or the
unrestricted Lonely Runner Conjecture. Root's independent replay remains the
next verification action for this reviewed batch.

