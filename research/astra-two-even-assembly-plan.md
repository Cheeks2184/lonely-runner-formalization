# Two-even branch: exact assembly plan

**The reviewed argument closes with the compiled signed 6.1/6.4 interfaces.**
No new geometric lemma, arithmetic search, gcd hypothesis, or assumption about
distinct speed values is required. The remaining work is the cohesive Lean
implementation described below, followed by its focused compile and independent
source review. This document proves the mathematical assembly; it does not
claim the proposed declarations have been elaborated.

Use fixed label roles: `v 0` is the pivot, `v 1` the other even speed, and
`v 2,v 3,v 4` are odd. Label values may repeat. Literal maps for the three
possible odd upper faces keep the weight-two coordinate at index zero without
introducing general permutation infrastructure.

## 1. Public theorem contracts

All project names are in namespace `LonelyRunner`. These two declarations are
proposed for `LonelyRunner/TwoEvenRunners.lean`:

```lean
theorem fiveMovingNaturalRunners_of_two_even_residues
    (v : Fin 5 → ℕ) (hpos : ∀ i, 0 < v i)
    (hsix : 6 ∣ v 0) (heven1 : 2 ∣ v 1)
    (hodd2 : ¬ 2 ∣ v 2) (hodd3 : ¬ 2 ∣ v 3) (hodd4 : ¬ 2 ∣ v 4)
    (hother : ∀ i, i ≠ 0 → ¬ 3 ∣ v i) :
    ∃ t : ℝ, 0 < t ∧ ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ))

theorem one_three_divisible_two_even_witness
    (v : Fin 5 → ℕ) (hpos : ∀ i, 0 < v i) (p : Fin 5)
    (hone : ∀ i, 3 ∣ v i ↔ i = p)
    (heven : ((Finset.univ : Finset (Fin 5)).filter
      (fun i => 2 ∣ v i)).card = 2) :
    ∃ t : ℝ, 0 < t ∧ ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ))
```

The count adapter intentionally has no supplied `hsix`: the existing
small-denominator cover yields it under all-real nonexistence. Neither theorem
requires `Finset.univ.gcd v=1`, injectivity, a speed-ratio bound, or a supplied
common witness. Intermediate affine times need not be positive. Every public
margin is closed.

## 2. Frozen existing APIs and local transport contracts

Import `OneSixthComplementMaximizer`, `SignedRemainingPhase`,
`SixthAffinePhase`, and `SmallDenominatorWitness`. The first import supplies
`ConstrainedMaximizer`. `OneEvenRunners` is a checked proof-pattern reference;
its private helpers are not callable public APIs and need not be imported.

The exact current maximizer declaration is:

```lean
theorem exists_one_sixth_complement_maximizer
    (v : Fin 5 → ℕ) (hpos : ∀ i, 0 < v i) (p : Fin 5)
    (hno : ¬ ∃ t : ℝ, ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ))) :
    ∃ τ : ℝ, 0 < τ ∧ τ < 1 ∧ ComplementSafe v p ((1 : ℝ) / 6) τ ∧
      (∀ t : ℝ, ComplementSafe v p ((1 : ℝ) / 6) t →
        circleNorm (t * (v p : ℝ)) ≤ circleNorm (τ * (v p : ℝ))) ∧
      0 < Int.fract (τ * (v p : ℝ)) ∧
      Int.fract (τ * (v p : ℝ)) < (1 : ℝ) / 6 ∧
      Int.fract (τ * (v p : ℝ)) = circleNorm (τ * (v p : ℝ)) ∧
      ∃ r, r ≠ p ∧ Int.fract (τ * (v r : ℝ)) = (5 : ℝ) / 6
```

In particular, its `hmax` ranges over **all real times** with safe complement.
It returns an actual fractional upper face, not merely a label of norm 1/6.

The current phase theorem names and their complete choice sets are:

* `renault_phase_six_one_signed x e he`: arbitrary real `x : Fin 3 → ℝ`,
  independent integer signs `e` with `he : ∀ j, e j=1 ∨ e j=-1`. With
  `w j = if j=0 then 2 else 1`, it returns either shared natural
  `2≤a≤5`, `1≤b≤5` and `∀j, 1/6≤N(a*x j+e j*w j*b/6)`, or shared natural
  `1≤b≤4` and `∀j, 1/6<N(x j+e j*w j*b/6)`.
