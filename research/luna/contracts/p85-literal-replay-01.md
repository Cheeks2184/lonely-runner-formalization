# Prompt85 single-tuple literal replay: Luna Narrow contract

Task ID: `P85-LITERAL-REPLAY-01`

Supervising Sol Medium lead: Recovery and Verification Lead, with the
Formalization/Specification Lead reviewing the frozen finite semantics before
launch.

Purpose: Implement exactly one literal finite-enumeration layer and replay the
single candidate tuple `(1,2,5,7,9,11,12,13)` across all eight pivots and every
normalized width-two construction. The task decides the eight disputed
minimum-junction values and their canonical least minimizers. It does not
implement an optimized dynamic program, scan any other speed tuple, modify
Lean, synchronize general documentation, reject a mathematical route, or
promote a status label.

Current admission decision: **`MEDIUM-SPEC-REQUIRED`**. All twelve admission
gate fields are frozen below, but a Medium lead other than this contract's
author must independently review the contract tip. Sol High may change this
decision to `LUNA-READY` only after that review accepts the exact contract blob
and Sol High commits the immutable launch record described below. No worker is
launched by this specification task.

Base commit: `cc58e9affd445af9cb5f77911c8ab823916bbeae`

Branch/worktree:

- worker branch: `verify/luna-p85-literal-replay-01`;
- isolated worktree identifier: `isolated:luna-p85-literal-replay-01`;
- public-safe sibling mapping: `../lrc-luna-p85-literal-replay-01`;
- create the branch and worktree fresh at the exact base above;
- do not resume an existing worker session, branch, or worktree.

Access mode: Read tracked repository sources and the immutable contract; write
only the allowed tracked and temporary paths listed below. No merge, push,
browser operation, task-board edit, dependency/configuration change, or
evidence/status promotion is authorized.

Worker runtime: a fresh top-level Codex session explicitly routed to
`gpt-5.6-luna` with reasoning effort `xhigh`, operating through Ubuntu 26.04
WSL under the repository owner's existing unprivileged account. Authoritative
session/runtime metadata must confirm the effective model and effort. A
natural-language identity claim, inherited Sol child, or substitute route does
not satisfy the contract. The executable runtime is `/usr/bin/python3.14`,
which must report exactly `Python 3.14.4`; only the Python standard library is
permitted.

## Immutable delivery and containment gate

Before launch, Sol High must create and separately commit:

```text
research/luna/launches/p85-literal-replay-01.md
```

with exactly these single-valued fields:

```text
Task ID: P85-LITERAL-REPLAY-01
Worker base: cc58e9affd445af9cb5f77911c8ab823916bbeae
Contract commit: <40 lowercase hex commit containing this reviewed contract>
Contract path: research/luna/contracts/p85-literal-replay-01.md
Contract SHA-256: <64 lowercase hex SHA-256 of that committed blob>
Worker branch: verify/luna-p85-literal-replay-01
Worktree mapping: ../lrc-luna-p85-literal-replay-01
Runtime target: gpt-5.6-luna/xhigh fresh top-level Codex session
Independent contract review: accepted
Sol High launch authority: approved
```

The launcher supplies the launch-record commit SHA to the worker. The worker
must use `git cat-file`/`git show` to verify the record commit, every exact
field above, the contract commit, and the contract blob SHA-256 before reading
the contract. Missing, duplicate, empty, malformed, or mismatched fields fail
closed. The worker must not infer or edit them.

With `launch_record_commit` supplied externally, the exact verification is:

