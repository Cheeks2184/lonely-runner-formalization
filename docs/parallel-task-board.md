# Parallel task board

This file is the authoritative coordination record for proof-research work
based on commit `88c88789f5a503ad24adf54949fb330e88a70f35`. It records task routing and
integration readiness; it does not promote any mathematical claim.

## Operating rules

- Initial lane maxima are 4 active Sol Pro cells, 3 Sol Medium leads, and 6
  Luna workers. These are separate limits, not one shared worker cap.
- Platform collaboration slots are a separate runtime constraint. Top-level
  CLI Luna workers run as external processes: they are not nested agents and
  do not consume a nested collaboration slot.
- Only the supervising top-level lead `/root` may promote a deliverable to
  `verified`, integrate it, merge it, or change a mathematical status label.
- A rejected audit is useful evidence but is not an accepted implementation.
- Workers must stay within their allowed-file cells. Overlap requires an
  explicit handoff from the supervising lead.
- Runtime routing evidence and repository evidence are labeled separately.
- Inherited workers must not be called “Luna.” Luna labels apply only where
  top-level CLI route/model metadata has been runtime-verified below.
- Authoritative route metadata comes from the top-level CLI session/thread
  record or direct UI state, not a worker's prose self-description. Access
  mode is recorded from the honored runtime session, not merely the requested
  task mode.

Status values are `planned`, `queued`, `active`, `running`, `waiting`,
`blocked`, `rejected`, `review`, `verified`, and `integrated`.

## Current metrics

| Metric | Value | Counting rule |
| --- | ---: | --- |
| Accepted audit deliverables | 5 | `RO-AUDIT-001`, `LUNA-ROUTE-001`, `VL-AUDIT-001`, `FL-AUDIT-001`, and `VL-LUNA-DPLP-001` were accepted as audit evidence. |
| Accepted negative audits | 4 | The Luna routing audit and three DPLP contract audits returned valid negative results. |
| Accepted recovery deliverables | 1 | `SOL-R59-RECOVER-001` recovered and normalized Response59 without promoting its claims. |
| Accepted implementations | 0 unrestricted; 1 conditional formal artifact | The corrected DPLP contract/wrapper is reviewed in isolation and pending main integration; it proves neither DPLP nor induction. |
| Active Sol Pro cells | 4 / 4 | Prompt60 PRO-E, Prompt61 PRO-A, Prompt62 PRO-B, and Prompt63 PRO-C are running in four genuinely separate conversations. |
| Queued Sol Pro cells | 0 | No additional Sol Pro cell may start until an active slot is released. |
| Active Sol Medium leads | 3 / 3 | Research Operations, Verification, and Formalization are the initial lead lanes. |
| Active Luna workers | 1 / 6 | The independent Response59 verification audit is active; the formal Luna artifact has completed review. |
| Duplicated work | 0 unplanned; 1 deliberate replication | Prompt60 PRO-E intentionally overlaps the active clean-room Response59 audit to reduce correlated error. |
| Failed delegations | 2 | The nested Luna spawn was rejected; the first formal workspace-write launch was downgraded to read-only and terminated. |
| Merge conflicts | 0 | No task on this board has been merged. |
| Integration backlog | 3 | Main integration of the corrected formal contract, DPLP selector/correlation work, and the pending-tranche integration decision remain unresolved. |
| Wait time | Not recorded | Prompt60--63, the independent Response59 audit, and formal-contract integration are pending, but trustworthy start timestamps are not present in this repository snapshot. Do not invent elapsed time. |

Metrics are updated only from a worker result accepted by the supervising
lead. A sound negative audit counts as an accepted audit deliverable, but not
as an accepted implementation or mathematical proof.

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
  routing evidence accepted by `/root`. The top-level CLI fallback is
  runtime-verified and used by the recorded Luna tasks below. Inherited
  workers are not Luna and must not be labeled as such.

### VL-AUDIT-001 — pending DPLP tranche verification

- **ID:** `VL-AUDIT-001`
- **Lane:** verification
- **Owner / supervising lead:** Verification Lead / `/root`
- **Base:** `88c88789f5a503ad24adf54949fb330e88a70f35`
- **Dependencies:** pending DPLP proof/computation tranche
- **Branch:** none; read-only audit
- **Status:** `verified`
- **Exact deliverable:** Verify that the pending DPLP tranche matches its
  declared contract, including proof boundary, computation evidence, hashes,
  and status labels.
