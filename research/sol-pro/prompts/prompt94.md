---
owner: GPT-5.6 Sol High top-level desktop orchestrator
supervising_authority: /root
launch_runtime: original browser-capable desktop Codex session
role: Research Pipeline Medium Lead - divisor-lattice contract only
task_id: SOL-P94-DIVISOR-LATTICE-CONTRACT-PREP-283
base_commit: d389ec8be54d63753719d603147c591ab37a3984
admission: REVIEW-REQUIRED
---

# Prompt 94: ALL-PIVOT UNIT-STRATUM MOBIUS DEFICIT

Prove or decisively refute one exact unrestricted strengthening of the finite
pivot-certificate theorem. At every pivot, decompose the covered candidate
residues by divisibility and exact gcd with the pivot modulus. Arithmetic
Mobius inversion isolates the unit gcd stratum. The sole new lemma asserts
that the total unit-stratum cover deficit over all labelled pivots is strictly
positive.

This is a prepared research contract only. It is not a browser launch, active
cell, response, proof, audit, computation, or evidence promotion. Only
GPT-5.6 Sol High under `/root`, using the original signed-in browser-capable
desktop session, may open a genuinely new ChatGPT conversation, explicitly
select GPT-5.6 Sol with Pro effort, submit a reviewed hash-locked prompt,
recover the response, assign independent audits, and decide status. Sol
Medium prepared the contract. Luna may later replay one frozen finite artifact
or implement one frozen local lemma; Luna may not search for this theorem or
operate the browser.

Use one major turn. Prove every quantifier of the sole target, give one exact
counterexample, or isolate one proved unrestricted theorem that strictly
narrows its first open arrow. Do not replace the unit stratum after a failure,
choose a favorable divisor family from the tuple, or claim unrestricted
Lonely Runner.

## Research contract

| Field | Frozen value |
| --- | --- |
| Exact target | `ALL-PIVOT-UNIT-STRATUM-MOBIUS-DEFICIT` below |
| Scope | every dimension `n>=2` and every positive injective integer tuple; unrestricted height |
| New structure | divisor-zeta layers of the covered multiplicity threshold, exact-gcd Mobius inversion, and the unit stratum |
| Complete chain | positive total unit deficit -> one unit candidate outside every bad set -> canonical pivot certificate -> integer LRC -> real LRC |
| Single unresolved lemma | strict positivity of the total unit-stratum deficit |
| Dependencies | elementary finite cyclic arithmetic, arithmetic Mobius inversion, Euler totient, and accepted Lean pivot/reduction equivalences |
| Falsification | two independent finite implementations, consecutive/scaled families, route-failure tuples, and exact boundary/collision/nonunit controls |
| Stop condition | first exact tuple with zero total unit deficit, a broken inversion/scaling identity, or reduction to the ordinary pivot existential |
| Maximum budget | one major Sol Pro turn; no Lean implementation before the arithmetic target survives |

The target is stronger than ordinary pivot-certificate existence because it
requires the numerator to be a unit modulo its pivot modulus. It is materially
narrower than unrestricted LRC as a research obligation: all new work is one
fixed exact-gcd stratum statement on the already finite pivot rows. It is not a
height bound, a selected-pivot heuristic, or a menu of weights.

## Accepted boundary and exclusions

Unrestricted LRC remains open. Use repository material only at its accepted
scope:

- `proved-lean`: exact positive-integer pivot-certificate equivalence;
- `proved-lean`: positive-integer/real-speed equivalence with positivity,
  injectivity, all quantifiers, circle distance, and the closed endpoint;
- `proved-lean`: candidate cardinality, pivot safety, exact strict bad-set
  counts, and exact pair-fiber intersection formulas at their hypotheses;
- `proved-math-qualified`: common scaling, labelled incidence Fubini
  identities, and elementary modular/gcd calculations at their stated scope;
- `computed finite evidence` only where an immutable independently replayed
  artifact is already identified; and
- `open`: the unit-stratum target, ordinary uniform pivot existence, and
  unrestricted LRC.

Prompt93's proposed common-clock rational score is excluded from this route;
the exact tuple `(1,3,4)` is a mandatory anti-reuse test below. Do not use a
Prompt93 score, denominator, common-clock occupancy, or inferred status as a
premise. Prompt91 is a separate prepared common-clock Fejer/Fourier route; no
Prompt91 result or evidence label is assumed here.

