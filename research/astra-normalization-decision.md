# A finite exact decision reduction for all external moduli

Status: complete manuscript reduction and arithmetic controls, 2026-09-05.
This note specifies a terminating exact decision procedure for a fixed
odd prime `N` and fixed primitive positive `N-1`-tuple `V`. It decides the
normalization predicate A/B/R from `research/astra-union-supply-audit.md`,
including all common modular units, independent signs, permitted lifts,
and external moduli. The symbolic decision engine is not implemented here.
No all-modulus failure for a particular tuple is claimed in this note.

The reduction is valid: A/R become finitely many one-variable formulas
of degree at most two. Feasible intervals contain the required coprime
integer pairs in every admissible residue class. Feasible point atoms must
instead pass an exact rationality and reduced-pair test. B is a separate
finite divisor scan. Thus exact rejection of every finite case certifies
all-modulus failure of these normalization contracts, not failure of LRC.

## 1. Input and exact decision target

Fix an odd prime `N`, and positive integers `V_1,...,V_k`, where `k=N-1`
and `gcd(V_1,...,V_k)=1`. Distinctness is appropriate to the intended LRC
application but is not needed for the finite reduction itself.

For integers `M>=2` and `1<=c<M` with `gcd(c,M)=1`, let

```text
d_i=min(c*V_i mod M, (-c*V_i) mod M),
Small(i) := 0<d_i and (N-1)*d_i<M and N does not divide d_i.
```

The three predicates are:

* A: `Small(i)` for every label.
* B: some label `p` satisfies `M|V_p`, `N` does not divide `V_p`, and
  `Small(i)` for every other label.
* R: choose a positive signed residue `z_i` for every label. The set
  `Z={i : N|z_i}` is nonempty. With `L=min_Z z_i` and `H=max_Z z_i`,
  require

  ```text
  H<(N-1)*L,
  N*H*L <= ((N-1)*L-H)*M,
  0<z_i<L and N*z_i*L <= (L-z_i)*M       for every i outside Z.
  ```

The target is existence of any `M,c` satisfying A, B, or R. The preceding
union manuscript proves this is exactly the permitted union of A, B,
coarse one-zero C, and robust multiple-zero normalization. Coarse C is
the singleton-zero case of R. In particular, this target already accounts
for common lifts divisible by `N` when `N` does not divide `M`, the regime
`N|M`, and positive Nat representatives obtained with independent `N*M`
additions. None of these choices may be silently removed by the decision
procedure.

## 2. Velocity cells and arithmetic classes

Put `x=c/M in (0,1)`. Form the finite sorted breakpoint set

```text
T={0,1} union {j/V_i : 1<=i<=k, 1<=j<V_i}.
```

On each consecutive open cell `J=(alpha,beta)` of `T`, every integer
`q_i=floor(V_i*x)` is constant. Define two affine functions there:

```text
f_i^+(x)=V_i*x-q_i,
f_i^-(x)=q_i+1-V_i*x=1-f_i^+(x).
```

Both are strictly between 0 and 1 throughout the cell. Their integer
versions at `x=c/M` are the two positive signed residues

```text
M*f_i^+(c/M)=V_i*c-q_i*M,
M*f_i^-(c/M)=(q_i+1)*M-V_i*c.
```

There are at most `sum_i(V_i-1)+1` cells. Repeated breakpoints are merged.
At an internal breakpoint, at least one `V_i*x` is an integer, so that
coordinate has residue zero for both signs. A and R are impossible there:
they require a positive base smaller than `M`. In particular one must not
mistake `1-f_i^+=1` at such a breakpoint for a valid negative residue.
The external endpoints 0 and 1 are outside the permitted ratio range.
B at a velocity breakpoint is handled separately below.

For A/R, enumerate the `N^2-1` ordered class pairs

```text
(u,m) in {0,...,N-1}^2 minus {(0,0)},
c == u (mod N),       M == m (mod N).
```

The excluded pair cannot occur because `gcd(c,M)=1`. Every other pair
will be shown realizable densely in each nonempty open interval. On a
fixed cell and class pair, zero divisibility for either signed option is
determined by the constants

```text
delta_i^+ = V_i*u-q_i*m                    mod N,
delta_i^- = (q_i+1)*m-V_i*u                mod N.           (6)
```

