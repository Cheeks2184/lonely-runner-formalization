---
owner: GPT-5.6 Sol High top-level desktop orchestrator
supervising_authority: /root
launch_runtime: original browser-capable desktop Codex session
role: Research Pipeline Medium Lead - unrestricted balanced-junction contract only
task_id: PIPE-P89-BALANCED-JUNCTION-CONTRACT-257
base_commit: cc58e9affd445af9cb5f77911c8ab823916bbeae
admission: REVIEW-REQUIRED
---

# Prompt 89: BALANCED-JUNCTION-COVER-DEFICIT

Develop or decisively refute one unrestricted successor to Prompt85's fixed
width-two junction route. The sole target replaces the fixed three-owner bag
by a dimension-dependent square-root bag bound chosen before any scan:

```text
b(m) = min(m, 1 + ceilSqrt(m)).
```

For every positive injective tuple, prove that some pivot admits one exact
normalized running-intersection construction of bag size `b(m)` whose junction
upper bound is strictly smaller than the pivot candidate grid. This is one
stronger sufficient theorem, not a request to invent a different invariant.

This file is a prepared research contract only. It is not a browser launch,
active cell, response, proof, computation, audit, or evidence promotion. Only
GPT-5.6 Sol High under `/root`, using the original signed-in browser-capable
desktop session, may open a genuinely new ChatGPT conversation, explicitly
select GPT-5.6 Sol with Pro effort, submit a reviewed hash-locked prompt,
recover the response, assign independent audits, and decide status. Sol Medium
prepared the contract. Luna may later replay one frozen finite artifact or
implement one frozen local lemma; Luna may not search for this theorem or
operate the browser.

Use one major turn. Prove every quantifier of the sole target, return one exact
counterexample, or isolate one strictly narrower non-tautological successor.
Do not edit a repository, launch an agent, or claim unrestricted LRC.

## Accepted boundary and current Prompt85 status

Unrestricted Lonely Runner remains open. Use these project results only at
their exact accepted scopes:

- `proved-lean`: the exact positive-integer pivot-certificate equivalence;
- `proved-lean`: positive-integer LRC is equivalent to real-speed LRC with
  positivity, injectivity, quantifiers, and the closed threshold preserved;
- `proved-math-qualified`: Prompt85's normalized construction count, parent
  and rooted-tree properties, bag coverage, running intersection, local
  junction upper bound in `Int`, introduction identity, component identity,
  strict modular bad-set formulas, and scaling/permutation laws;
- `proved-math-qualified`: Prompt85's candidate-grid arithmetic and ordinary
  certificate for `(1,2,5,7,9,11,12,13)`; and
- `computed-unverified`: Prompt85's claimed width-two minima, scans, hashes,
  and three-checker agreement.

Prompt85 has a mixed / provisional `STOP`, not an accepted computation-backed
rejection: its generic mathematics is audited, but no recovered verifier
independently establishes all `793,800` width-two minima at the five uncovered
pivots of its candidate tuple. Do not promote those response-authored minima.
This contract needs none of them: it defines a different finite construction
type and supplies only non-evidentiary Medium preflight observations below.

## Exact modular pivot data

Fix `n>=3`, put `N=n+1`, and let

```text
a : Fin n -> Nat
```

be positive and injective. Fix pivot `j`, set `p=a_j` and `M=N*p`, and define

```text
rho_M(x) = min(x mod M, M-(x mod M)),

R_j = {r : Fin M | N does not divide r},

O_j = {i : Fin n | i != j},

B_i^j = {r in R_j | rho_M(r*a_i) < p}       for i in O_j.
```

Badness is strict. Equality `rho_M(...)=p` is safe. Retain both cyclic sides,
zero targets, antipodes, nonunits, coincident labelled bad sets, and candidate
exclusion. The labels remain distinct even when two bad subsets are equal.

Exactly `p` residues modulo `M` are divisible by `N`, so

```text
|R_j| = M-p = n*p.
```