```bash
launch_path='research/luna/launches/p85-literal-replay-01.md'
contract_path='research/luna/contracts/p85-literal-replay-01.md'
test "${#launch_record_commit}" -eq 40
case "$launch_record_commit" in *[!0-9a-f]*) exit 1 ;; esac
git cat-file -e "${launch_record_commit}^{commit}"
record_text="$(git show "${launch_record_commit}:${launch_path}")"
test "$(printf '%s\n' "$record_text" | wc -l)" -eq 10
one_field () {
  field="$1"
  values="$(printf '%s\n' "$record_text" | sed -n "s/^${field}: //p")"
  test "$(printf '%s\n' "$values" | wc -l)" -eq 1
  test -n "$values"
  printf '%s' "$values"
}
test "$(one_field 'Task ID')" = 'P85-LITERAL-REPLAY-01'
test "$(one_field 'Worker base')" = \
  'cc58e9affd445af9cb5f77911c8ab823916bbeae'
contract_commit="$(one_field 'Contract commit')"
contract_sha256="$(one_field 'Contract SHA-256')"
test "$(one_field 'Contract path')" = "$contract_path"
test "$(one_field 'Worker branch')" = \
  'verify/luna-p85-literal-replay-01'
test "$(one_field 'Worktree mapping')" = \
  '../lrc-luna-p85-literal-replay-01'
test "$(one_field 'Runtime target')" = \
  'gpt-5.6-luna/xhigh fresh top-level Codex session'
test "$(one_field 'Independent contract review')" = 'accepted'
test "$(one_field 'Sol High launch authority')" = 'approved'
test "${#contract_commit}" -eq 40
case "$contract_commit" in *[!0-9a-f]*) exit 1 ;; esac
test "${#contract_sha256}" -eq 64
case "$contract_sha256" in *[!0-9a-f]*) exit 1 ;; esac
git cat-file -e "${contract_commit}^{commit}"
test "$(git show "${contract_commit}:${contract_path}" | sha256sum | cut -d' ' -f1)" = \
  "$contract_sha256"
```

The launcher creates the worktree from the authoritative repository root:

```bash
test ! -e ../lrc-luna-p85-literal-replay-01
test -z "$(git branch --list verify/luna-p85-literal-replay-01)"
git worktree add -b verify/luna-p85-literal-replay-01 \
  ../lrc-luna-p85-literal-replay-01 \
  cc58e9affd445af9cb5f77911c8ab823916bbeae
```

The worker must confirm that `realpath .` equals the real path of the declared
sibling mapping, that the basename is `lrc-luna-p85-literal-replay-01`, that
`git rev-parse HEAD` is the exact base, that `git branch --show-current` is the
exact worker branch, and that `git worktree list --porcelain` reports the same
HEAD and branch. Absolute paths are inspected locally but never persisted.

## Exact proposition or algorithm

The sole candidate is the ordered tuple

```text
a = (1,2,5,7,9,11,12,13),  n = 8,  N = n+1 = 9.
```

The program must hard-code this candidate rather than accept a user-selected
tuple in full-run mode. For pivot `j in {0,...,7}` define, using arbitrary
precision integers,

```text
p = a[j]
M = N*p
rho_M(x) = min(x mod M, M - (x mod M))
R_j = {r in {0,...,M-1} : r mod N != 0}
O_j = the increasing tuple of original indices i in {0,...,7} with i != j
B_i^j = {r in R_j : rho_M(r*a[i]) < p}.
```

Owner labels are always the original indices. Equal or colliding bad sets are
not quotiented, deduplicated, or used to relabel owners.

For the seven-owner type, a normalized construction consists of:

1. a permutation `sigma` of `O_j` satisfying
   `sigma[0] < sigma[1] < sigma[2]`;
2. root bag `bag[0] = sorted(sigma[0:3])`;
3. for each `k=3,4,5,6`, an increasing two-owner tuple `S_k` which occurs as a
   subset of at least one already created bag;
4. child index `c=k-2`, child bag
   `bag[c] = sorted(S_k union {sigma[k]})`;
5. `parent[c]` equal to the least integer `b<c` with
   `set(S_k) <= set(bag[b])`.

An unavailable separator is not a construction. A nonleast chosen parent is
not accepted. At every step the implementation must assert that the separator
has two distinct original owner labels, that the new owner is not in the
separator, that the child bag has three labels, and that its intersection with
its derived parent is exactly the separator.

For any owner subset `S`, compute `U(S)` literally as the Python finite-set
union of the labelled `B_i^j`. Empty unions are empty. For every construction
compute in mathematical integers

```text
J_j(D) = sum_b len(U(bag[b]))
         - sum_(c=1,...,4) len(U(bag[c] intersect bag[parent[c]])).
```

The separator-intersection equality must also be checked, but the subtracted
term is recomputed from the actual bag intersection. Natural-number truncation
is prohibited. Independently within the same literal layer, compute the
marginal tuple

```text
(len(U(bag[0])),
 len(B_sigma[3] \ U(S_3)), ...,
 len(B_sigma[6] \ U(S_6)))
```

and assert that its integer sum equals `J_j(D)` for every construction.

For each pivot enumerate the complete normalized type, minimize `J_j(D)`, and
retain the lexicographically least minimizing construction under the exact
ordering below. This finite result neither proves unrestricted LRC nor changes
the status of the width-two universal statement without separate review.

