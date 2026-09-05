# Exact failure of uniform weighted bad-incidence supply

Task `/root/vanishing_slope-weighted-sparse-audit`, requested Astra/xhigh,
2026-09-05. The current project workflow, policy, active state, and accepted
general-sparse manuscript/review were read; structural validation passed.
Only this note was edited. No Lean, Git, global-state, dependency, or cache
changes were made. No additional agent or external computation was used.

**Disposition:** the proposed uniform sufficient condition `T_bad<A` is
false, already for N=35, p=31, and 17 distinct genuine lower owners with
`2*17<35`. A rational certificate proves `T_bad>(101/100)A`. The tuple
nevertheless has both a closed and a strict witness on its actual pivot
grid. This is an exact counterexample to universal availability of this
weighted-incidence condition, not to sparse noncover or LRC. Common scaling
gives counterexamples to the condition at arbitrarily large pivot height.
The result is a manuscript/computational certificate awaiting independent
review, not a Lean kernel theorem.

## 1. Exact sufficient condition and its stronger premise

Retain the accepted notation. For N>=3, p>0, and c distinct lower speeds
`0<d_i<p` with `2c<N`, put M=Np and

```text
R={0<=r<M : N does not divide r},
H_v(z)=2-z^v-z^(-v),
Q=H_p product_i H_(d_i),  A=CT(Q),
z_r=exp(2 pi i r/M),
m(r)=number of lower labels i with rho_M(r*d_i)<p,
T_bad=(1/M) sum_(0<=r<M) m(r) Q(z_r).
```

Badness is strict and equality at p is good. Since H_p vanishes when N|r,
points outside R contribute zero to Q and T_bad. The degree argument in the
accepted manuscript gives `(1/M)sum_r Q(z_r)=A` exactly. Every Q(z_r) is
nonnegative. Thus complete coverage would give `T_bad>=A`, proving the
one-way sufficient implication `T_bad<A => noncover`.

Let G be the closed-good candidates and let
`W_good=(1/M)sum_(r in G)Q(z_r)`. The exact identity is

```text
A-T_bad = W_good
           -(1/M)sum_(r in R, m(r)>=1) (m(r)-1)Q(z_r).   (1)
```

On G every original speed has distance at least 1/N>0, so all factors of
Q are positive. Consequently `W_good>0` is equivalent to G being nonempty.
The extra overlap term in (1) is why T_bad<A has no such converse. The
counterexample below makes that difference quantitative.

## 2. The starting N=9 case genuinely improves on the factor estimate

For N=9, p=5, lower owners `(1,2,3,4)`, and full V=`(1,2,3,4,5)`, the
accepted calculation gives A=12 and lower-deletion sum S=44. Concavity of
sine on `[0,pi/6]` gives `gamma_9=4 sin^2(pi/9)>=4/9`, so
`gamma_9*S>=176/9>12`: the older simple factor criterion fails.

The weighted-incidence condition itself succeeds. For
`x=rho_M(rv)/M` in `[0,1/2]`, the elementary bounds `sin y<=min(1,y)` and
`pi<22/7` give the rational factor upper bound

```text
H_v(z_r) <= 4 min(1, ((22/7)*x)^2).
```

Multiply these nonnegative bounds over the five speeds and sum with the
literal integer multiplicity m(r), skipping N|r where the product is zero.
The exact rational result is

```text
T_bad <= 268573232580726195617792 / 71247850975245287109375
       < 4 < 12=A.                                     (2)
```

This establishes a strict improvement of sufficient domains; it does not
suggest a universal inequality. At this grid the multiplicity counts are
`m=0:18, m=1:16, m=2:4, m=4:2` among the 40 candidates.

## 3. A structured sparse counterexample

Take

```text
N=35, p=31, M=1085,
V={2,4} union {1,3,5,...,31},
lower owners={2,4} union {1,3,5,...,29}.
```

There are 18 distinct positive moving speeds, of which c=17 are strictly
below the actual pivot 31. Thus `2c=34<35`. This is exactly the sparse
auxiliary domain; N is not being changed to the canonical denominator for
these 18 moving speeds.

To compute A without numerical integration, set
`P(z)=product_(v in V)(1-z^v)`. Then `Q(z)=P(z)P(z^(-1))`, so for the
integer coefficients `P(z)=sum a_e z^e`,

```text
A=sum_e a_e^2=860.
```

The product has degree `1+3+...+31+2+4=262<M`. Thus the ordinary constant
term, the coefficient-square sum, and the actual M-grid average agree.
The small integer multiplication computing 860 is reproduced below.

The mechanism is deliberate: at time near 1/2, all odd-speed factors are
large, while speeds 2 and 4 are both strictly bad. Their two vanishing
factors at exactly 1/2 do not prevent the nearby region from carrying most
of the relevant weight.

