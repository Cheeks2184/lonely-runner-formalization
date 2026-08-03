# Prompt65 preflight and verifier stop audit

Status date: 2026-08-03.

## Disposition

Prompt65 C1 is **STOP / OPEN**. The reviewed work produced a specification and
an execution contract, followed by three rejected or stopped verifier
implementations. It produced no accepted computation, theorem, counterexample,
Lean result, axiom result, or finite-evidence promotion.

No complete 1,397-row scan was accepted or completed. The read-only fixture
remained clean at base
`80e8cee4bb31bf99733c2687e4674bfdafe03889`. Authoritative runtime metadata
confirmed Luna/xhigh routing for the top-level verifier work. Private runtime
locations and session identifiers are intentionally omitted.

## Reviewed task dispositions

| Task | Reviewed disposition | Exact boundary |
| --- | --- | --- |
| `VER-P65-PREFLIGHT-027` | conditional-ready contract only | The proposed execution contract could govern a future implementation, but supplied no implementation or evidence. |
| `FORM-P65-SPEC-028` | **SPEC-ONLY / OPEN** | It preserved the exact first-blocker transfer target and exposed missing definitions; it did not prove the target or supply the missing Lean API. |
| `VER-P65-FALSIFY-028` | **REJECTED** | Pass/hit semantics were inverted, and tied-global-minimum aggregation allowed one passing minimum to mask a failing one. The obsolete process was stopped. Its partial outputs are not evidence. |
| `VER-P65-CODE-AUDIT-030` | accepted negative source audit | Beyond the inversion and masking defects, the audit found that component-reconstruction failures were not uniformly fatal, strict edge validation was incomplete, premise-failure vacuity and counters were not truthful, the C++ path did not implement the full transfer/reindex theorem scan independently, and artifact/driver binding was insufficient to establish fresh frozen results. |
| `VER-P65-REPAIR-030` | **REJECTED** | The repair corrected the Python pass/failure inversion and tied-minimum aggregation, but did not satisfy the complete verifier contract. |
| `VER-P65-REPAIR-REVIEW-032` | accepted negative repair review | The C++ program was micro-only/non-independent and did not implement first blockers, transfer conclusions, or real reindex parity. The repair also retained defects in fatal component diagnostics, complete validator coverage, vacuity, explicit counters, freeze-manifest binding, stale-output prevention, the required unit matrix, and frozen Python/C++ full-run drivers. Its matching micro output did not exercise a transfer row. |
| `VER-P65-REPAIR-033` | **STOP / REJECT** | A deterministic search capped at the first 500 primitive increasing tuples in the required ordering twice reported no actual interior-`tau` transfer microcase. The contract required an immediate stop without enlarging the cap. Because no independent verifier or frozen compliant source existed, this is unverified operational output, not computed finite evidence and not a mathematical no-case result. |

Rejected implementation hashes, where retained elsewhere, are provenance only.
They do not bind accepted source or output and are not reproduced here.

## Exact mathematical boundary

For every non-full edge tied at the global minimum, the target remains the
existential conclusion

```text
exists successor e', deletedIndex(e') = h_e and Delta(e') <= tau_e.
```

Every tied non-full global minimum must be evaluated separately. Any failed
existential is a hit; all tested transfers must pass for a passing row; and all
global minima must be full for the full-endpoint disposition. Equality at
`Delta=tau` passes. A failure attached only to a nonminimum source does not
count, while every successor edge deleting the selected blocker remains a
candidate.

The unsupported implication chain must not be shortened or replaced:

```text
N*a_h crossing -> M_h -> active n*a_j -> successor edge -> Delta<=tau.
```

`ReverseGrid.lean` verifies local arithmetic under explicit
`ReverseGridData` hypotheses. The current Lean API does not define:

- the deletion feasible sets `K_k`;
- the maximizer sets `M_k`;
- complete oriented active-edge enumeration, including all ties;
- the realization predicate connecting arithmetic data to an edge;
- the `Delta`, `gamma`, and first-blocker structures required by the target.

Consequently the local reverse-grid identities do not establish the crossing,
maximizer, successor-edge, or `Delta<=tau` steps.

## Evidence and non-evidence

The following tracked research inputs were verified at the clean base and are
authoritative provenance for the contract:

| Tracked input | SHA-256 |
| --- | --- |
| `research/sol-pro/prompts/prompt65.md` | `e1197121c37f9623752f6370583de5a537853e658bed73badd58b033b4701afb` |
| `docs/response63-audit.md` | `4c4da5762bff0ec3daa6656ef35c2a044d58021c001a270fd78af0e7debd42e4` |
| `research/sol-pro/responses/response63.md` | `b3db11b42448d3b92d3d9522fdac89128a46ca7de32cca19b033ac202242e134` |
| `docs/prompt64-luna-audit.md` | `aada974f508b6bdd405aed09f3dd2ee10ef124484040d29aa32d2a4f1028ab55` |

These hashes bind tracked source documents only. They do not validate any
rejected verifier, scanner output, or theorem claim.

The following are explicitly not promoted:

- partial or stale scanner output;
- the rejected verifier implementations or their manifests;
- the capped first-500 operational no-case report;
- a full-domain result, because no accepted complete 1,397-row scan exists;
- any theorem, counterexample, Lean declaration, axiom conclusion, or uniform
  implication.

## Stop and restart rule

Further verifier implementation is frozen. Reopen C1 implementation only if
at least one of the following occurs:

1. a real nonvacuous exact transfer case is supplied independently of the
   rejected scanners;
2. a direct mathematical proof or refutation changes the research boundary;
3. an independently reviewed new contract resolves the implementation and
   evidence defects above.

`SOL-P65-PRO-C-001` remains waiting for the required external signed-in
ChatGPT Sol Pro execution. Browser/ChatGPT control is unavailable in the
current runtime. The tracked prompt is a contract only; waiting does not
promote or reopen the verifier work.

Recommended evidence label:
**reviewed preflight/negative implementation audit; C1 STOP / OPEN; no
computed or formal promotion**.
