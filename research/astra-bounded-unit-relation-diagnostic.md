# The fifth Fourier signature does not force bounded unit coefficients

Task `/root/bounded_unit_relation_diagnostic`; assigned checkpoint
`76a0ee0f467161e1b6a14794381333fdf2b95850`. Requested route:
`gpt-6-astra/xhigh`; observed model, effort, elapsed time and usage: null.
Only this manuscript is owned. The block construction and its finite-error
bound were proposed by root and checked here by hand. Independent review
is required; no new Lean theorem or unrestricted LRC result is claimed.

**Disposition.** At the fixed moving count n=5000, primitive native-good
integer tuples satisfy the FULL failure-derived fifth Fourier inequality,
and every deletion complement has gcd one, while their unit-coefficient
relations require arbitrarily large coefficients. Thus those necessary
conditions alone cannot supply a unit relation bounded only by n, even
without a support restriction. This refutes the proposed signature-only
extraction, not an implication using actual strict failure and minimality.

## 1. Exact signature being tested

Use the bound source's notation and its specific smoothing kernel:

    N=n+1, alpha=1/N, p=2/N,
    A_n=n*sum_(j=0)^4 binom(n-1,j),
    M=45*A_n, D=D_n=2*(M-1),
    g(t)=1_{||t||<alpha}, f=J_M*g,
    P_5(z)=sum_(J subset [n], |J|<=5) (-1)^|J| product_(i in J) z_i.

Here T=R/Z carries normalized Haar measure. The accepted source proves

    0<=f<=1, integral f=p, degree(f)<=D,
    ||f-g||_1<=3/(2M),
    S_5=sum_(j=0)^5 (-1)^j binom(n,j)*p^j > 1/15  (n>=6),
    integral_T P_5(f(v_i*t):i)=S_5+Gamma_v.                 (1)

Gamma_v is exactly its finite signed sum over all nonzero resonant
frequency choices in subsets of size at most five. Zero coordinates and
occurrences of the same support inside different subsets are retained.
Its failure-derived inequality, source (12), is

    Gamma_v <= 1/30-S_5 < -1/30.                           (2)

The issue is whether (2) forces a relation with support at most five,
coefficients bounded by D, and some coefficient +1 or -1. The original
bounded-relation theorem does not assert this extra unit condition.

## 2. A symbolic family with no bounded unit relation

Fix r=2500, n=2r=5000 and the corresponding D above. For ANY integer
H>=D, put

    B=30H+1,
    V_H={2*B^j,3*B^j : 0<=j<r}.                           (3)

These are distinct positive integers: 2*B^j<3*B^j<2*B^(j+1).
Their gcd is one because the first block is (2,3). The base is kept
symbolic; no large integer list or numerical search is needed.

**Digit lemma.** Every integer relation on V_H with all coefficients of
magnitude at most H has the form

    c_j=3h_j, d_j=-2h_j  for every j,                      (4)

where c_j multiplies 2*B^j and d_j multiplies 3*B^j.

Indeed put z_j=2c_j+3d_j, so |z_j|<=5H. If J is the greatest index with
z_J!=0, its term has magnitude at least B^J, whereas all earlier terms
have total magnitude at most

    5H*sum_(j=0)^(J-1) B^j
        =5H*(B^J-1)/(B-1)=(B^J-1)/6 < B^J.

This contradicts sum_j z_j*B^j=0, including J=0 with empty earlier sum.
Thus all z_j=0; coprimality of 2 and 3 gives (4). No nonzero coefficient
in such a relation can be +1 or -1. This conclusion holds with unrestricted
support, and hence in particular with support at most five and bound D.
The primitive relation (3,-2) within each block is fully consistent with
the original detector; primitive coefficients need not contain a unit.

**Native witness.** Since B=1 modulo 5, at t=1/5 every speed in (3) has
circle norm 2/5>alpha. In fact the tuple's actual maximum is exactly 2/5.
For the first pair, ||2t||>=2/5 restricts t modulo one to
[1/5,3/10] union [7/10,4/5]; intersecting with ||3t||>=2/5 leaves only
t=1/5 or 4/5. Both work for every block, so no larger common norm is
possible. Continuity also supplies an open interval of strict native
witnesses. This family is never a canonical strict failure.

## 3. Exact finite Fourier factorization across blocks

