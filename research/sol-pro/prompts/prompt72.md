---
owner: GPT-5.6 Sol High top-level desktop orchestrator
supervising_authority: /root
launch_runtime: original browser-capable desktop Codex session
role: Research Pipeline Lead - prompt preparation only
task_id: PIPE-P72-MODULAR-COVER-CIRCUIT-CONTRACT-135
---

# Prompt 72: MODULAR-COVER-CIRCUIT-ESCAPE

This is one isolated unrestricted Sol Pro research contract. Prove or
decisively refute the exact circuit-escape lemma below. The intended structure
is classification and arithmetic uncrossing of canonical inclusion-minimal
complete modular bad-set covers. Matroidal or polymatroidal language is allowed
only after its exact ground set, rank function, and axioms are proved.

This file is a prepared contract only. It is not a browser launch, response,
proof, computation, audit, or status promotion. Only GPT-5.6 Sol High under
`/root`, using the original signed-in browser-capable desktop session, may
launch the Pro turn. Do not delegate research to Luna.

The route must remain distinct from:

- active Prompt68 cofinite prime forcing;
- Prompt69 weighted deficit compensation and its injection;
- Prompt70 simultaneous-full-cover common-prime propagation;
- Prompt66 whole-block packing, radial descent, and signed phase cells;
- frozen top-two, owner-shift, Gamma, height-compression, deletion, descent,
  and first-blocker routes; and
- generic hypergraph statements which merely rename noncoverage.

Use `proved-lean`, `proved-math`, `computed finite evidence`, `conditional`,
`conjectural`, `rejected`, and `open` literally. The response may recommend a
disposition but may not promote its own claims before independent audit.

## Existing exact boundary

The repository has these `proved-lean` equivalences:

```text
exists_witness_iff_exists_pivot_certificate
positiveIntegerConjecture_iff_pivotCertificateConjecture
conjecture_iff_positiveIntegerConjecture.
```

They identify one uncovered canonical pivot residue with a fixed-instance real
witness and reduce unrestricted real LRC to the positive-integer proposition.
They do not establish an uncovered residue. The statements
`not (forall j, Covers(j))`, `exists j, G_j>0`, and positivity of an exact
certificate count are rejected as tautological targets.

## Frozen modular objects and strict boundary

Let `n : Nat`, `2 <= n`, put `N=n+1`, and let

```text
a : Fin n -> Nat
```

be positive and injective. For each pivot `j : Fin n`, define

```text
p_j = a_j,
M_j = N*p_j,
rho_M(x) = min(x mod M, M-(x mod M)),
R_j = {r : Fin M_j | N does not divide r.val},
B_i^j = {r : R_j | rho_(M_j)(r.val*a_i) < p_j}  for i != j,
Q_j = R_j \ union_(i!=j) B_i^j,
G_j(a) = |Q_j|,
Covers(j) :<=> Q_j is empty.
```

The bad boundary is strict `<p_j`; equality is safe. Do not replace cyclic
distance by a one-sided interval. Every `Fin M_j` value uses its unique
representative. Multiples of `N` are excluded, making the pivot coordinate
safe. Original speeds are injective, but their modular residues need not be:
retain nonunits, gcd degeneracies, repeated residues, coincident bad sets, and
separate owner labels.

Prove

```text
Covers(j) <-> union_(i!=j) B_i^j = R_j
```

before using a cover. Reflection `r |-> -r` must handle fixed points without
doubling. Pivot groups have different moduli; there is no implicit transport
of residues, representatives, or characters between them.

Define the finite set of completely covered pivots

```text
F(a) = {j : Fin n | Covers(j)}.
```

## Canonical modular-cover circuits

For `j in F(a)`, an owner set `C` is a complete cover when

```text
C subset {i : Fin n | i != j}
and union_(i in C) B_i^j = R_j.
```

Order owners by increasing integer speed `a_i`; injectivity makes this a strict
total order independent of coordinate labels. Order complete covers by the key

```text
(|C|, the increasing list of speeds {a_i | i in C})
```

lexicographically, and let `C_j` be the unique least complete cover. Prove
existence, uniqueness, and that minimum cardinality makes `C_j`
inclusion-minimal. For every `i in C_j`, prove existence of a private point

```text
r_(j,i) in B_i^j \ union_(h in C_j, h != i) B_h^j.
```

The owner-labelled family `C_j` is called the canonical modular-cover circuit
at `j`. This terminology does not assert a matroid. In particular, do not cite
circuit elimination until the exact family of circuits on one declared ground
set is shown to satisfy the circuit axioms.

## Sole unrestricted exchange/rank lemma

There is exactly one permitted unresolved lemma:

```text
MODULAR-COVER-CIRCUIT-ESCAPE:

For every n : Nat with 2 <= n, every positive injective
a : Fin n -> Nat, and every nonempty subset S of F(a),

  there exist j in S and i in C_j such that i is not in S.
```

Equivalently, no nonempty collection of covered pivots is closed under every
owner in its canonical cover circuits. The displayed quantified statement is
frozen. Do not weaken it to `F(a)` being proper, to one circuit containing an
uncovered owner, or to `exists j, G_j>0`; those conclusions are the existing
certificate target in disguise.

