# Exact limits of the fixed-sign Fourier certificates

Pass64 merged through PR63 at `badc4e30291ce6379f69fb4d8ac9f971908ca33b`.
Both required CI jobs passed and root verified the checkpoint on fetched main.
This pass screens two precise Fourier certificate classes for the uniform
arbitrary-N task. It neither changes Lean source nor resolves unrestricted LRC.

The primary source is Gonçalves–Ramos, *Bounds for the Lonely Runner Problems
Via Linear Programming* (2022), Sections 1.1–3. The project reads its lower
class with the essential explicit normalization `f(0)>0` and symmetric speed
frequency exceptions. The displayed source definition does not state this
positivity: `f=-1` gives an invalid lower ratio of 1, while
`f=-1+cos(2*pi*x)` has a zero denominator. The source's proposed dilation also
fails to preserve its fixed negative interval for `q=3,a=2,V=(2,4)`.
This is a failure of that displayed candidate, not of the existence of an
optimal certificate. The source audit retains exact controls and locations.
[Publisher article](https://link.springer.com/article/10.1007/s00574-021-00272-7).

For the normalized lower class, let q divide no speed. Averaging f over the
q-grid retains only coefficients at multiples of q, all nonnegative except
possibly the mean. If f is nonpositive at the nonzero grid points, then
`c_0 <= (1/q) sum_j f(j/q) <= f(0)/q`. The lower ratio is at most `1/q`.
An explicit finite polynomial attains this bound while being nonpositive
on the entire closed interval `[1/q,1/2]` and having every nonconstant
Fourier coefficient nonnegative. Its finite recurrence, coefficient signs
and boundary are proved directly; q=2 has a separate degree-one polynomial.
Equality requires an adequate degree limit, or allowing all finite degrees.

Consequently the source's global normalized lower class has exact optimum
`1/S`, where S is the sum of the two largest speeds. For `n=N-1>=3`,
`S>=2N-3>N`, so it cannot supply the LRC target at any finite degree.
The denominator-specific version has optimum `1/q` whenever applicable.
But time `1/q` already supplies that bound by integer residues. If q<=N it
already solves the target directly, and if q>N the certificate stays below
the target. These are limits on the certificate ratio, not upper bounds on
the true loneliness gap. A denominator of an actual rational maximizing
time, as assumed in the source's specialized theorem, is not supplied by
the optimization argument.

The complementary upper class has f nonnegative everywhere and nonpositive
coefficients outside the speed frequencies. A separate finite coloring
argument proves `f(0)<=N*c_0` for n distinct speeds. Color the integer
distance graph on `0,...,L-1` greedily with N colors. Cauchy–Schwarz and
finite Fourier orthogonality give

```text
L*(f(0)-N*c_0) <= 2*sum_(k=1)^D k*c_k       for every integer L>D.
```

The right side is fixed for f; unbounded L forces the asserted inequality,
even when that correction term is negative. Thus every such upper ratio is
at least `1/N`. Consecutive speeds attain the barrier with a Fejér kernel
when degree n is permitted; equality is not asserted for arbitrary tuples.
Since this class gives an upper bound on the actual gap, the barrier rules
out a strict subtarget disproof certificate from this class. It gives no
lower bound on the actual gap and no witness time. Ordinary graph colorings
are not silently converted into colorings arising from a single real orbit.

The author manuscripts and root source audit received an independent
Astra/xhigh review. The review checks the source contracts, finite formulas,
normalization, closed endpoints, all degree qualifications, and both
directions of inference. Root read the complete accepted inputs. These are
reviewed manuscript arguments, not new kernel-checked declarations.

No solver, mathematical program, enumeration or Lean run was needed locally.
No dependency cache was restored. The checkpoint binds the original reports,
review and source audit and retains the actual verification commands and
outputs. It does not claim that all LP, SDP, Riesz-product or Fourier methods
are exhausted. Further work needs a justified mechanism beyond these exact
sign classes that supplies a witness for actual integer-speed tuples.
The canonical six-runner theorem remains established; unrestricted LRC and
the separate protected-deletion-seed route remain unresolved.
