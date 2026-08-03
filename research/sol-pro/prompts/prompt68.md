---
owner: GPT-5.6 Sol High top-level desktop orchestrator
supervising_authority: /root
launch_runtime: original browser-capable desktop Codex session
role: Medium - prompt preparation only
---

# Prompt 68: PRIME-INDEPENDENT OBSTRUCTION EXTRACTION

This is one isolated unrestricted Sol Pro research contract. Work only on the
prime-independent finite obstruction-signature bridge defined below, or give a
decisive counterexample to that exact formulation. Do not replace it by
bounded-height coefficient optimization, a dimension census, or a broad
survey. This prompt is not a launch record, proof, computation, response, or
status promotion.

Use `proved-lean`, `proved-math`, `computed finite evidence`, `conditional`,
`conjectural`, `rejected`, `open`, `literature`, and
`external-unformalized` strictly. Give each claim its exact status. Response67
self-labels and recovered computations are inputs for adversarial checking,
not automatically accepted results. No theorem or computation is promoted
without independent audit and `/root` approval.

## Exact theorem and unrestricted classification

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

Define

```text
B_i(v) = {r in Z/MZ : rho_M(r*v_i) < p}.
```

Badness is strict `<p`; equality `rho_M(r*v_i)=p` is safe. The full witness
domain is `0<=r<M`, including `r=0`. Then `PrimeForcing(n,p)` means that every
admissible tuple has an `r` with

```text
p <= rho_M(r*v_i)                                         for every i,
```

equivalently, no admissible tuple satisfies

```text
union_i B_i(v) = Z/MZ.
```

For a failure tuple, an inclusion-minimal selected cover consists of

```text
1 <= m <= n,
an injection iota : Fin m -> Fin n,
union_(j : Fin m) B_(iota j)(v) = Z/MZ,
```

with full coverage destroyed after deleting any selected coordinate.

For `H>=1`, an `H`-bounded obstruction signature is fixed integer data

```text
sigma = (m_sigma, c_sigma, z_sigma, Delta_sigma)
```

where

```text
1 <= m_sigma <= n,
c_sigma : Fin m_sigma -> {0,...,N-1},
z_sigma : Fin m_sigma -> Int,
|z_sigma(j)| <= H,
Delta_sigma : Int,
Delta_sigma != 0.
```

A failure tuple `v` at prime `p` realizes `sigma` if there exist an
inclusion-minimal cover `iota`, a unit `u` modulo `N*p`, and signs
`epsilon_j in {-1,+1}` such that, for every selected coordinate,

```text
u*epsilon_j*v_(iota j) == c_sigma(j)  (mod N),
u*epsilon_j*v_(iota j) == z_sigma(j)  (mod p),
p divides Delta_sigma.
```

The unit and signs may depend on `(p,v)`; `H`, `sigma`, and `Delta_sigma` may
depend on `n` but must not depend on `p` or `v`. Coordinate permutations,
independent sign changes, and common multiplication by a unit must be justified
as cover-preserving operations, not assumed silently.

The single unresolved lemma is:

### `FINITE-OBSTRUCTION-SIGNATURE-CLASSIFICATION`

```text
For every n>=3, there exist H_n>=1 and a finite set Sigma_n of
H_n-bounded obstruction signatures such that, for every natural prime p and
every admissible possibly repeated tuple v,

  union_i B_i(v) = Z/(N*p)Z

implies that v realizes some sigma in Sigma_n.
```

The quantifier order is authoritative:

```text
forall n, exists H_n, exists finite Sigma_n,
  forall prime p, forall admissible v,
    full cover by the B_i(v) -> exists sigma in Sigma_n realized by v.
```

In particular, `Sigma_n` is prime-independent and every obstruction prime
divides one fixed nonzero integer

```text
D_n = product_(sigma in Sigma_n) Int.natAbs(Delta_sigma) > 0.
```

Prove this lemma at the stated quantifiers, or decisively refute it. A decisive
refutation must give some fixed `n>=3` and infinitely many distinct primes
`p` with explicit admissible failure tuples and complete cover certificates.
A failure at one prime, an unbounded family with changing `n`, or failure of a
particular normalization method does not refute the lemma.

## Exact threshold and implication chain

Define

```text
C_n = binom(n+1,2),
T_n = min {T : Nat | n^n*T >= C_n^(n*(n-1))}.
```

Use only the exact natural-number minimum and cross-multiplied inequality. If
you use `Q>=T_n`, prove its equivalence to

```text
n^n*Q >= C_n^(n*(n-1)).
```

Do not infer it from real floor/ceiling shorthand.