For a subset of original labels of size at most five, expand its product
of f(v*t) into finite Fourier modes. Every coordinate frequency has
magnitude at most D<=H. By the digit lemma a mode survives one-time
integration exactly when 2c_j+3d_j=0 separately for each block, taking
the frequency of an omitted label to be zero. These are precisely the
conditions for integration with independent block times t_0,...,t_(r-1).
The Fourier coefficients of each surviving term are unchanged. Therefore

    integral_T P_5(f(v*t):v in V_H)
      = integral_(T^r) P_5(f(2t_j),f(3t_j):0<=j<r).         (5)

This is an equality for the specified finite polynomials. It does NOT
assert independence of the original unsmoothed one-time indicators,
whose arbitrarily large Fourier frequencies can have carries.

For one independent block the indicator means are both p and

    q=integral_T g(2t)*g(3t)=2alpha/3=p/3.                 (6)

To verify (6), their bad arcs have centers {0,1/2} and {0,1/3,2/3},
and radii alpha/2 and alpha/3. Distinct centers have circular separation
at least 1/6, exceeding the sum 5alpha/6 because alpha<1/5. Only the
coincident center zero contributes; its intersection has radius alpha/3.
Endpoints are null sets throughout this integral calculation.

Consequently the generating polynomial for one block's intersection
moments is 1-2p*z+q*z^2. Let T_r be the sum of coefficients of degrees
zero through five in

    (1-2p*z+(p/3)*z^2)^r.

Independence of the block times makes T_r exactly the integral of P_5
for their 2r indicators, including every subset and its multiplicity.

## 4. A finite hand bound for the full signed quantity

Select s blocks contributing the linear term and d contributing the
quadratic term, where s+2d<=5; set k=s+d. The contribution to T_r is

    C_(s,d)*eta_k,
    C_(s,d)=(-2)^s*(1/3)^d/(s!*d!),
    eta_k=(r)_k*[2/(2r+1)]^k
         =product_(h=0)^(k-1) [1-(2h+1)/(2r+1)].           (7)

This follows directly from the multinomial coefficient
(r)_k/(s!*d!) and q=p/3. Empty products are one. For r>=5 and k<=5,
all factors lie in [0,1], and the elementary product bound gives

    0<=1-eta_k<=sum_(h=0)^(k-1) (2h+1)/(2r+1)
                =k^2/(2r+1)<=25/(2r+1).                 (8)

The reference finite sum is exactly

    sum_(s+2d<=5) C_(s,d)
      =sum_(s=0)^5 (-2)^s/s!
         +(1/3)*sum_(s=0)^3 (-2)^s/s!
         +(1/18)*sum_(s=0)^1 (-2)^s/s!
      =1/15-1/9-1/18=-1/10.

The corresponding absolute sum is

    109/15+19/9+1/6=859/90<10.

Equations (7)-(8) therefore give, at r=2500,

    |T_r+1/10| < 250/(2r+1)=250/5001<1/20,
    T_r < -1/20.                                         (9)

No limiting independence assertion or numerical evaluation of T_r is
used; (9) is a bound on the displayed finite polynomial.

On the block torus, each individual map t_j -> 2t_j or 3t_j preserves
Haar measure. Telescoping products of [0,1]-valued functions bounds the
error for any subset J by |J|*||f-g||_1, even when both labels come
from one block. Thus the SAME exact source counting factor gives

    |integral_(T^r) P_5(f(2t_j),f(3t_j):j)-T_r|
      <= [sum_(l=1)^5 l*binom(n,l)]*3/(2M)
      =A_n*3/(2M)=1/30.                                  (10)

Combining (5), (9), (10), and (1) proves

    integral_T P_5(f(v*t):v in V_H) < -1/60,
    Gamma_(V_H) < -1/60-S_5 < 1/30-S_5.                   (11)

In particular Gamma_(V_H)<-1/12<-1/30. The important comparison in
(11) is with the FULL source inequality (2), not only its weaker last
bound. This exact finite signature is independent of H, because the
block factorization uses the same fixed n, D and kernel for every H.

## 5. Deletion gcds and the genuine minimality distinction

