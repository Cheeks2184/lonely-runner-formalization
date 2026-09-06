# Independent source review: pair selector and odd half-time shift

Semantic decision: **accept both exact auxiliary contracts**. The complete source
review and the single fixed import-only probe both passed. Exact predeclarations,
execution receipts and complete raw streams are preserved below. Neither declaration
establishes a boundary minimum, supplies its band hypotheses, proves the excluded
even-anchor case, or promotes a runner count or unrestricted LRC.

This task owns only this report. I authored the earlier assembly manuscript,
but neither source implementation. Terra drafted the selector; root corrected
literal cast/normalization steps. Root authored and corrected the odd half-time
module. Thus this is an independent source review of implementation from a
manuscript in which I participated; the separate manuscript review was by a
different Astra reviewer. Source/state/Git/imports/cache and other reports were
not edited, and no source build or numerical experiment is part of this review.

Current project configuration, workflow, policy and focused state were read;
`python3 scripts/validate_workflow.py` exited 0 with
`workflow structural validation passed; it cannot certify mathematical validity.`
The focused review entry records checkpoint `865b96f`, requested Astra/xhigh,
observed model/effort unavailable, research/in_progress. State remains root-owned.

## Frozen inputs and contract comparison

| Input | SHA-256 |
| --- | --- |
| `LonelyRunner/PairSafeSixthAffine.lean` | `290b5844fd7e3a11baf1c51d724a904362a41d76e31c3e78c45c7818b9763737` |
| `LonelyRunner/OddHalfTimeShift.lean` | `ea274daeadc4bf2242399663cd5da914b1c096f62b58cb43fdffa2e625af6b5c` |
| `research/astra-two-divisible-boundary-assembly.md` | `f282ced2c133f1bb607b2d5f6ca94d6b27bb8591605b445ee6de60b422a9800c` |
| `research/astra-boundary-assembly-review.md` | `c5ad3f1e191f72561af6ae9f5a09a95b938a65762e0532ee1d61dab56f9e856f` |

Both manuscripts and complete target proofs were read. The implemented selector
has precisely the manuscript's supplied-band contract, including the excluded
both-six/even condition. The independent manuscript review accepts the same
five-row argument. The probe below spells out the private `PairSafe` abbreviation
as its two closed inequalities, preserving the original conjunction grouping.
Its type assignments are universal: there is no local specialization, numerical
fixture, additional hypothesis or replacement theorem.

## Selector proof audit

Write N for circleNorm, δ=1/6, A=N(τa), B=N(τb). The only inputs are naturals
with 3∣a, 3∣b, 3∤c, at least one of 6∣a or 6∣b, the explicit negation of
`6∣a ∧ 6∣b ∧ 2∣c`, arbitrary real τ with fract(τc)=5/6, and the supplied
`FoldedPairSafeBands A B`. No positivity, distinctness, order, primitive gcd,
no-witness, maximality, strict seed or boundary assumption is smuggled in.
The bands themselves can make some degenerate inputs impossible, which is
legitimate; for example a=0 or b=0 contradicts the corresponding double band.
The condition 3∤c already rules out c=0. Repeated values are otherwise allowed.

`exists_three_residue_mod_six` supplies signed integer decompositions
`d=6z+3ε`, with ε=0 or 1 and the exact equivalence `6∣d ↔ ε=0`.
`exists_centered_sixth_residue_of_not_dvd_three` supplies c=6zc+e with
 e∈{1,-1,2,-2}. Signed witnesses stay integers; negative residuals are not
translated into truncated natural subtraction. Set e=κσ with κ∈{1,2} and
σ∈{1,-1}. The common time is s=nτ+σ/6.

The private zero-residue helper applies
`circleNorm_sixth_affine_of_three_residue` with ε=0 to identify N(sd) with
N(n*N(τd)). It works for arbitrary integer σ. The one-residue helper uses ε=1,
then `circleNorm_add_signed_half`, to identify N(sd) with
N(n*N(τd)+1/2) for either sign. These identities fold arbitrary real phases
without assuming their actual fractional parts equal their norms.

