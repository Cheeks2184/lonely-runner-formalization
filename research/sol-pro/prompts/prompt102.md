---
owner: GPT-5.6 Sol High top-level desktop orchestrator
supervising_authority: /root
launch_runtime: original browser-capable desktop Codex session
role: GPT-5.6 Sol / Pro mathematical research agent
task_id: SOL-P102-PRO-UPPER-HALF-PIVOT-CERTIFICATE
base_commit: 5f7fb970ffe1da4b1fd83d0dbbc3a2ac9fb257b2
admission: LAUNCH-CANDIDATE
prompt_encoding: ASCII
prompt_line_endings: LF
prompt_hash_scope: bytes from the line "# Prompt 102:" through EOF
prompt_sha256: 0e1cdc1e563955296d5a52b145ff05cb450b7a0e1ef7b23161d63cbd2ad88acb
---

# Prompt 102: UPPER-HALF-PIVOT-CERTIFICATE

You are GPT-5.6 Sol running at Pro effort in a genuinely new ChatGPT
conversation. Act as the mathematical research agent. This is the actual
research turn, not a request to review admission, prepare a prompt, or propose
another research contract. If this payload has been submitted, GPT-5.6 Sol
High in the original browser-capable desktop Codex session has already made
the launch decision.

Use one major turn. Prove the exact unrestricted theorem below, give one exact
independently reproducible theorem-domain counterexample, or prove one
unrestricted successor lemma that strictly narrows the first unsupported
edge. Do not claim the Lonely Runner Conjecture unless the complete chain is
closed independently.

## Frozen research contract

| Field | Frozen value |
| --- | --- |
| Exact theorem | `UPPER-HALF-PIVOT-CERTIFICATE` below |
| Scope | every `n>=2` and every positive injective integer speed tuple; unrestricted height |
| New structure | the speed-rank median cut; the pivot must be among the largest `ceil(n/2)` speeds |
| Complete consequence | exact positive-integer pivot certificate, then the kernel-checked integer and real Lonely Runner equivalences |
| Single unresolved lemma | at least one upper-half pivot row has a canonical safe residue |
| Stop condition | exact tuple with every upper-half pivot covered; semantic equivalence to an already frozen target; or proof that the proposed attack needs an unproved pivot witness |
| Maximum budget | one major Pro turn; at most one quarter on finite falsification |

The target is stronger than ordinary pivot-certificate existence because it
restricts the rank of the pivot speed. It is weaker than a top-two or maximum-
speed selector once `n>=5`. Prove the displayed rank bound; do not silently
replace it by an endpoint, top-two, maximum-covered, response-selected, or
score-selected pivot.

## Evidence and provenance boundary

Unrestricted LRC remains open. Accepted project inputs at this contract's
base include:

- `proved-lean`: the exact positive-integer pivot-certificate equivalence;
- `proved-lean`: the endpoint-safe equivalence between positive-integer and
  positive-real LRC;
- `proved-lean`: canonical candidate and strict bad-residue definitions,
  including equality safety;
- `proved-lean`: exact single bad-set counts and exact pair/triple CRT fiber
  counts;
- `proved-lean`: common-scaling laws for complete pivot rows;
- `refuted-exact`: Prompt101's positive subcritical-weight theorem;
- `refuted-exact`: Prompt98's maximal internal pair-overlap supply; and
- `open`: the upper-half theorem, the ordinary pivot existential, integer
  LRC, and real LRC.

Prompt preparation, prompt launch, a response, a compiled conditional lemma,
or a bounded search is not a theorem. Do not treat response-authored claims or
attachments as accepted evidence before independent audit.

Use only these evidence labels in the response:

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

`proved-math-response` remains response-authored. `computed finite evidence`
requires a complete deterministic domain, source/output binding, fixtures,
and independent replay. No finite result proves the universal target.

## Exact canonical pivot definitions

Fix `n>=2`, put `N=n+1`, and let

```text
a : Fin n -> Nat
```

be positive and injective. Labels are indices and are never merged. For pivot
label `j`, put

```text
p_j = a_j,
M_j = N*p_j,

rho_M(x) = min(x mod M, M-(x mod M)),

R_j = {r in {0,...,M_j-1} : N does not divide r},

B_i^j = {r in R_j : rho_(M_j)(r*a_i) < p_j}  for i != j,

Q_j = R_j minus union_(i != j) B_i^j.
```

