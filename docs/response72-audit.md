# Response 72 mathematical audit

## Scope and disposition

This document independently audits canonical Response72 at recovery commit
`dc644fd6828a47400e0456663ccb0d1d5c60876e`, whose exact response blob has
SHA-256 `1bd95673813274756e246ede8596099c554a31b57cdc9665e65bdabff2b7a0ec`.
The recovered attachments are not opened or executed. Their future replay
remains `MEDIUM-SPEC-REQUIRED` under artifact audit 169.

Response72's self-disposition `STOP` is not accepted merely because the
response states it. Independent audit nevertheless reaches the same route-level
conclusion for a precise reason: as a schema over all dimensions,
`MODULAR-COVER-CIRCUIT-ESCAPE` is equivalent to the positive-integer Lonely
Runner Conjecture. It is a finite canonical reformulation, not a narrower
unrestricted bridge.

The audit recommends the following manuscript results for `proved-math`,
subject to Sol High promotion:

- exact cover and canonical-circuit construction, uniqueness, minimality, and
  relative private points;
- reflection and fixed-point classification, pivot safety, and common-scaling
  invariance of the complete-cover/circuit data;
- coverage-polymatroid identities and the exact gcd-dependent singleton count;
- the arbitrary-`N` boundary-grid lemma, including every compactness,
  first-entry, endpoint, and integer-time-reduction step;
- the theorem that any nonempty closed subset produces a lower-dimensional
  positive-integer LRC counterexample;
- both implications proving schema equivalence; and
- the exact quotient/transport counterexamples and abstract local-rank
  countermodel at their stated scopes.

The reusable minimal-counterexample result is:

```text
Every positive-integer counterexample that is minimal in moving dimension has
no nonempty proper subset of its covered pivots closed under the canonical
cover circuits.
```

Indeed, a proper closed subset would itself be a smaller-dimensional
counterexample. This irreducibility theorem is unconditional once the
canonical circuits are defined; it does not prove circuit escape for arbitrary
tuples or rule out the whole pivot set in a counterexample.

All Response72 fixture batches, permutation/scaling regressions, scan totals,
and zero-closed-subset claims remain unaccepted pending audit 169. Unrestricted
LRC remains `open`.

## Frozen definitions and quantifiers

Let `n>=2`, put `N=n+1`, and let

```text
a : Fin n -> Nat
```

be positive and injective. For pivot `j`, put `p_j=a_j`, `M_j=N*p_j`, and

```text
rho_M(x) = min(x mod M, M-(x mod M)),
R_j = {r in {0,...,M_j-1} : N does not divide r},
B_i^j = {r in R_j : rho_(M_j)(r*a_i) < p_j}  for i != j,
U_j = union_{i!=j} B_i^j,
Q_j = R_j \ U_j.
```

Badness is strict `<p_j`; equality is safe. Residues use unique natural
representatives and cyclic distance includes both sides. Owner identities are
retained when modular residues or bad sets coincide.

Define

```text
Covers(j) :<-> Q_j is empty,
F(a) = {j : Fin n | Covers(j)}.
```

For `j in F(a)`, a complete owner cover is a subset

```text
C subset {i : Fin n | i != j}
```

such that `union_{i in C} B_i^j=R_j`. Order complete covers by

```text
(|C|, increasing list of the integer speeds {a_i : i in C})
```

lexicographically. The unique least cover is `C_j`, the canonical
modular-cover circuit.

The frozen schema is

```text
MODULAR-COVER-CIRCUIT-ESCAPE:

For every n>=2, every positive injective a : Fin n -> Nat,
and every nonempty S subset F(a),
there exist j in S and i in C_j such that i is not in S.
```

Its negation is the existence of a nonempty `S subset F(a)` satisfying

```text
for every j in S, C_j subset S.
```

Because every owner in `C_j` differs from `j`, this is equivalently
`C_j subset S\{j}`. This is the exact meaning of a **closed** subset below.

## Exact claim table

