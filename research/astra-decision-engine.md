# Exact all-modulus normalization engine

Status: implementation complete; independent semantic review pending,
2026-09-05. The engine implements the accepted finite reduction for A/B/R.
It is a computational decision tool for these normalization contracts,
not a kernel proof or a decision procedure for LRC itself.

Owned artifacts in this pass:

* `scripts/grid_normalization_decision.py`
* `tests/test_grid_normalization_decision.py`
* This note.

No fixed-checker, Lean, workflow-state, or Git file was edited. No Lean cache
was restored. Current workflow/policy/state were read and workflow validation
passed. Root owns integration and publication.

## 1. Public use and result meanings

```python
from scripts.grid_normalization_decision import decide_normalization, replay_record

receipt = decide_normalization(7, (2, 3, 4, 7, 14, 9))
# Optional bound on logical cases, not a modulus cutoff:
bounded = decide_normalization(7, (2, 3, 4, 7, 14, 9), max_cases=5000)
assert replay_record(bounded)
```

The engine accepts exactly the fixed checker's domain: odd prime `N`, a
tuple of `N-1` distinct positive Python integers, and primitive gcd 1.
Booleans/floats, repeated speeds, nonprimitive tuples, and malformed counts
are rejected. The input must be a tuple, as in the underlying checker.

`FEASIBLE` contains a complete certificate reconstructed by
`find_fixed_normalization` and independently checked by `verify_certificate`.
`INFEASIBLE` is returned only after the finite B scan and every A/R
cell/class/anchor finish without a witness. It means no normalization in
this exact union, not a counterexample to LRC. `INCOMPLETE` means the
optional case limit interrupted enumeration; it has no negative meaning.

Invalid inputs raise `ValueError`. Symbolic/fixed-checker disagreement raises
`DecisionError`. Other arithmetic exceptions propagate. No error handler
turns a failure into `INFEASIBLE`.

The command-line interface supports both direct and module invocation:

```sh
python3 scripts/grid_normalization_decision.py 7 2 3 4 7 14 9 --max-cases 5000
python3 -m scripts.grid_normalization_decision 3 1 2
```

Output is a JSON receipt. Exit status is 0 for a completed result, 3 for
`INCOMPLETE`, and 2 for handled input/consistency errors. Unexpected arithmetic
errors exit unsuccessfully rather than emitting a negative decision.

## 2. Exact backend and completeness correspondence

The accepted manuscript reduction is implemented directly:

1. Enumerate all divisors `M>=2` of original speeds not divisible by `N`,
   and all units modulo these moduli, for the finite B branch.
2. Split `(0,1)` at all distinct velocity breakpoints `j/V_i`. A and R
   cannot hold at the breakpoints because an original residue is zero;
   B has already covered its possible breakpoint witnesses.
3. Enumerate every ordered class pair `(c mod N,M mod N)` except `(0,0)`.
   This includes `M` divisible by `N` and `c` divisible by `N`.
4. Construct the linear A formula and all eligible attained-minimum zero
   anchors for R. Signed residue classes use
   `delta_minus=m-delta_plus`, including the positive remainder correction.
   The anchored row formulas use `D=1+N*lambda` and degree-at-most-two
   comparisons, retaining non-strict coarse equalities.
5. Isolate all critical roots, evaluate every open sign atom exactly, and
   use the constructive CRT density lemma to produce a coprime rational
   pair in a feasible open atom. At a point atom, irrational points are
   rejected and rational points use their unique actual reduced pair.

The algebraic backend uses only `int` and `Fraction` arithmetic. A polynomial
is an ascending triple `(constant, linear, quadratic)`. Rational roots are
Fractions. Irrational roots use a primitive irreducible integer quadratic
with positive leading coefficient and lower/upper root index. Thus nonzero
scalar multiples of the same polynomial identify the same roots before
ordering begins. Double roots are deduplicated as Fractions. Constants and
identically zero polynomials produce no spurious critical points.

