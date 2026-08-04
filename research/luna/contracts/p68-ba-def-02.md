# P68 bounded-annihilator definitions: Luna Narrow contract

Task ID: `P68-BA-DEF-02`
Specification task: SPEC-P68-BA-DEF-02-RUNTIME-192

Supervising Sol Medium lead: Formalization/Specification Lead

Purpose: Implement only the four frozen bounded-annihilator definitions and
four local boundary/computation lemmas below. This is a one-layer Lean
definitions task. It does not include the support theorem, Fourier analysis,
the hyperplane corollary, a root-module import, or any claim about unrestricted
Lonely Runner.

Current admission decision: **`MEDIUM-SPEC-REQUIRED` pending independent
contract review**. The accepted Task01 mathematical and implementation
contract at `039e0d4f20a9677ec74bed8ccf1b058afbb27cd0` is preserved below. Its first
rollout failed closed before implementation because the worker's allowed
surface did not expose authoritative effective-model metadata. Root later
confirmed `gpt-5.6-luna`/`xhigh` from the fresh turn context, but retroactive
acceptance is prohibited. Task02 changes only task/worktree identities, the
base, and the operational metadata probe. It may become `LUNA-READY` only
after independent review accepts the final contract blob and Sol High commits
the immutable launch record. Preparation alone is not admission or launch.

Base commit: `c05cd83743e6290598077006b380da5d80a1c122`

Branch/worktree:

- worker branch: `formal/luna-p68-ba-def-02`
- isolated worktree identifier: `isolated:luna-p68-ba-def-02`
- public-safe repository-root sibling mapping:
  `../lrc-luna-p68-ba-def-02`
- the worktree must be created fresh at the exact base commit above;
- the worker must not reuse or resume an existing Codex session or branch.

Worker runtime: a fresh top-level Codex session explicitly routed to
`gpt-5.6-luna` with reasoning effort `xhigh`. Effective model and effort must
be verified from the worker's own fresh authoritative rollout metadata by the
exact read-only probe below. A nested child, inherited Sol route, substitute
model, natural-language identity claim, parent-only readback, or retroactive
attestation does not satisfy this contract.

## Twelve-field Luna admission review

Independent review must check all twelve fields before Sol High may mark the
task `LUNA-READY`:

1. **Exact proposition:** the four definitions and four local lemmas below;
   no support, Fourier, sampling, hyperplane, or LRC theorem.
2. **Quantified domains:** the displayed `Nat`, `Fin`, `ZMod`, `NeZero`, and
   finite fixture types are frozen.
3. **Boundary:** strict badness is `<`; equality is safe; zero modulus must
   fail through the missing premise.
4. **Ordering:** tuple coordinates, field points, least witnesses, fixtures,
   logs, and inventory output use the declared deterministic order.
5. **Fixtures:** success, collision-bearing failure, distance, equality,
   malformed modulus, and deliberately false height fixtures are mandatory.
6. **Allowed files:** one tracked Lean module and the exact ignored temporary
   paths below; no other write is permitted.
7. **Commands:** runtime bootstrap, preflight, targeted build, axiom probe,
   scans, inventories, cleanup, and commit commands are exact.
8. **Report fields:** the complete worker return schema below is mandatory,
   using `none` rather than omission.
9. **Evidence ceiling:** success is `infrastructure-only`; the worker cannot
   promote a mathematical or Lean status.
10. **Stop/escalation:** runtime mismatch, semantic change, fixture mismatch,
    inventory mismatch, prohibited construct, or budget exhaustion fails
    closed.
11. **Supervision:** the Formalization/Specification Lead inspects preflight;
    independent implementation review remains a separate task.
12. **Base/isolation:** exact base, fresh branch, sibling worktree, immutable
    contract delivery, and live containment readback are required.

If any field is changed or cannot be checked, return to
`MEDIUM-SPEC-REQUIRED`; the worker may not fill the gap.

### Exact worktree creation and live containment readback

Sol High or its authorized operations helper must run the following from the
authoritative repository root before the worker starts:

```bash
test ! -e ../lrc-luna-p68-ba-def-02
test -z "$(git branch --list formal/luna-p68-ba-def-02)"
git worktree add -b formal/luna-p68-ba-def-02 \
  ../lrc-luna-p68-ba-def-02 \
  c05cd83743e6290598077006b380da5d80a1c122
```

From the new worktree, the launcher and worker must both run this exact live
readback. Resolved absolute paths are private runtime values: inspect them
locally, but do not persist or publish them.