For every `r in R_j`, write `s=r mod N`, where `1<=s<=N-1`. At the pivot
coordinate,

```text
rho_(N*p)(r*p) = p*min(s,N-s) >= p.
```

Thus the pivot itself is automatically safe. A residue outside
`union_(i in O_j) B_i^j` is an exact pivot certificate.

## Frozen square-root bag rule

Let

```text
m = |O_j| = n-1,

ceilSqrt(m) = least s : Nat with m <= s*s,

b(m) = min(m, 1+ceilSqrt(m)).
```

Prove existence and leastness of `ceilSqrt`. For `m>=4`, prove

```text
ceilSqrt(m) <= m-2,
b(m) = 1+ceilSqrt(m) < m.
```

One elementary route is `(m-2)^2-m=(m-1)*(m-4)>=0`. Consequently the rule
is not a full-owner bag and is asymptotically sublinear. Exact controls are

```text
b(2)=2, b(3)=3, b(4)=3,
b(5)=b(6)=b(7)=b(8)=b(9)=4,
b(10)=5.
```

The formula was frozen before the fixture and bounded preflight. Do not tune
it after a failed case, replace it by `m-1`, or choose a tuple-dependent bag
size.

## Exact finite balanced constructions

Write `b=b(m)`. A normalized balanced construction `D` on owner type `O_j`
is the following finite data.

If `m=b`, there is one root bag `O_j`, no child, and no separator.

If `m>b`:

1. choose a bijection

   ```text
   sigma : Fin m -> O_j
   ```

   whose first `b` owner labels are increasing;
2. define the root bag

   ```text
   bag_0={sigma(0),...,sigma(b-1)};
   ```

3. for each introduction index `k=b,...,m-1`, choose a labelled separator

   ```text
   S_k subset O_j,       |S_k|=b-1,
   ```

   contained in at least one earlier bag;
4. introduce exactly the new owner `sigma(k)` with

   ```text
   bag_(k-b+1)=S_k union {sigma(k)};
   ```

5. define `parent(k-b+1)` to be the least earlier bag index containing `S_k`.

The new owner has not occurred earlier. Hence it is not in `S_k`, each bag has
exactly `b` owners, and the child-parent intersection is exactly `S_k`.

Prove by introduction induction:

- parent indices strictly decrease toward the root;
- parent edges form a finite rooted tree;
- bags cover all owner labels;
- for each owner, the bags containing it induce a connected subtree; and
- every separator is the exact child-parent bag intersection.

Do not quantify over an unspecified arbitrary tree decomposition. Use this
canonical finite construction type and its deterministic least-parent rule.
The normalization removes only root-order symmetry.

Also prove the exact construction count

```text
#D(m)
 = binom(m,b)*(m-b)!
   * product_(t=0)^(m-b-1) (b+t*(b-1)).
```

The root contributes `b` available `(b-1)`-faces. Every introduced owner adds
exactly `b-1` new faces containing that new label. Required controls include

```text
#D(4)=12  when b=3,
#D(5)=20  when b=4,
#D(6)=840 when b=4,
#D(7)=58,800 when b=4.
```

## Junction functional and generic implication

For an owner subset `S`, write

```text
U_j(S)=union_(i in S) B_i^j.
```

All cardinalities below are cast to `Int`; no natural subtraction is allowed.
Define

```text
J_j(D)
 = sum_b Int(|U_j(bag_b)|)
   - sum_(nonroot c)
       Int(|U_j(bag_c intersect bag_parent(c))|).
```

Prove the generic local theorem, rather than merely citing Prompt85. Remove a
nonroot leaf `c`, let `W` be the union of the remaining bag unions, and use

```text
U_j(bag_c intersect bag_parent(c))
  subset U_j(bag_c) intersect W.
```

Finite inclusion-exclusion and leaf induction give

```text
Int(|union_(i in O_j) B_i^j|) <= J_j(D).       (LOCAL-JUNCTION-BOUND)
```

The one-bag case is equality. The same proof gives `0<=J_j(D)`.

