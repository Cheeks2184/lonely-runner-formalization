# Independent source review: rational divisor preparation

2026-09-06. Requested Astra/xhigh; runtime model/effort are not independently
attested. Task `/root/rational_divisor_source_review`, recorded checkpoint
`5e60390195660af375300233309f058f2d2cb452`. I authored the earlier mathematical
plan but did not author these three Lean sources. Root owns workflow state;
only this report is owned. All other files are preserved.

**Semantic disposition: accept all six frozen theorem contracts and proof
bodies.** The import-only probe result is recorded separately below. The
contracts are exactly items 2, 3, 5, 6, 7 and 8 of the accepted divisibility
seed plan; items 1 and 4 are already reviewed helpers in `RationalShiftOrbits`.
This is restricted divisor preparation, not a complete five-moving sixth
theorem or an unrestricted LRC result.

## Independent proof and scope review

**Reduced orbit.** `RationalShiftGcd` takes arbitrary real `x`, natural
`ell,d`, `ell≥2`, and `¬ell∣d`. It defines exactly `g=gcd(ell,d)`,
`n=ell/g`, `c=d/g`. Positivity of `ell` makes `g>0`; exact divisibility
gives `ell=g*n`, `d=g*c`, and `n>0`. If `n=1`, then `ell=g` divides `d`,
contradicting the supplied nondivisibility. Hence `n≥2`. The coprimality
lemma initially gives the reduced pair in the opposite order; the explicit
`.symm` supplies `Nat.Coprime c n` as required by the checked natural-grid
helper. Nothing assumes that `d` itself is coprime to `ell` or that `ell`
is prime. The case `d=0` is excluded by `hnot`, rather than by an unstated
positive-speed premise.

The imported bounded coprime-grid theorem supplies `k<n` with the sharp
closed mesh margin. Since `g>0`, `n≤ell`, and the source uses
`hk.trans_le hnle` to obtain `k<ell`. The relation is `k<n≤ell`, not
`k<n<ell`; `n=ell` is allowed when the gcd is one. Cancelling only the
positive gcd in the real ratio gives `d/ell=c/n`. The output retains the
original time-shift denominator `ell`, the actual orbit size `n` in its
margin, and both requested bounds on `k`. All real phases, including
negative phases, and the possible witness `k=0` remain admitted.

**Closed quarter bound.** The second theorem independently recovers `n≥2`
from the same gcd/nondivisibility facts and compares
`1/4≤(n-1)/(2*n)` using the positive denominator `2*n`. It weakens the mesh
margin and forgets only the extra `k<n` conclusion, exactly as in the
accepted contract. At `n=2` the two margins are equal, so the non-strict
comparison is essential. The theorem and proof preserve this equality;
there is no hidden strictly-better-than-quarter assertion. This is a
symbolic endpoint review, not a numerical fixture.

**One shift for an arbitrary family.** `RationalShiftInsertion` first applies
the quarter theorem at real base phase `t*d`, choosing one natural `k<ell`.
Distributivity converts the exceptional phase into `(t+k/ell)*d`. For each
old coordinate it then applies the checked exact preservation theorem to
`ell∣v i`. No choice is made over the family after selecting `k`. The label
type is universe-polymorphic `ι : Type*`, with no `Fintype`, nonemptiness,
injectivity or positivity assumption. Empty or infinite families, zero old
speeds and negative real time are included. The old-coordinate conclusion
is exact equality of norms, without a supplied safety margin.

**Conditional positive five-moving insertion.** The distinguished label
`p : Fin 5` is nondivisible, while every other label is divisible. The source
uses `old j=v(p.succAbove j)` for `j : Fin 4`. Positivity restricts to this
tuple; the checked `fourMovingNaturalRunners` gives `t₀>0` with margin
`(5:ℝ)⁻¹`. The family-preserving shift raises the exceptional coordinate
to at least `1/4`, leaving all four old norms at least `1/5`. Both bounds
imply the exact closed `1/6` conclusion. The final time is `t₀+k/ell>0`
because `k` is natural and `ell>0`. `Fin.exists_succAbove_eq` covers every
label other than `p`; no speed-value sorting or deduplication occurs, and
repeated old speeds are allowed. The exceptional value cannot equal a
divisible value by the stated divisibility assumptions themselves. The
proof invokes the four-moving fifth-margin supply, not the unproved
unrestricted five-moving sixth theorem.

