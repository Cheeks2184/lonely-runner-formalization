# Independent sparse lower-owner supply review

Requested Astra/xhigh review, 2026-09-05, task
`/root/vanishing_slope-sparse-owner-review`. The current workflow, policy,
configuration, and active state were read; structural validation passed.
Only this review note was edited. No Lean compilation, cache restoration,
Git operation, shared-state edit, external model session, or additional wide
subset search was performed.

**Accepted without correction:** the entire frozen
`research/astra-sparse-owner-supply-audit.md`, SHA-256
`a51e581cdf4dc7b37a9b7481e930af00f0605fb4aa0a8aa06d848845fdb99f8f`.
The result is a reviewed manuscript proof of arbitrary-height **N=9 four
distinct lower-owner noncover**. It is not yet a new kernel-checked theorem.
The general `2c<N` contract remains open, including the unproved N=10 case
identified by the author. The N=15 control refutes a sufficient individual
remainder bound, not sparse noncover or the Lonely Runner Conjecture.

## 1. Exact contract and counting reduction

For positive p let

```text
R_N(p) = {r in [0,Np) : N does not divide r},
B_d = {r in R_N(p) : min(rd mod Np, -rd mod Np) < p}.
```

For N=9, the accepted theorem says that any four distinct integers
`0<d_i<p` have `union B_d` strictly smaller than `R_9(p)`, whose cardinality
is 8p. A surviving r supplies time `r/(9p)` good at the closed threshold 1/9
for these four actual owners and the actual pivot p. The pivot is good because
`r mod 9` is between 1 and 8. No other moving speed is protected by this
statement. Strict badness is essential: equality at p remains good.

I independently checked the exact cardinality formula. Put
`h=gcd(d,p)`, `P=p/h`, `D=d/h`, and `k=gcd(D,9)`. Since
`gcd(D,P)=1`, multiplication by D on residues modulo 9P has kernel size k.
The strictly bad signed targets have k-divisible values with absolute value
at most P-1. Subtracting the candidates with `9|r` gives

```text
|B_d|/p = [k(2 floor((P-1)/k)+1)
            -(2 floor((P-1)/9)+1)]/P,
|Z_d| = h(k-1).
```

Thus k is 1, 3, or 9; no field or primality assumption has entered. The
k=1 density is at most 16/9. For k=3, write `P-1=9q+s` and
`j=floor(s/3)`. The numerator is `16q+6j+2`, at most
`2P=18q+2s+2`, because `s>=3j`.

For k=9 we have `P>=10`, `3` not dividing P, and numerator `8(2q+1)`.
If q>=3, this is at most `2(9q+1)<=2P`. The q=1 and q=2 cases leave
exactly the four reduced pairs

```text
(P,D) = (10,9), (11,9), (19,9), (19,18),
densities = 12/5, 24/11, 40/19, 40/19.
```

All lower-owner densities are consequently at most 12/5. With no such
star, all four counts are at most 2p and all four sets contain the two
distinct residues 1 and 9p-1. Their union is at most the sum minus six,
hence strictly below 8p. Distinctness of the four owners is needed in the
star case: equality of their reduced (P,D) at a fixed p means equality of
the original speeds, so the identical star can legitimately be excluded.

## 2. Complete exceptional-pair proof

Choose any star of density beta, not necessarily a largest one, and put
`T=(8-beta)/3`. The three thresholds are `28/15`, `64/33`, and `112/57`.
All exceed 16/9. Zero-free rows are therefore already strictly below T.
For other rows the scalar bound

```text
b(k,P)/P <= 16/9 + 7(k-1)/(9P)
```

implies a finite **necessary** denominator bound whenever raw density is
at least T. Its integer bounds for k=3 and k=9 are respectively
`(17,70)`, `(9,38)`, and `(8,33)`. This is an algebraic reduction of all
heights, not an empirical denominator cutoff. Enumerating every admissible
D in these ranges reproduces the manuscript's denominator tables and
37+13+9+9=68 ordered pairs. In particular the other D at P=19 is retained.

The finite computations were also checked by the manuscript's analytic
grouping. Star badness modulo S is `{0,+1,-1}` for S=10 or 11;
at S=19 it is `{0,+1,-1,+2,-2}` or `{0,+1,-1,+9,-9}`.
An other row's bad-candidate status is determined modulo 9P. CRT distributes
each such class evenly through the compatible star classes modulo S because
`gcd(S,9)=1`. This counts actual candidates, including the exclusion of
multiples of 9.

The grouped bounds exhaust the finite table:

- Star 10: coprime P give at most `(7/10)(12/5)p=42p/25`.
  The gcd-two cases P=4,16 for k=3 and P=28,38,46,64 for k=9 give
  at most `(4/5)(2p)=8p/5`. At P=20 the only admissible e=D/9 is 1,
  and only bad classes 2 and 18 escape the star, giving 4p/5. At P=55,
  the zero target contributes at least 4p/55 inside the star, leaving
  at most `(104-4)p/55=20p/11`. Each bound is strictly below 28p/15.
