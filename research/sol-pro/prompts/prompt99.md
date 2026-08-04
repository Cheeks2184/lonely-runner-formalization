---
owner: GPT-5.6 Sol High top-level desktop orchestrator
supervising_authority: /root
launch_runtime: original browser-capable desktop Codex session
role: GPT-5.6 Sol / Pro mathematical research agent
task_id: SOL-P99-PRO-MAX-COVERED-DIVISIBLE-PIVOT-REDUNDANCY-316
base_commit: 068de11a61a6551256138110e2920af9cec89284
admission: REVIEW-REQUIRED
prompt_encoding: ASCII
prompt_line_endings: LF
prompt_hash_scope: bytes from the line "# Prompt 99:" through EOF
prompt_sha256: 164ba48076c1bced2f3e2fb76162a609a17475ff6a376b8deb886c5ad91eabdb
---

# Prompt 99: MAX-COVERED-DIVISIBLE-PIVOT-REDUNDANCY

You are GPT-5.6 Sol running at Pro effort in a genuinely new ChatGPT
conversation. Act as the mathematical research agent. This is the actual
research turn, not a request to review prompt admission or prepare another
contract. If this text has been submitted, Sol High has already made the
launch decision. Attack the exact theorem below now.

Use one major turn. Prove this unrestricted branch theorem, give one exact
independently reproducible theorem-domain counterexample, or return the frozen
separation alternative with one precise quotient or descent edge. Spend a
strict majority of the turn on uniform mathematics. Do not reopen all of
Prompt95, replace the branch, or claim unrestricted Lonely Runner.

## Research contract

| Field | Frozen value |
| --- | --- |
| Exact theorem | `MAX-COVERED-DIVISIBLE-PIVOT-REDUNDANCY` below |
| Scope | every `n>=2` and positive injective integer tuple, restricted only by `N` dividing the maximum-speed covered pivot |
| New structure | exact reduction of the pivot row modulo `p`, with `N` sheets and a formal threshold `d=p/N` |
| Required attack | quotient/divisor-layer peeling, `p/N` descent, exact cover exchange, or an exact counterexample |
| Complete branch consequence | closes only the `N|p` maximum-covered-pivot branch of Prompt95 |
| Independent complement | Prompt98 is intended to address `N` not dividing `p`, but is unproved and is not a premise |
| Stop condition | exact theorem-domain internal minimal cover, or a semantic defect in the branch or quotient identities |
| Maximum budget | one major Pro turn; at least two thirds uniform mathematics and at most one third finite work |

This is a genuinely narrower subcase of Prompt95. It adds the arithmetic
hypothesis `N|p`, where `p` is the unique maximum speed among covered pivots.
It is not full Prompt95, a unit-deficit statement, or a tautological witness
supply. Even a complete proof does not establish the complementary branch.

The branch-specific opportunity is that `p=N*d` makes reduction modulo `p`
preserve the exclusion of `N`-multiple candidates. Owners whose speeds are
divisible by `N` become full-fiber quotient bad sets. Prove every identity and
every lift-back condition; do not treat this observation as redundancy.

## Evidence boundary and dependency map

Unrestricted LRC remains open. Accepted Lean pivot and real/integer reductions
may be cited only in the downstream dependency map. They are not premises for
the new arithmetic theorem.

Prompt95's tracked prompt fixes historical terminology, but its response,
attachments, searches, and response-authored claims are not evidence. Reprove
every fact used here from the definitions below.

Prompt98 is a separate prepared contract for the complementary `N`-nondivisible
branch. It is unproved, is not an accepted input, and cannot be invoked.

The exact dependency map is:

```text
Prompt99 theorem
  -> closes only the N|p branch of Prompt95.

Prompt98 theorem, if separately proved
+ Prompt99 theorem, if separately proved
  -> full MAX-COVERED-PIVOT-INTERNAL-COVER-REDUNDANCY.

Full Prompt95, if proved
  -> canonical pivot certificate
  -> positive-integer LRC
  -> unrestricted positive-real LRC.
```

Prompt99 alone does not prove any statement on the last two lines.