If the classification holds, set `D=D_n` and define

```text
R_0 = 1,
q_j = the least prime divisor of D*R_j+1,
R_(j+1) = R_j*q_j,
m_n = min {m : Nat | R_m >= T_n}.
```

Prove every arrow in this chain:

```text
finite signatures with nonzero Delta_sigma
  -> every obstruction prime divides fixed D_n
  -> q_j is prime and divides neither D_n nor R_j
  -> the q_j are distinct and PrimeForcing(n,q_j) holds
  -> R_j >= 2^j, so m_n exists
  -> product_(j<m_n) q_j = R_(m_n) >= T_n
  -> UniformPrimeForcingSupply in dimension n
  -> every supplied prime divides a primitive counterexample's speed product
  -> their distinct-prime product divides that positive speed product
  -> exact weak lower bound contradicts the strict MSS upper bound
  -> positive-integer LRC in dimension n
  -> induction from the one- and two-positive-speed bases
  -> unrestricted positive-integer LRC
  -> `conjecture_iff_positiveIntegerConjecture`
  -> unrestricted real LRC.
```

Do not abbreviate primitive reduction, every-deletion gcd one, reduction of
distinct speeds to possibly repeated residues modulo `N*p`, the case `p|N`,
pairwise-coprime product assembly, positivity, the strict contradiction, or
the induction indexing. At step `n`, there are `n` positive moving speeds and
`n+1` total runners; deletion leaves `n-1` positive speeds and `n` total
runners. Cite the repository one- and two-positive-speed base declarations at
their exact `proved-lean` scope.

This chain is conditional even if the new classification is proved. The
Malikiosis--Santos--Schymura subset-gcd/product theorem is `literature` and
`external-unformalized`; its repository Lean interface is absent. Do not call
it `proved-math` or `proved-lean` in this project.

## Audited bibliography boundary

Use only these audited primary-source lines, and only where genuinely needed:

- Malikiosis--Santos--Schymura, published DOI
  `https://doi.org/10.1017/fms.2025.10107`, and matching primary arXiv text
  `https://arxiv.org/html/2411.06903v2`, for Theorem A, its exact indexing,
  and the strict product consequence.
- Rosenfeld, `https://arxiv.org/html/2512.01912v1`, only for the audited
  prime-forcing/product application context.

Do not cite or rely on arXiv `2604.23906` or `2509.14111`, and do not import
claims from any other unaudited source. A literature citation cannot replace a
proof of the new classification.

## Two materially different attacks inside the single target

Develop both attacks within the fixed budget. Each must attack
`FINITE-OBSTRUCTION-SIGNATURE-CLASSIFICATION` itself, not introduce a second
unresolved supply lemma. Put every unproved transition inside the one named
classification lemma, or mark it fatal.

### Attack A: minimal-cover rigidity and CRT normalization

Start from an inclusion-minimal cover. Use private points, exact bad-set
cardinalities for `d_i=gcd(N*p,v_i)`, deletion-gcd restrictions at every prime
dividing `N`, and the two projections modulo `N` and modulo `p`. Seek a bounded
minimal-cover normal form after the permitted symmetries, with an explicit
integer determinant/resultant `Delta_sigma` whose nonzero value is independent
of `p` and whose vanishing modulo `p` is forced by realization.

You must prove that all selected coordinates, repetitions, nonunit
coordinates, `p|N`, CRT compatibility, and equality boundaries survive the
normalization. If a determinant can vanish as an integer, classify that branch
or give a fixed-`n` infinite-prime counterfamily; do not discard it as
degenerate.

### Attack B: dual/Fourier or polynomial cover certificate

Encode a full strict-bad-set cover through an exact dual, group-algebra,
Fourier, or polynomial identity over `Z/(N*p)Z`. Derive bounded-complexity
integer data from a minimal certificate, then prove that every sufficiently
large obstruction prime divides one of finitely many nonzero integer
coefficients. Handle characteristic collapse, denominators, roots of unity,
and reduction modulo primes dividing `N` explicitly.

This attack must be genuinely different from Attack A: it may use minimality
to obtain a certificate, but it cannot simply rename the same normalized CRT
matrix. If the certificate degree, support, or coefficient height necessarily
grows with `p`, either prove that this yields a fixed-`n` infinite obstruction
family or record the attack as `STOP` without weakening the target.

For each attack, identify the first unsupported arrow and decide whether it is
real structural compression or the original cover problem in new notation.

## Known obstructions and mandatory falsification

Before recommending the bridge:

1. Reproduce the exact admissibility and full-cover certificates for the
   recovered candidates `n=3,p=5,v=(1,3,4)` and
   `n=4,p=7,v=(1,3,4,5)`. Treat aggregate recovered counts as unverified until
   independently replayed.
2. Include repeated tuples, especially coincident bad sets; do not infer a
   distinct-coordinate reduction.
3. Check every deletion gcd and every prime divisor of `N`, including `p|N`.
4. Check `r=0`, both cyclic endpoints, and equality `rho=p` as safe.
5. Test signature stability under coordinate permutation, independent signs,
   common units, different minimal subcovers, and different choices of CRT
   representatives.
6. Attempt to extend each candidate obstruction across primes at one fixed
   `n`. Record whether the proposed `H_n`, signature list, and nonzero
   `Delta_sigma` remain fixed. A family with changing `n` is not decisive.
7. Reject any proof that chooses `Delta_sigma=p`, enlarges `Sigma_n`, or raises
   `H_n` after seeing the quantified prime.
8. Reject finite verification of many primes as proof of finite obstruction
   support. Conversely, do not claim refutation without infinitely many
   distinct obstruction primes at one fixed dimension.
9. Verify separately the audited small-prime witness mechanism and why primes
   `p<=N` alone are threshold-insufficient; neither fact proves the
   classification.
10. Test whether the proposed signatures do more than encode a finite list of
    already-enumerated `(p,v)` failures. If no prime-independent derivation
    exists, record no structural progress.

Every counterexample must state the quantified claim it rejects, exact domain
and ordering, all premises, and a complete cover or algebraic certificate.

## Single unresolved lemma and stop condition

There is exactly one permitted unresolved lemma:

```text
FINITE-OBSTRUCTION-SIGNATURE-CLASSIFICATION.
```

The Euclidean extraction, threshold comparison, and conditional implication
chain must be proved from it or explicitly rejected at their first invalid
edge; they may not become additional conjectures.

Return exactly one disposition:

- `BRIDGE` only if the classification is completely proved at its unrestricted
  quantifiers, or it is decisively refuted and a strictly narrower replacement
  is itself completely proved at unrestricted quantifiers with a complete
  implication chain.
- `PIVOT` if a precise prime-independent intermediate theorem is proved but
  the classification remains open, or a decisive counterexample forces a
  materially different unrestricted formulation.
- `STOP` if both attacks retain prime-dependent enumeration, require the
  classification under another name, or fail to control a fixed-`n` infinite
  family.

Do not claim full LRC even under `BRIDGE`: the MSS interface remains
external-unformalized and every new result requires independent audit.

## Fixed one-turn research budget and optional verifier

The budget is one major Sol Pro turn. Spend it on the two attacks and their
common classification target. No broad literature survey, bounded-height
search, or second research target is allowed.

An optional verifier may be used only for falsification. Before running it,
declare one fixed dimension, a finite increasing prime list, tuple ordering,
the complete repeated-tuple or explicitly bounded signature domain, strict
badness, equality behavior, and deterministic stop rules. Use at most one new
source file and one machine-readable output, test at most eight primes, and do
not expand the domain after seeing results. Report hashes and replay commands.
Any result is `computed finite evidence` only and cannot justify eventual
prime validity or finite signature support.

An optional Lean prototype may formalize at most one local statement: either
the extraction from a supplied fixed nonzero `D_n`, or one exact
cover-preserving symmetry. Do not formalize MSS or attempt both. Claim
`proved-lean` only after compilation and an axiom audit.

## Required output format

Return one self-contained memo with these sections, in order:

1. **Disposition** — exactly `STOP`, `PIVOT`, or `BRIDGE`.
2. **Status table** — one strict label for every theorem, computation,
   dependency, rejection, and open statement.
3. **Exact classification theorem** — all definitions and quantifiers,
   including `H_n`, `Sigma_n`, `Delta_sigma`, and `D_n`.
4. **Attack A** — proof or first unsupported/fatal arrow.
5. **Attack B** — proof or first unsupported/fatal arrow.
6. **Falsification** — repetitions, boundaries, small-prime fixtures, and
   fixed-`n` signature-stability tests.
7. **Complete implication chain** — extraction, distinct primes, threshold,
   primitive/deletion bridge, external MSS boundary, induction bases, and real
   reduction.
8. **Artifacts and replay** — only if the optional bounded verifier or Lean
   prototype was used.
9. **Final boundary** — exact proved, computed, rejected, conditional, and
   open claims, with no response self-promotion.

Do not substitute a progress narrative or a catalogue of approaches. The sole
goal is a prime-independent finite obstruction classification at unrestricted
quantifiers, or a decisive fixed-dimension infinite-prime refutation.
