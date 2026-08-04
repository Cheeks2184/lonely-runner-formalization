# Response85 independent mathematical audit

Audit task: `P85-MATHEMATICAL-AUDIT-251`

Base: `f6a22522892d53f53b43437a4e9bc7a2fe2c1317`

Audited prompt: `research/sol-pro/prompts/prompt85.md`, SHA-256
`491e11edbb5fb88756f09f635f08203427035c3ab1eef62c4d18605d7e120255`
(17,217 bytes).

Audited response: `research/sol-pro/responses/response85.md`, SHA-256
`59196ec701c39ab56d8a945897b1719060c3a4070e132597a2f273aad6897722`
(36,817 bytes).

## Provisional disposition

The appropriate disposition is **mixed / provisional STOP**.

The response's generic normalized-construction mathematics is correct at
`proved-math-qualified` scope: parent and tree properties, running
intersection, the exact construction-count formula, the local junction upper
bound, the introduction identity, the component identity, strict modular
intersection formulas, and common-scaling and permutation laws all admit
direct proofs from the frozen definitions.

The tuple

```text
(1,2,5,7,9,11,12,13)
```

also has the response's exact candidate grids, union sizes, uncovered sets,
and ordinary pivot certificate at pivot `7`, numerator `8`. These were
recomputed independently without enumerating width-two constructions.

However, the claimed minima over `793,800` normalized constructions at each
pivot have not been independently replayed. Prompt85 returned no verifier or
output attachment. The claimed source/output hashes identify no recovered
bytes, and the scan counts and three-way DP agreement cannot be checked from
the recovery package. Therefore the tuple is only a **computed-unverified
candidate counterexample** to `WIDTH-TWO-JUNCTION-COVER-DEFICIT`. The
universal target cannot yet be promoted to `rejected`.

The exact first unverified edge is

```text
for each uncovered pivot j in {3,4,5,6,7} and every normalized D,
  J_j(D) >= |R_j|.
```

Equivalently, the minimum disconnectedness penalty must be at least the exact
uncovered count at each of those five pivots. The generic theorem settles the
three covered pivots `j=0,1,2`, but it does not settle these five universal
finite quantifiers.

No response-authored construction enumeration, minimum, scan count, verifier
hash, state count, named-fixture replay, or DP-agreement claim is accepted in
this audit.

## Recovery and immutable diff-check boundary

The recovery provenance states that Prompt85 supplied only the normalized
response and no source/output attachment. It records exactly three immutable
`git diff --check` exceptions in the response at lines `665`, `877`, and
`1277`; each complete line consists of seven `=` characters used as an
equation separator. They are bound by the response hash, are not merge
markers, and are not changed here.

Those pre-existing response exceptions do not apply to this audit file. The
one-file audit diff against the exact base has no whitespace error and passes
`git diff --check` without an exception.

## Frozen construction and exact count

Fix a pivot `j` and write `m=|O_j|=n-1`. If `m<=3`, the sole construction is
the one root bag `O_j`.

For `m>3`, a normalized construction chooses a bijective introduction order
`sigma`, with only the first-root symmetry removed by

```text
sigma(0) < sigma(1) < sigma(2).
```

The root is the set of those first three owners. At step `k>=3`, choose an
increasing pair `S_k` occurring in an earlier bag, add the new bag

```text
S_k union {sigma(k)},
```

and make its parent the least earlier bag containing `S_k`. Owner labels are
never quotiented by equality of bad sets.

### Parent, tree, bags, and running intersection

Separator admissibility makes the finite set of earlier containing bags
nonempty, so the least parent exists and has strictly smaller index. Every
nonroot bag has exactly one such parent. Iterating parents strictly decreases
the natural bag index and reaches the root. The graph is connected; an
undirected cycle is impossible because its largest-index vertex would need
two smaller-index incident edges although it has only one parent edge.
Therefore the parent graph is a rooted tree.

Before step `k`, every earlier bag contains only owners introduced before
`sigma(k)`. Thus the new owner is not in `S_k` or its parent. Every general
bag has three owners, its intersection with its parent is exactly `S_k`, and
every separator has two owners. The root introduces the first three owners
and each later bag introduces the next one, so the bags cover `O_j`.

For running intersection, induct over bag introduction. A new owner initially
occurs only in its introduction bag. An old owner added to a new bag belongs
to `S_k`, hence also belongs to the parent bag. Attaching the new bag there
preserves connectivity of that owner's occurrence set. Owners absent from
the new bag are unchanged. Hence the bags containing any fixed owner induce a
connected subtree.

### Construction cardinality

The normalized introduction orders number

```text
m!/3! = binom(m,3)*(m-3)!.
```