## Exact pivot rows and strict boundary

Fix `n>=2`, put `N=n+1`, and let

```text
a : Fin n -> Nat
```

be positive and injective. For each labelled pivot `j`, define

```text
p_j = a_j,
M_j = N*p_j,
rho_M(x) = min(x mod M, M-(x mod M)),

R_j = {r in {0,...,M_j-1} : N does not divide r},

B_i^j = {r in R_j : rho_(M_j)(r*a_i) < p_j}  for i!=j,

mu_j(r) = #{i : Fin n | i!=j and r in B_i^j}.
```

Representatives are canonical. Exactly `p_j` multiples of `N`, including
zero, are excluded, so `|R_j|=n*p_j`. Badness is strict: equality
`rho=p_j` is safe. Retain both cyclic sides, antipodes, reflection fixed
points, zero modular products, nonunits, repeated modular residues,
coincident bad sets, and all gcd-degenerate multiplication fibers. Pivot and
owner labels are never deduplicated.

For `r in R_j`, write `r=N*q+s` with `1<=s<=N-1` and prove

```text
rho_(M_j)(r*a_j)=a_j*min(s,N-s)>=a_j.
```

Thus `mu_j(r)=0` is exactly a canonical pivot certificate at row `j`.

## Divisor lattice and covered layers

Use `mob(d)` for the classical arithmetic Mobius function, not for the cover
multiplicity `mu_j`. Freeze

```text
mob(1)=1,
mob(d)=0                 if a prime square divides d,
mob(d)=(-1)^omega(d)     otherwise,
```

where `omega(d)` counts distinct prime divisors.

For every positive divisor `d|M_j`, define the divisibility-layer covered
count

```text
K_j(d) = #{r in R_j : d|r and 1<=mu_j(r)}.
```

`K_j(d)` counts residues, not owner incidences. Coincident labelled bad sets
still contribute separately to `mu_j`, but the threshold `1<=mu_j(r)` marks
the residue covered exactly once. No natural subtraction appears.

For every positive divisor `g|M_j`, define the exact-gcd covered count

```text
G_j(g) = #{r in R_j : gcd(r,M_j)=g and 1<=mu_j(r)}.
```

Prove the divisor-zeta and inversion identities in `Int`:

```text
K_j(d) = sum_(g|M_j, d|g) G_j(g),

G_j(g) = sum_(d|M_j, g|d) mob(d/g)*K_j(d).
```

In particular,

```text
G_j(1) = sum_(d|M_j) mob(d)*K_j(d).
```

The proof must exchange finite sums explicitly and use

```text
sum_(d|m) mob(d) = 1 if m=1, and 0 otherwise.
```

Do not replace exact gcd by `gcd(r,N)=1`, squarefree support, or a condition
on distinct residue values.

## Unit candidates and frozen deficit

Let `phi` be Euler's totient. Since `N|M_j` and `N>=3`, every canonical unit
residue modulo `M_j` is nonzero and lies in `R_j`. Hence the number of unit
candidates is exactly `phi(M_j)`.

Define in `Int`

```text
CoveredUnit_j(a) = sum_(d|M_j) mob(d)*K_j(d),
DefUnit_j(a) = phi(M_j) - CoveredUnit_j(a),
OmegaUnit(a) = sum_(j : Fin n) DefUnit_j(a).
```

Prove as elementary support, before using the open lemma,

```text
CoveredUnit_j(a) = G_j(1),

DefUnit_j(a)
  = #{r in {0,...,M_j-1} :
        gcd(r,M_j)=1 and mu_j(r)=0},

0<=DefUnit_j(a),

OmegaUnit(a)>0
  iff exists j,r,
       gcd(r,M_j)=1 and mu_j(r)=0.
```

The target is stated through the Mobius-transformed covered layers, but this
support identity is mandatory. Do not conceal an exact uncovered count behind
an unproved signed sum.

## Sole unrestricted lemma

Prove or refute exactly:

```text
ALL-PIVOT-UNIT-STRATUM-MOBIUS-DEFICIT:

For every n>=2 and every positive injective
a : Fin n -> Nat,

  OmegaUnit(a) > 0.
```

