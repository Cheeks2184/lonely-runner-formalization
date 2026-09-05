import LonelyRunner.PivotResidues

/-!
# Nearest actual-pivot grid transport

This module keeps the quantitative premise explicit: it transports a supplied
common real witness for a pivot and any finite labelled family of lower natural
speeds to the pivot's natural residue grid.  It deliberately makes no LRC or
induction claim.
-/

namespace LonelyRunner

open scoped BigOperators

/-- A nearest integer to `N * p * t` cannot lie on the forbidden `N`-multiple
grid when the actual pivot has margin strictly greater than `1 / (2N)`. -/
private theorem rounded_pivot_not_dvd {N p : ℕ} (hN : 2 ≤ N) (hp : 0 < p)
    (t alpha : ℝ)
    (hpivot : alpha ≤ circleNorm (t * (p : ℝ)))
    (halpha : (2 * (N : ℝ))⁻¹ < alpha) :
    ¬ ((N : ℤ) ∣ round (((N * p : ℕ) : ℝ) * t)) := by
  intro hdiv
  obtain ⟨k, hk⟩ := hdiv
  have hNpos : 0 < N := by omega
  have hMpos : 0 < N * p := Nat.mul_pos hNpos hp
  have hNreal : (0 : ℝ) < (N : ℝ) := by exact_mod_cast hNpos
  have hMreal : (0 : ℝ) < ((N * p : ℕ) : ℝ) := by exact_mod_cast hMpos
  let z : ℤ := round (((N * p : ℕ) : ℝ) * t)
  have hz : z = (N : ℤ) * k := hk
  have hround : |((N * p : ℕ) : ℝ) * t - (z : ℝ)| ≤ (1 : ℝ) / 2 := by
    simpa [z, abs_sub_comm] using abs_sub_round (((N * p : ℕ) : ℝ) * t)
  have hphase : ((z : ℝ) / ((N * p : ℕ) : ℝ)) * (p : ℝ) = (k : ℝ) := by
    rw [hz]
    push_cast
    field_simp
  have hdist : |t * (p : ℝ) - ((z : ℝ) / ((N * p : ℕ) : ℝ)) * (p : ℝ)| ≤
      (2 * (N : ℝ))⁻¹ := by
    rw [show t * (p : ℝ) - ((z : ℝ) / ((N * p : ℕ) : ℝ)) * (p : ℝ) =
        (((N * p : ℕ) : ℝ) * t - (z : ℝ)) / (N : ℝ) by
      push_cast; field_simp]
    rw [abs_div, abs_of_pos hNreal]
    calc
      |((N * p : ℕ) : ℝ) * t - (z : ℝ)| / (N : ℝ) ≤ ((1 : ℝ) / 2) / (N : ℝ) :=
        (div_le_div_iff_of_pos_right hNreal).mpr hround
      _ = (2 * (N : ℝ))⁻¹ := by field_simp
  have hzero : circleNorm (((z : ℝ) / ((N * p : ℕ) : ℝ)) * (p : ℝ)) = 0 := by
    rw [hphase]
    simpa [circleNorm] using (circleNorm_add_int k 0)
  have hlip := circleNorm_sub_abs_le_circleNorm (t * (p : ℝ))
    (((z : ℝ) / ((N * p : ℕ) : ℝ)) * (p : ℝ))
  rw [hzero] at hlip
  linarith

/-- Quantitative nearest-grid transport at a fixed positive natural pivot.

