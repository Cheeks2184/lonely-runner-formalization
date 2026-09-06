# Independent source review: third shifts and three-divisible runners

Review date: 2026-09-06. Requested role: Astra/xhigh independent semantic review;
the runtime does not independently expose model/effort attestation. The reviewer
authored the original mathematical plan, but authored none of these five Lean
implementations (Terra implementations with root elaboration corrections).

## Scope and initial semantic verdict

All seven complete proofs preserve the accepted contracts. The exact universal
contracts are the seven direct type assignments in the frozen probe below.
The source review accepts them; the separately capped import probe is predeclared
below, and its actual result will be appended without changing the executable
sections. This is a restricted positive five-moving-speed branch with threshold
1/6, not a proof for unrestricted five moving speeds or the full conjecture.

Read the current project config, workflow, policy, and focused state; the state
has research/in_progress and assigns this report at checkpoint 01e34de.
`python3 scripts/validate_workflow.py` actually returned exit 0 with the full
stdout `workflow structural validation passed; it cannot certify mathematical validity.`
followed by a newline. It also passed after context compaction. State is
orchestrator-owned. Only this report is written by this review.

The five source hashes were checked against the current
`research/astra-pass46-verification.json`. Its compiler corrections and earlier
failed draft commands are historical root evidence, not executions by this
review. Root separately reported its final full build passed 3682 jobs.
This review neither rebuilds sources nor claims that separate build as its own.
The accepted plan is SHA e4d53b08ebfeb49ec31a7a6245bdb870795f31dc8831f326cba8005cc9cf03bc;
its independent review is SHA 981748f0e5377735fdd43c3109c7011b33ea7a0d75272e9e371aedb443229eb9.
Both documents and all five final source proofs were read.

## Independent derivation and source audit

Write N(x) for `circleNorm x`, the norm of the image of x in the unit quotient
circle. All thresholds in this review are closed in the final conclusions.

1. `circleNorm_sub_le_add` unfolds N, identifies the image of x-y with the
   difference of the two images using `AddCircle.coe_sub`, and applies
   `norm_sub_le`. It holds for arbitrary real x,y.

2. `circleNorm_bad_subsingleton_of_separated` is universe-generic and places
   no finiteness, injectivity, or sign hypothesis on δ. If two distinct labels
   have N(f i)<δ and N(f j)<δ, the triangle inequality gives
   N(f i-f j)<2δ, contradicting the stated pairwise lower bound. For δ≤0 the
   bad set is empty by norm nonnegativity, consistently with the same proof.
   Strict badness is essential: two labels on the boundary N=δ need not coincide.
   The proof never replaces either strict inequality by a weak one.

3. `circleNorm_third_shift_sub_ge` cancels the arbitrary real phase x. For
   ordered distinct r,s in Fin 3, h=s.val-r.val satisfies 0<h<3. Thus 3 does
   not divide h. Primality of 3 and the explicit assumption 3∤d imply 3∤h*d.
   The existing small-denominator theorem with N=q=3 and a=h*d gives
   N(h*d/3)≥1/3. The natural subtraction is performed only after establishing
   r.val<s.val; `Nat.cast_sub hrs.le` therefore matches real subtraction.
   The reverse ordering is recovered by negating the phase difference and
   `circleNorm_neg`. Negative x and unreduced d are allowed; no assertion
   about nonzero residues for composite moduli is used.

4. `exists_third_shift_safe_nondivisible_family` uses the finite set R=Fin 3
   and B(i)={k∈R:N(x i+k*d i/3)<1/6}. Items 2–3 and 2*(1/6)=1/3 prove
   |B(i)|≤1. Summing over labels gives sum |B(i)|≤card ι≤2<3=|R|.
   `exists_mem_avoiding_of_sum_card_lt_card` produces one k avoiding every
   B(i); negating strict badness gives the required weak lower bounds.
   The existential k precedes the universal i. The empty Fintype is included.
   Repeated speed/phase pairs repeat a bad set; repeating only one component
   also causes no issue because the cardinal bound is proved per label.
   Classical finite sets are internal; the public type adds no DecidableEq
   or nonempty premise. Both the source and probe remain universe-generic.

5. `exists_third_shift_of_seeded_divisible` passes the subtype of the
   nondivisible labels to item 4 with phase x(i)=t₀*v(i). Its Fintype cardinal
   is exactly the filtered Finset cardinal in the hypothesis. For divisible
   labels, the existing rational-shift preservation theorem proves
   N((t₀+k/3)*v(i))=N(t₀*v(i)). For exceptional labels, distributivity gives
   the same expression as item 4. Thus the single k works for every Fin 5
   label. There is no positivity premise on t₀ or speeds. A zero divisible
   speed would make the seed hypothesis false; the theorem does not silently
   assume or derive positivity. If all five labels are divisible, it already
   requires all five to be seeded. It does not manufacture that seed.

