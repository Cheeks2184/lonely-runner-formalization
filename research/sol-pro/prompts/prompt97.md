---
owner: GPT-5.6 Sol High top-level desktop orchestrator
supervising_authority: /root
launch_runtime: original browser-capable desktop Codex session
role: stopped research-contract provenance record
task_id: SOL-P97-PRO-CANONICAL-PRIVATE-CYCLE-SYNCHRONIZATION-307
base_commit: bf11c644c80cc1f4411a1d2bb311c26e7040a8eb
admission: STOP / NOT LAUNCHABLE
stop_audit_task: OPS-P97-CONTRACT-STOP-AUDIT-313
candidate_commit: efb8c60aac77c0bcb79e3bd0f0b7d78382c74212
candidate_prompt_sha256: 8727b28607829b9ced7f60b2d078a85bec2cd1a369491f33ee081bfb9d6c1f8b
prompt_encoding: UTF-8
prompt_line_endings: LF
prompt_hash_scope: bytes from the line "# Prompt 97:" through EOF
prompt_sha256: 91402ed82e69866c9078189de27dde730c016c548a62361228f5ea3b1645ced6
---

# Prompt 97: CANONICAL-PRIVATE-CYCLE-SYNCHRONIZATION

> **STOP / NOT LAUNCHABLE.** This file is a historical failed-approach record,
> not an executable Sol Pro prompt. Do not submit it to ChatGPT or treat any
> imperative below as an active instruction. The exact rejected theorem,
> definitions, tests, and requested output are retained for reproducibility.

The candidate would have assigned one major research turn to prove the exact
unrestricted synchronization theorem, give an exact counterexample, or derive
the frozen separation alternative. Independent review stopped the contract
before launch because its proposed bridge is tuplewise equivalent to the
Prompt94 unit-certificate target once its own terminal lemma is used. See
`../audits/prompt97-contract-stop-audit-313.md`.

## Research contract

| Field | Frozen value |
| --- | --- |
| Exact theorem | `CANONICAL-PRIVATE-CYCLE-SYNCHRONIZATION` below |
| Scope | every `n>=2` and every positive injective integer tuple; unrestricted height |
| New structure | canonical minimum labelled unit covers, their private pairs, reduced edge congruences, and synchronized directed cycles |
| Complete chain | synchronized cycle -> impossible product divisibility -> one uncovered unit row -> canonical pivot certificate -> integer LRC -> real LRC |
| Single unresolved edge | a hypothetical simultaneous full unit cover supplies one synchronized simple cycle |
| Falsification | exact hand rows, partial-cycle defect controls, repeated-speed rejection, scaling controls, and two literal finite implementations if used |
| Stop condition | exact positive injective tuple with every unit row covered but no synchronized cycle, or proof that the target is merely equivalent to the ordinary pivot existential |
| Maximum budget | one major Pro turn; at most one third on computation |

The theorem is stronger than ordinary pivot existence because it produces an
uncovered numerator coprime to the whole pivot modulus and rules out a full
unit cover through one prescribed cycle mechanism. Its proof obligation is
materially narrower than unrestricted LRC: prove only the existence of an
explicit arithmetically synchronized cycle in the canonical cover graph under
the contrary full-unit-cover hypothesis.

This is not a request to restate that some pivot is uncovered. The cycle data,
reduced moduli, pairwise-coprimality condition, and every cross congruence are
fixed before the turn. A proof which obtains the cycle by first invoking a
pivot certificate or LRC is circular and must be rejected.

## Evidence boundary and excluded routes

Unrestricted LRC remains open. Use only these accepted inputs:

- `proved-lean`: the exact positive-integer pivot-certificate equivalence;
- `proved-lean`: the exact positive-integer/positive-real equivalence, with
  positivity, injectivity, all dimension quantifiers, circle distance, and the
  closed endpoint preserved; and
- independently reproved elementary finite-set, gcd, congruence, and directed
  cycle facts explicitly established in this response.

Prompt94 response labels and artifacts are not premises. In particular, do
not cite its unit-deficit identity, scaling statement, finite searches,
implementation agreement, or evidence labels without proving the exact fact
again from the definitions below. Prompt96 is reserved adversarial synthesis
and supplies no premise.

