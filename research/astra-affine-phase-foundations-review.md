# Affine phase-certificate foundations: independent source review

**Semantic decision: accept all three exact public theorem contracts and their
complete proofs.** The supplied finite band facts are sufficient at singleton
and open atoms; the cover includes the final singleton; the assembly selects
one candidate shared by all three coordinate types. This source supplies no
concrete Renault 6.1/6.4 certificate or new runner-count theorem. The one
import-only execution result is recorded separately below.

I authored neither this source nor the assessment defining these three
interfaces. I previously reviewed the larger one-three-divisible manuscript.
Only this report is owned. Current config, workflow, policy and focused state
were read: task `/root/affine_phase_foundations_review`, checkpoint
`a1d90c2ace37dc7779dc78e104da331965af6646`, requested Astra/xhigh, observed
runtime metadata unavailable, research/in_progress. Startup workflow validation
exited 0 with `workflow structural validation passed; it cannot certify
mathematical validity.` Terra High owns focused compile/repair, while root
inspects successful bound receipts without an identical repeated probe. Full
integration/trust and independent semantic review remain distinct obligations.
Canonical N=6 remains the transition to uniform arbitrary-N research.

| Input | SHA-256 |
| --- | --- |
| `LonelyRunner/AffinePhaseCertificate.lean` | `175fe8208166387b2fd0d4da15e3742ed2c9ca5f6d687aedced8f6130f3249eb` |
| `research/astra-remaining-phase-certificate-assessment.md` | `16ad698faeac6f3469c391094806f8bc301bc46fdfe294caefbf557051ba0589` |
| Source-build receipt `research/astra-affine-phase-certificate-implementation.json` | `74c7d9542f1d24b7b0e01bb66f9de6325068f08012afc259f3182289c16958c8` |

All 233 source lines and the complete assessment were read, as were the full
FiniteCutCover and RealPhaseBands proofs and the relevant closed integer-band
proof in StructuredClasses. All three public types match the assessment. The
probe below explicitly supplies every quantifier and expands CutAtomMem in
both uses. The named input structure remains a structure, whose entire finite
meaning is spelled out here and bound by the frozen source.

## Definitions and band soundness

For arbitrary C : Nat→Nat and natural a,A,S, the source defines
R=2*C(a/2) on even a and R=C(a/2)+C(a/2+1) on odd a,
P=A*R+120*S, and Q=P/720, with natural division. Thus R/720 is the
singleton phase or the adjacent-cut midpoint. The effective numerator S is
unrestricted natural; there is no S<6, bounded quotient or residue-unit premise.

`AffineSixthBandFact C a A S s` is a Prop structure with exactly two fields:

- If a%2=0, the remainder P%720 is strictly between 120 and 600 for s=true,
  or in the closed interval [120,600] for s=false.
- If a%2≠0, `360*Q+60 ≤ A*C(a/2)+60*S` and
  `A*C(a/2+1)+60*S ≤ 360*Q+300`, for either flag.

No membership, coverage, sortedness, floor equality or real conclusion is
already assumed inside these fields. Only the field for the actual atom parity
is used. The theorem requires A>0 and actual CutAtomMem C 360 a x; it returns
strict or closed sixth-margin goodness of A*x+S/6 according to the same flag.

At a singleton x=C(a/2)/360, let T=P%720. Natural division gives
720*Q+T=P. After exact casts and the singleton identity this proves
`A*x+S/6 = Q+T/720`. The quotient is cast to an integer when applying the
integer-band lemmas. Closed 120≤T≤600 yields
Q+1/6≤phase≤Q+5/6; the strict version yields both strict comparisons. The
source applies the correct closed or strict lemma in the separate Bool branches.
At T=120 or T=600 only the closed condition is satisfied, so endpoint equalities
cannot enter a strict singleton certificate. Arbitrarily large S is handled by
P and Q; its integer part is never discarded without the division identity.

