# Three-even branch: complete assembly plan

The root outline is mathematically sound. The current checked interfaces suffice;
no additional mathematical hypothesis or unresolved lemma is needed. The new
work is the symbolic transport and finite-label assembly specified below. None
of the proposed declarations has been implemented or elaborated by this task.

The smallest assembly needs only `sixth_shift_weak_even`: rescuing the two even
exceptions first, then applying the half-time argument, already forces the odd
partner's norm above 1/3. `sixth_shift_weak_odd` also correctly proves the outline's
intermediate strict-sixth statement, but that extra subproof can be omitted.

A second simplification strengthens the count adapter: its explicit six-divisible
pivot hypothesis can be derived under all-real no-witness using the existing
small-denominator cover theorem. This uses no primitive/gcd assumption.

## 1. Exact public contracts

Use fixed **label roles**, not an injectivity assumption on speed values: label
0 is A, labels 1 and 2 are E,F, and labels 3 and 4 are U,W. This makes the final
three-label weak-bad set literal and lets the count adapter reorder five chosen
labels by a vector. The pointwise contract is:

```lean
theorem fiveMovingNaturalRunners_of_three_even_residues
    (v : Fin 5 → ℕ) (hpos : ∀ i, 0 < v i)
    (hsix : 6 ∣ v 0)
    (heven1 : 2 ∣ v 1) (heven2 : 2 ∣ v 2)
    (hodd3 : ¬ 2 ∣ v 3) (hodd4 : ¬ 2 ∣ v 4)
    (hother : ∀ i, i ≠ 0 → ¬ 3 ∣ v i) :
    ∃ t : ℝ, 0 < t ∧ ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ))
```

The arbitrary-pivot adapter can have precisely this stronger statement:

```lean
theorem one_three_divisible_three_even_witness
    (v : Fin 5 → ℕ) (hpos : ∀ i, 0 < v i) (p : Fin 5)
    (hone : ∀ i, 3 ∣ v i ↔ i = p)
    (heven : ((Finset.univ : Finset (Fin 5)).filter
      (fun i => 2 ∣ v i)).card = 3) :
    ∃ t : ℝ, 0 < t ∧ ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ))
```

Both permit repeated positive values within the parity classes. Neither requires
a primitive tuple, speed injectivity, a fast-speed bound on E or F, or a supplied
witness. Keep every displayed bound closed. The internal contradiction is always
against absence of an **all-real** witness; only the final wrapper forces its
time positive.

## 2. Actual interfaces and proposed small helpers

All project theorem names below are in `LonelyRunner`. The following are existing,
inspected interfaces, not proposed replacements:

* `sixth_shift_weak_even (x y z : ℝ) (hx : circleNorm x ≤ 1/6)` returns
  `∃ b : ℕ, (b=1 ∨ b=2 ∨ b=4 ∨ b=5) ∧` the three closed bounds for
  `x+2*b/6`, `y+2*b/6`, and `z+b/6`. One shared `b` serves all three.
* `sixth_shift_weak_odd (x y z : ℝ) (hz : circleNorm z ≤ 1/6)` returns
  `∃ b : ℕ, 1≤b ∧ b≤5 ∧` the same three closed bounds. Its allowance of
  `b=3` is intentional. Both accept arbitrary signed real phases.
* `fract_sixth_affine_time t d α β z e hd`, for natural d and integer
  `α,β,z,e`, transports fractional parts under `hd : (d:ℤ)=6*z+e`:
  `fract(((α:ℝ)*t+(β:ℝ)/6)*d)
   = fract((α:ℝ)*fract(t*d)+((β*e:ℤ):ℝ)/6)`.
* `exists_centered_sixth_residue_of_not_dvd_three d hthree` returns integer
  `z,e`, the identity `(d:ℤ)=6*z+e`, and `e=1 ∨ e=-1 ∨ e=2 ∨ e=-2`.
* `circleNorm_time_add_nat_div_of_dvd ell d k hell hd t` preserves the norm
  at `t+k/ell` when `0<ell` and `ell∣d`. Use `(ell,k)=(6,b)` or `(2,1)`.
* `circleNorm_time_add_half_of_not_dvd_two t d hodd`, followed by
  `circleNorm_add_half (t*d)`, gives exactly
  `N((t+1/2)*d)=1/2-N(t*d)` for odd d and arbitrary real t.
