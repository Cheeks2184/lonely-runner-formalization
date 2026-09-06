# Boundary-zero assembly from checked phase interfaces

The accepted boundary-zero argument admits the bounded decomposition below.
This is an implementation design, not a new Lean proof or a repeated review of
Proposition 3.1. It uses the terminal residue argument of the accepted
[07f278 plan](astra-two-divisible-three-reduction-plan.md) and its independent
[4d499c review](astra-two-divisible-three-plan-review.md). I authored the former;
the latter was a different Astra review. The conditional cover-to-witness
argument remains a separate module and is not used here.

Assigned checkpoint `cd15103`; requested route Astra/xhigh, exposed observed
model/effort null. Only this report is owned. Project instructions, policy and
focused research/in_progress state were read; structural validation passed.
All calculations below are symbolic manuscript derivations. No Lean run,
numeric fixture, search, finite experiment, source/state/Git or cache mutation
was performed. The sources and their status are distinguished at the end.

## Exact target and notation

Preserve the accepted target verbatim, including the arbitrary real queried
time, all-real nonexistence, positive labelled speeds and even-count bound:

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

Write N(x)=circleNorm x and δ=1/6 in prose. All displayed declarations belong in namespace `LonelyRunner`. The following
transparent private abbreviations shorten the helper contracts and may be inlined.
They assert the same closed sixth margin, without new hypotheses.

```lean
private abbrev SixthSafe (x : ℝ) : Prop :=
  (1 : ℝ) / 6 ≤ circleNorm x
private abbrev PairSafe (a b : ℕ) (s : ℝ) : Prop :=
  SixthSafe (s * (a : ℝ)) ∧ SixthSafe (s * (b : ℝ))
private abbrev AllSafe (v : Fin 5 → ℕ) (s : ℝ) : Prop :=
  ∀ i, SixthSafe (s * (v i : ℝ))
```

The helpers work with actual phases and possibly negative time. Exchanging p
and q later orders their **norms** only. It does not change either speed's
phase to its norm or declare that either fractional phase is below 1/2.

## 1. Residue certificates and the five separate rows

Root has now source-built the following exact helper in
`SixthAffineFoldedNorm.lean`; no duplicate implementation is requested:

```lean
theorem circleNorm_sixth_affine_of_three_residue (t : ℝ) (d n : ℕ)
    (β z ε : ℤ) (hd : (d : ℤ) = 6 * z + 3 * ε) :
    circleNorm (((n : ℝ) * t + (β : ℝ) / 6) * (d : ℝ)) =
      circleNorm ((n : ℝ) * circleNorm (t * (d : ℝ)) +
        ((β * ε : ℤ) : ℝ) / 2)
```

Its exact real decomposition is the integer βz plus
`n*(t*d)+(βε)/2`; integer periodicity and the checked half-folding identity
finish it. It allows all signed β,z,ε, n=0, d=0 and arbitrary real t.
The n in this norm interface is natural, which is sufficient for all rows.
The existing fractional-part affine theorem separately retains signed integer
dilation coefficients. No generalization of folding to arbitrary sixth shifts
of a nondivisible speed is assumed.

Root has source-built the following residue-certificate interface in
`ThreeResidueModSix.lean`; its full source was read and is bound below:

```lean
theorem exists_three_residue_mod_six (d : ℕ) (h3 : 3 ∣ d) :
    ∃ z ε : ℤ, (d : ℤ) = 6 * z + 3 * ε ∧
      (ε = 0 ∨ ε = 1) ∧ (6 ∣ d ↔ ε = 0)
```

For 6∣d use its quotient and ε=0. Otherwise write d=3k. If k were even,
d would be divisible by six, so k is odd and `k=2*(k/2)+1`; choose
z=k/2, ε=1. The final equivalence follows from the chosen branch. This proof
uses Euclidean natural division before casting, and includes d=0 in the first
branch. It is separate from the checked nondivisible centered-residue theorem.

