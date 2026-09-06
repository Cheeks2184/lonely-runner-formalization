import LonelyRunner.OneSixthComplementMaximizer
import LonelyRunner.SignedRemainingPhase
import LonelyRunner.SixthAffinePhase
import LonelyRunner.SmallDenominatorWitness
import LonelyRunner.ThreeEvenOrbit
import Mathlib.Tactic

/-!
# The two-even branch for five moving speeds

The fixed roles are pivot `0`, other even label `1`, and odd labels `2,3,4`.
All phase choices are shared times; speed values themselves need not be distinct.
-/

namespace LonelyRunner

private theorem two_even_norm_affine (t : ℝ) (d : ℕ)
    (α β z e : ℤ) (hd : (d : ℤ) = 6 * z + e) :
    circleNorm (((α : ℝ) * t + (β : ℝ) / 6) * (d : ℝ)) =
      circleNorm ((α : ℝ) * Int.fract (t * (d : ℝ)) +
        ((β * e : ℤ) : ℝ) / 6) := by
  rw [circleNorm_eq_min_fract, circleNorm_eq_min_fract,
    fract_sixth_affine_time t d α β z e hd]

private theorem two_even_fract_shift (d : ℕ) (hd : 6 ∣ d)
    (t : ℝ) (b : ℤ) :
    Int.fract ((t + (b : ℝ) / 6) * (d : ℝ)) =
      Int.fract (t * (d : ℝ)) := by
  obtain ⟨u, hu⟩ := hd
  have hdu : (d : ℤ) = 6 * (u : ℤ) + 0 := by exact_mod_cast hu
  simpa using fract_sixth_affine_time t d 1 b (u : ℤ) 0 hdu

private theorem two_even_odd_face_closed (σ : ℤ) (b : ℕ)
    (hσ : σ = 1 ∨ σ = -1) (hb1 : 1 ≤ b) (hb5 : b ≤ 5) :
    (1 : ℝ) / 6 ≤ circleNorm ((σ : ℝ) * (b : ℝ) / 6) := by
  rcases hσ with rfl | rfl
  · rw [show ((1 : ℤ) : ℝ) * (b : ℝ) / 6 = (b : ℝ) / 6 by ring]
    apply circleNorm_ge_of_int_band 0 ((b : ℝ) / 6) ((1 : ℝ) / 6) <;>
      norm_num at * <;> nlinarith [show (1 : ℝ) ≤ b by exact_mod_cast hb1,
        show (b : ℝ) ≤ 5 by exact_mod_cast hb5]
  · rw [show ((-1 : ℤ) : ℝ) * (b : ℝ) / 6 = -((b : ℝ) / 6) by ring,
      circleNorm_neg]
    apply circleNorm_ge_of_int_band 0 ((b : ℝ) / 6) ((1 : ℝ) / 6) <;>
      norm_num at * <;> nlinarith [show (1 : ℝ) ≤ b by exact_mod_cast hb1,
        show (b : ℝ) ≤ 5 by exact_mod_cast hb5]

private theorem two_even_odd_face_forward (σ : ℤ) (b : ℕ)
    (hchoice : (σ = 1 ∧ 1 ≤ b ∧ b ≤ 4) ∨
      (σ = -1 ∧ 2 ≤ b ∧ b ≤ 5)) :
    (1 : ℝ) / 6 ≤ Int.fract ((σ : ℝ) * (b : ℝ) / 6) ∧
      Int.fract ((σ : ℝ) * (b : ℝ) / 6) < (5 : ℝ) / 6 := by
  rcases hchoice with ⟨rfl, hb1, hb4⟩ | ⟨rfl, hb2, hb5⟩ <;>
    interval_cases b <;> norm_num [Int.fract] at *

private theorem two_even_face_double :
    Int.fract ((5 : ℝ) * 2 / 6) = (2 : ℝ) / 3 := by norm_num [Int.fract]

private theorem two_even_face_forward (σ : ℤ) (b : ℕ)
    (hσ : σ = 1 ∨ σ = -1) (hb : b = 1 ∨ b = 5) :
    (1 : ℝ) / 6 ≤ Int.fract ((5 + 2 * (σ : ℝ) * (b : ℝ)) / 6) ∧
      Int.fract ((5 + 2 * (σ : ℝ) * (b : ℝ)) / 6) < (5 : ℝ) / 6 := by
  rcases hσ with rfl | rfl <;> rcases hb with rfl | rfl <;>
    norm_num [Int.fract]

