# Response 72 recovery and provenance audit

## Disposition

**ACCEPT** the Prompt72 recovery package at corrected tip
`ea9f129851c2dc1b424abe15cea2fefc496eb895`, with recovery parent
`79c7d8937d88ef8c26e11ea5d36f3dc0adafd585`, for byte preservation,
inventory, lifecycle documentation, and public-safety scope only.

This acceptance does **not** accept the response's self-disposition, execute or
validate either attachment, accept the JSON's reported results, audit any
mathematics, or promote any evidence label. The JSON has no embedded hash of
the Python source, so the two recovered files are not intrinsically
source-bound. Artifact audit 169 remains `MEDIUM-SPEC-REQUIRED`.

The audit used the original local downloads selected by the root-supplied
attachment metadata. Their original download names and local paths are
intentionally omitted from this public document.

## Commit and path scope

The recovery commit has parent
`35f23f59157762f8978bbdbd93f05ae4001c1330` and changes exactly six paths:

1. `research/sol-pro/artifacts/prompt72/README.md` — added;
2. `research/sol-pro/artifacts/prompt72/modular_cover_circuit_scan.json` —
   added;
3. `research/sol-pro/artifacts/prompt72/modular_cover_circuit_scan.py` — added;
4. `research/sol-pro/launches/prompt72-2026-08-03.md` — updated;
5. `research/sol-pro/responses/response72.md` — added; and
6. `research/sol-pro/session-log.md` — updated.

The correction commit changes only the package README, launch record, and
session log from that six-path set. It adds the corrected downstream audit IDs
and does not modify the response or either attachment. The combined recovery
range introduces no seventh path, archive, nested repository, executable
binary, screenshot, browser state, or paper.

## Raw response normalization

The input-only raw clipboard decodes as valid UTF-8 with the following exact
shape:

| Property | Independently observed |
| --- | ---: |
| Bytes | 24,769 |
| Unicode characters | 24,759 |
| CRLF separators | 707 |
| Lone LF separators | 0 |
| Lone CR separators | 0 |
| Terminal CRLF | yes |
| SHA-256 | `b9668dc0955a25fb640a0fa63052ec96f640eca4e0b79911a6ad67cf093475e6` |

Replacing each CRLF by one LF, with no trimming or other transformation,
produces bytes exactly equal to the tracked canonical response:

| Property | Independently observed |
| --- | ---: |
| Bytes | 24,062 |
| Unicode characters | 24,052 |
| LF separators | 707 |
| CR bytes | 0 |
| Terminal LF | yes |
| SHA-256 | `1bd95673813274756e246ede8596099c554a31b57cdc9665e65bdabff2b7a0ec` |

The normalized byte arrays compare equal, not merely equal after a second text
conversion. The 707-byte size reduction is exactly the removal of one CR from
each of 707 CRLF separators. This verifies the package claim that normalization
was LF-only.

## Attachment inventory and byte identity

The root-supplied inventory identifies exactly two attachments. Each
metadata-designated original download was present, and each is byte-for-byte
identical to its canonical tracked counterpart:

| Canonical recovered file | Metadata bytes | Original bytes | Tracked bytes | SHA-256 | Exact byte comparison |
| --- | ---: | ---: | ---: | --- | --- |
| `modular_cover_circuit_scan.py` | 21,659 | 21,659 | 21,659 | `6440b7877e5218049b99780e40e1d2a94dc8ac376d4983a3c2d330a36be9fde2` | pass |
| `modular_cover_circuit_scan.json` | 51,311 | 51,311 | 51,311 | `582d3d5b0a31622241dbbd60836274b232737dd76a68043fa86d8ba1e35c5f62` | pass |

Both hashes also match the values printed in the recovered response. No third
attachment is present in the supplied inventory. This verifies fidelity to the
supplied inventory; it is not an independent reconstruction of the original
browser UI.

Two ignored transport captures were also checked without using them as
canonical inputs. Each contains a literal truncation marker and neither is a
complete valid Base64 payload. Rejecting those transports and using the
metadata-designated original downloads was therefore correct.

The attachment metadata's observation-time field is not promoted by this
audit: its key says UTC while its value carries a nonzero offset. No public
package statement depends on that field, and attachment identity is established
by exact bytes and hashes instead.

## JSON parse and source-binding boundary

The tracked JSON parses successfully under a case-sensitive JSON parser as one
object with root keys:

```text
fixture_checks
fixtures
frozen_scan
general_regressions
metadata
```

Its metadata object has keys:

```text
implementation
integer_arithmetic
language
platform
python_version
schema
script_argv
```

There is no `source_sha256`, `script_sha256`, source-hash object, or other
embedded 64-hex digest. Fields whose names contain the ordinary mathematical
word `source`, such as a source pivot or source equation, are not provenance
bindings. `script_argv` records a command line but does not bind the JSON to
the tracked source bytes.

Therefore the README is accurate to say that the JSON contains no source-hash
binding and that none is claimed. A future artifact audit must bind the exact
source hash externally before executing a replay and comparing outputs.

Windows PowerShell's legacy `ConvertFrom-Json` rejects this JSON because it
treats case-distinct keys such as `n` and `N` as duplicates. That is a parser
limitation rather than invalid JSON; a standards-conforming case-sensitive
parser succeeds. Reproducibility instructions should use a case-sensitive
parser.