Do not reuse or rename:

- Prompt94 total `OmegaUnit` positivity or Mobius layers;
- Prompt95's maximum-covered-pivot internal redundancy;
- Prompt66 packing, radial descent, tokens, or signed phase cells;
- Prompt62 owner-aware multishifts;
- obstruction-prime supply or prime forcing;
- coefficient-two Gamma matching;
- height compression or minimal-counterexample descent;
- first-blocker time evolution; or
- the pivot-certificate equivalence as the new lemma.

The operation here is static and cross-pivot: select canonical minimum unit
covers, extract private congruence edges, follow a directed cycle of pivot
labels, and multiply synchronized reduced congruences.

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

No response-authored claim is `proved-math-qualified`, `proved-lean`, or
`computed finite evidence` until independent repository review accepts it.

## Exact strict modular rows

Fix `n>=2`, put `N=n+1`, and let

```text
a : Fin n -> Nat
```

be positive and injective. Labels are never deduplicated. For pivot `j`, put

```text
p_j = a_j,
M_j = N*p_j,
rho_M(x) = min(x mod M, M-(x mod M)),

U_j = {r in {0,...,M_j-1} : gcd(r,M_j)=1},

B_i^j = {r in U_j : rho_(M_j)(r*a_i) < p_j}  for i!=j,

QUnit_j = U_j \ union_(i!=j) B_i^j.
```

All representatives are canonical. Badness is strict; equality `rho=p_j` is
safe. Retain both cyclic sides, zero modular products, antipodes, noninjective
multiplication fibers, repeated products, and coincident labelled bad sets.
Unit candidates exclude nonunits but owner labels remain distinct.

Because `N|M_j` and `N>=3`, every unit lies in the ordinary candidate set
`R_j={r:N does not divide r}`. Prove directly that for `r in U_j`, writing
`r=N*q+s`, `1<=s<=N-1`, gives

```text
rho_(M_j)(r*a_j) = a_j*min(s,N-s) >= a_j.
```

Thus `QUnit_j` nonempty gives an ordinary canonical pivot certificate with
the exact closed boundary.

## Canonical minimum labelled covers

Say row `j` is `unit-full` when `QUnit_j` is empty. Only for a unit-full row,
let a labelled subset

```text
C subset Fin n \ {j}
```

be a unit cover when

```text
U_j = union_(i in C) B_i^j.
```

Order subsets first by cardinality and then lexicographically by their
increasing owner-label lists. Define `C_j` to be the unique least unit cover.
This is a canonical minimum-cardinality cover, not merely an arbitrary
inclusion-minimal cover. Prove existence and uniqueness from finiteness.

For `i in C_j`, define its exclusive set relative to the selected cover:

```text
E_(j,i) = B_i^j \ union_(k in C_j, k!=i) B_k^j.
```

Minimum cardinality implies `E_(j,i)` is nonempty. Privacy is relative to
`C_j`; an owner outside `C_j` may also cover the residue. Reflection preserves
every `B_i^j` and `U_j`. Since a unit modulo `M_j>=3` is never fixed by
`r |-> M_j-r`, `E_(j,i)` is a disjoint union of reflection pairs.

Define the canonical private representative

```text
r_(j,i) = least r in E_(j,i) with 0 < 2*r < M_j.
```

Prove this set is nonempty and that `M_j-r_(j,i)` is its paired private
residue. Do not strengthen relative privacy to uniqueness among all owners.

## Reduced private-edge congruence

For every selected edge `j -> i` with `i in C_j`, badness and
`p_j<=M_j/3` give a unique signed integer `e_(j,i)` such that

```text
-p_j < e_(j,i) < p_j,
r_(j,i)*a_i = q_(j,i)*M_j + e_(j,i)
```

for a unique integer `q_(j,i)`. Use the centered representative forced by the
strict bad arc; do not choose its sign later.

Put

```text
g_(j,i) = gcd(a_j,a_i),
u_(j,i) = a_j/g_(j,i),
v_(j,i) = a_i/g_(j,i),
z_(j,i) = e_(j,i)/g_(j,i).
```

