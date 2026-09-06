# Independent source review: boundary divisibility and signed anchor phases

**Source semantic decision: accept all four exact public contracts.** The
one predeclared import-only probe also passed all four universal theorem
assignments and all four allowed-axiom checks. Its complete actual execution
evidence is retained separately below; no payload or limit changed.

The complete reviewed sources are `LonelyRunner/BoundaryZeroDivisibility.lean`,
SHA-256 `a01608409d16b3ce50ebfe65f19bf003c1c9d4d02f94623257e7e6a2b258f1f5`
(2,132 bytes), and `LonelyRunner/SixthAffineSpecialAnchor.lean`, SHA-256
`6c78c1e4fdde4d25afbb03aadbcd16d6a0f7f7bc83aa287ede4f1a3ac3e2756e`
(1,217 bytes). I read every declaration and full proof in both files.
I authored the larger two-divisible and assembly manuscripts, not these Lean
sources or root's corrections. This source review is independent of Terra's
implementation and root's edits; the larger plan separately received the
independent manuscript review `4d499c4477e80445646c6f82fcb72e36009ed1b9fc35b0023dd278f399598f71`.

Assigned checkpoint: `1156abc`; requested reviewer route Astra/xhigh; exposed
observed model and effort null. Project configuration, workflow, policy and
focused research/in_progress state were read, and the structural validator
passed. Only this report is owned. No source, import, state, Git or shared-cache
edits, builds, numeric fixtures, searches or finite computations are authorized
or performed in this review. The one fixed import-only probe is separate from
root's subsequent requested exact replay.

## Full semantic review

Write N(x)=circleNorm x in the explanatory mathematics.

**`dvd_of_circleNorm_nat_div_eq_zero`.** The exact inputs are natural M,a,
`0<M`, and `N(a/M)=0`. The conclusion is natural divisibility M∣a; no positivity
of a, primitivity, modulus bound, or prime-modulus assumption is added.
Under M∤a, the checked small-denominator helper gives cyclic residue distance
at least one. `circleNorm_nat_div_ge` then gives `1/M≤N(a/M)=0`, contradicting
`1/M>0`. This argument works for composite M, M=1, and a=0; in the latter two
situations the contradiction premise M∤a cannot hold where appropriate.
M's positivity is essential to the proof and remains in the public type.

The residue bridge used here is source-grounded: `cyclicResidueDistance M a`
is `min (a % M) (M-a%M)`. Positive M and a nonzero remainder put both
natural distances above zero. The norm lower-bound theorem uses natural
Euclidean division, obtains the real closed residue band with margin 1/M,
and invokes `circleNorm_ge_of_int_band`. It does not treat any nonzero
composite residue as invertible. No finite candidate test is used.

**`dvd_or_dvd_of_five_sixths_pair_zero`.** The exact input is natural a,b,c
with c>0 and a SUPPLIED all-real hypothesis: every t with `fract(t*c)=5/6`
has pair-norm minimum zero. The conclusion is `6*c∣a ∨ 6*c∣b` in Nat.
The proof neither establishes hzero nor derives it from a no-witness premise.
There is no runner family, gcd, norm ordering, maximum, or positivity-of-a/b
hypothesis hidden in this bridge. Zero or equal measured speeds remain valid.

It chooses the actual negative time `t=-1/((6*c : Nat) : Real)`. Positivity
of c justifies cancellation and proves the exact identity

    t*c = -1/6 = (-1 : Int) + 5/6.

`Int.fract_intCast_add` removes the integer -1, and the remaining fractional
part is exactly 5/6. A positive test time 1/(6c) would give the wrong anchor;
the source retains the negative time and the hypothesis quantifies over it.
From hzero at this time, total order selects the smaller of the two norms.
`min_eq_left` or `min_eq_right` therefore identifies that selected norm with
zero; equality of the two norms is harmless. The source does not need an
extra min-zero lemma with unstated sign conditions.

For the selected a or b, `t*a=-(a/(6c))` exactly. The final source rewrites
this identity and `circleNorm_neg` in the known zero-norm hypothesis, producing
the positive-quotient zero needed by the first theorem. Its denominator is
the full natural product `6*c`, positive by c>0. There is no cancellation of
the factor six from the divisibility conclusion and no real/integer
reinterpretation of that Nat statement. If a=0 the left divisibility is valid;
if b=0 the right is valid, so no excluded zero-speed case is being smuggled in.

