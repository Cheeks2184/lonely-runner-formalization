# Independent review of the concrete Renault phase assembly

Semantic disposition: **accept the three frozen modules at the exact Renault
5.1 phase-lemma scope**. The concrete facts now supply the premises left open
by the generic band and mask modules. No semantic correction is requested.
Execution evidence from this review is recorded separately below. This is
not a new runner-count theorem or a resolution of unrestricted LRC.

Assigned checkpoint: `a854ae8`; requested route Astra/xhigh, with observed
runtime model/effort unavailable in focused state. I did not author these
three source modules. This task owns only this report. Current policy and
focused state were read and workflow validation passed. The complete source
was read in a separate, untruncated call after an initial aggregate display
was truncated. The accepted concrete-bridge plan, kernel-check predeclaration,
execution record and failed-attempt history were inspected. History's long
diagnostics were checked by complete byte/hash validation and normalized
diagnostic classes, rather than treating a truncated display as evidence.

Frozen sources:

| File | SHA-256 |
| --- | --- |
| `LonelyRunner/FiniteMaskSubset.lean` | `8a7dec857dc4a9c4f2b5d4360389e97487163bd69d2d01ed3408b1335f162c3e` |
| `LonelyRunner/RenaultPhaseConcreteData.lean` | `1d5709da3631bc51d60bb4dbeb94fa2668da5cdbf5a63007e7b4ebd96a5b6c17` |
| `LonelyRunner/RenaultPhaseLemma.lean` | `1ceac85438299dffdd48d57fb0052b598a9bd5eda995cabff0256885529d89cb` |

## Literal data, rows, and historical source check

The four definitions have exactly the required types: cuts are a total
`Nat → Nat` using 61 literal entries with `getD i 0`; atom masks are
`Fin 120 → Nat`; core atoms are `Fin 41 → Fin 120`; dominators are
`Fin 120 → Fin 41`. A static comparison with certificate SHA-256
`c1374409d4f6804487179fe9765695a2f0d756ccd2a79b5ee8616e919acbb7b1`
checked all four lists in order. The core list is exactly
`[class_reps[i] for i in minimal_classes]`, and the dominator list is exactly
the supplied `dom`, interpreted as retained-index positions. Every raw core
literal is in [0,120), and every raw dominator literal in [0,41), so `Fin`
numeral coercion cannot conceal an out-of-range value by modular reduction.

For `a : Fin 120`, `a.val/2 < 60` and its successor is at most 60. Thus all
cut accesses relevant to atoms and band predicates use the 61 actual entries;
the total default outside that range does not change the result. The cut at
index 60 is 360, and the zero cut is zero. No atom index 120 is introduced.

The static check also confirms exactly 120 row declarations, with matching
fixed indices 0 through 119, and exactly 120 corresponding branches in the
`fin_cases` assembly. Each row is a conjunction of two implications over
`k : Fin 23`: the parity-appropriate singleton remainder facts, retaining the
closed/strict candidate distinction, and the open interval endpoint facts.
It is precisely the two non-endpoint fields of `PhaseBandFacts`, without any
changed denominator, candidate domain, or weakened implication. Ordinary
`by decide` proves each fixed row. The public band-facts theorem assembles
them and the two endpoint equalities. The other two concrete public facts
use the exact defined objects to prove all 41 core-mask equalities and all
120 domination AND-equalities. This review did not reevaluate those
predicates, generate masks, search witnesses, or rerun any row proof.

The static list digests below use compact JSON with no final newline:

| List | Length | SHA-256 |
| --- | ---: | --- |
| cuts | 61 | `2c6cfd6f93fe9b41f5f744cf4c621bf198e563405039e85fa40f9bb8c63a9981` |
| atom masks | 120 | `366c03c646faa0920574356e1e5cabed4a5d29bc3e311d4a29bc56469f77976c` |
| core atoms | 41 | `9243ace4d3027ac51361aeb5751edd40fc73527e29a37f4db50a6e2e8d21a8ed` |
| dominators | 120 | `62e6588fc86a000dc1e10cf111ca6d59982da7dcea275242fd879c767af834b8` |

