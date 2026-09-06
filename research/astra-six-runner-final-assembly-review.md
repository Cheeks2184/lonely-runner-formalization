# Independent review and implementation contract: final six-runner assembly

The root's frozen assembly plan is mathematically accepted. Its seven bound
source files have the stated hashes, and their actual interfaces support the
normalization and canonical bridge without an additional theorem about real
speed ratios. The only unimplemented mathematical inputs to this assembly are
the exact two-even and three-even branch contracts below. They remain future
dependencies in this review; no declaration depending on them is claimed to
have compiled.

The reviewer did not author the root assembly plan. The reviewer authored the
earlier one-three-divisible and three-even manuscripts; the original
one-three-divisible manuscript has its separate independent review. Here the
review is of the final dispatcher, gcd removal, bounded hypothesis and canonical
quantifiers, not another source review of the unfinished parity implementations.

Current project instructions/policy and focused state were read. State records
this Astra/xhigh review at source checkpoint
`62eef5c0c8a39cde54e37e0ea68095f98dd3c1a9`; only this report is owned.
`python3 scripts/validate_workflow.py` actually exited 0 with
`workflow structural validation passed; it cannot certify mathematical validity.`
All checks here are static source reading, signature extraction or byte hashing.
No Lean execution, numerical experiment, probe, source implementation, Git/state
edit or cache modification was performed.

## 1. Exact final declarations to implement

These proposed names are currently unused. All belong to namespace
`LonelyRunner`; the signatures below are the acceptance contract.

```lean
theorem fiveMovingNaturalRunners_of_primitive
    (v : Fin 5 → ℕ) (hpos : ∀ i, 0 < v i)
    (hprimitive : Finset.univ.gcd v = 1) :
    ∃ t : ℝ, 0 < t ∧ ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ))

theorem fiveMovingNaturalRunners
    (v : Fin 5 → ℕ) (hpos : ∀ i, 0 < v i) :
    ∃ t : ℝ, 0 < t ∧ ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ))

theorem lowerCountPositiveIntegerHypothesis_seven :
    LowerCountPositiveIntegerHypothesis 7

theorem sixRunners (speeds : Fin 6 → ℝ)
    (hinj : Function.Injective speeds) (runner : Fin 6) :
    ∃ t : ℝ, LonelyAt speeds runner t
```

The positive-natural Fin5 theorems permit repeated speed values. Primitivity is
a premise of the first declaration only; it is removed in the second. The final
canonical theorem has only the canonical injectivity premise on six real
speeds. It imposes no sign, integrality, rational-ratio or gcd condition on them.
Its time may depend on the selected runner, as required by the conjecture.

## 2. Parity dependency boundary

The already implemented one-even adapter has exactly:

```lean
theorem one_three_divisible_one_even_witness
    (v : Fin 5 → ℕ) (hpos : ∀ i, 0 < v i) (p : Fin 5)
    (hsix : 6 ∣ v p) (hone : ∀ i, 3 ∣ v i ↔ i = p)
    (heven : ((Finset.univ : Finset (Fin 5)).filter
      (fun i => 2 ∣ v i)).card = 1) :
    ∃ t : ℝ, 0 < t ∧ ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ))
```

The two **planned, not yet implemented** adapters have exactly:

