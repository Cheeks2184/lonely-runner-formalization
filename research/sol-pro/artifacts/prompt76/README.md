# Prompt76 recovered artifact package

This directory preserves the complete five-file attachment inventory supplied
by `/root` from the completed Prompt76 GPT-5.6 Sol Pro turn. Recovery preserves
exact bytes and provenance only. Neither Python file was executed, and neither
the JSON results nor any response-authored evidence label is independently
accepted.

| Canonical recovered file | Bytes | SHA-256 |
| --- | ---: | --- |
| `p76_global_private_deficit_scan.py` | 33,260 | `844355ab056343f67f45ae3caa6094366e4aba8bc214b04d544299e7d68c499a` |
| `p76_global_private_deficit_scan.json` | 184,062 | `535bce9372e69a0478c4bc0870dde4938c8732fae8f4f0b6017692692c4f5fdc` |
| `p76_global_private_deficit_replay.py` | 7,441 | `cddfd82eb4e67c82842b91c4539ab56bb35256d5944345be132b1ec34a3e58da` |
| `p76_global_private_deficit_replay.json` | 4,128 | `94fe0cacd26a7db6dfb4b20363cf157e9c312f31f9bb2c40b0947b633ebee66e` |
| `p76_SHA256SUMS.txt` | 452 | `fa7bfdfc8feae4d1d4e0b5fc61d8984a8791a3ca6208a15825b8ff9851b215aa` |

The checksum manifest contains exactly four rows for the two source files and
two JSON outputs. Its labels use `/mnt/data/<filename>` sandbox paths. After
mapping each label to its basename, every manifest hash independently matches
the corresponding recovered file, with no missing or duplicate payload.
These byte bindings do not establish that either program is correct or that
either output came from an independently reproduced execution.

The canonical response is
`research/sol-pro/responses/response76.md`: 39,521 UTF-8 bytes; 39,515
characters; 1,581 LF separators; no CR; terminal LF; SHA-256
`3566a99d3f00bfe481c2f99455e59de719e53e4477a4e4e6c5ccea2fe7c85d2d`.
It is the exact CRLF-to-LF-only normalization of the input-only raw clipboard:
41,102 UTF-8 bytes; 41,096 characters; 1,581 CRLF separators; no lone LF or
lone CR; terminal CRLF; SHA-256
`ce0fc0670081ffcf3e1e9ac6551992569d34cc383502634cb921ef83696f5e11`.
No trimming, Unicode normalization, or other content change was performed.

The response self-disposition is **STOP** and reports the tuple
`(1,4,5,6,7,11)` with private demand `100` and external capacity `98` as a
counterexample to its frozen private-deficit inequality. Recovery does not
accept that mathematical claim, the reported bounded firstness, the displayed
counts, the proposed route disposition, or any `proved-math`, computed, or
rejected label authored by the response. Independent mathematical and
artifact audits remain required. The exact pivot selector and unrestricted
Lonely Runner Conjecture remain open.

There is no archive and there were no other observed attachments. A targeted
recovery scan found no credential, private key, personal email, private local
path, browser profile, session identifier, cookie, screenshot, or third-party
paper in the recovered package. Generic `/mnt/data` strings in the immutable
manifest are inert sandbox provenance, not private machine paths or commands
executed during recovery.
