# Task366 owner-count bridge: declaration-level formalization contract

Task: `367`

Base commit: `f073436efe947a906ab4da1516140891ee7799db`

Deliverable status: frozen declaration-level contract; no Lean implementation
is included

Mathematical input: the separately reviewed Task366 owner-count bridge. This
document does not change any repository evidence label.

## 1. Scope and semantic invariants

This contract freezes one dimension-adaptive consequence of the Prompt100
one-owner count. For every `N >= 5`, equality in the individual capacity bound
has one possible lower-owner speed. An injective family with at least two
labels therefore has strict total capacity whenever `3 * C.card <= N + 1`.
Applied to an internal complete cover at a maximum covered pivot, this forces

```text
N + 1 < 3 * C.card.
```

No minimality hypothesis is used. The final redundancy theorem is vacuous:
its cardinality premise makes every internal complete cover impossible.

All arithmetic variables and speeds are natural numbers. The contract uses
the repository's existing definitions literally:

```lean
pivotCandidates N p =
  (Finset.range (N * p)).filter (fun r => ¬ N ∣ r)

pivotBadResidues N p d =
  (pivotCandidates N p).filter
    (fun r => cyclicResidueDistance (N * p) (r * d) < p)
```

Badness is strict. A residue with
`cyclicResidueDistance (N * p) (r * d) = p` is safe and is not in the bad
set. The owner family is labelled: two distinct labels with the same numerical
speed are not an injective owner family and may not be passed to Declaration
B. Neither residues nor bad sets are quotiented by collisions.

The contract does not assert the Prompt100 two-owner theorem at `N = 4`,
unrestricted Prompt95, a uniform pivot certificate, integer LRC, real LRC, or
the unrestricted Lonely Runner Conjecture.

## 2. Module, namespace, and imports

All declarations belong to `namespace LonelyRunner`.

The proposed implementation module is:

```text
LonelyRunner/Prompt100OwnerDensity.lean
```

Its frozen import surface is:

```lean
import LonelyRunner.Prompt100TwoOwnerCounts
import LonelyRunner.Prompt99Scaling
import LonelyRunner.ModularCertificates
```

`Prompt100TwoOwnerCounts` supplies `normalizedBadCount` and
`card_pivotBadResidues_normalized`. At this contract's base commit those
declarations are a reviewed integration dependency rather than declarations
available on `main`; implementation must not duplicate them under new names.
`Prompt99Scaling` supplies the internal-cover definitions.
`ModularCertificates` supplies `card_biUnion_le_sum_card`.

The implementation may add only private helper lemmas to this module until a
separate integration task authorizes changes to `LonelyRunner.lean` or
`LonelyRunner/AxiomAudit.lean`. It may not introduce a second candidate-row,
bad-set, covered-pivot, or internal-cover definition.

## 3. Frozen declarations

The declarations below are frozen in name, binder order, hypotheses, and
conclusion. An implementation may not silently strengthen a premise, weaken a
conclusion, replace a strict inequality by a weak one, or reorder quantifiers.

### A. Individual owner bound and equality classification

```lean
theorem card_pivotBadResidues_owner_bound
    (N p d : Nat)
    (hN : 5 <= N) (hp : 0 < p) (hd : 0 < d) (hdp : d < p) :
    (N + 1) * (pivotBadResidues N p d).card <=
      3 * (N - 1) * p
```

```lean
theorem card_pivotBadResidues_owner_bound_eq_iff
    (N p d : Nat)
    (hN : 5 <= N) (hp : 0 < p) (hd : 0 < d) (hdp : d < p) :
    (N + 1) * (pivotBadResidues N p d).card =
        3 * (N - 1) * p ↔
      (N + 1) ∣ p ∧ d = N * (p / (N + 1))
```

The equality theorem is bidirectional. It is not merely a necessary
condition, and it is not restricted to `N = 5`. In the normalized variables

```text
p = h*P, d = h*D, gcd(D,P) = 1, k = gcd(D,N),
```

