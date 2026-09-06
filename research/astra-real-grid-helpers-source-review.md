# Independent frozen-source review: real grid helpers

2026-09-06. Requested Astra/xhigh; observed runtime model and effort unavailable.
Task `/root/real_grid_helpers_source_review`, executed by
`/root/seven_adic_expanded_falsifier`, checkpoint
`2c503a4e3599646e77d5d9453be54e2667842ae6`. I authored the accepted bridge and
divisor manuscripts, but did not author these Lean implementations. They were
written by Terra with root's compiler-directed corrections. Only this report
is owned; all other source, state, Git and cache files are preserved.

## Source verdict and exact scope

**Accept the seven theorem contracts and the atom definition, following an
independent reading of every proof body.** The import-only execution outcome
is recorded separately below; this paragraph is the semantic source verdict.
The assignment covers divisor-plan contracts 1 and 4 only, and the five generic
theorems plus atom definition from the concrete phase bridge. No reduced
noncoprime orbit, quarter-bound corollary, full phase certificate, six-total
runner theorem, or unrestricted LRC is claimed here.

The complete universal types are preserved in the executable probe below.
The implementation's `_hn` rename leaves the positive-`n` argument in the
finite-cut coverage type; it does not delete that accepted premise. There are
no extra sign, distinctness, sorting, rationality or strict-margin assumptions.

1. **Natural coprime grid representative.** The existing integer-grid theorem
   gives an integer `K`, at arbitrary real phase `x`, with the exact closed
   margin `(n-1)/(2*n)`. The source chooses `k = K.natMod n`, not `K.toNat` or
   an absolute value. Since `n>0`, Euclidean remainder is nonnegative and
   below `n`. The cast identity `k + n*(K/n) = K` yields
   `x+K*c/n = (K/n)*c + (x+k*c/n)` in the reals. The first summand is an
   integer; periodicity transfers the bound. This works for negative `K`
   and negative `x`, any natural `c`, and composite `n` subject to exactly
   `Nat.Coprime c n`. It does not assume every nonzero composite residue is
   invertible. For `n=1` the only bounded index is zero and the margin is zero;
   `c=0,n=1` remains admitted. These are symbolic scope deductions, not
   executed numerical fixtures. The proof reuses the already checked integer
   grid/Bezout theorem without changing its threshold.
2. **Divisible-speed time preservation.** Writing `a=ell*r`, the source
   proves `(t+k/ell)*a = k*r+t*a`, with `k*r` cast as an integer. Positivity
   of `ell` justifies denominator cancellation. Integer periodicity gives
   equality of norms, for arbitrary real `t`, including negative time,
   and for `a=0` or `k=0`. There is no upper bound on `k` and no premise
   that the original phase was safe. The statement needs no finite family.
3. **Strict integer band.** Put
   `ε=min(y-q,q+1-y)`. The two strict premises imply `δ<ε`; the nonnegative
   margin gives `0≤ε`. Each minimum bound implies `2*ε≤1` when added, hence
   `ε≤1/2`. Apply the checked closed-band theorem at `ε`, obtaining
   `δ<ε≤circleNorm y`. Thus the source retains `δ=0` and does not assume
   `δ<1/2` separately. Infeasible larger margins cause no exception: the
   strict premises themselves force `δ<1/2`. Both `q` and `y` may be negative.
4. **Positive affine open band.** Strict interior membership and `A>0`
   give `A*L+B<A*x+B<A*U+B`; composition with the closed endpoint bounds
   feeds the strict-band theorem. Endpoint equality with either safety
   boundary is allowed. Positivity of the slope is retained; replacing it
   with `A≥0` would invalidate this implication for a constant boundary
   phase. No extra sorting premise is needed beyond `L<x<U`.
5. **Affine fractional-part periodicity.** The exact identity
   `A*x+B = A*floor(x)+(A*fract(x)+B)` has integer `A*floor(x)` even when
   the floor is negative. The source casts the product from integers and
   applies integer periodicity. It admits `A=0`, arbitrary real offset `B`,
   and arbitrary real `x`; the floor is never cast to a natural number.
6. **Adjacent cut crossing.** Induction on `n` compares `x` with `C n` in
   the successor case. If `x<C n`, the previous crossing persists. Otherwise
   `C n≤x<C(n+1)` supplies the final adjacent crossing. No monotonicity,
   injectivity, boundedness or natural-valued restriction on this theorem's
   `C : ℕ→ℝ` is present. At `n=0` its premises contradict one another,
   which the base case discharges without asserting a nonexistent index.
7. **Singleton/open coverage.** `D>0`, `C 0=0` and `C n=D` bracket each
   `x∈[0,1)` by the normalized adjacent-crossing theorem. Equality with the
   selected lower cut gives even index `2*i`; strict inequality gives odd
   index `2*i+1`. Universal natural arithmetic proves both indices below
   `2*n`, their quotients by 2, and their remainders. This is not finite
   cut enumeration. The positive-`n` premise remains explicit even though
   endpoint and denominator premises already imply it. Duplicate/unsorted
   natural cuts are admitted. Zero is included; one is excluded by the
   theorem's premise. Interior cuts have singleton atoms, and all open
   atoms exclude their two endpoints. Coverage, not unique membership, is
   the exact claim for unsorted sequences.

