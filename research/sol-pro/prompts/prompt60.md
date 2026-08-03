# Prompt 60: independent adversarial replication of Response 59

Start a **new, separate GPT-5.6 Sol conversation with Pro effort**. This is
PRO-E, an independent adversarial review cell. Deliberate replication is
required: do not rely on the earlier conversation's reasoning, prose
conclusions, theorem labels, attachment output, or route ranking. Reconstruct
every accepted step from definitions, exact arithmetic, and primary sources.

Unrestricted Lonely Runner remains open. Do not claim otherwise. Preserve the
labels `proved-lean`, `proved-math`, `computed finite evidence`, `conditional`,
`conjectural`, `rejected`, and `open`. A result is `proved-lean` only after its
exact declaration and implication have been replayed in the pinned project
without `sorry`, `admit`, a custom axiom, a placeholder, `unsafe`, or
`native_decide`.

## Evidence envelope

The normalized Response 59 has SHA-256

`03265212ef51006bd200efe8f37b0afeeb64a572f9e80c57fb57f1c17459e5f4`.

Its attached audit script has SHA-256

`406b64139de1f7be51e3f42c750feb2a7e095d58865e82d6bdd76ab76a264e30`.

An independent replay reproduced these negative examples:

- the proposed D2 uniform criterion fails at `a=(1,2,3,60)`;
- the proposed D3 uniform criterion fails at `a=(1,3,4,5,18)`;
- prime-forcing fails for `n=3`, `N=4`, `p=5`,
  `v=(1,3,4) mod 20` despite the deletion-gcd premises.

These hashes and replay facts identify the material under review. They do not
make the response or attachment authoritative. Reimplement every finite check
clean-room without importing, translating, or calling the attachment.

## Correct formal baseline

The current Lean module proves only the following neutral soundness facts:

1. a **selected** deletion certificate satisfying the exact exceptional
   coordinate inequality yields an explicit full witness at time `r/(n*p)`;
2. a neutral wrapper consumes both
   `forall k, Nonempty (Cert k)` and an already supplied selector implication,
   then invokes the selected-certificate lift.

The corrected DPLP structural contract—with positivity, injectivity,
primitivity, the height branch, an `N`-divisible speed, all deletion
certificates, and the induction chain—is **not formalized**. The wrapper does
not prove that contract or the selector. DPLP remains conjectural. Treat any
Response 59 statement that the corrected DPLP induction bridge is already
kernel-checked as rejected unless you exhibit and replay an exact declaration
containing the full structural hypotheses and implication chain.

Raw deletion lifting without the `N`-divisible premise is false at
`(1,3,4,7)` for `n=4`, `N=5`: every deletion has a certificate but no deletion
certificate lifts. No speed is divisible by 5, and the direct time `1/5`
handles that tuple. It is not an LRC counterexample.

## Definitions to reconstruct

Let `n>=2`, `N=n+1`, and let
`a : Fin n -> Nat` be positive and injective. For pivot `j`, put `p=a_j`,
`M=n*p`, and

```text
R_j = { r : 0 <= r < M and n does not divide r }.
```

For `i != j`, using
`rho_M(x)=min(x mod M, M-(x mod M))`, define

```text
B_ji = { r in R_j : rho_M(r*a_i) < p },
D_ji = { r in R_j : N*rho_M(r*a_i) < n*p },
H_ji = B_ji \ D_ji.
```

The lower shell boundary is closed. Define

```text
delta_j(r) = #{ i != j : r in D_ji },
s_j(r)     = #{ i != j : r in H_ji },
G_j        = { r in R_j : delta_j(r)=0 and s_j(r)<=1 }.
```

Thus `G_j` consists of empty ordinary-bad candidates and shell-singleton
candidates. Do not silently exchange strict and closed endpoints.

For the continuous route, work on `T=R/Z` and define

```text
K_k   = { t in T : ||t*a_i|| >= 1/n for every i != k },
eta_k = max { ||t*a_k|| : t in K_k }.
```

Prove compactness and attainment before using `eta_k`. Keep continuous times
in `K_k` distinct from canonical speed-valued pivot times `r/(n*a_j)`.

## Independent D1--D6 audit

Response 59 offered the following statements. They are candidates for audit,
not premises.

### D1: exact complement identity

For every pivot `j`, test and prove or refute

