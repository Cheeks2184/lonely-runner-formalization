# P68-BA-DEF-02 contract audit

Task: `VER-P68-BA-DEF-02-CONTRACT-195`

Candidate: `72a6ab20dcfc439fa118bfa5f97465730f0bc09b`

Accepted Task01 contract:
`039e0d4f20a9677ec74bed8ccf1b058afbb27cd0`

## Verdict

**CORRECTIONS REQUIRED.**

The candidate is not `LUNA-READY`. The mathematical and implementation
contract is preserved exactly, but the new runtime bootstrap is not yet
fail-closed under malformed selected metadata, timestamp inversion, or a
candidate created during enumeration. Its exact PowerShell invocation also
cannot execute the unsigned temporary probe under the current host policy.
The launch-record draft remains non-authorizing and cannot launch a worker.

This is a contract-only operational review. It launches no Luna session,
accepts no implementation, and promotes no Lean, mathematical,
computational, or Lonely Runner claim.

## Candidate inventory and immutable boundaries

Relative to base `c05cd83743e6290598077006b380da5d80a1c122`, the candidate
adds exactly:

- `research/luna/contracts/p68-ba-def-02.md`;
- `research/luna/failures/p68-ba-def-01.md`; and
- `research/luna/launches/p68-ba-def-02.draft.md`.

`git diff --check` is clean. The final immutable path
`research/luna/launches/p68-ba-def-02.md` is absent. The tracked draft:

- is stored only at the distinct `.draft.md` path;
- says `draft only; not approved and not launch-authorizing`;
- retains placeholders; and
- records launch authority as `pending`.

It therefore cannot satisfy the contract-delivery gate.

The Task01 operational-failure record is accurate and appropriately scoped.
It records zero fixtures, files, commits, or evidence and does not treat the
later coordinator observation as retroactive worker-local admission.

## Exact Task01 preservation

After normalizing only the Task01/Task02 temporary-path suffix, the following
candidate sections are byte-for-byte identical to the accepted Task01
contract:

| Section | Result | Normalized SHA-256 |
| --- | --- | --- |
| Exact module, four definitions, and four lemmas | PASS | `daf791e3a5a8c4bf52ff8384733c0d3480df9644fd9f7f8ec2d3d306e9e4b131` |
| Quantified domains, ordering, and strict boundaries | PASS | `e0449ad0ee20dac4ffd9916e824171548d197b85f4721880830f4667d54478ab` |
| Six mandatory fixtures | PASS | `8281ecd12cb889fa6118c636ba3ea891b14ff5db313f6c981a011b0d0e4d17de` |

Consequently the candidate preserves:

- the exact definition bodies and factor order;
- `NeZero p` and all `Nat`, `Fin`, and `ZMod` domains;
- strict badness `<` with equality safe;
- zero-modulus elaboration failure;
- coordinate, field-point, least-witness, fixture, and log ordering;
- the expected witness table
  `[(0,0), (1,0), (2,1), (3,1), (4,0)]`;
- the collision-bearing negative fixture;
- both distance checks and the equality-boundary check;
- both expected-failure fixtures;
- one allowed tracked Lean module;
- the preflight/supervisor/full-run separation;
- the prohibited-token and axiom checks; and
- the infrastructure-only evidence ceiling.

Task02 changes the intended identities, base, worktree mapping, ignored
temporary directory, and runtime bootstrap only. The extra ignored
`RuntimeProbe.ps1` path and its cleanup instruction are internally
consistent.

## Twelve admission gates

| Gate | Result | Review |
| --- | --- | --- |
| 1. Exact proposition | PASS | Four definitions and four local lemmas only. |
| 2. Quantified domains | PASS | Task01 domains are exact. |
| 3. Boundary | PASS | Strict inequality, safe equality, and missing `NeZero 0` are exact. |
| 4. Ordering | PASS | Mathematical, fixture, report, and inventory ordering is frozen. |
| 5. Fixtures | PASS | All six fixtures and their expected outcomes are preserved. |
| 6. Allowed files | PASS | One tracked module plus the exact ignored Task02 paths. |
| 7. Commands | **FAIL** | The runtime command is blocked by host execution policy, and the probe algorithm has fail-open cases below. |
| 8. Report fields | PASS WITH CORRECTION | The schema is complete, but the final acceptance list has a stale review ID. |
| 9. Evidence ceiling | PASS | `infrastructure-only`; no promotion authority. |
| 10. Stop/escalation | **FAIL** | Three promised runtime failure modes can reach exit 0. |
| 11. Supervision | PASS | Preflight inspection and later implementation review remain separate. |
| 12. Base/isolation/delivery | PASS | Exact Task02 base and fresh isolation are required; draft cannot authorize launch. |

## RuntimeProbe static audit

