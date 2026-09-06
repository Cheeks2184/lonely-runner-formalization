import LonelyRunner.PivotBoundary
import LonelyRunner.StructuredClasses

/-!
# Constrained circle-norm maxima

Strict complement seeds give positive maxima. Phase-oriented reflection and
finite forward slack force an actual upper-face label. The generic margin
and finite label type are independent of any particular runner count.
-/

namespace LonelyRunner

/-- Circle norm is the smaller distance of the fractional part to either
integer endpoint. -/
theorem circleNorm_eq_min_fract (x : ℝ) :
    circleNorm x = min (Int.fract x) (1 - Int.fract x) := by
  let r : ℝ := Int.fract x
  have hr0 : 0 ≤ r := Int.fract_nonneg x
  have hr1 : r < 1 := Int.fract_lt_one x
  have hx : x = (⌊x⌋ : ℤ) + r := by
    dsimp [r]
    exact (Int.floor_add_fract x).symm
  have hperiod : circleNorm x = circleNorm r := by
    rw [hx, circleNorm_add_int]
  rw [hperiod]
  by_cases hrhalf : r ≤ (1 : ℝ) / 2
  · rw [circleNorm_eq_abs_of_abs_le_half]
    rw [abs_of_nonneg hr0, min_eq_left]
    linarith
    rw [abs_of_nonneg hr0]
    exact hrhalf
  · have hrhalf' : (1 : ℝ) / 2 ≤ r := le_of_not_ge hrhalf
    have hshift : circleNorm r = circleNorm ((-1 : ℤ) + r) := by
      symm
      exact circleNorm_add_int (-1) r
    rw [hshift, circleNorm_eq_abs_of_abs_le_half]
    · rw [show ((-1 : ℤ) : ℝ) + r = -(1 - r) by norm_num; ring,
        abs_neg, abs_of_nonneg (by linarith), min_eq_right]
      linarith
    · rw [show ((-1 : ℤ) : ℝ) + r = -(1 - r) by norm_num; ring,
        abs_neg, abs_of_nonneg (by linarith)]
      linarith

/-- Times at which every label except the distinguished one is closed-safe. -/
def ComplementSafe {I : Type*} (v : I → ℕ) (i : I) (δ t : ℝ) : Prop :=
  ∀ j, j ≠ i → δ ≤ circleNorm (t * (v j : ℝ))

/-- Positive speeds can move forward while all complement phases stay below
their upper endpoints. A lower endpoint causes no obstruction. -/
theorem exists_forward_complement_improvement
    {I : Type*} [Fintype I] [DecidableEq I]
    (v : I → ℕ) (i : I) (hv : ∀ j, 0 < v j)
    (δ s : ℝ) (hδ : 0 < δ) (hδhalf : δ < (1 : ℝ) / 2)
    (hi : Int.fract (s * (v i : ℝ)) < (1 : ℝ) / 2)
    (hbands : ∀ j, j ≠ i →
      δ ≤ Int.fract (s * (v j : ℝ)) ∧
      Int.fract (s * (v j : ℝ)) < 1 - δ) :
    ∃ ε : ℝ, 0 < ε ∧ ComplementSafe v i δ (s + ε) ∧
      circleNorm (s * (v i : ℝ)) < circleNorm ((s + ε) * (v i : ℝ)) := by
  classical
  let r := fun j => Int.fract (s * (v j : ℝ))
  let upper := fun j => if j = i then (1 : ℝ) / 2 else 1 - δ
  let capacity := fun j => (upper j - r j) / (v j : ℝ)
  have hvR : ∀ j, 0 < (v j : ℝ) := fun j => by exact_mod_cast hv j
  have hr : ∀ j, r j < upper j := by
    intro j
    by_cases hj : j = i
    · subst j; simpa [r, upper] using hi
    · simpa [r, upper, hj] using (hbands j hj).2
  have hc : ∀ j, 0 < capacity j := by
    intro j; exact div_pos (sub_pos.mpr (hr j)) (hvR j)
  obtain ⟨q, _, hq⟩ := Finset.exists_min_image (Finset.univ : Finset I) capacity
    ⟨i, Finset.mem_univ i⟩
  let ε := capacity q / 2
  have he : 0 < ε := div_pos (hc q) (by norm_num)
  have hecap : ∀ j, ε < capacity j := by
    intro j
    have := hq j (Finset.mem_univ j)
    dsimp [ε]
    linarith [hc q]
  have hupper : ∀ j, r j + ε * (v j : ℝ) < upper j := by
    intro j
    have h := (lt_div_iff₀ (hvR j)).mp (hecap j)
    linarith
  have hphase : ∀ j, (s + ε) * (v j : ℝ) =
      (⌊s * (v j : ℝ)⌋ : ℤ) + (r j + ε * (v j : ℝ)) := by
    intro j
    have hd := Int.floor_add_fract (s * (v j : ℝ))
    dsimp [r]
    nlinarith
  refine ⟨ε, he, ?_, ?_⟩
  · intro j hj
    apply circleNorm_ge_of_int_band ⌊s * (v j : ℝ)⌋ _ δ hδ.le hδhalf.le
    · rw [hphase j]
      have hlo := (hbands j hj).1
      have hinc := mul_pos he (hvR j)
      dsimp [r] at *
      linarith
    · rw [hphase j]
      have hh := hupper j
      simp only [upper, if_neg hj] at hh
      linarith
  · have hri0 : 0 ≤ r i := Int.fract_nonneg _
    have hnew0 : 0 ≤ r i + ε * (v i : ℝ) :=
      add_nonneg hri0 (mul_pos he (hvR i)).le
    have hnewhalf : r i + ε * (v i : ℝ) ≤ (1 : ℝ) / 2 := by
      simpa [upper] using (hupper i).le
    have hold : circleNorm (s * (v i : ℝ)) = r i := by
      rw [circleNorm_eq_min_fract, min_eq_left]
      change r i ≤ 1 - r i
      dsimp [r]; linarith
    rw [hold, hphase i, circleNorm_add_int,
      circleNorm_eq_abs_of_abs_le_half (by simpa [abs_of_nonneg hnew0] using hnewhalf),
      abs_of_nonneg hnew0]
    linarith [mul_pos he (hvR i)]