equality in the normalized gap forces `q = 1`, `k = N`, `ell = 0`, and
`s0 = 0`, hence `P = N + 1` and `D = N`. The public conclusion must then be
transported back to the displayed divisibility and speed formula without a
hidden exact-division assumption.

The natural-number products are intentional. Do not replace the bound with a
statement using truncated division such as
`card <= (3 * (N - 1) * p) / (N + 1)` and then use that weaker form as the
primary theorem.

### B. Sparse injective owner-family noncover

```lean
theorem sparse_injective_owner_family_noncover
    {ι : Type*} [DecidableEq ι]
    (N p : Nat) (speed : ι → Nat) (C : Finset ι)
    (hN : 5 <= N) (hp : 0 < p)
    (hCtwo : 2 <= C.card)
    (hpos : ∀ i ∈ C, 0 < speed i)
    (hlower : ∀ i ∈ C, speed i < p)
    (hinjective : Set.InjOn speed (↑C : Set ι))
    (hsparse : 3 * C.card <= N + 1) :
    C.biUnion (fun i => pivotBadResidues N p (speed i)) ≠
      pivotCandidates N p
```

The theorem is about a finite set of owner labels, not a finite set of speed
values. `Set.InjOn speed (↑C : Set ι)` is explicit and is the exact premise
which prevents two equality-capacity labels from carrying the same unique
equality speed.

The proof must establish the strict cardinal inequality

```text
(C.biUnion (fun i => pivotBadResidues N p (speed i))).card
  < (pivotCandidates N p).card
```

before concluding set inequality. The required strictness has two cases:

1. If `3 * C.card < N + 1`, the summed individual bounds are already strict.
2. If `3 * C.card = N + 1`, Declaration A's equality classification and
   `2 <= C.card` show that not every labelled owner can attain equality.
   At least one summand is strict.

There is no pairwise-disjointness premise. Union cardinality is bounded above
by the sum of bad-set cardinalities with `card_biUnion_le_sum_card`; collisions
can only help the noncover conclusion.

### C. Density of every internal complete cover

```lean
theorem internal_complete_cover_owner_density
    {n : Nat} (N : Nat) (hN : 5 <= N)
    (a : Fin n → Nat)
    (ha : ∀ i, 0 < a i) (hinjective : Function.Injective a)
    (j : Fin n) (hj : IsMaximumCoveredPivot N a j)
    (C : Finset (Fin n))
    (hinternal : IsInternalOwnerSet N a j C)
    (hcover : PivotCompleteCover N a j C) :
    N + 1 < 3 * C.card
```

There is deliberately no inclusion-minimality hypothesis. From
`hinternal`, every `i ∈ C` is a covered label distinct from `j`. From `hj`,
`a i <= a j`; global injectivity upgrades this to `a i < a j`. Thus
Declaration B applies whenever `2 <= C.card` and
`3 * C.card <= N + 1`. The cases `C.card = 0` and `C.card = 1` must be rejected
directly using completeness and Declaration A; they may not be hidden behind
an assumed lower-cardinality premise.

The pivot speed in the application of Declaration B is exactly `p = a j`, and
the owner speed map is exactly `a`. No relabelling or quotient of `C` is
permitted.

### D. Dimension-adaptive sparse-covered-pivots consequence

```lean
theorem internalCoverRedundantAt_of_sparse_coveredPivots
    {n : Nat} (N : Nat) (hN : 5 <= N)
    (a : Fin n → Nat)
    (ha : ∀ i, 0 < a i) (hinjective : Function.Injective a)
    (j : Fin n) (hj : IsMaximumCoveredPivot N a j)
    (hsparse :
      3 * ((coveredPivots N a).card - 1) <= N + 1) :
    InternalCoverRedundantAt N a j
```

This result is vacuous at its exact displayed hypothesis. If an internal
complete cover `C` existed, then

```text
C ⊆ (coveredPivots N a).erase j
```