- **Allowed files:** none; read-only
- **Acceptance command:** `git status --short && git diff --check`
- **Blocker:** Contract mismatch. Raw deletion-pivot lifting is false at the
  exact tuple `(1,3,4,7)`: every deletion has a certificate, but no deletion
  certificate lifts. This tuple has no speed divisible by `N=5`, so it is
  outside the corrected DPLP contract and instead takes the direct `1/5`
  witness branch. The pending tranche is blocked until it states and tests
  the corrected contract consistently.
- **Final disposition / promotion authority:** Audit accepted; audited DPLP
  tranche `REJECTED/BLOCKED`. Only `/root` may reopen or promote it after
  repair and a fresh audit. The obstruction is not an LRC counterexample and
  no DPLP claim is promoted.

### FL-AUDIT-001 — formal DPLP audit

- **ID:** `FL-AUDIT-001`
- **Lane:** Lean formalization
- **Owner / supervising lead:** Formalization Lead / `/root`
- **Base:** `88c88789f5a503ad24adf54949fb330e88a70f35`
- **Dependencies:** pending DPLP Lean module and declared theorem contract
- **Branch:** none; completed read-only audit of the pending tranche
- **Status:** `verified`
- **Exact deliverable:** Audit declaration semantics, quantifier order,
  closed-boundary arithmetic, imports, prohibited placeholders, full build,
  and axiom output without editing the main worktree.
- **Allowed files:** none; read-only
- **Acceptance command:** `lake env lean LonelyRunner/DeletionPivotLifting.lean && lake build && lake env lean LonelyRunner/AxiomAudit.lean`
- **Blocker:** The formal declarations may verify the sound implication from
  a selected exceptional-good certificate, but they do not repair the tranche
  contract. The unrestricted raw selector is obstructed by `(1,3,4,7)` and
  the corrected contract requires the `N`-divisible premise and its separate
  direct branch.
- **Final disposition / promotion authority:** Audit accepted as a negative
  result; audited DPLP tranche `REJECTED/BLOCKED`. Only `/root` may approve a
  corrected declaration contract after repair and re-audit. The open DPLP
  selector is not promoted.

### SOL-P59-001 — Prompt59 research turn

- **ID:** `SOL-P59-001`
- **Lane:** external research
- **Owner / supervising lead:** `/root`
- **Base:** prompt composed from the pending DPLP/roadmap snapshot based on
  `88c88789f5a503ad24adf54949fb330e88a70f35`
- **Dependencies:** Response58 audit and the stated DPLP evidence snapshot
- **Branch:** none; external conversation
- **Status:** `verified`
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
- **Blocker:** Research generation is complete, but the independent Response59
  audit remains active. Completion of a Sol turn does not verify its claims.
- **Final disposition / promotion authority:** Submission and completion
  evidence accepted; the response was handed to `SOL-R59-RECOVER-001` and
  `VL-R59-AUDIT-001`. No returned theorem is promoted without independent
  mathematical, computational, and Lean verification as applicable.

### SOL-R59-RECOVER-001 — Response59 recovery

- **ID:** `SOL-R59-RECOVER-001`
- **Lane:** response recovery
- **Owner / supervising lead:** `/root`
- **Base:** external/main pending tranche associated with
  `88c88789f5a503ad24adf54949fb330e88a70f35`
- **Dependencies:** completed `SOL-P59-001`
- **Branch:** none; external/main pending tranche
- **Status:** `verified`
- **Exact deliverable:** Recover and normalize Response59, preserve its source
  attachment when available, and distinguish recovered material from
  independently audited evidence.
- **Allowed files:** recovery artifacts in the external/main pending tranche;
  no ops-branch implementation files
- **Acceptance command:** Verify normalized Response59 SHA-256
  `03265212ef51006bd200efe8f37b0afeeb64a572f9e80c57fb57f1c17459e5f4`
  and recovered source SHA-256
  `406b64139de1f7be51e3f42c750feb2a7e095d58865e82d6bdd76ab76a264e30`.
- **Blocker:** The claimed expected-output attachment was unavailable. It must
  not be described as recovered or reproduced.
- **Final disposition / promotion authority:** Recovery accepted by `/root`;
  response claims remain unverified and are assigned to
  `VL-R59-AUDIT-001`.

### VL-R59-AUDIT-001 — independent Response59 audit

- **ID:** `VL-R59-AUDIT-001`
- **Lane:** Luna verification
- **Owner / supervising lead:** Luna/xhigh worker / Verification Lead and
  `/root`
- **Base:** verification fixture
  `64319f1c4f46e1ace1d152cef6b65c6331f60ce5`
