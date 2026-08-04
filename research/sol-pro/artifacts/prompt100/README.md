# Prompt100 recovered artifact bundle

This directory preserves the five attachments recovered from the completed
Prompt100 ChatGPT conversation. The response is tracked at
[`../../responses/response100.md`](../../responses/response100.md).

Recovery alone was an operational provenance result. Subsequent independent
review accepted the exact two-owner theorem and its vacuous
`|coveredPivots|<=3` Prompt95 consequence as `proved-math-qualified`, and
independently replayed both finite scans at their exact declared domains. See
the [mathematical and computational audit](../../audits/response100-mathematical-audit-355.md).
Unrestricted Prompt95, the pivot theorem, and unrestricted Lonely Runner
remain `open`.

## Recovered bytes

The browser downloads had opaque temporary basenames. Each was identified by
its supplied SHA-256 digest and preserved under the response-authored name.
No attachment required LF normalization: all five downloads were already
UTF-8/ASCII text with LF endings and one final LF, and the tracked bytes match
them exactly.

| Download basename | Tracked file | Bytes | SHA-256 |
| --- | --- | ---: | --- |
| `51490f5e-7598-4e6f-9edb-81ad161010c6.tmp` | `falsifier_a_literal.c` | 8,967 | `8eb381637769cf3981163c7c2be1438c696fc21300b7aba239095cdd113c6f35` |
| `cb5f1e2b-fe3a-4408-8e7a-49dd1724f8b2.tmp` | `falsifier_a_result.json` | 531 | `514a267c3959bd49a3288201c281f2b976c7dedb5118c7d63548c7f7ec02a739` |
| `299935e1-18a4-4711-b84a-5371d3806721.tmp` | `falsifier_b_fibers.c` | 10,971 | `8d302770222002a4ab9ef17f64b18762dc836ecbe84102d5a3fe8f6f703376ab` |
| `c9f724b9-2b6a-4701-ab3a-b21fb864eb86.tmp` | `falsifier_b_result.json` | 807 | `76c08f87964ee3a89d13957faed86a29c05cb66b298266c69771173246d8ba8d` |
| `a90951b4-00ae-4b08-be67-c866b6e5e2a9.tmp` | `manifest.json` | 2,974 | `b58b80d1a991c44ea001853e07d2421116cff59d56eaed9dbb7357bd9970a01e` |

The recovered response is 38,745 UTF-8 bytes and 1,283 LF-terminated lines,
with SHA-256
`bc783895beead9c035705d1e9acb04c65301d15ed3f000d46dd66709711059dc`.
The tracked response has LF line endings and one final LF. This record does
not assert whether an earlier browser-side representation used different line
endings.

## Response-supplied build and replay commands

The manifest records GCC 14.2.0 on Linux x86-64 and the flags
`-O3 -std=c11 -Wall -Wextra -Werror`. From this directory, the response's
commands are:

```bash
gcc -O3 -std=c11 -Wall -Wextra -Werror \
  -DSOURCE_SHA256=\"8eb381637769cf3981163c7c2be1438c696fc21300b7aba239095cdd113c6f35\" \
  falsifier_a_literal.c -o falsifier_a_literal
./falsifier_a_literal > falsifier_a_result.json

gcc -O3 -std=c11 -Wall -Wextra -Werror \
  -DSOURCE_SHA256=\"8d302770222002a4ab9ef17f64b18762dc836ecbe84102d5a3fe8f6f703376ab\" \
  falsifier_b_fibers.c -o falsifier_b_fibers
./falsifier_b_fibers > falsifier_b_result.json
```

The recovered manifest also records hashes for the original binaries, but
binaries are not tracked in this package.

## Independent replay

Both sources were rebuilt with Ubuntu GCC 15.2.0 using the commands above.
Every mandatory fixture and malformed control passed.

Implementation A completed `N=4..18`, `p=1..160`: 10,048,800 owner pairs,
190,800 owner rows, and 225,271,200 literal residue-predicate checks, with
common-domain digest `0e430dd2e7f1b766` and no failure.

Implementation B completed `N=4..24`, `p=1..240`: 47,780,880 owner pairs,
602,280 owner rows, and 225,271,200 common-domain pointwise comparisons with
zero mismatches. Its all-domain digest is `55a9a8f24ef40789`; its common-domain
digest is `0e430dd2e7f1b766`; no failure was found.

Fresh GCC 15.2 hashes:

| Output | SHA-256 |
| --- | --- |
| A binary | `a2e2b7590613fc655f2346121756cfd7f3d32643b5cea0c7e95740059d4a53e1` |
| B binary | `badfbadd063c5873f1b661f481fd1de1d7c798dd6ca2ba17761c56fd362785c6` |
| A result JSON | `f1dcf20517c172095ca5eaebee89129c01e2cf1aed2c6d3b4b2a25e7932eff98` |
| B result JSON | `3856aa71f19c154de118e50c4d440fefdaaa3bb835d406b8ce867f97ddaa95b5` |

The fresh JSON differs from the supplied GCC 14.2 JSON only in the compiler
field; all other parsed fields match exactly. The fresh binary hashes are not
expected to match the manifest's GCC 14.2 binaries.

## Fail-closed status

- Exact `TWO-LOWER-OWNER-NONCOVER`: `proved-math-qualified`.
- Prompt95 restricted to `|coveredPivots|<=3`: `proved-math-qualified`,
  vacuous because no internal complete cover exists.
- Proposed `N>=3` arithmetic extension: `refuted-exact` only.
- Two retained bounded scans: independently replayed
  `computed finite evidence` at the exact domains above.
- Lean formalization of the theorem: not yet provided.
- Unrestricted Prompt95, the pivot theorem, and LRC: `open`.