/-- A strict complement seed permits a positive distinguished objective,
even when the original distinguished phase is an integer. -/
private theorem exists_positive_complement_objective
    {I : Type*} [Fintype I] [DecidableEq I]
    (v : I → ℕ) (i : I) (hv : ∀ j, 0 < v j)
    (δ : ℝ) (hδ : 0 < δ) (hδhalf : δ < (1 : ℝ) / 2)
    (hstrict : ∃ s : ℝ, ∀ j, j ≠ i → δ < circleNorm (s * (v j : ℝ))) :
    ∃ s : ℝ, ComplementSafe v i δ s ∧ 0 < circleNorm (s * (v i : ℝ)) := by
  obtain ⟨s, hs⟩ := hstrict
  by_cases hi : 0 < circleNorm (s * (v i : ℝ))
  · exact ⟨s, fun j hj => (hs j hj).le, hi⟩
  have hzero : circleNorm (s * (v i : ℝ)) = 0 := by
    have hnonneg : 0 ≤ circleNorm (s * (v i : ℝ)) := norm_nonneg _
    linarith
  have hfractzero : Int.fract (s * (v i : ℝ)) = 0 := by
    rw [circleNorm_eq_min_fract] at hzero
    have := Int.fract_nonneg (s * (v i : ℝ))
    have := Int.fract_lt_one (s * (v i : ℝ))
    rcases le_total (Int.fract (s * (v i : ℝ)))
      (1 - Int.fract (s * (v i : ℝ))) with h | h
    · rw [min_eq_left h] at hzero; exact hzero
    · rw [min_eq_right h] at hzero; linarith
  obtain ⟨ε, _, hsafe, hinc⟩ := exists_forward_complement_improvement v i hv δ s
    hδ hδhalf (by rw [hfractzero]; norm_num) (by
      intro j hj
      have h := hs j hj
      rw [circleNorm_eq_min_fract, lt_min_iff] at h
      exact ⟨h.1.le, by linarith [h.2]⟩)
  exact ⟨s + ε, hsafe, by simpa [hzero] using hinc⟩

