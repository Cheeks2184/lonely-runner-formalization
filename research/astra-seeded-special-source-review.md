# Independent source review: seeded rescues and special sixth phases

Review date: 2026-09-06. Requested route: Astra/xhigh; independent runtime
model/effort attestation is unavailable. This reviewer authored none of the
three implementations. All three complete sources, including both private
helpers, were read. Only this report is edited.

## Semantic verdict and source scope

Accept all five exact public contracts and all complete proofs. No weakened
hypothesis, incorrect cast, endpoint defect, or separate-per-label shift was
found. The single import-only verification is predeclared below; its actual
receipt will be appended without changing either executable section.

Frozen sources, also matched against the `files` entries in
`research/astra-pass48-verification.json`:

- `ThirdShiftRescues.lean`:
  `829db12405e64ad88da5501ddb167d650ad82cf92295a88fd2374d9e08281732`.
- `SpecialSixthPhase.lean`:
  `677372ee3dc86520051f4bcc037f685a3f5fd8748c737ef9e1d2bfc5ac0072d8`.
- `ThirdShiftSpecialSeed.lean`:
  `ffbab991e23c45a1cd0abb2f692c30f35665f04ae5843a70898da00c69ab6187`.

All paths above are under `LonelyRunner/`. The accepted mathematical source
is the two-divisible manuscript SHA
`07f27873785c463d7f9b2e8c2074510f42fcd973d07cc6e73ea62e5b3bac0ad6`
and its independent review SHA
`4d499c4477e80445646c6f82fcb72e36009ed1b9fc35b0023dd278f399598f71`.
This batch supplies conditional proof infrastructure, not a complete
two-divisible branch or a new runner-count theorem.

Current config, workflow, policy, and focused state were read. The state records
research/in_progress and this review at checkpoint d90f1d8.
`python3 scripts/validate_workflow.py` actually returned exit 0 with stdout:

```text
workflow structural validation passed; it cannot certify mathematical validity.
```

Root reported all focused source builds passed; the full-root build was running
when the task was assigned. Build receipts and compiler corrections in the
verification JSON are historical root evidence, not fresh executions by this
review. This reviewer performs no source build and makes no claim about
completion of that separate root build.

## Complete semantic audit

Write N for circleNorm. The universal types in the probe retain every public
premise; the following checks explain why those are the correct contracts.

### Two bad labels among seeded divisible speeds

`exists_third_shift_of_two_bad_seeded_divisible` allows any natural Fin 5
speed function and any real t. It assumes every divisible label is seeded
at closed margin 1/6, at most three exceptional labels, and two distinct
labels whose current norms are strictly below 1/6.

The proof defines E as the Finset of nondivisible labels and X as its subtype.
`Fintype.card_coe` turns the explicit filtered cardinality bound into
card X≤3. Strict badness of u and w contradicts the seed hypothesis if either
speed were divisible by three, so both actually belong to E. Their subtype
representatives remain distinct: equality would give u=w by Subtype.val.
No distinctness of speed values is introduced.

The generic collision theorem is applied to X with x_i=t*v_i and d_i=v_i,
using exactly those two distinct bad subtype labels. It supplies a single
k safe for all exceptional labels. For each original label, either it is
divisible and the rational-shift preservation theorem gives

    N((t+k/3)*v_i)=N(t*v_i),

or it is exceptional and distributivity identifies its phase with
t*v_i+k*v_i/3 in the collision conclusion. Thus the same k handles all labels.
The case split neither changes k nor silently chooses another time.

No positivity of t or v is used. Zero speeds are not ruled out by an added
public premise, although a zero divisible speed makes the seed hypothesis
impossible. Strict badness is necessary to derive exception membership and
to use collision; all safety conclusions remain weak inequalities.

### One exception safe at every shift

`exists_third_shift_of_safe_exception_seeded_divisible` retains the same
arbitrary v,t, divisible seed, and exception-cardinality bound, and explicitly
requires r to be nondivisible and safe at **every** k:Fin 3.

