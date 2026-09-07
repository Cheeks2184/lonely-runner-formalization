# Positive common-time transport across arithmetic blocks

Task `/root/positive_block_transport`; assigned checkpoint
`fdf2ae4d56727f6fb007aa34eabb909de4eebe55`. Requested route:
`gpt-6-astra/xhigh`; observed model, effort, elapsed task time and usage:
null. Only this manuscript is owned. Root proposed the buffered envelopes
and relative block error argument; all constants and implications below
were checked here by hand. New claims await independent review. No kernel
theorem, literature novelty or unrestricted LRC result is claimed.

The positive result is a quadratic-degree arithmetic criterion giving a
common native-good set of positive measure. Dependence within each block
is preserved exactly. A hypothetical failure must therefore contain a
large block coupled by bounded relations that cannot be split by zero
restrictions. This is stronger information than a large component formed
by all relation supports, but no height-minimality argument yet excludes
such a block.

## 1. Exact contract

Let n>=6, let v_1,...,v_n be positive integers, and put

    N=n+1, alpha=1/N, delta=1/(56*n),
    M=(56*n)^2, D=2*(M-1)=6272*n^2-2.                       (1)

All integrals use Haar probability on T=R/Z. Let P be a partition of all
original labels into b nonempty blocks, each satisfying

    4*|B|<=N.                                               (2)

The arithmetic hypothesis is the following exact splitting property:

    for every r in Z^n with |r_i|<=D and sum_i r_i*v_i=0,
    sum_(i in B) r_i*v_i=0 for every B in P.                 (3)

There is NO bound on the support size of r. Internal block relations are
allowed, including relations without unit coefficients. Then

    measure{t: ||v_i*t||>=alpha for all i} >= 2^(-b-1)>0.    (4)

The same bound holds with every inequality strict. In particular the
actual global maximum of the full minimum is greater than alpha.

Distinctness, primitivity and count/sum minimality are unnecessary for
this sufficient theorem. For the intended application retain a least-count,
then least-sum strict failure among ALL positive distinct same-count
tuples, with its primitive normalization and actual global mu<alpha.
Such a tuple cannot have a partition satisfying (2)--(3). The n>=6 range
is imposed here uniformly; the six-runner theorem is not used to supply
any block witness or measure estimate.

## 2. A finite positive kernel and pointwise envelopes

Use e(x)=exp(2*pi*i*x) and the normalized squared Fejer kernel from the
accepted global-transport source:

    K_M(x)=|sum_(j=0)^(M-1) e(j*x)|^2/M,
    c_M=integral K_M^2=(2*M^2+1)/(3*M),
    J_M=K_M^2/c_M.

For completeness, the coefficients of K_M are 1-|j|/M for |j|<M and
zero otherwise. Orthogonality gives
`c_M=1+(2/M^2)*sum_(j=1)^(M-1) j^2>=2M/3`. Consequently J_M is
nonnegative, has mean one and finite Fourier degree D. The geometric-sum
bound and sin(pi*q)>=2q for q=||x|| in (0,1/2] give

    J_M(x)<=min(3*M/2, 3/(32*M^3*||x||^4)).

At zero use the first bound. Splitting the first moment at 1/(2M), the
near integral is at most 3/(8M), and the tail is at most
`3/(32*M^3)*(2M)^2=3/(8M)`. Hence

    integral ||x||*J_M(x)<=3/(4M),
    eta=integral_(||x||>delta) J_M(x)
       <=3/(4*M*delta)=3*delta/4<delta.                     (5)

The second inequality is the direct first-moment tail bound; M*delta^2=1.
No pointwise lower bound for J_M, infinite Fourier convergence or numerical
kernel evaluation is assumed.

Write g_a(x)=1_{||x||>=a}, and use circular convolution. The constants in
(1) satisfy 0<alpha-delta<alpha+delta<1/2. Define

    U=(J_M*g_(alpha-delta))/(1-delta),
    L=J_M*g_(alpha+delta)-delta.                             (6)

These are real finite trigonometric polynomials of degree at most D.
Convolving a bounded indicator with the finite kernel proves that directly
by finite expansion. Their pointwise bounds are

    L<=g_alpha<=U, U>=0, U-L>=0, U<=1/(1-delta).             (7)