The complete constructive table is as follows; each row is implemented
separately for σ=1 and σ=-1, giving ten signed branches.

| εa | εb | κ | n | Fields used for a, b | fract(sc) |
| --- | --- | --- | --- | --- | --- |
| 0 | 0 | 1 | 2 | `left_two`, `right_two` | 5/6 |
| 0 | 1 | 1 | 2 | `left_two`, `right_two_half` | 5/6 |
| 0 | 1 | 2 | 3 | `left_three`, `right_three_half` | 5/6 |
| 1 | 0 | 1 | 2 | `left_two_half`, `right_two` | 5/6 |
| 1 | 0 | 2 | 1 | `left_half`, `right_one` | 1/6 |

Every table entry uses a named closed band of the supplied structure; no band
is inferred by exchanging A and B or erasing their orientations. In the n=1
row, `simpa` only removes the literal natural cast and multiplication by one.
All endpoints remain safe through `≤`; no strict inequality is introduced.
The witness tuple fixes a single n and σ before proving both pair inequalities
and the anchor alternative, so these statements hold at the same real time.

The three private anchor helpers instantiate
`fract_sixth_affine_special_anchor`. Because σ²=1, the anchor becomes
fract((5n+κ)/6). The relevant exact symbolic reductions are 11/6=1+5/6,
17/6=2+5/6 and 7/6=1+1/6. The source explicitly presents the natural numerator
and denominator casts before applying `Int.fract_div_natCast_eq_div_natCast_mod`.
Thus this proof uses an actual checked fractional-part API, not an informal
modulo convention, and both negative and positive σ are covered.

The remaining branches close from the stated hypotheses. For εa=εb=0 and
κ=2, the signed residue e=2 supplies the integer witness c=2*(3zc+1), while
e=-2 supplies c=2*(3zc-1). `exact_mod_cast` transfers the integer divisibility
fact to natural `2∣c`; the residue equivalences give both six-divisibilities,
contradicting `hregular`. For εa=εb=1, the disjunction `hsix` and the exact
six-divisibility equivalences force one ε to be zero, a contradiction.
No admissible residual case is omitted, and the both-six/even case is explicitly
excluded instead of being treated as a selector output.

The conclusion intentionally has no positive-time claim. τ is unrestricted,
and nτ+σ/6 can be negative. Later counterexample elimination must handle time
positivity separately. The supplied bands and later even-anchor construction
remain separate assembly obligations; this source does not establish them.

## Odd half-time proof audit

For every real t and natural d with 2∤d, `Nat.mod_lt` gives d%2<2 and the
nondivisibility hypothesis gives d%2≠0. `omega` therefore obtains d%2=1 and
`d=2*(d/2)+1`. The quotient is natural Euclidean division throughout.
Casting this equality gives
`(t+1/2)*d = (d/2 : ℕ) + (t*d+1/2)` as a real identity. In the source the
integer turn is written `((d/2 : ℕ) : ℤ)`; rewriting only `Int.cast_natCast`
preserves the intended natural quotient. `nlinarith` proves the displayed
identity, and `circleNorm_add_int` removes the integer term.

Hence the exact asserted norm equality holds for arbitrary negative, zero or
positive real t. d=0 is excluded by 2∤d; no separate speed positivity is assumed.
This theorem does not claim equality of the two phases without the integer turn,
or provide any safety inequality by itself. Combining it later with a half-norm
complement requires a separate supplied bound. All endpoint behavior is retained
because this is an exact identity.

The complete direct project dependency proofs were read, with the underlying
norm definition, integer periodicity and reflection APIs inspected in the
relevant transitive sources. The 27 source/artifact/pin/runtime guards below
bind the ten relevant project modules, Mathlib.Tactic, all three project pins
and both pinned runtime binaries. These are ordinary Lean proofs; the axiom
probe checks the complete transitive axiom sets of the two declarations.

