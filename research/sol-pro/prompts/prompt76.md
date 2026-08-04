---
owner: GPT-5.6 Sol High top-level desktop orchestrator
supervising_authority: /root
launch_runtime: original browser-capable desktop Codex session
role: Research Pipeline Lead - prompt preparation only
task_id: PIPE-P76-GLOBAL-PRIVATE-DEFICIT-CONTRACT-180
base_commit: 94442b430f4dbb9b66ec186e5655d556ee4e477e
admission: LAUNCH-READY
---

# Prompt 76: GLOBAL-CANONICAL-PRIVATE-DEFICIT-HALL

This is one isolated unrestricted Sol Pro research contract. Prove or
decisively refute the exact global canonical-private-deficit inequality below.
The intended route combines minimal full modular covers with a genuinely
global Hall/uncrossing argument. It is not a pointwise nearest-boundary
exchange and not the per-covered-row weighted compensation conjecture from
Prompt69.

This file is a prepared contract only. It is not a browser launch, active
research cell, response, proof, computation, audit, or status promotion. Only
GPT-5.6 Sol High under `/root`, using the original signed-in browser-capable
desktop session, may start a genuinely new ChatGPT conversation, explicitly
select GPT-5.6 Sol with Pro effort, submit this contract, recover the response,
and decide its status. Sol Medium prepared the specification only. Luna may
later replay a frozen artifact but may not perform this proof search.

## Evidence and provenance boundary

Use the following immutable inputs only at their audited scopes.

| Input | Immutable provenance | Permitted status in this turn |
| --- | --- | --- |
| Response68 | recovered response `23ca5b89b13ae879c546598d7b56888a92fc39f2`; corrected audit tip `fb3db2e6e95bfb3e323d183000744643e420dbfa`; integrated audit `35f23f59157762f8978bbdbd93f05ae4001c1330` | With corrected `H_n=2n*5^(n-1)*4^n+1`, the bounded annihilator and rational-hyperplane necessary theorem are `proved-math`. Cofinite prime forcing remains `open`; recovered computations are outside this contract. |
| Response69 | recovered response `ed08c419d83b9f46daf7d30894c4b578098544f0`; mathematical audit `b98b249e545f9f24767a53f071aeed091062f622` | Cover/boundary/scaling/one-owner and `n=2` claims are audited `proved-math`. Nearest-boundary transport is `rejected`; the per-row weighted compensation lemma remains `open`; its finite output is not assumed. |
| Response70 | recovered response `7ca41ed3b537d6270ad07de52fdaf44e80b73f7d`; mathematical audit `d44a5d4508ded714296ec64b1619446355d5388a` | Coarse divisibility, singleton rigidity, strict-growth, and all-but-one family are audited `proved-math`. Private-point-to-gcd and nonunit-owner propagation are `rejected`. The common-prime target is equivalent to LRC and stopped as a bridge. |
| Response72 | recovered response `79c7d8937d88ef8c26e11ea5d36f3dc0adafd585`; integrated audit `db0e33091f93311fd95143a0160e7afd60f9e3e8` | Canonical covers, the boundary-grid lemma, and the minimal-dimension no-nonempty-proper-closed-subset theorem are `proved-math`. Circuit escape is equivalent to LRC and stopped as a narrower bridge. Artifacts were not executed and remain unaccepted. |
| Response74 | recovered response `967cabe9d0a94c2504e36e10473ef5eccef87adc`; integrated audit `94442b430f4dbb9b66ec186e5655d556ee4e477e` | The common-scaling identity and exact family `(c,2c,8c)`, `c>=6`, are `proved-math`; the arbitrary signed-Gram bridge is `rejected`; a primitive or scale-invariant replacement remains `open`. These spectral results are not inputs here. |

Do not use any Prompt75 output. Do not execute any recovered attachment. Use
`proved-lean`, `proved-math`, `computed finite evidence`, `conditional`,
`conjectural`, `rejected`, `external-unformalized`, and `open` literally.
Prior response self-dispositions do not promote their claims.

## Routes excluded from this cell

Do not use or rename:

- cofinite or uniform prime forcing;
- simultaneous-full-cover common-prime, which is audited equivalent to LRC;
- Prompt66 whole-block packing, radial descent, or signed phase cells;
- Prompt64 large-ratio top-two, Prompt62 owner shifts, or Gamma matching;
- height compression, deletion descent, or coefficient bounds;
- the Response72 circuit-escape schema or the assertion that a closed subset
  cannot exist;
- Prompt69's exact per-row inequality
  `2*a_j <= sum_{k!=j} w(j,k)*G_k`;
- a post-hoc injection obtained by first assuming the desired cardinality; or
- the tautology that some `G_j>0` or `sum_j G_j>0`.

This contract's sole missing lemma is an aggregate private-demand inequality,
not any item above.

## Frozen modular definitions and strict boundary

