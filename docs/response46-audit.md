# Response 46 audit

Status: independently audited on 2026-08-02. Nothing here proves or
disproves unrestricted LRC.

## Accepted mathematical argument: Kanold by finite algebra

Response 46 supplied an independent proof of the classical bound that every
block of `2^omega(c)` consecutive integers contains an integer coprime to
positive `c`. The argument is now fully assembled in
`LonelyRunner/KanoldVandermonde.lean` and is `proved-lean`.

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

The argument first survived an independent mathematical audit and then a
line-by-line formal audit. `subsetExponent_mod_injective` verifies the modular
node separation; `primitiveRoot_subset_nodes_injective` transfers it to the
complex roots; `roots_product_expansion` and
`roots_product_eq_zero_of_dvd` verify the filter identity; and
`exponential_sum_not_vanish_consecutively` invokes Mathlib's Vandermonde
kernel. `exists_avoiding_prime_set` assembles the consecutive interval, while
`coprime_of_avoids_primeFactors` closes the prime-factor bridge. The exact
public theorem is `kanoldIntervalBound_vandermonde : KanoldIntervalBound`.
Its axiom report contains only `propext`, `Classical.choice`, and
`Quot.sound`.

Primary source for the classical bound: H.-J. Kanold,
[“Über eine zahlentheoretische Funktion von Jacobsthal”](https://doi.org/10.1007/BF01350607),
*Mathematische Annalen* 170 (1967), 314–326.

## Stronger verified height constant

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
closed `1/N` witness follows from the exact `KanoldIntervalBound` theorem.
The integer gain is `floor(3*N/17)`.

The dependency-exposing wrapper remains
`seventeenThirdsHeight_family_witness_of_kanold`; the unconditional public
theorem is `seventeenThirdsHeight_family_witness`. Likewise,
`sixHeight_family_witness` is an unconditional corollary. Every positivity,
injectivity, speed-bound, and closed-boundary hypothesis is unchanged.

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
