# Formal interface inventory (source `ec30e17`)

This is a read-only source map. “Proved” below means a Lean theorem with a body in the named current file. A `def ... : Prop` only declares a target; it is not evidence that the proposition holds.

## Canonical statement and reduction

* **Canonical target (declared, unproved):** `LonelyRunner.Conjecture` in `LonelyRunner/Definitions.lean:41`. It quantifies `n : Nat`, `2 <= n`, an injective `Fin n -> Real` speed map, every labelled runner, and a real time with the closed `1 / n` distance condition (`LonelyAt`, lines 34–36). Its imports are `Mathlib.Analysis.Normed.Group.AddCircle` and `Mathlib.Data.Fin.Basic`.
* **Useful proved formulation bridges:**
  * `conjecture_iff_relativeConjecture` (`Definitions.lean:103`);
  * `conjecture_iff_distinctStationaryConjecture` (`StationaryEquivalence.lean:98`);
  * `conjecture_iff_stationaryConjecture` (`RepeatedStationaryEquivalence.lean:84`).
* **Positive-integer reduction (proved):** `conjecture_iff_positiveIntegerConjecture : Conjecture <-> PositiveIntegerConjecture` in `LonelyRunner/BHKRealReduction.lean:114`. It composes the stationary bridge, `stationaryConjecture_iff_positiveRationalConjecture` (`BHKRealReduction.lean:106`), and `positiveIntegerConjecture_iff_positiveRationalConjecture` (`RationalReduction.lean:188`). `PositiveIntegerConjecture` itself is only a declared proposition at `Formulations.lean:54`: positive injective natural speeds, `n >= 1`, unrestricted real time, closed threshold `1/(n+1)`.
* **Immediate missing premise for a canonical proof:** no declaration inhabits `PositiveIntegerConjecture`. The reduction is bidirectional; it does not furnish a witness or discharge the integer statement. `BHKRealReduction.lean` imports the collision/rational/stationary chain, and root `LonelyRunner.lean:70–86` imports that chain.

## Pivot certificate layer

* **Strict finite primitives (declared):** `pivotCandidates` and `pivotBadResidues` in `LonelyRunner/PivotResidues.lean:24,30`. A candidate is below `N*p` and not divisible by `N`; a bad residue has `cyclicResidueDistance (N*p) (r*d) < p`. Thus equality is safe. The file imports `LonelyRunner.StructuredClasses` and `Mathlib.Data.Finset.Card`.
* **Proved adapters:** `mem_pivotCandidates` (line 34), `mem_pivotBadResidues` (38), `pivotBadResidues_subset` (44), `card_pivotCandidates` (66), `not_mem_pivotBadResidues_iff_circleNorm_ge` (185), and `pivotResidueWitness` (242). Exact one-set cardinality is `card_pivotBadResidues_exact` in `LonelyRunner/PivotCounts.lean:441` (imports `PivotResidues`, floor division, and finset intervals).
* **Fixed-instance equivalence (proved):** `exists_witness_iff_exists_pivot_certificate` in `LonelyRunner/PivotBoundary.lean:454`. Under `2 <= N` and positivity of the finite natural speed family, it equates an arbitrary real common witness with
  `exists pivot r, r in pivotCandidates N (speeds pivot) /\ forall i != pivot, r notin pivotBadResidues N (speeds pivot) (speeds i)`.
  Its proof includes the boundary/grid normalization (`exists_safe_pivot_residue`, line 422). `PivotBoundary` imports `PivotResidues`, `Formulations`, and the intermediate-value theorem.
* **All-integer proposition and exact equivalence (proved):** `PositiveIntegerPivotCertificateConjecture` is a **definition** at `PivotBoundary.lean:479`; `positiveIntegerConjecture_iff_pivotCertificateConjecture` is a **theorem** at line 491. It preserves the original injective/positive hypotheses and fixes `N = n + 1`.
* **Immediate missing premise:** no theorem supplies the universally quantified pivot/residue required by `PositiveIntegerPivotCertificateConjecture`; therefore the exact equivalence is not an integer-LRC proof. Together with the preceding reduction, it gives a checked bridge from a proof of the universal pivot certificate to `Conjecture`, but no such proof exists in source.

## Covered-pivot and strict-cover structure

`LonelyRunner/Prompt99Scaling.lean` (imports `PivotCounts`) provides the current literal interfaces:

* `PivotCompleteCover` (line 28): a labelled `C : Finset (Fin n)` excludes `j` and covers every candidate by some owner's strict bad set.
* `PivotCovered` (35), noncomputable finite `coveredPivots` (39), `IsMaximumCoveredPivot` (46), `IsInternalOwnerSet` (52), and `InternalCoverRedundantAt` (58) are all **definitions of Props**. In particular, the maximum predicate includes both membership in `coveredPivots` and the speed-maximality comparison; an internal owner set is a subset of `(coveredPivots N a).erase j`.
* Proven common-scaling transport includes `pivotCompleteCover_scale_iff` (148), `coveredPivots_scale` (192), `isMaximumCoveredPivot_scale_iff` (202), `isInternalOwnerSet_scale_iff` (219), and `internalCoverRedundantAt_scale_iff` (226).
* `MaxCoveredPivotInternalCoverRedundancy` (247) and its divisible version (258) are **only propositions**. `maxCoveredDivisible_iff_unrestricted` (270) is proved and says the two propositions are equivalent; it proves neither redundancy proposition.

