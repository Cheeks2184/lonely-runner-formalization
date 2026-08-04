---
owner: GPT-5.6 Sol High top-level desktop orchestrator
supervising_authority: /root
launch_runtime: original browser-capable desktop Codex session
role: GPT-5.6 Sol / Pro mathematical research agent
task_id: SOL-P104-PRO-PROPER-PRIVATE-EXCHANGE-EXPANSION
base_commit: c5a493195ba48aedaeaa14ed66de96faa135d238
admission: LAUNCH-CANDIDATE
prompt_encoding: UTF-8
prompt_line_endings: LF
prompt_hash_scope: bytes from the line "# Prompt 104:" through EOF
prompt_sha256: 85aac6fa484b2b9e0003caf23968c79daa0ab5d2ebd57ee7df86d5a3ea8361b3
---

# Prompt 104: PROPER-SUBSET-PRIVATE-EXCHANGE-EXPANSION

You are GPT-5.6 Sol running at Pro effort in a genuinely new ChatGPT
conversation. Act as the mathematical research agent. This is the actual
research turn, not a request to review admission or draft another prompt. If
submitted, GPT-5.6 Sol High in the original browser-capable desktop Codex
session has already made the launch decision.

Use one major turn. Prove the exact unrestricted-height structural lemma,
give an exact theorem-domain counterexample, or return `STOP` with a proof of
tautology/equivalence. Do not weaken the target or add a conditional cover
class silently.

## Frozen research contract

| Field | Frozen value |
| --- | --- |
| Exact lemma | `PROPER-SUBSET-PRIVATE-EXCHANGE-EXPANSION` below |
| Scope | every `n>=4`, positive injective integer tuple, and every minimal internal cover at the maximum covered pivot; unrestricted height |
| New structure | whole-private-set one-for-one exchanges to omitted covered pivots |
| Material consequence | together with `N+1<3|C|`, every hypothetical internal cover reduces to a full-core two-fold Hall circuit; every cover with a proper deficient exchange core is ruled out |
| Single unresolved lemma in this cell | the displayed proper-subset expansion theorem |
| Stop condition | exact modular counterexample, hidden extra premise, or collapse to Prompt95/LRC by circularly assuming no cover |
| Maximum budget | one Pro turn; at most one quarter on finite falsification |

Unlike an earlier conditional draft, this theorem has no singleton-private or
external-degree premise. It applies to every inclusion-minimal internal cover.
It does not claim expansion for `S=C`; the verified density inequality forces
that full-set expansion to fail by cardinality. The target is therefore a
proper structural narrowing, not a conditional wrapper and not a proof of
unrestricted LRC by itself.

## Accepted evidence boundary

Unrestricted LRC remains open. Accepted exact-scope inputs are:

- `proved-lean`: canonical `pivotCandidates`, strict `pivotBadResidues`, and
  the pivot-certificate equivalence;
- `proved-lean`: `normalizedBadCount` and
  `card_pivotBadResidues_normalized`, for one bad-set cardinality only;
- `proved-math-qualified`: for `N>=5`, every internal complete cover `C` at a
  maximum covered pivot satisfies `N+1 < 3*|C|`, without minimality;
- `proved-math-qualified`: finite deletion to a labelled inclusion-minimal
  cover and nonempty private sets; and
- `open`: this exchange lemma, the full-core obstruction left after it,
  maximum-covered-pivot redundancy, the pivot existential, and LRC.

Task366 scans are audit support only. A response, launch, finite scan, or
compiled conditional wrapper is not evidence. Use only:

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

## Exact modular objects

Fix `n>=4`, put `N=n+1`, and let `a : Fin n -> Nat` be positive and
injective. Labels are never merged. For pivot `j`, define

```text
p_j = a_j,
M_j = N*p_j,
rho_M(x) = min(x mod M, M-(x mod M)),
R_j = {r in {0,...,M_j-1} : N does not divide r},
B_i^j = {r in R_j : rho_(M_j)(r*a_i) < p_j}  for i!=j,
Q_j = R_j minus union_(i!=j) B_i^j,
F(a) = {j : Q_j is empty}.
```

Badness is strict and equality `rho=p_j` is safe. Retain zero modular
products, both cyclic sides, antipodes, nonunits, multiplication-fiber
collisions, coincident labelled bad sets, and excluded `N`-multiples.

Assume `F(a)` is nonempty and `j` is its unique maximum-speed label. Let

```text
C subset F(a) minus {j}
```

be an inclusion-minimal complete cover of `R_j`. Define for every `i in C`

```text
Priv(C,i) = B_i^j minus union_(k in C, k!=i) B_k^j.
```

Each private set is nonempty, but it may contain many residues and may contain
a reflection fixed point. Define omitted covered labels

```text
O = F(a) minus (insert j C).
```

For `i in C`, `h in O`, define a genuine one-for-one exchange edge

```text
i ~ h  iff  Priv(C,i) subset B_h^j.
```

This is whole-private-set containment, not nonempty intersection. Prove the
adapter: if `i~h`, then `(C minus {i}) union {h}` still covers `R_j`. Every
point of `B_i^j` outside `Priv(C,i)` is covered by another label of `C`, while
`h` covers the entire private set.

