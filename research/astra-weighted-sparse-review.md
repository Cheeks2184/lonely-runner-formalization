# Independent review of weighted sparse incidence

Task `/root/affine_grid-weighted-sparse-review`, requested Astra/xhigh,
2026-09-05. **Accepted without correction** at the following exact binding:

| Input | SHA-256 |
| --- | --- |
| `research/astra-weighted-sparse-audit.md` | `9e0ee5af6fb466f9504c03e2822706461103a8698307e620b1de879aad4e6d1b` |
| `research/astra-general-sparse-route.md` | `37aac6b4b044504d5ef8c456baa734de1db314edc7e526a0d08080d489c34036` |
| `research/astra-general-sparse-review.md` | `f2bd2af612470521c08c1d031883ec56a1255f60086370b4af4bccdf413ba408` |

The entire frozen audit was read, its sole reproducer passed, and the
independent integer/Fraction controls below passed. The supplied source
checkpoint was `96a47f0`; the byte hashes above bind this acceptance.
Current configuration, workflow, policy, and active task state were read;
`python3 scripts/validate_workflow.py` passed. Only this review note was
written. No Lean, dependency, cache, Git, shared-state, or author-source
change was made. This accepts a mathematical manuscript and exact finite
certificates, not a new kernel-checked theorem or a universal supply result.

## 1. Meaning of the condition

For the stated genuine lower owners, let `M=Np`,
`Q(z)=H_p(z) product_i H_(d_i)(z)`, and `H_v=2-z^v-z^(-v)`.
On the unit circle, `H_v=4 sin^2(pi*v*t)>=0`. The sparse hypotheses imply
`c+1<=N` and `p+sum_i d_i<Np`; hence every nonconstant frequency of Q has
absolute value less than M. Averaging on all M roots of unity therefore
gives exactly `A=CT(Q)`. At excluded residues `N|r`, the pivot factor is
zero. This uses the actual pivot p and denominator M, not an average over
the smaller set R of candidates.

Let `m(r)` count the **strict** lower bad inequalities
`rho_M(r*d_i)<p`. On candidates, `m=0` is precisely closed goodness for
every original speed, including the pivot. Splitting `sum (1-m)Q` into
`m=0` and `m>=1` proves the displayed identity (1) in the audit. At a good
point every factor is positive, since every phase distance is at least
`1/N>0`. Thus positive weighted good-set mass is equivalent to a witness.
In contrast, `T_bad<A` requires good mass to exceed a nonnegative overlap
penalty. It is sufficient, but its necessity does not follow from this
identity. The explicit N35 example below proves that necessity is false.

## 2. Positive control at N9

For `N=9,p=5,V=(1,2,3,4,5)`, direct Laurent convolution independently
gives `A=12` and the four lower-deletion constant terms sum to `S=44`.
Concavity between 0 and `pi/6` gives `sin(pi/9)>=1/3`; consequently the
old sufficient estimate fails because `4 sin^2(pi/9) S>=176/9>12`.

The factorwise rational upper bound uses the distance `x` in `[0,1/2]`,
so `sin(pi*x)<=min(1,pi*x)`. Squaring, using `pi<22/7`, and multiplying
nonnegative upper bounds is valid. The independent check sums reflected
pairs of candidates, using their literal bad multiplicities. It recovers
exactly

```text
U=268573232580726195617792/71247850975245287109375 < 4 < 12.
```

Its multiplicity counts are `m0:18,m1:16,m2:4,m4:2` among 40 candidates.
In particular, the example establishes a real enlargement of the older
factor criterion's sufficient domain; no converse or universal claim is
used to establish that comparison.

## 3. Independent N35 lower-bound proof

Here `N=35,p=31,M=1085` and
`V={2,4} union {1,3,...,31}`. There are 17 distinct positive lower owners,
all below the actual pivot, with `34<35`. The degree is 262. Direct
convolution by each Laurent factor `2-z^v-z^(-v)` produces a symmetric
array of length 525 and constant term **860**, independently of the
author's coefficient-square method.

The sixteen residues selected by
`abs(2*r-M) in {1,3,...,15}` are genuine candidates: `35|r` would force
`35|abs(2r-M)`. Write `y=abs(2r-M)/(2M)`. The two even speeds have distances
`j` and `2j` in integer residue units, both below 31. Every odd speed v has
circle distance `1/2-v*y>=2/7`, with `v*y<=3/14<1/2`. Thus the exact lower
bad multiplicity is two; the pivot is good. No boundary equality was
silently treated as bad.

The trigonometric factorization into two squared sines and sixteen
squared cosines is exact at both reflected residues. Its rational lower
bounds are valid as follows:

- For `f(x)=x-x^3/6`, `f'(x)=1-x^2/2>=1/2` on `[0,1]`. Applying
  `sin x>=f(x)` first and then this monotonicity with `pi>3` gives the
  sine lower bounds. It would not be enough to replace pi inside an
  arbitrary oscillating sine expression.
- For cosine, `cos x>=1-x^2/2` and `pi<22/7` give the stated lower
  polynomial. Every rational upper angle is at most `33/49<1`; every
  cosine lower bound is at least `3713/4802>0`. The sine lower bounds are
  also positive. Squaring and multiplying therefore preserve order.
- The elementary sine and cosine inequalities follow by integration from
  `sin x<=x` and `cos x<=1` on this range. The manuscript's hexagon and
  positive-integral justifications for `3<pi<22/7` are correct. No
  transcendental numerical approximation is needed.

The independent code selects all sixteen residues directly and sums one
lower product per residue, instead of doubling a sum over eight positive
offsets. Calling this rational lower bound L, it proves the sharper bracket

```text
4343817/10000 <= L < 4343818/10000.
101*A/200 = 4343/10 < 4343817/10000.
```

Thus `W_central>=L>101*A/200`. The sixteen points have multiplicity two,
whereas the definition of L has not included that multiplicity. All
remaining contributions are nonnegative, so
`T_bad>=2*W_central>=2L>101*A/100>A`. The reflection factor and the
multiplicity factor are distinct; neither has been omitted or counted
twice.

## 4. Boundaries, witnesses, and arbitrary common scaling

Independent perturbation controls give the following results for both
`r=(1085-j)/2` and `r=(1085+j)/2`:

| j | Candidate? | Strictly bad lower speeds | Pivot distance in residue units |
| --- | --- | --- | --- |
| 15 | yes | 2, 4 | 310 |
| 17 | yes | 2 | 279 |
| 29 | yes | 2 | 93 |
| 31 | yes | none | 62 |
| 33 | yes | none | 31 |
| 35 | no | none | 0 |

At j31 speed 2 has distance exactly 31 and is good. At j33 the pivot is
on its closed boundary. These controls distinguish the central strict
badness range, the lower boundary, and candidate exclusion.

At the actual numerator r31, all distances are at least 31, with equality
for speed 1. At r33, the elementary interval
`33<=33v<=1023=1085-62` gives minimum distance exactly 33. The tuple
therefore has a strict actual-grid witness despite `T_bad>A`. Adjacent
numerator controls, recorded in the reproducer, also include failing,
strictly good, closed-good, and excluded points.

For every positive integer b, the scaled factors at numerator r satisfy
`H_(bv)(exp(2*pi*i*r/(bM)))=H_v(exp(2*pi*i*r/M))` and
`rho_(bM)(r*b*v)=b*rho_M(r*v)`. The latter identity preserves the strict
bad multiplicity. Reduction modulo M has b equal fibers and preserves
candidate exclusion because `N|M`. Dividing the sum by bM consequently
preserves T_bad. The exponent substitution also preserves the constant
term A. No coprimality assumption on b is required. The numerator 33
remains a strict witness with minimum `33b>31b`.

The code checks seven scales, including b35 and b10^9, over every original
residue and speed; the preceding identity, not those finite checks, proves
the arbitrary-b claim. Scaled tuples need not be primitive, consistently
with the manuscript's domain. This gives unbounded pivot height at fixed
N35, not a statement for every N.

## 5. Reproduction and final scope

Run the sole Python block below from the repository root using Python 3.
It uses no project imports, floating point, symbolic algebra package, or
trigonometric evaluator. It binds all inputs, convolves Laurent factors,
uses a reflected upper sum and a separate sixteen-point lower sum, and
checks exact boundary and scaling controls. The author's sole Python
block was also replayed and passed, as did the workflow validator. The
historical floating-point discovery screen was not rerun or used as
evidence for any inequality, minimality, or exhaustive-search claim.

