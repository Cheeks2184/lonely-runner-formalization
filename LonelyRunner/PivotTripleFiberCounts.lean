import LonelyRunner.PivotPairFiberCounts
import LonelyRunner.TripleCongruence

/-!
# Exact pivot triple-target counts

This module specializes the exact three-congruence count to pivot candidates.
It removes precisely the representatives divisible by the pivot-grid scale
`N`, retaining canonical target and strict-endpoint conventions.  It makes no
claim that any anchor or ordering is uniformly optimal.
-/

namespace LonelyRunner

/-- Candidate pivot residues attaining three specified canonical targets. -/
def pivotTripleTargetFiber
    (N pivot a b c x y z : ℕ) : Finset ℕ :=
  pivotTargetFiber N pivot a x ∩
    pivotTargetFiber N pivot b y ∩
    pivotTargetFiber N pivot c z

/-- Exact cardinality of one candidate triple-target fiber. -/
def candidateTripleCongruenceCount
    (N pivot a b c x y z : ℕ) : ℕ :=
  (pivotTripleTargetFiber N pivot a b c x y z).card

/-- Natural canonical representatives of the raw triple congruence fiber. -/
def tripleCongruenceNatResidues
    (M a b c x y z : ℕ) : Finset ℕ :=
  (Finset.range M).filter fun r =>
    Nat.ModEq M (a * r) x ∧
      Nat.ModEq M (b * r) y ∧
      Nat.ModEq M (c * r) z

theorem mem_tripleCongruenceNatResidues
    {M a b c x y z r : ℕ} :
    r ∈ tripleCongruenceNatResidues M a b c x y z ↔
      r < M ∧ Nat.ModEq M (a * r) x ∧
      Nat.ModEq M (b * r) y ∧ Nat.ModEq M (c * r) z := by
  simp [tripleCongruenceNatResidues]

