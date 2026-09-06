# Independent review of the fixed Renault 5.1 certificate

2026-09-06. Requested Astra/xhigh independent review, task
`/root/renault_phase_fixed_certificate_review`, executed by reused agent
`/root/seven_adic_expanded_falsifier`. Runtime model/effort are not independently
attested. Root owns workflow state; only this report is edited. Configuration,
workflow, policy and focused state were read, and the workflow validator
passed. Unrestricted LRC research is authorized and remains unresolved.

**Semantic verdict: accept the fixed certificate format and continuum
implication, and accept the exact generic Lean source contract/proof.**
The execution section below records whether the separately replayed finite
data and direct-import kernel probes actually pass. This verdict does not
promote the concrete Renault phase theorem to a checked declaration.

## Exact source scope and independent derivation

The reviewed primary source is Jérôme Renault, *View-obstruction: a shorter
proof for 6 lonely runners*, Discrete Mathematics 287 (2004), 93–101,
DOI `10.1016/j.disc.2004.06.008`. I retrieved and read Lemma 5.1 on printed
page 97 in the [hosted primary-paper copy](https://compmath.wordpress.com/wp-content/uploads/2008/08/view-obstruction_a_shorter_proof_for_6_lonely-runners.pdf#page=5).
It concerns three arbitrary phases in [0,1). Its alternatives are a common
dilation a in {2,3,4,5} and common shift b/6 with b in {1,2,3,4,5}, giving
closed safety, or one common shift with b in {1,2,4}, giving strict safety.
Thus the specified twenty closed bits and three strict bits have exactly
the source scope. There is no speed, rationality, distinctness or sign
hypothesis on these normalized phases. The hosted PDF identifies the DOI;
no byte identity with a publisher-hosted file is asserted. Lemmas 6.1/6.4
and the six-total assembly are not validated by this certificate.

For z in [0,1], the project's `circleNorm z` equals min(z,1-z): use the
half-unit identity for z<=1/2, and otherwise shift by integer -1 and use
the same identity. Integer periodicity gives this formula for the fractional
part of any real argument. It follows that a fractional part in [1/6,5/6]
is exactly closed norm safety, and one in (1/6,5/6) is exactly strict safety.
Both directions retain equality; a limit or continuity argument cannot
replace the strict singleton comparisons. The relevant project identities
were read in `FastRunnerInsertion.lean`, with the existing band helpers
in `StructuredClasses.lean` and `PairSumCompleteness.lean`.

The union of the three cut grids U18, U24 and U30 has 60 points:
each pairwise and the triple intersection is U6, hence
18+24+30-6-6-6+6=60. The cut list, starting at zero and with final sentinel
360, partitions [0,1) into 60 singletons and 60 intervening open intervals.
A last interval ending at 1 covers phases just below 1; phase 1 itself is
not required in this partition. Repeated phase values are admitted.

For a singleton at c/360, the program's numerator r=2c gives the exact
affine phase (a*r+120*b)/720. Euclidean quotient and remainder therefore
make the /720 mask comparison exactly the requested norm predicate.
For an open interval (c/360,d/360), r=c+d gives its midpoint. Every safety
boundary is of the form (6q+t-b)/(6a), t=1 or 5. Those boundaries lying
in [0,1) belong to the cut list: their /360 numerators are multiples of
60/a, and the grids for a=1,2 are already contained in U24. No boundary
can lie in the interior of a consecutive-cut interval.

More directly, for every good open-atom bit the fixed verifier checks

    360*q+60 <= a*c+60*b,
    a*d+60*b <= 360*q+300.

These inequalities alone are sufficient. Since a>0, every interior x
then satisfies q+1/6 < a*x+b/6 < q+5/6, so it is strictly safe. This proves
the implication for either candidate type even when an endpoint is exactly
a safety boundary. It does not require a claim about every false bit.
The cut argument proves why good midpoints imply these inequalities;
the verifier also checks the inequalities explicitly. Singletons remain
separate, so no endpoint is removed. For example at phase zero, the
strict b=1 bit must be false at equality 1/6, whereas the strict b=2 and
b=4 bits are true. At phase 1/2, strict b=2 and b=4 are false at distance
1/6. These controls are already among the fixed 2,760 predicates.

For any real phase x, write x=n+u, n=floor(x) an integer and u in [0,1).
Each allowed dilation a is an integer, so a*x+b/6 and a*u+b/6 differ by
the integer a*n. This preserves both strict and closed norm inequalities
and proves the manuscript's arbitrary-real normalization, including negative
or integral x. This normalization and the concrete partition/band proofs
are not yet implemented by the generic source reviewed here.

## Class, domination and supplied-witness audit

The verifier recomputes exactly 120 times 23 predicates and checks the
certificate's 120 masks. It validates all 61 cut entries, the increasing
class representatives, distinct representative masks, every atom's class
membership, and representative<=atom. Together with distinct class masks,
the last condition proves the representative is the least atom of its
class. Thus the claimed 98 classes are determined by the fixed data, not
trusted from the discovery counters.

The retained class masks are pairwise incomparable under inclusion. Every
atom is assigned a supplied retained mask contained in its good mask, and
each earlier retained index is checked not to be contained. This validates
the specified least-dominator convention. Smaller good masks are harder;
the inclusion direction in the data, verifier and Lean theorem agrees.

Antichain plus domination proves that the retained classes are precisely
all minimal classes without repeating discovery's class-minimalization:
if some class were properly below a retained one, its retained dominator
would be below that retained mask, contradicting incomparability. Conversely
a minimal class must equal its dominator. Minimality, unique classes and
tie conventions are useful certificate metadata; actual soundness only
needs containment and a common candidate for every retained triple.

With 41 retained masks, the exact count of sorted triples with repetitions
is 41*42*43/6=12,341. Canonical base64 decoding must supply exactly this many
bytes. In increasing lexicographic i<=j<=k order the fixed verifier checks
the supplied byte is below 23 and is a member of all three retained masks.
It additionally verifies that no smaller bit lies in the intersection.
It never chooses a replacement bit. Sorting any three atom dominators
preserves their common-candidate relation, and repeated indices are covered.
This proves coverage for arbitrary triples of atoms once mask soundness is
established. No speed or candidate-family search is involved in this replay.

I read the entire frozen 37,762-byte plan, including all three programs and
the resource driver. Its original UNEXECUTED labels correctly describe the
earlier predeclaration. The subsequent root result and execution JSON record
actual discovery/fixed-verifier exit 0, empty stderr and complete capture.
Those are root's earlier receipts, not measurements by this reviewer.
Discovery counters are observational metadata; the new fixed replay below
does not trust them or rerun discovery. The certificate's immutable binding is
19,034 bytes, SHA-256
`c1374409d4f6804487179fe9765695a2f0d756ccd2a79b5ee8616e919acbb7b1`.

## Generic Lean source review

The entire frozen `LonelyRunner/RenaultPhaseCertificates.lean` was read.
Its single definition `PhaseGood` is literally the proposed bit decoding.
For k<20 the natural quotient/remainder gives exactly a=2..5 and b=1..5.
For k>=20, the Fin 23 bound leaves precisely 20,21,22, decoded as strict
shifts 1,2,4. No strict comparison is changed to a closed one.

The single theorem `phase_certificate_sound` retains the exact accepted
type shown in the probe below. It assumes coverage of normalized phases,
soundness for each true mask bit, mask domination in the correct direction,
and common candidates for all sorted core triples. It chooses one atom for
each of the three phases. Six non-strict ordering branches permute the
three dominators, call the supplied sorted-triple hypothesis, and reorder
the conjunctions back to their original labels. Ties satisfy these branches
and require no distinctness premise. Applying domination and then soundness
proves the common phase candidate for all three labels.

Partition uniqueness, minimality and disjoint atoms are unnecessary for this
generic implication; their omission is sound. No m>0 premise is missing:
a total dom : Fin 120 -> Fin m already excludes m=0. The theorem does not
assert or load the concrete masks, 41 core indices, 12,341 witnesses, real
partition or endpoint inequalities. It is a checked conditional transfer
theorem, not an unconditional finite-coverage or arbitrary-real phase result.

## Predeclared fixed replay

One fixed verifier run is authorized here, with exactly the frozen 120x23
predicate domain and 12,341 supplied witnesses. The program below is the
reviewed fixed verifier copied verbatim from the frozen plan, not a new
discovery program. Its source hash is
`7f8be20e9ce9cbf6e257ab0e6042e207ed587873aa854acf4584fcd1fb4c39de`
(6,040 bytes). The replay's fixed input is the guarded certificate. No
obstruction mode, widened data, replacement witness or discovery is selected.

The fixed Python child has CPU soft/hard limits 59/60 seconds, alarm 60,
and address space 224 MiB; the driver has a 32 MiB soft address limit and
an independent 60-second child timeout. These address limits sum to 256 MiB.
The frozen verifier emits only its compact result or error, and the runner
requires combined output at most 65,536 bytes. All retained source, input
and receipts remain below 1 MiB. A timeout/error is a failed verification.

A separate direct-import Lean probe checks the literal definition, five
candidate-boundary decodings and universal theorem type, then prints axioms.
It has a 120-second parent timeout and uses the existing shared Lean cache,
with no 256 MiB cap on the imported Lean environment. At most one additional
Lean attempt is allowed for probe elaboration only; no theorem/source edits.
No root import guard is used because root integration is concurrent.
No dependency restoration, builds, cache cleanup, state or Git work occurs.

Complete fixed verifier:

```python
import base64
import itertools
import json
import sys

LIMIT = 425984
SCHEMA = "renault-5.1-phase-v1"
CANDIDATES = [(2 + k // 5, 1 + k % 5, False) for k in range(20)]
CANDIDATES += [(1, b, True) for b in (1, 2, 4)]


def require(condition, message):
    if not condition:
        raise ValueError(message)


def integer(x, lo, hi):
    require(type(x) is int and lo <= x <= hi, "integer field")


def vector(x, size, lo, hi):
    require(type(x) is list and len(x) == size, "vector length")
    for item in x:
        integer(item, lo, hi)


def unique_object(pairs):
    result = {}
    for key, value in pairs:
        require(key not in result, "duplicate JSON key")
        result[key] = value
    return result


def geometry():
    cuts = sorted(set(range(0, 360, 20)) | set(range(0, 360, 15)) |
                  set(range(0, 360, 12))) + [360]
    require(len(cuts) == 61 and cuts[0] == 0 and cuts[-1] == 360, "cuts")
    require(all(cuts[i] < cuts[i + 1] for i in range(60)), "cut order")
    return cuts


def arithmetic(cuts, atom, check_intervals):
    c, d = cuts[atom // 2], cuts[atom // 2 + 1]
    r = c + d if atom % 2 else 2 * c
    mask = 0
    for bit, (a, b, strict) in enumerate(CANDIDATES):
        n = a * r + 120 * b
        q = n // 720
        residue = n - 720 * q
        require(0 <= residue < 720, "Euclidean remainder")
        good = (residue > 120 and residue < 600) if strict else (
            residue >= 120 and residue <= 600)
        if good:
            mask += 2 ** bit
            if check_intervals and atom % 2:
                require(a * c + 60 * b >= 360 * q + 60, "open lower")
                require(a * d + 60 * b <= 360 * q + 300, "open upper")
    return r, mask


def main():
    raw = sys.stdin.buffer.read(LIMIT + 1)
    require(len(raw) <= LIMIT, "input cap")
    cert = json.loads(raw, object_pairs_hook=unique_object)
    require(type(cert) is dict and cert.get("schema") == SCHEMA, "schema")
    cuts = geometry()
    if cert.get("kind") == "obstruction":
        atoms = cert.get("atoms")
        nums = cert.get("numerators")
        masks = cert.get("masks")
        vector(atoms, 3, 0, 119)
        vector(nums, 3, 0, 719)
        vector(masks, 3, 0, 2 ** 23 - 1)
        for i in range(3):
            require(arithmetic(cuts, atoms[i], False) == (nums[i], masks[i]),
                    "fixed representative mismatch")
        require(masks[0] & masks[1] & masks[2] == 0, "not an obstruction")
        print(json.dumps({"verified": "fixed-obstruction", "atoms": atoms,
                          "numerators": nums, "denominator": 720,
                          "candidate_predicates": 69}, sort_keys=True))
        return 0

    require(cert.get("kind") == "coverage", "kind")
    supplied_cuts = cert.get("cuts")
    vector(supplied_cuts, 61, 0, 360)
    require(supplied_cuts == cuts, "cut values")
    masks = cert.get("masks")
    vector(masks, 120, 0, 2 ** 23 - 1)
    for atom in range(120):
        require(arithmetic(cuts, atom, True)[1] == masks[atom], "mask mismatch")
    class_reps = cert.get("class_reps")
    require(type(class_reps) is list and 1 <= len(class_reps) <= 120, "classes")
    u = len(class_reps)
    vector(class_reps, u, 0, 119)
    require(class_reps == sorted(set(class_reps)), "class order")
    class_of = cert.get("class_of")
    vector(class_of, 120, 0, u - 1)
    require(len({masks[a] for a in class_reps}) == u, "duplicate classes")
    for atom in range(120):
        representative = class_reps[class_of[atom]]
        require(representative <= atom, "least representative")
        require(masks[representative] == masks[atom], "quotient mismatch")
    for i, atom in enumerate(class_reps):
        require(class_of[atom] == i, "class representative map")

    minimal_classes = cert.get("minimal_classes")
    require(type(minimal_classes) is list and 1 <= len(minimal_classes) <= u,
            "retained classes")
    m = len(minimal_classes)
    vector(minimal_classes, m, 0, u - 1)
    require(minimal_classes == sorted(set(minimal_classes)), "retained order")
    core = [masks[class_reps[i]] for i in minimal_classes]
    for i, j in itertools.combinations(range(m), 2):
        require(core[i] & core[j] != core[i] and core[i] & core[j] != core[j],
                "retained antichain")
    dom = cert.get("dom")
    vector(dom, 120, 0, m - 1)
    for atom in range(120):
        chosen = dom[atom]
        require(core[chosen] & masks[atom] == core[chosen], "domination")
        for i in range(chosen):
            require(core[i] & masks[atom] != core[i], "dominator tie")

    expected = m * (m + 1) * (m + 2) // 6
    integer(cert.get("visited"), 1, 295240)
    require(cert["visited"] == expected, "triple count")
    encoded = cert.get("witnesses_b64")
    require(type(encoded) is str and len(encoded) <= 393656, "witness size")
    witness = base64.b64decode(encoded, validate=True)
    require(base64.b64encode(witness).decode("ascii") == encoded, "base64 canonical")
    require(len(witness) == expected, "witness length")
    checked = 0
    for i, j, k in itertools.combinations_with_replacement(range(m), 3):
        bit = witness[checked]
        require(bit < 23, "candidate index")
        flag = 1 << bit
        require(core[i] & flag and core[j] & flag and core[k] & flag,
                "supplied witness not common")
        common = core[i] & core[j] & core[k]
        require(common & (flag - 1) == 0, "least witness tie")
        checked += 1
    require(checked == expected, "incomplete verification")
    print(json.dumps({"verified": "fixed-coverage-certificate", "atoms": 120,
                      "classes": u, "retained": m, "triple_witnesses": checked,
                      "candidate_predicates": 2760,
                      "kernel_theorem": False}, sort_keys=True))
    return 0


if __name__ == "__main__":
    try:
        code = main()
    except Exception as exc:
        print("verification-error:" + type(exc).__name__, file=sys.stderr)
        code = 2
    raise SystemExit(code)
```

Complete direct-import probe:

```lean
import LonelyRunner.RenaultPhaseCertificates

open LonelyRunner

example (k : Fin 23) (x : ℝ) : PhaseGood k x ↔
    if k.val < 20 then
      (1 : ℝ) / 6 ≤ circleNorm
        (((2 + k.val / 5 : ℕ) : ℝ) * x + ((1 + k.val % 5 : ℕ) : ℝ) / 6)
    else
      (1 : ℝ) / 6 < circleNorm
        (x + ((if k.val = 20 then 1 else if k.val = 21 then 2 else 4 : ℕ) : ℝ) / 6) :=
  Iff.rfl

example (x : ℝ) : PhaseGood (0 : Fin 23) x ↔
    (1 : ℝ)/6 ≤ circleNorm (2*x+1/6) := by norm_num [PhaseGood]
example (x : ℝ) : PhaseGood (19 : Fin 23) x ↔
    (1 : ℝ)/6 ≤ circleNorm (5*x+5/6) := by norm_num [PhaseGood]
example (x : ℝ) : PhaseGood (20 : Fin 23) x ↔
    (1 : ℝ)/6 < circleNorm (x+1/6) := by norm_num [PhaseGood]
example (x : ℝ) : PhaseGood (21 : Fin 23) x ↔
    (1 : ℝ)/6 < circleNorm (x+2/6) := by norm_num [PhaseGood]
example (x : ℝ) : PhaseGood (22 : Fin 23) x ↔
    (1 : ℝ)/6 < circleNorm (x+4/6) := by norm_num [PhaseGood]

example
    (AtomMem : Fin 120 → ℝ → Prop)
    (mask : Fin 120 → Finset (Fin 23))
    (m : ℕ) (core : Fin m → Fin 120) (dom : Fin 120 → Fin m)
    (hpartition : ∀ x : ℝ, 0 ≤ x → x < 1 → ∃ a, AtomMem a x)
    (hsound : ∀ a k, k ∈ mask a → ∀ x, AtomMem a x → PhaseGood k x)
    (hdom : ∀ a, mask (core (dom a)) ⊆ mask a)
    (htriples : ∀ i j k : Fin m, i ≤ j → j ≤ k →
      ∃ c : Fin 23, c ∈ mask (core i) ∧ c ∈ mask (core j) ∧ c ∈ mask (core k)) :
    ∀ x : Fin 3 → ℝ, (∀ j, 0 ≤ x j ∧ x j < 1) →
      ∃ c : Fin 23, ∀ j, PhaseGood c (x j) :=
  phase_certificate_sound AtomMem mask m core dom hpartition hsound hdom htriples

#print axioms LonelyRunner.PhaseGood
#print axioms LonelyRunner.phase_certificate_sound
```

Exact replay from the repository root. The default argument `fixed` runs
only the fixed verifier; replacing it with `lean` runs only the displayed
Lean probe. Thus neither invocation launches discovery. All guards run before
and after the child. Programs use UTF-8 fence bytes including their final
newline. The runner creates no source or evidence file.

```bash
python3 - fixed <<'PY'
from pathlib import Path
from hashlib import sha256
import json, os, resource, signal, subprocess, sys, time

mode = sys.argv[1]
assert mode in ('fixed', 'lean')
if mode == 'fixed':
    resource.setrlimit(resource.RLIMIT_AS, (32*1024**2, 256*1024**2))
report = Path('research/astra-renault-phase-fixed-certificate-review.md').read_text()
def block(kind):
    return (report.split('```'+kind+'\n', 1)[1].split('\n```', 1)[0]+'\n').encode()
guards = {
 'research/astra-renault-phase-certificate-plan.md': '7f9d296d61db16467e7b7bf34e5070b7497f3b6a0be939e2e8fa273887ecf4af',
 'research/astra-renault-phase-certificate-result.md': '3df3af5721cc79d123eea92161fec91e723b8cd1d0e4154395ead7ce2bea9edb',
 'research/astra-renault-phase-five-one-certificate.json': 'c1374409d4f6804487179fe9765695a2f0d756ccd2a79b5ee8616e919acbb7b1',
 'research/astra-renault-phase-five-one-execution.json': '3c426aa110ef307a909f5f127f617a20fd738f394f2fa1a7ff97532a0fc0a694',
 'LonelyRunner/RenaultPhaseCertificates.lean': '36b58c04e0c755d462f32bae3388c30d744d97ccb20a3bc27aa0daa99b7e49f0',
 'LonelyRunner/FastRunnerInsertion.lean': 'dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5',
 'lean-toolchain': '8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af',
 'lake-manifest.json': '887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218',
}
def guard():
    for path, expected in guards.items():
        assert sha256(Path(path).read_bytes()).hexdigest() == expected, path
def limits():
    resource.setrlimit(resource.RLIMIT_AS, (224*1024**2, 224*1024**2))
    resource.setrlimit(resource.RLIMIT_CPU, (59, 60))
    resource.setrlimit(resource.RLIMIT_CORE, (0, 0))
    signal.alarm(60)
guard()
env = dict(os.environ)
env['PATH'] = str(Path.home()/'.elan/bin')+os.pathsep+env['PATH']
if mode == 'fixed':
    source = block('python')
    assert sha256(source).hexdigest() == '7f8be20e9ce9cbf6e257ab0e6042e207ed587873aa854acf4584fcd1fb4c39de'
    data = Path('research/astra-renault-phase-five-one-certificate.json').read_bytes()
    assert len(data) == 19034
    cmd = [sys.executable, '-I', '-c', source.decode()]
    deadline, preexec = 60, limits
else:
    source = block('lean')
    data = source
    cmd = ['lake', 'env', 'lean', '--stdin']
    deadline, preexec = 120, None
start = time.monotonic()
r = subprocess.run(cmd, input=data, capture_output=True, env=env,
                   timeout=deadline, preexec_fn=preexec)
elapsed = time.monotonic()-start
guard()
assert len(r.stdout)+len(r.stderr) <= 65536
u = resource.getrusage(resource.RUSAGE_CHILDREN)
print(json.dumps({'mode': mode, 'exit': r.returncode, 'guard_count': len(guards),
 'guards': 'PASS', 'wall_limit_seconds': deadline, 'wall_seconds': round(elapsed, 6),
 'child_user_seconds': u.ru_utime, 'child_system_seconds': u.ru_stime,
 'child_max_rss_kib': u.ru_maxrss, 'program_bytes': len(source),
 'program_sha256': sha256(source).hexdigest(), 'stdin_bytes': len(data),
 'stdin_sha256': sha256(data).hexdigest(),
 'argv_sha256': sha256(b'\0'.join(arg.encode() for arg in cmd)).hexdigest(),
 'stdout_bytes': len(r.stdout), 'stdout_sha256': sha256(r.stdout).hexdigest(),
 'stderr_bytes': len(r.stderr), 'stderr_sha256': sha256(r.stderr).hexdigest(),
 'python': sys.version}, sort_keys=True))
print('STDOUT-BEGIN')
print(r.stdout.decode(), end='')
print('STDOUT-END\nSTDERR-BEGIN')
print(r.stderr.decode(), end='')
print('STDERR-END')
raise SystemExit(r.returncode)
PY
```

## Actual execution receipts and remaining proof obligations

**Both checks passed, actual exit 0, with eight source guards unchanged
before and after each run.** The fixed run used the exact certificate bytes
and verified all 12,341 supplied witnesses. It completed in 0.020959 seconds
with child maximum RSS 11,352 KiB. Its stdout hash is identical to the
root's earlier fixed-verifier receipt. The direct-import Lean probe completed
in 1.943606 seconds with child maximum RSS 3,301,532 KiB. That larger imported
Lean environment was deliberately outside the Python memory cap.

The copied verifier is unchanged from its frozen 6,040-byte source. The
Lean probe is 1,770 bytes, SHA-256
`eb4981dd9dbce30ca96e34ed24562cc57eafea96c3679bf7d81c376d9a265fe6`.
The default bash replay is 3,466 bytes, SHA-256
`7949579dd3e68df3d727471ae600488efe62fb716b1398fbf398e661c4a48eb0`.
Commands were the displayed bash fence with argument `fixed`, followed
separately by the same fence with only that argument changed to `lean`.
The metadata's argv hash uses the exact NUL-separated argument bytes;
for fixed mode that includes the full displayed Python source as the
`-c` argument. Source and stdin hashes bind the complete programs/data,
rather than an abbreviated command display.

Full exact wrapper output for the fixed run:

~~~text
{"argv_sha256": "ff6d6eea21da4f53cc6e4a69be2a40daf6541a3ade4c6bb5cd8ccc0ba9e6cdae", "child_max_rss_kib": 11352, "child_system_seconds": 0.004114, "child_user_seconds": 0.016458, "exit": 0, "guard_count": 8, "guards": "PASS", "mode": "fixed", "program_bytes": 6040, "program_sha256": "7f8be20e9ce9cbf6e257ab0e6042e207ed587873aa854acf4584fcd1fb4c39de", "python": "3.12.3 (main, Jul 15 2026, 23:46:41) [GCC 13.3.0]", "stderr_bytes": 0, "stderr_sha256": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "stdin_bytes": 19034, "stdin_sha256": "c1374409d4f6804487179fe9765695a2f0d756ccd2a79b5ee8616e919acbb7b1", "stdout_bytes": 170, "stdout_sha256": "c5a5255fa822e07684c32339d8a8fe64d149466f2f1c3f2b5cadd79e3e234309", "wall_limit_seconds": 60, "wall_seconds": 0.020959}
STDOUT-BEGIN
{"atoms": 120, "candidate_predicates": 2760, "classes": 98, "kernel_theorem": false, "retained": 41, "triple_witnesses": 12341, "verified": "fixed-coverage-certificate"}
STDOUT-END
STDERR-BEGIN
STDERR-END
~~~

Full exact wrapper output for the Lean run:

~~~text
{"argv_sha256": "a5186ea02e35b2784babb645b3f6342f42dffd24a31358744dbd611b87f6a43f", "child_max_rss_kib": 3301532, "child_system_seconds": 0.43723999999999996, "child_user_seconds": 1.564515, "exit": 0, "guard_count": 8, "guards": "PASS", "mode": "lean", "program_bytes": 1770, "program_sha256": "eb4981dd9dbce30ca96e34ed24562cc57eafea96c3679bf7d81c376d9a265fe6", "python": "3.12.3 (main, Jul 15 2026, 23:46:41) [GCC 13.3.0]", "stderr_bytes": 0, "stderr_sha256": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "stdin_bytes": 1770, "stdin_sha256": "eb4981dd9dbce30ca96e34ed24562cc57eafea96c3679bf7d81c376d9a265fe6", "stdout_bytes": 182, "stdout_sha256": "42b8053454b029c76cd77fb3ff1852d6cadf68f177fb46bbc2de2eef77bc9f87", "wall_limit_seconds": 120, "wall_seconds": 1.943606}
STDOUT-BEGIN
'LonelyRunner.PhaseGood' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.phase_certificate_sound' depends on axioms: [propext, Classical.choice, Quot.sound]
STDOUT-END
STDERR-BEGIN
STDERR-END
~~~

The JSON lines and marker lines are wrapper output. The reported stdout/
stderr hashes cover the child streams between those markers only.
Both streams were captured to EOF, stderr is empty, and no timeout or
output bound failed. No finite experiment or Lean probe required a retry.
Two initial read-only source-location lookups tried nonexistent
`LonelyRunner/Defs.lean` and `LonelyRunner/Basic.lean`; the actual norm
definition was found in `FastRunnerInsertion.lean`. These were source
lookup errors, not verifier/compiler failures, and changed no files.

The independent final verdict is therefore **accept**: the fixed data gives
the claimed exact finite coverage; the reviewed manuscript endpoint,
normalization and domination arguments are sound; and the frozen generic
Lean implication has the exact accepted type and only permitted axioms.
The certificate, its schema and all strict alternatives need no correction.

The remaining kernel obligations are concrete and separate:

1. Define the 120 atoms from the actual ordered cut list and prove coverage
   of [0,1), with the singleton/open split and sentinel endpoint intact.
2. Prove the strict floor-band implication, singleton arithmetic and every
   true open-bit endpoint inequality, yielding the concrete `hsound`.
3. Check ordinary numeral mask/core/dom data and all supplied triple
   memberships inside Lean, with a checked exhaustive correspondence to
   every sorted triple including repetitions. Base64 transport, Python
   success and hashes cannot provide a trusted theorem hypothesis.
4. Instantiate `phase_certificate_sound`, then prove integer periodic
   normalization and decode the Fin 23 candidate into the stated a,b
   alternatives. The target `renault_phase_five_one` is still absent from
   the frozen source.

No minimality proof or first-bit tie convention is required in the trusted
continuum theorem once the actual containment and witness premises are proved.
They remain independently checked metadata of this compact certificate.

This does not prove the separate Renault 6.1/6.4 phase statements, the
five-moving margin-1/6 supply, the divisibility and maximizer assembly,
canonical six-total LRC, or unrestricted LRC. In particular H8 still needs
the five-moving margin 1/6 in addition to the six-moving margin 1/7; current
H6 supplies d=1 through 4. Root retains integration/publication ownership,
and the concurrent maximizer source is outside this review.

Final static verification passed the workflow validator, exact Python/Lean
program hashes, replay syntax and retained evidence bound. The review, frozen
plan, result, certificate, execution JSON and generic source together occupy
less than 100,000 bytes, well below the 1 MiB retained-evidence limit.