```text
R_j \ G_j
  = (union over i != j of D_ji)
    union { r in R_j : r belongs to at least two H_ji }.
```

### D2: first-order shell-surplus lower bound

Test and prove or refute

```text
|G_j| >= |R_j|
         - sum_{i != j} |D_ji|
         - sum_{i<k, i,k != j} |H_ji intersect H_jk|.
```

Strict positivity of the right side is only a sufficient condition for a
lift. It is not claimed necessary. Clean-room reproduce the rejection of the
uniform positivity assertion at `(1,2,3,60)`: verify every corrected DPLP
premise, every set, every count, and at least one exact lift. Distinguish a
counterexample to the sufficient inequality from a counterexample to DPLP.

### D3: third-order deep Bonferroni lower bound

Define

```text
D1_j = sum_i |D_ji|,
D2_j = sum_{i<k} |D_ji intersect D_jk|,
D3_j = sum_{i<k<l} |D_ji intersect D_jk intersect D_jl|,
H2_j = sum_{i<k} |H_ji intersect H_jk|,
```

where all nonpivot indices are distinct and ordered. Test and prove or refute

```text
|G_j| >= |R_j| - (D1_j-D2_j+D3_j) - H2_j.
```

Clean-room reproduce the rejection of uniform strict positivity at
`(1,3,4,5,18)`. Verify all corrected DPLP premises and the claimed closed
shell-boundary lifts; do not trust the attachment's enumeration.

### D4: pairwise disjoint deletion-safe sets

Assuming the full tuple has no `1/N` witness, prove or refute

```text
K_k intersect K_l = empty for every k != l.
```

Audit the exact threshold comparison `1/n > 1/N` and all edge cases.

### D5: active coordinate at a maximizer

Assuming no full `1/N` witness, `K_k` is nonempty, and `t_k` maximizes
`||t*a_k||` on `K_k`, prove or refute the existence of `i(k) != k` with

```text
||t_k*a_i(k)|| = 1/n.
```

Audit compact attainment and the assertion that `t -> ||t*a_k||` has no local
maximum below `1/2`. Handle zero phase, antipodes, connected components,
multiple maximizers, and the quantifier order over chosen maximizers.

### D6: active cycle

If D5 survives, state the exact choice-dependent or choice-independent
functional-graph theorem. Determine whether it proves merely that some
self-loop-free selection contains a cycle or that every allowed selection
does. For a cycle `k_1,...,k_m`, audit the claimed relations

```text
||t_{k_s}*a_{k_{s+1}}|| = 1/n,
||t_{k_s}*a_{k_s}|| < 1/N.
```

Do not identify the different maximizing times `t_k`.

## Primary DPLP target

Attempt to prove or refute an exact, fully quantified version of
`NDivisibleActiveCycleBreak`:

```text
For every primitive positive injective n-tuple a, N=n+1,
if some a_q is divisible by N and every K_k is nonempty,
then it is impossible for all eta_k to be strictly below 1/N
in the active-maximizer graph supplied by D5--D6.
```

This display is intentionally a review target, not an accepted theorem. Fix
its quantifiers over maximizers and active-coordinate choices before working
on it. In particular:

1. determine whether continuous `K_k` maximizers necessarily yield, can be
   replaced by, or merely coexist with canonical pivot certificates;
2. do not infer a DPLP shell/empty candidate from a continuous full witness
   without an exact bridge;
3. construct and test cycles which avoid the `N`-divisible coordinate;
4. state exactly where global `N`-divisibility enters an equation involving
   maximizing times attached to other coordinates;
5. reject the target if its only use of divisibility assumes the active cycle
   contains the divisible coordinate;
6. test `(1,3,4,7)`, `(1,2,3,60)`, `(1,2,6,8,10)`, the consecutive family,
   and `(15,21,40,48,56,105,126,280,1200)`.

The exact first unsupported DPLP implication reported for review is:

```text
Convert the active equality cycle, at different maximizing times, into a
shell or empty lift using the global N-divisible coordinate.
```

Do not accept Response 59's preference for this route. Make an independent
stop/continue decision.

## Prime-forcing audit

Let `p` be prime and `M=N*p`. Repeated residues are allowed. Reconstruct
`PrimeForcing(n,p)` as the assertion that every
`v : Fin n -> {0,...,M-1}` satisfying

```text
p does not divide v_i for every i,
gcd(M, {v_i : i != k}) = 1 for every deleted k,
```

