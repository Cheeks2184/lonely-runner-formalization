import LonelyRunner.MinimalCounterexample
import LonelyRunner.StrictCoreContraction
import LonelyRunner.BaseCases

namespace LonelyRunner

/-- A positive speed cannot have zero circle norm throughout an open interval.
At a zero center phase, use a short positive shift before the half-period. -/
private theorem exists_positive_circleNorm_in_interval
    (a : ℕ) (ha : 0 < a) (s epsilon : ℝ) (hepsilon : 0 < epsilon) :
    ∃ t : ℝ, t ∈ Set.Ioo (s - epsilon) (s + epsilon) ∧
      0 < circleNorm (t * (a : ℝ)) := by
  by_cases hs : 0 < circleNorm (s * (a : ℝ))
  · exact ⟨s, ⟨by linarith, by linarith⟩, hs⟩
  · have haR : 0 < (a : ℝ) := by exact_mod_cast ha
    have hzero : circleNorm (s * (a : ℝ)) = 0 :=
      le_antisymm (le_of_not_gt hs) (norm_nonneg _)
    have hphase_zero : s * (a : ℝ) = (round (s * (a : ℝ)) : ℝ) := by
      rw [circleNorm_eq_abs_sub_round] at hzero
      exact sub_eq_zero.mp (abs_eq_zero.mp hzero)
    let b : ℝ := min epsilon (1 / (2 * (a : ℝ)))
    let h : ℝ := b / 2
    have hb : 0 < b := lt_min hepsilon (by positivity)
    have hh : 0 < h := by dsimp [h]; positivity
    have hhb : h < b := by dsimp [h]; linarith
    have hhepsilon : h < epsilon := lt_of_lt_of_le hhb (min_le_left _ _)
    have hhsmall : h < 1 / (2 * (a : ℝ)) :=
      lt_of_lt_of_le hhb (min_le_right _ _)
    have hproduct : 0 < h * (a : ℝ) := mul_pos hh haR
    have hproduct_half : h * (a : ℝ) < (1 : ℝ) / 2 := by
      have hmul := (lt_div_iff₀ (show 0 < 2 * (a : ℝ) by positivity)).mp hhsmall
      nlinarith
    refine ⟨s + h, ⟨by linarith, by linarith⟩, ?_⟩
    have hphase : (s + h) * (a : ℝ) =
        (round (s * (a : ℝ)) : ℝ) + h * (a : ℝ) := by
      calc
        (s + h) * (a : ℝ) = s * (a : ℝ) + h * (a : ℝ) := add_mul _ _ _
        _ = (round (s * (a : ℝ)) : ℝ) + h * (a : ℝ) :=
          congrArg (fun x : ℝ => x + h * (a : ℝ)) hphase_zero
    rw [hphase, circleNorm_add_int,
      circleNorm_eq_abs_of_abs_le_half (by
        rw [abs_of_pos hproduct]
        exact hproduct_half.le), abs_of_pos hproduct]
    exact hproduct

/-- The sharp maximum of the speeds retained after deleting `i`. -/
def retainedMaxSpeed {n : ℕ} (v : Fin n → ℕ) (i : Fin n) : ℕ :=
  ((Finset.univ : Finset (Fin n)).erase i).sup v

private theorem retained_le_max {n : ℕ} (v : Fin n → ℕ) (i j : Fin n)
    (hji : j ≠ i) : (v j : ℝ) ≤ retainedMaxSpeed v i := by
  have hmem : j ∈ ((Finset.univ : Finset (Fin n)).erase i) :=
    Finset.mem_erase.mpr ⟨hji, Finset.mem_univ _⟩
  exact_mod_cast Finset.le_sup hmem

private theorem shifted_norm_lower (a : ℕ) (s u : ℝ) :
    circleNorm (s * (a : ℝ)) - (a : ℝ) * |u - s| ≤
      circleNorm (u * (a : ℝ)) := by
  have h := circleNorm_sub_abs_le_circleNorm (s * (a : ℝ)) (u * (a : ℝ))
  have heq : |s * (a : ℝ) - u * (a : ℝ)| = (a : ℝ) * |u - s| := by
    calc
      |s * (a : ℝ) - u * (a : ℝ)| = |u - s| * |(a : ℝ)| := by
        rw [show s * (a : ℝ) - u * (a : ℝ) = -(u - s) * (a : ℝ) by ring,
          abs_mul, abs_neg]
      _ = (a : ℝ) * |u - s| := by
        have habs : |(a : ℝ)| = (a : ℝ) := abs_of_nonneg (Nat.cast_nonneg a)
        rw [habs]
        ring
  simpa [heq] using h

