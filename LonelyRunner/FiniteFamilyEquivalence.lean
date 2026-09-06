import LonelyRunner.FinitePrimitiveFamilies
import LonelyRunner.BHKRealReduction
import LonelyRunner.BaseCases

/-!
# Finite primitive families and the canonical conjecture

This file separates the fixed finite-height family obligation from the
lower-dimensional supply used by the large-height reduction.  Strong induction
then supplies that lower-dimensional hypothesis at each moving-runner count.
-/

namespace LonelyRunner

noncomputable section

/-- The positive-integer stationary statement at one fixed moving-runner count. -/
def PositiveIntegerAtCount (n : ℕ) : Prop :=
  ∀ a : Fin n → ℕ,
    Function.Injective a → (∀ i, 0 < a i) →
    ∃ t : ℝ, ∀ i,
      (((n + 1 : ℕ) : ℝ)⁻¹) ≤ circleNorm (t * (a i : ℝ))

/-- Positive-integer witnesses at every earlier moving count give exactly the
bounded lower-count supply required at total count `n + 1`. -/
theorem lowerCount_of_previous_counts {n : ℕ} (hn : 2 ≤ n)
    (hprevious : ∀ d : ℕ, 1 ≤ d → d < n → PositiveIntegerAtCount d) :
    LowerCountPositiveIntegerHypothesis (n + 1) := by
  intro d hd hdn speeds hinj hpos
  exact hprevious d hd (by omega) speeds hinj hpos

/-- Appending the stationary zero turns a positive moving integer tuple into a
full distinct integer tuple.  The fixed-count bridge supplies a witness for the
new last label, whose relative speeds are the original moving speeds. -/
theorem positiveIntegerAtCount_of_lower_and_finiteFamily {m : ℕ}
    (hm : 1 ≤ m)
    (hLower : LowerCountPositiveIntegerHypothesis (m + 2))
    (hFinite : InclusivePrimitiveFiniteFamily m) :
    PositiveIntegerAtCount (m + 1) := by
  intro a hinj hpos
  let full : Fin (m + 2) → ℤ := Fin.lastCases 0 (fun i => (a i : ℤ))
  have hfullinj : Function.Injective full := by
    intro i j hij
    cases i using Fin.lastCases with
    | last =>
        cases j using Fin.lastCases with
        | last => rfl
        | cast j =>
            dsimp [full] at hij
            simp only [Fin.lastCases_last, Fin.lastCases_castSucc] at hij
            exact (Int.ofNat_ne_zero.mpr (Nat.ne_of_gt (hpos j)) hij.symm).elim
    | cast i =>
        cases j using Fin.lastCases with
        | last =>
            dsimp [full] at hij
            simp only [Fin.lastCases_castSucc, Fin.lastCases_last] at hij
            exact (Int.ofNat_ne_zero.mpr (Nat.ne_of_gt (hpos i)) hij).elim
        | cast j =>
            dsimp [full] at hij
            simp only [Fin.lastCases_castSucc] at hij
            have ha : a i = a j := by exact_mod_cast hij
            have heq : i = j := hinj ha
            subst j
            rfl
  obtain ⟨t, ht⟩ :=
    integer_lonelyAt_of_lower_and_finiteFamily hm hLower hFinite full hfullinj
      (Fin.last (m + 1))
  refine ⟨t, fun i => ?_⟩
  have hi := (lonelyAt_iff_relativeLonelyAt (fun j => (full j : ℝ))
    (Fin.last (m + 1)) t).mp ht i.castSucc (Fin.castSucc_ne_last i)
  simpa [full, circleNorm, Nat.add_assoc] using hi

/-- The all-count finite-family assumption supplies every positive-integer
moving count by strong induction.  Count one is handled directly, while the
inductive step uses the preceding counts only through the lower-count supply. -/
theorem positiveIntegerConjecture_of_allInclusivePrimitiveFiniteFamilies
    (hFinite : AllInclusivePrimitiveFiniteFamilies) :
    PositiveIntegerConjecture := by
  have hcounts : ∀ n : ℕ, 1 ≤ n → PositiveIntegerAtCount n := by
    intro n
    induction n using Nat.strong_induction_on with
    | h n ih =>
        intro hn
        by_cases hone : n = 1
        · subst n
          intro a _ hpos
          obtain ⟨t, ht⟩ := oneMovingRunner (a 0 : ℝ)
            (by exact_mod_cast (Nat.ne_of_gt (hpos 0)))
          refine ⟨t, fun i => ?_⟩
          have hi : i = 0 := Fin.eq_zero i
          subst i
          simpa [circleNorm] using ht
        · have hnTwo : 2 ≤ n := by omega
          let m : ℕ := n - 1
          have hm : 1 ≤ m := by
            dsimp [m]
            omega
          have hprevious : ∀ d : ℕ, 1 ≤ d → d < n → PositiveIntegerAtCount d := by
            intro d hd hdlt
            exact ih d hdlt hd
          have hLower : LowerCountPositiveIntegerHypothesis (m + 2) := by
            have h := lowerCount_of_previous_counts hnTwo hprevious
            convert h using 1 <;> omega
          have hcurrent := positiveIntegerAtCount_of_lower_and_finiteFamily hm
            hLower (hFinite m hm)
          convert hcurrent using 1 <;> omega
  intro n hn speeds hinj hpos
  have h := hcounts n hn speeds hinj hpos
  simpa [circleNorm] using h