Prove the elementary edge facts:

```text
g_(j,i) divides e_(j,i),
gcd(u_(j,i),v_(j,i))=1,
r_(j,i)*v_(j,i) = N*q_(j,i)*u_(j,i) + z_(j,i).
```

If `u_(j,i)>1`, prove additionally

```text
0 < abs(z_(j,i)) < u_(j,i),
gcd(abs(z_(j,i)),u_(j,i))=1,
z_(j,i) == r_(j,i)*v_(j,i)  (mod u_(j,i)).
```

Treat `u=1` and `e=z=0` explicitly. Do not divide by a possibly zero signed
remainder.

## Directed cycles and synchronization

Under the contrary hypothesis that every row is unit-full, every `C_j` is
nonempty. Form the labelled directed graph with an edge `j -> i` exactly when
`i in C_j`. It has no loops and has at least one simple directed cycle

```text
j_0 -> j_1 -> ... -> j_(m-1) -> j_0,
m>=2,
```

with distinct pivot labels. On its edge `j_t -> j_(t+1)`, abbreviate

```text
r_t = r_(j_t,j_(t+1)),
u_t = u_(j_t,j_(t+1)),
v_t = v_(j_t,j_(t+1)),
z_t = z_(j_t,j_(t+1)).
```

Call the cycle `synchronized` exactly when:

```text
(S1)  1 < u_t for every t;

(S2)  gcd(u_s,u_t)=1 for all distinct s,t;

(S3)  z_s == r_s*v_s (mod u_t) for every ordered pair s,t.
```

The diagonal cases of `(S3)` follow from the private-edge congruence; the
cross cases are real additional arithmetic. Do not omit them. Do not replace
pairwise coprimality by distinctness, squarefree support, or an assertion
about the product alone.

## Elementary synchronized-cycle contradiction

Prove this part without the sole unresolved theorem. For a synchronized cycle
put

```text
U = product_t u_t,
V = product_t v_t,
R = product_t r_t,
Z = product_t z_t.
```

Cycling the speed labels gives the exact telescoping identity

```text
V = product_t (a_(j_(t+1))/g_t)
  = product_t (a_(j_t)/g_t)
  = U.
```

For each `t`, `(S3)` implies

```text
Z == R*V == 0 (mod u_t).
```

By `(S2)`, `U` divides `Z`. By `(S1)` and the edge bounds,

```text
0 < abs(Z) < U,
```

which is impossible. Check signs and the nonzero product explicitly.

This contradiction is not LRC, the pivot equivalence, Mobius inversion, a
packing inequality, or a finite computation. It is an elementary terminal
lemma for the new cycle-supply problem.

## Sole unrestricted theorem

Prove or refute exactly:

```text
CANONICAL-PRIVATE-CYCLE-SYNCHRONIZATION:

For every n>=2 and every positive injective a : Fin n -> Nat,
if every pivot row is unit-full, then the directed graph selected by the
canonical minimum labelled unit covers C_j contains a synchronized simple
directed cycle.
```

Do not weaken `every pivot row`, use a response-selected noncanonical cover,
choose private residues after seeing the desired congruences, allow a closed
bad endpoint, or replace `(S3)` by only its automatic diagonal cases.

An exact counterexample to this theorem must be a positive injective tuple
for which every unit row is covered and for which every simple directed cycle
of the canonical graph fails at least one of `(S1)-(S3)`. Such a tuple refutes
this stronger bridge. It does not by itself refute ordinary LRC because a
nonunit pivot certificate may still exist.

## Complete implication chain

Assuming the sole theorem, derive every arrow:

```text
hypothetical failure of every unit pivot certificate
 -> every QUnit_j is empty
 -> every canonical C_j exists and is nonempty
 -> CANONICAL-PRIVATE-CYCLE-SYNCHRONIZATION
 -> synchronized simple cycle
 -> 0 < abs(Z) < U and U divides Z
 -> contradiction
 -> some QUnit_j is nonempty
 -> some ordinary canonical pivot certificate
 -> PositiveIntegerPivotCertificateConjecture
 -> PositiveIntegerConjecture
 -> unrestricted positive-real LRC.
```

