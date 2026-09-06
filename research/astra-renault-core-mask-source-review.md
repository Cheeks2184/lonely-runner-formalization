# Independent review of the Renault core-mask source

Disposition: **accept the two frozen modules at their exact finite-mask scope**.
The first and only predeclared import probe passed; no source correction is
requested. This is not a real-phase theorem or a new runner-count result.

Scope: the exact frozen `FiniteMaskCertificates.lean` and
`RenaultPhaseMasks.lean` modules, at assigned source checkpoint
`73189bbcfb2e7e735deae1483f9f6e8be35e80fa`. The requested reviewer route is
Astra/xhigh; runtime-observed model and effort are unavailable in focused state.
I read both complete modules and did not author their source. Current policy
and focused state were read; `python3 scripts/validate_workflow.py` exited 0.
The full project goal remains active. This task owns only this report.

Frozen inputs:

| File | SHA-256 |
| --- | --- |
| `LonelyRunner/FiniteMaskCertificates.lean` | `72629bc0780161890a31dd705b744c7ce2a77c884a915d7eaf4b3d69855b181e` |
| `LonelyRunner/RenaultPhaseMasks.lean` | `fc1360b225d440c99c6dc44067f2bfda2668c9e6984078770c70dc23dc3a4857` |
| `research/astra-renault-phase-five-one-certificate.json` | `c1374409d4f6804487179fe9765695a2f0d756ccd2a79b5ee8616e919acbb7b1` |

## Source and data review

The generic definition `maskCandidates B n` is exactly the finite set of
indices `k : Fin B` with `n.testBit k.val = true`. Its membership theorem has
no additional hypotheses. The common-bit theorem quantifies over all natural
B,a,b,c, assumes only `a < 2^B` and `(a &&& b &&& c) != 0`, and returns an
actual index in `Fin B` whose bit is true in all three masks. No bound on b or
c, no positive-B premise, and no requirement that the masks be distinct is
hidden in the statement or proof.

The proof first obtains a true bit of the nonzero intersection: if none
existed, every bit would be false and the natural would equal zero. The
Boolean case split handles the false case by `rfl`; this is the root's
correction to the initial worker source. `Nat.testBit_land` then yields the
three true bits. If their index k were at least B, then
`a < 2^B <= 2^k` would force a's bit at k to be false, a contradiction.
Packaging k in `Fin B` proves the result. The candidate theorem only applies
the membership equivalence three times. At B=0, the hypotheses are
inconsistent: a<1 forces a=0, making the intersection zero. Thus the empty
`Fin 0` case is sound without adding an assumption. High bits of b or c cannot
invalidate the conclusion because the common true bit also belongs to a.

The Renault definition contains exactly 41 natural literals in the specified
order. A static data comparison, with both input hashes asserted, read the
certificate JSON and compared the source vector to
`[masks[class_reps[i]] for i in minimal_classes]`. It exited 0 and printed:

```text
PASS: 41 literal masks equal certificate minimal-class representatives in order
literal_list_sha256 42a553c649834ee216d3a45280cfda1aca70069ab28fbbc539d04fae5fca71d3
```

That digest is of the vector encoded by `json.dumps(v,separators=(',',':'))`,
without a trailing newline. This is data integrity, not mask regeneration,
minimality verification, or an independent numerical intersection search.

All 41 private row propositions, numbered 0 through 40 exactly once, are
proved with ordinary `by decide`. Each fixes only its first index and
quantifies over every j,k:Fin41 under j<=k. There is no condition i<=j.
The public all-row theorem uses `fin_cases i` and the matching private row in
each case, so its exact statement has arbitrary i and only j<=k. Equal
indices are included. It is stronger than a fully sorted-triple statement.
This review does not rerun those decision procedures or numerically enumerate
their triples; the imported declarations come from root's separate source
builds. These are ordinary kernel decision proofs, not `native_decide`, a
custom axiom, or an unchecked JSON witness.

