# Bounded unit extraction still fails inside the sharper height cutoff

Task `/root/finite_height_unit_obstruction`; assigned checkpoint
`76a0ee0f467161e1b6a14794381333fdf2b95850`. Requested route:
`gpt-6-astra/xhigh`; observed model, effort, elapsed time and usage: null.
Only this manuscript is owned. Root proposed the three-speed construction
and bounds; they are checked here by hand. Independent review is required.
No new Lean theorem or unrestricted LRC result is claimed.

**Result.** One explicit symbolic tuple satisfies the full fifth Fourier
signature, positivity, distinctness, primitivity, every deletion gcd being
one, and the current sharper canonical height cutoff. It has no relation
with a unit coefficient and all coefficients bounded by D_n, even allowing
unrestricted support. It is nevertheless strictly native-good. Thus adding
the cutoff does not rescue extraction from those listed necessary
conditions. This does not refute extraction using actual least-count and
minimum-sum failure, or exclude every possible count-dependent unit bound.

## 1. Exact cutoff and signature contracts

Write n>=6 for moving count, N=n+1, alpha=1/N, and

    C=binom(n+1,2),
    A_n=n*sum_(j=0)^4 binom(n-1,j),
    M=45*A_n, D=D_n=2*(M-1), p=2/(n+1).

The source-level contract of
`primitive_sorted_largeHeight_stationary_lonelyAt` assumes
`LowerCountPositiveIntegerHypothesis (m+2)`, m>=1, and a strictly
increasing natural tuple s on m+2 labels with s(0)=0 and gcd(s)=1.
A height strictly greater than binom(m+2,2)^m supplies a positive-time
closed witness for the stationary label. With m=n-1, its contrapositive
under genuine least-count stationary failure is precisely

    max(V) <= C^(n-1).                                    (1)

This is the sharper stationary cutoff, not the older doubled-base cutoff
for arbitrary distinguished labels. The definition
`SharperInclusivePrimitiveFiniteFamily (n-1)` uses the inclusive domain
(1), together with the sorted-zero and primitive conditions, and requires
a witness for EVERY distinguished label of EVERY tuple in that domain.
The theorem `conjecture_iff_allSharperInclusivePrimitiveFiniteFamilies`
quantifies over every such count. The all-count finite-family supply is
still an obligation. Membership of one tuple in its domain proves neither
that supply nor any failure property. No kernel check is rerun here.

For the signature use exactly the positive kernel f=J_M*g from the bound
global-transport source, with g(t)=1_{||t||<alpha} on T=R/Z. Its established
properties, for normalized Haar measure, are

    0<=f<=1, integral f=p, degree(f)<=D,
    ||f-g||_1<=3/(2M),
    P_5(z)=sum_(J subset [n], |J|<=5) (-1)^|J| product_(i in J) z_i,
    S_5=sum_(l=0)^5 (-1)^l binom(n,l)*p^l > 1/15,
    integral_T P_5(f(v*t):v in V)=S_5+Gamma_V.              (2)

Gamma_V is the full finite resonant correction, including zero frequency
coordinates and every subset occurrence. The exact failure-derived
inequality audited here is source (12):

    Gamma_V <= 1/30-S_5 < -1/30.                           (3)

## 2. Three-speed blocks and absence of bounded unit relations

Fix r=1000 and n=3r=3000. For the corresponding D in (2), set

    B=60D+1,
    V={6*B^j,10*B^j,15*B^j : 0<=j<r}.                    (4)

The increasing order within and between blocks follows from
6<10<15<6B. The first block has gcd one, so V is primitive.

Every deletion also has gcd one. If a first-block label is deleted, the
gcd of the other two first-block labels is respectively 5, 3, or 2.
The complete second block has gcd B, and B=1 modulo 30 is coprime to
each of these three numbers. If a later label is deleted, the complete
first block remains. These statements concern the actual original labels.

Suppose integer coefficients c_j,d_j,e_j, all of magnitude at most D,
satisfy a relation on (4). Put z_j=6c_j+10d_j+15e_j, so |z_j|<=31D.
If J is the greatest index with z_J!=0, the leading magnitude is at
least B^J, while the earlier total magnitude is at most

    31D*(B^J-1)/(B-1)=(31/60)*(B^J-1)<B^J.

Hence every digit z_j vanishes. Reducing
6c_j+10d_j+15e_j=0 modulo 5, 3, and 2 respectively proves

    5 divides c_j, 3 divides d_j, 2 divides e_j.           (5)

