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
| RED-01 | Reduce arbitrary real speeds to rational/integer speeds with exact closed boundary. | literature | `docs/real-to-integer-reduction.md` reconstructs BHK Lemma 8 and the exact dependency `RatLRC(m) ∧ RatLRC(m-1) → RealLRC(m)`; formalization is blocked on a proved multidimensional Kronecker orbit-closure theorem, not on denominator clearing. |
| RED-02 | Remove signs and common integer factors. | open | Elementary circle-distance invariances. |
| BASE-01 | Prove the one-moving-runner case constructively. | proved-lean | `LonelyRunner.oneMovingRunner`, with witness `t = 1/(2v)` and the exact half-period norm theorem. |
| BASE-02 | Prove further small dimensions without importing the conjecture itself. | open | Select a tractable, exact literature proof. |
| PART-01 | Prove the quantitative fast-runner insertion theorem mathematically. | proved-math | Exact proof and endpoint audit in `docs/fast-runner-insertion.md`. |
| PART-02 | Formalize the fast-runner insertion theorem in Lean. | proved-lean | `abs_circleNorm_sub_circleNorm_le`, `exists_small_shift_circleNorm_ge`, and `fastRunnerInsertion` in `LonelyRunner/FastRunnerInsertion.lean`. |
| PART-03 | Prove the minimum-scale residue-band structured class. | proved-lean | `circleNorm_ge_of_int_band`, `circleNorm_ge_of_abs_int_band`, and `minimumScaleResidueBands` in `LonelyRunner/StructuredClasses.lean`; the explicit witness and both closed endpoints compile. |
| PART-04 | Prove the two irrational rank-one-block structured class. | proved-math | Open good arcs plus an explicit reduction to irrational-rotation density in `docs/structured-classes.md`; the standard density dependency is cited to Weyl (1916), and Lean formalization remains. |
| PART-05 | Prove soundness of finite bad-set union and ordered selected-parent overlap certificates. | proved-lean | The five finite-set theorems in `LonelyRunner/ModularCertificates.lean`, culminating in `exists_mem_avoiding_ordered_of_sum_lt_card`, prove that either strict certificate leaves an uncovered candidate. |
| PART-06 | Prove the exact modular pivot bad-set count and connect a surviving residue to circle norm. | proved-math | The gcd/ceiling count and closed-boundary implication are proved in `docs/modular-pivot-certificates.md` and exhaustively tested against literal sets; their number-theoretic Lean layer remains open. |
| GEN-01 | Establish the elementary universal `1/(2n)` lower bound. | open | Formalize Haar/Lebesgue measure or a finite combinatorial equivalent. |
| FIN-01 | State and justify the published finite-checking theorem. | literature | Malikiosis--Santos--Schymura Theorem A; not yet formalized. |
| COMP-01 | Build a reproducible exact-arithmetic finite-instance checker. | proved-math | `scripts/check_integer_tuple.py` and `scripts/check_bad_sets.py`; 9 core checker tests pass, all 162 distinct tuples of 1--4 speeds from 1--8 meet the target, and the `(1,2,3,4)` bad-set inclusion--exclusion audit is exact. The checkers are exact Python, not yet kernel-verified. |
| COMP-02 | Prove the finite-extrema certificate theorem and verifier in Lean. | open | The exact Python checker enumerates common-cell endpoints and pairwise affine intersections; formal trust transfer remains. |
| COMP-03 | Reproduce the bounded residual pivot-certificate audit. | proved-math | `scripts/search_residual.py` exactly checks every primitive increasing tuple with 3--6 moving speeds and maximum speed 30; 7 residual-search tests bring the combined suite to 16. The two-parent condition covers all 305,677 residual tuples; this has no unbounded-speed consequence and is not a kernel-checked enumeration. |
| UNIF-01 | Prove that two fixed adjacent anchors uniformly dominate all remaining modular bad sets. | rejected | Exact counterexample `(1,2,3,4,5,7)`: the proposed strict bound fails at all six pivots even though exact pivot bad unions leave witnesses; see `docs/failed-approaches.md`. |
| FULL-01 | Prove or disprove the conjecture for all dimensions. | open | The recognized mathematical problem remains open. |
| AUD-01 | Independently audit every nonstandard imported theorem and all axioms. | open | `AxiomAudit.lean` covers the equivalences, base case, fast-runner theorem, and residue-band theorem and reports only `propext`, `Classical.choice`, and `Quot.sound`; the open status reflects that no final all-dimensional proof/import audit exists. |
| SOL-01 | Run iterative GPT-5.6 Sol Pro research/rebuttal loop in a separate Chat conversation. | proved-math | Session 001 records an initial `Thinking failed`, five exact objections and repairs, two structured-class lemmas, and a modular-certificate round whose false subsumption claim was corrected after exact counterexamples. No full proof resulted. |

No row may be promoted to `proved-lean` solely because a weak or incorrectly
quantified surrogate theorem compiles.
