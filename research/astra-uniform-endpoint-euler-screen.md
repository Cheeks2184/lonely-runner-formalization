# Endpoint Euler counts and the arithmetic bad-arc graph

Date: 2026-09-06. Registered task `/root/uniform_endpoint_euler_screen`,
executed by `/root/uniform_seed_coupling`; requested Astra/xhigh.
Supplied and read-back checkpoint:
`665a35f68d468be388e4bc3a7538ff3e8c8a9cd3`.
Only this report is owned. Current project config, workflow, policy and
focused state were read; workflow validation passed. Runtime model/effort,
elapsed time and token usage are not independently exposed.

**Result.** Finite Euler counting retains isolated closed witnesses exactly.
Its boundary-event identity is equivalent to the established endpoint supply
condition; positivity is not supplied by changing the invariant. A naive
integration of pointwise bounds is false, even on an explicit unbounded
family with every deletion seed nonempty. A separate graph argument yields
an exact gcd/ceiling edge-count obstruction to absence of all full witnesses.
The established translated lcm block satisfies that aggregate obstruction.
When at least one speed is even, exact graph disconnection is equivalent to
full witness existence, and consequently is still an unresolved uniform
supply target rather than a proof of it.

Two structural approaches were explored: endpoint Euler accounting and the
actual integer-speed bad-arc graph. No mathematical program, tuple search,
Lean implementation, dependency/cache operation, shared-state edit, Git
mutation or further delegation was performed. Root supplied the origin-clique
and reflection observations used in the graph refinements below; their
proofs and scope were checked here. The separate rational-margin-gap and
strict-slack directions were not pursued.

## Source contracts and conventions

Read source bindings:

| Input | SHA-256 |
| --- | --- |
| `LonelyRunner/EndpointCompleteness.lean` | `0e3f10f64daf41bedebf31bb71cb6b93ffa5358615c6c30ec941b01fc97b9d57` |
| `LonelyRunner/PairSumCompleteness.lean` | `838a3bcec806b0e9d01cd117e64e5348de58a05127a3f7bef5dbe2d879ff292f` |
| `research/astra-uniform-global-seed-geometry.md` | `3a4a825f3f801282eb39b469571bbd4cac3a4e1f768d58542b7c1555cd725524` |
| `research/astra-uniform-divisor-minimality.md` | `8c4b6ee094f0f311f360d3abf371e95f731e28cee997d3810dd3218ff6f25746` |

The existing theorem `exists_endpoint_time_of_witness` accepts positive
natural speeds and coordinatewise margins in `(0,1/2]`. A supplied witness
yields a feasible rising endpoint `(k+margin_p)/v_p` in `(0,1/2]` with
`k<(v_p+1)/2`. It does not supply a witness. The declarations
`exists_pairSum_time_of_witness` and `exists_witness_iff_pairSumCertificate`
preserve a supplied positive closed margin using an original distinct pair
and a time `r/(v_p+v_q)`. Their all-dimensional canonical equivalence is
already explicit in `conjecture_iff_pairSumCertificateConjecture`.

Here `n=N-1>=3`, the `v_i` are distinct positive integers,
`delta=1/N`, and all times are on `T=R/Z`. Define

```
H={t : every i has ||v_i*t||>=delta},
U_i={t : ||v_i*t||<delta},   U=union_i U_i.
```

The own-margin deletion sets remain
`S_p={s : every i!=p has ||v_i*s||>=1/(N-1)}`. Q asks whether a protected
ball from some `S_p` reaches `H`. The hypothesis `H=empty` is stronger than
failure of Q. An identity for `H` cannot silently be used as an identity for
the protected intersection `H intersect B`.

## Approach 1: exact Euler accounting, including singleton cells

Take every distinct threshold event `v_i*t=k+delta` or `k-delta` modulo
integers, add the cut point zero, and divide the circle into its point cells
and open-arc cells. Define the finite constructible Euler valuation by

```
chi(A)=number of point cells in A - number of open-arc cells in A.
```

