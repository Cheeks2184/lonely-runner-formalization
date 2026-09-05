# Eighteenth Astra research checkpoint

The weighted obstruction now extends to every fixed positive odd order of
inclusion-exclusion. Increasing the fixed number of overlap terms cannot
make this particular product-weighted sufficient condition universally
available on sparse actual-pivot grids. The manuscript gives an explicit
counterfamily and a closed witness for every member. It adds no Lean theorem
and does not refute sparse noncover or the Lonely Runner Conjecture.

For an odd order `h`, write

```text
B_h(m) = sum_(j=1)^h (-1)^(j+1) binom(m,j).
```

For positive integer `m`, this equals `1+binom(m-1,h)`; at zero it is zero.
The corresponding average `T_h=mean(B_h(m(r))*Q(r/M))` is therefore at least
`A=mean(Q)` under complete coverage. The implication `T_h<A => noncover`
remains valid. What fails is universal availability of its premise when h
is fixed independently of the number of owners.

Set `e=h+1`, use even speeds `2,4,...,2e` together with odd speeds
`1,3,...,2k-1`, and choose pivot `p=2k-1`, owner count `c=k+e-1`, and
`N=2c+1`. For sufficiently large explicitly specified k, almost all of the
normalized product weight lies near time one-half. Exactly e lower owners
are bad there, so `B_h(e)=2`. This forces `T_h>A`, although candidate `r=p`
is a closed witness at time `1/N` because every speed is strictly below N.

The proof works on the actual finite grid. Two explicit central candidates
supply a positive polynomial lower bound for its total weight. A three-region
trigonometric estimate gives exponential suppression outside the central
region. A single term of the exponential series then supplies an explicit
factorial-sized integer k for each h. No grid or polynomial at that enormous
parameter is constructed. The Laurent degree is strictly below the grid
modulus, so constant-term averaging is exact and has no frequency aliasing.
The manuscript also proves `T_h/A -> 2` as k grows with h fixed.

The fixed-order restriction is essential. If the order is allowed to grow
so that an odd `h>=c`, then `B_h(m)=1` for every possible positive bad
multiplicity. The resulting condition becomes exactly positivity of weighted
good-set mass, hence a witness-existence test. The counterfamily does not
refute that identity or a different choice of weight.

Root and the author contributed to the candidate argument; the separate
Astra review supplies independent acceptance. Finite integer/rational
controls corroborate the algebra, literal candidates, floor bounds, and
explicit parameter arithmetic. Independent controls include 27 small families, 716 central candidates,
54 boundary perturbations, 80 exact trigonometric telescoping identities,
710 binomial identities, and 18 explicit parameter checks. The universal
quantifiers are carried by the manuscript proof and its semantic review,
not by those finite controls.
No local Lean rebuild is needed for these manuscript-only changes.

- [Universal fixed-order audit](../research/astra-bonferroni-weight-audit.md).
- [Independent review](../research/astra-bonferroni-weight-review.md).
- [Verification manifest](../research/astra-pass18-verification.json).
- [First-order exact checkpoint](astra-research-17.md).

A new existence argument is still needed for unrestricted LRC. The current
formal source retains the denominator-nine four-owner result and the
conditional canonical bridge from the sixteenth checkpoint.