Notice `delta_i^- = m-delta_i^+`, not generally `-delta_i^+`.
This distinction preserves the large signed zero-base options when
`N` does not divide `M`. When `m=0`, both signs are zero slopes together;
when `m!=0`, they cannot both be zero slopes.

## 3. Exact linear and quadratic formulas

For the fixed cell and arithmetic classes, A is the formula

```text
and_i [ or_{sigma in {+,-}}
  (delta_i^sigma != 0 and (N-1)*f_i^sigma(x) < 1) ].        (A-cell)
```

Positivity is automatic inside the velocity cell. Since `N>=3`, the
strict size bound implies that the chosen base is below `M/2`, so this
formula is equivalent to the absolute-residue definition of A. It uses
only linear inequalities and constant divisibility tests. No extra split
at half-residue points is necessary.

For R, enumerate an anchor label `p` and sign `tau` with
`delta_p^tau=0`, and put

```text
lambda(x)=f_p^tau(x),       D(x)=1+N*lambda(x).
```

The anchor is the attained minimum zero base divided by `M`. It is
positive throughout the cell. Require first that the anchor itself is a
valid zero option:

```text
lambda*D <= (N-1)*lambda.                                 (anchor)
```

For every other label `i`, require at least one sign whose option is:

```text
zero:      delta_i^sigma=0,
           f_i^sigma >= lambda,
           f_i^sigma*D <= (N-1)*lambda;

ordinary:  delta_i^sigma!=0,
           f_i^sigma*D <= lambda.                         (R-cell)
```

Every displayed variable expression is a polynomial inequality of degree
at most two with integer coefficients. The equalities or inequalities on
the `delta` values are constants within this case. The anchor's sign is
fixed; the remaining row choices are independent once it is fixed. Taking
the disjunction over at most `2*k` anchors therefore covers R without
enumerating all signed partitions.

**Lemma 1 (exact anchor equivalence).** At a rational point in the cell
with the prescribed reduced-pair classes, R holds if and only if at least
one of the anchor formulas holds.

For the forward direction, choose any row attaining the integer minimum
`L`. Divide bases and bounds by `M` or `M^2` as appropriate, and put
`lambda=L/M`. The zero bound is exactly

```text
(H/M)*(1+N*lambda) <= (N-1)*lambda.
```

Every smaller zero base satisfies that bound too and is at least `lambda`.
The ordinary inequality becomes `f_i*(1+N*lambda)<=lambda`.

Conversely, choose a valid option for each row, retaining the anchor's
chosen option. All selected zero bases are at least the anchor, so its
integer base is the attained minimum `L`. Their maximum satisfies the
zero bound. Because every base is positive and `D>1`, this same bound
implies the strict span `H<(N-1)L`. Likewise the ordinary bound implies
`0<z_i<L` strictly, as well as its required coarse size inequality.
Thus no extra span premise, endpoint relaxation, or guessed minimum is
being introduced by (R-cell). All-zero and empty-ordinary cases are included.

## 4. Coprime rational pairs with any admissible prescribed classes

**Lemma 2 (constructive density).** Let `N` be prime. Fix
`0<=u,m<N`, not both zero, and any nonempty open interval
`(ell,rho) subset (0,1)` with rational endpoints. There exist
`1<=c<M`, `M>=2`, with

```text
gcd(c,M)=1,       c==u (mod N),       M==m (mod N),
ell<c/M<rho.
```

Moreover the following finite construction gives explicit size bounds.

Choose a reduced rational `a/b` strictly inside the interval such that

```text
Delta=a*m-b*u != 0.
```

Only the single value `u/m`, when `m!=0`, could violate this condition.
For example try the midpoint of the interval, then `(2*ell+rho)/3` if
necessary, reducing the chosen rational. Here `0<a<b` and `gcd(a,b)=1`.
For a positive integer `k`, set

```text
c(k)=N*a*k+u,       M(k)=N*b*k+m.
```

Any common prime divisor of these two integers divides their fixed
determinant

```text
b*c(k)-a*M(k)=b*u-a*m=-Delta.                              (7)
```

