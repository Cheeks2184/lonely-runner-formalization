# Prompt85 single-tuple literal replay: Luna Narrow contract

Task ID: `P85-LITERAL-REPLAY-02`

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

This is a fresh successor task. `P85-LITERAL-REPLAY-01` remains immutable and
is not revised, resumed, or relaunched. This specification creates no actual
runtime receipt, launch record, worker session, implementation, or output.

Current admission decision: **`REVIEW-REQUIRED`**. All twelve admission gate
fields and the corrected operational provenance gates are frozen below, but a
Medium lead other than this contract's author must independently review the
contract tip. Sol High may change this decision to `LUNA-READY` only after that
review accepts the exact contract blob and Sol High commits the immutable
runtime receipt and launch record described below. No worker is launched by
this specification task.

Base commit: `cc58e9affd445af9cb5f77911c8ab823916bbeae`

Branch/worktree:

- worker branch: `verify/luna-p85-literal-replay-02`;
- isolated worktree identifier: `isolated:luna-p85-literal-replay-02`;
- public-safe sibling mapping: `../lrc-luna-p85-literal-replay-02`;
- create the branch and worktree fresh at the exact base above;
- do not resume an existing worker session, branch, or worktree.

Access mode: Read tracked repository sources and the immutable contract; write
only the allowed tracked and temporary paths listed below. No merge, push,
browser operation, task-board edit, dependency/configuration change, or
evidence/status promotion is authorized.

Worker runtime target: a fresh top-level Codex session explicitly routed to
`gpt-5.6-luna` with reasoning effort `xhigh`, operating through Ubuntu 26.04
WSL. Sol High, not the Luna worker, owns the underlying audit of authoritative
runtime metadata. After independently inspecting that metadata, Sol High must
commit the exact public-safe receipt and binding record below. The worker
verifies only those immutable public-safe Git objects; it must not rediscover,
request, infer, print, or persist inaccessible session metadata. A worker
identity assertion or free-form natural-language model claim is not a
substitute for the receipt. Sol High must recheck the underlying authoritative
metadata before final acceptance.

The executable runtime is `/usr/bin/python3.14`, which must report exactly
`Python 3.14.4`; only the Python standard library is permitted. The privacy
scanner is the Linux-native `/usr/bin/grep`, which must report exactly
`grep (GNU grep) 3.12` on the first line of `--version` output. Do not use an
inherited Windows `rg`, `grep`, or other executable through a mounted Windows
path.

## Immutable delivery and containment gate

After the fresh worker session exists but before it treats the contract as
authoritative, implements source, or runs preflight, Sol High must independently
inspect the authoritative runtime metadata. If and only if the effective model is
`gpt-5.6-luna`, effort is `xhigh`, and the session is fresh and top-level, Sol
High creates exactly this receipt path:

```text
research/luna/receipts/p85-literal-replay-02-runtime.md
```

The receipt blob has exactly six single-valued lines and a terminal LF:

```text
Task ID: P85-LITERAL-REPLAY-02
Effective model: gpt-5.6-luna
Effort: xhigh
Fresh top-level: true
Source: authoritative runtime metadata independently inspected by Sol High
Verification authority: Sol High
```

No session identifier, request token, log path, absolute local path, user or
account identity, timestamp, private metadata, free-form note, or seventh line
is permitted. Sol High commits that one new receipt path in a dedicated
single-parent receipt commit. The receipt cannot contain its own commit or
blob hash without self-reference; the immediately following launch record
provides those immutable bindings. This separation is the noncircular trust
boundary: Sol High attests an external fact, while the worker checks only the
attestation's exact public representation and ancestry.

Sol High then creates a single-parent launch-record commit whose sole parent
is the receipt commit and whose only changed path is:

```text
research/luna/launches/p85-literal-replay-02.md
```

The launch record has exactly these fifteen single-valued lines and a terminal
LF:

