---
owner: GPT-5.6 Sol High top-level desktop orchestrator
supervising_authority: /root
launch_runtime: original browser-capable desktop Codex session
role: GPT-5.6 Sol / Pro mathematical research agent
task_id: SOL-P101-PRO-COVERED-PIVOT-SUBCRITICAL-WEIGHTS-323
base_commit: 3f857f4c83d2b05aa80eef790e853c2aa53e09a0
admission: REVIEW-REQUIRED
prompt_encoding: ASCII
prompt_line_endings: LF
---

# Prompt 101: COVERED-PIVOT-SUBCRITICAL-WEIGHTS

You are GPT-5.6 Sol running at Pro effort in a genuinely new ChatGPT
conversation. Act as the mathematical research agent. This is the actual
research turn, not a request to review admission, prepare a contract, or
describe a plan. Attack the exact unrestricted cross-pivot theorem below.

Use one major turn. Prove the theorem at every frozen quantifier, give one
exact theorem-domain counterexample, or isolate one strictly narrower
arithmetic lemma which implies it. Spend at least two thirds of the turn on
uniform mathematics. Do not claim the Lonely Runner Conjecture.

## Research contract

| Field | Frozen value |
| --- | --- |
| Exact theorem | `COVERED-PIVOT-SUBCRITICAL-WEIGHTS` below |
| Scope | all dimensions `n>=2` and all positive injective integer tuples; no height, primality, or genericity bound |
| New global structure | the normalized labelled bad-incidence matrix induced by all currently covered pivots |
| Complete implication | subcritical weights -> no simultaneous full pivot cover -> exact pivot certificate -> positive-integer LRC -> accepted real reduction |
| Single unresolved lemma | existence of the strict positive rational superharmonic weights |
| Stop condition | an exact theorem-domain counterexample, a semantic defect, or proof that the target merely unfolds to the pivot certificate |
| Maximum budget | one major Pro turn; at most one third finite falsification |

This is a nonlinear cross-pivot spectral/averaging target. It is not a
weighted sum of already computed pivot margins: the index set is the
tuple-dependent covered set and the positive weights must solve all of its
strict row inequalities simultaneously.

## Evidence discipline

Use only these labels:

```text
proved-math
computed finite evidence
conditional
conjectural
refuted
open
rejected
```

Nothing in this prompt is `proved-lean`. A response-authored computation is
not an independent checker. A finite scan is not a proof. Do not change a
strict inequality, quantifier, matrix entry, or owner set after failure.

Accepted Lean results may be cited only in the final implication chain:
positive-integer LRC is equivalent both to the exact pivot-certificate
statement and to unrestricted positive-real LRC. They are not premises for
the new arithmetic theorem.

## Exact modular data

Fix `n>=2`, put `N=n+1`, and let

```text
a : Fin n -> Nat
```

be positive and injective. Labels remain distinct even when modular images or
bad subsets coincide. For pivot `j`, put

```text
p_j = a_j,
M_j = N*p_j,
u_M(x) = the unique representative of x modulo M in {0,...,M-1},
rho_M(x) = min(u_M(x), M-u_M(x)),

R_j = {r in {0,...,M_j-1} : N does not divide r},
B_i^j = {r in R_j : rho_(M_j)(r*a_i) < p_j}  for i!=j,
Q_j = R_j minus union_(i!=j) B_i^j,
F(a) = {j : Q_j is empty}.
```

Badness is strict; equality `rho=p_j` is safe. Keep both cyclic sides, zero
products, antipodes, nonunits, gcd-degenerate multiplication fibers,
coincident labelled bad sets, and all excluded `N`-multiples. Exactly `p_j`
representatives modulo `M_j` are divisible by `N`, including zero, so

```text
|R_j| = n*p_j > 0.
```

For `r in R_j`, prove pivot safety directly from

```text
rho_(N*p_j)(r*p_j)
  = p_j * min(r mod N, N-(r mod N))
  >= p_j.
```

Thus `Q_j` is literally the canonical pivot-certificate set at row `j`.

## The induced normalized bad-incidence matrix

For `j,i in F(a)`, define the nonnegative rational matrix

```text
A_F(j,i) = 0                         if i=j,
A_F(j,i) = |B_i^j| / |R_j|          if i!=j.
```

The numerator counts the labelled owner's strict bad set at pivot `j`; it is
not the size of a union and is not deduplicated when two labelled bad sets
coincide. The denominator is positive. Rows and columns use increasing speed
order only for deterministic presentation; the theorem is invariant under a
permutation of labels.

When `F(a)` is empty, the theorem below is vacuous. When it is nonempty, a
weight vector is a function

```text
x : F(a) -> Rat
```

with `x_j>0` for every covered pivot.

## Sole unrestricted theorem

Prove or refute exactly:

```text
COVERED-PIVOT-SUBCRITICAL-WEIGHTS:

For every n>=2 and every positive injective a : Fin n -> Nat,
if F(a) is nonempty, there exists x : F(a) -> Rat such that

  x_j > 0

and, for every j in F(a),

  sum_{i in F(a), i!=j} (|B_i^j| / |R_j|) * x_i < x_j.
```

