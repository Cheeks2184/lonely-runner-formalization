import LonelyRunner.RationalShiftGcd
import Mathlib.Tactic

/-!
# Prescribed small phases in reduced rational orbits

The coprime orbit realizes every residue modulo its denominator.  Reducing a
rational phase by its gcd then supplies either the exact fifth phase or a
phase in the closed twelfth-to-sixth band.
-/

namespace LonelyRunner

/-- A coprime rational orbit realizes each natural residue in its standard
range. -/
theorem exists_nat_coprime_grid_fract_eq
    (c n m : ℕ) (hn : 0 < n) (hc : Nat.Coprime c n) (hm : m < n) :
    ∃ k : ℕ, k < n ∧
      Int.fract ((k : ℝ) * (c : ℝ) / (n : ℝ)) = (m : ℝ) / (n : ℝ) := by
  obtain ⟨k, hk, hres⟩ :=
    Nat.exists_mul_mod_eq_of_coprime m hc hn.ne'
  have hres' : (k * c) % n = m := by
    calc
      (k * c) % n = (c * k) % n := by rw [Nat.mul_comm]
      _ = m % n := hres
      _ = m := Nat.mod_eq_of_lt hm
  refine ⟨k, hk, ?_⟩
  calc
    Int.fract ((k : ℝ) * (c : ℝ) / (n : ℝ)) =
        Int.fract (((k * c : ℕ) : ℝ) / (n : ℝ)) := by
          simp only [Nat.cast_mul]
    _ = (m : ℝ) / (n : ℝ) := by
      rw [Int.fract_div_natCast_eq_div_natCast_mod, hres']

/-- The ceiling of `n / 12`, encoded in naturals, lies in the target band for
every reduced denominator at least seven. -/
private theorem small_phase_numerator_bounds (n : ℕ) (hn : 7 ≤ n) :
    let m : ℕ := (n + 11) / 12
    0 < m ∧ m < n ∧ n ≤ 12 * m ∧ 6 * m ≤ n := by
  dsimp
  let r : ℕ := (n + 11) % 12
  have hrlt : r < 12 := by
    dsimp [r]
    exact Nat.mod_lt _ (by decide)
  have hsplit := Nat.mod_add_div (n + 11) 12
  change r + 12 * ((n + 11) / 12) = n + 11 at hsplit
  have hlow : n ≤ 12 * ((n + 11) / 12) := by omega
  have hpos : 0 < (n + 11) / 12 := by omega
  have hupp : 6 * ((n + 11) / 12) ≤ n := by
    by_cases hsmall : n < 12
    · have hmone : (n + 11) / 12 = 1 := by omega
      omega
    · omega
  constructor
  · exact hpos
  constructor
  · omega
  exact ⟨hlow, hupp⟩

/-- A non-integral rational phase with denominator coprime to six has a
reciprocal-time translate in the closed small-phase band, except for the
exact fifth-denominator orbit. -/
theorem exists_reciprocal_time_small_phase
    (A q : ℕ) (hq : 0 < q) (hcop : Nat.Coprime q 6)
    (hnot : ¬ q ∣ A) :
    ∃ k : ℕ, k < q ∧
      (((1 : ℝ) / 12 ≤ Int.fract ((k : ℝ) * (A : ℝ) / (q : ℝ)) ∧
        Int.fract ((k : ℝ) * (A : ℝ) / (q : ℝ)) ≤ (1 : ℝ) / 6) ∨
       Int.fract ((k : ℝ) * (A : ℝ) / (q : ℝ)) = (1 : ℝ) / 5) := by
  let g : ℕ := Nat.gcd q A
  let n : ℕ := q / g
  let c : ℕ := A / g
  have hg : 0 < g := by
    dsimp [g]
    exact Nat.gcd_pos_of_pos_left A hq
  have hgq : g ∣ q := by
    dsimp [g]
    exact Nat.gcd_dvd_left q A
  have hgA : g ∣ A := by
    dsimp [g]
    exact Nat.gcd_dvd_right q A
  have hqeq : q = g * n := by
    dsimp [n]
    exact (Nat.mul_div_cancel' hgq).symm
  have hAeq : A = g * c := by
    dsimp [c]
    exact (Nat.mul_div_cancel' hgA).symm
  have hnpos : 0 < n := by
    dsimp [n]
    exact Nat.div_pos (Nat.le_of_dvd hq hgq) hg
  have hnle : n ≤ q := by
    dsimp [n]
    exact Nat.div_le_self q g
  have hnone : n ≠ 1 := by
    intro hnone
    apply hnot
    rw [hqeq, hnone]
    simpa using hgA
  have hntwo : 1 < n := by omega
  have hcn : Nat.Coprime c n := by
    simpa [c, n, g] using (Nat.coprime_div_gcd_div_gcd hg).symm
  have hndvd : n ∣ q := by
    refine ⟨g, ?_⟩
    rw [hqeq, Nat.mul_comm]
  have hn6 : Nat.Coprime n 6 := Nat.Coprime.of_dvd_left hndvd hcop
  have hnot2 : ¬ 2 ∣ n := by
    intro htwo
    exact (Nat.not_coprime_of_dvd_of_dvd (by decide) htwo (by norm_num)) hn6
  have hnot3 : ¬ 3 ∣ n := by
    intro hthree
    exact (Nat.not_coprime_of_dvd_of_dvd (by decide) hthree (by norm_num)) hn6
  have hfive_or_large : n = 5 ∨ 7 ≤ n := by
    by_cases hlarge : 7 ≤ n
    · exact Or.inr hlarge
    · have hnle6 : n ≤ 6 := by omega
      have hmod2 : n % 2 ≠ 0 := by
        simpa [Nat.dvd_iff_mod_eq_zero] using hnot2
      have hmod3 : n % 3 ≠ 0 := by
        simpa [Nat.dvd_iff_mod_eq_zero] using hnot3
      omega
  have hgR : (g : ℝ) ≠ 0 := by exact_mod_cast hg.ne'
  have hphase : (A : ℝ) / (q : ℝ) = (c : ℝ) / (n : ℝ) := by
    rw [hAeq, hqeq]
    push_cast
    field_simp [hgR]
  rcases hfive_or_large with hfive | hlarge
  · have hcn5 : Nat.Coprime c 5 := by
      rw [← hfive]
      exact hcn
    have hnle5 : 5 ≤ q := by
      rw [← hfive]
      exact hnle
    obtain ⟨k, hk, hkphase⟩ :=
      exists_nat_coprime_grid_fract_eq c 5 1 (by decide) hcn5 (by decide)
    refine ⟨k, hk.trans_le hnle5, Or.inr ?_⟩
    have hphasek :
        (k : ℝ) * (A : ℝ) / (q : ℝ) = (k : ℝ) * (c : ℝ) / (n : ℝ) := by
      rw [mul_div_assoc, hphase, ← mul_div_assoc]
    rw [hfive] at hphasek
    norm_num at hphasek hkphase
    calc
      Int.fract ((k : ℝ) * (A : ℝ) / (q : ℝ)) =
          Int.fract ((k : ℝ) * (c : ℝ) / (5 : ℝ)) := congrArg Int.fract hphasek
      _ = (1 : ℝ) / 5 := hkphase
  · let m : ℕ := (n + 11) / 12
    obtain ⟨hmpos, hmlt, hnlow, hmupp⟩ := small_phase_numerator_bounds n hlarge
    obtain ⟨k, hk, hkphase⟩ := exists_nat_coprime_grid_fract_eq c n m hnpos hcn hmlt
    refine ⟨k, hk.trans_le hnle, Or.inl ?_⟩
    have hnR : 0 < (n : ℝ) := by exact_mod_cast hnpos
    have hnlowR : (n : ℝ) ≤ 12 * (m : ℝ) := by exact_mod_cast hnlow
    have hmuppR : 6 * (m : ℝ) ≤ (n : ℝ) := by exact_mod_cast hmupp
    have hphasek :
        (k : ℝ) * (A : ℝ) / (q : ℝ) = (k : ℝ) * (c : ℝ) / (n : ℝ) := by
      rw [mul_div_assoc, hphase, ← mul_div_assoc]
    rw [hphasek, hkphase]
    constructor
    · apply (div_le_div_iff₀ (by norm_num) hnR).2
      nlinarith
    · apply (div_le_div_iff₀ hnR (by norm_num)).2
      nlinarith

end LonelyRunner