For each covered residue `r`, let `H_r` be the union in the bag tree of the
connected bag subtrees belonging to owners whose bad sets contain `r`. If
`kappa_D(r)` is its number of connected components, prove

```text
J_j(D) = sum_(r in union_i B_i^j) kappa_D(r),

J_j(D)-|union_i B_i^j|
 = sum_(r in union_i B_i^j) (kappa_D(r)-1).
```

Writing

```text
G_j=|R_j \ union_i B_i^j|,
```

derive the exact strictness criterion

```text
J_j(D)<|R_j|
iff
sum_(covered r) (kappa_D(r)-1) < G_j.
```

Therefore

```text
J_j(D)<Int(|R_j|)
 -> Int(|union_i B_i^j|)<Int(|R_j|)
 -> exists r in R_j outside every B_i^j
 -> rho_(N*p)(r*a_i)>=p for every i
 -> at time t=r/(N*p), every circle distance is >=1/N.
```

This implication is generic finite-set mathematics. It does not prove the
existence of `j,D`.

## Sole unrestricted target

There is exactly one target:

```text
BALANCED-JUNCTION-COVER-DEFICIT:
For every n>=3 and every positive injective a : Fin n -> Nat,
there exist a pivot j and a normalized balanced construction D on O_j,
using exactly b(n-1)=min(n-1,1+ceilSqrt(n-1)), such that

  J_j(D) < Int(|R_j|).
```

There is no height bound, primitive premise, finite-range premise, primality
premise, minimal-counterexample premise, or tuple-dependent change of `b`.
Common gcd normalization may be used only after proving the exact scaling law
for this construction type.

## Complete implication chain to unrestricted LRC

Assuming the sole target:

1. Fix any positive injective integer `n`-tuple for `n>=3`.
2. Select `j,D` from the target.
3. Apply `LOCAL-JUNCTION-BOUND` and strict transitivity to obtain an uncovered
   `r in R_j`.
4. Candidate exclusion makes the pivot coordinate safe; avoidance of all
   owner bad sets makes every other coordinate safe, including equality.
5. At rational time `r/(N*a_j)`, all integer runners have circle distance at
   least `1/N`.
6. This proves positive-integer LRC in every `n>=3`; the accepted one- and
   two-speed bases cover lower dimensions.
7. Apply the accepted real-to-positive-integer equivalence to obtain
   unrestricted real LRC.

The implication is conditional until the sole target is proved. Do not label
the chain `proved-lean` or claim LRC from a finite scan.

## Anti-tautology and route separation

Audit all of the following.

1. For `m>=4`, `b(m)<m`; the sole target never permits the one full-owner bag.
2. At `m=4`, the abstract pair-incidence set system has one point `e_uv` for
   each unordered owner pair, covered by exactly owners `u,v`. Its exact union
   has size six, but every normalized `b(4)=3` construction has `J=7`.
   Therefore balanced junction can strictly overcount the union and is not a
   restatement of pivot noncoverage.
3. For `m<=3`, `b(m)=m`, so the one-bag statement is exact. This low-dimensional
   degeneration does not make the unrestricted `m>=4` theorem tautological.
4. Prompt85 fixed `b=3` for every dimension and has a provisional candidate
   failure at seven owners. The present rule gives `b(7)=4` because of one
   frozen sublinear formula; it is not “width three succeeds on this tuple.”
5. Prompt66 whole-block packing chooses token-parent blocks under residue
   capacities. It has no owner running-intersection tree and no junction
   component penalty.
6. Prompt86 uses a fixed local multiplicity score. It neither selects bags nor
   bounds `kappa_D(r)` through an owner tree.
7. Prompt85's width-two minima are not premises. Reusing a response-authored
   minimizing construction without fresh derivation is forbidden.
8. Choosing `b=m`, `b=m-1`, a full bag at a difficult pivot, or a bag size
   after observing failure is a stopped near-tautological repair.

## Contract-design preflight — not evidence

