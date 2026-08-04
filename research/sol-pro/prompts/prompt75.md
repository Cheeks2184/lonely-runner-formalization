---
owner: GPT-5.6 Sol High top-level desktop orchestrator
supervising_authority: /root
launch_runtime: original browser-capable desktop Codex session
role: Research Pipeline Lead - prompt preparation only
task_id: PIPE-P75-ADVERSARIAL-SYNTHESIS-CONTRACT-156
base_commit: 6d1a06047718570d3038b8e069b493be4bf3023c
---

# Prompt 75: ADVERSARIAL-SYNTHESIS-OF-RESPONSES-68-69-70

This is one isolated reserved-cell-D adversarial synthesis contract. Audit the
three immutable recovered Sol Pro responses identified below, compare their
first fatal arrows, and decide whether any exact surviving unrestricted lemma
is genuinely narrower than Lonely Runner and materially closer to proof.

This is not a fourth broad proof search. Do not propose a new research program,
edit the repository, execute attachments, or manufacture a nearby theorem.
The required output is a one-turn adversarial research memo with exact
quantifiers, falsification, a proof-obligation table, and a final disposition.

This file is a prepared contract only. It is not a browser launch, active Pro
cell, recovered response, proof, audit result, or status promotion. Only GPT-5.6
Sol High under `/root`, using the original signed-in browser-capable desktop
session, may start the genuinely new ChatGPT conversation, explicitly select
GPT-5.6 Sol with Pro effort, recover the result, and decide its status.

## Immutable inputs and provenance boundary

Read the following recovered response texts as claims to audit, not as accepted
mathematics:

| Input | Immutable commit | Repository path | SHA-256 of exact blob bytes |
|---|---|---|---|
| Response68 | `23ca5b89b13ae879c546598d7b56888a92fc39f2` | `research/sol-pro/responses/response68.md` | `d8b3b8fbf4037690a53f6a79318e18d5cc7ea8ec00a8d93bb89072567ef27cc0` |
| Response69 | `ed08c419d83b9f46daf7d30894c4b578098544f0` | `research/sol-pro/responses/response69.md` | `9ade57c8530b89bb3fc60b48b740d619245f6eafb9b21801de11735ba51abdf1` |
| Response70 | `7ca41ed3b537d6270ad07de52fdaf44e80b73f7d` | `research/sol-pro/responses/response70.md` | `d8ec6af6c38fa49b938778b8114567bad8eb04a34738da25740a525d35cfadd9` |

Line references below are to those exact Markdown blobs, numbered from one.
Any attached Python or JSON file is evidence for a reported computation only.
Do not execute it and do not treat it as proof of a universal claim. The
reported attachment hashes are:

- Response68: source
  `ffcadeab525c63faee8548389b8460c1730ee7ea51039ba8dcb1463d16ef9004`,
  output
  `b85677d9487220a2b7f0c5438dcb021372a30b6e75761f8fc972b8b7001375f9`;
- Response69: source
  `d8362aec4061ac06d91bb693b132a0b8399978cbc283b024bfa2a88dbd7fb9f7`,
  output
  `3fe8d4b0eabce987f418c8e0d60881a1af6fd27f1aa79a70e611da1492ec2952`;
- Response70: source
  `0b9c3dc443c1fc1689736edf1b860e149d9c8eb8d7efe8a68dc02d7dc2520e46`,
  output
  `32d1fdc80dd68744912f6d11b552b6f826c0f500841960ec40820a871a5bd4f3`.

Preserve every repository evidence label at exact scope. A response's own
`proved-math`, `conditional`, `computed finite evidence`, `PIVOT`, or `STOP`
label is a claim to review, not an accepted promotion. The unrestricted Lonely
Runner Conjecture remains `open`. The known canonical equivalences are
`proved-lean`; none supplies the missing existential pivot certificate.

## Frozen pivot definitions and boundary

For `n >= 1`, put `N=n+1`. Let

```text
a : Fin n -> Nat
```

be positive and injective. For pivot `j`, put `p_j=a_j`, `M_j=N*p_j`, and

```text
rho_M(x) = min(x mod M, M-(x mod M)),
R_j = {r in {0,...,M_j-1} : N does not divide r},
B_i^j = {r in R_j : rho_(M_j)(r*a_i) < p_j}  for i != j.
```