Again X is the subtype of exceptional labels, with card X≤3. The proof forms
rX:X and then Y={i:X // i.val≠r}. The library
`Fintype.card_subtype_lt` applies using the omitted witness rX; its predicate
fails because rX.val=r. Therefore card Y<card X≤3 and card Y≤2.
This nested subtype removes one original label, not one distinct speed value.
For i:Y, i.val is in X, and i.val.property is exactly its membership in E;
the proof correctly extracts nondivisibility from that property.

The at-most-two family theorem supplies one k for Y. Divisible labels use
preservation; the distinguished label r uses hsafe k; each other exceptional
label is embedded as iY:Y and uses the same hk. The nested projections
iY.val.val are definitionally the original Fin 5 label, and the ring identity
restores the time-shift expression.

The argument also permits an empty Y, for example when r is the only
exception. It does not require three exceptions exactly, and it cannot remove
a divisible r: the public hr premise is retained. Merely knowing that r is safe
at the seed would be insufficient; the source retains uniform safety over k.
There is no public DecidableEq assumption; local classical instances handle
the finite filters and subtypes.

### Private fractional-part reduction

The first private helper is `fract_add_nat_div_three`. For arbitrary real x
and natural n it proves

    fract(x+n/3)=fract(fract(x)+(n%3)/3).

The integer-difference witness is floor(x)+(n/3:ℕ), cast to ℤ **after**
natural division. This distinction is present explicitly in the source as
`((n / 3 : ℕ) : ℤ)`. Let q=n/3 in ℕ and r=n%3.
The identities x=floor(x)+fract(x) and 3q+r=n give

    x+n/3 - (fract(x)+r/3) = floor(x)+q.

This is exactly the witness required by `Int.fract_eq_fract`.
The explicit cast rewrites preserve q as the natural quotient; they do not
turn it into rational n/3. Negative x is handled by its integer floor, without
taking a natural floor or assuming x≥0. The case n=0 is included.

The second private helper, `circleNorm_ge_sixth_of_fract_special`, rewrites
N(y)=min(fract(y),1-fract(y)). For each of the three allowed fractions
1/6,1/2,5/6 this gives N(y)≥1/6, retaining equality at the two endpoints.
Both private proofs are ordinary proof terms used transitively by public
theorems; no extra axiom or unchecked computation is introduced.

### Odd-sixth safety for every natural speed

`circleNorm_third_shift_of_special_sixth` takes arbitrary x:ℝ, d:ℕ, k:Fin 3
and the three-way phase disjunction. It has **no nondivisibility premise**.
The source first casts the natural product k.val*d, then applies the private
reduction with n=k.val*d. Its remainder r=(k.val*d)%3 satisfies 0≤r<3.

Writing the initial fraction as (2j+1)/6 for j∈{0,1,2}, the reduced fraction
is that of (2j+1+2r)/6. Its numerator remains odd modulo six, so the result
belongs to {1/6,1/2,5/6}. The proof explicitly splits the three possible
natural remainders and the three initial phases. Its `interval_cases`,
`norm_num`, and `Int.fract_div_natCast_eq_div_natCast_mod` steps produce
ordinary kernel proof terms for these symbolic residue branches.
They are not an external certificate, `native_decide`, a search over speed
tuples, or a numerical experiment conducted by this review.

The used mathlib fractional-quotient theorem was read: for natural m,n it
identifies fract((m:ℝ)/n) with (m%n)/n by Euclidean division.
The generic private reduction is what justifies applying the finite rational
identities to unrestricted real x and natural d.

This contract includes d=0 and all speeds divisible by three; in those cases
the norm is still safe. No assertion that a nonzero composite residue is a
unit occurs. Preservation here proves safety, while its proof also establishes
membership in the three-point phase set.

### Exact transport to 5/6

`exists_third_shift_fract_five_sixths` is a different contract. It explicitly
assumes 3∤d. The natural remainder r=d%3 is below three and nonzero, so it is
one or two. The source's six branches choose exactly:

| Initial fraction | d%3=1 | d%3=2 |
| --- | --- | --- |
| 1/6 | k=2 | k=1 |
| 1/2 | k=1 | k=2 |
| 5/6 | k=0 | k=0 |

In the first row k*d has residue two, so the fractional addition is 2/3.
In the second it has residue one, so the addition is 1/3.
In the last no shift is needed. All yield exactly 5/6 after the private
fractional-part reduction, including when d is unreduced.
The choices lie in Fin 3; arithmetic on their natural values matches the
real casts in the public expression.

The nondivisibility premise is essential to this exact transport contract and
is retained. There is no assumption that x is nonnegative or already reduced,
and the phase conclusion is an equality, not a norm lower bound. The two
zero-shift branches do not drop the public nondivisibility assumption.

### Final special-seed wrapper

`exists_third_shift_of_special_sixth_seeded_divisible` retains the seeded
divisible family, at most three exceptions, a specified nondivisible r, and
the exact three-way fractional-part condition at t*v_r. It supplies the
uniform hsafe required by the second adapter by applying odd-sixth safety
to every k with x=t*v_r. The ring equality

    (t+k/3)*v_r = t*v_r+k*v_r/3

matches the two interfaces. The adapter then returns one k for the full family.
The exact-5/6 transport theorem is not needed for this wrapper; it is useful
separately in the anchored-maximum argument. No extra existence of a special
seed or positive final time is claimed.

All five contracts preserve closed 1/6 safety and the special endpoints
1/6 and 5/6. Arbitrary negative real times and repeated input speeds are
allowed wherever the stated conditional hypotheses can hold.

## Source dependencies and verification boundary

Direct project dependencies outside this target set are `ThirdShiftSeed`,
`ThirdShiftCollision`, and `ConstrainedMaximizer`. Their relevant exported
helpers are divisible-speed preservation/common shifts, the generic two-bad
collision, and the exact min-of-fractions norm identity. The needed signatures
and source proofs were inspected at frozen bindings; the min-of-fractions
identity had already been read in this same review sequence and is unchanged.

The launcher also binds the directly used inherited `RationalShiftOrbits`,
`ThirdShiftExceptions`, and norm-defining `FastRunnerInsertion`.
Direct mathlib imports `Data.Fintype.Card` and `Tactic`, plus the floor
source containing the exact fractional-quotient API, are bound with their
oleans. There are 28 guarded paths: nine project source/olean pairs, three
mathlib source/olean pairs, two accepted manuscripts, and two pins.
All exact hashes appear in EXPECTED below.

Root's separate focused builds supply source-to-olean correspondence.
This import-only probe independently checks the exported universal types
and their transitive axiom reports under the frozen oleans; it is not a new
source build or a hash audit of every transitive dependency. Root integration
and audit files, the mutable verification JSON, workflow state, and other
ongoing sources are not guarded. The toolchain pin is Lean v4.32.1.

## Predeclared single verification

Exactly one serial import-only probe, with five complete universal direct
type assignments and five full axiom prints. Both private helpers are reviewed
from source and covered transitively in the public axiom reports.
There are no extra probes, display options, numeric fixtures, solver calls,
mathematical searches, source builds, Git/state changes, or cache mutations.
Static reading, hashing, parsing, and report assembly are bookkeeping.

Child argv is exactly
`/home/joshua/.elan/bin/lake env lean -j1 -s65536 --stdin`,
with process-local `LEAN_NUM_THREADS=1` and `LEAN_STACK_SIZE_KB=65536`.
Limits are 8 GiB address space, CPU soft/hard 59/60 seconds, child alarm
60 seconds, and parent process-group kill after 60 seconds wall time.
Core dumps are disabled. Stdin and both output streams use regular temporary
files; each output file has a 128 KiB cap, combined stream capacity 256 KiB.

All guards and complete executable sections are compared before and after.
Stdout and stderr are retained completely as UTF-8 and base64 with byte counts
and SHA-256 hashes. Pass requires child exit 0, no timeout, uncapped capture,
empty stderr, unchanged inputs/sections, exactly five axiom lists in order,
and only propext, Classical.choice, Quot.sound. The parser includes multiline
lists through the closing bracket. Any failure will be retained and reported;
no retry or budget increase is authorized by this predeclaration.

## Exact universal probe

<!-- BEGIN PROBE -->
```lean
import LonelyRunner.ThirdShiftRescues
import LonelyRunner.SpecialSixthPhase
import LonelyRunner.ThirdShiftSpecialSeed

open LonelyRunner

example : ∀
    (v : Fin 5 → ℕ) (t : ℝ)
    (hseed : ∀ i, 3 ∣ v i →
      (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ)))
    (hexceptions :
      ((Finset.univ : Finset (Fin 5)).filter (fun i => ¬ 3 ∣ v i)).card ≤ 3)
    (u w : Fin 5) (huw : u ≠ w)
    (hu : circleNorm (t * (v u : ℝ)) < (1 : ℝ) / 6)
    (hw : circleNorm (t * (v w : ℝ)) < (1 : ℝ) / 6),
    ∃ k : Fin 3, ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm
        ((t + (k.val : ℝ) / 3) * (v i : ℝ)) :=
  exists_third_shift_of_two_bad_seeded_divisible

example : ∀
    (v : Fin 5 → ℕ) (t : ℝ)
    (hseed : ∀ i, 3 ∣ v i →
      (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ)))
    (hexceptions :
      ((Finset.univ : Finset (Fin 5)).filter (fun i => ¬ 3 ∣ v i)).card ≤ 3)
    (r : Fin 5) (hr : ¬ 3 ∣ v r)
    (hsafe : ∀ k : Fin 3,
      (1 : ℝ) / 6 ≤ circleNorm
        ((t + (k.val : ℝ) / 3) * (v r : ℝ))),
    ∃ k : Fin 3, ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm
        ((t + (k.val : ℝ) / 3) * (v i : ℝ)) :=
  exists_third_shift_of_safe_exception_seeded_divisible

example : ∀
    (x : ℝ) (d : ℕ) (k : Fin 3)
    (hx : Int.fract x = (1 : ℝ) / 6 ∨ Int.fract x = (1 : ℝ) / 2 ∨
      Int.fract x = (5 : ℝ) / 6),
    (1 : ℝ) / 6 ≤ circleNorm
      (x + (k.val : ℝ) * (d : ℝ) / 3) :=
  circleNorm_third_shift_of_special_sixth

example : ∀
    (x : ℝ) (d : ℕ) (hnot : ¬ 3 ∣ d)
    (hx : Int.fract x = (1 : ℝ) / 6 ∨ Int.fract x = (1 : ℝ) / 2 ∨
      Int.fract x = (5 : ℝ) / 6),
    ∃ k : Fin 3, Int.fract
      (x + (k.val : ℝ) * (d : ℝ) / 3) = (5 : ℝ) / 6 :=
  exists_third_shift_fract_five_sixths

example : ∀
    (v : Fin 5 → ℕ) (t : ℝ)
    (hseed : ∀ i, 3 ∣ v i →
      (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ)))
    (hexceptions :
      ((Finset.univ : Finset (Fin 5)).filter (fun i => ¬ 3 ∣ v i)).card ≤ 3)
    (r : Fin 5) (hr : ¬ 3 ∣ v r)
    (hx : Int.fract (t * (v r : ℝ)) = (1 : ℝ) / 6 ∨
      Int.fract (t * (v r : ℝ)) = (1 : ℝ) / 2 ∨
      Int.fract (t * (v r : ℝ)) = (5 : ℝ) / 6),
    ∃ k : Fin 3, ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm
        ((t + (k.val : ℝ) / 3) * (v i : ℝ)) :=
  exists_third_shift_of_special_sixth_seeded_divisible

#print axioms LonelyRunner.exists_third_shift_of_two_bad_seeded_divisible
#print axioms LonelyRunner.exists_third_shift_of_safe_exception_seeded_divisible
#print axioms LonelyRunner.circleNorm_third_shift_of_special_sixth
#print axioms LonelyRunner.exists_third_shift_fract_five_sixths
#print axioms LonelyRunner.exists_third_shift_of_special_sixth_seeded_divisible
```
<!-- END PROBE -->

## Exact bounded launcher

<!-- BEGIN LAUNCHER -->
```python
import base64
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

REPORT = Path('research/astra-seeded-special-source-review.md')
EXPECTED = {
    "LonelyRunner/ThirdShiftRescues.lean": "829db12405e64ad88da5501ddb167d650ad82cf92295a88fd2374d9e08281732",
    "LonelyRunner/SpecialSixthPhase.lean": "677372ee3dc86520051f4bcc037f685a3f5fd8748c737ef9e1d2bfc5ac0072d8",
    "LonelyRunner/ThirdShiftSpecialSeed.lean": "ffbab991e23c45a1cd0abb2f692c30f35665f04ae5843a70898da00c69ab6187",
    "LonelyRunner/ThirdShiftSeed.lean": "3c8b90583658df1cfdbe00e4444157e08d8ae7b4a74b986d5770e9f750429b46",
    "LonelyRunner/ThirdShiftCollision.lean": "5b984687f89ea16bad34453d3c048ceb974f999af9cd1969f73d56ce30e13cec",
    "LonelyRunner/ConstrainedMaximizer.lean": "2ef07e6b83b8675a22184571c31d2a71dab9d5c072e3cd165cb8382957b46e92",
    "LonelyRunner/RationalShiftOrbits.lean": "cf615dd6c6b3cf091cd5d31ac641f4f994c1c50d95e0120c311d3ac129b88591",
    "LonelyRunner/ThirdShiftExceptions.lean": "85590988cd0e104dc93fd51bc79aa326fe2799974eae426b7ea3336853872073",
    "LonelyRunner/FastRunnerInsertion.lean": "dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5",
    ".lake/build/lib/lean/LonelyRunner/ThirdShiftRescues.olean": "f43015c4f1d03a823ae6987b979d1ea09a5d972e2ee8c7cc953c149d666d2e94",
    ".lake/build/lib/lean/LonelyRunner/SpecialSixthPhase.olean": "2e4951ab757b0fa22574e72381abd7be6cca5c971f9e38967cf24f0991532537",
    ".lake/build/lib/lean/LonelyRunner/ThirdShiftSpecialSeed.olean": "f0c65f1e1d6e4f2982a645bdbc116d690f2508223de02e31ac4e479445536f58",
    ".lake/build/lib/lean/LonelyRunner/ThirdShiftSeed.olean": "5305c6fd2737c6a611abdb710e5e7659bdccdb35c346b7e386c0733a592686be",
    ".lake/build/lib/lean/LonelyRunner/ThirdShiftCollision.olean": "66e46c34df46e2a5350489acb7195991b6f332820fc6ec1535f40f4f186d4ef6",
    ".lake/build/lib/lean/LonelyRunner/ConstrainedMaximizer.olean": "443a61889184bd7fc7ea52a85ebcfa3fc0ba6f1e458b34824afb166812f38170",
    ".lake/build/lib/lean/LonelyRunner/RationalShiftOrbits.olean": "8194c5c6ac0b8495146728fcac70a6a1e9d317f9e7689c4759f22ed33c14340f",
    ".lake/build/lib/lean/LonelyRunner/ThirdShiftExceptions.olean": "d9c38deec30bda66014ed4d3e4de79fe5934f323e44e39771d353667ce47c7f9",
    ".lake/build/lib/lean/LonelyRunner/FastRunnerInsertion.olean": "121edfbaed0d7b9fed32bacf891de838142988e48dcb4e7f2bed0c488ea49136",
    ".lake/packages/mathlib/Mathlib/Data/Fintype/Card.lean": "2307820b0dee2080bd8245e268974bd02678d76067a6efc8878d004f7b8ed774",
    ".lake/packages/mathlib/Mathlib/Tactic.lean": "c6f2c548596b635a3d5c8aff8b19cbdeb60dd54e41bb89a1cd03b1a54d335fa5",
    ".lake/packages/mathlib/Mathlib/Algebra/Order/Floor/Ring.lean": "11f61aaf83c406b6b0accc6d34bdb4f77a1566fbdc63eae4d704728b9acf038c",
    ".lake/packages/mathlib/.lake/build/lib/lean/Mathlib/Data/Fintype/Card.olean": "5574bbb259614ae208b68ffa3f0e2439d08e1316b7e1e60a42e677b4f73f9208",
    ".lake/packages/mathlib/.lake/build/lib/lean/Mathlib/Tactic.olean": "0534ef12e7aaf8ffbb6e520a91f922da4469d0dca2b54c87b4458e1faa28a6a2",
    ".lake/packages/mathlib/.lake/build/lib/lean/Mathlib/Algebra/Order/Floor/Ring.olean": "7321187722159060ef5bba522dcb0fa44c87cd3b6933c2cedfd27f63b35a9080",
    "research/astra-two-divisible-three-reduction-plan.md": "07f27873785c463d7f9b2e8c2074510f42fcd973d07cc6e73ea62e5b3bac0ad6",
    "research/astra-two-divisible-three-plan-review.md": "4d499c4477e80445646c6f82fcb72e36009ed1b9fc35b0023dd278f399598f71",
    "lean-toolchain": "8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af",
    "lake-manifest.json": "887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218"
}

def sha(data):
    return hashlib.sha256(data).hexdigest()

def guard():
    observed = {p: sha(Path(p).read_bytes()) for p in EXPECTED}
    return observed, observed == EXPECTED

def section(report, name, language):
    start = '<!-- BEGIN ' + name + ' -->\n```' + language + '\n'
    end = '\n```\n<!-- END ' + name + ' -->'
    assert report.count(start) == 1 and report.count(end) == 1
    return (report.split(start, 1)[1].split(end, 1)[0] + '\n').encode('utf-8')

report_before = REPORT.read_text(encoding='utf-8')
probe = section(report_before, 'PROBE', 'lean')
launcher = section(report_before, 'LAUNCHER', 'python')
before, before_ok = guard()
if not before_ok:
    print(json.dumps({'status': 'precondition-failed', 'guards_before': before}, sort_keys=True))
    raise SystemExit(2)

CAP = 128 * 1024
WALL = 60.0
AS = 8 * 1024 ** 3

def child_limits():
    resource.setrlimit(resource.RLIMIT_AS, (AS, AS))
    resource.setrlimit(resource.RLIMIT_CPU, (59, 60))
    resource.setrlimit(resource.RLIMIT_FSIZE, (CAP, CAP))
    resource.setrlimit(resource.RLIMIT_CORE, (0, 0))
    signal.alarm(60)

argv = ['/home/joshua/.elan/bin/lake', 'env', 'lean', '-j1', '-s65536', '--stdin']
env = os.environ.copy()
env['LEAN_NUM_THREADS'] = '1'
env['LEAN_STACK_SIZE_KB'] = '65536'
env['PATH'] = '/home/joshua/.elan/bin:' + env.get('PATH', '')
usage_before = resource.getrusage(resource.RUSAGE_CHILDREN)
started = time.monotonic()
timed_out = False
with tempfile.TemporaryFile() as inp, tempfile.TemporaryFile() as out, tempfile.TemporaryFile() as err:
    inp.write(probe)
    inp.seek(0)
    child = subprocess.Popen(argv, stdin=inp, stdout=out, stderr=err,
        env=env, preexec_fn=child_limits, start_new_session=True)
    while child.poll() is None:
        if time.monotonic() - started >= WALL:
            timed_out = True
            try:
                os.killpg(child.pid, signal.SIGKILL)
            except ProcessLookupError:
                pass
            break
        time.sleep(0.02)
    exit_code = child.wait()
    wall = time.monotonic() - started
    out.seek(0)
    err.seek(0)
    stdout = out.read(CAP + 1)
    stderr = err.read(CAP + 1)
usage_after = resource.getrusage(resource.RUSAGE_CHILDREN)
after, after_ok = guard()
report_after = REPORT.read_text(encoding='utf-8')
probe_after = section(report_after, 'PROBE', 'lean')
launcher_after = section(report_after, 'LAUNCHER', 'python')
executable_unchanged = probe_after == probe and launcher_after == launcher
capture_ok = len(stdout) < CAP and len(stderr) < CAP
text_out = stdout.decode('utf-8', errors='replace')
axiom_records = re.findall(
    r"'LonelyRunner\.([^']+)' (?:depends on axioms: \[([^\]]*)\]|does not depend on any axioms)",
    text_out)
names = [
    "exists_third_shift_of_two_bad_seeded_divisible",
    "exists_third_shift_of_safe_exception_seeded_divisible",
    "circleNorm_third_shift_of_special_sixth",
    "exists_third_shift_fract_five_sixths",
    "exists_third_shift_of_special_sixth_seeded_divisible"
]
allowed = {'propext', 'Classical.choice', 'Quot.sound'}
axioms_ok = [name for name, _ in axiom_records] == names and all(
    set(filter(None, (x.strip() for x in body.split(',')))) <= allowed
    for _, body in axiom_records)
passed = (exit_code == 0 and not timed_out and capture_ok and not stderr
    and after_ok and executable_unchanged and axioms_ok)
receipt = {
    'status': 'passed' if passed else 'failed',
    'argv': argv,
    'runtime_env': {k: env[k] for k in ['LEAN_NUM_THREADS', 'LEAN_STACK_SIZE_KB']},
    'cwd': str(Path.cwd()),
    'exit_code': exit_code,
    'timed_out': timed_out,
    'wall_seconds': wall,
    'limits': {'address_space_bytes': AS, 'cpu_seconds': [59, 60],
        'wall_seconds': WALL, 'alarm_seconds': 60,
        'per_stream_bytes': CAP, 'combined_stream_bytes': 2 * CAP},
    'child_user_seconds': usage_after.ru_utime - usage_before.ru_utime,
    'child_system_seconds': usage_after.ru_stime - usage_before.ru_stime,
    'child_maxrss_kib': usage_after.ru_maxrss,
    'probe_bytes': len(probe),
    'probe_sha256': sha(probe),
    'probe_after_sha256': sha(probe_after),
    'launcher_bytes': len(launcher),
    'launcher_sha256': sha(launcher),
    'launcher_after_sha256': sha(launcher_after),
    'executable_unchanged': executable_unchanged,
    'guards_before': before,
    'guards_after': after,
    'capture_ok': capture_ok,
    'axiom_records': axiom_records,
    'axioms_ok': axioms_ok,
    'stdout_bytes': len(stdout),
    'stdout_sha256': sha(stdout),
    'stdout_base64': base64.b64encode(stdout).decode('ascii'),
    'stdout_utf8': text_out,
    'stderr_bytes': len(stderr),
    'stderr_sha256': sha(stderr),
    'stderr_base64': base64.b64encode(stderr).decode('ascii'),
    'stderr_utf8': stderr.decode('utf-8', errors='replace'),
}
print(json.dumps(receipt, sort_keys=True, indent=2))
raise SystemExit(0 if passed else 1)
```
<!-- END LAUNCHER -->

## Single Bash replay entry

Run in `/home/joshua/lonely-runner-formalization`. The same entry is used
for the initial invocation and extracts exactly the frozen launcher.

```bash
python3 -I - <<'PY'
from pathlib import Path
p = Path('research/astra-seeded-special-source-review.md')
s = p.read_text(encoding='utf-8')
start = '<!-- BEGIN LAUNCHER -->\n```python\n'
end = '\n```\n<!-- END LAUNCHER -->'
assert s.count(start) == 1 and s.count(end) == 1
code = s.split(start, 1)[1].split(end, 1)[0] + '\n'
exec(compile(code, str(p) + ':launcher', 'exec'))
PY
```

## Pre-invocation executable freeze

Static extraction and Python parsing passed before any Lean invocation.
All 28 guards and the exact single Bash-to-launcher extraction matched.
The actual static command exited 0 with this complete stdout:

```json
{
  "static_only": true,
  "guards_count": 28,
  "guards_match": true,
  "bash_entry_extraction_matches": true,
  "probe_bytes": 2789,
  "probe_sha256": "41965aafbf96380684bcc2a55c6e470a9a4e6b48fe6b0bd57af396748b35ba7f",
  "launcher_bytes": 8623,
  "launcher_sha256": "7abca32919611d1d6ee51f6f866555cb441e6fafaf902540c01500d9e8f994f8"
}
```

These are the fixed complete probe/launcher hashes and byte counts before
the single authorized Lean invocation. Neither executable section will change.

## Actual execution and final verdict

Accepted: all five complete universal type assignments elaborated, and all five
complete axiom reports use only propext, Classical.choice, Quot.sound.
The single Lean child and the outer launcher both exited 0. There was no
timeout, retry, extra Lean probe, numerical experiment, or source build here.

Actual elapsed wall time was 1.8493230769818183 seconds. Child user CPU
was 1.245921 seconds; child system CPU was
0.605329 seconds. Linux child peak RSS was
3285084 KiB, which is a resident-memory measurement separate
from the 8 GiB address-space cap. Stdout was 4314 bytes;
stderr was empty. Every one of the 28 guards and both complete executable
sections stayed unchanged.

The stdout includes 16 unused-name warnings for the named proof binders
in the explicit universal probe types. Those names are not referenced later
in their type bodies; their hypotheses are still quantified in the exact
type assignments. The warnings are not theorem failures or removed premises.
Their full text, including the tool's linter suggestion, is retained below.
No display/linter option was added, no output was suppressed, and the probe
was not changed or rerun to remove warnings.

Tool provenance: initial chunk `90bc32`, session `72823`,
empty initial output; completion chunk `a4ecb7`, actual outer exit 0.
The complete launcher stdout follows without truncation, including its closing
newline. The separate readable Lean stdout repeats exactly the bytes encoded
by the receipt's UTF-8/base64 fields.

<!-- BEGIN RECEIPT -->
```json
{
  "argv": [
    "/home/joshua/.elan/bin/lake",
    "env",
    "lean",
    "-j1",
    "-s65536",
    "--stdin"
  ],
  "axiom_records": [
    [
      "exists_third_shift_of_two_bad_seeded_divisible",
      "propext, Classical.choice, Quot.sound"
    ],
    [
      "exists_third_shift_of_safe_exception_seeded_divisible",
      "propext,\n Classical.choice,\n Quot.sound"
    ],
    [
      "circleNorm_third_shift_of_special_sixth",
      "propext, Classical.choice, Quot.sound"
    ],
    [
      "exists_third_shift_fract_five_sixths",
      "propext, Classical.choice, Quot.sound"
    ],
    [
      "exists_third_shift_of_special_sixth_seeded_divisible",
      "propext,\n Classical.choice,\n Quot.sound"
    ]
  ],
  "axioms_ok": true,
  "capture_ok": true,
  "child_maxrss_kib": 3285084,
  "child_system_seconds": 0.605329,
  "child_user_seconds": 1.245921,
  "cwd": "/home/joshua/lonely-runner-formalization",
  "executable_unchanged": true,
  "exit_code": 0,
  "guards_after": {
    ".lake/build/lib/lean/LonelyRunner/ConstrainedMaximizer.olean": "443a61889184bd7fc7ea52a85ebcfa3fc0ba6f1e458b34824afb166812f38170",
    ".lake/build/lib/lean/LonelyRunner/FastRunnerInsertion.olean": "121edfbaed0d7b9fed32bacf891de838142988e48dcb4e7f2bed0c488ea49136",
    ".lake/build/lib/lean/LonelyRunner/RationalShiftOrbits.olean": "8194c5c6ac0b8495146728fcac70a6a1e9d317f9e7689c4759f22ed33c14340f",
    ".lake/build/lib/lean/LonelyRunner/SpecialSixthPhase.olean": "2e4951ab757b0fa22574e72381abd7be6cca5c971f9e38967cf24f0991532537",
    ".lake/build/lib/lean/LonelyRunner/ThirdShiftCollision.olean": "66e46c34df46e2a5350489acb7195991b6f332820fc6ec1535f40f4f186d4ef6",
    ".lake/build/lib/lean/LonelyRunner/ThirdShiftExceptions.olean": "d9c38deec30bda66014ed4d3e4de79fe5934f323e44e39771d353667ce47c7f9",
    ".lake/build/lib/lean/LonelyRunner/ThirdShiftRescues.olean": "f43015c4f1d03a823ae6987b979d1ea09a5d972e2ee8c7cc953c149d666d2e94",
    ".lake/build/lib/lean/LonelyRunner/ThirdShiftSeed.olean": "5305c6fd2737c6a611abdb710e5e7659bdccdb35c346b7e386c0733a592686be",
    ".lake/build/lib/lean/LonelyRunner/ThirdShiftSpecialSeed.olean": "f0c65f1e1d6e4f2982a645bdbc116d690f2508223de02e31ac4e479445536f58",
    ".lake/packages/mathlib/.lake/build/lib/lean/Mathlib/Algebra/Order/Floor/Ring.olean": "7321187722159060ef5bba522dcb0fa44c87cd3b6933c2cedfd27f63b35a9080",
    ".lake/packages/mathlib/.lake/build/lib/lean/Mathlib/Data/Fintype/Card.olean": "5574bbb259614ae208b68ffa3f0e2439d08e1316b7e1e60a42e677b4f73f9208",
    ".lake/packages/mathlib/.lake/build/lib/lean/Mathlib/Tactic.olean": "0534ef12e7aaf8ffbb6e520a91f922da4469d0dca2b54c87b4458e1faa28a6a2",
    ".lake/packages/mathlib/Mathlib/Algebra/Order/Floor/Ring.lean": "11f61aaf83c406b6b0accc6d34bdb4f77a1566fbdc63eae4d704728b9acf038c",
    ".lake/packages/mathlib/Mathlib/Data/Fintype/Card.lean": "2307820b0dee2080bd8245e268974bd02678d76067a6efc8878d004f7b8ed774",
    ".lake/packages/mathlib/Mathlib/Tactic.lean": "c6f2c548596b635a3d5c8aff8b19cbdeb60dd54e41bb89a1cd03b1a54d335fa5",
    "LonelyRunner/ConstrainedMaximizer.lean": "2ef07e6b83b8675a22184571c31d2a71dab9d5c072e3cd165cb8382957b46e92",
    "LonelyRunner/FastRunnerInsertion.lean": "dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5",
    "LonelyRunner/RationalShiftOrbits.lean": "cf615dd6c6b3cf091cd5d31ac641f4f994c1c50d95e0120c311d3ac129b88591",
    "LonelyRunner/SpecialSixthPhase.lean": "677372ee3dc86520051f4bcc037f685a3f5fd8748c737ef9e1d2bfc5ac0072d8",
    "LonelyRunner/ThirdShiftCollision.lean": "5b984687f89ea16bad34453d3c048ceb974f999af9cd1969f73d56ce30e13cec",
    "LonelyRunner/ThirdShiftExceptions.lean": "85590988cd0e104dc93fd51bc79aa326fe2799974eae426b7ea3336853872073",
    "LonelyRunner/ThirdShiftRescues.lean": "829db12405e64ad88da5501ddb167d650ad82cf92295a88fd2374d9e08281732",
    "LonelyRunner/ThirdShiftSeed.lean": "3c8b90583658df1cfdbe00e4444157e08d8ae7b4a74b986d5770e9f750429b46",
    "LonelyRunner/ThirdShiftSpecialSeed.lean": "ffbab991e23c45a1cd0abb2f692c30f35665f04ae5843a70898da00c69ab6187",
    "lake-manifest.json": "887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218",
    "lean-toolchain": "8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af",
    "research/astra-two-divisible-three-plan-review.md": "4d499c4477e80445646c6f82fcb72e36009ed1b9fc35b0023dd278f399598f71",
    "research/astra-two-divisible-three-reduction-plan.md": "07f27873785c463d7f9b2e8c2074510f42fcd973d07cc6e73ea62e5b3bac0ad6"
  },
  "guards_before": {
    ".lake/build/lib/lean/LonelyRunner/ConstrainedMaximizer.olean": "443a61889184bd7fc7ea52a85ebcfa3fc0ba6f1e458b34824afb166812f38170",
    ".lake/build/lib/lean/LonelyRunner/FastRunnerInsertion.olean": "121edfbaed0d7b9fed32bacf891de838142988e48dcb4e7f2bed0c488ea49136",
    ".lake/build/lib/lean/LonelyRunner/RationalShiftOrbits.olean": "8194c5c6ac0b8495146728fcac70a6a1e9d317f9e7689c4759f22ed33c14340f",
    ".lake/build/lib/lean/LonelyRunner/SpecialSixthPhase.olean": "2e4951ab757b0fa22574e72381abd7be6cca5c971f9e38967cf24f0991532537",
    ".lake/build/lib/lean/LonelyRunner/ThirdShiftCollision.olean": "66e46c34df46e2a5350489acb7195991b6f332820fc6ec1535f40f4f186d4ef6",
    ".lake/build/lib/lean/LonelyRunner/ThirdShiftExceptions.olean": "d9c38deec30bda66014ed4d3e4de79fe5934f323e44e39771d353667ce47c7f9",
    ".lake/build/lib/lean/LonelyRunner/ThirdShiftRescues.olean": "f43015c4f1d03a823ae6987b979d1ea09a5d972e2ee8c7cc953c149d666d2e94",
    ".lake/build/lib/lean/LonelyRunner/ThirdShiftSeed.olean": "5305c6fd2737c6a611abdb710e5e7659bdccdb35c346b7e386c0733a592686be",
    ".lake/build/lib/lean/LonelyRunner/ThirdShiftSpecialSeed.olean": "f0c65f1e1d6e4f2982a645bdbc116d690f2508223de02e31ac4e479445536f58",
    ".lake/packages/mathlib/.lake/build/lib/lean/Mathlib/Algebra/Order/Floor/Ring.olean": "7321187722159060ef5bba522dcb0fa44c87cd3b6933c2cedfd27f63b35a9080",
    ".lake/packages/mathlib/.lake/build/lib/lean/Mathlib/Data/Fintype/Card.olean": "5574bbb259614ae208b68ffa3f0e2439d08e1316b7e1e60a42e677b4f73f9208",
    ".lake/packages/mathlib/.lake/build/lib/lean/Mathlib/Tactic.olean": "0534ef12e7aaf8ffbb6e520a91f922da4469d0dca2b54c87b4458e1faa28a6a2",
    ".lake/packages/mathlib/Mathlib/Algebra/Order/Floor/Ring.lean": "11f61aaf83c406b6b0accc6d34bdb4f77a1566fbdc63eae4d704728b9acf038c",
    ".lake/packages/mathlib/Mathlib/Data/Fintype/Card.lean": "2307820b0dee2080bd8245e268974bd02678d76067a6efc8878d004f7b8ed774",
    ".lake/packages/mathlib/Mathlib/Tactic.lean": "c6f2c548596b635a3d5c8aff8b19cbdeb60dd54e41bb89a1cd03b1a54d335fa5",
    "LonelyRunner/ConstrainedMaximizer.lean": "2ef07e6b83b8675a22184571c31d2a71dab9d5c072e3cd165cb8382957b46e92",
    "LonelyRunner/FastRunnerInsertion.lean": "dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5",
    "LonelyRunner/RationalShiftOrbits.lean": "cf615dd6c6b3cf091cd5d31ac641f4f994c1c50d95e0120c311d3ac129b88591",
    "LonelyRunner/SpecialSixthPhase.lean": "677372ee3dc86520051f4bcc037f685a3f5fd8748c737ef9e1d2bfc5ac0072d8",
    "LonelyRunner/ThirdShiftCollision.lean": "5b984687f89ea16bad34453d3c048ceb974f999af9cd1969f73d56ce30e13cec",
    "LonelyRunner/ThirdShiftExceptions.lean": "85590988cd0e104dc93fd51bc79aa326fe2799974eae426b7ea3336853872073",
    "LonelyRunner/ThirdShiftRescues.lean": "829db12405e64ad88da5501ddb167d650ad82cf92295a88fd2374d9e08281732",
    "LonelyRunner/ThirdShiftSeed.lean": "3c8b90583658df1cfdbe00e4444157e08d8ae7b4a74b986d5770e9f750429b46",
    "LonelyRunner/ThirdShiftSpecialSeed.lean": "ffbab991e23c45a1cd0abb2f692c30f35665f04ae5843a70898da00c69ab6187",
    "lake-manifest.json": "887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218",
    "lean-toolchain": "8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af",
    "research/astra-two-divisible-three-plan-review.md": "4d499c4477e80445646c6f82fcb72e36009ed1b9fc35b0023dd278f399598f71",
    "research/astra-two-divisible-three-reduction-plan.md": "07f27873785c463d7f9b2e8c2074510f42fcd973d07cc6e73ea62e5b3bac0ad6"
  },
  "launcher_after_sha256": "7abca32919611d1d6ee51f6f866555cb441e6fafaf902540c01500d9e8f994f8",
  "launcher_bytes": 8623,
  "launcher_sha256": "7abca32919611d1d6ee51f6f866555cb441e6fafaf902540c01500d9e8f994f8",
  "limits": {
    "address_space_bytes": 8589934592,
    "alarm_seconds": 60,
    "combined_stream_bytes": 262144,
    "cpu_seconds": [
      59,
      60
    ],
    "per_stream_bytes": 131072,
    "wall_seconds": 60.0
  },
  "probe_after_sha256": "41965aafbf96380684bcc2a55c6e470a9a4e6b48fe6b0bd57af396748b35ba7f",
  "probe_bytes": 2789,
  "probe_sha256": "41965aafbf96380684bcc2a55c6e470a9a4e6b48fe6b0bd57af396748b35ba7f",
  "runtime_env": {
    "LEAN_NUM_THREADS": "1",
    "LEAN_STACK_SIZE_KB": "65536"
  },
  "status": "passed",
  "stderr_base64": "",
  "stderr_bytes": 0,
  "stderr_sha256": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
  "stderr_utf8": "",
  "stdout_base64": "PHN0ZGluPjo5OjU6IHdhcm5pbmc6IFZhcmlhYmxlIG5hbWUgYGhzZWVkYCBpcyBub3QgZXhwbGljaXRseSByZWZlcmVuY2VkLgoKVGhlIGJpbmRpbmcgY2FuIGJlIHJlbW92ZWQgKGlmIHVudXNlZCkgb3IgbmFtZWQgYF9gIChpZiB1c2VkIGltcGxpY2l0bHkpLgoKTm90ZTogVGhpcyBsaW50ZXIgY2FuIGJlIGRpc2FibGVkIHdpdGggYHNldF9vcHRpb24gbGludGVyLnVudXNlZFZhcmlhYmxlcyBmYWxzZWAKPHN0ZGluPjoxMTo1OiB3YXJuaW5nOiBWYXJpYWJsZSBuYW1lIGBoZXhjZXB0aW9uc2AgaXMgbm90IGV4cGxpY2l0bHkgcmVmZXJlbmNlZC4KClRoZSBiaW5kaW5nIGNhbiBiZSByZW1vdmVkIChpZiB1bnVzZWQpIG9yIG5hbWVkIGBfYCAoaWYgdXNlZCBpbXBsaWNpdGx5KS4KCk5vdGU6IFRoaXMgbGludGVyIGNhbiBiZSBkaXNhYmxlZCB3aXRoIGBzZXRfb3B0aW9uIGxpbnRlci51bnVzZWRWYXJpYWJsZXMgZmFsc2VgCjxzdGRpbj46MTM6MTk6IHdhcm5pbmc6IFZhcmlhYmxlIG5hbWUgYGh1d2AgaXMgbm90IGV4cGxpY2l0bHkgcmVmZXJlbmNlZC4KClRoZSBiaW5kaW5nIGNhbiBiZSByZW1vdmVkIChpZiB1bnVzZWQpIG9yIG5hbWVkIGBfYCAoaWYgdXNlZCBpbXBsaWNpdGx5KS4KCk5vdGU6IFRoaXMgbGludGVyIGNhbiBiZSBkaXNhYmxlZCB3aXRoIGBzZXRfb3B0aW9uIGxpbnRlci51bnVzZWRWYXJpYWJsZXMgZmFsc2VgCjxzdGRpbj46MTQ6NTogd2FybmluZzogVmFyaWFibGUgbmFtZSBgaHVgIGlzIG5vdCBleHBsaWNpdGx5IHJlZmVyZW5jZWQuCgpUaGUgYmluZGluZyBjYW4gYmUgcmVtb3ZlZCAoaWYgdW51c2VkKSBvciBuYW1lZCBgX2AgKGlmIHVzZWQgaW1wbGljaXRseSkuCgpOb3RlOiBUaGlzIGxpbnRlciBjYW4gYmUgZGlzYWJsZWQgd2l0aCBgc2V0X29wdGlvbiBsaW50ZXIudW51c2VkVmFyaWFibGVzIGZhbHNlYAo8c3RkaW4+OjE1OjU6IHdhcm5pbmc6IFZhcmlhYmxlIG5hbWUgYGh3YCBpcyBub3QgZXhwbGljaXRseSByZWZlcmVuY2VkLgoKVGhlIGJpbmRpbmcgY2FuIGJlIHJlbW92ZWQgKGlmIHVudXNlZCkgb3IgbmFtZWQgYF9gIChpZiB1c2VkIGltcGxpY2l0bHkpLgoKTm90ZTogVGhpcyBsaW50ZXIgY2FuIGJlIGRpc2FibGVkIHdpdGggYHNldF9vcHRpb24gbGludGVyLnVudXNlZFZhcmlhYmxlcyBmYWxzZWAKPHN0ZGluPjoyMzo1OiB3YXJuaW5nOiBWYXJpYWJsZSBuYW1lIGBoc2VlZGAgaXMgbm90IGV4cGxpY2l0bHkgcmVmZXJlbmNlZC4KClRoZSBiaW5kaW5nIGNhbiBiZSByZW1vdmVkIChpZiB1bnVzZWQpIG9yIG5hbWVkIGBfYCAoaWYgdXNlZCBpbXBsaWNpdGx5KS4KCk5vdGU6IFRoaXMgbGludGVyIGNhbiBiZSBkaXNhYmxlZCB3aXRoIGBzZXRfb3B0aW9uIGxpbnRlci51bnVzZWRWYXJpYWJsZXMgZmFsc2VgCjxzdGRpbj46MjU6NTogd2FybmluZzogVmFyaWFibGUgbmFtZSBgaGV4Y2VwdGlvbnNgIGlzIG5vdCBleHBsaWNpdGx5IHJlZmVyZW5jZWQuCgpUaGUgYmluZGluZyBjYW4gYmUgcmVtb3ZlZCAoaWYgdW51c2VkKSBvciBuYW1lZCBgX2AgKGlmIHVzZWQgaW1wbGljaXRseSkuCgpOb3RlOiBUaGlzIGxpbnRlciBjYW4gYmUgZGlzYWJsZWQgd2l0aCBgc2V0X29wdGlvbiBsaW50ZXIudW51c2VkVmFyaWFibGVzIGZhbHNlYAo8c3RkaW4+OjI3OjE3OiB3YXJuaW5nOiBWYXJpYWJsZSBuYW1lIGBocmAgaXMgbm90IGV4cGxpY2l0bHkgcmVmZXJlbmNlZC4KClRoZSBiaW5kaW5nIGNhbiBiZSByZW1vdmVkIChpZiB1bnVzZWQpIG9yIG5hbWVkIGBfYCAoaWYgdXNlZCBpbXBsaWNpdGx5KS4KCk5vdGU6IFRoaXMgbGludGVyIGNhbiBiZSBkaXNhYmxlZCB3aXRoIGBzZXRfb3B0aW9uIGxpbnRlci51bnVzZWRWYXJpYWJsZXMgZmFsc2VgCjxzdGRpbj46Mjg6NTogd2FybmluZzogVmFyaWFibGUgbmFtZSBgaHNhZmVgIGlzIG5vdCBleHBsaWNpdGx5IHJlZmVyZW5jZWQuCgpUaGUgYmluZGluZyBjYW4gYmUgcmVtb3ZlZCAoaWYgdW51c2VkKSBvciBuYW1lZCBgX2AgKGlmIHVzZWQgaW1wbGljaXRseSkuCgpOb3RlOiBUaGlzIGxpbnRlciBjYW4gYmUgZGlzYWJsZWQgd2l0aCBgc2V0X29wdGlvbiBsaW50ZXIudW51c2VkVmFyaWFibGVzIGZhbHNlYAo8c3RkaW4+OjM4OjU6IHdhcm5pbmc6IFZhcmlhYmxlIG5hbWUgYGh4YCBpcyBub3QgZXhwbGljaXRseSByZWZlcmVuY2VkLgoKVGhlIGJpbmRpbmcgY2FuIGJlIHJlbW92ZWQgKGlmIHVudXNlZCkgb3IgbmFtZWQgYF9gIChpZiB1c2VkIGltcGxpY2l0bHkpLgoKTm90ZTogVGhpcyBsaW50ZXIgY2FuIGJlIGRpc2FibGVkIHdpdGggYHNldF9vcHRpb24gbGludGVyLnVudXNlZFZhcmlhYmxlcyBmYWxzZWAKPHN0ZGluPjo0NToyMTogd2FybmluZzogVmFyaWFibGUgbmFtZSBgaG5vdGAgaXMgbm90IGV4cGxpY2l0bHkgcmVmZXJlbmNlZC4KClRoZSBiaW5kaW5nIGNhbiBiZSByZW1vdmVkIChpZiB1bnVzZWQpIG9yIG5hbWVkIGBfYCAoaWYgdXNlZCBpbXBsaWNpdGx5KS4KCk5vdGU6IFRoaXMgbGludGVyIGNhbiBiZSBkaXNhYmxlZCB3aXRoIGBzZXRfb3B0aW9uIGxpbnRlci51bnVzZWRWYXJpYWJsZXMgZmFsc2VgCjxzdGRpbj46NDY6NTogd2FybmluZzogVmFyaWFibGUgbmFtZSBgaHhgIGlzIG5vdCBleHBsaWNpdGx5IHJlZmVyZW5jZWQuCgpUaGUgYmluZGluZyBjYW4gYmUgcmVtb3ZlZCAoaWYgdW51c2VkKSBvciBuYW1lZCBgX2AgKGlmIHVzZWQgaW1wbGljaXRseSkuCgpOb3RlOiBUaGlzIGxpbnRlciBjYW4gYmUgZGlzYWJsZWQgd2l0aCBgc2V0X29wdGlvbiBsaW50ZXIudW51c2VkVmFyaWFibGVzIGZhbHNlYAo8c3RkaW4+OjU0OjU6IHdhcm5pbmc6IFZhcmlhYmxlIG5hbWUgYGhzZWVkYCBpcyBub3QgZXhwbGljaXRseSByZWZlcmVuY2VkLgoKVGhlIGJpbmRpbmcgY2FuIGJlIHJlbW92ZWQgKGlmIHVudXNlZCkgb3IgbmFtZWQgYF9gIChpZiB1c2VkIGltcGxpY2l0bHkpLgoKTm90ZTogVGhpcyBsaW50ZXIgY2FuIGJlIGRpc2FibGVkIHdpdGggYHNldF9vcHRpb24gbGludGVyLnVudXNlZFZhcmlhYmxlcyBmYWxzZWAKPHN0ZGluPjo1Njo1OiB3YXJuaW5nOiBWYXJpYWJsZSBuYW1lIGBoZXhjZXB0aW9uc2AgaXMgbm90IGV4cGxpY2l0bHkgcmVmZXJlbmNlZC4KClRoZSBiaW5kaW5nIGNhbiBiZSByZW1vdmVkIChpZiB1bnVzZWQpIG9yIG5hbWVkIGBfYCAoaWYgdXNlZCBpbXBsaWNpdGx5KS4KCk5vdGU6IFRoaXMgbGludGVyIGNhbiBiZSBkaXNhYmxlZCB3aXRoIGBzZXRfb3B0aW9uIGxpbnRlci51bnVzZWRWYXJpYWJsZXMgZmFsc2VgCjxzdGRpbj46NTg6MTc6IHdhcm5pbmc6IFZhcmlhYmxlIG5hbWUgYGhyYCBpcyBub3QgZXhwbGljaXRseSByZWZlcmVuY2VkLgoKVGhlIGJpbmRpbmcgY2FuIGJlIHJlbW92ZWQgKGlmIHVudXNlZCkgb3IgbmFtZWQgYF9gIChpZiB1c2VkIGltcGxpY2l0bHkpLgoKTm90ZTogVGhpcyBsaW50ZXIgY2FuIGJlIGRpc2FibGVkIHdpdGggYHNldF9vcHRpb24gbGludGVyLnVudXNlZFZhcmlhYmxlcyBmYWxzZWAKPHN0ZGluPjo1OTo1OiB3YXJuaW5nOiBWYXJpYWJsZSBuYW1lIGBoeGAgaXMgbm90IGV4cGxpY2l0bHkgcmVmZXJlbmNlZC4KClRoZSBiaW5kaW5nIGNhbiBiZSByZW1vdmVkIChpZiB1bnVzZWQpIG9yIG5hbWVkIGBfYCAoaWYgdXNlZCBpbXBsaWNpdGx5KS4KCk5vdGU6IFRoaXMgbGludGVyIGNhbiBiZSBkaXNhYmxlZCB3aXRoIGBzZXRfb3B0aW9uIGxpbnRlci51bnVzZWRWYXJpYWJsZXMgZmFsc2VgCidMb25lbHlSdW5uZXIuZXhpc3RzX3RoaXJkX3NoaWZ0X29mX3R3b19iYWRfc2VlZGVkX2RpdmlzaWJsZScgZGVwZW5kcyBvbiBheGlvbXM6IFtwcm9wZXh0LCBDbGFzc2ljYWwuY2hvaWNlLCBRdW90LnNvdW5kXQonTG9uZWx5UnVubmVyLmV4aXN0c190aGlyZF9zaGlmdF9vZl9zYWZlX2V4Y2VwdGlvbl9zZWVkZWRfZGl2aXNpYmxlJyBkZXBlbmRzIG9uIGF4aW9tczogW3Byb3BleHQsCiBDbGFzc2ljYWwuY2hvaWNlLAogUXVvdC5zb3VuZF0KJ0xvbmVseVJ1bm5lci5jaXJjbGVOb3JtX3RoaXJkX3NoaWZ0X29mX3NwZWNpYWxfc2l4dGgnIGRlcGVuZHMgb24gYXhpb21zOiBbcHJvcGV4dCwgQ2xhc3NpY2FsLmNob2ljZSwgUXVvdC5zb3VuZF0KJ0xvbmVseVJ1bm5lci5leGlzdHNfdGhpcmRfc2hpZnRfZnJhY3RfZml2ZV9zaXh0aHMnIGRlcGVuZHMgb24gYXhpb21zOiBbcHJvcGV4dCwgQ2xhc3NpY2FsLmNob2ljZSwgUXVvdC5zb3VuZF0KJ0xvbmVseVJ1bm5lci5leGlzdHNfdGhpcmRfc2hpZnRfb2Zfc3BlY2lhbF9zaXh0aF9zZWVkZWRfZGl2aXNpYmxlJyBkZXBlbmRzIG9uIGF4aW9tczogW3Byb3BleHQsCiBDbGFzc2ljYWwuY2hvaWNlLAogUXVvdC5zb3VuZF0K",
  "stdout_bytes": 4314,
  "stdout_sha256": "70e269dfe46438d0c76407142c48cef69f6ff91d870054b27d300fb7e0fd7696",
  "stdout_utf8": "<stdin>:9:5: warning: Variable name `hseed` is not explicitly referenced.\n\nThe binding can be removed (if unused) or named `_` (if used implicitly).\n\nNote: This linter can be disabled with `set_option linter.unusedVariables false`\n<stdin>:11:5: warning: Variable name `hexceptions` is not explicitly referenced.\n\nThe binding can be removed (if unused) or named `_` (if used implicitly).\n\nNote: This linter can be disabled with `set_option linter.unusedVariables false`\n<stdin>:13:19: warning: Variable name `huw` is not explicitly referenced.\n\nThe binding can be removed (if unused) or named `_` (if used implicitly).\n\nNote: This linter can be disabled with `set_option linter.unusedVariables false`\n<stdin>:14:5: warning: Variable name `hu` is not explicitly referenced.\n\nThe binding can be removed (if unused) or named `_` (if used implicitly).\n\nNote: This linter can be disabled with `set_option linter.unusedVariables false`\n<stdin>:15:5: warning: Variable name `hw` is not explicitly referenced.\n\nThe binding can be removed (if unused) or named `_` (if used implicitly).\n\nNote: This linter can be disabled with `set_option linter.unusedVariables false`\n<stdin>:23:5: warning: Variable name `hseed` is not explicitly referenced.\n\nThe binding can be removed (if unused) or named `_` (if used implicitly).\n\nNote: This linter can be disabled with `set_option linter.unusedVariables false`\n<stdin>:25:5: warning: Variable name `hexceptions` is not explicitly referenced.\n\nThe binding can be removed (if unused) or named `_` (if used implicitly).\n\nNote: This linter can be disabled with `set_option linter.unusedVariables false`\n<stdin>:27:17: warning: Variable name `hr` is not explicitly referenced.\n\nThe binding can be removed (if unused) or named `_` (if used implicitly).\n\nNote: This linter can be disabled with `set_option linter.unusedVariables false`\n<stdin>:28:5: warning: Variable name `hsafe` is not explicitly referenced.\n\nThe binding can be removed (if unused) or named `_` (if used implicitly).\n\nNote: This linter can be disabled with `set_option linter.unusedVariables false`\n<stdin>:38:5: warning: Variable name `hx` is not explicitly referenced.\n\nThe binding can be removed (if unused) or named `_` (if used implicitly).\n\nNote: This linter can be disabled with `set_option linter.unusedVariables false`\n<stdin>:45:21: warning: Variable name `hnot` is not explicitly referenced.\n\nThe binding can be removed (if unused) or named `_` (if used implicitly).\n\nNote: This linter can be disabled with `set_option linter.unusedVariables false`\n<stdin>:46:5: warning: Variable name `hx` is not explicitly referenced.\n\nThe binding can be removed (if unused) or named `_` (if used implicitly).\n\nNote: This linter can be disabled with `set_option linter.unusedVariables false`\n<stdin>:54:5: warning: Variable name `hseed` is not explicitly referenced.\n\nThe binding can be removed (if unused) or named `_` (if used implicitly).\n\nNote: This linter can be disabled with `set_option linter.unusedVariables false`\n<stdin>:56:5: warning: Variable name `hexceptions` is not explicitly referenced.\n\nThe binding can be removed (if unused) or named `_` (if used implicitly).\n\nNote: This linter can be disabled with `set_option linter.unusedVariables false`\n<stdin>:58:17: warning: Variable name `hr` is not explicitly referenced.\n\nThe binding can be removed (if unused) or named `_` (if used implicitly).\n\nNote: This linter can be disabled with `set_option linter.unusedVariables false`\n<stdin>:59:5: warning: Variable name `hx` is not explicitly referenced.\n\nThe binding can be removed (if unused) or named `_` (if used implicitly).\n\nNote: This linter can be disabled with `set_option linter.unusedVariables false`\n'LonelyRunner.exists_third_shift_of_two_bad_seeded_divisible' depends on axioms: [propext, Classical.choice, Quot.sound]\n'LonelyRunner.exists_third_shift_of_safe_exception_seeded_divisible' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'LonelyRunner.circleNorm_third_shift_of_special_sixth' depends on axioms: [propext, Classical.choice, Quot.sound]\n'LonelyRunner.exists_third_shift_fract_five_sixths' depends on axioms: [propext, Classical.choice, Quot.sound]\n'LonelyRunner.exists_third_shift_of_special_sixth_seeded_divisible' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n",
  "timed_out": false,
  "wall_seconds": 1.8493230769818183
}
```
<!-- END RECEIPT -->

Complete Lean stdout, 4314 bytes including final newline:

<!-- BEGIN STDOUT -->
```text
<stdin>:9:5: warning: Variable name `hseed` is not explicitly referenced.

The binding can be removed (if unused) or named `_` (if used implicitly).

Note: This linter can be disabled with `set_option linter.unusedVariables false`
<stdin>:11:5: warning: Variable name `hexceptions` is not explicitly referenced.

The binding can be removed (if unused) or named `_` (if used implicitly).

Note: This linter can be disabled with `set_option linter.unusedVariables false`
<stdin>:13:19: warning: Variable name `huw` is not explicitly referenced.

The binding can be removed (if unused) or named `_` (if used implicitly).

Note: This linter can be disabled with `set_option linter.unusedVariables false`
<stdin>:14:5: warning: Variable name `hu` is not explicitly referenced.

The binding can be removed (if unused) or named `_` (if used implicitly).

Note: This linter can be disabled with `set_option linter.unusedVariables false`
<stdin>:15:5: warning: Variable name `hw` is not explicitly referenced.

The binding can be removed (if unused) or named `_` (if used implicitly).

Note: This linter can be disabled with `set_option linter.unusedVariables false`
<stdin>:23:5: warning: Variable name `hseed` is not explicitly referenced.

The binding can be removed (if unused) or named `_` (if used implicitly).

Note: This linter can be disabled with `set_option linter.unusedVariables false`
<stdin>:25:5: warning: Variable name `hexceptions` is not explicitly referenced.

The binding can be removed (if unused) or named `_` (if used implicitly).

Note: This linter can be disabled with `set_option linter.unusedVariables false`
<stdin>:27:17: warning: Variable name `hr` is not explicitly referenced.

The binding can be removed (if unused) or named `_` (if used implicitly).

Note: This linter can be disabled with `set_option linter.unusedVariables false`
<stdin>:28:5: warning: Variable name `hsafe` is not explicitly referenced.

The binding can be removed (if unused) or named `_` (if used implicitly).

Note: This linter can be disabled with `set_option linter.unusedVariables false`
<stdin>:38:5: warning: Variable name `hx` is not explicitly referenced.

The binding can be removed (if unused) or named `_` (if used implicitly).

Note: This linter can be disabled with `set_option linter.unusedVariables false`
<stdin>:45:21: warning: Variable name `hnot` is not explicitly referenced.

The binding can be removed (if unused) or named `_` (if used implicitly).

Note: This linter can be disabled with `set_option linter.unusedVariables false`
<stdin>:46:5: warning: Variable name `hx` is not explicitly referenced.

The binding can be removed (if unused) or named `_` (if used implicitly).

Note: This linter can be disabled with `set_option linter.unusedVariables false`
<stdin>:54:5: warning: Variable name `hseed` is not explicitly referenced.

The binding can be removed (if unused) or named `_` (if used implicitly).

Note: This linter can be disabled with `set_option linter.unusedVariables false`
<stdin>:56:5: warning: Variable name `hexceptions` is not explicitly referenced.

The binding can be removed (if unused) or named `_` (if used implicitly).

Note: This linter can be disabled with `set_option linter.unusedVariables false`
<stdin>:58:17: warning: Variable name `hr` is not explicitly referenced.

The binding can be removed (if unused) or named `_` (if used implicitly).

Note: This linter can be disabled with `set_option linter.unusedVariables false`
<stdin>:59:5: warning: Variable name `hx` is not explicitly referenced.

The binding can be removed (if unused) or named `_` (if used implicitly).

Note: This linter can be disabled with `set_option linter.unusedVariables false`
'LonelyRunner.exists_third_shift_of_two_bad_seeded_divisible' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.exists_third_shift_of_safe_exception_seeded_divisible' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'LonelyRunner.circleNorm_third_shift_of_special_sixth' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.exists_third_shift_fract_five_sixths' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.exists_third_shift_of_special_sixth_seeded_divisible' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
```
<!-- END STDOUT -->

Complete Lean stderr is the empty byte string, 0 bytes, SHA-256
`e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.
Full stdout SHA-256 is
`70e269dfe46438d0c76407142c48cef69f6ff91d870054b27d300fb7e0fd7696`.

Both seeded rescue adapters and the final special-phase wrapper preserve
arbitrary real t and return one common k for every Fin 5 label. The scalar
safety theorem includes every natural d, including zero; exact transport
retains 3∤d. Closed endpoint safety, exception-cardinality hypotheses, and
strict initial badness remain intact. All public and private source proofs
are accepted within this scope.

Root's independent full read and exact replay remain next for this batch.
These declarations do not supply an unconditioned special seed, a complete
two-divisible proof, an unrestricted five-moving sixth-margin theorem, H8,
a canonical new runner count, or full Lonely Runner resolution.

