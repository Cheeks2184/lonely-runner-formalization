# Independent source review: signed remaining phases

**Accept the three exact public declarations in the frozen source.** I authored
neither the unsigned nor signed implementation. This review found no changed
hypothesis, lost endpoint, sign error, or weakened common-witness quantifier.

Reviewed bindings (SHA-256):

| File | Hash |
| --- | --- |
| `LonelyRunner/SignedRemainingPhase.lean` | `f75e742e3b0109fc9b1e23818dcc4873e1d824395171adbc4188da862050597c` |
| `LonelyRunner/RemainingPhaseLemma.lean` | `4523603cd6f8f88546f09017b8cee3159c65683237af81dd61fb66fd452cb4db` |
| `research/astra-signed-remaining-phase-implementation.json` | `b226bcaf42e215381b8e15df1ddda431ac8544d840e8f78ef604da44f30962c5` |
| `research/astra-one-three-divisible-review.md` | `8f720fbd8002918adaaa0d36fc7774c450eeb5dba84dd555552d24b5e57e6078` |

The unsigned declarations match the original manuscript contracts reviewed in
the last binding. Their public mathematical provenance is Renault's Lemmas 6.1
and 6.4, as preserved in the manuscript and its independent review:
[View-obstruction: a shorter proof for 6 lonely runners](https://compmath.wordpress.com/wp-content/uploads/2008/08/view-obstruction_a_shorter_proof_for_6_lonely-runners.pdf).
No new paper retrieval or mathematical search was performed for this review.

## Exact semantic checks

Write `N = circleNorm` and `w j = if j = 0 then 2 else 1`. All three
declarations quantify arbitrary real `x : Fin 3 → ℝ` and independently chosen
integer signs `e : Fin 3 → ℤ`, with `∀ j, e j = 1 ∨ e j = -1`.

* `renault_phase_six_one_signed` gives one common `a,b` with
  `2 ≤ a ≤ 5`, `1 ≤ b ≤ 5` and closed safety of
  `a*x j + e j*w j*b/6`, or one common `b` with `1 ≤ b ≤ 4` and strict
  safety of `x j + e j*w j*b/6`. There is no initial safety hypothesis.
  The factor two occurs only in the shift at coordinate zero; the phase is
  never replaced by `2*x 0`.
* `renault_phase_six_one_signed_reflected` has the same closed alternative,
  and precisely `2 ≤ b ≤ 5` in the strict alternative. It applies the first
  theorem with all signs negated, then uses the single shared replacement
  `b ↦ 6-b`. The proof establishes `b ≤ 6` before natural subtraction.
* `renault_phase_six_four_signed` requires initial **closed** safety
  `∀ j, 1/6 ≤ N(x j)`. Its alternatives are strict safety of `2*x j`;
  strict safety of `x j + e j*b/6` for one common `b=1 ∨ b=5`; or closed
  safety of `a*x j + e j*b/6` for common `a=3 ∨ a=5`, `b≤5`.
  The doubling alternative is unsigned, and the final natural shift still
  allows `b=0`.

The signed transport applies each unsigned theorem to `e j*x j`. Pointwise,
`N(a*(e*x)+w*b/6) = N(a*x+e*w*b/6)` because `e=1` gives equality and
`e=-1` makes the two arguments negatives. This operation acts separately on
the three coordinates after the unsigned theorem has selected its common
witness. It therefore never introduces coordinate-dependent slopes or shifts.
The same reflection identity transfers initial safety for 6.4 and removes
the sign from its doubled phase.

The private reflected-shift identity uses the exact integer translation
`-(e*w)`:

`y + (-e)*w*b/6 = -(e*w) + (y + e*w*(6-b)/6)`.

It holds for arbitrary integer `e,w`; the final casts and reassociation do
not require an additional sign hypothesis. Applying `circleNorm_add_int`
proves norm equality before either `<` or `≤` is transported. Thus strict
boundaries remain strict and closed boundaries remain closed. The failed
intermediate reflection edits in the receipt were tactic-shape errors; the
final source explicitly rewrites by an equality and then uses the original
inequality, with the same public theorem statements.

## Evidence accepted and scope

The frozen receipt records two failed focused checks followed by exit 0 on
the third source snapshot, with empty final stdout/stderr. I read the full
final signed and unsigned sources, the diagnostic outputs, and all three
reported axiom lines. A static Python check verified every embedded source
snapshot and check stream against its stated size/hash, and verified the
final embedded snapshot equals the current signed source. Root separately
matched all physical snapshots/streams and final `.olean`/`.ilean` artifacts;
that root inspection is reported coordination evidence, not a check rerun by
this reviewer.

The separate recorded import/axiom probe exits 0 and reports exactly
`[propext, Classical.choice, Quot.sound]` for all three public declarations.
No duplicate Lean invocation, import probe, numerical experiment, solver,
cache mutation, shared-state edit, or Git operation was performed here.
The workflow validator exited 0 and explicitly certified structural
consistency only.

Acceptance is for these exact signed phase adapters. It is not acceptance of
an unwritten two-even runner assembly, a canonical six-runner bridge, or the
unrestricted conjecture. No unresolved concern requires a repeated check of
this frozen source.