Badness is strict `< p_j`; equality is safe. Retain both cyclic sides,
nonunits, repeated modular residues, coincident owner sets, and owner-indexed
multiplicity. A pivot certificate is a pair `(j,r)` with `r in R_j` and
`r` in no `B_i^j`. `FullCover_j(a)` means the owner bad sets cover all of
`R_j`. Do not replace these definitions by an asymptotic or continuous model.

These pivot-certificate definitions govern Audits B and C and the final LRC
implications. Response68 Audit A begins in a different finite problem. There,
for `n >= 3`, `N=n+1`, prime `p`, and `M=N*p`, an admissible tuple is

```text
v in (Z/MZ)^n,
p does not divide v_i for every i,
gcd(M, {v_i : i != k}) = 1 for every deletion k,
```

with repetitions allowed, and

```text
B_i(v) = {r in Z/MZ : rho_M(r*v_i) < p}.
```

`PrimeForcing(n,p)` asserts that these bad sets do not cover the whole group
`Z/MZ`. There is no candidate subset `R_j` and no exclusion of `N`-multiples
in this definition. Do not transfer a restriction from one setting to the
other. In particular, a PrimeForcing failure tuple is a modular tuple `v`
depending on `p`; it is not definitionally a positive injective integer speed
tuple `a` or a pivot cover at one of its coordinates.

## Audit A: Response68 local arithmetic and Fourier claims

Independently reconstruct and audit the following statements. Do not cite the
response's prose as its own proof.

### A1. N-divisible-coordinate conclusion

Response68 lines 321--345 use

```text
rho_(N*p)(p*x) = p*rho_N(x)
```

and the group residue `r=p` to claim that every PrimeForcing failure tuple has
an `N`-divisible coordinate. Lines 349--357 claim that the deletion condition
strengthens this to

```text
1 <= #{i : N divides v_i} <= n-2.
```

State the complete theorem with every domain condition: the meaning of
`admissible`, the prime and dimension ranges, nonzeroness modulo `p`, the fact
that repetitions are allowed, and the exact deletion hypothesis. Verify the
identity, that `r=p` is a valid residue of the full group `Z/(Np)Z` for every
prime `p` (including when `N` divides `p`), and both bounds. Explicitly forbid
using the pivot condition `r in R_j` or testing `N` does not divide `r` here.
The conclusion concerns a prime-dependent modular failure tuple, not yet a
fixed positive-integer counterexample. Pay special attention to `n=2` and to
any silent use of `p>N` or `gcd(p,N)=1`; Response68 says this conclusion does
not require `p>N`.

### A2. CRT-capacity formula

Response68 lines 361--452 begin a separate `p>N` case, infer
`gcd(p,N)=1`, and define exactly

```text
b_i = v_i mod p in (Z/pZ)^x,
c_i = v_i mod N,
d_i = gcd(N,c_i),
```

where the gcd must be interpreted using a canonical integer representative of
`c_i` (equivalently it is invariant under changing that representative by a
multiple of `N`). It does **not** define `c_i=b_i^{-1}v_i mod N`; that
expression improperly mixes the two CRT factors and must not be introduced.
Re-derive the claimed set equality and cardinality using only the exact
definitions above.

List explicitly:

- the domains of `x`, `y`, and every residue representative;
- why `b_i` is invertible;
- the canonical-representative convention for `c_i` and why `gcd(N,c_i)` is
  representative-independent;
- why this equals `gcd(N,v_i)` for an integer representative of the original
  residue, without multiplying by `b_i^{-1}`;
- strict versus closed endpoint behavior in each lifted fiber;
- whether the allegedly disjoint pieces are actually disjoint for all allowed
  `N,p,d_i`;
- the exact formula for one fiber and one whole `N`-divisible column; and
- precisely what the capacity inequality proves, without turning it into a
  determinant or signature conclusion.

Response68 lines 473--485 explicitly say that the relevant ratios still vary
through `F_p`, no fixed nonzero determinant or finite signature has been
obtained, and choosing `Delta=p` is circular. Identify the first unsupported
arrow after the valid CRT formula. If any premise or count is false, give the
least exact counterexample and mark the downstream claim rejected.

### A3. Bounded-annihilator theorem

Response68 lines 493--680 claim a tent-function/Fourier theorem of the form:

```text
For n >= 3, N=n+1, prime p, and b in (F_p^x)^n,
if for every x in F_p there exists i with rho_p(x*b_i) < p/N,
then there is c in Z^n, c != 0, ||c||_infinity <= H_n,
and sum_i c_i*b_i = 0 mod p.
For p>H_n the support of c has size at least two.
```

The rendered constant at Response68 line 511 is ambiguous. Reconstruct the
literal intended formula—apparently

```text
H_n = 2*n*5^(n-1)*4^n + 1
```

but do not assume that reading without checking every subsequent inequality.
If the text does not determine a unique constant, say so and audit the
strongest unambiguous bound actually proved.

Check the tent support including zero endpoints, normalization of every
Fourier coefficient, absolute convergence needed for termwise finite-field
averaging, the tail estimate, the pigeonhole step that extracts a nonzero
frequency vector, the sup-norm constant, and the support-at-least-two claim.
State exactly how strict modular badness corresponds to the tent's support.
Classify the theorem no higher than `conditional` unless you supply a complete
independent proof in this memo.

### A4. Finite rational-hyperplane corollary

Response68 lines 682--732 claim that every fixed positive-integer LRC
counterexample lies on one of finitely many rational hyperplanes

```text
c dot a = 0,
c != 0,
||c||_infinity <= H_n.
```

Audit the reduction to infinitely many primes, the stabilization of `c`, and
the passage from congruence modulo arbitrarily large primes to equality in
`Z`. State all requirements on the prime set. Determine whether positivity
forces `c` to have both positive and negative coefficients and whether zero
coordinates in `c` are allowed.

Reconstruct this corollary by sampling the fixed integer counterexample at
times `x/p` and applying A3 to `b_i=a_i mod p` for primes larger than every
speed. Do not assert that the fixed speed tuple is an A1/A2 admissible
PrimeForcing tuple, and do not identify its sampled obstruction with a pivot
`FullCover_j`. If any deletion-gcd or PrimeForcing hypothesis is used, name and
justify it; the displayed argument in Response68 purports not to require one.

Then enforce Response68's own fatal boundary at lines 734--752: one bounded
relation is only necessary. A hyperplane exists over every finite field; one
congruence does not make a prime divide a fixed nonzero determinant. No
cofinite-prime conclusion follows without an additional independent relation
or an exclusion theorem on every surviving rational subtorus.

## Audit B: compare Response70's common-prime mechanism

Audit only the claims material to synthesis:

1. The exact full-cover equivalence at Response70 lines 71--86.
2. The coarse divisor-cover implication at lines 127--169, including the
   statement that simultaneous covers force an `N`-divisible coordinate but
   one such coordinate blocks the same coarse candidates at every other
   pivot.
3. Singleton-cover rigidity at lines 215--294.
4. The strict-growth functional-digraph consequence at lines 298--325:
   simultaneous full covers force at least one genuinely multiowner pivot.
5. The exact partition at pivot `2` of `(1,2,3,5)` at lines 327--357, which
   refutes private-point-to-owner/pivot-gcd propagation.
6. The common-modulus Fourier pullback at lines 541--571, which preserves
   separate annihilation equations but supplies no justified coupling.
7. The logical-strength warning at lines 807--812: given the existing
   equivalences and normalization wrapper, the simultaneous-full-cover
   common-prime theorem both implies LRC and is vacuously implied by LRC.

Do not treat Response70's `PIVOT` as an accepted disposition. Explicitly test
whether its open common-prime statement is simply equivalent to unrestricted
LRC rather than a narrower bridge. Preserve the reported rejections:

- `n-1` full pivots do not force a common prime;
- a private candidate does not force an owner/pivot common prime; and
- a full pivot need not contain a nonunit owner.

## Audit C: compare Response69's STOP result

Response69 reports no finite counterexample to its proposed compensation
inequality, but stops because its transport argument does not prove destination
safety. Audit and use the exact distinction:

- line 5 gives `STOP`, finite evidence only, and names the first fatal arrow;
- lines 18--20 claim only a conditional scaling identity, a one-owner cover
  characterization, and an `n=2` special case;
- lines 24--29 reject the nearest-boundary exchange, leave injection/charge and
  weighted compensation open, and keep the LRC implication conditional;
- line 31 promotes no new claim;
- the first fatal token/nearest-boundary failure is developed around lines
  382--472;
