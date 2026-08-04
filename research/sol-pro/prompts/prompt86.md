---
owner: GPT-5.6 Sol High top-level desktop orchestrator
supervising_authority: /root
launch_runtime: original browser-capable desktop Codex session
role: Research Pipeline Medium Lead - unrestricted contract preparation only
task_id: PIPE-P86-LOCAL-PIVOT-SCORE-CONTRACT-238
base_commit: b083994f6cf2e54f5129f3dc211365ca2a1b8c66
admission: LAUNCH-READY
---

# Prompt 86: LOCAL-DIMENSIONAL-MULTIPLICITY-PIVOT

Develop or decisively refute one unrestricted successor to the rejected
Prompt82 global fixed-coefficient score. The new target asks for one pivot
whose **local** owner-multiplicity score is positive, with coefficient equal
to the tuple dimension parameter. It does not ask for a positive sum over
pivots.

This file is a prepared research contract only. It is not a browser launch,
active cell, response, proof, audit, or evidence promotion. Only GPT-5.6 Sol
High under `/root`, using the original signed-in browser-capable desktop
session, may open a genuinely new ChatGPT conversation, explicitly select
GPT-5.6 Sol with Pro effort, submit the hash-locked prompt, recover the
response, and decide status. Sol Medium prepared the contract. Luna may later
replay a frozen exact computation or implement a frozen local lemma; Luna may
not search for this proof.

## Research contract and route boundary

The sole target is an **unrestricted sufficient invariant**, stronger than
canonical pivot-certificate existence and therefore stronger than LRC. It has
no coefficient-height, finite-range, minimal-counterexample, primality, or
bounded-dimension premise.

This is not Prompt82 with a renamed score:

- the coefficient is the tuple-dependent value `N=n+1`, not the fixed `8`;
- the conclusion selects one locally positive pivot row;
- no global signed sum `sum_j S_j` is permitted;
- no cross-pivot cancellation of positive and negative score terms is
  permitted; and
- no good-set weight, positive part, certificate indicator, or favorable
  residue may be inserted into the score.

Do not revive Prompt82's rejected global invariant, Prompt66 radial descent
or signed phase cells, Prompt64 large-ratio top-two selection, Prompt62's
owner-aware multi-shift argument unchanged, coefficient-two Gamma matching,
height compression, whole-block packing, first blockers, or a tautological
restatement of the pivot-certificate equivalence. A genuinely new exact
cross-pivot balance may be used only to **select** a pivot at which a local
inequality is then proved; it may not establish the target by asserting a
positive global signed score.

Complete one major Sol Pro turn. By the end, return a proof for all dimensions,
an exact fail-closed counterexample to this stronger invariant, or one exact
strictly narrower lemma that survives every mandatory fixture and leaves a
complete implication chain. Further bounded scanning is not a substitute.

## Canonical modular definitions and strict boundary

Let `n : Nat` with `3 <= n`, put `N=n+1`, and let

```text
a : Fin n -> Nat
```

be positive and injective. For every pivot `j : Fin n`, define

```text
p_j = a_j,
M_j = N*p_j,
rho_M(x) = min(x mod M, M-(x mod M)),
R_j = {r in {0,...,M_j-1} : N does not divide r},
B_i^j = {r in R_j : rho_(M_j)(r*a_i) < p_j}  for i != j,
mu_j(r) = #{i : Fin n | i != j and r in B_i^j}.
```

All multiplicities are owner-indexed. Distinct owners inducing coincident bad
sets or equal modular residues still count separately. Speeds are positive
and injective, but they need not be units or pairwise coprime. Retain gcd
degeneracies, zero target residues, both cyclic sides, reflection fixed
points, antipodes, and excluded `N`-multiples.

Badness is strictly `rho < p_j`; equality `rho=p_j` is safe. Never replace the
centered cyclic distance by a one-sided interval or weak inequality. Every
residue is represented uniquely in `0,...,M_j-1`.

Prove, rather than assume, the exact count

```text
|R_j| = (N-1)*p_j = n*p_j.
```

Also prove canonical pivot-coordinate safety: for `r in R_j`,

```text
rho_(N*p_j)(r*p_j) >= p_j,
```

including the equality cases.

## Frozen dimension-dependent local score

For `m : Nat`, interpret the following exactly in `Rat`, with the numerator
first formed in `Int`:

```text
phi_N(m) = (1-m)/(N*m+1).
```

Thus

```text
phi_N(0)=1,
phi_N(1)=0,
phi_N(m)<0 for m>=2,
and -1/N < phi_N(m) < 0 for m>=2.
```

For a pivot `j`, define only the local score