- **Dependencies:** `SOL-R59-RECOVER-001`, `LUNA-ROUTE-001`
- **Branch:** `verify/response59-audit-001`
- **Status:** `active`
- **Exact deliverable:** Independently audit Response59's D1--D6, P1/P2,
  counterexamples, attachment claims, formal-status statements, and first-gap
  conclusions without promoting recovered prose.
- **Allowed files:** none; read-only verification fixture
- **Acceptance command:** Verify the fixture base and authoritative top-level
  CLI thread `019fc66f-818b-7790-b71e-a5ca2780e72b`, then run the
  task-prescribed clean-room checks and return exact evidence.
- **Blocker:** The independent Luna/xhigh/read-only audit is active. Its final
  result has not returned and must not be inferred.
- **Final disposition / promotion authority:** Pending Verification Lead and
  `/root` review. Thread metadata verifies routing only, not any Response59
  mathematical or computational claim.

### SOL-P60-PRO-E-001 — independent Prompt60 review

- **ID:** `SOL-P60-PRO-E-001`
- **Lane:** external research / PRO-E deliberate replication
- **Owner / supervising lead:** `/root`
- **Base:** Prompt60 file commit
  `241472cd655e818b5e1bdfa546daadf5b783aed2`
- **Dependencies:** `SOL-R59-RECOVER-001`, Prompt60 package audit
- **Branch:** none; genuinely new external ChatGPT conversation
- **Status:** `active`
- **Exact deliverable:** Independently replicate and adversarially audit
  Response59's DPLP and prime-forcing work under Prompt60's clean-room
  contract.
- **Allowed files:** none while the external turn is running; recovery requires
  a separately assigned task
- **Acceptance command:** Verify GPT-5.6 Sol and Pro radios are both true;
  match the terminal-LF-excluded composer payload at 12,878 characters,
  12,882 UTF-8 bytes, 358 line feeds, and SHA-256
  `97c19d8810dd56a093f7b9260a72f5321470bbdc6f53b7881fce0f0d234172e2`;
  match file SHA-256
  `58fe909e504c7c7b2e6b351498ace28498a3037c5dfaf052888935c3728efc65`;
  confirm live `Stop answering`.
- **Blocker:** The external turn is active. No Response60 result exists yet.
- **Final disposition / promotion authority:** Submission evidence accepted;
  `/root` owns browser execution and eventual recovery. No result or claim is
  promoted.

### SOL-P61-PRO-A-001 — height-compression contract

- **ID:** `SOL-P61-PRO-A-001`
- **Lane:** Sol Pro / PRO-A height compression
- **Owner / supervising lead:** unassigned new-chat worker / `/root`
- **Base:** prompt-package base
  `fcf082781091f8e59ca43d498a4c37f8723ec599`
- **Dependencies:** verified bounded-height endpoint and corrected current
  status ledger
- **Branch:** none; genuinely new external ChatGPT conversation, with the
  prompt artifact sourced from `ops/parallel-task-board-001`
- **Status:** `active`
- **Exact deliverable:** Attack only
  `MinimalCounterexampleHeightCompression` by replacement/descent operations
  whose conclusion is the coefficient-three height bound. Do not enter direct
  pivot coverage or deletion induction.
- **Allowed files:** none while the external turn is active; recovery requires
  a separately assigned task
- **Acceptance command:** Verify UIA reports GPT-5.6 Sol true and Pro true;
  verify file SHA-256
  `d337fc56508ef92c820371cc7e9d2b2091171283b884c982868b2c690931118b`;
  match the terminal-LF-excluded composer payload at 7,039 characters, 7,047
  UTF-8 bytes, 172 line feeds, and SHA-256
  `be2abad7d2f0e9a9bcc0187bba9c4c30d7125bd36a02a8de187ca630b3763eed`;
  confirm exact composer readback and live `Stop answering`.
- **Blocker:** The external turn is active. No PRO-A result exists yet.
- **Final disposition / promotion authority:** Submission evidence accepted;
  `/root` owns recovery and may accept or promote only an independently
  audited result.

### SOL-P62-PRO-B-001 — uniform-pivot contract

- **ID:** `SOL-P62-PRO-B-001`
- **Lane:** Sol Pro / PRO-B pivot coverage
- **Owner / supervising lead:** unassigned new-chat worker / `/root`
- **Base:** prompt-package base
  `fcf082781091f8e59ca43d498a4c37f8723ec599`
- **Dependencies:** verified pivot-certificate equivalence, exact CRT counts,
  and corrected current status ledger
- **Branch:** none; genuinely new external ChatGPT conversation, with the
  prompt artifact sourced from `ops/parallel-task-board-001`