Equivalently, the nonnegative rational matrix `A_F` has spectral radius
strictly below one. The rational strict-superharmonic formulation above is
the frozen theorem; a spectral proof must derive a rational vector, for
example by density after obtaining strict real inequalities or by an exact
`M`-matrix argument. Do not return only a numerical eigenvalue.

The target is unrestricted in height and dimension. It is stronger than the
existing pivot equivalence because it constrains every tuple having any
covered pivot, including tuples which already have a certificate at another
pivot. It is materially narrower than unrestricted LRC because it asks for a
specific finite system of rational linear inequalities built only from exact
pairwise bad-set cardinalities.

There is exactly one unresolved lemma: the displayed weight existence. Basic
finite-set identities, matrix equivalences, and the implication below must be
proved rather than listed as additional conjectures.

## Complete implication to unrestricted LRC

Assume the sole theorem and suppose, for contradiction, that every pivot is
covered. Then `F(a)=Fin n`. Obtain a positive rational vector `x`, and choose
`j` with minimal `x_j`. Since the labelled bad sets cover `R_j`, the union
bound gives

```text
1 <= sum_{i!=j} |B_i^j| / |R_j|.
```

Minimality gives `x_i>=x_j` for every `i`, hence

```text
sum_{i!=j} (|B_i^j|/|R_j|)*x_i
  >= x_j * sum_{i!=j} |B_i^j|/|R_j|
  >= x_j,
```

contradicting the strict row inequality. Therefore some `Q_j` is nonempty.
Select `r in Q_j`, use pivot safety and complements of all strict nonpivot
bad sets, and obtain the exact positive-integer pivot certificate. Handle
`n=1` separately with `N=2` and `r=1`, then use the accepted Lean
equivalences to reach unrestricted real LRC.

Prove every arrow. The conditional implication does not prove the sole
theorem.

## Anti-tautology and route separation

Before attacking the theorem, audit these exclusions.

1. Do not replace the target by `F(a)!=Fin n`, `some Q_j is nonempty`,
   positivity of an uncovered-count sum, or the pivot equivalence.
2. Prompt76's canonical private-demand Hall inequality is refuted at
   `(1,4,5,6,7,11)` by demand `100` and capacity `98`. The present matrix has
   no canonical covers, private points, token destinations, or external-good
   capacity. Do not revive that injection.
3. Prompt78's sparse owner escape is refuted by `(6,7,12,24,144)`. The
   present theorem neither selects a sparse cover nor requires an owner to
   escape `F(a)`.
4. Prompts 90, 95, 98, and 99 concern redundancy of complete covers at the
   maximum covered pivot and cross-modulus owner exchange. The present target
   uses all covered rows, no maximum pivot, no minimal cover, and no exchange
   of residue sets between moduli.
5. Prompt100's two-lower-owner theorem is a single-row local statement and
   yields only the `|F(a)|<=3` part of the maximum-pivot route. It is not a
   premise and is not the global theorem requested here.
6. Prompt82 refutes one fixed separable scalar score at
   `(1,4,5,6,7,11,32)`. Prompt86's local multiplicity selector is open and
   unverified. Do not sum a fixed per-row score or assume either route. The
   tuple-dependent simultaneous solution of `(I-A_F)x>0` is the new edge.
7. Common-LCM weighting of normalized optimized margins fails on
   `(8,15,35,40,48,56,75,132,147)`. Do not replace `A_F` by those margins.
8. Do not use prime forcing, unit strata, packing, signed phase cells,
   coefficient-two Gamma, height compression, descent, deletion,
   first-blocker flow, or the tautological circuit-escape theorem.

Give an abstract anti-tautology example: a finite labelled cover system may
have a proper covered set whose induced normalized incidence matrix is
subcritical, while another abstract system may violate subcriticality without
all rows being covered. Therefore the matrix theorem is not a set-theoretic
unfolding of noncoverage; its content must be arithmetic.

## Required attacks

### Attack A: exact cardinality and `M`-matrix structure

Derive an exact formula for every `|B_i^j|`, including all gcd and strict
endpoint corrections. Investigate whether `I-A_F` is a nonsingular
`M`-matrix by principal minors, diagonal scaling, or an explicit positive
rational inverse certificate. Every determinant or minor inequality must be
proved uniformly; numerical positivity is insufficient.

### Attack B: Perron obstruction and closed walk arithmetic

Assume the target fails. By an exact finite-dimensional alternative, obtain a
nonzero nonnegative dual/Perron vector or a principal subset `S subset F(a)`
with spectral radius at least one. Expand powers or cycle products of the
matrix into labelled closed walks

```text
j_0 -> j_1 -> ... -> j_k=j_0
```

weighted by exact bad-set cardinalities. Seek an arithmetic incompatibility
among the different moduli `N*a_j`. This must use proved gcd/fiber formulas;
do not transport residue representatives across pivot moduli or cancel a
nonunit.

