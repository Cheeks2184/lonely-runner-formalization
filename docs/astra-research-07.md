# Pass 7: decide the current normalization method over all moduli

The exact decision engine implements the independently accepted finite reduction
for the A/B/R normalization union. Its domain is an odd prime `N` and a primitive
tuple of `N-1` distinct positive integer speeds. It is a tool for auditing these
sufficient conditions, not a decision procedure for the Lonely Runner Conjecture.

`scripts/grid_normalization_decision.py` enumerates the finite pivot cases and
the complete velocity-cell, arithmetic-class, and zero-anchor decomposition.
All polynomial comparisons use exact integer and rational arithmetic, including
quadratic irrational roots and isolated rational endpoints. Successful results
are reconstructed and checked by the existing fixed-pair certificate verifier.
An optional logical-case limit yields `INCOMPLETE`; arithmetic failures propagate.
Neither is reported as nonexistence.

The source-bound evidence is in `research/astra-decision-engine.md`, the
accepted independent review in `research/astra-pass7-review.md`, and root integration
checks in `research/astra-pass7-verification.json`. The earlier bounded candidate
sweep is retained in `research/astra-normalization-candidates.md`; its misses
remain only bounded misses.

## Concrete scope and limitation

For `N=7` and `V=(2,3,4,7,14,9)`, the uncapped engine exhausts 3,395 logical
cases: 11 pivot-unit pairs, 1,152 A formulas, and 2,232 R anchors across all
24 velocity cells and all 48 admissible arithmetic classes. It returns
`INFEASIBLE`. The receipt retains source hashes, exact coverage counts, and a
deterministic coverage digest. A separate solver importing no project code also
exhausted all 73,728 signed cell/class choices and 11 pivot-unit pairs. Its 7,856
distinct geometric conjunctions were all empty over the reals. Root reran this
independent reproducer successfully. This is accepted complete computational
evidence, not a standalone kernel proof of the obstruction.

The tuple itself has a strict Lonely Runner witness at `t=1/5`: its distances
are `(2/5,2/5,1/5,2/5,1/5,1/5)`, all greater than `1/7`. Thus this result can
reject universality of the current A/B/R sufficient conditions, but cannot
disprove LRC. A separate compact mathematical derivation of the obstruction is
being developed and is not part of this implementation checkpoint.

Even the existing general residue-band transport can express this witness:
take `M=35`, multiplier `b=1`, all positive signs, `s=1`, `r=2`, `r0=0`, and
`beta=14`. With the speeds themselves as bases, the field residues are
`h=(2,3,4,0,0,2)` and `h*M+a*beta=(98,147,196,98,196,196)`, each in
`[M,6*M]=[35,210]`. This is an exact arithmetic calculation against the existing
transport contract, not a newly compiled Lean declaration. A broader supply
argument must obtain useful residue-dependent bands without assuming the
desired witness in advance.

## Verification and storage

Root ran 62 focused tests covering the new exact backend and decision engine,
the existing fixed verifier, and workflow/ledger safeguards. The engine author
also checked direct CLI success, incomplete, and error behavior. Independent
mathematical and implementation review passed and is recorded separately with
exact source hashes. It includes independent radical-sign, root-order,
interval-range, arithmetic-class, and stopping-boundary checks.

No Lean source or dependency pin changed, and no shared Lean cache was restored.
The previous compiled theorem and trust evidence remains scoped to its original
source checkpoint; repository CI rechecks the pinned build on publication.
Only compact evidence is retained. The unrestricted canonical conjecture remains
unresolved.
