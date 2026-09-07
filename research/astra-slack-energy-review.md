# Independent review of the proposed global slack-energy inequality

Task `/root/slack_energy_review`, existing reviewer handle
`/root/fold_zero_restoration_resume`, requested Astra/xhigh. Assignment
source `5aecd6775dd9480e3e4eaa8e8ec7fe76ebd80665`. Only this review
is owned. The complete frozen author is
`research/astra-uniform-strategy-after-fold.md`, SHA-256
`e569596af4ebab9f9d5e1c796d8da435bc433c1c238bc10f9901e644f9f49871`.

**Verdict.** The derivative, local homothety, exact defect identity,
Fourier encoding and conditional canonical implication are correct at
their stated scope, without corrections. The proposed inequality (E)
remains an unproved stronger assertion. One exact analytical attack on
`v=(1,2,3)` gives strictly positive defect throughout `0<a<1/4`, so
does not falsify it. The independently inspected bounded integration
control likewise reports no negative value in its actual 1,000 evaluations.
Neither nonfinding supplies uniform compensation across cells or proves E.

## Contract, derivative and conditional implication

The proposed domain is every `d>=2` and every positive distinct primitive
integer tuple `v`, with `alpha=1/(d+1)`. It does not assume a hypothetical
failure, a fold, a selected maximizer or minimality. Put

    f_i(t)=||v_i t||,
    I(a)=integral_0^1 product_i (f_i(t)-a)_+ dt,
    H(a)=integral_{all f_i(t)>a}
               sum_i product_{j!=i}(f_j(t)-a) dt,
    Delta(a)=(d+1)I(a)-(alpha-a)H(a).

Every equation `f_i(t)=a` has finitely many solutions for fixed
`0<a<1/2`. Off their union, differentiating the product gives exactly
the negative integrand of `H`: if one slack is strictly negative then the
product is identically zero in a small threshold neighbourhood. If all
are positive, the ordinary product rule applies. Each factor is
1-Lipschitz in `a` and at most `1/2`; telescoping products bounds the
difference quotients by `d(1/2)^(d-1)` on a sufficiently small threshold
neighbourhood. Dominated convergence proves `I'(a)=-H(a)`.
It also gives continuity of the threshold integrals. No derivative of a
discontinuous integration boundary is omitted.

The claimed monotonicity is exactly

    (alpha-a)H(a)<=(d+1)I(a),      0<a<alpha.               (E)

Indeed

    d/da [I(a)/(alpha-a)^(d+1)]
       =Delta(a)/(alpha-a)^(d+2).

The constant `I(0)` is positive: finitely many zero phases cannot fill
the unit interval, and a time outside them has a neighbourhood where
the continuous product is positive. If E held throughout its proposed
domain, monotonicity from an arbitrary positive starting threshold and
continuity as that threshold tends to zero would give

    I(a)>=I(0)((alpha-a)/alpha)^(d+1)>0   for 0<=a<alpha.

This step does not assume E at the excluded endpoint zero or divide by
an integral that might vanish. Positivity of `I(a)` is equivalent to an
actual strict common `a`-witness: a positive integrand supplies a point,
and conversely strict slacks persist on a neighbourhood. Thus
`mu(v)>=alpha` follows by taking subcritical thresholds to `alpha`.
Periodicity and compactness alternatively provide a limiting closed
witness. There is no claim of positive energy at the sharp endpoint.

Common integer scaling preserves the energy distribution and circle
optimization, removing the primitive normalization. Extending the resulting
all-count integer theorem through the existing canonical bridges would
still require its actual proof and the prescribed formal checks. The
conditional argument is valid; its hypothesis E is not a checked theorem.
No converse from LRC to this quantitative monotonicity is established.

## Local homothety and the exact unresolved defect

Between successive integer-phase cuts, each speed has a fixed period
index and `f_i(t)` is the minimum of two affine functions. It is concave
on that closed cell, even when its half-phase peak lies inside the cell.
The cell may therefore be used as stated without extra half-phase cuts
for the convexity argument. For its peak `mu_C`, choose `t_C` attaining
the maximum of the simultaneous minimum.

The set `D_C(a)` in the author is the intersection of finitely many
closed half-spaces in variables `(t,y_1,...,y_d)`, with bounded coordinates.
Its `(d+1)`-dimensional volume is `I_C(a)` by its rectangular fibres.
For `0<=a<b<mu_C`, the proposed ratio
`lambda=(mu_C-b)/(mu_C-a)` is in `(0,1)`. Concavity gives

    f_i(lambda t+(1-lambda)t_C)
      >=lambda(y_i+a)+(1-lambda)mu_C=lambda y_i+b.

The homothety therefore maps the whole first polytope into the second,
and volume scales by exactly `lambda^(d+1)`. Taking the right derivative
in `b` at `a` yields

    (mu_C-a)H_C(a)<=(d+1)I_C(a),
    Q_C(a)=(d+1)I_C(a)-(mu_C-a)H_C(a)>=0.