Equivalently, some pivot has a canonical certificate numerator coprime to the
entire modulus `N*a_j`. The unit condition is fixed before the turn. Do not
weaken it to `gcd(r,N)=1`, allow a tuple-dependent set of gcd strata, or fall
back to an arbitrary nonunit certificate.

An exact positive injective tuple with `OmegaUnit=0` returns `STOP`. It
rejects only this stronger unit-stratum bridge, not the ordinary pivot theorem
or LRC.

## Complete implication chain

Prove without the sole lemma:

```text
OmegaUnit(a)>0
 -> exists j, 0<DefUnit_j(a)
 -> exists r with gcd(r,M_j)=1 and mu_j(r)=0
 -> r in R_j and r avoids every B_i^j
 -> one exact canonical pivot certificate
 -> a closed 1/N Lonely Runner witness.
```

The second arrow uses finiteness and nonnegativity of every row deficit. Unit
membership implies `N` does not divide `r`; do not add candidate membership as
an unsupported assumption. Pivot safety is proved separately, including
equality.

Handle `n=1` directly with `N=2`, the unique pivot, and `r=1`. For `n>=2`,
apply the sole lemma and finish through the accepted directions

```text
unit pivot certificate
 -> PositiveIntegerPivotCertificateConjecture
 -> PositiveIntegerConjecture
 -> unrestricted real LRC.
```

State positivity, injectivity, all dimension quantifiers, and the closed
`>=1/(n+1)` endpoint. Do not describe the real/integer theorem as density.

## Common scaling and permutation

The target quantifies over nonprimitive tuples, so scaling must be exact. For
`h>=1`, put `A_i=h*a_i`. At pivot `j`, let `M=M_j(a)` and `M'=h*M`.

For each unit residue `r mod M`, the `h` lifts are

```text
r+t*M,  0<=t<h.
```

Prove that every lift has the same labelled badness pattern after scaling:

```text
rho_(h*M)((r+t*M)*(h*a_i))
  = h*rho_M(r*a_i).
```

Define

```text
s(h,M) = product {prime l : l|h and l does not divide M},
lambda(h,M) = (h/s(h,M))*phi(s(h,M)).
```

The empty product is one. Prove `s(h,M)|h`, `lambda(h,M)>0`, and exactly
`lambda(h,M)` of the `h` lifts are units modulo `h*M`, independently of the
chosen unit `r`. Consequently

```text
DefUnit_j(h*a) = lambda(h,M_j(a))*DefUnit_j(a).
```

The factor depends on the pivot modulus; do not claim
`OmegaUnit(h*a)=h*OmegaUnit(a)`. Positivity is nevertheless preserved in both
directions, permitting common-gcd normalization only after this theorem.

A permutation of speed labels permutes the pivot rows and owner labels and
preserves `OmegaUnit`. Prove this without sorting or deduplicating modular
collisions.

## Anti-equivalence and anti-tautology gates

The ordinary pivot theorem permits nonunit numerators. The exact row

```text
a=(1,2,3), N=4, pivot p=3, M=12
```

has safe candidate numerators `r=3,9`, both nonunits, while every unit
candidate in that row is covered and `DefUnit=0`. Equality
`rho_12(3*1)=3=p` is safe. Thus an ordinary certificate at a fixed pivot does
not imply unit-stratum deficiency at that pivot.

At the abstract row-system level, take two symmetric candidate rows:

```text
R_0={1,2} modulo 3, both unit points covered;
R_1={1,2,4,5} modulo 6, unit points {1,5} covered,
     nonunit points {2,4} uncovered.
```

This system has an ordinary certificate but zero total unit deficit. It need
not arise from speeds. It proves that candidate symmetry, cover definitions,
and the ordinary existential do not definitionally imply the sole lemma. New
arithmetic must exclude this pattern for speed-derived rows.

Reject any proof that expands all gcd strata and then invokes the ordinary
pivot existential, or defines a favorable stratum by first locating a known
certificate. The unit stratum is selected before the tuple is inspected.

## Symbolic stress families

### Consecutive family

For every `n>=2`, take

```text
a=(1,2,...,n), N=n+1.
```

At the pivot `p=1`, every unit `r mod N` permutes the nonzero residue classes
`r,2r,...,nr`. Prove every coordinate is safe, including the classes at
distance exactly one. Hence

