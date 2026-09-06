# A finite coloring barrier for the Fourier upper class

Date: 2026-09-06. Task `/root/uniform_fourier_upper_barrier`, using the
existing `/root/uniform_seed_coupling` session with requested Astra/xhigh
routing. Source checkpoint: `badc4e30291ce6379f69fb4d8ac9f971908ca33b`.
Only this report is worker-owned. Status: manuscript audit of root's proposed
argument, awaiting independent review. No literature-novelty claim is made.

**Result.** Let V contain n distinct positive integer speeds, and put
`N=n+1`. Every polynomial in the precisely specified upper class below obeys

```text
f(0) <= N c_0,      hence c_0/f(0) >= 1/N.
```

The proposed finite coloring proof is valid, including when its finite
coefficient correction is negative. Thus this class cannot produce a strict
upper bound on the actual gap below `1/N`. This is a restriction on upper
certificates; it supplies no lower bound on the actual gap and no LRC proof.

## Class and source scope

Write `e(x)=exp(2 pi i x)`. Fix a nonnegative integer degree bound D and

```text
f(x) = sum_(k=-D)^D c_k e(kx),
c_(-k)=c_k in R,          f(x)>=0 for every real x,
f(0)>0,
c_k<=0 for k outside {0} union V union (-V).            (U)
```

Extend `c_k=0` outside the displayed finite range. No coefficient sign is
assumed at the exceptional speed frequencies. These are symmetric frequency
exceptions: equivalently, impose the sign condition at positive frequencies
outside V and use evenness for negative frequencies. Periodicity and evenness
make global nonnegativity equivalent to nonnegativity on `[0,1/2]`.

