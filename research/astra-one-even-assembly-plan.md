# One-even branch: Lean-ready assembly

This plan specializes the accepted one-three-divisible manuscript to its
one-even branch, using the now-compiled signed 5.1 and complement-maximizer
interfaces. No new mathematical assumption is needed. All declarations below
that are described as proposed remain unimplemented by this task; no Lean or
numerical execution occurred. Only this report was edited.

## 1. Cohesive target and scope

Implement one module, provisionally `LonelyRunner/OneEvenRunners.lean`, using
`SignedRenaultFiveOne`, `OneSixthComplementMaximizer`, `SixthAffinePhase`, and
the finite-label APIs below. Keep helper declarations private unless another
current task actually needs them.

The useful pointwise endpoint is:

```lean
theorem fiveMovingNaturalRunners_of_one_even_residues
    (v : Fin 5 → ℕ) (hpos : ∀ i, 0 < v i) (p : Fin 5)
    (hsix : 6 ∣ v p)
    (hodd : ∀ i, i ≠ p → ¬ 2 ∣ v i)
    (hthree : ∀ i, i ≠ p → ¬ 3 ∣ v i) :
    ∃ t : ℝ, 0 < t ∧ ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ))
```

Use an internal contradiction proof with exactly the same data and

```lean
hno : ¬ ∃ t : ℝ, ∀ i,
  (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ))
```

Its conclusion is `False`. Do not supply only absence of positive-time
witnesses to the maximizer API. First obtain an all-real witness by this
contradiction argument; then perform the positive-time conversion in section 7.
There is no primitive/gcd premise or injectivity premise on speed values.
Repeated positive speeds are permitted. Positivity of every speed is essential
to the existing maximum and forward-improvement arguments.

A thin adapter matches the original normalized parity case:

```lean
theorem one_three_divisible_one_even_witness
    (v : Fin 5 → ℕ) (hpos : ∀ i, 0 < v i) (p : Fin 5)
    (hsix : 6 ∣ v p) (hone : ∀ i, 3 ∣ v i ↔ i = p)
    (heven : ((Finset.univ : Finset (Fin 5)).filter
      (fun i => 2 ∣ v i)).card = 1) :
    ∃ t : ℝ, 0 < t ∧ ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ))
```

For this adapter, `2∣v p` follows from `2∣6` and `hsix`. The filter contains
`p`; its cardinality one excludes every `i≠p`, by
`Finset.card_le_one : s.card≤1 ↔ ∀a∈s,∀b∈s,a=b`.
The other nondivisibility follows directly from `hone`. No divisor-count
theorem or primitive normalization is needed inside either declaration.

## 2. Actual compiled dependencies

All names are in `LonelyRunner` unless explicitly qualified otherwise.

`exists_one_sixth_complement_maximizer v hpos p hno` returns

`τ, 0<τ, τ<1, hsafe, hmax, hmpos, hmlt, hmnorm, r, hrp, hrface`, where

* `hsafe : ComplementSafe v p (1/6) τ`;
* `hmax : ∀ t : ℝ, ComplementSafe v p (1/6) t →
  N(t*v p) ≤ N(τ*v p)`;
* `hmpos : 0 < fract(τ*v p)` and `hmlt : fract(τ*v p)<1/6`;
* `hmnorm : fract(τ*v p)=N(τ*v p)`;
* `hrp : r≠p`, `hrface : fract(τ*v r)=5/6`.

Here `N` abbreviates `circleNorm` only in prose. The checked helper supplies
the strict complement seed from the four-moving `1/5` theorem, so do not
rebuild its compactness, positivity, or upper-face proof.

`renault_phase_five_one_signed (x : Fin 3 → ℝ) (e : Fin 3 → ℤ)
(he : ∀j,e j=1 ∨ e j=-1)` returns either

* `∃a b:ℕ, 2≤a ∧ a≤5 ∧ 1≤b ∧ b≤5 ∧
  ∀j, 1/6≤N((a:ℝ)*x j+(e j:ℝ)*(b:ℝ)/6)`, or
* `∃b:ℕ, (b=1 ∨ b=2 ∨ b=4) ∧
  ∀j, 1/6<N(x j+(e j:ℝ)*(b:ℝ)/6)`.

`renault_phase_five_one_signed_reflected` has the same closed alternative
and strict set `(b=2 ∨ b=4 ∨ b=5)`. Both accept arbitrary real phases.

`fract_sixth_affine_time (t:ℝ) (d:ℕ) (α β z e:ℤ)
(hd:(d:ℤ)=6*z+e)` states

