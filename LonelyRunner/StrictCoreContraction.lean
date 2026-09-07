import LonelyRunner.ConstrainedMaximizer

namespace LonelyRunner

private theorem circleNorm_time_shift_lower
    (a : ℕ) (t s : ℝ) :
    circleNorm (t * (a : ℝ)) - (a : ℝ) * |s| ≤
      circleNorm ((t + s) * (a : ℝ)) := by
  have h := circleNorm_sub_abs_le_circleNorm
    (t * (a : ℝ)) ((t + s) * (a : ℝ))
  have hdiff : |t * (a : ℝ) - (t + s) * (a : ℝ)| =
      (a : ℝ) * |s| := by
    have ha0 : 0 ≤ (a : ℝ) := Nat.cast_nonneg a
    calc
      |t * (a : ℝ) - (t + s) * (a : ℝ)| = |s * (a : ℝ)| := by
        rw [show t * (a : ℝ) - (t + s) * (a : ℝ) =
          -(s * (a : ℝ)) by ring, abs_neg]
      _ = |s| * |(a : ℝ)| := abs_mul _ _
      _ = (a : ℝ) * |s| := by rw [abs_of_nonneg ha0]; ring
  simpa [hdiff] using h

private theorem exists_radial_time_shift
    (a : ℕ) (ha : 0 < a) (t r : ℝ)
    (hqr : circleNorm (t * (a : ℝ)) < r)
    (hrhalf : r < (1 : ℝ) / 2) :
    ∃ s : ℝ,
      |s| = (r - circleNorm (t * (a : ℝ))) / (a : ℝ) ∧
      circleNorm ((t + s) * (a : ℝ)) = r := by
  let x : ℝ := t * (a : ℝ)
  let e : ℝ := x - (round x : ℝ)
  have haR : 0 < (a : ℝ) := by exact_mod_cast ha
  have hnorm : circleNorm (t * (a : ℝ)) = |e| := by
    simpa [x, e] using circleNorm_eq_abs_sub_round (t * (a : ℝ))
  have hrpos : 0 < r := lt_of_le_of_lt (norm_nonneg _) hqr
  by_cases he : 0 ≤ e
  · let s : ℝ := (r - e) / (a : ℝ)
    have her : e < r := by
      rw [← abs_of_nonneg he, ← hnorm]
      exact hqr
    have hnum : 0 ≤ r - e := (sub_nonneg.mpr her.le)
    refine ⟨s, ?_, ?_⟩
    · rw [show s = (r - e) / (a : ℝ) by rfl, abs_div,
        abs_of_nonneg hnum, abs_of_pos haR, hnorm,
        abs_of_nonneg he]
    · have hphase : (t + s) * (a : ℝ) = (round x : ℝ) + r := by
        dsimp [s, x, e]
        field_simp
        ring
      rw [hphase, circleNorm_add_int (round x) r,
        circleNorm_eq_abs_of_abs_le_half (by
          rw [abs_of_nonneg hrpos.le]
          exact hrhalf.le), abs_of_nonneg hrpos.le]
  · have heneg : e < 0 := lt_of_not_ge he
    let s : ℝ := (-r - e) / (a : ℝ)
    have hnegr : -e < r := by
      rw [← abs_of_neg heneg, ← hnorm]
      exact hqr
    have hsum : 0 ≤ r + e := by linarith
    have hsnum : -r - e ≤ 0 := by linarith
    refine ⟨s, ?_, ?_⟩
    · rw [show s = (-r - e) / (a : ℝ) by rfl, abs_div,
        abs_of_nonpos hsnum, abs_of_pos haR, hnorm,
        abs_of_neg heneg]
      ring
    · have hphase : (t + s) * (a : ℝ) = (round x : ℝ) - r := by
        dsimp [s, x, e]
        field_simp
        ring
      rw [hphase, show (round x : ℝ) - r = (round x : ℝ) + (-r) by ring,
        circleNorm_add_int (round x) (-r),
        circleNorm_eq_abs_of_abs_le_half (by
          rw [abs_neg, abs_of_nonneg hrpos.le]
          exact hrhalf.le), abs_neg, abs_of_nonneg hrpos.le]

