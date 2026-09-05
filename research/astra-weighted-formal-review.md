# Independent review of the weighted affine-avoidance formalization

Status: **accepted**, 2026-09-05. Both public declarations implement the
accepted weighted counting contract without weakened conclusions or extra
hypotheses. This is a kernel-checked finite-field lemma, not an unrestricted
normalization theorem or a resolution of LRC.

Reviewer `/root/vanishing_slope`, requested in-session Astra xhigh,
independent of implementation author `/root/fixed_grid_checker`. Observed
runtime model/effort metadata is unavailable. Current project configuration,
workflow, policy and state were read; the workflow validator passed.
Only this review note was written. The frozen pass 9 review remains unchanged.

## 1. Exact source binding and public contracts

The entire frozen source was read:

```text
LonelyRunner/WeightedAffineAvoidance.lean
  59c8421001abfa0b7776783ea0af3bae562eb3a5a3270c07d6971cf07a20b195
research/astra-pass9-review.md (unchanged accepted manuscript review)
  d489613c466422a94e1a1d95360bbba6854fc073765267b5fc47dd4496ba125a
```

The exact primary contract is:

```lean
theorem LonelyRunner.weighted_affine_avoidance
    (p : ℕ) [Fact p.Prime] {I : Type*} [Fintype I]
    (a v : I → ZMod p) (F : I → Finset (ZMod p))
    (_hzero : ∀ i, 0 ∈ F i)
    (hdir : ((Finset.univ : Finset (ZMod p)).filter fun m =>
      m ≠ 0 ∧ ∃ i, v i + m * a i = 0).card ≤ p - 2)
    (hweight : Finset.univ.sum (fun i => ((F i).erase 0).card) ≤ p - 2) :
    ∃ r s : ZMod p, r ≠ 0 ∧ s ≠ 0 ∧
      ∀ i, s * v i + r * a i ∉ F i
```

`LonelyRunner.weighted_affine_avoidance_author` has exactly the same
parameters, weight assumption and conclusion, with direction hypothesis

```lean
    (hdir : ((Finset.univ : Finset (ZMod p)).filter fun m =>
      m ≠ 0 ∧ ∃ i, a i + m * v i = 0).card ≤ p - 2)
```

These are the parent's requested and manuscript-author ratio conventions,
respectively. No oddness, nonempty-index, cardinality-of-I, nonzero-slope,
nonzero-offset, distinctness, product, or supplied-witness assumption was
added. The parameter `p` is any prime, including 2. Both selected parameters
are nonzero and every original index is included in the conclusion.

## 2. Proof audit

The proof constructs `U=univ.erase 0` with cardinality `p-1`. Primality
supplies `p>=2`, so the natural-number bounds `p-2<p-1` remain correct at
the endpoint `p=2`. If every element of `U` belonged to the bad-direction
set, cardinal monotonicity would contradict its bound. Hence a nonzero
direction `m` exists with every `w_i=v_i+m*a_i` nonzero.

For each row, its bad nonzero scales are filtered by membership of `s*w_i`
in `(F i).erase 0`. Multiplication by the established nonzero `w_i` is
injective over the prime field, so that bad-scale set has cardinality at
most the row's forbidden weight. The cardinality of their finite union is
at most the sum of those weights, strictly less than `p-1`. A second
cardinality contradiction therefore produces a nonzero scale `s` outside
the union. The returned pair is `(r,s)=(s*m,s)`.

The final contradiction uses both facts needed for erase membership:
`s*w_i` belongs to `F i` under the alleged failure, and it is nonzero.
Thus no forbidden element is accidentally omitted when passing through
`erase 0`. The explicit `_hzero` argument is unused by the proof because
the erase cardinality already charges every forbidden nonzero value; it
is nevertheless retained in the public contract as requested. With that
argument, the weight agrees with the manuscript's `|F_i|-1` expression.

The author-oriented theorem calls the primary theorem with coefficients
swapped. Its resulting avoidance expression is `s*a_i+r*v_i`; swapping
the two witnesses restores the required output `s*v_i+r*a_i`. The source
does this explicitly, including the order of the two nonzero proofs.
This is not an unproved assertion that the two direction sets are equal.

Zero slopes and zero offsets need no special case: the chosen direction
ensures each `w_i` is nonzero. A row with both coefficients zero would
exhaust all `p-1` bad directions, so the direction bound itself rules it
out. Repeated rows are correctly charged separately in the weight sum,
while coincident bad directions are counted once in the direction set.
Empty `I` simply leaves both unions empty and both selected parameters
nonzero; the proof requires no selected row.

The source contains no `sorry`, `admit`, custom axiom, `native_decide`,
unsafe implementation, or external computational shortcut. Its only import
is the existing pinned mathlib finite-field module.