- Star 11: every other exceptional denominator is coprime to 11, giving
  at most `96p/55<64p/33`.
- Either star 19: other denominators give at most `168p/95<112p/57`.
  The other star of denominator 19 shares three bad classes and leaves
  two, giving `16p/19<112p/57`.

For the P=55 step, S=10 divides p and P=55 divides p. Among zero classes
modulo 55, half are zero modulo 10; independently eight ninths are
candidates. The resulting count is exactly 4p/55. This does not depend on
which unit e modulo 55 multiplies that other owner. No exception is hidden
by using only the coprime-period formula.

Arbitrary original powers of 3 and common factors cause no gap. In addition
to the author's valid 3-adic argument, there is a direct independent
reduction: for a normalized pair put `p0=lcm(S,P)`. Since both S and P
divide the original p, `g=p/p0` is integral and **both owners and the
pivot** are g times their values at p0. Reduction modulo 9p0 has exactly
g fibers in `[0,9p)`, preserves `9` not dividing r, and scales each modular
distance by g. Thus it multiplies the literal remainder cardinality by g.
The 68 finite period checks therefore cover every common scaling, including
all powers of 3; no owner is rescaled in isolation.

Independent literal pair maxima are

```text
84/55, 96/55, 168/95, 168/95,
```

all strictly below their respective T values. Consequently each of the
three other rows has remainder less than Tp and
`|union B_d| < beta*p+3*T*p=8p`. This proves the full claimed N=9 result.

## 3. Added scope and limits

The existing owner budget rearranges to
`(N-2)q <= (N+1)(N-2c)`. Taking q=c gives `3c<=N+1`; four owners thus
already pass that old bound for N>=11. The author's q<=1 and even-N q<=2
observations follow directly. Together with the accepted N=7 manuscript,
the inherited cases cover the admitted counts N<=8. The N=9 statement is
a new sufficient domain relative to these audited mechanisms, with no
literature-priority claim. It does not establish N=10 by changing grids.
Its maximum-covered-pivot consequence also has the stated scope: a complete
internal cover needs at least five lower owners, so redundancy is vacuous
when at most five labels including the pivot are covered.

The separating example is reproduced literally:

```text
N=9, p=6160, owners=(1,2640,5040,5544),
bad counts=(10950,12320,13440,14784),
8p=49280, safe count=14636, first safe r=6162.
```

The three nonempty zero kernels have underlying periods 21, 11, and 10.
The candidate residues 21, 11, and 10 respectively lie in their own kernel
and neither other kernel, so they require three dominating owners, not just
an assertion based on incomparable gcd values. The old budget is
`80+7*3=101>90`; even raw sum minus six exceeds 8p. Every integer denominator
2 through 9 divides a listed speed or p. These failures concern specified
older sufficient tests and do not assert that every previously known method
fails on this tuple.

The general fixed-N reduction in Section 3 is valid as stated. From
`b(k,P)<=2P+k-3-2Q`, raw density greater than 2 forces
`Q<=floor((k-4)/2)`, hence the listed finite potential-star bound.
The threshold
`T_N=2(N-1)(N-2)/((N+1)(N-3))` is strictly greater than the zero-free
baseline by the stated positive difference. Solving the scalar inequality
then gives its finite exceptional-other bound. This reduces a sufficient
pair-estimate strategy for each fixed odd N, not the original multiowner
union problem or an unbounded N quantifier.

The attempted uniform pair estimate is conclusively false:

```text
N=15, p=272, star=255, other=240,
|B_star|=714, |B_other|=672, |intersection|=126,
|B_other\B_star|/p = 546/272 = 273/136,
273/136 - 91/48 = 91/816 > 0.
```

The star attains the global density maximum 21/8, so choosing an actually
largest star does not repair this inequality. The independent CRT calculation
is `(42/17)*(13/16)` because the periods 17 and 16 are coprime. This is not
a sparse cover: the full seven-owner family `(1,2,3,4,5,240,255)` has the
displayed safe r=583, and the eight listed distances including the pivot
match exactly. Its time 1/7 has minimum distance 1/7, strictly above 1/15.

## 4. Reproduction and evidence scope

All six frozen source hashes listed in the author note were independently
checked. Its finite exception/power/fixture code, omitting the wide subset
loop, was replayed successfully. I read the wide loop and independently
confirmed its domain count 9,582,210, but did **not** rerun that scan; its
no-hit outcome remains the author's reported bounded execution. Neither
that outcome nor the timing is used in the all-height proof.

The following independent reproducer imports no project checker and performs
no wide subset search. The finite bounds it uses were proved above. It checks
every normalized exceptional pair directly, eight scaling controls, the
separating example including actual zero-kernel domination, and the N=15
counter-bound and safe full-family certificate.

