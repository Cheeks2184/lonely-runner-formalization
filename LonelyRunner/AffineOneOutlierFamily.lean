import LonelyRunner.AffineGridArithmetic
import Mathlib.Data.ZMod.Basic
import Mathlib.Tactic.LinearCombination

/-!
# One unrestricted outlier among the small speeds

For every odd `N ≥ 5`, the speeds `2, ..., N-3, v, N, 2*N` have a
closed `1/N` witness for every positive `v`. The three candidate times in
the nondivisible case work over an odd residue ring, without primality.
The two divisible cases retain the original speeds and use explicit times.
-/

namespace LonelyRunner

private theorem outlier_natCast_ne_zero (N a : ℕ)
    (ha : 0 < a) (haN : a < N) : (a : ZMod N) ≠ 0 := by
  intro h
  have hd := (ZMod.natCast_eq_zero_iff a N).mp h
  have := Nat.le_of_dvd ha hd
  omega

private theorem outlier_midpoint_inverse (N : ℕ) (hodd : Odd N) :
    (2 : ZMod N) * ((N + 1) / 2 : ℕ) = 1 := by
  have hn : 2 * ((N + 1) / 2) = N + 1 := by
    have := Nat.odd_iff.mp hodd
    omega
  have hc := congrArg (fun a : ℕ => (a : ZMod N)) hn
  push_cast at hc
  simpa using hc

/-- Three fixed multipliers escape two adjacent residues. The only ring
facts needed are the inverse of two and nonvanishing of three. -/
private theorem outlier_three_residues (N : ℕ) (hN : 5 ≤ N)
    (hodd : Odd N) (x q : ZMod N) (hx : x ≠ 0) :
    (x + q ≠ 0 ∧ x + q ≠ -1) ∨
    (((N + 1) / 2 : ℕ) * x + q ≠ 0 ∧
      ((N + 1) / 2 : ℕ) * x + q ≠ -1) ∨
    (-x + q ≠ 0 ∧ -x + q ≠ -1) := by
  let h : ZMod N := ((N + 1) / 2 : ℕ)
  have hh : 2 * h = 1 := outlier_midpoint_inverse N hodd
  have hthree : (3 : ZMod N) ≠ 0 :=
    outlier_natCast_ne_zero N 3 (by omega) (by omega)
  have hdouble : ∀ y : ZMod N, 2 * y = 0 → y = 0 := by
    intro y hy
    calc
      y = (2 * h) * y := by rw [hh, one_mul]
      _ = h * (2 * y) := by ring
      _ = 0 := by rw [hy, mul_zero]
  have hxmin : x ≠ -x := by
    intro he
    apply hx
    apply hdouble
    linear_combination he
  have hmidx : h * x ≠ x := by
    intro he
    apply hx
    have hs : 2 * (h * x) = x := by rw [← mul_assoc, hh, one_mul]
    linear_combination hs - 2 * he
  by_cases h1 : x + q = 0 ∨ x + q = -1
  · by_cases h2 : h * x + q = 0 ∨ h * x + q = -1
    · by_cases h3 : -x + q = 0 ∨ -x + q = -1
      · have htwo : 2 * x = 1 ∨ 2 * x = -1 := by
          rcases h1 with ha | ha <;> rcases h3 with hb | hb
          · exact (hxmin (by linear_combination ha - hb)).elim
          · left
            linear_combination ha - hb
          · right
            linear_combination ha - hb
          · exact (hxmin (by linear_combination ha - hb)).elim
        have hmidneg : h * x ≠ -x := by
          intro he
          have hs : 2 * (h * x) = x := by rw [← mul_assoc, hh, one_mul]
          have htrip : 3 * x = 0 := by linear_combination 2 * he - hs
          apply hthree
          rcases htwo with ht | ht
          · calc
              (3 : ZMod N) = 3 * (2 * x) := by rw [ht]; ring
              _ = 2 * (3 * x) := by ring
              _ = 0 := by rw [htrip]; ring
          · calc
              (3 : ZMod N) = -(3 * (2 * x)) := by rw [ht]; ring
              _ = -(2 * (3 * x)) := by ring
              _ = 0 := by rw [htrip]; ring
        exfalso
        rcases h1 with ha | ha <;> rcases h2 with hb | hb <;>
          rcases h3 with hc | hc
        all_goals first
          | exact hxmin (by linear_combination ha - hc)
          | exact hmidx (by linear_combination hb - ha)
          | exact hmidneg (by linear_combination hb - hc)
      · right; right
        tauto
    · right; left
      change h * x + q ≠ 0 ∧ h * x + q ≠ -1
      tauto
  · left
    tauto