and `hj.1 : j ∈ coveredPivots N a` would give

```text
C.card <= (coveredPivots N a).card - 1.
```

The sparse premise would contradict Declaration C. Therefore the antecedent
`PivotCompleteCover N a j C` in `InternalCoverRedundantAt` never holds. The
implementation must prove this contradiction and may then eliminate it; it
must not manufacture a redundant owner from an empty cover.

When used in the standard pivot model, one instantiates `N = n + 1`. The
general declaration above intentionally follows the existing definitions and
does not add that equality as a premise.

## 4. Existing-definition adapters

The implementation must use and expose the following exact adapters in its
proof structure:

- `card_pivotBadResidues_normalized` rewrites each individual bad-set count;
- `card_pivotCandidates N p` with `0 < N` rewrites the row cardinality to
  `(N - 1) * p`;
- `pivotBadResidues_subset` keeps every union piece inside the candidate row;
- `card_biUnion_le_sum_card C` bounds the labelled finite union by the sum of
  its pieces;
- `PivotCompleteCover` must be unfolded to turn cover membership into
  membership in the labelled bad-set union;
- `IsMaximumCoveredPivot` supplies both `j ∈ coveredPivots N a` and the speed
  comparison for every covered owner;
- `IsInternalOwnerSet` supplies
  `C ⊆ (coveredPivots N a).erase j`;
- `Finset.card_le_card`, `Finset.card_erase_of_mem`, and the membership rule
  for `Finset.erase` supply the owner-count inequality in Declaration D;
- `InternalCoverRedundantAt` is unfolded only at the final vacuity wrapper.

The implementation must not replace `Set.InjOn` in Declaration B with global
injectivity, nor derive injectivity from distinct numerical bad sets. In
Declaration C, `Function.Injective a` is restricted to `C` explicitly when B
is applied.

## 5. Dependency DAG

```text
existing pivotBadResidues / pivotCandidates strict definitions
  + card_pivotBadResidues_exact
  + normalizedBadCount
  + card_pivotBadResidues_normalized
          |
          +--> normalized quotient/remainder gap inequality
          +--> normalized equality classification for every N>=5
                    |
                    +--> A: individual owner bound
                    +--> A: equality iff unique owner speed
                              |
card_biUnion_le_sum_card ------+--> strict labelled sum under 3*|C|<=N+1
Set.InjOn on C -----------------+                |
                                                 +--> B: sparse family noncover

Prompt99Scaling definitions:
  IsMaximumCoveredPivot
  IsInternalOwnerSet
  PivotCompleteCover
  + global positive/injective speeds
  + A for owner families of size 0 or 1
  + B for owner families of size at least 2
                    |
                    +--> C: every internal complete cover has
                             N+1 < 3*C.card

IsInternalOwnerSet subset
  + maximum-pivot membership
  + card_erase_of_mem
  + sparse covered-pivot hypothesis
  + C
                    |
                    +--> no internal complete cover
                    +--> D: InternalCoverRedundantAt, vacuously
```

At base `f073436`, the first implementation dependency is integration of the
reviewed `normalizedBadCount` and `card_pivotBadResidues_normalized`
declarations. Prompt100's `N = 4` owner-class modules are independent of this
all-`N >= 5` chain.

## 6. Mandatory preflight fixtures

Every implementation task must begin with a disposable theorem-probe file and
must stop before a full run if any relevant fixture fails.

### 6.1 Declaration A fixtures

- General equality beyond `N = 5`: `(N,p,d) = (6,7,6)` attains equality and
  satisfies `7 ∣ 7` and `d = 6 * (7 / 7)`.
- Original equality case: `(N,p,d) = (5,6,5)` attains equality.
- Strict case: `(N,p,d) = (5,6,1)` does not attain equality.
- Divisibility failure: with `(N,p) = (5,5)`, no admissible owner may be
  classified as an equality owner because `6 ∤ 5`.
