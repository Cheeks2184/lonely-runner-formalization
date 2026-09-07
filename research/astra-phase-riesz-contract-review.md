# Independent review of the phase Riesz source contract

Task `/root/phase_riesz_contract_review`; requested `gpt-6-astra/xhigh`;
observed model, effort, elapsed time and usage: `null`. Assignment checkpoint:
`92d567677620fec37008cff35a70092339a87fd3`. Only this review is owned.

**Accept the corrected manuscript at source-contract scope.** The algebra
and its stated limitations pass the review below. One false sentence about
normalized phase averages in the initial manuscript was corrected and the
replacement proof was independently checked. Acceptance is confined to the
audited derivations conditional on the named earlier inputs. It is neither an
independent proof of those inputs nor a proof
of canonical LRC or the proposed slack-energy inequality (E).

## Evidence boundary

The complete author manuscript and primary TeX were read, including the source's
proofs of its phase estimate and all-support error bound. Primary source:
Bedert--Hu, *Phase-randomised Riesz products and a further improvement towards
the lonely runner conjecture*, [immutable main.tex](https://github.com/hxypqr/phase_riesz_products_lonely_runner/blob/d53fa46aedf01779481fc5f17726bb0ab6770ac4/main.tex).
Publication status, author-link provenance and the original earlier papers
cited there were not independently audited.

| Input | SHA-256 |
| --- | --- |
| Initial author `research/astra-phase-riesz-global-contract.md` | `b1830a7afa75b9283d2f45344ed29cbbe2512033d60f93fa34580789acf068d1` |
| Corrected author `research/astra-phase-riesz-global-contract.md` | `66c83f09a66f169ef9e212d5e5d4ca32acc2fa3732c94def184d4015061ef848` |
| `/tmp/astra-bedert-hu-d53fa46.tex` (36,745 bytes) | `b50d17e25c4e8c4841e7350463b3f08a0ce5fd1b9ecec0d9cc97cd9924761079` |
| `research/astra-uniform-strategy-after-fold.md` | `e569596af4ebab9f9d5e1c796d8da435bc433c1c238bc10f9901e644f9f49871` |
| `research/astra-slack-energy-review.md` | `1c526b214e7772088555642447d5fa2f93030f40195fd4aaca7a79bb1f6bd573` |

## Probability, entropy and all supports

Let `n` be the number of distinct positive integer speeds, `delta=ML(V)` the
actual maximum, and `Phi=sum_i 1_{||v_i t||<=delta}`. The closed detector gives
`1<=Phi<=n` everywhere and `integral Phi=2n delta=1+epsilon`. The source's
assumption `delta<=0.9/n` is needed by its stated Fejer input and Fourier scale.

Write `k` for the maximum size of a 2-dissociated subset `D` of the speeds;
the paper calls this dimension `d`. Its earlier Bedert inputs are: the excess
bound `1/[C n k(log n)^C]-C n^(-100)`; a dilation `D'=j_0 D`, `1<=j_0<100n`,
with `sum_{m in D'} Phi_hat(m)>=k/(Cn)`; and the progression bound
`|E_j(D') intersect P|<=(C log(2+|P|))^j`. These are inputs as stated in the
audited source, not independently established here. The negligible subtraction
in the first bound can be absorbed for sufficiently large `n`, using `k<=n`.

For every auxiliary phase, `R_theta=product_{m in D'}(1+cos(2pi(mt+theta_m)))`
is nonnegative with integral one. Its full expansion has coefficient `2^(-s)`
at signed phase vector `sigma` of support `s`. Dissociation excludes nonzero
signed zero sums; 2-dissociation also makes the signed representation injective
and the physical support layers disjoint. These are separate uses. Phase
averaging gives `E R_theta(t)=1`. Consequently

    Y(theta)=integral Phi R_theta-1,
    0<=Y<=n-1,  E Y=epsilon,
    Y_hat(sigma)=2^(-s) Phi_hat(-sum_m sigma_m m), sigma!=0.

The precise Bonami input is `||g||_q<=Cq||g||_2`, `q>=2`, when `g` is supported
on signed phase vectors of support two. Accepting that input, the stated
level inequality follows by duality: for `0<=f<=1`, `eta=integral f>0`, take
`q=max(2,ceil(log(e/eta)))` and conjugate `p`. Then
`||f||_p<=eta^(1-1/q)<=e eta`; Holder gives
`sum_{s=2}|f_hat|^2<=C eta^2 log^2(e/eta)`. The zero-mean case is direct.
For `f=Y/n`, the factor `1/(4n)` in each support-two coefficient and signed
uniqueness give the author's bound (2), with no multiplicity omission.

For `J=n^3`, the union of the `n` progressions `v_i[-J,J]` meets `E_2` in at
most `Cn(log n)^2` points. Cauchy--Schwarz and the complementary dyadic tail
give (3). The final test `product(1-rho cos(2pi mt))` retains every signed
support with coefficient `(-rho/2)^j`. In particular the two signs in the
first layer give exactly `-rho sum_{D'} Phi_hat(m)`, with no missing factor
two. All levels `j>=ceil(10 log n)` are bounded using disjointness, at most
`3^k` frequencies and the harmonic-sum estimate. Every remaining `j>=3` is
bounded by the progression input and a geometric sum. Thus the source's
master inequality (4) includes all supports; only their signs are discarded
when estimating the higher-level error.

For completeness, put `rho=kappa n^(-1/4)(log n)^(-5)`, `sqrt(n)<=k<=n`,
and `G=rho k/n`. Assuming `epsilon<=c_0 G`, monotonicity of
`x log(en/x)` for `x<n` bounds the first error divided by `G` by
`C c_0 kappa^2(log n)^(-8)`. The next two ratios are bounded by
`C kappa n^(-7/4)(log n)^(-3)` and `C kappa^2/log n`; the last is
superpolynomially small. Choosing `c_0` small and `n` sufficiently large
therefore yields the stated contradiction. Conversion from `epsilon` to
excess divides by `2n`, giving `k/[C n^(9/4)(log n)^5]`. Balancing with the
small-dimension input gives excess `n^(-13/8-o(1))`. This is an asymptotic
scope check; it does not produce explicit constants for every finite count.

## Transfer to the actual tent product

For any measurable `0<=F<=M`, `M>0`, put `A=integral F`. The same probability
density gives `0<=Z_F=integral F R_theta<=M`, `E Z_F=A`, and support-two
coefficients `F_hat(-sum sigma_m m)/4`. Applying the preceding inequality to
`Z_F/M` proves (5), including the zero-mean case. This generalization uses
neither a covering assumption nor the Fejer signal.

For the distinct positive primitive tuple, `n>=2`, `alpha=1/(n+1)` and
`0<a<alpha`, put `P_a=product_i (||v_i t||-a)_+`, `L=1/2-a`. Then `P_a<=L^n` and
the absolutely summable tent coefficients `(-1)^r q_r`, with `q_0=L^2` and
`q_r=(sin(pi r L)/(pi r))^2` for `r!=0`. Multiplication and integration give
the full shifted-relation formula (7); no original labels or support blocks
are removed by selecting the output frequencies in (6). Dominated
differentiation gives `H=-I'=integral Q_a`, with `0<=Q_a<=nL^(n-1)`.
Applying (5) separately to this nonnegative derivative density controls its
selected Fourier coefficients in terms of `H`; it supplies no comparison of
`H` and `I`.

The author's abstract constant family `F_a=(b-a)^(n+1)`, `0<a<b<alpha`,
does obey all such homogeneous coefficient bounds and has analogous defect
`(n+1)(b-a)^n(b-alpha)<0`. This correctly falsifies an inference from those
bounds and positivity alone. It is explicitly outside the speed-tent family
and does not refute (E).

Independent shifts of the tents give `E I_theta=L^(2n)` and
`E H_theta=2nL^(2n-1)`. The averaged defect in (8) has the stated positive
factor `[(n-1)^2/(2(n+1))+(n-1)a]` for `n>=2`. Haar averaging removes
nonzero relations, so this has no implication for their sum at `theta=0`.
Orbit-compatible phases `theta_i=v_i tau` preserve `I_0` exactly by time
translation. This is correctly distinguished from varying the auxiliary
probability density on the original common time.

## Required normalization correction

The initial manuscript's last normalization sentence incorrectly denied
preservation of the pointwise phase average. For any positive integer speed
tuple, with no dissociation assumption, let

    R_theta(t)=product_i (1+cos(2pi(v_i t+theta_i))),
    B(theta)=integral R_theta,  W_theta(t)=R_theta(t)/B(theta).

Each factor has only finitely many zeros in one time period. Hence their
product is positive off a finite set and `B(theta)>0` for every phase.
Translation gives `R_{theta+v tau}(t)=R_theta(t+tau)` and
`B(theta+v tau)=B(theta)`. Thus `E_theta W_theta(t)` is independent of `t`.
Its integral is one because each `W_theta` has mass one; consequently
`E_theta W_theta(t)=1` pointwise. In particular
`integral(Phi-1)W_theta` retains both `0<=Y_tilde<=n-1` and `E Y_tilde=epsilon`.

The unnormalized coefficient correction displayed in the author manuscript,
including subtraction at nonzero signed zero relations, is sound. Dividing
by the phase-dependent mass changes that simple coefficient identification.
The entropy argument can still be applied to the normalized function, but
transporting its coefficients to the required physical signal needs new
work; signed-layer injectivity and the cited progression bounds are also
not restored by normalization. The false average claim was therefore a
local error, not a reason to dismiss normalized dependent densities.

## Exact remaining scope

Canonical margin `alpha=1/(n+1)` requires excess
`(n-1)/[2n(n+1)]`, equivalently `epsilon>=(n-1)/(n+1)`. The audited estimates
instead guarantee only `epsilon>=n^(-5/8-o(1))`. The source's Section 3
comparison with an ideal large-dimension excess `k/n^(2+o(1))` and its
unchanged small-dimension input still yields only `n^(-3/2+o(1))` excess.
This constrains that combination of inputs, not every future Riesz argument.
For `n>9`, the further interval `0.9/n<delta<1/(n+1)` is absent from the
source hypothesis and would need its own uniform treatment.

A sharp contradiction at a hypothetical maximum would require a normalized
nonnegative test with `integral Phi_delta W<1`. Such a test exists exactly
when this closed detector has an uncovered open region; existence alone
does not constitute additional supply. The present master inequality does
not force it: its guaranteed signal `rho k/(Cn)` tends to zero even at
`k=n`. No uniform sharp separation from the cover excess is established.

For (E), the first unresolved implication is a bound on the actual defect
`(n+1)I-(alpha-a)H` at common starting phase zero for every `0<a<alpha`.
Those thresholds include `a<ML(V)`, where the bad sets do not cover. A
cover-only argument, the generic coefficient bound, and the positive
independent-phase average do not supply this stronger derivative statement.
No admissible counterexample to (E), full LRC proof or impossibility result
was obtained or accepted by this review.

## Checks and ownership

Read `.codex/config.toml`, `docs/project-workflow.md`, the policy and focused
state at startup and after compaction. State was `research/in_progress`,
with explicit start authorization and this review recorded. Required
`python3 -B scripts/validate_workflow.py` exited zero, reporting
`workflow structural validation passed; it cannot certify mathematical validity.`
Source hashes were checked with `sha256sum`; all derivations above were
checked by hand. No mathematical program, numerical sweep, Lean check,
build, cache operation, Git operation, shared-state write, additional agent
or browser model was used. All other manuscript files remain author-owned.
