# Normalized phase densities: exact signal and certification limits

Task `/root/normalized_phase_signal`; requested `gpt-6-astra/xhigh`.
Observed model, effort, elapsed time and usage: `null`. Assignment checkpoint:
`92d567677620fec37008cff35a70092339a87fd3`. Only this manuscript is owned.
Status: new hand derivations awaiting independent review; no kernel theorem.

**Finding.** Full dependent products preserve the phase average after
normalization. Their Fourier weights can be negative and acquire infinitely
many phase harmonics. Aggregating those harmonics gives exact nonnegative
spectral gains, but no sharp lower signal is obtained. More concretely, this
entire fixed density family, including its mixtures, fails to detect uncovered
times at thresholds just below the true optimum of every tuple. This is a
limitation of an all-subthreshold certificate claim, not a counterexample
satisfying hypothetical minimal-failure assumptions.

## Exact normalization, without dissociation

Let `n>=2`, let `v_1,...,v_n` be positive integers, and give both `T` and `T^n`
normalized Haar measure. Distinctness and primitivity may be imposed but are
not required for the identities. Write `e(x)=exp(2 pi i x)` and

    R_theta(t) = product_i (1+cos(2 pi(v_i t+theta_i))),
    B(theta) = integral_T R_theta(t) dt,
    W_theta(t) = R_theta(t)/B(theta),
    w(theta) = R_theta(0)/B(theta).

There is an elementary bound independent of the speed heights. For
`P_theta(z)=product_i(1+e(theta_i)z^(v_i))`,

    R_theta(t)=2^(-n)|P_theta(e(t))|^2,
    B(theta)=2^(-n) sum_k |[z^k]P_theta|^2 >= 2^(1-n).

The constant and top-degree coefficients both have modulus one, because all
speeds are positive. Consequently `0<=W_theta<=2^(2n-1)`. The denominator is
smooth and bounded away from zero; all phase integrals below are justified.
Each density is positive except at finitely many times.

Time translation gives

    B(theta+v tau)=B(theta),
    W_theta(t)=w(theta+v t),
    integral_T w(theta+v t) dt=1.                             (1)

Haar invariance makes `E_theta W_theta(t)` independent of `t`; integrating
in `t` gives `E_theta W_theta(t)=1`. Thus, for real bounded measurable `F`,

    Z_F(theta)=integral F(t) W_theta(t) dt,
    E_theta Z_F=integral F.

Use the Fourier convention `f_hat(k)=integral f(x)e(-k dot x) dx`.
Changing variables `eta=theta+v t` in the phase integral proves exactly

    Z_F_hat(sigma)=w_hat(sigma) F_hat(-v dot sigma).            (2)

Taking Fourier coefficients of the last identity in (1) gives

    w_hat(0)=1,
    w_hat(sigma)=0 if sigma!=0 and v dot sigma=0.              (3)

Also `w(-theta)=w(theta)`, so its coefficients are real and even. Equations
(1)--(3) are derived here independently. They do not require a dissociated
subtuple or an independent shift of the original runners' starting points.

For any threshold `0<=delta<=1/2`, define

    Phi_delta(t)=sum_i 1_{||v_i t||<=delta}.

If these bad sets cover, then `1<=Phi_delta<=n`. With
`epsilon=2n delta-1` and `Y=Z_(Phi_delta-1)`, we retain

    0<=Y<=n-1,   E Y=epsilon.

This applies in particular at the actual maximum
`mu=max_t min_i ||v_i t||`; a freely chosen `delta<mu` is not a cover.

## An exact dependent coefficient calculation

Take the admissible primitive distinct tuple `(1,2,3)` and
`p=(1,1,-1)`. The only nonzero relations in `{-1,0,1}^3` are `p,-p`, so

    B(theta)=1+(1/4)cos(2 pi p dot theta).

Put `q=4-sqrt(15)`, so `0<q<1` and `q+q^(-1)=8`. The elementary Poisson
series, or multiplication of the displayed series by `B`, gives

    1/B(theta)=sum_{j in Z} h_j e(j p dot theta),
    h_j=(4/sqrt(15))(-q)^|j|.

The numerator has coefficient `2^(-|supp eta|)` for
`eta in {-1,0,1}^3` and zero otherwise. Convolving therefore yields

    w_hat(e_i)=1-2/sqrt(15)                 (i=1,2,3),
    w_hat(e_1-e_2)=1/sqrt(15),
    w_hat(2e_1+k p)=(-q)^(k+1)/(2sqrt(15)) (integer k>=0).     (4)

For the first formula only `h_0/2+h_1/4` contributes; for the second only
`h_0/4` contributes. In the last formula the only contributing numerator
vector is `(1,-1,1)`, with coefficient `1/8` and inverse index `k+1`.
In particular `w_hat(2e_1)<0`. There are infinitely many nonzero alternating
phase coefficients, all in this example at the same time frequency
`v dot (2e_1+k p)=2`. Thus neither the original weights `2^(-support)` nor
nonnegativity of every replacement weight survives normalization.

