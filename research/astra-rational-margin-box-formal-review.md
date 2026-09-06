# Independent formal review of rational-margin boxes and the two-leaf pilot

2026-09-06. Assigned reviewer `/root/mss_published_bound_audit`, requested
Astra/xhigh; routing is not independently attested. Source base:
`84eacffc06cabd017d67c53d1d70995a8d25de3d`. Configuration, workflow, policy
and current task state were read; workflow validation passed. Only this review
is owned, except root's separately requested prose-only correction to the
previous direct-proof screen. No Lean source, other report, Git, state or cache
is changed by this review.

Semantic verdict: the two exact source files implement the accepted box plan
correctly. Focused kernel checks and final acceptance are recorded below.
The pilot proves coverage of its stated twelve-row box. It supplies no
finite K5 certificate, universal five-total-runner theorem or full LRC result.

## Proof and contract assessment

I read both complete Lean files, the frozen implementation report and its
resource command. The generic raw leaf transfers its lower and upper
cross-products through the inequalities defining a contained row. Positive
coordinate denominator and q justify the real divisions. The resulting
two band inequalities themselves imply margin<=1/2, so the exact integer-band
norm lemma applies without an extra half-margin premise. Natural subtraction,
an asserted floor identity, injectivity and positive speeds are not used.
The public band field is a band index. Thus margin zero at its integer upper
endpoint remains valid even though the actual floor has increased.

The raw theorem needs no well-formedness or nonempty-index premise. It can
accept an impossible margin on an empty raw box; its row conclusion is then
vacuous. The common-time theorem still checks positive p and q independently
and returns the particular time p/q for every contained row. The public tree
checker separately rejects any root with lo>hi. On a well-formed root, lo is
itself contained, so an impossible coordinate margin cannot be hidden in an
empty domain. For Fin 0, the empty function remains a row and the positive
time guards are retained.

Both child bounds are computed by Function.update: only the left upper
endpoint and right lower endpoint change, to cut and cut+1 respectively.
There are no user-supplied child rectangles and no one-child constructor.
The public split-cover theorem uses w_i<=cut versus its negation; natural
discreteness gives cut+1<=w_i on the right. Boundaries are closed on both
sides, with disjoint natural domains and no missing integer. Reverse child
inclusion and child well-formedness follow from the same definitions and
split guard; the exported forward coverage theorem is what the induction
actually requires.

Structural induction generalizes both B and w and extracts all three checked
split conditions, including both child checks. The chosen child's row theorem
retains positive p and a passing row whose q/denominator positivity is already
encoded. The public guard remains explicit in the checker, even though the
stronger raw core soundness proof does not need well-formedness. The final
tree theorem has forall row, exists positive time; only a leaf has one common
time across all its rows. It preserves every original closed rational margin.

The pilot literal is exactly lo=(2,3,5,6), hi=(3,4,5,8), split label 3 at 7,
with p/q=1/10 and bands all zero on the left, and p/q=5/32 with last band 1
on the right. The margins are the original fifth/fifth/fifth/quarter values.
The box size is the product 2*2*1*3=12; no enumeration is used by the universal
row theorem. The source proves the two-leaf count. Its named controls cover
the rejected unsplit/bad-cut/failing-child/wrong-band cases, both split
boundaries, repeated coordinates, zero margins/speeds, half equality,
above-half failure, zero p/q/denominator rejection and raw/public empty scope.
All acceptance and rejection controls use ordinary kernel decide.

Root and audit changes are additive: removing the two new imports reconstructs
the prior root bytes; removing those imports and the terminal 28-print section
reconstructs the prior audit bytes. The new modules import downward from the
existing rational-margin core. The old canonical fourRunners type remains
unchanged.

## Verification and resource provenance

