# Independent review of bounded-relation rank under lower-count supply

Task `/root/large_block_minimality_review`; review checkpoint
`71ecb331e43687a5d2be31c8c2599e44d9ee1b6c`. Requested route:
`gpt-6-astra/xhigh`. Observed model, effort, elapsed task time and usage:
null. Only this review is owned; other manuscripts and shared state are
preserved.

**Disposition: accepted at the exact manuscript scope, with no mathematical
correction.** The complete frozen author is
`research/astra-large-block-minimality.md`, SHA-256
`7fee5332b73f99e0c8ec9b7de85d59b57d9c5e9e19425d58ba5ae5ac1ce64b9f`.
Its finite phase lemma and lower-count rank consequence are sound. The
consequence excludes the specified relation-preserving descent and proper
splitting branches, but supplies neither a new finite-height improvement
nor a contradiction in the remaining full-rank case. This is independent
hand review, not a new kernel proof or a literature-priority judgment.

## Exact hypotheses and finite phase transfer

Fix n>=6 positive distinct integer speeds v, alpha=1/(n+1), beta=1/n and
the actual maximum mu of the full minimum on the time circle. Assume

    (LC) every d distinct positive integer speeds, 1<=d<n,
         have a common closed 1/(d+1) witness.

The principal conclusion needs only (LC) and mu<=alpha. Primitivity and
least sum are needed for the later descent comparison, not for this rank
theorem. A full `MinimalPositiveIntegerFailure` supplies (LC), primitivity
and the stronger 0<mu<alpha through its actual exported contracts. The
source does not identify failure of a closed witness with merely mu<=alpha.

Put M=n(n+1), P=2n^2, epsilon=1/M and E=P(M-1). Let R_E consist of ALL
integer zero relations of v with each coefficient at most E in absolute
value. There is no support-size restriction. For a torus point x, the
phase lemma assumes r dot x=0 **in R/Z** for every r in R_E, and concludes
one real time t with ||v_i t-x_i||<epsilon for every original label.

I independently checked the kernel normalization. The finite Fejer kernel
K_M has nonnegative triangular Fourier coefficients and degree M-1.
On the centered interval |s|<=1/(8PM), every angle in its defining sum
has absolute value <1/P, since pi<4. Taking the real part and using
cos(y)>=1-y^2/2 yields

    K_M(s)/M >= (1-1/(2P^2))^2 >= 1-1/P^2.

Bernoulli then gives K_M(s)^P>=M^P(1-1/P)>=M^P/2. The interval has
length 1/(4PM), so c=integral K_M^P>=M^(P-1)/(8P)>0. Consequently
J=K_M^P/c has mean one, degree E, nonnegative real Fourier coefficients,
and peak at most 8PM. In particular its constant Fourier coefficient is
exactly one; it is not merely bounded below by one.

The geometric-sum formula and sin(pi q)>=2q for 0<=q<=1/2 give
K_M(s)<=1/(4M q^2) when q=||s||>0. Hence for q>=epsilon=1/M,

    J(s) <= 8PM/4^P.

The author's unsimplified bound (5) is the same inequality before using
M epsilon=1. If no required common approximation exists, at every t at
least one coordinate has distance >=epsilon. The product F_x of all n
translated J factors therefore satisfies, everywhere,

    F_x(t) <= (8PM)^n/4^P
            = [16n^3(n+1)/16^n]^n < 1.

The strict numerical comparison holds uniformly: 2^n>=n^2 for n>=4 by
induction, so 16^n>=n^8; for n>=6,
16n^3(n+1)<=32n^4<n^8. This gives a single upper bound strictly below
one for the entire circle, not only separate pointwise strict inequalities.

On the other hand, expand this finite product before integrating in the
single actual time variable. Precisely the terms indexed by R_E survive:

    integral F_x = sum_(r in R_E) product_i Jhat(r_i)
                                      * exp(-2 pi i r dot x).

The phase assumption makes every multiplier one. All coefficient products
are nonnegative, and r=0 contributes one. Thus the integral is at least
one, a contradiction. No independence of the n phases, infinite Fourier
interchange, sign cancellation or unbounded-relation theorem is assumed.
Changing representatives of x changes r dot x by an integer and leaves
the argument intact. Treating distance exactly epsilon as excluded proves
the needed STRICT approximation; real lifts, wrap points and negative
times introduce no exception.

## Rank defect and the lower-count witness

Write L_E=span_Q R_E and W=L_E perpendicular over Q. Since L_E is
contained in v perpendicular, rank is at most n-1. If it were at most
n-2, W would contain v and an independent rational vector z. The ratios
z_i/v_i are not constant. Choose adjacent distinct attained ratios at a,b.
For

    w_i=(v_a+v_b)z_i-(z_a+z_b)v_i,

the weighted mean (z_a+z_b)/(v_a+v_b) lies strictly between those adjacent
ratios. No w_i can vanish. Direct expansion gives w_a=-w_b!=0. This is
exactly the inspected adjacent-ratio algebra; it requires positivity of
the reference v but does not assume any orbit-closure premise.

