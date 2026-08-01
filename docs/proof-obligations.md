# Proof-obligation ledger

Statuses: `proved-lean`, `proved-math`, `literature`, `open`, `rejected`, and
`blocked-external`.

| ID | Obligation | Status | Evidence / next action |
|---|---|---|---|
| STMT-01 | Define circle distance and the closed lonely boundary. | proved-lean | `UnitCircle`, `circleDistance`, and `LonelyAt` use mathlib's quotient metric and `≤` against the distance. |
| STMT-01A | Complete the reusable circle-distance range, symmetry, and periodicity library. | open | `circleNorm_add_int` and the one-Lipschitz estimate now support insertion; explicit range and general symmetry/translation lemmas remain useful for later analytic work. |
| STMT-02 | Encode the canonical `forall runner, exists time` statement for injective real speeds. | proved-lean | `LonelyRunner.Conjecture`; unrestricted real time, total-runner denominator `N`, and closed boundary. The nonnegative-time and relative-velocity equivalences also compile. |
| STMT-03 | Prove equivalence with a distinct nonzero stationary tuple. | proved-lean | `conjecture_iff_distinctStationaryConjecture`; `Fin.lastCases` appends the stationary runner and `Fin.succAbove` enumerates exactly its complement while preserving the denominator. |
| STMT-04 | Extend the stationary tuple statement to repeated nonzero entries without hiding lower-dimensional induction. | proved-lean | `distinctStationaryConjecture_iff_stationaryConjecture` and the composed `conjecture_iff_stationaryConjecture`; the finite range is explicitly enumerated, its cardinal `m` satisfies `1 ≤ m ≤ n`, and the stronger `1/(m+1)` bound is weakened to `1/(n+1)`. |
| RED-01 | Reduce arbitrary real speeds to rational/integer speeds with exact closed boundary. | literature | Formal proof must expose Kronecker and lower-dimensional hypotheses; BHK Lemma 8. |
| RED-02 | Remove signs and common integer factors. | open | Elementary circle-distance invariances. |
| BASE-01 | Prove the one-moving-runner case constructively. | proved-lean | `LonelyRunner.oneMovingRunner`, with witness `t = 1/(2v)` and the exact half-period norm theorem. |
| BASE-02 | Prove further small dimensions without importing the conjecture itself. | open | Select a tractable, exact literature proof. |
| PART-01 | Prove the quantitative fast-runner insertion theorem mathematically. | proved-math | Exact proof and endpoint audit in `docs/fast-runner-insertion.md`. |
| PART-02 | Formalize the fast-runner insertion theorem in Lean. | proved-lean | `abs_circleNorm_sub_circleNorm_le`, `exists_small_shift_circleNorm_ge`, and `fastRunnerInsertion` in `LonelyRunner/FastRunnerInsertion.lean`. |
| PART-03 | Prove the minimum-scale residue-band structured class. | proved-math | Explicit witness and closed-band proof in `docs/structured-classes.md`; Lean formalization remains. |
| PART-04 | Prove the two irrational rank-one-block structured class. | proved-math | Open good arcs plus an explicit reduction to irrational-rotation density in `docs/structured-classes.md`; the standard density dependency is cited to Weyl (1916), and Lean formalization remains. |
| GEN-01 | Establish the elementary universal `1/(2n)` lower bound. | open | Formalize Haar/Lebesgue measure or a finite combinatorial equivalent. |
| FIN-01 | State and justify the published finite-checking theorem. | literature | Malikiosis--Santos--Schymura Theorem A; not yet formalized. |
| COMP-01 | Build a reproducible exact-arithmetic finite-instance checker. | proved-math | `scripts/check_integer_tuple.py` and `scripts/check_bad_sets.py`; 9 tests pass, all 162 distinct tuples of 1--4 speeds from 1--8 meet the target, and the `(1,2,3,4)` bad-set inclusion--exclusion audit is exact. The checkers are exact Python, not yet kernel-verified. |
| COMP-02 | Prove the finite-extrema certificate theorem and verifier in Lean. | open | The exact Python checker enumerates common-cell endpoints and pairwise affine intersections; formal trust transfer remains. |
| FULL-01 | Prove or disprove the conjecture for all dimensions. | open | The recognized mathematical problem remains open. |
| AUD-01 | Independently audit every nonstandard imported theorem and all axioms. | open | `AxiomAudit.lean` covers the equivalences, base case, and fast-runner theorem and reports only `propext`, `Classical.choice`, and `Quot.sound`; the open status reflects that no final all-dimensional proof/import audit exists. |
| SOL-01 | Run iterative GPT-5.6 Sol Pro research/rebuttal loop in a separate Chat conversation. | proved-math | Session 001 records an initial `Thinking failed`, a recovered strategy response, five exact objections and repairs, plus two subsequently audited structured-class lemmas. No full proof resulted. |

No row may be promoted to `proved-lean` solely because a weak or incorrectly
quantified surrogate theorem compiles.