## Earlier source builds are separate evidence

Root's `research/astra-pass52-verification.json` was read at SHA-256
`ec8bc92fe2fd42220976dbd618c8832b9ab8fdd1d96625148bacaa44b978c4e7`.
It retains the selector's first actual failed source and log (exit 1, source SHA
`d0489851ca3c2e87da6699c57a991d6783fe33ab7f01f6048f7bdc3503d446b6`).
The errors were the three fractional-part rewrites lacking the literal Nat-cast
shape and four n=1 band applications requiring normalization. The successful
source keeps the same complete theorem types and adds only those corrections.
Root's final selector build exited 0 at 3,007 jobs. It replayed two informational
`ring_nf` suggestions from SixthAffineSpecialAnchor; their wording about a ring
tactic failing to close a goal did not make the source build fail.

The same history retains the odd helper's initial failed quotient-cast proof,
its correction from broad `push_cast` to `Int.cast_natCast`, and its actual
exit-0 build at 3,001 jobs. The identity's type is unchanged. These are root's
source-build receipts, not reviewer-run builds. The fixed import probe below
produces independent actual type/axiom evidence without repeating any build.

## Predeclared fixed probe and sole replay entry

The only Lean payload has two direct imports, two complete universal type
assignments and two full axiom prints. No helper experiment, arithmetic fixture,
case enumeration or formatting option is included. The exact UTF-8 fence bytes,
including final newlines, are hashed before execution.

Probe SHA-256: `3b2d6020506c62cbf02ef8b75baf2076abb53d50fd36a9ef22c57673373a05e4`
Launcher SHA-256: `e6eee7cd23991773a4e118ea350d3f1a7dad650a65d4200c4349ccd51b2e0512`

The complete Python controller is embedded in the single Bash entry. It binds
all 27 inputs before and after execution, checks PATH resolves to the pinned
v4.32.1 Lean/Lake binaries, and checks both predeclared fence hashes. The
manifest pins mathlib to `520045ab14e26149ee970e2e617ca04b09bde5d6`.

Invocation: `lake env lean -j1 -s65536 --stdin`, with environment threads 1 and
stack 65536 KiB. Limits: AS 8 GiB; CPU soft/hard 59/60 s; wall 60 s; each regular
stdout/stderr file 128 KiB; core dumps disabled. A timeout kills the child's
process group. Every error, signal, timeout, cap hit or changed guard fails the
run and retains its actual status and complete streams; there is no retry,
build or escalation. The parser requires exactly the two named axiom reports
in order and no other stdout or stderr, with only propext, Classical.choice,
Quot.sound. It does not silently discard diagnostics.

The controller saves the complete pre-run report snapshot. That snapshot will
change on root's later replay after actual evidence is appended; the probe,
launcher, guards, resource bounds and output contract remain frozen.