## Canonical finite domain and deterministic ordering

- Pivots are processed in increasing original index `0,...,7`.
- Residues are processed in increasing representative order `0,...,M-1`.
- Owners and all serialized owner sets are in increasing original-index order.
- `sigma` values are traversed in ordinary tuple lexicographic order: use
  `itertools.permutations(O_j)` on increasing `O_j` and retain exactly those
  with the first three entries strictly increasing.
- At each `k`, form the set of all increasing pairs contained in any earlier
  bag, sort that set lexicographically, and traverse it in that order.
- Separator sequences use depth-first recursion in `k=3,4,5,6` order, so their
  comparison is ordinary lexicographic comparison of
  `(S_3,S_4,S_5,S_6)`.
- The complete construction key is `(sigma,(S_3,S_4,S_5,S_6))`. Parents,
  bags, and marginals are derived and are not additional tie breakers.
- On equal `J`, retain the existing result; because traversal is exact, this
  retains the least key.
- The available-pair counts at successive steps must be exactly `3,5,7,9`.
- Exactly `793800` constructions must be evaluated at every pivot and exactly
  `6350400` over all eight pivots, per full execution. These are requirements,
  not disputed output values.
- JSON object keys are sorted; JSON arrays preserve the order specified here.
  Serialization is UTF-8, ASCII-escaped, compact JSON with separators `,` and
  `:`, and exactly one final LF. No timestamps, random values, concurrency,
  hash-randomized set iteration, locale-dependent formatting, or machine paths
  may affect output.

## Strict and closed boundary rules

- Badness is strictly `rho_M(r*a[i]) < p`; `rho=p-1` is bad and `rho=p` is
  safe.
- Candidate membership is strictly `r mod 9 != 0`; all multiples of `9`,
  including zero, are excluded.
- Residue representatives are the half-open interval `0 <= r < M`.
- `x mod M` is the canonical nonnegative Python remainder. Both cyclic sides,
  zero, and an even-modulus antipode are retained.
- All speeds must be Python integers but not booleans, strictly positive, and
  pairwise distinct; `n>=3` is required. Validation rejects rather than
  deduplicates or coerces malformed data.
- The full candidate is not sorted or normalized by the worker; its displayed
  order and original labels are authoritative.

## Mandatory preflight fixtures

The same literal enumerator used for the full run must execute all fixtures.
No disputed Prompt85 candidate minimum or minimizer may appear as a preflight
expectation.

1. **One-bag equality and strict-deficit success.** Owners `(0,1,2)` have
   labelled sets `B_0={0,1}`, `B_1={1,2}`, `B_2={3}`. The sole construction
   has `sigma=(0,1,2)`, no separators, count `1`, exact union `4`, and `J=4`.
   With synthetic candidate bound `5`, `J<5` is true. This checks the one-bag
   equality base and a known success branch.
2. **Four-owner width-two equality and equality-boundary failure.** Owners
   `(0,1,2,3)` have disjoint singleton sets `B_i={i}`. All `12`
   constructions have union `4` and `J=4`; the least minimizer is
   `sigma=(0,1,2,3)`, separator `((0,1),)`, parent `(0,)`. With synthetic
   candidate bound `4`, the strict test `J<4` is false.
3. **Four-owner width-two overcount.** Give the six pair points the exact
   encoding `e01=0,e02=1,e03=2,e12=3,e13=4,e23=5` and set
   `B_0={0,1,2}`, `B_1={0,3,4}`, `B_2={1,3,5}`, `B_3={2,4,5}`. All `12`
   normalized constructions have exact union `6` and `J=7`; the least
   minimizer is `sigma=(0,1,2,3)`, separator `((0,1),)`, parent `(0,)`.
   This is an abstract set system, not a modular LRC counterexample.
4. **Strict modular boundary.** Use `N=4,p=3,M=12,a_i=1`. Residues `2,3,10`
   are candidates; `rho(2)=rho(10)=2=p-1` and both are bad, while
   `rho(3)=3=p` and is safe. Residue `6` is the antipode and safe. Residues
   `0,4,8` are excluded candidate multiples. Every equality is checked with
   the strict predicate.
