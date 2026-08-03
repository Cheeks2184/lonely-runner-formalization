# FULL-PROOF PRIORITY Prompt 58: unrestricted bridges

Continue the same Lonely Runner Conjecture project, but switch immediately to
FULL-PROOF PRIORITY MODE. Use GPT-5.6 Sol with Pro effort. Do not spend this
turn optimizing another bounded-height coefficient unless it directly proves
an all-N selector, supplies an explicit effective cutoff plus complete finite
verification, finds a genuine exact-selector counterexample, or proves a
lemma reusable without a height bound.

Unrestricted LRC is open. Do not claim otherwise. Preserve the strict status
labels proved-lean, proved-math, computed finite evidence, conditional,
conjectural, rejected, and open.

## Authoritative verified state

The project kernel-checks the canonical/stationary/positive-integer
equivalences, the endpoint-safe BHK real-to-positive-integer reduction, and
the exact finite pivot-certificate equivalence. In particular:

- `positiveIntegerConjecture_iff_pivotCertificateConjecture` makes the
  uniform positive-integer pivot certificate exactly equivalent to the
  positive-integer conjecture.
- `positiveIntegerConjecture_iff_divisorOrUncoveredPivotPrinciple` makes the
  divisor-or-uncovered-pivot dichotomy an exact reformulation, not an easier
  proved theorem.
- `pivotInsertionCase_iff_not_allPivotCandidatesCovered` identifies an
  uncovered candidate on one pivot grid with the exact modular certificate.
- bad-set sizes, pair intersections, triple intersections, and generalized
  CRT compatibility have exact Lean formulas.
- common scaling normalization, codimension-one divisor insertion,
  fast-runner insertion, cross-pivot scaling, small-denominator witnesses,
  generic finite descent, and the one-item relocation block identity are
  Lean-verified at their stated hypotheses.
- the strongest unconditional bounded-height theorem is
  `threeHeight_family_witness`: for `N=n+1`, maximum speed `N+t`, and
  `3*t<=N`, a common closed `1/N` witness exists.

Thus a height-compression theorem forcing a minimal counterexample to
`maxSpeed<=N+floor(N/3)` would close the positive-integer problem and, through
the verified reduction, unrestricted LRC.

## Authoritative obstructions

Do not recycle rejected sufficient conditions. Exact counterexamples already
reject uniform random/additive order surrogates, GCD clocks, fixed anchors,
anchor-star and dispersion-star inequalities, top-cycle, CHAIN3, fixed-depth
or several linear-depth correlation polynomials, fixed-row deletion
monotonicity, naive CRT independence, and a universal shifted/covering-radius
strengthening. Favorable exact pivot certificates still exist on the
displayed stress tuples; those are failures of sufficient conditions, not LRC
counterexamples.

The final coefficient-two sprint established only reusable obstructions and
conditional lemmas: bounded fixed J1 shift families cannot be uniform, and
punctured critical cores require higher-order arithmetic. Unless you can meet
one of the four concrete continuation outcomes in the first paragraph,
freeze that branch.

## Mandatory strategy generation

Develop at least three materially different unrestricted strategies before
selecting one. At least one must address each route A, B, and C below. For
every branch, give a short research contract containing:

1. exact theorem statement with all quantifiers;
2. bounded-height or unrestricted label;
3. complete implication chain to unrestricted LRC using named verified
   bridges above;
4. exactly one first unresolved lemma;
5. known obstructions and concrete falsification tests;
6. a stop condition;
7. a maximum budget measured in one major Sol turn, one exact finite sweep,
   and at most one Lean prototype before reassessment.

Rank branches first by logical distance to unrestricted LRC, second by
probability of success, and third by independent publishability. Additional
formal lemmas are not progress unless they materially shorten the implication
chain.

## Route A: minimal-counterexample height compression

Specify a well-founded ordering for a hypothetical positive-integer
counterexample. Candidate orderings include:

- minimal moving dimension, then primitive normalization, then maximum speed,
  then sum, then lexicographic tuple;
- fixed dimension, primitive normalization, then maximum/sum;
- a weighted height or pair-sum complexity compatible with witness lifting.

Target an exact theorem implying

`max_i a_i <= N + floor(N/3)`

for a selected minimal counterexample, where `N=n+1`. Investigate:

- common scaling and why it gives only primitivity;
- deletion gcd constraints from codimension-one insertion;
- modulus cover: every `2<=q<=N` must divide some speed;
- fast-runner comparability;
- largest-speed replacement or signed-divisor descent;
- replacement operations reducing maximum or sum while preserving positivity
  and injectivity;
- whether a witness for the smaller tuple lifts to the original tuple with
  the closed `1/N` boundary.

Do not infer bounded height merely from gcd normalization. For each proposed
replacement, prove the contrapositive witness-lifting statement at every
pivot, including the changed pivot, or exhibit its smallest failure.

The desired bridge is:

`MinimalCounterexampleHeightCompression`:
every least primitive counterexample under the chosen ordering satisfies
`3*(maxSpeed-N)<=N`.

If this exact target is implausible, identify the strongest weaker descent
statement that combines with a verified bounded-height theorem in finitely
many iterations; state the termination measure and endpoint threshold.

## Route B: uniform pivot certificate

Attack the exact open proposition directly: every positive injective integer
tuple has some pivot and candidate residue outside every strict bad-residue
set. Explore at least three of:

- top-two pivot comparison and cross-pivot injection;
- an aggregate coverage inequality summed over pivots;
- forced overlaps from exact pair/triple CRT formulas;
- additive energy or a low/high multiplicity decomposition;
- a growing-order moment polynomial that uses CRT table structure and is not
  tautological on `(1,...,n)`;
- Fourier/Riesz-product information translated into a finite pivot-grid
  inequality;
- LP duality, with the dual object interpreted arithmetically rather than as
  a restatement of bad-set coverage;
- state-adaptive relocation descent for an optimized deletion order.

Any proposed sufficient inequality must first be evaluated on all tracked
stress tuples and on the tight consecutive family. State precisely whether
strict inequality is required. If the criterion fails, return the exact
smallest counterexample and do not weaken the quantifier silently.

The preferred bridge is an unrestricted theorem whose conclusion is exactly
`PositiveIntegerPivotCertificateConjecture`, or a non-tautological sufficient
condition with a separately plausible arithmetic proof.

## Route C: descent, deletion, or induction

Seek an operation taking an arbitrary hypothetical counterexample to one of:

- a smaller-dimensional counterexample;
- a counterexample with smaller maximum speed;
- a lexicographically smaller primitive tuple.

The operation must state the reverse witness-lifting theorem exactly. Analyze
deletion of one speed, division by a deletion gcd, signed residue replacement,
largest-speed factor replacement, and fast-runner removal. Do not use
fixed-row deletion monotonicity; it is false.

One promising target is a sharpened divisor-or-uncovered-pivot principle that
is genuinely stronger than merely restating the exact equivalence: derive the
divisor branch from structural minimality, or derive a specific uncovered
pivot from failure of every admissible descent.

## Required adversarial work

1. Search primitive increasing tuples in a complete small domain for failures
   of every proposed A/C replacement or minimality claim. Record the exact
   domain, version, deterministic order, runtime, and source/output hashes.
2. Evaluate every B inequality on the repository's RF, GCD-clock, OPT-ADD,
   anchor-star, TOP-CYCLE, CHAIN3, and consecutive-family stresses.
3. Identify hidden uses of lower-dimensional LRC, open/closed boundary
   changes, nonattained suprema, quantifier interchange, or normalization that
   changes the tuple.
4. Ask an internal adversarial reviewer to attack the selected strategy and
   include its strongest objection.

## Formalization rule

Recommend at most one next Lean declaration per route. It must encode a real
bridge or a falsifiable descent invariant, not just a renamed form of LRC or
Hall. Label a theorem proved-lean only if it actually compiles under Lean
4.32.1 with no `sorry`, `admit`, custom axiom, placeholder, `unsafe`, or
`native_decide`, and report its axioms.

## Required output

1. Status table.
2. Three research contracts A/B/C, plus any materially different fourth.
3. Dependency graph from each contract to the exact unrestricted theorem.
4. Ranked recommendation with quantitative reason for the ranking.
5. Complete proof of every new proved-math lemma and exact counterexample to
   every rejected claim.
6. First unsupported implication for each surviving route.
7. Explicit stop/freeze recommendation for coefficient two.
8. No claim of unrestricted LRC without an independently replayed,
   kernel-checked exact main theorem and audited equivalence chain.
