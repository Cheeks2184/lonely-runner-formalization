# Three divisible speeds: exact third-shift manuscript

2026-09-06. Requested Astra/xhigh mathematical task
`/root/three_divisible_shift_plan`, recorded checkpoint `a854ae8`. Runtime
model/effort are not independently attested. Only this report is owned.
Configuration, workflow, policy and focused state were read; root owns state.
The overall unrestricted goal remains active. This is a manuscript with
proposed Lean contracts, not an implementation or an executed arithmetic check.

**The noncircular result is complete for exactly three or four labels whose
speeds are divisible by 3, with arbitrary positive natural speeds and repeated
values allowed.** Consequently it holds whenever at least three labels are
divisible by 3 and the tuple has gcd one. Without primitivity or another
assumption excluding the all-five-divisible case, the originally suggested
statement includes the full five-moving closed-sixth theorem by scaling.
That larger statement is not discharged by this argument.

## Primary scope

The source labels this result **Lemma 2.3**, not Claim 2.3. Section 2 fixes
five positive integers with gcd one; no distinctness premise is imposed on
that integer tuple. Lemma 2.3 spans printed pages 94–95. Its proof uses
Lemma 2.1 to reduce to three divisible and two nondivisible speeds, then the
three times `t,t+1/3,t+2/3`. The paper's safe interval is closed. These scope
points were checked in the [primary-paper hosted copy, pages 94–95](https://compmath.wordpress.com/wp-content/uploads/2008/08/view-obstruction_a_shorter_proof_for_6_lonely-runners.pdf#page=2):
Jérôme Renault, *View-obstruction: a shorter proof for 6 lonely runners*,
Discrete Mathematics 287 (2004), 93–101, DOI `10.1016/j.disc.2004.06.008`.
The PDF header identifies the DOI; byte identity with a publisher-hosted
version is not claimed.

The proof below is a self-contained implementation derivation using the
project's checked four-moving theorem and metric/finite-set APIs. In
particular it explicitly proves the bad-set bound with strict badness,
handles four divisible labels directly, and retains positive time.

## 1. A separated family has at most one strictly bad point

Write `N(y)=circleNorm y=‖(y : UnitCircle)‖`. For arbitrary real `u,v`,

    N(u-v) ≤ N(u)+N(v).                                      (T)

This is the additive norm triangle inequality `norm_sub_le` on `UnitCircle`,
after rewriting the coercion of the difference with `AddCircle.coe_sub`.
It is circular distance on the quotient, not the ordinary real distance
`|u-v|`; the latter would fail to control phases near opposite ends of a
chosen unit interval.

Let `f : α→ℝ` be any labelled family, with no finiteness assumption, and let
`δ : ℝ`. Suppose every two distinct labels satisfy

    2*δ ≤ N(f(i)-f(j)).                                     (S)

If both `N(f(i))<δ` and `N(f(j))<δ`, then (T) gives

    N(f(i)-f(j)) ≤ N(f(i))+N(f(j)) < 2*δ,

contradicting (S) unless `i=j`. Thus the strictly bad set is subsingleton.
No sign or upper-bound premise on `δ` is needed for this logical implication;
when `δ≤0` the bad set is empty because a norm is nonnegative. The useful
specialization below is `δ=1/6` and pairwise separation at least `1/3`.

Closed safety is essential. Two points at distance exactly `2*δ` can both
have norm equal to `δ`, so replacing the bad test `<δ` by `≤δ` would destroy
this cardinality bound. Equality at norm `1/6` remains safe throughout.

Proposed reusable signatures:

```lean
theorem circleNorm_sub_le_add (u v : ℝ) :
    circleNorm (u - v) ≤ circleNorm u + circleNorm v

theorem circleNorm_bad_subsingleton_of_separated {α : Type*}
    (f : α → ℝ) (δ : ℝ)
    (hsep : ∀ i j, i ≠ j →
      2 * δ ≤ circleNorm (f i - f j)) :
    Set.Subsingleton {i : α | circleNorm (f i) < δ}
```

The finite cardinality consequence uses the already present
`Finset.card_le_one` or `Finset.card_le_one_iff_subsingleton` on the filtered
candidate set. A separate general counting theorem is optional; the
subsingleton statement is the smallest reusable geometric ingredient.

## 2. Third-shift separation for any nondivisible natural speed

Fix arbitrary `x : ℝ`, natural `d` with `¬3∣d`, and `k,l : Fin 3`, `k≠l`.
The phase difference cancels `x`:

    (x+k*d/3) - (x+l*d/3) = (k-l)*d/3.

To avoid truncated natural subtraction, first order the two natural indices.
In the order `l.val < k.val`, put `h=k.val-l.val`. Then `0<h<3` and
`(h:ℝ)=(k.val:ℝ)-(l.val:ℝ)`. Since `h` is positive and below 3, it is not
divisible by 3. Primality of 3 and `¬3∣d` imply `¬3∣h*d`. This uses genuine
primality only at modulus 3; no assumption that a nonzero composite residue
is a unit is introduced.

Let `r=(h*d)%3`. Nondivisibility gives `r≠0`, while the remainder bound
gives `r<3`; hence `1≤r` and `1≤3-r`. Therefore

    1 ≤ cyclicResidueDistance 3 (h*d)
      = min ((h*d)%3) (3-(h*d)%3).

The checked theorem `circleNorm_nat_div_ge` with `M=3`, numerator `h*d`
and lower bound `b=1` yields

    1/3 ≤ N((h*d)/3).

If the indices have the opposite order, exchange them and use
`circleNorm_neg`. This supplies the same bound on the original difference.
The argument needs no enumeration of the six ordered index pairs or the
speed values. The inequalities `0<h<3`, primality and the remainder bound
prove it uniformly. All casts are exact, and the only natural subtraction
occurs after proving the corresponding order.

The project APIs used here already exist: `cyclicResidueDistance` and
`circleNorm_nat_div_ge` in `PivotResidues.lean`, and `circleNorm_neg` in
`StructuredClasses.lean`. The relevant mathlib arithmetic API
`Nat.Prime.not_dvd_mul` was read in `Data/Nat/Prime/Basic.lean`.

Proposed spacing signature:

```lean
theorem circleNorm_third_shift_sub_ge (x : ℝ) (d : ℕ)
    (hnot : ¬ 3 ∣ d) (k l : Fin 3) (hkl : k ≠ l) :
    (1 : ℝ) / 3 ≤ circleNorm
      ((x + (k.val : ℝ) * (d : ℝ) / 3) -
        (x + (l.val : ℝ) * (d : ℝ) / 3))
```

Only the lower bound is needed; there is no reason to prove exact equality
of this norm with `1/3` first. Combining this bound with the preceding
subsingleton lemma gives

    #{k : Fin 3 | N(x+k*d/3)<1/6} ≤ 1.                      (B)

This includes all endpoint ties. For example the two phases `-1/6` and
`1/6` have the allowed separation `1/3` and are both safe at equality;
they do not count as two bad shifts. This is a symbolic boundary explanation,
not an executed fixture.

## 3. At most two nondivisible exceptions share a safe shift

Let `ι` be a finite type of at most two exceptional labels, each with a
natural speed `d i` not divisible by 3 and an arbitrary real base phase
`x i`. The base phases need not be rational or equal, and the speed values
need not be distinct. Put

    R = (Finset.univ : Finset (Fin 3)),
    B i = R.filter (fun k => N(x i+k*d i/3)<1/6).

Every `B i` is a subset of `R`. By (B), each has cardinality at most one, so

    sum_i #(B i) ≤ Fintype.card ι ≤ 2 < 3 = #R.

Apply the existing theorem
`LonelyRunner.exists_mem_avoiding_of_sum_card_lt_card R B hB hcard`.
It produces one `k : Fin 3` outside every bad set. The negated strict
comparison yields `1/6≤N(x i+k*d i/3)` for every exceptional label. Repeated
speed/phase pairs repeat a bad set. Repetition in either component separately
also causes no problem: the cardinality bound is proved for each label
independently. Empty and singleton exceptional families are also admitted.

The exact existing avoidance interface is:

```lean
exists_mem_avoiding_of_sum_card_lt_card {α ι : Type*}
    [DecidableEq α] [Fintype ι] (R : Finset α) (B : ι → Finset α)
    (hB : ∀ i, B i ⊆ R)
    (hcard : Finset.univ.sum (fun i => (B i).card) < R.card) :
    ∃ r ∈ R, ∀ i, r ∉ B i
```

Its proof is an elementary finite union bound in `ModularCertificates.lean`;
no external certificate, solver, or search is needed. The proposed resulting
generic exception theorem is:

```lean
theorem exists_third_shift_safe_nondivisible_family {ι : Type*} [Fintype ι]
    (x : ι → ℝ) (d : ι → ℕ)
    (hnot : ∀ i, ¬ 3 ∣ d i) (hcard : Fintype.card ι ≤ 2) :
    ∃ k : Fin 3, ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm
        (x i + (k.val : ℝ) * (d i : ℝ) / 3)
```

The proof can use `classical` locally for finite-set manipulations. There is no
finiteness assumption on the set of possible speed values, only on this
supplied exceptional label type.

## 4. Transfer at a supplied seed time

For a labelled speed tuple `v : Fin 5 → ℕ`, let

    S = {i : Fin 5 | 3∣v i},
    E = {i : Fin 5 | ¬3∣v i}.

Assume a real seed time `t₀` already makes **every** label in `S` safe at
threshold `1/6`, and `#E≤2`. Apply the exception theorem to the finite subtype
`{i : Fin 5 // i∈E}`, with `x i=t₀*v i`, `d i=v i`. Its Fintype cardinality
equals `E.card`, so the supplied bound is exact. Membership in `E` supplies
nondivisibility.

For the resulting single `k : Fin 3`, put `t=t₀+k.val/3`. At an exceptional
label, real distributivity gives

    (t₀+k/3)*v i = t₀*v i + k*v i/3,

which is the exception theorem's safe phase. At a divisible label, the checked
`circleNorm_time_add_nat_div_of_dvd 3 (v i) k.val` gives equality with its
original safe norm. Thus all five labels are safe at the same time.

This conditional statement includes even the case `#S=5`, but then its
premise already supplies safety for all five; it does not create such a
seed. It cannot be used to justify that missing seed from four labels.

Proposed exact adapter:

```lean
theorem exists_third_shift_of_seeded_divisible
    (v : Fin 5 → ℕ) (t₀ : ℝ)
    (hseed : ∀ i, 3 ∣ v i →
      (1 : ℝ) / 6 ≤ circleNorm (t₀ * (v i : ℝ)))
    (hexceptions :
      ((Finset.univ : Finset (Fin 5)).filter
        (fun i => ¬ 3 ∣ v i)).card ≤ 2) :
    ∃ k : Fin 3, ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm
        ((t₀ + (k.val : ℝ) / 3) * (v i : ℝ))
```

This adapter needs no positivity of speeds or seed time. In the final theorem,
the chosen seed is positive and `k.val/3≥0`, so the shifted time is positive.
There is no need to normalize time into `[0,1)` or repair a nonpositive time.

## 5. Uniform positive seed for exactly three or four divisible labels

Assume all five natural speeds are positive, `3≤S.card`, and `S.card≤4`.
Since the full label set has cardinality five, choose a label `p∉S`.
Equivalently, `¬3∣v p`. This choice is possible regardless of repeated speed
values: labels, rather than values, are counted.

Define the four-label tuple

    old(j) = v(p.succAbove j),  j : Fin 4.

It contains all labels other than `p`. Apply the checked
`fourMovingNaturalRunners old` with positivity inherited from `v`. Its exact
conclusion is a positive `t₀` with

    (5 : ℝ)⁻¹ ≤ N(t₀*old(j))  for every j : Fin 4.

Every divisible label `i` differs from `p`, so
`Fin.exists_succAbove_eq` supplies its corresponding `j`. Thus every label
of `S` is seeded at margin `1/5`, hence also at `1/6`. This works uniformly
when `#S=3` or `#S=4`: in the first case the four-label seed includes one
extra nondivisible label, whose safety need not persist under the shift;
it is still among the exceptions handled by the bad-set argument. There is
no need to pad a three-label tuple, split into cardinality cases, or deduplicate
speeds.

Complementary filtering gives `S.card+E.card=5`. Therefore `3≤S.card`
implies `E.card≤2`. Apply the preceding seeded adapter. Its `k` gives
`t=t₀+k.val/3>0` and simultaneous closed sixth-margin safety for all five.

Exact contract for the nonprimitive restricted theorem:

```lean
theorem fiveMovingNaturalRunners_of_three_or_four_divisible_three
    (v : Fin 5 → ℕ) (hpos : ∀ i, 0 < v i)
    (hlower : 3 ≤
      ((Finset.univ : Finset (Fin 5)).filter
        (fun i => 3 ∣ v i)).card)
    (hupper :
      ((Finset.univ : Finset (Fin 5)).filter
        (fun i => 3 ∣ v i)).card ≤ 4) :
    ∃ t : ℝ, 0 < t ∧ ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ))
```

An equivalent input for `hupper` is `∃p, ¬3∣v p`. Keeping the displayed
cardinality version matches the requested three-or-four contract. Useful
existing selection/count APIs were verified in the pinned source:
`Finset.exists_mem_notMem_of_card_lt_card` chooses `p` from `S.card<5`,
`Finset.card_filter_add_card_filter_not` proves the complement count, and
`Fintype.card_coe` identifies the exceptional subtype's cardinality.
The checked `Fin.succAbove_ne`/`Fin.exists_succAbove_eq` patterns occur in
the repository's four-moving and stationary-equivalence developments.

## 6. Primitive corollary and the all-five scope boundary

If `Finset.univ.gcd v=1`, some speed is not divisible by 3. Otherwise
`Finset.dvd_gcd` gives `3∣Finset.univ.gcd v`, hence `3∣1`, a contradiction.
Consequently `S` is a proper subset of five labels and `S.card≤4`.
The preceding theorem proves the paper's at-least-three implication, with
positive time and without a distinctness requirement:

```lean
theorem fiveMovingNaturalRunners_of_primitive_three_divisible_three
    (v : Fin 5 → ℕ) (hpos : ∀ i, 0 < v i)
    (hprimitive : Finset.univ.gcd v = 1)
    (hthree : 3 ≤
      ((Finset.univ : Finset (Fin 5)).filter
        (fun i => 3 ∣ v i)).card) :
    ∃ t : ℝ, 0 < t ∧ ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ))
```

This uses no hypothetical no-witness assumption and no unimplemented divisor-
count theorem. Under a no-witness assumption its contrapositive says that
a primitive tuple has at most two labels divisible by 3. It supplies the
three-divisible branch needed before the separate two-divisible argument.

The nonprimitive all-five case is a real boundary to this branch. For any
positive tuple `w : Fin 5→ℕ`, let `v i=3*w i`. Then all five speeds of `v`
are divisible by 3. A theorem claiming sixth-margin safety for every positive
tuple with at least three divisible labels, including this case, would give
a positive `t` for `v`, hence `s=3*t>0` for `w`, because

    t*(3*w i) = (3*t)*w i.

Conversely the full positive five-moving sixth theorem trivially covers
such `v`. Thus that unqualified all-five-inclusive statement is equivalent
to the complete five-moving natural sixth theorem. It is not false, but
this manuscript does not prove it.

Dividing a common gcd cannot repair this restricted branch by itself: the
divided tuple can have fewer than three multiples of 3, so the needed
hypothesis is not preserved. The previously proposed four-divisible insertion
requires a nondivisible exceptional speed; it likewise cannot supply the
all-five case. In the rational orbit language, a divisible exceptional speed
has no changing phase under `k/3`. An arbitrary excluded fifth divisible
label cannot be made safe by shifting a four-label witness.

Therefore implement the two exact restricted/primitive contracts above.
Do not silently drop `hupper` from the nonprimitive theorem or drop
`hprimitive` from its at-least-three corollary. No application of an
unproved five-moving sixth theorem occurs in any derivation here.

## 7. Implementation dependencies and acceptance checks

All new signatures above are proposals, not Lean code executed in this task.
The candidate count is fixed at three, but the argument is symbolic; no
numerical certificate or arithmetic experiment is required. A sensible order
is:

1. Triangle/subsingleton geometry from `FastRunnerInsertion` and the quotient
   norm API.
2. Uniform third-shift separation from `PivotResidues`, `StructuredClasses`
   and the natural primality/remainder lemmas.
3. Exceptional-family shift theorem using `ModularCertificates`.
4. Seeded-divisible adapter using `RationalShiftOrbits`.
5. The count-three-or-four theorem using `FiveRunnerOrdinary` and exact label
   complement enumeration; then the primitive corollary via the finite gcd.

The checked four-moving theorem lives in `FiveRunnerOrdinary.lean`, with
`Fin 4→Nat`, positivity, positive time and margin `(5:ℝ)⁻¹`. The canonical
`fiveRunners` theorem is a five-total-runner theorem and is not a replacement
for a five-moving sixth-margin supply. The old integer-grid theorem in
`DivisorInsertion` was inspected but does not need to be reproved or invoked
for the two-exception counting step. Its natural bounded adapter is not
sufficient by itself: separate exceptional witnesses might use different
shifts. The bad-set bound is what guarantees the common shift here.

For later implementation review, check the universal types, axiom dependencies,
nondivisibility premise on every exception, strict `<1/6` badness, the same
chosen `k` for every label, positivity of final time, and both scope
assumptions excluding the all-five case where applicable. No standalone
positive example or finite search could replace those universal obligations.
The later Renault two-divisible branch, further parity/phase branches, full
five-moving sixth supply and H7/H8/canonical assembly remain outside this
result. In particular a hypothetical `Fin 6` natural `1/7` statement would
not replace the five-moving `1/6` supply at the current canonical gap.

## 8. Actual read-only provenance

The workflow validator was actually run and exited 0:

```text
workflow structural validation passed; it cannot certify mathematical validity.
```

Primary browsing retrieved the nine-page paper and the text at printed pages
94–95, including Section 2's gcd-one assumption and Lemma 2.3. No large local
artifact was downloaded. Repository and pinned-library source searches/reads
established the API names above. There is no file named
`LonelyRunner/Distance.lean`; guessed reads of that path, and guesses of
`SevenAdicCertificates.lean`/`FiniteCertificates.lean`, reported missing files.
The relevant actual distance API was found in `FastRunnerInsertion`,
`StructuredClasses` and `PivotResidues`. These were discovery errors, not
Lean or mathematical failures. No Lean execution, build, numerical search,
solver, finite enumeration, cache mutation, Git operation, or state write
was performed. Only this report was written.

The following actual `sha256sum` output identifies the inspected source
dependencies (exit 0):

```text
cf615dd6c6b3cf091cd5d31ac641f4f994c1c50d95e0120c311d3ac129b88591  LonelyRunner/RationalShiftOrbits.lean
8b7e9dc5be1236acb812607c19454fe43ecd1333145aef675e7df8e6d0c3871c  LonelyRunner/ModularCertificates.lean
dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5  LonelyRunner/FastRunnerInsertion.lean
5328a7a88d2b42f86ffc3f0f0418ca22c761219e8fa3e5822bda5a18ac286e8c  LonelyRunner/StructuredClasses.lean
362da5ab923f22e900ae7ac821dd4cf4aab91dfe70889987bc9e5a05d19c276a  LonelyRunner/PivotResidues.lean
662d0116f13971bce85e76c503e2f3be4fdc6291ba8113aeda43957e38354ffe  LonelyRunner/FiveRunnerOrdinary.lean
212fa6d879bab6d70f09a4a43b2027b96724b5e5ac4a22cdf4b368509973166f  LonelyRunner/DivisorInsertion.lean
d1d6cf01650c809da0cb19ed722754071df070831e02e22a3c4b2c3dc28afb04  LonelyRunner/PrimitivePrompt95.lean
87c674ba5464c7868fb3e253e58a695821bf8841bb4e076bac5d570236dc6229  .lake/packages/mathlib/Mathlib/Data/Finset/Card.lean
5a70d92ff1637a57053c8ccddd92752adb7f0938e9fd585b3cd77badee2e248b  .lake/packages/mathlib/Mathlib/Data/Fintype/EquivFin.lean
b97e83d65681b68b3ad1f4bdfd36defd0a30aa173cf726b3d2807acf8bde5027  .lake/packages/mathlib/Mathlib/Data/Nat/Prime/Basic.lean
```

The next useful action is independent review of these exact contracts,
followed by bounded implementation of the geometry, shift and label-selection
lemmas. There is no unresolved mathematical gap inside the stated
three-or-four/primitive contracts; their Lean formalization remains work.