5. **Collision with distinct owner labels.** Owners `(0,1,2,3,4)` all have
   the identical labelled set `{0,2,4}`. There are exactly `300` normalized
   constructions, exact union `3`, and every construction has `J=3`. The least
   minimizer begins with `sigma=(0,1,2,3,4)` and separator sequence
   `((0,1),(0,1))`. Owner labels must remain five distinct labels.
6. **Malformed repeated speed.** Calling the exact full-domain validator on
   `(1,1,2)` must raise `ValueError` with exact message
   `speeds must be pairwise distinct`; it must not silently deduplicate.
7. **Deliberately altered expectation.** Apply the expectation checker to the
   already computed four-owner pair-incidence result while supplying altered
   expected minimum `6` instead of proved value `7`. It must raise the
   program's dedicated `ExpectationMismatch`, and the preflight records PASS
   only if this wrong value is rejected.

The preflight report must contain the seven fixtures in this order, each with
`status:"PASS"`, its observed count and values, and the expected values. It
must end with `preflight_complete:true` and `all_passed:true`. Any exception
other than the two explicitly expected exceptions, any missing fixture, or any
wrong value fails closed.

The worker first writes the preflight report and its SHA-256, then stops for
the supervising Medium lead's inspection. Full execution is authorized only
after that lead creates this ignored file:

```text
tmp/p85-literal-replay-01/medium-preflight-approved.txt
```

with exactly:

```text
Task ID: P85-LITERAL-REPLAY-01
Preflight SHA-256: <64 lowercase hex of the retained preflight JSON>
Decision: APPROVED FOR FULL RUN
```

The worker verifies all three single-valued fields and the hash. If approval
does not arrive during the assigned turn, return `preflight-waiting`; do not
start the large run.

## Allowed files and outputs

Allowed tracked source:

```text
scripts/replay_prompt85_literal.py
```

Allowed tracked deterministic outputs:

```text
research/luna/artifacts/p85-literal-replay-01/preflight.json
research/luna/artifacts/p85-literal-replay-01/full.json
research/luna/artifacts/p85-literal-replay-01/manifest.json
```

Allowed ignored temporary paths only:

```text
tmp/p85-literal-replay-01/medium-preflight-approved.txt
tmp/p85-literal-replay-01/full-second.json
tmp/p85-literal-replay-01/*.stdout
tmp/p85-literal-replay-01/*.stderr
tmp/p85-literal-replay-01/pycache/**
```

The worker may create missing parent directories with ordinary filesystem
commands. All tracked file content must be created or changed with
`apply_patch`; deterministic report files may instead be written by the
assigned replay program. No test module, optimized checker, DP, cache,
certificate for another tuple, or report/documentation file is allowed.

On failure, retained outputs must not say `COMPLETE`; delete any partial
tracked output created during that failed command, retain only ignored logs,
and report the failure. Do not commit a partial manifest.

## Frozen full-output schema

`full.json` has these exact top-level keys:

```text
schema_version, task_id, evidence_scope, input, pivots, completion
```

with values:

- `schema_version: 1`;
- `task_id: "P85-LITERAL-REPLAY-01"`;
- `evidence_scope: "single-tuple literal replay; independent check pending"`;
- `input: {"speeds":[1,2,5,7,9,11,12,13],"n":8,"N":9}`;
- `pivots`: eight objects in pivot-index order;
- `completion`: the exact completion marker below.

Each pivot object has exactly these keys:

```text
j, p, M, owners, candidate_count, exact_union_count, gap,
uncovered_residues, least_uncovered, owner_bad_set_counts,
construction_count, evaluated_count, min_J, minimizer_count,
least_minimizer
```

`owner_bad_set_counts` is an array of `[original_owner_index,count]` pairs in
owner order. `least_uncovered` is the least uncovered integer or JSON `null`.
`least_minimizer` has exactly:

```text
sigma, separators, parents, bags, marginals
```

where all are arrays in the deterministic orders above, `parents` corresponds
to child bags `1,...,4`, and `marginals` is the root term followed by the four
introduced-owner marginal terms. The program must assert that the marginal
sum is `min_J` and recompute the serialized minimizer's junction value before
writing output.

The already independently audited, non-minimum columns are mandatory internal
checks and must appear exactly as follows:

```text
j p   M   |R| union gap uncovered_residues
0 1   9    8    8   0  []
1 2   18  16   16   0  []
2 5   45  40   40   0  []
3 7   63  56   50   6  [8,20,22,41,43,55]
4 9   81  72   64   8  [10,21,26,28,53,55,60,71]
5 11  99  88   82   6  [26,35,37,62,64,73]
6 12 108  96   90   6  [26,28,38,70,80,82]
7 13 117 104   96   8  [28,37,41,44,73,76,80,89]
```