If `a>=mu_C`, there is no time with all cell slacks strictly positive;
both integrals vanish. Cell boundaries have measure zero, so the global
identity is exactly

    Delta(a)=sum_C [Q_C(a)+(mu_C-alpha)H_C(a)].             (1)

Every sign and normalization checks. In particular, concavity does not
replace a subcritical `mu_C` by `alpha`. Such cells make the second term
negative. The first unresolved implication is nonnegativity of the entire
sum for actual compatible integer-speed cells, uniformly over the domain
of E. Local convexity proves no such compensation.

The author's calibrations are correct. For `(1,2)` and
`1/4<=a<1/3`, the full positive region consists of
`[a,(1-a)/2]` and its reflected copy, up to endpoints. Exact integration
gives `I=(1-3a)^3/12`, making E equality there. An exponent below three
already fails on this two-speed example; this is not a separate proof of
sharpness in every dimension. For `(1,2,3)`, the integer-phase cell
`[1/3,1/2]` has peak `1/5` at `2/5`, with positive energy below that
peak and zero energy there. Its cellwise replacement by `alpha=1/4`
would therefore be false, as the author states.

## Fourier normalization and convergence

Let `L=1/2-a`. On the unit circle, convolving the indicators of two
centred intervals of length `L` gives the triangular function
`(L-||x||)_+`. Translation by `1/2` gives
`(||x||-a)_+`, including its endpoints, since
`||x-1/2||=1/2-||x||`. With unit Lebesgue measure, its Fourier coefficients
are consequently

    (-1)^k q_k,
    q_0=L^2,
    q_k=(sin(pi k L)/(pi k))^2,      k!=0.

For each fixed `a`, these coefficients are absolutely summable. Products
of their finitely many series are also absolutely summable, so termwise
integration is justified. The integral of an exponential is zero unless
`sum_i v_i k_i=0`. This gives exactly the author's signed relation sum,
including the sign `(-1)^(sum_i k_i)` and the zero-frequency coefficient.
No differentiated Fourier series, uniform resonance bound or sign pairing
has been proved. The formula retains the global problem; it does not
supply the missing estimate in (1).

## One exact analytical falsification attempt

The bounded hand test used the actual tuple `v=(1,2,3)` over its entire
subcritical threshold range. Write

    delta=1/4-a>0,    epsilon=(1/5-a)_+,
    u=(1/6-a)_+,      0<a<1/4.

Reflection reduces integration to `[0,1/2]`. Its first positive component
is `[a,(1-a)/3]`; its second is
`[(1+a)/3,(1-a)/2]` when `a<1/5`, and is absent otherwise. On the
first component, speed two changes affine branch at `1/4`, and speed
three changes branch at `1/6` when that point is inside the component.
All the following integrals are ordinary exact polynomial integrations
on these actual phase pieces.

Start on the first component with provisional factors
`(t-a)(2t-a)(1-3t-a)`. With `x=t-a` and `L_1=4delta/3`, its integral is

    3 integral_0^L_1 x(2x+a)(L_1-x) dx
      =L_1^4/2+a L_1^3/2
      =(8/27)delta^3+(32/81)delta^4.

For `t>=1/4`, the provisional speed-two slack exceeds the true one by
`4t-1`. The exact correction, with `y=t-1/4`, is

    integral_0^(delta/3) (y+delta)(4y)(delta-3y) dy
       =(7/81)delta^4.

If `a<1/6`, the provisional speed-three slack exceeds the true one by
`1-6t` on `[a,1/6]`. Its correction is

    6 integral_0^u x(2x+a)(u-x) dx=u^4+a u^3=u^3/6.

No correction is present when `a>=1/6`. On the second component put
`x=t-(1+a)/3` and `L_2=5epsilon/6`. Its three actual slacks are
`x+(1-2a)/3`, `2(L_2-x)`, and `3x`, so its integral is

    ((1-2a)/3)L_2^3+L_2^4/2
      =(25/216)epsilon^3+(1625/2592)epsilon^4.

This term vanishes when `a>=1/5`. Combining the pieces and reflecting
proves, for every threshold in the stated range,

    I(a)/2=(8/27)delta^3+(25/81)delta^4-u^3/6
           +(25/216)epsilon^3+(1625/2592)epsilon^4.        (2)

The positive-part powers are differentiable at the two switching
thresholds. Using `H=-I'`, the exact proposed defect is

    Delta(a)/2=(8/27)delta^3-(5/288)epsilon^2
               -(25/2592)epsilon^3
               +u^2(1/24-u/6).                          (3)

If `epsilon>0`, then `delta=epsilon+1/20`. The first three terms of
(3) become

    (743/2592)epsilon^3+(13/480)epsilon^2
       +epsilon/450+1/27000>0.