The prime `N` cannot divide both because `(u,m)!=(0,0)`. For any prime
`p` dividing `Delta` with `p!=N`, at least one of `a,b` is nonzero modulo
`p`. Thus at least one coefficient `N*a,N*b` is invertible modulo `p`.
The two equations

```text
N*a*k+u == 0 (mod p),      N*b*k+m == 0 (mod p)
```

have exactly one simultaneous solution class for `k`. The invertible
coefficient fixes it uniquely; the determinant condition `p|Delta`
ensures that the other equation agrees. This reasoning also covers
`a==0 (mod p)` or `b==0 (mod p)`. Choose any other class modulo `p`.
Even when `p=2`, a different class exists. CRT over the finitely many
distinct primes gives a progression

```text
k == k0 (mod Q),
Q=product_{p|Delta, p!=N} p,       0<=k0<Q.
```

If the product is empty, use `Q=1,k0=0`. Every positive `k` in this
progression gives `gcd(c(k),M(k))=1`: any common prime would contradict
either the class restriction at `N` or one of the avoided classes.

Here is an explicit termination bound. Put

```text
epsilon=min(a/b-ell, rho-a/b)>0,
K=max(1, floor(|Delta|/(N*b^2*epsilon))+1).
```

Choose the first `k>=K` in the progression. Then `K<=k<K+Q`, and

```text
|c(k)/M(k)-a/b|
  = |Delta| / (b*(N*b*k+m))
  <= |Delta| / (N*b^2*k)
  < epsilon.
```

Consequently the ratio lies in the desired interval, so `0<c<M`.
The integer construction gives `M>=2` automatically, and

```text
M < N*b*(K+Q)+N.                                          (8)
```

This handles both `u=0,m!=0` and `m=0,u!=0`; it does not assume that
both numerator and denominator are units modulo `N`. Primality matters
for the stated class criterion: at composite modulus 6, classes `(2,4)`
are not both zero but every corresponding integer pair has a common
factor 2. No such case occurs for the prime `N` used here.

If an open interval has algebraic rather than rational endpoints, first
choose rational endpoints of a smaller nonempty interval within it.
Exact real-root isolation supplies these effectively. Thus Lemma 2 applies
to every nonempty open atom in the polynomial decomposition below.

## 5. Point atoms cannot use density or scaling

All ratios `c/M` are rational. An isolated feasible irrational algebraic
point is therefore not realizable. If a point is rational, write it in
lowest terms as `p/q in (0,1)`. Then

```text
c/M=p/q and gcd(c,M)=1, 0<c<M
    imply c=p and M=q.                                    (9)
```

Indeed equality and coprimality force the two positive reduced numerator-
denominator pairs to agree. Multiplying both by an integer to change their
classes is forbidden by `gcd(c,M)=1`. Therefore a rational point contributes
a solution in a class case `(u,m)` exactly when

```text
q>=2,       p mod N=u,       q mod N=m,
and the exact cell formula is true at p/q.
```

These checks apply to every critical point atom, whether or not it is an
isolated connected component of the feasible set. Feasible intervals have
already been handled independently by Lemma 2. Strict inequalities must
be evaluated at the point itself: replacing a formula by its closure would
be unsound.

For a concrete endpoint control, use `N=7,V=(1,2,3,4,7,14)` on the cell
`(0,1/14)`, take all positive signs and zero anchor `lambda=7*x`.
With classes `(u,m)=(1,3)`, its four ordinary classes are nonzero and the
last two zero. The most restrictive ordinary inequality is

```text
4*x*(1+49*x)<=7*x,       equivalently x<=3/196.
```

The zero inequalities are weaker here. The endpoint `x=3/196` has actual
reduced classes `(3,0)`, so it is not a solution in the `(1,3)` case.
It is a valid R solution in its actual class: `c=3,M=196`, ordinary bases
`(3,6,9,12)`, zero bases `(21,42)`, with equality in the base-12 ordinary
bound. This illustrates why arithmetic point classes must be checked and
why valid non-strict coarse equalities must not be discarded.

For the real-algebraic backend, the formula
`x^2=1/2` in `(0,1)` is a simple isolated irrational control. Its unique
positive feasible point is real but cannot be any permitted `c/M`.
This is a backend control, not a claim that that formula is an R instance.

## 6. A terminating exact decision procedure

