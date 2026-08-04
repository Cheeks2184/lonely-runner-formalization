# Admission decision

**REVIEW-REQUIRED**

The theorem, finite definitions, and conditional LRC implication chain are internally coherent. The contract should not yet be hash-locked or launched. Several specification gaps could produce materially different Pro responses or permit an invalid cross-pivot exchange.

| Component                                       | Review status                                                      |
| ----------------------------------------------- | ------------------------------------------------------------------ |
| Modular definitions and strict boundary         | Accepted                                                           |
| Definition and uniqueness of (j_\star)          | Accepted                                                           |
| Universal redundancy formulation                | Accepted after adding the no-internal-cover equivalent form        |
| Minimal-cover equivalence                       | Correct by finite deletion                                         |
| Conditional implication to integer and real LRC | Correct at the stated evidence boundary                            |
| Three preflight rows and frozen tuple counts    | Internally reproduced, review-only, not evidence                   |
| Attack A                                        | Sufficiently specified after centered-representative clarification |
| Attack B                                        | Blocking underspecification                                        |
| Attack C                                        | Sufficiently specified                                             |
| Mandatory falsification suite                   | Blocking underfreezing                                             |
| Artifact and hashing protocol                   | Blocking ambiguity                                                 |
| `STOP` versus `OPEN` protocol                   | Internally inconsistent                                            |
| Anti-tautology claims                           | One unsupported strictness claim must be weakened                  |
| Launch status                                   | Not ready                                                          |

## Blocking corrections

### 1. Attack B permits an inadmissible pivot owner

A minimal cover (D_i) at pivot (i) may contain (j_\star). That label cannot be inserted into a cover at pivot (j_\star). The current instruction to replace (i) using “owner data from the pivot-(i) cover” leaves this case unresolved and could let a response silently use the pivot as its own owner.

Insert the following immediately after choosing the pivot-(i) cover:

```text
Write D_i for the selected inclusion-minimal complete cover at pivot i.
The only admissible proposed replacement at pivot j_star is

  E_i = (C \ {i}) union (D_i \ {j_star}).

The label j_star is never an admissible owner at its own pivot. If
j_star belongs to D_i, its coverage contribution at pivot i may not be
carried into E_i by identity, deletion, or an unstated transport. The proof
must either discharge that contribution through an explicit residue map with
proved fibers and strict boundaries, or declare the exchange unsupported.

No key decrease may be claimed until E_i is proved to cover R_j_star.
```

This is the most important mathematical correction.

### 2. `STOP` and `OPEN` are assigned inconsistently

The research-contract stop condition includes “failure to produce a noncircular cross-pivot step,” while the disposition rules say unsupported transitions require `OPEN`. These are different outcomes.

Replace the procedural stop language with:

```text
A procedural stop only ends further searching in the current turn. It does
not by itself determine the final disposition.

Return STOP only if:
1. an exact counterexample to the sole target is independently reproduced; or
2. a proved structural reduction shows that the first remaining obligation is
   exactly Prompt72 circuit escape, unrestricted positive-integer LRC, or an
   equivalent theorem.

Return OPEN when the attacks merely terminate at unsupported arrows, failed
candidate maps, missing fiber control, or an unproved arithmetic lemma.
```

Delete “failure to produce a noncircular cross-pivot step” from the list of conditions that can independently produce `STOP`.

### 3. The mandatory suite is not fully frozen

Several tests leave the tuple, owner, permutation, malformed representation, or deliberately false expectation to the implementer. That prevents deterministic replay.

Freeze them as follows:

```text
5. For (1,3,4,5), n=4, N=5, pivot speed 3, and owner speed 1:
   - r=2 has rho_15(2*1)=2<3 and is bad;
   - r=3 has rho_15(3*1)=3 and is safe against that owner.
   Other owners must still be evaluated separately.

7. Singleton-cover rigidity:
   - true fixture: (1,3,4), pivot speed 1, owner speed 4.
     Since N*pivot=4 divides 4, that labelled owner singleton-covers R_1.
   - false fixture: (1,3,4), pivot speed 1, owner speed 3.
     Since 4 does not divide 3, the singleton cover assertion must fail.

8. Scaling and permutation:
   - base tuple: (1,6,11,12,13);
   - scale factor: 5;
   - permutation of original positions: (4,0,3,1,2), producing
     (13,1,12,6,11) before scaling.
   Compare all results by speed label. The covered-speed set must remain
   {1,6}, and the distinguished covered speed must remain 6.

10. Malformed and negative controls:
   - zero speed: (0,1,2), expected NONPOSITIVE_SPEED;
   - repeated speed: (1,1,2), expected NONINJECTIVE_SPEED;
   - pivot in owner set: (1,3,13), pivot index 1, proposed owner set {0,1},
     expected PIVOT_OWNER_FORBIDDEN;
   - omitted residue: delete the least element of the literal R_j for
     (1,3,13) at pivot speed 3, expected RESIDUE_DOMAIN_MISMATCH;
   - deduplicated equal sets: at the same pivot, replace the two labelled
     owners 1 and 13 by one unlabelled bad set, expected OWNER_LABEL_MISMATCH;
   - altered expected cover: for (6,7,12,24,144) at pivot speed 7, declare
     {6,12} complete, expected EXPECTED_COVER_FAILURE.
```

The cyclic-side, zero-target, antipode, nonunit, and gcd-degenerate tests also need explicit tuple/residue records in the verifier manifest, even if they are discovered from the already frozen fixtures.

### 4. Executed verification and pseudocode are currently conflated

The contract permits “transparent exact pseudocode and check,” but later requires full-domain completion and artifact hashes. Pseudocode cannot establish that the (12{,}142)-tuple domain completed.