`CutAtomMem` itself has no positivity assumptions: it is a total predicate
using real division and an even/odd split. Its unrestricted definition is
appropriate; positive denominator and endpoint assumptions appear in the
coverage theorem that uses it. The probe checks the full definitional body
as a universally quantified equivalence in addition to its function type.

The relevant old proof bodies were read in `DivisorInsertion.lean`,
`StructuredClasses.lean` and `FastRunnerInsertion.lean`. Their guarded source
hashes appear in the launcher. No unrelated module or canonical theorem is
being promoted by this review.

## Predeclaration, written before the sole Lean invocation

Run exactly one process command, `lake env lean --stdin`, with only the three
direct helper imports below and universal type assignments. No source build,
root import, finite certificate checking, search, numerical enumeration,
dependency restoration or cache cleanup is authorized by this probe.

The child has address-space limit 8 GiB, CPU soft/hard limits 59/60 seconds,
an inherited 60-second alarm and a parent-enforced 60-second wall deadline.
Each captured stream has a 128 KiB regular-file limit, a combined maximum of
256 KiB. Anonymous temporary files capture stdin/stdout/stderr; no probe source
file or output artifact is added to the repository. The launcher reads every
retained output byte only after the process has stopped, includes raw base64
and UTF-8 views plus hashes, and kills the process group on a wall failure.
A cap/timeout/nonzero exit is a failed probe, never successful evidence.

The launcher checks frozen source, manuscript, toolchain/manifest and three
target olean hashes before and after, and verifies the executable report
prefix is unchanged. Olean hashes identify the imported compiled artifacts;
this import-only check does not rebuild them. Their correspondence to the
frozen sources relies on root's separately reported successful focused builds.
The review independently checks exported types and axioms of those exact
imported artifacts. Root is to replay this same bounded command once.

Seven `#print axioms` commands target the theorems, and the eighth targets
`CutAtomMem`. The only acceptable dependencies are `propext`,
`Classical.choice`, and `Quot.sound`. The optional symbolic body equivalence
does not add a computational domain. All seven type assignments use direct
proof terms, with no tactic search or numeric examples.

The command below is the exact replay entry point, from the repository root:

```bash
python3 -I - <<'PY'
from pathlib import Path
p = Path('research/astra-real-grid-helpers-source-review.md')
s = p.read_text(encoding='utf-8')
start = '<!-- BEGIN LAUNCHER -->\n```python\n'
end = '\n```\n<!-- END LAUNCHER -->'
assert s.count(start) == 1
code = s.split(start, 1)[1].split(end, 1)[0] + '\n'
exec(compile(code, str(p) + ':launcher', 'exec'))
PY
```

<!-- BEGIN PROBE -->
```lean
import LonelyRunner.RationalShiftOrbits
import LonelyRunner.RealPhaseBands
import LonelyRunner.FiniteCutCover

open LonelyRunner

example : ∀ (x : ℝ) (c n : ℕ), 0 < n → Nat.Coprime c n →
    ∃ k : ℕ, k < n ∧ ((n : ℝ) - 1) / (2 * (n : ℝ)) ≤
      circleNorm (x + (k : ℝ) * (c : ℝ) / (n : ℝ)) :=
  exists_nat_coprime_grid_circleNorm_ge

example : ∀ (ell a k : ℕ), 0 < ell → ell ∣ a → ∀ t : ℝ,
    circleNorm ((t + (k : ℝ) / (ell : ℝ)) * (a : ℝ)) =
      circleNorm (t * (a : ℝ)) :=
  circleNorm_time_add_nat_div_of_dvd

example : ∀ (q : ℤ) (y δ : ℝ), 0 ≤ δ →
    (q : ℝ) + δ < y → y < (q : ℝ) + 1 - δ →
      δ < circleNorm y :=
  circleNorm_gt_of_int_band

example : ∀ (q : ℤ) (A B L U x δ : ℝ), 0 < A → 0 ≤ δ →
    (q : ℝ) + δ ≤ A * L + B →
    A * U + B ≤ (q : ℝ) + 1 - δ → L < x → x < U →
      δ < circleNorm (A * x + B) :=
  circleNorm_gt_of_affine_open_band

example : ∀ (A : ℕ) (B x : ℝ),
    circleNorm ((A : ℝ) * Int.fract x + B) =
      circleNorm ((A : ℝ) * x + B) :=
  circleNorm_nat_affine_fract

example : ∀ (C : ℕ → ℝ) (n : ℕ) (x : ℝ), C 0 ≤ x → x < C n →
    ∃ i : ℕ, i < n ∧ C i ≤ x ∧ x < C (i + 1) :=
  exists_adjacent_cut_interval

example : ∀ (n D : ℕ), 0 < n → 0 < D → ∀ C : ℕ → ℕ,
    C 0 = 0 → C n = D → ∀ x : ℝ, 0 ≤ x → x < 1 →
      ∃ a : Fin (2 * n), CutAtomMem C D a.val x :=
  cutAtomMem_covers_unit_interval

example : (ℕ → ℕ) → ℕ → ℕ → ℝ → Prop := CutAtomMem

example (C : ℕ → ℕ) (D a : ℕ) (x : ℝ) :
    CutAtomMem C D a x ↔
      (if a % 2 = 0 then x = (C (a / 2) : ℝ) / (D : ℝ)
       else (C (a / 2) : ℝ) / (D : ℝ) < x ∧
         x < (C (a / 2 + 1) : ℝ) / (D : ℝ)) :=
  Iff.rfl

