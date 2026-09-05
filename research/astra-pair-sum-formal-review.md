# Independent exact-source review: pair-sum completeness

Accepted at the exact frozen contract. The complete source elaborates afresh,
and every public declaration and review control uses only the permitted axioms.
This is an equivalence between witness existence and finite pair-sum certificate
existence. It proves neither the universal certificate proposition nor the
canonical Lonely Runner Conjecture.

Review scope: assigned checkpoint `367a9dc22e093a0347a776f988cac67335bab379`,
branch `codex/astra-pair-sum-completeness`; task
`/root/endpoint_label_audit-pair-sum-source-review`. The project configuration,
workflow, policy and current state were read, and
`python3 -B scripts/validate_workflow.py` exited 0 with structural validation
passed. Research was active and the canonical result unresolved. Requested
routing was Astra/xhigh; observed runtime identity/effort is not independently
exposed by these tools. This worker changed only this review and its temporary
probes. No reviewed source, root imports, state, Git or cache was changed.

The 267-line reviewed file is `LonelyRunner/PairSumCompleteness.lean`, SHA-256
`838a3bcec806b0e9d01cd117e64e5348de58a05127a3f7bef5dbe2d879ff292f`.
The complete settled contract is `research/astra-pair-sum-cell-contract.md`,
SHA-256 `1b441ec0b0145007cf18bce59482396d175634cdd34d3ba4edba8c0376cb7c8f`.
Both hashes were asserted before and after the successful replay. No source
change was requested to make a check pass.

The eight public declarations were checked in their complete source context:

| Declaration in `LonelyRunner` | Exact accepted scope |
| --- | --- |
| `circleNorm_le_abs_sub_int` | Every real phase and every prescribed integer lift. |
| `int_band_of_circleNorm_ge` | Closed unit-band hypotheses give both closed margin inequalities; no positivity assumption is silently added. |
| `exists_balanced_pairSum_cell_peak` | At least two original labels, positive natural speeds, natural floors below their speeds, and supplied closed positive-margin bands. Output retains distinct original labels, positive bounded numerator, both balanced equations, every closed band, and `δ ≤ M ≤ 1/2`. |
| `exists_pairSum_time_of_witness` | Every supplied real-time witness with arbitrary positive real margin for the positive natural tuple yields a positive original-pair time preserving that margin. Repeated speeds are allowed. |
| `pairSumCertificate_of_witness` | Specializes the margin to `1/N`, with `N > 0` and at least two moving labels; `N` is independent of the moving count. |
| `exists_witness_iff_pairSumCertificate` | Exact fixed-instance equivalence under those same assumptions. |
| `positiveIntegerConjecture_iff_pairSumCertificateConjecture` | Exact all-dimensional positive-integer equivalence, with injectivity required by those propositions and the one-moving-runner case supplied by the old base theorem. |
| `conjecture_iff_pairSumCertificateConjecture` | Exact composition with the already established global BHK canonical equivalence, retaining every total count, injective real speed assignment, chosen runner and closed canonical boundary. |

The decisive finite-cell argument has the correct orientation. With positive
speeds `W_i`, define

```
L_i(m) = (z_i + m) / W_i
R_i(m) = (z_i + 1 - m) / W_i
C_ij = (W_i (z_j + 1) - W_j z_i) / (W_i + W_j).
```

Positive-denominator clearing proves `m ≤ C_ij ↔ L_i(m) ≤ R_j(m)`.
The supplied bands imply `δ ≤ C_ij` for **every ordered pair**, including
diagonals. The source takes an attained minimum on the full finite product.
For a minimizing pair `(p,q)`, it sets `M=C_pq` and
`T=(z_p+z_q+1)/(W_p+W_q)`. Its active identities are
`L_p(M)=T=R_q(M)`. The comparisons `(i,q)` yield every lower band;
`(p,i)` yield every upper band. Reversing or dropping one orientation would
lose the stated conclusion; the actual source uses both correctly.

The diagonal values are exactly `1/2`, so the same minimum gives `M≤1/2`.
If the selected labels coincide, the active equations force `M=1/2` and all
closed bands collapse to their midpoints. The source then selects labels 0
and 1, which are distinct because `n≥2`, and keeps both balanced equations
and every band. It does not assert that their speeds differ, and does not
deduplicate the tuple. In either branch, `r=z_p+z_q+1` is a natural number
with `0<r<W_p+W_q`, using `z_i<W_i`; the cast/division identities are retained.
Thus the final time is strictly between 0 and 1.

The arbitrary-time wrapper first takes `tau=Int.fract time`, so negative and
integer-shifted input times are included. Integer speeds preserve each circle
norm under this normalization. The normalized phases lie in `[0,W_i)`, their
natural floors satisfy `z_i<W_i`, and the integer-band helper recovers both
closed inequalities from the original margin. The peak's full bands yield
circle norms at least `M`, hence at least the original `δ`. No full-tuple
witness is imported: it is an explicit premise of this implication.

