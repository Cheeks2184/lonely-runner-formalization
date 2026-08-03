# Prompt 59: adversarial DPLP and prime-forcing comparison

Continue as GPT-5.6 Sol with Pro effort. Unrestricted Lonely Runner remains
open. Do not claim a proof unless every implication is complete. Preserve the
labels proved-lean, proved-math, computed finite evidence, conditional,
conjectural, rejected, and open.

## Audit of Response 58

The exact copied response had 28,319 characters, 28,431 UTF-8 bytes, and
SHA-256

`0a4fd013d20fae0e1f825aa925a42ad6797c14ab8ec9ef43fa304fee2ccf8d8f`.

Accepted at exact strength: signed-divisor certificate transport; pair-sum
cyclic-distance symmetry; third-order Bonferroni; the exact Bonferroni failure
at `(1,2,3,4,5,7)` with margins `(0,0,0,0,0,-6)` and safe counts
`(0,0,0,0,2,2)`; and the prime-forcing local-to-global implication conditional
on the published minimal-counterexample product bound.

Corrections:

1. The external solved-dimension status was stale. Peer-reviewed work reaches
   ten total runners; a separately unaudited 2026 preprint claims eleven
   through thirteen.
2. The supplied Python source/output were not recovered or replayed. Their
   71,039, 511,796, and 75,887 counts are not accepted evidence here.
3. The Malikiosis--Santos--Schymura product theorem is a primary-source
   dependency but is not yet formalized in this project.
4. Pair-sum, top-two, height compression, and uniform prime supply remain
   open.

## New Lean-verified DPLP bridge

Let an original tuple have `n` positive speeds `a_i`, put `N=n+1`, and let

`rho_M(x)=min(x mod M,M-(x mod M))`.

For a deleted index `k`, a deletion pivot certificate consists of a surviving
pivot index `j`, `p=a_j`, and candidate `0<=r<n*p`, `n∤r`, such that

`rho_(n*p)(r*a_i) >= p` for every `i!=k`.

The tracked Lean 4.32.1 module `DeletionPivotLifting.lean` now kernel-checks:

```text
deletion certificate for k
+ n*p <= N*rho_(n*p)(r*a_k)
-> explicit full witness time r/(n*p) at closed threshold 1/N.
```

It also checks the exact quantifier wrapper

```text
(forall k, Nonempty(Cert k))
+ ((forall k, Nonempty(Cert k)) -> exists k cert, ExceptionalGood(cert))
-> full witness.
```

The axiom probes use only `propext`, `Classical.choice`, and `Quot.sound`. This
is soundness only; existence of a lifting certificate is not proved.

The corrected DPLP conjecture is:

```text
For every primitive positive injective n-tuple a with
  max(a) > N+floor(N/3),
  some speed divisible by N, and
  forall k, Nonempty(Cert k),
there exist k and cert : Cert k with ExceptionalGood(cert).
```

Together with lower-dimensional pivot completeness, the Lean-verified
coefficient-three height theorem, and the direct time `1/N` when no speed is
divisible by `N`, DPLP closes induction and proves unrestricted
positive-integer LRC, hence unrestricted real LRC through the verified BHK
equivalence.

## Exact DPLP reformulation

For pivot `j`, `p=a_j`, and a canonical candidate `r`, define

```text
S_j(r)={i!=j : rho_(n*p)(r*a_i)<p}.
```

Then `r` certifies deletion `k` iff `S_j(r) subset {k}`. If `S_j(r)` is empty,
the candidate lifts immediately. If `S_j(r)={k}`, it lifts exactly when

```text
n*p <= N*rho_(n*p)(r*a_k).
```

Therefore DPLP failure means every available deletion certificate is a
singleton whose unique bad coordinate lies in the strict deep hole

```text
N*rho_(n*p)(r*a_k) < n*p.
```

This is an empty-or-shell-singleton problem, not a raw deletion-monotonicity
claim.

## Exact one-coordinate counts

Assume `n>=2`, let `m=n*p`, `g=gcd(a,m)`, `h=gcd(a,p)`. Among candidates
`0<=r<m`, `n∤r`, the deep-hole count is