No expected `min_J`, minimizer count, or least minimizing construction for
this tuple is supplied. The program must discover them from the complete
literal enumeration.

The exact completion object is:

```json
{"all_pivots_complete":true,"constructions_per_pivot":793800,"evaluated_constructions_total":6350400,"pivot_count":8,"status":"COMPLETE","tuple_count":1}
```

It may be written only after all eight pivot loops finish and every per-pivot
count check passes.

## Manifest and source/output binding

`manifest.json` has sorted keys and binds the exact raw LF-terminated bytes of
the source, preflight, and full output. It contains:

```text
schema_version: 1
task_id: P85-LITERAL-REPLAY-01
worker_base: cc58e9affd445af9cb5f77911c8ab823916bbeae
contract_commit: <from immutable launch record>
contract_sha256: <from immutable launch record>
prompt85_sha256: 491e11edbb5fb88756f09f635f08203427035c3ab1eef62c4d18605d7e120255
response85_sha256: 59196ec701c39ab56d8a945897b1719060c3a4070e132597a2f273aad6897722
response85_audit_sha256: 531959e5bc23541dfa867615e907cf429588b264088d7c76ed2e39918f5ade78
python: Python 3.14.4
source_path/source_sha256
preflight_path/preflight_sha256
full_path/full_sha256
full_second_sha256
full_outputs_identical: true
preflight_complete: true
full_complete: true
```

`full-second.json` is generated by a second complete execution of the same
literal implementation, stays ignored, and must have the same SHA-256 as
`full.json`. The manifest does not hash itself. The program's
`--verify-manifest` mode must rehash all three tracked inputs, revalidate both
completion markers and all construction totals, and exit nonzero on any
mismatch. Source/output identity does not constitute independent mathematical
verification.

## Required commands

After the immutable delivery, runtime, worktree, and preflight-approval gates,
the worker runs exactly this Level 2 sequence from the isolated worktree:

```bash
set -euo pipefail
test "$(python3.14 --version)" = 'Python 3.14.4'
mkdir -p research/luna/artifacts/p85-literal-replay-01 \
  tmp/p85-literal-replay-01

timeout 300s python3.14 scripts/replay_prompt85_literal.py \
  --preflight \
  --output research/luna/artifacts/p85-literal-replay-01/preflight.json
sha256sum research/luna/artifacts/p85-literal-replay-01/preflight.json

# Stop here until the supervising Medium lead supplies and the worker verifies
# medium-preflight-approved.txt exactly as specified above.
approval='tmp/p85-literal-replay-01/medium-preflight-approved.txt'
test -f "$approval"
test "$(wc -l < "$approval")" -eq 3
test "$(sed -n 's/^Task ID: //p' "$approval" | wc -l)" -eq 1
test "$(sed -n 's/^Task ID: //p' "$approval")" = \
  'P85-LITERAL-REPLAY-01'
test "$(sed -n 's/^Preflight SHA-256: //p' "$approval" | wc -l)" -eq 1
approved_preflight_sha="$(sed -n 's/^Preflight SHA-256: //p' "$approval")"
test "${#approved_preflight_sha}" -eq 64
case "$approved_preflight_sha" in *[!0-9a-f]*) exit 1 ;; esac
test "$approved_preflight_sha" = \
  "$(sha256sum research/luna/artifacts/p85-literal-replay-01/preflight.json | cut -d' ' -f1)"
test "$(sed -n 's/^Decision: //p' "$approval" | wc -l)" -eq 1
test "$(sed -n 's/^Decision: //p' "$approval")" = \
  'APPROVED FOR FULL RUN'

timeout 1500s python3.14 scripts/replay_prompt85_literal.py \
  --full \
  --output research/luna/artifacts/p85-literal-replay-01/full.json
timeout 1500s python3.14 scripts/replay_prompt85_literal.py \
  --full \
  --output tmp/p85-literal-replay-01/full-second.json
cmp research/luna/artifacts/p85-literal-replay-01/full.json \
  tmp/p85-literal-replay-01/full-second.json

python3.14 scripts/replay_prompt85_literal.py \
  --write-manifest \
  --preflight-path research/luna/artifacts/p85-literal-replay-01/preflight.json \
  --full-path research/luna/artifacts/p85-literal-replay-01/full.json \
  --second-full-path tmp/p85-literal-replay-01/full-second.json \
  --contract-commit "$contract_commit" \
  --contract-sha256 "$contract_sha256" \
  --output research/luna/artifacts/p85-literal-replay-01/manifest.json
python3.14 scripts/replay_prompt85_literal.py \
  --verify-manifest \
  research/luna/artifacts/p85-literal-replay-01/manifest.json

PYTHONPYCACHEPREFIX=tmp/p85-literal-replay-01/pycache \
  python3.14 -m py_compile scripts/replay_prompt85_literal.py
git diff --check
actual_changed="$(git status --porcelain=v1 --untracked-files=all | \
  sed 's/^...//' | sort)"
expected_changed="$(printf '%s\n' \
  research/luna/artifacts/p85-literal-replay-01/full.json \
  research/luna/artifacts/p85-literal-replay-01/manifest.json \
  research/luna/artifacts/p85-literal-replay-01/preflight.json \
  scripts/replay_prompt85_literal.py | sort)"
test "$actual_changed" = "$expected_changed"

scan_paths=(
  scripts/replay_prompt85_literal.py
  research/luna/artifacts/p85-literal-replay-01/preflight.json
  research/luna/artifacts/p85-literal-replay-01/full.json
  research/luna/artifacts/p85-literal-replay-01/manifest.json
)
scan_pattern="-----BEGIN [A-Z ]*PRIVATE KEY-----|gh[pousr]_[A-Za-z0-9_]{20,}|(api[_-]?key|access[_-]?token|client[_-]?secret|password|cookie|session[_-]?id)[[:space:]]*[:=][[:space:]]*[\"'][^\"']+|[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}|[A-Za-z]:\\\\|/home/[^/]+/|/Users/[^/]+/|\\\\\\\\wsl[^\\\\]*\\\\"
if rg -l -i -- "$scan_pattern" "${scan_paths[@]}" \
    > tmp/p85-literal-replay-01/privacy-scan.stdout; then
  exit 1
else
  scan_rc="$?"
  test "$scan_rc" -eq 1
fi
git status --short
```

The worker must then assert that the changed tracked-file set is exactly the
four allowed paths, scan those files for credentials, private keys, cookies,
browser/session data, email addresses, absolute Windows/WSL/home paths, and
machine identifiers, and report PASS/FAIL without printing any detected secret
value. No Lean build, repository-wide regression suite, or clean clone is part
of this one-layer checkpoint.

## Expected worker return schema

```text
Task ID:
Effective model and effort metadata:
Base commit:
Branch/commit:
Files changed:
Commands run:
Preflight result:
Full-run result:
Domain completed:
Counts:
First failure or certificate:
Hashes:
Independent comparison:
Tests:
Axiom output:
Known limitations:
Recommended evidence label:
Escalations:
Final status:
```

`Axiom output` must say `not applicable; no Lean changed`. `Independent
comparison` must say `pending P85-LITERAL-REPLAY-CHECK-02` unless that separate
reviewed task has actually completed; the worker may not perform or impersonate
it. The return must include all eight discovered `min_J` values and the eight
least minimizer keys, or identify the first failed pivot without presenting a
partial prefix as evidence.

## Independent checker

Independent checker task ID: `P85-LITERAL-REPLAY-CHECK-02` (not launched and
not specified by this contract). It must be a separate Medium-reviewed,
`LUNA-READY` read-only replay task with an implementation independent of this
source. It will consume the immutable source/output/manifest bundle and compare
all eight minima, least minimizers, counts, and completion markers. Reusing
this program's enumeration function is prohibited. Until that task and Medium
review succeed, the current output is an implementation candidate only.

## Acceptance criteria and evidence label

The implementation task is accepted operationally only if:

- authoritative metadata confirms Luna/xhigh and all immutable delivery and
  worktree gates pass;
- all seven preflight fixtures pass and Medium authorizes the full run using
  the exact preflight hash;
- both full executions complete the entire declared domain within the budget;
- all per-pivot and total construction counts and the audited non-minimum grid
  match exactly;
- the two full outputs are byte-identical;
- manifest verification, Python compilation, diff check, changed-file
  inventory, and changed-file privacy/secret scan pass;
