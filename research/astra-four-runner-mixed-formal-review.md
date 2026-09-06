# Independent review of the four-runner mixed classification

Assigned Astra/xhigh review by `/root/mss_published_bound_audit`, based on
`7e1b4073cfd0095a3e514df975313562feb82688`. This file is the only owned new
artifact. The separately authorized tight-family review rebind is complete.
Current project configuration, workflow, policy and active state were read;
the structural validator passed. Observed runtime model/effort were not
independently exposed. The unrestricted Lonely Runner goal remains unresolved.

**Verdict: accepted.** No mathematical, contract, finite-coverage or trust
correction is required in the frozen patch. This accepts the complete positive
natural-triple mixed classification and its strict ordinary consequence at
four total runners. It does not assert the unrestricted canonical conjecture.

## Mathematical contract review

The final source has the intended unrestricted natural-triple contract:
for every `0<a<b<H`, `FourRunnerMixed a b H` holds exactly when
`not (b=2*a and H=3*a)`. The definition requires a single positive real time
with lower norms at least 1/4 and fastest norm at least 1/3. The fastest bound
also implies its ordinary quarter bound. No primitive, height, lower-count,
direct-divisor, pairwise-coprimality or strict-witness premise remains in this
classification. The strict ordinary consequence accepts existence at any real
time, including a negative one, and supplies a positive mixed time which may
be elsewhere. It does not claim strict-to-mixed conversion at the same time.

The finite certificate quantifies over all H,a,b in `Fin 37`, with exactly
the positive sorting, total gcd one and exclusion of (1,2,3) guards. It seeks
one of 34 fixed rational candidates. All 37 fixed-height clauses use ordinary
`decide`; their assembly exhausts H. Ineligible keys are discharged only by
their false guard. No count or external digest is a premise, and the existential
candidate search must find a row for every eligible key. In particular H=36
is included and total gcd one does not mean pairwise coprimality.

`fourRunnerMixedRowOK` checks positive numerator and denominator and both
sides of each residue band: q<=4r<=3q for each lower speed, and q<=3r<=2q
for H. Its generic soundness proof derives the corresponding bound on
`min(r,q-r)`, uses the existing exact natural-rational circle-norm identity,
and chooses the same positive time p/q for all three coordinates. No assumption
about reduced fractions or primitive speeds is needed for row soundness.
The analytic exclusion below supplies the negative result independently of
finite search output.

For H>36 the tuple is `![0,a,b,H]` on `Fin 4`. Its finite gcd divides a,b,H,
hence is one under the triple's total gcd-one hypothesis. The lower-count
hypothesis at N=4 concerns exactly d=1 and d=2, supplied respectively by the
existing one-moving- and two-moving-runner theorems at thresholds 1/2 and 1/3.
It imports no conjectural statement. At m=2 the accepted zero-residual mixed
height theorem has cutoff choose(4,2)^2=36. It returns one positive time;
labels 1 and 2 give the two ordinary bounds relative to zero, and label 3 is
the actual fastest endpoint with bound 1/3. Thus the finite and large-height
branches meet without a missing boundary or a hidden induction premise.

For the exception, write T=t*a and f=abs(T-round(T)). Integer translation and
reflection give the same circle norm for k*T and k*f for each natural k,
with 0<=f<=1/2, including nearest-integer ties. The first ordinary quarter
bound gives f>=1/4; the second and `norm(2f)<=abs(2f-1)=1-2f` give f<=3/8.
Consequently 3f-1 lies in [-1/4,1/8], so norm(3f)<=1/4<1/3. This rules out
mixed times for every scale a, including a=0. With strict ordinary bounds,
f>1/4 and f<3/8 give abs(3f-1)<1/4, contradicting the strict third bound.
This argument is valid for arbitrary real T, not just positive phases.

For the positive direction at arbitrary gcd, set g=gcd(a,gcd(b,H))>0 and
A=a/g, B=b/g, C=H/g. Divisibility gives exact factorizations a=g*A,
b=g*B, H=g*C. Positive multiplication cancellation preserves positivity and
strict ordering and proves gcd(A,gcd(B,C))=1. If the normalized triple were
(1,2,3), multiplication would force the excluded raw shape. A primitive
witness u>0 therefore exists, and t=u/g>0 preserves all phases exactly.
The cutoff applies after normalization; raw nonprimitive heights may exceed
36. The reverse implication uses the analytic raw-scale exclusion directly,
so a separate converse classification of normalized exceptional shapes is
unnecessary.