Strict rational isolating intervals are derived with integer square roots
of scaled discriminants. Two distinct irrational roots are ordered by
refining until their intervals separate; canonical equality rules out an
infinite refinement of equal roots. To evaluate another quadratic at a
root, reduce it modulo the minimal polynomial to a linear expression and
compare the root exactly with a rational threshold. No float conversion,
tolerance, approximate root equality, or sampled root ordering is used.

The core public helpers are:

```text
polynomial(c=0,b=0,a=0) -> ascending Fraction triple
real_roots(poly) -> tuple[Fraction | QuadraticRoot]
compare_points(x,y) -> -1,0,1
polynomial_sign(poly,x) -> -1,0,1
rational_inner_interval(left,right) -> two strict interior Fractions
prescribed_pair(N,u,m,left,right) -> coprime (c,M)
Compare(poly,strict=False), conjunction(...), disjunction(...)
solve_formula(formula,left,right,N,u,m,coverage=None)
  -> FormulaWitness(c,M,kind='open' or 'point') or None
cell_formulas(N,V,left,right,u,m) -> A and every eligible R anchor
decide_normalization(N,V,max_cases=None) -> JSON-compatible receipt
replay_record(receipt) -> exact deterministic rerun comparison
```

The optional `max_cases` counts one B unit pair or one A/R formula. It is
not a CPU, memory, factorization, integer-bit, or wall-clock bound. It does
not cap modulus sizes. Default `None` leaves the mathematically finite
enumeration unrestricted. Velocity-cell construction and exact root work
can be expensive when speeds or coefficients are large.

## 3. Verification completed

Command:

```sh
python3 -m unittest tests.test_grid_normalization_decision tests.test_grid_normalization -q
```

Result: **30 tests passed**, comprising 22 new engine/backend tests and the
8 existing fixed-checker tests. Additional direct CLI checks verified
completed positive, explicit incomplete, and invalid-input JSON/exit behavior.

The new controls include:

* Constant, zero, linear, rational, double, and irrational roots; canonical
  equality under positive/negative integer and rational scaling.
* Exact signs at quadratic roots and ordering across different quadratic
  fields. The roots `sqrt(2)` and `sqrt(2)+10^-60` were ordered and separated
  by a rational inner interval without tolerance.
* Strict/closed contradictory inequalities, coincident critical roots,
  excluded open-cell endpoints, and an isolated irrational feasible point
  `2*x^2=1` rejected as a rational witness.
* The singleton `x=3/196`, accepted only with actual classes `(3,0)` modulo
  7 and rejected in the tempting classes `(1,3)`.
* All 160 prescribed-pair constructions from the manuscript's two rational
  intervals and every admissible class at `N=3,5,7`.
* Exact agreement of generated A/R formulas with independent exhaustive
  signed-base enumeration on **780 fixed cases**, including **85 velocity
  boundary cases**. This compares both positive and negative predicates.
* All **32** cell/class/anchor formulas for `N=3,V=(1,2)`, evaluated to
  completion: **12 feasible** and **20 infeasible formula cases**. These
  are formula decisions, not an invented negative union instance.
* A/B/R reconstruction, both zero class regimes, receipt replay/tampering,
  explicit budget exhaustion, strict input checks, and exception propagation
  from failed reconstruction, failed certificate verification, or arithmetic.

No test assumes that an actual tuple is an all-modulus union obstruction.
The candidate negative in Section 5 is an independently reviewable engine
output, kept separate from the synthetic backend rejection controls.

## 4. Positive smoke controls

The complete engine found and independently verified:

| Input | Branch | `(M,c)` | Logical cases |
| --- | --- | --- | --- |
| `N=3, V=(1,2)` | A | `(48,7)` | 8 |
| `N=7, V=(1,2,3,4,5,31)` | B | `(31,1)` | 10 |
| `N=7, V=(1,2,3,4,7,14)` | R | `(5488,43)` | 49 |
| `N=7, V=(2,3,4,30,7,14)` | R | `(399951390721,54521169101)` | 969 |
| `N=7, V=(2,3,4,7,14,8)` | R | `(93427713,12762148)` | 377 |