/-- The canonical conjecture holds exactly when all bounded primitive finite
families hold.  The forward direction specializes canonical witnesses; the
reverse direction first establishes every positive-integer moving count. -/
theorem conjecture_iff_allInclusivePrimitiveFiniteFamilies :
    Conjecture ↔ AllInclusivePrimitiveFiniteFamilies := by
  constructor
  · intro hConjecture m hm s hsmono _ _ _ r
    have hsinj : Function.Injective (fun i => (s i : ℝ)) := by
      intro i j hij
      apply hsmono.injective
      exact Nat.cast_injective hij
    obtain ⟨t, ht⟩ := hConjecture (m + 2) (by omega)
      (fun i => (s i : ℝ)) hsinj r
    exact ⟨t, ht⟩
  · intro hFinite
    exact conjecture_iff_positiveIntegerConjecture.mpr
      (positiveIntegerConjecture_of_allInclusivePrimitiveFiniteFamilies hFinite)

/-- Positive speeds with an appended zero meet the nonnegative stationary
normalization contract, so the sharper finite family supplies this count. -/
theorem positiveIntegerAtCount_of_lower_and_sharperFiniteFamily {m : ℕ}
    (hm : 1 ≤ m)
    (hLower : LowerCountPositiveIntegerHypothesis (m + 2))
    (hFinite : SharperInclusivePrimitiveFiniteFamily m) :
    PositiveIntegerAtCount (m + 1) := by
  intro a hinj hpos
  let full : Fin (m + 2) → ℤ := Fin.lastCases 0 (fun i => (a i : ℤ))
  have hfullinj : Function.Injective full := by
    intro i j hij
    cases i using Fin.lastCases with
    | last =>
        cases j using Fin.lastCases with
        | last => rfl
        | cast j =>
            dsimp [full] at hij
            simp only [Fin.lastCases_last, Fin.lastCases_castSucc] at hij
            exact (Int.ofNat_ne_zero.mpr (Nat.ne_of_gt (hpos j)) hij.symm).elim
    | cast i =>
        cases j using Fin.lastCases with
        | last =>
            dsimp [full] at hij
            simp only [Fin.lastCases_castSucc, Fin.lastCases_last] at hij
            exact (Int.ofNat_ne_zero.mpr (Nat.ne_of_gt (hpos i)) hij).elim
        | cast j =>
            dsimp [full] at hij
            simp only [Fin.lastCases_castSucc] at hij
            have ha : a i = a j := by exact_mod_cast hij
            have heq : i = j := hinj ha
            subst j
            rfl
  have hfullnonneg : ∀ i, 0 ≤ full i := by
    intro i
    cases i using Fin.lastCases with
    | last => simp [full]
    | cast i => simp [full]
  obtain ⟨t, ht⟩ :=
    nonnegative_integer_stationary_lonelyAt_of_lower_and_sharperFiniteFamily
      hm hLower hFinite full hfullinj hfullnonneg (Fin.last (m + 1))
      (by simp [full])
  refine ⟨t, fun i => ?_⟩
  have hi := (lonelyAt_iff_relativeLonelyAt (fun j => (full j : ℝ))
    (Fin.last (m + 1)) t).mp ht i.castSucc (Fin.castSucc_ne_last i)
  simpa [full, circleNorm, Nat.add_assoc] using hi

/-- Strong induction closes the sharper finite-family reduction. The total
count two case uses the existing direct one-moving-runner theorem. -/
theorem positiveIntegerConjecture_of_allSharperInclusivePrimitiveFiniteFamilies
    (hFinite : AllSharperInclusivePrimitiveFiniteFamilies) :
    PositiveIntegerConjecture := by
  have hcounts : ∀ n : ℕ, 1 ≤ n → PositiveIntegerAtCount n := by
    intro n
    induction n using Nat.strong_induction_on with
    | h n ih =>
        intro hn
        by_cases hone : n = 1
        · subst n
          intro a _ hpos
          obtain ⟨t, ht⟩ := oneMovingRunner (a 0 : ℝ)
            (by exact_mod_cast (Nat.ne_of_gt (hpos 0)))
          refine ⟨t, fun i => ?_⟩
          have hi : i = 0 := Fin.eq_zero i
          subst i
          simpa [circleNorm] using ht
        · have hnTwo : 2 ≤ n := by omega
          let m : ℕ := n - 1
          have hm : 1 ≤ m := by
            dsimp [m]
            omega
          have hprevious : ∀ d : ℕ, 1 ≤ d → d < n → PositiveIntegerAtCount d := by
            intro d hd hdlt
            exact ih d hdlt hd
          have hLower : LowerCountPositiveIntegerHypothesis (m + 2) := by
            have h := lowerCount_of_previous_counts hnTwo hprevious
            convert h using 1 <;> omega
          have hcurrent := positiveIntegerAtCount_of_lower_and_sharperFiniteFamily hm
            hLower (hFinite m hm)
          convert hcurrent using 1 <;> omega
  intro n hn speeds hinj hpos
  have h := hcounts n hn speeds hinj hpos
  simpa [circleNorm] using h

/-- The canonical conjecture holds exactly when all bounded primitive finite
families hold.  The forward direction specializes canonical witnesses; the
reverse direction first establishes every positive-integer moving count. -/
theorem conjecture_iff_allSharperInclusivePrimitiveFiniteFamilies :
    Conjecture ↔ AllSharperInclusivePrimitiveFiniteFamilies := by
  constructor
  · intro hConjecture m hm s hsmono _ _ _ r
    have hsinj : Function.Injective (fun i => (s i : ℝ)) := by
      intro i j hij
      apply hsmono.injective
      exact Nat.cast_injective hij
    obtain ⟨t, ht⟩ := hConjecture (m + 2) (by omega)
      (fun i => (s i : ℝ)) hsinj r
    exact ⟨t, ht⟩
  · intro hFinite
    exact conjecture_iff_positiveIntegerConjecture.mpr
      (positiveIntegerConjecture_of_allSharperInclusivePrimitiveFiniteFamilies hFinite)

end

end LonelyRunner
