# Every fixed odd Bonferroni truncation fails universal weighted supply

Task `/root/guard_internal_cover_audit`, requested Astra/xhigh, 2026-09-05.
Starting source checkpoint: `a04bbdb819860ec35174e94b565dcc4665c981ca`.
The current workflow, policy, and active state were read and structural
validation passed. Only this note is owned. No Lean, dependency, cache,
Git, shared-state, or other-agent changes were made.

**Disposition:** the argument below proves at manuscript level that, for
every fixed positive odd truncation order, the associated weighted sufficient
inequality fails on some genuine sparse actual-pivot tuple. The tuple has an
explicit closed witness. This extends the first-order weighted-incidence
obstruction to every fixed order; it does not refute sparse noncover or LRC.
Independent mathematical review is still required. No Lean theorem is claimed.

The root proposed the family and concentration strategy, and supplied matching
explicit constants during this audit. This note independently derives and
checks the grid alignment, tail estimate, weight normalization, and explicit
integer parameter choice. It is a jointly informed candidate proof, not its
own independent acceptance review.

Frozen input bindings:

| Input | SHA-256 |
| --- | --- |
| `research/astra-general-sparse-route.md` | `37aac6b4b044504d5ef8c456baa734de1db314edc7e526a0d08080d489c34036` |
| `research/astra-weighted-sparse-audit.md` | `9e0ee5af6fb466f9504c03e2822706461103a8698307e620b1de879aad4e6d1b` |

The first input supplies the accepted actual-grid averaging framework. The
second supplies the first-order obstruction; its independent review was
pending at task launch. The proof here is standalone and does not depend on
acceptance of that finite counterexample.

## 1. The exact statement being refuted

For a positive odd integer h, define, with binomial coefficients zero beyond
their ordinary nonnegative integer range,

```text
B_h(m) = sum_(j=1)^h (-1)^(j+1) binom(m,j).
```

Pascal's identity telescopes to

```text
B_h(0)=0,
B_h(m)=1+binom(m-1,h)   for integers m>=1.                 (1)
```

Indeed `sum_(j=0)^h (-1)^j binom(m,j)=(-1)^h binom(m-1,h)`
for m>=1, including h>=m under the stated convention. Thus B_h is nonnegative
and is at least one wherever m>=1. In particular, if e=h+1, then e is even
and `B_h(e)=2`.

Given N, distinct lower owners d<p, actual pivot p, and M=Np, put

```text
R={0<=r<M : N does not divide r},
rho_M(x)=min(x mod M, M-(x mod M)),
m(r)=#{lower owners d : rho_M(rd)<p},
H_v(t)=4 sin^2(pi v t),
Q(t)=product_(v in V) H_v(t),
A=CT product_(v in V)(2-z^v-z^(-v)),
T_h=(1/M) sum_(r=0)^(M-1) B_h(m(r)) Q(r/M).
```

Here V includes the pivot and every lower owner; m counts only lower labels.
The strict inequality in m makes equality at the target boundary good.
Whenever the Laurent degree is less than M, the root-of-unity average gives
`A=(1/M)sum_r Q(r/M)` exactly. On excluded multiples of N the pivot factor
is zero. Consequently complete coverage of R implies `T_h>=A` by (1).
The sufficient condition `T_h<A` therefore implies noncover.

The claim refuted below is universal availability of that sufficient
condition for a **fixed h**, over all sparse tuples. The order is fixed
independently of their number of owners. No assertion is made against an
order growing with the tuple size or against full inclusion-exclusion.

## 2. A family with an explicit witness

Fix h odd and positive, set e=h+1, and take any integer
`k>=max(40,e+1)`. Define

```text
V={2,4,...,2e} union {1,3,...,2k-1},
p=2k-1,             c=k+e-1,
N=2c+1=2k+2e-1,     M=Np.                                (2)
```

The two sets are disjoint, there are k+e moving speeds, and p>2e is the
unique largest speed. Exactly c of these speeds are genuine distinct lower
owners. All are positive, `2c=N-1<N`, and all v in V satisfy `v<=p<N`.
N and p are odd, so M is odd.

The literal residue r=p lies in R because `0<p<N`. At time r/M=1/N,

```text
rho_M(pv)=p min(v,N-v)>=p     for every v in V.             (3)
```

Speed one attains equality. Thus every member of (2) has a closed actual-grid
witness, regardless of the weighted criterion. N is the sparse problem's
given threshold denominator; this tuple has k+e listed moving speeds, not
N-1 listed moving speeds. No normalization to a different denominator is
being made.

