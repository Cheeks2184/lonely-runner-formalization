# Failed approaches and counterexamples

## 2026-08-01: audit of a claimed CRT/LCM proof

Source audited: Bhaskar Kumar, *A Complete Proof of the Lonely Runner
Conjecture*, March 2026, <https://vixra.org/pdf/2603.0086v1.pdf>.

This argument is rejected for several independent reasons.

### Explicit counterexample to Lemma 5.1

Use the paper's strict "good" interval with `n = 6`. Let the existing moduli be
`a1 = 2`, `a2 = 3`, and let `r = 1`. Then

- `1 mod 2 = 1` lies in `(2/6, 10/6) = (1/3, 5/3)`;
- `1 mod 3 = 1` lies in `(3/6, 15/6) = (1/2, 5/2)`.

Thus `r` is good for both old moduli. Their LCM is `B2 = 6`. Add the new,
distinct modulus `a3 = 6`, which divides `B2`. Every permitted update is
`r' = 1 + 6y`, so `r' mod 6 = 1`. But the new good interval is `(1,5)`, and
the residue `1` is not in it. Therefore the induction lemma is false.

The paper's Case 1 observes that the residue is fixed and then silently reasons
about other "compatible residues" that cannot be reached while preserving the
old residue classes.

### Invalid time discretization

For relative integer speeds `b_i` and `D = lcm(b_i)`, putting
`a_i = D/b_i` and `r = Dt` gives `||b_i t|| = ||r/a_i||`. Nothing permits
restricting the real variable `r` to integers. Indeed, if an `a_i` is `1`, no
integer residue can lie in its strict good interval. The claim that multiplying
speeds by a least common denominator makes reciprocal periods integral also has
the scaling direction wrong.

### Wrong boundary

The conjecture uses `>=`, but the manuscript replaces it by strict interior
conditions. The stronger statement is false: the tuple `(1,2)` has maximum
minimum distance exactly `1/3`, never strictly greater than `1/3`.

### Conclusion

The claimed proof cannot be repaired locally: its central induction lemma,
time reduction, and target inequality all fail independently.

## 2026-08-01: adjacent-anchor domination conjecture

Sol Pro proposed that, for every residual primitive integer tuple, some pivot's
two neighboring-speed bad sets would overlap all remaining bad sets strongly
enough to give a strict two-parent union bound. This proposed uniform
strengthening is false.

The smallest counterexample found has six moving runners:

`(1,2,3,4,5,7)`, with `N=7`.

It is primitive and increasing. Fast insertion fails (`7 < 6*5`), and the
minimum-scale band criterion fails because `7` lies in the open gap `(6,8)`.
For pivots of speeds `1,2,3,4,5,7`, the proposed adjacent-anchor upper bounds
and candidate-set cardinalities are respectively

`6=6, 12=12, 18=18, 24=24, 30=30, 46>42`.

The condition requires strict inequality, so every pivot fails. This is a
failure of the proposed anchor restriction, not a counterexample to Lonely
Runner: the exact complete bad unions at pivots `5` and `7` have sizes `28<30`
and `40<42`, so those grids contain witnesses. The fixed adjacent anchors lose
decisive higher overlap.

## 2026-08-01: pairwise overlap budget without Hall constraints

A sum of directed pairwise intersections cannot replace the union-overlap
credit in an ordered certificate. The smallest abstract counterexample has

```text
R = {x},
B1 = B2 = B3 = {x},
P2 = {1},
P3 = {1,2}.
```

Here `S=3` and `S-|R|=2`. The three directed pairwise intersections have total
cardinality `3>2`, but the actual union credit is only `1+1=2`; the residue
`x` is counted twice among the two parents of `B3`. A distinct-set version is
`R={x,y,z}`, `B1={x}`, `B2={x,y}`, and `B3={x,z}`, with the same strict
failure.

