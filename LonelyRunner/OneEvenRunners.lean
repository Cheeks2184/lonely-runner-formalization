import LonelyRunner.OneSixthComplementMaximizer
import LonelyRunner.SignedRenaultFiveOne
import LonelyRunner.SixthAffinePhase

/-!
# The one-even branch for five moving speeds

This module is pointwise: repeated positive speeds are allowed.  It uses the
oriented complement maximizer to turn a common signed Renault phase choice
into a contradiction, then reflects an all-real witness to positive time.
-/

namespace LonelyRunner

private theorem exists_unit_sixth_residue (d : ℕ)
    (hodd : ¬ 2 ∣ d) (hthree : ¬ 3 ∣ d) :
    ∃ z e : ℤ, (d : ℤ) = 6 * z + e ∧ (e = 1 ∨ e = -1) := by
  obtain ⟨z, e, hd, he⟩ := exists_centered_sixth_residue_of_not_dvd_three d hthree
  rcases he with he | he | he | he
  · exact ⟨z, e, hd, Or.inl he⟩
  · exact ⟨z, e, hd, Or.inr he⟩
  · exfalso
    apply hodd
    have hdiv : (2 : ℤ) ∣ (d : ℤ) := by
      refine ⟨3 * z + 1, ?_⟩
      linarith [hd, he]
    exact_mod_cast hdiv
  · exfalso
    apply hodd
    have hdiv : (2 : ℤ) ∣ (d : ℤ) := by
      refine ⟨3 * z - 1, ?_⟩
      linarith [hd, he]
    exact_mod_cast hdiv

private theorem circleNorm_sixth_affine_time (t : ℝ) (d : ℕ)
    (α β z e : ℤ) (hd : (d : ℤ) = 6 * z + e) :
    circleNorm (((α : ℝ) * t + (β : ℝ) / 6) * (d : ℝ)) =
      circleNorm ((α : ℝ) * Int.fract (t * (d : ℝ)) +
        ((β * e : ℤ) : ℝ) / 6) := by
  rw [circleNorm_eq_min_fract, circleNorm_eq_min_fract,
    fract_sixth_affine_time t d α β z e hd]

private theorem fract_add_sixth_of_dvd (d : ℕ) (hd : 6 ∣ d)
    (t : ℝ) (b : ℤ) :
    Int.fract ((t + (b : ℝ) / 6) * (d : ℝ)) =
      Int.fract (t * (d : ℝ)) := by
  obtain ⟨u, hu⟩ := hd
  have hdu : (d : ℤ) = 6 * (u : ℤ) + 0 := by
    exact_mod_cast hu
  simpa using fract_sixth_affine_time t d 1 b (u : ℤ) 0 hdu

private theorem circleNorm_add_sixth_of_dvd (d : ℕ) (hd : 6 ∣ d)
    (t : ℝ) (b : ℤ) :
    circleNorm ((t + (b : ℝ) / 6) * (d : ℝ)) =
      circleNorm (t * (d : ℝ)) := by
  rw [circleNorm_eq_min_fract, circleNorm_eq_min_fract,
    fract_add_sixth_of_dvd d hd t b]

private theorem closed_signed_sixth_safe (σ : ℤ) (b : ℕ)
    (hσ : σ = 1 ∨ σ = -1) (hb1 : 1 ≤ b) (hb5 : b ≤ 5) :
    (1 : ℝ) / 6 ≤ circleNorm ((σ : ℝ) * (b : ℝ) / 6) := by
  rcases hσ with hσ | hσ
  · rw [hσ]
    norm_num
    apply circleNorm_ge_of_int_band 0 ((b : ℝ) / 6) ((1 : ℝ) / 6)
    · norm_num
    · norm_num
    · have hb1R : (1 : ℝ) ≤ (b : ℝ) := by exact_mod_cast hb1
      nlinarith
    · have hb5R : (b : ℝ) ≤ 5 := by exact_mod_cast hb5
      nlinarith
  · rw [hσ, show ((-1 : ℤ) : ℝ) * (b : ℝ) / 6 = -((b : ℝ) / 6) by ring,
      circleNorm_neg]
    apply circleNorm_ge_of_int_band 0 ((b : ℝ) / 6) ((1 : ℝ) / 6)
    · norm_num
    · norm_num
    · have hb1R : (1 : ℝ) ≤ (b : ℝ) := by exact_mod_cast hb1
      nlinarith
    · have hb5R : (b : ℝ) ≤ 5 := by exact_mod_cast hb5
      nlinarith