* `renault_phase_six_one_signed_reflected x e he`: identical closed choice,
  strict choice exactly `2≤b≤5`.
* `renault_phase_six_four_signed x e he hx`: `hx : ∀j,1/6≤N(x j)` is
  required. It returns strict `∀j,1/6<N(2*x j)`; or a shared `b=1 ∨ b=5`
  with strict `N(x j+e j*b/6)`; or shared `a=3 ∨ a=5`, `b≤5` with closed
  `N(a*x j+e j*b/6)`. Here every weight is one and `b=0` remains allowed.

The source review of these exact three declarations is frozen separately at
`research/astra-signed-remaining-phase-source-review.md`. Do not substitute
unsigned phases for signed residues or independently choose a time per label.

Existing transport:

```lean
theorem fract_sixth_affine_time (t : ℝ) (d : ℕ) (α β z e : ℤ)
    (hd : (d : ℤ) = 6 * z + e) :
    Int.fract (((α : ℝ) * t + (β : ℝ) / 6) * (d : ℝ)) =
      Int.fract ((α : ℝ) * Int.fract (t * (d : ℝ)) +
        ((β * e : ℤ) : ℝ) / 6)

theorem exists_centered_sixth_residue_of_not_dvd_three (d : ℕ)
    (hnot : ¬ 3 ∣ d) :
    ∃ z e : ℤ, (d : ℤ) = 6 * z + e ∧
      (e = 1 ∨ e = -1 ∨ e = 2 ∨ e = -2)
```

Implement these small local helpers directly from the checked interfaces:

```lean
private theorem two_even_residue (d : ℕ)
    (h2 : 2 ∣ d) (h3 : ¬ 3 ∣ d) :
    ∃ z σ : ℤ, (d : ℤ) = 6 * z + 2 * σ ∧ (σ = 1 ∨ σ = -1)

private theorem two_even_odd_residue (d : ℕ)
    (h2 : ¬ 2 ∣ d) (h3 : ¬ 3 ∣ d) :
    ∃ z σ : ℤ, (d : ℤ) = 6 * z + σ ∧ (σ = 1 ∨ σ = -1)

private theorem two_even_norm_affine (t : ℝ) (d : ℕ)
    (α β z e : ℤ) (hd : (d : ℤ) = 6 * z + e) :
    circleNorm (((α : ℝ) * t + (β : ℝ) / 6) * (d : ℝ)) =
      circleNorm ((α : ℝ) * Int.fract (t * (d : ℝ)) +
        ((β * e : ℤ) : ℝ) / 6)

private theorem two_even_fract_shift (d : ℕ) (hd : 6 ∣ d)
    (t : ℝ) (b : ℤ) :
    Int.fract ((t + (b : ℝ) / 6) * (d : ℝ)) =
      Int.fract (t * (d : ℝ))
```

For even residues, cast `2∣d` to integer divisibility and its witness rules
out the centered residues ±1 by `omega`. Residues ±2 give σ=±1. For odd
residues, ±2 would give integer divisibility witnesses `3*z+1` or `3*z-1`
for `2∣d`; cast back to naturals to contradict h2. This is exactly the
checked one-even odd-residue proof pattern. No nonnegative integer quotient
is needed. For the norm helper rewrite both norms by
`circleNorm_eq_min_fract` and then by `fract_sixth_affine_time`. For pivot
shift preservation write `d=6*u`, set residue e=0, α=1, β=b, and simplify.

For a weight w∈{1,2}, the norm helper with `e=(w:ℤ)*σ` yields
`N((a*t+b/6)*d)=N(a*fract(t*d)+σ*w*b/6)`. This is the exact form required
by the signed phase theorem. Normalize the integer product and casts before
reassociating multiplication; keep α,β integers in the general transport.