**`circleNorm_add_signed_half`.** The theorem takes arbitrary real x, integer
σ, and exactly `σ=1∨σ=-1`. The positive branch is the same expression.
In the negative branch,

    x-1/2 = (-1 : Int) + (x+1/2),

so integer periodicity proves equal norms. Negative x, integral x and all
boundary phases are covered. This is a half-shift identity for the stated two
signs; it does not assert invariance under an arbitrary sixth translation.

**`fract_sixth_affine_special_anchor`.** The inputs are arbitrary real τ,
natural c,n,κ, integers z,σ, the exact decomposition `c=6z+κσ` after casting,
`σ=1∨σ=-1`, and `fract(τ*c)=5/6`. There is no restriction κ∈{1,2}, n>0,
3∤c or z≥0. n=0 and κ=0 are included. c=0 is not explicitly excluded,
although the supplied anchor hypothesis would then be impossible.

The proof instantiates `fract_sixth_affine_time` with signed residue e=κσ,
integer α=n and β=σ. After the supplied anchor rewrite, the remaining real
expression is `(5*n+κ*σ²)/6`; each sign has σ²=1. Ordinary cast/ring
normalization gives the asserted equality with `fract((5*n+κ)/6)`. Thus the
right numerator really is the natural `5*n+κ`, even for negative σ, z or τ.
No truncated natural subtraction replaces a negative signed term.

The conclusion is ONLY a fractional-part identity. For general n,κ it need
not be one of the odd-sixth phases; that requires subsequent specific choices.
In particular it asserts neither a safe norm nor a general sixth-affine
folding identity. The signed orientation cancellation is in the integer
product σ*(κσ), not an assumption that an actual phase equals its norm.

I read the complete direct project dependency sources `SmallDenominatorWitness`,
`SixthAffinePhase`, and `FoldedCirclePhase`, the relevant closed-band/reflection
proofs in `StructuredClasses`, and the full residue lower-bound proof in
`PivotResidues`. The underlying `FastRunnerInsertion` definition identifies
circleNorm with the norm on UnitCircle and supplies integer periodicity.
The target declarations use ordinary Lean proof terms, with no custom axiom,
sorry/admit or native computation. The probe checks their transitive axiom sets.

## Earlier build records versus this review

Root's separate `research/astra-pass51-verification.json` was read at SHA-256
`eb05d3af49e6fad45f8ce1ffd776a2dfeac0047dd33886453b56e42f7e38a9c0`.
It retains the first boundary build's actual exit 1, unknown
`Int.fract_int_add`, and the two incorrectly targeted norm rewrites. The
correction uses the actual `Int.fract_intCast_add` API and rewrites in ha0/hb0.
Static comparison of both boundary declaration headers against the preserved
initial source found their full types unchanged. The final boundary build
exited 0 at 3,002 jobs.

The anchor module passed unchanged at 3,002 jobs, exit 0, while emitting TWO
informational `ring_nf` suggestions containing the tactic text “failed to
close the goal.” The recorded build nevertheless succeeded; these are not
errors or a failed theorem check. Their complete actual output remains in
root's receipt. This reviewer performs no rebuild and does not erase that
message history. The import-only probe's stdout is captured independently.

## Predeclared fixed probe and sole replay entry

The exact payload contains two direct imports, four full universal type
assignments and four full axiom prints. There are no local numeric controls,
case enumerations, helper proof experiments, or formatting options.
The hashes below cover the exact UTF-8 fence bytes, including final newlines,
and are fixed before execution.

Probe SHA-256: `e155eb86754e2e3bd8905c297ccdecaf5b9064f6802f7903c0cc93d5c5dc397a`
Launcher SHA-256: `c3feebd8f21157e0013e5ccdfc52c7feb10130c3c62a77f339d6899d5950b687`

The complete Python controller is embedded in the single Bash entry below.
Its 23 guards bind both target source/olean pairs, their four immediate
project dependencies and the Mathlib.Tactic umbrella, the additional relevant
PivotResidues/FastRunnerInsertion source/oleans, the three project pins and
both pinned runtime binaries. PATH and resolved-executable checks ensure the
guarded Lean/Lake v4.32.1 binaries are used. The manifest pins mathlib to
`520045ab14e26149ee970e2e617ca04b09bde5d6`.

