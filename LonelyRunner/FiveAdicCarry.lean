import Mathlib.Tactic

namespace LonelyRunner

/-- The finite data retained from one normalized five-adic unit.  The carry tag
couples the double and triple carries, rather than choosing them independently. -/
structure FiveCarryState where
  top : Fin 5
  residue : Fin 2
  carry : Fin 4
  deriving DecidableEq, Fintype

/-- The selected carry for multipliers 1, 2, and 3 respectively. -/
def fiveCarryCarry (tag : Fin 4) (u : Fin 3) : Nat :=
  (![![0, 0, 0], ![0, 0, 1], ![0, 1, 1], ![0, 1, 2]] tag) u

/-- The top base-five digit after choosing multiplier `u.val + 1` and
translation `k.val`. -/
def fiveCarryDigit (s : FiveCarryState) (u : Fin 3) (k : Fin 5) : Fin 5 :=
  ⟨((u.val + 1) * s.top.val + fiveCarryCarry s.carry u +
      (u.val + 1) * k.val * (s.residue.val + 1)) % 5,
    Nat.mod_lt _ (by decide)⟩

/-- The closed admissibility predicate for one carry state and one choice. -/
private abbrev fiveCarryGood (s : FiveCarryState) (u : Fin 3) (k : Fin 5) : Prop :=
  (fiveCarryDigit s u k).val ∈ ({1, 2, 3} : Finset Nat)

/-! The two finite searches below are deliberately expressed in normalized
coordinates.  They range over 1,600 and 80 inputs, respectively, and never
materialize the original `40^3` state space. -/
private abbrev fiveCarryBase (d : Fin 5) (c : Fin 4) (u : Fin 3) : Nat :=
  ((u.val + 1) * d.val + fiveCarryCarry c u) % 5

private abbrev fiveCarryBaseGood (v : Nat) : Prop :=
  v % 5 ∈ ({1, 2, 3} : Finset Nat)

private abbrev fiveCarryBlock (v : Nat) (b : Fin 5) : Prop :=
  v = b.val ∨ v = (b.val + 1) % 5

set_option maxRecDepth 100000 in
set_option maxHeartbeats 10000000 in
private theorem fiveCarryNormalizedTriple :
    ∀ d e : Fin 5, ∀ c0 c1 c2 : Fin 4,
      ∃ u : Fin 3, ∃ h : Fin 5,
        fiveCarryBaseGood (fiveCarryBase 0 c0 u + h.val) ∧
        fiveCarryBaseGood (fiveCarryBase d c1 u + h.val) ∧
        fiveCarryBaseGood (fiveCarryBase e c2 u + h.val) := by
  decide

set_option maxRecDepth 100000 in
set_option maxHeartbeats 10000000 in
private theorem fiveCarryNormalizedPair :
    ∀ d : Fin 5, ∀ c0 c1 : Fin 4,
      ∃ u : Fin 3, ∃ b : Fin 5,
        fiveCarryBlock (fiveCarryBase 0 c0 u) b ∧
        fiveCarryBlock (fiveCarryBase d c1 u) b := by
  decide

private abbrev fiveCarryF : Type := ZMod 5
private local instance fiveCarryPrime : Fact (Nat.Prime 5) := ⟨by decide⟩
private abbrev fiveCarryCast (d : Fin 5) : fiveCarryF := d.val
private abbrev fiveCarryJ (u : Fin 3) : fiveCarryF := u.val + 1
private abbrev fiveCarryR (r : Fin 2) : fiveCarryF := r.val + 1
private abbrev fiveCarryC (c : Fin 4) (u : Fin 3) : fiveCarryF :=
  fiveCarryCarry c u

private abbrev fiveCarryFGood (z : fiveCarryF) : Prop :=
  z = 1 ∨ z = 2 ∨ z = 3

private def fiveCarryRepresentative (z : fiveCarryF) : Fin 5 :=
  ⟨z.val, ZMod.val_lt z⟩

