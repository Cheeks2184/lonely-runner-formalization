# Independent review of rational-margin certificate interfaces

2026-09-06. Assigned reviewer `/root/mss_published_bound_audit`, requested
Astra/xhigh; the runtime model and effort are not independently attested.
Base checkpoint `d1ac311bef74afad9220e19cb76077cc97f60b6f`. Current project
configuration, workflow, policy and active task state were read and the workflow
validator passed. Only this review is owned; no Lean source, other manuscript,
state, Git, dependency or cache is changed.

Accepted: all eight new public contracts implement the generic design without
a mathematical gap. The focused root-import kernel probe passed with terminal
exit 0. This is an exact-source review of the three
new modules, their root imports and audit entries, not a finite-domain scan,
resource pilot, K5 proof or universal five-runner supply theorem.

## Mathematical contract review

The scalar rational equivalence assumes exactly positive B and q. It derives
the two additive natural inequalities from the exact residue norm. The proof's
internal subtraction is justified by r=x%q<q; the public checker contains no
truncated-subtraction comparison. Numerator A may be zero or greater than B/2,
and x may be zero. Margins above a half are rejected by the inequalities,
without requiring a half-margin hypothesis in the theorem.

`rationalMarginResidueOK` is deliberately just the two arithmetic tests.
It does not itself reject zero denominators. Its iff is purely arithmetic.
`rationalMarginRowOK` separately enforces q>0 and every coordinate denominator
positive before real interpretation. Thus a pointwise real inequality involving
Lean's division by zero cannot accidentally certify a row. Both row iff
theorems retain these guards. No positivity, injectivity or nonemptiness is
imposed on the finite speed family; zero speeds, repeated speeds, p=0 and
zero numerators are admitted. Only the positive-time existence corollary adds
p>0, and it returns exactly the common real time p/q. All coordinate margins
are closed and simultaneous.

The endpoint theorem requires n>0, positive natural speeds, real coordinate
margins in (0,1/2], and a supplied real witness. It first takes fractional part,
then reflects into the half period; integer-speed periodicity and negation
preserve each separate margin. Natural floors are legitimate because the
folded seed is nonnegative. Each closed floor band contains the seed. A
maximal left endpoint T lies below the seed and hence below every band's right
endpoint; maximality gives every lower band inequality. The same integer-band
lemma therefore proves all original margins at T.

The proof initially needs only seed>=0: positivity of its chosen endpoint
follows independently from positive margin and speed. In particular an
impossible seed zero cannot create a spurious witness. It proves
`2*k<speeds p` from T<=1/2 and positive owner margin before deriving the natural
bound `k<(speeds p+1)/2`. This is the correct ceil-half count for both parities,
including speed one. Finite maximum ties, repeated speeds, n=1, negative input
time, half margins and singleton band intersections require no separate
positive-width or injectivity assumption. The real margins are not rounded,
uniformized or replaced by smaller values.

The strict pair theorem uses n>=2 and positive natural speeds, with an arbitrary
real delta>0. The finite minimum mu of the supplied strict witness is attained,
so mu>delta. Existing closed arbitrary-margin pair completeness at mu returns
all norms >=mu and therefore still >delta. It selects distinct indices p!=q,
not distinct speed values. Its positive numerator and strict numerator bound
are preserved. The reverse implication supplies that same pair time directly.
There is no hidden lower-count, sortedness, coprimality, rational-delta or
global-conjecture premise. It does not preserve a different designated margin
and does not assert that a strict witness exists.

All three modules import only existing lower-level modules and Mathlib.
Root imports expose all eight declarations; the audit prints those eight
names. Removing exactly the three added imports from the root reconstructs
its prior accepted bytes. Removing those imports and the new terminal audit
section likewise reconstructs the prior audit bytes. The old
`LonelyRunner.fourRunners` type remains unconditional for arbitrary injective
real Fin 4 speeds and any selected runner. No new result discharges the open
finite coverage obligation or proves unrestricted LRC.

## Frozen sources and provenance

The executable guards below bind the three sources, root/audit, all three
implementation reports, the accepted design review, the used existing
interfaces, and pinned dependency files. The full source build reported by
root finished in session `50426` with terminal exit 0 and 3649 jobs. Root's
global trust audit finished in session `39997` with exit 0. I read the final
logs and independently checked all 470 reported axiom lists against the three
permitted axioms; both log hashes matched:

| Evidence | SHA-256 |
| --- | --- |
| `/tmp/astra-pass36-full-build.log` | `914f9c993770fd4f90eea73cadcb16b4bf30fa5c8bceb596be177ce65746126f` |
| `/tmp/astra-pass36-trust.log` | `f014583ce8db5db95bdfb322723d7e4a1e45bd10ab2fb96567d226d9c482d11c` |

These are root's completed build/audit runs, not reviewer rebuilds. The
implementation reports record the endpoint draft repairs and final source
checks; root also disclosed two earlier strict-control failures involving
test casts/norm rewriting and a corrected successful probe. Neither historical
failed draft nor failed control is used as final evidence. The frozen final
source is independently assessed here. Module prefixes in the rational report
identify files; the actual declarations are in namespace `LonelyRunner`.

## Guarded root-import probe

The Python block runs only the adjacent Lean stdin block, checks its actual
return code and exact theorem axiom reports, and verifies unchanged sources
before and after. All fixed Booleans use ordinary kernel `decide`. Existential
controls apply the proved theorem and do not evaluate a noncomputable witness.
The exact-type examples contain no extra assumptions.

```python
from hashlib import sha256
from pathlib import Path
import json, os, re, subprocess

guards = {
    'LonelyRunner/RationalMarginCertificates.lean':'ffe31ce9636281f6c4b8fc2cdf618043a6c02b0195bf75ff6e0aee65c317c1d9',
    'LonelyRunner/EndpointCompleteness.lean':'0e3f10f64daf41bedebf31bb71cb6b93ffa5358615c6c30ec941b01fc97b9d57',
    'LonelyRunner/StrictPairSumCompleteness.lean':'549e879d49b54560a56f402aec18d64b6b227f86a71821a28c13c7356f622bd6',
    'LonelyRunner.lean':'4e2bcd1c805cba6ac47c42a95298fafaa80047829127b7f367eedb13575d8ff4',
    'LonelyRunner/AxiomAudit.lean':'f9dc948ca09cca91857ff9b75a21206ef82470fe774ac7bdb451c1ec3c17c54b',
    'research/astra-rational-margin-certificates-implementation.md':'7442e38ecca4d57594090036c77d740af70d160fc0411a1c7dac5351bddda4ef',
    'research/astra-endpoint-completeness-implementation.md':'137b0817326d6aeeb05b7f8cc9189b7d180492e15b885a62905613fb143edf6a',
    'research/astra-strict-pair-sum-implementation.md':'e5ad89dc4ddd89613e27abcd3c5c14c5945f6c2a29b718761fde3c00983867fc',
    'research/astra-five-runner-certificate-design-review.md':'c86e42c2ed14c015f83776644469827a850614fc6fbdd5c55a96ce61c8b12b40',
    'LonelyRunner/PairSumCompleteness.lean':'838a3bcec806b0e9d01cd117e64e5348de58a05127a3f7bef5dbe2d879ff292f',
    'LonelyRunner/StructuredClasses.lean':'5328a7a88d2b42f86ffc3f0f0418ca22c761219e8fa3e5822bda5a18ac286e8c',
    'LonelyRunner/PivotResidues.lean':'362da5ab923f22e900ae7ac821dd4cf4aab91dfe70889987bc9e5a05d19c276a',
    'LonelyRunner/FourRunnerCanonical.lean':'353b116d04d464fb9aedb92437e7f56168992e087a862f934044bc9062761c38',
    'lean-toolchain':'8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af',
    'lake-manifest.json':'887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218',
}
for path, digest in guards.items():
    assert sha256(Path(path).read_bytes()).hexdigest() == digest, path
names = (
    'LonelyRunner.rationalMargin_circleNorm_iff',
    'LonelyRunner.rationalMarginResidueOK_iff',
    'LonelyRunner.rationalMarginRowOK_iff',
    'LonelyRunner.rationalMarginRowOK_sound',
    'LonelyRunner.rationalMarginRowOK_circleNorm_iff',
    'LonelyRunner.rationalMarginRowOK_exists_positive_time',
    'LonelyRunner.exists_endpoint_time_of_witness',
    'LonelyRunner.exists_strictWitness_iff_pairSum',
    'LonelyRunner.fourRunners',
)
root = Path('LonelyRunner.lean').read_text()
audit = Path('LonelyRunner/AxiomAudit.lean').read_text()
mods = ('RationalMarginCertificates','EndpointCompleteness','StrictPairSumCompleteness')
for mod in mods:
    assert 'import LonelyRunner.'+mod+'\n' in root
    imports = re.findall(r'^import (.+)$',Path('LonelyRunner/'+mod+'.lean').read_text(),re.M)
    assert 'LonelyRunner' not in imports
    assert all('LonelyRunner.'+other not in imports for other in mods)
assert all('#print axioms '+name in audit for name in names)
new_imports = r'^import LonelyRunner\.(RationalMarginCertificates|EndpointCompleteness|StrictPairSumCompleteness)\n'
assert sha256(re.sub(new_imports,'',root,flags=re.M).encode()).hexdigest() == '0568c0f96dc4c7612d27f39673a9770ce9b780e020b7d6eb4b1268296eb069df'
old_audit = re.sub(new_imports,'',audit.split('-- Generic certificate interfaces')[0].rstrip()+'\n',flags=re.M)
assert sha256(old_audit.encode()).hexdigest() == '699818b850898afe849785ffb6aae5ab3dc927cd58263f6e477389965c41ebd1'
review = Path('research/astra-rational-margin-formal-review.md').read_text()
fence = chr(96)*3
blocks = re.findall(rf'^{fence}lean\n(.*?)^{fence}[ \t]*$',review,re.M|re.S)
assert len(blocks) == 1
lean = blocks[0]
examples = len(re.findall(r'^example\b',lean,re.M))
env = dict(os.environ)
env['PATH'] = '/home/joshua/.elan/bin:' + env.get('PATH','')
proc = subprocess.run(['lake','env','lean','--stdin'],input=lean,text=True,
    stdout=subprocess.PIPE,stderr=subprocess.STDOUT,env=env)
print(proc.stdout,end='')
assert proc.returncode == 0, proc.returncode
reports = re.findall(r"'([^']+)' depends on axioms: \[([^\]]*)\]",proc.stdout)
assert len(reports) == 9 and {name for name,_ in reports} == set(names)
allowed = {'propext','Classical.choice','Quot.sound'}
for name, axioms in reports:
    assert {a.strip() for a in axioms.split(',')} <= allowed, (name,axioms)
for path, digest in guards.items():
    assert sha256(Path(path).read_bytes()).hexdigest() == digest, path
print(json.dumps({
    'result':'PASS','source_guards':len(guards),'kernel_examples':examples,
    'axiom_reports':len(reports),'lean_exit_code':proc.returncode,
    'lean_stdin_sha256':sha256(lean.encode()).hexdigest(),
    'lean_stdout_sha256':sha256(proc.stdout.encode()).hexdigest(),
    'root_and_audit_prior_bytes_preserved':True,
    'speed_tuple_scan':False,'resource_pilot':False,
},sort_keys=True))
```