The kernel-check history preserves source SHA
`173ecfcd7a20183bd1ae94dcc524ec144e25c6b1dcfa2284705eac189441c79a`,
which exited 1 after 3.4235238280089106 seconds. Its complete 25,722-byte
stdout hashes to
`4007e7bb3dfdd3f3ea5c7f0ab92d134f6c4faf5454eb09a95cd808ce8bb93e30`;
stderr is empty. The errors are failure to synthesize `Decidable (AtomBandRow
...)`, followed by the 100-error limit. Static comparison of the preserved
old source to the frozen source proves that the sole edit was
`private def AtomBandRow` to `private abbrev AtomBandRow`. Every literal,
predicate, row, and public theorem statement is otherwise byte-identical.
This changes reducibility for instance synthesis, not the proposition.

The preserved successful execution records exit 0 in 9.085562850988936
seconds with empty streams, RSS 3,564,752 KiB, and unchanged guards. Both
historical attempts used AS 8 GiB, CPU 59/60 seconds, wall 60 seconds, streams
256 KiB, one thread and stack 65,536 KiB, as predeclared in the kernel plan.
Their launcher hashes and embedded stream hashes were independently checked
statically here. These are root's source-check records; they are not new
source executions performed by this review. Root also reports separate
focused/full builds (3013/3674 jobs) and a 589-report trust audit. The present
task's only Lean execution is the import probe below.

## Generic subset and real assembly

`maskCandidates_subset_of_and_eq` is universal in natural B, small, large,
with only `small &&& large = small`. For any bounded candidate whose bit in
small is true, applying `testBit` to the equality gives that its bit in large
is true. This proves **small's candidate set is a subset of large's**.
There is no size bound or nonzero premise. At B=0 both candidate sets are
empty, so the same universally quantified theorem remains valid.

The normalized assembly supplies all four hypotheses of
`phase_certificate_sound` about the actual concrete masks:

1. `cutAtomMem_covers_unit_interval` uses n=60,D=360 and the concrete first
   and last cuts. It covers [0,1), including zero and every interior cut by
   singleton atoms. Open intervals exclude their endpoints. The coverage
   proof requires no sorted-cut or uniqueness premise.
2. `phaseBandFacts_sound` uses the proved concrete structure. Singleton bits
   0–19 permit equality at norm 1/6; singleton bits 20–22 require strict
   safety. For open atoms positive slopes turn the certified closed endpoint
   bands into strict interior safety, which is weakened only for the first
   20 candidates. No endpoint is discarded or silently made strict.
3. `renaultPhaseCoreAtoms_masks` rewrites the atom mask at each selected core
   to its fixed core mask. `renaultPhaseDominators_and` and the generic subset
   theorem transfer each selected core bit into the containing atom mask.
   The direction is exactly `mask(core(dom a)) ⊆ mask(a)`.
4. The already reviewed common-core theorem supplies one `Fin 23` candidate
   for three retained indices. It needs only j<=k; the generic interface also
   supplies i<=j, which can be unused. All three memberships are rewritten
   by the core-mask equality. Non-strict ordering includes repeated indices.

The generic phase theorem chooses a **single candidate** and transports it
to all three atom memberships. Its sorting of retained indices only reorders
the membership proof; it does not choose different candidates by phase.

`renault_phase_common_candidate` then takes `Int.fract (x j)` for each j.
These lie in [0,1), for every real input including negative, integer,
irrational, and repeated phases. `phaseGood_fract` transports the same chosen
candidate back for each j. Integer phases are handled at the zero singleton;
the excluded upper endpoint 1 is not a missing case after this normalization.
There is no residual hypothesis on x and no conditional certificate premise.

Finally, `renault_phase_five_one` decodes that one candidate outside the
universal j binder. For c<20 its quotient/remainder give one pair a,b with
2<=a<=5 and 1<=b<=5, satisfying the closed norm bound for all three phases.
Otherwise c is 20,21,or22 and yields one b in {1,2,4}, satisfying the strict
bound for all three. This is exactly the disjunction in the accepted concrete
bridge manuscript, including every quantifier and endpoint. The fully
expanded type is assigned verbatim in the probe below.

The assembly needs neither a proof of class minimality nor semantics for
false bits. The JSON is a provenance source for literal constants, not an
unchecked premise in the resulting Lean theorem. The source chain uses
ordinary kernel proofs and the already reviewed generic real lemmas. Its
exact final result is the Renault 5.1 phase lemma, which is an auxiliary input
to the remaining six-total speed argument, not that runner-count theorem.

## Predeclared fixed import probe