No coefficient can be +1 or -1. This proof has no support restriction;
it in particular excludes the proposed support-at-most-five unit relation
with coefficient bound D. Nonunit bounded relations such as
5*(6B^j)-3*(10B^j)=0 remain, as the original detector permits.

At t=1/4, B=1 modulo 4 gives block norms (1/2,1/2,1/4).
Thus every original norm is at least 1/4>alpha, with an open interval of
strict native witnesses by continuity. No actual strict failure is
asserted. In particular, no original speed is divisible by 4; the other
necessary small-denominator failure conditions have not been imposed.

## 3. Exact block moments and finite Fourier compatibility

For positive integers a,b, noncoincident grid centers k/a,l/b have
circular separation at least gcd(a,b)/(ab). Their alpha-arc radii sum
to alpha*(a+b)/(ab). Thus when alpha<gcd(a,b)/(a+b), only coincident
centers can contribute to the intersection of the two bad sets. There
are gcd(a,b) such centers, each with intersection radius
alpha/max(a,b). For the three pairs in (6,10,15), the required upper
bounds on alpha are 1/8, 1/7, and 1/5, all satisfied by alpha=1/3001.
Consequently

    integral g(6t)*g(10t)=p/5,
    integral g(6t)*g(15t)=p/5,
    integral g(10t)*g(15t)=p/3.                            (6)

If all three bad arcs contain a time, their pairwise centers must
coincide by the same argument. The three grids have only center zero
in common modulo one because gcd(6,10,15)=1. The smallest radius there
is alpha/15. Therefore

    integral g(6t)*g(10t)*g(15t)=p/15.                    (7)

All endpoints have measure zero. The moment-generating polynomial for
one independent block is exactly

    F(z)=1-3p*z+(11p/15)*z^2-(p/15)*z^3.                  (8)

For finite products of the smoothed f over at most five original labels,
the frequency on each coordinate is bounded by D. The digit argument
above says that a mode survives one-time integration exactly when each
block relation 6c_j+10d_j+15e_j=0 holds, with omitted frequencies zero.
This is exactly the integration condition for independent block times.
The coefficients agree term by term, so

    integral_T P_5(f(v*t):v in V)
      =integral_(T^r) P_5(f(6t_j),f(10t_j),f(15t_j):j).    (9)

Only finite Fourier moments are being identified. No independence of
the original unsmoothed one-time indicators is assumed.

## 4. Full fifth integral with a finite error bound

Let T_r be the sum of coefficients of degrees zero through five in
F(z)^r. By independence across block times it is the integral of P_5
for the block indicators, retaining every subset and multiplicity.
Selecting s linear terms, d quadratic terms and t cubic terms gives
s+2d+3t<=5 and k=s+d+t<=5, with contribution

    L_(s,d,t)*eta_k,
    L_(s,d,t)=(-2)^s*(22/45)^d*(-2/45)^t/(s!*d!*t!),
    eta_k=product_(h=0)^(k-1)(1-h/r)*[3r/(3r+1)]^k.       (10)

This is the multinomial expansion of (8), using p=2/(3r+1).
For r>=5 all factors are in [0,1], and

    0<=1-eta_k<=k*(k-1)/(2r)+k/(3r+1)<=k^2/(2r).         (11)

The finite reference sum of L_(s,d,t) is the degree-five truncation
of exp(-2z+(22/45)z^2-(2/45)z^3), evaluated at z=1. This identifies a
finite coefficient sum; no limiting assertion is needed. Set
U_j=sum_(s=0)^j (-2)^s/s!. The possibilities for (d,t) give

    sum L = U_5+(22/45)*U_3+(242/2025)*U_1
                    -(2/45)*U_2-44/2025
          =1/15-22/135-242/2025-2/45-44/2025
          =-571/2025.                                    (12)

Replacing all terms by their absolute values gives

    sum |L| = 109/15+418/135+726/2025+2/9+44/2025
            =22205/2025<11.                              (13)

Thus, at r=1000, (11)-(13) imply

    |T_r+571/2025|<275/(2r)=11/80,
    T_r<-1/10.                                           (14)

For the last comparison, 571/2025>1/4, so the upper bound is strictly
less than -1/4+11/80=-9/80<-1/10. These are exact hand inequalities.

On the block torus, integer multiplication preserves Haar measure for
each coordinate. Product telescoping for [0,1]-valued functions therefore
bounds the smoothing error, even within a block, by

    [sum_(l=1)^5 l*binom(n,l)]*||f-g||_1
       <=A_n*3/(2M)=1/30.