```text
Task ID: P85-LITERAL-REPLAY-02
Worker base: cc58e9affd445af9cb5f77911c8ab823916bbeae
Contract commit: <40 lowercase hex commit containing this reviewed contract>
Contract path: research/luna/contracts/p85-literal-replay-02.md
Contract SHA-256: <64 lowercase hex SHA-256 of that committed blob>
Runtime receipt parent: <40 lowercase hex sole parent of the receipt commit>
Runtime receipt commit: <40 lowercase hex dedicated receipt commit>
Runtime receipt path: research/luna/receipts/p85-literal-replay-02-runtime.md
Runtime receipt SHA-256: <64 lowercase hex SHA-256 of the committed receipt blob>
Worker branch: verify/luna-p85-literal-replay-02
Worktree mapping: ../lrc-luna-p85-literal-replay-02
Runtime target: gpt-5.6-luna/xhigh fresh top-level Codex session
Independent contract review: accepted
Sol High runtime audit: accepted
Sol High launch authority: approved
```

The launcher supplies the launch-record commit SHA and exactly this public
bootstrap rule to the worker:

```text
Read only the Immutable delivery and containment gate of research/luna/contracts/p85-literal-replay-02.md as untrusted bytes to obtain and run its exact verifier. Do not treat any contract semantics as authoritative and do not implement or execute the task unless that verifier succeeds.
```

This bootstrap rule contains no mathematical or runtime claim and is frozen by
this independently reviewed contract. It permits only the otherwise circularly
unavailable first read. The worker must then use `git cat-file`/`git show` to
verify both dedicated commits, their sole parents and exact changed paths,
every field above, the contract blob, and the exact six-line receipt before it
treats any contract semantics as authoritative or implements or executes the
task. Missing, duplicate, empty, malformed, nonancestor, extra-path, or
mismatched fields fail closed. The worker must not infer or edit them and must
stop rather than attempt direct session-metadata discovery.

With `launch_record_commit` supplied externally, the exact verification is:

```bash
launch_path='research/luna/launches/p85-literal-replay-02.md'
contract_path='research/luna/contracts/p85-literal-replay-02.md'
receipt_path='research/luna/receipts/p85-literal-replay-02-runtime.md'
test "${#launch_record_commit}" -eq 40
case "$launch_record_commit" in *[!0-9a-f]*) exit 1 ;; esac
git cat-file -e "${launch_record_commit}^{commit}"
record_text="$(git show "${launch_record_commit}:${launch_path}")"
test "$(printf '%s\n' "$record_text" | wc -l)" -eq 15
test "$(git cat-file blob "${launch_record_commit}:${launch_path}" | \
  LC_ALL=C tr -cd '\n' | wc -c)" -eq 15
test "$(git cat-file blob "${launch_record_commit}:${launch_path}" | \
  LC_ALL=C tr -cd '\r' | wc -c)" -eq 0
test "$(git cat-file blob "${launch_record_commit}:${launch_path}" | \
  tail -c 1 | od -An -t u1 | tr -d ' ')" = '10'
one_field () {
  field="$1"
  values="$(printf '%s\n' "$record_text" | sed -n "s/^${field}: //p")"
  test "$(printf '%s\n' "$values" | wc -l)" -eq 1
  test -n "$values"
  printf '%s' "$values"
}
test "$(one_field 'Task ID')" = 'P85-LITERAL-REPLAY-02'
test "$(one_field 'Worker base')" = \
  'cc58e9affd445af9cb5f77911c8ab823916bbeae'
contract_commit="$(one_field 'Contract commit')"
contract_sha256="$(one_field 'Contract SHA-256')"
test "$(one_field 'Contract path')" = "$contract_path"
receipt_parent="$(one_field 'Runtime receipt parent')"
receipt_commit="$(one_field 'Runtime receipt commit')"
test "$(one_field 'Runtime receipt path')" = "$receipt_path"
receipt_sha256="$(one_field 'Runtime receipt SHA-256')"
test "$(one_field 'Worker branch')" = \
  'verify/luna-p85-literal-replay-02'
test "$(one_field 'Worktree mapping')" = \
  '../lrc-luna-p85-literal-replay-02'
test "$(one_field 'Runtime target')" = \
  'gpt-5.6-luna/xhigh fresh top-level Codex session'
test "$(one_field 'Independent contract review')" = 'accepted'
test "$(one_field 'Sol High runtime audit')" = 'accepted'
test "$(one_field 'Sol High launch authority')" = 'approved'
test "${#contract_commit}" -eq 40
case "$contract_commit" in *[!0-9a-f]*) exit 1 ;; esac
test "${#contract_sha256}" -eq 64
case "$contract_sha256" in *[!0-9a-f]*) exit 1 ;; esac
for commit_sha in "$receipt_parent" "$receipt_commit"; do
  test "${#commit_sha}" -eq 40
  case "$commit_sha" in *[!0-9a-f]*) exit 1 ;; esac
  git cat-file -e "${commit_sha}^{commit}"
done
test "${#receipt_sha256}" -eq 64
case "$receipt_sha256" in *[!0-9a-f]*) exit 1 ;; esac
git cat-file -e "${contract_commit}^{commit}"
test "$(git show "${contract_commit}:${contract_path}" | sha256sum | cut -d' ' -f1)" = \
  "$contract_sha256"
test "$(git rev-list --parents -n 1 "$receipt_commit" | wc -w)" -eq 2
test "$(git rev-parse "${receipt_commit}^")" = "$receipt_parent"
test "$(git rev-list --parents -n 1 "$launch_record_commit" | wc -w)" -eq 2
test "$(git rev-parse "${launch_record_commit}^")" = "$receipt_commit"
if git cat-file -e "${receipt_parent}:${receipt_path}" 2>/dev/null; then
  exit 1
fi
if git cat-file -e "${receipt_commit}:${launch_path}" 2>/dev/null; then
  exit 1
fi
test "$(git diff-tree --no-commit-id --name-only -r "$receipt_commit")" = \
  "$receipt_path"
test "$(git diff-tree --no-commit-id --name-only -r "$launch_record_commit")" = \
  "$launch_path"
git merge-base --is-ancestor "$contract_commit" "$receipt_parent"
test "$(git show "${receipt_commit}:${receipt_path}" | sha256sum | cut -d' ' -f1)" = \
  "$receipt_sha256"

receipt_text="$(git show "${receipt_commit}:${receipt_path}")"
test "$(printf '%s\n' "$receipt_text" | wc -l)" -eq 6
test "$(git cat-file blob "${receipt_commit}:${receipt_path}" | \
  LC_ALL=C tr -cd '\n' | wc -c)" -eq 6
test "$(git cat-file blob "${receipt_commit}:${receipt_path}" | \
  LC_ALL=C tr -cd '\r' | wc -c)" -eq 0
test "$(git cat-file blob "${receipt_commit}:${receipt_path}" | \
  tail -c 1 | od -An -t u1 | tr -d ' ')" = '10'
receipt_field () {
  field="$1"
  values="$(printf '%s\n' "$receipt_text" | sed -n "s/^${field}: //p")"
  test "$(printf '%s\n' "$values" | wc -l)" -eq 1
  test -n "$values"
  printf '%s' "$values"
}
test "$(receipt_field 'Task ID')" = 'P85-LITERAL-REPLAY-02'
test "$(receipt_field 'Effective model')" = 'gpt-5.6-luna'
test "$(receipt_field 'Effort')" = 'xhigh'
test "$(receipt_field 'Fresh top-level')" = 'true'
test "$(receipt_field 'Source')" = \
  'authoritative runtime metadata independently inspected by Sol High'
test "$(receipt_field 'Verification authority')" = 'Sol High'
```

The launcher creates the worktree from the authoritative repository root:

```bash
test ! -e ../lrc-luna-p85-literal-replay-02
test -z "$(git branch --list verify/luna-p85-literal-replay-02)"
git worktree add -b verify/luna-p85-literal-replay-02 \
  ../lrc-luna-p85-literal-replay-02 \
  cc58e9affd445af9cb5f77911c8ab823916bbeae
```

The worker must confirm that `realpath .` equals the real path of the declared
sibling mapping, that the basename is `lrc-luna-p85-literal-replay-02`, that
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

The preflight report must contain top-level
`source_path:"scripts/replay_prompt85_literal.py"` and
`source_sha256:<64 lowercase hex>`. The program must hash its own exact raw
source bytes immediately before fixture evaluation and again immediately
before writing the report, reject a supplied mismatch, and record that frozen
hash. It must also contain the seven fixtures in this order, each with
`status:"PASS"`, its observed count and values, and the expected values. It
must end with `preflight_complete:true` and `all_passed:true`. Any source hash
change, exception other than the two explicitly expected exceptions, missing
fixture, or wrong value fails closed.