- the first fatal charge arrow is identified around line 544; and
- the final implication chain remains conditional through the end of the
  response.

Explain whether Response69 and Response70 fail for the same mathematical
reason—lack of a cross-pivot conservation or coupling law—or merely share a
vague verbal resemblance. An injection or charge must map to an actually safe
destination with exact owner multiplicity; a private point or Fourier support
component does not supply that fact.

## Required synthesis decisions

For each pair `(68,69)`, `(68,70)`, and `(69,70)`, answer all of the following.

1. Are the first missing lemmas logically identical after unfolding exact
   definitions?
2. Does either lemma imply the other under already accepted hypotheses?
3. Do they only share a weaker prerequisite? State that prerequisite with
   full quantifiers.
4. Is any claimed bridge equivalent to unrestricted LRC because its
   antecedent is exactly the absence of a pivot certificate?
5. Does one response's valid local theorem close a named edge in another?
   Give the complete implication or say no.
6. Does a cited counterexample decisively stop the proposed implication?

The verbal phrase “cross-pivot coupling” is not an answer. Translate it into a
specific map, equality, inequality, divisibility statement, rank statement,
or quantified selection principle, then test that statement.

## Candidate finite-hyperplane bridge: mandatory anti-tautology test

The most obvious synthesis of Response68 with the pivot equivalence is:

```text
FIXED-BOUNDED-HYPERPLANE-PIVOT:
For every n >= 3 and every c in Z^n with
  c != 0 and ||c||_infinity <= H_n,
every positive injective a in N^n satisfying c dot a = 0
has a pivot certificate.
```

If positivity makes mixed signs necessary, state that restriction exactly.
This is a finite family of unrestricted-height subproblems for fixed `n`, but
combined with Response68's claimed necessary hyperplane theorem it immediately
proves LRC. Conversely LRC proves every member. Therefore “finitely many
hyperplanes” by itself may be only a decomposition of LRC, not a closer bridge.

You must decide, with proof, whether this scheme or any variant you propose is:

- a literal equivalent reformulation;
- a strictly stronger theorem;
- a strictly weaker theorem that does not close LRC;
- or a genuinely narrower missing lemma whose proof uses additional structure
  supplied by Responses 69 or 70.

Do not call the finite list material progress merely because the coefficient
vectors are bounded. To qualify as genuinely narrower, exhibit an exact extra
restriction on the counterexample hyperplane, cover system, or relation vector
that follows independently from audited claims and rules out a nonempty class
of arbitrary hyperplane instances. Then prove both the restriction and the
complete implication chain.

Examples of assertions requiring explicit falsification—not suggestions to
assume—include:

- the bounded relation forces a singleton cover at some pivot;
- it forces a common prime in a multiowner cover;
- it supplies destination safety for Response69's injection;
- two pivot-local Fourier relations are linearly independent;
- a second relation follows from deletion minimality; or
- a fixed hyperplane excludes simultaneous full covers.

For each attempted assertion, search first for a least small positive injective
tuple satisfying its premises but not its conclusion. A tuple with a pivot
certificate can still refute an intermediate universal assertion; distinguish
that from an LRC counterexample.

## Sole permitted positive deliverable

After the audits, output at most one exact surviving lemma. It must have all
quantifiers, domains, strict boundaries, and dependencies frozen. It qualifies
only if all four tests pass:

1. **Unrestricted:** no height cutoff, finite scan premise, tuple-dependent
   coefficient bound beyond the audited `H_n`, or unproved cofinite-prime
   hypothesis.
2. **Non-tautological:** neither the statement nor one of its hypotheses says
   that some pivot certificate exists or that simultaneous full cover is
   impossible.
3. **Strictly narrower:** its complete implication to LRC uses at least one
   independently audited theorem from Responses 68--70, and the lemma itself
   does not become vacuously equivalent to LRC after unfolding.
4. **Falsification-surviving:** all mandatory fixtures and every new small
   search or hand counterexample test pass at their declared scope.

If no lemma passes, the required result is `STOP`, not an invented replacement.
You may identify a shared prerequisite as `open` even when it is not close
enough to occupy a new Pro cell.

## Mandatory falsification suite

At minimum, recompute by hand or transparent pseudocode the relevant claims on:

1. `(1,2,3,5)`, especially pivot `2`, where the owner bad sets partition the
   candidate set and all owners are coprime to the pivot.