| Response lines | Exact claim | Independent result | Recommended label | Exact boundary |
| --- | --- | --- | --- | --- |
| 33--77 | `Covers(j)` iff the full owner union equals `R_j` | Valid | `proved-math` | Uses only `B_i^j subset R_j`; strict badness is retained. |
| 79--97 | Existence and uniqueness of `C_j`, inclusion-minimality, and a private point for each selected owner | Valid | `proved-math` | Injectivity makes the sorted speed list identify the owner subset; privacy is relative to `C_j`. |
| 106--119 | Reflection invariance and pivot safety | Valid | `proved-math` | The antipode is one fixed orbit; equality at `p_j` is safe. |
| 206--248 | Arbitrary-subset boundary-grid lemma at threshold `1/N` | Valid | `proved-math` | Requires positive integer speeds, nonempty finite `S`, `N>=2`, circle distance, and unrestricted real time modulo one. |
| 250--275 | Every nonempty closed `S` yields a positive-integer LRC counterexample in dimension `m=|S|` | Valid | `proved-math` | The standard threshold `1/(m+1)` is at least `1/N`; the inequality direction is essential. |
| 275--284 and 555--663 | Circuit escape iff positive-integer LRC as all-dimensional schemas | Valid | `proved-math` logical equivalence | This classifies strength; it proves neither equivalent statement. |
| 288--308 | Centered quotient is automatically a candidate in the owner-pivot grid | False | `rejected` | In `(1,3,4,5)`, pivot 3, owner 1, private `r=1` gives quotient zero. |
| 310--372 | Badness at the target circuit transports back to badness at the source private point | False | `rejected` | The same tuple with private `r=13` gives a target-bad quotient but source-safe owner 5. |
| 374--396 | A successful owner replacement necessarily decreases the canonical cover key | False | `rejected` | In `(1,6,11,12,13)`, replacement `{12}` is lexicographically later than canonical `{6}` at pivot 1. |
| 398--456 | Coverage rank is normalized, monotone, submodular, with exact marginal/private-point deficiency formulas | Valid | `proved-math` | It is a coverage polymatroid, not a matroid rank; singleton rank can exceed one. |
| 458--480 | Exact gcd-dependent formula for `|B_i^j|` | Valid with the subtraction displayed explicitly below | `proved-math` | Counts owner-labelled nonunit fibers and removes excluded `N`-multiples exactly. |
| 482--504 | Positivity of the internal deficit sum is equivalent to a real `1/N` witness for the subtuple | Valid | `proved-math` equivalence | Therefore this proposed rank inequality is the witness problem, not a consequence of submodularity. |
| 506--514 | Local normalized/monotone/submodular ranks plus private points force circuit escape | False as an abstract implication | `rejected` | The two-label singleton-grid model is closed. It is not an arithmetic LRC counterexample. |
| 516--546 | No closed subset among 2,429 bounded primitive tuples | Not checked here | unaccepted pending audit 169 | Recovered finite output only. |
| 695--707 | `STOP` refutes circuit escape | Invalid reading | schema `open` (logically equivalent to LRC); route `stop` | The response stops the proposed attacks and classifies strength; it does not refute the schema. |

## Canonical covers, minimality, and private points

For a covered pivot, the complete owner covers form a nonempty finite family:
the full nonpivot owner set is one member. The displayed key is totally ordered
lexicographically. Injectivity is essential for uniqueness: two different
owner subsets cannot have the same sorted list of speed values. A finite strict
total order has one least element, giving `C_j`.

If `D` were a proper complete subset of `C_j`, then `|D|<|C_j|`, contradicting
the first coordinate of the minimal key. Thus `C_j` is inclusion-minimal.
For `i in C_j`, if

```text
B_i^j subset union_{h in C_j\{i}} B_h^j,
```

then deleting `i` would preserve complete coverage. Hence

```text
B_i^j \ union_{h in C_j\{i}} B_h^j
```

is nonempty. Any point in this difference is private **within the canonical
cover**. An owner omitted from `C_j` may still cover it; owner labels are not
quotiented even when two bad sets coincide.

Common scaling by `c>0` preserves this entire structure. Reduction modulo
`M_j` maps the scaled pivot grid modulo `cM_j` onto the original grid with
exactly `c` lifts, preserves divisibility by `N`, and satisfies

```text
rho_(cM_j)(r*c*a_i)=c*rho_(M_j)((r mod M_j)*a_i).
```