/-- A compact maximum is oriented by its distinguished phase. Its upper
face is an actual complement label, since otherwise forward motion improves it. -/
theorem exists_oriented_complement_maximizer
    {I : Type*} [Fintype I] [DecidableEq I]
    (v : I → ℕ) (i : I) (hv : ∀ j, 0 < v j)
    (δ : ℝ) (hδ : 0 < δ) (hδhalf : δ < (1 : ℝ) / 2)
    (hstrict : ∃ s : ℝ, ∀ j, j ≠ i → δ < circleNorm (s * (v j : ℝ)))
    (hno : ¬ ∃ t : ℝ, ∀ j, δ ≤ circleNorm (t * (v j : ℝ))) :
    ∃ τ : ℝ, 0 < τ ∧ τ < 1 ∧ ComplementSafe v i δ τ ∧
      (∀ t : ℝ, ComplementSafe v i δ t →
        circleNorm (t * (v i : ℝ)) ≤ circleNorm (τ * (v i : ℝ))) ∧
      0 < Int.fract (τ * (v i : ℝ)) ∧
      Int.fract (τ * (v i : ℝ)) < δ ∧
      Int.fract (τ * (v i : ℝ)) = circleNorm (τ * (v i : ℝ)) ∧
      ∃ j, j ≠ i ∧ Int.fract (τ * (v j : ℝ)) = 1 - δ := by
  classical
  let T := {t : ℝ | ComplementSafe v i δ t}
  let S := Set.Icc (0 : ℝ) 1 ∩ T
  have hcont : ∀ j, Continuous (fun t : ℝ => circleNorm (t * (v j : ℝ))) :=
    fun j => continuous_circleNorm.comp (continuous_id.mul continuous_const)
  have hT : IsClosed T := by
    have heq : T = ⋂ j, ⋂ (_ : j ≠ i), {t : ℝ | δ ≤ circleNorm (t * (v j : ℝ))} := by
      ext t; simp [T, ComplementSafe]
    rw [heq]
    exact isClosed_iInter fun j => isClosed_iInter fun _ => isClosed_le continuous_const (hcont j)
  have hcompact : IsCompact S := isCompact_Icc.inter_right hT
  have hnormtime (t : ℝ) (ht : ComplementSafe v i δ t) :
      Int.fract t ∈ S := by
    refine ⟨⟨Int.fract_nonneg t, (Int.fract_lt_one t).le⟩, ?_⟩
    intro j hj
    rw [circleNorm_fract_mul_nat]
    exact ht j hj
  obtain ⟨s, hs, hspos⟩ := exists_positive_complement_objective v i hv δ hδ hδhalf hstrict
  obtain ⟨u, hu, hmax⟩ := hcompact.exists_isMaxOn ⟨Int.fract s, hnormtime s hs⟩
    (hcont i).continuousOn
  have hmaxglobal : ∀ t : ℝ, ComplementSafe v i δ t →
      circleNorm (t * (v i : ℝ)) ≤ circleNorm (u * (v i : ℝ)) := by
    intro t ht
    have h := hmax (hnormtime t ht)
    change circleNorm (Int.fract t * (v i : ℝ)) ≤ circleNorm (u * (v i : ℝ)) at h
    simpa only [circleNorm_fract_mul_nat] using h
  have hupos : 0 < circleNorm (u * (v i : ℝ)) := lt_of_lt_of_le hspos (hmaxglobal s hs)
  have hu0 : 0 < u := by
    have hge := hu.1.1
    by_contra h
    have : u = 0 := by linarith
    simp [this, circleNorm] at hupos
  have hu1 : u < 1 := by
    have hle := hu.1.2
    by_contra h
    have heq : u = 1 := by linarith
    have hz : circleNorm (u * (v i : ℝ)) = 0 := by
      rw [heq, one_mul]
      have hz' := circleNorm_add_int (v i : ℤ) 0
      simpa [circleNorm] using hz'
    linarith
  have hult : circleNorm (u * (v i : ℝ)) < δ := by
    by_contra h
    apply hno
    refine ⟨u, fun j => ?_⟩
    by_cases hj : j = i
    · subst j; exact le_of_not_gt h
    · exact hu.2 j hj
  have hreflect (j : I) : circleNorm ((1 - u) * (v j : ℝ)) =
      circleNorm (u * (v j : ℝ)) := by
    rw [show (1 - u) * (v j : ℝ) = ((v j : ℤ) : ℝ) + -(u * (v j : ℝ)) by
      push_cast; ring, circleNorm_add_int, circleNorm_neg]
  have horient : ∃ τ : ℝ, 0 < τ ∧ τ < 1 ∧ ComplementSafe v i δ τ ∧
      circleNorm (τ * (v i : ℝ)) = circleNorm (u * (v i : ℝ)) ∧
      Int.fract (τ * (v i : ℝ)) = circleNorm (u * (v i : ℝ)) := by
    have hmin := circleNorm_eq_min_fract (u * (v i : ℝ))
    by_cases hbranch : Int.fract (u * (v i : ℝ)) ≤ 1 - Int.fract (u * (v i : ℝ))
    · rw [min_eq_left hbranch] at hmin
      exact ⟨u, hu0, hu1, hu.2, rfl, hmin.symm⟩
    · rw [min_eq_right (le_of_not_ge hbranch)] at hmin
      refine ⟨1 - u, by linarith, by linarith, ?_, hreflect i, ?_⟩
      · intro j hj; rw [hreflect]; exact hu.2 j hj
      · apply Int.fract_eq_iff.mpr
        refine ⟨hupos.le, by linarith, ⟨(v i : ℤ) - ⌊u * (v i : ℝ)⌋ - 1, ?_⟩⟩
        have hd := Int.floor_add_fract (u * (v i : ℝ))
        push_cast
        nlinarith
  obtain ⟨τ, hτ0, hτ1, hτsafe, hτnorm, hτfract⟩ := horient
  have hτmax : ∀ t : ℝ, ComplementSafe v i δ t →
      circleNorm (t * (v i : ℝ)) ≤ circleNorm (τ * (v i : ℝ)) := by
    intro t ht; rw [hτnorm]; exact hmaxglobal t ht
  refine ⟨τ, hτ0, hτ1, hτsafe, hτmax, by simpa [hτfract] using hupos,
    by simpa [hτfract] using hult, hτfract.trans hτnorm.symm, ?_⟩
  by_contra hface
  have hbands : ∀ j, j ≠ i → δ ≤ Int.fract (τ * (v j : ℝ)) ∧
      Int.fract (τ * (v j : ℝ)) < 1 - δ := by
    intro j hj
    have hg := hτsafe j hj
    rw [circleNorm_eq_min_fract, le_min_iff] at hg
    have hne : Int.fract (τ * (v j : ℝ)) ≠ 1 - δ := fun he => hface ⟨j, hj, he⟩
    exact ⟨hg.1, lt_of_le_of_ne (by linarith [hg.2]) hne⟩
  obtain ⟨ε, _, hsafe, himproves⟩ := exists_forward_complement_improvement v i hv δ τ
    hδ hδhalf (by rw [hτfract]; linarith) hbands
  exact (not_lt_of_ge (hτmax (τ + ε) hsafe)) himproves

