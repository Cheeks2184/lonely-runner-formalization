# Independent review of normalized phase densities

Task `/root/normalized_phase_review`; requested `gpt-6-astra/xhigh`;
observed model, effort, elapsed time and usage: `null`. Assignment checkpoint:
`92d567677620fec37008cff35a70092339a87fd3`. Only this review is owned.

**Accept the frozen manuscript without mathematical corrections.** Its
normalization, coefficient identities, first-order upper bound and complete
variance formula have direct hand proofs. Its compactness obstruction and
explicit example refute the stated all-subthreshold certificate claim. They
do not supply a hypothetical minimal LRC failure, disprove LRC, or establish
the slack-energy inequality (E). This is manuscript review, not kernel proof.

## Hash-bound scope

The author manuscript was read completely. Its corrected source contract and
the preceding independent review were already read completely in the preceding
task, and their unchanged hashes were verified here. No external theorem is
needed for the new derivations under review; no external paper was newly
audited in this task.

| Input | SHA-256 |
| --- | --- |
| `research/astra-normalized-phase-signal.md` | `55f23f7eaed77263ef713783ef4d3083fd444f6b1c4f3ea398974afd81ef3a4e` |
| `research/astra-phase-riesz-global-contract.md` | `66c83f09a66f169ef9e212d5e5d4ca32acc2fa3732c94def184d4015061ef848` |
| `research/astra-phase-riesz-contract-review.md` | `e1fc63cb735696edfe2340788e4fb9b8958f708af77adbba790fc6ba23d99a97` |

## Normalization and dependent coefficients

The hypotheses are `n>=2` and positive integer speeds, with Haar probability
measure on both tori. Distinctness and primitivity are unnecessary for the
identities; all examples asserted to be admissible have both properties.
The polynomial identity `R_theta=2^(-n)|P_theta(e(t))|^2` is correct. Positivity
of the speeds makes the constant and top-degree coefficients distinct and of
modulus one, giving `B>=2^(1-n)` by Parseval and `W<=2^(2n-1)`. Thus division
and every phase integral used in the manuscript are well-defined. The product
has only finitely many time zeros for each phase.

Translation gives `B(theta+v tau)=B(theta)` and `W_theta(t)=w(theta+v t)`.
Its orbit average is one. Averaging over phases is consequently also one
pointwise in time. The change of variables `eta=theta+v t` contributes the
factor `e(t v dot sigma)` under the stated Fourier convention, so

    Z_F_hat(sigma)=w_hat(sigma) F_hat(-v dot sigma).

Taking phase coefficients of the unit orbit average proves `w_hat(0)=1` and
vanishing at every nonzero zero-relation. The parity identity follows from
`R_{-theta}(0)=R_theta(0)` and time reversal for `B`, so the coefficients are
real and even. For a cover, `Y=integral(Phi_delta-1)W_theta` lies in `[0,n-1]`
and has mean `epsilon=2n delta-1`. No cover hypothesis is used before this step.

For `(1,2,3)`, the only nonzero signed zero-relations are `p=(1,1,-1)` and
`-p`; their numerator coefficients are `1/8`. Hence
`B=1+(1/4)cos(2pi p dot theta)`. Multiplying the proposed inverse series by
this polynomial verifies its coefficients
`h_j=(4/sqrt(15))(-q)^|j|`, `q=4-sqrt(15)`; the series converges absolutely.
For each `e_i`, the convolution is `h_0/2+h_1/4=1-2/sqrt(15)`.
For `e_1-e_2`, only `h_0/4=1/sqrt(15)` remains. For `2e_1+k p`, `k>=0`,
the only allowed numerator index is `(1,-1,1)`, giving
`h_(k+1)/8=(-q)^(k+1)/(2sqrt(15))`. This independently verifies all of (4),
including the negative coefficient at `2e_1` and infinitely many nonzero
harmonics with the same time frequency `2`.

Appending odd speeds larger than the sum of all predecessors introduces no
new signed zero-relation: the largest participating appended speed cannot
be cancelled. The denominator is unchanged, and taking zero appended phase
indices preserves the displayed coefficients. The original three speeds have
maximum `1/4`: on the author's three subintervals of `[0,1/2]`, speeds `1`,
`3` and `2` respectively bound the minimum by `1/4`; reflection completes
the period. Every appended odd speed has norm `1/4` at `t=1/4`. This proves
the asserted extension to every moving count at least three and also verifies
that these examples satisfy the canonical margin rather than strict failure.

## First-order bound and full aggregate variance

The first-order argument supplied by the orchestrator is sound. Deterministic
offsets align the individual Fourier coefficients with their absolute values.
Covariance then identifies their sum with `E_theta integral W_theta S_theta`,
bounded above by `E_theta sup_t S_theta`. With `K=8 sum_i v_i`, the Lipschitz
constant is at most `2pi sum_i v_i<K`; the mesh loses less than one. At every
fixed mesh point the phases remain independent and uniform. The exponential
moment is `sum_r (lambda^2/4)^r/(r!)^2<=exp(lambda^2/4)`. Jensen applied to
log-sum-exp therefore gives

    sum_i |w_hat(e_i)| <= 1+log(K)/lambda+n lambda/4
                      = 1+sqrt(n log K)

