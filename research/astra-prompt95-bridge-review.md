# Independent review of the conditional Prompt95 bridge

Review date: 2026-09-05. Reviewer: in-session Astra, requested extra-high
reasoning; independent of the Terra implementation. Source checkpoint:
`8a3a407f729163316a11ffbb863ca9dddf249d36`.

## Frozen artifacts and scope

- `LonelyRunner/Prompt95CanonicalBridge.lean`:
  `4cf03bcbb47c7d935766281927e333e8734c09b08a2ae399815cc79dc05695d2`.
- `research/astra-prompt95-bridge-implementation.md`:
  `677dd245715583b78b5e04d5d2fd77a1c813bdfce251a744ef6d5c88b4270f61`.

The entire source and implementation note were read, along with the exact
definitions of candidates, strict bad residues, complete and internal covers,
covered pivots, maximum covered pivots, universal redundancy, the positive
integer formulation, its pivot certificate equivalence, the canonical real
formulation, and the existing real/integer equivalence. No source, imports,
workflow state, Git state, or other worker files were edited by this reviewer.
The only owned artifact is this review. No dependency rebuild was requested.

## Semantic assessment

The finite equivalence preserves the exact quantifier over **every** labelled
internal complete cover. Erasing a redundant member strictly reduces the finite
owner set and preserves internality. A nonempty candidate row excludes the
empty complete cover; strong induction therefore excludes every internal
complete cover. The reverse implication is the direct contradiction between
the supplied cover and the asserted absence of any such cover. No assumption
about positive speeds, injectivity, or canonical runner counts enters this
finite statement.

The nonempty-row hypothesis is sufficient and all canonical applications meet
it. It is needed for this source proof's subsidiary claim that the empty set
cannot cover the row, but is **not necessary for the equivalence itself**.
On an empty row, the empty owner set is an internal complete cover; redundancy
is false because it demands an element of that empty set. The no-internal-cover
side is false as well. The independent generic probe below proves the stronger
unconditional equivalence by applying redundancy before every induction step,
including the empty-set case. This is a nonblocking scope clarification, not
a correction to the frozen theorem or a claim of progress toward LRC.

For the positive integer implication, failure of any pivot certificate forces
every pivot to be covered. A maximum-speed label exists in the nonempty finite
family. Because all labels are covered, this label is a maximum covered pivot
and its full set of other labels is internal as well as complete. The explicit
universal premise gives redundancy at precisely this label, contradicting the
finite equivalence. Choosing a maximum in all labels here is sound because
all labels have first been proved covered. No speed ordering is imposed on the
input tuple.

The universal premise starts at two positive moving speeds, so the proof treats
one moving speed separately. Residue one is a candidate at denominator twice
any positive pivot speed. There are no other moving labels to exclude; the
pivot itself attains the closed one-half boundary. The independent arbitrary-p
probe below checks equality of the cyclic distance to p and exclusion from the
strict bad set. No zero-speed or empty-row tuple slips into the canonical use:
positivity and the runner-count hypotheses produce candidate one.

The final declaration has type
`MaxCoveredPivotInternalCoverRedundancy → Conjecture`. It applies the checked
positive-integer equivalence to the canonical statement for every real-speed
injective tuple, every runner count at least two, and every chosen runner, with
real time and the closed reciprocal distance. It imposes no height bound,
divisibility, sign, rationality, or supplied-witness restriction on canonical
tuples. The redundancy premise remains explicit and unproved. No converse is
claimed. Acceptance of this bridge would not prove either that premise or LRC.

## Reproducible checks

The pinned toolchain is `leanprover/lean4:v4.32.1`. A direct fresh source check
completed with exit status zero and no diagnostics:

```sh
PATH="$HOME/.elan/bin:$PATH" lake env lean LonelyRunner/Prompt95CanonicalBridge.lean
```

The following replay concatenates the frozen source with the Lean block below,
so it checks current source rather than importing a possibly stale bridge
olean. It creates no scratch project file or alternate dependency cache.

