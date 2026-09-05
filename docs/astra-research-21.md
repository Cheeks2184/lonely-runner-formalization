# Twenty-first Astra checkpoint: limits of global endpoint transport

The full unrestricted Lonely Runner Conjecture remains unresolved. This pass
closes one proposed sufficient transport mechanism with an independently
reviewed exact obstruction. It adds no Lean theorem or dependency change.

## What largest-row coverage says

The [manuscript](../research/astra-primitive-endpoint-exchange.md) proves an
exact separation statement. If the largest pivot row is covered, the old-good
set avoids every actual candidate time `r/(Np)` with `N` not dividing `r`.
Every old-good component therefore lies strictly between consecutive candidates.
Gaps through omitted multiples have width `2/(Np)` and are new-speed bad;
other gaps have width `1/(Np)` and are new-speed good. Coverage thus permits
full witnesses in good gaps away from the largest pivot's grid.

For a trapped component, its two endpoint owners already spoil the adjacent
largest-grid candidates. Those local failures follow from trapping itself.
Any argument using the full covered-row hypothesis needs information beyond
these two neighbors.

## The global symmetry mechanism fails

Take `N=7`, old speeds `(1,4,5,6,7)`, new maximum `11`, and stronger old
witness `13/36`. The actual largest row is covered. The witness's old-good
component `[5/14,13/35]` lies strictly in `(27/77,29/77)`, a new-speed bad
interval; its endpoint owners are `6` and `5`.

The entire old-good set has six components. Its two shortest components have
width `1/294` and left endpoints `15/49` and `29/42`. A translation preserving
the entire set must permute those two endpoints. Fixing one requires an
integer shift; swapping them would require their doubled separation
`113/147` to be integral. Consequently only integer translations preserve
the set. Evenness of circular norms then classifies its reflections too:
every preserving circle isometry is `x -> x+j` or `x -> -x+j`, with integer
`j`. Such maps preserve the new-speed norm and cannot rescue either endpoint.
The conclusion also holds for one-sided containment, using the finite measure
and regular closedness of this explicit set.

This is an obstruction under every hypothesis of the actual endpoint
candidate. It refutes the proposed global symmetry supply, not that candidate.
Indeed `29/42 = 5/14 + 1/3` is a full witness on the original speed-6 row.
The same shift spoils speed 7 at the other endpoint, so a successful exchange
chosen for one point need not preserve the entire old-good set.

## Verification and decision

The [independent review](../research/astra-primitive-endpoint-exchange-review.md)
accepted the all-real symmetry proof, separation statement, and exact scope.
Root replay passed the author's controls and the independent construction from
840 old and 9,240 full phase-band combinations. It checked all six possible
translation shifts, 264 signed grid representatives, and all six original rows.

The [fixed-fixture inventory](../research/astra-cover-corpus-inventory.json)
rechecked the ten previously recorded largest-pivot covers. It identified no
new admitted fixture; this was not an exhaustive corpus search. Ambiguous
historical schemas and quarantined claims were not treated as certificates.
All 48 focused workflow, storage, and ledger tests passed. Exact hashes,
executable controls, and verification limits are recorded in
[the verification record](../research/astra-pass21-verification.json).

Global translations and reflections preserving the entire old-good set are
retired as a universal supply mechanism. The endpoint candidate itself remains unproved,
and the argument supplies no endpoint-specific exchange. The next research
attempt uses minimality in both moving-runner count and the sum of integer
speeds, seeking an additional valid descent argument rather than another
stronger symmetry requirement. No such descent theorem is claimed here.
