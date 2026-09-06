import LonelyRunner.EndpointAffineApproximation
import LonelyRunner.PrimitiveAffineRank
import LonelyRunner.AffineLonelyAt

namespace LonelyRunner

noncomputable section

/-- The rational slope obtained by comparing the endpoint height `H` with an
endpoint-approximation denominator `q`. -/
private def endpointSlope (H q : ℕ) : ℚ := (H : ℚ) / (q : ℚ)

/-- The residual rational row after extracting the endpoint slope. -/
private def endpointResidual {m : ℕ} (s : Fin (m + 2) → ℕ)
    (H q : ℕ) (u : Fin (m + 2) → ℤ) : Fin (m + 2) → ℚ :=
  fun i => (s i : ℚ) - endpointSlope H q * (u i : ℚ)

private theorem endpointResidual_identity {m : ℕ} (s : Fin (m + 2) → ℕ)
    (H q : ℕ) (u : Fin (m + 2) → ℤ) (hq : 0 < q) : ∀ i,
    (q : ℚ) * endpointResidual s H q u i =
      (q : ℚ) * (s i : ℚ) - (H : ℚ) * (u i : ℚ) := by
  intro i
  have hqQ : (q : ℚ) ≠ 0 := by exact_mod_cast hq.ne'
  simp only [endpointResidual, endpointSlope]
  field_simp

private theorem endpointResidual_actual {m : ℕ} (s : Fin (m + 2) → ℕ)
    (H q : ℕ) (u : Fin (m + 2) → ℤ) : ∀ i,
    endpointSlope H q * (u i : ℚ) + endpointResidual s H q u i = s i := by
  intro i
  simp [endpointResidual]

private theorem endpointResidual_last {m : ℕ} (s : Fin (m + 2) → ℕ)
    (H q : ℕ) (u : Fin (m + 2) → ℤ)
    (hsH : s (Fin.last (m + 1)) = H)
    (huH : u (Fin.last (m + 1)) = (q : ℤ)) (hq : 0 < q) :
    endpointResidual s H q u (Fin.last (m + 1)) = 0 := by
  have hqQ : (q : ℚ) ≠ 0 := by exact_mod_cast hq.ne'
  simp [endpointResidual, endpointSlope, hsH, huH]
  field_simp
  ring

end