Representatives are canonical. Badness is strict. Equality
`rho_(M_j)(r*a_i)=p_j` is safe. Retain zero products, both cyclic sides,
antipodes, nonunits, nontrivial multiplication fibers, coincident bad sets
with distinct labels, and excluded `N`-multiples.

For each `r in R_j`, writing `r=N*q+s` with `1<=s<=N-1` gives

```text
rho_(N*p_j)(r*p_j) = p_j*min(s,N-s) >= p_j.
```

Thus every `r in Q_j` is exactly a canonical pivot certificate.

## Exact speed-rank predicate

For a label `j`, define its number of strictly faster labels by

```text
faster_a(j) = #{i : Fin n | a_j < a_i}.
```

Injectivity makes every comparison strict and removes ties. Define

```text
UpperHalf_a(j)  iff  faster_a(j) <= floor((n-1)/2).
```

Equivalently, if labels are sorted by increasing speed, an upper-half label
has sorted index at least `floor(n/2)`. The set contains exactly `ceil(n/2)`
labels. The theorem is invariant under a permutation of labels and under a
positive common scaling, but those invariances do not move a lower-half speed
into the upper half.

## Sole unrestricted theorem

Prove or refute exactly:

```text
UPPER-HALF-PIVOT-CERTIFICATE:

For every n>=2 and every positive injective a : Fin n -> Nat,
there exist j : Fin n and r : Nat such that

  UpperHalf_a(j),
  r in R_j,
  and for every i != j,
    rho_(N*a_j)(r*a_i) >= a_j.
```

Equivalent residue-set form:

```text
There exists an upper-half label j with Q_j nonempty.
```

The equivalence between these two displays is definitional bookkeeping and is
not the missing theorem. The missing content is the upper-half existence.

## Exact implication to unrestricted LRC

From the theorem:

1. Forget the rank condition and retain `j,r` as a positive-integer pivot
   certificate.
2. Invoke the accepted kernel-checked pivot-certificate equivalence.
3. Handle `n=1` separately with its unique speed and time `1/(2*a_0)`.
4. Apply the accepted endpoint-safe real/integer reduction.

Every step is conditional until the sole theorem is proved. A result only for
top-two, maximum speed, bounded height, primitive tuples without a proved
normalization law, or finitely many dimensions does not close this chain.

## Non-equivalence and strength audit

Before using any proposed reduction, prove all relevant directions.

- Ordinary pivot existence does not specify the rank of its pivot.
- A label permutation preserves numerical rank after sorting and cannot make
  an arbitrary certificate upper-half.
- Common scaling preserves all strict speed comparisons and cannot change the
  rank class.
- Choosing a boundary point of the continuous safe set supplies a pivot
  numerator congruent to `+1` or `-1 mod N`, but does not choose its speed
  rank.
- The target is not Prompt95: it has no covered-set, maximum-covered-pivot,
  internal-cover, or redundancy premise.
- The target is not Prompt100: it restricts pivot rank, not the number of
  owners in one cover.

If you show that the universal upper-half theorem is equivalent to the
ordinary pivot theorem by a valid elementary transformation, return `STOP`
with that proof. Do not market an equivalent restatement as progress.

## Required research attacks

Spend the strict majority of the turn on uniform mathematics. Investigate at
least two materially different attacks before selecting one.

### Attack A: median-cut cross-pivot compensation

Assume every upper-half row is covered. Split labels into the lower and upper
speed halves. Derive an exact cross-pivot map, injection, or uncrossing showing
that lower-owner coverage cannot simultaneously complete every upper row.
Every target residue must remain in its declared candidate set, and every
strict inequality must be checked after changing moduli.

### Attack B: rank-aware CRT or incidence obstruction

Use exact single, pair, or triple intersection formulas to seek an inequality
or structural incompatibility across the median cut. A scalar matrix weight
of Prompt101's form is forbidden. If using higher intersections, do not stop
at full inclusion-exclusion, which simply reproduces `|Q_j|`.

### Attack C: minimal upper-covered subsystem

Choose a smallest tuple or smallest upper covered subsystem only under an
explicit well-founded order. Prove every deletion, replacement, and witness
lift. Do not import frozen height compression or first-blocker descent.

## Forbidden duplicate methods

Do not reopen or rename:

- Prompt64's exact top-two large-ratio implication, affine shifts, or frozen
  owner-transversal route;
- Prompt66 whole-block packing, radial descent, or signed phase cells;
- Prompt67/68 forcing-prime supply or product induction;
- Prompt98 MBCP or the refuted maximal internal pair-overlap supply;
- Prompt100 two-lower-owner noncover as the universal target;
- Prompt101 positive subcritical weights or a nearby Perron vector;
- coefficient-two Gamma matching;
- height compression, signed-divisor replacement, deletion first-blocker
  flow, or reverse-grid descent;
- a tautological circuit escape, exact union complement, or ordinary pivot
  certificate renamed by a score.

A local lemma from an earlier route may be cited only at its accepted scope.

## Mandatory falsification fixtures

Recompute these from the literal definitions before trusting a proof or
verifier:

1. `(1,2,3)`, `N=4`: equality is safe; pivots `1,2,3` have canonical safe
   residues, including `r=3,9` at pivot `3`.
2. `(1,2,8)`, `N=4`: the upper endpoint pivot `8` has certificates beginning
   `r=9,10,11`; an unconditional paired-top grid may be empty elsewhere.
3. `(1,4,5,6,7,11)`, `N=7`: the maximum-speed pivot is not certified, while
   pivots `6` and `7` have certificates beginning `13` and `15`. This forbids
   silently strengthening upper-half to maximum speed.
4. `(1,5,25,125)`, `N=5`: the covered set is `{1,5,25}` and pivot `125` has
   the exact witness `r=156`.
5. `(1,3,4,5,18)`, `N=6`: certified pivots include speeds `4,5,18`.
6. `(1,3,13)`: coincident labelled bad sets remain distinct owners.
7. A common positive scale and a nontrivial label permutation of at least one
   successful fixture must preserve the exact rank and row laws.
8. Repeated speeds, zero speeds, a residue outside `[0,N*p)`, and an
   `N`-multiple residue are malformed or premise-violating controls.
9. Deliberately replace one safe `>=p` comparison by strict `>p`; the equality
   fixture must then fail.

If computation is supplied, use a canonical sorted tuple order, state raw and
primitive counts separately, compare literal and independently optimized row
implementations, and report the first upper-half failure. A bounded
`NO-COUNTEREXAMPLE` result remains finite evidence only.

## Stop and disposition rules

Return `STOP` immediately on any of:

- an exact positive injective tuple for which every upper-half pivot row is
  covered;
- a fatal quantifier, boundary, or rank defect;
- an exact proof that the theorem is only the ordinary pivot theorem under a
  reversible renaming;
- or a reduction whose first missing edge is the unchanged Prompt64, 98, 100,
  or 101 target.

Return `PIVOT` only for a proved unrestricted lemma that strictly narrows the
upper-half existence edge and includes its complete implication chain. A
bounded-rank statement, finite search, conditional count, or restated union
deficit is not enough.

Return `PROVE` only with a complete proof at every quantifier. Return
`COUNTEREXAMPLE` only with a literal exact certificate including all rows,
candidate guards, speed rank, and strict distances.

## Required response schema

Return one self-contained response with these sections:

1. `Disposition` -- `PROVE`, `COUNTEREXAMPLE`, `PIVOT`, or `STOP`.
2. `Frozen definitions` -- exact domains, rank predicate, and boundary.
3. `Input claim table` -- every imported fact and its evidence label.
4. `Non-equivalence audit` -- rank, scaling, permutation, and prior-route
   separation.
5. `Attack comparison` -- at least two uniform attacks and their first fatal
   or surviving edges.
6. `Main mathematics` -- complete proof, exact counterexample, or proved
   narrower lemma.
7. `Implication chain` -- every arrow to the exact target and to LRC.
8. `Falsification` -- all mandatory fixtures and any bounded domain.
9. `Proof-obligation ledger` -- one row per unresolved statement.
10. `Lean plan` -- exact declarations only after mathematics survives; no
    `sorry`, `admit`, `unsafe`, `native_decide`, or new axioms.
11. `Artifacts` -- source, output, hashes, deterministic order, and commands,
    or `not-run`.
12. `Evidence table` -- exact scope of every response claim.

Do not ask a follow-up question. Do not propose another prompt. Do not claim
unrestricted LRC from finite evidence, a conditional wrapper, or launch
provenance.