Do not reuse or rename:

- full Prompt95 as the new lemma;
- Prompt98 as a premise or proved complementary case;
- Prompt94 unit deficits, Mobius layers, response, or artifacts;
- Prompt66 packing, radial descent, tokens, or signed phase cells;
- prime forcing, obstruction-prime supply, or product-divisibility bridges;
- coefficient-two Gamma matching;
- height compression, minimal-counterexample descent, or first-blocker flow;
- a synchronized impossible witness like the stopped Prompt97 route;
- an ordinary pivot certificate or unrestricted LRC as an input.

Use these response labels exactly:

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
```

No response-authored claim is promoted merely because it is written, computed,
or compiled.

## Exact canonical pivot rows

Fix `n>=2`, put `N=n+1`, and let

```text
a : Fin n -> Nat
```

be positive and injective. Labels are indices and are never merged. For pivot
`j`, define

```text
p_j = a_j,
M_j = N*p_j,

rho_M(x) = min(x mod M, M-(x mod M)),

R_j = {r in {0,...,M_j-1} : N does not divide r},

B_i^j = {r in R_j : rho_(M_j)(r*a_i) < p_j}  for i!=j,

Q_j = R_j minus union_(i!=j) B_i^j,

F(a) = {j : Fin n | Q_j is empty}.
```

Representatives are canonical. Badness is strict, so equality `rho=p_j` is
safe. Retain both cyclic sides, zero products, antipodes, nonunits,
gcd-degenerate multiplication fibers, coincident labelled bad sets, and the
excluded `N`-multiple representatives when validating the candidate domain.

Exactly `p_j` representatives are divisible by `N`, including zero, and

```text
|R_j| = n*p_j > 0.
```

For `r in R_j`, write `r=N*q+s`, `1<=s<=N-1`, and prove

```text
rho_(N*p_j)(r*p_j) = p_j*min(s,N-s) >= p_j.
```

Thus `Q_j` is exactly the canonical pivot-certificate set at row `j`.

## Maximum covered pivot and internal covers

If `F(a)` is nonempty, define `j_star` by

```text
j_star in F(a),
a_j_star = max {a_j : j in F(a)}.
```

It exists uniquely by finiteness and injectivity. Put

```text
p = a_j_star,
M = N*p,
R = R_j_star.
```

Every covered pivot `i!=j_star` has `a_i<p`.

A labelled subset

```text
C subset Fin n minus {j_star}
```

is complete at `j_star` when

```text
R = union_(i in C) B_i^j_star.
```

It is inclusion-minimal if no proper labelled subset remains complete. It is
internal when

```text
C subset F(a) minus {j_star}.
```

For an inclusion-minimal complete cover and `i in C`, define

```text
Priv(C,i) = B_i^j_star minus union_(h in C, h!=i) B_h^j_star.
```

Every private set is nonempty and privacy is relative only to `C`. Reflection
preserves `R` and every bad set. In this branch `p=N*d`. If `M/2` exists, it is
a multiple of `N` and is excluded from `R`. Therefore reflection has no fixed
candidate, every private set is a disjoint union of pairs, and the least
canonical lower-half private representative exists. Prove this parity claim
before using it.

The theorem quantifies over every internal complete cover. One failed proposed
cover cannot establish the tuplewise theorem. One actual internal
inclusion-minimal complete cover is enough to refute it.

## Exact `N`-sheet quotient structure

Under the branch hypothesis write

```text
p = N*d,
M = N*p = N^2*d,

S = {x in {0,...,p-1} : N does not divide x}.
```

Every canonical `r in {0,...,M-1}` has a unique representation

```text
r = x+k*p,
0<=x<p,
0<=k<N.
```

Because `N|p`, prove

```text
r in R  iff  x in S.
```

Thus reduction modulo `p` is an exact `N`-to-one map

```text
pi : R -> S,
pi(x+k*p)=x.
```

For every owner speed `b`, prove the phase identity

```text
(x+k*p)*b == x*b + p*(k*b mod N)  (mod M).
```

If `h=gcd(N,b)`, the phases `k*b mod N`, `0<=k<N`, visit the `N/h`
multiples of `h`, each exactly `h` times. Do not replace this multiset by all
`N` phases unless `gcd(N,b)=1`.

### Full-fiber quotient for `N`-divisible owners

If `N|b`, write `b=N*c`. Prove

```text
(x+k*p)*b == N*x*c  (mod M),

