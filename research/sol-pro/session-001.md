# GPT-5.6 Sol Pro research session 001

Date: 2026-08-01

Environment: separate signed-in ChatGPT browser conversation. Model family
`GPT-5.6 Sol` and intelligence level `Pro` were selected through the page's
accessibility interface.

## Prompt 1: strategy generation

> Act as the primary mathematical research agent on the Lonely Runner
> Conjecture, with the standard closed-boundary formulation: for every n>=1
> and every nonzero real v_1,...,v_n, there is t in R such that ||t v_i|| >=
> 1/(n+1) for all i, equivalently every runner among n+1 pairwise-distinct
> real-speed runners becomes lonely at some (runner-dependent) time. This
> remains open in general; do not optimize for claiming a proof.
>
> First research round: develop at least four materially different proof or
> disproof strategies before committing to one. Include approaches based on
> (a) integer reduction / finite checking / arithmetic structure, (b) Fourier
> or measure/inclusion-exclusion methods, (c) torus, lattice, or zonotope
> geometry, and (d) an induction, compactness, or topological route; add a
> fifth if useful. For every strategy: (1) state the proposed reduction
> precisely with all quantifiers and boundary conventions; (2) give a directed
> list of explicit lemmas needed; (3) identify which lemmas are established
> literature versus new obligations; (4) explain the most likely fatal
> obstruction or tight example; (5) give small computational or symbolic tests
> that could falsify the key new lemma; (6) flag hidden uses of strict slack,
> finiteness, attainment of a supremum, or unjustified reduction from real to
> rational/integer speeds.
>
> Then rank the strategies by genuine promise. If any argument would already
> settle a known open case, say so plainly. Do not present a complete proof
> unless every transition is supplied at lemma level. End with 3-6 concrete
> research tasks for a Lean coordinator to test next. Use mathematical notation
> in plain text where possible so the response can be archived.

## Response 1

No response was produced. After approximately 30 minutes, the visible progress
log reported 13 website-search batches and computations concerning prime
thresholds, candidate witness fractions, Fourier collisions, denominator
divisibility, and the `B_13` finite-checking scale. The run then terminated with
the exact page status `Thinking failed`.

Progress text is not treated as a mathematical argument and is not imported
into the proof ledger.

## Prompt 2: bounded recovery synthesis

> Your previous Pro research run ended with the page status "Thinking failed"
> after completing its searches and computations. Do not repeat web research.
> Based only on the work already completed in this conversation, produce a
> compact synthesis under 2500 words: four materially different strategies,
> each with a precise reduction, lemma DAG, known-vs-new labels, smallest
> falsification tests, and fatal obstruction. Include the observed failure of
> second-order Fourier inclusion-exclusion on v=(1,2,3,4) at threshold 1/5 and
> explain it exactly. Explain what the B_13/prime-product computation can prove
> and why it cannot prove all dimensions. Rank the strategies and end with five
> exact Lean/research tasks. Do not browse, do not claim a proof, and do not
> omit closed-boundary or real-to-integer reduction hazards.

## Response 2

The recovery run completed after 3m56s. It proposed four routes:

1. An arithmetic prime-product route based on a claimed minimal-counterexample
   bound `sum |v_i| <= binom(n+1,2)^(n-1)`, prime avoidance, and a proposed
   finite-field lemma asserting a common witness `k/p` whenever `p` divides no
   coordinate. It computed `M_13 = 91^12` and a corresponding product scale.
2. A Fourier/measure route using bad sets `A_i={t: ||tv_i||<1/(n+1)}` and
   second-order inclusion-exclusion. It claimed that for `(1,2,3,4)` every
   pair intersection has measure `1/5` and wrote the second partial sum as an
   upper bound on the union.
3. A torus/zonotope route using the orbit closure and a proposed covering-radius
   bound.
4. A compactness/induction route based on a supremum `f(v)` and a proposed
   rigidity/dimension-drop lemma.

It ranked zonotopes first, compactness second, arithmetic third, and Fourier
fourth. It did not claim a proof.

## Coordinator audit of response 2

The candidate synthesis is rejected as written:

