# Exact contracts before adopting the Fourier LP construction

Date: 2026-09-06. Root-authored source audit at checkpoint
`1fa1a5fed45c66227b686975d659d80f86dcaeb1`. Independent review is required.
This is a mathematical contract check, not a Lean theorem or an LRC result.

The primary source is Gonçalves and Ramos, *Bounds for the Lonely Runner
Problems Via Linear Programming*, published online in 2021, volume 53 (2022),
595–603. Root inspected the [publisher HTML](https://link.springer.com/article/10.1007/s00574-021-00272-7)
and the extracted text of the [publisher PDF](https://link.springer.com/content/pdf/10.1007/s00574-021-00272-7.pdf).
Section 1.1 specifies sign and Fourier-coefficient restrictions; Section 3
changes the sign interval using a denominator of a maximizing time and gives
a dilated kernel construction. No numerical result from the paper is used.

## Positive normalization is an essential hypothesis

The displayed admissible-class definition on page 596 requires a nonzero
polynomial but does not explicitly require `f(0)>0`. For a sound lower-bound
contract we must add that requirement, or normalize directly to `f(0)=1`.
This is mathematically substantive, not merely denominator nonvanishing.

For example, take the constant polynomial `f=-1`. It is nonzero, even and
real, is nonpositive on every required negative-class interval, and has zero
Fourier coefficients at every nonzero frequency. Nevertheless its ratio
`fhat(0)/f(0)` is 1. Every circle distance is at most 1/2, so that ratio cannot
be a lower bound for any ordinary loneliness gap. The step dividing by
`f(0)` in the lower-bound argument therefore requires its positive sign.
The polynomial `-1+cos(2*pi*x)` also satisfies those sign requirements but
has `f(0)=0`, making the unqualified quotient undefined.

Our certificate class consequently uses positive normalization explicitly.
Frequency conditions are stated on positive cosine indices, or equivalently
on integer Fourier indices outside `{0} union V union (-V)`. This makes the
evenness convention explicit instead of applying a positive-frequency list
literally to negative indices. No conclusion about the unnormalized supremum
is inferred from a theorem about this corrected class.

## A dilated candidate does not preserve the sign interval

The displayed polynomial in Theorem 3 cannot be used as an admissible
certificate for every allowed dilation. The following is an exact hand
control of that particular formula, not a refutation of the theorem's
existence conclusion.

Take `q=3`, `a=2`, and the speed tuple `(2,4)`. The scalars a and q are
coprime, and the tuple contains exactly `a*{1,2}`. Its maximum loneliness
is 1/3 and is attained at `t=1/3`, which lies in `(0,1/2)` with denominator
q. To see the upper bound directly, put `u=||2t||`. If `u<=1/3`, the first
coordinate suffices; if `u>1/3`, then `u<=1/2` and
`||4t||=1-2u<1/3`. Thus all the stated tuple hypotheses are satisfied.

For the standard Fejér kernel,

```
K_3(y) = (1/3)*(1+2*cos(2*pi*y))^2.
```

The source's displayed quotient, with its removable singularities filled,
simplifies in this case to

```
f(x) = K_3(2x) * sin(pi/3)^2
       / (cos(2*pi*x)^2-cos(pi/3)^2)
     = 1+2*cos(4*pi*x).
```

At `x=1/2`, its value is 3, contradicting the required `f(x)<=0` on
`[1/3,1/2]`. The contradiction occurs away from any singularity. Even if
one omitted the endpoint, continuity gives positive values immediately
below 1/2 within that interval. Therefore dilation of the input argument
does not automatically preserve this fixed sign interval.

For comparison, the undilated polynomial `1+2*cos(2*pi*x)` is admissible for
this tuple and q: it is nonpositive on `[1/3,1/2]`, has nonnegative Fourier
coefficients outside the speed set, and has ratio 1/3. Thus the failed
displayed candidate does not refute existence of an optimal certificate.
We do not transfer the valid dilation invariance of the actual loneliness
gap or of the upper-certificate class to this lower-certificate sign condition.

## Integration decision and evidence limit

The separate grid-averaging investigation uses a positive-normalized finite
Fourier class and proves its estimates directly; it does not depend on the
displayed dilated candidate or sampled numerical feasibility. Its exact
scope must be reviewed independently before any solver or Lean work.

Both source representations inspected above contain the relevant displayed
conditions and dilated formula (PDF pages 596 and 599–600). PDF screenshot
requests did not provide a usable visual readback; this audit relies on the
matching HTML and extracted PDF text, not a claimed visual inspection.
No source article was copied into the repository. All controls here are
the displayed elementary hand calculations. No mathematical program, search,
LP solver, Lean invocation, or dependency-cache operation was performed.
No external message was sent to the authors. Unrestricted LRC remains open
in this project.
