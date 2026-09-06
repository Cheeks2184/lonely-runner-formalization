# Zero-residual preservation and the sharper mixed-height reduction

2026-09-05. Requested Astra/xhigh source-contract audit by
`/root/mss_published_bound_audit`; observed runtime model/effort are not
independently exposed. Assigned source checkpoint:
`0b0a033e9655b5f9d2fa0b57ac0f61729b2db123`.
Only this note is owned. This is future work, separate from Pass 31 and the
strict-to-mixed investigation.

**Finding: the proposed stronger simultaneous conclusion is valid.** The
current construction preserves the complete free-phase margin at every zero
residual coordinate. Propagating that fact through the existing wrappers gives
a positive mixed witness above the sharper primitive height cutoff, under the
same bounded lower-count ordinary hypothesis. This strengthening is not yet
declared or checked in Lean; this pass supplies a source-based derivation and
implementation contract only.

## Exact reason the fastest margin survives

`exists_affinePhaseTransfer` selects one integer
`j=round(p*y-x)` and one time `t=(j+x)/p`. For every coordinate, its existing
proof establishes

```text
(p*U_i+V_i)*t = integer(U_i*j) + (U_i*x+V_i*y) + V_i*(t-y).
```

If `V_i=0`, the target and base norms are equal. In particular, the target
retains `delta+epsilon`, rather than merely `delta`. This happens at the
same t that supplies the ordinary margins for all coordinates. Rounding ties
cause no problem: the vanished error is zero for any permitted rounding choice.
The present positive-time and shift proofs remain unchanged.

`exists_positiveAffine_witness` obtains base margins `1/(N-1)` at every
coordinate from `exists_bhk_twoPhase_margin`. Its period normalization preserves
all base norms. With `delta=1/N` and `epsilon=1/[N(N-1)]`, the existing
`hmarginEq` is precisely `delta+epsilon=1/(N-1)`. Thus a zero residual retains
the desired stronger margin. No new BHK or period-normalization theorem is
needed.

`exists_signedAffine_witness` replaces `(U_i,V_i)` by either itself or its
negative. Zero remains zero, and circle norm is invariant under negation, so
the stronger conclusion transfers back at the same common time. The BHK
collision vector is explicitly nowhere zero; the lower-count argument merges
equal absolute magnitudes but retains the witness inequality for every original
coordinate. There is no zero-collision branch that discards the endpoint.

`rational_affine_lonelyAt` uses relative residuals `V_i=v_i-v_r` after deleting
the chosen runner. Hence its stronger conclusion applies when **other != r
and v_other=v_r**. It must not include the chosen runner itself: its relative
speed is zero and cannot meet a positive distance threshold.

Finally, in the sharper stationary height proof, `v_0=v_H=0` and `r=0`.
The fastest relative residual is therefore zero. The approximation still has
`Q=choose(N,2)`, `1<=q<=Q^(N-2)<H`, `p=H/q>1`, primitive rank two, integral
common periods, and the unchanged error bound `|v_i|<=p/Q`.
The zero residual at H does not contradict rank two: rank needs some nonzero
minor, not a nonzero residual at every coordinate. Stationary label zero is
excluded from the moving relative row; fastest label H is retained.

## Proposed exact strengthened contracts

Names below are proposals. Except for the displayed return types, retain every
argument and hypothesis of the corresponding existing declaration, in its
present order. These contract fragments have not been elaborated in Lean.

For `exists_affinePhaseTransfer_with_zeroResidual`, retain its full existing
generic inputs and return:

```lean
∃ t : ℝ, 0 < t ∧ |t - y| ≤ (1 : ℝ) / (2 * p) ∧
  (∀ i, δ ≤ circleNorm ((p * (U i : ℝ) + V i) * t)) ∧
  (∀ i, V i = 0 →
    δ + ε ≤ circleNorm ((p * (U i : ℝ) + V i) * t))
```

For both `exists_positiveAffine_witness_with_zeroResidual` and
`exists_signedAffine_witness_with_zeroResidual`, retain their respective full
existing inputs, including `hLower`, and return:

```lean
∃ t : ℝ, 0 < t ∧
  (∀ i, (N : ℝ)⁻¹ ≤ circleNorm
    (t * ((p : ℝ) * (U i : ℝ) + (V i : ℝ)))) ∧
  (∀ i, V i = 0 → (((N - 1 : ℕ) : ℝ)⁻¹) ≤ circleNorm
    (t * ((p : ℝ) * (U i : ℝ) + (V i : ℝ))))
```

For `rational_affine_lonelyAt_with_equalResidual`, retain all existing inputs
and the arbitrary chosen label r, and return the following proposition:

```lean
let speeds : Fin (m + 2) → ℝ :=
  fun i => ((p * (u i : ℚ) + v i : ℚ) : ℝ)
∃ t : ℝ, 0 < t ∧ LonelyAt speeds r t ∧
  ∀ other : Fin (m + 2), other ≠ r → v other = v r →
    (((m + 1 : ℕ) : ℝ)⁻¹) ≤
      circleNorm (t * (speeds other - speeds r))
```

The intended height declaration can have this full signature:

```lean
theorem primitive_sorted_largeHeight_stationary_mixed {m : ℕ} (hm : 1 ≤ m)
    (hLower : LowerCountPositiveIntegerHypothesis (m + 2))
    (s : Fin (m + 2) → ℕ)
    (hsorted : StrictMono s) (hs0 : s 0 = 0)
    (hprimitive : Finset.univ.gcd s = 1)
    (hheight : (Nat.choose (m + 2) 2) ^ m < s (Fin.last (m + 1))) :
    ∃ t : ℝ, 0 < t ∧
      LonelyAt (fun i => (s i : ℝ)) 0 t ∧
      (((m + 1 : ℕ) : ℝ)⁻¹) ≤
        circleNorm (t * (s (Fin.last (m + 1)) : ℝ))
```