```text
S_j(a) = sum_(r in R_j) phi_N(mu_j(r)).
```

There is no target involving `sum_j S_j(a)`. The dimension coefficient `N`,
the denominator `N*m+1`, owner multiplicity, equal weighting inside a pivot,
and strict sign `>0` are frozen before proof and search. Do not tune the
coefficient after seeing a tuple, weight by speeds or gcds, discard negative
rows, or restrict to a favorable subset of candidates.

## Sole unresolved unrestricted lemma

Prove or refute exactly:

```text
LOCAL-DIMENSIONAL-MULTIPLICITY-PIVOT:

For every n>=3 and every positive injective a : Fin n -> Nat,
there exists j : Fin n such that S_j(a) > 0.
```

Equivalently, it is enough to prove the primitive case after proving the exact
common-scaling theorem below. `Primitive` means only that the gcd of all
speeds is one; it does not mean pairwise coprime.

This is the single open mathematical edge in the contract. Local algebra,
scaling, certificate extraction, and the downstream Lean implication chain
must be discharged in the response and may not be relabeled as additional
conjectures.

## Mandatory local algebra and sign implication

Derive exactly, for every `m`,

```text
phi_N(m) = (N+1)/(N*(N*m+1)) - 1/N.
```

For the multiplicity histogram

```text
h_(j,m) = #{r in R_j : mu_j(r)=m},
```

derive both exact local forms

```text
S_j
  = h_(j,0) - sum_(m>=2) h_(j,m)*(m-1)/(N*m+1),

S_j > 0
  iff sum_(r in R_j) 1/(N*mu_j(r)+1) > |R_j|/(N+1).
```

Equivalently, if `H_j` is the harmonic mean of the positive integers
`N*mu_j(r)+1`, prove

```text
S_j>0 iff H_j<N+1.
```

Define the per-pivot generating polynomial

```text
F_j(z) = sum_(r in R_j) z^(mu_j(r)).
```

Using `1/(N*m+1)=integral_0^1 x^(N*m) dx`, derive

```text
S_j
  = ((N+1)/N) * integral_0^1 F_j(x^N) dx - |R_j|/N.
```

These are local algebraic identities only. They neither prove the sole target
nor authorize summing signed scores over pivots.

Now prove the exact local sign implication

```text
S_j(a)>0
  -> exists r in R_j, mu_j(r)=0
  -> r is an explicit canonical pivot certificate at j.
```

The first arrow follows because if every `mu_j(r)>=1`, every summand is
nonpositive. Expand the second arrow owner by owner and combine it with pivot-
coordinate safety. Preserve the safe equality boundary.

## Logical-strength audit and fail-closed boundary

The converse is not available: one uncovered candidate contributes `1`, but
many multiply covered candidates may contribute enough negative mass to make
the same local score nonpositive. Do not infer `S_j>0` from a certificate,
choose a known good pivot, replace `phi_N` by its positive part, or smuggle
`1_[mu=0]` into the proof.

The decisive fail fixture is therefore:

```text
a positive injective tuple a such that
  some pivot has an exact canonical certificate,
but
  S_j(a) <= 0 for every pivot j.
```

The first such exact tuple refutes only
`LOCAL-DIMENSIONAL-MULTIPLICITY-PIVOT`; it is not an LRC counterexample. Stop
the proof route and report all local histograms and reduced rational scores.
If all local scores are nonpositive and the literal checker finds no pivot
certificate, quarantine the tuple as a potential unrestricted LRC
counterexample and request immediate independent exact replay; make no claim.

Prompt82's exact tuple

```text
(1,4,5,6,7,11,32)
```

is a mandatory calibration. Prompt82 established that its fixed-coefficient
global `N=8` score is negative while pivot speed `7`, residue `17`, is a
certificate. That does **not** decide the present local target: reproduce all
seven local histograms and scores and determine whether at least one row is
positive. Never reuse its negative global sum as a local counterexample.

## Exact common-scaling and permutation laws

Before restricting a search to primitive increasing tuples, prove both laws.

For `c>=1` and `A_i=c*a_i`, reduction

```text
R_j(A) -> R_j(a),
r |-> r mod (N*a_j)
```

has exactly `c` fibers and preserves candidate membership and every owner-
labelled strict badness predicate. Prove the representative range,
surjectivity, fiber cardinality, exclusion of `N`-multiples, both centered
cyclic sides, and equality safety. Conclude

```text
mu_j^A(r) = mu_j^a(r mod (N*a_j)),
S_j(A)=c*S_j(a),
```

so positivity and nonpositivity are preserved in both directions. Then prove
normalization by the common gcd and lifting back to the original tuple.

