# Fourier formulas for modular pivot bad sets

This note records an exact fixed-pivot calculation. It is a possible analytic
interface, not a proof of a uniform pivot certificate.

Fix positive integers `N >= 2` and `a`, put `M = N*a`, and use the normalized
Fourier transform on `Z/MZ`

\[
\widehat f(k)=\frac1M\sum_{r=0}^{M-1}f(r)e^{-2\pi i k r/M}.
\]

## Candidate filter

Let `c(r)=1` when `N` does not divide `r`, and zero otherwise. The divisible
residues form the subgroup `{N*s : 0 <= s < a}`. Its geometric sum gives

\[
\widehat c(k)=\mathbf 1_{k=0}-\frac1N\mathbf 1_{a\mid k}.
\]

Thus `c-hat(0)=1-1/N`, every nonzero multiple of `a` has coefficient `-1/N`,
and every other coefficient vanishes.

## Strict cyclic interval and multiplication pullback

Let

\[
A=\{x\in\mathbb Z/M\mathbb Z:\rho_M(x)<a\}.
\]

Because `a <= M/2`, including the antipodal case `N=2`, the strict set is
represented exactly by the integers `-(a-1),...,a-1`. Hence

\[
\widehat{1_A}(k)=\frac1M D_{a-1}(2\pi k/M),
\qquad
D_h(\theta)=\sum_{y=-h}^{h}e^{-iy\theta}.
\]

At frequency zero this is `(2*a-1)/M`; away from zero it is the usual real
Dirichlet quotient

\[
\frac1M\frac{\sin((2a-1)\pi k/M)}{\sin(\pi k/M)}.
\]

Now fix a positive integer `b`, let `d=gcd(b,M)`, `M'=M/d`, and
`b'=b/d`. Multiplication by `b'` is invertible modulo `M'`. Put

\[
h=\left\lfloor\frac{a-1}{d}\right\rfloor.
\]

For `g(r)=1_A(b*r)`, periodicity with period `M'` gives

\[
\widehat g(k)=0\quad\text{unless }d\mid k.
\]

If `k=d*ell` and `u` is the inverse of `b'` modulo `M'`, then substitution in
`Z/M'Z` gives

\[
\widehat g(d\ell)=\frac1{M'}D_h(2\pi \ell u/M').
\]

For `M'=1`, interpret `u` as the unique element of the trivial quotient (or
handle that case separately); then `h=0` and the coefficient is one. The floor
is the strict-boundary calculation: `rho_M(d*y)<a` is equivalent to
`rho_(M')(y) <= floor((a-1)/d)`. The formula also covers `M'=1` by reading the
single Dirichlet sum as one.

## Actual bad-set indicator

The pivot bad-set indicator for the other speed `b` is the pointwise product
`beta=c*g`. Product becomes convolution under the normalized transform. Using
the sparse candidate-filter coefficients,

\[
\widehat\beta(k)
=\widehat g(k)-\frac1N\sum_{q=0}^{N-1}\widehat g(k-q a).
\]

The elementary Dirichlet estimate yields

\[
|\widehat g(d\ell)|
\le \min\left(\frac{2h+1}{M'},
\frac{1}{M'|\sin(\pi\ell u/M')|}\right)
\]

when the denominator is nonzero, and `g-hat(k)=0` off the gcd-supported
frequencies. Combining this with the convolution gives an explicit bound for
every bad-set coefficient.

This estimate alone does not prove uniform main-term domination for the
product of all good-set indicators. Near-zero Dirichlet coefficients can be
large, and the convolution over many runners can overwhelm the zero-frequency
term. A successful Fourier proof still needs cancellation or an arithmetic
selection of a pivot controlling the combined nonzero spectrum.

## Absolute main-term domination is not necessary

For an exact good-count factorization

\[
H(r)=c(r)\prod_{i\ne j}(1-\beta_i(r)),
\]

one tempting sufficient condition is that the all-zero Fourier convolution
term strictly exceed the sum of the absolute values of every other zero-sum
frequency tuple. This condition already fails for the distinct tuple
`(1,2,3)` with `N=4` and pivot `a_j=3`, even though residues `3` and `9` are
explicit certificates. The bad sets are

```text
B1 = {1,2,10,11}
B2 = {1,5,6,7,11}.
```

The all-zero term and total absolute zero-sum convolution are exactly

\[
T_0=\frac7{24},\qquad
A=\frac{37}{72}+\frac{\sqrt3}{18}.
\]

Thus the non-main remainder exceeds the main term by

\[
A-2T_0=\frac{4\sqrt3-5}{72}>0,
\]

where positivity follows from `48>25`. This disproves necessity of the
absolute main-term criterion at the smallest distinct certified dimension.
The tuple `(4,5,9)` is a stronger finite diagnostic: every pivot has explicit
good residues and every pivot fails this criterion.

The estimate is also factorization-dependent. Replacing each actual bad
indicator `beta_i=c*g_i` by the algebraically equivalent outer factorization
`c*prod_i(1-g_i)` makes pivot `3` of `(1,2,3)` pass, while at pivot `1` the
`beta` factorization passes and the raw-`g` factorization fails. Consequently
triangle-bound domination is not an invariant property of the good-count
function. Any viable Fourier proof needs signed cancellation or a more stable
positive-definite/Riesz-product device, not arbitrary factorwise absolute
values.

The formulas were independently audited for normalization, inverse direction,
the `N=2` antipode, and `M'=1`. Reproduce the numerical cross-check with

```sh
python3 scripts/check_fourier_badsets.py
```

It enumerates all frequencies for `N=2..7`, `a=1..9`, and `b=0..3M`. This
finite check is regression evidence only; it also reproduces the
factorization counterexamples above. The displayed geometric-sum,
change-of-variables, and exact `(1,2,3)` calculations are the mathematical
justification.
