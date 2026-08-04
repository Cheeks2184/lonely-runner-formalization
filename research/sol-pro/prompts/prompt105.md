---
owner: GPT-5.6 Sol High top-level desktop orchestrator
supervising_authority: /root
launch_runtime: original browser-capable desktop Codex session
role: GPT-5.6 Sol / Pro mathematical research agent
task_id: SOL-P105-PRO-GLOBAL-FOUR-GCD-UNCOVERED-MASS
base_commit: c5a493195ba48aedaeaa14ed66de96faa135d238
admission: LAUNCH-CANDIDATE
prompt_encoding: UTF-8
prompt_line_endings: LF
prompt_hash_scope: bytes from the line "# Prompt 105:" through EOF
prompt_sha256: b85a89b554d449651b2ff1eeef91e4a38662041e35536fe366fa897b54e1cc04
---

# Prompt 105: GLOBAL-FOUR-GCD-UNCOVERED-MASS

You are GPT-5.6 Sol running at Pro effort in a genuinely new ChatGPT
conversation. Act as the mathematical research agent. This is the actual
research turn, not a request to review admission or prepare another contract.
If submitted, GPT-5.6 Sol High in the original browser-capable desktop Codex
session has already made the launch decision.

Use one major turn. Prove the exact unrestricted quantitative theorem below,
give an exact theorem-domain counterexample, or return `STOP` with a proof that
it is equivalent to ordinary pivot positivity or duplicates an existing route.
Do not silently weaken the constant four.

## Frozen research contract

| Field | Frozen value |
| --- | --- |
| Exact theorem | `GLOBAL-FOUR-GCD-UNCOVERED-MASS` below |
| Scope | every `n>=3` and positive injective integer tuple; unrestricted height |
| New structure | permutation-symmetric total uncovered mass across all pivots, normalized by the common speed gcd |
| Complete consequence | positive uncovered mass -> ordinary pivot certificate -> kernel-checked integer/real LRC equivalences; `n<=2` uses accepted base cases |
| Single unresolved lemma | the displayed `4*g` lower bound |
| Stop condition | exact tuple with total uncovered mass below `4*g`; proof of equivalence to ordinary positivity; or invalid reflection/scaling step |
| Maximum budget | one Pro turn; at most one quarter on finite falsification |

This replaces a stopped product-weighted draft. The discarded inequality

```text
product_k a_k <= sum_j |Q_j|*product_(k!=j) a_k
```

is false already at `(n,N,a)=(2,3,(1,3))`, where the `Q` counts are `(0,2)`
and `3>2`. It is not the theorem below and must not be revived.

The new target is distinct from Prompt98's nondivisible maximum pivot,
Prompt102's upper-half pivot, Prompt103's squarefree-gcd numerator, Prompt66's
packing/radial descent, and coefficient-two Gamma matching. It selects no pivot
by rank, divisibility, or residue gcd.

## Accepted evidence boundary

Unrestricted LRC remains open. Exact-scope accepted inputs are:

- `proved-lean`: canonical candidate and strict bad-residue definitions;
- `proved-lean`: exact positive-integer pivot-certificate equivalence and the
  endpoint-safe positive-integer/real reduction;
- `proved-lean`: common-scaling laws for pivot rows and finite-family gcd
  normalization;
- `proved-lean`: exact one-set cardinalities and pair/triple CRT counts;
- `refuted-exact`: Prompt101's positive scalar-weight theorem and Prompt98's
  maximal internal pair-overlap supply;
- `refuted-exact`: the discarded product-weighted mass inequality above; and
- `open`: the `4*g` theorem, ordinary pivot existence, integer LRC, and real
  LRC.

No prompt, response, attachment, finite scan, or compiled conditional wrapper
is evidence. Use only:

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

## Exact canonical data

Fix `n>=3`, put `N=n+1`, and let `a : Fin n -> Nat` be positive and
injective. For pivot `j`, define

```text
p_j = a_j,
M_j = N*p_j,
rho_M(x) = min(x mod M, M-(x mod M)),
R_j = {r in {0,...,M_j-1} : N does not divide r},
B_i^j = {r in R_j : rho_(M_j)(r*a_i) < p_j}  for i!=j,
Q_j = R_j minus union_(i!=j) B_i^j.
```

Representatives are canonical and badness is strict. Equality `rho=p_j` is
safe. Retain zero products, both cyclic sides, antipodes, nonunits,
gcd-degenerate multiplication fibers, coincident bad sets with distinct
labels, and excluded `N`-multiples.

Let

```text
g(a) = gcd {a_j : j : Fin n},
U(a) = sum_(j : Fin n) |Q_j|.
```

Use the positive finite-family gcd, so `g(a)>0`. The intended scaling law is

```text
g(t*a)=t*g(a),
|Q_j(t*a)|=t*|Q_j(a)|,
U(t*a)=t*U(a)
```

for positive natural `t`. Prove every sheet/cardinality statement before
normalizing; do not infer it merely from complete-cover invariance.