It invokes only `lake env lean -j1 -s65536 --stdin` with explicit environment
threads 1 and stack size 65536 KiB. Limits: AS 8 GiB; CPU soft/hard 59/60 s;
wall 60 s; each regular stdout/stderr file 128 KiB; core dumps disabled.
Timeout kills the child's process group. Every error/signal/timeout/cap hit
fails the run and retains the complete resulting streams and status; there is
no automatic retry, build or resource escalation. All guards run before and
after. The parser requires exactly the four named axiom reports in order,
no other stdout or stderr, and only propext, Classical.choice, Quot.sound.

The controller snapshots this report before execution. The snapshot changes
on root's replay after actual evidence is appended; the probe, Bash entry,
guarded inputs, limits and output contract remain frozen.

```lean
import LonelyRunner.BoundaryZeroDivisibility
import LonelyRunner.SixthAffineSpecialAnchor

open LonelyRunner

example :
    ∀ M a : ℕ, 0 < M → circleNorm ((a : ℝ) / (M : ℝ)) = 0 → M ∣ a :=
  LonelyRunner.dvd_of_circleNorm_nat_div_eq_zero

example :
    ∀ a b c : ℕ, 0 < c →
      (∀ t : ℝ, Int.fract (t * (c : ℝ)) = (5 : ℝ) / 6 →
        min (circleNorm (t * (a : ℝ))) (circleNorm (t * (b : ℝ))) = 0) →
      6 * c ∣ a ∨ 6 * c ∣ b :=
  LonelyRunner.dvd_or_dvd_of_five_sixths_pair_zero

example :
    ∀ (x : ℝ) (σ : ℤ), (σ = 1 ∨ σ = -1) →
      circleNorm (x + (σ : ℝ) / 2) = circleNorm (x + 1 / 2) :=
  LonelyRunner.circleNorm_add_signed_half

example :
    ∀ (τ : ℝ) (c n κ : ℕ) (z σ : ℤ),
      (c : ℤ) = 6 * z + (κ : ℤ) * σ → (σ = 1 ∨ σ = -1) →
      Int.fract (τ * (c : ℝ)) = (5 : ℝ) / 6 →
      Int.fract (((n : ℝ) * τ + (σ : ℝ) / 6) * (c : ℝ)) =
        Int.fract (((5 * n + κ : ℕ) : ℝ) / 6) :=
  LonelyRunner.fract_sixth_affine_special_anchor

#print axioms LonelyRunner.dvd_of_circleNorm_nat_div_eq_zero
#print axioms LonelyRunner.dvd_or_dvd_of_five_sixths_pair_zero
#print axioms LonelyRunner.circleNorm_add_signed_half
#print axioms LonelyRunner.fract_sixth_affine_special_anchor
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
report = root / 'research/astra-boundary-div-anchor-source-review.md'
text = report.read_text()
fence = chr(96) * 3
probe = text.split(fence + 'lean\n', 1)[1].split(fence, 1)[0].encode()
launcher = text.split(fence + 'bash\n', 1)[1].split(fence, 1)[0].encode()
out = Path(tempfile.mkdtemp(prefix='astra-boundary-div-anchor-review-'))
(out / 'stdin.bin').write_bytes(probe)
(out / 'launcher.sh').write_bytes(launcher)
(out / 'report-snapshot.md').write_bytes(text.encode())
guards = {
    'LonelyRunner/BoundaryZeroDivisibility.lean': 'a01608409d16b3ce50ebfe65f19bf003c1c9d4d02f94623257e7e6a2b258f1f5',
    '.lake/build/lib/lean/LonelyRunner/BoundaryZeroDivisibility.olean': '2468fa096fc1ec8895c3189a0754b90000d41187d8cc549ffe5ba0f60b6a946f',
    'LonelyRunner/SixthAffineSpecialAnchor.lean': '6c78c1e4fdde4d25afbb03aadbcd16d6a0f7f7bc83aa287ede4f1a3ac3e2756e',
    '.lake/build/lib/lean/LonelyRunner/SixthAffineSpecialAnchor.olean': '8c47257ec2d0b4a84b1e076214e9725a44418fd71fd0ce72b52550415c8e557a',
    'LonelyRunner/SmallDenominatorWitness.lean': '1570a359100594f4a5589588e3b32674dc2d54d60e500df1d47aca64c2faf95f',
    '.lake/build/lib/lean/LonelyRunner/SmallDenominatorWitness.olean': 'c67482b37cb6a5c0d5da7fbeeb52eb5eb2c24d440553d4be22cbcf8364b28711',
    'LonelyRunner/StructuredClasses.lean': '5328a7a88d2b42f86ffc3f0f0418ca22c761219e8fa3e5822bda5a18ac286e8c',
    '.lake/build/lib/lean/LonelyRunner/StructuredClasses.olean': '4ada0ca2f0a5f20a8c83c3c2e58256e931c3b283882a88a074aeedb02d7e048f',
    'LonelyRunner/SixthAffinePhase.lean': '76e420713079ec0c3979e9b169cd78ecb6a932d6dc790ea7d9711adbb64b7d4b',
    '.lake/build/lib/lean/LonelyRunner/SixthAffinePhase.olean': '9a0cbfec2825c4b98fc7897835dc726929daabb3328a2d45818765c568cf47b3',
    'LonelyRunner/FoldedCirclePhase.lean': '957606878108847d5ceff47be621ff0fc9c0a0d976568b5f5ef3dbb6db10481e',
    '.lake/build/lib/lean/LonelyRunner/FoldedCirclePhase.olean': '3032bbcf8e5c414daea831a7a415a40b4f254e5b72428b6fa078742e891afc06',
    'LonelyRunner/PivotResidues.lean': '362da5ab923f22e900ae7ac821dd4cf4aab91dfe70889987bc9e5a05d19c276a',
    '.lake/build/lib/lean/LonelyRunner/PivotResidues.olean': '428daa1defa2f0e0e1744f1d59e9b7ee8b7197dea9cf25f667ff3e1b27c444cf',
    'LonelyRunner/FastRunnerInsertion.lean': 'dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5',
    '.lake/build/lib/lean/LonelyRunner/FastRunnerInsertion.olean': '121edfbaed0d7b9fed32bacf891de838142988e48dcb4e7f2bed0c488ea49136',
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
    'LonelyRunner.dvd_of_circleNorm_nat_div_eq_zero',
    'LonelyRunner.dvd_or_dvd_of_five_sixths_pair_zero',
    'LonelyRunner.circleNorm_add_signed_half',
    'LonelyRunner.fract_sixth_affine_special_anchor',
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

## Actual evidence

The first and only authorized import-only invocation passed. Lean and the
complete Bash entry both exited 0. All four complete universal theorem types
checked, and all four axiom lists are exactly `propext`, `Classical.choice`,
`Quot.sound`. Both predeclarations matched; all 23 guards passed before and
after; the resolved executables are the pinned Lean/Lake binaries. This run
emitted no errors, warnings or other informational output: its stdout consists
only of the four requested axiom reports, and stderr is empty. It had no
signal, timeout, cap hit, retry, build or resource escalation.

The recorded inner wall time is 2.026937899994664 seconds, maximum resident
set size 3,283,624 KiB. The pre-run report snapshot is 20,132 bytes, SHA-256
`ed7c61859fb12f59bcb460c819850a78a46c14fe2b92c1af39545ab44570898a`.
The exact probe and launcher remain unchanged in this final report.
Inner evidence directory: `/tmp/astra-boundary-div-anchor-review-ksstda5z`.
Its full receipt SHA-256 is
`159f17660134b68fab494fa7581c8cfcf2be3e63088d1bbf6ad6706524d09a9f`.
Lean stdout is 427 bytes, SHA-256
`f31e1e2712c6948c59a8959da921c18997aba43e7701e1981684b10b5419f286`;
Lean stderr is empty, SHA-256
`e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

