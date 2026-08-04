---
owner: GPT-5.6 Sol High top-level desktop orchestrator
supervising_authority: /root
launch_runtime: original browser-capable desktop Codex session
role: GPT-5.6 Sol / Pro mathematical research agent
task_id: SOL-P95-PRO-MAX-COVERED-PIVOT-292
base_commit: 33a690ddcaf66b818b74b6fa62ac16491c9638ba
admission: LAUNCH-CANDIDATE
prompt_encoding: UTF-8
prompt_line_endings: LF
prompt_hash_scope: bytes from the line "# Prompt 95:" through EOF
prompt_sha256: 5f917f80e45fcbc30a442a9c6e434c53d093477eeab2013a49ba599bf314944c
---

# Prompt 95: MAX-COVERED-PIVOT-INTERNAL-COVER-REDUNDANCY-CORRECTED

You are GPT-5.6 Sol running at Pro effort in a genuinely new ChatGPT
conversation. Act as the mathematical research agent. This is the actual
research turn, not a request to review prompt admission or prepare another
contract. If this text has been submitted to you, Sol High has already made
the launch decision. Attack the theorem below now.

Use one major turn. Prove the exact unrestricted theorem at every quantifier,
give an exact independently reproducible counterexample, or isolate one proved
unrestricted successor lemma that strictly narrows the first open edge. Do not
replace the theorem, perform only a contract review, or return another launch
checklist. Do not claim unrestricted Lonely Runner unless the complete
conditional chain is actually closed.

## Research contract

| Field | Frozen value |
| --- | --- |
| Exact theorem | `MAX-COVERED-PIVOT-INTERNAL-COVER-REDUNDANCY` below |
| Scope | all `n>=2` and all positive injective integer speed tuples; unrestricted height |
| Distinguished structure | the unique maximum-speed pivot among the covered pivots |
| Complete chain | redundancy -> no simultaneous full pivot cover -> exact positive-integer pivot certificate -> integer LRC -> accepted real reduction |
| Single unresolved lemma | the exact universal redundancy/no-internal-cover theorem |
| Falsification | exact strict modular definitions, frozen hand fixtures, malformed controls, and an optional frozen bounded replay |
| Stop condition | exact independently reproduced counterexample, or proved equivalence/reduction to circuit escape or unrestricted LRC |
| Maximum budget | one major Pro turn; no more than one third on finite checking |

The target preserves Prompt90's intended theorem without changing its
quantifiers, boundary convention, distinguished pivot, or complete covers.
Prompt90's prior operational failure is provenance only; it supplies no
mathematical premise or evidence.

## Evidence and provenance boundary

Unrestricted LRC remains open. The only accepted downstream inputs are:

- `proved-lean`: the exact positive-integer pivot-certificate equivalence;
- `proved-lean`: the equivalence between positive-integer and real-speed LRC,
  with positivity, injectivity, every dimension quantifier, circle distance,
  and the closed `>=1/(n+1)` threshold preserved;
- `proved-math-qualified`: elementary finite deletion to an
  inclusion-minimal labelled cover and the private-point property relative to
  that selected cover;
- `proved-math-qualified`: singleton-cover rigidity
  `B_i^j=R_j iff N*a_j divides a_i` for `N>=3`; and
- `open`: the theorem below, the exact uniform pivot existential, integer LRC,
  and real LRC.

The following hash-frozen files are specification provenance or route
descriptions only, not mathematical premises:

```text
research/sol-pro/prompts/prompt90.md
  fa32686d52bac99073031c85530891a46f3aeac25c185b2432d3b8da05f21a4b

research/sol-pro/responses/response90.md
  b6c69b73405c7ffd468695b6130b33f9deb50f00e96174746904afda3372ea50

research/sol-pro/audits/response90-recovery-audit-289.md
  67c12580ab4b23a466e87545bbb93daeb4ae1961f588e6d6b1fe31d8484b7ea9
```

