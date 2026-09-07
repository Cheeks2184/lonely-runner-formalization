# Independent review of exact-support compensation

Task `/root/slack_energy_global_review`, existing reviewer handle
`/root/fold_zero_restoration_resume`, requested Astra/xhigh. Current task
checkpoint `6cdabaff21e525ee1728ecf215ecf77e2b54f95d`. Only this review
is owned. The complete frozen author is
`research/astra-slack-energy-global-compensation.md`, SHA-256
`8032d020e4beccc1112b025c8b85f6be6c2ec5cb67cdd763d4ae62a029627cb9`.

**Verdict: accepted at the stated manuscript scope, without corrections.**
The complete `(1,2,4)` integration and exact-support decomposition are
correct. The negative odd-support block and defect statements, including
their extension to positive subcritical thresholds, are justified without
differentiating an infinite Fourier series. These results refute the
specified termwise sign shortcuts. They neither prove nor refute the full
slack-energy inequality E. No new mechanism or partial-sum screen is
introduced by this review.

## Exact support and ambient-dimension bookkeeping

Retain positive distinct primitive integer speeds of count `d>=2`,
`alpha=1/(d+1)`, `0<a<alpha`, and `L=1/2-a`. The energy and full
defect are

    I_v(a)=integral product_i (||v_i t||-a)_+ dt,
    H_v(a)=-dI_v/da=dI_v/dL,
    Delta_v=(d+1)I_v-(alpha-a)H_v.

The Fourier coefficients and absolute convergence are the frozen strategy's
correct tent calculation. Grouping by exact support partitions the full
absolutely convergent relation sum. There is one empty-support term
`L^(2d)`, and no support-one term because `v_i k_i=0` forces `k_i=0`.
No common constant is repeated across different relation rays.

For a subset `U`, the auxiliary quantity

    J_U=L^(2(d-|U|)) I_U(1/2-L)

sets every coordinate outside `U` to its zero Fourier index. Thus
`J_U=sum_(S subset U) R_S`. Finite inclusion-exclusion proves

    R_S=sum_(U subset S) (-1)^(|S|-|U|) J_U.

This supplies derivatives through finitely many ordinary energy functions.
In particular, the block defect uses the **ambient** coefficient `d+1`
and the ambient `alpha`, not the native count of its supporting subset.
Summing the block defects gives exactly `Delta_v` with no missing term
or derivative sign. No differentiated infinite-series assertion is needed.

## Exhaustive integration for `(1,2,4)`

Let `a=1/4-epsilon`, `0<=epsilon<1/20`, so `1/5<a<=1/4`.
Put `M=1-3a=1/4+3epsilon` and `L=1/2-a`.
Reflection reduces the energy integrations to `[0,1/2]` and doubles them.

For the pair `(1,2)`, the common good interval is
`[a,(1-a)/2]`. On its part before `1/4`, replacing the true rising
speed-two norm by the descending one overestimates its slack by `1-4t`.
The full reflected correction is

    2 integral_a^(1/4) (t-a)(1-4t) dt=(4/3)epsilon^3.

The provisional descending-branch integral is `M^3/12`. Hence
`P=I_(1,2)=M^3/12-(4/3)epsilon^3`. Integer time scaling on a full
period gives `I_(2,4)=P` exactly.

For `(1,4)`, the first speed-four good interval has upper endpoint
`(1-a)/4<a`, because `a>1/5`; speed one excludes it. The sole
surviving half-period interval is centred at `3/8` with radius `L/4`.
Writing `y=t-3/8`, its speed-four slack is `L-4|y|`. The odd part of
the other slack `y+3/8-a` integrates to zero. Consequently

    Q=2(3/8-a) integral_(-L/4)^(L/4) (L-4|y|)dy
     =L^2(L-1/8)/2.

For the triple, intersecting this interval with the speed-two constraint
leaves exactly

    [(1+a)/4,(1-a)/2].

The lower endpoint is above `a` and above `1/4`; the upper endpoint is
the tighter of the speed-two and speed-four upper constraints. There is
no omitted component at these thresholds. Its only remaining norm-branch
change is the speed-four peak at `3/8`.

