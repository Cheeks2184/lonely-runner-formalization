# Fixed Renault5.1 core-mask kernel check

Root predeclaration, 2026-09-06. This is implementation of the previously
reviewed fixed certificate, not new candidate discovery.

Input is the exact certificate JSON SHA-256
`c1374409d4f6804487179fe9765695a2f0d756ccd2a79b5ee8616e919acbb7b1`.
Extract exactly `masks[class_reps[i]] for i in minimal_classes`:41 natural
mask constants in their saved order. Do not recompute classes, discover
witnesses, remove cases or edit this input.

Implement `renaultPhaseCoreMasks : Fin41 -> Nat` with these41 literal
constants and only ordinary proof-producing `decide` checks. Each row i
checks forall j k:Fin41, j<=k -> (mask i &&& mask j &&& mask k) != 0.
There are41 fixed rows,68921 dense triples with the j<=k implication, and
35301 ordered-pair tests counting duplicate unordered triples. This includes
all12341 distinct sorted triples, plus symmetry duplicates. The universal
assembly must retain arbitrary i,j,k and j<=k. Prove also every mask<2^23.
Use41 separately named private row lemmas and a finite case split on i;
no axiom, sorry, native_decide, unsafe or external oracle. The full first-row
pilot previously passed under8GiB virtual AS in1.83seconds with[propext].

Before execution, save exact generated source SHA and launcher command.
One focused source check may use the shared pinned environment,
LEAN_NUM_THREADS=1 and LEAN_STACK_SIZE_KB=65536, lean -j1 -s65536,
8GiB per-process address cap, CPU59/60seconds, wall60seconds, per-stream
256KiB file caps, source maxHeartbeats1000000/maxRecDepth4096. These
limits apply to the complete41-row module invocation. Retain actual child
exit/status, complete stdout/stderr, byte hashes, source guards before/after,
and reject timeout/truncation. No automatic larger retry or domain change.
A proof syntax error may be repaired while preserving exact statements and
all resource caps, retaining the failed source/output evidence.

Own only LonelyRunner/RenaultPhaseMasks.lean and a compact implementation
receipt report. Do not add root imports/audit yet. Full source verification,
independent contract/axiom review, Fin23 common-bit extraction, concrete
atom mask domination, and continuum soundness remain later obligations.
This module alone is a finite bit-intersection result and cannot be labeled
Renault5.1 or a new runner-count proof.