- The finite-field lemma is false. For two moving speeds `(1,2)`, threshold
  `1/3`, and `p=5`, the nonzero numerators give residue distances
  `(1/5,2/5)`, `(2/5,1/5)`, `(2/5,1/5)`, or `(1/5,2/5)`. None is a witness,
  although the real time `1/3` is. The modulus must retain the tight
  denominator structure (the recent ansatz methods use `lp`, not an arbitrary
  avoiding prime alone).
- The claimed bound on `sum |v_i|` was not sourced and is not the published
  finite-checking statement located in the literature review. The published
  theorem bounds a subset-gcd/lattice-point expression and consequences must
  be derived exactly before using the `B_13` computation.
- The second Bonferroni partial sum has the wrong direction:
  `sum |A_i| - sum |A_i intersection A_j| <= |union A_i|`, not `>=`.
- The pair-intersection computation is false. At threshold `1/5`,
  `|A_1 intersection A_3|=2/15`, not `1/5`.
- A universal covering-radius theorem drifts toward the shifted LRC; explicit
  shifted counterexamples are known. The original problem needs the exact
  distinguished-coset zonotope statement.
- `t mod 1` is invalid for arbitrary real speeds. Moreover, failure of an
  attained-witness statement need not imply a strict supremum gap on a dense
  nonclosed orbit, and the response's proposed maximizer cannot simultaneously
  satisfy `f(v)<delta` and have coordinates equal to `delta`.

## Prompt 3: exact objections and repair request

The coordinator submitted the five numbered objections above verbatim, added
the exact fast-runner insertion theorem and proof sketch, and required explicit
retractions, a repaired lemma DAG, the comparable-speed obstruction, at most
two surviving alternate routes, and five Lean tasks.

## Response 3

Sol Pro explicitly retracted or corrected all five challenged claims:

1. It accepted `(1,2), p=5` and retracted the prime-grid lemma, noting that an
   arithmetic ansatz must retain a denominator such as `lp`.
2. It corrected the Bonferroni direction and the pair intersections. For
   `(1,2,3,4)` at `delta=1/5`, it reported pair-intersection sum `14/15`, triple
   sum `13/30`, quadruple measure `1/10`, and therefore full bad-union measure
   `1`; the safe set consists only of boundary points such as `k/5`.
3. It retracted the unsupported speed-sum bound and every unconditional
   consequence of its `B_13` calculation.
4. It retracted the covering-radius strengthening and restored the need for a
   distinguished-coset statement.
5. It corrected the invalid real-time modulo-one reduction and the inconsistent
   strict-supremum rigidity claim.

It then gave the correct fast-runner DAG: the base case, induction hypothesis,
the supplied insertion lemma, and the corollary for any tuple with one
coordinate satisfying

`(n+1) * max(other absolute speeds) <= |V|`.

After sorting `n+1` absolute speeds as `a_1 <= ... <= a_(n+1)`, the exact
remaining regime for this mechanism is

`a_(n+1) < (n+1) * a_n`.

Two other routes were retained only as open research programs: an exact
distinguished-coset lattice formulation and a finite endpoint-certificate
formulation for integer speeds. Neither was claimed as a proof.

The suggested next formal tasks were: formalize fast insertion; formalize the
sorted comparable-speed normal form; build exact bad-interval algebra; state
the exact distinguished-coset equivalence; and test endpoint certificates in
small dimensions.

## Coordinator audit of response 3

The retractions and fast-runner DAG are accepted. The geometric alternative is
still too vague to formalize and remains an open statement obligation, not a
usable lemma. The endpoint route is a finite reformulation/testing lane; its
proposed global alternation principle would carry essentially the unresolved
content of LRC and has not been justified.

## Coordinator audit

One full objection-and-repair cycle completed. No complete proof or disproof
was produced. The strongest new auditable mathematical result remains the
fast-runner insertion theorem in `docs/fast-runner-insertion.md`.

## Prompt 4: comparable-speed-only lemma search

After the insertion theorem compiled in Lean, the coordinator asked for at
most two precisely quantified new sufficient lemmas in the remaining regime
`a_n < n*a_(n-1)`. The prompt prohibited restating LRC, shifted covering-radius
claims, invalid modulo-one reductions for real speeds, and compactness without
an orbit-closure hypothesis. It required exact constants and stress tests on
tight tuples, near repetitions, signs, and irrational ratios.

## Response 4 and coordinator audit

Sol Pro returned two lemmas after 8m42s:

