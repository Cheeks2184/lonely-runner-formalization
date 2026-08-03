# Prompt 63: PRO-C deletion, descent, and induction

Start a **new GPT-5.6 Sol conversation with Pro effort**. This is PRO-C, an
isolated unrestricted research cell. Work only on deletion certificates,
reverse witness lifting, descent, and induction. Do not develop a
minimal-counterexample replacement merely to prove a height bound (PRO-A), or
direct all-pivot/top-two/Fourier coverage (PRO-B).

Unrestricted Lonely Runner remains open. Do not claim a proof without a fully
replayed kernel-checked main theorem and audited equivalence chain. Preserve
the labels `proved-lean`, `proved-math`, `computed finite evidence`,
`conditional`, `conjectural`, `rejected`, and `open`.

Coefficient two is frozen. Do not work on Gamma matching or another bounded
coefficient theorem.

## Correct formal status

The current Lean module proves only:

1. a **selected** deletion certificate satisfying the exact exceptional-good
   inequality gives the explicit full witness time `r/(n*p)` at the closed
   `1/(n+1)` threshold;
2. a neutral selector-consuming wrapper: if every deletion has a certificate
   and a selector implication is already supplied, the selected certificate
   yields the full witness.

The corrected DPLP structural contract and the complete induction bridge are
not formalized. The neutral wrapper does not prove the selector, height split,
`N`-divisible premise, or induction. DPLP remains conjectural.

## Exact deletion definitions

Let the original tuple have `n>=2` positive injective speeds
`a : Fin n -> Nat`, and put `N=n+1`. For deleted coordinate `k`, a deletion
certificate consists of a surviving pivot `j!=k`, pivot speed `p=a_j`, and

```text
0 <= r < n*p,
n does not divide r,
rho_(n*p)(r*a_i) >= p for every i != k.
```

The certificate is exceptional-good when

```text
n*p <= N*rho_(n*p)(r*a_k).
```

The shell lower boundary is closed. Do not replace `<=` with `<`, change the
modulus to `N*p`, or select one arbitrary certificate per deletion and average
without controlling the selector distribution.

## Exact unrestricted theorem contract

The corrected target is:

```text
CorrectedDeletionPivotLiftingPrinciple:
For every n>=2 and every primitive positive injective n-tuple a,
with N=n+1, if
  max(a) > N+floor(N/3),
  some speed a_q is divisible by N, and
  every deletion k has at least one deletion certificate,
then some deletion k has an exceptional-good deletion certificate.
```

This is an unrestricted induction contract because its hypotheses arise in
the residual branch of a least bad dimension; it is not a bounded-height
conclusion.

## Exact implication chain

```text
hypothetical least bad moving dimension n
  -> primitive normalization
  -> max(a) <= N+floor(N/3)
       -> verified threeHeight_family_witness -> contradiction
  -> max(a) > N+floor(N/3)
       -> no speed divisible by N
            -> direct time 1/N -> contradiction
       -> some speed divisible by N
            -> lower-dimensional pivot completeness gives a certificate
               for every deletion
            -> CorrectedDeletionPivotLiftingPrinciple
            -> selected exceptional-good certificate
            -> proved-Lean explicit full witness
            -> contradiction
  -> PositiveIntegerConjecture
  -> verified endpoint-safe real reduction
  -> unrestricted LRC.
```

Audit every structural arrow. In particular, do not call this chain
proved-Lean: only its final selected-certificate implication is formalized.

## Single primary unresolved lemma

`DELETION-CERTIFICATE-CORRELATION` is the only primary research target. It is
the exact selector conclusion of the corrected contract:

```text
Under primitivity, positivity, injectivity, the residual height inequality,
an N-divisible speed, and nonempty certificate sets for every deletion,
the union of those certificate sets contains an exceptional-good member.
```

Develop at least two materially different attacks before choosing one:

1. exact empty/shell-singleton versus deep-singleton incidence with genuine
   overlap control;
2. a deletion-safe continuous-maximizer or active-cycle argument, including
   an exact bridge back to canonical speed-valued certificates;
3. a minimal-certificate exchange or phase argument respecting all selector
   quantifiers.

Do not rename the selector conclusion as a lemma and count that as progress.

## Response59 candidate lemmas under independent review

For

```text
K_k = { t in R/Z : ||t*a_i|| >= 1/n for every i != k },
eta_k = max_{t in K_k} ||t*a_k||,
```

Response59 proposed:

- D4: if there is no full `1/N` witness, distinct `K_k` are pairwise
  disjoint;
