# Prompt64 recovered artifact package

This directory preserves the three canonical attachments recovered from the
completed Prompt64 Sol Pro turn. They are byte-for-byte recovery inputs; this
package does not rewrite them or infer acceptance from their self-labels.

| Canonical recovered file | Bytes | SHA-256 |
| --- | ---: | --- |
| `p64_top_two_sweep_v1.cpp` | 10,492 | `9c8bdb908bd37c9a9a13a20f023c50b3121def34ffc5c7dfbe9e1f20038e7b37` |
| `p64_targeted_stress_v1.py` | 10,787 | `6b42c80fe54bda78bd56aabc0c340e22b8cf21c574a94d6279a4fab82e46557a` |
| `p64_execution_manifest_v1.json` | 2,961 | `d839bcc52ce003aba795aad09e619158dc5b98feb43b76074d606320a56aec03` |

The original solver binary, sweep output, targeted output, and timing files
were not recovered. Their hashes in the canonical manifest and response are
response-supplied provenance only and have not been independently
byte-verified. The manifest's `/mnt/data` paths are generic, non-identifying
execution paths. Sandbox links in the response are inert historical references
and are not package members.

The normalized canonical response is
`research/sol-pro/responses/response64.md`: 41,788 UTF-8 bytes, 1,367 LF
separators, terminal LF present, SHA-256
`f273ee340066c42dc4f3cb8224e35b4df028ebdd47b4dda1bb4879f515f5698d`.
It is the exact CRLF-to-LF normalization of the raw clipboard capture: 43,155
UTF-8 bytes, 1,367 CRLF separators, terminal CRLF present, 1,368 split slots
including the terminal empty slot, SHA-256
`2fdc753554dab9221a4ee38031ecea71ea699039f5f0998d2d9d1bd542baef9b`.

Independent audit accepted the finite computations only as computed finite
evidence and accepted manuscript claims only at their corrected exact scope.
In particular, the response's literal `r<M<dM` statement is false when `d=1`;
the accepted scaling edge is `r<M<=dM`. The response remains canonical and
unchanged. See [the Prompt64 audit](../../../../docs/response64-audit.md).

`TOP-TWO-LARGE-RATIO-EXCLUSION`, the downstream owner-transversal, the exact
pivot selector, and unrestricted Lonely Runner remain open. This package adds
no Lean theorem and no uniform mathematical result.