1. A minimum-scale residue-band criterion with explicit witness
   `t=1/((n+1)a_1)`. Dividing each normalized-ratio band by `n+1` places the
   phase in the exact closed good interval between consecutive integers. The
   coordinator independently checked the band endpoints, the equivalent open
   gaps, signs, and the examples `(1,...,n)` and `(1,2,5)`.
2. A two-block criterion in which each block is an integer multiple of one
   real scale, the scale ratio is irrational, and each multiplier spread is
   strictly below `n`. The stated epsilon bound really produces a nonempty
   open simultaneous-good arc for each block. Irrationality is precisely the
   absence of a nonzero integer character annihilating `(alpha,beta)`, so the
   continuous orbit is dense in the two-torus and meets the product of those
   arcs.

Both proofs are accepted as mathematical partial results and are written out
in `docs/structured-classes.md`. Neither supplies the full conjecture. At this
point the first remained to be formalized directly; it was subsequently proved
as `minimumScaleResidueBands`. The second still needs a formal
Kronecker/two-torus density theorem.

## Prompt 5: residual primitive-integer modular search

The coordinator restricted the next round to primitive positive increasing
integer tuples left after fast insertion and the minimum-scale band filter. It
requested at most two exact structural certificates based on common
numerators, adjacent gaps, or subset gcds, with exact tests for 3--5 moving
runners through maximum speed 30. The prompt expressly prohibited an
unjustified real-to-integer reduction or any all-dimensional conclusion from
the bounded computation.

## Response 5

After 11m47s, Sol Pro proposed the pivot grid `t=r/((n+1)a_j)`. It defined the
pivot-good residue set `R_j`, strict bad sets `B_ij`, and supplied the exact
gcd/ceiling formula

`|B_ij| = g_ij(2 ceil(a_j/g_ij)-1)
          - h_ij(2 ceil(a_j/((n+1)h_ij))-1)`

with `g_ij=gcd(a_i,(n+1)a_j)` and `h_ij=gcd(a_i,a_j)`. A strict sum-cardinality
bound yields a good residue. Its second lemma retained overlap by ordering the
bad sets and, at each step, subtracting overlap with a selected union of one or
two earlier parent sets.

The response reported the exact partition and coverage table now preserved in
`docs/modular-pivot-certificates.md`: among primitive increasing tuples with
maximum speed 30, the two-parent certificate covered every one of the 1,136,
10,297, and 54,316 residual tuples for 3, 4, and 5 moving runners. It clearly
labeled this finite evidence rather than a uniform theorem. It also supplied
the stress tuple `(1,9,10,11,12)` with witness `t=13/27`.

## Independent audit and objection

Two independent exact implementations reproduced the formula, strict
boundary, induction, all table entries, and the stress witness. The coordinator
found one false comparison claim: the single-set union bound does **not**
subsume the minimum-scale band theorem, because it can discard decisive
overlap even when `r=1` is visibly good. Exact counterexamples are `(4,5,9)`,
`(2,3,5,7)`, and `(2,3,4,5,6)`, which satisfy the band criterion but fail the
union-bound inequality at every pivot. This objection, along with the exact
counterexamples, was returned to Sol Pro.

## Corrected response 5

After 4m45s, Sol Pro explicitly retracted the false subsumption wording and
gave the corrected map:

- fast insertion and the band condition are incomparable;
- the band condition fixes pivot `a_1` and numerator `1`, while the simple
  union criterion searches broader grids but loses all overlap;
- the simple union criterion and band condition are incomparable, with
  `(1,2,4)` witnessing the opposite direction;
- the two-parent condition subsumes the simple union criterion;
- for 3 and 4 moving runners it computes a complete bad union and therefore
  subsumes a known band witness, whereas no such global relationship is proved
  for 5 or more moving runners.

It then listed the precise residue-model, cardinality, datatype, soundness, and
enumeration-completeness obligations for an end-to-end Lean verifier. As a
possible uniform target it proposed an **open** adjacent-anchor domination
inequality requiring two neighboring-speed bad sets at one pivot to account
for enough of every other bad set. That statement is not accepted into the
ledger without a separate counterexample search; even if it survives bounded
testing, it remains an unproved strengthening, not progress on `FULL-01`.

## Coordinator audit of the corrected response