At an open atom, write L=C(a/2)/360 and U=C(a/2+1)/360. Membership means
L<x<U, with no equality allowed. Casting the two finite endpoint inequalities
gives Q+1/6≤A*L+S/6 and A*U+S/6≤Q+5/6. Since A>0, the actual interior phase
lies strictly between those band endpoints. The read
`circleNorm_gt_of_affine_open_band` proves strict norm>1/6; the closed branch
weakens only that conclusion to ≥. Thus the endpoint certificates may be closed
without weakening the strict interior result. The positive-slope hypothesis is
essential to this step and is actually supplied. The uniform A>0 requirement
is retained even though singleton soundness alone could use a weaker premise.

For open atoms, Q is the natural quotient selected from the representative,
but its being a floor of the actual x-dependent phase is not assumed or needed:
the supplied endpoint inequalities put the entire open affine interval inside
one Q-band. The proof is an implication from finite conditions, not an assertion
that those conditions always hold or that every false bit is false throughout
an atom. There is no predicate-constancy or cut-completeness claim here.

C and a are unrestricted naturals/functions: no sortedness, finite cut range,
or C≤360 assumption is added. Descending or coincident adjacent cuts simply
have no open member, and an arbitrary singleton is handled by its exact phase.
x is quantified over all reals; membership may of course restrict it. A and S
are natural, so this theorem is not a signed-slope or signed-effective-shift
claim. Its fixed input denominator 360 and affine numerator denominator 720
match the assessment exactly.

## Closed cut cover

`cutAtomMem_covers_closed_interval` takes natural n,D with D>0, arbitrary
C : Nat→Nat and x between C(0)/D and C(n)/D, both endpoints included. If x equals
the final endpoint, the source returns a=2*n in Fin(2*n+1). Its parity and
quotient decode exactly to singleton C(n)/D. For n=0, the two input inequalities
force this equality and Fin 1 contains precisely the needed atom 0.

Otherwise x<C(n)/D. The inspected adjacent-crossing theorem on the real cut
sequence yields i<n with C(i)/D≤x<C(i+1)/D. Its induction needs no monotonicity:
if x<C(n-1)/D it invokes the earlier crossing; otherwise that last adjacent
pair is an upward crossing. The new proof chooses singleton 2*i if the left
comparison is equality, or open atom 2*i+1 otherwise. Both indices are strictly
below 2*n+1, and the odd index arithmetic is proved explicitly. No extra open
interval is appended beyond the final endpoint.

Consequently arbitrary repeated or unsorted cuts are covered under the stated
endpoint hypotheses; the theorem asserts coverage, not uniqueness or a sorted
partition. If the endpoints cannot bracket x, its premises are absent. D>0 is
retained exactly from the proposed contract, although this particular argument
does not use it (the source-build linter reports that fact). It is not a missing
sign condition or an unproved positive-n assumption.

## Coordinate-typed common candidate

`typed_phase_certificate_sound` allows arbitrary natural candidate count B,
separate row counts m(j), and M(j,i)⊆Fin B. Domain and Good are arbitrary
coordinate-indexed predicates; the theorem does not silently identify weight
types. For a supplied triple x in its respective domains, hrow produces one
sound row i(j) per coordinate. Classical choice packages these dependent Fin
indices into one function i. The proof invokes hcommon once on that entire
function, obtaining one c : Fin B present in all three selected rows. Each
row implication then proves Good(j,c,x(j)) for that same c.

There is no per-coordinate candidate choice, coordinate sorting, nonempty-mask
assumption or phase distinctness hidden by the proof. All row tuples are covered
by hcommon, including equal row indices where types agree. B=0 and m(j)=0
remain in the signature: on an inhabited domain the supplied row/common
hypotheses must rule out the corresponding impossible choices; the theorem
cannot manufacture a candidate from an empty Fin B. Repeated phase values are
allowed because x is an arbitrary Fin 3 function. The typed interface prevents
sorting a distinguished weight-two row into a weight-one coordinate.

Coverage, true-bit soundness, core domination, actual row data and common-bit
checks remain external obligations of future concrete certificates. Minimality
is not an assumption, and no finite masks or candidate tables are present in
this module. The three declarations are sound generic foundations, not a
completed 6.1/6.4 or runner theorem.

## Earlier focused build and this fixed verification