## Prompt and launch-completion consistency

The tracked Prompt72 contract independently reproduces the launch record:

| Property | Tracked prompt | Submitted payload |
| --- | ---: | ---: |
| UTF-8 bytes | 15,306 | 15,305 |
| Unicode characters | 15,286 | 15,285 |
| LF separators | 344 | 343 after terminal-LF omission |
| Terminal LF | yes | no |
| SHA-256 | `171ced8399d060c11817ff441b6cc9e0df5c3dd5b26db572f854b9a1947a8d7d` | `c509b53e235eaef1a5d13af65087a104c886c414dcfa4593edca027f7fe407fc` |

Removing only the tracked prompt's terminal LF produces the exact submitted
payload hash. The launch document correctly changes the earlier active state
to completed/recovered, records the root-supplied terminal UI readback, and
uses the raw-response observation time supplied with the clipboard metadata.
The terminal-duration readback is an operational Sol High observation; it is
not derivable from response bytes and is accepted only at that provenance
scope.

The lifecycle record continues to say that mathematical and artifact audits
are pending and that no theorem or finite result is accepted. It does not turn
completion or recovery into mathematical evidence.

## Immutable conflict-marker exception

The canonical response contains exactly one line matching Git's leftover
conflict-marker check:

```text
line 472: =======
```

The raw clipboard contains the same standalone line at the same line number.
Neither raw nor canonical response contains a `<<<<<<<` or `>>>>>>>` line.
The line occurs inside the response's displayed singleton-rank equation and is
immutable recovered content, not an unresolved merge conflict.

Across the full six-path recovery range, `git diff --check` reports only this
one exception. The README's path-and-line-specific whitelist is therefore
accurate. The exception must remain limited to this immutable response line;
it does not justify suppressing conflict-marker checks elsewhere.

## Execution and evidence boundary

This audit read and hashed both attachment files and parsed the JSON as data.
It did not import, invoke, or execute the Python attachment and did not run its
recorded command. No tracked file claims that recovery replayed the script; the
README, launch record, and session log consistently state the opposite.

The historical claim that recovery did not execute the script is necessarily
an operational provenance statement rather than a fact derivable from file
bytes. It is consistent with the root-supplied record and with the absence of
any tracked replay promotion or execution-produced evidence. Acceptance is
limited accordingly: this audit verifies that the package makes no execution
or result-validation claim and independently confirms that this audit itself
performed none.

Response72's `STOP`, every asserted theorem, the fixture records, regression
outputs, the 2,429-tuple scan, and the zero-closed-subset result remain
unverified. The recovered files are evidence candidates only.

## Privacy and public-release audit

Automated targeted scans and manual inspection of all six changed paths found
no API key, access token, cookie, credential, private key, connection string,
email address, personal identifier, browser profile, conversation identifier,
or private machine path.

The JSON's recorded command and the response's historical attachment links use
generic `/mnt/data` sandbox paths. These do not identify the local machine and
are inert text. The package does not publish the original download names or
locations. No screenshot, authentication artifact, archive, generated binary,
or third-party paper is included.

The files are modest in size and appropriate for source control. The Python
file is executable source in the ordinary sense, but its presence is not a
claim that it was run or verified.

## Corrected downstream identifiers

The corrected tip records exactly these Prompt72 downstream tasks in the
README, launch record, and session log:

- `VER-P72-RECOVERY-PROVENANCE-167`;
- `VERIFY-P72-MATHEMATICAL-AUDIT-168`; and
- `VERIFY-P72-ARTIFACT-AUDIT-169`.

No other Prompt72 audit ID appears in those lifecycle records. Audit 169 is
consistently marked `MEDIUM-SPEC-REQUIRED`; no Luna task is admitted and no
artifact result is accepted.

## Acceptance ledger

| Obligation | Result | Evidence scope |
| --- | --- | --- |
| Recovery/correction commit ancestry | pass | Exact commit parents inspected |
| Six-path recovery scope | pass | Exact combined diff inventory |
| Raw clipboard metadata | pass | Bytes, characters, separators, terminal state, and hash reproduced |
| Raw-to-canonical normalization | pass | Exact byte equality after CRLF-to-LF only |
| Two-attachment inventory | pass | Root-supplied inventory; no browser-UI reconstruction claimed |
| Original-to-tracked attachment identity | pass | Exact byte, size, and SHA-256 comparisons |
| Truncated transport rejection | pass | Markers present; payloads incomplete |
| JSON parse | pass with parser note | Case-sensitive parser required |
| JSON embedded source binding | absent, accurately disclosed | Artifact replay must bind externally |
| Prompt/payload binding | pass | Terminal-LF omission reproduces submitted hash |
| Launch completion update | pass at operational provenance scope | Root-supplied terminal readback and raw observation record |
| Immutable `=======` exception | pass | Exact raw/canonical line; sole diff-check finding |
| No-execution claim | pass at stated provenance scope | No execution performed by this audit; no replay claimed by package |
| Privacy/public safety | pass | Automated targeted and manual six-path scan |
| Correct IDs 167/168/169 | pass | Exact unique Prompt72 IDs in all three lifecycle records |
| Mathematical/computational acceptance | not performed | Remains open/unverified |

Final disposition: **ACCEPT recovery provenance only**. This document does not
authorize artifact execution, mathematical promotion, merge, or push.
