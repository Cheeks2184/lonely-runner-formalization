# Independent review of the five-runner buffered implementation

2026-09-05. Assigned Astra/xhigh reviewer `/root/mss_published_bound_audit`;
requested routing is not independently attested runtime metadata. Source
checkpoint `5a621b8065fdbc69694168e6d406824b1fa23cff`. The current project
configuration, workflow, policy and active state were read; the structural
validator passed. Only this review is owned. All source, prior evidence, Git,
state, and the active shared cache are preserved. No enumeration is performed.

**Accepted: the frozen exception and parameter proofs satisfy their intended
contracts. Independent kernel checks and final integration verification passed;
no mathematical or source correction is required.**
This review binds the accepted generic core review
`e43fda02baa1ec87a67a27d713ea0e148a7f634a2729e77677195fd24c0c59d5`
and unchanged core source
`a135f5c41ead308a2a4250f07535bf3e32f78c88599497bf79bb632cd1e05f0a`;
its full mathematics is not repeated here. These are sufficient stationary
positive-natural five-total-runner classes, not a universal canonical N5
result, global K5, or unrestricted LRC.

## Predicate and exceptional-family contract

`FiveRunnerMixed a b c H` is exactly one positive real time with closed
margins `(1/5,1/5,1/5,1/4)` on those original four speeds. The definition
itself does not impose sorting; the public theorems establish the required
positive ordering in their hypotheses. In particular H is the actual maximum
in the two parameter theorems and in the exceptional family `H>3a>0`.

For the normalized `(1,2,3,K)` family, `K>3` is the only public premise.
If four does not divide K, time 1/4 leaves each lower norm at least one
quarter and the nonzero residue of K modulo four has norm at least one
quarter. If four divides K but five does not, all four nonzero residues
modulo five are handled: residues 1,4 use time 2/5; residues 2,3 use time
1/5. All lower norms are at least one fifth, and the fastest norm is two
fifths. The source uses the existing exact natural-residue-to-circle bridge,
with its modulus positivity and nonzero-residue premises retained.

If both divide K, the proof obtains `K=20d` with `d>=1` and uses
`t=1/4+1/(80d)`. Each lower phase lies in the actual closed band `[1/5,4/5]`;
the third upper bound is the tightest, and `3/(80d)<=3/80<1/20` suffices.
The fastest phase is exactly the integer `5d` plus one quarter. Positivity,
natural/real casts and denominators are checked in the source; no bounded
search or incomplete residue case is hidden in this branch.

For coprime positive A,K with `K>3A`, A=1 uses that theorem. At A>=2 the
source calls the coprime grid with modulus A and multiplier K, using
`Nat.Coprime K A`. The time `s=1/(4A)+k/A` has lower phases
`k+1/4,2k+1/2,3k+3/4`, while its fastest phase is the same grid phase
`K/(4A)+kK/A`. The mesh lower bound `(A-1)/(2A)>=1/4` is closed at A=2.
Since the supplied integer k need not be positive, the proof normalizes s to
`s+1-floor(s)>0`. Its difference from s is an integer, and the source proves
phase preservation for every natural speed, including K, at the same new time.

The public `fiveRunnerMixed_exceptional a H` then sets `g=gcd(a,H)>0`,
`A=a/g`, `K=H/g`. Divisibility gives exact factorizations `a=gA,H=gK`;
positivity and order transport give `A>0,K>3A`, and the quotients are coprime.
After the normalized witness u, time `u/g` is positive and has exactly the
same four phases at `(a,2a,3a,H)` as u has at `(A,2A,3A,K)`. The four phase
identities are proved separately in the source. There is no public gcd,
primitive, divisibility, strict-seed, height-cutoff or lower-count premise.

## Parameter specialization and coarse boundary

The main public assumptions are exactly natural `0<a<b<c<H` and

    10ab <= H(a+b),       30bc <= H(3c+8b).

