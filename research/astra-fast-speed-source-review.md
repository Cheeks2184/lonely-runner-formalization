# Independent source review: positive five-speed fast insertion

**Semantic decision: accept the exact conditional contract.** The complete
source is `LonelyRunner/FiveMovingFast.lean`, SHA-256
`cc203315c6d36be23b7cdcfc9706785fb05e6d5406c84714a9fea42bdfce7212`,
2,109 bytes. It has one public theorem. The corrected fixed import probe also
passed, with only the three permitted axioms. The initial formatting failure
and the successful corrected run are separately preserved below.

Assigned checkpoint: `ed5fc6a0144d666b77cda3c28d1455dace22d69c`.
Requested reviewer route: Astra/xhigh; runtime-observed model and effort are
unavailable in focused state. I authored the mathematical fast-adapter plan,
but did not author or edit this Lean source. Terra authored the source and
root reports its first focused build passed unchanged. This is an independent
review of that implementation, not an independent review of my broader
Proposition 3.1 manuscript; another reviewer owns that task.

Only this report is owned. Configuration, project workflow, policy and focused
state were read, and `python3 scripts/validate_workflow.py` passed. No source,
root import, state, Git or cache edits, builds, mathematical searches or numerical controls
are part of this review. The Lean invocations are the first declared import-only probe and one
explicitly authorized formatting correction. Root's later exact replay is
separate evidence.

## Source and dependency reasoning

The statement quantifies over every `v : Fin 5 → ℕ`, positive at every label,
and every chosen label p subject to `5*v i ≤ v p` for each `i≠p`. It returns
one real `t>0` with every circle norm at least the **closed** margin 1/6.
It imposes no gcd, divisibility, injectivity, ordering or strict seed premise.
The four other speeds may repeat. Equality between the chosen speed and an
other positive speed is excluded by the supplied speed inequality itself;
there is no hidden distinctness condition on the other labels.

1. Lines 14–16 define `old j=v(p.succAbove j)` on all four complementary
   labels and apply `fourMovingNaturalRunners`. That theorem's actual scope
   is positive Fin4 natural speeds with repetitions allowed, at margin
   `5⁻¹`. It supplies all four simultaneous bounds. The proof deliberately
   does not use the seed's positive-time fact `_ht₀` afterward.
2. Lines 17–24 cast the natural speed inequality to the exact real inequality
   required by `fastRunnerInsertion` at `n=4`. Positivity proves the new speed
   nonzero and removes the absolute values on the old and new speeds.
   The inequality remains `≤`, so the factor-five equality case survives.
3. Lines 25–26 obtain a real u at sixth margin for the pivot and every old
   coordinate. `fastRunnerInsertion` supplies a perturbation bound and norm
   bounds; it does **not** promise `u>0`. Its closed perturbation estimate
   loses at most `1/5-1/6=1/30` on each old phase, which justifies the retained
   endpoint when an old norm or speed bound is at equality.
4. Lines 27–31 prove `u≠0` from the pivot's positive sixth-margin bound:
   at u=0 its norm is zero. The proof then splits `u<0` from `0<u`.
   In the first case it returns `-u`, proves positivity with `neg_pos.mpr`,
   and rewrites `(-u)*v i=-(u*v i)` using `circleNorm_neg`. No positivity
   inference from the perturbation size is present.
5. In both sign cases, the pivot is handled separately. Every `i≠p` is
   recovered by `Fin.exists_succAbove_eq`; the resulting equality is used
   to rewrite the actual label, rather than assuming the tuple is injective.
   `one_div` only changes inverse notation to the stated margin.

I read the full `FiveMovingFast`, `FiveRunnerOrdinary` and
`FastRunnerInsertion` sources, plus the relevant `StructuredClasses`
reflection proof and immediate import interfaces. The lower-count supply
uses the previously checked four-speed result, never an unconditional
five-speed sixth-margin theorem. The source contains ordinary Lean proofs
and no local axiom, `sorry`, `admit`, `native_decide` or evaluated certificate.
The axiom probe checks the imported theorem's transitive axiom dependencies.