2. `(1,2,3,4,5,7)`, with four full pivots but primitive global gcd.
3. `(1,3,4,5,7,18)`, pivot `7`, fully covered although every owner is a unit
   modulo `49`.
4. `(4,5,9)`, where first bad-set masses equal candidate masses but overlap
   leaves gaps.
5. `(1,3,4)`, the Response69 nearest-boundary exchange failure.
6. The Response70 all-but-one infinite family for general `n`, not just one
   numerical instance.
7. At least one tuple lying on a small mixed-sign rational hyperplane and still
   having a pivot certificate, to show that a relation alone does not encode
   obstruction.
8. Boundary cases `n=1`, `n=2`, `rho=p-1`, and `rho=p`.

If you write scratch code, include complete source inline or as a separately
hashed attachment and state its exact finite domain, deterministic ordering,
interpreter version, and first-failure convention. Such output is only
`computed finite evidence`; it cannot promote a universal lemma.

## Required response format

Return exactly these sections.

### 1. Disposition

Choose one:

- `PROMISING`: one exact surviving lemma passes all four positive-deliverable
  tests and has a credible proof plan with a named first open edge;
- `MIXED`: at least one local Response68--70 theorem survives independent
  audit and materially sharpens dependency knowledge, but no qualifying bridge
  survives; or
- `STOP`: the proposed synthesis is false, equivalent to LRC, or supplies no
  narrower actionable lemma.

### 2. Independent claim audit

A table with columns:

```text
Response/lines | exact reconstructed claim | independent verdict |
proof or least counterexample | evidence label | dependencies
```

Include every A1--A4, B1--B7, and material Response69 claim named above.

### 3. Pairwise implication matrix

For all ordered pairs among the three first missing arrows, record `implies`,
`does not imply`, or `unknown`, with proof or countermodel. State any shared
prerequisite exactly.

### 4. Anti-tautology audit

Unfold the fixed-hyperplane scheme and Response70 common-prime theorem through
the canonical pivot equivalence. Say precisely which statements are equivalent
to LRC, conditional decompositions of it, or strictly narrower.

### 5. Falsification results

Give exact outputs for the mandatory suite, distinguish theorem-domain
counterexamples from synthetic verifier negatives, and preserve strict boundary
semantics.

### 6. Sole surviving lemma or STOP certificate

State at most one lemma in full formal quantifier order. Give its complete
implication chain, the single unresolved proof obligation, why it is genuinely
narrower, and a direct falsification plan. Otherwise give a concise STOP
certificate naming the first fatal arrow and the evidence that prevents repair.

### 7. Proof-obligation ledger

Use columns:

```text
ID | exact statement | source/dependency | status | evidence | first open arrow |
falsification | implication to unrestricted LRC | recommended next owner
```

No item may be hidden behind “standard”, “clearly”, “generic”, or “by
compactness”. Separate local arithmetic, Fourier analysis, finite computation,
and global logical implications.

### 8. Recommended route disposition

For each of Responses 68, 69, and 70 choose `continue`, `freeze`, or `stop`,
with one precise reason. Recommend whether any downstream declaration-level
audit is worth Sol Medium specification. Do not assign Luna novel proof search.

### 9. Final evidence boundary

List separately:

- repository `proved-lean` inputs;
- independently established `proved-math` claims, if any;
- `computed finite evidence` at exact finite scope;
- `conditional` claims;
- `rejected` implications; and
- remaining `open` obligations.

Do not claim unrestricted LRC. Do not promote a result because it appeared in a
prior Pro response, because code ran, or because a conditional wrapper is
complete. The final Sol High disposition and any repository integration remain
outside this Pro turn.

## Stop and budget rules

This is one Pro turn. Spend the budget on independent checking and logical
comparison, not on polishing or a new broad proof attempt. Stop immediately on
a route when:

- its exact lemma has a counterexample;
- it unfolds to LRC or the pivot-certificate equivalence;
- its proof requires an unproved second relation, destination-safety law, or
  common-prime selector under a new name; or
- its only support is a finite scan.

If the bounded-annihilator proof cannot be reconstructed from the response text
because the formula or normalization is ambiguous, record the exact ambiguity
and keep it `conditional`; do not silently repair it. A rigorous `MIXED` or
`STOP` memo is a successful response.
