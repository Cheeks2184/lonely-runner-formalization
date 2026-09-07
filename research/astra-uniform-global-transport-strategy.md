# A global cover forces a bounded relation on at most five labels

Task `/root/uniform_global_transport_strategy`; assigned checkpoint
`3c71f4dc668896ff37169570f81bb9c87c899627`. Requested route:
`gpt-6-astra/xhigh`; observed model, effort, elapsed time and usage: null.
Only this manuscript is owned. These hand deductions await independent
review; no literature novelty, kernel theorem or unrestricted LRC result
is claimed.

The selected new structural contract is a global good-time measure theorem.
For n>=6 positive integer speeds, absence of a relation on at most five
labels with coefficients bounded by `90*n^5-2` is sufficient for more
than 1/30 of the circle to be native-good. Consequently a hypothetical
minimal failure has a primitive relation of that bounded kind. The proof
uses the entire bad-set cover and retains multiply-bad regions through an
exact Bonferroni identity. It does not transport failure along the relation.

## 1. What the preceding transport work supplies

Retain a hypothetical strict failure V of n distinct positive integer
speeds, least by moving count and then by sum among ALL such failures at
that count. It is primitive. The established six-total-runner result
allows n>=6; no successive-count program is proposed. Put

    N=n+1, alpha=1/N,
    mu=max_(t in T) min_(v in V)||vt||<alpha, T=R/Z.

The same actual global maximum and the full original labels remain fixed.
The accepted private-repair review shows that repairing every single-bad
region leaves multiply-bad witness domains uncontrolled. The accepted
positive escape-cycle and mixed-sink papers give no common repair across
all those domains. Their local controls do not satisfy full trapping.

The same-parity pair paper was accepted during this assignment. Its
two-core inclusion concerns every component of the new good set, including
two-old-bad points. Its guaranteed-beta comparison is uniformly too weak;
this does not exclude a stronger use of its actual new maximum or exact
component positions. No such stronger transport ingredient is assumed here.

The energy hold is also preserved: complete signed support contributions
have no individually usable positivity budget, and their unproved full
compensation is not a supplied theorem. The normalized phase-Riesz results
do not provide a sharp first-level signal. This task tests ONE different
global mechanism after those dispositions, rather than relaunching them.

## 2. Exact selected contract

For n>=6 define the positive integers

    A_n = n * sum_(j=0)^4 binom(n-1,j),
    M_n = 45*A_n,
    D_n = 2*(M_n-1) = 90*A_n-2 <= 90*n^5-2.                 (1)

To check the last estimate, subsets of {1,...,n-1} of size at most four
inject into {0,...,n-1}^4 by their increasing lists padded with initial
zeros. Thus their number is at most n^4, and A_n<=n^5.

**Global measure theorem.** Let v_1,...,v_n be positive integers. Assume
there is no nonzero integer vector r with

    sum_i r_i*v_i=0, |support(r)|<=5, |r_i|<=D_n for every i. (2)

Then, for normalized Haar measure on T,

    measure{t: ||v_i*t||>=1/(n+1) for every i} > 1/30.      (3)

The same measure bound holds with all inequalities strict. In particular
the global maximum is strictly greater than 1/(n+1).

The theorem itself does not require distinctness, gcd normalization,
minimum count or minimum sum. Repeated positive speeds already violate
(2). The minimal-failure application uses the stronger original hypotheses
only through its whole-time bad-set cover. This distinction identifies
exactly what new information has, and has not, been extracted.

**Failure corollary.** A hypothetical minimal failure has a vector r with

    2<=|support(r)|<=5, gcd_(i)(|r_i|)=1,
    0<max_i |r_i|<=D_n, sum_i r_i*v_i=0.                    (4)

At least one entry is positive and at least one negative. The bound depends
on n, not on the largest original speed. For fixed n it restricts failure
to finitely many sparse relation patterns; their solution sets remain
unbounded integer families. It is not a finite height theorem or an
instruction to enumerate those patterns.