Root's separate focused-build record is
`research/astra-pass47-verification.json`: it records exit 0, 3,524 jobs, and
log SHA-256 `4a0c898077b25fc1432eccd60bfbf07f305e8c5e87adcbf362e3281f33893ac6`.
That log includes replayed dependency warnings and the successful build of
`FiveMovingFast`; it is not a warning-free fresh build claim by this reviewer.
This task imports existing guarded `.olean` files and does not repeat that build.

## Predeclared probe and exact replay

The probe assigns the full universal type to the single public theorem and
prints its complete axiom list. It contains no case enumeration or numeric
test. The launcher guards the theorem's source and `.olean`, all three
immediate imports' sources and `.olean` files, the used reflection helper,
the project pins, and the pinned Lean/Lake executables. Guard checks run both
before and after the invocation. Mathlib is pinned to commit
`520045ab14e26149ee970e2e617ca04b09bde5d6`; Lean is `v4.32.1`.

Probe SHA-256: `ec463d317c78e576942d82200302a6cdaaf950ffbed794908fef8bab3420da02`
Launcher SHA-256: `3d3531fd34b1e385bf63f3bd4313ee5f33287329d1811e3a5db4577307477cd4`

Those hashes are computed from the complete UTF-8 fence contents including
their final newline, before the corresponding invocation. The launcher validates them
against these external-to-the-fence predeclarations; it cannot contain its own
literal hash. A replay captures the current report, so its report snapshot and
receipt hashes can differ after this report gains execution evidence. Probe,
launcher and guarded input bytes must remain identical.

```lean
import LonelyRunner.FiveMovingFast

example :
    ∀ (v : Fin 5 → ℕ), (∀ i, 0 < v i) →
      ∀ p : Fin 5, (∀ i, i ≠ p → 5 * v i ≤ v p) →
        ∃ t : ℝ, 0 < t ∧ ∀ i,
          (1 : ℝ) / 6 ≤ LonelyRunner.circleNorm (t * (v i : ℝ)) :=
  LonelyRunner.fiveMovingNaturalRunners_of_fast_speed

#print axioms LonelyRunner.fiveMovingNaturalRunners_of_fast_speed
```

Run this one exact Bash entry from any directory. It contains the complete
Python controller. The child process has address-space limit 8 GiB, CPU soft
and hard limits 59/60 seconds, wall timeout 60 seconds, and a 128 KiB regular
file size cap on each output stream. Core dumps are disabled. The fixed serial
settings are explicit in both command arguments and environment. Timeout kills
the new process group. Streams are retained even on a process/guard failure;
a cap hit or unexpected axiom output cannot count as a pass. There is no automatic retry,
resource escalation, build or default-thread launch.

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
report = root / 'research/astra-fast-speed-source-review.md'
text = report.read_text()
fence = chr(96) * 3
probe = text.split(fence + 'lean\n', 1)[1].split(fence, 1)[0].encode()
launcher = text.split(fence + 'bash\n', 1)[1].split(fence, 1)[0].encode()
out = Path(tempfile.mkdtemp(prefix='astra-fast-speed-review-'))
(out / 'stdin.bin').write_bytes(probe)
(out / 'launcher.sh').write_bytes(launcher)
(out / 'report-snapshot.md').write_bytes(text.encode())
guards = {
    'LonelyRunner/FiveMovingFast.lean': 'cc203315c6d36be23b7cdcfc9706785fb05e6d5406c84714a9fea42bdfce7212',
    '.lake/build/lib/lean/LonelyRunner/FiveMovingFast.olean': '4cf670a69bb776af9038f6ea85c53e58543bebb58616919bd299b8de02292b52',
    'LonelyRunner/FiveRunnerOrdinary.lean': '662d0116f13971bce85e76c503e2f3be4fdc6291ba8113aeda43957e38354ffe',
    '.lake/build/lib/lean/LonelyRunner/FiveRunnerOrdinary.olean': '408abf21f2b4e3c356ae528f92762826556887d7e5068283399a79d6ca72ef31',
    'LonelyRunner/FastRunnerInsertion.lean': 'dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5',
    '.lake/build/lib/lean/LonelyRunner/FastRunnerInsertion.olean': '121edfbaed0d7b9fed32bacf891de838142988e48dcb4e7f2bed0c488ea49136',
    '.lake/packages/mathlib/Mathlib/Tactic.lean': 'c6f2c548596b635a3d5c8aff8b19cbdeb60dd54e41bb89a1cd03b1a54d335fa5',
    '.lake/packages/mathlib/.lake/build/lib/lean/Mathlib/Tactic.olean': '0534ef12e7aaf8ffbb6e520a91f922da4469d0dca2b54c87b4458e1faa28a6a2',
    'LonelyRunner/StructuredClasses.lean': '5328a7a88d2b42f86ffc3f0f0418ca22c761219e8fa3e5822bda5a18ac286e8c',
    '.lake/build/lib/lean/LonelyRunner/StructuredClasses.olean': '4ada0ca2f0a5f20a8c83c3c2e58256e931c3b283882a88a074aeedb02d7e048f',
    'lean-toolchain': '8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af',
    'lakefile.toml': 'bdcbaaa18d518409619215e8acf7892452c1fa5c6e80ba742ce67f7380682a26',
    'lake-manifest.json': '887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218',
    '/home/joshua/.elan/toolchains/leanprover--lean4---v4.32.1/bin/lean': 'e8baaa71855a616dc351028f3ad2200051b0671f423a1696a100e809302d5550',
    '/home/joshua/.elan/toolchains/leanprover--lean4---v4.32.1/bin/lake': '60330ab6f07dce20f3fa9ebb08e8b984ea9549eac172afeb15d9d2227060e2b3',
}
argv = ['lake', 'env', 'lean', '-j1', '-s65536', '--stdin']
limits = {'address_space_bytes': 8 * 1024**3, 'cpu_seconds': [59, 60],
          'wall_seconds': 60, 'stream_bytes': 128 * 1024}