- only the four allowed tracked files changed;
- no prohibited technique or semantic substitution is present; and
- the supervising Medium lead inspects the source, discovered values,
  minimizers, manifests, and worker report.

Evidence label on this task's success:
`accepted implementation candidate; independent verification pending`.
It is not yet `computed finite evidence`, does not reject the universal
width-two invariant, and cannot promote any theorem or route status. Only Sol
High may accept a later finite-evidence label after the separate checker and
review.

## Stop and escalation conditions

Stop immediately and preserve the failure only as operational provenance if:

- a frozen type, quantifier, boundary, ordering, output field, or malformed
  behavior is ambiguous or cannot be implemented literally;
- a separator is unavailable, an available-pair count is not `3,5,7,9`, a
  parent is nonleast, an owner label is lost, or a bag/intersection invariant
  fails;
- any preflight value fails or the altered value is accepted;
- Medium preflight approval is absent or its hash mismatches;
- any pivot count differs from `793800`, the total differs from `6350400`, or
  a non-minimum pivot-grid value differs from the audited table;
- a full command times out, crashes, writes a partial `COMPLETE` marker, or the
  two deterministic outputs differ;
- the worker would need an optimized DP, pruning, branch-and-bound, symmetry
  reduction beyond the frozen first-triple normalization, parallel execution,
  native extension, nonstandard dependency, or another tuple;
- any proposal would weaken or change the target, strictness, candidate grid,
  owner labels, minimizer ordering, malformed behavior, or report schema;
- an extra tracked file changes, a secret/private artifact is detected, or the
  runtime/worktree/contract provenance gate fails.

Escalate semantic defects to the supervising Medium lead. Do not redesign the
algorithm, invent a replacement theorem, substitute a model, repair a semantic
failure in the same task, or reinterpret a partial prefix as finite evidence.
Routine syntax, imports, type annotations, formatting, and deterministic JSON
serialization may be repaired without altering the frozen semantics.

Maximum execution budget: one uninterrupted hour total after implementation,
including preflight, Medium inspection wait within the live turn, two full
runs, manifest verification, and Level 2 checks. Each full run has a
`1500`-second hard timeout. If timely Medium approval is unavailable, stop as
`preflight-waiting`; do not consume the full-run budget.

## Required independent contract review

Before `LUNA-READY`, a second Medium lead must return an explicit PASS/FAIL for:

1. literal agreement with Prompt85's normalized construction and the accepted
   parts of `docs/response85-mathematical-audit.md`;
2. original owner labels, strict badness, candidate exclusion, least-parent
   derivation, integer junction subtraction, enumeration order, and both exact
   construction totals;
3. independent derivation of every synthetic preflight expectation, including
   proof that no disputed candidate minimum is used as an oracle;
4. full-output and least-minimizer schema, completion markers, double-run
   determinism, manifest binding, malformed behavior, and fail-closed cleanup;
5. one-layer scope, allowed paths, executable command syntax, runtime budget,
   separate-checker boundary, and nonpromotion evidence label; and
6. absence of credentials, personal data, local absolute paths, browser state,
   or machine-specific identifiers in the contract.

The review must name the reviewed contract commit and blob SHA-256. Any defect
returns the task to `MEDIUM-SPEC-REQUIRED`; it must not be repaired informally
inside a Luna execution.

## Admission-gate accounting

| Gate | Frozen location |
| --- | --- |
| 1. Exact proposition/algorithm | Exact proposition or algorithm |
| 2. Quantified domains and finite types | Exact proposition; canonical domain |
| 3. Strict/closed boundaries | Strict and closed boundary rules |
| 4. Canonical enumeration/order | Canonical finite domain and ordering |
| 5. Success/failure/equality/malformed fixtures | Mandatory preflight fixtures |
| 6. Allowed files/outputs | Allowed files and outputs |
| 7. Exact acceptance commands | Required commands |
| 8. Expected report fields | Frozen output and worker return schemas |
| 9. Evidence classification | Acceptance criteria and evidence label |
| 10. Stop/escalation conditions | Stop and escalation conditions |
| 11. Supervising Medium lead | Header and preflight approval gate |
| 12. Base and isolated worktree | Header and immutable containment gate |

The twelve semantic fields are present, but independent contract review and
the Sol High launch record remain procedural prerequisites. Therefore this
commit remains `MEDIUM-SPEC-REQUIRED`; it does not self-promote to
`LUNA-READY`.
