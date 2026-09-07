# Independent review of relation-changing scalar transport

Task `/root/relation_changing_transport_review`; review checkpoint
`ece90ad9f84e50f0158946daf329bb67341105fe`. Requested route:
`gpt-6-astra/xhigh`; observed model, effort, elapsed task time and usage:
null. Only this review is owned.

**Disposition: accepted at the stated restricted manuscript scope, without
mathematical correction.** The complete frozen author is
`research/astra-relation-changing-transport.md`, SHA-256
`8712e1dbc753e6ef77c87067171914fdcaa5f3635772836a4bb44d7de83b8bb3`.
The full-good-set tail estimate, phase exclusion, signed correlation and
exact frequency-fiber criterion are valid. They provide no phase-selected
witness and do not exclude a comparison specialized to the unshifted
good-time predicate. No kernel proof or unrestricted LRC result follows.

## Collision and the full-time tail estimate

Retain n>=6 positive distinct integer speeds v, alpha=1/(n+1), beta=1/n,
the actual global maximum mu of the original full minimum, and 0<mu<alpha.
Lower-count supply and the accepted bounded-rank theorem give n-1
independent original relations at E=P(M-1), M=n(n+1), P=2n^2. Removing
one selected independent row leaves a rational annihilator plane. The
adjacent-ratio combination of v and an independent vector z in that plane
is nowhere zero and has two opposite coordinates, as in the bound source.
Its coefficient on z is v_a+v_b>0, so it remains independent of v after
clearing denominators. Consequently the omitted row cannot annihilate w:
otherwise w would lie in the full rational annihilator Qv.

The positive distinct magnitudes of the resulting integer w have count
1<=d<=n-1. Lower-count supply therefore gives a CLOSED beta witness for
all n signed original slots, by evenness of circle norm and restoration
of repeated magnitudes. No same-count rational conjecture, smaller-sum
property of this collision, or phase condition at that witness is assumed.
Other E-bounded rows may also change. Rational codimension one does not
make their defects integer unit multiples of the omitted row's defect.

Write J=K_M^P/c and j_q=Jhat(q). The accepted normalization and tail bounds
apply unchanged. At every integer |q|<=E, a sum of P integers in
[-(M-1),M-1] realizes q; all corresponding Fejer coefficients are positive.
Thus j_q>0 on the entire closed coefficient interval, including its two
endpoints. Also j_0=1 and |j_q|<=integral J=1 because J is pointwise
nonnegative. Pointwise strict positivity of J is not needed.

For a_r=product_i j_(r_i), expansion in the ORIGINAL common time s gives

    H_w(t)=integral_s product_i J(v_i s-w_i t)
          =sum_(r in R_E(v)) a_r cos(2 pi (r dot w)t).

Pairing r with -r cancels imaginary parts; summing over the full symmetric
set introduces no additional factor two. The defining integral proves
H_w>=0. At t=0 its value is A=sum_r a_r>=1, including the zero row's
contribution one. These are correlated finite Fourier terms, not
independent coordinate moments.

For gamma>mu, take ANY t in the complete closed set
G_w(gamma)={t: every ||w_i t||>=gamma}. For EVERY s, the original global
bound supplies some i with ||v_i s||<=mu. The circle triangle inequality
then gives ||v_i s-w_i t||>=gamma-mu. That coordinate receives the tail
bound; all others receive the peak bound. Integration therefore gives

    H_w(t)<=T(gamma-mu),
    T(eta)=(8PM)^n/[4^P(M eta)^(2P)].

The selected old bad label may vary with s; the product bound requires
only its existence at each s. It covers multiply-bad regions, all signed
new labels, negative times and circle wraps. Closed endpoint equalities
preserve every inequality. Conversely H_w(t)>T(eta) forces some actual s
with every phase error STRICTLY below eta, since otherwise the same
product bound would hold everywhere. At t in G_w(gamma), eta=gamma-mu,
that would make every original norm >mu and contradict the global maximum.

