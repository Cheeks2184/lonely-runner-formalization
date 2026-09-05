# Independent review of every fixed odd truncation obstruction

Task `/root/affine_grid-bonferroni-weight-review`, requested Astra/xhigh,
2026-09-05. **Accepted without correction**, bound to the entire manuscript
`research/astra-bonferroni-weight-audit.md` at SHA-256
`9116444bc4b55f976a148ecd0431c3032ec4b4d62b7396bd4ed420cc477cfaa0`.
The review was assigned against base/main `f36d99a` after PR15. The author's
earlier starting checkpoint is separately identified in the manuscript.

I read the current configuration, workflow, policy, active state, and full
frozen manuscript. Structural workflow validation and the author's sole
Python reproducer passed. The independent controls below also passed.
Only this review note was written; no Lean, source, Git, shared-state,
dependency, or cache changes were made. No huge tuple, polynomial, or grid
at the explicit factorial-sized threshold was constructed. This is an
independent mathematical review of the universal argument, supported by
finite exact controls, not a kernel-checked theorem.

## 1. Exact quantifiers, domain, and sufficient implication

The statement proved is: for each **fixed positive odd integer h**, put
`e=h+1`. With the explicit integer `k_e` of manuscript (14), every integer
`k>=k_e` yields a sparse tuple for which `T_h>A`, despite the closed witness
`r=p`. This is stronger than merely selecting an unspecified large k for
each h. It makes no assertion when h grows with the tuple.

Pascal telescoping gives, for all nonnegative integers m,
`B_h(0)=0` and `B_h(m)=1+binom(m-1,h)` for m positive. The zero convention
for binomial coefficients handles h>=m, including the telescoping identity
at h=m. Oddness is essential to the nonnegative upper approximation:
`B_h(m)>=1` for positive m, and `B_h(e)=2`. For example, order two at m3
instead gives zero. Thus complete coverage of the pivot candidates implies
`T_h>=A`; the implication `T_h<A => noncover` is sound.

The family contains e positive even speeds and k positive odd speeds.
Since `e<=k-1`, the odd pivot `p=2k-1` is strictly larger than every even
speed. All speeds are distinct; c=k+e-1 are genuine lower owners and
`N=2c+1`, so `2c<N`. The denominator N is retained exactly as stated.
This is an auxiliary sparse instance, not a list of N-1 moving speeds.

The degree calculation has no alias gap:
`k^2+e(e+1)<=k^2+k(k-1)=kp<Np=M`. Hence averaging Q over all M roots
of unity equals its ordinary constant term A. The average is normalized
by M, not by the number of nonexcluded candidates. The pivot factor
vanishes exactly on excluded grid points `N|r`; no primality of N or p
is assumed or used. Strict lower badness uses `rho_M(rd)<p`, preserving
goodness at equality.

At r=p, the time is exactly 1/N. Each original speed satisfies `1<=v<N`,
so `rho_M(pv)=p*min(v,N-v)>=p`. Speed one attains equality and `p<N`
ensures r is a genuine candidate. This verifies the actual-coordinate
witness independently of the weight argument.

## 2. Central geometry and positive total mass

Here `e>=2`, `k>=40`, `2k<N<4k`, and `p>2e`. If
`u=|t-1/2|<delta=1/(2eN)`, every even speed 2a has circle distance
`2a*u<1/N`. Every odd speed v has distance `1/2-v*u`; there is no wrap
because `v*u<1/(2e)<=1/4`. This distance is strictly greater than 1/4,
and hence than 1/N. Therefore precisely the e even lower owners are bad
throughout U. The pivot is strictly good there, so an excluded grid point
cannot lie in U.

Since N and p are odd, M is odd. The residues `(M-1)/2` and `(M+1)/2`
are distinct genuine candidates: `N|r` would imply `N|1`. Their nonzero
displacement is `1/(2M)<delta`, since p>e. The lower bound for A therefore
uses two actual grid points and does not assume a continuous peak meets
the grid.

At these points the e even factors contribute at least
`16^e*(e!)^2/M^(2e)`, by the sine chord inequality on `[0,1/2]`.
For the k odd factors, writing their cosine arguments as x_j gives

