# Independent review: positive transport across splitting blocks

Task `/root/positive_block_transport_review`; review checkpoint
`52758d2e85ca73f7daa1b579dc55dc8dc69c193a`. The author was assigned from
`fdf2ae4d56727f6fb007aa34eabb909de4eebe55`. Requested route:
`gpt-6-astra/xhigh`; observed model, effort, elapsed task time and usage:
null. Only this review is owned.

**Disposition: accept the complete frozen manuscript without correction.**
The theorem supplies one full-label good set of measure at least
2^(-b-1)>0 under its exact all-support splitting and block-size hypotheses.
The strict-good version and the large finest-block consequence also hold.
No actual minimal-failure argument establishing or replacing the required
block-size bound is supplied. This is independent manuscript acceptance,
not a kernel result or unrestricted LRC resolution.

## Exact contract and buffered boundaries

Let n>=6, v_1,...,v_n be positive integers, N=n+1, alpha=1/N, and

    delta=1/(56n), M=(56n)^2, D=2(M-1)=6272n^2-2.

Let P partition all n original labels into b nonempty blocks, with
4|B|<=N for each block. The hypothesis is that every integer vector r
with |r_i|<=D and sum_i r_i*v_i=0 has zero subtotal on every block.
There is no support restriction. This precise rectangular coefficient
bound is essential; checking only short supports is not the theorem.
Distinctness, gcd one and either minimality are not needed here.

The normalized square Fejer kernel has mean one, is nonnegative and has
degree D. Its coefficient normalization is
c_M=(2M^2+1)/(3M)>=2M/3. Combining K_M<=M and
K_M(x)<=1/(4M||x||^2) gives

    J_M(x)<=min(3M/2,3/(32M^3||x||^4)).

Splitting the first moment at 1/(2M) gives at most 3/(8M) from each
side of that split after both halves of the circle are included. Thus
integral ||x||*J_M(x)<=3/(4M). These kernel facts hold for the present
integer M, not only the earlier source's choice 45A_n. With
eta=integral_(||x||>delta) J_M(x), the first-moment bound yields

    eta<=3/(4M*delta)=3delta/4<delta,

since M*delta^2=1. Also 0<alpha-delta<alpha+delta<1/2 and 0<delta<1/4.

Use the closed good indicator g_a(x)=1_{||x||>=a} and set

    U=(J_M*g_(alpha-delta))/(1-delta),
    L=J_M*g_(alpha+delta)-delta.

Both are real finite polynomials of degree at most D: expand the finite
kernel before integrating the bounded indicator. If ||x||>=alpha and
||s||<=delta, then ||x-s||>=alpha-delta. The numerator of U is therefore
at least 1-eta>=1-delta, so U>=1 on the entire CLOSED good set. If
||x||<alpha and ||s||<=delta, then ||x-s||<alpha+delta; the convolution
defining L has value at most eta, and L<0. Everywhere L<=1-delta, while
U is nonnegative and at most 1/(1-delta). Consequently

    L<=g_alpha<=U, U-L>=0.

This proves the envelopes at ||x||=alpha without changing its good-set
membership. Points at the smoothing radius ||s||=delta are included in
the controlled part; the strict tail definition and closed indicator
are consistent. L can be negative and is not treated as a probability.

The exact means give

    integral U=(1-2alpha+2delta)/(1-delta),
    integral L=1-2alpha-3delta,
    integral(U-L)=delta*(6-2alpha-3delta)/(1-delta)<=7delta.

The last comparison is precisely 4delta<=1+2alpha, which holds here.

## Products, relative errors and one original time

For each original label compose U,L,g_alpha with v_i*t. Within a block,
let G_B be the product of the g_i, U_B the product of the U_i, and

    E_B=sum_(i in B) (U_i-L_i)*product_(j in B, j!=i) U_j.

All U_i and E_B are nonnegative. Since 0<=g_i<=U_i, telescoping gives

    0<=U_B-G_B
      <=sum_(i in B)(U_i-g_i)*product_(j!=i)U_j<=E_B.

This uses no division by U_i and remains valid at its zeros. Thus the
block minorant U_B-E_B is legitimate even when negative. In particular,
the proof does not multiply the possibly negative scalar or block
minorants to obtain a claimed lower bound.

Put u_B=integral U_B and d_B=integral E_B. Integer multiplication
preserves Haar probability. The actual block union bound, with no
independence assumption, proves

    u_B>=integral G_B>=1-2alpha|B|>=1/2.

Bernoulli's inequality gives (1-delta)^n>=1-n*delta=55/56. Therefore a
product of at most n of the U_i is bounded above by 56/55<2. Apply that
bound only to the other factors of each nonnegative error summand and
use the mean of U_i-L_i. This yields

    0<=d_B<=14|B|delta.

