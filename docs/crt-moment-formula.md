# Direct CRT formula for the common-slice moments

## Scope

This note resolves the local formula obligation `CORR-03`: it expresses every
moment

```text
H_q = sum_s d(s) * binom(k(s),q)
```

as an explicit finite sum of generalized-CRT intersection counts.  The formula
does not enumerate the weighted `k` histogram or the safe set.  It is an exact
identity, not a proof that a useful low-order signed combination is always
positive, and therefore does not prove the Lonely Runner Conjecture.

## Hypotheses and boundary convention

Let `a_0,...,a_{n-1}` be positive integer speeds, with `n>=1`, and put

```text
N = n+1,  ell = lcm(a_0,...,a_{n-1}),  L=N*ell.
```

Distinctness is not needed for the identity, although the standard integer
Lonely Runner statement assumes distinct speeds.  Runner *indices* remain
distinct even when two numerical speeds coincide.

For a positive modulus `M`, write

```text
rho_M(x) = min(x mod M, M-(x mod M)),
```

where `x mod M` is in `{0,...,M-1}`.  “Bad” means the strict inequality
`rho_M(x)<A`.  Thus the residues at circular distance exactly `A` are good.
Equivalently,

```text
rho_M(x)<A  iff  x = h (mod M) for a unique h with -(A-1)<=h<=A-1,
```

in the applications below, since `M=N*A>2(A-1)`.

## From common slices to pivot grids

For pivot index `j`, set `Q_j=ell/a_j` and

```text
C_j = Q_j*(Z/LZ) \ N*Q_j*(Z/LZ).
```

The map

```text
r in Z/(N*a_j)Z, with r not equal to 0 mod N,
    |-> Q_j*r in C_j
```

is a bijection.  If

```text
b_i(s) = 1[rho_L(a_i*s)<ell],
k(s)   = sum_i b_i(s),
d(s)   = #{j : s in C_j},
```

then on the pivot-`j` grid

```text
b_i(Q_j*r) = 1[rho_(N*a_j)(a_i*r)<a_j].
```

Expanding the binomial coefficient as a sum over index subsets gives

```text
H_q
 = sum_j sum_{I subset {0,...,n-1}, |I|=q} T(j,I),

T(j,I)
 = #{r mod N*a_j : r != 0 mod N,
                     rho_(N*a_j)(a_i*r)<a_j for every i in I}.
```

There are no repeated indices in `I`: this is the square-free subset expansion
of `binom(k,q)`.  Numerically repeated speeds are not merged.  If `j in I`,
the self condition says `a_j*r=0 (mod N*a_j)`, hence `r=0 (mod N)`; therefore
`T(j,I)=0`.  One may equivalently sum only over `I` disjoint from `{j}`.  The
empty-subset convention is `T(j,empty)=n*a_j`, so `H_0=n*sum_j a_j`.

## Closed generalized-CRT count for one term

Fix `j`, write `A=a_j` and `M=N*A`, and fix `I`.  For each `i in I`, define

```text
g_i = gcd(a_i,M),
m_i = M/g_i,

R_i = { (a_i/g_i)^(-1)*(h/g_i) mod m_i :
        -(A-1)<=h<=A-1 and g_i divides h }.
```

The inverse exists modulo `m_i` because `gcd(a_i/g_i,m_i)=1`.  When `m_i=1`,
the sole residue class is interpreted as `0 mod 1`.  Distinct admissible
endpoints `h` yield distinct classes because their difference has absolute
value less than `M`.  Consequently the strict bad condition for runner `i` is
the disjoint union

```text
union_{c_i in R_i} {r : r=c_i (mod m_i)}.
```

For an endpoint-class vector `c=(c_i)_{i in I}`, put

```text
m_I = lcm_{i in I} m_i,
```

with `m_empty=1`.  The generalized CRT says that the system

```text
r=c_i (mod m_i),  i in I,
```

is compatible exactly when

```text
c_i = c_i' (mod gcd(m_i,m_i'))
```

for every pair `i,i' in I`.  If compatible, it determines a unique class
`r=c (mod m_I)`.  Because every `m_i` divides `M`, this class contains
`M/m_I` residues modulo `M`.

The excluded pivot multiples add the congruence `r=0 (mod N)`.  They meet the
class `c mod m_I` exactly when

```text
c = 0 (mod gcd(m_I,N)).
```

In that case their number is `M/lcm(m_I,N)`; otherwise it is zero.  Therefore

```text
T(j,I)
 = sum_{(c_i) in product_i R_i, pairwise CRT-compatible}
     [ M/m_I
       - 1[c=0 mod gcd(m_I,N)] * M/lcm(m_I,N) ].
```

This includes all gcd/lcm compatibility and candidate-exclusion effects.  No
coprimality between speeds is assumed.  The endpoint vectors describe disjoint
solution classes, so the displayed sum has no multiplicity correction.

## Exact audit on G

The standalone verifier
[`scripts/audit_crt_moment_formula.py`](../scripts/audit_crt_moment_formula.py)
implements the formula by recursively merging the disjoint congruence-class
families with the generalized CRT.  It independently compares the result with
a literal sum of `binom(k,q)` on each pivot grid; that comparison also constructs
neither a histogram nor a safe set.

For

```text
G=(15,21,40,48,56,105,126,280,1200),
```

the exact result is

```text
(H_0,H_1,H_2,H_3,H_4) = (17019,27432,18203,7492,2709).
```

Reproduce with:

```bash
python3 scripts/audit_crt_moment_formula.py
```

The script also checks every self-runner term `T(j,{j})=0` and explicitly
tests that distance `A` is outside, while distance `A-1` is inside, the strict
bad ball.
