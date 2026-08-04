---
owner: GPT-5.6 Sol High top-level desktop orchestrator
supervising_authority: /root
launch_runtime: original browser-capable desktop Codex session
role: Research Pipeline Medium Lead - unrestricted direct-pivot contract only
task_id: PIPE-P85-WIDTH2-JUNCTION-DEFICIT-CONTRACT-226
base_commit: 70ef1a13f7383e2e4af34f404cf7a863652b056f
admission: LAUNCH-READY
---

# Prompt 85: WIDTH-TWO-JUNCTION-COVER-DEFICIT

Develop or decisively refute one independent unrestricted direct-pivot route.
The proposed invariant upper-bounds a full pivot cover using width-two
junction trees of owner-labelled strict bad sets. First prove the generic
junction inequality. Then prove or refute the sole arithmetic assertion that
some pivot has a strict junction deficit.

This is one Sol Pro research contract, not a proof claim or evidence
promotion. Only GPT-5.6 Sol High under `/root`, using the original signed-in
browser-capable desktop session, may launch it in a genuinely new conversation
with GPT-5.6 Sol and Pro effort. Sol Medium prepared the contract. Luna may
later implement one frozen verifier or Lean lemma; it must not perform this
research. Do not edit a repository, launch another agent, or claim
unrestricted Lonely Runner.

## Exact pivot definitions and accepted boundary

Fix `n>=3`, put `N=n+1`, and let `a : Fin n -> Nat` be positive and
injective. For pivot `j`, write

```text
p_j = a_j,
M_j = N*p_j,
rho_M(x) = min(x mod M, M-(x mod M)),
R_j = {r in {0,...,M_j-1} : N does not divide r},
O_j = {i : Fin n | i != j},
B_i^j = {r in R_j : rho_(M_j)(r*a_i) < p_j}  for i in O_j,
Q_j = R_j \ union_(i in O_j) B_i^j,
G_j : Nat := |Q_j|.
```

Thus, definitionally, `G_j=|R_j \ union_(i in O_j) B_i^j|`.

Badness is strict `<p_j`; equality is safe. Keep both cyclic sides,
antipodes, reflection fixed points, excluded `N`-multiples, nonunits, gcd
degeneracies, coincident bad sets with distinct owner labels, modular residue
collisions, and all pivots.

Accepted `proved-lean` dependencies are the exact positive-integer
pivot-certificate equivalence and the real-to-positive-integer equivalence.
Thus an explicit `r in Q_j` gives time `r/(N*a_j)` and closed circle distance
at least `1/N` for every speed. Neither equivalence proves that any `Q_j` is
nonempty. Unrestricted LRC remains open.

## Finite normalized width-two junction constructions

Let `m=|O_j|=n-1`. A normalized width-two construction `D` for pivot `j` is
defined as follows.

### Small owner sets

If `m<=3`, `D` has one root bag

```text
bag_0=O_j
```

and no tree edge.

### General owner sets

If `m>3`, choose an owner ordering

```text
sigma : {0,...,m-1} -> O_j
```

which is a bijection. Normalize only the irrelevant first-bag symmetry by
requiring `sigma(0)<sigma(1)<sigma(2)` in the canonical `Fin n` order. Put

```text
bag_0={sigma(0),sigma(1),sigma(2)}.
```

For each `k=3,...,m-1`, choose an unordered two-owner separator `S_k`, encoded
as its increasing pair, satisfying

```text
|S_k|=2,
S_k subset bag_b for at least one earlier bag b<k-2.
```

Use new bag index `c=k-2` and define

```text
bag_c=S_k union {sigma(k)},
parent(c)=the least b<c with S_k subset bag_b.
```

The least-parent rule is part of normalization; it is not an optimization
choice. The tree edges are `(c,parent(c))` for `c>0`. The new owner
`sigma(k)` has not appeared in an earlier bag, so

```text
bag_c intersect bag_parent(c)=S_k.
```

First prove from these definitions:

1. the parent exists and is strictly earlier;
2. the parent edges form a finite rooted tree;
3. every bag has at most three owners and every separator has exactly two;
4. the bags cover `O_j`; and
5. **running intersection:** for every owner `i`, the bags containing `i`
   induce a connected subtree.