The fixed-certificate wrapper discards the positive-numerator and peak fields
only because the existing certificate stores the weaker `r<D` field. Its
analytic/natural-residue bridge is the preexisting `PairSumGeometry` theorem.
`N=1` is included but has an impossible positive-speed input witness; `N=2`
correctly includes half-distance examples, even with repeated speeds and
moving count two. Omitting `N>0` or `n≥2` is genuinely invalid, as checked
below. The all-dimensional integer reverse implication covers `n=1` with
`oneMovingRunner`, then uses the certificate for `n≥2`. The canonical reverse
route uses the established all-dimensional BHK equivalence, not a fixed-count
real-to-integer claim or a change of distinguished runner.

The helper certifies an attained peak of the supplied finite cell. It does not
state a global maximum over all cells or times. This exact balanced helper is
suitable for replacing the balanced-witness premise in the accepted one-anchor
manuscript argument. The one-anchor packet construction is still a manuscript,
and this equivalence does not supply a uniform `H_N` time selector.

The fresh probe hoists exactly the six imports already present in the source,
strips only its import lines and appends its entire body, then adds the controls.
It never imports `LonelyRunner.PairSumCompleteness` or the root module. Recursive
inspection found 27 local preexisting source dependencies, none importing the
reviewed module directly or transitively. The generator binds their complete
hash manifest, the toolchain and Lake manifest; those checks prevent a stale
reviewed-body import shortcut. Imported preexisting dependencies use the shared
pinned cache. Root separately reported its completed full build (3638 jobs,
exit 0) before this worker started Lean. That root build is coordination/context,
not substituted for this independent fresh-body replay.

The final command was
`python3 -B /tmp/astra-pair-sum-review.py > /tmp/astra-pair-sum-review-run5.log 2>&1`,
which runs `lake env lean /tmp/astra-pair-sum-review.lean` with
`/home/joshua/.elan/bin` prepended to `PATH`. Both exits were 0. There is no
`-o` flag and no worker build/cache restoration. The proof source is scanned
against `sorry`, `admit`, `native_decide` and explicit custom `axiom` tokens;
`#print axioms` then checks the transitive trust of each reviewed declaration.

The 16 named controls comprise one generic closed-band helper, twelve specific
fixture/exclusion proofs, and three exact generic interface proofs. They are
supplemental to the full unbounded proof, not finite evidence in its place:

| Control | What is established by Lean |
| --- | --- |
| Repeated `(1,1)`, time `-5/2`, `N=2` | An actual half-distance input, its certificate, and output with two distinct original labels whose speeds remain equal. |
| `(1,2)`, time `1/3`, `N=3` | Closed equality at the conjecture threshold and a certificate from the actual input. |
| `(1,2)`, time `-7/3`, `N=3` | Nonhalf negative-time normalization, with floors `(-3,-5)` used only to prove the input witness. |
| `(1,3,4)`, input `5/12`, margin `1/4`, cell `(0,1,1)` | The helper itself supplies the existential output; finite elimination of the two returned labels and the retained bands proves **that output** has `M=2/7`, `T=3/7`. Both active equations and every band remain in the proved result. |
| `(2,3)`, time `4/5`, margin `2/5` | Actual closed witness at the positive last possible numerator `r=D−1=4`. |
| One index, speed 1 | A half-distance witness exists, but a pair certificate is impossible because no two original labels differ. |
| `N=0`, two speeds 1 | Analytic inverse-zero threshold has a witness, but the positive denominator cannot satisfy a zero-scaled residue certificate. |
| `N=1`, two speeds 1 | No input witness exists; the claimed positive-`N` theorem is not an unconditional existence assertion. |
| Generic fixed and positive/canonical iff proofs | Exact independent `n,N` quantification and the expanded all-dimensional certificate proposition; the canonical side explicitly retains all real labelled tuples and all chosen runners. |

There are exactly 24 axiom reports: eight reviewed public declarations and
16 named controls. All eight public reports and 14 controls list precisely
`propext`, `Classical.choice`, `Quot.sound`; the two elementary impossibility
controls list only `propext`. No accepted report contains `sorryAx` or another
axiom. The final output contains only five source linter warnings: an unused
`hδ` in the stronger-than-needed cell helper and four unnecessary sequencing
warnings. These do not weaken its statement or add trust assumptions.

Four earlier complete probes exited 1 on review-control code. Attempt 1 had
ambiguous natural/real literals, a resulting elaboration heartbeat timeout,
closed diagonal goals, and unnormalized arithmetic. Attempt 2 retained only
the closed-goal tactic issue and a real/natural literal coercion. Attempt 3
needed explicit simplification of vector literal index 2 in the third band.
Attempt 4 tried an overly strong definitional `change` across real numeral
arithmetic. The final control uses `Matrix.cons_val_two` and passes. The frozen
body's eight reports already contained only permitted axioms in each failed
attempt; any `sorryAx` output in those rejected runs belonged to failed control
elaboration and was never accepted as evidence. No reviewed source was edited.

