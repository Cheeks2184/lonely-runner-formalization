# Prompt85 literal replay contract review

Task ID: `P85-LITERAL-REPLAY-REVIEW-RECORD-263`

Review level: Level 1, documentation-only independent contract review

Review base: `66f4dc8adc96e4fdf1b0686088b9c18a9f12c83d`

Candidate contract commit:
`2b0b537bfc3d1cd0bc619e3d84caf2ff2d663a98`

Candidate contract path:
`research/luna/contracts/p85-literal-replay-01.md`

Candidate contract SHA-256:
`a6018d39cb48d3e153fe8f350549d51c8df59d295d0cfeb07de63591b92dac7d`

Candidate contract shape: 29,977 UTF-8 bytes and characters, 682 LF
separators, no CR, and a terminal LF.

## Disposition

**REVISE. Do not launch Luna.**

The frozen mathematical replay semantics are accepted, but three operational
provenance and acceptance-command defects prevent promotion from
`MEDIUM-SPEC-REQUIRED` to `LUNA-READY`. The candidate contract must be
corrected and independently rereviewed before Sol High creates a launch
record.

This review does not implement the checker, execute disputed Prompt85 minima,
launch Luna, reject the width-two theorem, create computed finite evidence,
or promote any mathematical or lifecycle status.

## Semantic checks passed

The contract agrees with Prompt85's frozen normalized width-two construction
and the accepted scope of `docs/response85-mathematical-audit.md` in the
following respects:

- The tuple is exactly `(1,2,5,7,9,11,12,13)`, with `n=8` and `N=9`.
- Pivot residues use `0<=r<9*a_j` and exclude exactly the multiples of `9`.
- Badness is strict `rho<p`; `rho=p-1` is bad and `rho=p` is safe.
- Original owner indices remain distinct labels even when bad sets coincide.
- A normalized construction uses a bijective owner order with only the first
  triple sorted, then introduces one fresh owner through an available
  increasing separator pair.
- Parents are derived as the least earlier containing bag. The subtracted
  term is recomputed from the actual child-parent intersection.
- Junction arithmetic uses mathematical integers, with no truncated natural
  subtraction.
- The root term plus the four introduced-owner marginals must equal the
  directly computed junction value for every construction.
- Traversal order, construction keys, minimizer tie-breaking, JSON ordering,
  and terminal-LF serialization are deterministic.
- Validation rejects booleans, non-integers, nonpositive speeds, dimensions
  below three, and repeated speeds rather than coercing or deduplicating them.
- The seven synthetic fixtures cover success, equality failure, genuine
  junction overcount, strict modular endpoints and both cyclic sides,
  coincident labelled sets, malformed repeated input, and a deliberately
  wrong expected value.
- The full output contains no disputed expected minimum, minimizer count, or
  least minimizer. Those values must come from complete literal enumeration.
- The task is one literal layer only: no optimized dynamic program, pruning,
  symmetry reduction beyond the root normalization, extra tuple, Lean change,
  dependency change, or status promotion is authorized.
- A separately specified and reviewed independent checker remains mandatory
  before any finite-evidence promotion.

## Independent count and fixture checks

For seven owners, normalized owner orders number

```text
binom(7,3) * 4! = 35 * 24 = 840.
```

The available-pair counts are exactly `3,5,7,9`: the root contributes three
pairs, and every child contributes two new pairs containing its fresh owner.
Thus each pivot has

```text
840 * 3 * 5 * 7 * 9 = 793,800
```

constructions, and eight pivots have

```text
8 * 793,800 = 6,350,400.
```

The synthetic construction counts and junction expectations independently
reduce to:

| Fixture | Count | Exact union | Junction result |
| --- | ---: | ---: | ---: |
| One bag, three owners | 1 | 4 | `J=4<5` |
| Four disjoint singleton owners | 12 | 4 | every `J=4`; strict `J<4` is false |
| Four-owner pair incidence | 12 | 6 | every `J=7` |
| Five coincident labelled sets | 300 | 3 | every `J=3` |

The least keys stated for the four- and five-owner fixtures follow from the
frozen lexicographic traversal: identity `sigma`, followed first by separator
`(0,1)` at every available step.

An independent literal recomputation of the non-disputed modular columns
matches the contract exactly:

| `j` | `p` | `M` | `|R_j|` | union | gap | uncovered residues |
| ---: | ---: | ---: | ---: | ---: | ---: | --- |
| 0 | 1 | 9 | 8 | 8 | 0 | `[]` |
| 1 | 2 | 18 | 16 | 16 | 0 | `[]` |
| 2 | 5 | 45 | 40 | 40 | 0 | `[]` |
| 3 | 7 | 63 | 56 | 50 | 6 | `[8,20,22,41,43,55]` |
| 4 | 9 | 81 | 72 | 64 | 8 | `[10,21,26,28,53,55,60,71]` |
| 5 | 11 | 99 | 88 | 82 | 6 | `[26,35,37,62,64,73]` |
| 6 | 12 | 108 | 96 | 90 | 6 | `[26,28,38,70,80,82]` |
| 7 | 13 | 117 | 104 | 96 | 8 | `[28,37,41,44,73,76,80,89]` |

No candidate-tuple junction minimum was calculated or used by this review.

The candidate's frozen Prompt85 source hashes also match its declared worker
base:

| Input | SHA-256 |
| --- | --- |
| Prompt85 | `491e11edbb5fb88756f09f635f08203427035c3ab1eef62c4d18605d7e120255` |
| Response85 | `59196ec701c39ab56d8a945897b1719060c3a4070e132597a2f273aad6897722` |
| Response85 mathematical audit | `531959e5bc23541dfa867615e907cf429588b264088d7c76ed2e39918f5ade78` |

## Blocking defects and required corrections

### 1. The required privacy command is not executable

In the declared Ubuntu WSL runtime, `command -v rg` resolves to an application
binary exposed through the mounted Windows application directory. Executing
that path returns permission denied rather than the required grep-style exit
code `1`. The contract forbids installing or changing dependencies, so its
exact Level-2 command sequence cannot pass as written.

Required correction: freeze an executable Linux-native scanner already in the
declared runtime, such as `/usr/bin/grep -EIl`, or a Python-standard-library
scanner with exact match/no-match/error exit behavior. Verify the executable
path before relying on it. Preserve the rule that only matching filenames,
never matched secret values, may be retained.

### 2. `git diff --check` does not inspect the new deliverables

All four allowed deliverables are new untracked files at the worker base.
Plain `git diff --check` ignores untracked files, so the mandated command can
report success without inspecting any source or JSON output. The changed-file
inventory does not repair this whitespace-check gap.

Required correction: freeze an exact procedure that makes the four intended
paths visible to the diff check, for example an intent-to-add/staged check
with the index restored afterward, or an explicit per-file LF/CR/trailing-
whitespace validator. The correction must check all four retained tracked
deliverables and fail closed.

### 3. The retained source is not bound to every execution stage

The Medium approval file binds only the preflight JSON hash. The preflight
schema contains no source hash, and the contract permits routine source
repairs without explicitly requiring the preflight to be rerun. The manifest
records the source bytes present when the manifest is written, but does not
prove those same bytes produced the approved preflight and both full outputs.
The required commands also never create or identify a final commit containing
the four-file bundle, while the worker return asks for `Branch/commit` and the
future independent checker is expected to consume an immutable bundle.

Required correction:

1. include the source SHA-256 in the preflight report and Medium approval;
2. assert that exact source hash immediately before and after each full run
   and again before manifest creation;
3. require a new preflight and new approval after any source-byte change;
4. make manifest verification recheck the retained source, preflight, both
   full-run hashes, completion markers, and totals; and
5. specify whether Luna or the supervising Sol owner creates the exact final
   four-file commit, then pass that immutable commit SHA to
   `P85-LITERAL-REPLAY-CHECK-02`.

These changes bind provenance only. They must not alter enumeration,
minimization, fixture, boundary, or evidence semantics.

## Evidence and launch boundary

The candidate remains `MEDIUM-SPEC-REQUIRED`. It is **not `LUNA-READY`**.
Sol High must not create an approving launch record or start a Luna session
from the reviewed candidate commit.

After the three blockers are corrected, a second Medium lead must rereview the
new exact contract commit and blob hash. A later successful primary replay is
at most an `accepted implementation candidate; independent verification
pending`. It is not computed finite evidence until the separately contracted
checker independently reproduces all eight minima, least minimizers, counts,
and completion markers and Sol High accepts that review.

Nothing in this memo rejects `WIDTH-TWO-JUNCTION-COVER-DEFICIT`, proves or
disproves unrestricted LRC, accepts any disputed Prompt85 minimum, authorizes
an implementation, or changes an existing theorem or evidence label.
