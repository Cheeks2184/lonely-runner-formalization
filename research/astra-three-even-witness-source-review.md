# Independent source review: complete three-even witness branch

Accepted: both new public witness contracts and every new proof body in the
frozen `ThreeEvenRunners.lean` match the accepted plan, with no mathematical or
scope defect found. The reviewer authored the three-even manuscript but did not
author this source. This is an independent implementation-source review, with
that manuscript authorship disclosed.

Current configuration/workflow/policy and focused state were read. State assigns
only this report at checkpoint `34afe4f`. The structural validator actually
exited 0 with `workflow structural validation passed; it cannot certify mathematical validity.`
The review used source reading and static comparisons of retained evidence only.
No Lean invocation, numerical experiment, source edit, Git/state mutation or
cache operation was performed.

## Exact new public contracts

Both declarations are in namespace `LonelyRunner`:

```lean
theorem fiveMovingNaturalRunners_of_three_even_residues
    (v : Fin 5 → ℕ) (hpos : ∀ i, 0 < v i)
    (hsix : 6 ∣ v 0)
    (heven1 : 2 ∣ v 1) (heven2 : 2 ∣ v 2)
    (hodd3 : ¬ 2 ∣ v 3) (hodd4 : ¬ 2 ∣ v 4)
    (hother : ∀ i, i ≠ 0 → ¬ 3 ∣ v i) :
    ∃ t : ℝ, 0 < t ∧ ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ))

theorem one_three_divisible_three_even_witness
    (v : Fin 5 → ℕ) (hpos : ∀ i, 0 < v i) (p : Fin 5)
    (hone : ∀ i, 3 ∣ v i ↔ i = p)
    (heven : ((Finset.univ : Finset (Fin 5)).filter
      (fun i => 2 ∣ v i)).card = 3) :
    ∃ t : ℝ, 0 < t ∧ ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ))
```

Static extraction matched both complete signatures to the accepted plan after
whitespace normalization. There is no ambient hypothesis. The fixed-role
theorem has exactly the stated parity/non-three-divisibility pattern; the count
adapter has no supplied six-divisibility premise. Both permit repeated positive
values, require no tuple gcd or injectivity assumption, and return one positive
time serving all five labels with closed bounds.

## Earlier proof preserved and correctly bound

The old odd-zero source hash `22351370ee5c81f7e07d86aa76fe1a2656dc0a02d76687fb86722c246a2f08f7`
refers to the **historical successful input snapshot** in the bound odd-zero
receipt, not the current whole file. The reviewer decoded that snapshot and
checked its hash. Removing its import header and final `end LonelyRunner`, its
7653-byte module-comment/namespace/declaration block is byte-for-byte the
corresponding initial block of the new source. That preserved block has SHA-256
`a96d169c609f141168ec7edfa4ae38d0bf8f4eedd42bb090388f0e43178991da`.
The import changes are exactly the four additional modules
`ThreeWeakExceptions`, `BadSixthDilate`, `TwoOddOutsideThree`, and
`SmallDenominatorWitness`. The abbreviation, two old private helpers and public
odd-zero proof are unchanged. Their separate accepted review remains bound below.

## New proof assessment

The new private `threeEven_coprime_six q h2 h3` proves `Nat.Coprime q 6`
from `¬2∣q` and `¬3∣q`. It uses the prime coprimality criterion for 2 and 3,
reverses its orientation to `Coprime q 2` and `Coprime q 3`, and combines them
with `Nat.coprime_mul_iff_right`. This is valid for composite q and makes no
claim that every nonzero residue modulo a composite modulus is a unit.

For the fixed-role theorem, the proof first assumes absence of an **all-real**
closed witness. It converts the five separate inequalities to `ThreeEvenFiveSafe`
by explicit cases on the Fin5 label and includes the witness time in the
existential. At a zero of v3 with a safe pivot v0, the unchanged odd-zero theorem
supplies a partner norm greater than 1/3 at v4. Its exact final conjunct supplies
the `hlarge` hypothesis of `threeEven_dvd_of_large_partner_at_zeros`, proving
`v3∣v0`. The second application swaps v3 and v4 in every relevant position:
positivity, coprimality, oddness, non-three-divisibility, and the order of the
last two safe conjuncts in hno. It therefore proves `v4∣v0` as well. It does
not infer a symmetric hypothesis without constructing it.

From `Coprime (vi) 6`, symmetry gives `Coprime 6 (vi)`. The exact
`mul_dvd_of_dvd_of_dvd hsix hdiv` has conclusion `6*vi∣v0`; positivity of v0
then yields `6*vi≤v0` by `Nat.le_of_dvd`, separately for i=3,4. These are
pairwise arithmetic facts, not an assumption of a primitive tuple. Neither
the value v1 nor v2 is assigned an unsupported fast-speed bound.

