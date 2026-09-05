import LonelyRunner.FiniteTupleSorting
import Mathlib.Algebra.GCDMonoid.Finset
import Mathlib.Tactic

namespace LonelyRunner

open Finset

/-- Every finite injective integer tuple can be sorted, translated, and divided
by its joint finite gcd.  The reindexing still points to the original labels. -/
theorem exists_sorted_primitive_integer_normalization {m : ℕ}
    (a : Fin (m + 2) → ℤ) (hinj : Function.Injective a) :
    ∃ (e : Fin (m + 2) ≃ Fin (m + 2)) (c : ℤ) (g : ℕ)
      (b : Fin (m + 2) → ℕ), 0 < g ∧ StrictMono b ∧ b 0 = 0 ∧
        Finset.univ.gcd b = 1 ∧ ∀ j, a (e j) = c + (g : ℤ) * (b j : ℤ) := by
  obtain ⟨e, he⟩ := exists_strictMono_reindex a hinj
  let c : ℤ := a (e 0)
  let w : Fin (m + 2) → ℕ := fun j => (a (e j) - c).toNat
  have hwlift (j : Fin (m + 2)) : (w j : ℤ) = a (e j) - c := by
    apply Int.toNat_of_nonneg
    dsimp [c]
    exact sub_nonneg.mpr (he.monotone (Fin.zero_le j))
  have hwstrict : StrictMono w := by
    intro i j hij
    apply (Int.ofNat_lt).mp
    rw [hwlift, hwlift]
    exact sub_lt_sub_right (he hij) c
  have hwzero : w 0 = 0 := by simp [w, c]
  let last : Fin (m + 2) := Fin.last (m + 1)
  have hwlastpos : 0 < w last := by
    apply (Int.ofNat_lt).mp
    rw [hwlift]
    dsimp [last, c]
    apply sub_pos.mpr
    apply he
    change 0 < m + 1
    omega
  let g : ℕ := Finset.univ.gcd w
  have hgdvd (j : Fin (m + 2)) : g ∣ w j := by
    exact Finset.gcd_dvd (s := Finset.univ) (f := w) (Finset.mem_univ j)
  have hgpos : 0 < g := by
    apply Nat.pos_of_ne_zero
    change Finset.univ.gcd w ≠ 0
    rw [Finset.gcd_ne_zero_iff]
    exact ⟨last, Finset.mem_univ last, hwlastpos.ne'⟩
  let b : Fin (m + 2) → ℕ := fun j => w j / g
  have hfactor (j : Fin (m + 2)) : w j = g * b j := by
    dsimp [b]
    exact (Nat.mul_div_cancel' (hgdvd j)).symm
  refine ⟨e, c, g, b, hgpos, ?_, ?_, ?_, ?_⟩
  · intro i j hij
    have hmul : g * b i < g * b j := by simpa [← hfactor i, ← hfactor j] using hwstrict hij
    exact (Nat.mul_lt_mul_left hgpos).mp hmul
  · simp [b, hwzero]
  · change Finset.univ.gcd (fun j => w j / Finset.univ.gcd w) = 1
    exact Finset.gcd_div_eq_one (s := Finset.univ) (f := w)
      (i := last) (Finset.mem_univ last) hwlastpos.ne'
  · intro j
    have hj : a (e j) = c + (w j : ℤ) := by linarith [hwlift j]
    rw [hj, hfactor j]
    norm_cast

end LonelyRunner
