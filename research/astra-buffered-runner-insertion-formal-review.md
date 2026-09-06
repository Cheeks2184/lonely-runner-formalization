# Independent review of generic buffered runner insertion

2026-09-05, assigned Astra/xhigh reviewer `/root/mss_published_bound_audit`.
Source checkpoint `5a621b8065fdbc69694168e6d406824b1fa23cff`. Requested routing
is not independently attested runtime metadata. Project configuration, workflow,
policy and active state were read; the workflow validator passed. Only this
review is owned. Other manuscripts, Lean, Git, state and the active shared
cache are preserved. Unfinished five-runner callers are outside this review.

**Accepted: the exact generic contract is sound, and the independent kernel
contract/boundary probe passed. No source correction is required.** The frozen
source is `LonelyRunner/BufferedRunnerInsertion.lean`, SHA-256
`a135f5c41ead308a2a4250f07535bf3e32f78c88599497bf79bb632cd1e05f0a`.
The guarded stdin probe and full source review are recorded below. This core
is a conditional insertion theorem, not uniform mixed supply or LRC.

## Source proof and exact scope

The old tuple has arbitrary positive real speeds on nonempty `Fin n`;
injectivity, integrality, sorting, gcd and lower-count hypotheses are absent.
The new speed and seed are positive real numbers. The old target obeys
`0<delta<1/2`, the new target obeys `0<=beta<=1/2`, and every supplied seed
margin exceeds delta and is attained as a closed lower bound at the same seed.
No separate upper bound on those margins is needed: the actual circle-norm
seed premise already bounds them by one half.

For each label i, the proof fixes its integer floor and defines its closed
weak phase band. `int_band_of_circleNorm_ge` converts the supplied norm margin
to both strong seed-band inequalities; positivity of the speed allows division
without reversing order. Finite maximization of the left endpoints and
minimization of the right endpoints yield labels p,q. Both chosen bands
contain the seed, so their intersection is nonempty.

If p=q, the exact interval width is `(1-2*delta)/speeds p`, and the supplied
same-owner hypothesis gives the required width `2*beta/newSpeed`. If p and
q are different labels, the left and right seed buffers respectively are at
least `(margins p-delta)/speeds p` and `(margins q-delta)/speeds q`. Adding
them and applying the pair hypothesis gives the same closed width bound.
Ties need no uniqueness: any maximizing/minimizing labels satisfy the argument.
The pair test is on labels, so repeated speed values are permitted. It may
be stronger than necessary for a repeated tuple, but is never used to infer
distinct values. At n=1 the pair condition is vacuous and the same-owner
branch suffices.

At the midpoint phase, `exists_small_shift_circleNorm_ge` supplies a phase
shift of magnitude at most beta. Division by the positive new speed gives a
time shift of magnitude at most beta/newSpeed, no larger than half the
interval width. Hence the shifted time belongs to every original weak band.
The exact phase identity proves the new closed margin, and the reverse band
lemma proves every old closed margin at that same time. Equality at the width
threshold is preserved throughout. The beta=0 and beta=1/2 endpoints use the
actual closed hypotheses of the small-shift helper.

Positive final time follows from nonnegative integer floors of the positive
seed phases and the strictly positive old target: the maximal left endpoint
is positive, and the final time is at least that endpoint. There is no use of
integer-period normalization, which would be invalid for arbitrary real speeds.
The theorem does not require the new speed to exceed any old speed, and its
conclusion makes no unproved claim about the distance from the original seed.

The forward floor-band helper is defined in `PairSumCompleteness.lean`.
The reverse helper `circleNorm_ge_of_int_band` is defined in
`StructuredClasses.lean` and imported transitively. I read both proofs and
the small-shift proof. Their closed bounds and unrestricted integer lifts
match the uses above; no conjecture premise is obtained merely from an import.

## Independent exact-contract and boundary probe

The sole Python block guards the frozen source, helpers, implementation report,
prior accepted plan review and pinned dependency descriptors before and after
running only `lake env lean --stdin`. It compiles the exact generic type and
four fixed applications: n=1 at same-width equality with beta=1/2; the unequal
margins (1/4,1/4,1/3) at speeds (4,5,11), seed 2/15 and new speed 24; repeated
old speeds at beta=0 with a smaller new speed; and repeated tied speeds with
beta=1/2 and equality in both width tests. These are kernel applications of
the generic theorem, not numerical search or execution of a noncomputable
witness function. Four explicit axiom reports cover the core and its helpers.

