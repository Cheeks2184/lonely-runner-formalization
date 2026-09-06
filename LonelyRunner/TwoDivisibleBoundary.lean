import LonelyRunner.AnchoredPairMaximizer
import LonelyRunner.AnchoredPairSafeBands
import LonelyRunner.PairSafeSixthAffine
import LonelyRunner.EvenAnchorThreeTimes
import LonelyRunner.TwoDivisibleSmallPair
import LonelyRunner.ThirdShiftSpecialSeed

/-!
# Vanishing of the divisible pair on a sixth-anchored fiber

A safe divisible pair and a special exceptional phase supply a common third
shift. The finite fiber maximum therefore vanishes: a positive maximum would
produce the safe folded bands, whose affine selector or even-anchor alternative
supplies that same rescue. The final bound applies to every real fiber time.
-/

namespace LonelyRunner

private theorem pair_special_rescue
    (v : Fin 5 → ℕ) (p q r : Fin 5) (hpq : p ≠ q)
    (hdiv : ∀ i, 3 ∣ v i ↔ i = p ∨ i = q) (hr : ¬ 3 ∣ v r)
    (s : ℝ)
    (hp : (1 : ℝ) / 6 ≤ circleNorm (s * (v p : ℝ)))
    (hq : (1 : ℝ) / 6 ≤ circleNorm (s * (v q : ℝ)))
    (hs : Int.fract (s * (v r : ℝ)) = (1 : ℝ) / 6 ∨
      Int.fract (s * (v r : ℝ)) = (5 : ℝ) / 6) :
    ∃ t : ℝ, ∀ i, (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ)) := by
  have hseed : ∀ i, 3 ∣ v i → (1 : ℝ) / 6 ≤ circleNorm (s * (v i : ℝ)) := by
    intro i hi
    rcases (hdiv i).mp hi with rfl | rfl
    · exact hp
    · exact hq
  have hex := (three_exceptions_of_two_divisible_labels v p q hpq hdiv).le
  have hphase : Int.fract (s * (v r : ℝ)) = (1 : ℝ) / 6 ∨
      Int.fract (s * (v r : ℝ)) = (1 : ℝ) / 2 ∨
      Int.fract (s * (v r : ℝ)) = (5 : ℝ) / 6 := by
    rcases hs with h | h
    · exact Or.inl h
    · exact Or.inr (Or.inr h)
  obtain ⟨k, hk⟩ := exists_third_shift_of_special_sixth_seeded_divisible
    v s hseed hex r hr hphase
  exact ⟨s + (k.val : ℝ) / 3, hk⟩

private theorem pair_bands_contradict_nonexistence
    (v : Fin 5 → ℕ) (p q r : Fin 5)
    (hpq : p ≠ q) (hrp : r ≠ p) (hrq : r ≠ q)
    (hdiv : ∀ i, 3 ∣ v i ↔ i = p ∨ i = q)
    (hsix : 6 ∣ v p ∨ 6 ∣ v q)
    (heven : (Finset.univ.filter (fun i => 2 ∣ v i)).card ≤ 3)
    (hno : ¬ ∃ t : ℝ, ∀ i, (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ)))
    (τ : ℝ) (ht : Int.fract (τ * (v r : ℝ)) = (5 : ℝ) / 6)
    (H : FoldedPairSafeBands (circleNorm (τ * (v p : ℝ)))
      (circleNorm (τ * (v q : ℝ)))) : False := by
  have hp : 3 ∣ v p := (hdiv p).mpr (Or.inl rfl)
  have hq : 3 ∣ v q := (hdiv q).mpr (Or.inr rfl)
  have hr : ¬ 3 ∣ v r := by simpa [hdiv, hrp, hrq]
  by_cases he : 6 ∣ v p ∧ 6 ∣ v q ∧ 2 ∣ v r
  · rcases both_six_even_anchor_three_time_witness v p q r hpq hrp hrq
      he.1 he.2.1 he.2.2 heven τ ht H with h | h | h
    · exact hno ⟨2 * τ, h⟩
    · exact hno ⟨2 * τ + 1 / 2, h⟩
    · exact hno ⟨4 * τ + 1 / 2, h⟩
  · obtain ⟨n, σ, _hn, _hσ, hpair, hphase⟩ :=
      exists_pair_safe_special_sixth_affine (v p) (v q) (v r)
        hp hq hr hsix he τ ht H
    exact hno (pair_special_rescue v p q r hpq hdiv hr
      ((n : ℝ) * τ + (σ : ℝ) / 6) hpair.1 hpair.2 hphase)