This is not confined to one moving count. Append any sequence of odd speeds,
each larger than the sum of all preceding speeds. A signed zero relation
cannot involve the largest appended speed, so the denominator remains the
one above and the displayed coefficients persist with zero appended phase
indices. The family is good: the first three speeds have maximum `1/4`
(by reflection it suffices to use `[0,1/2]`; its ranges `[0,1/4]`,
`[1/4,5/12]`, `[5/12,1/2]` are bounded
by speeds `1`, `3`, `2`, respectively), and `t=1/4` retains that margin for
every appended odd speed. No strict-failure example is claimed.

## First-order mass cannot stay uniformly large

The orchestrator supplied the following argument; it is independently
checked here. Choose deterministic offsets `phi_i` so that

    integral w(theta) sum_i cos(2 pi(theta_i-phi_i)) dtheta
      = sum_i |w_hat(e_i)|.

By (1) and Haar invariance, this equals
`E_theta integral W_theta(t) S_theta(t) dt`, where
`S_theta(t)=sum_i cos(2 pi(v_i t+theta_i-phi_i))`. It is at most
`E_theta sup_t S_theta(t)` since `W_theta` is a probability density.

Set the integer `K=8 sum_i v_i`. The derivative has absolute value at most
`2 pi sum_i v_i<K`, so a mesh with spacing `1/K` gives

    sup_t S_theta(t) <= 1+max_{0<=j<K} S_theta(j/K).

At each fixed mesh point the summands are independent uniform-phase cosines.
For `lambda>0`, termwise integration of the exponential gives

    E exp(lambda cos(2 pi U))
      =sum_{r>=0} (lambda^2/4)^r/(r!)^2 <= exp(lambda^2/4).

Log-sum-exp followed by Jensen bounds the expected mesh maximum by
`log(K)/lambda+n lambda/4`. Taking `lambda=2sqrt(log(K)/n)` proves

    sum_i |w_hat(e_i)| <= 1+sqrt(n log(8 sum_i v_i)).           (5)

For `v=(1,...,n)`, division by `n` makes the right side tend to zero.
Thus even a uniform positive lower bound on the *average absolute* first
weight is false. This limits first-order replacements of the dissociated
signal; it says nothing by itself against a signal using all harmonics.
The proof uses only covariance and nonnegative unit mass, so the same
first-order bound applies to other kernels with those properties, including
normalized finite powers of the product. It is still only a first-order bound.

## The exact aggregate signal retains every phase harmonic

Let `S(v)={v dot eta: eta in {-1,0,1}^n}` and put

    c_m(theta)=integral R_theta(t)e(-m t) dt,
    A_m=E_theta |c_m(theta)/B(theta)|^2.

The Fourier series in common time stays finite even though the phase series
does not: division by `B(theta)` cannot add time frequencies. Parseval in
the phase variables and (2) give

    A_m=sum_{sigma: v dot sigma=m} |w_hat(sigma)|^2,
    Var_theta(Z_F)=sum_{m!=0} A_m |F_hat(m)|^2.                (6)

Here `A_0=1`; `A_m=0` outside `S(v)`; and `0<A_m<1` for every nonzero
`m in S(v)`. Positivity follows because `c_m` is a nonzero trigonometric
polynomial: its distinct phase monomials have positive coefficients.
The upper bound is strict because a density positive almost everywhere
cannot have a nonconstant character of modulus-one expectation. This also
follows from strictness in the triangle inequality for
`integral W_theta(t)e(-m t)dt`.

For a cover, `Y^2<=(n-1)Y` therefore supplies the exact necessary inequality

    sum_{m!=0} A_m |Phi_delta_hat(m)|^2
      <= epsilon (n-1-epsilon).                              (7)

There is no discarded support or adverse sign in (6)--(7). But no lower
bound for this actual weighted signal strong enough to force
`epsilon>=(n-1)/(n+1)` has been established. Equation (5) does not rule out
such a full-signal argument; equation (7) does not supply one.

## Failure of an all-subthreshold certificate claim

Fix any one tuple of positive integer speeds with `n>=2`, and let `mu` be
its actual maximum. It is positive, since only finitely many times are zeros
of the individual runners. At `delta=mu`, `Phi_mu>=1` everywhere and
`Phi_mu=n` on a nonempty interval about zero. Since every `W_theta` is
positive except at finitely many times,

    integral (Phi_mu-1) W_theta > 0   for every theta.

The integral is continuous in `theta`; compactness of `T^n` gives

    gamma_v=min_theta integral (Phi_mu-1) W_theta > 0.

