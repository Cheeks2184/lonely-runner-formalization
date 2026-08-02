import LonelyRunner.SimultaneousCongruence
import Mathlib.Tactic.Ring

/-!
# Three simultaneous linear congruences

This module counts canonical residues solving three linear congruences with a
common unknown and modulus.  Its compatibility predicate retains the
strengthened modulus `M * gcd(M,a,b,c)` in all three pairwise cross
congruences.  No coefficient is assumed nonzero.
-/

namespace LonelyRunner

/-- The additive homomorphism associated with three common-unknown linear
congruences. -/
def tripleCongruenceHom (M a b c : ℕ) :
    ZMod M →+ ZMod M × ZMod M × ZMod M where
  toFun r := ((a : ZMod M) * r, (b : ZMod M) * r, (c : ZMod M) * r)
  map_zero' := by simp
  map_add' r s := by simp [mul_add]

/-- Canonical representatives solving three congruences modulo `M`. -/
def tripleCongruenceResidues
    (M a b c x y z : ℕ) : Finset (Fin M) :=
  Finset.univ.filter fun r =>
    Nat.ModEq M (a * r.val) x ∧
      Nat.ModEq M (b * r.val) y ∧
      Nat.ModEq M (c * r.val) z

/-- Exact audited compatibility for three congruences. -/
def TripleCongruenceCompatible
    (M a b c x y z : ℕ) : Prop :=
  let g := M.gcd (a.gcd (b.gcd c))
  g ∣ x ∧ g ∣ y ∧ g ∣ z ∧
    Nat.ModEq (M * g) (b * x) (a * y) ∧
    Nat.ModEq (M * g) (c * x) (a * z) ∧
    Nat.ModEq (M * g) (c * y) (b * z)

theorem mem_tripleCongruenceResidues
    {M a b c x y z : ℕ} {r : Fin M} :
    r ∈ tripleCongruenceResidues M a b c x y z ↔
      Nat.ModEq M (a * r.val) x ∧
      Nat.ModEq M (b * r.val) y ∧
      Nat.ModEq M (c * r.val) z := by
  simp [tripleCongruenceResidues]

private theorem finEquiv_apply_eq_natCast_triple
    {M : ℕ} [NeZero M] (r : Fin M) :
    ZMod.finEquiv M r = (r.val : ZMod M) := by
  cases M with
  | zero => exact (NeZero.ne 0 rfl).elim
  | succ M =>
      apply Fin.ext
      change r.val = r.val % (M + 1)
      exact (Nat.mod_eq_of_lt r.isLt).symm

theorem mem_tripleCongruenceResidues_iff_hom
    {M a b c x y z : ℕ} [NeZero M] {r : Fin M} :
    r ∈ tripleCongruenceResidues M a b c x y z ↔
      tripleCongruenceHom M a b c (ZMod.finEquiv M r) =
        ((x : ZMod M), (y : ZMod M), (z : ZMod M)) := by
  rw [mem_tripleCongruenceResidues,
    finEquiv_apply_eq_natCast_triple]
  simp only [tripleCongruenceHom, AddMonoidHom.coe_mk,
    ZeroHom.coe_mk, Prod.mk.injEq, ← Nat.cast_mul]
  rw [ZMod.natCast_eq_natCast_iff, ZMod.natCast_eq_natCast_iff,
    ZMod.natCast_eq_natCast_iff]

private theorem gcd_pairwise_eq_fourfold (M a b c : ℕ) :
    (M.gcd (a.gcd b)).gcd (M.gcd c) =
      M.gcd (a.gcd (b.gcd c)) := by
  calc
    (M.gcd (a.gcd b)).gcd (M.gcd c) =
        M.gcd ((a.gcd b).gcd (M.gcd c)) :=
      Nat.gcd_assoc M (a.gcd b) (M.gcd c)
    _ = M.gcd (M.gcd ((a.gcd b).gcd c)) := by
      rw [Nat.gcd_left_comm (a.gcd b) M c]
    _ = M.gcd ((a.gcd b).gcd c) := by
      rw [← Nat.gcd_assoc]
      simp
    _ = M.gcd (a.gcd (b.gcd c)) := by
      rw [Nat.gcd_assoc]