theorem primitive_sorted_largeHeight_lonelyAt {m : ℕ} (hm : 1 ≤ m)
    (hLower : LowerCountPositiveIntegerHypothesis (m + 2))
    (s : Fin (m + 2) → ℕ)
    (hsorted : StrictMono s) (hs0 : s 0 = 0)
    (hprimitive : Finset.univ.gcd s = 1)
    (hheight : ((m + 2) * (m + 1)) ^ m < s (Fin.last (m + 1))) :
    ∀ runner : Fin (m + 2), ∃ t : ℝ, 0 < t ∧
      LonelyAt (fun i => (s i : ℝ)) runner t := by
  classical
  let H : ℕ := s (Fin.last (m + 1))
  let Q : ℕ := (m + 2) * (m + 1)
  have hQpos : 0 < Q := by dsimp [Q]; positivity
  have hQH : Q ^ m < H := by simpa [H, Q] using hheight
  have hHpos : 0 < H := lt_trans (by positivity : 0 < Q ^ m) hQH
  obtain ⟨q, hqone, hqbound, u, hu0, huH, huapprox⟩ :=
    exists_endpoint_affine_approximation s H Q hHpos hQpos hs0 (by rfl)
  have hqpos : 0 < q := lt_of_lt_of_le (by omega) hqone
  have hqH : q < H := lt_of_le_of_lt hqbound hQH
  let p : ℚ := endpointSlope H q
  let v : Fin (m + 2) → ℚ := endpointResidual s H q u
  have hp : 1 < p := by
    dsimp [p, endpointSlope]
    have hqQ : (0 : ℚ) < q := by exact_mod_cast hqpos
    have hqHQ : (q : ℚ) < H := by exact_mod_cast hqH
    rw [lt_div_iff₀ hqQ]
    linarith
  have hv0 : v 0 = 0 := by
    dsimp [v, endpointResidual, endpointSlope]
    simp [hs0, hu0]
  have hvH : v (Fin.last (m + 1)) = 0 := by
    exact endpointResidual_last s H q u (by rfl) huH hqpos
  have hidentity : ∀ i, (q : ℚ) * v i =
      (q : ℚ) * (s i : ℚ) - (H : ℚ) * (u i : ℚ) := by
    intro i
    exact endpointResidual_identity s H q u hqpos i
  have hrank : RationalPairRankTwo u v :=
    rankTwo_of_primitive_approximation s H q hqpos hqH hprimitive u v huH hvH hidentity
  have hactual : ∀ i, p * (u i : ℚ) + v i = s i := by
    intro i
    exact endpointResidual_actual s H q u i
  have hinj : Function.Injective (fun i => p * (u i : ℚ) + v i) := by
    intro i j hij
    apply hsorted.injective
    have : (s i : ℚ) = s j := by simpa [hactual i, hactual j] using hij
    exact_mod_cast this
  have hperiod : ∀ i, ∃ z : ℤ, (q : ℚ) * v i = (z : ℚ) := by
    intro i
    refine ⟨(q : ℤ) * (s i : ℤ) - (H : ℤ) * u i, ?_⟩
    exact_mod_cast hidentity i
  have hp0 : 0 < p := by linarith
  have herror (j : Fin (m + 2)) : |v j| ≤ p / Q := by
    have hj := huapprox j
    have heq : v j = p * ((q : ℚ) * (s j : ℚ) / (H : ℚ) - (u j : ℚ)) := by
      dsimp [v, p, endpointResidual, endpointSlope]
      have hqQ : (q : ℚ) ≠ 0 := by exact_mod_cast hqpos.ne'
      field_simp
    rw [heq, abs_mul, abs_of_pos hp0]
    calc
      p * |(q : ℚ) * (s j : ℚ) / (H : ℚ) - (u j : ℚ)| ≤
          p * ((1 : ℚ) / (Q : ℚ)) :=
        mul_le_mul_of_nonneg_left hj.le hp0.le
      _ = p / Q := by ring
  intro runner
  -- The endpoint error is scaled by the positive slope and then compared
  -- twice by the triangle inequality in the affine witness contract.
  have herr : ∀ i, |v i - v runner| ≤ 2 * p / (Q : ℚ) := by
    intro i
    calc
      |v i - v runner| = |v i + -v runner| := by rw [sub_eq_add_neg]
      _ ≤ |v i| + |-v runner| := abs_add_le _ _
      _ = |v i| + |v runner| := by rw [abs_neg]
      _ ≤ p / Q + p / Q := add_le_add (herror i) (herror runner)
      _ = 2 * p / Q := by ring
  obtain ⟨t, ht, hl⟩ := rational_affine_lonelyAt hm hLower u v p hp q hqpos hu0 hv0
    hrank hinj hperiod runner (by simpa [Q] using herr)
  refine ⟨t, ht, ?_⟩
  have hspeed : (fun i => ((p * (u i : ℚ) + v i : ℚ) : ℝ)) =
      (fun i => (s i : ℝ)) := by
    funext i
    exact_mod_cast hactual i
  rw [hspeed] at hl
  exact hl