The concurrent `ThreeEvenOrbit` source is **not a verified dependency of this
plan**. Root reports prospective public names
`threeEven_exists_even_unit_sixth_residue` and
`threeEven_exists_odd_unit_sixth_residue` with the two residue contracts above.
If their source is subsequently compiled and independently accepted with
those exact contracts, reuse them and omit the two local residue proofs.
Otherwise the checked centered-residue theorem already suffices. Its future
norm weighted-shift helper is unnecessary here because the α-dependent
affine norm contract is needed anyway. Do not import mutable orbit source
merely because an expected name is present.

## 3. Exact face scalar lemmas

These are proposed local contracts. They concern the **actual fractional
phase**, except for the first closed-norm helper.

```lean
private theorem two_even_odd_face_closed (σ : ℤ) (b : ℕ)
    (hσ : σ = 1 ∨ σ = -1) (hb1 : 1 ≤ b) (hb5 : b ≤ 5) :
    (1 : ℝ) / 6 ≤ circleNorm ((σ : ℝ) * (b : ℝ) / 6)

private theorem two_even_odd_face_forward (σ : ℤ) (b : ℕ)
    (hchoice : (σ = 1 ∧ 1 ≤ b ∧ b ≤ 4) ∨
      (σ = -1 ∧ 2 ≤ b ∧ b ≤ 5)) :
    (1 : ℝ) / 6 ≤ Int.fract ((σ : ℝ) * (b : ℝ) / 6) ∧
      Int.fract ((σ : ℝ) * (b : ℝ) / 6) < (5 : ℝ) / 6

private theorem two_even_face_double :
    Int.fract ((5 : ℝ) * 2 / 6) = (2 : ℝ) / 3

private theorem two_even_face_forward (σ : ℤ) (b : ℕ)
    (hσ : σ = 1 ∨ σ = -1) (hb : b = 1 ∨ b = 5) :
    (1 : ℝ) / 6 ≤
        Int.fract ((5 + 2 * (σ : ℝ) * (b : ℝ)) / 6) ∧
      Int.fract ((5 + 2 * (σ : ℝ) * (b : ℝ)) / 6) < (5 : ℝ) / 6

private theorem two_even_face_closed (σ : ℤ) (a b : ℕ)
    (hσ : σ = 1 ∨ σ = -1) (ha : a = 3 ∨ a = 5) (hb : b ≤ 5) :
    (1 : ℝ) / 6 ≤
        Int.fract ((5 * (a : ℝ) + 2 * (σ : ℝ) * (b : ℝ)) / 6) ∧
      Int.fract ((5 * (a : ℝ) + 2 * (σ : ℝ) * (b : ℝ)) / 6)
        ≤ (5 : ℝ) / 6
```

The odd closed helper is the already checked argument from OneEvenRunners:
remove the sign with `circleNorm_neg`, then use
`circleNorm_ge_of_int_band 0 (b/6) (1/6)` and the two b bounds. For the odd
forward helper, positive σ yields b/6 for b=1..4; negative σ yields
1-b/6 for b=2..5. Both ranges are precisely
`{1/6,1/3,1/2,2/3} ⊆ [1/6,5/6)`. The cases b=1 with negative σ or b=5
with positive σ would hit 5/6 and are deliberately absent.

For the even face write its residue as **2*σ**, σ=±1. Starting from 5/6,
its affine-time phase is

`fract((5*a + 2*σ*b)/6)`.

The strict and doubled cases reduce exactly as follows:

| a | b | σ | Actual fractional phase |
| --- | --- | --- | --- |
| 2 | 0 | either | 2/3 |
| 1 | 1 | 1 | 1/6 |
| 1 | 5 | 1 | 1/2 |
| 1 | 1 | -1 | 1/2 |
| 1 | 5 | -1 | 1/6 |

The last numerator is -5, so no proof may assume the unreduced numerator
nonnegative. At odd a=3 or5 the integer `5*a+2*σ*b` is odd; its Euclidean
remainder modulo 6 is 1,3,or5, including at b=0. Thus the exact possible
fractional phases are `{1/6,1/2,5/6}`. This proves the closed helper and
explains why it is insufficient for forward improvement. An exact Lean proof
can split σ and a, use `interval_cases b`, and close each rational fractional
part with `norm_num [Int.fract]`. The odd forward helper uses the analogous
bounded b split. These are proofs of the stated scalar ranges, not an
experiment or an unverified table certificate. No such computation is run by
this planning task.

