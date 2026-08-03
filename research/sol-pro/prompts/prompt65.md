# Prompt 65: FIRST-BLOCKER-MAXIMIZER-TRANSFER

Start one new signed-in ChatGPT Sol Pro conversation with a major independent
research turn. This is the next unrestricted C1 cell after the incomplete
Prompt64 verification stop. Attack only the exact first-blocker/maximizer
transfer below. Do not switch to top-two coverage, prime-forcing, height
compression, or a broad unrestricted search.

Preserve the project ledger labels exactly: `proved-lean`, `proved-math`,
`computed`, `conditional`, `conjectural`, `rejected`, and `open`. A response
self-label, a finite sweep, or a plausible Lean block does not promote a
claim. The Prompt64 stop record is in `docs/prompt64-luna-audit.md`; its
incomplete domain and partial coverage are not evidence for this cell.

## Exact response63 definitions

Use the definitions below from `research/sol-pro/responses/response63.md`
without replacing them by convenient variants.

Let `n >= 2`, `N = n + 1`, and let

```text
a : [n] -> Z_{>0}
```

be injective. For `m > 0`, `[x]_m` is the least residue in
`{0,...,m-1}`, and

```text
rho_m(x) = min([x]_m, m - [x]_m).
```

Thus `|x/m|_{R/Z} = rho_m(x)/m`. Define the speed functions and deletion
feasible sets by

```text
f_i(t) = |a_i * t|_{R/Z},
K_k = { t : f_i(t) >= 1/n for every i != k },
eta_k = max_{t in K_k} f_k(t),
M_k = { t in K_k : f_k(t) = eta_k }.
```

For deletion `k`, the exact response63 canonical certificate set is

```text
C_k(a) = { (j,r) :
  j != k,
  0 <= r < n*a_j,
  n does not divide r,
  rho_(n*a_j)(r*a_i) >= a_j for every i != k }.
```

For `c=(k,j,r)`, put `p=a_j` and `m=n*p`. The exceptional-good condition is

```text
Good_a(k,j,r) <-> n*p <= N * rho_(n*p)(r*a_k).
```

The shell boundary is closed. A row with no strict bad coordinate lifts every
allowed deletion; a singleton row `{k}` lifts deletion `k` exactly when its
deleted residue satisfies the exceptional-good inequality. Do not replace
this closed-boundary convention by an open one.

## Oriented active edges and exact reverse-grid data

Define `E(a)` to contain **all** oriented active edges

```text
e = (k_e, t_e, epsilon_e, j_e)
```

such that:

1. `t_e in M_(k_e)`;
2. `epsilon_e` is a one-sided direction in which `f_(k_e)` locally increases;
3. `j_e != k_e`;
4. `f_(j_e)(t_e) = 1/n`;
5. direction `epsilon_e` locally decreases `f_(j_e)`.

Include every maximizing time, active index, orientation, and tie. Never select
one arbitrary maximizer or one arbitrary active edge and silently discard the
others. The deleted index of an edge is its first component:

```text
deletedIndex(e) = k_e.
```

Each edge carries the exact response63 B3/C1 data. Write `p_e=a_(j_e)` and
choose `s_e in {+1,-1}` so that the signed active phase is
`p_e*t_e = s_e/n (mod 1)`. The direction increasing the deleted coordinate is
`epsilon_e = -s_e`. There are integers `z_e,r_e` with

```text
r_e = n*z_e + s_e,
0 <= r_e < n*p_e,
t_e = r_e/(n*p_e) (mod 1).
```

Put

```text
d_e = rho_(n*p_e)(r_e*a_(k_e)),
b_e = (a_(k_e) + d_e)/n,
Q_e = (z_e*a_(k_e) + s_e*b_e)/p_e,
R_e = (N*Q_e - s_e) mod (N*a_(k_e)),
```

with `b_e` and `Q_e` integral and `0 <= R_e < N*a_(k_e)`. The exact source
equations are

```text
r_e*a_(k_e) = -s_e*d_e (mod n*p_e),
d_e = -a_(k_e) (mod n),
a_(k_e) + d_e = n*b_e,
p_e divides z_e*a_(k_e) + s_e*b_e,
N*d_e < n*p_e.
```

The final strict inequality is mandatory. Every edge used in the theorem
must have valid `ReverseGridData`, including `N=n+1`, positive `p_e` and
`a_(k_e)`, `s_e=+1` or `-1`, the source equations above, and
`N*d_e < n*p_e`. Do not infer the deep inequality from a vague phrase such as
“reverse endpoint” or from a finite example.

Define the response63 reverse path and escape by

```text
Delta_e = (n*p_e - N*d_e) / (N*n*p_e*a_(k_e)),
gamma_e(delta) = t_e - s_e*delta,
0 <= delta <= Delta_e.
```

At `gamma_e(Delta_e)`, the deleted coordinate is exactly on the closed
`1/N` boundary. In the canonical reverse-grid representative
`u_e = R_e/(N*a_(k_e))`, the exact C1 facts are

