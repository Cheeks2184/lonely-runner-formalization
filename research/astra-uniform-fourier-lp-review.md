# Independent review of the fixed-sign Fourier LP screen

Date: 2026-09-06. Task `/root/uniform_fourier_lp_review`, executed by
`/root/uniform_screen_review`; requested Astra/xhigh. Runtime model, effort
and usage are not independently exposed. Root supplied checkpoint
`badc4e30291ce6379f69fb4d8ac9f971908ca33b`. Only this review file is owned.
The reviewer did not author any of the three mathematical inputs.

**Accepted at manuscript scope.** The positive-normalized lower class has
the claimed exact reciprocal-grid optimum. The finite-degree and external-q
qualifications are necessary and are correctly retained. The upper class
obeys the separate universal ratio barrier `1/N`. The source audit's
normalization and dilation controls are valid. None of these statements
resolves unrestricted LRC or rules out other Fourier, LP or SDP approaches.

All three complete inputs were read. The actual source readback was:

```text
9b2d6ac78271d61d62bc201358243b5236c2afd51b4cd6e33d685699112b4bb5  research/astra-uniform-fourier-lp-cap.md
cf3ea5b08fbaee07e56b34d295632f7c67a35cc80679055a74725b0596b96043  research/astra-fourier-lp-source-contract.md
d3ba7474730fb2c17ba5118ee9753367336673eb175bf00080493e7e74a37bb1  research/astra-uniform-fourier-upper-barrier.md
```

The second hash matches `pending_fourier_lp.root_contract_sha256` in the
focused root-owned state. The source checkpoint above is parent-supplied;
this reviewer performed no Git operation.