/-- The homogeneous triple system is exactly the set of multiples of the
modulus divided by the four-way gcd. -/
theorem triple_zero_iff_div_fourfoldGcd_dvd
    {M a b c r : ℕ} (hM : 0 < M) :
    (Nat.ModEq M (a * r) 0 ∧
      Nat.ModEq M (b * r) 0 ∧
      Nat.ModEq M (c * r) 0) ↔
      M / M.gcd (a.gcd (b.gcd c)) ∣ r := by
  let dab := M.gcd (a.gcd b)
  let dc := M.gcd c
  have hdabM : dab ∣ M := Nat.gcd_dvd_left M (a.gcd b)
  have hdcM : dc ∣ M := Nat.gcd_dvd_left M c
  have hlcm : (M / dab).lcm (M / dc) =
      M / M.gcd (a.gcd (b.gcd c)) := by
    rw [Nat.div_lcm_eq_div_gcd hdabM hdcM,
      gcd_pairwise_eq_fourfold]
  rw [← and_assoc,
    simultaneous_zero_iff_div_tripleGcd_dvd (M := M) (b := a) (c := b) hM,
    mul_modEq_zero_iff_div_gcd_dvd hM]
  rw [← Nat.lcm_dvd_iff, hlcm]

/-- The homogeneous triple fiber has exactly `gcd(M,a,b,c)` canonical
residues, including when any or all coefficients vanish. -/
theorem card_tripleCongruenceResidues_zero
    (M a b c : ℕ) (hM : 0 < M) :
    (tripleCongruenceResidues M a b c 0 0 0).card =
      M.gcd (a.gcd (b.gcd c)) := by
  let g := M.gcd (a.gcd (b.gcd c))
  let q := M / g
  have hgM : g ∣ M := Nat.gcd_dvd_left M (a.gcd (b.gcd c))
  have hgPos : 0 < g := Nat.gcd_pos_of_pos_left (a.gcd (b.gcd c)) hM
  have hgLe : g ≤ M := Nat.le_of_dvd hM hgM
  have hqPos : 0 < q := Nat.div_pos hgLe hgPos
  have hqg : q * g = M := Nat.div_mul_cancel hgM
  let e : ↑(tripleCongruenceResidues M a b c 0 0 0) ≃ Fin g := {
    toFun r := by
      have hrzero := mem_tripleCongruenceResidues.mp r.2
      have hrdiv : q ∣ r.1.val := by
        simpa [q, g] using
          (triple_zero_iff_div_fourfoldGcd_dvd hM).mp hrzero
      refine ⟨r.1.val / q, ?_⟩
      have hmul : q * (r.1.val / q) = r.1.val :=
        Nat.mul_div_cancel' hrdiv
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
      apply mem_tripleCongruenceResidues.mpr
      apply (triple_zero_iff_div_fourfoldGcd_dvd hM).mpr
      change q ∣ r.val
      exact dvd_mul_left q k.val
    left_inv r := by
      apply Subtype.ext
      apply Fin.ext
      dsimp
      have hrzero := mem_tripleCongruenceResidues.mp r.2
      have hrdiv : q ∣ r.1.val := by
        simpa [q, g] using
          (triple_zero_iff_div_fourfoldGcd_dvd hM).mp hrzero
      exact Nat.div_mul_cancel hrdiv
    right_inv k := by
      apply Fin.ext
      dsimp
      rw [Nat.mul_comm]
      exact Nat.mul_div_cancel_left k.val hqPos
  }
  simpa [g] using Fintype.card_congr e