/-- The sharper height reduction applies to the stationary minimum label.
The finite branch is inclusive at `choose (m+2) 2 ^ m`; this theorem treats
strictly greater heights and preserves the closed lonely distance threshold. -/
theorem primitive_sorted_largeHeight_stationary_mixed {m : ℕ} (hm : 1 ≤ m)
    (hLower : LowerCountPositiveIntegerHypothesis (m + 2))
    (s : Fin (m + 2) → ℕ)
    (hsorted : StrictMono s) (hs0 : s 0 = 0)
    (hprimitive : Finset.univ.gcd s = 1)
    (hheight : (Nat.choose (m + 2) 2) ^ m < s (Fin.last (m + 1))) :
    ∃ t : ℝ, 0 < t ∧
      LonelyAt (fun i => (s i : ℝ)) 0 t ∧
      (((m + 1 : ℕ) : ℝ)⁻¹) ≤
        circleNorm (t * (s (Fin.last (m + 1)) : ℝ)) := by
  classical
  let H : ℕ := s (Fin.last (m + 1))
  let Q : ℕ := Nat.choose (m + 2) 2
  have hQdouble : 2 * Q = (m + 2) * (m + 1) := by
    simpa [Q, Nat.choose_one_right, Nat.mul_comm] using
      (Nat.add_one_mul_choose_eq (m + 1) 1).symm
  have hQpos : 0 < Q := by nlinarith
  have hQH : Q ^ m < H := by simpa [H, Q] using hheight
  have hHpos : 0 < H := lt_trans (by positivity : 0 < Q ^ m) hQH
  obtain ⟨q, hqone, hqbound, u, hu0, huH, huapprox⟩ :=
    exists_endpoint_affine_approximation s H Q hHpos hQpos hs0 (by rfl)
  have hqpos : 0 < q := lt_of_lt_of_le (by omega) hqone
  have hqH : q < H := lt_of_le_of_lt hqbound hQH
  let p : ℚ := endpointSlope H q
  let v : Fin (m + 2) → ℚ := endpointResidual s H q u
  have hp : 1 < p := by
    dsimp [p, endpointSlope]
    have hqQ : (0 : ℚ) < q := by exact_mod_cast hqpos
    have hqHQ : (q : ℚ) < H := by exact_mod_cast hqH
    rw [lt_div_iff₀ hqQ]
    linarith
  have hv0 : v 0 = 0 := by
    dsimp [v, endpointResidual, endpointSlope]
    simp [hs0, hu0]
  have hvH : v (Fin.last (m + 1)) = 0 := by
    exact endpointResidual_last s H q u (by rfl) huH hqpos
  have hidentity : ∀ i, (q : ℚ) * v i =
      (q : ℚ) * (s i : ℚ) - (H : ℚ) * (u i : ℚ) := by
    intro i
    exact endpointResidual_identity s H q u hqpos i
  have hrank : RationalPairRankTwo u v :=
    rankTwo_of_primitive_approximation s H q hqpos hqH hprimitive u v huH hvH hidentity
  have hactual : ∀ i, p * (u i : ℚ) + v i = s i := by
    intro i
    exact endpointResidual_actual s H q u i
  have hinj : Function.Injective (fun i => p * (u i : ℚ) + v i) := by
    intro i j hij
    apply hsorted.injective
    have : (s i : ℚ) = s j := by simpa [hactual i, hactual j] using hij
    exact_mod_cast this
  have hperiod : ∀ i, ∃ z : ℤ, (q : ℚ) * v i = (z : ℚ) := by
    intro i
    refine ⟨(q : ℤ) * (s i : ℤ) - (H : ℤ) * u i, ?_⟩
    exact_mod_cast hidentity i
  have hp0 : 0 < p := by linarith
  have herror (j : Fin (m + 2)) : |v j| ≤ p / Q := by
    have hj := huapprox j
    have heq : v j = p * ((q : ℚ) * (s j : ℚ) / (H : ℚ) - (u j : ℚ)) := by
      dsimp [v, p, endpointResidual, endpointSlope]
      have hqQ : (q : ℚ) ≠ 0 := by exact_mod_cast hqpos.ne'
      field_simp
    rw [heq, abs_mul, abs_of_pos hp0]
    calc
      p * |(q : ℚ) * (s j : ℚ) / (H : ℚ) - (u j : ℚ)| ≤
          p * ((1 : ℚ) / (Q : ℚ)) :=
        mul_le_mul_of_nonneg_left hj.le hp0.le
      _ = p / Q := by ring
  -- At the stationary endpoint the residual is zero, so no second error
  -- term is needed. This is exactly where the halved approximation base enters.
  have herr : ∀ i, |v i - v 0| ≤
      2 * p / (((m + 2) * (m + 1) : ℕ) : ℚ) := by
    intro i
    rw [hv0, sub_zero]
    calc
      |v i| ≤ p / Q := herror i
      _ = 2 * p / (((m + 2) * (m + 1) : ℕ) : ℚ) := by
        rw [← hQdouble]
        push_cast
        ring
  obtain ⟨t, ht, hl, hzero⟩ := rational_affine_lonelyAt_with_equalResidual hm hLower u v p hp q hqpos hu0 hv0
    hrank hinj hperiod 0 herr
  have hspeed : (fun i => ((p * (u i : ℚ) + v i : ℚ) : ℝ)) =
      (fun i => (s i : ℝ)) := by
    funext i
    exact_mod_cast hactual i
  refine ⟨t, ht, ?_, ?_⟩
  · rw [hspeed] at hl
    exact hl
  · have hlast : Fin.last (m + 1) ≠ 0 := by
      intro h
      have hval : m + 1 = 0 := by simpa using congrArg Fin.val h
      omega
    have hfast := hzero (Fin.last (m + 1)) hlast (by rw [hvH, hv0])
    have hlastactual : ((p * (u (Fin.last (m + 1)) : ℚ) + v (Fin.last (m + 1)) : ℚ) : ℝ) =
        (s (Fin.last (m + 1)) : ℝ) := by exact_mod_cast hactual (Fin.last (m + 1))
    have hzeroactual : ((p * (u 0 : ℚ) + v 0 : ℚ) : ℝ) = (s 0 : ℝ) := by
      exact_mod_cast hactual 0
    rw [hlastactual, hzeroactual, hs0] at hfast
    simpa [hs0] using hfast

