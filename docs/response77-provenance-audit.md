# Prompt77 recovery provenance audit

Task: `OPS-P77-PROVENANCE-AUDIT-205`

Audit base and recovered package commit:
`9789f1dd457f0084838dfe72c5aa5168d33e278b`

Scope: committed recovery bytes, raw/normalized response relation, five
response-authored hashes, strict JSON and JSONL syntax, JSONL inventory and
ordering, summary/source bindings, launch and session-log lifecycle, the
declared `git diff --check` exception, and public-release privacy. Neither
recovered Python source was imported or executed.

## Disposition

**QUALIFIED ACCEPT for tracked recovery provenance; one launch timestamp
correction is required.**

All five response-authored hashes match the exact Git blobs. The two JSON
documents and all 6,330 JSONL records parse with exact duplicate-key
rejection. The JSONL record count, dimension counts, endpoints, order, and
summary bindings agree. Prompt terminal-LF removal and response CRLF-to-LF
normalization reproduce every declared byte, character, separator, and hash
value.

The launch record's local launch timestamp and parenthesized UTC timestamp
are not the same instant. They differ by `43.0488 ms`. Correct the UTC value or
label it as a separate observation. The documented `git diff --check`
exception is accurate and is not a merge-state defect: immutable response
line 688 is exactly `=======` inside a displayed equation, while every other
recovery path passes the scoped check.

The raw clipboard, browser UI, and attachment downloads are not tracked.
Their source custody and completeness remain Sol High attestations. The
tracked bytes and transformations are reproducible, but the browser-origin
claims cannot be independently replayed from the checkout.

This audit accepts no Python execution, certificate semantics, bounded search,
counterexample, mathematical claim, response disposition, evidence label,
Lean result, or unrestricted Lonely Runner result.

## Authoritative byte inventory

All sizes and hashes below were computed from the blobs at the audited commit,
not from checkout files. This distinction matters on this machine because
`core.autocrlf=true`: the Windows worktree converts the 6,330-line JSONL to
CRLF, while the authoritative Git blob has LF only.

| Response-authored file | Git-blob bytes | Independently computed SHA-256 | Binding |
| --- | ---: | --- | --- |
| `prompt77_exact_search.py` | 14,085 | `c416c9fcc192b57d038801f32342b7ad1a48d6e641f3aa47dc40590872bbec51` | response, README, and summary agree |
| `prompt77_search_summary.json` | 1,888 | `8cb881ec154faa556cdf6c92693f7f680dfc15f582c3cab2b1ee9bb8ef2c3ad0` | response and README agree |
| `prompt77_search_certificates.jsonl` | 3,677,569 | `0a00e2f1ff08ddcf726dfb777e2d0edd823d299d14d01e95862ac2c1b5c16010` | response, README, and summary agree |
| `prompt77_counterexample_verify.py` | 6,556 | `6d48456ccfee6323371beb4f8c4a46b89de3e228fa12e1bd5c7784aa83f3971c` | response, README, and counterexample certificate agree |
| `prompt77_counterexample_certificate.json` | 3,026 | `c9713f16644acb1f562823b93135cd1d12fbc3f3350c4c8fa3d4ca09723b72d9` | response and README agree |

The repository-authored recovery `README.md` is 3,345 Git-blob bytes with
SHA-256
`9e75f01007864eae291d38464ad59513a8d58e23e90e902ebc9e012c4737a72e`.
It is package metadata, not a sixth recovered attachment. The response links
exactly the five files in the table, consistent with the tracked inventory.
The claim that no additional browser attachment existed remains a recovery
attestation because browser download state is not preserved.

## Strict JSON and JSONL audit

An independent data-only parser rejected exact duplicate keys at every object
level. It parsed:

- `prompt77_search_summary.json` with schema
  `prompt77-exact-search-summary-v1`;
- `prompt77_counterexample_certificate.json` with schema
  `prompt77-counterexample-certificate-v1`; and
- all 6,330 nonblank JSONL records.

The authoritative JSONL blob has:

```text
3,677,569 bytes
6,330 LF separators
zero CR bytes
terminal LF
6,330 physical lines
zero blank lines
6,330 unique (n, tuple) keys
```

Its `(n, tuple)` keys are strictly increasing. Every record's `n` equals its
tuple length. The independently counted domain is:

| `n` | Records |
| ---: | ---: |
| 2 | 63 |
| 3 | 325 |
| 4 | 965 |
| 5 | 1,981 |
| 6 | 2,996 |
| **Total** | **6,330** |

The first key is `(2,[1,2])`; the last is
`(6,[9,10,11,12,13,14])`. These values match the recovery README and search
summary. This is an inventory/order audit, not validation of any Rayleigh
interval or certificate calculation.

The summary's `source_sha256` equals the exact-search source hash, and its
`certificate_sha256` equals the canonical JSONL Git-blob hash. Its
`total_certified_tuples`, `counts_by_n`, domain bounds, and `first_failure=null`
match the parsed structure. The counterexample certificate's `source_sha256`
equals the verifier-source hash. Static source inspection confirms that each
program computes and embeds the corresponding source hash; the search source
uses NumPy as declared, while the verifier does not import the search source.
These byte bindings do not prove that the outputs were generated by those
programs or that their calculations are correct.

