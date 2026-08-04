---
owner: GPT-5.6 Sol High top-level desktop orchestrator
supervising_authority: /root
launch_runtime: original browser-capable desktop Codex session
role: Research Pipeline Lead - prompt preparation only
task_id: PIPE-P80-DIVISOR-BLOCK-CONTRACT-196
base_commit: c2c0adc213c5df85a3f0fe64c87b5cc2b57dc3aa
admission: LAUNCH-READY
---

# Prompt 80: CANONICAL-DELETION-FAILURE-FORCES-DIVISOR-BLOCK

This is one isolated unrestricted Sol Pro research contract. It opens a new
minimal-counterexample/deletion route: delete a whole divisor block, lift a
lower-dimensional witness through a finite shift orbit, and use exact orbit
capacity to protect every exceptional coordinate. It is not the existing
single-deletion DPLP selector, signed-divisor height replacement, or Prompt65
first-blocker transfer.

Prove or decisively refute the exact structural lemma below. This file is only
a prepared contract. It is not a launch, active cell, result, proof, audit, or
status promotion. Only GPT-5.6 Sol High under `/root`, using the original
signed-in browser-capable desktop session, may launch it in a genuinely new
ChatGPT conversation with GPT-5.6 Sol and Pro effort. Sol Medium prepared the
specification. Luna may later replay one frozen bounded search or implement a
frozen local lemma; it may not search for the theorem.

## Accepted boundary and exclusions

Use accepted results only at their exact scopes.

- The real-to-positive-integer reduction, common-gcd normalization, exact
  pivot-certificate equivalence, coefficient-three bounded-height theorem,
  and the sound implication from a selected deletion certificate plus the
  exceptional inequality are `proved-lean` at their tracked hypotheses.
- The deletion-gcd bridge under lower-dimensional LRC and the elementary
  finite shift argument for one omitted coordinate are `proved-math`.
- Corrected DPLP is still `open`. Its finite sweeps are finite evidence only.
  Raw deletion lifting without the `N`-divisible premise is false at
  `(1,3,4,7)`. Pairwise intersection of deletion-certificate phase sets is
  false at `(1,2,3,60)`. A lift need not use an `N`-divisible pivot, as
  `(1,2,6,8,10)` shows.
- Response72 circuit escape and simultaneous-cover common-prime selection are
  stopped as LRC-equivalent. Prompt76 private-demand Hall, Prompt77 signed
  Gram/Fourier, and Prompt78 sparse-cover exchange are separate active cells.
  Assume no output from them.
- Do not use any unaccepted Prompt75 claim or recovered computation.

Excluded routes: prime forcing; whole-block packing; private-demand Hall;
signed Gram/Fourier; sparse minimal covers; Gamma matching; top-two ratios;
owner shifts; signed-divisor replacement; first blockers; reverse-grid
`Delta` descent; pairwise certificate intersection; or a restatement that a
full witness exists.

## Frozen deletion-certificate definitions

Let `n>=3`, put `N=n+1`, and let

```text
a : Fin n -> Nat
```

be positive and injective. Write

```text
rho_M(x) = min(x mod M, M-(x mod M)).
```

For a deleted index `k`, surviving pivot `j!=k`, and numerator `r`, define

```text
DelCert(a;k,j,r) iff
  0 <= r < n*a_j,
  n does not divide r,
  for every i!=k, rho_(n*a_j)(r*a_i) >= a_j.
```

This is the exact pivot certificate for the `(n-1)`-speed deletion at
threshold `1/n`. The pivot coordinate is included; its safety follows from
`n` not dividing `r` but may not be silently omitted in formal statements.

Order all deletion certificates for fixed `k` lexicographically by

```text
(a_j, j, r).
```

Injectivity makes the speed key strict. When the finite certificate set is
nonempty, call its unique least member `(j_k,r_k)`. Define

```text
CanonicalLift(a,k) iff
  N * rho_(n*a_(j_k))(r_k*a_k) >= n*a_(j_k).
```

This weak integer inequality is the closed full-LRC boundary. Its negation is
strict. Do not interchange `for every deletion` with `there exists one
certificate` and do not replace the canonical certificate after seeing the
exceptional phase.

## Frozen divisor-block definitions

For a nonempty proper subset `S` of exceptional indices, let

```text
T = Fin n \ S,
d = gcd(a_i : i in T),
g_k = gcd(d,a_k)                    for k in S,
q_k = d/g_k,
cap_N(d,a_k) = g_k * ceil(2*q_k/N),
ceil(x/y) = (x+y-1)/y               for positive y.
```

`S` is a **strict divisor block** when

```text
sum_(k in S) cap_N(d,a_k) < d.
```

All quantities are natural numbers. The subset `T` is nonempty, so its gcd is
positive. Repeated orbit points caused by `g_k>1` count with multiplicity in
the number of shifts excluded by coordinate `k`. Equality in the capacity
sum is not sufficient.

