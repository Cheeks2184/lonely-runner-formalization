import LonelyRunner.PivotResidues
import Mathlib.Tactic

/-!
# Rational-margin residue certificates

Closed circle-margin inequalities at a natural rational phase are exactly two
natural cross-product inequalities.  The API intentionally permits zero
numerators, repeated speeds, and zero speeds; positivity is needed only for
denominators and for a later positive-time wrapper.
-/

namespace LonelyRunner

/-- Exact residue characterization of an arbitrary nonnegative rational
margin.  No positivity or half-circle assumption on the margin is used. -/
theorem rationalMargin_circleNorm_iff {A B q x : ℕ}
    (hB : 0 < B) (hq : 0 < q) :
    (A : ℝ) / (B : ℝ) ≤ circleNorm ((x : ℝ) / (q : ℝ)) ↔
      A * q ≤ B * (x % q) ∧ B * (x % q) + A * q ≤ B * q := by
  rw [circleNorm_nat_div_eq]
  have hBR : (0 : ℝ) < (B : ℝ) := by exact_mod_cast hB
  have hqR : (0 : ℝ) < (q : ℝ) := by exact_mod_cast hq
  rw [div_le_div_iff₀ hBR hqR]
  let r := x % q
  have hrlt : r < q := by
    dsimp [r]
    exact Nat.mod_lt _ hq
  change (A : ℝ) * (q : ℝ) ≤ (min r (q - r) : ℕ) * (B : ℝ) ↔
    A * q ≤ B * r ∧ B * r + A * q ≤ B * q
  rw [mul_comm]
  constructor
  · intro h
    have hnatR : ((A * q : ℕ) : ℝ) ≤ ((B * min r (q - r) : ℕ) : ℝ) := by
      simpa [Nat.cast_mul, mul_comm] using h
    have hnat : A * q ≤ B * min r (q - r) := by exact_mod_cast hnatR
    constructor
    · exact hnat.trans (Nat.mul_le_mul_left B (min_le_left _ _))
    · have hright : A * q ≤ B * (q - r) :=
        hnat.trans (Nat.mul_le_mul_left B (min_le_right _ _))
      rw [Nat.mul_sub_left_distrib] at hright
      have hBr : B * r ≤ B * q := Nat.mul_le_mul_left B (Nat.le_of_lt hrlt)
      simpa [Nat.add_comm] using (Nat.le_sub_iff_add_le hBr).mp hright
  · rintro ⟨hlow, hupp⟩
    have hright : A * q ≤ B * (q - r) := by
      rw [Nat.mul_sub_left_distrib]
      omega
    have hnat : A * q ≤ B * min r (q - r) := by
      rcases le_total r (q - r) with hmin | hmin
      · rw [min_eq_left hmin]
        exact hlow
      · rw [min_eq_right hmin]
        exact hright
    have hnatR : ((A * q : ℕ) : ℝ) ≤ ((B * min r (q - r) : ℕ) : ℝ) := by
      exact_mod_cast hnat
    simpa [Nat.cast_mul, mul_comm] using hnatR

/-- Boolean form of the two natural cross-product checks for one coordinate. -/
def rationalMarginResidueOK (A B q x : ℕ) : Bool :=
  (A * q ≤ B * (x % q)) && (B * (x % q) + A * q ≤ B * q)

theorem rationalMarginResidueOK_iff {A B q x : ℕ} :
    rationalMarginResidueOK A B q x = true ↔
      A * q ≤ B * (x % q) ∧ B * (x % q) + A * q ≤ B * q := by
  simp [rationalMarginResidueOK]

/-- A finite rational-margin row, with one numerator and denominator per
coordinate and one common natural rational time. -/
def rationalMarginRowOK {n : ℕ} (speeds num den : Fin n → ℕ) (p q : ℕ) : Bool :=
  decide (0 < q ∧ ∀ i, 0 < den i ∧
    rationalMarginResidueOK (num i) (den i) q (speeds i * p) = true)