One invocation is authorized and predeclared: `lake env lean -j1 -s65536
--stdin`, with `LEAN_NUM_THREADS=1` and `LEAN_STACK_SIZE_KB=65536`, AS 8 GiB,
CPU soft/hard 59/60 seconds, wall 60 seconds, and 128 KiB per output regular
file. No default-thread attempt, source build, table check, mask search, or
predicate evaluation is part of it. The probe assigns the six full public
theorem types, checks the four literal definitions by `rfl`, and prints the
six axiom dependencies. Static literal and range comparison is distinct from
Lean predicate verification and is repeated by the guarded launcher only as
data-integrity checking.

```lean
import LonelyRunner.RenaultPhaseLemma

open LonelyRunner

example : ∀ (B small large : Nat), small &&& large = small →
    maskCandidates B small ⊆ maskCandidates B large :=
  maskCandidates_subset_of_and_eq

example : PhaseBandFacts renaultPhaseCuts renaultPhaseAtomMasks :=
  renaultPhaseBandFacts

example : ∀ i : Fin 41,
    renaultPhaseAtomMasks (renaultPhaseCoreAtoms i) = renaultPhaseCoreMasks i :=
  renaultPhaseCoreAtoms_masks

example : ∀ a : Fin 120,
    renaultPhaseCoreMasks (renaultPhaseDominators a) &&& renaultPhaseAtomMasks a =
      renaultPhaseCoreMasks (renaultPhaseDominators a) :=
  renaultPhaseDominators_and

example : ∀ x : Fin 3 → ℝ,
    ∃ c : Fin 23, ∀ j, PhaseGood c (x j) :=
  renault_phase_common_candidate

example : ∀ x : Fin 3 → ℝ,
    (∃ a b : ℕ, 2 ≤ a ∧ a ≤ 5 ∧ 1 ≤ b ∧ b ≤ 5 ∧
      ∀ j, (1 : ℝ) / 6 ≤
        circleNorm ((a : ℝ) * x j + (b : ℝ) / 6)) ∨
    (∃ b : ℕ, (b = 1 ∨ b = 2 ∨ b = 4) ∧
      ∀ j, (1 : ℝ) / 6 < circleNorm (x j + (b : ℝ) / 6)) :=
  renault_phase_five_one

example : renaultPhaseCuts =
    (fun i : Nat => [0, 12, 15, 20, 24, 30, 36, 40, 45, 48, 60, 72, 75, 80, 84, 90, 96, 100, 105, 108, 120, 132, 135, 140, 144, 150, 156, 160, 165, 168, 180, 192, 195, 200, 204, 210, 216, 220, 225, 228, 240, 252, 255, 260, 264, 270, 276, 280, 285, 288, 300, 312, 315, 320, 324, 330, 336, 340, 345, 348, 360].getD i 0) := rfl

example : renaultPhaseAtomMasks =
    (![7340031, 7847407, 7847407, 7585263, 7585263, 7577071, 7577071, 7576815, 8101103, 7970031, 7986415, 7982311, 8244455, 8178919, 8179431, 8179303, 8187495, 8185447, 8316519, 8283751, 4159351, 4158259, 4191027, 3666739, 3668787, 3668787, 3668915, 3668883, 3668883, 3406739, 3407771, 3391385, 3915673, 3784601, 3784665, 3784665, 3784665, 3776473, 4038617, 3973081, 4120573, 4083196, 4148732, 4148732, 4156924, 4154876, 4154876, 4154620, 4187388, 3663100, 3667198, 3666174, 3666174, 3404030, 3404542, 3404414, 3406462, 3406462, 3930750, 3799678, 1965951, 6078255, 6209327, 6176559, 6176559, 6168367, 6168495, 6168463, 6233999, 6233999, 6250383, 6246279, 6279047, 5754759, 5754823, 5754823, 5763015, 5760967, 5760967, 5498823, 4978679, 4846067, 5108211, 5042675, 5044723, 5044723, 5044723, 5044467, 5175539, 5142771, 5143803, 5127417, 5192953, 5192953, 5193465, 5193337, 5193337, 5185145, 5217913, 4693625, 4710269, 6541116, 7065404, 6934332, 6942524, 6940476, 6940604, 6940572, 7202716, 7137180, 7141278, 7140254, 7271326, 7238558, 7238622, 7238622, 7240670, 7240670, 7306206, 7306206] : Fin 120 → Nat) := rfl

example : renaultPhaseCoreAtoms =
    (![7, 9, 11, 13, 15, 17, 19, 21, 23, 29, 31, 33, 37, 39, 41, 47, 49, 53, 55, 59, 60, 61, 65, 67, 71, 73, 79, 81, 83, 87, 89, 91, 97, 99, 101, 103, 105, 107, 109, 111, 113] : Fin 41 → Fin 120) := rfl

example : renaultPhaseDominators =
    (![27, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 7, 7, 8, 8, 8, 8, 9, 9, 9, 9, 10, 10, 11, 11, 11, 11, 12, 12, 13, 13, 14, 14, 14, 14, 15, 15, 15, 15, 16, 16, 17, 17, 17, 17, 18, 18, 18, 18, 19, 20, 21, 21, 22, 22, 22, 22, 23, 23, 23, 23, 24, 24, 25, 25, 25, 25, 26, 26, 26, 27, 27, 27, 28, 28, 28, 28, 29, 29, 30, 30, 31, 31, 31, 31, 32, 32, 32, 32, 33, 33, 34, 34, 35, 35, 36, 36, 37, 37, 38, 38, 39, 39, 40, 40, 40, 40, 40, 40, 40] : Fin 120 → Fin 41) := rfl

#print axioms LonelyRunner.maskCandidates_subset_of_and_eq
#print axioms LonelyRunner.renaultPhaseBandFacts
#print axioms LonelyRunner.renaultPhaseCoreAtoms_masks
#print axioms LonelyRunner.renaultPhaseDominators_and
#print axioms LonelyRunner.renault_phase_common_candidate
#print axioms LonelyRunner.renault_phase_five_one
```

