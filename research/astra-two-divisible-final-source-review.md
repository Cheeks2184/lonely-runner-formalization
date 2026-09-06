# Independent source review: final two-divisible branch and normalization

Semantic decision: **accept all four exact contracts**. The complete source
proofs preserve the accepted mathematical scopes, including the distinction
between primitive count at least two and nonprimitive count exactly two. The
single fixed import-only probe also passed; its exact predeclarations, complete
receipts and original streams are preserved below. This review does not assert an unconditional
five-moving sixth-margin theorem or unrestricted LRC.

I authored the original two-divisible and boundary assembly manuscripts but
neither reviewed source module. A different Astra reviewer accepted the original
manuscript. This is an independent implementation review that relies on the
separately frozen boundary source review, without repeating its proof review.
Only this report is owned; source/state/root imports/Git/cache and other reports
are preserved. No source build, numerical fixture, search or enumeration is run.

Project config, workflow, policy and focused state were read. The task records
checkpoint `d2f5f28`, requested Astra/xhigh and unavailable observed model/effort,
with research/in_progress. The actual `python3 scripts/validate_workflow.py`
exited 0 with `workflow structural validation passed; it cannot certify mathematical validity.`

## Frozen inputs and scope mapping

| Input | SHA-256 |
| --- | --- |
| `LonelyRunner/PrimitiveTwoDivisible.lean` | `873916a4fd815c75731c7327de419d96efde4c40fe74ed15d011b40b577f678d` |
| `LonelyRunner/TwoDivisibleNormalization.lean` | `d812237f06d63e67c8739122c76a5e67daa470402575ccafcdcee4c41d950286` |
| Original `research/astra-two-divisible-three-reduction-plan.md` | `07f27873785c463d7f9b2e8c2074510f42fcd973d07cc6e73ea62e5b3bac0ad6` |
| Independent `research/astra-two-divisible-three-plan-review.md` | `4d499c4477e80445646c6f82fcb72e36009ed1b9fc35b0023dd278f399598f71` |
| Accepted `research/astra-boundary-assembly-source-review.md` | `e4f69d48fa3a5930347b33c6b73f0d4b942ab03d3100f80c7041ca64a45f9375` |

The complete two target sources, directly invoked divisor-count, factor-six,
cover and three-divisible interfaces, and exact gcd/periodicity APIs were read.
The source changes some manuscript declaration names while preserving all its
intended final scopes. In particular the old shorter primitive name meant count
at least two; its full scope is now under the explicit at-least-two name below.

| Accepted manuscript contract | Implemented declaration | Exact count scope |
| --- | --- | --- |
| `false_of_primitive_no_sixth_witness_two_divisible_three` | `primitive_two_divisible_no_witness_contradiction` | Primitive, exactly two, all-real nonexistence implies False |
| Primitive intermediate positive witness | `fiveMovingNaturalRunners_of_primitive_two_divisible_three` | Primitive, exactly two |
| Manuscript `fiveMovingNaturalRunners_of_primitive_two_divisible_three` | `fiveMovingNaturalRunners_of_primitive_at_least_two_divisible_three` | Primitive, at least two |
| `fiveMovingNaturalRunners_of_two_divisible_three` | `fiveMovingNaturalRunners_of_exactly_two_divisible_three` | No primitive premise, exactly two |

Static comparison found the three corresponding manuscript/implemented complete
contracts equal after declaration-name changes, whitespace normalization and
the at-least-two hypothesis's binder rename. The new exact-two primitive witness
is the intermediate used to implement those adapters. It must not be confused
with the manuscript's old at-least-two use of the shorter name. The four exact
universal type assignments below make the final distinction explicit.

## 1. Primitive nonexistence to the supplied cover

Assume positive v : Fin 5 → Nat, gcd v=1, exactly two labels with 3-divisible
speed, and no real time with all five norms at least 1/6. The source defines
the divisible-label filter S and uses `Finset.card_eq_two` to obtain p≠q and
S={p,q}. The explicit `change S = {p,q} at hS` makes that let-defined equality
usable. Both directions of membership prove
`3∣v i ↔ i=p ∨ i=q` for every label; no injectivity of v is required.