/-- Every inhabited triple fiber is a translate of the homogeneous fiber. -/
theorem card_tripleCongruenceResidues_of_nonempty
    (M a b c x y z : ℕ) (hM : 0 < M)
    (hnonempty : (tripleCongruenceResidues M a b c x y z).Nonempty) :
    (tripleCongruenceResidues M a b c x y z).card =
      M.gcd (a.gcd (b.gcd c)) := by
  letI : NeZero M := ⟨hM.ne'⟩
  obtain ⟨r₀, hr₀⟩ := hnonempty
  have hr₀hom :=
    (mem_tripleCongruenceResidues_iff_hom (r := r₀)).mp hr₀
  let e : ↑(tripleCongruenceResidues M a b c x y z) ≃
      ↑(tripleCongruenceResidues M a b c 0 0 0) := {
    toFun r := by
      let w : ZMod M := ZMod.finEquiv M r.1 - ZMod.finEquiv M r₀
      refine ⟨(ZMod.finEquiv M).symm w, ?_⟩
      apply mem_tripleCongruenceResidues_iff_hom.mpr
      have hrhom :=
        (mem_tripleCongruenceResidues_iff_hom (r := r.1)).mp r.2
      change tripleCongruenceHom M a b c
        (ZMod.finEquiv M ((ZMod.finEquiv M).symm w)) =
          (((0 : ℕ) : ZMod M), ((0 : ℕ) : ZMod M),
            ((0 : ℕ) : ZMod M))
      rw [(ZMod.finEquiv M).apply_symm_apply]
      dsimp only [w]
      rw [map_sub, hrhom, hr₀hom]
      apply Prod.ext
      · simp
      · apply Prod.ext <;> simp
    invFun k := by
      let w : ZMod M := ZMod.finEquiv M k.1 + ZMod.finEquiv M r₀
      refine ⟨(ZMod.finEquiv M).symm w, ?_⟩
      apply mem_tripleCongruenceResidues_iff_hom.mpr
      have hkhom :=
        (mem_tripleCongruenceResidues_iff_hom (r := k.1)).mp k.2
      simp [w, map_add, hkhom, hr₀hom]
    left_inv r := by
      apply Subtype.ext
      dsimp
      rw [(ZMod.finEquiv M).apply_symm_apply, sub_add_cancel]
      exact (ZMod.finEquiv M).symm_apply_apply r.1
    right_inv k := by
      apply Subtype.ext
      dsimp
      rw [(ZMod.finEquiv M).apply_symm_apply, add_sub_cancel_right]
      exact (ZMod.finEquiv M).symm_apply_apply k.1
  }
  calc
    (tripleCongruenceResidues M a b c x y z).card =
        (tripleCongruenceResidues M a b c 0 0 0).card := by
      simpa using Fintype.card_congr e
    _ = M.gcd (a.gcd (b.gcd c)) :=
      card_tripleCongruenceResidues_zero M a b c hM

private theorem cancel_scaled_cross
    {M g u v : ℕ} (hM : 0 < M) (hg : 0 < g)
    (h : Nat.ModEq (M * g) (g * u) (g * v)) :
    Nat.ModEq M u v := by
  have hgcd : (M * g).gcd g = g :=
    Nat.gcd_eq_right_iff_dvd.mpr (dvd_mul_left g M)
  have hcancel := h.cancel_left_div_gcd (Nat.mul_pos hM hg)
  have hdiv : M * g / g = M := by
    simpa [Nat.mul_comm] using Nat.mul_div_right M hg
  rw [hgcd, hdiv] at hcancel
  exact hcancel