#print axioms LonelyRunner.exists_nat_coprime_grid_circleNorm_ge
#print axioms LonelyRunner.circleNorm_time_add_nat_div_of_dvd
#print axioms LonelyRunner.circleNorm_gt_of_int_band
#print axioms LonelyRunner.circleNorm_gt_of_affine_open_band
#print axioms LonelyRunner.circleNorm_nat_affine_fract
#print axioms LonelyRunner.exists_adjacent_cut_interval
#print axioms LonelyRunner.cutAtomMem_covers_unit_interval
#print axioms LonelyRunner.CutAtomMem
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

REPORT = Path('research/astra-real-grid-helpers-source-review.md')
EXPECTED = {
    'LonelyRunner/RationalShiftOrbits.lean': 'cf615dd6c6b3cf091cd5d31ac641f4f994c1c50d95e0120c311d3ac129b88591',
    'LonelyRunner/RealPhaseBands.lean': '7f70467bad6bb5a8a859bff8947af1dc73e685910b69157b49bab259b3c02ca0',
    'LonelyRunner/FiniteCutCover.lean': 'b7e7e50834bc86d13ffde759e3d0c2dc4d2480a03ec61eb88a70ca215fcc1011',
    '.lake/build/lib/lean/LonelyRunner/RationalShiftOrbits.olean': '8194c5c6ac0b8495146728fcac70a6a1e9d317f9e7689c4759f22ed33c14340f',
    '.lake/build/lib/lean/LonelyRunner/RealPhaseBands.olean': '7442f9f49d9f1e2d214460557f6a891ba13717ededff679876033793ac2c6504',
    '.lake/build/lib/lean/LonelyRunner/FiniteCutCover.olean': 'e135595b4c42102e9e2736492c39fc95914e1d09800615c3d943553abedc1ade',
    'research/astra-six-total-divisibility-seed-plan.md': '752cc8e216bde3cc8b533e84da02967972781a2bd7cbc95e6b62503f26d5e792',
    'research/astra-six-total-divisibility-seed-review.md': '50ed03a4832e989b533ad39480e5e16a21590f3567c90451436af032830819e6',
    'research/astra-renault-phase-concrete-bridge-plan.md': 'ec29e6cba74dd87a9db823e712fba099d47d6277bf52b2d227ce2d633e0dca60',
    'LonelyRunner/DivisorInsertion.lean': '212fa6d879bab6d70f09a4a43b2027b96724b5e5ac4a22cdf4b368509973166f',
    'LonelyRunner/StructuredClasses.lean': '5328a7a88d2b42f86ffc3f0f0418ca22c761219e8fa3e5822bda5a18ac286e8c',
    'LonelyRunner/FastRunnerInsertion.lean': 'dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5',
    'lean-toolchain': '8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af',
    'lake-manifest.json': '887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218',
}

def sha(data):
    return hashlib.sha256(data).hexdigest()

def guard():
    observed = {p: sha(Path(p).read_bytes()) for p in EXPECTED}
    return observed, observed == EXPECTED

raw_report = REPORT.read_bytes()
report = raw_report.decode('utf-8')

def section(name, language):
    start = '<!-- BEGIN ' + name + ' -->\n```' + language + '\n'
    end = '\n```\n<!-- END ' + name + ' -->'
    assert report.count(start) == 1 and report.count(end) == 1
    return (report.split(start, 1)[1].split(end, 1)[0] + '\n').encode('utf-8')

probe = section('PROBE', 'lean')
launcher = section('LAUNCHER', 'python')
receipt_marker = b'<!-- BEGIN RECEIPT -->'
prefix_before = sha(raw_report.split(receipt_marker, 1)[0])
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

argv = ['/home/joshua/.elan/bin/lake', 'env', 'lean', '--stdin']
env = os.environ.copy()
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
prefix_after = sha(REPORT.read_bytes().split(receipt_marker, 1)[0])
capture_ok = len(stdout) < CAP and len(stderr) < CAP
text_out = stdout.decode('utf-8', errors='replace')
axiom_records = re.findall(
    r"'LonelyRunner\.([^']+)' (?:depends on axioms: \[([^\]]*)\]|does not depend on any axioms)",
    text_out)
names = [
    'exists_nat_coprime_grid_circleNorm_ge',
    'circleNorm_time_add_nat_div_of_dvd',
    'circleNorm_gt_of_int_band',
    'circleNorm_gt_of_affine_open_band',
    'circleNorm_nat_affine_fract',
    'exists_adjacent_cut_interval',
    'cutAtomMem_covers_unit_interval',
    'CutAtomMem',
]
allowed = {'propext', 'Classical.choice', 'Quot.sound'}
axioms_ok = [name for name, _ in axiom_records] == names and all(
    set(filter(None, (x.strip() for x in body.split(',')))) <= allowed
    for _, body in axiom_records)
passed = (exit_code == 0 and not timed_out and capture_ok and not stderr
    and after_ok and prefix_before == prefix_after and axioms_ok)
