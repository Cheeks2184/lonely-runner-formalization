import LonelyRunner.Formulations

/-!
# Equivalence with the distinct stationary-runner formulation

This file carries out the finite reindexing that relates the canonical
labelled-runner conjecture to `DistinctStationaryConjecture`.

For the forward implication, a stationary runner is appended at `Fin.last n`.
For the reverse implication, `runner.succAbove : Fin (n + 1) → Fin (n + 2)`
enumerates exactly the runners other than the selected runner.  Using this
explicit embedding avoids a choice of equivalence and makes the denominator
identity `(n + 1) + 1 = n + 2` visible to the simplifier.
-/

namespace LonelyRunner

/-- Appending a zero speed to an injective family of nonzero speeds preserves
injectivity.  The zero is placed at the final index. -/
theorem injective_lastCases_zero {n : ℕ} {speeds : Fin n → ℝ}
    (hspeeds : Function.Injective speeds) (hne : ∀ i, speeds i ≠ 0) :
    Function.Injective (Fin.lastCases 0 speeds : Fin (n + 1) → ℝ) := by
  intro i j hij
  cases i using Fin.lastCases with
  | last =>
      cases j using Fin.lastCases with
      | last => rfl
      | cast j =>
          simp only [Fin.lastCases_last, Fin.lastCases_castSucc] at hij
          exact (hne j hij.symm).elim
  | cast i =>
      cases j using Fin.lastCases with
      | last =>
          simp only [Fin.lastCases_castSucc, Fin.lastCases_last] at hij
          exact (hne i hij).elim
      | cast j =>
          simp only [Fin.lastCases_castSucc] at hij
          simpa using hspeeds hij

/-- Relative speeds of all runners other than a selected runner are injective
when the original labelled speed family is injective. -/
theorem injective_relative_succAbove {n : ℕ} {speeds : Fin (n + 1) → ℝ}
    (hspeeds : Function.Injective speeds) (runner : Fin (n + 1)) :
    Function.Injective
      (fun i : Fin n ↦ speeds (runner.succAbove i) - speeds runner) := by
  intro i j hij
  apply Fin.succAbove_right_injective
  apply hspeeds
  exact sub_left_injective hij

/-- No relative speed in the `succAbove` enumeration is zero when the original
labelled speed family is injective. -/
theorem relative_succAbove_ne_zero {n : ℕ} {speeds : Fin (n + 1) → ℝ}
    (hspeeds : Function.Injective speeds) (runner : Fin (n + 1)) :
    ∀ i : Fin n, speeds (runner.succAbove i) - speeds runner ≠ 0 := by
  intro i hzero
  exact Fin.succAbove_ne runner i (hspeeds (sub_eq_zero.mp hzero))

/-- The canonical labelled-runner conjecture implies the distinct stationary
formulation by appending a zero-speed runner. -/
theorem conjecture_implies_distinctStationaryConjecture :
    Conjecture → DistinctStationaryConjecture := by
  intro hconjecture n hn speeds hspeeds hne
  let fullSpeeds : Fin (n + 1) → ℝ := Fin.lastCases 0 speeds
  have hfull : Function.Injective fullSpeeds := by
    exact injective_lastCases_zero hspeeds hne
  have hrelative : RelativeConjecture :=
    conjecture_iff_relativeConjecture.mp hconjecture
  obtain ⟨time, htime⟩ :=
    hrelative (n + 1) (by omega) fullSpeeds hfull (Fin.last n)
  refine ⟨time, fun i ↦ ?_⟩
  have hi := htime i.castSucc (Fin.castSucc_ne_last i)
  simpa [fullSpeeds] using hi

/-- The distinct stationary formulation implies the relative-velocity form of
the canonical conjecture.  Writing the total runner count as `n + 2` makes
`runner.succAbove` the exact complement enumeration. -/
theorem distinctStationaryConjecture_implies_relativeConjecture :
    DistinctStationaryConjecture → RelativeConjecture := by
  intro hstationary total htotal speeds hspeeds runner
  obtain ⟨n, rfl⟩ : ∃ n, total = n + 2 := Nat.exists_eq_add_of_le' htotal
  let relativeSpeeds : Fin (n + 1) → ℝ :=
    fun i ↦ speeds (runner.succAbove i) - speeds runner
  have hrelativeInjective : Function.Injective relativeSpeeds := by
    exact injective_relative_succAbove hspeeds runner
  have hrelativeNonzero : ∀ i, relativeSpeeds i ≠ 0 := by
    exact relative_succAbove_ne_zero hspeeds runner
  obtain ⟨time, htime⟩ :=
    hstationary (n + 1) (by omega) relativeSpeeds
      hrelativeInjective hrelativeNonzero
  refine ⟨time, ?_⟩
  intro other hother
  obtain ⟨i, rfl⟩ := Fin.exists_succAbove_eq hother
  simpa [relativeSpeeds, Nat.add_assoc] using htime i

/-- The canonical labelled-runner conjecture is exactly equivalent to the
stationary-runner formulation with distinct, nonzero moving speeds. -/
theorem conjecture_iff_distinctStationaryConjecture :
    Conjecture ↔ DistinctStationaryConjecture := by
  constructor
  · exact conjecture_implies_distinctStationaryConjecture
  · intro hstationary
    apply conjecture_iff_relativeConjecture.mpr
    exact distinctStationaryConjecture_implies_relativeConjecture hstationary

end LonelyRunner