`fract(((α:ℝ)*t+(β:ℝ)/6)*(d:ℝ))
 = fract((α:ℝ)*fract(t*(d:ℝ))+((β*e:ℤ):ℝ)/6)`.

`reciprocal_dilate_shift_improves` takes natural `N,d,α`, **integer** `β`,
real `t`, `3≤N`, `N∣d`, `2≤α`, `α<N`, and
`0<fract(t*d)<(N:ℝ)⁻¹`. It concludes
`circleNorm(t*d)<circleNorm(((α:ℝ)*t+(β:ℝ)/(N:ℝ))*d)`.

`exists_forward_complement_improvement v p hpos δ s` requires
`0<δ<1/2`, `fract(s*v p)<1/2`, and, for every `i≠p`,
`δ≤fract(s*v i) ∧ fract(s*v i)<1-δ`. It returns `ε>0`, a complement-safe
`s+ε`, and `N(s*v p)<N((s+ε)*v p)`. It permits a lower-face equality and
arbitrary real `s`; it does not permit an upper-face equality.

## 3. Explicit label permutation and signed residues

From `hrp`, `Fin.exists_succAbove_eq hrp` supplies `q : Fin 4` and
`hq : p.succAbove q = r`. Define

```lean
let ρ : Fin 3 → Fin 5 := fun j => p.succAbove (q.succAbove j)
```

The exact finite APIs in `Mathlib/Data/Fin/SuccPred.lean` are:

```lean
Fin.succAbove_ne (p : Fin (n+1)) (i : Fin n) : p.succAbove i ≠ p
Fin.succAbove_right_injective : Function.Injective p.succAbove
Fin.exists_succAbove_eq {x y : Fin (n+1)} (h : x ≠ y) :
  ∃ z, y.succAbove z = x
```

Consequently `ρ` is injective, every `ρ j≠p`, and every `ρ j≠r`: for the
last fact rewrite `r` using `hq`, cancel `p.succAbove`, and use
`q.succAbove_ne`. For each `i≠p,r`, first write `i=p.succAbove j`;
then `j≠q`, and a second `exists_succAbove_eq` writes `j=q.succAbove k`.
Thus `∃k,ρ k=i`. These are sufficient operational facts for assembly.

Explicitly, the resulting permutation of the five labels is

`π = Fin.cases p (Fin.cases r ρ) : Fin 5 → Fin 5`.

It sends zero to `p`, one to `r`, and `j.succ.succ` to `ρ j`. The disjoint
images and injectivity just proved give injectivity of `π`; the exhaustion
argument gives surjectivity. There is no need to construct an `Equiv.Perm`
or conjugate the whole speed tuple in Lean: use the original `v` and `ρ`.

The only new residue helper needed is:

```lean
private theorem exists_unit_sixth_residue (d : ℕ)
    (hodd : ¬ 2 ∣ d) (hthree : ¬ 3 ∣ d) :
    ∃ z e : ℤ, (d : ℤ) = 6*z+e ∧ (e=1 ∨ e=-1)
```

Apply the existing `exists_centered_sixth_residue_of_not_dvd_three`. Its four
residues are `1,-1,2,-2`. For residue `2`, the integer witness `3*z+1` proves
`(2:ℤ)∣(d:ℤ)`; for `-2`, use `3*z-1`. Cast integer divisibility back to the
natural divisibility to contradict `hodd`. This exact cast pattern already
appears in `PairSafeSixthAffine`; no assumption on the sign of `z` is needed.

Apply this helper to `v r`, obtaining `zr,σ,hdr,hσ`, where `hσ:σ=1∨σ=-1`.
Apply it to `v(ρ j)` for every `j`, choosing functions `z,e : Fin 3 → ℤ`
with `hd j : (v(ρ j):ℤ)=6*z j+e j` and `he j : e j=1∨e j=-1`.
The exclusions from the label map supply both hypotheses. Choices are over
labels, never over distinct speed values.

## 4. Tiny phase helpers and the common candidate

Use `circleNorm_eq_min_fract` to turn a fractional-part equality into a norm
equality: rewrite both norms as `min (fract x) (1-fract x)`. This gives a
private norm version of `fract_sixth_affine_time` with identical inputs and
right-hand norm instead of fractional part; no extra hypotheses are needed.

Also retain the private integer-shift preservation fact

```lean
private theorem fract_add_sixth_of_dvd (d : ℕ) (hd : 6 ∣ d)
    (t : ℝ) (b : ℤ) :
    Int.fract ((t + (b : ℝ)/6) * (d : ℝ)) =
      Int.fract (t * (d : ℝ))
```

