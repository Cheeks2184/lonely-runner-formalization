# Independent source review of the canonical four-runner theorem

Assigned Astra/xhigh review by `/root/mss_published_bound_audit`, against
`0e49249d9fcbba5e4a8312d845224bc11466db76`. Only this review is owned;
the earlier canonical-plan and deletion-gcd reviews remain frozen. Project
configuration, workflow, policy and active state were read, and structural
validation passed. Requested routing is recorded without independent runtime
attestation. The unrestricted canonical LRC goal remains unresolved.

**Verdict: accepted.** The six-file patch proves the exact canonical
four-total-runner statement below, using only the allowed standard axioms.
No mathematical, theorem-contract or source correction is required.

## Exact theorem and mathematical review

The final declaration is `LonelyRunner.fourRunners`:

```lean
∀ (speeds : Fin 4 → ℝ), Function.Injective speeds →
  ∀ runner : Fin 4, ∃ t : ℝ, LonelyAt speeds runner t
```

`LonelyAt` here uses every other original label, the quotient-circle distance,
and closed threshold 1/4. Speeds are arbitrary reals, with arbitrary signs,
translation and chosen label. Only distinctness remains as an admissibility
condition. Time ranges over all reals; the existential conclusion does not
assert goodness at every time. No natural/rational/sorted/stationary or H5
premise remains in this specialization. No mixed third margin, fixed count
five, or unrestricted all-count conclusion is asserted.
The quantifier order is every chosen runner followed by an existential time;
different chosen runners may use different times.

The ordinary natural bridge correctly separates the scaled exceptional shape.
At (a,2a,3a), positivity of a gives t=(4a)^(-1)>0 and exact phases
(1/4,1/2,3/4), with circle norms (1/4,1/2,1/4). Off that shape, the accepted
mixed classification supplies one positive time and its fastest third bound
is weakened to a quarter. Sorting an injective natural triple gives an
equivalence from sorted positions to original labels; its surjectivity restores
every original index at that same time. H5 then covers exactly dimensions
d=1,2,3 at their own bounds 1/2,1/3,1/4, using the existing H4 theorem for
the first two cases. It is not a five-total-runner theorem.

The strict-transfer helper extracts the original final open-set argument.
Every integer relation vanishing on u is required to vanish on z, precisely
the direction consumed by the existing orbit-closure theorem. The target
orbit point lies in the open finite intersection of coordinate norm bands
`delta < norm(x_i)`. Its closure membership supplies an actual u-orbit point
in this same open set, at one common real time. Delta and the target time are
arbitrary reals; the helper needs no count hypothesis, rationality or positivity.
The old global rational-collision theorem retains its complete original type
and strict-margin derivation, and only its final transfer block calls this
new helper. The new bounded wrappers do not call its global conjecture premise.

In the irrational-ratio branch, distinct ratio indices imply m>=2. BHK gives
a nowhere-zero rational row with magnitude cardinality strictly below m and
the required real relation implication. Restricting H_(m+2) to H_(m+1) is
valid on its smaller cardinality range. The existing bounded rational lemma
is called at N=m+1, so its output has margin 1/m. Since m>0,
`1/(m+1)<1/m`, every coordinate of that target is strictly above the desired
threshold. The strict-transfer helper is applied before weakening to closed.
The proof does not attempt to transfer a merely closed boundary through an
open set or reverse the relation implication.

In the rational-ratio branch, the chosen rational row q_i=u_i/u_first is
nowhere zero and may repeat. The implementation only proves nonzeroness,
which is sufficient: the existing bounded lemma deduplicates absolute values
internally and clears their positive denominators. The weak image-cardinality
bound <=m is automatic. At N=m+2 this yields exactly margin 1/(m+1), with
every original occurrence restored. Division of the resulting time by the
nonzero u_first preserves each phase exactly. The m=1 boundary is included
in this branch; irrational self-ratios cannot occur.

Sign normalization uses positive abs(v_i) for every nonzero original relative
speed. Repeated magnitudes are allowed, and the exact norm identity returns
each signed phase without changing the witness time. For a family on
`Fin (m+1)`, `runner.succAbove` enumerates exactly its m other labels.
Injectivity gives nonzero differences. The stationary bound 1/(m+1) is
therefore the original total-runner denominator, and
`lonelyAt_iff_relativeLonelyAt` returns actual circular distances.
Finally m=3 and the proved H5 discharge all supply assumptions in fourRunners.