The outer file-capture controller extracted and hash-checked the exact Bash
fence, wrote it to `entry.sh`, and invoked `bash entry.sh` once with stdin
`/dev/null` and regular stdout/stderr files. It used AS 8 GiB, CPU 59/60 s,
128 KiB file caps and disabled core dumps, with 65 seconds wall allowing the
inner controller to report after its fixed 60-second timeout. That reporting
grace does not change the Lean child's 60-second wall bound.
Outer directory: `/tmp/astra-boundary-div-anchor-entry-gch_3vgs`.
The following is its full receipt, SHA-256
`a4961d9d7a4a1ab207546afb8848f17811b6d2b5190e62c150864c688310e110`:

```json
{
  "argv": [
    "bash",
    "/tmp/astra-boundary-div-anchor-entry-gch_3vgs/entry.sh"
  ],
  "error": null,
  "exit": 0,
  "files": {
    "entry.sh": {
      "bytes": 9297,
      "sha256": "c3feebd8f21157e0013e5ccdfc52c7feb10130c3c62a77f339d6899d5950b687"
    },
    "stderr.bin": {
      "bytes": 0,
      "sha256": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
    },
    "stdout.bin": {
      "bytes": 5516,
      "sha256": "8d79e99b7651ab9a3cb60d7cec4eb2de70c8ae5f4f695a38169e32a275f70925"
    }
  },
  "stream_cap_hit": false,
  "timed_out": false,
  "wall_seconds": 2.1196782420156524
}
```