- **Status:** `active`
- **Exact deliverable:** Attack only unrestricted all-pivot coverage,
  TOP-TWO-PIVOT, and `TOP-TWO-INTEGRAL-TRANSVERSAL` through integral
  CRT/Fourier/transversal methods. Do not enter height descent or deletion
  induction.
- **Allowed files:** none while the external turn is active; recovery requires
  a separately assigned task
- **Acceptance command:** Verify UIA reports GPT-5.6 Sol true and Pro true;
  verify file SHA-256
  `c33ce233418ae356c0d9a41b35f47bf73598f6012803680a6b710a27cf3ba3e3`;
  match the terminal-LF-excluded payload at 7,640 characters, 7,644 UTF-8
  bytes, 186 line feeds, and SHA-256
  `687a774640d4b56b402a2ca2bb8a3c7b84c64b67a04dd5388ad9ee3bb39b875c`;
  confirm the post-send Copy message is exact after CRLF-to-LF normalization
  and confirm live `Stop answering`.
- **Blocker:** The external turn is active. No PRO-B result exists yet.
- **Final disposition / promotion authority:** Submission evidence accepted;
  `/root` owns recovery and may accept or promote only an independently
  audited result.

### SOL-P63-PRO-C-001 — deletion-induction contract

- **ID:** `SOL-P63-PRO-C-001`
- **Lane:** Sol Pro / PRO-C deletion and induction
- **Owner / supervising lead:** unassigned new-chat worker / `/root`
- **Base:** prompt-package base
  `fcf082781091f8e59ca43d498a4c37f8723ec599`
- **Dependencies:** reviewed isolated corrected DPLP contract/conditional
  wrapper pending main integration; selected-certificate lift is proved-Lean;
  D4/D5 and repaired D6 are independently accepted proved-math
- **Branch:** none; genuinely new external ChatGPT conversation, with the
  prompt artifact sourced from `ops/parallel-task-board-001`
- **Status:** `active`
- **Exact deliverable:** Attack only corrected deletion-certificate
  correlation, reverse witness lifting, descent, and induction, with the full
  D6 no-full-witness and nonempty-`K_k` hypotheses. Do not enter height-only
  descent or direct pivot/top-two coverage.
- **Allowed files:** none while the external turn is active; recovery requires
  a separately assigned task
- **Acceptance command:** Verify UIA reports GPT-5.6 Sol true and Pro true;
  verify file SHA-256
  `88a879a0489cbacf0707edd366527301e34f2c2763f7ed53d53529a8c7a487cb`;
  match the terminal-LF-excluded payload at 10,717 characters, 10,723 UTF-8
  bytes, 266 line feeds, and SHA-256
  `8a6714a63d55d155f06cdc433b4b3e19fff100a4a30640fa6a79fa11b3a3ddd7`;
  confirm exact composer readback, exact normalized post-send copy, and live
  `Stop answering`.
- **Blocker:** The external turn is active. No PRO-C result exists yet.
- **Final disposition / promotion authority:** Submission evidence accepted;
  `/root` owns recovery and may accept or promote only an independently
  audited result.

### DPLP-REPAIR-001 — contract repair

- **ID:** `DPLP-REPAIR-001`
- **Lane:** proof-contract repair
- **Owner / supervising lead:** unassigned / `/root`
- **Base:** a fresh branch from
  `88c88789f5a503ad24adf54949fb330e88a70f35`, with only explicitly selected
  pending-tranche inputs
- **Dependencies:** accepted negative results from `VL-AUDIT-001`,
  `FL-AUDIT-001`, and `VL-LUNA-DPLP-001`; reviewed corrected conditional
  artifact from `FL-LUNA-DPLP-001`
- **Branch:** to be allocated by `/root`; one isolated worktree
- **Status:** `queued`
- **Exact deliverable:** Build selector/correlation work on the corrected
  formal contract, preserve the sound-lift/open-selector boundary, and return
  a minimal independently verified diff plus replay evidence.
- **Allowed files:** must be declared by `/root` before launch; no overlap with
  the active Prompt60 turn or this board
- **Acceptance command:** `git diff --check && lake env lean LonelyRunner/DeletionPivotLifting.lean && lake build && lake env lean LonelyRunner/AxiomAudit.lean`
- **Blocker:** The corrected formal artifact remains outside main, and an
  exact selector/correlation file-cell assignment is pending.
- **Final disposition / promotion authority:** Queued. It requires a fresh
  Verification Lead audit; `/root` alone may promote or integrate it.