The worker receipt's source snapshots and raw base64 logs were decoded and
hash-checked without running Lean. Initial source da46e7ca... exited 1: the
proof referenced nonexistent `Bool.true_eq_true` and supplied the wrong
orientation of a disequality to a strict upper-bound step. One worker repair
round produced the frozen source and exit 0 (3002 jobs). The success log SHA is
`d11194d72fc2b1260f2adedef2f2d30f6f723fdf032394565d37e269cb0d3ebc`;
it includes the sole unused-hD warning described above. The initial raw log
SHA is `7e4eb96a6df8f6d793dac3b542ba38e4ce8d34e8ba3d5b517bd88487a5dad453`.
No Astra source repair is recorded. Those focused checks are distinct from this
review's authorized exact-type/axiom probe; they are not repeated here.

The following sole Bash entry runs only `lake env lean -j1 -s65536 --stdin`,
with LEAN_NUM_THREADS=1 and LEAN_STACK_SIZE_KB=65536. Predeclared limits are
AS 8 GiB, CPU soft/hard 59/60 seconds, wall 60 seconds, and regular-file stdout/
stderr caps of 128 KiB each. Core dumps are disabled; timeouts kill the child
process group. There are no numerical fixtures, data enumeration, proof builds,
format options, retries or resource escalation. Exactly three complete axiom
reports are required, in order, containing only propext, Classical.choice and
Quot.sound, with no other stdout and empty stderr.

The literal guards bind the target, immediate and relevant project dependencies
and artifacts, mathlib Tactic, pinned toolchain/manifest/lakefile and actual
Lean/Lake binaries, plus the exact assessment. Mutable root imports, state,
AxiomAudit, receipts and concurrent files are excluded. All guards are checked
before/after. The controller snapshots the report and requires it unchanged
during execution; the semantic/probe prefix is hashed before/after separately
from the later evidence append. The receipt hashes the canonical literal guard
dictionary instead of duplicating it. Root will inspect the complete successful
receipt without an identical repeat unless inputs change or a concern arises.

Probe bytes: 1623

Probe SHA-256: `4ab4972a312805581ec5b603a75fed12b3bcba27ca5775985b5abe4da814f112`

Launcher bytes: 9584

Launcher SHA-256: `13c313834754d9b1ef9acd80e4831d30f7a7bb7db5c0fa7bec6656d67c4aa86f`

