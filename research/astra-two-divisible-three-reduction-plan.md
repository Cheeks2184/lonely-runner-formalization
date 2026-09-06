# Renault's two-divisible-three reduction: proposed dependency plan

The exactly-two branch has a coherent symbolic route. Its first implementation
milestone is the fast-speed adapter below. The principal new obligation is a
maximum of **two norms on an anchored fiber**, which permits maximum zero;
the existing strict-seeded complement maximizer does not supply that contract.
This document derives the intervening arithmetic and identifies the remaining
Lean work. It does not report a formalized Proposition 3.1 or a new runner count.

Owned file: this manuscript only. Requested route: Astra/xhigh; observed model
and effort are unavailable in focused state. Assigned checkpoint:
`01e34debf2f07b309d912da8fdb296a0a16c730f`. Project configuration, workflow,
policy and focused state were read; the structural validator passed. No Lean
execution, build, mathematical search, numerical experiment, certificate
generation, source edit, state write, Git operation or cache mutation occurred.
Direct primary-paper retrieval and scoped local source/API inspection were
read-only. The simultaneously authored three-divisible source is an integration
dependency, not verification evidence supplied by this task.

## Source and exact scope

The paper calls the result **Proposition 3.1**, not Lemma 3.1. Its proof is on
printed pages 95–96; Section 2 globally assumes positive natural speeds and
gcd one. It permits repetitions in the integer formulation and uses closed
sixth-margin safety. The relevant preceding results are the divisor-count
Lemma 2.1, fast-speed Lemma 2.2 and three-divisible Lemma 2.3. Its strategy uses
an anchored maximum, residue distinctions, and a final divisibility argument.
[Renault, *View-obstruction: a shorter proof for 6 lonely runners*, DOI
10.1016/j.disc.2004.06.008, Sections 2–3](https://compmath.wordpress.com/wp-content/uploads/2008/08/view-obstruction_a_shorter_proof_for_6_lonely-runners.pdf#page=3).

This is the cited primary paper hosted as a third-party PDF copy. No claim of
byte identity with the inaccessible publisher copy is made. The contracts,
folded-coordinate derivations and proposed decomposition below are my
mathematical reconstruction. They require independent review and kernel proofs.

Write `N(x)=circleNorm x`, `X_i(t)=Int.fract(t*v_i)` and
`W(v,t) := ∀ i, 1/6 ≤ N(t*v_i)` in the explanatory mathematics. All speeds are
natural; real casts in that prose are implicit. A bad phase means **strictly**
`N(x)<1/6`. Time is an arbitrary real until a positive-time conclusion is proved.

The proposed main counterexample-elimination declaration is exactly:

```lean
theorem false_of_primitive_no_sixth_witness_two_divisible_three
    (v : Fin 5 → ℕ) (hpos : ∀ i, 0 < v i)
    (hprimitive : Finset.univ.gcd v = 1)
    (htwo : ((Finset.univ : Finset (Fin 5)).filter
      (fun i => 3 ∣ v i)).card = 2)
    (hno : ¬ ∃ t : ℝ, ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ))) : False
```

This has no distinctness, upper-speed, strict-seed or full five-moving witness
premise. It is a proposed theorem, not an available declaration. A more modular
inner proof can replace `hprimitive` by the two facts `∃ i, 6 ∣ v i` and
`(univ.filter (fun i => 2 ∣ v i)).card ≤ 3`. Existing divisor-count theorems
supply those facts under `hprimitive,hno`. Only denominators 6 and 2 are needed
for this branch; the denominator-4 and denominator-5 cases are not dependencies.

Two intended final adapters, after that elimination is checked, are:

```lean
theorem fiveMovingNaturalRunners_of_two_divisible_three
    (v : Fin 5 → ℕ) (hpos : ∀ i, 0 < v i)
    (htwo : ((Finset.univ : Finset (Fin 5)).filter
      (fun i => 3 ∣ v i)).card = 2) :
    ∃ t : ℝ, 0 < t ∧ ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ))

theorem fiveMovingNaturalRunners_of_primitive_two_divisible_three
    (v : Fin 5 → ℕ) (hpos : ∀ i, 0 < v i)
    (hprimitive : Finset.univ.gcd v = 1)
    (htwo : 2 ≤ ((Finset.univ : Finset (Fin 5)).filter
      (fun i => 3 ∣ v i)).card) :
    ∃ t : ℝ, 0 < t ∧ ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ))
```

The first adapter's removal of primitivity needs the gcd argument in the final
section. The second splits count two from count at least three and uses the
previous independently reviewed branch for the latter. The exactly-two proof
itself does not call that branch, so this split introduces no circularity.

## First bounded implementation milestone: the fast-speed adapter

Implement only this declaration first, preserving the equality case:

```lean
theorem fiveMovingNaturalRunners_of_fast_speed
    (v : Fin 5 → ℕ) (hpos : ∀ i, 0 < v i) (p : Fin 5)
    (hfast : ∀ i, i ≠ p → 5 * v i ≤ v p) :
    ∃ t : ℝ, 0 < t ∧ ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ))
```

Complete derivation: set `old j = v (p.succAbove j)`. The checked
`fourMovingNaturalRunners` gives a positive `t₀` with all four old norms at
least `5⁻¹`. Apply the checked `fastRunnerInsertion` at `n=4`, old real speeds
`(old j : ℝ)`, and new speed `(v p : ℝ)`. Natural positivity proves the new
speed nonzero and removes the absolute values in its speed hypotheses;
`hfast` casts to exactly those hypotheses. The result is a real `u` where
the new norm and every old norm are at least `6⁻¹`. Reindex using the case
`i=p` and `Fin.exists_succAbove_eq` for the complement.

At `u=0`, the inequality for label p contradicts `N(0)=0`, so `u≠0`.
If `u>0`, retain u. Otherwise use `-u>0` and
`N((-u)*v_i)=N(-(u*v_i))=N(u*v_i)`. Thus positivity follows by reflection;
it is not assumed from the perturbation estimate. The initial positive seed
does not by itself prove that the perturbed time is positive. Repeated speeds
are retained. This proof uses no gcd, divisibility or strict-safety premise.

The exact existing insertion interface at `FastRunnerInsertion.lean:92` is:

```lean
theorem fastRunnerInsertion {n : ℕ} (speeds : Fin n → ℝ)
    (time₀ newSpeed : ℝ)
    (hold : ∀ i,
      (((n + 1 : ℕ) : ℝ)⁻¹) ≤ circleNorm (time₀ * speeds i))
    (hnewSpeed : newSpeed ≠ 0)
    (hfast : ∀ i,
      (((n + 1 : ℕ) : ℝ) * |speeds i|) ≤ |newSpeed|) :
    ∃ time : ℝ,
      |time - time₀| ≤ (((n + 2 : ℕ) : ℝ)⁻¹) / |newSpeed| ∧
      (((n + 2 : ℕ) : ℝ)⁻¹) ≤ circleNorm (time * newSpeed) ∧
      ∀ i, (((n + 2 : ℕ) : ℝ)⁻¹) ≤ circleNorm (time * speeds i)
```

A direct subsequent contrapositive is that `hno` implies, for each p, some
`i≠p` satisfies `v p < 5*v i`. Do not replace this by an unsupported ratio
claim between two selected speeds before the divisibility cover is established.

## Third-shift rescue statements still needed

Fix distinct labels p,q and the exact characterization
`3 ∣ v i ↔ i=p ∨ i=q`. Thus the remaining label subtype has cardinality three.
At any real t where p,q are closed-safe, consider
`B_i={k : Fin 3 | N((t+k.val/3)*v_i)<1/6}` for the other labels.
The checked separation and subsingleton theorems give `card B_i ≤ 1`.
The pair's norms are preserved by all these shifts.

Two new assembly lemmas are required:

1. **Two bad labels at the same seed.** If two distinct labels are bad at t,
   both of their bad sets are exactly `{0}`. The third bad set has at most one
   element. Their union has at most two elements, so a k in Fin3 avoids them
   all. This proves `∃ k : Fin 3, W(v,t+k.val/3)`. Bad labels cannot be p or q
   because those are safe. This is a collision argument for three bad sets;
   the existing at-most-two-exceptions theorem cannot be applied to all three
   labels directly. A sum bound of three would also be insufficient.
2. **One special anchor.** If a remaining r has
   `X_r(t) ∈ {1/6,1/2,5/6}`, its phase at every third shift stays in that set:
   adding `k*v_r/3` changes an odd sixth numerator by an even integer.
   Hence r forbids no shift. Apply the existing common-shift theorem to the
   other two nondivisible labels, preserving p,q and r. This gives the same
   existential conclusion with a single common k.

Each statement is uniform in arbitrary real t and positive natural v (indeed
positivity is unnecessary for these two conditional shift statements).
All three special phases are safe **at equality** where appropriate. Under
`hno`, the two conclusions become impossibilities. Both helpers return actual
shifts, rather than merely independent safe times for different labels.

For anchor comparisons, a separate exact transport helper is useful: if
`3 ∤ d` and `fract(t*d)` is one of those three phases, there is `k : Fin 3`
with `fract((t+k.val/3)*d)=5/6`. A direct symbolic proof writes
`d=3u+c`, `c∈{1,2}`, and the starting phase `(2r+1)/6`, `0≤r<3`.
Choose `k=((2-r)*c)%3`; since `c²≡1 (mod 3)`, `k*d≡2-r (mod 3)`.
No search for k is necessary. This helper needs exact fractional parts;
the existing rational-orbit **lower-bound** theorem does not imply it.

## The anchored maximum, with zero permitted

Proposed generic interface, independent of five runners or divisibility:

```lean
theorem exists_five_sixths_fiber_pair_maximizer
    (a b c : ℕ) (hc : 0 < c) :
    ∃ τ : ℝ, 0 < τ ∧ τ < 1 ∧
      Int.fract (τ * (c : ℝ)) = (5 : ℝ) / 6 ∧
      ∀ t : ℝ, Int.fract (t * (c : ℝ)) = (5 : ℝ) / 6 →
        min (circleNorm (t * (a : ℝ))) (circleNorm (t * (b : ℝ))) ≤
          min (circleNorm (τ * (a : ℝ))) (circleNorm (τ * (b : ℝ)))
```

Complete construction: for `j : Fin c`, put `t_j=(j.val+5/6)/c` and maximize
the displayed minimum over the nonempty finite type `Fin c` using
`Finset.exists_max_image`. Each `t_j` lies strictly between zero and one and
has anchor phase 5/6. For an arbitrary anchored t, put `s=fract t`.
Integer-time periodicity preserves every natural-speed norm and the anchor
phase. Since `0≤s<1` and `fract(c*s)=5/6`, write `c*s=n+5/6` with
`n=floor(c*s)`. The inequalities give `0≤n<c`, so n has a natural representative
in Fin c and `s=t_n`. The finite maximum therefore controls every real t,
including negative times. No positivity of the maximum is asserted.

This is a parametric finite-existence proof, not an instruction to enumerate
c candidates for an input speed. It needs neither an executed finite table nor
a strict complement seed. `circleNorm_fract_mul_nat` handles the norms; the
parallel equality of fractional parts follows by subtracting the integer
`floor(t)*c`. `Int.fract_eq_fract` is an exact available interface for that step.

For the two divisible labels and one nondivisible anchor r, let M denote this
maximum. The special-anchor rescue lemma and `hno` imply `M<1/6`. Norm
nonnegativity gives `M≥0`. If `M=0`, the objective is already zero throughout
the fiber. Otherwise exchange the two **labels**, if needed, so

    a = N(τ*v_p) = M,    b = N(τ*v_q) ≥ a,    0<a<1/6.

There is no reflection assumption about either fractional phase. The existence
of a speed divisible by 6 remains a disjunction between p and q after exchange.
The existing oriented complement maximizer is a different theorem: its domain
requires four safe labels, and its strict seed forces a positive objective.
Neither condition is assumed or obtained for this anchored fiber.

## Folded-coordinate scalar derivation

Two elementary general identities should be extracted as helpers. For each
real x, there are an integer z and a sign such that `x=z+N(x)` or `x=z-N(x)`.
Indeed, split its fractional part at 1/2 and use `circleNorm_eq_min_fract`.
Consequently, for natural n and integer β,

    N(n*x+β/2) = N(n*N(x)+β/2).

For the minus sign, negate the phase and then add the integer β. This proves
the identity for negative x and signed β as well. This half-shift identity
should not be generalized silently to arbitrary rational shifts.

For `0<a<1/6`, both `N(3a)=3a>a` and
`N(5a)=min(5a,1-5a)>a`. Times `3τ` and `5τ` have anchor phases 1/2 and 1/6.
The exact third-shift transport returns each to the maximum's fiber while
preserving the pair's norms. The maximum bound thus forces

    N(3b) ≤ a,       N(5b) ≤ a,       a ≤ b ≤ 1/2.

A compact new scalar contract is:

```lean
theorem two_divisible_folded_band (a b : ℝ)
    (ha0 : 0 < a) (ha6 : a < (1 : ℝ) / 6)
    (hab : a ≤ b) (hbhalf : b ≤ (1 : ℝ) / 2)
    (h3 : circleNorm (3 * b) ≤ a)
    (h5 : circleNorm (5 * b) ≤ a) :
    (1 : ℝ) / 8 ≤ a ∧ (11 : ℝ) / 30 < b ∧ b < (7 : ℝ) / 18
```

Complete proof: set `z=round(3b)`. The absolute-error formula gives
`|3b-z|≤a`. Since `0<3b≤3/2` and `a<1/6`, the integer z is 0 or 1.
It cannot be zero because `3b≥3a>a`. Hence
`1-a≤3b≤1+a`, and thus `5/18<b<7/18`.
Now `25/18<5b<35/18`. From `|5b-round(5b)|≤a` and `a<1/6`, the second
integer is strictly between 1 and 3, hence is 2. Therefore
`2-a≤5b≤2+a`. It follows that `b>(2-1/6)/5=11/30`.
Combining `3*(2-a)≤15b≤5*(1+a)` gives `1≤8a`.
This derivation uses two integer-band arguments, without a wrapped-interval
enumeration. The closed possibility `a=1/8` is retained.

In particular `1/8≤a<1/6` and `11/30<b<7/18`. Direct middle-band arithmetic
now gives the following inequalities. Each expression has norm strictly above
1/6; recording weak inequalities in a helper is sufficient for assembly.

| Folded phase a | Folded phase b |
| --- | --- |
| `2a` | `b` |
| `3a` | `2b` |
| `4a` | `4b` |
| `a+1/2` | `2b+1/2` |
| `2a+1/2` | `3b+1/2` |

For a, the respective ranges are `[1/4,1/3)`, `[3/8,1/2)`,
`[1/2,2/3)`, `[5/8,2/3)`, and `[3/4,5/6)`.
For b, they are `(11/30,7/18)`, `(11/15,7/9)`, `(22/15,14/9)`,
`(37/30,23/18)`, and `(8/5,5/3)`. These all lie strictly inside some
integer translate of `[1/6,5/6]`. In the third, fourth and fifth b ranges
that translate is `[7/6,11/6]`. `circleNorm_ge_of_int_band` with integer
band 0 or 1 proves the needed closed safety. The folded identity transfers
them to the actual possibly reflected pair phases.

## Residue distinctions and the zero-maximum consequence

Let `x=τ*v_p`, `y=τ*v_q`, `X_r(τ)=5/6`. The actual residues of p,q modulo 6
are 0 or 3, and at least one is 0. For r, choose a signed representative
`e_r∈{1,-1,2,-2}`. Integer phase transport under `s=ατ+β/6` is

    X_i(s) = fract(α*X_i(τ)+β*e_i/6).

This requires integer α,β and a congruence certificate `v_i=6z_i+e_i`;
negative e and β must be real/Int arithmetic, never truncated natural
subtraction. It follows by separating the integer
`α*floor(τ*v_i)+β*z_i`. For p or q, the sixth shifts are therefore either
integers or half integers, precisely the cases handled above.

The following symbolic cases contradict special-anchor rescue using the scalar
safe bands. Write `σ=1` when e is positive and `σ=-1` when it is negative.

| Residues `(e_p,e_q)` | Anchor residue | Time | Anchor phase | Safe pair phases modulo integers |
| --- | --- | --- | --- | --- |
| `(0,0)` | `e_r=σ` | `2τ+σ/6` | `5/6` | `2x,2y` |
| `(0,3)` | `e_r=σ` | `2τ+σ/6` | `5/6` | `2x,2y+1/2` |
| `(0,3)` | `e_r=2σ` | `3τ+σ/6` | `5/6` | `3x,3y+1/2` |
| `(3,0)` | `e_r=σ` | `2τ+σ/6` | `5/6` | `2x+1/2,2y` |
| `(3,0)` | `e_r=2σ` | `τ+σ/6` | `1/6` | `x+1/2,y` |

The last line needs no reflection to return to 5/6: the rescue lemma already
accepts 1/6. The shifts by `-1/2` and `1/2` differ by an integer. These are
fixed symbolic cases of this argument, not a proposed candidate search.

The only remaining case is `(e_p,e_q)=(0,0)` with r even. The even-count bound
forces the other two labels u,w to be odd: p,q,r already provide three
distinct even labels. At both `2τ` and `2τ+1/2`, p,q,r are safe. The pair's
safety follows from the table of scalar bands, and the anchor is 2/3 at both
times. By `hno`, choose u bad at `2τ`. Its half-shift is safe, since
`N(z+1/2)=1/2-N(z)` for every real z; hence w must be bad at `2τ+1/2`.

For any z with `N(z)<1/6`, one has `N(2z+1/2)>1/6`: folding z gives
`0≤N(z)<1/6`, so `1/2≤2N(z)+1/2<5/6`. Apply this first to u's phase at
`2τ` and then to w's phase at `2τ+1/2`. At time `4τ+1/2`, oddness makes
their resulting phases exactly these expressions modulo integers; the latter
has an extra integer which does not change its norm. Thus both are safe.
The pair has phases `4x,4y` and the anchor has phase 1/3, also safe.
This contradicts `hno`. No assumption that a runner safe at one of the earlier
times remains safe later is used.

Every possible residue case contradicts `M>0`. Therefore `M=0`, and the maximum
bound implies that **every** anchored time has at least one zero pair norm.
There is no unresolved mathematical case in this calculation, but its scalar,
transport and finite-label assembly lemmas remain unimplemented here.

An exact proposed interface for that key consequence is:

```lean
theorem two_divisible_boundary_min_eq_zero
    (v : Fin 5 → ℕ) (hpos : ∀ i, 0 < v i)
    (p q r : Fin 5) (hpq : p ≠ q) (hrp : r ≠ p) (hrq : r ≠ q)
    (hdiv : ∀ i, 3 ∣ v i ↔ i = p ∨ i = q)
    (hsix : 6 ∣ v p ∨ 6 ∣ v q)
    (heven : ((Finset.univ : Finset (Fin 5)).filter
      (fun i => 2 ∣ v i)).card ≤ 3)
    (hno : ¬ ∃ t : ℝ, ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ)))
    (t : ℝ) (ht : Int.fract (t * (v r : ℝ)) = (5 : ℝ) / 6) :
    min (circleNorm (t * (v p : ℝ)))
      (circleNorm (t * (v q : ℝ))) = 0
```

## Divisibility, final ratio contradiction, and count adapters

For each remaining r, evaluate the zero-minimum conclusion at
`t=-1/(6*v_r)`. Positive `v_r` makes this well-defined and gives anchor phase
5/6. One of `N(v_p/(6*v_r))`, `N(v_q/(6*v_r))` vanishes, using norm
reflection. For positive natural Q, `N(A/Q)=0` implies `Q∣A`:
if not, `one_le_cyclicResidueDistance_of_not_dvd` followed by
`circleNorm_nat_div_ge` gives `0<1/Q≤N(A/Q)`, a contradiction.
This supplies the new small helper without assuming a fractional-quotient
integer equivalence or mishandling the negative test time. Consequently

    for each of the three remaining labels r,
    6*v_r divides v_p or 6*v_r divides v_q.

Assign each of those three **labels** to one of the two divisibility choices.
Pigeonhole gives two distinct labels, say u,w, assigned to the same pair speed,
called A. Call the other pair speed B and the remaining outside speed C.
Thus `6*v_u∣A`, `6*v_w∣A`, and `6*C∣A` or `6*C∣B`.
Positive divisibility yields the corresponding inequalities.

If `A≥5B`, then A is at least five times every other speed: u,w are bounded
by A/6, and C is bounded by A/6 or B/6. The fast-speed adapter contradicts
`hno`. The same reasoning with `B≥5A` gives the other contradiction, even
though u,w were assigned to A. Therefore `A<5B` and `B<5A`.

Set `t₀=1/(6A)`. Speed A is at its lower boundary, while u,w have phases in
`(0,1/36]` and are both bad. If B is safe, the two-bad-label rescue is already
a contradiction. Otherwise `0<B/(6A)<5/6`, using `B<5A`, and badness implies
`B/(6A)<1/6`. The other ratio gives `B/(6A)>1/30`.
At `5t₀`, A is at 5/6, B is strictly between 1/6 and 5/6, and u,w have
phases in `(0,5/36]`, hence remain strictly bad. The same rescue contradicts
`hno`. The position of C is unrestricted; the common shift handles it.

To remove primitivity for the **exactly-two** adapter, let
`g=Finset.univ.gcd v` and `w_i=v_i/g`. Positivity and `Finset.gcd_ne_zero_iff`
give `g>0`; `Finset.gcd_dvd` gives `v_i=g*w_i`, so each w_i is positive.
The checked library interface `Finset.gcd_div_eq_one` gives `gcd w=1`.
An outside label exists because only two of five are divisible by 3. Hence
`3 ∤ g`. Primality of 3 and `v_i=g*w_i` give `3∣v_i ↔ 3∣w_i`, preserving
the count exactly, even with repeated speeds. Apply the primitive elimination
to w by contradiction. A real witness is nonzero and can be reflected to a
positive witness s. Then `s/g>0` witnesses v, using
`circleNorm_div_time_mul_scale`. The existing sorted primitive normalization
requires injectivity and performs translation; it is not the right adapter.

For primitive count at least two, split the count into exactly two or at least
three. In the latter case call the separately reviewed
`fiveMovingNaturalRunners_of_primitive_three_divisible_three` only after that
source is verified. In the former use the new branch. No full Fin5 sixth-margin
theorem is assumed in either direction. An unqualified at-least-two statement
including all-five-divisible tuples would still contain the full unresolved
five-moving sixth problem by scaling every speed by 3; do not promote this
primitive reduction to that statement.

## Implementation sequence and actual API map

The first fast-speed adapter is a separate small source milestone with its
complete derivation above. After it, keep the remaining proof in these bounded
pieces; each needs a source-specific universal-type/axiom check at a later
authorized verification checkpoint.

| Piece to implement | Exact responsibility and checked ingredients |
| --- | --- |
| Third-shift rescue | Three singleton bad sets with two colliding at zero; boundary anchor forbids none. Use `ThirdShiftSpacing:9`, `SeparatedPhaseFamily:15`, `ThirdShiftExceptions:14`, and `ModularCertificates:33`. |
| Phase transport | Integer affine phase equality, signed mod-six representatives, special-anchor third shift to 5/6, half-shift norm identity. Existing `RationalShiftOrbits:44` gives norm preservation for natural reciprocal shifts only; signed exact fractional transport needs the new helper. |
| Fiber maximum | The exact generic declaration above, with no strict seed. Use `PivotBoundary:169`, `Int.fract_eq_fract`, and `Finset.exists_max_image`. |
| Folded scalar arithmetic | Integer/sign lift, integer-dilation half-shift identity, folded band theorem, and the listed safe bands. Use `FastRunnerInsertion:17,25`, `ConstrainedMaximizer:16`, and `StructuredClasses:14,28`. |
| Boundary zero | Integrate the maximum, the five displayed residue cases and the both-even case. Use the explicit divisor/count hypotheses; no seed or Renault 5.1 call. |
| Divisibility and ratios | Norm-zero divisibility, three-label/two-choice pigeonhole, final two rational times, rescue. Use `SmallDenominatorWitness:16`, `PivotResidues:102`, and the newly checked fast-speed wrapper. |
| Count and gcd adapters | Extract exactly two labels and their three-label complement; supply denominator-6 lower and denominator-2 upper facts via `SixTotalDivisorCounts:57`; positive gcd division, then the primitive at-least-two split. |

`Finset.card_eq_two` and `card_eq_three` are at
`Mathlib/Data/Finset/Card.lean:782,788`; they provide distinct **labels**.
`Finset.exists_max_image` is at `Mathlib/Data/Finset/Max.lean:528`.
`Int.fract_eq_fract`, `fract_eq_zero_iff` and `fract_neg` are at
`Mathlib/Algebra/Order/Floor/Ring.lean:444,460,466` respectively.
`Finset.gcd_dvd`, `gcd_ne_zero_iff`, and `gcd_div_eq_one` are at
`Mathlib/Algebra/GCDMonoid/Finset.lean:141,193,259`.
Natural division and primality interfaces are already used by the inspected
`RationalShiftGcd` and `ThirdShiftSpacing` sources. These locations were read,
not guessed from theorem names.

The reviewed constrained maximizer's positive objective and actual upper-face
label are useful in later branches, but they do not remove this fiber lemma.
Its `reciprocal_dilate_shift_improves` also assumes `N∣d`, so instantiating
N=6 for an odd multiple of 3 would be invalid, even when the selected shift
numerator is zero. The folded scalar proof handles that situation directly.
The already checked `renault_phase_five_one` concerns a different three-phase
alternative and is not needed here. No expansion to Renault 6.1/6.4, parity
Proposition 4.1, candidate-family experiment or finite certificate is proposed.

No finite arithmetic check is required by this plan. The two anchor residues
modulo 3 and the displayed residue distinctions can be proved by symbolic
integer decompositions and bounded natural inequalities. Any later decision
to replace these proofs by finite certificates would require a separately
reviewed exact domain and continuum bridge; none was run or prepared here.

## Static provenance and disposition

Source bindings below identify the inspected interfaces at this manuscript
checkpoint. The shared helpers `SeparatedPhaseFamily`, `ThirdShiftSpacing` and
`ThirdShiftExceptions` are bound below. The concurrently authored runner
assembly files `ThirdShiftSeed` and `ThreeDivisibleRunners` are not bound;
the latter was read as a draft interface. The accepted prior contract review
is separately bound. No `.olean` or build result is claimed.

```text
dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5  LonelyRunner/FastRunnerInsertion.lean
662d0116f13971bce85e76c503e2f3be4fdc6291ba8113aeda43957e38354ffe  LonelyRunner/FiveRunnerOrdinary.lean
5328a7a88d2b42f86ffc3f0f0418ca22c761219e8fa3e5822bda5a18ac286e8c  LonelyRunner/StructuredClasses.lean
0e56cab74d30ef8b537ed4ec24503aae875bd8aadc369d26da99ba882cc3603f  LonelyRunner/PivotBoundary.lean
2ef07e6b83b8675a22184571c31d2a71dab9d5c072e3cd165cb8382957b46e92  LonelyRunner/ConstrainedMaximizer.lean
cf615dd6c6b3cf091cd5d31ac641f4f994c1c50d95e0120c311d3ac129b88591  LonelyRunner/RationalShiftOrbits.lean
6e9d1e3e084188a651e4c875cf36fd5d6fc7cbd5f1914784019a207a0cec01f4  LonelyRunner/RationalShiftGcd.lean
6ab6e77e8f5edcdc2a2d242fb2616327004b376496616f46896303a06876db23  LonelyRunner/RationalShiftInsertion.lean
0b62ef724eb8c24db4085e247e9f16f650ec450291c7ccac2b0ad0981f148727  LonelyRunner/SixTotalDivisorCounts.lean
1570a359100594f4a5589588e3b32674dc2d54d60e500df1d47aca64c2faf95f  LonelyRunner/SmallDenominatorWitness.lean
362da5ab923f22e900ae7ac821dd4cf4aab91dfe70889987bc9e5a05d19c276a  LonelyRunner/PivotResidues.lean
28c5db2425eef754156e57c284959ff02da743f1fde424e053c4eae0c721b6bd  LonelyRunner/SeparatedPhaseFamily.lean
146cdfd80495aced0eb93bc322559cf7e950a80b0d01534b2a57cce7129debaa  LonelyRunner/ThirdShiftSpacing.lean
85590988cd0e104dc93fd51bc79aa326fe2799974eae426b7ea3336853872073  LonelyRunner/ThirdShiftExceptions.lean
8b7e9dc5be1236acb812607c19454fe43ecd1333145aef675e7df8e6d0c3871c  LonelyRunner/ModularCertificates.lean
20193ad984f308ce8512930fe683d3118a2b3b5c18636a6a1f4454aa6df43797  LonelyRunner/Normalization.lean
cac3351bf8c755c0bd354d0330e766f49c255d7ef21637d0975a8d8633cd94b0  LonelyRunner/PrimitiveTupleNormalization.lean
1ceac85438299dffdd48d57fb0052b598a9bd5eda995cabff0256885529d89cb  LonelyRunner/RenaultPhaseLemma.lean
87c674ba5464c7868fb3e253e58a695821bf8841bb4e076bac5d570236dc6229  .lake/packages/mathlib/Mathlib/Data/Finset/Card.lean
6a67c04a5ad263999707cf927121c15edf11bd66f7b5b48652c0e0e660a0d58c  .lake/packages/mathlib/Mathlib/Data/Finset/Max.lean
11f61aaf83c406b6b0accc6d34bdb4f77a1566fbdc63eae4d704728b9acf038c  .lake/packages/mathlib/Mathlib/Algebra/Order/Floor/Ring.lean
e0e320bd1f4a5a9e79da9fde6e2e3691ebbbccea8a4fba5765bda3b56e715568  .lake/packages/mathlib/Mathlib/Algebra/GCDMonoid/Finset.lean
981748f0e5377735fdd43c3109c7011b33ea7a0d75272e9e371aedb443229eb9  research/astra-three-divisible-shift-plan-review.md
```

The initial and final workflow validators establish structural consistency
only. The intended unrestricted project goal remains active. The first
milestone is settled mathematics suitable for immediate implementation; the
remaining exact contracts and reconstructed branch need independent manuscript
review followed by implementation and kernel verification. Canonical six-total,
the stronger lower-count margin required by H8, and unrestricted LRC remain
unproved by this document.