## 3. Build, type and axiom evidence

Commands, with the already prepared shared pinned cache:

```sh
env PATH="$HOME/.elan/bin:$PATH" lake build LonelyRunner.WeightedAffineAvoidance
env PATH="$HOME/.elan/bin:$PATH" lake env lean LonelyRunner/WeightedAffineAvoidance.lean
```

Both completed with exit status 0. The first was a targeted module build,
not a whole-repository build. The second freshly checked the source itself.

An independent stdin probe imported only the reviewed module, checked both
public types and printed their axioms. Exact axiom results:

```text
'LonelyRunner.weighted_affine_avoidance' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.weighted_affine_avoidance_author' depends on axioms: [propext, Classical.choice, Quot.sound]
```

The same probe compiled seven meaningful fixtures: prime-two empty indices;
three repeated zero-slope rows at prime two; three repeated zero-offset
rows at prime two; rejection of a zero form by the direction premise;
two distinct concrete direction sets; and an application of the author
orientation with a genuine triple forbidden set. In the repeated-row
fixtures, `card I=3` exceeds `p-2=0`, confirming that no hidden row-count
hypothesis was introduced. The two convention fixtures produce `{3}` and
`{2}`, respectively, so they do not test only a symmetric special case.

The complete successful probe is reproducible with:

```sh
env PATH="$HOME/.elan/bin:$PATH" lake env lean --stdin <<'LEAN'
import LonelyRunner.WeightedAffineAvoidance
open LonelyRunner
local instance : Fact (Nat.Prime 5) := ⟨by decide⟩
#check weighted_affine_avoidance
#check weighted_affine_avoidance_author
#print axioms weighted_affine_avoidance
#print axioms weighted_affine_avoidance_author

example : ∃ r s : ZMod 2, r ≠ 0 ∧ s ≠ 0 ∧
    ∀ _i : Fin 0, s * (0 : ZMod 2) + r * 0 ∉ ({0} : Finset (ZMod 2)) := by
  exact weighted_affine_avoidance 2 (fun _ : Fin 0 => 0) (fun _ => 0)
    (fun _ => {0}) (by intro _i; simp) (by decide) (by decide)
example : ∃ r s : ZMod 2, r ≠ 0 ∧ s ≠ 0 ∧
    ∀ _i : Fin 3, s * (1 : ZMod 2) + r * 0 ∉ ({0} : Finset (ZMod 2)) := by
  exact weighted_affine_avoidance 2 (fun _ : Fin 3 => 0) (fun _ => 1)
    (fun _ => {0}) (by intro _i; simp) (by decide) (by decide)
example : ∃ r s : ZMod 2, r ≠ 0 ∧ s ≠ 0 ∧
    ∀ _i : Fin 3, s * (0 : ZMod 2) + r * 1 ∉ ({0} : Finset (ZMod 2)) := by
  exact weighted_affine_avoidance 2 (fun _ : Fin 3 => 1) (fun _ => 0)
    (fun _ => {0}) (by intro _i; simp) (by decide) (by decide)
example : ¬ ((Finset.univ : Finset (ZMod 2)).filter fun m =>
    m ≠ 0 ∧ ∃ _i : Fin 1, (0 : ZMod 2) + m * 0 = 0).card ≤ 2-2 := by decide
example : ((Finset.univ : Finset (ZMod 5)).filter fun m =>
    m ≠ 0 ∧ ∃ _i : Fin 1, (2 : ZMod 5) + m * 1 = 0) = {3} := by decide
example : ((Finset.univ : Finset (ZMod 5)).filter fun m =>
    m ≠ 0 ∧ ∃ _i : Fin 1, (1 : ZMod 5) + m * 2 = 0) = {2} := by decide
example : ∃ r s : ZMod 5, r ≠ 0 ∧ s ≠ 0 ∧
    ∀ _i : Fin 1, s * (2 : ZMod 5) + r * 1 ∉ ({0,1,2} : Finset (ZMod 5)) := by
  exact weighted_affine_avoidance_author 5 (fun _ : Fin 1 => 1) (fun _ => 2)
    (fun _ => {0,1,2}) (by intro _i; simp) (by decide) (by decide)
LEAN
```

All `decide` uses are ordinary kernel-checked finite fixture proofs, not
`native_decide` or an added trust mechanism. No theorem source was edited
to make these fixtures pass.

## 4. Disposition and scope

Accept both declarations at the bound source hash, with only the three
permitted standard axioms. No correction is requested. The frozen pass 9
review was left unchanged, and the workflow structural validator passed.
The cyclic integer bridge and the full one-outlier family are separate
formalization/review checkpoints; they are not established by this module
alone. Unrestricted supply and canonical LRC remain unresolved.