rho_M((x+k*p)*b) = N*rho_p(x*c),

x+k*p in B_b^j_star  iff  rho_p(x*c) < d.
```

The condition is independent of `k`; an `N`-divisible owner's bad set is a
union of complete `pi` fibers.

The base set `S` is exactly the canonical candidate set for a formal pivot
speed `d`, with the same `N` and modulus `N*d=p`. The quotient coefficient of
owner `b=N*c` is `c`. This is a row identity only. The number `d` need not be
a speed in `a`; quotient coefficients need not form a theorem-domain tuple;
and no quotient pivot is known to lie in `F(a)`.

For a nondivisible owner, its coverage may vary with `k`. A projection of its
bad set to `S` loses phase information. To delete or replace a full-fiber
owner `b=N*c`, prove the phasewise inclusion

```text
pi^(-1)({x in S : rho_p(x*c)<d})
  subset union_(i in C, i!=b) B_i^j_star.
```

A union of quotient projections is insufficient.

## Sole unrestricted branch theorem

Prove or refute exactly:

```text
MAX-COVERED-DIVISIBLE-PIVOT-REDUNDANCY:

For every n>=2 and every positive injective a : Fin n -> Nat,
if F(a) is nonempty, j_star is its unique maximum-speed element,
p=a_j_star, and N divides p, then for every labelled subset

  C subset F(a) minus {j_star},

if C completely covers R_j_star, there exists i in C such that

  C minus {i}

still completely covers R_j_star.
```

Prove within the response the equivalent forms:

```text
No inclusion-minimal complete cover of R_j_star is internal.

There is no complete C subset F(a) minus {j_star}.
```

Finite deletion proves the equivalence. The empty set cannot cover the
nonempty row. Do not change coverwise quantifiers into one selected-cover
claim.

## Exact branch consequence and remaining open work

If the theorem is proved, derive only:

```text
N divides the maximum-speed covered pivot
  -> the exact Prompt95 redundancy/no-internal-cover conclusion for that tuple.