For an anchor c with 3∤c, that checked theorem gives
`c=6z_c+κσ`, where κ=1 or 2 and σ=1 or -1. Normalize its four listed
residues this way, keeping z_c and σ integral. For pair speeds a,b divisible
by three, write `a=6z_a+3ε_a`, `b=6z_b+3ε_b`, ε_a,ε_b∈{0,1}.
The supplied six-divisibility disjunction excludes (ε_a,ε_b)=(1,1).

Here is the bounded three-speed selector contract. It has no Fin5 family,
nonexistence, positivity, maximum, or norm-order hypothesis; the ordered band
packet contains precisely the phase inequalities it consumes.

```lean
theorem exists_pair_safe_special_sixth_affine
    (a b c : ℕ) (ha : 3 ∣ a) (hb : 3 ∣ b) (hc : ¬ 3 ∣ c)
    (hsix : 6 ∣ a ∨ 6 ∣ b)
    (hregular : ¬ (6 ∣ a ∧ 6 ∣ b ∧ 2 ∣ c))
    (τ : ℝ) (ht : Int.fract (τ * (c : ℝ)) = (5 : ℝ) / 6)
    (H : FoldedPairSafeBands (circleNorm (τ * (a : ℝ)))
      (circleNorm (τ * (b : ℝ)))) :
    ∃ (n : ℕ) (σ : ℤ), (n = 1 ∨ n = 2 ∨ n = 3) ∧
      (σ = 1 ∨ σ = -1) ∧
      PairSafe a b ((n : ℝ) * τ + (σ : ℝ) / 6) ∧
      (Int.fract (((n : ℝ) * τ + (σ : ℝ) / 6) * (c : ℝ)) =
          (1 : ℝ) / 6 ∨
        Int.fract (((n : ℝ) * τ + (σ : ℝ) / 6) * (c : ℝ)) =
          (5 : ℝ) / 6)
```

Implement its five rows as separate local lemmas, then perform only the
certificate/disjunction assembly in the public wrapper. The common row inputs
are exactly τ,a,b,c,z_a,z_b,z_c,σ, `σ=1∨σ=-1`, the displayed three residue
equalities, ht and H. For each row the output is `PairSafe a b (n*τ+σ/6)`
and the exact anchor equality in the last column. The following table fixes
every constant and field, so no candidate discovery or new case reasoning is
left to an implementer. Raw phases are x=τa,y=τb; folded phases are N(x),N(y).

| ε_a,ε_b | κ | n | Fields of H proving pair safety | Anchor numerator / 6 → phase |
| --- | --- | --- | --- | --- |
| 0,0 | 1 | 2 | `left_two`, `right_two` | 11/6 → 5/6 |
| 0,1 | 1 | 2 | `left_two`, `right_two_half` | 11/6 → 5/6 |
| 0,1 | 2 | 3 | `left_three`, `right_three_half` | 17/6 → 5/6 |
| 1,0 | 1 | 2 | `left_two_half`, `right_two` | 11/6 → 5/6 |
| 1,0 | 2 | 1 | `left_half`, `right_one` | 7/6 → 1/6 |

Complete row derivation: apply the norm helper twice with β=σ. For ε=0 its
half-shift vanishes; for ε=1 it is σ/2. The σ=-1 expression differs from
the +1/2 expression by the integer -1, so `circleNorm_add_int` makes the
specified field applicable; this one signed-half identity can be proved once
locally. Nothing requires x or y to have a positive residual orientation.

For the anchor, `fract_sixth_affine_time` with integer α=n, β=σ and signed
residue e=κσ, followed by ht, gives

    fract((n*τ+σ/6)*c) = fract((5*n+κ)/6),

since σ²=1. The three numerators 11,17,7 reduce to 5,5,1 modulo six. These
are fixed exact rational equalities for source proofs, not an executed table.
Use the already used `Int.fract_div_natCast_eq_div_natCast_mod` after rewriting
each numerator as a natural cast. There is no negative natural subtraction.