```lean
theorem one_three_divisible_two_even_witness
    (v : Fin 5 → ℕ) (hpos : ∀ i, 0 < v i) (p : Fin 5)
    (hone : ∀ i, 3 ∣ v i ↔ i = p)
    (heven : ((Finset.univ : Finset (Fin 5)).filter
      (fun i => 2 ∣ v i)).card = 2) :
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

The root's common informal description includes `hsix` for all three cases.
That is a sufficient local context, but the planned two/three count adapters
deliberately have no `hsix` argument: each obtains it internally from
`divisor_cover_of_no_small_witness` under all-real nonexistence. Preserve this
existing distinction when calling them. No hypothesis needs weakening or adding.

The two-even plan uses a positive fixed-role family with pivot at 0, even label
1, and odd labels 2,3,4. Its count adapter enumerates labels using erased
finsets. The three-even plan similarly uses pivot 0, even labels 1,2 and odd
labels 3,4. Each has a common positive witness and allows repeats. Their
pointwise proofs precede their count adapters; neither adapter invokes the
future primitive Fin5 theorem. Thus using them below creates no dependency
cycle. Their complete implementations, focused checks and independent source
acceptance must precede compilation of the final dispatcher.

## 3. Primitive Fin5 dispatcher

Work classically, and first prove the local all-real statement
`hall : ∃ t : ℝ, ∀ i, 1/6 ≤ circleNorm (t * (v i : ℝ))`
by contradiction. The local `hno` must be its negation, not merely absence of
a positive-time witness: the divisor-count API takes this exact all-real form.

For natural `ell` let
`S ell = (Finset.univ : Finset (Fin 5)).filter (fun i => ell ∣ v i)`.
The inspected source provides

```lean
six_total_divisor_count_bounds v hpos hprimitive hno ell hell hell6
```

with `hell : 2 ≤ ell`, `hell6 : ell ≤ 6`, and conclusion
`1 ≤ (S ell).card ∧ (S ell).card ≤ 3`.
Instantiate at 3, 6 and 2 as needed; each numerical side condition is a fixed
arithmetic proposition in the future Lean proof.

1. Split on `2 ≤ (S 3).card`. In that case call the actual public theorem
   `fiveMovingNaturalRunners_of_primitive_at_least_two_divisible_three`
   with `v hpos hprimitive` and that bound. It returns
   `⟨t, htpos, ht⟩`; `hno ⟨t, ht⟩` is the contradiction. Its source
   combines the exact-two and primitive-at-least-three branches, so no
   unqualified nonprimitive all-five-divisible theorem is being invoked.

2. Otherwise the lower count bound forces `(S 3).card = 1` by `omega`.
   The actual API `Finset.card_eq_one.mp` gives a label `p` and
   `hS3 : S 3 = {p}`. For every `i`, derive
   `hone i : 3 ∣ v i ↔ i = p` by converting divisibility to filter membership,
   rewriting `hS3` and simplifying singleton membership. A direct proof pattern
   is `have hi : i ∈ S 3 ↔ i = p := by rw [hS3]; simp`, followed by
   `simpa [S] using hi`. This is uniqueness of a **label**, not a statement
   that all speed values are distinct.

3. From the lower bound at 6, `Finset.one_le_card.mp` supplies
   `⟨q, hq⟩ : (S 6).Nonempty`; filter membership gives `hq6 : 6 ∣ v q`.
   Then `(hone q).mp (dvd_trans (by norm_num : 3 ∣ 6) hq6)` gives `q=p`.
   Rewrite that equality in `hq6` to obtain `hsix : 6 ∣ v p`. Thus the
   unique three-divisible label is even when hno holds. There is no uncovered
   branch in which that unique pivot is odd. Only the lower count bound is
   used in this step; the separate direct lower-cover API could also supply it.

4. The bounds at 2 force `(S 2).card = 1 ∨ (S 2).card = 2 ∨ (S 2).card = 3`
   by `omega`. Match the three cases and call, respectively,
   `one_three_divisible_one_even_witness v hpos p hsix hone`,
   `one_three_divisible_two_even_witness v hpos p hone`, or
   `one_three_divisible_three_even_witness v hpos p hone`, with the respective
   count equality. In every case discard only the returned time positivity and
   contradict hno with the same all-five bounds.

This closes `hall`. Obtain `⟨u, hu⟩` from it. To prove `u≠0`, use `hu 0`:
at `u=0`, `norm_num [circleNorm]` contradicts `1/6≤0`. Split
`lt_or_gt_of_ne hune`. If `u<0`, return `-u` and use
`(-u)*(v i:ℝ)=-(u*(v i:ℝ))` followed by `circleNorm_neg` at every label.
If `0<u`, return u unchanged. This is the checked OneEvenRunners conversion.
No further helper theorem is required, and the closed margin is unchanged.

## 4. Gcd removal for every positive labelled tuple

Use the exact initial/final normalization pattern already implemented in
`TwoDivisibleNormalization.lean`, omitting its intermediate exact-two count
preservation argument. Define `g := Finset.univ.gcd v` and `w i := v i / g`.

* `hgdvd i : g ∣ v i` is `Finset.gcd_dvd (Finset.mem_univ i)`.
* `hgpos : 0 < g` follows from `Nat.pos_of_ne_zero`,
  `Finset.gcd_ne_zero_iff`, and witness
  `⟨0, Finset.mem_univ _, (hpos 0).ne'⟩`.
* `hfactor i : v i = g * w i` is
  `(Nat.mul_div_cancel' (hgdvd i)).symm` after unfolding w.
* `hwpos i : 0 < w i` follows from
  `Nat.div_pos (Nat.le_of_dvd (hpos i) (hgdvd i)) hgpos`.
* `hwprimitive : Finset.univ.gcd w = 1` is exactly
  `Finset.gcd_div_eq_one (s := Finset.univ) (f := v) (i := 0)
    (Finset.mem_univ _) (hpos 0).ne'`, after unfolding g and w.

The actual inspected `gcd_div_eq_one` requires one member with nonzero value;
it does not require an injective tuple. Repeated values survive normalization
without a problem. A common gcd divisible by 3 or 6 is permitted: no parity or
three-divisibility count has to survive this reduction. The new primitive
theorem covers all primitive tuples and computes the needed counts afresh
inside its own contradiction.

