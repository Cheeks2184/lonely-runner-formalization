# Signed Renault choices and small rational orbits: independent source review

**Semantic decision: accept all four exact public contracts.** The signed
choices retain one common candidate and every strict/closed boundary. The
orbit proof retains its full composite-denominator scope and prescribed phase,
without inserting A>0 or gcd(A,q)=1. Execution evidence is separate below.
I reviewed the underlying one-three-divisible manuscript but authored neither
source nor the separate small-orbit implementation plan.

Only this report is owned. The current config, workflow, policy and focused
state were read; this task is recorded at checkpoint `5b85444`, requested
Astra/xhigh, observed runtime metadata unavailable, research/in_progress.
`python3 scripts/validate_workflow.py` actually exited 0 with
`workflow structural validation passed; it cannot certify mathematical validity.`
The updated rules retain Terra High's focused compilation and at most two
repair rounds. Root inspects complete successful receipts without duplicating
the same probe; full integration/trust and independent semantic review remain.
The priority is verified canonical N=6, followed by uniform arbitrary-N work.

| Frozen source | SHA-256 |
| --- | --- |
| `LonelyRunner/SignedRenaultFiveOne.lean` | `6971e02483c2b1e6f3d717ed5d4784fd8decfbdba6f6bdc9d8aca0dff2f4f3fc` |
| `LonelyRunner/SmallPhaseOrbits.lean` | `033d7c9f84e924ab7f66ad0f37cfddf7b22c395a596d7fef57b273b2459a0e97` |

The settled small-orbit plan is
`research/astra-small-phase-orbit-contract-plan.md`, SHA
`c8f8ff1f59e8dbe5859075ab7054f7a78d2e1bf939ce433daaf473a368c2bbca`.
The original one-three manuscript and its independent review are also literal
guards below (9da23060... and 8f720fbd...). All four public types appear fully
expanded in the fixed probe; there are no abstract predicates hiding their scope.

## Source reasoning

**Signed unit-weight choices.** The unsigned checked `renault_phase_five_one`
is applied once to the triple j↦e(j)*x(j). It supplies common naturals a,b in
the closed alternative (2≤a≤5, 1≤b≤5), or one common b∈{1,2,4} in the strict
alternative. For each label, e=1 leaves its norm unchanged; e=-1 gives
`a*(-x)+b/6 = -(a*x-b/6)`, or the same identity with a=1. Circle-norm negation
removes this orientation. The proof rewrites e(j) by its equality rather than
trying to substitute a function application. No new witness is chosen within
the per-label proof, and both thresholds are transported by exact equalities.
Arbitrary negative real phases, equal phase values and independent signs at
all three labels are included. The signs are restricted to ±1; this public
result is not a claim about arbitrary integer weights.

**Reflected choices.** The private helper proves for every real y, integer e
and natural b≤6 that
`N(y-e*b/6)=N(y+e*(6-b)/6)`: the left phase is the right phase minus the integer
e. `Nat.cast_sub hb` is justified by the actual b≤6, preventing truncated
natural subtraction from being mistaken for signed subtraction. This identity
needs no e=±1 hypothesis; only its use of the previous public result does.

The reflected theorem applies the signed theorem with signs -e, then changes
b to 6-b in *both* alternatives. In the closed branch 1≤b≤5 implies
1≤6-b≤5, while the same a and every label's closed bound are preserved.
In the strict branch the exact images are 1↦5, 2↦4, 4↦2, giving precisely
{2,4,5}, with strict inequalities unchanged. No phase reflection, per-label
choice of shift, extra assumption or boundary relaxation is hidden. The earlier
failed draft's direct reuse of the closed -e branch would not typecheck; the
final source repairs the mathematical transport as well as elaboration.

The complete unsigned dependency `RenaultPhaseLemma.lean` was read. Its
arbitrary-real wrapper first uses fract for each phase and the proved PhaseGood
periodicity. Its one Fin 23 candidate then decodes either to the closed
2..5/1..5 branch or to strict shifts 1,2,4. Thus the signed proof is importing
the required three-phase theorem, not assuming independent choices or an
unproved six-runner result. The earlier finite-certificate proof is not rerun.