```lean
import LonelyRunner

open LonelyRunner

-- Eight exact public contracts and the existing canonical compatibility type.
example :
    ∀ {A B q x : ℕ}, 0 < B → 0 < q →
      ((A : ℝ) / (B : ℝ) ≤ circleNorm ((x : ℝ) / (q : ℝ)) ↔
        A * q ≤ B * (x % q) ∧ B * (x % q) + A * q ≤ B * q) :=
  @rationalMargin_circleNorm_iff

example :
    ∀ {A B q x : ℕ},
      rationalMarginResidueOK A B q x = true ↔
        A * q ≤ B * (x % q) ∧ B * (x % q) + A * q ≤ B * q :=
  @rationalMarginResidueOK_iff

example :
    ∀ {n : ℕ} (speeds num den : Fin n → ℕ) (p q : ℕ),
      rationalMarginRowOK speeds num den p q = true ↔
        0 < q ∧ ∀ i, 0 < den i ∧
          num i * q ≤ den i * ((speeds i * p) % q) ∧
          den i * ((speeds i * p) % q) + num i * q ≤ den i * q :=
  @rationalMarginRowOK_iff

example :
    ∀ {n : ℕ} (speeds num den : Fin n → ℕ) (p q : ℕ),
      rationalMarginRowOK speeds num den p q = true →
      ∀ i, (num i : ℝ) / (den i : ℝ) ≤
        circleNorm (((p : ℝ) / (q : ℝ)) * (speeds i : ℝ)) :=
  @rationalMarginRowOK_sound

example :
    ∀ {n : ℕ} (speeds num den : Fin n → ℕ) (p q : ℕ),
      rationalMarginRowOK speeds num den p q = true ↔
        0 < q ∧ ∀ i, 0 < den i ∧
          (num i : ℝ) / (den i : ℝ) ≤
            circleNorm (((p : ℝ) / (q : ℝ)) * (speeds i : ℝ)) :=
  @rationalMarginRowOK_circleNorm_iff

example :
    ∀ {n : ℕ} (speeds num den : Fin n → ℕ) (p q : ℕ), 0 < p →
      rationalMarginRowOK speeds num den p q = true →
      ∃ t : ℝ, 0 < t ∧ ∀ i, (num i : ℝ) / (den i : ℝ) ≤
        circleNorm (t * (speeds i : ℝ)) :=
  @rationalMarginRowOK_exists_positive_time

example :
    ∀ {n : ℕ}, 0 < n →
    ∀ speeds : Fin n → ℕ, (∀ i, 0 < speeds i) →
    ∀ margins : Fin n → ℝ, (∀ i, 0 < margins i) →
      (∀ i, margins i ≤ (1 : ℝ) / 2) →
    ∀ time : ℝ, (∀ i, margins i ≤ circleNorm (time * (speeds i : ℝ))) →
      ∃ p : Fin n, ∃ k : ℕ, k < (speeds p + 1) / 2 ∧
        let T : ℝ := ((k : ℝ) + margins p) / (speeds p : ℝ)
        0 < T ∧ T ≤ (1 : ℝ) / 2 ∧
          ∀ i, margins i ≤ circleNorm (T * (speeds i : ℝ)) :=
  @exists_endpoint_time_of_witness

example :
    ∀ {n : ℕ}, 2 ≤ n →
    ∀ speeds : Fin n → ℕ, (∀ i, 0 < speeds i) →
    ∀ δ : ℝ, 0 < δ →
      ((∃ time : ℝ, ∀ i, δ < circleNorm (time * (speeds i : ℝ))) ↔
        ∃ p q : Fin n, p ≠ q ∧ ∃ r : ℕ,
          0 < r ∧ r < speeds p + speeds q ∧ ∀ i,
            δ < circleNorm (((r : ℝ) / ((speeds p + speeds q : ℕ) : ℝ)) *
              (speeds i : ℝ))) :=
  @exists_strictWitness_iff_pairSum

example : ∀ speeds : Fin 4 → ℝ, Function.Injective speeds →
    ∀ runner : Fin 4, ∃ t : ℝ, LonelyAt speeds runner t :=
  fourRunners

-- Zero speed, zero margin and p=0 remain valid for a pointwise row.
example : rationalMarginRowOK (fun _ : Fin 2 => 0)
    (fun _ => 0) (fun _ => 7) 0 3 = true := by decide

-- Row-level denominator guards reject invalid rational representations.
example : rationalMarginRowOK (fun _ : Fin 1 => 1)
    (fun _ => 0) (fun _ => 0) 0 3 = false := by decide

example : rationalMarginRowOK (fun _ : Fin 1 => 1)
    (fun _ => 0) (fun _ => 1) 0 0 = false := by decide

-- The margin upper bound is enforced by the arithmetic, not a premise.
example : rationalMarginRowOK (fun _ : Fin 1 => 1)
    (fun _ => 3) (fun _ => 4) 1 2 = false := by decide

example : rationalMarginRowOK (fun _ : Fin 1 => 1)
    (fun _ => 1) (fun _ => 4) 1 4 = true := by decide

example : rationalMarginRowOK (fun _ : Fin 1 => 1)
    (fun _ => 1) (fun _ => 2) 1 2 = true := by decide

-- This lower band passes, so rejection needs the upper inequality.
example : rationalMarginRowOK (fun _ : Fin 1 => 1)
    (fun _ => 1) (fun _ => 3) 3 4 = false := by decide

-- The empty row still requires q>0, but no nonempty-family assumption.
example : rationalMarginRowOK (fun _ : Fin 0 => 0)
    (fun _ => 0) (fun _ => 0) 0 7 = true := by decide

-- A known mixed row and a positive-time application check actual real output.
example : rationalMarginRowOK ![4,5,11,24] ![1,1,1,1] ![5,5,5,4]
    13 96 = true := by decide

example : ∃ t : ℝ, 0 < t ∧ ∀ i : Fin 4,
    ((![1,1,1,1] i : ℕ) : ℝ) / ((![5,5,5,4] i : ℕ) : ℝ) ≤
      circleNorm (t * ((![4,5,11,24] i : ℕ) : ℝ)) :=
  rationalMarginRowOK_exists_positive_time ![4,5,11,24] ![1,1,1,1] ![5,5,5,4]
    13 96 (by decide) (by decide)

-- One-speed half-margin endpoint: k=0 is retained, not excluded.
example :
    ∃ p : Fin 1, ∃ k : ℕ, k < ((1 : ℕ) + 1) / 2 ∧
      let T : ℝ := ((k : ℝ) + (1 : ℝ) / 2) / ((1 : ℕ) : ℝ)
      0 < T ∧ T ≤ (1 : ℝ) / 2 ∧
        ∀ _ : Fin 1, (1 : ℝ) / 2 ≤ circleNorm (T * ((1 : ℕ) : ℝ)) := by
  apply exists_endpoint_time_of_witness (by decide) (fun _ : Fin 1 => 1)
    (by intro i; decide) (fun _ => (1 : ℝ) / 2)
    (by intro i; norm_num) (by intro i; norm_num) ((1 : ℝ) / 2)
  intro i
  exact circleNorm_ge_of_int_band 0 _ _ (by norm_num) (by norm_num)
    (by norm_num) (by norm_num)

-- Two repeated speeds, negative input time, tied half-margin singleton bands.
example :
    ∃ p : Fin 2, ∃ k : ℕ, k < ((3 : ℕ) + 1) / 2 ∧
      let T : ℝ := ((k : ℝ) + (1 : ℝ) / 2) / 3
      0 < T ∧ T ≤ (1 : ℝ) / 2 ∧
        ∀ _ : Fin 2, (1 : ℝ) / 2 ≤ circleNorm (T * 3) := by
  apply exists_endpoint_time_of_witness (by decide) (fun _ : Fin 2 => 3)
    (by intro i; decide) (fun _ => (1 : ℝ) / 2)
    (by intro i; norm_num) (by intro i; norm_num) (-(1 : ℝ) / 2)
  intro i
  exact circleNorm_ge_of_int_band (-2) _ _ (by norm_num) (by norm_num)
    (by norm_num) (by norm_num)

-- Strict completeness works on repeated values and keeps distinct labels.
example : ∃ p q : Fin 2, p ≠ q ∧ ∃ r : ℕ,
    0 < r ∧ r < (1 : ℕ) + 1 ∧ ∀ _ : Fin 2,
      (1 : ℝ) / 4 < circleNorm
        (((r : ℝ) / ((1 + 1 : ℕ) : ℝ)) * ((1 : ℕ) : ℝ)) := by
  apply (exists_strictWitness_iff_pairSum (by decide) (fun _ : Fin 2 => 1)
    (by intro i; decide) ((1 : ℝ) / 4) (by norm_num)).mp
  refine ⟨-(1 : ℝ) / 2, fun i => ?_⟩
  have hband : (1 : ℝ) / 2 ≤ circleNorm ((-(1 : ℝ) / 2) * 1) :=
    circleNorm_ge_of_int_band (-1) _ _ (by norm_num) (by norm_num)
      (by norm_num) (by norm_num)
  simpa only [Nat.cast_one] using
    (lt_of_lt_of_le (by norm_num : (1 : ℝ) / 4 < (1 : ℝ) / 2) hband)

-- Strict half is impossible; closed half remains accepted above.
example : ¬ ∃ time : ℝ, ∀ _ : Fin 2,
    (1 : ℝ) / 2 < circleNorm (time * ((1 : ℕ) : ℝ)) := by
  intro h
  obtain ⟨p, q, hpq, r, hr0, hrlt, hgood⟩ :=
    (exists_strictWitness_iff_pairSum (by decide) (fun _ : Fin 2 => 1)
      (by intro i; decide) ((1 : ℝ) / 2) (by norm_num)).mp h
  have hr : r = 1 := by change r < 2 at hrlt; omega
  have hg := hgood (0 : Fin 2)
  norm_num [hr] at hg
  have hn : circleNorm ((1 : ℝ) / 2) = (1 : ℝ) / 2 := by
    simpa [cyclicResidueDistance] using circleNorm_nat_div_eq 2 1
  rw [hn] at hg
  exact (lt_irrefl _) hg

#print axioms LonelyRunner.rationalMargin_circleNorm_iff
#print axioms LonelyRunner.rationalMarginResidueOK_iff
#print axioms LonelyRunner.rationalMarginRowOK_iff
#print axioms LonelyRunner.rationalMarginRowOK_sound
#print axioms LonelyRunner.rationalMarginRowOK_circleNorm_iff
#print axioms LonelyRunner.rationalMarginRowOK_exists_positive_time
#print axioms LonelyRunner.exists_endpoint_time_of_witness
#print axioms LonelyRunner.exists_strictWitness_iff_pairSum
#print axioms LonelyRunner.fourRunners
```