has some `0 <= r < M` with

```text
rho_M(r*v_i) >= p for every i.
```

No injectivity may be imposed on the residue tuple.

### P1: large-prime almost forcing

For `A_i={r mod M : rho_M(r*v_i)<p}`, let
`mu(r)=#{i:r in A_i}`, `Z0=#{r:mu(r)=0}`, and `Z1=#{r:mu(r)=1}`.
Audit the proposed inequality

```text
2*Z0 + Z1 >= 2*p - (N-1)*(N-2).
```

Audit the multiplication-fiber bad-set count used in its proof. Then
clean-room verify `v=(1,3,4) mod 20`: check all deletion gcds, `p`-nondivision,
every residue, absence of an empty residue, and the claimed abundance of
singletons. Treat it as a counterexample to deriving prime forcing from P1,
not necessarily to P1 itself.

### P2: sign-class special case

Let `v~w` mean `v=+w` or `v=-w mod M`, and let `s` be the number of sign
classes. Audit the sufficient condition

```text
s*(2*p+N-2) < N*p,
```

and its claimed eventual form, when `2*s<N`,

```text
p > s*(N-2)/(N-2*s).
```

Check strictness, integer rounding, repeated residues, and whether deletion
gcd assumptions imply any useful bound on `s`. Seek the smallest exact
counterexample to every unjustified strengthening.

### Uniform prime supply and primary-source check

The candidate contract says that for every moving dimension `n` in the
induction range there is a finite set of distinct primes `P_n` such that
`PrimeForcing(n,p)` holds for every `p in P_n` and their product exceeds the
exact integer form of the published minimal-counterexample product bound.

Response 59 displayed the intended comparison as

```text
product_{p in P_n} p
  >= ((binom(n+1,2)^(n-1))/n)^n.
```

Do not accept this typography as the theorem. Locate the primary source,
state its exact hypotheses, runner/dimension convention, strictness, floors
or ceilings, and exponent placement, and derive the required integer product
comparison from it. Reject garbled notation such as an exponent containing a
stray comma or any silent movement of the outer exponent. Identify every
external dependency that is not formalized in the project.

The exact first unsupported prime-forcing implication reported for review is:

```text
Eliminate the singleton-bad residues guaranteed in abundance by P1 under the
deletion-gcd conditions.
```

Do not accept Response 59's conclusion about the route's merit. Rank it only
after the clean-room audit.

## Clean-room falsification protocol

Use a new implementation with no copied attachment code. Record language and
version, deterministic enumeration order, exact domain, runtime, source hash,
and output hash. Include literal residue tables for the three mandatory
counterexamples so the rejection does not depend on a program. Test all
strict/closed endpoints directly. Stop at the first mismatch between prose,
formula, code, and output, and report the smallest reproducible witness.

Do not spend this turn on another broad box search. Computation must audit the
named statements or falsify a newly proposed implication.

## Required output

Return:

1. an exact status table separating independently proved, independently
   computed, conditional, conjectural, rejected, and open statements;
2. corrected fully quantified theorem statements for D1--D6,
   `NDivisibleActiveCycleBreak`, P1, P2, `PrimeForcing`, and
   `UniformPrimeForcingSupply`;
3. complete proofs for every newly accepted `proved-math` statement;
4. clean-room certificates for all three mandatory counterexamples and the
   smallest counterexample to every additional rejected claim;
5. a proof-obligation ledger naming the first unsupported implication on each
   surviving DPLP and prime-forcing route;
6. explicit tests for continuous-maximizer versus canonical-certificate
   compatibility and for active cycles avoiding the `N`-divisible coordinate;
7. a primary-source audit of the product theorem and an exact integer product
   expression, or a precise statement that this dependency remains unresolved;
8. separate stop/continue decisions for low-order DPLP counting, the active
   cycle, P1 singleton elimination, P2 sign classes, and uniform prime supply;
9. at most one recommended next Lean declaration, only if it materially
   shortens a surviving implication chain;
10. no unrestricted proof claim without a fully replayed kernel-checked main
    theorem and an independently audited equivalence chain.

The other reported first gaps may be listed for context but are not work for
this cell:

```text
Top-two: prove the second pivot succeeds in the exact compressed
fastest-pivot failure regime.

Height compression: find a height-reducing replacement whose changed-pivot
witness lifts and which is available on a substantial fraction of
structurally minimal tuples.
```