The embedded PowerShell parses successfully. It emits no identifier, filename,
absolute path, raw JSON, raw exception, model-independent prose, or private
metadata on its explicit output paths. PASS contains only the frozen model,
effort, CWD status, source, freshness status, and candidate count. Explicit
failures use fixed codes, while the WSL wrapper suppresses other stderr and
returns a generic fixed failure.

The following properties are sound:

- model and effort compare case-sensitively to
  `gpt-5.6-luna` and `xhigh`;
- metadata source compares case-sensitively to `exec`;
- metadata and turn CWDs must normalize to the expected Windows CWD;
- stale session metadata is excluded by the launch not-before value;
- missing first turn context fails;
- more than one candidate present in the initial snapshot fails; and
- no real session metadata needs to appear in the public result.

Four corrections remain mandatory.

### C1 — make the exact PowerShell command executable

The frozen command

```text
powershell.exe -NoProfile -NonInteractive -File <ignored probe> ...
```

was rejected by the current host policy because the temporary probe is
unsigned. Parser validation alone does not repair execution. Freeze an
explicit current-host-compatible invocation, such as adding
`-ExecutionPolicy Bypass` for this exact reviewed temporary script, and
retest the literal WSL command. Do not weaken any metadata check while making
this operational correction.

### C2 — reject malformed records inside the selected candidate

After a file's first `session_meta` record matches expected CWD, source, and
freshness, the current loop catches malformed later JSON and continues.
Synthetic input

```text
matching session_meta
malformed JSON
valid turn_context
```

returned the sanitized PASS line with exit 0. This contradicts the contract's
parsing-failure stop rule.

Keep ignoring unrelated files whose first line cannot establish candidacy,
but once candidacy is established, make any malformed record before the first
`turn_context` fail with a fixed sanitized code.

### C3 — bind turn time to session time

The probe checks both timestamps against the launch window but never requires
the first turn to occur at or after its own `session_meta` timestamp. A
synthetic turn timestamp preceding the matching session timestamp, while both
remained inside the permitted window, returned PASS with exit 0.

Require:

```text
candidate.MetaTime <= turnTime
```

and fail with a fixed code on inversion.

### C4 — close the post-enumeration ambiguity race

`Get-ChildItem` is evaluated once before candidate files are parsed. A second
matching file created after that enumeration but before completion is never
considered. A synthetic test slowed parsing of the first candidate and created
a second valid candidate during that interval; the probe reached exit 0.

Immediately before PASS, re-enumerate and re-evaluate matching first-line
`session_meta` records. Require the final matching set to contain exactly the
same single internally selected file. Keep all path comparison internal and
emit only the existing sanitized count/status. The corrected review should
repeat this synthetic race test.

## Synthetic probe matrix

All metadata below was synthetic and used a synthetic profile root. No real
session log, identifier, filename, path, prompt, response, or raw private
record was read or reported.

| Case | Observed result | Expected |
| --- | --- | --- |
| Exact valid candidate | PASS, exit 0 | PASS |
| Model mismatch | fixed `model-mismatch`, exit 1 | FAIL |
| Effort mismatch | fixed `effort-mismatch`, exit 1 | FAIL |
| Turn CWD mismatch | fixed `cwd-mismatch`, exit 1 | FAIL |
| Source mismatch | fixed `candidate-count`, exit 1 | FAIL |
| Stale session metadata | fixed `candidate-count`, exit 1 | FAIL |
| Missing turn context | fixed `turn-context-missing`, exit 1 | FAIL |
| Two candidates present initially | fixed `candidate-count`, exit 1 | FAIL |
| Malformed selected record before valid turn | **PASS, exit 0** | FAIL |
| Turn timestamp before session timestamp | **PASS, exit 0** | FAIL |
| Second candidate created after enumeration | **exit 0** | FAIL |

The exact invocation without a process-scoped execution-policy override failed
before these semantic cases could run. The matrix used an override only to
exercise the embedded script logic; this does not validate the frozen command.
All synthetic files were deleted after the test.

## Cross-reference correction

The Task02 return schema and independent-checker section correctly name
`VER-P68-BA-DEF-IMPLEMENTATION-193`. Acceptance criterion 12 still says:

```text
independent implementation review 182 accepts the exact commit
```

Change `182` to `193`. Admission and later implementation acceptance must
not depend on two different review tasks.

## Required re-review package

A corrected candidate must:

1. implement C1--C4 without changing the accepted theorem, algorithm,
   strict-boundary, fixture, allowed-file, supervision, or evidence scopes;
2. correct acceptance criterion 12 from review 182 to review 193;
3. retain the draft-only, non-authorizing launch state;
4. pass PowerShell parsing and the full synthetic matrix, including malformed
   selected JSON, timestamp inversion, and the enumeration race;
5. pass `git diff --check` and a targeted privacy scan; and
6. receive a fresh independent contract review before Sol High creates the
   final immutable launch record.

Until then the exact disposition is:

```text
MEDIUM-SPEC-REQUIRED
LUNA launch: prohibited
Evidence promotion: none
```
