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
