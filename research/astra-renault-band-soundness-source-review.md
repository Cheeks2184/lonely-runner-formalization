# Independent review of Renault phase-band soundness

Semantic decision: **accept the two frozen source modules at their exact
supplied-facts scope**. No source correction is requested. This decision is
from complete source and contract review; execution status is recorded
separately below.

Assigned checkpoint: `a854ae8`. Requested reviewer route: Astra/xhigh;
runtime-observed model and effort are unavailable in focused state. I did not
author either reviewed source. I read current project configuration, workflow,
policy and focused state, both complete modules, the entire accepted concrete
bridge plan, and the relevant local dependency interfaces and proof bodies.
The workflow validator exited 0. Only this report is owned by this task;
other sources, reports, shared caches, Git, root imports/audit and state are
preserved.

Frozen primary inputs:

| File | SHA-256 |
| --- | --- |
| `LonelyRunner/RenaultPhaseBandFacts.lean` | `c775da2dfb8d3c6ff24f6d66c49d7b690f3422cc7dc95b410c064cc08c78d721` |
| `LonelyRunner/RenaultPhaseBandSoundness.lean` | `b7773a0755413e03371c2322d221bfda68cf1174bcbfac694e61a4803189ccf7` |
| `research/astra-renault-phase-concrete-bridge-plan.md` | `ec29e6cba74dd87a9db823e712fba099d47d6277bf52b2d227ce2d633e0dca60` |

## Definitions and exact semantic scope

The five natural definitions match the accepted plan without alteration.
For k<20 the candidate has slope `2+k/5` and sixth-turn shift `1+k%5`,
corresponding to all slopes 2 through 5 and shifts 1 through 5 in the prescribed
order. For k=20,21,22 the slope is one and shifts are respectively 1,2,4.
The `Fin 23` bound makes these the only three remaining indices. This decoding
is symbolic inspection, not a candidate enumeration or finite test.

For even atom index a the representative numerator is twice `C(a/2)`; for
odd a it is `C(a/2)+C(a/2+1)`. Dividing either by 720 gives the singleton
point or open interval midpoint on the cut scale 360. `phaseNumerator` is
exactly slope times this representative plus 120 times the shift, and
`phaseQuotient` is its natural quotient by 720. There is no signed or
truncated subtraction in these definitions.

`PhaseBandFacts C M` is a proposition about arbitrary `C : Nat → Nat` and
`M : Fin 120 → Nat`, with precisely four fields: the cut endpoints, the
true-bit singleton bounds, and the true-bit interval endpoint bounds. The
singleton bounds are inclusive 120 and 600 for the first 20 candidates and
strict 120 and 600 for the last three. The interval field has inclusive
endpoint inequalities for every candidate kind. It selects one integer band
using the prescribed natural quotient. It supplies no real-floor premise,
monotonicity of C, false-bit semantics, mask-size bound, finite table, or
unconditional existence of such facts.

The four public theorems have the requested meanings:

- `phaseSlope_pos` is positive for every candidate, by the defining split.
- `phaseGood_iff` is the exact closed/strict affine decoding of the existing
  `PhaseGood`, for every real x and every k. Its strict branch uses slope one;
  simplification removes `1*x`. No threshold is weakened.
- `phaseGood_fract` is an equivalence for every real x, including negative
  and integer values, and preserves strictness as well as closed safety.
- `phaseBandFacts_sound` takes arbitrary C,M and a supplied proof of all
  `PhaseBandFacts C M`. For every a,k, a true bit expressed as candidate-set
  membership implies `PhaseGood k x` for every real x satisfying the exact
  singleton/open `CutAtomMem` predicate. There is no hidden restriction to
  rational phases, interior-only phases, sorted cuts, or a concrete table.

## Proof review

For a singleton let c=C(a/2), A=phaseSlope(k), B=phaseShift(k),
N=A*(2*c)+120*B, Q=N/720, and R=N%720. Atom membership gives x=c/360.
`Nat.div_add_mod` gives `720*Q+R=N`. Casting this exact equality to the reals
and using the positive literal denominators yields

    A*x+B/6 = N/720 = Q+R/720.