For a fixed order and parent sets, an integral flow network computes the exact
disjoint credit: parent-child arcs carry proposed weights, eligibility arcs to
child-residue nodes have sufficiently large capacity, and every residue node
has unit capacity to the sink. Saturating all proposed weights is equivalent
to the Hall inequalities

```text
sum_{j in Q} w_ij <= |union_{j in Q} (Bi intersect Bj)|
```

for every child `i` and every subset `Q` of its parents. Consequently pairwise
gcd counts alone do not justify the missing implication; one needs arithmetic
control of these higher-union cuts.

## 2026-08-01: absolute Fourier main-term domination

The sufficient criterion that the all-zero Fourier convolution term dominate
the absolute sum of all other zero-sum terms is not necessary, even for a
certified three-speed tuple. For `(1,2,3)`, `N=4`, pivot `3`, residues `3` and
`9` are good, but the `c*prod(1-beta_i)` factorization has

```text
T0 = 7/24
A  = 37/72 + sqrt(3)/18
A - 2*T0 = (4*sqrt(3)-5)/72 > 0.
```

It is not even factorization invariant: `c*prod(1-g_i)` passes at this pivot,
while at pivot `1` the filtered-`beta` factorization passes and the raw-`g`
factorization fails. The regression script reproduces these values and an
all-pivot certified failure at `(4,5,9)`. Absolute triangle bounds therefore
discard essential cancellation and cannot serve as a uniform proof condition.

## 2026-08-01: uniform ranked random-order fiber credit

The exact ranked tail-sum identity correctly computes the average one-level
fiber-credit bound over all orders, but the proposed assertion that this
average is strict at some pivot is false.  The primitive tuple

```text
(2,3,7,9,10,12,15,16,19)
```

has expected bound at least the candidate count at every pivot.  At pivot
speed `3`, for example, `|R|=27`, the bad-size sum is `42`, the expected
credit is `251/20`, and the expected upper bound is `589/20>27`.

This is not a failure of the optimized additive method or of Lonely Runner.
At the same pivot, the order `(10,15,2,16,7,9,12,19)` has exact insertion
costs `(9,8,2,2,0,0,2,2)`, totaling `25<27`; `t=7/30` is an explicit closed-
boundary witness.  The failure mechanism is therefore genuine: a favorable
coordinated order can be substantially better than the uniform average.
Exact all-pivot scores and reproduction commands are in
`docs/ranked-fiber-averaging.md`.

## 2026-08-01: GCD-rate exponential-clock uniformity

The generic exponential-race and conditional-expectation identities are
valid, but the proposed fixed rates `gcd(a_i,(n+1)A)` do not give a strict
expected bound at some pivot for every primitive tuple.  Sol Pro's first exact
all-pivot counterexample was

```text
(8,15,35,40,48,56,63,75,78).
```

For pivot speeds in tuple order, the margins `9*A - expected_cost` are

```text
-306535/6748764
-45774477372115417671047/11080678499995494450060
-10092964235504317757/1440523581046830280
-3193009367893/203795336745
-302891714608332136588331/5467133235691463095760
-4794129545369388453438975200557/115115210899045744802513047950
-3327760206087107597795619165287/65752240224785488917083991450
-4670513694295489/330094903238100
-1059497781243660599/16137451462532400
```

All are negative.  The regression suite recomputes every fraction from the
strict pivot masks and also verifies that the tuple is primitive.  This is not
an optimized-additive or Lonely Runner counterexample.  At pivot `8`, order
`(75,48,40,15,78,35,63,56)` has costs `(14,6,28,8,4,8,2,0)` and total
`70<72`; the explicit time `13/80` gives distances
`(3/10,7/16,5/16,1/2,1/5,1/10,19/80,3/16,13/40)`.