## 3. Entire intersection moments and the independent benchmark

Write `g(x)=1_{||x||<alpha}`, p=integral g=2/N, and

    b_i(t)=g(v_i*t), B(t)=sum_i b_i(t),
    P_5(x_1,...,x_n)=sum_(J subset {1,...,n}, |J|<=5)
                          (-1)^|J| product_(i in J) x_i.

An empty product is one; binomial coefficients beyond range are zero.
For the actual indicator vector, Pascal's identity gives

    P_5(b(t))=1                       if B(t)=0,
    P_5(b(t))=-binom(B(t)-1,5)<=0     if B(t)>=1.             (5)

Therefore P_5(b) is pointwise at most the indicator of the common closed
good set. Under strict failure, B(t)>=1 at EVERY time and the integral
of P_5(b) is nonpositive. No region with multiple old bad labels is omitted: all
multiplicities are included in (5), including the negative values when
B>=6. This is an exact one-sided truncation, not an assumed sign for
uncomputed intersection contributions.

If all moments through order five factor with mean p, the integral of
P_5 is the benchmark

    S_5 = sum_(j=0)^5 (-1)^j binom(n,j)*(2/N)^j.

Direct expansion of the five falling-factorial products gives

    S_5 = 1/15 + 4/(3N) - 10/N^2 + 104/(3N^3)
                   - 856/(15N^4) + 32/N^5 > 1/15.           (6)

For the strict sign when N>=7, group the nonconstant terms as

    [4N^2-30N+104-856/(5N)]/(3N^3) + 32/N^5.

Since 856/(5N)<30, the bracket is greater than
`4N^2-30N+74=4(N-6)^2+18(N-6)+38>0`.
This verifies the polynomial and its sign without asymptotic estimates
or a finite numerical screen.

## 4. A positive finite kernel with an explicit approximation bound

Set M=M_n and use e(x)=exp(2*pi*i*x). Define the Fejer polynomial and
its normalized square by

    K_M(x)=(1/M)*|sum_(j=0)^(M-1) e(j*x)|^2,
    c_M=integral K_M^2=(2*M^2+1)/(3*M),
    J_M(x)=K_M(x)^2/c_M.                                    (7)

All operations are finite Fourier algebra. The coefficients of K_M are
`a_r=1-|r|/M` for |r|<M, and zero otherwise. Its mean is one. Orthogonality
therefore gives

    c_M=1+(2/M^2)*sum_(j=1)^(M-1) j^2
       =(2*M^2+1)/(3*M)>=2*M/3.

Consequently J_M is nonnegative, has integral one and has Fourier degree
exactly 2(M-1)=D_n. Its coefficients are the finite convolution
`(1/c_M)*sum_s a_s*a_(r-s)`; no infinite Fourier convergence is needed.

For r=||x||>0, the finite geometric progression and the sine chord bound
`sin(pi*r)>=2r` give `K_M(x)<=1/(4*M*r^2)`. The trivial bound is
K_M<=M. Thus

    J_M(x)<=min(3*M/2, 3/(32*M^3*r^4)).                      (8)

At r=0 use the first bound. Split the first moment at delta=1/(2M).
On the two sides of zero the near contribution is at most

    2*integral_0^delta r*(3*M/2) dr = 3/(8M).

The tail is at most

    2*integral_delta^(1/2) r*3/(32*M^3*r^4) dr
       <=3/(32*M^3*delta^2)=3/(8M).

Hence `integral ||x||*J_M(x)<=3/(4M)`. The open arc indicator g satisfies

    ||g(.-x)-g||_1 <= 2*||x||.

Indeed a translation along a shortest circular segment can change
membership only in the two endpoint strips, each of length at most ||x||.
This proof includes wraps and all arc endpoints, whose measure is zero.

Let f=J_M*g be circular convolution. Positivity and unit mass give
`0<=f<=1`, integral f=p. The integral triangle inequality and the moment
bound give

    epsilon_1=||f-g||_1<=3/(2M).                             (9)