The replay generator below is complete. Save its contents byte-for-byte as
`/tmp/astra-pair-sum-review.py` and run the command above. A different optional
output prefix is supported, but changes paths embedded in warning output and
therefore the output hash. The default path reproduces the recorded probe.
After the final successful run, all owned Lean/Python processes terminated.
Only this evidence manuscript was then written and checked; no further
source compilation is pending.

```python
#!/usr/bin/env python3
"""Fresh frozen-body semantic review; no reviewed .olean or output .olean."""
from pathlib import Path
import hashlib, json, os, re, subprocess, sys
ROOT = Path('/home/joshua/lonely-runner-formalization')
SOURCE = 'LonelyRunner/PairSumCompleteness.lean'
SOURCE_SHA = '838a3bcec806b0e9d01cd117e64e5348de58a05127a3f7bef5dbe2d879ff292f'
CONTRACT = 'research/astra-pair-sum-cell-contract.md'
CONTRACT_SHA = '1b441ec0b0145007cf18bce59482396d175634cdd34d3ba4edba8c0376cb7c8f'
OUT = Path(sys.argv[1] if len(sys.argv) > 1 else '/tmp/astra-pair-sum-review')
PUBLIC = ['circleNorm_le_abs_sub_int', 'int_band_of_circleNorm_ge',
 'exists_balanced_pairSum_cell_peak', 'exists_pairSum_time_of_witness',
 'pairSumCertificate_of_witness', 'exists_witness_iff_pairSumCertificate',
 'positiveIntegerConjecture_iff_pairSumCertificateConjecture',
 'conjecture_iff_pairSumCertificateConjecture']
CONTROLS = r'''
namespace PairSumReview
open LonelyRunner
set_option maxHeartbeats 1000000

-- Every fixture proves its actual analytic premise through closed integer bands.
theorem band {n : ℕ} (W : Fin n → ℕ) (z : Fin n → ℤ) (t δ : ℝ)
    (h0 : 0 ≤ δ) (hh : δ ≤ (1 : ℝ) / 2)
    (hl : ∀ i, (z i : ℝ) + δ ≤ t * (W i : ℝ))
    (hu : ∀ i, t * (W i : ℝ) ≤ (z i : ℝ) + 1 - δ) :
    ∀ i, δ ≤ circleNorm (t * (W i : ℝ)) := by
  intro i
  exact circleNorm_ge_of_int_band (z i) _ _ h0 hh (hl i) (hu i)

theorem repeated_negative_input :
    ∀ i : Fin 2, (1 : ℝ) / 2 ≤ circleNorm ((-5 / 2 : ℝ) *
      ((fun _ : Fin 2 => (1 : ℕ)) i : ℝ)) := by
  apply band (fun _ : Fin 2 => (1 : ℕ)) (fun _ => -3) (-5 / 2) (1 / 2)
  all_goals norm_num

theorem repeated_N2_certificate : PairSumCertificate 2 (fun _ : Fin 2 => (1 : ℕ)) := by
  apply pairSumCertificate_of_witness (by omega) _ (by omega) (by intro i; norm_num)
    (-5 / 2)
  simpa using repeated_negative_input

theorem repeated_original_labels :
    ∃ p q : Fin 2, p ≠ q ∧ (fun _ : Fin 2 => (1 : ℕ)) p = (fun _ : Fin 2 => (1 : ℕ)) q ∧
      ∃ r : ℕ, 0 < r ∧ r < 2 ∧
        ∀ i : Fin 2, (1 : ℝ) / 2 ≤ circleNorm (((r : ℝ) / 2) *
          ((fun _ : Fin 2 => (1 : ℕ)) i : ℝ)) := by
  obtain ⟨p, q, hpq, r, hr0, hrlt, hgood⟩ :=
    exists_pairSum_time_of_witness (by omega) (fun _ : Fin 2 => (1 : ℕ))
      (by intro i; norm_num) (1 / 2) (-5 / 2) (by norm_num) repeated_negative_input
  exact ⟨p, q, hpq, rfl, r, hr0, hrlt, by simpa using hgood⟩

theorem nonhalf_N3_equality : PairSumCertificate 3 (![1, 2] : Fin 2 → ℕ) := by
  apply pairSumCertificate_of_witness (by omega) _ (by omega)
    (by intro i; fin_cases i <;> norm_num) (1 / 3)
  have h := band (![1, 2] : Fin 2 → ℕ) (fun _ => 0) (1 / 3) (1 / 3)
    (by norm_num) (by norm_num)
    (by intro i; fin_cases i <;> norm_num)
    (by intro i; fin_cases i <;> norm_num)
  simpa using h

theorem nonhalf_negative_shift : PairSumCertificate 3 (![1, 2] : Fin 2 → ℕ) := by
  apply pairSumCertificate_of_witness (by omega) _ (by omega)
    (by intro i; fin_cases i <;> norm_num) (-7 / 3)
  have h := band (![1, 2] : Fin 2 → ℕ) ![-3, -5] (-7 / 3) (1 / 3)
    (by norm_num) (by norm_num)
    (by intro i; fin_cases i <;> norm_num)
    (by intro i; fin_cases i <;> norm_num)
  simpa using h

-- Obtain the output through the frozen helper, then prove its exact cell peak.
theorem balanced_134_exact :
    ∃ p q : Fin 3, p ≠ q ∧ ∃ (r : ℕ) (M T : ℝ),
      0 < r ∧ r < (![1, 3, 4] : Fin 3 → ℕ) p + (![1, 3, 4] : Fin 3 → ℕ) q ∧
      T = (r : ℝ) / (((![1, 3, 4] : Fin 3 → ℕ) p +
        (![1, 3, 4] : Fin 3 → ℕ) q : ℕ) : ℝ) ∧
      M = (2 : ℝ) / 7 ∧ T = (3 : ℝ) / 7 ∧
      T * ((![1, 3, 4] : Fin 3 → ℕ) p : ℝ) =
        ((![0, 1, 1] : Fin 3 → ℕ) p : ℝ) + M ∧
      T * ((![1, 3, 4] : Fin 3 → ℕ) q : ℝ) =
        ((![0, 1, 1] : Fin 3 → ℕ) q : ℝ) + 1 - M ∧
      ∀ i, ((![0, 1, 1] : Fin 3 → ℕ) i : ℝ) + M ≤
        T * ((![1, 3, 4] : Fin 3 → ℕ) i : ℝ) ∧
        T * ((![1, 3, 4] : Fin 3 → ℕ) i : ℝ) ≤
          ((![0, 1, 1] : Fin 3 → ℕ) i : ℝ) + 1 - M := by
  obtain ⟨p, q, hpq, r, M, T, hr0, hrlt, hT, hMlo, hMhi, hp, hq, hb⟩ :=
    exists_balanced_pairSum_cell_peak (by omega)
      (![1, 3, 4] : Fin 3 → ℕ) ![0, 1, 1]
      (by intro i; fin_cases i <;> norm_num)
      (by intro i; fin_cases i <;> norm_num)
      (1 / 4) (5 / 12) (by norm_num)
      (by intro i; fin_cases i <;> norm_num)
      (by intro i; fin_cases i <;> norm_num)
  have heq : M = (2 : ℝ) / 7 ∧ T = (3 : ℝ) / 7 := by
    have h0 := hb 0
    have h1 := hb 1
    have h2 := hb 2
    norm_num [Matrix.cons_val_two] at h2
    fin_cases p <;> fin_cases q
    all_goals try { exact False.elim (hpq rfl) }
    all_goals norm_num at hp hq h0 h1 h2 ⊢
    all_goals constructor <;> linarith
  exact ⟨p, q, hpq, r, M, T, hr0, hrlt, hT, heq.1, heq.2, hp, hq, hb⟩

theorem positive_last_numerator :
    ∃ r : ℕ, 0 < r ∧ r < 2 + 3 ∧ r = (2 + 3) - 1 ∧
      ∀ i : Fin 2, (2 : ℝ) / 5 ≤
        circleNorm (((r : ℝ) / (2 + 3)) * ((![2, 3] : Fin 2 → ℕ) i : ℝ)) := by
  refine ⟨4, by omega, by omega, by omega, ?_⟩
  have h := band (![2, 3] : Fin 2 → ℕ) ![1, 2] (4 / 5) (2 / 5)
    (by norm_num) (by norm_num)
    (by intro i; fin_cases i <;> norm_num)
    (by intro i; fin_cases i <;> norm_num)
  norm_num at h ⊢
  exact h

theorem one_index_has_witness :
    ∃ t : ℝ, ∀ i : Fin 1, (2 : ℝ)⁻¹ ≤ circleNorm (t *
      ((fun _ : Fin 1 => (1 : ℕ)) i : ℝ)) := by
  refine ⟨1 / 2, ?_⟩
  have h := band (fun _ : Fin 1 => (1 : ℕ)) (fun _ => 0) (1 / 2) (1 / 2)
    (by norm_num) (by norm_num) (by intro i; norm_num) (by intro i; norm_num)
  simpa using h

theorem one_index_no_pair : ¬ PairSumCertificate 2 (fun _ : Fin 1 => (1 : ℕ)) := by
  rintro ⟨p, q, hpq, _⟩
  exact hpq (Subsingleton.elim _ _)

theorem N0_has_witness :
    ∃ t : ℝ, ∀ i : Fin 2, (0 : ℝ)⁻¹ ≤ circleNorm (t *
      ((fun _ : Fin 2 => (1 : ℕ)) i : ℝ)) := by
  refine ⟨0, ?_⟩
  intro i
  simp [circleNorm]

theorem N0_no_certificate : ¬ PairSumCertificate 0 (fun _ : Fin 2 => (1 : ℕ)) := by
  rintro ⟨p, q, hpq, r, hr, h⟩
  have hi := h 0
  norm_num at hi

theorem N1_no_input :
    ¬ ∃ t : ℝ, ∀ i : Fin 2, (1 : ℝ)⁻¹ ≤ circleNorm (t *
      ((fun _ : Fin 2 => (1 : ℕ)) i : ℝ)) := by
  rintro ⟨t, h⟩
  obtain ⟨p, q, hpq, r, hr, hgood⟩ :=
    pairSumCertificate_of_witness (by omega) (fun _ : Fin 2 => (1 : ℕ))
      (N := 1) (by omega) (by intro i; norm_num) t (by simpa using h)
  have hi := hgood 0
  change r < 2 at hr
  interval_cases r <;> norm_num [cyclicResidueDistance] at hi

-- N is not tied to the number n of moving indices, and speeds need not inject.
theorem generic_fixed_iff {n N : ℕ} (hn : 2 ≤ n)
    (W : Fin n → ℕ) (hN : 0 < N) (hpos : ∀ i, 0 < W i) :
    (∃ t : ℝ, ∀ i, (N : ℝ)⁻¹ ≤ circleNorm (t * (W i : ℝ))) ↔
      PairSumCertificate N W :=
  exists_witness_iff_pairSumCertificate hn W hN hpos

theorem generic_positive_iff : PositiveIntegerConjecture ↔
    (∀ n : ℕ, 2 ≤ n → ∀ W : Fin n → ℕ, Function.Injective W →
      (∀ i, 0 < W i) → PairSumCertificate (n + 1) W) :=
  positiveIntegerConjecture_iff_pairSumCertificateConjecture

theorem generic_canonical_iff :
    (∀ n : ℕ, 2 ≤ n → ∀ W : Fin n → ℝ, Function.Injective W →
      ∀ r : Fin n, ∃ t : ℝ, LonelyAt W r t) ↔
    (∀ n : ℕ, 2 ≤ n → ∀ W : Fin n → ℕ, Function.Injective W →
      (∀ i, 0 < W i) → PairSumCertificate (n + 1) W) :=
  conjecture_iff_pairSumCertificateConjecture

end PairSumReview
'''

def sha(data):
    return hashlib.sha256(data).hexdigest()
assert sha((ROOT / SOURCE).read_bytes()) == SOURCE_SHA
assert sha((ROOT / CONTRACT).read_bytes()) == CONTRACT_SHA
body = (ROOT / SOURCE).read_text()
imports = re.findall(r'^import (\S+)\s*$', body, re.M)
closure = {}
def visit(module):
    assert module != 'LonelyRunner.PairSumCompleteness', module
    path = ROOT / (module.replace('.', '/') + '.lean')
    if not path.is_file() or module in closure:
        return
    data = path.read_bytes()
    closure[module] = sha(data)
    for dependency in re.findall(r'^import (\S+)\s*$', data.decode(), re.M):
        visit(dependency)
for module in imports:
    visit(module)
manifest = json.dumps(closure, sort_keys=True, indent=2) + '\n'
assert sha(manifest.encode()) == '10b1c322ee318990fce74dc83e2a62bf8eeac3e565ec3d088af24ccc313c2c64'
for p, expected in {
    'lean-toolchain': '8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af',
    'lake-manifest.json': '887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218'
}.items():
    assert sha((ROOT / p).read_bytes()) == expected
OUT.with_suffix('.dependencies.json').write_text(manifest)
controls = re.findall(r'^theorem ([A-Za-z0-9_]+)', CONTROLS, re.M)
names = ['LonelyRunner.' + x for x in PUBLIC] + ['PairSumReview.' + x for x in controls]
probe = '\n'.join('import ' + m for m in imports) + '\n' + re.sub(
    r'^import \S+\s*$', '', body, flags=re.M) + '\n' + CONTROLS + '\n'
probe += '\n'.join('#print axioms ' + x for x in names) + '\n'
assert 'import LonelyRunner.PairSumCompleteness' not in probe
assert not re.search(r'\b(sorry|admit|native_decide|axiom)\b',
                     re.sub(r'/\-.*?\-/', '', probe, flags=re.S))
OUT.with_suffix('.lean').write_text(probe)
env = dict(os.environ, PATH='/home/joshua/.elan/bin:' + os.environ.get('PATH', ''))
command = ['lake', 'env', 'lean', str(OUT.with_suffix('.lean'))]
result = subprocess.run(command, cwd=ROOT, env=env, text=True,
                        stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
OUT.with_suffix('.log').write_text(result.stdout)
reports = {name: sorted(a.strip() for a in axioms.split(',') if a.strip())
           for name, axioms in re.findall(
             r"'([^']+)' depends on axioms: \[([^\]]*)\]", result.stdout, re.S)}
for name in re.findall(r"'([^']+)' does not depend on any axioms", result.stdout):
    reports[name] = []
allowed = {'propext', 'Classical.choice', 'Quot.sound'}
metadata = {'source': SOURCE, 'source_sha256': SOURCE_SHA,
 'contract_sha256': CONTRACT_SHA,
 'generator_sha256': sha(Path(__file__).read_bytes()),
 'probe_sha256': sha(OUT.with_suffix('.lean').read_bytes()),
 'output_sha256': sha(OUT.with_suffix('.log').read_bytes()),
 'dependency_manifest_sha256': sha(manifest.encode()),
 'local_dependency_count': len(closure),
 'pinned_files': {p: sha((ROOT / p).read_bytes())
                  for p in ['lean-toolchain', 'lake-manifest.json']},
 'command': command, 'exit_code': result.returncode,
 'public_report_count': len(PUBLIC), 'control_report_count': len(controls),
 'reports': reports}
OUT.with_suffix('.json').write_text(json.dumps(metadata, sort_keys=True, indent=2) + '\n')
print(json.dumps({k:v for k,v in metadata.items() if k != 'reports'}, indent=2))
print(result.stdout)
assert result.returncode == 0
assert set(reports) == set(names), (set(names) - set(reports), set(reports) - set(names))
assert all(set(axioms) <= allowed for axioms in reports.values())
assert sha((ROOT / SOURCE).read_bytes()) == SOURCE_SHA
assert sha((ROOT / CONTRACT).read_bytes()) == CONTRACT_SHA
print('PASS: complete fresh source; all controls; exactly', len(names),
      'allowed-axiom reports; frozen hashes unchanged.')
```