Exhaustiveness: the pair residues permit only 00,01,10; κ permits 1,2.
The sixth combination, 00 with κ=2, makes all three speeds even and contradicts
hregular. Indeed `c=6z_c±2=2*(3z_c±1)` gives integer evenness, which casts back
to natural divisibility. Thus both signs are covered by each row. The fifth
row returns 1/6 directly; the later special-anchor rescue accepts that endpoint.

## 2. The both-six/even-anchor fallback

Use the following tiny odd-speed phase identity, which needs no positive-time
assumption and can be private to the fallback module:

```lean
theorem circleNorm_time_add_half_of_not_dvd_two
    (t : ℝ) (d : ℕ) (hodd : ¬ 2 ∣ d) :
    circleNorm ((t + (1 : ℝ) / 2) * (d : ℝ)) =
      circleNorm (t * (d : ℝ) + (1 : ℝ) / 2)
```

Write `d=2*(d/2)+1`; the phase difference is the integer d/2. For even speeds
use the existing `circleNorm_time_add_nat_div_of_dvd` with ell=2,k=1.

The separate `TwoPhaseHalfChoices.lean` source now has the exact scalar type
below and root reports its focused build passed. It is not a new implementation
request here.

```lean
theorem two_phase_half_choices (x y : ℝ) :
    (SixthSafe x ∧ SixthSafe y) ∨
      (SixthSafe (x + 1 / 2) ∧ SixthSafe (y + 1 / 2)) ∨
      (SixthSafe (2 * x + 1 / 2) ∧ SixthSafe (2 * y + 1 / 2))
```

Its complete derivation is independent of a runner family. If the first pair
fails, one phase, say x, is strictly bad. By `circleNorm_add_half`, its
half-translate is safe (in fact its norm exceeds 1/3). If the second pair
also fails, y+1/2 is strictly bad. Apply
`circleNorm_double_half_gt_of_small` to x and to y+1/2. The latter doubled
phase differs from 2y+1/2 by the integer 1, so the third pair is safe. The
other initial bad-label choice is symmetric. This includes x=0 or y=0,
negative phases, equal phases and boundary-safe ties. It yields a common
choice; it does not independently select one time per label.

The finite-label fallback can therefore return an explicit disjunction, with
no internal hno and no attempt to transport unsupported earlier safety:

```lean
theorem both_six_even_anchor_three_time_witness
    (v : Fin 5 → ℕ) (p q r : Fin 5)
    (hpq : p ≠ q) (hrp : r ≠ p) (hrq : r ≠ q)
    (hp : 6 ∣ v p) (hq : 6 ∣ v q) (hr : 2 ∣ v r)
    (heven : ((Finset.univ : Finset (Fin 5)).filter
      (fun i => 2 ∣ v i)).card ≤ 3)
    (τ : ℝ) (ht : Int.fract (τ * (v r : ℝ)) = (5 : ℝ) / 6)
    (H : FoldedPairSafeBands (circleNorm (τ * (v p : ℝ)))
      (circleNorm (τ * (v q : ℝ)))) :
    AllSafe v (2 * τ) ∨ AllSafe v (2 * τ + 1 / 2) ∨
      AllSafe v (4 * τ + 1 / 2)
```

Complete label proof: K={p,q,r} has cardinality three and is contained in the
even-label finset E. Since E.card≤3, cardinality and inclusion give K=E.
The complement `univ \ K` has cardinality two. Use `Finset.card_eq_two` to
write it as {u,w} with u≠w. Every label is p,q,r,u or w, and u,w are odd.
This counts labels, so repeated natural speed values are never discarded.

At 2τ the pair is safe by H.left_two/right_two and the zero-half folding
identity. At 4τ it is safe by H.left_four/right_four. Their evenness preserves
these norms under the indicated half-time additions. The anchor's phases at
2τ and 4τ are exactly 2/3 and 1/3, from `fract_int_dilate_eq` and ht. Both
have norm 1/3, using `circleNorm_eq_min_fract`, so are closed-safe. The even
anchor is also preserved under the half-time additions. Consequently all
three labels p,q,r are safe at each of the three displayed candidate times.