There is also no frequency alias. The Laurent degree is

```text
d=k^2+e(e+1) <= k^2+(k-1)k = kp < Np=M.                  (4)
```

The middle inequality uses e<=k-1. Every nonzero Laurent exponent is
strictly between -M and M, so its average over the M-th roots is zero.
This proves the exact formula for A used throughout the rest of the proof.

## 3. A central region with exactly e bad owners

For t in [0,1), write `u=|t-1/2|` and put

```text
delta=1/(2eN),     U={t : |t-1/2|<delta}.
```

If t lies in U, every even speed 2a, 1<=a<=e, has circle distance
`2a u<1/N`; these are strictly bad lower owners. Every odd v<=p has distance

```text
1/2-vu > 1/2-p/(2eN) > 1/2-1/(2e) >= 1/4 > 1/N.        (5)
```

The formula has no wrap because vu<1/(2e)<=1/4. Thus every odd speed,
including the actual pivot, is strictly good, and m=e exactly on U's grid
points. In particular, `B_h(m)=2` there. A grid point in U cannot be an
excluded multiple of N: that would make the pivot distance zero, contrary
to (5).

The two closest grid points to one-half are

```text
r_-=(M-1)/2,       r_+=(M+1)/2.                            (6)
```

They are distinct integers strictly between zero and M. If N divided either
one, it would divide `2r_+-M=1` or `M-2r_-=1`, impossible since N>1.
Their distance from one-half is `u_*=1/(2M)<delta`, because p>e.
This explicitly resolves parity, nonzero displacement, and candidate exclusion.

## 4. A polynomial lower bound for the exact total weight

At either point (6), the even factors satisfy

```text
H_(2a)=4 sin^2(pi a/M) >=16 a^2/M^2,     1<=a<=e.          (7)
```

Here a/M<1/2, so the chord bound `sin(pi x)>=2x` on [0,1/2]
applies. The odd factors are `4 cos^2(x_j)` with
`x_j=pi(2j-1)/(2M)`. Since `sin^2 x<=x^2`, pi<4, and N>2k,

```text
sum_j sin^2(x_j) <= k pi^2/(4N^2) < 1/k <= 1/40.
```

For numbers q_j in [0,1], induction gives
`product_j(1-q_j)>=1-sum_j q_j`. Therefore the odd-factor product
is at least `4^k/2`. Combining (7) over a=1,...,e gives, at each point,

```text
Q(r_+/M)=Q(r_-/M) >= 4^k 16^e (e!)^2/(2 M^(2e)).         (8)
```

Both points contribute to the exact average, so

```text
A >= 4^k 16^e (e!)^2/M^(2e+1)
  >= 4^k (e!)^2/[2^(2e+3) k^(4e+2)] > 0.                 (9)
```

The final inequality uses `N<4k`, `p<2k`, and hence `M<8k^2`.
This is a lower bound from two actual, nonexcluded grid points. It does not
replace the discrete average by an integral or assume that a continuous peak
contains a grid point.

## 5. Uniform exponential suppression outside U

For every t, with u=|t-1/2|, the exact product is

```text
Q(t)=4^(k+e) product_(a=1)^e sin^2(2 pi a u)
                 product_(j=1)^k cos^2(pi(2j-1)u).
```

Set `S_k(u)=sum_(j=1)^k sin^2(pi(2j-1)u)`. The elementary
inequality `1-x<=exp(-x)` and the bound on the even factors give

```text
Q(t)<=4^(k+e) exp(-S_k(u)).                                (10)
```

We prove, uniformly for `delta<=u<=1/2`,

```text
S_k(u)>=k/(1024e^2).                                     (11)
```

There are three exhaustive regions.

1. If `delta<=u<=1/(2k)`, let J=floor(k/2)>=k/4. For j<=J,
   `(2j-1)u<=1/2`, so the sine chord bound gives
   `sin^2(pi(2j-1)u)>=4(2j-1)^2u^2`. Since
   `sum_(j=1)^J(2j-1)^2=(4J^3-J)/3>=J^3`,

   ```text
   S_k(u)>=4u^2 J^3 >=k^3 u^2/16 >=k/(1024e^2).
   ```

   The last step uses `delta=1/(2eN)>=1/(8ek)` from N<4k.

