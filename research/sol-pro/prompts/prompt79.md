---
owner: GPT-5.6 Sol High top-level desktop orchestrator
supervising_authority: /root
launch_runtime: original browser-capable desktop Codex session
role: Research Pipeline Lead - prompt preparation only
task_id: PIPE-P79-OBSTRUCTION-SUPPLY-CONTRACT-196
base_commit: c2c0adc213c5df85a3f0fe64c87b5cc2b57dc3aa
admission: LAUNCH-READY
---

# Prompt 79: OBSTRUCTION-EXTRACTION-DISTINCT-PRIME-SUPPLY

This is one isolated unrestricted Sol Pro research contract and the exact
successor to Prompt67's prime-forcing route. Prove or decisively stop the
frozen obstruction-extraction lemma below. If it holds, a finite divisor graph
and an exact Euclidean/Hall argument produce enough distinct prime-forcing
primes to cross the audited Malikiosis--Santos--Schymura product threshold.

This file is only a prepared contract. It is not a browser launch, active
cell, response, proof, audit, or evidence promotion. Only GPT-5.6 Sol High
under `/root`, using the original signed-in browser-capable desktop session,
may open a genuinely new ChatGPT conversation, explicitly select GPT-5.6 Sol
with Pro effort, launch this prompt, recover the response, and decide status.
Sol Medium prepared the contract. Luna may later replay one frozen verifier;
it may not perform this proof search.

## Accepted boundary

Use only independently accepted scopes.

- `PrimeForcing(n,p)`, small-prime forcing for `p<=n+1`, small-prime product
  insufficiency, exact natural threshold arithmetic, conditional Euclidean
  distinct-prime extraction, deletion-gcd reduction, and the conditional
  prime-divisibility chain from Prompt67 are `proved-math` at their audited
  hypotheses. `OBSTRUCTION-EXTRACTION-SUPPLY` and uniform supply remain
  `open`.
- The corrected bounded modular-annihilator and fixed-counterexample rational
  hyperplane consequences from Response68 are `proved-math`. They provide
  necessary relations only. In particular, an exact relation `c dot a=0`
  cannot be used as a nonzero obstruction integer.
- The MSS Theorem A/product consequence is `literature` and
  `external-unformalized`. The exact audited comparison is

  ```text
  n^n * Q >= binom(n+1,2)^(n*(n-1)).
  ```

  Weak `>=` here contradicts the strict product upper bound for a primitive
  counterexample under lower-dimensional LRC.
- Do not use Prompt75 except for its integrated negative boundary: it proves
  no global synthesis. Assume no output from active Prompts76--78.

No recovered attachment may be executed. Response self-dispositions do not
promote claims.

## Frozen prime-forcing definitions

Let `n>=3`, put `N=n+1`, let `p` be prime, and put `M=N*p`. Define

```text
rho_M(x) = min(x mod M, M-(x mod M)).
```

`PrimeForcing(n,p)` means that every possibly repeated
`v : Fin n -> {0,...,M-1}` satisfying

```text
p does not divide v_i                                      for every i,
gcd(M,{v_i : i != k}) = 1                                 for every k,
```

has some `0<=r<M` with

```text
rho_M(r*v_i) >= p                                          for every i.
```

Badness is strict `<p`; equality is safe. Repeated residues, nonunits,
collisions, both cyclic sides, every deletion premise, and primes dividing
`N` must be retained.

Define `BadPrime(n,p)` as `p` prime and `not PrimeForcing(n,p)`. For a failure
tuple define its owner-labelled strict bad sets

```text
B_i(v) = {r in Z/(N*p)Z : rho_(N*p)(r*v_i) < p}.
```

Choose the unique canonical inclusion-minimal subcover by first minimizing
cardinality and then the increasing list of owner indices. Keep duplicate bad
sets as distinct owners.

## Frozen obstruction signatures

For `H>=1`, an `H`-bounded normalized obstruction signature is data