```lean
import LonelyRunner.PairSafeSixthAffine
import LonelyRunner.OddHalfTimeShift

open LonelyRunner

example :
    ∀ (a b c : ℕ), 3 ∣ a → 3 ∣ b → ¬ 3 ∣ c →
      (6 ∣ a ∨ 6 ∣ b) → ¬ (6 ∣ a ∧ 6 ∣ b ∧ 2 ∣ c) →
      ∀ τ : ℝ, Int.fract (τ * (c : ℝ)) = (5 : ℝ) / 6 →
        FoldedPairSafeBands (circleNorm (τ * (a : ℝ)))
          (circleNorm (τ * (b : ℝ))) →
        ∃ (n : ℕ) (σ : ℤ), (n = 1 ∨ n = 2 ∨ n = 3) ∧
          (σ = 1 ∨ σ = -1) ∧
          ((1 : ℝ) / 6 ≤ circleNorm (((n : ℝ) * τ + (σ : ℝ) / 6) * (a : ℝ)) ∧
            (1 : ℝ) / 6 ≤ circleNorm (((n : ℝ) * τ + (σ : ℝ) / 6) * (b : ℝ))) ∧
          (Int.fract (((n : ℝ) * τ + (σ : ℝ) / 6) * (c : ℝ)) =
              (1 : ℝ) / 6 ∨
            Int.fract (((n : ℝ) * τ + (σ : ℝ) / 6) * (c : ℝ)) =
              (5 : ℝ) / 6) :=
  LonelyRunner.exists_pair_safe_special_sixth_affine

example :
    ∀ (t : ℝ) (d : ℕ), ¬ 2 ∣ d →
      circleNorm ((t + (1 : ℝ) / 2) * (d : ℝ)) =
        circleNorm (t * (d : ℝ) + (1 : ℝ) / 2) :=
  LonelyRunner.circleNorm_time_add_half_of_not_dvd_two

#print axioms LonelyRunner.exists_pair_safe_special_sixth_affine
#print axioms LonelyRunner.circleNorm_time_add_half_of_not_dvd_two
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
report = root / 'research/astra-selector-oddhalf-source-review.md'
text = report.read_text()
fence = chr(96) * 3
probe = text.split(fence + 'lean\n', 1)[1].split(fence, 1)[0].encode()
launcher = text.split(fence + 'bash\n', 1)[1].split(fence, 1)[0].encode()
out = Path(tempfile.mkdtemp(prefix='astra-selector-oddhalf-review-'))
(out / 'stdin.bin').write_bytes(probe)
(out / 'launcher.sh').write_bytes(launcher)
(out / 'report-snapshot.md').write_bytes(text.encode())
guards = {
    'LonelyRunner/PairSafeSixthAffine.lean': '290b5844fd7e3a11baf1c51d724a904362a41d76e31c3e78c45c7818b9763737',
    '.lake/build/lib/lean/LonelyRunner/PairSafeSixthAffine.olean': '2c62c951e8945d12a7945d2c41bfc9213f008d43dfc8482e5d238e9f0954a745',
    'LonelyRunner/OddHalfTimeShift.lean': 'ea274daeadc4bf2242399663cd5da914b1c096f62b58cb43fdffa2e625af6b5c',
    '.lake/build/lib/lean/LonelyRunner/OddHalfTimeShift.olean': '728fdb322e3fe2f10c3c693bc17dd460b302cca2ee42a7bd835ca1a6231e572c',
    'LonelyRunner/ThreeResidueModSix.lean': '5df5d3b25175ea631032a8acd567449442ec4d6e56408ab271d6601dec527dfa',
    '.lake/build/lib/lean/LonelyRunner/ThreeResidueModSix.olean': 'e0715460b7e829aaf6dd86bb477842d229e9c0f71caa2094116b127be56d38ea',
    'LonelyRunner/SixthAffineFoldedNorm.lean': '4ce24ac7955800ccc5ff5220de83d1972bb624d9e9b7e29237ac84874bd5396d',
    '.lake/build/lib/lean/LonelyRunner/SixthAffineFoldedNorm.olean': '3cf896c376526144d1a3a9dd6d7584f9ca433e8a9b0afa073a3b4f3aab4bd91f',
    'LonelyRunner/SixthAffineSpecialAnchor.lean': '6c78c1e4fdde4d25afbb03aadbcd16d6a0f7f7bc83aa287ede4f1a3ac3e2756e',
    '.lake/build/lib/lean/LonelyRunner/SixthAffineSpecialAnchor.olean': '8c47257ec2d0b4a84b1e076214e9725a44418fd71fd0ce72b52550415c8e557a',
    'LonelyRunner/FoldedPairSafeBands.lean': '00903bcb0c131fdb31ab87d55cea809249dfacbbd5861f82ab3a987d39b74b5f',
    '.lake/build/lib/lean/LonelyRunner/FoldedPairSafeBands.olean': 'd000b970290ec9072f02465f527b817f32bb72113ed7fa09bd43c9f0a47287c8',
    'LonelyRunner/FoldedCirclePhase.lean': '957606878108847d5ceff47be621ff0fc9c0a0d976568b5f5ef3dbb6db10481e',
    '.lake/build/lib/lean/LonelyRunner/FoldedCirclePhase.olean': '3032bbcf8e5c414daea831a7a415a40b4f254e5b72428b6fa078742e891afc06',
    'LonelyRunner/SixthAffinePhase.lean': '76e420713079ec0c3979e9b169cd78ecb6a932d6dc790ea7d9711adbb64b7d4b',
    '.lake/build/lib/lean/LonelyRunner/SixthAffinePhase.olean': '9a0cbfec2825c4b98fc7897835dc726929daabb3328a2d45818765c568cf47b3',
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
    'LonelyRunner.exists_pair_safe_special_sixth_affine',
    'LonelyRunner.circleNorm_time_add_half_of_not_dvd_two',
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

## Actual evidence and final disposition

The first and only authorized import-only invocation passed. Lean and the
complete Bash entry both exited 0. Both expanded universal types checked, and
both full axiom lists are exactly `propext`, `Classical.choice`, `Quot.sound`.
Both predeclarations matched and all 27 guards passed before and after. There
was no stderr, timeout, cap hit, runtime error, retry, build or resource change.

The inner invocation took 1.8232206980173942 seconds wall time, 1.226796 seconds
child user time and 0.5938829999999999 seconds child system time; recorded
maximum child RSS was 3,284,212 KiB. Lean stdout is 226 bytes, SHA-256
`d6a2fa40a73286594c36a529603415fd215a51ca439e38d1b8fa4166ebed47ac`.
The complete inner receipt SHA-256 is
`5be619ae69d668462f9277f84a84e1510dc7ffe7ca9cb4c8be4fc6c46cb6b4ed`.

The Bash entry was itself run under a file-captured outer Python wrapper with
the same AS/CPU/regular-stream caps and a 65-second outer wall limit: 60 seconds
for the inner Lean invocation and five seconds of receipt-writing grace. This
does not extend Lean's 60-second limit. Its actual wall time was
1.868132389994571 seconds, exit 0. Bash stdout is 5,564 bytes, SHA-256
`3aebd54f245285f1a3450cb3e14ae76029c61764debf0ec5be87688a4f6c3520`;
outer stderr is empty. Both empty stderr streams have SHA-256
`e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