`six_total_divisor_count_bounds` is applied only with ell=6 and ell=2. At 6,
its lower bound yields an actual label i with 6∣v i. Since 3∣6, the exact
classification places i at p or q, giving the required disjunction
`6∣v p ∨ 6∣v q`. At 2, its upper bound gives at most three even labels.
These are derived from hprimitive/hno, not extra assumptions. The divisor-count
source obtains the lower bound from the already-checked small-denominator
obstruction and the upper bound from the independent four-divisible insertion;
it does not depend on the two-divisible theorem being proved.

For each r distinct from p and q, the frozen boundary theorem now supplies
zero pair minimum at *every real* time whose r phase is 5/6. It receives exactly
hpos, p≠q, r's two inequalities, hdiv, hsix, heven and the all-real hno.
`dvd_or_dvd_of_five_sixths_pair_zero` applies with positive c=v r and yields
`6*v r ∣ v p ∨ 6*v r ∣ v q`. The full natural factor 6 is retained.
Its existing proof uses the negative anchor time -1/(6*c), reflecting a zero
norm to the nonnegative rational phase before positive-denominator divisibility.
Thus the all-real boundary scope is essential and is actually supplied here.

The cover is obtained uniformly for every outside label, with the same p,q.
`fiveMovingNaturalRunners_of_two_divisible_cover` then returns one positive
time satisfying all five closed inequalities. Dropping only the positive-time
conjunct produces the real witness that contradicts hno. There is no circular
assumption of a cover: it is the output of the independent boundary/divisibility
chain. The cover finisher's proof uses fast-speed exclusions, label pigeonhole
and the independently checked small-pair rescue, without calling this theorem.

## 2. Any real witness gives a positive witness

The primitive exact-two positive theorem argues by contradiction. If no
positive witness exists but a real witness occurs at t, choose s=fract(t)+1.
Since fract(t)≥0, s>0, including when t is negative or an integer.
For each natural speed d, the source proves
`(fract(t)+1)*d = (d : Int) + fract(t)*d` after real casts. Integer periodicity
removes the first term, and `circleNorm_fract_mul_nat` gives
N(fract(t)*d)=N(t*d). This exact norm equality transports every closed-sixth
inequality to the same positive s.

Hence absence of a positive witness implies the *all-real* nonexistence premise
required by the first theorem, which yields False. The source does not silently
assume the original real t is nonzero or positive and needs no reflection case.
It uses natural-speed period one; it does not assert this normalization for
arbitrary nonintegral speeds. This implementation differs from the manuscript's
possible reflection route while proving the identical positive-time contract.

## 3. Primitive count at least two

The at-least-two theorem splits on whether the divisible-label count equals 2.
In that branch it calls the primitive exact-two positive theorem. Otherwise
integer arithmetic gives count≥3, and the independent
`fiveMovingNaturalRunners_of_primitive_three_divisible_three` applies with the
same positivity and gcd-one hypotheses. That existing source uses primitivity
to find a label not divisible by 3, bounding the count by 4, before using the
three-or-four-divisible seed/shift theorem. It never calls this new two case.
The split therefore retains all primitive count≥2 inputs without circularity.

It is essential that primitivity remains in this at-least-two theorem. This
review does not extend it to a nonprimitive count≥2 assertion; an all-five
three-divisible family would not preserve the required count after gcd removal.

## 4. Exact-two normalization without primitivity

Set g=gcd(v) and w_i=v_i/g using *natural* division. `Finset.gcd_dvd` gives
g∣v_i for each label. Positivity at label 0 and `Finset.gcd_ne_zero_iff`
prove g>0, so the normalization never divides by zero. `Nat.mul_div_cancel'`
gives the exact natural factorization v_i=g*w_i. Positive v_i and g∣v_i give
g≤v_i, hence `Nat.div_pos` proves every w_i>0. The read library theorem
`Finset.gcd_div_eq_one`, applied to the nonzero value at label 0, proves gcd(w)=1.
Its actual hypotheses are membership and nonzero value; no injectivity, sorting,
translation, or coprimality assumption is invented.

