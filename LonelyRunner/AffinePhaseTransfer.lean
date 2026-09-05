import LonelyRunner.FastRunnerInsertion

namespace LonelyRunner

/-- Transport simultaneous affine phase margins to a positive nearby time. -/
theorem exists_affinePhaseTransfer {ι : Type*} (U : ι → ℤ) (V : ι → ℝ)
    (p x y δ ε : ℝ) (hp : 0 < p) (hy : (1 : ℝ) / (2 * p) < y)
    (hmargin : ∀ i, δ + ε ≤ circleNorm ((U i : ℝ) * x + V i * y))
    (herr : ∀ i, |V i| / (2 * p) ≤ ε) :
    ∃ t : ℝ, 0 < t ∧ |t - y| ≤ (1 : ℝ) / (2 * p) ∧
      ∀ i, δ ≤ circleNorm ((p * (U i : ℝ) + V i) * t) := by
  let j : ℤ := round (p * y - x)
  let t : ℝ := ((j : ℝ) + x) / p
  have hround : |p * y - x - (j : ℝ)| ≤ (1 : ℝ) / 2 := by
    simpa [j, abs_sub_comm] using abs_sub_round (p * y - x)
  have htshift : |t - y| ≤ (1 : ℝ) / (2 * p) := by
    rw [show t - y = -((p * y - x - (j : ℝ)) / p) by dsimp [t]; field_simp; ring,
      abs_neg, abs_div, abs_of_pos hp]
    have h := (div_le_div_iff_of_pos_right hp).mpr hround
    calc
      |p * y - x - (j : ℝ)| / p ≤ (1 : ℝ) / 2 / p := h
      _ = (1 : ℝ) / (2 * p) := by ring
  have htpos : 0 < t := by
    have hbound : y - (1 : ℝ) / (2 * p) ≤ t := by
      linarith [le_trans (neg_le_abs (t - y)) htshift]
    linarith
  refine ⟨t, htpos, htshift, ?_⟩
  intro i
  let base : ℝ := (U i : ℝ) * x + V i * y
  let target : ℝ := (p * (U i : ℝ) + V i) * t
  have hphase : target = ((U i * j : ℤ) : ℝ) + base + V i * (t - y) := by
    dsimp [target, base, t]
    push_cast
    field_simp
    ring
  have hrewrite : circleNorm target =
      circleNorm (base + V i * (t - y)) := by
    rw [hphase]
    simpa [add_assoc] using circleNorm_add_int (U i * j) (base + V i * (t - y))
  have herror : |V i * (t - y)| ≤ ε := by
    rw [abs_mul]
    have hmul := mul_le_mul_of_nonneg_left htshift (abs_nonneg (V i))
    have hp2 : 0 < 2 * p := by positivity
    have hscale : |V i| * (1 / (2 * p)) = |V i| / (2 * p) := by ring
    rw [hscale] at hmul
    exact le_trans hmul (herr i)
  have hmetric := circleNorm_sub_abs_le_circleNorm base
    (base + V i * (t - y))
  rw [show |base - (base + V i * (t - y))| = |V i * (t - y)| by
    rw [show base - (base + V i * (t - y)) = -(V i * (t - y)) by ring, abs_neg]] at hmetric
  change δ ≤ circleNorm target
  rw [hrewrite]
  linarith [hmargin i]

end LonelyRunner