The Prompt90 payload retained Medium-preparation metadata, so its Pro turn
returned an admission review instead of attempting the theorem. Preserve its
blocking corrections only as unverified specification feedback already
incorporated here. Do not cite its diagnostic counts as evidence.

Use exactly these response evidence labels:

```text
input-accepted
proved-lean
proved-math-qualified
proved-math-response
computed finite evidence
refuted-exact
conditional
conjectural
open
not-run
out-of-scope
rejected operational output
```

`proved-math-response` remains response-authored until independent audit.
`computed finite evidence` is always finite-scope and requires an executed,
hash-bound artifact. It never promotes an unrestricted statement. Do not
change an existing project label merely to fit this response vocabulary.

## Exact modular pivot data

Fix `n>=2`, put `N=n+1`, and let

```text
a : Fin n -> Nat
```

be positive and injective. Owner labels are indices. Never merge labels when
their speeds, residues, or bad subsets are congruent. For pivot `j`, put

```text
p_j = a_j,
M_j = N*p_j,

rho_M(x) = min(x mod M, M-(x mod M)),

R_j = {r in {0,...,M_j-1} : N does not divide r},

B_i^j = {r in R_j : rho_(M_j)(r*a_i) < p_j}  for i!=j,

Q_j = R_j \ union_(i!=j) B_i^j,

F(a) = {j : Fin n | Q_j is empty}.
```

Representatives are canonical. Badness is strict. Equality
`rho_(M_j)(r*a_i)=p_j` is safe. Retain zero modular products, both cyclic
sides, antipodes, nonunits, gcd-degenerate multiplication fibers, coincident
labelled sets, and excluded candidate residues. Exactly `p_j` representatives
are divisible by `N`, including zero, so

```text
|R_j| = M_j-p_j = n*p_j > 0.
```

For `r in R_j`, write `r=N*q+s` with `1<=s<=N-1`. Then

```text
rho_(N*p_j)(r*p_j) = p_j*min(s,N-s) >= p_j.
```

Thus the pivot coordinate is safe, and `Q_j` is exactly the canonical
pivot-certificate set at row `j`.

## Complete covers, minimality, and the fastest covered pivot

A labelled owner subset

```text
C subset Fin n \ {j}
```

is complete at pivot `j` when

```text
R_j = union_(i in C) B_i^j.
```

It is inclusion-minimal when no proper labelled subset is complete. If
`j in F(a)`, the full labelled owner set is complete, so finite deletion
produces an inclusion-minimal complete subcover. In such a selected minimal
cover every `i in C` has a nonempty private set

```text
Priv(j,C,i) = B_i^j \ union_(h in C, h!=i) B_h^j.
```

Privacy is relative only to `C`. An omitted owner may cover every element of a
private set.

If `F(a)` is nonempty, define `j_star` by

```text
j_star in F(a),
a_j_star = max {a_j : j in F(a)}.
```

Because `F(a)` is finite and nonempty and `a` is injective, this pivot exists
and is unique. There is no tie under the theorem premises. Repeated speeds are
malformed input and must be rejected before `j_star` is computed. Every
covered pivot `i!=j_star` satisfies `a_i<a_j_star`.

## Sole unrestricted theorem and three equivalent forms

Prove or refute exactly:

```text
MAX-COVERED-PIVOT-INTERNAL-COVER-REDUNDANCY:

For every n>=2 and every positive injective a : Fin n -> Nat,
if F(a) is nonempty and j_star is its unique maximum-speed element, then
for every labelled subset

  C subset F(a) \ {j_star},

if C completely covers R_j_star, there exists i in C such that

  C \ {i}

still completely covers R_j_star.
```

Equivalent minimal-cover form:

```text
Every inclusion-minimal complete cover of R_j_star contains an owner
i outside F(a), equivalently Q_i is nonempty.
```

Equivalent no-internal-cover form:

```text
There is no C subset F(a) \ {j_star} such that

  R_j_star = union_(i in C) B_i^j_star.
```

