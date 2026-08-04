# P68 bounded-annihilator definitions: Luna Narrow contract

Task ID: `P68-BA-DEF-01`

Supervising Sol Medium lead: Formalization/Specification Lead

Purpose: Implement only the four frozen bounded-annihilator definitions and
four local boundary/computation lemmas below. This is a one-layer Lean
definitions task. It does not include the support theorem, Fourier analysis,
the hyperplane corollary, a root-module import, or any claim about unrestricted
Lonely Runner.

Current admission decision: **`MEDIUM-SPEC-REQUIRED`**. The original contract
commit `911e871f51bb09b7b8fb20c53891dda671c40e88` was rejected by independent
review because its inventory, worktree-provenance, and contract-delivery gates
were incomplete. This corrected contract may be promoted to `LUNA-READY` only
after independent contract re-review accepts its exact correction tip and Sol
High creates the mandatory immutable launch record specified below. Prompt or
contract preparation alone is not admission.

Base commit: `94442b430f4dbb9b66ec186e5655d556ee4e477e`

Branch/worktree:

- worker branch: `formal/luna-p68-ba-def-01`
- isolated worktree identifier: `isolated:luna-p68-ba-def-01`
- public-safe repository-root sibling mapping:
  `../lrc-luna-p68-ba-def-01`
- the worktree must be created fresh at the exact base commit above;
- the worker must not reuse or resume an existing Codex session or branch.

Worker runtime: a fresh top-level Codex session explicitly routed to
`gpt-5.6-luna` with reasoning effort `xhigh`. Effective model and effort must
be verified from authoritative runtime/session metadata. A nested child,
inherited Sol route, substitute model, or natural-language identity claim does
not satisfy this contract.

### Exact worktree creation and live containment readback

Sol High or its authorized operations helper must run the following from the
authoritative repository root before the worker starts:

```bash
test ! -e ../lrc-luna-p68-ba-def-01
test -z "$(git branch --list formal/luna-p68-ba-def-01)"
git worktree add -b formal/luna-p68-ba-def-01 \
  ../lrc-luna-p68-ba-def-01 \
  94442b430f4dbb9b66ec186e5655d556ee4e477e
```

From the new worktree, the launcher and worker must both run this exact live
readback. Resolved absolute paths are private runtime values: inspect them
locally, but do not persist or publish them.

```bash
worker_root="$(realpath .)"
common_git_dir="$(realpath "$(git rev-parse --git-common-dir)")"
controller_root="$(dirname "$common_git_dir")"
expected_worker_root="$(realpath "$controller_root/../lrc-luna-p68-ba-def-01")"
test "$worker_root" = "$expected_worker_root"
test "$(dirname "$worker_root")" = "$(dirname "$controller_root")"
test "$(basename "$worker_root")" = "lrc-luna-p68-ba-def-01"
test "$(git rev-parse HEAD)" = "94442b430f4dbb9b66ec186e5655d556ee4e477e"
test "$(git branch --show-current)" = "formal/luna-p68-ba-def-01"
git worktree list --porcelain | awk \
  -v wt="$worker_root" \
  -v head="94442b430f4dbb9b66ec186e5655d556ee4e477e" '
    $1 == "worktree" {
      in_target = ($0 == "worktree " wt)
      if (in_target) seen = 1
      next
    }
    in_target && $1 == "HEAD" {
      head_ok = ($2 == head)
      next
    }
    in_target && $1 == "branch" {
      branch_ok = ($2 == "refs/heads/formal/luna-p68-ba-def-01")
      next
    }
    END { exit !(seen && head_ok && branch_ok) }
  '
```

The public report records only `isolated:luna-p68-ba-def-01`, the relative
mapping `../lrc-luna-p68-ba-def-01`, and PASS/FAIL for these checks. It must not
record the resolved private paths.

### Immutable contract-delivery gate