These derivations match the earlier accepted finite plan. The focused formal
verification and exact frozen-source checks below all passed. For a>0 the
exceptional family has its ordinary witness at t=1/(4a), with norms
(1/4,1/2,1/4). Its
failure of the stronger mixed condition is not an LRC counterexample. No
all-real-speed/all-chosen-runner canonical bridge or higher-count result is
asserted by this patch.

## Frozen sources

```text
ae47b419c5b4cebfa72a325bdb50cd32e03444c39850a74b885037d83e312a5c  LonelyRunner/FourRunnerMixed.lean
3fee16348b510ed25fd75194d59ed24ec5ffb6d02a3af1318761b772be167c56  LonelyRunner/FourRunnerMixedCertificate.lean
e5b59aba042af33744faaaa10c7eca5e4d3f3d82977921aee31a825b4dd69d84  LonelyRunner/AxiomAudit.lean
72c775735f2a92c118585499f396b2af7771fc169d09972513144446b260590e  LonelyRunner.lean
```

The pinned environment is Lean `v4.32.1`, mathlib
`520045ab14e26149ee970e2e617ca04b09bde5d6`. The accepted zero-residual review
was read, and its height theorem's source and exact use at m=2 were inspected.

## Independent executable checks

The sole Python block below reads frozen files and sends the following Lean
block directly to `lake env lean --stdin`. It writes no Lean source or compiled
output. Run it from the repository root with `python3 -B`. Read-only Git
comparison checks compatibility against the assigned base. The candidate
comparison reads the frozen 34-pair output; it does not rerun endpoint search.