The function f is a trigonometric polynomial of degree at most D_n,
with coefficients `f_hat(r)=J_hat_M(r)*g_hat(r)` and

    g_hat(0)=p,
    g_hat(r)=sin(2*pi*alpha*r)/(pi*r) for r!=0.

These coefficients follow by integrating over (-alpha,alpha); open or
closed endpoints give the same value. No kernel is evaluated or expanded
by a mathematical program in this task.

## 5. Moment factorization, the error budget, and relation detection

For |J|<=5, expand the FINITE product of f(v_i*t), i in J, and integrate.
An exponential contributes only when `sum_(i in J) r_i*v_i=0`.
Under (2) the only such frequency choice within |r_i|<=D_n is all zero.
Therefore

    integral product_(i in J) f(v_i*t)=p^|J|.                (10)

All phases come from the SAME original time. Auxiliary independent runner
phases or arbitrary shifted LRC are not introduced. The exact absence of
relations is what justifies factorization.

For any J, telescoping products of numbers in [0,1] bounds their difference
by the sum of the individual differences. Integer multiplication of time
preserves normalized Haar measure, so

    |integral product_(i in J) f(v_i*t)
         -integral product_(i in J) b_i(t)| <= |J|*epsilon_1.

Every original label participates. Summing over all subsets through order
five gives the exact counting factor

    sum_(j=1)^5 j*binom(n,j)
       =n*sum_(j=0)^4 binom(n-1,j)=A_n.

Equations (9) and M=45*A_n consequently imply

    |integral P_5(f(v_1*t),...,f(v_n*t))-integral P_5(b(t))|
        <=A_n*3/(2M)=1/30.                                 (11)

Under (2), the first integral is S_5 by (10). Combining (5), (6) and
(11) proves

    measure{all original norms>=alpha}
        >=integral P_5(b)>=S_5-1/30>1/30,

which is (3). For each positive integer v_i, the equation ||v_i*t||=alpha
has finitely many times modulo one. Removing their finite union proves
the same strict-good measure bound and in particular mu>alpha.

Contraposition under the whole-time failure cover gives a nonzero bounded
relation. Its support cannot be one because all speeds are positive.
Its signs cannot all agree for the same reason. Divide all its entries
by their positive gcd to obtain (4), preserving the support and coefficient
bound. No original label is deleted or replaced in this argument.

There is also an exact global signed certificate, stronger than bare
existence of a relation. Without assuming (2), define

    Gamma_v = sum_(1<=|J|<=5) (-1)^|J|
                sum_(r in Z^J, |r_i|<=D_n, r!=0,
                     sum_(i in J) r_i*v_i=0)
                         product_(i in J) f_hat(r_i).

Zeros among entries of r are allowed; occurrences in different J are
deliberately included as prescribed by P_5. Finite Fourier expansion gives
`integral P_5(f(v*t))=S_5+Gamma_v`. The sum is real by conjugate symmetry.
Under full failure, (5) and (11) give

    Gamma_v <= 1/30-S_5 < -1/30.                             (12)

No separate relation support or individual term is assigned a positive
sign. Dividing a relation to make it primitive proves (4), but is not
asserted to preserve that term's Fourier coefficient or signed weight.

The no-relation hypothesis is nonvacuous at unbounded counts. With
B=D_n+1, take speeds 1,B,...,B^(n-1). In any nonzero relation with
coefficients of magnitude at most D_n=B-1, the largest nonzero term has
magnitude at least B^q, while all earlier terms have total magnitude
at most `(B-1)*sum_(j<q) B^j=B^q-1`. Cancellation is impossible.
Thus (3) applies to this entire family. This is a scope check, not a
successive-count proof program or a novelty claim about that family.

## 6. Comparison with the earlier Bonferroni hold and the remaining contract

