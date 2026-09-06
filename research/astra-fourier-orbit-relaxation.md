# The orbit-only zero-weight relaxation remains witness-dominated

Date: 2026-09-06. Task `/root/uniform_fourier_orbit_relaxation`, using the
existing `/root/uniform_seed_coupling` session with requested Astra/xhigh
routing. Source checkpoint: `8e5fd81f95d1a33ce8ed2cd347815bda24d9401f`.
Only this report is worker-owned. Status: manuscript check of root's proposed
finite argument; independent final review remains required.

**Result.** The proposed barrier is valid. If `p/q` is a supplied witness
at margin `a/q`, the specified Fourier ratio cannot exceed `a/q`, even when
the sign of f is unrestricted at every zero-weight orbit sample. No global
maximality assumption is needed. This relaxation alone therefore cannot
exclude the supplied point as a global maximizer by certifying a strictly
larger gap. No feasibility, equality or optimum claim is made.

This is a direct finite form of the triangular-kernel argument in Theorem 1
of [Gonçalves–Ramos](https://link.springer.com/article/10.1007/s00574-021-00272-7),
read earlier in this session. It checks one proposed relaxation and makes
no literature-novelty claim.

## Exact hypotheses

Let `q>=2`, let p be an integer coprime to q, and let a be an integer with
`1<=a` and `2a<=q`. Let V be a finite set of positive integer speeds satisfying

```text
||p v/q|| >= a/q        for every v in V.              (W)
```

Write `e(x)=exp(2 pi i x)`. Let f be a finite even real trigonometric
polynomial with

```text
f(x)=sum_(k=-D)^D c_k e(kx),
c_(-k)=c_k in R,               f(0)>0,
c_k>=0 outside {0} union V union (-V).                (F)
```

Extend coefficients by zero outside the degree range; `c_0` need not be
positive. Impose only the sample signs

```text
f(ps/q)<=0 whenever 1<=s<=q-1 and q does not divide as. (S)
```

No interval sign is assumed. Omitted samples may have either sign. Since
p is coprime to q, s=0 is the only sample representing zero, and multiplication
by p permutes the grid. All speeds use the same p/q.

## 1. The cyclic hat is an exact interval autocorrelation

For a residue r modulo q, define

```text
dist_q(r)=min_(m in Z) |r-mq|,
H(r)=max(a-dist_q(r),0),
I={0,...,a-1} subset Z/qZ.
```

Then

```text
H(r)=#{(u,v) in I x I : v-u=r mod q}.                (1)
```

To verify (1), ordinary differences v-u lie in `[-a+1,a-1]`. Reduction
modulo q is injective on that interval: two such differences differ in
absolute value by at most `2a-2<=q-2<q`. A residue at circular distance
`d<a` has one difference representative in the interval, with multiplicity
`a-d`. A residue at distance at least a has none. This gives exactly H.

For even q and `a=q/2`, the antipodal residue has H value zero, with no
double-counting or endpoint correction.

Define the finite geometric sum

```text
D_a(s)=sum_(j=0)^(a-1) e(js/q),       w_s=|D_a(s)|^2.
```

Finite character orthogonality and (1) give the exact expansion

```text
H(r)=(1/q) sum_(s=0)^(q-1) w_s e(sr/q).              (2)
```

Indeed, expanding `w_s` gives terms `e(s(u-v)/q)`. After multiplication
by `e(sr/q)`, the average over s is one precisely when `v-u=r mod q`.
This checks the plus sign in (2), including for negative r.

Every `w_s` is nonnegative and `w_0=a^2`. For `1<=s<=q-1`, the denominator
in the geometric-series expression is nonzero, and

```text
D_a(s)=[1-e(as/q)]/[1-e(s/q)],
w_s=0  iff  q divides as.                            (3)
```

For composite q the zero set is still exactly (3): if `d=gcd(a,q)`, its
nonzero members are `q/d,2q/d,...,(d-1)q/d`. For `a=1`, every weight is one,
including at `q=2`; there are no nonzero zero-weight samples.

## 2. The finite pairing bounds the ratio by the supplied margin

Hypothesis (W) says `dist_q(pv)>=a`. Thus `H(pv)=0` for every v, and
evenness of H also gives `H(-pv)=0`. The exceptional coefficients at
`+/-v` may have either sign, but all their contributions vanish. Every
other nonconstant contribution `c_k H(pk)` is nonnegative by (F), since
H is nonnegative. Because `H(0)=a`, this proves

```text
a c_0 <= sum_(k=-D)^D c_k H(pk).                     (4)
```

Insert (2) and interchange only finite sums:

```text
sum_k c_k H(pk)
  = (1/q) sum_(s=0)^(q-1) w_s sum_k c_k e(spk/q)
  = (1/q) sum_(s=0)^(q-1) w_s f(ps/q).               (5)
```

No assumption `D<q` is needed. Aliasing is retained exactly in (5); every
unrestricted speed coefficient still has zero H factor in (4).

For every nonzero s with `w_s>0`, condition (3) makes (S) applicable. If
`w_s=0`, its summand is zero regardless of the value of f. Separating s=0
in (5) therefore gives

```text
a c_0 <= (1/q) sum_s w_s f(ps/q)
       <= (a^2/q) f(0).
```

Since `a>0` and `f(0)>0`, division yields

```text
c_0/f(0) <= a/q.                                    (6)
```

Closed equality in (W) gives H value zero. The coefficient sign, sample sign
and positive denominator have each been used explicitly. No global
maximizer hypothesis was used.

## Consequence and precise limitation

Let `mu(p/q)=min_(v in V)||pv/q||` for a nonempty V. The supplied inequalities
already give `mu(p/q)>=a/q`. Combining this with (6) shows that any lower
ratio from this relaxed class is no stronger than the known value at p/q.
If the actual value is `mu(p/q)=a/q`, no such certificate can prove
`gap(V)>mu(p/q)` by obtaining a larger ratio. Assuming p/q to be a global
maximizer adds nothing to the pairing and cannot turn it into a contradiction.
In particular, when `a/q<1/N`, this class cannot reach the target `1/N`.

No optimum or attainment is asserted. The earlier uniform-grid screen was
read in the preceding task and its binding checked again here:

```text
9b2d6ac78271d61d62bc201358243b5236c2afd51b4cd6e33d685699112b4bb5
research/astra-uniform-fourier-lp-cap.md
```

The barrier allows every finite degree. It does not cover different signs,
kernels, phase constraints or LP/SDP formulations. It neither proves that
the supplied point is maximal nor supplies an arbitrary-N witness. No solver
or Lean implementation is justified solely for this excluded improvement.

## Actual verification receipt

Current project config, workflow, policy and focused active state were read.
The command `python3 -B scripts/validate_workflow.py` exited 0 with output

```text
workflow structural validation passed; it cannot certify mathematical validity.
```

Verification is the displayed hand argument. No mathematical program, solver,
enumeration, Lean invocation or cache restoration was used. Hashing and
whitespace checks concern documentation only. No shared state, Git data,
cache or other source was edited. Independent mathematical review remains
required; the unrestricted project goal remains open.