The public size theorem supplies `< 2^23` for every mask, using ordinary
`decide`. The common-candidate corollary applies the generic theorem with
B=23, the size bound on the first mask, and the all-row intersection result.
It returns exactly `Fin 23`, with membership in all three candidate sets.
The only ordering premise remains j<=k. The source-local heartbeat and
recursion limits are elaboration settings; they do not alter these domains.

The existing worker report, `research/astra-renault-core-mask-implementation.md`,
was read in full. Its historical launcher used 8 GiB virtual address space,
`ulimit -t 59`, a 60-second timeout, one Lean thread, and a 64 MiB stack. It
records a failed tactic-import attempt, a repaired source check, and a failed
import attempt before an olean existed. It explicitly lacks retained raw
streams, hashes, launcher files, resource receipts, and enforced 256 KiB
per-stream capture for those runs. I do not treat those worker-reported
outcomes as complete raw-execution evidence or as axiom results. In particular
the historical CPU command does not document a separate hard limit of 60.
Root's later source builds and the independently captured probe below provide
separate evidence for the currently frozen modules.

## Fixed probe predeclaration

Predeclared before execution: one import-only Lean invocation, importing the
two named modules through `LonelyRunner.RenaultPhaseMasks`. It assigns complete
universal types to all eight public declarations (two definitions and six
theorems), checks the generic set definition and the exact fixed 41-vector
by `rfl`, and prints axioms for all eight. It contains no `decide`, `#eval`,
native computation, row reproof, numeric triple enumeration, mask generation,
or solver. B=0 and unrestricted-first-index scope are covered by the universal
types and source reasoning, not a separate finite test. No new source module
or olean will be written.

The fixed resource limits are 8 GiB address space, CPU soft/hard 59/60 seconds,
60 seconds wall time, and 256 KiB for each output stream. One Lean thread and
64 MiB stack are requested. Any failure is retained without resource
escalation. The launcher records the exact probe bytes as stdin, both streams,
its own source, child status, resource limits, timing, hashes, and source and
olean guards. Temporary evidence is retained and no shared cache is changed.

```lean
import LonelyRunner.RenaultPhaseMasks

open LonelyRunner

example : (B n : Nat) → Finset (Fin B) := maskCandidates

example : ∀ {B n : Nat} {k : Fin B},
    k ∈ maskCandidates B n ↔ n.testBit k.val = true :=
  @mem_maskCandidates

example : ∀ (B a b c : Nat), a < 2 ^ B → (a &&& b &&& c) ≠ 0 →
    ∃ k : Fin B, a.testBit k.val = true ∧ b.testBit k.val = true ∧
      c.testBit k.val = true :=
  exists_common_mask_bit

example : ∀ (B a b c : Nat), a < 2 ^ B → (a &&& b &&& c) ≠ 0 →
    ∃ k : Fin B, k ∈ maskCandidates B a ∧ k ∈ maskCandidates B b ∧
      k ∈ maskCandidates B c :=
  exists_common_mask_candidate

example : Fin 41 → Nat := renaultPhaseCoreMasks

example : ∀ i j k : Fin 41, j ≤ k →
    (renaultPhaseCoreMasks i &&& renaultPhaseCoreMasks j &&&
      renaultPhaseCoreMasks k) ≠ 0 :=
  renaultPhaseCoreMasks_all_rows

example : ∀ i : Fin 41, renaultPhaseCoreMasks i < 2 ^ 23 :=
  renaultPhaseCoreMasks_lt

example : ∀ i j k : Fin 41, j ≤ k →
    ∃ c : Fin 23, c ∈ maskCandidates 23 (renaultPhaseCoreMasks i) ∧
      c ∈ maskCandidates 23 (renaultPhaseCoreMasks j) ∧
      c ∈ maskCandidates 23 (renaultPhaseCoreMasks k) :=
  renaultPhaseCoreMasks_common_candidate

example (B n : Nat) : maskCandidates B n =
    Finset.univ.filter (fun k : Fin B => n.testBit k.val = true) := rfl

example : renaultPhaseCoreMasks =
    (![7576815, 7970031, 7982311, 8178919, 8179303, 8185447, 8283751,
      4158259, 3666739, 3406739, 3391385, 3784601, 3776473, 3973081,
      4083196, 4154620, 3663100, 3404030, 3404414, 3799678, 1965951,
      6078255, 6168367, 6168463, 6246279, 5754759, 5498823, 4846067,
      5042675, 5044467, 5142771, 5127417, 5185145, 4693625, 6541116,
      6934332, 6940476, 6940572, 7137180, 7140254, 7238558] : Fin 41 → Nat) := rfl

#print axioms LonelyRunner.maskCandidates
#print axioms LonelyRunner.mem_maskCandidates
#print axioms LonelyRunner.exists_common_mask_bit
#print axioms LonelyRunner.exists_common_mask_candidate
#print axioms LonelyRunner.renaultPhaseCoreMasks
#print axioms LonelyRunner.renaultPhaseCoreMasks_all_rows
#print axioms LonelyRunner.renaultPhaseCoreMasks_lt
#print axioms LonelyRunner.renaultPhaseCoreMasks_common_candidate
```