This correction commit cannot contain its own final commit SHA or its own file
SHA-256. Therefore a separate Sol High launch record is mandatory before any
worker session starts. Its exact tracked path is:

```text
research/luna/launches/p68-ba-def-01.md
```

The launch record must be committed separately and must contain these exact
fields with final values:

```text
Task ID: P68-BA-DEF-01
Worker base: 94442b430f4dbb9b66ec186e5655d556ee4e477e
Contract commit: <40-hex correction tip containing this contract>
Contract path: research/luna/contracts/p68-ba-def-01.md
Contract SHA-256: <64-hex SHA-256 of the blob at Contract commit/Contract path>
Worker branch: formal/luna-p68-ba-def-01
Worktree mapping: ../lrc-luna-p68-ba-def-01
Runtime target: gpt-5.6-luna/xhigh fresh top-level Codex session
Sol High launch authority: approved
```

Sol High must supply the launch-record commit SHA as an external immutable
input. The worker must not infer, edit, or choose any field. Before reading the
implementation contract, it must run the following with
`launch_record_commit` set to that supplied 40-hex SHA:

```bash
launch_record_path='research/luna/launches/p68-ba-def-01.md'
contract_path='research/luna/contracts/p68-ba-def-01.md'
test "${#launch_record_commit}" -eq 40
case "$launch_record_commit" in *[!0-9a-f]*) exit 1 ;; esac
git cat-file -e "${launch_record_commit}^{commit}"
test "$(git rev-parse "${launch_record_commit}^{commit}")" = \
  "$launch_record_commit"
git cat-file -e "${launch_record_commit}:${launch_record_path}"
git show "${launch_record_commit}:${launch_record_path}"
```

It must extract the exact `Contract commit` and `Contract SHA-256` values from
that displayed record, reject duplicates through the single-value checks
below, and then run:

```bash
record_text="$(git show "${launch_record_commit}:${launch_record_path}")"
contract_commit="$(printf '%s\n' "$record_text" | \
  sed -n 's/^Contract commit: //p')"
contract_sha256="$(printf '%s\n' "$record_text" | \
  sed -n 's/^Contract SHA-256: //p')"
test "$(printf '%s\n' "$record_text" | sed -n 's/^Task ID: //p')" = \
  'P68-BA-DEF-01'
test "$(git show "${launch_record_commit}:${launch_record_path}" | \
  sed -n 's/^Worker base: //p')" = \
  '94442b430f4dbb9b66ec186e5655d556ee4e477e'
test "$(git show "${launch_record_commit}:${launch_record_path}" | \
  sed -n 's/^Contract path: //p')" = "$contract_path"
test "$(git show "${launch_record_commit}:${launch_record_path}" | \
  sed -n 's/^Worker branch: //p')" = 'formal/luna-p68-ba-def-01'
test "$(git show "${launch_record_commit}:${launch_record_path}" | \
  sed -n 's/^Worktree mapping: //p')" = '../lrc-luna-p68-ba-def-01'
test "$(git show "${launch_record_commit}:${launch_record_path}" | \
  sed -n 's/^Runtime target: //p')" = \
  'gpt-5.6-luna/xhigh fresh top-level Codex session'
test "$(git show "${launch_record_commit}:${launch_record_path}" | \
  sed -n 's/^Sol High launch authority: //p')" = 'approved'
test "${#contract_commit}" -eq 40
case "$contract_commit" in *[!0-9a-f]*) exit 1 ;; esac
test "${#contract_sha256}" -eq 64
case "$contract_sha256" in *[!0-9a-f]*) exit 1 ;; esac
test "$(git rev-parse "$contract_commit^{commit}")" = "$contract_commit"
test "$(git show "$contract_commit:$contract_path" | sha256sum | \
  cut -d' ' -f1)" = "$contract_sha256"
```

The extracted blob, not the worker base, is the immutable task contract. This
does not merge, cherry-pick, or otherwise change the worker base. The worker
must fail closed before implementation if the launch record is absent, any
field is duplicated or empty, either SHA is malformed, the contract commit or
path is unavailable, the hash differs, or Sol High approval is not exact.