- D5: if there is no full `1/N` witness, `K_k` is nonempty, and `t_k`
  maximizes the exceptional coordinate on `K_k`, some other coordinate is
  active at equality `1/n`;
- D6: **only under both no-full-witness and nonempty `K_k` hypotheses**, a
  self-loop-free choice of active coordinates has a directed cycle.

D4 and D5 are candidate `proved-math` statements pending the independent
PRO-E audit. D6 must not be stated from “DPLP failure” alone without deriving
no full witness and every `K_k` nonempty. Continuous maximizers need not be
canonical pivot certificates; prove an exact bridge or keep the conclusion
continuous. A directed cycle may avoid the `N`-divisible coordinate.

## Known exact obstructions

- Raw lifting is false at `(1,3,4,7)` for `N=5`: every deletion is
  certifiable but no certificate lifts. No speed is divisible by 5, so the
  direct time `1/5` handles the tuple. It is not an LRC counterexample.
- `(1,2,3,60)` refutes the proposed uniform first-order deep-plus-shell-pair
  positivity criterion while having lifts.
- `(1,3,4,5,18)` refutes the proposed uniform third-order deep-Bonferroni
  plus shell-pair positivity criterion while having closed-boundary lifts.
- `(1,2,6,8,10)` shows a lift need not use an `N`-divisible pivot.
- `(1,2,3,60)` also shows that pairwise phase collision is not forced.
- Fixed-row deletion monotonicity is false.
- Selecting one certificate independently for each deletion does not create a
  distribution suitable for averaging.
- Coordinatewise shell capacity does not control singleton multiplicity.

Treat all finite survival counts as computed evidence only.

## Product-threshold correction

Prime-forcing/product induction is not the primary target of this cell. If it
is mentioned as a comparator or auxiliary stop decision, use the exact
integer threshold

```text
n^n * product_{p in P_n} p
  >= binom(n+1,2)^(n*(n-1)).
```

This is the denominator-cleared form of the intended product comparison.
Reject garbled exponent notation, and do not use the published product bound
without auditing its exact dimension convention and hypotheses. Do not open a
second `UniformPrimeForcingSupply` research program in this cell; that would
violate the single-primary-lemma and non-overlap contracts.

## Mandatory falsification suite

For every proposed selector, exchange, cycle, or descent implication:

1. evaluate `(1,3,4,7)`, `(1,2,3,60)`, `(1,3,4,5,18)`,
   `(1,2,6,8,10)`, the consecutive family, and
   `(15,21,40,48,56,105,126,280,1200)`;
2. preserve the quantifier order
   `forall deletion, exists certificate`, followed by one globally justified
   selector;
3. enumerate all certificates, not one convenient certificate per deletion;
4. test CRT-structured, `N`-spike, affine-residue, large-`N`-multiple, and
   mutation families around the raw-lift failure;
5. for continuous arguments, compute all relevant connected components and
   maximizing choices and test cycles that exclude the divisible coordinate;
6. for canonical arguments, verify strict/closed endpoints and literal
   residues with a second implementation.

Return the first exact counterexample to every proposed strengthening. Do not
spend the turn on another broad box whose only conclusion is zero failures.

## Stop condition and maximum budget

Maximum budget for this cell:

- one major Sol Pro turn;
- one targeted exact adversarial sweep tied to the chosen correlation lemma;
- at most one Lean prototype for a surviving non-tautological bridge.

Stop and freeze the attempted route if it reduces to arbitrary per-deletion
selection, if its cycle can avoid every use of the divisible coordinate, if a
continuous argument cannot return to a canonical certificate when required,
or if its first inequality fails a mandatory tuple. Continue only if the
first unsupported implication becomes strictly narrower than
`DELETION-CERTIFICATE-CORRELATION`.

## Required output

Return:

1. an exact status table correcting the formal baseline;
2. fully quantified statements for the corrected DPLP contract, certificate
   sets, exceptional-good predicate, and chosen correlation lemma;
3. at least two materially different attacks before selecting one;
4. complete proofs for every new `proved-math` lemma;
5. exact counterexamples and literal residue/certificate tables for every
   rejected claim;
6. deterministic audit version, domain, order, runtime, source hash, output
   hash, and independent implementation agreement;
7. an explicit audit of D4/D5 and the missing D6 hypotheses if they are used;
8. the single first unsupported implication after the turn;
9. at most one next Lean declaration, only if it materially shortens the
   selector chain;
10. a stop/continue decision for each attempted mechanism and for corrected
    DPLP overall;
11. no height-compression, direct pivot/top-two, coefficient-two, or
    unrestricted LRC claim.

This prompt is queued packaging only. Its contents do not record submission or
a result.