The lower exception is covered internally by the preceding unconditional
family theorem. Otherwise the exact C4 mixed classification supplies one
positive seed with margins `(1/4,1/4,1/3)`. The generic core is instantiated
with three old coordinates, old target one fifth, and new target one quarter.
Every positivity, seed and strict-slack obligation follows from that data.

The same-owner width `3/(5w)` dominates `1/(2H)` for each `w<=c<H`.
The two explicit pair inequalities are precisely the rational width bounds
for (a,b) and (b,c), with positive denominators. The remaining (a,c) case
uses `a<b` to show `1/(20b)<=1/(20a)`, retaining the c-buffer `2/(15c)`.
I checked all nine ordered `Fin 3` cases: three diagonal contradictions and
both orientations of each of the three actual pairs. No coordinate is lost,
no stronger uniform seed is assumed, and every norm uses the returned common
time. All bounds remain closed, including equality in the (a,b) condition.

The coarse theorem retains only `22b<=3H` in addition to positivity/order.
Its first comparison uses `5b<=H` and `a<b`; its second adds
`22bc<=3Hc` and `8bc<=8bH` to obtain `30bc<=H(3c+8b)`.
There is no off-by-one natural division or strengthened strict inequality.
The core, C4 classification and scalar arithmetic supply the entire proof;
no external K5, H5 or global conjecture premise enters the public contracts.

The root imports all three new modules, and the audit imports the root and
prints each of the five new public declarations. The existing
`LonelyRunner.fourRunners` remains the unconditional arbitrary-real,
any-chosen-label Fin4 statement; the compatibility example below checks it.
The new public N5 classes remain stationary sorted natural classes. They do
not include a chosen-runner bridge or exhaust all positive-natural quadruples.

## Guarded reproducible kernel probe

The sole Python block checks exact file hashes, root/audit connectivity, the
full predicate and five audited public types, unchanged fourRunners, and ten
fixed theorem applications. Five are the requested scaled-grid, scaled-A1,
new-parameter, coarse-equality and pair-equality controls. Five more check
the four normalized nonzero modulo-five cases and the 20-divisible branch.
These are kernel theorem applications, not evaluation of a noncomputable
witness or tuple enumeration. The positive-time and closed-margin predicate
is independently expanded by a definitional equivalence example.

