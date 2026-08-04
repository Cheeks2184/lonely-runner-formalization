# Response95 fail-closed recovery audit

Task: `OPS-P95-RECOVERY-PACKAGE-310`

Base: `5db949acb0866ab9b67543b889b6d2d73447afc8`

Recovered response: `research/sol-pro/responses/response95.md`, SHA-256
`77586d4231f044a7b9253b26565c7aa78887cba41c48cf11fee4e01de803558c`.

Raw decoded response: SHA-256
`093f68c9c2d9175bf9772d7da2053aa8f2ef3a48fb68311f366c52b699532eb8`.

## Recovery disposition: `PIVOT` self-label preserved, no promotion

Response95 self-disposes as `PIVOT`, while explicitly leaving
`MAX-COVERED-PIVOT-INTERNAL-COVER-REDUNDANCY` open. It proposes an
unrestricted lower-owner skeleton and reports a bounded zero-failure run.
This Level-1 package preserves those statements as
**RESPONSE-AUTHORED / UNVERIFIED** only.

The response's `PIVOT` word is a self-label, not an accepted project status.
No theorem, successor bridge, finite evidence, counterexample, or LRC status
is promoted by recovery. The only accepted evidence label for this package is
`recovery-provenance`.

## Rapid claim table

| Response95 claim | Recovery classification | Required next evidence |
| --- | --- | --- |
| Redundancy, minimal-cover, and no-internal-cover forms are equivalent | **RESPONSE-AUTHORED / UNVERIFIED** | Independent finite-set proof audit, including nonempty candidate set and repeated deletion |
| Exact common-scaling and permutation laws preserve rows, covers, minimality, privacy, `F`, and `j_star` | **RESPONSE-AUTHORED / UNVERIFIED** | Independent inverse-image and relabelling proofs at every strict boundary |
| Private residues admit a unique signed-error normal form | **RESPONSE-AUTHORED / UNVERIFIED** | Independent endpoint, quotient-bound, zero-error, and omitted-owner audit |
| Reduction modulo a lower pivot is candidate-preserving with the displayed fibers and lift formula | **RESPONSE-AUTHORED / UNVERIFIED** | Independent modular proof and exact scope audit |
| A stress tuple refutes naive small-pivot-to-large-pivot badness transport | response-authored countercalculation; **UNVERIFIED** | Independent literal reproduction; it is not a theorem-domain refutation of the maximum-pivot statement |
| Exact gcd-sensitive bad-set cardinality formula | **RESPONSE-AUTHORED / UNVERIFIED in this response** | Map against the existing Lean exact bad-set theorem and audit algebraic equivalence before claiming novelty |
| Common two-residue overlap gives a cover-capacity inequality and cover-size/`F` lower bounds | **RESPONSE-AUTHORED / UNVERIFIED** | Independent union-bound and integer-rounding proof |
| The `tp`, `tp+1`, and `tp-1` slices impose simultaneous modular constraints | **RESPONSE-AUTHORED / UNVERIFIED** | Independent strict-interval calculation with every candidate guard |
| `MAXIMUM-PIVOT-LOWER-OWNER-SKELETON` strictly narrows the internal-cover edge | response `PIVOT` proposal; **UNVERIFIED / NOT PROMOTED** | Audit novelty, exact eliminated subcases, and whether the restrictions materially shorten the unrestricted route |
| `PRIVATE-LIFT-COVERAGE` is the first open cross-pivot edge | response-authored route diagnosis; **UNVERIFIED** | Verify exact sufficiency chain; an additional descent or exchange lemma may still be required |
| Frozen run completed 12,142 tuples and 59,996 pivots with no theorem failure | **UNVERIFIED / QUARANTINED** | Source safety audit, frozen inventory, deterministic replay, independent clean-room implementation, and source/output binding |
| Sole max-covered-pivot redundancy theorem | `open`; response self-status preserved | A complete proof or exact theorem-domain counterexample |
| Conditional implication from the sole theorem to integer and real LRC | `conditional`; response reasoning unverified | Audit the implication against accepted Lean interfaces only after the antecedent is established |
| Unrestricted LRC | `open`; unaffected | A separate complete kernel-checked proof or independently verified disproof |