Set x=(2τ)v_u and y=(2τ)v_w. The two odd-speed phase identities identify their
norms at these three times with respectively `(x,y)`,
`(x+1/2,y+1/2)`, and `(2x+1/2,2y+1/2)`. Apply the single common disjunction
from `two_phase_half_choices`, then use the complete label decomposition to
establish the corresponding AllSafe. This proves the fallback contract.
It needs neither exact three-divisibility nor positivity as extra inner
premises; the original boundary theorem retains both stipulated hypotheses.

## 3. Assemble the zero-permitted maximum without orientation loss

First derive `3∣v p`, `3∣v q`, and `¬3∣v r` from hdiv and label inequalities.
The checked `three_exceptions_of_two_divisible_labels` gives exactly three
nondivisible labels, hence the ≤3 count for all special-anchor rescue calls.
Define one local rescue: if p and q are safe at real s and r has phase 1/6,
1/2 or 5/6 there, hdiv supplies the divisible seed and
`exists_third_shift_of_special_sixth_seeded_divisible` returns one k with
AllSafe at `s+k.val/3`. That contradicts the stipulated all-real hno. This
wrapper has no new existence premise and serves both uses below.

Apply the checked `exists_five_sixths_fiber_pair_maximizer` to v p,v q,v r,
using hpos r. Obtain τ in (0,1), its 5/6 anchor, and the global all-real
fiber bound. Set `M=min (N(τ*v p)) (N(τ*v q))`; nonnegativity gives M≥0.
If M≥δ, both pair labels are safe at τ, so the local special-anchor rescue
contradicts hno. Thus M<δ. No strict seed, positive maximum or complement-safe
maximizer has been introduced.

Suppose M>0. Split the total order of the two norms and denote the smaller
label by a and the other by b. In the p≤q branch M=N(τ*v p); in the other
M=N(τ*v q). After exchanging labels use `min_comm` for the entire supplied
fiber bound, `Or.comm` for the exact divisible-label characterization, and
exchange the six-divisibility disjunction. Keep τ and both actual phases
unchanged; also exchange the two inequalities involving r. The even count
does not change. There is no reason that the smaller-norm label must be the
one divisible by six, and the proof must retain both possibilities.

Now `foldedPairSafeBands_of_five_sixths_pair_bound` applies to the norm-ordered
speeds v a,v b, anchor v r, τ, the positive/small smaller norm, its ordering,
and the rewritten global fiber bound. It returns exactly the ordered packet
H used by both helpers above; its source already proves all scalar steps.

Split on `6∣v a ∧ 6∣v b ∧ 2∣v r`. In that branch the three-time fallback
supplies an AllSafe witness, contradicting hno. Otherwise the five-row selector
supplies a safe pair and special anchor at `nτ+σ/6`; apply the local rescue.
All rows permit σ=-1, so the constructed time need not be positive. The
all-real hno is exactly sufficient; silently replacing it with positive-time
nonexistence would require a separate nonzero/reflection lemma.

Every case contradicts M>0. Since M≥0, conclude M=0. For the original queried
real t at the 5/6 anchor, its pair minimum is nonnegative and is at most M by
the original global fiber bound. Therefore it equals zero. This is the exact
target above, at every anchored real t, not just at the chosen τ. Neither a
gcd assumption nor the separate cover finisher appears in this derivation.

## Implementation order, actual APIs and source bindings

Use these bounded milestones: (i) implement the odd half-time identity using
the checked residue/periodicity interfaces; (ii) prove each of the five table rows independently
using the checked norm helper, then combine their finite disjunctions into the
three-speed selector; (iii) use the now source-built two-phase helper for
the two-label complement bookkeeping and three-time fallback; (iv) write only the
short maximum/rescue/swap wrapper above. No worker needs to reconstruct the
scalar bands, discover candidate times, or solve the whole branch at once.

