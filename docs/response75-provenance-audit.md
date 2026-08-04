# Prompt75 recovery provenance audit

Task: `VER-P75-RECOVERY-PROVENANCE-185`

Audit base: `94442b430f4dbb9b66ec186e5655d556ee4e477e`

Recovery commit: `b40872423d9e6aac3610f058a859600126740365`

Audited branch: `research/p75-recovery-package-184`

## Verdict

**ACCEPTED for recovery provenance only.**

The recovery commit has the exact three-path inventory, the canonical response
is the exact CRLF-to-LF-only normalization of the ignored raw clipboard, and
the prompt, submitted-payload, completion, no-attachment, and public-scope
records agree. The only diff-check diagnostics are 13 single trailing spaces
already present in the immutable raw response. They are byte-preservation
exceptions, not formatting defects to repair.

This verdict does not accept Prompt75's top-level **MIXED** assessment, Section
6 **STOP** self-disposition, reconstructed mathematics, reported finite
computations, formal claims, or evidence labels. Independent mathematical
audit `VERIFY-P75-MATHEMATICAL-AUDIT-186` owns those questions. Unrestricted
LRC and every open bridge retain their prior status.

## Exact commit inventory

The recovery commit has the declared base as both parent and merge base. Its
entire change is:

```text
M  research/sol-pro/launches/prompt75-2026-08-03.md
A  research/sol-pro/responses/response75.md
M  research/sol-pro/session-log.md
```

No artifact directory, attachment, executable, screenshot, archive, browser
state, or fourth path was added.

## Ignored input inventory and strict Base64 replay

The ignored handoff contains exactly these Prompt75 inputs:

| Input | Bytes | SHA-256 |
| --- | ---: | --- |
| `tmp/p75-response.meta.json` | 584 | `00e98356006719fa6175bf31c0026d22424445a2ef352660d4a4313017f8bb14` |
| `tmp/p75-response.raw.b64` | 77,641 | `87bef282c9e1e7ab8fdc73d6fb83a145c209697a63a9f9d7c71ca20d8b52277e` |

Both are excluded by the repository's `/tmp/` rule. The Base64 transport has
1,009 LF-terminated lines: 1,008 lines of 76 characters and a final line of
24 characters. It contains no CR, space, tab, or non-Base64 character after
removing those wrapper LFs. The compact payload is 76,632 characters.

Direct strict decoding correctly rejects the line-wrapped transport because
strict mode admits no whitespace. Removing only the 1,009 transport LFs and
then decoding with strict alphabet and padding validation succeeds. Strict
UTF-8 decoding also succeeds. The decoded raw clipboard has:

| Property | Independently observed |
| --- | ---: |
| UTF-8 bytes | 57,473 |
| Unicode characters | 57,354 |
| CRLF pairs | 1,168 |
| Lone LF | 0 |
| Lone CR | 0 |
| Terminal CRLF | yes |
| SHA-256 | `e7e1a71f2964a3736c9f71542dff51fcfbb6adbc2f49bf3bb9e86fecd477419d` |

Every value agrees with the ignored metadata. That record identifies task
`OPS-P75-RECOVERY-PACKAGE-184`, Prompt75, terminal readback
`Worked for 61m 28s`, observation time
`2026-08-04T02:35:12.4203735Z`, an empty attachment array, and an explicit
recovery-only evidence boundary.

Replacing every raw CRLF pair by one LF, with no trimming, Unicode
normalization, or other transformation, produces bytes exactly equal to the
tracked response:

| Property | Canonical response |
| --- | ---: |
| Path | `research/sol-pro/responses/response75.md` |
| UTF-8 bytes | 56,305 |
| Unicode characters | 56,186 |
| LF separators | 1,168 |
| CR characters | 0 |
| Terminal LF | yes, exactly one |
| SHA-256 | `4fa46783c1e67477d56fc79f04a6b249c995aa2a095578852c2396f872fdd156` |

The 1,168-byte reduction is exactly one removed CR per separator.

