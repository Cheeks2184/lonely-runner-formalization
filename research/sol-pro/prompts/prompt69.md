---
owner: GPT-5.6 Sol High top-level desktop orchestrator
supervising_authority: /root
launch_runtime: original browser-capable desktop Codex session
role: Research Pipeline/Specification Lead - prompt preparation only
task_id: PIPE-P69-RESPEC-128
---

# Prompt 69: CROSS-PIVOT-WEIGHTED-DEFICIT-COMPENSATION

This is one isolated unrestricted Sol Pro research contract. Prove or
decisively refute the exact quantitative cross-pivot compensation lemma below.
The intended structure is modular uncrossing or exchange: a pivot row with no
uncovered candidate must force enough explicitly weighted uncovered mass at
other pivot moduli.

This file is only a prepared contract. It is not a launch record, response,
proof, computation, audit, or mathematical promotion. Only GPT-5.6 Sol High
under `/root` may launch the Pro turn. Do not delegate research to Luna.

This route must remain distinct from:

- Prompt68 cofinite prime forcing;
- corrected Prompt70 simultaneous-full-cover common-prime propagation;
- Prompt66 packing, radial descent, and signed phase cells;
- Fourier aggregation;
- top-two, owner-shift, Gamma matching, height compression, deletion,
  first-blocker descent, and coefficient-bounded searches.

Do not turn the task into descent or into a simultaneous-cover contradiction.
The former target `not (forall j, Covers(j))` is **rejected as tautological**:
after expanding `Covers`, it is exactly the existing pivot-certificate
existence statement.

Use `proved-lean`, `proved-math`, `computed finite evidence`, `conditional`,
`conjectural`, `rejected`, and `open` literally. The response may recommend a
disposition but may not promote its own claims before independent audit.

## Existing exact boundary

The repository has the `proved-lean` equivalences

```text
exists_witness_iff_exists_pivot_certificate
positiveIntegerConjecture_iff_pivotCertificateConjecture
conjecture_iff_positiveIntegerConjecture.
```

They identify one uncovered canonical pivot residue with a fixed-instance real
witness and reduce unrestricted real LRC to the positive-integer proposition.
They do not prove that an uncovered residue exists. A formula which merely
renames `exists j, G_j>0`, including a minimum or an indicator sum over the
unknown good set, earns `STOP`.

The quantitative target `sum_j G_j >= n` is also **rejected**: for `n=6`,
`N=7`, the primitive tuple `(1,2,3,4,5,7)` has
`G=(0,0,0,0,2,2)` and total uncovered mass `4<6`.

## Frozen definitions and conventions

Let `n : Nat`, `2 <= n`, `N=n+1`, and let

```text
a : Fin n -> Nat
```

be positive and injective. For every pivot `j : Fin n`, set

```text
p_j = a_j,
M_j = N*p_j,
rho_M(x) = min(x mod M, M-(x mod M)),
R_j = {r : Fin M_j | N does not divide r.val},
B_i^j = {r : R_j | rho_(M_j)(r.val*a_i) < p_j}  for i != j,
mu_j(r) = #{i : Fin n | i != j and r in B_i^j},
Q_j = {r : R_j | mu_j(r)=0},
G_j(a) = |Q_j|.
```

The boundary is frozen: `<p_j` is bad and equality `rho=p_j` is safe. Never
replace cyclic distance by a one-sided interval. Every residue uses its unique
representative `0 <= r.val < M_j`; `N`-multiples are excluded; and the pivot
coordinate is safe for exactly that candidate reason. Original speeds are
injective integers, but their residues modulo `M_j` need not be distinct.
Retain nonunits, gcd degeneracies, repeated residues, and coincident bad sets
with their separate owners.

Write

```text
Covers(j) :<=> Q_j is empty
           :<=> union_(i!=j) B_i^j = R_j.
```

Prove this equivalence before using finite-set subtraction. Reflection is
`r |-> -r` modulo `M_j`; handle fixed points, particularly all-odd half-time
points, without doubling. Different pivots live in different cyclic groups.
There is no implicit residue or character identification between them.

For distinct pivots `j,k`, define the frozen arithmetic exchange weight

```text
w(j,k) = a_k / gcd(a_j,a_k).
```

This is a natural quotient by a positive divisor. Prove positivity and every
divisibility fact before cancellation. The weight is fixed from the original
integer tuple, not selected after inspecting which pivot succeeds.

## Sole unrestricted structural lemma

There is exactly one permitted unresolved lemma:

```text
CROSS-PIVOT-WEIGHTED-DEFICIT-COMPENSATION:

For every n : Nat with 2 <= n, every positive injective
a : Fin n -> Nat, and every pivot j : Fin n,

  Covers(j) ->
    2*a_j <= sum_(k : Fin n, k != j) w(j,k)*G_k(a).
```

