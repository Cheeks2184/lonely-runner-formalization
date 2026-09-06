import LonelyRunner.PivotBoundary
import Mathlib.Data.Finset.Max
import Mathlib.Tactic

/-!
# Finite maximization on a sixth-anchored fiber

The condition on the `c`-phase leaves precisely `c` normalized candidate
times.  Maximizing the pair objective on that finite fiber is an existence
argument, not an executable search over arbitrary real times.
-/

namespace LonelyRunner

theorem exists_five_sixths_fiber_pair_maximizer (a b c : ℕ) (hc : 0 < c) :
    ∃ τ : ℝ, 0 < τ ∧ τ < 1 ∧
      Int.fract (τ * (c : ℝ)) = (5 : ℝ) / 6 ∧
      ∀ t : ℝ, Int.fract (t * (c : ℝ)) = (5 : ℝ) / 6 →
        min (circleNorm (t * (a : ℝ))) (circleNorm (t * (b : ℝ))) ≤
          min (circleNorm (τ * (a : ℝ))) (circleNorm (τ * (b : ℝ))) := by
  classical
  let T : Fin c → ℝ := fun j => ((j.val : ℝ) + (5 : ℝ) / 6) / (c : ℝ)
  let F : Fin c → ℝ := fun j =>
    min (circleNorm (T j * (a : ℝ))) (circleNorm (T j * (b : ℝ)))
  obtain ⟨j, _hj, hmax⟩ := Finset.exists_max_image (Finset.univ : Finset (Fin c)) F
    ⟨⟨0, hc⟩, Finset.mem_univ _⟩
  have hcR : (0 : ℝ) < (c : ℝ) := by exact_mod_cast hc
  have hTpos : 0 < T j := by
    dsimp [T]
    positivity
  have hTlt : T j < 1 := by
    dsimp [T]
    rw [div_lt_one₀ hcR]
    have hjstep : (j.val : ℝ) + 1 ≤ (c : ℝ) := by
      exact_mod_cast (Nat.succ_le_of_lt j.isLt)
    linarith
  refine ⟨T j, hTpos, hTlt, ?_, ?_⟩
  · apply Int.fract_eq_iff.mpr
    refine ⟨by norm_num, by norm_num, ⟨j.val, ?_⟩⟩
    dsimp [T]
    field_simp
    push_cast
    ring
  · intro t ht
    let s : ℝ := Int.fract t
    have hs0 : 0 ≤ s := Int.fract_nonneg t
    have hs1 : s < 1 := Int.fract_lt_one t
    have hnorma : circleNorm (t * (a : ℝ)) = circleNorm (s * (a : ℝ)) := by
      simpa [s] using (circleNorm_fract_mul_nat t a).symm
    have hnormb : circleNorm (t * (b : ℝ)) = circleNorm (s * (b : ℝ)) := by
      simpa [s] using (circleNorm_fract_mul_nat t b).symm
    have hfract : Int.fract (s * (c : ℝ)) = (5 : ℝ) / 6 := by
      have hfracteq : Int.fract (s * (c : ℝ)) = Int.fract (t * (c : ℝ)) := by
        apply Int.fract_eq_fract.mpr
        refine ⟨-(⌊t⌋ * (c : ℤ)), ?_⟩
        dsimp [s]
        have hdecomp := Int.floor_add_fract t
        push_cast
        nlinarith
      rw [hfracteq]
      exact ht
    let n : ℤ := ⌊s * (c : ℝ)⌋
    have hsc0 : 0 ≤ s * (c : ℝ) := mul_nonneg hs0 hcR.le
    have hn0 : 0 ≤ n := by
      dsimp [n]
      exact Int.floor_nonneg.mpr hsc0
    have hscLt : s * (c : ℝ) < c := by
      nlinarith
    have hfloorle : (n : ℝ) ≤ s * (c : ℝ) := by
      dsimp [n]
      exact Int.floor_le _
    have hnlt : n < (c : ℤ) := by
      by_contra hnot
      have hge : (c : ℝ) ≤ (n : ℝ) := by exact_mod_cast (le_of_not_gt hnot)
      linarith
    let q : Fin c := ⟨n.toNat, by omega⟩
    have hncast : (n.toNat : ℝ) = (n : ℝ) := by
      exact_mod_cast (Int.toNat_of_nonneg hn0)
    have hdecomp : s * (c : ℝ) = (n : ℝ) + (5 : ℝ) / 6 := by
      have hfloor := Int.floor_add_fract (s * (c : ℝ))
      dsimp [n]
      rw [hfract] at hfloor
      exact hfloor.symm
    have hsT : s = T q := by
      dsimp [T, q]
      rw [hncast]
      field_simp [hcR.ne']
      nlinarith [hdecomp]
    rw [hnorma, hnormb, hsT]
    exact hmax q (Finset.mem_univ _)

end LonelyRunner