private theorem outlier_residue_band (N H : ℕ) [NeZero N]
    (hN : 2 ≤ N) (hz : (H : ZMod N) ≠ 0)
    (hn : (H : ZMod N) ≠ -1) :
    1 ≤ H % N ∧ H % N ≤ N - 2 := by
  have hp : 0 < N := by omega
  have hl := Nat.mod_lt H hp
  have hzero : H % N ≠ 0 := by
    intro he
    exact hz ((ZMod.natCast_eq_zero_iff H N).mpr (Nat.dvd_of_mod_eq_zero he))
  have hlast : H % N ≠ N - 1 := by
    intro he
    apply hn
    apply ZMod.val_injective N
    rw [ZMod.val_natCast, he]
    obtain ⟨n, rfl⟩ := Nat.exists_eq_succ_of_ne_zero hp.ne'
    simp [ZMod.val_neg_one]
  omega

private noncomputable def outlierTime (N k : ℕ) : ℝ :=
  (k : ℝ) / N + 1 / (N : ℝ) ^ 2

private theorem outlier_fraction_band (N : ℕ) (hN : 2 ≤ N)
    (z : ℤ) (x : ℝ) (hx : 1 ≤ x) (hxN : x ≤ (N : ℝ) - 1) :
    (N : ℝ)⁻¹ ≤ circleNorm ((z : ℝ) + x / N) := by
  have hNp : (0 : ℝ) < N := by exact_mod_cast (by omega : 0 < N)
  have hNr : (2 : ℝ) ≤ N := by exact_mod_cast hN
  refine circleNorm_ge_of_int_band z _ _ (by positivity) ?_ ?_ ?_
  · rw [inv_eq_one_div]
    exact one_div_le_one_div_of_le (by norm_num) hNr
  · have := (div_le_div_iff_of_pos_right hNp).mpr hx
    simpa only [one_div, add_comm] using add_le_add_left this (z : ℝ)
  · have ht : x / (N : ℝ) ≤ 1 - (N : ℝ)⁻¹ := by
      rw [inv_eq_one_div, le_sub_iff_add_le, ← add_div]
      exact (div_le_one hNp).mpr (by linarith)
    linarith

