---
owner: GPT-5.6 Sol High top-level desktop orchestrator
supervising_authority: /root
launch_runtime: original browser-capable desktop Codex session
role: GPT-5.6 Sol / Pro mathematical research agent
task_id: SOL-P98-PRO-MAX-COVERED-NONDIVISIBLE-PIVOT-REDUNDANCY-315
base_commit: 5db949acb0866ab9b67543b889b6d2d73447afc8
admission: REVIEW-REQUIRED
prompt_encoding: ASCII
prompt_line_endings: LF
prompt_hash_scope: bytes from the line "# Prompt 98:" through EOF
prompt_sha256: cb5c5445f87a70805077ddd49c8e4900a7f5d95d6cdffa56c69b4521cab1a1a7
---

# Prompt 98: MAX-COVERED-NONDIVISIBLE-PIVOT-REDUNDANCY

You are GPT-5.6 Sol running at Pro effort in a genuinely new ChatGPT
conversation. Act as the mathematical research agent. This is the actual
research turn, not a request to review admission or prepare another contract.
If this text has been submitted, Sol High has already made the launch decision.
Attack the exact theorem below now.

Use one major turn. Prove this unrestricted branch theorem, give one exact
independently reproducible theorem-domain counterexample, or return the frozen
separation alternative with one precise next arithmetic edge. Spend a strict
majority of the turn on uniform mathematics. Do not reopen all of Prompt95,
replace the branch, or claim unrestricted Lonely Runner.

## Research contract

| Field | Frozen value |
| --- | --- |
| Exact theorem | `MAX-COVERED-NONDIVISIBLE-PIVOT-REDUNDANCY` below |
| Scope | every `n>=2` and positive injective integer tuple, restricted only by `N` not dividing the maximum-speed covered pivot |
| New forced structure | the `t*p` candidate slice forces a lower covered owner whose speed is divisible by `N` |
| Required attack | peel, project, replace, or descend through that forced `N`-divisible owner, or give an exact counterexample |
| Complete branch consequence | closes only the `N`-nondivisible maximum-covered-pivot branch of Prompt95 |
| Remaining open | the `N|p` branch, full Prompt95, the pivot theorem, and unrestricted LRC |
| Stop condition | exact theorem-domain internal minimal cover, or a semantic defect in the frozen branch statement |
| Maximum budget | one major Pro turn; at least two thirds uniform mathematics and at most one third finite work |

This is a genuinely narrower subcase of Prompt95: it adds the arithmetic
hypothesis `N` does not divide `p`, where `p` is the unique maximum speed among
covered pivots. It is neither full Prompt95 nor equivalent to the ordinary
pivot existential. Even a complete proof leaves the complementary `N|p`
branch open.

The new work is not the elementary observation that a complete cover contains
an `N`-divisible owner. Reprove that observation exactly, then use it in a
uniform peeling, projection, replacement, or descent argument.

## Evidence boundary and route independence

Unrestricted LRC remains open. Accepted Lean pivot and real/integer reductions
may be cited only to describe downstream status; they are not premises for the
new theorem.

Prompt95's tracked prompt fixes historical terminology, but its response,
attachments, searches, and any response-authored theorem are not evidence and
must not be used. Reprove every fact needed here from the definitions below.

Do not reuse or rename:

- full `MAX-COVERED-PIVOT-INTERNAL-COVER-REDUNDANCY` as the new lemma;
- Prompt94 unit deficits, Mobius layers, response, or artifacts;
- Prompt96 synthesis outputs;
- packing, radial descent, tokens, signed phase cells, or whole-block packing;
- obstruction-prime supply, prime forcing, or product-divisibility bridges;
- coefficient-two Gamma matching;
- height compression, minimal-counterexample descent, or first-blocker flow;
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
safe. Retain both cyclic sides, zero modular products, antipodes, nonunits,
gcd-degenerate multiplication fibers, coincident labelled bad sets, and all
excluded `N`-multiple representatives when validating the candidate domain.

Exactly `p_j` representatives are divisible by `N`, including zero, and

```text
|R_j| = n*p_j > 0.
```

