# Fortieth Astra checkpoint: seven-adic scope and difference compression

The direct extension of the five-adic carry argument fails for both tested
seven-adic multiplier families. Exact fixed certificates identify the failure;
both configurations also have explicit ordinary lonely times. These are
refutations of auxiliary claims, not counterexamples to the Lonely Runner
Conjecture. The canonical five-total-runner theorem remains proved, and the
unrestricted conjecture remains unresolved.

## Exact scope of the rejected families

Put R=7^m and P=7R. Five normalized units are represented by a top digit,
a residue in {1,2,3}, and a coupled tag for their lower remainders. The sixth
moving speed is R times a unit. The proposed shared multipliers are
A=J(1+kR), with k in {0,...,6}. For each unit, a candidate succeeds exactly
when its resulting top digit is in {1,...,5}. The top-level speed is handled
separately: digit six can satisfy its closed distance bound at equality.

| Family | Finite domain | Fixed positive moving speeds | Ordinary stationary witness |
| --- | --- | --- | --- |
| J=1,...,5 | 210 states, 35 candidates | 1,10,317,318,199,49 at R=49 | t=1/4 |
| J=1,...,6 | 252 states, 42 candidates | 1,73,2200,2201,1431,343 at R=343 | t=1/6 |

Every candidate in its respective family fails at one of the five unit speeds.
The second family needs twelve coupled carry tags, adding cuts at 1/6 and
5/6 to the first family's ten tags. Treating the six carries as independent
values would change the contract. Conversely, the displayed states are
simultaneously realized by the actual integer speeds, so these certificates
are not artifacts of an unrealizable abstraction.

The expanded search used the predeclared 252-row bitmask model, unordered
seed pairs and at most three greedy additions. It found a cover after 26
seeds and 19,656 gain evaluations, with 10,584 mask-digit evaluations. Early
coverage is padded deterministically to five distinct rows; this example
needed no padding. Separate fixed verification checks all 210 unit/candidate
comparisons and all 42 top-speed bounds. Root replayed fixed verification and
the one-time ordinary control, matching both recorded outputs, and reconstructed
the original predeclaration hash. Root did not rerun discovery.

See the [initial scope audit](../research/astra-seven-adic-carry-scope-audit.md),
[initial independent review](../research/astra-seven-adic-carry-scope-review.md),
and [expanded-family report](../research/astra-seven-adic-expanded-falsifier.md).
The [expanded independent review](../research/astra-seven-adic-expanded-review.md)
accepted the exact counterexample. Its separate fixed program reconstructs the
author certificate from integer residues; root read and replayed it successfully.

## A different arithmetic primitive

The [difference-compression plan](../research/astra-prime-difference-compression-plan.md)
proposes a general-prime replacement for the rejected shortcut. For three
integer inputs and a chosen anchor, reduce the two oriented differences
modulo p^(m+1). If either difference collapses to zero, or their live prime
levels differ, successive unit corrections can place all three top digits
in two consecutive cyclic positions. The proposed two-target theorem allows
arbitrary prescribed digits at distinct levels, with nonzero targets at the
top level. No source implementation is included here.

The proof explicitly handles a difference divisible by the modulus and the
closed endpoint of a signed lift. A top digit p-1 does not imply that the
negative difference has top digit zero or p-1. Instead, transformed anchored
differences admit lifts in [-p^m,0], which directly gives the two-position
conclusion. Same-level differences remain a separate obstruction; compressing
one triple alone does not supply a common lonely time for other speeds.
The [independent compression review](../research/astra-prime-difference-compression-review.md)
accepted both proposed natural theorem contracts unchanged. Its fixed controls
cover eight triple fixtures, five prescribed-target fixtures, and negative
controls for the endpoint and current multiplier coefficient. Root read the
complete review and replayed its exact command successfully.

## Runner-count bridge and next work

Root inspected `BoundedRealReduction.lean`. Its seven-real-runner specialization
requires H8, including five moving integer speeds at their own threshold 1/6.
The current H6 provides moving counts one through four. A future six-moving
integer result at 1/7 cannot supply the stronger 1/6 case by duplication.
Both missing counts remain explicit obligations.

Renault's 2004 paper is a relevant source for the six-total-runner obligation.
Its main proof uses congruence classes modulo six, constrained maximization,
and finite phase lemmas. Root read Sections 1 through 6 in a
[copy of the published paper](https://compmath.wordpress.com/wp-content/uploads/2008/08/view-obstruction_a_shorter_proof_for_6_lonely-runners.pdf);
its DOI and metadata match the
[institutional record](https://www.tse-fr.eu/articles/view-obstruction-shorter-proof-6-lonely-runners).
The publisher page returned 403; no byte identity with that inaccessible PDF
is asserted. This reading supplies a next contract-review target, not an
accepted Lean implementation or independently completed source audit.

## Verification and publication

All six manuscripts and reviews were read, and the recorded fixed-only replay
commands passed. The [verification record](../research/astra-pass40-verification.json)
preserves exact report, program, command and output hashes, including measured
root replay results. Workflow structural validation and whitespace checks
passed. No Lean source has changed, and no dependency cache was restored for
these manuscript checks.
The storage report confirms no allowlisted build/cache paths are present.

Pass39 was published through PR38. Both required jobs passed, the exact
reviewed head 173f16275638c8d067d80b66b53094312294fbbf was merged, and remote
and local main were verified at 312158239315a3488cb522695b58c0a2fece7621.
An additional review-agent launch hit the runtime thread limit; existing Astra
agents were reused for independent cross-review. The actual goal remained active.
