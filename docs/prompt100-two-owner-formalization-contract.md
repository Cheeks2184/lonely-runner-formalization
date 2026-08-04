# Prompt100 two-owner formalization contract

Task: 358

Base commit: `48bbfcbddde2d4d8e5b9c279eb991aa613a1ebdc`

Specification status: frozen for review; no Lean implementation is included

Mathematical input: independently audited Prompt100 response, accepted only at
`proved-math-qualified` scope

## 1. Scope and semantic invariants

The public target is the exact canonical strict-residue theorem below. All
variables are natural numbers. There is no implicit reduction to a primitive
triple, no coprimality premise, and no divisibility premise.

```lean
theorem twoLowerOwner_noncover
    (N p b c : Nat)
    (hN : 4 <= N) (hp : 0 < p)
    (hb : 0 < b) (hbc : b < c) (hc : c < p) :
    ∃ r : Nat,
      r ∈ pivotCandidates N p ∧
      r ∉ pivotBadResidues N p b ∧
      r ∉ pivotBadResidues N p c
```

The theorem uses the existing definitions without a wrapper:

```lean
pivotCandidates N p = (Finset.range (N * p)).filter (fun r => ¬ N ∣ r)
pivotBadResidues N p d =
  (pivotCandidates N p).filter
    (fun r => cyclicResidueDistance (N * p) (r * d) < p)
```

Thus the quantifier is exactly `0 <= r < N*p` with `N ∤ r`. Badness is the
strict inequality `rho_(N*p)(r*d) < p`. Its complement is closed:
`p <= rho_(N*p)(r*d)`. Equality is safe. In particular, no implementation may
replace `< p` by `<= p`, replace the candidate filter by the full residue
range, or quotient away labelled owners.

The corresponding set-level corollary is also frozen:

```lean
theorem union_twoLowerOwner_badResidues_ne_candidates
    (N p b c : Nat)
    (hN : 4 <= N) (hp : 0 < p)
    (hb : 0 < b) (hbc : b < c) (hc : c < p) :
    pivotBadResidues N p b ∪ pivotBadResidues N p c ≠
      pivotCandidates N p
```

It is a corollary of `twoLowerOwner_noncover`, not a replacement statement.

## 2. Module and namespace plan

All new declarations belong to `namespace LonelyRunner`.

The intended files and minimal imports are:

| Proposed module | Required imports |
| --- | --- |
| `LonelyRunner/Prompt100TwoOwnerCounts.lean` | `LonelyRunner.PivotCounts`, `Mathlib.Data.Finset.Card` |
| `LonelyRunner/Prompt100Four.lean` | `LonelyRunner.Prompt100TwoOwnerCounts`, `LonelyRunner.Prompt99Scaling`, `Mathlib.Data.Nat.ModEq`, `Mathlib.Data.Finset.Interval` |
| `LonelyRunner/Prompt100InternalCover.lean` | `LonelyRunner.Prompt100Four`, `LonelyRunner.PrimitivePrompt95` |

An implementer may use a single module initially, but may not change any
signature below. `LonelyRunner.lean` and `LonelyRunner/AxiomAudit.lean` are
integration files and are outside each local implementation task until a
separate reviewed integration task authorizes them.

Existing declarations that discharge frozen semantic edges are:

- `mem_pivotCandidates` and `card_pivotCandidates`;
- `mem_pivotBadResidues`, `pivotBadResidues_subset`, and
  `not_mem_pivotBadResidues_iff_circleNorm_ge`;
- `card_pivotBadResidues_exact`;
- `cyclicResidueDistance_mul_left`;
- `mem_pivotCandidates_scale_reduce_iff` and
  `mem_pivotBadResidues_scale_reduce_iff`;
- `pivotCompleteCover_scale_iff`, `coveredPivots_scale`, and
  `internalCoverRedundantAt_scale_iff`;
- `PivotCompleteCover`, `coveredPivots`, `IsMaximumCoveredPivot`,
  `IsInternalOwnerSet`, and `InternalCoverRedundantAt`;