**Primitive upper divisor count.** `SixTotalDivisorCounts` takes positive
`v : Fin 5→ℕ`, `Finset.univ.gcd v=1`, and the exact no-witness hypothesis
`¬∃t:ℝ, ∀i, 1/6≤circleNorm(t*v i)`. This ranges over all real times and
retains the closed boundary. For every `ell≥2`, primitivity supplies a
nondivisible label `p`: otherwise `Finset.dvd_gcd` implies `ell∣1`, forcing
`ell=1`. Thus the all-five-divisible case is excluded logically; there is
no scaling or recursive invocation of the target theorem.

Let `S` be the divisible-label filter. It lies in `univ.erase p`, whose
cardinality is four. If `S.card>3`, then `4≤S.card`, and
`Finset.eq_of_subset_of_card_le` forces `S=univ.erase p`. Every other label
is therefore divisible, so the conditional insertion theorem supplies a
positive witness. Forgetting its positivity contradicts the given all-real
`hno`. The bound is valid for every natural `ell≥2`, with no upper bound,
primality or coprimality assumption. Label cardinality, not distinct speed
cardinality, is used throughout.

**Lower count and conjunction.** For `2≤ell≤6`, the existing
`divisor_cover_of_no_small_witness` at `N=6` supplies a divisible label.
Its source proof uses the explicit time `1/ell`: a nonzero residue has
cyclic distance at least one, giving norm at least `1/ell≥1/6`.
`simpa [one_div]` changes only the notation of the same closed margin.
The new proof converts that label into `1≤S.card` and combines it with
the independently established upper bound. The lower bound needs the
`ell≤6` hypothesis; the upper theorem does not. Neither count theorem
is a sufficiency claim for the existence of a lonely time.

All three new source files and the relevant old proof bodies/API statements
were read. The accepted plan and its independent review were rechecked at
their guarded hashes. No defect or weakened theorem was found. Root reports
the final focused build succeeded; this task does not claim a fresh source
build or a full project build. The following probe checks the exact exported
types/axioms of the specifically guarded imported oleans.

## Predeclared single import-only probe

This complete probe and launcher are saved before execution. There will be
one invocation of `lake env lean -j1 -s65536 --stdin` with process-local
`LEAN_NUM_THREADS=1` and `LEAN_STACK_SIZE_KB=65536`. It contains exactly six
universal direct type assignments and six `#print axioms` commands. No
numerical fixtures, finite searches, source builds, root imports, dependency
restoration or cache cleanup are part of this check.

Limits: 8 GiB address space, CPU soft/hard 59/60 seconds, a 60-second alarm,
parent wall deadline 60 seconds, and a 128 KiB regular-file cap for each
output stream (256 KiB combined). Anonymous temporary files hold stdin and
capture stdout/stderr; no probe/output file is added to the repository.
Both streams are read in full after process completion or forced termination.
The complete raw bytes, hashes, parsed axiom lists, exit status and resource
receipt are retained below. A failure is recorded as a failure, with no
automatic retry or cap increase.

Thirteen full-file guards cover the three new sources, their three oleans,
three relevant dependency sources, the accepted plan/review, and the pinned
toolchain/manifest. They are checked before and after. The complete probe
and launcher fences are also extracted and compared byte-for-byte before
and after; this does not rely on a report-prefix marker. The static hashes
of these executable fences are recorded below before the child is launched.
Olean/source correspondence relies on root's separately reported focused
source builds; this task independently checks the imported exported contracts
and their actual axiom dependencies.

Exactly one Bash replay entry point follows. It is also the actual command
used in this task, from the repository root:

```bash
python3 -I - <<'PY'
from pathlib import Path
p = Path('research/astra-rational-divisor-source-review.md')
s = p.read_text(encoding='utf-8')
start = '<!-- BEGIN LAUNCHER -->\n```python\n'
end = '\n```\n<!-- END LAUNCHER -->'
assert s.count(start) == 1 and s.count(end) == 1
code = s.split(start, 1)[1].split(end, 1)[0] + '\n'
exec(compile(code, str(p) + ':launcher', 'exec'))
PY
```

<!-- BEGIN PROBE -->
```lean
import LonelyRunner.RationalShiftGcd
import LonelyRunner.RationalShiftInsertion
import LonelyRunner.SixTotalDivisorCounts

open LonelyRunner
universe u