/-- Separate the possibly large outlier into its quotient and remainder.
This is cyclic transport: the quotient is included before taking the residue. -/
private theorem outlier_good_of_residue (N k v : ℕ) [NeZero N]
    (hN : 2 ≤ N)
    (hz : ((k * v + v / N : ℕ) : ZMod N) ≠ 0)
    (hn : ((k * v + v / N : ℕ) : ZMod N) ≠ -1) :
    (N : ℝ)⁻¹ ≤ circleNorm (outlierTime N k * v) := by
  let H := k * v + v / N
  have hb := outlier_residue_band N H hN hz hn
  have hNp : (0 : ℝ) < N := by exact_mod_cast (by omega : 0 < N)
  have hNne : (N : ℝ) ≠ 0 := hNp.ne'
  have hv : (N : ℝ) * (v / N : ℕ) + (v % N : ℕ) = v := by
    exact_mod_cast Nat.div_add_mod v N
  have hH : (N : ℝ) * (H / N : ℕ) + (H % N : ℕ) =
      (k : ℝ) * v + (v / N : ℕ) := by
    exact_mod_cast Nat.div_add_mod H N
  have hphase : outlierTime N k * v = ((H / N : ℕ) : ℝ) +
      ((H % N : ℕ) + (v % N : ℕ) / (N : ℝ)) / N := by
    dsimp [outlierTime]
    field_simp
    linear_combination -hv - (N : ℝ) * hH
  rw [hphase]
  have hrlo : (1 : ℝ) ≤ (H % N : ℕ) := by exact_mod_cast hb.1
  have hrup : ((H % N : ℕ) : ℝ) + 2 ≤ N := by
    exact_mod_cast (show H % N + 2 ≤ N by omega)
  have hzlt : ((v % N : ℕ) : ℝ) < N := by
    exact_mod_cast Nat.mod_lt v (show 0 < N by omega)
  have hzfrac : ((v % N : ℕ) : ℝ) / N ≤ 1 :=
    (div_le_one hNp).mpr hzlt.le
  apply outlier_fraction_band N hN (H / N : ℕ)
  · have : (0 : ℝ) ≤ ((v % N : ℕ) : ℝ) / N := by positivity
    linarith
  · linarith

private theorem outlier_core_avoidance (N k a : ℕ) (hN : 5 ≤ N)
    (hodd : Odd N) (ha : 2 ≤ a) (haN : a ≤ N - 3)
    (hk : k = 1 ∨ k = (N + 1) / 2 ∨ k = N - 1) :
    ((k * a : ℕ) : ZMod N) ≠ 0 ∧ ((k * a : ℕ) : ZMod N) ≠ -1 := by
  have ha0 : (a : ZMod N) ≠ 0 := outlier_natCast_ne_zero N a (by omega) (by omega)
  have ha1 : ((a + 1 : ℕ) : ZMod N) ≠ 0 :=
    outlier_natCast_ne_zero N (a + 1) (by omega) (by omega)
  have ha2 : ((a + 2 : ℕ) : ZMod N) ≠ 0 :=
    outlier_natCast_ne_zero N (a + 2) (by omega) (by omega)
  have ha_ne_one : (a : ZMod N) ≠ 1 := by
    intro he
    have hv := congrArg ZMod.val he
    rw [ZMod.val_natCast_of_lt (by omega : a < N)] at hv
    have hone : (1 : ZMod N).val = 1 := by
      simpa using (ZMod.val_natCast_of_lt (by omega : 1 < N))
    rw [hone] at hv
    omega
  rcases hk with rfl | rfl | rfl
  · simp only [one_mul]
    refine ⟨ha0, ?_⟩
    intro he
    apply ha1
    push_cast
    rw [he]
    ring
  · have hh := outlier_midpoint_inverse N hodd
    push_cast
    constructor
    · intro he
      apply ha0
      calc
        (a : ZMod N) = (2 * ((N + 1) / 2 : ℕ)) * (a : ZMod N) := by
          rw [hh, one_mul]
        _ = 2 * (((N + 1) / 2 : ℕ) * (a : ZMod N)) := by ring
        _ = 0 := by rw [he]; ring
    · intro he
      apply ha2
      push_cast
      have hs : 2 * (((N + 1) / 2 : ℕ) * (a : ZMod N)) = a := by
        rw [← mul_assoc, hh, one_mul]
      linear_combination 2 * he - hs
  · have hk : ((N - 1 : ℕ) : ZMod N) = -1 := by
      rw [Nat.cast_sub (by omega : 1 ≤ N)]
      simp
    push_cast
    rw [hk]
    simp only [neg_one_mul]
    constructor
    · simpa using ha0
    · intro he
      apply ha_ne_one
      linear_combination -he