The running-intersection proof must be by the actual introduction order: old
owners in a new bag lie in its parent separator, and the new owner first
appears in that bag. Do not assume a general tree-decomposition theorem without
checking this normalized construction.

The construction set is finite. Give exact finite encodings for orderings,
separators, bags, and parents suitable for exhaustive enumeration and Lean.
Owner labels remain distinct even when their bad sets coincide.

## Junction functional and the local theorem

For `S subset O_j`, define

```text
U_j(S)=union_(i in S) B_i^j.
```

For a normalized construction `D`, define the exact integer

```text
J_j(D)
  = sum_b Int(|U_j(bag_b)|)
    - sum_(c>0) Int(|U_j(bag_c intersect bag_parent(c))|).
```

Use `Int`, not truncated natural subtraction. Prove first, by leaf induction
on the rooted junction tree,

```text
Int(|union_(i in O_j) B_i^j|) <= J_j(D).        (LOCAL-JUNCTION-BOUND)
```

At a leaf `c` with parent `b`, the separator supplies a certified part of the
overlap with the remaining bag-union family:

```text
U_j(bag_c intersect bag_b)
  subset U_j(bag_c) intersect union_(d!=c) U_j(bag_d).
```

Write the exact finite-cardinality inequality, remove the leaf, and retain all
other parent edges. Prove the single-bag base and derive `0<=J_j(D)`.

Also derive the exact introduction-order identity

```text
J_j(D)
 = |U_j(bag_0)|
   + sum_(c>0) |B_(sigma(c+2))^j \ U_j(S_(c+2))|,
```

with all cardinalities cast to `Int`. This follows because a child bag is its
separator plus one new owner. It is a useful reformulation, not the open
arithmetic target.

`LOCAL-JUNCTION-BOUND` is generic finite-set mathematics. Proving it alone is
not progress on unrestricted LRC and must not receive the sole target's
status.

## Sole unrestricted target

There is exactly one open target:

```text
WIDTH-TWO-JUNCTION-COVER-DEFICIT:
For every n>=3 and every positive injective a : Fin n -> Nat,
there exist a pivot j and a normalized width-two construction D for O_j
such that

  J_j(D) < Int(|R_j|).
```

Together with `LOCAL-JUNCTION-BOUND`, strict deficit gives

```text
|union_(i in O_j) B_i^j| < |R_j|,
```

so finite set difference yields an explicit `r in Q_j`. The accepted pivot
bridge then gives positive-integer LRC, and the accepted real/integer
equivalence gives unrestricted real LRC.

This target is a stronger sufficient invariant, not an equivalence
restatement. For `n<=4`, `|O_j|<=3`, the sole bag is all owners and `J_j(D)` is
the exact union cardinality. For `n>=5`, width two is a genuine restriction:
`J_j(D)` may strictly overcount the exact union. An LRC certificate need not
imply the existence of a strict junction deficit.

Audit this strength claim in both directions. Do not prove the target by first
assuming an uncovered pivot or by invoking the pivot equivalence backward.

## Route-separation requirements

This route must remain mathematically distinct from:

- Prompt82's all-pivot multiplicity average;
- Prompt74's Fourier, character, PSD, or signed-Gram route;
- Prompt78's private-point owner escape or sparse-cover exchange;
- Prompt76's private-demand Hall transport or external capacity;
- Prompt66's whole-block packing;
- prime or prime-power forcing;
- top-two, Gamma matching, or bounded-height arguments; and
- deletion, divisor-block, or induction witness lifting.

Do not rename one of those missing lemmas as a junction deficit. The junction
functional may be expanded by inclusion-exclusion or additive energy, but no
foreign route may supply its sole existential conclusion without a complete
new implication.

## Mandatory Attack A: exact modular intersections

For a triple bag `{x,y,z}` and pair separator `{x,y}`, derive

```text
|U_j({x,y})|
 = |B_x^j|+|B_y^j|-|B_x^j intersect B_y^j|,

|U_j({x,y,z})|
 = sum singletons - sum pair intersections
   + |B_x^j intersect B_y^j intersect B_z^j|.
```

Then express every leaf marginal exactly as

```text
|U_j({x,y,z})|-|U_j({x,y})|
  = |B_z^j \ (B_x^j union B_y^j)|.
```

Classify the singleton, pair, and triple intersections arithmetically. A bad
set is defined by target residues in the strict cyclic band

