# Prompt83 recovery provenance

This directory records the public-safe recovery boundary for the completed
Prompt83 Sol Pro response. Prompt83 returned no attached files, and the raw
response contains no `sandbox:/...` attachment references. Recovery therefore
packages only the normalized response and this provenance memo.

## Exact response provenance

The immutable raw clipboard capture has SHA-256
`0aed6dc2989380343f9b6f28d2d7055ecbcf06ef8e2a1942545b8f66b846a61d`:
54,047 UTF-8 bytes, 54,021 characters, 1,190 CRLF separators, no lone LF or
CR, and a terminal CRLF.

The tracked response is exactly that capture with CRLF normalized to LF. It
has SHA-256
`ea582cc4b47d6c5cb047afb80c5e63f36d66f4b2b3a1b9fdb23c2277525ccb15`:
52,857 UTF-8 bytes, 52,831 characters, 1,190 LF separators, no CR, and a
terminal LF.

Recovery independently confirmed the response's **STOP** self-disposition and
its statement that no implementation candidate is admitted. These are
response dispositions, not mathematical audit results.

## Evidence boundary

Recovery preserves without accepting any response-authored proof,
counterexample, equivalence, dependency, scan, falsification, computation, or
status label. No response-authored calculation was executed or replayed. No
theorem, counterexample, computed finite evidence, Lean result, bridge, or LRC
status is promoted by this package. The unrestricted Lonely Runner Conjecture
remains open.

A targeted credential, private-key, browser-session, personal-email, and
private-machine-path scan of the normalized response and this memo found no
sensitive data. There are no recovered attachments or response-era sandbox
links to classify.