Let `M_v=max_(theta,t) W_theta(t)`, finite and at most `2^(2n-1)`.
For `0<=delta<mu`, Haar measure preservation of each integer circle map
gives `integral (Phi_mu-Phi_delta)=2n(mu-delta)`. Hence, uniformly in phase,

    integral Phi_delta W_theta
      >= 1+gamma_v-2n M_v(mu-delta) > 1                      (8)

whenever `0<mu-delta<gamma_v/(2n M_v)`. Nevertheless `Phi_delta=0` on a
nonempty open interval about a maximizing time: every runner there is
strictly farther than `delta` from zero. Thus all these densities, and all
their probability mixtures, miss an existing uncovered interval.

This obstruction reaches every moving count at the canonical threshold.
For `v=(1,...,n)`, one has `mu=alpha=1/(n+1)`: a shortest cyclic gap among
`0,t,...,nt` gives some `||i t||<=alpha`, and `t=alpha` attains equality
for the minimum over all speeds. Therefore (8) refutes the proposed
sufficiency statement

    for every tuple and every 0<delta<alpha,
    some phase theta has integral Phi_delta W_theta < 1.     (false)

There is also an explicit hand check of the gap for `(1,2)`, where `B=1`.
At `mu=1/3`, set `c=sqrt(3)/(2 pi)`, `x=2 pi theta_1`, `y=2 pi theta_2`.
The only required time coefficients are
`Phi_hat(1)=c`, `Phi_hat(2)=c/2`, `Phi_hat(3)=0`, so

    integral Phi_mu W_theta
      =4/3+c[cos x+(1/2)cos y+(1/2)cos(y-x)].

Minimizing in `y` leaves `cos x-|cos(x/2)|`. Writing
`u=|cos(x/2)| in [0,1]`, its minimum is that of `2u^2-u-1`, namely
`-9/8` at `u=1/4`. Consequently

    min_theta integral Phi_mu W_theta
      =4/3-9sqrt(3)/(16 pi)=1+gamma,
    gamma=1/3-9sqrt(3)/(16 pi)>0.                             (9)

For positivity, `27sqrt(3)<48<16 pi` suffices. Since here `W<=4`, the
entire explicit interval `1/3-gamma/16<delta<1/3` has uncovered times but
`integral Phi_delta W_theta>1` for every phase.

The falsified statement permits thresholds below the actual maximum.
It is **not** the statement restricted to an actual maximum
`mu<alpha` of a hypothetical minimal failure. No example here satisfies
those failure hypotheses. The compactness argument concerns this fixed
unit-amplitude family and its mixtures; it does not exclude unbounded
powers, increasingly concentrated densities, or other adaptive families.

## First unresolved implication and checks

The normalized phase average survives with every original speed present.
What remains missing is an arithmetic lower signal at an actual hypothetical
subcritical maximum, strong enough to force order-one `epsilon`, or a
different density construction justified by the full failure hypotheses.
Replacing the weights by positive constants is false; the exact aggregate
constraint (7) does not close that step. Ordinary or canonical LRC and the
stronger all-threshold slack-energy inequality remain unresolved.

The corrected source contract was read completely at the hash below. Its
reviewer's acceptance paragraph was read; the external paper and its earlier
inputs were not independently audited in this task. All new mathematical
statements above have direct hand derivations. The correction's acceptance
does not promote this new manuscript to independently reviewed evidence.

| Read input | SHA-256 |
| --- | --- |
| `research/astra-phase-riesz-global-contract.md` | `66c83f09a66f169ef9e212d5e5d4ca32acc2fa3732c94def184d4015061ef848` |
| Acceptance paragraph of `research/astra-phase-riesz-contract-review.md` | `e1fc63cb735696edfe2340788e4fb9b8958f708af77adbba790fc6ba23d99a97` |
| `.codex/config.toml` | `28212a53cf42cdc377df1f7dab040732d657e59d7bb97ee78791256d01d4bb2c` |
| `docs/project-workflow.md` | `2b42a133352b6b53ba2106fc73882733f176e04a0deffbb183b4c16eefd9cd67` |
| `research/workflow-policy.json` | `833c397b61d1ffdb994fb115019f6d60d6c1a62ff85f19cdd2c9f8ac3a979c8b` |
| `scripts/validate_workflow.py` | `250a3ce2a080f5835ac4fd2e4b2803568424c777cda5d421f9fe92efd34d5383` |

Read the configuration, workflow, policy and focused active task at startup
and after compaction. The gate was `research/in_progress`, with explicit
2026-09-05 start authorization and the owned task recorded. The command
`python3 -B scripts/validate_workflow.py` exited zero:
`workflow structural validation passed; it cannot certify mathematical validity.`
Input hashes were checked with `sha256sum`. No mathematical program, sweep,
solver, build, cache operation, Git operation, shared-state write, additional
agent, browser model, or memory write was used. Only this manuscript changed.