```text
sum_j sin^2(x_j) <= k*pi^2/(4N^2) < 1/k <= 1/40.
```

The first inequality uses `2j-1<=p` and `M=Np`; the strict second one
uses `pi<4` and `N>2k`. For numbers q_j in `[0,1]`, the elementary
product inequality `product(1-q_j)>=1-sum(q_j)` now gives an odd-factor
product greater than `4^k/2`. Thus the two points together imply

```text
A >= 4^k*16^e*(e!)^2/M^(2e+1)
  >= 4^k*(e!)^2/[2^(2e+3)*k^(4e+2)] > 0.
```

The last exponent and power of two are correct:
`16^e/8^(2e+1)=2^(-2e-3)`, and `M<8k^2` follows from `N<4k,p<2k`.
The factor two from the two grid points cancels the preceding denominator
two; no normalization factor is missing.

## 3. Independent verification of all three tail regions

The exact factorization about one-half and `1-x<=exp(-x)` give
`Q(t)<=4^(k+e)*exp(-S_k(u))`, where
`S_k(u)=sum_(j=1)^k sin^2(pi*(2j-1)*u)`. Dropping the even sine factors
only enlarges the nonnegative product. It remains to bound S uniformly
for `delta<=u<=1/2`.

1. For `u<=1/(2k)`, put `J=floor(k/2)`. Then `J>=k/4`, and every
   selected argument `(2j-1)u` lies in `[0,1/2]`. The exact sum of odd
   squares is `(4J^3-J)/3>=J^3`. The chord bound yields
   `S>=4u^2J^3>=k^3u^2/16`. Since `delta>=1/(8ek)`, this is at least
   `k/(1024e^2)`.
2. For `1/(2k)<=u<=1/2-1/(2k)`, the denominator in the displayed finite
   trigonometric sum is positive. Independently, the Laurent identity

   ```text
   (z-z^-1) sum_(j=1)^k [z^(2j-1)+z^(-(2j-1))]
      = z^(2k)-z^(-2k)
   ```

   gives precisely `S=k/2-sin(4*pi*k*u)/(4*sin(2*pi*u))` after
   substitution `z=exp(2*pi*i*u)`. The chord lower bound on both halves
   gives `sin(2*pi*u)>=4*min(u,1/2-u)>=2/k`. Consequently `S>=3k/8`.
3. For `1/2-1/(2k)<=u<=1/2`, let `v=1/2-u` and
   `J'=floor(k/4)>=k/8`. The selected arguments satisfy
   `(2j-1)v<=1/4`. Since the odd frequencies exchange sine squared and
   cosine squared on reflection about one-half, each selected term is
   at least 1/2. Thus `S>=J'/2>=k/16`.

These regions are exhaustive, with harmless shared endpoints. In
particular `delta<1/(2k)` because `eN>k`. The floors work for odd k as
well as even k. The last two estimates exceed `k/(1024e^2)` for e>=2.
The trigonometric quotient is never used at 0 or 1/2; the third region
includes 1/2 without a singular expression. Therefore the tail bound
holds on the entire complement of the **open** central region.

## 4. Explicit threshold and optional fixed-order limit

There are at most M terms in the outside sum. Combining the preceding
uniform tail bound with the positive A lower bound gives exactly

```text
W_out/A <= beta*k^D*exp(-k/C),
C=1024e^2, D=4e+2, beta=2^(4e+3)/(e!)^2.
```

The power in beta is `4^e*2^(2e+3)=2^(4e+3)`; no outside candidate-count
estimate is required. Define `L_e=2^(4e+4)*C^(D+1)*(D+1)!` and
`k_e=L_e+e+40`. For **every** k>=k_e, all earlier side conditions hold
and k>L_e. Since k/C>0, the single nonnegative exponential-series term
of degree D+1 gives

```text
W_out/A <= beta*C^(D+1)*(D+1)!/k
        = L_e/[2*(e!)^2*k] < 1/2.
```

