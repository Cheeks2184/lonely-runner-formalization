# Prompt74 recovery provenance audit

Task: `VER-P74-RECOVERY-PROVENANCE-173`

Audit base: `5b426830263ba49674a7178ff371877200f123bc`

Recovery commit: `967cabe9d0a94c2504e36e10473ef5eccef87adc`

Audited branch: `research/p74-recovery-package-172`

## Verdict

**ACCEPTED for recovery provenance only.**

The recovery commit contains exactly the intended three-path change, the
canonical response is an exact CRLF-to-LF-only normalization of the trusted
raw clipboard, launch provenance remains linked to the tracked Prompt74
payload, and no Prompt74 attachment is present or claimed. No sensitive
material was detected by the targeted changed-path scan.

This verdict does not accept the response's self-disposition **STOP**, the
claimed common-scaling counterexample, any displayed finite computation, or
any mathematical status. Those claims remain unverified pending independent
mathematical audit 174. The signed-Gram lemma, exact pivot selector,
positive-integer LRC, and unrestricted LRC retain their prior statuses.

## Exact commit inventory

`git diff-tree --no-commit-id --name-status -r 967cabe...` reports exactly:

```text
M  research/sol-pro/launches/prompt74-2026-08-03.md
A  research/sol-pro/responses/response74.md
M  research/sol-pro/session-log.md
```

The merge base with the declared authoritative base is exactly
`5b426830263ba49674a7178ff371877200f123bc`. No artifact directory, executable,
certificate, screenshot, or other path was added.

## Raw clipboard replay

The ignored trusted inputs were independently decoded and inspected without
writing them into the repository. The raw payload agrees with its trusted
metadata in every recorded field:

| Property | Independently observed |
| --- | ---: |
| UTF-8 bytes | 20,483 |
| Unicode characters | 20,483 |
| CRLF pairs | 852 |
| Lone LF | 0 |
| Lone CR | 0 |
| Terminal CRLF | yes |
| SHA-256 | `68a0e350b8a04c1fb03aa11b8db8ced35cdfe4e7c161dfaf37c2e474a9c645f6` |
| Trusted observation time | `2026-08-04T01:50:40.9759997Z` |

Strict UTF-8 decoding succeeded. Replacing every CRLF pair by one LF produced
bytes exactly equal to the tracked response, with no trimming, Unicode
normalization, or other transformation:

| Property | Canonical response |
| --- | ---: |
| Path | `research/sol-pro/responses/response74.md` |
| UTF-8 bytes | 19,631 |
| Unicode characters | 19,631 |
| LF separators | 852 |
| CR characters | 0 |
| Terminal LF | yes |
| SHA-256 | `dbe3073cbc6b25f890feec995ffa3baa369e65175721d01c4e33e1b5d3f5e94d` |

Replacing those 852 LF bytes by CRLF reconstructs the exact trusted raw byte
count, character count, newline shape, and SHA-256.

## Launch linkage

The pre-existing launch record identifies the sole owner as the GPT-5.6 Sol
High top-level desktop orchestrator and records a genuinely new signed-in
ChatGPT conversation with Chat, `GPT-5.6 Sol`, Pro, and exact prompt readback.
The recovery edit changes only the terminal lifecycle portion and preserves
those launch facts.

The tracked `research/sol-pro/prompts/prompt74.md` independently has:

- 15,030 UTF-8 bytes;
- 15,010 characters;
- 343 LF separators and no CR;
- terminal LF; and
- SHA-256
  `1b4eb2ec7642522711be1b00b87b7cd17cc04635d499783e335eae1b21977b24`.

Removing only its terminal LF produces 15,029 bytes and SHA-256
`b63df8588f6bc76d2bd889d6fb87b2429ce30e4a3ff11362c8f51109d27fcba0`,
exactly matching the submitted UI payload/readback recorded at launch.

The terminal recovery fields consistently record `Worked for 36m 54s`, the
trusted observation time, both response hashes and shapes, no attachments,
and the pending audit boundary. The launch record and session-log entry agree.

## No-attachment audit

The ignored Prompt74 input inventory contains only the raw-response base64
payload and its metadata. The recovery commit contains no
`research/sol-pro/artifacts/prompt74/` path. The response itself states that no
optional source, machine-readable output, or Lean prototype was created.
Together with the trusted handoff's explicit no-attachments fact, this
supports the public `Attachments: none` record.

No code or mathematical calculation was executed during this audit.

## Privacy and hygiene

The targeted scan covered the exact three recovery paths for common API-key,
access-token, bearer credential, private-key, password, cookie, session-ID,
connection-string, personal-email, UUID, Windows-user-path, WSL-path, and
Linux-home-path patterns. It found no match. A separate search found no URL,
local filesystem path, sandbox path, or attachment link in the recovered
response. The launch record contains only generic browser/session wording and
explicitly excludes private identifiers.

`git diff <base> <recovery> --check` passes with no whitespace or conflict
marker diagnostic.

## Evidence boundary

The recovery lifecycle text is fail-closed and consistent:

- the response's **STOP** is identified as a self-disposition and is not
  accepted;
- the common-scaling cancellation and counterexample are not promoted;
- no fixture, histogram, matrix, or finite result is promoted;
- the signed-Gram gap and all LRC statements retain their previous status;
  and
- mathematical review is explicitly deferred to audit 174.

Recommended evidence label:
`recovery-provenance-accepted`. This label applies only to the response bytes,
normalization, launch linkage, no-attachment inventory, and recovery metadata.
It is not a mathematical or computational evidence label.

## Discrepancies

None.

## Commands used

Read-only checks included:

```text
git show --stat --oneline <recovery>
git diff-tree --no-commit-id --name-status -r <recovery>
git merge-base <recovery> <base>
git diff <base> <recovery> -- <launch record>
git diff <base> <recovery> --check
git ls-tree -r --name-only <recovery>
Get-FileHash -Algorithm SHA256 <tracked paths>
```

Raw and normalized shapes were recomputed with strict UTF-8 decoding and
in-memory byte comparison. Targeted privacy searches were performed over the
exact changed-path inventory.