For a closed candidate the supplied inequalities `120<=R<=600` put this
phase in `[Q+1/6,Q+5/6]`. The proof uses
`circleNorm_ge_of_int_band` with q=(Q:Int), and supplies its nonnegative and
at-most-one-half margin hypotheses at 1/6. For a strict candidate the
inequalities `120<R<600` put the phase strictly between those boundaries;
`circleNorm_gt_of_int_band` gives the required strict norm bound. Casting a
natural Q to Int and then Real preserves Q exactly. There is no assertion
that Q equals the floor of an arbitrary real phase.

For an open atom let L=C(a/2)/360 and U=C(a/2+1)/360. Membership gives
L<x<U. The interval facts, cast to the reals and divided by 360, say

    Q+1/6 <= A*L+B/6,
    A*U+B/6 <= Q+5/6.

Since A>0, the interior affine value lies strictly between the endpoint
affine values. Thus it lies strictly inside the same integer band, even if
an endpoint inequality is an equality. The generic affine-open lemma gives
`1/6 < circleNorm(A*x+B/6)`. The strict candidate branch retains this strict
bound; the closed branch alone uses `le_of_lt`. The chosen quotient is used
only as a band label. The supplied endpoint facts suffice without proving
that it is a floor at the midpoint or at every interior point.

This checks all four parity/candidate-kind branches. An open endpoint itself
is excluded by `CutAtomMem`, and is handled by a singleton when coverage is
later assembled. Equality at a singleton is accepted only for a closed
candidate. Empty or reversed intervals create no defect: their membership
premise cannot be satisfied. The proof neither discards endpoints as a
measure-zero exception nor infers strictness from mere continuity.

The local strict-band dependency was read: it chooses the minimum distance
to the two band endpoints, proves this margin exceeds the requested one,
and applies the existing closed-band theorem. The affine-open dependency
uses positive slope to obtain the two strict interior inequalities. These
are exact real proofs. The integer-periodicity dependency was also read:
`x=floor(x)+fract(x)` produces an additive integer `A*floor(x)`, even when
the floor is negative. `circleNorm_nat_affine_fract` preserves the arbitrary
real offset, and `phaseGood_fract` rewrites both candidate branches by this
norm equality. There is no conversion of a negative floor to Nat.

The fields `first` and `last` are retained in `PhaseBandFacts` but are not
used by `phaseBandFacts_sound`; they are for the separate coverage step.
The imported `cutAtomMem_covers_unit_interval` can consume these endpoints
at n=60,D=360 and requires no monotonicity, but the reviewed soundness theorem
does not invoke coverage. In particular universal quantification over real
x under atom membership is not a claim that these atoms cover all real x.
The later fractional-part normalization supplies the reduction to [0,1).

## Predeclared import-only probe

Before execution, the fixed probe below was declared to assign full universal
types to all four public theorems, check all five natural defining equations
by `rfl`, and check the full four-field `PhaseBandFacts` constructor type.
It prints axioms for the four public theorems. All parameters remain generic;
there is no concrete cut table, mask table, numerical phase control, decision
procedure, search, enumeration, solver, or source build in this probe.

The sole invocation is `lake env lean -j1 -s65536 --stdin`, with
`LEAN_NUM_THREADS=1` and `LEAN_STACK_SIZE_KB=65536`. Default-thread launch is
forbidden and is not attempted. Limits are AS 8 GiB, CPU soft/hard 59/60
seconds, wall 60 seconds, and 128 KiB per regular output stream. Any failure
is retained without escalating resources. The wrapper captures exact stdin,
stdout, stderr, launcher source, the pre-execution report, and a JSON receipt,
including frozen source/olean/dependency guards before and after the child.

