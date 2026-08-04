---
owner: GPT-5.6 Sol High top-level desktop orchestrator
supervising_authority: /root
launch_runtime: original browser-capable desktop Codex session
role: Research Pipeline Medium Lead - reserved adversarial synthesis contract only
task_id: PIPE-P87-DYADIC-STOP-SYNTHESIS-CONTRACT-245
base_commit: 908a91234f5b91bbe5a4d759883e233993d8c9d8
admission: REVIEW-REQUIRED
---

# Prompt 87: DYADIC COUNTERFAMILY AND C2 SURVIVOR SYNTHESIS

Independently verify one response-authored symbolic counterfamily from
Prompt84, then determine its exact consequences for the unrestricted
prime-forcing program. This is a reserved adversarial synthesis turn. It is
not a request for another broad proof search.

This file is a prepared research contract only. It is not a browser launch,
active cell, response, proof, audit, or evidence promotion. Only GPT-5.6 Sol
High under `/root`, using the original signed-in browser-capable desktop
session, may open a genuinely new signed-in ChatGPT conversation, explicitly
select GPT-5.6 Sol with Pro effort, submit a reviewed hash-locked version of
this file, recover the response, and decide status. Sol Medium prepared the
contract. Luna may later replay one frozen calculation; Luna may not perform
the synthesis or operate the browser.

Use one major turn. Re-derive every displayed identity. Treat the Prompt84
capture as an unverified external response, not as accepted mathematics.
Return `STOP` at the first false premise or hidden equivalence to LRC.

## Evidence boundary and immutable input

Unrestricted Lonely Runner remains open. Use only these accepted scopes:

- `proved-lean`: positive-integer LRC is equivalent to real-speed LRC with
  the exact closed threshold, injectivity, positivity, and quantifiers;
- `proved-lean`: the exact positive-integer pivot-certificate equivalence;
- `proved-math-qualified`: small-prime forcing for primes `p<=n+1`, the
  bad-cover equivalence, exact single-coordinate bad-set counts, the
  factorial-interval prime-product bound, and Euclidean distinct-prime
  extraction conditional on a fixed nonzero obstruction integer;
- `proved-math-qualified`: Prompt79's anchor/CRT normalization and
  private-point cross-minors, while its full determinant and displayed
  annihilator are rejected only as candidate constructions;
- `literature`, `external-unformalized`: the exact MSS strict-product
  consequence used by C2; and
- `open`: `OBSTRUCTION-EXTRACTION-DISTINCT-PRIME-SUPPLY`,
  `UniformPrimeForcingSupply`, C2 assembly, and unrestricted LRC.

Prompt84 completed with a response-authored `STOP` candidate. Its immutable
raw clipboard capture has SHA-256

```text
1b22792c0b50dc3c98853c33bbeea4d4d93088274329bd3eeb2b64bc7dd5e2e6
```

and reported 39,617 UTF-8 bytes, 39,609 characters, 1,509 CRLF separators,
a terminal CRLF, and no `sandbox:/...` reference. The response is not yet a
recovered or audited repository result. Do not cite its self-label as proof.

## Exact forcing definitions

For positive `M`, use

```text
rho_M(x) = min(x mod M, M-(x mod M)).
```

For `n>=3`, put `N=n+1`. For `q>=1`, `PowerForcing(n,q)` means:

```text
For every possibly repeated v : Fin n -> {0,...,N*q-1}, if

  (i)  for every deletion k,
       gcd(N*q, {v_i : i != k}) = 1,

  (ii) q does not divide v_i for every i,

then there exists r with 0<=r<N*q such that

       q <= rho_(N*q)(r*v_i) for every i.
```

The gcd is the common gcd of the modulus and all surviving coordinates.
Badness is strict: `rho<q`; equality is safe. There is no candidate-residue
exclusion. Coordinates may repeat, collide, be nonunits, or share factors
with `N`.

For prime `p`, `PrimeForcing(n,p)` is the same statement with `q=p` and
modulus `N*p`. The C2 route requires a finite set of **distinct primes**
`P_n`, each satisfying `PrimeForcing(n,p)`, whose product crosses the exact
MSS threshold. It never claimed that powers of one prime can replace those
distinct primes.