* `circleNorm_nat_mul_add_int_half x n β` states
  `N((n:ℝ)*x+(β:ℝ)/2)=N((n:ℝ)*N(x)+(β:ℝ)/2)`.
* `exists_reciprocal_time_small_phase A q hq hcop hnot` has natural A,q,
  `0<q`, `Nat.Coprime q 6`, and `¬q∣A`; it returns `k<q` and
  `fract(k*A/q)∈[1/12,1/6]` or exactly `1/5`. Composite q is supported.
* `exists_bad_sixth_dilate x hx`, with `hx : 1/6<N(x)`, returns a natural
  `2≤a≤5` with `N((a:ℝ)*x)<1/6`.
* `third_shift_of_three_weak_exceptions v p hdiv hother t hp hbad` requires
  `3∣v p`, every other label nondivisible by three, a closed-safe pivot at t,
  and at least three other labels with norm **at most** 1/6. It returns one
  common `k:Fin 3` making all five safe at `t+k.val/3`. It has no positivity
  or speed-distinctness premise.

Use these proposed private residue helpers; do not call the identically themed
private helper in `OneEvenRunners`, which is not a public API:

```lean
private theorem exists_even_unit_sixth_residue (d : ℕ)
    (h2 : 2 ∣ d) (h3 : ¬ 3 ∣ d) :
    ∃ z σ : ℤ, (d : ℤ) = 6 * z + 2 * σ ∧ (σ = 1 ∨ σ = -1)

private theorem exists_odd_unit_sixth_residue (d : ℕ)
    (h2 : ¬ 2 ∣ d) (h3 : ¬ 3 ∣ d) :
    ∃ z σ : ℤ, (d : ℤ) = 6 * z + σ ∧ (σ = 1 ∨ σ = -1)
```

Apply the existing four-centered-residue theorem. For even d, cast `2∣d` to
integer divisibility; its witness makes the residues ±1 impossible by integer
linear arithmetic. For odd d, the residues ±2 give integer witnesses `3*z+1`
and `3*z-1` for `2∣d`; cast that divisibility back to naturals. The surviving
cases give the claimed signed identity by ring simplification. No integer
quotient sign is assumed.

A small reusable norm transport avoids importing maximizer infrastructure:

```lean
private theorem circleNorm_nat_mul_fract (x : ℝ) (n : ℕ) :
    circleNorm ((n : ℝ) * x) =
      circleNorm ((n : ℝ) * Int.fract x)

private theorem circleNorm_sixth_weighted_shift
    (t : ℝ) (d w b : ℕ) (z σ : ℤ)
    (hd : (d : ℤ) = 6 * z + (w : ℤ) * σ)
    (hσ : σ = 1 ∨ σ = -1) :
    circleNorm ((t + (b : ℝ) / 6) * (d : ℝ)) =
      circleNorm ((σ : ℝ) * Int.fract (t * (d : ℝ)) +
        (w : ℝ) * (b : ℝ) / 6)
```

For the first, use `Int.floor_add_fract x` to write the left argument as the
integer `(n:ℤ)*⌊x⌋` plus `n*fract x`, then `circleNorm_add_int`. At n=1 it
also gives `N(x)=N(fract x)`.

For the second, use `fract_sixth_affine_time` with `α=1`, `β=(b:ℤ)` and
`e=(w:ℤ)*σ`. Convert the fractional equality to norm equality using the first
helper at n=1 on both arguments. Normalize integer products **before** casting.
The resulting norm is `N(fract(t*d)+w*b*σ/6)`. When σ=1 the target follows by
ring; when σ=-1 the two real arguments are negatives, so use `circleNorm_neg`.
The shift `b/6` is the same actual time shift for every label, despite their
independently chosen residue signs. At b=0 the helper also identifies each
signed normalized base norm with its actual base norm. This declaration is
valid for all natural w,b, including zero, and all real t.

## 3. The odd-zero obstruction, with exact contract

The core argument is easier to reuse in both odd-label orders by temporarily
working with speed values and a private conjunction:

```lean
private abbrev FiveSafe (A E F U W : ℕ) (t : ℝ) : Prop :=
  (1 : ℝ) / 6 ≤ circleNorm (t * (A : ℝ)) ∧
  (1 : ℝ) / 6 ≤ circleNorm (t * (E : ℝ)) ∧
  (1 : ℝ) / 6 ≤ circleNorm (t * (F : ℝ)) ∧
  (1 : ℝ) / 6 ≤ circleNorm (t * (U : ℝ)) ∧
  (1 : ℝ) / 6 ≤ circleNorm (t * (W : ℝ))

private theorem three_even_at_odd_zero
    (A E F U W : ℕ)
    (hA6 : 6 ∣ A) (hE2 : 2 ∣ E) (hF2 : 2 ∣ F)
    (hU2 : ¬ 2 ∣ U) (hW2 : ¬ 2 ∣ W)
    (hE3 : ¬ 3 ∣ E) (hF3 : ¬ 3 ∣ F)
    (hU3 : ¬ 3 ∣ U) (hW3 : ¬ 3 ∣ W)
    (hno : ¬ ∃ s : ℝ, FiveSafe A E F U W s)
    (t : ℝ) (hzero : Int.fract (t * (U : ℝ)) = 0)
    (hp : (1 : ℝ) / 6 ≤ circleNorm (t * (A : ℝ))) :
    (1 : ℝ) / 6 < circleNorm (t * (E : ℝ)) ∧
    (1 : ℝ) / 6 < circleNorm (t * (F : ℝ)) ∧
    (1 : ℝ) / 3 < circleNorm (t * (W : ℝ))
```

No speed positivity is required for this helper. It follows solely from the
specified parities, residues, pivot bound and all-real no-witness. The public
theorem still keeps all its required positivity hypotheses.

Choose E,F residues `2*σE,2*σF` and U,W residues `σU,σW`, each sign ±1.
Normalize the three free phases by

`x=σE*fract(t*E)`, `y=σF*fract(t*F)`, `z=σW*fract(t*W)`.

These are signed **fractional parts**, not folded circle norms. The weight
transport says that after the actual common time shift b/6 their norms become
`N(x+2b/6)`, `N(y+2b/6)`, `N(z+b/6)`.

If E is weakly bad, the same norm transport at b=0 supplies the hypothesis of
`sixth_shift_weak_even x y z`. If F is weakly bad, apply the theorem to `y x z`
and exchange its first two conclusions. Either call supplies b in `{1,2,4,5}`;
extract `1≤b≤5` by the displayed alternatives. The pivot is preserved using
`circleNorm_time_add_nat_div_of_dvd 6 A b`. At U the actual fractional part is
`fract(σU*b/6)` because its initial fractional part is zero; its norm is
`N(b/6)` by the weight-one transport and reflection. The closed integer band
`[1/6,5/6]` proves U safe. Thus the single time `t+b/6` satisfies all five
conjuncts of `FiveSafe`, contradicting hno. This proves E,F strictly safe.

For completeness, if W is weakly bad, the same argument using
`sixth_shift_weak_odd x y z` gives the outline's W>1/6 conclusion. Its possible
b=3 causes no issue: U then has norm 1/2 and the pivot is still preserved.
The following stronger conclusion makes that additional call unnecessary.

Suppose `N(t*W)≤1/3`. At `t+1/2`, the three even phases are preserved by the
reciprocal-shift theorem with ell=2,k=1; for A use `2∣6∣A`. The U norm at t is
zero, by `hzero` and `N(x)=N(fract x)`. The odd-half-time identity gives its new
norm as 1/2. The same identity at W gives `1/2-N(t*W)≥1/6`. E,F were already
strictly safe, and A was closed-safe. This is a full witness at `t+1/2`, another
contradiction. Therefore `N(t*W)>1/3`, including exclusion of equality. No step
assumes t, t+b/6 or t+1/2 is positive.

## 4. Prescribed orbit to divisibility

The following two scalar contracts contain all remaining delicate endpoints:

```lean
private theorem small_phase_double_four_safe (x : ℝ)
    (hx : (((1 : ℝ) / 12 ≤ Int.fract x ∧
      Int.fract x ≤ (1 : ℝ) / 6) ∨ Int.fract x = (1 : ℝ) / 5)) :
    (1 : ℝ) / 6 ≤ circleNorm (2 * x) ∧
    (1 : ℝ) / 6 ≤ circleNorm (4 * x)

private theorem circleNorm_double_lt_third (x : ℝ)
    (hx : (1 : ℝ) / 3 < circleNorm x) :
    circleNorm (2 * x) < (1 : ℝ) / 3
```