```text
rho_(N*a_(k_e))(R_e*a_(k_e)) = a_(k_e),

f_h(u_e) >= 1/N
  <-> rho_(N*a_(k_e))(R_e*a_h) >= a_(k_e),

rho_(N*a_(k_e))(R_e*p_e)
  = rho_(N*a_(k_e))(N*b_e - p_e).
```

Use these as the formal/arithmetic boundary, not as a common-grid
identification between different edges.

## Sole theorem target

Assume exactly the following target context:

- `n >= 2`, `N=n+1`, and `a` is positive and injective;
- every `K_k` is nonempty and `E(a)` is nonempty;
- every edge `e` in `E(a)` has valid `ReverseGridData`, including
  `N*d_e < n*p_e`;
- `e` is a global minimizer of `Delta` over **all** `E(a)`;
- `gamma_e(Delta_e)` is not a full closed `1/N` witness;
- define the first survivor-blocker time

  ```text
  tau_e = min { delta in [0,Delta_e] :
                min_(h != k_e) f_h(gamma_e(delta)) <= 1/N };
  ```

  and assume `0 < tau_e < Delta_e`;
- choose `h_e != k_e` as the least blocker satisfying
  `f_(h_e)(gamma_e(tau_e)) = 1/N`.

Prove or refute exactly:

```text
exists e' in E(a),
  deletedIndex(e') = h_e
  and Delta_e' <= tau_e.
```

The strict inequality `Delta_e' < Delta_e` would follow from
`tau_e < Delta_e` and contradict global minimality. Keep the requested
non-strict target as the theorem conclusion; do not silently state only the
strict version or change `tau_e` to an arbitrary blocker time.

Do not silently add a convenient maximizer, a common active pivot, a common
modulus, a common reverse time, a common grid, a fixed deletion certificate,
or a unique orientation. If a proof needs an additional premise, state it as
a rejected strengthening unless it is proved from the exact context.

## Two required attacks

Run both attacks before selecting a surviving route. They are materially
different and each needs an obligation ledger.

### Attack A: component/maximizer geometry

Start from the compact components of the exact `K_k`, the full maximizer sets
`M_k`, and all oriented active edges. Determine whether the first blocker on
the reverse path forces a component or maximizer for deletion `h_e` whose
maximizer data can be used to construct `e'`. Track endpoint closure,
component labels, all ties, and one-sided orientations. Prove every claimed
component-to-maximizer implication with exact quantifiers.

Explicitly test and, if attempted, certify any strengthening that says an
active cycle must meet an `N`-divisible coordinate, that maximizing sets from
different deletions intersect, or that two active vertices use one common
modulus. Response63 records these mechanisms as obstructed; do not reuse them
without a new proof under the exact target hypotheses.

### Attack B: exact modular-grid conversion

Start at the exact first-blocker crossing on the `N*a_(h_e)` reverse grid and
try to produce an actual maximizer in `M_(h_e)`, then an active `n*a_j` grid
point at that maximizer, then an oriented edge deleting `h_e`. Preserve
`N*d_e < n*p_e`, the signed residue equations, the closed boundary, and the
full `Delta` definition at every conversion.

The single unsupported conversion must remain explicit:

```text
N*a_h first-blocker crossing
  -> actual maximizer t' in M_h
  -> active n*a_j grid at t'
  -> oriented edge e' deleting h
  -> Delta_e' <= tau_e.
```

Do not replace this with a fixed-row deletion monotonicity claim, an
independent per-deletion choice, a common-grid relaxation, or a shell-count
inequality that does not control singleton overlap. Each is a separate
rejected strengthening unless proved at the exact hypotheses.

## Mandatory falsification

Before promoting any proof idea, run one targeted deterministic generator
aimed specifically at cases where `gamma_e(Delta_e)` is **not** a full closed
`1/N` witness. The prior Response63 census had 36 zero-exceptional records,
but every minimizing reverse endpoint there was already full; those cases are
vacuous for this branch and cannot support the transfer.

For every generated tuple and every deletion, enumerate all of the following:

- every maximizer in `M_k`;
- every active index and every locally increasing orientation;
- all maximizing ties and all eligible first blockers;
- the least blocker and the exact `tau_e`;
- every eligible successor edge, including its deleted index, `p`, `r`, `d`,
  `b`, `Q`, `R`, `Delta`, and whether `Delta <= tau_e`;
- both literal and independently structured/optimized results, with exact
  byte comparison and provenance that distinguishes lower/source coordinates
  from normalized full tuples.

Also include every consecutive family `(1,2,...,n)` for `2 <= n <= 30`.
Mandatory fixtures are:

```text
(1,3,4,7)
(1,2,3,60)
(1,3,4,5,18)
(1,2,6,8,10)
(15,21,40,48,56,105,126,280,1200)
```

