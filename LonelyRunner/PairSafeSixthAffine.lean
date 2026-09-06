import LonelyRunner.ThreeResidueModSix
import LonelyRunner.SixthAffineFoldedNorm
import LonelyRunner.SixthAffineSpecialAnchor
import LonelyRunner.FoldedPairSafeBands

/-!
# Finite affine selector for a divisible pair

The residue certificates reduce the selector to five fixed rows.  Each row
uses a named folded-band field and preserves a special sixth phase for the
nondivisible anchor.
-/

namespace LonelyRunner

private abbrev PairSafe (a b : ℕ) (s : ℝ) : Prop :=
  (1 : ℝ) / 6 ≤ circleNorm (s * (a : ℝ)) ∧
    (1 : ℝ) / 6 ≤ circleNorm (s * (b : ℝ))

private theorem sixth_safe_zero_residue (τ : ℝ) (d n : ℕ) (σ z : ℤ)
    (hd : (d : ℤ) = 6 * z) (hs : (1 : ℝ) / 6 ≤
      circleNorm ((n : ℝ) * circleNorm (τ * (d : ℝ)))) :
    (1 : ℝ) / 6 ≤ circleNorm (((n : ℝ) * τ + (σ : ℝ) / 6) * (d : ℝ)) := by
  rw [circleNorm_sixth_affine_of_three_residue τ d n σ z 0]
  · norm_num
    exact hs
  · simpa using hd

private theorem sixth_safe_one_residue (τ : ℝ) (d n : ℕ) (σ z : ℤ)
    (hσ : σ = 1 ∨ σ = -1)
    (hd : (d : ℤ) = 6 * z + 3)
    (hs : (1 : ℝ) / 6 ≤
      circleNorm ((n : ℝ) * circleNorm (τ * (d : ℝ)) + (1 : ℝ) / 2)) :
    (1 : ℝ) / 6 ≤ circleNorm (((n : ℝ) * τ + (σ : ℝ) / 6) * (d : ℝ)) := by
  rw [circleNorm_sixth_affine_of_three_residue τ d n σ z 1]
  · norm_num only [Int.mul_one]
    rw [circleNorm_add_signed_half _ σ hσ]
    exact hs
  · simpa using hd

private theorem anchor_two_one (τ : ℝ) (c : ℕ) (z σ : ℤ)
    (hd : (c : ℤ) = 6 * z + (1 : ℤ) * σ)
    (hσ : σ = 1 ∨ σ = -1)
    (ht : Int.fract (τ * (c : ℝ)) = (5 : ℝ) / 6) :
    Int.fract ((((2 : ℕ) : ℝ) * τ + (σ : ℝ) / 6) * (c : ℝ)) =
      (5 : ℝ) / 6 := by
  rw [show Int.fract ((((2 : ℕ) : ℝ) * τ + (σ : ℝ) / 6) * (c : ℝ)) =
    Int.fract (((5 * 2 + 1 : ℕ) : ℝ) / 6) by
      exact fract_sixth_affine_special_anchor τ c 2 1 z σ hd hσ ht]
  change Int.fract (((11 : ℕ) : ℝ) / ((6 : ℕ) : ℝ)) = (5 : ℝ) / 6
  rw [Int.fract_div_natCast_eq_div_natCast_mod]
  norm_num

private theorem anchor_three_two (τ : ℝ) (c : ℕ) (z σ : ℤ)
    (hd : (c : ℤ) = 6 * z + (2 : ℤ) * σ)
    (hσ : σ = 1 ∨ σ = -1)
    (ht : Int.fract (τ * (c : ℝ)) = (5 : ℝ) / 6) :
    Int.fract ((((3 : ℕ) : ℝ) * τ + (σ : ℝ) / 6) * (c : ℝ)) =
      (5 : ℝ) / 6 := by
  rw [show Int.fract ((((3 : ℕ) : ℝ) * τ + (σ : ℝ) / 6) * (c : ℝ)) =
    Int.fract (((5 * 3 + 2 : ℕ) : ℝ) / 6) by
      exact fract_sixth_affine_special_anchor τ c 3 2 z σ hd hσ ht]
  change Int.fract (((17 : ℕ) : ℝ) / ((6 : ℕ) : ℝ)) = (5 : ℝ) / 6
  rw [Int.fract_div_natCast_eq_div_natCast_mod]
  norm_num