A targeted independent divisor-template search subsequently found the simpler
primitive failure `(6,8,15,21,28,35,40,48,75)`.  Its maximum speed is `75`
and its speed sum is `276`, versus `78` and `418` for the first tuple.  The
regression suite recomputes all nine strictly negative margins.  At pivot
`75`, conditional-expectation greedy still produces cost `643<675`, so the
same separation from the deterministic additive route remains explicit.  The
bounded search does not establish global minimality.

## 2026-08-02: globally best-parent feedback-cycle uniformity

The top-parent restriction is a sound sufficient condition for the optimized
additive certificate: give every child-target token only a globally
maximum-weight parent, then pay the minimum backward top-edge weight
`tau_top`. The resulting cost bound is `D_top=S-F_top+tau_top`. It is not a
uniform condition. The primitive tuple

```text
(5,28,35,40,68,88,108,148,165)
```

has, in pivot order, exact top costs and thresholds

```text
45/45, 258/252, 315/315, 362/360, 624/612,
810/792, 982/972, 1364/1332, 1489/1485.
```

Every row therefore fails the required strict inequality. Two implementations
independently reconstruct the strict candidate sets, fibers, parent weights,
top ties, and subset recurrence. One clean-room audit exhaustively enumerates
all `8!` orders at every pivot. Candidate sets have cardinality `9*a_j`, and
strict boundary hits remain good.

This counterexample does not propagate to unrestricted optimized ordering.
At pivot `28`, a lower-ranked-parent order has cost `250<252`; the best
top-only order costs `258`, and merely applying second-best rescue to that
same order gives `254`, showing that a different order is essential. The
explicit candidate `r=6`, or time `t=3/140`, has minimum circular distance
`3/28>1/10`. Thus this section rejects `TOP-CYCLE-UNIF` only. It is not a
counterexample to `OPT-ADD-UNIF`, the pivot-certificate formulation, or LRC.
Reproduction details are in `docs/top-cycle-failure-audit.md`.

## 2026-08-02: bounded-depth chain and unrestricted additive uniformity

The nested three-deletion bound `CHAIN3-UNIF` is a sound strengthening of
one-step peeling but is not uniform. The primitive tuple
`(8,15,35,40,48,56,75,132,147)` has
`B_3-beta=(2,1,6,16,50,24,0,96,72)`, so every pivot is nonstrict. It does not
reject unrestricted additive ordering: pivots `15`, `35`, and `75` succeed,
and `t=13/80` is lonely.

Even the exact unrestricted additive-order condition is not uniform. For

```text
(15,21,40,48,56,105,126,280,1200),
```

the optimized surpluses `9A-Dopt` are
`(0,-31,0,-32,-2,-2,-62,-48,-24)`. A clean-room literal oracle checks every
strict residue/fiber construction and all `362,880` pivot-order pairs. Equality
at pivots `15` and `40` is insufficient, so `OPT-ADD-UNIF` is false. This
rejects the ordering surrogate only. Pivot `48`, residue `39`, gives
`t=13/160`; every circular distance is at least `1/10`, and the exact witness
is kernel-checked in `OptAddCounterexample.lean`. The surviving target is the
strictly stronger exact pivot-certificate proposition.

## 2026-08-02: fixed and prescribed correlation depth

The alternating-binomial correlation polynomial gives a sound lower bound on
the sum of safe pivot candidates, and its low moments now have a noncircular
generalized-CRT formula. It cannot, however, be closed by any fixed depth. For
the consecutive tuple `A_n=(1,...,n)`, the exact estimate

```text
L_(n,d)(A_n)
  <= n*phi(n+1) - (2/(n-1))*C(n-1,2d+1)
```

is negative for infinitely many `n` at every fixed `d`. The linearly growing
choice `d=(n-3)/4` is also negative whenever `n congruent to 59 mod 60`.
These are genuine infinite theorems, not extrapolations from the bounded
verifier. Nevertheless every consecutive tuple has the exact lonely time
`t=1/(n+1)`. The failure is therefore in the prescribed-depth sufficient
certificate, not the pivot-certificate proposition or LRC. Arbitrary adaptive
depths, other feasible zero-indicator polynomials, and additional cross-pivot
CRT constraints remain open.