Prove all three equivalences. From an internal complete cover, finite deletion
produces an internal inclusion-minimal cover. Conversely, repeated use of the
one-owner redundancy conclusion would reach the empty cover, which cannot
cover the nonempty set `R_j_star`. The theorem quantifies over every internal
complete cover, not one response-selected, canonical, or sparsity-bounded
cover.

Do not add a height, primitive, finite-range, primality,
minimal-counterexample, genericity, or common-divisor premise. Common scaling
or coordinate permutation may be used only after proving the exact laws for
`R`, `B`, `Q`, `F`, `j_star` by speed, covers, and minimality.

## Complete conditional implication to unrestricted LRC

Derive this chain without assuming any additional existential:

1. Suppose every pivot of a positive injective integer tuple were covered.
   Then `F(a)=Fin n` is nonempty.
2. Let `j_star` be the global maximum-speed pivot. Its full owner set is a
   finite complete cover; delete owners until an inclusion-minimal complete
   subcover `C` remains.
3. Since every pivot is covered, `C subset F(a)\{j_star}`.
4. The sole theorem makes one owner of `C` redundant, contradicting
   inclusion-minimality.
5. Hence some `Q_j` is nonempty. Choose `r in Q_j`; pivot safety and the
   complements of all strict nonpivot bad sets give distance at least `1/N`
   for every coordinate at time `r/(N*a_j)`.
6. This proves positive-integer LRC for `n>=2`. Handle `n=1` directly with
   `N=2`, its unique pivot, and `r=1`.
7. Apply only the accepted positive-integer-to-real equivalence, preserving
   every quantifier and the closed endpoint.

This chain is `conditional` until the sole theorem is proved. A finite scan,
compiled conditional wrapper, or restatement of the pivot existential does
not prove LRC.

## Anti-tautology and route separation

The target implies bare pivot-certificate existence through the displayed
conditional chain. No converse or strict logical separation from LRC is
assumed. If the arithmetic target is proved equivalent to Prompt72 circuit
escape, the ordinary uniform pivot existential, or unrestricted LRC, that is a
valid structural `STOP`; do not rename the equivalent theorem as progress.

At the abstract labelled-set level, circuit escape does not imply the present
redundancy statement. Take covered labels `F={0,1,2,3}`, one good label `4`,
speeds increasing with the labels, and unique minimal dependency circuits

```text
C_0={1}, C_1={2}, C_2={3,4}, C_3={0,1}.
```

Realize each circuit on a separate abstract ground set with one private point
per listed owner. Every nonempty subset of `F` has an outgoing circuit edge,
yet the fastest covered label `3` has the internal minimal cover `{0,1}`.
This is an abstract anti-tautology fixture, not a speed tuple or an LRC
counterexample.

The duplication audit is against only the route signatures stated here and
the following hash-frozen files. Do not use browser memory or an unfrozen
version of another prompt as a premise.

```text
Prompt92: AGGREGATE-DYADIC-C2-COVER-DIVISIBILITY
research/sol-pro/prompts/prompt92.md
654f8bc4de240642483cd83898c6cd272cf0eb3635ab9c08971bdc2d2ac2c3dd

Prompt94: ALL-PIVOT-UNIT-STRATUM-MOBIUS-DEFICIT
research/sol-pro/prompts/prompt94.md
dfb9d28e46091512864edb182524a60819d5ae0e34b4d1c4b9ba05f09e0e3ae8

Prompt89 recovery scope
research/sol-pro/audits/response89-recovery-audit-276.md
87964b5bc418514e4947d238b8041fbbf2470f763617ead389a1d192655afe7c
```

- Prompt92 uses one large dyadic fixed grid and product-divisibility forcing.
  Do not introduce a dyadic threshold, deletion-gcd supply, or product-bound
  premise here.
- Prompt94 selects the exact unit gcd stratum through divisor-lattice Mobius
  inversion. Do not replace internal-cover redundancy by a unit-numerator
  deficit or a tuple-selected divisor stratum.