6. `fiveMovingNaturalRunners_of_three_or_four_divisible_three` retains both
   count bounds and positivity of all five inputs. The upper bound chooses a
   nondivisible label p. The four old labels `p.succAbove j`, j∈Fin 4,
   include every divisible label, since such a label differs from p.
   The checked `fourMovingNaturalRunners` supplies t₀>0 and margin 1/5
   on all four old labels. It allows repeated speeds. The proof weakens
   1/5 to 1/6 to obtain exactly item 5's seed hypothesis.
   The filter/complement cardinal identity and the lower count bound give
   at most two exceptional labels. Item 5 then supplies k; the chosen time
   t₀+k.val/3 is positive because k.val≥0. No padding or speed scaling is
   required. The four-label theorem is the sole runner-count theorem invoked.

7. `fiveMovingNaturalRunners_of_primitive_three_divisible_three` uses
   `Finset.univ.gcd v=1` to produce a nondivisible label: otherwise
   `Finset.dvd_gcd` gives 3∣1, impossible. The divisible-label set is
   contained in the universe with this label erased, so its cardinal is at
   most four. Item 6 applies using the explicit lower count bound.
   This does not divide all five inputs by three and recursively invoke the
   target. Repeated positive speeds remain permitted under the stated gcd
   and count assumptions.

There is no semantic defect or omitted essential hypothesis. In particular,
no unqualified all-five-divisible case is accepted. These declarations contain
neither a closed-witness nonexistence premise nor a hidden reduction through the
unproved general five-moving-speed 1/6 theorem. They do not settle the remaining
six-total branches or the broader H7/H8 assembly gaps.

## Fixed dependencies and trust boundary

The actual immediate project imports, outside the five reviewed files, are
FastRunnerInsertion (definition/quotient norm), SmallDenominatorWitness (rational
phase lower bound), StructuredClasses (negation symmetry), ModularCertificates
(finite avoidance), RationalShiftOrbits (divisible-speed preservation), and
FiveRunnerOrdinary (four-moving positive 1/5 witness). Their source and olean
hashes are all guarded below. The mathlib imports are Mathlib.Tactic and
Mathlib.Algebra.GCDMonoid.Finset, pinned by the manifest and toolchain.

The dependency order is subtraction inequality → separated bad-set uniqueness;
third-shift spacing + uniqueness + finite avoidance → common exceptional shift;
common exceptional shift + divisible-speed preservation → seeded adapter;
seeded adapter + four-moving theorem → count 3-or-4 witness; finite gcd → primitive
corollary. The source/olean correspondence relies on root's separate source
build and the frozen hashes. This import-only check independently checks the
exported exact types and their reported transitive axioms under those oleans;
it is not a fresh source build or a hash guard over every transitive dependency.

## Predeclared single execution

One serial direct-import Lean invocation only, with seven universal direct type
assignments and seven complete axiom prints. No numerical fixture, family
enumeration, search, solver, source build, cache work, Git action, or state edit
is part of this review. Static report assembly, executable extraction/hashing,
source reading, and the workflow validator are separate bookkeeping.

The launcher below freezes 26 guards: five source/olean pairs, six immediate
project-dependency source/olean pairs, two accepted manuscripts, and two pins.
It checks all before and after the Lean process, and compares the complete probe
and launcher sections before and after. Root's mutable integration/verification
records are not executable guards. Lean is pinned by `lean-toolchain` to
`leanprover/lean4:v4.32.1`.

Child argv is exactly
`/home/joshua/.elan/bin/lake env lean -j1 -s65536 --stdin`.
Process-local thread count is 1 and stack setting 65536 KiB. Child address-space
limit is 8 GiB, CPU soft/hard limits 59/60 seconds, alarm 60 seconds, and parent
wall timeout 60 seconds. Each captured output file has a 128 KiB cap, total
stream budget 256 KiB; incomplete or capped output fails. Core dumps are disabled.
The source of stdin is exactly the probe section including one final newline.
Both stdout and stderr are captured to temporary files and retained completely
in the JSON receipt as UTF-8 and base64, with byte counts and SHA-256 hashes.
No output file survives except evidence inside this owned report.

A precondition mismatch exits before Lean. Any actual failure or timeout is
reported, not converted to a mathematical failure or silently retried. The pass
criterion requires exit 0, no timeout, complete capture, empty stderr, unchanged
guards/executable sections, exactly seven axiom reports in order, and no axioms
outside propext, Classical.choice, Quot.sound. Multiline axiom lists are captured
through their closing bracket.

