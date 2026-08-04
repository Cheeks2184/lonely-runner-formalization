# Prompt86 recovery provenance

This directory records the public-safe recovery boundary for the completed
Prompt86 Sol Pro response and its five attachments. The attachments are
preserved byte-for-byte under `quarantine/` because the repository permits
tracked research sources and outputs, but they are untrusted evidence. No
attachment was executed, imported, evaluated, replayed, or used to derive a
mathematical conclusion during recovery.

## Exact response provenance

The immutable decoded raw capture has SHA-256
`932681932ef64767f0c51d00740158474459c1cba59cba95dd79d4fdedb9810d`:
40,509 UTF-8 bytes, 40,483 characters, 1,569 CRLF separators, no lone LF or
CR, and a terminal CRLF. Strict UTF-8 decoding found no NUL or replacement
character.

The tracked response at `research/sol-pro/responses/response86.md` is exactly
that capture with CRLF normalized to LF and no other content change. It has
SHA-256
`4b977eed0879be8508f1354daaf7db914c254c229e507af3b1b25f8cc52449fa`:
38,940 UTF-8 bytes, 38,914 characters, 1,569 LF separators, no CR, and a
terminal LF. Re-expanding every LF to CRLF reproduces the immutable raw
capture byte-for-byte.

## Prompt and launch binding

The public launch record is
`research/sol-pro/launches/prompt86-2026-08-04.md`. It binds the tracked
prompt `research/sol-pro/prompts/prompt86.md` at integrated commit
`5ee9a0a62b7709ee1ca6c48d81143f14e016888f` and SHA-256
`49135b31319081b732a26fa24ec6154c63c3e2543e6995637d2e2e0b11cc7f77`.
No private conversation, browser-session, account, or machine identifier is
included in this package.

The response contains exactly five original `sandbox:/mnt/data/...`
attachment references. They map by basename to the five files in
`quarantine/`. The recovery manifest records every path, byte size, and
SHA-256. The four source/output hashes independently match both the response
table and the supplied `p86_manifest.txt`; the supplied manifest's own hash
is also frozen. Hash agreement proves attachment identity only. It does not
verify their implementation, output, claimed execution, or agreement.

## Quarantine and evidence boundary

The response self-disposition is **PIVOT**. Recovery preserves but does not
accept its algebra, fixture rows, checker descriptions, claimed dual-verifier
agreement over 56,762 tuples, absence-of-failure claim, conditional Lean
chain, or proposed universal selector.

In particular:

- the claimed 56,762-tuple computation is **UNVERIFIED / QUARANTINED**;
- the inequality `S_j >= h_(j,0) - E_j/(2N+1)` is response-authored and
  unverified pending independent mathematical audit; and
- `I_j-|R_j| < 2N*h_(j,0)` for some pivot remains an **OPEN** universal
  selector.

No theorem, counterexample, computation, Lean result, bridge, or LRC status
is promoted by this recovery package. Unrestricted Lonely Runner remains
open.

A targeted credential, private-key, token, email, private-path, and
browser/session-data scan found no sensitive artifact. A deliberately broad
Windows drive expression matched six TeX fragments (`a:\\` three times and
`j:\\` three times) in the immutable response; they are mathematical
notation, not filesystem paths. No response or attachment byte was changed
to silence the scan.

Staged `git diff --check` reports exactly five immutable response lines—574,
678, 878, 911, and 920—whose complete content is seven `=` characters. They
are response-authored mathematical equation separators bound by the response
hash, not unresolved merge state. All other staged paths pass. Editing those
lines would violate exact recovery.