## Sole counterfamily theorem to audit

Independently prove or refute every quantifier of:

```text
DYADIC-POWERFORCING-COUNTERFAMILY:
For every E>=3, let q=2^E, N=5, M=5*q, and

  v_0 = 1,
  v_1 = 4,
  v_2 = M/2 - 1 = 5*q/2 - 1,
  v_3 = M/2     = 5*q/2.

Then v lies in {0,...,M-1}^4, satisfies every deletion-gcd premise,
q divides no v_i, and

  for every 0<=r<M, there exists i<4 with rho_M(r*v_i)<q.

Consequently not PowerForcing(4,q).
```

Do not replace the common deletion gcd by pairwise coprimality. Do not infer
the cover from a finite scan. The theorem is symbolic for every `E>=3`.

## Complete candidate proof data to re-derive

The following is supplied so the turn is independent of unpushed files. It is
candidate proof data, not an accepted proof.

### Domain and nondivisibility

Because `E>=3`, `q` is divisible by `8`, `M` is even, and

```text
0 < 1 < 4 < M/2-1 < M/2 < M.
```

Also `q` divides none of `1`, `4`, `M/2-1`, or `M/2`:

```text
M/2   = 2*q + q/2,
M/2-1 = 2*q + q/2 - 1,
0 < 4 < q.
```

### Every deletion gcd

If any of `v_1,v_2,v_3` is deleted, survivor `v_0=1` makes the common gcd
equal to one. If `v_0` is deleted, then

```text
gcd(M,v_1,v_2,v_3)
  divides gcd(4,M/2-1)
  = gcd(4,5*2^(E-1)-1)
  = gcd(4,-1)
  = 1,
```

because `E-1>=2`. Therefore all four separately quantified deletion gcds
are one.

### Full strict cover

Let `x` be the representative of `r` in `[0,M)`. If `r` is even, then

```text
r*v_3 = r*M/2 = 0 mod M,
rho_M(r*v_3)=0<q.
```

Now suppose `r` is odd and, for contradiction, every coordinate is safe.
Safety for `v_0=1` gives

```text
q <= x <= M-q = 4*q.
```

For odd `r`, `r*M/2=M/2 mod M`, so

```text
r*v_2 = M/2-x mod M.
```

On `q<=x<=4q`, the representative `M/2-x` lies in
`[-3q/2,3q/2]`, strictly inside the antipodal range. Hence safety for `v_2`
is exactly

```text
abs(x-5q/2) >= q,
```

which leaves only

```text
x in [q,3q/2] union [7q/2,4q].
```

On the first interval, direct reduction of `4*x` modulo `5q` shows

```text
rho_M(4*x) >= q  iff  x=q or x=3q/2.
```

On the reflected second interval, using `x' = M-x`, it shows

```text
rho_M(4*x) >= q  iff  x=7q/2 or x=4q.
```

All four endpoints are even integers because `q` is divisible by `4`.
They cannot equal the odd residue `r`. Thus one of `v_0,v_1,v_2` is strictly
bad for every odd `r`; `v_3` is strictly bad for every even `r`. The union of
the four labelled strict bad sets is all of `Z/MZ`.

Audit the subinterval split at `5q/4` and `15q/4`, both cyclic sides, every
endpoint equality, and the reflection. In particular, `rho=q` is safe; the
four equality endpoints are covered only because they are even and `v_3`
has distance zero there.

## Exact consequence audit

If the theorem survives, decide each statement separately.

1. `DYADIC-VALUATION-FORCING` from Prompt84 is false, because its universal
   quantifier includes `n=4` and its exact target is `q_4=2^32`, which belongs
   to this family.
2. Any theorem asserting `PowerForcing(4,2^E)` for every sufficiently large
   `E`, under only the frozen deletion-gcd and whole-power nondivisibility
   premises, is false.
3. The one-large-dyadic-divisor replacement for C2 is stopped. A fixed-grid
   contrapositive cannot force `2^E` into the speed product from these premises.
4. Do **not** claim that `PowerForcing(4,4) -> PowerForcing(4,8)` is refuted
   unless the antecedent is independently proved. A zero-failure scan at
   `q=4` is not a theorem.