The worker first writes the preflight report and its SHA-256, then stops for
the supervising Medium lead's inspection. Full execution is authorized only
after that lead creates this ignored file:

```text
tmp/p85-literal-replay-02/medium-preflight-approved.txt
```

with exactly:

```text
Task ID: P85-LITERAL-REPLAY-02
Source SHA-256: <64 lowercase hex recorded by the retained preflight JSON>
Preflight SHA-256: <64 lowercase hex of the retained preflight JSON>
Decision: APPROVED FOR FULL RUN
```

The worker verifies all four single-valued fields and both hashes. If the
source changes after preflight, the approval is void: rerun preflight from the
new source bytes and obtain a new approval file binding both new hashes. If
approval does not arrive during the assigned turn, return
`preflight-waiting`; do not start the large run.

## Allowed files and outputs

Allowed tracked source:

```text
scripts/replay_prompt85_literal.py
```

Allowed tracked deterministic outputs:

```text
research/luna/artifacts/p85-literal-replay-02/preflight.json
research/luna/artifacts/p85-literal-replay-02/full.json
research/luna/artifacts/p85-literal-replay-02/manifest.json
```

Allowed ignored temporary paths only:

```text
tmp/p85-literal-replay-02/medium-preflight-approved.txt
tmp/p85-literal-replay-02/full-second.json
tmp/p85-literal-replay-02/*.stdout
tmp/p85-literal-replay-02/*.stderr
tmp/p85-literal-replay-02/pycache/**
```

The worker may create missing parent directories with ordinary filesystem
commands. All tracked file content must be created or changed with
`apply_patch`; deterministic report files may instead be written by the
assigned replay program. No test module, optimized checker, DP, cache,
certificate for another tuple, or report/documentation file is allowed.
The Luna worker is authorized to create exactly one final commit containing
the four allowed tracked paths after every frozen check passes. It may create
no intermediate commit and may not amend, merge, or push that final commit.

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
- `task_id: "P85-LITERAL-REPLAY-02"`;
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
task_id: P85-LITERAL-REPLAY-02
worker_base: cc58e9affd445af9cb5f77911c8ab823916bbeae
contract_commit: <from immutable launch record>
contract_sha256: <from immutable launch record>
prompt85_sha256: 491e11edbb5fb88756f09f635f08203427035c3ab1eef62c4d18605d7e120255
response85_sha256: 59196ec701c39ab56d8a945897b1719060c3a4070e132597a2f273aad6897722
response85_audit_sha256: 531959e5bc23541dfa867615e907cf429588b264088d7c76ed2e39918f5ade78
python: Python 3.14.4
source_path: scripts/replay_prompt85_literal.py
source_sha256: <hash frozen by preflight and Medium approval>
preflight_path: research/luna/artifacts/p85-literal-replay-02/preflight.json
preflight_sha256
full_path: research/luna/artifacts/p85-literal-replay-02/full.json
full_sha256
full_second_sha256
full_outputs_identical: true
preflight_complete: true
full_complete: true
```

`full-second.json` is generated by a second complete execution of the same
literal implementation, stays ignored, and must have the same SHA-256 as
`full.json`. The manifest does not hash itself. The program's
`--verify-manifest` mode must rehash the retained source, preflight, full
output, and canonical ignored
`tmp/p85-literal-replay-02/full-second.json`; compare both full files
byte-for-byte; revalidate both completion markers and all construction totals;
and exit nonzero on any mismatch. The source SHA in the manifest must equal
the hash frozen in the retained preflight and Medium approval. Source/output
identity does not constitute independent mathematical verification.

## Required commands

After the immutable delivery, runtime, and worktree gates, the worker runs
exactly this Level 2 sequence from the isolated worktree, pausing at the marked
Medium preflight-approval boundary and then continuing in the same order:

```bash
set -euo pipefail
test "$(/usr/bin/python3.14 --version)" = 'Python 3.14.4'
test "$(/usr/bin/grep --version | /usr/bin/head -n 1)" = \
  'grep (GNU grep) 3.12'
