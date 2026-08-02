import LonelyRunner.FiberCredits
import LonelyRunner.PivotCounts
import LonelyRunner.SimultaneousCongruence

/-!
# Pivot target fibers and pair intersections

This module refines a modular-pivot bad set by the exact residue attained by
one speed.  The target set is the strict cyclic ball, so the strict bad-set
endpoint convention is preserved.  Intersections of two target fibers are
the candidate (non-`N`-divisible) solutions of two simultaneous linear
congruences.
-/

namespace LonelyRunner

open scoped BigOperators

/-- Candidate pivot residues at which `speed` attains the exact canonical
target residue modulo `N * pivot`. -/
def pivotTargetFiber (N pivot speed target : ℕ) : Finset ℕ :=
  (pivotCandidates N pivot).filter fun r =>
    (r * speed) % (N * pivot) = target

theorem mem_pivotTargetFiber {N pivot speed target r : ℕ} :
    r ∈ pivotTargetFiber N pivot speed target ↔
      r ∈ pivotCandidates N pivot ∧
        (r * speed) % (N * pivot) = target := by
  simp [pivotTargetFiber]

/-- Fibers belonging to distinct exact targets are disjoint. -/
theorem disjoint_pivotTargetFiber_of_ne
    (N pivot speed x y : ℕ) (hxy : x ≠ y) :
    Disjoint (pivotTargetFiber N pivot speed x)
      (pivotTargetFiber N pivot speed y) := by
  rw [Finset.disjoint_left]
  intro r hrx hry
  have hx := (mem_pivotTargetFiber.mp hrx).2
  have hy := (mem_pivotTargetFiber.mp hry).2
  exact hxy (hx.symm.trans hy)

/-- The strict-ball target fibers disjointly cover exactly one pivot bad set.
Both positivity hypotheses are explicit so reduction modulo `N * pivot` has
a positive modulus. -/
theorem biUnion_pivotTargetFiber_eq_pivotBadResidues
    (N pivot speed : ℕ) (hN : 0 < N) (hpivot : 0 < pivot) :
    (strictCyclicBall (N * pivot) pivot).biUnion
        (pivotTargetFiber N pivot speed) =
      pivotBadResidues N pivot speed := by
  have hM : 0 < N * pivot := Nat.mul_pos hN hpivot
  ext r
  simp only [Finset.mem_biUnion, mem_pivotTargetFiber,
    mem_pivotBadResidues]
  constructor
  · rintro ⟨x, hxBall, hrCandidate, hrTarget⟩
    refine ⟨hrCandidate, ?_⟩
    have hxDist : cyclicResidueDistance (N * pivot) x < pivot := by
      exact (Finset.mem_filter.mp hxBall).2
    have hxlt : x < N * pivot :=
      Finset.mem_range.mp (Finset.mem_filter.mp hxBall).1
    unfold cyclicResidueDistance at hxDist ⊢
    rw [hrTarget]
    simpa [Nat.mod_eq_of_lt hxlt] using hxDist
  · rintro ⟨hrCandidate, hrDist⟩
    let x := (r * speed) % (N * pivot)
    refine ⟨x, ?_, hrCandidate, rfl⟩
    apply Finset.mem_filter.mpr
    refine ⟨Finset.mem_range.mpr (Nat.mod_lt _ hM), ?_⟩
    simpa [x, cyclicResidueDistance, Nat.mod_mod] using hrDist

/-- The exact candidate solutions for a pair of target congruences. -/
def pivotPairTargetFiber
    (N pivot b c x y : ℕ) : Finset ℕ :=
  pivotTargetFiber N pivot b x ∩ pivotTargetFiber N pivot c y

/-- Cardinality of the candidate solutions of the two target congruences. -/
def candidateSimultaneousCongruenceCount
    (N pivot b c x y : ℕ) : ℕ :=
  (pivotPairTargetFiber N pivot b c x y).card

/-- Natural representatives below `M` solving two simultaneous congruences.
Unlike `pivotPairTargetFiber`, this raw fiber still contains representatives
divisible by the pivot-grid scale `N`. -/
def simultaneousCongruenceNatResidues
    (M b c x y : ℕ) : Finset ℕ :=
  (Finset.range M).filter fun r =>
    Nat.ModEq M (b * r) x ∧ Nat.ModEq M (c * r) y