After `t` owners have been introduced, exactly `2t-3` distinct owner pairs
occur in earlier bags. The root supplies three pairs. Each later introduction
uses one old pair and creates exactly two new pairs incident to its new owner;
those pairs cannot have appeared earlier. Thus the exact construction count
for `m>3` is

```text
binom(m,3)*(m-3)! * product_(t=3,...,m-1) (2t-3).
```

For seven owners this formula evaluates to

```text
(7!/3!)*(3*5*7*9) = 840*945 = 793,800.
```

This proves the cardinality of the finite construction type. It does **not**
prove that Response85 enumerated the type or computed its minimum correctly.

## Generic local junction mathematics

For an owner subset `S`, write

```text
U(S) = union_(i in S) B_i^j.
```

For a construction `D`, set `A_b=U(bag_b)` and, for a nonroot child `c`,

```text
C_c = U(bag_c intersect bag_parent(c)) = U(S_(c+2)).
```

All following cardinalities are cast to `Int`.

### Local junction upper bound

Choose a nonroot leaf `c` and put `W=union_(d!=c) A_d`. The parent remains in
the family, so

```text
C_c subset A_c intersect A_parent(c) subset A_c intersect W.
```

Exact finite-cardinality inclusion-exclusion gives

```text
|W union A_c| = |W| + |A_c| - |W intersect A_c|
              <= |W| + |A_c| - |C_c|.
```

Remove the leaf and its parent edge and induct on the remaining rooted tree.
The one-bag case is equality. Because the bags cover all owners, the result is

```text
Int(|union_(i in O_j) B_i^j|) <= J_j(D).          (1)
```

Subtraction is in `Int`, not truncated `Nat`. The left side is nonnegative,
so `(1)` also proves `0<=J_j(D)`.

### Introduction identity

A child bag is `S union {z}` for its new owner `z`. Since

```text
U(S union {z}) = U(S) union B_z^j,
```

its bag-minus-separator contribution is exactly

```text
|B_z^j \ U(S)|.
```

Therefore

```text
J_j(D)
  = Int(|U(root bag)|)
    + sum_(children c) Int(|B_(sigma(c+2))^j \ U(S_(c+2))|).    (2)
```

### Component identity

For an owner `i`, let `T_i` be its connected occurrence subtree. For a
covered candidate `r`, take the union `H_r` of `T_i` over all owners whose
bad set contains `r`.

A tree vertex belongs to `H_r` exactly when its bag union contains `r`. A
tree edge belongs to `H_r` exactly when its separator union contains `r`.
Thus its contribution to `J_j(D)` is

```text
|V(H_r)| - |E(H_r)|.
```

The graph `H_r` is a nonempty forest, so this difference is its number
`kappa_D(r)` of connected components. Summing candidate indicators yields

```text
J_j(D) = sum_(r in union_i B_i^j) kappa_D(r),                    (3)

J_j(D) - |union_i B_i^j|
  = sum_(r in union_i B_i^j) (kappa_D(r)-1).                     (4)
```

Equations `(1)`--`(4)` are `proved-math-qualified` generic finite-set
statements. They are independent of the unverified minimization.

If `G_j=|R_j \ union_i B_i^j|`, then `(4)` gives the exact criterion

```text
J_j(D)<|R_j|
iff
sum_(r in union_i B_i^j) (kappa_D(r)-1) < G_j.                  (5)
```

Consequently a covered pivot (`G_j=0`) can never give a strict deficit. An
uncovered pivot succeeds only when its disconnectedness penalty is smaller
than its uncovered count.

### Genuine abstract width-two loss

The response's abstract four-owner example is correct. Give the universe one
point `e_uv` for every unordered owner pair `{u,v}`, covered by exactly those
two owners. The exact union has six points. A normalized construction has a
root triple and introduces the fourth owner on a root pair. The point shared
by the introduced owner and the root owner omitted from that separator has
two disconnected owner subtrees; all other pair points are connected. Hence
every construction has `J=7` while the union has size six.

This shows that width two can overcount from `m=4` (`n=5`) onward. It is an
abstract set-system fact, not a modular LRC counterexample.

## Strict modular and candidate boundaries

For a pivot speed `p`, put `M=Np`. The canonical candidate grid is

```text
R_j = {0<=r<M : N does not divide r}.
```

Exactly the `p` representatives `0,N,...,(p-1)N` are excluded, so

```text
|R_j| = Np-p = (N-1)p = n*p.
```

Strict badness `rho_M(r*a_i)<p` is equivalent to the product phase lying in
the image modulo `M` of

```text
T_p = {-(p-1),...,0,...,p-1}.
```