- Premise violations `N < 5`, `p = 0`, `d = 0`, and `p <= d` must be rejected
  by the hypotheses, not instantiated as theorem cases.
- Mutation kill: deliberately replacing the expected equality speed by
  `N * (p / (N + 1)) + 1` must fail on `(6,7,6)`.

### 6.2 Strict-boundary and collision fixtures

- At `(N,p,d,r) = (5,6,1,6)`, `r` is a pivot candidate and
  `cyclicResidueDistance 30 6 = 6 = p`; therefore
  `r ∉ pivotBadResidues 5 6 1`.
- A mutation using `<= p` as badness must incorrectly include that residue and
  must be rejected by the preflight.
- Repeated products or repeated bad-set residues must remain counted through
  `Finset` semantics; no injectivity of multiplication modulo `N*p` may be
  assumed.

### 6.3 Declaration B fixtures

- Equality-sparse family: take two labelled owners of speeds `1` and `5` with
  `N = 5`, `p = 6`. Then `3 * C.card = 6 = N + 1`, only speed `5` is the
  equality owner, and candidate `r = 8` is outside both strict bad sets.
- Repeated-speed premise violation: take two distinct labels both assigned
  speed `1`. `Set.InjOn speed (↑C : Set ι)` must evaluate to false. This is a
  verifier-premise fixture, not a counterexample to Declaration B.
- Singleton and empty owner sets violate `2 <= C.card` and therefore may not
  instantiate Declaration B.
- A deliberately altered expected result declaring the two-owner
  `(N,p) = (5,6)` fixture a complete cover must fail.

### 6.4 Declarations C and D fixtures

- The equality case in D is included: for `N = 5` and
  `(coveredPivots N a).card = 3`, the sparse arithmetic premise reads
  `3 * (3 - 1) = 6 = N + 1`.
- An internal singleton cover must be rejected by the one-owner bound rather
  than passed to Declaration B.
- An empty internal cover must fail `PivotCompleteCover` because
  `pivotCandidates N (a j)` is nonempty under `N >= 5` and `a j > 0`.
- A synthetic `C` not contained in `(coveredPivots N a).erase j` must fail the
  `IsInternalOwnerSet` premise. It is not a theorem-domain counterexample.
- A deliberately altered D proof which infers an owner from the vacuous
  complete-cover hypothesis must be rejected; the accepted proof closes by
  contradiction before producing any owner.

## 7. Luna Narrow Verification admission

The contract itself does not launch Luna. Admission is evaluated per layer:

| Layer | Current admission | Reason and transition condition |
| --- | --- | --- |
| Normalized quotient/remainder gap and equality helpers behind A | `MEDIUM-SPEC-REQUIRED` | Sol Medium must freeze the `q,k,ell,s0` decomposition, divisibility facts, and exact helper signatures before implementation. |
| Public A bound adapter | `MEDIUM-SPEC-REQUIRED` | Becomes `LUNA-READY` only after the normalized gap helper and `card_pivotBadResidues_normalized` compile at reviewed signatures. |
| Public A equality-iff adapter | `MEDIUM-SPEC-REQUIRED` | Becomes `LUNA-READY` only after both normalized equality directions and the exact division transport are separately frozen. |
| Strict finite-sum lemma behind B | `MEDIUM-SPEC-REQUIRED` | Sol Medium must split the strict-sparse and equality-sparse cases and specify the unique-equality-owner contradiction. |
| Final B union-noncover adapter | `MEDIUM-SPEC-REQUIRED` | Becomes `LUNA-READY` after the strict sum lemma is reviewed; then it is one deterministic finite-cardinality layer. |
| C internal-cover density adapter | `MEDIUM-SPEC-REQUIRED` | Becomes `LUNA-READY` after A and B compile and a lead freezes the empty/singleton case split. |
| D vacuity wrapper | `MEDIUM-SPEC-REQUIRED` | Becomes `LUNA-READY` after C compiles; it is then a narrow existing-definition/cardinality adapter. |
| Fixed fixture replay for A and B | `LUNA-READY` | Domains, strict boundary, expected equality cases, repeated-speed rejection, and mutation kills are fixed above; audit evidence only. |

