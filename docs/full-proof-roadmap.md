# Full-proof roadmap

This document is the decision record for **FULL-PROOF PRIORITY MODE**. The
primary objective is unrestricted Lonely Runner, not another isolated
bounded-height improvement. Results keep the repository-wide labels
`proved-lean`, `proved-math`, `computed`, `conditional`, `conjectural`,
`refuted`, and `open`.

## Exact unrestricted bottleneck

The kernel-checked integer statement is
`PositiveIntegerConjecture`: for every `n>=1` and every injective positive
tuple `speeds : Fin n -> Nat`, there is a real time at which every coordinate
has circle distance at least `1/(n+1)`.

Lean proves

```text
PositiveIntegerConjecture
  <-> PositiveIntegerPivotCertificateConjecture
```

in `positiveIntegerConjecture_iff_pivotCertificateConjecture`. The right side
asks for a pivot `j` and a candidate numerator `r` in
`pivotCandidates (n+1) (speeds j)` which lies in none of the strict bad sets
`pivotBadResidues (n+1) (speeds j) (speeds i)` for `i != j`.

Lean also proves

```text
PositiveIntegerConjecture
  <-> DivisorOrUncoveredPivotPrinciple
```

in `positiveIntegerConjecture_iff_divisorOrUncoveredPivotPrinciple`. This is
an exact reformulation: the uncovered-pivot alternative is not assumed or
proved uniformly.

The endpoint-safe BHK reduction and the canonical/stationary equivalences are
kernel-checked. Therefore proving either integer proposition above, with its
present quantifiers and closed boundary, proves the standard unrestricted
conjecture. The first unsupported implication is arithmetic: prove that the
finite strict bad sets fail to cover at least one pivot grid, or prove a sound
descent which reduces every hypothetical counterexample to a region already
covered.

## Priority and continuation rule

Branches are ranked by:

1. logical distance to unrestricted LRC;
2. estimated probability of closing their first unsupported lemma;
3. independent publishability.

Coefficient two receives one final audit sprint. After that it is frozen as a
documented milestone unless work targets one of these outcomes:

1. an all-`N` proof of the exact Gamma selector;
2. an explicit effective large-`N` cutoff plus complete verification below it;
3. a genuine counterexample to the exact Gamma selector;
4. an unrestricted lemma reusable in a full proof.

Conditional maps, wider bounded shift lists, larger finite sweeps, and another
coefficient-only formal lemma do not satisfy this continuation rule.

## Dependency map

```text
standard canonical LRC
  ^  proved-lean equivalence and endpoint-safe BHK reduction
PositiveIntegerConjecture
  ^
  +-- Bridge A: minimal counterexample has coefficient-three height
  |     ^
  |     +-- primitive/minimal normalization + global descent/compression
  |
  +-- Bridge B: a top-two or unrestricted pivot grid is not covered
  |     ^
  |     +-- exact bad counts + exact pair/triple CRT intersections
  |
  +-- Bridge C1: one lower-dimensional pivot certificate lifts
  |     ^
  |     +-- deletion-certificate correlation across all deleted coordinates
  |
  +-- Bridge C2: forced divisors exceed the counterexample product bound
        ^
        +-- a uniform supply of prime-forcing modular theorems
```

The coefficient-three endpoint is already `proved-lean`:
`threeHeight_family_witness` gives a closed `1/N` witness for `n=N-1`
positive injective speeds bounded by `N+t` when `t>0` and `3*t<=N`.

## Bridge A contract: minimal-counterexample height compression

### Exact target

Choose a hypothetical positive-integer counterexample first with minimal
moving dimension, then divide by the common gcd, then minimize the tuple

```text
(maximum speed, sum of speeds, sorted lexicographic tuple).
```

The target `MinimalCounterexampleHeightCompression` is:

```text
For N=n+1 and every such least primitive counterexample A,
3 * (max(A) - N) <= N.
```

Natural subtraction must be guarded by `N<=max(A)`; if `max(A)<=N`, the
existing small-height theorem already applies. Small dimensions are discharged
by the verified base cases.

### Scope and implication chain

This is an **unrestricted bridge**, not a bounded-height conclusion:

```text
least positive-integer counterexample
  -> primitive height compression
  -> threeHeight_family_witness
  -> contradiction
  -> PositiveIntegerConjecture
  -> standard LRC.
```