Every bounded original relation annihilates v and z, hence w, with the
SAME coefficients. Take a positive integer q clearing denominators of w.
Its distinct magnitudes |q w_i| form a nonempty positive integer set with
d<=n-1 labels, because the opposite pair has equal magnitude. By (LC),
some tau works for that entire set at margin 1/(d+1)>=beta. The time for
the original rational w is q tau, since (q tau)w_i=tau(q w_i). Neither
division by q nor independently chosen coordinate times would suffice.
Evenness of circle norm restores all signed coordinates and repetitions.

Set x_i=q tau w_i modulo one. Its relation sums vanish exactly as real
numbers using these lifts, which is stronger than the torus annihilation
needed by the phase lemma. At the resulting common original time,

    ||v_i t|| >= ||x_i||-||v_i t-x_i||
               > beta-epsilon = alpha

for EVERY i. The closed smaller-count seed is sufficient precisely because
the transfer error is strict. It contradicts the actual global bound
mu<=alpha. Thus rank_Q L_E=n-1 under the stated assumptions.

This establishes rational generation of the relation SPACE by n-1 bounded
independent rows. It does not establish integral generation of the whole
relation lattice. Likewise W=Qv is a rational-linear assertion; it is not
an assertion that the torus annihilator of the bounded relations has no
additional finite components. Neither stronger assertion is used.

The current `BHKCollisionToWitness.lean` wrapper requires ALL integer
relations and its stated rational-witness supply. The manuscript correctly
does not feed its truncated relation premise into that wrapper. It proves
the required finite transfer directly and obtains its seed from lower
counts. The source's complete deletion sets and single shared attained mu
also remain intact; no deletion witness is silently a witness for a
simultaneous replacement or for the full original tuple.

## Splitting, sum and height consequences

For any D>=E, suppose a partition into b nonempty blocks splits every
D-bounded original relation. By linearity each element of L_E satisfies
one zero equation on each block. Those b forms are independent: their
supports are disjoint and each contains a nonzero original speed. Their
common kernel has dimension n-b. Full rank therefore forces b=1.

The exact comparison at the proposed half-block depth is

    D_half-E = 2n^2(n+1)[784(n+1)-n]+2n^2-2 > 0,
    D_half = 1568n^2(n+1)^2-2.

This rules out a proper core with a nonempty outside block that actually
satisfies splitting at that depth under (LC) and mu<=alpha. It does not
depend on an unreviewed half-block positivity theorem. Nor does it silently
apply at the earlier D_0=6272n^2-2 for all n: eventually E>D_0. The frozen
quadratic positive-block theorem and its distinct hypotheses are preserved.

Now assume primitive v. Any integer w preserving all E-bounded relations
lies on Qv, say w=lambda v. Bezout coefficients with sum a_i v_i=1 give
lambda=sum a_i w_i in Z. Positivity implies lambda>=1, so its sum cannot
be smaller. If w is also primitive it equals v; larger integer multiples
are not primitive. Keeping even one positive original coordinate fixed
also forces lambda=1 without a primitivity assumption. These claims concern
the same original labelled coordinates and complete relation preservation;
they do not forbid a general relation-changing descent.

The existing smaller-sum source theorem quantifies over ALL positive
injective same-count tuples, but it supplies only a closed alpha witness.
It supplies neither the relation constraints nor the beta slack needed
above. The previous private-repair, parity-coset and pair-descent holds are
invoked at this correct scope: selected seeds, tracked competitors and
private sets cannot replace the full common-time comparison.

The actual sharper height theorem, with m=n-1 and the stationary zero
appended to a sorted primitive v, gives the inclusive necessary failure
cutoff H=C^(n-1), C=binom(n+1,2), assuming (LC). Its universal finite-family
obligation remains present in the equivalence theorem. I checked the
current source statements, rather than replacing them by an older bound
from the historical affine manuscripts.

The displayed E<H comparison is valid: E<4n^2 C and
C^(n-2)>=C^4>=n^8/16>4n^2 for n>=6. This compares two numerical bounds;
it does not say a particular tuple has max v>E. If E>=max v, the primitive
pair relations already fit and span v perpendicular. No extra restriction
is then obtained. Conversely, n-1 independent E-bounded rows yield an
integer cofactor null vector whose coordinates are bounded by
(n-1)!E^(n-1). For primitive v, dividing that vector by its gcd gives v
up to sign. This height bound is larger than H because E>C, so it gives
no improvement on the accepted cutoff.

The native-sharp progression (1,...,n) confirms the limitation. Its n+1
orbit points, including zero, cannot all have circular separation greater
than 1/(n+1), while time 1/(n+1) attains that margin. Thus mu=alpha. The
n-1 displayed relations are independent by eliminating their highest
coordinates successively, and their coefficients are at most two. Full
bounded-relation rank is compatible with this LRC-good boundary example;
it is not itself a certificate of strict failure.

## First unresolved implication and evidence