The third row has `7|M`; the fourth has `7|c`. Thus the smoke controls
exercise both regimes that a modulus cutoff or unit-modulo-`N` assumption
would mishandle. Large constructed denominators are expected from the
elementary density proof. Every listed positive carries an actual original
time and passes the fixed certificate verifier.

## 5. Provisional complete negative, pending independent review

The bounded smoke run on

```text
N=7, V=(2,3,4,7,14,9), max_cases=5000
```

returned `INFEASIBLE` after **3395** logical cases, so it did not exhaust
the bound. Its coverage includes 24 velocity cells, all `24*48=1152`
arithmetic class cases, 1152 A formulas, 2232 R anchors, and 11 B unit
pairs. This output was rerun with `replay_record` and reproduced exactly.

**This negative is provisional until independent completeness review of
the final engine and receipt.** It is not used as an assumed unit-test
answer or promoted to an independently accepted mathematical obstruction
by this note. The original tuple itself has a strict witness at `1/5`,
with minimum distance `1/5>1/7`; even a confirmed negative concerns only
the A/B/R normalization union.

Compact exact receipt:

```json
{
  "N": 7,
  "V": [2, 3, 4, 7, 14, 9],
  "algorithm_version": 1,
  "status": "INFEASIBLE",
  "scope": "A/B/R normalization union only; not an LRC decision",
  "max_cases": 5000,
  "certificate": null,
  "discovery": null,
  "counts": {
    "a_cases": 1152,
    "b_moduli": 4,
    "b_units": 11,
    "cases": 3395,
    "class_pairs": 1152,
    "constant_false": 144,
    "formulas": 3384,
    "open_atoms": 13164,
    "point_atoms": 9924,
    "r_anchors": 2232,
    "root_sets": 3240,
    "velocity_cells": 24
  },
  "coverage_sha256": "0a6ce7c28901b555a65e478a87c3e6d94020da444aeb9b7db1a3be73fbb1a4c6",
  "sources": {
    "engine": "393cdc38eee2fdead8a3ef47bdad599917a5319e407d768b197c5997ffd8e5d1",
    "fixed_checker": "38bc58b6a53c044998a9b48d4fda8dc4a717fa6936dee9e8cb68935bf690cdb0",
    "manuscript": "6e3a76646f4f93dec9420a4285ffbdc8848b4437dc607a6485a555f7c7c4d89f"
  }
}
```

## 6. Replay scope, trust, and source hashes

The engine streams canonical formula/root/atom data into a SHA-256 coverage
digest and retains compact counts, selected discovery information, full
positive certificate when present, and source hashes. Enumeration order is
deterministic. A negative can therefore be independently rerun from the
small receipt without retaining large rebuildable atom dumps.

`replay_record` checks source/version identity and compares a full rerun
with the receipt, including its digest and counts. It is computational
replay, not a standalone negative-certificate proof checker or Lean theorem.
Review must still establish correctness of the exact engine and complete
enumeration. Every positive additionally goes through the separate fixed
finder and verifier. Arithmetic errors are never evidence of nonexistence.

Source SHA-256 values for this pass:

```text
scripts/grid_normalization_decision.py
  393cdc38eee2fdead8a3ef47bdad599917a5319e407d768b197c5997ffd8e5d1
tests/test_grid_normalization_decision.py
  43893659bea8251824d82c8dde6a50c55004ddbb05be0cdad4e462efb266985b
scripts/grid_normalization.py (unchanged dependency)
  38bc58b6a53c044998a9b48d4fda8dc4a717fa6936dee9e8cb68935bf690cdb0
research/astra-normalization-decision.md (accepted specification)
  6e3a76646f4f93dec9420a4285ffbdc8848b4437dc607a6485a555f7c7c4d89f
```

The semantic completion claim here is implementation of the specified finite
algorithm, with the stated computational tests and remaining independent
review. No uniform supply theorem, complexity bound, canonical LRC theorem,
or kernel-checked obstruction is claimed.