### Sixteen literal candidates with exactly two bad owners

For j in `{1,3,5,7,9,11,13,15}`, take the two integer residues

```text
r_(j,+)=(M+j)/2,  r_(j,-)=(M-j)/2,
t_(j,+/-)=1/2 +/- j/(2M).
```

They are distinct and lie in `[0,M)`. If N divided one of them, it would
divide j because `2r=M+/-j`; but `0<j<N`. They are therefore genuine
candidates, not excluded grid points.

Speed 2 has residue distance j and speed 4 has residue distance 2j. Both
are strictly below p=31, including the endpoint `2j=30<31`. For any odd
speed v<=31, its circle distance at these points is

```text
1/2-vj/(2M) >= 1/2-(31*15)/(2*1085)=2/7>1/35.
```

There is no wrap in that formula because `vj/(2M)<=3/14<1/2`.
Thus every central point has m(r)=2 exactly, with only lower speeds 2 and
4 bad; the pivot and every other original row are good.

### Rational lower bound on their weight

Write `y_j=j/(2M)`. At either central point,

```text
Q(z_r)=4^18 sin^2(2*pi*y_j) sin^2(4*pi*y_j)
                 product_(v=1,3,...,31) cos^2(pi*v*y_j).
```

Use only the elementary bounds `3<pi<22/7`,
`sin x>=x-x^3/6`, and `cos x>=1-x^2/2` for the small nonnegative angles
appearing here. Define the rational numbers

```text
s_(a,j)=3*a*y_j-(3*a*y_j)^3/6,             a in {2,4},
c_(v,j)=1-((22/7)*v*y_j)^2/2,             v odd, 1<=v<=31,
L=(2*4^18/M) sum_(j odd,1<=j<=15)
       s_(2,j)^2 s_(4,j)^2 product_(v odd,1<=v<=31) c_(v,j)^2.
```

All these s and c are positive. Every angle bounded above using 22/7 is
less than 1. On `[0,1]`, the polynomial `x-x^3/6` is increasing, so
`sin(a*pi*y_j)>=s_(a,j)` follows first from the sine lower bound and then
from pi>3. The cosine inequality and pi<22/7 give the stated cosine lower
bound. Positivity permits squaring and multiplying. These steps prove

```text
W_central=(1/M)sum_(the sixteen central r)Q(z_r) >= L.
```

The strict rational comparison in the reproducer is

```text
200 L > 101 A = 86860.                                  (3)
```

No floating-point sign or estimate enters (3). Since all omitted
contributions to T_bad are nonnegative and every central m equals two,

```text
T_bad >= 2 W_central >= 2 L > (101/100)A > A.             (4)
```

This is an exact rejection of the proposed universal strict inequality.
For clarity, the elementary trigonometric bounds do not require a table of
transcendental approximations: `3<pi` follows from the inscribed regular
hexagon, and `pi<22/7` follows from the positive integral
`integral_0^1 x^4(1-x)^4/(1+x^2) dx=22/7-pi`. The sine and cosine bounds
follow by successive integration of `sin x<=x` and `cos x<=1` on the
nonnegative range. The exact rational code also checks the angle and
positivity side conditions used above.

## 4. Actual witnesses and unbounded height, without a supply claim

There is no sparse cover obstruction. At r=p=31, time is exactly 1/35.
Every v in V lies between 1 and 31, so its circle distance is at least
1/35. This is a literal candidate and speed 1 attains the closed boundary.

There is also a strict candidate r=33. Since every v is between 1 and 31,

```text
33 <= 33v <= 1023=M-62,
```

and hence all original residue distances are at least 33>p. The minimum
is exactly 33, realized at speed 1. This gives a strict actual-grid witness
without a safe-row search. In particular W_good>0 despite (4).

For any positive integer b, scale all 18 speeds and the actual pivot by b.
The new modulus is bM. At its point r/(bM), the product and bad multiplicity
are the original functions of r modulo M. Reduction modulo M has b equal
fibers, and the candidate exclusion is preserved because N divides M.
Thus A and T_bad are unchanged. All hypotheses, the failure (4), and the
strict witness numerator r=33 persist at pivot 31b. This proves failure
at unbounded height for the same fixed N; no claim about every N is made.

## 5. Bounded discovery and exact reproducibility

Screening considered the N=9 starting control and the ten prescribed family
members `V_k={2,4} union {1,3,...,2k-1}`, `N=2k+3`, for
`k in {5,8,12,16,20,24,30,40,50,64}`. Floating-point sums were used only
to select k=16 for certification. This was not an exhaustive search or a
minimal-counterexample claim. No subsequent search is needed for the proof.
All promoted inequalities, domains, endpoints, and witnesses are established
by the following integer/Fraction-only reproducer.