private theorem fiveCarryCast_representative (z : fiveCarryF) :
    fiveCarryCast (fiveCarryRepresentative z) = z := by
  exact ZMod.natCast_zmod_val z

private theorem fiveCarryCast_injective (d e : Fin 5) :
    fiveCarryCast d = fiveCarryCast e ↔ d = e := by
  constructor
  · intro h
    apply Fin.ext
    have := congrArg ZMod.val h
    simpa [fiveCarryCast, ZMod.val_natCast_of_lt d.isLt,
      ZMod.val_natCast_of_lt e.isLt] using this
  · intro h
    subst e
    rfl

private theorem fiveCarryDigit_cast (s : FiveCarryState) (u : Fin 3) (k : Fin 5) :
    fiveCarryCast (fiveCarryDigit s u k) =
      fiveCarryJ u * fiveCarryCast s.top + fiveCarryC s.carry u +
        fiveCarryJ u * fiveCarryCast k * fiveCarryR s.residue := by
  simp [fiveCarryCast, fiveCarryDigit, fiveCarryJ, fiveCarryC, fiveCarryR,
    ZMod.natCast_mod, Nat.cast_add, Nat.cast_mul]

private theorem fiveCarryBase_cast (d : Fin 5) (c : Fin 4) (u : Fin 3) :
    (fiveCarryBase d c u : fiveCarryF) = fiveCarryJ u * fiveCarryCast d + fiveCarryC c u := by
  simp [fiveCarryBase, fiveCarryCast, fiveCarryJ, fiveCarryC,
    ZMod.natCast_mod, Nat.cast_add, Nat.cast_mul]

private theorem fiveCarryGood_cast (d : Fin 5) :
    d.val ∈ ({1, 2, 3} : Finset Nat) ↔ fiveCarryFGood (fiveCarryCast d) := by
  fin_cases d <;> decide

private theorem fiveCarryBaseGood_cast (d h : Fin 5) (c : Fin 4) (u : Fin 3) :
    fiveCarryBaseGood (fiveCarryBase d c u + h.val) ↔
      fiveCarryFGood (fiveCarryJ u * fiveCarryCast d + fiveCarryC c u + fiveCarryCast h) := by
  let q : Fin 5 := ⟨(fiveCarryBase d c u + h.val) % 5, Nat.mod_lt _ (by decide)⟩
  change q.val ∈ ({1, 2, 3} : Finset Nat) ↔ _
  rw [fiveCarryGood_cast q]
  simp [q, fiveCarryCast, fiveCarryBase, fiveCarryJ, fiveCarryC,
    ZMod.natCast_mod, Nat.cast_add, Nat.cast_mul]

/-- A normalized two-block remains the corresponding adjacent pair in `ZMod 5`.
Only this forward direction is needed by the pair assembly. -/
private theorem fiveCarryBlock_cast (d b : Fin 5) (c : Fin 4) (u : Fin 3)
    (h : fiveCarryBlock (fiveCarryBase d c u) b) :
    fiveCarryJ u * fiveCarryCast d + fiveCarryC c u = fiveCarryCast b ∨
      fiveCarryJ u * fiveCarryCast d + fiveCarryC c u = fiveCarryCast b + 1 := by
  rcases h with h | h
  · left
    calc
      fiveCarryJ u * fiveCarryCast d + fiveCarryC c u = (fiveCarryBase d c u : fiveCarryF) :=
        fiveCarryBase_cast d c u |>.symm
      _ = fiveCarryCast b := by simpa [fiveCarryCast] using congrArg (fun n : Nat => (n : fiveCarryF)) h
  · right
    calc
      fiveCarryJ u * fiveCarryCast d + fiveCarryC c u = (fiveCarryBase d c u : fiveCarryF) :=
        fiveCarryBase_cast d c u |>.symm
      _ = fiveCarryCast b + 1 := by
        simpa [fiveCarryCast, ZMod.natCast_mod, Nat.cast_add] using
          congrArg (fun n : Nat => (n : fiveCarryF)) h

