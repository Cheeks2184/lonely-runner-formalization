---
owner: GPT-5.6 Sol High top-level desktop orchestrator
supervising_authority: /root
launch_runtime: original browser-capable desktop Codex session
role: Medium - prompt preparation only
---

# Prompt 68: COFINITE PRIME FORCING

This is one isolated unrestricted Sol Pro research contract. Work only on the
cofinite prime-forcing theorem below, or decisively refute it. Do not replace
it by bounded-height coefficient optimization, a dimension census, a broad
survey, or the former finite-signature formulation. This prompt is not a
launch record, proof, computation, response, or status promotion.

Use `proved-lean`, `proved-math`, `computed finite evidence`, `conditional`,
`conjectural`, `rejected`, `open`, `literature`, and
`external-unformalized` strictly. Give every claim one exact status. Recovered
Response67 labels and computations are adversarial inputs, not accepted
results. No theorem or computation is promoted without independent audit and
`/root` approval.

## Exact definitions

Fix an arbitrary natural `n>=3` and put `N=n+1`. For `M>0`, define

```text
rho_M(x) = min(x mod M, M-(x mod M)),
```

using the canonical residue in `{0,...,M-1}`.

For a natural prime `p`, put `M=N*p`. An admissible tuple is any possibly
repeated

```text
v : Fin n -> {0,...,M-1}
```

such that

```text
p does not divide v_i                                      for every i,

gcd(M, {v_i : i != k}) = 1                               for every k.
```

Each deletion gcd includes `M` and all surviving coordinates. Do not replace
it by the full-tuple gcd, pairwise coprimality, distinctness, or one selected
deletion. The case `p|N` is included.

Define the strict bad set

```text
B_i(v) = {r in Z/MZ : rho_M(r*v_i) < p}.
```

Equality `rho_M(r*v_i)=p` is safe. The full witness domain is `0<=r<M`,
including `r=0`. Then `PrimeForcing(n,p)` means:

```text
for every admissible possibly repeated v,
there exists 0<=r<N*p such that
  p <= rho_(N*p)(r*v_i) for every i.
```

Equivalently, no admissible tuple has

```text
union_i B_i(v) = Z/(N*p)Z.
```

For a failure tuple, an inclusion-minimal selected cover means an injection
`iota : Fin m -> Fin n`, with `1<=m<=n`, whose selected bad sets cover the
whole group, while deleting any one selected coordinate destroys full
coverage. Prove existence by finite deletion before using minimal-cover
properties.

## Sole unresolved target and exact logical boundary

The sole unresolved lemma is:

### `COFINITE-PRIME-FORCING`

```text
For every n>=3, there exists a natural D_n>0 such that, for every natural
prime p,

  p does not divide D_n -> PrimeForcing(n,p).
```

The quantifier order is authoritative:

```text
forall n>=3, exists D_n>0, forall prime p, ... .
```

`D_n` may depend on `n`, but not on `p` or the tuple. If there are no bad
primes, take `D_n=1`.

State and prove the elementary equivalences before using the target:

```text
COFINITE-PRIME-FORCING in dimension n

<-> only finitely many primes p fail PrimeForcing(n,p)

<-> there exists a finite exceptional prime set E_n such that every prime
    outside E_n is prime-forcing

<-> there exists a cutoff P_n such that every prime p>P_n is prime-forcing.
```

For the forward direction, every bad prime divides `D_n`, so the bad primes
are contained in its finite prime-divisor set. Conversely, for a finite bad
set use the product of its distinct primes, with empty product `1`. Derive the
cutoff statement from finiteness and conversely use the finite set of primes
at most the cutoff.

This equivalence is not structural compression. Do not market
`COFINITE-PRIME-FORCING`, an arbitrary finite exceptional set, or an arbitrary
integer `D_n` as a signature classification. In particular, encoding each
known bad prime by choosing `Delta=p` merely restates cofiniteness and is
forbidden as a claimed proof method.

Prove `COFINITE-PRIME-FORCING` at the stated unrestricted quantifiers, or
decisively refute it. A decisive refutation must give one fixed `n>=3` and
infinitely many distinct primes `p` with explicit admissible failure tuples
and complete modular-cover certificates. A failure at one prime, an unbounded
family with changing `n`, or failure of one proof device does not refute the
target.

## Exact threshold and unrestricted implication chain

Define

```text
C_n = binom(n+1,2),
T_n = min {T : Nat | n^n*T >= C_n^(n*(n-1))}.
```

Prove the exact natural-number equivalence

```text
Q>=T_n <-> n^n*Q >= C_n^(n*(n-1)).
```

Do not infer it from real floor/ceiling shorthand.

Assuming `COFINITE-PRIME-FORCING`, fix its `D=D_n` and define

```text
R_0 = 1,
q_j = the least prime divisor of D*R_j+1,
R_(j+1) = R_j*q_j,
m_n = min {m : Nat | R_m >= T_n}.
```

Prove every arrow:

```text
q_j is prime and divides neither D_n nor R_j
  -> the q_j are distinct and PrimeForcing(n,q_j) holds
  -> R_j >= 2^j, so m_n exists
  -> product_(j<m_n) q_j = R_(m_n) >= T_n
  -> UniformPrimeForcingSupply in dimension n
  -> every supplied prime divides a primitive counterexample's speed product
  -> their distinct-prime product divides that positive speed product
  -> the exact weak lower bound contradicts the strict MSS upper bound
  -> positive-integer LRC in dimension n
  -> induction from the one- and two-positive-speed bases
  -> unrestricted positive-integer LRC
  -> `conjecture_iff_positiveIntegerConjecture`
  -> unrestricted real LRC.
```

Do not abbreviate primitive reduction, every-deletion gcd one, reduction of
distinct speeds to possibly repeated residues modulo `N*p`, pairwise-coprime
product assembly, positivity, strictness, or induction indexing. At step `n`,
there are `n` positive moving speeds and `n+1` total runners; deletion leaves
`n-1` positive speeds and `n` total runners. Cite the repository one- and
two-positive-speed base declarations at exact `proved-lean` scope.

Treat `p|N` explicitly. The Response67 small-prime witness candidate is
`r=N` for `p<=N`; independently prove its cyclic-distance identity and closed
boundary before using it. If accepted, it discharges all primes with `p<=N`,
including every possible `p|N`. Only for the remaining branch `p>N` may you
use `gcd(p,N)=1` and independent CRT projections. Otherwise prove the exact
compatibility conditions without a CRT split.

The final chain remains conditional even if cofiniteness is proved. The
Malikiosis--Santos--Schymura theorem is `literature` and
`external-unformalized`; its repository Lean interface is absent. Never label
it `proved-math` or `proved-lean` here.

## Exact audited bibliography boundary

Use only these audited primary sources, only for the stated roles:

- Malikiosis--Santos--Schymura, DOI
  `https://doi.org/10.1017/fms.2025.10107`, with primary arXiv text
  `https://arxiv.org/html/2411.06903v2`: Theorem A, exact runner indexing,
  subset-gcd hypothesis, and strict product consequence.
- Rosenfeld, `https://arxiv.org/html/2512.01912v1`:
  - Theorem 1 and Corollary 2: product-bound application;
  - Lemma 3: prime-forcing-to-divisibility;
  - Lemma 4: deletion gcd one under the lower-dimensional hypothesis.

Verify hypotheses and indexing before citing any of these roles. Do not cite
or rely on arXiv `2604.23906` or `2509.14111`, and do not import claims from
another unaudited source. Literature cannot replace a proof of cofiniteness.

## Optional structural proof device: canonical signatures

Obstruction signatures are permitted only as a proof device for cofiniteness,
not as the theorem itself. Any claimed structural progress must first declare,
for each fixed `n`, before seeing the quantified prime:

```text
an explicit finite signature universe S_n,

a canonical normalization map from a stated class of minimal covers into S_n,

a canonical predeclared map
  Delta_n : S_n -> Int
given by an explicit determinant, resultant, or coefficient formula,

and a proof that Delta_n(sigma) != 0 for every realized signature.
```

It must then prove that every obstruction at prime `p` maps to some
`sigma in S_n` with

```text
p divides Delta_n(sigma).
```

Only this stronger, predeclared structure counts as genuine compression. It
must specify how the universe and map depend on `n` and why neither depends on
`p`, the tuple, enumeration results, or a post hoc exceptional list. Choosing
`Delta_n(sigma)=p`, inserting one signature per observed bad prime, or changing
the universe/map after seeing `p` is explicitly invalid. Zero determinants
must be classified or used to expose a genuine infinite-prime obstruction;
they may not be discarded.

## Two materially different attacks on cofiniteness

Develop both attacks within the fixed budget. Each attacks
`COFINITE-PRIME-FORCING` directly. There is no second permitted unresolved
lemma. If an attack proposes a stronger structural intermediate, state all its
quantifiers and explain why it is stronger than mere cofiniteness.

### Attack A: minimal-cover rigidity and compatible CRT normalization

Start from an inclusion-minimal full cover by strict bad sets. Use private
points, the exact cardinality for `d_i=gcd(N*p,v_i)`, every deletion-gcd
restriction, and the projections modulo `N` and `p`.

First discharge `p<=N`, or separately handle all `p|N` compatibility. For
`p>N`, prove `gcd(p,N)=1` before treating the projections as independent. Seek
either:

1. a direct bound, depending only on `n`, on all obstruction primes; or
2. the canonical signature universe and predeclared nonzero determinant map
   described above.

Handle repetitions, nonunit coordinates, different minimal subcovers,
independent signs, common units, CRT representatives, and equality
`rho=p`. Identify the first unsupported arrow. A prime-dependent normal form
or arbitrary obstruction integer is not progress.

### Attack B: dual/Fourier or polynomial noncoverage

Encode a full cover through an exact dual, group-algebra, Fourier, or
polynomial identity over `Z/(N*p)Z`. Seek a direct theorem that all sufficiently
large primes are nonobstructing. Alternatively derive a fixed, explicitly
predeclared finite list of nonzero integer coefficients whose divisibility
contains every obstruction prime.