Root's full build, session `87992`, ended with terminal exit 0 and 3651 jobs.
Root's trust run, session `60743`, ended with exit 0. I read the final logs
and checked all 497 dependency reports against the permitted axioms. There
are also two axiom-free declarations: existing normalizedBadCount and new
rationalMarginBoxPilot_fin_zero_accepts. A first read-only parser assertion
expected just one axiom-free declaration; inspecting the full log corrected
that count. This was a receipt-parser mismatch, not a theorem or trust failure.

| Root evidence | SHA-256 |
| --- | --- |
| `/tmp/astra-pass37-full-build.log` | `da77b590b789fb8c4cbae071bffa8a49e301a2d77104e4f8b6195ce652ee3081` |
| `/tmp/astra-pass37-trust.log` | `985809ea21823abb8b23def831cd0ce3522cb83d6b0364b52c247b07c5409d69` |
| Resource root-replay JSON | `12409bf47f32e923a09b0b4a707681f5354c2636ecc142055bce0dd6f72cef8f` |
| Resource root-replay stdout | `8750913f10f598e4ee295aa19e2652b6a24bc39dbd57315a84ad15a19617fe55` |

I read the complete monitor command, SHA
`7e79d8262730f7258e3b50fff058f778fad4e0fadac1d5e9699e3527cbd2c1e1`,
and verified its identity to the implementation report and root receipt.
It guards both sources, bounds the entire 5646-byte pilot source and this
fixed two-leaf certificate, and checks the complete source command. The root
replay reports monitor wall 1.853 seconds, GNU wall 1.87 seconds, sampled
descendant RSS sum 4,109,700 KiB, GNU peak 3,311,716 KiB, and child exit 0.
These values are below the recorded 60-second/4-GiB limits.

The RSS measurements have different meanings: the monitor samples the sum
over discovered descendants every 20 ms and stops on a sampled breach;
GNU time supplies a post-run peak check. This is not a continuous OS-enforced
aggregate-memory ceiling, and sampling can miss brief aggregate peaks.
The record supports this completed pilot, not arbitrary tree resources or a
large-domain compression claim. No reviewer performance rerun was necessary;
the earlier implementation run lacking RSS enforcement is explicitly historical.

## Guarded root-import kernel probe

The sole Python block binds all reviewed sources, plans/reports and dependencies,
checks old root/audit preservation and all 28 new audit entries, and executes
only the adjacent Lean stdin block. It handles both dependency-list and
axiom-free print formats. No tuple scan, new region, benchmark or cache cleanup
is executed.