```python
from hashlib import sha256
from pathlib import Path
import json, os, re, subprocess

guards = {
    'LonelyRunner/BufferedRunnerInsertion.lean': 'a135f5c41ead308a2a4250f07535bf3e32f78c88599497bf79bb632cd1e05f0a',
    'LonelyRunner/PairSumCompleteness.lean': '838a3bcec806b0e9d01cd117e64e5348de58a05127a3f7bef5dbe2d879ff292f',
    'LonelyRunner/StructuredClasses.lean': '5328a7a88d2b42f86ffc3f0f0418ca22c761219e8fa3e5822bda5a18ac286e8c',
    'LonelyRunner/FastRunnerInsertion.lean': 'dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5',
    'research/astra-buffered-runner-insertion-implementation.md': 'c898040cb44e753bce8136514976328de4581e8d3200c9a809dc300f9792656a',
    'research/astra-five-runner-mixed-structure-review.md': 'ce3e6ecf5bb454ece9e9b71901db9504556a5ecd5c63888e3cb5a963fea9ff5f',
    'lean-toolchain': '8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af',
    'lake-manifest.json': '887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218',
}
for path, digest in guards.items():
    assert sha256(Path(path).read_bytes()).hexdigest() == digest, path
review = Path('research/astra-buffered-runner-insertion-formal-review.md').read_text()
fence = chr(96)*3
blocks = re.findall(rf'^{fence}lean\n(.*?)^{fence}[ \t]*$', review, re.M | re.S)
assert len(blocks) == 1
lean = blocks[0]
assert len(re.findall(r'^example\b', lean, re.M)) == 5
env = dict(os.environ)
env['PATH'] = '/home/joshua/.elan/bin:' + env.get('PATH', '')
proc = subprocess.run(['lake','env','lean','--stdin'], input=lean,
    text=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, env=env)
print(proc.stdout, end='')
assert proc.returncode == 0, proc.returncode
reports = re.findall(r"'([^']+)' depends on axioms: \[([^\]]*)\]", proc.stdout)
expected = {
    'LonelyRunner.bufferedRunnerInsertion',
    'LonelyRunner.int_band_of_circleNorm_ge',
    'LonelyRunner.circleNorm_ge_of_int_band',
    'LonelyRunner.exists_small_shift_circleNorm_ge',
}
assert {name for name,_ in reports} == expected and len(reports) == 4
allowed = {'propext','Classical.choice','Quot.sound'}
for name, axioms in reports:
    assert {a.strip() for a in axioms.split(',')} <= allowed, (name,axioms)
for path, digest in guards.items():
    assert sha256(Path(path).read_bytes()).hexdigest() == digest, path
print(json.dumps({
    'result':'PASS',
    'source_guards':len(guards),
    'kernel_examples':5,
    'axiom_reports':len(reports),
    'lean_exit_code':proc.returncode,
    'lean_stdin_sha256':sha256(lean.encode()).hexdigest(),
    'lean_stdout_sha256':sha256(proc.stdout.encode()).hexdigest(),
}, sort_keys=True))
```