The following is the complete raw Bash stdout, including the FULL inner
receipt and the full Lean streams between their markers. Its 5,516 bytes
have SHA-256 `8d79e99b7651ab9a3cb60d7cec4eb2de70c8ae5f4f695a38169e32a275f70925`.
Outer stderr is also empty, with the empty-stream hash above.

```text
EVIDENCE_DIR /tmp/astra-boundary-div-anchor-review-ksstda5z
RECEIPT_SHA256 159f17660134b68fab494fa7581c8cfcf2be3e63088d1bbf6ad6706524d09a9f
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
    "LonelyRunner.circleNorm_add_signed_half": [
      "propext",
      "Classical.choice",
      "Quot.sound"
    ],
    "LonelyRunner.dvd_of_circleNorm_nat_div_eq_zero": [
      "propext",
      "Classical.choice",
      "Quot.sound"
    ],
    "LonelyRunner.dvd_or_dvd_of_five_sixths_pair_zero": [
      "propext",
      "Classical.choice",
      "Quot.sound"
    ],
    "LonelyRunner.fract_sixth_affine_special_anchor": [
      "propext",
      "Classical.choice",
      "Quot.sound"
    ]
  },
  "child_max_rss_kib": 3283624,
  "child_system_seconds": 0.6214839999999999,
  "child_user_seconds": 1.406926,
  "environment": {
    "LEAN_NUM_THREADS": "1",
    "LEAN_STACK_SIZE_KB": "65536"
  },
  "error": null,
  "exit": 0,
  "files": {
    "launcher.sh": {
      "bytes": 9297,
      "sha256": "c3feebd8f21157e0013e5ccdfc52c7feb10130c3c62a77f339d6899d5950b687"
    },
    "report-snapshot.md": {
      "bytes": 20132,
      "sha256": "ed7c61859fb12f59bcb460c819850a78a46c14fe2b92c1af39545ab44570898a"
    },
    "stderr.bin": {
      "bytes": 0,
      "sha256": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
    },
    "stdin.bin": {
      "bytes": 1293,
      "sha256": "e155eb86754e2e3bd8905c297ccdecaf5b9064f6802f7903c0cc93d5c5dc397a"
    },
    "stdout.bin": {
      "bytes": 427,
      "sha256": "f31e1e2712c6948c59a8959da921c18997aba43e7701e1981684b10b5419f286"
    }
  },
  "guards": {
    ".lake/build/lib/lean/LonelyRunner/BoundaryZeroDivisibility.olean": "2468fa096fc1ec8895c3189a0754b90000d41187d8cc549ffe5ba0f60b6a946f",
    ".lake/build/lib/lean/LonelyRunner/FastRunnerInsertion.olean": "121edfbaed0d7b9fed32bacf891de838142988e48dcb4e7f2bed0c488ea49136",
    ".lake/build/lib/lean/LonelyRunner/FoldedCirclePhase.olean": "3032bbcf8e5c414daea831a7a415a40b4f254e5b72428b6fa078742e891afc06",
    ".lake/build/lib/lean/LonelyRunner/PivotResidues.olean": "428daa1defa2f0e0e1744f1d59e9b7ee8b7197dea9cf25f667ff3e1b27c444cf",
    ".lake/build/lib/lean/LonelyRunner/SixthAffinePhase.olean": "9a0cbfec2825c4b98fc7897835dc726929daabb3328a2d45818765c568cf47b3",
    ".lake/build/lib/lean/LonelyRunner/SixthAffineSpecialAnchor.olean": "8c47257ec2d0b4a84b1e076214e9725a44418fd71fd0ce72b52550415c8e557a",
    ".lake/build/lib/lean/LonelyRunner/SmallDenominatorWitness.olean": "c67482b37cb6a5c0d5da7fbeeb52eb5eb2c24d440553d4be22cbcf8364b28711",
    ".lake/build/lib/lean/LonelyRunner/StructuredClasses.olean": "4ada0ca2f0a5f20a8c83c3c2e58256e931c3b283882a88a074aeedb02d7e048f",
    ".lake/packages/mathlib/.lake/build/lib/lean/Mathlib/Tactic.olean": "0534ef12e7aaf8ffbb6e520a91f922da4469d0dca2b54c87b4458e1faa28a6a2",
    ".lake/packages/mathlib/Mathlib/Tactic.lean": "c6f2c548596b635a3d5c8aff8b19cbdeb60dd54e41bb89a1cd03b1a54d335fa5",
    "/home/joshua/.elan/toolchains/leanprover--lean4---v4.32.1/bin/lake": "60330ab6f07dce20f3fa9ebb08e8b984ea9549eac172afeb15d9d2227060e2b3",
    "/home/joshua/.elan/toolchains/leanprover--lean4---v4.32.1/bin/lean": "e8baaa71855a616dc351028f3ad2200051b0671f423a1696a100e809302d5550",
    "LonelyRunner/BoundaryZeroDivisibility.lean": "a01608409d16b3ce50ebfe65f19bf003c1c9d4d02f94623257e7e6a2b258f1f5",
    "LonelyRunner/FastRunnerInsertion.lean": "dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5",
    "LonelyRunner/FoldedCirclePhase.lean": "957606878108847d5ceff47be621ff0fc9c0a0d976568b5f5ef3dbb6db10481e",
    "LonelyRunner/PivotResidues.lean": "362da5ab923f22e900ae7ac821dd4cf4aab91dfe70889987bc9e5a05d19c276a",
    "LonelyRunner/SixthAffinePhase.lean": "76e420713079ec0c3979e9b169cd78ecb6a932d6dc790ea7d9711adbb64b7d4b",
    "LonelyRunner/SixthAffineSpecialAnchor.lean": "6c78c1e4fdde4d25afbb03aadbcd16d6a0f7f7bc83aa287ede4f1a3ac3e2756e",
    "LonelyRunner/SmallDenominatorWitness.lean": "1570a359100594f4a5589588e3b32674dc2d54d60e500df1d47aca64c2faf95f",
    "LonelyRunner/StructuredClasses.lean": "5328a7a88d2b42f86ffc3f0f0418ca22c761219e8fa3e5822bda5a18ac286e8c",
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
  "resolved_executables": {
    "lake": "/home/joshua/.elan/toolchains/leanprover--lean4---v4.32.1/bin/lake",
    "lean": "/home/joshua/.elan/toolchains/leanprover--lean4---v4.32.1/bin/lean"
  },
  "stream_cap_hit": false,
  "timed_out": false,
  "wall_seconds": 2.026937899994664
}
STDOUT-BEGIN
'LonelyRunner.dvd_of_circleNorm_nat_div_eq_zero' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.dvd_or_dvd_of_five_sixths_pair_zero' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.circleNorm_add_signed_half' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.fract_sixth_affine_special_anchor' depends on axioms: [propext, Classical.choice, Quot.sound]
STDOUT-END
STDERR-BEGIN
STDERR-END
```

Retained regular-file evidence totals 51,478 bytes across the two temporary
directories, below 1 MiB. Complete raw receipts/streams are preserved, and this
report contains the sole full Bash replay entry with its Python source. Root's
requested exact replay is a separate subsequent verification action.

Actual workflow validation exited 0 and printed
`workflow structural validation passed; it cannot certify mathematical validity.`
The remaining limitation is semantic scope: hzero is supplied, not proved by
these declarations; the generic anchor identity is only an equality of
fractional parts. This review establishes no boundary-zero assembly,
unconditional six-total witness or unrestricted Lonely Runner result.