Access mode: Read access to tracked repository sources and pinned dependencies;
write access only to the one allowed tracked file and the exact ignored
temporary locations listed below. No merge, push, task-board edit, status-label
promotion, dependency update, configuration edit, or browser operation is
authorized.

## Exact module contract

Allowed tracked file:

```text
LonelyRunner/BoundedAnnihilator.lean
```

It is a new file. No other tracked file may change.

The file must begin with exactly these imports and namespace openings, apart
from comments or whitespace:

```lean
import LonelyRunner.Formulations
import LonelyRunner.PivotResidues
import Mathlib.Data.Nat.Prime.Infinite
import Mathlib

namespace LonelyRunner

open scoped BigOperators
open Finset
```

It must end with `end LonelyRunner`.

### Exact definitions

The worker must implement these declarations without changing their names,
binders, types, bodies, factor order, or strict inequality:

```lean
/-- The canonical shorter distance from a nonzero-modulus residue to zero. -/
def zmodCyclicDistance {p : ℕ} [NeZero p] (x : ZMod p) : ℕ :=
  cyclicResidueDistance p x.val

/-- The exact audited Prompt68 coefficient bound. -/
def boundedAnnihilatorHeight (n : ℕ) : ℕ :=
  2 * n * 5 ^ (n - 1) * 4 ^ n + 1

/-- Every field point is strictly bad in at least one coordinate. -/
def IsStrictZModCover {n p : ℕ} [NeZero p]
    (N : ℕ) (b : Fin n → ZMod p) : Prop :=
  ∀ x : ZMod p, ∃ i : Fin n,
    N * zmodCyclicDistance (x * b i) < p

/-- A nonzero, pointwise bounded integer relation modulo `p`. -/
def IsBoundedZModAnnihilator {n p : ℕ}
    (H : ℕ) (b : Fin n → ZMod p) (c : Fin n → ℤ) : Prop :=
  c ≠ 0 ∧
  (∀ i, (c i).natAbs ≤ H) ∧
  ∑ i, (c i : ZMod p) * b i = 0
```

### Exact allowed lemmas

Only these four theorem declarations may be added. Their signatures are
frozen; the proof terms may use ordinary kernel-checked tactics.

```lean
@[simp] theorem zmodCyclicDistance_zero {p : ℕ} [NeZero p] :
    zmodCyclicDistance (0 : ZMod p) = 0

theorem zmodCyclicDistance_eq_min_val {p : ℕ} [NeZero p]
    (x : ZMod p) :
    zmodCyclicDistance x = min x.val (p - x.val)

@[simp] theorem boundedAnnihilatorHeight_three :
    boundedAnnihilatorHeight 3 = 9601

@[simp] theorem boundedAnnihilatorHeight_four :
    boundedAnnihilatorHeight 4 = 256001
```

No extra declaration is permitted except private/local proof auxiliaries that
do not escape the proof block. If an additional named declaration appears
necessary, stop and escalate rather than adding it.

## Canonical finite domains, boundaries, and ordering

- A tuple `Fin 3 → ZMod 5` is ordered by coordinate indices `0, 1, 2`.
- Field points are checked in representative order `x.val = 0, 1, 2, 3, 4`.
- When reporting a covering coordinate, choose the least coordinate index.
- Fixture results are reported in the numbered order 1 through 6 below.
- All logs are UTF-8 text with LF line endings. No timestamps, random values,
  unordered maps, parallel tests, or nondeterministic seeds are permitted.
- Strict badness is exactly `N * zmodCyclicDistance (x * b i) < p`.
  Equality is safe and must not be treated as bad.
- Repeated residues are permitted by `IsStrictZModCover`; a fixture with
  repeated residues is not malformed merely because it has collisions.
