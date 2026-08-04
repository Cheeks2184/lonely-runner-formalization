# Prompt78 recovered artifacts

This directory preserves the three files attached to the Prompt78 Sol Pro
response. Recovery copied their bytes exactly. The C++ source was not
compiled, executed, or imported, and the JSON output was not regenerated.

## Exact attachment inventory

| File | Bytes | SHA-256 |
|---|---:|---|
| `p78_sparse_minimal_cover_verifier.cpp` | 34,336 | `45c664918d25ec5213836c9eca420df7616483f3c67fd4b67d8e014bb8f933f4` |
| `p78_sparse_minimal_cover_verifier_output.json` | 54,960 | `e006eab7a6cff892127d6019bc4c1b3da80e418f480df4cc53b91b8b8194f7df` |
| `p78_sparse_minimal_cover_manifest.json` | 2,237 | `ddb73c8c2e283a6a015125bdb06d797ca5048f3867929690ee0e9cd97abd1898` |

All three attachment sizes and hashes match the browser-capture metadata and
the response-authored hashes. The C++ source has 827 LF separators, the output
JSON has one, and the manifest has 42; each has a terminal LF and no CR.

## Static binding checks

The manifest and output parse as strict UTF-8 JSON with duplicate-key
rejection. Static inspection established:

- the manifest's source hash matches the recovered C++ bytes;
- the manifest's output hash matches the recovered output bytes;
- the output metadata's `source_sha256_binding` and the manifest's
  `source_sha256_embedded` both match the recovered source hash;
- both JSON files name the tuple `[6,7,12,24,144]` consistently;
- the output's nested `first_failure` and the manifest's corresponding field
  are both `null`; and
- serialized `R`, `Q`, and bad-residue arrays in the claimed counterexample
  record are strictly increasing and duplicate-free.

The manifest also records a binary SHA-256
`b32ab0c511a9ebbd6d5416fc17e351710197d5d6e2c377ee3ce52370b3c4d8f7`.
No binary, compiler log, run log, or malformed-input output was among the three
observed attachments. Therefore that binary hash and the manifest's build,
run, compiler, exit-code, and malformed-input claims were inspected only as
static JSON fields and were not independently verified.

## Declared counterexample fields

The recovered output statically declares, without this package accepting the
claim:

- record: `n=5`, `N=6`, speeds `[6,7,12,24,144]`, tuple gcd `1`, sparse bound
  `3`, and `G=[0,0,0,0,160]`;
- selected pivot: index `1`, speed `7`;
- selected owner indices `[0,2,3]`, speeds `[6,12,24]`, marked complete,
  inclusion-minimal, and applicable to the frozen target;
- owner-labelled private sets
  `[1,8,13,15,20,22,27,29,34,41]`,
  `[3,4,10,11,17,25,31,32,38,39]`, and
  `[2,5,9,16,19,23,26,33,37,40]`;
- empty owner-pivot `Q` arrays for those three owners;
- singleton blocker index `4`, speed `144`; and
- claimed divisibilities `36|144`, `72|144`, and `144|144`.

The output also statically declares 532,412 primitive tuples, 4,946 applicable
sparse minimal covers, and no first failure in its bounded search. Recovery did
not run or independently replay that search, so these values are unaccepted
response-authored computation claims, not computed finite evidence.

## Response provenance and evidence boundary

The raw clipboard capture has SHA-256
`d11f74e6ebabf7e5b60b11fe3a1455beb6aef47f1b1a73095b647b4cb654ffe8`:
23,157 UTF-8 bytes, 23,149 characters, 942 CRLF separators, no lone LF or
CR, and a terminal CRLF. The tracked response is that capture with only CRLF
normalized to LF. It has SHA-256
`96e3bc5d0c05fb2b04e8e2d9117a55bf86b1d96d608e92422553bf54ab0a2390`:
22,215 UTF-8 bytes, 22,207 characters, 942 LF separators, no CR, and a
terminal LF.

Recovery preserves without accepting the response's **STOP** disposition, its
claimed counterexample, its rejection of
`SPARSE-MINIMAL-COVER-OWNER-ESCAPE`, its canonical-cover statement, and every
bounded, computational, mathematical, conditional, and open label. Root's
independent triage is a separate review and is not part of this recovery
package. No theorem, bridge counterexample, computed finite evidence, Lean
result, or LRC status is promoted here. The exact unrestricted pivot selector
and unrestricted Lonely Runner Conjecture remain open.

A targeted credential, private-path, browser-session, and personal-data scan
was clean. The three `sandbox:/mnt/data/...` links in the immutable response
are inert response-era attachment references, not local authentication or
session data.

`git diff --check` reports `research/sol-pro/responses/response78.md:716` as a
possible conflict marker because that immutable response line is exactly
`=======` inside a boxed fraction. It is response content, not a repository
merge marker, and changing it would violate exact recovery. The scoped check
over every other changed path passes.