```text
DefUnit_(p=1)(a)=phi(N),
OmegaUnit(a)>=phi(N)>0.
```

Then apply the exact scaling formula to every common multiple
`h*(1,2,...,n)`. This is a symbolic family theorem, not evidence for an
arbitrary tuple.

### Shared-factor and route-failure families

Test, without importing conclusions from stopped routes:

- pairwise-coprime and highly non-pairwise-coprime tuples;
- prime powers and tuples with several speeds sharing factors with `N`;
- the Prompt89/packing stress tuples already present in the repository;
- `(1,2,3,4,5,7)`, where naive row first-moment deficits fail;
- `(6,7,12,24,144)`, which killed a sparse-cover route;
- `(15,21,40,48,56,105,126,280,1200)`, without using any common-clock score;
  and
- the exact Prompt93 anti-reuse tuple `(1,3,4)`.

One target counterexample stops this contract immediately. A tuple with only
some covered unit rows does not.

## Mandatory exact hand controls

For each row report `(pivot p, M, phi(M), CoveredUnit, DefUnit)` and enough
`K_j(d)` values to verify the Mobius sum. Reproduce exactly:

```text
a=(1,2):
  (1,3,2,0,2), (2,6,2,2,0); OmegaUnit=2.

a=(1,3):
  (1,3,2,2,0), (3,9,6,4,2); OmegaUnit=2.

a=(1,2,3):
  (1,4,2,0,2), (2,8,4,4,0), (3,12,4,4,0);
  OmegaUnit=2, while pivot 3 has only the nonunit certificates 3 and 9.

a=(1,3,4):
  (1,4,2,2,0), (3,12,4,2,2), (4,16,8,6,2);
  OmegaUnit=4.

a=(1,3,13):
  (1,4,2,0,2), (3,12,4,2,2), (13,52,24,20,4);
  OmegaUnit=8.

a=(4,5,9):
  (4,16,8,6,2), (5,20,8,6,2), (9,36,12,10,2);
  OmegaUnit=6.

a=(1,2,3,4,5,7):
  DefUnit rows are (0,0,0,0,2,2); OmegaUnit=4.

a=(2,6,8)=2*(1,3,4):
  (2,8,4,4,0), (6,24,8,4,4), (8,32,16,12,4);
  OmegaUnit=8.
```

For `(1,3,4)` at pivot `p=3`, verify the full divisor layer

```text
M=12,
K(1)=7, K(2)=3, K(3)=3, K(4)=0, K(6)=1, K(12)=0,
CoveredUnit=7-3-3+1=2,
unit certificates={5,7}.
```

For `(1,2,3)` at pivot `p=3`, verify

```text
K(1)=7, K(2)=3, K(3)=1, K(4)=0, K(6)=1, K(12)=0,
CoveredUnit=7-3-1+1=4=phi(12),
DefUnit=0.
```

Boundary and malformed controls:

1. `rho_12(3)=3` is safe for pivot threshold `3`; changing `<` to `<=`
   must fail the equality control.
2. In `(1,3)`, pivot `1`, the other speed has zero modular product on both
   unit candidates and covers them strictly.
3. In `(1,3,13)`, pivot `3`, owners `1` and `13` have coincident bad sets but
   distinct labels. `mu` retains both labels; `K` counts a covered residue
   once.
4. Nonunit speeds and multiplication fibers in `(4,5,9)` are not cancelled.
5. `r=0` and every multiple of `N` are excluded from `R_j`; units are never
   excluded by a separate convention.
6. Reject `n<2`, zero, negative, noninteger, repeated-speed, wrong-length, or
   noncanonical residue input. Repeated modular residues and bad sets remain
   valid.
7. Deliberately omitting a squarefree divisor with nonzero `mob`, using
   `mob(d/g)` with the divisor order reversed, or performing the signed sum in
   `Nat` must fail a hand table.
8. Test a nontrivial permutation and common scales whose new prime factors do
   and do not divide the original pivot modulus.

## Deterministic falsification plan

Before a general proof, implement the definitions independently twice on

```text
2<=n<=5,
strictly increasing primitive tuples from {1,...,18},
ordered first by n and then lexicographically.
```