2. If `1/(2k)<=u<=1/2-1/(2k)`, the finite trigonometric sum is

   ```text
   S_k(u)=k/2-sin(4 pi k u)/(4 sin(2 pi u)).               (12)
   ```

   It follows by writing sine squared as `(1-cos(2x))/2` and summing
   the odd-frequency geometric progression. Its denominator is nonzero in
   this region. The chord bound on both halves of [0,pi] gives
   `sin(2 pi u)>=4 min(u,1/2-u)>=2/k`. Hence `S_k(u)>=3k/8`.

3. If `1/2-1/(2k)<=u<=1/2`, put v=1/2-u and
   L=floor(k/4)>=k/8. For j<=L, `(2j-1)v<=1/4`, and
   `sin^2(pi(2j-1)u)=cos^2(pi(2j-1)v)>=1/2`.
   Thus `S_k(u)>=L/2>=k/16`.

For e>=2, the bounds in regions two and three imply (11) as well.
Endpoint overlaps between the regions cause no problem. Formula (12) is
never used at u=0 or u=1/2.

Let `W_out=(1/M)sum_(r/M outside U)Q(r/M)`. Combining (9)--(11),
and using that the number of terms is at most M, gives the uniform bound

```text
W_out/A <= beta_e k^D exp(-k/C),
C=1024e^2,       D=4e+2,       beta_e=2^(4e+3)/(e!)^2.     (13)
```

This bound includes all grid points outside U. Excluded multiples of N
contribute exactly zero; no unweighted candidate count or divisibility
approximation has entered it.

## 6. An explicit integer counterexample for every fixed h

Define the positive integer

```text
L_e=2^(4e+4) C^(D+1) (D+1)!,
k_e=L_e+e+40,      with C=1024e^2 and D=4e+2.             (14)
```

Then k_e> L_e and k_e>=max(40,e+1). For any k>=k_e, the single-term
lower bound `exp(x)>=x^(D+1)/(D+1)!` for x>0 converts (13) to

```text
W_out/A <= beta_e C^(D+1)(D+1)!/k
        = L_e/[2(e!)^2 k] < 1/2.                         (15)
```

On U we have B_h(m)=2; outside U the value is nonnegative. Therefore

```text
T_h >= 2(A-W_out) > A.                                  (16)
```

Equations (2) and (14) specify an explicit finite counterexample for every
positive odd h. Its closed witness is still r=p by (3). The parameter is
deliberately very large; no optimality or small-counterexample claim is made.
The proof uses elementary exponential domination with explicit constants,
not a limit interchange, numerical quadrature, or a huge enumerated grid.

For completeness, the concentration even gives `T_h/A -> 2` as k tends
to infinity with h fixed. Indeed `0<=m<=c<2k`, so (1) implies
`|B_h(m)-2|<=2+(2k)^h`. On U that difference is zero. Thus

```text
|T_h/A-2| <= [2+(2k)^h] beta_e k^D exp(-k/C) -> 0.
```

To verify the last limit without assuming it, bound the exponential below
by its term of degree D+h+1. The right side is then bounded by a constant
depending only on h times `k^(-h-1)+k^(-1)`, which tends to zero.
This optional limit is not needed for the explicit refutation (16).

## 7. Small exact controls and reproducibility

The code below checks only finite boundary/identity controls and the exact
integer parameter algebra. It does not attempt to enumerate the family at
the factorial-sized k_e, calculate its polynomial, or claim finite checking
of the universal proof. The universal result is the manuscript argument above.
The domains are h in {1,3,5,7,9}, m in {0,...,60}, and the fifteen small
members with the corresponding e=h+1 and k in {40,64,100}.

