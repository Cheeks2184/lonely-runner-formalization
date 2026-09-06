# Exactly one speed divisible by three: manuscript and implementation contract

Status: author derivation, awaiting independent mathematical review and Lean
implementation. This report proposes a proof for one restricted five-moving
branch. It does not claim a checked new runner count or the unrestricted Lonely
Runner Conjecture. The author owns only this report. No Lean invocation, source
implementation, numerical experiment, candidate search, solver, cache operation,
state edit, or Git operation was performed for this task.

## 1. Target, source scope, and reduction

Write `N x = circleNorm x`, `f x = Int.fract x`, and `δ = 1/6`.
All norms below are quotient-circle norms. “Safe” means `δ ≤ N x`;
“strictly safe” means `δ < N x`. Weakly bad means `N x ≤ δ`, whereas the
complement of safe is strictly bad, `N x < δ`. These are different sets.

The proposed public endpoint is exactly:

```lean
theorem fiveMovingNaturalRunners_of_one_three_divisible
    (v : Fin 5 → ℕ) (hpos : ∀ i, 0 < v i)
    (hprimitive : Finset.univ.gcd v = 1)
    (hone : ((Finset.univ : Finset (Fin 5)).filter
      (fun i => 3 ∣ v i)).card = 1) :
    ∃ t : ℝ, 0 < t ∧ ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ))
```

This is a proposed declaration, not existing source. No injectivity or ordering
of `v` is assumed. The proof treats labels throughout, so equal speeds are
allowed.

