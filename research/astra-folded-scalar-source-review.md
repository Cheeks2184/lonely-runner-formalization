# Independent source review: folded scalar and half-shift identities

**Semantic decision: accept all four exact public contracts.** The complete
reviewed sources are `LonelyRunner/TwoDivisibleFoldedBand.lean`, SHA-256
`de4ec95f1dee0215cb0ded1092eca0147093131d2c76d6e96c1320432274e029`
(2,062 bytes), and `LonelyRunner/FoldedCirclePhase.lean`, SHA-256
`957606878108847d5ceff47be621ff0fc9c0a0d976568b5f5ef3dbb6db10481e`
(2,334 bytes). The single import-only probe passed all four full universal
types and all four allowed-axiom checks; complete evidence follows below.

Assigned checkpoint: `449e715`. Requested reviewer route: Astra/xhigh;
runtime-observed model and effort are unavailable in focused state. I authored
the larger mathematical plan but neither these source drafts nor root's
corrections. Terra drafted the proofs; root corrected casts and rewrites.
This review checks the final source implementations independently of their
authors. The earlier independent manuscript review is
`research/astra-two-divisible-three-plan-review.md`, SHA-256
`4d499c4477e80445646c6f82fcb72e36009ed1b9fc35b0023dd278f399598f71`;
its folded identities and scalar contracts agree with these source types.

Only this report is owned. Project configuration, workflow, policy and focused
state were read; the structural validator passed. No Lean source, root imports,
state, Git or cache edits, builds, mathematical searches or numeric fixtures
were performed. Exactly one fixed import-only probe is authorized here;
root's later exact replay is separate. No formatting option or resource
escalation is part of the probe.

## Complete semantic review

**`two_divisible_folded_band`.** The inputs are precisely arbitrary real a,b
with `0<a<1/6`, `a≤b≤1/2`, `N(3b)≤a` and `N(5b)≤a`. There is no unmentioned
fractional-part, integer-speed, positivity-of-b, maximum or runner-family
hypothesis. The needed positivity of b follows from `a>0` and `a≤b`.

The proof sets `z=round(3b)` and uses the actual quotient-norm identity
`N(3b)=|3b-z|`, not the absolute value of 3b. Its real inequalities put the
integer z strictly between -1 and 2. `omega` gives z=0 or z=1; z=0 would
force `3b≤a`, contradicting `3b≥3a>a`. Explicit real casts of z=1 then yield
`1-a≤3b≤1+a`. For `w=round(5b)`, the same absolute-error bound and these
inequalities give `1<w<3`; hence w=2 and `2-a≤5b≤2+a`.

Combining `3(2-a)≤15b≤5(1+a)` yields `1≤8a`, so the first conclusion is
closed: `1/8≤a`. The lower b bound follows from `5b≥2-a>11/6`, and the
upper follows from `3b≤1+a<7/6`. Thus the other conclusions are strictly
`11/30<b<7/18`. Their strictness comes from the input `a<1/6`, not a strict
rounding-error assertion or an assumed tie-breaking rule. All integer/real
transfers are explicit; no natural subtraction occurs.

**`exists_int_circleNorm_lift`.** This theorem applies to every real x and
returns an integer z with `x=z+N(x)` or `x=z-N(x)`. It chooses `z=round x`,
rewrites `N(x)=|x-z|`, and splits on the residual's nonnegativity. At zero
residual the plus branch applies; either residual orientation at a half-period
tie is valid. There is no uniqueness, positivity or unit-interval premise,
and negative x is covered by the same argument.

**`circleNorm_nat_mul_add_int_half`.** The declaration quantifies over every
real x, every natural n, and every integer β, with no sign or nonzero
restrictions. In the plus lift, the extra term `n*z` is an integer and is
removed by `circleNorm_add_int`. In the minus lift the exact identity is

    n*(z-N(x))+β/2 = (n*z+β) - (n*N(x)+β/2).

Here `n*z+β` is an integer for **all signed β**. Integer periodicity and
`circleNorm_neg` then prove the equality. `nth_rw 1 [hz]` replaces only the
outer occurrence of x, leaving the `N(x)` arguments on the target side
unchanged. There is no division by n, so n=0 is included. The half-shift is
essential to this identity: the theorem does not assert folding under an
arbitrary rational shift.

**`circleNorm_add_half`.** Instantiating the preceding theorem at natural
n=1 and integer β=1 reduces the goal to `N(N(x)+1/2)=1/2-N(x)`.
The proof derives `0≤N(x)≤1/2` from the absolute-error formula and
`abs_sub_round`, then subtracts the integer 1. The residual `N(x)-1/2`
lies in the closed interval `[-1/2,0]`, where its quotient norm is its
absolute value, equal to `1/2-N(x)`. Both endpoints are retained: norm zero
and norm one-half require no exception or strict inequality.

