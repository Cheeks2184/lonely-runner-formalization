import Mathlib.Data.ZMod.Basic
import Mathlib.Data.Nat.ModEq
import Mathlib.GroupTheory.Index
import Mathlib.GroupTheory.OrderOfElement
import Mathlib.Data.Finset.Card
import Mathlib.Tactic.Ring

/-!
# Simultaneous linear congruences

This module counts residues solving two linear congruences with a common
unknown and modulus.  It is independent of the Lonely Runner conjecture.
-/

namespace LonelyRunner

/-- The additive homomorphism whose fibers are simultaneous congruence
solution sets. -/
def simultaneousCongruenceHom (M b c : ℕ) :
    ZMod M →+ ZMod M × ZMod M where
  toFun r := ((b : ZMod M) * r, (c : ZMod M) * r)
  map_zero' := by simp
  map_add' r s := by simp [mul_add]

/-- Residue classes modulo `M` solving both congruences. -/
def simultaneousCongruenceZMod (M b c x y : ℕ) [NeZero M] : Finset (ZMod M) :=
  Finset.univ.filter fun r =>
    simultaneousCongruenceHom M b c r = ((x : ZMod M), (y : ZMod M))

/-- Canonical natural representatives `r < M` solving both congruences. -/
def simultaneousCongruenceResidues (M b c x y : ℕ) : Finset (Fin M) :=
  Finset.univ.filter fun r =>
    Nat.ModEq M (b * r.val) x ∧ Nat.ModEq M (c * r.val) y

/-- The exact compatibility predicate for two congruences.  The strengthened
cross modulus `M * gcd(M,b,c)` is essential; using only modulus `M` is not
sufficient when the three-way gcd is nontrivial. -/
def SimultaneousCongruenceCompatible (M b c x y : ℕ) : Prop :=
  let g := M.gcd (b.gcd c)
  g ∣ x ∧ g ∣ y ∧ Nat.ModEq (M * g) (c * x) (b * y)

theorem mem_simultaneousCongruenceResidues {M b c x y : ℕ} {r : Fin M} :
    r ∈ simultaneousCongruenceResidues M b c x y ↔
      Nat.ModEq M (b * r.val) x ∧ Nat.ModEq M (c * r.val) y := by
  simp [simultaneousCongruenceResidues]

private theorem finEquiv_apply_eq_natCast {M : ℕ} [NeZero M] (r : Fin M) :
    ZMod.finEquiv M r = (r.val : ZMod M) := by
  cases M with
  | zero => exact (NeZero.ne 0 rfl).elim
  | succ M =>
      apply Fin.ext
      change r.val = r.val % (M + 1)
      exact (Nat.mod_eq_of_lt r.isLt).symm

/-- The natural representative predicate is exactly the corresponding fiber
of the additive homomorphism on `ZMod M`. -/
theorem mem_simultaneousCongruenceResidues_iff_hom {M b c x y : ℕ}
    [NeZero M] {r : Fin M} :
    r ∈ simultaneousCongruenceResidues M b c x y ↔
      simultaneousCongruenceHom M b c (ZMod.finEquiv M r) =
        ((x : ZMod M), (y : ZMod M)) := by
  rw [mem_simultaneousCongruenceResidues, finEquiv_apply_eq_natCast]
  simp only [simultaneousCongruenceHom, AddMonoidHom.coe_mk,
    ZeroHom.coe_mk, Prod.mk.injEq, ← Nat.cast_mul]
  rw [ZMod.natCast_eq_natCast_iff, ZMod.natCast_eq_natCast_iff]