## Local whole-block lifting theorem to prove in this turn

This theorem is required support, not a second permitted open lemma:

```text
DIVISOR-BLOCK-WITNESS-LIFT:

If S is a strict divisor block and the divided survivor tuple
  b_i=a_i/d, i in T,
has a time t at which every survivor has circle distance at least
  1/(|T|+1),
then some h in {0,...,d-1} makes tau_h=(t+h)/d a full witness for a
at threshold 1/N.
```

Prove exactly:

1. survivor phases are unchanged modulo one at every `tau_h`;
2. the exceptional `k`-orbit has `q_k` distinct equally spaced phases, each
   repeated exactly `g_k` times among the `d` shifts;
3. the open bad arc of length `2/N` contains at most
   `ceil(2*q_k/N)` distinct orbit phases;
4. hence coordinate `k` excludes at most `cap_N(d,a_k)` shift indices;
5. strict union bound leaves one shift; equality phases are safe; and
6. `|T|+1<=n<N` gives the required survivor threshold comparison.

No continuity, irrational approximation, or unproved canonical pivot choice
is needed. If the displayed capacity bound is false at an endpoint, return
`STOP` rather than modifying it silently.

## Sole unresolved unrestricted lemma

Call `a` **hard-canonical-failure data** when all of the following hold:

```text
n>=3 and N=n+1,
a is positive, injective, and primitive,
max_i a_i > N + floor(N/3),
some a_i is divisible by N,
for every deletion k, its DelCert set is nonempty,
for every k, not CanonicalLift(a,k).
```

The sole permitted missing edge is:

```text
CANONICAL-DELETION-FAILURE-FORCES-DIVISOR-BLOCK:

Every hard-canonical-failure tuple a has a nonempty proper exceptional set S
which is a strict divisor block.
```

This theorem is unrestricted in dimension and height. It is not DPLP: it
does not seek a lifting deletion certificate and may return a full witness
from a lower-dimensional block deletion. It is not a statement only about
hypothetical counterexamples: it quantifies over every tuple satisfying the
explicit finite arithmetic and canonical-certificate premises, including
tuples that may already have a different full witness. Perform an explicit
anti-tautology audit. If the proof uses counterexamplehood, assumes no full
witness, or defines `S` from a known witness, return `STOP`.

Do not weaken the theorem to a sum-minimal counterexample, an unspecified
certificate selector, a noncanonical existential chosen after inspection, or
an additional hypothesis not derived in the implication chain.

## Complete implication chain to unrestricted LRC

Prove every branch and dependency, without claiming the missing lemma.

```text
induct on the number n of positive moving speeds
  -> Lean base cases n=1 and n=2
  -> normalize a hypothetical n-speed counterexample to primitive a
  -> if max(a)<=N+floor(N/3), use coefficient-three theorem
  -> otherwise, if no speed is N-divisible, t=1/N is a direct witness
  -> hard branch: max above cutoff and some speed N-divisible
  -> induction gives a nonempty DelCert set for every deletion
  -> if one canonical certificate lifts, existing sound lift gives witness
  -> otherwise frozen structural lemma gives strict divisor block S
  -> induction applied to divided survivor tuple on T gives its witness
  -> DIVISOR-BLOCK-WITNESS-LIFT gives a full witness for a
  -> contradiction in every branch
  -> positive-integer LRC
  -> existing proved-lean real/integer equivalence
  -> unrestricted real LRC.
```

The induction may delete more than one speed at the divisor-block branch;
state the strong induction hypothesis for every smaller positive dimension.
Handle `|T|=1` with the one-speed base. No external MSS theorem is used in
this route.

## Attack A: divisor lattice of the hard tuple

Study the divisor hypergraph

```text
prime powers ell^e  --  survivor subsets T on which ell^e divides every a_i.
```

Use primitivity and all-deletion gcd one exactly: no subset of size `n-1` has
gcd greater than one, but smaller survivor blocks may. Seek a canonical
maximal gcd block and compare its exceptional orbit capacities. Any sum,
valuation, or laminarity claim must be stated before inspecting a witness.

Explain why pairwise-coprime hard tuples, singleton survivor blocks, and large
`gcd(d,a_k)` multiplicities do or do not stop the route. Merely choosing the
largest speed as a singleton survivor is insufficient unless the strict
capacity inequality is proved.

## Attack B: canonical deletion failure forces divisibility

For each canonical deletion certificate write the unique centered exceptional
equation

```text
r_k*a_k = q_k' * n*a_(j_k) + e_k,
N*|e_k| < n*a_(j_k).
```

Use the complete survivor safety inequalities and canonical minimality to
derive actual common divisors on a survivor block. Any transition from a
centered equation to divisibility must retain gcds and prove both directions;
a small remainder is not zero. Do not use Prompt65 reverse-grid transfer or a
first-blocker potential.

A valid pivot theorem may replace the frozen structural lemma only if it is
an unrestricted arithmetic statement with a strictly smaller open edge and
does not introduce another existential of equal strength.