If 3∣g then 3∣v_i for every i, so the 3-divisible filter equals all of Fin 5.
Its count is 5, contradicting exactly 2. Thus 3∤g. Using v_i=g*w_i,
`Nat.prime_three.dvd_mul` proves 3∣v_i implies 3∣w_i, because the alternative
3∣g is impossible. Conversely 3∣w_i implies 3∣g*w_i. This is a labelwise
biconditional, not just a cardinality inequality. Finset extensionality therefore
preserves the entire filter and its exact count 2, including repeated speeds.

The primitive exact-two theorem applied to w yields t>0 and all five bounds.
The returned time for v is t/g>0. The final source first rewrites each natural
factorization and then explicitly applies `Nat.cast_mul`; real field cancellation
proves `(t/g)*(g*w_i)=t*w_i` since g>0. Thus the *same* t/g works for every label
and the closed 1/6 threshold is unchanged. The scale is divided, not multiplied,
and no approximate or numerical reasoning enters the transport.

All four declarations concern labelled positive natural speeds. Repeated values
are allowed throughout; no distinct-speed assumption has been added. They prove
the indicated two-divisible and primitive-at-least-two cases. They do not supply
a result for arbitrary five positive speeds or a new unrestricted runner count.

## Earlier build evidence and preserved failures

Root's `research/astra-pass53-verification.json` was read at SHA-256
`c7007afce95afedd95ef6dec8ecede2e78e9c862e747d0ae754b2754867269b1`.
It retains both failed source drafts and complete actual logs. The primitive
first build exited 1 because hS's let-defined finset shape did not match the
subsequent rewrites; the only source correction was the explicit change to
S={p,q}. Its successful focused build exited 0 at 3,563 jobs, log SHA
`2a49fd5f19b5f5f49ec77a2f516ff5d3f3cf61eb1669ca9841ec521cea11c44f`.

The normalization first build exited 1 at the final real phase equality after
natural multiplication was left under a cast. The corrected proof explicitly
rewrites `Nat.cast_mul` and then cancels the nonzero real factor. Its remaining
source changes are explanatory documentation. The focused build exited 0 at
3,565 jobs, log SHA
`bf365a37ca1076d2859a5944d812f8cc864068bdc1aabea4f4cee09426b958b7`.
Static comparison confirms all four failed/final public declaration headers
unchanged. These are root's focused-build records; this review neither reruns
them nor claims a full Pass53 integration build from those focused receipts.

| Preserved failure | Source SHA-256 | Full log SHA-256 |
| --- | --- | --- |
| Primitive initial, exit 1 | `12be342490c0e9cfc93221ec4537277271be0d5f81470cea53f1cbb65e9beaf9` | `ffa2f22e64ec36a0acc99cec08a2e05d502dbb49c7c0b044955fd9812d9d9272` |
| Normalization initial, exit 1 | `8f17e4b16df3ce730fec690bee1f727a265151568779787297c57123328e5a92` | `83f4dd555f13ac430847aac3dd30850b49c32fdd419176db24f63715a13b065c` |

Earlier boundary source review is frozen at the hash above; its exact accepted
all-real target is reused, not re-proved in this review. The new import probe
independently checks the four target artifact types and complete transitive
axiom lists. Prior dependency warnings/informational messages remain in root's
source-build logs; a clean import stdout would not erase that build history.

## Predeclared fixed probe and sole replay entry

The payload has two direct imports, four complete universal type assignments
and four full axiom prints. Every count, gcd, positivity, time domain and closed
inequality is explicit. No private abbreviation occurs in these public types.
There is no local fixture, numerical computation, case enumeration, extra proof
experiment or formatting option. Each SHA-256 binds exact UTF-8 fence bytes,
including the final newline, before execution.

Probe SHA-256: `3b9b8cd8e96f605792443aad2e0b751a8e4e318b45479d58346b7f53f759366e`
Launcher SHA-256: `2c3a50a64ce743c3a3842108438eaaa4fe28a7a50f3b4bd5cd653b0e2c942aed`

