# Independent review: zero-residual mixed-height strengthening

Review scope: the six Lean files below against base
`fd99b6f550bcb931f101ef2186168f1fc09aec4d`. This reviewer did not author the
source plan or implementation. Only this review file is owned by this task.
The full Lonely Runner objective remains unresolved.

The plan is `research/astra-zero-residual-mixed-height.md`, SHA-256
`91f2bfee846f2c682976e3476e8c3e3214c163661945957bdef8bdb6cecbb8a7`.
The final implementation report is `research/astra-zero-residual-implementation.md`,
SHA-256 `3a037d5308e8def843b9b2ccca52375a92e349490f68da019ebe9b46d264f583`.
Its only change from the originally assigned report hash was correction of
Lake job-count wording; cached jobs are not claimed to have been rebuilt.

## Verdict and mathematical review

**Accepted: no semantic or interface issue found in the frozen six-file
patch.** The mathematical derivation was saved before executable probes;
the focused compatibility, boundary, source-trust, and axiom checks below
have now passed. This is acceptance of the conditional strengthening only.

1. The generic transfer chooses one integer `j = round (p*y-x)` and one
   `t = (j+x)/p`. Its error bound includes rounding ties. From
   `y > 1/(2*p)` and `p > 0`, this same `t` is strictly positive. Removing
   the integer phase `U i*j` gives the shared identity
   `norm ((p*U i+V i)*t) = norm (U i*x+V i*y+V i*(t-y))`.
   The ordinary branch loses at most `epsilon`. If `V i = 0`, the
   perturbation vanishes exactly, so the full `delta + epsilon` survives.
   Both coordinatewise conclusions belong to the same existential time;
   the stronger branch makes no extra sign assumption on the margins.
2. The positive wrapper retains the existing BHK collision construction,
   actual magnitude deduplication, and lower-count supply. That supply is
   exactly `LowerCountPositiveIntegerHypothesis N`: injective positive
   integer tuples of every size `1 <= d <= N-2`, with margin `1/(d+1)`.
   The signed collision has all coordinates nonzero and two opposite
   coordinates, so its distinct magnitudes have cardinality at most `N-2`.
   Every original coordinate receives margin `1/(N-1)` after lifting the
   smaller witness; the new conclusion does not discard collision labels.
3. The common-period step changes only the second phase by a multiple of
   `q`; integrality of every `q*V i` preserves all original norms. Its
   normalized phase is at least `q >= 1`, sufficient for strict positivity
   in the transfer since `p > 1`. With `N >= 3`, the exact identity
   `1/N + 1/(N*(N-1)) = 1/(N-1)` gives the claimed zero-residual margin.
4. The signed wrapper changes `U i` and `V i` by the same sign. It preserves
   the phase norm, quotient used for nonconstancy, absolute residual error,
   and integral period premise. Original zero residual implies normalized
   zero residual. The shared sign-normalized norm identity is used for both
   output branches, with no second time selection.
5. The relative wrapper enumerates precisely the other labels by
   `r.succAbove`, with residual `v other-v r`. Injectivity excludes zero
   actual relative speeds. Equal original residuals imply zero relative
   residual, yielding margin `1/(m+1)` at the same ordinary loneliness time.
   Its stronger conclusion explicitly requires `other != r`; omitting this
   condition would incorrectly demand a positive margin at phase zero.
   Here `N=m+2` and `m>=1` ensure `N>=3` throughout the lower-count chain.
6. For the sharper stationary height theorem, write `H=s(last)` and
   `Q=choose(m+2,2)`. Endpoint approximation gives `1<=q<=Q^m<H` and
   `p=H/q>1`, with `u 0=0`, `u last=q`, and residuals `v 0=v last=0`.
   Primitivity and `q<H` supply rank two exactly as in the previous proof.
   The bound `|v i|<=p/Q=2*p/((m+2)*(m+1))` applies relative to stationary
   label zero without doubling, since `v 0=0`. The stronger relative
   wrapper therefore yields one positive time with ordinary stationary
   margin `1/(m+2)` and fastest margin `1/(m+1)`. The last label differs
   from zero, and `s 0=0` removes the relative subtraction.
7. The new contrapositive keeps every sorted, primitive, stationary, and
   lower-count hypothesis. Failure of any common positive mixed witness
   implies the inclusive bound `H<=Q^m`: otherwise the strict large-height
   theorem supplies exactly the forbidden witness. There is no premise
   asserting an ordinary witness. Equality `H=Q^m` is not excluded. No
   stronger arbitrary-runner height bound or unconditional supply follows.

No mathematical defect was found in these steps. No pending four-runner
classification, modular-units result, strict-to-mixed conjecture, or other
unreviewed manuscript is used.

## Frozen source provenance

All hashes were independently checked after the implementation-report wording
correction. SHA-256 values:

