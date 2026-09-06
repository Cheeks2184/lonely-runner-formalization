# Exact rational-grid ceiling for the fixed-sign Fourier lower class

Date: 2026-09-06. Task `/root/uniform_fourier_lp_cap`, using the existing
`/root/uniform_seed_coupling` session with requested Astra/xhigh routing.
Source checkpoint: `1fa1a5fed45c66227b686975d659d80f86dcaeb1`.
Only this report is worker-owned. Status: independent manuscript derivation,
requiring independent review; no Lean result or computational certificate.

**Result.** With the explicit normalization `f(0)>0`, the lower Fourier-ratio
class described below has optimum exactly `1/q` whenever q divides no speed
and all finite degrees are permitted. Consequently its global version has
optimum `1/S`, where S is the sum of the two largest speeds. A fixed degree
limit always obeys the same ceiling; equality is established once it permits
the explicit polynomial constructed below. These are limits on this precise
certificate class, not upper bounds on the actual lonely-runner gap.

## Primary-source scope (under 200 words)

Gonçalves–Ramos (2022), Sections 1.1 and 3, define even real finite
trigonometric classes for Fourier-ratio bounds on `gap(v)`. The minus class
uses nonpositive function values away from zero and nonnegative Fourier
coefficients outside the speed frequencies. Its global cutoff is `1/S`.
Theorem 1's lower-bound proof pairs f with a triangular kernel at a maximizing
time. Section 3 replaces the cutoff by `1/q` and assumes `v in V_q`: a reduced
interior rational time `p/q` attains the global maximum. The plus class gives
upper bounds. The paper's base kernel in Theorem 3 agrees with the construction
below, whose coefficient signs and wider feasibility are proved independently
here. [Official full text, Sections 1.1, 2 and 3](https://link.springer.com/article/10.1007/s00574-021-00272-7),
read 2026-09-06.

The rendered conditions omit `f(0)>0`; every assertion here imposes it.
We use the symmetric frequency exception set `0, +/-v_i`, consistent with
the cosine expansion. A literal all-integer reading of the printed positive
exception list is stricter and still implies our sign hypothesis. No source
numerics or dilation claims are used.

## 1. Exact averaging ceiling

Let V be a finite set of positive integer speeds. Let q be an integer with
`q>=2`, and assume `q` divides no member of V. Write an even real finite
trigonometric polynomial as

```text
f(x) = sum_(k=-D)^D c_k exp(2 pi i k x)
     = c_0 + 2 sum_(k=1)^D c_k cos(2 pi k x),
c_(-k)=c_k in R,       f(0)>0.
```

Coefficients outside this finite range are zero. Impose

```text
c_k >= 0 for k outside {0} union V union (-V),          (F)
f(j/q) <= 0 for j=1,...,q-1.                           (G)
```

There is no sign assumption on `c_0` or on the exceptional speed coefficients.
The nonnegative sign in (F) is essential; reversing it reverses the relevant
averaging comparison. The assumption is imposed on both signs of frequency,
or equivalently on positive frequencies followed by evenness.

**Ceiling lemma.** Under these hypotheses,

```text
c_0/f(0) <= 1/q.                                      (1)
```

**Proof.** A finite geometric sum gives, for every integer k, including
negative k,

```text
(1/q) sum_(j=0)^(q-1) exp(2 pi i k j/q)
    = 1 if q divides k, and 0 otherwise.
```

Interchanging two finite sums therefore yields the exact aliasing identity

```text
A := (1/q) sum_(j=0)^(q-1) f(j/q)
   = sum_(q divides k) c_k
   = c_0 + 2 sum_(m>=1, mq<=D) c_(mq).
```

No nonzero multiple of q is an exceptional speed frequency, because q
divides no speed. Thus (F) gives `c_0<=A`. Condition (G) gives
`A<=f(0)/q`. Dividing by the explicitly positive number `f(0)` proves (1).
No convergence, limiting degree argument, primality or coprimality of q
with the speeds is used. In particular, `q` not dividing a speed is enough;
pairwise coprimality with q is unnecessary. QED.

The stronger interval condition

```text
f(x)<=0 for 1/q <= x <= 1/2                            (I_q)
```

implies (G). For a nonzero residue j modulo q, its circular distance from
zero is between `1/q` and `1/2`; periodicity and evenness fold its argument
into that interval. All endpoints are included.

## 2. An attaining polynomial with every nonconstant coefficient nonnegative

For `q>=3`, put `theta=2 pi/q` and define

```text
c_0=1,
c_j = 1-j/q + sin(j theta)/(q sin(theta)),  1<=j<=q-2,
f_q(x)=1+2 sum_(j=1)^(q-2) c_j cos(2 pi j x).
```

Here `sin(theta)>0`. All nonconstant coefficients are nonnegative. For
`j<=q/2`, both terms in the displayed expression are nonnegative. For
`j>q/2`, set `r=q-j`; then

```text
c_j = [r - sin(r theta)/sin(theta)]/q >= 0.
```

The last inequality follows from

```text
sin(r theta)/sin(theta)
  = exp(i(r-1)theta)+exp(i(r-3)theta)+...+exp(-i(r-1)theta),
```

whose absolute value is at most r by the triangle inequality. Thus (F)
holds for every speed set V, without using which frequencies are exceptional.

Define the finite Fejer polynomial by

```text
K_q(x) = (1/q) |sum_(j=0)^(q-1) exp(2 pi i j x)|^2
       = sum_(|j|<q) (1-|j|/q) exp(2 pi i j x).
```

It is nonnegative and `K_q(0)=q`. The exact identity needed for the sign is

```text
(cos(2 pi x)-cos(theta)) f_q(x) = (1-cos(theta)) K_q(x). (2)
```

For completeness, extend the coefficient formula through j=q; it gives
`c_(q-1)=c_q=0`, as required by the finite polynomial. For `1<=j<=q-1`,
direct linear and sine recurrences give

```text
(c_(j-1)+c_(j+1))/2 - cos(theta)c_j
    = (1-cos(theta))(1-j/q).
```

At frequency zero, `c_1=c_0=1` gives the constant coefficient
`1-cos(theta)`. Negative frequencies follow by evenness, and outside these
ranges both sides have zero coefficients. This proves (2) as a finite
polynomial identity, without numerical coefficient checks.

Evaluating (2) at zero gives `f_q(0)=q>0`. On `1/q<x<=1/2`, cosine is
strictly less than `cos(theta)`, while the right side of (2) is nonnegative.
Hence `f_q(x)<=0`. Continuity supplies the endpoint `x=1/q`, proving (I_q).
The mean coefficient is one, so `c_0/f_q(0)=1/q`.

For `q=2`, use `f_2(x)=1+cos(2 pi x)`: its mean is one, value at zero is two,
and value at `1/2` is zero. Its nonconstant coefficients are nonnegative.

Root proposed this sharpness construction; the finite recurrence, coefficient
positivity, interval sign and normalization were independently checked here.

## 3. Exact optima and uniform implications

Let `L^pos(V,q)` be the supremum of `c_0/f(0)` over polynomials obeying (F),
(I_q), and `f(0)>0`. Positive rescaling equivalently permits `f(0)=1`.
If q divides no speed, Sections 1 and 2 prove

```text
L^pos(V,q) = 1/q.                                     (3)
```

For a fixed degree limit D, the ceiling holds for every D, and equality is
proved for `D>=q-2` when `q>=3`, or `D>=1` when `q=2`. Formula (3) also holds
when the optimization permits every finite degree. No equality claim is made
for a smaller fixed degree limit or an empty feasible class.

For the global class, sort `0<v_1<...<v_n`, where `n=N-1>=3`, and put
`S=v_(n-1)+v_n`. Since `S>max(V)`, S divides no speed. The global interval
condition is exactly (I_S), so its normalized optimum is

```text
L^pos_global(V) = 1/S
```

when finite degree is unrestricted or `D>=S-2`; at any smaller degree it
cannot exceed `1/S`. Distinct positive integers give

```text
S >= (n-1)+n = 2N-3 > N,      hence 1/S < 1/N.
```

Therefore this global lower-certificate class cannot certify the LRC target
for these counts, at any finite degree. Increasing solver accuracy, sample
density or degree cannot defeat the exact ceiling while these signs remain
unchanged. This conclusion concerns exact admissibility, not sampled sign
constraints.

For the q-specific class, suppose `p/q` is an actual rational global
maximizer, as required in the source's `V_q` hypothesis. The true gap is
positive: at time `1/(2 max(V))`, every positive speed has norm strictly
positive. Consequently no speed can be divisible by q, since that speed
would have norm zero at `p/q`. Thus (3) applies.

Moreover, whenever q divides no speed, the common time `1/q` already gives
`||v_i/q||>=1/q` for every i by nonzero integer residues. This fact does not
require knowledge of a maximizing numerator or time. Hence the q-specific
normalized optimum is exactly the direct reciprocal-grid bound:

* If `q>N`, its value `1/q<1/N` cannot certify the target.
* If `q<=N`, the direct time `1/q` already supplies the target.

Knowing a true maximizer denominator is not a new uniform source of that
knowledge. If every denominator `2..N` divides some speed, every denominator
eligible for this missing-speed argument must exceed N. Nothing here bounds
the actual gap above by `1/q`, or asserts that it equals `1/q`.

## Limits and verification

These conclusions apply to the specified Fourier lower class with its exact
nonnegative off-speed coefficients and nonpositive interval values, with
`f(0)>0` explicit. They do not concern arbitrary LP, SDP, Riesz-product or
other Fourier constructions. The positive-sign upper-certificate class has
the opposite use: a large upper bound on the gap gives no lower witness.
Literal unnormalized source claims, dilation assertions and numerical samples
are not promoted by this report.

The elementary averaging theorem and explicit finite recurrence could be
formalized if needed for an audit, but implementing a solver or restoring
Lean dependencies for this fixed lower class would not address the uniform
supply gap. No mathematical program, solver, enumeration or Lean check was
used. The source was read through the official HTML; the source location is
bound by its DOI URL and section identifiers above, without claiming a local
PDF hash. Project config, workflow, policy and focused active state were read.
The command `python3 -B scripts/validate_workflow.py` passed with output:

```text
workflow structural validation passed; it cannot certify mathematical validity.
```

Only this report was written. No shared state, Git data, cache or other source
was changed by this worker. Independent mathematical review remains required.
This exact class has now been screened; unrestricted LRC remains unresolved.