```python
from fractions import Fraction as F
from math import prod
from pathlib import Path
from hashlib import sha256

bindings={
    'research/astra-general-sparse-route.md':
    '37aac6b4b044504d5ef8c456baa734de1db314edc7e526a0d08080d489c34036',
    'research/astra-general-sparse-review.md':
    'f2bd2af612470521c08c1d031883ec56a1255f60086370b4af4bccdf413ba408',
}
for name,digest in bindings.items():
    assert sha256(Path(name).read_bytes()).hexdigest()==digest

def distance(M,x):
    residue=x%M
    return min(residue,M-residue)

def coefficients(V):
    P={0:1}
    for v in V:
        Q=dict(P)
        for e,a in P.items():
            Q[e+v]=Q.get(e+v,0)-a
        P={e:a for e,a in Q.items() if a}
    return P

def constant(V):
    return sum(a*a for a in coefficients(V).values())

# Positive control: exact factorwise rational upper bound, not a float sum.
N,p=9,5
M=N*p;V=(1,2,3,4,5)
A=constant(V)
S=sum(constant(V[:i]+V[i+1:]) for i in range(len(V)-1))
assert (A,S)==(12,44) and F(4,9)*S>A
U=F(0);histogram={}
for r in range(M):
    if r%N==0:
        continue  # H_p is exactly zero here.
    rho=[distance(M,r*v) for v in V]
    multiplicity=sum(x<p for x in rho[:-1])
    histogram[multiplicity]=histogram.get(multiplicity,0)+1
    factors=[4*min(F(1),F(22*x,7*M)**2) for x in rho]
    U+=multiplicity*prod(factors)
U/=M
assert U==F(268573232580726195617792,71247850975245287109375)
assert U<4<A
assert histogram=={4:2,2:4,1:16,0:18}

# Structural counterexample: only sixteen weighted grid points are needed.
N,p=35,31
M=N*p
odds=tuple(range(1,32,2))
V=tuple(sorted((2,4)+odds))
lower=V[:-1];c=len(lower)
assert len(V)==len(set(V))==18 and c==17 and 2*c<N
assert V[-1]==p and all(0<d<p for d in lower)
P=coefficients(V);A=sum(a*a for a in P.values())
assert max(P)==sum(V)==262<M and A==860

central=set();L=F(0)
for j in range(1,16,2):
    y=F(j,2*M)
    for sign in (-1,1):
        assert (M+sign*j)%2==0
        r=(M+sign*j)//2
        assert 0<=r<M and r%N
        central.add(r)
        bad=[d for d in lower if distance(M,r*d)<p]
        assert bad==[2,4]
        assert distance(M,2*r)==j and distance(M,4*r)==2*j<p
        assert all(F(distance(M,r*v),M)>=F(2,7) for v in odds)
    sine_lowers=[]
    for a in (2,4):
        xlo=3*a*y
        xhi=F(22,7)*a*y
        assert 0<xlo<xhi<1
        value=xlo-xlo**3/6
        assert value>0
        sine_lowers.append(value)
    cosine_lowers=[]
    for v in odds:
        xhi=F(22,7)*v*y
        assert 0<xhi<1
        value=1-xhi**2/2
        assert value>0
        cosine_lowers.append(value)
    lower_product=4**len(V)*prod(x*x for x in sine_lowers+cosine_lowers)
    L+=F(2,M)*lower_product
assert len(central)==16
assert 200*L>101*A
assert 2*L>F(101,100)*A>A

assert p%N and min(distance(M,p*v) for v in V)==p
assert 33%N and min(distance(M,33*v) for v in V)==33>p
# Finite scaling controls corroborate the proved arbitrary-b transport.
for b in (1,2,7,100):
    assert all(distance(b*M,33*b*v)==b*distance(M,33*v) for v in V)
    assert 33<b*M and min(distance(b*M,33*b*v) for v in V)>b*p
    assert constant(tuple(b*v for v in V))==A

print({'N9_weighted_upper':str(U),'N9_A':12,
       'N35_A':A,'central_points':len(central),
       'certified_Tbad_over_A_lower':'101/100',
       'closed_witness_numerator':31,'strict_witness_numerator':33,
       'uniform_weighted_incidence':'refuted only'})
```

The accepted source inputs are bound inside the reproducer. The independent
review supplies the exact finite-grid averaging and weighted-good versus
weighted-incidence distinction; the new counterexample does not modify
either accepted result. A passing structural validator is only workflow
evidence. Neither the original factor criterion nor this stronger weighted
incidence criterion now provides a universal sparse supply theorem. A new
weight, a genuinely stronger aggregate estimate, or a different existence
mechanism is required; directly testing positive good-set mass would merely
test witness existence again. The canonical LRC goal remains unresolved.