Refining a cell preserves this value. A point and a nonempty closed proper
interval have value `1`; an open proper interval has value `-1`; a half-open
proper interval has value `0`. The circle has value `0`, because its cyclic
decomposition has equally many vertices and edges. Thus the fundamental
domain must not be treated as a closed interval with two different copies
of zero. This is a finitely additive valuation, not a positive measure.

Since `H` is closed and excludes a neighborhood of zero,

```
chi(H)=number of connected components of H,
H nonempty iff chi(H)>0.                         (1)
```

Singleton components count as one in (1).

At a distinct event time `t`, put

```
P(t)={i : fract(v_i*t)=delta},
M(t)={i : fract(v_i*t)=1-delta},
Z(t)={i : ||v_i*t||<delta}.
```

Let `h(t)=1_H(t)` and let `h_minus,h_plus` be its values on the immediately
adjacent open arcs. Positivity of speeds and `delta<1/2` give

```
h       = 1_(Z=empty),
h_minus = 1_(Z=empty and P=empty),
h_plus  = 1_(Z=empty and M=empty).
```

The exact symmetric and oriented formulas are

```
chi(H)=sum_t [h-(h_minus+h_plus)/2]
      =sum_t [h-h_minus]
      =sum_t [h-h_plus].                         (2)
```

Every open arc occurs twice in the symmetric sum with weight `-1/2`, and
once in either oriented sum. Each point occurs once. Simultaneous events
are combined at their actual common time, never counted once per label.

| Event | Local full-good geometry | Symmetric contribution |
| --- | --- | --- |
| `Z` nonempty | Point and its nearby arcs are covered | `0` |
| `Z` empty, only `P` nonempty | Left endpoint of a positive-length component | `1/2` |
| `Z` empty, only `M` nonempty | Right endpoint of a positive-length component | `1/2` |
| `Z` empty, both `P,M` nonempty | Isolated full witness | `1` |
| No contact and no strict bad label | Interior point, if added as a cut | `0` |

In particular, two or more simultaneous contacts on either side do not
multiply the contribution. An isolated point with several contacts of both
orientations still contributes exactly one.

Half-open step functions are legitimate only with the point correction in
(2). For example, copying the right-arc value to the preceding endpoint
gives a function constant on half-open cells and having Euler integral zero;
the corrections `h-h_plus` restore the actual closed set. The ordinary
signed jump `h_plus-h_minus` sums to zero around the circle and gives zero
at an isolated witness. It is therefore not a replacement for (2).

### Exact arithmetic and the remaining supply test

The left-oriented sum in (2) counts exactly the distinct event times with
`Z=empty` and `P` nonempty. Every such time is
`(N*k+1)/(N*v_i)` for an actual rising owner `i`. Hence positivity of that
sum asks whether one rising endpoint passes every closed margin test.
This is the endpoint supply condition already made complete by the read
Lean theorem, now with multiplicity removed. No new sign bound follows.

At an opposite-contact event, write

```
v_i*t=k_i+1/N,   v_j*t=k_j-1/N.
```

Then

```
N*(v_i*k_j-v_j*k_i)=v_i+v_j,
N divides v_i+v_j,
t=(k_i+k_j)/(v_i+v_j).                           (3)
```

The numerator lies strictly between zero and the denominator for
`0<t<1`. Thus an isolated threshold witness is also an actual pair-sum
time, consistent with the established completeness contracts. Same-oriented
coincidences instead require `N` to divide the speed difference. These are
necessary coincidence identities, not guarantees that `Z` is empty.

### Why pointwise inequalities cannot be integrated as bounds

Let `K=sum_i 1_(U_i)`. Pointwise `1_H>=1-K`. Monotonicity of ordinary
integration would suggest an Euler lower bound, but Euler valuation is not
monotone: even `0<=1_(U_i)` has integrals `0` and `-v_i`. In fact the
suggested bound would be

```
chi(H) >= chi(T)-sum_i chi(U_i) = sum_i v_i,      (false)
```

because each `U_i` consists of `v_i` open arcs.

An unbounded, hypothesis-complete actual family refutes this proposed
promotion. For prime `N>=5` and speeds `1,...,N-1`, the full-good set is
exactly `{a/N : 1<=a<N}`. Packing the `N` points `0,t,...,(N-1)t` proves
this: pairwise circular separation at least `1/N` forces all `N` cyclic
gaps to equal `1/N`. Thus

