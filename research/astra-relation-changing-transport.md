# The exact defect in relation-changing scalar transport

Task `/root/relation_changing_transport`; assigned source checkpoint
`94a96d13c7877aeb37ef341543830ef253299008`. Requested route:
`gpt-6-astra/xhigh`; observed model, effort, elapsed task time and usage:
null. Only this manuscript is owned. The following hand derivations await
independent review; they are not new kernel declarations or an LRC result.

The single mechanism tested is removal of one independent bounded
relation, followed by a lower-count collision and a finite-kernel
comparison. The result is an exact quantitative phase-loss formula and
an obstruction to a universal scalar comparison weight. The latter
already fails algebraically whenever the replacement changes an original
bounded relation. This does not refute a comparison specialized to the
actual failure and its unshifted good-time predicate. No supported
relation-changing descent has emerged, so new Lean Fourier infrastructure
is not justified by this attempt.

## 1. Full original assumptions and the actual collision

Let v be n positive distinct integer speeds, n>=6, and set

    N=n+1, alpha=1/N, beta=1/n,
    mu=max_(s in T) min_i ||v_i*s||, T=R/Z.

The intended application is a least-count, then least-sum failure among
ALL positive distinct same-count tuples. Thus gcd(v)=1, 0<mu<alpha,
every smaller positive distinct count has its closed native witness,
and every positive distinct n-tuple of smaller sum has a closed
alpha-witness. All times are real modulo one. A bound on a selected
constrained maximum is not substituted for the global mu.

Use the accepted finite-relation theorem with

    epsilon=beta-alpha=1/[n*N], M=n*N, P=2*n^2,
    E=P*(M-1),
    R_E(v)={r in Z^n: max_i |r_i|<=E, r dot v=0}.

Its conclusion under lower-count supply and mu<=alpha is
`span_Q R_E(v)=v^perp`. Choose n-1 independent rows from R_E(v),
remove one row, and let W be the rational annihilator of the other n-2.
Then W is a plane containing v. Choose z in W independent of v and
adjacent distinct values among z_i/v_i. At their indices a,b put

    w'_i=(v_a+v_b)*z_i-(z_a+z_b)*v_i.

The existing adjacent-ratio algebra proves every w'_i nonzero and
w'_a=-w'_b. Clear denominators to obtain an integer w. It is independent
of v, remains in W, and its distinct positive absolute values have
cardinality d<=n-1. Lower count supplies a time t with

    ||w_i*t||>=1/(d+1)>=beta for ALL n original indices.    (1)

Signs and repeated magnitudes are removed only for this supply and then
restored in (1). The omitted independent row has nonzero dot product
with w. Other bounded rows can change too: modulo the retained rational
row span they need not be integer unit multiples of the omitted row.
The phase comparison below keeps every r in R_E(v).

Full sum minimality cannot supply a compatible alternative: the accepted
rank theorem and primitivity force any integer vector preserving all
R_E(v) to be an integer multiple of v. For an arbitrary admissible
lower-sum vector u, the theorem `witness_of_sum_lt` supplies only the
closed alpha margin, not beta. Neither premise supplies a phase-selected
witness for a changed tuple.

## 2. Quantitative comparison using the complete global failure

Use exactly the accepted kernel

    K_M(x)=|sum_(j=0)^(M-1) exp(2*pi*i*j*x)|^2/M,
    c=integral_T K_M^P, J=K_M^P/c.

Write j_q for the real Fourier coefficients of J. They vanish outside
[-E,E], j_0=1, and 0<j_q<=1 throughout that interval. Positivity at
EVERY index follows because q can be written as a sum of P integers in
[-(M-1),M-1], each having a positive K_M coefficient. This is stronger
than merely nonnegative coefficients and is used in Section 3.

The accepted elementary estimates are

    c>=M^(P-1)/(8P), J(x)<=8PM,
    J(x)<=8PM/[4^P*(M*eta)^(2P)] when ||x||>=eta>0.

Define the finite quantities

    a_r=product_i j_(r_i),
    H_w(t)=integral_T product_i J(v_i*s-w_i*t) ds,
    A=sum_(r in R_E(v)) a_r,
    T(eta)=(8PM)^n/[4^P*(M*eta)^(2P)].