The following procedure is complete for fixed inputs `N,V`.

1. **Finite B scan.** For each label `p` with `N` not dividing `V_p`,
   enumerate all divisors `M>=2` of `V_p` and all units `1<=c<M`.
   Check B directly with integer arithmetic. These are all B possibilities;
   `M<=max_i V_i`. Return any successful actual pivot and signed bases.

2. **Velocity cells.** Construct `T` and its open cells. Boundary points
   do not enter A/R. As a positive B boundary control,
   `N=7,V=(1,2,3,4,5,31),M=31,c=1` satisfies B with pivot 31 and
   ordinary bases 1 through 5, while that pivot has residue zero and
   prevents A/R at `x=1/31`.

3. **Class cases and anchors.** For every velocity cell and every one
   of the `N^2-1` arithmetic class pairs, construct (A-cell) and all
   eligible (R-cell) anchor formulas using (6). False constant choices
   may be discarded immediately.

4. **Exact sign decomposition.** For each formula, move each comparison
   to zero and gather the resulting nonconstant, nonzero polynomials;
   their degrees are at most two. Constants, including identically zero polynomials, are
   evaluated as constants and must not create spurious root lists.
   Isolate all real roots inside the current velocity cell, merge equal
   roots, and sort them exactly. Split the cell into open interval atoms
   and individual root atoms. On each open atom every polynomial sign,
   hence the entire Boolean formula, is constant.

5. **Open atom test.** Choose a rational sample in each open atom and
   evaluate its formula exactly. If it is true, construct a reduced
   `c/M` in that atom with the prescribed classes using Lemma 2.
   Evaluate the resulting integer A or R predicate as a final check,
   choose the signs/anchor options it supplies, and return this witness.

6. **Point atom test.** Evaluate the formula exactly at each root atom.
   If true, determine whether that algebraic number is rational. Reject
   irrational points. At rational `p/q`, perform the reduced-pair tests
   (9) and the actual integer predicate check; return a successful pair.

7. **Failure.** If the finite B scan and all A/R atoms reject, conclude
   no allowed `M,c` satisfies A, B, or R.

All arithmetic here is exact. Linear and quadratic roots can be represented
by their rational polynomial, a rational isolating interval, and root index.
Rationality for a quadratic root is decided by whether the discriminant is
a rational square, after handling lower-degree cases. Root equality can be
checked with polynomial gcds; root order can be resolved by exact isolation
and refinement. Evaluating another quadratic at such a root is exact
arithmetic in its degree-at-most-two number field. No floating-point sign,
approximate root equality, or numerical feasibility tolerance is permitted.

An open atom always contains a rational sample, and root isolation is finite
for the finitely many degree-at-most-two polynomials. Lemma 2 has an explicit
finite construction, including trial factorization of the nonzero fixed
integer `Delta`. The B scan is finite. These facts prove termination without
introducing an external modulus cutoff.

**Theorem 3 (soundness and completeness).** The procedure returns a witness
if and only if the exact A/B/R union has some permitted normalization.
Otherwise its finite rejection data certifies all-modulus failure.

Soundness follows from the final integer predicate checks and the exact
normalization equivalence in the preceding manuscript. For completeness,
take any hypothetical witness `M,c`. If B holds it appears in Step 1.
Otherwise its ratio cannot be a velocity breakpoint and lies in one open
cell. Its actual classes are among the enumerated pairs. A holds in its
linear formula, or Lemma 1 supplies an R anchor. The ratio lies either
in an open sign atom or at a critical root. In the former case the whole
atom is feasible and Step 5 produces a witness. In the latter it is
rational with precisely its actual reduced pair, so Step 6 accepts it.
Thus rejection of all cases excludes every modulus.

## 7. Certificate format and practical limits

A positive certificate need only retain `N,V,M,c`, the selected A/B/R
branch, actual signs and bases, the B pivot or R zero set and minimum,
and exact integer checks. If produced from an interval, retaining the
cell, class pair, anchor, rational subinterval, and density construction
also makes the discovery reproducible. The normalized positive speeds
and transported witness can then be generated by the existing bridges.