/-- A single homogeneous linear congruence has the standard divided-modulus
description. -/
theorem mul_modEq_zero_iff_div_gcd_dvd {M b r : ℕ} (hM : 0 < M) :
    Nat.ModEq M (b * r) 0 ↔ M / M.gcd b ∣ r := by
  constructor
  · intro h
    have h' : Nat.ModEq M (b * r) (b * 0) := by simpa using h
    have hcancel := h'.cancel_left_div_gcd hM
    simpa [Nat.modEq_zero_iff_dvd] using hcancel
  · intro hr
    let d := M.gcd b
    have hdM : d ∣ M := Nat.gcd_dvd_left M b
    have hdb : d ∣ b := Nat.gcd_dvd_right M b
    rcases hr with ⟨k, hk⟩
    apply Nat.modEq_zero_iff_dvd.mpr
    refine ⟨(b / d) * k, ?_⟩
    rw [hk]
    calc
      b * (M / d * k) = (d * (b / d)) * (M / d * k) := by
        rw [Nat.mul_div_cancel' hdb]
      _ = (d * (M / d)) * ((b / d) * k) := by ac_rfl
      _ = M * ((b / d) * k) := by
        rw [Nat.mul_div_cancel' hdM]

private theorem gcd_pair_eq_triple (M b c : ℕ) :
    (M.gcd b).gcd (M.gcd c) = M.gcd (b.gcd c) := by
  calc
    (M.gcd b).gcd (M.gcd c) = M.gcd (b.gcd (M.gcd c)) :=
      Nat.gcd_assoc M b (M.gcd c)
    _ = M.gcd (M.gcd (b.gcd c)) := by rw [Nat.gcd_left_comm b M c]
    _ = M.gcd (b.gcd c) := by rw [← Nat.gcd_assoc]; simp

/-- The simultaneous homogeneous kernel consists exactly of multiples of the
modulus divided by the three-way gcd. -/
theorem simultaneous_zero_iff_div_tripleGcd_dvd {M b c r : ℕ}
    (hM : 0 < M) :
    (Nat.ModEq M (b * r) 0 ∧ Nat.ModEq M (c * r) 0) ↔
      M / M.gcd (b.gcd c) ∣ r := by
  let db := M.gcd b
  let dc := M.gcd c
  have hdbM : db ∣ M := Nat.gcd_dvd_left M b
  have hdcM : dc ∣ M := Nat.gcd_dvd_left M c
  have hlcm : (M / db).lcm (M / dc) = M / M.gcd (b.gcd c) := by
    rw [Nat.div_lcm_eq_div_gcd hdbM hdcM, gcd_pair_eq_triple]
  rw [mul_modEq_zero_iff_div_gcd_dvd hM,
    mul_modEq_zero_iff_div_gcd_dvd hM]
  rw [← Nat.lcm_dvd_iff, hlcm]

/-- The homogeneous simultaneous congruence system has exactly the three-way
gcd many canonical residues. -/
theorem card_simultaneousCongruenceResidues_zero (M b c : ℕ) (hM : 0 < M) :
    (simultaneousCongruenceResidues M b c 0 0).card =
      M.gcd (b.gcd c) := by
  let g := M.gcd (b.gcd c)
  let q := M / g
  have hgM : g ∣ M := Nat.gcd_dvd_left M (b.gcd c)
  have hgPos : 0 < g := Nat.gcd_pos_of_pos_left (b.gcd c) hM
  have hgLe : g ≤ M := Nat.le_of_dvd hM hgM
  have hqPos : 0 < q := Nat.div_pos hgLe hgPos
  have hqg : q * g = M := Nat.div_mul_cancel hgM
  let e : ↥(simultaneousCongruenceResidues M b c 0 0) ≃ Fin g := {
    toFun r := by
      have hrzero :
          Nat.ModEq M (b * r.1.val) 0 ∧ Nat.ModEq M (c * r.1.val) 0 :=
        mem_simultaneousCongruenceResidues.mp r.2
      have hrdiv : q ∣ r.1.val := by
        simpa [q, g] using
          (simultaneous_zero_iff_div_tripleGcd_dvd hM).mp hrzero
      refine ⟨r.1.val / q, ?_⟩
      have hmul : q * (r.1.val / q) = r.1.val := Nat.mul_div_cancel' hrdiv
      have hlt : q * (r.1.val / q) < q * g := by
        rw [hmul, hqg]
        exact r.1.isLt
      exact (Nat.mul_lt_mul_left hqPos).mp hlt
    invFun k := by
      have hvalLt : k.val * q < M := by
        have hlt : q * k.val < q * g :=
          (Nat.mul_lt_mul_left hqPos).mpr k.isLt
        calc
          k.val * q = q * k.val := Nat.mul_comm _ _
          _ < q * g := hlt
          _ = M := hqg
      let r : Fin M := ⟨k.val * q, hvalLt⟩
      refine ⟨r, ?_⟩
      apply mem_simultaneousCongruenceResidues.mpr
      apply (simultaneous_zero_iff_div_tripleGcd_dvd hM).mpr
      change q ∣ r.val
      exact dvd_mul_left q k.val
    left_inv r := by
      apply Subtype.ext
      apply Fin.ext
      dsimp
      have hrzero :
          Nat.ModEq M (b * r.1.val) 0 ∧ Nat.ModEq M (c * r.1.val) 0 :=
        mem_simultaneousCongruenceResidues.mp r.2
      have hrdiv : q ∣ r.1.val := by
        simpa [q, g] using
          (simultaneous_zero_iff_div_tripleGcd_dvd hM).mp hrzero
      exact Nat.div_mul_cancel hrdiv
    right_inv k := by
      apply Fin.ext
      dsimp
      rw [Nat.mul_comm]
      exact Nat.mul_div_cancel_left k.val hqPos
  }
  simpa [g] using Fintype.card_congr e

/-- Every inhabited fiber of the simultaneous congruence homomorphism is a
translate of its homogeneous kernel and hence has the same cardinality. -/
theorem card_simultaneousCongruenceResidues_of_nonempty
    (M b c x y : ℕ) (hM : 0 < M)
    (hnonempty : (simultaneousCongruenceResidues M b c x y).Nonempty) :
    (simultaneousCongruenceResidues M b c x y).card =
      M.gcd (b.gcd c) := by
  letI : NeZero M := ⟨hM.ne'⟩
  obtain ⟨r₀, hr₀⟩ := hnonempty
  have hr₀hom :=
    (mem_simultaneousCongruenceResidues_iff_hom (r := r₀)).mp hr₀
  let e : ↥(simultaneousCongruenceResidues M b c x y) ≃
      ↥(simultaneousCongruenceResidues M b c 0 0) := {
    toFun r := by
      let z : ZMod M := ZMod.finEquiv M r.1 - ZMod.finEquiv M r₀
      refine ⟨(ZMod.finEquiv M).symm z, ?_⟩
      apply mem_simultaneousCongruenceResidues_iff_hom.mpr
      have hrhom :=
        (mem_simultaneousCongruenceResidues_iff_hom (r := r.1)).mp r.2
      change simultaneousCongruenceHom M b c
        (ZMod.finEquiv M ((ZMod.finEquiv M).symm z)) =
          (((0 : ℕ) : ZMod M), ((0 : ℕ) : ZMod M))
      rw [(ZMod.finEquiv M).apply_symm_apply]
      dsimp only [z]
      rw [map_sub, hrhom, hr₀hom]
      apply Prod.ext <;> simp
    invFun k := by
      let z : ZMod M := ZMod.finEquiv M k.1 + ZMod.finEquiv M r₀
      refine ⟨(ZMod.finEquiv M).symm z, ?_⟩
      apply mem_simultaneousCongruenceResidues_iff_hom.mpr
      have hkhom :=
        (mem_simultaneousCongruenceResidues_iff_hom (r := k.1)).mp k.2
      simp [z, map_add, hkhom, hr₀hom]
    left_inv r := by
      apply Subtype.ext
      dsimp
      rw [(ZMod.finEquiv M).apply_symm_apply]
      rw [sub_add_cancel]
      exact (ZMod.finEquiv M).symm_apply_apply r.1
    right_inv k := by
      apply Subtype.ext
      dsimp
      rw [(ZMod.finEquiv M).apply_symm_apply]
      rw [add_sub_cancel_right]
      exact (ZMod.finEquiv M).symm_apply_apply k.1
  }
  calc
    (simultaneousCongruenceResidues M b c x y).card =
        (simultaneousCongruenceResidues M b c 0 0).card := by
      simpa using Fintype.card_congr e
    _ = M.gcd (b.gcd c) :=
      card_simultaneousCongruenceResidues_zero M b c hM

/-- The audited divisibility and strengthened cross-congruence conditions are
sufficient for a simultaneous solution. -/
theorem simultaneousCongruenceResidues_nonempty_of_compatible
    (M b c x y : ℕ) (hM : 0 < M)
    (hcompat : SimultaneousCongruenceCompatible M b c x y) :
    (simultaneousCongruenceResidues M b c x y).Nonempty := by
  let g := M.gcd (b.gcd c)
  have hgM : g ∣ M := Nat.gcd_dvd_left M (b.gcd c)
  have hgb : g ∣ b :=
    dvd_trans (Nat.gcd_dvd_right M (b.gcd c)) (Nat.gcd_dvd_left b c)
  have hgc : g ∣ c :=
    dvd_trans (Nat.gcd_dvd_right M (b.gcd c)) (Nat.gcd_dvd_right b c)
  have hgPos : 0 < g := Nat.gcd_pos_of_pos_left (b.gcd c) hM
  rcases hcompat with ⟨hx, hy, hcross⟩
  change g ∣ x at hx
  change g ∣ y at hy
  rcases hx with ⟨X, rfl⟩
  rcases hy with ⟨Y, rfl⟩
  have hcross' : Nat.ModEq (M * g) (g * (c * X)) (g * (b * Y)) := by
    simpa [mul_assoc, mul_comm, mul_left_comm] using hcross
  have hgcd : (M * g).gcd g = g :=
    Nat.gcd_eq_right_iff_dvd.mpr (dvd_mul_left g M)
  have hcrossM : Nat.ModEq M (c * X) (b * Y) := by
    have hcancel := hcross'.cancel_left_div_gcd (Nat.mul_pos hM hgPos)
    have hdiv : M * g / g = M := by
      simpa [mul_comm] using Nat.mul_div_right M hgPos
    rw [hgcd, hdiv] at hcancel
    exact hcancel

  let d := b.gcd c
  let A : ℤ := M.gcdA d
  let B : ℤ := M.gcdB d
  let C : ℤ := b.gcdA c
  let D : ℤ := b.gcdB c
  let V : ℤ := B * C
  let W : ℤ := B * D
  have hbez : (g : ℤ) =
      (M : ℤ) * A + (b : ℤ) * V + (c : ℤ) * W := by
    calc
      (g : ℤ) = (M : ℤ) * A + (d : ℤ) * B := by
        simpa [g, d, A, B] using Nat.gcd_eq_gcd_ab M d
      _ = (M : ℤ) * A + (b : ℤ) * V + (c : ℤ) * W := by
        have hdbez : (d : ℤ) = (b : ℤ) * C + (c : ℤ) * D := by
          simpa [d, C, D] using Nat.gcd_eq_gcd_ab b c
        rw [hdbez]
        simp [V, W]
        ring

  letI : NeZero M := ⟨hM.ne'⟩
  have hbezZ : (g : ZMod M) =
      (b : ZMod M) * (V : ZMod M) + (c : ZMod M) * (W : ZMod M) := by
    have hz := congrArg (fun z : ℤ => (z : ZMod M)) hbez
    simpa using hz
  have hcrossZ : (c : ZMod M) * (X : ZMod M) =
      (b : ZMod M) * (Y : ZMod M) := by
    rw [← Nat.cast_mul, ← Nat.cast_mul]
    exact (ZMod.natCast_eq_natCast_iff _ _ _).mpr hcrossM
  have hbV : (b : ZMod M) * (V : ZMod M) =
      (g : ZMod M) - (c : ZMod M) * (W : ZMod M) :=
    eq_sub_of_add_eq hbezZ.symm
  have hcW : (c : ZMod M) * (W : ZMod M) =
      (g : ZMod M) - (b : ZMod M) * (V : ZMod M) := by
    rw [add_comm] at hbezZ
    exact eq_sub_of_add_eq hbezZ.symm
  let rZ : ZMod M :=
    (V : ZMod M) * (X : ZMod M) + (W : ZMod M) * (Y : ZMod M)
  have hfirst : (b : ZMod M) * rZ = ((g * X : ℕ) : ZMod M) := by
    rw [Nat.cast_mul]
    simp only [rZ, mul_add]
    rw [← mul_assoc, hbV]
    calc
      ((g : ZMod M) - (c : ZMod M) * (W : ZMod M)) * (X : ZMod M) +
          (b : ZMod M) * ((W : ZMod M) * (Y : ZMod M)) =
          ((g : ZMod M) - (c : ZMod M) * (W : ZMod M)) * (X : ZMod M) +
            (W : ZMod M) * ((b : ZMod M) * (Y : ZMod M)) := by ring
      _ = ((g : ZMod M) - (c : ZMod M) * (W : ZMod M)) * (X : ZMod M) +
            (W : ZMod M) * ((c : ZMod M) * (X : ZMod M)) := by rw [hcrossZ]
      _ = (g : ZMod M) * (X : ZMod M) := by ring
  have hsecond : (c : ZMod M) * rZ = ((g * Y : ℕ) : ZMod M) := by
    rw [Nat.cast_mul]
    simp only [rZ, mul_add]
    calc
      (c : ZMod M) * ((V : ZMod M) * (X : ZMod M)) +
          (c : ZMod M) * ((W : ZMod M) * (Y : ZMod M)) =
          (V : ZMod M) * ((c : ZMod M) * (X : ZMod M)) +
            ((c : ZMod M) * (W : ZMod M)) * (Y : ZMod M) := by ring
      _ = (V : ZMod M) * ((b : ZMod M) * (Y : ZMod M)) +
            ((g : ZMod M) - (b : ZMod M) * (V : ZMod M)) * (Y : ZMod M) := by
          rw [hcrossZ, hcW]
      _ = (g : ZMod M) * (Y : ZMod M) := by ring
  let r : Fin M := (ZMod.finEquiv M).symm rZ
  refine ⟨r, mem_simultaneousCongruenceResidues_iff_hom.mpr ?_⟩
  rw [show ZMod.finEquiv M r = rZ by
    exact (ZMod.finEquiv M).apply_symm_apply rZ]
  exact Prod.ext hfirst hsecond

/-- Every simultaneous solution satisfies the two gcd divisibilities and the
strengthened cross congruence modulo `M * gcd(M,b,c)`. -/
theorem compatible_of_mem_simultaneousCongruenceResidues
    {M b c x y : ℕ} (r : Fin M)
    (hr : r ∈ simultaneousCongruenceResidues M b c x y) :
    SimultaneousCongruenceCompatible M b c x y := by
  let g := M.gcd (b.gcd c)
  have hgM : g ∣ M := Nat.gcd_dvd_left M (b.gcd c)
  have hgb : g ∣ b :=
    dvd_trans (Nat.gcd_dvd_right M (b.gcd c)) (Nat.gcd_dvd_left b c)
  have hgc : g ∣ c :=
    dvd_trans (Nat.gcd_dvd_right M (b.gcd c)) (Nat.gcd_dvd_right b c)
  obtain ⟨hbmod, hcmod⟩ := mem_simultaneousCongruenceResidues.mp hr
  change g ∣ x ∧ g ∣ y ∧ Nat.ModEq (M * g) (c * x) (b * y)
  refine ⟨(hbmod.dvd_iff hgM).mp (dvd_mul_of_dvd_left hgb r.val),
    (hcmod.dvd_iff hgM).mp (dvd_mul_of_dvd_left hgc r.val), ?_⟩
  rw [Nat.modEq_iff_dvd]
  have hgbInt : (g : ℤ) ∣ (b : ℤ) := Int.natCast_dvd_natCast.mpr hgb
  have hgcInt : (g : ℤ) ∣ (c : ℤ) := Int.natCast_dvd_natCast.mpr hgc
  have hy : (M : ℤ) ∣ (y : ℤ) - (c * r.val : ℕ) := hcmod.dvd
  have hx : (M : ℤ) ∣ (x : ℤ) - (b * r.val : ℕ) := hbmod.dvd
  have hyb : (M : ℤ) * (g : ℤ) ∣
      ((y : ℤ) - (c * r.val : ℕ)) * (b : ℤ) :=
    Int.mul_dvd_mul hy hgbInt
  have hxc : (M : ℤ) * (g : ℤ) ∣
      ((x : ℤ) - (b * r.val : ℕ)) * (c : ℤ) :=
    Int.mul_dvd_mul hx hgcInt
  change (M : ℤ) * (g : ℤ) ∣ (b * y : ℕ) - (c * x : ℕ)
  convert dvd_sub hyb hxc using 1
  · rfl
  · push_cast
    ring

/-- Compatibility is equivalent to existence of a canonical simultaneous
residue when the modulus is positive. -/
theorem simultaneousCongruenceCompatible_iff_nonempty
    (M b c x y : ℕ) (hM : 0 < M) :
    SimultaneousCongruenceCompatible M b c x y ↔
      (simultaneousCongruenceResidues M b c x y).Nonempty := by
  constructor
  · exact simultaneousCongruenceResidues_nonempty_of_compatible M b c x y hM
  · rintro ⟨r, hr⟩
    exact compatible_of_mem_simultaneousCongruenceResidues r hr

instance (M b c x y : ℕ) :
    Decidable (SimultaneousCongruenceCompatible M b c x y) := by
  unfold SimultaneousCongruenceCompatible
  infer_instance

/-- Exact simultaneous-congruence count.  Compatible targets have one full
coset of the homogeneous kernel; incompatible targets have no solutions. -/
theorem card_simultaneousCongruenceResidues
    (M b c x y : ℕ) (hM : 0 < M) :
    (simultaneousCongruenceResidues M b c x y).card =
      if SimultaneousCongruenceCompatible M b c x y then
        M.gcd (b.gcd c)
      else 0 := by
  classical
  by_cases hcompat : SimultaneousCongruenceCompatible M b c x y
  · rw [if_pos hcompat]
    exact card_simultaneousCongruenceResidues_of_nonempty M b c x y hM
      (simultaneousCongruenceResidues_nonempty_of_compatible
        M b c x y hM hcompat)
  · rw [if_neg hcompat]
    apply Finset.card_eq_zero.mpr
    rw [Finset.eq_empty_iff_forall_notMem]
    intro r hr
    exact hcompat (compatible_of_mem_simultaneousCongruenceResidues r hr)

/-- Convenient compatible branch of the exact count. -/
theorem card_simultaneousCongruenceResidues_of_compatible
    (M b c x y : ℕ) (hM : 0 < M)
    (hcompat : SimultaneousCongruenceCompatible M b c x y) :
    (simultaneousCongruenceResidues M b c x y).card =
      M.gcd (b.gcd c) := by
  rw [card_simultaneousCongruenceResidues M b c x y hM, if_pos hcompat]

/-- Convenient incompatible branch of the exact count. -/
theorem card_simultaneousCongruenceResidues_of_not_compatible
    (M b c x y : ℕ) (hM : 0 < M)
    (hcompat : ¬SimultaneousCongruenceCompatible M b c x y) :
    (simultaneousCongruenceResidues M b c x y).card = 0 := by
  rw [card_simultaneousCongruenceResidues M b c x y hM, if_neg hcompat]

end LonelyRunner
