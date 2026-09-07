# Independent review of rational-cell compensation

Task `/root/rational_cell_review`; requested `gpt-6-astra/xhigh`.
Observed model, effort, elapsed time and usage: `null`. Assignment checkpoint:
`0110b922e90d06943d29dbd42d05753fa984f305`. Only this review is owned.

**Accept without corrections at the stated manuscript scope.** The exact
family, chamber geometry, integral and derivative formulas, strict negative
budgets, actual translation, radius quantifiers and aggregate limsup all
check. They refute compensation by positive weighted groups of uniformly
bounded chamber-index diameter. They do not determine the full defect or
refute (E), and the examples explicitly satisfy the ordinary LRC target.

## Hypotheses and actual chambers

Fix `d>=2`, `K>=2`, and the author's constants

    A=(d+1)(4d+5),   a=1/A,   M=AK+1,
    v=(1,...,d-1,M),   alpha=1/(d+1).

Then `0<a<alpha`, `alpha-a=4(d+1)a`, and the speeds are positive, distinct
and primitive. At `t=alpha`, every slow speed has distance at least alpha,
and `M alpha=K(4d+5)+alpha` has distance alpha. This establishes an actual
closed witness; it is not a computation of the tuple's maximum or energy.

For `2K+1<=j<=3K-1`, the endpoint inequalities follow from

    2aM=2K+2/A < 2K+1,
    3K < 3aM=3K+3/A.

Thus each entire `C_j=[j/M,(j+1)/M]` lies strictly in `(2a,3a)`.
Since `3(d-1)/A<1/2`, every slow norm is exactly `it` throughout this
interval; no slow zero produces an intervening cut. There are exactly
`K-1` consecutive actual chambers in the stated run, without a hidden
relabeling of the chamber indices. Every slow slack is positive, and the
fast slack is positive on `((j+a)/M,(j+1-a)/M)`, of positive length.

The local maximum calculation uses the smallest slow norm, namely `t`.
On `C_j`, the simultaneous minimum is at most `min(t,j+1-Mt)`.
These two affine functions meet at `t_j=(j+1)/(M+1)` and their minimum
has a unique maximum there. The chamber midpoint is below `1/2`, giving
`M>2j+1`; equivalently, `t_j` lies strictly after the midpoint. It is
inside `C_j`, on the descending fast branch, where the upper bound is
attained. Hence exactly

    mu_C=(j+1)/(M+1) in (2a,3a),   mu_C<alpha.

The use of rational zero cuts, rather than additional half-phase cuts,
matches the accepted concavity/homothety contract.

## Complete integral and threshold derivative

Hold the tuple, chamber and center `c=(j+1/2)/M` fixed while varying the
threshold near the chosen a. In particular, do not differentiate the
defining family relation `M=AK+1`. The strict slow-slack inequalities on
the compact chamber persist in an open threshold neighborhood.

With `L=1/2-a`, the positive fast tent in coordinates `u=t-c` is
`L-M|u|` on `|u|<=L/M`. Expanding
`F_a(c+u)=product_{i=1}^{d-1}(i(c+u)-a)` gives precisely the author's
positive coefficients `b_r(c,a)`. For even r, direct integration yields

    2 integral_0^(L/M) u^r(L-Mu) du
      =2 L^(r+2)/[M^(r+1)(r+1)(r+2)].

Odd moments vanish. This proves the author's entire finite formula (1),
including all slow factors and both fast branches. Writing
`u_r=-partial_a b_r>=0`, termwise differentiation gives formula (2):

    H_C=sum_{r even} 2[u_r L^(r+2)+(r+2)b_r L^(r+1)]
                       /[M^(r+1)(r+1)(r+2)].

The sum has `0<=r<=d-1`; the top coefficient can have zero derivative,
consistent with `u_r>=0`. There is no endpoint correction: the fast
slack vanishes at each moving endpoint. This agrees with the accepted
dominated-differentiation identity `H_C=-I_C'` on the fixed chamber.

## Strict sign, transport and aggregate bound

At every common-positive time in the run, `0<t-a<2a`. Keeping just the
speed-one summand in `H` gives a strictly larger density than `P_a/(2a)`.
Since `I_C>0`, the exact conclusion is

    H_C>I_C/(2a),
    Delta_C=(d+1)I_C-4(d+1)a H_C < -(d+1)I_C < 0.            (1)

This establishes the sign directly, without inferring it from the
subcritical local maximum or from selected Fourier terms.

Every slow slack also exceeds a on the whole chamber. The fast slack's
integral is exactly `L^2/M`, so `I_C>a^(d-1)L^2/M`. Summing (1) gives

    sum_run Delta_C < -(d+1)a^(d-1)L^2 (K-1)/(AK+1).

