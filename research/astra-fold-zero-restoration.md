# First-fold zeros: a sharp quarter-cell obstruction

Recovered task `/root/fold_zero_restoration_resume`, requested Astra/xhigh;
assignment source `27309c7e0a0d93c8f9ce90245cec013a3ffcd5d8`. Only this
manuscript is owned. The current configuration, workflow, policy and focused
state were read: `research / in_progress`, with recorded start authorization.
Workflow validation passed. Observed model, effort and usage are null.

**Author result, pending independent review.** The quarter-time attempt has
an exact two-coordinate ceiling. If `z` is the largest deleted speed and
`b` is any original speed divisible by four, then

    mu(v) <= b/[2(z+b)],             z < (d-1)b.            (1)

The second assertion uses an elementary bound proved below. If a zero is
active and an opposite active coordinate has folded absolute speed two,
the first bound is equality. Under hypothetical strict failure, that entire
central quarter cell then fails the target already on these two coordinates.
This identifies an obstruction to that proposed local restoration step;
it neither constructs a failure nor excludes this contact configuration.
A uniform exact good family also refutes selecting the smaller fold's
own canonical witness inside the zero-protection interval. No reverse-fold
invariant or original witness has been obtained.

## Exact hypotheses and the mixed-margin requirement

Retain an ordinary distinct positive integer failure, least by moving count
`d=N-1>=6`, then natural sum. It is primitive and mixed parity. Set

    alpha=1/(d+1),    mu=max_t min_i ||v_i*t|| < alpha,
    beta_d=(d-1)/(d+1),             beta_d<r=1-2mu<1.

Here `||.||` is distance to the integers. Choose a globally closest odd lift

    n=s_0*v+e,    0<s_0<1,    ||e||_infty=r,
    1<=n_i<=v_i,                 t_*=s_0/2.

The accepted predecessor proves saturation of `Zv+Zn`, and that
`w=v-2n` is primitive with strictly smaller absolute sum. This branch
assumes `Z={i:w_i=0}` is nonempty. Its members obey `v_i=2n_i=2 mod 4`.
Let `z=max_(i in Z) v_i`. Signs, removal of zeros and deduplication give
an actual smaller positive tuple `V`, with `q=|V|`, supplied at margin
`1/(q+1)` by minimality. Its raw folded problem has radius one on `Z`;
the zero-free rank-three transport theorem therefore does not apply.

For every real `u` and every coordinate, oddness of `n_i` gives exactly

    ||v_i(1/4+u)|| = 1/2-||w_i/4+v_i*u||.                 (2)

Thus the required retained-coordinate condition is the **upper** bound
`||w_i/4+v_i*u||<=1/2-alpha`, at one common `u`. Ordinary smaller-fold
supply is a lower circle-distance bound with a different time dependence.
It does not imply (2)'s requirement. No arbitrary shifted LRC assertion
is used here.

The central cell and its closed zero-protection interval are

    J_z={1/4+u: |u|<=1/(2z)},
    I_Z(alpha)={1/4+u: |u|<=(1/2-alpha)/z}.                (3)

On `J_z` every deleted coordinate has norm `1/2-v_i|u|`, so their
minimum is exactly `1/2-z|u|`. In particular (3) gives exactly their
simultaneous good portion inside this central cell, including endpoints.
Other good components of the deleted speeds are not excluded by this
description. The old maximizing time lies in the interior of `J_z`, since

    e_i=v_i(1/2-s_0) for i in Z,
    |t_*-1/4|<=r/(2z)<1/(2z).                              (4)

At quarter time, odd original speeds have norm `1/4` and all speeds of
valuation one have norm `1/2`. Consequently full failure forces at least
one original speed divisible by four. Such a speed is retained by the
fold and has folded value `2 mod 4`. In particular the first retained
fold cannot already be all odd. This argument uses `alpha<=1/4`.

## The exact local ceiling and a uniform ratio restriction

For any positive `z=2 mod 4` and any positive `b=0 mod 4`,

    max_(t in J_z) min(||zt||,||bt||)=b/[2(z+b)].           (5)

Indeed put `x=|t-1/4|`. On the cell, `||zt||=1/2-zx`, while
`||bt||=||b(t-1/4)||<=bx`. The minimum of these two affine bounds
has maximum `b/[2(z+b)]`, attained at `x=1/[2(z+b)]`. At that
point `bx<1/2`, so the second bound is equality too. This proves both
directions of (5), with the cell closed and with no speed-ratio premise.

Apply this to a deleted maximum `z` and any original multiple of four
`b`. By (4), the actual original optimum lies in `J_z`, and hence gives
the first inequality of (1). Equivalently, direct substitution gives
`mu<=b*r/(2z)` and then the same rearrangement using `r=1-2mu`.
This is an upper bound for the optimum, not a witness.