Set `x=t-(1+a)/4` and `W=M/4`. Before correcting that peak, the
three slacks are `x+W`, `2(W-x)`, and `4x`. Their reflected integral is

    16 integral_0^W x(x+W)(W-x) dx=M^4/64.

On the falling end, `y=t-3/8` ranges from zero to `epsilon/2`.
The provisional speed-four slack exceeds the actual one by `8y`.
The full correction is

    16 integral_0^(epsilon/2)
           y(1/8+epsilon+y)(epsilon-2y)dy
       =epsilon^3/12+(5/6)epsilon^4
       =M epsilon^3/3-epsilon^4/6.

Subtracting proves the author's complete formula

    I_(1,2,4)=M^4/64-M epsilon^3/3+epsilon^4/6.

These formulas include `epsilon=0`; the falling correction then has an
empty interior. Endpoints of the positive regions have measure zero and
introduce no extra term in the energy derivative.

## Exact defect decomposition at `a=6/25`

Here `epsilon=1/100` and `L=13/50`. Since
`d epsilon/dL=1` and `dM/dL=3`, differentiating the preceding exact
polynomials gives precisely

    P=457/250000,          P'=73/1250,
    Q=4563/1000000,        Q'=689/10000,
    I=57569/600000000,     H=12263/3000000,
    Delta_v=823/2400000>0.

Primes here are derivatives in `L`. For example,
`P'=3M^2/4-4epsilon^2` and
`I'=3M^3/16-M epsilon^2-epsilon^3/3`, confirming the derivative
normalization and the value of H independently of a Fourier derivative.

With ambient `d=3`, a pair block is
`R_{i,j}=L^2(I_(i,j)-L^4)`. All three pairs and the empty support thus
sum to `J=L^2(2P+Q)-2L^6`. Direct substitution gives

    J=-3889197/62500000000,
    J'=100373/39062500,
    4J-(1/100)J'=-4290689/15625000000<0.

There is exactly one remaining nonempty support, of size three. Its
defect is the full value minus that complete lower-support value:

    Delta_{1,2,3}=115785143/187500000000>0.

This agrees with the author and repairs the entire negative lower-support
defect. The tuple itself is good: `t=1/3` gives distance `1/3` in every
coordinate, and `(1,2)` supplies the matching global upper bound.
Neither negative J nor its negative defect is a falsifier to E.

The two displayed pair relations generate the entire integer relation
lattice. Besides their primitive cross product `(1,2,4)`, an explicit
check is available: if `k_1+2k_2+4k_3=0`, then

    k=(-k_2-2k_3)(2,-1,0)-k_3(0,2,-1).

Thus combinations with full support really belong to this same complete
lattice. Their contribution is not determined by treating the two rays
as separate scalar problems.

## Endpoint signs and the positive-threshold conclusion

At `a=0`, `L=1/2`, every nonzero even Fourier coefficient vanishes;
every surviving nonzero index is odd with strictly positive `q_k`.
For a support of size `s`, all surviving signs are therefore `(-1)^s`.
Absolute convergence proves

    R_S(1/2)=(-1)^s A_S,       A_S>=0.

An actual relation supported exactly on S with all supported entries odd
makes the inequality strict. For coordinates of speeds `1,2,3`, the
relation `(1,1,-1)` supplies this condition. Appending other distinct
positive speeds multiplies that exact-support block by their positive
zero-frequency factors; it does not remove its negative sign.

The endpoint derivative argument is also sound. For each finite subset U,
dominated convergence in the original integral gives

    (dI_U/da)(0+)=-sum_(i in U) I_(U minus i)(0).

The derivative from positive a converges to this value: outside the finite
set of zero phases, every slack and all-positive indicator converge to
their zero-threshold values, with a uniform integrable bound. This proves
continuity of the energy derivative at the endpoint, not merely existence
of a one-sided difference quotient. The empty subset is constant.

Differentiating `J_U` at `L=1/2` from the left therefore gives

    J'_U=4(d-|U|)J_U+4 sum_(i in U)J_(U minus i).