For the first, put r=fract x and use `circleNorm_nat_mul_fract` at n=2,4.
When r lies in the closed small band, `2r∈[1/6,1/3]` and `4r∈[1/3,2/3]`.
When r=1/5, the phases are 2/5 and 4/5. In all cases apply
`circleNorm_ge_of_int_band 0 _ (1/6)`. The lower endpoint r=1/12 gives exactly
1/6 at the double and must not be made strict. No modular wrap occurs in these
bands, including the special fifth phase.

For the second, put u=N(x). `circleNorm_eq_abs_sub_round` and `abs_sub_round`
give `u≤1/2`. The existing folded dilation identity at n=2,β=0 gives
`N(2x)=N(2u)`. Write `2u=(1:ℤ)+(2u-1)` and use integer periodicity.
Here `-1/3<2u-1≤0`, so `circleNorm_eq_abs_of_abs_le_half` and
`abs_of_nonpos` give `N(2x)=1-2u<1/3`. At u=1/2 this is exactly zero.
This proof handles arbitrary signed x and does not confuse the folded u with
an oriented fractional part.

A useful small conditional arithmetic/phase bridge is:

```lean
private theorem dvd_of_large_partner_at_zeros
    (A U W : ℕ) (hU : 0 < U) (hcop : Nat.Coprime U 6)
    (hlarge : ∀ t : ℝ, Int.fract (t * (U : ℝ)) = 0 →
      (1 : ℝ) / 6 ≤ circleNorm (t * (A : ℝ)) →
      (1 : ℝ) / 3 < circleNorm (t * (W : ℝ))) :
    U ∣ A
```

Assume `¬U∣A`. Apply `exists_reciprocal_time_small_phase A U hU hcop` to get
k<U and the prescribed fractional phase. Set `s=(k:ℝ)/(U:ℝ)`. Rewrite
`s*A=k*A/U` by field/ring arithmetic and apply `small_phase_double_four_safe`
to x=s*A. Thus the pivot is safe at both 2s and 4s.

Since U>0, `(2s)*U=(2*k:ℕ)` and `(4s)*U=(4*k:ℕ)` after casting; the
fractional parts are zero by `Int.fract_natCast`. Invoke hlarge at each of
those **actual times**, obtaining `N((2s)*W)>1/3` and `N((4s)*W)>1/3`.
Apply `circleNorm_double_lt_third` to `x=(2s)*W` and rewrite
`2*((2s)*W)=(4s)*W`. Contradiction. There is no requirement k>0 or s>0:
the all-real conditional hypothesis was chosen to avoid such unnecessary work.

For each odd q=U,W, derive `Nat.Coprime q 6` from the two nondivisibilities.
The inspected exact arithmetic APIs are:

```lean
Nat.Prime.coprime_iff_not_dvd (hp : Nat.Prime p) :
  Nat.Coprime p n ↔ ¬ p ∣ n
Nat.coprime_mul_iff_right :
  Nat.Coprime k (m * n) ↔ Nat.Coprime k m ∧ Nat.Coprime k n
Nat.Coprime.mul_dvd_of_dvd_of_dvd (h : Nat.Coprime m n)
  (hm : m ∣ a) (hn : n ∣ a) : m * n ∣ a
```

Use `Nat.prime_two` and `Nat.prime_three`, then symmetry, to get `Coprime q 2`
and `Coprime q 3`; combine using `Nat.coprime_mul_iff_right.mpr` and normalize
2*3=6. This does not infer unit status from a nonzero composite residue.

The odd-zero helper supplies hlarge for U with partner W. To obtain the reverse
order, swap U,W in that helper, reordering the last two `FiveSafe` conjuncts in
hno; all the required parity/nondivisibility assumptions swap too. This proves
both `U∣A` and `W∣A` without a symmetry assumption on the values.