- `exists_scaleSpeeds_primitive` and
  `primitiveSpeedFamily_iff_speedGCD_eq_one`.

The existing exact count uses `Nat.ceilDiv` notation rather than the response's
floor notation. The implementation must prove the necessary arithmetic
rewrites; it must not introduce a second, unproved count formula.

## 3. Frozen declarations

### 3.1 Exact count normalization and the `N >= 5` branch

The main capacity theorem for this branch is:

```lean
theorem twoLowerOwner_badCardSum_lt_of_five_le
    (N p b c : Nat)
    (hN : 5 <= N) (hp : 0 < p)
    (hb : 0 < b) (hbc : b < c) (hc : c < p) :
    (pivotBadResidues N p b).card +
        (pivotBadResidues N p c).card <
      (pivotCandidates N p).card
```

This statement includes the exceptional equality analysis at `N = 5`:
one owner may attain the individual `2*p` bound, but two distinct labelled
owners cannot both be that unique owner. The following local normalization is
frozen to keep that analysis explicit:

```lean
def normalizedBadCount (N k P : Nat) : Nat :=
  k * (2 * ((P - 1) / k) + 1) -
    (2 * ((P - 1) / N) + 1)

theorem card_pivotBadResidues_normalized
    (N p d h P D k : Nat)
    (hN : 2 <= N) (hp : 0 < p) (hd : 0 < d) (hdp : d < p)
    (hh : h = Nat.gcd d p)
    (hpP : p = h * P) (hdD : d = h * D)
    (hDP : Nat.Coprime D P) (hk : k = Nat.gcd D N) :
    (pivotBadResidues N p d).card = h * normalizedBadCount N k P
```

All gcd and factorization premises in this auxiliary theorem are explicit.
The public pair theorem has none. The proof must derive `0 < h`, `k ∣ N`,
`k < P`, and the required floor/ceiling identities rather than assume them
silently.

The unique equality owner should be exposed as:

```lean
theorem badCard_le_half_and_eq_owner
    (p d : Nat) (hp : 0 < p) (hd : 0 < d) (hdp : d < p) :
    2 * (pivotBadResidues 5 p d).card <=
        (pivotCandidates 5 p).card ∧
      ((pivotBadResidues 5 p d).card = 2 * p →
        6 ∣ p ∧ d = 5 * (p / 6))
```

The first conjunct is deliberately integral. No division in `Nat` may weaken
the bound.

### 3.2 The `N = 4` small-multiplier and lift branch

The closed quarter-safe small-multiplier lemma is:

```lean
theorem exists_quarterSafe_smallMultipliers
    (m x y : Nat)
    (hm : 0 < m) (hx : 0 < x) (hxy : x < y) (hy : 4 * y < m) :
    ∃ r : Nat,
      r < m ∧
      m <= 4 * cyclicResidueDistance m (r * x) ∧
      m <= 4 * cyclicResidueDistance m (r * y)
```

The conclusion is closed and therefore retains equality. The response proves
this by intersecting closed safe arcs and using a grid spacing argument. The
repository's `exists_int_grid_circleNorm_ge` may supply part of the mesh
argument, but it is one-dimensional and does not by itself prove the displayed
two-multiplier intersection.

The normalized `G` class is fixed as follows:

```lean
def IsFourGOwner (p d : Nat) : Prop :=
  let h := Nat.gcd d p
  Nat.gcd (d / h) 4 = 4 ∧ (p / h) % 4 = 1
```

This predicate is used only with `0 < d < p`, which makes `h` positive. It
must not be evaluated at zero inside a proof before positivity is established.

The primitive lift lemma is:

```lean
theorem fourGOwner_has_commonSafeCandidate_of_primitive
    (p d e : Nat)
    (hp : 0 < p) (hd : 0 < d) (he : 0 < e)
    (hdp : d < p) (hep : e < p) (hne : d ≠ e)
    (hprimitive : Nat.gcd (Nat.gcd p d) e = 1)
    (hG : IsFourGOwner p d) :
    ∃ r : Nat,
      r ∈ pivotCandidates 4 p ∧
      r ∉ pivotBadResidues 4 p d ∧
      r ∉ pivotBadResidues 4 p e
```

The explicit primitive premise belongs only to this normalized auxiliary.
The unrestricted branch below must remove it using common scaling and the
existing scaling equivalences:

```lean
theorem four_twoLowerOwner_noncover
    (p b c : Nat)
    (hp : 0 < p) (hb : 0 < b) (hbc : b < c) (hc : c < p) :
    ∃ r : Nat,
      r ∈ pivotCandidates 4 p ∧
      r ∉ pivotBadResidues 4 p b ∧
      r ∉ pivotBadResidues 4 p c
```

The full `N = 4` implementation additionally needs the exact three candidate
class counts and the eight normalized owner types from the audited response,
followed by `cover forces G`. Those table declarations are not admitted as one
Luna task: a Medium lead must first freeze a finite inductive owner-class type
and a total epsilon function, including impossible inputs. Until that data
model is separately reviewed, the class-table layer is
`MEDIUM-SPEC-REQUIRED`.

In the `4 ∣ e` subcase of the `G` lift, the response invokes the
small-multiplier lemma on `d/4` and `e/4`. Its prose does not order these two
arguments first. The Lean proof must use a case split to reorder them before
applying `exists_quarterSafe_smallMultipliers`; it may not assume `d < e` in
that subcase.

### 3.3 Singleton lower-owner noncover

The cardinality statement is frozen for every `N >= 3`:

```lean
theorem lowerOwner_badCard_lt_candidates
    (N p d : Nat)
    (hN : 3 <= N) (hp : 0 < p) (hd : 0 < d) (hdp : d < p) :
    (pivotBadResidues N p d).card < (pivotCandidates N p).card
```

Its witness corollary is:

```lean
theorem singletonLowerOwner_noncover
    (N p d : Nat)
    (hN : 3 <= N) (hp : 0 < p) (hd : 0 < d) (hdp : d < p) :
    ∃ r : Nat,
      r ∈ pivotCandidates N p ∧
      r ∉ pivotBadResidues N p d
```

For `N >= 4`, the audited proof bounds the full multiplication preimage before
candidate exclusion. For `N = 3`, it uses the normalized exact count and must
split `gcd(D,3) = 1` or `3`. The implementation may instead derive both cases
from `card_pivotBadResidues_exact`, but it must retain the exact strict count.

### 3.4 Restricted Prompt95 consequence

The strongest frozen bridge states that no internal complete cover exists:

```lean
theorem no_internalCompleteCover_of_coveredPivots_card_le_three
    {n : Nat} (hn : 2 <= n) (a : Fin n → Nat)
    (ha : ∀ i, 0 < a i) (hinjective : Function.Injective a)
    (j : Fin n) (hj : IsMaximumCoveredPivot (n + 1) a j)
    (hcard : (coveredPivots (n + 1) a).card <= 3) :
    ∀ C : Finset (Fin n),
      IsInternalOwnerSet (n + 1) a j C →
      ¬ PivotCompleteCover (n + 1) a j C
```

The requested redundancy theorem is then vacuous:

```lean
theorem internalCoverRedundantAt_of_coveredPivots_card_le_three
    {n : Nat} (hn : 2 <= n) (a : Fin n → Nat)
    (ha : ∀ i, 0 < a i) (hinjective : Function.Injective a)
    (j : Fin n) (hj : IsMaximumCoveredPivot (n + 1) a j)
    (hcard : (coveredPivots (n + 1) a).card <= 3) :
    InternalCoverRedundantAt (n + 1) a j
```

