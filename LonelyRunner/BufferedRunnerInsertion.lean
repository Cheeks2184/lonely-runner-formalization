import LonelyRunner.PairSumCompleteness
import LonelyRunner.FastRunnerInsertion

/-!
# Buffered runner insertion

This finite-band insertion theorem preserves a smaller closed margin for all
old positive speeds while moving a new positive speed into a prescribed closed
circle band.
-/

namespace LonelyRunner

open Finset

/-- Insert a positive new speed after intersecting the old finite floor bands.
The same-owner and distinct-owner hypotheses certify enough width for the
midpoint phase adjustment. -/
theorem bufferedRunnerInsertion {n : ℕ} (hn : 0 < n)
    (speeds : Fin n → ℝ) (hspeed : ∀ i, 0 < speeds i)
    (seed : ℝ) (hseedpos : 0 < seed) (newSpeed : ℝ) (hnew : 0 < newSpeed)
    (δ β : ℝ) (hδ : 0 < δ) (hδhalf : δ < (1 : ℝ) / 2)
    (hβ : 0 ≤ β) (hβhalf : β ≤ (1 : ℝ) / 2)
    (margins : Fin n → ℝ) (hslack : ∀ i, δ < margins i)
    (hold : ∀ i, margins i ≤ circleNorm (seed * speeds i))
    (hsame : ∀ i, 2 * β / newSpeed ≤ (1 - 2 * δ) / speeds i)
    (hpairs : ∀ i j, i ≠ j →
      2 * β / newSpeed ≤ (margins i - δ) / speeds i +
        (margins j - δ) / speeds j) :
    ∃ time : ℝ, 0 < time ∧ β ≤ circleNorm (time * newSpeed) ∧
      ∀ i, δ ≤ circleNorm (time * speeds i) := by
  classical
  let z : Fin n → ℤ := fun i => ⌊seed * speeds i⌋
  let L : Fin n → ℝ := fun i => ((z i : ℝ) + δ) / speeds i
  let R : Fin n → ℝ := fun i => ((z i : ℝ) + 1 - δ) / speeds i
  have hnonempty : (Finset.univ : Finset (Fin n)).Nonempty := by
    exact ⟨⟨0, hn⟩, Finset.mem_univ _⟩
  obtain ⟨p, hp, hpmax⟩ := Finset.exists_max_image Finset.univ L hnonempty
  obtain ⟨q, hq, hqmin⟩ := Finset.exists_min_image Finset.univ R hnonempty
  have hbands : ∀ i, L i ≤ seed ∧ seed ≤ R i := by
    intro i
    have hfloorlo : (z i : ℝ) ≤ seed * speeds i := by
      exact Int.floor_le _
    have hfloorhi : seed * speeds i ≤ (z i : ℝ) + 1 := by
      exact (Int.lt_floor_add_one _).le
    obtain ⟨hlo, hhi⟩ := int_band_of_circleNorm_ge (z i) (seed * speeds i)
      (margins i) hfloorlo hfloorhi (hold i)
    constructor
    · change ((z i : ℝ) + δ) / speeds i ≤ seed
      exact (div_le_iff₀ (hspeed i)).mpr (by linarith [hslack i])
    · change seed ≤ ((z i : ℝ) + 1 - δ) / speeds i
      exact (le_div_iff₀ (hspeed i)).mpr (by linarith [hslack i])
  have hLp : L p ≤ seed := (hbands p).1
  have hRq : seed ≤ R q := (hbands q).2
  have hLR : L p ≤ R q := hLp.trans hRq
  have hwidth : 2 * β / newSpeed ≤ R q - L p := by
    by_cases hpq : p = q
    · subst q
      have hsamep := hsame p
      have hwidthp : R p - L p = (1 - 2 * δ) / speeds p := by
        dsimp [R, L]
        field_simp
        ring
      rwa [hwidthp]
    · have hpLower : (z p : ℝ) + margins p ≤ seed * speeds p := by
        have hfloorlo : (z p : ℝ) ≤ seed * speeds p := Int.floor_le _
        have hfloorhi : seed * speeds p ≤ (z p : ℝ) + 1 :=
          (Int.lt_floor_add_one _).le
        exact (int_band_of_circleNorm_ge (z p) (seed * speeds p) (margins p)
          hfloorlo hfloorhi (hold p)).1
      have hqUpper : seed * speeds q ≤ (z q : ℝ) + 1 - margins q := by
        have hfloorlo : (z q : ℝ) ≤ seed * speeds q := Int.floor_le _
        have hfloorhi : seed * speeds q ≤ (z q : ℝ) + 1 :=
          (Int.lt_floor_add_one _).le
        exact (int_band_of_circleNorm_ge (z q) (seed * speeds q) (margins q)
          hfloorlo hfloorhi (hold q)).2
      have hpbuffer : (margins p - δ) / speeds p ≤ seed - L p := by
        exact (div_le_iff₀ (hspeed p)).mpr (by
          have hcalc : (seed - ((z p : ℝ) + δ) / speeds p) * speeds p =
              seed * speeds p - ((z p : ℝ) + δ) := by
            field_simp [(hspeed p).ne']
          rw [hcalc]
          linarith)
      have hqbuffer : (margins q - δ) / speeds q ≤ R q - seed := by
        exact (div_le_iff₀ (hspeed q)).mpr (by
          have hcalc : (((z q : ℝ) + 1 - δ) / speeds q - seed) * speeds q =
              ((z q : ℝ) + 1 - δ) - seed * speeds q := by
            field_simp [(hspeed q).ne']
          rw [hcalc]
          linarith)
      linarith [hpairs p q hpq]
  let midpoint : ℝ := (L p + R q) / 2
  obtain ⟨s, hs, hnewgood⟩ :=
    exists_small_shift_circleNorm_ge (midpoint * newSpeed) β hβ hβhalf
  let time : ℝ := midpoint + s / newSpeed
  have hphase : time * newSpeed = midpoint * newSpeed + s := by
    dsimp [time]
    field_simp [hnew.ne']
  have htimeBand : ∀ i, L i ≤ time ∧ time ≤ R i := by
    intro i
    have hLi : L i ≤ L p := hpmax i (Finset.mem_univ _)
    have hRi : R q ≤ R i := hqmin i (Finset.mem_univ _)
    have hslo : -β ≤ s := by linarith [neg_le_abs s]
    have hshi : s ≤ β := by linarith [le_abs_self s]
    have hwidthMul : 2 * β ≤ (R q - L p) * newSpeed :=
      (div_le_iff₀ hnew).mp hwidth
    have hbuffer : β / newSpeed ≤ (R q - L p) / 2 := by
      apply (div_le_iff₀ hnew).mpr
      nlinarith
    have hshiftlo : -β / newSpeed ≤ s / newSpeed := by
      exact (div_le_div_iff_of_pos_right hnew).mpr hslo
    have hshifthi : s / newSpeed ≤ β / newSpeed := by
      exact (div_le_div_iff_of_pos_right hnew).mpr hshi
    dsimp [time, midpoint]
    constructor <;> nlinarith
  have htimepos : 0 < time := by
    have hznonneg : 0 ≤ (z p : ℝ) := by
      have : (0 : ℝ) ≤ seed * speeds p :=
        mul_nonneg hseedpos.le (hspeed p).le
      have hzint : 0 ≤ z p := Int.floor_nonneg.mpr this
      exact_mod_cast hzint
    have hLpPos : 0 < L p := by
      dsimp [L]
      apply div_pos
      · linarith
      · exact hspeed p
    exact lt_of_lt_of_le hLpPos (htimeBand p).1
  refine ⟨time, htimepos, ?_, ?_⟩
  · rw [hphase]
    exact hnewgood
  · intro i
    have hi := htimeBand i
    exact circleNorm_ge_of_int_band (z i) (time * speeds i) δ (le_of_lt hδ)
      hδhalf.le (by
        exact (div_le_iff₀ (hspeed i)).mp (by simpa [L] using hi.1)) (by
        exact (le_div_iff₀ (hspeed i)).mp (by simpa [R] using hi.2))

end LonelyRunner
