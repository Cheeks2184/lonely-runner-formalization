# Current project instructions

This is the project-only Astra workflow, established 2026-09-04. Its automatic
instruction entry point is `.codex/config.toml`; no `AGENTS.md`, global instruction
file, or unrelated project's settings are required or modified. Codex's effective
`config/read` resolved this project layer with Astra/high and the setup gate.
This confirms saved effective configuration; it neither switches nor independently
verifies the model or reasoning effort of an already running task.

The machine-readable policy is `research/workflow-policy.json`. The resumable
checkpoint is `research/workflow-state.json`. Read all three after context
compaction and at task startup, then run `python3 scripts/validate_workflow.py`.
The validator checks configuration and record consistency; it cannot establish
mathematical truth or enforce a platform's scheduler.

## Start gate and routing

Setup ends at `phase: ready`, `goal_status: not_started`, and null
`start_authorization`. That state authorizes setup maintenance only. Do not
research, start a goal, or schedule work until the user explicitly says to begin.
Record that instruction and its date before entering `research` / `in_progress`.

| Responsibility | Model | Effort | Execution |
| --- | --- | --- | --- |
| Orchestration, final integration | `gpt-6-astra` | `high` | Current session |
| Novel mathematics, difficult semantic reasoning, independent review | `gpt-6-astra` | `xhigh` | In-session subagent |
| Implementation from settled specifications and mechanical verification | `gpt-5.6-terra` | `medium` | In-session subagent |

Use `collaboration.spawn_agent` with explicit `model`, `reasoning_effort`, and
`fork_turns: "none"`. Supply the current policy, source checkpoint, precise target,
owned files, acceptance checks, and setup/research boundary in its prompt. The
`.codex/agents/` files mirror these defaults for compatible named-role runtimes.
They do not replace explicit routing in this session. Limit concurrency to the
smaller of the runtime allowance and four agents including the orchestrator.
If a requested model is unavailable, checkpoint the blocker; never silently use
another model. Research and review default to Astra/xhigh. A specific
user instruction may instead authorize Astra/high for one research or review
task only when its state record has a `routing_override` object recording
`source: user`, the matching Astra/high requested route, and the nonempty
instruction. The workflow validator checks that durable record; it does not
establish the authorization itself. Terra escalates unclear theorem contracts
to Astra.

The old Sol, browser Pro, and Luna procedure is retired. Browser model sessions,
external CLI model workers, and new user-visible tasks are not substitutes.
Web and existing integrations may still retrieve primary sources when needed;
this is distinct from asking a browser model to do research.

## Recovery and continuous work after authorization

Only the orchestrator writes `workflow-state.json`, with serialized updates using
a temporary sibling file followed by atomic replacement. Workers report findings
and write their owned evidence files; they do not edit shared state.

Before a delegation, save its target and requested routing in `active_tasks`.
Immediately after launch, add the returned ID. On completion, save its disposition,
checks, source checkpoint, evidence paths, and precise remaining gap in
`completed_tasks`, then remove the active entry. Do not invent observed runtime
metadata: use null when the runtime does not expose it. Runtime task IDs help
coordination but are not durable evidence by themselves.

Checkpoint material findings, failed branches, edits, verification, storage
cleanup, and the next executable action before compaction or interruption.
Maintain small local commits and exact reproducibility commands. Preserve full
hypotheses and proof dependencies for mathematical claims; distinguish a proposed
argument, independently reviewed manuscript proof, computation, and kernel proof.

Once started, use judgment on routine decisions and continue without renewed
confirmation. A failed branch or local experiment budget ends that branch only:
record why, reassess its value, and pursue another justified route. Partial
lemmas, finite searches, and unsuccessful attempts do not satisfy the objective.
Keep the user informed without requiring replies for routine work.

On 2026-09-05, the user granted standing authorization to recover from an
isolated subagent failure. Inspect the actual goal state whenever that failure
appears to have blocked the goal. Treat it as a failed task, preserve its output,
and retry its same requested role, model, and effort or reassign bounded work
within the routing table. Never mark the overall goal blocked solely because one
worker failed. If the actual goal is incorrectly blocked and the runtime exposes
a supported resume control, use it without renewed permission and read back the
status. If no such control exists, record that exact limitation and continue
other useful authorized work in the current turn. Do not fabricate a resume
control, mark the goal complete and recreate it, bypass a runtime limit, or
silently substitute a model or effort.

Platform time, context, quota, connectivity, and tool availability can interrupt
execution; project instructions cannot guarantee unlimited runtime or resolution
of an open problem. Persist a precise restart point when that happens. Never
mislabel a limit as a mathematical result. No scheduled run is installed during
setup, and no credits are purchased or redeemed without user authorization.

## Research transition after six total runners