### Existing support

- Common positive scaling preserves every circle-distance row and permits
  primitive normalization (`proved-math`).
- Fast-runner insertion, codimension-one divisor insertion, small-denominator
  witnesses, and the fastest-pivot gap restriction are `proved-lean`.
- A minimal-dimensional primitive counterexample must satisfy deletion-gcd
  restrictions and cover every modulus `2<=q<=N` in the precise senses already
  recorded in the ledger.
- The verified coefficient-three theorem is exactly the desired endpoint.

### Evidence against naive forms

- Primitivity alone does not bound the maximum.
- Fixed-pivot signed replacement is not a global descent: other pivot moduli
  change, representatives can collide, and the changed pivot is asymmetric.
- Fixed-row deletion monotonicity is refuted.
- Sum-minimality cannot compare a replacement with larger maximum unless the
  ordering says so explicitly.

### Single unresolved lemma

`HEIGHT-DESCENT`: every least primitive counterexample above the
coefficient-three height admits a positivity- and injectivity-preserving
operation which either lowers dimension or strictly decreases the displayed
well-founded tuple, and every witness for the smaller object lifts to the
original at the closed `1/N` boundary.

### Falsification and stop contract

- Complete small search: primitive sorted tuples with `3<=n<=8` and maximum
  at most `40`, restricted successively by modulus cover, fastest-pivot gap,
  and deletion-gcd conditions. Test each proposed operation, not LRC itself.
- Every operation must be tested on all existing descent/RF/pivot stress
  tuples and on `(1,...,n)`.
- Reject an operation on its first exact failure; do not add an untestable
  “minimal counterexample” premise unless it follows from the chosen order.
- Reassess after **two major Sol Pro turns, one complete deterministic sweep,
  and one Lean prototype**. Freeze the exact compression route if no operation
  survives the changed-pivot witness-lifting audit.

## Bridge B contract: uniform pivot certificate

### Exact target

The preferred target is the existing
`PositiveIntegerPivotCertificateConjecture`. The nearest nontrivial
strengthening with substantial finite evidence is `TOP-TWO-PIVOT`:

```text
For every injective positive integer tuple with at least two coordinates,
one of the two numerically largest speeds has an uncovered pivot candidate.
```

Numerical top-two status must be expressed without an assumed indexing order,
or after an explicit finite reindexing.

### Scope and implication chain

This is an **unrestricted direct bridge**:

```text
TOP-TWO-PIVOT
  -> PositiveIntegerPivotCertificateConjecture
  -> PositiveIntegerConjecture
  -> standard LRC.
```

### Existing support

- Exact single bad-set cardinalities and exact pair/triple target-intersection
  counts are `proved-lean`.
- The fastest-pivot ratio and extremal-interval compression theorems are
  `proved-lean`.
- Saturated lower intervals and a common-grid top-two class are `proved-lean`.
- A deterministic top-two audit found no failure in 878,245 primitive box
  tuples and 86,745 structured mutations (`computed finite evidence`).
- Affine common-LCM fiber identities and quotient lifts are audited
  `proved-math`.

### Evidence against naive forms

- The endpoint-pivot restriction is false.
- A proposed fractional two-grid dual invariant is refuted at
  `(N,A,B)=(7,98,187)` even though the integral top-two instance is good.
- Coarse top-speed divisibility flags cannot choose which top pivot works.
- Fixed-depth and several growing-depth numerical moment polynomials are
  nonuniform or near-tautological on the consecutive family.
- Random/additive ordering, GCD-clock, fixed-anchor, star, top-cycle, and
  three-step sufficient conditions all have exact non-LRC counterexamples.

### Single unresolved lemma

`TOP-TWO-INTEGRAL-TRANSVERSAL`: in the residual large-gap/compressed-interval
regime, exact affine fibers and the integral lower-speed bad sets cannot cover
both robust top grids simultaneously.

This must be an arithmetic integral statement. The rejected fractional dual
cannot be reused as if it implied the integral claim.

### Falsification and stop contract

- Search top-two exactly on every new primitive box and on structured CRT,
  large-gap, saturated, deletion, and affine-fiber mutations.
- Evaluate each sufficient inequality on the RF, GCD-clock, OPT-ADD,
  anchor-star, TOP-CYCLE, CHAIN3, and consecutive-family stresses before Lean.
