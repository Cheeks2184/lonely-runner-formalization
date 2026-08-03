# Parallel task board

This file is the authoritative coordination record for proof-research work
based on commit `88c88789f5a503ad24adf54949fb330e88a70f35`. It records task routing and
integration readiness; it does not promote any mathematical claim.

## Operating rules

- At most four workers may be active or running at once. Additional work is
  queued.
- Only the supervising top-level lead `/root` may promote a deliverable to
  `verified`, integrate it, merge it, or change a mathematical status label.
- A rejected audit is useful evidence but is not an accepted implementation.
- Workers must stay within their allowed-file cells. Overlap requires an
  explicit handoff from the supervising lead.
- Runtime routing evidence and repository evidence are labeled separately.
- Inherited workers must not be called “Luna.” The only supported Luna claim
  is the runtime-verified routing result recorded below.

Status values are `planned`, `queued`, `active`, `running`, `waiting`,
`blocked`, `rejected`, `review`, `verified`, and `integrated`.

## Current metrics

| Metric | Value | Counting rule |
| --- | ---: | --- |
| Accepted deliverables | 2 | `RO-AUDIT-001` and `LUNA-ROUTE-001` were accepted as read-only operational evidence. |
| Duplicated work | 0 | No two live cells have the same deliverable or allowed-file set. |
| Failed delegations | 1 | The nested Luna spawn attempt was rejected at runtime. |
| Merge conflicts | 0 | No task on this board has been merged. |
| Integration backlog | 2 | The DPLP contract repair and current pending-tranche integration decision remain unresolved. |
| Wait time | Not recorded | Prompt59 is running, but no trustworthy start timestamp is present in the repository snapshot. Do not invent elapsed time. |

Metrics are updated only from a worker result accepted by the supervising
lead. Negative audit results increase neither “accepted deliverables” nor
mathematical proof counts unless the board explicitly says otherwise.

## Worker register

### RO-AUDIT-001 — pending-work and roadmap audit

- **ID:** `RO-AUDIT-001`
- **Lane:** research operations
- **Owner / supervising lead:** Research-Operations Lead / `/root`
- **Base:** `88c88789f5a503ad24adf54949fb330e88a70f35`
- **Dependencies:** none
- **Branch:** none; read-only audit of the main worktree
- **Status:** `verified`
- **Exact deliverable:** Inventory the pending 21-path tranche, define
  dependency-safe PRO-A through PRO-E cells, audit Prompt59 evidence, and
  report blockers without editing, merging, or promoting claims.
- **Allowed files:** none; read-only
- **Acceptance command:** `git status --short && git diff --check`
- **Blocker:** none
- **Final disposition / promotion authority:** Accepted as operational
  evidence by `/root`; it does not promote DPLP, Prompt59, or unrestricted
  Lonely Runner claims.

### LUNA-ROUTE-001 — Luna routing audit

- **ID:** `LUNA-ROUTE-001`
- **Lane:** runtime routing
- **Owner / supervising lead:** Research-Operations Lead / `/root`
- **Base:** runtime session associated with
  `88c88789f5a503ad24adf54949fb330e88a70f35`
- **Dependencies:** none
- **Branch:** none; read-only runtime probe
- **Status:** `verified`
- **Exact deliverable:** Determine whether a nested worker can directly spawn
  a Luna worker and identify a safe fallback route.
- **Allowed files:** none
- **Acceptance command:** Inspect the orchestrator result for the rejected
  nested spawn and retain its exact runtime disposition; no repository command
  can reproduce an orchestrator routing decision.
- **Blocker:** Nested Luna spawning was rejected at runtime.
- **Final disposition / promotion authority:** Runtime-verified negative
  routing evidence accepted by `/root`. The supported fallback is a future
  top-level CLI launch supervised by `/root`; inherited workers are not Luna
  and must not be labeled as such.

### VL-AUDIT-001 — pending DPLP tranche verification