Finally `hcopU.symm.mul_dvd_of_dvd_of_dvd hA6 hUA` has conclusion `6*U∣A`,
with the factors in exactly that order. Apply `Nat.le_of_dvd hA` to get
`6*U≤A`; similarly for W. These use positivity of A, not a gcd assumption on
the entire tuple. In particular no bound on E or F has been derived.

## 5. Five small dilates and the final weak-label count

The existing `small_sixth_seed_norms` only supplies the first and fifth times.
Do not claim it covers all five. Its direct phase proof gives this small private
generalization, whose inclusion of a=0 and U=0 is harmless and useful:

```lean
private theorem small_sixth_dilate_norm (A U : ℝ) (a : ℕ)
    (hA : 0 < A) (hU : 0 ≤ U) (hsmall : 6 * U ≤ A) (ha : a ≤ 5) :
    circleNorm (((a : ℝ) * (1 / (6 * A))) * U) < (1 : ℝ) / 6
```

Indeed `0≤U/(6A)≤1/36`, so the actual nonnegative phase lies at most a/36,
hence at most 5/36<1/6. Because it is below 1/2, its circle norm is the phase
itself by `circleNorm_eq_abs_of_abs_le_half`. Derive the fraction inequality
with `div_le_iff₀` and `0<6A`, keeping the positivity premise explicit.

Now return to the fixed-role tuple v, assuming
`hno : ¬∃t:ℝ,∀i,1/6≤N(t*v i)`. Set A=v0,E=v1,F=v2,U=v3,W=v4 and
convert hno to the five-conjunct form by cases on the five labels. The previous
sections give `6*U≤A` and `6*W≤A`. Cast these natural inequalities to reals.
Set `t₀=1/(6*(A:ℝ))`, which is positive by hpos0.

For arbitrary natural a with `1≤a≤5`, write `tₐ=(a:ℝ)*t₀`. The pivot's actual
phase is `tₐ*A=a/6`; positivity of A permits this cancellation. The zero integer
band proves its norm at least 1/6. The new small-dilate helper makes U,W strictly
bad at tₐ, hence also weakly bad.

Suppose E is weakly bad there. In the exact filter

`B = Finset.univ.filter
  (fun i : Fin 5 => i ≠ 0 ∧ N(tₐ*(v i:ℝ))≤1/6)`,

the three **distinct labels** 1,3,4 all belong. Prove
`({1,3,4} : Finset (Fin 5)) ⊆ B` by splitting membership into its three labels,
then use `Finset.card_le_card` and the literal card 3. This proof does not compare
any speed values. Supply `3∣v0` from `3∣6∣v0`, the original hother, the pivot
bound and this `3≤B.card` to `third_shift_of_three_weak_exceptions`. Its one
common returned shift gives an all-real witness, contradicting hno.

Therefore
`∀ a:ℕ, 1≤a → a≤5 → 1/6<N(((a:ℝ)*t₀)*(v1:ℝ))`.
At a=1 this supplies the input to `exists_bad_sixth_dilate (t₀*(v1:ℝ))`.
Its returned `2≤a≤5` has norm strictly below 1/6; associativity rewrites that
argument to the same tₐ*v1, contradicting the displayed strict lower bound.
There is no need to prove F strictly safe at all five dilates as a separate
final step. No speed search, case recursion or supplied five-moving witness
enters this contradiction.

This establishes the all-real witness for the public pointwise theorem.
It cannot occur at zero, by its label-0 bound and `circleNorm 0=0`. Return the
time itself if positive, and its negative if negative, using `circleNorm_neg`
and `(-t)*d=-(t*d)`. This is the same already reviewed conversion in
`OneEvenRunners`.

## 6. Unique-three/cardinality adapter

First prove an all-real witness by contradiction. Convert its hno from 1/6 to
`(6:ℝ)⁻¹` using `one_div`, and apply this existing interface from
`SmallDenominatorWitness`:

```lean
divisor_cover_of_no_small_witness {n N : ℕ}
  (speeds : Fin n → ℕ) (hN : 0 < N)
  (hNoWitness : ¬ ∃ t : ℝ, ∀ i,
    (N : ℝ)⁻¹ ≤ circleNorm (t * (speeds i : ℝ))) :
  ∀ q, 2 ≤ q → q ≤ N → ∃ i, q ∣ speeds i
```