5. The distinct-prime C2 route survives logically. The counterfamily uses the
   half-modulus for powers of two; it neither constructs an odd bad prime nor
   disproves `PrimeForcing(n,p)` for any new prime. It does not refute a finite
   set of distinct good primes with a sufficiently large product.
6. Prompt79's open prime-independent obstruction supply also survives. Its
   inputs are failures at varying prime moduli `N*p`; this one-prime-power
   family supplies neither infinitely many bad primes nor a bounded
   prime-independent obstruction integer.
7. Determine whether any candidate repair adds only a separately proved
   structural premise, or instead says that `v` is the reduction of a
   hypothetical LRC counterexample and then uses counterexamplehood to exclude
   the family. The latter is circular when its conclusion is the missing LRC
   witness. Merely renaming that premise is not salvage.

## Salvage admission gate

The default disposition after a valid symbolic counterfamily is `STOP` and
freeze of the dyadic route. Return `PIVOT` only if you state and support one
strictly narrower non-tautological lemma satisfying all of these:

- it is unrestricted in dimension/height where claimed;
- its premise is already proved independently or has one explicitly narrower
  open edge, not “comes from an LRC counterexample”;
- the counterfamily is either inside its domain and satisfies its conclusion,
  or is excluded by a proved premise whose role is shown exactly;
- it has a complete implication chain to either distinct-prime obstruction
  supply or an exact pivot certificate;
- it is not `PowerForcing` under a new name, not a fixed finite scan, and not
  an iteration of `PrimeForcing(n,2)`; and
- its one unresolved lemma is stated with every domain, strict endpoint,
  owner label, and quantifier frozen.

If no such lemma is fully specified, return `STOP`, not a menu of research
ideas.

## Mandatory adversarial checks

1. Recheck `E=3`, `q=8`, `M=40`, `v=(1,4,19,20)` literally over all
   `r=0,...,39`, including the four safe equality endpoints.
2. Exhibit every deletion gcd for that tuple separately.
3. Check common unit scaling and coordinate permutation preserve failure, but
   do not infer a larger theorem from those symmetries.
4. Explain why `q=4` is outside the family theorem: premise (ii) fails at
   coordinate `4`.
5. Explain why odd prime moduli do not admit the half-modulus parity argument.
6. Test any salvage lemma against the exact family, Prompt67's known failures
   `(n,p)=(3,5)` and `(4,7)`, Prompt79's prime-dependent determinant defect,
   repeated residues, nonunits, equality `rho=q`, and noncoprime `N,q`.
7. Reject any use of a response-authored scan as theorem evidence.

## Required response format

Return exactly these sections.

1. **Disposition** — `STOP`, or exceptionally `PIVOT`; never `PROVE LRC`.
2. **Independent counterfamily proof** — every quantifier, gcd, interval,
   parity, reflection, and strict endpoint.
3. **Literal q=8 audit** — complete residue-owner table or transparent exact
   compression with first-owner convention.
4. **Prompt84 impact table** — killed, surviving, conditional, and untouched
   statements at exact scope.
5. **Prompt67/Prompt79/C2 synthesis** — complete logical dependency graph,
   including the external MSS edge.
6. **Circularity audit** — every proposed repaired premise and whether it adds
   the LRC counterexample assumption.
7. **Optional sole salvage lemma** — exact statement, implication chain,
   single open edge, and counterfamily test; omit if none passes.
8. **Proof-obligation ledger** — statement, dependency, evidence class,
   falsification, and owner.
9. **Verifier plan** — one literal finite `q=8` replay and an independent
   symbolic-proof checklist; no repository edit.
10. **Final evidence boundary** — separate accepted prior scopes, this
    response's reasoning, unverified computation, rejected route, surviving
    open routes, and unrestricted LRC.

## Budget and stop rules

Spend at most one quarter on literal `q=8`, one quarter on the symbolic proof,
one quarter on consequence/circularity analysis, and one quarter on the exact
ledger and optional salvage gate.

Stop on an incorrect deletion gcd, lost owner label, weak/strict endpoint
swap, division by two before proving integrality, false parity at an equality
endpoint, hidden use of the LRC conclusion, or any claim that a power-of-two
counterfamily by itself refutes distinct-prime supply.