This keeps `N=m+2>=3`, the closed ordinary threshold `1/N`, and the closed
fastest threshold `1/(N-1)` at one positive real time. It does not promise a
rational time. In particular, do not extend mixed existence indiscriminately
to N=2, where the proposed fastest threshold would be one.

## Minimal compositional implementation plan

1. Move the existing transfer proof to the stronger declaration. Factor its
   per-coordinate norm rewrite so ordinary loss and zero-loss preservation
   reuse the same identity. Make the old declaration a projection wrapper.
2. Move each positive and signed affine proof to its stronger declaration,
   consume the preceding stronger output, and make the old public theorem a
   projection wrapper. In the positive proof use the already established
   `hmarginEq`; in the signed proof carry `V_i=0` through the sign case and
   use the same norm-negation identity for both bounds.
3. Strengthen the relative wrapper once. Use `Fin.exists_succAbove_eq` for the
   extra conclusion and reduce `v_other=v_r` to zero relative residual. The
   current cast and phase identities already transfer the same coordinate.
   Retain the old `rational_affine_lonelyAt` type as a projection wrapper.
4. Move the sharper stationary height proof to the mixed declaration. At its
   final call use `other=Fin.last (m+1)`, its inequality with zero, and
   `hvH`/`hv0`. Rewrite actual speeds using `hactual` and use `hs0` to remove
   the stationary phase. Keep the old stationary height theorem as a wrapper
   discarding only the final bound. Leave the old arbitrary-runner height API
   intact; the smaller cutoff is not an arbitrary-runner conclusion.
5. Add the conditional no-mixed height corollary below, permanent axiom probes,
   and narrowly scoped regression/type checks. Finish with a pinned source
   build, trust audit and an independent semantic review of the exact patch.

This requires no proof-body duplication, changes to BHK phase supply, or
changes to the existing ordinary finite-family equivalence. Compatibility
means preserving existing public theorem types, not keeping old proof bytes
unchanged. The new declarations carry the stronger result; old callers keep
their original contracts.

## Finite counterexample consequence and remaining obligation

For a sorted primitive stationary tuple at fixed `N>=3`, assuming the same
`LowerCountPositiveIntegerHypothesis N`, absence of any mixed witness implies

```text
H <= choose(N,2)^(N-2).
```

Proof: if `H>B`, the proposed strengthened height theorem constructs a positive
mixed witness, contradiction. Equality remains in the finite region. This
needs no separate ordinary witness premise. A primitive direct-or-mixed
counterexample is in particular not mixed, so it has the same bound.

At a first unresolved count, prior ordinary counts provide `hLower`. Prior
primitive direct-or-mixed supply also suffices to provide those ordinary
counts: normalize each positive tuple by gcd, obtain direct or mixed there,
then rescale the resulting ordinary witness. This does not preserve direct
divisibility under scaling, nor does it need to.

The primitive restriction is essential. Raw N=3 examples `(3a,6a)`, `a>=1`, have
unbounded height and no mixed witness despite the ordinary lower-count base.
The proposed result therefore does not repair the known raw-union failure.
It bounds the primitive velocity search under the stated lower-count supply;
checking all remaining bounded tuples, supplying a global primitive union,
and proving unrestricted LRC are still open obligations. No full published
gcd-subset theorem, new finite-family equivalence for mixed supply, or Lean
formalization of this stronger statement has been completed in this pass.

## Inspected source SHA-256

| File in `LonelyRunner/` | SHA-256 |
| --- | --- |
| `AffinePhaseTransfer.lean` | `069d7f05229f517639284a58d9bb10f6fd6ee8d949efc3d377361424e7381776` |
| `PositiveAffineWitness.lean` | `ed9e66d5a8944f3b5862be66f96c30abe7829c063e866504ca9e9ac1989e2e03` |
| `SignedAffineWitness.lean` | `19018618fdb454ddbdb199a29db8672bd4729bf68052736133c1d708cc26f3e5` |
| `AffineLonelyAt.lean` | `19ef8e3e8b5cc0364b74d13cfb93b608adf176ffdbb1a7e020e2d5f1b484ec7b` |
| `FiniteHeightReduction.lean` | `d6ebb1974372dd8356c76b57ce322a6a7ca076404c7049b968cad207469f3406` |
| `BHKTwoPhaseSupply.lean` | `2890e8ad41f9e3c2a0f098ba2a0da7060fa14ac2fe12842adf1c11905148ac09` |
| `AffinePhasePeriod.lean` | `340c4dd29276544566175cf791307ca42753ddc964345aa793d33abef1e9b176` |
| `RationalPairRank.lean` | `8ab0d557ad561415b2fdf06566482e780fca1aa5b37c2a9e2340c24805ca6cbe` |
| `EndpointAffineApproximation.lean` | `19989c0528c028bd0bcb8ef4e514ac35177fafd1a0f889e69b82f25651aaa3d3` |
| `PrimitiveAffineRank.lean` | `0b82838ac09e0572a329d7fe12091c250caa746441216e5a7ec84ceb7ff89eb9` |
| `LowerCountSupply.lean` | `0705291adc53011fb72fc718a7260876512b092741442d6a6cceb4b76eb5ccf4` |

Workflow/state and current routing were checked; the structural validator
passed. Verification here consists of source inspection and symbolic algebra,
not a Lean build or new numerical search. Only this note was written; no Lean
source or shared-state edit, Git operation, dependency change, or cache
operation was performed.