These are bounds on the original time circle, including arbitrary
dependence within the block. No separate block LRC theorem is invoked.

Telescoping once more at block level proves pointwise

    product_B G_B >= product_B U_B
                       -sum_B E_B*product_(C!=B) U_C.

This lower bound covers every time and every bad-label multiplicity.
It need not be nonnegative pointwise. Its positive integral will provide
the full original witness; no deletion or private-set domain is used.

In each summand on its right side, every original coordinate occurs
exactly once as U_i or U_i-L_i. Each such factor has degree at most D
in its own argument. Hence a finite Fourier term has |r_i|<=D for
each label, despite potentially large total frequency in the time t.
There is no extra factor n or |B| in that coefficient bound.

Under the splitting hypothesis, the full frequency sum is zero exactly
when all its block subtotals are zero. The latter conditions are those
in the product of the separate block integrals, with the same finite
coefficient products and internal multiplicities. It follows that

    integral product_B U_B=product_B u_B,
    integral E_B*product_(C!=B) U_C=d_B*product_(C!=B)u_C.

The second identity is obtained for each summand of E_B and then summed.
This establishes the particular smoothed factorizations at one original
time; it does not assert independence of the unsmoothed block indicators.

All u_B are positive, so integration and division by those means give

    measure{all ||v_i*t||>=alpha}
      >=product_B u_B*(1-sum_B d_B/u_B),
    sum_B d_B/u_B<=28delta*sum_B |B|=28n*delta=1/2.

Thus the measure is at least 2^(-b-1), a strictly positive quantity.
The claim is >= this bound, not a strict inequality against this bound.
Each positive integer speed has only finitely many times modulo one
with norm exactly alpha. Removing their finite union leaves the same
measure and makes every inequality strict. In particular the continuous
full minimum has actual global maximum greater than alpha.

## Finest splitting partition and exact failure consequence

The one-block partition always splits. If P,Q split and r is a bounded
zero relation, its restriction to any P-block remains a bounded zero
relation. Applying Q-splitting to that restriction gives zero on each
nonempty P/Q intersection. Thus common refinement preserves splitting.
There are finitely many partitions, so their qualifying common refinement
exists and is the unique finest splitting partition.

The restriction-indecomposable definition keeps the coefficients of one
relation fixed: no nonempty proper subset of its support has zero
subtotal. Every nonzero bounded relation decomposes into disjoint
restriction-indecomposable zero restrictions by induction on support size.
A proper zero restriction and its complement are nonzero, have smaller
supports and retain the original bounded coefficients. The zero relation
requires no pieces. No replacement coefficients or primitive normalization
are used in this decomposition.

For a splitting partition, an indecomposable support cannot meet two
blocks: its intersection with one would be a forbidden proper zero
restriction. Conversely, if every indecomposable support lies in a
block, decomposing any relation as above makes every block subtotal a
sum of zero pieces. Hence the partition splits. Its finest form is
exactly the components of the hypergraph of these supports, including
isolated labels. This is not the minimal-support relation hypergraph
obtained by allowing different coefficients.

If the actual global maximum mu<=alpha, every block of the finest
partition cannot satisfy 4|B|<=N, because the proven strict-good theorem
would give mu>alpha. Therefore some finest block has |B|>N/4. Equality
mu=alpha is included in this necessary conclusion; strict failure is
not required for it.

The raw-support hypergraph also gives a splitting partition, since each
relation's entire support lies in one of its components. Its corresponding
large-component consequence is weaker. Sums of relations on disjoint
supports remain coefficient-bounded and may create raw edges between
blocks that still split every relation. Raw connectivity therefore does
not substitute for the restriction-indecomposable conclusion.

## Both controls and the actual unresolved implication

For the accepted finite-height tuple with n=3000, let
D_old=90A_n-2, B=60D_old+1 and use the triples (6B^j,10B^j,15B^j).
Its previously checked digit proof splits every D_old-bounded relation
into these triples. Independently checking the comparison gives

    D_old>=45n(n-1)(n-2)-2
          >(45/4)n^3-2>6272n^2-2=D,

because A_n includes n*binom(n-1,2), (n-1),(n-2)>n/2, and
(45/4)*3000=33750>6272. Thus the same triples split at the new bound D.
Each has 4|B|=12<=3001; b=1000 gives native-good measure at least
2^(-1001). This is compatible with its earlier negative fifth functional
and lack of old-bounded unit relations: the new positive certificate
uses the buffered full-label product, not that fifth functional.

