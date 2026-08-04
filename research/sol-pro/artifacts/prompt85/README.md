# Prompt85 recovery provenance

This directory records the public-safe recovery boundary for the completed
Prompt85 Sol Pro response. Prompt85 returned no attached verifier, output, or
other file, and the raw response contains no `sandbox:/...` attachment
references. Recovery therefore packages only the normalized response and this
provenance memo.

## Exact response provenance

The immutable raw clipboard capture has SHA-256
`76fc2f0fb3e8bc61bab813d7e2330a41f2082482408e40e5161c78a62c86dd71`:
38,333 UTF-8 bytes, 38,319 characters, 1,516 CRLF separators, no lone LF or
CR, and a terminal CRLF.

The tracked response is exactly that capture with CRLF normalized to LF. It
has SHA-256
`59196ec701c39ab56d8a945897b1719060c3a4070e132597a2f273aad6897722`:
36,817 UTF-8 bytes, 36,803 characters, 1,516 LF separators, no CR, and a
terminal LF.

Recovery independently confirmed the response's **STOP** self-disposition and
its claimed counterexample tuple `(1,2,5,7,9,11,12,13)` for
`WIDTH-TWO-JUNCTION-COVER-DEFICIT`. The tuple, generic lemmas, claimed
793,800-construction enumeration, scans, hashes, and counterexample are all
response claims pending independent mathematical and computational audit.

## Evidence boundary

No response-authored calculation, construction enumeration, scan, verifier,
or symbolic argument was executed or replayed. There are no verifier/output
attachments to package. Recovery preserves without accepting any
response-authored proof, counterexample, equivalence, dependency, finite
count, hash, or status label.

No theorem, counterexample, computed finite evidence, Lean result, bridge, or
LRC status is promoted by this package. The unrestricted Lonely Runner
Conjecture remains open.

A targeted credential, private-key, browser-session, personal-email, and
private-machine-path scan of the normalized response and this memo found no
sensitive data. There are no response-era sandbox links to classify.

`git diff --check` flags exactly three immutable response lines—normalized
response lines 665, 877, and 1277—whose complete content is seven `=`
characters. They are original mathematical equation separators bound by the
response hash, not Git merge markers. Changing them would violate exact
recovery. All other changed paths and scoped checks pass.