example : ∀ (ell d : ℕ), 2 ≤ ell → ¬ ell ∣ d → ∀ x : ℝ,
    let n : ℕ := ell / Nat.gcd ell d
    ∃ k : ℕ, k < n ∧ k < ell ∧
      ((n : ℝ) - 1) / (2 * (n : ℝ)) ≤
        circleNorm (x + (k : ℝ) * (d : ℝ) / (ell : ℝ)) :=
  exists_nat_rational_shift_circleNorm_ge_mesh

example : ∀ (ell d : ℕ), 2 ≤ ell → ¬ ell ∣ d → ∀ x : ℝ,
    ∃ k : ℕ, k < ell ∧ (1 : ℝ) / 4 ≤
      circleNorm (x + (k : ℝ) * (d : ℝ) / (ell : ℝ)) :=
  exists_nat_rational_shift_circleNorm_ge_quarter

example {ι : Type u} : ∀ (v : ι → ℕ) (ell d : ℕ),
    2 ≤ ell → ¬ ell ∣ d → (∀ i, ell ∣ v i) → ∀ t : ℝ,
      ∃ k : ℕ, k < ell ∧
        (1 : ℝ) / 4 ≤ circleNorm
          ((t + (k : ℝ) / (ell : ℝ)) * (d : ℝ)) ∧
        ∀ i, circleNorm ((t + (k : ℝ) / (ell : ℝ)) * (v i : ℝ)) =
          circleNorm (t * (v i : ℝ)) :=
  exists_nat_shift_preserving_divisible_family

example : ∀ (v : Fin 5 → ℕ), (∀ i, 0 < v i) →
    ∀ ell : ℕ, 2 ≤ ell → ∀ p : Fin 5, ¬ ell ∣ v p →
      (∀ i, i ≠ p → ell ∣ v i) →
      ∃ t : ℝ, 0 < t ∧ ∀ i,
        (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ)) :=
  fiveMovingNaturalRunners_of_four_divisible

example : ∀ (v : Fin 5 → ℕ), (∀ i, 0 < v i) →
    Finset.univ.gcd v = 1 →
    (¬ ∃ t : ℝ, ∀ i, (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ))) →
    ∀ ell : ℕ, 2 ≤ ell →
      ((Finset.univ : Finset (Fin 5)).filter (fun i => ell ∣ v i)).card ≤ 3 :=
  primitive_no_sixth_witness_divisor_count_le_three

example : ∀ (v : Fin 5 → ℕ), (∀ i, 0 < v i) →
    Finset.univ.gcd v = 1 →
    (¬ ∃ t : ℝ, ∀ i, (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ))) →
    ∀ ell : ℕ, 2 ≤ ell → ell ≤ 6 →
      1 ≤ ((Finset.univ : Finset (Fin 5)).filter (fun i => ell ∣ v i)).card ∧
      ((Finset.univ : Finset (Fin 5)).filter (fun i => ell ∣ v i)).card ≤ 3 :=
  six_total_divisor_count_bounds