The proposed adjacent-anchor statement was immediately falsified. For six
moving runners, the primitive residual tuple `(1,2,3,4,5,7)` gives proposed
bounds versus candidate-set sizes

`6=6, 12=12, 18=18, 24=24, 30=30, 46>42`

over the six pivots, so no required strict inequality holds. Exact full-union
sizes `28<30` at pivot `5` and `40<42` at pivot `7` show that the failure comes
from the fixed anchors losing overlap, not from absence of a grid witness. The
counterexample and exact per-pivot figures were submitted back to Sol Pro with
a request for explicit retraction and no untested replacement. The statement
is recorded as `rejected`, not `open`.

## Sol Pro retraction

Sol Pro responded after 52 seconds and explicitly retracted the
adjacent-anchor domination conjecture. It verified all six failed strict
bounds and the two exact-union witnesses. Its diagnosis agrees with the
coordinator's: fixed anchors count each non-anchor remainder separately and
therefore miss overlap among those remainders. At pivot `5` this overcounts by
`2`; at pivot `7` it overcounts by `6`. As requested, it proposed no replacement
without a prior six-runner residual audit. No uniform modular statement
survives this round.

## Prompt 6: post-anchor residual strategies

The coordinator supplied the rejected six-runner anchor conjecture and asked
for three materially different strategies: adaptive higher-order overlap, a
minimal-height or finite-critical-time route, and arithmetic gcd/divisor
structure. Every proposed uniform statement had to survive an exact
six-runner search, and the response was required to decide whether pivot grids
were merely an ansatz.

## Response 6

After 18m24s, Sol Pro returned four claims, with no global proof claim.

1. **Boundary-pivot lemma (claimed proved).** For positive integer speeds, any
   witness can be replaced by a witness of the form
   `(N*m+epsilon)/(N*a_j)`. The proposed proof takes a boundary point of the
   nonempty proper closed safe subset of `R/Z`; some coordinate is then exactly
   at distance `1/N`. Thus pivot-grid universality is equivalent to the
   integer LRC instance, not a stronger ansatz.
2. **Half-parent certificate (computational conjecture).** With parent capacity
   `ceil((n-2)/2)`, some pivot and ordering should satisfy the audited ordered
   overlap inequality. The response reported complete success for `n=6`
   through speed 30, `n=7` through speed 20, and `n=8` through speed 15. It
   claimed `(1,2,5,7,9,11,12,13)` is the first exhibited tuple failing every
   two-parent certificate but passing a three-parent bound `50<56` at pivot
   `7` with surviving residue `8`.
3. **Pair-sum critical spectrum (claimed proved).** For
   `F_A(t)=min_i ||a_i t||`, a global maximizing time occurs at
   `r/(a_p+a_q)` for two indices `p<q`. At a maximizer below `1/2`, active
   triangular-wave slopes of both signs give `(a_p+a_q)t` integral; at value
   `1/2`, all coordinates are half-integral. This yields a finite blocking
   incidence system but no height bound.
4. **Codimension-one divisor insertion (claimed proved conditional on the
   lower-dimensional integer theorem).** If all speeds except `a_j` have gcd
   `D`, put `m=D/gcd(D,a_j)`. Shifts by `k/D` preserve the old coordinates and
   move the exceptional coordinate through an `m`-point grid. The condition
   `N(m-1)>=2m` supplies the new `1/N` bound. Consequently a primitive integer
   counterexample with at least three moving speeds must have deletion gcd one
   at every index, a corollary later corrected to require the lower-dimensional
   theorem or minimal counterexample dimension.

The response reported additional bounded data: all 239,928 six-runner
residual tuples through speed 30 pass two-parent certificates; the divisor
lemma covers 20,878 of them.

## Independent objections and Sol Pro corrections

The boundary-pivot, pair-sum, and divisor-insertion proofs survived an
independent mathematical audit, including the closed endpoint. Two corrections
were returned to the separate Sol Pro conversation:

1. The invariant pair-sum denominator bound is
   `max_{p<q}(a_p+a_q)`. A sorted tuple gives at most `2*a_n`; only a sorted
   pairwise-distinct positive-integer tuple gives
   `a_(n-1)+a_n <= 2*a_n-1`. Sol Pro explicitly retracted the hypothesis-free
   sharper bound.
