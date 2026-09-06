# Independent review of the orbit-only Fourier relaxation

Date: 2026-09-06. Task `/root/uniform_fourier_orbit_review`, executed by
`/root/uniform_screen_review`; requested Astra/xhigh. Runtime model, effort
and usage are not independently exposed. Parent-supplied current checkpoint:
`8b9ea58d8a477a0fad733c3cf6674c307c1f9782`. Only this review file is owned.
The reviewer did not author the mathematical input.

**Accepted at manuscript scope, without correction.** The finite pairing
proves `c_0/f(0)<=a/q` using only the supplied witness inequalities. It does
not require a global maximizer. Freeing all zero-weight sample signs cannot
raise this ratio above that witness's known value. No feasibility, optimum,
attainment, general Fourier impossibility or LRC resolution follows.

The complete input was read, and both actual bindings matched:

```text
18fee9eb62fe473a829f1e1de65e2556d0a66f5b05a3cf7de0c04b894cb55576  research/astra-fourier-orbit-relaxation.md
9b2d6ac78271d61d62bc201358243b5236c2afd51b4cd6e33d685699112b4bb5  research/astra-uniform-fourier-lp-cap.md
```

The attribution is consistent with the triangular-kernel pairing in the
[primary article's Theorem 1 proof](https://link.springer.com/article/10.1007/s00574-021-00272-7),
inspected in the preceding review. The present finite proof is checked
directly below; no new literature or novelty claim is needed.

**Cyclic autocorrelation and all endpoints.** The assumptions are integers
`q>=2`, `1<=a` and `2a<=q`, with p coprime to q. For
`I={0,...,a-1}`, ordinary differences lie in `[-a+1,a-1]`. Two such
differences differ by at most `2a-2<q`, so reduction modulo q is injective
on that interval. A residue with circular distance d<a has exactly one
representative there, with `a-d` ordered pairs; a residue with distance
at least a has none. Thus the claimed count equals
`H(r)=max(a-dist_q(r),0)`, including `H(0)=a` and the zero value at d=a.

For even q and `a=q/2`, neither representative of the antipodal residue
belongs to the difference interval. Its count is zero, not doubled. For
a=1 the only difference is zero, giving the delta function on the cyclic
group. These arguments include q=2 without a special exception.

**Fourier sign and exact zero weights.** Expanding
`w_s=|sum_(j=0)^(a-1) exp(2*pi*i*j*s/q)|^2` produces terms with exponent
`s(u-v)/q`. Multiplication by the proposed positive-sign character
`exp(2*pi*i*s*r/q)` makes the cyclic average select exactly
`v-u=r mod q`. Therefore

```text
H(r)=(1/q) sum_(s=0)^(q-1) w_s exp(2*pi*i*s*r/q)
```

has the correct sign and normalization for every integer r, including
negative r. Each weight is nonnegative and `w_0=a^2`.

For `0<s<q`, the denominator `1-exp(2*pi*i*s/q)` is nonzero. The geometric
sum therefore vanishes exactly when `q|as`. Writing `d=gcd(a,q)` makes
these nonzero indices precisely `q/d,2q/d,...,(d-1)q/d`; no primality or
coprimality of a with q was used. When a=1 every weight is one and none
of the nonzero samples is omitted. When `q=2a`, the omitted indices are
exactly the nonzero even indices, with an empty list when q=2. The zero
sample always has positive weight and is treated separately. Coprimality
of p and q ensures that no other sample represents zero.

**Pairing, negative frequencies and aliasing.** The witness inequality is
equivalent to `dist_q(pv)>=a`, so both `H(pv)` and `H(-pv)` vanish. This
kills every exceptional coefficient regardless of its sign. All remaining
nonconstant terms are nonnegative, while the constant term is exactly
`a c_0`. Consequently the lower comparison holds without any sign
assumption on c_0.

Inserting the finite Fourier expansion and interchanging only finite sums
gives the exact expression

```text
a c_0 <= sum_(k=-D)^D c_k H(pk)
      = (1/q) sum_(s=0)^(q-1) w_s f(ps/q)
      <= (a^2/q) f(0).
```

Every actual frequency is retained; `D<q` is unnecessary. Exceptional
frequencies vanish individually, and congruent frequencies still occur
with their own coefficients and the corresponding periodic H factor.
Negative frequencies cause no change to the count or the coefficient
comparison. There is no replacement of the original exception set by
an unproved condition on aliased coefficients.

For the last inequality, every positive-weight nonzero sample has the
required nonpositive f value, while a zero-weight sample contributes zero
even if f is positive there. The s=0 term is exactly `a^2 f(0)/q`.
Dividing by `a>0` and `f(0)>0` yields the asserted ratio bound. Equality
in the closed witness inequalities gives zero H factors and is fully
allowed; none of the steps needs strict witness slack.

**The exact limitation.** For nonempty V, the supplied data already give
`a/q<=mu(p/q)`, hence

```text
c_0/f(0) <= a/q <= mu(p/q) <= gap(V).
```

The first inequality was proved without the last inequality being an
equality. A global-maximizer assumption is therefore absent from the
argument, rather than an assumption available to contradict. In particular,
no ratio in this class can exceed the supplied point's value, whether the
chosen a/q equals that value or is a weaker certified margin. If a/q is
below the target `1/N`, these ratios stay below the target too.

The barrier itself permits empty V, but the stated minimum and gap
comparison require the manuscript's nonempty-V qualification. No feasible
polynomial is constructed here, and the earlier lower-class attainer is
not silently transferred to these different sample restrictions. No claim
about an attained optimum or a different kernel or certificate class is
justified. The remaining task is an independent uniform witness-supply
mechanism; this conditional bound does not supply one.

**Actual checks.** Current configuration, workflow, policy and focused state
were read. The binding command was:

```sh
sha256sum research/astra-fourier-orbit-relaxation.md research/astra-uniform-fourier-lp-cap.md
```

It exited 0 with the complete output reproduced above. The required command
`python3 -B scripts/validate_workflow.py` exited 0 with complete output:

```text
workflow structural validation passed; it cannot certify mathematical validity.
```

The documentation scan
`rg -n '[ \t]+$' research/astra-fourier-orbit-relaxation-review.md`
returned no output and exit 1: no trailing whitespace was found.

Mathematical verification consists of the displayed hand calculations.
No mathematical program, solver, enumeration, Lean invocation or cache
operation was performed. No other source, shared state or Git data was
modified. The validator establishes workflow consistency only.