Exact final replay metadata:

```json
{
  "command": [
    "lake",
    "env",
    "lean",
    "/tmp/astra-pair-sum-review.lean"
  ],
  "contract_sha256": "1b441ec0b0145007cf18bce59482396d175634cdd34d3ba4edba8c0376cb7c8f",
  "control_report_count": 16,
  "dependency_manifest_sha256": "10b1c322ee318990fce74dc83e2a62bf8eeac3e565ec3d088af24ccc313c2c64",
  "exit_code": 0,
  "generator_sha256": "6e469b398c5fbc67668d1f358cfd87d93b51e505de31f36263efee9ccd08d150",
  "local_dependency_count": 27,
  "output_sha256": "c1ce518a732638af389de5047e07db3be7ad5ab42e09c0f05f1a1b1aee0c0e76",
  "pinned_files": {
    "lake-manifest.json": "887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218",
    "lean-toolchain": "8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af"
  },
  "probe_sha256": "c16c6b443231d82ea3feb19f4b2f4cf4d2d4bc4e1d42af153fa2497499f93333",
  "public_report_count": 8,
  "source": "LonelyRunner/PairSumCompleteness.lean",
  "source_sha256": "838a3bcec806b0e9d01cd117e64e5348de58a05127a3f7bef5dbe2d879ff292f"
}
```

