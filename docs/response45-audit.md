# Response 45 audit

Status: independently audited on 2026-08-02. Nothing in this document proves
or disproves unrestricted LRC.

## Accepted mathematical result

For primes `p_1=2<p_2<...`, put

```text
P_k = product_{i=1}^k p_i,
Q_k = product_{i=1}^k (p_i-1),
```

and choose the largest `k` with `P_k<=N`. Then

```text
max_{1<=c<=N} c/phi(c) = P_k/Q_k.
```

Indeed, if `q_1<...<q_s` are the distinct prime divisors of `c`, then
`q_i>=p_i`, the function `x/(x-1)` is decreasing, and
`P_s<=q_1*...*q_s<=c<=N`; hence `s<=k` and
`c/phi(c)<=P_k/Q_k`. Equality is attained by `c=P_k`.

The existing missing-height argument therefore proves the following exact
strict theorem on paper. If positive injective `N-1` speeds are bounded by
`N+t` and

```text
(4*P_k-Q_k)*t < N*Q_k,
```

then they have a common real witness at closed circular distance at least
`1/N`. In the short-interval branch, absence of a coprime denominator gives

```text
c*Q_k <= phi(c)*P_k <= (2*c+t-N)*P_k,
2*c <= N+t,
```

which implies `N*Q_k <= (4*P_k-Q_k)*t`, the required contradiction. The
largest integral gain delivered by this proof is

```text
floor((N*Q_k-1)/(4*P_k-Q_k)).
```

Strictness is essential to this argument. The unconditional theorem is now
`proved-lean`. `PrimorialHeight.lean` checks the complete height argument,
exact gain, largest-primorial construction, the uniform ratio inequality, and
attainment of the maximum. The uniform inequality is proved by a terminating
finite-prime exchange: replacing a maximal prime by a missing smaller prime
strictly lowers the radical while increasing its Euler ratio. No unrestricted
LRC conclusion follows.

## Analytic corollary

Response 45 also invoked Rosser and Schoenfeld's explicit estimate for
`c/phi(c)`. The attribution and universal `2.50637` constant were checked
against Theorem 15 of their 1962 paper. The resulting `N/log log N` height
corollary is mathematically sound, but it is not formalized and is no longer
the preferred route because the separate Kanold/Jacobsthal investigation may
give a stronger linear-height statement.

Primary source: J. Barkley Rosser and Lowell Schoenfeld,
[“Approximate formulas for some functions of prime numbers”](https://doi.org/10.1215/ijm/1255631807),
*Illinois Journal of Mathematics* 6 (1962), 64–94.

## Recovered computation

The two attached source files were recovered from the signed-in GPT-5.6 Pro
conversation. Their SHA-256 values match the response. The Python verifier
checks the primorial maximum through `N=5000`, reported gain samples, and two
residual compatibility families. Its output hash is
`9e703e7d4209f2853fae3ed9c291a70ed371db22bc9e7f30339405bdc6e10ecd`.

The C++ program checks 150,426 tuples of the form

```text
(1,3,4,5,6,8,9,14,24,30,42,56,168,x,y),
50<=x<y<=600,
```

and finds the prescribed full Chebyshev score positive at pivot `x` in every
case. Its output hash is
`faa2aeaa86b805140590939eff3471bf7f4ba7cfd88854170febbd12f9a266c7`.
This is finite evidence only and supplies no uniform cross-pivot inequality.

Reproduce both artifacts with:

```bash
bash scripts/audit_response45.sh
```

## Residual family

The active-terminal family in the response is valid. For `N>=10`, take the
set consisting of `N`, all even `2m` for `ceil(N/2)<=m<=N-1`, and the smallest
integers at least two needed to reach `N-1` elements. It satisfies the listed
divisor-cover, deletion-gcd, comparable-top, terminal-interval, and
signed-descent restrictions, while `1/(2N)` is an explicit closed-boundary
witness. It demonstrates compatibility of those necessary conditions; it is
not an LRC counterexample.

## New objection returned to Sol

Prompt 46 reports the independently discovered Kanold/Jacobsthal route. With
`g(c)` defined as the least length forcing a coprime in every consecutive
interval, Kanold's bound `g(c)<=2^omega(c)` appears to combine with the same
denominator interval to prove the stronger hypothesis `6*t<=N`. This remains
conditional until the imported theorem is reconstructed without an axiom and
the small cases and interval convention are fully formalized.

Primary source: H.-J. Kanold,
[“Über eine zahlentheoretische Funktion von Jacobsthal”](https://doi.org/10.1007/BF01350607),
*Mathematische Annalen* 170 (1967), 314–326.