The implementation matches the accepted plan review
`d957473a23aeab123ab754dd00ce3e027e71ff795bea15cac167b1282c88b53c`,
including its generic labelled-helper refinement. Mathematical review found
no source correction. The focused executable checks below passed before
this artifact was frozen.

## Frozen sources

```text
2fb2f5c9c0742daa3278ee0ddeacd8643e1e22f8c885de95f5f38e10734b29f6  LonelyRunner/FourRunnerOrdinary.lean
e5175b1f55a2d73e850ffd3e5a5dab140b6e4d84f0cefd94ebf6d7663d3a0d6a  LonelyRunner/BHKCollisionToWitness.lean
7eae68d2c46041b39c3e18f9a1e105c75680352f8e4b4edf65e0dd2a92becb72  LonelyRunner/BoundedRealReduction.lean
353b116d04d464fb9aedb92437e7f56168992e087a862f934044bc9062761c38  LonelyRunner/FourRunnerCanonical.lean
dae4d7c57a2cd80e33b8d087c62fa0ba64fb039012112078a2e4ef7c24c93756  LonelyRunner.lean
31ca9c8be208cca88007162b5a6941d90fdf901a21f55f2176fc0d51c9e43b4a  LonelyRunner/AxiomAudit.lean
```

## Focused executable checks

Run the sole Python block below from the repository root with `python3 -B`.
It guards the frozen sources, checks old-source compatibility and imports,
then sends the second Lean block in this review to `lake env lean --stdin`.
It creates no Lean source or compiled output. Read-only Git inspection is
used solely for comparison with the assigned base.

