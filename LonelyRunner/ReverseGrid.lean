import LonelyRunner.PivotResidues
import Mathlib.Data.Int.ModEq
import Mathlib.Tactic

namespace LonelyRunner

/-! Reverse-grid arithmetic for the audited Response 63 identity.  The source
data keeps the integer signs and phases in `ℤ`, while the speed/grid data stay
in `ℕ`; exact identities are stated in `ℚ` so no natural subtraction is used.
-/

structure ReverseGridData where
  n : ℕ
  N : ℕ
  p : ℕ
  ak : ℕ
  d : ℕ
  b : ℕ
  s : ℤ
  z : ℤ
  r : ℤ
  Q : ℤ
  hn : 2 ≤ n
  hN : N = n + 1
  hp : 0 < p
  hak : 0 < ak
  hs : s = 1 ∨ s = -1
  hr : r = (n : ℤ) * z + s
  hakd : ak + d = n * b
  hQ : z * (ak : ℤ) + s * (b : ℤ) = (p : ℤ) * Q
  hdeep : N * d < n * p

def ReverseGridData.X (D : ReverseGridData) : ℤ := (D.N : ℤ) * D.Q - D.s

def ReverseGridData.modulus (D : ReverseGridData) : ℕ := D.N * D.ak

def ReverseGridData.R (D : ReverseGridData) : ℕ :=
  D.X.natMod (D.modulus : ℤ)

def signedCyclicResidueDistance (M : ℕ) (x : ℤ) : ℕ :=
  cyclicResidueDistance M (x.natMod (M : ℤ))

private theorem reverseGrid_pos_modulus (D : ReverseGridData) :
    0 < D.modulus := by
  unfold ReverseGridData.modulus
  have hn2 : 2 ≤ D.n := D.hn
  have hn : 0 < D.n := by omega
  have hN : 0 < D.N := by rw [D.hN]; omega
  exact Nat.mul_pos hN D.hak