```sh
python3 - <<'PY'
import os, pathlib, re, subprocess
source = pathlib.Path('LonelyRunner/Prompt95CanonicalBridge.lean').read_text()
review = pathlib.Path('research/astra-prompt95-bridge-review.md').read_text()
probe = re.search(r'```lean\n(.*?)\n```', review, re.S).group(1)
env = os.environ.copy()
env['PATH'] = str(pathlib.Path.home() / '.elan/bin') + ':' + env['PATH']
raise SystemExit(subprocess.run(['lake', 'env', 'lean', '--stdin'],
    input=source + '\n' + probe, text=True, env=env).returncode)
PY
```

```lean
#check LonelyRunner.internalCoverRedundantAt_iff_no_internal_complete_cover
#check LonelyRunner.positiveIntegerConjecture_of_maxCoveredPivotInternalCoverRedundancy
#check LonelyRunner.conjecture_of_maxCoveredPivotInternalCoverRedundancy
#print axioms LonelyRunner.internalCoverRedundantAt_iff_no_internal_complete_cover
#print axioms LonelyRunner.positiveIntegerConjecture_of_maxCoveredPivotInternalCoverRedundancy
#print axioms LonelyRunner.conjecture_of_maxCoveredPivotInternalCoverRedundancy

namespace LonelyRunner.Prompt95BridgeReview

theorem unconditional_finite_iff {n N : Nat} {a : Fin n → Nat} {j : Fin n} :
    InternalCoverRedundantAt N a j ↔
      ∀ C : Finset (Fin n),
        IsInternalOwnerSet N a j C → ¬ PivotCompleteCover N a j C := by
  constructor
  · intro hredundant
    have hno : ∀ D : Finset (Fin n),
        IsInternalOwnerSet N a j D → PivotCompleteCover N a j D → False := by
      intro D
      induction D using Finset.strongInduction with
      | H D ih =>
          intro hinternal hcover
          obtain ⟨i, hi, hcoverErase⟩ := hredundant D hinternal hcover
          exact ih (D.erase i) (Finset.erase_ssubset hi)
            (fun k hk => hinternal (Finset.erase_subset i D hk)) hcoverErase
    exact hno
  · intro hno C hi hc
    exact False.elim (hno C hi hc)

theorem empty_row_controls {n N : Nat} {a : Fin n → Nat} {j : Fin n}
    (he : pivotCandidates N (a j) = ∅) :
    IsInternalOwnerSet N a j ∅ ∧ PivotCompleteCover N a j ∅ ∧
      ¬ InternalCoverRedundantAt N a j ∧
      ¬ (∀ C : Finset (Fin n),
        IsInternalOwnerSet N a j C → ¬ PivotCompleteCover N a j C) := by
  have hi : IsInternalOwnerSet N a j ∅ := Finset.empty_subset _
  have hc : PivotCompleteCover N a j ∅ := by
    refine ⟨Finset.empty_subset _, ?_⟩
    intro r hr
    simp [he] at hr
  refine ⟨hi, hc, ?_, ?_⟩
  · intro h
    obtain ⟨i, himem, _⟩ := h ∅ hi hc
    simp at himem
  · intro h
    exact h ∅ hi hc

example : pivotCandidates 3 0 = ∅ := by decide
example : pivotCandidates 1 7 = ∅ := by decide

theorem singleton_boundary (p : Nat) (hp : 0 < p) :
    1 ∈ pivotCandidates 2 p ∧
      cyclicResidueDistance (2 * p) (1 * p) = p ∧
      1 ∉ pivotBadResidues 2 p p := by
  have hlt : p < 2 * p := by omega
  have hsub : 2 * p - p = p := by omega
  have hd : cyclicResidueDistance (2 * p) (1 * p) = p := by
    simp [cyclicResidueDistance, Nat.mod_eq_of_lt hlt, hsub]
  refine ⟨?_, hd, ?_⟩
  · rw [mem_pivotCandidates]
    constructor <;> omega
  · rw [mem_pivotBadResidues]
    intro h
    rw [hd] at h
    omega

theorem arbitrary_positive_integer_tuple
    (h : MaxCoveredPivotInternalCoverRedundancy)
    (n : Nat) (hn : 1 ≤ n) (a : Fin n → Nat)
    (hinj : Function.Injective a) (hpos : ∀ i, 0 < a i) :
    ∃ j : Fin n, ∃ r : Nat, r ∈ pivotCandidates (n + 1) (a j) ∧
      ∀ i, i ≠ j → r ∉ pivotBadResidues (n + 1) (a j) (a i) :=
  (positiveIntegerConjecture_iff_pivotCertificateConjecture.mp
    (positiveIntegerConjecture_of_maxCoveredPivotInternalCoverRedundancy h))
    n hn a hinj hpos

theorem arbitrary_real_tuple (h : MaxCoveredPivotInternalCoverRedundancy)
    (n : Nat) (hn : 2 ≤ n) (v : Fin n → ℝ)
    (hinj : Function.Injective v) (j : Fin n) :
    ∃ t : ℝ, LonelyAt v j t :=
  (conjecture_of_maxCoveredPivotInternalCoverRedundancy h) n hn v hinj j

#print axioms unconditional_finite_iff
#print axioms empty_row_controls
#print axioms singleton_boundary
#print axioms arbitrary_positive_integer_tuple
#print axioms arbitrary_real_tuple

end LonelyRunner.Prompt95BridgeReview
```