The complete Python controller is contained in the single Bash entry below.
Its 29 guards bind both target source/olean pairs, their five other immediate
project dependencies, three relevant periodicity/norm source/olean pairs,
Mathlib's Finset gcd module and Tactic umbrella, three project pins and both
pinned runtime binaries. Mathlib is pinned by the manifest to
`520045ab14e26149ee970e2e617ca04b09bde5d6`; the resolved Lean/Lake paths must
be the guarded v4.32.1 binaries. All input guards run before and after; the
probe and launcher hashes are checked against their startup bytes.

The controller invokes only `lake env lean -j1 -s65536 --stdin`, with threads 1
and stack 65536 KiB explicitly set in the environment. Limits are AS 8 GiB,
CPU soft/hard 59/60 seconds, wall 60 seconds and 128 KiB per regular stdout/stderr
file; core dumps are disabled. A timeout kills the child's process group.
Any error, signal, timeout, cap hit or guard mismatch fails the run and retains
its full actual output/status. There is no retry, build or resource escalation.
The parser requires precisely the four named axiom reports in order, no other
stdout or stderr, and only propext, Classical.choice, Quot.sound.

The controller saves this report's complete pre-run snapshot. Root's later
replay will snapshot the report after actual evidence is appended; the exact
probe, launcher, guards, caps and output contract remain unchanged.