Actual APIs read: `AnchoredPairSafeBands:15`, `AnchoredPairMaximizer:15`,
`ThirdShiftSpecialSeed:15`, `TwoDivisibleSmallPair:15`, the affine/folded source
interfaces below, and `Mathlib/Data/Finset/Card.lean` at 580
(`card_sdiff_of_subset`) and 782 (`card_eq_two`). The count theorem in
TwoDivisibleSmallPair is independently established and does not call this
boundary theorem or the later cover wrapper. Norm reflection and integer
periodicity are the existing `circleNorm_neg` and `circleNorm_add_int`.

The following hashes bind read-only source/context inputs. Root reports the
new AnchoredPairSafeBands, SixthAffineFoldedNorm, ThreeResidueModSix and
TwoPhaseHalfChoices focused builds passed; this task does not reproduce those
builds or substitute its source reads for their separate verification receipts.

| File | SHA-256 |
| --- | --- |
| `research/astra-two-divisible-three-reduction-plan.md` | `07f27873785c463d7f9b2e8c2074510f42fcd973d07cc6e73ea62e5b3bac0ad6` |
| `research/astra-two-divisible-three-plan-review.md` | `4d499c4477e80445646c6f82fcb72e36009ed1b9fc35b0023dd278f399598f71` |
| `LonelyRunner/AnchoredPairSafeBands.lean` | `14212e32cdd3a343b286dd0fc370cefa6c33c145541f61afdf42e8e5290bc306` |
| `LonelyRunner/AnchoredPairMaximizer.lean` | `050888f1d9017183661dbca6e2e61bfeb518849c339bc77b43605a6b3918bdd8` |
| `LonelyRunner/SixthAffineFoldedNorm.lean` | `4ce24ac7955800ccc5ff5220de83d1972bb624d9e9b7e29237ac84874bd5396d` |
| `LonelyRunner/ThreeResidueModSix.lean` | `5df5d3b25175ea631032a8acd567449442ec4d6e56408ab271d6601dec527dfa` |
| `LonelyRunner/SixthAffinePhase.lean` | `76e420713079ec0c3979e9b169cd78ecb6a932d6dc790ea7d9711adbb64b7d4b` |
| `LonelyRunner/FoldedCirclePhase.lean` | `957606878108847d5ceff47be621ff0fc9c0a0d976568b5f5ef3dbb6db10481e` |
| `LonelyRunner/FoldedPairSafeBands.lean` | `00903bcb0c131fdb31ab87d55cea809249dfacbbd5861f82ab3a987d39b74b5f` |
| `LonelyRunner/AnchoredPairTransport.lean` | `63414c3ccb6c12c1ed8775cb7e18dccc84c30da42cd4be089ac336df75ceca43` |
| `LonelyRunner/ThirdShiftSpecialSeed.lean` | `ffbab991e23c45a1cd0abb2f692c30f35665f04ae5843a70898da00c69ab6187` |
| `LonelyRunner/ThirdShiftRescues.lean` | `829db12405e64ad88da5501ddb167d650ad82cf92295a88fd2374d9e08281732` |
| `LonelyRunner/RationalShiftOrbits.lean` | `cf615dd6c6b3cf091cd5d31ac641f4f994c1c50d95e0120c311d3ac129b88591` |
| `LonelyRunner/TwoDivisibleSmallPair.lean` | `ff40734821aae9abff43fdfc17c4275f4b5d045b4757b254dc11d24e695e8821` |
| `LonelyRunner/TwoPhaseHalfChoices.lean` | `cb5c23225a130c8613c1897a749eaa7834c14b3de504ae8b51f1744c53624acc` |
| `.lake/packages/mathlib/Mathlib/Data/Finset/Card.lean` | `87c674ba5464c7868fb3e253e58a695821bf8841bb4e076bac5d570236dc6229` |
| `lean-toolchain` | `8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af` |
| `lake-manifest.json` | `887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218` |

Actual workflow validation exited 0 and printed
`workflow structural validation passed; it cannot certify mathematical validity.`
The assembly contracts still need independent review, source implementation
and kernel checks. No boundary-zero, divisibility-cover establishment,
unconditional six-total theorem or unrestricted LRC result is claimed here.
