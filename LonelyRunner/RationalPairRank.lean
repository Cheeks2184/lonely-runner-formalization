import LonelyRunner.StationaryEquivalence

namespace LonelyRunner

/-- Two rational rows have rank two when one explicit `2 × 2` minor is
nonzero. -/
def RationalPairRankTwo {ι : Type*} (u : ι → ℤ) (v : ι → ℚ) : Prop :=
  ∃ i j, (u i : ℚ) * v j ≠ (u j : ℚ) * v i

/-- A nonzero minor eliminates any common rational linear relation. -/
theorem rationalPairRankTwo_elim {ι : Type*} (u : ι → ℤ) (v : ι → ℚ)
    (hrank : RationalPairRankTwo u v) (A B : ℚ)
    (hrel : ∀ i, A * (u i : ℚ) + B * v i = 0) : A = 0 ∧ B = 0 := by
  obtain ⟨i, j, hij⟩ := hrank
  have hi := hrel i
  have hj := hrel j
  have hAprod : A * ((u i : ℚ) * v j - (u j : ℚ) * v i) = 0 := by
    calc
      A * ((u i : ℚ) * v j - (u j : ℚ) * v i) =
          (A * (u i : ℚ) + B * v i) * v j -
            (A * (u j : ℚ) + B * v j) * v i := by ring
      _ = 0 := by rw [hi, hj]; ring
  have hBprod : B * ((u i : ℚ) * v j - (u j : ℚ) * v i) = 0 := by
    calc
      B * ((u i : ℚ) * v j - (u j : ℚ) * v i) =
          (A * (u j : ℚ) + B * v j) * (u i : ℚ) -
            (A * (u i : ℚ) + B * v i) * (u j : ℚ) := by ring
      _ = 0 := by rw [hi, hj]; ring
  constructor
  · exact (mul_eq_zero.mp hAprod).resolve_right (sub_ne_zero.mpr hij)
  · exact (mul_eq_zero.mp hBprod).resolve_right (sub_ne_zero.mpr hij)

/-- Rank two of anchored rational rows forces the relative affine ratios to
be nonconstant after deleting any chosen label. -/
theorem relative_ratio_nonconstant_of_rankTwo {m : ℕ}
    (u : Fin (m + 2) → ℤ) (v : Fin (m + 2) → ℚ) (p : ℚ)
    (hu0 : u 0 = 0) (hv0 : v 0 = 0)
    (hrank : RationalPairRankTwo u v)
    (hinj : Function.Injective (fun i => p * (u i : ℚ) + v i))
    (r : Fin (m + 2)) :
    ∃ a b : Fin (m + 1),
      ((u (r.succAbove a) - u r : ℤ) : ℚ) /
          (p * ((u (r.succAbove a) - u r : ℤ) : ℚ) +
            (v (r.succAbove a) - v r)) ≠
      ((u (r.succAbove b) - u r : ℤ) : ℚ) /
          (p * ((u (r.succAbove b) - u r : ℤ) : ℚ) +
            (v (r.succAbove b) - v r)) := by
  let U : Fin (m + 1) → ℚ := fun a => ((u (r.succAbove a) - u r : ℤ) : ℚ)
  let V : Fin (m + 1) → ℚ := fun a => v (r.succAbove a) - v r
  let D : Fin (m + 1) → ℚ := fun a => p * U a + V a
  have hD : ∀ a, D a ≠ 0 := by
    intro a hzero
    apply Fin.succAbove_ne r a
    apply hinj
    dsimp [D, U, V] at hzero
    push_cast at hzero
    linarith
  by_contra hnonconstant
  push Not at hnonconstant
  let a0 : Fin (m + 1) := 0
  let lam : ℚ := U a0 / D a0
  have hall : ∀ a, U a / D a = lam := by
    intro a
    exact hnonconstant a a0
  have hrel : ∀ a, (1 - lam * p) * U a - lam * V a = 0 := by
    intro a
    have hlam : lam * D a = U a := by
      have ha : U a = D a * lam := by
        calc
          U a = (U a / D a) * D a := (div_mul_cancel₀ (U a) (hD a)).symm
          _ = lam * D a := by rw [hall a]
          _ = D a * lam := by ring
      rw [mul_comm]
      exact ha.symm
    calc
      (1 - lam * p) * U a - lam * V a = U a - lam * D a := by
        dsimp [D]
        ring
      _ = 0 := by rw [← hlam]; ring
  have hrelOrig : ∀ i : Fin (m + 2),
      (1 - lam * p) * ((u i : ℚ) - (u r : ℚ)) -
        lam * (v i - v r) = 0 := by
    intro i
    by_cases hir : i = r
    · subst i
      ring
    · obtain ⟨a, ha⟩ := Fin.exists_succAbove_eq hir
      subst i
      simpa [U, V] using hrel a
  have hbase := hrelOrig 0
  have hbase' : (1 - lam * p) * (u r : ℚ) - lam * v r = 0 := by
    rw [hu0, hv0] at hbase
    norm_num at hbase
    linarith
  have hglobal : ∀ i, (1 - lam * p) * (u i : ℚ) + (-lam) * v i = 0 := by
    intro i
    have hi := hrelOrig i
    linarith
  obtain ⟨hA, hB⟩ := rationalPairRankTwo_elim u v hrank
    (1 - lam * p) (-lam) hglobal
  have hlam : lam = 0 := by linarith
  rw [hlam] at hA
  norm_num at hA

end LonelyRunner