Complete local dependency hash manifest:

```json
{
  "LonelyRunner.BHKAdjacentPair": "3d36d812db7ed18db8fce521b2505d5904a8387d8e315c6e7d08d9eb7dc75708",
  "LonelyRunner.BHKAdjacentRatios": "677c365618fc612a5ee7d3d9e9696273da2d9e775b77487d0b3e208cea9d6733",
  "LonelyRunner.BHKBridgeAssembly": "85cdff6609ffe604c1a090b000e7ea34a4155a384b9ced55a52ee277793d3f57",
  "LonelyRunner.BHKBridgeCore": "43d0371d3fa213daa895d5431e9cfdd28d79d2de4ba89e02d9a9da93273678a3",
  "LonelyRunner.BHKCollisionToWitness": "42e7665af7981ef336ab4e1826ff3f096e6d6855b50440f76e2ede7a538f7f87",
  "LonelyRunner.BHKNongenericRow": "0780c53aa676a356e6e0b2ce1d451c51bc15690f65bd4e121c9125cebd86c3ec",
  "LonelyRunner.BHKPositiveCollision": "7569f6798bc42be6ffd5ae04e0f8110f386f941aa58f02a2f168d597a17a514e",
  "LonelyRunner.BHKRealReduction": "98d7c878eef7e4a3b7f7c504c882cf35191c1343816a59d731193ac8a207ed26",
  "LonelyRunner.BaseCases": "31e2c328e060c077c6c9928e3fb431601326e4e54a949ee5148aed5cd3687d1f",
  "LonelyRunner.Definitions": "5f0258a6ab99950fc7045b2200d6708fe7603d3caa4d62855ef2b19a330c95aa",
  "LonelyRunner.FastRunnerInsertion": "dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5",
  "LonelyRunner.Formulations": "0c3328e975bee236ff66862d3a5cadeb58fbc7c804fa953e53701ba466b9d788",
  "LonelyRunner.KroneckerAveraging": "101efb0a698d89b445682decc9771efa5350e250beeefe1e3f08db34ce446ca2",
  "LonelyRunner.KroneckerCharacters": "88cb49a836f51050855fffd8f0c7e68fb680345652f183765315e873752fb926",
  "LonelyRunner.KroneckerOrbit": "c152c31987265ee86cc7590d2f3148695cda97adbe20fa55b7880c4648f64487",
  "LonelyRunner.KroneckerSeparation": "50e0ff4babbe451598f84ada0907180bb17b0a8f8ae5aa84d7cb923d227c4198",
  "LonelyRunner.KroneckerSeparationSetup": "782a05f6ce6816a355addab21a9cc9ca9abccaa555884af10588437da9af6fa3",
  "LonelyRunner.Normalization": "20193ad984f308ce8512930fe683d3118a2b3b5c18636a6a1f4454aa6df43797",
  "LonelyRunner.PairSumGeometry": "3bc47a6f1a77950577edc54b571e9809bb03bffd37575ebc10bae0fcfcab9384",
  "LonelyRunner.PivotBoundary": "0e56cab74d30ef8b537ed4ec24503aae875bd8aadc369d26da99ba882cc3603f",
  "LonelyRunner.PivotResidues": "362da5ab923f22e900ae7ac821dd4cf4aab91dfe70889987bc9e5a05d19c276a",
  "LonelyRunner.PositiveRationalRelation": "7f45dee887a837ed4564f0516f5141f154e0a2d32594e7eb57cf1afa0a3eeb29",
  "LonelyRunner.RationalReduction": "c707227a24eb53d06b20ff00e2e86ce52c158ba7eed55c1d8eba32cf9c457a4e",
  "LonelyRunner.RationalRelationSpace": "540f0ef0da35cea31a6c82d063a8c2fde84ddf18e6f04abb6f73740b230fd11a",
  "LonelyRunner.RepeatedStationaryEquivalence": "ae4ce972eb4a8969e671f982e8cb1c9e4ea99c59b529008da8b6a9e2f38bdc04",
  "LonelyRunner.StationaryEquivalence": "12dce8930c34b211bc01e2dc21e932087270726bce2bf127fa2d8d6594544b49",
  "LonelyRunner.StructuredClasses": "5328a7a88d2b42f86ffc3f0f0418ca22c761219e8fa3e5822bda5a18ac286e8c"
}
```

