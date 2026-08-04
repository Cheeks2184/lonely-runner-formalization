---
owner: GPT-5.6 Sol High top-level desktop orchestrator
supervising_authority: /root
launch_runtime: original browser-capable desktop Codex session
role: Research Pipeline Lead - prompt preparation only
task_id: PIPE-P78-ALTERNATE-CONTRACT-191
base_commit: c05cd83743e6290598077006b380da5d80a1c122
admission: LAUNCH-READY
---

# Prompt 78: SPARSE-MINIMAL-COVER-OWNER-ESCAPE

This is one isolated unrestricted Sol Pro research contract. Prove or
decisively refute the exact sparse-cover exchange theorem below. The intended
route classifies inclusion-minimal complete modular covers with at most
`floor(n/2)+1` owner labels and forces an exact good residue at one selected
owner's own pivot.

This file is a prepared contract only. It is not a browser launch, active
research cell, response, proof, computation, audit, or status promotion. Only
GPT-5.6 Sol High under `/root`, using the original signed-in browser-capable
desktop session, may start a genuinely new ChatGPT conversation, explicitly
select GPT-5.6 Sol with Pro effort, submit this contract, recover the response,
and decide its status. Sol Medium prepared the specification only.

## Evidence and provenance boundary

Use these immutable inputs only at their integrated audited scopes.

| Input | Immutable provenance | Permitted status in this turn |
| --- | --- | --- |
| Response68 | recovered response `23ca5b89b13ae879c546598d7b56888a92fc39f2`; corrected audit tip `fb3db2e6e95bfb3e323d183000744643e420dbfa`; integrated audit `35f23f59157762f8978bbdbd93f05ae4001c1330` | With `H_n=2n*5^(n-1)*4^n+1`, the bounded-annihilator and rational-hyperplane necessary theorems are `proved-math`. They do not supply the exchange theorem below. |
| Response69 | recovered response `ed08c419d83b9f46daf7d30894c4b578098544f0`; mathematical audit `b98b249e545f9f24767a53f071aeed091062f622` | Strict cover/boundary, common scaling, singleton, and `n=2` claims are `proved-math`. Nearest-boundary transport is `rejected`; weighted compensation remains `open`. |
| Response70 | recovered response `7ca41ed3b537d6270ad07de52fdaf44e80b73f7d`; mathematical audit `d44a5d4508ded714296ec64b1619446355d5388a` | Singleton rigidity, strict-growth functional-graph obstruction, exact bad-set examples, and the all-but-one family are `proved-math`. Private-point-to-gcd and common-prime propagation are rejected or stopped. |
| Response72 | recovered response `79c7d8937d88ef8c26e11ea5d36f3dc0adafd585`; integrated audit `db0e33091f93311fd95143a0160e7afd60f9e3e8` | Canonical cover existence, uniqueness, inclusion-minimality, private points, singleton cardinality, and boundary facts are `proved-math`. Circuit escape is equivalent to LRC and is excluded here. Quotient transport and canonical-key descent are `rejected`. |
| Response74 | recovered response `967cabe9d0a94c2504e36e10473ef5eccef87adc`; integrated audit `94442b430f4dbb9b66ec186e5655d556ee4e477e` | Common scaling and the exact nonprimitive signed-Gram counterexample family are `proved-math`. Spectral statements are outside this target. |
| Prompt75 | recovery commit `b408724`; provenance audit `c05cd83` | Recovery provenance only is accepted. No mathematical, computational, formal, line-attribution, or status claim from Response75 is an input. |
| Prompt76 and Prompt77 | active launch records integrated before this contract | Both are active, unavailable research cells. Assume no output from either. |

Do not execute a recovered attachment. Use `proved-lean`, `proved-math`,
`computed finite evidence`, `conditional`, `conjectural`, `rejected`,
`external-unformalized`, and `open` literally. A response disposition never
promotes its claims.

## Independent-route boundary

Do not use or rename:

- Prompt67 prime forcing, orbit extraction, or cofinite-prime forcing;
- Prompt76 canonical private demand, external capacity, Hall transport, or
  its aggregate inequality;
- Prompt77 primitive signed-Gram forms or any spectral gap;
- Prompt66 whole-block packing, radial descent, or signed phase cells;
- Prompt64 top-two, Prompt62 owner shifts, Gamma matching, height compression,
  deletion descent, or first-blocker routes;
- Prompt69's weighted compensation inequality or nearest-boundary map;
- Response70's common-prime target;
- Response72 circuit escape, closed-subset exclusion, or a generic
  submodularity argument; or
- the rejected Prompt78 relation-support closure shape. In particular,
  `(1,2,8)` has `F={1,2}` and `C_1=C_2={8}`, so no nonempty subset of
  `F` is circuit-closed. Do not revive that false target.