Implementation A directly enumerates unit residues with `gcd(r,M_j)=1`, then
tests every strict labelled bad predicate. Implementation B must not filter
covered residues by `gcd=1`; it constructs every `K_j(d)`, factors `M_j`,
computes `mob(d)`, and obtains `CoveredUnit` by the signed divisor sum. Shared
cover or unit-filter code is forbidden.

The contract-design preflight, which is not tracked or promoted, reports:

```text
n=2: 153 raw increasing tuples, 101 primitive;
n=3: 816 raw, 712 primitive;
n=4: 3060 raw, 2919 primitive;
n=5: 8568 raw, 8436 primitive;
total: 12597 raw, 12168 primitive, zero target failures.
```

Reproduce or reject every count. Zero failures are finite evidence only after
separate immutable replay; they are never a proof. Then test deterministic
structured mutations of every stress tuple above, with a declared seed and
at most `5000` tuples per dimension. A partial prefix is not a complete scan.

Any counterexample report must include `n,N,a`, every `M_j`, factorization and
divisor order, every `K_j(d)`, `CoveredUnit`, `DefUnit`, the direct unit-residue
oracle, completion markers, first-failure ordering, language/version, seed,
and source/output hashes. One disagreement between implementations stops the
computation without mathematical promotion.

## Route comparison matrix

| Route | Frozen object | Missing edge | Forbidden substitution here |
| --- | --- | --- | --- |
| Prompt67/79 | varying prime moduli and obstruction supply | enough distinct good primes | no prime supply, deletion-gcd premise, or MSS product bound |
| Prompt89 | balanced junction bags | one strict junction deficit | no bags, separators, Gamma, or component penalties |
| Prompt90 | fastest covered pivot and internal minimal covers | external owner/redundancy structure | no selected maximal covered row or cover deletion |
| Prompt92 | one large dyadic fixed grid | cover forces product divisibility | no dyadic threshold, repeated residue tuple, or MSS induction |
| Prompt93 | false common-clock rational score | universal score positivity | no common clock, occupancy denominator, or reciprocity score |
| Prompt91 | common-clock Fejer convolution | positive translate | no kernel, Fourier smoothing, or selected translate |
| Prompt66 | whole-block packing | integral capacity-respecting selection | no tokens, parent blocks, LP dual, radial descent, or phase cells |
| Height compression | least counterexample and replacement | bounded maximum speed | no minimal-counterexample or descent premise |
| Owner-aware multishift | fixed translated owner sets | finite transversal | no unchanged shift family |
| Prompt80 | deletion divisor blocks | canonical failure forces strict block | no deletion, lower-dimensional witness, or shift orbit |
| Prompt94 | covered divisibility layers at canonical pivots | positive unit-stratum deficit | only the exact unit gcd stratum and Mobius inversion above |

If an argument needs another row's open edge, return `STOP` or `OPEN` and name
the dependency. Do not rename it as divisor-lattice progress.

## Required proof lanes

### Lane A - zeta/Mobius cover conservation

Derive exact formulas for `K_j(d)` from the strict cyclic intervals and the
congruence `d|r`. Use exact gcd/lcm compatibility, including `gcd(d,N)>1`,
and seek an all-pivot conservation law making

```text
sum_j (phi(M_j)-sum_(d|M_j) mob(d)K_j(d))
```

positive. A union bound or the already false unstratified first moment is not
enough. State the first term that cannot be controlled.

### Lane B - Ramanujan and exact-gcd characters

Use the exact unit indicator

```text
1_[gcd(r,M)=1] = sum_(d|gcd(r,M)) mob(d)
```

or equivalent Ramanujan sums to express covered-unit counts. Any Fourier or
character calculation stays inside one pivot modulus and is organized by
exact gcd; a common-clock kernel or selected translate is prohibited. Prove
every normalization and zero-frequency term. A character identity alone is
support, not the missing positivity theorem.

### Lane C - minimal full unit covers

Assume every unit stratum is covered. For each pivot select an
inclusion-minimal labelled owner cover of the unit group only. Use private
unit residues, multiplication by units, and exact divisor fibers to derive a
cross-pivot incompatibility. Deleting or merging owners is allowed only after
proving labels, injectivity, and every other pivot row remain valid. This is
not Prompt90's fastest-row redundancy theorem.

### Lane D - prime-power divisor assembly