private theorem outlier_core_good (N k a : ℕ) [NeZero N]
    (hN : 5 ≤ N) (hodd : Odd N) (ha : 2 ≤ a) (haN : a ≤ N - 3)
    (hk : k = 1 ∨ k = (N + 1) / 2 ∨ k = N - 1) :
    (N : ℝ)⁻¹ ≤ circleNorm (outlierTime N k * a) := by
  have hab := outlier_core_avoidance N k a hN hodd ha haN hk
  apply outlier_good_of_residue N k a (by omega)
  · simpa only [Nat.div_eq_of_lt (by omega : a < N), add_zero] using hab.1
  · simpa only [Nat.div_eq_of_lt (by omega : a < N), add_zero] using hab.2

private theorem outlier_choose_time (N v : ℕ) [NeZero N]
    (hN : 5 ≤ N) (hodd : Odd N) (hv : ¬ N ∣ v) :
    ∃ k : ℕ, (k = 1 ∨ k = (N + 1) / 2 ∨ k = N - 1) ∧
      (N : ℝ)⁻¹ ≤ circleNorm (outlierTime N k * v) := by
  have hx : (v : ZMod N) ≠ 0 := by
    intro he
    exact hv ((ZMod.natCast_eq_zero_iff v N).mp he)
  rcases outlier_three_residues N hN hodd (v : ZMod N) (v / N : ℕ) hx with
    h | h | h
  · refine ⟨1, Or.inl rfl, outlier_good_of_residue N 1 v (by omega) ?_ ?_⟩
    · simpa only [one_mul, Nat.cast_add] using h.1
    · simpa only [one_mul, Nat.cast_add] using h.2
  · refine ⟨(N + 1) / 2, Or.inr (Or.inl rfl),
      outlier_good_of_residue N _ v (by omega) ?_ ?_⟩
    · simpa only [Nat.cast_add, Nat.cast_mul] using h.1
    · simpa only [Nat.cast_add, Nat.cast_mul] using h.2
  · have hk : ((N - 1 : ℕ) : ZMod N) = -1 := by
      rw [Nat.cast_sub (by omega : 1 ≤ N)]
      simp
    refine ⟨N - 1, Or.inr (Or.inr rfl),
      outlier_good_of_residue N _ v (by omega) ?_ ?_⟩
    · simpa only [Nat.cast_add, Nat.cast_mul, hk, neg_one_mul] using h.1
    · simpa only [Nat.cast_add, Nat.cast_mul, hk, neg_one_mul] using h.2

private theorem outlier_zero_rows (N k : ℕ) (hN : 5 ≤ N) :
    (N : ℝ)⁻¹ ≤ circleNorm (outlierTime N k * N) ∧
    (N : ℝ)⁻¹ ≤ circleNorm (outlierTime N k * (2 * N : ℕ)) := by
  have hNp : (0 : ℝ) < N := by exact_mod_cast (by omega : 0 < N)
  have hNne := hNp.ne'
  have hNr : (5 : ℝ) ≤ N := by exact_mod_cast hN
  constructor
  · have hp : outlierTime N k * N = ((k : ℕ) : ℝ) + 1 / N := by
      dsimp [outlierTime]
      field_simp
    rw [hp]
    exact outlier_fraction_band N (by omega) k 1 (by norm_num) (by linarith)
  · have hp : outlierTime N k * (2 * N : ℕ) =
        ((2 * k : ℕ) : ℝ) + 2 / N := by
      dsimp [outlierTime]
      push_cast
      field_simp
    rw [hp]
    exact outlier_fraction_band N (by omega) (2 * k : ℕ) 2
      (by norm_num) (by linarith)