```python
from hashlib import sha256
from pathlib import Path
import json, os, re, subprocess

guards = {
    'LonelyRunner/FiveRunnerMixed.lean': '1e27f19d8906ee0d71b452758a38a7c44fff54e0b1b3c1e08dd5354921eb1eb0',
    'LonelyRunner/FiveRunnerBuffered.lean': '70f690a2300e122da3e9646e48d2f4e9c6af630c16da89d403e8508cb16b6d04',
    'LonelyRunner.lean': '0568c0f96dc4c7612d27f39673a9770ce9b780e020b7d6eb4b1268296eb069df',
    'LonelyRunner/AxiomAudit.lean': '699818b850898afe849785ffb6aae5ab3dc927cd58263f6e477389965c41ebd1',
    'LonelyRunner/BufferedRunnerInsertion.lean': 'a135f5c41ead308a2a4250f07535bf3e32f78c88599497bf79bb632cd1e05f0a',
    'research/astra-buffered-runner-insertion-formal-review.md': 'e43fda02baa1ec87a67a27d713ea0e148a7f634a2729e77677195fd24c0c59d5',
    'research/astra-five-runner-exception-implementation.md': '9126d28b636281e6c9177f06c60792fd8b0b9266b8968c4785d258c38efbbe3c',
    'research/astra-five-runner-buffered-implementation.md': 'deacc4c6a30b8a0054ace8b39d6e031b1241428a7e890b7f60e5175a67c6e8f1',
    'LonelyRunner/FourRunnerCanonical.lean': '353b116d04d464fb9aedb92437e7f56168992e087a862f934044bc9062761c38',
    'LonelyRunner/FourRunnerMixed.lean': 'ae47b419c5b4cebfa72a325bdb50cd32e03444c39850a74b885037d83e312a5c',
    'LonelyRunner/DivisorInsertion.lean': '212fa6d879bab6d70f09a4a43b2027b96724b5e5ac4a22cdf4b368509973166f',
    'LonelyRunner/PivotResidues.lean': '362da5ab923f22e900ae7ac821dd4cf4aab91dfe70889987bc9e5a05d19c276a',
    'LonelyRunner/StructuredClasses.lean': '5328a7a88d2b42f86ffc3f0f0418ca22c761219e8fa3e5822bda5a18ac286e8c',
    'lean-toolchain': '8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af',
    'lake-manifest.json': '887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218',
}
for path, digest in guards.items():
    assert sha256(Path(path).read_bytes()).hexdigest() == digest, path

# Verify source import direction without importing the global audit output.
root_imports = set(re.findall(r'^import (.+)$', Path('LonelyRunner.lean').read_text(), re.M))
for module in ('LonelyRunner.BufferedRunnerInsertion','LonelyRunner.FiveRunnerMixed','LonelyRunner.FiveRunnerBuffered'):
    assert module in root_imports
audit = Path('LonelyRunner/AxiomAudit.lean').read_text()
assert 'import LonelyRunner\n' in audit
names = (
    'LonelyRunner.bufferedRunnerInsertion',
    'LonelyRunner.fiveRunnerMixed_one_two_three',
    'LonelyRunner.fiveRunnerMixed_exceptional',
    'LonelyRunner.fiveRunnerMixed_of_buffer_inequalities',
    'LonelyRunner.fiveRunnerMixed_of_three_mul_height_ge',
    'LonelyRunner.fourRunners',
)
assert all('#print axioms '+name in audit for name in names)
review = Path('research/astra-five-runner-buffered-formal-review.md').read_text()
fence = chr(96)*3
blocks = re.findall(rf'^{fence}lean\n(.*?)^{fence}[ \t]*$', review, re.M | re.S)
assert len(blocks) == 1
lean = blocks[0]
assert len(re.findall(r'^example\b', lean, re.M)) == 17
env = dict(os.environ)
env['PATH'] = '/home/joshua/.elan/bin:' + env.get('PATH', '')
proc = subprocess.run(['lake','env','lean','--stdin'], input=lean,
    text=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, env=env)
print(proc.stdout, end='')
assert proc.returncode == 0, proc.returncode
reports = re.findall(r"'([^']+)' depends on axioms: \[([^\]]*)\]", proc.stdout)
assert len(reports) == 6 and {name for name,_ in reports} == set(names)
allowed = {'propext','Classical.choice','Quot.sound'}
for name, axioms in reports:
    assert {a.strip() for a in axioms.split(',')} <= allowed, (name,axioms)
for path, digest in guards.items():
    assert sha256(Path(path).read_bytes()).hexdigest() == digest, path
print(json.dumps({
    'result':'PASS',
    'source_guards':len(guards),
    'kernel_examples':17,
    'axiom_reports':len(reports),
    'lean_exit_code':proc.returncode,
    'lean_stdin_sha256':sha256(lean.encode()).hexdigest(),
    'lean_stdout_sha256':sha256(proc.stdout.encode()).hexdigest(),
}, sort_keys=True))
```