This is a theorem about the cardinality of the labelled finite set
`coveredPivots`, not the number of distinct numerical speeds inferred after
quotienting. Injectivity and maximum-covered-pivot membership show that every
internal owner has positive speed strictly below `a j`. For `n = 2`
(`N = 3`) there is at most one nonpivot label. For `3 <= n` (`4 <= N`), an
internal cover under the cardinality hypothesis has at most two owners after
finite minimization, contradicting the singleton or two-owner theorem.

The conclusion proves only the `coveredPivots.card <= 3` fragment of Prompt95.
It does not prove unrestricted Prompt95, the uniform pivot certificate,
integer LRC, or real LRC.

## 4. Dependency DAG and unresolved Lean edges

```text
existing strict definitions and membership lemmas
  + card_pivotBadResidues_exact
  + card_pivotCandidates
          |
          +--> normalized exact count
          |       +--> N>=6 individual bound
          |       +--> N=5 unique equality owner
          |                 |
          |                 +--> N>=5 pair-cardinality branch
          |
          +--> singleton N>=4 count
          +--> singleton N=3 normalized cases
                          |
                          +--> singletonLowerOwner_noncover

closed quarter-safe small-multiplier lemma
  + primitive triple normalization/scaling
  + exact N=4 class table
          +--> cover forces G
                  +--> G odd / twice-odd / 4-divisible lift
                          +--> N=4 pair branch

N>=5 pair branch + N=4 pair branch
          +--> twoLowerOwner_noncover
                  +--> no internal cover when coveredPivots.card<=3
                          +--> restricted Prompt95 redundancy
```

Precise unresolved implementation edges are:

1. reconcile the floor-form normalized response count with the existing
   `Nat.ceilDiv` theorem without natural-subtraction mistakes;
2. formalize the `N = 5` equality classification and uniqueness of the
   labelled owner;
3. formalize the closed two-arc intersection and rational-grid hit in
   `exists_quarterSafe_smallMultipliers`;
4. freeze, then implement, the `N = 4` owner-class data type and exact class
   table;
5. formalize the weighted class-capacity argument, including the common point
   `r = 1` when a class sum is exactly its capacity;
6. implement the three parity lift cases and candidate exclusion in the
   primitive `G` lemma;
7. remove the primitive premise by common scaling without changing the
   labelled pair or the strict boundary;
8. perform the finite owner-set minimization/cardinality case split for the
   Prompt95 wrapper.

No item above is a new mathematical conjecture, but several are too broad for
one narrow implementation task.

## 5. Mandatory probes and fixtures

Every implementation task must include theorem probes with the exact frozen
signature before proof work. No large proof task begins until the following
decidable fixtures are checked by a separate test file or `example` block:

- success and equality boundary: `(N,p,b,c) = (4,3,1,2)`, with `r = 3` safe;
- collision/nonunit equality: `(4,6,1,5)`, with `r = 6` retained;
- nonunit owner: `(4,4,1,3)`;
- common scaling: `(4,15,5,10)`, whose uncovered residues are the five lifted
  copies of the `(4,3,1,2)` uncovered set;
- `N = 3` out-of-domain failures: `(3,3,1,2)` and `(3,5,2,3)` are complete
  two-owner covers;
- malformed premises: `p = 0`, `b = 0`, `b = c`, `c >= p`, and `N < 4` must
  be rejected by hypotheses rather than made theorem instances;
- mutation kill: replacing strict badness `< p` by `<= p` must remove the
  equality witness `r = 3` in `(4,3,1,2)`;
- labelled collision fixture: distinct labels with equal speeds is outside the
  Prompt95 wrapper because `Function.Injective a` fails, even though the
  arithmetic bad sets coincide.

The response Markdown is visibly corrupted in several displayed formulas and
tables: subtraction markers became headings/rules and table pipes split
mathematical expressions. Implementers must use the normalized formulas in
this contract and the recovered source definitions, not copy malformed
Markdown literally.

## 6. Luna Narrow Verification admission