/-- The divisibility and all three strengthened cross congruences construct
an actual common solution. -/
theorem tripleCongruenceResidues_nonempty_of_compatible
    (M a b c x y z : ℕ) (hM : 0 < M)
    (hcompat : TripleCongruenceCompatible M a b c x y z) :
    (tripleCongruenceResidues M a b c x y z).Nonempty := by
  let g := M.gcd (a.gcd (b.gcd c))
  have hgPos : 0 < g :=
    Nat.gcd_pos_of_pos_left (a.gcd (b.gcd c)) hM
  rcases hcompat with ⟨hx, hy, hz, hxy, hxz, hyz⟩
  change g ∣ x at hx
  change g ∣ y at hy
  change g ∣ z at hz
  rcases hx with ⟨X, rfl⟩
  rcases hy with ⟨Y, rfl⟩
  rcases hz with ⟨Z, rfl⟩
  have hxyScaled :
      Nat.ModEq (M * g) (g * (b * X)) (g * (a * Y)) := by
    simpa [Nat.mul_assoc, Nat.mul_comm, Nat.mul_left_comm] using hxy
  have hxzScaled :
      Nat.ModEq (M * g) (g * (c * X)) (g * (a * Z)) := by
    simpa [Nat.mul_assoc, Nat.mul_comm, Nat.mul_left_comm] using hxz
  have hyzScaled :
      Nat.ModEq (M * g) (g * (c * Y)) (g * (b * Z)) := by
    simpa [Nat.mul_assoc, Nat.mul_comm, Nat.mul_left_comm] using hyz
  have hxyM : Nat.ModEq M (b * X) (a * Y) :=
    cancel_scaled_cross hM hgPos hxyScaled
  have hxzM : Nat.ModEq M (c * X) (a * Z) :=
    cancel_scaled_cross hM hgPos hxzScaled
  have hyzM : Nat.ModEq M (c * Y) (b * Z) :=
    cancel_scaled_cross hM hgPos hyzScaled

  let d := b.gcd c
  let e := a.gcd d
  let A : ℤ := M.gcdA e
  let B : ℤ := M.gcdB e
  let C : ℤ := a.gcdA d
  let D : ℤ := a.gcdB d
  let E : ℤ := b.gcdA c
  let F : ℤ := b.gcdB c
  let U : ℤ := B * C
  let V : ℤ := B * D * E
  let W : ℤ := B * D * F
  have hbez : (g : ℤ) =
      (M : ℤ) * A + (a : ℤ) * U +
        (b : ℤ) * V + (c : ℤ) * W := by
    have heBez : (e : ℤ) = (a : ℤ) * C + (d : ℤ) * D := by
      simpa [e, C, D] using Nat.gcd_eq_gcd_ab a d
    have hdBez : (d : ℤ) = (b : ℤ) * E + (c : ℤ) * F := by
      simpa [d, E, F] using Nat.gcd_eq_gcd_ab b c
    calc
      (g : ℤ) = (M : ℤ) * A + (e : ℤ) * B := by
        simpa [g, e, A, B] using Nat.gcd_eq_gcd_ab M e
      _ = (M : ℤ) * A + (a : ℤ) * U +
          (b : ℤ) * V + (c : ℤ) * W := by
        rw [heBez, hdBez]
        simp [U, V, W]
        ring

  letI : NeZero M := ⟨hM.ne'⟩
  have hbezZ : (g : ZMod M) =
      (a : ZMod M) * (U : ZMod M) +
        (b : ZMod M) * (V : ZMod M) +
        (c : ZMod M) * (W : ZMod M) := by
    have hcast := congrArg (fun t : ℤ => (t : ZMod M)) hbez
    simpa using hcast
  have hxyZ : (b : ZMod M) * (X : ZMod M) =
      (a : ZMod M) * (Y : ZMod M) := by
    rw [← Nat.cast_mul, ← Nat.cast_mul]
    exact (ZMod.natCast_eq_natCast_iff _ _ _).mpr hxyM
  have hxzZ : (c : ZMod M) * (X : ZMod M) =
      (a : ZMod M) * (Z : ZMod M) := by
    rw [← Nat.cast_mul, ← Nat.cast_mul]
    exact (ZMod.natCast_eq_natCast_iff _ _ _).mpr hxzM
  have hyzZ : (c : ZMod M) * (Y : ZMod M) =
      (b : ZMod M) * (Z : ZMod M) := by
    rw [← Nat.cast_mul, ← Nat.cast_mul]
    exact (ZMod.natCast_eq_natCast_iff _ _ _).mpr hyzM
  let rZ : ZMod M :=
    (U : ZMod M) * (X : ZMod M) +
      (V : ZMod M) * (Y : ZMod M) +
      (W : ZMod M) * (Z : ZMod M)
  have hfirst : (a : ZMod M) * rZ = ((g * X : ℕ) : ZMod M) := by
    rw [Nat.cast_mul]
    calc
      (a : ZMod M) * rZ =
          ((a : ZMod M) * (U : ZMod M)) * (X : ZMod M) +
          (V : ZMod M) * ((a : ZMod M) * (Y : ZMod M)) +
          (W : ZMod M) * ((a : ZMod M) * (Z : ZMod M)) := by
        simp [rZ]
        ring
      _ = ((a : ZMod M) * (U : ZMod M)) * (X : ZMod M) +
          (V : ZMod M) * ((b : ZMod M) * (X : ZMod M)) +
          (W : ZMod M) * ((c : ZMod M) * (X : ZMod M)) := by
        rw [← hxyZ, ← hxzZ]
      _ = ((a : ZMod M) * (U : ZMod M) +
          (b : ZMod M) * (V : ZMod M) +
          (c : ZMod M) * (W : ZMod M)) * (X : ZMod M) := by ring
      _ = (g : ZMod M) * (X : ZMod M) := by rw [← hbezZ]
  have hsecond : (b : ZMod M) * rZ = ((g * Y : ℕ) : ZMod M) := by
    rw [Nat.cast_mul]
    calc
      (b : ZMod M) * rZ =
          (U : ZMod M) * ((b : ZMod M) * (X : ZMod M)) +
          ((b : ZMod M) * (V : ZMod M)) * (Y : ZMod M) +
          (W : ZMod M) * ((b : ZMod M) * (Z : ZMod M)) := by
        simp [rZ]
        ring
      _ = (U : ZMod M) * ((a : ZMod M) * (Y : ZMod M)) +
          ((b : ZMod M) * (V : ZMod M)) * (Y : ZMod M) +
          (W : ZMod M) * ((c : ZMod M) * (Y : ZMod M)) := by
        rw [hxyZ, ← hyzZ]
      _ = ((a : ZMod M) * (U : ZMod M) +
          (b : ZMod M) * (V : ZMod M) +
          (c : ZMod M) * (W : ZMod M)) * (Y : ZMod M) := by ring
      _ = (g : ZMod M) * (Y : ZMod M) := by rw [← hbezZ]
  have hthird : (c : ZMod M) * rZ = ((g * Z : ℕ) : ZMod M) := by
    rw [Nat.cast_mul]
    calc
      (c : ZMod M) * rZ =
          (U : ZMod M) * ((c : ZMod M) * (X : ZMod M)) +
          (V : ZMod M) * ((c : ZMod M) * (Y : ZMod M)) +
          ((c : ZMod M) * (W : ZMod M)) * (Z : ZMod M) := by
        simp [rZ]
        ring
      _ = (U : ZMod M) * ((a : ZMod M) * (Z : ZMod M)) +
          (V : ZMod M) * ((b : ZMod M) * (Z : ZMod M)) +
          ((c : ZMod M) * (W : ZMod M)) * (Z : ZMod M) := by
        rw [hxzZ, hyzZ]
      _ = ((a : ZMod M) * (U : ZMod M) +
          (b : ZMod M) * (V : ZMod M) +
          (c : ZMod M) * (W : ZMod M)) * (Z : ZMod M) := by ring
      _ = (g : ZMod M) * (Z : ZMod M) := by rw [← hbezZ]
  let r : Fin M := (ZMod.finEquiv M).symm rZ
  refine ⟨r, mem_tripleCongruenceResidues_iff_hom.mpr ?_⟩
  rw [show ZMod.finEquiv M r = rZ by
    exact (ZMod.finEquiv M).apply_symm_apply rZ]
  exact Prod.ext hfirst (Prod.ext hsecond hthird)