theorem MinimalPositiveIntegerFailure.two_le_count
    {n : ℕ} {v : Fin n → ℕ} (hv : MinimalPositiveIntegerFailure v) : 2 ≤ n := by
  by_contra h
  have hc := hv.count_pos
  have hn : n = 1 := by omega
  subst n
  obtain ⟨t, ht⟩ := oneMovingRunner (v 0 : ℝ) (by
    exact_mod_cast (Nat.ne_of_gt (hv.positive 0)))
  obtain ⟨j, hj⟩ := hv.failure t
  have hj0 : j = 0 := Fin.eq_zero j
  subst j
  exact (not_lt_of_ge (by simpa [circleNorm] using ht)) hj

theorem MinimalPositiveIntegerFailure.deletion_seed_interval
    {n : ℕ} {v : Fin n → ℕ} (hv : MinimalPositiveIntegerFailure v) (i : Fin n) :
    let alpha : ℝ := (((n + 1 : ℕ) : ℝ)⁻¹)
    let Q : ℝ := (retainedMaxSpeed v i : ℝ)
    let epsilon : ℝ := ((n : ℝ)⁻¹ - alpha) / Q
    0 < Q ∧ 0 < epsilon ∧ ∃ s : ℝ,
      (∀ j : Fin n, j ≠ i → (n : ℝ)⁻¹ ≤ circleNorm (s * (v j : ℝ))) ∧
      Set.Ioo (s - epsilon) (s + epsilon) ⊆ {t : ℝ | ComplementSafe v i alpha t} := by
  dsimp
  have hn2 := hv.two_le_count
  have hn0 : n ≠ 0 := by omega
  obtain ⟨d, rfl⟩ := Nat.exists_eq_succ_of_ne_zero hn0
  have hd : 1 ≤ d := by omega
  let old : Fin d → ℕ := fun j => v (i.succAbove j)
  have holdinj : Function.Injective old := fun a b h =>
    Fin.succAbove_right_injective (hv.injective h)
  obtain ⟨s, hs⟩ := hv.previous_counts d hd (by omega) old holdinj (fun j => hv.positive _)
  have hseed : ∀ j : Fin (d + 1), j ≠ i → ((d + 1 : ℕ) : ℝ)⁻¹ ≤ circleNorm (s * (v j : ℝ)) := by
    intro j hji
    obtain ⟨k, rfl⟩ := Fin.exists_succAbove_eq hji
    exact hs k
  let q := retainedMaxSpeed v i
  have hqpos : 0 < q := by
    let k : Fin d := ⟨0, Nat.zero_lt_of_lt hd⟩
    have hle : (v (i.succAbove k) : ℝ) ≤ q := retained_le_max v i _ (Fin.succAbove_ne i k)
    have hp : 0 < (v (i.succAbove k) : ℝ) := by exact_mod_cast hv.positive (i.succAbove k)
    have hqreal : 0 < (q : ℝ) := lt_of_lt_of_le hp hle
    exact_mod_cast hqreal
  have hqR : 0 < (q : ℝ) := by exact_mod_cast hqpos
  have hgap : (((d + 2 : ℕ) : ℝ)⁻¹) < ((d + 1 : ℕ) : ℝ)⁻¹ := by
    have hpos : 0 < ((d + 1 : ℕ) : ℝ) := by positivity
    have hlt : ((d + 1 : ℕ) : ℝ) < ((d + 2 : ℕ) : ℝ) := by
      exact_mod_cast (show d + 1 < d + 2 by omega)
    simpa only [one_div] using one_div_lt_one_div_of_lt hpos hlt
  refine ⟨hqR, div_pos (sub_pos.mpr hgap) hqR, s, hseed, ?_⟩
  intro u hu j hji
  have hdist : |u - s| < (((d + 1 : ℕ) : ℝ)⁻¹ - ((d + 2 : ℕ) : ℝ)⁻¹) / (q : ℝ) := by
    rw [abs_lt]
    exact ⟨by linarith [hu.1], by linarith [hu.2]⟩
  have hle : (v j : ℝ) ≤ q := retained_le_max v i j hji
  have hprod := mul_le_mul_of_nonneg_right hle (abs_nonneg (u - s))
  have hstrict : ((d + 2 : ℕ) : ℝ)⁻¹ < ((d + 1 : ℕ) : ℝ)⁻¹ - (q : ℝ) * |u - s| := by
    have := (lt_div_iff₀ hqR).mp hdist
    linarith
  exact le_trans (le_of_lt hstrict) (le_trans (sub_le_sub (hseed j hji) hprod) (shifted_norm_lower (v j) s u))

