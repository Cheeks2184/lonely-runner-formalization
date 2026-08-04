---
owner: GPT-5.6 Sol High top-level desktop orchestrator
supervising_authority: /root
launch_runtime: original browser-capable desktop Codex session
role: Research Pipeline Medium Lead - unrestricted dyadic forcing contract only
task_id: PIPE-P84-DYADIC-VALUATION-FORCING-CONTRACT-221
base_commit: 2a210d4565006c9659ec0857527b1269b9b3def1
admission: LAUNCH-READY
---

# Prompt 84: DYADIC-VALUATION-FORCING

Develop or decisively stop one independent unrestricted replacement route
after Prompt79 stopped at prime-dependent determinants. The route asks whether
one sufficiently large power of two can be forced directly, including its
full 2-adic multiplicity, rather than extracting many distinct good primes.

This is one Sol Pro research contract, not a proof claim or evidence
promotion. Only GPT-5.6 Sol High under `/root`, using the original signed-in
browser-capable desktop session, may launch it in a genuinely new conversation
with GPT-5.6 Sol and Pro effort. Sol Medium prepared the contract. Luna may
later implement one frozen verifier or local lemma; it must not perform this
proof search.

Use one major turn. Prove the sole target at every frozen quantifier and
boundary, or return the first fatal arrow and `STOP`. Do not edit a repository,
launch another agent, or claim unrestricted Lonely Runner.

## Accepted boundary and evidence labels

Use these project results only at their exact accepted scopes:

- `proved-lean`: one- and two-moving-speed LRC;
- `proved-lean`: common positive-integer scaling/gcd normalization;
- `proved-lean`: the exact positive-integer pivot-certificate equivalence;
- `proved-lean`: the real-speed conjecture is equivalent to the
  positive-integer conjecture, preserving injectivity, positivity,
  quantifiers, and the closed threshold;
- `proved-math`: under strong induction in lower dimensions, a primitive
  minimal counterexample has every deletion gcd equal to one; and
- `literature`, `external-unformalized`: the exact MSS strict-product
  consequence stated below.

Do not promote the MSS wrapper to `proved-lean`. Unrestricted LRC remains
open. Any finite computation produced in this turn is `computed finite
evidence` only.

## Exact natural thresholds

Fix `n>=3` and put

```text
N = n+1,
C_n = binom(N,2),
T_n = min {T : Nat | n^n*T >= C_n^(n*(n-1))},
E_n = min {e : Nat | T_n <= 2^e},
q_n = 2^E_n.
```

All arithmetic is in `Nat`. No real logarithm, ceiling of a real logarithm,
asymptotic estimate, or floating-point evaluation may appear in the proof.

Before using these definitions, prove:

1. the set defining `T_n` is nonempty;
2. `T_n>0` for `n>=3`;
3. the set defining `E_n` is nonempty, for example via a direct induction
   proving `m<=2^m`;
4. least-element minimality for both definitions;
5. `0<q_n` and `T_n<=q_n`; and
6. every multiplication or exponent comparison needed by the final strict
   product contradiction, without hidden natural-subtraction assumptions.

Exact scale controls are

```text
n=3: C_3=6, T_3=1728, E_3=11, q_3=2048;
n=4: C_4=10, T_4=3,906,250,000, E_4=32, q_4=4,294,967,296.
```

Recheck these in exact integer arithmetic. They show why small dyadic tests
are structural falsification only, not evidence at the actual target powers.

## Cyclic distance and exact forcing definition

For positive modulus `M`, define

```text
rho_M(x) = min(x mod M, M-(x mod M)).
```

For `q>=1`, `PowerForcing(n,q)` means:

```text
For every possibly repeated v : Fin n -> {0,...,N*q-1}, if

  (i)  for every deletion k,
       gcd(N*q, {v_i : i != k}) = 1,

  (ii) q does not divide v_i for every i,

then there exists r with 0<=r<N*q such that

       q <= rho_(N*q)(r*v_i) for every i.
```