```lean
import LonelyRunner.FiveRunnerBuffered
import LonelyRunner.FourRunnerCanonical

open LonelyRunner

example (a b c H : ℕ) :
    FiveRunnerMixed a b c H ↔
      ∃ t : ℝ, 0 < t ∧
        (5 : ℝ)⁻¹ ≤ circleNorm (t * (a : ℝ)) ∧
        (5 : ℝ)⁻¹ ≤ circleNorm (t * (b : ℝ)) ∧
        (5 : ℝ)⁻¹ ≤ circleNorm (t * (c : ℝ)) ∧
        (4 : ℝ)⁻¹ ≤ circleNorm (t * (H : ℝ)) := Iff.rfl

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

example :
    ∀ K : ℕ, 3 < K → FiveRunnerMixed 1 2 3 K :=
  fiveRunnerMixed_one_two_three

example :
    ∀ a H : ℕ, 0 < a → 3 * a < H →
      FiveRunnerMixed a (2*a) (3*a) H :=
  fiveRunnerMixed_exceptional

example :
    ∀ a b c H : ℕ, 0 < a → a < b → b < c → c < H →
      10*a*b ≤ H*(a+b) → 30*b*c ≤ H*(3*c+8*b) →
      FiveRunnerMixed a b c H :=
  fiveRunnerMixed_of_buffer_inequalities

example :
    ∀ a b c H : ℕ, 0 < a → a < b → b < c → c < H →
      22*b ≤ 3*H → FiveRunnerMixed a b c H :=
  fiveRunnerMixed_of_three_mul_height_ge

example : ∀ speeds : Fin 4 → ℝ, Function.Injective speeds →
    ∀ runner : Fin 4, ∃ t : ℝ, LonelyAt speeds runner t :=
  fourRunners

-- Nonprimitive input reducing to A=2, K=7, hence the coprime-grid branch.
example : FiveRunnerMixed 6 12 18 21 := by
  exact fiveRunnerMixed_exceptional 6 21 (by decide) (by decide)

-- Nonprimitive input reducing to A=1, K=5.
example : FiveRunnerMixed 4 8 12 20 := by
  exact fiveRunnerMixed_exceptional 4 20 (by decide) (by decide)

-- The new parameter class outside the compared old ordinary bounds.
example : FiveRunnerMixed 4 5 11 24 := by
  exact fiveRunnerMixed_of_buffer_inequalities 4 5 11 24
    (by decide) (by decide) (by decide) (by decide) (by decide) (by decide)

-- Equality in the public coarse hypothesis.
example : FiveRunnerMixed 1 3 4 22 := by
  exact fiveRunnerMixed_of_three_mul_height_ge 1 3 4 22
    (by decide) (by decide) (by decide) (by decide) (by decide)

-- Equality in the (a,b) pair bound.
example : FiveRunnerMixed 12 20 24 75 := by
  exact fiveRunnerMixed_of_buffer_inequalities 12 20 24 75
    (by decide) (by decide) (by decide) (by decide) (by decide) (by decide)

-- Four nonzero residue classes modulo five while four divides K.
example : FiveRunnerMixed 1 2 3 4 :=
  fiveRunnerMixed_one_two_three 4 (by decide)
example : FiveRunnerMixed 1 2 3 8 :=
  fiveRunnerMixed_one_two_three 8 (by decide)
example : FiveRunnerMixed 1 2 3 12 :=
  fiveRunnerMixed_one_two_three 12 (by decide)
example : FiveRunnerMixed 1 2 3 16 :=
  fiveRunnerMixed_one_two_three 16 (by decide)

-- The remaining 20-divisible normalized family.
example : FiveRunnerMixed 1 2 3 20 :=
  fiveRunnerMixed_one_two_three 20 (by decide)

#print axioms LonelyRunner.bufferedRunnerInsertion
#print axioms LonelyRunner.fiveRunnerMixed_one_two_three
#print axioms LonelyRunner.fiveRunnerMixed_exceptional
#print axioms LonelyRunner.fiveRunnerMixed_of_buffer_inequalities
#print axioms LonelyRunner.fiveRunnerMixed_of_three_mul_height_ge
#print axioms LonelyRunner.fourRunners
```

## Verification and provenance

The independent probe completed on its first execution with terminal exit 0
(session 51477). All fifteen immutable source/report/dependency guards passed
before and after Lean. It checked seventeen kernel examples: the definition's
full positive-time/closed-margin equivalence, five public API types including
the already accepted core, unchanged fourRunners compatibility, and ten fixed
applications. All six printed axiom reports contain exactly the three allowed
axioms. No failed reviewer probe, source repair, or post-success probe edit
occurred in this task.