private theorem outlier_divisible_not_square (N v : ℕ) (hN : 5 ≤ N)
    (hd : N ∣ v) (hnd : ¬ N ^ 2 ∣ v) :
    (N : ℝ)⁻¹ ≤ circleNorm (outlierTime N 1 * v) := by
  obtain ⟨d, rfl⟩ := hd
  have hnot : ¬ N ∣ d := by
    rintro ⟨e, he⟩
    apply hnd
    refine ⟨e, ?_⟩
    rw [he]
    ring
  have hmod : d % N ≠ 0 := by
    intro he
    exact hnot (Nat.dvd_of_mod_eq_zero he)
  have hNp : 0 < N := by omega
  have hNreal : (N : ℝ) ≠ 0 := by exact_mod_cast hNp.ne'
  have hp : outlierTime N 1 * (N * d : ℕ) = (d : ℤ) + (d : ℝ) / N := by
    dsimp [outlierTime]
    push_cast
    field_simp
  rw [hp, circleNorm_add_int]
  simpa only [Nat.cast_one, one_div] using
    circleNorm_nat_div_ge hNp (one_le_cyclicResidueDistance_of_mod_ne_zero hNp hmod)

/-- The small positive perturbation is applied to the original speeds.
The extra speed becomes an integer plus `1/N`; no signed-lift transfer is used. -/
private theorem outlier_square_divisible (N v : ℕ) (hN : 5 ≤ N)
    (hv : 0 < v) (hd : N ^ 2 ∣ v) :
    let t := outlierTime N 1 + 1 / ((N : ℝ) * v)
    (N : ℝ)⁻¹ ≤ circleNorm (t * v) ∧
    (N : ℝ)⁻¹ ≤ circleNorm (t * N) ∧
    (N : ℝ)⁻¹ ≤ circleNorm (t * (2 * N : ℕ)) ∧
    ∀ a : ℕ, 2 ≤ a → a ≤ N - 3 →
      (N : ℝ)⁻¹ ≤ circleNorm (t * a) := by
  dsimp only
  obtain ⟨d, hd⟩ := hd
  have hNv : N ≤ v := by
    apply Nat.le_of_dvd hv
    refine ⟨N * d, ?_⟩
    rw [hd]
    ring
  have hNr : (5 : ℝ) ≤ N := by exact_mod_cast hN
  have hNvr : (N : ℝ) ≤ v := by exact_mod_cast hNv
  have hNp : (0 : ℝ) < N := by linarith
  have hNne := hNp.ne'
  have hvp : (0 : ℝ) < v := by exact_mod_cast hv
  have hvne := hvp.ne'
  have hratio : (N : ℝ) / v ≤ 1 := (div_le_one hvp).mpr hNvr
  have hratio0 : (0 : ℝ) ≤ (N : ℝ) / v := by positivity
  have hphase : (outlierTime N 1 + 1 / ((N : ℝ) * v)) * v =
      ((d * (N + 1) : ℕ) : ℝ) + 1 / N := by
    dsimp [outlierTime]
    push_cast
    field_simp
    have hdreal : (v : ℝ) = (N : ℝ) ^ 2 * d := by exact_mod_cast hd
    rw [hdreal]
    ring
  refine ⟨?_, ?_, ?_, ?_⟩
  · rw [hphase]
    exact outlier_fraction_band N (by omega) (d * (N + 1) : ℕ) 1
      (by norm_num) (by linarith)
  · have hp : (outlierTime N 1 + 1 / ((N : ℝ) * v)) * N =
        (1 : ℤ) + (1 + (N : ℝ) / v) / N := by
      dsimp [outlierTime]
      push_cast
      field_simp
      ring
    rw [hp]
    exact outlier_fraction_band N (by omega) 1 _ (by linarith) (by linarith)
  · have hp : (outlierTime N 1 + 1 / ((N : ℝ) * v)) * (2 * N : ℕ) =
        (2 : ℤ) + (2 + 2 * ((N : ℝ) / v)) / N := by
      dsimp [outlierTime]
      push_cast
      field_simp
      ring
    rw [hp]
    exact outlier_fraction_band N (by omega) 2 _ (by linarith) (by linarith)
  · intro a ha haN
    have har : (2 : ℝ) ≤ a := by exact_mod_cast ha
    have haNr : (a : ℝ) + 3 ≤ N := by
      exact_mod_cast (show a + 3 ≤ N by omega)
    have hdivN : (a : ℝ) / N ≤ 1 := (div_le_one hNp).mpr (by linarith)
    have hdivv : (a : ℝ) / v ≤ 1 := (div_le_one hvp).mpr (by linarith)
    have hdivN0 : (0 : ℝ) ≤ (a : ℝ) / N := by positivity
    have hdivv0 : (0 : ℝ) ≤ (a : ℝ) / v := by positivity
    have hp : (outlierTime N 1 + 1 / ((N : ℝ) * v)) * a =
        (0 : ℤ) + ((a : ℝ) + (a : ℝ) / N + (a : ℝ) / v) / N := by
      dsimp [outlierTime]
      push_cast
      field_simp
      ring
    rw [hp]
    exact outlier_fraction_band N (by omega) 0 _ (by linarith) (by linarith)