Strict failure gives beta-mu>beta-alpha=1/M=epsilon. Since T decreases
strictly on eta>0,

    T(beta-mu)<T(epsilon)=[16n^3(n+1)/16^n]^n<1.

The final constant was independently checked in the accepted predecessor.
Hence the entire supplied beta-good set has H_w below one despite its
value at zero. The same tail argument applies to an admissible lower-sum
tuple u on G_u(alpha), but its supplied gap is alpha-mu. It cannot be
replaced by epsilon, and its tail bound need not be below one. This is the
correct scope of `witness_of_sum_lt`.

## Gcd phase loss and positive-measure correlation

There is at least one nonzero integer r dot w. Its positive gcd g over
the finite relation set is therefore well-defined. Set h_r=(r dot w)/g.
All h_r are integers; their nonzero values collectively have gcd one,
although no individual value need have absolute value one. With
S=sum_r a_r h_r^2, strict positivity of the relevant a_r gives S>0.

For h(theta)=sum_r a_r cos(2 pi h_r theta), the exact loss and upper
estimate are

    A-h(theta)=sum_r a_r[1-cos(2 pi h_r theta)],
    0<=A-h(theta)<=2 pi^2 S ||theta||^2.

To obtain the second line choose one centered lift of theta. Replacing
theta by that lift changes each cosine by an integer period, and
1-cos y<=y^2/2 holds for arbitrary real y, even when |h_r theta| is large.
The estimate retains every frequency and every weight. Since A>=1 and
T(beta-mu)<1, its numerator below is strictly positive. Combining with
the tail bound yields, at EVERY beta-good time,

    ||g t||>=sqrt((A-T(beta-mu))/(2 pi^2 S)).

This is an exclusion condition under failure. It does not produce a time
violating that condition. The proof would also be valid if the lower bound
exceeded 1/2; that additional event would itself contradict the already
supplied good time, but no estimate establishing it is present.

Both alpha and mu+epsilon are strictly below beta. Choose gamma between
their maximum and beta. Continuity of all finitely many signed phases at
a closed beta seed yields an open interval contained in G_w(gamma), so
rho=measure G_w(gamma)>0. Define
B=sum_(r dot w=0) a_r>=1. Those terms contribute exactly B rho on this
set. Integrating the pointwise tail bound therefore gives

    sum_(r dot w!=0) a_r integral_(G_w(gamma)) cos(2 pi (r dot w)t)
      <=[T(gamma-mu)-B]rho<0.

Here gamma-mu>epsilon makes T(gamma-mu)<1<=B. This is a signed
correlation of the COMPLETE good-time set with the changed frequencies.
It is neither termwise negativity nor the reverse positivity estimate
needed for a contradiction. Coincident frequencies remain counted with
their actual relation multiplicities.

## The exact scalar-weight obstruction

This part has no LRC or minimality premise. Fix integer vectors v,w and
the same finite J. Let V be any integrable complex scalar function of s,
fixed independently of theta in T^n. Expand the author's Delta_V in the
independent phase variables. The coefficient of exp(-2 pi i r dot theta)
is exactly

    a_r [ integral_s V(s) exp(2 pi i (r dot v)s)
                          - 1_(r dot w=0) ],

for every r in the FULL cube [-E,E]^n. Since a_r>0, all-phase equality
requires that the target indicator be constant on every fiber of
r -> r dot v. Conversely, if this condition holds, assign its common
value b_l to each original time frequency l and take the finite polynomial
V(s)=sum_l b_l exp(-2 pi i l s). Orthogonality gives every required
moment. The symmetric cube gives b_(-l)=b_l and symmetric frequency set,
so this V is real. It need not be nonnegative. This proves both directions
of the stated iff with exactly the stated class of admissible weights.

For the removed relation r_*, the two phase indices 0 and r_* have the
same original frequency zero and different target indicators. They cannot
be distinguished by a scalar moment, whatever arithmetic or hypothetical
failure data were used to choose V. This disproves the identity for all
independent phase shifts, not its value at one chosen shift.

