# Renault 5.1: unexecuted certificate experiment and continuum bridge

Status: proposed experiment, **not executed**. The finite coverage result and
the Lean theorem are unknown in this task. This report derives the soundness
bridge and freezes complete programs for root review before any execution.
It does not implement or prove the six-total theorem or unrestricted LRC.

The requested route is Astra/xhigh; observed model metadata is unavailable.
The task checkpoint is `f1d45fdf95af26f31cffcc92485fc5951c4b0169`.
Configuration, workflow, policy, and focused state were read. The actual
`python3 scripts/validate_workflow.py` command passed. An initial mistaken
invocation of nonexistent `scripts/workflow_state.py` exited 2; it performed
no validation or mutation. Only this report is owned. The frozen maximizer
report `ef0b17914b831106650ff0f09152054131fcaba58ce47a10a0bf36c0fdccb100`
and other workers' files are preserved.

## Exact target and frozen finite domain

Write `G(y) := circleNorm(y) >= 1/6` and
`H(y) := circleNorm(y) > 1/6`. The target for arbitrary three phases is

    (exists a in {2,3,4,5}, b in {1,2,3,4,5}, forall j, G(a*x_j+b/6))
    or (exists b in {1,2,4}, forall j, H(x_j+b/6)).

This is the mixed closed/strict statement of
[Renault, Lemma 5.1, printed p. 97](https://compmath.wordpress.com/wp-content/uploads/2008/08/view-obstruction_a_shorter_proof_for_6_lonely-runners.pdf#page=5).
The linked file is a hosted copy of the research paper; its header identifies
DOI `10.1016/j.disc.2004.06.008`. No byte identity with the inaccessible
publisher PDF is claimed. The certificate construction and bridge below are
our derivation, rather than an attribution of this algorithm to Renault.

The 23 candidates have this immutable bit order:

- Bits 0 through 19: `a = 2 + bit // 5`, `b = 1 + bit % 5`, closed.
- Bits 20, 21, 22: `a = 1`, respectively `b = 1,2,4`, strict.

Use integer cut numerators

    C = sorted({20*k : 0 <= k < 18}
             union {15*k : 0 <= k < 24}
             union {12*k : 0 <= k < 30}),

then append 360. There are 60 circle cuts: the corresponding grids
`U18,U24,U30` intersect pairwise and triply in `U6`, giving
`18+24+30-6-6-6+6=60`. This is the previously proposed atom model;
its separate independent review is outside this task. The program constructs
the same cut list by the fixed loop `range(360)` and checks its cardinality.

For `0 <= h < 60`, atom `2*h` is `{C[h]/360}` and atom `2*h+1` is
`(C[h]/360,C[h+1]/360)`. Thus there are exactly 120 atoms, including 60
singletons. Their representatives have denominator 720 and numerators
`2*C[h]` and `C[h]+C[h+1]`, respectively. The appended endpoint 1 is
excluded; phase zero belongs to the singleton at zero. There is no epsilon
sampling or rounding convention.

For candidate `(a,b)`, set

    n = a*r + 120*b, q = n // 720, rem = n % 720.

The representative is good exactly when `120 <= rem <= 600` for a closed
candidate, or `120 < rem < 600` for a strict candidate. The good mask is
the 23-bit integer encoding these tests. In particular, an equality at
either endpoint is rejected by the last three candidates.

## A direct integer certificate for the continuum

This section is a complete manuscript implication, independent of the
outcome of the proposed finite computation.

First, for every real y, integer q, and `0 <= delta <= 1/2`,

    q+delta <= y <= q+1-delta  implies  delta <= circleNorm(y).

For `0 < delta < 1/2`, replacing both inequalities by strict inequalities
implies `delta < circleNorm(y)`. To see both statements, subtract q using
integer periodicity. For `z in [0,1]`, the norm is `min(z,1-z)`:
if `z <= 1/2`, use the existing half-unit norm identity on z; otherwise
use integer periodicity on `z-1`, whose absolute value is `1-z`.
This also proves that with `q=floor(y)`, the corresponding band tests are
equivalent to the norm tests. Strictness follows from both arguments of
the minimum being strictly larger than delta, not from continuity alone.

For an open atom with integer endpoints c<d, a good representative yields
the following **non-strict integer endpoint certificate**:

    360*q + 60 <= a*c + 60*b,
    a*d + 60*b <= 360*q + 300.                         (E)

Here q is the quotient calculated above from its midpoint. We now derive
why (E) follows mathematically, rather than merely promising to test it.
Let `L=c/360`, `U=d/360`, `z=(L+U)/2`, and define

    A = (6*q+1-b)/(6*a), B = (6*q+5-b)/(6*a).

Representative goodness implies `A <= z <= B`; for a strict candidate
these are already strict. A or B that lies in `[0,1)` is a cut:
its numerator on the /360 grid is `(60/a)*(6*q+t-b)`, for t=1 or 5.
For a=1,2,3,4,5, the coefficient `60/a` is respectively 60,30,20,15,12.
These are in U6, U12, U18, U24, U30, and `U6,U12` are contained in U24.
The integrality assertion is over integers, including negative q or
negative boundary numerators; only boundaries in `[0,1)` are claimed to
belong to C.

Consecutive cuts have no cut in `(L,U)`. Since `L<z<U`, the alternatives
`L<A<=z` and `z<=B<U` are impossible. Hence `A<=L` and `U<=B`, exactly
(E) after multiplication by positive `360*a`. This argument also rules
out a midpoint equality with either safety boundary for closed candidates.
It works at the first and last interval: any hypothetical interior
boundary still lies in `[0,1)`, while a boundary outside that range does
not obstruct the two endpoint inequalities.

Conversely, (E) directly certifies every real x in this open atom, without
requiring the trusted verifier to know why the cut list was chosen:

    q+1/6 <= a*L+b/6 < a*x+b/6 < a*U+b/6 <= q+5/6.

The two strict inequalities use `a>0` and `L<x<U`. Therefore every such x
satisfies **strict** norm safety for this candidate. This suffices for both
candidate types. Equality of an interval endpoint with a safety boundary
is harmless because that endpoint is not in the open atom.

For a singleton, use the exact quotient identity `n=720*q+rem`, with
`0<=rem<720`. Dividing by 720 gives its affine phase in the chosen floor
band. The representative mask comparison proves precisely the requested
closed or strict statement at the singleton, without extending it to a
neighboring point. This is where replacing all tests by closed ones would
invalidate the target.

Every x in `[0,1)` belongs to one of these atoms: take the largest cut
`c/360 <= x`; it exists because zero is a cut. If equality holds, choose
the singleton. Otherwise x lies strictly between that cut and the next
one, including the appended endpoint 1. Strict ordering of the finite
list proves both this coverage and uniqueness. No measure-zero deletion
or endpoint limit is used.

It follows that checking (E) for each true open-atom mask bit and the
singleton comparisons gives a sound mask interpretation for **all** real
phases in `[0,1)`. For a general real phase x, write
`x=floor(x)+fract(x)`. Since every a is an integer,
`a*x+b/6 = a*floor(x)+(a*fract(x)+b/6)`; integer periodicity preserves
both norm comparisons. Thus the same certificate would establish the
stated arbitrary-real version. Full equivalence of all false mask bits
on open atoms is unnecessary for this positive implication; the actual
generator nevertheless calculates exact representative masks, and its
fixed verifier checks those exact calculations.

## Quotient, domination, and witnesses

Process atoms in increasing ID. Equal masks form one class, represented
by the least atom ID. Class IDs are in increasing representative order.
A retained class is inclusion-minimal among the distinct **good** masks:
it has no other class mask that is a proper subset. Smaller good masks
are harder. This direction must not be reversed.

Every atom mask contains a retained one: in the finite nonempty collection
of class masks contained in that atom mask, choose an inclusion-minimal
member. A proper subset class would also belong to that collection,
contradicting minimality. Retained classes are ordered by class ID. For
each atom the dominator is the first retained mask contained in its mask.

For retained count m, visit all triples `0<=i<=j<=k<m` lexicographically,
with repetition. Their number is `m*(m+1)*(m+2)//6 <= 295240`.
For each, select the least candidate bit in the three-way intersection.
This is recorded as one byte in [0,22]. The first empty intersection stops
the experiment with that exact triple of representative phases, classified
as a proposed obstruction. No domain widening or alternative candidate
family follows. A completed positive certificate encodes all witness bytes
in base64, at most 393656 ASCII bytes.

The soundness proof does not trust minimality. For arbitrary three atoms,
map them to their supplied dominators, sort the three indices, and use the
corresponding supplied witness. Membership in all three retained masks
and their inclusion in the original masks gives the same candidate at
all three real phases. Sorting does not alter an intersection; repeated
indices are why triples with repetition are required.

The separate verifier checks the concrete quotient map, exact masks,
domination, and retained antichain. Domination of every atom together with
the antichain proves that these really are all inclusion-minimal classes:
if some class were properly below a retained one, its own retained
dominator would contradict the antichain. Any omitted minimal class would
equal its dominator. Thus this metadata can be checked without rerunning
the generator's all-class minimalization. For coverage, minimality and the
quotient are optional compression metadata; dominators and bit witnesses
are the logically necessary certificates.

## Predeclared operations, bounds, and stop rules

These are proposed limits, not timing or size measurements.

| Operation | Exact domain or bound |
| --- | --- |
| Construct cuts | 360 grid entries; at most 1080 remainder tests with the three fixed divisors |
| Construct masks | 120 atoms times 23 candidates = 2760 remainder predicates |
| Check true-bit interval certificates | At most 1380 open-atom true bits |
| Quotient | 120 atom iterations: 120 membership tests, 120 lookups, and U inserts |
| Generator minimalization | Exactly U*(U-1) distinct ordered class comparisons, at most 14280; no early break |
| Generator dominators | Exactly 120*m inclusion tests, at most 14400; retain first match |
| Generator triple loop | At most m*(m+1)*(m+2)/6, at most 295240; stop on first empty intersection |
| Fixed coverage verification | Same fixed 2760 predicates and at most 295240 supplied triple witnesses; no witness discovery |
| Fixed metadata verification | At most 7140 retained unordered pairs and 14400 inclusion/tie checks |
| Fixed obstruction verification | Three supplied atom representatives times 23 predicates; no triple exploration |

The fixed verifier is a separately launched program. A discovery result
does not automatically launch it. It checks one supplied JSON object;
obstruction mode does not validate a claim that the supplied case was the
first case. The generator's `counters` field is reported metadata, not
accepted evidence in either verifier mode; the verifier emits its own
checked counts. Coverage mode validates
every supplied witness, including the least-bit tie convention, but does
not search for replacement witnesses.

No floating point, randomness, solver, external packages, network, Lean,
or cache access appears in the programs. Input reads and output sizes are
capped. The driver gives the child CPU limits (59,60) seconds and 224 MiB
address space, itself uses a 32 MiB soft address limit, and enforces a
60-second child wall deadline. These address-space soft limits sum to
256 MiB; the child cannot raise its hard limit. Wall-deadline cleanup and
small receipt writes occur after killing a timed-out child. Exact stdin,
stdout, stderr, source, launcher, exit/signal, hashes, and cap status are
retained. At most 425984 bytes of combined child output are retained,
with at most 425984 input bytes and 65536 source bytes; receipt and final
byte accounting leave the evidence below 1 MiB. A timeout or cap failure
is an incomplete experiment, never a coverage result. No larger retry is
preauthorized by this report.

The driver's resource limits and capture logic are themselves proposed,
not executed or profiled here. All code below is complete source intended
for later review and extraction, not pseudocode. A positive Python exit
would establish only exact finite evidence; kernel proofs of the bridge
and all finite certificate checks remain necessary.

## Proposed generator: `discover.py` — UNEXECUTED

```python
import base64
import itertools
import json
import sys

LIMIT = 425984
SCHEMA = "renault-5.1-phase-v1"
CANDIDATES = [(a, b, False) for a in range(2, 6) for b in range(1, 6)]
CANDIDATES += [(1, b, True) for b in (1, 2, 4)]


def require(condition, message):
    if not condition:
        raise ValueError(message)


def emit(value):
    data = (json.dumps(value, sort_keys=True, separators=(",", ":")) + "\n").encode()
    require(len(data) <= LIMIT, "output cap")
    sys.stdout.buffer.write(data)


def main():
    require(sys.stdin.buffer.read(1) == b"", "discovery stdin must be empty")
    cuts = [c for c in range(360) if c % 20 == 0 or c % 15 == 0 or c % 12 == 0]
    require(len(cuts) == 60 and cuts[0] == 0, "cut contract")
    cuts.append(360)
    require(len(CANDIDATES) == 23, "candidate contract")
    reps = []
    masks = []
    predicates = 0
    endpoint_checks = 0
    for atom in range(120):
        h = atom // 2
        c, d = cuts[h], cuts[h + 1]
        r = c + d if atom % 2 else 2 * c
        reps.append(r)
        mask = 0
        for bit, (a, b, strict) in enumerate(CANDIDATES):
            predicates += 1
            q, rem = divmod(a * r + 120 * b, 720)
            good = 120 < rem < 600 if strict else 120 <= rem <= 600
            if good:
                mask |= 1 << bit
                if atom % 2:
                    endpoint_checks += 1
                    require(360 * q + 60 <= a * c + 60 * b, "lower band")
                    require(a * d + 60 * b <= 360 * q + 300, "upper band")
        masks.append(mask)
    require(predicates == 2760 and endpoint_checks <= 1380, "predicate budget")

    index = {}
    class_reps = []
    class_of = []
    for atom, mask in enumerate(masks):
        if mask not in index:
            index[mask] = len(class_reps)
            class_reps.append(atom)
        class_of.append(index[mask])
    unique = len(class_reps)
    minimal_classes = []
    comparisons = 0
    for i in range(unique):
        current = masks[class_reps[i]]
        minimal = True
        for j in range(unique):
            if i != j:
                comparisons += 1
                other = masks[class_reps[j]]
                if other & current == other:
                    minimal = False
        if minimal:
            minimal_classes.append(i)
    require(comparisons == unique * (unique - 1) <= 14280, "class budget")
    core_atoms = [class_reps[i] for i in minimal_classes]
    m = len(core_atoms)
    require(1 <= m <= 120, "retained count")
    dom = []
    dom_checks = 0
    for mask in masks:
        first = None
        for i, atom in enumerate(core_atoms):
            dom_checks += 1
            if masks[atom] & mask == masks[atom] and first is None:
                first = i
        require(first is not None, "missing dominator")
        dom.append(first)
    require(dom_checks == 120 * m <= 14400, "dominator budget")

    expected = m * (m + 1) * (m + 2) // 6
    require(expected <= 295240, "triple budget")
    witnesses = bytearray()
    visited = 0
    counters = {"predicates": predicates, "endpoint_checks": endpoint_checks,
                "classes": unique, "class_comparisons": comparisons,
                "retained": m, "dominator_checks": dom_checks}
    for i, j, k in itertools.combinations_with_replacement(range(m), 3):
        visited += 1
        atoms = [core_atoms[i], core_atoms[j], core_atoms[k]]
        common = masks[atoms[0]] & masks[atoms[1]] & masks[atoms[2]]
        if common == 0:
            emit({"schema": SCHEMA, "kind": "obstruction", "atoms": atoms,
                  "numerators": [reps[a] for a in atoms],
                  "masks": [masks[a] for a in atoms],
                  "minimal_triple": [i, j, k], "visited": visited,
                  "counters": counters})
            return 3
        bit = (common & -common).bit_length() - 1
        witnesses.append(bit)
    require(visited == expected == len(witnesses), "incomplete triple loop")
    emit({"schema": SCHEMA, "kind": "coverage", "cuts": cuts,
          "masks": masks, "class_reps": class_reps, "class_of": class_of,
          "minimal_classes": minimal_classes, "dom": dom,
          "witnesses_b64": base64.b64encode(witnesses).decode("ascii"),
          "visited": visited, "counters": counters})
    return 0


if __name__ == "__main__":
    try:
        code = main()
    except Exception as exc:
        print("experiment-error:" + type(exc).__name__, file=sys.stderr)
        code = 2
    raise SystemExit(code)
```

## Proposed fixed verifier: `verify.py` — UNEXECUTED

This deliberately contains its own fixed geometry and arithmetic, with no
import of the discovery program. It validates a supplied certificate or
one supplied obstruction. No invocation has been made.

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

## Proposed capped driver: `run-capped.py` — UNEXECUTED

Extract the three Python fences verbatim to a fresh directory using the
displayed filenames. Extraction is a text operation, not experiment
execution. After review and a separate root authorization, the complete
commands are, respectively:

```bash
python3 -I run-capped.py discover ./discovery-evidence
python3 -I run-capped.py verify ./fixed-evidence ./discovery-evidence/stdout.bin
```

Run only the authorized one. The output directory must not exist. The
second command consumes the first run's exact stdout as its fixed stdin.
The driver records actual exit status and preserves signals; discovery
exit 3 is a proposed obstruction, exit 0 a proposed coverage certificate,
and other outcomes are incomplete/errors. Verifier exit 0 says only that
its supplied finite object passed its checks. A complete result requires
`capture_complete=true` and no resource/capture failure in the receipt.

```python
import hashlib
import json
import os
from pathlib import Path
import resource
import selectors
import signal
import subprocess
import sys
import time

IO_LIMIT = 425984
SOURCE_LIMIT = 65536
EVIDENCE_LIMIT = 1048576
MIB = 1024 * 1024


def digest(data):
    return hashlib.sha256(data).hexdigest()


def child_limits():
    resource.setrlimit(resource.RLIMIT_AS, (224 * MIB, 224 * MIB))
    resource.setrlimit(resource.RLIMIT_CPU, (59, 60))
    resource.setrlimit(resource.RLIMIT_CORE, (0, 0))


def kill_child(process):
    try:
        os.killpg(process.pid, signal.SIGKILL)
    except ProcessLookupError:
        pass


def main():
    if len(sys.argv) not in (3, 4) or sys.argv[1] not in ("discover", "verify"):
        raise ValueError("usage: run-capped.py discover OUT or verify OUT INPUT")
    mode = sys.argv[1]
    if len(sys.argv) != (3 if mode == "discover" else 4):
        raise ValueError("argument count")
    resource.setrlimit(resource.RLIMIT_AS, (32 * MIB, 256 * MIB))
    root = Path(__file__).resolve().parent
    names = ("discover.py", "verify.py", "run-capped.py")
    sources = {name: (root / name).read_bytes() for name in names}
    if sum(map(len, sources.values())) > SOURCE_LIMIT:
        raise ValueError("source cap")
    input_data = b""
    if mode == "verify":
        with Path(sys.argv[3]).open("rb") as handle:
            input_data = handle.read(IO_LIMIT + 1)
        if len(input_data) > IO_LIMIT:
            raise ValueError("input cap")
    outdir = Path(sys.argv[2]).resolve()
    outdir.mkdir(parents=False, exist_ok=False)
    for name, data in sources.items():
        (outdir / name).write_bytes(data)
    (outdir / "stdin.bin").write_bytes(input_data)
    chosen = "discover.py" if mode == "discover" else "verify.py"
    command = [sys.executable, "-I", str(outdir / chosen)]
    stdout = bytearray()
    stderr = bytearray()
    failure = None
    process = None
    started = time.monotonic()
    with (outdir / "stdin.bin").open("rb") as stdin_handle:
        process = subprocess.Popen(command, stdin=stdin_handle,
                                   stdout=subprocess.PIPE, stderr=subprocess.PIPE,
                                   cwd=outdir, start_new_session=True,
                                   preexec_fn=child_limits)
        selector = selectors.DefaultSelector()
        selector.register(process.stdout, selectors.EVENT_READ, stdout)
        selector.register(process.stderr, selectors.EVENT_READ, stderr)
        while selector.get_map():
            remaining = 60 - (time.monotonic() - started)
            if remaining <= 0:
                failure = "wall-timeout"
                break
            events = selector.select(min(remaining, 0.2))
            for key, _ in events:
                room = IO_LIMIT - len(stdout) - len(stderr)
                chunk = os.read(key.fileobj.fileno(), min(8192, room + 1))
                if not chunk:
                    selector.unregister(key.fileobj)
                    key.fileobj.close()
                    continue
                if len(chunk) > room:
                    key.data.extend(chunk[:room])
                    failure = "combined-output-cap"
                    break
                key.data.extend(chunk)
            if failure:
                break
        if failure:
            kill_child(process)
        for key in list(selector.get_map().values()):
            selector.unregister(key.fileobj)
            key.fileobj.close()
        selector.close()
        if not failure:
            remaining = 60 - (time.monotonic() - started)
            if remaining <= 0:
                failure = "wall-timeout"
                kill_child(process)
            else:
                try:
                    process.wait(timeout=remaining)
                except subprocess.TimeoutExpired:
                    failure = "wall-timeout"
                    kill_child(process)
        process.wait()
    elapsed = time.monotonic() - started
    (outdir / "stdout.bin").write_bytes(stdout)
    (outdir / "stderr.bin").write_bytes(stderr)
    hashes = {name: digest(data) for name, data in sources.items()}
    hashes.update({"stdin.bin": digest(input_data), "stdout.bin": digest(stdout),
                   "stderr.bin": digest(stderr)})
    receipt = {"mode": mode, "command": command, "python": sys.version,
               "platform": sys.platform, "returncode": process.returncode,
               "signal": -process.returncode if process.returncode < 0 else None,
               "wall_seconds": elapsed, "failure": failure,
               "capture_complete": failure is None,
               "child_cpu_limits": [59, 60], "child_address_bytes": 224 * MIB,
               "driver_address_soft_bytes": 32 * MIB, "wall_limit_seconds": 60,
               "combined_output_limit": IO_LIMIT, "hashes": hashes}
    record = (json.dumps(receipt, indent=2, sort_keys=True) + "\n").encode()
    if len(record) > 4096:
        raise ValueError("receipt cap")
    (outdir / "receipt.json").write_bytes(record)
    evidence_bytes = sum(p.stat().st_size for p in outdir.iterdir())
    if evidence_bytes > EVIDENCE_LIMIT:
        raise ValueError("evidence cap")
    print(json.dumps({"receipt": str(outdir / "receipt.json"),
                      "returncode": process.returncode, "failure": failure,
                      "evidence_bytes": evidence_bytes}, sort_keys=True))
    if failure:
        return 124 if failure == "wall-timeout" else 125
    return process.returncode if process.returncode >= 0 else 128 - process.returncode


if __name__ == "__main__":
    raise SystemExit(main())
```

The cap branch explicitly records incomplete capture; its stored prefix
must not be described as full stdout. For normal completion, both streams
are captured through EOF before acceptance. Source/stdin hashes in the
receipt bind the exact programs and fixed data actually used. The output
directory is newly created and contains only the seven displayed evidence
files, so final accounting does not inspect or modify another task's files.

## Proposed Lean contract and dependencies

The certificate theorem should use explicit data and kernel-checked
arithmetic. The following is an exact mathematical interface; its Lean
syntax and library invocations have not been compiled in this task.

```lean
-- Candidate k has the exact (a,b,strict) interpretation specified above.
def PhaseGood (k : Fin 23) (x : ℝ) : Prop :=
  if k.val < 20 then
    (1 : ℝ) / 6 ≤ circleNorm
      (((2 + k.val / 5 : ℕ) : ℝ) * x +
        ((1 + k.val % 5 : ℕ) : ℝ) / 6)
  else
    (1 : ℝ) / 6 < circleNorm
      (x + ((if k.val = 20 then 1 else if k.val = 21 then 2 else 4 : ℕ) : ℝ) / 6)

-- AtomMem uses the /360 singleton/open-interval definitions in this report.
-- Generic transfer: compression metadata is not a mathematical assumption.
theorem phase_certificate_sound
    (AtomMem : Fin 120 → ℝ → Prop)
    (mask : Fin 120 → Finset (Fin 23))
    (m : ℕ) (core : Fin m → Fin 120) (dom : Fin 120 → Fin m)
    (hpartition : ∀ x : ℝ, 0 ≤ x → x < 1 → ∃ a, AtomMem a x)
    (hsound : ∀ a k, k ∈ mask a → ∀ x, AtomMem a x → PhaseGood k x)
    (hdom : ∀ a, mask (core (dom a)) ⊆ mask a)
    (htriples : ∀ i j k : Fin m, i ≤ j → j ≤ k →
      ∃ c : Fin 23, c ∈ mask (core i) ∧
        c ∈ mask (core j) ∧ c ∈ mask (core k)) :
    ∀ x : Fin 3 → ℝ, (∀ j, 0 ≤ x j ∧ x j < 1) →
      ∃ c : Fin 23, ∀ j, PhaseGood c (x j)

theorem renault_phase_five_one (x : Fin 3 → ℝ) :
    (∃ a b : ℕ, 2 ≤ a ∧ a ≤ 5 ∧ 1 ≤ b ∧ b ≤ 5 ∧
      ∀ j, (1 : ℝ) / 6 ≤ circleNorm ((a : ℝ) * x j + (b : ℝ) / 6)) ∨
    (∃ b : ℕ, (b = 1 ∨ b = 2 ∨ b = 4) ∧
      ∀ j, (1 : ℝ) / 6 < circleNorm (x j + (b : ℝ) / 6))
```

The first theorem is generic certificate soundness, with no unproved
coverage hidden in its conclusion; the final theorem remains a target.
Instantiate its partition using the 61 cut entries with checked strict
order, endpoints, and singleton/open split. Prove `hsound` by integer
quotient identities and (E). The small strict floor-band helper follows
from the minimum identity proved above. `hdom` uses finite mask inclusion.
For `htriples`, import each concrete witness byte as an ordinary numeral
and prove its range and the three memberships; the proof of exhaustive
lexicographic indexing must account for all `i<=j<=k`, including repeats.
Alternatively emit one declaration per first index, each checking its
explicit finite triangular block, and combine them with a checked finite
case split. Missing or duplicate triples must fail the aggregate theorem.

The base64 container is only a transport format. Decode it outside Lean
to proposed numeral data, then check the complete data and its coverage
inside the kernel. Neither a Python success flag, SHA-256, native_decide,
an external oracle, nor an unchecked generated theorem can supply a
mathematical premise. Kernel-reduced `decide` or explicit arithmetic proof
terms are acceptable only when the resulting declaration is checked with
the pinned dependencies and permitted axioms. Hashes establish provenance,
not truth. Minimality and first-witness conventions may be separately
audited but need not inflate the trusted theorem.

Reuse source-level APIs already identified in the frozen maximizer plan:
`FastRunnerInsertion.circleNorm_add_int` and the half-unit norm identity;
`StructuredClasses.circleNorm_ge_of_int_band`; and
`PairSumCompleteness.int_band_of_circleNorm_ge`. These module-qualified
descriptions identify source locations, not a claim that their Lean
namespace literally equals the filename. Floor/cast identities use
`Int.floor_add_fract`, Euclidean division, and positive-denominator
arithmetic. The interval bridge requires no compactness, optimization,
or continuity theorem. Root is independently inspecting existing finite
certificate patterns; this task does not duplicate that source audit.

The minimal dependency order is: review this unexecuted program and band
proof; authorize one capped discovery run; preserve its exact result;
authorize the separate fixed verification of that result; review the
fixed evidence; implement the generic partition/band/mask transfer and
the exact numeral certificate; check the resulting theorem and axiom
dependencies. An obstruction, incomplete run, or failed verifier instead
ends this bounded experiment for reassessment. No execution or automatic
promotion is implied by saving the plan.

## Evidence status and remaining gap

Only policy validation, source reading, primary-paper reading, report
writing, and static text hashing are allowed and performed in this task.
No masks, retained count, triple coverage, resource pilot, certificate
program, fixed verifier, or Lean proof has been executed. The maximal
counts are derived bounds, not observed counts. The endpoint and
domination implications are manuscript proofs awaiting independent review
and implementation. Renault 5.1 remains unproved in the repository by this
task, as do the separate six-total assembly and the missing five-moving
margin-1/6 supply needed by the canonical H8 route. Lemmas 6.1 and 6.4 are
outside this report's scope.

Static text extraction and SHA-256 hashing, without importing, parsing,
or running any proposed program, gave these bindings. Each hashed byte
string starts at the first line after its Python fence and includes the
newline immediately before the closing fence.

| Proposed file | Bytes | SHA-256 |
| --- | ---: | --- |
| `discover.py` | 4505 | `57b157b6f02cc82a81c10a2e8b576e1aa84213a6c9f80d2154a77cc5770142e4` |
| `verify.py` | 6040 | `7f8be20e9ce9cbf6e257ab0e6042e207ed587873aa854acf4584fcd1fb4c39de` |
| `run-capped.py` | 5617 | `407325b3e7e57b5a873d8a3068c1a579e74a87ed06d8b8b4efd247332437fa33` |

The three sources total 16162 bytes. The conservative evidence bound from
the declared caps is `425984*2+65536+4096=921600` bytes, below 1 MiB.
These arithmetic size bounds do not assert that an experiment completed.

For reproducible extraction only, the following proposed shell command
creates a fresh directory and checks these hashes. It is also unexecuted;
it launches none of the three programs. Then use only the separately
authorized driver command from above, within that directory.

```bash
python3 - <<'PY'
from pathlib import Path
import hashlib
report = Path('/home/joshua/lonely-runner-formalization/research/astra-renault-phase-certificate-plan.md')
target = Path('/tmp/renault-phase-five-one-reviewed')
text = report.read_text()
blocks = [part.split('```', 1)[0].encode() for part in text.split('```python\n')[1:]]
spec = [
    ('discover.py', '57b157b6f02cc82a81c10a2e8b576e1aa84213a6c9f80d2154a77cc5770142e4'),
    ('verify.py', '7f8be20e9ce9cbf6e257ab0e6042e207ed587873aa854acf4584fcd1fb4c39de'),
    ('run-capped.py', '407325b3e7e57b5a873d8a3068c1a579e74a87ed06d8b8b4efd247332437fa33'),
]
if len(blocks) != len(spec):
    raise ValueError('fence count')
for block, (name, expected) in zip(blocks, spec):
    if hashlib.sha256(block).hexdigest() != expected:
        raise ValueError('source hash: ' + name)
target.mkdir(exist_ok=False)
for block, (name, _) in zip(blocks, spec):
    (target / name).write_bytes(block)
print(target)
PY
```