private theorem fiveCarryJ_ne_zero (u : Fin 3) : fiveCarryJ u ≠ 0 := by
  fin_cases u <;> decide

private theorem fiveCarryR_ne_zero (r : Fin 2) : fiveCarryR r ≠ 0 := by
  fin_cases r <;> decide

private theorem fiveCarryUnit (u : Fin 3) (r : Fin 2) :
    fiveCarryJ u * fiveCarryR r ≠ 0 :=
  mul_ne_zero (fiveCarryJ_ne_zero u) (fiveCarryR_ne_zero r)

private theorem fiveCarryRatio (r r' : Fin 2) (h : r ≠ r') :
    (fiveCarryR r' : fiveCarryF) / fiveCarryR r = 2 ∨ fiveCarryR r' / fiveCarryR r = 3 := by
  fin_cases r <;> fin_cases r'
  · exact (h rfl).elim
  · left
    change (2 : fiveCarryF) / 1 = 2
    simp
  · right
    apply (div_eq_iff (fiveCarryR_ne_zero ⟨1, by decide⟩)).2
    decide
  · exact (h rfl).elim

private theorem fiveCarryEscape (z : fiveCarryF) (tag : Fin 2) :
    fiveCarryFGood z ∨ fiveCarryFGood (z + (tag.val + 2 : fiveCarryF)) := by
  rw [← fiveCarryCast_representative z]
  generalize fiveCarryRepresentative z = q
  fin_cases q <;> fin_cases tag <;>
    decide

private theorem fiveCarryDigit_good_of_field (s : FiveCarryState) (u : Fin 3) (k : Fin 5)
    (h : fiveCarryFGood (fiveCarryJ u * fiveCarryCast s.top + fiveCarryC s.carry u +
      fiveCarryJ u * fiveCarryCast k * fiveCarryR s.residue)) : fiveCarryGood s u k := by
  apply (fiveCarryGood_cast (fiveCarryDigit s u k)).mpr
  simpa [fiveCarryDigit_cast] using h

private theorem fiveCarryTriple_same (a b c : FiveCarryState)
    (hab : a.residue = b.residue) (hac : a.residue = c.residue) :
    ∃ u : Fin 3, ∃ k : Fin 5,
      fiveCarryGood a u k ∧ fiveCarryGood b u k ∧ fiveCarryGood c u k := by
  let d := fiveCarryRepresentative (fiveCarryCast b.top - fiveCarryCast a.top)
  let e := fiveCarryRepresentative (fiveCarryCast c.top - fiveCarryCast a.top)
  obtain ⟨u, h, ha, hb, hc⟩ :=
    fiveCarryNormalizedTriple d e a.carry b.carry c.carry
  let D : fiveCarryF := fiveCarryJ u * fiveCarryR a.residue
  let H : fiveCarryF := fiveCarryCast h - fiveCarryJ u * fiveCarryCast a.top
  let k := fiveCarryRepresentative (H / D)
  have hD : D ≠ 0 := fiveCarryUnit u a.residue
  have hk : fiveCarryJ u * fiveCarryCast k * fiveCarryR a.residue = H := by
    rw [show fiveCarryCast k = H / D by
      exact fiveCarryCast_representative (H / D)]
    calc
      fiveCarryJ u * (H / D) * fiveCarryR a.residue = D * (H / D) := by
        dsimp [D]
        ring
      _ = H := mul_div_cancel₀ H hD
  refine ⟨u, k, ?_, ?_, ?_⟩
  · apply fiveCarryDigit_good_of_field
    have ha' := (fiveCarryBaseGood_cast (0 : Fin 5) h a.carry u).mp ha
    rw [hk]
    convert ha' using 1 <;> simp [fiveCarryCast] <;> dsimp [H] <;> ring
  · apply fiveCarryDigit_good_of_field
    have hb' := (fiveCarryBaseGood_cast d h b.carry u).mp hb
    have hd : fiveCarryCast d = fiveCarryCast b.top - fiveCarryCast a.top :=
      fiveCarryCast_representative _
    rw [← hab, hk]
    convert hb' using 1 <;> dsimp [H] <;> rw [hd] <;> ring
  · apply fiveCarryDigit_good_of_field
    have hc' := (fiveCarryBaseGood_cast e h c.carry u).mp hc
    have he : fiveCarryCast e = fiveCarryCast c.top - fiveCarryCast a.top :=
      fiveCarryCast_representative _
    rw [← hac, hk]
    convert hc' using 1 <;> dsimp [H] <;> rw [he] <;> ring

/-- The unequal-residue case uses the two adjacent translations supplied by
the normalized pair theorem.  The proof stays in `ZMod 5`; its only finite
ingredients are the already checked pair/block, ratio, and escape lemmas. -/
private theorem fiveCarryTriple_pair (a b c : FiveCarryState)
    (hab : a.residue = b.residue) (hac : a.residue ≠ c.residue) :
    ∃ u : Fin 3, ∃ k : Fin 5,
      fiveCarryGood a u k ∧ fiveCarryGood b u k ∧ fiveCarryGood c u k := by
  let d := fiveCarryRepresentative (fiveCarryCast b.top - fiveCarryCast a.top)
  obtain ⟨u, b0, hblocka, hblockb⟩ :=
    fiveCarryNormalizedPair d a.carry b.carry
  let U : fiveCarryF := fiveCarryJ u * fiveCarryCast a.top + fiveCarryCast b0
  let D : fiveCarryF := fiveCarryJ u * fiveCarryR a.residue
  let K0 : fiveCarryF := (1 - U) / D
  let K1 : fiveCarryF := (2 - U) / D
  let k0 := fiveCarryRepresentative K0
  let k1 := fiveCarryRepresentative K1
  have hD : D ≠ 0 := fiveCarryUnit u a.residue
  have hk0 : fiveCarryJ u * fiveCarryCast k0 * fiveCarryR a.residue = 1 - U := by
    rw [show fiveCarryCast k0 = K0 by exact fiveCarryCast_representative K0]
    calc
      fiveCarryJ u * K0 * fiveCarryR a.residue = D * K0 := by dsimp [D]; ring
      _ = 1 - U := mul_div_cancel₀ _ hD
  have hk1 : fiveCarryJ u * fiveCarryCast k1 * fiveCarryR a.residue = 2 - U := by
    rw [show fiveCarryCast k1 = K1 by exact fiveCarryCast_representative K1]
    calc
      fiveCarryJ u * K1 * fiveCarryR a.residue = D * K1 := by dsimp [D]; ring
      _ = 2 - U := mul_div_cancel₀ _ hD
  have ha0 : fiveCarryFGood (fiveCarryJ u * fiveCarryCast a.top + fiveCarryC a.carry u +
      fiveCarryJ u * fiveCarryCast k0 * fiveCarryR a.residue) := by
    rcases fiveCarryBlock_cast 0 b0 a.carry u hblocka with h | h
    · left; rw [hk0]; dsimp [U]; simp [fiveCarryCast] at h; rw [h]; ring
    · right; left; rw [hk0]; dsimp [U]; simp [fiveCarryCast] at h; rw [h]; ring
  have ha1 : fiveCarryFGood (fiveCarryJ u * fiveCarryCast a.top + fiveCarryC a.carry u +
      fiveCarryJ u * fiveCarryCast k1 * fiveCarryR a.residue) := by
    rcases fiveCarryBlock_cast 0 b0 a.carry u hblocka with h | h
    · right; left; rw [hk1]; dsimp [U]; simp [fiveCarryCast] at h; rw [h]; ring
    · right; right; rw [hk1]; dsimp [U]; simp [fiveCarryCast] at h; rw [h]; ring
  have hd : fiveCarryCast d = fiveCarryCast b.top - fiveCarryCast a.top :=
    fiveCarryCast_representative _
  have hbaseb : fiveCarryJ u * fiveCarryCast b.top + fiveCarryC b.carry u = U ∨
      fiveCarryJ u * fiveCarryCast b.top + fiveCarryC b.carry u = U + 1 := by
    rcases fiveCarryBlock_cast d b0 b.carry u hblockb with h | h
    · left
      calc
        fiveCarryJ u * fiveCarryCast b.top + fiveCarryC b.carry u =
            fiveCarryJ u * fiveCarryCast a.top +
              (fiveCarryJ u * fiveCarryCast d + fiveCarryC b.carry u) := by rw [hd]; ring
        _ = U := by dsimp [U]; rw [h]
    · right
      calc
        fiveCarryJ u * fiveCarryCast b.top + fiveCarryC b.carry u =
            fiveCarryJ u * fiveCarryCast a.top +
              (fiveCarryJ u * fiveCarryCast d + fiveCarryC b.carry u) := by rw [hd]; ring
        _ = U + 1 := by dsimp [U]; rw [h]; ring
  have hb0 : fiveCarryFGood (fiveCarryJ u * fiveCarryCast b.top + fiveCarryC b.carry u +
      fiveCarryJ u * fiveCarryCast k0 * fiveCarryR b.residue) := by
    rcases hbaseb with h | h
    · rw [← hab, hk0, h]; left; ring
    · rw [← hab, hk0, h]; right; left; ring
  have hb1 : fiveCarryFGood (fiveCarryJ u * fiveCarryCast b.top + fiveCarryC b.carry u +
      fiveCarryJ u * fiveCarryCast k1 * fiveCarryR b.residue) := by
    rcases hbaseb with h | h
    · rw [← hab, hk1, h]; right; left; ring
    · rw [← hab, hk1, h]; right; right; ring
  let Y : fiveCarryF := fiveCarryJ u * fiveCarryCast c.top + fiveCarryC c.carry u +
    fiveCarryJ u * fiveCarryCast k0 * fiveCarryR c.residue
  have hK : K1 = K0 + 1 / D := by
    dsimp [K0, K1]
    field_simp [hD]
    ring
  have hratio := fiveCarryRatio a.residue c.residue hac
  rcases hratio with hratio | hratio
  · have hstep : fiveCarryJ u * fiveCarryCast k1 * fiveCarryR c.residue =
        fiveCarryJ u * fiveCarryCast k0 * fiveCarryR c.residue + 2 := by
      rw [show fiveCarryCast k1 = K1 by exact fiveCarryCast_representative K1,
        show fiveCarryCast k0 = K0 by exact fiveCarryCast_representative K0]
      have hr : fiveCarryR c.residue = 2 * fiveCarryR a.residue :=
        (div_eq_iff (fiveCarryR_ne_zero a.residue)).mp hratio
      rw [hK, hr]
      field_simp [D, hD]
      ring
    rcases fiveCarryEscape Y 0 with hy | hy
    · exact ⟨u, k0, fiveCarryDigit_good_of_field _ _ _ ha0,
        fiveCarryDigit_good_of_field _ _ _ hb0, fiveCarryDigit_good_of_field _ _ _ hy⟩
    · refine ⟨u, k1, fiveCarryDigit_good_of_field _ _ _ ha1,
        fiveCarryDigit_good_of_field _ _ _ hb1, fiveCarryDigit_good_of_field _ _ _ ?_⟩
      change fiveCarryFGood (fiveCarryJ u * fiveCarryCast c.top + fiveCarryC c.carry u +
        fiveCarryJ u * fiveCarryCast k1 * fiveCarryR c.residue)
      rw [hstep]
      dsimp [Y] at hy
      convert hy using 1 <;> ring
  · have hstep : fiveCarryJ u * fiveCarryCast k1 * fiveCarryR c.residue =
        fiveCarryJ u * fiveCarryCast k0 * fiveCarryR c.residue + 3 := by
      rw [show fiveCarryCast k1 = K1 by exact fiveCarryCast_representative K1,
        show fiveCarryCast k0 = K0 by exact fiveCarryCast_representative K0]
      have hr : fiveCarryR c.residue = 3 * fiveCarryR a.residue :=
        (div_eq_iff (fiveCarryR_ne_zero a.residue)).mp hratio
      rw [hK, hr]
      field_simp [D, hD]
      ring
    rcases fiveCarryEscape Y 1 with hy | hy
    · exact ⟨u, k0, fiveCarryDigit_good_of_field _ _ _ ha0,
        fiveCarryDigit_good_of_field _ _ _ hb0, fiveCarryDigit_good_of_field _ _ _ hy⟩
    · refine ⟨u, k1, fiveCarryDigit_good_of_field _ _ _ ha1,
        fiveCarryDigit_good_of_field _ _ _ hb1, fiveCarryDigit_good_of_field _ _ _ ?_⟩
      change fiveCarryFGood (fiveCarryJ u * fiveCarryCast c.top + fiveCarryC c.carry u +
        fiveCarryJ u * fiveCarryCast k1 * fiveCarryR c.residue)
      rw [hstep]
      dsimp [Y] at hy
      convert hy using 1 <;> ring

private theorem fiveCarryResiduePartition (r0 r1 r2 : Fin 2) :
    (r0 = r1 ∧ r1 = r2) ∨ (r0 = r1 ∧ r0 ≠ r2) ∨
      (r0 = r2 ∧ r0 ≠ r1) ∨ (r1 = r2 ∧ r1 ≠ r0) := by
  fin_cases r0 <;> fin_cases r1 <;> fin_cases r2 <;> decide

/-- The complete private carry theorem combines the equal-residue assembly,
the unequal-residue pair assembly, and the exhaustive three-bit partition. -/
private theorem fiveCarryTripleThree : ∀ a b c : FiveCarryState,
    ∃ u : Fin 3, ∃ k : Fin 5,
      fiveCarryGood a u k ∧ fiveCarryGood b u k ∧ fiveCarryGood c u k := by
  intro a b c
  rcases fiveCarryResiduePartition a.residue b.residue c.residue with
      ⟨hab, hbc⟩ | ⟨hab, hac⟩ | ⟨hac, hab⟩ | ⟨hbc, hba⟩
  · exact fiveCarryTriple_same a b c hab (hab.trans hbc)
  · exact fiveCarryTriple_pair a b c hab hac
  · obtain ⟨u, k, ha, hc, hb⟩ := fiveCarryTriple_pair a c b hac hab
    exact ⟨u, k, ha, hb, hc⟩
  · obtain ⟨u, k, hb, hc, ha⟩ := fiveCarryTriple_pair b c a hbc hba
    exact ⟨u, k, ha, hb, hc⟩

/-- Every ordered triple of coupled carry states has a multiplier and
translation whose three digits avoid the two forbidden residues. -/
theorem fiveCarryTriple : ∀ s : Fin 3 → FiveCarryState,
    ∃ u : Fin 3, ∃ k : Fin 5, ∀ i,
      (fiveCarryDigit (s i) u k).val ∈ ({1, 2, 3} : Finset Nat) := by
  intro s
  obtain ⟨u, k, h0, h1, h2⟩ := fiveCarryTripleThree (s 0) (s 1) (s 2)
  refine ⟨u, k, ?_⟩
  intro i
  fin_cases i
  · exact h0
  · exact h1
  · exact h2

end LonelyRunner