```python
from pathlib import Path
from hashlib import sha256
import json,os,re,runpy,subprocess

BASE="0e49249d9fcbba5e4a8312d845224bc11466db76"
HERE=Path("research/astra-four-runner-canonical-formal-review.md")
doc=HERE.read_text()
digest=lambda b:sha256(b).hexdigest()
guards={p:h for h,p in re.findall(
    r"^([a-f0-9]{64})  (LonelyRunner(?:/[^ \n]+)?\.lean)$",doc,re.M)}
assert len(guards)==6
guards["research/astra-four-runner-canonical-bridge-review.md"]="d957473a23aeab123ab754dd00ce3e027e71ff795bea15cac167b1282c88b53c"
for p,h in guards.items():
    assert digest(Path(p).read_bytes())==h,p
assert Path("lean-toolchain").read_text().strip()=="leanprover/lean4:v4.32.1"
manifest=json.loads(Path("lake-manifest.json").read_text())
assert next(p["rev"] for p in manifest["packages"] if p["name"]=="mathlib")=="520045ab14e26149ee970e2e617ca04b09bde5d6"
scanner=runpy.run_path("scripts/audit_lean_trust.py")
for p in guards:
    if p.endswith(".lean"):
        assert scanner["find_forbidden_source"](Path(p).read_text()) is None,p
print("PASS: seven source guards; pinned Lean/mathlib; six source trust scans")

changed=set(subprocess.check_output(
    ["git","diff","--name-only",BASE,"--","*.lean"],text=True).splitlines())
assert changed<=set(p for p in guards if p.endswith(".lean")),changed
bhk="LonelyRunner/BHKCollisionToWitness.lean"
old=subprocess.check_output(["git","show",BASE+":"+bhk],text=True)
cur=Path(bhk).read_text()
def original_prefix(s):
    a=s.index("theorem exists_stationaryWitness_of_rational_collision")
    return s[a:s.index("  let c : ℝ",a)]
assert original_prefix(old)==original_prefix(cur)
for p in ["LonelyRunner.lean","LonelyRunner/AxiomAudit.lean"]:
    old=subprocess.check_output(["git","show",BASE+":"+p],text=True)
    cur=Path(p).read_text()
    for name in ["FourRunnerOrdinary","BoundedRealReduction","FourRunnerCanonical"]:
        line="import LonelyRunner."+name+"\n"
        assert cur.count(line)==1
        cur=cur.replace(line,"")
    assert cur==old if p=="LonelyRunner.lean" else cur.startswith(old)
print("PASS: old BHK type and strict-margin prefix preserved; imports/audit additions only")

graph={"LonelyRunner":re.findall(r"^import (LonelyRunner\.\S+)",Path("LonelyRunner.lean").read_text(),re.M)}
for p in Path("LonelyRunner").glob("*.lean"):
    graph["LonelyRunner."+p.stem]=re.findall(r"^import (LonelyRunner\.\S+)",p.read_text(),re.M)
def reach(x):
    seen=set();todo=[x]
    while todo:
        a=todo.pop()
        if a in seen:continue
        seen.add(a);todo.extend(graph.get(a,[]))
    return seen
seen=set();active=set()
def visit(x):
    if x in seen:return
    assert x not in active,x
    active.add(x)
    for y in graph.get(x,[]):visit(y)
    active.remove(x);seen.add(x)
visit("LonelyRunner")
assert all("LonelyRunner."+x in seen for x in
    ["FourRunnerOrdinary","BoundedRealReduction","FourRunnerCanonical"])
assert "LonelyRunner.FourRunnerMixed" not in reach("LonelyRunner.BoundedRealReduction")
assert "LonelyRunner.BoundedRealReduction" not in reach("LonelyRunner.LowerCountSupply")
print("PASS: root-connected import graph is acyclic; bounded supply stays count-local")

fence=chr(96)*3
blocks=re.findall(r"^"+fence+r"lean\n(.*?)^"+fence+r"[ \t]*$",doc,re.M|re.S)
assert len(blocks)==2
probe=blocks[1]
assert len(re.findall(r"^example\b",probe,re.M))==18
env=os.environ.copy()
env["PATH"]=str(Path.home()/".elan/bin")+os.pathsep+env["PATH"]
run=subprocess.run(["lake","env","lean","--stdin"],input=probe,text=True,
                   stdout=subprocess.PIPE,stderr=subprocess.STDOUT,env=env)
if run.returncode!=0:
    print(run.stdout,end="")
    raise SystemExit(run.returncode)
reports=re.findall(r"depends on axioms:\s*\[([^]]*)\]",run.stdout)
assert len(reports)==9
for report in reports:
    assert {s.strip() for s in report.split(",")}<=scanner["ALLOWED_AXIOMS"]
for p,h in guards.items():
    assert digest(Path(p).read_bytes())==h,p
print("PASS: 18 kernel examples; eight new exact types plus old compatibility; nine allowed axiom reports")
print("Lean stdin SHA256:",digest(probe.encode()))
print("Lean stdout/stderr SHA256:",digest(run.stdout.encode()))
print("Terminal status: Lean exited 0; no child process remains")
```