- `NeZero p` is part of the domain of `zmodCyclicDistance` and
  `IsStrictZModCover`. A zero modulus is a premise-violating input and must
  fail elaboration rather than receive an invented instance.

## Mandatory six-fixture preflight

The worker must create the temporary sources named below using `apply_patch`.
The positive source is:

```text
tmp/p68-ba-def-01/Preflight.lean
```

It imports `LonelyRunner.BoundedAnnihilator`, stays in namespace
`LonelyRunner`, and checks these exact propositions with ordinary `decide`,
`norm_num`, `simp`, or explicit finite case proofs. `native_decide` is
prohibited.

1. Known success: with
   `b = (![1, 3, 4] : Fin 3 → ZMod 5)`, prove
   `IsStrictZModCover 4 b`. The finite check must cover all points in the
   canonical order above. The expected least-witness table by `x.val` is
   `[(0,0), (1,0), (2,1), (3,1), (4,0)]`.
2. Known failure with collisions: with
   `b = (![1, 1, 1] : Fin 3 → ZMod 5)`, prove
   `¬ IsStrictZModCover 4 b`; also prove explicitly that at `x=2` every
   coordinate fails the strict inequality.
3. Distance successes: prove
   `zmodCyclicDistance (0 : ZMod 5) = 0` and
   `zmodCyclicDistance (2 : ZMod 5) = 2`.
4. Equality boundary: prove
   `5 * zmodCyclicDistance (1 : ZMod 5) = 5` and
   `¬ 5 * zmodCyclicDistance (1 : ZMod 5) < 5`.

The two negative sources are:

```text
tmp/p68-ba-def-01/ExpectedFailureZeroModulus.lean
tmp/p68-ba-def-01/ExpectedFailureWrongHeight.lean
```

5. Malformed/premise-violating modulus: the first imports the module and asks
   Lean to elaborate
   `#check zmodCyclicDistance (0 : ZMod 0)` without declaring a `NeZero 0`
   instance. Compilation must fail because the required instance is absent.
6. Deliberately altered expectation: the second imports the module and
   contains
   `example : boundedAnnihilatorHeight 3 = 9600 := by decide`.
   Compilation must fail. A success is a preflight failure.

No theorem-domain counterexample is claimed by fixtures 5 or 6.

## Allowed temporary outputs and cleanup

The only task-authored temporary paths are:

```text
tmp/p68-ba-def-01/Preflight.lean
tmp/p68-ba-def-01/ExpectedFailureZeroModulus.lean
tmp/p68-ba-def-01/ExpectedFailureWrongHeight.lean
tmp/p68-ba-def-01/AxiomProbe.lean
tmp/p68-ba-def-01/commands.log
```

Lake may write its normal ignored cache beneath `.lake/`. No other scratch,
certificate, generated source, or output path is allowed. None of these paths
may be committed. Before returning, remove the five named temporary files with
`rm -f --` and then remove the now-empty task directory with
`rmdir -- tmp/p68-ba-def-01`. An ignored `.lake/` cache may remain locally but
must not be committed or included in an artifact bundle.

## Required commands and supervisor gate

Run from the assigned worktree root. Before implementation:

```bash
test "$(git rev-parse HEAD)" = "94442b430f4dbb9b66ec186e5655d556ee4e477e"
test "$(git branch --show-current)" = "formal/luna-p68-ba-def-01"
git status --short
```

The initial status must be empty. After writing the module and temporary
fixtures, do not stage or commit the module. Run this preflight only:

```bash
lake env lean LonelyRunner/BoundedAnnihilator.lean
lake env lean tmp/p68-ba-def-01/Preflight.lean
if lake env lean tmp/p68-ba-def-01/ExpectedFailureZeroModulus.lean >>tmp/p68-ba-def-01/commands.log 2>&1; then exit 1; fi
if lake env lean tmp/p68-ba-def-01/ExpectedFailureWrongHeight.lean >>tmp/p68-ba-def-01/commands.log 2>&1; then exit 1; fi
git diff --check
git diff --name-only 94442b430f4dbb9b66ec186e5655d556ee4e477e --
git ls-files --others --exclude-standard
git status --porcelain=v1 --untracked-files=all
```