- Prompt93 is referenced only by its route signature, a common-clock rational
  score/`Psi` proposal. No Prompt93 operative statement, counterexample, or
  evidence status is supplied or assumed here.
- Prompt89's response proposed balanced-junction and root-star targets. Its
  recovery audit keeps both universal selectors open and its attachments
  quarantined/unverified. No bag, separator, junction score, or reported
  finite minimum is a premise here.
- Prompt78's known stress tuple `(6,7,12,24,144)` distinguishes its pivot-7
  internal cover from this theorem's fastest-covered pivot. Recheck it from
  the literal definitions below; do not import an unstated theorem.
- Prompt76 private-demand Hall sums, Prompt69 weighted compensation, Prompt70
  common-prime propagation, Prompt86 local multiplicity score, Prompt66
  whole-block packing, owner-aware multishift, coefficient-two Gamma, and
  height compression are separate routes and may not be assumed.

Restricting the theorem to an all-covered tuple as a premise inside an
uncrossing lemma, assuming an owner outside `F(a)`, or choosing an already-good
pivot is circular.

## Frozen mandatory hand fixtures

Recompute every applicable predicate literally. These controls validate
definitions and proposed calculations; they are not evidence for the
unrestricted theorem.

### Fastest-covered rows

For each tuple list every pivot, labelled bad set, `Q`, `F`, `j_star`, every
complete cover, and every inclusion-minimal cover. The expected speed-labelled
summaries are:

| Tuple | Covered speeds `F(a)` | `j_star` speed | Inclusion-minimal covers at `j_star`, by speed |
| --- | --- | ---: | --- |
| `(1,6,11,12,13)` | `{1,6}` | `6` | `{1,11,12,13}` |
| `(6,7,12,24,144)` | `{6,7,12,24}` | `24` | `{144}` |
| `(1,4,5,6,7,11)` | `{1,4,5,11}` | `11` | `{1,4,5,6,7}` |

Each displayed minimal cover contains an owner outside `F(a)`. A mismatch is
a specification failure, not permission to alter the theorem.

### Strict boundary, cyclic, collision, and candidate controls

1. For `(1,3,4,5)`, `n=4`, `N=5`, pivot speed `3`, modulus `15`, and owner
   speed `1`:
   - `r=2` is a candidate and has `rho_15(2)=2<3`, so it is bad;
   - `r=13` is a candidate and has `rho_15(13)=2<3`, testing the other cyclic
     side; and
   - `r=3` is a candidate and has `rho_15(3)=3`, so equality is safe against
     that owner. Other owners must still be evaluated separately.
2. For `(1,3,13)`, `N=4`, pivot speed `3`, modulus `12`, owners `1` and `13`
   have equal bad subsets because their multipliers are congruent modulo 12,
   but they remain two distinct owner labels.
3. For `(1,3,4)`, pivot speed `1`, modulus `4`, owner speed `4` has zero
   modular product on every candidate and singleton-covers `R_j`. Owner speed
   `3` does not singleton-cover that row. This checks both directions of
   singleton rigidity.
4. For `(1,3,4)`, pivot speed `3`, modulus `12`, owner speed `1`, candidate
   `r=6` maps to the antipode and is safe. Representatives `r=0,4,8` are
   excluded because `N=4` divides them.
5. For `(1,2,3)`, pivot speed `3`, modulus `12`, `r=3` and `r=9` are retained
   nonunit candidates. They are safe against speeds `1` and `2`, with equality
   for speed `1`; do not discard or cancel them.
6. For `(4,5,9)`, `N=4`, pivot speed `5`, modulus `20`, owner speed `4`, the
   distinct candidate residues `r=1` and `r=6` both map to residue `4` and are
   bad. This is a gcd-degenerate multiplication fiber, not a collision to
   deduplicate.
7. At `(6,7,12,24,144)`, pivot speed `7`, the proposed owner set `{6,12}` is
   deliberately declared complete and must be rejected as
   `EXPECTED_COVER_FAILURE`. The target row remains the distinct pivot speed
   `24`.