### Attack C: construct weights or refute exactly

Try explicit weights built from speeds, gcd data, divisor layers, or a finite
Neumann-series truncation with a proved uniform tail. Alternatively derive
weights by eliminating a deterministically selected row and prove Schur
complements preserve the strict modular inequality. If false, give the first
exact positive injective tuple in the declared search order for which no
positive rational `x` exists, together with an exact dual certificate or a
principal minor/eigenvalue certificate. A decimal eigenvalue is not enough.

## Mandatory semantic and falsification suite

Recompute these from the literal definitions before trusting a proof or
program. These are controls, not accepted evidence.

1. **Known-success tuple:** `(1,4,5,6,7,11)` has covered-speed set
   `F={1,4,5,11}`. Verify the exact induced matrix and exhibit exact rational
   weights satisfying all strict rows.
2. **Stopped-score success:** `(1,4,5,6,7,11,32)` must be processed even
   though Prompt82's scalar score is negative. Its covered-speed set is
   `{1,4,5,6}`; an exact weight certificate here tests route independence.
3. **Sparse-cover obstruction:** `(6,7,12,24,144)` has covered-speed set
   `{6,7,12,24}`. The matrix target must survive the Prompt78 internal
   three-owner cover rather than deleting it.
4. **Restriction failure:** on all labels of `(1,2,3,5)`, rather than only
   `F(a)`, the normalized bad-incidence matrix has row sums
   `(1,1,1,6/5)` and is not subcritical. This deliberately false
   strengthened expectation must fail.
5. **Boundary:** at `N=4`, `p=3`, owner `1`, candidate `r=3` has
   `rho_12(3)=3=p` and is safe; reflection gives the matching endpoint.
6. **Collision:** use `(1,3,13)` at pivot `3` to retain distinct labelled
   coincident bad sets. Also include a candidate where two products collide
   at equality without merging owners.
7. **Nonunit/gcd:** retain nonunit candidates and a zero modular product in a
   bad set; compare the exact count with the gcd/fiber formula.
8. **Scaling:** common positive scaling of every speed must preserve `F`, all
   normalized matrix entries, and feasibility after the canonical
   speed-labelled identification.
9. **Permutation:** arbitrary coordinate permutation must conjugate `A_F` and
   transport the weight certificate without changing truth.
10. **Malformed inputs:** reject zero speed, repeated speed, `n<2`, a pivot
    included as its own owner, omitted candidates, weak-boundary badness,
    deduplicated equal owner sets, and a deliberately altered expected matrix
    entry.
11. **Synthetic matrix negative:** separately test a rational nonnegative
    matrix with spectral radius at least one and verify that the exact
    feasibility checker rejects it. Label it as not arising from a theorem-
    domain tuple.

Canonical tuple enumeration, if used, is by `(n,max(a),increasing tuple)`;
owners and pivots are ordered by increasing speed. Subsets are ordered first
by cardinality and then lexicographically. Exact rational Gaussian
elimination or exact linear programming is required. Floating-point
eigenvalues may guide a search but cannot certify an outcome.

## Small admission preflight - not evidence

The contract preparer ran one disposable exact-rational sanity check. It
solved `(I-A_F)x=1` by rational Gaussian elimination and checked `x>0`, hence
`A_F*x<x`, for primitive increasing tuples in these complete boxes:

```text
(n,H,count) =
  (2,30,277),
  (3,24,1747),
  (4,18,2919),
  (5,14,1981),
  (6,11,462).
```

No failure occurred. The same check passed the first three mandatory tuples.
No script or output is supplied, no independent replay occurred, and this is
not `computed finite evidence`. Recompute independently before citing any
finite result.

## Required response format

Return exactly these sections:

1. `Disposition`: one of `PROVE`, `STOP`, `SEPARATION`, or `OPEN`.
2. `Frozen statement audit`: every quantifier, strict boundary, and matrix
   convention.
3. `Anti-tautology and overlap audit`.
4. `Exact cardinality formula` for `|B_i^j|`, with proof.
5. `Uniform attack`: full proof or the first unsupported arrow.
6. `Dual/counterexample audit`: exact certificate if the target fails.
7. `Mandatory fixtures`: exact results and malformed-input rejection.
8. `Implication chain`: with every still-open edge labelled.
9. `Claim table`: claim, hypotheses, status label, proof/evidence location.
10. `Single next obligation`: one exact statement, or `none` after a proved
    theorem or exact refutation.

The outcomes are mutually exclusive:

- `PROVE`: a complete all-`n`, all-height proof and rational-weight
  construction.
- `STOP`: an exact theorem-domain counterexample or fatal semantic collapse.
- `SEPARATION`: one strictly narrower non-tautological arithmetic lemma with
  a complete proof and a complete implication to the frozen target.
- `OPEN`: neither proof, exact refutation, nor proved narrowing was achieved;
  identify exactly one first missing lemma.

Do not silently weaken the theorem, substitute a nearby score, or promote a
bounded computation. End after one major turn.