Set `t0=1/(6*v0)`. For every natural `1≤a≤5`, the actual pivot phase at
time `a*t0` is exactly `a/6`; cancellation uses v0>0. The closed integer-band
lemma preserves its safety, including a=1 and a=5. The two size bounds and
`threeEven_small_sixth_dilate_norm` make labels 3 and 4 strictly bad at this
same time. Explicit `le_of_lt` conversions place them in the **weak** bad set.
If label 1 is also weakly bad, the literal three distinct labels `{1,3,4}`
are contained in

`univ.filter (fun i => i≠0 ∧ N((a*t0)*vi)≤1/6)`.

The subset/cardinality argument counts labels, so equal speed values do not
collapse its cardinality. The source passes precisely this weak, closed
threshold, pivot safety, `3∣v0` and hother to
`third_shift_of_three_weak_exceptions`. Its returned **single** `k:Fin 3`
gives all five bounds at `a*t0+k.val/3`, contradicting the same hno. Equality
of label 1's norm with 1/6 is correctly included in this contradiction.

Thus label 1 is strictly safe for all five dilates. The a=1 instance feeds
`exists_bad_sixth_dilate`, whose returned `2≤a≤5` has norm strictly below
1/6. Associativity identifies its argument with the already strictly safe
phase at `a*t0`, yielding the contradiction. No separate choice of a per
label, unproved bound for v2 or five-moving witness hypothesis appears.
This proves the all-real witness. The source excludes time zero using the
positive threshold at label 0 and converts a negative witness to its negation
using `circleNorm_neg`. It therefore returns the advertised positive witness.

For the count adapter, all-real nonexistence and
`divisor_cover_of_no_small_witness` at N=q=6 supply a six-divisible label i.
Since 3 divides 6, hone identifies i with p. This derives six-divisibility
and evenness at p without a gcd assumption or the primitive divisor upper bound.
For the even-label finset S, `S.card=3` and `p∈S` imply
`(S.erase p).card=2`. `Finset.card_eq_two` supplies distinct e,f;
erase membership excludes p and proves their evenness. The call to
`exists_two_odd_outside_three v p e f` supplies precisely the required
inequalities `p≠e`, `f≠p`, `f≠e` as `hep.symm`, `hfp`, `hef.symm`.
It returns odd u,w and exhaustion of all five labels.

The vector `v' = ![v p,v e,v f,v u,v w]` inherits positivity and all required
parities. The explicit non-three-divisibility proof uses hone and e,f≠p;
for u,w it first derives exclusion from p by oddness versus evenness of p.
Calling the already established fixed-role theorem for v' is noncircular.
The exhaustion disjunction transfers the **same** returned time and each of
its five coordinate inequalities to the original labels. The outer all-real
contradiction then uses the same nonzero/negation conversion at p to return a
positive time. No permutation of speed values or injectivity assumption is
introduced; no unqualified all-five-divisible reduction is used.

## Actual focused evidence and repair history

The reviewer statically verified the two physical before-source files, all four
embedded before/after source records, all four physical/embedded raw stream
records, and both final artifacts against their bytes and SHA-256 values.
Each capture has identical before/after source bytes; the final capture equals
the current source. Both complete diagnostics and the exact repair diff were
read. All checks passed. The historical whole-file and preserved-block checks
above were separate static comparisons, not Lean re-executions.

| Capture | Source SHA-256 | Actual exit | Wall seconds | Stdout / stderr bytes |
| --- | --- | --- | --- | --- |
| initial | `66b4eeccb50eef61dcff0a32849fe80af96bbebe291cdc796ad51335d700c05a` | 1 | 8.847453020978719 | 7000 / 0 |
| repair1 | `6089c1920a69127b113ecf3a0d6cc57c6f080d46a6bf81b15b855e2eec77dc6c` | 0 | 7.695886914007133 | 2036 / 0 |

These are retained worker executions. The full argv arrays, cwd, Elan PATH
override, snapshot/stream paths and contents are in
`generated_focus_captures.initial` and `.repair1` of the bound receipt.
Each command locks `.lake/verification.lock` and runs
`timeout --preserve-status 180s prlimit --as=8589934592 --cpu=179:180
lake env lean -j1 -s65536 LonelyRunner/ThreeEvenRunners.lean`
with explicit shared `.olean`/`.ilean` output paths. Actual controls are 8 GiB
address space, CPU soft/hard 179/180 seconds and wall 180 seconds. No original
CPU usage measurement or per-stream cap is claimed beyond the retained fields.