**Exact residue helper.** `exists_nat_coprime_grid_fract_eq` uses the inspected
`Nat.exists_mul_mod_eq_of_coprime` to obtain a natural k<n with
c*k mod n = m mod n. Its library proof handles modulus one explicitly and
otherwise uses a Bézout-derived inverse. Commutativity changes c*k to k*c;
m<n makes m mod n=m. The inspected
`Int.fract_div_natCast_eq_div_natCast_mod` then gives exactly
`fract(k*c/n)=m/n`, after the real cast of the natural product.
All divisions in this equality are real; the modular numerator is natural.

There is no positive-coefficient, prime-modulus, or coprime-target-residue
hypothesis. In particular n=1 is allowed, then m=0 and k=0; c may also be 0
when compatible with coprimality. The modulus remains positive, as required
for the natural-index selection. These are consequences of the symbolic proof,
not executed numeric fixtures.

**Small orbit wrapper.** Set g=gcd(q,A), n=q/g and c=A/g in naturals. From q>0,
g>0; exact divisibility gives q=g*n and A=g*c. Hence n>0 and n≤q. If n=1,
q=g divides A, contradicting hnot, so n>1. The gcd quotient theorem, with its
symmetry in the correct order, supplies coprime(c,n). The factorization gives
n∣q, so coprime(q,6) implies coprime(n,6). In particular neither 2 nor 3 divides
n; together with n>1 this gives n=5 or n≥7. This exclusion does not assume q
or n is prime and does not regard arbitrary nonzero residues as units.

For n=5, the exact helper selects target m=1. For n≥7, the private bound sets
m=(n+11)/12 using *natural* division. With r=(n+11)%12, the checked remainder
identity is r+12*m=n+11 and 0≤r≤11. Thus n≤12*m≤n+11 and m>0.
If 7≤n<12, the source obtains m=1, hence 6*m≤n. Otherwise n≥12 implies
12*m≤n+11≤2*n, again 6*m≤n. Positivity and that last bound give m<n.
The proof uses symbolic constant-coefficient natural arithmetic, not a table
of denominators. It applies the exact helper to this same m and same reduced
coefficient c.

The real ratio identity A/q=c/n follows by cancelling nonzero g after casting
both natural factorizations. Multiplication by the chosen k and Int.fract
transport the helper back to the original ratio exactly. In the large branch,
positive denominators turn n≤12*m and 6*m≤n into the two *closed* bounds
1/12≤m/n≤1/6; in the fifth branch the result is exactly 1/5. The natural bound
k<n≤q returns the required strict k<q in both branches. The proof explicitly
normalizes the cast of 5 before composing fractional-part equalities.

A may be arbitrary natural in the public signature; hnot already rules out
A=0 and q=1 in this wrapper. There is no assumption gcd(A,q)=1, no supplied
reduced orbit, no loss at either closed endpoint, and no positive-time assertion.
The helper and wrapper match the accepted plan exactly. The imported
RationalShiftGcd proof and decisive pinned library API proofs were read; neither
new orbit declaration uses a large-norm orbit as a substitute for a prescribed
small *fractional part*. The private natural bound is included in this review.

## Build provenance and bounded verification

Root's pass55 record was read at snapshot SHA
`2f7bff4284f460f17d39431fbc913da4358c339869e2ff59bbdf6bc77051f6d7`.
It retains the failed signed draft/log and the corrected exit-0 build (3014
jobs). The same historical Medium worker made the repairs; root supplied the
closed-branch correction requirement and did not edit that source. The fresh
Terra High orbit delivery records initial failure and two worker repair rounds,
then exit 0 (3002 jobs), with no root source changes. Its precheck source
snapshots were not retained; they are not reconstructed or claimed available.
The mutable orbit receipt is being normalized to original raw logs by its owner
and is not a replay guard or a substitute for this review's actual fixed probe.
No earlier source check is rerun here.

The single predeclared import-only probe below checks all four universal types
and prints all four full axiom closures. It uses the two direct imports only,
with no numerical evaluation, mathematical search, source build or retries.
Limits: AS 8 GiB; CPU 59/60 seconds; wall 60 seconds; stdout and stderr each
128 KiB as regular files; no core dumps; process-group kill on timeout.
The exact command is `lake env lean -j1 -s65536 --stdin`, with environment
LEAN_NUM_THREADS=1 and LEAN_STACK_SIZE_KB=65536. No formatting options are added.