At N=q=6 this supplies i with `6∣v i`. Since `3∣6`, hone identifies i=p.
Thus `6∣v p` and `2∣v p`. This precise lower-cover theorem has **no primitive
or positivity premise**. Do not call the primitive upper divisor-count theorem
or assume a stronger count scope.

Let S be the even-label filter. Its cardinality is 3 and p∈S, so
`(S.erase p).card=2` by `Finset.card_erase_of_mem`. Use
`Finset.card_eq_two.mp` to get e,f with e≠f and `S.erase p={e,f}`. Their
membership gives e,f≠p and both even. Apply the inspected API

`exists_two_odd_outside_three v p e f hpe hfp hfe hp2 he2 hf2 hcardle3`.

It supplies distinct u,w, their oddness, and exact exhaustion
`∀i, i=p ∨ i=e ∨ i=f ∨ i=u ∨ i=w`. The argument order of the three inequalities
is p≠e, f≠p, f≠e. These are obtained from the erase membership and e≠f with
the appropriate symmetries.

Define `v' : Fin 5 → ℕ := ![v p, v e, v f, v u, v w]`. Its positivity and
four parity fields follow directly by the fixed-coordinate simplifications.
For every j≠0, its three-nondivisibility follows from hone at the corresponding
original label. For e,f use their exclusion from p. For u,w derive exclusion
from p by oddness against hp2. Use `fin_cases j` and vector simplification;
this is a finite label proof, not a numerical experiment.

Apply the pointwise theorem to v'. It returns a positive time and five common
bounds. Split the original exhaustion disjunction and use the corresponding
bound at index 0,1,2,3,4. This is an all-real witness for v and contradicts hno.
No `Equiv.Perm`, speed sorting, speed injectivity or gcd normalization is needed.
Finally convert the resulting all-real witness to a positive one as above.
The pointwise theorem is already proved before this adapter and does not depend
on it, so the adapter's contradiction is not circular.

## 7. Cohesive implementation order and scope

A reasonable single new module is `LonelyRunner/ThreeEvenRunners.lean`, importing
`WeakSixthShifts`, `SmallPhaseOrbits`, `SixthAffinePhase`, `OddHalfTimeShift`,
`ThreeWeakExceptions`, `BadSixthDilate`, `TwoOddOutsideThree` and
`SmallDenominatorWitness`; the folded norm and reciprocal preservation APIs
arrive through these imports. `SmallSixthSeeds` is a proof-pattern reference,
not a falsely generalized dependency. `ConstrainedMaximizer` is unnecessary.

Implement private norm/residue transports first, then the two scalar orbit
bounds and generic `dvd_of_large_partner_at_zeros`; implement the odd-zero
obstruction, small-dilate bound, fixed-role contradiction/positive wrapper,
and finally the count adapter. Keep the displayed algebraic helper contracts
private unless an already named task needs them. All their mathematics is
settled here; a compiler problem is not authorization to change a contract.

The first independent Terra-ready work is the cohesive norm transport and
scalar orbit bridge (sections 2 and 4). The second is the small-dilate scalar
bound plus the finite-label extraction in section 6, if a separate dependency
batch is useful. The substantial odd-zero and final assembly should remain
cohesive after those inputs are compiled. Source review, focused compilation,
integration and trust audit are still required; this plan is not a build receipt.

The only mathematical scope claimed is a complete manuscript proof of these
two restricted branch contracts. The next milestone remains the checked
canonical N=6 theorem; afterward research must switch to a uniform arbitrary-N
mechanism, not successive finite runner counts.

## 8. Static source evidence

Read project config/workflow/policy and focused state. State was research /
in_progress, task `/root/three_even_assembly_plan`, checkpoint `a4e324a`, requested
Astra/xhigh; no runtime-observed routing is inferred. The required validator was
run once at startup and exited 1 with these exact diagnostics:

```text
workflow validation error: completed_tasks[363].status must be one of ['complete', 'interrupted']
workflow validation error: completed_tasks[364].status must be one of ['complete', 'interrupted']
workflow validation error: completed_tasks[365].status must be one of ['complete', 'interrupted']
```