## Final verification record

The corrected reviewer run completed in session `87965` with terminal exit 0
(final tool chunk `d563ee`). All 23 examples passed: eight exact new types,
the old canonical four-runner type, and fourteen fixed edge/application
controls. All nine axiom reports used only permitted axioms. In particular
the arithmetic residue iff uses only `propext`; the arithmetic row iff uses
`propext` and `Quot.sound`; the remaining seven use at most the standard three.
All fifteen hashes passed before and after the Lean subprocess. The root
and audit comparisons also reconstructed the exact prior accepted bytes.

| Frozen reviewer evidence | SHA-256 |
| --- | --- |
| Sole Python program | `c6b4f8a9740bcae517c1484fe7452ed2d5478d06b6dcf1f25259bfad5822c518` |
| Lean stdin block | `1ccd52f957caa9c74b25a6309c9eaa83e0255d3ef868cf918451af25cba2995b` |
| Raw Lean stdout | `b9d675a417216aa86dca7875fa1037345f73c9b97cebfd477fbd5405b68539f9` |
| Raw reviewer program stdout | `449bcbc7ba635810debc421b58b1acb6f8424b83e465ab3baa41cc579a41ec18` |

The stdout includes two unused-owner-variable warnings in the constant-speed
endpoint examples; these are not theorem failures. The JSON summary records
23 kernel examples, 9 axiom reports, 15 guards, exit 0 and preserved prior
root/audit bytes, with both speed-tuple scan and resource pilot false.