## Exact universal probe

<!-- BEGIN PROBE -->
```lean
import LonelyRunner.SeparatedPhaseFamily
import LonelyRunner.ThirdShiftSpacing
import LonelyRunner.ThirdShiftExceptions
import LonelyRunner.ThirdShiftSeed
import LonelyRunner.ThreeDivisibleRunners

open LonelyRunner
universe u

example : ∀ (x y : ℝ),
    circleNorm (x - y) ≤ circleNorm x + circleNorm y :=
  circleNorm_sub_le_add

example : ∀ {α : Type u} (f : α → ℝ) (δ : ℝ),
    (∀ i j, i ≠ j → 2 * δ ≤ circleNorm (f i - f j)) →
    Set.Subsingleton {i : α | circleNorm (f i) < δ} :=
  @circleNorm_bad_subsingleton_of_separated

example : ∀ (x : ℝ) (d : ℕ), (¬ 3 ∣ d) →
    ∀ (k l : Fin 3), k ≠ l →
      (1 : ℝ) / 3 ≤ circleNorm
        ((x + (k.val : ℝ) * (d : ℝ) / 3) -
          (x + (l.val : ℝ) * (d : ℝ) / 3)) :=
  circleNorm_third_shift_sub_ge

example : ∀ {ι : Type u} [Fintype ι] (x : ι → ℝ) (d : ι → ℕ),
    (∀ i, ¬ 3 ∣ d i) → Fintype.card ι ≤ 2 →
    ∃ k : Fin 3, ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm
        (x i + (k.val : ℝ) * (d i : ℝ) / 3) :=
  @exists_third_shift_safe_nondivisible_family

example : ∀ (v : Fin 5 → ℕ) (t₀ : ℝ),
    (∀ i, 3 ∣ v i →
      (1 : ℝ) / 6 ≤ circleNorm (t₀ * (v i : ℝ))) →
    ((Finset.univ : Finset (Fin 5)).filter
      (fun i => ¬ 3 ∣ v i)).card ≤ 2 →
    ∃ k : Fin 3, ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm
        ((t₀ + (k.val : ℝ) / 3) * (v i : ℝ)) :=
  exists_third_shift_of_seeded_divisible

example : ∀ (v : Fin 5 → ℕ), (∀ i, 0 < v i) →
    3 ≤ ((Finset.univ : Finset (Fin 5)).filter
      (fun i => 3 ∣ v i)).card →
    ((Finset.univ : Finset (Fin 5)).filter
      (fun i => 3 ∣ v i)).card ≤ 4 →
    ∃ t : ℝ, 0 < t ∧ ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ)) :=
  fiveMovingNaturalRunners_of_three_or_four_divisible_three

example : ∀ (v : Fin 5 → ℕ), (∀ i, 0 < v i) →
    Finset.univ.gcd v = 1 →
    3 ≤ ((Finset.univ : Finset (Fin 5)).filter
      (fun i => 3 ∣ v i)).card →
    ∃ t : ℝ, 0 < t ∧ ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ)) :=
  fiveMovingNaturalRunners_of_primitive_three_divisible_three

#print axioms LonelyRunner.circleNorm_sub_le_add
#print axioms LonelyRunner.circleNorm_bad_subsingleton_of_separated
#print axioms LonelyRunner.circleNorm_third_shift_sub_ge
#print axioms LonelyRunner.exists_third_shift_safe_nondivisible_family
#print axioms LonelyRunner.exists_third_shift_of_seeded_divisible
#print axioms LonelyRunner.fiveMovingNaturalRunners_of_three_or_four_divisible_three
#print axioms LonelyRunner.fiveMovingNaturalRunners_of_primitive_three_divisible_three
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

REPORT = Path('research/astra-third-shift-source-review.md')
EXPECTED = {
    "LonelyRunner/SeparatedPhaseFamily.lean": "28c5db2425eef754156e57c284959ff02da743f1fde424e053c4eae0c721b6bd",
    "LonelyRunner/ThirdShiftSpacing.lean": "146cdfd80495aced0eb93bc322559cf7e950a80b0d01534b2a57cce7129debaa",
    "LonelyRunner/ThirdShiftExceptions.lean": "85590988cd0e104dc93fd51bc79aa326fe2799974eae426b7ea3336853872073",
    "LonelyRunner/ThirdShiftSeed.lean": "3c8b90583658df1cfdbe00e4444157e08d8ae7b4a74b986d5770e9f750429b46",
    "LonelyRunner/ThreeDivisibleRunners.lean": "614dc7bbf75143da6960d74b3eef5427ef93c9c8b3cbe51ec5cd5c6ca47376a3",
    ".lake/build/lib/lean/LonelyRunner/SeparatedPhaseFamily.olean": "eff265763238a85323240590e528ff8514eef2f4bdb405f0742e0f0a67f6ba41",
    ".lake/build/lib/lean/LonelyRunner/ThirdShiftSpacing.olean": "7bc4793433826271b91dd77e0eb635951c899f55acf5962b94ed3802a2b8c885",
    ".lake/build/lib/lean/LonelyRunner/ThirdShiftExceptions.olean": "d9c38deec30bda66014ed4d3e4de79fe5934f323e44e39771d353667ce47c7f9",
    ".lake/build/lib/lean/LonelyRunner/ThirdShiftSeed.olean": "5305c6fd2737c6a611abdb710e5e7659bdccdb35c346b7e386c0733a592686be",
    ".lake/build/lib/lean/LonelyRunner/ThreeDivisibleRunners.olean": "3420ef54c8e2a26960e7dcb8469a5083202a8ca02338978063dfa06662a14c13",
    "LonelyRunner/FastRunnerInsertion.lean": "dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5",
    "LonelyRunner/SmallDenominatorWitness.lean": "1570a359100594f4a5589588e3b32674dc2d54d60e500df1d47aca64c2faf95f",
    "LonelyRunner/StructuredClasses.lean": "5328a7a88d2b42f86ffc3f0f0418ca22c761219e8fa3e5822bda5a18ac286e8c",
    "LonelyRunner/ModularCertificates.lean": "8b7e9dc5be1236acb812607c19454fe43ecd1333145aef675e7df8e6d0c3871c",
    "LonelyRunner/RationalShiftOrbits.lean": "cf615dd6c6b3cf091cd5d31ac641f4f994c1c50d95e0120c311d3ac129b88591",
    "LonelyRunner/FiveRunnerOrdinary.lean": "662d0116f13971bce85e76c503e2f3be4fdc6291ba8113aeda43957e38354ffe",
    ".lake/build/lib/lean/LonelyRunner/FastRunnerInsertion.olean": "121edfbaed0d7b9fed32bacf891de838142988e48dcb4e7f2bed0c488ea49136",
    ".lake/build/lib/lean/LonelyRunner/SmallDenominatorWitness.olean": "c67482b37cb6a5c0d5da7fbeeb52eb5eb2c24d440553d4be22cbcf8364b28711",
    ".lake/build/lib/lean/LonelyRunner/StructuredClasses.olean": "4ada0ca2f0a5f20a8c83c3c2e58256e931c3b283882a88a074aeedb02d7e048f",
    ".lake/build/lib/lean/LonelyRunner/ModularCertificates.olean": "3fc9326cf1393d2b053c26cb27c8b6b174546cd588c7d8d4441c92dc5822f6c5",
    ".lake/build/lib/lean/LonelyRunner/RationalShiftOrbits.olean": "8194c5c6ac0b8495146728fcac70a6a1e9d317f9e7689c4759f22ed33c14340f",
    ".lake/build/lib/lean/LonelyRunner/FiveRunnerOrdinary.olean": "408abf21f2b4e3c356ae528f92762826556887d7e5068283399a79d6ca72ef31",
    "research/astra-three-divisible-shift-plan.md": "e4d53b08ebfeb49ec31a7a6245bdb870795f31dc8831f326cba8005cc9cf03bc",
    "research/astra-three-divisible-shift-plan-review.md": "981748f0e5377735fdd43c3109c7011b33ea7a0d75272e9e371aedb443229eb9",
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
    "circleNorm_sub_le_add",
    "circleNorm_bad_subsingleton_of_separated",
    "circleNorm_third_shift_sub_ge",
    "exists_third_shift_safe_nondivisible_family",
    "exists_third_shift_of_seeded_divisible",
    "fiveMovingNaturalRunners_of_three_or_four_divisible_three",
    "fiveMovingNaturalRunners_of_primitive_three_divisible_three"
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

Run from `/home/joshua/lonely-runner-formalization`. This is also the initial
execution entrypoint; it extracts and executes only the frozen launcher.

```bash
python3 -I - <<'PY'
from pathlib import Path
p = Path('research/astra-third-shift-source-review.md')
s = p.read_text(encoding='utf-8')
start = '<!-- BEGIN LAUNCHER -->\n```python\n'
end = '\n```\n<!-- END LAUNCHER -->'
assert s.count(start) == 1 and s.count(end) == 1
code = s.split(start, 1)[1].split(end, 1)[0] + '\n'
exec(compile(code, str(p) + ':launcher', 'exec'))
PY
```

## Pre-invocation freeze receipt

Before any Lean invocation, static extraction and Python syntax parsing confirmed
all 26 guards match and the single Bash entry extracts exactly the launcher below.
An initial static hash comparison caught an extra `c8` in the copied spacing-olean
guard; it was corrected to the observed frozen hash before invocation. This was
a report transcription correction, not a source change or a failed Lean run.

The final pre-invocation static command exited 0 with this complete stdout:

```json
{
  "static_only": true,
  "guards_count": 26,
  "guards_match": true,
  "bash_entry_extraction_matches": true,
  "probe_bytes": 2674,
  "probe_sha256": "62b81327c607adbcecf5ede70be0a1f292b64886862133b17aef025c8cd2b5d6",
  "launcher_bytes": 8361,
  "launcher_sha256": "fcb2f3660a0305e0949511da9615a17e7493bed1df299984fb8e8d4aadd0bf6a"
}
```

These are the executable hashes fixed before the single authorized invocation.

## Actual single-run result and final verdict

Accepted: all seven exact universal type assignments elaborated and all seven
complete axiom reports contain only propext, Classical.choice, Quot.sound.
There was exactly one Lean invocation; it returned exit 0 without a timeout.
The launcher also exited 0. Elapsed child-process wall time was
1.969869501015637 seconds, child user CPU 1.333859 seconds,
child system CPU 0.637398 seconds. Linux child peak RSS was
3647328 KiB; this is a resident-memory measurement, distinct from
the 8 GiB address-space cap. Stdout was 816 bytes and stderr was empty.
All 26 guards and both full executable sections were unchanged.

The tool started this execution as chunk `e05dcb`, session
`21607`, with no initial output; the completion chunk was
`9021ba`, actual outer exit `0`. The completion tool returned
the complete JSON below without truncation. This receipt is the raw launcher
stdout, including its closing newline. Full Lean stdout is additionally rendered
after it for readable inspection; its base64 in the receipt specifies all bytes.

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
      "circleNorm_sub_le_add",
      "propext, Classical.choice, Quot.sound"
    ],
    [
      "circleNorm_bad_subsingleton_of_separated",
      "propext, Classical.choice, Quot.sound"
    ],
    [
      "circleNorm_third_shift_sub_ge",
      "propext, Classical.choice, Quot.sound"
    ],
    [
      "exists_third_shift_safe_nondivisible_family",
      "propext, Classical.choice, Quot.sound"
    ],
    [
      "exists_third_shift_of_seeded_divisible",
      "propext, Classical.choice, Quot.sound"
    ],
    [
      "fiveMovingNaturalRunners_of_three_or_four_divisible_three",
      "propext,\n Classical.choice,\n Quot.sound"
    ],
    [
      "fiveMovingNaturalRunners_of_primitive_three_divisible_three",
      "propext,\n Classical.choice,\n Quot.sound"
    ]
  ],
  "axioms_ok": true,
  "capture_ok": true,
  "child_maxrss_kib": 3647328,
  "child_system_seconds": 0.637398,
  "child_user_seconds": 1.333859,
  "cwd": "/home/joshua/lonely-runner-formalization",
  "executable_unchanged": true,
  "exit_code": 0,
  "guards_after": {
    ".lake/build/lib/lean/LonelyRunner/FastRunnerInsertion.olean": "121edfbaed0d7b9fed32bacf891de838142988e48dcb4e7f2bed0c488ea49136",
    ".lake/build/lib/lean/LonelyRunner/FiveRunnerOrdinary.olean": "408abf21f2b4e3c356ae528f92762826556887d7e5068283399a79d6ca72ef31",
    ".lake/build/lib/lean/LonelyRunner/ModularCertificates.olean": "3fc9326cf1393d2b053c26cb27c8b6b174546cd588c7d8d4441c92dc5822f6c5",
    ".lake/build/lib/lean/LonelyRunner/RationalShiftOrbits.olean": "8194c5c6ac0b8495146728fcac70a6a1e9d317f9e7689c4759f22ed33c14340f",
    ".lake/build/lib/lean/LonelyRunner/SeparatedPhaseFamily.olean": "eff265763238a85323240590e528ff8514eef2f4bdb405f0742e0f0a67f6ba41",
    ".lake/build/lib/lean/LonelyRunner/SmallDenominatorWitness.olean": "c67482b37cb6a5c0d5da7fbeeb52eb5eb2c24d440553d4be22cbcf8364b28711",
    ".lake/build/lib/lean/LonelyRunner/StructuredClasses.olean": "4ada0ca2f0a5f20a8c83c3c2e58256e931c3b283882a88a074aeedb02d7e048f",
    ".lake/build/lib/lean/LonelyRunner/ThirdShiftExceptions.olean": "d9c38deec30bda66014ed4d3e4de79fe5934f323e44e39771d353667ce47c7f9",
    ".lake/build/lib/lean/LonelyRunner/ThirdShiftSeed.olean": "5305c6fd2737c6a611abdb710e5e7659bdccdb35c346b7e386c0733a592686be",
    ".lake/build/lib/lean/LonelyRunner/ThirdShiftSpacing.olean": "7bc4793433826271b91dd77e0eb635951c899f55acf5962b94ed3802a2b8c885",
    ".lake/build/lib/lean/LonelyRunner/ThreeDivisibleRunners.olean": "3420ef54c8e2a26960e7dcb8469a5083202a8ca02338978063dfa06662a14c13",
    "LonelyRunner/FastRunnerInsertion.lean": "dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5",
    "LonelyRunner/FiveRunnerOrdinary.lean": "662d0116f13971bce85e76c503e2f3be4fdc6291ba8113aeda43957e38354ffe",
    "LonelyRunner/ModularCertificates.lean": "8b7e9dc5be1236acb812607c19454fe43ecd1333145aef675e7df8e6d0c3871c",
    "LonelyRunner/RationalShiftOrbits.lean": "cf615dd6c6b3cf091cd5d31ac641f4f994c1c50d95e0120c311d3ac129b88591",
    "LonelyRunner/SeparatedPhaseFamily.lean": "28c5db2425eef754156e57c284959ff02da743f1fde424e053c4eae0c721b6bd",
    "LonelyRunner/SmallDenominatorWitness.lean": "1570a359100594f4a5589588e3b32674dc2d54d60e500df1d47aca64c2faf95f",
    "LonelyRunner/StructuredClasses.lean": "5328a7a88d2b42f86ffc3f0f0418ca22c761219e8fa3e5822bda5a18ac286e8c",
    "LonelyRunner/ThirdShiftExceptions.lean": "85590988cd0e104dc93fd51bc79aa326fe2799974eae426b7ea3336853872073",
    "LonelyRunner/ThirdShiftSeed.lean": "3c8b90583658df1cfdbe00e4444157e08d8ae7b4a74b986d5770e9f750429b46",
    "LonelyRunner/ThirdShiftSpacing.lean": "146cdfd80495aced0eb93bc322559cf7e950a80b0d01534b2a57cce7129debaa",
    "LonelyRunner/ThreeDivisibleRunners.lean": "614dc7bbf75143da6960d74b3eef5427ef93c9c8b3cbe51ec5cd5c6ca47376a3",
    "lake-manifest.json": "887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218",
    "lean-toolchain": "8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af",
    "research/astra-three-divisible-shift-plan-review.md": "981748f0e5377735fdd43c3109c7011b33ea7a0d75272e9e371aedb443229eb9",
    "research/astra-three-divisible-shift-plan.md": "e4d53b08ebfeb49ec31a7a6245bdb870795f31dc8831f326cba8005cc9cf03bc"
  },
  "guards_before": {
    ".lake/build/lib/lean/LonelyRunner/FastRunnerInsertion.olean": "121edfbaed0d7b9fed32bacf891de838142988e48dcb4e7f2bed0c488ea49136",
    ".lake/build/lib/lean/LonelyRunner/FiveRunnerOrdinary.olean": "408abf21f2b4e3c356ae528f92762826556887d7e5068283399a79d6ca72ef31",
    ".lake/build/lib/lean/LonelyRunner/ModularCertificates.olean": "3fc9326cf1393d2b053c26cb27c8b6b174546cd588c7d8d4441c92dc5822f6c5",
    ".lake/build/lib/lean/LonelyRunner/RationalShiftOrbits.olean": "8194c5c6ac0b8495146728fcac70a6a1e9d317f9e7689c4759f22ed33c14340f",
    ".lake/build/lib/lean/LonelyRunner/SeparatedPhaseFamily.olean": "eff265763238a85323240590e528ff8514eef2f4bdb405f0742e0f0a67f6ba41",
    ".lake/build/lib/lean/LonelyRunner/SmallDenominatorWitness.olean": "c67482b37cb6a5c0d5da7fbeeb52eb5eb2c24d440553d4be22cbcf8364b28711",
    ".lake/build/lib/lean/LonelyRunner/StructuredClasses.olean": "4ada0ca2f0a5f20a8c83c3c2e58256e931c3b283882a88a074aeedb02d7e048f",
    ".lake/build/lib/lean/LonelyRunner/ThirdShiftExceptions.olean": "d9c38deec30bda66014ed4d3e4de79fe5934f323e44e39771d353667ce47c7f9",
    ".lake/build/lib/lean/LonelyRunner/ThirdShiftSeed.olean": "5305c6fd2737c6a611abdb710e5e7659bdccdb35c346b7e386c0733a592686be",
    ".lake/build/lib/lean/LonelyRunner/ThirdShiftSpacing.olean": "7bc4793433826271b91dd77e0eb635951c899f55acf5962b94ed3802a2b8c885",
    ".lake/build/lib/lean/LonelyRunner/ThreeDivisibleRunners.olean": "3420ef54c8e2a26960e7dcb8469a5083202a8ca02338978063dfa06662a14c13",
    "LonelyRunner/FastRunnerInsertion.lean": "dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5",
    "LonelyRunner/FiveRunnerOrdinary.lean": "662d0116f13971bce85e76c503e2f3be4fdc6291ba8113aeda43957e38354ffe",
    "LonelyRunner/ModularCertificates.lean": "8b7e9dc5be1236acb812607c19454fe43ecd1333145aef675e7df8e6d0c3871c",
    "LonelyRunner/RationalShiftOrbits.lean": "cf615dd6c6b3cf091cd5d31ac641f4f994c1c50d95e0120c311d3ac129b88591",
    "LonelyRunner/SeparatedPhaseFamily.lean": "28c5db2425eef754156e57c284959ff02da743f1fde424e053c4eae0c721b6bd",
    "LonelyRunner/SmallDenominatorWitness.lean": "1570a359100594f4a5589588e3b32674dc2d54d60e500df1d47aca64c2faf95f",
    "LonelyRunner/StructuredClasses.lean": "5328a7a88d2b42f86ffc3f0f0418ca22c761219e8fa3e5822bda5a18ac286e8c",
    "LonelyRunner/ThirdShiftExceptions.lean": "85590988cd0e104dc93fd51bc79aa326fe2799974eae426b7ea3336853872073",
    "LonelyRunner/ThirdShiftSeed.lean": "3c8b90583658df1cfdbe00e4444157e08d8ae7b4a74b986d5770e9f750429b46",
    "LonelyRunner/ThirdShiftSpacing.lean": "146cdfd80495aced0eb93bc322559cf7e950a80b0d01534b2a57cce7129debaa",
    "LonelyRunner/ThreeDivisibleRunners.lean": "614dc7bbf75143da6960d74b3eef5427ef93c9c8b3cbe51ec5cd5c6ca47376a3",
    "lake-manifest.json": "887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218",
    "lean-toolchain": "8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af",
    "research/astra-three-divisible-shift-plan-review.md": "981748f0e5377735fdd43c3109c7011b33ea7a0d75272e9e371aedb443229eb9",
    "research/astra-three-divisible-shift-plan.md": "e4d53b08ebfeb49ec31a7a6245bdb870795f31dc8831f326cba8005cc9cf03bc"
  },
  "launcher_after_sha256": "fcb2f3660a0305e0949511da9615a17e7493bed1df299984fb8e8d4aadd0bf6a",
  "launcher_bytes": 8361,
  "launcher_sha256": "fcb2f3660a0305e0949511da9615a17e7493bed1df299984fb8e8d4aadd0bf6a",
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
  "probe_after_sha256": "62b81327c607adbcecf5ede70be0a1f292b64886862133b17aef025c8cd2b5d6",
  "probe_bytes": 2674,
  "probe_sha256": "62b81327c607adbcecf5ede70be0a1f292b64886862133b17aef025c8cd2b5d6",
  "runtime_env": {
    "LEAN_NUM_THREADS": "1",
    "LEAN_STACK_SIZE_KB": "65536"
  },
  "status": "passed",
  "stderr_base64": "",
  "stderr_bytes": 0,
  "stderr_sha256": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
  "stderr_utf8": "",
  "stdout_base64": "J0xvbmVseVJ1bm5lci5jaXJjbGVOb3JtX3N1Yl9sZV9hZGQnIGRlcGVuZHMgb24gYXhpb21zOiBbcHJvcGV4dCwgQ2xhc3NpY2FsLmNob2ljZSwgUXVvdC5zb3VuZF0KJ0xvbmVseVJ1bm5lci5jaXJjbGVOb3JtX2JhZF9zdWJzaW5nbGV0b25fb2Zfc2VwYXJhdGVkJyBkZXBlbmRzIG9uIGF4aW9tczogW3Byb3BleHQsIENsYXNzaWNhbC5jaG9pY2UsIFF1b3Quc291bmRdCidMb25lbHlSdW5uZXIuY2lyY2xlTm9ybV90aGlyZF9zaGlmdF9zdWJfZ2UnIGRlcGVuZHMgb24gYXhpb21zOiBbcHJvcGV4dCwgQ2xhc3NpY2FsLmNob2ljZSwgUXVvdC5zb3VuZF0KJ0xvbmVseVJ1bm5lci5leGlzdHNfdGhpcmRfc2hpZnRfc2FmZV9ub25kaXZpc2libGVfZmFtaWx5JyBkZXBlbmRzIG9uIGF4aW9tczogW3Byb3BleHQsIENsYXNzaWNhbC5jaG9pY2UsIFF1b3Quc291bmRdCidMb25lbHlSdW5uZXIuZXhpc3RzX3RoaXJkX3NoaWZ0X29mX3NlZWRlZF9kaXZpc2libGUnIGRlcGVuZHMgb24gYXhpb21zOiBbcHJvcGV4dCwgQ2xhc3NpY2FsLmNob2ljZSwgUXVvdC5zb3VuZF0KJ0xvbmVseVJ1bm5lci5maXZlTW92aW5nTmF0dXJhbFJ1bm5lcnNfb2ZfdGhyZWVfb3JfZm91cl9kaXZpc2libGVfdGhyZWUnIGRlcGVuZHMgb24gYXhpb21zOiBbcHJvcGV4dCwKIENsYXNzaWNhbC5jaG9pY2UsCiBRdW90LnNvdW5kXQonTG9uZWx5UnVubmVyLmZpdmVNb3ZpbmdOYXR1cmFsUnVubmVyc19vZl9wcmltaXRpdmVfdGhyZWVfZGl2aXNpYmxlX3RocmVlJyBkZXBlbmRzIG9uIGF4aW9tczogW3Byb3BleHQsCiBDbGFzc2ljYWwuY2hvaWNlLAogUXVvdC5zb3VuZF0K",
  "stdout_bytes": 816,
  "stdout_sha256": "0ecb53061cee9cb3e2d127456cdf339e24c904f5f7481248b9deca57388ec9ba",
  "stdout_utf8": "'LonelyRunner.circleNorm_sub_le_add' depends on axioms: [propext, Classical.choice, Quot.sound]\n'LonelyRunner.circleNorm_bad_subsingleton_of_separated' depends on axioms: [propext, Classical.choice, Quot.sound]\n'LonelyRunner.circleNorm_third_shift_sub_ge' depends on axioms: [propext, Classical.choice, Quot.sound]\n'LonelyRunner.exists_third_shift_safe_nondivisible_family' depends on axioms: [propext, Classical.choice, Quot.sound]\n'LonelyRunner.exists_third_shift_of_seeded_divisible' depends on axioms: [propext, Classical.choice, Quot.sound]\n'LonelyRunner.fiveMovingNaturalRunners_of_three_or_four_divisible_three' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'LonelyRunner.fiveMovingNaturalRunners_of_primitive_three_divisible_three' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n",
  "timed_out": false,
  "wall_seconds": 1.969869501015637
}
```
<!-- END RECEIPT -->