Whenever a phase is known in `[1/6,5/6]`, derive closed norm safety using
`circleNorm_eq_min_fract` and `le_min_iff`. A strictly safe norm gives both
strict fractional bounds via `circleNorm_eq_min_fract` and `lt_min_iff`.
The latter implication is what justifies the oriented forward argument.

## 4. The two common contradiction mechanisms

Under all-real hno obtain the maximizer at pivot 0 and abbreviate
`m=fract(τ*v0)`. Retain hsafe, hmax, `0<m<1/6`, `m=N(τ*v0)`, and the actual
face `r≠0`, `fract(τ*vr)=5/6`. Do not restrict hmax to [0,1], positive
times, or times with strict complement safety.

For any natural `2≤a≤5` and integer B, put `s=a*τ+B/6`. Once its complement
is closed-safe, call the existing contract:

```lean
theorem reciprocal_dilate_shift_improves
    (N d α : ℕ) (β : ℤ) (t : ℝ) (hN : 3 ≤ N)
    (hdiv : N ∣ d) (hα : 2 ≤ α) (hαN : α < N)
    (hx : 0 < Int.fract (t * (d : ℝ)))
    (hxN : Int.fract (t * (d : ℝ)) < (N : ℝ)⁻¹) :
    circleNorm (t * (d : ℝ)) <
      circleNorm (((α : ℝ) * t + (β : ℝ) / (N : ℝ)) * (d : ℝ))
```

Set `(N,d,α,β,t)=(6,v0,a,B,τ)`; derive a<6 and rewrite 1/6 as the inverse.
This contradicts `hmax s hsafe'`. It does not require the pivot to reach
1/6 at s: strict improvement of its constrained maximum is sufficient.

For a slope-one candidate s, first prove `fract(s*v0)=m` and hence
`N(s*v0)=N(τ*v0)`. Prove the actual bands
`∀i≠0,1/6≤fract(s*vi) ∧ fract(s*vi)<5/6`. Then use:

```lean
theorem exists_forward_complement_improvement
    {I : Type*} [Fintype I] [DecidableEq I]
    (v : I → ℕ) (i : I) (hv : ∀ j, 0 < v j)
    (δ s : ℝ) (hδ : 0 < δ) (hδhalf : δ < (1 : ℝ) / 2)
    (hi : Int.fract (s * (v i : ℝ)) < (1 : ℝ) / 2)
    (hbands : ∀ j, j ≠ i →
      δ ≤ Int.fract (s * (v j : ℝ)) ∧
      Int.fract (s * (v j : ℝ)) < 1 - δ) :
    ∃ ε : ℝ, 0 < ε ∧ ComplementSafe v i δ (s + ε) ∧
      circleNorm (s * (v i : ℝ)) < circleNorm ((s + ε) * (v i : ℝ))
```

With δ=1/6 its pivot premise follows from m<1/6. Rewrite the starting norm
by its equality with N(τ*v0), and contradict `hmax (s+ε) hsafe'`. The one
increment ε is common to all five labels. Lower fractional endpoints 1/6
are allowed; upper endpoints 5/6 are not. These two mechanisms may be small
private helper proofs to avoid repeating the same maximizer contradiction.

## 5. Odd upper face: mixed signed 6.1

It is useful to implement this assembly once with explicit labels `r` and
`ρ : Fin 3 → Fin 5`, requiring only these local facts:

```lean
hrodd : ¬ 2 ∣ v r
hrp : r ≠ 0
hrface : Int.fract (τ * (v r : ℝ)) = (5 : ℝ) / 6
hρzero : ρ 0 = 1
hρp : ∀ j, ρ j ≠ 0
hρr : ∀ j, ρ j ≠ r
hρodd : ∀ j, j ≠ 0 → ¬ 2 ∣ v (ρ j)
hρexhaust : ∀ i, i ≠ 0 → i ≠ r → ∃ j, ρ j = i
```

