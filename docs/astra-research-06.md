# Astra research checkpoint 6

The unrestricted canonical conjecture remains unresolved. This pass makes the
current prime-count normalization question precise and supplies an exact checker
for one modulus/unit pair. A complete finite all-modulus decision reduction is
independently reviewed as manuscript mathematics; its engine is separate work.

## Exact residue contracts

`research/astra-union-supply-audit.md` proves that the allowed full-size,
actual-pivot, and robust multiple-zero normalizations are equivalent to explicit
A/B/R residue predicates, including both external-modulus regimes, independent
signs, arbitrary common lifts, and positive transformed representatives. The
coarse one-zero theorem is the single-zero case of R.

The proposed tuple (1,2,3,4,7,14) has an R certificate at M=66,c=1. The audit
explains the identity-base class behind that example, so it is not an obstruction
to the enlarged union. Global supply of A/B/R remains unproved. These contracts
assume an odd prime runner count; even a proof of their full supply would still
need the remaining count and canonical-formulation bridges for unrestricted LRC.

## Fixed-pair finder and independent verifier

`scripts/grid_normalization.py` accepts an odd prime N, a primitive distinct
positive tuple of length N-1, and a valid M>=2/unit c. It decides A/B/R for
that fixed pair and reconstructs an exact original-speed rational witness.
The optimized R check anchors the minimum zero base instead of enumerating
all signed partitions. Its independent verifier rechecks branch inequalities,
signed lifts, actual affine offsets, rounding, and original-speed distances.

On valid inputs, None means all three fixed-pair predicates fail. Invalid
inputs also return None, so rejection outside the stated domain is not a
nonexistence result. Failure to reconstruct a mathematically guaranteed witness
raises an internal error; it is not converted into a negative predicate answer.
Certificate numeric fields use exact integers and rational arithmetic.

## Finite all-modulus reduction

`research/astra-normalization-decision.md` partitions c/M into finitely many
velocity cells and numerator/denominator classes modulo N. A becomes linear;
anchored R becomes a Boolean combination of inequalities of degree at most two.
The pivot branch is a finite divisor/unit scan. Exact sign decomposition then
handles interval atoms and critical point atoms separately.

An elementary determinant and CRT construction proves that every feasible open
atom contains a coprime pair in its admissible classes. A rational point instead
forces its unique reduced numerator and denominator; an isolated irrational
point cannot be a ratio c/M. Strict boundaries are evaluated as stated. This
specifies a complete decision procedure for a fixed tuple without a modulus
cutoff. No symbolic engine, all-modulus failure for a tuple, or uniform supply
proof is delivered in this checkpoint.

Independent review is in `research/astra-pass6-review.md`. It compared 85,354
fixed cases to direct signed enumeration, independently checked all 10,102
returned witnesses, and checked 19,076 normalized formula cases plus 576 extra
density constructions. The final focused checker suite has eight tests; the
combined checker/workflow/ledger run has 40. Exact hashes and scope are recorded
in `research/astra-pass6-verification.json`.

No Lean source or pinned dependency changed. The prior full build and 346-report
trust audit remain the formal source checkpoint; the 7.69 GB rebuildable local
cache was removed after that verification batch. The current source-only and
Python work does not require restoring it.