For `r in R_j`, write `r=N*q+s`, `1<=s<=N-1`. Prove

```text
rho_(N*p_j)(r*p_j) = p_j*min(s,N-s) >= p_j.
```

Thus `Q_j` is exactly the canonical pivot-certificate set at row `j`.

## Covered pivots, the maximum pivot, and covers

If `F(a)` is nonempty, define `j_star` by

```text
j_star in F(a),
a_j_star = max {a_j : j in F(a)}.
```

Finiteness and injectivity make it unique. Put

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

It is inclusion-minimal when no proper labelled subset is complete. It is
internal when

```text
C subset F(a) minus {j_star}.
```

For an inclusion-minimal complete cover and `i in C`, define

```text
Priv(C,i) = B_i^j_star minus union_(h in C, h!=i) B_h^j_star.
```

Every `Priv(C,i)` is nonempty. Privacy is relative to `C`; an omitted owner
may cover the same residue. Reflection preserves the strict bad predicates.
An exclusive set is therefore a union of reflection pairs together with a
possible fixed antipode `M/2` when that residue lies in `R`. Zero is excluded,
but the antipode need not be. Do not assume every private set has a lower-half
member. If a deterministic witness is needed, use the least canonical
`r in Priv(C,i)` and handle a fixed antipode explicitly.

The theorem quantifies over every internal complete cover. One proposed cover
which fails to cover does not prove that no other internal cover exists. A
counterexample requires one actual internal inclusion-minimal complete cover.

## Mandatory `t*p` slice lemma

Reprove this elementary consequence before any novel attack.

For `1<=t<=N-1`, put

```text
r_t = t*p.
```

It is a canonical representative in `{0,...,N*p-1}`, and

```text
r_t in R  iff  N does not divide t*p.
```

For every owner speed `b=a_i`, prove exactly

```text
rho_(N*p)(r_t*b) = p*rho_N(t*b),

r_t in B_i^j_star  iff  N divides t*b,
```

whenever `r_t in R`. The second equivalence uses that `rho_N(t*b)` is a
nonnegative integer and badness is strict.

If `gcd(t,N)=1` and `N` does not divide `p`, then `r_t in R` and

```text
r_t in B_i^j_star  iff  N divides b.
```

In particular, `t=1` shows:

```text
If N does not divide p and C completely covers R,
then C contains an owner i with N divides a_i.
```

If `C` is internal, this forced owner is itself a covered pivot and, by
maximality and injectivity,

```text
N divides a_i  and  0<a_i<p.
```

This slice lemma is not the branch theorem. It supplies one owner but does not
show that owner redundant, transport its cover, or contradict its coveredness.

## Sole unrestricted branch theorem

Prove or refute exactly:

```text
MAX-COVERED-NONDIVISIBLE-PIVOT-REDUNDANCY:

For every n>=2 and every positive injective a : Fin n -> Nat,
if F(a) is nonempty, j_star is its unique maximum-speed element,
p=a_j_star, and N does not divide p, then for every labelled subset

  C subset F(a) minus {j_star},

if C completely covers R_j_star, there exists i in C such that

  C minus {i}

still completely covers R_j_star.
```

Prove the following equivalent forms within the response:

```text
No inclusion-minimal complete cover of R_j_star is internal.

There is no complete C subset F(a) minus {j_star}.
```

Finite deletion proves the equivalence. The empty set cannot cover the
nonempty row `R_j_star`. Do not change coverwise quantifiers into the claim
that one favored cover is redundant.

## Exact branch consequence and nonconsequence

If the theorem is proved, derive only:

```text
N does not divide the maximum-speed covered pivot
  -> the exact Prompt95 redundancy/no-internal-cover conclusion for that tuple.
```

Consequently, under the branch theorem, any hypothetical tuple with every
pivot covered and with maximum speed not divisible by `N` is impossible. Any
hypothetical all-covered tuple must therefore have its global maximum speed
divisible by `N`.

The following remain open:

```text
the complementary N|p maximum-covered-pivot branch;
full MAX-COVERED-PIVOT-INTERNAL-COVER-REDUNDANCY;
unrestricted canonical pivot existence;
positive-integer LRC;
unrestricted positive-real LRC.
```