```lean
import LonelyRunner.BufferedRunnerInsertion

open LonelyRunner

example :
    ∀ {n : ℕ}, 0 < n →
    ∀ (speeds : Fin n → ℝ), (∀ i, 0 < speeds i) →
    ∀ (seed : ℝ), 0 < seed →
    ∀ (newSpeed : ℝ), 0 < newSpeed →
    ∀ (δ β : ℝ), 0 < δ → δ < (1 : ℝ) / 2 →
      0 ≤ β → β ≤ (1 : ℝ) / 2 →
    ∀ (margins : Fin n → ℝ), (∀ i, δ < margins i) →
      (∀ i, margins i ≤ circleNorm (seed * speeds i)) →
      (∀ i, 2 * β / newSpeed ≤ (1 - 2 * δ) / speeds i) →
      (∀ i j, i ≠ j →
        2 * β / newSpeed ≤ (margins i - δ) / speeds i +
          (margins j - δ) / speeds j) →
    ∃ time : ℝ, 0 < time ∧ β ≤ circleNorm (time * newSpeed) ∧
      ∀ i, δ ≤ circleNorm (time * speeds i) :=
  @bufferedRunnerInsertion

private theorem halfGood : (1 / 2 : ℝ) ≤ circleNorm (1 / 2) := by
  exact circleNorm_ge_of_int_band 0 (1/2) (1/2)
    (by norm_num) (by norm_num) (by norm_num) (by norm_num)

-- One old coordinate, beta=1/2, with exact same-owner width equality.
example : ∃ t : ℝ, 0 < t ∧ (1/2 : ℝ) ≤ circleNorm (t*2) ∧
    ∀ i : Fin 1, (1/4 : ℝ) ≤ circleNorm (t * (fun _ : Fin 1 => (1 : ℝ)) i) := by
  refine bufferedRunnerInsertion (by decide) (fun _ : Fin 1 => (1 : ℝ))
    (by intro i; norm_num) (1/2) (by norm_num) 2 (by norm_num)
    (1/4) (1/2) (by norm_num) (by norm_num) (by norm_num) (by norm_num)
    (fun _ => 1/2) ?_ ?_ ?_ ?_
  · intro i; norm_num
  · intro i; simpa using halfGood
  · intro i; norm_num
  · intro i j hij
    exact (hij (Subsingleton.elim i j)).elim

-- Three unequal margins, using an explicit mixed lower seed.
example : ∃ t : ℝ, 0 < t ∧ (1/4 : ℝ) ≤ circleNorm (t*24) ∧
    ∀ i : Fin 3, (1/5 : ℝ) ≤ circleNorm (t * (![4,5,11] : Fin 3 → ℝ) i) := by
  refine bufferedRunnerInsertion (by decide) (![4,5,11] : Fin 3 → ℝ)
    (by intro i; fin_cases i <;> norm_num)
    (2/15) (by norm_num) 24 (by norm_num)
    (1/5) (1/4) (by norm_num) (by norm_num) (by norm_num) (by norm_num)
    (![1/4,1/4,1/3] : Fin 3 → ℝ) ?_ ?_ ?_ ?_
  · intro i; fin_cases i <;> norm_num
  · intro i
    fin_cases i
    · apply circleNorm_ge_of_int_band 0 <;> norm_num
    · apply circleNorm_ge_of_int_band 0 <;> norm_num
    · apply circleNorm_ge_of_int_band 1 <;> norm_num
  · intro i; fin_cases i <;> norm_num
  · intro i j hij
    fin_cases i <;> fin_cases j <;>
      first | exact (hij rfl).elim | norm_num

-- beta=0 and a new speed smaller than the repeated old speed.
example : ∃ t : ℝ, 0 < t ∧ (0 : ℝ) ≤ circleNorm (t*(1/7)) ∧
    ∀ i : Fin 2, (1/4 : ℝ) ≤ circleNorm (t * (fun _ : Fin 2 => (1 : ℝ)) i) := by
  refine bufferedRunnerInsertion (by decide) (fun _ : Fin 2 => (1 : ℝ))
    (by intro i; norm_num) (1/2) (by norm_num) (1/7) (by norm_num)
    (1/4) 0 (by norm_num) (by norm_num) (by norm_num) (by norm_num)
    (fun _ => 1/2) ?_ ?_ ?_ ?_
  · intro i; norm_num
  · intro i; simpa using halfGood
  · intro i; norm_num
  · intro i j _; norm_num

-- Repeated speeds, tied endpoints, beta=1/2 and exact pair-width equality.
example : ∃ t : ℝ, 0 < t ∧ (1/2 : ℝ) ≤ circleNorm (t*2) ∧
    ∀ i : Fin 2, (1/4 : ℝ) ≤ circleNorm (t * (fun _ : Fin 2 => (1 : ℝ)) i) := by
  refine bufferedRunnerInsertion (by decide) (fun _ : Fin 2 => (1 : ℝ))
    (by intro i; norm_num) (1/2) (by norm_num) 2 (by norm_num)
    (1/4) (1/2) (by norm_num) (by norm_num) (by norm_num) (by norm_num)
    (fun _ => 1/2) ?_ ?_ ?_ ?_
  · intro i; norm_num
  · intro i; simpa using halfGood
  · intro i; norm_num
  · intro i j _; norm_num

#print axioms LonelyRunner.bufferedRunnerInsertion
#print axioms LonelyRunner.int_band_of_circleNorm_ge
#print axioms LonelyRunner.circleNorm_ge_of_int_band
#print axioms LonelyRunner.exists_small_shift_circleNorm_ge
```