Thus an owner subset is complete before scaling iff the same index subset is
complete after scaling. Multiplying every speed in every sorted key by the
same positive `c` preserves lexicographic order, so `F(a)` and every
owner-index circuit `C_j` are unchanged. Consequently closure and escape are
common-scaling invariant. Dividing by the common gcd therefore reduces to a
primitive tuple without changing circuit incidence, but primitivity does not
lower the logical strength of the schema.

## Reflection and pivot safety

Reflection `r |-> -r mod M_j` preserves `R_j`, each owner-labelled bad set,
their union, and `Q_j`. Its fixed residues satisfy `2r=0 mod M_j`. Zero is
excluded. The only other possibility is `M_j/2`, which lies in `R_j` exactly
when `N` is even and `p_j` is odd.

At that antipode, an even owner speed maps to zero and is bad; an odd owner
speed maps back to the antipode, whose distance `M_j/2` is at least `p_j`.
Thus a good fixed antipode occurs exactly for an all-odd tuple and is counted
once, not as a reflection pair.

For every `r in R_j`, write `r=Nq+k` with `1<=k<=N-1`. Then

```text
(r*p_j) mod (N*p_j)=k*p_j,
rho_(N*p_j)(r*p_j)=p_j*min(k,N-k)>=p_j.
```

The pivot coordinate is therefore always safe at the closed boundary.

## Boundary-grid lemma

Let `S` be a nonempty finite set of positive integer speeds, let `N>=2`, and
suppose a real time `t` satisfies

```text
circleNorm(t*a_i)>=1/N  for every i in S.
```

Integer speeds make all coordinates periodic with period one. Replace `t` by
its fractional part. It cannot become zero, because circle norm at integer
time is zero while `1/N>0`; hence take `0<t<1`.

On the compact interval `[0,t]`, define

```text
K={x : circleNorm(x*a_i)>=1/N for every i in S}.
```

Each coordinate map is continuous, so `K` is closed. It is nonempty because it
contains `t`, and therefore compact with a least element `x_0`. Zero is not in
`K`, so `x_0>0`.

If every coordinate were strictly above `1/N` at `x_0`, finiteness of `S` and
continuity would give a common left neighborhood still inside `K`, contrary to
minimality. Thus some `j in S` satisfies

```text
circleNorm(x_0*a_j)=1/N.
```

For a real number, equality of circle distance to `1/N` means

```text
x_0*a_j=k+1/N  or  x_0*a_j=k-1/N
```

for an integer `k` (at `N=2` the two descriptions may represent the same
antipode, which causes no problem). Hence

```text
x_0=(N*k +/- 1)/(N*a_j).
```

Reduce the numerator modulo `N*a_j` to `r in {0,...,N*a_j-1}`. The numerator
is congruent to `+/-1 mod N`, so `N` does not divide `r`. Changing it by a
multiple of `N*a_j` changes time by an integer; all integer-speed circle
positions remain unchanged. For every `i in S\{j}` the safe inequality at
`x_0` becomes

```text
rho_(N*a_j)(r*a_i)>=a_j.
```

This proves the boundary-grid lemma with the correct strict/closed boundary.
No density argument, limiting endpoint, or interchange of quantifiers is used.

## Closed subsets give lower-dimensional counterexamples

Let nonempty `S subset F(a)` be closed, and put `m=|S|`. For every `j in S`,

```text
C_j subset S\{j}
```

and `C_j` covers `R_j`. If the subtuple on `S` had a real witness at threshold
`1/N`, the boundary-grid lemma would produce `j in S` and `r in R_j` safe
against every other speed in `S`. In particular it would be safe against every
owner in `C_j`, contradicting coverage. Thus the subtuple has no `1/N`
witness.

Since `S subset Fin n`, `m<=n`, and therefore

```text
1/(m+1)>=1/(n+1)=1/N.
```

A standard `m`-speed LRC witness at threshold `1/(m+1)` would also be a
`1/N` witness. None exists. Reindexing the finite subset `S` by `Fin m`
preserves positivity and injectivity, so it is a genuine positive-integer LRC
counterexample in moving dimension `m`.

The case `m=1` is consistent: a covered pivot cannot have its nonempty grid
covered by the empty owner circuit, so a closed singleton cannot actually
occur. For `n=2`, each covered pivot has only the other owner available.
Singleton-cover rigidity gives `N*a_j | a_i`; two simultaneously covered
pivots would require strict divisibility in both directions. Hence the escape
schema is directly valid in dimension two.