```bash
worker_root="$(realpath .)"
common_git_dir="$(realpath "$(git rev-parse --git-common-dir)")"
controller_root="$(dirname "$common_git_dir")"
expected_worker_root="$(realpath "$controller_root/../lrc-luna-p68-ba-def-02")"
test "$worker_root" = "$expected_worker_root"
test "$(dirname "$worker_root")" = "$(dirname "$controller_root")"
test "$(basename "$worker_root")" = "lrc-luna-p68-ba-def-02"
test "$(git rev-parse HEAD)" = "c05cd83743e6290598077006b380da5d80a1c122"
test "$(git branch --show-current)" = "formal/luna-p68-ba-def-02"
git worktree list --porcelain | awk \
  -v wt="$worker_root" \
  -v head="c05cd83743e6290598077006b380da5d80a1c122" '
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
      branch_ok = ($2 == "refs/heads/formal/luna-p68-ba-def-02")
      next
    }
    END { exit !(seen && head_ok && branch_ok) }
  '
```

The public report records only `isolated:luna-p68-ba-def-02`, the relative
mapping `../lrc-luna-p68-ba-def-02`, and PASS/FAIL for these checks. It must not
record the resolved private paths.

### Immutable contract-delivery gate

This correction commit cannot contain its own final commit SHA or its own file
SHA-256. Therefore a separate Sol High launch record is mandatory before any
worker session starts. Its exact tracked path is:

```text
research/luna/launches/p68-ba-def-02.md
```

The launch record must be committed separately and must contain these exact
fields with final values:

```text
Task ID: P68-BA-DEF-02
Worker base: c05cd83743e6290598077006b380da5d80a1c122
Contract commit: <40-hex correction tip containing this contract>
Contract path: research/luna/contracts/p68-ba-def-02.md
Contract SHA-256: <64-hex SHA-256 of the blob at Contract commit/Contract path>
Worker branch: formal/luna-p68-ba-def-02
Worktree mapping: ../lrc-luna-p68-ba-def-02
Runtime target: gpt-5.6-luna/xhigh fresh top-level Codex session
Runtime not-before UTC: <RFC3339 UTC timestamp recorded immediately before launch>
Sol High launch authority: approved
```

Sol High must supply the launch-record commit SHA as an external immutable
input. The worker must not infer, edit, or choose any field. Before reading the
implementation contract, it must run the following with
`launch_record_commit` set to that supplied 40-hex SHA:

```bash
launch_record_path='research/luna/launches/p68-ba-def-02.md'
contract_path='research/luna/contracts/p68-ba-def-02.md'
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
runtime_not_before_utc="$(printf '%s\n' "$record_text" | \
  sed -n 's/^Runtime not-before UTC: //p')"
test "$(printf '%s\n' "$record_text" | sed -n 's/^Task ID: //p')" = \
  'P68-BA-DEF-02'
test "$(git show "${launch_record_commit}:${launch_record_path}" | \
  sed -n 's/^Worker base: //p')" = \
  'c05cd83743e6290598077006b380da5d80a1c122'
test "$(git show "${launch_record_commit}:${launch_record_path}" | \
  sed -n 's/^Contract path: //p')" = "$contract_path"
test "$(git show "${launch_record_commit}:${launch_record_path}" | \
  sed -n 's/^Worker branch: //p')" = 'formal/luna-p68-ba-def-02'
test "$(git show "${launch_record_commit}:${launch_record_path}" | \
  sed -n 's/^Worktree mapping: //p')" = '../lrc-luna-p68-ba-def-02'
test "$(git show "${launch_record_commit}:${launch_record_path}" | \
  sed -n 's/^Runtime target: //p')" = \
  'gpt-5.6-luna/xhigh fresh top-level Codex session'
test "$(printf '%s\n' "$record_text" | \
  sed -n 's/^Runtime not-before UTC: //p')" = "$runtime_not_before_utc"
test "$(printf '%s\n' "$record_text" | \
  sed -n 's/^Runtime not-before UTC: //p' | wc -l)" -eq 1
case "$runtime_not_before_utc" in
  ????-??-??T??:??:??.???Z) ;;
  *) exit 1 ;;
esac
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

### Fresh-session authoritative runtime probe

The worker is expressly permitted to parse only the metadata records needed
to identify its own fresh local rollout log. This access is read-only. The
probe may inspect `session_meta` and the first `turn_context` record of recent
JSONL files only. It may not copy, retain, print, summarize, or disclose any
session ID, thread ID, filename, absolute path, prompt, response, raw JSON,
private log content, or raw exception. It must emit only the sanitized PASS
line specified below or a fixed failure code.

Before creating the Lean module or any fixture, create this exact ignored
temporary file with `apply_patch`:

```text
tmp/p68-ba-def-02/RuntimeProbe.ps1
```

Its exact content is:

```powershell
param(
  [Parameter(Mandatory = $true)][string]$ExpectedCwd,
  [Parameter(Mandatory = $true)][string]$NotBeforeUtc
)

