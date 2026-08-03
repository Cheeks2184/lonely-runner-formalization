# Prompt 62: PRO-B unrestricted uniform pivot and top-two

Start a **new GPT-5.6 Sol conversation with Pro effort**. This is PRO-B, an
isolated unrestricted research cell. Work only on direct pivot coverage, the
top-two strengthening, exact CRT overlap, integral transversals, Fourier or
finite-grid inequalities. Do not develop minimal-counterexample height
replacements or deletion/descent induction; those belong to PRO-A and PRO-C.

Unrestricted Lonely Runner remains open. Do not claim a proof without a fully
replayed kernel-checked main theorem and audited equivalence chain. Preserve
the labels `proved-lean`, `proved-math`, `computed finite evidence`,
`conditional`, `conjectural`, `rejected`, and `open`.

Coefficient two is frozen. Do not work on Gamma matching, bounded translations,
or another coefficient-only selector.

## Exact definitions and unrestricted target

Let `n>=1`, `N=n+1`, and let `a : Fin n -> Nat` be positive and injective.
For a pivot `j`, put `p=a_j` and define the canonical candidates

```text
C_j = { r : 0 <= r < N*p and N does not divide r }.
```

A candidate is uncovered when

```text
p <= rho_(N*p)(r*a_i) for every i,
```

where `rho_M(x)=min(x mod M, M-(x mod M))`. The pivot coordinate is automatic
for a canonical candidate, but do not silently remove it without proving the
equivalence. Strict bad sets use `<p`; safety uses the closed boundary `>=p`.

The exact target is the existing unrestricted proposition:

```text
PositiveIntegerPivotCertificateConjecture:
For every n and every positive injective integer tuple a,
there exist a pivot j and r in C_j which is uncovered.
```

The preferred strengthening for this cell is:

```text
TOP-TWO-PIVOT:
For every positive injective tuple with n>=2,
one of the two numerically largest speeds has an uncovered
canonical pivot candidate.
```

State “two numerically largest” by an explicit finite reindexing or quantified
maximality conditions; do not assume the input indexing is sorted.

Both targets are unrestricted. TOP-TWO-PIVOT may be refuted while the exact
all-pivot proposition remains open.

## Exact implication chain

```text
TOP-TWO-PIVOT
  -> PositiveIntegerPivotCertificateConjecture
  -> verified PositiveIntegerConjecture equivalence
  -> verified endpoint-safe real reduction
  -> unrestricted LRC.
```

If TOP-TWO-PIVOT fails exactly, switch only to the all-pivot target; do not
weaken the quantifier or report an LRC counterexample.

## Single primary unresolved lemma

`TOP-TWO-INTEGRAL-TRANSVERSAL` is the only primary research target:

```text
In the exact residual regime after the verified fastest-pivot ratio,
large-gap, and extremal-interval reductions, the integral affine fibers and
strict lower-speed bad sets cannot cover both top canonical grids.
```

You must state the residual regime with all quantifiers and inequalities
before using this name. The conclusion must produce an actual integer
candidate on one of the two grids, not a fractional mass, LP relaxation, or a
restatement that one grid is uncovered.

## Verified ingredients at exact strength

- The positive-integer pivot-certificate equivalence is proved-Lean.
- Exact single bad-set cardinalities and pair/triple target-intersection and
  generalized CRT compatibility formulas are proved-Lean.
- Fastest-pivot ratio and extremal-interval compression results are
  proved-Lean at their stated hypotheses.
- Saturated lower intervals and a common-grid top-two class are formal partial
  results, not uniform TOP-TWO-PIVOT.
- Deterministic finite searches reported no top-two failure in 878,245
  primitive box tuples and 86,745 structured mutations. These are computed
  finite evidence only.

Do not infer the target from the finite counts.

## Known obstructions

- Endpoint-only pivot restrictions are false.
- A fractional two-grid dual invariant is false at
  `(N,A,B)=(7,98,187)`, although the corresponding integral top-two instance
  is good. Never reuse that fractional relaxation as an integral theorem.
- Coarse top-speed divisibility flags do not decide which top pivot works.
- Random/additive ordering, GCD-clock, fixed-anchor, anchor-star,
  dispersion-star, top-cycle, CHAIN3, and several fixed or growing moment
  conditions have exact non-LRC counterexamples.
- Fixed-depth and several linear-depth moment polynomials are nonuniform or
  nearly tautological on consecutive speeds.
- Naive CRT independence and pairwise-only overlap estimates are inadequate.
- An LP or Fourier certificate which encodes the full cover indicator without
  a separately plausible arithmetic inequality is only a restatement.

The DPLP and prime-forcing results from Response59 do not belong to this cell.
In particular, Response59 D4 and D5 are only candidate proved-math pending the
independent PRO-E audit; do not use them as inputs.

## Mandatory adversarial program

Develop at least three materially different integral approaches before
selecting one:

1. a cross-pivot injection or affine-fiber comparison between the two top
   grids;
2. forced overlap from exact pair/triple CRT tables, additive energy, or a
   low/high multiplicity decomposition;
3. a finite-grid Fourier/Riesz-product or LP-dual inequality whose dual object
   has an explicit arithmetic interpretation and is not the cover itself.

For every proposed sufficient inequality:

- state whether strict inequality is required;
- evaluate every term exactly on the consecutive family and the tracked RF,
  GCD-clock, OPT-ADD, anchor-star, TOP-CYCLE, and CHAIN3 stress tuples;
- test structured CRT, affine-fiber, large-gap, saturated, and deletion
  mutations;
- compare literal enumeration against a separate optimized implementation;
- return the smallest exact counterexample immediately on failure.

A clean exact tuple whose two top grids are both covered refutes
TOP-TWO-PIVOT and ends that strengthening. It does not refute the all-pivot
certificate or LRC.

## Stop condition and maximum budget

Maximum budget for this cell:

- one major Sol Pro turn now, within a route cap of three major turns before
  mandatory reassessment;
- one targeted complete affine/CRT sweep with declared finite bounds;
- at most one Lean prototype for a genuinely non-tautological integral
  inequality.

Stop TOP-TWO-PIVOT immediately on an exact two-grid cover. Otherwise freeze
the strengthening at the route cap if only fractional relaxations, cover
restatements, or criteria already rejected by the mandatory stresses survive.
Continue only when the first unsupported implication becomes strictly smaller
than `TOP-TWO-INTEGRAL-TRANSVERSAL`.

## Required output

Return:

1. an exact status table;
2. fully quantified statements of the all-pivot target, TOP-TWO-PIVOT, the
   residual regime, and `TOP-TWO-INTEGRAL-TRANSVERSAL`;
3. three materially different integral approaches and an adversarial choice
   among them;
4. complete proofs of every new `proved-math` lemma;
5. smallest exact counterexamples to every rejected criterion, with literal
   pivot-grid certificates;
6. deterministic sweep domain, version, order, runtime, source hash, output
   hash, and separate optimized/literal agreement;
7. the single first unsupported implication after the turn;
8. at most one next Lean declaration, only if it materially shortens the
   direct pivot implication chain;
9. a stop/continue decision for top-two and, separately, the all-pivot route;
10. no height-compression, DPLP, deletion-induction, coefficient-two, or
    unrestricted LRC claim.

This prompt is queued packaging only. Its contents do not record submission or
a result.