Handle `n=1` separately using `N=2`, the unique pivot, and `r=1`. State the
closed `>=1/(n+1)` endpoint, positivity, injectivity, and all dimension
quantifiers. The last arrow uses the accepted exact equivalence, not density.

## Mandatory hand falsifiers

Recompute every item literally. They are specification controls, not accepted
evidence.

1. For `a=(1,2,3)`, `N=4`, the unit deficits by speed are `(2,0,0)`.
   Therefore rows `p=2` and `p=3` are unit-full but the tuple does not satisfy
   the all-row premise. The canonical minimum covers are:

   ```text
   p=2: owners with speeds 1 and 3;
   p=3: the singleton owner with speed 2.
   ```

   These partial rows contain the directed 2-cycle `p=2 -> p=3 -> p=2`.
   Its reduced data, in that orientation, are

   ```text
   (r,u,v,z) = (3,2,3,1), (1,3,2,2).
   ```

   The denominators `2,3` are coprime, but cross synchronization fails because
   `1` is not congruent to `3*3=9` modulo `3`. This proves that a bare cycle,
   private pairs, and pairwise-coprime reduced denominators do not imply `(S3)`.

2. For `a=(1,3,13)`, the unit deficits are `(2,2,4)`. No row is unit-full.
   At pivot `p=3`, owners `1` and `13` have coincident labelled strict bad
   sets; retain both labels. Do not manufacture a cover by deduplication.

3. For `a=(4,5,9)`, the unit deficits are `(2,2,2)`. Retain nonunit
   multiplication fibers in arithmetic checks even though `U_j` contains
   only unit candidates. No canonical cover exists at any row.

4. The Prompt92-derived `E=3` tuple is

   ```text
   (1,1,13,15,27,28).
   ```

   It has a repeated speed and is outside the theorem domain. Reject it before
   constructing canonical covers. It is a malformed/collision control only,
   not a counterexample or evidence for this theorem.

5. For the common scale `2*(1,2,3)=(2,4,6)`, the unit deficits are `(4,0,0)`.
   The two partial canonical covers have the same owner labels as in item 1,
   and their displayed normalized edge data agree in this case. This is one
   control, not a license to assume canonical private representatives or all
   cross congruences are invariant under arbitrary scaling. Prove any scaling
   statement before using it.

6. Equality is safe: at `(1,2,3)`, pivot `p=3`, residue `r=3` has
   `rho_12(3*1)=3`. It is nonunit and must not enter `U_j`; changing `<` to
   `<=` or silently reverting to ordinary candidates must fail the control.

7. Include a synthetic finite set-system fixture with a minimum cover whose
   private point relative to the selected cover is also covered by an omitted
   owner. This fixture need not arise from speeds. It must reject the false
   inference `relative private => globally unique blocker`.

8. Include a synthetic directed cycle satisfying the diagonal edge
   congruences but failing one cross congruence. Also include a malformed
   synthetic record satisfying `(S1)-(S3)` but deliberately violating the
   speed-cycle telescoping identity `V=U`; the verifier must reject it as not
   arising from a directed speed cycle. A deliberately altered verifier which
   skips the `V=U` check must make the expected comparison fail.

## Finite preflight and optional search

Before any large computation, use a tiny literal preflight containing:

- the success/non-full rows and partial cycle of `(1,2,3)`;
- the no-full-row cases `(1,3,13)` and `(4,5,9)`;
- the scaled control `(2,4,6)`;
- the repeated-speed rejection above;
- the strict equality/nonunit boundary case;
- coincident labelled bad sets;
- the relative-private synthetic fixture;
- a cross-congruence failure; and
- one deliberately altered expected field which must make comparison fail.

If computation is useful, write two independent literal implementations for
strictly increasing primitive tuples, ordered by `n` then lexicographically.
One implementation may enumerate unit rows and canonical minimum covers. The
other must independently enumerate all candidate residues first and then
filter units; it must independently rank subsets and cycles. Shared core cover
or synchronization code is forbidden.