Indeed, if ||x||>=alpha and ||s||<=delta, the circular triangle inequality
gives ||x-s||>=alpha-delta. Thus the first convolution in (6) is at least
1-eta>=1-delta, proving U>=1 on the CLOSED good set. Everywhere else
U>=0. If ||x||<alpha and ||s||<=delta, then ||x-s||<alpha+delta, so the
second convolution is at most eta and L<0. On the closed good set one
has L<=1-delta<=1. This proves (7), including ||x||=alpha; no equality
case is reassigned to an open bad arc.

Convolution preserves means. Since integral g_a=1-2a,

    integral U=(1-2*alpha+2*delta)/(1-delta),
    integral L=1-2*alpha-3*delta,
    integral(U-L)=delta*(6-2*alpha-3*delta)/(1-delta)
                 <=7*delta.                               (8)

The last inequality is equivalent to 4*delta<=1+2*alpha, which holds
since delta<1/4. The minorant L may be negative; the proof never treats
it as a probability or assumes that its products have a useful sign.

## 3. Positive block masses and relative errors

For every original label define U_i(t)=U(v_i*t), L_i(t)=L(v_i*t), and
g_i(t)=g_alpha(v_i*t). For a block B set

    G_B=product_(i in B) g_i,
    U_B=product_(i in B) U_i,
    E_B=sum_(i in B) (U_i-L_i)*product_(j in B, j!=i) U_j,
    L_B=U_B-E_B.

Then E_B>=0 and L_B<=G_B<=U_B. To prove the lower inequality, telescope
`product U_i-product g_i`; since 0<=g_i<=U_i, it is at most
`sum_i (U_i-g_i)*product_(j!=i)U_j`, which is at most E_B by (7).
This argument works even when some U_i vanishes.

Let u_B=integral U_B and d_B=integral E_B. Each positive integer time map
t->v_i*t preserves Haar probability. The union bound for the actual
common-time block indicators gives

    u_B>=integral G_B>=1-2*alpha*|B|>=1/2.                  (9)

This retains arbitrary overlap of the block's original bad sets. It
does not replace them by independent phases or invoke lower-count LRC.

Bernoulli's inequality gives

    (1-delta)^n>=1-n*delta=55/56.

Therefore any product of at most n of the U_i is at most
`(1-delta)^(-n)<=56/55<2`. Applying this bound to the other factors in
each summand of E_B, and using (8) and Haar preservation, proves

    0<=d_B<=14*|B|*delta.                                  (10)

All integrals in (9)--(10) remain on the original one-dimensional time
circle; no independence has yet been asserted.

Apply the same telescoping inequality to the nonnegative block functions
G_B<=U_B, using U_B-G_B<=E_B. Pointwise on the entire time circle,

    product_B G_B >= product_B U_B
                      -sum_B E_B*product_(C!=B) U_C.       (11)

This is a lower bound for the full original good indicator, including
every region with several bad original labels. It is not restricted to
private sets, deletion seeds or selected components.

## 4. Exact factorization and the positive common-time bound

Every polynomial term in (11) contains exactly one of U_i or U_i-L_i
for each original coordinate. After finite expansion, its multiindex r
therefore satisfies |r_i|<=D, with no extra factor n or |B|. A term
survives time integration exactly when sum_i r_i*v_i=0. Under (3) this
is equivalent to the vanishing of every block subtotal. The product of
Fourier coefficients is unchanged. Summing the same finite multiindices
thus proves

    integral product_B U_B=product_B u_B,
    integral E_B*product_(C!=B)U_C=d_B*product_(C!=B)u_C.    (12)

For the second identity, apply the argument separately to each summand
of E_B and then use linearity. Internal relations, coincident block
frequencies and their multiplicities are all retained by this expansion.
The argument identifies these particular finite polynomial integrals;
it does NOT assert independence of the unsmoothed indicators G_B.

Combining (9)--(12), with positive u_B, yields

    measure{all original norms>=alpha}
      >= product_B u_B * (1-sum_B d_B/u_B),
    sum_B d_B/u_B <= 28*delta*sum_B |B|=28*n*delta=1/2.