This is an explicit algebraic estimate, not an appeal to eventual
domination with an unspecified threshold. On U the truncation equals
two; outside it is nonnegative. Hence
`T_h>=2*(A-W_out)>A`, proving the claimed counterexamples for all fixed
positive odd orders.

The optional limit is also valid. For fixed h, `0<=m<=c<2k` bounds
`|B_h(m)-2|` by `2+(2k)^h`; the difference vanishes on U. Multiplying the
tail estimate by that polynomial and bounding the exponential below by
its term of degree D+h+1 leaves a constant depending only on h times
`k^(-h-1)+k^-1`. This tends to zero. The proof keeps h fixed throughout;
neither this limit nor the explicit threshold provides control for an
order varying with the tuple.

## 5. Independent exact controls

The author block passed with its reported 305 binomial, 15 family, 466
central-candidate, and five parameter checks. The independent block below
uses 27 small families, including odd k and the cases `e=k-1`; 716 central
candidates; 54 first-outside perturbations; 80 Laurent telescoping checks;
710 binomial checks; and 18 explicit parameter checks. It also retains
an even-order negative control. The chosen outside points demonstrate
that the strict central condition cannot be extended indiscriminately.
In fact no grid point is exactly on this central boundary: equality
would require `e*abs(2r-M)=p`, impossible because e is even and p is odd.
The proof itself does not rely on omitting boundary points.

The rational product controls test the inequalities used in the lower
bound, without numerical sine, cosine, or exponential evaluations. Only
integers and Fractions are used. The large-parameter controls construct
the few defining integers; they do not construct their tuples or grids.
These finite checks corroborate the preceding all-parameter proof, not
replace any of its quantifiers.