The two implementation reports record the worker's final direct source
compilations, focused named builds and session 13530 probe; those are reported
worker evidence, not builds repeated by this reviewer. Root's integration
build session 3712 terminated with exit 0 and 3646 jobs, and the full trust
audit session 2707 terminated with exit 0 and 462 accepted theorem reports.
I read and hash-checked both completed logs:

| Root log | SHA-256 |
| --- | --- |
| /tmp/astra-pass35-full-build.log | 2eb8e7507c62f11d8d97768f7332a4d186ad01dbe4f6ed59d00d91d1e7eba47e |
| /tmp/astra-pass35-trust.log | c21d10f41ee0d9a8e7caa43bfcfaae4cc2a58493ab706639ba0d471a57e21129 |

Executed reviewer command:

```bash
python3 -B - <<'PY'
from pathlib import Path
from hashlib import sha256
from contextlib import redirect_stdout
import re,io
fence=chr(96)*3
raw=Path('research/astra-five-runner-buffered-formal-review.md').read_text()
blocks=re.findall(rf'^{fence}python\n(.*?)^{fence}[ \t]*$',raw,re.M|re.S)
assert len(blocks)==1
out=io.StringIO()
try:
 with redirect_stdout(out):
  exec(compile(blocks[0],'five-runner-final-independent-probe','exec'),{})
finally:
 print(out.getvalue(),end='')
print('program_sha256='+sha256(blocks[0].encode()).hexdigest())
print('stdout_sha256='+sha256(out.getvalue().encode()).hexdigest())
PY
```

Frozen evidence hashes:

| Artifact | SHA-256 |
| --- | --- |
| Sole Python program | 511541c6658ebb3b6bc150f9bdd4ad43b42a0ee6fc9550f11a03acbb7b40d55a |
| Python stdout, including final newline | 1713297dbc3b4b61e023ff017b9e2a3844f7ba5dfac7c423758fa60120d8bd11 |
| Lean stdin | ba749d528a10f4b91397d7d9b8ae0a9dc0e6f7062086df8a81378d1df2d053bd |
| Raw Lean stdout/stderr | 49523e1e16ebb41f61254995061187686d2f2db981cebada703dcf5321fea03a |

Exact Python stdout:

```text
'LonelyRunner.bufferedRunnerInsertion' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.fiveRunnerMixed_one_two_three' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.fiveRunnerMixed_exceptional' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.fiveRunnerMixed_of_buffer_inequalities' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.fiveRunnerMixed_of_three_mul_height_ge' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.fourRunners' depends on axioms: [propext, Classical.choice, Quot.sound]
{"axiom_reports": 6, "kernel_examples": 17, "lean_exit_code": 0, "lean_stdin_sha256": "ba749d528a10f4b91397d7d9b8ae0a9dc0e6f7062086df8a81378d1df2d053bd", "lean_stdout_sha256": "49523e1e16ebb41f61254995061187686d2f2db981cebada703dcf5321fea03a", "result": "PASS", "source_guards": 15}
```

Final immutable guards and the workflow validator passed. This reviewer wrote
only this report, ran no full build or enumeration, and made no source, other
evidence, state, Git, dependency or cache changes. All reviewer processes
stopped after the final readback; no further cache-dependent work is needed.
The final review hash is reported at handoff, avoiding a self-referential hash.

**Accepted: no mathematical or source correction required.** The complete
exceptional family and the two closed sufficient parameter theorems have
exactly the intended scope, and their root/audit integration is verified.
The determinant refinement remains a separate manuscript statement. None
of these declarations proves uniform five-runner mixed supply, global K5,
canonical universal N5, or unrestricted LRC; the speed restrictions remain
explicit theorem hypotheses.