```python
from pathlib import Path
from hashlib import sha256
import ast,json,os,re,runpy,subprocess

HERE = Path("research/astra-four-runner-mixed-formal-review.md")
doc = HERE.read_text()
digest = lambda b: sha256(b).hexdigest()
guards = {p:h for h,p in re.findall(
    r"^([a-f0-9]{64})  (LonelyRunner(?:/[^ \n]+)?\.lean)$", doc, re.M)}
assert len(guards) == 4
guards.update({
    "research/astra-four-runner-mixed-controls.md":
        "bf8c14305fb7232dbd6831188559d6440f1f2cd529aa3533f4c08f46e25b597a",
    "research/astra-four-runner-mixed-finite-plan.md":
        "9b71c56eb36093793df2bf02807e4f7da5f69ef1bccf4edeb68230c154dee085",
    "research/astra-four-runner-mixed-finite-review.md":
        "a5ecf0dac9c1e5049606d29fd39c740295f936a1221dc6dbf619c345b8e01371"})
for p,h in guards.items():
    assert digest(Path(p).read_bytes()) == h, p
assert Path("lean-toolchain").read_text().strip() == "leanprover/lean4:v4.32.1"
manifest = json.loads(Path("lake-manifest.json").read_text())
assert next(p["rev"] for p in manifest["packages"] if p["name"] == "mathlib") == "520045ab14e26149ee970e2e617ca04b09bde5d6"
print("PASS: seven frozen guards and pinned Lean/mathlib")
base='7e1b4073cfd0095a3e514df975313562feb82688'
changed=set(subprocess.check_output(['git','diff','--name-only',base,'--','*.lean'],text=True).splitlines())
assert changed<={'LonelyRunner.lean','LonelyRunner/AxiomAudit.lean','LonelyRunner/FourRunnerMixed.lean','LonelyRunner/FourRunnerMixedCertificate.lean'},changed
root=Path('LonelyRunner.lean').read_text()
for line in ['import LonelyRunner.FourRunnerMixedCertificate\n','import LonelyRunner.FourRunnerMixed\n']:
    assert root.count(line)==1
    root=root.replace(line,'')
assert root==subprocess.check_output(['git','show',base+':LonelyRunner.lean'],text=True)
audit=Path('LonelyRunner/AxiomAudit.lean').read_text()
old=subprocess.check_output(['git','show',base+':LonelyRunner/AxiomAudit.lean'],text=True)
oldlines=[l for l in old.splitlines() if l.strip()]
newlines=[l for l in audit.splitlines() if l.strip()]
assert newlines[:len(oldlines)]==oldlines
print('PASS: old Lean bodies/types preserved; root adds two imports; audit only adds blank line and new reports')
cert=Path('LonelyRunner/FourRunnerMixedCertificate.lean').read_text()
raw=cert.split('def fourRunnerMixedCandidates',1)[1].split('![',1)[1].split(']',1)[0]
pairs=ast.literal_eval('['+raw+']')
controls=Path('research/astra-four-runner-mixed-controls.md').read_text()
fixed=json.loads(re.findall(r'^~~~json\n(.*?)^~~~',controls.replace(chr(96)*3,'~~~'),re.M|re.S)[0])
assert len(pairs)==34 and [list(p) for p in pairs]==fixed['selected']
assert all(p>0 and q>0 for p,q in pairs)
chunks=re.findall(r'private theorem fourRunnerMixed_coverageAt_(\d+) : fourRunnerMixedCoverageAt ⟨(\d+), by decide⟩ := by\n  decide',cert)
assert chunks==[(str(i),str(i)) for i in range(37)]
print('PASS: exact 34 frozen candidates, positive p/q; 37 correctly indexed kernel-decide clauses')
scanner=runpy.run_path('scripts/audit_lean_trust.py')
for p in ['LonelyRunner.lean','LonelyRunner/AxiomAudit.lean','LonelyRunner/FourRunnerMixed.lean','LonelyRunner/FourRunnerMixedCertificate.lean']:
    assert scanner['find_forbidden_source'](Path(p).read_text()) is None,p
print('PASS: four source trust scans')

fence = chr(96)*3
blocks = re.findall(r"^"+fence+r"lean\n(.*?)^"+fence+r"[ \t]*$",doc,re.M|re.S)
assert len(blocks) == 1
probe = blocks[0]
assert digest(probe.encode()) == "aee08f64ddcefa30f79878b662c27768942ce016bad189e1b85ca95b83a12542"
assert len(re.findall(r"^example\b",probe,re.M)) == 20
env = os.environ.copy()
env["PATH"] = str(Path.home()/".elan/bin")+os.pathsep+env["PATH"]
run = subprocess.run(["lake","env","lean","--stdin"],input=probe,text=True,
                     stdout=subprocess.PIPE,stderr=subprocess.STDOUT,env=env)
assert run.returncode == 0, run.stdout
reports = re.findall(r"depends on axioms:\s*\[([^]]*)\]",run.stdout)
assert len(reports) == 11
for report in reports:
    assert {s.strip() for s in report.split(",")} <= scanner["ALLOWED_AXIOMS"]
assert digest(run.stdout.encode()) == "7c4cd8810b04aa8e33d230ad9fa42202c785052f29c913b4e6342bbb59a94ffc"
for p,h in guards.items():
    assert digest(Path(p).read_bytes()) == h, p
print("PASS: 20 Lean examples; 11 exact types and allowed axiom reports")
print("Lean stdin SHA256:",digest(probe.encode()))
print("Lean output SHA256:",digest(run.stdout.encode()))
print("Terminal status: Lean exited 0; no child process remains")
```