Also `0<=u<1/6`, making the last term nonnegative. If `epsilon=0`,
then `u=0` and (3) is simply `(8/27)delta^3>0`. Thus this attack
finds **no falsifier**: E holds strictly for `(1,2,3)` on all
`0<a<1/4`, including the two piece-switching thresholds. Negative
contributions from the secondary component are real, but are compensated
in this particular tuple. This is a scoped analytical nonfinding, not
evidence sufficient to accept E generally or a new runner-count milestone.

## Independent inspection of the bounded integration control

Root subsequently supplied the frozen Terra source and execution receipt
listed below. Both were read completely; neither was executed here.
The algorithm is mathematically correct for its stated exact rational
integration task. It partitions `[0,1]` at every `k/(2v_i)` and every
threshold crossing `(k+a)/v_i`, `(k+1-a)/v_i`. Thus on each open interval
every norm has one affine branch and every slack has constant sign.
The rational midpoint selects these properties exactly. Endpoints have
measure zero, including equality at the threshold.

All affine coefficients, interval bounds, polynomial products, integrals
and comparisons use exact `Fraction` arithmetic. The all-positive test
is applied before both integrations: the leave-one-out products for H
are not accidentally integrated on larger deletion-witness regions.
The code computes precisely `(d+1)I-(1/(d+1)-a)H`. Clock readings only
enforce the search budget; they make no mathematical sign decision.

The two focused regression values agree with direct mathematics:
at `(1,2), a=1/4`, `I=1/768`, `H=3/64`, defect zero; at the
mechanical one-speed control `(1), a=1/4`, `I=1/16`, `H=1/2`.
The latter is outside E's proposed dimension domain and is correctly
used only to check the integrator.

The source iterates primitive distinct positive tuples from speeds 1--12
in dimension-first lexicographic order, testing `a=j/[8(d+1)]` for
`j=1,...,7`. The receipt binds its complete embedded source to the
frozen Python file. The one supplied execution exited zero and stopped
at its 1,000-evaluation limit: 315 evaluations in dimension two and
685 in dimension three; none in dimensions four or five. Its reported
program duration is `1.8090054899998904` seconds. The last evaluation is
`(3,4,12), a=3/16`, with positive defect `2327/884736`.
The receipt reports both regressions passed and no negative defect.

This accepts the exact method and the receipt at their bounded scope.
It does not certify the unexecuted portion of the configured domain,
all thresholds of the sampled tuples, any greater height or count, or E.
No rerun or broadened experiment was performed. The new hand calculation
(2)--(3) is independent of the program and was derived before its source
and receipt were supplied to this reviewer.

## Disposition, frozen bindings and actual checks

No correction to the new derivations in the author is required. E has
neither a proof nor a falsifier in this review. The first unresolved
implication remains a uniform nonnegative bound for the exact sum (1),
using actual common-time integer-phase compatibility. The analytical and
computational controls do not justify replacing that obligation by more
local lemmas, a numerical positivity table or bare witness positivity.
The proposed inequality has not been weakened. The unrestricted canonical
proof/disproof gate remains unmet.

The historical strategy summary retains the previously accepted fold
results and their strict hypotheses as background; this review does not
re-prove or re-promote all earlier research. All 20 frozen author input
hashes were read back and matched. The complete author and the new
integration source/receipt were independently read. Direct review bindings:

| File | SHA-256 |
| --- | --- |
| `research/astra-uniform-strategy-after-fold.md` | `e569596af4ebab9f9d5e1c796d8da435bc433c1c238bc10f9901e644f9f49871` |
| `research/astra-slack-energy-control.py` | `7c693ad658c59afb615965b551c42ebffd068d99d85b62f1ee954b35c6f69d73` |
| `research/astra-slack-energy-control.json` | `3d3ee3c559a07a6242ec347a35a72ec5ae4a11b77aac5c438bb2814e5576aaeb` |
| `.codex/config.toml` | `28212a53cf42cdc377df1f7dab040732d657e59d7bb97ee78791256d01d4bb2c` |
| `docs/project-workflow.md` | `2b42a133352b6b53ba2106fc73882733f176e04a0deffbb183b4c16eefd9cd67` |
| `research/workflow-policy.json` | `833c397b61d1ffdb994fb115019f6d60d6c1a62ff85f19cdd2c9f8ac3a979c8b` |
| `scripts/validate_workflow.py` | `250a3ce2a080f5835ac4fd2e4b2803568424c777cda5d421f9fe92efd34d5383` |

Current config, workflow, policy and focused active state were read. The
gate is `research / in_progress` with explicit start authorization.
Actual command in `/home/joshua/lonely-runner-formalization`:

    python3 -B scripts/validate_workflow.py

Exit status zero; complete output:

    workflow structural validation passed; it cannot certify mathematical validity.

Final administrative checks verify the seven direct bindings, the receipt's
embedded-source hash, final newline and trailing whitespace, then report
the owned SHA separately. No mathematical program, sweep, solver, build,
cache/dependency operation, browser model, extra agent, Git mutation,
shared-state edit or other-file write was performed by this reviewer.
No owned process remains. Requested route is Astra/xhigh; observed model,
effort, reviewer elapsed time and token usage remain null.