On 2026-09-06 the user directed that the current approach may continue through
a working formalized theorem for N = 6 total runners. Establish the five-moving
closed 1/6 result and its canonical six-runner bridge, with full build, trust
audit and independent exact-scope review. Then focus research on a uniform
arbitrary-N mechanism for unrestricted LRC. Do not pursue N = 7, 8 and successive
individual counts as the roadmap. A finite-count lemma or experiment is useful
only when its role in a specific uniform mechanism is stated explicitly.
Six runners is a transition milestone and never satisfies the unrestricted
completion gate. This instruction governs future plans and delegations even
when older branch records mention higher-count targets.

## Completion gate

The objective is a full kernel-checked proof or disproof of the unrestricted
canonical `LonelyRunner.Conjecture`. A successful artifact must declare that type
or `Not LonelyRunner.Conjecture`; an alternative formulation also needs a checked
bridge to the canonical statement. Verify all runner counts, admissible speeds,
time domain, and the closed distance threshold. A refuted stronger auxiliary
claim is not a disproof of LRC.

Require an independent Astra/xhigh semantic review and a fresh source build with
the pinned Lean/mathlib versions, source trust scan, theorem axiom audit, and
appropriate regression checks. Permit only `propext`, `Classical.choice`, and
`Quot.sound`; no `sorry`, `admit`, custom axioms, weakened theorem, or unchecked
computational shortcut. Record exact declaration, source revision, proof artifact,
commands, outcomes, axiom output, and independent review before marking complete.
A state-file record or passing workflow validator alone cannot authorize promotion.

## Takeover checkpoint and historical material

Baseline: `166dbb2b817bf8d4d1fbb505858e770017e9ea35`. The takeover audit verified the
existing full Lean build, trust checks, 191 deterministic Python tests, and public
release audit. It installed missing local dependencies. This is baseline evidence,
not a new proof and not a claim that all historical research proposals are sound.
The small local audit bundle is at
`/home/joshua/Documents/Codex/audits/lonely-runner-2026-09-04/`.

The old `research/task-ledger.json` is a frozen historical snapshot, bound by its
SHA-256 in the new policy. Its old routing and apparently active browser cells
must not become a live queue. Historical prompts, task board rows, and promotion
registries retain their original provenance. Current operating rules come from
this workflow; mathematical claims still require their original evidence.

Two inherited holds must survive compaction. Prompt104's purported weakening
collapses to the previously rejected Prompt95 condition under accepted density:
for c owners and o outside labels, N+1<3c and c+o<=N-2 conflict with the
cosingleton expansion requirement 2(c-1)<=o. The prior audit contains the details.
Prompt105's proposed mass condition has a manuscript equivalence to ordinary
witness existence, not a completed Lean formalization. Reassess these contracts
before reuse after research is authorized; do not launch them blindly. The
existing formalization and exact certificate infrastructure remain useful, while
these inherited route proposals do not establish progress toward full LRC.

## Storage and verification

Follow `docs/storage-policy.md`. Retain the pinned toolchain installed. Keep one shared dependency/build cache
only while needed. At an idle checkpoint, retain small reproducibility evidence,
run `python3 scripts/manage_storage.py`, and then its explicit `--clean` operation.
Never clean concurrently with any build, verifier, or search. Preserve source,
Git history, unique certificates, dirty dependency sources, and other projects.
Rebuild ignored dependencies from the pinned manifest only when needed.

For setup-only edits run the focused workflow and storage tests plus the existing
ledger checks; do not regenerate gigabytes of Lean output for documentation.
A real source change still requires checks appropriate to that change. Local
setup files and checkpoints are authorized. Checkpoint publication follows the
standing authorization below; unrelated operations require their own authorization.

## Checkpoint publication

On 2026-09-05 the user instructed: “From now on, each time you save and verify a
new checkpoint, commit, push, open a PR, then merge it to main.” This is standing
authorization for this repository, `Cheeks2184/lonely-runner-formalization`.
After each verified checkpoint, complete those steps in that order without
requesting renewed approval. Use a `codex/` branch and target `main`.

Stage only the verified checkpoint and its documentation. Preserve unfinished
worker files and unrelated changes. Confirm appropriate local verification,
inspect required PR checks and reviews, resolve failures, and merge the exact
reviewed head SHA. Never bypass branch protections or force-push. Prefer a merge
commit when permitted so individual checkpoint commits remain traceable. Fetch
and verify that remote main contains the checkpoint, then record the PR URL,
head SHA, merge SHA, and checks in the durable state. If publication fails,
record the precise failure and next action; do not report delivery prematurely.

A receipt-only state update may accompany the next substantive checkpoint,
avoiding an endless sequence of PRs recording their own merge. This publishing
authorization does not lift the setup start gate or authorize unrelated external
actions. The unrestricted mathematical completion gate remains unchanged.
