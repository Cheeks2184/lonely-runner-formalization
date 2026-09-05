# Twentieth Astra checkpoint: endpoint labels and divisor shifts

The full unrestricted Lonely Runner Conjecture remains unresolved. This pass
audits a proposed way to use the endpoints of an old-good component when
inserting the fastest runner. It adds manuscript evidence and exact controls;
no Lean declaration or dependency was changed.

## The candidate and its proved scope

At denominator `N>=4`, let `V` contain `N-2` distinct positive integer speeds,
and let `p>max(V)`. Assume the actual largest pivot row is covered. A supplied
old witness at threshold `1/(N-1)` lies inside an old-good component at the
weaker threshold `1/N`. If that entire component lies in one open bad interval
of `p`, the candidate asks whether at least one of its endpoint owners is
noncovered in the original tuple `V union {p}`. Both the stronger universal
choice of endpoint owners and the weaker existential choice remain unproved.
Ties, the original labels, and the denominator remain explicit.

The [audit manuscript](../research/astra-endpoint-label-audit.md) proves a
limited result. Write `D=gcd(V)`, `g=gcd(D,p)`, and `m=D/g`. Under
`2m <= N(m-1)`, every old-safe candidate on an old runner's actual pivot row
can be shifted to a full-safe candidate on that same row. Shifts by `j/D`
preserve all old phases. The new phase visits a translated `m`-point grid,
whose largest circular distance is at least `(m-1)/(2m)`. Its signed pivot
numerator changes by `N*(a/D)*j`, preserving the nonzero residue modulo `N`.
Reduction modulo `Na` then preserves all integer-speed norms.

For `N>=4` and `m>=2`, this proves that every endpoint owner is noncovered,
including tied owners and closed equality. After common positive scaling is
removed, the remaining candidate is restricted to `gcd(V)=1`. The mesh bound
already exists in `DivisorInsertion.lean`; preservation of the same actual
pivot row is proved here at manuscript scope, with no new formal wrapper.

## Why the largest-row hypothesis matters

For `N=7`, `V=(2,5,7,12,17)`, `p=19`, the old stronger witness `31/85` lies
in the full weak-good component `[43/119,13/35]`, strictly inside the open
`p`-bad interval `(48/133,50/133)`. Its endpoint owners `17` and `5` are both
covered in the original tuple. The largest pivot is noncovered, with exactly
four safe residues `[13,41,92,120]` modulo `133`.

Thus local component geometry alone cannot justify the endpoint-label claim.
This example refutes the version that omits largest-row coverage. It refutes
neither the fully stated candidate nor LRC; `13/133` is a full closed witness.

## Verification and remaining work

The [independent review](../research/astra-endpoint-label-review.md) accepted the
frozen manuscript, and root replay passed its independent checks of all 70
original pivot rows and 196 endpoint tie assignments. [Mechanical replay](../research/astra-endpoint-controls.json)
passed 480 complete-cover-set comparisons against literal enumeration, ten
positive cover certificates, 60 trapped components, and 2,448 old-safe shifts.
All 48 focused workflow, storage, and historical-ledger tests passed.

Root separately tested the broader divisor proposition on 2,108 contracts,
85,270 old-safe candidates, and 255,810 signed normalizations using rational
norms. These controls include 414 nonprimitive contracts, pivots below the old
maximum, and 264 instances of closed equality. They support the written proof;
they do not replace it or establish an unrestricted conjecture.

The author's bounded search completed all feasible `6<=N<=10,p<=118` and
`N=6,7,8,9,p=119`; its unfinished `(10,119)` instance is explicitly excluded.
The timed search's reported domain is separate from the reproduced positive
certificates. Nine of its ten primitive cover tuples fall within the proved
common-divisor scope; the only old-gcd-one tuple was already known. These
finite misses provide no new global argument in the remaining case.

Exact hashes, reproduction code, review disposition, and verification limits
are preserved in [the checkpoint record](../research/astra-pass20-verification.json).
Further work must connect the complete original pivot rows in the old-gcd-one
case. No local endpoint certificate or finite search supplies that missing step.