Expansion on the ORIGINAL single time circle gives the exact identity

    H_w(t)=sum_(r in R_E(v)) a_r*cos(2*pi*(r dot w)*t).
                                                               (2)

The symmetric r and -r terms justify the real expression. Also H_w>=0
from its defining integral and A=H_w(0)>=1. No independence of the
original phases, or of the remaining relation defects, was used.

For gamma>mu let

    G_w(gamma)={t: ||w_i*t||>=gamma for EVERY i}.

For every t in this COMPLETE closed set and every original time s,
choose an original index with ||v_i*s||<=mu. The reverse triangle
inequality gives

    ||v_i*s-w_i*t||>=gamma-mu.

At least this factor has the tail bound, and every other factor has
the peak bound. Consequently

    H_w(t)<=T(gamma-mu) for EVERY t in G_w(gamma).           (3)

This uses the full global failure on all s and retains all n labels,
including every region where several old labels are bad. Equality in
the closed good threshold or in the distance lower bound is harmless.
Conversely H_w(t)>T(eta) supplies one actual s with ALL coordinate
phase errors <eta; otherwise the same pointwise product bound would
hold everywhere. For t in G_w(gamma) and eta=gamma-mu, such an s would
have every original norm >mu, contradicting the actual global maximum.

At gamma=beta, strict failure makes beta-mu>epsilon. Thus

    T(beta-mu)<T(epsilon)
       =[16*n^3*N/16^n]^n<1.                               (4)

The last strict inequality is proved in the accepted source for n>=6.
So (1) supplies a nonempty set on which H_w is uniformly below one,
even though H_w(0)>=1. A positive total integral or a peak at zero does
not locate that peak in the supplied set. The same (3) applies to every
lower-sum u on its nonempty G_u(alpha), by full sum minimality, but
T(alpha-mu) can be large. The native gap alpha-mu cannot silently be
replaced by beta-alpha.

Here is the precise one-phase loss, without assuming a unit quotient.
Let g be the positive gcd of the nonzero integers r dot w for
r in R_E(v), and put h_r=(r dot w)/g. Such integers exist by Section 1.
Then

    H_w(t)=h(g*t), h(theta)=sum_r a_r*cos(2*pi*h_r*theta),
    A-h(theta)=sum_r a_r*(1-cos(2*pi*h_r*theta)),
    S=sum_r a_r*h_r^2>0,
    0<=A-h(theta)<=2*pi^2*S*||theta||^2.                    (5)

For the last inequality use a centered representative of theta and
`1-cos y<=y^2/2`; integrality of every h_r preserves the cosine.
The gcd of their nonzero values is one, but no particular h_r need
equal one. All coefficients and all frequencies remain in (5).

Combining (3)--(5), EVERY supplied beta-good time obeys

    ||g*t|| >= sqrt((A-T(beta-mu))/(2*pi^2*S)).              (6)

This is a global exclusion of aligned phases, not supply of an aligned
witness. In particular, producing one such witness with a STRICTLY
smaller phase distance would prove a contradiction, but count and sum
minimality have not produced it here.

One can retain positive measure as well as points without changing E.
Choose `max(alpha,mu+epsilon)<gamma<beta`; this is possible since
mu<alpha. A closed beta seed has an open neighborhood in G_w(gamma),
so rho=measure G_w(gamma)>0. With

    B=sum_(r in R_E(v), r dot w=0) a_r >=1,

integration of (2)--(3) gives the exact signed requirement

    sum_(r dot w != 0) a_r * integral_(G_w(gamma))
         cos(2*pi*(r dot w)*t) dt
       <= (T(gamma-mu)-B)*rho < 0.                         (7)

This identifies the correlation lost by independent phase averaging.
It is not a proved opposite inequality or a new positivity budget.

## 3. Why a universal scalar time weight cannot remove this defect

This obstruction is exact and has no LRC premise. Take integer v,w and
the same J with j_q>0 on [-E,E]. For any integrable scalar weight V(s),
even complex or signed, compare the positive kernel family at ALL
independent phase shifts theta in T^n:

    Delta_V(theta)
      = integral_s V(s)*product_i J(v_i*s-theta_i)
        - integral_t product_i J(w_i*t-theta_i).             (8)