I read both complete final proofs and the relevant immediate dependency
interfaces. `FastRunnerInsertion` defines `circleNorm` as the norm in
`UnitCircle` and supplies the round formula, integer-period identity and the
closed half-interval norm formula. `StructuredClasses` supplies norm reflection.
The final sources use ordinary Lean arithmetic proofs; they contain no
`sorry`, `admit`, custom axiom, `native_decide`, certificate generation or
numerical enumeration. The probe below checks their transitive axiom lists.

Root's separately owned `research/astra-pass48-verification.json` was read at
SHA-256 `8ac6653cc0cee46696e3f1d64f23fda00d82b481fb7d73c7756abe33296eed03`.
It preserves initial compile failures and corrections. Static comparison of
the initial and final declaration types found all four unchanged. The recorded
final scalar build exited 0 with 2,999 jobs (log SHA-256
`5abac8f45278669111b19960ac3e702ab3bd0fa462037e81a3845d1f295deac1`), and
the folded build exited 0 with 3,000 jobs (log SHA-256
`4a5ee2bef5348578f23503860b9e36eb39617ea9a9b971441017c66fa0e6ef51`).
Those are root's source-build records. This reviewer performs no rebuild.

## Predeclared universal probe and exact replay

The only Lean payload consists of two direct module imports, four complete
universal type assignments and four full axiom prints. There are no case
fixtures, searches, executable table checks or unsupported formatting options.
The probe names every theorem explicitly and adds no extra hypotheses.

Probe SHA-256: `d289794bdcbd26b00c90b3dcc845758cab84b9868d45076fe8eda6ff0db819e6`
Launcher SHA-256: `eb977115de9859e147352afd42ab17b1cf82bb4d4a711541d0d30cb901c4ad2b`

Hashes cover the exact UTF-8 fence bytes, including the final newline, and
are declared before execution. The controller checks both against these
external-to-the-fence declarations. The guarded source/olean set is the two
target modules and their three immediate dependencies: `FastRunnerInsertion`,
`StructuredClasses` and `Mathlib.Tactic`. The project pins and pinned Lean/Lake
executables are also guarded. Lean is v4.32.1; the manifest pins mathlib to
commit `520045ab14e26149ee970e2e617ca04b09bde5d6`.

```lean
import LonelyRunner.TwoDivisibleFoldedBand
import LonelyRunner.FoldedCirclePhase

open LonelyRunner

example :
    ∀ (a b : ℝ), 0 < a → a < (1 : ℝ) / 6 → a ≤ b →
      b ≤ (1 : ℝ) / 2 → circleNorm (3 * b) ≤ a →
      circleNorm (5 * b) ≤ a →
        (1 : ℝ) / 8 ≤ a ∧ (11 : ℝ) / 30 < b ∧ b < (7 : ℝ) / 18 :=
  LonelyRunner.two_divisible_folded_band

example :
    ∀ x : ℝ, ∃ z : ℤ,
      x = (z : ℝ) + circleNorm x ∨ x = (z : ℝ) - circleNorm x :=
  LonelyRunner.exists_int_circleNorm_lift

example :
    ∀ (x : ℝ) (n : ℕ) (β : ℤ),
      circleNorm ((n : ℝ) * x + (β : ℝ) / 2) =
        circleNorm ((n : ℝ) * circleNorm x + (β : ℝ) / 2) :=
  LonelyRunner.circleNorm_nat_mul_add_int_half

example :
    ∀ x : ℝ, circleNorm (x + (1 : ℝ) / 2) = (1 : ℝ) / 2 - circleNorm x :=
  LonelyRunner.circleNorm_add_half

#print axioms LonelyRunner.two_divisible_folded_band
#print axioms LonelyRunner.exists_int_circleNorm_lift
#print axioms LonelyRunner.circleNorm_nat_mul_add_int_half
#print axioms LonelyRunner.circleNorm_add_half
```

The following is the single complete Bash entry, including the full Python
controller. It launches `lake env lean -j1 -s65536 --stdin`, with explicit
environment thread count 1 and stack size 65536 KiB. Address space is capped
at 8 GiB; CPU limits are 59/60 seconds; wall timeout is 60 seconds; each
regular stdout/stderr file is capped at 128 KiB. Core dumps are disabled.
Timeout kills the child process group. No automatic retry, rebuild or resource
escalation occurs. Every stream and process status is retained on failure.
All 15 guards run before and after the import-only invocation. The controller
accepts only four contiguous axiom reports for the specified symbols, with no
duplicate or disallowed axioms and no stderr.