Primary source: J. Renault, *View-obstruction: a shorter proof for 6 lonely
runners*, Discrete Mathematics 287 (2004), 93–101,
[DOI 10.1016/j.disc.2004.06.008 and primary PDF](https://compmath.wordpress.com/wp-content/uploads/2008/08/view-obstruction_a_shorter_proof_for_6_lonely-runners.pdf).
Section 2, printed p.94, assumes positive integers with gcd one. Under a missing
witness, Lemma 2.1 bounds divisor counts. The relevant parity branches are
Proposition 4.1 (p.96), Proposition 5.4 (p.98), and Proposition 6.6 (p.100).
Lemma 5.1 (p.97) has three unit-weight phases; Lemma 6.1 (p.99) has weights
`(2,1,1)`; Lemma 6.4 (pp.99–100) assumes three initially safe phases and has
different strict alternatives. Lemmas 5.2–5.3 and 6.2–6.3/6.5 transport signs.
The argument below makes the finite geometry, orbit step, and endpoint logic
explicit; the three-even orbit proof is given directly rather than relying on
an implicit claim about composite residues.

Assume, for contradiction, the absence of an **all-real closed** witness:

```lean
hno : ¬ ∃ t : ℝ, ∀ i,
  (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ))
```

The singleton filter gives a label `p` with `3 ∣ v i ↔ i = p`. Apply the checked
`six_total_divisor_count_bounds` at `ell = 6`: some label is divisible by six,
so it is `p` and `6 ∣ v p`. Apply the same theorem at `ell = 2`: the number of
even labels is one, two, or three. The lower count theorem is used only at
denominators at most six; its upper count statement is not silently extended
to a stronger lower bound. Primitive normalization is used here, not inside
the three normalized parity proofs below.

Prove an all-real witness first. Such a witness cannot occur at zero since
`δ > 0`. If its time is negative, negate it and use `N(-x)=N x`. This gives the
strictly positive time in the endpoint. None of the contradiction arguments
requires an intermediate affine time to be positive.

No theorem about two or more three-divisible labels is used. Newly compiling
two-divisible normalization modules reported by the root are not dependencies
of this manuscript and are not represented as independently reviewed here.

## 2. Existing checked interfaces used without redesign

The following statements were read in their current source files. Their exact
file hashes are bound in section 11. This task did not rebuild or re-probe them.

* `six_total_divisor_count_bounds` in `SixTotalDivisorCounts.lean` takes positive `Fin 5`
  natural speeds, gcd one, the all-real `hno`, and `2 ≤ ell ≤ 6`, and returns
  `1 ≤ card(divisible ell)` and `card(divisible ell) ≤ 3`.
* `renault_phase_five_one (x : Fin 3 → ℝ)` in `RenaultPhaseLemma.lean` returns either a
  common `2 ≤ a ≤ 5`, `1 ≤ b ≤ 5` with all `N(a*x j+b/6) ≥ δ`, or a common
  `b = 1 ∨ b = 2 ∨ b = 4` with all `N(x j+b/6) > δ`. It accepts arbitrary real
  phases. It is not the mixed-weight Lemma 6.1 or the initially-safe Lemma 6.4.
* `fourMovingNaturalRunners` in `FiveRunnerOrdinary.lean` takes positive `Fin 4` natural
  speeds, including repetitions, and returns a positive common time with
  margin `1/5`. For a deleted label use `fun j : Fin 4 => v (p.succAbove j)`.
  Since `1/6 < 1/5`, this supplies the strict complement seed below.
* `exists_oriented_complement_maximizer` in `ConstrainedMaximizer.lean`, specialized to
  `δ`, supplies `0 < τ < 1`, safe complement, a bound against **all real**
  complement-safe times, `0 < f(τ*v p) < δ`, equality of that phase and its
  norm, and an actual other label `r` with `f(τ*v r)=5/6`. Its hypotheses are
  positive speeds, `0 < δ < 1/2`, a strict complement seed, and `hno`.
* `exists_forward_complement_improvement` requires `f(s*v p)<1/2` and actual
  other phases in `[δ,1-δ)`. It then supplies a positive increment preserving
  the safe complement and strictly increasing the pivot norm. A lower face is
  permitted; an upper face is not. Its conclusion does not require `s > 0`.
* `reciprocal_dilate_shift_improves`, with `N=6`, takes `6 ∣ v p`,
  `2 ≤ a < 6`, an **integer** numerator `b`, and the positive pivot phase
  below `1/6`, and strictly improves its norm at `a*τ+b/6`.
* `fract_sixth_affine_time` in `SixthAffinePhase.lean` transports actual times through
  `d = 6*z+e`, with integer `a,b,z,e`. The companion residue theorem gives
  `e ∈ {1,-1,2,-2}` for `3 ∤ d`. Parity distinguishes the two pairs.
* `circleNorm_add_half` in `FoldedCirclePhase.lean` gives `N(x+1/2)=1/2-N x`.
  Its integer-half and integer-lift lemmas also handle natural multiplication
  and signed phase representatives.
* `circleNorm_sub_le_add` in `SeparatedPhaseFamily.lean` and
  `circleNorm_bad_subsingleton_of_separated`, together with
  `circleNorm_third_shift_sub_ge` in `ThirdShiftSpacing.lean`, give at most one strictly
  bad third shift for a speed not divisible by three. The latter has arbitrary
  real phase and distinct `Fin 3` indices.
* `exists_nat_coprime_grid_circleNorm_ge` in `RationalShiftOrbits.lean` and the reduced
  mesh theorem in `RationalShiftGcd` give large-norm orbit points. They do not
  directly give the prescribed phase band required in section 8. The same
  reduced coprime-orbit argument supports that new lemma.
* `circleNorm_time_add_nat_div_of_dvd` in `RationalShiftOrbits.lean` preserves norms at
  natural reciprocal shifts for divisible speeds. Signed sixth shifts in the
  maximum argument also require the integer-periodicity/affine identity above.
* `fiveMovingNaturalRunners_of_fast_speed` in `FiveMovingFast.lean` requires one speed
  at least **five times every other labelled speed**. Knowing only that the
  pivot dominates the two odd speeds does not meet this contract. We do not
  invoke it under that weaker information.

Useful exact maximum adapter, proposed only to package existing APIs:

```lean
theorem exists_one_sixth_complement_maximizer
    (v : Fin 5 → ℕ) (hpos : ∀ i, 0 < v i) (p : Fin 5)
    (hno : ¬ ∃ t : ℝ, ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ))) :
    ∃ τ : ℝ, 0 < τ ∧ τ < 1 ∧
      ComplementSafe v p ((1 : ℝ) / 6) τ ∧
      (∀ t : ℝ, ComplementSafe v p ((1 : ℝ) / 6) t →
        circleNorm (t * (v p : ℝ)) ≤ circleNorm (τ * (v p : ℝ))) ∧
      0 < Int.fract (τ * (v p : ℝ)) ∧
      Int.fract (τ * (v p : ℝ)) < (1 : ℝ) / 6 ∧
      Int.fract (τ * (v p : ℝ)) = circleNorm (τ * (v p : ℝ)) ∧
      ∃ r, r ≠ p ∧ Int.fract (τ * (v r : ℝ)) = (5 : ℝ) / 6
```

## 3. Scalar dilation and six-grid geometry

These are symbolic interval arguments; no finite table or experimental result
is being assumed. They can be implemented as small exact real-interval lemmas.

### 3.1 A strictly safe phase has a bad dilation

For every real `x`, if `δ < N x`, there is `a ∈ {2,3,4,5}` with `N(a*x)<δ`.
Put `u=N x`, so `1/6<u≤1/2`. An integer lift and a possible sign change reduce
`N(a*x)` to `N(a*u)`. Choose by this exhaustive ordered partition:

| Condition after preceding cases failed | Choose `a` | Strict interval for `a*u` |
| --- | --- | --- |
| `u < 7/30` | 5 | `(5/6,7/6)` |
| `u < 7/24` | 4 | `(5/6,7/6)` |
| `u < 7/18` | 3 | `(5/6,7/6)` |
| `u < 13/30` | 5 | `(11/6,13/6)` |
| otherwise | 2 | `(5/6,7/6)` |

For rows two through five the previous failed comparisons provide respectively
`u≥7/30`, `u≥7/24`, `u≥7/18`, and `u≥13/30`; each makes the displayed lower
inequality strict. The last upper bound uses `2*u≤1<7/6`. All threshold ties
therefore go to a row with strict output. The first three and last rows are
within `1/6` of the integer one; the fourth is within `1/6` of two.

### 3.2 Bad sixth-shift sets

Work modulo six on integer indices and define
`B(x)={b : 0≤b<6 | N(x+b/6)<δ}`. Normalize `f x∈[0,1)`.
If `k/6 < f x < (k+1)/6`, then
`B(x)={-k-1,-k} mod 6`; if `f x=k/6`, then `B(x)={-k} mod 6`.
This follows by writing `N y<δ` as the existence of an integer within the
strict distance `δ`, then comparing the consecutive sixth-grid positions.
In particular `B` has at most two elements; two elements are cyclically
adjacent. Grid endpoints produce a singleton, not two bad points.

On `L={1,2,3,4,5}`, the bad set for `N(x+2*b/6)` is contained in one of
`{1,4}`, `{2,5}`, `{3}` (or is empty). Indeed the three residue classes modulo
three are separated by `1/3=2δ`, so two distinct classes cannot both be
strictly bad. Signs on a weight reflect the index set and preserve these facts.

If `N(y-z)≤δ`, the union `B(y)∪B(z)` lies in an open circular arc of length at
most `1/2`: choose lifts of their centers with separation at most `δ` and
include their two radius-`δ` open arcs. Such an open arc contains at most three
sixth-grid positions, cyclically consecutive. On `L` the union therefore has
at most two elements or is one of `{1,2,3}`, `{2,3,4}`, `{3,4,5}`. Each latter
set has complement respectively `{4,5}`, `{1,5}`, `{1,2}`, none contained in a
single doubled-weight bad class. Consequently, for every real `u`,

`N(y-z)≤δ ⇒ ∃b∈L, N(u+2b/6)≥δ ∧ N(y+b/6)≥δ ∧ N(z+b/6)≥δ`.       (CLOSE)

The arc is open even when its length equals `1/2`, so it cannot contain four
sixth-grid points. This is the endpoint fact needed in CLOSE.

### 3.3 Three phases covering all six bad positions

If three phases have no common safe shift among `b=0,...,5`, their three
`B` sets cover six indices. Since each has at most two elements, all three
are disjoint two-element cyclic edges. A perfect matching of the six-cycle
must be `{01,23,45}` or `{12,34,50}`: choose the edge incident to zero, after
which the remaining path forces the two other edges. Applying the exact
formula in 3.2, the three phases lie strictly in the three even sextants, one
per sextant, or strictly in the three odd sextants, one per sextant. No phase
can be a grid endpoint. This deduction also proves that repeated phases cannot
satisfy the premise.

## 4. Mixed-weight three-phase lemma: complete derivation

The new scalar contract has arbitrary real phases with weights `(2,1,1)`:

```lean
theorem renault_phase_six_one (x : Fin 3 → ℝ) :
    (∃ a b : ℕ, 2 ≤ a ∧ a ≤ 5 ∧ 1 ≤ b ∧ b ≤ 5 ∧
      ∀ j, (1 : ℝ) / 6 ≤ circleNorm
        ((a : ℝ) * x j +
          (if j = 0 then (2 : ℝ) else 1) * (b : ℝ) / 6)) ∨
    (∃ b : ℕ, 1 ≤ b ∧ b ≤ 4 ∧
      ∀ j, (1 : ℝ) / 6 < circleNorm
        (x j + (if j = 0 then (2 : ℝ) else 1) * (b : ℝ) / 6))
```

Normalize the phases and denote them `u,y,z`, with `u` of weight two. Assume
both alternatives fail. For every `a=2,...,5`, CLOSE forces
`N(a*(y-z))>δ`. Section 3.1 implies `N(y-z)≤δ`. Equality is impossible at
`a=5`, and `N(y-z)≤1/12` is impossible at `a=2`. Hence

`1/12 < N(y-z) < 1/6`, and `1/6 < N(2*(y-z)) < 1/3`.            (D)

Put `U=f(2u), Y=f(2y), Z=f(2z)` and
`A=(B(Y)∪B(Z))∩L`. The failure at slope two requires the doubled-weight bad
set for `U` to contain `L\A`, so `|A|≥3`. Also `|A|≤4`.

If `|A|=3`, its complement must be `{1,4}` or `{2,5}`. Thus `A={2,3,5}` or
`{1,3,4}`. For the former, one phase lies in `(1/2,2/3)` (its bad pair is
`{2,3}`), the other in `(0,1/6]` (its only bad element in `L` is 5). Their
circle distance is greater than `1/3`, contradicting (D). In the latter the
corresponding intervals are `(1/3,1/2)` and `[5/6,1)`, again with distance
greater than `1/3`. The possible singleton endpoint was retained in each case.

If `|A|=4`, both bad sets contribute disjoint adjacent pairs in `L`. The
possible unions are `{1,2,3,4}`, `{1,2,4,5}`, and `{2,3,4,5}`. The middle one
forces phases in `(2/3,5/6)` and `(1/6,1/3)`, again distance greater than
`1/3`. This leaves the following two cases, with `y,z` interchanged if needed.

Case A: `A={1,2,3,4}`. Then

* `Y∈(2/3,5/6)`, `Z∈(1/3,1/2)`;
* failure at `b=5` gives `U∈(1/6,1/2)`;
* `u∈(1/12,1/4) ∪ (7/12,3/4)`;
* `y∈(1/3,5/12) ∪ (5/6,11/12)`;
* `z∈(1/6,1/4) ∪ (2/3,3/4)`.

The condition `N(y-z)<1/6` forces `y,z` into their two lower intervals
together or their two upper intervals together. Mixed choices have distance
greater than `1/6`. Each row below gives one shared **strict** slope-one shift:

| `y,z` intervals | `u` interval | `b` |
| --- | --- | --- |
| both lower | lower | 1 |
| both lower | upper | 2 |
| both upper | lower | 4 |
| both upper | upper | 3 |

For example, in the first row `u+1/3∈(5/12,7/12)`,
`y+1/6∈(1/2,7/12)`, and `z+1/6∈(1/3,5/12)`.
For the second row the doubled-weight phase modulo one is in `(1/4,5/12)`;
the two unit-weight phases are in `(2/3,3/4)` and `(1/2,7/12)`.
For the upper pair, shifts three and four put the unit-weight phases in
`(1/3,5/12),(1/6,1/4)` and `(1/2,7/12),(1/3,5/12)` respectively.
The corresponding doubled-weight phases are `u` for shift three and
`u+1/3` modulo one for shift four. They are strictly safe in the stated rows.

Case B: `A={2,3,4,5}`. Here

* `Y∈(1/2,2/3)`, `Z∈(1/6,1/3)`, `U∈(1/2,5/6)`;
* `u∈(1/4,5/12) ∪ (3/4,11/12)`;
* `y∈(1/4,1/3) ∪ (3/4,5/6)`;
* `z∈(1/12,1/6) ∪ (7/12,2/3)`.

Again (D) forces both unit-weight phases into their lower intervals or both
into their upper intervals. For both lower, choose `b=3` if `u` is lower and
`b=2` if `u` is upper: the doubled-weight phases are respectively `u` and a
phase in `(5/12,7/12)`, while the unit phases are strictly safe.
For both upper, the two unit phases at `b=4` are strictly safe. The assumed
failure of that strict alternative forces `u∈(3/4,5/6]`: the lower interval
would be strictly safe, and the upper interval is weakly bad after adding
`4/3` exactly when `u≤5/6`. Therefore

`f(4u)∈(0,1/3]`, `f(4y)∈(0,1/3)`, `f(4z)∈(1/3,2/3)`.

At slope four and shift one, adding `1/3` to the first and `1/6` to the other
two gives a closed safe triple. This contradicts the first alternative's
failure. The retained `u=5/6` endpoint gives a safe phase and is not discarded.

All cases contradict failure. Normalizing arbitrary inputs loses nothing:
integer slopes commute with fractional normalization up to an integer.

## 5. Initially-safe three-phase lemma: complete derivation

The second new scalar contract is:

```lean
theorem renault_phase_six_four (x : Fin 3 → ℝ)
    (hx : ∀ j, (1 : ℝ) / 6 ≤ circleNorm (x j)) :
    (∀ j, (1 : ℝ) / 6 < circleNorm (2 * x j)) ∨
    (∃ b : ℕ, (b = 1 ∨ b = 5) ∧
      ∀ j, (1 : ℝ) / 6 < circleNorm (x j + (b : ℝ) / 6)) ∨
    (∃ a b : ℕ, (a = 3 ∨ a = 5) ∧ b ≤ 5 ∧
      ∀ j, (1 : ℝ) / 6 ≤
        circleNorm ((a : ℝ) * x j + (b : ℝ) / 6))
```

The natural `b` in the third alternative includes zero. Normalize the initial
phases into `[1/6,5/6]` and assume all alternatives fail. Failure of strict
doubling gives a phase `m∈[5/12,7/12]`. Failure at shift one gives a phase
`h∈[2/3,5/6]`; failure at shift five gives `l∈[1/6,1/3]`. These three closed
intervals are pairwise disjoint, so the phases belong to three distinct labels
and exhaust them, even though repeated input phases were allowed originally.

At slope three, the middle phase has fractional part in `[1/4,3/4]`, hence is
safe. Failure at shift zero forces the low phase to be strictly bad near one
(including fractional part zero), or the high phase strictly bad near zero.
The absence of every safe sixth shift allows section 3.3 to be applied to
these three tripled phases. In particular no tripled phase is a grid endpoint.

If the low phase is bad near one, its tripled phase lies in sextant five. The
matching is the odd-sextant matching; the high phase has its tripled phase in
`(1/6,1/3)` and the middle phase in `(1/2,2/3)`. Consequently

`l∈(5/18,1/3]`, `m∈(1/2,5/9)`, `h∈(13/18,7/9)`.

These imply
`f(5l)∈(7/18,2/3]`, `f(5m)∈(1/2,7/9)`,
`f(5h)∈(11/18,8/9)`. Subtracting `1/6`, equivalently taking `(a,b)=(5,5)`,
makes all three safe. The weaker closed upper bound for `l` is harmless.

If the high phase is bad near zero, its tripled phase lies in sextant zero.
The matching is the even-sextant matching, forcing

`l∈(2/9,5/18)`, `m∈(4/9,1/2)`, `h∈[2/3,13/18)`.

Thus `f(5l)∈(1/9,7/18)`, `f(5m)∈(2/9,1/2)`,
`f(5h)∈[1/3,11/18)`. Adding `1/6`, or `(a,b)=(5,1)`, makes all three safe.
Both cases contradict the failure of the third alternative. Endpoint zero
in the preliminary split does not create an omitted case: it is ruled out
by the matching consequence before the open sextant bounds are used.

## 6. Signed transport and the one-even branch

For weights `w j∈{1,2}` and integer signs `e j∈{1,-1}`, apply any unsigned
phase lemma to `e j * x j`. The identity

`N(a*(e j*x j)+w j*b/6) = N(a*x j+e j*w j*b/6)`

follows from norm invariance under multiplication by the sign. For the
reflected version apply it to `-e j*x j` and replace `b` by `6-b`; the two
resulting phases differ by an integer after an overall sign. This maps the
strict set `{1,2,4}` to `{2,4,5}`, and `{1,2,3,4}` to `{2,3,4,5}`. It maps
`{1,5}` to itself. For the third alternative of section 5, simply keep the
unreflected signed lemma so zero stays in the natural range `0≤b≤5`.

Here and below natural multipliers and integer signs must be cast separately;
there is no natural subtraction used for `-1`, `6-b` is used only with an
explicit bound on `b`, and negative real input phases are normalized only
through proved integer periodicity.

Suppose `6 ∣ v p`, `p` is the only three-divisible label and also the only
even label. All other residues have sign `e i=±1`. Obtain the maximum adapter
from section 2, write `m=f(τ*v p)∈(0,δ)`, and let `r≠p` be its upper face.
Set `σ=e r` and `t'=τ+σ/6`. Then

`f(t'*v r)=0`, and `f(t'*v p)=m`.

This uses `σ*e r=1` and `6 ∣ v p`; it does not confuse a norm with an oriented
phase. The remaining three labels can be reindexed as `Fin 3`. Apply the
signed checked `renault_phase_five_one` to their phases at `t'`, using its
reflected version when `σ=-1`.

For a returned closed slope `2≤a≤5`, put `s=a*t'+b/6`. The three labelled
phases are safe by the common candidate; the upper-face label now has phase
`f(σ*b/6)`, safe for every `1≤b≤5`. The pivot norm strictly increases by
`reciprocal_dilate_shift_improves` with integer numerator `a*σ+b`, since

`s=a*τ+(a*σ+b)/6`.

This contradicts the maximum over all complement-safe real times.

For the strict slope-one alternative, the three phases are strictly safe and
the face label's actual phase is one of `{1/6,1/3,2/3}`. Indeed use
`b∈{1,2,4}` when `σ=1`, and `b∈{2,4,5}` when `σ=-1`.
The pivot still has phase `m`. Thus every complement phase lies in `[δ,5/6)`,
and the existing forward-improvement theorem contradicts the maximum.
One global `s`, followed when needed by one global positive increment, is used.

## 7. Two-even branch

Suppose `p` is six-divisible, the sole other even label is `q`, and the other
three labels are odd. All labels other than `p` are nondivisible by three.
Thus `e q=±2`, and the other residues are `±1`. Obtain the same maximum and
actual face label `r`.

If `r` is odd, set `t'=τ+e r/6`. The remaining three labels consist of `q`
and two odd labels. Put `q` at `Fin 3` index zero and apply the signed mixed
lemma of section 4, reflected when `e r=-1`. Closed slopes two through five
give a safe complement and a strict pivot improvement, exactly as in section
6. For slope one, the face's actual phase belongs to
`{1/6,1/3,1/2,2/3}`: use shifts `{1,2,3,4}` for positive face sign, or
`{2,3,4,5}` for negative sign. The other three phases are strictly safe.
Forward improvement again contradicts the maximum.

If `r=q` is even, apply the signed initially-safe lemma of section 5 to the
three odd phases at `τ`. The candidates give:

| Candidate | Phase of `q`, starting from `5/6` | Pivot/complement conclusion |
| --- | --- | --- |
| `(a,b)=(2,0)` | `2/3` | odd phases strictly safe; pivot strictly improves |
| `a=1`, `b=1` or `5` | `1/6` or `1/2` | odd phases strictly safe; forward improvement applies |
| `a=3` or `5`, `0≤b≤5` | one of `1/6,1/2,5/6` | odd phases closed safe; pivot strictly improves |

For the last row, `5*a+e q*b` is odd; its residue modulo six is 1, 3, or 5.
This proves the phase statement for both signs and all endpoints without a
speed-dependent experiment. In the middle row, sixth shifts preserve the
pivot phase and the other phases are all below their upper faces. These are
the exact hypotheses needed by the existing improvement theorem. Every row
contradicts the all-real maximum. This finishes the two-even branch, conditional
only on implementing the new scalar lemmas proved above.

## 8. Three-even branch: prescribed orbit and weak-boundary rescue

Label the three even speeds by `A=v p`, `E`, `F`; label the two odd speeds by
`U`, `W`. The labels are distinct, their values need not be. We have `6 ∣ A`,
residues `E,F=±2 mod 6`, and `U,W=±1 mod 6`. Continue under `hno`.

### 8.1 Three weakly bad exceptions suffice

At any time where the pivot is safe, suppose three distinct other labels have
norm at most `δ`. For any one of those labels, each nonzero third shift changes
its phase by `±1/3` modulo one. The triangle inequality gives

`1/3 ≤ N(old phase)+N(shifted phase)`, hence `N(shifted phase)≥δ`.

All three are therefore safe at **both** shifts `k=1,2`. The remaining label
has at most one strictly bad third shift, by the checked spacing/subsingleton
lemmas. One of these same two shifts is safe for it. The pivot is preserved
because it is divisible by three. This gives a common safe time. The argument
uses weak badness for the selected three and strict badness for the final
exception, so equality at `δ` is included correctly.

### 8.2 Two fixed sixth-shift avoidance lemmas

After sign normalization, the following statements hold for arbitrary reals
`x,y,z`:

(A) If `N x≤δ`, some `b∈{1,2,4,5}` makes
`x+2b/6`, `y+2b/6`, `z+b/6` all safe.

(B) If `N z≤δ`, some `b∈{1,2,3,4,5}` makes those same three phases all safe.

For (A), the first phase is safe at all four allowed shifts by the preceding
triangle argument. The doubled-weight bad set of the second phase is
contained in `{1,4}` or `{2,5}` or is empty on this domain. The last phase has
at most two bad positions; if two, they must be `{1,2}` or `{4,5}`. These
cannot cover the complement of either doubled-weight pair. If either set is
smaller, their total cardinality is already less than four.

For (B), lift the weakly bad `z` into `[-δ,δ]`. Among shifts one through five
it can be strictly bad only at 1 or 5, and not both. Each doubled-weight bad
set is contained in one of `{1,4}`, `{2,5}`, `{3}`. If neither includes 3,
then 3 remains safe for all three. If one includes 3, the union of the two
doubled bad sets has size at most three, and adding the single bad endpoint
still leaves a safe shift among five. These arguments prove the two common
choices; they do not select a different shift for each phase.

Now suppose `f(t*U)=0` and `A` is safe at `t`. If `E` or `F` is weakly bad,
apply (A) after sign normalization; if `W` is weakly bad, apply (B). In either
case `A` is preserved by the sixth shift and `U` has phase `±b/6`, safe for
every permitted nonzero `b`. This would give a witness. Therefore under `hno`
the three phases `E,F,W` at such a `t` are all strictly safe.

In fact `N(t*W)>1/3`. Otherwise time `t+1/2` preserves all three even phases,
makes `U` have phase `1/2`, and gives
`N((t+1/2)*W)=1/2-N(t*W)≥δ`. That would be a witness.

### 8.3 Prescribed coprime orbit band

Here is the required new arithmetic lemma, with no primality assumption on
the denominator:

```lean
theorem exists_reciprocal_time_small_phase
    (A q : ℕ) (hq : 0 < q) (hcop : Nat.Coprime q 6)
    (hnot : ¬ q ∣ A) :
    ∃ k : ℕ, k < q ∧
      (((1 : ℝ) / 12 ≤ Int.fract ((k : ℝ) * (A : ℝ) / (q : ℝ)) ∧
        Int.fract ((k : ℝ) * (A : ℝ) / (q : ℝ)) ≤ (1 : ℝ) / 6) ∨
       Int.fract ((k : ℝ) * (A : ℝ) / (q : ℝ)) = (1 : ℝ) / 5)
```

Proof: put `g=gcd(q,A)`, `n=q/g`, `c=A/g`. Positivity of `q` gives `g>0`;
the gcd division identities give `q=g*n`, `A=g*c` and `Coprime c n`.
The nondivisibility hypothesis gives `n>1`. Since `n∣q`, also `Coprime n 6`.
Thus `n=5` or `n≥7`: the integers 2, 3, 4, and 6 are excluded by divisibility
by 2 or 3, not by treating every nonzero residue of a composite modulus as a
unit.

For `n=5`, take target residue `m=1`. For `n≥7`, choose
`m=ceil(n/12)`. Then `1≤m<n` and `1/12≤m/n≤1/6`.
For `7≤n<12` this is `m=1`; for `n≥12`, use
`n/12≤m≤n/12+1≤n/6`. These are a symbolic integer interval split, not an
enumerated search. The same choice can be written `(n+11)/12` in naturals.

Coprimality makes multiplication by `c` a permutation modulo `n`: a Bézout
inverse gives `k<n` with `k*c ≡ m (mod n)`. Consequently
`f(k*A/q)=f(k*c/n)=m/n`, since `0≤m<n`. Also `k<n≤q`.
This proves the statement, including composite `q`. The existing mesh theorem
provides the gcd setup but its large-distance conclusion alone is insufficient;
the prescribed-residue permutation step must be implemented explicitly.

### 8.4 Both odd speeds divide the pivot

If `U ∤ A`, apply 8.3 with `q=U`, which is positive and coprime to six because
it is odd and nondivisible by three. Put `s=k/U`. Then `U` has zero phase at
`s`, `2s`, and `4s`. The obtained pivot phase `r` lies in `[1/12,1/6]` or is
`1/5`. In either case both `2r` and `4r` are safe modulo one. Thus 8.2 implies

`N(2s*W)>1/3` and `N(4s*W)>1/3`.

But `N x>1/3` implies `N(2x)<1/3`: fold to `u=N x∈(1/3,1/2]`, so
`N(2x)=1-2u∈[0,1/3)`. This contradiction proves `U∣A`.
Interchanging the two odd labels proves `W∣A` as well.

Since both are coprime to six and `6∣A`, we obtain `6*U∣A` and `6*W∣A`.
Positivity then gives `6*U≤A` and `6*W≤A`. No bound has been proved on `E,F`,
so this is deliberately not an application of the fast-speed theorem.

### 8.5 Finish with one dilation obstruction

Set `t₀=1/(6*A)>0`. At every integer multiple `a*t₀`, `1≤a≤5`, the pivot
phase is exactly `a/6`, safe. The two odd phases satisfy

`0 < a*U/(6*A) ≤ a/36 ≤ 5/36 < 1/6`,

and the same inequality holds for `W`. Thus both odd labels are strictly bad.
If either even exception is weakly bad there, 8.1 supplies a common witness,
contradicting `hno`. Therefore `N(a*t₀*E)>δ` for every `1≤a≤5` (and likewise
for `F`). Apply 3.1 to the strictly safe phase `t₀*E`. Its bad dilation among
two through five contradicts this conclusion. This finishes the three-even
branch without recursion, a missing count hypothesis, or a speed enumeration.

## 9. Lean-sized contracts and dependency order

All names below are proposed; only names in section 2 are claimed to exist.
The full new phase contracts are displayed in sections 4–5, the maximum
adapter in section 2, and the orbit contract in section 8.3. Further useful
small interfaces are:

```lean
theorem exists_bad_sixth_dilate (x : ℝ)
    (hx : (1 : ℝ) / 6 < circleNorm x) :
    ∃ a : ℕ, 2 ≤ a ∧ a ≤ 5 ∧
      circleNorm ((a : ℝ) * x) < (1 : ℝ) / 6

theorem sixth_shift_close_pair (x y z : ℝ)
    (hyz : circleNorm (y - z) ≤ (1 : ℝ) / 6) :
    ∃ b : ℕ, 1 ≤ b ∧ b ≤ 5 ∧
      (1 : ℝ) / 6 ≤ circleNorm (x + 2 * (b : ℝ) / 6) ∧
      (1 : ℝ) / 6 ≤ circleNorm (y + (b : ℝ) / 6) ∧
      (1 : ℝ) / 6 ≤ circleNorm (z + (b : ℝ) / 6)

theorem sixth_shift_weak_even (x y z : ℝ)
    (hx : circleNorm x ≤ (1 : ℝ) / 6) :
    ∃ b : ℕ, (b = 1 ∨ b = 2 ∨ b = 4 ∨ b = 5) ∧
      (1 : ℝ) / 6 ≤ circleNorm (x + 2 * (b : ℝ) / 6) ∧
      (1 : ℝ) / 6 ≤ circleNorm (y + 2 * (b : ℝ) / 6) ∧
      (1 : ℝ) / 6 ≤ circleNorm (z + (b : ℝ) / 6)

theorem sixth_shift_weak_odd (x y z : ℝ)
    (hz : circleNorm z ≤ (1 : ℝ) / 6) :
    ∃ b : ℕ, 1 ≤ b ∧ b ≤ 5 ∧
      (1 : ℝ) / 6 ≤ circleNorm (x + 2 * (b : ℝ) / 6) ∧
      (1 : ℝ) / 6 ≤ circleNorm (y + 2 * (b : ℝ) / 6) ∧
      (1 : ℝ) / 6 ≤ circleNorm (z + (b : ℝ) / 6)

theorem third_shift_of_three_weak_exceptions
    (v : Fin 5 → ℕ) (p : Fin 5)
    (hdiv : 3 ∣ v p) (hother : ∀ i, i ≠ p → ¬ 3 ∣ v i)
    (t : ℝ) (hp : (1 : ℝ) / 6 ≤ circleNorm (t * (v p : ℝ)))
    (hbad : 3 ≤ ((Finset.univ : Finset (Fin 5)).filter
      (fun i => i ≠ p ∧ circleNorm (t * (v i : ℝ)) ≤ (1 : ℝ) / 6)).card) :
    ∃ k : Fin 3, ∀ i, (1 : ℝ) / 6 ≤ circleNorm
      ((t + (k.val : ℝ) / 3) * (v i : ℝ))

theorem no_sixth_shift_implies_sextant_matching (x : Fin 3 → ℝ)
    (hno : ¬ ∃ b : Fin 6, ∀ j, (1 : ℝ) / 6 ≤
      circleNorm (x j + (b.val : ℝ) / 6)) :
    ∃ e : Fin 2, ∃ π : Equiv.Perm (Fin 3), ∀ j : Fin 3,
      ((2 * j.val + e.val : ℕ) : ℝ) / 6 < Int.fract (x (π j)) ∧
      Int.fract (x (π j)) < ((2 * j.val + e.val + 1 : ℕ) : ℝ) / 6
```

The weak-exception theorem needs no speed positivity or primitive condition;
the scalar lemmas accept negative input phases. `classical` may be introduced
inside a proof for real filters; it is not an added public typeclass hypothesis.
The matching uses an actual permutation, not merely membership in the union
of three sextants. This retains one phase per sextant.

The normalized parity contracts can share one exact parameterized statement,
proved by three separately named internal cases:

```lean
theorem one_three_divisible_parity_witness
    (v : Fin 5 → ℕ) (hpos : ∀ i, 0 < v i) (p : Fin 5)
    (hsix : 6 ∣ v p) (hone : ∀ i, 3 ∣ v i ↔ i = p)
    (e : ℕ) (he : e = 1 ∨ e = 2 ∨ e = 3)
    (heven : ((Finset.univ : Finset (Fin 5)).filter
      (fun i => 2 ∣ v i)).card = e) :
    ∃ t : ℝ, ∀ i, (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ))
```

The three internal lemmas replace `e,he,heven` with `card(even)=1`, `=2`, or
`=3`. They must not assume the all-real witness they are intended to produce;
`hno` is introduced only inside contradiction proofs. They do not assume gcd
one, since their exact residue pattern is already supplied.

Implementation order, with each mathematical batch independently reviewed
before promotion:

The first two independent drafting units are `exists_bad_sixth_dilate`
(section 3.1) and `third_shift_of_three_weak_exceptions` (section 8.1).
They need neither mixed-phase lemma nor a maximum construction and have exact
displayed contracts above. Root review of these small arguments can settle
their specifications while the larger manuscript receives independent review.

1. Scalar folded dilation, exact sixth-grid bad-set shape, CLOSE, and the
   matching lemma. Prove interval endpoints by integer lifts and linear
   inequalities. Generic finite-union/cardinality APIs in
   `ModularCertificates` can package avoidance, but simple cardinal sums alone
   do not replace the shape argument in CLOSE or 8.2.
2. Mixed Lemma 6.1 and initially-safe Lemma 6.4 from sections 4–5; then their
   signed and reflected adapters. Preserve each strict alternative verbatim.
   These are the principal new phase proof obligations. The existing 23-choice
   certificate for 5.1 is not a certificate for either new statement.
3. Existing maximum wrapper from the four-runner fifth-margin seed; signed
   actual-time adapters; one-even branch using checked 5.1. This branch can
   proceed before the new mixed lemmas.
4. Two-even branch using the mixed lemmas and the same maximum wrapper.
5. Weak three-exception rescue and the two small sixth-shift lemmas; prescribed
   gcd-orbit band; divisibility-at-an-odd-zero consequence; three-even finish.
   This is independent of maximum construction and of the two-divisible
   boundary assembly.
6. Finite-label singleton/parity reindexing, divisor-count reduction, and
   all-real-to-positive conversion for the displayed public endpoint.

After integration with the other established cases, the project milestone is
the verified canonical theorem for **N = 6 total runners**, including its exact
bridge, full build, trust audit, and independent scope review. Per the standing
2026-09-06 priority, research then transitions to a **uniform arbitrary-N
mechanism** for unrestricted LRC; N = 7, 8, and successive counts are not a
milestone roadmap. Further finite-count work would need an explicitly stated
role in that uniform mechanism. The six-runner milestone does not complete the
unrestricted goal.

Reindexing is by labels, using erasures/subtypes or explicit finite
equivalences. A singleton filter identifies `p`. Cardinal one/two/three of the
even filter and `p`'s membership identify the other even and odd complements.
Deleting `p` supplies exactly four labels; deleting an actual distinct face
supplies three. In the three-even branch two distinct odd labels remain even
if their speed values coincide. No “choose different speeds” step is valid
or necessary. Algebra at each actual candidate is supplied by the same
integer-residue identity, so a phase statement cannot accidentally introduce
different affine choices for different labels.

## 10. Review obligations and exact remaining gap

The candidate derivation covers all three parity patterns arising from the
one-three-divisible primitive hypothesis. It leaves no mathematical lemma as
an assumed unproved witness assertion: new scalar/orbit claims are stated and
proved here. It nevertheless remains an **unreviewed manuscript candidate**.
The most useful independent review targets are the open-arc endpoint in CLOSE,
the three/four-element bad-set classification in section 4, the grid-boundary
exclusion in section 5, and the prescribed gcd-orbit band and two-half-time
contradiction in section 8. A defect in any of these must be repaired before
implementation is represented as settled.

No Lean declaration in sections 1, 4, 5, 8.3, or 9 was elaborated in this task.
Implementation must discharge the finite label equivalences, sign/cast
transport, exact scalar inequalities, and all remaining compositions; then
source review, full integration, and trust audit remain necessary. The report
does not promote the whole five-moving theorem, a full six-runner result, or
the unrestricted conjecture. Completing the separately implemented
two-divisible branch would not remove these remaining one-divisible obligations.

## 11. Static provenance and source bindings

Policy/configuration and the focused live task record were read at task start
and again after context compaction. The active record identified
`/root/one_three_divisible_plan`, source checkpoint `a233f95`, requested
`gpt-6-astra` / `xhigh`, and this single owned file; observed runtime metadata
was null in state. The repository remained `research` / active. No settings or
state were modified.

Actual validation command: `python3 scripts/validate_workflow.py`; actual exit
code 0. Full stdout:

```text
workflow structural validation passed; it cannot certify mathematical validity.
```

The primary PDF was retrieved through the web tool as a nine-page PDF, with
printed pages 93–101 and DOI metadata as above. Relevant text was read; no
local PDF or bulk artifact was created. The source-based claims are its section
and lemma scopes. The arguments and proposed kernel contracts in this report
are author mathematical derivations, not claims that a publisher proof was
executed or kernel checked. Read-only source inspection and `sha256sum` were
the only source-binding operations. Static hashes bind bytes, not mathematical
truth or compiled artifacts. Mutable root integration/audit files are omitted.

The following is a single optional **static-only** replay, from the repository
root. It checks the fifteen bindings read for this plan; it runs no Lean or
mathematical computation and creates no files.

```bash
timeout 10s sha256sum --check <<'SHA256'
8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af  lean-toolchain
887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218  lake-manifest.json
0b62ef724eb8c24db4085e247e9f16f650ec450291c7ccac2b0ad0981f148727  LonelyRunner/SixTotalDivisorCounts.lean
1ceac85438299dffdd48d57fb0052b598a9bd5eda995cabff0256885529d89cb  LonelyRunner/RenaultPhaseLemma.lean
2ef07e6b83b8675a22184571c31d2a71dab9d5c072e3cd165cb8382957b46e92  LonelyRunner/ConstrainedMaximizer.lean
662d0116f13971bce85e76c503e2f3be4fdc6291ba8113aeda43957e38354ffe  LonelyRunner/FiveRunnerOrdinary.lean
cc203315c6d36be23b7cdcfc9706785fb05e6d5406c84714a9fea42bdfce7212  LonelyRunner/FiveMovingFast.lean
cf615dd6c6b3cf091cd5d31ac641f4f994c1c50d95e0120c311d3ac129b88591  LonelyRunner/RationalShiftOrbits.lean
6e9d1e3e084188a651e4c875cf36fd5d6fc7cbd5f1914784019a207a0cec01f4  LonelyRunner/RationalShiftGcd.lean
212fa6d879bab6d70f09a4a43b2027b96724b5e5ac4a22cdf4b368509973166f  LonelyRunner/DivisorInsertion.lean
76e420713079ec0c3979e9b169cd78ecb6a932d6dc790ea7d9711adbb64b7d4b  LonelyRunner/SixthAffinePhase.lean
957606878108847d5ceff47be621ff0fc9c0a0d976568b5f5ef3dbb6db10481e  LonelyRunner/FoldedCirclePhase.lean
28c5db2425eef754156e57c284959ff02da743f1fde424e053c4eae0c721b6bd  LonelyRunner/SeparatedPhaseFamily.lean
146cdfd80495aced0eb93bc322559cf7e950a80b0d01534b2a57cce7129debaa  LonelyRunner/ThirdShiftSpacing.lean
8b7e9dc5be1236acb812607c19454fe43ecd1333145aef675e7df8e6d0c3871c  LonelyRunner/ModularCertificates.lean
SHA256
```

There are fifteen bound files above (two pins and thirteen Lean interfaces).
The exact Bash fence, with one final newline, was extracted from this report
and run through `subprocess.run(['bash','-c',program], capture_output=True,
timeout=10)`. This is the only additional replay performed. Actual receipt:

```text
static_replay_program_sha256=d2798d85d71907debbbf71eaccad98a9581f7b079d06145a131e8e6a53c3c0b7
exit_code=0
stdout_bytes=571
stdout_sha256=cfb30e47741fecd0ab47039b491fd0757f7b27a980fade915f292cd2c5dfbcd3
lean-toolchain: OK
lake-manifest.json: OK
LonelyRunner/SixTotalDivisorCounts.lean: OK
LonelyRunner/RenaultPhaseLemma.lean: OK
LonelyRunner/ConstrainedMaximizer.lean: OK
LonelyRunner/FiveRunnerOrdinary.lean: OK
LonelyRunner/FiveMovingFast.lean: OK
LonelyRunner/RationalShiftOrbits.lean: OK
LonelyRunner/RationalShiftGcd.lean: OK
LonelyRunner/DivisorInsertion.lean: OK
LonelyRunner/SixthAffinePhase.lean: OK
LonelyRunner/FoldedCirclePhase.lean: OK
LonelyRunner/SeparatedPhaseFamily.lean: OK
LonelyRunner/ThirdShiftSpacing.lean: OK
LonelyRunner/ModularCertificates.lean: OK
stderr_bytes=0
stderr_sha256=e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855
```

This successful static binding check is not a mathematical test or a Lean
proof check. The stated review and implementation obligations remain.