The endpoints `-p` and `p` are absent and equality is safe. Since
`2p-2<M` for `N>=4`, reduction is injective on this target interval. Both
cyclic sides and the zero target are retained.

For one, two, or three owner labels `A`, the response's generalized-CRT
formula is also correct. For owner `i`, set

```text
g_i=gcd(a_i,M),  d_i=M/g_i.
```

The congruence `a_i*r=t_i mod M` has solutions only when `g_i|t_i`; after
division it fixes one class modulo `d_i`. A target vector is compatible iff
these classes agree pairwise modulo `gcd(d_i,d_h)`, and then it has
`M/lcm_i(d_i)` solutions modulo `M`.

Excluded candidates are exactly `r=Ns` with `s mod p`. They can occur only
when every `N|t_i`; after division one obtains the analogous system modulo
`p`, with `h_i=gcd(a_i,p)` and `e_i=p/h_i`, contributing
`p/lcm_i(e_i)` excluded solutions when compatible. Subtracting those exact
fibres retains nonunits, collisions, coincident labelled sets, and candidate
exclusion. The singleton specialization is

```text
|B_i^j|
 = g_i*(2*floor((p-1)/g_i)+1)
   - h_i*(2*floor((p-1)/(N*h_i))+1).
```

Pair/triple inclusion-exclusion and

```text
|U({x,y,z})|-|U({x,y})|
  = |B_z^j \ (B_x^j union B_y^j)|
```

then follow exactly. These formulas compute local costs but do not select a
pivot or prove the open universal target.

## Scaling and permutation laws

For common positive scaling `a'_i=c*a_i`, the pivot modulus changes from `M`
to `cM`. Reduction `r' -> r' mod M` has exactly `c` fibres. Because `N|M`,
candidate membership is preserved along each fibre. Moreover

```text
rho_(cM)(r'*(c*a_i)) = c*rho_M((r' mod M)*a_i).
```

Thus every owner-labelled bad set at the scaled tuple is the full preimage of
the original bad set. Every bag union, separator union, exact union, and
candidate grid has cardinality multiplied by `c`, giving

```text
J'_j(D)=c*J_j(D),
|R'_j|=c*|R_j|.
```

Strict deficit is preserved in both directions. This justifies primitive
normalization for searches after the usual common gcd is removed.

A coordinate permutation relabels pivots and owner-labelled bad sets. Apply
the relabeling to every bag and separator; sort each encoded separator and
sort the first three entries of the introduction order. Sorting those first
three changes only their root-order representation, not the root bag or later
introduced owners. Availability, least-parent indices, and every `J` term
are preserved. The inverse relabeling gives a bijection between normalized
construction sets, so minima and existential deficit are permutation
invariant.

These laws are `proved-math-qualified`; the response-authored scaling and
permutation fixture executions remain unverified.

## Fresh literal pivot-grid audit

For

```text
a=(1,2,5,7,9,11,12,13),  n=8,  N=9,
```

the following table was recomputed directly from the strict bad-set
definition. Only candidate grids and owner badness were enumerated; no
normalized construction or dynamic-program state was evaluated.

| `j` | `p_j` | `M_j` | `|R_j|` | exact union | `G_j` | complete uncovered set `Q_j` |
| ---: | ---: | ---: | ---: | ---: | ---: | --- |
| 0 | 1 | 9 | 8 | 8 | 0 | empty |
| 1 | 2 | 18 | 16 | 16 | 0 | empty |
| 2 | 5 | 45 | 40 | 40 | 0 | empty |
| 3 | 7 | 63 | 56 | 50 | 6 | `{8,20,22,41,43,55}` |
| 4 | 9 | 81 | 72 | 64 | 8 | `{10,21,26,28,53,55,60,71}` |
| 5 | 11 | 99 | 88 | 82 | 6 | `{26,35,37,62,64,73}` |
| 6 | 12 | 108 | 96 | 90 | 6 | `{26,28,38,70,80,82}` |
| 7 | 13 | 117 | 104 | 96 | 8 | `{28,37,41,44,73,76,80,89}` |

This verifies the response's non-minimum pivot columns and least uncovered
residues. At pivots `0,1,2`, equation `(1)` immediately gives
`J_j(D)>=|R_j|` for every construction because the exact union already equals
`R_j`.

At pivot `j=3`, choose `r=8`. It is a candidate because `9` does not divide
`8`. The centred distances modulo `63`, in speed order, are

```text
(8,16,23,7,9,25,30,22).
```

Every value is at least the pivot speed `7`; the pivot coordinate attains
equality and is safe. Thus `8 in Q_3`, and time `8/63` gives circle distance
at least `7/63=1/9` for every speed. The tuple is not an LRC counterexample.