/-- Under the exact two-divisible nonexistence setup, the pair minimum is
zero at every real time where the exceptional anchor is at five sixths. -/
theorem two_divisible_boundary_min_eq_zero
    (v : Fin 5 → ℕ) (hpos : ∀ i, 0 < v i)
    (p q r : Fin 5) (hpq : p ≠ q) (hrp : r ≠ p) (hrq : r ≠ q)
    (hdiv : ∀ i, 3 ∣ v i ↔ i = p ∨ i = q)
    (hsix : 6 ∣ v p ∨ 6 ∣ v q)
    (heven : ((Finset.univ : Finset (Fin 5)).filter
      (fun i => 2 ∣ v i)).card ≤ 3)
    (hno : ¬ ∃ t : ℝ, ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ)))
    (t : ℝ) (ht : Int.fract (t * (v r : ℝ)) = (5 : ℝ) / 6) :
    min (circleNorm (t * (v p : ℝ)))
      (circleNorm (t * (v q : ℝ))) = 0 := by
  have hnonneg (x : ℝ) : 0 ≤ circleNorm x := by
    rw [circleNorm_eq_abs_sub_round]
    exact abs_nonneg _
  have hp : 3 ∣ v p := (hdiv p).mpr (Or.inl rfl)
  have hq : 3 ∣ v q := (hdiv q).mpr (Or.inr rfl)
  have hr : ¬ 3 ∣ v r := by simpa [hdiv, hrp, hrq]
  obtain ⟨τ, _hτpos, _hτlt, hτ, hmax⟩ :=
    exists_five_sixths_fiber_pair_maximizer (v p) (v q) (v r) (hpos r)
  have hMnonneg : 0 ≤ min (circleNorm (τ * (v p : ℝ)))
      (circleNorm (τ * (v q : ℝ))) := le_min (hnonneg _) (hnonneg _)
  have hMsmall : min (circleNorm (τ * (v p : ℝ)))
      (circleNorm (τ * (v q : ℝ))) < (1 : ℝ) / 6 := by
    apply lt_of_not_ge
    intro h
    have hpair := le_min_iff.mp h
    exact hno (pair_special_rescue v p q r hpq hdiv hr τ
      hpair.1 hpair.2 (Or.inr hτ))
  have hMzero : min (circleNorm (τ * (v p : ℝ)))
      (circleNorm (τ * (v q : ℝ))) = 0 := by
    by_contra hne
    have hpositive := lt_of_le_of_ne hMnonneg (Ne.symm hne)
    rcases le_total (circleNorm (τ * (v p : ℝ)))
        (circleNorm (τ * (v q : ℝ))) with horder | horder
    · have hposp : 0 < circleNorm (τ * (v p : ℝ)) := by
        simpa only [min_eq_left horder] using hpositive
      have hsmallp : circleNorm (τ * (v p : ℝ)) < (1 : ℝ) / 6 := by
        simpa only [min_eq_left horder] using hMsmall
      have hbound : ∀ s : ℝ, Int.fract (s * (v r : ℝ)) = (5 : ℝ) / 6 →
          min (circleNorm (s * (v p : ℝ))) (circleNorm (s * (v q : ℝ))) ≤
            circleNorm (τ * (v p : ℝ)) := by
        intro s hs
        simpa only [min_eq_left horder] using hmax s hs
      have H := foldedPairSafeBands_of_five_sixths_pair_bound
        (v p) (v q) (v r) hp hq hr τ hτ hposp hsmallp horder hbound
      exact pair_bands_contradict_nonexistence v p q r hpq hrp hrq
        hdiv hsix heven hno τ hτ H
    · have hposq : 0 < circleNorm (τ * (v q : ℝ)) := by
        simpa only [min_eq_right horder] using hpositive
      have hsmallq : circleNorm (τ * (v q : ℝ)) < (1 : ℝ) / 6 := by
        simpa only [min_eq_right horder] using hMsmall
      have hbound : ∀ s : ℝ, Int.fract (s * (v r : ℝ)) = (5 : ℝ) / 6 →
          min (circleNorm (s * (v q : ℝ))) (circleNorm (s * (v p : ℝ))) ≤
            circleNorm (τ * (v q : ℝ)) := by
        intro s hs
        rw [min_comm]
        simpa only [min_eq_right horder] using hmax s hs
      have H := foldedPairSafeBands_of_five_sixths_pair_bound
        (v q) (v p) (v r) hq hp hr τ hτ hposq hsmallq horder hbound
      have hdiv' : ∀ i, 3 ∣ v i ↔ i = q ∨ i = p := by
        intro i
        rw [hdiv i, or_comm]
      exact pair_bands_contradict_nonexistence v q p r hpq.symm hrq hrp
        hdiv' hsix.symm heven hno τ hτ H
  apply le_antisymm
  · simpa only [hMzero] using hmax t ht
  · exact le_min (hnonneg _) (hnonneg _)

end LonelyRunner