/-- The original stationary height theorem is the ordinary projection of the
mixed-margin large-height reduction. -/
theorem primitive_sorted_largeHeight_stationary_lonelyAt {m : ℕ} (hm : 1 ≤ m)
    (hLower : LowerCountPositiveIntegerHypothesis (m + 2))
    (s : Fin (m + 2) → ℕ)
    (hsorted : StrictMono s) (hs0 : s 0 = 0)
    (hprimitive : Finset.univ.gcd s = 1)
    (hheight : (Nat.choose (m + 2) 2) ^ m < s (Fin.last (m + 1))) :
    ∃ t : ℝ, 0 < t ∧ LonelyAt (fun i => (s i : ℝ)) 0 t := by
  obtain ⟨t, ht, hl, _⟩ :=
    primitive_sorted_largeHeight_stationary_mixed hm hLower s hsorted hs0 hprimitive hheight
  exact ⟨t, ht, hl⟩

/-- Under the same lower-count supply, a sorted primitive stationary tuple
without a positive mixed witness lies in the inclusive sharper finite range. -/
theorem primitive_sorted_noMixed_height_le {m : ℕ} (hm : 1 ≤ m)
    (hLower : LowerCountPositiveIntegerHypothesis (m + 2))
    (s : Fin (m + 2) → ℕ)
    (hsorted : StrictMono s) (hs0 : s 0 = 0)
    (hprimitive : Finset.univ.gcd s = 1)
    (hnoMixed : ∀ t : ℝ, ¬ (0 < t ∧ LonelyAt (fun i => (s i : ℝ)) 0 t ∧
      (((m + 1 : ℕ) : ℝ)⁻¹) ≤ circleNorm (t * (s (Fin.last (m + 1)) : ℝ))) ) :
    s (Fin.last (m + 1)) ≤ (Nat.choose (m + 2) 2) ^ m := by
  by_contra hnot
  have hheight : (Nat.choose (m + 2) 2) ^ m < s (Fin.last (m + 1)) := by omega
  obtain ⟨t, ht, hl, hfast⟩ :=
    primitive_sorted_largeHeight_stationary_mixed hm hLower s hsorted hs0 hprimitive hheight
  exact hnoMixed t ⟨ht, hl, hfast⟩

end LonelyRunner