Control characteristic collapse, denominators, roots of unity, strict arcs,
and primes dividing `N`. Prove coefficient degree, support, and height bounds
depend only on `n`. This attack must not reproduce Attack A's normalized CRT
matrix under different notation. If its complexity necessarily grows with
`p`, determine whether that yields a fixed-`n` infinite bad-prime family; if
not, mark the attack `STOP` at its first unsupported arrow.

## Known obstructions and mandatory falsification

Before recommending the route:

1. Reproduce admissibility and complete full-cover certificates for recovered
   candidates `n=3,p=5,v=(1,3,4)` and
   `n=4,p=7,v=(1,3,4,5)`. Aggregate Response67 counts remain unverified until
   independently replayed.
2. Include repeated tuples and coincident bad sets; do not infer a
   distinct-coordinate reduction.
3. Check every deletion gcd and every prime divisor of `N`, including `p|N`.
4. Check `r=0`, both cyclic endpoints, and equality `rho=p` as safe.
5. Test all claimed normalizations under coordinate permutation, independent
   signs, common units, different minimal subcovers, and different residue
   representatives.
6. Attempt to extend candidate obstructions across primes at one fixed `n`.
   A changing-dimension family is not a refutation.
7. For structural signatures, freeze `S_n` and the formula for `Delta_n`
   before testing primes. Reject post hoc `Delta=p` and post hoc exceptions.
8. Reject any density, cutoff, or finite-bad-prime inference drawn only from a
   finite prime interval.
9. Verify independently the `p<=N` witness and the strict insufficiency of the
   product of those small primes against `T_n`; neither proves cofiniteness.
10. Test whether a proposed intermediate is logically stronger than the
    cofinite target. If it is merely a finite exceptional set in new notation,
    label it equivalent, not structural.

Every counterexample must state the exact quantified claim rejected, domain,
ordering, all premises, and a complete cover or algebraic certificate.

## Single unresolved lemma, dispositions, and stop condition

There is exactly one permitted unresolved lemma:

```text
COFINITE-PRIME-FORCING.
```

The Euclidean extraction, threshold comparison, and conditional MSS induction
chain must be proved from it or rejected at their first invalid edge; they may
not become additional conjectures.

Return exactly one disposition:

- `BRIDGE` only if `COFINITE-PRIME-FORCING` is completely proved at its
  unrestricted quantifiers, or it is decisively refuted and a strictly
  narrower replacement is itself completely proved with the full implication
  chain.
- `PIVOT` only if a precise prime-independent structural partial theorem is
  proved that does not itself imply cofiniteness but materially narrows the
  remaining gap, or a decisive fixed-`n` infinite-prime counterexample forces
  a materially different unrestricted formulation. Any proved stronger
  sufficient theorem implying cofiniteness receives `BRIDGE`.
- `STOP` if both attacks retain prime-dependent enumeration, assume
  cofiniteness under another name, or fail to control a fixed-`n` infinite
  family.

Do not claim full LRC even under `BRIDGE`: the MSS interface remains
external-unformalized and every new result requires independent audit.

## Fixed one-turn budget and optional verifier

The budget is one major Sol Pro turn. Spend it on the two attacks and the one
cofinite target. No broad literature survey, bounded-height search, or second
research target is allowed.

An optional verifier may be used only for falsification. Before running it,
declare one fixed dimension, a finite increasing prime list, tuple ordering,
the complete repeated-tuple or explicitly bounded structural domain, strict
badness, equality behavior, and deterministic stop rules. Use at most one new
source file and one machine-readable output, test at most eight primes, and do
not expand the domain after seeing results. Report hashes and replay commands.
Every output is `computed finite evidence` only and cannot prove a cutoff.

An optional Lean prototype may formalize at most one local statement: either
the extraction from a supplied fixed `D_n>0`, or one cover-preserving
symmetry. Do not formalize MSS or attempt both. Claim `proved-lean` only after
compilation and an axiom audit.

## Required output format

Return one self-contained memo with these sections, in order:

1. **Disposition** — exactly `STOP`, `PIVOT`, or `BRIDGE`.
2. **Status table** — one strict label for every theorem, computation,
   dependency, rejection, and open statement.
3. **Exact cofinite theorem** — definitions, quantifiers, and proof of its
   finite-exception/cutoff equivalences.
4. **Attack A** — proof, stronger structural intermediate, or first fatal
   arrow.
5. **Attack B** — proof, stronger structural intermediate, or first fatal
   arrow.
6. **Falsification** — repetitions, boundaries, small-prime fixtures,
   fixed-`n` prime stability, and any canonical-signature tests.
7. **Complete implication chain** — Euclidean extraction, distinct primes,
   threshold, primitive/deletion bridge, Rosenfeld lemma roles, external MSS
   boundary, induction bases, and real reduction.
8. **Artifacts and replay** — only if an optional verifier or Lean prototype
   was used.
9. **Final boundary** — exact proved, computed, rejected, conditional, and
   open claims, with no response self-promotion.

Do not substitute a progress narrative or catalogue of approaches. The sole
goal is unrestricted cofinite prime forcing, or a decisive fixed-dimension
infinite-prime refutation.