## Both directions of schema equivalence

### Circuit escape implies positive-integer LRC

Handle `n=1` separately. With `N=2`, the unique pivot has no nonpivot owners;
`r=1` is a candidate and its pivot distance is exactly the safe value `p`.

For `n>=2`, suppose a positive injective tuple had every pivot covered. Then
`F(a)=Fin n`, a nonempty set. Applying circuit escape to `S=F(a)` would give
`j in F(a)` and an owner `i in C_j` outside `F(a)`. But every owner index lies
in `Fin n=F(a)`, a contradiction. Hence some pivot is not covered. Select
`r in Q_j`; the strict complement makes every nonpivot coordinate safe, and
pivot safety handles the pivot coordinate. This is the canonical pivot
certificate.

The existing Lean equivalences then give the positive-integer and real
conjectures in the right-to-left directions. This implication is conditional
on circuit escape; it does not prove it.

### Positive-integer LRC implies circuit escape

Assume positive-integer LRC in every dimension. Given arbitrary `n>=2`, tuple
`a`, and nonempty `S subset F(a)`, suppose for contradiction that `S` is
closed. Reindex the `m=|S|` positive injective speeds by `Fin m`. LRC supplies a
witness at threshold `1/(m+1)`, hence at the weaker threshold `1/N`. Apply the
boundary-grid lemma using the **original** `N=n+1`, not `m+1`. It gives a pivot
in `S` safe against all other members of `S`, contradicting its internal
canonical cover.

Therefore every nonempty `S subset F(a)` has a canonical-circuit owner outside
`S`, which is exactly circuit escape.

Consequently, as propositions quantified over every dimension,

```text
MODULAR-COVER-CIRCUIT-ESCAPE
  iff PositiveIntegerConjecture
  iff unrestricted real LRC.
```

The circuit schema is more verbose and gives an outgoing edge for every subset,
but the reverse boundary theorem shows that this apparent strengthening costs
no logical strength globally. It is exactly equivalent, not narrower.

The repository directions were checked against:

- `LonelyRunner/PivotBoundary.lean:454`, fixed-instance witness iff pivot
  certificate;
- `LonelyRunner/PivotBoundary.lean:479`, the positive-integer certificate
  schema;
- `LonelyRunner/PivotBoundary.lean:491`, positive-integer conjecture iff its
  pivot-certificate formulation; and
- `LonelyRunner/BHKRealReduction.lean:114`, real conjecture iff positive-
  integer conjecture.

## Coverage rank and gcd-dependent singleton formula

For a fixed pivot, define

```text
U_j(A)=union_{i in A} B_i^j,
rank_j(A)=|U_j(A)|,
def_j(A)=|R_j|-rank_j(A).
```

Then `rank_j(empty)=0`, it is monotone, and it is submodular. Indeed,

```text
U_j(A union D)=U_j(A) union U_j(D),
U_j(A intersection D) subset U_j(A) intersection U_j(D),
```

so the ordinary two-set cardinality identity yields the required inequality.
The exact marginal is

```text
rank_j(A union {i})-rank_j(A)=|B_i^j \ U_j(A)|.
```

At `C_j`, removal of owner `i` has deficiency exactly the number of its private
points and is positive. Singleton ranks can exceed one, so this is a coverage
polymatroid rather than a matroid rank.

For the singleton count put `p=a_j`, `b=a_i`, `M=Np`,

```text
g=gcd(b,Np),
d=gcd(b,p),
L=floor((p-1)/N).
```

Multiplication by `b` modulo `Np` has image the multiples of `g` and fiber
size `g`. The total number of residues, before removing `N`-multiples, mapping
into the strict arc `-(p-1),...,p-1` is

```text
g*(2*floor((p-1)/g)+1).
```

For excluded residues `r=N*k`,

```text
rho_(Np)(b*N*k)=N*rho_p(b*k).
```

Strict badness is therefore `rho_p(b*k)<=L`. Multiplication by `b` modulo `p`
has image multiples of `d` and fiber size `d`, giving exactly

```text
d*(2*floor(L/d)+1)
```

excluded bad residues. Thus the intended formula, whose subtraction is
visually obscured by the recovered Markdown rendering, is