The controller snapshots this report before execution. That snapshot and its
receipt will differ during a later replay after evidence is appended; the
probe, launcher, guarded inputs, caps and axiom output contract remain fixed.

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
report = root / 'research/astra-folded-scalar-source-review.md'
text = report.read_text()
fence = chr(96) * 3
probe = text.split(fence + 'lean\n', 1)[1].split(fence, 1)[0].encode()
launcher = text.split(fence + 'bash\n', 1)[1].split(fence, 1)[0].encode()
out = Path(tempfile.mkdtemp(prefix='astra-folded-scalar-review-'))
(out / 'stdin.bin').write_bytes(probe)
(out / 'launcher.sh').write_bytes(launcher)
(out / 'report-snapshot.md').write_bytes(text.encode())
guards = {
    'LonelyRunner/TwoDivisibleFoldedBand.lean': 'de4ec95f1dee0215cb0ded1092eca0147093131d2c76d6e96c1320432274e029',
    '.lake/build/lib/lean/LonelyRunner/TwoDivisibleFoldedBand.olean': '6432ad040c0145fbc6fee736d1aa4709e7b659a69c026d79f3608f87b46da21c',
    'LonelyRunner/FoldedCirclePhase.lean': '957606878108847d5ceff47be621ff0fc9c0a0d976568b5f5ef3dbb6db10481e',
    '.lake/build/lib/lean/LonelyRunner/FoldedCirclePhase.olean': '3032bbcf8e5c414daea831a7a415a40b4f254e5b72428b6fa078742e891afc06',
    'LonelyRunner/FastRunnerInsertion.lean': 'dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5',
    '.lake/build/lib/lean/LonelyRunner/FastRunnerInsertion.olean': '121edfbaed0d7b9fed32bacf891de838142988e48dcb4e7f2bed0c488ea49136',
    'LonelyRunner/StructuredClasses.lean': '5328a7a88d2b42f86ffc3f0f0418ca22c761219e8fa3e5822bda5a18ac286e8c',
    '.lake/build/lib/lean/LonelyRunner/StructuredClasses.olean': '4ada0ca2f0a5f20a8c83c3c2e58256e931c3b283882a88a074aeedb02d7e048f',
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
    'LonelyRunner.two_divisible_folded_band',
    'LonelyRunner.exists_int_circleNorm_lift',
    'LonelyRunner.circleNorm_nat_mul_add_int_half',
    'LonelyRunner.circleNorm_add_half',
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

## Actual execution evidence

The first and only authorized invocation **passed**. Lean and the complete
Bash entry both exited 0. All four universal assignments elaborated, and each
full axiom list was exactly `[propext, Classical.choice, Quot.sound]`.
All 15 input guards matched before and after execution, both predeclaration
hashes matched, and no timeout or stream cap was hit. Stderr was empty.
Recorded wall time: 1.8220793689833954 seconds; child peak RSS: 3,280,936 KiB.
No retry, additional probe, numeric fixture or source build occurred.

Inner evidence directory: `/tmp/astra-folded-scalar-review-w5a73kwj`.
Full receipt SHA-256:
`2dc63d876d7081ac6be5115c736f31f86b30c8a9fade88c36c5a6e6620fb67ff`.
The complete actual receipt is:

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
  "axiom_output_valid": true,
  "axioms": {
    "LonelyRunner.circleNorm_add_half": [
      "propext",
      "Classical.choice",
      "Quot.sound"
    ],
    "LonelyRunner.circleNorm_nat_mul_add_int_half": [
      "propext",
      "Classical.choice",
      "Quot.sound"
    ],
    "LonelyRunner.exists_int_circleNorm_lift": [
      "propext",
      "Classical.choice",
      "Quot.sound"
    ],
    "LonelyRunner.two_divisible_folded_band": [
      "propext",
      "Classical.choice",
      "Quot.sound"
    ]
  },
  "child_max_rss_kib": 3280936,
  "child_system_seconds": 0.572369,
  "child_user_seconds": 1.237269,
  "environment": {
    "LEAN_NUM_THREADS": "1",
    "LEAN_STACK_SIZE_KB": "65536"
  },
  "error": null,
  "exit": 0,
  "files": {
    "launcher.sh": {
      "bytes": 7869,
      "sha256": "eb977115de9859e147352afd42ab17b1cf82bb4d4a711541d0d30cb901c4ad2b"
    },
    "report-snapshot.md": {
      "bytes": 16611,
      "sha256": "e4326ef3c68a316b8dc14854c8f7854cf139ca220ed6d049065885a5a708fb16"
    },
    "stderr.bin": {
      "bytes": 0,
      "sha256": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
    },
    "stdin.bin": {
      "bytes": 1101,
      "sha256": "d289794bdcbd26b00c90b3dcc845758cab84b9868d45076fe8eda6ff0db819e6"
    },
    "stdout.bin": {
      "bytes": 401,
      "sha256": "2d49b576e06f8885dfeb320bb2691fd1b55f5b62726d7d000fb13bb5fd1bf843"
    }
  },
  "guards": {
    ".lake/build/lib/lean/LonelyRunner/FastRunnerInsertion.olean": "121edfbaed0d7b9fed32bacf891de838142988e48dcb4e7f2bed0c488ea49136",
    ".lake/build/lib/lean/LonelyRunner/FoldedCirclePhase.olean": "3032bbcf8e5c414daea831a7a415a40b4f254e5b72428b6fa078742e891afc06",
    ".lake/build/lib/lean/LonelyRunner/StructuredClasses.olean": "4ada0ca2f0a5f20a8c83c3c2e58256e931c3b283882a88a074aeedb02d7e048f",
    ".lake/build/lib/lean/LonelyRunner/TwoDivisibleFoldedBand.olean": "6432ad040c0145fbc6fee736d1aa4709e7b659a69c026d79f3608f87b46da21c",
    ".lake/packages/mathlib/.lake/build/lib/lean/Mathlib/Tactic.olean": "0534ef12e7aaf8ffbb6e520a91f922da4469d0dca2b54c87b4458e1faa28a6a2",
    ".lake/packages/mathlib/Mathlib/Tactic.lean": "c6f2c548596b635a3d5c8aff8b19cbdeb60dd54e41bb89a1cd03b1a54d335fa5",
    "/home/joshua/.elan/toolchains/leanprover--lean4---v4.32.1/bin/lake": "60330ab6f07dce20f3fa9ebb08e8b984ea9549eac172afeb15d9d2227060e2b3",
    "/home/joshua/.elan/toolchains/leanprover--lean4---v4.32.1/bin/lean": "e8baaa71855a616dc351028f3ad2200051b0671f423a1696a100e809302d5550",
    "LonelyRunner/FastRunnerInsertion.lean": "dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5",
    "LonelyRunner/FoldedCirclePhase.lean": "957606878108847d5ceff47be621ff0fc9c0a0d976568b5f5ef3dbb6db10481e",
    "LonelyRunner/StructuredClasses.lean": "5328a7a88d2b42f86ffc3f0f0418ca22c761219e8fa3e5822bda5a18ac286e8c",
    "LonelyRunner/TwoDivisibleFoldedBand.lean": "de4ec95f1dee0215cb0ded1092eca0147093131d2c76d6e96c1320432274e029",
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
  "stream_cap_hit": false,
  "timed_out": false,
  "wall_seconds": 1.8220793689833954
}
```

Complete Lean stdout, 401 bytes, SHA-256
`2d49b576e06f8885dfeb320bb2691fd1b55f5b62726d7d000fb13bb5fd1bf843`:

```text
'LonelyRunner.two_divisible_folded_band' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.exists_int_circleNorm_lift' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.circleNorm_nat_mul_add_int_half' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.circleNorm_add_half' depends on axioms: [propext, Classical.choice, Quot.sound]
```

Complete Lean stderr is empty: 0 bytes, SHA-256
`e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.
The exact stdin, launcher, complete pre-execution report snapshot, complete
stdout/stderr and receipt are retained in the inner directory. The snapshot
SHA-256 is `e4326ef3c68a316b8dc14854c8f7854cf139ca220ed6d049065885a5a708fb16`.

The complete Bash entry's output was additionally captured in ordinary files
in `/tmp/astra-folded-scalar-entry-6q4sdzlw`. Its stdout consists of the inner
receipt and its directory/hash labels followed by the complete raw streams;
its stderr is empty. The capture executed the exact extracted Bash fence
once, recorded its returned status, and hashed the three files. It introduced
no additional Lean invocation. Outer receipt SHA-256:
`f73bfc4b4c1c94f4e8d2ac351d7ead53c6fb7702e3f11f0981db2e22086b413a`.

```json
{
  "exit": 0,
  "files": {
    "entrypoint.sh": {
      "bytes": 7869,
      "sha256": "eb977115de9859e147352afd42ab17b1cf82bb4d4a711541d0d30cb901c4ad2b"
    },
    "stderr.bin": {
      "bytes": 0,
      "sha256": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
    },
    "stdout.bin": {
      "bytes": 4257,
      "sha256": "9fb6e3fa30a767b8ce41ef68b5183d464ce42cab87f895ccf53cda7615c26a86"
    }
  }
}
```


Total retained regular-file evidence in the two named directories: 42,208 bytes.

The semantic review and import-only verification accept these four exact
source contracts. Root must read this frozen report and replay the sole Bash
entry before integration. These scalar identities and bounds do not establish
Proposition 3.1, a new canonical runner count, or unrestricted LRC. The overall
goal remains active.
