# Arithmetic label cuts and explicit anchor witnesses

Pass63 merged through PR62 at `15a34041b72e17734d746fea005c83130a7e41fb`.
Both required CI jobs passed, and root verified the checkpoint on fetched main.
This pass studies a uniform sufficient condition for ordinary witnesses; it
does not establish unrestricted LRC or introduce another runner-count milestone.

For positive distinct speeds and `N = n+1`, join two labels a,b when
`a+b > N gcd(a,b)`. An empty full-good set forces this label graph to be
connected. Coincident-centre merging preserves the bad union, and every label
survives at its intrinsic centre `1/v` (speed 1 survives at 0). Distinct-centre
overlap then projects to the strict arithmetic edge relation. The independent
review removes the author's unnecessary deletion-seed premise. This refinement
is recorded in the review; the original author manuscript remains frozen.

The accompanying abstract construction has full coverage, reflection symmetry,
same-colour disjointness and strict deletion seeds even after the prescribed
radius inflation. These properties alone cannot exclude full coverage. It
omits the complete integer-frequency grids and equal radii within each colour.
The review gives its exact unequal colour measures and qualifies the original
centre-pattern wording. Deleting a colour after coincident-centre merging also
loses arcs that must be restored; reduction and deletion do not commute.

The separate profile investigation proves a direct arithmetic sufficient
condition. For any integer `N>=2` and positive integer anchor m, if each
positive speed a satisfies `a+m <= N gcd(a,m)`, both common times
`(N-1)/(Nm)` and `(N+1)/(Nm)` give distance at least `1/N`. Reduce `a/m=d/e`.
When `e=1`, periodicity gives the bound; otherwise coprimality gives
`||d/e||>=1/e` and the Lipschitz loss is at most `d/(Ne)`. The hypothesis
`d+e<=N` supplies the closed bound. Neither a prescribed label count,
distinctness, nor membership of the anchor in the collection is necessary.
The proof does not produce a suitable anchor for every tuple.

For `N=8`, the positive control `(1,2,4,6,8,15,42)` has isolated label 6.
It nevertheless satisfies every previously listed deletion-gcd and divisor
restriction, covers all denominators `2..8`, satisfies all reciprocal-orbit
capacity inequalities (proved for every integer orbit denominator), and
passes both height bounds and the fast-speed exclusion. The full witness
`3/10` even supplies all stronger deletion seeds. Thus this particular
arithmetic profile does not imply label-graph connectivity. This is a scope
control for a uniform mechanism, not a new fixed-count proof. The independent
review checks both arguments and their exact input bindings.

Adding label connectivity still does not make the accumulated arithmetic
profile contradictory. In the previously accepted unbounded positive family
`v_i=L+i`, `0<=i<=N-2`, `L=lcm(2,...,N)`, every label pair is an edge:
its gcd is at most `N-2`, whereas its sum is at least `2L+1` and
`L>=N(N-1)`. Thus this family has a complete label graph as well as the
earlier arithmetic restrictions and full stronger-margin witnesses. The
review separately checks this root-proposed additional scope observation.

The anchor lemma has a small possible Lean implementation using gcd reduction,
periodicity and the existing circle-norm Lipschitz API. Full arc-graph machinery
is unnecessary for that subcase. Implementation is deferred until this
condition supports an argument covering the remaining tuples; another
conditional lemma by itself would not close the uniform supply gap.
Root checked the existing `circleNorm_add_int` and
`circleNorm_sub_abs_le_circleNorm` declarations in
`LonelyRunner/FastRunnerInsertion.lean`; this is an API feasibility check,
not an elaboration or kernel check of the proposed anchor theorem.

No Lean source or dependency cache is changed. The remaining central obligation
is uniform witness supply for actual integer-speed tuples, including those
whose label graph is connected. The protected-seed assertion Q remains a
separate unresolved sufficient route. The formalized canonical six-runner
milestone remains established; the unrestricted conjecture remains open here.