This contract concerns one sparse inclusion-minimal cover at one pivot. It is
not a statement about every subset of covered pivots, a relation support,
private-demand capacity, Fourier energy, or prime variation.

## Frozen modular definitions and strict boundary

Let `n : Nat`, `3 <= n`, put `N=n+1`, and let

```text
a : Fin n -> Nat
```

be positive and injective. For pivot `j`, put

```text
p_j = a_j,
M_j = N*p_j,
rho_M(x) = min(x mod M, M-(x mod M)),
R_j = {r in {0,...,M_j-1} : N does not divide r},
B_i^j = {r in R_j : rho_(M_j)(r*a_i) < p_j}  for i != j,
Q_j = R_j \ union_{i!=j} B_i^j,
G_j = |Q_j|,
F(a) = {j : Fin n | G_j=0}.
```

Badness is strict `<p_j`; equality is safe. Both cyclic sides are included.
Retain excluded `N`-multiples, nonunits, gcd degeneracies, repeated modular
residues, reflection fixed points, coincident bad sets, and distinct owner
labels. Never cancel a nonunit or replace centered cyclic distance by a
one-sided interval.

For `j in F(a)`, an owner set

```text
C subset {i : Fin n | i != j}
```

is **complete at j** when

```text
union_{i in C} B_i^j = R_j.
```

It is **inclusion-minimal complete** when it is complete and, for every
`i in C`,

```text
union_{h in C, h != i} B_h^j != R_j.
```

Equivalently, prove rather than assume that every owner-labelled private set

```text
Priv(j,C,i)
  = B_i^j \ union_{h in C, h != i} B_h^j
```

is nonempty. An omitted owner may cover a private point, and coincident owner
sets retain separate labels.

For the canonical corollary, order all complete covers by

```text
(|C|, increasing list of speed values {a_i : i in C})
```

lexicographically and call the unique least cover `C_j`. Prove finiteness,
nonemptiness, uniqueness from injectivity, and inclusion-minimality before
using it.

Define the frozen sparse threshold using natural-number division:

```text
SparseBound(n) = floor(n/2)+1 = n/2+1.
```

No assertion that a sparse complete cover exists is part of the definitions.

## Sole unrestricted lemma

There is exactly one unresolved theorem in this cell:

```text
SPARSE-MINIMAL-COVER-OWNER-ESCAPE:

For every n>=3, every positive injective a : Fin n -> Nat,
every covered pivot j in F(a), and every inclusion-minimal complete
owner set C at j, if

  2 <= |C| <= SparseBound(n),

then

  there exists i in C with Q_i nonempty.
```

The conclusion must include an explicit owner index `i in C` and an explicit
residue `s in Q_i`, expanded as

```text
s in R_i
and
for every h != i, rho_(N*a_i)(s*a_h) >= a_i.
```

Do not weaken it to an uncovered pivot somewhere outside `C`, a positive
sum of all `G` values, or a conditional statement that already assumes one
selected owner is uncovered.

The theorem is unrestricted in height and quantifies over **every**
inclusion-minimal complete `C` in the displayed cardinality range, not only
the canonical cover. A counterexample involving a noncanonical
inclusion-minimal cover refutes it.

## Anti-tautology and logical-strength audit

This target does not say that a sparse cover exists. If all pivots were
covered, it would only forbid sparse inclusion-minimal covers; covers with
more than `SparseBound(n)` owners remain possible. It therefore does not
unfold to one-pivot certificate existence or Response72 circuit escape.

The owner `i` and residue `s` may not be selected by first enumerating all
`Q_i` and choosing a nonempty one. A proof must derive them from exact
arithmetic data of `a,j,C`, such as gcd fibers, centered
quotient/remainder data, CRT classes, or a predeclared finite exchange rule.

The target is also not Prompt76 Hall transport: there is no global source
mass, destination capacity, or arbitrary matching into known good sets. It
is a local classification theorem with a cross-pivot conclusion.

Before proof, establish the exact common-scaling lift: reduction from each
scaled grid modulo `c*N*a_j` to the original grid modulo `N*a_j` has `c`
fibers, preserves candidate membership and owner-labelled badness, multiplies
every `G_j` and private-set cardinality by `c`, and preserves `F`, complete
owner sets, inclusion-minimality, and the target. This justifies primitive
bounded falsification but does not prove the unrestricted theorem.

Return `STOP` if the only argument is:

- LRC, one-pivot certificate existence, or circuit escape;
- the known low-dimensional LRC theorem applied without new classification;
- enumeration of good residues followed by post-hoc owner selection;
- generic set-cover minimality or submodularity;
- the rejected centered-quotient transport or canonical-key descent from
  Response72;