This is a quantitative cross-pivot statement. It is strictly stronger than
the existing certificate equivalence: for every completely covered row it
requires at least `2*a_j` units of gcd-weighted uncovered mass at other,
different pivot moduli. It is not permitted to weaken the right side to
`some G_k>0`, `sum G_k>0`, `U>0`, a reflection pair, or any condition
definitionally equivalent to a pivot certificate.

The factor `2*a_j` and the exact quotient weight are frozen. If either is
refuted, return `STOP` or a rigorously proved replacement under the disposition
rules; do not silently alter constants, weights, or quantifiers.

## Complete implication chain

Split `n=1` first. For its unique positive speed, there are no nonpivot bad
owners, `R_j` is nonempty, and any candidate gives the certificate. Do not
invoke a nonexistent second pivot.

For `n>=2`, choose any pivot `j`. If `Q_j` is nonempty, it directly supplies a
canonical certificate. If `Covers(j)`, apply the compensation lemma. Since
`2*a_j>0`, its finite nonnegative sum is positive; therefore some
`k != j` has `w(j,k)*G_k(a)>0`, hence `G_k(a)>0`. Extract an exact
`r in Q_k`, expand `mu_k(r)=0` into avoidance of every owner bad set, and prove
the pivot coordinate safe at the closed boundary.

Then give every repository arrow:

```text
one canonical pivot certificate
  -> PositiveIntegerPivotCertificateConjecture
  -> PositiveIntegerConjecture
  -> Conjecture
  -> unrestricted real LRC.
```

Use both `proved-lean` equivalences in the correct direction with exact
positivity, injectivity, indexing, and `Fin`/natural representative hypotheses.
The finite-sum positivity and product-positivity steps are part of the proof,
not implicit classical choice.

## Attack A: explicit modular exchange injection

Fix a covered pivot `j`. Select the canonical inclusion-minimal owner cover
`I_j` using a declared total order. For every `i in I_j`, prove existence of a
private candidate

```text
r_(j,i) in B_i^j \ union_(h in I_j, h != i) B_h^j.
```

Track its unique representative, centered signed residue, quotient/remainder
equation, `gcd(M_j,a_i)`, attained fibers, and strict inequalities.

Define the finite token and destination types

```text
T_j = Fin (2*a_j),
D_j = Sigma (k : {k : Fin n // k != j}),
        (Fin (w(j,k)) x Q_k).
```

Construct an explicit arithmetic map `Phi_j : T_j -> D_j` and prove it
injective. Its pivot, slot, and residue components must be determined from the
minimal-cover/private-point congruence data by a formula declared before
examining favorable rows. Merely invoking the finite-cardinality theorem
`|T_j|<=|D_j| iff an injection exists`, after assuming the desired inequality,
is circular.

An accepted construction must prove:

1. the target pivot differs from `j`;
2. its output lies in the canonical grid and avoids all strict bad sets;
3. equality at the LRC boundary is retained as safe;
4. slot indices lie below `a_k/gcd(a_j,a_k)`;
5. collisions of output residues are separated by the slot or proved absent;
6. nonunit owners and coincident bad sets remain valid; and
7. injectivity survives changes between the moduli `M_j` and `M_k`.

Cardinality of this injection gives the frozen compensation inequality. A map
defined only on a convenient subset of tokens, an owner exchange with no good
target residue, or a pivot chosen after knowing `Q_k` is nonempty is
insufficient.

## Attack B: weighted charge conservation across pivot rows

Independently build the owner-indexed incidence object of triples `(j,i,r)`
with `r in B_i^j`, retaining coincident sets. From the same exact modular
quotient/remainder equations, assign `2*a_j` units of demand from a covered row
`j` to uncovered residues at other pivots. Prove a local arithmetic transport
identity and a global capacity bound in which each residue of `Q_k` receives at
most `a_k/gcd(a_j,a_k)` slots for the fixed source `j`.

All charges must be nonnegative integers fixed by an explicit rule. Do not use
Fourier transforms, fractional hypergraph duality, whole-block packing, a
common-prime conclusion, or a descent transformation. Do not average unrelated
residue representatives as though the pivot groups were identical.

The argument must finish at the exact weighted inequality. A double count that
only proves equality with the unknown `G_k`, chooses weights after observing
the good pivots, or assumes uniform bad-set fibers is bookkeeping or circular
and earns `STOP`. State the first unsupported transport or capacity arrow.

## Mandatory regression and falsification suite

Recompute all counts and weighted sides from the frozen definitions before
trusting either attack.

1. `(1,3,4)`, `n=3`: `G=(0,2,2)`. For the covered speed-`1` pivot, the weighted
   right side is `3*2+4*2=14`, versus demand `2`.
2. `(1,3,4,5)`, `n=4`: `G=(0,0,2,2)`. The covered speed-`1` row has weighted
   side `18` versus `2`; the covered speed-`3` row has side `18` versus `6`.
   Two covered pivots must remain distinct owner-indexed rows.