Sol Medium froze `b(m)` before running two separate exact evaluators: a direct
normalized-construction enumerator and a memoized state evaluator. They agreed
on every row below. These ephemeral admission checks are not tracked artifacts,
were not independently promoted, and are **not computed finite evidence**.
Reproduce or reject them; do not cite them as theorem premises.

For each tuple, the table gives one strict-deficit pivot:

| Fixture | `m` | `b(m)` | pivot | `|R_j|` | exact union | minimum `J` |
| --- | ---: | ---: | ---: | ---: | ---: | ---: |
| P76 `(1,4,5,6,7,11)` | 5 | 4 | speed `6` | 36 | 34 | 34 |
| P77 `(6,7,168)` | 2 | 2 | speed `168` | 504 | 378 | 378 |
| P78 `(6,7,12,24,144)` | 4 | 3 | speed `144` | 720 | 560 | 560 |
| P79 `(1,3,4)` | 2 | 2 | speed `3` | 9 | 7 | 7 |
| P79 `(1,3,4,5)` | 3 | 3 | speed `4` | 16 | 14 | 14 |
| P80 `(1,3,16)` | 2 | 2 | speed `3` | 9 | 7 | 7 |
| P82 `(1,4,5,6,7,11,32)` | 6 | 4 | speed `7` | 49 | 47 | 47 |
| P85 `(1,2,5,7,9,11,12,13)` | 7 | 4 | speed `7` | 56 | 50 | 50 |

The evaluators also agreed on construction counts `1,12,20,840,58,800` at
the applicable owner counts. On the abstract four-owner pair-incidence fixture
they both gave exact union `6` and minimum `J=7`, preserving the known genuine
junction loss.

The sole declared bounded admission domain was

```text
D_pre = union over (n,H) in
        {(3,10),(4,10),(5,10),(6,10),(7,9)}
        of primitive strictly increasing n-tuples in {1,...,H}.
```

The respective tuple counts were

```text
109, 205, 251, 210, 36,
```

for 811 total tuples. No first failure was found. This is bounded
non-evidentiary contract preflight, not support for the universal theorem.
Do not enlarge or tune this domain during the turn.

## Mandatory falsification suite

Before attempting a uniform proof, independently implement the literal finite
definitions or give transparent exact pseudocode and check:

1. every fixture and table row above, including all pivots of the P85 tuple;
2. the complete fixed domain `D_pre`, in tuple lexicographic, pivot increasing,
   root lexicographic, introduction-owner lexicographic, separator
   lexicographic order;
3. the abstract four-owner pair-incidence loss `|U|=6`, `min J=7`;
4. one-bag equality for `m=2,3`;
5. five distinct owner labels with identical bad sets, retaining the labels;
6. strict boundary `rho=p-1` bad and equality `rho=p` safe, both cyclic sides,
   zero, antipode, and excluded `N`-multiples;
7. nonunits and gcd-degenerate intersections from P77/P78;
8. common positive scaling and coordinate permutation;
9. malformed constructions: repeated owner, missing owner, separator of wrong
   size, separator absent from earlier bags, nonleast recorded parent, broken
   running intersection, and wrong bag bound; and
10. a deliberately altered abstract expectation `min J=6`, which must fail.

No second new bounded domain is permitted. A finite zero-failure report is not
a theorem. A finite counterexample to the exact sole target is a valid `STOP`
only after literal reproduction and complete construction-domain coverage.

## Required mathematical attacks

### Attack A — balanced random construction and component energy

For a fixed pivot and covered residue `r`, let `C_r` be its owner set. Analyze
the expected number of components `kappa_D(r)` under an explicitly defined
distribution on normalized balanced constructions. Any claimed expectation
must respect root normalization, available separators, and owner labels.

Seek a dimension-uniform inequality of the exact form

```text
exists j,D,
  sum_(covered r) (kappa_D(r)-1) < G_j.
```

An average may select `D` only after all summands and denominators are shown
finite and nonnegative. Do not interchange `exists j`, expectation over `D`,
and sum over residues without an explicit finite averaging argument. A bound
depending on an uncovered residue before `j` is selected is circular.

