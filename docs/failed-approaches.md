# Failed approaches and counterexamples

## 2026-08-04: Prompt98/101 bridge stops

Prompt98's proposed MBCP statement is rejected as a disguised equivalent of
the entire frozen nondivisible branch: that branch implies MBCP vacuously,
while the response's descent claims MBCP implies the branch. The later
maximal-set `INTERNAL-PAIR-OVERLAP-SUPPLY` sufficient condition is
`refuted-exact` by `(7,8,9,10,11,13,18,3243240)`; see
[`internal-pair-overlap-supply-refutation.md`](internal-pair-overlap-supply-refutation.md).
The generic pair-incidence inequality remains valid.

Prompt101's `COVERED-PIVOT-SUBCRITICAL-WEIGHTS` theorem is `refuted-exact` by
the primitive tuple `(1,5,25,125)`, with the same obstruction extending to the
geometric family `a_k=cN^k`; see
[`response101-mathematical-audit.md`](response101-mathematical-audit.md).
Neither tuple is an LRC counterexample. These records stop only the named
sufficient bridges.

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

The stronger quadratic shortcut now has an exact all-pivot failure. For
`(1,3,5,6,7)`, the scaled values of
`H_0-H_1+alpha_5*H_2` are
`(-14722,0,-324,-486,-972)`, so no pivot meets the strict condition. This does
not refute the sound pointwise minorant, the full Chebyshev score, or LRC:
the last three full scores are positive, and `t=7/30` is a direct witness.
See `docs/quadratic-chebyshev-failure.md`.

## 2026-08-02: all feasible reversal diagonals need not satisfy Hall

The full interval of feasible crossed-rectangle starts does not supply a Hall
relation merely by taking every reversal edge `d=Q_s-c`. The first exact
nonempty-row collision occurs at `(N,t)=(36,16)`. Its starts are
`{11,12,13}`, its totals are `{63,64,65}`, and all seven actual candidate rows
are nonempty, but

```text
Gamma_diagonal({20,22,24})={41,43}.
```

The full Gamma graph is Hall-good, with explicit SDR
`20->41,21->40,22->45,23->39,24->43,25->38,26->37`. Therefore this is not a
coefficient-two or LRC counterexample. It proves that any variable-total
reversal proof must augment with non-diagonal Gamma edges; shared-prime
blocking and collisions cannot be dismissed row by row. The exact verifier
and expected output are `scripts/audit_gamma_diagonal_obstruction.py` and
`certificates/gamma_diagonal_obstruction_expected.txt`.

One tempting summary of the logarithmic-height argument is also false: the
growth condition does not force the denominator interval length `L` to satisfy
`L>=c`. The exact case `N=21,t=1,c=11` has `L=9<c`. The valid conclusion is
only that `L<c` and absence of a coprime denominator cannot occur together;
the complement/totient contradiction is essential.

## 2026-08-02: the global fractional top-two dual is false

The fixed top pair `(14,16)` at `N=8` admits a useful vertex weighting of
mass `11/2>5`, with every possible lower speed seeing bad mass at most one.
This suggested a global fractional-dual invariant for every top pair. The
invariant is false.

At `N=7` and top speeds `(98,187)`, an exact nonnegative fractional cover of
all 1,224 mutually-top-good vertices has total mass `962/241<4`; every vertex
receives cover mass at least one. Weak LP duality therefore bounds every
candidate vertex weighting of the proposed kind below four, whereas the
strategy requires mass greater than `n-2=4`. The certificate is reproduced
by `scripts/audit_top_two_fractional_obstruction.sh`.

This does not refute the integral top-two pivot conjecture. Exhaustive exact
enumeration of all 3,464,840 four-lower-speed subsets finds no cover in this
instance; the best covers 1,142 vertices. The failure is specifically the
fractional proof invariant. See
`docs/top-two-fractional-obstruction.md` for the exact formulation.

## 2026-08-02: naive almost-saturated insertion formulas are not stable

The verified saturated family uses the relation between the runner count
`N`, the second-largest speed `A=N-2`, and its explicit residues. Replacing
one lower speed by a new speed `C>N-2` breaks that arithmetic; deletion and
insertion cannot simply reuse the same three formulas.

For

```text
N=5, speeds=(2,3,4,5), C=4, B=5,
```

one has `B=N*1` and `C` does not divide `1`. Naively transplanting the second
saturated case selects pivot `C` and residue `r=N-1=4`. It fails exactly at
the other top speed because

```text
cyclicResidueDistance 20 (4*5) = 0 < 4.
```

The actual complete top-pivot safe-residue sets are

```text
pivot 4: [2,3,17,18]
pivot 5: [3,4,21,22].
```

The transplanted fastest formula also fails. For

```text
N=5, speeds=(1,3,4,20), C=4, B=N*C*1,
```

it prescribes `r=(N-1)*N*1-1=19` at pivot `20`, but speed `1` has distance
`19<20`. The complete top-pivot profiles are

```text
pivot 4:  []
pivot 20: [41,42,43,44,56,57,58,59].
```