- A genuine exact tuple with both top grids covered refutes `TOP-TWO-PIVOT`
  and immediately ends this strengthening, while leaving unrestricted pivot
  existence open.
- Reassess after **three major Sol Pro turns, one targeted complete affine
  sweep, and one Lean prototype**. If only another fractional relaxation or a
  restatement of integral cover survives, freeze top-two and fall back to the
  unrestricted all-pivot form.

## Bridge C contract: deletion-pivot lifting induction

### Exact target

For a modulus `M`, write

```text
rho_M(x) = min(x mod M, M - (x mod M)).
```

Let the original tuple have `n` speeds and put `N=n+1`. For an index `k`,
`DelCert(a;k,p,r)` means:

1. `p=a_j` for some surviving index `j!=k`;
2. `0<=r<n*p` and `n` does not divide `r`;
3. for every `i!=k`, `rho_(n*p)(r*a_i)>=p`.

This is exactly a canonical pivot certificate for the deletion, whose moving
dimension is `n-1` and whose threshold is `1/n`.

The target `CorrectedDeletionPivotLiftingPrinciple` (`DPLP`) is:

```text
For every `n>=2` and every primitive positive injective n-tuple a with
  max(a) > N + floor(N/3),
  some a_i divisible by N, and
  for every k there exist p,r with DelCert(a;k,p,r),
there exist k,p,r with DelCert(a;k,p,r) and
  N * rho_(n*p)(r*a_k) >= n*p.
```

The quantifier order is essential: lower-dimensional LRC makes every deletion
certificate set nonempty, and DPLP may choose both the deletion and its
certificate. It does not claim that an arbitrarily preselected deletion
certificate lifts.

### Scope and implication chain

This is an **unrestricted induction bridge**. For a least bad moving
dimension, normalize by the common gcd and sort. Put `t=floor(N/3)`:

```text
hypothetical counterexample
  -> max<=N+t: threeHeight_family_witness, contradiction
  -> max>N+t and no N-divisible speed: t=1/N witness, contradiction
  -> max>N+t and an N-divisible speed
  -> lower-dimensional LRC certifies every deletion
  -> DPLP chooses a lifting deletion certificate
  -> full closed 1/N witness, contradiction
  -> PositiveIntegerConjecture
  -> standard LRC.
```

For a lifting certificate, use `tau=r/(n*p)`. Surviving coordinates have
distance at least `1/n>=1/(n+1)`. The added cross-multiplied inequality gives
the deleted coordinate distance at least `1/(n+1)`. No open-boundary limit or
supremum is used.

### Existing support

- The coefficient-three height endpoint, small-denominator witness, exact
  fixed-tuple pivot equivalence, and common-scaling normalization are already
  verified at their stated strengths.
- A deterministic Python 3.14.4 audit covers all primitive increasing tuples
  above the coefficient-three cutoff in the complete boxes
  `(n,max)=(3,60),(4,35),(5,25),(6,24),(7,20),(8,18),(9,16),(10,16)`.
- Of 402,517 above-cutoff tuples, 158,544 have no `N`-divisible speed and take
  the direct branch. The other 243,973 instantiate DPLP's `N`-divisible
  branch; exact deletion-certificate enumeration finds zero lift failures.
- The tracked corrected audit's source SHA-256 is
  `a152a8ed58f8257d2ce5f46f00a89d25bc9c4c9f4bc60d7b738a131f812ace1f`;
  stdout SHA-256 is
  `c2f7de1da569d246fab40075ff74a43e797ff0ad9bd2d085c4fe7b0737f934f8`.
  Runtime was 7.46 seconds. This is computed finite evidence only.
- `DeletionPivotLifting.lean` proves the sound implication from a selected
  certificate and the exceptional-coordinate inequality to the explicit full
  time `r/(n*p)`. It records the corrected DPLP proposition with the exact
  `n>=2`, positivity, injectivity, primitivity, strict-height, divisibility,
  and all-deletions premises, and proves a wrapper conditional on that
  proposition without interchanging quantifiers. These implications are
  `proved-lean`; the selector proposition itself remains open.
- A targeted adversarial audit found no counterexample among 726,641 unique
  eligible primitive mutation/CRT/affine tuples or 92,084 separate
  `N`-divisible tuples in complete small boxes. These counts remain scratch
  evidence until their exact source and expected output are promoted.