These are facts in the local proof context, not a new public type or an extra
mathematical assumption on v. There is no need to assume ρ injective: the
explicit constructions below have the stronger property anyway, and the
assembly uses only exhaustion, exclusion, and coordinate roles.

1. Extract `(v r:ℤ)=6*zr+σ`, σ=±1, using hrodd and hother. Set
   `t'=τ+σ/6`. From `fract_sixth_affine_time` with α=1, β=σ, residue σ,
   and σ²=1 obtain `fract(t'*vr)=fract(5/6+1/6)=0`.
   The six-divisible pivot has `fract(t'*v0)=m`.
2. At coordinate zero extract an even residue for v1, and at the other two
   coordinates extract odd residues. Use `choose` to obtain integer functions
   z,e with `e j=±1` and
   `(v(ρ j):ℤ)=6*z j+(if j=0 then (2:ℤ) else 1)*e j`.
   Set `x j=fract(t'*v(ρ j))`; these are unrestricted real phases.
3. If σ=1 apply `renault_phase_six_one_signed x e he`; if σ=-1 apply
   `renault_phase_six_one_signed_reflected x e he`. This produces either
   one common closed `(a,b)` in a=2..5,b=1..5, or one common strict b with
   `(σ=1 ∧ 1≤b≤4) ∨ (σ=-1 ∧ 2≤b≤5)`.
4. In the closed case set `s=a*t'+b/6`. Apply `two_even_norm_affine` to
   every ρ coordinate with α=a, β=b and residue w*e. The signed phase
   bounds then give its closed safety. The actual face phase is
   `fract(σ*b/6)` by the same fractional transport and its zero phase at
   t'. Use `two_even_odd_face_closed` to protect r. Exhaustion gives
   `ComplementSafe v 0 (1/6) s`.
   Define **integer** `B=(a:ℤ)*σ+(b:ℤ)` and verify
   `s=(a:ℝ)*τ+(B:ℝ)/6` by casting and ring algebra. The first mechanism
   in section 4 contradicts hmax. Never encode B using natural subtraction.
5. In the strict case set `s=t'+b/6`. The same norm transport gives strict
   safety at every ρ coordinate; the odd forward helper gives the actual
   face band at r. These imply all four fractional bands in `[1/6,5/6)`.
   Also `s=τ+((σ+(b:ℤ):ℤ):ℝ)/6`, so pivot fractional preservation gives
   `fract(s*v0)=m`. Apply the forward mechanism from section 4.

For the fixed-role proof split the actual face r by `fin_cases r`. The r=0
case contradicts hrp; r=1 is section 6. For the other three cases use:

| Actual upper face r | ρ vector |
| --- | --- |
| 2 | `![1,3,4]` |
| 3 | `![1,2,4]` |
| 4 | `![1,2,3]` |

`fin_cases j` proves the coordinate facts from the pointwise hypotheses;
`fin_cases i` proves exhaustion, choosing the corresponding literal index
in Fin3. These are label arguments and remain valid with repeated speeds.
In particular the same weighted assembly handles all three rows; do not
copy its long proof three times.

## 6. Even upper face: initially safe signed 6.4

Now r=1, so the unique other even speed has `fract(τ*v1)=5/6`.
Use the fixed map `ρ : Fin 3 → Fin 5 := ![2,3,4]`. Extract unit signs e j
for these odd speeds and write `x j=fract(τ*v(ρ j))`. Initial closed norm
safety follows from the maximizer's `hsafe (ρ j)`; norm affine transport
with α=1,β=0 identifies N(x j) with the original norm. Consequently
`renault_phase_six_four_signed x e he hx` applies. Separately extract
`(v1:ℤ)=6*zq+2*σ` with σ=±1.

For every candidate `s=a*τ+b/6`, `fract_sixth_affine_time` and hrface give

`fract(s*v1)=fract((5*a+2*σ*b)/6)`.

This equality follows by ring normalization of the real expression after
casting the integer product β*(2*σ). The three branches are:

* **Strict doubling:** take a=2,b=0,s=2τ. Each odd coordinate is strictly
  safe by the first alternative; `two_even_norm_affine` identifies its
  actual norm with N(2*x j). The even face is exactly 2/3 by
  `two_even_face_double`, hence closed-safe. The complete complement is
  closed-safe, and the dilation mechanism with a=2,B=0 contradicts hmax.
  No forward argument is necessary in this branch.
