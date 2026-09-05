import LonelyRunner.Definitions

/-!
# Exact transport of canonical lonely witnesses

This preserves the original runner labels while transporting a witness through
a permutation, common translation, and an arbitrary nonzero signed scale.
The inverse permutation and inverse scale in the statement are essential.
-/

namespace LonelyRunner

theorem lonelyAt_reindex_translate_scale_iff {n : ℕ}
    (a b : Fin n → ℝ) (e : Fin n ≃ Fin n) (c g : ℝ) (hg : g ≠ 0)
    (hfactor : ∀ j, a (e j) = c + g * b j)
    (r : Fin n) (T : ℝ) :
    LonelyAt a r (T / g) ↔ LonelyAt b (e.symm r) T := by
  constructor
  · intro h
    apply (lonelyAt_iff_relativeLonelyAt b (e.symm r) T).mpr
    intro j hj
    have hej : e j ≠ r := by
      intro hEq
      apply hj
      apply e.injective
      simpa using hEq
    have horig := (lonelyAt_iff_relativeLonelyAt a r (T / g)).mp h (e j) hej
    have hphase : T * (b j - b (e.symm r)) =
        (T / g) * (a (e j) - a r) := by
      have har : a r = c + g * b (e.symm r) := by
        simpa using hfactor (e.symm r)
      rw [hfactor j, har]
      field_simp
      ring
    rw [hphase]
    exact horig
  · intro h
    apply (lonelyAt_iff_relativeLonelyAt a r (T / g)).mpr
    intro i hi
    let j : Fin n := e.symm i
    have hj : j ≠ e.symm r := by
      intro hEq
      apply hi
      apply e.injective
      simpa [j] using hEq
    have hnew := (lonelyAt_iff_relativeLonelyAt b (e.symm r) T).mp h j hj
    have hphase : (T / g) * (a i - a r) =
        T * (b j - b (e.symm r)) := by
      have hji : e j = i := by simp [j]
      have har : a r = c + g * b (e.symm r) := by
        simpa using hfactor (e.symm r)
      rw [← hji, hfactor j, har]
      field_simp
      ring
    rw [hphase]
    exact hnew

end LonelyRunner
