import LonelyRunner.Definitions
import Mathlib.Data.Fintype.Pigeonhole
import Mathlib.Algebra.Order.Floor.Ring

namespace LonelyRunner

/-- The half-open fractional box of a real coordinate at resolution Q. -/
noncomputable def fractionalBox (Q : ℕ) (hQ : 0 < Q) (x : ℝ) : Fin Q :=
  ⟨⌊(Q : ℝ) * Int.fract x⌋₊, by
    apply (Nat.floor_lt (mul_nonneg (by positivity) (Int.fract_nonneg x))).mpr
    have := mul_lt_mul_of_pos_left (Int.fract_lt_one x) (show (0 : ℝ) < Q by exact_mod_cast hQ)
    simpa using this⟩

/-- Equal half-open fractional boxes have strict coordinate error below one
box width. -/
theorem fractionalBox_eq_error {Q : ℕ} (hQ : 0 < Q) (x y : ℝ)
    (h : fractionalBox Q hQ x = fractionalBox Q hQ y) :
    |Int.fract x - Int.fract y| < (1 : ℝ) / (Q : ℝ) := by
  have hQR : (0 : ℝ) < (Q : ℝ) := by exact_mod_cast hQ
  have hx0 : 0 ≤ (Q : ℝ) * Int.fract x :=
    mul_nonneg (by positivity) (Int.fract_nonneg x)
  have hy0 : 0 ≤ (Q : ℝ) * Int.fract y :=
    mul_nonneg (by positivity) (Int.fract_nonneg y)
  have hfloor : ⌊(Q : ℝ) * Int.fract x⌋₊ =
      ⌊(Q : ℝ) * Int.fract y⌋₊ := congrArg Fin.val h
  have hxlo : (⌊(Q : ℝ) * Int.fract x⌋₊ : ℝ) ≤
      (Q : ℝ) * Int.fract x := Nat.floor_le hx0
  have hylo : (⌊(Q : ℝ) * Int.fract y⌋₊ : ℝ) ≤
      (Q : ℝ) * Int.fract y := Nat.floor_le hy0
  have hxhi : (Q : ℝ) * Int.fract x <
      (⌊(Q : ℝ) * Int.fract x⌋₊ : ℝ) + 1 := Nat.lt_floor_add_one _
  have hyhi : (Q : ℝ) * Int.fract y <
      (⌊(Q : ℝ) * Int.fract y⌋₊ : ℝ) + 1 := Nat.lt_floor_add_one _
  have hscaled : |(Q : ℝ) * (Int.fract x - Int.fract y)| < 1 := by
    rw [show (Q : ℝ) * (Int.fract x - Int.fract y) =
      (Q : ℝ) * Int.fract x - (Q : ℝ) * Int.fract y by ring]
    apply abs_lt.mpr
    constructor <;> rw [hfloor] at *
    · linarith
    · linarith
  rw [abs_mul, abs_of_pos hQR] at hscaled
  apply (lt_div_iff₀ hQR).mpr
  simpa [mul_comm] using hscaled

/-- Simultaneous strict Dirichlet approximation by one positive integer
denominator, obtained from half-open fractional boxes. -/
theorem exists_simultaneous_integer_approximation (d Q : ℕ) (hQ : 0 < Q)
    (x : Fin d → ℝ) :
    ∃ q : ℕ, 0 < q ∧ q ≤ Q ^ d ∧ ∃ z : Fin d → ℤ, ∀ i,
      |(q : ℝ) * x i - (z i : ℝ)| < (1 : ℝ) / (Q : ℝ) := by
  let f : Fin (Q ^ d + 1) → (Fin d → Fin Q) :=
    fun k i => fractionalBox Q hQ ((k : ℝ) * x i)
  have hcard : Fintype.card (Fin d → Fin Q) < Fintype.card (Fin (Q ^ d + 1)) := by
    simp
  obtain ⟨a, b, hab, heq⟩ := Fintype.exists_ne_map_eq_of_card_lt f hcard
  obtain hablt | hba := lt_or_gt_of_ne hab
  · refine ⟨b - a, by omega, by omega, ?_⟩
    let z : Fin d → ℤ := fun i => ⌊(b : ℝ) * x i⌋ - ⌊(a : ℝ) * x i⌋
    refine ⟨z, ?_⟩
    intro i
    have hbox : fractionalBox Q hQ ((b : ℝ) * x i) =
        fractionalBox Q hQ ((a : ℝ) * x i) := congrFun heq.symm i
    have herr := fractionalBox_eq_error hQ ((b : ℝ) * x i) ((a : ℝ) * x i) hbox
    simp only [Int.fract] at herr
    have hcast : ((b - a : ℕ) : ℝ) = (b : ℝ) - (a : ℝ) := by
      rw [Nat.cast_sub (le_of_lt hablt)]
    rw [hcast]
    dsimp [z]
    rw [Int.cast_sub]
    change |((b : ℝ) - (a : ℝ)) * x i -
      ((⌊(b : ℝ) * x i⌋ : ℝ) - (⌊(a : ℝ) * x i⌋ : ℝ))| < _
    have heqphase :
        ((b : ℝ) - (a : ℝ)) * x i -
          ((⌊(b : ℝ) * x i⌋ : ℝ) - (⌊(a : ℝ) * x i⌋ : ℝ)) =
          ((b : ℝ) * x i - (⌊(b : ℝ) * x i⌋ : ℝ)) -
            ((a : ℝ) * x i - (⌊(a : ℝ) * x i⌋ : ℝ)) := by
      ring
    rw [heqphase]
    exact herr
  · refine ⟨a - b, by omega, by omega, ?_⟩
    let z : Fin d → ℤ := fun i => ⌊(a : ℝ) * x i⌋ - ⌊(b : ℝ) * x i⌋
    refine ⟨z, ?_⟩
    intro i
    have hbox : fractionalBox Q hQ ((a : ℝ) * x i) =
        fractionalBox Q hQ ((b : ℝ) * x i) := congrFun heq i
    have herr := fractionalBox_eq_error hQ ((a : ℝ) * x i) ((b : ℝ) * x i) hbox
    simp only [Int.fract] at herr
    have hcast : ((a - b : ℕ) : ℝ) = (a : ℝ) - (b : ℝ) := by
      rw [Nat.cast_sub (le_of_lt hba)]
    rw [hcast]
    dsimp [z]
    rw [Int.cast_sub]
    change |((a : ℝ) - (b : ℝ)) * x i -
      ((⌊(a : ℝ) * x i⌋ : ℝ) - (⌊(b : ℝ) * x i⌋ : ℝ))| < _
    have heqphase :
        ((a : ℝ) - (b : ℝ)) * x i -
          ((⌊(a : ℝ) * x i⌋ : ℝ) - (⌊(b : ℝ) * x i⌋ : ℝ)) =
          ((a : ℝ) * x i - (⌊(a : ℝ) * x i⌋ : ℝ)) -
            ((b : ℝ) * x i - (⌊(b : ℝ) * x i⌋ : ℝ)) := by
      ring
    rw [heqphase]
    exact herr

end LonelyRunner