- For one coordinate, the exact deep-hole and ordinary bad-set counts are now
  `proved-math`; their difference gives a closed formula for shell capacity.
  The missing step is overlap-sensitive singleton counting, not evaluation of
  one coordinate.

### Evidence against naive forms

- The statement “speed 1 gives the witness `1/N`” is false: `(1,3)` at
  `N=3` has distance zero in its speed-3 coordinate. The correct direct
  condition is that **no** speed is divisible by `N`.
- Raw deletion lifting without the `N`-divisible premise is false. The exact
  tuple `(1,3,4,7)` has no lifting deletion certificate, although `1/5` is a
  direct full witness because none of its speeds is divisible by `5`.
- Lower-dimensional LRC proves only that each deletion certificate set is
  nonempty. It supplies no correlation between those sets and the exceptional
  coordinates.
- Fixed-row deletion monotonicity remains false and is not used by DPLP.
- A lift need not use an `N`-divisible pivot. At `(1,2,6,8,10)` with `N=6`,
  pivot 6 has no empty or shell-singleton residue; lifts occur at pivots 8 or
  10. The premise may identify the hard case without identifying the pivot.
- Pairwise collision of deletion-certificate phases is not forced. The tuple
  `(1,2,3,60)` has pairwise-disjoint deletion phase sets and still has lifts.

### Single unresolved lemma

`DELETION-CERTIFICATE-CORRELATION`: prove DPLP's final existential from the
family of nonempty deletion certificate sets and the presence of an
`N`-divisible coordinate. The result must use exact modular structure; merely
restating that one certificate lifts is not progress.

Equivalently, for each pivot candidate let `S_j(r)` be the nonpivot
coordinates in the strict deletion-bad set. A deletion certificate has
`S_j(r) subset {k}`. An empty set lifts immediately; a singleton lifts exactly
when its unique coordinate lies in the shell
`n*p/(n+1) <= rho_(n*p)(r*a_k) < p`. Under failure, every available deletion
certificate is a deep singleton. The current sharp target is therefore a
weighted shell-surplus inequality across pivots. Coordinatewise shell counts
alone do not control singleton multiplicity.

### Falsification and stop contract

- Search DPLP exactly, preserving its `forall deletion, exists certificate`
  premise and allowing the conclusion to choose a different certificate.
- Target CRT-structured families, large `N`-multiples, and mutations around
  the smallest raw-lift failure; do not spend the budget on another broad box.
- Reject every proof which averages over a certificate selected independently
  for each deletion without controlling the selector distribution.
- The first reassessment budget is **one major Sol Pro turn, the completed
  deterministic sweep above, one targeted adversarial construction search,
  and one Lean prototype of the sound implication**. Lower the route's rank if
  no non-tautological correlation inequality survives that budget.

## Bridge C2 contract: prime-forcing product induction

### Exact target

For `n>=3`, `N=n+1`, and a prime `p`, define `PrimeForcing(n,p)` as follows.
For every possibly repeated residue tuple `v : Fin n -> {0,...,N*p-1}` such
that every deletion together with `N*p` has gcd one and no coordinate is
divisible by `p`, there is `0<=r<N*p` with

```text
p <= rho_(N*p)(r*v_i)  for every i.
```

The target `UniformPrimeForcingSupply` is: for every unsolved `n`, there is a
finite set of distinct primes `P_n` satisfying `PrimeForcing(n,p)` whose
product is at least the published minimal-counterexample product bound

```text
B_n = (binom(n+1,2)^(n-1) / n)^n.
```

All floors/ceilings in an eventual formal statement must use the exact
integer version of the bound, not the displayed real shorthand.

### Scope and implication chain

This is an **unrestricted induction bridge**:

```text
lower-dimensional LRC
  -> primitive counterexample has every deletion gcd one
  -> PrimeForcing(n,p) forces p to divide the speed product
  -> every p in P_n divides the product
  -> product >= product(P_n) >= B_n
  -> published strict product upper bound, contradiction
  -> PositiveIntegerConjecture
  -> standard LRC.
```

The product upper bound is a primary-source theorem of
Malikiosis--Santos--Schymura, used by Rosenfeld's successful finite-dimensional
proofs. It has not been formalized in this repository and is an explicit
external dependency.

### Existing support and evidence against