/-- Every odd runner count at least five admits the full one-outlier family.
There is no primality, height, distinctness, or divisibility restriction on
the positive outlier. All displayed speeds share the closed `1/N` bound. -/
theorem affine_one_outlier_family_witness_nat (N v : ℕ)
    (hN : 5 ≤ N) (hodd : Odd N) (hv : 0 < v) :
    ∃ t : ℝ,
      (N : ℝ)⁻¹ ≤ circleNorm (t * v) ∧
      (N : ℝ)⁻¹ ≤ circleNorm (t * N) ∧
      (N : ℝ)⁻¹ ≤ circleNorm (t * (2 * N : ℕ)) ∧
      ∀ a : ℕ, 2 ≤ a → a ≤ N - 3 →
        (N : ℝ)⁻¹ ≤ circleNorm (t * a) := by
  letI : NeZero N := ⟨by omega⟩
  by_cases hd : N ∣ v
  · by_cases hsq : N ^ 2 ∣ v
    · exact ⟨_, outlier_square_divisible N v hN hv hsq⟩
    · obtain ⟨hzero, htwo⟩ := outlier_zero_rows N 1 hN
      refine ⟨outlierTime N 1, outlier_divisible_not_square N v hN hd hsq,
        hzero, htwo, ?_⟩
      intro a ha haN
      exact outlier_core_good N 1 a hN hodd ha haN (Or.inl rfl)
  · obtain ⟨k, hk, hgood⟩ := outlier_choose_time N v hN hodd hd
    obtain ⟨hzero, htwo⟩ := outlier_zero_rows N k hN
    refine ⟨outlierTime N k, hgood, hzero, htwo, ?_⟩
    intro a ha haN
    exact outlier_core_good N k a hN hodd ha haN hk

/-- Integer-indexed version retaining every speed in `[2, N-3]`, the
unrestricted positive outlier, and the actual speeds `N` and `2*N`. -/
theorem affine_one_outlier_family_witness (N v : ℕ)
    (hN : 5 ≤ N) (hodd : Odd N) (hv : 0 < v) :
    ∃ t : ℝ,
      (N : ℝ)⁻¹ ≤ circleNorm (t * v) ∧
      (N : ℝ)⁻¹ ≤ circleNorm (t * N) ∧
      (N : ℝ)⁻¹ ≤ circleNorm (t * (2 * N : ℕ)) ∧
      ∀ a : ℤ, 2 ≤ a → a ≤ (N : ℤ) - 3 →
        (N : ℝ)⁻¹ ≤ circleNorm (t * a) := by
  obtain ⟨t, hv, hzero, htwo, hcore⟩ :=
    affine_one_outlier_family_witness_nat N v hN hodd hv
  refine ⟨t, hv, hzero, htwo, ?_⟩
  intro a ha haN
  have ha0 : 0 ≤ a := by omega
  have han : 2 ≤ a.toNat := by omega
  have hanN : a.toNat ≤ N - 3 := by omega
  have hc := hcore a.toNat han hanN
  have haeq : ((a.toNat : ℕ) : ℝ) = (a : ℝ) := by
    exact_mod_cast Int.toNat_of_nonneg ha0
  simpa only [haeq] using hc

end LonelyRunner
