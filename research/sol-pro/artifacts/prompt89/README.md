# Prompt89 recovery provenance

This directory records the public-safe recovery boundary for the completed
Prompt89 Sol Pro response and its four attachments. The attachments are
preserved byte-for-byte under `quarantine/` because the repository permits
tracked research sources and outputs, but they remain untrusted. No
attachment was executed, imported, evaluated, replayed, or treated as
mathematical or computed evidence during recovery.

## Exact response provenance

The immutable decoded raw capture has SHA-256
`897a500651162e066e2aabd3b1be005372f6cd17404d933a3d1c570a132709de`:
36,943 UTF-8 bytes, 36,907 characters, 1,372 CRLF separators, no lone LF or
CR, and a terminal CRLF. Strict UTF-8 decoding found no NUL or replacement
character.

The tracked response at `research/sol-pro/responses/response89.md` is exactly
that capture with CRLF normalized to LF and no other content change. It has
SHA-256
`2c4e7985a7d2c0622a487ccbfad98215ae3121d24ba3bdc0f8780c27d448c7b9`:
35,571 UTF-8 bytes, 35,535 characters, 1,372 LF separators, no CR, and a
terminal LF. Re-expanding every LF to CRLF reproduces the immutable raw
capture byte-for-byte.

## Prompt and launch binding

The public launch record is
`research/sol-pro/launches/prompt89-2026-08-04.md`. It binds the tracked
prompt `research/sol-pro/prompts/prompt89.md` at integrated commit
`85d525a2934f90be5f3e266c3c15c19519822d98` and SHA-256
`acd509f2ac8e471d56f0564b133a98b5d91e2652ebb7892bd3cb5a2990c1cf74`.
No private conversation, browser-session, account, or machine identifier is
included in this package.

The response contains exactly four original `sandbox:/mnt/data/...`
attachment references. They map by basename to the four files in
`quarantine/`. The recovery manifest records each path, byte size, and
SHA-256. The supplied checksum text lists the other three attachment hashes,
and all three independently match the copied bytes. Its own hash is also
frozen. Hash agreement proves attachment identity only; it does not verify
the implementation, reports, CSV rows, claimed execution, minima, or
agreement.

## Quarantine and evidence boundary

The response self-disposition is **PIVOT**. Recovery preserves but does not
promote it. In this package:

- `BALANCED-JUNCTION-COVER-DEFICIT` remains **OPEN**;
- `ROOT-STAR-BALANCED-DEFICIT` remains **OPEN**;
- the generic construction theorems, junction identities, and arithmetic
  formulas are response-authored and unverified;
- the claimed 811-tuple / 3,914-pivot scan, every fixture and P85 minimum,
  and all root-star minima are **UNVERIFIED / QUARANTINED**;
- the uniform-average selection route is rejected by the response only on
  the basis of its unverified P85 fixture claim; and
- unrestricted Lonely Runner remains **OPEN**.

No theorem, counterexample, computation, Lean result, bridge, or status is
promoted by this recovery package.

A targeted credential, private-key, token, email, private-path, and
browser/session-data scan found no sensitive artifact. A deliberately broad
Windows drive expression matched five TeX fragments (`a:\\` twice and
`j:\\`, `i:\\`, and `x:\\` once each) in the immutable response; they are
mathematical notation, not filesystem paths. No response or attachment byte
was changed to silence the scan.

Staged `git diff --check` reports exactly one immutable response line—774—
whose complete content is seven `=` characters. It is a response-authored
mathematical equation separator bound by the response hash, not unresolved
merge state. All other staged paths pass. Editing that line would violate
exact recovery.