mkdir -p research/luna/artifacts/p85-literal-replay-02 \
  tmp/p85-literal-replay-02

source_path='scripts/replay_prompt85_literal.py'
preflight_path='research/luna/artifacts/p85-literal-replay-02/preflight.json'
preflight_partial="${preflight_path}.partial"
full_path='research/luna/artifacts/p85-literal-replay-02/full.json'
full_partial="${full_path}.partial"
second_full_path='tmp/p85-literal-replay-02/full-second.json'
second_full_partial="${second_full_path}.partial"
manifest_path='research/luna/artifacts/p85-literal-replay-02/manifest.json'
manifest_partial="${manifest_path}.partial"
reset_paths=("$source_path" "$preflight_path" "$full_path" "$manifest_path")
source_sha256="$(sha256sum "$source_path" | cut -d' ' -f1)"
test "${#source_sha256}" -eq 64
case "$source_sha256" in *[!0-9a-f]*) exit 1 ;; esac
assert_source_unchanged () {
  test "$(sha256sum "$source_path" | cut -d' ' -f1)" = \
    "$source_sha256"
}

phase_cleanup=()
abort_phase () {
  trap - ERR INT TERM
  git reset --quiet HEAD -- "${reset_paths[@]}" || true
  rm -f -- "${phase_cleanup[@]}"
  exit 1
}

# A failed or interrupted preflight leaves neither a partial file nor an old
# retained preflight that could be mistaken for the current approval basis.
phase_cleanup=("$preflight_path" "$preflight_partial")
trap abort_phase ERR INT TERM
rm -f -- "$preflight_path" "$preflight_partial"
timeout 300s /usr/bin/python3.14 scripts/replay_prompt85_literal.py \
  --preflight \
  --source-sha256 "$source_sha256" \
  --output "$preflight_partial"
assert_source_unchanged
/usr/bin/python3.14 scripts/replay_prompt85_literal.py \
  --verify-preflight \
  "$preflight_partial" \
  --source-sha256 "$source_sha256"
mv -f -- "$preflight_partial" "$preflight_path"
trap - ERR INT TERM
phase_cleanup=()
sha256sum "$preflight_path"

# Stop here until the supervising Medium lead supplies and the worker verifies
# medium-preflight-approved.txt exactly as specified above.
approval='tmp/p85-literal-replay-02/medium-preflight-approved.txt'
test -f "$approval"
test "$(wc -l < "$approval")" -eq 4
test "$(sed -n 's/^Task ID: //p' "$approval" | wc -l)" -eq 1
test "$(sed -n 's/^Task ID: //p' "$approval")" = \
  'P85-LITERAL-REPLAY-02'
test "$(sed -n 's/^Source SHA-256: //p' "$approval" | wc -l)" -eq 1
approved_source_sha="$(sed -n 's/^Source SHA-256: //p' "$approval")"
test "${#approved_source_sha}" -eq 64
case "$approved_source_sha" in *[!0-9a-f]*) exit 1 ;; esac
test "$approved_source_sha" = "$source_sha256"
test "$(sed -n 's/^Preflight SHA-256: //p' "$approval" | wc -l)" -eq 1
approved_preflight_sha="$(sed -n 's/^Preflight SHA-256: //p' "$approval")"
test "${#approved_preflight_sha}" -eq 64
case "$approved_preflight_sha" in *[!0-9a-f]*) exit 1 ;; esac
test "$approved_preflight_sha" = \
  "$(sha256sum "$preflight_path" | cut -d' ' -f1)"
test "$(sed -n 's/^Decision: //p' "$approval" | wc -l)" -eq 1
test "$(sed -n 's/^Decision: //p' "$approval")" = \
  'APPROVED FOR FULL RUN'
assert_source_unchanged

# From valid approval onward, every retained or ignored full/manifest output is
# either atomically installed from a verified same-directory partial file or
# removed on any failure, interruption, timeout, or later precommit rejection.
phase_cleanup=(
  "$preflight_path"
  "$full_path" "$full_partial"
  "$second_full_path" "$second_full_partial"
  "$manifest_path" "$manifest_partial"
)
trap abort_phase ERR INT TERM
rm -f -- "$full_path" "$full_partial" \
  "$second_full_path" "$second_full_partial" \
  "$manifest_path" "$manifest_partial"