```text
{-(p_j-1),...,p_j-1} mod N*p_j
```

together with candidate exclusion `N does not divide r`. Count simultaneous
congruences with all gcd compatibility conditions, nonunit fibers, coincident
sets, both cyclic signs, zero targets, and candidate subtraction retained.
Do not cancel an owner speed or split CRT factors unless the required
coprimality is proved. Equality at distance `p_j` must not enter a bad band.

Use the exact formulas to seek a uniform choice of pivot, root triple,
introduction order, and available two-owner separators whose junction sum is
strictly below `|R_j|`. An average over constructions is useful only if its
strict inequality is proved from tuple arithmetic and then derandomized to one
normalized construction.

Stop Attack A at the first intersection estimate whose error can equal or
exceed the required one-unit strict deficit.

## Mandatory Attack B: elimination, uncrossing, or additive energy

Independently minimize `J_j(D)` over the finite normalized construction set.
Develop local exchanges of:

- root triple;
- owner introduction order;
- available separator pair; and
- leaf elimination order.

Give exact before/after formulas. A proposed uncrossing must preserve the
two-owner separator's occurrence in an earlier bag and the deterministic
least-parent normalization. It may not replace the construction by an
arbitrary width-two tree decomposition without proving normalization
completeness.

Alternatively sum the marginal identity over owner orders and separator
choices. Relate the result to exact pair/triple additive energy of the bad-set
incidence vectors. Prove any averaging weights, collision corrections, and
strict extraction. Determine whether covered pivots force equality while an
uncovered pivot supplies a quantitative gap, or whether width-two overcount
can consume every exact uncovered residue.

The attack succeeds only with a tuple-uniform theorem producing one `j,D`.
The statements

```text
min_D J_j(D) >= |union_i B_i^j|
```

and

```text
if min_D J_j(D)<|R_j| then Q_j is nonempty
```

are local consequences already built into the contract, not solutions.

## Mandatory exhaustive falsification

Build a literal exact verifier before trusting a proof pattern. For every
tested tuple, enumerate **every** normalized construction, not a greedy sample.
Use deterministic order:

1. dimension increasing;
2. maximum speed increasing;
3. increasing speed tuple lexicographic;
4. pivot index increasing;
5. normalized owner ordering lexicographic;
6. each unordered separator pair lexicographic; and
7. deterministic least parent as defined above.

For each pivot report:

```text
|R_j|,
|union_i B_i^j|,
G_j,
number of normalized constructions,
min_D J_j(D),
the lexicographically least minimizing construction,
and one least uncovered numerator if and only if G_j>0 (otherwise `none`).
```

Retain injective speeds whose distinct owners induce coincident bad sets or
repeated modular residues. Add synthetic labelled-set fixtures with identical
bad sets to test the junction evaluator. Repeated numerical speeds violate the
theorem premise and must be rejected explicitly rather than silently
deduplicated. Include:

- nonunit owners and gcd-degenerate intersections;
- `rho=p_j-1` bad and `rho=p_j` safe;
- excluded `N`-multiples;
- antipodes and both cyclic sides;
- owner permutations and canonical-order normalization; and
- common scaling.

If restricting the exhaustive speed search to primitive increasing tuples,
first prove the exact scaling law: under `a -> c*a`, candidate and bad-set
fibers replicate by `c`, every bag and separator union cardinality scales by
`c`, and strict junction deficit is preserved in both directions. Do not infer
this merely from LRC scaling.

These root literal preflight observations are contract-design data only, not
accepted evidence:

```text
no failure among primitive increasing tuples
  n=3,4,5 with maximum speed <=20,
  n=6 with maximum speed <=15;
```

and the named fixtures

```text
P76: (1,4,5,6,7,11),
P77: (6,7,168),
P78: (6,7,12,24,144),
P80: (1,3,16),
P82: (1,4,5,6,7,11,32)
```

were reported to have a strict junction deficit at a known certificate pivot,
while covered pivots often attained equality. Independently reproduce or
reject every observation. Do not cite it as verified, do not infer a uniform
theorem, and do not rely on a response-authored certificate without checking
the strict bad-set definitions.

You may add at most one new finite domain, chosen before execution to
distinguish a specific modular-intersection or uncrossing claim. No larger scan
may substitute for the unrestricted proof.

### Fail-closed counterexample rule