- **ID:** `VL-AUDIT-001`
- **Lane:** verification
- **Owner / supervising lead:** Verification Lead / `/root`
- **Base:** `88c88789f5a503ad24adf54949fb330e88a70f35`
- **Dependencies:** pending DPLP proof/computation tranche
- **Branch:** none; read-only audit
- **Status:** `rejected`
- **Exact deliverable:** Verify that the pending DPLP tranche matches its
  declared contract, including proof boundary, computation evidence, hashes,
  and status labels.
- **Allowed files:** none; read-only
- **Acceptance command:** `git status --short && git diff --check`
- **Blocker:** Contract mismatch. The pending tranche is rejected and blocked
  from integration until a dedicated repair cell resolves the mismatch and a
  fresh verification audit accepts it.
- **Final disposition / promotion authority:** `REJECTED/BLOCKED`; only
  `/root` may reopen or promote it after repair and re-audit. No DPLP claim is
  promoted.

### FL-AUDIT-001 — formal DPLP audit

- **ID:** `FL-AUDIT-001`
- **Lane:** Lean formalization
- **Owner / supervising lead:** Formalization Lead / `/root`
- **Base:** `88c88789f5a503ad24adf54949fb330e88a70f35`
- **Dependencies:** pending DPLP Lean module and declared theorem contract
- **Branch:** none; active read-only audit of the pending tranche
- **Status:** `active`
- **Exact deliverable:** Audit declaration semantics, quantifier order,
  closed-boundary arithmetic, imports, prohibited placeholders, full build,
  and axiom output without editing the main worktree.
- **Allowed files:** none; read-only
- **Acceptance command:** `lake env lean LonelyRunner/DeletionPivotLifting.lean && lake build && lake env lean LonelyRunner/AxiomAudit.lean`
- **Blocker:** Awaiting the Formalization Lead’s final result; VL-AUDIT-001’s
  contract rejection independently blocks integration.
- **Final disposition / promotion authority:** Pending `/root` review. A
  successful compiler audit may verify only the sound lifting declarations;
  it cannot promote the open DPLP selector.

### SOL-P59-001 — Prompt59 research turn

- **ID:** `SOL-P59-001`
- **Lane:** external research
- **Owner / supervising lead:** `/root`
- **Base:** prompt composed from the pending DPLP/roadmap snapshot based on
  `88c88789f5a503ad24adf54949fb330e88a70f35`
- **Dependencies:** Response58 audit and the stated DPLP evidence snapshot
- **Branch:** none; external conversation
- **Status:** `running`
- **Exact deliverable:** Return an adversarial DPLP and prime-forcing
  comparison under Prompt59’s proof, counterexample, ranking, and stop/continue
  contracts.
- **Allowed files:** none while running; recovered artifacts require a new
  isolated task
- **Acceptance command:** Match the submitted composer payload after removing
  the tracked file’s terminal newline: 7,706 characters, 7,710 UTF-8 bytes,
  206 line feeds, SHA-256
  `0ff913739a2a7d0f6c9270f64bcb65e0e15267e73b7c16ab49f9a260165c476f`;
  confirm the live `Stop answering` control.
- **Blocker:** Response is still running. The repository session log has not
  yet been synchronized with the runtime-confirmed submission.
- **Final disposition / promotion authority:** Running only. `/root` may
  accept a recovered response for audit; no returned theorem is promoted
  without independent mathematical, computational, and Lean verification as
  applicable.

### DPLP-REPAIR-001 — contract repair

- **ID:** `DPLP-REPAIR-001`
- **Lane:** proof-contract repair
- **Owner / supervising lead:** unassigned / `/root`
- **Base:** a fresh branch from
  `88c88789f5a503ad24adf54949fb330e88a70f35`, with only explicitly selected
  pending-tranche inputs
- **Dependencies:** `VL-AUDIT-001`, final `FL-AUDIT-001` report
- **Branch:** to be allocated by `/root`; one isolated worktree
- **Status:** `queued`
- **Exact deliverable:** Resolve the exact DPLP contract mismatch identified
  by verification, preserve the sound-lift/open-selector boundary, and return
  a minimal repair diff plus replay evidence.