Apply `fiveMovingNaturalRunners_of_primitive w hwpos hwprimitive` to obtain
`⟨t, htpos, ht⟩`. Return `t/(g:ℝ)`, positive because both numerator and
denominator are positive. Set `hgR : (g:ℝ)≠0` by casting `hgpos.ne'`.
For each i rewrite `hfactor i` and `Nat.cast_mul`, then use the exact identity

```lean
t / (g : ℝ) * ((g : ℝ) * (w i : ℝ)) = t * (w i : ℝ)
```

proved by `field_simp [hgR]`. The same rescaled time works for every label,
and its phase is exactly the old phase, so no limiting or strict-margin loss is
involved. This removes the only tuple gcd hypothesis. It does not recursively
invoke the theorem being proved on a smaller unnormalized tuple.

## 5. H7 is the supply through five moving speeds

The actual definition in `LowerCountSupply.lean` is

```lean
def LowerCountPositiveIntegerHypothesis (N : ℕ) : Prop :=
  ∀ d : ℕ, 1 ≤ d → d ≤ N - 2 →
    ∀ speeds : Fin d → ℕ,
      Function.Injective speeds → (∀ i, 0 < speeds i) →
        ∃ time : ℝ, ∀ i,
          (((d + 1 : ℕ) : ℝ)⁻¹) ≤
            circleNorm (time * (speeds i : ℝ))
```

Thus H6 covers `1≤d≤4`; H7 covers `1≤d≤5`. The additional case needs the
new **five-moving** natural theorem at exactly `1/6`. The implementation is
the following unexecuted proof recipe, matching the existing H6 proof pattern:

```lean
by
  intro d hd hdmax speeds hinj hpos
  by_cases hsmall : d ≤ 4
  · exact lowerCountPositiveIntegerHypothesis_six
      d hd (by omega) speeds hinj hpos
  · have hd5 : d = 5 := by omega
    subst d
    obtain ⟨t, _htpos, ht⟩ := fiveMovingNaturalRunners speeds hpos
    exact ⟨t, by simpa [one_div] using ht⟩
```

The lower cases keep their own margin `1/(d+1)` through the existing H6 theorem;
one must not replace those margins by `1/6`. The `hinj` assumption is required
by the existing H-definition and passed to H6. It is deliberately unused for
d=5 because the new theorem is stronger and allows repeats. Neither d=0 nor
any d≥6 is a case of this hypothesis.

## 6. Canonical six-runner bridge and exact quantifiers

The actual checked interface is

```lean
theorem lonelyAt_of_lowerCount {m : ℕ} (hm : 1 ≤ m)
    (hLower : LowerCountPositiveIntegerHypothesis (m + 2))
    (speeds : Fin (m + 1) → ℝ) (hinj : Function.Injective speeds)
    (runner : Fin (m + 1)) : ∃ t : ℝ, LonelyAt speeds runner t
```

Consequently the complete proposed body of `sixRunners` is

```lean
  lonelyAt_of_lowerCount (m := 5) (by omega)
    lowerCountPositiveIntegerHypothesis_seven speeds hinj runner
```

This matches the existing `fiveRunners` body with m=4 and H6. All numeral
identifications are correct: m+1=6 original runners, m=5 relative moving
coordinates, and m+2=7 in the bounded-hypothesis index.

The source bridge forms
`relative i = speeds (runner.succAbove i) - speeds runner` for `i:Fin 5`.
`relative_succAbove_ne_zero hinj runner` establishes the required nonzero
relative speeds. `stationaryWitness_of_lowerCount` takes coordinatewise
absolute values, so negative relative speeds and repeated magnitudes are
allowed. Its `positiveRealWitness_of_lowerCount` handles arbitrary real ratios:
the rational-ratio branch groups distinct absolute rational magnitudes and
uses H7 through five; the irrational branch uses a collision and the smaller
H6 supply inherited from H7, obtaining the strict extra margin needed for its
transfer. There is no universal-N hypothesis hidden in this bounded interface.

Finally `lonelyAt_iff_relativeLonelyAt` and `Fin.exists_succAbove_eq` transfer
the one common relative witness to every other original label. The canonical
definition expands here to

```lean
∀ other : Fin 6, other ≠ runner →
  (6 : ℝ)⁻¹ ≤ dist (position (speeds runner) t)
                     (position (speeds other) t)
```

The distance is the ordinary quotient-circle distance with closed equality,
and time ranges over all reals. Canonical speeds may include zero or negative
values, and no selected runner is privileged. The quantifier order is
`∀ speeds, Injective speeds → ∀ runner, ∃ t, LonelyAt ...`; it does not assert
one time when every runner is lonely simultaneously. Only n=6 is established
by this proposed declaration, whereas `Conjecture` quantifies over all n≥2.

