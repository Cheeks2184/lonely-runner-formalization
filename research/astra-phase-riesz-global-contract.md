# Phase Riesz products: exact transfer and remaining global contract

Task `/root/phase_riesz_global_contract`; requested `gpt-6-astra/xhigh`.
Observed model, effort, elapsed time and usage: `null`. Assignment source:
`6cdabaff21e525ee1728ecf215ecf77e2b54f95d`. Only this file is owned.
Status: bounded source audit and new hand derivations, awaiting independent
review. No formal theorem, sharp LRC proof, or falsification of (E) is claimed.

**Finding.** The audited phase mechanism supplies a useful homogeneous bound
on selected Fourier coefficients of the full slack product. It supplies no
comparison of its mean with its threshold derivative. No uniform sharp step
follows from this mechanism with the present inputs and error estimates.

## Frozen sources and scope

The primary source is Bedert--Hu, *Phase-randomised Riesz products and a further
improvement towards the lonely runner conjecture*, [immutable main.tex](https://github.com/hxypqr/phase_riesz_products_lonely_runner/blob/d53fa46aedf01779481fc5f17726bb0ab6770ac4/main.tex),
commit `d53fa46aedf01779481fc5f17726bb0ab6770ac4`. The orchestrator supplied
the 36,745-byte source at `/tmp/astra-bedert-hu-d53fa46.tex`; its complete hash
was verified. This audit read that source and both local contract files below.
Author-link provenance and publication status are outside this bounded audit.

| Complete input | SHA-256 |
| --- | --- |
| `/tmp/astra-bedert-hu-d53fa46.tex` | `b50d17e25c4e8c4841e7350463b3f08a0ce5fd1b9ecec0d9cc97cd9924761079` |
| `research/astra-uniform-strategy-after-fold.md` | `e569596af4ebab9f9d5e1c796d8da435bc433c1c238bc10f9901e644f9f49871` |
| `research/astra-slack-energy-review.md` | `1c526b214e7772088555642447d5fa2f93030f40195fd4aaca7a79bb1f6bd573` |
| `.codex/config.toml` | `28212a53cf42cdc377df1f7dab040732d657e59d7bb97ee78791256d01d4bb2c` |
| `docs/project-workflow.md` | `2b42a133352b6b53ba2106fc73882733f176e04a0deffbb183b4c16eefd9cd67` |
| `research/workflow-policy.json` | `833c397b61d1ffdb994fb115019f6d60d6c1a62ff85f19cdd2c9f8ac3a979c8b` |
| `scripts/validate_workflow.py` | `250a3ce2a080f5835ac4fd2e4b2803568424c777cda5d421f9fe92efd34d5383` |

The source cites earlier Bedert inputs for small additive dimension, a Fejer
signal, and arithmetic-progression intersection bounds, and Bonami for degree
two hypercontractivity. Their exact uses are recorded below; this is not an
independent audit of those earlier papers. The phase algebra, transfer formulas
and propagation of the stated bounds are checked here by hand.

## One mechanism, including every support in its test

Write `n=N-1` for the number of distinct positive integer speeds and `k` for
the paper's additive dimension (called `d` there). Put

    delta = max_t min_i ||v_i t||,   epsilon = 2 n delta - 1,
    phi = 1_{[-delta,delta]} on T,   Phi(t) = sum_i phi(v_i t).

At this actual maximum, `1 <= Phi <= n` everywhere and `integral Phi=1+epsilon`.
The paper assumes `delta<=0.9/n`; otherwise its weaker target already follows.
Its nonzero Fourier coefficients are

    Phi_hat(r) = sum_{v_i | r} lambda(r/v_i),
    lambda(j) = sin(2 pi j delta)/(pi j).

Take a 2-dissociated `D subset V` of maximum cardinality, meaning no nonzero
relation with coefficients in `{-2,-1,0,1,2}`, and `k=|D|`. The cited Fejer input supplies
`1<=j_0<100n`, `D'=j_0 D`, with `sum_{m in D'} Phi_hat(m)>=k/(Cn)`.
Let `E_j` contain all signed sums of exactly `j` distinct elements of `D'`.
The signed representation is unique and the layers are disjoint. The cited
arithmetic-progression bound is `|E_j intersect P| <= (C log(2+|P|))^j`.

For independent auxiliary phases `theta in T^k`, the source's density is

    R_theta(t) = product_{m in D'} [1+cos(2 pi (m t+theta_m))]
      = sum_{sigma in {-1,0,1}^k} 2^{-s(sigma)}
          e(t sum_m sigma_m m) e(sigma dot theta),

where `e(x)=exp(2 pi i x)` and `s(sigma)=|supp sigma|`. All supports are present.
Nonnegativity is pointwise; dissociation makes its integral exactly one for
every phase. Also `E_theta R_theta(t)=1`. Thus

    Y(theta) = integral Phi(t) R_theta(t) dt - 1

satisfies `0<=Y<=n-1`, `E Y=epsilon`, and, for every nonzero signed vector,

    Y_hat(sigma) = 2^{-s(sigma)} Phi_hat(-sum_m sigma_m m).       (1)

These phases choose a density on the original common time. They do not give
the runners independent starting phases, nor replace that time by separate
row witnesses.

The source's Bonami input says `||g||_q <= C q ||g||_2`, `q>=2`, for a
trigonometric polynomial supported on signed phase vectors of support two.
For `0<=f<=1` of mean `eta`, choose `q=max(2,ceil(log(e/eta)))` and its
conjugate `p`. Then `||f||_p<=eta^(1-1/q)<=e eta`. Duality and Holder give

    sum_{s(sigma)=2} |f_hat(sigma)|^2 <= C eta^2 log^2(e/eta).

Apply this to `f=Y/n`, use (1), and use uniqueness of the signed sums:

    sum_{ell in E_2} |Phi_hat(ell)|^2
      <= C epsilon^2 log^2(en/epsilon).                       (2)

At `epsilon=0` the right side is zero by continuity, or directly because
`Y=0` almost everywhere. With `J=n^3`, the intersection of `E_2` with
`union_i v_i[-J,J]` has size at most `Cn(log n)^2`. Cauchy--Schwarz on that
set, and the progression bound in dyadic blocks outside it, yield

    sum_{E_2} |Phi_hat|
      <= C epsilon sqrt(n) log n log(en/epsilon)
           + C (log n)^2/n^2.                                (3)

The final test is the nonnegative probability density
`R_rho=product_{m in D'}(1-rho cos(2 pi m t))`, `0<=rho<=1`.
Its coefficient at every `ell in E_j` is exactly `(-rho/2)^j`. Therefore
the complete contribution of all levels at least three is

    T_{>=3} = sum_{j=3}^k (-rho/2)^j sum_{ell in E_j} Phi_hat(ell).

For `C rho^(1/3) log n<=1/2`, the source bounds this entire sum by
`C rho^3(log n)^9 + C n^2 rho^(10 log n)`. The latter term controls every
support at least `ceil(10 log n)`, using disjointness and the harmonic sum
over at most `3^k` frequencies. For the remaining supports the progression
bound gives at most `n^(-1)(C log n)^(3j)` per original speed, and summing
the resulting geometric series gives the first term. Thus no high support
is silently discarded, but its sign is discarded in the error bound.

The cover test `integral Phi R_rho>=1`, the Fejer signal and (3) give

    0 <= epsilon - rho k/(Cn)
       + C rho^2 epsilon sqrt(n) log n log(en/epsilon)
       + C rho^2(log n)^2/n^2
       + C rho^3(log n)^9 + C n^2 rho^(10 log n).               (4)

For sufficiently large `n`, with absolute constants allowed to vary between
bounds, `sqrt(n)<=k<=n` and `rho=kappa n^(-1/4)(log n)^(-5)` make all error terms
`o(rho k/n)` if `epsilon<=c_0 rho k/n`. Taking `c_0` small contradicts (4).
Consequently the large-dimension excess is `k/[C n^(9/4)(log n)^5]`.
Balancing this with the cited small-dimension excess
`1/[C n k(log n)^C]` at `k=n^(5/8+o(1))` gives `n^(-13/8-o(1))`.

## Exact ingredient transferable to the full slack product

The phase estimate has a general version that does not require a cover.
For any measurable `0<=F<=M`, `M>0`, let `A=integral F` and
`Z_F(theta)=integral F R_theta`. Then `0<=Z_F<=M`, `E Z_F=A`, and (1)
holds with `Y,Phi` replaced by `Z_F,F`. Applying the same level inequality
to `Z_F/M`, whose support-two coefficients are `F_hat(-ell)/(4M)`, proves

    sum_{ell in E_2(D')} |F_hat(ell)|^2
      <= C A^2 log^2(eM/A).                                  (5)

For `A=0`, `F=0` almost everywhere and the bound is zero. This derivation
uses precisely the same Bonami input as (2), without assuming `F>=1`.

Now fix any distinct positive primitive tuple, `n>=2`, and set

    alpha=1/(n+1),  0<a<alpha,  L=1/2-a,
    h_a(x)=(||x||-a)_+,   P_a(t)=product_i h_a(v_i t),
    I(a)=integral P_a,
    Q_a(t)=1_{all ||v_i t||>a}
             sum_i product_{j!=i}(||v_j t||-a),
    H(a)=integral Q_a=-I'(a).

Since `0<=P_a<=L^n`, (5) gives

    sum_{E_2(D')} |P_a_hat(ell)|^2
      <= C I(a)^2 log^2(e L^n/I(a)).                           (6)

This retains every original label inside each coefficient. Indeed put
`q_0=L^2` and `q_r=(sin(pi r L)/(pi r))^2` for nonzero integer `r`. The
absolutely convergent tent series has coefficient `(-1)^r q_r`, whence

    P_a_hat(ell) = sum_{r in Z^n : v dot r=ell}
                    (-1)^(sum_i r_i) product_i q_{r_i}.       (7)

Every support and every shifted integer relation in (7) remains included.
However, (6) controls selected nonzero coefficients, not the ratio `H/I`.
Applying (5) separately to `Q_a<=n L^(n-1)` only gives another homogeneous
bound with mean `H`. Neither supplies the unproved contract

    (alpha-a) H(a) <= (n+1) I(a)                              (E)

or a sign for its defect. There is no supplied positive Fejer signal for
`P_a`, nor a comparison as the threshold `a` changes. To see the logical
limitation of positivity and phase-level bounds alone, take the abstract
constant function `F_a(t)=(b-a)^(n+1)` for `0<a<b<alpha`. Every nonzero
phase coefficient vanishes, but its analogous defect equals
`(n+1)(b-a)^n(b-alpha)<0`. This is not a speed-tent family or a counterexample
to (E); it isolates the missing use of that family's integer compatibility.

## Why two natural identifications would change the contract

Independent phase shifts of the tents themselves produce a different family,

    I_theta(a)=integral product_i h_a(v_i t+theta_i) dt
      = sum_{r : v dot r=0} (-1)^(sum_i r_i)
            product_i q_{r_i} e(r dot theta).

The actual common-start problem is `theta=0`. Independent phase averaging
kills every nonzero relation, giving `E I_theta=L^(2n)` and, by dominated
differentiation, `E H_theta=2n L^(2n-1)`. In particular its averaged defect is

    E[(n+1)I_theta-(alpha-a)H_theta]
      = L^(2n-1) [(n-1)^2/(2(n+1)) + (n-1)a] > 0.             (8)

A positive average does not imply the desired inequality at `theta=0`.
Phases `theta_i=v_i tau` for one `tau` preserve the original orbit, but
then `I_theta=I_0` by time translation, so they provide no new averaging
gain. This is distinct from the source's valid use of auxiliary densities.

Likewise, inserting every speed into `R_theta` without dissociation changes
the calculation: `integral R_theta` contains the nonzero signed zero
relations and can depend on `theta`; signed sums and support layers can
collide. The nonnegative quantity `integral (Phi-1)R_theta` still has mean
`epsilon`, but its nonzero phase coefficient is now

    2^{-s(sigma)} [Phi_hat(-sum_i sigma_i v_i)
                     - 1_{sum_i sigma_i v_i=0}].

Normalizing restores unit mass and also preserves the pointwise phase
average. Indeed let `B(theta)=integral R_theta` and `W_theta=R_theta/B(theta)`.
Every speed is a positive integer, so each factor of `R_theta` vanishes at
only finitely many times; their union is finite. Thus `B(theta)>0`. For
every `tau in T`, time translation gives

    B(theta+v tau)=B(theta),
    W_{theta+v tau}(t)=W_theta(t+tau).

Haar invariance of the phase average makes `E_theta W_theta(t)` constant in
`t`. Its time integral is one by Tonelli and `integral W_theta=1`, so
`E_theta W_theta(t)=1` for every `t`. Consequently the normalized variable
`integral (Phi-1)W_theta` still lies in `[0,n-1]` and has mean `epsilon`.
The simple coefficient formula (1) is not retained by this division;
its replacement weights and the progression/layer bookkeeping require new
work. No sharp Fourier signal follows here merely from preserved averaging.

## First unresolved sharp implication and disposition

The paper's moving count is exactly our `n=N-1`. Canonical LRC needs excess
`(n-1)/[2n(n+1)]`, or `epsilon>=(n-1)/(n+1)`, of order one. The present
uniform lower bound only supplies `epsilon>=n^(-5/8-o(1))`. The paper's
Section 3 explicitly notes that even an ideal large-dimension treatment
giving excess `k/n^(2+o(1))`, paired with its unchanged small-dimension
input, would balance at excess `n^(-3/2+o(1))`. This is a limitation of that
combination of inputs, not an impossibility theorem for all Riesz methods.
Also, for `n>9` the assumption `delta<=0.9/n` omits the unresolved interval
`0.9/n<delta<1/(n+1)`. Improving only the error exponents is insufficient.

At a hypothetical maximum `delta<alpha`, a sharp cover contradiction would
require a nonnegative density of mass one with `integral Phi_delta W<1`.
Within (4), this requires its negative signal to dominate `epsilon` and
every higher contribution uniformly across all additive dimensions and
the full subcritical range. The supplied guaranteed signal `rho k/(Cn)`
is vanishing with the chosen `rho`; none of the audited estimates provides
that sharp separation. Its mere existence is equivalent to finding an
uncovered region for the cover detector and is not an additional premise.

Finally, the source uses `Phi>=1` at the actual maximum. Contract (E) asks
for every `a<alpha`, including `a<delta`, where the corresponding bad sets
do not cover. Even a strengthened cover-only contradiction would not by
itself establish this stronger derivative inequality. `Phi` and the
nonlinear slack product cannot be identified. Formula (6) is the surviving
transfer; a uniform bound on the actual defect's mean is the first missing
implication for (E). No admissible falsifier or proof of (E) was obtained.

## Checks

Independent reviewer `/root/uniform_strategy_after_fold` found one error in
the initial frozen manuscript, SHA-256
`b1830a7afa75b9283d2f45344ed29cbbe2512033d60f93fa34580789acf068d1`:
its last normalization sentence incorrectly denied preservation of the
pointwise phase average. The proof above corrects that claim. The missing
sharp coefficient control and the separate derivative contract (E) remain
unresolved; this correction does not constitute their proof.

Read current configuration, workflow, policy and focused active task after
startup and compaction. State was `research/in_progress`, with the explicit
2026-09-05 goal-start authorization and this owned research task recorded.
`python3 -B scripts/validate_workflow.py` exited zero:
`workflow structural validation passed; it cannot certify mathematical validity.`
Complete input hashes were checked with `sha256sum`; source and derivations
were read and checked by hand. No mathematical program, numerical search,
build, cache operation, Git operation, shared-state write, additional agent,
or browser model was used. Earlier owned reviews remain frozen.