```lean
import LonelyRunner.RenaultPhaseBandSoundness

open LonelyRunner

example (k : Fin 23) : phaseSlope k =
    (if k.val < 20 then 2 + k.val / 5 else 1) := rfl

example (k : Fin 23) : phaseShift k =
    (if k.val < 20 then 1 + k.val % 5
     else if k.val = 20 then 1 else if k.val = 21 then 2 else 4) := rfl

example (C : Nat → Nat) (a : Fin 120) : phaseRepresentative C a =
    (if a.val % 2 = 0 then 2 * C (a.val / 2)
     else C (a.val / 2) + C (a.val / 2 + 1)) := rfl

example (C : Nat → Nat) (a : Fin 120) (k : Fin 23) :
    phaseNumerator C a k =
      phaseSlope k * phaseRepresentative C a + 120 * phaseShift k := rfl

example (C : Nat → Nat) (a : Fin 120) (k : Fin 23) :
    phaseQuotient C a k = phaseNumerator C a k / 720 := rfl

example : ∀ (C : Nat → Nat) (M : Fin 120 → Nat),
    C 0 = 0 → C 60 = 360 →
    (∀ (a : Fin 120) (k : Fin 23),
      a.val % 2 = 0 → (M a).testBit k.val = true →
        if k.val < 20 then
          120 ≤ phaseNumerator C a k % 720 ∧
            phaseNumerator C a k % 720 ≤ 600
        else
          120 < phaseNumerator C a k % 720 ∧
            phaseNumerator C a k % 720 < 600) →
    (∀ (a : Fin 120) (k : Fin 23),
      a.val % 2 ≠ 0 → (M a).testBit k.val = true →
        360 * phaseQuotient C a k + 60 ≤
            phaseSlope k * C (a.val / 2) + 60 * phaseShift k ∧
          phaseSlope k * C (a.val / 2 + 1) + 60 * phaseShift k ≤
            360 * phaseQuotient C a k + 300) →
    PhaseBandFacts C M :=
  @PhaseBandFacts.mk

example : ∀ k : Fin 23, 0 < phaseSlope k := phaseSlope_pos

example : ∀ (k : Fin 23) (x : ℝ),
    PhaseGood k x ↔
      if k.val < 20 then
        (1 : ℝ) / 6 ≤ circleNorm
          ((phaseSlope k : ℝ) * x + (phaseShift k : ℝ) / 6)
      else
        (1 : ℝ) / 6 < circleNorm
          ((phaseSlope k : ℝ) * x + (phaseShift k : ℝ) / 6) :=
  phaseGood_iff

example : ∀ (k : Fin 23) (x : ℝ),
    PhaseGood k (Int.fract x) ↔ PhaseGood k x :=
  phaseGood_fract

example : ∀ (C : Nat → Nat) (M : Fin 120 → Nat), PhaseBandFacts C M →
    ∀ (a : Fin 120) (k : Fin 23), k ∈ maskCandidates 23 (M a) →
      ∀ x : ℝ, CutAtomMem C 360 a.val x → PhaseGood k x :=
  phaseBandFacts_sound

#print axioms LonelyRunner.phaseSlope_pos
#print axioms LonelyRunner.phaseGood_iff
#print axioms LonelyRunner.phaseGood_fract
#print axioms LonelyRunner.phaseBandFacts_sound
```

The single Bash fence is the complete reproducible entrypoint. It extracts
the fixed Lean fence from this report and imports the already built modules;
it never invokes Lake build or produces a source olean. The exact guards bind
the reviewed source, its mapped local inputs, pinned manifest/toolchain,
accepted plan, and six imported local artifacts.