/-- Every triple solution satisfies the four-way gcd divisibilities and all
three strengthened pairwise cross congruences. -/
theorem compatible_of_mem_tripleCongruenceResidues
    {M a b c x y z : ℕ} (r : Fin M)
    (hr : r ∈ tripleCongruenceResidues M a b c x y z) :
    TripleCongruenceCompatible M a b c x y z := by
  let g := M.gcd (a.gcd (b.gcd c))
  have hgM : g ∣ M := Nat.gcd_dvd_left M (a.gcd (b.gcd c))
  have hgabc : g ∣ a.gcd (b.gcd c) :=
    Nat.gcd_dvd_right M (a.gcd (b.gcd c))
  have hga : g ∣ a :=
    dvd_trans hgabc (Nat.gcd_dvd_left a (b.gcd c))
  have hgbc : g ∣ b.gcd c :=
    dvd_trans hgabc (Nat.gcd_dvd_right a (b.gcd c))
  have hgb : g ∣ b := dvd_trans hgbc (Nat.gcd_dvd_left b c)
  have hgc : g ∣ c := dvd_trans hgbc (Nat.gcd_dvd_right b c)
  obtain ⟨hamod, hbmod, hcmod⟩ := mem_tripleCongruenceResidues.mp hr
  have habCompat : SimultaneousCongruenceCompatible M a b x y :=
    compatible_of_mem_simultaneousCongruenceResidues r
      (mem_simultaneousCongruenceResidues.mpr ⟨hamod, hbmod⟩)
  have hacCompat : SimultaneousCongruenceCompatible M a c x z :=
    compatible_of_mem_simultaneousCongruenceResidues r
      (mem_simultaneousCongruenceResidues.mpr ⟨hamod, hcmod⟩)
  have hbcCompat : SimultaneousCongruenceCompatible M b c y z :=
    compatible_of_mem_simultaneousCongruenceResidues r
      (mem_simultaneousCongruenceResidues.mpr ⟨hbmod, hcmod⟩)
  have habCross : Nat.ModEq (M * M.gcd (a.gcd b)) (b * x) (a * y) :=
    habCompat.2.2
  have hacCross : Nat.ModEq (M * M.gcd (a.gcd c)) (c * x) (a * z) :=
    hacCompat.2.2
  have hbcCross : Nat.ModEq (M * M.gcd (b.gcd c)) (c * y) (b * z) :=
    hbcCompat.2.2
  have hgAB : g ∣ M.gcd (a.gcd b) :=
    Nat.dvd_gcd hgM (Nat.dvd_gcd hga hgb)
  have hgAC : g ∣ M.gcd (a.gcd c) :=
    Nat.dvd_gcd hgM (Nat.dvd_gcd hga hgc)
  have hgBC : g ∣ M.gcd (b.gcd c) :=
    Nat.dvd_gcd hgM (Nat.dvd_gcd hgb hgc)
  change g ∣ x ∧ g ∣ y ∧ g ∣ z ∧
    Nat.ModEq (M * g) (b * x) (a * y) ∧
    Nat.ModEq (M * g) (c * x) (a * z) ∧
    Nat.ModEq (M * g) (c * y) (b * z)
  refine ⟨(hamod.dvd_iff hgM).mp (dvd_mul_of_dvd_left hga r.val),
    (hbmod.dvd_iff hgM).mp (dvd_mul_of_dvd_left hgb r.val),
    (hcmod.dvd_iff hgM).mp (dvd_mul_of_dvd_left hgc r.val), ?_, ?_, ?_⟩
  · exact habCross.of_dvd (Nat.mul_dvd_mul_left M hgAB)
  · exact hacCross.of_dvd (Nat.mul_dvd_mul_left M hgAC)
  · exact hbcCross.of_dvd (Nat.mul_dvd_mul_left M hgBC)