private theorem strict_signed_sixth_band (σ : ℤ) (b : ℕ)
    (hchoice : (σ = 1 ∧ (b = 1 ∨ b = 2 ∨ b = 4)) ∨
      (σ = -1 ∧ (b = 2 ∨ b = 4 ∨ b = 5))) :
    (1 : ℝ) / 6 ≤ Int.fract ((σ : ℝ) * (b : ℝ) / 6) ∧
      Int.fract ((σ : ℝ) * (b : ℝ) / 6) < (5 : ℝ) / 6 := by
  rcases hchoice with ⟨rfl, rfl | rfl | rfl⟩ | ⟨rfl, rfl | rfl | rfl⟩ <;>
    norm_num [Int.fract]

private theorem rho_ne_p (p : Fin 5) (q : Fin 4) (j : Fin 3) :
    p.succAbove (q.succAbove j) ≠ p :=
  Fin.succAbove_ne p _

private theorem rho_ne_r (p : Fin 5) (q : Fin 4) (j : Fin 3)
    (r : Fin 5) (hq : p.succAbove q = r) :
    p.succAbove (q.succAbove j) ≠ r := by
  rw [← hq]
  intro h
  apply Fin.succAbove_ne q j
  exact Fin.succAbove_right_injective h

private theorem rho_exhausts (p : Fin 5) (q : Fin 4) (r : Fin 5)
    (hq : p.succAbove q = r) (i : Fin 5)
    (hip : i ≠ p) (hir : i ≠ r) :
    ∃ j : Fin 3, p.succAbove (q.succAbove j) = i := by
  obtain ⟨u, hu⟩ := Fin.exists_succAbove_eq hip
  have huq : u ≠ q := by
    intro h
    apply hir
    rw [← hq, ← h]
    exact hu.symm
  obtain ⟨j, hj⟩ := Fin.exists_succAbove_eq huq
  refine ⟨j, ?_⟩
  rw [hj]
  exact hu