2. For a primitive tuple, the divisor orbit size is the deletion gcd `D_j`.
   An arbitrary primitive counterexample does not automatically have
   `D_j=1`, because lower-dimensional LRC is a premise of insertion. Sol Pro's
   corrected corollary applies to a minimal-dimensional counterexample or
   after dimension `n-1` is established. The condition
   `(n+1)(D_j-1)>=2D_j` is equivalent to `(n-1)D_j>=n+1`; for `n>=3` it holds
   exactly when `D_j>=2`, while for `n=2` it only rules out `D_j>=3`.

Exact independent enumeration reproduced the reported six- and seven-runner
data. At eight speeds through 15, it found a second two-parent failure omitted
from the response: `(1,5,7,8,9,11,13,15)`. Together with
`(1,2,5,7,9,11,12,13)`, these are the only failures among 1,716 residual
tuples. Both pass a three-parent bound `50<56` at pivot `7`, with witnesses
`20/63` and `8/63` respectively. The proposed half-parent rule survives this
box but remains unproved.

## Prompt 7: half-parent structure and interval boundary proof

The coordinator returned the complete seven- and eight-speed data, including
both two-parent failures, and reported that the exact strict bad-set formula
now compiles in Lean. Sol Pro was asked either to advance the half-parent rule
without appealing to the finite searches or identify the first unsupported
structural implication. It was separately asked for a Lean-friendly
boundary-pivot proof on a real interval rather than on `R/Z`.

## Response 7 and audit

The half-parent lane produced only a necessary overlap-budget condition. Any
ordered capacity-`p` certificate must credit total overlap strictly exceeding
`sum_i |B_i|-|R|`. Assigning each credited residue to one selected parent gives
a directed graph of indegree at most `p` with bounded pairwise edge weights.
The converse does not follow: summing pairwise overlaps can count one residue
several times, while the ordered certificate may credit it only through its
union overlap. Sol Pro explicitly identified this disjoint-allocation step as
the first unsupported implication. Thus no sufficient uniform half-parent
theorem emerged from the round.

The boundary lane replaced circle topology by a real path. Reduce a witness
`x` modulo one to `x0 in [0,1)`, define
`f(s)=min_i ||a_i*s*x0||` on `[0,1]`, and take the least point of the nonempty
closed safe set `{s : f(s)>=1/N}`. It is positive because `f(0)=0`; if its
value were strictly above the target, continuity and finite slack would give a
smaller safe point. Hence one coordinate is exactly at distance `1/N`, which
yields a pivot rational and then a canonical residue modulo `N*a_j`.

The audit found one omitted endpoint in Sol Pro's extraction step. It wrote
`1/N<1/2`, but the one-moving-runner case has `N=2` and equality. The argument
remains repairable by handling the antipodal value explicitly; the exact
objection was returned to Sol Pro. The response's phrase "fully formalizable"
was also too strong before exact mathlib lemma names and a compiling proof are
verified. The interval argument remains `proved-math`, not `proved-lean`.

Sol Pro accepted both objections. Its corrected extraction splits `N>2`, where
a nearest integer differs by `±1/N`, from `N=2`, where the phase is a
half-integer and `epsilon=+1` suffices. Writing `q=Nm+epsilon`, taking the
Euclidean remainder `r` modulo `M=Na_j`, and subtracting the integral quotient
preserves every integer-speed phase. Since `r` is congruent to `epsilon`
modulo `N`, it is not divisible by `N`. Sol Pro also downgraded the interval
argument to a Lean-suitable lemma DAG pending compilation and confirmed that
the half-parent lane proves no sufficient structural theorem.

## Prompt 8: exact certificate equivalence and different strategies

After the boundary file compiled, Sol Pro was given the exact canonical pivot
statement and asked to audit it, state the fixed-instance and global
equivalences, and develop two materially different uniform certificate
strategies. It was specifically told to confront the two eight-speed cases
requiring parent capacity three rather than extrapolate from smaller boxes.

## Response 8 and audit

The response repeated two lanes. Its boundary lane gave the same real-interval
argument and correctly treated it as a reduction, but again wrote
`1/N < 1/2` and therefore omitted the `N=2` endpoint in its prose. The actual
Lean development handles both signs and `N=2`, so the compiled result is
stronger than that narrative.