```text
sigma = (m,c,z,Delta)

1 <= m <= n,
c : Fin m -> {0,...,N-1},
z : Fin m -> Int,             |z_s| <= H,
Delta : Int,                  Delta != 0.
```

A failure `(p,v)` realizes `sigma` when there are:

```text
the canonical inclusion-minimal cover iota : Fin m -> Fin n,
a unit u modulo N*p,
signs eps_s in {-1,+1},
```

such that for every selected owner `s`,

```text
u*eps_s*v_(iota s) == c_s (mod N),
u*eps_s*v_(iota s) == z_s (mod p).
```

Coordinate permutation, independent sign reflection, and common unit scaling
may be used only after proving that they preserve the full strict cover and
all deletion-gcd premises.

## Sole unresolved unrestricted lemma

There is exactly one permitted missing edge:

```text
OBSTRUCTION-EXTRACTION-DISTINCT-PRIME-SUPPLY:

For every n>=3 there exist H_n>=1 and a finite set Sigma_n of
H_n-bounded normalized obstruction signatures, fixed before p and v,
such that every BadPrime(n,p) failure tuple v realizes some sigma in Sigma_n
and p divides Delta_sigma.
```

The theorem is unrestricted in `n`, `p`, and tuple height. `Sigma_n` may
depend on `n` but not on `p` or the failure tuple. Every `Delta_sigma` must be
a displayed nonzero integer obtained from the normalized cover data. It is
forbidden to define it as `p`, as a product of all bad primes, or by first
assuming finiteness of the bad-prime set.

This is stronger and more structured than cofinite prime forcing: it requires
an owner-labelled bounded normalization and a nonzero integral obstruction
certificate for every failure. It is materially narrower than uniform prime
supply because the remaining extraction is finite arithmetic. Perform the
logical-strength audit explicitly. If the only construction of `Sigma_n` or
`Delta` presupposes cofinite forcing, uniform supply, or LRC, return `STOP`.

## Exact divisor graph and Hall extraction

Assuming the frozen lemma, put

```text
D_n = product_(sigma in Sigma_n) |Delta_sigma| > 0,
C_n = binom(n+1,2),
T_n = min {Q : Nat | 0<Q and n^n*Q >= C_n^(n*(n-1))}.
```

Starting with `R_0=1`, define

```text
E_j = D_n*R_j + 1,
q_j = the least prime divisor of E_j,
R_(j+1) = R_j*q_j.
```

Let `m_n` be the least `m` with `R_m>=T_n`. Freeze the finite bipartite
divisor graph

```text
Left  = Fin m_n,
Right = {q prime : exists j<m_n, q divides E_j},
j ~ q iff q divides E_j.
```

Prove, rather than cite informally:

1. every `E_j>1` has a least prime divisor;
2. `gcd(D_n,E_j)=1`;
3. the greedy choices `j |-> q_j` are injective, hence give a matching;
4. the matching implies Hall's neighborhood inequality for every left subset;
5. no matched prime divides `D_n`, so it is not bad by the frozen lemma;
6. `R_(m_n)` is exactly the product of the distinct matched primes and meets
   the natural threshold.

The Hall formulation is an audit device: it must bind each demand to a
distinct prime divisor and must not count prime powers or repeated primes.

## Complete implication chain

Give every quantifier and dependency.

```text
one- and two-moving-speed Lean base cases
  -> induction hypothesis in all smaller moving dimensions
  -> primitive normalization of a hypothetical n-speed counterexample
  -> every deletion gcd is one                           [proved-math]
  -> frozen obstruction lemma
  -> divisor-graph matching gives distinct primes q_j
  -> each q_j satisfies PrimeForcing(n,q_j)
  -> counterexample reduction modulo N*q_j forces q_j | product_i a_i
  -> R_(m_n) | product_i a_i
  -> n^n*product_i a_i >= C_n^(n*(n-1))
  -> contradiction with strict MSS product bound        [external-unformalized]
  -> positive-integer LRC
  -> existing proved-lean real/integer equivalence
  -> unrestricted real LRC.
```