The immediate missing premise for a cover-to-certificate route is precisely an inhabitant of `MaxCoveredPivotInternalCoverRedundancy` (or its divisible equivalent), plus the separate bridge from redundancy to a noncovered pivot/certificate. No theorem in `Prompt99Scaling.lean` establishes either. The source search found no declaration named `Prompt95` theorem that closes this gap.

## Prompt100: present formal seed versus absent accepted claims

The accepted material is explicitly contract-only: `docs/prompt100-two-owner-formalization-contract.md:7–10` says “no Lean implementation,” and its acceptance is `proved-math-qualified`, not `proved-lean`. Current root imports `Prompt100TwoOwnerCounts` (`LonelyRunner.lean:35–36`), but no proposed `Prompt100Four` or `Prompt100InternalCover` module exists.

**Present and proved:**

* `normalizedBadCount` is a **definition** in `LonelyRunner/Prompt100TwoOwnerCounts.lean:7`.
* `card_pivotBadResidues_normalized` is a **proved theorem** at line 37. It needs explicit `N >= 2`, positive/lower owner, gcd factorization `h,P,D,k`, coprimality of `D,P`, and `k = gcd D N`; it rewrites the exact one-owner cardinality only. The module imports `PivotCounts` and `Mathlib.Data.Finset.Card`.
* Generic union tools already exist: `card_biUnion_le_sum_card` and `exists_mem_avoiding_of_sum_card_lt_card` in `LonelyRunner/ModularCertificates.lean:20,33`. They supply finite-union cardinality logic but no Prompt100 inequality.

**Absent from all `*.lean` source searches (frozen Prompt100 claims):**

* `twoLowerOwner_badCardSum_lt_of_five_le`, `badCard_le_half_and_eq_owner` (the `N >= 5` pair/equality branch);
* `exists_quarterSafe_smallMultipliers`, `IsFourGOwner`, `fourGOwner_has_commonSafeCandidate_of_primitive`, and `four_twoLowerOwner_noncover` (the `N = 4` branch);
* `lowerOwner_badCard_lt_candidates` and `singletonLowerOwner_noncover`;
* public `twoLowerOwner_noncover` and `union_twoLowerOwner_badResidues_ne_candidates`;
* `no_internalCompleteCover_of_coveredPivots_card_le_three` and `internalCoverRedundantAt_of_coveredPivots_card_le_three`.

Their exact frozen signatures are in `docs/prompt100-two-owner-formalization-contract.md:18–53,101–143,153–206,227–272`. The immediate missing formal premises are the `N >= 5` strict pair-cardinality/equality proof, the `N = 4` class/closed-arc/lift proof, the singleton count, and the finite internal-owner cardinality/minimization wrapper. The contract itself records these unresolved edges at lines 318–335. No source definition or theorem permits treating the document's mathematical acceptance as Lean proof.

## Task366 owner-density claims

Task366 is also a specification, not implementation: `docs/task366-owner-count-formalization-contract.md:7` says “no Lean implementation.” Its proposed module, `LonelyRunner/Prompt100OwnerDensity.lean`, is absent. The specified imports are `Prompt100TwoOwnerCounts`, `Prompt99Scaling`, and `ModularCertificates` (lines 60–73); all three currently exist.

**Absent from all `*.lean` source searches (all frozen Task366 public claims):**

1. `card_pivotBadResidues_owner_bound` and bidirectional `card_pivotBadResidues_owner_bound_eq_iff` (contract lines 89–103).
2. `sparse_injective_owner_family_noncover` (125–136), which requires labelled `Set.InjOn speed (↑C : Set iota)`, at least two owners, lower/positive speeds, and `3*C.card <= N+1`.
3. `internal_complete_cover_owner_density` (164–172), the strict `N+1 < 3*C.card` conclusion for an internal complete cover at a maximum covered pivot.
4. `internalCoverRedundantAt_of_sparse_coveredPivots` (190–198), the vacuous sparse-covered-pivot wrapper.

Immediate missing premises are not merely imports: the existing normalized count must be strengthened into the `N >= 5` owner bound and its exact equality iff; the strict labelled finite-sum lemma then needs the unique equality owner; the density theorem also needs explicit empty/singleton cover exclusions; and the final wrapper needs the erase-cardinality contradiction. These are exactly the dependency order stated at contract lines 224–284. `card_biUnion_le_sum_card`, `card_pivotCandidates`, `pivotBadResidues_subset`, the strict definitions, and the covered-pivot definitions are available adapters, but none proves any Task366 public claim.

## Selection-relevant conclusion

At `ec30e17`, the formalized spine is complete through (1) canonical <-> positive-integer reduction and (2) positive-integer <-> finite pivot-certificate equivalence, plus exact one-bad-set counting and scaling/cover definitions. The unproved bottleneck is universal construction of a certificate. Prompt100 and Task366 contribute only one compiled normalized-count lemma; their accepted pair, cover, and density conclusions have no Lean declarations/theorems in this checkout. Any proof task should retain the strict `< p` badness, labelled `Finset` owners, and the contracts' displayed hypotheses rather than promote a `Prop` definition or a contract statement into a proved fact.