```text
|B_i^j|
  = g*(2*floor((p-1)/g)+1)
    - d*(2*floor(L/d)+1).
```

The count includes all nonunit and repeated-residue fibers. It says nothing
about overlaps between different owners and cannot determine `C_j` or a
cross-pivot inequality.

For nonempty `S`, define

```text
D_N(S)=sum_{j in S} def_j(S\{j}).
```

All terms are nonnegative. A positive term is exactly a pivot candidate safe
against every other speed in `S`, which gives a real `1/N` witness by pivot
safety. Conversely, the boundary-grid lemma turns every such real witness into
a positive term. Therefore

```text
D_N(S)>0 iff the subtuple S has a real witness at threshold 1/N.
```

For closed `S`, every term is zero. Proving positivity to exclude closure is
therefore the subtuple witness problem itself, not a consequence of local
submodularity.

## Quotient and exchange failures

For a private source point, strict badness gives a unique centered equation

```text
r*b=q*N*p+e,  |e|<p,
```

because the strict arcs around consecutive multiples of `Np` are disjoint for
`N>=3`.

In `(1,3,4,5)`, take pivot `p=3`, owner `b=1`, and private point `r=1`.
At that pivot the three owner sets are the disjoint partition

```text
B_1^3={1,2,13,14},
B_4^3={4,7,8,11},
B_5^3={3,6,9,12}
```

of the twelve candidates, so all three owners are canonical and every listed
point is private to its owner. For `r=1`, `1=0*15+1`, so `q=0`, excluded from
the target grid at pivot one. Thus candidate membership does not transport.

For the same pivot and owner, `r=13` is private and

```text
13=1*15-2.
```

Now `q=1` is a candidate at pivot one and is bad there through its canonical
owner five. Nevertheless

```text
rho_15(13*5)=rho_15(65)=5>=3,
```

so owner five is safe at the original private point. Target badness does not
transport back. Algebraically, if additionally

```text
q*h=s*N*b+f,  |f|<b,
```

then

```text
b*(r*h-s*N^2*p)=e*h+N*p*f.
```

Divisibility of the right side by `b` supplies no bound on the cyclic distance
of its quotient.

The key-decrease failure is also exact. For `(1,6,11,12,13)`, `N=6`:

```text
C_1={6},
C_6={1,11,12,13}.
```

At pivot six, whose candidate grid consists of the nonmultiples of six modulo
36, the owner bad sets are

```text
B_1  ={1,2,3,4,5,31,32,33,34,35},
B_11 ={3,7,10,13,16,20,23,26,29,33},
B_12 ={3,9,15,21,27,33},
B_13 ={3,8,11,14,17,19,22,25,28,33}.
```

Their union is the full 30-point candidate grid. They have the following
private residues relative to the four-owner cover:

```text
owner 1:  {1,2,4,5,31,32,34,35},
owner 11: {7,10,13,16,20,23,26,29},
owner 12: {9,15,21,27},
owner 13: {8,11,14,17,19,22,25,28}.
```

Thus all four owners are necessary. At pivot one, both speed six and speed
twelve individually cover because each is divisible by the modulus six.
Replacing the diagonal owner one from `C_6` by owner twelve at pivot one gives
key `(1,[12])`, strictly later than canonical `(1,[6])`; using all available
non-diagonal owners increases cardinality. Successful coverage replacement
therefore does not guarantee descent of the frozen key.

These examples reject the specified quotient/elimination mechanisms, not the
circuit-escape schema itself.

## Local-submodularity countermodel

Take two abstract labels with singleton grids

```text
R_1={x}, R_2={y},
B_2^1=R_1, B_1^2=R_2.
```

Both coverage ranks are normalized, monotone, and submodular. Each canonical
circuit is a singleton and has a private point, while `{1,2}` is closed. This
is a valid countermodel to any derivation using only those local set-cover
axioms. It is deliberately not an arithmetic modular-cover tuple and therefore
does not refute LRC or circuit escape. A successful rank proof needs a new
cross-pivot arithmetic axiom.

## Reusable minimal-counterexample irreducibility