Common scaling cannot erase this distinction without proof. In particular, a
scale factor may turn `N`-nondivisibility into divisibility.

## Required uniform attack lanes

### Lane A - forced divisible owner and private slices

Assume for contradiction that an internal inclusion-minimal cover `C` exists.
Use the `t*p` slice to select the least owner label `i in C` with `N|a_i`.
Write

```text
a_i = N*c,  0<a_i<p.
```

Study its canonical private reflection pairs. Determine which residue classes
can be private to an `N`-divisible owner and whether all of `B_i^j_star` can be
reassigned. Do not infer global privacy or a matroid exchange axiom.

### Lane B - projection or peeling through the covered owner

Because `i in F(a)`, row `i` is itself completely covered. Seek an explicit
map between a declared subset of `R_j_star` and `R_i`, with exact domain,
codomain, fibers, collisions, excluded `N`-multiples, both cyclic sides, and
strict equality behavior. If a complete cover at pivot `i` is substituted for
owner `i` at pivot `j_star`, prove the literal union inclusion before deleting
anything.

The label `j_star` cannot own its own pivot after substitution. If it appears
in a cover at pivot `i`, its contribution must be transported or replaced by
a proved rule; it cannot simply be dropped.

### Lane C - arithmetic descent

Try a well-founded descent on a frozen key such as

```text
(p, least N-divisible owner speed, |C|, increasing owner-label list),
```

ordered lexicographically. A replacement must remain a complete internal
cover at the distinguished maximum covered pivot, or must produce a new exact
theorem-domain obstruction with a strictly smaller key. Prove candidate-row,
label, strict-boundary, and `F(a)` preservation before claiming decrease.

Do not choose a descent key after seeing a failed transport.

### Lane D - adversarial counterexample search

Search directly for a positive injective tuple with `F(a)` nonempty,
`j_star` maximal by speed, `N` not dividing `a_j_star`, and an internal
complete cover. Enumerate every required row before classifying `F` or
`j_star`. If found, delete owners deterministically to an inclusion-minimal
internal cover and return its private sets. A cover at a nonmaximum pivot is
transport-only and cannot stop the theorem.

## Mandatory exact fixtures

Recompute every fixture literally. These are specification controls, not
accepted evidence for the unrestricted theorem.

### 1. Nonmaximum transport-only fixture

For

```text
a=(6,7,12,24,144), n=5, N=6,
```

verify

```text
F(a)={6,7,12,24} by speed label,
j_star=24,
N divides 24.
```

The branch theorem is therefore inapplicable at `j_star`. At the separate
covered pivot `p=7`, where `N` does not divide `7`, verify:

```text
M=42;
the inclusion-minimal covers are {6,12,24} and {6,12,144};
the candidate r=p=7 is covered exactly by N-divisible owners;
{6,12} is not complete, with least uncovered candidate r=2.
```

The cover `{6,12,24}` is internal relative to pivot `7`. This proves the
maximum-covered-pivot hypothesis is essential. Pivot `7` is transport-only:
it is not a theorem-domain counterexample because it is not `j_star`.

### 2. Prompt92-derived injective `E=3` fixture

For

```text
a=(1,8,13,15,27,28), n=6, N=7,
```

verify independently:

```text
F(a)={1,8},
j_star=8,
7 does not divide 8,
M_j_star=56,
the five-owner cover is {1,13,15,27,28},
only owner 1 belongs to F(a) minus {8},
r=p=8 is covered by owner 28 and is safe for owner 1.
```

Thus the known complete cover is not internal, and the full internal owner set
`{1}` does not cover. This is a positive branch control, not a proof.

### 3. Divisible-boundary fixture

For

```text
a=(1,6,11,12,13), n=5, N=6,
```

verify `F(a)={1,6}`, `j_star=6`, and `N|p`. The branch is excluded exactly at
the arithmetic boundary. Its minimum cover at pivot `6` must not be used to
claim anything about the `N`-nondivisible branch.

### 4. Strict boundary, collision, and nonunit controls