For the five uncovered pivots, the independently verified information reduces
the candidate-counterexample obligation to these exact penalty bounds:

| `j` | required universal lower bound |
| ---: | --- |
| 3 | `sum_r (kappa_D(r)-1) >= 6` for every normalized `D` |
| 4 | `sum_r (kappa_D(r)-1) >= 8` for every normalized `D` |
| 5 | `sum_r (kappa_D(r)-1) >= 6` for every normalized `D` |
| 6 | `sum_r (kappa_D(r)-1) >= 6` for every normalized `D` |
| 7 | `sum_r (kappa_D(r)-1) >= 8` for every normalized `D` |

Response85 claims stronger exact minima, including penalty `8` rather than
`6` at `j=5`, but none of these five universal finite bounds is accepted
without a fresh replay. A displayed construction can establish only an upper
bound on a minimum; it cannot establish that no lower-cost construction was
omitted.

## Evidence and usefulness after the candidate STOP

The following generic statements qualify as `proved-math-qualified`:

- finite normalized encoding and exact construction cardinality;
- parent existence, rooted-tree structure, exact bag/separator intersections,
  owner coverage, and running intersection;
- `LOCAL-JUNCTION-BOUND` in `Int`;
- the introduction-order marginal identity;
- the owner-subtree component/overcount identities;
- the abstract earliest width-two loss at four owners;
- strict target-band and candidate-grid arithmetic;
- generalized-CRT intersection counting with candidate subtraction;
- common-scaling and coordinate-permutation invariance; and
- the tuple's exact pivot grids and ordinary certificate.

They remain mathematically valid even if the universal target is ultimately
rejected. Their main reusable content is diagnostic: equation `(5)` isolates
the exact disconnectedness penalty that any modified junction invariant must
control, and the CRT formulas evaluate its local costs. They do not themselves
produce a pivot or shorten the remaining unrestricted existential edge.

Under Full-Proof Priority Mode, formalizing these generic lemmas is not a
material LRC advance unless a new unrestricted bridge uses them. The immediate
useful action is the narrow replay that decides whether the supplied tuple
really rejects this invariant. Larger bounded scans, the response's DP state
counts, and documentation polish do not close that edge.

## Recommended Medium specification fragment

Classification: **`MEDIUM-SPEC-REQUIRED`**, not yet `LUNA-READY`.

A future narrow task should freeze exactly one layer: literal replay of the
single tuple `(1,2,5,7,9,11,12,13)` over all eight pivots and the exact
normalized construction type from Prompt85. It should report the complete
domain marker, construction cardinality, `|R_j|`, union, `G_j`, minimum `J`,
and lexicographically least minimizer for each pivot, with strict badness,
candidate exclusion, least-parent normalization, and deterministic ordering
fixed before launch.

Before admission, Sol Medium should supply success, equality, collision, and
malformed-input fixtures from already proved generic cases, including the
one-bag equality case and the four-owner pair-incidence example. The required
deliberately wrong expectation should alter a proved synthetic fixture, not
assume the disputed tuple minimum. Source/output binding, completion markers,
hashes, exact allowed paths, report fields, time budget, and fail-closed
cleanup must be frozen.

The first task must not include an optimized DP, broad tuple scan,
documentation integration, or status promotion. If the literal result passes
Medium review, a separate independently implemented optimized replay may be
specified and compared. Only a complete reviewed agreement can promote the
single-tuple result to `computed finite evidence` and permit Sol High to
reject the universal width-two invariant.

## Final labels and gaps

| Item | Audit label |
| --- | --- |
| Generic normalized/tree/junction/intersection/scaling mathematics | `proved-math-qualified` |
| Tuple pivot grids, uncovered sets, and certificate | `proved-math-qualified` finite arithmetic |
| Construction-type cardinality `793,800` at seven owners | `proved-math-qualified` combinatorics, not an execution claim |
| Claimed minima and least minimizing constructions | response-authored computation, unverified |
| Claimed scans, counts, hashes, and literal/DP agreement | response-authored computation, unverified |
| Tuple as a counterexample to the universal invariant | computed-unverified candidate |
| `WIDTH-TWO-JUNCTION-COVER-DEFICIT` | provisional STOP; rejection pending fresh replay |
| Strict-deficit implication through the accepted pivot bridge | `conditional` |
| New Lean status | none |
| Unrestricted LRC | `open` |

Recommendation to Sol High: preserve Response85 as a promising, exact-scope
negative candidate; accept the generic manuscript lemmas; commission only the
frozen single-tuple literal replay; and do not promote `STOP` to a rejected
universal theorem until the five uncovered-pivot minima survive independent
completion and review.