Terms such as `proved-math-response` and `computed finite evidence` inside the
response are response-authored classifications. Recovery does not adopt them.

## Provisional logical cautions

The response's exact bad-set formula appears to restate the already accepted
Lean theorem `card_pivotBadResidues_exact` using the elementary equivalence
between ceiling and floor forms. Independent review must separate existing
formal content from genuinely new consequences.

`PRIVATE-LIFT-COVERAGE` is at most a first open edge. Its conclusion says a
replacement set covers the large row; it does not by itself delete an owner
from the original internal minimal cover. The response reports no decreasing
cardinality, maximum-speed, sum, or lexicographic key. A separate descent,
termination, or exchange-back lemma therefore appears necessary.

The literal transport example refutes the displayed naive lift implication.
It does not prove uniqueness of the projection, refute every possible
cross-modulus identity, or address the maximum-covered-pivot hypothesis.

Cover-dependent capacity and slice failures eliminate the proposed cover.
They prove a tuple-level subcase only after every allowed internal cover has
been eliminated. No finite zero-failure statement changes these boundaries.

## Attachment quarantine and identity boundary

Three files are preserved byte-for-byte under
`research/sol-pro/artifacts/prompt95/quarantine/`:

| File | Bytes | SHA-256 |
| --- | ---: | --- |
| `prompt95_literal_verifier.py` | 24,203 | `2c1228c059b26b76f804bc3d55b1ca143344d1685c0c799f24707e10620082ff` |
| `prompt95_manifest.json` | 1,397 | `e1d4a00dec974926fcaa421e2ee10ef13871427b7a47895a74dd65e2c8c1f9ae` |
| `prompt95_result.json` | 138,577 | `71c9c47d9869ee4f25ae5ab792797624cd993d330741c1098636d55b2767eb34` |

Every measured whole-file hash exactly matches the corresponding hash printed
in the response. This establishes identity only. None of the attachments was
opened, read, parsed, imported, or executed. No schema, field, fixture,
completion marker, source/output binding, deterministic order, result, or
source safety property was checked.

The privacy, secret, credential, email, and host-path scan covers the tracked
response and recovery-authored text. Attachment content is intentionally
excluded from content scanning because this task forbids reading or parsing
the quarantined files; only their public filenames, byte counts, and
whole-file hashes were checked. Any later release-content scan of those files
requires a separately authorized safety-review stage.

## Response normalization and public provenance

Sol High supplied one ignored base64 capture. Strict UTF-8 decoding produced
exactly 44,390 bytes and 44,385 characters with 1,679 CRLF endings, no lone LF
or CR, and a terminal CRLF. The tracked response changes CRLF to LF only and
contains 42,711 bytes, 42,706 characters, 1,679 LF endings, no CR, and a
terminal LF. Restoring CRLF reproduces the raw decoded bytes and SHA-256
exactly.

The ignored base64 capture, browser profile, private session identifiers, and
authentication state are not tracked. The public record contains only task,
launch, file-identity, and lifecycle facts.

## Verification boundary and next action

This is a Level-1 recovery package. It runs no Lean build, response verifier,
attachment parser, deterministic test, or full repository replay. No task
ledger, task board, status document, prompt, source module, or global
documentation is changed.

Recommended next action: independently audit the three-form equivalence,
lower-owner skeleton, slice constraints, and exact scope of the transport
obstruction. Before any attachment execution, a Sol Medium lead must freeze a
source-safety review and Luna-ready replay specification with immutable hashes,
mandatory fixtures, timeouts, deterministic outputs, and an independent
checker. Recovery alone supplies no computed finite evidence.

Level-1 checks are limited to response round-trip identity, attachment
whole-file identity, path/hash inventory, changed-text privacy and secret
scanning, `git diff --check`, and repository-shape validation.