private theorem two_even_face_closed (σ : ℤ) (a b : ℕ)
    (hσ : σ = 1 ∨ σ = -1) (ha : a = 3 ∨ a = 5) (hb : b ≤ 5) :
    (1 : ℝ) / 6 ≤ Int.fract ((5 * (a : ℝ) + 2 * (σ : ℝ) * (b : ℝ)) / 6) ∧
      Int.fract ((5 * (a : ℝ) + 2 * (σ : ℝ) * (b : ℝ)) / 6) ≤
        (5 : ℝ) / 6 := by
  rcases hσ with rfl | rfl <;> rcases ha with rfl | rfl <;>
    interval_cases b <;> norm_num [Int.fract] at *

/- These consequences deliberately use the actual fractional phase.  Closed
folded-norm safety permits the upper face `5 / 6`; a strict folded-norm bound
supplies the strict upper fractional bound needed by the forward move. -/
private theorem two_even_closed_of_fract_band (x : ℝ)
    (hlo : (1 : ℝ) / 6 ≤ Int.fract x)
    (hhi : Int.fract x ≤ (5 : ℝ) / 6) :
    (1 : ℝ) / 6 ≤ circleNorm x := by
  rw [circleNorm_eq_min_fract, le_min_iff]
  constructor <;> linarith

private theorem two_even_strict_bands_of_norm (x : ℝ)
    (h : (1 : ℝ) / 6 < circleNorm x) :
    (1 : ℝ) / 6 ≤ Int.fract x ∧ Int.fract x < (5 : ℝ) / 6 := by
  rw [circleNorm_eq_min_fract, lt_min_iff] at h
  constructor <;> linarith