- an assumed upper bound on `|C|`;
- pairwise coprimality substituted for tuple primitivity; or
- bounded computation without an unrestricted proof.

## Exact cross-pivot consequence

Prove the following implication carefully, but do not mislabel it as LRC.

Assume a positive injective tuple has no pivot certificate. The exact cover
equivalence gives

```text
F(a)=Fin n.
```

Response70's accepted singleton-rigidity/strict-growth argument gives a pivot
`j` whose canonical cover `C_j` is not a singleton, so `|C_j|>=2`.
Canonical minimality makes `C_j` inclusion-minimal.

If `|C_j|<=SparseBound(n)`, the frozen theorem gives an owner
`i in C_j` with `Q_i` nonempty, contradicting `F(a)=Fin n`. Therefore
the theorem yields only the exact obstruction

```text
DENSE-CANONICAL-CORE:

Every simultaneous full-cover tuple has some pivot j with

  |C_j| >= SparseBound(n)+1 = floor(n/2)+2,

and each selected owner has a nonempty owner-labelled private set.
```

For `n=3,4`, this exceeds the available `n-1` owners and recovers only
already known low-dimensional cases. For `n>=5`, it is a genuine structural
narrowing but not a contradiction. Do not invent a second lemma excluding the
dense core.

The existing Lean chain

```text
one pivot certificate
  -> PositiveIntegerPivotCertificateConjecture
  -> PositiveIntegerConjecture
  -> Conjecture
  -> unrestricted real LRC
```

is relevant only if a later, separately audited result excludes the dense
core. This contract does not reach that chain and must not claim unrestricted
LRC.

## Attack A: exact sparse-cover classification

Start from the exact singleton cardinality formula. For `p=a_j`,
`b=a_i`, `M=Np`, put

```text
g=gcd(b,Np),
d=gcd(b,p),
L=floor((p-1)/N).
```

Then rederive

```text
|B_i^j|
  = g*(2*floor((p-1)/g)+1)
    - d*(2*floor(L/d)+1).
```

Do not turn this marginal count into an overlap assertion. Instead classify
the exact image subgroups, fibers, strict centered arcs, and intersections
for the selected family `{B_i^j : i in C}`. Use inclusion-minimality through
the actual private sets.

Seek a deterministic rule, declared before inspecting any `Q_i`, that
chooses an owner `i in C` and constructs a residue modulo `N*a_i`.
Prove candidate membership, safety against every owner, strict/equality
endpoints, nonunit fibers, collision control, and reflection fixed points.

A successful proof must explain where the half-sparse cardinality bound enters
an exact inequality or classification. Merely observing that there are few
owners is not an argument.

## Attack B: two-level minimal-cover exchange

Assume for contradiction that every owner pivot in `C` is covered. At each
`i in C`, construct its canonical complete cover `C_i` using the frozen
order. Form a two-level owner-labelled incidence system from:

```text
Source = Sigma (i in C), Priv(j,C,i),
```

the complete covers at the owner pivots, and exact centered equations

```text
r*a_i = q*N*a_j + e,  |e|<a_j.
```

An exchange step must end in one of two certified outcomes:

1. an explicit `s in Q_i` for some `i in C`; or
2. a proper subset of the original `C` that still covers `R_j`, directly
   contradicting its inclusion-minimality.

Declare any exchange relation and any well-founded potential before using
individual good residues. Prove every target is in its declared candidate
grid and preserve pivot moduli, diagonal exclusions, owner multiplicity,
strict badness, and cyclic representatives.

The known failures are mandatory constraints: a centered quotient may be
zero, target badness need not transport to source badness, and a successful
owner replacement need not decrease the canonical cover key. A proof that
repeats any of those arrows is `STOP`.

## Mandatory exact fixtures

Recompute all definitions from scratch. Do not execute recovered artifacts.

1. `(1,2,8)`: verify `G=(0,0,6)` and singleton canonical covers
   `C_1=C_2={8}`. The sparse theorem excludes singleton covers. Preserve
   this tuple as the decisive refutation of the rejected relation-circuit
   Prompt78 shape.
2. `(1,3,4)`: verify `G=(0,2,2)`, `C_1={4}`, and strict equality
   handling.
3. `(1,3,4,5)`: verify `G=(0,0,2,2)`,
   `C_1={5}`, and `C_3={1,4,5}`. At pivot three the three owner bad sets
   partition the candidate grid; the sparse conclusion must select owner four
   or five, not owner one.
4. `(1,2,3,5)`: verify `G=(0,0,2,2)`,
   `C_1={5}`, and `C_2={1,3,5}`; retain all owner labels in the exact
   partition.
5. `(4,5,8)`: verify `G=(4,0,8)` and the inclusion-minimal binary cover
   `C_5={4,8}`. This is a nonvacuous binary case.