```bash
#!/usr/bin/env bash
set -euo pipefail
cd /home/joshua/lonely-runner-formalization
export PATH="$HOME/.elan/bin:$PATH"
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
import subprocess
import tempfile
import time

root = Path('/home/joshua/lonely-runner-formalization')
report = root / 'research/astra-renault-band-soundness-source-review.md'
text = report.read_text()
fence = chr(96) * 3
probe = text.split(fence + 'lean\n', 1)[1].split(fence, 1)[0].encode()
launcher = text.split(fence + 'bash\n', 1)[1].split(fence, 1)[0].encode()
out = Path(tempfile.mkdtemp(prefix='astra-renault-band-review-'))
(out / 'stdin.bin').write_bytes(probe)
(out / 'launcher.sh').write_bytes(launcher)
(out / 'predeclared-report.md').write_bytes(text.encode())
guards = {
    'LonelyRunner/RenaultPhaseBandFacts.lean': 'c775da2dfb8d3c6ff24f6d66c49d7b690f3422cc7dc95b410c064cc08c78d721',
    'LonelyRunner/RenaultPhaseBandSoundness.lean': 'b7773a0755413e03371c2322d221bfda68cf1174bcbfac694e61a4803189ccf7',
    'LonelyRunner/RealPhaseBands.lean': '7f70467bad6bb5a8a859bff8947af1dc73e685910b69157b49bab259b3c02ca0',
    'LonelyRunner/FiniteCutCover.lean': 'b7e7e50834bc86d13ffde759e3d0c2dc4d2480a03ec61eb88a70ca215fcc1011',
    'LonelyRunner/RenaultPhaseCertificates.lean': '36b58c04e0c755d462f32bae3388c30d744d97ccb20a3bc27aa0daa99b7e49f0',
    'LonelyRunner/FiniteMaskCertificates.lean': '72629bc0780161890a31dd705b744c7ce2a77c884a915d7eaf4b3d69855b181e',
    'LonelyRunner/StructuredClasses.lean': '5328a7a88d2b42f86ffc3f0f0418ca22c761219e8fa3e5822bda5a18ac286e8c',
    'LonelyRunner/FastRunnerInsertion.lean': 'dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5',
    'research/astra-renault-phase-concrete-bridge-plan.md': 'ec29e6cba74dd87a9db823e712fba099d47d6277bf52b2d227ce2d633e0dca60',
    'lean-toolchain': '8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af',
    'lake-manifest.json': '887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218',
    'lakefile.toml': 'bdcbaaa18d518409619215e8acf7892452c1fa5c6e80ba742ce67f7380682a26',
    '.lake/build/lib/lean/LonelyRunner/RenaultPhaseBandFacts.olean': 'd1bae95cbd3ccfde10a90f58fe650d81cd4d6120bb815c4d9558c08b09d34a77',
    '.lake/build/lib/lean/LonelyRunner/RenaultPhaseBandSoundness.olean': '4867093c71b4b6e5d29dfc3255b426159f367aafccd5393543d9487fb40e1e4f',
    '.lake/build/lib/lean/LonelyRunner/RealPhaseBands.olean': '7442f9f49d9f1e2d214460557f6a891ba13717ededff679876033793ac2c6504',
    '.lake/build/lib/lean/LonelyRunner/FiniteCutCover.olean': 'e135595b4c42102e9e2736492c39fc95914e1d09800615c3d943553abedc1ade',
    '.lake/build/lib/lean/LonelyRunner/RenaultPhaseCertificates.olean': '9ec36c868453c9889f616f0f4dd5d0a4d3a5d477fa09b07da786b3164b38e666',
    '.lake/build/lib/lean/LonelyRunner/FiniteMaskCertificates.olean': 'f0ca24c85fa4ecef7643feec5c77d277fcbf62c312a65eb081a5161c6005cfb6',
}
argv = ['lake', 'env', 'lean', '-j1', '-s65536', '--stdin']
limits = {'address_space_bytes': 8 * 1024**3, 'cpu_seconds': [59, 60],
          'wall_seconds': 60, 'stream_bytes': 128 * 1024}
receipt = {'argv': argv, 'limits': limits, 'guards': guards,
           'exit': None, 'timed_out': False, 'error': None,
           'guards_before': False, 'guards_after': False,
           'probe_expected_sha256': '19d524cb19a668dc5b9ffda4a4a21ff4a12f252b9c7af42229479bfa781ef69a'}
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
    assert sha(probe) == receipt['probe_expected_sha256'], 'probe bytes'
    check_guards()
    receipt['guards_before'] = True
    with (out / 'stdin.bin').open('rb') as stdin, \
            (out / 'stdout.bin').open('wb') as stdout, \
            (out / 'stderr.bin').open('wb') as stderr:
        proc = subprocess.Popen(argv, cwd=root, stdin=stdin, stdout=stdout,
                                stderr=stderr, env=os.environ.copy(),
                                start_new_session=True, preexec_fn=capped_child)
        try:
            receipt['exit'] = proc.wait(timeout=limits['wall_seconds'])
        except subprocess.TimeoutExpired:
            receipt['timed_out'] = True
            os.killpg(proc.pid, signal.SIGKILL)
            receipt['exit'] = proc.wait()
    check_guards()
    receipt['guards_after'] = True
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
    for name in ['stdin.bin', 'stdout.bin', 'stderr.bin', 'launcher.sh', 'predeclared-report.md']:
        data = (out / name).read_bytes()
        receipt['files'][name] = {'bytes': len(data), 'sha256': sha(data)}
    receipt['stream_cap_hit'] = any(receipt['files'][name]['bytes'] >= limits['stream_bytes']
                                    for name in ['stdout.bin', 'stderr.bin'])
    receipt['passed'] = (receipt['exit'] == 0 and receipt['error'] is None
                         and receipt['guards_before'] and receipt['guards_after']
                         and not receipt['timed_out']
                         and not receipt['stream_cap_hit'])
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

## Actual execution evidence

The first and only authorized probe passed without modification or cap
escalation. The child and its launcher both exited 0. All four universal
theorem assignments, the five defining equations, and the exact constructor
assignment elaborated. Both pre- and post-execution checks matched all 18
guards. There was no timeout, stream-cap hit, diagnostic, or stderr.

Measured wrapper wall time was 1.8720271740166936 seconds; child user/system
CPU were 1.264583 and 0.5653549999999999 seconds, with recorded child maximum
RSS 3,284,804 KiB. These are this run's measurements; the resource limits in
the launcher and receipt are the predeclared limits. No default-thread launch,
source build, finite-table enumeration, or second Lean invocation occurred.

Retained exact evidence: `/tmp/astra-renault-band-review-gbdgi5fo`.
The directory contains the five files recorded below plus `receipt.json`;
the pre-execution report is preserved as a complete byte snapshot.

| File | Bytes | SHA-256 |
| --- | ---: | --- |
| `stdin.bin` | 2419 | `19d524cb19a668dc5b9ffda4a4a21ff4a12f252b9c7af42229479bfa781ef69a` |
| `stdout.bin` | 344 | `2ff414a7978b3f7590f381958323041cc865592f63e4e331fb077d10ec3de216` |
| `stderr.bin` | 0 | `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855` |
| `launcher.sh` | 6735 | `6bef1fbae6de7a01d55ce3837256c8c9a2acf16cf346660cd37ce5d0cb0f3d3b` |
| `predeclared-report.md` | 17790 | `a09b8f2fb939de12867497c7e56e3101732e718c6bf6e193a012cd70cf653000` |
| `receipt.json` | 3465 | `4254fc1991b4adf702ae534c4369962fbfde48254e1648843afa5b9cfc811e57` |

Complete Lean stdout (the entire stderr is the empty byte string):

```text
'LonelyRunner.phaseSlope_pos' depends on axioms: [propext, Quot.sound]
'LonelyRunner.phaseGood_iff' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.phaseGood_fract' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.phaseBandFacts_sound' depends on axioms: [propext, Classical.choice, Quot.sound]
```

`phaseSlope_pos` depends on `propext` and `Quot.sound`. The other three
reviewed theorems depend only on `propext`, `Classical.choice`, and `Quot.sound`.
All four are within the project's allowed axiom set. These are actual imported
declaration results, not expected output or a replacement for root's source
build evidence.

Complete captured receipt:

```json
{
  "argv": [
    "lake",
    "env",
    "lean",
    "-j1",
    "-s65536",
    "--stdin"
  ],
  "child_max_rss_kib": 3284804,
  "child_system_seconds": 0.5653549999999999,
  "child_user_seconds": 1.264583,
  "error": null,
  "exit": 0,
  "files": {
    "launcher.sh": {
      "bytes": 6735,
      "sha256": "6bef1fbae6de7a01d55ce3837256c8c9a2acf16cf346660cd37ce5d0cb0f3d3b"
    },
    "predeclared-report.md": {
      "bytes": 17790,
      "sha256": "a09b8f2fb939de12867497c7e56e3101732e718c6bf6e193a012cd70cf653000"
    },
    "stderr.bin": {
      "bytes": 0,
      "sha256": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
    },
    "stdin.bin": {
      "bytes": 2419,
      "sha256": "19d524cb19a668dc5b9ffda4a4a21ff4a12f252b9c7af42229479bfa781ef69a"
    },
    "stdout.bin": {
      "bytes": 344,
      "sha256": "2ff414a7978b3f7590f381958323041cc865592f63e4e331fb077d10ec3de216"
    }
  },
  "guards": {
    ".lake/build/lib/lean/LonelyRunner/FiniteCutCover.olean": "e135595b4c42102e9e2736492c39fc95914e1d09800615c3d943553abedc1ade",
    ".lake/build/lib/lean/LonelyRunner/FiniteMaskCertificates.olean": "f0ca24c85fa4ecef7643feec5c77d277fcbf62c312a65eb081a5161c6005cfb6",
    ".lake/build/lib/lean/LonelyRunner/RealPhaseBands.olean": "7442f9f49d9f1e2d214460557f6a891ba13717ededff679876033793ac2c6504",
    ".lake/build/lib/lean/LonelyRunner/RenaultPhaseBandFacts.olean": "d1bae95cbd3ccfde10a90f58fe650d81cd4d6120bb815c4d9558c08b09d34a77",
    ".lake/build/lib/lean/LonelyRunner/RenaultPhaseBandSoundness.olean": "4867093c71b4b6e5d29dfc3255b426159f367aafccd5393543d9487fb40e1e4f",
    ".lake/build/lib/lean/LonelyRunner/RenaultPhaseCertificates.olean": "9ec36c868453c9889f616f0f4dd5d0a4d3a5d477fa09b07da786b3164b38e666",
    "LonelyRunner/FastRunnerInsertion.lean": "dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5",
    "LonelyRunner/FiniteCutCover.lean": "b7e7e50834bc86d13ffde759e3d0c2dc4d2480a03ec61eb88a70ca215fcc1011",
    "LonelyRunner/FiniteMaskCertificates.lean": "72629bc0780161890a31dd705b744c7ce2a77c884a915d7eaf4b3d69855b181e",
    "LonelyRunner/RealPhaseBands.lean": "7f70467bad6bb5a8a859bff8947af1dc73e685910b69157b49bab259b3c02ca0",
    "LonelyRunner/RenaultPhaseBandFacts.lean": "c775da2dfb8d3c6ff24f6d66c49d7b690f3422cc7dc95b410c064cc08c78d721",
    "LonelyRunner/RenaultPhaseBandSoundness.lean": "b7773a0755413e03371c2322d221bfda68cf1174bcbfac694e61a4803189ccf7",
    "LonelyRunner/RenaultPhaseCertificates.lean": "36b58c04e0c755d462f32bae3388c30d744d97ccb20a3bc27aa0daa99b7e49f0",
    "LonelyRunner/StructuredClasses.lean": "5328a7a88d2b42f86ffc3f0f0418ca22c761219e8fa3e5822bda5a18ac286e8c",
    "lake-manifest.json": "887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218",
    "lakefile.toml": "bdcbaaa18d518409619215e8acf7892452c1fa5c6e80ba742ce67f7380682a26",
    "lean-toolchain": "8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af",
    "research/astra-renault-phase-concrete-bridge-plan.md": "ec29e6cba74dd87a9db823e712fba099d47d6277bf52b2d227ce2d633e0dca60"
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
  "probe_expected_sha256": "19d524cb19a668dc5b9ffda4a4a21ff4a12f252b9c7af42229479bfa781ef69a",
  "stream_cap_hit": false,
  "timed_out": false,
  "wall_seconds": 1.8720271740166936
}
```

The single Bash fence above is byte-for-byte the executed launcher, SHA-256
`6bef1fbae6de7a01d55ce3837256c8c9a2acf16cf346660cd37ce5d0cb0f3d3b`.
Its fixed Lean stdin is SHA-256
`19d524cb19a668dc5b9ffda4a4a21ff4a12f252b9c7af42229479bfa781ef69a`.
Both hashes were sent to root before the one invocation. Root can replay
that exact entrypoint after reading this complete report. A replay retains
its own evidence directory; timing, RSS, the final-report snapshot and
therefore receipt hashes will vary, while the source/olean/probe guards and
axiom stdout remain the fixed comparison targets.

## Final boundary

Semantic acceptance and the successful execution are separate conclusions.
This review accepts the exact generic implication from supplied natural band
facts to real `PhaseGood` on each specified singleton or open atom. It does
not instantiate `PhaseBandFacts` for concrete literals, link core masks and
dominators, assemble coverage and the common-candidate theorem, or prove
Renault 5.1 for all phases. No new runner count, six-total supply, H7/H8
completion, or unrestricted LRC result is claimed. Root's separate focused
source builds are not relabeled as builds performed by this review. Only the
owned report and retained temporary evidence were written; no Lean, root
import, audit, Git, shared cache, or state change was made.