private theorem two_even_odd_face_false
    (v : Fin 5 → ℕ) (hpos : ∀ i, 0 < v i)
    (hsix : 6 ∣ v 0) (heven1 : 2 ∣ v 1)
    (hodd2 : ¬ 2 ∣ v 2) (hodd3 : ¬ 2 ∣ v 3) (hodd4 : ¬ 2 ∣ v 4)
    (hother : ∀ i, i ≠ 0 → ¬ 3 ∣ v i)
    (τ : ℝ) (hmax : ∀ t : ℝ, ComplementSafe v 0 ((1 : ℝ) / 6) t →
      circleNorm (t * (v 0 : ℝ)) ≤ circleNorm (τ * (v 0 : ℝ)))
    (hmpos : 0 < Int.fract (τ * (v 0 : ℝ)))
    (hmlt : Int.fract (τ * (v 0 : ℝ)) < (1 : ℝ) / 6)
    (hmnorm : Int.fract (τ * (v 0 : ℝ)) = circleNorm (τ * (v 0 : ℝ)))
    (r : Fin 5) (hrp : r ≠ 0)
    (hrface : Int.fract (τ * (v r : ℝ)) = (5 : ℝ) / 6)
    (ρ : Fin 3 → Fin 5) (hρzero : ρ 0 = 1)
    (hρp : ∀ j, ρ j ≠ 0) (hρr : ∀ j, ρ j ≠ r)
    (hρodd : ∀ j, j ≠ 0 → ¬ 2 ∣ v (ρ j))
    (hρexhaust : ∀ i, i ≠ 0 → i ≠ r → ∃ j, ρ j = i) : False := by
  have hrodd : ¬ 2 ∣ v r := by
    fin_cases r <;> simp_all [hodd2, hodd3, hodd4]
  obtain ⟨zr, σ, hdr, hσ⟩ :=
    threeEven_exists_odd_unit_sixth_residue (v r) hrodd (hother r hrp)
  have hρres : ∀ j, ∃ z e : ℤ,
      (v (ρ j) : ℤ) = 6 * z +
        (if j = 0 then (2 : ℤ) else 1) * e ∧ (e = 1 ∨ e = -1) := by
    intro j
    by_cases hj : j = 0
    · subst j
      obtain ⟨z, e, hd, he⟩ := threeEven_exists_even_unit_sixth_residue
        (v 1) heven1 (hother 1 (by decide))
      refine ⟨z, e, ?_, he⟩
      simpa [hρzero] using hd
    · obtain ⟨z, e, hd, he⟩ := threeEven_exists_odd_unit_sixth_residue
        (v (ρ j)) (hρodd j hj) (hother _ (hρp j))
      exact ⟨z, e, by simpa [hj] using hd, he⟩
  choose z e hd he using hρres
  let t' : ℝ := τ + (σ : ℝ) / 6
  let x : Fin 3 → ℝ := fun j => Int.fract (t' * (v (ρ j) : ℝ))
  have ht'p : Int.fract (t' * (v 0 : ℝ)) = Int.fract (τ * (v 0 : ℝ)) := by
    simpa [t'] using two_even_fract_shift (v 0) hsix τ σ
  have hsquare : σ * σ = 1 := by rcases hσ with rfl | rfl <;> norm_num
  have ht'r : Int.fract (t' * (v r : ℝ)) = 0 := by
    have h := fract_sixth_affine_time τ (v r) 1 σ zr σ hdr
    rw [hrface, hsquare] at h
    norm_num at h ⊢
    simpa [t'] using h
  have hchoice :
      (∃ a b : ℕ, 2 ≤ a ∧ a ≤ 5 ∧ 1 ≤ b ∧ b ≤ 5 ∧ ∀ j,
        (1 : ℝ) / 6 ≤ circleNorm ((a : ℝ) * x j + (e j : ℝ) *
          (if j = 0 then (2 : ℝ) else 1) * (b : ℝ) / 6)) ∨
      (∃ b : ℕ, ((σ = 1 ∧ 1 ≤ b ∧ b ≤ 4) ∨
        (σ = -1 ∧ 2 ≤ b ∧ b ≤ 5)) ∧ ∀ j,
        (1 : ℝ) / 6 < circleNorm (x j + (e j : ℝ) *
          (if j = 0 then (2 : ℝ) else 1) * (b : ℝ) / 6)) := by
    rcases hσ with hσ | hσ
    · subst σ
      rcases renault_phase_six_one_signed x e he with h | h
      · exact Or.inl h
      · rcases h with ⟨b, hb1, hb4, hg⟩
        exact Or.inr ⟨b, Or.inl ⟨rfl, hb1, hb4⟩, hg⟩
    · subst σ
      rcases renault_phase_six_one_signed_reflected x e he with h | h
      · exact Or.inl h
      · rcases h with ⟨b, hb2, hb5, hg⟩
        exact Or.inr ⟨b, Or.inr ⟨rfl, hb2, hb5⟩, hg⟩
  rcases hchoice with hclosed | hstrict
  · rcases hclosed with ⟨a, b, ha2, ha5, hb1, hb5, hgood⟩
    let s : ℝ := (a : ℝ) * t' + (b : ℝ) / 6
    have hρphase : ∀ j, circleNorm (s * (v (ρ j) : ℝ)) =
        circleNorm ((a : ℝ) * x j + (e j : ℝ) *
          (if j = 0 then (2 : ℝ) else 1) * (b : ℝ) / 6) := by
      intro j
      have h := two_even_norm_affine t' (v (ρ j)) (a : ℤ) (b : ℤ) (z j)
        ((if j = 0 then (2 : ℤ) else 1) * e j) (hd j)
      simpa [s, x, mul_comm, mul_left_comm, mul_assoc] using h
    have hrphase : Int.fract (s * (v r : ℝ)) =
        Int.fract ((σ : ℝ) * (b : ℝ) / 6) := by
      have h := fract_sixth_affine_time t' (v r) (a : ℤ) (b : ℤ) zr σ hdr
      rw [ht'r] at h
      simpa [s, mul_comm, mul_left_comm, mul_assoc] using h
    have hsafe' : ComplementSafe v 0 ((1 : ℝ) / 6) s := by
      intro i hip
      by_cases hir : i = r
      · subst i
        have hrnorm : circleNorm (s * (v r : ℝ)) =
            circleNorm ((σ : ℝ) * (b : ℝ) / 6) := by
          rw [circleNorm_eq_min_fract, circleNorm_eq_min_fract, hrphase]
        rw [hrnorm]
        exact two_even_odd_face_closed σ b hσ hb1 hb5
      · obtain ⟨j, hj⟩ := hρexhaust i hip hir
        rw [← hj, hρphase]
        exact hgood j
    let B : ℤ := (a : ℤ) * σ + (b : ℤ)
    have hsform : s = (a : ℝ) * τ + (B : ℝ) / 6 := by
      dsimp [s, t', B]; push_cast; ring
    have hmlt' : Int.fract (τ * (v 0 : ℝ)) < (6 : ℝ)⁻¹ := by norm_num; exact hmlt
    have himprove := reciprocal_dilate_shift_improves 6 (v 0) a B τ
      (by omega) hsix ha2 (by omega) hmpos hmlt'
    have himprove' : circleNorm (τ * (v 0 : ℝ)) < circleNorm (s * (v 0 : ℝ)) := by
      simpa [hsform] using himprove
    exact (not_lt_of_ge (hmax s hsafe')) himprove'
  · rcases hstrict with ⟨b, htype, hgood⟩
    let s : ℝ := t' + (b : ℝ) / 6
    have hρphase : ∀ j, circleNorm (s * (v (ρ j) : ℝ)) =
        circleNorm (x j + (e j : ℝ) *
          (if j = 0 then (2 : ℝ) else 1) * (b : ℝ) / 6) := by
      intro j
      have h := two_even_norm_affine t' (v (ρ j)) 1 (b : ℤ) (z j)
        ((if j = 0 then (2 : ℤ) else 1) * e j) (hd j)
      simpa [s, x, mul_comm, mul_left_comm, mul_assoc] using h
    have hrphase : Int.fract (s * (v r : ℝ)) =
        Int.fract ((σ : ℝ) * (b : ℝ) / 6) := by
      have h := fract_sixth_affine_time t' (v r) 1 (b : ℤ) zr σ hdr
      rw [ht'r] at h
      simpa [s, mul_comm, mul_left_comm, mul_assoc] using h
    have hbands : ∀ i, i ≠ 0 → (1 : ℝ) / 6 ≤ Int.fract (s * (v i : ℝ)) ∧
        Int.fract (s * (v i : ℝ)) < 1 - (1 : ℝ) / 6 := by
      intro i hip
      by_cases hir : i = r
      · subst i
        rw [hrphase]
        obtain ⟨hlo, hhi⟩ := two_even_odd_face_forward σ b htype
        exact ⟨hlo, by linarith⟩
      · obtain ⟨j, hj⟩ := hρexhaust i hip hir
        subst i
        obtain ⟨hlo, hhi⟩ := two_even_strict_bands_of_norm _ (by rw [hρphase]; exact hgood j)
        exact ⟨hlo, by linarith⟩
    have hspfract : Int.fract (s * (v 0 : ℝ)) = Int.fract (τ * (v 0 : ℝ)) := by
      calc
        Int.fract (s * (v 0 : ℝ)) = Int.fract (t' * (v 0 : ℝ)) := by
          simpa [s] using two_even_fract_shift (v 0) hsix t' (b : ℤ)
        _ = Int.fract (τ * (v 0 : ℝ)) := ht'p
    have hspnorm : circleNorm (s * (v 0 : ℝ)) = circleNorm (τ * (v 0 : ℝ)) := by
      rw [circleNorm_eq_min_fract, hspfract, min_eq_left]
      · exact hmnorm
      · linarith
    obtain ⟨ε, hε, hsafe', himprove⟩ := exists_forward_complement_improvement v 0 hpos
      ((1 : ℝ) / 6) s (by norm_num) (by norm_num)
      (by rw [hspfract]; linarith) hbands
    rw [hspnorm] at himprove
    exact (not_lt_of_ge (hmax (s + ε) hsafe')) himprove

/- When the exposed `5 / 6` face is the other even label, signed 6.4 has
three outcomes.  The closed outcome deliberately accepts `b = 0`. -/
private theorem two_even_even_face_false
    (v : Fin 5 → ℕ) (hpos : ∀ i, 0 < v i)
    (hsix : 6 ∣ v 0) (heven1 : 2 ∣ v 1)
    (hodd2 : ¬ 2 ∣ v 2) (hodd3 : ¬ 2 ∣ v 3) (hodd4 : ¬ 2 ∣ v 4)
    (hother : ∀ i, i ≠ 0 → ¬ 3 ∣ v i)
    (τ : ℝ) (hsafe : ComplementSafe v 0 ((1 : ℝ) / 6) τ)
    (hmax : ∀ t : ℝ, ComplementSafe v 0 ((1 : ℝ) / 6) t →
      circleNorm (t * (v 0 : ℝ)) ≤ circleNorm (τ * (v 0 : ℝ)))
    (hmpos : 0 < Int.fract (τ * (v 0 : ℝ)))
    (hmlt : Int.fract (τ * (v 0 : ℝ)) < (1 : ℝ) / 6)
    (hmnorm : Int.fract (τ * (v 0 : ℝ)) = circleNorm (τ * (v 0 : ℝ)))
    (hrface : Int.fract (τ * (v 1 : ℝ)) = (5 : ℝ) / 6) : False := by
  let ρ : Fin 3 → Fin 5 := ![2, 3, 4]
  have hρp : ∀ j, ρ j ≠ 0 := by intro j; fin_cases j <;> decide
  have hρexhaust : ∀ i, i ≠ 0 → i ≠ 1 → ∃ j, ρ j = i := by
    intro i hi0 hi1
    fin_cases i
    · exact (hi0 rfl).elim
    · exact (hi1 rfl).elim
    · exact ⟨0, rfl⟩
    · exact ⟨1, rfl⟩
    · exact ⟨2, rfl⟩
  have hρres : ∀ j, ∃ z e : ℤ, (v (ρ j) : ℤ) = 6 * z + e ∧
      (e = 1 ∨ e = -1) := by
    intro j
    fin_cases j
    · simpa [ρ] using threeEven_exists_odd_unit_sixth_residue (v 2) hodd2
        (hother 2 (by decide))
    · simpa [ρ] using threeEven_exists_odd_unit_sixth_residue (v 3) hodd3
        (hother 3 (by decide))
    · simpa [ρ] using threeEven_exists_odd_unit_sixth_residue (v 4) hodd4
        (hother 4 (by decide))
  choose z e hd he using hρres
  let x : Fin 3 → ℝ := fun j => Int.fract (τ * (v (ρ j) : ℝ))
  have hx : ∀ j, (1 : ℝ) / 6 ≤ circleNorm (x j) := by
    intro j
    have hs := hsafe (ρ j) (hρp j)
    simpa [x, circleNorm_eq_min_fract] using hs
  obtain ⟨zq, σ, hdq, hσ⟩ :=
    threeEven_exists_even_unit_sixth_residue (v 1) heven1 (hother 1 (by decide))
  rcases renault_phase_six_four_signed x e he hx with hdouble | hunit | hclosed
  · let s : ℝ := 2 * τ
    have hρsafe : ∀ j, (1 : ℝ) / 6 ≤ circleNorm (s * (v (ρ j) : ℝ)) := by
      intro j
      have h := two_even_norm_affine τ (v (ρ j)) 2 0 (z j) (e j) (hd j)
      have h' : circleNorm (s * (v (ρ j) : ℝ)) = circleNorm (2 * x j) := by
        simpa [s, x] using h
      rw [h']
      exact (hdouble j).le
    have hface : Int.fract (s * (v 1 : ℝ)) = (2 : ℝ) / 3 := by
      have h := fract_sixth_affine_time τ (v 1) 2 0 zq (2 * σ) (by
        calc
          (v 1 : ℤ) = 6 * zq + 2 * σ := hdq
          _ = 6 * zq + (2 * σ) := by ring)
      rw [hrface] at h
      calc
        Int.fract (s * (v 1 : ℝ)) = Int.fract (2 * ((5 : ℝ) / 6)) := by
          simpa [s, mul_comm, mul_left_comm, mul_assoc] using h
        _ = (2 : ℝ) / 3 := by norm_num [Int.fract]
    have hsafe' : ComplementSafe v 0 ((1 : ℝ) / 6) s := by
      intro i hi
      by_cases h1 : i = 1
      · subst i
        apply two_even_closed_of_fract_band <;> rw [hface] <;> norm_num
      · obtain ⟨j, hj⟩ := hρexhaust i hi h1
        subst i
        exact hρsafe j
    have hmlt' : Int.fract (τ * (v 0 : ℝ)) < (6 : ℝ)⁻¹ := by norm_num; exact hmlt
    have himprove := reciprocal_dilate_shift_improves 6 (v 0) 2 0 τ
      (by omega) hsix (by omega) (by omega) hmpos hmlt'
    have hsform : s = (2 : ℝ) * τ + ((0 : ℤ) : ℝ) / 6 := by dsimp [s]; ring
    have himprove' : circleNorm (τ * (v 0 : ℝ)) < circleNorm (s * (v 0 : ℝ)) := by
      simpa [hsform] using himprove
    exact (not_lt_of_ge (hmax s hsafe')) himprove'
  · rcases hunit with ⟨b, hb, hgood⟩
    let s : ℝ := τ + (b : ℝ) / 6
    have hρnorm : ∀ j, (1 : ℝ) / 6 < circleNorm (s * (v (ρ j) : ℝ)) := by
      intro j
      have h := two_even_norm_affine τ (v (ρ j)) 1 (b : ℤ) (z j) (e j) (hd j)
      have h' : circleNorm (s * (v (ρ j) : ℝ)) =
          circleNorm (x j + (e j : ℝ) * (b : ℝ) / 6) := by
        simpa [s, x, mul_comm] using h
      rw [h']
      exact hgood j
    have hface : Int.fract (s * (v 1 : ℝ)) =
        Int.fract ((5 + 2 * (σ : ℝ) * (b : ℝ)) / 6) := by
      have h := fract_sixth_affine_time τ (v 1) 1 (b : ℤ) zq (2 * σ) (by
        calc
          (v 1 : ℤ) = 6 * zq + 2 * σ := hdq
          _ = 6 * zq + (2 * σ) := by ring)
      rw [hrface] at h
      calc
        Int.fract (s * (v 1 : ℝ)) =
            Int.fract ((5 : ℝ) / 6 + (σ : ℝ) * ((b : ℝ) * 2) / 6) := by
          simpa [s, mul_comm, mul_left_comm, mul_assoc] using h
        _ = _ := by congr 1; ring
    have hbands : ∀ i, i ≠ 0 → (1 : ℝ) / 6 ≤ Int.fract (s * (v i : ℝ)) ∧
        Int.fract (s * (v i : ℝ)) < 1 - (1 : ℝ) / 6 := by
      intro i hi
      by_cases h1 : i = 1
      · subst i
        rw [hface]
        obtain ⟨hl, hu⟩ := two_even_face_forward σ b hσ hb
        exact ⟨hl, by linarith⟩
      · obtain ⟨j, hj⟩ := hρexhaust i hi h1
        subst i
        obtain ⟨hl, hu⟩ := two_even_strict_bands_of_norm _ (hρnorm j)
        exact ⟨hl, by linarith⟩
    have hspfract : Int.fract (s * (v 0 : ℝ)) = Int.fract (τ * (v 0 : ℝ)) := by
      simpa [s] using two_even_fract_shift (v 0) hsix τ (b : ℤ)
    have hspnorm : circleNorm (s * (v 0 : ℝ)) = circleNorm (τ * (v 0 : ℝ)) := by
      rw [circleNorm_eq_min_fract, hspfract, min_eq_left]
      · exact hmnorm
      · linarith
    obtain ⟨ε, hε, hs', himprove⟩ := exists_forward_complement_improvement v 0 hpos
      ((1 : ℝ) / 6) s (by norm_num) (by norm_num) (by rw [hspfract]; linarith) hbands
    rw [hspnorm] at himprove
    exact (not_lt_of_ge (hmax (s + ε) hs')) himprove
  · rcases hclosed with ⟨a, b, ha, hb, hgood⟩
    let s : ℝ := (a : ℝ) * τ + (b : ℝ) / 6
    have hρsafe : ∀ j, (1 : ℝ) / 6 ≤ circleNorm (s * (v (ρ j) : ℝ)) := by
      intro j
      have h := two_even_norm_affine τ (v (ρ j)) (a : ℤ) (b : ℤ) (z j) (e j) (hd j)
      have h' : circleNorm (s * (v (ρ j) : ℝ)) =
          circleNorm ((a : ℝ) * x j + (e j : ℝ) * (b : ℝ) / 6) := by
        simpa [s, x, mul_comm] using h
      rw [h']
      exact hgood j
    have hface : Int.fract (s * (v 1 : ℝ)) =
        Int.fract ((5 * (a : ℝ) + 2 * (σ : ℝ) * (b : ℝ)) / 6) := by
      have h := fract_sixth_affine_time τ (v 1) (a : ℤ) (b : ℤ) zq (2 * σ) (by
        calc
          (v 1 : ℤ) = 6 * zq + 2 * σ := hdq
          _ = 6 * zq + (2 * σ) := by ring)
      rw [hrface] at h
      calc
        Int.fract (s * (v 1 : ℝ)) =
            Int.fract ((a : ℝ) * (5 / 6) + (σ : ℝ) * ((b : ℝ) * 2) / 6) := by
          simpa [s, mul_comm, mul_left_comm, mul_assoc] using h
        _ = _ := by congr 1; ring
    have hsafe' : ComplementSafe v 0 ((1 : ℝ) / 6) s := by
      intro i hi
      by_cases h1 : i = 1
      · subst i
        obtain ⟨hl, hu⟩ := two_even_face_closed σ a b hσ ha hb
        exact two_even_closed_of_fract_band _ (by rw [hface]; exact hl) (by rw [hface]; exact hu)
      · obtain ⟨j, hj⟩ := hρexhaust i hi h1
        subst i
        exact hρsafe j
    have hmlt' : Int.fract (τ * (v 0 : ℝ)) < (6 : ℝ)⁻¹ := by norm_num; exact hmlt
    have himprove := reciprocal_dilate_shift_improves 6 (v 0) a (b : ℤ) τ
      (by omega) hsix (by omega) (by omega) hmpos hmlt'
    have himprove' : circleNorm (τ * (v 0 : ℝ)) < circleNorm (s * (v 0 : ℝ)) := by
      simpa [s] using himprove
    exact (not_lt_of_ge (hmax s hsafe')) himprove'

/-- The two-even residue branch supplies a positive common sixth-margin time
for five positive labelled speeds.  Values may repeat: all case splits are on
the five labels, never on numerical speed equality. -/
theorem fiveMovingNaturalRunners_of_two_even_residues
    (v : Fin 5 → ℕ) (hpos : ∀ i, 0 < v i)
    (hsix : 6 ∣ v 0) (heven1 : 2 ∣ v 1)
    (hodd2 : ¬ 2 ∣ v 2) (hodd3 : ¬ 2 ∣ v 3) (hodd4 : ¬ 2 ∣ v 4)
    (hother : ∀ i, i ≠ 0 → ¬ 3 ∣ v i) :
    ∃ t : ℝ, 0 < t ∧ ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ)) := by
  have hall : ∃ t : ℝ, ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ)) := by
    by_contra hno
    obtain ⟨τ, hτ0, hτ1, hsafe, hmax, hmpos, hmlt, hmnorm,
      r, hrp, hrface⟩ := exists_one_sixth_complement_maximizer v hpos 0 hno
    fin_cases r
    · exact (hrp rfl).elim
    · exact two_even_even_face_false v hpos hsix heven1 hodd2 hodd3 hodd4 hother
        τ hsafe hmax hmpos hmlt hmnorm hrface
    · exact two_even_odd_face_false v hpos hsix heven1 hodd2 hodd3 hodd4 hother
        τ hmax hmpos hmlt hmnorm 2 (by decide) hrface ![1, 3, 4] (by rfl)
        (by intro j; fin_cases j <;> decide)
        (by intro j; fin_cases j <;> decide)
        (by intro j hj; fin_cases j
            · exact (hj rfl).elim
            · exact hodd3
            · exact hodd4)
        (by intro i hi0 hi2; fin_cases i
            · exact (hi0 rfl).elim
            · exact ⟨0, rfl⟩
            · exact (hi2 rfl).elim
            · exact ⟨1, rfl⟩
            · exact ⟨2, rfl⟩)
    · exact two_even_odd_face_false v hpos hsix heven1 hodd2 hodd3 hodd4 hother
        τ hmax hmpos hmlt hmnorm 3 (by decide) hrface ![1, 2, 4] (by rfl)
        (by intro j; fin_cases j <;> decide)
        (by intro j; fin_cases j <;> decide)
        (by intro j hj; fin_cases j
            · exact (hj rfl).elim
            · exact hodd2
            · exact hodd4)
        (by intro i hi0 hi3; fin_cases i
            · exact (hi0 rfl).elim
            · exact ⟨0, rfl⟩
            · exact ⟨1, rfl⟩
            · exact (hi3 rfl).elim
            · exact ⟨2, rfl⟩)
    · exact two_even_odd_face_false v hpos hsix heven1 hodd2 hodd3 hodd4 hother
        τ hmax hmpos hmlt hmnorm 4 (by decide) hrface ![1, 2, 3] (by rfl)
        (by intro j; fin_cases j <;> decide)
        (by intro j; fin_cases j <;> decide)
        (by intro j hj; fin_cases j
            · exact (hj rfl).elim
            · exact hodd2
            · exact hodd3)
        (by intro i hi0 hi4; fin_cases i
            · exact (hi0 rfl).elim
            · exact ⟨0, rfl⟩
            · exact ⟨1, rfl⟩
            · exact ⟨2, rfl⟩
            · exact (hi4 rfl).elim)
  obtain ⟨u, hu⟩ := hall
  have hu0 : u ≠ 0 := by
    intro hzero
    have h := hu 0
    rw [hzero] at h
    norm_num [circleNorm] at h
  rcases lt_or_gt_of_ne hu0 with hneg | hposu
  · refine ⟨-u, neg_pos.mpr hneg, ?_⟩
    intro i
    rw [show (-u) * (v i : ℝ) = -(u * (v i : ℝ)) by ring, circleNorm_neg]
    exact hu i
  · exact ⟨u, hposu, hu⟩

/-- A unique three-divisible label and exactly two even labels can be relabelled
into the fixed two-even theorem.  The divisor cover supplies the required
six-divisible pivot under the temporary all-real nonexistence assumption. -/
theorem one_three_divisible_two_even_witness
    (v : Fin 5 → ℕ) (hpos : ∀ i, 0 < v i) (p : Fin 5)
    (hone : ∀ i, 3 ∣ v i ↔ i = p)
    (heven : ((Finset.univ : Finset (Fin 5)).filter
      (fun i => 2 ∣ v i)).card = 2) :
    ∃ t : ℝ, 0 < t ∧ ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ)) := by
  have hall : ∃ t : ℝ, ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ)) := by
    by_contra hno
    obtain ⟨i, hsi⟩ := divisor_cover_of_no_small_witness v (N := 6) (by omega)
      (by simpa [one_div] using hno) 6 (by omega) (by omega)
    have hip : i = p := (hone i).mp (dvd_trans (by norm_num) hsi)
    subst i
    have hp2 : 2 ∣ v p := dvd_trans (by norm_num) hsi
    let S : Finset (Fin 5) := (Finset.univ.filter (fun i => 2 ∣ v i))
    have hpS : p ∈ S := by simp [S, hp2]
    have herase : (S.erase p).card = 1 := by
      rw [Finset.card_erase_of_mem hpS, heven]
    obtain ⟨q, hqS⟩ := Finset.card_eq_one.mp herase
    have hqmem : q ∈ S.erase p := by rw [hqS]; simp
    have hqp : q ≠ p := by
      exact (Finset.mem_erase.mp hqmem).1
    have hq2 : 2 ∣ v q := by
      have : q ∈ S := (Finset.mem_erase.mp hqmem).2
      simpa [S] using this
    let O : Finset (Fin 5) := ((Finset.univ : Finset (Fin 5)).erase p).erase q
    have hOcard : O.card = 3 := by
      simp [O, hqp]
    obtain ⟨u, w, z, huw, huz, hwz, hO⟩ := Finset.card_eq_three.mp hOcard
    have hu_p : u ≠ p := by
      have : u ∈ O := by rw [hO]; simp
      exact (Finset.mem_erase.mp (Finset.mem_erase.mp this).2).1
    have hw_p : w ≠ p := by
      have : w ∈ O := by rw [hO]; simp
      exact (Finset.mem_erase.mp (Finset.mem_erase.mp this).2).1
    have hz_p : z ≠ p := by
      have : z ∈ O := by rw [hO]; simp
      exact (Finset.mem_erase.mp (Finset.mem_erase.mp this).2).1
    have hu_q : u ≠ q := by
      have : u ∈ O := by rw [hO]; simp
      exact (Finset.mem_erase.mp this).1
    have hw_q : w ≠ q := by
      have : w ∈ O := by rw [hO]; simp
      exact (Finset.mem_erase.mp this).1
    have hz_q : z ≠ q := by
      have : z ∈ O := by rw [hO]; simp
      exact (Finset.mem_erase.mp this).1
    have heven_iff : ∀ i, 2 ∣ v i ↔ i = p ∨ i = q := by
      intro j
      constructor
      · intro hj
        have hjS : j ∈ S := by simp [S, hj]
        by_cases hjp : j = p
        · exact Or.inl hjp
        · have hjE : j ∈ S.erase p := Finset.mem_erase.mpr ⟨hjp, hjS⟩
          rw [hqS] at hjE
          exact Or.inr (by simpa using hjE)
      · rintro (rfl | rfl)
        · exact hp2
        · exact hq2
    let v' : Fin 5 → ℕ := ![v p, v q, v u, v w, v z]
    have hv'pos : ∀ j, 0 < v' j := by
      intro j; fin_cases j <;> simp [v', hpos]
    have hv'six : 6 ∣ v' 0 := by simpa [v'] using hsi
    have hv'even : 2 ∣ v' 1 := by simpa [v'] using hq2
    have hv'odd2 : ¬ 2 ∣ v' 2 := by
      simpa [v'] using fun h => hu_q (Or.resolve_left ((heven_iff u).mp h) hu_p)
    have hv'odd3 : ¬ 2 ∣ v' 3 := by
      simpa [v'] using fun h => hw_q (Or.resolve_left ((heven_iff w).mp h) hw_p)
    have hv'odd4 : ¬ 2 ∣ v' 4 := by
      simpa [v'] using fun h => hz_q (Or.resolve_left ((heven_iff z).mp h) hz_p)
    have hv'other : ∀ j, j ≠ 0 → ¬ 3 ∣ v' j := by
      intro j hj h3
      fin_cases j <;> simp_all [v', hone, hqp, hu_p, hw_p, hz_p]
    obtain ⟨t, ht, hbound⟩ := fiveMovingNaturalRunners_of_two_even_residues v'
      hv'pos hv'six hv'even hv'odd2 hv'odd3 hv'odd4 hv'other
    apply hno
    refine ⟨t, ?_⟩
    intro j
    by_cases hjp : j = p
    · subst j; simpa [v'] using hbound 0
    by_cases hjq : j = q
    · subst j; simpa [v'] using hbound 1
    have hjO : j ∈ O := by simp [O, hjp, hjq]
    rw [hO] at hjO
    simp at hjO
    rcases hjO with rfl | rfl | rfl
    · simpa [v'] using hbound 2
    · simpa [v'] using hbound 3
    · simpa [v'] using hbound 4
  obtain ⟨u, hu⟩ := hall
  have hu0 : u ≠ 0 := by
    intro hzero
    have h := hu p
    rw [hzero] at h
    norm_num [circleNorm] at h
  rcases lt_or_gt_of_ne hu0 with hneg | hposu
  · refine ⟨-u, neg_pos.mpr hneg, ?_⟩
    intro i
    rw [show (-u) * (v i : ℝ) = -(u * (v i : ℝ)) by ring, circleNorm_neg]
    exact hu i
  · exact ⟨u, hposu, hu⟩

end LonelyRunner