```python
from fractions import Fraction as F
from hashlib import sha256
from math import comb, factorial, prod
from pathlib import Path

bindings = {
    'research/astra-bonferroni-weight-audit.md':
    '9116444bc4b55f976a148ecd0431c3032ec4b4d62b7396bd4ed420cc477cfaa0',
    'research/astra-general-sparse-route.md':
    '37aac6b4b044504d5ef8c456baa734de1db314edc7e526a0d08080d489c34036',
    'research/astra-weighted-sparse-audit.md':
    '9e0ee5af6fb466f9504c03e2822706461103a8698307e620b1de879aad4e6d1b',
}
for path, digest in bindings.items():
    assert sha256(Path(path).read_bytes()).hexdigest() == digest

pairs = sorted(set(
    [(e,k) for e in (2,4,6,10) for k in (40,41,43,63,65,101)]
    + [(40,41), (62,63), (100,101)]))
central = outside = 0
for e, k in pairs:
    N = 2*k+2*e-1
    p = 2*k-1
    M = N*p
    V = tuple(range(2,2*e+1,2)) + tuple(range(1,2*k,2))
    lower = V[:-1]
    assert k >= max(40,e+1) and len(set(V)) == len(V) == k+e
    assert 2*len(lower)+1 == N and max(lower) < p < N
    assert sum(V) == k*k+e*(e+1) <= k*p < M < 8*k*k
    assert N > 2*k and M % 2 and p % N
    def rho(r,v):
        residue = r*v % M
        return min(residue, M-residue)
    assert min(rho(p,v) for v in V) == p
    delta = F(1,2*e*N)
    J, ell = k//2, k//4
    assert 4*J >= k and 8*ell >= k
    assert (4*J**3-J)//3 == sum((2*j-1)**2 for j in range(1,J+1)) >= J**3
    assert F(2*J-1,2*k) < F(1,2) and F(2*ell-1,2*k) < F(1,4)
    assert 4*J**3*delta**2 >= F(k,1024*e*e)
    assert F(3*k,8) >= F(k,1024*e*e) and F(ell,2) >= F(k,1024*e*e)
    q = [F(4*v*v,M*M) for v in range(1,2*k,2)]
    assert sum(q) < F(1,k) and all(0 <= z <= 1 for z in q)
    assert prod(1-z for z in q) >= 1-sum(q) > F(1,2)
    assert F(16**e,8**(2*e+1)) == F(1,2**(2*e+3))
    js = [j for j in range(1,p+2,2) if e*j < p]
    assert js and js[0] == 1
    for j in js:
        for sign in (-1,1):
            r = (M+sign*j)//2
            assert 0 < r < M and r % N
            assert F(abs(2*r-M),2*M) < delta
            assert tuple(v for v in lower if rho(r,v) < p) == tuple(range(2,2*e+1,2))
            assert all(rho(r,v) > p for v in V if v % 2)
            central += 1
    j = js[-1]+2
    assert e*j > p and e*(j-2) < p
    for sign in (-1,1):
        r = (M+sign*j)//2
        assert F(abs(2*r-M),2*M) > delta and rho(r,2*e) >= p
        outside += 1

for k in range(2,82):
    terms = {}
    for j in range(1,k+1):
        for a in (2*j-1,-2*j+1):
            terms[a+1] = terms.get(a+1,0)+1
            terms[a-1] = terms.get(a-1,0)-1
    assert {a:b for a,b in terms.items() if b} == {2*k:1,-2*k:-1}

binomial = 0
for h in range(1,20,2):
    for m in range(71):
        lhs = sum((-1)**(j+1)*comb(m,j) for j in range(1,min(h,m)+1))
        rhs = 0 if m == 0 else 1+(comb(m-1,h) if h < m else 0)
        assert lhs == rhs and lhs >= 0 and (m == 0 or lhs >= 1)
        binomial += 1
    assert 1+comb(h,h) == 2
assert sum((-1)**(j+1)*comb(3,j) for j in (1,2)) == 0

parameters = 0
for e in (2,4,6,10,20,40):
    C, D = 1024*e*e, 4*e+2
    beta = F(2**(4*e+3),factorial(e)**2)
    L = 2**(4*e+4)*C**(D+1)*factorial(D+1)
    for k in (L+e+40, 2*(L+e+40), 10*(L+e+40)+1):
        assert k > L and k >= max(40,e+1)
        assert beta*C**(D+1)*factorial(D+1)/k == F(L,2*factorial(e)**2*k) < F(1,2)
        N, p = 2*k+2*e-1, 2*k-1
        M = N*p
        assert k*k+e*(e+1) <= k*p < M < 8*k*k
        for sign in (-1,1):
            r = (M+sign)//2
            assert 0 < r < M and r % N and F(1,2*M) < F(1,2*e*N)
        parameters += 1
assert (len(pairs),central,outside,binomial,parameters) == (27,716,54,710,18)
print({'small_families':len(pairs), 'central_candidates':central,
       'first_outside_controls':outside, 'Laurent_identities':80,
       'binomial_controls':binomial, 'parameter_controls':parameters,
       'acceptance':'every fixed positive odd order, manuscript proof only'})
```

Exact replay command, run from the repository root:

```sh
PYTHONDONTWRITEBYTECODE=1 python3 - <<'PY'
from pathlib import Path
import re
for name in ('research/astra-bonferroni-weight-audit.md',
             'research/astra-bonferroni-weight-review.md'):
    blocks = re.findall(r'```python\n(.*?)\n```', Path(name).read_text(), re.S)
    assert len(blocks) == 1
    exec(compile(blocks[0], name, 'exec'), {})
PY
python3 scripts/validate_workflow.py
```

## 6. Accepted scope and remaining limitation

The explicit all-h family disproves universal availability of every fixed
odd Bonferroni truncation of this particular nonnegative product weight.
It does not disprove sparse noncover: each instance has the closed
actual-grid witness proved above. It neither resolves LRC nor excludes
different weights, tuple-dependent truncation orders, or other existence
arguments. In particular, for odd h>=c, the binomial identity gives
`B_h(m)=1` for `1<=m<=c`, and hence `T_h=A-W_good`. Every closed-good
candidate has positive Q, so that inequality is exactly a witness test.
The fixed-order obstruction does not refute or turn that growing-order
identity into new existence supply.

No correction to the frozen manuscript is required. All commands recorded
for this review completed; the acceptance rests on the exact source hash
and mathematical derivation, not on workflow or runtime status.