The quantitative obstruction also holds for complex V. Put
a=a_(r_*) in (0,1] and c_0=integral V. The two distinct Fourier
coefficients of Delta_V are c_0-1 and a c_0. On normalized Haar measure
of T^n, a Fourier coefficient is bounded by the L1 norm, which is bounded
by the supremum norm. Therefore both norms are at least

    max(|c_0-1|,a|c_0|)>=a/(1+a).

Indeed if that maximum is L, the triangle inequality gives
1<=|1-c_0|+|c_0|<=L(1+1/a). Mean-one V gives the stronger lower bound a.
The finite expansion makes Delta_V continuous even when V is merely
integrable, so essential and ordinary supremum agree.

Every supported Fejer coefficient is at least 1/M. A single P-fold
contribution gives (K_M^P)hat(q)>=M^(-P); c<=M^P then gives
j_q>=M^(-2P). Thus a>=M^(-2Pn), and a/(1+a)>=a/2 proves
the displayed explicit error lower bound 1/[2M^(2Pn)]. It is a positive
bound for a FIXED kernel and cutoff, independent of the chosen V. It
does not compare favorably with any required transport tolerance by
itself, and says nothing about a different kernel, a theta-dependent
weight, or an error at the single unshifted point.

## Source comparison, first gap and checks

The directly retrieved Section 4 of Tao's paper uses a proper progression,
a nonzero collision, lower-count supply, and a finite Fourier comparison.
In Lemma 4.4, equivalence and uniqueness of the added frequency are proved
using the progression's properness and the primitive direction. Those
are substantive extra hypotheses behind its coefficient identity. The
present deletion of a bounded original relation does not establish them.
The manuscript's restricted obstruction therefore does not contradict
that result or establish novelty for collision/Fourier transfer.
[Tao, Some remarks on the lonely runner conjecture, Section 4](https://arxiv.org/pdf/1701.02048).

The prior affine argument instead controls a concrete perturbation with
the correct rational period. The inspected projection, parent and private
sources retain respectively the fiber integer-point obligation, common
repair across all attained portions, and multiply-bad old regions. None
supplies the missing all-label phase comparison; the current manuscript
uses them only to preserve those scope restrictions.

The first unresolved inference is a failure-dependent choice or comparison
that controls the changed-frequency contribution at an actual supplied
witness. For the one-phase route, a beta-good time strictly violating the
proved gcd-phase exclusion would suffice, but has not been supplied. A
specialized unshifted comparison must retain and bound the error caused
by the conflicting zero-frequency coefficients. No such bound follows
from the displayed identities or from count/sum minimality alone here.
The universal scalar branch is obstructed; the specialized branch remains
open. This is not a universal transport impossibility or an LRC disproof.

Complete frozen-author readback: `44b2cc`. All 17 actual input bindings:
`005783`, passed. Current config/workflow/policy reads: `499dd1`, `8e8275`;
focused active state and research authorization: `a0f552`. Startup workflow
check `db9c06` exited 0 with the full output

    workflow structural validation passed; it cannot certify mathematical validity.

Unchanged accepted kernel/rank, minimality, deletion and adjacent-ratio
source evidence was reused after checking current hashes; the original
proofs were not treated as new declarations in this manuscript. Current
projection/parent scope inspection is `74d707`. Tao's actual Section 4
was retrieved through the web tool and its coefficient comparison read
directly; no local PDF or build was created. Final owned full readback,
author-plus-input hashes, whitespace/newline and workflow checks are
reported with the frozen review hash at handoff. No mathematical program,
solver, enumeration, Lean run, cache restoration, new agent, external model,
Git/shared-state/memory write or other-file edit was performed. Administrative
checks establish source identity and workflow structure, not proof validity.
Observed runtime accounting remains null.

| Bound source | SHA-256 |
| --- | --- |
| `research/astra-relation-changing-transport.md` | `8712e1dbc753e6ef77c87067171914fdcaa5f3635772836a4bb44d7de83b8bb3` |
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