### VL-LUNA-DPLP-001 — Luna verification audit

- **ID:** `VL-LUNA-DPLP-001`
- **Lane:** Luna verification
- **Owner / supervising lead:** Luna/xhigh worker / Verification Lead and
  `/root`
- **Base:** verification fixture
  `9f1fd836a823e9be2c4a9935f94d19585ff93960`
- **Dependencies:** `LUNA-ROUTE-001`, `VL-AUDIT-001`
- **Branch:** `verify/luna-dplp-contract-001`
- **Status:** `verified`
- **Exact deliverable:** Independently audit the DPLP fixture contract and
  return exact evidence for every accepted or rejected claim. The session is
  Luna with xhigh reasoning and is read-only.
- **Allowed files:** none; read-only verification fixture
- **Acceptance command:** Verify `git rev-parse HEAD` equals the fixture base,
  run the task-prescribed read-only checks, and return sanitized model/route
  metadata plus exact findings to the Verification Lead.
- **Blocker:** The first returned audit required lead corrections. After those
  corrections, the audit confirms the DPLP contract mismatch and reports 31
  certificate failures in the fixture. It produced no file changes.
- **Final disposition / promotion authority:** Accepted negative audit after
  Verification Lead corrections; audited implementation remains rejected.
  The 31 fixture failures do not prove or refute corrected DPLP or LRC. Only
  `/root` may authorize repair or promotion.

### FL-LUNA-DPLP-001 — Luna formal audit

- **ID:** `FL-LUNA-DPLP-001`
- **Lane:** Luna formalization
- **Owner / supervising lead:** Luna/xhigh worker / Formalization Lead and
  `/root`
- **Base:** formal fixture
  `cd908c8ea148f2e46e19d1e8754497e729bd2716`
- **Dependencies:** `LUNA-ROUTE-001`, `FL-AUDIT-001`
- **Branch:** `formal/luna-dplp-contract-001`
- **Status:** `verified`
- **Exact deliverable:** Independently audit or repair the formal DPLP fixture
  under the exact task contract while preserving the sound-lift/open-selector
  boundary. The session is Luna with xhigh reasoning.
- **Allowed files:** only the isolated formal fixture worktree authorized by
  its task contract; no main-worktree or board changes
- **Acceptance command:** Verify `git rev-parse HEAD` equals the fixture base,
  run the task-prescribed Lean and contract checks, and return sanitized
  model/route metadata plus exact findings to the Formalization Lead.
- **Blocker:** The first workspace-write launch was downgraded to read-only
  and terminated. A fresh `danger-full-access` top-level CLI session was
  runtime-honored and isolated and produced commit
  `e5a353397008e0d2fcbbb6213972b952055c4dbf`. Review accepts its corrected
  DPLP contract and conditional wrapper; main integration remains pending.
- **Final disposition / promotion authority:** Reviewed conditional formal
  artifact accepted by the Formalization Lead. It records the structural
  premises and consumes the DPLP selector but proves neither DPLP nor
  induction. `/root` alone may integrate it into main.

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
- **Blocker:** The accepted `VL-AUDIT-001` audit rejected the current tranche
  contract; repair and fresh verification have not occurred.
- **Final disposition / promotion authority:** Blocked. Only `/root` may
  integrate or merge after every dependency is accepted.

## Integration order

1. Preserve the accepted negative `VL-AUDIT-001`, `FL-AUDIT-001`, and
   `VL-LUNA-DPLP-001` results; their audited tranche remains rejected and
   blocked.
2. Preserve the reviewed `FL-LUNA-DPLP-001` conditional artifact without
   promoting DPLP, and wait for the active `VL-R59-AUDIT-001` result.
3. Specify and execute `DPLP-REPAIR-001` in an isolated branch using only
   accepted findings.
4. Re-run a fresh verification audit; an accepted negative audit cannot be
   silently converted into implementation acceptance.
5. Keep recovered Response59 separate from its active independent audit, and
   keep the active Prompt60 PRO-E turn separate from both. Do not claim a
   Response60 result before one exists and is recovered.
6. Re-evaluate `PRO-E-INTEGRATE-001` only after all gates are explicit.
7. Launch any additional Luna/xhigh work only through the verified top-level
   CLI route; external CLI processes are not nested agents, and nested Luna
   delegation must not be retried.

## Manual field-audit checklist

Every worker row above contains: ID; lane; owner and supervising lead; base;
dependencies; branch; status; exact deliverable; allowed files; acceptance
command; blocker; and final disposition or promotion authority. Missing or
ambiguous fields block integration rather than receiving inferred values.