theorem tripleCongruenceCompatible_iff_nonempty
    (M a b c x y z : ℕ) (hM : 0 < M) :
    TripleCongruenceCompatible M a b c x y z ↔
      (tripleCongruenceResidues M a b c x y z).Nonempty := by
  constructor
  · exact tripleCongruenceResidues_nonempty_of_compatible
      M a b c x y z hM
  · rintro ⟨r, hr⟩
    exact compatible_of_mem_tripleCongruenceResidues r hr

instance (M a b c x y z : ℕ) :
    Decidable (TripleCongruenceCompatible M a b c x y z) := by
  unfold TripleCongruenceCompatible
  infer_instance

/-- Exact cardinality of a three-equation common-unknown system. -/
theorem card_tripleCongruenceResidues
    (M a b c x y z : ℕ) (hM : 0 < M) :
    (tripleCongruenceResidues M a b c x y z).card =
      if TripleCongruenceCompatible M a b c x y z then
        M.gcd (a.gcd (b.gcd c))
      else 0 := by
  classical
  by_cases hcompat : TripleCongruenceCompatible M a b c x y z
  · rw [if_pos hcompat]
    exact card_tripleCongruenceResidues_of_nonempty
      M a b c x y z hM
      (tripleCongruenceResidues_nonempty_of_compatible
        M a b c x y z hM hcompat)
  · rw [if_neg hcompat]
    apply Finset.card_eq_zero.mpr
    rw [Finset.eq_empty_iff_forall_notMem]
    intro r hr
    exact hcompat (compatible_of_mem_tripleCongruenceResidues r hr)