The internal relations (5,-3,0) and (5,0,-2) are bounded and
restriction-indecomposable; each has two nonzero entries and neither
singleton has zero subtotal. They connect every triple internally.
Since the triple partition splits, its finest refinement cannot merge
triples; since these internal supports cannot be cut, it cannot split
one. The finest partition is exactly the triples. Meanwhile adding
copies of (5,-3,0) from two different triples gives a bounded raw edge
joining them. All labels are therefore in one raw component. This
checks the claimed distinction on the same actual admissible tuple.

The frozen finite-height source and accepted review already establish
positivity, distinctness, primitivity, all deletion gcds one and
max(V)<=binom(n+1,2)^(n-1) for this tuple. Their unchanged evidence is
reused. This is membership in the inclusive tuple domain, not a proof
of the all-count finite-family proposition. The present theorem neither
requires nor derives a general speed-height bound.

For V={1,...,n}, the relation 2*v_1-v_2=0 and the relations
v_1+v_j-v_(j+1)=0 for 2<=j<n all have coefficients bounded by two.
The former has indecomposable support two. In each latter relation,
no singleton subtotal vanishes; the three pair subtotals are respectively
j+1, -j and -1, all nonzero. Thus these are restriction-indecomposable
supports and together connect every label, giving one finest block.
The tuple has gcd one, height n and the smallest possible sum of n
distinct positive integers. Its actual maximum is alpha: a shortest
gap among 0,t,...,nt gives the upper bound, and t=1/(n+1) attains it.
It is a native-good equality control, not a strict-failure example.

The first actual gap is a use of full strict failure and complete
minimum-count/minimum-sum replacement conditions to bound or otherwise
control a finest block larger than N/4. The construction of the finest
partition proves its existence, not that its blocks are small. The
positive theorem uses none of those replacement conditions. Even
absolute minimum sum and small height alone cannot give the needed
size bound, as the progression shows. Knowing proper subtuple LRC
provides separate times; it does not establish the missing splitting
equations or the displayed full-label factorization across a coupled
block. No all-time smaller-tuple failure transport is obtained either.

Thus this is a valid global sufficient mechanism with a precise new
necessary arithmetic restriction, but no contradiction for actual
minimal failure. It does not refute every possible continuation using
strict failure. Deferring new Fourier implementation until such a
continuation is supplied is a strategic choice, not a claim that the
manuscript theorem or every block approach fails.

## Bindings and checks

The complete frozen author was read. All new envelope, error, product,
partition and comparison arguments above were checked independently by
hand. The four mathematical input files were previously read completely
and accepted at their exact scopes in this same review route; their
unchanged hashes were checked here. No earlier numerical evidence or
Lean check was replayed.

Current config, workflow, policy and focused state were read. The gate
is research/in_progress with explicit start authorization
`2026-09-05T04:12:25.208107+00:00`. The command
`python3 -B scripts/validate_workflow.py` exited zero with
`workflow structural validation passed; it cannot certify mathematical validity.`
The table binds the frozen author and all eight of its inputs. Final full
review readback, all hashes and exact input-set equality, final newline,
whitespace and final workflow validation are checked at handoff. The
frozen review hash is returned separately.

Only this owned review was written. No mathematical program, enumeration,
solver, local build, dependency/cache operation, new agent, external
model, Git/shared-state/memory write or other-file edit was performed.
The author was preserved, and no correction was requested. Unknown
runtime model, effort, time and usage remain null.

| Bound source | SHA-256 |
| --- | --- |
| `research/astra-positive-block-transport.md` | `ced2c8cfac1bcc529e73a5ee8eef4af3595d30ebfa7db49273aa3ebd6f39f232` |
| `research/astra-uniform-global-transport-strategy.md` | `c6d433ea553cc5507a0faa97387fba75108d15bece45ac14489c879c2078d618` |
| `research/astra-uniform-global-transport-strategy-review.md` | `5eb21ae36164e68f29ac1ce0f70ca897cbfe558165cc90d8a2de3ee982ca98f7` |
| `research/astra-finite-height-unit-obstruction.md` | `0c6c83bdd2188576121391b0e232486a4af259580d842c850111581ca87c55e0` |
| `research/astra-finite-height-unit-obstruction-review.md` | `64809ab4ac32f5991fa65587ff79c938ee4860bb5a4f4ccfa92a52c2a5fd9183` |
| `.codex/config.toml` | `28212a53cf42cdc377df1f7dab040732d657e59d7bb97ee78791256d01d4bb2c` |
| `docs/project-workflow.md` | `2b42a133352b6b53ba2106fc73882733f176e04a0deffbb183b4c16eefd9cd67` |
| `research/workflow-policy.json` | `833c397b61d1ffdb994fb115019f6d60d6c1a62ff85f19cdd2c9f8ac3a979c8b` |
| `scripts/validate_workflow.py` | `250a3ce2a080f5835ac4fd2e4b2803568424c777cda5d421f9fe92efd34d5383` |