The first reviewer run, session `90842`, ended with exit 1. Its controls wrote
real numeral one where the theorem retained a cast of natural one; this
prevented direct unification in the one-speed endpoint and strict repeated
controls and caused a subsequent change-tactic failure. The eight exact types
and nine axiom reports had already checked. Only the Lean examples in this
review were corrected to keep the explicit casts and simplify them before
the final norm rewrite. No source or theorem contract changed. The failed
run's captured stdout hash was
`d3ea22e707ecefd19a42b12b24b1d3384e64326c2af6af4c3404d48ff4da8344`;
the Python program was byte-identical in both runs. The successful final
hashes above, rather than the failed controls, are the reproducible evidence.

The exact outer command used for both runs, from the repository root, was:

```bash
python3 -B - <<'PY'
from pathlib import Path
from hashlib import sha256
from contextlib import redirect_stdout
import re,io
f=chr(96)*3
raw=Path('research/astra-rational-margin-formal-review.md').read_text()
blocks=re.findall(rf'^{f}python\n(.*?)^{f}[ \t]*$',raw,re.M|re.S)
assert len(blocks)==1
out=io.StringIO()
try:
 with redirect_stdout(out):
  exec(compile(blocks[0],'rational-margin-independent-review','exec'),{})
finally:
 print(out.getvalue(),end='')
 print('review_program_sha256='+sha256(blocks[0].encode()).hexdigest())
 print('review_stdout_sha256='+sha256(out.getvalue().encode()).hexdigest())
PY
```

Final disposition: accepted with no source correction required. The positive
denominator guards, simultaneous closed margins, positive endpoint time,
strictness and label distinction match the intended public interfaces.
The source build, global axiom audit and focused exact-type/edge probes are
separate recorded evidence. These are checker and completeness tools; no
new finite coverage certificate, K5, universal N5 or unrestricted LRC result
is claimed. All reviewer processes are stopped at handoff. The shared cache
remains under root's control for its independent replay; no cleanup or further
Lean work is performed by this reviewer.