Since every u_B>=1/2, this proves (4). Each positive speed has only
finitely many times modulo one with ||v_i*t||=alpha. Removing their
finite union leaves the same measure, proving the strict version too.
The positive lower bound supplies one shared original witness; it does
not merely supply separate block witnesses.

The loss in the final measure may be exponential in the number of blocks.
The degree is nevertheless quadratic in n: errors are charged relative
to positive block means before taking the product. An absolute product
approximation demanding error smaller than 2^(-b) is not used.

## 5. The exact arithmetic block forced by a failure

Call a partition D-splitting when it satisfies (3). The one-block
partition always qualifies. If P and Q qualify, their common refinement
also qualifies: for a bounded zero relation r, its restriction r_B to a
P-block is itself a bounded zero relation. Splitting that relation using
Q gives zero on every intersection B intersect C. Thus a unique finest
D-splitting partition exists, as the common refinement of the finitely
many qualifying partitions.

There is a direct description that avoids artificial coupling. A nonzero
bounded zero relation r is **restriction-indecomposable** if no nonempty
proper subset S of its support satisfies sum_(i in S) r_i*v_i=0, using
those SAME coefficients. Every bounded zero relation can be decomposed
into such restrictions: if a proper zero restriction exists, both it and
the complementary restriction are nonzero zero relations on smaller
supports, so induction terminates. Coefficients are unchanged and remain
bounded by D throughout.

A partition is D-splitting if and only if every restriction-indecomposable
relation support lies in one block. In the forward direction, a support
meeting two blocks would yield a proper zero restriction. In the reverse
direction, decompose any bounded relation as above and sum its pieces
within their blocks. Consequently the connected components of the
hypergraph of THESE supports, with isolated labels included, give exactly
the finest D-splitting partition. This is not a substitution of minimal
supports allowing different coefficients.

By (4), whenever the actual global maximum mu<=alpha, at least one block
of this finest partition has

    |B|>N/4.                                                (13)

In particular (13) holds for every hypothetical strict minimal failure.
The weaker raw-support hypergraph corollary also holds: its component
partition splits every bounded relation, so some raw component has size
>N/4. However, sums of bounded relations on disjoint supports are still
bounded and can join independent blocks in the raw graph. Raw connectivity
alone does not obstruct (3). The restriction-indecomposable formulation
is the precise arithmetic conclusion used here.

## 6. Scope within finite height and the remaining minimality gap

The accepted finite-height unit obstruction provides a useful exact scope
comparison. It has n=3000=3r, r=1000, and

    D_old=90*A_n-2, A_n=n*sum_(j=0)^4 binom(n-1,j),
    B=60*D_old+1,
    V={6*B^j,10*B^j,15*B^j:0<=j<r}.

Its reviewed digit argument proves that EVERY D_old-bounded relation
splits into these triples. At this n,

    D_old>=45*n*(n-1)*(n-2)-2
          >(45/4)*n^3-2 > 6272*n^2-2=D.

Here (n-1),(n-2)>n/2 and (45/4)*3000=33750>6272. Therefore its triple
partition satisfies (3); also 4*3<=3001. The new theorem proves that
its common native-good measure is at least 2^(-1001), despite its lack
of any old-bounded unit relation and its negative fifth functional. It
already has the explicit witness t=1/4; this application demonstrates the
different certificate, rather than a new claim that the tuple is good.

The same example makes the raw-graph distinction concrete. Within every
triple, the bounded relations with coefficients (5,-3,0) and (5,0,-2)
connect all its labels. Adding copies of (5,-3,0) from two different
triples gives a bounded relation joining those triples in the raw graph.
Thus the raw graph is connected, while the triple partition still splits
every D-bounded relation. The two displayed internal supports are
restriction-indecomposable. Together with the known splitting, they show
that the finest partition is exactly the triple partition.

The bound source and its accepted review place this same tuple inside
the sharper inclusive height domain

    max(V)<=binom(n+1,2)^(n-1),

with positivity, distinctness, primitivity and every deletion gcd one.
These are previously verified source facts, not a new Lean check here.
Thus the positive theorem has a nontrivial application inside that domain;
it is not restricted to tuples that violate its height cutoff. For fixed
n, (3) is a finite coefficient condition, but it does not itself bound
the speeds or discharge the remaining all-count finite-family obligation.