Stop on the first positive injective tuple for which:

```text
some pivot has an exact certificate,
but for every pivot j and every normalized width-two D,
J_j(D) >= |R_j|.
```

Emit the complete tuple, certificate pivot and numerator, every pivot's exact
union and minimum junction values, and the minimizing constructions. Such a
tuple refutes only `WIDTH-TWO-JUNCTION-COVER-DEFICIT`, not the pivot theorem or
LRC.

If a tuple has no strict junction deficit and the literal verifier also finds
no pivot certificate, do not call it an invariant counterexample and move on.
Treat it as a potential unrestricted LRC counterexample requiring immediate
independent exact replay and Sol High review.

Every verifier must specify exact finite types, malformed-input behavior,
success/failure/equality/collision fixtures, one deliberately altered expected
value that must fail, deterministic serialization, source/output hashes,
complete-domain termination, and an independent literal-versus-optimized
comparison. Finite output is `computed finite evidence` only after review.

## Exact implication chain

A successful proof must display:

```text
positive injective integer tuple a
  -> WIDTH-TWO-JUNCTION-COVER-DEFICIT gives j,D
  -> LOCAL-JUNCTION-BOUND
  -> |union_(i!=j) B_i^j| < |R_j|
  -> explicit r in Q_j
  -> proved-lean pivotResidueWitness
  -> positive-integer LRC
  -> proved-lean real/integer equivalence
  -> unrestricted real LRC.
```

State every cast between `Nat` cardinalities and `Int`, every strict
inequality, and the finite-set extraction. Do not call the chain complete if
the sole target remains open or is replaced by an average premise.

## Required response format

Return exactly these sections.

1. **Disposition** -- `PROVE`, `PIVOT`, or `STOP`.
2. **Frozen definitions and normalization audit** -- finite construction,
   least parent, tree, bag coverage, and running intersection.
3. **Local junction theorem** -- complete leaf-induction proof and marginal
   identity, clearly separated from the sole target.
4. **Logical-strength and route-separation audit** -- stronger-than-LRC
   direction, `n<=4` collapse, `n>=5` restriction, and excluded prior routes.
5. **Attack A: modular intersection classification** -- exact singleton,
   pair, triple, nonunit, and candidate-exclusion formulas.
6. **Attack B: elimination/energy** -- exact exchanges or averages, strictness,
   and first unsupported arrow or complete proof.
7. **Exhaustive falsification report** -- every normalized construction,
   preflight reproduction or rejection, fixtures, and at most one new domain.
8. **Sole theorem proof or counterexample certificate** -- exact universal
   proof, or the first certificate-bearing tuple with no width-two deficit, or
   a precise `PIVOT` lemma strictly narrowing the target.
9. **Complete implication chain** -- all inequalities, casts, witnesses, and
   evidence labels through real LRC.
10. **Proof-obligation ledger** -- statement, dependency, status,
    falsification, first open arrow, stop condition, and recommended owner.
11. **Verifier and Lean plan** -- frozen data types, theorem signatures,
    literal checker, independent optimized checker, and acceptance commands;
    no implementation.
12. **Final evidence boundary** -- separate `proved-lean`, generic
    `proved-math`, response-authored observations, computed finite evidence,
    conditional, rejected, and open.

`PROVE` requires the sole target for all `n>=3`. `PIVOT` requires one exact,
strictly narrower non-tautological lemma with a complete downstream chain and
mandatory-fixture survival; it promotes nothing. Return `STOP` on an exact
invariant counterexample, an LRC-equivalent restatement, a hidden uncovered
pivot assumption, an unclosed strict estimate, or a verifier that omits a
normalized construction.

## One-turn budget and stop rules

Use one Sol Pro turn. Spend the first quarter on normalization and the local
leaf theorem, the second on modular intersections, the third on independent
uncrossing/energy and falsification, and the last on theorem or counterexample,
implication chain, obligations, and implementation plan.

Stop immediately at lost owner labels, an unavailable separator, a nonleast
parent, failed running intersection, truncated natural subtraction, an
incorrect exact-union claim for `n>=5`, nonunit cancellation, weak badness,
unsafe equality, omitted normalized construction, hidden pivot certificate,
or finite evidence promoted to a theorem. A rigorous counterexample to this
stronger invariant is a successful result and does not change LRC status.