```lean
import LonelyRunner.PrimitiveTwoDivisible
import LonelyRunner.TwoDivisibleNormalization

open LonelyRunner

example :
    ∀ v : Fin 5 → ℕ, (∀ i, 0 < v i) →
      Finset.univ.gcd v = 1 →
      ((Finset.univ : Finset (Fin 5)).filter (fun i => 3 ∣ v i)).card = 2 →
      (¬ ∃ t : ℝ, ∀ i, (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ))) → False :=
  LonelyRunner.primitive_two_divisible_no_witness_contradiction

example :
    ∀ v : Fin 5 → ℕ, (∀ i, 0 < v i) →
      Finset.univ.gcd v = 1 →
      ((Finset.univ : Finset (Fin 5)).filter (fun i => 3 ∣ v i)).card = 2 →
      ∃ t : ℝ, 0 < t ∧ ∀ i,
        (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ)) :=
  LonelyRunner.fiveMovingNaturalRunners_of_primitive_two_divisible_three

example :
    ∀ v : Fin 5 → ℕ, (∀ i, 0 < v i) →
      Finset.univ.gcd v = 1 →
      2 ≤ ((Finset.univ : Finset (Fin 5)).filter (fun i => 3 ∣ v i)).card →
      ∃ t : ℝ, 0 < t ∧ ∀ i,
        (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ)) :=
  LonelyRunner.fiveMovingNaturalRunners_of_primitive_at_least_two_divisible_three

example :
    ∀ v : Fin 5 → ℕ, (∀ i, 0 < v i) →
      ((Finset.univ : Finset (Fin 5)).filter (fun i => 3 ∣ v i)).card = 2 →
      ∃ t : ℝ, 0 < t ∧ ∀ i,
        (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ)) :=
  LonelyRunner.fiveMovingNaturalRunners_of_exactly_two_divisible_three

#print axioms LonelyRunner.primitive_two_divisible_no_witness_contradiction
#print axioms LonelyRunner.fiveMovingNaturalRunners_of_primitive_two_divisible_three
#print axioms LonelyRunner.fiveMovingNaturalRunners_of_primitive_at_least_two_divisible_three
#print axioms LonelyRunner.fiveMovingNaturalRunners_of_exactly_two_divisible_three
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
report = root / 'research/astra-two-divisible-final-source-review.md'
text = report.read_text()
fence = chr(96) * 3
probe = text.split(fence + 'lean\n', 1)[1].split(fence, 1)[0].encode()
launcher = text.split(fence + 'bash\n', 1)[1].split(fence, 1)[0].encode()
out = Path(tempfile.mkdtemp(prefix='astra-two-divisible-final-review-'))
(out / 'stdin.bin').write_bytes(probe)
(out / 'launcher.sh').write_bytes(launcher)
(out / 'report-snapshot.md').write_bytes(text.encode())
guards = {
    'LonelyRunner/PrimitiveTwoDivisible.lean': '873916a4fd815c75731c7327de419d96efde4c40fe74ed15d011b40b577f678d',
    '.lake/build/lib/lean/LonelyRunner/PrimitiveTwoDivisible.olean': 'cb852919663129497b8de9f0d8495f829f6ae05834f69b946588b3cbfca186ce',
    'LonelyRunner/TwoDivisibleNormalization.lean': 'd812237f06d63e67c8739122c76a5e67daa470402575ccafcdcee4c41d950286',
    '.lake/build/lib/lean/LonelyRunner/TwoDivisibleNormalization.olean': '392cb13a2ae6f55acf2967bd4d537a921b45a079a6c93bdda35e874cb038b61b',
    'LonelyRunner/SixTotalDivisorCounts.lean': '0b62ef724eb8c24db4085e247e9f16f650ec450291c7ccac2b0ad0981f148727',
    '.lake/build/lib/lean/LonelyRunner/SixTotalDivisorCounts.olean': '4c4adfb72f8142f2187e1e7a069738f0154b5759468e044fc32386f0ddeef888',
    'LonelyRunner/TwoDivisibleBoundary.lean': '5a3dc7ca4c0d777ba38d47e2f2b86a1036f9d6080f03f473ad87f6d31c1ca66c',
    '.lake/build/lib/lean/LonelyRunner/TwoDivisibleBoundary.olean': 'affcd1c846fe099c66b978e2873fd0261ea324b872b46a3d4a4c86d9c182395d',
    'LonelyRunner/BoundaryZeroDivisibility.lean': 'a01608409d16b3ce50ebfe65f19bf003c1c9d4d02f94623257e7e6a2b258f1f5',
    '.lake/build/lib/lean/LonelyRunner/BoundaryZeroDivisibility.olean': '2468fa096fc1ec8895c3189a0754b90000d41187d8cc549ffe5ba0f60b6a946f',
    'LonelyRunner/TwoDivisibleCover.lean': '5438e044cb9026dadefb754aab18c22f7ad8eb9ce457f7ad9be3dedb3aff4d81',
    '.lake/build/lib/lean/LonelyRunner/TwoDivisibleCover.olean': 'd364d5542397637ccd437a0bb6b773e94d576e79564c074e06302a63ca79a99b',
    'LonelyRunner/ThreeDivisibleRunners.lean': '614dc7bbf75143da6960d74b3eef5427ef93c9c8b3cbe51ec5cd5c6ca47376a3',
    '.lake/build/lib/lean/LonelyRunner/ThreeDivisibleRunners.olean': '3420ef54c8e2a26960e7dcb8469a5083202a8ca02338978063dfa06662a14c13',
    'LonelyRunner/PivotBoundary.lean': '0e56cab74d30ef8b537ed4ec24503aae875bd8aadc369d26da99ba882cc3603f',
    '.lake/build/lib/lean/LonelyRunner/PivotBoundary.olean': '85bf755552cc89ea4836b653f374ea9218e2c87e43e19665f2100623f514b573',
    'LonelyRunner/FastRunnerInsertion.lean': 'dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5',
    '.lake/build/lib/lean/LonelyRunner/FastRunnerInsertion.olean': '121edfbaed0d7b9fed32bacf891de838142988e48dcb4e7f2bed0c488ea49136',
    'LonelyRunner/StructuredClasses.lean': '5328a7a88d2b42f86ffc3f0f0418ca22c761219e8fa3e5822bda5a18ac286e8c',
    '.lake/build/lib/lean/LonelyRunner/StructuredClasses.olean': '4ada0ca2f0a5f20a8c83c3c2e58256e931c3b283882a88a074aeedb02d7e048f',
    '.lake/packages/mathlib/Mathlib/Algebra/GCDMonoid/Finset.lean': 'e0e320bd1f4a5a9e79da9fde6e2e3691ebbbccea8a4fba5765bda3b56e715568',
    '.lake/packages/mathlib/.lake/build/lib/lean/Mathlib/Algebra/GCDMonoid/Finset.olean': '44a670f6baf14a85957f51aa9da654754c5964546ba645c9fcb6cbb3b55d9797',
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
    'LonelyRunner.primitive_two_divisible_no_witness_contradiction',
    'LonelyRunner.fiveMovingNaturalRunners_of_primitive_two_divisible_three',
    'LonelyRunner.fiveMovingNaturalRunners_of_primitive_at_least_two_divisible_three',
    'LonelyRunner.fiveMovingNaturalRunners_of_exactly_two_divisible_three',
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
complete Bash entry both exited 0. All four full universal types checked;
every complete axiom list is exactly `propext`, `Classical.choice`, `Quot.sound`.
Both predeclared hashes matched and all 29 guards passed before and after.
There was no stderr, timeout, cap hit, runtime error, retry, source build or
resource change. The multi-line axiom output below is preserved exactly as
Lean printed it; the controller did not suppress formatting or diagnostics.

The inner invocation took 2.174991198000498 seconds wall time, 1.445951 seconds
child user time and 0.687574 seconds child system time. Recorded maximum child
RSS was 3,650,572 KiB. Lean stdout is 534 bytes, SHA-256
`61c66a18a7e4a8791e76b29ad8a90fffe6b42cde1dedda687462ba4dc229f1a7`.
The complete inner receipt SHA-256 is
`9581a00d469b943c22c20f8ca6fb8b751ac307c936feb502c3279d0d593e0538`.

The Bash entry was launched by a file-captured outer Python wrapper with the
same AS/CPU/regular-stream caps and a 65-second outer wall limit: 60 seconds
for the inner Lean limit plus five seconds to write receipts. This does not
extend Lean's limit. Its actual wall time was 2.219063497002935 seconds, exit 0.
Complete Bash stdout is 6,517 bytes, SHA-256
`9e008b2a686cabeaa7dc51329a84fcb76f859fd7af3102705b58e1870540e965`.
Both inner and outer stderr contain zero bytes with SHA-256
`e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