3. `(1,2,3,4,5,7)`, `n=6`: `G=(0,0,0,0,2,2)`. Its four covered pivots have
   weighted right side `24`; their demands are respectively `2,4,6,8`.
   The good residues are `{6,29}` modulo `35` at speed `5` and `{8,41}`
   modulo `49` at speed `7`. This tuple rejects `U>=n` and any claim that a
   large majority of covered pivots is itself contradictory; it does not
   refute the frozen weighted compensation.
4. `(1,2,8)`: `G=(0,0,6)`. It rejects any replacement requiring two distinct
   good pivots, while stressing a large exchange weight.
5. `(1,3)`: `G=(0,2)`; verify the `n=2` implication and both reflection points.
6. `(1,2,3)`: `G=(2,2,2)`; at pivot speed `3`, `rho=3` is safe.
7. `(4,5,9)`: `G=(2,2,4)` although the audited factorwise absolute Fourier
   criterion fails at every pivot.
8. `(1,3,5)`: classify all-odd half-time fixed points without double counting.
9. `(1,3,13)` at pivot speed `3`: the other speeds coincide modulo `12`; keep
   both owners and their coincident bad sets.
10. Test `r=0`, exclusion `N|r`, `rho=p_j-1`, equality `rho=p_j`, antipodes,
    a pivot pair with neither speed dividing the other, a pair with nontrivial
    gcd, every permutation of fixtures 1--3, and common scaling of a fixture.

For every proposed injection or charge rule, emit the first token for which it
is undefined, out of range, bad at the destination, or collides improperly.
One failure rejects that rule, not the frozen lemma. A counterexample to the
lemma must give the ordered tuple, source covered pivot, every `G_k`, every
weight, the exact failed inequality, and a complete finite replay certificate.

## Fixed finite budget

Computation is optional and only for falsification. If used, allow one source
file and one machine-readable output. Run the ten mandatory regressions first.
Then enumerate primitive strictly increasing tuples for `n=2,3,4,5,6`, largest
speed at most `12`, ordered by `n` and lexicographically; within a tuple order
source pivots and residues naturally. Stop at the first covered pivot violating
the frozen inequality, after emitting its exact certificate. Do not expand the
box, add random samples, or start a second scan after observing results.

Declare implementation language/version, command, domain, ordering, stop rule,
schema, and SHA-256 hashes. Completed zero-failure output remains only
`computed finite evidence` and cannot prove the unrestricted lemma.

An optional Lean prototype may formalize at most one local statement: either
the finite implication from the frozen inequality to a pivot certificate, or
cardinality of the explicitly supplied `D_j` type. It may not formalize both,
the open exchange construction, or an older route. Claim `proved-lean` only
after standalone compilation and an axiom audit.

## Disposition and stop rules

Return exactly one disposition.

- `BRIDGE`: the frozen compensation lemma is proved for every quantified tuple
  and pivot, and the complete implication chain is established. A replacement
  qualifies only if fully proved, genuinely cross-pivot and quantitative,
  strictly stronger than certificate existence, and sufficient for
  unrestricted LRC without a second open lemma.
- `PIVOT`: a prime-independent and height-independent exchange or charge
  theorem is proved which materially narrows one exact arrow to the frozen
  inequality, or an infinite family refutes a named strengthening and leaves a
  precise narrower surviving obligation.
- `STOP`: the frozen inequality is refuted; both attacks reduce to selecting an
  already-good pivot; an output map assumes its target is good; weights are
  chosen post hoc; a modular transport or capacity step is unsupported; only
  finite enumeration is obtained; or the response migrates to a forbidden
  route.

Finite success never earns `PIVOT` or `BRIDGE`. Failure of a proposed exchange
map does not disprove LRC. A true counterexample to the frozen inequality
rejects this stronger bridge only unless it also has every pivot covered.

## One-turn budget and required output

Use one major Sol Pro turn for the two attacks and the one frozen lemma. No
broad literature survey, second research target, or follow-up question is
permitted.

Return one self-contained memo with these sections, in order:

1. **Disposition** — exactly `STOP`, `PIVOT`, or `BRIDGE`.
2. **Status table** — one exact evidence label for each claim and dependency.
3. **Exact target** — definitions, quantifiers, weights, and strict boundary.
4. **Regression and non-tautology audit** — all mandatory fixtures and why the
   target is stronger than certificate existence.
5. **Attack A** — explicit modular exchange injection or first fatal arrow.
6. **Attack B** — weighted charge conservation or first fatal arrow.
7. **Falsification** — rules, exact counterexamples, and any bounded scan.
8. **Complete implication chain** — including the `n=1` split and exact Lean
   dependencies.
9. **Artifacts and replay** — only if an optional artifact was created.
10. **Final boundary** — proved, computed, conditional, rejected, and open
    claims without response self-promotion.

Do not return a catalogue of ideas. The sole goal is the exact weighted
cross-pivot deficit-compensation lemma, its decisive refutation, or one
rigorously proved structural partial theorem under these disposition rules.