This failure isolates the missing minimum-speed hypothesis. If speed `1` is
deleted instead, then on `(2,3,4,20)` the same `r=19` gives respective cyclic
distances

```text
38,43,24,20
```

and succeeds. More generally, when `B=N*C*k`, the transplanted fastest
residue works under the additional condition `B<=r*m`, where `m` is the
least nonpivot speed. These examples reject the unconditional insertion
step, not the top-two conjecture.

## 2026-08-02: coarse top-speed divisibility cannot choose the pivot

The largest two speeds' residues modulo `N` and their basic divisibility flags
do not determine which top pivot succeeds. Consider the exact pair of
six-runner instances

```text
(1,4,5,6,7,11),
(1,3,4,5,7,18).
```

Both have `N=7`, second-largest speed `C=7`, `B congruent to 4 mod 7`,
`gcd(C,B)=1`, `C` not dividing `B`, and `N*C` not dividing `B`. Nevertheless
their complete top-pivot profiles require opposite pivots:

```text
(1,4,5,6,7,11):
  pivot 7:  [15,34]
  pivot 11: []

(1,3,4,5,7,18):
  pivot 7:  []
  pivot 18: [57,58,68,69].
```

Thus a case split using only those coarse invariants is refuted. It does not
rule out a finer classification retaining the exact top speeds and the lower
residue classes. It also does not refute the top-two conjecture: each tuple
has the displayed certificate at one top pivot.

## 2026-08-02: coefficient-two extra-blocker Hall matching fails

In the generic short-hole band under `2*t<=N`, every missing blocker `c`
satisfies `c>3*N/8`. Only `2*c` and `3*c` can be occupied multiples below
height `N+t`, and `3*c` is always above `N`. This suggests matching every
missing base height to an occupied extra multiple. The matching claim is
false.

For every `u>=1`, take

```text
N=4*u,
t=2*u,
S=[1,4*u] \ {2*u,3*u} union {6*u}.
```

This is a valid `N-1`-speed family of height `N+t`. Its base holes and extras
are

```text
M={2*u,3*u},  E={6*u}.
```

The extra speed `6*u` is simultaneously `3*(2*u)` and `2*(3*u)`, so both
holes have the same singleton neighborhood in `E`. Hall fails because
`2=|M|>|E|=1`. Moreover `4*u=2*(2*u)` is an occupied base blocker, confirming
that blocking need not consume an extra speed.

This infinite family does not refute the coefficient-two height theorem or
LRC. Put `q=6*u+1`. The complementary missing heights `2*u` and `4*u+1`
are below `q`, every selected speed is below `q`, `4*u<q<=8*u`, and
`gcd(2*u,q)=1` because `q-3*(2*u)=1`. The exact two-hole denominator lemma
therefore supplies a common closed `1/N` witness. What fails is only the
proposed injection/Hall closure. See `docs/coefficient-two-frontier.md`.

## 2026-08-02: the hard affine `k=1` fiber is jointly covered

The affine common-LCM construction is algebraically sound, but its principal
hard row does not supply the hoped-for cross-pivot rescue.  At

```text
N=7, A=98, B=187, epsilon=+1, k=1,
```

the six pairs that are candidates on both top grids are

```text
(87,166), (185,353), (283,540),
(381,727), (479,914), (577,1101).
```

The exact cross-top distances are `(195,295,99,97,293,197)` on the `A`-grid
and constantly `560` on the `B`-grid.  Thus the fourth `A`-grid pair is
already cross-top strict-bad because `97<98`; the other five are cross-top
good, and all six `B`-grid pairs are cross-top good.  More decisively, lower
speed `63` has distance constantly `7<98` on the first grid and `14<187` on
the second.  Thus it is strict-bad at both pivots for every pair, and the
single intersection

```text
D^A_63 intersect D^B_63
```

already covers the entire fiber.  The strict double-intersection sum
criterion necessarily fails there.  The quotient-lift identities reproduce
the same obstruction because `63=0 mod 7` and both base products have
quotient `55=6 mod 7` with positive remainder.

This is a failure of the selected `k=1` affine row, not of the complete affine
family.  It is not a counterexample to the top-two pivot conjecture or to
Lonely Runner.  Exact formulas and the endpoint audit are in
`docs/top-two-affine-fibers.md`.

## 2026-08-02: unconditional paired-transversal existence has an empty-grid counterexample

The proposed assertion that every top pair admits a shift family `H` with
`tau_H>N-3` is false under the robust-pair definition. At

```text
N=4, A=2, B=8,
```

every `A`-candidate has `rho_8(8*r)=0<2`, so the `A`-robust grid is empty.
Every selected robust-pair family is consequently empty for every `H`, and
the empty lower set is a transversal: `tau_H=0<=1`.

This does not refute top-two. The family `(1,2,8)` has the `B`-pivot
certificate `r=9`, with distances `(9,14,8)` modulo `32`. What fails is only
an unconditional theorem that insists on a paired robust fiber even when one
robust grid is empty. The corrected sufficient frontier is disjunctive: one
individual robust grid has cover number greater than `N-3`, or both grids are
nonempty and a selected pair family has transversal number greater than
`N-3`. See `docs/affine-transversal-frontier.md`.