The single Bash fence below is the exact guarded replay entrypoint. It imports
existing oleans and captures complete source, output, status, timing, limits,
and guards. It preserves failures without increasing caps. A pre-execution
snapshot of this report is saved alongside the exact stdin and launcher.

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
report = root / 'research/astra-renault-concrete-assembly-source-review.md'
text = report.read_text()
fence = chr(96) * 3
probe = text.split(fence + 'lean\n', 1)[1].split(fence, 1)[0].encode()
launcher = text.split(fence + 'bash\n', 1)[1].split(fence, 1)[0].encode()
out = Path(tempfile.mkdtemp(prefix='astra-renault-assembly-review-'))
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
    'LonelyRunner/FiniteMaskSubset.lean': '8a7dec857dc4a9c4f2b5d4360389e97487163bd69d2d01ed3408b1335f162c3e',
    'LonelyRunner/RenaultPhaseConcreteData.lean': '1d5709da3631bc51d60bb4dbeb94fa2668da5cdbf5a63007e7b4ebd96a5b6c17',
    'LonelyRunner/RenaultPhaseLemma.lean': '1ceac85438299dffdd48d57fb0052b598a9bd5eda995cabff0256885529d89cb',
    '.lake/build/lib/lean/LonelyRunner/FiniteMaskSubset.olean': '8d96f6d4086e6902567a8bdce7400520919e5db15e7e03a64165ba1dc3b7476d',
    '.lake/build/lib/lean/LonelyRunner/RenaultPhaseConcreteData.olean': '16190e2dbd242294572d32ed017b600e640585278ed54c80c9968236c93e8bcc',
    '.lake/build/lib/lean/LonelyRunner/RenaultPhaseLemma.olean': 'b5a78878c8fa760a5eed5d42d0ba5b28c1735a5e8750c5acc258e921d9df4c6f',
    'LonelyRunner/RenaultPhaseMasks.lean': 'fc1360b225d440c99c6dc44067f2bfda2668c9e6984078770c70dc23dc3a4857',
    '.lake/build/lib/lean/LonelyRunner/RenaultPhaseMasks.olean': 'f6d1245ea1ef3b57619ccc1056223969f75628397a1ccbd08459cba3ead72647',
    'research/astra-renault-phase-five-one-certificate.json': 'c1374409d4f6804487179fe9765695a2f0d756ccd2a79b5ee8616e919acbb7b1',
    'research/astra-renault-concrete-data-kernel-plan.md': '801a0b22658489a041b6577a746eb48ff13667c07b1333fff8cd02f4e1cd42fd',
    'research/astra-renault-concrete-data-kernel-execution.json': 'cd4a3533af1780fb5d9ac6d6077c056e14319a41c62e1b372f758139020224b4',
    'research/astra-renault-concrete-data-kernel-history.json': 'd74996dc0c5597939fe966e19f6c138830e47f24e1c61bc362da0a5351282aee',
}
argv = ['lake', 'env', 'lean', '-j1', '-s65536', '--stdin']
limits = {'address_space_bytes': 8 * 1024**3, 'cpu_seconds': [59, 60],
          'wall_seconds': 60, 'stream_bytes': 128 * 1024}
