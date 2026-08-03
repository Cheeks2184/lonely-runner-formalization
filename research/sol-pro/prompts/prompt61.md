# Prompt 61: PRO-A minimal-counterexample height compression

Start a **new GPT-5.6 Sol conversation with Pro effort**. This is PRO-A, an
isolated unrestricted research cell. Work only on minimal-counterexample
height compression. Do not work on pivot-cover inequalities, top-two/Fourier
arguments, deletion-certificate correlation, or a deletion induction; those
belong to PRO-B and PRO-C.

Unrestricted Lonely Runner remains open. Do not claim a proof unless the full
main theorem and audited equivalence chain are kernel-checked. Preserve the
labels `proved-lean`, `proved-math`, `computed finite evidence`, `conditional`,
`conjectural`, `rejected`, and `open`.

## Verified starting point

Let the moving dimension be `n>=1` and put `N=n+1`. The project verifies the
endpoint-safe reduction from real speeds to positive injective integer speeds,
the canonical and pivot-certificate equivalences, primitive scaling, several
small-denominator and insertion lemmas, and the bounded-height endpoint
`threeHeight_family_witness`.

At its exact strength, that endpoint says that positive injective speeds
bounded by `N+t`, with `t>0` and `3*t<=N`, have a common closed `1/N` witness.
It is a bounded-height theorem, not unrestricted LRC.

Coefficient two is frozen. Do not return to Gamma matching, bounded shift
lists, or another coefficient-only theorem unless it directly proves the
height-compression theorem below.

## Exact unrestricted theorem contract

Choose a hypothetical positive-integer counterexample by the following
well-founded order:

1. least moving dimension `n`;
2. divide by the common gcd, so the tuple is primitive;
3. sort the positive injective tuple increasingly;
4. minimize lexicographically
   `(maximum speed, sum of speeds, sorted tuple)`.

The target is:

```text
MinimalCounterexampleHeightCompression:
For every tuple a selected by this order, with N=n+1,
max(a) <= N + floor(N/3).
```

When `N<=max(a)`, the desired arithmetic form is

```text
3*(max(a)-N) <= N.
```

Guard natural subtraction explicitly. If `max(a)<=N`, use the existing
small-height branch rather than rewriting an unguarded subtraction.

This theorem is unrestricted because it constrains a least hypothetical
counterexample, not an arbitrary bounded family.

## Exact implication chain

```text
hypothetical positive-integer counterexample
  -> least-dimension primitive max/sum/lex counterexample
  -> MinimalCounterexampleHeightCompression
  -> max(a) <= N+floor(N/3)
  -> threeHeight_family_witness at the closed 1/N threshold
  -> contradiction
  -> PositiveIntegerConjecture
  -> verified endpoint-safe real reduction
  -> unrestricted LRC.
```

Every arrow must cite an existing verified theorem or be proved in full.

## Single primary unresolved lemma

`HEIGHT-DESCENT` is the only primary research target:

```text
Every selected least primitive counterexample above
N+floor(N/3) admits a positivity- and injectivity-preserving replacement
which either lowers moving dimension or strictly lowers
(maximum, sum, sorted lexicographic tuple), and whose use is sufficient to
contradict minimality.
```

You may design a replacement, signed-divisor operation, compression, or
well-founded descent only to prove this height bound. Do not turn the cell into
a general deletion/witness-lifting induction. If a proposed replacement needs
a reverse witness argument, prove that local argument completely—including
the changed coordinate and changed pivot—but keep its conclusion scoped to
`HEIGHT-DESCENT`.

## Known constraints and rejected shortcuts

- Primitivity alone does not bound the maximum speed.
- Common scaling gives normalization, not height compression.
- Modulus cover says that a counterexample must have some speed divisible by
  every `2<=q<=N`; it does not bound the maximum by itself.
- Deletion-gcd restrictions and fastest-runner comparison are necessary
  residual conditions, not a contradiction.
- A fixed-pivot signed replacement can change every other pivot modulus,
  collide representatives, break positivity or injectivity, and lose the
  changed-pivot witness.
- Sum minimality cannot compare a replacement with a larger maximum; use the
  declared order exactly.
- Fixed-row deletion monotonicity is false and belongs to PRO-C in any case.
- Sparse success of a replacement is not a uniform descent theorem.

Do not add an untestable “minimal counterexample” premise unless it is derived
from the declared order and verified structural lemmas.

## Mandatory falsification suite

Before recommending Lean work, implement a deterministic exact checker for
each proposed operation. At minimum:

1. enumerate primitive sorted tuples for `3<=n<=8`, maximum at most 40;
2. filter successively by modulus cover, fastest-pivot restrictions, and
   deletion-gcd conditions, recording counts at each stage;
3. test whether the operation is defined, positive, injective, primitive after
   normalization, and strictly decreasing in the declared order;
4. test its reverse witness statement at every pivot, including the changed
   pivot and the closed `1/N` boundary;
5. test the consecutive family `(1,...,n)`, every tracked signed-descent and
   replacement stress tuple, `(1,3,4,7)`, `(1,2,3,60)`,
   `(1,2,6,8,10)`, and
   `(15,21,40,48,56,105,126,280,1200)`.

Reject an operation at its first exact failure. Report the smallest witness
and the precise failed implication; do not patch it with a premise that is not
forced by minimality.

## Stop condition and maximum budget

Maximum budget for this cell:

- one major Sol Pro turn;
- one complete deterministic sweep over the declared domain;
- at most one Lean prototype encoding the actual descending invariant or
  reverse witness statement.

Stop and recommend freezing this exact route if no operation survives the
changed-pivot audit, if every surviving premise merely restates the absence of
a counterexample, or if the operation applies only to a sparse subclass with
no argument that least counterexamples lie there. Continue only if a concrete
operation survives all tests and materially shortens `HEIGHT-DESCENT`.

## Required output

Return:

1. an exact status table;
2. the fully quantified `MinimalCounterexampleHeightCompression` statement,
   including the well-founded selection order and subtraction guards;
3. at least two materially different height-descent attempts before choosing
   one;
4. complete proofs of every new `proved-math` lemma;
5. exact smallest counterexamples to every rejected replacement or lifting
   claim;
6. deterministic sweep domain, version, order, runtime, source hash, output
   hash, and stage counts;
7. the exact first unsupported implication remaining in `HEIGHT-DESCENT`;
8. at most one next Lean declaration, only if it is not a renamed form of the
   target;
9. an explicit stop/continue decision under the stated budget;
10. no pivot-cover, DPLP, prime-forcing, coefficient-two, or unrestricted LRC
    claim.

This prompt is queued packaging only. Its contents do not record submission or
a result.