**Primary-source check.** I independently read the publisher HTML and
extracted PDF, particularly Section 1.1 (page 596), the Theorem 1 proof
(page 598), and Section 3/Theorem 3 (pages 599–600). The displayed classes
require nonzero even real finite trigonometric polynomials, specify function
and coefficient signs, and divide by `f(0)` without explicitly requiring
its positivity. Section 3 assumes an interior reduced rational maximizing
time and uses the closed interval `[1/q,1/2]`. Theorem 3 displays the dilated
candidate audited here. The analytic Fejer expression is the standard kernel;
the printed Fourier summation endpoint is not used in this review. These
checks address the contracts used by the inputs, not the whole paper.
[Publisher HTML](https://link.springer.com/article/10.1007/s00574-021-00272-7),
[publisher PDF](https://link.springer.com/content/pdf/10.1007/s00574-021-00272-7.pdf).

This source check used HTML and extracted PDF text. No visual PDF inspection,
local PDF hash, article-wide audit or external numerical validation is claimed.
The following arguments are independent mathematical checks of the supplied
manuscripts rather than a further summary of the paper. The upper report's
declared lower-report binding also matches the first hash above.

**Normalization and symmetric frequencies.** The constant `f=-1` meets
all stated lower sign inequalities and every off-speed coefficient condition,
including a literal all-integer frequency reading. Its ratio is 1, which
cannot lower-bound a gap bounded above by `1/2`. The example
`f=-1+cos(2*pi*x)` has nonnegative nonconstant Fourier coefficients and is
nonpositive everywhere, but `f(0)=0`; its quotient is undefined. Thus merely
excluding the zero polynomial does not repair the contract. Requiring
`f(0)>0`, or normalizing to 1 by positive rescaling, does.

In the reviewed class the exceptional frequencies are explicitly
`{0} union V union (-V)`. Evenness makes this equivalent to a condition on
positive cosine indices. Reading only the positive exception list literally
for all integer indices imposes additional nonnegativity at speed
frequencies too. The ceiling still applies to that smaller lower class,
and the attaining polynomial satisfies even those additional restrictions.
No assumption that the constant coefficient is positive is needed for the
ceiling; positivity of the denominator is what licenses division.

**Exact grid averaging.** For every integer frequency k, the finite average
of `exp(2*pi*i*k*j/q)` over `0<=j<q` is the indicator of `q|k`.
Negative k, k=0 and frequencies beyond the polynomial's degree introduce
no exception. With zero extension of the finite coefficient sequence,

```text
c_0 <= c_0+2 sum_(m>=1) c_(mq)
    = (1/q) sum_(j=0)^(q-1) f(j/q)
    <= f(0)/q.
```

The first comparison uses exactly that q divides no speed, so every
nonzero aliased frequency has a nonnegative coefficient. The last comparison
uses the grid sign conditions, not an approximate sample inequality. The
closed interval sign condition implies every such grid condition by evenness
and periodicity: the folded distance of a nonzero residue is in
`[1/q,1/2]`. No primality or coprimality assumption is hidden here. The finite
identity proves the ceiling for every degree, including degrees for which
the feasible class could be empty.

**Sharpness, coefficient signs and the endpoint.** For `q>=3`,
`theta=2*pi/q` has positive sine. The stated coefficients satisfy
`c_0=c_1=1`. For `1<=j<=q/2`, both summands in their formula are nonnegative.
For `j>q/2`, put `r=q-j`. The finite exponential expression for
`sin(r*theta)/sin(theta)` has r unit-modulus terms, so its real value is at
most r. Therefore

```text
c_j = (r-sin(r*theta)/sin(theta))/q >= 0.
```

This proves all nonconstant coefficient signs independently of V. Extending
the formula to `j=q-1,q` gives zero in both cases. Its linear part has zero
second difference and its sine part satisfies the cosine recurrence. Hence
the coefficient identity at `1<=j<=q-1` follows exactly. At zero the
coefficient is `c_1-cos(theta)c_0=1-cos(theta)`; negative indices follow by
symmetry, and all further coefficients vanish. This verifies the full finite
identity

```text
(cos(2*pi*x)-cos(theta)) f_q(x)
    = (1-cos(theta)) K_q(x),
K_q(x)=(1/q) |sum_(j=0)^(q-1) exp(2*pi*i*j*x)|^2.
```

In particular, the kernel used here has Fourier support `|j|<q` and is
nonnegative by its displayed square. At zero the identity gives `f_q(0)=q`.
For `1/q<x<=1/2`, the multiplier on the left is strictly negative, proving
`f_q(x)<=0`. Continuity supplies the excluded dividing point `x=1/q`;
one must not divide the identity there. All closed endpoints are covered.
The constant coefficient is one, so the ratio is exactly `1/q`.

For q=2 the separate polynomial `1+cos(2*pi*x)` has mean one, value two
at zero and zero at the only required interval point `1/2`. This avoids
the singular `sin(theta)` formula. It is a valid external-q result; no
reduced denominator-2 time lies in `(0,1/2)` for the additional maximizing-
time hypothesis. The equality thresholds are precisely sufficient ones:
`D>=q-2` for `q>=3`, and `D>=1` for q=2. The argument does not assert
sharpness below them, nor turn an empty feasible class into an attained
optimum. Allowing all finite degrees does include these explicit attainers.

**Global and denominator-specific conclusions.** For
`0<v_1<...<v_n`, `n=N-1>=3`, the sum S of the largest two speeds exceeds
every speed, hence divides none. Its sign interval is exactly the q=S
case, giving unrestricted-finite-degree optimum `1/S` and the same ceiling
at every fixed degree. Distinct positive integers give
`S>=2n-1=2N-3>N`; therefore the ceiling is strictly below `1/N` throughout
the claimed N range. This conclusion concerns the exact admissible class,
so additional degree or denser numerical sampling cannot change it.

At time `1/(2 max(V))`, every positive speed phase lies in `(0,1/2]`.
Thus the true gap is positive. A denominator q of an actual maximizing
time cannot divide any speed, since that coordinate would then have norm
zero. However, the optimization identity requires only this latter
nondivisibility condition, not knowledge of a maximizing numerator.

For any eligible external q, integer residues at time `1/q` give each norm
at least `1/q`. Thus q<=N already supplies a closed target witness directly;
q>N leaves this entire lower class below the target. The ratio is not an
upper bound on the true gap, and neither equality of the true gap to `1/q`
nor a new supply of maximizing denominators follows. The q=2 boundary case
does not change this dichotomy.

**The dilated control checks the candidate, not existence.** For
`q=3,a=2,V=(2,4)`, the gcd and containment conditions hold, and `t=1/3`
attains gap `1/3`. Indeed, if `u=||2t||<=1/3` the first speed bounds the
minimum; if `u>1/3`, then `u<=1/2` and `||4t||=1-2u<1/3`.

Writing `C=cos(4*pi*x)`, the audited quotient has numerator
`(1+2C)^2/4` and denominator `(1+2C)/4`. Its continuous polynomial
extension is therefore `1+2*cos(4*pi*x)`. At `x=1/2` it equals 3 and
the original denominator is nonzero; continuity also gives failure inside
the required interval. This is a failure of the fixed sign condition,
not a removable-singularity artifact. The undilated polynomial
`1+2*cos(2*pi*x)` has the required sign on `[1/3,1/2]`, ratio `1/3`, and
positive off-speed coefficients at frequencies +/-1. The ceiling proves
its optimality for this tuple. Existence of an optimal certificate therefore
survives the failure of the displayed dilated candidate. No corresponding
failure of dilation invariance for the actual gap or the upper class is
inferred.

**Upper-class addendum: the finite coloring barrier.** In this separate
class the function is nonnegative everywhere and the off-speed coefficients
are nonpositive, with the same symmetric exceptions and `f(0)>0`.
Evenness and periodicity justify replacing global nonnegativity by the closed
half-period condition. The lower-class sign pattern must not be substituted
in the following argument.

For any integer `L>D`, a vertex j in the distance graph on `0,...,L-1`
has at most n earlier neighbors, namely `j-v` for eligible positive speeds v.
Thus `N=n+1` colors suffice by finite greedy assignment. Every same-color
pair of distinct vertices has its difference outside both signs of V.
Empty color classes are allowed, and the argument needs no coloring that
is compatible across different L.

For the color polynomials P_r, pointwise Cauchy--Schwarz gives
`|sum_r P_r|^2<=N sum_r |P_r|^2`. Multiplication preserves this inequality
because f is nonnegative. Finite orthogonality then gives

```text
integral f |P_r|^2 = sum_(j,k in A_r) c_(k-j)
                   <= |A_r| c_0.
```

The diagonal is exact, every off-diagonal coefficient is nonpositive,
and coefficients beyond D are correctly zero. Summing uses
`sum_r |A_r|=L`. Counting pairs of vertices with a specified difference in
the full interval gives the second, exact calculation

```text
integral f |sum_(j=0)^(L-1) exp(2*pi*i*j*x)|^2
    = sum_(|k|<L) (L-|k|) c_k
    = L f(0)-B,
B = 2 sum_(k=1)^D k c_k.
```

The factor 2 and the correction sign are correct. Because `L>D`, every
possibly nonzero coefficient has its required pair-count weight. Combining
the two comparisons yields `L(f(0)-N c_0)<=B` for every such integer L.
Here B belongs to the fixed f, independently of L or its coloring. If
`A=f(0)-N c_0>0`, an integer `L>max(D,B/A)` contradicts this inequality.
This remains valid when B is negative. No infinite Fourier sum, exchange
of limit and integral, or density assertion about one color class is used.
It follows that `f(0)<=N c_0`, and positive normalization gives the ratio
bound and `c_0>0`.

The admissible constant 1 proves feasibility even at degree zero. Therefore
the infimum at any fixed degree, or over all finite degrees, lies in
`[1/N,1]`. For `V={1,...,n}`, the displayed finite Fejer kernel K_N has
mean one, value N at zero, and support exactly among the allowed speed
frequencies. It proves equality when degree n is permitted. No conclusion
of equality for arbitrary V or a smaller fixed degree follows. This
sharpness statement concerns the expressly defined symmetric-frequency
class; it is not transferred to a stricter literal all-integer reading
that also forbids positive coefficients at negative speed frequencies.

The certificate implication is an upper bound on the gap. Proving that
every such right-hand side is at least `1/N` excludes a strict subtarget
upper certificate from this class, but supplies no lower bound on the
actual gap. The greedy coloring is unrestricted: it need not come from
sampling one rotation orbit or partitioning that orbit into equal arcs.
No conversion of graph colors into a witness time is justified here.
Independent matching witnesses can still make valid upper estimates useful
for proving tightness. These limits apply to this class and leave other
Fourier or optimization mechanisms open.

**Verification and remaining scope.** Configuration, current workflow,
policy and focused state were read. The exact binding command was:

```sh
sha256sum research/astra-uniform-fourier-lp-cap.md research/astra-fourier-lp-source-contract.md research/astra-uniform-fourier-upper-barrier.md
```

It exited 0 with the complete output reproduced above. The required command
`python3 -B scripts/validate_workflow.py` exited 0 with complete output:

```text
workflow structural validation passed; it cannot certify mathematical validity.
```

The whitespace command
`rg -n '[ \t]+$' research/astra-uniform-fourier-lp-review.md`
returned no output and exit 1, meaning no trailing whitespace was found.

All mathematical verification was by the displayed finite identities and
inequalities. No mathematical program, search, solver, enumeration, Lean
invocation or cache operation was used. No other source, Git data or shared
state was modified. The independent arithmetic witness-supply problem remains
open. The accepted results screen the specified lower class for stronger
target-level supply and the specified upper class for strict subtarget
disproof certificates; they do not screen all possible optimization methods.