theorem MinimalPositiveIntegerFailure.exists_common_deletion_margin
    {n : ℕ} {v : Fin n → ℕ} (hv : MinimalPositiveIntegerFailure v) (anchor : Fin n) :
    let alpha : ℝ := (((n + 1 : ℕ) : ℝ)⁻¹)
    let F : ℝ → ℝ := minimumCircleNorm (fun i => (v i : ℝ)) anchor
    ∃ mu tau : ℝ, tau ∈ Set.Icc (0 : ℝ) 1 ∧ 0 < mu ∧ mu < alpha ∧ F tau = mu ∧
      (∀ t : ℝ, F t ≤ mu) ∧
      (∀ i : Fin n, 0 < retainedMaxSpeed v i ∧
        0 < mu / (v i : ℝ) - (alpha - mu) / (retainedMaxSpeed v i : ℝ) ∧
        ∀ t : ℝ, ComplementSafe v i alpha t →
          circleNorm (t * (v i : ℝ)) + (v i : ℝ) * (alpha - mu) / (retainedMaxSpeed v i : ℝ) ≤ mu) ∧
      (∀ t : ℝ, F t = mu → ∀ i : Fin n, ¬ ComplementSafe v i alpha t) := by
  dsimp
  obtain ⟨mu, tau, htau, hmu0, hmua, hF, hglobal⟩ :=
    exists_attained_strict_failure_margin v anchor hv.positive hv.failure
  have hhalf : (((n + 1 : ℕ) : ℝ)⁻¹) ≤ (1 : ℝ) / 2 := by
    have hn := hv.two_le_count
    have hnR : (2 : ℝ) ≤ ((n + 1 : ℕ) : ℝ) := by
      exact_mod_cast (show 2 ≤ n + 1 by omega)
    simpa only [one_div] using
      one_div_le_one_div_of_le (show (0 : ℝ) < 2 by norm_num) hnR
  refine ⟨mu, tau, htau, hmu0, hmua, hF, hglobal, ?_, ?_⟩
  · intro i
    obtain ⟨hQ, heps, s, hseed, hinterval⟩ := hv.deletion_seed_interval i
    have hqnat : 0 < retainedMaxSpeed v i := by exact_mod_cast hQ
    have hbound := strict_core_bound_of_global_minimum v anchor i
      (((n + 1 : ℕ) : ℝ)⁻¹) mu (retainedMaxSpeed v i : ℝ) (hv.positive i) hQ
      (fun j hj => retained_le_max v i j hj) hmua hhalf hglobal
    obtain ⟨u, hu, hupos⟩ := exists_positive_circleNorm_in_interval (v i) (hv.positive i) s
      (((n : ℝ)⁻¹ - (((n + 1 : ℕ) : ℝ)⁻¹)) / (retainedMaxSpeed v i : ℝ)) heps
    have husafe : ComplementSafe v i (((n + 1 : ℕ) : ℝ)⁻¹) u := hinterval hu
    have hubound := hbound u husafe
    refine ⟨hqnat, ?_, fun t ht => hbound t ht⟩
    have hm : 0 < (v i : ℝ) := by exact_mod_cast hv.positive i
    have hterm : (v i : ℝ) * ((((n + 1 : ℕ) : ℝ)⁻¹) - mu) /
        (retainedMaxSpeed v i : ℝ) < mu := by
      linarith
    apply sub_pos.mpr
    apply (lt_div_iff₀ hm).mpr
    calc
      ((((n + 1 : ℕ) : ℝ)⁻¹ - mu) / (retainedMaxSpeed v i : ℝ)) * (v i : ℝ) =
          (v i : ℝ) * (((n + 1 : ℕ) : ℝ)⁻¹ - mu) /
            (retainedMaxSpeed v i : ℝ) := by ring
      _ < mu := hterm
  · intro t ht i
    exact not_complementSafe_of_global_maximum v anchor i (((n + 1 : ℕ) : ℝ)⁻¹) mu
      (retainedMaxSpeed v i : ℝ) (hv.positive i) (by
        obtain ⟨hQ, _, _, _, _⟩ := hv.deletion_seed_interval i
        exact hQ) (fun j hj => retained_le_max v i j hj) hmua hhalf hglobal t ht

end LonelyRunner