Use only a declared modest range that completes within the turn. Report the
exact range, raw and primitive counts, completion markers, language/version,
deterministic ordering, source hashes, output hashes, first disagreement, and
first target failure. A partial prefix is `not-run`, not finite evidence. Zero
failures are finite evidence only after independent immutable replay and are
never a proof.

The primary finite purpose is to find an exact all-unit-covered tuple which
falsifies the cycle supply. Do not occupy the turn by merely reproducing more
positive unit-deficit ranges.

## Required proof lanes

### Lane A - canonical-cover exchange structure

Exploit minimum cardinality and lexicographic canonicity without treating bad
sets as an arbitrary matroid. Determine whether exclusive reflection pairs
force restrictions on which owner labels can appear around a directed cycle.
Track omitted owners explicitly. The first unsupported exchange inclusion
must be named; do not infer global privacy.

### Lane B - reduced congruence synchronization

Starting from

```text
r_t*v_t = N*q_t*u_t + z_t,
```

seek a genuine reason that one canonical cycle has pairwise-coprime `u_t` and
all cross congruences. Investigate cycle shortening, gcd uncrossing, exchanging
owners between minimum covers, and prime-by-prime obstruction rerouting. Do
not import a prime-supply theorem. State the first prime or cross residue that
cannot be controlled.

### Lane C - shortest or minimum-obstruction cycle

Choose a simple directed cycle by an exact tuple-independent rule, such as
minimum length followed by lexicographic labels, and test whether a failed
cross congruence permits a shorter cycle or a lexicographically smaller
canonical cover. Any replacement must still cover the complete unit row and
must preserve labels and strict endpoints. No silent basis-exchange axiom is
allowed.

### Lane D - adversarial separation

Try to destroy the target. Search first for an all-unit-covered tuple; if one
is found, enumerate every canonical simple cycle and return the first exact
failure. Separately construct abstract symmetric set systems and modular edge
tables showing which steps use speed arithmetic. A non-speed-derived fixture
may refute a combinatorial sublemma but cannot be `STOP` for the exact theorem.

## Mutually exclusive final dispositions

Return exactly one primary disposition.

### `PIVOT`

Give a complete proof of `CANONICAL-PRIVATE-CYCLE-SYNCHRONIZATION`, the
terminal product contradiction, and the full implication chain. Decompose it
into declaration-level lemmas and identify every imported fact.

### `STOP`

Give an exact positive injective tuple satisfying the all-unit-full premise
but having no synchronized simple cycle in its canonical graph. Report every
`M_j`, unit set, labelled bad set, canonical cover, exclusive set, private
representative, edge datum, simple cycle, and the first failed condition.
Provide two independently checkable literal verifiers. State explicitly that
this refutes only the stronger cycle bridge, not ordinary LRC.

### `SEPARATION`

If neither proof nor exact theorem-domain counterexample is obtained, prove
the strongest exact cycle-separation statement reached. At minimum classify
each failed canonical cycle by the first one of:

```text
u_t=1;
noncoprime pair u_s,u_t;
explicit cross defect z_s-r_s*v_s modulo u_t.
```

Then isolate one named uniform lemma, strictly narrower than the target, which
would eliminate the surviving separation certificates. Prove that the new
lemma plus the elementary terminal argument implies the target. Do not call a
definition, exhaustive trichotomy, finite zero-failure result, or the ordinary
pivot equivalence a separation theorem.

## Required response

Return:

1. the primary disposition `PIVOT`, `STOP`, or `SEPARATION`;
2. exact theorem statements with all quantifiers;
3. proofs of every elementary support identity used;
4. the canonical-cover and private-pair construction;
5. the synchronized-cycle terminal proof;
6. the complete implication chain or the exact point where it remains open;
7. all hand-control tables;
8. finite method, manifests, hashes, and completion state if computation ran;
9. a proof-obligation ledger with dependencies and first open edges;
10. a declaration-level Lean plan for surviving audited statements; and
11. a final evidence table separating accepted inputs, response proofs,
    finite computations, conditional claims, refutations, and open claims.

Do not write Lean before the arithmetic survives independent audit. Do not use
`sorry`, `admit`, new axioms, `unsafe`, `native_decide`, or an opaque external
oracle. Do not promote any result merely because code ran or a nearby theorem
compiled.