Both negative diagnostics must be inspected before the supervisor gate. The
zero-modulus diagnostic must fail at the displayed `#check` because Lean
cannot synthesize `NeZero 0`; the wrong-height diagnostic must fail at the
displayed equality because `9601 ≠ 9600`. A failure caused by an import,
syntax, path, encoding, or unrelated elaboration error does not pass the
fixture.

The frozen pre-commit inventory is:

```text
git diff --name-only: <empty>
git ls-files --others --exclude-standard:
LonelyRunner/BoundedAnnihilator.lean
git status --porcelain=v1 --untracked-files=all:
?? LonelyRunner/BoundedAnnihilator.lean
```

The ignored preflight and Lake-cache paths must not appear. Any staged status,
extra tracked or untracked path, or missing module fails the preflight. Return
the preflight result to the supervising lead and stop. The worker must not run
the full phase until that lead inspects all six fixture results and this exact
inventory, then explicitly authorizes continuation.

After authorization, create the exact temporary axiom probe:

```lean
import LonelyRunner.BoundedAnnihilator

#print axioms LonelyRunner.zmodCyclicDistance_zero
#print axioms LonelyRunner.zmodCyclicDistance_eq_min_val
#print axioms LonelyRunner.boundedAnnihilatorHeight_three
#print axioms LonelyRunner.boundedAnnihilatorHeight_four
```

Then run:

```bash
lake build LonelyRunner.BoundedAnnihilator
lake env lean tmp/p68-ba-def-01/AxiomProbe.lean
if git grep -n -E 'sorry|admit|native_decide|unsafe|^[[:space:]]*(axiom|constant)[[:space:]]' -- LonelyRunner/BoundedAnnihilator.lean; then exit 1; fi
git diff --check
git diff --name-only 94442b430f4dbb9b66ec186e5655d556ee4e477e --
git ls-files --others --exclude-standard
git status --porcelain=v1 --untracked-files=all
```

Before commit, the last two commands must again report the one untracked module
and the exact `??` status above. No ignored scratch path may be staged.

The worker may then commit the one tracked file with a descriptive formal
implementation message, clean the exact temporary files as specified, and
run:

```bash
git status --short
git show --stat --oneline --decorate HEAD
git diff --check 94442b430f4dbb9b66ec186e5655d556ee4e477e..HEAD
git diff --name-only 94442b430f4dbb9b66ec186e5655d556ee4e477e..HEAD
git ls-files --others --exclude-standard
git status --porcelain=v1 --untracked-files=all
```

The frozen post-commit inventory is:

```text
git diff --name-only base..HEAD:
LonelyRunner/BoundedAnnihilator.lean
git ls-files --others --exclude-standard: <empty>
git status --porcelain=v1 --untracked-files=all: <empty>
```

The worktree is review-ready only if this exact inventory holds after temporary
cleanup.

## Expected worker return schema

The worker must return every field, using `none` rather than omitting an
inapplicable value:

```text
Task ID: P68-BA-DEF-01
Effective model and effort metadata: <authoritative runtime record, not self-report>
Base commit: 94442b430f4dbb9b66ec186e5655d556ee4e477e
Launch-record commit/path: <exact external commit and research/luna/launches/p68-ba-def-01.md>
Contract commit/path/SHA-256: <exact values verified from the launch record>
Worktree mapping/readback: <../lrc-luna-p68-ba-def-01 and containment PASS/FAIL only>
Branch/commit: <formal/luna-p68-ba-def-01 and exact commit SHA, or none>
Files changed: <exact tracked paths>
Commands run: <ordered commands and exit codes>
Preflight result: <PASS/FAIL, six fixtures individually>
Full-run result: <PASS/FAIL/not-authorized>
Domain completed: <all five ZMod 5 points and all six fixtures, or exact prefix>
Counts: <5 success-domain points; 6 total fixtures; expected-failure count 2>
First failure or certificate: <least failing fixture, or exact witness table>
Hashes: <SHA-256 of the committed source and any retained report; none for deleted scratch>
Independent comparison: pending VER-P68-BA-DEF-IMPLEMENTATION-182
Tests: <target compile, preflight, build, prohibited-token scan, diff checks>
Axiom output: <verbatim output or not-authorized>
Known limitations: definitions and four local lemmas only; no support/Fourier/LRC claim
Recommended evidence label: infrastructure-only
Escalations: <none or exact semantic issue>
Final status: <preflight-waiting/review-ready/rejected/failed-delegation>
```

The worker may recommend but may not accept an evidence label.

## Independent checker and acceptance criteria

Independent checker: Sol Medium Verification Lead under review task
`VER-P68-BA-DEF-IMPLEMENTATION-182`, using a fresh read-only or isolated replay at the
worker's exact candidate commit. The checker must inspect the complete diff,
re-run all commands including both expected failures, compare the canonical
witness table, verify the source SHA-256, inspect the axiom output, and confirm
that no tracked or ignored task-authored output was retained. The implementing
Luna worker may not perform or claim this independent review.

Acceptance requires all of the following:

1. exact immutable launch record, contract extraction/hash, base, branch,
   public-safe sibling mapping, and isolated worktree containment readback;
2. only the allowed tracked module changed, with exact pre-commit and
   post-commit inventories;
3. exact imports, namespace, four definitions, and four theorem signatures;
4. all six fixtures completed in canonical order;
5. the positive preflight compiles and both negative preflights fail;
6. supervising-lead inspection occurs before the full phase;
7. targeted module compile and Lake build succeed;
8. no `sorry`, `admit`, `unsafe`, `native_decide`, `axiom`, `constant`, disabled
   check, or changed theorem appears;
9. axiom output contains no project-specific or untrusted axiom;
10. deterministic source hash and command results are reported;
11. the worktree is clean after its one-file commit and temporary cleanup; and
12. independent implementation review 182 accepts the exact commit.

Evidence label on success: **`infrastructure-only`**. This implementation may
support later formal work, but neither its compilation nor its arithmetic
lemmas promote the bounded-annihilator theorem, a support theorem, any finite
evidence, or unrestricted LRC.

## Stop and escalation conditions

Stop immediately and return the exact failing goal or fixture if any of these
occurs:

- a definition or theorem signature must change;
- a strict inequality would become weak, equality would become bad, or a
  quantified domain would change;
- a new named declaration, import, tracked file, axiom, placeholder, unsafe
  feature, or `native_decide` appears necessary;
- a positive fixture fails, a negative fixture succeeds, the witness table
  differs, or deterministic ordering cannot be preserved;
- the base, branch, worktree, dependency, provenance, or allowed-path contract
  is not exact;
- a theorem-domain or malformed-input interpretation is ambiguous;
- the worker would need to alter the support theorem or invent a replacement
  result; or
- the execution budget expires.

Routine syntax, import elaboration, type annotations, arithmetic tactics,
formatting, and deterministic serialization may be repaired without changing
the contract. Any semantic defect returns to Sol Medium for a fresh contract;
the worker must not redesign it.

Maximum execution budget: **55 minutes**, including preflight and the
post-authorization full phase. Time waiting for explicit supervisor inspection
does not consume the worker's execution budget. If authorization does not
arrive in the same task turn, return `preflight-waiting` without proceeding.

## Explicit downstream exclusion

`P68-BA-SUPPORT-02` remains **`MEDIUM-SPEC-REQUIRED`**. It depends on a future
accepted and independently reviewed `P68-BA-DEF-01` commit, so it has no valid
exact base for Luna admission yet. It is not bundled into this task.