For completeness, the source-free lower bound `mu>1/(2d)` for `d>=2`
follows from interval length. Set `a=1/(2d)` and `M=max_i v_i`.
Each closed set `{t mod 1: ||v_i t||<=a}` has total length `2a`:
integer multiplication gives `v_i` equally spaced intervals of length
`2a/v_i` on the unit circle. All these sets share the interval of
radius `a/M` around zero. Their union therefore has length at most
`2da-(d-1)*2a/M=1-(d-1)/(dM)<1`. A point outside this union has
every distance strictly above `a`, proving the claimed strict bound.
Combining it with (5) gives `z<(d-1)b`, for every such `b`. This proof
requires no unrestricted LRC premise or external theorem.

More generally, a simultaneous `alpha`-witness inside `J_z` requires

    z <= ((1-2alpha)/(2alpha))*b.

For the canonical target this is `z<=(d-1)b/2`. If this fails for
even one multiple of four, the zero-protection interval cannot contain
an original witness: already that pair has an insufficient maximum
throughout the larger cell `J_z`. Conversely, the pairwise inequalities
alone do not make all retained coordinates good at a common time.

## Active-zero contact: the first nonexcluded folded value

The following additional conclusion requires an active deleted coordinate;
it is not inferred from the mere existence of zeros. Since the deleted
residuals in (4) share one sign, only their largest speed can be active.
Also `s_0!=1/2`: otherwise the original maximizing time is quarter time,
where a required multiple of four would have norm zero, although `mu>0`.

Put `sigma=sign(1/2-s_0)` and `h=|t_*-1/4|`. If the maximum deleted
speed is active, then `e_z=sigma*r` and `r=2zh`. Minimization over the
real lift parameter for this fixed closest odd vector requires an opposite
active coordinate `j`, with `e_j=-sigma*r`. Otherwise a sufficiently
small change of that parameter strictly reduces every residual of maximal
absolute value. This contradicts global closestness. The coordinate `j`
is retained, because all deleted residuals have sign `sigma`.

Writing `b=v_j`, direct algebra now gives the positive integer

    K=sigma*w_j=4h(z+b)>0,
    h=K/[4(z+b)],       r=z*K/[2(z+b)],
    mu=[2(z+b)-z*K]/[4(z+b)],
    2*beta_d*(1+b/z)<K<2*(1+b/z).                          (6)

Both signs of `s_0-1/2` are included; reflection about quarter time
has not been assumed to preserve the original optimization. Since
`r>beta_d>1/2`, the value `K=1` is impossible. The first value not
excluded by (6) is therefore `K=2`.

If `K=2`, then `w_j=+/-2` and oddness of `n_j` forces `b=0 mod 4`.
Formula (6) reduces to

    mu=b/[2(z+b)],           (d-1)b/2 < z < (d-1)b.         (7)

The strict lower bound is exactly `mu<1/(d+1)`; the upper bound comes
from (1). By (5), the pair's maximum throughout `J_z` is now precisely
the actual old optimum. Thus it is strictly below the canonical margin
under the full failure hypothesis. Seeking a better common time within
the protected quarter component cannot succeed in this contact case.

This is a conditional obstruction with the original hypotheses retained,
not evidence that an actual failure or this strict-failure configuration
exists. To close the zero branch by this route one must first exclude
the active-zero `K=2` configuration by further global information, or
construct a witness using other good components of the deleted speeds.
The case with no active zero and the higher values of `K` also remain.

## Exact uniform control of the proposed localized fold supply

For every integer `k>=2`, use the distinct positive primitive tuple

    v={1,3,4k} union {4j+2: 0<=j<=k},
    d=k+4,    gamma=k/(4k+1),    t_*=gamma,
    n_1=n_3=1,  n_(4k)=2k-1,  n_(4j+2)=2j+1.             (8)

It has `mu(v)=gamma`. Here is an exact global check, with no search.
By ordinary periodicity and reflection restrict to `0<=t<=1/2`. On
`[1/3,1/2]`, the speeds two and three have minimum at most `1/5`,
which is below `gamma`. If the speeds one, two and three are all
`gamma`-good on `[0,1/3]`, then

    gamma <= t <= (1-gamma)/3,
    -gamma <= 4k(t-1/4) <= gamma/3.

The first line uses `t>=gamma>1/6`, so the norm of `3t` there is
`1-3t`. On the second interval the absolute value is below one half.
The speed `4k` can be `gamma`-good only at its left endpoint, namely
`t=gamma`. At this time speeds one and `4k` have norm `gamma`, speed
three has norm `(k+1)/(4k+1)`, and the deleted candidates have norms

    ||(4j+2)t_*||=1/2-(2j+1)/[2(4k+1)] >= gamma.