6. `(4,5,32)`: verify `G=(0,0,24)` and
   `C_5={4,32}`. Exactly one selected owner is covered, so any strengthening
   from “some owner uncovered” to “every owner uncovered” is false.
7. `(1,3,4,9,12)`: verify `G=(0,2,0,6,8)` and the three-owner
   inclusion-minimal cover `C_4={3,9,12}`.
8. `(1,6,11,12,13)`: verify `G=(0,0,8,8,10)`;
   `C_1={6}` and `C_6={1,11,12,13}`. This tests a cover above the sparse
   threshold and the rejected canonical-key replacement.
9. `(1,2,3,4,5,7)`: verify `G=(0,0,0,0,2,2)` and every canonical cover.
   The size-four covers at pivots two and three are within the `n=6` sparse
   threshold and must contain uncovered owners.
10. `(1,3,13)`: recompute coincident owner bad sets and retain multiplicity,
    even though no pivot is covered.
11. For every `n>=2`, test the accepted all-but-one family
    `(1,2,...,n-1,m*N*lcm(1,...,n-1))` for `m=1,2,3`. Its covered pivots
    have singleton covers and are outside the target antecedent.
12. Test `r=0`, excluded `N`-multiples, `rho=p_j-1`, equality
    `rho=p_j`, antipodes, reflection fixed points, gcd fibers, coincident
    sets, every fixture permutation, and common scaling by two and three.

For every applicable `C`, report all private owner sets and each selected
owner's exact `Q_i`, not only cardinalities.

## Mandatory deterministic falsification

Before attempting a universal proof, write and execute a fresh exact verifier.
Do not reuse or execute a recovered source file.

Enumerate:

```text
3 <= n <= 7,
primitive strictly increasing positive tuples,
maximum speed <= 24,
ordered first by n and then lexicographically.
```

For every tuple:

1. enumerate every pivot and exact `R_j,B_i^j,Q_j,G_j`;
2. enumerate **every** owner subset, not only the canonical cover;
3. retain every inclusion-minimal complete `C` with
   `2<=|C|<=SparseBound(n)`;
4. stop at the first `C` for which every `i in C` has `G_i=0`; and
5. emit the tuple, `N`, pivot, `F(a)`, all `G` values, all selected bad sets,
   `C`, every private set, and every owner-pivot `Q_i`.

Zero failures are `computed finite evidence` only. Prove permutation and
common-scaling invariance before treating the primitive sorted domain as
representative.

Any artifact must declare language and version, exact command, deterministic
ordering, domain count, malformed-input behavior, set serialization,
early-stop semantics, and source/output binding. Hash source and output with
SHA-256 and provide a machine-readable first-failure field. Floating
arithmetic is forbidden.

## Required response format

Return exactly:

1. **Disposition** — `PIVOT` or `STOP`.
2. **Status table** — one exact evidence label and dependency per claim.
3. **Frozen target** — all domains, cover predicates, sparse bound, and strict
   boundary.
4. **Anti-tautology audit** — distinction from LRC and all excluded routes.
5. **Exact fixtures** — complete records and rejected strengthenings.
6. **Deterministic falsification** — source/output hashes, domain, and first
   failure or zero-failure boundary.
7. **Attack A** — exact classification proof or first fatal arrow.
8. **Attack B** — exact exchange proof or first fatal arrow.
9. **Cross-pivot consequence** — dense canonical core and exact Lean boundary.
10. **Artifacts and final evidence boundary** — links, hashes, finite scope,
    and remaining open statements.

`PIVOT` requires a proof of
`SPARSE-MINIMAL-COVER-OWNER-ESCAPE` at every displayed quantifier, including
an explicit owner and residue, plus the dense-core consequence. Finite success,
a theorem only for canonical covers, or a theorem only at bounded height is
never `PIVOT`.

## One-turn budget and STOP rules

Use one major Sol Pro turn:

- first third: exact fixtures, scaling/permutation reduction, and deterministic
  falsification;
- second third: sparse-cover subgroup/fiber classification;
- final third: two-level exchange, theorem proof, and dense-core consequence.

Return `STOP` immediately on the first exact counterexample. Also return
`STOP` if the argument selects a known good residue post hoc; proves only a
canonical-cover variant; assumes sparse-cover existence; invokes LRC,
Response72 circuit escape, Prompt76 Hall capacity, Prompt77 spectral output,
or an active-cell result; cancels a nonunit; deduplicates owners; changes
strict badness; silently weakens “every inclusion-minimal cover”; introduces
a second unrestricted lemma; or ends with bounded/floating evidence.

A rigorous counterexample or a precise first-fatal-arrow memo is a successful
response. Do not edit the tracked repository, launch another research cell,
or claim unrestricted LRC.