```python
from collections import Counter
from fractions import Fraction as F
from hashlib import sha256
from math import prod
from pathlib import Path

bindings = {
    'research/astra-weighted-sparse-audit.md':
    '9e0ee5af6fb466f9504c03e2822706461103a8698307e620b1de879aad4e6d1b',
    'research/astra-general-sparse-route.md':
    '37aac6b4b044504d5ef8c456baa734de1db314edc7e526a0d08080d489c34036',
    'research/astra-general-sparse-review.md':
    'f2bd2af612470521c08c1d031883ec56a1255f60086370b4af4bccdf413ba408',
}
for name, digest in bindings.items():
    assert sha256(Path(name).read_bytes()).hexdigest() == digest

def dist(M, x):
    t = x % M
    return min(t, M-t)

def laurent(V):
    coeff = [1]
    offset = 0
    for v in V:
        nxt = [0] * (len(coeff) + 2*v)
        for i, w in enumerate(coeff):
            nxt[i] -= w
            nxt[i+v] += 2*w
            nxt[i+2*v] -= w
        coeff, offset = nxt, offset+v
    return coeff, offset

def constant(V):
    coeff, offset = laurent(V)
    return coeff[offset]

N, p = 9, 5
M = N*p
V = tuple(range(1, 6))
assert constant(V) == 12
assert sum(constant(V[:i]+V[i+1:]) for i in range(4)) == 44
assert F(4, 9)*44 > 12
hist = Counter()
half = F(0)
for r in range(1, (M+1)//2):
    if r % N == 0:
        continue
    rho = [dist(M, r*v) for v in V]
    assert rho == [dist(M, (M-r)*v) for v in V]
    m = sum(x < p for x in rho[:-1])
    hist[m] += 2
    half += m*4**len(V)*prod(min(F(1), F(22*x, 7*M)**2) for x in rho)
U = 2*half/M
assert U == F(268573232580726195617792, 71247850975245287109375)
assert U < 4 < 12 and hist == {0:18, 1:16, 2:4, 4:2}

N, p = 35, 31
M = N*p
odds = tuple(range(1, 32, 2))
V = tuple(sorted((2, 4)+odds))
lower = V[:-1]
assert len(V) == len(set(V)) == 18 and 2*len(lower) < N
assert V[-1] == p and all(0 < d < p for d in lower)
coeff, degree = laurent(V)
assert len(coeff) == 525 and degree == 262 < M and coeff[degree] == 860
assert coeff == coeff[::-1] and sum(coeff) == 0
central = [r for r in range(M) if abs(2*r-M) in range(1, 16, 2)]
assert len(central) == 16
L = F(0)
mincos, maxangle = F(1), F(0)
for r in central:
    y = F(abs(2*r-M), 2*M)
    assert r % N and [d for d in lower if dist(M, r*d) < p] == [2, 4]
    assert all(F(dist(M, r*v), M) == F(1, 2)-v*y for v in odds)
    assert all(F(dist(M, r*v), M) >= F(2, 7) for v in odds)
    squares = []
    for a in (2, 4):
        lo, hi = 3*a*y, F(22, 7)*a*y
        assert 0 < lo < hi < 1
        value = lo-lo**3/6
        assert value > 0
        squares.append(value*value)
        maxangle = max(maxangle, hi)
    for v in odds:
        hi = F(22, 7)*v*y
        assert 0 < hi < 1
        value = 1-hi*hi/2
        assert value > 0
        squares.append(value*value)
        mincos, maxangle = min(mincos, value), max(maxangle, hi)
    L += F(4**len(V), M)*prod(squares)
assert maxangle == F(33, 49) and mincos == F(3713, 4802)
assert F(4343817, 10000) <= L < F(4343818, 10000)
assert 2*L > F(101*860, 100) > 860

expected = {
    15: (True, (2, 4), 310), 17: (True, (2,), 279),
    29: (True, (2,), 93), 31: (True, (), 62),
    33: (True, (), 31), 35: (False, (), 0),
}
for j, result in expected.items():
    for sign in (-1, 1):
        r = (M+sign*j)//2
        assert (M+sign*j) % 2 == 0
        got = (r % N != 0, tuple(d for d in lower if dist(M, r*d) < p),
               dist(M, r*p))
        assert got == result
assert dist(M, ((M+31)//2)*2) == p
nearby = {r: min(dist(M, r*v) for v in V) for r in range(30, 38)}
assert nearby == {30:30, 31:31, 32:32, 33:33, 34:31, 35:0, 36:31, 37:12}
assert 31 % N and 33 % N
scale_checks = 0
for b in (1, 2, 3, 7, 35, 100, 10**9):
    assert 33 < b*M and min(dist(b*M, 33*b*v) for v in V) == 33*b > 31*b
    for r in range(M):
        for v in V:
            assert dist(b*M, r*b*v) == b*dist(M, r*v)
            scale_checks += 1
        assert (r % N == 0) == ((r+M) % N == 0)
assert scale_checks == 136710
print({'N9_A_S': (12, 44), 'N9_upper': str(U),
       'N35_A_degree': (860, 262), 'central_points': len(central),
       'L_bracket': '[4343817/10000,4343818/10000)',
       'boundary_controls': 12, 'distance_scaling_checks': scale_checks,
       'accepted': 'weighted-incidence counterexample and positive control only'})
```

The accepted negative result is exactly failure of universal availability
of this specific weighted-incidence sufficient condition. It does not
refute sparse noncover: the same tuple has the strict witness just proved.
It does not refute LRC, establish the condition's behavior for every N, or
supply the still-missing dense/canonical existence argument. Replacing the
condition by positivity of weighted good-set mass would restore an exact
witness test, not provide independent existence supply.