## Prompt and response transformations

The tracked prompt Git blob independently measures as:

```text
13,232 UTF-8 bytes
13,212 characters
267 LF separators
zero CR
terminal LF
SHA-256 2be2073c6f476d3d0d570cc36ee8be3d4a16d100fb1fbc72180afb568b0a1527
```

Removing exactly its terminal LF produces:

```text
13,231 UTF-8 bytes
13,211 characters
266 LF separators
no terminal LF
SHA-256 3ce793e7269be86e9505840e705717282103c8f6f0b51edc3a332bafd8bddaa0
```

This verifies the tracked-prompt to submitted-payload byte relation. Composer
readback and actual browser submission remain UI attestations.

The canonical response Git blob independently measures as:

```text
26,012 UTF-8 bytes
26,005 characters
1,332 LF separators
zero CR
terminal LF
SHA-256 c758c5e8759e2b61cb5fc15e4c056e85b9c3551480660006f349944ee72f8835
```

Replacing every LF by CRLF and making no other change produces:

```text
27,344 UTF-8 bytes
27,337 characters
1,332 CRLF separators
no lone LF or CR
terminal CRLF
SHA-256 61931350e89dc5757628d94d29e5cd1d42cbbaf0290d295e4fc168b697bfafa4
```

The declared raw and normalized blobs are therefore related exactly by
CRLF-to-LF normalization. Because only the normalized response is committed,
this establishes internal byte/hash consistency rather than independent
custody of the original clipboard.

## Recovery exception and lifecycle

The recovery README accurately records the only full-diff exception:

```text
research/sol-pro/responses/response77.md:688: leftover conflict marker
```

At that exact immutable line the complete content is `=======`, between
`\beta_d` and the following displayed formula. The line is response-authored
mathematical formatting, not evidence of an unresolved Git merge. Running
`git diff --check` over recovery commit `9789f1d` while excluding only the
canonical response exits successfully. No other changed path has a whitespace
or conflict-marker diagnostic. The response must not be edited merely to
silence this recovery-preservation exception.

Commit `9694789846f6e9e01dede7cb1cfe59e8bea5dcb7` created the launch record
at lifecycle `active Sol Pro research`. Commit `9789f1d` changed it to
`completed/recovered`, added the response and five attachments, and appended a
matching recovery record to `research/sol-pro/session-log.md`. This transition
is monotone and does not infer verification from recovery.

The local launch timestamp

```text
2026-08-03T21:46:33.9518423-05:00
```

converts exactly to

```text
2026-08-04T02:46:33.9518423Z,
```

not the launch record's parenthesized

```text
2026-08-04T02:46:33.9948911Z.
```

The recorded UTC value is `43.0488 ms` later. Correct one value or explicitly
label them as separate observations. The session log repeats only the local
timestamp and is consistent with that side of the launch record.

Capture occurred `1h 3m 54.9045696s` after launch. The UI work-duration
readback is `36m 32s`, leaving `27m 22.9045696s` for queueing, UI rendering,
large-attachment saving, and capture. This is chronologically possible, and
the direct-browser-save note supplies a plausible recovery stage, but neither
the UI duration nor download sequence is independently replayable. Git history
places the launch commit after launch and the recovery commit after capture.

The launch record, package README, and session log consistently preserve the
response's **STOP** disposition, tuple `(6,7,168)`, block dispositions,
`G=(0,0,126)`, and 6,330-record claim without accepting them.

## Privacy and release scan

A targeted filename-only scan covered the response, launch record, recovery
README, both sources, both JSON documents, and the entire JSONL. It found:

- no high-confidence API key, GitHub token, OpenAI key, AWS key, bearer token,
  database connection string, private-key marker, or credential field;
- no personal email address;
- no Windows user path, `/home/<user>` path, macOS user path, WSL UNC path,
  Codex profile path, browser profile, cookie, or authentication artifact;
- no session, thread, or private conversation identifier; and
- no screenshot, browser export, third-party paper, archive, cache, build
  directory, or oversized uncontrolled output beyond the declared JSONL.

The only response absolute-path strings are five inert
`sandbox:/mnt/data/<filename>` attachment links. Source shebangs and computed
`__file__` use contain no machine-specific literal. No secret value was
printed during the scan.

## Required correction and evidence boundary

Before calling the lifecycle record exact, make this documentation-only
correction:

```text
either replace 2026-08-04T02:46:33.9948911Z with
2026-08-04T02:46:33.9518423Z,
or label the two values as distinct observations.
```

Recommended disposition:

```text
tracked recovery blobs and five hashes: ACCEPT
strict JSON/JSONL syntax, count, and ordering: ACCEPT as provenance structure
summary and source-byte bindings: ACCEPT
raw-normalization relation: ACCEPT
raw clipboard/browser/download custody: externally attested, not replayable
response line-688 diff-check exception: ACCEPT as exact immutable source
launch local/UTC timestamp pair: CORRECTION REQUIRED
Python execution and computed finite evidence: NOT AUDITED / NOT ACCEPTED
mathematical claims and response disposition: NOT AUDITED / NOT PROMOTED
unrestricted LRC: OPEN
```