Let `n : Nat`, `2 <= n`, put `N=n+1`, and let

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
mu_j(r) = #{i : i != j and r in B_i^j},
Q_j = {r in R_j : mu_j(r)=0},
G_j = |Q_j|.
```

Badness is strict `<p_j`; equality is safe. Both cyclic sides are included.
Keep nonunits, gcd degeneracies, repeated modular residues, coincident bad
sets, and separate owner identities. Never cancel a nonunit or replace cyclic
distance by a one-sided interval.

Define the finite covered-pivot set

```text
F(a) = {j : Fin n | G_j=0}.
```

For `j in F(a)`, an owner subset `C` is complete if

```text
C subset {i : Fin n | i != j}
and union_{i in C} B_i^j = R_j.
```

Order complete covers by

```text
(|C|, increasing list of speed values {a_i : i in C})
```

lexicographically, and let `C_j` be the least one. Before using it, prove:

1. the complete-cover family is finite and nonempty;
2. injectivity makes the key a strict total order and `C_j` unique;
3. minimum cardinality makes `C_j` inclusion-minimal; and
4. for every `i in C_j`, the owner-labelled private set

```text
Priv(j,i) = B_i^j \ union_{h in C_j, h != i} B_h^j
```

is nonempty. Privacy is relative to `C_j`; an omitted owner can still cover a
private point.

Put

```text
PrivateDemand(a)
  = sum_{j in F(a)} sum_{i in C_j} |Priv(j,i)|,

w(j,k) = a_k / gcd(a_j,a_k),

ExternalCapacity(a)
  = sum_{j in F(a)} sum_{k notin F(a)} w(j,k)*G_k.
```

All sums are natural-number sums over owner indices. The equivalent regrouped
capacity is

```text
sum_{k notin F(a)} G_k * sum_{j in F(a)} w(j,k).
```

State and prove this finite Fubini/reindexing identity; do not suppress owner
or pivot multiplicity.

## Sole unrestricted lemma

There is exactly one permitted unresolved bridge:

```text
GLOBAL-CANONICAL-PRIVATE-DEFICIT-HALL:

For every n>=2 and every positive injective a : Fin n -> Nat,
if F(a) is nonempty, then

  PrivateDemand(a) <= ExternalCapacity(a).
```

This is an unrestricted-height quantitative theorem. It is not the pivot
equivalence: it imposes a fixed inequality on every tuple with at least one
covered pivot, including tuples already having certificates elsewhere. It is
not Response69's per-row conjecture: only the aggregate private demand must be
transported, and the source size is the exact canonical private mass rather
than `2*a_j`.

The lemma is intended as a stronger sufficient structure than LRC, not a
logical reformulation. Perform an explicit anti-tautology audit. If unfolding
definitions or invoking the provisional closed-subset theorem makes the lemma
equivalent to “some pivot is uncovered,” return `STOP`. If a tuple with
`F(a)` proper violates the inequality, that is a genuine counterexample and
also requires `STOP`.

## Complete implication chain

Handle `n=1` directly: `N=2`, there are no nonpivot owners, and `r=1` is an
uncovered pivot candidate safe at equality.

For `n>=2`, suppose a positive injective tuple has no pivot certificate. Then
the exact cover equivalence gives

```text
F(a)=Fin n.
```

Every `R_j` is nonempty, so a complete cover `C_j` cannot be empty. By
inclusion-minimality, every selected owner has a nonempty private set. Hence

```text
PrivateDemand(a) >= n > 0.
```

But there is no `k notin F(a)`, so

```text
ExternalCapacity(a)=0.
```

The frozen inequality gives a contradiction. Therefore some `Q_j` is
nonempty. Expand `r in Q_j` into avoidance of every strict nonpivot bad set,
and prove pivot safety from `N` not dividing `r`. Finish through the existing
`proved-lean` directions

```text
one pivot certificate
  -> PositiveIntegerPivotCertificateConjecture
  -> PositiveIntegerConjecture
  -> Conjecture
  -> unrestricted real LRC.
```

Do not claim this implication proves the lemma.

## Attack A: global Hall transport from private tokens

Use the exact finite source type

```text
Source = Sigma (j in F(a)), Sigma (i in C_j), Priv(j,i).
```

Use the exact destination slot type

```text
Dest = Sigma (j in F(a)), Sigma (k notin F(a)),
         Fin(w(j,k)) x Q_k.