symbol = 'LonelyRunner.fiveMovingNaturalRunners_of_fast_speed'
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
    match = re.fullmatch(re.escape("'" + symbol + "' depends on axioms:")
                         + r'\s*\[([^\]]*)\]\s*', output)
    if match:
        axioms = [x.strip() for x in match.group(1).split(',') if x.strip()]
        receipt['axioms'] = axioms
        receipt['axiom_output_valid'] = (len(axioms) == len(set(axioms))
                                         and set(axioms) <= allowed)
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

The first declared invocation actually exited **1** (both Lean and the Bash
entry). Its only reported error is my unsupported `set_option pp.width 200`
formatting directive. The theorem's axiom list was printed, but the run is
**not a pass**. All 15 guards and both predeclaration checks passed. No timeout
or stream cap was hit. No retry had occurred when this failure was recorded.

Inner evidence directory: `/tmp/astra-fast-speed-review-ibt7rvk7`.
Full inner receipt SHA-256:
`82599285765f08ccbd748b2bb6d32ec2418eb15511fdd68fc2d58b05443b2805`.

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
  "axiom_output_valid": false,
  "axioms": null,
  "child_max_rss_kib": 3644252,
  "child_system_seconds": 0.611393,
  "child_user_seconds": 1.304207,
  "environment": {
    "LEAN_NUM_THREADS": "1",
    "LEAN_STACK_SIZE_KB": "65536"
  },
  "error": null,
  "exit": 1,
  "files": {
    "launcher.sh": {
      "bytes": 7602,
      "sha256": "3d3531fd34b1e385bf63f3bd4313ee5f33287329d1811e3a5db4577307477cd4"
    },
    "report-snapshot.md": {
      "bytes": 14440,
      "sha256": "90f4d396b2e558f58beec7a55f11fab1701150700eb6ca7fa71b99b1011465b6"
    },
    "stderr.bin": {
      "bytes": 0,
      "sha256": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
    },
    "stdin.bin": {
      "bytes": 415,
      "sha256": "925757d1fdc781c0d1b88d79877f871747d3ba0e7f6ca96468af918f5c116c8e"
    },
    "stdout.bin": {
      "bytes": 159,
      "sha256": "8ef5384a19a8666a3a272adad2aa37a88345fbb113557b2d219702776b61bd18"
    }
  },
  "guards": {
    ".lake/build/lib/lean/LonelyRunner/FastRunnerInsertion.olean": "121edfbaed0d7b9fed32bacf891de838142988e48dcb4e7f2bed0c488ea49136",
    ".lake/build/lib/lean/LonelyRunner/FiveMovingFast.olean": "4cf670a69bb776af9038f6ea85c53e58543bebb58616919bd299b8de02292b52",
    ".lake/build/lib/lean/LonelyRunner/FiveRunnerOrdinary.olean": "408abf21f2b4e3c356ae528f92762826556887d7e5068283399a79d6ca72ef31",
    ".lake/build/lib/lean/LonelyRunner/StructuredClasses.olean": "4ada0ca2f0a5f20a8c83c3c2e58256e931c3b283882a88a074aeedb02d7e048f",
    ".lake/packages/mathlib/.lake/build/lib/lean/Mathlib/Tactic.olean": "0534ef12e7aaf8ffbb6e520a91f922da4469d0dca2b54c87b4458e1faa28a6a2",
    ".lake/packages/mathlib/Mathlib/Tactic.lean": "c6f2c548596b635a3d5c8aff8b19cbdeb60dd54e41bb89a1cd03b1a54d335fa5",
    "/home/joshua/.elan/toolchains/leanprover--lean4---v4.32.1/bin/lake": "60330ab6f07dce20f3fa9ebb08e8b984ea9549eac172afeb15d9d2227060e2b3",
    "/home/joshua/.elan/toolchains/leanprover--lean4---v4.32.1/bin/lean": "e8baaa71855a616dc351028f3ad2200051b0671f423a1696a100e809302d5550",
    "LonelyRunner/FastRunnerInsertion.lean": "dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5",
    "LonelyRunner/FiveMovingFast.lean": "cc203315c6d36be23b7cdcfc9706785fb05e6d5406c84714a9fea42bdfce7212",
    "LonelyRunner/FiveRunnerOrdinary.lean": "662d0116f13971bce85e76c503e2f3be4fdc6291ba8113aeda43957e38354ffe",
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
  "passed": false,
  "predeclarations_match": true,
  "stream_cap_hit": false,
  "timed_out": false,
  "wall_seconds": 1.920905571023468
}
```

Complete Lean stdout, 159 bytes, SHA-256
`8ef5384a19a8666a3a272adad2aa37a88345fbb113557b2d219702776b61bd18`:

```text
<stdin>:3:0: error: Unknown option `pp.width`
'LonelyRunner.fiveMovingNaturalRunners_of_fast_speed' depends on axioms: [propext, Classical.choice, Quot.sound]
```

Lean stderr is empty (0 bytes), SHA-256
`e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.
The whole Bash entry's stdout and exit were separately captured in
`/tmp/astra-fast-speed-entry-tt_hp53c`; its complete output consists of the
inner receipt above, directory/hash labels, and the complete streams above.
The outer receipt SHA-256 is
`50d8f3ec500e453f79390f8dcab1ab8fdc9b041142e73b6f570ebac3ae64e1ae`:

```json
{
  "exit": 1,
  "files": {
    "entrypoint.sh": {
      "bytes": 7602,
      "sha256": "3d3531fd34b1e385bf63f3bd4313ee5f33287329d1811e3a5db4577307477cd4"
    },
    "stderr.bin": {
      "bytes": 0,
      "sha256": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
    },
    "stdout.bin": {
      "bytes": 3529,
      "sha256": "4e7da1891021cd69f62884012fc834b6927c9aa2151605fd1860f8bc110b4e09"
    }
  }
}
```

This is a review-harness error, not evidence of a source or mathematical
failure. The exact failed stdin, launcher and pre-execution report snapshot
are preserved in the inner evidence directory. No execution success is claimed
from the axiom line alone. A fixed formatting-only correction, if authorized,
will preserve this failure and leave the type, imports, axiom target, guards
and resource caps unchanged.


### Explicitly authorized formatting correction

After the initial failure was recorded, root explicitly authorized one corrected
fixed probe removing only the unsupported option and its adjacent blank line.
The corrected canonical Lean fence above is exactly that byte deletion; the
universal type, declaration reference, import and axiom print are unchanged.
The complete original 415-byte stdin is preserved here, as well as on disk:

```text
import LonelyRunner.FiveMovingFast

set_option pp.width 200

example :
    ∀ (v : Fin 5 → ℕ), (∀ i, 0 < v i) →
      ∀ p : Fin 5, (∀ i, i ≠ p → 5 * v i ≤ v p) →
        ∃ t : ℝ, 0 < t ∧ ∀ i,
          (1 : ℝ) / 6 ≤ LonelyRunner.circleNorm (t * (v i : ℝ)) :=
  LonelyRunner.fiveMovingNaturalRunners_of_fast_speed

#print axioms LonelyRunner.fiveMovingNaturalRunners_of_fast_speed
```