Replace that clause with:

```text
The full mandatory suite and frozen domain must be executed by a deterministic
verifier. Pseudocode may accompany the verifier but cannot substitute for an
execution artifact.

The response must supply:
- the verifier source;
- a machine-readable manifest;
- a machine-readable result file;
- SHA-256 hashes of all three;
- interpreter or compiler version;
- process exit status;
- tuple and pivot ordering;
- total completed tuple count;
- first_failure=null when no failure occurs.

An independent audit is assigned after response recovery and is not claimed by
the originating Pro turn.
```

### 5. Hash scope for the prompt itself is undefined

`base_commit` is provenance, not a prompt-content hash. Add front-matter fields with a nonrecursive hash scope:

```text
prompt_encoding: UTF-8
prompt_line_endings: LF
prompt_hash_scope: bytes from the line "# Prompt 90:" through EOF
prompt_sha256: TO-BE-FILLED-AFTER-FINAL-REVIEW
```

The hash must be computed only after all review edits are applied. Do not include the front-matter hash field itself in the hash scope.

For attachments, specify SHA-256 over exact file bytes, not normalized text.

### 6. Ordering and serialization need completion

The tuple order is frozen, but pivot order, residue order, and failure serialization are not.

Add:

```text
Deterministic ordering:
- tuples: increasing n, then lexicographic increasing speed tuple;
- pivots: increasing pivot speed;
- residues: canonical representatives 0,...,N*p-1 in increasing order;
- owners: increasing owner speed, retaining labels even when bad sets coincide;
- owner subsets: cardinality first, then lexicographic increasing speed list;
- private candidates: least residue representative when a deterministic
  witness is required;
- failures: the first record in the preceding total order.

The machine-readable first-failure record must contain:
n, tuple, pivot_index, pivot_speed, N, M, residue, owner_indices,
owner_speeds, expected, observed, and failure_code.
```

Full bad-set and cover listings should be stored in the artifact. Section 5 of the response should report hashes, totals, summaries, and the first failure rather than printing every set inline.

### 7. Evidence-label vocabulary is not frozen

“One exact evidence label per claim” is not deterministic without an allowed vocabulary. Add:

```text
Allowed status labels are exactly:

input-accepted
proved-lean
proved-math-qualified
proved-math-response
computed-finite
refuted-exact
conditional
open
not-run
out-of-scope

`proved-math-response` remains response-authored until independent audit.
`computed-finite` never promotes an unrestricted statement.
```

Use the project’s established alternative spelling instead if a repository-wide vocabulary already exists, but the prompt must name that vocabulary or hash the file defining it.

## Mathematical clarifications

### Add the third equivalent form

The universal redundancy statement is finite-descent equivalent to the absence of any internal complete cover. State this explicitly:

```text
Equivalent no-internal-cover form:

  There is no C subset F(a) \ {j_star} such that
  R_j_star = union_(i in C) B_i^j_star.

Indeed, repeated use of one-owner redundancy would otherwise reach the empty
cover, which is impossible because |R_j_star|>0.
```

This prevents a response from proving only that one selected cover is nonminimal.

### Make the centered congruence unique

In Attack A, replace the unrestricted notation for (e_i) with:

```text
For each private candidate r_i, let e_i be the unique integer in

  {-(p-1), ..., -1, 0, 1, ..., p-1}

and q_i the unique integer such that

  r_i*a_i = q_i*N*p + e_i.

Uniqueness follows because strict badness gives |e_i|<p and N>=3.
```

This removes ambiguity at cyclic representatives and ensures that (e_i=0) and both signs are handled literally.

### Weaken the unsupported strictness claim

The abstract circuit fixture proves that abstract circuit escape does not imply internal-cover redundancy. It does not prove that the arithmetic target is strictly stronger than, or inequivalent to, unrestricted LRC.

Replace:

```text
The target is logically stronger than bare pivot-certificate existence...
Its universal proof would be a genuine bridge, not a new encoding...
```

with:

```text
The target implies bare pivot-certificate existence through the displayed
conditional chain. No converse or strict logical separation from LRC is
assumed. If the arithmetic target is shown equivalent to Prompt72 circuit
escape or unrestricted LRC, that is a valid structural STOP.
```

This aligns the anti-tautology discussion with the stop rules.

## Frozen prior-route audit

The references to Prompts 69, 70, 72, 76, 78, and 86 are adequate as warnings but not as exact audit inputs. Either attach hash-identified frozen statements for those routes or narrow the required audit to the descriptions included in Prompt 90.

Recommended replacement:

```text
The duplication audit is against only:
1. the exact route signatures stated in this prompt; and
2. any separately listed attachment whose SHA-256 is frozen below.

Do not claim an exact implication to or from an earlier prompt whose operative
statement is not included here or supplied through a frozen attachment.
```

This prevents browser memory or an unfrozen repository version from becoming an unstated premise.

## Review-only diagnostics

A local, non-promoted review calculation reproduced:

* the declared primitive tuple counts (127,997,2919,4311,2996,792);
* no internal minimal cover in the stated (12{,}142)-tuple admission domain;
* the three displayed fastest-covered-pivot rows and their listed minimal covers.

Additional unretained exploratory ranges also produced no counterexample. None of these calculations has a frozen artifact, independent replay, or evidentiary status. They must not appear in the launched prompt as evidence or as an enlarged frozen domain.

## Final disposition

Keep:

```text
admission: REVIEW-REQUIRED
```

Apply the blocking corrections, canonicalize the final bytes, compute the prompt SHA-256 over the declared scope, and only then change the admission field to `LAUNCH-READY`.