```

Their cardinalities are `PrivateDemand` and `ExternalCapacity`. Seek either an
explicit injection `Source -> Dest` or a Hall relation with a proved neighbor
inequality for every source subset.

The destination map/relation must be declared from centered
quotient/remainder, CRT, or exact congruence data before inspecting which
individual residues happen to be in `Q_k`. It may depend on the full tuple,
`F(a)`, canonical circuits, gcds, and owner labels. It may not enumerate the
good sets and then use the target inequality to choose arbitrary slots.

Aggregate transport is allowed to repair pointwise failures: several source
tokens may be rerouted jointly, and the first pivot label `j` is retained in
the destination slots. Prove destination candidate membership, destination
safety against every owner, slot range, collision control, reflection fixed
points, and strict endpoints. A map landing only in a bad incidence or in a
candidate not known to be good is not progress.

## Attack B: modular uncrossing of canonical covers

Independently seek a finite uncrossing identity. For source private point
`r in Priv(j,i)`, write the unique centered equation

```text
r*a_i = q*N*a_j + e,  |e|<a_j.
```

Use complete covers at other pivots only through exact owner-labelled set
operations. An uncrossing step must prove one of:

1. an exact family of external good residues with total weighted capacity at
   least the private tokens discharged; or
2. a strict decrease in a predeclared global potential together with a
   telescoping identity whose terminal boundary is `ExternalCapacity`.

Every replacement must remain at its declared pivot modulus, preserve
strict/closed boundaries, retain diagonal exclusions, and cover all formerly
private points. Generic set-cover submodularity is insufficient; the
two-label closed abstract countermodel from audited Response72 must be
excluded by a genuinely arithmetic hypothesis; its recovered artifact remains
unexecuted.

## Mandatory counterexamples and falsification suite

Recompute all definitions without executing recovered attachments.

1. `(1,3,4)`: the nearest-boundary exchange fails although the aggregate
   inequality is not thereby refuted. Verify `F`, `C_j`, every private set,
   both sides, and the failed transported residues.
2. `(1,3,4,5)`: verify the two covered pivots and the owner-labelled private
   partition at pivot three. The quotient can be zero, and target badness need
   not transport back.
3. `(1,2,3,5)`, pivot two: the three owner bad sets exactly partition the grid
   although every owner is coprime to the pivot. Reject private-point-to-gcd.
4. `(1,6,11,12,13)`: reconstruct the canonical circuits and the failed key
   decrease; a least-owner selector cycle is not an uncrossing proof.
5. `(1,2,8)`: two covered pivots feed the sole uncovered pivot; any demand for
   two uncovered pivots is false.
6. `(1,2,3,4,5,7)`: four covered pivots and only two good rows; reject
   `sum_j G_j>=n` and majority-pivot arguments.
7. `(1,3,13)`: coincident bad sets remain distinct owners and sources.
8. The audited all-but-one family
   `(1,2,...,n-1,m*N*lcm(1,...,n-1))`: `n-1` full pivots do not force a common
   prime. Prove the frozen inequality on this symbolic family or refute it.
9. Boundary cases `rho=p-1`, `rho=p`, excluded `N`-multiples, reflection fixed
   antipodes, `n=2`, nonunits, and common scaling by at least two factors.

Before attempting a universal proof, perform a deterministic exact search over
primitive strictly increasing tuples for `2<=n<=6`, maximum speed at most 14,
then add common scalings of every tested primitive tuple by 2 and 3. Enumerate
subsets and residues canonically. Stop at the first inequality failure and
emit the complete tuple, `F(a)`, every `C_j`, all private sets, `G`, weights,
and both sides. A found failure is a route-stopping mathematical counterexample;
zero failures are only `computed finite evidence`.

Any code must be supplied as a separately hashed attachment with deterministic
ordering, exact domain, interpreter/compiler version, malformed-input behavior,
and a machine-readable first-failure record. Do not ask Luna to infer the
semantics.

## Required response format

Return exactly these sections.

1. **Disposition** — `BRIDGE`, `PIVOT`, or `STOP`.
2. **Status table** — one exact evidence label per claim and dependency.
3. **Frozen definitions** — every finite type, representative, order, and
   boundary.
4. **Anti-tautology audit** — compare the lemma with pivot equivalence,
   Response69 compensation, and audited Response72 circuit escape.
5. **Exact falsification** — mandatory fixtures, symbolic family, bounded
   domain, ordering, and first failure.
6. **Attack A** — complete Hall relation/injection or first unsupported arrow.
7. **Attack B** — complete modular uncrossing/telescoping proof or first
   unsupported arrow.
8. **Complete implication chain** — include `n=1`, pivot safety, and exact Lean
   theorem directions.
9. **Proof-obligation ledger** — statement, status, dependency, falsification,
   first open edge, and recommended next owner.
10. **Artifacts and final evidence boundary** — hashes and finite scope only.

`BRIDGE` is permitted only for a complete proof of the frozen inequality at
every quantifier plus the implication chain. `PIVOT` requires a proved
unrestricted arithmetic theorem that strictly narrows the inequality without
introducing an equally strong new existential. Finite success is never
`PIVOT`.

## One-turn budget and STOP rules

Use one major Sol Pro turn. Spend the first third on exact falsification, the
second on Hall transport, and the final third on uncrossing and disposition.

Return `STOP` immediately if:

- an exact tuple or symbolic family violates the inequality;
- the proof selects good residues only after assuming the desired capacity;
- nearest-boundary, private-to-gcd, common-prime, or local-submodularity claims
  reappear under new names;
- the sole open edge becomes circuit escape, per-row compensation, or LRC;
- a nonunit is cancelled, a strict inequality is weakened, or owners are
  deduplicated; or
- only bounded computation remains.

A rigorous counterexample or exact first-fatal-arrow memo is a successful
response. Do not edit the tracked repository or claim unrestricted LRC.