Gonçalves–Ramos use the positive-sign class for an **upper** bound on
`gap(V)`, through the ratio `c_0/f(0)`, and give consecutive-speed Fejer
kernels as sharp examples. The conventions and direction were checked in
Section 1.1 and the proofs of Theorems 1 and 2 of the
[official article](https://link.springer.com/article/10.1007/s00574-021-00272-7),
read 2026-09-06. This report makes the positive denominator and the symmetric
frequency interpretation explicit. A stricter reading of the printed
frequency restriction still satisfies the barrier whenever it satisfies (U);
the sharpness statement below concerns exactly the class just defined.

## Finite proof

Fix one admissible f. For any integer `L>D`, make a graph on
`{0,...,L-1}` by joining j,k exactly when `|j-k| in V`. In increasing vertex
order, vertex j has at most n earlier neighbours: they have the form `j-v`
for `v in V`, when nonnegative. Greedily assign one of N colors avoiding
these earlier-neighbour colors. At most n colors are forbidden, so this
constructs a proper coloring. Write its color classes as `A_1,...,A_N`,
allowing empty classes.

For each color define finite exponential polynomials

```text
P_r(x) = sum_(j in A_r) e(jx),
P(x) = sum_(r=1)^N P_r(x) = sum_(j=0)^(L-1) e(jx).
```

Pointwise Cauchy--Schwarz gives

```text
|P(x)|^2 <= N sum_(r=1)^N |P_r(x)|^2.
```

Multiply by the nonnegative f and integrate over `[0,1]`. This is the precise
step requiring `f>=0`; it must not be applied to the lower certificate class.
Finite Fourier orthogonality gives, for each r,

```text
I_r := integral_0^1 f(x)|P_r(x)|^2 dx
     = sum_(j,k in A_r) c_(k-j)
     <= |A_r| c_0.                                   (1)
```

Indeed, the diagonal contributes exactly `|A_r|c_0`. For `j!=k` in the same
color class, proper coloring gives `|j-k| notin V`, so every off-diagonal
coefficient `c_(k-j)` is nonpositive by (U). This argument includes negative
frequencies and coefficients outside the degree range. Empty classes
contribute zero. Consequently

```text
I := integral_0^1 f(x)|P(x)|^2 dx
   <= N sum_r I_r <= N L c_0.                         (2)
```

The same finite orthogonality calculation, now counting pairs with a given
index difference, gives

```text
I = sum_(|k|<L) (L-|k|) c_k
  = L sum_(k=-D)^D c_k - 2 sum_(k=1)^D k c_k
  = L f(0) - B,
B := 2 sum_(k=1)^D k c_k.                             (3)
```

Here `L>D` ensures that all Fourier coefficients of f appear with their
correct weights. Combining (2) and (3) proves

```text
L [f(0)-N c_0] <= B           for every integer L>D.   (4)
```

The constant B depends only on the fixed polynomial; it is not assumed
nonnegative. If `A:=f(0)-N c_0` were positive, the Archimedean property would
give an integer `L>max(D,B/A)`. Then `LA>B`, contradicting (4). Hence
`f(0)<=N c_0`. Since `f(0)>0`, division yields `c_0/f(0)>=1/N` and also
implies `c_0>0`.

All sums and integrals used for a chosen L are finite polynomial expressions.
Colorings may depend on L; one infinite coloring is not required. The last
step uses unbounded integers and the Archimedean property, without exchanging
an infinite Fourier sum and an integral or assuming convergence of a solver.
This completes the proof.

## Feasibility and sharpness scope

The class is nonempty for every V and every `D>=0`: the constant polynomial
`f=1` is admissible. Thus, for its infimum `U^pos(V)`, at any fixed degree
limit or over all finite degrees,

```text
1/(n+1) <= U^pos(V) <= 1.
```

The universal lower barrier is attained for `V={1,...,n}` when degree n is
permitted. Put `N=n+1` and define the finite Fejer polynomial

```text
K_N(x) = (1/N) |sum_(j=0)^(N-1) e(jx)|^2
       = sum_(|k|<N) (1-|k|/N) e(kx).
```

It is even, real and nonnegative, has `c_0=1` and `K_N(0)=N`, and all its
nonzero nonconstant coefficients lie at the allowed frequencies
`+/-1,...,+/-n`. Every coefficient outside that set is zero, as (U) requires.
Its ratio is therefore `1/N`, proving sharpness for that family. No claim is
made that `U^pos(V)=1/N` for arbitrary V or for a smaller fixed degree limit.

## Meaning for the uniform task

The source's upper-certificate implication has direction

```text
gap(V) <= c_0/f(0).
```

The proved barrier puts this right side at least `1/N` for every admissible
f. It therefore excludes the proposed use of this exact class to disprove
LRC by producing an upper certificate strictly below the target. It does
not exclude the logical possibility that the actual gap is below the target:
`gap(V)<=R` and `R>=1/N` give no lower bound on `gap(V)`. Upper certificates
can still give upper estimates or establish tightness when an independent
matching witness is supplied.

The coloring here is an ordinary proper coloring of a finite integer
distance graph. It is not asserted to arise from a map `j -> jt mod 1`,
an equal-arc partition along that map, or any chosen real time. Converting
this unrestricted graph coloring into such an orbit claim would require a
new theorem; the proof contains no such conversion.

The complementary lower-class screen is bound to

```text
9b2d6ac78271d61d62bc201358243b5236c2afd51b4cd6e33d685699112b4bb5
research/astra-uniform-fourier-lp-cap.md
```

It derives the exact reciprocal-grid optima for the normalized lower class.
Together, these manuscript arguments exclude two specific uses of the fixed
published sign classes: obtaining new target-level lower supply beyond the
reciprocal-grid criterion, and obtaining a strict subtarget upper disproof.
They do not exclude all linear programming, semidefinite, Riesz-product or
other Fourier methods. They assert no literature novelty, no universal
equality between the LP optimum and the actual gap, and no completion of LRC.

The proof could be formalized using finite graph coloring, finite Fourier
orthogonality and ordered arithmetic if an audit later requires it. This
screen supplies no reason to start a solver or restore a Lean cache merely
to pursue those two excluded uses. A useful next mathematical mechanism
would need additional or different justified structure.

## Verification receipt

Current project configuration, workflow, policy, focused state and the bound
lower-class report were read. The primary article's class conventions and
upper-bound direction were checked through its official HTML. No mathematical
program, solver, enumeration, Lean invocation or cache restoration was used.
The proof is the displayed original finite derivation, independently checked
against root's proposed steps; it still requires independent final review.

The command `python3 -B scripts/validate_workflow.py` passed with output

```text
workflow structural validation passed; it cannot certify mathematical validity.
```

The owned manuscript's whitespace and source hash were checked separately.
No other source, shared state, Git data or cache was edited by this worker.
This bounded certificate audit is complete; unrestricted LRC remains open.