/-- At a reciprocal margin, each allowed dilation strictly improves a
positive phase below that margin, including after every integer numerator shift. -/
theorem reciprocal_dilate_shift_improves
    (N d α : ℕ) (β : ℤ) (t : ℝ) (hN : 3 ≤ N)
    (hdiv : N ∣ d) (hα : 2 ≤ α) (hαN : α < N)
    (hx : 0 < Int.fract (t * (d : ℝ)))
    (hxN : Int.fract (t * (d : ℝ)) < (N : ℝ)⁻¹) :
    circleNorm (t * (d : ℝ)) <
      circleNorm (((α : ℝ) * t + (β : ℝ) / (N : ℝ)) * (d : ℝ)) := by
  let x := Int.fract (t * (d : ℝ))
  have hNR : (0 : ℝ) < N := by exact_mod_cast (show 0 < N by omega)
  have hαR : (2 : ℝ) ≤ α := by exact_mod_cast hα
  have hαNR : (α : ℝ) + 1 ≤ N := by exact_mod_cast (show α + 1 ≤ N by omega)
  have hNx : (N : ℝ) * x < 1 := by
    have h := (lt_div_iff₀ hNR).mp (show x < 1 / (N : ℝ) by simpa [x] using hxN)
    nlinarith
  have hx0 : 0 < x := hx
  have hxhalf : x < (1 : ℝ) / 2 := by nlinarith
  have hax0 : 0 ≤ (α : ℝ) * x := by positivity
  have hax1 : (α : ℝ) * x < 1 := by nlinarith
  have hleft : x < (α : ℝ) * x := by nlinarith
  have hright : x < 1 - (α : ℝ) * x := by nlinarith
  have hold : circleNorm (t * (d : ℝ)) = x := by
    rw [circleNorm_eq_min_fract, min_eq_left]
    change x ≤ 1 - x
    linarith
  obtain ⟨q, hq⟩ := hdiv
  have hshift : ((β : ℝ) / (N : ℝ)) * (d : ℝ) = ((β * (q : ℤ) : ℤ) : ℝ) := by
    rw [hq]
    push_cast
    field_simp
  have hphase : ((α : ℝ) * t + (β : ℝ) / (N : ℝ)) * (d : ℝ) =
      (((α : ℤ) * ⌊t * (d : ℝ)⌋ + β * (q : ℤ) : ℤ) : ℝ) + (α : ℝ) * x := by
    have hd := congrArg (fun z : ℝ => (α : ℝ) * z) (Int.floor_add_fract (t * (d : ℝ)))
    rw [add_mul, hshift]
    dsimp [x]
    push_cast
    nlinarith
  rw [hold, hphase, circleNorm_add_int, circleNorm_eq_min_fract,
    Int.fract_eq_self.mpr ⟨hax0, hax1⟩, lt_min_iff]
  exact ⟨hleft, hright⟩

end LonelyRunner