## Immutable trailing-space exceptions

The canonical response has exactly 13 lines ending in whitespace. Each has
one trailing ASCII space and no tab, and each raw CRLF-delimited line has the
same byte before its line ending:

```text
416 443 749 790 879 926 980 992 994 996 1130 1131 1132
```

These are the complete `git diff <base> <recovery> --check` diagnostics. They
must remain limited to the immutable response. The launch record and session
log have no whitespace diagnostic.

## Prompt and launch linkage

The tracked `research/sol-pro/prompts/prompt75.md` independently has 22,156
UTF-8 bytes, 22,122 characters, 507 LF separators, no CR, terminal LF, and
SHA-256
`39e41e524fa3176f0ba504c165392e2f44d11d087356b25cbf51a859e4cb39b0`.

Removing only its terminal LF produces 22,155 bytes, 22,121 characters, 506 LF
separators, no terminal LF, and SHA-256
`02191a16956371c8c45537238cb63d46eafc271c0404efb6724dd59170f969e7`.
This exactly reproduces the submitted UI payload/readback recorded by the
pre-existing launch provenance.

The recovery edit preserves the original Sol High desktop owner, `/root`
authority, genuinely new signed-in ChatGPT conversation, Chat selection,
`GPT-5.6 Sol` family readback, Pro effort, and exact prompt reconciliation. It
adds only the terminal readback, response metrics, empty attachment inventory,
and pending-audit boundary. The launch record and session log agree.

## Runtime blob and attachment boundary

The response explicitly states at line 21 that the three exact Markdown blobs
were unavailable through its connected repository history or File Library,
their hashes and literal lines were not independently rechecked, and its
attribution is conditional. This audit confirms that the response contains
that limitation; it does not infer additional runtime access from reconstructed
claims.

The ignored metadata records `attachments_observed: []`. No Prompt75 artifact
path exists in the recovery diff, and the response does not claim it supplied
an attachment with this answer. Its statements that no attachment was executed
and that inspected artifacts were not executed are preserved as response text,
not promoted computation. This audit executed no response content, code,
attachment, verifier, or mathematical calculation.

## Privacy and public-path scope

The targeted scan covered all three recovery paths and the decoded raw bytes
for API keys, access tokens, bearer credentials, private keys, passwords,
cookies, session identifiers, connection strings, personal email addresses,
UUIDs, URLs, browser profiles, Windows user paths, WSL paths, Linux home paths,
and local conversation identifiers. It found no sensitive value or private
path. The only keyword matches were the launch record's explicit denial of
private browser/session data and ordinary mathematical TeX resembling a drive
prefix.

The public package contains no URL, screenshot, authentication artifact,
browser profile, private session identifier, or absolute machine path. The
ignored transport inputs remain excluded from Git.

## Evidence boundary

The recovery wording is fail-closed:

- **MIXED** and **STOP** are response self-assessments, not accepted statuses;
- reported `proved-math`, computed finite evidence, and rejected/conditional
  labels are not promoted by recovery;
- no response calculation or artifact was replayed;
- unavailable Response68--70 blob attribution remains conditional; and
- all mathematical and formal review is assigned to audit 186.

Recommended evidence label: `recovery-provenance-accepted`. It applies only to
the captured bytes, normalization, prompt/launch linkage, empty attachment
inventory, public-safety scope, and lifecycle metadata.

## Discrepancies

None. The 13 immutable trailing spaces are exact raw-response bytes and are
documented exceptions, not recovery discrepancies.

## Checks performed

Read-only checks included exact commit/merge-base and three-path inventory,
strict Base64 and UTF-8 decoding, in-memory newline normalization and byte
comparison, independent SHA-256 and shape recomputation, prompt payload
reconciliation, ignored-file inventory, attachment and runtime-limitation text
searches, targeted secret/privacy searches, and path-limited diff inspection.
No Lean build, verifier, response code, artifact, or mathematical proof was
executed.