- **Allowed files:** must be declared by `/root` before launch; no overlap with
  the running Prompt59 or this board
- **Acceptance command:** `git diff --check && lake env lean LonelyRunner/DeletionPivotLifting.lean && lake build && lake env lean LonelyRunner/AxiomAudit.lean`
- **Blocker:** The Formalization Lead’s final finding and an exact repair
  file-cell assignment are pending.
- **Final disposition / promotion authority:** Queued. It requires a fresh
  Verification Lead audit; `/root` alone may promote or integrate it.

### LUNA-XHIGH-001 — top-level Luna worker mechanism

- **ID:** `LUNA-XHIGH-001`
- **Lane:** runtime routing
- **Owner / supervising lead:** unassigned top-level operator / `/root`
- **Base:** new isolated worktree at a commit selected explicitly by `/root`
- **Dependencies:** `LUNA-ROUTE-001`, exact task contract, available top-level
  concurrency slot
- **Branch:** unique branch to be assigned before launch
- **Status:** `planned`
- **Exact deliverable:** Launch one isolated Luna xhigh worker through the
  top-level CLI fallback, capture the route/model evidence and worker result,
  and avoid any nested spawn path.
- **Allowed files:** task-specific isolated cell declared before launch
- **Acceptance command:** The exact top-level CLI invocation must be recorded
  by `/root` after live CLI capability discovery, together with exit status
  and sanitized route/model evidence. No unverified command is prescribed by
  this board.
- **Blocker:** Top-level CLI model alias, invocation syntax, task branch, and
  concurrency slot must be verified live. Nested delegation is known to fail.
- **Final disposition / promotion authority:** Planned only. `/root` may
  authorize the top-level launch and accept its result. Inherited workers
  remain inherited workers, not Luna.

### PRO-E-INTEGRATE-001 — pending-tranche integration decision

- **ID:** `PRO-E-INTEGRATE-001`
- **Lane:** integration
- **Owner / supervising lead:** `/root`
- **Base:** `88c88789f5a503ad24adf54949fb330e88a70f35`
- **Dependencies:** accepted `FL-AUDIT-001`, repaired and accepted
  `DPLP-REPAIR-001`, synchronized Prompt59 submission record, final whole-tree
  verification
- **Branch:** integration branch to be selected by `/root`
- **Status:** `blocked`
- **Exact deliverable:** Decide whether the corrected, independently verified
  pending tranche is coherent and ready for integration without status
  overstatement or unrelated changes.
- **Allowed files:** only the repaired tranche explicitly approved by `/root`
- **Acceptance command:** `git status --short && git diff --check && lake build && python3 -m unittest discover -s tests -v`
- **Blocker:** `VL-AUDIT-001` rejected the current contract; repair and fresh
  verification have not occurred.
- **Final disposition / promotion authority:** Blocked. Only `/root` may
  integrate or merge after every dependency is accepted.

## Integration order

1. Finish `FL-AUDIT-001` without changing the pending tranche.
2. Specify and execute `DPLP-REPAIR-001` in an isolated branch.
3. Re-run a fresh verification audit; the rejected VL result cannot be
   silently converted to acceptance.
4. Synchronize the runtime-confirmed Prompt59 submission in its owning
   documentation cell. Response completion and response audit remain a
   separate future tranche.
5. Re-evaluate `PRO-E-INTEGRATE-001` only after all gates are explicit.
6. Launch `LUNA-XHIGH-001` only from the top level and only after live CLI
   discovery; do not retry nested Luna delegation.

## Manual field-audit checklist

Every worker row above contains: ID; lane; owner and supervising lead; base;
dependencies; branch; status; exact deliverable; allowed files; acceptance
command; blocker; and final disposition or promotion authority. Missing or
ambiguous fields block integration rather than receiving inferred values.