```lean
import LonelyRunner
open LonelyRunner
open scoped BigOperators

example : ∀ (a b H : ℕ), 0 < a → a < b → b < H →
    ∃ t : ℝ, 0 < t ∧
      (4 : ℝ)⁻¹ ≤ circleNorm (t * (a : ℝ)) ∧
      (4 : ℝ)⁻¹ ≤ circleNorm (t * (b : ℝ)) ∧
      (4 : ℝ)⁻¹ ≤ circleNorm (t * (H : ℝ)) :=
  threeMovingNaturalSpeeds

example : ∀ (speeds : Fin 3 → ℕ), Function.Injective speeds →
    (∀ i, 0 < speeds i) → ∃ t : ℝ, 0 < t ∧ ∀ i,
      (4 : ℝ)⁻¹ ≤ circleNorm (t * (speeds i : ℝ)) :=
  threeMovingNaturalRunners

example : LowerCountPositiveIntegerHypothesis 5 :=
  lowerCountPositiveIntegerHypothesis_five

example : ∀ {m : ℕ} (u z : Fin m → ℝ) (δ τ : ℝ),
    (∀ a : Fin m → ℤ, (∑ i, (a i : ℝ) * u i = 0) →
      ∑ i, (a i : ℝ) * z i = 0) →
    (∀ i, δ < circleNorm (τ * z i)) →
    ∃ t : ℝ, ∀ i, δ < circleNorm (t * u i) :=
  @exists_stationaryStrictWitness_of_relations

example : ∀ {m : ℕ}, 1 ≤ m →
    LowerCountPositiveIntegerHypothesis (m + 2) →
    ∀ u : Fin m → ℝ, (∀ i, 0 < u i) →
    ∃ t : ℝ, ∀ i, (((m + 1 : ℕ) : ℝ)⁻¹) ≤ circleNorm (t * u i) :=
  @positiveRealWitness_of_lowerCount

example : ∀ {m : ℕ}, 1 ≤ m →
    LowerCountPositiveIntegerHypothesis (m + 2) →
    ∀ v : Fin m → ℝ, (∀ i, v i ≠ 0) →
    ∃ t : ℝ, ∀ i, (((m + 1 : ℕ) : ℝ)⁻¹) ≤ circleNorm (t * v i) :=
  @stationaryWitness_of_lowerCount

example : ∀ {m : ℕ}, 1 ≤ m →
    LowerCountPositiveIntegerHypothesis (m + 2) →
    ∀ speeds : Fin (m + 1) → ℝ, Function.Injective speeds →
    ∀ runner : Fin (m + 1), ∃ t : ℝ, LonelyAt speeds runner t :=
  @lonelyAt_of_lowerCount

example : ∀ speeds : Fin 4 → ℝ, Function.Injective speeds →
    ∀ runner : Fin 4, ∃ t : ℝ, LonelyAt speeds runner t :=
  fourRunners

example : ∀ {m : ℕ}, 2 ≤ m → ∀ (u : Fin m → ℝ) (w : Fin m → ℚ),
    (∀ i, w i ≠ 0) →
    (Finset.univ.image (fun i => |w i|)).card < m →
    (∀ a : Fin m → ℤ, (∑ i, (a i : ℝ) * u i = 0) →
      ∑ i, (a i : ℝ) * (w i : ℝ) = 0) →
    PositiveRationalConjecture →
    ∃ time : ℝ, ∀ i, (((m + 1 : ℕ) : ℝ)⁻¹) ≤ circleNorm (time * u i) :=
  @exists_stationaryWitness_of_rational_collision

example (speeds : Fin 4 → ℝ) (hinj : Function.Injective speeds) (r : Fin 4) :
    ∃ t : ℝ, ∀ j : Fin 4, j ≠ r →
      (1 : ℝ) / 4 ≤ dist (position (speeds r) t) (position (speeds j) t) := by
  obtain ⟨t, ht⟩ := fourRunners speeds hinj r
  exact ⟨t, by simpa only [LonelyAt, Nat.cast_ofNat, one_div] using ht⟩

example : ∃ t : ℝ, 0 < t ∧
    (4 : ℝ)⁻¹ ≤ circleNorm (t * 17) ∧
    (4 : ℝ)⁻¹ ≤ circleNorm (t * 34) ∧
    (4 : ℝ)⁻¹ ≤ circleNorm (t * 51) := by
  simpa using threeMovingNaturalSpeeds 17 34 51 (by decide) (by decide) (by decide)

example : ∃ t : ℝ, 0 < t ∧ ∀ i : Fin 3,
    (4 : ℝ)⁻¹ ≤ circleNorm (t * ((![51,17,34] : Fin 3 → ℕ) i : ℝ)) := by
  apply threeMovingNaturalRunners
  · intro i j hij
    fin_cases i <;> fin_cases j <;> (try rfl) <;> norm_num at hij
  · intro i
    fin_cases i <;> norm_num

example : ∃ t : ℝ, ∀ i : Fin 3,
    (4 : ℝ)⁻¹ ≤ circleNorm (t * (![1,1,2] : Fin 3 → ℝ) i) := by
  apply positiveRealWitness_of_lowerCount (m := 3) (by decide)
    lowerCountPositiveIntegerHypothesis_five
  intro i
  fin_cases i <;> norm_num

example : ∃ t : ℝ, ∀ i : Fin 3,
    (4 : ℝ)⁻¹ ≤ circleNorm (t * (![-1,1,2] : Fin 3 → ℝ) i) := by
  apply stationaryWitness_of_lowerCount (m := 3) (by decide)
    lowerCountPositiveIntegerHypothesis_five
  intro i
  fin_cases i <;> norm_num

example : ∃ t : ℝ, LonelyAt (![0,1,2,3] : Fin 4 → ℝ) 1 t := by
  apply fourRunners
  intro i j hij
  fin_cases i <;> fin_cases j <;> (try rfl) <;> norm_num at hij

example : ∃ t : ℝ, LonelyAt (![-5,-4,-3,-2] : Fin 4 → ℝ) 1 t := by
  apply fourRunners
  intro i j hij
  fin_cases i <;> fin_cases j <;> (try rfl) <;> norm_num at hij

example : ∃ t : ℝ, LonelyAt (![0,1,Real.sqrt 2,3] : Fin 4 → ℝ) 2 t := by
  have hspos : 0 < Real.sqrt 2 := Real.sqrt_pos.2 (by norm_num)
  have hsq : (Real.sqrt 2)^2 = 2 := Real.sq_sqrt (by norm_num)
  have hsone : 1 < Real.sqrt 2 := by nlinarith
  have hsthree : Real.sqrt 2 < 3 := by nlinarith
  apply fourRunners
  intro i j hij
  fin_cases i <;> fin_cases j <;> (try rfl) <;> norm_num at hij <;> nlinarith

example : ∃ t : ℝ, ∀ i : Fin 1,
    (2 : ℝ)⁻¹ ≤ circleNorm (t * (![-7] : Fin 1 → ℝ) i) := by
  have h3 : LowerCountPositiveIntegerHypothesis 3 := by
    intro d hd hdmax speeds hinj hpos
    exact lowerCountPositiveIntegerHypothesis_five d hd (by omega) speeds hinj hpos
  apply stationaryWitness_of_lowerCount (m := 1) (by decide) h3
  intro i
  fin_cases i
  norm_num

#check @threeMovingNaturalSpeeds
#print axioms LonelyRunner.threeMovingNaturalSpeeds
#check @threeMovingNaturalRunners
#print axioms LonelyRunner.threeMovingNaturalRunners
#check @lowerCountPositiveIntegerHypothesis_five
#print axioms LonelyRunner.lowerCountPositiveIntegerHypothesis_five
#check @exists_stationaryStrictWitness_of_relations
#print axioms LonelyRunner.exists_stationaryStrictWitness_of_relations
#check @positiveRealWitness_of_lowerCount
#print axioms LonelyRunner.positiveRealWitness_of_lowerCount
#check @stationaryWitness_of_lowerCount
#print axioms LonelyRunner.stationaryWitness_of_lowerCount
#check @lonelyAt_of_lowerCount
#print axioms LonelyRunner.lonelyAt_of_lowerCount
#check @fourRunners
#print axioms LonelyRunner.fourRunners
#check @exists_stationaryWitness_of_rational_collision
#print axioms LonelyRunner.exists_stationaryWitness_of_rational_collision
```