This is the full guarded launcher. Run this Bash fence from any directory;
it locates the report and extracts the preceding fixed Lean fence. It never
builds a source module. The two exact olean guards bind the imported artifacts
to those inspected after root's frozen-source builds; source guards are
checked both before and after the invocation.

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
report = root / 'research/astra-renault-core-mask-source-review.md'
text = report.read_text()
fence = chr(96) * 3
probe = text.split(fence + 'lean\n', 1)[1].split(fence, 1)[0].encode()
launcher = text.split(fence + 'bash\n', 1)[1].split(fence, 1)[0].encode()
out = Path(tempfile.mkdtemp(prefix='astra-renault-core-review-'))
(out / 'stdin.bin').write_bytes(probe)
(out / 'launcher.sh').write_bytes(launcher)
guards = {
    'LonelyRunner/FiniteMaskCertificates.lean': '72629bc0780161890a31dd705b744c7ce2a77c884a915d7eaf4b3d69855b181e',
    'LonelyRunner/RenaultPhaseMasks.lean': 'fc1360b225d440c99c6dc44067f2bfda2668c9e6984078770c70dc23dc3a4857',
    'research/astra-renault-phase-five-one-certificate.json': 'c1374409d4f6804487179fe9765695a2f0d756ccd2a79b5ee8616e919acbb7b1',
    'lean-toolchain': '8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af',
    'lake-manifest.json': '887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218',
    'lakefile.toml': 'bdcbaaa18d518409619215e8acf7892452c1fa5c6e80ba742ce67f7380682a26',
    '.lake/build/lib/lean/LonelyRunner/FiniteMaskCertificates.olean': 'f0ca24c85fa4ecef7643feec5c77d277fcbf62c312a65eb081a5161c6005cfb6',
    '.lake/build/lib/lean/LonelyRunner/RenaultPhaseMasks.olean': 'f6d1245ea1ef3b57619ccc1056223969f75628397a1ccbd08459cba3ead72647',
}
argv = ['lake', 'env', 'lean', '-j', '1', '-s', '65536',
        '-DwarningAsError=true', '--stdin']
limits = {'address_space_bytes': 8 * 1024**3, 'cpu_seconds': [59, 60],
          'wall_seconds': 60, 'stream_bytes': 256 * 1024}
