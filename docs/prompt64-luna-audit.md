# Prompt64 Luna verification audit

This record classifies the Prompt64 verification attempt as **INCOMPLETE**.
It is an operations and evidence-boundary record, not a theorem, computation,
or finite-sweep promotion.

## Routing and repository boundary

The public/base commit for this attempt is
`51de33bad6ba251747cd5c37db8e6425e3cb6425`. The formal source checkpoint
remains `586b4858cd1b1c513566f3b33d7b5141640e7865`, as already documented.

Persisted `turn_context` authoritatively verified the fresh top-level worker
routing as Luna/xhigh with approvals `never` and sandbox
`danger-full-access` in an isolated read-only verification worktree. The
private local path, branch attribution, and session identifier are
intentionally omitted from this public record. This is runtime routing
evidence only; it is not mathematical or finite-evidence endorsement.

## Attempt status

| Item | Status | Evidence boundary |
| --- | --- | --- |
| `OPS-P64-CONTRACT-018` | integrated operations contract | The Prompt64 contract is distinct from external execution; the required signed-in ChatGPT Sol Pro conversation has never run. |
| `VER-P64-FALSIFY-022` | **INCOMPLETE / rejected as evidence** | The generated domain omitted mandatory named fixtures `(2,3)` equality and `(1,2,8)` strict. The PI stopped the scans and rejected partial outputs. |
| `VER-P64-REPAIR-023` | **INCOMPLETE / rejected as evidence** | A repaired domain and partial scanner work reached the stop boundary, but frozen full coverage and provenance validation did not complete. |
| `TOP-TWO-LARGE-RATIO-EXCLUSION` | `open` | No theorem, counterexample, or `NO-COUNTEREXAMPLE` finite conclusion was accepted. |
| `TOP-TWO-INTEGRAL-TRANSVERSAL` and owner-transversal | `open` | Downstream branches remain open and were not entered or promoted. |
| Lean / axiom result | none | No Lean prototype, new declaration, or axiom result arose from this attempt. |

The Prompt64 finite sweep is frozen at its turn cap. Larger bounds are not a
recommended continuation. Resume this route only for a new mathematical
implication, an exact counterexample, or a contract-faithful verifier restart
justified by the PI.

## `VER-P64-FALSIFY-022`: initial failure

The generated strict/equality domain omitted two mandatory named fixtures:

- `(2,3)` in the equality branch;
- `(1,2,8)` in the strict branch.

The PI deliberately stopped the scans after this contract failure. Partial
outputs are rejected as evidence. This attempt therefore cannot establish a
counterexample, cannot establish `NO-COUNTEREXAMPLE`, and cannot support a
finite theorem or a theorem-status change.

## `VER-P64-REPAIR-023`: repaired but incomplete

The repair regenerated a 24,708-row domain with the following recorded
counts:

| Quantity | Count |
| --- | ---: |
| Primary strict rows | 20,764 |
| Primary equality controls | 1,366 |
| Total strict rows | 23,301 |
| Total equality rows | 1,367 |
| Residual provenance/control rows | 40 |
| Named fixtures `(2,3)` equality and `(1,2,8)` strict | exactly once each |

Thus `23,301 + 1,367 + 40 = 24,708`; the residual rows are provenance/
control rows, not strict theorem instances.

The `domain.tsv` hash before the later provenance defect was discovered was
`16c9d13fe367edfaceb746224f6b53fa9ce92317013e14eb6190b67c46ca2a11`.
This hash and the corresponding domain are historical provenance only: they
are **not accepted and not frozen-final evidence**.

Both implementations confirmed the two named implementation checks:

| Implementation | A-grid safe count | B-grid safe count | First B-grid safe numerator |
| --- | ---: | ---: | ---: |
| literal / primary | 0 | 6 | 9 |
| optimized / independent | 0 | 6 | 9 |

Independent byte-identical scanner shards covered a contiguous prefix through
input row 19,750. That prefix is not promotable: frozen full coverage did not
complete, and later validation found a provenance bookkeeping defect.

## Exact verifier defects at the stop

The following defects remain unresolved and are part of the incomplete result:

1. Strict-only failure semantics were branch-blind in both the literal and
   optimized scanners.
2. Optimized completion was non-atomic and could report `complete=true` after
   an early stop.
3. The third verifier retained the same equality-calibration issue.
4. Genuine reindexing was absent.
5. Scaling lacked independent optimized/verifier agreement.
6. Structured-CRT provenance recorded the post-normalization q-multiple
   condition over the entire tuple rather than only the designated
   lower/source coordinates.

Regenerating in place after results had been produced would violate the
freeze. The PI therefore stopped the turn rather than rewriting the tracked
provenance or treating a repaired-in-place output as final.

## Mathematical disposition and ledger

The exact Prompt64 target remains:

```text
For n>=2, N=n+1, positive injective speeds, and numerical top indices jA,jB
with A=speeds[jA] < B=speeds[jB],

  N*A < 2*B -> TopCert(speeds,jA) or TopCert(speeds,jB).
```

The strict branch was not verified to completion. The equality side belongs
to the residual branch. No counterexample was accepted, and no
`NO-COUNTEREXAMPLE` conclusion was accepted. `TOP-TWO-LARGE-RATIO-EXCLUSION`
therefore remains `open`; the owner-transversal and unrestricted LRC targets
also remain `open`.

The result labels are preserved strictly:

- the formal ReverseGrid arithmetic at checkpoint `586b485` remains
  `proved-lean` under its explicit `ReverseGridData` hypotheses;
- the response63 paper lemmas retain only their exact `proved-math`,
  `conditional`, `computed`, `rejected`, or `open` boundaries;
- this Prompt64 attempt is incomplete and rejected as evidence;
- no theorem, finite-evidence, Lean, axiom, or unrestricted-LRC status is
  promoted by this record.

## Current lifecycle disposition

Prompt64 is prepared/parked and Prompt65 is prepared/parked/frozen; neither
was launched at the current checkpoint. Both remain solely owned by the Sol
High top-level desktop orchestrator under `/root`. Earlier browser-control
limitations in this audit describe only the exact Luna worker runtime and are
not top-level desktop blockers. Prompt66 is the active first-ranked cell. No
response or result is inferred from these operational states.