$ErrorActionPreference = 'Stop'

function Fail-Closed([string]$Code) {
  [Console]::Error.WriteLine("RUNTIME_METADATA_FAIL code=$Code")
  exit 1
}

try {
  $style = [Globalization.DateTimeStyles]::AssumeUniversal
  $format = 'yyyy-MM-ddTHH:mm:ss.fffZ'
  $notBefore = [DateTimeOffset]::ParseExact(
    $NotBeforeUtc,
    $format,
    [Globalization.CultureInfo]::InvariantCulture,
    $style
  ).ToUniversalTime()
  $now = [DateTimeOffset]::UtcNow
  if ($notBefore -gt $now.AddMinutes(1) -or
      $notBefore -lt $now.AddMinutes(-15)) {
    Fail-Closed 'launch-window'
  }

  $expected = [IO.Path]::GetFullPath($ExpectedCwd).TrimEnd('\')
  $sessionRoot = Join-Path $env:USERPROFILE '.codex\sessions'
  if (-not (Test-Path -LiteralPath $sessionRoot -PathType Container)) {
    Fail-Closed 'log-root-unavailable'
  }

  $candidates = @()
  $files = Get-ChildItem -LiteralPath $sessionRoot -Recurse -File -Filter '*.jsonl' | Where-Object {
      $_.LastWriteTimeUtc -ge $notBefore.AddMinutes(-1).UtcDateTime
    }

  foreach ($file in $files) {
    try {
      $firstLine = Get-Content -LiteralPath $file.FullName -TotalCount 1
      $metaRecord = $firstLine | ConvertFrom-Json -ErrorAction Stop
      if ($metaRecord.type -ne 'session_meta') { continue }
      $metaCwd = [IO.Path]::GetFullPath(
        [string]$metaRecord.payload.cwd
      ).TrimEnd('\')
      $metaTime = [DateTimeOffset]::Parse(
        [string]$metaRecord.payload.timestamp,
        [Globalization.CultureInfo]::InvariantCulture,
        $style
      ).ToUniversalTime()
    } catch {
      continue
    }

    if ($metaCwd -ine $expected -or
        [string]$metaRecord.payload.source -cne 'exec' -or
        $metaTime -lt $notBefore -or
        $metaTime -gt $now.AddMinutes(1)) {
      continue
    }

    $turnRecord = $null
    $selectedMalformed = $false
    foreach ($line in Get-Content -LiteralPath $file.FullName) {
      try {
        $record = $line | ConvertFrom-Json -ErrorAction Stop
      } catch {
        $selectedMalformed = $true
        break
      }
      if ($record.type -eq 'turn_context') {
        $turnRecord = $record
        break
      }
    }
    if ($selectedMalformed) {
      Fail-Closed 'selected-record-malformed'
    }
    $candidates += [pscustomobject]@{
      Meta = $metaRecord
      Turn = $turnRecord
      MetaTime = $metaTime
      Path = [IO.Path]::GetFullPath($file.FullName)
    }
  }

  if ($candidates.Count -ne 1) {
    Fail-Closed 'candidate-count'
  }
  $candidate = $candidates[0]
  if ($null -eq $candidate.Turn) {
    Fail-Closed 'turn-context-missing'
  }

  try {
    $turnCwd = [IO.Path]::GetFullPath(
      [string]$candidate.Turn.payload.cwd
    ).TrimEnd('\')
    $turnTime = [DateTimeOffset]::Parse(
      [string]$candidate.Turn.timestamp,
      [Globalization.CultureInfo]::InvariantCulture,
      $style
    ).ToUniversalTime()
  } catch {
    Fail-Closed 'turn-context-malformed'
  }

  if ([string]$candidate.Turn.payload.model -cne 'gpt-5.6-luna') {
    Fail-Closed 'model-mismatch'
  }
  if ([string]$candidate.Turn.payload.effort -cne 'xhigh') {
    Fail-Closed 'effort-mismatch'
  }
  if ($turnCwd -ine $expected) {
    Fail-Closed 'cwd-mismatch'
  }
  if ([string]$candidate.Meta.payload.source -cne 'exec') {
    Fail-Closed 'source-mismatch'
  }
  if ($candidate.MetaTime -lt $notBefore -or
      $turnTime -lt $notBefore -or
      $turnTime -gt $now.AddMinutes(1)) {
    Fail-Closed 'timestamp-not-fresh'
  }
  if ($candidate.MetaTime -gt $turnTime) {
    Fail-Closed 'timestamp-order'
  }

  $finalMatches = @()
  $finalFiles = Get-ChildItem -LiteralPath $sessionRoot -Recurse -File -Filter '*.jsonl' | Where-Object {
      $_.LastWriteTimeUtc -ge $notBefore.AddMinutes(-1).UtcDateTime
    }
  foreach ($file in $finalFiles) {
    try {
      $firstLine = Get-Content -LiteralPath $file.FullName -TotalCount 1
      $metaRecord = $firstLine | ConvertFrom-Json -ErrorAction Stop
      if ($metaRecord.type -ne 'session_meta') { continue }
      $metaCwd = [IO.Path]::GetFullPath(
        [string]$metaRecord.payload.cwd
      ).TrimEnd('\')
      $metaTime = [DateTimeOffset]::Parse(
        [string]$metaRecord.payload.timestamp,
        [Globalization.CultureInfo]::InvariantCulture,
        $style
      ).ToUniversalTime()
    } catch {
      continue
    }

    if ($metaCwd -ine $expected -or
        [string]$metaRecord.payload.source -cne 'exec' -or
        $metaTime -lt $notBefore -or
        $metaTime -gt $now.AddMinutes(1)) {
      continue
    }
    $finalMatches += [IO.Path]::GetFullPath($file.FullName)
  }

  if ($finalMatches.Count -ne 1) {
    Fail-Closed 'candidate-count'
  }
  if (-not [StringComparer]::OrdinalIgnoreCase.Equals(
      [string]$finalMatches[0], [string]$candidate.Path)) {
    Fail-Closed 'candidate-changed'
  }

  [Console]::Out.WriteLine(
    'RUNTIME_METADATA_PASS model=gpt-5.6-luna effort=xhigh ' +
    'cwd=PASS source=exec fresh_timestamp=PASS candidate_count=1'
  )
  exit 0
} catch {
  Fail-Closed 'probe-error'
}
```

Run it from the assigned WSL worktree root:

```bash
worker_root="$(realpath .)"
worker_root_windows="$(wslpath -w "$worker_root")"
probe_windows="$(wslpath -w tmp/p68-ba-def-02/RuntimeProbe.ps1)"
if ! runtime_probe_output="$(powershell.exe -NoProfile -NonInteractive \
    -ExecutionPolicy Bypass \
    -File "$probe_windows" \
    -ExpectedCwd "$worker_root_windows" \
    -NotBeforeUtc "$runtime_not_before_utc" 2>/dev/null)"; then
  echo 'RUNTIME_METADATA_FAIL code=probe-nonzero'
  exit 1
fi
test "$runtime_probe_output" = \
  'RUNTIME_METADATA_PASS model=gpt-5.6-luna effort=xhigh cwd=PASS source=exec fresh_timestamp=PASS candidate_count=1'
```

The launcher and supervising lead must inspect only that sanitized line. If
the log root is unavailable, no unique fresh candidate exists, any exact field
differs, the timestamp is outside the frozen window, parsing fails, or any raw
metadata would need to be disclosed, stop before implementation with
`failed-delegation`. A parent or later audit may not retroactively satisfy this
worker-local gate.

Access mode: Read access to tracked repository sources, pinned dependencies,
the immutable launch-record and contract blobs, and only the worker's own
fresh rollout metadata through the redacted probe above. Write access is
limited to the one allowed tracked file and exact ignored temporary locations
below. No merge, push, task-board edit, status promotion, dependency or
configuration edit, browser operation, raw-log copy, or session-data
publication is authorized.

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
tmp/p68-ba-def-02/Preflight.lean
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
tmp/p68-ba-def-02/ExpectedFailureZeroModulus.lean
tmp/p68-ba-def-02/ExpectedFailureWrongHeight.lean
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
tmp/p68-ba-def-02/RuntimeProbe.ps1
tmp/p68-ba-def-02/Preflight.lean
tmp/p68-ba-def-02/ExpectedFailureZeroModulus.lean
tmp/p68-ba-def-02/ExpectedFailureWrongHeight.lean
tmp/p68-ba-def-02/AxiomProbe.lean
tmp/p68-ba-def-02/commands.log
```

Lake may write its normal ignored cache beneath `.lake/`. No other scratch,
certificate, generated source, or output path is allowed. None of these paths
may be committed. Before returning, remove the six named temporary files with
`rm -f --` and then remove the now-empty task directory with
`rmdir -- tmp/p68-ba-def-02`. An ignored `.lake/` cache may remain locally but
must not be committed or included in an artifact bundle.

## Required commands and supervisor gate

Run from the assigned worktree root. Before implementation:

```bash
test "$(git rev-parse HEAD)" = "c05cd83743e6290598077006b380da5d80a1c122"
test "$(git branch --show-current)" = "formal/luna-p68-ba-def-02"
git status --short
```

The initial status must be empty. After writing the module and temporary
fixtures, do not stage or commit the module. Run this preflight only:

```bash
lake env lean LonelyRunner/BoundedAnnihilator.lean
lake env lean tmp/p68-ba-def-02/Preflight.lean
if lake env lean tmp/p68-ba-def-02/ExpectedFailureZeroModulus.lean >>tmp/p68-ba-def-02/commands.log 2>&1; then exit 1; fi
if lake env lean tmp/p68-ba-def-02/ExpectedFailureWrongHeight.lean >>tmp/p68-ba-def-02/commands.log 2>&1; then exit 1; fi
git diff --check
git diff --name-only c05cd83743e6290598077006b380da5d80a1c122 --
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
lake env lean tmp/p68-ba-def-02/AxiomProbe.lean
if git grep -n -E 'sorry|admit|native_decide|unsafe|^[[:space:]]*(axiom|constant)[[:space:]]' -- LonelyRunner/BoundedAnnihilator.lean; then exit 1; fi
git diff --check
git diff --name-only c05cd83743e6290598077006b380da5d80a1c122 --
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
git diff --check c05cd83743e6290598077006b380da5d80a1c122..HEAD
git diff --name-only c05cd83743e6290598077006b380da5d80a1c122..HEAD
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
Task ID: P68-BA-DEF-02
Effective model and effort metadata: <exact sanitized RuntimeProbe PASS line, or FAIL code>
Runtime probe disclosure audit: <PASS/FAIL; no IDs, paths, raw JSON, or raw errors>
Base commit: c05cd83743e6290598077006b380da5d80a1c122
Launch-record commit/path: <exact external commit and research/luna/launches/p68-ba-def-02.md>
Contract commit/path/SHA-256: <exact values verified from the launch record>
Worktree mapping/readback: <../lrc-luna-p68-ba-def-02 and containment PASS/FAIL only>
Branch/commit: <formal/luna-p68-ba-def-02 and exact commit SHA, or none>
Files changed: <exact tracked paths>
Commands run: <ordered commands and exit codes>
Preflight result: <PASS/FAIL, six fixtures individually>
Full-run result: <PASS/FAIL/not-authorized>
Domain completed: <all five ZMod 5 points and all six fixtures, or exact prefix>
Counts: <5 success-domain points; 6 total fixtures; expected-failure count 2>
First failure or certificate: <least failing fixture, or exact witness table>
Hashes: <SHA-256 of the committed source and any retained report; none for deleted scratch>
Independent comparison: pending VER-P68-BA-DEF-IMPLEMENTATION-193
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
`VER-P68-BA-DEF-IMPLEMENTATION-193`, using a fresh read-only or isolated replay at the
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
12. independent implementation review 193 accepts the exact commit.

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
- the runtime log cannot be read through the exact probe, the matching record
  is absent or nonunique, model/effort/cwd/source/timestamp differs, or the
  probe would disclose a session identifier, absolute path, raw JSON, or raw
  error;
- a theorem-domain or malformed-input interpretation is ambiguous;
- the worker would need to alter the support theorem or invent a replacement
  result; or
- the execution budget expires.

Routine syntax, import elaboration, type annotations, arithmetic tactics,
formatting, and deterministic serialization may be repaired without changing
the contract. Any semantic defect returns to Sol Medium for a fresh contract;
the worker must not redesign it.

Maximum execution budget: **55 minutes**, including the metadata probe,
preflight, and post-authorization full phase. Time waiting for explicit
supervisor inspection does not consume the worker's execution budget. If
authorization does not arrive in the same task turn, return
`preflight-waiting` without proceeding.

## Explicit downstream exclusion

`P68-BA-SUPPORT-02` remains **`MEDIUM-SPEC-REQUIRED`**. It depends on a future
accepted and independently reviewed `P68-BA-DEF-02` commit, so it has no valid
exact base for Luna admission yet. It is not bundled into this task.