For `(1,3,4,5)`, `n=4`, `N=5`, pivot `p=3`, check that `r=p=3` is a
candidate, owner speed `1` is safe by equality, and owner speed `5` covers it
by a zero product. This is the literal `t=1` slice.

For `(1,3,13)`, `N=4`, pivot `3`, owners `1` and `13` have coincident bad
sets modulo `12` but remain distinct labels.

For `(1,2,3)`, `N=4`, pivot `3`, candidates `r=3,9` are nonunits and remain
in `R_j`; equality for owner `1` is safe. Do not replace `R_j` by a unit row.

Reject `(1,1,2)` before computing `F` or `j_star`. Reject owner sets containing
the pivot label, weak badness, an omitted cyclic side, or a row with zero
silently removed.

### 5. Scaling control

Compare

```text
a=(1,8,13,15,27,28)
```

with its common scale by `7`:

```text
7*a=(7,56,91,105,189,196).
```

Verify by speed label that the covered sets are respectively `{1,8}` and
`{7,56}`, and the distinguished covered speeds are `8` and `56`. The base
tuple satisfies `7` not dividing `8`; the scaled tuple satisfies `7|56` and is
outside the branch. Prove any row, cover, or private-set scaling law before
using it. The branch predicate itself is not scale invariant.

## Coverwise and tuplewise fail-closed controls

The following do not prove the theorem:

- one proposed internal owner set fails to cover;
- one inclusion-minimal cover contains an owner outside `F` while another
  cover has not been classified;
- an internal cover exists at a covered pivot which is not `j_star`;
- the full internal owner union fails only in a finite sample;
- a scaled tuple leaves the branch;
- a finite search has zero failures.

For a fixed tuple, proving that no internal complete cover exists may use the
exact equivalence

```text
union_(i in F(a) minus {j_star}) B_i^j_star != R_j_star.
```

If that full union covers, finite deletion produces an internal
inclusion-minimal cover and the tuple is a counterexample to the branch.

## Finite preflight and optional falsification

Before a larger run, validate:

- all five fixture groups above;
- one known complete cover and one known incomplete cover;
- strict equality and both cyclic sides;
- coincident labelled bad sets;
- nonunit and excluded `N`-multiple residues;
- repeated-speed and pivot-owner rejection;
- a deliberately wrong `j_star` at pivot `7` of `(6,7,12,24,144)`;
- a deliberately altered expected first-uncovered residue for `{6,12}`;
- a synthetic premise-violating record which is detected as such, not emitted
  as a theorem-domain counterexample.

If computation is used, freeze a modest height before execution and order
strictly increasing tuples by `n` and then lexicographically. Use increasing
pivot labels, canonical increasing residues, increasing owner labels, and
owner subsets ordered first by cardinality and then lexicographically. Select
the first failure in that total order. Report raw and primitive counts
separately.

Implementation A must literally enumerate every `R_j`, labelled `B_i^j`,
`Q_j`, `F`, `j_star`, every internal owner subset, complete covers, minimality,
and private sets.

Implementation B must independently compute the union of all internal owners
at `j_star`. On equality with `R_j_star`, it must construct a minimal cover by
starting with the increasing internal owner-label list, deleting the least
label whose removal preserves coverage, and restarting the scan until no
deletion is possible. Shared cover or row code is forbidden.

Report language/version, exact domain, deterministic ordering, completion
marker, source hashes, output hashes, first disagreement, first theorem-domain
failure, and first malformed-input failure. Partial prefixes are `not-run`.
Zero failures become computed finite evidence only after immutable independent
replay and never prove the theorem.

## Anti-tautology and stop gates

Reject any argument that:

1. assumes full Prompt95 or an ordinary pivot certificate;
2. replaces `N` not dividing `p` by a favorable scaling or normalization;
3. selects a nonmaximum covered pivot after inspecting its cover;
4. proves only the mandatory `t*p` slice lemma;
5. treats the forced `N`-divisible owner as redundant without a literal cover
   inclusion or descent;
6. transports a cover between moduli without a map, fiber proof, candidate
   proof, and strict-boundary proof;