theorem card_tripleCongruenceResidues_of_compatible
    (M a b c x y z : ℕ) (hM : 0 < M)
    (hcompat : TripleCongruenceCompatible M a b c x y z) :
    (tripleCongruenceResidues M a b c x y z).card =
      M.gcd (a.gcd (b.gcd c)) := by
  rw [card_tripleCongruenceResidues M a b c x y z hM, if_pos hcompat]

theorem card_tripleCongruenceResidues_of_not_compatible
    (M a b c x y z : ℕ) (hM : 0 < M)
    (hcompat : ¬TripleCongruenceCompatible M a b c x y z) :
    (tripleCongruenceResidues M a b c x y z).card = 0 := by
  rw [card_tripleCongruenceResidues M a b c x y z hM, if_neg hcompat]

/-- Zero-coefficient audit: compatibility reduces exactly to divisibility of
all three targets by the modulus; the cross conditions become tautologies. -/
theorem tripleCongruenceCompatible_zero_coefficients_iff
    (M x y z : ℕ) :
    TripleCongruenceCompatible M 0 0 0 x y z ↔
      M ∣ x ∧ M ∣ y ∧ M ∣ z := by
  unfold TripleCongruenceCompatible
  simp only [Nat.gcd_zero_right, zero_mul]
  change (M ∣ x ∧ M ∣ y ∧ M ∣ z ∧
      Nat.ModEq (M * M) 0 0 ∧ Nat.ModEq (M * M) 0 0 ∧
      Nat.ModEq (M * M) 0 0) ↔ _
  constructor
  · tauto
  · rintro ⟨hx, hy, hz⟩
    exact ⟨hx, hy, hz, .rfl, .rfl, .rfl⟩

/-- Exact zero-coefficient fiber count, including zero targets. -/
theorem card_tripleCongruenceResidues_zero_coefficients
    (M x y z : ℕ) (hM : 0 < M) :
    (tripleCongruenceResidues M 0 0 0 x y z).card =
      if M ∣ x ∧ M ∣ y ∧ M ∣ z then M else 0 := by
  rw [card_tripleCongruenceResidues M 0 0 0 x y z hM]
  simp only [tripleCongruenceCompatible_zero_coefficients_iff]
  simp

end LonelyRunner