```
chi(H)=N-1 < N*(N-1)/2=sum_i v_i.
```

Every deletion seed is explicitly available, as proved in the bound global
geometry report: for `p<n=N-1`, put `q=N-p>=2`, take `a*p=1 mod N`, and
use `s=a/N-1/[N*n*q]`. Speed `q` has norm `1/n`; every other retained norm
is at least `2/N-1/(N*q)>=3/(2*N)>=1/n`. For `p=n`, use `s=1/n`.
The pivot-1 seed `s=1/N-1/[N*n^2]` has radius `1/[N*n^2]` and score
exactly delta. Thus all seed hypotheses hold and Q succeeds at equality.
This is a failure of the purported Euler inequality, not of Q.

For Q itself, finite Euler counting could test `chi(H intersect B)>0`,
because that intersection is again a proper closed finite interval union.
This is exactly protected witness existence. Replacing it with `chi(H)>0`
would discard the unresolved protected-location requirement.

## Approach 2: the actual primitive bad-arc graph

For each speed `v_i` and `0<=k<v_i`, use the open circle arc

```
A_(i,k)={t : distance_T(t,k/v_i)<1/(N*v_i)}.
```

Their union is `U`. Construct the simple graph `G` with these arcs as
vertices and a single edge for each nonempty intersection. Arcs of the
same speed are disjoint. The total vertex count is
`V=sum_i v_i`. Graph components correspond exactly to components of the
union of these connected open arcs.

Two arcs from distinct speeds `a,b` have total lengths at most `3/N<1`,
since `1/a+1/b<=3/2`. Their intersection, when nonempty, is one connected
open arc. Finite nonempty intersections are likewise connected: work in
interval coordinates on one arc and intersect its connected interval
intersections with the others.

Consequently finite inclusion-exclusion gives an exact Euler identity

```
chi(H)=C_1-C_2+C_3-...,
C_r=#{r primitive arcs having nonempty common intersection},
C_1=V, C_2=E.                                  (4)
```

These `C_r` are in fact the graph's clique counts. A clique has at most one
arc of each speed, and the sum of those arc lengths is at most
`(2/N)*(1+1/2+...+1/(N-1))<1` for `N>=4`. The inequality holds at `N=4`
and persists on increasing `N`, since the new summand adds `2/N<1`.
There is a point outside all clique arcs; cut there. Pairwise-intersecting
intervals on the resulting line have a common point. Thus every clique
corresponds to an actual common-time intersection. Formula (4) does not
assume independently assigned coordinate phases. Its unresolved sign is
the same sign as (1).

### Exact pair counts and a legitimate aggregate obstruction

For two distinct speeds `a,b`, let `g=gcd(a,b)`. Arc centers `k/a,l/b`
overlap precisely when their circular separation is strictly less than
`(a+b)/(N*a*b)`. The differences `b*k-a*l mod a*b` range over the
multiples of `g`, each exactly `g` times. Put

```
L=a*b/g,   T=(a+b)/(N*g).
```

Here `T<L/2`. The centered residues modulo `L` having distance strictly
less than `T` number `2*ceil(T)-1`. Hence the exact edge count is

```
E=sum_(i<j) g_ij * (2*ceil((v_i+v_j)/(N*g_ij))-1).             (5)
```

The ceiling implements strict overlap. At integral `T`, the two residues
with distance exactly `T` are excluded: their arcs touch only at a point
outside both open bad arcs. Dropping this distinction would lose precisely
the closed witness contacts under investigation.

If `H` is empty, `U` is the circle and `G` is connected. The `n` arcs
centered at zero form an actual clique `K_n`. Contract that clique; a
connected graph needs at least `V-n` further edges to connect its other
vertices. Therefore a necessary condition for **absence of all full
witnesses** is

```
E >= V-n+choose(n,2).                            (6)
```

Conversely, violation of (6) proves a full delta witness, without using a
deletion hypothesis. This bound is legitimate graph counting, not an
integration of a pointwise Euler inequality. It has not been established
here as a necessary condition for Q failure: that failure does not assume
the absence of all full witnesses.