```

The `N`-nondivisible branch remains open unless Prompt98 is separately proved.
Prompt98 is not a premise in this turn.

Only the conjunction of independently proved Prompt98 and Prompt99 branch
theorems would close full Prompt95 by the exhaustive divisibility case split.
Only full Prompt95 would enter its separate conditional chain to the pivot
certificate and LRC.

Prompt99 alone does not prove full Prompt95, a pivot certificate, integer LRC,
or real LRC.

## Required uniform attack lanes

### Lane A - quotient layers and full-fiber owners

Assume for contradiction that an internal inclusion-minimal cover `C` exists.
Partition its owners by `gcd(N,a_i)` and identify the `N`-divisible full-fiber
owners. Use the exact phase multiset for every other owner. Determine whether
private fibers force a removable full-fiber owner or a rigid all-phase pattern.
Track omitted owners and relative privacy; do not assume a matroid exchange.

If `C` has no `N`-divisible owner, the full-fiber quotient identity alone says
nothing. Prove a separate divisor-layer obstruction or report this as the
first open case.

### Lane B - `p/N` descent

Use `d=p/N<p` only through an explicit construction. If proposing a quotient
tuple or pivot row, define every speed and label, prove positivity and
injectivity, prove its dimension still gives the same `N`, compute every
candidate exclusion and strict bad set, determine its covered-pivot set and
maximum covered pivot, and prove how redundancy lifts back to the original
row.

The formal quotient row at speed `d` is not automatically a row of `a` and is
not automatically covered. Dividing only selected owners does not produce a
valid tuple theorem. Dividing all speeds is allowed only when all are divisible
and after proving every premise and the exact common-scaling law.

### Lane C - cover exchange through a lower covered pivot

For any owner `i in C`, coveredness `i in F(a)` supplies complete covers at
pivot `i`. If substituting one such cover into the row at `j_star`, specify the
residue map, domain, codomain, fibers, labels, collisions, excluded
`N`-multiples, strict equality, and both cyclic sides. Prove the literal union
inclusion at `j_star` before deleting `i`.

The label `j_star` cannot own its own row. If it occurs in a lower-pivot cover,
its contribution cannot be dropped without an independently proved
replacement.

### Lane D - well-founded descent or exact counterexample

Freeze a tuple-independent key, for example

```text
(p, d, number of non-full-fiber owners, |C|, increasing owner labels),
```

before using it. Every replacement must preserve tuple-domain premises,
`F(a)`, the identity of `j_star`, internality, complete coverage, labels, and
strict boundaries, or must create a new exact obstruction with a strictly
smaller key.

Adversarially search for a tuple in the exact branch with an internal complete
cover. If found, deterministically delete to an inclusion-minimal cover and
return all private pairs and quotient phases.

## Mandatory exact fixtures

Recompute every fixture literally. These are specification controls, not
accepted evidence for the unrestricted theorem.

### 1. Small divisible maximum fixture

For

```text
a=(1,6,11,12,13), n=5, N=6,
```

verify

```text
F(a)={1,6},
j_star=6,
p=6=N*1,
M=36,
d=1.
```

The unique inclusion-minimal complete cover at pivot `6` is
`{1,11,12,13}`. It is not internal. The full internal owner set is `{1}`;
its least uncovered candidate is `7`. Reproduce the six-sheet quotient and
show that owner `1` is phase-dependent, not a full-fiber owner.

### 2. Divisible Prompt95 stress fixture

For

```text
a=(6,7,12,24,144), n=5, N=6,
```

verify

```text
F(a)={6,7,12,24},
j_star=24,
p=24=6*4,
M=144,
d=4.
```

The unique inclusion-minimal complete cover at pivot `24` is `{144}`, which
is outside `F(a)`. The full internal owner set `{6,7,12}` is incomplete, with
least uncovered candidate `4`. Owners `6` and `12` are full-fiber quotient
owners with quotient coefficients `1` and `2`; owner `7` is phase-dependent.

At the separate pivot `7`, the covers `{6,12,24}` and `{6,12,144}` are
transport-only. Pivot `7` is not `j_star` and is in the complementary
nondivisible case. It cannot stop or prove this theorem.

The representative `r=p=24` is excluded because `N|r`. Do not import the
nondivisible-branch `r=p` slice.

### 3. Prompt92-derived scaling pair

First verify independently for

```text
a=(1,8,13,15,27,28), n=6, N=7
```

that `F(a)={1,8}` and `j_star=8`, so the base tuple is outside Prompt99 because
`7` does not divide `8`.

Then scale by `7`:

```text
a'=(7,56,91,105,189,196).
```

Verify

```text
F(a')={7,56},
j_star=56,
p=56=7*8,
M=392,
d=8.
```

At pivot `56`, the unique inclusion-minimal complete cover is
`{7,91,105,189,196}`, which is not internal. The full internal owner set is
`{7}`, with least uncovered candidate `8`. Owner `7` is a full-fiber quotient
owner with coefficient `1`.

This scaling changes branch membership. Prove any common-scaling law before
using it; do not infer Prompt99 from the unproved Prompt98 branch.

### 4. Strict boundary, collision, and candidate controls

For `(1,3,4,5)`, `n=4`, `N=5`, pivot `p=3`, candidate `r=3` is safe against
owner `1` by equality. This checks strictness even though that pivot is not the
Prompt99 maximum fixture.

For `(1,4,17)`, `n=3`, `N=4`, pivot `p=4`, modulus `16`, owners `1` and `17`
induce the coincident labelled bad sets `{1,2,3,13,14,15}` and remain distinct
labels.

For `(1,2,3)`, `N=4`, pivot `3`, candidates `3` and `9` are retained nonunits.
Do not replace ordinary candidate rows by unit rows.

In the `N|p` branch, prove that any antipode `M/2` which exists is an excluded
multiple of `N`. A verifier which includes it in `R` must fail.

Reject `(0,1,2)` as nonpositive, `(1,1,2)` as noninjective, an owner set
containing the pivot label, a wrong `j_star`, weak badness, an omitted cyclic
side, or a quotient record which loses phase multiplicities.

### 5. Quotient and lift-back controls

For every divisible-branch fixture, list each base `x in S`, all `N` lifts,
and each owner's phase multiset for the smallest nontrivial fibers needed to
check the formulas. Include:

- one `N`-divisible owner whose membership is constant on the fiber;
- one owner with `gcd(N,b)=1` visiting all phases;
- one owner with `1<gcd(N,b)<N` visiting fewer phases with multiplicity;
- strict equality at the quotient threshold `rho_p(x*c)=d` remaining safe;
- a deliberately false quotient-projection inclusion which holds after
  projection but fails on at least one lift.

The last control must reject any proof that unions projected bad sets and then
silently lifts the union.

## Coverwise and tuplewise fail-closed controls

The following do not prove the theorem:

- one proposed internal owner set fails to cover;
- one minimum cover contains an owner outside `F` while other covers are
  unclassified;
- an internal cover exists at a nonmaximum pivot;
- quotient projections cover `S` without phasewise lift coverage;
- a formal row at speed `d` is covered without being embedded in a valid
  positive injective tuple;
- a finite search has zero failures.

For a fixed tuple, no internal complete cover exists exactly when

```text
union_(i in F(a) minus {j_star}) B_i^j_star != R_j_star.
```

If equality holds, finite deletion yields an internal inclusion-minimal cover
and the tuple is a counterexample to Prompt99.

## Finite preflight and optional falsification

Before a larger run, validate:

- all five fixture groups above;
- one known complete and one known incomplete cover;
- every quotient fiber identity and phase multiplicity;
- strict equality, both cyclic sides, nonunits, and excluded multiples;
- coincident labelled bad sets;
- nonpositive, repeated-speed, pivot-owner, and wrong-`j_star` rejection;
- transport-only pivot `7` of `(6,7,12,24,144)` rejected as a Prompt99 result;
- a deliberately altered expected gap or quotient phase;
- a projection-only false positive rejected at lift-back.

If computation is used, freeze a modest height before execution and order
strictly increasing tuples by dimension and then lexicographically. Use
increasing pivot labels, canonical residues, owner labels, quotient bases and
fiber phases. Order subsets first by cardinality and then lexicographically.
Select the first failure in that total order and report raw and primitive
counts separately.

Implementation A must literally enumerate every `R_j`, labelled bad set,
`Q_j`, `F`, `j_star`, internal owner subset, complete cover, minimality, and
private set.

Implementation B must independently build the quotient bases, all lifts, and
phase tables at divisible maximum pivots, then compute the full internal-owner
union directly on lifted residues. If it covers, start from increasing internal
labels, remove the least redundant label, restart, and continue to a minimal
cover. Shared row, cover, or quotient code is forbidden.

Report language/version, exact domain, deterministic order, completion marker,
source/output hashes, first disagreement, first theorem-domain failure, and
first malformed failure. Partial prefixes are `not-run`. Zero failures become
computed finite evidence only after immutable independent replay and never
prove the theorem.

## Anti-tautology and stop gates

Reject any argument that:

1. assumes full Prompt95, Prompt98, or an ordinary pivot certificate;
2. treats `N|p` as permission to divide an arbitrary subset of speeds;
3. promotes the formal quotient pivot `d` to a covered tuple pivot without
   proving every premise;
4. projects owner bad sets but omits fiber phases or lift-back;
5. changes candidate exclusions under quotient or scaling;
6. treats strict equality as bad;
7. drops, merges, or relabels owners during cover exchange;
8. deletes `j_star` from a lower-pivot cover without replacement;
9. changes `F(a)` or `j_star` without recomputing every pivot row;
10. infers the tuplewise theorem from one failing cover;
11. uses a tautological supply of an already impossible witness;
12. calls bounded zero failures an unrestricted proof; or
13. claims Prompt99 alone proves full P95 or LRC.

## Mutually exclusive final dispositions

Return exactly one primary disposition.

### `PIVOT`

Give a complete proof of `MAX-COVERED-DIVISIBLE-PIVOT-REDUNDANCY` at every
frozen quantifier, prove the equivalent forms, and state only the branch
consequence. `PIVOT` means a proved research bridge, not a pivot certificate or
unrestricted LRC.

### `STOP`

Give an exact positive injective tuple with `F(a)` nonempty, `j_star` its
unique maximum-speed covered pivot, `N|a_j_star`, and an actual internal
inclusion-minimal complete cover at `j_star`. Report every modulus, candidate
row, bad set, `Q`, `F`, `j_star`, cover, private pair, quotient base, phase
table, and first strict-boundary check. Supply two independently checkable
literal verifiers. State that this refutes only the divisible branch.

### `SEPARATION`

If neither proof nor exact counterexample is obtained, prove the exact
`N`-sheet and full-fiber quotient identities and the strongest additional
uniform statement actually reached. Identify exactly one next lemma involving
a phasewise lift, divisor-layer peeling, valid quotient tuple, cover exchange,
or well-founded `p/N` descent. Its statement must freeze every map, fiber,
label, candidate, strict boundary, `F`, `j_star`, and lift-back premise. It must
be more informative than the quotient identities and strictly narrower than
assuming Prompt99. Prove that it would close the branch, but do not claim the
next lemma itself is proved.

A definition, projection without lifts, trichotomy, finite scan, or restatement
of redundancy is not a separation theorem.

## Required response schema

Return exactly these sections:

1. **Disposition** - `PIVOT`, `STOP`, or `SEPARATION`.
2. **Evidence boundary** - dependencies, exclusions, and labels.
3. **Exact definitions** - rows, strictness, `F`, `j_star`, covers,
   minimality, internality, privacy, and deterministic orders.
4. **Branch equivalences** - redundancy and both no-internal-cover forms.
5. **Quotient structure** - unique fibers, candidate preservation, phase
   multisets, full-fiber owners, and strict quotient identity.
6. **Fixture ledger** - every mandatory fixture and malformed control.
7. **Lane A** - quotient/divisor layers and first unsupported inclusion.
8. **Lane B** - exact `p/N` construction or first failed premise.
9. **Lane C** - cover exchange, lift-back, or first failed transport.
10. **Lane D** - descent or finite counterexample method.
11. **Sole theorem** - complete proof, exact counterexample, or unchanged open
    status at every frozen quantifier.
12. **Dependency map** - Prompt99-only consequence and all remaining branches.
13. **Proof-obligation ledger** - claim, dependencies, evidence class,
    falsifier, first open edge, and downstream owner.
14. **Declaration-level plan** - only for statements surviving this response.
15. **Final evidence table** - accepted input, response proof, computation,
    conditional statements, refutations, and open claims.

## One-turn budget and fail-closed rules

Use at most 15 percent for definitions, equivalences, and fixtures; at least 35
percent for quotient/divisor-layer mathematics; at least 25 percent for
descent, exchange, or adversarial uniform analysis; and at most 25 percent for
finite falsification, artifacts, and the final ledger. A strict majority must
address novel uniform mathematics beyond the elementary quotient identities.

Return `STOP` immediately on a fully verified theorem-domain counterexample or
on a semantic inconsistency in the branch statement. Return `SEPARATION`, not
`PIVOT`, at the first unsupported quotient lift, tuple construction, cover
exchange, descent, or uniform quantifier. Preserve Prompt98, the complementary
branch, full Prompt95, the pivot theorem, and unrestricted LRC as open unless
they are independently proved in separate exact work.

Do not write Lean before the arithmetic survives independent audit. Do not use
`sorry`, `admit`, new axioms, `unsafe`, `native_decide`, or an opaque external
oracle. Do not promote any result merely because code ran or a nearby theorem
compiled.