timeout 1500s /usr/bin/python3.14 scripts/replay_prompt85_literal.py \
  --full \
  --source-sha256 "$source_sha256" \
  --output "$full_partial"
assert_source_unchanged
mv -f -- "$full_partial" "$full_path"
timeout 1500s /usr/bin/python3.14 scripts/replay_prompt85_literal.py \
  --full \
  --source-sha256 "$source_sha256" \
  --output "$second_full_partial"
assert_source_unchanged
mv -f -- "$second_full_partial" "$second_full_path"
cmp "$full_path" "$second_full_path"

assert_source_unchanged
/usr/bin/python3.14 scripts/replay_prompt85_literal.py \
  --write-manifest \
  --preflight-path "$preflight_path" \
  --full-path "$full_path" \
  --second-full-path "$second_full_path" \
  --source-sha256 "$source_sha256" \
  --contract-commit "$contract_commit" \
  --contract-sha256 "$contract_sha256" \
  --output "$manifest_partial"
assert_source_unchanged
/usr/bin/python3.14 scripts/replay_prompt85_literal.py \
  --verify-manifest \
  "$manifest_partial" \
  --second-full-path "$second_full_path"
mv -f -- "$manifest_partial" "$manifest_path"
/usr/bin/python3.14 scripts/replay_prompt85_literal.py \
  --verify-manifest \
  "$manifest_path" \
  --second-full-path "$second_full_path"
assert_source_unchanged

PYTHONPYCACHEPREFIX=tmp/p85-literal-replay-02/pycache \
  /usr/bin/python3.14 -m py_compile scripts/replay_prompt85_literal.py
assert_source_unchanged
scan_paths=(
  scripts/replay_prompt85_literal.py
  "$preflight_path"
  "$full_path"
  "$manifest_path"
)

actual_changed="$(git status --porcelain=v1 --untracked-files=all | \
  sed 's/^...//' | sort)"
expected_changed="$(printf '%s\n' \
  research/luna/artifacts/p85-literal-replay-02/full.json \
  research/luna/artifacts/p85-literal-replay-02/manifest.json \
  research/luna/artifacts/p85-literal-replay-02/preflight.json \
  scripts/replay_prompt85_literal.py | sort)"
test "$actual_changed" = "$expected_changed"

scan_pattern="-----BEGIN [A-Z ]*PRIVATE KEY-----|gh[pousr]_[A-Za-z0-9_]{20,}|(api[_-]?key|access[_-]?token|client[_-]?secret|password|cookie|session[_-]?id)[[:space:]]*[:=][[:space:]]*[\"'][^\"']+|[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}|[A-Za-z]:\\\\|/home/[^/]+/|/Users/[^/]+/|\\\\\\\\wsl[^\\\\]*\\\\"
if /usr/bin/grep -EIl -i -- "$scan_pattern" "${scan_paths[@]}" \
    > tmp/p85-literal-replay-02/privacy-scan.stdout; then
  false
else
  scan_rc="$?"
  test "$scan_rc" -eq 1
fi

# Stage all four new deliverables so diff validation is nonvacuous.
git add -- "${scan_paths[@]}"
git diff --cached --check -- "${scan_paths[@]}"
staged_changed="$(git diff --cached --name-only --diff-filter=ACMRTUXB | sort)"
test "$staged_changed" = "$expected_changed"
assert_source_unchanged
git -c commit.gpgSign=false commit --no-verify \
  -m 'verification: replay Prompt85 literal constructions'
trap - ERR INT TERM
phase_cleanup=()

bundle_commit="$(git rev-parse HEAD)"
test "${#bundle_commit}" -eq 40
case "$bundle_commit" in *[!0-9a-f]*) exit 1 ;; esac
test "$(git rev-parse HEAD^)" = \
  'cc58e9affd445af9cb5f77911c8ab823916bbeae'
bundle_paths="$(git diff-tree --no-commit-id --name-only -r \
  "$bundle_commit" | sort)"
test "$bundle_paths" = "$expected_changed"
source_blob_oid="$(git rev-parse "$bundle_commit:$source_path")"
preflight_blob_oid="$(git rev-parse \
  "$bundle_commit:research/luna/artifacts/p85-literal-replay-02/preflight.json")"