Separately prove that a permutation of owner labels only permutes pivot rows,
candidate multiplicity histograms, scores, and certificates. Only after this
may a verifier enumerate increasing tuples.

## Attack A: cross-pivot multiplicity or harmonic-mean balance

Assume for contradiction that every pivot has `S_j<=0`, equivalently

```text
sum_(r in R_j) 1/(N*mu_j(r)+1) <= |R_j|/(N+1)
```

for every `j`. Seek an exact cross-pivot incidence relation that makes this
system impossible. The new step must retain owner labels, collisions,
nonunits, and pivot-dependent moduli.

Possible directions include selecting a pivot by:

- an extremal owner-incidence or reciprocal-load statistic;
- a harmonic-mean balance between a pivot and the rows owned by its speeds;
- an exact transfer map between high-multiplicity candidates in one row and
  low-multiplicity candidates in another; or
- a tuple-wide conservation law for **unsigned incidence data** which forces
  one row across its local reciprocal threshold.

Write every transfer with domain, codomain, fibers, collisions, and strict
boundary behavior. A generic average-degree, Jensen, or probability slogan is
not enough. In particular, do not prove or assume
`sum_j S_j>0`; that is precisely the rejected global-score architecture. An
unsigned or nonnegative extremal statistic may identify a pivot only if the
subsequent inequality proves that pivot's local score positive without signed
cross-row cancellation.

Stop Attack A at the first missing uniform fiber bound, reversed convexity
inequality, unproved coprimality, or step that chooses an already certified
pivot.

## Attack B: local minimal covers, private incidence, or additive energy

Independently analyze one pivot row as a labelled set system

```text
{B_i^j : i != j}
```

while using tuple-wide arithmetic only to select the pivot. If the row is a
cover, minimize a labelled subcover canonically and record private incidences;
if it is not a cover, retain every zero-multiplicity candidate and the full
overlap histogram. Do not discard owners not chosen by the minimal subcover.

The exact local threshold is

```text
h_(j,0)
  > sum_(m>=2) h_(j,m)*(m-1)/(N*m+1).
```

Seek a modular uncrossing, private-incidence injection, or additive-energy
bound forcing this inequality for at least one pivot. Any exchange must keep
the original owner labels and count coincident sets with multiplicity. Any
energy calculation must state its normalization and collision terms and must
not replace the required signed local inequality by a union bound.

If a canonical minimal full cover is used under the contradiction assumption,
derive an arithmetic impossibility shared across pivots rather than merely
restating that an uncovered row would give a certificate. If a row already
has zeros, prove quantitatively that its zero mass dominates its overcoverage;
the existence of a zero alone is insufficient.

Stop Attack B on a hidden selection of a good residue, loss of unused owners,
an invalid injection at modular collisions, a weak inequality at the strict
threshold, or an additive-energy statement equivalent to the target after
unfolding.

## Mandatory literal falsification

Build a literal exact checker before trusting either attack. For every tuple,
enumerate every pivot, every representative `0<=r<N*a_j`, and every
nonpivot owner. Record the complete histogram `h_(j,m)`, exact reduced
rational `S_j`, the least zero-multiplicity candidate or `none`, and all
strict-boundary diagnostics. Do not infer a score from a union size.

Use deterministic order:

1. dimension increasing;
2. maximum speed increasing;
3. primitive increasing speed tuple lexicographic;
4. pivot index increasing; and
5. residue representative increasing.

Reject repeated numerical speeds as premise violations, but retain distinct
owners whose bad sets or modular residues coincide. Mandatory fixtures must
include:

- one known success tuple and one synthetic negative score row;
- `rho=p_j-1` bad and `rho=p_j` safe;
- an excluded `N`-multiple;
- both cyclic sides and an antipode;
- a nonunit owner and a gcd-degenerate fiber;
- coincident labelled bad sets and repeated modular residues;
- an owner permutation;
- a common scaling pair;
- malformed zero or repeated-speed input; and
- one deliberately altered expected histogram or score that must fail.

Recompute the known research fixtures

```text
P76: (1,4,5,6,7,11),
P77: (6,7,168),
P78: (6,7,12,24,144),
P80: (1,3,16),
P82: (1,4,5,6,7,11,32).
```

The following root-side literal-search observations are **contract-design
observations only**, not evidence and not premises:

```text
no fail fixture among primitive increasing tuples in
  n=3,4 with maximum speed <=30,
  n=5 with maximum speed <=20,
  n=6 with maximum speed <=15,
  n=7 with maximum speed <=12;

each listed P76/P77/P78/P80/P82 fixture was reported to have a positive local
row at a certificate pivot.
```