theorem strict_core_bound_of_global_minimum
    {n : ℕ} (v : Fin n → ℕ) (anchor i : Fin n)
    (alpha mu Q : ℝ)
    (hi : 0 < v i) (hQ : 0 < Q)
    (hretained : ∀ j : Fin n, j ≠ i → (v j : ℝ) ≤ Q)
    (hgap : mu < alpha) (hhalf : alpha ≤ (1 : ℝ) / 2)
    (hglobal : ∀ s : ℝ,
      minimumCircleNorm (fun j => (v j : ℝ)) anchor s ≤ mu)
    (t : ℝ) (ht : ComplementSafe v i alpha t) :
    circleNorm (t * (v i : ℝ)) + (v i : ℝ) * (alpha - mu) / Q ≤ mu := by
  let q : ℝ := circleNorm (t * (v i : ℝ))
  have hiR : 0 < (v i : ℝ) := by exact_mod_cast hi
  have hdelta : 0 < (alpha - mu) / Q := div_pos (sub_pos.mpr hgap) hQ
  have hqle : q ≤ mu := by
    obtain ⟨j, hj⟩ := exists_eq_minimumCircleNorm
      (fun j => (v j : ℝ)) anchor t
    by_cases hji : j = i
    · subst j
      change circleNorm (t * (v i : ℝ)) ≤ mu
      rw [hj]
      exact hglobal t
    · have hs := ht j hji
      rw [hj] at hs
      linarith [hglobal t]
  by_contra hbad
  have hescape : mu < q + (v i : ℝ) * (alpha - mu) / Q := lt_of_not_ge hbad
  let c : ℝ := min ((1 : ℝ) / 2)
    (q + (v i : ℝ) * (alpha - mu) / Q)
  let r : ℝ := (mu + c) / 2
  have hc_mu : mu < c := by
    apply lt_min
    · linarith [hhalf]
    · exact hescape
  have hrmu : mu < r := by dsimp [r]; linarith
  have hrhalf : r < (1 : ℝ) / 2 := by
    dsimp [r]
    have := min_le_left ((1 : ℝ) / 2)
      (q + (v i : ℝ) * (alpha - mu) / Q)
    linarith
  have hrc : r < c := by dsimp [r]; linarith
  have hqr : q < r := lt_of_le_of_lt hqle hrmu
  obtain ⟨s, hsabs, hsradial⟩ :=
    exists_radial_time_shift (v i) hi t r (by simpa [q] using hqr) hrhalf
  have hsdelta : |s| < (alpha - mu) / Q := by
    have hrc' : r < q + (v i : ℝ) * (alpha - mu) / Q :=
      lt_of_lt_of_le hrc (min_le_right _ _)
    have hdiff : r - circleNorm (t * (v i : ℝ)) <
        (v i : ℝ) * ((alpha - mu) / Q) := by
      dsimp [q] at hrc'
      have hterm : (v i : ℝ) * (alpha - mu) / Q =
          (v i : ℝ) * ((alpha - mu) / Q) := by ring
      rw [hterm] at hrc'
      linarith
    rw [hsabs]
    apply (div_lt_iff₀ hiR).mpr
    nlinarith [hdiff]
  have hretained_shift : ∀ j : Fin n, j ≠ i →
      mu < circleNorm ((t + s) * (v j : ℝ)) := by
    intro j hji
    have hbase := circleNorm_time_shift_lower (v j) t s
    have hsafe := ht j hji
    have hbound := hretained j hji
    have hcast : 0 ≤ (v j : ℝ) := Nat.cast_nonneg _
    have hprod : (v j : ℝ) * |s| ≤ Q * |s| :=
      mul_le_mul_of_nonneg_right hbound (abs_nonneg s)
    have hstrict : mu < alpha - Q * |s| := by
      have := (lt_div_iff₀ hQ).mp hsdelta
      linarith
    linarith
  obtain ⟨j, hj⟩ := exists_eq_minimumCircleNorm
    (fun j => (v j : ℝ)) anchor (t + s)
  have hmin : minimumCircleNorm (fun j => (v j : ℝ)) anchor (t + s) ≤ mu :=
    hglobal (t + s)
  have hji : j = i := by
    by_contra hne
    have := hretained_shift j hne
    rw [hj] at this
    linarith
  subst j
  rw [← hj] at hmin
  have : r ≤ mu := by
    calc r = circleNorm ((t + s) * (v i : ℝ)) := hsradial.symm
         _ ≤ mu := hmin
  linarith

theorem not_complementSafe_of_global_maximum
    {n : ℕ} (v : Fin n → ℕ) (anchor i : Fin n)
    (alpha mu Q : ℝ)
    (hi : 0 < v i) (hQ : 0 < Q)
    (hretained : ∀ j : Fin n, j ≠ i → (v j : ℝ) ≤ Q)
    (hgap : mu < alpha) (hhalf : alpha ≤ (1 : ℝ) / 2)
    (hglobal : ∀ s : ℝ,
      minimumCircleNorm (fun j => (v j : ℝ)) anchor s ≤ mu)
    (t : ℝ)
    (hmax : minimumCircleNorm (fun j => (v j : ℝ)) anchor t = mu) :
    ¬ ComplementSafe v i alpha t := by
  intro ht
  have hbound := strict_core_bound_of_global_minimum v anchor i alpha mu Q hi hQ
    hretained hgap hhalf hglobal t ht
  have hinc : 0 < (v i : ℝ) * (alpha - mu) / Q := by
    apply div_pos
    · exact mul_pos (by exact_mod_cast hi) (sub_pos.mpr hgap)
    · exact hQ
  have hq : circleNorm (t * (v i : ℝ)) < mu := by linarith
  have hmin := minimumCircleNorm_le (fun j => (v j : ℝ)) anchor i t
  rw [hmax] at hmin
  linarith

end LonelyRunner