```python
from hashlib import sha256
from pathlib import Path
import json, os, re, subprocess

guards = {
    'LonelyRunner/RationalMarginBoxes.lean':'9faab792a9e4120d931cb24eef071b072eee89a580d174f224ec2a7a123d51bf',
    'LonelyRunner/RationalMarginBoxPilot.lean':'25e144207b1ef4121c155f50d9ca9209655bcca46fdc40b1b06a4bc88f1f84e8',
    'LonelyRunner.lean':'a04502b8ac17cecdaa2aada77d66bac3e484e693f01c31c0b9d6f671cd586f96',
    'LonelyRunner/AxiomAudit.lean':'170d1b3937d0c58b0a4b0601a33b570bb9e504b6102d943c5ee29d49718bd5c1',
    'research/astra-rational-margin-box-pilot-implementation.md':'8f5993f3ae0721cfc1a075eb982f583b39ccc9a382f8419229c326d19adffbdb',
    'research/astra-rational-margin-box-pilot-plan.md':'0c1eecb6872e4c202643e5fdf237747b8262a06ed2de4cc7fea2bd84acf8a67a',
    'research/astra-rational-margin-box-pilot-plan-review.md':'c327faf2230f223ac8abf7036e9ce5d3d52b0c34ca2c935e8253f61c5444c61a',
    'research/astra-rational-margin-formal-review.md':'deec0d70183627c53bdafc631c6496700d0f7cb9fbce67d9512e3fb6019227d3',
    'LonelyRunner/RationalMarginCertificates.lean':'ffe31ce9636281f6c4b8fc2cdf618043a6c02b0195bf75ff6e0aee65c317c1d9',
    'LonelyRunner/StructuredClasses.lean':'5328a7a88d2b42f86ffc3f0f0418ca22c761219e8fa3e5822bda5a18ac286e8c',
    'LonelyRunner/PivotResidues.lean':'362da5ab923f22e900ae7ac821dd4cf4aab91dfe70889987bc9e5a05d19c276a',
    'LonelyRunner/FourRunnerCanonical.lean':'353b116d04d464fb9aedb92437e7f56168992e087a862f934044bc9062761c38',
    'lean-toolchain':'8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af',
    'lake-manifest.json':'887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218',
}
for path,digest in guards.items():
    assert sha256(Path(path).read_bytes()).hexdigest() == digest, path
root = Path('LonelyRunner.lean').read_text()
audit = Path('LonelyRunner/AxiomAudit.lean').read_text()
imports = r'^import LonelyRunner\.(RationalMarginBoxes|RationalMarginBoxPilot)\n'
assert len(re.findall(imports,root,re.M)) == 2
assert sha256(re.sub(imports,'',root,flags=re.M).encode()).hexdigest() == '4e2bcd1c805cba6ac47c42a95298fafaa80047829127b7f367eedb13575d8ff4'
old = audit.split('-- Exact box and partition soundness')[0].rstrip()+'\n'
assert sha256(re.sub(imports,'',old,flags=re.M).encode()).hexdigest() == 'f9dc948ca09cca91857ff9b75a21206ef82470fe774ac7bdb451c1ec3c17c54b'
source_names = []
for file in ('RationalMarginBoxes','RationalMarginBoxPilot'):
    source_names += re.findall(r'^theorem (\w+)',Path('LonelyRunner/'+file+'.lean').read_text(),re.M)
assert len(source_names) == 28
assert all('#print axioms LonelyRunner.'+name in audit for name in source_names)
names = tuple('LonelyRunner.'+s for s in (
    'rationalMarginBandLeafOK_row',
    'rationalMarginBandLeafOK_common_positive_time',
    'rationalMarginBox_split_cover',
    'rationalMarginBoxTreeOKCore_row',
    'rationalMarginBoxTreeOK_row',
    'rationalMarginBoxTreeOK_exists_positive_time',
    'rationalMarginBoxPilot_accepts',
    'rationalMarginBoxPilot_row',
    'rationalMarginBoxPilot_exists_positive_time',
    'rationalMarginBoxPilot_two_leaves',
    'rationalMarginBoxPilot_fin_zero_accepts',
    'fourRunners',
))
f = chr(96)*3
review = Path('research/astra-rational-margin-box-formal-review.md').read_text()
blocks = re.findall(rf'^{f}lean\n(.*?)^{f}[ \t]*$',review,re.M|re.S)
assert len(blocks) == 1
lean = blocks[0]
env = dict(os.environ)
env['PATH'] = '/home/joshua/.elan/bin:' + env.get('PATH','')
proc = subprocess.run(['lake','env','lean','--stdin'],input=lean,text=True,
    stdout=subprocess.PIPE,stderr=subprocess.STDOUT,env=env)
print(proc.stdout,end='')
assert proc.returncode == 0, proc.returncode
reports = re.findall(r"'([^']+)' depends on axioms: \[([^\]]*)\]",proc.stdout)
free = re.findall(r"'([^']+)' does not depend on any axioms",proc.stdout)
assert len(reports) == 11 and free == ['LonelyRunner.rationalMarginBoxPilot_fin_zero_accepts']
assert {name for name,_ in reports}|set(free) == set(names)
for name,axioms in reports:
    assert {a.strip() for a in axioms.split(',')} <= {'propext','Classical.choice','Quot.sound'},(name,axioms)
for path,digest in guards.items():
    assert sha256(Path(path).read_bytes()).hexdigest() == digest, path
print(json.dumps({
    'result':'PASS','source_guards':len(guards),
    'kernel_examples':len(re.findall(r'^example\b',lean,re.M)),
    'dependency_reports':len(reports),'axiom_free_reports':len(free),
    'lean_exit_code':proc.returncode,'root_and_audit_prior_bytes_preserved':True,
    'lean_stdin_sha256':sha256(lean.encode()).hexdigest(),
    'lean_stdout_sha256':sha256(proc.stdout.encode()).hexdigest(),
    'tuple_scan':False,'resource_benchmark':False,
},sort_keys=True))
```