```text
62291689ea8fb589ae96f50e159363277713ee67ad6bc172f8f2804cbd69ba05  LonelyRunner/AffinePhaseTransfer.lean
94532f1686bc612e9f0e852f541ed06a0e20362878c2be1ecaff645df69f261f  LonelyRunner/PositiveAffineWitness.lean
a1652cdad78c03da52c39d869b0e37d5c97d3aafb14359674492f8d4e17c3c6e  LonelyRunner/SignedAffineWitness.lean
6866bbb379b7b8fcd62f686818d5929e2ba8b2def5b06f2bf5def2b587a68459  LonelyRunner/AffineLonelyAt.lean
cb41059260b943411e2ab5360b84b59cd13f2ddf352c3c50a0b3715b9b9987d6  LonelyRunner/FiniteHeightReduction.lean
834a94f4a431c4728e5ebf22e722ee518c4c7060133fae665ee9ecfb74d54aa6  LonelyRunner/AxiomAudit.lean
```

The author reports a successful full build (3,638 jobs) and trust audit
(438 theorem reports). Those are implementation evidence, distinct from
this reviewer's focused probes below. Project workflow/config/policy/
state and the validator were read; `python3 -B scripts/validate_workflow.py`
passed. The pinned toolchain is `leanprover/lean4:v4.32.1`.

## Reproducer for the focused independent checks

Run the sole Python block below from the repository root with `python3 -B`.
It reads the frozen sources/base and sends generated examples directly to
Lean stdin, creating no source, compiled output, Git, workflow, or cache file.
The six compatibility examples use the base declaration types, not the new
wrappers' types. Boundary examples specialize the conditional theorem only;
they assert no unconditional three- or four-runner classification.

```python
from pathlib import Path
from hashlib import sha256
import re, runpy, subprocess

BASE = "fd99b6f550bcb931f101ef2186168f1fc09aec4d"
HERE = Path("research/astra-zero-residual-review.md")
doc = HERE.read_text()
digest = lambda b: sha256(b).hexdigest()
guards = {p: h for h, p in re.findall(
    r"^([a-f0-9]{64})  (LonelyRunner/[^\n]+\.lean)$", doc, re.M)}
assert len(guards) == 6
guards.update({
    "research/astra-zero-residual-mixed-height.md":
    "91f2bfee846f2c682976e3476e8c3e3214c163661945957bdef8bdb6cecbb8a7",
    "research/astra-zero-residual-implementation.md":
    "3a037d5308e8def843b9b2ccca52375a92e349490f68da019ebe9b46d264f583"})
for path, wanted in guards.items():
    assert digest(Path(path).read_bytes()) == wanted, path
assert Path("lean-toolchain").read_text().strip() == "leanprover/lean4:v4.32.1"
scanner = runpy.run_path("scripts/audit_lean_trust.py")
for path in guards:
    if path.endswith(".lean"):
        assert scanner["find_forbidden_source"](Path(path).read_text()) is None
print("PASS: eight source guards; six source trust scans; pinned toolchain")

old_apis = {
    "AffinePhaseTransfer": ["exists_affinePhaseTransfer"],
    "PositiveAffineWitness": ["exists_positiveAffine_witness"],
    "SignedAffineWitness": ["exists_signedAffine_witness"],
    "AffineLonelyAt": ["rational_affine_lonelyAt"],
    "FiniteHeightReduction": ["primitive_sorted_largeHeight_stationary_lonelyAt",
                              "primitive_sorted_largeHeight_lonelyAt"]}
probe = ("import LonelyRunner.FiniteHeightReduction\n"
         "import LonelyRunner.FiniteFamilyEquivalence\nopen LonelyRunner\n")
legacy = []
for module, names in old_apis.items():
    path = "LonelyRunner/" + module + ".lean"
    old = subprocess.check_output(["git", "show", BASE + ":" + path], text=True)
    current = Path(path).read_text()
    for name in names:
        def start(s):
            return re.search(r"^theorem " + name + r"\b", s, re.M).start()
        def header(s):
            return s[start(s):s.index(":= by", start(s))]
        assert header(old).split() == header(current).split(), name
        if name == "primitive_sorted_largeHeight_lonelyAt":
            def declaration(s):
                tail = s[start(s):]
                return tail[:tail.index("\n/--")]
            assert declaration(old) == declaration(current)
        h = header(old).removeprefix("theorem " + name).strip()
        depth = 0
        for k, char in enumerate(h):
            if char in "({[": depth += 1
            elif char in ")}]": depth -= 1
            elif char == ":" and depth == 0:
                probe += "example : ∀ " + h[:k] + "," + h[k+1:]
                probe += " := @" + name + "\n"
                break
        else:
            raise AssertionError(name)
        legacy.append(name)
for module in ["FinitePrimitiveFamilies", "FiniteFamilyEquivalence",
               "BHKTwoPhaseSupply", "AffinePhasePeriod", "LowerCountSupply"]:
    path = "LonelyRunner/" + module + ".lean"
    assert Path(path).read_bytes() == subprocess.check_output(
        ["git", "show", BASE + ":" + path]), path
print("PASS: six legacy headers; arbitrary-runner body; five unchanged files")

for m, bound in [(1, 3), (2, 36)]:
    N, last = m + 2, m + 1
    common = f"""(hLower : LowerCountPositiveIntegerHypothesis {N})
    (s : Fin {N} → ℕ) (hs : StrictMono s) (hz : s 0 = 0)
    (hg : Finset.univ.gcd s = 1)"""
    mixed = f"""0 < t ∧ LonelyAt (fun i => (s i : ℝ)) 0 t ∧
      (1 / {last} : ℝ) ≤ circleNorm (t * (s (Fin.last {last}) : ℝ))"""
    probe += f"""
example {common} (hh : {bound} < s (Fin.last {last})) :
    ∃ t : ℝ, {mixed} := by
  have h := primitive_sorted_largeHeight_stationary_mixed
    (m := {m}) (by decide) hLower s hs hz hg
    (by norm_num [Nat.choose]; exact hh)
  norm_num at h ⊢
  exact h
example {common} (hn : ∀ t : ℝ, ¬ ({mixed})) :
    s (Fin.last {last}) ≤ {bound} := by
  have h := primitive_sorted_noMixed_height_le (m := {m}) (by decide)
    hLower s hs hz hg (by convert hn using 1; norm_num)
  norm_num [Nat.choose] at h
  exact h
"""
new = ["exists_affinePhaseTransfer_with_zeroResidual",
       "exists_positiveAffine_witness_with_zeroResidual",
       "exists_signedAffine_witness_with_zeroResidual",
       "rational_affine_lonelyAt_with_equalResidual",
       "primitive_sorted_largeHeight_stationary_mixed",
       "primitive_sorted_noMixed_height_le"]
equivalences = ["conjecture_iff_allInclusivePrimitiveFiniteFamilies",
                "conjecture_iff_allSharperInclusivePrimitiveFiniteFamilies"]
for name in new:
    probe += "#check @" + name + "\n"
for name in new + legacy + equivalences:
    probe += "#print axioms LonelyRunner." + name + "\n"
run = subprocess.run(["lake", "env", "lean", "--stdin"], input=probe,
                     text=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
assert run.returncode == 0, run.stdout
reports = re.findall(r"depends on axioms:\s*\[([^]]*)\]", run.stdout)
assert len(reports) == 14
for report in reports:
    assert {s.strip() for s in report.split(",")} <= scanner["ALLOWED_AXIOMS"]
print("PASS: six kernel compatibility examples; four boundary examples; 14 axiom reports")
print("Lean stdin SHA256:", digest(probe.encode()))
print("Lean output SHA256:", digest(run.stdout.encode()))
print("Process status: Lean exited 0; no child process remains")
```