The complete earlier Bonferroni audit and its accepted scope were read.
They refute universal fixed-order supply for a PARTICULAR product-weighted
sparse pivot-grid criterion: its weight can concentrate where exactly
h+1 owners are bad. That hold remains valid. Here the measure is unweighted
Haar measure, the threshold is native, and the conclusion (3) is explicitly
conditional on absence of bounded sparse relations. No universal positivity
of P_5, weighted integral, or supportwise energy defect is asserted.
Equation (12) records precisely the aggregate obstruction when the new
arithmetic hypothesis fails. It does not budget that obstruction away.

The selected structural proof contract is (3) together with its
minimal-failure corollary (4), with the exact constants (1). The strategic
recommendation is to DEFER its Lean implementation: the present proof
has not yet supplied a global descent or compensation use for the relation.
Its formalization would require finite Fourier orthogonality, the positive
kernel estimate and the finite Bonferroni identity, but that infrastructure
is not the current mathematical bottleneck. Preserve the reviewed
manuscript and require a concrete transport application before investing
in that implementation. This is a proved conditional measure statement,
not a route declared successful because it lacks a counterexample.

The FIRST UNRESOLVED transport inference is to use one of the forced
relations, together with the complete minimum-count/minimum-sum hypotheses,
to construct an admissible smaller tuple whose failure holds at every
time, or to obtain a common original witness by a different justified
argument. The bounded relation alone provides neither. Invoking the known
theorem on its at-most-five-label support only supplies a witness for that
subtuple; it does not synchronize the other original labels. No relation
pivot, integer phase carry, or multiply-bad region is discarded here.
No new relation-to-descent lemma is supported by the present calculation.

The obvious proposed next inequality, positivity of this complete fifth
functional for all native tuples, is FALSE. Root supplied the following
hand control, checked here. Set

    n=10, V={1,3,5,...,19}, alpha=1/11,
    E={t:||t||<1/(11*19)}, measure(E)=2/209.

All ten speeds are strictly bad on E, so (5) gives
`P_5(b)=-binom(9,5)=-126` there. Everywhere else P_5(b)<=1. Therefore

    integral P_5(b) <= -126*(2/209)+(1-2/209)=-45/209<0.

Yet t=1/2 makes every original norm 1/2, and continuity gives an open
interval of strict native-good times. Thus the obstruction is not limited
to equality-only witnesses. By (11), even the smoothed functional has
integral at most `-45/209+1/30<0` for this tuple. A universal bound on the
complete signed relation total sufficient to make this fixed functional
positive cannot be the next lemma. The control is native-good, not a
minimum-failure counterexample; its role is exactly this new compensation
test, not another refutation of private repair.

One precise further structural diagnostic, before any claimed descent,
is whether the full-failure signature (12) can force a bounded relation
having a coefficient +1 or -1, still with support at most five and bound
D_n. A unit coefficient would remove the division ambiguity when solving
that one phase from the others, but would not synchronize their witnesses.
The current proof gives no such extraction. This is an explicitly unproved
test, not a selected implementation contract or an assertion that it will
work. Neither bare relation detection nor universal fifth-order positivity
currently supplies enough support for a new global transport theorem.

One intrinsic limitation is important: the argument only needs a bad cover
almost everywhere. Native-sharp tuples may meet that hypothesis. For
V={1,...,n}, the shortest-gap argument on 0,t,...,nt gives mu<=1/(n+1),
and t=1/(n+1) attains equality. Every closed native witness then has some
||v*t||=alpha and hence belongs to a finite union of boundary times.
The open bad sets cover almost everywhere, so the same relation detector
and signed bound apply, even though this tuple is LRC-good. Its relation
1+2-3=0 is consistent with (4). Thus neither a relation nor negative
Gamma distinguishes strict failure from a sharp closed witness.

This explains why the new structural result does not settle LRC or revive
the rejected universal positivity shortcuts. It changes the available
global arithmetic information, but count/height minimality must still do
new work after that restriction. The present bounded assessment stops
there; unrestricted LRC remains unresolved.