## 7. Implementation order and evidence boundary

No new generic API is needed for the final assembly. A cohesive
`SixRunnerOrdinary.lean` can import `SixTotalDivisorCounts`,
`TwoDivisibleNormalization`, `OneEvenRunners`, the future accepted
`TwoEvenRunners` and `ThreeEvenRunners`, and `FiveRunnerOrdinary`, then define
the primitive theorem, its gcd-normalized theorem and H7 in that order.
`SixRunnerCanonical.lean` then imports that module and `BoundedRealReduction`
and defines `sixRunners`. Exact file names are an implementation choice; the
four public types above are the semantic contract. No public lemma about
singleton filters or a generic gcd normalization API is needed for this pass.

The dependency order is acyclic: existing lower-count/divisor and at-least-two
results plus the three parity adapters supply primitive Fin5; normalization
supplies all positive natural Fin5; that supplies H7; the existing bounded
real bridge supplies canonical Fin6. The current task provides no focused or
full-build evidence for these new declarations. Root must wait for both parity
dependencies to compile and be accepted, then perform the assigned focused
implementation checks, final integration build, source/axiom trust audit and
independent exact-scope source review before declaring canonical N=6 complete.

The root plan's mathematical assembly has no unresolved quantifier or endpoint
gap. Its remaining dependencies are explicit implementation obligations.
Canonical N=6 is a transition milestone only; afterward research switches to
a uniform arbitrary-N mechanism. The unrestricted conjecture remains unresolved.

## 8. Frozen static bindings

Paths are relative to `/home/joshua/lonely-runner-formalization`.
The seven source hashes in the root plan were independently checked and all
matched. The additional bindings identify the parity contracts, canonical
definitions and finite-set APIs used in this review. Future mutable parity
source files and root integration/audit files are deliberately not bound.

| Path | SHA-256 |
| --- | --- |
| `research/astra-six-runner-final-assembly-plan.md` | `e2fd7e78c03e6baf227e2061fde87713c520518ffedd0da5caa7e61a6d0d387a` |
| `LonelyRunner/SixTotalDivisorCounts.lean` | `0b62ef724eb8c24db4085e247e9f16f650ec450291c7ccac2b0ad0981f148727` |
| `LonelyRunner/TwoDivisibleNormalization.lean` | `d812237f06d63e67c8739122c76a5e67daa470402575ccafcdcee4c41d950286` |
| `LonelyRunner/OneEvenRunners.lean` | `5bf5f01d7b31b410b680d646a832b273890cc267dc7a4775fea37eac5c58b810` |
| `LonelyRunner/FiveRunnerOrdinary.lean` | `662d0116f13971bce85e76c503e2f3be4fdc6291ba8113aeda43957e38354ffe` |
| `LonelyRunner/LowerCountSupply.lean` | `0705291adc53011fb72fc718a7260876512b092741442d6a6cceb4b76eb5ccf4` |
| `LonelyRunner/BoundedRealReduction.lean` | `7eae68d2c46041b39c3e18f9a1e105c75680352f8e4b4edf65e0dd2a92becb72` |
| `LonelyRunner/FiveRunnerCanonical.lean` | `a78cdaafcc359110535422d1967676610587a69be8f2bf8810e0ba65be1c8946` |
| `research/astra-two-even-assembly-plan.md` | `3b1cf3018ebb78b01a2d43eaf8d534d80ee313db4e55a37b863a147c07bc0073` |
| `research/astra-three-even-assembly-plan.md` | `66a9bac477d1e985d23f6188197ca7af6f0d90ad29df38ab8e710ed417cf510a` |
| `research/astra-one-three-divisible-plan.md` | `9da230600af3a0a0bc8223de3daca2575f8d41f447142687ca64db53ced4ae9e` |
| `research/astra-one-three-divisible-review.md` | `8f720fbd8002918adaaa0d36fc7774c450eeb5dba84dd555552d24b5e57e6078` |
| `LonelyRunner/Definitions.lean` | `5f0258a6ab99950fc7045b2200d6708fe7603d3caa4d62855ef2b19a330c95aa` |
| `LonelyRunner/StationaryEquivalence.lean` | `12dce8930c34b211bc01e2dc21e932087270726bce2bf127fa2d8d6594544b49` |
| `.lake/packages/mathlib/Mathlib/Algebra/GCDMonoid/Finset.lean` | `e0e320bd1f4a5a9e79da9fde6e2e3691ebbbccea8a4fba5765bda3b56e715568` |
| `.lake/packages/mathlib/Mathlib/Data/Finset/Card.lean` | `87c674ba5464c7868fb3e253e58a695821bf8841bb4e076bac5d570236dc6229` |
| `lean-toolchain` | `8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af` |
| `lake-manifest.json` | `887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218` |