Optimizing the coefficients does not rescue any fixed moment order. The exact
degree-`r` primal LP ranges over every polynomial below the zero indicator on
`0,...,n-1`, and its dual ranges over all nonnegative pseudo-histograms with
the supplied moments. It gives stronger finite bounds than the original
polynomial, but for every fixed `r` an infinite low-totient consecutive family
forces every nonzero primal vertex to have negative objective. The zero
polynomial then proves the exact optimum is zero. This closes all uniform
fixed-order moment-only strategies, not growing order or methods retaining the
full CRT intersection table.

For the original Response 39 polynomial, allowing the depth to adapt does not
produce a meaningfully low-order theorem on the standard tight family. For
all `n>=90`, `(1,...,n)` first becomes positive only one or two depths below
the tautological cutoff `floor(n/2)`, with both gaps occurring infinitely
often. This does not reject all growing-degree polynomials, but it closes the
hope that the original coefficient pattern remains uniformly far from exact
inclusion--exclusion.

## 2026-08-01: fixed-dimension minimality does not supply induction

Response 42 claimed that a primitive sum-minimal counterexample at fixed `n`
must satisfy `a_n<n*a_(n-1)`. The proposed proof deletes `a_n`, applies LRC to
the remaining `n-1` speeds, and then uses fast insertion. Fixed-`n` sum
minimality gives no theorem about the lower-dimensional tuple, so this is an
invalid interchange of dimensions. The conclusion is retained only after
choosing a least counterexample dimension, or by explicitly assuming LRC in
dimension `n-1`. The corrected restriction is compatible with divisor cover,
the height bound, and signed-descent irreducibility, so it does not currently
yield a contradiction. Response 43 repeated the same fixed-dimension claim
after receiving this objection; its residual-class theorem is rejected for
the same reason.

The direct two-residue hole construction also stops being complete at the
next height. At `N=4`, speeds `(3,4,7)` leave holes `(1,2,5,6)` in `[1,7]`.
No reciprocal or `C_2` inverse witness exists, but the `C_3` witness `t=1/10`
has scaled residues `(12,16,12)>=10`. This rejects only the restricted
two-residue construction. The stronger max-speed `n+4` theorem survives by
allowing `C_3` in two small cases.

An attempted conditional Lean wrapper for the uniform `N>=12` height proof
did not elaborate within repeated 60--180 second checks, even after the
missing-hole and reciprocal/coprime branches were separated. No Lean error
was produced, so this is recorded as a formalization-performance obstruction,
not a mathematical objection. The unverified declarations were removed; only
the previously clean `n+2` height theorem remains in the kernel.

The reciprocal/`C_2`/`C_3` construction is not complete even for the accepted
five-hole theorem. At `N=4`, speeds `(2,6,8)` and holes `(1,3,4,5,7)` admit no
such pattern under the exact search definitions, although the direct witness
`t=2/7` satisfies the closed `1/4` boundary. Two further small configurations
also require direct witnesses. These are method failures, not counterexamples;
the exhaustive finite certificate preserves the max-speed `n+5` theorem.

Correcting the minimal-counterexample quantifiers does not make the current
arithmetic restrictions contradictory. The infinite family
`U_N=(3,4,...,N,N+4)` satisfies divisor cover, deletion-gcd-one, comparable
top speed, the lcm/product inequalities, nontrivial cross-pivot scaling, and
signed-descent irreducibility, yet is lonely at `1/(3N)`. Thus height plus the
existing descent conditions cannot replace the missing total-pivot argument.

Finally, zero exact all-pivot Chebyshev-score failures across the recorded
finite domains is not a proof of uniform positivity. A score failure would
reject only that sufficient certificate, while absence of one provides no
compactness or induction step.
