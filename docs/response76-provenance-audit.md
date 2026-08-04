# Prompt76 recovery provenance audit

Task: `OPS-P76-PROVENANCE-AUDIT-200`

Audit base and recovered package commit:
`8c82bd24a73bd44354db2ae4529caf2e03577929`

Audit scope: tracked recovery bytes, response normalization, hashes,
manifest bindings, JSON syntax, source/output hash references, launch and
session-log lifecycle records, and public-release privacy. Neither recovered
Python program was executed. This audit does not assess the mathematics or
promote any response-authored evidence label.

## Disposition

**QUALIFIED ACCEPT for tracked recovery provenance; one lifecycle timestamp
correction is required.**

The canonical response, prompt payload relation, five response-supplied
attachments, checksum manifest, and JSON syntax are byte-consistent. Every
claimed attachment hash matches. Replacing each LF in the tracked normalized
response by CRLF reproduces the declared raw-clipboard byte count, character
count, terminal convention, and SHA-256 exactly.

The launch record's local launch timestamp and its parenthesized UTC timestamp
do not denote the same instant. The discrepancy is `66.37 ms`; it must be
corrected or the UTC value must be explicitly labelled as a separate
observation. This does not invalidate the recovered response bytes, but the
paired timestamp claim is not exact as written.

The raw clipboard itself, browser UI, and attachment-download inventory are
not tracked. Their origin and completeness remain Sol High recovery
attestations. The exact normalization relation is independently reproducible;
the claim that the unattached source blob was the original clipboard cannot be
independently replayed from this checkout.

No theorem, counterexample, finite computation, Python execution, Lean result,
route disposition, or unrestricted Lonely Runner claim is accepted here.

## Inventory and byte audit

The response names exactly five attachments. The recovery directory contains
those five files plus its repository-authored `README.md`; there is no archive,
screenshot, paper, browser export, or additional payload.

| Tracked file | Bytes | Independently computed SHA-256 | Binding |
| --- | ---: | --- | --- |
| `p76_global_private_deficit_scan.py` | 33,260 | `844355ab056343f67f45ae3caa6094366e4aba8bc214b04d544299e7d68c499a` | response, README, manifest, and scan JSON metadata agree |
| `p76_global_private_deficit_scan.json` | 184,062 | `535bce9372e69a0478c4bc0870dde4938c8732fae8f4f0b6017692692c4f5fdc` | response, README, and manifest agree |
| `p76_global_private_deficit_replay.py` | 7,441 | `cddfd82eb4e67c82842b91c4539ab56bb35256d5944345be132b1ec34a3e58da` | response, README, manifest, and replay JSON metadata agree |
| `p76_global_private_deficit_replay.json` | 4,128 | `94fe0cacd26a7db6dfb4b20363cf157e9c312f31f9bb2c40b0947b633ebee66e` | response, README, and manifest agree |
| `p76_SHA256SUMS.txt` | 452 | `fa7bfdfc8feae4d1d4e0b5fc61d8984a8791a3ca6208a15825b8ff9851b215aa` | response and README agree; intentionally not self-listed |
| recovery `README.md` | 2,980 | `c768f9c202353823ad120bde1c992b53e0c5c4fc933c4d259e5b85ce3c4d73bb` | repository-authored metadata, not a recovered attachment |

The manifest has exactly four syntactically valid rows. After mapping each
`/mnt/data/<basename>` label to its basename, the names are unique, all four
source/output payloads occur exactly once, there are no missing or extra rows,
and every digest matches. The `/mnt/data` and `sandbox:/mnt/data` strings are
response sandbox provenance, not private host paths.

Both JSON files pass UTF-8 JSON parsing and a second parse that rejects exact
duplicate object keys. Their top-level schemas are respectively:

```text
p76-global-canonical-private-deficit-hall/v1
p76-global-private-deficit-independent-replay/v1
```

The scan JSON's `metadata.source_sha256` matches the tracked scan source. The
replay JSON's `metadata.source_sha256` matches the tracked replay source. This
binds each declared output to the named source bytes but does not establish
that either output was produced by executing that source. Static import review
finds only Python standard-library imports, and the replay source does not
import the scan implementation. No recovered program was run by this audit.

## Prompt and response transformation audit

The tracked prompt has the declared shape and hash:

```text
15,100 UTF-8 bytes
15,076 characters
350 LF separators
terminal LF
SHA-256 c86ea1ac96077169c37ff6f99caf618f9ee3eecdf55a5705da31dea1e44e5b79
```

Removing exactly that terminal LF produces:

```text
15,099 UTF-8 bytes
15,075 characters
349 LF separators
no terminal LF
SHA-256 6896a689d58ecad64258603196f4cef4813446d56fff5674c504a80b8378b5f6
```

This independently confirms the tracked-prompt to submitted-payload
transformation claim. Composer readback and actual submission remain UI
attestations rather than checkout-replayable facts.

The tracked normalized response independently measures as:

```text
39,521 UTF-8 bytes
39,515 characters
1,581 LF separators
zero CR
terminal LF
SHA-256 3566a99d3f00bfe481c2f99455e59de719e53e4477a4e4e6c5ccea2fe7c85d2d
```

Replacing every LF by CRLF, with no other transformation, produces:

```text
41,102 UTF-8 bytes
41,096 characters
1,581 CRLF separators
no lone LF or CR
terminal CRLF
SHA-256 ce0fc0670081ffcf3e1e9ac6551992569d34cc383502634cb921ef83696f5e11
```

Thus the two declared blobs are related exactly by CRLF-to-LF normalization.
Because only the normalized blob is tracked, this proves internal byte/hash
consistency rather than independent custody of the raw clipboard.

## Lifecycle consistency

Commit `9694789846f6e9e01dede7cb1cfe59e8bea5dcb7` first created the launch
record with lifecycle `active Sol Pro research`. Recovery commit `8c82bd2`
then changed it to `completed/recovered`, added the canonical response and
five attachments, and appended a matching recovery entry to
`research/sol-pro/session-log.md`. This history is monotone and does not infer
verification from launch or recovery.

The local launch value

```text
2026-08-03T21:43:05.5532034-05:00
```

converts to

```text
2026-08-04T02:43:05.5532034Z
```

not the recorded parenthesized value

```text
2026-08-04T02:43:05.6195734Z.
```

The latter is `66.37 ms` later. Correct one representation or label them as
distinct observations. The session log repeats only the local value and is
therefore consistent with that side of the launch record.

The response capture time is later than launch by `41m 13.4460719s`. The UI
work-duration readback is `37m 47s`, leaving `3m 26.4460719s` for launch,
rendering, and capture overhead. These values are chronologically possible;
the UI duration itself is not independently replayable. Git commit times also
place the launch commit after the launch observation and the recovery commit
after response capture.

The launch record, package README, and session log consistently say that the
response self-disposition, claimed tuple `(1,4,5,6,7,11)`, claimed values
`100` and `98`, bounded firstness, computation, and evidence labels are
unverified. The response's own stronger labels are preserved as source text
only.

## Privacy and release scan

A targeted filename-only scan covered the canonical response, launch record,
recovery README, manifest, both sources, and both JSON outputs. It found:

- no high-confidence API key, GitHub token, OpenAI key, AWS key, bearer token,
  database connection string, or private-key marker;
- no personal email address;
- no Windows user path, `/home/<user>` path, macOS user path, WSL UNC path,
  Codex profile path, browser profile, cookie, or authentication artifact;
- no session, thread, or private conversation identifier; and
- no screenshot, browser export, third-party paper, archive, cache, or build
  output.

The only absolute-looking paths are the inert `/mnt/data` sandbox labels and
the Python shebang `/usr/bin/env python3`. Repository-relative paths are
public-safe. The phrase “session identifier” in the README is a denial that
one is present, not an identifier. No secret value was printed during the
scan.

## Required correction and evidence boundary

Before calling the lifecycle record exact, make one documentation-only
correction:

```text
either replace 2026-08-04T02:43:05.6195734Z with
2026-08-04T02:43:05.5532034Z,
or explicitly label the two values as separate observations.
```

Recommended disposition:

```text
tracked recovery bytes and hash bindings: ACCEPT
raw-normalization relation: ACCEPT
raw clipboard/browser custody: externally attested, not replayable
launch lifecycle timestamp pair: CORRECTION REQUIRED
artifact execution or computed evidence: NOT AUDITED / NOT ACCEPTED
mathematical claims and response disposition: NOT AUDITED / NOT PROMOTED
unrestricted LRC: OPEN
```