### Aggregate edge counts do not remove the established compatible family

For `N>=5`, take the existing family `v_i=L_N+i`, `0<=i<n=N-1`, with
`L_N=lcm(2,...,N)`. The cited divisor manuscript establishes its compatibility
with the earlier arithmetic profile. Here only its new edge inequality is
assessed. Since `N` and `N-1` are coprime,

```
L_N>=N*(N-1),  V>=N*n^2,
sum_(i<j) gcd(v_i,v_j) <= sum_(i<j)(j-i)=n*(n^2-1)/6.
```

Using `ceil(x)>=x` in (5) gives

```
E >= [2*(n-1)/N]*V - n*(n^2-1)/6,
E - [V-n+choose(n,2)] >= n*(5*n^2-21*n+10)/6 > 0.
```

The last polynomial is positive at `n=4` and increases thereafter. Thus
the family satisfies the stronger aggregate inequality (6) for every
`N>=5`, not just a selected finite list.

It also has every deletion seed: at `t=1/(2*L_N)`, all norms are
`1/2-i/(2*L_N)>(n-1)/(2*n)>=1/n`. This is a full gamma witness. The
family contains an even speed. Its **full graph is disconnected** by the
reflection lemma below; only its aggregate edge count passes (6). No
claim that it satisfies graph connectedness or `chi(H)=0` is made.

### Reflection turns connectedness into an exact supply reformulation

**Lemma.** If at least one speed is even, then

```
H nonempty iff G is disconnected.                (7)
```

The easy direction holds without parity: disconnected `G` gives a
disconnected union `U`, so `U` is not the whole circle. For the other
direction, integer speeds make `H` invariant under `t -> 1-t`. The bad
union contains zero, and an even speed puts `1/2` in it as well. A full
witness therefore has, after reflection, a representative `0<t<1/2`.
The two excluded points `t,1-t` separate zero from `1/2` on the circle.
The bad union contains both and omits both separators, so it is disconnected.
Its graph is disconnected too.

When all speeds are odd, `1/2` itself is a full witness; implication (7)
is not asserted. Thus an exact arithmetic graph-disconnection formulation
handles the nontrivial parity case, but proving it uniformly is again full
integer LRC supply. The explicit adjacency rule and Euler valuation have
not supplied that proof.

The deletion hypotheses have a precise graph interpretation. Assume now
`H=empty` and every `S_p` is nonempty. Delete every vertex of colour `p`.
The resulting graph describes the old delta-bad union. Whenever that old
tuple retains an even speed, its supplied gamma seed is a full old delta
witness, so the same reflection argument disconnects that graph. Hence
if at least two original speeds are even, `G` is connected but deleting
any entire colour disconnects it. With exactly one even speed, this is
asserted only for deletions of an odd speed. This is genuine simultaneous
graph coupling, but currently only restates the available deletion supply
at the weaker delta threshold. No bound on the higher clique terms or a
contradiction from these colour cuts was found.

## Remaining obligation and Lean relevance

The endpoint formula (2), the exact pair count (5), the aggregate obstruction
(6), and the parity equivalence (7) are manuscript results with complete
finite arguments above. They retain strict bad arcs, simultaneous contacts,
singleton full witnesses, the circle's Euler value zero, and actual integer
common-time compatibility. None establishes uniform witness supply or Q.

For endpoint Euler positivity, the missing step is exactly the existence of
an event with no strictly bad label. For the graph formulation, it is a
uniform proof of disconnection in the even-speed case, or a new effective
constraint on its cliques/colour cuts. Aggregate edge counting alone still
admits the established arithmetic compatibility family. A least-count
counterexample supplies all deletion seeds but does not remove these gaps.

The existing Lean endpoint and pair-sum declarations already capture the
first existence equivalence. New formalization could record the finite
cell valuation, gcd/ceiling pair count and graph/reflection lemmas; this
would require endpoint-sensitive source work and independent review. It
would not create the missing sign or disconnection theorem. No new Lean
declaration, axiom audit, mathematical execution receipt or completion
claim is made. Source hashes and workflow validation are the only tool
checks in this task; independent manuscript review remains necessary.