## Mandatory exact fixtures and falsification

Recompute all definitions from scratch.

1. Local success: `a=(2,4,5)`, `n=3`, `N=4`, survivor set `T={2,4}` and
   exceptional set `{5}`. Verify `d=2`, capacity `1<2`, all orbit
   multiplicities, and an explicit lifted shift.
2. Boundary failure: `a=(2,4,6)` with the same survivor positions. Verify
   capacity equals `d`; this is not a strict divisor block.
3. `(1,2,3,10)`: primitive, above the coefficient-three cutoff, and with an
   `N=5`-divisible speed. Show that those coarse premises alone do not force a
   divisor block; the canonical-failure premise may not be dropped.
4. `(1,3,4,7)`: preserve the exact raw-deletion-lift failure and verify why
   the `N`-divisible hard branch excludes it.
5. `(1,2,3,60)`: reject pairwise deletion-certificate intersection.
6. `(1,2,6,8,10)`: reject selection of an `N`-divisible pivot.
7. Pairwise-coprime, prime-power, CRT-structured, high-gcd, and common-scaling
   families. Primitivity is tuple gcd one, not pairwise coprimality.
8. Equality at the shell boundary, strict capacity equality, orbit collisions,
   `S` empty, `T` empty, singleton `T`, and malformed division data.

Before proof, run a fresh deterministic exact search over primitive strictly
increasing tuples

```text
3 <= n <= 6,
max speed <= 24,
tuple order first n then lexicographic.
```

Compute all deletion certificate sets, their frozen canonical members, the
hard-canonical-failure premise, every nonempty proper `S`, and the exact first
strict divisor block. Stop at the first premise tuple with no block and emit
the tuple, all canonical certificates and exceptional distances, every subset
gcd, every capacity term, and the failed sums. Separately run targeted
mutations of the four obstruction fixtures above up to maximum speed 120.

A first failure refutes only the frozen structural lemma, not LRC. Zero premise
rows must be reported as a vacuous scan, not finite positive evidence. Zero
failures on a nonempty completed premise domain are `computed finite evidence`
only. Any code must be separately hashed and declare exact interpreter,
command, ordering, counts, malformed-input behavior, and source/output binding.

## Route-overlap matrix

| Cell | Mathematical object | Missing edge | Forbidden overlap here |
| --- | --- | --- | --- |
| Prompt67/79 | bad primes and fixed obstruction integers | bounded nonzero obstruction extraction | no prime forcing or divisor graph |
| Prompt76 | canonical private tokens over all pivots | global demand/capacity Hall inequality | no private-token matching |
| Prompt77 | primitive signed character blocks | fixed-degree signed-Gram gap | no Fourier or spectral energy |
| Prompt78 | sparse inclusion-minimal owner covers | selected owner escape | no sparse-cover exchange |
| Prompt80 | block deletion and finite shift orbits | canonical deletion failure forces a strict divisor block | no single-deletion DPLP selector or first blocker |

If an argument crosses into another row's missing edge, return `STOP` and name
the duplicate rather than renaming it.

## Required response format

Return exactly:

1. **Disposition** -- `BRIDGE`, `PIVOT`, or `STOP`.
2. **Status table** -- exact evidence label and dependency per claim.
3. **Frozen definitions** -- certificate order, block types, gcds, capacities,
   and strict boundaries.
4. **Anti-tautology and route-overlap audit**.
5. **Local lifting theorem** -- complete orbit-count proof or first fatal edge.
6. **Exact fixtures and deterministic falsification** -- counts, hashes, first
   failure, and vacuity boundary.
7. **Attack A** -- divisor-lattice proof or first unsupported arrow.
8. **Attack B** -- canonical-failure arithmetic or first unsupported arrow.
9. **Complete implication chain** -- every induction and Lean dependency.
10. **Proof-obligation ledger and final evidence boundary**.

`BRIDGE` requires both the local lift and the frozen structural lemma at every
quantifier plus the complete implication. `PIVOT` requires a proved reusable
unrestricted theorem that strictly narrows the structural lemma. Finite
success, a conditional wrapper, or the local lift alone is never `PIVOT`.

## One-turn budget and STOP rules

Use one major Sol Pro turn: first third orbit proof/falsification, second third
divisor-lattice attack, final third canonical-failure attack and disposition.

Return `STOP` immediately on an exact structural counterexample; a false orbit
capacity; a proof using counterexamplehood or a known full witness; a hidden
second existential; a nonunit cancellation; gcd-one confused with pairwise
coprime; strict `<` changed to weak; a certificate chosen after inspecting the
exception; reappearance of DPLP correlation, Prompt65 first blockers, or any
Prompt76--78 missing edge; or bounded evidence only. A rigorous counterexample
or exact fatal-arrow memo is a successful turn. Do not edit the tracked
repository or claim unrestricted LRC.