No Luna task may infer helper statements from the Task366 prose, redesign the
finite-family theorem, weaken `Set.InjOn`, or choose a replacement theorem if
one of the frozen declarations fails. A semantic failure returns to Sol Medium
and requires a fresh reviewed specification.

## 8. Targeted build and axiom commands

Before proof work, the exact signatures must be placed in a disposable probe
with the proposed imports. Each implementation layer then uses Level 2
targeted verification:

```text
lake env lean LonelyRunner/Prompt100OwnerDensity.lean
lake build LonelyRunner.Prompt100OwnerDensity
```

When imports are integrated into the root module, additionally run:

```text
lake build LonelyRunner
```

A separate probe must contain:

```lean
#print axioms LonelyRunner.card_pivotBadResidues_owner_bound
#print axioms LonelyRunner.card_pivotBadResidues_owner_bound_eq_iff
#print axioms LonelyRunner.sparse_injective_owner_family_noncover
#print axioms LonelyRunner.internal_complete_cover_owner_density
#print axioms LonelyRunner.internalCoverRedundantAt_of_sparse_coveredPivots
```

The expected trust output is limited to the standard logical axioms already
permitted by the project and actually inherited from reviewed dependencies,
normally `Classical.choice`, `propext`, and `Quot.sound`. Any new named axiom,
`sorry`, `admit`, `unsafe`, `native_decide`, disabled check, or placeholder is
a hard failure. The fixture probe may use kernel reduction or ordinary
decision procedures, but not an untrusted evaluator.

Documentation-only changes require only Level 1 checks: `git diff --check`,
changed-file privacy/secret scanning, link and declaration-name validation,
and evidence-label consistency. They do not trigger a clean repository build.

## 9. Stop and escalation rules

Stop the current implementation layer and escalate to the supervising Sol
Medium lead if any of the following occurs:

- either direction of Declaration A's equality equivalence appears false;
- equality can occur for two distinct admissible numerical owner speeds;
- the normalized proof requires an unstated positivity, coprimality,
  divisibility, exact-division, or `k < P` premise;
- Declaration B requires global injectivity instead of injectivity on `C`;
- strictness fails in the boundary case `3 * C.card = N + 1`;
- a proof changes `< p` to `<= p` or drops the `N ∤ r` candidate condition;
- a proof quotients labelled owners by equal bad sets or residues;
- Declaration C requires inclusion minimality or a minimal-cover selection;
- Declaration D requires constructing a redundant owner instead of proving
  the complete-cover antecedent impossible;
- an existing-definition adapter has a different quantifier order or semantic
  domain from the statement frozen here;
- or the target cannot compile within the task's declared budget without
  changing its signature.

Routine repairs to syntax, imports, type annotations, local arithmetic
elaboration, or deterministic fixture serialization do not require
escalation. A failed theorem must not be replaced by a nearby compilable one.

## 10. Evidence limits

This document is a specification artifact only. It proves no Lean theorem and
does not promote Task366 or any project status.

After independent kernel checking, each declaration may receive
declaration-scoped `proved-lean` evidence only at its exact hypotheses:

- A: one-owner bound and equality classification for `N >= 5`;
- B: noncover only for injective labelled families with `2 <= C.card` and
  `3 * C.card <= N + 1`;
- C: density only for internal complete covers at a maximum covered pivot;
- D: redundancy only under the displayed sparse-covered-pivots hypothesis,
  and only vacuously because no internal complete cover exists.

Finite fixture success is `computed finite evidence` at the enumerated inputs
only. It is not proof of A, B, C, or D. A compiled conditional adapter is not
evidence for an unproved arithmetic dependency. None of these results, even
after successful implementation, proves unrestricted Prompt95 or unrestricted
LRC.