Include all explicit reindexings, all orientations and ties, and any non-full
reverse-endpoint cases found by the targeted generator. The fixtures are
falsification obligations, not
counterexamples to LRC. A literal rejected-strengthening certificate must
give the complete tuple, hypotheses, exact failing witness/row/edge, and the
reason it does not refute the primary theorem.

## Known obstructions to preserve

The following are known response63 obstructions and must remain visible in
the proof ledger:

- active cycles may avoid all coordinates divisible by `N`;
- maximizing sets can be disjoint and can use different moduli;
- the `N*a_h` first-blocker grid and an active `n*a_j` grid need not match;
- fixed-row deletion monotonicity is false;
- independently selecting one certificate per deletion is invalid;
- shell counts do not control singleton overlap;
- ReverseGrid C1 needs `N*d<n*p`.

The tuple `(1,2,6,8,10)` is the mandatory active-cycle obstruction. The tuples
`(1,3,4,7)`, `(1,2,3,60)`, and `(1,3,4,5,18)` are mandatory boundary,
fixed-pivot, and related obstruction checks. The large stress tuple is the
mandatory nine-speed arithmetic stress. Do not call any of them an LRC
counterexample without a complete proof of that stronger claim.

## Exact implication chain to unrestricted LRC

Return the chain below with every arrow annotated `proved-lean`,
`proved-math`, `computed`, `conditional`, `conjectural`, `rejected`, or
`open`:

```text
hypothetical least bad positive-integer dimension
  -> primitive normalization
  -> coefficient-three residual branch and an N-divisible speed
  -> lower-dimensional completeness gives every K_k nonempty
  -> no full witness
  -> no exceptional-good deletion certificate
     by the proved-Lean selected-certificate lift
  -> every oriented edge is deep, hence N*d_e<n*p_e
  -> global minimum edge and non-full reverse endpoint
  -> first blocker (h_e,tau_e)
  -> FIRST-BLOCKER-MAXIMIZER-TRANSFER
  -> Delta_e' <= tau_e < Delta_e
  -> contradiction to global minimality
  -> no least-bad positive-integer counterexample
  -> PositiveIntegerConjecture
  -> endpoint-safe real reduction
  -> unrestricted LRC.
```

Annotate every arrow with `proved-lean`, `proved-math`, `computed`,
`conditional`, `conjectural`, `rejected`, or `open`. Keep the coefficient-three
residual, divisibility, lower-dimensional completeness, no-full-witness,
selected-certificate-lift, deep-edge, non-full-endpoint, and first-blocker
premises explicit; none may be silently inferred from a response label. The
selected-certificate lift is proved-Lean only when its exact exceptional-good
premise is supplied. The first-blocker transfer remains conjectural/open until
proved or refuted. The transfer theorem does **not** prove corrected DPLP for
arbitrary tuples. It does not route the contradiction through DPLP or through
a selected certificate after the contradiction; those are separate downstream
claims and remain open unless independently closed.

## Budget and stop contract

Use at most:

- one major independent Sol Pro turn;
- one targeted generator aimed at non-full reverse endpoints;
- one Lean prototype, only after a sound local transfer has been established,
  and only for that exact local transfer.

Stop immediately on an exact counterexample satisfying the contracted
premises and failing the `exists e'` conclusion. Stop as `STOP/OPEN` if the
argument requires a convenient maximizer, a common maximizer or common grid,
an unproved reindexing, or only broad zero-failure evidence. Do not spend the
turn on larger bounds, another broad census, or downstream owner-transversal.

## Required response

Return, in this order:

1. a status table separating existing inputs, new results, finite evidence,
   rejected strengthenings, and open claims;
2. the exact theorem and every definition above, including the quantifiers,
   `M_k`, `E(a)`, `tau_e`, `h_e`, and `deletedIndex`;
3. both attacks and an obligation ledger for each;
4. complete proofs of every new `proved-math` claim with endpoint, tie,
   orientation, and reindexing details;
5. literal rejected-strengthening certificates for every failed shortcut;
6. reproducible commands, tool/runtime versions, deterministic order, exact
   case counts, runtimes, source/output SHA-256 values, and literal/optimized
   agreement for the targeted generator;
7. the one first unsupported implication, written exactly as the
   `N*a_h -> M_h -> n*a_j -> e' -> Delta` chain above;
8. at most one repository-compatible Lean declaration, clearly marked
   proposed until independently compiled and axiom-audited;
9. the complete implication chain annotated with evidence labels;
10. a `PROVE`, `REFUTE`, or `STOP/OPEN` decision for this exact theorem, plus
    a separate statement that owner-transversal, corrected DPLP, and
    unrestricted LRC remain open unless independently closed.

## Lifecycle state

This prompt is **prepared, parked, and frozen** under sole owner
`GPT-5.6 Sol High top-level desktop orchestrator`, supervising authority
`/root`, and launch runtime `original browser-capable desktop Codex session`.
It was not launched at this checkpoint. It records no Sol Pro response,
computation, proof, theorem promotion, or finite-evidence conclusion.