For `S subset C`, define

```text
Gamma(S) = {h in O : exists i in S, i ~ h}.
```

## Sole unresolved lemma

Prove or refute exactly:

```text
PROPER-SUBSET-PRIVATE-EXCHANGE-EXPANSION:

For every tuple, maximum covered pivot, and labelled inclusion-minimal
internal complete cover above, for every nonempty proper S subset C,

  2*|S| <= |Gamma(S)|.
```

Do not state this for `S=C`. Do not replace whole-private-set containment by
covering one selected private residue. Minimum degree two is not two-fold Hall;
the conclusion quantifies over every nonempty proper subset.

## Exact implication and remaining frontier

1. Task366 density gives `N+1 < 3*|C|`.
2. Since `F(a) subset Fin n` and `C,O` partition `F(a)\{j}`,
   `|C|+|O|=|F(a)|-1<=N-2`.
3. Hence `|O|<2*|C|`. Since `Gamma(C) subset O`, explicitly
   `|Gamma(C)|<2*|C|`: the full set `C` is necessarily two-fold deficient.
4. The target says no nonempty proper subset is deficient. Thus the exchange
   graph of every hypothetical internal cover is a full-core two-fold Hall
   circuit.
5. Therefore every cover having a proper deficient exchange core is ruled
   out. The exact surviving obstruction is a full-core circuit satisfying all
   proper expansion inequalities.
6. A future `NO-FULL-EXCHANGE-CIRCUIT` theorem would combine with the target
   to eliminate every internal cover at the maximum covered pivot.
7. Maximum-covered-pivot redundancy would then give some nonempty `Q_j`; the
   accepted pivot-certificate and integer/real equivalences would yield LRC.

This materially narrows Prompt95 but does not eliminate the full-core circuit.
A later `NO-FULL-EXCHANGE-CIRCUIT` theorem would finish this route. Do not call
the present lemma an LRC proof.

## Mandatory tautology and distance audit

- Minimality gives `Priv(C,i)` nonempty, not an exchange neighbor.
- Coveredness of an omitted pivot does not automatically make it cover a
  private set in row `j`; moduli differ across pivot rows.
- Arbitrary bipartite graphs can have a deficient proper subset, so the target
  is not Hall bookkeeping.
- Full Prompt95 implies the target vacuously because there are no internal
  covers, but the target does not imply Prompt95: it explicitly leaves a
  consistent full-core deficient graph. If your proof uses nonexistence of
  covers, return `STOP / CIRCULAR`.
- If a valid argument upgrades the conclusion to include `S=C`, acknowledge
  that density makes the upgrade a complete Prompt95 bridge and audit every
  premise against the exact LRC equivalence before claiming it.

## Required attacks

Compare at least two:

1. **Minimal deficient core uncrossing.** Assume a smallest proper violating
   `S`. Use exact private sets and modular bad bands to exchange or uncross it
   into a smaller complete cover.
2. **CRT collision rigidity.** Use exact one-, pair-, and triple-intersection
   formulas to constrain several owners whose whole private sets share too few
   omitted exchange labels. Never infer injectivity of modular multiplication.
3. **Alternating covers.** Study alternating replacement paths. Another cover
   of the same size is not a contradiction unless it produces a proper
   deficient core or violates inclusion minimality exactly.

## Mandatory falsification suite

- Enumerate small positive injective tuples, every maximum-covered pivot, and
  every labelled minimal internal cover; testing one chosen cover is invalid.
- Preserve strict `<p` badness and the safe equality fixture
  `(N,p,d,r)=(5,6,1,6)`.
- Retain reflection fixed points, antipodes, residue collisions, and coincident
  labelled bad sets.
- Test positive common scalings and verify exact preservation or failure of
  private sets and exchange adjacency rather than assuming it.
- Reject zero/repeated speeds, nonmaximum pivots, external covers, noncovers,
  and nonminimal covers as malformed.
- Include an arbitrary-graph negative control with a proper two-fold Hall
  deficiency; label it non-modular, not a theorem-domain counterexample.
- Mutate whole-private containment to nonempty intersection and require the
  exchange-cover adapter to fail.

An exact counterexample must report the tuple, pivot, `C`, all bad and private
sets, `O`, every exchange neighborhood, the violating proper `S`, and every
premise check. Finite success is finite evidence only.

## Output schema and stop rule

Return exactly:

1. `Verdict`: `PROVED`, `REFUTED`, `MIXED`, or `STOP`.
2. Exact quantified target.
3. Tautology/equivalence audit.
4. Claim table with permitted labels.
5. Proof or exact theorem-domain counterexample.
6. Five-step implication audit above.
7. Falsification and mutation report.
8. First declaration-level formal obligation.
9. Exact surviving full-core obstruction.
10. Recommended disposition.

Budget is one major Pro turn. Stop on an exact counterexample, circular use of
Prompt95/LRC, a modulus-changing exchange without proof, or a hidden class
hypothesis. Do not invent a weaker replacement theorem.