private theorem one_even_all_real_false
    (v : Fin 5 → ℕ) (hpos : ∀ i, 0 < v i) (p : Fin 5)
    (hsix : 6 ∣ v p)
    (hodd : ∀ i, i ≠ p → ¬ 2 ∣ v i)
    (hthree : ∀ i, i ≠ p → ¬ 3 ∣ v i)
    (hno : ¬ ∃ t : ℝ, ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ))) : False := by
  obtain ⟨τ, hτ0, hτ1, hsafe, hmax, hmpos, hmlt, hmnorm,
    r, hrp, hrface⟩ := exists_one_sixth_complement_maximizer v hpos p hno
  obtain ⟨q, hq⟩ := Fin.exists_succAbove_eq hrp
  let ρ : Fin 3 → Fin 5 := fun j => p.succAbove (q.succAbove j)
  have hρp : ∀ j, ρ j ≠ p := by
    intro j
    exact rho_ne_p p q j
  have hρr : ∀ j, ρ j ≠ r := by
    intro j
    exact rho_ne_r p q j r hq
  have hρexhaust : ∀ i, i ≠ p → i ≠ r → ∃ j, ρ j = i := by
    intro i hip hir
    exact rho_exhausts p q r hq i hip hir
  obtain ⟨zr, σ, hdr, hσ⟩ :=
    exists_unit_sixth_residue (v r) (hodd r hrp) (hthree r hrp)
  have hρres : ∀ j, ∃ z e : ℤ,
      (v (ρ j) : ℤ) = 6 * z + e ∧ (e = 1 ∨ e = -1) := by
    intro j
    exact exists_unit_sixth_residue (v (ρ j)) (hodd _ (hρp j))
      (hthree _ (hρp j))
  choose z e hd he using hρres
  let t' : ℝ := τ + (σ : ℝ) / 6
  let x : Fin 3 → ℝ := fun j => Int.fract (t' * (v (ρ j) : ℝ))
  have ht'p : Int.fract (t' * (v p : ℝ)) =
      Int.fract (τ * (v p : ℝ)) := by
    simpa [t'] using fract_add_sixth_of_dvd (v p) hsix τ σ
  have hsquare : σ * σ = 1 := by
    rcases hσ with hσ | hσ <;> subst σ <;> norm_num
  have ht'r : Int.fract (t' * (v r : ℝ)) = 0 := by
    have h := fract_sixth_affine_time τ (v r) 1 σ zr σ hdr
    rw [hrface, hsquare] at h
    norm_num at h ⊢
    simpa [t'] using h
  have hchoice :
      (∃ a b : ℕ, 2 ≤ a ∧ a ≤ 5 ∧ 1 ≤ b ∧ b ≤ 5 ∧ ∀ j,
        (1 : ℝ) / 6 ≤ circleNorm ((a : ℝ) * x j +
          (e j : ℝ) * (b : ℝ) / 6)) ∨
      (∃ b : ℕ,
        ((σ = 1 ∧ (b = 1 ∨ b = 2 ∨ b = 4)) ∨
          (σ = -1 ∧ (b = 2 ∨ b = 4 ∨ b = 5))) ∧ ∀ j,
        (1 : ℝ) / 6 < circleNorm (x j +
          (e j : ℝ) * (b : ℝ) / 6)) := by
    rcases hσ with hσ | hσ
    · subst σ
      rcases renault_phase_five_one_signed x e he with h | h
      · exact Or.inl h
      · rcases h with ⟨b, hb, hgood⟩
        exact Or.inr ⟨b, Or.inl ⟨rfl, hb⟩, hgood⟩
    · subst σ
      rcases renault_phase_five_one_signed_reflected x e he with h | h
      · exact Or.inl h
      · rcases h with ⟨b, hb, hgood⟩
        exact Or.inr ⟨b, Or.inr ⟨rfl, hb⟩, hgood⟩
  rcases hchoice with hclosed | hstrict
  · rcases hclosed with ⟨a, b, ha2, ha5, hb1, hb5, hgood⟩
    let s : ℝ := (a : ℝ) * t' + (b : ℝ) / 6
    have hρphase : ∀ j, circleNorm (s * (v (ρ j) : ℝ)) =
        circleNorm ((a : ℝ) * x j + (e j : ℝ) * (b : ℝ) / 6) := by
      intro j
      have h := circleNorm_sixth_affine_time t' (v (ρ j)) (a : ℤ) (b : ℤ)
        (z j) (e j) (hd j)
      simpa [s, x, mul_comm, mul_left_comm, mul_assoc] using h
    have hrphase : Int.fract (s * (v r : ℝ)) =
        Int.fract ((σ : ℝ) * (b : ℝ) / 6) := by
      have h := fract_sixth_affine_time t' (v r) (a : ℤ) (b : ℤ) zr σ hdr
      rw [ht'r] at h
      simpa [s, mul_comm, mul_left_comm, mul_assoc] using h
    have hrnorm : circleNorm (s * (v r : ℝ)) =
        circleNorm ((σ : ℝ) * (b : ℝ) / 6) := by
      rw [circleNorm_eq_min_fract, circleNorm_eq_min_fract, hrphase]
    have hsafe' : ComplementSafe v p ((1 : ℝ) / 6) s := by
      intro i hip
      by_cases hir : i = r
      · subst i
        rw [hrnorm]
        exact closed_signed_sixth_safe σ b hσ hb1 hb5
      · obtain ⟨j, hj⟩ := hρexhaust i hip hir
        rw [← hj, hρphase]
        exact hgood j
    let B : ℤ := (a : ℤ) * σ + (b : ℤ)
    have hsform : s = (a : ℝ) * τ + (B : ℝ) / 6 := by
      dsimp [s, t', B]
      push_cast
      ring
    have hmlt' : Int.fract (τ * (v p : ℝ)) < (6 : ℝ)⁻¹ := by
      norm_num
      exact hmlt
    have himprove := reciprocal_dilate_shift_improves 6 (v p) a B τ
      (by omega) hsix ha2 (by omega) hmpos hmlt'
    have himprove' : circleNorm (τ * (v p : ℝ)) <
        circleNorm (s * (v p : ℝ)) := by
      simpa [hsform] using himprove
    exact (not_lt_of_ge (hmax s hsafe')) himprove'
  · rcases hstrict with ⟨b, htype, hgood⟩
    let s : ℝ := t' + (b : ℝ) / 6
    have hρphase : ∀ j, circleNorm (s * (v (ρ j) : ℝ)) =
        circleNorm (x j + (e j : ℝ) * (b : ℝ) / 6) := by
      intro j
      have h := circleNorm_sixth_affine_time t' (v (ρ j)) 1 (b : ℤ)
        (z j) (e j) (hd j)
      simpa [s, x, mul_comm, mul_left_comm, mul_assoc] using h
    have hrphase : Int.fract (s * (v r : ℝ)) =
        Int.fract ((σ : ℝ) * (b : ℝ) / 6) := by
      have h := fract_sixth_affine_time t' (v r) 1 (b : ℤ) zr σ hdr
      rw [ht'r] at h
      simpa [s, mul_comm, mul_left_comm, mul_assoc] using h
    have hbands : ∀ i, i ≠ p →
        (1 : ℝ) / 6 ≤ Int.fract (s * (v i : ℝ)) ∧
          Int.fract (s * (v i : ℝ)) < 1 - (1 : ℝ) / 6 := by
      intro i hip
      by_cases hir : i = r
      · subst i
        rw [hrphase]
        obtain ⟨hlo, hhi⟩ := strict_signed_sixth_band σ b htype
        exact ⟨hlo, by linarith⟩
      · obtain ⟨j, hj⟩ := hρexhaust i hip hir
        subst i
        have hnorm : (1 : ℝ) / 6 < circleNorm (s * (v (ρ j) : ℝ)) := by
          rw [hρphase]
          exact hgood j
        rw [circleNorm_eq_min_fract, lt_min_iff] at hnorm
        exact ⟨hnorm.1.le, by linarith [hnorm.2]⟩
    have hspfract : Int.fract (s * (v p : ℝ)) =
        Int.fract (τ * (v p : ℝ)) := by
      calc
        Int.fract (s * (v p : ℝ)) = Int.fract (t' * (v p : ℝ)) := by
          simpa [s] using fract_add_sixth_of_dvd (v p) hsix t' (b : ℤ)
        _ = Int.fract (τ * (v p : ℝ)) := ht'p
    have hspnorm : circleNorm (s * (v p : ℝ)) =
        circleNorm (τ * (v p : ℝ)) := by
      rw [circleNorm_eq_min_fract, hspfract, min_eq_left]
      · exact hmnorm
      · linarith [hmlt]
    obtain ⟨ε, hε, hsafe', himprove⟩ := exists_forward_complement_improvement v p hpos
      ((1 : ℝ) / 6) s (by norm_num) (by norm_num)
      (by rw [hspfract]; linarith [hmlt]) hbands
    rw [hspnorm] at himprove
    exact (not_lt_of_ge (hmax (s + ε) hsafe')) himprove

/-- The one-even residue branch supplies a positive common sixth-margin time
for five positive labelled speeds, without a distinctness or gcd premise. -/
theorem fiveMovingNaturalRunners_of_one_even_residues
    (v : Fin 5 → ℕ) (hpos : ∀ i, 0 < v i) (p : Fin 5)
    (hsix : 6 ∣ v p)
    (hodd : ∀ i, i ≠ p → ¬ 2 ∣ v i)
    (hthree : ∀ i, i ≠ p → ¬ 3 ∣ v i) :
    ∃ t : ℝ, 0 < t ∧ ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ)) := by
  have hall : ∃ t : ℝ, ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ)) := by
    by_contra hno
    exact one_even_all_real_false v hpos p hsix hodd hthree hno
  obtain ⟨u, hallbounds⟩ := hall
  have hune : u ≠ 0 := by
    intro hu0
    have hp := hallbounds p
    rw [hu0] at hp
    norm_num [circleNorm] at hp
  rcases lt_or_gt_of_ne hune with huneg | hupos
  · refine ⟨-u, neg_pos.mpr huneg, ?_⟩
    intro i
    rw [show (-u) * (v i : ℝ) = -(u * (v i : ℝ)) by ring, circleNorm_neg]
    exact hallbounds i
  · exact ⟨u, hupos, hallbounds⟩

/-- A unique even label together with a unique three-divisible label is the
one-even residue branch. -/
theorem one_three_divisible_one_even_witness
    (v : Fin 5 → ℕ) (hpos : ∀ i, 0 < v i) (p : Fin 5)
    (hsix : 6 ∣ v p) (hone : ∀ i, 3 ∣ v i ↔ i = p)
    (heven : ((Finset.univ : Finset (Fin 5)).filter
      (fun i => 2 ∣ v i)).card = 1) :
    ∃ t : ℝ, 0 < t ∧ ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ)) := by
  have hp2 : 2 ∣ v p := dvd_trans (by norm_num) hsix
  have hp_mem : p ∈ (Finset.univ : Finset (Fin 5)).filter (fun i => 2 ∣ v i) := by
    simp [hp2]
  have hcard : ((Finset.univ : Finset (Fin 5)).filter (fun i => 2 ∣ v i)).card ≤ 1 := by
    omega
  apply fiveMovingNaturalRunners_of_one_even_residues v hpos p hsix
  · intro i hip hdiv
    have hi_mem : i ∈ (Finset.univ : Finset (Fin 5)).filter (fun j => 2 ∣ v j) := by
      simp [hdiv]
    have heq := (Finset.card_le_one.mp hcard) i hi_mem p hp_mem
    exact hip heq
  · intro i hip hdiv
    exact hip ((hone i).mp hdiv)

end LonelyRunner