The half-parent lane proved only a necessary accounting inequality: an
ordered certificate must obtain overlap credit exceeding
`sum_i |B_i| - |R|`. It then proposed a directed pairwise-overlap budget. The
response itself identified the first unsupported implication: pairwise edge
weights can count the same residue more than once among a child's parents,
whereas the required union overlap counts it once. Thus the proposed graph
condition is not sufficient without a disjoint allocation theorem. Its
claimed `n=6`, speed-15 brute-force check supplied no code or certificates and
was not used as evidence in this repository.

## Prompt 9: exact objections returned

The coordinator reported the clean Lean build and the declarations
`exists_witness_iff_exists_pivot_certificate` and
`positiveIntegerConjecture_iff_pivotCertificateConjecture`, then returned five
objections: necessity is not sufficiency; the pairwise-to-union implication
double-counts; the computation was unreproducible; the test did not confront
the 1,716 residual eight-speed tuples and their two capacity-three cases; and
the remaining target is uniform certificate existence, not another boundary
proof. Sol Pro was asked for both a Hall/max-flow disjoint-allocation attack
and a materially different Fourier, character-sum, or divisor-lattice attack,
with every open step labeled and every computational claim reproducible.

## Response 9 and audit

Sol Pro accepted the exact fixed-instance theorem and independently listed the
necessary hypotheses: a finite nonempty family, positive natural speeds, and
`N >= 2`, with no injectivity, primitivity, or relation between `N` and the
number of coordinates. Its signed-boundary and negative-numerator audit agrees
with the Lean proof, including the fact that both signs are congruent to one
modulo two at `N=2`.

For the uniform problem it offered two open lemmas. The first was the complete
half-parent assertion itself, with parent capacity
`ceil((n-2)/2)`; this only moved the full unknown certificate existence into a
single premise. The second asserted that complete coverage of every pivot grid
forces some deletion gcd at least two. Together with minimal-dimension
induction and the already checked divisor-insertion theorem, that assertion
would prove the positive-integer conjecture. No arithmetic argument toward it
was supplied, and the successful finite boxes cannot test an implication whose
all-pivot-cover antecedent is false on every tested tuple. Thus neither lemma
was promoted in the obligation ledger.

## Prompt 10: require a bounded combinatorial or Fourier derivation

The coordinator rejected the two open restatements as carrying essentially the
whole theorem and noted that the requested non-parent attack had not been
delivered. Sol Pro was given a forced choice: either construct an explicit
finite set-system counterexample to pairwise-overlap accounting and prove an
exact integral max-flow formulation for disjoint credit, or derive a complete
Fourier/character-sum expansion for the arithmetic bad-set indicator and
isolate a genuinely new uniform exponential-sum bound. It was instructed not
to repeat the pivot equivalence or conceal LRC inside one open lemma.

## Response 10 and audit

Sol Pro again supplied two generic sufficient conditions. Its disjoint-credit
lane contained an incorrect multiplicity identity: summing `mu(r)-1` over all
of `R` gives negative contributions at uncovered residues. The correct
redundancy is

```text
S - |union_i B_i| = sum_r max(mu(r)-1, 0).
```

After this repair, the maximum proposed credit is exactly that redundancy, so
credit greater than `S-|R|` is equivalent to the desired proper union. The
claimed uniform lemma was therefore a tautological restatement, not new
structure. The minimal pairwise-accounting counterexample is `R={x}` and
`B1=B2=B3={x}` with two parents allowed: the three directed pair intersections
sum to `3 > S-|R| = 2`, while sequential union credit is only `2`. A distinct
variant is `R={x,y,z}`, `B1={x}`, `B2={x,y}`, `B3={x,z}`.

An independent audit supplied the exact fixed-order flow formulation. Parent
arcs carry proposed credits, eligibility arcs to child-residue nodes have a
conceptually infinite capacity, and residue-to-sink arcs have capacity one.
Integral max flow is precisely disjoint union credit. The min-cut inequalities
are the capacitated Hall conditions

```text
sum_{j in Q} w_ij <= |union_{j in Q} (B_i intersect B_j)|
```

for every child and parent subset. Thus pairwise counts alone cannot prove the
needed flow; arithmetic control of all relevant cuts is required.

The Fourier lane stated only the generic product/convolution identity and a
main-term-dominance criterion. It did not calculate the coefficients of the
candidate filter or the gcd-dependent preimage of the strict cyclic interval,
so it did not yet meet the requested arithmetic task.

