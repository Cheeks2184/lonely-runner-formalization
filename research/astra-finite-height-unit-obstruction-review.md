# Independent review: unit obstruction within the sharper height domain

Task `/root/finite_height_unit_obstruction_review`; assigned checkpoint
`76a0ee0f467161e1b6a14794381333fdf2b95850`. Requested route:
`gpt-6-astra/xhigh`; observed model, effort, elapsed task time and usage:
null. Only this review is owned; the preceding Pass99 sources remain frozen.

**Disposition: accept the complete frozen manuscript without correction.**
The explicit tuple satisfies the full fifth Fourier inequality, every
deletion gcd condition and the actual sharper inclusive height-domain
premises, while no relation in the D_n coefficient box has a unit entry.
It is strictly native-good. This refutes the specified extraction from
those necessary summaries, not an implication using actual strict failure
and full minimality. It is a manuscript obstruction, not a new kernel
theorem or a resolution of unrestricted LRC.

## Integer construction and complete coefficient exclusion

Use the accepted global source's native alpha=1/(n+1),
A_n=n*sum_(j=0)^4 binom(n-1,j), M=45*A_n and D=2(M-1)=90*A_n-2.
Here r=1000, n=3r=3000, B=60D+1, and

    V={6B^j,10B^j,15B^j:0<=j<r}.

The inequalities 6<10<15<6B make every speed positive and the displayed
block order strictly increasing. The first triple has gcd one, so V is
primitive. A deletion outside that triple leaves it intact. If 6, 10 or
15 is deleted from the first triple, the remaining pair has gcd 5, 3 or
2 respectively, while the complete second triple has gcd B. Since
B=1 modulo 30, combining these gives gcd one in all three cases.
This checks every original deletion; no replacement labels are used.

In any integer relation with coefficient magnitudes at most D, let the
jth block digit be z_j=6a_j+10b_j+15c_j. Then |z_j|<=31D. If q is its
greatest nonzero index, the leading term has magnitude at least B^q,
and all earlier terms together have magnitude at most

    31D*sum_(j<q) B^j=(31/60)*(B^q-1)<B^q.

This also covers q=0. Thus every z_j is zero. Reducing the individual
equation modulo 5, 3 and 2 gives respectively

    5|a_j, 3|b_j, 2|c_j.

No coefficient can be +1 or -1. The argument applies to arbitrary support,
not just support at most five. It does not exclude primitive nonzero
bounded relations: (5,-3,0) on any block is one such relation.

B=1 modulo 4, so at the same actual time t=1/4 the norms of each block
are (1/2,1/2,1/4). These strictly exceed alpha=1/3001; continuity gives
an open interval of strict native witnesses. Indeed no speed is divisible
by 4, so the elementary necessary denominator-cover condition for failure
at denominator 4 is absent. The author correctly restricts the control
to its listed summaries and does not claim every known necessary
arithmetic condition, actual coverage or minimum-failure status.

## All block moments and the signed integral

Write g(x)=1_{||x||<alpha} and p=2alpha. For grids of zeros of speeds
a,b, noncoincident centers have circular separation at least
gcd(a,b)/(ab). This remains true across zero: the numerator after any
integer translate is still a nonzero multiple of gcd(a,b). The two arc
radii sum to alpha*(a+b)/(ab), so alpha<gcd(a,b)/(a+b) forces every
intersecting pair of centers to coincide. There are gcd(a,b) common
centers, each contributing an intersection of radius alpha/max(a,b).

For (6,10), (6,15), (10,15), the thresholds are respectively 1/8, 1/7,
1/5. They all hold here, and the corresponding integrals are p/5, p/5,
p/3. If three arcs contain a time, their pairwise centers coincide by
these same bounds. The common center of all three grids is only zero
modulo one, and the smallest radius is alpha/15. Thus the triple integral
is p/15. Open endpoints have zero measure. These prove exactly

    F(z)=integral (1-z*g(6t))*(1-z*g(10t))*(1-z*g(15t))
        =1-3p*z+(11p/15)*z^2-(p/15)*z^3.

Let T_r be the integral of P_5 on the independent r-dimensional block
torus. Multiplying these finite generating polynomials identifies T_r
with the sum of coefficients through degree five in F(z)^r, retaining
all original subsets and their multiplicities.

For s linear selections, d quadratic selections and e cubic selections,
put k=s+d+e, where s+2d+3e<=5. The exact contribution is L_(s,d,e)*eta_k,
with

    L_(s,d,e)=(-2)^s*(22/45)^d*(-2/45)^e/(s!*d!*e!),
    eta_k=product_(h=0)^(k-1)(1-h/r)*(3r/(3r+1))^k.

This follows from the multinomial coefficient (r)_k/(s!*d!*e!) and
p=2/(3r+1); the factor 2/3 per selected block is included in L, not
discarded. For k<=5 and r>=5 the product factors are in [0,1]. Hence

    0<=1-eta_k<=k*(k-1)/(2r)+k/(3r+1)<=k^2/(2r).

Grouping the reference coefficients by (d,e)=(0,0),(1,0),(2,0),(0,1),(1,1)
independently gives

    sum L=1/15-22/135-242/2025-2/45-44/2025
         =-571/2025,
    sum |L|=109/15+418/135+726/2025+2/9+44/2025
           =22205/2025<11.

Consequently, at r=1000,

    |T_r+571/2025|<11*25/(2r)=11/80.

Since 571/2025>1/4, this implies T_r<-9/80<-1/10. This is an explicit
finite-r estimate. The exponential mentioned in the author is only a
convenient identifier for these finitely many reference coefficients;
no limiting replacement, numerical sum or search is involved.