receipt = {'argv': argv, 'limits': limits, 'guards': guards,
           'exit': None, 'timed_out': False, 'error': None,
           'guards_before': False, 'guards_after': False,
           'static_data': False, 'probe_expected_sha256': '6ce0561b7a61ee4f7fd6d1840f8e3dbb1d26346a44eee7c4ac76cceedbb21dfa'}
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
    source = (root / 'LonelyRunner/RenaultPhaseConcreteData.lean').read_text()
    def literals(name):
        match = re.search(r'def ' + name + r'[^\n]*\n\s*!?\[(.*?)\]', source, re.S)
        assert match, name
        return [int(z.strip()) for z in match.group(1).split(',')]
    data = {
        'cuts': literals('renaultPhaseCuts'),
        'masks': literals('renaultPhaseAtomMasks'),
        'cores': literals('renaultPhaseCoreAtoms'),
        'dom': literals('renaultPhaseDominators'),
    }
    assert data['cuts'] == cert['cuts'] and len(data['cuts']) == 61
    assert data['masks'] == cert['masks'] and len(data['masks']) == 120
    assert data['cores'] == [cert['class_reps'][i] for i in cert['minimal_classes']]
    assert len(data['cores']) == 41 and all(0 <= x < 120 for x in data['cores'])
    assert data['dom'] == cert['dom'] and len(data['dom']) == 120
    assert all(0 <= x < 41 for x in data['dom'])
    receipt['literal_sha256'] = {name: sha(json.dumps(v, separators=(',', ':')).encode())
                                  for name, v in data.items()}
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
    for name in ['stdin.bin', 'stdout.bin', 'stderr.bin', 'launcher.sh', 'predeclared-report.md']:
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

## Actual independent import result

The first and only invocation passed unchanged, with both child and launcher
exit 0. The six full public-type assignments and four literal `rfl` checks
all elaborated. The static data comparisons passed. All 30 guards matched
before and after; no timeout, stream-cap hit, diagnostic, stderr, default-thread
launch, or cap escalation occurred. This task did not reexecute any band-row,
core-intersection, or domination decision proof.

Measured wall time was 1.9265523420181125 seconds. Child user/system CPU
were 1.298137 and 0.5907439999999999 seconds, with maximum RSS 3,294,164 KiB.
The retained directory is `/tmp/astra-renault-assembly-review-bm7b7gd1`.
These measurements belong to the import check, separately from root's source
build and table-check records.

| Retained file | Bytes | SHA-256 |
| --- | ---: | --- |
| `stdin.bin` | 3680 | `6ce0561b7a61ee4f7fd6d1840f8e3dbb1d26346a44eee7c4ac76cceedbb21dfa` |
| `stdout.bin` | 547 | `cfb32ed67fce740189748c5bf208958341f803aabf3f4694acb3c0f12222bd54` |
| `stderr.bin` | 0 | `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855` |
| `launcher.sh` | 9513 | `9f43f3089a2d0b277af2f9bcabaec987df3e897a26d2868d16e8e77885cb4f24` |
| `predeclared-report.md` | 23182 | `4c0676f4bb731f030a63de59278e53fd37d87ef7da7c0ac5f4a6603ebe6a91e0` |
| `receipt.json` | 5346 | `0ee1d6c6dec6deb50d3130b698632b85ded42f33cbbbebf1f16f51341efac73f` |

Complete actual Lean stdout follows; stderr is the empty byte string.

```text
'LonelyRunner.maskCandidates_subset_of_and_eq' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.renaultPhaseBandFacts' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.renaultPhaseCoreAtoms_masks' depends on axioms: [propext]
'LonelyRunner.renaultPhaseDominators_and' depends on axioms: [propext]
'LonelyRunner.renault_phase_common_candidate' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.renault_phase_five_one' depends on axioms: [propext, Classical.choice, Quot.sound]
```