Independently reproduce or reject these observations. If they are not
independently reproduced, ignore them. You may add at most one new bounded
domain, chosen before execution to test one named transfer, minimal-cover, or
energy assertion. No finite range supports unrestricted extrapolation.

Every proposed verifier must fix its finite types, malformed-input behavior,
deterministic serialization, full-domain completion marker, source/output
hashes, and independent literal-versus-optimized comparison. A stopped,
partial, stale, or semantically repaired run is rejected operational output,
not computed finite evidence.

## Complete implication chain

A successful proof must give every arrow in

```text
positive injective integer tuple a
  -> LOCAL-DIMENSIONAL-MULTIPLICITY-PIVOT supplies j with S_j(a)>0
  -> some r in R_j has mu_j(r)=0
  -> owner-by-owner strict bad-set complement at r
  -> pivot coordinate safe, including equality
  -> explicit canonical pivot certificate
  -> proved-lean pivotResidueWitness
  -> PositiveIntegerPivotCertificateConjecture
  -> PositiveIntegerConjecture
  -> Conjecture
  -> unrestricted real Lonely Runner Conjecture.
```

Handle `n=1` and `n=2` separately using already verified elementary cases or
give direct canonical witnesses; the sole target begins at `n=3`. Identify
the exact existing Lean declarations and directions used. State all positivity
hypotheses, finite-index transports, rational casts, strict inequalities, and
closed loneliness boundary conventions. Do not describe the integer-to-real
reduction merely as density.

## Required response format

Return exactly these sections.

1. **Disposition** -- `PROVE`, `PIVOT`, or `STOP`.
2. **Frozen definitions and boundary audit** -- `R_j`, strict badness,
   owner multiplicity, cardinality, and pivot-coordinate safety.
3. **Local algebra** -- transform identity, histogram form, reciprocal and
   harmonic-mean forms, and per-pivot generating-function integral.
4. **Scaling, permutation, and logical-strength audit** -- exact laws, local
   sign implication, converse boundary, and distinction from Prompt82.
5. **Attack A: cross-pivot balance** -- exact transfers or extremal selection,
   collisions, strictness, and first unsupported arrow or full proof.
6. **Attack B: local cover or energy** -- canonical objects, exact inequality,
   owner retention, and first unsupported arrow or full proof.
7. **Falsification report** -- every pivot and residue, all fixtures, design-
   observation reproduction or rejection, and at most one new domain.
8. **Sole target proof, narrower pivot, or fail certificate** -- a complete
   universal proof; one strictly narrower non-tautological lemma with complete
   downstream chain; or the first certificate-bearing tuple with all local
   scores nonpositive.
9. **Complete implication chain** -- exact witnesses and evidence labels
   through unrestricted real LRC.
10. **Proof-obligation ledger** -- statement, dependency, status,
    falsification test, first open arrow, stop condition, and recommended
    owner.
11. **Verifier and Lean plan** -- frozen data types and theorem signatures,
    literal checker, independent optimized checker, fixtures, target commands,
    axiom probes, and no implementation.
12. **Final evidence boundary** -- separately list `proved-lean`, generic
    `proved-math`, response-authored calculation, independently reproduced
    computed finite evidence, conditional, rejected, and open.

`PROVE` requires the sole target for every `n>=3`. `PIVOT` requires one exact
lemma strictly narrower than the target, not equivalent to LRC or to the pivot
certificate theorem, surviving all mandatory fixtures with a complete stated
path onward; it promotes nothing by itself. `STOP` is required on an exact
fail fixture, an LRC-equivalent reformulation, global signed-score revival,
hidden good-pivot selection, unsupported finite extrapolation, or any unclosed
strict estimate presented as a proof.

## Maximum budget and hard stop rules

Use one major Sol Pro turn. Allocate roughly one fifth each to local algebra
and normalization, Attack A, Attack B, exact falsification, and synthesis plus
the obligation/Lean plan. Add at most one bounded search domain. Do not spend
the turn optimizing a coefficient or extending a scan after the first exact
fail fixture.

Stop immediately on weak badness, unsafe equality, lost owner labels,
deduplicated coincident sets, nonunit cancellation, an unproved scaling or
sorting reduction, signed cross-pivot score cancellation, a certificate
chosen before the local score proof, a positive-part substitution, a finite
pattern promoted to a theorem, or a proof whose only unresolved statement is
the original pivot-certificate conjecture in different notation.

Prompt82's invariant remains `rejected`; its exact counterexample remains an
exact counterexample only to that stronger global invariant. Unrestricted LRC
remains `open` unless the exact target and every displayed implication compile
and survive independent audit. A rigorous counterexample to the present
stronger invariant is a successful research result and does not disprove LRC.