The pre-run snapshot was 21,596 bytes, SHA-256
`ad7246d2a5e4e1c6eb31ee0dbfc286fe774357d52637effe75dff11a77fdea26`.
The two temporary evidence directories retain exact stdin, launcher, report
snapshot, inner/outer receipts and original regular streams. The report below
also preserves both receipts and all stdout/stderr contents; no diagnostic was
truncated or omitted. Those records suffice to interpret the actual execution
even if the temporary directories are subsequently removed.

Full outer receipt, SHA-256
`c69dc352da4929c2d8bc127a8a25cc6409d609d9386402c610473fc87594b8bd`:

```json
{
  "address_space_bytes": 8589934592,
  "argv": [
    "bash",
    "/tmp/astra-selector-oddhalf-entry-a1qm3q9_/entry.sh"
  ],
  "cpu_seconds": [
    59,
    60
  ],
  "error": null,
  "exit": 0,
  "files": {
    "entry.sh": {
      "bytes": 9684,
      "sha256": "e6eee7cd23991773a4e118ea350d3f1a7dad650a65d4200c4349ccd51b2e0512"
    },
    "stderr.bin": {
      "bytes": 0,
      "sha256": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
    },
    "stdout.bin": {
      "bytes": 5564,
      "sha256": "3aebd54f245285f1a3450cb3e14ae76029c61764debf0ec5be87688a4f6c3520"
    }
  },
  "outer_wall_limit_note": "60-second inner Lean limit plus 5-second receipt-writing grace",
  "outer_wall_limit_seconds": 65,
  "passed": true,
  "stream_bytes": 131072,
  "stream_cap_hit": false,
  "timed_out": false,
  "wall_seconds": 1.868132389994571
}
```