| Task | Admission | Reason and evidence label on success |
| --- | --- | --- |
| Probe existing strict definitions and exact count on the fixed fixtures | `LUNA-READY` | Frozen inputs, expected sets, strict boundary, and commands; audit deliverable only |
| Implement `card_pivotBadResidues_normalized` | `LUNA-READY` after a Medium lead supplies a one-file task contract | One frozen local signature; `proved-lean` only for that lemma |
| Implement `twoLowerOwner_badCardSum_lt_of_five_le` | `MEDIUM-SPEC-REQUIRED` | Must first split normalization, uniform inequality, and `N=5` equality into separate tasks |
| Implement `exists_quarterSafe_smallMultipliers` | `LUNA-READY` after theorem-probe preflight | One local frozen lemma; stop on any boundary or interval-semantics issue |
| Implement the `N=4` class table | `MEDIUM-SPEC-REQUIRED` | Owner-class type, impossible inputs, and epsilon table are not yet frozen |
| Implement primitive `G` lift | `MEDIUM-SPEC-REQUIRED` | Must be split into odd, twice-odd, and four-divisible lift lemmas |
| Implement `lowerOwner_badCard_lt_candidates` | `LUNA-READY` after separate `N=3` and `N>=4` tasks are issued | Frozen local count statements; `proved-lean` at exact scope |
| Implement public `twoLowerOwner_noncover` | `MEDIUM-SPEC-REQUIRED` | Integration task only after both branches compile and are reviewed |
| Implement restricted Prompt95 wrapper | `MEDIUM-SPEC-REQUIRED` | Freeze the finite-minimalization helper and owner-set case split first |

No task is `RESEARCH-UNRESOLVED`: the mathematics has passed independent
paper audit. This does not make a broad multi-layer implementation Luna-ready.

## 7. Trust, commands, and acceptance

Permitted trust base: Lean 4 kernel, pinned mathlib, standard classical logic,
and declarations already imported from this repository after their own axiom
audit. No new axiom is permitted.

Prohibited in every implementation: `sorry`, `admit`, `axiom`,
`native_decide`, `unsafe`, disabled checks, silent theorem weakening,
strengthened public hypotheses, reordered quantifiers, or replacement of
strict badness by a closed bad set.

Targeted commands for a local source task are:

```text
lake env lean LonelyRunner/Prompt100TwoOwnerCounts.lean
lake env lean LonelyRunner/Prompt100Four.lean
lake env lean LonelyRunner/Prompt100InternalCover.lean
lake build LonelyRunner.Prompt100InternalCover
```

The integration task must add and run these axiom probes:

```lean
#print axioms LonelyRunner.twoLowerOwner_noncover
#print axioms LonelyRunner.twoLowerOwner_badCardSum_lt_of_five_le
#print axioms LonelyRunner.four_twoLowerOwner_noncover
#print axioms LonelyRunner.singletonLowerOwner_noncover
#print axioms LonelyRunner.no_internalCompleteCover_of_coveredPivots_card_le_three
#print axioms LonelyRunner.internalCoverRedundantAt_of_coveredPivots_card_le_three
```

Accepted output must report only standard logical axioms already expected from
mathlib (normally `Classical.choice`, `propext`, and `Quot.sound` as actually
printed). Any new named axiom, placeholder, or untrusted evaluator is a hard
failure.

Evidence labels after successful kernel checking are declaration-scoped
`proved-lean`. The public pair theorem may be promoted to `proved-lean` only
after its exact signature and definitions are independently compared with
Section 1. The restricted Prompt95 consequence receives `proved-lean` only at
the explicit `coveredPivots.card <= 3` hypothesis. None of these promotions
changes unrestricted Prompt95 or LRC from `open`.

Stop and escalate immediately if an implementation requires changing a frozen
signature, adding a primitive/gcd premise to the public theorem, changing
candidate exclusion, weakening strict/closed semantics, treating unlabelled
speed values as owners, or replacing the exact `N = 4` class argument with a
finite scan. Routine syntax, import, type annotation, and arithmetic
elaboration repairs are allowed without escalation.
