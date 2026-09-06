import LonelyRunner.PairSumCompleteness
import Mathlib.Data.Finset.Max

/-!
# Strict pair-sum completeness

A strict finite witness has a positive attained minimum margin.  Applying the
closed pair-sum completeness theorem at that margin preserves strict slack.
-/

namespace LonelyRunner

/-- Strict witnesses for positive natural speeds are exactly strict pair-sum
witnesses.  The two selected indices are distinct labels; speeds may repeat. -/
theorem exists_strictWitness_iff_pairSum {n : ℕ} (hn : 2 ≤ n)
    (speeds : Fin n → ℕ) (hspeeds : ∀ i, 0 < speeds i) (δ : ℝ) (hδ : 0 < δ) :
    (∃ time : ℝ, ∀ i, δ < circleNorm (time * (speeds i : ℝ))) ↔
      ∃ p q : Fin n, p ≠ q ∧ ∃ r : ℕ,
        0 < r ∧ r < speeds p + speeds q ∧ ∀ i,
          δ < circleNorm (((r : ℝ) / ((speeds p + speeds q : ℕ) : ℝ)) *
            (speeds i : ℝ)) := by
  classical
  constructor
  · rintro ⟨time, htime⟩
    let f : Fin n → ℝ := fun i => circleNorm (time * (speeds i : ℝ))
    have hnonempty : (Finset.univ : Finset (Fin n)).Nonempty := by
      exact ⟨⟨0, by omega⟩, Finset.mem_univ _⟩
    obtain ⟨j, hj, hjmin⟩ :=
      Finset.exists_min_image (Finset.univ : Finset (Fin n)) f hnonempty
    have hδm : δ < f j := by simpa [f] using htime j
    obtain ⟨p, q, hpq, r, hr0, hrlt, hgood⟩ :=
      exists_pairSum_time_of_witness hn speeds hspeeds (f j) time
        (lt_trans hδ hδm) (fun i => hjmin i (Finset.mem_univ _))
    refine ⟨p, q, hpq, r, hr0, hrlt, fun i => ?_⟩
    exact lt_of_lt_of_le hδm (hgood i)
  · rintro ⟨p, q, hpq, r, hr0, hrlt, hgood⟩
    refine ⟨(r : ℝ) / ((speeds p + speeds q : ℕ) : ℝ), hgood⟩

end LonelyRunner