## Executed outcomes and final provenance

The sole guarded Python block completed with terminal exit 0. Its 18 kernel
examples include the exact eight new public contracts, the preserved old
global rational-collision contract, and an expanded canonical check spelling
out the distance inequality and closed quarter threshold. The eight further
controls cover the scaled natural exception (17,34,51), its unsorted input
order (51,17,34), repeated positive speeds (1,1,2), signed repeated magnitudes
(-1,1,2), chosen runner 1 in (0,1,2,3), the translated negative tuple
(-5,-4,-3,-2) at runner 1, the tuple (0,1,sqrt(2),3) at runner 2, and the
generic m=1 boundary with speed -7. The sqrt(2) tuple's injectivity is proved
from its positive square and the exact inequalities 1<sqrt(2)<3. These are
kernel interface applications, not numerical searches or claims of runtime
branch coverage for the noncomputable proofs.

The eight new declarations and the old compatibility declaration were each
printed at their exact types; all nine axiom reports contain only `propext`,
`Classical.choice` and `Quot.sound`. All six frozen Lean paths passed the
source trust scanner. The old rational-collision theorem's type and its
entire prefix through the strict-margin derivation are byte-identical to
base. Only the final open-set block is replaced by the new helper call.
Other existing mathematical sources are unchanged. The root adds three
imports, and the axiom file adds the same imports and eight reports. The
actual root import graph is acyclic, reaches all three new modules, and
retains independence of bounded supply from the four-runner classification.