Complete final Lean output:

```text
/tmp/astra-pair-sum-review.lean:51:18: warning: Variable name `hδ` is not explicitly referenced.

The binding can be removed (if unused) or named `_` (if used implicitly).

Note: This linter can be disabled with `set_option linter.unusedVariables false`
/tmp/astra-pair-sum-review.lean:112:24: warning: Used `tac1 <;> tac2` where `(tac1; tac2)` would suffice

Note: This linter can be disabled with `set_option linter.unnecessarySeqFocus false`
/tmp/astra-pair-sum-review.lean:116:24: warning: Used `tac1 <;> tac2` where `(tac1; tac2)` would suffice

Note: This linter can be disabled with `set_option linter.unnecessarySeqFocus false`
/tmp/astra-pair-sum-review.lean:172:60: warning: Used `tac1 <;> tac2` where `(tac1; tac2)` would suffice

Note: This linter can be disabled with `set_option linter.unnecessarySeqFocus false`
/tmp/astra-pair-sum-review.lean:172:74: warning: Used `tac1 <;> tac2` where `(tac1; tac2)` would suffice

Note: This linter can be disabled with `set_option linter.unnecessarySeqFocus false`
'LonelyRunner.circleNorm_le_abs_sub_int' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.int_band_of_circleNorm_ge' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.exists_balanced_pairSum_cell_peak' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.exists_pairSum_time_of_witness' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.pairSumCertificate_of_witness' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.exists_witness_iff_pairSumCertificate' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.positiveIntegerConjecture_iff_pairSumCertificateConjecture' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'LonelyRunner.conjecture_iff_pairSumCertificateConjecture' depends on axioms: [propext, Classical.choice, Quot.sound]
'PairSumReview.band' depends on axioms: [propext, Classical.choice, Quot.sound]
'PairSumReview.repeated_negative_input' depends on axioms: [propext, Classical.choice, Quot.sound]
'PairSumReview.repeated_N2_certificate' depends on axioms: [propext, Classical.choice, Quot.sound]
'PairSumReview.repeated_original_labels' depends on axioms: [propext, Classical.choice, Quot.sound]
'PairSumReview.nonhalf_N3_equality' depends on axioms: [propext, Classical.choice, Quot.sound]
'PairSumReview.nonhalf_negative_shift' depends on axioms: [propext, Classical.choice, Quot.sound]
'PairSumReview.balanced_134_exact' depends on axioms: [propext, Classical.choice, Quot.sound]
'PairSumReview.positive_last_numerator' depends on axioms: [propext, Classical.choice, Quot.sound]
'PairSumReview.one_index_has_witness' depends on axioms: [propext, Classical.choice, Quot.sound]
'PairSumReview.one_index_no_pair' depends on axioms: [propext]
'PairSumReview.N0_has_witness' depends on axioms: [propext, Classical.choice, Quot.sound]
'PairSumReview.N0_no_certificate' depends on axioms: [propext]
'PairSumReview.N1_no_input' depends on axioms: [propext, Classical.choice, Quot.sound]
'PairSumReview.generic_fixed_iff' depends on axioms: [propext, Classical.choice, Quot.sound]
'PairSumReview.generic_positive_iff' depends on axioms: [propext, Classical.choice, Quot.sound]
'PairSumReview.generic_canonical_iff' depends on axioms: [propext, Classical.choice, Quot.sound]
```