full_blob_oid="$(git rev-parse \
  "$bundle_commit:research/luna/artifacts/p85-literal-replay-02/full.json")"
manifest_blob_oid="$(git rev-parse \
  "$bundle_commit:research/luna/artifacts/p85-literal-replay-02/manifest.json")"
for blob_oid in "$source_blob_oid" "$preflight_blob_oid" \
  "$full_blob_oid" "$manifest_blob_oid"; do
  test "${#blob_oid}" -eq 40
  case "$blob_oid" in *[!0-9a-f]*) exit 1 ;; esac
done
test "$(git cat-file blob "$source_blob_oid" | sha256sum | cut -d' ' -f1)" = \
  "$source_sha256"
test -z "$(git status --porcelain=v1 --untracked-files=all)"
```

The worker must assert that the changed tracked-file set is exactly the four
allowed paths, scan those files for credentials, private keys, cookies,
browser/session data, email addresses, absolute Windows/WSL/home paths, and
machine identifiers, and report PASS/FAIL without printing any detected
secret value. The staging trap must leave the index empty on any precommit
failure. A successful task has exactly one final commit with the exact worker
base as parent, the exact four paths as its complete diff, and a clean
worktree. No Lean build, repository-wide regression suite, or clean clone is
part of this one-layer checkpoint.

## Expected worker return schema

```text
Task ID:
External metadata receipt verified:
Runtime receipt binding:
Base commit:
Branch/commit:
Bundle parent:
Bundle Git blob OIDs:
Files changed:
Commands run:
Preflight result:
Full-run result:
Domain completed:
Counts:
First failure or certificate:
Hashes:
CHECK-02 handoff:
Independent comparison:
Tests:
Axiom output:
Known limitations:
Recommended evidence label:
Escalations:
Final status:
```

`External metadata receipt verified` must say exactly `PASS - immutable
public-safe receipt verified; underlying runtime audit owned by Sol High`.
`Runtime receipt binding` must report the exact receipt commit, path, and
SHA-256 from the launch record. Neither field may contain a worker identity
claim or inaccessible metadata. `Axiom output` must say
`not applicable; no Lean changed`. `Independent
comparison` must say `pending P85-LITERAL-REPLAY-CHECK-02` unless that separate
reviewed task has actually completed; the worker may not perform or impersonate
it. The return must include all eight discovered `min_J` values and the eight
least minimizer keys, or identify the first failed pivot without presenting a
partial prefix as evidence. `Bundle parent` is the exact worker base. `Bundle
Git blob OIDs` lists the source, preflight, full, and manifest blobs in that
order. `Hashes` includes the SHA-256 of those four committed files and the
ignored second full output. `CHECK-02 handoff` supplies the final bundle commit,
its parent, all four Git blob OIDs, and all five SHA-256 values; no mutable
worktree path is an admissible handoff.

## Independent checker

Independent checker task ID: `P85-LITERAL-REPLAY-CHECK-02` (not launched and
not specified by this contract). It must be a separate Medium-reviewed,
`LUNA-READY` read-only replay task with an implementation independent of this
source. It will consume the immutable source/output/manifest bundle and compare
all eight minima, least minimizers, counts, and completion markers. Reusing
this program's enumeration function is prohibited. Until that task and Medium
review succeed, the current output is an implementation candidate only.

The immutable input to that checker is the Luna-created final bundle commit,
not the worker's mutable worktree. The checker contract must receive the exact
commit SHA and four Git blob OIDs from the primary worker report. It must verify
the commit exists, has the exact worker base as its sole parent, changes exactly
the four allowed paths, reproduces every handed-off blob OID and SHA-256, and
matches the source/preflight/full hashes recorded by the manifest. A missing,
uncommitted, amended, or mismatched bundle fails closed before replay.

## Acceptance criteria and evidence label

The implementation task is accepted operationally only if:

- the worker verifies the exact external metadata receipt and all immutable
  delivery/worktree gates, and Sol High independently rechecks the underlying
  authoritative runtime metadata before final acceptance;
- all seven preflight fixtures pass and Medium authorizes the full run using
  the exact source and preflight hashes;
- both full executions complete the entire declared domain within the budget;
- all per-pivot and total construction counts and the audited non-minimum grid
  match exactly;
- the two full outputs are byte-identical;
- manifest verification, Python compilation, diff check, changed-file
  inventory, and changed-file privacy/secret scan pass;
- only the four allowed tracked files changed;
- the exact four paths pass a nonvacuous staged `git diff --check`, and the
  Luna worker creates exactly one clean final commit with the worker base as
  its parent;
- the worker report supplies the final commit, all four Git blob OIDs, and the
  exact SHA-256 handoff for the independent checker;
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
- Medium preflight approval is absent, its source or preflight hash mismatches,
  or the source changes after approval;
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
  receipt/launch/worktree/contract provenance gate fails;
- the receipt or launch record has an extra line or path, a wrong parent,
  non-LF serialization, a mismatched hash/value, private metadata, or cannot be
  verified without direct worker access to session metadata;
- the Linux-native scanner path/version is wrong, staged diff validation is
  empty or incomplete, the final commit has the wrong parent or path set, the
  worktree is not clean afterward, or any bundle/blob handoff hash mismatches.

Escalate semantic defects to the supervising Medium lead. Do not redesign the
algorithm, invent a replacement theorem, substitute a model, repair a semantic
failure in the same task, or reinterpret a partial prefix as finite evidence.
Routine syntax, imports, type annotations, formatting, and deterministic JSON
serialization may be repaired without altering the frozen semantics. Any
source-byte repair after preflight invalidates that preflight and its Medium
approval; both must be regenerated before either full run.

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
   separate-checker boundary, nonpromotion evidence label, and the
   noncircular external-runtime receipt trust boundary; and
6. absence of credentials, personal data, local absolute paths, browser state,
   or machine-specific identifiers in the contract.

The review must name the reviewed contract commit and blob SHA-256. Any defect
returns the task to `MEDIUM-SPEC-REQUIRED`; it must not be repaired informally
inside a Luna execution.

## Version-02 semantic preservation map

The accepted source specification is
`research/luna/contracts/p85-literal-replay-01.md` with SHA-256
`b188da7ae45e8f85bd8863b55b285ec03fa0f950185830a8bb589a43a16c61fb`.
This `-02` contract changes the task/worktree/output namespace and the runtime
attestation mechanism only. For comparison, canonicalize the two version
tokens `P85-LITERAL-REPLAY-02` to `P85-LITERAL-REPLAY-01` and
`p85-literal-replay-02` to `p85-literal-replay-01`. The following frozen
sections then equal `-01` byte-for-byte:

| Frozen section | Canonical bytes | SHA-256 of the `-01` bytes |
| --- | ---: | --- |
| Exact proposition through all seven preflight fixtures | 8,910 | `4f88b356df1cc46488cb2662e7de3135d7cdc6a526aae8cebf747b7e524a9f85` |
| Allowed tracked and temporary outputs | 1,387 | `756a0b9f320064b8dab957cea0b5441e6b65f855641179668390f0d8ed52bb23` |
| Frozen full-output schema | 2,237 | `5a90e2e08a9f4081447b2f098278657c0e73d88c2eaffe717802408cf0c92851` |
| Manifest and source/output binding | 1,723 | `700d29b6fc7fc8a01cb0e543ee1f925d3446141d1501cefe5c4548e1493fb921` |
| Full-run, cleanup, staging, and bundle commands | 7,720 | `42cce8c2547ad7b910e63bcf13d9950d9df77559fe2d959b67cd713968a77b9a` |
| Independent checker boundary | 1,104 | `c864a821ecf8b5182f1bb7685cfde4ce30cb42b0b0e4f6fa6bb9c1d8f11e9d13` |

Thus the algorithm, domains, owner labels, ordering, strict/closed boundaries,
fixtures, output count and roles, Medium preflight binding, full-run behavior,
and CHECK-02 handoff are declaration-for-declaration unchanged. Receipt and
launch formats are embedded templates only; this specification creates
neither actual record.

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
the Sol High runtime-receipt/launch-record commits remain procedural
prerequisites. Therefore this new `-02` contract remains `REVIEW-REQUIRED`; it
does not self-promote to `LUNA-READY`.