Complete Lean stdout (816 bytes including final newline):

<!-- BEGIN STDOUT -->
```text
'LonelyRunner.circleNorm_sub_le_add' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.circleNorm_bad_subsingleton_of_separated' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.circleNorm_third_shift_sub_ge' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.exists_third_shift_safe_nondivisible_family' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.exists_third_shift_of_seeded_divisible' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.fiveMovingNaturalRunners_of_three_or_four_divisible_three' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'LonelyRunner.fiveMovingNaturalRunners_of_primitive_three_divisible_three' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
```
<!-- END STDOUT -->

Complete Lean stderr is the empty byte string (0 bytes), SHA-256
`e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.
Stdout SHA-256 is
`0ecb53061cee9cb3e2d127456cdf339e24c904f5f7481248b9deca57388ec9ba`.

The accepted artifact is a conditional positive-time theorem for five natural
moving speeds when exactly three or four labels are divisible by three, plus
the primitive at-least-three corollary and their reusable helpers. It has no
distinctness premise, permits repeated speeds under its explicit assumptions,
and keeps the same selected shift for all labels. No missing premise was found.
No theorem for the all-five-divisible nonprimitive case, unrestricted six total
runners, a new runner count, or full Lonely Runner resolution is certified here.
Root's remaining task for this batch is its independent replay and integration;
the wider proof assembly remains outside this bounded review.
