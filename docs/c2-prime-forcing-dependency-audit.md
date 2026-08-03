# C2 prime-forcing dependency audit

Task: `VER-C2-DEPENDENCY-038`.

Status date: 2026-08-03. Base:
`f9afa7e6ff98eccb252e29cd6f0de1aac3ac56ef`.

## Disposition

The primary-source product dependency is accepted at the exact scope below.
It remains **external unformalized mathematics**: the repository has no Lean
wrapper for Malikiosis--Santos--Schymura Theorem A, its induction indexing, or
the strict product corollary. `UniformPrimeForcingSupply` remains open.

This audit promotes no finite computation, Lean result, or unrestricted
claim. Under the route reassessment, direct unrestricted route B ranks before
C2 because B is one new arithmetic lemma from the existing pivot-certificate
equivalence, whereas C2 requires a uniform prime supply, induction, and the
external product theorem.

## Accepted primary theorem and indexing

Use the paper's indexing exactly. Its `n` is the number of positive moving
speeds in the target instance, so adjoining stationary speed `0` gives `n+1`
total runners. The induction hypothesis is LRC for `n` total runners.

For a primitive positive integer vector `v=(v_1,...,v_n)`, define

```text
v_S = gcd(v_i : i in S),
v_empty = 0,
C_n = binom(n+1,2)^(n-1).
```

Malikiosis--Santos--Schymura Theorem A proves the target instance from the
lower-dimensional LRC hypothesis when

```text
sum_(S subset {1,...,n}) v_S > C_n.
```

The inequality is strict. There is no floor or ceiling in Theorem A.

Primary sources:

- [Malikiosis--Santos--Schymura, published article and Theorem A](https://doi.org/10.1017/fms.2025.10107)
- [Malikiosis--Santos--Schymura, primary arXiv text](https://arxiv.org/html/2411.06903v2)
- [Rosenfeld, primary prime-forcing/product application](https://arxiv.org/html/2512.01912v1)

## Accepted strict product corollary

Let

```text
P = product_(i=1)^n v_i,
C = binom(n+1,2).
```

For positive injective speeds and `n>=2`, the subset-gcd sum strictly exceeds
the singleton sum, while AM--GM gives

```text
sum_i v_i >= n*P^(1/n).
```

Consequently

```text
P >= (C^(n-1)/n)^n
```

is sufficient for the strict Theorem A hypothesis. Equivalently, a primitive
counterexample compatible with the lower-dimensional hypothesis must satisfy

```text
P < C^(n(n-1))/n^n.
```

If a product `Q` of distinct forced primes divides `P`, the exact sufficient
integer comparison is

```text
n^n * Q >= binom(n+1,2)^(n(n-1)).
```

Weak `>=` is sufficient here because the opposing counterexample bound is
strict. The outer exponent applies to the entire real quotient; square
brackets in the cited product corollary are grouping delimiters, not a floor.

## PrimeForcing contract and finite evidence

For `n>=3`, `N=n+1`, and prime `p`, `PrimeForcing(n,p)` quantifies over every
possibly repeated residue tuple modulo `N*p` satisfying:

- no coordinate is divisible by `p`;
- after deleting any one coordinate, the remaining residues together with
  `N*p` have gcd one.

It requires one residue `r` modulo `N*p` with

```text
p <= rho_(N*p)(r*v_i)
```

for every coordinate. Repeated residues are mandatory; distinct integer
speeds can collide after reduction.

`VER-C2-DEPENDENCY-038` independently reproduced the tracked `n=3` prime
slice below with an in-memory exact enumerator. This reproduction does not
repair the complete Response60 artifact, whose whole-output replay remains
nonreproducible.

| Prime `p` | Premise-satisfying residue tuples | Exact failures |
| ---: | ---: | ---: |
| 2 | 64 | 0 |
| 3 | 256 | 0 |
| 5 | 2,048 | 192 |
| 7 | 6,912 | 0 |
| 11 | 32,000 | 0 |
| 13 | 55,296 | 0 |

The reproduced distinct-prime supply `{2,3,7,11,13}` has product `6006`,
exceeding the exact dimension-three product threshold `1728`. These rows
remain **computed finite evidence only**; the mandatory complete Response60
artifact remains nonreproducible.

`PrimeForcing(3,5)` is rejected by

```text
N=4, p=5, v=(1,3,4) mod 20.
```

All deletion-gcd and nondivisibility premises hold, but the strict bad sets
cover every residue. Among exactly `2,048` premise-satisfying tuples for
`p=5`, exactly `192` fail; `(1,3,4)` is the first failure in the enumerator's
declared lexicographic tuple order. This is **computed finite negative
evidence only** against that prime, not a rejection of uniform supply from
other primes.

## Open dependency and missing Lean wrappers

`UniformPrimeForcingSupply` asks, for every `n>=3`, for finitely many distinct
primes satisfying `PrimeForcing(n,p)` whose product meets

```text
n^n * Q >= binom(n+1,2)^(n(n-1)).
```

No dimension-uniform construction, density theorem, or eventual-prime
criterion is known. The local forcing property is itself a growing finite
cover problem and may retain most of the original difficulty.

Only distinct primes are admissible in this route contract. Prime powers are
not part of the supply and cannot be used to increase `Q`.

The Lean project is missing wrappers for:

1. MSS Theorem A with the exact `n` versus `n+1` runner indexing;
2. primitive normalization and the lower-dimensional induction hypothesis;
3. the subset-gcd sum and `v_empty=0` convention;
4. the strict AM--GM product corollary;
5. forced-prime divisibility of the speed product from `PrimeForcing`;
6. assembly of a finite prime supply into the exact integer comparison;
7. the final contradiction and induction step.

Existing local prime-forcing arithmetic does not fill these external wrappers.

## Route consequence

Keep C2 open but second. Route B is first by distance to unrestricted LRC,
then by estimated success, then by publishability. Do not launch a duplicate
prime-forcing Sol Pro cell while `SOL-P66-PRO-B-001` is the active first-ranked
Sol High desktop cell.
Reassess C2 only after the B cell stops or a genuinely uniform prime-supply
lemma, rather than another dimension-by-dimension enumeration, becomes
available.

Recommended evidence label:
**accepted external dependency audit; finite prime rows only; C2 open and
unformalized; no status promotion**.
