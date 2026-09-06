import LonelyRunner.TwoDivisibleSmallPair
import LonelyRunner.ThreeLabelPigeonhole
import LonelyRunner.FiveMovingFast

/-!
# A supplied two-divisible cover

The cover forces two exceptional labels to divide the same divisible target.
Before choosing them, fast-runner insertion excludes both extreme ratios; the
checked small-pair result then supplies the positive sixth-margin witness.
-/

namespace LonelyRunner

/-- A factor-six cover by two labels divisible by three yields a positive
closed sixth-margin time. -/
theorem fiveMovingNaturalRunners_of_two_divisible_cover
    (v : Fin 5 → ℕ) (hpos : ∀ i, 0 < v i)
    (p q : Fin 5) (hpq : p ≠ q)
    (hdiv : ∀ i, 3 ∣ v i ↔ i = p ∨ i = q)
    (hcover : ∀ i, i ≠ p → i ≠ q →
      6 * v i ∣ v p ∨ 6 * v i ∣ v q) :
    ∃ t : ℝ, 0 < t ∧ ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ)) := by
  by_contra hnowitness
  have hpqratio : v p < 5 * v q := by
    apply Nat.lt_of_not_ge
    intro hqp
    apply hnowitness
    apply fiveMovingNaturalRunners_of_fast_speed v hpos p
    intro i hip
    by_cases hiq : i = q
    · subst i
      exact hqp
    · rcases hcover i hip hiq with htoP | htoQ
      · have hle := Nat.le_of_dvd (hpos p) htoP
        omega
      · have hleQ := Nat.le_of_dvd (hpos q) htoQ
        omega
  have hqpratio : v q < 5 * v p := by
    apply Nat.lt_of_not_ge
    intro hpqle
    apply hnowitness
    apply fiveMovingNaturalRunners_of_fast_speed v hpos q
    intro i hiq
    by_cases hip : i = p
    · subst i
      exact hpqle
    · rcases hcover i hip hiq with htoP | htoQ
      · have hleP := Nat.le_of_dvd (hpos p) htoP
        omega
      · have hle := Nat.le_of_dvd (hpos q) htoQ
        omega
  let E : Finset (Fin 5) := Finset.univ.filter (fun i => ¬ 3 ∣ v i)
  have hEcard : 3 ≤ E.card := by
    simpa [E] using
      (three_exceptions_of_two_divisible_labels v p q hpq hdiv).ge
  have hEcover : ∀ i ∈ E, 6 * v i ∣ v p ∨ 6 * v i ∣ v q := by
    intro i hi
    have hnotdiv : ¬ 3 ∣ v i := (Finset.mem_filter.mp hi).2
    apply hcover i
    · intro hip
      exact hnotdiv ((hdiv i).mpr (Or.inl hip))
    · intro hiq
      exact hnotdiv ((hdiv i).mpr (Or.inr hiq))
  rcases exists_two_same_side_of_three E hEcard
    (fun i => 6 * v i ∣ v p) (fun i => 6 * v i ∣ v q) hEcover with hP | hQ
  · rcases hP with ⟨u, hu, w, hw, huw, hUP, hWP⟩
    apply hnowitness
    exact two_divisible_pair_small_witness v hpos p q hpq hdiv hpqratio hqpratio
      u w huw (Nat.le_of_dvd (hpos p) hUP) (Nat.le_of_dvd (hpos p) hWP)
  · rcases hQ with ⟨u, hu, w, hw, huw, hUQ, hWQ⟩
    apply hnowitness
    exact two_divisible_pair_small_witness v hpos q p hpq.symm
      (fun i => by simpa [or_comm] using hdiv i) hqpratio hpqratio u w huw
      (Nat.le_of_dvd (hpos q) hUQ) (Nat.le_of_dvd (hpos q) hWQ)

end LonelyRunner