- Rosenfeld's primary nine-runner paper proves the local forcing implication
  and combines finitely verified prime powers with the product bound.
- Trakulthongchai's peer-reviewed work extends the known result through ten
  total runners. A separate 2026 preprint claims eleven through thirteen; the
  repository does not treat those preprint computations as independently
  audited.
- Repeated residues modulo `N*p` are mandatory even for distinct speeds.
- Small primes may fail, and success in each fixed dimension gives no density,
  eventual-validity, or computable all-dimension supply theorem.
- The local forcing property is itself a growing finite cover statement and
  may encode nearly the original difficulty.

### Single unresolved lemma

`UNIFORM-PRIME-FORCING-SUPPLY`: prove enough prime or prime-power forcing
statements uniformly in `n` to exceed the exact product bound, without
performing an unrelated full cover search separately for every dimension and
modulus.

### Falsification and stop contract

- Test any proposed sufficient condition on residue tuples with collisions,
  every deletion-gcd constraint, and the modular cover obstructions in the
  primary implementations.
- Reject a density/eventual-prime claim at its first infinite residue-family
  obstruction; do not replace it by dimension-by-dimension computation.
- Reassess after **one major Sol Pro turn, one exact prime interval in one new
  dimension, and one Lean prototype of only the local-to-global divisor
  wrapper**. Freeze the uniform route if its condition is equivalent to the
  original finite cover or no dimension-uniform prime supply survives.

## Current ranking

| Rank | Bridge | Distance to LRC | Current assessment |
| ---: | --- | --- | --- |
| 1 | C1: deletion-pivot lifting | One modular correlation theorem | Sound lift is Lean-verified; exact shell counts and strong targeted survival narrow the gap to singleton overlap |
| 2 | C2: prime-forcing product induction | One uniform supply theorem plus an external product-bound dependency | Directly extends recent successful finite-dimensional work, but the local cover may remain LRC-hard |
| 3 | B: top-two/uniform pivot | One arithmetic theorem | Large mature finite evidence and exact formal target; several relaxations already refuted |
| 4 | A: height compression | One global descent lemma plus proved coefficient-three endpoint | High leverage, but current replacement operations are extremely sparse |

The ranking is provisional and must change when an exact counterexample,
proof, or budget stop condition is reached.

## Rolling material-progress record

| Date | Result | Label | Material effect on unrestricted path |
| --- | --- | --- | --- |
| 2026-08-02 | Entered FULL-PROOF PRIORITY MODE; fixed A/B/C contracts and budgets | research policy | Replaces coefficient-by-coefficient optimization with three explicit unrestricted bridges |
| 2026-08-02 | Response 57 fixed-shift obstruction: no finite fixed J1 shift family is uniformly row-nonempty | proved-math, independent finite checks | Does not shorten unrestricted path; supports freezing bounded translation variants |
| 2026-08-02 | Submitted Sol Pro Prompt 58 on A/B/C with adversarial contracts | research in progress | Strategy generation only; no theorem yet |
| 2026-08-02 | `RELOC-UNIF` refuted by the existing all-pivot OPT-ADD counterexample | computed plus exact finite inference | Removes a stale unrestricted branch; generic relocation identities remain valid |
| 2026-08-02 | Formulated DPLP and found zero failures in 243,973 exact `N`-divisible above-cutoff tuples | conjectural plus computed finite evidence | Supplies a new one-lemma induction bridge from lower dimensions and coefficient-three to unrestricted LRC |
| 2026-08-02 | Lean-verified the sound DPLP lift and exact selector wrapper | proved-lean | Removes every analytic, boundary, and quantifier-order concern after a lifting certificate is selected; only correlation remains |
| 2026-08-02 | Derived exact deep/shell coordinate counts and refuted two stronger pivot/phase intermediates | proved-math plus exact counterexamples | Narrows DPLP to overlap-sensitive singleton shell surplus and prevents two invalid proof shortcuts |
| 2026-08-02 | Audited Response 58 and added prime-forcing/product induction | literature-backed conditional route | Adds an unrestricted bridge used successfully in recent finite dimensions; its all-dimension prime supply remains open |

For every future entry, “material effect” must say whether the new result
removes a dependency, proves/refutes a bridge, improves a stop decision, or
merely adds independent partial information. The last category does not raise
a branch's priority.