/-- Natural and `Fin M` presentations of the raw triple fiber are
equivalent. -/
def tripleCongruenceNatResiduesEquiv
    (M a b c x y z : ℕ) :
    {r // r ∈ tripleCongruenceNatResidues M a b c x y z} ≃
      {r // r ∈ tripleCongruenceResidues M a b c x y z} where
  toFun r := ⟨⟨r.1, (mem_tripleCongruenceNatResidues.mp r.2).1⟩, by
    rw [mem_tripleCongruenceResidues]
    exact (mem_tripleCongruenceNatResidues.mp r.2).2⟩
  invFun r := ⟨r.1.1, by
    rw [mem_tripleCongruenceNatResidues]
    exact ⟨r.1.2, mem_tripleCongruenceResidues.mp r.2⟩⟩
  left_inv r := by
    apply Subtype.ext
    rfl
  right_inv r := by
    apply Subtype.ext
    apply Fin.ext
    rfl

theorem card_tripleCongruenceNatResidues
    (M a b c x y z : ℕ) :
    (tripleCongruenceNatResidues M a b c x y z).card =
      (tripleCongruenceResidues M a b c x y z).card := by
  simpa only [Fintype.card_coe] using
    Fintype.card_congr
      (tripleCongruenceNatResiduesEquiv M a b c x y z)

/-- Exact raw natural-representative count transferred from the audited
triple theorem. -/
theorem card_tripleCongruenceNatResidues_exact
    (M a b c x y z : ℕ) (hM : 0 < M) :
    (tripleCongruenceNatResidues M a b c x y z).card =
      if TripleCongruenceCompatible M a b c x y z then
        M.gcd (a.gcd (b.gcd c))
      else 0 := by
  rw [card_tripleCongruenceNatResidues]
  exact card_tripleCongruenceResidues M a b c x y z hM

theorem mem_pivotTripleTargetFiber_iff_modEq
    {N pivot a b c x y z r : ℕ} (_hM : 0 < N * pivot)
    (hx : x < N * pivot) (hy : y < N * pivot)
    (hz : z < N * pivot) :
    r ∈ pivotTripleTargetFiber N pivot a b c x y z ↔
      r < N * pivot ∧ ¬N ∣ r ∧
      Nat.ModEq (N * pivot) (a * r) x ∧
      Nat.ModEq (N * pivot) (b * r) y ∧
      Nat.ModEq (N * pivot) (c * r) z := by
  simp only [pivotTripleTargetFiber, Finset.mem_inter,
    mem_pivotTargetFiber, mem_pivotCandidates]
  constructor
  · rintro ⟨⟨⟨⟨hrlt, hrN⟩, ha⟩, ⟨-, hb⟩⟩, ⟨-, hc⟩⟩
    refine ⟨hrlt, hrN, ?_, ?_, ?_⟩
    · change (a * r) % (N * pivot) = x % (N * pivot)
      simpa [Nat.mul_comm, Nat.mod_eq_of_lt hx] using ha
    · change (b * r) % (N * pivot) = y % (N * pivot)
      simpa [Nat.mul_comm, Nat.mod_eq_of_lt hy] using hb
    · change (c * r) % (N * pivot) = z % (N * pivot)
      simpa [Nat.mul_comm, Nat.mod_eq_of_lt hz] using hc
  · rintro ⟨hrlt, hrN, ha, hb, hc⟩
    refine ⟨⟨⟨⟨hrlt, hrN⟩, ?_⟩, ⟨⟨hrlt, hrN⟩, ?_⟩⟩,
      ⟨⟨hrlt, hrN⟩, ?_⟩⟩
    · change (a * r) % (N * pivot) = x % (N * pivot) at ha
      simpa [Nat.mul_comm, Nat.mod_eq_of_lt hx] using ha
    · change (b * r) % (N * pivot) = y % (N * pivot) at hb
      simpa [Nat.mul_comm, Nat.mod_eq_of_lt hy] using hb
    · change (c * r) % (N * pivot) = z % (N * pivot) at hc
      simpa [Nat.mul_comm, Nat.mod_eq_of_lt hz] using hc

/-- The candidate triple target is the non-`N`-divisible part of the raw
triple congruence fiber. -/
theorem pivotTripleTargetFiber_eq_filter_not_dvd
    (N pivot a b c x y z : ℕ) (hN : 0 < N) (hpivot : 0 < pivot)
    (hx : x < N * pivot) (hy : y < N * pivot)
    (hz : z < N * pivot) :
    pivotTripleTargetFiber N pivot a b c x y z =
      (tripleCongruenceNatResidues
        (N * pivot) a b c x y z).filter fun r => ¬N ∣ r := by
  have hM : 0 < N * pivot := Nat.mul_pos hN hpivot
  ext r
  rw [mem_pivotTripleTargetFiber_iff_modEq hM hx hy hz]
  simp only [Finset.mem_filter, mem_tripleCongruenceNatResidues]
  tauto

/-- The `N`-divisible part complementary to a candidate triple target. -/
def divisibleTripleCongruenceNatResidues
    (N pivot a b c x y z : ℕ) : Finset ℕ :=
  (tripleCongruenceNatResidues
    (N * pivot) a b c x y z).filter fun r => N ∣ r

theorem mem_divisibleTripleCongruenceNatResidues
    {N pivot a b c x y z r : ℕ} :
    r ∈ divisibleTripleCongruenceNatResidues
        N pivot a b c x y z ↔
      r < N * pivot ∧ N ∣ r ∧
      Nat.ModEq (N * pivot) (a * r) x ∧
      Nat.ModEq (N * pivot) (b * r) y ∧
      Nat.ModEq (N * pivot) (c * r) z := by
  simp only [divisibleTripleCongruenceNatResidues,
    Finset.mem_filter, mem_tripleCongruenceNatResidues]
  tauto

/-- Scaling by `N` identifies the smaller-modulus raw triple fiber with the
`N`-divisible part of the large-modulus fiber. -/
theorem mul_mem_divisibleTripleCongruenceNatResidues_iff
    (N pivot a b c x y z q : ℕ) (hN : 0 < N)
    (hxDvd : N ∣ x) (hyDvd : N ∣ y) (hzDvd : N ∣ z) :
    N * q ∈ divisibleTripleCongruenceNatResidues
        N pivot a b c x y z ↔
      q ∈ tripleCongruenceNatResidues
        pivot a b c (x / N) (y / N) (z / N) := by
  rw [mem_divisibleTripleCongruenceNatResidues,
    mem_tripleCongruenceNatResidues]
  have hxScale : N * (x / N) = x := Nat.mul_div_cancel' hxDvd
  have hyScale : N * (y / N) = y := Nat.mul_div_cancel' hyDvd
  have hzScale : N * (z / N) = z := Nat.mul_div_cancel' hzDvd
  constructor
  · rintro ⟨hq, -, ha, hb, hc⟩
    refine ⟨(Nat.mul_lt_mul_left hN).mp hq, ?_, ?_, ?_⟩
    · apply Nat.ModEq.mul_left_cancel' hN.ne'
      simpa [Nat.mul_assoc, Nat.mul_left_comm, Nat.mul_comm,
        hxScale] using ha
    · apply Nat.ModEq.mul_left_cancel' hN.ne'
      simpa [Nat.mul_assoc, Nat.mul_left_comm, Nat.mul_comm,
        hyScale] using hb
    · apply Nat.ModEq.mul_left_cancel' hN.ne'
      simpa [Nat.mul_assoc, Nat.mul_left_comm, Nat.mul_comm,
        hzScale] using hc
  · rintro ⟨hq, ha, hb, hc⟩
    refine ⟨(Nat.mul_lt_mul_left hN).mpr hq, dvd_mul_right N q,
      ?_, ?_, ?_⟩
    · simpa [Nat.mul_assoc, Nat.mul_left_comm, Nat.mul_comm,
        hxScale] using ha.mul_left' N
    · simpa [Nat.mul_assoc, Nat.mul_left_comm, Nat.mul_comm,
        hyScale] using hb.mul_left' N
    · simpa [Nat.mul_assoc, Nat.mul_left_comm, Nat.mul_comm,
        hzScale] using hc.mul_left' N

/-- Explicit image theorem for the bijection `q ↦ N * q`. -/
theorem divisibleTripleCongruenceNatResidues_eq_image
    (N pivot a b c x y z : ℕ) (hN : 0 < N)
    (hxDvd : N ∣ x) (hyDvd : N ∣ y) (hzDvd : N ∣ z) :
    divisibleTripleCongruenceNatResidues N pivot a b c x y z =
      (tripleCongruenceNatResidues
        pivot a b c (x / N) (y / N) (z / N)).image fun q => N * q := by
  classical
  ext r
  simp only [Finset.mem_image]
  constructor
  · intro hr
    have hrDvd := (mem_divisibleTripleCongruenceNatResidues.mp hr).2.1
    have hrScale : N * (r / N) = r := Nat.mul_div_cancel' hrDvd
    refine ⟨r / N, ?_, hrScale⟩
    rw [← mul_mem_divisibleTripleCongruenceNatResidues_iff
      N pivot a b c x y z (r / N) hN hxDvd hyDvd hzDvd]
    simpa [hrScale] using hr
  · rintro ⟨q, hq, rfl⟩
    exact (mul_mem_divisibleTripleCongruenceNatResidues_iff
      N pivot a b c x y z q hN hxDvd hyDvd hzDvd).2 hq

theorem card_divisibleTripleCongruenceNatResidues
    (N pivot a b c x y z : ℕ) (hN : 0 < N)
    (hxDvd : N ∣ x) (hyDvd : N ∣ y) (hzDvd : N ∣ z) :
    (divisibleTripleCongruenceNatResidues
      N pivot a b c x y z).card =
      (tripleCongruenceNatResidues
        pivot a b c (x / N) (y / N) (z / N)).card := by
  classical
  rw [divisibleTripleCongruenceNatResidues_eq_image
    N pivot a b c x y z hN hxDvd hyDvd hzDvd]
  apply Finset.card_image_iff.mpr
  intro q hq r hr hqr
  exact Nat.mul_left_cancel hN hqr

theorem dvd_first_target_of_mem_divisibleTripleCongruenceNatResidues
    {N pivot a b c x y z r : ℕ}
    (hr : r ∈ divisibleTripleCongruenceNatResidues
      N pivot a b c x y z) :
    N ∣ x := by
  have hrData := mem_divisibleTripleCongruenceNatResidues.mp hr
  have harDvd : N ∣ a * r :=
    dvd_mul_of_dvd_right hrData.2.1 a
  have haMod : Nat.ModEq N (a * r) x :=
    hrData.2.2.1.of_dvd (dvd_mul_right N pivot)
  exact Nat.modEq_zero_iff_dvd.mp
    ((harDvd.zero_modEq_nat.trans haMod).symm)

theorem dvd_second_target_of_mem_divisibleTripleCongruenceNatResidues
    {N pivot a b c x y z r : ℕ}
    (hr : r ∈ divisibleTripleCongruenceNatResidues
      N pivot a b c x y z) :
    N ∣ y := by
  have hrData := mem_divisibleTripleCongruenceNatResidues.mp hr
  have hbrDvd : N ∣ b * r :=
    dvd_mul_of_dvd_right hrData.2.1 b
  have hbMod : Nat.ModEq N (b * r) y :=
    hrData.2.2.2.1.of_dvd (dvd_mul_right N pivot)
  exact Nat.modEq_zero_iff_dvd.mp
    ((hbrDvd.zero_modEq_nat.trans hbMod).symm)

theorem dvd_third_target_of_mem_divisibleTripleCongruenceNatResidues
    {N pivot a b c x y z r : ℕ}
    (hr : r ∈ divisibleTripleCongruenceNatResidues
      N pivot a b c x y z) :
    N ∣ z := by
  have hrData := mem_divisibleTripleCongruenceNatResidues.mp hr
  have hcrDvd : N ∣ c * r :=
    dvd_mul_of_dvd_right hrData.2.1 c
  have hcMod : Nat.ModEq N (c * r) z :=
    hrData.2.2.2.2.of_dvd (dvd_mul_right N pivot)
  exact Nat.modEq_zero_iff_dvd.mp
    ((hcrDvd.zero_modEq_nat.trans hcMod).symm)

/-- Exact divisible-part count: it is zero unless all targets are divisible
by `N`, and otherwise is the smaller-modulus raw triple count. -/
theorem card_divisibleTripleCongruenceNatResidues_if
    (N pivot a b c x y z : ℕ) (hN : 0 < N) :
    (divisibleTripleCongruenceNatResidues
      N pivot a b c x y z).card =
      if N ∣ x ∧ N ∣ y ∧ N ∣ z then
        (tripleCongruenceNatResidues
          pivot a b c (x / N) (y / N) (z / N)).card
      else 0 := by
  classical
  by_cases hx : N ∣ x
  · by_cases hy : N ∣ y
    · by_cases hz : N ∣ z
      · rw [if_pos ⟨hx, hy, hz⟩]
        exact card_divisibleTripleCongruenceNatResidues
          N pivot a b c x y z hN hx hy hz
      · rw [if_neg (fun h => hz h.2.2)]
        apply Finset.card_eq_zero.mpr
        rw [Finset.eq_empty_iff_forall_notMem]
        intro r hr
        exact hz
          (dvd_third_target_of_mem_divisibleTripleCongruenceNatResidues hr)
    · rw [if_neg (fun h => hy h.2.1)]
      apply Finset.card_eq_zero.mpr
      rw [Finset.eq_empty_iff_forall_notMem]
      intro r hr
      exact hy
        (dvd_second_target_of_mem_divisibleTripleCongruenceNatResidues hr)
  · rw [if_neg (fun h => hx h.1)]
    apply Finset.card_eq_zero.mpr
    rw [Finset.eq_empty_iff_forall_notMem]
    intro r hr
    exact hx
      (dvd_first_target_of_mem_divisibleTripleCongruenceNatResidues hr)

/-- Candidate triple count equals the raw large-modulus count minus its
`N`-divisible part. -/
theorem candidateTripleCongruenceCount_eq_raw_sub_divisible
    (N pivot a b c x y z : ℕ) (hN : 0 < N) (hpivot : 0 < pivot)
    (hx : x < N * pivot) (hy : y < N * pivot)
    (hz : z < N * pivot) :
    candidateTripleCongruenceCount N pivot a b c x y z =
      (tripleCongruenceNatResidues
        (N * pivot) a b c x y z).card -
      (divisibleTripleCongruenceNatResidues
        N pivot a b c x y z).card := by
  rw [candidateTripleCongruenceCount,
    pivotTripleTargetFiber_eq_filter_not_dvd
      N pivot a b c x y z hN hpivot hx hy hz]
  have hsplit := Finset.card_filter_add_card_filter_not
    (s := tripleCongruenceNatResidues (N * pivot) a b c x y z)
    (p := fun r => N ∣ r)
  change
    ((tripleCongruenceNatResidues
      (N * pivot) a b c x y z).filter fun r => N ∣ r).card +
    ((tripleCongruenceNatResidues
      (N * pivot) a b c x y z).filter fun r => ¬N ∣ r).card =
    (tripleCongruenceNatResidues
      (N * pivot) a b c x y z).card at hsplit
  change
    ((tripleCongruenceNatResidues
      (N * pivot) a b c x y z).filter fun r => ¬N ∣ r).card =
    (tripleCongruenceNatResidues
      (N * pivot) a b c x y z).card -
    ((tripleCongruenceNatResidues
      (N * pivot) a b c x y z).filter fun r => N ∣ r).card
  omega

/-- Raw-minus-conditional-smaller form of the candidate triple count. -/
theorem candidateTripleCongruenceCount_eq_raw_sub_if
    (N pivot a b c x y z : ℕ) (hN : 0 < N) (hpivot : 0 < pivot)
    (hx : x < N * pivot) (hy : y < N * pivot)
    (hz : z < N * pivot) :
    candidateTripleCongruenceCount N pivot a b c x y z =
      (tripleCongruenceNatResidues
        (N * pivot) a b c x y z).card -
      if N ∣ x ∧ N ∣ y ∧ N ∣ z then
        (tripleCongruenceNatResidues
          pivot a b c (x / N) (y / N) (z / N)).card
      else 0 := by
  rw [candidateTripleCongruenceCount_eq_raw_sub_divisible
    N pivot a b c x y z hN hpivot hx hy hz]
  rw [card_divisibleTripleCongruenceNatResidues_if
    N pivot a b c x y z hN]

/-- Anchor-facing presentation: a triple target is a pair target refined by
one further exact target fiber. -/
theorem pivotTripleTargetFiber_eq_pair_inter_target
    (N pivot a b c x y z : ℕ) :
    pivotTripleTargetFiber N pivot a b c x y z =
      pivotPairTargetFiber N pivot a b x y ∩
        pivotTargetFiber N pivot c z := by
  rfl

theorem candidateTripleCongruenceCount_eq_card_pair_inter_target
    (N pivot a b c x y z : ℕ) :
    candidateTripleCongruenceCount N pivot a b c x y z =
      (pivotPairTargetFiber N pivot a b x y ∩
        pivotTargetFiber N pivot c z).card := by
  rfl

/-- Closed exact arithmetic expression for one pivot triple target. -/
def exactCandidateTripleCongruenceCount
    (N pivot a b c x y z : ℕ) : ℕ :=
  (if TripleCongruenceCompatible
      (N * pivot) a b c x y z then
      (N * pivot).gcd (a.gcd (b.gcd c))
    else 0) -
    if N ∣ x ∧ N ∣ y ∧ N ∣ z then
      if TripleCongruenceCompatible
          pivot a b c (x / N) (y / N) (z / N) then
        pivot.gcd (a.gcd (b.gcd c))
      else 0
    else 0

/-- Fully evaluated candidate triple-target count, with positivity and all
canonical-target bounds explicit. -/
theorem candidateTripleCongruenceCount_exact
    (N pivot a b c x y z : ℕ) (hN : 0 < N) (hpivot : 0 < pivot)
    (hx : x < N * pivot) (hy : y < N * pivot)
    (hz : z < N * pivot) :
    candidateTripleCongruenceCount N pivot a b c x y z =
      exactCandidateTripleCongruenceCount N pivot a b c x y z := by
  rw [candidateTripleCongruenceCount_eq_raw_sub_if
    N pivot a b c x y z hN hpivot hx hy hz]
  rw [card_tripleCongruenceNatResidues_exact
    (N * pivot) a b c x y z (Nat.mul_pos hN hpivot)]
  rw [card_tripleCongruenceNatResidues_exact
    pivot a b c (x / N) (y / N) (z / N) hpivot]
  rfl

/-- Strict-ball specialization supplies canonical target bounds while
preserving every strict endpoint. -/
theorem candidateTripleCongruenceCount_exact_of_mem_strictCyclicBall
    (N pivot a b c x y z : ℕ) (hN : 0 < N) (hpivot : 0 < pivot)
    (hxBall : x ∈ strictCyclicBall (N * pivot) pivot)
    (hyBall : y ∈ strictCyclicBall (N * pivot) pivot)
    (hzBall : z ∈ strictCyclicBall (N * pivot) pivot) :
    candidateTripleCongruenceCount N pivot a b c x y z =
      exactCandidateTripleCongruenceCount N pivot a b c x y z := by
  apply candidateTripleCongruenceCount_exact
    N pivot a b c x y z hN hpivot
  · exact Finset.mem_range.mp (Finset.mem_filter.mp hxBall).1
  · exact Finset.mem_range.mp (Finset.mem_filter.mp hyBall).1
  · exact Finset.mem_range.mp (Finset.mem_filter.mp hzBall).1

end LonelyRunner
