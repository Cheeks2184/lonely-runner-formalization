# Twenty-sixth Astra checkpoint: the exact finite-family equivalence

The unconditional equivalence
`LonelyRunner.conjecture_iff_allInclusivePrimitiveFiniteFamilies` is kernel checked
and independently reviewed at its exact canonical type.
Neither side of the equivalence has been proved independently; unrestricted
LRC remains unresolved.

## Exact remaining obligation

For N=m+2>=3, let C=[N(N-1)]^(N-2). The proposition
`InclusivePrimitiveFiniteFamily m` requires that every strictly increasing
natural tuple s on the original N labels, with s0=0, joint gcd one, and
s_last<=C, has a canonical lonely time for every chosen runner. Its bound is
inclusive and its threshold is the original closed 1/N. Time is unrestricted,
as in the canonical conjecture, and may depend on the chosen runner.

`AllInclusivePrimitiveFiniteFamilies` requires this for every m>=1. The final
Lean theorem proves exactly

```text
LonelyRunner.Conjecture ↔ LonelyRunner.AllInclusivePrimitiveFiniteFamilies
```

It has no extra lower-count or witness premise. There are finitely many speed
configurations at each fixed count, but the count quantifier is unbounded.
This checkpoint does not enumerate those configurations, establish the
finite-family proposition, or supply an algorithm proving all its instances.

## Formal bridge

`FiniteTupleSorting` reindexes any injective finite tuple in a linear order
into strictly increasing order, including empty and singleton types. The
permutation maps sorted labels to original labels.

`PrimitiveTupleNormalization` sorts an arbitrary injective integer tuple,
subtracts its minimum in integers, and divides the resulting natural row by
its joint gcd. The row contains zero, so gcd positivity is proved from a
nonzero endpoint. It returns a positive scale g, an integer translation c,
and the exact factorization a(e j)=c+g*b_j with b sorted and primitive.
This includes negative original speeds and two-label tuples.

`LonelyAtTransport` proves the canonical equivalence under any permutation,
translation, and nonzero real scale. It uses the inverse label e.symm r and
the inverse time T/g. Negative scales are allowed. Every original comparison
and the original denominator remain unchanged.

`FinitePrimitiveFamilies` combines these facts with the previously verified
large-height theorem. Given H_N and F_N at the current count, it splits the
normalized height into the inclusive low branch supplied by F_N and the
strict high branch supplied by H_N, then transports the witness back to the
arbitrary original integer tuple and chosen runner.

`FiniteFamilyEquivalence` derives H_N by strong induction on moving-runner
counts. Count one uses the existing base case; every inductive request has
strictly fewer moving runners than the current tuple. Appending zero gives
the stationary runner, which remains the selected last label. After proving
all positive-integer counts, the existing global BHK equivalence supplies
canonical LRC. The reverse implication specializes canonical witnesses to
the bounded primitive tuples. The finite-family proposition remains unproved.

The complete [contract and controls](../research/astra-finite-family-bridge-contract.md)
record the integer subtraction, joint-gcd, permutation direction, time scaling,
inclusive boundary, and count conventions.

## Limits of the endpoint approximation method

A separate [manuscript](../research/astra-uniform-finite-supply-audit.md) and
[independent review](../research/astra-uniform-finite-supply-review.md)
settle three precise properties of the endpoint approximation method:

- Allowing an auxiliary denominator q>=H does not enlarge the specified
  global small-error packet class: reduction modulo H preserves the actual
  speeds and residuals and restores 0<q<H.
- A global packet in that class requires
  H>=N(N-1)*floor(N/2)/2. Explicit primitive families attain equality at every
  N>=3. This is a bound on successful packets, not on counterexamples.
- Consecutive speeds 0,...,N-1 have no packet in the stated error class,
  even if a separate packet is chosen for each runner, but t=1/N directly
  witnesses the original conjecture for all their runners.

These are manuscript results supported by exact controls, not new Lean
claims. The review separately checks a packet that works for two individual
runners below the global packet-height bound, preserving the difference
between a single-runner error bound and a bound for every pair of labels.
Improved auxiliary margins and other witness constructions are outside this
negative result. The selected global packet route is frozen at this scope.

## Verification

The integrated source build passed 3,637 jobs and all 58 focused tests passed.
The root read all five complete source bodies. The independent manuscript
programs were replayed byte-exactly, including 24 independent packet instances,
16 strict denominator folds, 18 attained boundaries, 1,863 relative pair
checks, 5,376 fixed residue-map evaluations, and 518 consecutive comparisons.
These are controlled finite examples, not verification of any general F_N.

The trust audit accepted all 419 reports using only the permitted axioms.
The [independent source review](../research/astra-finite-family-formal-review.md)
and root saved-generator replay freshly elaborated all five complete bodies,
excluding their compiled imports directly and transitively. Eleven public
declarations, twelve named review theorems, twenty-two further kernel examples,
and 23 permitted-only axiom reports passed. Honest H_3/F_3 inputs exercise
below-, equal-, and above-cutoff signed original tuples; explicit controls
reject the wrong permutation and time direction. The exact probe and log
hashes reproduced unchanged. Storage cleanup and publication are recorded in the
[verification manifest](../research/astra-pass26-verification.json).

After verification stopped and the active researcher confirmed a command
hold, safe cleanup removed 7,747,979,982 bytes of rebuildable cache. Source,
Git history, the pinned toolchain, and the complete replay evidence remain.
The separate adaptive-margin audit is not part of this verified checkpoint.