## Verification and disposition

The corrected focused probe terminated with exit 0 (session 81686). All
eight source/report/dependency guards passed before and after execution.
The exact theorem type and four fixed applications compiled; each of the
four axiom reports listed only propext, Classical.choice and Quot.sound.
This establishes the stated generic contract without adding a conjecture
premise. It is not verification of the unfinished five-runner caller modules.

The initial version of the n3 test used `norm_num at hij ⊢` after splitting
both finite labels. It produced three "No goals to be solved" diagnostics
when the impossible diagonal hypothesis had already closed its goal.
Session 66307 exited 1; its outer stdout capture hid those diagnostics.
The identical failed probe was rerun once with capture printed on failure
(session 47457, exit 1). Only this review's test tactic was corrected to
eliminate the diagonal cases explicitly. The theorem source and the other
test obligations were unchanged. The final Lean block above is the
exact successful stdin; no post-success test edits were made.

Source compilation and the 2977-job named build are worker-reported terminal
results in the guarded implementation report, not additional builds performed
by this reviewer. Root separately reported its exact-type/axiom/n=1 probe
success. The final integration build and full trust audit remain root's later
responsibility after the caller modules are ready. This review accepts only
the frozen generic core and its prerequisite contracts.

Executed reviewer command:

```bash
python3 -B - <<'PY'
from pathlib import Path
from hashlib import sha256
from contextlib import redirect_stdout
import re,io
fence=chr(96)*3
raw=Path('research/astra-buffered-runner-insertion-formal-review.md').read_text()
blocks=re.findall(rf'^{fence}python\n(.*?)^{fence}[ \t]*$',raw,re.M|re.S)
assert len(blocks)==1
out=io.StringIO()
try:
 with redirect_stdout(out):
  exec(compile(blocks[0],'buffered-core-independent-probe','exec'),{})
finally:
 print(out.getvalue(),end='')
print('program_sha256='+sha256(blocks[0].encode()).hexdigest())
print('stdout_sha256='+sha256(out.getvalue().encode()).hexdigest())
PY
```

Frozen evidence hashes:

| Artifact | SHA-256 |
| --- | --- |
| Sole Python program | 7559eed92c6f3a20010315b7a575a810131e0426466d1ca3cb1a0109a354beac |
| Python stdout, including final newline | c02252be56235e871cadb4caa2c48a23062b3d8fcbf15d9b6da3565da4d89411 |
| Lean stdin | 8c22ad804b84e82fe5dd9fc44d21b67c8de1db54ab219b3fb65e26f598549225 |
| Raw Lean stdout/stderr | 07e7be9f925620f3cc07e94d53dcb40f9f675a5a0ca60f73563c293cd2832c6a |

Exact Python stdout:

```text
'LonelyRunner.bufferedRunnerInsertion' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.int_band_of_circleNorm_ge' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.circleNorm_ge_of_int_band' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.exists_small_shift_circleNorm_ge' depends on axioms: [propext, Classical.choice, Quot.sound]
{"axiom_reports": 4, "kernel_examples": 5, "lean_exit_code": 0, "lean_stdin_sha256": "8c22ad804b84e82fe5dd9fc44d21b67c8de1db54ab219b3fb65e26f598549225", "lean_stdout_sha256": "07e7be9f925620f3cc07e94d53dcb40f9f675a5a0ca60f73563c293cd2832c6a", "result": "PASS", "source_guards": 8}
```

Final source/program/stored-output guards and the workflow validator passed.
Only this review was written; no Lean source, other report, Git/state,
dependency or cache edits, cleanup, full build or enumeration were performed.
All reviewer commands stopped after final readback. The final review hash is
reported externally at handoff to avoid a self-referential digest.

**Final disposition: accepted, no mathematical or source correction required.**
The generic positive-real finite-band insertion API is ready for the separately
owned callers. No root integration, N5 specialization, determinant refinement,
global K5, or unrestricted LRC conclusion is certified by this review.