receipt = {
    'status': 'passed' if passed else 'failed',
    'argv': argv,
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
    'launcher_bytes': len(launcher),
    'launcher_sha256': sha(launcher),
    'report_prefix_before_sha256': prefix_before,
    'report_prefix_after_sha256': prefix_after,
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

<!-- BEGIN RECEIPT -->

The single predeclared invocation completed with **launcher exit 1, child
exit 134**, after 2.8746073129877914 seconds. It produced no stdout or
axiom records and exactly 98 bytes of stderr:

```text
libc++abi: terminating due to uncaught exception of type lean::exception: failed to create thread
```

The newline shown above is part of stderr. This is an infrastructure/process
failure before any successful universal-type or axiom evidence. It is not a
Lean type error, a theorem refutation, or a passed import check. The source
verdict remains semantic acceptance; kernel-probe acceptance is **pending**.
No retry was run in this task. The resource caps were not increased. Root was
notified immediately and owns any separately authorized corrective replay.
Using an explicitly serial Lean process may avoid default thread allocation,
but the failure's exact resource cause is not established by this output.

All 14 frozen source/olean/manuscript/toolchain guards matched both before and
after. Both streams were below their file caps and the parent wall deadline
did not fire. The observed child RSS high-water mark was 3,279,456 KiB;
this is not its virtual address-space peak and does not explain the failure
by itself. CPU totals were 1.208284 user seconds and 0.602312 system seconds.
The launcher and complete probe are retained unchanged above.

The report-prefix hash in the launcher stops at the first literal receipt
marker, which also occurs inside its own source. It therefore guards only
that prefix, not the full executable section. The full probe and launcher
have separate exact hashes below; static re-extraction can check their final
retained bytes. This limitation does not affect the 14 full-file guards.
It is recorded explicitly rather than treating the prefix hash as full
self-integrity evidence.

Complete actual launcher stdout follows, byte-for-byte including its final
newline. The enclosing tool reported launcher exit 1. Base64 fields retain
all raw child bytes, while the UTF-8 fields make them directly readable.

```json
{
  "argv": [
    "/home/joshua/.elan/bin/lake",
    "env",
    "lean",
    "--stdin"
  ],
  "axiom_records": [],
  "axioms_ok": false,
  "capture_ok": true,
  "child_maxrss_kib": 3279456,
  "child_system_seconds": 0.602312,
  "child_user_seconds": 1.208284,
  "cwd": "/home/joshua/lonely-runner-formalization",
  "exit_code": 134,
  "guards_after": {
    ".lake/build/lib/lean/LonelyRunner/FiniteCutCover.olean": "e135595b4c42102e9e2736492c39fc95914e1d09800615c3d943553abedc1ade",
    ".lake/build/lib/lean/LonelyRunner/RationalShiftOrbits.olean": "8194c5c6ac0b8495146728fcac70a6a1e9d317f9e7689c4759f22ed33c14340f",
    ".lake/build/lib/lean/LonelyRunner/RealPhaseBands.olean": "7442f9f49d9f1e2d214460557f6a891ba13717ededff679876033793ac2c6504",
    "LonelyRunner/DivisorInsertion.lean": "212fa6d879bab6d70f09a4a43b2027b96724b5e5ac4a22cdf4b368509973166f",
    "LonelyRunner/FastRunnerInsertion.lean": "dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5",
    "LonelyRunner/FiniteCutCover.lean": "b7e7e50834bc86d13ffde759e3d0c2dc4d2480a03ec61eb88a70ca215fcc1011",
    "LonelyRunner/RationalShiftOrbits.lean": "cf615dd6c6b3cf091cd5d31ac641f4f994c1c50d95e0120c311d3ac129b88591",
    "LonelyRunner/RealPhaseBands.lean": "7f70467bad6bb5a8a859bff8947af1dc73e685910b69157b49bab259b3c02ca0",
    "LonelyRunner/StructuredClasses.lean": "5328a7a88d2b42f86ffc3f0f0418ca22c761219e8fa3e5822bda5a18ac286e8c",
    "lake-manifest.json": "887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218",
    "lean-toolchain": "8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af",
    "research/astra-renault-phase-concrete-bridge-plan.md": "ec29e6cba74dd87a9db823e712fba099d47d6277bf52b2d227ce2d633e0dca60",
    "research/astra-six-total-divisibility-seed-plan.md": "752cc8e216bde3cc8b533e84da02967972781a2bd7cbc95e6b62503f26d5e792",
    "research/astra-six-total-divisibility-seed-review.md": "50ed03a4832e989b533ad39480e5e16a21590f3567c90451436af032830819e6"
  },
  "guards_before": {
    ".lake/build/lib/lean/LonelyRunner/FiniteCutCover.olean": "e135595b4c42102e9e2736492c39fc95914e1d09800615c3d943553abedc1ade",
    ".lake/build/lib/lean/LonelyRunner/RationalShiftOrbits.olean": "8194c5c6ac0b8495146728fcac70a6a1e9d317f9e7689c4759f22ed33c14340f",
    ".lake/build/lib/lean/LonelyRunner/RealPhaseBands.olean": "7442f9f49d9f1e2d214460557f6a891ba13717ededff679876033793ac2c6504",
    "LonelyRunner/DivisorInsertion.lean": "212fa6d879bab6d70f09a4a43b2027b96724b5e5ac4a22cdf4b368509973166f",
    "LonelyRunner/FastRunnerInsertion.lean": "dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5",
    "LonelyRunner/FiniteCutCover.lean": "b7e7e50834bc86d13ffde759e3d0c2dc4d2480a03ec61eb88a70ca215fcc1011",
    "LonelyRunner/RationalShiftOrbits.lean": "cf615dd6c6b3cf091cd5d31ac641f4f994c1c50d95e0120c311d3ac129b88591",
    "LonelyRunner/RealPhaseBands.lean": "7f70467bad6bb5a8a859bff8947af1dc73e685910b69157b49bab259b3c02ca0",
    "LonelyRunner/StructuredClasses.lean": "5328a7a88d2b42f86ffc3f0f0418ca22c761219e8fa3e5822bda5a18ac286e8c",
    "lake-manifest.json": "887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218",
    "lean-toolchain": "8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af",
    "research/astra-renault-phase-concrete-bridge-plan.md": "ec29e6cba74dd87a9db823e712fba099d47d6277bf52b2d227ce2d633e0dca60",
    "research/astra-six-total-divisibility-seed-plan.md": "752cc8e216bde3cc8b533e84da02967972781a2bd7cbc95e6b62503f26d5e792",
    "research/astra-six-total-divisibility-seed-review.md": "50ed03a4832e989b533ad39480e5e16a21590f3567c90451436af032830819e6"
  },
  "launcher_bytes": 6492,
  "launcher_sha256": "587e19ecc6c85a9afe678ea51ee4d110d4cc4815da83e49a710d6bdb5947f48e",
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
  "probe_bytes": 2282,
  "probe_sha256": "3409d93575f40f57dd2f91ece2f4b81b6358c9b27e2a360ba7665d64d64c855b",
  "report_prefix_after_sha256": "55451ca955c63c01089ce0ea8ef1928fa0742a8808bdc952f1a11902edf92228",
  "report_prefix_before_sha256": "55451ca955c63c01089ce0ea8ef1928fa0742a8808bdc952f1a11902edf92228",
  "status": "failed",
  "stderr_base64": "bGliYysrYWJpOiB0ZXJtaW5hdGluZyBkdWUgdG8gdW5jYXVnaHQgZXhjZXB0aW9uIG9mIHR5cGUgbGVhbjo6ZXhjZXB0aW9uOiBmYWlsZWQgdG8gY3JlYXRlIHRocmVhZAo=",
  "stderr_bytes": 98,
  "stderr_sha256": "32a60967270365f092cad81a408cf0e68f13aceab4359f32700f140a54129b9b",
  "stderr_utf8": "libc++abi: terminating due to uncaught exception of type lean::exception: failed to create thread\n",
  "stdout_base64": "",
  "stdout_bytes": 0,
  "stdout_sha256": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
  "stdout_utf8": "",
  "timed_out": false,
  "wall_seconds": 2.8746073129877914
}
```

Workflow validation also exited 0 with:
```text
workflow structural validation passed; it cannot certify mathematical validity.
```

Remaining acceptance work: obtain successful universal-type assignments and
all eight axiom reports from one bounded import-only corrective replay or
root's exact replay. No new mathematical search or source build is indicated
by the thread-creation error. The full phase/certificate and runner-count
assembly gaps described above remain separate work.

## Separately authorized serial corrective replay — predeclaration

After reading the captured thread-creation failure, root explicitly authorized
one corrective invocation of the identical fixed probe. Only process threading
and stack configuration change: Lean CLI `-j1 -s65536`, and process-local
`LEAN_NUM_THREADS=1`, `LEAN_STACK_SIZE_KB=65536`. All probe bytes, frozen-file
guards, imports, theorem types, axiom commands and resource limits remain
unchanged: 8 GiB AS, CPU 59/60 seconds, wall/alarm 60 seconds, captured streams
128 KiB each / 256 KiB combined. The complete first launcher and its failed
receipt remain above. No source build or added mathematical check is authorized.

The exact corrected launcher below is saved before that second invocation.
It differs only in the stated execution settings, its own fenced-source
selector, and recording those two environment values in the receipt. Run it
with the same Python extraction command as the first invocation, replacing
both marker names `LAUNCHER` in that entry point with `RETRY LAUNCHER`.
The extracted source is compiled and executed once. The first receipt's
pending/no-retry statements describe the state before this later authorization.

<!-- BEGIN RETRY LAUNCHER -->
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

REPORT = Path('research/astra-real-grid-helpers-source-review.md')
EXPECTED = {
    'LonelyRunner/RationalShiftOrbits.lean': 'cf615dd6c6b3cf091cd5d31ac641f4f994c1c50d95e0120c311d3ac129b88591',
    'LonelyRunner/RealPhaseBands.lean': '7f70467bad6bb5a8a859bff8947af1dc73e685910b69157b49bab259b3c02ca0',
    'LonelyRunner/FiniteCutCover.lean': 'b7e7e50834bc86d13ffde759e3d0c2dc4d2480a03ec61eb88a70ca215fcc1011',
    '.lake/build/lib/lean/LonelyRunner/RationalShiftOrbits.olean': '8194c5c6ac0b8495146728fcac70a6a1e9d317f9e7689c4759f22ed33c14340f',
    '.lake/build/lib/lean/LonelyRunner/RealPhaseBands.olean': '7442f9f49d9f1e2d214460557f6a891ba13717ededff679876033793ac2c6504',
    '.lake/build/lib/lean/LonelyRunner/FiniteCutCover.olean': 'e135595b4c42102e9e2736492c39fc95914e1d09800615c3d943553abedc1ade',
    'research/astra-six-total-divisibility-seed-plan.md': '752cc8e216bde3cc8b533e84da02967972781a2bd7cbc95e6b62503f26d5e792',
    'research/astra-six-total-divisibility-seed-review.md': '50ed03a4832e989b533ad39480e5e16a21590f3567c90451436af032830819e6',
    'research/astra-renault-phase-concrete-bridge-plan.md': 'ec29e6cba74dd87a9db823e712fba099d47d6277bf52b2d227ce2d633e0dca60',
    'LonelyRunner/DivisorInsertion.lean': '212fa6d879bab6d70f09a4a43b2027b96724b5e5ac4a22cdf4b368509973166f',
    'LonelyRunner/StructuredClasses.lean': '5328a7a88d2b42f86ffc3f0f0418ca22c761219e8fa3e5822bda5a18ac286e8c',
    'LonelyRunner/FastRunnerInsertion.lean': 'dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5',
    'lean-toolchain': '8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af',
    'lake-manifest.json': '887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218',
}

def sha(data):
    return hashlib.sha256(data).hexdigest()

def guard():
    observed = {p: sha(Path(p).read_bytes()) for p in EXPECTED}
    return observed, observed == EXPECTED

raw_report = REPORT.read_bytes()
report = raw_report.decode('utf-8')

def section(name, language):
    start = '<!-- BEGIN ' + name + ' -->\n```' + language + '\n'
    end = '\n```\n<!-- END ' + name + ' -->'
    assert report.count(start) == 1 and report.count(end) == 1
    return (report.split(start, 1)[1].split(end, 1)[0] + '\n').encode('utf-8')

probe = section('PROBE', 'lean')
launcher = section('RETRY LAUNCHER', 'python')
receipt_marker = b'<!-- BEGIN RECEIPT -->'
prefix_before = sha(raw_report.split(receipt_marker, 1)[0])
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
prefix_after = sha(REPORT.read_bytes().split(receipt_marker, 1)[0])
capture_ok = len(stdout) < CAP and len(stderr) < CAP
text_out = stdout.decode('utf-8', errors='replace')
axiom_records = re.findall(
    r"'LonelyRunner\.([^']+)' (?:depends on axioms: \[([^\]]*)\]|does not depend on any axioms)",
    text_out)
names = [
    'exists_nat_coprime_grid_circleNorm_ge',
    'circleNorm_time_add_nat_div_of_dvd',
    'circleNorm_gt_of_int_band',
    'circleNorm_gt_of_affine_open_band',
    'circleNorm_nat_affine_fract',
    'exists_adjacent_cut_interval',
    'cutAtomMem_covers_unit_interval',
    'CutAtomMem',
]
allowed = {'propext', 'Classical.choice', 'Quot.sound'}
axioms_ok = [name for name, _ in axiom_records] == names and all(
    set(filter(None, (x.strip() for x in body.split(',')))) <= allowed
    for _, body in axiom_records)
passed = (exit_code == 0 and not timed_out and capture_ok and not stderr
    and after_ok and prefix_before == prefix_after and axioms_ok)
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
    'launcher_bytes': len(launcher),
    'launcher_sha256': sha(launcher),
    'report_prefix_before_sha256': prefix_before,
    'report_prefix_after_sha256': prefix_after,
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
<!-- END RETRY LAUNCHER -->

<!-- BEGIN RETRY RECEIPT -->

**Final disposition: accept the frozen helper sources and their checked
exported contracts.** The authorized corrective invocation completed with
launcher exit 0 and child exit 0, in 1.8301744060008787 seconds.
The exact same universal proof probe elaborated successfully. All seven theorem
assignments, the atom-definition type assignment and its symbolic definitional
equivalence passed. All eight axiom reports contain only `propext`,
`Classical.choice`, and `Quot.sound`. No source or mathematical contract
changed between the failed invocation and this successful one.

Captured stdout is exactly 825 bytes and stderr is empty. All 14 full-file
guards matched before and after; the report prefix also remained unchanged
within its explicitly documented scope. Neither timeout nor capture cap fired.
The observed RSS high-water mark was 3,282,220 KiB, distinct from the enforced
8 GiB virtual-address-space limit. This pass used 1.245684 user seconds and
0.5880409999999999 system seconds. This outcome supports the corrective launch
configuration; it does not independently identify the original error's cause.

Full successful child stdout (including final newline):

```text
'LonelyRunner.exists_nat_coprime_grid_circleNorm_ge' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.circleNorm_time_add_nat_div_of_dvd' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.circleNorm_gt_of_int_band' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.circleNorm_gt_of_affine_open_band' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.circleNorm_nat_affine_fract' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.exists_adjacent_cut_interval' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.cutAtomMem_covers_unit_interval' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.CutAtomMem' depends on axioms: [propext, Classical.choice, Quot.sound]
```

Complete actual corrective-launcher stdout, retaining both raw child streams,
all source/program hashes and resource receipt:

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
      "exists_nat_coprime_grid_circleNorm_ge",
      "propext, Classical.choice, Quot.sound"
    ],
    [
      "circleNorm_time_add_nat_div_of_dvd",
      "propext, Classical.choice, Quot.sound"
    ],
    [
      "circleNorm_gt_of_int_band",
      "propext, Classical.choice, Quot.sound"
    ],
    [
      "circleNorm_gt_of_affine_open_band",
      "propext, Classical.choice, Quot.sound"
    ],
    [
      "circleNorm_nat_affine_fract",
      "propext, Classical.choice, Quot.sound"
    ],
    [
      "exists_adjacent_cut_interval",
      "propext, Classical.choice, Quot.sound"
    ],
    [
      "cutAtomMem_covers_unit_interval",
      "propext, Classical.choice, Quot.sound"
    ],
    [
      "CutAtomMem",
      "propext, Classical.choice, Quot.sound"
    ]
  ],
  "axioms_ok": true,
  "capture_ok": true,
  "child_maxrss_kib": 3282220,
  "child_system_seconds": 0.5880409999999999,
  "child_user_seconds": 1.245684,
  "cwd": "/home/joshua/lonely-runner-formalization",
  "exit_code": 0,
  "guards_after": {
    ".lake/build/lib/lean/LonelyRunner/FiniteCutCover.olean": "e135595b4c42102e9e2736492c39fc95914e1d09800615c3d943553abedc1ade",
    ".lake/build/lib/lean/LonelyRunner/RationalShiftOrbits.olean": "8194c5c6ac0b8495146728fcac70a6a1e9d317f9e7689c4759f22ed33c14340f",
    ".lake/build/lib/lean/LonelyRunner/RealPhaseBands.olean": "7442f9f49d9f1e2d214460557f6a891ba13717ededff679876033793ac2c6504",
    "LonelyRunner/DivisorInsertion.lean": "212fa6d879bab6d70f09a4a43b2027b96724b5e5ac4a22cdf4b368509973166f",
    "LonelyRunner/FastRunnerInsertion.lean": "dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5",
    "LonelyRunner/FiniteCutCover.lean": "b7e7e50834bc86d13ffde759e3d0c2dc4d2480a03ec61eb88a70ca215fcc1011",
    "LonelyRunner/RationalShiftOrbits.lean": "cf615dd6c6b3cf091cd5d31ac641f4f994c1c50d95e0120c311d3ac129b88591",
    "LonelyRunner/RealPhaseBands.lean": "7f70467bad6bb5a8a859bff8947af1dc73e685910b69157b49bab259b3c02ca0",
    "LonelyRunner/StructuredClasses.lean": "5328a7a88d2b42f86ffc3f0f0418ca22c761219e8fa3e5822bda5a18ac286e8c",
    "lake-manifest.json": "887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218",
    "lean-toolchain": "8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af",
    "research/astra-renault-phase-concrete-bridge-plan.md": "ec29e6cba74dd87a9db823e712fba099d47d6277bf52b2d227ce2d633e0dca60",
    "research/astra-six-total-divisibility-seed-plan.md": "752cc8e216bde3cc8b533e84da02967972781a2bd7cbc95e6b62503f26d5e792",
    "research/astra-six-total-divisibility-seed-review.md": "50ed03a4832e989b533ad39480e5e16a21590f3567c90451436af032830819e6"
  },
  "guards_before": {
    ".lake/build/lib/lean/LonelyRunner/FiniteCutCover.olean": "e135595b4c42102e9e2736492c39fc95914e1d09800615c3d943553abedc1ade",
    ".lake/build/lib/lean/LonelyRunner/RationalShiftOrbits.olean": "8194c5c6ac0b8495146728fcac70a6a1e9d317f9e7689c4759f22ed33c14340f",
    ".lake/build/lib/lean/LonelyRunner/RealPhaseBands.olean": "7442f9f49d9f1e2d214460557f6a891ba13717ededff679876033793ac2c6504",
    "LonelyRunner/DivisorInsertion.lean": "212fa6d879bab6d70f09a4a43b2027b96724b5e5ac4a22cdf4b368509973166f",
    "LonelyRunner/FastRunnerInsertion.lean": "dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5",
    "LonelyRunner/FiniteCutCover.lean": "b7e7e50834bc86d13ffde759e3d0c2dc4d2480a03ec61eb88a70ca215fcc1011",
    "LonelyRunner/RationalShiftOrbits.lean": "cf615dd6c6b3cf091cd5d31ac641f4f994c1c50d95e0120c311d3ac129b88591",
    "LonelyRunner/RealPhaseBands.lean": "7f70467bad6bb5a8a859bff8947af1dc73e685910b69157b49bab259b3c02ca0",
    "LonelyRunner/StructuredClasses.lean": "5328a7a88d2b42f86ffc3f0f0418ca22c761219e8fa3e5822bda5a18ac286e8c",
    "lake-manifest.json": "887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218",
    "lean-toolchain": "8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af",
    "research/astra-renault-phase-concrete-bridge-plan.md": "ec29e6cba74dd87a9db823e712fba099d47d6277bf52b2d227ce2d633e0dca60",
    "research/astra-six-total-divisibility-seed-plan.md": "752cc8e216bde3cc8b533e84da02967972781a2bd7cbc95e6b62503f26d5e792",
    "research/astra-six-total-divisibility-seed-review.md": "50ed03a4832e989b533ad39480e5e16a21590f3567c90451436af032830819e6"
  },
  "launcher_bytes": 6666,
  "launcher_sha256": "c18ecb8790a5f6f8d2e2fa2708ebd64c1ec37ce4a57166e6f3771f009dd45b17",
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
  "probe_bytes": 2282,
  "probe_sha256": "3409d93575f40f57dd2f91ece2f4b81b6358c9b27e2a360ba7665d64d64c855b",
  "report_prefix_after_sha256": "55451ca955c63c01089ce0ea8ef1928fa0742a8808bdc952f1a11902edf92228",
  "report_prefix_before_sha256": "55451ca955c63c01089ce0ea8ef1928fa0742a8808bdc952f1a11902edf92228",
  "runtime_env": {
    "LEAN_NUM_THREADS": "1",
    "LEAN_STACK_SIZE_KB": "65536"
  },
  "status": "passed",
  "stderr_base64": "",
  "stderr_bytes": 0,
  "stderr_sha256": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
  "stderr_utf8": "",
  "stdout_base64": "J0xvbmVseVJ1bm5lci5leGlzdHNfbmF0X2NvcHJpbWVfZ3JpZF9jaXJjbGVOb3JtX2dlJyBkZXBlbmRzIG9uIGF4aW9tczogW3Byb3BleHQsIENsYXNzaWNhbC5jaG9pY2UsIFF1b3Quc291bmRdCidMb25lbHlSdW5uZXIuY2lyY2xlTm9ybV90aW1lX2FkZF9uYXRfZGl2X29mX2R2ZCcgZGVwZW5kcyBvbiBheGlvbXM6IFtwcm9wZXh0LCBDbGFzc2ljYWwuY2hvaWNlLCBRdW90LnNvdW5kXQonTG9uZWx5UnVubmVyLmNpcmNsZU5vcm1fZ3Rfb2ZfaW50X2JhbmQnIGRlcGVuZHMgb24gYXhpb21zOiBbcHJvcGV4dCwgQ2xhc3NpY2FsLmNob2ljZSwgUXVvdC5zb3VuZF0KJ0xvbmVseVJ1bm5lci5jaXJjbGVOb3JtX2d0X29mX2FmZmluZV9vcGVuX2JhbmQnIGRlcGVuZHMgb24gYXhpb21zOiBbcHJvcGV4dCwgQ2xhc3NpY2FsLmNob2ljZSwgUXVvdC5zb3VuZF0KJ0xvbmVseVJ1bm5lci5jaXJjbGVOb3JtX25hdF9hZmZpbmVfZnJhY3QnIGRlcGVuZHMgb24gYXhpb21zOiBbcHJvcGV4dCwgQ2xhc3NpY2FsLmNob2ljZSwgUXVvdC5zb3VuZF0KJ0xvbmVseVJ1bm5lci5leGlzdHNfYWRqYWNlbnRfY3V0X2ludGVydmFsJyBkZXBlbmRzIG9uIGF4aW9tczogW3Byb3BleHQsIENsYXNzaWNhbC5jaG9pY2UsIFF1b3Quc291bmRdCidMb25lbHlSdW5uZXIuY3V0QXRvbU1lbV9jb3ZlcnNfdW5pdF9pbnRlcnZhbCcgZGVwZW5kcyBvbiBheGlvbXM6IFtwcm9wZXh0LCBDbGFzc2ljYWwuY2hvaWNlLCBRdW90LnNvdW5kXQonTG9uZWx5UnVubmVyLkN1dEF0b21NZW0nIGRlcGVuZHMgb24gYXhpb21zOiBbcHJvcGV4dCwgQ2xhc3NpY2FsLmNob2ljZSwgUXVvdC5zb3VuZF0K",
  "stdout_bytes": 825,
  "stdout_sha256": "957877af184f3162a1309d7802b725f9260d648aaea5471433804429b3c16349",
  "stdout_utf8": "'LonelyRunner.exists_nat_coprime_grid_circleNorm_ge' depends on axioms: [propext, Classical.choice, Quot.sound]\n'LonelyRunner.circleNorm_time_add_nat_div_of_dvd' depends on axioms: [propext, Classical.choice, Quot.sound]\n'LonelyRunner.circleNorm_gt_of_int_band' depends on axioms: [propext, Classical.choice, Quot.sound]\n'LonelyRunner.circleNorm_gt_of_affine_open_band' depends on axioms: [propext, Classical.choice, Quot.sound]\n'LonelyRunner.circleNorm_nat_affine_fract' depends on axioms: [propext, Classical.choice, Quot.sound]\n'LonelyRunner.exists_adjacent_cut_interval' depends on axioms: [propext, Classical.choice, Quot.sound]\n'LonelyRunner.cutAtomMem_covers_unit_interval' depends on axioms: [propext, Classical.choice, Quot.sound]\n'LonelyRunner.CutAtomMem' depends on axioms: [propext, Classical.choice, Quot.sound]\n",
  "timed_out": false,
  "wall_seconds": 1.8301744060008787
}
```

For root's one replay of the successful configuration, the exact entry command
is:

```bash
python3 -I - <<'PY'
from pathlib import Path
p = Path('research/astra-real-grid-helpers-source-review.md')
s = p.read_text(encoding='utf-8')
start = '<!-- BEGIN RETRY LAUNCHER -->\n```python\n'
end = '\n```\n<!-- END RETRY LAUNCHER -->'
assert s.count(start) == 1
code = s.split(start, 1)[1].split(end, 1)[0] + '\n'
exec(compile(code, str(p) + ':launcher', 'exec'))
PY
```

The final remaining mathematical work lies beyond these generic helpers:
the full concrete phase facts/certificate bridge, divisor-orbit reduction and
subsequent speed-family/count assembly. This acceptance establishes none of
those unimplemented declarations and makes no new runner-count or full LRC
claim. Root's separately reported focused source builds provide build
provenance; this review performed only the two recorded import invocations,
one predeclared failure and one explicitly authorized corrective retry.