This proves global optimality and uniqueness on `[0,1/2]`. The doubled
time is `s_0=2gamma`; the displayed lift is odd and its residual norm
is exactly `r=(2k+1)/(4k+1)=1-2gamma<1`, hence globally closest.
Its coordinates satisfy `1<=n_i<=v_i`. The minors from the speed-one
column paired with speeds three and `4k` are `-2` and `-2k-1`, of gcd
one, so its plane is saturated as well.

All `k+1` valuation-one coordinates fold to zero; the three retained
signed values are `(-1,1,2)`, so `V=(1,2)` and `q=2`. The largest
zero `z=4k+2` is active with positive residual, while `b=4k` is active
with negative residual and folded value two. This gives equality in
the local ceiling (5). These tuples are good: `gamma>1/(k+5)`.
They do not have the strict-failure or minimal-failure hypotheses.

The complete set of ordinary `1/3`-witnesses for `V=(1,2)`, modulo
one, is `{1/3,2/3}`. This follows by intersecting
`t in [1/3,2/3]` with `2t mod 1 in [1/3,2/3]`. The deleted original
speed six is zero at both these times. Also

    radius(I_Z(1/(k+5)))
      =(1/2-1/(k+5))/(4k+2) < 1/12.

Neither folded canonical witness belongs to that interval around quarter
time. Thus the assertion that genuine smaller-fold supply can always be
selected in the protected interval is false even with a normalized global
closest lift, primitive saturated plane, many actual zeros and arbitrary
dimension along this family. The correction from the old optimum remains
essential; this control cannot refute a statement using strict failure.

## Disposition and receipts

The bounded quarter-restoration attempt yields (1), (5), (6) and the
conditional obstruction (7), with the exact good-family control (8).
The full failure-to-restoration implication is unresolved. Its first
explicit uncovered contact case is the active-zero value `K=2` in (7):
local restoration is impossible there unless global arguments eliminate
the configuration. No common-time selection in other zero components,
mixed-margin invariant for subsequent reverse folds, smaller failing tuple
or unrestricted witness has been derived. Decreasing height and eventual
arrival at an all-odd smaller tuple do not supply that missing reverse step.
The separately refuted harmonic fold inequality is not used or reproposed.

All conclusions here have author-manuscript status only. No Lean statement
or canonical proof/disproof is claimed; no disconnected implementation,
count ladder or further experiment is proposed by this bounded task.
Root supplied the active-zero contact observation and independently the
local upper bound, and suggested the strict union-length refinement;
the algebra and uniform control above were checked here.
The complete frozen fold and rank-three manuscripts and reviews were read.

| Input | SHA-256 |
| --- | --- |
| `.codex/config.toml` | `28212a53cf42cdc377df1f7dab040732d657e59d7bb97ee78791256d01d4bb2c` |
| `docs/project-workflow.md` | `2b42a133352b6b53ba2106fc73882733f176e04a0deffbb183b4c16eefd9cd67` |
| `research/workflow-policy.json` | `833c397b61d1ffdb994fb115019f6d60d6c1a62ff85f19cdd2c9f8ac3a979c8b` |
| `scripts/validate_workflow.py` | `250a3ce2a080f5835ac4fd2e4b2803568424c777cda5d421f9fe92efd34d5383` |
| `research/astra-parity-plane-joint-descent.md` | `2b9a2350701206bd4bf5af0589cb607b545afe5a96258239a5ad77a031f58472` |
| `research/astra-parity-plane-joint-review.md` | `eafc2a8545ffe8ab2eae1014be5c40ddb8b955723658e3bf0aeb00fc9a497e88` |
| `research/astra-parity-rank-three-transport.md` | `7dd4d626a3efb1d2b8061261a9b286240f5207ac8655827079a0f887ef3a5048` |
| `research/astra-parity-rank-three-review.md` | `9051141c4e70f62b8192e01dc00d82c97849ba6c2fda0aca936cfcedcaa95140` |

Actual startup command in `/home/joshua/lonely-runner-formalization`:

    python3 scripts/validate_workflow.py

Exit status 0; full output:

    workflow structural validation passed; it cannot certify mathematical validity.

The displayed derivations are the mathematical reproduction. Source readback
used `sha256sum`; final administrative checks bind all eight inputs and
verify this file's final newline and absence of trailing whitespace. Its
frozen SHA-256 is reported separately. No mathematical program, numerical
sweep, solver, browser model, new external mathematical source, extra agent,
Lean/dependency/cache operation, Git mutation or shared-state edit was used.
Only this manuscript was written. No owned process remains. Unexposed
runtime observations, elapsed time and token usage remain null.