The first missing implication in this proposed descent route is control of
the phase of a CHANGED E-bounded relation at a supplied smaller-tuple
witness, sufficient to transfer all original labels at one actual time.
Neither sum minimality nor the reviewed private/parity restrictions gives
that control. Preserving every bounded relation cannot give a fresh
lowering in the remaining primitive full-rank class; assuming rank defect
again merely returns to a branch the theorem has excluded. This conclusion
does not preclude other mechanisms or prove a universal impossibility.
Unrestricted LRC remains unresolved, and no new Lean implementation or
kernel acceptance follows from this manuscript review.

The complete frozen author was read in receipt `a1b0e4`; all 18 actual
input hashes matched in `637f88`. Current project instructions were read
in `57fbfc`; focused state and start authorization were read in `102c1b`.
Workflow validation `967c0b` exited 0 with:

    workflow structural validation passed; it cannot certify mathematical validity.

The adjacent-ratio sources and lower-count source were read during the
independent candidate check before freeze. Current all-relations wrapper
readback is `e1a802`; exact minimality, deletion, sharper-height and
equivalence scope readback is `a47b58`. Prior held mechanisms and historical
height comparisons were inspected at their invoked scopes in `67a735`
and `8cc190`; no historical mathematical computation was replayed. Earlier
accepted positive-block evidence was reused with its current hash checked.
Full owned readback, final source bindings, newline/whitespace and workflow
checks are repeated at handoff; their actual receipts and review hash are
reported separately. Hashes certify byte identity, not the mathematics.

No mathematical program, enumeration, solver, local build, dependency/cache
operation, external model, new agent, Git/shared-state/memory write or
other-file edit was performed. The only Python uses were administrative
state, binding, format and workflow checks. Runtime accounting remains null.

| Bound source | SHA-256 |
| --- | --- |
| `research/astra-large-block-minimality.md` | `7fee5332b73f99e0c8ec9b7de85d59b57d9c5e9e19425d58ba5ae5ac1ce64b9f` |
| `LonelyRunner/MinimalCounterexample.lean` | `b0c13b2212abd6bca49fe59f16b0c9d5b124e07e85226e35c14378baa1ffd539` |
| `LonelyRunner/MinimalFailureDeletion.lean` | `2c9b11be2996fec5ef56278d6df0acda3723669a30f4003be374300d4a10342c` |
| `LonelyRunner/BHKAdjacentRatios.lean` | `677c365618fc612a5ee7d3d9e9696273da2d9e775b77487d0b3e208cea9d6733` |
| `LonelyRunner/BHKAdjacentPair.lean` | `3d36d812db7ed18db8fce521b2505d5904a8387d8e315c6e7d08d9eb7dc75708` |
| `LonelyRunner/BHKCollisionToWitness.lean` | `e5175b1f55a2d73e850ffd3e5a5dab140b6e4d84f0cefd94ebf6d7663d3a0d6a` |
| `LonelyRunner/FiniteHeightReduction.lean` | `cb41059260b943411e2ab5360b84b59cd13f2ddf352c3c50a0b3715b9b9987d6` |
| `LonelyRunner/FiniteFamilyEquivalence.lean` | `475a46b9e10226f3de30628e595073a9765a8c03cb0ab071bdcc10acb6446be3` |
| `research/astra-positive-block-transport.md` | `ced2c8cfac1bcc529e73a5ee8eef4af3595d30ebfa7db49273aa3ebd6f39f232` |
| `research/astra-uniform-global-transport-strategy.md` | `c6d433ea553cc5507a0faa97387fba75108d15bece45ac14489c879c2078d618` |
| `research/astra-private-repair-review.md` | `a8aaec8468969723207dc12e9ff2c112a4560c1f51e97f13b43f4e342c849512` |
| `research/astra-same-parity-pair-descent.md` | `9ccb99d3ef297b5e1e3bb1f0dd6bc20234ff895ebcbe40d362098aaf72903a35` |
| `research/astra-parity-coset-minimum-review.md` | `fda600dd2cdbf2f470bc18e24baeab0bb4b9a90616f34b10d160ba3fa86b3360` |
| `research/astra-affine-finite-height-audit.md` | `6b676a05eb3a0036cd69e779150a5f1a868024d089ea75c142daeddccede938f` |
| `research/astra-affine-finite-height-review.md` | `eb0fb96e22096175fa3b68dc70a1b7981f39356aaf1377863dcaa95b6a510876` |
| `.codex/config.toml` | `28212a53cf42cdc377df1f7dab040732d657e59d7bb97ee78791256d01d4bb2c` |
| `docs/project-workflow.md` | `2b42a133352b6b53ba2106fc73882733f176e04a0deffbb183b4c16eefd9cd67` |
| `research/workflow-policy.json` | `833c397b61d1ffdb994fb115019f6d60d6c1a62ff85f19cdd2c9f8ac3a979c8b` |
| `scripts/validate_workflow.py` | `250a3ce2a080f5835ac4fd2e4b2803568424c777cda5d421f9fe92efd34d5383` |