The gcd is the common gcd of the modulus and all listed surviving
coordinates. Keep every deletion separately. The tuple may have repeated
coordinates, nonunits, collisions, zero residues before premise (ii) is
checked, and coordinates sharing factors with `N`. Do not silently replace
the deletion conditions by total gcd one or pairwise coprimality.

Badness is strict:

```text
rho_(N*q)(r*v_i) < q.
```

Equality `rho=q` is safe. Keep both cyclic sides, antipodes, reflection fixed
points, and every residue `0<=r<N*q`. There is no pivot-candidate exclusion in
this forcing definition.

## Sole unrestricted target

There is exactly one target:

```text
DYADIC-VALUATION-FORCING:
For every n>=3, PowerForcing(n,q_n).
```

The theorem is unrestricted in dimension and residue tuples. There is no
height bound and no finite-domain premise. You may decompose the proof into a
uniform base and dyadic lift, or prove the target powers directly, but a
successful disposition must close every introduced lemma. Do not replace the
target by a conditional wrapper whose missing premise is PowerForcing under a
new name.

## Exact implication chain to unrestricted LRC

Audit every quantifier and endpoint in this chain.

Fix `n>=3` and assume positive-integer LRC in every smaller moving dimension.
Suppose a positive injective `n`-speed counterexample `a` exists.

1. Divide by the common gcd to make `a` primitive.
2. The accepted deletion-gcd reduction gives

   ```text
   gcd({a_i : i != k})=1 for every k.
   ```

3. Put `q=q_n`, `M=N*q`, and reduce `a_i` modulo `M` to `v_i`. Prove exactly

   ```text
   gcd(M,{v_i : i != k})=1 for every k.
   ```

4. If `q` divides no speed, prove it divides no residue `v_i`. Apply the sole
   target to obtain `0<=r<M` with

   ```text
   rho_M(r*v_i)>=q for every i.
   ```

   Congruence gives the same cyclic distances for the original speeds. At
   time `t=r/M`, every circle distance is at least

   ```text
   q/(N*q)=1/N,
   ```

   including equality. This contradicts counterexamplehood.
5. Therefore some positive speed is divisible by the whole number
   `q=2^E_n`, not merely by `2`. Hence

   ```text
   product_i a_i >= q_n >= T_n.
   ```

6. By the defining property of `T_n`,

   ```text
   n^n * product_i a_i >= C_n^(n*(n-1)).
   ```

7. The MSS consequence used by this route is exactly: under lower-dimensional
   LRC, every primitive `n`-speed counterexample satisfies the strict reverse

   ```text
   n^n * product_i a_i < C_n^(n*(n-1)).
   ```

   This is a `literature`, `external-unformalized` dependency. The strict and
   weak inequalities are intentionally complementary.
8. Contradiction proves the positive-integer `n`-speed statement. Strong
   induction with the accepted bases proves positive-integer LRC, and the
   accepted real/integer equivalence transfers it to unrestricted real LRC.

The response must distinguish a proof of the new forcing theorem from this
conditional literature wrapper. Do not report the complete chain as
`proved-lean`.

## Logical-strength and route-distinction audit

This route is not Prompt67 or Prompt79's distinct-prime supply argument.
Those routes used forcing for distinct primes `p_j`. Each prime-forcing
contrapositive yielded only `p_j | product_i a_i` once, so repeating the same
prime could not supply additional valuation; prime powers were prohibited
there because no multiplicity conclusion had been proved.

Here the proposed theorem itself uses modulus `N*2^E` and excludes divisibility
by the entire `q=2^E`. Its contrapositive yields

```text
2^E divides some positive speed,
```

and therefore supplies the full dyadic valuation in one step. This is a new
claim, not an iteration of prime forcing. Do not assume that
`PrimeForcing(n,2)` iterates, that `PowerForcing(n,q)` implies
`PowerForcing(n,2q)`, or that separate divisibilities by `2` accumulate on one
coordinate.

Perform both directions of the anti-tautology audit:

1. Unfold the exact positive-integer pivot equivalence and determine whether
   `DYADIC-VALUATION-FORCING` is a genuinely stronger modular theorem or is
   merely unrestricted LRC restated for encoded tuples.