```lean
import LonelyRunner
open LonelyRunner
example : ∀ {a b H : ℕ}, 0 < a → a < b → b < H →
    (FourRunnerMixed a b H ↔ ¬ (b = 2 * a ∧ H = 3 * a)) :=
  @fourRunnerMixed_iff
example : ∀ {a b H : ℕ}, 0 < a → a < b → b < H →
    (∃ t : ℝ, (1 : ℝ) / 4 < circleNorm (t * (a : ℝ)) ∧
      (1 : ℝ) / 4 < circleNorm (t * (b : ℝ)) ∧
      (1 : ℝ) / 4 < circleNorm (t * (H : ℝ))) → FourRunnerMixed a b H :=
  @strict_ordinary_witness_implies_fourRunnerMixed
example (a b H : ℕ) : FourRunnerMixed a b H =
    (∃ t : ℝ, 0 < t ∧ (1 : ℝ) / 4 ≤ circleNorm (t * (a : ℝ)) ∧
      (1 : ℝ) / 4 ≤ circleNorm (t * (b : ℝ)) ∧
      (1 : ℝ) / 3 ≤ circleNorm (t * (H : ℝ))) := by
  simp only [FourRunnerMixed, Nat.cast_ofNat, one_div]
example : ∀ a : ℕ, ¬ FourRunnerMixed a (2 * a) (3 * a) :=
  not_fourRunnerMixed_one_two_three
example : ∀ a : ℕ, ¬ ∃ t : ℝ,
    (1 : ℝ) / 4 < circleNorm (t * (a : ℝ)) ∧
    (1 : ℝ) / 4 < circleNorm (t * ((2 * a : ℕ) : ℝ)) ∧
    (1 : ℝ) / 4 < circleNorm (t * ((3 * a : ℕ) : ℝ)) :=
  not_strict_ordinary_one_two_three
example : LowerCountPositiveIntegerHypothesis 4 := fourRunnerMixed_lowerCount4
example : ∀ H a b : Fin 37, 0 < a.1 → a.1 < b.1 → b.1 < H.1 →
    Nat.gcd a.1 (Nat.gcd b.1 H.1) = 1 →
    ¬ (a.1 = 1 ∧ b.1 = 2 ∧ H.1 = 3) →
    ∃ k : Fin 34, fourRunnerMixedRowOK a.1 b.1 H.1
      (fourRunnerMixedCandidates k).1 (fourRunnerMixedCandidates k).2 = true :=
  fourRunnerMixed_finiteCoverage
example : ∀ {a b H p q : ℕ}, fourRunnerMixedRowOK a b H p q = true →
    ∃ t : ℝ, 0 < t ∧ ((4 : ℕ) : ℝ)⁻¹ ≤ circleNorm (t * (a : ℝ)) ∧
      ((4 : ℕ) : ℝ)⁻¹ ≤ circleNorm (t * (b : ℝ)) ∧
      ((3 : ℕ) : ℝ)⁻¹ ≤ circleNorm (t * (H : ℝ)) :=
  @fourRunnerMixedRowOK_sound
example : FourRunnerMixed 1 2 36 :=
  primitive_fourRunnerMixed_of_le_36 (by decide) (by decide) (by decide)
    (by decide) (by decide) (by decide)
example : FourRunnerMixed 1 2 37 :=
  primitive_fourRunnerMixed_of_gt_36 (by decide) (by decide) (by decide)
    (by decide) (by decide)
example : FourRunnerMixed 6 10 15 :=
  primitive_fourRunnerMixed (by decide) (by decide) (by decide)
    (by decide) (by decide)
example : FourRunnerMixed 12 24 72 :=
  fourRunnerMixed_of_not_exception (by decide) (by decide) (by decide) (by decide)
example : ¬ FourRunnerMixed 17 34 51 := by
  simpa using not_fourRunnerMixed_one_two_three 17
example : ¬ FourRunnerMixed 0 0 0 := by
  simpa using not_fourRunnerMixed_one_two_three 0
example : ∀ k : Fin 34, fourRunnerMixedRowOK 1 2 3
    (fourRunnerMixedCandidates k).1 (fourRunnerMixedCandidates k).2 = false := by
  decide
example : fourRunnerMixedRowOK 1 2 4 1 0 = false := by decide
example : fourRunnerMixedRowOK 1 2 4 0 3 = false := by decide
example : fourRunnerMixedRowOK 12 24 72 5 216 = true := by decide
example {a b H : ℕ} (ha : 0 < a) (hab : a < b) (hbH : b < H)
    (t : ℝ) (_ht : t < 0)
    (h1 : (1 : ℝ) / 4 < circleNorm (t * (a : ℝ)))
    (h2 : (1 : ℝ) / 4 < circleNorm (t * (b : ℝ)))
    (h3 : (1 : ℝ) / 4 < circleNorm (t * (H : ℝ))) :
    ∃ u : ℝ, 0 < u ∧ (1 : ℝ) / 4 ≤ circleNorm (u * (a : ℝ)) ∧
      (1 : ℝ) / 4 ≤ circleNorm (u * (b : ℝ)) ∧
      (1 : ℝ) / 3 ≤ circleNorm (u * (H : ℝ)) := by
  have hm := strict_ordinary_witness_implies_fourRunnerMixed
    ha hab hbH ⟨t, h1, h2, h3⟩
  simpa only [FourRunnerMixed, Nat.cast_ofNat, one_div] using hm
example : FourRunnerMixed 1 2 4 := by
  apply strict_ordinary_witness_implies_fourRunnerMixed (by decide) (by decide) (by decide)
  refine ⟨-(1 : ℝ) / 3, ?_, ?_, ?_⟩
  all_goals norm_num only [Nat.cast_ofNat]
  · rw [circleNorm_neg]
    have h := circleNorm_nat_div_eq 3 1
    norm_num [cyclicResidueDistance] at h
    rw [h]
    norm_num
  · rw [circleNorm_neg]
    have h := circleNorm_nat_div_eq 3 2
    norm_num [cyclicResidueDistance] at h
    rw [h]
    norm_num
  · rw [circleNorm_neg]
    have h := circleNorm_nat_div_eq 3 4
    norm_num [cyclicResidueDistance] at h
    rw [h]
    norm_num
#check @fourRunnerMixed_finiteCoverage
#print axioms LonelyRunner.fourRunnerMixed_finiteCoverage
#check @fourRunnerMixedRowOK_sound
#print axioms LonelyRunner.fourRunnerMixedRowOK_sound
#check @primitive_fourRunnerMixed_of_le_36
#print axioms LonelyRunner.primitive_fourRunnerMixed_of_le_36
#check @fourRunnerMixed_lowerCount4
#print axioms LonelyRunner.fourRunnerMixed_lowerCount4
#check @primitive_fourRunnerMixed_of_gt_36
#print axioms LonelyRunner.primitive_fourRunnerMixed_of_gt_36
#check @primitive_fourRunnerMixed
#print axioms LonelyRunner.primitive_fourRunnerMixed
#check @not_fourRunnerMixed_one_two_three
#print axioms LonelyRunner.not_fourRunnerMixed_one_two_three
#check @fourRunnerMixed_of_not_exception
#print axioms LonelyRunner.fourRunnerMixed_of_not_exception
#check @fourRunnerMixed_iff
#print axioms LonelyRunner.fourRunnerMixed_iff
#check @not_strict_ordinary_one_two_three
#print axioms LonelyRunner.not_strict_ordinary_one_two_three
#check @strict_ordinary_witness_implies_fourRunnerMixed
#print axioms LonelyRunner.strict_ordinary_witness_implies_fourRunnerMixed
```