The fresh-source replay completed with exit status zero and no warnings or
errors. The three public `#check` outputs retain exactly the displayed
nonempty-row and universal-redundancy hypotheses. Each of the three public
declarations and all five named control declarations reported exactly
`[propext, Classical.choice, Quot.sound]`; no other axiom occurs. Both closed
empty-row examples also elaborated by kernel `decide`.

The review's additional controls are proof checks, not finite experiments:
the empty-row and unconditional-equivalence controls quantify over arbitrary
natural dimensions and tuples, the one-speed boundary control quantifies over
every positive p, and the canonical application quantifies over every
admissible real-speed tuple.

Additional commands, each run at the repository root:

```sh
python3 scripts/validate_workflow.py
sha256sum LonelyRunner/Prompt95CanonicalBridge.lean research/astra-prompt95-bridge-implementation.md LonelyRunner/Definitions.lean LonelyRunner/Formulations.lean LonelyRunner/Prompt99Scaling.lean LonelyRunner/BHKRealReduction.lean LonelyRunner/PivotBoundary.lean LonelyRunner/PivotResidues.lean
python3 - <<'PY'
import pathlib, re
source = pathlib.Path('LonelyRunner/Prompt95CanonicalBridge.lean').read_text()
assert not re.search(r'\b(sorry|admit|axiom|native_decide|implemented_by|unsafe)\b', source)
print('Frozen bridge source trust-token scan passed.')
PY
```

Workflow structural validation and the source trust-token scan passed. The
trust-token scan is supplemental; the actual dependency trust evidence is the
transitive axiom output from the fresh source replay above. The reviewed
definition/equivalence hashes were:

| Source | SHA-256 |
| --- | --- |
| `LonelyRunner/Definitions.lean` | `5f0258a6ab99950fc7045b2200d6708fe7603d3caa4d62855ef2b19a330c95aa` |
| `LonelyRunner/Formulations.lean` | `0c3328e975bee236ff66862d3a5cadeb58fbc7c804fa953e53701ba466b9d788` |
| `LonelyRunner/Prompt99Scaling.lean` | `49131a7f9690042d1b16cbc876417f9d9ce1b53cc6565f87b6d1b53c4e3340cd` |
| `LonelyRunner/BHKRealReduction.lean` | `98d7c878eef7e4a3b7f7c504c882cf35191c1343816a59d731193ac8a207ed26` |
| `LonelyRunner/PivotBoundary.lean` | `0e56cab74d30ef8b537ed4ec24503aae875bd8aadc369d26da99ba882cc3603f` |
| `LonelyRunner/PivotResidues.lean` | `362da5ab923f22e900ae7ac821dd4cf4aab91dfe70889987bc9e5a05d19c276a` |

## Disposition

**Accepted as the exact conditional bridge. No blocking defect found.**
The frozen source and implementation-note hashes remained unchanged after
verification. The nonempty-row clarification above does not require a source
change. All processes launched for this review completed. Independent review
does not replace the orchestrator's integration, full build, and trust audit.
The missing mathematical input remains a proof of
`MaxCoveredPivotInternalCoverRedundancy`; neither that proposition nor the
unrestricted canonical conjecture has been established by this checkpoint.