```python
from fractions import Fraction as F
from itertools import combinations
from math import comb, gcd, lcm
from pathlib import Path
from hashlib import sha256

source = Path('research/astra-sparse-owner-supply-audit.md')
assert sha256(source.read_bytes()).hexdigest() == (
    'a51e581cdf4dc7b37a9b7481e930af00f0605fb4aa0a8aa06d848845fdb99f8f')

def distance(modulus, value):
    residue = value % modulus
    return min(residue, modulus-residue)

def bad(N, p, d):
    return {r for r in range(N*p)
            if r % N != 0 and distance(N*p, r*d) < p}

def numerator(P, D):
    k = gcd(D, 9)
    return k*(2*((P-1)//k)+1)-(2*((P-1)//9)+1)

stars = [(10,9), (11,9), (19,9), (19,18)]
counts, maxima = [], []
scaling_checks = 0
for S, Ds in stars:
    beta = F(numerator(S,Ds), S)
    threshold = (8-beta)/3
    pairs = []
    # Independent enumeration includes all D, including zero-free types;
    # admissibility and the derived k-specific bound do the filtering.
    for P in range(2, 71):
        for D in range(1, P):
            k = gcd(D,9)
            if gcd(P,D) != 1 or k == 1 or (P,D) == (S,Ds):
                continue
            cap = F(7*(k-1), 9)/(threshold-F(16,9))
            if P > cap or F(numerator(P,D), P) < threshold:
                continue
            p0 = lcm(S,P)
            Bs = bad(9,p0,Ds*(p0//S))
            Bd = bad(9,p0,D*(p0//P))
            assert F(len(Bs),p0) == beta
            assert F(len(Bd),p0) == F(numerator(P,D),P)
            ratio = F(len(Bd-Bs),p0)
            assert ratio < threshold
            pairs.append(ratio)
    counts.append(len(pairs))
    maxima.append(max(pairs))
    p0 = lcm(S,7)
    ds, d = Ds*(p0//S), 3*(p0//7)
    base = len(bad(9,p0,d)-bad(9,p0,ds))
    for g in (3,9):
        assert len(bad(9,g*p0,g*d)-bad(9,g*p0,g*ds)) == g*base
        scaling_checks += 1
assert counts == [37,13,9,9]
assert maxima == [F(84,55),F(96,55),F(168,95),F(168,95)]
assert scaling_checks == 8

p, owners = 6160, (1,2640,5040,5544)
R = {r for r in range(9*p) if r % 9}
Bs = [bad(9,p,d) for d in owners]
assert tuple(map(len,Bs)) == (10950,12320,13440,14784)
safe = R-set().union(*Bs)
assert (len(safe),min(safe)) == (14636,6162)
Zs = [{r for r in R if r*d % (9*p) == 0} for d in owners]
assert not Zs[0]
for i, r in enumerate((21,11,10), start=1):
    assert r in Zs[i] and all(r not in Zs[j] for j in range(4) if j != i)
minimum_q = min(len(J) for q in range(5) for J in combinations(range(4),q)
                if all(any(Z <= Zs[j] for j in J) for Z in Zs))
assert minimum_q == 3 and 80+7*minimum_q > 90
assert sum(map(len,Bs))-6 > len(R)
assert all(any(v % q == 0 for v in owners+(p,)) for q in range(2,10))

N,p = 15,272
Bs, Bd = bad(N,p,255), bad(N,p,240)
assert (len(Bs),len(Bd),len(Bs & Bd),len(Bd-Bs)) == (714,672,126,546)
assert F(len(Bs),p) == F(3*(N-1),N+1)
assert F(len(Bd-Bs),p) == F(42,17)*F(13,16)
assert F(len(Bd-Bs),p)-F(91,48) == F(91,816)
V = (1,2,3,4,5,240,255,272)
distances = tuple(distance(N*p,583*v) for v in V)
assert distances == (583,1166,1749,1748,1165,1200,1785,544)
assert 583 % N and min(distances) >= p
assert min(F(distance(7,v),7) for v in V) == F(1,7) > F(1,15)

# Domain size only: this does not replay or validate a no-hit outcome.
assert sum(comb(28,(N-1)//2+1) for N in range(4,17)) == 9582210
print({'exception_pairs': counts, 'pair_maxima': list(map(str,maxima)),
       'scaling_checks': scaling_checks, 'fixture_safe': len(safe),
       'minimum_zero_dominators': minimum_q, 'N15_bound': 'refuted',
       'N15_full_family': 'safe', 'wide_scan': 'not rerun'})
```

The remaining work is a separate formalization of the exact N=9 theorem
and a new argument for the broader sparse-owner supply problem. This review
does not change the unresolved canonical completion status.