Attempt receipts (only run5 is accepted):

```json
[
  {
    "run": "run",
    "exit_code": 1,
    "generator_sha256": "c50bac07494da4ddaa8b445f7dad7422ec53139c0d70ce57e126aa95b3abb999",
    "probe_sha256": "cc53a1bf628f9cfc0d02ba8769f9da88fcbe0cbf9af977a4ea04764ad6c7e703",
    "lean_output_sha256": "df13a1f2010d1602bc9bc808386f45a94e6f42f4e7b5a9902e565be7ef72f583",
    "driver_log_sha256": "2d2c733e1f8aa7a63a5b0577c2d4869a8c93a874d41e51b8cd99e996e99cf430"
  },
  {
    "run": "run2",
    "exit_code": 1,
    "generator_sha256": "912d808df062dee64e69f23f916a0be9b8ce0000941308a34d8a6488a30d1aca",
    "probe_sha256": "bc8c5648f9d23ba4a03c0d116395bea8fb64ddeb0f010cc8ba90b8fd3647d6eb",
    "lean_output_sha256": "d6da90e65d6e698d3d60cfa0b6c369e84a85f1bcda93beb7483a806dd3c290e5",
    "driver_log_sha256": "28f680f1b908d0f760a2161043c0754883d10b53575f9d1d1cb48a97c661fb8c"
  },
  {
    "run": "run3",
    "exit_code": 1,
    "generator_sha256": "fea7eb2256075c6ce4a1445318d92575f77ba59d2281bc17212192955be45812",
    "probe_sha256": "b56d6ae62dc340d8b2d94d7febb8a38a66364ad7003135b3dfede6d0f28e61d4",
    "lean_output_sha256": "e074718b54964f1efc18b3e657885ab863e40b4cb137c8006bf5c150aafac80c",
    "driver_log_sha256": "bffc515b5123f4c7ec0bbf4d3e3907b8882f40b7a749ec6b6850e798093ce647"
  },
  {
    "run": "run4",
    "exit_code": 1,
    "generator_sha256": "a51860b00d5d9c0693f655c54c3173e4b7455a5cfbb189179e1ec0e293c9aa2d",
    "probe_sha256": "cc4bb68f4cd116457a7733028f922b4ab34e94e9faf9207c1ff85bff866b5fcf",
    "lean_output_sha256": "9c2f0e6d6ce9912fb1c26c852d6a819b760eaa352da6cfb0f63a76e79cd1a6e5",
    "driver_log_sha256": "37594aa6fe9e17a4e494461d410f3508a78483193f33f639d6c8d2154769f4de"
  },
  {
    "run": "run5",
    "exit_code": 0,
    "generator_sha256": "6e469b398c5fbc67668d1f358cfd87d93b51e505de31f36263efee9ccd08d150",
    "probe_sha256": "c16c6b443231d82ea3feb19f4b2f4cf4d2d4bc4e1d42af153fa2497499f93333",
    "lean_output_sha256": "c1ce518a732638af389de5047e07db3be7ad5ab42e09c0f05f1a1b1aee0c0e76",
    "driver_log_sha256": "27995dee67f5a20a2d8d811a211326a94aa792022698ffa49f053973b6a0fcaa"
  }
]
```

Final disposition: accepted, with no source defect found. The remaining unrestricted obligation is a proof or disproof of the all-dimensional pair-sum certificate proposition (equivalently the canonical conjecture). This checkpoint establishes the equivalence, not that obligation. All owned commands are stopped at freeze.