Do not call the final chain `proved-lean`: the obstruction lemma is open and
the MSS wrapper is external-unformalized.

## Required attacks

### Attack A: private-point normalization

For each selected owner choose its least private residue. Write exact centered
equations at those private residues, preserve signs and the `N` and `p`
components, and seek a bounded normal form independent of `p`. Any proposed
bound `H_n` must be explicit. Show how one fixed determinant, resultant, or
integer polynomial `Delta_sigma` vanishes modulo `p`, and separately prove it
is nonzero over `Int`.

### Attack B: obstruction divisor graph

Build a graph whose left vertices are normalized private-point equations or
minimal-cover dependencies and whose right vertices are irreducible integer
factors. Prove a Hall or uncrossing statement that selects enough independent
equations to produce a nonzero minor. A rank count over `F_p` is insufficient
unless the corresponding integer minor and its nonvanishing are explicit.

The two attacks may share the frozen signature, but may not introduce a
second unrestricted lemma.

## Mandatory falsification

Recompute, without recovered code:

1. `n=3,p=5,v=(1,3,4) mod 20`, a genuine admissible failure;
2. `n=4,p=7,v=(1,3,4,5) mod 35`, a genuine admissible failure;
3. all audited small-prime successes `p<=N` using `r=N`;
4. repeated-coordinate and coincident-bad-set cases;
5. primes dividing `N`, nonunits, deletion-gcd edge cases, and equality
   `rho=p`;
6. a cover whose bounded modular annihilator specializes to an exact integer
   relation, demonstrating why `Delta=0` is forbidden.

Before a universal proof, run a fresh deterministic exact search over every
premise-satisfying repeated tuple for `(n,p)=(3,5)` and `(4,7)`. For every
proposed normalization, emit the first failure to realize a signature, the
first zero `Delta`, or the first missed divisibility. Search order is tuple
lexicographic, then canonical cover, then private residues, then sign/unit
choices. Zero failures are finite evidence only.

Any code must be a separately hashed attachment with exact interpreter,
command, domain count, ordering, malformed-input behavior, and source/output
binding. Floating arithmetic is forbidden.

## Required response format

Return exactly:

1. **Disposition** -- `BRIDGE`, `PIVOT`, or `STOP`.
2. **Status table** -- exact evidence label and dependency for every claim.
3. **Frozen definitions** -- all domains, normalization choices, and strict
   boundaries.
4. **Anti-tautology audit** -- distinguish the target from cofinite forcing,
   uniform supply, and LRC.
5. **Exact fixtures and falsification** -- domains, ordering, hashes, first
   failure or finite-only zero-failure result.
6. **Attack A** -- complete normalization and nonzero obstruction proof, or
   the first fatal arrow.
7. **Attack B** -- exact divisor/minor Hall argument, or first fatal arrow.
8. **Distinct-prime extraction** -- full graph, matching, injectivity, product,
   and threshold proof.
9. **Complete implication chain** -- including induction, external MSS, and
   the existing Lean boundary.
10. **Proof-obligation ledger and evidence boundary**.

`BRIDGE` requires the frozen obstruction lemma for all quantifiers plus the
exact extraction. `PIVOT` requires a proved unrestricted theorem that strictly
narrows the obstruction lemma without replacing it by an equally strong
existential. Finite success is never `PIVOT`.

## One-turn budget and STOP rules

Use one major Sol Pro turn: first third normalization/falsification, second
third nonzero obstruction extraction, final third divisor graph and audit.

Return `STOP` immediately if `Delta=0`; a determinant is only prime-dependent;
the finite signature is chosen after seeing `p`; the proof assumes finitely
many bad primes; a repeated residue is excluded; a nonunit is cancelled; a
strict boundary is weakened; a prime power is counted more than once; the
missing edge becomes uniform supply or LRC; or only bounded computation
survives. A rigorous fatal-arrow memo or counterexample is a successful turn.
Do not edit the tracked repository or claim unrestricted LRC.