## 7. Evidence and checks

The global low-order-independence mechanism and its complete moment
argument were developed here. Root independently supplied the matching
fifth-order expansion, an initial positive Fejer error budget, and the
sharper normalized-square kernel and constants used in (7)--(11). All were
checked here by hand. The superseded larger degree bound is not needed.
No external theorem beyond the displayed elementary integration and finite
Fourier identities is invoked, and no literature priority is claimed.

Current config, workflow, policy and focused state were read; the gate was
research/in_progress with explicit start authorization at
`2026-09-05T04:12:25.208107+00:00`. The same owned task was confirmed after
the resource-diagnosis pause. `python3 -B scripts/validate_workflow.py`
exited zero with `workflow structural validation passed; it cannot certify
mathematical validity.` Unknown runtime metadata remains null.

The following bindings are generated from the actual source bytes. Full
owned readback, all bindings, final newline/whitespace and final workflow
validation are checked at handoff; the frozen hash is reported separately.
Only administrative checks were run. No mathematical program, enumeration,
solver, local build, dependency/cache operation, extra agent, browser model,
Git/shared-state/memory edit or other-file change was made.

| Bound input | SHA-256 |
| --- | --- |
| `research/astra-same-parity-pair-descent.md` | `9ccb99d3ef297b5e1e3bb1f0dd6bc20234ff895ebcbe40d362098aaf72903a35` |
| `research/astra-same-parity-pair-descent-review.md` | `4e4d1345ad7ac9cd0a5b027f8ca197d77b394c4ff07fce08487b8ecb6a2a69fb` |
| `research/astra-private-repair-review.md` | `a8aaec8468969723207dc12e9ff2c112a4560c1f51e97f13b43f4e342c849512` |
| `research/astra-positive-candidate-escape-cycles.md` | `d7c8ff0d24f43ce30c272b4eed93686eeaad8b7dfca41449d1f1b22781e7ad49` |
| `research/astra-positive-candidate-escape-cycles-review.md` | `b458336f8e4ce912259d356fcc7971e73400b88838824e2372a5e2163a4f62b7` |
| `research/astra-mixed-candidate-zero-sinks.md` | `c51b493cadda81760e221b8bc747df465d3865e8aa39361e581c3de1672c18eb` |
| `research/astra-mixed-candidate-zero-sinks-review.md` | `4fa7964cdbf91b618cefdf959dda5158274c5872f80b344e168f1309647040a3` |
| `research/astra-slack-energy-global-compensation.md` | `8032d020e4beccc1112b025c8b85f6be6c2ec5cb67cdd763d4ae62a029627cb9` |
| `research/astra-uniform-strategy-after-energy.md` | `ee253b7ade891196bdf213250badac0ddf5992937eba32b625dbc9adb79f506e` |
| `research/astra-phase-riesz-global-contract.md` | `66c83f09a66f169ef9e212d5e5d4ca32acc2fa3732c94def184d4015061ef848` |
| `research/astra-bonferroni-weight-audit.md` | `9116444bc4b55f976a148ecd0431c3032ec4b4d62b7396bd4ed420cc477cfaa0` |
| `research/astra-bonferroni-weight-review.md` | `35a5db5bad8a895743491ac2f84dc45d2d25cc1c18c6b50680144dcf15f7f625` |
| `.codex/config.toml` | `28212a53cf42cdc377df1f7dab040732d657e59d7bb97ee78791256d01d4bb2c` |
| `docs/project-workflow.md` | `2b42a133352b6b53ba2106fc73882733f176e04a0deffbb183b4c16eefd9cd67` |
| `research/workflow-policy.json` | `833c397b61d1ffdb994fb115019f6d60d6c1a62ff85f19cdd2c9f8ac3a979c8b` |
| `scripts/validate_workflow.py` | `250a3ce2a080f5835ac4fd2e4b2803568424c777cda5d421f9fe92efd34d5383` |