A negative certificate needs the complete finite divisor/unit rejection
for B and a covering sign decomposition for every A/R cell/class/anchor.
For each open atom, record an exact sample and false formula evaluation.
For each point atom, record a false evaluation, an irrationality certificate,
or a failed actual reduced-pair condition. Defining polynomials, root indices,
isolating intervals, and equality/order evidence must certify that the atoms
cover each entire cell. A checker must verify that coverage and the complete
case enumeration, not trust a search program's final boolean.

The procedure may be expensive: the velocity-cell count grows with the
numerical speeds, and the B unit scans can be large. This note supplies no
polynomial complexity claim or useful uniform upper bound on witness moduli.
It supplies a terminating finite reduction with constructive bounds local
to accepted open atoms. It is an obstruction/search tool, not a uniform
supply mechanism, a proof that supply is easier than LRC, or a resolution
of the canonical conjecture. Implementation and independent review of a
symbolic engine are separate work.

## 8. Source binding and checked arithmetic controls

Read source: `research/astra-union-supply-audit.md`, SHA-256
`dc5cf0ec0d7e0b77b79f998f6419a8d81b5be5851bc861a8701f062d7aec012e`.
The earlier value audit remains bound at
`ef3619bfdf74e5b2794f8d4737623e8d3e9cedf62dd21039f9169465e4dd8090`.
Current project workflow/policy/state were read and the workflow validator
passed. Only this manuscript was edited; no Lean or symbolic engine build
was performed.

The following compact exact controls passed. The density construction was
checked for all admissible pairs at `N=3,5,7`, in two open rational intervals:
160 constructions, including zero numerator class and zero denominator
class. The largest produced denominator was 26,965,681. This finite test is
supplementary to the proof of Lemma 2, not its justification. The rational
R endpoint and the finite B boundary fixture were also checked exactly.

```python
from fractions import Fraction as F
from math import gcd

def prime_divisors(n):
    n, out, p = abs(n), [], 2
    while p*p <= n:
        if n % p == 0:
            out.append(p)
            while n % p == 0:
                n //= p
        p += 1
    if n > 1:
        out.append(n)
    return out

def lift(N, u, m, left, right):
    point = (left+right)/2
    a, b = point.numerator, point.denominator
    if a*m-b*u == 0:
        point = (2*left+right)/3
        a, b = point.numerator, point.denominator
    delta = a*m-b*u
    assert delta != 0
    epsilon = min(point-left, right-point)
    K = max(1, abs(delta)//(N*b*b*epsilon)+1)
    k0, Q = 0, 1
    for p in prime_divisors(delta):
        if p == N:
            continue
        if a % p:
            bad = -u*pow(N*a, -1, p) % p
        else:
            bad = -m*pow(N*b, -1, p) % p
        good = (bad+1) % p
        k0 += Q*((good-k0)*pow(Q, -1, p) % p)
        Q *= p
    k = k0+Q*max(0, -((k0-K)//Q))
    c, M = N*a*k+u, N*b*k+m
    assert K <= k < K+Q and M < N*b*(K+Q)+N
    assert left < F(c, M) < right and gcd(c, M) == 1
    assert (c % N, M % N) == (u, m) and 1 <= c < M
    return c, M

count = largest = 0
for N in (3, 5, 7):
    for u in range(N):
        for m in range(N):
            if u == m == 0:
                continue
            for interval in ((F(1,70), F(1,60)), (F(2,7), F(3,8))):
                c, M = lift(N, u, m, *interval)
                count += 1
                largest = max(largest, M)
assert (count, largest) == (160, 26965681)

N, c, M = 7, 3, 196
bases = [c*v % M for v in (1,2,3,4,7,14)]
L, H = min(bases[-2:]), max(bases[-2:])
assert (c % N, M % N) == (3,0)
assert (c % N, M % N) != (1,3)
assert N*H*L <= ((N-1)*L-H)*M
assert all(N*a*L <= (L-a)*M for a in bases[:-2])
assert N*bases[3]*L == (L-bases[3])*M

N, V, M, c = 7, (1,2,3,4,5,31), 31, 1
assert V[-1] % M == 0 and V[-1] % N != 0
assert all(0 < v and (N-1)*v < M and v % N for v in V[:-1])
assert c*V[-1] % M == 0
print("160 density constructions, rational endpoint, and B boundary passed")
```
