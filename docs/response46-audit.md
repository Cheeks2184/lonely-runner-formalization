# Response 46 audit

Status: independently audited on 2026-08-02. Nothing here proves or
disproves unrestricted LRC.

## Accepted mathematical argument: Kanold by finite algebra

Response 46 supplied an independent proof of the classical bound that every
block of `2^omega(c)` consecutive integers contains an integer coprime to
positive `c`. This is `proved-math`, not yet `proved-lean`.

Let `P` be the distinct prime divisors of `c`, let `M` be their product, and
choose a primitive `M`-th complex root of unity `zeta`. For each `p in P`, set
`zeta_p=zeta^(M/p)` and

```text
F(x) = product_{p in P} (1-zeta_p^x).
```

Then `F(x)=0` exactly when some `p in P` divides `x`, hence exactly when `x`
is not coprime to `c`. Expanding the product gives one exponential mode for
each subset `S` of `P`:

```text
F(x) = sum_{S subset P} (-1)^|S| lambda_S^x,
lambda_S = product_{p in S} zeta_p.
```

The `lambda_S` are pairwise distinct. Writing
`e_S=sum_{p in S} M/p`, equality of two roots would imply
`e_S=e_T (mod M)`. Reducing modulo a prime in `S symmetric-difference T`
leaves exactly one nonzero term `+/- M/p`, a contradiction.

If `2^|P|` consecutive values `F(a+r)` all vanished, the resulting square
Vandermonde system on the distinct nodes `lambda_S` would force all
coefficients `(-1)^|S|*lambda_S^a` to vanish. The empty-subset coefficient is
one, so this is impossible. The cases `c=1` and `x=0` are compatible with the
same interval convention.

The argument has survived an independent mathematical audit. It does not
reconstruct Kanold's original analytic proof, and it has not yet been fully
formalized. Scratch Lean now verifies subset-exponent and primitive-root node
injectivity, the exact powerset expansion, and the Vandermonde nonvanishing
kernel. Full interval/coprimality assembly remains.

Primary source for the classical bound: H.-J. Kanold,
[“Über eine zahlentheoretische Funktion von Jacobsthal”](https://doi.org/10.1007/BF01350607),
*Mathematische Annalen* 170 (1967), 314–326.

## Stronger conditional height constant

Response 46 sharpened the interval arithmetic from `6*t<=N` to

```text
17*t <= 3*N.
```

In the nonreciprocal branch, `2*c<=N+t`. Multiplying this by seven and using
`17*t<=3*N` gives

```text
14*c + 10*t <= 7*N + 17*t <= 10*N,
```

so for `ell=N-c-t`, `5*ell>=2*c`. Together with the Lean-verified estimate
`5*2^omega(c)<=2*c` for `c>=7`, this supplies enough interval length. The
six small moduli satisfy the required length bounds directly. Thus the
closed `1/N` witness follows from the exact `KanoldIntervalBound` premise.
The integer gain is `floor(3*N/17)`.

The conditional wrapper now compiles as
`seventeenThirdsHeight_family_witness_of_kanold`; the earlier `6*t<=N`
declaration is retained as a corollary. The result remains conditional because
the roots-of-unity proof of `KanoldIntervalBound` is not yet fully formalized.
The abstract Vandermonde consecutive-vanishing kernel, primitive-root node
injectivity, subset-exponent injectivity, exact powerset product expansion,
and divisibility-to-vanishing direction compile together in scratch. The
remaining bridge is the full interval/coprimality assembly and reindexing into
the compiled Vandermonde kernel.

The condition `5*t<=N` still fails for the arbitrary fixed-hole selector at
`(N,t,c)=(11,2,6)`, where the interval is `(20,21,22)`. This does not refute a
different coefficient-five family theorem.

## Square-root-log fallback

The response also supplied a complete manuscript proof of

```text
c^2 <= 8*omega(c)*phi(c)^2       for c>=2.
```

It orders the distinct prime factors, uses the elementary slot bound
`p_i>=2*i-1`, and bounds the resulting Wallis-type product by tracking
`A_k=R_k^2/k`. The recurrence

```text
A_(k+1)/A_k = 1 + 1/(4*k*(k+1))
```

and the telescoping sum of the added fractions give `A_k<16/3<8`. This proof
is accepted mathematically. Several component lemmas compile in scratch Lean,
but the complete prime-factor product bridge is not yet assembled.

## Recovered computation

The attached verifier was recovered byte-for-byte. Its source SHA-256 is
`53d525d152044fd2502550fa2854a2944441073c9c879e633bfb7cc345a1f261`,
and its reproduced output SHA-256 is
`23dbf402f45274bb77d28bc537b0ee26875bb34c2a1103fe229ff0bc5909f253`.
It checks the Jacobsthal bound through `c=5000`, 3,978,332 admissible
nonreciprocal triples for `17*t<=3*N` through `N=500`, 3,742,532 triples for
`6*t<=N`, and the coefficient-five local obstruction. These are regression
checks only; the finite-algebra argument, not enumeration, proves the
manuscript bound.

Reproduce it with:

```bash
bash scripts/audit_response46.sh
```

## Pivot frontier

Response 46 found neither a cross-pivot inequality nor an all-pivot failure
for the full Chebyshev/CRT score. The rejected quadratic projection remains
rejected. No full-score or unrestricted LRC conclusion was accepted.