theorem mem_simultaneousCongruenceNatResidues
    {M b c x y r : ℕ} :
    r ∈ simultaneousCongruenceNatResidues M b c x y ↔
      r < M ∧ Nat.ModEq M (b * r) x ∧
        Nat.ModEq M (c * r) y := by
  simp [simultaneousCongruenceNatResidues]

/-- The natural representatives and the `Fin M` representatives used by
`simultaneousCongruenceResidues` are the same finite fiber. -/
def simultaneousCongruenceNatResiduesEquiv
    (M b c x y : ℕ) :
    {r // r ∈ simultaneousCongruenceNatResidues M b c x y} ≃
      {r // r ∈ simultaneousCongruenceResidues M b c x y} where
  toFun r := ⟨⟨r.1, (mem_simultaneousCongruenceNatResidues.mp r.2).1⟩, by
    rw [mem_simultaneousCongruenceResidues]
    exact (mem_simultaneousCongruenceNatResidues.mp r.2).2⟩
  invFun r := ⟨r.1.1, by
    rw [mem_simultaneousCongruenceNatResidues]
    exact ⟨r.1.2, mem_simultaneousCongruenceResidues.mp r.2⟩⟩
  left_inv r := by
    apply Subtype.ext
    rfl
  right_inv r := by
    apply Subtype.ext
    apply Fin.ext
    rfl

theorem card_simultaneousCongruenceNatResidues
    (M b c x y : ℕ) :
    (simultaneousCongruenceNatResidues M b c x y).card =
      (simultaneousCongruenceResidues M b c x y).card := by
  simpa only [Fintype.card_coe] using
    Fintype.card_congr (simultaneousCongruenceNatResiduesEquiv M b c x y)

/-- The exact raw natural-representative count, transferred from the audited
simultaneous-congruence theorem. -/
theorem card_simultaneousCongruenceNatResidues_exact
    (M b c x y : ℕ) (hM : 0 < M) :
    (simultaneousCongruenceNatResidues M b c x y).card =
      if SimultaneousCongruenceCompatible M b c x y then
        M.gcd (b.gcd c)
      else 0 := by
  rw [card_simultaneousCongruenceNatResidues]
  exact card_simultaneousCongruenceResidues M b c x y hM

theorem mem_pivotPairTargetFiber_iff_modEq
    {N pivot b c x y r : ℕ} (_hM : 0 < N * pivot)
    (hx : x < N * pivot) (hy : y < N * pivot) :
    r ∈ pivotPairTargetFiber N pivot b c x y ↔
      r < N * pivot ∧ ¬N ∣ r ∧
        Nat.ModEq (N * pivot) (b * r) x ∧
        Nat.ModEq (N * pivot) (c * r) y := by
  simp only [pivotPairTargetFiber, Finset.mem_inter,
    mem_pivotTargetFiber, mem_pivotCandidates]
  constructor
  · rintro ⟨⟨⟨hrlt, hrN⟩, hb⟩, ⟨-, hc⟩⟩
    refine ⟨hrlt, hrN, ?_, ?_⟩
    · change (b * r) % (N * pivot) = x % (N * pivot)
      simpa [Nat.mul_comm, Nat.mod_eq_of_lt hx] using hb
    · change (c * r) % (N * pivot) = y % (N * pivot)
      simpa [Nat.mul_comm, Nat.mod_eq_of_lt hy] using hc
  · rintro ⟨hrlt, hrN, hb, hc⟩
    refine ⟨⟨⟨hrlt, hrN⟩, ?_⟩, ⟨⟨hrlt, hrN⟩, ?_⟩⟩
    · change (b * r) % (N * pivot) = x % (N * pivot) at hb
      simpa [Nat.mul_comm, Nat.mod_eq_of_lt hx] using hb
    · change (c * r) % (N * pivot) = y % (N * pivot) at hc
      simpa [Nat.mul_comm, Nat.mod_eq_of_lt hy] using hc

/-- The candidate target fiber is the non-`N`-divisible part of the raw
simultaneous-congruence fiber.  The target bounds are essential: raw
congruences interpret arbitrary targets modulo `N * pivot`, whereas exact
target fibers use canonical representatives. -/
theorem pivotPairTargetFiber_eq_filter_not_dvd
    (N pivot b c x y : ℕ) (hN : 0 < N) (hpivot : 0 < pivot)
    (hx : x < N * pivot) (hy : y < N * pivot) :
    pivotPairTargetFiber N pivot b c x y =
      (simultaneousCongruenceNatResidues (N * pivot) b c x y).filter
        fun r => ¬N ∣ r := by
  have hM : 0 < N * pivot := Nat.mul_pos hN hpivot
  ext r
  rw [mem_pivotPairTargetFiber_iff_modEq hM hx hy]
  simp only [Finset.mem_filter, mem_simultaneousCongruenceNatResidues]
  tauto

/-- The `N`-divisible part complementary to the candidate target fiber. -/
def divisibleSimultaneousCongruenceNatResidues
    (N pivot b c x y : ℕ) : Finset ℕ :=
  (simultaneousCongruenceNatResidues (N * pivot) b c x y).filter
    fun r => N ∣ r

theorem mem_divisibleSimultaneousCongruenceNatResidues
    {N pivot b c x y r : ℕ} :
    r ∈ divisibleSimultaneousCongruenceNatResidues N pivot b c x y ↔
      r < N * pivot ∧ N ∣ r ∧
        Nat.ModEq (N * pivot) (b * r) x ∧
        Nat.ModEq (N * pivot) (c * r) y := by
  simp only [divisibleSimultaneousCongruenceNatResidues,
    Finset.mem_filter, mem_simultaneousCongruenceNatResidues]
  tauto

/-- Scaling by `N` carries a smaller-modulus solution to precisely an
`N`-divisible solution at modulus `N * pivot`. -/
theorem mul_mem_divisibleSimultaneousCongruenceNatResidues_iff
    (N pivot b c x y q : ℕ) (hN : 0 < N)
    (hxDvd : N ∣ x) (hyDvd : N ∣ y) :
    N * q ∈ divisibleSimultaneousCongruenceNatResidues
        N pivot b c x y ↔
      q ∈ simultaneousCongruenceNatResidues
        pivot b c (x / N) (y / N) := by
  rw [mem_divisibleSimultaneousCongruenceNatResidues,
    mem_simultaneousCongruenceNatResidues]
  have hxScale : N * (x / N) = x := Nat.mul_div_cancel' hxDvd
  have hyScale : N * (y / N) = y := Nat.mul_div_cancel' hyDvd
  constructor
  · rintro ⟨hq, -, hb, hc⟩
    refine ⟨(Nat.mul_lt_mul_left hN).mp hq, ?_, ?_⟩
    · apply Nat.ModEq.mul_left_cancel' hN.ne'
      simpa [Nat.mul_assoc, Nat.mul_left_comm, Nat.mul_comm,
        hxScale] using hb
    · apply Nat.ModEq.mul_left_cancel' hN.ne'
      simpa [Nat.mul_assoc, Nat.mul_left_comm, Nat.mul_comm,
        hyScale] using hc
  · rintro ⟨hq, hb, hc⟩
    refine ⟨(Nat.mul_lt_mul_left hN).mpr hq, dvd_mul_right N q, ?_, ?_⟩
    · simpa [Nat.mul_assoc, Nat.mul_left_comm, Nat.mul_comm,
        hxScale] using hb.mul_left' N
    · simpa [Nat.mul_assoc, Nat.mul_left_comm, Nat.mul_comm,
        hyScale] using hc.mul_left' N

/-- Explicit image form of the bijection `q ↦ N * q`. -/
theorem divisibleSimultaneousCongruenceNatResidues_eq_image
    (N pivot b c x y : ℕ) (hN : 0 < N)
    (hxDvd : N ∣ x) (hyDvd : N ∣ y) :
    divisibleSimultaneousCongruenceNatResidues N pivot b c x y =
      (simultaneousCongruenceNatResidues
        pivot b c (x / N) (y / N)).image fun q => N * q := by
  classical
  ext r
  simp only [Finset.mem_image]
  constructor
  · intro hr
    have hrDvd :=
      (mem_divisibleSimultaneousCongruenceNatResidues.mp hr).2.1
    have hrScale : N * (r / N) = r := Nat.mul_div_cancel' hrDvd
    refine ⟨r / N, ?_, hrScale⟩
    rw [← mul_mem_divisibleSimultaneousCongruenceNatResidues_iff
      N pivot b c x y (r / N) hN hxDvd hyDvd]
    simpa [hrScale] using hr
  · rintro ⟨q, hq, rfl⟩
    exact (mul_mem_divisibleSimultaneousCongruenceNatResidues_iff
      N pivot b c x y q hN hxDvd hyDvd).2 hq

theorem card_divisibleSimultaneousCongruenceNatResidues
    (N pivot b c x y : ℕ) (hN : 0 < N)
    (hxDvd : N ∣ x) (hyDvd : N ∣ y) :
    (divisibleSimultaneousCongruenceNatResidues
      N pivot b c x y).card =
      (simultaneousCongruenceNatResidues
        pivot b c (x / N) (y / N)).card := by
  classical
  rw [divisibleSimultaneousCongruenceNatResidues_eq_image
    N pivot b c x y hN hxDvd hyDvd]
  apply Finset.card_image_iff.mpr
  intro q hq r hr hqr
  exact Nat.mul_left_cancel hN hqr

theorem dvd_left_target_of_mem_divisibleSimultaneousCongruenceNatResidues
    {N pivot b c x y r : ℕ}
    (hr : r ∈ divisibleSimultaneousCongruenceNatResidues
      N pivot b c x y) :
    N ∣ x := by
  have hrData := mem_divisibleSimultaneousCongruenceNatResidues.mp hr
  have hrDvd : N ∣ r := hrData.2.1
  have hbrDvd : N ∣ b * r := dvd_mul_of_dvd_right hrDvd b
  have hbMod : Nat.ModEq N (b * r) x :=
    hrData.2.2.1.of_dvd (dvd_mul_right N pivot)
  exact Nat.modEq_zero_iff_dvd.mp
    ((hbrDvd.zero_modEq_nat.trans hbMod).symm)

theorem dvd_right_target_of_mem_divisibleSimultaneousCongruenceNatResidues
    {N pivot b c x y r : ℕ}
    (hr : r ∈ divisibleSimultaneousCongruenceNatResidues
      N pivot b c x y) :
    N ∣ y := by
  have hrData := mem_divisibleSimultaneousCongruenceNatResidues.mp hr
  have hrDvd : N ∣ r := hrData.2.1
  have hcrDvd : N ∣ c * r := dvd_mul_of_dvd_right hrDvd c
  have hcMod : Nat.ModEq N (c * r) y :=
    hrData.2.2.2.of_dvd (dvd_mul_right N pivot)
  exact Nat.modEq_zero_iff_dvd.mp
    ((hcrDvd.zero_modEq_nat.trans hcMod).symm)

/-- Exact count of the divisible part.  It vanishes unless both targets are
divisible by `N`; otherwise the explicit scaling bijection gives the
smaller-modulus count. -/
theorem card_divisibleSimultaneousCongruenceNatResidues_if
    (N pivot b c x y : ℕ) (hN : 0 < N) :
    (divisibleSimultaneousCongruenceNatResidues
      N pivot b c x y).card =
      if N ∣ x ∧ N ∣ y then
        (simultaneousCongruenceNatResidues
          pivot b c (x / N) (y / N)).card
      else 0 := by
  classical
  by_cases hx : N ∣ x
  · by_cases hy : N ∣ y
    · rw [if_pos ⟨hx, hy⟩]
      exact card_divisibleSimultaneousCongruenceNatResidues
        N pivot b c x y hN hx hy
    · rw [if_neg (fun h => hy h.2)]
      apply Finset.card_eq_zero.mpr
      rw [Finset.eq_empty_iff_forall_notMem]
      intro r hr
      exact hy
        (dvd_right_target_of_mem_divisibleSimultaneousCongruenceNatResidues hr)
  · rw [if_neg (fun h => hx h.1)]
    apply Finset.card_eq_zero.mpr
    rw [Finset.eq_empty_iff_forall_notMem]
    intro r hr
    exact hx
      (dvd_left_target_of_mem_divisibleSimultaneousCongruenceNatResidues hr)

/-- Candidate count equals the raw modulus-`N * pivot` count minus its
`N`-divisible part. -/
theorem candidateSimultaneousCongruenceCount_eq_raw_sub_divisible
    (N pivot b c x y : ℕ) (hN : 0 < N) (hpivot : 0 < pivot)
    (hx : x < N * pivot) (hy : y < N * pivot) :
    candidateSimultaneousCongruenceCount N pivot b c x y =
      (simultaneousCongruenceNatResidues (N * pivot) b c x y).card -
        (divisibleSimultaneousCongruenceNatResidues
          N pivot b c x y).card := by
  rw [candidateSimultaneousCongruenceCount,
    pivotPairTargetFiber_eq_filter_not_dvd
      N pivot b c x y hN hpivot hx hy]
  have hsplit := Finset.card_filter_add_card_filter_not
    (s := simultaneousCongruenceNatResidues (N * pivot) b c x y)
    (p := fun r => N ∣ r)
  change
    ((simultaneousCongruenceNatResidues (N * pivot) b c x y).filter
      fun r => N ∣ r).card +
      ((simultaneousCongruenceNatResidues (N * pivot) b c x y).filter
        fun r => ¬N ∣ r).card =
      (simultaneousCongruenceNatResidues (N * pivot) b c x y).card at hsplit
  change
    ((simultaneousCongruenceNatResidues (N * pivot) b c x y).filter
      fun r => ¬N ∣ r).card =
      (simultaneousCongruenceNatResidues (N * pivot) b c x y).card -
        ((simultaneousCongruenceNatResidues (N * pivot) b c x y).filter
          fun r => N ∣ r).card
  omega

/-- Candidate count as the raw count minus the conditional smaller-modulus
count supplied by the scaling bijection. -/
theorem candidateSimultaneousCongruenceCount_eq_raw_sub_if
    (N pivot b c x y : ℕ) (hN : 0 < N) (hpivot : 0 < pivot)
    (hx : x < N * pivot) (hy : y < N * pivot) :
    candidateSimultaneousCongruenceCount N pivot b c x y =
      (simultaneousCongruenceNatResidues (N * pivot) b c x y).card -
        if N ∣ x ∧ N ∣ y then
          (simultaneousCongruenceNatResidues
            pivot b c (x / N) (y / N)).card
        else 0 := by
  rw [candidateSimultaneousCongruenceCount_eq_raw_sub_divisible
    N pivot b c x y hN hpivot hx hy]
  rw [card_divisibleSimultaneousCongruenceNatResidues_if
    N pivot b c x y hN]

/-- Closed arithmetic expression for one candidate pair-target count.  Each
branch uses the exact compatibility predicate, including its strengthened
cross modulus. -/
def exactCandidateSimultaneousCongruenceCount
    (N pivot b c x y : ℕ) : ℕ :=
  (if SimultaneousCongruenceCompatible (N * pivot) b c x y then
      (N * pivot).gcd (b.gcd c)
    else 0) -
    if N ∣ x ∧ N ∣ y then
      if SimultaneousCongruenceCompatible
          pivot b c (x / N) (y / N) then
        pivot.gcd (b.gcd c)
      else 0
    else 0

/-- Fully evaluated candidate pair-target count. -/
theorem candidateSimultaneousCongruenceCount_exact
    (N pivot b c x y : ℕ) (hN : 0 < N) (hpivot : 0 < pivot)
    (hx : x < N * pivot) (hy : y < N * pivot) :
    candidateSimultaneousCongruenceCount N pivot b c x y =
      exactCandidateSimultaneousCongruenceCount N pivot b c x y := by
  rw [candidateSimultaneousCongruenceCount_eq_raw_sub_if
    N pivot b c x y hN hpivot hx hy]
  rw [card_simultaneousCongruenceNatResidues_exact
    (N * pivot) b c x y (Nat.mul_pos hN hpivot)]
  rw [card_simultaneousCongruenceNatResidues_exact
    pivot b c (x / N) (y / N) hpivot]
  rfl

/-- A target fiber's overlap with another pivot bad set is the sum of the
exact candidate simultaneous-congruence counts over all strict-ball targets
of the second speed. -/
theorem card_pivotTargetFiber_inter_pivotBadResidues
    (N pivot b c x : ℕ) (hN : 0 < N) (hpivot : 0 < pivot) :
    (pivotTargetFiber N pivot b x ∩
        pivotBadResidues N pivot c).card =
      ∑ y ∈ strictCyclicBall (N * pivot) pivot,
        candidateSimultaneousCongruenceCount N pivot b c x y := by
  classical
  let targets := strictCyclicBall (N * pivot) pivot
  let pieces := fun y => pivotPairTargetFiber N pivot b c x y
  have hdecomp : targets.biUnion pieces =
      pivotTargetFiber N pivot b x ∩ pivotBadResidues N pivot c := by
    rw [← biUnion_pivotTargetFiber_eq_pivotBadResidues N pivot c hN hpivot]
    ext r
    simp only [targets, pieces, pivotPairTargetFiber,
      Finset.mem_biUnion, Finset.mem_inter]
    aesop
  have hdisjoint : ∀ y ∈ targets, ∀ z ∈ targets, y ≠ z →
      Disjoint (pieces y) (pieces z) := by
    intro y hy z hz hyz
    exact (disjoint_pivotTargetFiber_of_ne N pivot c y z hyz).mono
      Finset.inter_subset_right Finset.inter_subset_right
  rw [← hdecomp]
  exact card_biUnion_eq_sum_card_of_pairwise_disjoint targets pieces hdisjoint

/-- The pair-fiber overlap written directly as raw simultaneous-congruence
counts minus their `N`-divisible smaller-modulus counts. -/
theorem card_pivotTargetFiber_inter_pivotBadResidues_eq_sum_raw_sub_if
    (N pivot b c x : ℕ) (hN : 0 < N) (hpivot : 0 < pivot)
    (hxBall : x ∈ strictCyclicBall (N * pivot) pivot) :
    (pivotTargetFiber N pivot b x ∩
        pivotBadResidues N pivot c).card =
      ∑ y ∈ strictCyclicBall (N * pivot) pivot,
        ((simultaneousCongruenceNatResidues
            (N * pivot) b c x y).card -
          if N ∣ x ∧ N ∣ y then
            (simultaneousCongruenceNatResidues
              pivot b c (x / N) (y / N)).card
          else 0) := by
  rw [card_pivotTargetFiber_inter_pivotBadResidues
    N pivot b c x hN hpivot]
  apply Finset.sum_congr rfl
  intro y hyBall
  apply candidateSimultaneousCongruenceCount_eq_raw_sub_if
    N pivot b c x y hN hpivot
  · exact Finset.mem_range.mp (Finset.mem_filter.mp hxBall).1
  · exact Finset.mem_range.mp (Finset.mem_filter.mp hyBall).1

/-- Exact arithmetic expansion of every summand in the target-fiber overlap.
Membership of `x` in the strict ball supplies its canonical-target bound;
the summation membership supplies the corresponding bound for every `y`. -/
theorem card_pivotTargetFiber_inter_pivotBadResidues_exact
    (N pivot b c x : ℕ) (hN : 0 < N) (hpivot : 0 < pivot)
    (hxBall : x ∈ strictCyclicBall (N * pivot) pivot) :
    (pivotTargetFiber N pivot b x ∩
        pivotBadResidues N pivot c).card =
      ∑ y ∈ strictCyclicBall (N * pivot) pivot,
        exactCandidateSimultaneousCongruenceCount N pivot b c x y := by
  rw [card_pivotTargetFiber_inter_pivotBadResidues
    N pivot b c x hN hpivot]
  apply Finset.sum_congr rfl
  intro y hyBall
  apply candidateSimultaneousCongruenceCount_exact
    N pivot b c x y hN hpivot
  · exact Finset.mem_range.mp (Finset.mem_filter.mp hxBall).1
  · exact Finset.mem_range.mp (Finset.mem_filter.mp hyBall).1

end LonelyRunner