This lemma is materially stronger than the pivot equivalence: it gives an
outgoing canonical-circuit edge for **every** nonempty subset of covered
pivots. It is a narrower arithmetic rank/uncrossing problem than unrestricted
real LRC because all objects are finite modular covers with a fixed canonical
selection.

## Complete implication chain

Split `n=1` first. With no nonpivot owners, the unique pivot grid is nonempty,
so any candidate is uncovered and gives the certificate. Do not invoke a
circuit or second pivot in this case.

For `n>=2`, suppose for contradiction that every pivot is covered. Then
`F(a)=Fin n`, which is nonempty. Apply
`MODULAR-COVER-CIRCUIT-ESCAPE` to `S=F(a)`. It yields `j in F(a)` and
`i in C_j` with `i notin F(a)`, contradicting `F(a)=Fin n`. Therefore some
pivot is not covered. Extract `r in Q_j`; expand its membership into avoidance
of every strict nonpivot bad set and prove the pivot coordinate safe.

Finish through the exact repository implications

```text
one canonical pivot certificate
  -> PositiveIntegerPivotCertificateConjecture
  -> PositiveIntegerConjecture
  -> Conjecture
  -> unrestricted real LRC.
```

Use the two `proved-lean` equivalences in the correct directions, with exact
positivity, injectivity, indexing, representative, and closed-boundary
hypotheses. Do not describe the real/integer step merely as density.

## Attack A: arithmetic circuit elimination

Assume a nonempty `S subset F(a)` is closed: `C_j subset S` for every
`j in S`. Choose an extremal pivot and circuit using a deterministic key fixed
in advance, such as the increasing pair `(a_j, circuit speed-list)`. Track all
private points and their exact centered quotient/remainder equations

```text
r_(j,i)*a_i = q_(j,i)*N*a_j + e_(j,i),
|e_(j,i)| < a_j
```

with the sign and representative convention stated precisely.

Use a second circuit `C_i` inside the closed set to perform a genuine modular
elimination: replace one owner of `C_j` by explicitly identified owners from
`C_i`, and prove that their bad sets still cover every point formerly covered
only by that owner. The resulting owner set must be a complete cover at the
**original pivot modulus** `M_j` and must have either smaller cardinality or the
same cardinality with a lexicographically smaller speed-list, contradicting
the canonical definition of `C_j`.

Every elimination step must prove:

1. the exact source and target circuits and eliminated owner;
2. coverage of all private points, not merely aggregate cardinality;
3. transport between `M_i` and `M_j` without cancelling a nonunit;
4. preservation of strict badness and safe equality;
5. handling of coincident bad sets and repeated modular residues; and
6. strict decrease of the declared circuit key.

An abstract circuit-elimination slogan, owner swap, or generic set-cover
exchange is insufficient. This is not speed descent: no tuple is transformed
and no height measure may be introduced. Finish at circuit escape or identify
the first unsupported arithmetic elimination arrow.

## Attack B: coverage polymatroid and no-closed-set rank inequality

For each covered pivot define on owner subsets

```text
rank_j(A) = |union_(i in A) B_i^j|,
def_j(A) = |R_j| - rank_j(A).
```

Prove from finite sets that `rank_j` is normalized, monotone, and submodular.
Do not call it a matroid rank: its singleton bounds and unit-increment axiom
generally fail. Prove exact marginal formulas at the canonical circuit;
private points make every removal have positive deficiency.

Assuming a closed nonempty `S`, combine the pivot-indexed submodular ranks using
one explicitly declared integer potential determined before selecting an
extremal tuple. Derive a strict rank inequality which says that at least one
`C_j`, `j in S`, contains an owner outside `S`. Track diagonal exclusions,
gcd-dependent fibers, coincident bad sets, and the fact that the rank functions
live over different ambient residue grids.

A sum of identities `rank_j(C_j)=|R_j|`, a generic hypergraph theorem, or a
potential whose final positivity is equivalent to an unknown `G_k>0` is
tautological. Do not use Prompt69's weighted good-residue injection, Prompt70's
common prime, Fourier transforms, packing, or descent. Finish at the exact
escape lemma or state the first unsupported cross-pivot rank inequality.

## Mandatory regression and falsification suite

Recompute every count and canonical circuit from the frozen ordering.

1. `(1,3,4)`, `n=3`: `G=(0,2,2)`. The only covered pivot has speed `1` and
   canonical circuit `{4}`, which escapes the covered set.
2. `(1,3,4,5)`, `n=4`: `G=(0,0,2,2)`. The canonical circuits at covered speeds
   `1` and `3` are respectively `{5}` and `{1,4,5}`. Every nonempty subset of
   these two covered pivots has an outgoing owner.
3. `(1,2,3,4,5,7)`, `n=6`: `G=(0,0,0,0,2,2)`. The canonical circuits at
   covered speeds `1,2,3,4` are respectively
   `{7}`, `{1,3,5,7}`, `{1,4,5,7}`, and `{1,2,3,5,7}`. The good residues are
   `{6,29}` modulo `35` and `{8,41}` modulo `49`. This fixture rejects the old
   total-mass bound and shows that four covered pivots are not contradictory by
   cardinality alone.