## Prompt 11: explicit arithmetic Fourier coefficients

The multiplicity correction, tautology objection, minimal counterexample, and
exact Hall/min-cut formulation were returned to Sol Pro. The next prompt asks
only for normalized Fourier coefficients of the candidate filter and each
arithmetic bad-set indicator, the exact convolution formula for the good
count, and a genuine Dirichlet-kernel or gcd-support bound. It explicitly
forbids presenting a condition equivalent to a good residue as progress.

## Response 11 and audit

The response did not perform the requested Fourier calculation. It instead
returned the abstract counterexample and a tagged-occurrence flow network.
That network is a valid generic repair: edge nodes represent proposed
parent-child quotas, tagged `(child,residue)` nodes prevent double counting
within a child, and an integral flow saturating every quota is equivalent to a
disjoint allocation. Cloning quota nodes yields the corresponding Hall
conditions. A quota sum above `S-|R|` is therefore sufficient once all Hall
cuts hold.

This is useful as a diagnostic but supplies no arithmetic expansion theorem.
The response correctly labels its uniform bounded-parent Hall assertion as
strictly stronger than LRC and leaves its entire arithmetic existence step
open. The result was recorded as a rejected pairwise-only implication plus a
possible higher-union proof interface, not as progress on `FULL-01`.

## Prompt 12: one bounded Fourier calculation

Because the Fourier instruction was ignored, the next prompt asks only for
five explicit formulas on `Z/(N a)`: the candidate-filter transform, the
strict cyclic interval transform, the gcd-dependent pullback under
multiplication by another speed, the convolution for their pointwise product,
and one honest coefficient bound. Parent and flow arguments are excluded from
this round.

## Response 12 and audit

Sol Pro correctly derived the sparse candidate-filter transform and the
gcd-supported Dirichlet pullback, including the inverse multiplier on the
quotient cycle. Its alternative subtraction formula for removing
`N`-divisible residues is compatible with the simpler convolution formula in
`docs/fourier-pivot-badsets.md`. The zero-frequency terms, strict radius, and
support divisibilities survived independent checking.

The response's final boxed estimate was not valid. From

```text
|beta-hat(k)| <= |p-hat(k)|
  + (1/N) sum_t |p-hat(k-t*a)|
```

and `C=N*h/d` surviving shifts, one obtains at most
`(1+C/N) * max |p-hat|`, not `C * max |p-hat|`. For `C=1` the claimed bound
simply discards a positive `1/N` contribution. No cancellation supporting that
step was proved, and the phrase that `d` is typically close to `N*h` was
unsupported. The repository therefore records only the directly proved
Dirichlet estimate and exact convolution, not Sol Pro's stronger box.

Independently, the exact formulas were audited at the `N=2` antipode,
`M'=1`, inverse direction, and normalization. The deterministic script
`scripts/check_fourier_badsets.py` cross-checks 120,060 pullback and
bad-indicator coefficients in its default box.

## Prompt 13: coefficient-bound correction

The missing factor was returned explicitly. Sol Pro was asked either to prove
actual cancellation or retract the boxed estimate in favor of the valid
`(1+C/N)` bound, and to confirm that the repaired elementary estimate still
does not imply uniform main-term domination.

## Response 13 and final audit of this pass

Sol Pro rederived the candidate filter, strict cyclic interval, gcd pullback,
and bad-indicator convolution without the invalid boxed estimate. The formulas
match `docs/fourier-pivot-badsets.md`. It also recorded the valid support
restriction `gcd(b,a) | k` for a nonzero bad-indicator coefficient and the
exact number `N*gcd(b,a)/gcd(b,N*a)` of surviving shifted terms when the
frequency congruence is soluble.

The repaired response explicitly confirms that these bounds do not give
uniform main-term domination. When the reduced strict interval has radius
zero, every Fourier coefficient has the same magnitude as its density; in
sparse interval regimes the first nonzero Dirichlet coefficient can be
arbitrarily close to the zero-frequency coefficient. Absolute-value estimates
therefore have no uniform spectral gap. A Fourier proof would need genuine
cancellation or arithmetic correlation control across runners. No such lemma
was supplied, so this round closes with an exact fixed-pivot formula and a
precise obstruction, not a proof of LRC.