Before the initial capture, root gave one round of correction guidance for an
omitted existential witness and reversed label inequalities. That guidance is
counted as one Astra repair round, with zero direct Astra source lines. The
initial captured source still failed on a redundant post-`field_simp` tactic,
the missing strict-to-weak conversions at labels 3/4, and insufficiently explicit
non-three-divisibility reasoning for the relabelled odd positions. One worker
repair removed the redundant tactic, added the two weak bounds, and replaced
the final broad simplification by explicit coordinate proofs. The complete
new public types and the old proof block were unchanged across this repair.

The successful stdout contains only style/unused-tactic warnings: five inherited
sequence warnings, two unused simp-argument warnings, one no-op `norm_num`
warning and two unnecessary-`simpa` warnings. Their full unsuppressed bytes are
retained, with SHA-256
`a1e4e1ccff546694f395dc20ea2cfd109a78110881c8173de32cdff29bd81aec`.
Both stderr streams are empty, SHA-256
`e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.
The initial stdout SHA-256 is
`061a416af97f0f1b57088f6871a35c7175e5fc36b4813557ecd166972d902682`.
The final source is 16855 bytes; the `.olean` is 747376 bytes, SHA-256
`b2602827c2c86438c30351b2bc0d52ec0155713baad877c7d40a2fafd9bc02b8`;
the `.ilean` is 34890 bytes, SHA-256
`c19ba86df376efb24d709236a708b89b0c0f2f2067c668db279109f755e6f6c9`.

The receipt records `axiom_probe: null`, so no fresh axiom lists for these
declarations are asserted. Root's normal full integration/trust and axiom audit
remain pending. No distinct source or contract concern requiring a duplicate
probe was found. Delivery metrics retain first-check failure, one worker repair,
one Astra guidance round, zero direct Astra repair lines, and null total worker
elapsed time/usage where not exposed.

## Frozen bindings and scope

Paths are relative to `/home/joshua/lonely-runner-formalization`. The old
odd-zero report/receipt are historical bindings; only the current source row
below binds the complete current `ThreeEvenRunners.lean`.

| Path | SHA-256 |
| --- | --- |
| `LonelyRunner/ThreeEvenRunners.lean` | `6089c1920a69127b113ecf3a0d6cc57c6f080d46a6bf81b15b855e2eec77dc6c` |
| `research/astra-three-even-witness-implementation.json` | `0ecd1232c8cb29d3974e1294a9580c93375d53dacda95c7c3e8a85af295a2f0c` |
| `research/astra-three-even-assembly-plan.md` | `66a9bac477d1e985d23f6188197ca7af6f0d90ad29df38ab8e710ed417cf510a` |
| `research/astra-three-even-odd-zero-review.md` | `49e055694402f2a2c408651d1182b3f70c1178898d0778e379430132148a5988` |
| `research/astra-three-even-odd-zero-implementation.json` | `c390e9fed0877536b62615de5c82f9ea653f9f0af2358bf80c92388b33a11b7c` |
| `LonelyRunner/ThreeEvenOrbit.lean` | `2d2cbdd51dc51f1e23985feb9c7826ce5bb944118f01c8c7719e5ad25de4e088` |
| `research/astra-three-even-orbit-source-review.md` | `69e38074735e7480e5fca33dbc15a0b5d81faf9a1048860d270f39f792b841b6` |
| `LonelyRunner/ThreeWeakExceptions.lean` | `bdb75b5254a4a8bacb01f29ebdef34b40aa966c96de2b69285290ec03bb43d33` |
| `LonelyRunner/BadSixthDilate.lean` | `5031f198c72e9b248962d7c91c263a7d4b1f6d5d4c55a01fd927ab769d8e3b96` |
| `LonelyRunner/TwoOddOutsideThree.lean` | `6b2c9fb02bffe58cdd2383246c56dfca3f91fe3b88c1a2902486b4d90cae6735` |
| `LonelyRunner/SmallDenominatorWitness.lean` | `1570a359100594f4a5589588e3b32674dc2d54d60e500df1d47aca64c2faf95f` |
| `lean-toolchain` | `8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af` |
| `lake-manifest.json` | `887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218` |

This establishes source acceptance of the exact three-even restricted witness
branch. The two-even dependency and final primitive/normalization/H7/canonical
assembly remain separate work; this report does not claim canonical N=6 or
unrestricted LRC completion. The standing transition remains checked canonical
N=6, followed by uniform arbitrary-N research.