This root-owned metadata defect was reported immediately; no state was changed
by this worker. It is separate from the mathematical analysis. Source discovery
also encountered absent exploratory filenames/directories and resolved the
actual API locations below. No Lean/compiler, numerical experiment, solver,
mathematical search, Git or cache action occurred. Only this report was edited.
The source bodies/signatures and accepted section 8 manuscript were inspected;
compiled status is inherited from existing delivery evidence, not freshly tested.

The following SHA-256 bindings identify the source used. `ML/` means
`.lake/packages/mathlib/Mathlib/`. `Init/` means the pinned toolchain source root
`/home/joshua/.elan/toolchains/leanprover--lean4---v4.32.1/src/lean/Init/`.

| Source | SHA-256 |
| --- | --- |
| `research/astra-three-even-next-outline.md` | `cb07108c5df8e9127a98c597f71606b2055d28aa249bdfc8fdbe2e34a857e82d` |
| `LonelyRunner/WeakSixthShifts.lean` | `8c2ba998a08976ffc33f6af0226908a1bc068c322bac793e071210c49b1ce61b` |
| `LonelyRunner/SmallPhaseOrbits.lean` | `033d7c9f84e924ab7f66ad0f37cfddf7b22c395a596d7fef57b273b2459a0e97` |
| `LonelyRunner/SixthAffinePhase.lean` | `76e420713079ec0c3979e9b169cd78ecb6a932d6dc790ea7d9711adbb64b7d4b` |
| `LonelyRunner/OddHalfTimeShift.lean` | `ea274daeadc4bf2242399663cd5da914b1c096f62b58cb43fdffa2e625af6b5c` |
| `LonelyRunner/FoldedCirclePhase.lean` | `957606878108847d5ceff47be621ff0fc9c0a0d976568b5f5ef3dbb6db10481e` |
| `LonelyRunner/ThreeWeakExceptions.lean` | `bdb75b5254a4a8bacb01f29ebdef34b40aa966c96de2b69285290ec03bb43d33` |
| `LonelyRunner/BadSixthDilate.lean` | `5031f198c72e9b248962d7c91c263a7d4b1f6d5d4c55a01fd927ab769d8e3b96` |
| `LonelyRunner/SmallSixthSeeds.lean` | `dcd429006413b0403dac4584355fa2ef2aebe4008aec69212ef1a1b707dd5b41` |
| `LonelyRunner/TwoOddOutsideThree.lean` | `6b2c9fb02bffe58cdd2383246c56dfca3f91fe3b88c1a2902486b4d90cae6735` |
| `LonelyRunner/RationalShiftOrbits.lean` | `cf615dd6c6b3cf091cd5d31ac641f4f994c1c50d95e0120c311d3ac129b88591` |
| `LonelyRunner/SmallDenominatorWitness.lean` | `1570a359100594f4a5589588e3b32674dc2d54d60e500df1d47aca64c2faf95f` |
| `LonelyRunner/FastRunnerInsertion.lean` | `dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5` |
| `LonelyRunner/StructuredClasses.lean` | `5328a7a88d2b42f86ffc3f0f0418ca22c761219e8fa3e5822bda5a18ac286e8c` |
| `LonelyRunner/OneEvenRunners.lean` | `5bf5f01d7b31b410b680d646a832b273890cc267dc7a4775fea37eac5c58b810` |
| `ML/Data/Finset/Card.lean` | `87c674ba5464c7868fb3e253e58a695821bf8841bb4e076bac5d570236dc6229` |
| `ML/Data/Nat/Prime/Defs.lean` | `617c1a2a927a2a282092f11c8d254036454e7ffa2eab12f8dd16880cf83d0d61` |
| `ML/Algebra/Order/Floor/Ring.lean` | `11f61aaf83c406b6b0accc6d34bdb4f77a1566fbdc63eae4d704728b9acf038c` |
| `Init/Data/Nat/Coprime.lean` | `05b67b9e50bb0b92ba80dc4a8074580c14a8bdcdbdc150486f4796d104c8426a` |
| `lean-toolchain` | `8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af` |
| `lake-manifest.json` | `887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218` |
| `research/astra-one-three-divisible-plan.md` | `9da230600af3a0a0bc8223de3daca2575f8d41f447142687ca64db53ced4ae9e` |
| `research/astra-one-three-divisible-review.md` | `8f720fbd8002918adaaa0d36fc7774c450eeb5dba84dd555552d24b5e57e6078` |