## Executed outcomes and freeze

The guarded program above completed under Python `-B`; its Lean stdin command
was `lake env lean --stdin`. All six new APIs were printed and all six old
APIs were checked against their base types by the kernel. Only the stationary
projection's header changed whitespace; the other five old headers were
byte-identical. The arbitrary-runner declaration, both finite-family files,
and BHK, period, and lower-count dependency files were byte-identical to base.
All fourteen axiom reports stayed within `propext`, `Classical.choice`, and
`Quot.sound`. The four boundary examples check both strict large-height and
inclusive no-mixed conclusions at `m=1` and `m=2`, retaining `hLower` explicitly.

The first exploratory header extractor assumed a newline after theorem names;
the next assumed identical whitespace. Both assumptions were corrected before
the guarded replay. Initial boundary probe tactics also needed explicit
`Nat.choose` normalization and proposition conversion. These were probe-harness
failures; they required no implementation changes. Lean's unused-binder warnings
in the base-type examples are benign and included in the raw output hash.

Exact final reproduction hashes (UTF-8, including trailing newlines):

```text
75f60fd0a4a20f7c46bc4684e34d2e3cb590ac636429590250caf4697d0a5169  sole Python block
9477bfd14c4052d96f142b44c525ffcd277e18e4891713df78f922553f4469fa  program stdout
105d76fe86b7168055d1e46f131a15bc1c3b9c7314550d3b7f27dd948cc5c4cf  generated Lean stdin
a6a90c0f9f02350f37bf86ade7070e544f94ab3039eb82a05d78e315a3fc6fc4  raw Lean stdout/stderr
```

The program stdout was:

```text
PASS: eight source guards; six source trust scans; pinned toolchain
PASS: six legacy headers; arbitrary-runner body; five unchanged files
PASS: six kernel compatibility examples; four boundary examples; 14 axiom reports
Lean stdin SHA256: 105d76fe86b7168055d1e46f131a15bc1c3b9c7314550d3b7f27dd948cc5c4cf
Lean output SHA256: a6a90c0f9f02350f37bf86ade7070e544f94ab3039eb82a05d78e315a3fc6fc4
Process status: Lean exited 0; no child process remains
```

All review commands have stopped. No full build, numerical search, new Lean
source, or cache cleanup was run by this reviewer. Existing pinned build
artifacts were used for the focused imports; the author's full-source build
is reported separately above. Only this review artifact was written. The
raw review-file hash is supplied at handoff, outside the file to avoid a
self-referential hash. The next step is root acceptance/publication of this
conditional patch; unrestricted mixed supply and the full LRC remain open.