Nor does height or sum smallness force the useful partition. The accepted
native-sharp control V={1,...,n} has the smallest possible sum of n distinct
positive integers, gcd one and height n. The relations 2*v_1-v_2=0 and
v_1+v_j-v_(j+1)=0 for 2<=j<n are restriction-indecomposable and bounded
by 2. Their supports connect all labels. Its finest partition at D is
therefore one block. The usual shortest-gap proof on 0,t,...,nt gives
mu<=1/(n+1), and t=1/(n+1) attains equality. This is native-GOOD and
does not have strict failure; it shows why (13), even with absolute minimum
sum, cannot be promoted to a contradiction without using strict failure.

The current positive theorem is a real global sufficient mechanism: small
arithmetic blocks synchronize through exact bounded Fourier factorization
and relative error. It bypasses unit extraction and the false universal
positivity of the fifth functional. It neither assumes a sign for each
relation nor repairs only single-bad regions.

The FIRST UNRESOLVED inference for an actual minimum failure is any
justified use of its complete replacement conditions to split or otherwise
control the large restriction-indecomposable block in (13). No step in
this proof uses those conditions to make that block smaller. Knowing LRC
for its proper subtuples only supplies separate times and does not restore
(12) across an unsplit block. Nor does a bounded relation alone supply
an admissible lower-sum tuple with failure preserved at every time.
The progression control refutes a version based on minimum sum and height
alone; it does not refute a new argument using actual strict failure.

The settled proof contract is (1)--(4) and the precise consequence (13).
There is no supported next minimality lemma ready for implementation.
Retain this positive theorem for independent review, but defer new Lean
Fourier infrastructure until a concrete use of the large-block restriction
in the unresolved case is available. This is an honest application gap,
not a claim that every possible block-based approach fails. The full
unrestricted LRC objective remains unresolved.

## 7. Evidence and checks

The complete frozen global-transport source and review, and finite-height
unit-obstruction source and review, were read. Their scopes above are
preserved. The envelope/product proof was proposed by root and independently
checked here; both routes identified the restriction-indecomposable
characterization. All displayed new derivations are hand mathematics.

Current config, workflow, policy and focused state were read, including
after compaction. The gate is research/in_progress with explicit start
authorization `2026-09-05T04:12:25.208107+00:00`. The command
`python3 -B scripts/validate_workflow.py` passed at startup and after
compaction; it checks structure only. Final full owned readback, actual
input hashes, whitespace/final newline and final workflow validation are
checked at handoff; the frozen manuscript hash is reported separately.

Only administrative text/hash/workflow checks were run. No mathematical
program, enumeration, solver, local build, dependency/cache operation,
new agent, external model, Git/shared-state/memory write or other-file
change was made. Unknown runtime metadata remains null. New mathematics
awaits an independent review; this document does not accept itself.

| Bound input | SHA-256 |
| --- | --- |
| `research/astra-uniform-global-transport-strategy.md` | `c6d433ea553cc5507a0faa97387fba75108d15bece45ac14489c879c2078d618` |
| `research/astra-uniform-global-transport-strategy-review.md` | `5eb21ae36164e68f29ac1ce0f70ca897cbfe558165cc90d8a2de3ee982ca98f7` |
| `research/astra-finite-height-unit-obstruction.md` | `0c6c83bdd2188576121391b0e232486a4af259580d842c850111581ca87c55e0` |
| `research/astra-finite-height-unit-obstruction-review.md` | `64809ab4ac32f5991fa65587ff79c938ee4860bb5a4f4ccfa92a52c2a5fd9183` |
| `.codex/config.toml` | `28212a53cf42cdc377df1f7dab040732d657e59d7bb97ee78791256d01d4bb2c` |
| `docs/project-workflow.md` | `2b42a133352b6b53ba2106fc73882733f176e04a0deffbb183b4c16eefd9cd67` |
| `research/workflow-policy.json` | `833c397b61d1ffdb994fb115019f6d60d6c1a62ff85f19cdd2c9f8ac3a979c8b` |
| `scripts/validate_workflow.py` | `250a3ce2a080f5835ac4fd2e4b2803568424c777cda5d421f9fe92efd34d5383` |