The original and corrected Bash launcher bytes are identical: 7,602 bytes,
SHA-256 `3d3531fd34b1e385bf63f3bd4313ee5f33287329d1811e3a5db4577307477cd4`.
Thus the sole complete Bash fence is both the original launcher and the exact
corrected replay; it reads the canonical probe and its predeclared hash from
this report. All 15 guards and all resource limits are unchanged. The first
receipt binds the original complete pre-execution report snapshot and stdin.

Corrected probe bytes: 390; SHA-256 `ec463d317c78e576942d82200302a6cdaaf950ffbed794908fef8bab3420da02`.
Corrected launcher SHA-256:
`3d3531fd34b1e385bf63f3bd4313ee5f33287329d1811e3a5db4577307477cd4`.

The corrected invocation ran once and **passed**: Lean exit 0 and Bash exit 0,
with no stderr, no timeout, no cap hit, and every guard/predeclaration check
passing. The full type assignment elaborated. The only printed axiom list is
`[propext, Classical.choice, Quot.sound]`, exactly within the project's allowed
set. Actual wall time was 1.9224355059850495 seconds and recorded child peak
RSS was 3,644,196 KiB. The one earlier invocation remains a failed run.

Corrected inner evidence: `/tmp/astra-fast-speed-review-g3vrbe6o`.
Full receipt SHA-256:
`f9e8e1a8ff6810ede43f826dcc43248c3da6a763c61d813c82030f0e677e623c`.

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
  "axioms": [
    "propext",
    "Classical.choice",
    "Quot.sound"
  ],
  "child_max_rss_kib": 3644196,
  "child_system_seconds": 0.6315029999999999,
  "child_user_seconds": 1.287183,
  "environment": {
    "LEAN_NUM_THREADS": "1",
    "LEAN_STACK_SIZE_KB": "65536"
  },
  "error": null,
  "exit": 0,
  "files": {
    "launcher.sh": {
      "bytes": 7602,
      "sha256": "3d3531fd34b1e385bf63f3bd4313ee5f33287329d1811e3a5db4577307477cd4"
    },
    "report-snapshot.md": {
      "bytes": 21234,
      "sha256": "69de49380f2e88142d675741198d57d2e964927b23c01d0f365bc79bc74d871d"
    },
    "stderr.bin": {
      "bytes": 0,
      "sha256": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
    },
    "stdin.bin": {
      "bytes": 390,
      "sha256": "ec463d317c78e576942d82200302a6cdaaf950ffbed794908fef8bab3420da02"
    },
    "stdout.bin": {
      "bytes": 113,
      "sha256": "960edfed552ea86b398fc8b262219dfd563ea56c807329b412ee0c1d804627e3"
    }
  },
  "guards": {
    ".lake/build/lib/lean/LonelyRunner/FastRunnerInsertion.olean": "121edfbaed0d7b9fed32bacf891de838142988e48dcb4e7f2bed0c488ea49136",
    ".lake/build/lib/lean/LonelyRunner/FiveMovingFast.olean": "4cf670a69bb776af9038f6ea85c53e58543bebb58616919bd299b8de02292b52",
    ".lake/build/lib/lean/LonelyRunner/FiveRunnerOrdinary.olean": "408abf21f2b4e3c356ae528f92762826556887d7e5068283399a79d6ca72ef31",
    ".lake/build/lib/lean/LonelyRunner/StructuredClasses.olean": "4ada0ca2f0a5f20a8c83c3c2e58256e931c3b283882a88a074aeedb02d7e048f",
    ".lake/packages/mathlib/.lake/build/lib/lean/Mathlib/Tactic.olean": "0534ef12e7aaf8ffbb6e520a91f922da4469d0dca2b54c87b4458e1faa28a6a2",
    ".lake/packages/mathlib/Mathlib/Tactic.lean": "c6f2c548596b635a3d5c8aff8b19cbdeb60dd54e41bb89a1cd03b1a54d335fa5",
    "/home/joshua/.elan/toolchains/leanprover--lean4---v4.32.1/bin/lake": "60330ab6f07dce20f3fa9ebb08e8b984ea9549eac172afeb15d9d2227060e2b3",
    "/home/joshua/.elan/toolchains/leanprover--lean4---v4.32.1/bin/lean": "e8baaa71855a616dc351028f3ad2200051b0671f423a1696a100e809302d5550",
    "LonelyRunner/FastRunnerInsertion.lean": "dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5",
    "LonelyRunner/FiveMovingFast.lean": "cc203315c6d36be23b7cdcfc9706785fb05e6d5406c84714a9fea42bdfce7212",
    "LonelyRunner/FiveRunnerOrdinary.lean": "662d0116f13971bce85e76c503e2f3be4fdc6291ba8113aeda43957e38354ffe",
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
  "stream_cap_hit": false,
  "timed_out": false,
  "wall_seconds": 1.9224355059850495
}
```

Complete corrected Lean stdout, 113 bytes, SHA-256
`960edfed552ea86b398fc8b262219dfd563ea56c807329b412ee0c1d804627e3`:

```text
'LonelyRunner.fiveMovingNaturalRunners_of_fast_speed' depends on axioms: [propext, Classical.choice, Quot.sound]
```

Corrected Lean stderr is empty (0 bytes), SHA-256
`e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.
The complete Bash entry output is separately retained in
`/tmp/astra-fast-speed-entry-7o96n5jb`; its stdout contains the receipt,
directory/hash labels and the full streams. The outer receipt SHA-256 is
`686cc8deea90bf3b31e603bd646ebea694564c84a1a3c19d19e5daffdc036adc`:

```json
{
  "exit": 0,
  "files": {
    "entrypoint.sh": {
      "bytes": 7602,
      "sha256": "3d3531fd34b1e385bf63f3bd4313ee5f33287329d1811e3a5db4577307477cd4"
    },
    "stderr.bin": {
      "bytes": 0,
      "sha256": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
    },
    "stdout.bin": {
      "bytes": 3549,
      "sha256": "948814bc37c74a897b1e594a0e9146af593aa710be9492bedeb02c29dfbc7149"
    }
  }
}
```

The outer captures were made by executing the exact extracted Bash fence,
with its stdout and stderr directed to ordinary files, and recording the
returned Bash status and the three file hashes. They introduced no second
Lean invocation within either run. Each inner controller preserves its own
exact stdin, exact launcher, complete report snapshot, complete stdout/stderr
and full receipt. The sole Bash fence above is the complete replay entry.

The original predeclaration report hash is
`90f4d396b2e558f58beec7a55f11fab1701150700eb6ca7fa71b99b1011465b6`;
the corrected predeclaration report hash is
`69de49380f2e88142d675741198d57d2e964927b23c01d0f365bc79bc74d871d`.
Those complete report snapshots remain in their respective inner directories.


Total retained regular-file evidence across the four named directories: 81,537 bytes.

The semantic review and corrected import probe accept this conditional fast-speed
theorem. They do not prove Proposition 3.1, an unconditional five-moving
sixth-margin supply, or a new canonical runner count. The overall goal remains
active. Root must independently read this frozen report and replay its exact
entry point before integration.