The pre-run report snapshot is 25,772 bytes, SHA-256
`fa32301ecdde36b5a873699b6bf1f429ffbc7e3a84cce636767f2de4d7afcb6b`.
The two temporary evidence directories retain exact stdin, launcher, snapshot,
receipts and original regular streams. Both full receipts and every output
stream are also embedded below, so the actual result is independently readable
without relying on temporary-directory persistence.

Full outer receipt, SHA-256
`442d15e285d838b591bbabcf0acbf97b2aa5bc754beb4ba2b6040aa10ac987ee`:

```json
{
  "address_space_bytes": 8589934592,
  "argv": [
    "bash",
    "/tmp/astra-two-divisible-final-entry-lz855yh0/entry.sh"
  ],
  "cpu_seconds": [
    59,
    60
  ],
  "error": null,
  "exit": 0,
  "files": {
    "entry.sh": {
      "bytes": 10200,
      "sha256": "2c3a50a64ce743c3a3842108438eaaa4fe28a7a50f3b4bd5cd653b0e2c942aed"
    },
    "stderr.bin": {
      "bytes": 0,
      "sha256": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
    },
    "stdout.bin": {
      "bytes": 6517,
      "sha256": "9e008b2a686cabeaa7dc51329a84fcb76f859fd7af3102705b58e1870540e965"
    }
  },
  "outer_wall_limit_note": "60-second inner Lean limit plus 5-second receipt-writing grace",
  "outer_wall_limit_seconds": 65,
  "passed": true,
  "stream_bytes": 131072,
  "stream_cap_hit": false,
  "timed_out": false,
  "wall_seconds": 2.219063497002935
}
```

Complete original Bash stdout, including the full inner receipt and original
Lean stdout/stderr between explicit markers:

```text
EVIDENCE_DIR /tmp/astra-two-divisible-final-review-wom7p_95
RECEIPT_SHA256 9581a00d469b943c22c20f8ca6fb8b751ac307c936feb502c3279d0d593e0538
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
    "LonelyRunner.fiveMovingNaturalRunners_of_exactly_two_divisible_three": [
      "propext",
      "Classical.choice",
      "Quot.sound"
    ],
    "LonelyRunner.fiveMovingNaturalRunners_of_primitive_at_least_two_divisible_three": [
      "propext",
      "Classical.choice",
      "Quot.sound"
    ],
    "LonelyRunner.fiveMovingNaturalRunners_of_primitive_two_divisible_three": [
      "propext",
      "Classical.choice",
      "Quot.sound"
    ],
    "LonelyRunner.primitive_two_divisible_no_witness_contradiction": [
      "propext",
      "Classical.choice",
      "Quot.sound"
    ]
  },
  "child_max_rss_kib": 3650572,
  "child_system_seconds": 0.687574,
  "child_user_seconds": 1.445951,
  "environment": {
    "LEAN_NUM_THREADS": "1",
    "LEAN_STACK_SIZE_KB": "65536"
  },
  "error": null,
  "exit": 0,
  "files": {
    "launcher.sh": {
      "bytes": 10200,
      "sha256": "2c3a50a64ce743c3a3842108438eaaa4fe28a7a50f3b4bd5cd653b0e2c942aed"
    },
    "report-snapshot.md": {
      "bytes": 25772,
      "sha256": "fa32301ecdde36b5a873699b6bf1f429ffbc7e3a84cce636767f2de4d7afcb6b"
    },
    "stderr.bin": {
      "bytes": 0,
      "sha256": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
    },
    "stdin.bin": {
      "bytes": 1763,
      "sha256": "3b9b8cd8e96f605792443aad2e0b751a8e4e318b45479d58346b7f53f759366e"
    },
    "stdout.bin": {
      "bytes": 534,
      "sha256": "61c66a18a7e4a8791e76b29ad8a90fffe6b42cde1dedda687462ba4dc229f1a7"
    }
  },
  "guards": {
    ".lake/build/lib/lean/LonelyRunner/BoundaryZeroDivisibility.olean": "2468fa096fc1ec8895c3189a0754b90000d41187d8cc549ffe5ba0f60b6a946f",
    ".lake/build/lib/lean/LonelyRunner/FastRunnerInsertion.olean": "121edfbaed0d7b9fed32bacf891de838142988e48dcb4e7f2bed0c488ea49136",
    ".lake/build/lib/lean/LonelyRunner/PivotBoundary.olean": "85bf755552cc89ea4836b653f374ea9218e2c87e43e19665f2100623f514b573",
    ".lake/build/lib/lean/LonelyRunner/PrimitiveTwoDivisible.olean": "cb852919663129497b8de9f0d8495f829f6ae05834f69b946588b3cbfca186ce",
    ".lake/build/lib/lean/LonelyRunner/SixTotalDivisorCounts.olean": "4c4adfb72f8142f2187e1e7a069738f0154b5759468e044fc32386f0ddeef888",
    ".lake/build/lib/lean/LonelyRunner/StructuredClasses.olean": "4ada0ca2f0a5f20a8c83c3c2e58256e931c3b283882a88a074aeedb02d7e048f",
    ".lake/build/lib/lean/LonelyRunner/ThreeDivisibleRunners.olean": "3420ef54c8e2a26960e7dcb8469a5083202a8ca02338978063dfa06662a14c13",
    ".lake/build/lib/lean/LonelyRunner/TwoDivisibleBoundary.olean": "affcd1c846fe099c66b978e2873fd0261ea324b872b46a3d4a4c86d9c182395d",
    ".lake/build/lib/lean/LonelyRunner/TwoDivisibleCover.olean": "d364d5542397637ccd437a0bb6b773e94d576e79564c074e06302a63ca79a99b",
    ".lake/build/lib/lean/LonelyRunner/TwoDivisibleNormalization.olean": "392cb13a2ae6f55acf2967bd4d537a921b45a079a6c93bdda35e874cb038b61b",
    ".lake/packages/mathlib/.lake/build/lib/lean/Mathlib/Algebra/GCDMonoid/Finset.olean": "44a670f6baf14a85957f51aa9da654754c5964546ba645c9fcb6cbb3b55d9797",
    ".lake/packages/mathlib/.lake/build/lib/lean/Mathlib/Tactic.olean": "0534ef12e7aaf8ffbb6e520a91f922da4469d0dca2b54c87b4458e1faa28a6a2",
    ".lake/packages/mathlib/Mathlib/Algebra/GCDMonoid/Finset.lean": "e0e320bd1f4a5a9e79da9fde6e2e3691ebbbccea8a4fba5765bda3b56e715568",
    ".lake/packages/mathlib/Mathlib/Tactic.lean": "c6f2c548596b635a3d5c8aff8b19cbdeb60dd54e41bb89a1cd03b1a54d335fa5",
    "/home/joshua/.elan/toolchains/leanprover--lean4---v4.32.1/bin/lake": "60330ab6f07dce20f3fa9ebb08e8b984ea9549eac172afeb15d9d2227060e2b3",
    "/home/joshua/.elan/toolchains/leanprover--lean4---v4.32.1/bin/lean": "e8baaa71855a616dc351028f3ad2200051b0671f423a1696a100e809302d5550",
    "LonelyRunner/BoundaryZeroDivisibility.lean": "a01608409d16b3ce50ebfe65f19bf003c1c9d4d02f94623257e7e6a2b258f1f5",
    "LonelyRunner/FastRunnerInsertion.lean": "dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5",
    "LonelyRunner/PivotBoundary.lean": "0e56cab74d30ef8b537ed4ec24503aae875bd8aadc369d26da99ba882cc3603f",
    "LonelyRunner/PrimitiveTwoDivisible.lean": "873916a4fd815c75731c7327de419d96efde4c40fe74ed15d011b40b577f678d",
    "LonelyRunner/SixTotalDivisorCounts.lean": "0b62ef724eb8c24db4085e247e9f16f650ec450291c7ccac2b0ad0981f148727",
    "LonelyRunner/StructuredClasses.lean": "5328a7a88d2b42f86ffc3f0f0418ca22c761219e8fa3e5822bda5a18ac286e8c",
    "LonelyRunner/ThreeDivisibleRunners.lean": "614dc7bbf75143da6960d74b3eef5427ef93c9c8b3cbe51ec5cd5c6ca47376a3",
    "LonelyRunner/TwoDivisibleBoundary.lean": "5a3dc7ca4c0d777ba38d47e2f2b86a1036f9d6080f03f473ad87f6d31c1ca66c",
    "LonelyRunner/TwoDivisibleCover.lean": "5438e044cb9026dadefb754aab18c22f7ad8eb9ce457f7ad9be3dedb3aff4d81",
    "LonelyRunner/TwoDivisibleNormalization.lean": "d812237f06d63e67c8739122c76a5e67daa470402575ccafcdcee4c41d950286",
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
  "wall_seconds": 2.174991198000498
}
STDOUT-BEGIN
'LonelyRunner.primitive_two_divisible_no_witness_contradiction' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'LonelyRunner.fiveMovingNaturalRunners_of_primitive_two_divisible_three' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'LonelyRunner.fiveMovingNaturalRunners_of_primitive_at_least_two_divisible_three' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'LonelyRunner.fiveMovingNaturalRunners_of_exactly_two_divisible_three' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
STDOUT-END
STDERR-BEGIN
STDERR-END
```

Complete outer stderr (zero bytes):

```text
```

Final disposition: accept all four exact implemented contracts. No source
correction is requested. The results cover primitive positive Fin 5 families
with at least two three-divisible labels, and arbitrary positive Fin 5 families
with exactly two three-divisible labels. They do not assert the nonprimitive
at-least-two case or the unrestricted five-moving sixth-margin theorem. Root's
remaining integration and exact replay are separate from this completed review.

The standing user priority recorded during this review on 2026-09-06 remains
in force: finish the working canonical N=6 milestone with its required build,
trust and exact-scope checks, then direct research to a uniform arbitrary-N
mechanism. Successive higher runner counts are not the roadmap. This policy
update changes neither the reviewed source contracts nor the frozen probe,
launcher or artifact guards, and N=6 is not completion of unrestricted LRC.