The accepted source supplies f=J_M*g, a finite polynomial of degree at
most D with 0<=f<=1 and ||f-g||_1<=3/(2M). On the product torus each
individual speed map preserves Haar measure. Telescoping each product
through order five, including products using two or three labels from
one block, gives the total smoothing error

    [sum_(l=1)^5 l*binom(n,l)]*3/(2M)=3*A_n/(2M)=1/30.

For the actual one-time smoothed tuple, a Fourier term survives exactly
when sum_j B^j(6a_j+10b_j+15c_j)=0 with all frequencies bounded by D.
The digit argument makes this equivalent to vanishing of every block
digit. These are exactly the independent-block zero-frequency equations.
The surviving coefficients agree, giving equality of the two smoothed
P_5 integrals. No corresponding independence is assumed for the original
unsmoothed indicators.

Combining this equality, the error estimate and T_r<-1/10 yields

    integral_T P_5(f(v*t))<-1/15,
    Gamma_V<-1/15-S_5<1/30-S_5.

Here the exact identity integral P_5(f(v*t))=S_5+Gamma_V is used, with
all zero-coordinate occurrences and subset weights retained. This is
strictly stronger than the full source failure signature, not merely
its consequence Gamma_V<-1/30. The control does not assert coverage;
the signed inequality is a necessary condition with no converse.

## Exact sharper finite-height admission and source scope

The binomial expansion is

    A_n=n*(n^4-6n^3+23n^2-18n+24)/24.

For n>=4, n^2*(6n-23)+(18n-24)>0, proving A_n<=n^5/24. Thus

    B=5400*A_n-119<=225*n^5.

Set C=binom(n+1,2)=n(n+1)/2. Because C>=n^2/2 and n=3000>=1800,

    B<=225*n^5<=n^6/8<=C^3.

All bases are positive. With 3r=n and C^2>=15, the exponent comparison is

    max(V)=15*B^(r-1)<=15*C^(3r-3)
          =15*C^(n-3)<=C^(n-1).

No rounded asymptotic or different cutoff is used. Prepending zero to
the displayed order gives n+1 strictly increasing natural labels, zero
at index zero, gcd one and exactly this inclusive height bound.

I checked the actual source declarations. In
`primitive_sorted_largeHeight_stationary_lonelyAt`, the parameter is
m=n-1, hence m+2=n+1 and the cutoff is binom(n+1,2)^(n-1). Its other
premises are m>=1, `LowerCountPositiveIntegerHypothesis (m+2)`, strict
ordering, stationary zero and gcd one. Its strict large-height branch
supplies a positive real time and a closed witness for label zero.
Only under genuine lower-count supply and stationary failure may one
take the contrapositive to get the inclusive bound. The control's
membership in that bound was instead verified directly above.

`SharperInclusivePrimitiveFiniteFamily (n-1)` is a universal proposition:
every tuple meeting the ordering/zero/gcd/inclusive-height premises must
have a witness for every distinguished label. The constructed tuple
satisfies its domain premises. That does not prove this universal
proposition, supply witnesses for all its distinguished labels, or imply
that any tuple fails. The explicit t=1/4 is a stationary witness only.

`conjecture_iff_allSharperInclusivePrimitiveFiniteFamilies` retains the
universal quantifier over all m>=1. Its reverse proof obtains preceding
positive-integer counts by strong induction and feeds them into the
lower-count hypothesis; it assumes the all-count finite-family supply.
The present domain admission discharges none of that universal supply.
The sharper stationary theorem is also not being replaced by the older
doubled-base theorem for an arbitrary distinguished label.

## Falsification status and first unresolved implication

The exact refuted implication is that the full fifth Fourier signature,
positive distinct primitive speeds, every deletion gcd one and this
specific sharper height bound force a unit relation with all coefficient
magnitudes <=D_n. It fails already at n=3000, even if arbitrary relation
support is permitted. Nonzero bounded relations remain available, so
the accepted detector is intact.

Unlike the prior arbitrary-H two-speed construction, this example has
a fixed base at a fixed count and stays within a fixed finite-height
domain. It does not refute every possible coefficient bound depending
only on count. Nor does it satisfy actual strict failure, minimum count,
minimum sum, or every separate arithmetic necessary condition. The first
unresolved implication remains a use of genuine full failure/minimality
beyond these listed summaries to extract a useful relation or justify
all-time transport to a smaller tuple or an original witness. No such
implication or unrestricted LRC conclusion is supplied.

## Bindings and check receipt

The complete frozen author was read and every new displayed calculation
above checked by hand. The unchanged global kernel/moment proof and its
accepted review, and the preceding two-speed diagnostic, are reused only
at their exact bound scopes. I read the actual sharper-height declarations
and proofs, the complete finite-family definition module and the complete
canonical finite-family equivalence module. This is a source-contract
review; no new Lean execution or trust audit was performed.

The current config, workflow, policy and focused state were read. The gate
is research/in_progress with explicit start authorization
`2026-09-05T04:12:25.208107+00:00`. The command
`python3 -B scripts/validate_workflow.py` exited zero with
`workflow structural validation passed; it cannot certify mathematical validity.`
The table binds the author and all ten of its bound inputs. Final full
owned readback, all hashes and the exact input set, final newline,
whitespace and final workflow validation are checked at handoff; the
frozen review hash is reported separately.

Only administrative text/hash/workflow checks were run. No mathematical
program, enumeration, solver, build, dependency/cache operation, new agent,
external model, Git/shared-state/memory write or other-file edit occurred.
The author was preserved; no mathematical correction was requested.
Observed runtime metadata remains null.

| Bound source | SHA-256 |
| --- | --- |
| `research/astra-finite-height-unit-obstruction.md` | `0c6c83bdd2188576121391b0e232486a4af259580d842c850111581ca87c55e0` |
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
