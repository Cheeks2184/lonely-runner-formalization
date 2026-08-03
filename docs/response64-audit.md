# Response 64 audit

## Disposition

Prompt64 completed with self-disposition **STOP/OPEN**. Independent reviews
accept a narrow set of manuscript arguments and the declared computations at
their exact scopes. They do not prove or refute
`TOP-TWO-LARGE-RATIO-EXCLUSION`, the downstream
`RESIDUAL-2N-SHIFT-OWNER-TRANSVERSAL`, the exact pivot selector, or
unrestricted Lonely Runner. No new Lean theorem is promoted, and the route is
frozen under its one-turn stop contract.

| Item | Audit label | Exact boundary |
| --- | --- | --- |
| Target implication / natural-number contrapositive equivalence | `proved-math` (qualified ACCEPT) | Exact logical equivalence, not a proof of either statement. |
| Common positive scaling and arbitrary reindexing | `proved-math` (qualified ACCEPT) | Includes numerator reduction and explicit top-index transport; scaling is accepted only with the correction below. |
| The `n=2` strict large-ratio branch | `proved-math` (qualified ACCEPT) | The `B` pivot succeeds at this dimension only. |
| Exact `kB+d` and `kB-d` residue-block formulas | `proved-math` (qualified ACCEPT) | Formula identities only; they do not construct a uniform selector. |
| Conditional `1/(m+2)` reduction | `proved-math` (qualified ACCEPT) | Conditional consequence of the still-open target and weaker than the Lonely Runner threshold `1/(m+1)`. |
| First unsupported branch | open | Failure of a `B`-pivot certificate forcing an `A`-pivot certificate is an equivalent/open reformulation, not progress closing the target. |
| Complete bounded sweep and targeted stress replay | computed finite evidence | Independently replayed as described below; finite domains do not imply the uniform theorem. |
| `TOP-TWO-LARGE-RATIO-EXCLUSION` and downstream owner-transversal | open | No theorem, counterexample, or exact selector is promoted. |
| Unrestricted Lonely Runner | open | No status change. |

## Required scaling correction

`FORM-P64-SCALING-EDGE-083` found one literal false inequality in the canonical
response. The response states `r<M<dM`; at `d=1`, `M<dM` is false. The accepted
manuscript claim is therefore only

```text
r < M <= d*M.
```

This correction is recorded here rather than altering recovered bytes. All
scaling arguments accepted by `FORM-P64-RESPONSE-MATH-AUDIT-081` are accepted
only with that correction.

## Independently replayed finite evidence

`VER-P64-COMPUTE-REPLAY-082` accepted the computations at finite-evidence
scope. The complete primitive sweep reproduced:

- 247,020 primitive rows and 5,597 skipped nonprimitive rows;
- 98,271,563 literal and 98,271,563 optimized candidates;
- 6,923,288 top-index placement checks and 494,040 full-mask agreements;
- `A`/`B`/both certificate counts 246,281 / 247,020 / 246,281;
- zero exact two-top counterexamples.

The targeted replay reproduced 61 cases, 45 strict-branch cases, 148,530
candidates in each implementation, 122 full-grid agreements, zero strict
two-top failures, 24 scaling checks, and 18 reindexing checks. An independent
enumerator agreed; AddressSanitizer/UndefinedBehaviorSanitizer execution and
the independent Python parser passed. `/root` independently reproduced the
same semantic counts.

These results are computed finite evidence only. They do not justify the
response's observed `B`-pivot behavior beyond the frozen domain.

## Recovery provenance and caveats

The raw clipboard capture has 43,155 UTF-8 bytes, 1,367 CRLF separators with
a trailing CRLF, 1,368 split slots including the terminal empty slot, and
SHA-256
`2fdc753554dab9221a4ee38031ecea71ea699039f5f0998d2d9d1bd542baef9b`.
Exact CRLF-to-LF normalization yields the canonical response: 41,788 bytes,
1,367 LF separators with trailing LF, SHA-256
`f273ee340066c42dc4f3cb8224e35b4df028ebdd47b4dda1bb4879f515f5698d`.

Only three attachments were recovered canonically:

| File | Bytes | SHA-256 |
| --- | ---: | --- |
| `p64_top_two_sweep_v1.cpp` | 10,492 | `9c8bdb908bd37c9a9a13a20f023c50b3121def34ffc5c7dfbe9e1f20038e7b37` |
| `p64_targeted_stress_v1.py` | 10,787 | `6b42c80fe54bda78bd56aabc0c340e22b8cf21c574a94d6279a4fab82e46557a` |
| `p64_execution_manifest_v1.json` | 2,961 | `d839bcc52ce003aba795aad09e619158dc5b98feb43b76074d606320a56aec03` |

The original solver binary, output, and timing files were not recovered.
Their response/manifest hashes remain response-supplied and are not presented
as independently byte-verified. Generic `/mnt/data` paths are non-identifying.
Sandbox links are inert historical references only. Recovery provenance
contains no ChatGPT/browser conversation URL, conversation/session ID, or
private runtime record; the response's one HTTPS link is a public arXiv
reference.

The accepted status is therefore: recovered canonical response and three
attachments; qualified manuscript acceptance; independently replayed computed
finite evidence; exact target and all unrestricted consequences still open.