* **Strict unit slope:** take a=1 and the returned b=1 or5. Each odd
  coordinate is strictly safe. `two_even_face_forward` puts the even face
  at 1/6 or1/2, so all four actual phases are in `[1/6,5/6)`.
  Pivot preservation uses `two_even_fract_shift (v0) hsix τ (b:ℤ)`.
  Apply the forward mechanism. An even face at 1/6 is permissible here.
* **Closed odd slope:** take the returned a=3 or5 and b≤5, including b=0.
  Norm transport protects the three odd coordinates. The closed face
  helper protects v1 and permits its 5/6 endpoint. The complete complement
  is closed-safe. Use the dilation mechanism with this a and B=(b:ℤ).
  Requiring b≥1 or an upper phase strictly below 5/6 would discard valid
  outputs of the checked theorem.

Each branch contradicts the same all-real maximum. This completes the
fixed-role contradiction under hno.

## 7. Positive time and arbitrary-pivot count adapter

For the pointwise theorem, prove an all-real closed witness by contradiction
using sections 4–6. Its time u is nonzero because the label-0 bound would
otherwise read `1/6≤circleNorm 0=0`. If u>0 return it. If u<0 return -u,
using `(-u)*vi=-(u*vi)` and `circleNorm_neg`. This is exactly the checked
positive conversion in OneEvenRunners; no speed sign or endpoint changes.

For `one_three_divisible_two_even_witness`, first prove an all-real witness
by contradiction. The current existing contract is:

```lean
theorem divisor_cover_of_no_small_witness {n N : Nat}
    (speeds : Fin n → Nat) (hN : 0 < N)
    (hNoWitness : ¬ ∃ t : Real, ∀ i,
      (N : Real)⁻¹ ≤ circleNorm (t * (speeds i : Real))) :
    ∀ q, 2 ≤ q → q ≤ N → ∃ i, q ∣ speeds i
```

Apply it with n=5,N=6,q=6, converting hno by `one_div`. It returns an i
with 6∣v i. Since 3∣6, hone gives i=p, hence hsix and hp2. This lower-cover
theorem needs no gcd hypothesis; the primitive divisor-count upper theorem
is unnecessary for this adapter.

Let `S=univ.filter (fun i => 2∣v i)`. Then p∈S, |S|=2, and
`(S.erase p).card=1` by `Finset.card_erase_of_mem`. The inspected API
`Finset.card_eq_one.mp` returns q with `S.erase p={q}`. Thus q≠p and q is
even. Any even i is p or q, by splitting i=p and otherwise placing i in
S.erase p. No choice between equal *speed values* is made.

Let `O=((Finset.univ : Finset (Fin 5)).erase p).erase q`. Its cardinality
is 3: erase p from the five labels, then erase q, whose membership follows
from q≠p. The inspected current API is:

```lean
Finset.card_eq_three : s.card = 3 ↔
  ∃ x y z, x ≠ y ∧ x ≠ z ∧ y ≠ z ∧ s = {x, y, z}
```

Obtain labels u,w,z enumerating O. Their erase membership excludes p and q,
so they are odd by the characterization of even labels. Their exclusion
from p also yields nondivisibility by three from hone. Every original label
is p,q,u,w,or z, by splitting membership in the two erased labels and O.

Define `v' : Fin 5 → ℕ := ![v p,v q,v u,v w,v z]`. Positivity, six
divisibility at zero, evenness at one, oddness at two through four, and
three-nondivisibility away from zero follow by finite coordinate cases.
Call the already established pointwise theorem for v'. Transfer its single
positive time to every original label using the exhaustion disjunction and
the corresponding bound at index 0..4. This contradicts the original hno.
Convert the resulting all-real witness to positive time as above.

This adapter does not depend on speed injectivity, a permutation object, a
primitive tuple, or the future combined one-three-divisible theorem. The
pointwise theorem precedes the adapter, so its use inside the contradiction
is not circular.

## 8. Implementation, review, and remaining scope