at `lambda=2sqrt(log(K)/n)`. For `(1,...,n)`, its ratio to `n` tends to zero,
refuting a positive uniform lower bound on the average absolute first weight.
The proof requires only covariance, positivity and unit mass, so its stated
application to normalized finite powers is valid. It gives no bound against
a signal using all harmonics.

Division by the time-independent `B(theta)` preserves the finite time
frequency set `S(v)`. The time coefficient `c_m/B` has phase coefficient
`w_hat(sigma)` when `v dot sigma=m`, and zero otherwise. Parseval gives

    A_m=E |c_m/B|^2=sum_{v dot sigma=m}|w_hat(sigma)|^2,
    Var(Z_F)=sum_{m!=0} A_m |F_hat(m)|^2

for real bounded `F`, with the minus sign in the coefficient formula removed
by Fourier symmetry. Zero-relations contribute nothing beyond the constant.
For `m in S(v)`, `c_m` is a nonzero polynomial of distinct phase characters
with positive coefficients, so `A_m>0`. For `m!=0`, strict triangle inequality
gives `|integral W_theta e(-mt)|<1`: a nonconstant character cannot have
constant phase on a density positive almost everywhere. This proves the
strict upper bound `A_m<1`; also `A_0=1` and all other gains vanish.

For a cover, `Y^2<=(n-1)Y` gives `Var(Y)<=epsilon(n-1-epsilon)`, exactly (7).
Every phase harmonic and time frequency is included. Neither positivity of
these gains nor the first-order upper bound supplies the missing lower bound
on this particular weighted signal.

## Compactness obstruction and its exact falsification scope

For every fixed positive integer tuple with `n>=2`, the maximum `mu` is
positive because the individual zero sets have finite union. At `mu`, the
detector is at least one everywhere and equals `n` on an interval about zero.
Every density is positive almost everywhere, so
`integral(Phi_mu-1)W_theta>0` for every phase. This integral is continuous in
phase; compactness gives the asserted strictly positive minimum `gamma_v`.
The condition `n>=2` is essential to this strictness and is explicitly present.

Integer circle maps preserve Haar measure. Therefore for `0<=delta<mu`,
`integral(Phi_mu-Phi_delta)=2n(mu-delta)`. The common density bound `M_v`
gives (8) uniformly in phase. A maximizing time has an open neighborhood
uncovered at every such lower threshold. The same strict uniform estimate
holds for every probability mixture of the densities. This proves the stated
failure to detect uncovered times just below the optimum of every fixed tuple.

For `(1,...,n)`, the shortest cyclic gap among `0,t,...,nt` yields an index
`1<=i<=n` with `||it||<=1/(n+1)`; coincident points give norm zero and cause
no exception. The time `t=1/(n+1)` attains equality. Hence `mu=alpha`, and the
obstruction does falsify the universal claim for all `0<delta<alpha`, at
arbitrarily large counts. It does not require, or exhibit, `mu<alpha`.

For the explicit pair `(1,2)`, there is no nonzero signed zero-relation, so
`B=1` and `W<=4`. At `mu=1/3`, the coefficients are indeed `c`, `c/2`, `0`
at frequencies `1`, `2`, `3`, where `c=sqrt(3)/(2pi)`. Expanding the product
gives the displayed integral in (9). Minimizing in `y` yields
`cos x-|cos(x/2)|`; setting `u=|cos(x/2)|` reduces this to `2u^2-u-1`, whose
minimum on `[0,1]` is `-9/8` at `u=1/4`. Thus

    min_theta integral Phi_mu W_theta=4/3-9sqrt(3)/(16pi),
    gamma=1/3-9sqrt(3)/(16pi)>0.

The elementary inequalities `27sqrt(3)<48<16pi` verify the strict sign.
Here `2nM=16`, so the exact interval `1/3-gamma/16<delta<1/3` in the manuscript
is correct. These are admissible tuples with suboptimal chosen thresholds,
not hypothetical actual minimal failures. The compactness argument concerns
this fixed unit-amplitude family and its mixtures; it supplies no uniform
obstruction as powers or concentration vary without bound.

## First unresolved implication and checks

No lower estimate established here forces the actual aggregate signal at a
hypothetical maximum `mu<1/(n+1)` to contradict its covering bound. That step
would have to use arithmetic or minimal-failure hypotheses absent from the
falsified all-subthreshold assertion. No proof or admissible counterexample
to LRC or (E) follows. This bounded review accepts the stated identities and
obstruction, with that precise unresolved implication preserved.

Read current configuration, workflow, policy and focused state; the gate was
`research/in_progress`, with explicit 2026-09-05 start authorization and this
owned review recorded. Their hashes matched the already-read setup sources.
`python3 -B scripts/validate_workflow.py` exited zero:
`workflow structural validation passed; it cannot certify mathematical validity.`
Hashes were checked with `sha256sum`; mathematics was checked by hand. No
mathematical program, numerical sweep, build, cache operation, Git operation,
shared-state edit, external model or additional agent was used. Other files
were preserved.
