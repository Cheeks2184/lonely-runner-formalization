# Pass 87: arithmetic pruning of private-cell completions

The complete original grid admits a quantitative saving before its interval
completions are colored. At each common center, arcs are nested by increasing
speed. Remove every inner arc below a forced outer arc; elsewhere retain the
two outermost arcs. At every completion gap, forced chains contribute zero
and each other chain's multiplicity becomes its minimum with two. Thus every
gap remains doubly covered, including singleton gaps and open endpoints.

Write C3 for the reciprocal cost of all third-and-later arcs at their centers,
and C2F for the cost of second arcs whose outer ancestor is forced. The exact
discarded cost is S=C3+C2F. If f is forced cost and B is the sum of the
remaining cellwise color-cost differences, choosing the cheaper color gives
an actual full cover of cost `(n+f-S-B)/2`. The saving is positive: the zero
center alone contributes the reciprocals of all but the two smallest speeds.
This is a safe construction, not a claim that the resulting cover is optimal.

The manuscript also identifies a limitation under actual canonical strict
failure. Put `alpha=1/(n+1)`, `rho=mu/alpha<1`, and let M be full bad-arc
multiplicity. The excess `integral (M-2)_+` is at least `2alpha*C3`.
Together with the private-region identity and the forced-core length bound,
this gives `rho*f >= 1+C3+E` for an explicitly nonnegative E. Consequently
`f-1-C3 >= (1-rho)*f+E > 0`: deleting coincidence tails alone cannot provide
the saving required for a contradiction. Additional arithmetic remains needed.

A uniform exact control strengthens the earlier prime-progression example.
For speeds `1,...,n`, every `n>=3`, and test width
`1/(n+1)<a<1/n`, the forced arcs are exactly those whose centers are primitive
fractions with denominator equal to their speed. Explicit private times prove
this classification. Every remaining arc lies inside its forced ancestor, so
the exact minimum original-grid cover cost is `sum_(q<=n) phi(q)/q`.
At the closed canonical width these primitive arcs still cover; two specified
arcs overlap by `(n-2)/((n+1)*n*(n-1))`. Hence their cost is at least
`(n+1)/2+(n-2)/(2n*(n-1))`. Even exhaustive pruning fails the target saving
on these controls. Their true maximum is the native `1/(n+1)`, so they are
not canonical strict failures and do not refute LRC.

Independent review and the integration receipt record the verification status
of these manuscript arguments. No new Lean theorem, numerical search, local
build, or dependency restoration is included. The unrestricted proof/disproof
remains unresolved. Further work examines coverage from different centers and
valid exchanges using the full minimum-count and minimum-sum hypotheses.

A focused literature check found that Bohman and Peng's Theorem 1.3 gives
strict witnesses for sufficiently large n when
`n < max(V) <= 2n-exp(C*(log log n)^2)`. Their Section 3 uses coprime missing
speeds to exclude the three nearest residues at a chosen rational time.
The height restriction is essential to that construction; it does not close
the unrestricted completion gap. This is a scope note, not an imported proof.
Source: [Coprime Mappings and Lonely Runners, arXiv v1](https://arxiv.org/pdf/2109.09860).

Pass 86 merged through PR85 at `33b5b430b443014241f99030dacb2cb66576feea`.
Both required remote checks passed, and fetched main passed seventeen file
hash checks plus head and parent ancestry checks.
