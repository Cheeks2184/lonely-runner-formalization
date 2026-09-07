# Pass 97: exact cycle optimality and the limits of parent pruning

This checkpoint records two bounded uniform investigations. It adds no Lean
declaration and does not change the unrestricted completion gate.

The first manuscript proves the precise path-exchange inequality for a
minimum original endpoint cycle C of cost c. If its forward segment from i
to j has displacement d and cost c_ij, an arbitrary original directed path
between the same indexed vertices has displacement d+h, with integer h>=0,
and cost at least `c_ij+h*c`. Repeated vertices and additional turns are
counted with multiplicity. Splicing the complementary segment produces
exactly h+1 simple winding-one cycles.

The finite potential formulation gives exactly this same optimality
constraint. For edge weight `1/b-lambda*Delta`, a potential exists precisely
when `lambda<=c`. At `lambda=N/2`, every native edge has positive weight
`(a+r)/(2*a*b)`, so the constant zero potential already works. This supplies
a lower-cost certificate and no opposing upper bound. Independent shifts
within individual speed grids do not preserve the cross-label edges; a
translation preserving all original labels is trivial because their gcd is
one. These findings close the proposed potential and translation shortcuts
without claiming that stronger arithmetic cannot succeed.

The second manuscript corrects a root hypothesis error before using it.
For a smaller parent shared by two forced maximum arcs with lifted indices
h<k, write q=k-h. The general determinant identity is `D_-+D_+=b*q`.
Numerical adjacency q=1 follows only if either gap contains a stronger
deletion seed at beta=1/n. The accepted bound b>m/n was never available for
every component of the deletion set. General reuse gives a matching of
consecutive forced indices, which can have numerical gap q>1. Such a gap
cannot contain a beta seed at either endpoint component.

Every intervening original maximum-speed arc is contained in the shared
forced parent's contracted core. After excluding arcs already removed by
the same-center saving S_c, their distinct reciprocal cost D_off can be
omitted from the coarse completion estimate. The color imbalance must be
recomputed as B_new; keeping the old imbalance while adding D_off would be
unjustified. The constructed bound is

`(n+f-S_c-D_off-B_new)/2`.

The entire extra discount is charged to the existing excess coverage and
contracted-core remainder. The resulting bound

`f-1-S_c-D_off >= (epsilon/alpha)*(f+Lambda) > 0`

shows that this pruning alone is insufficient. The exact private-cell
optimum already ignores these arcs, and the minimum-cycle containment rule
already excludes their cores. The new contribution is explicit accounting
and corrected component scope, not a new feasible cover class or an
improvement of the actual optimum. No contradictory imbalance bound or
full-time smaller-tuple transport is supplied.

The manuscripts are `research/astra-optimal-endpoint-cycle-exchange.md` and
`research/astra-forced-small-parent-reuse.md`, with their separate independent
reviews. Their new results are hand mathematics, not kernel declarations.
Local checkpoint checks bind the exact reviewed files and invoked sources;
required hosted checks govern publication. No local dependency restoration
or full build is needed for these manuscript changes.

The preceding source checkpoint was delivered through
[PR #95](https://github.com/Cheeks2184/lonely-runner-formalization/pull/95).
Head `20ec10f1093b10962ddebd59732723c2ab3ff40e` merged as
`2dca882840ede6444cca50aeda81c72f283de1c4` on 2026-09-07 at 11:46:18 UTC.
The full build completed 3,731 jobs, the trust audit accepted 710 theorem
reports, and both exact certificate replays and the full regression suite
passed. Remote-main verification checked fifty committed hashes and ancestry.
After local verification, 4,184,096,033 bytes of allowlisted rebuildable
storage were removed; the subsequent report found no remaining build cache.

Unrestricted LRC remains unresolved. The next bounded investigation returns
to positive endpoint candidates at every forced maximum arc. The accepted
native-good control already defeats a proposed ordering based solely on
private repairs and individual replacement witnesses. Any new escape-cycle
argument must use the actual full-time trapping hypothesis beyond those
local consequences. Neither this plan nor a candidate graph is a proof.