For completeness, the least-count deletion-gcd consequence is already
Proposition 1 and Corollary 2 of the bound divisor-minimality manuscript.
Here is its primitive specialization with the correct translated-grid
margin. In a primitive least-count strict failure with n>=6, delete v_i
and put d=gcd(V without v_i). If d>1, primitivity gives gcd(v_i,d)=1.
Least count supplies a time t with every retained norm at least 1/n.
All shifts t+k/d preserve those norms. The exceptional phases form a
translated d-point equally spaced grid. One is within 1/(2d) of 1/2,
and hence has norm at least

    (d-1)/(2d)>=1/4>alpha.

Together with the retained margins this contradicts original failure.
Thus every deletion gcd is one. The translated-grid guarantee is
(d-1)/(2d); floor(d/2)/d would assume a favorable translation.
The existing generic Lean declaration
`exists_nat_shift_preserving_divisible_family` preserves ALL retained
norms and supplies the exceptional quarter-margin, while
`exists_nat_rational_shift_circleNorm_ge_mesh` provides the exact reduced
orbit bound. No new shift infrastructure or fresh compile is needed here.

The control (3) satisfies this necessary gcd condition too. Deleting 2
leaves 3 and 2B, whose gcd is one because B=1 modulo 3; deleting 3 leaves
2 and 3B, whose gcd is one because B is odd. Any other deletion retains
2 and 3. Bezout therefore supplies a relation with a unit on any chosen
coordinate, but supplies no coefficient bound depending only on n. For
example the first two blocks already have

    2 + (20H)*3 - 2B = 0,                                (12)

a support-three unit relation whose coefficient 20H exceeds H. Equation
(4) proves that every unit relation must exceed H somewhere, not merely
that this example does. Given ANY proposed finite bound depending only
on n, choose an integer H at least that bound at n=5000 and at least D.
Then (2) and all deletion gcds still hold, but no unit relation within
the proposed bound exists, even with unrestricted support.

**First unresolved implication.** Actual least-count and all-admissible
minimum-sum strict failure have not been used to deduce a unit relation
of controlled size, or an all-time transport along the nonunit relation
already detected. The present native-good controls do not refute an
implication with those full hypotheses. They do rule out replacing those
hypotheses by (2), even supplemented by every deletion gcd being one.
Keep that signature-only extraction on hold; even a separately supplied
unit relation would still require common-time witness/failure transport.
The source bounded nonzero-relation theorem remains intact.

## 6. Bindings and checks

The setup gate was open (`research` / `in_progress`) with recorded start
authorization; only root owns workflow state. Inputs were read and
hash-bound below. Startup and post-compaction workflow validation passed
(receipts `0bd743`, `ca46e2`), certifying structure only. All mathematics
above was derived by hand. Full source readback (`376cb5`, `d17e18`),
verification of all nine input hashes and whitespace (`9f5955`), and
workflow validation (`a57a25`) passed before freezing. No mathematical
programs or numerical searches, builds, cache operations, new agents,
external models, Git or shared-state edits were used. Runtime accounting
remains null; independent mathematical acceptance is a separate step.

| Input | SHA-256 |
| --- | --- |
| `research/astra-uniform-global-transport-strategy.md` | `c6d433ea553cc5507a0faa97387fba75108d15bece45ac14489c879c2078d618` |
| `research/astra-uniform-global-transport-strategy-review.md` | `5eb21ae36164e68f29ac1ce0f70ca897cbfe558165cc90d8a2de3ee982ca98f7` |
| `research/astra-uniform-divisor-minimality.md` | `8c4b6ee094f0f311f360d3abf371e95f731e28cee997d3810dd3218ff6f25746` |
| `LonelyRunner/RationalShiftGcd.lean` | `6e9d1e3e084188a651e4c875cf36fd5d6fc7cbd5f1914784019a207a0cec01f4` |
| `LonelyRunner/RationalShiftInsertion.lean` | `6ab6e77e8f5edcdc2a2d242fb2616327004b376496616f46896303a06876db23` |
| `.codex/config.toml` | `28212a53cf42cdc377df1f7dab040732d657e59d7bb97ee78791256d01d4bb2c` |
| `docs/project-workflow.md` | `2b42a133352b6b53ba2106fc73882733f176e04a0deffbb183b4c16eefd9cd67` |
| `research/workflow-policy.json` | `833c397b61d1ffdb994fb115019f6d60d6c1a62ff85f19cdd2c9f8ac3a979c8b` |
| `scripts/validate_workflow.py` | `250a3ce2a080f5835ac4fd2e4b2803568424c777cda5d421f9fe92efd34d5383` |