The first version of the fixed-tuple probe used `norm_num at hij` and the
goal in a combined invocation which sometimes continued after a contradiction
had closed the goal. It was rejected with `No goals to be solved`. The outer
output-capture wrapper initially hid that diagnostic; one replay exposed it.
Separating reflexive goals from hypothesis normalization corrected only the
probe. No Lean implementation source was changed for these checks, and the
failed attempts are not counted as passes.

One documentation-only correction was requested and completed by root: the
canonical implementation report initially named a nonexistent extra module
namespace. The actual declaration is `LonelyRunner.fourRunners`, and the
report now names it correctly. The six mathematical/integration source hashes
were unchanged. Acceptance is bound to the corrected report hash below.

Exact reproduction hashes, UTF-8 including final newlines:

```text
5a3d2526aab2deea5c0acdde5de67901bb9f6f0e0cc2ead3076826c0f32b7f89  sole Python block
06ace03ec96989b7ff0dcc0eb317f90ac048fca4c5cbc4d1fd9a39bf039b85f0  program stdout
0a6ac6cb98fbcc9af58f9d20a917820fbfba2e116785b833871168ffc33cecff  Lean stdin block
e1e21ae9cd4fa87834c6f2e25689f3ea3518367743f53ebd14181c74bed5c4a7  raw Lean stdout/stderr
```

The program stdout was:

```text
PASS: seven source guards; pinned Lean/mathlib; six source trust scans
PASS: old BHK type and strict-margin prefix preserved; imports/audit additions only
PASS: root-connected import graph is acyclic; bounded supply stays count-local
PASS: 18 kernel examples; eight new exact types plus old compatibility; nine allowed axiom reports
Lean stdin SHA256: 0a6ac6cb98fbcc9af58f9d20a917820fbfba2e116785b833871168ffc33cecff
Lean stdout/stderr SHA256: e1e21ae9cd4fa87834c6f2e25689f3ea3518367743f53ebd14181c74bed5c4a7
Terminal status: Lean exited 0; no child process remains
```

Root separately confirmed terminal exit 0 for `lake build LonelyRunner`
(3643 jobs) and the full trust audit (457 accepted reports). I read both
final logs and verified their terminal success lines and final source hashes.
Root also independently replayed this review's sole program and obtained the
same probe/output hashes and all 18 examples. The pinned toolchain is Lean
v4.32.1 with mathlib `520045ab14e26149ee970e2e617ca04b09bde5d6`.
This reviewer did not repeat the full build or global trust audit.

| Supporting artifact | SHA-256 |
| --- | --- |
| Accepted canonical bridge plan review | `d957473a23aeab123ab754dd00ce3e027e71ff795bea15cac167b1282c88b53c` |
| Ordinary implementation report | `1b05b304158ae1a1b3cec12ed16955b7ec7273cf0b4a1e59663c51369229b42c` |
| Bounded real implementation report | `f97466dd5cfc2f376cb3934a66f6c16773ee820c09696bffa2edca4b86e57d07` |
| Corrected canonical implementation report | `2714bd3c9fc2a5228c26f940f43be08417167317ee3d1cb769249a87eeba94cf` |
| `/tmp/astra-pass34-full-build.log` | `2ee002515a58c40fde734e39bd7e4b3f53afdcafcba232aeaf722281df354265` |
| `/tmp/astra-pass34-trust.log` | `7df3ad88a21f875a339110f3d5ce27baf163a66296e7fe91c7886706ac87a93e` |

Only this owned review was written. All previously frozen reviews were
preserved. No Lean source, shared state, Git data, dependencies or cache was
edited; Git was used read-only for exact base comparison. All commands and
child processes have stopped. Final guards and readback precede freezing;
the review's own raw hash is reported separately. This is an unconditional
canonical theorem at exactly four total runners. The unrestricted canonical
LRC objective remains unresolved.