Complete original Bash stdout, containing the full inner receipt and unabridged
Lean stdout/stderr between explicit markers:

```text
EVIDENCE_DIR /tmp/astra-selector-oddhalf-review-63seu272
RECEIPT_SHA256 5be619ae69d668462f9277f84a84e1510dc7ffe7ca9cb4c8be4fc6c46cb6b4ed
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
    "LonelyRunner.circleNorm_time_add_half_of_not_dvd_two": [
      "propext",
      "Classical.choice",
      "Quot.sound"
    ],
    "LonelyRunner.exists_pair_safe_special_sixth_affine": [
      "propext",
      "Classical.choice",
      "Quot.sound"
    ]
  },
  "child_max_rss_kib": 3284212,
  "child_system_seconds": 0.5938829999999999,
  "child_user_seconds": 1.226796,
  "environment": {
    "LEAN_NUM_THREADS": "1",
    "LEAN_STACK_SIZE_KB": "65536"
  },
  "error": null,
  "exit": 0,
  "files": {
    "launcher.sh": {
      "bytes": 9684,
      "sha256": "e6eee7cd23991773a4e118ea350d3f1a7dad650a65d4200c4349ccd51b2e0512"
    },
    "report-snapshot.md": {
      "bytes": 21596,
      "sha256": "ad7246d2a5e4e1c6eb31ee0dbfc286fe774357d52637effe75dff11a77fdea26"
    },
    "stderr.bin": {
      "bytes": 0,
      "sha256": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
    },
    "stdin.bin": {
      "bytes": 1308,
      "sha256": "3b2d6020506c62cbf02ef8b75baf2076abb53d50fd36a9ef22c57673373a05e4"
    },
    "stdout.bin": {
      "bytes": 226,
      "sha256": "d6a2fa40a73286594c36a529603415fd215a51ca439e38d1b8fa4166ebed47ac"
    }
  },
  "guards": {
    ".lake/build/lib/lean/LonelyRunner/FastRunnerInsertion.olean": "121edfbaed0d7b9fed32bacf891de838142988e48dcb4e7f2bed0c488ea49136",
    ".lake/build/lib/lean/LonelyRunner/FoldedCirclePhase.olean": "3032bbcf8e5c414daea831a7a415a40b4f254e5b72428b6fa078742e891afc06",
    ".lake/build/lib/lean/LonelyRunner/FoldedPairSafeBands.olean": "d000b970290ec9072f02465f527b817f32bb72113ed7fa09bd43c9f0a47287c8",
    ".lake/build/lib/lean/LonelyRunner/OddHalfTimeShift.olean": "728fdb322e3fe2f10c3c693bc17dd460b302cca2ee42a7bd835ca1a6231e572c",
    ".lake/build/lib/lean/LonelyRunner/PairSafeSixthAffine.olean": "2c62c951e8945d12a7945d2c41bfc9213f008d43dfc8482e5d238e9f0954a745",
    ".lake/build/lib/lean/LonelyRunner/SixthAffineFoldedNorm.olean": "3cf896c376526144d1a3a9dd6d7584f9ca433e8a9b0afa073a3b4f3aab4bd91f",
    ".lake/build/lib/lean/LonelyRunner/SixthAffinePhase.olean": "9a0cbfec2825c4b98fc7897835dc726929daabb3328a2d45818765c568cf47b3",
    ".lake/build/lib/lean/LonelyRunner/SixthAffineSpecialAnchor.olean": "8c47257ec2d0b4a84b1e076214e9725a44418fd71fd0ce72b52550415c8e557a",
    ".lake/build/lib/lean/LonelyRunner/StructuredClasses.olean": "4ada0ca2f0a5f20a8c83c3c2e58256e931c3b283882a88a074aeedb02d7e048f",
    ".lake/build/lib/lean/LonelyRunner/ThreeResidueModSix.olean": "e0715460b7e829aaf6dd86bb477842d229e9c0f71caa2094116b127be56d38ea",
    ".lake/packages/mathlib/.lake/build/lib/lean/Mathlib/Tactic.olean": "0534ef12e7aaf8ffbb6e520a91f922da4469d0dca2b54c87b4458e1faa28a6a2",
    ".lake/packages/mathlib/Mathlib/Tactic.lean": "c6f2c548596b635a3d5c8aff8b19cbdeb60dd54e41bb89a1cd03b1a54d335fa5",
    "/home/joshua/.elan/toolchains/leanprover--lean4---v4.32.1/bin/lake": "60330ab6f07dce20f3fa9ebb08e8b984ea9549eac172afeb15d9d2227060e2b3",
    "/home/joshua/.elan/toolchains/leanprover--lean4---v4.32.1/bin/lean": "e8baaa71855a616dc351028f3ad2200051b0671f423a1696a100e809302d5550",
    "LonelyRunner/FastRunnerInsertion.lean": "dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5",
    "LonelyRunner/FoldedCirclePhase.lean": "957606878108847d5ceff47be621ff0fc9c0a0d976568b5f5ef3dbb6db10481e",
    "LonelyRunner/FoldedPairSafeBands.lean": "00903bcb0c131fdb31ab87d55cea809249dfacbbd5861f82ab3a987d39b74b5f",
    "LonelyRunner/OddHalfTimeShift.lean": "ea274daeadc4bf2242399663cd5da914b1c096f62b58cb43fdffa2e625af6b5c",
    "LonelyRunner/PairSafeSixthAffine.lean": "290b5844fd7e3a11baf1c51d724a904362a41d76e31c3e78c45c7818b9763737",
    "LonelyRunner/SixthAffineFoldedNorm.lean": "4ce24ac7955800ccc5ff5220de83d1972bb624d9e9b7e29237ac84874bd5396d",
    "LonelyRunner/SixthAffinePhase.lean": "76e420713079ec0c3979e9b169cd78ecb6a932d6dc790ea7d9711adbb64b7d4b",
    "LonelyRunner/SixthAffineSpecialAnchor.lean": "6c78c1e4fdde4d25afbb03aadbcd16d6a0f7f7bc83aa287ede4f1a3ac3e2756e",
    "LonelyRunner/StructuredClasses.lean": "5328a7a88d2b42f86ffc3f0f0418ca22c761219e8fa3e5822bda5a18ac286e8c",
    "LonelyRunner/ThreeResidueModSix.lean": "5df5d3b25175ea631032a8acd567449442ec4d6e56408ab271d6601dec527dfa",
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
  "wall_seconds": 1.8232206980173942
}
STDOUT-BEGIN
'LonelyRunner.exists_pair_safe_special_sixth_affine' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.circleNorm_time_add_half_of_not_dvd_two' depends on axioms: [propext, Classical.choice, Quot.sound]
STDOUT-END
STDERR-BEGIN
STDERR-END
```

Complete outer stderr (zero bytes):

```text
```

Final disposition: accept the exact selector and odd half-time identity as
implemented, with their stated hypotheses and scope. No source correction is
requested. The paired-band premise, excluded both-six/even case, later boundary
minimum-zero assembly and eventual unconditional five-moving 1/6 result are
not supplied by these two declarations. This review does not claim a new
canonical runner count or an unrestricted proof/disproof.
