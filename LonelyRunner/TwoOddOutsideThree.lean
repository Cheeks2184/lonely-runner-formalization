import Mathlib.Tactic

/-!
# Two odd labels outside a three-label even set

The three prescribed even labels exhaust the bounded even-label set.  Its
two-label complement supplies the required odd labels without comparing speed
values.
-/

namespace LonelyRunner

/-- If at most three labels have even speed and three distinct prescribed
labels are even, the remaining two labels are odd and exhaust the complement. -/
theorem exists_two_odd_outside_three
    (v : Fin 5 → ℕ) (p q r : Fin 5)
    (hpq : p ≠ q) (hrp : r ≠ p) (hrq : r ≠ q)
    (hp : 2 ∣ v p) (hq : 2 ∣ v q) (hr : 2 ∣ v r)
    (heven : ((Finset.univ : Finset (Fin 5)).filter (fun i => 2 ∣ v i)).card ≤ 3) :
    ∃ u w : Fin 5, u ≠ w ∧ ¬ 2 ∣ v u ∧ ¬ 2 ∣ v w ∧
      ∀ i : Fin 5, i = p ∨ i = q ∨ i = r ∨ i = u ∨ i = w := by
  classical
  let K : Finset (Fin 5) := {p, q, r}
  let E : Finset (Fin 5) := Finset.univ.filter (fun i => 2 ∣ v i)
  have hpr : p ≠ r := hrp.symm
  have hqr : q ≠ r := hrq.symm
  have hKcard : K.card = 3 := by
    simp [K, hpq, hpr, hqr]
  have hKE : K ⊆ E := by
    intro i hi
    rcases (by simpa [K] using hi) with rfl | rfl | rfl
    · exact Finset.mem_filter.mpr ⟨Finset.mem_univ _, hp⟩
    · exact Finset.mem_filter.mpr ⟨Finset.mem_univ _, hq⟩
    · exact Finset.mem_filter.mpr ⟨Finset.mem_univ _, hr⟩
  have hEcard : E.card = 3 := by
    have hle := Finset.card_le_card hKE
    change E.card ≤ 3 at heven
    omega
  have hKEeq : K = E := by
    apply Finset.eq_of_subset_of_card_le hKE
    omega
  let O : Finset (Fin 5) := Finset.univ \ E
  have hOcard : O.card = 2 := by
    dsimp [O]
    rw [Finset.card_sdiff_of_subset (show E ⊆ Finset.univ from Finset.subset_univ E), hEcard]
    decide
  obtain ⟨u, w, huw, hO⟩ := Finset.card_eq_two.mp hOcard
  have huO : u ∈ O := by rw [hO]; simp
  have hwO : w ∈ O := by rw [hO]; simp
  have huodd : ¬ 2 ∣ v u := by
    intro hu
    have huE : u ∈ E := Finset.mem_filter.mpr ⟨Finset.mem_univ _, hu⟩
    exact (Finset.mem_sdiff.mp huO).2 huE
  have hwodd : ¬ 2 ∣ v w := by
    intro hw
    have hwE : w ∈ E := Finset.mem_filter.mpr ⟨Finset.mem_univ _, hw⟩
    exact (Finset.mem_sdiff.mp hwO).2 hwE
  refine ⟨u, w, huw, huodd, hwodd, ?_⟩
  intro i
  by_cases hiE : i ∈ E
  · have hiK : i ∈ K := by rwa [hKEeq]
    have hcases : i = p ∨ i = q ∨ i = r := by simpa [K] using hiK
    rcases hcases with h | h | h
    · exact Or.inl h
    · exact Or.inr (Or.inl h)
    · exact Or.inr (Or.inr (Or.inl h))
  · have hiO : i ∈ O := Finset.mem_sdiff.mpr ⟨Finset.mem_univ _, hiE⟩
    have hiuw : i = u ∨ i = w := by simpa [hO] using hiO
    rcases hiuw with rfl | rfl
    · exact Or.inr (Or.inr (Or.inr (Or.inl rfl)))
    · exact Or.inr (Or.inr (Or.inr (Or.inr rfl)))

end LonelyRunner