Order positive-integer counterexamples first by moving dimension. Let `a` be
minimal in dimension. Absence of every pivot certificate gives
`F(a)=Fin n`. Construct the canonical circuits at the original `N=n+1`.
Then no nonempty proper `S subset F(a)` can satisfy

```text
for every j in S, C_j subset S.
```

Otherwise the closed-subset theorem produces a positive-integer LRC
counterexample on `m=|S|<n` speeds, contradicting dimensional minimality.

This lemma is unrestricted, reusable, and materially narrower than the full
schema: it excludes proper closed subsets only inside a dimension-minimal
counterexample. It does not exclude `S=Fin n`, which is exactly the unresolved
possibility that all pivots of the minimal counterexample are covered. It also
does not bound height or supply a descent in maximum speed.

## Artifact boundary

This audit did not open or execute the recovered scan source or JSON. It does
not accept:

- the mandatory fixture table as a batch;
- 870 permutation checks;
- scaling regressions by two and three;
- the 2,429 primitive tuple count;
- the bounded absence of a closed subset; or
- any source/output binding, deterministic-ordering, or malformed-input claim.

Those remain recovered finite claims pending a Medium-frozen specification and
artifact audit 169. The explicit quotient and key counterexamples above are
accepted independently because their complete arithmetic is reconstructed in
this manuscript, not because of the attachments.

## Proof-obligation ledger

| ID | Exact obligation | Status after audit | First open or false edge | Disposition |
| --- | --- | --- | --- | --- |
| P72-S1 | Canonical complete cover, minimality, and private points | independently valid | Privacy only relative to selected owners | Accept as reusable structure |
| P72-S2 | Boundary-grid lemma for arbitrary positive integer subset and `N>=2` | independently valid | None at manuscript level | Accept; strong formalization candidate |
| P72-S3 | Closed subset gives lower-dimensional counterexample | independently valid | Requires reindexing and threshold comparison exactly as stated | Accept; minimal-counterexample lemma |
| P72-S4 | Coverage polymatroid and gcd singleton formula | independently valid | Local ranks do not couple pivots | Accept locally |
| P72-R1 | Centered quotient always belongs to target candidate grid | false | `(1,3,4,5)`, `r=1` | Stop |
| P72-R2 | Target badness transports to source private-point badness | false | `(1,3,4,5)`, `r=13` | Stop |
| P72-R3 | Successful replacement decreases canonical key | false | `(1,6,11,12,13)` | Stop |
| P72-R4 | Local submodularity/private points imply escape | false abstractly | Two-label closed set system | Stop without new arithmetic axiom |
| P72-EQ | Global circuit-escape schema | `open`, and equivalent to positive-integer and real LRC | Whole closed set remains possible exactly in a counterexample | Stop as narrower route |
| P72-MIN | Minimal counterexample has no proper nonempty closed covered-pivot subset | independently valid | Does not exclude the whole pivot set | Preserve and consider formalization |
| P72-V1 | Independently replay recovered finite artifacts | `MEDIUM-SPEC-REQUIRED` | Frozen data model, fixtures, binding, and malformed-input behavior | Audit 169 |

## Route recommendation and evidence boundary

Overall route disposition: **STOP** circuit escape as an independent bridge,
because it is exactly equivalent to the unresolved theorem and both proposed
derivations stop at explicit failures.

Preserve two results for downstream work:

1. the boundary-grid/closed-subset theorem, preferably formalized with its
   arbitrary-`N` statement; and
2. minimal-counterexample circuit irreducibility, which may constrain a future
   descent or deletion argument.

Do not retry quotient transport or local submodularity without a new arithmetic
operation that controls candidate membership, strict distance, and key descent
simultaneously.

Evidence labels after this audit:

- `proved-lean`: only the existing repository equivalences cited above.
- Recommended `proved-math`: the canonical-cover facts, reflection, pivot
  safety, common scaling, boundary-grid and closed-subset theorems, schema
  equivalence, coverage-rank identities, gcd singleton formula, explicit
  negative audits, and minimal-counterexample irreducibility.
- `computed finite evidence`: none accepted here; audit 169 is not yet
  specified or run.
- `rejected`: all three proposed quotient/exchange rules, derivation from local
  submodularity alone, and the claim that a proper closed subset would not
  refute LRC.
- `open`: circuit escape and unrestricted LRC; the two schemas are logically
  equivalent.