```text
D(p,a)=
g*(1+2*floor((m-1)/(N*g)))
-h*(1+2*floor((p-1)/(N*h))).
```

The ordinary deletion-bad count is

```text
B(p,a)=
g*(1+2*floor((p-1)/g))
-h*(1+2*floor((p-1)/(n*h))).
```

These formulas have a complete multiplication-fiber proof: divide by `g` on
the full modulus and subtract `r=n*s` using
`rho_(n*p)(n*s*a)=n*rho_p(s*a)`. Seeded exact checking matched 5,000 cases.
The shell capacity is `B-D`.

The missing issue is overlap: coordinatewise bad/deep counts do not count
residues bad for exactly one coordinate.

## Exact adversarial results

No corrected-DPLP failure was found among 726,641 unique eligible primitive
tuples in targeted affine/N-mutations of `(1,3,4,7)`, N-spike families,
N-affine residue fibers, affine-consecutive families, and seeded CRT/residue
fibers. Separate complete small boxes contained 92,084 primitive
N-divisible tuples and again no failure. This is finite evidence only.

Do not strengthen DPLP in either of these false ways:

1. The lift need not use an N-divisible pivot. For
   `(1,2,6,8,10)`, `n=5`, `N=6`, pivot 6 has no empty or shell-singleton
   candidate; lifts occur through empty bad sets at pivots 8 or 10.
2. The premises do not force a phase collision between two deletion
   certificate sets. `(1,2,3,60)`, `n=4`, `N=5`, has pairwise-disjoint phase
   sets and still has lifts.

Raw lifting without the N-divisible premise is false at `(1,3,4,7)`, but the
direct time `1/5` works there.

## Mandatory task A: attack DPLP

Develop at least two materially different attempts before choosing one:

1. a weighted double count of empty, singleton-shell, and singleton-deep
   residues across all pivots and deleted coordinates;
2. an exact CRT/Fourier/incidence argument controlling residues bad for
   exactly one coordinate rather than only individual capacities;
3. a minimal-certificate exchange or phase argument that survives the two
   counterexamples above.

For every proposed inequality:

- state the full formula with strict/closed endpoints;
- prove it from exact sums or provide the smallest counterexample;
- evaluate it on `(1,3,4,7)`, `(1,2,3,60)`, `(1,2,6,8,10)`, the consecutive
  family, and the tracked OPT-ADD tuple
  `(15,21,40,48,56,105,126,280,1200)`;
- identify whether the N-divisible premise is used globally or at a chosen
  pivot;
- forbid selecting one certificate independently per deletion and then
  averaging without controlling the selector distribution.

The desired new theorem is a non-tautological `WeightedShellSurplus` whose
conclusion is an empty or shell singleton. If it is false, return an exact
counterexample to the inequality, not a weakened restatement.

## Mandatory task B: compare prime-forcing honestly

State the exact `UniformPrimeForcingSupply` contract with repeated residues,
every deletion-gcd condition, and the integer product bound. Determine whether
it is logically closer to unrestricted LRC than DPLP, or whether its local
cover theorem merely relocates the original difficulty. Seek one theoretical
condition implying prime forcing for a nontrivial infinite prime family. Test
it against residue collisions and known small-prime failures.

Do not rely on another dimension-by-dimension computation. A result counts as
material only if it supplies a dimension-uniform prime density, an eventual
prime theorem, a provable prime-product lower bound, or a reusable analytic
bound on the finite covers.

## Budget and required output

This is one major Sol turn. Recommend at most one next Lean declaration. Do
not spend the turn on coefficient two or another broad finite box.

Return:

1. exact status table;
2. complete proofs of every new proved-math lemma;
3. exact counterexamples to every rejected intermediate claim;
4. the first unsupported implication on each surviving DPLP attempt;
5. an adversarial ranking of DPLP, prime forcing, top-two, and height
   compression by distance to unrestricted LRC, probability, publishability;
6. a stop/continue decision for DPLP under its current budget;
7. no unrestricted proof claim without a fully replayed kernel-checked main
   theorem and audited equivalence statement.