```lean
import LonelyRunner

open LonelyRunner

-- Six exact generic theorem types, retaining raw/vacuous scope and all margins.
example : ∀ {n : ℕ} (B : NatSpeedBox n) (num den : Fin n → ℕ)
    (d : RationalMarginBandLeaf n),
    rationalMarginBandLeafOK B num den d = true →
    ∀ w : Fin n → ℕ, B.Contains w →
      rationalMarginRowOK w num den d.p d.q = true :=
  @rationalMarginBandLeafOK_row

example : ∀ {n : ℕ} (B : NatSpeedBox n) (num den : Fin n → ℕ)
    (d : RationalMarginBandLeaf n),
    rationalMarginBandLeafOK B num den d = true →
    0 < (d.p : ℝ) / (d.q : ℝ) ∧ ∀ w, B.Contains w → ∀ i,
      (num i : ℝ) / (den i : ℝ) ≤
        circleNorm (((d.p : ℝ) / (d.q : ℝ)) * (w i : ℝ)) :=
  @rationalMarginBandLeafOK_common_positive_time

example : ∀ {n : ℕ} (B : NatSpeedBox n) (i : Fin n) (cut : ℕ),
    (B.lo i ≤ cut ∧ cut < B.hi i) →
    ∀ w : Fin n → ℕ, B.Contains w →
      (B.left i cut).Contains w ∨ (B.right i cut).Contains w :=
  @rationalMarginBox_split_cover

example : ∀ {n : ℕ} (tree : RationalMarginBoxTree n)
    (B : NatSpeedBox n) (num den : Fin n → ℕ),
    rationalMarginBoxTreeOKCore B num den tree = true →
    ∀ w : Fin n → ℕ, B.Contains w →
      ∃ p q : ℕ, 0 < p ∧ rationalMarginRowOK w num den p q = true :=
  @rationalMarginBoxTreeOKCore_row

example : ∀ {n : ℕ} (B : NatSpeedBox n) (num den : Fin n → ℕ)
    (tree : RationalMarginBoxTree n),
    rationalMarginBoxTreeOK B num den tree = true →
    ∀ w : Fin n → ℕ, B.Contains w →
      ∃ p q : ℕ, 0 < p ∧ rationalMarginRowOK w num den p q = true :=
  @rationalMarginBoxTreeOK_row

example : ∀ {n : ℕ} (B : NatSpeedBox n) (num den : Fin n → ℕ)
    (tree : RationalMarginBoxTree n),
    rationalMarginBoxTreeOK B num den tree = true →
    ∀ w : Fin n → ℕ, B.Contains w →
      ∃ t : ℝ, 0 < t ∧ ∀ i, (num i : ℝ) / (den i : ℝ) ≤
        circleNorm (t * (w i : ℝ)) :=
  @rationalMarginBoxTreeOK_exists_positive_time

-- Exact pilot contracts and pre-existing canonical compatibility.
example : rationalMarginBoxTreeOK rationalMarginBoxPilotRoot
    rationalMarginBoxPilotNum rationalMarginBoxPilotDen rationalMarginBoxPilotTree = true :=
  rationalMarginBoxPilot_accepts

example : ∀ w : Fin 4 → ℕ, rationalMarginBoxPilotRoot.Contains w →
    ∃ p q : ℕ, 0 < p ∧ rationalMarginRowOK w rationalMarginBoxPilotNum
      rationalMarginBoxPilotDen p q = true :=
  rationalMarginBoxPilot_row

example : ∀ w : Fin 4 → ℕ, rationalMarginBoxPilotRoot.Contains w →
    ∃ t : ℝ, 0 < t ∧ ∀ i, (rationalMarginBoxPilotNum i : ℝ) /
      (rationalMarginBoxPilotDen i : ℝ) ≤ circleNorm (t * (w i : ℝ)) :=
  rationalMarginBoxPilot_exists_positive_time

example : rationalMarginBoxPilotLeafCount rationalMarginBoxPilotTree = 2 :=
  rationalMarginBoxPilot_two_leaves

example : ∀ speeds : Fin 4 → ℝ, Function.Injective speeds →
    ∀ runner : Fin 4, ∃ t : ℝ, LonelyAt speeds runner t :=
  fourRunners

-- The public checker includes the well-formed root, independently of its core.
example {n : ℕ} (B : NatSpeedBox n) (num den : Fin n → ℕ)
    (tree : RationalMarginBoxTree n) :
    rationalMarginBoxTreeOK B num den tree =
      (decide (∀ i, B.lo i ≤ B.hi i) && rationalMarginBoxTreeOKCore B num den tree) := rfl

-- An impossible margin may pass only on an empty raw box; its public form fails.
example : rationalMarginBandLeafOK ⟨![1], ![0]⟩ ![2] ![1] ⟨4,1,![1]⟩ = true := by
  decide

example : rationalMarginBoxTreeOK ⟨![1], ![0]⟩ ![2] ![1] (.leaf ⟨4,1,![1]⟩) = false := by
  decide

example (w : Fin 1 → ℕ) (hw : (⟨![1], ![0]⟩ : NatSpeedBox 1).Contains w) :
    rationalMarginRowOK w ![2] ![1] 4 1 = true :=
  rationalMarginBandLeafOK_row ⟨![1], ![0]⟩ ![2] ![1] ⟨4,1,![1]⟩
    (by decide) w hw

-- Closed zero-margin upper endpoint x=1 with band=0, followed through row soundness.
example : rationalMarginRowOK ![1] ![0] ![1] 1 1 = true :=
  rationalMarginBandLeafOK_row ⟨![1], ![1]⟩ ![0] ![1] ⟨1,1,![0]⟩
    (by decide) ![1] (by intro i; fin_cases i; decide)

example : ∃ t : ℝ, 0 < t ∧ ∀ i : Fin 1,
    ((![0] i : ℕ) : ℝ) / ((![1] i : ℕ) : ℝ) ≤
      circleNorm (t * ((![1] i : ℕ) : ℝ)) :=
  rationalMarginBoxTreeOK_exists_positive_time ⟨![1], ![1]⟩ ![0] ![1]
    (.leaf ⟨1,1,![0]⟩) rationalMarginBoxPilot_zero_margin_integer_upper_accepts
    ![1] (by intro i; fin_cases i; decide)

-- A Fin 0 tree still provides a positive time; all coordinates remain vacuous.
example : ∃ t : ℝ, 0 < t ∧ ∀ i : Fin 0, (1 : ℝ) ≤ circleNorm (t * 0) := by
  obtain ⟨t, ht, hgood⟩ :=
    rationalMarginBoxTreeOK_exists_positive_time
      (⟨(fun _ : Fin 0 => 0), (fun _ => 0)⟩ : NatSpeedBox 0)
      (fun _ => 0) (fun _ => 0) (.leaf ⟨1,1,fun _ => 0⟩)
      (by decide) (fun _ => 0) (by intro i; exact Fin.elim0 i)
  exact ⟨t, ht, fun i => Fin.elim0 i⟩

-- Exactly named pilot rows: both split boundaries and repeated coordinates.
example : ∃ p q : ℕ, 0 < p ∧ rationalMarginRowOK ![2,3,5,7]
    rationalMarginBoxPilotNum rationalMarginBoxPilotDen p q = true :=
  rationalMarginBoxPilot_left_boundary_row

example : ∃ p q : ℕ, 0 < p ∧ rationalMarginRowOK ![2,3,5,8]
    rationalMarginBoxPilotNum rationalMarginBoxPilotDen p q = true :=
  rationalMarginBoxPilot_right_boundary_row

example : ∃ p q : ℕ, 0 < p ∧ rationalMarginRowOK ![3,3,5,8]
    rationalMarginBoxPilotNum rationalMarginBoxPilotDen p q = true :=
  rationalMarginBoxPilot_repeated_coordinates

#print axioms LonelyRunner.rationalMarginBandLeafOK_row
#print axioms LonelyRunner.rationalMarginBandLeafOK_common_positive_time
#print axioms LonelyRunner.rationalMarginBox_split_cover
#print axioms LonelyRunner.rationalMarginBoxTreeOKCore_row
#print axioms LonelyRunner.rationalMarginBoxTreeOK_row
#print axioms LonelyRunner.rationalMarginBoxTreeOK_exists_positive_time
#print axioms LonelyRunner.rationalMarginBoxPilot_accepts
#print axioms LonelyRunner.rationalMarginBoxPilot_row
#print axioms LonelyRunner.rationalMarginBoxPilot_exists_positive_time
#print axioms LonelyRunner.rationalMarginBoxPilot_two_leaves
#print axioms LonelyRunner.rationalMarginBoxPilot_fin_zero_accepts
#print axioms LonelyRunner.fourRunners
```