### Attack B — arithmetic owner-set structure across pivots

Use the exact modular origin of `C_r`, rather than an arbitrary set system.
Possible inputs are generalized-CRT incompatibilities, cross-pivot sums of
owner-set sizes, additive energy of coincident bad fibers, and restrictions on
minimal complete covers. Derive every nonunit and candidate-subtraction term.

The conclusion must control balanced-tree disconnectedness at one pivot. A
generic statement that every owner set is connected in some unrestricted
tree is insufficient if the tree violates `b(m)` or running intersection.
Likewise, assuming an uncovered pivot and then choosing the full owner bag is
the forbidden tautological repair.

### Attack C — minimal counterexample to the balanced target

If the sole target appears false, choose the lexicographically least positive
increasing primitive tuple by `(n,max speed,sum,tuple)`, then the least pivot
and construction. Determine the exact owner-set obstruction preventing every
strict deficit. Any descent must preserve positivity, injectivity, strict bad
boundaries, candidate exclusion, and the frozen bag rule. State the exact
witness-lifting arrow before using it.

## Required response format

Return exactly these sections.

1. **Disposition** — `PROVE`, `PIVOT`, or `STOP`.
2. **Exact definitions** — `ceilSqrt`, `b(m)`, pivot grids, owner-labelled bad
   sets, normalized balanced construction, parents, bags, and separators.
3. **Finite construction theorem** — tree, running intersection, coverage,
   separator intersection, sublinear bound, and exact construction count.
4. **Generic junction theorem** — leaf induction, component identity, and
   strict-deficit implication.
5. **Anti-tautology and route separation** — full-bag prohibition, abstract
   loss, and exact distinctions from Prompts 66, 85, and 86.
6. **Falsification report** — every mandatory fixture, complete `D_pre`,
   malformed controls, altered expectation, ordering, and hashes of any
   response-created source/output.
7. **Attack A** — exact distribution and component-energy proof or first fatal
   arrow.
8. **Attack B** — modular arithmetic selection proof or first fatal arrow.
9. **Attack C** — minimal-counterexample analysis or exact counterexample.
10. **Sole theorem proof or STOP certificate** — every quantifier of
    `BALANCED-JUNCTION-COVER-DEFICIT`, or the first complete refutation.
11. **Complete implication chain** — integer pivot certificate through real
    LRC, with exact evidence labels.
12. **Proof-obligation ledger** — claim, dependency, status, falsification,
    first open edge, and recommended owner.
13. **Verifier and Lean plan** — one frozen literal architecture, one
    independent checker, declaration signatures only after the mathematics is
    accepted; no repository edit.
14. **Final evidence boundary** — separate `proved-lean`,
    `proved-math-qualified`, response reasoning, unverified computation,
    conditional, rejected, and open.

`PROVE` requires the unrestricted sole target plus the generic implication at
all exact quantifiers. `PIVOT` requires one strictly narrower non-tautological
lemma, the complete implication chain back to the sole target, and survival of
every fixture. It promotes nothing. Return `STOP` on an exact tuple failure,
an unclosed component-energy bound, a full-bag repair, a tuple-dependent bag
size, an LRC-equivalent restatement, or reliance on response-authored minima.

## One-turn budget and stop rules

Use the first quarter for exact definitions, generic proofs, and independent
falsification; the second for Attack A; the third for Attack B and the minimal
counterexample analysis; and the final quarter for the theorem or STOP
certificate, implication chain, and obligation ledger.

Stop immediately on a missing owner label, unavailable separator, wrong bag
size, nonleast parent used as data, broken running intersection, truncated
natural subtraction, strict/closed endpoint swap, candidate-grid exclusion
error, noncoprime CRT cancellation, tuple-dependent change of `b`, hidden full
bag, quantifier interchange, or proof step that already assumes an uncovered
pivot. A correct negative result is more valuable than a conditional wrapper
with the same missing existential.