### Scaling and permutation control

Use base tuple `(1,6,11,12,13)`, common scale factor `5`, and the permutation
of original positions `(4,0,3,1,2)`, which produces
`(13,1,12,6,11)` before scaling. Compare results by speed label, not array
position. Before scaling the covered-speed set must remain `{1,6}` and the
distinguished covered speed must remain `6`; after scaling the corresponding
speed-labelled set is `{5,30}` and the distinguished speed is `30`. Any proof
using this control must first establish the exact scaling and permutation
laws rather than infer them from the fixture.

### Malformed and deliberately false controls

Use these exact first-failure codes:

```text
(0,1,2)
  -> NONPOSITIVE_SPEED

(1,1,2)
  -> NONINJECTIVE_SPEED

(1,3,13), pivot index 1, proposed owner indices {0,1}
  -> PIVOT_OWNER_FORBIDDEN

(1,3,13), pivot speed 3, delete least literal candidate r=1 from R_j
  -> RESIDUE_DOMAIN_MISMATCH

(1,3,13), pivot speed 3, merge labelled owners 1 and 13
  -> OWNER_LABEL_MISMATCH

(6,7,12,24,144), pivot speed 7, declare {6,12} complete
  -> EXPECTED_COVER_FAILURE
```

The abstract circuit fixture must pass abstract circuit escape and fail
internal-cover redundancy. It is processed separately from speed tuples and
must never be serialized as a theorem-domain counterexample.

## Deterministic ordering and optional bounded execution

The required literal-verifier pseudocode must define this total order:

```text
tuples: increasing n, then lexicographic increasing speed tuple
pivots: increasing pivot speed
residues: canonical representatives 0,...,N*p-1 in increasing order
owners: increasing owner speed, retaining original labels
owner subsets: cardinality first, then lexicographic increasing speed list
private candidates: least canonical residue when a witness must be selected
failures: first record in the preceding total order
```

The pseudocode must separately define premise validation, literal `R_j`, every
labelled `B_i^j`, `Q_j`, `F(a)`, unique `j_star`, complete covers,
inclusion-minimality, private sets, and the three theorem forms. Pseudocode is
required for falsifiability but is not an execution artifact and cannot
establish completion or finite evidence.

Executing a self-generated verifier is optional. Do not spend research time
building code unless the mathematical attack needs it. If no verifier is
executed, label the bounded domain `not-run` and make no claim about its
counts or failures.

If executed, use only this frozen domain of primitive strictly increasing
tuples:

```text
(n,H) = (2,20), (3,20), (4,18), (5,16), (6,14), (7,12),

a in combinations({1,...,H}, n), gcd(a)=1.
```

The review-only expected tuple counts are

```text
127, 997, 2919, 4311, 2996, 792; total 12,142.
```

They are unverified specification controls, not evidence. Reproduce or reject
them; do not tune or enlarge the domain after seeing results.

Any optional execution must supply three separate response attachments:

1. deterministic source;
2. a machine-readable execution manifest; and
3. a machine-readable result file.

Hash each attachment over its exact bytes with SHA-256. Record language and
interpreter/compiler version, process exit status, deterministic order,
fixture completion, total completed tuple and pivot counts, source/result
binding, and `first_failure=null` only after full completion. Do not claim
independence for response-authored code. Independent audit occurs only after
recovery.

The first-failure record must contain exactly these core fields, with optional
additional diagnostic fields allowed only after them:

```text
n, tuple, pivot_index, pivot_speed, N, M, residue,
owner_indices, owner_speeds, expected, observed, failure_code
```

A partial prefix, pseudocode-only result, missing file, hash mismatch, stale
output, or malformed fixture is `not-run` or `rejected operational output`,
not computed finite evidence.

## Required mathematical attacks

### Attack A - fastest-covered minimal-cover classification

Assume an inclusion-minimal internal cover `C` exists at `j_star`. Every
`i in C` is covered and has `a_i<a_j_star`; singleton rigidity forces
`|C|>=2`. Select the least private candidate