## Sole unrestricted theorem

Prove or refute exactly:

```text
GLOBAL-FOUR-GCD-UNCOVERED-MASS:

For every n>=3 and positive injective a : Fin n -> Nat,

  4*g(a) <= U(a).
```

For primitive tuples this is `4 <= sum_j |Q_j|`. The theorem counts canonical
residues, not reflection orbits and not distinct real times.

## Exact implication to unrestricted LRC

1. Positivity gives `g(a)>0`, hence the target gives `U(a)>0`.
2. Some `Q_j` is nonempty; choose `r in Q_j`.
3. This is an ordinary canonical pivot certificate.
4. Invoke the kernel-checked positive-integer pivot equivalence.
5. Use accepted direct base cases for `n=1,2`.
6. Apply the endpoint-safe integer/real equivalence.

The chain has one new mathematical edge: the displayed `4*g` inequality.

## Mandatory strength/equivalence audit

- Reflection preserves each `Q_j`. A non-fixed safe residue gives a pair, but
  ordinary pivot existence alone yields only two canonical residues, not four.
- A reflection fixed point can occur only at `M_j/2`; analyze candidate
  membership and parity exactly. Do not assert all orbits have size two.
- If an antipodal certificate forces certificates at other pivots, prove the
  cross-pivot statement with the changed moduli.
- Common scaling should explain the factor `g`; it does not prove the primitive
  lower bound four.
- Relabelling only permutes summands. The target is not upper-half, top-two,
  maximum-pivot, or squarefree-gcd selection.
- Full inclusion-exclusion for `Q_j` is a tautological rewrite. Pair/triple
  energy may be used only with a sign-valid inequality.
- If you prove that every ordinary certificate automatically forces total mass
  at least `4*g`, return `STOP / EQUIVALENT` with the exact proof. Do not market
  an equivalent restatement as progress.

## Required attacks

Compare at least two:

1. **Reflection-orbit transfer.** Start from a hypothetical minimal tuple with
   `U<4g`. Classify the at most three normalized uncovered residues, including
   fixed antipodes, and use exact cross-pivot transfer to force another orbit.
2. **Global additive energy.** For
   `mu_j(r)=#{i!=j:r in B_i^j}`, use exact pair/triple intersection counts to
   show that concentrating coverage enough to leave fewer than four primitive
   residues at all pivots is incompatible across moduli. Do not reverse a
   second-moment inequality.
3. **Primitive minimal counterexample.** Normalize by the common gcd using an
   exact `Q`-cardinality scaling proof, then minimize `(n,max a,sum a,sorted a)`.
   Every deletion or replacement needs a witness-lifting argument.

## Mandatory falsification suite

- Exactly enumerate small positive injective tuples and all pivot rows; report
  the first minimizer of `U/g`, not merely certificate existence.
- Verify equality fixtures:
  `(1,3,4)` at `n=3` has `Q` counts `(0,2,2)`;
  `(1,2,3,5)` at `n=4` has `(0,0,2,2)`; and
  `(1,2,3,4,5,7)` at `n=6` has `(0,0,0,0,2,2)`.
- Recheck the stopped product-weighted counterexamples `(1,3)`, `(1,2,8)`,
  `(1,3,4,5)`, and `(1,2,3,4,5,7)` against the new theorem; they must not be
  misreported as failures of `U>=4g` when `n>=3`.
- Preserve strict equality safety using `(N,p,d,r)=(5,6,1,6)` and kill a
  mutated `<=p` implementation.
- Retain antipodes, fixed reflection points, fiber collisions, and coincident
  labelled bad sets.
- Test positive common scalings and require both sides to scale by exactly `t`.
- Reject zero or repeated speeds as malformed.
- Include a synthetic declared `Q`-count vector summing below `4g` as a
  negative checker fixture, explicitly not a theorem-domain counterexample.

The preparation audit (not mathematical evidence) found no counterexample in
complete domains `n=3, a_i<=25`; `n=4, a_i<=16`; `n=5, a_i<=12`;
`n=6, a_i<=10`; `n=7, a_i<=9`, plus 300 deterministic random tuples per
dimension `3..8` with speeds at most 120. Reproduce independently before using
any count. A real counterexample must report every `R_j`, labelled bad set,
`Q_j`, `g`, `U`, and premise check.

## Output schema and stop rule

Return exactly:

1. `Verdict`: `PROVED`, `REFUTED`, `MIXED`, or `STOP`.
2. Exact quantified theorem.
3. Strength/equivalence audit.
4. Claim table with permitted labels.
5. Proof or exact theorem-domain counterexample.
6. Six-step implication audit.
7. Falsification, scaling, and mutation report.
8. First declaration-level formal obligation.
9. Single remaining obstruction if unresolved.
10. Recommended disposition.

Budget is one major Pro turn. Stop on an exact counterexample, a false fixed-
point or scaling claim, equivalence to ordinary pivot positivity, or reuse of
the stopped product-weighted inequality. Do not invent a weaker constant.