## 2026-08-02: fixed affine internal-blocker charges collide

A coefficient-two charge choosing one of `3*c+1`, `3*c-1`, or `2*c` is not
injective even when every reciprocal is blocked. At `N=19,t=9`, the missing
and extra sets

```text
M={9,14}, E={28}
```

satisfy `3*9+1=28=2*14`. Retaining both low-hole alternatives still fails for
`M={9,13,14}`, `E={26,28}` because `3*9-1=26=2*13` and
`3*9+1=28=2*14`.

Neither family is an LRC counterexample. In both, `q=29`, `c=9`, and the
complementary missing height `20` give a direct two-hole witness. These rows
motivate the full coprime complementary neighborhood `Gamma(c)` recorded in
`docs/coefficient-two-gamma.md`; they refute only premature one-output
charging rules.

## 2026-08-02: matching the full Gamma containing rectangle is too strong

In the range `7*t<=3*N`, the generic Gamma triangle contains an equal pair of
consecutive intervals. It is tempting to prove a coprime perfect matching of
those full intervals and then restrict it to the actual candidate set. This
stronger rectangle statement is false at

```text
N=17, t=7,
left=[8,12], right=[18,22].
```

Both intervals contain three even and two odd numbers. Every left even would
need a distinct right odd partner, so no coprime perfect matching exists.
This is not a Gamma Hall counterexample: the short inequality removes `c=8`,
and `Auto(9)` holds via `d=25`, leaving `{10,11,12}`. The assignments
`10->21`, `11->18`, and `12->19` are valid Gamma neighbors. A successful
argument must exploit candidate pruning or split/sliding rectangles rather
than demand a matching of the full containing hull.

## 2026-08-02: strict Gamma pair-energy exclusion is false

The exact Cauchy--Schwarz pair-energy inequality does not become strict merely
because every proper subset is Hall-good. At `(N,t)=(14,6)`, let

```text
A={6,8,9,10},
Gamma(6)={17,19},
Gamma(8)={15,17,19},
Gamma(9)={16,17,19},
Gamma(10)={17}.
```

Every proper subset satisfies Hall. With `m=4`, the total incidence count is
`e=9` and the total pair-intersection energy is `p=9`, so the proposed strict
comparison fails at equality:

```text
e^2=(m-1)*(e+2*p)=81.
```

This is not a selector counterexample: the union is `{15,16,17,19}`, of size
four, and the full set is Hall-good. It rejects only `ENERGY-EXCLUSION` and
shows that a successful energy argument needs genuinely new arithmetic input.

## 2026-08-02: one completed descending Gamma matching need not have strict reachability

The fixed-matching dependency theorem says that strict Hall is equivalent to
every left vertex reaching an unmatched-neighbor vertex for that fixed
matching. It is tempting to expect the descending least-neighbor matching to
have this property automatically. At `(N,t)=(20,10)`, the exact candidate
rows are

```text
10:{21,23,27,29},
11:{21,23,24,25,26,27,28,29},
12:{23,25},
13:{21,22,23,24,25,27},
14:{23,25},
15:{22,23}.
```

The descending matching

```text
15->22, 14->23, 13->21, 12->25, 11->24, 10->27
```

leaves `{12,14}` successor-closed and free of vertices seeing an unmatched
right neighbor; its neighborhood is exactly `{23,25}`. Thus `12` and `14`
do not reach a marked vertex. Independent direct reconstruction reproduces
every row and dependency edge.

This is not a Gamma Hall counterexample: the displayed map already saturates
the full candidate set. It refutes only the claim that one canonical completed
matching must itself certify strict Hall. A surviving augmentation proof must
contract or rematch tight dependency blocks.

## 2026-08-02: unannotated atomic contraction is vacuous

Every critical deficiency-one set with at least two left vertices has every
co-singleton tight. Contracting any one deletes the full right neighborhood
and leaves one isolated left vertex. Lean proves this in
`CriticalCoreContraction.lean`. Thus `GAMMA-ATOMIC-EXCLUSION`, when the
contraction forgets deleted labels and neighborhoods, cannot retain arithmetic
content. Nonspanning contraction with an explicit puncture certificate is the
corrected open route.

Even repaired terminals are not canonical. The critical rows
`0:{0,1,2}`, `1:{1,2}`, `2:{1,2}`, `3:{0}` admit maximal nonspanning tight
blocks producing terminals of different sizes. No potential may assume a
unique terminal or an order-independent cardinality.

## 2026-08-02: three fixed J1 shifts do not suffice

At `(N,t)=(20,9)`, shifts `{-1,0,1}` leave the exact offset rows

```text
10:{1}, 11:{1,3}, 12:{3}, 13:{3,4,5}, 14:{5}.
```

The first three rows have only `{1,3}`. Full Gamma nevertheless has the SDR
`10->27,11->21,12->23,13->22,14->25`. Exhausting every effective fixed shift
family of size at most three shows none works across the four active `N=20`
instances; the four size-four survivors all fail at `(21,9)`. This rejects
only small fixed extensions of J1, not adaptive translation families or Gamma
Hall.