receipt = {'argv': argv, 'limits': limits, 'guards': guards,
           'exit': None, 'timed_out': False, 'error': None,
           'guards_before': False, 'guards_after': False,
           'static_data': False, 'probe_expected_sha256': '894da5310baa2238e90e0e7c9eb422c545b7598ebc637de72348a50c73bed453'}
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
    cert = json.loads((root / 'research/astra-renault-phase-five-one-certificate.json').read_bytes())
    source = (root / 'LonelyRunner/RenaultPhaseMasks.lean').read_text()
    match = re.search(r'def renaultPhaseCoreMasks : Fin 41 → Nat := !\[(.*?)\]', source)
    literal = [int(x.strip()) for x in match.group(1).split(',')]
    selected = [cert['masks'][cert['class_reps'][i]] for i in cert['minimal_classes']]
    assert len(literal) == len(selected) == 41 and literal == selected
    probe_match = re.search(r'\(!\[(.*?)\] : Fin 41 → Nat\)', probe.decode(), re.S)
    assert [int(x.strip()) for x in probe_match.group(1).split(',')] == literal
    receipt['literal_list_sha256'] = sha(json.dumps(literal, separators=(',', ':')).encode())
    receipt['static_data'] = True
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
    for name in ['stdin.bin', 'stdout.bin', 'stderr.bin', 'launcher.sh']:
        data = (out / name).read_bytes()
        receipt['files'][name] = {'bytes': len(data), 'sha256': sha(data)}
    receipt['stream_cap_hit'] = any(receipt['files'][name]['bytes'] >= limits['stream_bytes']
                                    for name in ['stdout.bin', 'stderr.bin'])
    receipt['passed'] = (receipt['exit'] == 0 and receipt['error'] is None
                         and receipt['guards_before'] and receipt['guards_after']
                         and receipt['static_data'] and not receipt['timed_out']
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

## Actual probe outcome

The first and only invocation exited 0; the fixed Lean source and resource
caps were not revised. The launcher also exited 0. Wall time was
1.8201070869981777 seconds; child user/system CPU were 1.2579639999999999 and
0.566874 seconds, and recorded child maximum RSS was 3,284,620 KiB. There was
no timeout, stream-cap hit, warning, stderr, or failed guard. All eight source,
certificate, dependency, and imported-artifact guards matched before and after.
The static vector comparison was repeated inside the guarded launcher and
passed. No row decision procedure was replayed.

The retained evidence directory is
`/tmp/astra-renault-core-review-ym4i56fo`; all six retained files together are
27,128 bytes. The pre-execution report was separately retained byte-for-byte,
so the predeclaration can be checked after this final report is frozen.

| Retained file | Bytes | SHA-256 |
| --- | ---: | --- |
| `stdin.bin` | 2251 | `894da5310baa2238e90e0e7c9eb422c545b7598ebc637de72348a50c73bed453` |
| `stdout.bin` | 735 | `d6c627aea9ef46706974db6c995a14497ee9e8987d36126da5888e68565a38be` |
| `stderr.bin` | 0 | `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855` |
| `launcher.sh` | 6295 | `50a69e22407108d7f0a51c77ba565553327977951ed161e25e891231f4842622` |
| `receipt.json` | 2259 | `22c801089d646f252fc0d5ed4823393dd429582de4c27690ce75f59aa033bfde` |
| `predeclared-report.md` | 15588 | `7a0a2972c2840446eebe46bbe67188d04c26a06ec627a928feba2e4d8bd5a5e3` |

Complete Lean stdout follows; stderr is the empty byte string.

```text
'LonelyRunner.maskCandidates' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.mem_maskCandidates' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.exists_common_mask_bit' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.exists_common_mask_candidate' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.renaultPhaseCoreMasks' depends on axioms: [propext]
'LonelyRunner.renaultPhaseCoreMasks_all_rows' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.renaultPhaseCoreMasks_lt' depends on axioms: [propext]
'LonelyRunner.renaultPhaseCoreMasks_common_candidate' depends on axioms: [propext, Classical.choice, Quot.sound]
```

The two declarations with only `propext` are the literal-vector definition
and its size theorem. Every other listed declaration uses only `propext`,
`Classical.choice`, and `Quot.sound`. All dependencies remain inside the
project's allowed axiom set. This axiom output is from the actual successful
import probe, independently of the unavailable-artifact worker attempt.

Complete captured receipt:

```json
{
  "argv": [
    "lake",
    "env",
    "lean",
    "-j",
    "1",
    "-s",
    "65536",
    "-DwarningAsError=true",
    "--stdin"
  ],
  "child_max_rss_kib": 3284620,
  "child_system_seconds": 0.566874,
  "child_user_seconds": 1.2579639999999999,
  "error": null,
  "exit": 0,
  "files": {
    "launcher.sh": {
      "bytes": 6295,
      "sha256": "50a69e22407108d7f0a51c77ba565553327977951ed161e25e891231f4842622"
    },
    "stderr.bin": {
      "bytes": 0,
      "sha256": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
    },
    "stdin.bin": {
      "bytes": 2251,
      "sha256": "894da5310baa2238e90e0e7c9eb422c545b7598ebc637de72348a50c73bed453"
    },
    "stdout.bin": {
      "bytes": 735,
      "sha256": "d6c627aea9ef46706974db6c995a14497ee9e8987d36126da5888e68565a38be"
    }
  },
  "guards": {
    ".lake/build/lib/lean/LonelyRunner/FiniteMaskCertificates.olean": "f0ca24c85fa4ecef7643feec5c77d277fcbf62c312a65eb081a5161c6005cfb6",
    ".lake/build/lib/lean/LonelyRunner/RenaultPhaseMasks.olean": "f6d1245ea1ef3b57619ccc1056223969f75628397a1ccbd08459cba3ead72647",
    "LonelyRunner/FiniteMaskCertificates.lean": "72629bc0780161890a31dd705b744c7ce2a77c884a915d7eaf4b3d69855b181e",
    "LonelyRunner/RenaultPhaseMasks.lean": "fc1360b225d440c99c6dc44067f2bfda2668c9e6984078770c70dc23dc3a4857",
    "lake-manifest.json": "887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218",
    "lakefile.toml": "bdcbaaa18d518409619215e8acf7892452c1fa5c6e80ba742ce67f7380682a26",
    "lean-toolchain": "8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af",
    "research/astra-renault-phase-five-one-certificate.json": "c1374409d4f6804487179fe9765695a2f0d756ccd2a79b5ee8616e919acbb7b1"
  },
  "guards_after": true,
  "guards_before": true,
  "limits": {
    "address_space_bytes": 8589934592,
    "cpu_seconds": [
      59,
      60
    ],
    "stream_bytes": 262144,
    "wall_seconds": 60
  },
  "literal_list_sha256": "42a553c649834ee216d3a45280cfda1aca70069ab28fbbc539d04fae5fca71d3",
  "passed": true,
  "probe_expected_sha256": "894da5310baa2238e90e0e7c9eb422c545b7598ebc637de72348a50c73bed453",
  "static_data": true,
  "stream_cap_hit": false,
  "timed_out": false,
  "wall_seconds": 1.8201070869981777
}
```

The guarded Bash fence remains exactly the predeclared launcher. Root can
replay it directly; a replay creates its own evidence directory and receipt.
The expected source, probe, literal-vector, and stdout hashes are fixed; timing,
RSS, and therefore the new receipt hash are run-specific. Existing caches and
build artifacts were retained, and no root import, audit, publication, Git,
or workflow state was edited by this task.

## Exact remaining boundary

The source review finds no contract defect. The continuum bridge remains an
independent obligation: map every arbitrary real phase to an atom; for each
atom select a retained core whose set bits are a subset of that atom's actual
good-candidate bits; and prove that each true candidate bit implies the exact
mixed strict/closed Renault phase predicates. Candidate indices also need
their exact correspondence to the designated 23 transformations. The frozen
JSON or the names of these constants alone do not establish those Lean
premises. These modules prove the finite intersections and their Fin23 witness;
they do not prove Renault 5.1 over all real phases, an unconditional six-total
witness, any new canonical runner count, or unrestricted LRC.