```python
from fractions import Fraction as F
from math import comb, factorial
from pathlib import Path
from hashlib import sha256

bindings={
    'research/astra-general-sparse-route.md':
    '37aac6b4b044504d5ef8c456baa734de1db314edc7e526a0d08080d489c34036',
    'research/astra-weighted-sparse-audit.md':
    '9e0ee5af6fb466f9504c03e2822706461103a8698307e620b1de879aad4e6d1b',
}
for path,digest in bindings.items():
    assert sha256(Path(path).read_bytes()).hexdigest()==digest

def rho(M,x):
    x%=M
    return min(x,M-x)

def choose(n,j):
    return comb(n,j) if 0<=j<=n else 0

families=central_points=0
parameter_digits=[]
for h in (1,3,5,7,9):
    e=h+1
    for m in range(61):
        B=sum((-1)**(j+1)*choose(m,j) for j in range(1,h+1))
        assert B==(0 if m==0 else 1+choose(m-1,h))
        assert B>=0 and (m==0 or B>=1)
    assert sum((-1)**(j+1)*choose(e,j) for j in range(1,h+1))==2

    for k in (40,64,100):
        N=2*k+2*e-1;p=2*k-1;M=N*p;c=k+e-1
        V=tuple(sorted(tuple(range(2,2*e+1,2))+tuple(range(1,2*k,2))))
        lower=V[:-1]
        assert len(V)==len(set(V))==c+1 and 2*c<N
        assert V[-1]==p>2*e and all(0<d<p for d in lower)
        assert sum(V)==k*k+e*(e+1)<=k*p<M<8*k*k
        assert M%2 and p%N and min(rho(M,p*v) for v in V)==p
        delta=F(1,2*e*N)
        assert F(1,8*e*k)<=delta<F(1,2*k)
        J=k//2;L=k//4
        assert 4*J>=k and 8*L>=k
        assert sum((2*j-1)**2 for j in range(1,J+1))>=J**3
        assert 4*delta**2*J**3>=F(k,1024*e*e)
        for j in range(1,p,2):
            if e*j>=p:
                continue
            for sign in (-1,1):
                r=(M+sign*j)//2
                assert 2*r==M+sign*j and 0<r<M and r%N
                assert F(abs(2*r-M),2*M)<delta
                assert [d for d in lower if rho(M,r*d)<p]==list(range(2,2*e+1,2))
                assert all(rho(M,r*v)>p for v in V if v%2)
                central_points+=1
        families+=1

    # Integer/rational parameter checks only: no huge V, polynomial, or grid.
    C=1024*e*e;D=4*e+2
    beta=F(2**(4*e+3),factorial(e)**2)
    bigL=2**(4*e+4)*C**(D+1)*factorial(D+1)
    k=bigL+e+40
    assert k>bigL and k>=max(40,e+1)
    assert beta*C**(D+1)*factorial(D+1)/k==F(bigL,2*factorial(e)**2*k)<F(1,2)
    N=2*k+2*e-1;p=2*k-1;M=N*p
    assert M%2 and k*k+e*(e+1)<=k*p<M<8*k*k
    for sign in (-1,1):
        r=(M+sign)//2
        assert 0<r<M and r%N and e*N<M
    parameter_digits.append((h,len(str(k))))

print({'binomial_identity_controls':5*61,
       'small_family_controls':families,
       'central_candidate_controls':central_points,
       'explicit_parameter_decimal_digits':parameter_digits,
       'scope':'finite checks support the manuscript; no all-k enumeration'})
```

Run from the repository root with standard-library Python only:

```sh
PYTHONDONTWRITEBYTECODE=1 python3 - <<'PY'
import pathlib,re
note=pathlib.Path('research/astra-bonferroni-weight-audit.md').read_text()
program=re.search(r'```python\n(.*?)\n```',note,re.S).group(1)
exec(compile(program,'<bonferroni-review-controls>','exec'))
PY
```

The exact command exited zero. It reported 305 binomial-identity controls,
15 small-family controls, 466 literal central-candidate controls, and five
successful exact large-parameter checks. The decimal lengths of k_e for
h=1,3,5,7,9 were respectively 51, 104, 160, 220, and 282. No grid or
polynomial at those large parameters was constructed. The input hashes
matched, and workflow structural validation passed. These checks corroborate
the displayed formulas; they are not a kernel proof or an independent
mathematical review of the universal argument.

## 8. Remaining boundary

For every fixed odd h, this particular nonnegative product weight puts almost
all normalized mass where exactly h+1 owners are bad, making the odd truncated
overlap count equal two. The sufficient inequality is therefore not universally
available, even though a closed witness exists. This rules out repairing the
specified weighted-incidence approach merely by choosing a larger fixed odd
truncation. A different weight, tuple-dependent order, or different existence
argument remains possible. It supplies no disproof of sparse noncover and no
proof or disproof of the unrestricted canonical Lonely Runner Conjecture.

In particular, if an odd order h is chosen with h>=c, then (1) gives
`B_h(m)=1` for every 1<=m<=c. In that case `T_h=A-W_good`, where W_good
is the Q-weight of closed-good candidates. Every such candidate has strictly
positive Q, so `T_h<A` is exactly a witness-existence test. The present result
does not refute this growing-order identity.

All commands launched for this audit completed. The frozen candidate is ready
for separate independent Astra mathematical review; acceptance is not asserted
by the author or by the finite reproducer.