```text
r_i in Priv(j_star,C,i)
```

under the frozen residue order. Put `p=a_j_star`. For each `r_i`, define
`e_i` as the unique integer in

```text
{-(p-1), ..., -1, 0, 1, ..., p-1}
```

and `q_i` as the unique integer satisfying

```text
r_i*a_i = q_i*N*p + e_i.
```

Prove uniqueness: strict badness gives `|e_i|<p`, and `N>=3` makes two such
representatives modulo `N*p` impossible. Include `e_i=0`, both signs,
nonunits, cyclic reflection, and coincident labelled bad subsets. Safety of
`r_i` against every other selected owner must be written explicitly. A
private candidate is not globally safe because omitted owners remain.

Seek a contradiction using the strict speed order and the complete modular
conditions. State the first unsupported inequality or congruence if the
classification does not close.

### Attack B - exact cross-pivot uncrossing

For a selected `i in C`, choose a fully specified inclusion-minimal complete
cover `D_i` at pivot `i`. The only admissible proposed replacement at pivot
`j_star` is

```text
E_i = (C \ {i}) union (D_i \ {j_star}).
```

The label `j_star` is never an admissible owner at its own pivot. If
`j_star in D_i`, its coverage contribution at pivot `i` cannot be carried into
`E_i` by identity, deletion, or unstated transport. Either discharge that
contribution through an explicit residue map with proved fibers, collisions,
candidate preservation, and strict boundaries, or declare the exchange
unsupported.

No cover or key decrease may be claimed until

```text
R_j_star = union_(h in E_i) B_h^j_star
```

is proved literally. Every cross-modulus map must specify domain, codomain,
representatives, fibers, exceptional residues, zero products, nonunits,
collisions, and both strict cyclic sides.

Freeze any descent key before choosing `i`. An admissible key is a completely
specified well-founded lexicographic tuple such as

```text
(|C|, maximum owner speed, total owner speed,
 increasing speed-labelled owner list).
```

Prove strict decrease and show that replacement cannot reintroduce a larger
covered owner. Merely finding an owner outside `F(a)` in `E_i` does not make
an owner of the original internal cover `C` redundant. The exchange must
either produce a proper complete subset of `C` or enter a fully proved
well-founded chain whose terminal contradiction excludes the original
internal cover. Raw modular reduction, nearest-boundary selection without
fiber control, or deletion of `j_star`'s contribution is not uncrossing.

### Attack C - minimal internal-cover obstruction or counterfamily

Independently seek an arithmetic obstruction forced by an internal minimal
cover at the maximum covered speed: a divisibility cycle, CRT incompatibility
among private congruences, strict product contradiction, or a determinant
with a proved height-independent nonzero bound. The obstruction must use
`j_star` speed maximality essentially and must not choose a prime or divisor
after locating the desired certificate.

If the theorem is false, prefer a symbolic infinite counterfamily. Otherwise
give the lexicographically first exact candidate found under a declared
search domain, together with every premise, labelled set, complete-cover, and
minimality check. Do not weaken or replace the theorem after failure.

## Exact disposition semantics

A procedural stop only ends searching in the current turn. It does not by
itself determine the mathematical disposition.

Return `BRIDGE` only for a complete proof of the sole theorem at every
quantifier plus the entire implication chain.

Return `PIVOT` only for a proved unrestricted arithmetic theorem that strictly
narrows the first open edge without adding an equally strong existential,
assuming a good pivot, or invoking LRC/circuit escape.

Return `STOP` only if either:

1. an exact theorem-domain counterexample is supplied with every literal
   premise and cover check and is independently reproduced by a second
   derivation or execution whose independence is explained; or
2. a complete structural proof shows that the first remaining obligation is
   exactly Prompt72 circuit escape, the uniform positive-integer pivot
   existential, unrestricted LRC, or a theorem equivalent to one of them.