#print axioms LonelyRunner.exists_nat_rational_shift_circleNorm_ge_mesh
#print axioms LonelyRunner.exists_nat_rational_shift_circleNorm_ge_quarter
#print axioms LonelyRunner.exists_nat_shift_preserving_divisible_family
#print axioms LonelyRunner.fiveMovingNaturalRunners_of_four_divisible
#print axioms LonelyRunner.primitive_no_sixth_witness_divisor_count_le_three
#print axioms LonelyRunner.six_total_divisor_count_bounds
```
<!-- END PROBE -->

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

REPORT = Path('research/astra-rational-divisor-source-review.md')
EXPECTED = {
    'LonelyRunner/RationalShiftGcd.lean': '6e9d1e3e084188a651e4c875cf36fd5d6fc7cbd5f1914784019a207a0cec01f4',
    'LonelyRunner/RationalShiftInsertion.lean': '6ab6e77e8f5edcdc2a2d242fb2616327004b376496616f46896303a06876db23',
    'LonelyRunner/SixTotalDivisorCounts.lean': '0b62ef724eb8c24db4085e247e9f16f650ec450291c7ccac2b0ad0981f148727',
    '.lake/build/lib/lean/LonelyRunner/RationalShiftGcd.olean': '925dfab54e1f29d8e5e7bc80272c9d933502bbcb593b1413da6f600dc75dd2de',
    '.lake/build/lib/lean/LonelyRunner/RationalShiftInsertion.olean': 'af17002f5e03d6b8eaf31e02d0c79dd9b5377d79b0b6f34092d1e72af6cf1e43',
    '.lake/build/lib/lean/LonelyRunner/SixTotalDivisorCounts.olean': '4c4adfb72f8142f2187e1e7a069738f0154b5759468e044fc32386f0ddeef888',
    'LonelyRunner/RationalShiftOrbits.lean': 'cf615dd6c6b3cf091cd5d31ac641f4f994c1c50d95e0120c311d3ac129b88591',
    'LonelyRunner/FiveRunnerOrdinary.lean': '662d0116f13971bce85e76c503e2f3be4fdc6291ba8113aeda43957e38354ffe',
    'LonelyRunner/SmallDenominatorWitness.lean': '1570a359100594f4a5589588e3b32674dc2d54d60e500df1d47aca64c2faf95f',
    'research/astra-six-total-divisibility-seed-plan.md': '752cc8e216bde3cc8b533e84da02967972781a2bd7cbc95e6b62503f26d5e792',
    'research/astra-six-total-divisibility-seed-review.md': '50ed03a4832e989b533ad39480e5e16a21590f3567c90451436af032830819e6',
    'lean-toolchain': '8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af',
    'lake-manifest.json': '887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218',
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
    'exists_nat_rational_shift_circleNorm_ge_mesh',
    'exists_nat_rational_shift_circleNorm_ge_quarter',
    'exists_nat_shift_preserving_divisible_family',
    'fiveMovingNaturalRunners_of_four_divisible',
    'primitive_no_sixth_witness_divisor_count_le_three',
    'six_total_divisor_count_bounds',
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

## Pre-execution static hashes

Static extraction of the two saved complete executable fences exited 0 before
the Lean invocation. Exactly one trailing newline is included in each hash:

```text
PROBE 2595 f90b99d03dfd286fa808b5d81ef1fcbc6678f9f8fa3e04d891841a4f424025f2
LAUNCHER 6702 1a820483d469c4040e6ab00c3d16f7855c47e417e3f99892b2b7412049531c16
```

## Actual execution

**Final disposition: accept the six frozen declarations at their exact
contracts.** The sole authorized invocation returned launcher exit 0 and
child exit 0. All six universal direct assignments elaborated and all six
complete axiom outputs contain only `propext`, `Classical.choice` and
`Quot.sound`. There was no failed attempt, retry, cap increase or source
change in this task.

The measured wall time was 1.9910664570052177 seconds; child CPU totals
were 1.37245 user seconds and 0.6249399999999999 system
seconds. The observed RSS high-water mark was 3644520 KiB;
it is distinct from the enforced 8 GiB virtual-address-space limit.
Neither the wall deadline nor stream caps fired. Stdout was exactly
710 bytes, including its final newline; stderr was empty.
All thirteen full-file guards matched before and after, and both complete
executable sections remained byte-identical to their predeclared hashes.

Complete actual child stdout, with multiline lists retained:

```text
'LonelyRunner.exists_nat_rational_shift_circleNorm_ge_mesh' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.exists_nat_rational_shift_circleNorm_ge_quarter' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'LonelyRunner.exists_nat_shift_preserving_divisible_family' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.fiveMovingNaturalRunners_of_four_divisible' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.primitive_no_sixth_witness_divisor_count_le_three' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'LonelyRunner.six_total_divisor_count_bounds' depends on axioms: [propext, Classical.choice, Quot.sound]
```

Complete actual launcher stdout follows. Its raw-byte base64 fields and hashes
retain both child streams exactly; the enclosing command's exit code was 0.

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
      "exists_nat_rational_shift_circleNorm_ge_mesh",
      "propext, Classical.choice, Quot.sound"
    ],
    [
      "exists_nat_rational_shift_circleNorm_ge_quarter",
      "propext,\n Classical.choice,\n Quot.sound"
    ],
    [
      "exists_nat_shift_preserving_divisible_family",
      "propext, Classical.choice, Quot.sound"
    ],
    [
      "fiveMovingNaturalRunners_of_four_divisible",
      "propext, Classical.choice, Quot.sound"
    ],
    [
      "primitive_no_sixth_witness_divisor_count_le_three",
      "propext,\n Classical.choice,\n Quot.sound"
    ],
    [
      "six_total_divisor_count_bounds",
      "propext, Classical.choice, Quot.sound"
    ]
  ],
  "axioms_ok": true,
  "capture_ok": true,
  "child_maxrss_kib": 3644520,
  "child_system_seconds": 0.6249399999999999,
  "child_user_seconds": 1.37245,
  "cwd": "/home/joshua/lonely-runner-formalization",
  "executable_unchanged": true,
  "exit_code": 0,
  "guards_after": {
    ".lake/build/lib/lean/LonelyRunner/RationalShiftGcd.olean": "925dfab54e1f29d8e5e7bc80272c9d933502bbcb593b1413da6f600dc75dd2de",
    ".lake/build/lib/lean/LonelyRunner/RationalShiftInsertion.olean": "af17002f5e03d6b8eaf31e02d0c79dd9b5377d79b0b6f34092d1e72af6cf1e43",
    ".lake/build/lib/lean/LonelyRunner/SixTotalDivisorCounts.olean": "4c4adfb72f8142f2187e1e7a069738f0154b5759468e044fc32386f0ddeef888",
    "LonelyRunner/FiveRunnerOrdinary.lean": "662d0116f13971bce85e76c503e2f3be4fdc6291ba8113aeda43957e38354ffe",
    "LonelyRunner/RationalShiftGcd.lean": "6e9d1e3e084188a651e4c875cf36fd5d6fc7cbd5f1914784019a207a0cec01f4",
    "LonelyRunner/RationalShiftInsertion.lean": "6ab6e77e8f5edcdc2a2d242fb2616327004b376496616f46896303a06876db23",
    "LonelyRunner/RationalShiftOrbits.lean": "cf615dd6c6b3cf091cd5d31ac641f4f994c1c50d95e0120c311d3ac129b88591",
    "LonelyRunner/SixTotalDivisorCounts.lean": "0b62ef724eb8c24db4085e247e9f16f650ec450291c7ccac2b0ad0981f148727",
    "LonelyRunner/SmallDenominatorWitness.lean": "1570a359100594f4a5589588e3b32674dc2d54d60e500df1d47aca64c2faf95f",
    "lake-manifest.json": "887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218",
    "lean-toolchain": "8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af",
    "research/astra-six-total-divisibility-seed-plan.md": "752cc8e216bde3cc8b533e84da02967972781a2bd7cbc95e6b62503f26d5e792",
    "research/astra-six-total-divisibility-seed-review.md": "50ed03a4832e989b533ad39480e5e16a21590f3567c90451436af032830819e6"
  },
  "guards_before": {
    ".lake/build/lib/lean/LonelyRunner/RationalShiftGcd.olean": "925dfab54e1f29d8e5e7bc80272c9d933502bbcb593b1413da6f600dc75dd2de",
    ".lake/build/lib/lean/LonelyRunner/RationalShiftInsertion.olean": "af17002f5e03d6b8eaf31e02d0c79dd9b5377d79b0b6f34092d1e72af6cf1e43",
    ".lake/build/lib/lean/LonelyRunner/SixTotalDivisorCounts.olean": "4c4adfb72f8142f2187e1e7a069738f0154b5759468e044fc32386f0ddeef888",
    "LonelyRunner/FiveRunnerOrdinary.lean": "662d0116f13971bce85e76c503e2f3be4fdc6291ba8113aeda43957e38354ffe",
    "LonelyRunner/RationalShiftGcd.lean": "6e9d1e3e084188a651e4c875cf36fd5d6fc7cbd5f1914784019a207a0cec01f4",
    "LonelyRunner/RationalShiftInsertion.lean": "6ab6e77e8f5edcdc2a2d242fb2616327004b376496616f46896303a06876db23",
    "LonelyRunner/RationalShiftOrbits.lean": "cf615dd6c6b3cf091cd5d31ac641f4f994c1c50d95e0120c311d3ac129b88591",
    "LonelyRunner/SixTotalDivisorCounts.lean": "0b62ef724eb8c24db4085e247e9f16f650ec450291c7ccac2b0ad0981f148727",
    "LonelyRunner/SmallDenominatorWitness.lean": "1570a359100594f4a5589588e3b32674dc2d54d60e500df1d47aca64c2faf95f",
    "lake-manifest.json": "887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218",
    "lean-toolchain": "8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af",
    "research/astra-six-total-divisibility-seed-plan.md": "752cc8e216bde3cc8b533e84da02967972781a2bd7cbc95e6b62503f26d5e792",
    "research/astra-six-total-divisibility-seed-review.md": "50ed03a4832e989b533ad39480e5e16a21590f3567c90451436af032830819e6"
  },
  "launcher_after_sha256": "1a820483d469c4040e6ab00c3d16f7855c47e417e3f99892b2b7412049531c16",
  "launcher_bytes": 6702,
  "launcher_sha256": "1a820483d469c4040e6ab00c3d16f7855c47e417e3f99892b2b7412049531c16",
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
  "probe_after_sha256": "f90b99d03dfd286fa808b5d81ef1fcbc6678f9f8fa3e04d891841a4f424025f2",
  "probe_bytes": 2595,
  "probe_sha256": "f90b99d03dfd286fa808b5d81ef1fcbc6678f9f8fa3e04d891841a4f424025f2",
  "runtime_env": {
    "LEAN_NUM_THREADS": "1",
    "LEAN_STACK_SIZE_KB": "65536"
  },
  "status": "passed",
  "stderr_base64": "",
  "stderr_bytes": 0,
  "stderr_sha256": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
  "stderr_utf8": "",
  "stdout_base64": "J0xvbmVseVJ1bm5lci5leGlzdHNfbmF0X3JhdGlvbmFsX3NoaWZ0X2NpcmNsZU5vcm1fZ2VfbWVzaCcgZGVwZW5kcyBvbiBheGlvbXM6IFtwcm9wZXh0LCBDbGFzc2ljYWwuY2hvaWNlLCBRdW90LnNvdW5kXQonTG9uZWx5UnVubmVyLmV4aXN0c19uYXRfcmF0aW9uYWxfc2hpZnRfY2lyY2xlTm9ybV9nZV9xdWFydGVyJyBkZXBlbmRzIG9uIGF4aW9tczogW3Byb3BleHQsCiBDbGFzc2ljYWwuY2hvaWNlLAogUXVvdC5zb3VuZF0KJ0xvbmVseVJ1bm5lci5leGlzdHNfbmF0X3NoaWZ0X3ByZXNlcnZpbmdfZGl2aXNpYmxlX2ZhbWlseScgZGVwZW5kcyBvbiBheGlvbXM6IFtwcm9wZXh0LCBDbGFzc2ljYWwuY2hvaWNlLCBRdW90LnNvdW5kXQonTG9uZWx5UnVubmVyLmZpdmVNb3ZpbmdOYXR1cmFsUnVubmVyc19vZl9mb3VyX2RpdmlzaWJsZScgZGVwZW5kcyBvbiBheGlvbXM6IFtwcm9wZXh0LCBDbGFzc2ljYWwuY2hvaWNlLCBRdW90LnNvdW5kXQonTG9uZWx5UnVubmVyLnByaW1pdGl2ZV9ub19zaXh0aF93aXRuZXNzX2Rpdmlzb3JfY291bnRfbGVfdGhyZWUnIGRlcGVuZHMgb24gYXhpb21zOiBbcHJvcGV4dCwKIENsYXNzaWNhbC5jaG9pY2UsCiBRdW90LnNvdW5kXQonTG9uZWx5UnVubmVyLnNpeF90b3RhbF9kaXZpc29yX2NvdW50X2JvdW5kcycgZGVwZW5kcyBvbiBheGlvbXM6IFtwcm9wZXh0LCBDbGFzc2ljYWwuY2hvaWNlLCBRdW90LnNvdW5kXQo=",
  "stdout_bytes": 710,
  "stdout_sha256": "45fe0cc9efeddfa20449c159ff3778c1483c228d426945d3fcfb2bd97a343184",
  "stdout_utf8": "'LonelyRunner.exists_nat_rational_shift_circleNorm_ge_mesh' depends on axioms: [propext, Classical.choice, Quot.sound]\n'LonelyRunner.exists_nat_rational_shift_circleNorm_ge_quarter' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'LonelyRunner.exists_nat_shift_preserving_divisible_family' depends on axioms: [propext, Classical.choice, Quot.sound]\n'LonelyRunner.fiveMovingNaturalRunners_of_four_divisible' depends on axioms: [propext, Classical.choice, Quot.sound]\n'LonelyRunner.primitive_no_sixth_witness_divisor_count_le_three' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'LonelyRunner.six_total_divisor_count_bounds' depends on axioms: [propext, Classical.choice, Quot.sound]\n",
  "timed_out": false,
  "wall_seconds": 1.9910664570052177
}
```

The workflow validator also exited 0 with:

```text
workflow structural validation passed; it cannot certify mathematical validity.
```

No source build, search, numerical fixture, cache cleanup, Git operation or
state mutation occurred. The only mathematical execution was the single
import-only probe above. The exact Bash entry point earlier in this report
is the one for root's replay. The remaining full phase/speed-family assembly
and canonical H7/H8 gaps are not discharged by these six helpers; no full
runner-count theorem or unrestricted LRC result is asserted.