Factor each `M_j` and analyze how strict arcs pull back to its unit group over
prime-power quotients. Seek a local conservation or incompatibility theorem
that assembles by the generalized CRT, including noncoprime factors and
endpoint equality. This lane must stay at the canonical moduli `N*a_j`; it may
not become Prompt67 prime forcing or Prompt92 dyadic product divisibility.

## Required response schema

Return exactly these sections.

1. **Disposition** - `PROVE`, `PIVOT`, `STOP`, or `OPEN`.
2. **Independent boundary audit** - accepted inputs, excluded routes, and
   evidence labels.
3. **Pivot definitions** - representatives, candidates, strict badness,
   multiplicities, labels, zero products, and collisions.
4. **Divisor lattice** - `K`, `G`, arithmetic `mob`, zeta identity, inversion,
   and all finite divisor orders.
5. **Unit deficit support** - totient count, signed-sum interpretation,
   nonnegativity, and exact certificate extraction.
6. **Scaling and permutation** - `s(h,M)`, `lambda(h,M)`, lift counts,
   pivot-dependent factors, and label laws.
7. **Anti-equivalence** - the pivot-3 nonunit row, abstract two-row fixture,
   and proof that no ordinary certificate is imported.
8. **Symbolic families** - consecutive tuples, common scales, and shared-factor
   stresses.
9. **Hand controls** - every exact row, boundary, collision, nonunit,
   malformed, and deliberate-failure check.
10. **Independent falsification** - two implementations, complete domain,
    counts, first failure, versions, seed, and hashes where used.
11. **Lane A** - conservation proof or first unsupported term.
12. **Lane B** - character proof or first unsupported coefficient.
13. **Lane C** - minimal unit-cover theorem or obstruction.
14. **Lane D** - prime-power assembly or exact incompatibility failure.
15. **Sole lemma** - complete proof, exact counterexample, or unchanged open
    status at every frozen quantifier.
16. **Complete implication chain** - include `n=1`, candidate/pivot safety,
    exact Lean directions, and real reduction.
17. **Proof-obligation ledger** - claim, dependency, evidence class,
    falsification, first open edge, and recommended downstream owner.
18. **Final evidence boundary** - separate `proved-lean`,
    `proved-math-qualified`, response reasoning, finite computation,
    conditional, rejected, and open.

`PROVE` requires the sole lemma at every quantifier, all support identities,
and the complete implication chain. `PIVOT` requires one proved unrestricted
arithmetic theorem that strictly narrows the unit-stratum target without
adding an equally strong existential, ordinary pivot certificate, selected
favorable divisor, or excluded route. Mobius inversion, finite zero failures,
or a conditional wrapper alone is not `PIVOT`.

## One-turn budget and fail-closed rules

Use the first quarter for support identities, exact hand controls, and both
falsifiers; the second quarter for Lane A and the consecutive/scaling
families; the third quarter for Lanes B and C; and the final quarter for Lane
D, disposition, implication chain, and obligation ledger. Do not prototype
Lean unless the unrestricted arithmetic lemma first has a complete paper
proof.

Return `STOP` immediately on:

- an exact positive injective tuple with `OmegaUnit=0`;
- a mismatch in any hand table or deterministic-domain count;
- failure of zeta inversion, the unit-candidate implication, nonnegativity,
  scaling lift counts, or permutation invariance;
- changing exact gcd one to `gcd(r,N)=1` or a tuple-selected divisor set;
- natural-number evaluation of a signed Mobius sum;
- weak badness, removal of a cyclic side, omitted antipode, or lost collision;
- deduplicating owner labels before computing `mu`, or counting a covered
  residue once per owner in `K`;
- using an ordinary certificate, LRC, or counterexamplehood as a premise for
  unit-stratum positivity;
- expanding all gcd strata and reconstructing the unrestricted uncovered
  indicator before selecting the unit stratum;
- dependence on Prompt67/79, Prompt89, Prompt90, Prompt91, Prompt92, Prompt93,
  packing, height compression, divisor-block deletion, or unchanged
  multishift;
- bounded computation offered as a universal theorem; or
- silent weakening or replacement after a failure.

If the unit theorem fails, preserve the exact tuple and divisor tables and
recommend a separate narrow verification specification. Do not repair the
target inside the same turn. If only Mobius inversion and scaling survive,
return `OPEN` or `STOP`; support identities are not unrestricted progress.