theorem rationalMarginRowOK_iff {n : ℕ} (speeds num den : Fin n → ℕ) (p q : ℕ) :
    rationalMarginRowOK speeds num den p q = true ↔
      0 < q ∧ ∀ i, 0 < den i ∧
        num i * q ≤ den i * ((speeds i * p) % q) ∧
        den i * ((speeds i * p) % q) + num i * q ≤ den i * q := by
  simp [rationalMarginRowOK, rationalMarginResidueOK, and_assoc]

theorem rationalMarginRowOK_sound {n : ℕ} (speeds num den : Fin n → ℕ) (p q : ℕ)
    (hrow : rationalMarginRowOK speeds num den p q = true) :
    ∀ i, (num i : ℝ) / (den i : ℝ) ≤
      circleNorm (((p : ℝ) / (q : ℝ)) * (speeds i : ℝ)) := by
  obtain ⟨hq, hcoords⟩ := (rationalMarginRowOK_iff speeds num den p q).mp hrow
  intro i
  rw [show ((p : ℝ) / (q : ℝ)) * (speeds i : ℝ) =
      ((speeds i * p : ℕ) : ℝ) / (q : ℝ) by push_cast; ring]
  exact (rationalMargin_circleNorm_iff (hcoords i).1 hq).mpr ⟨(hcoords i).2.1,
    (hcoords i).2.2⟩

/-- The finite Boolean row is equivalent to the corresponding real
closed-margin statement, with denominator positivity made explicit. -/
theorem rationalMarginRowOK_circleNorm_iff {n : ℕ}
    (speeds num den : Fin n → ℕ) (p q : ℕ) :
    rationalMarginRowOK speeds num den p q = true ↔
      0 < q ∧ ∀ i, 0 < den i ∧
        (num i : ℝ) / (den i : ℝ) ≤
          circleNorm (((p : ℝ) / (q : ℝ)) * (speeds i : ℝ)) := by
  constructor
  · intro hrow
    obtain ⟨hq, hcoords⟩ := (rationalMarginRowOK_iff speeds num den p q).mp hrow
    refine ⟨hq, fun i => ⟨(hcoords i).1, ?_⟩⟩
    exact rationalMarginRowOK_sound speeds num den p q hrow i
  · rintro ⟨hq, hcoords⟩
    apply (rationalMarginRowOK_iff speeds num den p q).mpr
    refine ⟨hq, fun i => ⟨(hcoords i).1, ?_, ?_⟩⟩
    · have hphase : ((p : ℝ) / (q : ℝ)) * (speeds i : ℝ) =
          ((speeds i * p : ℕ) : ℝ) / (q : ℝ) := by
          push_cast
          ring
      have hnorm := (hcoords i).2
      rw [hphase] at hnorm
      exact (rationalMargin_circleNorm_iff (hcoords i).1 hq).mp hnorm |>.1
    · have hphase : ((p : ℝ) / (q : ℝ)) * (speeds i : ℝ) =
          ((speeds i * p : ℕ) : ℝ) / (q : ℝ) := by
          push_cast
          ring
      have hnorm := (hcoords i).2
      rw [hphase] at hnorm
      exact (rationalMargin_circleNorm_iff (hcoords i).1 hq).mp hnorm |>.2

theorem rationalMarginRowOK_exists_positive_time {n : ℕ}
    (speeds num den : Fin n → ℕ) (p q : ℕ) (hp : 0 < p)
    (hrow : rationalMarginRowOK speeds num den p q = true) :
    ∃ t : ℝ, 0 < t ∧ ∀ i, (num i : ℝ) / (den i : ℝ) ≤
      circleNorm (t * (speeds i : ℝ)) := by
  have hq : 0 < q := (rationalMarginRowOK_iff speeds num den p q).mp hrow |>.1
  refine ⟨(p : ℝ) / (q : ℝ), div_pos (by exact_mod_cast hp) (by exact_mod_cast hq), ?_⟩
  exact rationalMarginRowOK_sound speeds num den p q hrow

end LonelyRunner