Implement the local residue/affine/face helpers, the two shared maximum
contradictions, the odd-face assembly with its literal label maps, the even
face assembly, the fixed-role positive theorem, and the count adapter in
one cohesive module. The small helper proofs can remain private. Comments
should explain the actual-phase upper endpoint, the mixed weight at coordinate
zero, and the integer numerator in the reflected closed case. Update the
project checkpoint documentation after the module is accepted.

The complete module still needs focused compilation, independent final source
review, integration, and the trust audit. A repeated check of an unchanged
signed dependency is not needed solely for this assembly. Any actual missing
helper or altered endpoint must be escalated rather than weakening the public
statements.

The remaining mathematical scope is the two-even restricted branch. Combined
parity dispatch, the full five-moving-speed sixth-margin theorem, and its
canonical N=6 bridge remain separate integration obligations. N=6 is the
transition milestone; once checked with the full build, trust audit, and exact
scope review, continue toward a uniform arbitrary-N mechanism. No successive
runner-count roadmap and no claim of unrestricted LRC completion is implied.

## 9. Static provenance and checks

This plan expands section 7 of the already independently accepted manuscript
and the root handoff outline. The primary paper provenance remains
[Renault, View-obstruction: a shorter proof for 6 lonely runners](https://compmath.wordpress.com/wp-content/uploads/2008/08/view-obstruction_a_shorter_proof_for_6_lonely-runners.pdf).
No web retrieval, Lean invocation, probe, numerical program, candidate
search, solver, shared-cache mutation, shared-state edit, or Git operation
was performed by this task. New mathematical reasoning here is the explicit
symbolic assembly and exact endpoint accounting, not a kernel proof.

The required workflow validator exited 0 and explicitly certified structural
consistency only. Only the two assigned research Markdown files were written.
Static readback checked all eleven source bindings below, balanced code fences,
and the eleven proposed declaration names. These checks do not certify Lean
elaboration or mathematical validity.

Frozen source bindings (SHA-256), verified by static byte hashing:

| File | SHA-256 |
| --- | --- |
| `research/astra-two-even-next-outline.md` | `75e2a7336bed3d460ee5a8534278e17ba89fac06d5ea64fa8e63fc9b3609a0cd` |
| `research/astra-one-three-divisible-plan.md` | `9da230600af3a0a0bc8223de3daca2575f8d41f447142687ca64db53ced4ae9e` |
| `research/astra-one-three-divisible-review.md` | `8f720fbd8002918adaaa0d36fc7774c450eeb5dba84dd555552d24b5e57e6078` |
| `research/astra-signed-remaining-phase-source-review.md` | `1b184342ddda5fb995c5c57c754f4c4ac38fefbdb1072bc4ad12fb3e7f352ae6` |
| `LonelyRunner/SignedRemainingPhase.lean` | `f75e742e3b0109fc9b1e23818dcc4873e1d824395171adbc4188da862050597c` |
| `LonelyRunner/RemainingPhaseLemma.lean` | `4523603cd6f8f88546f09017b8cee3159c65683237af81dd61fb66fd452cb4db` |
| `LonelyRunner/OneEvenRunners.lean` | `5bf5f01d7b31b410b680d646a832b273890cc267dc7a4775fea37eac5c58b810` |
| `LonelyRunner/OneSixthComplementMaximizer.lean` | `5a7011ca680b8a2b26c7bad466a8ee4008cf47507eb8b700846f296894bb90a1` |
| `LonelyRunner/SixthAffinePhase.lean` | `76e420713079ec0c3979e9b169cd78ecb6a932d6dc790ea7d9711adbb64b7d4b` |
| `LonelyRunner/ConstrainedMaximizer.lean` | `2ef07e6b83b8675a22184571c31d2a71dab9d5c072e3cd165cb8382957b46e92` |
| `LonelyRunner/SmallDenominatorWitness.lean` | `1570a359100594f4a5589588e3b32674dc2d54d60e500df1d47aca64c2faf95f` |

Hashes bind inspected text and accepted prior evidence only. No compiled
artifact or acceptance is asserted for the mutable `ThreeEvenOrbit` source.