Combining this with (9), (14), and (2) proves

    integral_T P_5(f(v*t):v in V)<-1/15,
    Gamma_V<-1/15-S_5<1/30-S_5.                           (15)

The tuple satisfies the FULL signature (3), not merely Gamma_V<-1/30.

## 5. Membership in the actual inclusive finite-height domain

Expanding the four binomial products in A_n gives

    A_n=n*(n^4-6n^3+23n^2-18n+24)/24 <= n^5/24
                                                         (n>=4).

For the inequality, 6n-23>=1 and 18n-24>0 make
6n^3-23n^2+18n-24 positive. Therefore

    B=60*(90*A_n-2)+1=5400*A_n-119<=225*n^5.

Since C=n*(n+1)/2>=n^2/2 and n=3000>=1800,

    B<=225*n^5<=n^6/8<=C^3.

Using 3r=n and C^2>=15 now gives the required exponent precisely:

    max(V)=15*B^(r-1)<=15*C^(3r-3)
          =15*C^(n-3)<=C^(n-1).                          (16)

Prepend zero to the already increasing block order. This produces n+1
strictly increasing natural labels starting at zero, still with gcd one,
and (16) is exactly their bound in
`SharperInclusivePrimitiveFiniteFamily (n-1)`. No large integer values
need to be written down or checked by a search.

## 6. Scope and first unresolved implication

The preceding two-speed diagnostic allowed heights to grow arbitrarily
at fixed n. The present three-speed construction closes that particular
scope gap for the specified D_n-unit extraction: the full signature,
primitivity, every deletion gcd one, and the exact sharper cutoff can all
hold while the desired bounded unit relation is absent.

This bounded-height example does NOT rule out all possible coefficient
bounds depending on count; its base is fixed by D_n, and it is not an
unbounded-height family. Nor does it have actual least-count or minimum-sum
failure. The first unresolved step remains an essential use of genuine
full failure/minimality beyond these necessary summaries, either to
extract a suitable relation or to transport along a detected nonunit one.
No such transport is supplied here. The original bounded nonzero-relation
theorem and canonical finite-family equivalence remain intact.

## 7. Checks and source bindings

The current instructions and focused active task were read with the setup
gate open (`research` / `in_progress`) and explicit start authorization.
Startup workflow validation passed (`2fd85b`); it checks structure only.
The formal cutoff declarations, finite-family definition and canonical
equivalence were inspected as source contracts. All new calculations
above are hand mathematics. Full readback (`7701e5`, `a51b63`), all ten
input bindings and whitespace (`574b11`), and workflow validation
(`15fd5f`) passed before freezing. No build,
cache operation, mathematical program, numerical scan, new agent, external
model, Git mutation or shared-state edit was performed. Unknown runtime
metadata remains null. Independent mathematical review is still required.

| Input | SHA-256 |
| --- | --- |
| `research/astra-bounded-unit-relation-diagnostic.md` | `5c68faac8901bde8e82cb564b3c4ff8dc4918bd08240873e6bbd1047a72c1ba7` |
| `research/astra-uniform-global-transport-strategy.md` | `c6d433ea553cc5507a0faa97387fba75108d15bece45ac14489c879c2078d618` |
| `research/astra-uniform-global-transport-strategy-review.md` | `5eb21ae36164e68f29ac1ce0f70ca897cbfe558165cc90d8a2de3ee982ca98f7` |
| `LonelyRunner/FiniteHeightReduction.lean` | `cb41059260b943411e2ab5360b84b59cd13f2ddf352c3c50a0b3715b9b9987d6` |
| `LonelyRunner/FinitePrimitiveFamilies.lean` | `023b39b29e7939dd18b29a51217c3e3fcf353ee5843f3bc3effb27012137e9f0` |
| `LonelyRunner/FiniteFamilyEquivalence.lean` | `475a46b9e10226f3de30628e595073a9765a8c03cb0ab071bdcc10acb6446be3` |
| `.codex/config.toml` | `28212a53cf42cdc377df1f7dab040732d657e59d7bb97ee78791256d01d4bb2c` |
| `docs/project-workflow.md` | `2b42a133352b6b53ba2106fc73882733f176e04a0deffbb183b4c16eefd9cd67` |
| `research/workflow-policy.json` | `833c397b61d1ffdb994fb115019f6d60d6c1a62ff85f19cdd2c9f8ac3a979c8b` |
| `scripts/validate_workflow.py` | `250a3ce2a080f5835ac4fd2e4b2803568424c777cda5d421f9fe92efd34d5383` |