private theorem anchor_one_two (τ : ℝ) (c : ℕ) (z σ : ℤ)
    (hd : (c : ℤ) = 6 * z + (2 : ℤ) * σ)
    (hσ : σ = 1 ∨ σ = -1)
    (ht : Int.fract (τ * (c : ℝ)) = (5 : ℝ) / 6) :
    Int.fract ((((1 : ℕ) : ℝ) * τ + (σ : ℝ) / 6) * (c : ℝ)) =
      (1 : ℝ) / 6 := by
  rw [show Int.fract ((((1 : ℕ) : ℝ) * τ + (σ : ℝ) / 6) * (c : ℝ)) =
    Int.fract (((5 * 1 + 2 : ℕ) : ℝ) / 6) by
      exact fract_sixth_affine_special_anchor τ c 1 2 z σ hd hσ ht]
  change Int.fract (((7 : ℕ) : ℝ) / ((6 : ℕ) : ℝ)) = (1 : ℝ) / 6
  rw [Int.fract_div_natCast_eq_div_natCast_mod]
  norm_num

/-- The five checked folded-band rows select a common affine time for the
divisible pair and leave the nondivisible anchor at an odd sixth. -/
theorem exists_pair_safe_special_sixth_affine
    (a b c : ℕ) (ha : 3 ∣ a) (hb : 3 ∣ b) (hc : ¬ 3 ∣ c)
    (hsix : 6 ∣ a ∨ 6 ∣ b)
    (hregular : ¬ (6 ∣ a ∧ 6 ∣ b ∧ 2 ∣ c))
    (τ : ℝ) (ht : Int.fract (τ * (c : ℝ)) = (5 : ℝ) / 6)
    (H : FoldedPairSafeBands (circleNorm (τ * (a : ℝ)))
      (circleNorm (τ * (b : ℝ))) ) :
    ∃ (n : ℕ) (σ : ℤ), (n = 1 ∨ n = 2 ∨ n = 3) ∧
      (σ = 1 ∨ σ = -1) ∧ PairSafe a b ((n : ℝ) * τ + (σ : ℝ) / 6) ∧
      (Int.fract (((n : ℝ) * τ + (σ : ℝ) / 6) * (c : ℝ)) =
          (1 : ℝ) / 6 ∨
        Int.fract (((n : ℝ) * τ + (σ : ℝ) / 6) * (c : ℝ)) =
          (5 : ℝ) / 6) := by
  obtain ⟨za, εa, hda, hεa, ha6⟩ := exists_three_residue_mod_six a ha
  obtain ⟨zb, εb, hdb, hεb, hb6⟩ := exists_three_residue_mod_six b hb
  obtain ⟨zc, e, hdc, he⟩ := exists_centered_sixth_residue_of_not_dvd_three c hc
  rcases hεa with hεa | hεa <;> rcases hεb with hεb | hεb
  · have ha0 : (a : ℤ) = 6 * za := by simpa [hεa] using hda
    have hb0 : (b : ℤ) = 6 * zb := by simpa [hεb] using hdb
    have h6a : 6 ∣ a := ha6.mpr hεa
    have h6b : 6 ∣ b := hb6.mpr hεb
    rcases he with he | he | he | he
    · refine ⟨2, 1, Or.inr (Or.inl rfl), Or.inl rfl, ?_, Or.inr ?_⟩
      constructor
      · exact sixth_safe_zero_residue τ a 2 1 za ha0 H.left_two
      · exact sixth_safe_zero_residue τ b 2 1 zb hb0 H.right_two
      exact anchor_two_one τ c zc 1 (by simpa [he] using hdc) (Or.inl rfl) ht
    · refine ⟨2, -1, Or.inr (Or.inl rfl), Or.inr rfl, ?_, Or.inr ?_⟩
      constructor
      · exact sixth_safe_zero_residue τ a 2 (-1) za ha0 H.left_two
      · exact sixth_safe_zero_residue τ b 2 (-1) zb hb0 H.right_two
      exact anchor_two_one τ c zc (-1) (by simpa [he] using hdc) (Or.inr rfl) ht
    · exfalso
      apply hregular
      refine ⟨h6a, h6b, ?_⟩
      have hcz : (2 : ℤ) ∣ (c : ℤ) := by
        refine ⟨3 * zc + 1, ?_⟩
        linarith [hdc, he]
      exact_mod_cast hcz
    · exfalso
      apply hregular
      refine ⟨h6a, h6b, ?_⟩
      have hcz : (2 : ℤ) ∣ (c : ℤ) := by
        refine ⟨3 * zc - 1, ?_⟩
        linarith [hdc, he]
      exact_mod_cast hcz
  · have ha0 : (a : ℤ) = 6 * za := by simpa [hεa] using hda
    have hb1 : (b : ℤ) = 6 * zb + 3 := by simpa [hεb] using hdb
    rcases he with he | he | he | he
    · refine ⟨2, 1, Or.inr (Or.inl rfl), Or.inl rfl, ?_, Or.inr ?_⟩
      constructor
      · exact sixth_safe_zero_residue τ a 2 1 za ha0 H.left_two
      · exact sixth_safe_one_residue τ b 2 1 zb (Or.inl rfl) hb1 H.right_two_half
      exact anchor_two_one τ c zc 1 (by simpa [he] using hdc) (Or.inl rfl) ht
    · refine ⟨2, -1, Or.inr (Or.inl rfl), Or.inr rfl, ?_, Or.inr ?_⟩
      constructor
      · exact sixth_safe_zero_residue τ a 2 (-1) za ha0 H.left_two
      · exact sixth_safe_one_residue τ b 2 (-1) zb (Or.inr rfl) hb1 H.right_two_half
      exact anchor_two_one τ c zc (-1) (by simpa [he] using hdc) (Or.inr rfl) ht
    · refine ⟨3, 1, Or.inr (Or.inr rfl), Or.inl rfl, ?_, Or.inr ?_⟩
      constructor
      · exact sixth_safe_zero_residue τ a 3 1 za ha0 H.left_three
      · exact sixth_safe_one_residue τ b 3 1 zb (Or.inl rfl) hb1 H.right_three_half
      exact anchor_three_two τ c zc 1 (by simpa [he] using hdc) (Or.inl rfl) ht
    · refine ⟨3, -1, Or.inr (Or.inr rfl), Or.inr rfl, ?_, Or.inr ?_⟩
      constructor
      · exact sixth_safe_zero_residue τ a 3 (-1) za ha0 H.left_three
      · exact sixth_safe_one_residue τ b 3 (-1) zb (Or.inr rfl) hb1 H.right_three_half
      exact anchor_three_two τ c zc (-1) (by simpa [he] using hdc) (Or.inr rfl) ht
  · have ha1 : (a : ℤ) = 6 * za + 3 := by simpa [hεa] using hda
    have hb0 : (b : ℤ) = 6 * zb := by simpa [hεb] using hdb
    rcases he with he | he | he | he
    · refine ⟨2, 1, Or.inr (Or.inl rfl), Or.inl rfl, ?_, Or.inr ?_⟩
      constructor
      · exact sixth_safe_one_residue τ a 2 1 za (Or.inl rfl) ha1 H.left_two_half
      · exact sixth_safe_zero_residue τ b 2 1 zb hb0 H.right_two
      exact anchor_two_one τ c zc 1 (by simpa [he] using hdc) (Or.inl rfl) ht
    · refine ⟨2, -1, Or.inr (Or.inl rfl), Or.inr rfl, ?_, Or.inr ?_⟩
      constructor
      · exact sixth_safe_one_residue τ a 2 (-1) za (Or.inr rfl) ha1 H.left_two_half
      · exact sixth_safe_zero_residue τ b 2 (-1) zb hb0 H.right_two
      exact anchor_two_one τ c zc (-1) (by simpa [he] using hdc) (Or.inr rfl) ht
    · refine ⟨1, 1, Or.inl rfl, Or.inl rfl, ?_, Or.inl ?_⟩
      constructor
      · exact sixth_safe_one_residue τ a 1 1 za (Or.inl rfl) ha1 (by simpa using H.left_half)
      · exact sixth_safe_zero_residue τ b 1 1 zb hb0 (by simpa using H.right_one)
      exact anchor_one_two τ c zc 1 (by simpa [he] using hdc) (Or.inl rfl) ht
    · refine ⟨1, -1, Or.inl rfl, Or.inr rfl, ?_, Or.inl ?_⟩
      constructor
      · exact sixth_safe_one_residue τ a 1 (-1) za (Or.inr rfl) ha1 (by simpa using H.left_half)
      · exact sixth_safe_zero_residue τ b 1 (-1) zb hb0 (by simpa using H.right_one)
      exact anchor_one_two τ c zc (-1) (by simpa [he] using hdc) (Or.inr rfl) ht
  · exfalso
    rcases hsix with h6 | h6
    · have hzero := ha6.mp h6
      omega
    · have hzero := hb6.mp h6
      omega

end LonelyRunner
