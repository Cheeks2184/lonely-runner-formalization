# Prompt72 recovered artifact package

This directory preserves the complete two-file attachment inventory supplied
by `/root` from the completed Prompt72 GPT-5.6 Sol Pro turn. Recovery preserves
bytes and provenance only. Neither attachment was executed during recovery,
and neither its claims, results, nor evidence labels are independently
accepted.

| Canonical recovered file | Bytes | SHA-256 |
| --- | ---: | --- |
| `modular_cover_circuit_scan.py` | 21,659 | `6440b7877e5218049b99780e40e1d2a94dc8ac376d4983a3c2d330a36be9fde2` |
| `modular_cover_circuit_scan.json` | 51,311 | `582d3d5b0a31622241dbbd60836274b232737dd76a68043fa86d8ba1e35c5f62` |

The response text declares both attachment hashes, and they match the
canonical recovered bytes. The JSON parses as one object with root keys
`fixture_checks`, `fixtures`, `frozen_scan`, `general_regressions`, and
`metadata`. It contains no source-hash binding field, so no JSON-to-source
binding is claimed. These checks establish recovery fidelity only; the script
was not executed and the JSON's fixtures, regression results, 2,429-tuple
scan, and evidence labels were not replayed or accepted.

The ignored attachment `.b64` transport copies supplied for packaging contain
literal UI truncation markers and were rejected as noncanonical inputs. The
canonical bytes were instead recovered from the original local download files
identified by the supplied attachment metadata; both exact byte lengths and
SHA-256 hashes match that metadata. No original download name or local path is
recorded in the public package.

There is no archive and there were no other UI attachments. The files contain
no recovered executable binary, browser state, screenshot, paper, credential,
private local path, or personal identifier detected by the recovery scan.
Generic `/mnt/data` paths embedded in the JSON's recorded command and the
response's historical sandbox links are inert provenance text, not private
paths or commands run during recovery.

The canonical response is
`research/sol-pro/responses/response72.md`: 24,062 UTF-8 bytes; 24,052
characters; 707 LF separators; terminal LF present; SHA-256
`1bd95673813274756e246ede8596099c554a31b57cdc9665e65bdabff2b7a0ec`.
It is the exact CRLF-to-LF normalization of the input-only raw clipboard:
24,769 UTF-8 bytes; 24,759 characters; 707 CRLF separators; no lone LF or
lone CR; terminal CRLF present; SHA-256
`b9668dc0955a25fb640a0fa63052ec96f640eca4e0b79911a6ad67cf093475e6`.
No trimming, Unicode normalization, or other byte change was performed.

The canonical response contains the standalone line `=======` at line 472,
inside its displayed singleton-rank equation. That exact line is present in
the raw clipboard and has no paired `<<<<<<<` or `>>>>>>>` marker. Git
therefore reports a false-positive `leftover conflict marker` for this one
immutable response line. Recovery whitelists only that exact path and line;
all other changed-file whitespace checks must pass.

The response self-disposition is **STOP** and is not accepted by recovery.
Every claimed mathematical theorem and finite result remains unverified
pending independent audits. `MODULAR-COVER-CIRCUIT-ESCAPE`, the exact pivot
selector, positive-integer LRC, and unrestricted LRC remain open. This package
adds no Lean theorem and promotes no mathematical or computational claim.

The frozen downstream audit identifiers are:

- `VER-P72-RECOVERY-PROVENANCE-167`;
- `VERIFY-P72-MATHEMATICAL-AUDIT-168`; and
- `VERIFY-P72-ARTIFACT-AUDIT-169`.

The artifact audit remains `MEDIUM-SPEC-REQUIRED` until its exact replay and
semantic-audit contract is frozen. Prompt68's separately assigned artifact
audit identifier is not reused by this package.