For its proof write `d=6*u` with `u:ℕ`, apply the existing fractional affine
identity with `α=1`, `β=b`, `z=(u:ℤ)`, `e=0`, then simplify
`Int.fract_fract`. This is preservation of actual oriented phase for every
integer `b`, including negative values; norm preservation follows too.

Set `m=fract(τ*v p)` and

`t' = τ + (σ:ℝ)/6`, `x j = fract(t'*(v(ρ j):ℝ))`.

The preservation helper gives `fract(t'*v p)=m`. At the face label use
`fract_sixth_affine_time τ (v r) 1 σ zr σ hdr` and `hrface`.
Since `σ²=1`, its right side is `fract(5/6+1/6)=0`, hence
`fract(t'*v r)=0`. The sign square occurs in **integer multiplication** before
casting; splitting `hσ` or proving `σ*σ=1` resolves it exactly.

Choose 5.1 according to the anchor orientation: the signed theorem if `σ=1`,
the signed-reflected theorem if `σ=-1`. Package these into one disjunction so
the substantial branches below are not duplicated. Its closed branch is the
same in either orientation. Its strict branch retains the exact condition

`(σ=1 ∧ (b=1∨b=2∨b=4)) ∨ (σ=-1 ∧ (b=2∨b=4∨b=5))`,

along with the three strict inequalities. This packaging only records which
already-proved theorem was called.

For every returned natural `a,b`, define `s=(a:ℝ)*t'+(b:ℝ)/6`.
The affine identity at base `t'` and residue `hd j` gives

`N(s*v(ρ j)) = N((a:ℝ)*x j+(e j:ℝ)*(b:ℝ)/6)`.              (T)

Normalize `((b:ℤ)*e j:ℤ)` casts and commute the real product explicitly.
The same identity at label `r`, whose base phase is zero, gives

`fract(s*v r)=fract((σ:ℝ)*(b:ℝ)/6)`.                        (F)

These identities use the **same** `a,b,s` for all labels. They do not require
`t'` or `s` to be positive.

## 5. Closed slope branch

Here `2≤a≤5`, `1≤b≤5`, and all three right sides of (T) are closed-safe.
Equation (F) makes the face label closed-safe too: its norm is `N(b/6)` by
sign reflection, and `1/6≤b/6≤5/6`. Use `circleNorm_ge_of_int_band` at integer
band zero, or `circleNorm_eq_min_fract` and `Int.fract_eq_self`.

For arbitrary `i≠p`, split `i=r`; otherwise write `i=ρ j`. This proves
`ComplementSafe v p (1/6) s`.

Define the actual integer numerator

```lean
let B : ℤ := (a : ℤ) * σ + (b : ℤ)
```

After expanding `s,t',B`, `push_cast` and `ring` give
`s=(a:ℝ)*τ+(B:ℝ)/6`. Keep `B` integer: it can be negative when `σ=-1`.
Now invoke

`reciprocal_dilate_shift_improves 6 (v p) a B τ`.

Its premises are `3≤6`, `hsix`, `2≤a`, `a<6`, `hmpos`, and `hmlt`
rewritten from `1/6` to `(6:ℝ)⁻¹`. The result is
`N(τ*v p)<N(s*v p)`, contradicting `hmax s` applied to the safe complement.
The pivot itself is not being assumed safe at `s`; only strict objective
improvement is needed.

## 6. Strict slope-one branch and forward time

Set `s=t'+(b:ℝ)/6`. Formula (T) with `a=1` makes all three remaining labels
strictly safe. The face's actual phase from (F) is:

| Anchor sign | Permitted `b` | Actual face phases, in that order |
| --- | --- | --- |
| `σ=1` | `1,2,4` | `1/6,1/3,2/3` |
| `σ=-1` | `2,4,5` | `2/3,1/3,1/6` |

For a non-enumerative scalar proof, the positive case has `1≤b≤4` and phase
`b/6`. The negative case has `2≤b≤5` and phase `(6-b)/6`, since
`-b/6=(-1:ℤ)+(6-b)/6`. Use `Nat.cast_sub` with the established `b≤6`,
`Int.fract_intCast_add`, and `Int.fract_eq_self`. Both actual phases lie in
`[1/6,2/3]`, hence below `5/6`. The displayed exact shift sets themselves
remain those returned by signed/reflected 5.1.

For a remaining label, strict norm means
`1/6 < min(fract(s*v i), 1-fract(s*v i))`.
`lt_min_iff` supplies both inequalities, yielding its actual phase in
`(1/6,5/6)`. Combine with the face case and label exhaustion to get

`∀i≠p, 1/6≤fract(s*v i) ∧ fract(s*v i)<5/6`.