A response-authored `STOP` remains `proved-math-response` or
`computed finite evidence` at its exact scope until downstream independent
audit accepts it. If independent reproduction is unavailable in this turn,
report the counterexample as a candidate under `OPEN` and specify the exact
replay obligation.

Return `OPEN` when attacks terminate at unsupported arrows, a failed proposed
map, missing fiber or strict-boundary control, an unproved arithmetic lemma,
or a counterexample candidate lacking the required independent reproduction.
Name exactly one first missing lemma.

## Required response schema

Return exactly these sections.

1. **Disposition** - `BRIDGE`, `PIVOT`, `STOP`, or `OPEN` under the exact rules
   above.
2. **Evidence boundary** - one allowed evidence label for every imported and
   new claim; no project-level promotion.
3. **Frozen definitions** - finite domains, canonical representatives,
   strict boundary, labels, collisions, `Q`, `F`, unique `j_star`, covers,
   minimality, privacy, and all three target forms.
4. **Equivalence audit** - prove the redundancy, minimal-cover, and
   no-internal-cover equivalences without importing LRC.
5. **Route separation** - compare only the frozen signatures supplied here;
   explain why the proof is not Prompt72, P92, P93, P94, P89, or an excluded
   earlier route.
6. **Mandatory fixtures** - every exact success, equality, cyclic-side,
   antipode, zero, nonunit, collision, scaling/permutation, malformed, and
   deliberately false control.
7. **Verifier pseudocode** - deterministic literal architecture and total
   ordering; distinguish it from execution.
8. **Optional execution** - `not-run`, or exact attachment names, hashes,
   versions, exit status, completion counts, and first failure. Never infer
   execution from pseudocode.
9. **Attack A** - complete classification or first unsupported arrow.
10. **Attack B** - exact `D_i`, `E_i`, cross-modulus transport, cover proof,
    and well-founded key, or first unsupported arrow.
11. **Attack C** - obstruction, exact counterfamily, or first unsupported
    arrow.
12. **Sole theorem** - complete proof, exact independently reproducible
    counterexample, or unchanged `open` status at every frozen quantifier.
13. **Complete implication chain** - include finite deletion, `n=1`, pivot
    safety, strict complements, the closed endpoint, and accepted Lean
    directions.
14. **Proof-obligation ledger** - exact claim, hypotheses, dependency,
    evidence label, falsifier, first open edge, and downstream audit required.
15. **Final evidence boundary** - distinguish response reasoning, optional
    finite execution, conditional consequences, rejected operations, and open
    unrestricted statements.

## One-turn budget and fail-closed rules

Use at most one third of the turn on mandatory controls, pseudocode, or
optional finite execution; at least one third on exact cross-pivot arithmetic;
and the remainder on independent obstruction analysis, implication audit, and
disposition. Do not prototype Lean unless a complete unrestricted arithmetic
lemma first survives.

Fail closed on any of the following:

- changing strict `<p_j` badness to `<=p_j` or losing the closed safe endpoint;
- removing a cyclic side, zero product, antipode, nonunit, collision, or
  excluded `N`-multiple;
- deduplicating owner labels or treating private points as globally safe;
- permitting `j_star` to own its own pivot after an exchange;
- moving residues between pivot moduli without an explicit map, fiber count,
  candidate proof, and strict-boundary proof;
- claiming `E_i` covers before proving the literal union equality;
- choosing or changing a descent key after seeing the exchange;
- failing to use the maximum-covered-speed property essentially;
- importing an unfrozen prior-route theorem, ordinary pivot certificate, good
  owner, uncovered pivot, or LRC premise;
- treating review-only counts, pseudocode, a partial prefix, or stale output
  as computed finite evidence;
- returning `STOP` for an unsupported arrow that is only `OPEN`;
- proving only a bounded-height or finite-range statement and calling it the
  unrestricted theorem; or
- silently weakening or replacing the target after failure.

A rigorous negative result or exact first obstruction is useful. Do not
fabricate completion, promote a launch or contract review as research, or
claim unrestricted LRC without closing and independently auditing the exact
kernel-checkable theorem.