The weight may depend on v,w and their arithmetic, but is one fixed
function of s, independent of theta. For r in the full cube [-E,E]^n,
the coefficient of exp(-2*pi*i*r dot theta) in (8) is

    a_r*(integral_s V(s)*exp(2*pi*i*(r dot v)*s)
                    - 1_(r dot w=0)).                     (9)

Thus an exact identity for all these phase shifts exists if and only if

    r dot v=r' dot v  implies
    1_(r dot w=0)=1_(r' dot w=0)
    for every r,r' in [-E,E]^n.                            (10)

Necessity follows from (9), since a_r>0. For sufficiency, let L be the
finite set of frequencies r dot v and let b_l in {0,1} be the well-defined
value in (10). The finite real polynomial

    V(s)=sum_(l in L) b_l*exp(-2*pi*i*l*s)

has exactly the required moments; symmetry of L and b makes it real.
No nonnegativity of this comparison weight is claimed or needed.

In particular, if r_* in R_E(v) has r_* dot w!=0, (10) fails on
r=0 and r'=r_*. These two multi-frequencies are both the constant
time frequency on the original orbit, while only one is constant on
the new orbit. No scalar weight can distinguish them. This applies
to EVERY collision produced in Section 1, independent of the chosen
basis and even if the weight is chosen using the actual failure.
The impossible extra requirement is universality in theta.

There is a quantitative version. Write a=a_(r_*)>0 and c_0=integral V.
The two coefficients in (9) are c_0-1 and a*c_0. Fourier coefficient
bounds on normalized Haar measure yield

    ||Delta_V||_infinity >= ||Delta_V||_1
       >= max(|c_0-1|,a*|c_0|) >= a/(1+a).                 (11)

The final step follows from
`1<=|1-c_0|+|c_0|`. If the weight has mean one, the lower bound is a.
The same inequalities hold with essential supremum; (8) is continuous
in theta because it is a finite polynomial.

Even a crude explicit positive bound is available. Each K_M coefficient
inside its support is at least 1/M; one contributing P-fold product and
c<=M^P give j_q>=M^(-2P) for every |q|<=E. Also j_q<=1 since J is a
nonnegative probability density. Hence

    ||Delta_V||_infinity >= 1/[2*M^(2*P*n)].                 (12)

This bound can be extremely small. No useful comparison between (12)
and the tail in (4), or impossibility of every approximate or specialized
comparison, is asserted. Its role is exact: dropping a relation cannot
be repaired by an arbitrarily accurate universal scalar identity for
this fixed kernel and cutoff. All original coordinates occur in (8).

## 4. Prior holds, literature scope, and disposition

The completed affine transfer already changes relations using a proved
small affine error and its exact rational period; it does not rely on a
universal comparison identity. Removing a row supplies no such small
error. The projection review retains an integer point in a common fibre
as an additional obligation. The parity/pair holds retain all half-shift
masks. The parent repair source needs a common candidate across ALL
private portions, and the private-repair review retains multiply-bad
regions. Neither a projected point nor a locally repaired portion is an
all-label phase witness for (2). These obstacles are not being renamed
as a positive transport theorem.

For source comparison, I directly read Section 4, especially Lemmas
4.1, 4.3 and 4.4, of
[Tao, Some remarks on the lonely runner conjecture](https://arxiv.org/pdf/1701.02048).
Its collision and Fourier transfer use a proper progression and a
weighted comparison identity. The proof establishes equivalence and
uniqueness of bounded frequency lifts. That is actual extra arithmetic;
deleting a row of an arbitrary full-rank bounded-relation family does
not establish it. Formula (10) is a direct finite-Fourier test of the
proposed scalar analogue. The present obstruction does not contradict
Tao's result or claim novelty for collision/Fourier methods.

The first unresolved inference is a failure-dependent selection or
comparison that controls the changed frequencies at an ACTUAL supplied
witness. Quantitatively, the proposed one-phase route would need a
collision w and t in its full G_w(beta) violating (6), or a specialized
unshifted comparison strong enough to contradict (3). Merely requiring
this is not progress: no argument from complete count/sum minimality
has supplied it. Equations (6) and (7) are the exclusions it must
overcome, not proposed universal inequalities in the reverse direction.

The bounded task therefore stops with a precise obstruction to the
universal scalar mechanism and the full phase-defect estimate. The next
concrete mathematical check is whether a proposed specialized comparison
keeps the zero-frequency collision in (9) as an explicit error and proves
control of that error from actual strict failure and minimum sum. An
argument that again assigns different moments to r=0 and r=r_* fails
before any witness analysis. No supported positive estimate for the
specialized error is available here, and no new Lean implementation is
recommended. The unrestricted theorem remains unresolved.

## 5. Source bindings and checks

Current config, workflow, policy and focused state were read. The setup
gate was research/in_progress with the explicit goal authorization of
2026-09-05. Startup and post-resumption workflow validation passed. The
source interfaces inspected include `MinimalCounterexample.lean:12,18,198`,
`MinimalFailureDeletion.lean:84,130`, the adjacent-ratio algebra and the
accepted finite-kernel/rank source and review. Relevant affine,
projection, parity, parent and private-repair scopes were read directly.
The external PDF was retrieved through the web tool; no local copy,
external model, mathematical program or new agent was used.

All new algebra and inequalities above were checked by hand. Final owned
readback, exact input hashes, newline/whitespace checks and
`python3 -B scripts/validate_workflow.py` are recorded at handoff.
The validator certifies workflow structure, not mathematics. No Lean
source/build, cache/dependency operation, enumeration, Git/state/memory
write or other-file edit was performed. Source and review acceptance are
distinct; these new claims await independent review.

| Input | SHA-256 |
| --- | --- |
| `research/astra-large-block-minimality.md` | `7fee5332b73f99e0c8ec9b7de85d59b57d9c5e9e19425d58ba5ae5ac1ce64b9f` |
| `research/astra-large-block-minimality-review.md` | `032f5c8a4d7a6086727a299fe2e132b7f500b163f1e82d1ddc89415059f0ebf2` |
| `LonelyRunner/MinimalCounterexample.lean` | `b0c13b2212abd6bca49fe59f16b0c9d5b124e07e85226e35c14378baa1ffd539` |
| `LonelyRunner/MinimalFailureDeletion.lean` | `2c9b11be2996fec5ef56278d6df0acda3723669a30f4003be374300d4a10342c` |
| `LonelyRunner/BHKAdjacentRatios.lean` | `677c365618fc612a5ee7d3d9e9696273da2d9e775b77487d0b3e208cea9d6733` |
| `LonelyRunner/BHKAdjacentPair.lean` | `3d36d812db7ed18db8fce521b2505d5904a8387d8e315c6e7d08d9eb7dc75708` |
| `LonelyRunner/BHKCollisionToWitness.lean` | `e5175b1f55a2d73e850ffd3e5a5dab140b6e4d84f0cefd94ebf6d7663d3a0d6a` |
| `research/astra-affine-finite-height-audit.md` | `6b676a05eb3a0036cd69e779150a5f1a868024d089ea75c142daeddccede938f` |
| `research/astra-affine-finite-height-review.md` | `eb0fb96e22096175fa3b68dc70a1b7981f39356aaf1377863dcaa95b6a510876` |
| `research/astra-center-preserving-projection-review.md` | `a1402e6545dd2de6a2d4b2f832b2ff13ec52f759a1ae5fb183122d1ad3d0c7e6` |
| `research/astra-same-parity-pair-descent.md` | `9ccb99d3ef297b5e1e3bb1f0dd6bc20234ff895ebcbe40d362098aaf72903a35` |
| `research/astra-zero-only-parent-reduction.md` | `9b67661ec12a1b51e6de9405c04f3a0d071b3a5630b6ad772d19da18baf99d71` |
| `research/astra-private-repair-review.md` | `a8aaec8468969723207dc12e9ff2c112a4560c1f51e97f13b43f4e342c849512` |
| `.codex/config.toml` | `28212a53cf42cdc377df1f7dab040732d657e59d7bb97ee78791256d01d4bb2c` |
| `docs/project-workflow.md` | `2b42a133352b6b53ba2106fc73882733f176e04a0deffbb183b4c16eefd9cd67` |
| `research/workflow-policy.json` | `833c397b61d1ffdb994fb115019f6d60d6c1a62ff85f19cdd2c9f8ac3a979c8b` |
| `scripts/validate_workflow.py` | `250a3ce2a080f5835ac4fd2e4b2803568424c777cda5d421f9fe92efd34d5383` |