The integer numerator for this time is `B₁=σ+(b:ℤ)`, with
`s=τ+(B₁:ℝ)/6`. Preservation gives `fract(s*v p)=m`, hence it is below `1/2`,
and also `N(s*v p)=N(τ*v p)`. Apply

`exists_forward_complement_improvement v p hpos (1/6) s`

with these precise actual-phase bounds. It returns `ε>0`, a safe complement
at `s+ε`, and `N(s*v p)<N((s+ε)*v p)`. Replacing the left norm by the value
at `τ` contradicts `hmax (s+ε)`. The anchor may be at the lower face `1/6`;
positive speeds then move it inward, which is why the forward theorem permits
that endpoint. An unreflected choice when `σ=-1` could put the anchor at the
upper face; the orientation selection above prevents that error.

## 7. Positive wrapper and implementation delivery

The two branches prove the internal `False` under the all-real `hno`.
Classical contradiction therefore gives `u : ℝ` with all five closed bounds.
Taking its `p` component shows `u≠0`, since `circleNorm 0=0<1/6`.
If `u>0`, return it. If `u<0`, return `-u`; use
`(-u)*(v i:ℝ)=-(u*(v i:ℝ))` and `circleNorm_neg` for every label. This exact
positive-time pattern already occurs in `FiveMovingFast.lean`.

Terra High can implement the cohesive module in this order: label map facts
and private phase/residue helpers; unified orientation-dependent 5.1 choice;
one shared closed branch and one shared strict branch; positive wrapper and
cardinality adapter. The helper proofs are elementary consequences of the
inspected APIs, not additional mathematical obligations. Use the assigned
serial focused-compile slot and normal initial-check/two-repair protocol;
escalate a semantic mismatch rather than change a theorem's hypotheses.

This plan does not assert its proposed declarations are compiled. Source
review and checkpoint integration remain required. It contributes only to the
current N=6 milestone; the standing next research focus remains a uniform
arbitrary-N mechanism after that canonical milestone is verified.

## 8. Source-only evidence

Project configuration, current workflow/policy, and focused state were read.
State was research/in_progress, task `/root/one_even_branch_assembly_plan`,
checkpoint `a1d90c2`, requested Astra/xhigh. Actual validator command
`python3 scripts/validate_workflow.py` exited 0 with stdout:

```text
workflow structural validation passed; it cannot certify mathematical validity.
```

Static source inspection resolved the APIs above. Some exploratory filename
lookups returned file-not-found diagnostics; the actual files and hashes below
are the bindings used. There were no compiler, probe, experiment, state, Git,
or cache actions. `LR/` means repository `LonelyRunner/`; `ML/` means
`.lake/packages/mathlib/Mathlib/`. These are byte bindings, not fresh build
receipts.

| File | SHA-256 |
| --- | --- |
| `LR/SignedRenaultFiveOne.lean` | `6971e02483c2b1e6f3d717ed5d4784fd8decfbdba6f6bdc9d8aca0dff2f4f3fc` |
| `LR/OneSixthComplementMaximizer.lean` | `5a7011ca680b8a2b26c7bad466a8ee4008cf47507eb8b700846f296894bb90a1` |
| `LR/SixthAffinePhase.lean` | `76e420713079ec0c3979e9b169cd78ecb6a932d6dc790ea7d9711adbb64b7d4b` |
| `LR/ConstrainedMaximizer.lean` | `2ef07e6b83b8675a22184571c31d2a71dab9d5c072e3cd165cb8382957b46e92` |
| `LR/FastRunnerInsertion.lean` | `dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5` |
| `LR/StructuredClasses.lean` | `5328a7a88d2b42f86ffc3f0f0418ca22c761219e8fa3e5822bda5a18ac286e8c` |
| `LR/FiveMovingFast.lean` | `cc203315c6d36be23b7cdcfc9706785fb05e6d5406c84714a9fea42bdfce7212` |
| `ML/Data/Fin/SuccPred.lean` | `b4abd81eb56af7f8178d592af2eabca0604ade556b85a09981ff301a44783dce` |
| `ML/Data/Finset/Card.lean` | `87c674ba5464c7868fb3e253e58a695821bf8841bb4e076bac5d570236dc6229` |
| `ML/Algebra/Order/Floor/Ring.lean` | `11f61aaf83c406b6b0accc6d34bdb4f77a1566fbdc63eae4d704728b9acf038c` |
| `research/astra-one-three-divisible-plan.md` | `9da230600af3a0a0bc8223de3daca2575f8d41f447142687ca64db53ced4ae9e` |
| `research/astra-one-three-divisible-review.md` | `8f720fbd8002918adaaa0d36fc7774c450eeb5dba84dd555552d24b5e57e6078` |
