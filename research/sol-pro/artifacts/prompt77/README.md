# Prompt77 recovered artifacts

This directory preserves the five files attached to the Prompt77 Sol Pro
response. Recovery copied their bytes exactly and did not execute either
Python program. The large JSONL file required direct browser saving; recovery
did not execute, regenerate, or modify it.

## Exact inventory

| File | UTF-8 bytes | SHA-256 |
|---|---:|---|
| `prompt77_exact_search.py` | 14,085 | `c416c9fcc192b57d038801f32342b7ad1a48d6e641f3aa47dc40590872bbec51` |
| `prompt77_search_summary.json` | 1,888 | `8cb881ec154faa556cdf6c92693f7f680dfc15f582c3cab2b1ee9bb8ef2c3ad0` |
| `prompt77_search_certificates.jsonl` | 3,677,569 | `0a00e2f1ff08ddcf726dfb777e2d0edd823d299d14d01e95862ac2c1b5c16010` |
| `prompt77_counterexample_verify.py` | 6,556 | `6d48456ccfee6323371beb4f8c4a46b89de3e228fa12e1bd5c7784aa83f3971c` |
| `prompt77_counterexample_certificate.json` | 3,026 | `c9713f16644acb1f562823b93135cd1d12fbc3f3350c4c8fa3d4ca09723b72d9` |

All five response-authored hashes were independently recomputed and match.
The JSON documents and all nonblank JSONL lines were parsed strictly with
duplicate-key rejection.

The summary binds `prompt77_exact_search.py` and
`prompt77_search_certificates.jsonl` by the exact hashes above. The
counterexample certificate binds `prompt77_counterexample_verify.py` by its
exact hash. The JSONL contains 6,330 nonblank records, has a terminal LF and no
CR bytes, and is in strictly increasing `(n, tuple)` order. Its per-dimension
counts are 63, 325, 965, 1,981, and 2,996 for `n = 2, 3, 4, 5, 6`, matching the
summary; the first tuple is `[1,2]` and the last is
`[9,10,11,12,13,14]`.

## Response provenance and evidence boundary

The exact raw clipboard capture has SHA-256
`61931350e89dc5757628d94d29e5cd1d42cbbaf0290d295e4fc168b697bfafa4`:
27,344 UTF-8 bytes, 27,337 characters, 1,332 CRLF separators, no lone LF or
CR, and a terminal CRLF. The tracked response is the raw capture with only
CRLF normalized to LF. It has SHA-256
`c758c5e8759e2b61cb5fc15e4c056e85b9c3551480660006f349944ee72f8835`:
26,012 UTF-8 bytes, 26,005 characters, 1,332 LF separators, no CR, and a
terminal LF.

Recovery preserves, without accepting, the response's **STOP** disposition;
its proposed family and first member `(6,7,168)`; its claimed block
dispositions `negative-semidefinite`, `negative-semidefinite`, `zero`; its
claimed aggregate `G=(0,0,126)`; and its claimed 6,330-tuple bounded scan with
zero failures. These are response-authored claims awaiting independent
mathematical and computational audit. They are not promoted to a theorem,
counterexample, computed finite evidence, or any other accepted evidence
label. The exact pivot problem and unrestricted Lonely Runner Conjecture
remain open.

A targeted privacy, credential, browser-session, and local-path scan found no
publishable sensitive material. Any `/mnt/data` references in the preserved
response or artifacts are inert response-era attachment paths, not local
authentication or session data.

`git diff --check` reports `research/sol-pro/responses/response77.md:688` as a
possible conflict marker because that immutable response line is exactly
`=======` inside a displayed formula. It is response content, not a repository
merge marker, and changing it would violate exact recovery. The scoped check
over every other changed path passes.
