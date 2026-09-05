# Astra setup completion

Ready, with mathematical work explicitly **not started**. This setup follows the
2026-09-04 takeover audit of `166dbb2b817bf8d4d1fbb505858e770017e9ea35`.
No Lean source or dependency pin was changed, and no project files were moved.

The project instruction layer is `.codex/config.toml`, supported by
`docs/project-workflow.md`, role defaults in `.codex/agents/`, and the policy and
state files in `research/`. No `AGENTS.md` or global instruction settings were
created or modified. Effective Codex configuration readback confirmed Astra/high
and these instructions in this project, and their absence in the home-directory
configuration. Saved settings do not independently verify an active task's model.

Astra High orchestrates; in-session Astra Extra High handles novel or difficult
semantic work and independent review; in-session Terra Medium handles settled
implementation and mechanical verification. The setup itself used two Terra
Medium workers and an independent Astra Extra High reviewer. Requested routing
and completed setup receipts are retained in `research/workflow-state.json`;
unexposed observed model metadata remains null.

The old Sol/browser Pro/Luna routing is superseded. Historical prompts and ledger
remain intact, with hash validation, and their active-looking rows are explicitly
historical. Prompt104/105 audit holds persist without initiating new research.
The existing formal library and exact verification tools remain valuable; the
inherited final research contracts require reassessment after start authorization.

Recovery instructions require a single orchestrator writer, atomic state updates,
compact evidence, exact task contracts, honest failure records, and next actions.
A failed branch does not end the future full goal. Completion requires the actual
canonical kernel-checked proof/disproof, appropriate trust checks, and independent
semantic review. Runtime limits cannot be eliminated by project instructions.
No goal, recurring run, browser-model session, or external model worker was started.

Validation:

- 47 focused tests passed: 16 storage, 12 current workflow, 19 historical ledger.
- Current workflow validation and the preserved historical ledger validation passed.
- Effective project configuration and project isolation were checked through
  Codex's read-only `config/read` endpoint.
- All three independent review findings were addressed: serialized shared-state
  writes, retained toolchain, and configuration/runtime evidence distinction.
- Real cache preflight confirmed clean manifest-pinned dependencies with no
  unbacked local branch commits. Cleanup first refused ambiguous processes;
  narrowly scoped read-only inspections resolved those cases before deletion.
- Removed 7,667,820,701 bytes of project cache and 439,158,169 bytes in the exact
  8,639 downloaded mathlib archives produced by the audit: **8.11 GB** total.
  Temporary API schemas were also removed. Unique evidence, source, project Git,
  unrelated caches, and the installed pinned Lean toolchain were preserved.
- Added explicit Node installation to CI and documented local prerequisites and
  the Elan PATH requirement. No full Lean build was repeated for setup-only edits;
  the prior baseline audit already passed the full build, trust audit, and all
  191 existing deterministic tests. New CI changes have not run remotely.

All work is local. No remote publication was performed. The next transition is
the user's explicit instruction to begin; readiness itself is not authorization.
