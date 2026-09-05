# Twenty-fifth Astra checkpoint: a conditional finite-height theorem

The full conditional finite-height theorem is kernel checked and independently
reviewed at its exact public type.
Unrestricted LRC remains unresolved.

## The conditional finite-height argument

For N>=3, let Q=N(N-1). The precise smaller-count hypothesis H_N supplies a
stationary witness for every nonempty set D of distinct positive integers
with |D|<=N-2, at distance at least 1/(|D|+1). It does not assume LRC at
the current count or at every count.

Under H_N, the theorem proves that every primitive sorted
integer configuration

```text
0=s0<s1<...<s_(N-1)=H, gcd(s1,...,s_(N-1))=1,
H > [N(N-1)]^(N-2)
```

has a positive witness for each chosen runner at the original closed 1/N
threshold. Thus a primitive counterexample under H_N must lie in the
inclusive finite box H<=Q^(N-2). Denote the assertion that this box has no
counterexample by F_N. Neither F_N for all N nor an exhaustive certificate
for any new finite box is supplied here.

The proof approximates exactly N-2 internal normalized coordinates. A
pigeonhole argument gives 1<=q<=Q^(N-2), integer coefficients u, and rational
errors v such that s=p*u+v, p=H/q>1, both endpoint errors vanish, q*v is
integral, and |v_i|<=p/Q. Primitivity excludes an exact rank-one
approximation: it would imply H divides q, contradicting 0<q<H.

For any chosen runner, rank two makes the relative coordinate ratios
nonconstant. The adjacent-ratio BHK construction then gives a nowhere-zero
rational vector with two equal absolute values. H_N applies to its smaller
set of magnitudes and supplies a margin of 1/(N-1). Two free phases encode
this margin. Normalizing the second phase by its actual period q and
rounding to the nearest integer loses at most 1/[N(N-1)], leaving 1/N.
This uses BHK's algebraic construction; it asserts no compatibility of that
auxiliary vector with all relations of the original one-parameter orbit.

The [manuscript](../research/astra-affine-finite-height-audit.md) and
[independent review](../research/astra-affine-finite-height-review.md)
retain signed differences, arbitrary chosen runners, nonminimal periods,
negative auxiliary times, and all closed boundary equalities. No literature
priority or novelty claim is made.

## Completed formal components

The following modules have passed their individual Lean builds and axiom
probes. Independent combined source review accepted the seven underlying
components; a separate review accepted all twelve complete source bodies.

- `LowerCountSupply` defines exactly H_N, transfers it to distinct positive
  rational speeds by denominator clearing, and obtains the 1/(N-1) margin
  for a nonzero rational vector with at most N-2 distinct magnitudes.
- `BHKTwoPhaseSupply` combines the adjacent-ratio collision and that bounded
  supply to produce two free phases. It does not assert an actual-orbit
  witness by itself.
- `AffinePhasePeriod` moves a second phase to [q,2q), preserving every norm
  whenever q times each coefficient is integral. Period one is not assumed.
- `AffinePhaseTransfer` converts supplied affine margins into a positive
  nearby time. Its generic index type, integer first coefficients, real
  errors, and closed error bound permit both signs and rounding ties.
- `PositiveAffineWitness` composes those ingredients, and
  `SignedAffineWitness` extends the result to every nonzero signed affine
  comparison without changing the original count. Nonconstant ratios,
  H_N, a common period, and the quantitative error bound remain explicit.
- `SimultaneousApproximation` proves the unconditional finite-box theorem
  for any d real coordinates: some 0<q<=Q^d and integer vector z satisfy
  |q*x_i-z_i|<1/Q. The bound is strict, and d=0 and Q=1 are included.

`EndpointAffineApproximation` supplies the two exact endpoints without
approximating extra coordinates. `RationalPairRank` proves that anchored
rank two gives nonconstant relative ratios for any chosen runner.
`PrimitiveAffineRank` obtains H dividing q from the finite gcd if that rank
condition fails, contradicting 0<q<H. It does not require an individual
speed coprime to H or a supplied Bezout certificate. `AffineLonelyAt` retains
all original labels through `runner.succAbove` and the canonical relative
distance equivalence.

`LonelyRunner.primitive_sorted_largeHeight_lonelyAt` in
`FiniteHeightReduction.lean` composes these adapters. Its index type is `Fin (m+2)` with
m>=1, covering every N>=3. The only witness-supply assumption is
`LowerCountPositiveIntegerHypothesis (m+2)`. The caller supplies no rank,
approximation, period, nonconstant-ratio, or free-phase premise. The result
quantifies over every original runner and returns strictly positive time
and canonical `LonelyAt` at distance at least 1/(m+2).

The [contract plan](../research/astra-affine-formal-contract.md) records the
staged design. Formal evidence comes from the named declarations, their
exact source, and their verification. A later bridge from general integer
tuples must still formalize sorting, minimum translation, and gcd division;
it is not silently part of the already-primitive sorted theorem. Uniform
F_N and unrestricted LRC remain unsupplied.

## Verification record

The root replayed the frozen independent manuscript program: 143 rounding
lifts, 358 signed comparisons, and 16 exact target equalities passed. Its
controls also exercise denominator direction, the period, missing rank and
error hypotheses, negative phases, and the inclusive cutoff boundary.
These are targeted controls, not exhaustive finite-box verification.

The root's replay of the independent component review passed 10 generic
contract checks, 29 fixed controls, and 15 axiom reports. It freshly
elaborates all seven complete source bodies and proves its H_3 test premise
from a one-speed witness. The full integrated build passed 3,632 jobs, and
all 58 focused tests passed. The trust audit accepted all 408 reports using
only the permitted axioms.

The [final independent review](../research/astra-finite-height-formal-review.md)
and root replay freshly elaborate all twelve complete source bodies, excluding
their compiled imports directly and transitively. Nineteen public checks,
sixteen examples, six review theorems, and 25 exact permitted-only axiom
reports passed. Genuine H_3 and H_4 proofs support all-chosen-runner fixtures
(0,2,11) and (0,2,87,174); other controls cover signed slopes, periods 7 and 14,
zero internal coordinates, joint primitivity, and excluded hypotheses.
These controls do not supply uniform F_N. Exact hashes and commands are in
[the verification record](../research/astra-pass25-verification.json).

After all worker and root commands stopped, safe cleanup removed the shared
rebuildable cache (7,734,053,047 bytes). Source, pinned toolchain, Git history,
and the complete reproducible evidence were retained.