The two finite link equalities depend only on `propext`; the subset theorem,
concrete band facts, and both final phase theorems use only `propext`,
`Classical.choice`, and `Quot.sound`. All six are inside the project's allowed
axiom set. This is actual axiom output, not an expected transcript.

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
  "child_max_rss_kib": 3294164,
  "child_system_seconds": 0.5907439999999999,
  "child_user_seconds": 1.298137,
  "error": null,
  "exit": 0,
  "files": {
    "launcher.sh": {
      "bytes": 9513,
      "sha256": "9f43f3089a2d0b277af2f9bcabaec987df3e897a26d2868d16e8e77885cb4f24"
    },
    "predeclared-report.md": {
      "bytes": 23182,
      "sha256": "4c0676f4bb731f030a63de59278e53fd37d87ef7da7c0ac5f4a6603ebe6a91e0"
    },
    "stderr.bin": {
      "bytes": 0,
      "sha256": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
    },
    "stdin.bin": {
      "bytes": 3680,
      "sha256": "6ce0561b7a61ee4f7fd6d1840f8e3dbb1d26346a44eee7c4ac76cceedbb21dfa"
    },
    "stdout.bin": {
      "bytes": 547,
      "sha256": "cfb32ed67fce740189748c5bf208958341f803aabf3f4694acb3c0f12222bd54"
    }
  },
  "guards": {
    ".lake/build/lib/lean/LonelyRunner/FiniteCutCover.olean": "e135595b4c42102e9e2736492c39fc95914e1d09800615c3d943553abedc1ade",
    ".lake/build/lib/lean/LonelyRunner/FiniteMaskCertificates.olean": "f0ca24c85fa4ecef7643feec5c77d277fcbf62c312a65eb081a5161c6005cfb6",
    ".lake/build/lib/lean/LonelyRunner/FiniteMaskSubset.olean": "8d96f6d4086e6902567a8bdce7400520919e5db15e7e03a64165ba1dc3b7476d",
    ".lake/build/lib/lean/LonelyRunner/RealPhaseBands.olean": "7442f9f49d9f1e2d214460557f6a891ba13717ededff679876033793ac2c6504",
    ".lake/build/lib/lean/LonelyRunner/RenaultPhaseBandFacts.olean": "d1bae95cbd3ccfde10a90f58fe650d81cd4d6120bb815c4d9558c08b09d34a77",
    ".lake/build/lib/lean/LonelyRunner/RenaultPhaseBandSoundness.olean": "4867093c71b4b6e5d29dfc3255b426159f367aafccd5393543d9487fb40e1e4f",
    ".lake/build/lib/lean/LonelyRunner/RenaultPhaseCertificates.olean": "9ec36c868453c9889f616f0f4dd5d0a4d3a5d477fa09b07da786b3164b38e666",
    ".lake/build/lib/lean/LonelyRunner/RenaultPhaseConcreteData.olean": "16190e2dbd242294572d32ed017b600e640585278ed54c80c9968236c93e8bcc",
    ".lake/build/lib/lean/LonelyRunner/RenaultPhaseLemma.olean": "b5a78878c8fa760a5eed5d42d0ba5b28c1735a5e8750c5acc258e921d9df4c6f",
    ".lake/build/lib/lean/LonelyRunner/RenaultPhaseMasks.olean": "f6d1245ea1ef3b57619ccc1056223969f75628397a1ccbd08459cba3ead72647",
    "LonelyRunner/FastRunnerInsertion.lean": "dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5",
    "LonelyRunner/FiniteCutCover.lean": "b7e7e50834bc86d13ffde759e3d0c2dc4d2480a03ec61eb88a70ca215fcc1011",
    "LonelyRunner/FiniteMaskCertificates.lean": "72629bc0780161890a31dd705b744c7ce2a77c884a915d7eaf4b3d69855b181e",
    "LonelyRunner/FiniteMaskSubset.lean": "8a7dec857dc4a9c4f2b5d4360389e97487163bd69d2d01ed3408b1335f162c3e",
    "LonelyRunner/RealPhaseBands.lean": "7f70467bad6bb5a8a859bff8947af1dc73e685910b69157b49bab259b3c02ca0",
    "LonelyRunner/RenaultPhaseBandFacts.lean": "c775da2dfb8d3c6ff24f6d66c49d7b690f3422cc7dc95b410c064cc08c78d721",
    "LonelyRunner/RenaultPhaseBandSoundness.lean": "b7773a0755413e03371c2322d221bfda68cf1174bcbfac694e61a4803189ccf7",
    "LonelyRunner/RenaultPhaseCertificates.lean": "36b58c04e0c755d462f32bae3388c30d744d97ccb20a3bc27aa0daa99b7e49f0",
    "LonelyRunner/RenaultPhaseConcreteData.lean": "1d5709da3631bc51d60bb4dbeb94fa2668da5cdbf5a63007e7b4ebd96a5b6c17",
    "LonelyRunner/RenaultPhaseLemma.lean": "1ceac85438299dffdd48d57fb0052b598a9bd5eda995cabff0256885529d89cb",
    "LonelyRunner/RenaultPhaseMasks.lean": "fc1360b225d440c99c6dc44067f2bfda2668c9e6984078770c70dc23dc3a4857",
    "LonelyRunner/StructuredClasses.lean": "5328a7a88d2b42f86ffc3f0f0418ca22c761219e8fa3e5822bda5a18ac286e8c",
    "lake-manifest.json": "887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218",
    "lakefile.toml": "bdcbaaa18d518409619215e8acf7892452c1fa5c6e80ba742ce67f7380682a26",
    "lean-toolchain": "8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af",
    "research/astra-renault-concrete-data-kernel-execution.json": "cd4a3533af1780fb5d9ac6d6077c056e14319a41c62e1b372f758139020224b4",
    "research/astra-renault-concrete-data-kernel-history.json": "d74996dc0c5597939fe966e19f6c138830e47f24e1c61bc362da0a5351282aee",
    "research/astra-renault-concrete-data-kernel-plan.md": "801a0b22658489a041b6577a746eb48ff13667c07b1333fff8cd02f4e1cd42fd",
    "research/astra-renault-phase-concrete-bridge-plan.md": "ec29e6cba74dd87a9db823e712fba099d47d6277bf52b2d227ce2d633e0dca60",
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
    "stream_bytes": 131072,
    "wall_seconds": 60
  },
  "literal_sha256": {
    "cores": "9243ace4d3027ac51361aeb5751edd40fc73527e29a37f4db50a6e2e8d21a8ed",
    "cuts": "2c6cfd6f93fe9b41f5f744cf4c621bf198e563405039e85fa40f9bb8c63a9981",
    "dom": "62e6588fc86a000dc1e10cf111ca6d59982da7dcea275242fd879c767af834b8",
    "masks": "366c03c646faa0920574356e1e5cabed4a5d29bc3e311d4a29bc56469f77976c"
  },
  "passed": true,
  "probe_expected_sha256": "6ce0561b7a61ee4f7fd6d1840f8e3dbb1d26346a44eee7c4ac76cceedbb21dfa",
  "static_data": true,
  "stream_cap_hit": false,
  "timed_out": false,
  "wall_seconds": 1.9265523420181125
}
```

The sole Bash fence remains the exact executed entrypoint, SHA-256
`9f43f3089a2d0b277af2f9bcabaec987df3e897a26d2868d16e8e77885cb4f24`.
The fixed Lean fence is the exact stdin, SHA-256
`6ce0561b7a61ee4f7fd6d1840f8e3dbb1d26346a44eee7c4ac76cceedbb21dfa`.
Both were declared to root before execution. Root can read this report and
replay that entrypoint as supplied; a new run preserves its own directory,
report snapshot, and receipt. Timing/RSS and receipt/snapshot hashes vary by
run, while the frozen inputs, fixed probe and literal-list hashes, and axiom
stdout are the comparison targets. No runtime-model provenance is inferred
from a passing probe.

## Final disposition and remaining work

Accept the exact local declarations `renault_phase_common_candidate` and
`renault_phase_five_one`, together with their three concrete facts and generic
subset adapter. The final quantifiers range over every `Fin 3 → Real`; one
shared candidate works for all three phases, with precisely the manuscript's
closed slope-two-through-five alternative or strict slope-one alternative.
The finite data and the previously reviewed generic real bridge are connected
by kernel declarations rather than external certificate metadata.

This review requests no source changes. The permitted work wrote only the
owned report and temporary captured evidence; no Lean source, root import,
audit, Git, publication, state, or cache was changed. The separate remaining
six-total speed/divisibility arguments, Renault's later phase inputs where
needed, and H7/H8 assembly are not proved by this phase lemma alone. No new
canonical runner-count theorem or unrestricted LRC resolution is claimed.