## Final focused verification

Accepted at the exact guarded bytes. The first focused execution ran the sole
Python block above, extracted from this file, and its only Lean command was
`lake env lean --stdin`. Session `26589` reached terminal exit 0 (final tool
chunk `12db6d`). All 21 kernel examples passed, together with 14 source guards,
the six exact generic types, named pilot contracts and the old unconditional
canonical fourRunners type. The 12 axiom prints comprised 11 dependency reports
using only propext, Classical.choice and Quot.sound, plus the axiom-free Fin 0
acceptance theorem. The raw empty/impossible-margin case, its rejected public
form, the zero-margin integer upper endpoint and the Fin 0 positive-time
application all compiled through the intended interfaces.

The run emitted one harmless unused-variable warning at stdin line 102.
The executed Lean block is preserved exactly; no warning-only edits or repeat
probe were needed. This was the first focused Lean run for this review and
there was no failed Lean attempt.

| Frozen executable evidence | SHA-256 |
| --- | --- |
| Sole Python block | `c25a6a71f6512c0ad394bc4f4f43b846edd4a4bd2d370e575b4ffc200d95f75d` |
| Raw Python-block stdout | `c8a1453668676aecbe7f4a5a236ba6edc9a5c5a01b9a6df77caac5f3cfb3b215` |
| Lean stdin block | `02f4249db79d355bbfe2c32f140f4067c67f2194bd30fa99b38724dba743d35d` |
| Raw Lean stdout | `a15a266fef146a59b65c4f47bc965fb7098b38f575abd5bd1f6aeb165eb97bff` |

The Python stdout hash covers precisely the block's printed Lean output and
final JSON line, excluding an outer runner's hash labels. The program checks
all source guards again after Lean terminates. Final workflow validation also
passed; this checks workflow structure, not the mathematical argument.

No correction to the source or accepted contract is required. The certified
result is generic box/tree soundness and the specified two-leaf, twelve-row
pilot, with closed coordinate margins and row-dependent positive time. It
does not establish finite K5, universal five-total-runner supply or unrestricted
LRC. All reviewer processes have stopped. The shared cache remains available
for root's independent replay and disposition.