The guard dictionary binds both target source/artifact pairs, immediate project
imports, decisive mathlib and Init API source/artifact pairs, toolchain/manifest/
lakefile pins, both resolved runtime binaries and all three accepted manuscripts.
Mutable root imports, AxiomAudit, state and build receipts are excluded. Guards
run before/after; the entire report must remain unchanged during execution.
The controller snapshots the full report and hashes its pre-evidence prefix,
so appending the actual receipt cannot silently change the proof or probe.
For compactness the receipt hashes the canonical literal guard manifest rather
than repeating its entire dictionary. It accepts only the four named full axiom
reports in order, using propext, Classical.choice and Quot.sound, with empty
stderr and no other output. Failures and complete actual streams are preserved.
Root inspects this bound receipt without an identical replay unless a specific
concern, changed input or missing evidence warrants another check.

Probe bytes: 1817

Probe SHA-256: `41b138a970d45be94538d26267d48f3ad390317974b9bd5e58d29e806251fd88`

Launcher bytes: 10583

Launcher SHA-256: `6bfa4e440cc45684705ffba213ff8784db725fbd55ca5e58211c9dc71950572c`

```lean
import LonelyRunner.SignedRenaultFiveOne
import LonelyRunner.SmallPhaseOrbits

open LonelyRunner

example : ∀ (x : Fin 3 → ℝ) (e : Fin 3 → ℤ),
    (∀ j, e j = 1 ∨ e j = -1) →
    (∃ a b : ℕ, 2 ≤ a ∧ a ≤ 5 ∧ 1 ≤ b ∧ b ≤ 5 ∧ ∀ j,
      (1 : ℝ) / 6 ≤ circleNorm ((a : ℝ) * x j + (e j : ℝ) * (b : ℝ) / 6)) ∨
    (∃ b : ℕ, (b = 1 ∨ b = 2 ∨ b = 4) ∧ ∀ j,
      (1 : ℝ) / 6 < circleNorm (x j + (e j : ℝ) * (b : ℝ) / 6)) :=
  LonelyRunner.renault_phase_five_one_signed

example : ∀ (x : Fin 3 → ℝ) (e : Fin 3 → ℤ),
    (∀ j, e j = 1 ∨ e j = -1) →
    (∃ a b : ℕ, 2 ≤ a ∧ a ≤ 5 ∧ 1 ≤ b ∧ b ≤ 5 ∧ ∀ j,
      (1 : ℝ) / 6 ≤ circleNorm ((a : ℝ) * x j + (e j : ℝ) * (b : ℝ) / 6)) ∨
    (∃ b : ℕ, (b = 2 ∨ b = 4 ∨ b = 5) ∧ ∀ j,
      (1 : ℝ) / 6 < circleNorm (x j + (e j : ℝ) * (b : ℝ) / 6)) :=
  LonelyRunner.renault_phase_five_one_signed_reflected

example : ∀ c n m : ℕ, 0 < n → Nat.Coprime c n → m < n →
    ∃ k : ℕ, k < n ∧
      Int.fract ((k : ℝ) * (c : ℝ) / (n : ℝ)) = (m : ℝ) / (n : ℝ) :=
  LonelyRunner.exists_nat_coprime_grid_fract_eq

example : ∀ A q : ℕ, 0 < q → Nat.Coprime q 6 → (¬ q ∣ A) →
    ∃ k : ℕ, k < q ∧
      (((1 : ℝ) / 12 ≤ Int.fract ((k : ℝ) * (A : ℝ) / (q : ℝ)) ∧
        Int.fract ((k : ℝ) * (A : ℝ) / (q : ℝ)) ≤ (1 : ℝ) / 6) ∨
       Int.fract ((k : ℝ) * (A : ℝ) / (q : ℝ)) = (1 : ℝ) / 5) :=
  LonelyRunner.exists_reciprocal_time_small_phase

#print axioms LonelyRunner.renault_phase_five_one_signed
#print axioms LonelyRunner.renault_phase_five_one_signed_reflected
#print axioms LonelyRunner.exists_nat_coprime_grid_fract_eq
#print axioms LonelyRunner.exists_reciprocal_time_small_phase
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
report = root / 'research/astra-signed-small-orbit-source-review.md'
text = report.read_text()
marker = '\n<!-- ACTUAL EVIDENCE -->\n'
assert text.count(marker) == 1
prefix = text.split(marker, 1)[0].encode()
fence = chr(96) * 3
probe = text.split(fence + 'lean\n', 1)[1].split(fence, 1)[0].encode()
launcher = text.split(fence + 'bash\n', 1)[1].split(fence, 1)[0].encode()
out = Path(tempfile.mkdtemp(prefix='astra-signed-small-orbit-review-'))
(out / 'stdin.bin').write_bytes(probe)
(out / 'launcher.sh').write_bytes(launcher)
(out / 'report-snapshot.md').write_bytes(text.encode())
guards = {
    'LonelyRunner/SignedRenaultFiveOne.lean': '6971e02483c2b1e6f3d717ed5d4784fd8decfbdba6f6bdc9d8aca0dff2f4f3fc',
    '.lake/build/lib/lean/LonelyRunner/SignedRenaultFiveOne.olean': '368d25f93e3f7e339a157e1e13bc0bec91027993c25c146905b3bc7a9edd1bfa',
    'LonelyRunner/SmallPhaseOrbits.lean': '033d7c9f84e924ab7f66ad0f37cfddf7b22c395a596d7fef57b273b2459a0e97',
    '.lake/build/lib/lean/LonelyRunner/SmallPhaseOrbits.olean': '1d1206725e6fd4f95d6d17762efd18f2a0de332bf8212ae86371757455e10adb',
    'LonelyRunner/RenaultPhaseLemma.lean': '1ceac85438299dffdd48d57fb0052b598a9bd5eda995cabff0256885529d89cb',
    '.lake/build/lib/lean/LonelyRunner/RenaultPhaseLemma.olean': 'b5a78878c8fa760a5eed5d42d0ba5b28c1735a5e8750c5acc258e921d9df4c6f',
    'LonelyRunner/RationalShiftGcd.lean': '6e9d1e3e084188a651e4c875cf36fd5d6fc7cbd5f1914784019a207a0cec01f4',
    '.lake/build/lib/lean/LonelyRunner/RationalShiftGcd.olean': '925dfab54e1f29d8e5e7bc80272c9d933502bbcb593b1413da6f600dc75dd2de',
    '.lake/packages/mathlib/Mathlib/Tactic.lean': 'c6f2c548596b635a3d5c8aff8b19cbdeb60dd54e41bb89a1cd03b1a54d335fa5',
    '.lake/packages/mathlib/.lake/build/lib/lean/Mathlib/Tactic.olean': '0534ef12e7aaf8ffbb6e520a91f922da4469d0dca2b54c87b4458e1faa28a6a2',
    '.lake/packages/mathlib/Mathlib/Data/Int/GCD.lean': '13cf17d1beed6c6a24bd471065f461a2449f6eb55101ff5a6e6828d7be28b568',
    '.lake/packages/mathlib/.lake/build/lib/lean/Mathlib/Data/Int/GCD.olean': 'c2443c093e355d780bafae04f7a06276a5995565ea5b3abf6e17ab93db27b197',
    '.lake/packages/mathlib/Mathlib/Algebra/Order/Floor/Ring.lean': '11f61aaf83c406b6b0accc6d34bdb4f77a1566fbdc63eae4d704728b9acf038c',
    '.lake/packages/mathlib/.lake/build/lib/lean/Mathlib/Algebra/Order/Floor/Ring.olean': '7321187722159060ef5bba522dcb0fa44c87cd3b6933c2cedfd27f63b35a9080',
    '.lake/packages/mathlib/Mathlib/Data/Nat/GCD/Basic.lean': 'c46b9173200adac93cefa0f8d9ee02306930771a1960796335c32455f719c3ac',
    '.lake/packages/mathlib/.lake/build/lib/lean/Mathlib/Data/Nat/GCD/Basic.olean': 'ede191f5f23004fe8fea67a5e2b8b26ab341b2a1e9ffdf04bdb5194f52b7de1e',
    '/home/joshua/.elan/toolchains/leanprover--lean4---v4.32.1/src/lean/Init/Data/Nat/Coprime.lean': '05b67b9e50bb0b92ba80dc4a8074580c14a8bdcdbdc150486f4796d104c8426a',
    '/home/joshua/.elan/toolchains/leanprover--lean4---v4.32.1/lib/lean/Init/Data/Nat/Coprime.olean': 'dbbad1362c2b6039332959b61c1a8ad8217aa138ffeb288a8617b486b800117a',
    'lean-toolchain': '8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af',
    'lakefile.toml': 'bdcbaaa18d518409619215e8acf7892452c1fa5c6e80ba742ce67f7380682a26',
    'lake-manifest.json': '887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218',
    '/home/joshua/.elan/toolchains/leanprover--lean4---v4.32.1/bin/lean': 'e8baaa71855a616dc351028f3ad2200051b0671f423a1696a100e809302d5550',
    '/home/joshua/.elan/toolchains/leanprover--lean4---v4.32.1/bin/lake': '60330ab6f07dce20f3fa9ebb08e8b984ea9549eac172afeb15d9d2227060e2b3',
    'research/astra-small-phase-orbit-contract-plan.md': 'c8f8ff1f59e8dbe5859075ab7054f7a78d2e1bf939ce433daaf473a368c2bbca',
    'research/astra-one-three-divisible-plan.md': '9da230600af3a0a0bc8223de3daca2575f8d41f447142687ca64db53ced4ae9e',
    'research/astra-one-three-divisible-review.md': '8f720fbd8002918adaaa0d36fc7774c450eeb5dba84dd555552d24b5e57e6078',
}
argv = ['lake', 'env', 'lean', '-j1', '-s65536', '--stdin']
limits = {'address_space_bytes': 8 * 1024**3, 'cpu_seconds': [59, 60],
          'wall_seconds': 60, 'stream_bytes': 128 * 1024}
symbols = ['LonelyRunner.renault_phase_five_one_signed', 'LonelyRunner.renault_phase_five_one_signed_reflected', 'LonelyRunner.exists_nat_coprime_grid_fract_eq', 'LonelyRunner.exists_reciprocal_time_small_phase']
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

## Complete actual evidence

The single authorized import-only probe passed: Lean and the exact Bash entry
both exited 0; all four full universal assignments checked, and each complete
axiom list is exactly propext, Classical.choice, Quot.sound. All 26 guards and
both predeclarations matched before and after. No errors, warnings, timeout,
cap hit, retry, mathematical fixture or additional Lean invocation occurred.

The inner receipt SHA is
`134bbfe9aa7a6d6867a951792da5202d3bf97170d3997da14e7b79d57ec3a4b6`.
Raw Lean stdout is 434 bytes, SHA
`deba14df613652e4242294202933187584dbbd73c923f964a28e86cc6dd278b4`;
stderr is empty. Original stdin, launcher, report snapshot, receipt and streams
remain in `/tmp/astra-signed-small-orbit-review-5xalwwip`. Peak child RSS was
3,287,612 KiB; inner elapsed time was 1.873460956994677 seconds. Complete CPU,
bounds and other original measurements appear in the receipt, without rounding.

The outer capture used `subprocess.Popen(['bash', '-c', program.decode()])` on
the exact frozen Bash bytes, regular stdout/stderr files, the same AS/CPU/file/
core bounds and a 65-second outer watchdog around the inner 60-second limit.
It is one invocation of that entry, not another probe. Its files remain in
`/tmp/astra-signed-small-orbit-entry-0us23pc9`. Its full original receipt follows,
SHA `415d20cc009ff2b126fbdc8ad5b972814211f8d7b66699eb977f5fd4541ba8c9`.
The complete Bash stdout following that receipt contains the complete inner
receipt and every raw Lean stdout/stderr byte, with exact delimiters. Outer
stderr is the empty byte string. No output is elided or reconstructed.

The pre-run full report SHA was
`7667c78b960e4bbb4357a1fc7be8e280c429c384446d92bcf30cb195781bfc1b`.
The pre-evidence prefix SHA is
`60c8146614aee25208711b34722e416b1a7d6798ce2224ba1abe90a48b91b50d`
before/after execution and after this append. Exact probe and Bash bytes remain
unchanged; the guard-manifest hash was independently recomputed from the literal
dictionary in the frozen launcher during final static receipt inspection.

```json
{
  "exit": 0,
  "files": {
    "entry.sh": {
      "bytes": 10583,
      "sha256": "6bfa4e440cc45684705ffba213ff8784db725fbd55ca5e58211c9dc71950572c"
    },
    "stderr.bin": {
      "bytes": 0,
      "sha256": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
    },
    "stdout.bin": {
      "bytes": 3067,
      "sha256": "d4418110abc1c6db95c273979c50523f754f7841384508abaf40ee00ee3786c9"
    }
  },
  "kind": "one exact fenced Bash invocation; outer capture only",
  "launcher_sha256": "6bfa4e440cc45684705ffba213ff8784db725fbd55ca5e58211c9dc71950572c",
  "timed_out": false,
  "wall_seconds": 1.9184137280099094
}
```

```text
EVIDENCE_DIR /tmp/astra-signed-small-orbit-review-5xalwwip
RECEIPT_SHA256 134bbfe9aa7a6d6867a951792da5202d3bf97170d3997da14e7b79d57ec3a4b6
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
    "LonelyRunner.exists_nat_coprime_grid_fract_eq": [
      "propext",
      "Classical.choice",
      "Quot.sound"
    ],
    "LonelyRunner.exists_reciprocal_time_small_phase": [
      "propext",
      "Classical.choice",
      "Quot.sound"
    ],
    "LonelyRunner.renault_phase_five_one_signed": [
      "propext",
      "Classical.choice",
      "Quot.sound"
    ],
    "LonelyRunner.renault_phase_five_one_signed_reflected": [
      "propext",
      "Classical.choice",
      "Quot.sound"
    ]
  },
  "child_max_rss_kib": 3287612,
  "child_system_seconds": 0.5700839999999999,
  "child_user_seconds": 1.263685,
  "environment": {
    "LEAN_NUM_THREADS": "1",
    "LEAN_STACK_SIZE_KB": "65536"
  },
  "error": null,
  "exit": 0,
  "files": {
    "launcher.sh": {
      "bytes": 10583,
      "sha256": "6bfa4e440cc45684705ffba213ff8784db725fbd55ca5e58211c9dc71950572c"
    },
    "report-snapshot.md": {
      "bytes": 22331,
      "sha256": "7667c78b960e4bbb4357a1fc7be8e280c429c384446d92bcf30cb195781bfc1b"
    },
    "stderr.bin": {
      "bytes": 0,
      "sha256": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
    },
    "stdin.bin": {
      "bytes": 1817,
      "sha256": "41b138a970d45be94538d26267d48f3ad390317974b9bd5e58d29e806251fd88"
    },
    "stdout.bin": {
      "bytes": 434,
      "sha256": "deba14df613652e4242294202933187584dbbd73c923f964a28e86cc6dd278b4"
    }
  },
  "guard_count": 26,
  "guard_manifest_sha256": "0343bd1469d9570e055240918b46c98471f2b9bee40e9e3c726bc49f4107d851",
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
  "report_prefix_after_sha256": "60c8146614aee25208711b34722e416b1a7d6798ce2224ba1abe90a48b91b50d",
  "report_prefix_before_sha256": "60c8146614aee25208711b34722e416b1a7d6798ce2224ba1abe90a48b91b50d",
  "report_unchanged_during_run": true,
  "resolved_executables": {
    "lake": "/home/joshua/.elan/toolchains/leanprover--lean4---v4.32.1/bin/lake",
    "lean": "/home/joshua/.elan/toolchains/leanprover--lean4---v4.32.1/bin/lean"
  },
  "stream_cap_hit": false,
  "timed_out": false,
  "wall_seconds": 1.873460956994677
}
STDOUT-BEGIN
'LonelyRunner.renault_phase_five_one_signed' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.renault_phase_five_one_signed_reflected' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.exists_nat_coprime_grid_fract_eq' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.exists_reciprocal_time_small_phase' depends on axioms: [propext, Classical.choice, Quot.sound]
STDOUT-END
STDERR-BEGIN
STDERR-END
```

Final disposition: **accept all four frozen source contracts and this successful
bounded exact-type/axiom check**. Root's receipt inspection and the source
checkpoint's integrated build/trust remain distinct obligations. These helper
results do not establish the remaining one-three-divisible branch, canonical
N=6, or unrestricted LRC. No source/state/Git/import/cache edits were made.