private theorem reverseGrid_natMod_cast (M x : ℕ) (hM : 0 < M) :
    (x : ℤ).natMod (M : ℤ) = x % M := by
  have hnonneg : 0 ≤ (x : ℤ) % (M : ℤ) := by
    exact Int.emod_nonneg _ (by exact_mod_cast hM.ne')
  have hcast : (((x : ℤ) % (M : ℤ)).toNat : ℤ) =
      (x : ℤ) % (M : ℤ) := Int.toNat_of_nonneg hnonneg
  rw [Int.natMod] at *
  rw [← Int.natCast_emod] at hcast
  exact_mod_cast hcast

private theorem reverseGrid_natMod_eq_emod (M : ℕ) (x : ℤ) (hM : 0 < M) :
    (x.natMod (M : ℤ) : ℤ) = x % (M : ℤ) := by
  unfold Int.natMod
  exact Int.toNat_of_nonneg (Int.emod_nonneg _ (by exact_mod_cast hM.ne'))

private theorem reverseGrid_exact_numerator (D : ReverseGridData) :
    (D.N : ℚ) * (D.ak : ℚ) * (D.r : ℚ) -
        (D.s : ℚ) * ((D.n : ℚ) * (D.p : ℚ) - (D.N : ℚ) * (D.d : ℚ)) =
      (D.n : ℚ) * (D.p : ℚ) * (D.X : ℚ) := by
  have hrQ : (D.r : ℚ) = (D.n : ℚ) * (D.z : ℚ) + (D.s : ℚ) := by
    exact_mod_cast D.hr
  have hakdQ : (D.ak : ℚ) + (D.d : ℚ) = (D.n : ℚ) * (D.b : ℚ) := by
    exact_mod_cast D.hakd
  have hQQ : (D.z : ℚ) * (D.ak : ℚ) + (D.s : ℚ) * (D.b : ℚ) =
      (D.p : ℚ) * (D.Q : ℚ) := by
    exact_mod_cast D.hQ
  unfold ReverseGridData.X
  push_cast
  linear_combination
    (D.N : ℚ) * D.ak * hrQ +
      (D.N : ℚ) * D.s * hakdQ +
      (D.N : ℚ) * D.n * hQQ

theorem reverseGrid_exact_identity (D : ReverseGridData) :
    (D.r : ℚ) / ((D.n * D.p : ℕ) : ℚ) -
      (D.s : ℚ) *
        (((D.n * D.p : ℕ) : ℚ) - ((D.N * D.d : ℕ) : ℚ)) /
        ((D.N * D.n * D.p * D.ak : ℕ) : ℚ) =
      (D.X : ℚ) / ((D.N * D.ak : ℕ) : ℚ) := by
  have hn2 : 2 ≤ D.n := D.hn
  have hn : 0 < D.n := by omega
  have hnp : 0 < D.n * D.p := Nat.mul_pos hn D.hp
  have hNa : 0 < D.N * D.ak := reverseGrid_pos_modulus D
  have hN : 0 < D.N := by rw [D.hN]; omega
  have hbig : 0 < D.N * D.n * D.p * D.ak := by
    exact Nat.mul_pos (Nat.mul_pos (Nat.mul_pos hN hn) D.hp) D.hak
  have hnpQ : ((D.n * D.p : ℕ) : ℚ) ≠ 0 := by exact_mod_cast hnp.ne'
  have hNaQ : ((D.N * D.ak : ℕ) : ℚ) ≠ 0 := by exact_mod_cast hNa.ne'
  have hbigQ : ((D.N * D.n * D.p * D.ak : ℕ) : ℚ) ≠ 0 := by
    exact_mod_cast hbig.ne'
  have hden : ((D.N * D.n * D.p * D.ak : ℕ) : ℚ) =
      ((D.n * D.p : ℕ) : ℚ) * ((D.N * D.ak : ℕ) : ℚ) := by
    push_cast
    ring
  rw [hden]
  calc
    (D.r : ℚ) / ((D.n * D.p : ℕ) : ℚ) -
        (D.s : ℚ) *
          (((D.n * D.p : ℕ) : ℚ) - ((D.N * D.d : ℕ) : ℚ)) /
          (((D.n * D.p : ℕ) : ℚ) * ((D.N * D.ak : ℕ) : ℚ)) =
        ((D.N : ℚ) * (D.ak : ℚ) * (D.r : ℚ) -
          (D.s : ℚ) * ((D.n : ℚ) * (D.p : ℚ) - (D.N : ℚ) * (D.d : ℚ))) /
          (((D.n * D.p : ℕ) : ℚ) * ((D.N * D.ak : ℕ) : ℚ)) := by
      field_simp [hnpQ, hNaQ]
      push_cast
      ring
    _ = ((D.n : ℚ) * (D.p : ℚ) * (D.X : ℚ)) /
        (((D.n * D.p : ℕ) : ℚ) * ((D.N * D.ak : ℕ) : ℚ)) := by
      rw [reverseGrid_exact_numerator D]
    _ = (D.X : ℚ) / ((D.N * D.ak : ℕ) : ℚ) := by
      field_simp [hnpQ, hNaQ]
      push_cast
      ring

theorem reverseGrid_deficit_pos (D : ReverseGridData) :
    0 < ((D.n * D.p : ℕ) : ℚ) - ((D.N * D.d : ℕ) : ℚ) := by
  have h : ((D.N * D.d : ℕ) : ℚ) < ((D.n * D.p : ℕ) : ℚ) := by
    exact_mod_cast D.hdeep
  exact sub_pos.mpr h

theorem reverseGrid_residue_lt (D : ReverseGridData) :
    D.R < D.modulus := by
  exact Int.natMod_lt (Nat.ne_of_gt (reverseGrid_pos_modulus D))

theorem reverseGrid_residue_modEq (D : ReverseGridData) :
    Int.ModEq (D.modulus : ℤ) D.X (D.R : ℤ) := by
  unfold ReverseGridData.R
  have hM : 0 < D.modulus := reverseGrid_pos_modulus D
  have hcast : (D.X.natMod (D.modulus : ℤ) : ℤ) =
      D.X % (D.modulus : ℤ) := reverseGrid_natMod_eq_emod D.modulus D.X hM
  unfold Int.ModEq
  rw [hcast]
  simp

theorem reverseGrid_phase_mod_one (D : ReverseGridData) :
    ∃ q : ℤ,
      (D.X : ℚ) / (D.modulus : ℚ) =
        (q : ℚ) + (D.R : ℚ) / (D.modulus : ℚ) := by
  have hM : 0 < D.modulus := reverseGrid_pos_modulus D
  have hMZ : (0 : ℤ) < (D.modulus : ℤ) := by exact_mod_cast hM
  have hrem : (D.R : ℤ) = D.X % (D.modulus : ℤ) := by
    exact reverseGrid_natMod_eq_emod D.modulus D.X hM
  refine ⟨D.X / (D.modulus : ℤ), ?_⟩
  have hdiv := Int.emod_add_mul_ediv D.X (D.modulus : ℤ)
  have hremQ : (D.R : ℚ) = ((D.X % (D.modulus : ℤ) : ℤ) : ℚ) := by
    exact_mod_cast hrem
  rw [hremQ]
  have hdivQ : ((D.X % (D.modulus : ℤ) : ℤ) : ℚ) +
      (D.modulus : ℚ) * ((D.X / (D.modulus : ℤ) : ℤ) : ℚ) = (D.X : ℚ) := by
    exact_mod_cast hdiv
  field_simp [show (D.modulus : ℚ) ≠ 0 by exact_mod_cast hM.ne']
  nlinarith [hdivQ]

theorem signedCyclicResidueDistance_ofNat {M x : ℕ} (hM : 0 < M) :
    signedCyclicResidueDistance M (x : ℤ) = cyclicResidueDistance M x := by
  simp [signedCyclicResidueDistance, reverseGrid_natMod_cast M x hM,
    cyclicResidueDistance]

theorem signedCyclicResidueDistance_congr {M : ℕ} (hM : 0 < M) {x y : ℤ}
    (hxy : Int.ModEq (M : ℤ) x y) :
    signedCyclicResidueDistance M x = signedCyclicResidueDistance M y := by
  have hmod : x % (M : ℤ) = y % (M : ℤ) := hxy
  have hx : (x.natMod (M : ℤ) : ℤ) = x % (M : ℤ) :=
    reverseGrid_natMod_eq_emod M x hM
  have hy : (y.natMod (M : ℤ) : ℤ) = y % (M : ℤ) :=
    reverseGrid_natMod_eq_emod M y hM
  unfold signedCyclicResidueDistance
  have hnat : x.natMod (M : ℤ) = y.natMod (M : ℤ) := by
    apply Int.natCast_inj.mp
    exact hx.trans (hmod.trans hy.symm)
  rw [hnat]

theorem signedCyclicResidueDistance_neg {M : ℕ} (hM : 0 < M) (x : ℤ) :
    signedCyclicResidueDistance M (-x) = signedCyclicResidueDistance M x := by
  have hneg : (-x) % (M : ℤ) =
      if x % (M : ℤ) = 0 then 0 else (M : ℤ) - x % (M : ℤ) := by
    by_cases hz : x % (M : ℤ) = 0
    · have hdvd : (M : ℤ) ∣ x := Int.dvd_iff_emod_eq_zero.mpr hz
      simp [Int.neg_emod, hdvd, hz]
    · rw [Int.neg_emod]
      have hndvd : ¬(M : ℤ) ∣ x := by
        intro hdvd
        exact hz (Int.emod_eq_zero_of_dvd hdvd)
      simp [hndvd, hz]
  have hx : (x.natMod (M : ℤ) : ℤ) = x % (M : ℤ) :=
    reverseGrid_natMod_eq_emod M x hM
  have hnx : ((-x).natMod (M : ℤ) : ℤ) = (-x) % (M : ℤ) :=
    reverseGrid_natMod_eq_emod M (-x) hM
  have hnatneg : (-x).natMod (M : ℤ) =
      if x % (M : ℤ) = 0 then 0 else M - x.natMod (M : ℤ) := by
    apply Int.natCast_inj.mp
    by_cases hz : x % (M : ℤ) = 0
    · simp only [if_pos hz]
      rw [hnx, hneg]
      simp [hz]
    · simp only [if_neg hz]
      rw [hnx, hneg]
      simp only [if_neg hz]
      rw [← hx]
      rw [Int.natCast_sub]
      exact Nat.le_of_lt (Int.natMod_lt hM.ne')
  unfold signedCyclicResidueDistance
  rw [hnatneg]
  simp only [cyclicResidueDistance]
  by_cases hz : x % (M : ℤ) = 0
  · have hxn0 : x.natMod (M : ℤ) = 0 := by
      apply Int.natCast_inj.mp
      rw [hx, hz]
      norm_num
    rw [if_pos hz]
    simp [hxn0]
  · have hxnpos : 0 < x.natMod (M : ℤ) := by
      apply Nat.pos_of_ne_zero
      intro hzero
      apply hz
      rw [← hx, hzero]
      rfl
    have hxlt : x.natMod (M : ℤ) < M := Int.natMod_lt hM.ne'
    have hxsub_lt : M - x.natMod (M : ℤ) < M := by omega
    rw [if_neg hz, Nat.mod_eq_of_lt hxlt, Nat.mod_eq_of_lt hxsub_lt]
    rw [Nat.sub_sub_self (Nat.le_of_lt hxlt)]
    exact min_comm _ _

private theorem reverseGrid_boundary_of_modEq {N a R : ℕ} {s : ℤ}
    (hN : 2 ≤ N) (ha : 0 < a)
    (hs : s = 1 ∨ s = -1)
    (hmod : Int.ModEq (N : ℤ) (R : ℤ) (-s)) :
    cyclicResidueDistance (N * a) (R * a) = a := by
  have hNpos : 0 < N := by omega
  have hmod' : (R % N : ℕ) =
      if s = 1 then N - 1 else 1 := by
    have hmodInt : (R : ℤ) % (N : ℤ) = (-s) % (N : ℤ) := hmod
    rcases hs with rfl | rfl
    · have hNnotone : ¬(N : ℤ) ∣ 1 := by
        intro h
        have : (N : ℤ) ≤ 1 := Int.le_of_dvd (by norm_num) h
        omega
      rw [← Int.natCast_emod R N] at hmodInt
      have hone : (1 : ℤ) % (N : ℤ) = 1 := by
        exact Int.emod_eq_of_lt (by norm_num)
          (by exact_mod_cast (show 1 < N by omega))
      have hnegone : (-1 : ℤ) % (N : ℤ) = (N : ℤ) - 1 := by
        rw [Int.neg_emod, if_neg hNnotone, hone]
        simp
      rw [hnegone] at hmodInt
      have hsubcast : ((N - 1 : ℕ) : ℤ) = (N : ℤ) - 1 := by
        exact Int.natCast_sub (by omega)
      simp only [if_pos rfl]
      exact_mod_cast hmodInt.trans hsubcast.symm
    · rw [← Int.natCast_emod R N] at hmodInt
      have hone : (1 : ℤ) % (N : ℤ) = 1 := by
        exact Int.emod_eq_of_lt (by norm_num)
          (by exact_mod_cast (show 1 < N by omega))
      rw [show -(-1 : ℤ) = 1 by norm_num, hone] at hmodInt
      simp only [if_neg (by norm_num : (-1 : ℤ) ≠ 1)]
      exact_mod_cast hmodInt
  have hdecomp : R = N * (R / N) + R % N := by
    exact (Nat.div_add_mod R N).symm
  have hmul : R * a = (N * a) * (R / N) + (R % N) * a := by
    calc
      R * a = (N * (R / N) + R % N) * a :=
        congrArg (fun t => t * a) hdecomp
      _ = (N * a) * (R / N) + (R % N) * a := by ring
  have hres : ((N * a) * (R / N) + (R % N) * a) % (N * a) =
      (R % N) * a := by
    have hsmall : (R % N) * a < N * a :=
      (Nat.mul_lt_mul_right ha).mpr (Nat.mod_lt R hNpos)
    calc
      ((N * a) * (R / N) + (R % N) * a) % (N * a) =
          ((R % N) * a) % (N * a) := by
        simpa only [Nat.add_comm] using
          Nat.add_mul_mod_self_left ((R % N) * a) (N * a) (R / N)
      _ = (R % N) * a := Nat.mod_eq_of_lt hsmall
  unfold cyclicResidueDistance
  have hres' : R * a % (N * a) = (R % N) * a := by
    rw [hmul, hres]
  rw [hres']
  rw [hmod']
  by_cases hsone : s = 1
  · simp only [if_pos hsone]
    have hsubmul : (N - 1) * a = N * a - a := by
      rw [Nat.sub_mul, Nat.one_mul]
    rw [hsubmul]
    have hsum : a + a ≤ N * a := by
      calc
        a + a = 2 * a := (Nat.two_mul a).symm
        _ ≤ N * a := Nat.mul_le_mul_right a (by omega)
    have ha_le : a ≤ N * a - a := Nat.le_sub_of_add_le hsum
    rw [Nat.sub_sub_self (Nat.le_of_lt (by omega : a < N * a))]
    exact Nat.min_eq_right ha_le
  · simp only [if_neg hsone]
    have hsum : a + a ≤ N * a := by
      calc
        a + a = 2 * a := (Nat.two_mul a).symm
        _ ≤ N * a := Nat.mul_le_mul_right a (by omega)
    have ha_le : a ≤ N * a - a := Nat.le_sub_of_add_le hsum
    simpa only [Nat.one_mul] using Nat.min_eq_left ha_le

private theorem reverseGrid_X_mod_N (D : ReverseGridData) :
    Int.ModEq (D.N : ℤ) D.X (-D.s) := by
  unfold ReverseGridData.X
  simpa [sub_eq_add_neg] using
    ((Int.modulus_modEq_zero.mul_right D.Q).add_right (-D.s))

theorem reverseGrid_deleted_boundary (D : ReverseGridData) :
    cyclicResidueDistance (D.N * D.ak) (D.R * D.ak) = D.ak := by
  have hres : Int.ModEq (D.modulus : ℤ) D.X (D.R : ℤ) :=
    reverseGrid_residue_modEq D
  have hRmod : Int.ModEq (D.N : ℤ) (D.R : ℤ) (-D.s) := by
    have hdiv : (D.N : ℤ) ∣ (D.modulus : ℤ) := by
      refine ⟨(D.ak : ℤ), ?_⟩
      simp [ReverseGridData.modulus, mul_comm]
    exact hres.symm.of_dvd hdiv |>.trans (reverseGrid_X_mod_N D)
  have hn2 : 2 ≤ D.n := D.hn
  have hNtwo : 2 ≤ D.N := by rw [D.hN]; omega
  exact reverseGrid_boundary_of_modEq hNtwo D.hak D.hs hRmod

theorem reverseGrid_pivot_modEq (D : ReverseGridData) :
    Int.ModEq ((D.N * D.ak : ℕ) : ℤ)
      (((D.R * D.p : ℕ) : ℤ))
      (D.s * (((D.N * D.b : ℕ) : ℤ) - (D.p : ℤ))) := by
  have hcalc : D.X * (D.p : ℤ) =
      ((D.N * D.ak : ℕ) : ℤ) * D.z +
        D.s * (((D.N * D.b : ℕ) : ℤ) - (D.p : ℤ)) := by
    unfold ReverseGridData.X
    push_cast
    linear_combination -(D.N : ℤ) * D.hQ
  have hzero : Int.ModEq ((D.N * D.ak : ℕ) : ℤ)
      (((D.N * D.ak : ℕ) : ℤ) * D.z) 0 := by
    have hmod0 : Int.ModEq ((D.N * D.ak : ℕ) : ℤ)
        ((D.N * D.ak : ℕ) : ℤ) 0 := Int.modulus_modEq_zero
    have hz := hmod0.mul_right D.z
    simpa only [zero_mul] using hz
  have hxp : Int.ModEq ((D.N * D.ak : ℕ) : ℤ)
      (D.X * (D.p : ℤ))
      (((D.R * D.p : ℕ) : ℤ)) := by
    simpa [ReverseGridData.modulus, Int.natCast_mul] using
      (reverseGrid_residue_modEq D).mul_right (D.p : ℤ)
  rw [hcalc] at hxp
  have hsr : Int.ModEq ((D.N * D.ak : ℕ) : ℤ)
      (D.s * (((D.N * D.b : ℕ) : ℤ) - (D.p : ℤ)))
      (D.s * (((D.N * D.b : ℕ) : ℤ) - (D.p : ℤ))) := Int.ModEq.rfl
  have hsum := hzero.add hsr
  have hsum' : Int.ModEq ((D.N * D.ak : ℕ) : ℤ)
      (((D.N * D.ak : ℕ) : ℤ) * D.z +
        D.s * (((D.N * D.b : ℕ) : ℤ) - (D.p : ℤ)))
      (D.s * (((D.N * D.b : ℕ) : ℤ) - (D.p : ℤ))) := by
    simpa using hsum
  exact hxp.symm.trans hsum'

theorem reverseGrid_pivot_distance (D : ReverseGridData) :
    cyclicResidueDistance (D.N * D.ak) (D.R * D.p) =
      signedCyclicResidueDistance (D.N * D.ak)
        (((D.N * D.b : ℕ) : ℤ) - (D.p : ℤ)) := by
  have hM : 0 < D.modulus := reverseGrid_pos_modulus D
  have hdist : signedCyclicResidueDistance D.modulus
      (((D.R * D.p : ℕ) : ℤ)) =
      signedCyclicResidueDistance D.modulus
        (D.s * (((D.N * D.b : ℕ) : ℤ) - (D.p : ℤ))) :=
    signedCyclicResidueDistance_congr hM (reverseGrid_pivot_modEq D)
  change cyclicResidueDistance D.modulus (D.R * D.p) =
    signedCyclicResidueDistance D.modulus
      (((D.N * D.b : ℕ) : ℤ) - (D.p : ℤ))
  rw [← signedCyclicResidueDistance_ofNat hM]
  rw [hdist]
  rcases D.hs with hs | hs
  · rw [hs]
    simp
  · rw [hs]
    simpa [neg_mul] using
      signedCyclicResidueDistance_neg hM
        (((D.N * D.b : ℕ) : ℤ) - (D.p : ℤ))

end LonelyRunner