Here d, a and L are fixed. Since `(K-1)/(AK+1)` tends to `1/A=a`,

    limsup_(K -> infinity) sum_run Delta_C
      <= -(d+1)a^d L^2 < 0.

The non-strict limiting inequality is correct despite the strict finite
inequalities. No convergence or equality of the defect sums is assumed.
This is a bound for the run alone, not the sum over the whole period.

For successive chambers that both belong to the run, `t -> t+1/M`
preserves the fast norm, has unit Jacobian, and increases each slow norm
by exactly `i/M`. It transports the entire positive fast interval onto
its successor. Since there is at least one slow factor and the fast
slack is positive on an interval, the increase in `I_C` is strict.
Both transported defects remain negative by (1). Reflection of an actual
cell preserves every integer-speed norm, hence also I, H and Delta; it
cannot alone turn this negative budget into positive credit.

## Quantifiers and disposition

Let any finite nonnegative integer R be given, even as a function of d
and a. Choose `K>=2R+2` and `j_*=2K+R+1`. Then

    j_*-R=2K+1,   j_*+R=2K+2R+1<=3K-1.

Because these are consecutive actual chambers, the entire R-neighborhood
of `C_(j_*)` in the ordered cell system has strictly negative defects.
Every group of index diameter at most R containing that cell lies in
this neighborhood. Any positive weighted sum of its defects is strictly
negative. Such groups therefore cannot partition the full cell system
into nonnegative budgets. Ordinary pairs are included as a special case.
The author correctly does not infer a global energy identity from an
arbitrarily weighted partition; those weights only strengthen the
obstruction being tested.

At each fixed d the threshold a remains fixed while K is arbitrarily
large. This refutes any finite index radius independent of speed height,
including one depending on d and a. It does not bound physical transport
distance: the run's time length tends to `1/A`. Remote groups, ranges
growing with height, and credit relayed through an arbitrarily long chain
remain outside the falsified contract.

The first unresolved implication is a global assignment of sufficient
positive cell budgets to the deficient cells, with a capacity bound
preventing repeated expenditure of the same surplus. Neither the local
homothety nor the improving endpoint translation supplies that assignment.
The full defect of this admissible good family was not evaluated. The
global inequality (E) and unrestricted LRC remain unproved and unrefuted.

## Bound sources and actual checks

The complete frozen author was read and checked by hand. The four earlier
mathematical inputs were already reviewed in preceding tasks; their hashes
were checked unchanged here, and the derivative/local-cell contracts were
reread. No new mathematical research or computational experiment was run.

| Source | SHA-256 |
| --- | --- |
| `research/astra-rational-cell-compensation.md` | `3304bb071092c71e6516b5c1e16b0d47d918f1c21042f7c47592865d2ac10076` |
| `research/astra-uniform-strategy-after-fold.md` | `e569596af4ebab9f9d5e1c796d8da435bc433c1c238bc10f9901e644f9f49871` |
| `research/astra-slack-energy-review.md` | `1c526b214e7772088555642447d5fa2f93030f40195fd4aaca7a79bb1f6bd573` |
| `research/astra-slack-energy-global-compensation.md` | `8032d020e4beccc1112b025c8b85f6be6c2ec5cb67cdd763d4ae62a029627cb9` |
| `research/astra-slack-energy-global-review.md` | `c6416983efcbeeb909449a372be2ff316647f0ab6d92ba4d199429bd35e75e79` |
| `.codex/config.toml` | `28212a53cf42cdc377df1f7dab040732d657e59d7bb97ee78791256d01d4bb2c` |
| `docs/project-workflow.md` | `2b42a133352b6b53ba2106fc73882733f176e04a0deffbb183b4c16eefd9cd67` |
| `research/workflow-policy.json` | `833c397b61d1ffdb994fb115019f6d60d6c1a62ff85f19cdd2c9f8ac3a979c8b` |
| `scripts/validate_workflow.py` | `250a3ce2a080f5835ac4fd2e4b2803568424c777cda5d421f9fe92efd34d5383` |

Read the current configuration, workflow, policy and focused active task.
The gate was `research/in_progress`, with explicit 2026-09-05 start
authorization. `python3 -B scripts/validate_workflow.py` exited zero:
`workflow structural validation passed; it cannot certify mathematical validity.`
Complete hashes were checked with `sha256sum`. No mathematical program,
build, cache operation, external model, additional agent, Git operation,
shared-state write, memory write or other-file edit was used. This is an
independent manuscript review, not a kernel proof or a full-goal result.