7. drops `j_star` when it appears as an owner in a lower pivot cover;
8. changes an inclusion-minimal cover, internality, or private-set quantifier;
9. promotes a nonmaximum fixture or malformed record to `STOP`;
10. infers the tuplewise theorem from one failing cover;
11. calls a bounded zero-failure search an unrestricted proof; or
12. claims the branch proves full P95 or LRC.

## Mutually exclusive final dispositions

Return exactly one primary disposition.

### `PIVOT`

Give a complete proof of `MAX-COVERED-NONDIVISIBLE-PIVOT-REDUNDANCY` at every
frozen quantifier, prove the equivalent forms, and state the exact branch-only
consequence. `PIVOT` here means a proved research bridge, not an ordinary pivot
certificate and not unrestricted LRC.

### `STOP`

Give an exact positive injective tuple with `F(a)` nonempty, `j_star` the
unique maximum-speed covered pivot, `N` not dividing `a_j_star`, and an actual
internal inclusion-minimal complete cover at `j_star`. Report every modulus,
candidate row, labelled bad set, `Q`, `F`, `j_star`, cover, private set, and
first strict-boundary check. Supply two independently checkable literal
verifiers. State that this refutes only the branch theorem.

### `SEPARATION`

If neither a proof nor exact counterexample is obtained, prove the mandatory
slice lemma and the strongest additional uniform statement actually reached.
Identify exactly one next lemma involving an explicit `N`-divisible-owner
peeling, projection, replacement, or well-founded descent. Its statement must
specify every map, domain, fiber, label, boundary, and preservation premise;
it must be strictly more informative than the slice lemma and strictly
narrower than assuming the branch theorem. Prove that it would close the
branch, but do not claim the next lemma itself is proved.

A trichotomy, definition, finite scan, or restatement of redundancy is not a
separation theorem.

## Required response schema

Return exactly these sections:

1. **Disposition** - `PIVOT`, `STOP`, or `SEPARATION`.
2. **Evidence boundary** - accepted inputs, exclusions, and response labels.
3. **Exact definitions** - all domains, labels, strictness, `F`, `j_star`,
   covers, minimality, internality, privacy, and deterministic orders used.
4. **Branch equivalences** - redundancy, no-minimal-internal-cover, and
   no-internal-cover forms.
5. **`t*p` slice proof** - every congruence, candidate condition, and the
   forced lower covered `N`-divisible owner.
6. **Fixture ledger** - every mandatory literal fixture and malformed control.
7. **Lane A** - private-slice structure and first unsupported inclusion.
8. **Lane B** - exact projection/peeling map or first failed transport.
9. **Lane C** - descent key, preservation proof, or first failed decrease.
10. **Lane D** - finite method and exact first failure if computation ran.
11. **Sole theorem** - complete proof, exact counterexample, or unchanged open
    status at all frozen quantifiers.
12. **Branch consequence** - what closes and the complete list remaining open.
13. **Proof-obligation ledger** - claim, dependencies, evidence class,
    falsifier, first open edge, and downstream owner.
14. **Declaration-level plan** - only for statements surviving this response.
15. **Final evidence table** - separate accepted input, response proof,
    finite computation, conditional statements, refutations, and open claims.

## One-turn budget and fail-closed rules

Use at most 15 percent for definitions, equivalences, and fixtures; at least 35
percent for divisible-owner peeling/projection; at least 25 percent for descent
or adversarial uniform analysis; at most 25 percent for finite falsification,
artifacts, and the final ledger. A strict majority must address novel uniform
mathematics beyond the slice lemma.

Return `STOP` immediately on a fully verified theorem-domain counterexample or
on a semantic inconsistency in the exact branch statement. Return
`SEPARATION`, not `PIVOT`, at the first unsupported transport, inclusion,
descent, or uniform quantifier. Preserve the `N|p` branch, full Prompt95, the
pivot theorem, and unrestricted LRC as open unless independently solved by a
separate exact theorem.

Do not write Lean before the arithmetic survives independent audit. Do not use
`sorry`, `admit`, new axioms, `unsafe`, `native_decide`, or an opaque external
oracle. Do not promote any result merely because code ran or a nearby theorem
compiled.