```lean
import LonelyRunner.AffinePhaseCertificate

open LonelyRunner

example : ∀ (C : ℕ → ℕ) (a A S : ℕ) (s : Bool), 0 < A →
    AffineSixthBandFact C a A S s → ∀ x : ℝ,
    (if a % 2 = 0 then x = (C (a / 2) : ℝ) / 360
     else (C (a / 2) : ℝ) / 360 < x ∧ x < (C (a / 2 + 1) : ℝ) / 360) →
    if s then (1 : ℝ) / 6 < circleNorm ((A : ℝ) * x + (S : ℝ) / 6)
    else (1 : ℝ) / 6 ≤ circleNorm ((A : ℝ) * x + (S : ℝ) / 6) :=
  LonelyRunner.affineSixthBandFact_sound

example : ∀ (n D : ℕ), 0 < D → ∀ (C : ℕ → ℕ) (x : ℝ),
    (C 0 : ℝ) / (D : ℝ) ≤ x → x ≤ (C n : ℝ) / (D : ℝ) →
    ∃ a : Fin (2 * n + 1),
      if a.val % 2 = 0 then x = (C (a.val / 2) : ℝ) / (D : ℝ)
      else (C (a.val / 2) : ℝ) / (D : ℝ) < x ∧
        x < (C (a.val / 2 + 1) : ℝ) / (D : ℝ) :=
  LonelyRunner.cutAtomMem_covers_closed_interval

example : ∀ (B : ℕ) (m : Fin 3 → ℕ)
    (M : (j : Fin 3) → Fin (m j) → Finset (Fin B))
    (Domain : Fin 3 → ℝ → Prop) (Good : Fin 3 → Fin B → ℝ → Prop),
    (∀ (j : Fin 3) (x : ℝ), Domain j x →
      ∃ i : Fin (m j), ∀ c : Fin B, c ∈ M j i → Good j c x) →
    (∀ i : (j : Fin 3) → Fin (m j),
      ∃ c : Fin B, ∀ j : Fin 3, c ∈ M j (i j)) →
    ∀ x : Fin 3 → ℝ, (∀ j : Fin 3, Domain j (x j)) →
      ∃ c : Fin B, ∀ j : Fin 3, Good j c (x j) :=
  LonelyRunner.typed_phase_certificate_sound

#print axioms LonelyRunner.affineSixthBandFact_sound
#print axioms LonelyRunner.cutAtomMem_covers_closed_interval
#print axioms LonelyRunner.typed_phase_certificate_sound
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
report = root / 'research/astra-affine-phase-foundations-review.md'
text = report.read_text()
marker = '\n<!-- ACTUAL EVIDENCE -->\n'
assert text.count(marker) == 1
prefix = text.split(marker, 1)[0].encode()
fence = chr(96) * 3
probe = text.split(fence + 'lean\n', 1)[1].split(fence, 1)[0].encode()
launcher = text.split(fence + 'bash\n', 1)[1].split(fence, 1)[0].encode()
out = Path(tempfile.mkdtemp(prefix='astra-affine-phase-foundations-review-'))
(out / 'stdin.bin').write_bytes(probe)
(out / 'launcher.sh').write_bytes(launcher)
(out / 'report-snapshot.md').write_bytes(text.encode())
guards = {
    'LonelyRunner/AffinePhaseCertificate.lean': '175fe8208166387b2fd0d4da15e3742ed2c9ca5f6d687aedced8f6130f3249eb',
    '.lake/build/lib/lean/LonelyRunner/AffinePhaseCertificate.olean': '43af447c0d7bc4643a65fb77f8615793054d6505201f46e128d9543cba9b5efc',
    'LonelyRunner/FiniteCutCover.lean': 'b7e7e50834bc86d13ffde759e3d0c2dc4d2480a03ec61eb88a70ca215fcc1011',
    '.lake/build/lib/lean/LonelyRunner/FiniteCutCover.olean': 'e135595b4c42102e9e2736492c39fc95914e1d09800615c3d943553abedc1ade',
    'LonelyRunner/RealPhaseBands.lean': '7f70467bad6bb5a8a859bff8947af1dc73e685910b69157b49bab259b3c02ca0',
    '.lake/build/lib/lean/LonelyRunner/RealPhaseBands.olean': '7442f9f49d9f1e2d214460557f6a891ba13717ededff679876033793ac2c6504',
    'LonelyRunner/StructuredClasses.lean': '5328a7a88d2b42f86ffc3f0f0418ca22c761219e8fa3e5822bda5a18ac286e8c',
    '.lake/build/lib/lean/LonelyRunner/StructuredClasses.olean': '4ada0ca2f0a5f20a8c83c3c2e58256e931c3b283882a88a074aeedb02d7e048f',
    'LonelyRunner/FastRunnerInsertion.lean': 'dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5',
    '.lake/build/lib/lean/LonelyRunner/FastRunnerInsertion.olean': '121edfbaed0d7b9fed32bacf891de838142988e48dcb4e7f2bed0c488ea49136',
    'LonelyRunner/Definitions.lean': '5f0258a6ab99950fc7045b2200d6708fe7603d3caa4d62855ef2b19a330c95aa',
    '.lake/build/lib/lean/LonelyRunner/Definitions.olean': 'a73f18b23e60c128456eab0a2c43fbadd0bf31e136dc4df9f94bfeb161a5773a',
    '.lake/packages/mathlib/Mathlib/Tactic.lean': 'c6f2c548596b635a3d5c8aff8b19cbdeb60dd54e41bb89a1cd03b1a54d335fa5',
    '.lake/packages/mathlib/.lake/build/lib/lean/Mathlib/Tactic.olean': '0534ef12e7aaf8ffbb6e520a91f922da4469d0dca2b54c87b4458e1faa28a6a2',
    'lean-toolchain': '8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af',
    'lakefile.toml': 'bdcbaaa18d518409619215e8acf7892452c1fa5c6e80ba742ce67f7380682a26',
    'lake-manifest.json': '887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218',
    '/home/joshua/.elan/toolchains/leanprover--lean4---v4.32.1/bin/lean': 'e8baaa71855a616dc351028f3ad2200051b0671f423a1696a100e809302d5550',
    '/home/joshua/.elan/toolchains/leanprover--lean4---v4.32.1/bin/lake': '60330ab6f07dce20f3fa9ebb08e8b984ea9549eac172afeb15d9d2227060e2b3',
    'research/astra-remaining-phase-certificate-assessment.md': '16ad698faeac6f3469c391094806f8bc301bc46fdfe294caefbf557051ba0589',
}
argv = ['lake', 'env', 'lean', '-j1', '-s65536', '--stdin']
limits = {'address_space_bytes': 8 * 1024**3, 'cpu_seconds': [59, 60],
          'wall_seconds': 60, 'stream_bytes': 128 * 1024}
symbols = ['LonelyRunner.affineSixthBandFact_sound', 'LonelyRunner.cutAtomMem_covers_closed_interval', 'LonelyRunner.typed_phase_certificate_sound']
allowed = {'propext', 'Classical.choice', 'Quot.sound'}
guard_manifest = (json.dumps(guards, sort_keys=True, separators=(',', ':')) + '\n').encode()
receipt = {'argv': argv, 'limits': limits, 'guard_count': len(guards),
           'guard_manifest_sha256': hashlib.sha256(guard_manifest).hexdigest(),
           'environment': {'LEAN_NUM_THREADS': '1', 'LEAN_STACK_SIZE_KB': '65536'},
           'exit': None, 'timed_out': False, 'error': None,
           'guards_before': False, 'guards_after': False,
           'predeclarations_match': False, 'axioms': None,
           'report_prefix_before_sha256': hashlib.sha256(prefix).hexdigest(),
           'report_unchanged_during_run': False,
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
    text_after = report.read_text()
    receipt['report_prefix_after_sha256'] = sha(text_after.split(marker, 1)[0].encode())
    receipt['report_unchanged_during_run'] = text_after == text
    assert receipt['report_unchanged_during_run'], 'report changed during run'
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
                         and receipt['report_unchanged_during_run']
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

<!-- ACTUAL EVIDENCE -->

## Actual bounded probe receipt

The first and only authorized import-only probe passed. Lean and the exact
fenced Bash both exited 0. All three expanded universal type assignments checked;
each full axiom report is exactly propext, Classical.choice, Quot.sound. All 20
guards and both predeclarations matched before/after, with no other stdout,
empty stderr, no errors, warnings, signal, timeout, cap hit, retry or escalation.
This was not a source build or numerical certificate check.

The inner receipt SHA is
`9d704495bba0392f22b2597685d36004981dbc2467136d4e23a9d76e7535be2d`.
Raw Lean stdout is 312 bytes with SHA
`86d428994c04926a81359992c43f552abc47f69aa2a076bc4870affa50415400`;
stderr is the empty byte string. Inner wall time was 1.820949215994915 seconds
and peak child RSS 3,281,292 KiB. All original measurements and limits are in
the complete receipt below. Original stdin, launcher, pre-run report snapshot,
receipt and streams remain in
`/tmp/astra-affine-phase-foundations-review-4ewfmbkp`.

The outer regular-file capture ran the exact frozen Bash bytes through
`subprocess.Popen(['bash', '-c', program.decode()])`, using the same AS/CPU/
file/core limits and a 65-second outer watchdog around the inner 60-second
limit. This is one invocation of the stated entry, not an extra Lean check.
Its complete receipt SHA is
`62614cfeacc3ccdf55265a85e662cfeed5578bfea797e329e1f1e95071d15d6c`;
its files remain in `/tmp/astra-affine-phase-foundations-entry-uf9xj1ty`.
Outer stderr is empty. The complete original outer stdout below contains the
full inner receipt and raw Lean stdout/stderr with exact delimiters; nothing
is omitted, summarized in place of raw data, or reconstructed.

The pre-run full report SHA was
`42d0b718b3bfbbb8e6511b9440f4237ba5be51bc05f88172e394fef2684ec077`.
The semantic/probe prefix SHA is
`faf40dd106043d904351726c9a1831447b25ca10e9a40fa171100037d2f171f3`
before/after execution and after this append. Probe/Bash bytes were compared
with the original captured files; the guard-manifest hash was statically
recomputed from the launcher dictionary. No second probe was run.

```json
{
  "exit": 0,
  "files": {
    "entry.sh": {
      "bytes": 9584,
      "sha256": "13c313834754d9b1ef9acd80e4831d30f7a7bb7db5c0fa7bec6656d67c4aa86f"
    },
    "stderr.bin": {
      "bytes": 0,
      "sha256": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
    },
    "stdout.bin": {
      "bytes": 2811,
      "sha256": "3cce4d9f7b727d33b808dbe0a4f5da1db50e1daa25590b0aed61126df0234e3f"
    }
  },
  "kind": "one exact fenced Bash invocation; outer capture only",
  "launcher_sha256": "13c313834754d9b1ef9acd80e4831d30f7a7bb7db5c0fa7bec6656d67c4aa86f",
  "timed_out": false,
  "wall_seconds": 1.8682961529993918
}
```

```text
EVIDENCE_DIR /tmp/astra-affine-phase-foundations-review-4ewfmbkp
RECEIPT_SHA256 9d704495bba0392f22b2597685d36004981dbc2467136d4e23a9d76e7535be2d
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
    "LonelyRunner.affineSixthBandFact_sound": [
      "propext",
      "Classical.choice",
      "Quot.sound"
    ],
    "LonelyRunner.cutAtomMem_covers_closed_interval": [
      "propext",
      "Classical.choice",
      "Quot.sound"
    ],
    "LonelyRunner.typed_phase_certificate_sound": [
      "propext",
      "Classical.choice",
      "Quot.sound"
    ]
  },
  "child_max_rss_kib": 3281292,
  "child_system_seconds": 0.5600459999999999,
  "child_user_seconds": 1.268489,
  "environment": {
    "LEAN_NUM_THREADS": "1",
    "LEAN_STACK_SIZE_KB": "65536"
  },
  "error": null,
  "exit": 0,
  "files": {
    "launcher.sh": {
      "bytes": 9584,
      "sha256": "13c313834754d9b1ef9acd80e4831d30f7a7bb7db5c0fa7bec6656d67c4aa86f"
    },
    "report-snapshot.md": {
      "bytes": 22090,
      "sha256": "42d0b718b3bfbbb8e6511b9440f4237ba5be51bc05f88172e394fef2684ec077"
    },
    "stderr.bin": {
      "bytes": 0,
      "sha256": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
    },
    "stdin.bin": {
      "bytes": 1623,
      "sha256": "4ab4972a312805581ec5b603a75fed12b3bcba27ca5775985b5abe4da814f112"
    },
    "stdout.bin": {
      "bytes": 312,
      "sha256": "86d428994c04926a81359992c43f552abc47f69aa2a076bc4870affa50415400"
    }
  },
  "guard_count": 20,
  "guard_manifest_sha256": "2ed87fc2a9de7d5dcee72e509165a0cf8557a4be5ab52af8a330aef9eb05732a",
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
  "report_prefix_after_sha256": "faf40dd106043d904351726c9a1831447b25ca10e9a40fa171100037d2f171f3",
  "report_prefix_before_sha256": "faf40dd106043d904351726c9a1831447b25ca10e9a40fa171100037d2f171f3",
  "report_unchanged_during_run": true,
  "resolved_executables": {
    "lake": "/home/joshua/.elan/toolchains/leanprover--lean4---v4.32.1/bin/lake",
    "lean": "/home/joshua/.elan/toolchains/leanprover--lean4---v4.32.1/bin/lean"
  },
  "stream_cap_hit": false,
  "timed_out": false,
  "wall_seconds": 1.820949215994915
}
STDOUT-BEGIN
'LonelyRunner.affineSixthBandFact_sound' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.cutAtomMem_covers_closed_interval' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.typed_phase_certificate_sound' depends on axioms: [propext, Classical.choice, Quot.sound]
STDOUT-END
STDERR-BEGIN
STDERR-END
```

Final disposition: **accept the frozen source's three generic interfaces and
the successful exact-type/axiom probe**. Root can inspect these complete bound
receipts without duplicating the run. Full integrated build/trust remains a
separate checkpoint check. Concrete true-bit facts, typed row domination and
common-candidate data are still needed for the contemplated phase theorems.
No source/state/Git/import/cache edits were made, and neither canonical N=6
nor unrestricted LRC is promoted by this foundation module.