## Executed outcomes and evidence boundaries

The final guarded program exited zero. Its 20 kernel examples check eight
exact definition/declaration contracts and twelve boundary applications:
H=36 and H=37 on (1,2,H); total-gcd-one (6,10,15), whose three pairwise gcds
are all nontrivial; raw scale (12,24,72) above the primitive cutoff; the scaled
exception (17,34,51); scale zero; rejection of all table candidates at (1,2,3);
zero-denominator and zero-numerator rejection; the exact scaled row 5/216;
an arbitrary negative-time strict premise; and the concrete strict witness
t=-1/3 for (1,2,4), whose three norms are each 1/3. Every mixed conclusion
still has a positive time. These controls check the interfaces and important
boundaries; the all-key kernel certificate supplies exhaustive finite coverage.

The fixed coverage domain is every primitive positive increasing triple of
height at most 36, with only (1,2,3) omitted from the positive branch. The
earlier independently reviewed finite evidence counted 6079 primitive triples
and 6078 positive rows. The current proof does not infer completeness from
either number: each of all `Fin 37` keys is checked by the kernel. The 34
candidate pairs agree exactly with the frozen compression output and have
positive p,q. All 37 private fixed-height declarations were inspected and
their numeric indices and ordinary `decide` bodies independently checked.

All eleven public declarations were printed at their exact inferred types.
All eleven axiom reports use only `propext`, `Classical.choice` and `Quot.sound`.
The four changed/new Lean paths passed the source trust scanner. Read-only
comparison with the assigned base confirms that all pre-existing theorem
bodies/types are unchanged: the root adds two imports, while the axiom file
adds eleven reports, two comments, and one unrelated blank line. That blank
line initially defeated an overly strict prefix assertion in the review
harness; the corrected comparison preserves every old nonblank line.

Two initial negative-time probe attempts failed in the probe's casts/rewrites:
the goal retained natural casts, then `norm_num` had already reduced the phase
before an explicit product rewrite. Correcting only the test harness resolved
both. One earlier tool-call construction failed before executing a command.
No implementation correction was made by this reviewer, and none of those
failed probe attempts is reported as a passed test.

Exact reproduction hashes, UTF-8 including trailing newlines:

```text
9f9cc630757d14e957dcf05eb374f4c7cee89e6761749b8494996860e87b46b2  sole Python block
f9e416f3efeaa87bd63b8f305aa51c37d3e49b7d64325d3ff3a8dc3b59dd43c4  program stdout
aee08f64ddcefa30f79878b662c27768942ce016bad189e1b85ca95b83a12542  Lean stdin block
7c4cd8810b04aa8e33d230ad9fa42202c785052f29c913b4e6342bbb59a94ffc  raw Lean stdout/stderr
```

The program stdout was:

```text
PASS: seven frozen guards and pinned Lean/mathlib
PASS: old Lean bodies/types preserved; root adds two imports; audit only adds blank line and new reports
PASS: exact 34 frozen candidates, positive p/q; 37 correctly indexed kernel-decide clauses
PASS: four source trust scans
PASS: 20 Lean examples; 11 exact types and allowed axiom reports
Lean stdin SHA256: aee08f64ddcefa30f79878b662c27768942ce016bad189e1b85ca95b83a12542
Lean output SHA256: 7c4cd8810b04aa8e33d230ad9fa42202c785052f29c913b4e6342bbb59a94ffc
Terminal status: Lean exited 0; no child process remains
```

The root's final full-build and trust logs were independently read, including
their terminal success lines and absence of error lines. The full build reports
3640 jobs and the trust audit accepts 449 reports. The original worker's earlier
premature success claim was withdrawn; this review uses the corrected final
source hashes and terminal evidence only. The root also directly recompiled
the final certificate under `/usr/bin/time -v`, with exit status 0, 28.49 seconds
wall time, maximum RSS 3,985,760 KiB, zero swaps and zero filesystem outputs.
These resource figures measure that local run, not a guarantee for other CI
machines. This reviewer ran no full rebuild and did not repeat the tuple search.

| Supporting artifact read | SHA-256 |
| --- | --- |
| Accepted finite plan | `9b71c56eb36093793df2bf02807e4f7da5f69ef1bccf4edeb68230c154dee085` |
| Accepted finite-plan review | `a5ecf0dac9c1e5049606d29fd39c740295f936a1221dc6dbf619c345b8e01371` |
| Frozen endpoint compression controls | `bf8c14305fb7232dbd6831188559d6440f1f2cd529aa3533f4c08f46e25b597a` |
| Final implementation report | `56c05823d7f9ed318cec755ea5a3badfc4087cf93848e9c482d2bd105f4d99b8` |
| Accepted zero-residual review | `2d280adc4e51068db4b2c5fdb6684dc3e507d9027b522b332849891387d2fdff` |
| `FiniteHeightReduction.lean` | `cb41059260b943411e2ab5360b84b59cd13f2ddf352c3c50a0b3715b9b9987d6` |
| `LowerCountSupply.lean` | `0705291adc53011fb72fc718a7260876512b092741442d6a6cceb4b76eb5ccf4` |
| `BaseCases.lean` | `31e2c328e060c077c6c9928e3fb431601326e4e54a949ee5148aed5cd3687d1f` |
| `SmallDimensions.lean` | `e4933da3551792130eebf1ede4701bff3296f59eb696dfb7b6276e16d940d699` |
| `PivotResidues.lean` | `362da5ab923f22e900ae7ac821dd4cf4aab91dfe70889987bc9e5a05d19c276a` |
| `PairSumCompleteness.lean` | `838a3bcec806b0e9d01cd117e64e5348de58a05127a3f7bef5dbe2d879ff292f` |
| `Definitions.lean` | `5f0258a6ab99950fc7045b2200d6708fe7603d3caa4d62855ef2b19a330c95aa` |
| `/tmp/astra-pass33-full-build.log` | `86f1fad48e79c7e39ebbe93a2462987432afc8649eea30d56bba1f26629cab92` |
| `/tmp/astra-pass33-trust.log` | `0d6ebd7e196a91cf1128f086d554bdf1f7ca69eb389a5f458482fc369eef150b` |
| `/tmp/astra-pass33-certificate-resources.log` | `ae74162f4c247a6cbcad94856f3e0b9a9d5ecaca9eb3f43171782bbcb18f246c` |

Only this review and the separately authorized tight-family review rebind were
written. No Lean source, shared state, Git data, dependency or cache was edited;
read-only Git inspection was used for compatibility. All reviewer Lean and
other child processes have stopped. Final source guards, workflow validation
and review readback precede freezing; the review's own hash is reported
separately. The full unrestricted LRC goal remains unresolved.