4. `(1,6,11,12,13)`, `n=5`: `G=(0,0,8,8,10)`. The canonical circuits at
   speeds `1` and `6` are `{6}` and `{1,11,12,13}`. Choosing the least-speed
   owner creates the false cycle `1 -> 6 -> 1`; the full circuit still escapes
   through `11`, `12`, or `13`. Reject any proof based only on a canonical
   single-owner selector.
5. `(1,2,8)`: `G=(0,0,6)`; both covered circuits must escape to the sole good
   pivot, while a claim requiring two good pivots is false.
6. `(1,3)`: `G=(0,2)`; verify the `n=2` circuit and reflection pair.
7. `(1,2,3)`: `G=(2,2,2)` and equality `rho=3` is safe at pivot speed `3`.
8. `(1,3,5)`: classify all-odd half-time fixed points without doubling.
9. `(1,3,13)` at pivot speed `3`: the other owners coincide modulo `12`;
   retain both owner labels and test canonical tie handling.
10. Test `r=0`, exclusion `N|r`, `rho=p_j-1`, equality `rho=p_j`, antipodes,
    a nondividing pivot pair, a pair with nontrivial gcd, every permutation of
    fixtures 1--4, and common scaling. Canonical circuits must be relabelled by
    speed, not changed by coordinate order.

For every proposed elimination or rank inequality, identify the first private
point, owner, or subset where it fails. A counterexample to the frozen lemma
must provide the ordered tuple, `F(a)`, every canonical circuit, a nonempty
closed subset `S`, all pivot counts, and an exact replay certificate. Failure
of a sufficient exchange rule rejects only that rule, not LRC.

## Fixed finite falsification budget

Computation is optional and only for falsification. If used, allow one source
file and one machine-readable output. Run the ten fixtures first. Then
enumerate primitive strictly increasing tuples for `n=2,3,4,5,6`, largest
speed at most `12`, ordered by `n` then lexicographically. For each tuple,
order pivots naturally, construct the canonical minimum-cardinality/lex cover,
and enumerate nonempty subsets of `F(a)` by cardinality then lexicographically.
Stop at the first closed subset and emit its complete certificate. Do not grow
the box, add random samples, or start another scan after seeing the result.

Declare language/version, command, domain, canonical ordering, early-stop
rule, schema, and SHA-256 hashes. A completed zero-failure scan remains only
`computed finite evidence` and cannot prove the unrestricted lemma.

An optional Lean prototype may formalize at most one local statement: either
canonical minimum-cardinality covers have private points, or circuit escape
implies a pivot certificate. It may not formalize both, the open escape lemma,
or an older route. Claim `proved-lean` only after standalone compilation and an
axiom audit.

## Disposition and stop rules

Return exactly one disposition.

- `BRIDGE`: the circuit-escape lemma is proved at every stated quantifier and
  the complete implication chain is established. A replacement qualifies only
  if fully proved, genuinely arithmetic and cross-pivot, strictly stronger than
  noncoverage, and sufficient for unrestricted LRC without another open lemma.
- `PIVOT`: an unrestricted, height-independent arithmetic elimination or rank
  theorem is proved which materially narrows one exact arrow to circuit escape,
  or an infinite family refutes a named strengthening and leaves a precise
  narrower surviving obligation.
- `STOP`: the frozen lemma is refuted; both attacks reduce to generic set-cover
  facts; circuit elimination is assumed rather than proved; the decisive rank
  inequality is equivalent to an uncovered residue; only finite enumeration
  is obtained; or the response migrates to a forbidden route.

Finite success never earns `PIVOT` or `BRIDGE`. Failure of circuit escape does
not disprove LRC unless the closed subset is all pivots and every row is truly
covered.

## One-turn budget and required output

Use one major Sol Pro turn for both attacks and the single frozen lemma. No
broad literature survey, second target, or follow-up question is permitted.

Return one self-contained memo with these sections, in order:

1. **Disposition** — exactly `STOP`, `PIVOT`, or `BRIDGE`.
2. **Status table** — one exact evidence label per claim and dependency.
3. **Exact target** — domains, canonical circuit order, quantifiers, and strict
   boundary.
4. **Regression and non-tautology audit** — all mandatory fixtures, especially
   the false single-owner cycle.
5. **Attack A** — arithmetic circuit elimination or first fatal arrow.
6. **Attack B** — coverage-polymatroid rank proof or first fatal arrow.
7. **Falsification** — exact counterexamples and any bounded scan.
8. **Complete implication chain** — including `n=1` and exact Lean
   dependencies.
9. **Artifacts and replay** — only if an optional artifact was created.
10. **Final boundary** — proved, computed, conditional, rejected, and open
    claims without response self-promotion.

Do not return a catalogue of ideas. The sole goal is the exact modular-cover
circuit-escape lemma, its decisive refutation, or one rigorously proved
structural partial theorem under these disposition rules.