The coordinate family is arbitrary and finite only through its index type;
in particular, the proof is stronger than the manuscript's lower-speed
specialization and does not need `d i < p`.  No cardinality, injectivity, or
smaller-count witness is supplied implicitly.
The conclusion uses the repository's strict bad sets, hence equality with the
closed `1 / N` boundary is retained. -/
theorem exists_nearestPivotGrid_residue {ι : Type*} [Fintype ι]
    (N p : ℕ) (hN : 2 ≤ N) (hp : 0 < p) (d : ι → ℕ)
    (t alpha : ℝ)
    (hpivot : alpha ≤ circleNorm (t * (p : ℝ)))
    (hcoords : ∀ i, alpha ≤ circleNorm (t * (d i : ℝ)))
    (halpha : (2 * (N : ℝ))⁻¹ < alpha)
    (hmargins : ∀ i, (N : ℝ)⁻¹ ≤
      alpha - (d i : ℝ) / (2 * ((N * p : ℕ) : ℝ))) :
    ∃ r : ℕ, r ∈ pivotCandidates N p ∧
      (∀ i, r ∉ pivotBadResidues N p (d i)) ∧
      (N : ℝ)⁻¹ ≤ circleNorm (((r : ℝ) / ((N * p : ℕ) : ℝ)) * (p : ℝ)) ∧
      ∀ i, (N : ℝ)⁻¹ ≤
        circleNorm (((r : ℝ) / ((N * p : ℕ) : ℝ)) * (d i : ℝ)) := by
  let M : ℕ := N * p
  let z : ℤ := round ((M : ℝ) * t)
  let r : ℕ := z.natMod (M : ℤ)
  let q : ℤ := z / (M : ℤ)
  have hNpos : 0 < N := by omega
  have hMpos : 0 < M := by dsimp [M]; exact Nat.mul_pos hNpos hp
  have hMZ : (M : ℤ) ≠ 0 := by exact_mod_cast hMpos.ne'
  have hMreal : (0 : ℝ) < (M : ℝ) := by exact_mod_cast hMpos
  have hNreal : (0 : ℝ) < (N : ℝ) := by exact_mod_cast hNpos
  have hrLt : r < M := by
    exact Int.natMod_lt hMpos.ne'
  have hrCast : (r : ℤ) = z % (M : ℤ) := by
    dsimp [r]
    rw [Int.natMod, Int.toNat_of_nonneg (Int.emod_nonneg z hMZ)]
  have hzdecomp : q * (M : ℤ) + (r : ℤ) = z := by
    rw [hrCast]
    simpa [q] using Int.ediv_mul_add_emod z (M : ℤ)
  have hzNotDvd : ¬ (N : ℤ) ∣ z := by
    simpa [z, M] using rounded_pivot_not_dvd hN hp t alpha hpivot halpha
  have hrNotDvd : ¬ N ∣ r := by
    intro hdiv
    have hdivZr : (N : ℤ) ∣ (r : ℤ) := by exact_mod_cast hdiv
    have hdivZM : (N : ℤ) ∣ q * (M : ℤ) := by
      apply dvd_mul_of_dvd_right
      dsimp [M]
      exact dvd_mul_right (N : ℤ) (p : ℤ)
    apply hzNotDvd
    rw [← hzdecomp]
    exact dvd_add hdivZM hdivZr
  have hrCandidate : r ∈ pivotCandidates N p := by
    apply mem_pivotCandidates.mpr
    simpa [M] using And.intro hrLt hrNotDvd
  have hphase (a : ℕ) :
      ((z : ℝ) / (M : ℝ)) * (a : ℝ) =
        ((q * (a : ℤ) : ℤ) : ℝ) +
          ((r : ℝ) / (M : ℝ)) * (a : ℝ) := by
    rw [← hzdecomp]
    push_cast
    field_simp
  have hround : |(M : ℝ) * t - (z : ℝ)| ≤ (1 : ℝ) / 2 := by
    simpa [z, abs_sub_comm] using abs_sub_round ((M : ℝ) * t)
  have hcoordGrid (i : ι) : (N : ℝ)⁻¹ ≤
      circleNorm (((z : ℝ) / (M : ℝ)) * (d i : ℝ)) := by
    have hdist : |t * (d i : ℝ) - ((z : ℝ) / (M : ℝ)) * (d i : ℝ)| ≤
        (d i : ℝ) / (2 * (M : ℝ)) := by
      rw [show t * (d i : ℝ) - ((z : ℝ) / (M : ℝ)) * (d i : ℝ) =
          (((M : ℝ) * t - (z : ℝ)) * (d i : ℝ)) / (M : ℝ) by field_simp]
      rw [abs_div, abs_mul, abs_of_nonneg (by positivity : (0 : ℝ) ≤ d i),
        abs_of_pos hMreal]
      calc
        |(M : ℝ) * t - (z : ℝ)| * (d i : ℝ) / (M : ℝ) ≤
            ((1 : ℝ) / 2) * (d i : ℝ) / (M : ℝ) := by
          gcongr
        _ = (d i : ℝ) / (2 * (M : ℝ)) := by ring
    have hlip := circleNorm_sub_abs_le_circleNorm (t * (d i : ℝ))
      (((z : ℝ) / (M : ℝ)) * (d i : ℝ))
    have hbound : alpha - (d i : ℝ) / (2 * (M : ℝ)) ≤
        circleNorm (((z : ℝ) / (M : ℝ)) * (d i : ℝ)) := by
      linarith [hcoords i]
    have hmargin : (N : ℝ)⁻¹ ≤ alpha - (d i : ℝ) / (2 * (M : ℝ)) := by
      simpa [M] using hmargins i
    exact hmargin.trans hbound
  refine ⟨r, hrCandidate, ?_, pivot_circleNorm_ge hNpos hp hrCandidate, ?_⟩
  · intro i
    apply (not_mem_pivotBadResidues_iff_circleNorm_ge hNpos hp hrCandidate).mpr
    have hgrid : (N : ℝ)⁻¹ ≤
        circleNorm (((r : ℝ) / (M : ℝ)) * (d i : ℝ)) := by
      have h := hcoordGrid i
      rw [hphase (d i), circleNorm_add_int] at h
      exact h
    simpa [M] using hgrid
  · intro i
    have hgrid : (N : ℝ)⁻¹ ≤
        circleNorm (((r : ℝ) / (M : ℝ)) * (d i : ℝ)) := by
      have h := hcoordGrid i
      rw [hphase (d i), circleNorm_add_int] at h
      exact h
    simpa [M] using hgrid

end LonelyRunner