2. If deriving PowerForcing from lower-dimensional LRC, identify every step
   handling repeated residues, lack of injectivity, deletion gcds, and the
   fixed dyadic modulus. A proof that first assumes the `n`-dimensional LRC
   conclusion is circular.
3. If the only proof of the dyadic lift assumes the desired `2q`-scale safe
   residue, return `STOP` and name the exact hidden occurrence.
4. A theorem that applies only when every `v_i` is a unit, distinct, odd, or
   below a height cutoff does not prove the target.

## Mandatory Attack A: direct dyadic lifting and 2-adic collision classes

Attempt an exact scale lift. You may seek a theorem of the shape

```text
PowerForcing(n,q) -> PowerForcing(n,2*q)
```

for powers of two, but do not assume it is true.

Given `v mod N*(2q)`, reduction modulo `N*q` preserves every deletion gcd, but
the premise

```text
2q does not divide v_i
```

does not imply

```text
q does not divide v_i.
```

Coordinates with exact dyadic valuation `v_2(v_i)=v_2(q)` are the first
obstruction. Classify all coordinates by `min(v_2(v_i),v_2(2q))`, including
zero, and show exactly which reduced tuple satisfies which induction premise.

For any lower-scale numerator, enumerate all lifts in the fiber modulo
`N*(2q)`. Derive the exact cyclic-distance transformation on both sides of the
circle. Track:

- whether the numerator lift changes a phase by `0` or `N*q`;
- parity of each coordinate and collisions among lifted bad fibers;
- equality at distances `q` and `2q`;
- antipodes and fixed points;
- primes dividing `N` and nonunit coordinates;
- repeated coordinate residues; and
- all deletion gcd conditions after every reduction or quotient.

A union bound must count actual labelled bad fibers and remain strict. A
choice of one binary lift must work simultaneously for all coordinates.
If a stronger induction invariant is needed, state it before using it and
test whether it is genuinely narrower, false on the mandatory fixtures, or
equivalent to the target. Close the invariant in the same turn or stop.

Also prove a uniform base if the route uses induction on `E`. The vacuous fact
`PowerForcing(n,1)` is useless because `1` divides every coordinate; it cannot
serve silently as the base for `q=2`.

## Mandatory Attack B: independent minimal-cover and CRT route

Independently assume `PowerForcing(n,2^E)` fails. Define labelled strict bad
sets

```text
B_i={r mod N*2^E : rho_(N*2^E)(r*v_i)<2^E}.
```

They cover the full residue ring. Choose a least-cardinality labelled cover
and then the lexicographically least owner list. Prove every selected owner
has a relative private residue; do not treat relative privacy as global
safety.

Use the exact CRT decomposition available when `N` is not necessarily odd:
you may not write `Z/(N*2^E)` as a direct product of `Z/N` and
`Z/2^E` unless their gcd is one. Instead separate the 2-primary part of `N`,
or use compatible congruence fibers with the full gcd retained.

Exploit, or show the insufficiency of:

- at least two coordinates being units modulo each prime divisor forced by
  the every-deletion gcd premise;
- the distribution of exact 2-adic valuations among selected owners;
- translation by half-modulus and reflection;
- owner-labelled private fibers;
- intersection incompatibilities between valuation classes; and
- a possible minimal full-cover deletion or uncrossing argument.

The conclusion must be an uncovered residue at threshold `2^E`, not a
prime-dependent determinant, a zero annihilator, an average that can vanish,
or a cover inequality already equivalent to PowerForcing. If Attack B only
rephrases noncoverage, say so and stop it.

## Mandatory falsification and boundary suite

Reimplement definitions literally or use transparent exact pseudocode. The
canonical enumeration is tuple lexicographic over
`{0,...,N*q-1}^n`, then numerator increasing. Check every deletion gcd before
the `q`-divisibility exclusions. Record premise count, failure count, and the
lexicographically first failure with its covering owner sets.

Required controls:

1. repeated coordinates that satisfy the premises;
2. coincident labelled bad sets;
3. a tuple failing exactly one deletion gcd;
4. zero and `q`-divisible coordinates rejected by premise (ii);
5. nonunits and coordinates sharing factors with `N`;
6. `rho=q-1` bad and `rho=q` safe;
7. antipodes, both cyclic sides, common unit scaling, and permutations;
8. reduction from original positive speeds modulo `N*q`; and
9. the exact odd-modulus warning

   ```text
   n=3, q=5, N*q=20, v=(1,3,4),
   ```

   which satisfies the forcing premises but is a failure. Therefore arbitrary
   moduli and arbitrary primes do not satisfy `PowerForcing`.

The following are contract-design observations from a root literal preflight,
not accepted evidence:

| `(n,q)` | reported premise count | reported failures |
| --- | ---: | ---: |
| `(3,2)` | 64 | 0 |
| `(3,4)` | 1,280 | 0 |
| `(3,8)` | 13,312 | 0 |
| `(3,16)` | 118,784 | 0 |
| `(4,2)` | 608 | 0 |
| `(4,4)` | 43,776 | 0 |

Independently specify and reproduce or reject these counts. Do not cite them
as verified. They do not reach `q_3=2048` or `q_4=2^32` and do not prove a
uniform theorem.

You may add at most one new bounded domain. Choose it before execution and
justify why it distinguishes a proposed dyadic lift or valuation invariant.
Do not spend the turn enlarging a scan. Any verifier plan must include:

- exact finite types and tuple/numerator order;
- strict/closed boundary behavior;
- success, failure, equality, repeated-residue, collision, and malformed
  fixtures;
- one deliberately altered expected count that must fail;
- complete-domain termination and first-failure reporting;
- deterministic source/output hashing; and
- an independent literal-versus-optimized comparison.

No finite result is a theorem or unrestricted evidence.

## Required response format

Return exactly these sections.

1. **Disposition** -- `PROVE`, `PIVOT`, or `STOP`.
2. **Exact definitions and threshold arithmetic** -- existence and minimality
   of `T_n,E_n`, exact `q_n>=T_n`, and `n=3,4` controls.
3. **Logical-strength audit** -- comparison with LRC, Prompt67/79, and any
   hidden prime-forcing iteration.
4. **Attack A: dyadic lift** -- full fiber formulas, valuation classes,
   boundaries, base case, and first unsupported arrow or complete proof.
5. **Attack B: minimal cover/CRT** -- independent proof or first unsupported
   arrow with noncoprime CRT handled exactly.
6. **Falsification report** -- every mandatory fixture, exact preflight-count
   reproduction or rejection, and at most one declared new domain.
7. **Sole theorem proof or STOP certificate** -- a complete proof of
   `DYADIC-VALUATION-FORCING`, or one minimal counterexample to it, or the
   exact fatal lemma preventing completion.
8. **Complete implication chain** -- primitive counterexample through MSS and
   real LRC, with every evidence label and strict endpoint.
9. **Proof-obligation ledger** -- exact statement, dependency, status,
   falsification, first open arrow, and recommended owner.
10. **Verifier plan** -- one frozen literal architecture and independent
    checker plan; no repository edit or implementation.
11. **Final evidence boundary** -- separate `proved-lean`, `proved-math`,
    `literature/external-unformalized`, response-authored computation,
    computed finite evidence, conditional, rejected, and open.

`PROVE` requires a complete proof at all quantifiers. `PIVOT` requires a
strictly narrower, non-tautological lemma that survives every fixture and has
an explicit chain to the sole target; it does not promote that lemma. Return
`STOP` on an exact target counterexample, an unclosed dyadic lift, a hidden
PowerForcing assumption, an LRC-equivalent restatement, or dependence on
unverified computation.

## One-turn budget and stop rules

Use the first quarter for threshold and logical-strength audit, the second for
Attack A, the third for Attack B and falsification, and the final quarter for
the theorem or STOP certificate, implication chain, obligations, and verifier
plan.

Stop immediately at a violated deletion gcd, lost owner label, cancelled
nonunit, incorrect coprime CRT split, strict/closed endpoint error, odd-modulus
fixture failure, use of `q`-divisible data inside the theorem domain, silent
prime-forcing iteration, or proof step that already assumes dyadic
noncoverage. A correct negative result is more valuable than a conditional
wrapper with the same missing premise.