In inclusion-exclusion for a fixed S of size s, a term `J_U` in the
second sum receives `s-|U|` contributions of the opposite sign. Its net
coefficient is consequently `4(d-|U|)-4(s-|U|)=4(d-s)`, proving

    R'_S(1/2)=4(d-s)R_S(1/2),
    Delta_S(0)=[((d-1)^2+4s)/(d+1)] R_S(1/2).

The multiplier is strictly positive for the stated domain. All these
derivatives arise from a finite inclusion-exclusion expression, not an
unjustified termwise derivative of the infinite relation sum. The same
finite expression and derivative continuity make `Delta_S(a)` continuous
at zero. A strictly negative odd-support endpoint defect therefore remains
negative for every sufficiently small positive a. Intersecting that
neighbourhood with `(0,1/(d+1))` gives the claimed actual subcritical
scope; a uniform neighbourhood across all tuples is not asserted.

For `(1,2,3)` the displayed polynomial pieces of the full integrand are
exactly `6t^3`, `2t^2-6t^3`, `t-5t^2+6t^3`, and
`5t^2-t-6t^3` on the stated successive half-period intervals. Their
integral, reflection and the pair deletion integrals give

    I(0)=145/10368,   H(0)=41/216,
    R_{1,2,3}(1/2)=-23/10368,   R'_{1,2,3}(1/2)=0,
    Delta_{1,2,3}(0)=-23/2592,
    Delta_v(0)=11/1296>0.

For an additional normalization check, the empty support is `1/64` and
the only nonzero pair block at zero is the `(1,3)` block `1/1728`.
Their sum is `7/432`, whose subtraction from the full integral yields
the claimed negative full-support value. Their positive defects compensate
that negative block. There is again no negative full defect in this control.

## Scope, first unresolved implication and receipts

The two examples show opposite directions of compensation. They disprove
discarding all higher-support terms or assigning a uniformly nonnegative
defect to every such block. They do not exclude a valid global estimate
that balances blocks of different supports. The first unresolved step is
still a bound of the combined negative defect by the combined positive
defect for every actual relation lattice and every `0<a<1/(d+1)`, with
the empty-support term counted once. No such bound or E falsifier is
contained in the author or this review. The unrestricted canonical goal
remains unresolved. No next mechanism or extended screen is proposed here.

The complete author was read; its frozen strategy input was fully read in
the preceding review and is unchanged. All five author input bindings and
the author itself were checked against the following current hashes:

| File | SHA-256 |
| --- | --- |
| `research/astra-slack-energy-global-compensation.md` | `8032d020e4beccc1112b025c8b85f6be6c2ec5cb67cdd763d4ae62a029627cb9` |
| `research/astra-uniform-strategy-after-fold.md` | `e569596af4ebab9f9d5e1c796d8da435bc433c1c238bc10f9901e644f9f49871` |
| `.codex/config.toml` | `28212a53cf42cdc377df1f7dab040732d657e59d7bb97ee78791256d01d4bb2c` |
| `docs/project-workflow.md` | `2b42a133352b6b53ba2106fc73882733f176e04a0deffbb183b4c16eefd9cd67` |
| `research/workflow-policy.json` | `833c397b61d1ffdb994fb115019f6d60d6c1a62ff85f19cdd2c9f8ac3a979c8b` |
| `scripts/validate_workflow.py` | `250a3ce2a080f5835ac4fd2e4b2803568424c777cda5d421f9fe92efd34d5383` |

Current config, workflow, policy and focused state were read. The gate is
`research / in_progress`, with recorded explicit start authorization.
Actual command in `/home/joshua/lonely-runner-formalization`:

    python3 -B scripts/validate_workflow.py

Exit status zero; complete output:

    workflow structural validation passed; it cannot certify mathematical validity.

The mathematical verification was exact hand integration, arithmetic,
finite inclusion-exclusion and endpoint analysis. Administrative readback
checks the six bindings, final newline and trailing whitespace and reports
this review's hash separately. No mathematical program, numerical screen,
solver, build/cache/dependency operation, browser model, external source,
extra agent, Git mutation, shared-state edit or other-file write was used.
No owned process remains. Requested route is Astra/xhigh; observed model,
effort, reviewer elapsed time and token usage remain null.
