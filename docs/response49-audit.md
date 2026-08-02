# Response 49 audit

Status: independently audited on 2026-08-02. The two global reductions below
are `proved-math`, not `proved-lean`. Neither proves the unrestricted top-two
pivot conjecture or the Lonely Runner Conjecture.

## Recovery and hashes

Chrome exposed multiple virtualized response controls out of chronological
order. The first recovered text was a Prompt 45-era response and was rejected
as a Response 49 artifact before any mathematical promotion. The actual
Response 49 begins `Status corrections`.

The exact recovery metadata is:

| representation | characters | UTF-8 bytes | line data | SHA-256 |
|---|---:|---:|---|---|
| raw Windows clipboard | 16,115 | 16,192 | CRLF | `b553c921e824c2ee3769442e439a64842000ef4c8d2ec0aee151e8b9a33613ff` |
| LF-normalized preservation | 15,400 | 15,477 | 715 LF, final LF present | `25168ac758f8be28ca31eee9e9b8d2e22b4cbd762ca7e57dbbbe0e98b3a1838a` |

The normalized full response is preserved outside the public repository. This
document records only the audited claims, exact hashes, and objections.

## Compiler-targeted attachment

Sol Pro supplied a saturated-class Lean attachment with SHA-256

```text
7f112ac4b2f2f281d609cc393521fe3d6d73a193ecd0830536692f834c9c4072
```

The attachment is **rejected as formal evidence**. Its first compiler failures
against the pinned project were:

```text
line 66:  rewriting N=(N-1)+1 also rewrote inside N-1
line 117: an unresolved product/natural-subtraction goal
line 143: an unresolved positivity goal
line 148: an incorrectly applied dvd_add_iff lemma
line 178: an invalid natural-subtraction rewrite
line 192: a complement inequality in the wrong orientation
line 236: inverse-inequality elaboration failed
line 249: an extra tactic remained after the goal was closed
```

Later goals were not audited once these failures established that the file did
not compile. The project's independently written saturated-class module is a
separate artifact and does not retroactively validate this attachment.

## B1: fastest-pivot interval compression

Let

```text
0 < a_1 < ... < a_(n-1) = A < a_n = B,
N = n+1.
```

If a natural number `r` satisfies

```text
N does not divide r,
B <= r*a_1,
r*A <= (N-1)*B,
```

then `r` is a canonical certificate at the fastest pivot `B`.

Indeed, every nonpivot speed `a_i` lies between `a_1` and `A`, so

```text
B <= r*a_i <= (N-1)*B = N*B-B.
```

These products are below `N*B`, and both closed endpoints are safe because
`pivotBadResidues` uses the strict inequality `cyclicResidueDistance < B`.
Moreover `r<=r*A<(N*B)`, so `N∤r` gives candidate membership.

Put

```text
L = ceil(B/a_1),
U = floor((N-1)*B/A).
```

Any `r` in `[L,U]` not divisible by `N` gives the certificate. Consequently,
failure at the fastest pivot forces exactly one of the compressed cases

```text
U < L,
U = L and N divides L.
```

If `U>=L+1`, the interval contains two consecutive integers and cannot consist
only of multiples of `N>=2`. The previously formalized ratio criterion is the
special choice `r=N-1`; failure of that choice forces `(N-1)*a_1<B` and hence
`L>=N`.

This argument passed independent endpoint and quantifier audit. The certificate
core is now also `proved-lean` as
`pivot_le_cyclicResidueDistance_mul_of_band` and
`exists_fastestPivotCertificate_of_extremal_band`; the first draft exposed a
strict/non-strict `.trans` elaboration error, and the repaired
`lt_of_le_of_lt` source compiled in an isolated ext4 target with only standard
axioms. The separate ceiling/floor failure dichotomy remains `proved-math` and
has not yet been formalized.

The remaining obstruction is global: the compressed alternatives constrain
only the multiplicative range of the lower speeds. They do not control their
residue classes modulo `N*A`, so they do not force the other top pivot `A` to
succeed.

## B2: common top-grid slice

Let

```text
g = gcd(A,B),  A=g*alpha,  B=g*beta,
gcd(alpha,beta)=1.
```

Define

```text
C = {u : 0 <= u < N*g,
         N does not divide alpha*u,
         N does not divide beta*u}.
```

For `u in C`, put

```text
r_A=alpha*u,  r_B=beta*u.
```

Then `r_A` and `r_B` are candidates on the `A`- and `B`-pivot grids and

```text
r_A/(N*A) = r_B/(N*B) = u/(N*g).
```

Thus they represent one common time. For a lower speed `s`, define

```text
D_s = {u in C : cyclicResidueDistance (N*g) (s*u) < g}.
```

Any `u` outside the union of the lower `D_s` gives simultaneous certificates
at both top pivots. If

```text
d_A=gcd(N,alpha),  d_B=gcd(N,beta),
```

then the common candidate slice has the exact size

```text
|C| = g*(N-d_A-d_B+1).
```

The exclusions depend only on `u mod N`. Multiplication by `alpha` and `beta`
has kernel sizes `d_A` and `d_B`; their kernel intersection has size one
because `gcd(alpha,beta)=1`; every residue modulo `N` has `g` lifts modulo
`N*g`.

Each `|D_s|` is exactly computable by generalized CRT. Writing

```text
T_g = {x mod N*g : cyclicResidueDistance (N*g) x < g},
```

inclusion-exclusion removes the forbidden congruences `A*u=0` and `B*u=0`
modulo `N*g`. In particular, the strict union bound

```text
sum_s |D_s| < g*(N-d_A-d_B+1)
```

is sufficient for a top-two certificate. The common-time identity, slice
count, and union criterion passed independent audit and are `proved-math`.
They are sufficient reductions only.

## Exact global obstruction

The common slice can be empty. At the independently audited hard top pair

```text
N=7, A=98, B=187,
```

one has

```text
g=1, alpha=98, beta=187,
d_A=7, d_B=1,
|C|=1*(7-7-1+1)=0.
```

Therefore B2 is completely silent on this instance. A global proof would need
another rigid cross-pivot slice, especially when one normalized top speed is
annihilated modulo `N`, or a different argument controlling both full top
grids. No such replacement is supplied by Response 49.

## Final status

- B1 closed-band certificate: `proved-lean`; authoritative clean integration
  replay passed.
- B1 ceiling/floor failure dichotomy: `proved-math`.
- B2 common-time identity and exact slice count: `proved-math`.
- B2 strict union criterion: `proved-math`, sufficient only.
- Response 49 Lean attachment: rejected as formal evidence.
- General top-two pivot conjecture: conjectural/open.
- Unrestricted LRC: open.
