# Prompt98 recovered artifact bundle

This directory preserves the five attachments recovered by the GPT-5.6 Sol
High top-level desktop orchestrator from the completed Prompt98 ChatGPT
conversation. The original ChatGPT response is tracked at
[`../../responses/response98.md`](../../responses/response98.md).

Recovery does not accept any mathematical claim. In particular,
`MAX-COVERED-NONDIVISIBLE-PIVOT-REDUNDANCY`, Prompt95, the pivot existential,
and unrestricted Lonely Runner remain open.

## Recovered bytes

The downloaded browser files arrived with opaque temporary names. They were
identified only after their SHA-256 digests matched the response's declared
digests, then preserved under the response-authored filenames. The files have
no terminal newline; their tracked bytes match the downloads exactly.

| File | Bytes | SHA-256 |
| --- | ---: | --- |
| `sol_p98_impl_a.cpp` | 9,304 | `f0c999dd846a6d49239abc2f2094b585bdb4ca065fbe4c979f73d2f41708f24c` |
| `sol_p98_impl_b.cpp` | 8,249 | `3998587e8239aa0bc4ac98922f855753820568ba8c7552308bfca84fb73a4f69` |
| `sol_p98_summary_a_checked.txt` | 1,398 | `5e81c7e583d435145f7dc9ea1252e7546f847f69a125212ad8b8f33bf73ad2b0` |
| `sol_p98_summary_b.txt` | 1,269 | `400ef29b92c427a1a01ea28abbbd7ece935376c5731bbf26f34d5cfd87bb9788` |
| `sol_p98_computation_manifest.txt` | 1,721 | `702bc22d2628379603744aeda29141b69fdc5e840f0a06adc01fb3d05f0df14a` |

The LF-normalized tracked response has 1,126 lines, 36,037 UTF-8 bytes, and
SHA-256
`43cca6034228def4931f8d0ea31bb06f2d4840cf5c5a5fcf8dcf48492bfa14e4`.

## Independent replay

The coordinator replayed both programs in a fresh native-WSL temporary
directory with Ubuntu GCC 15.2.0. The tracked sources reproduced the supplied
summaries byte-for-byte. The two independently generated canonical record
streams were byte-identical:

```text
records_a.txt
ebca04f8f85f653d444fd2ffaa4aae59f4ad9e48f440a17bb25115652e6b1e66

records_b.txt
ebca04f8f85f653d444fd2ffaa4aae59f4ad9e48f440a17bb25115652e6b1e66
```

Each stream contains 2,803,981 records. Both completion markers were present,
their first disagreement was `NONE`, and their first theorem-domain failure
was `NONE`. Program A took 3.14 seconds and program B took 2.64 seconds on the
replay machine. The record streams and binaries are deliberately not tracked.

Exact commands:

```bash
g++ -std=c++20 -O3 sol_p98_impl_a.cpp -o impl_a
g++ -std=c++20 -O3 sol_p98_impl_b.cpp -o impl_b
./impl_a records_a.txt summary_a.txt
./impl_b records_b.txt summary_b.txt
cmp records_a.txt records_b.txt
sha256sum records_a.txt records_b.txt summary_a.txt summary_b.txt
```

This replay is eligible only for independent computed-finite review at the
declared domain `2 <= n <= 7`, height at most 30. It cannot prove an
unrestricted theorem.

## Fail-closed mathematical audit

The response's proposed `MBCP` successor is not accepted. If `B` denotes the
frozen branch theorem in its equivalent no-minimal-internal-cover form, then
`B` makes MBCP's minimal-cover antecedent impossible, so `B -> MBCP` is
vacuous. The response claims `MBCP -> B` by descent. Therefore MBCP is
equivalent to the original branch proposition at universal scope and is not a
genuinely narrower separation lemma.

That exact objection was returned to the same Pro conversation. Its correction
turn was submitted by the Sol High desktop orchestrator with the existing
conversation's visible Pro effort control. Prompt98 remains under correction
and independent audit; no response-authored proof label has been promoted.
