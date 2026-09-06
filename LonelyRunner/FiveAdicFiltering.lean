import LonelyRunner.PivotResidues
import Mathlib.Tactic

/-!
# Five-adic digit arithmetic

The arithmetic layer for the five-adic filter records base-five digits and the
unit corrections used by the later finite-label descent.
-/

namespace LonelyRunner

/-- The base-five digit at level `m`. -/
def fiveAdicDigit (m x : ℕ) : ℕ := (x / 5 ^ m) % 5

/-- Digits one through three are the good five-adic residues. -/
def FiveAdicGoodDigit (m x : ℕ) : Prop :=
  1 ≤ fiveAdicDigit m x ∧ fiveAdicDigit m x ≤ 3

/-- The level-`j` unit correction used below top level `m`. -/
def fiveAdicCorrection (m j k : ℕ) : ℕ := 1 + k * 5 ^ (m - j)

/-- A correction is positive. -/
theorem fiveAdicCorrection_pos (m j k : ℕ) : 0 < fiveAdicCorrection m j k := by
  simp [fiveAdicCorrection]

/-- Below the top level, corrections are one modulo five. -/
theorem fiveAdicCorrection_mod_five (m j k : ℕ) (hj : j < m) :
    fiveAdicCorrection m j k % 5 = 1 := by
  unfold fiveAdicCorrection
  have hpow : 5 ∣ 5 ^ (m - j) := dvd_pow_self 5 (by omega)
  rw [Nat.add_mod, Nat.mul_mod, Nat.mod_eq_zero_of_dvd hpow]
  norm_num

/-- The residue modulo the next five-adic power splits into its selected digit
and its lower residue. -/
theorem fiveAdic_residue_decomposition (m x : ℕ) :
    x % (5 * 5 ^ m) = 5 ^ m * fiveAdicDigit m x + x % 5 ^ m := by
  unfold fiveAdicDigit
  simpa [Nat.mul_comm, Nat.add_comm] using (Nat.mod_mul (x := x) (a := 5 ^ m) (b := 5))

/-- A good selected digit gives the closed cyclic-distance threshold. -/
theorem fiveAdicGoodDigit_distance (m x : ℕ) (hgood : FiveAdicGoodDigit m x) :
    5 ^ m ≤ cyclicResidueDistance (5 * 5 ^ m) x := by
  unfold FiveAdicGoodDigit at hgood
  rw [cyclicResidueDistance, fiveAdic_residue_decomposition]
  obtain ⟨hlo, hhi⟩ := hgood
  have hrem : x % 5 ^ m < 5 ^ m := Nat.mod_lt _ (pow_pos (by omega) _)
  rw [le_min_iff]
  have hR : 0 < 5 ^ m := pow_pos (by omega) _
  have hleft := Nat.mul_le_mul_left (5 ^ m) hlo
  have hright := Nat.mul_le_mul_left (5 ^ m) hhi
  constructor <;> omega

/-- At its selected level, a correction adds exactly one level-`m` block. -/
theorem fiveAdicCorrection_selected_product (m j k A u : ℕ) (hj : j ≤ m) :
    fiveAdicCorrection m j k * (A * (5 ^ j * u)) =
      A * (5 ^ j * u) + k * 5 ^ m * (A * u) := by
  unfold fiveAdicCorrection
  have hpow : 5 ^ (m - j) * 5 ^ j = 5 ^ m := Nat.pow_sub_mul_pow 5 hj
  calc
    (1 + k * 5 ^ (m - j)) * (A * (5 ^ j * u)) =
        A * (5 ^ j * u) + k * (5 ^ (m - j) * 5 ^ j) * (A * u) := by ring
    _ = A * (5 ^ j * u) + k * 5 ^ m * (A * u) := by rw [hpow]

/-- The selected digit shifts by its actual current coefficient. -/
theorem fiveAdicCorrection_selected_digit (m j k A u : ℕ) (hj : j ≤ m) :
    fiveAdicDigit m (fiveAdicCorrection m j k * (A * (5 ^ j * u))) =
      (fiveAdicDigit m (A * (5 ^ j * u)) + k * ((A * u) % 5)) % 5 := by
  rw [fiveAdicCorrection_selected_product m j k A u hj]
  unfold fiveAdicDigit
  rw [show k * 5 ^ m * (A * u) = 5 ^ m * (k * (A * u)) by ring,
    Nat.add_mul_div_left _ _ (pow_pos (by omega) _)]
  simp [Nat.add_mod, Nat.mul_mod]

/-- Corrections below a higher level preserve its residue modulo `5^(m+1)`. -/
theorem fiveAdicCorrection_higher_residue (m j ell k A u : ℕ)
    (hjell : j < ell) (hell : ell ≤ m) :
    (fiveAdicCorrection m j k * (A * (5 ^ ell * u))) % (5 * 5 ^ m) =
      (A * (5 ^ ell * u)) % (5 * 5 ^ m) := by
  unfold fiveAdicCorrection
  have hexp : m - j + ell = (m + 1) + (ell - j - 1) := by omega
  have hpow : 5 ^ (m - j) * 5 ^ ell =
      (5 * 5 ^ m) * 5 ^ (ell - j - 1) := by
    calc
      5 ^ (m - j) * 5 ^ ell = 5 ^ (m - j + ell) := by rw [← Nat.pow_add]
      _ = 5 ^ ((m + 1) + (ell - j - 1)) := by rw [hexp]
      _ = 5 ^ (m + 1) * 5 ^ (ell - j - 1) := by rw [Nat.pow_add]
      _ = (5 * 5 ^ m) * 5 ^ (ell - j - 1) := by rw [pow_succ]; ring
  have hprod : (1 + k * 5 ^ (m - j)) * (A * (5 ^ ell * u)) =
      A * (5 ^ ell * u) + (5 * 5 ^ m) *
        (k * 5 ^ (ell - j - 1) * (A * u)) := by
    calc
      _ = A * (5 ^ ell * u) + k * (5 ^ (m - j) * 5 ^ ell) * (A * u) := by ring
      _ = _ := by rw [hpow]; ring
  rw [hprod]
  exact Nat.add_mul_mod_self_left _ _ _

/-- At the top level the residue is exactly its nonzero base-five unit digit. -/
theorem fiveAdic_top_residue (m A u : ℕ) :
    (A * (5 ^ m * u)) % (5 * 5 ^ m) = 5 ^ m * ((A * u) % 5) := by
  rw [show A * (5 ^ m * u) = 5 ^ m * (A * u) by ring,
    show 5 * 5 ^ m = 5 ^ m * 5 by ring]
  exact Nat.mul_mod_mul_left _ _ _

/-- A top-level unit has the closed five-adic distance bound, including digit four. -/
theorem fiveAdic_top_distance (m A u : ℕ) (hunit : ¬ 5 ∣ A * u) :
    5 ^ m ≤ cyclicResidueDistance (5 * 5 ^ m) (A * (5 ^ m * u)) := by
  rw [cyclicResidueDistance, fiveAdic_top_residue]
  have hR : 0 < 5 ^ m := pow_pos (by omega) _
  have hmod : (A * u) % 5 ≠ 0 := by
    intro h
    exact hunit (Nat.dvd_iff_mod_eq_zero.mpr h)
  have hlt : (A * u) % 5 < 5 := Nat.mod_lt _ (by omega)
  have hlo : 1 ≤ (A * u) % 5 := by omega
  have hhi : (A * u) % 5 ≤ 4 := by omega
  have hleft := Nat.mul_le_mul_left (5 ^ m) hlo
  have hright := Nat.mul_le_mul_left (5 ^ m) hhi
  rw [le_min_iff]
  constructor <;> omega

/-- At most two nonzero affine rows modulo five admit a common good digit. -/
theorem fiveAdic_avoid_two {I : Type*} [Fintype I] (q s : I → ℕ)
    (hcard : Fintype.card I ≤ 2) (hunit : ∀ i, ¬ 5 ∣ s i) :
    ∃ k : Fin 5, ∀ i,
      1 ≤ (q i + k.val * s i) % 5 ∧ (q i + k.val * s i) % 5 ≤ 3 := by
  classical
  letI : Fact (Nat.Prime 5) := ⟨by decide⟩
  let bad : I → Finset (ZMod 5) := fun i =>
    {-(q i : ZMod 5) / (s i : ZMod 5), ((4 : ZMod 5) - (q i : ZMod 5)) / (s i : ZMod 5)}
  let B : Finset (ZMod 5) := Finset.univ.biUnion bad
  have hB : B.card ≤ 4 := by
    calc
      B.card ≤ ∑ i ∈ (Finset.univ : Finset I), (bad i).card := Finset.card_biUnion_le
      _ ≤ ∑ _i ∈ (Finset.univ : Finset I), 2 := by
        gcongr
        exact Finset.card_insert_le _ _ |>.trans (by simp)
      _ = 2 * Fintype.card I := by
        norm_num [Finset.sum_const, nsmul_eq_mul, Nat.mul_comm]
      _ ≤ 4 := by omega
  have hfive : (Finset.univ : Finset (ZMod 5)).card = 5 := by decide
  obtain ⟨K, hKuniv, hK⟩ := Finset.exists_mem_notMem_of_card_lt_card
    (show B.card < (Finset.univ : Finset (ZMod 5)).card by rw [hfive]; omega)
  refine ⟨⟨K.val, ZMod.val_lt K⟩, fun i => ?_⟩
  have hnot0 : (q i + (K.val : ℕ) * s i : ZMod 5) ≠ 0 := by
    intro h
    have hs : (s i : ZMod 5) ≠ 0 := by
      exact fun hz => hunit i ((ZMod.natCast_eq_zero_iff (s i) 5).mp hz)
    have hKbad : K = -(q i : ZMod 5) / (s i : ZMod 5) := by
      apply (eq_div_iff hs).mpr
      rw [← ZMod.natCast_zmod_val K]
      linear_combination h
    apply hK
    exact Finset.mem_biUnion.mpr ⟨i, Finset.mem_univ _, by simp [bad, hKbad]⟩
  have hnot4 : (q i + (K.val : ℕ) * s i : ZMod 5) ≠ 4 := by
    intro h
    have hs : (s i : ZMod 5) ≠ 0 := by
      exact fun hz => hunit i ((ZMod.natCast_eq_zero_iff (s i) 5).mp hz)
    have hKbad : K = ((4 : ZMod 5) - (q i : ZMod 5)) / (s i : ZMod 5) := by
      apply (eq_div_iff hs).mpr
      rw [← ZMod.natCast_zmod_val K]
      linear_combination h
    apply hK
    exact Finset.mem_biUnion.mpr ⟨i, Finset.mem_univ _, by simp [bad, hKbad]⟩
  let n : ℕ := q i + K.val * s i
  have hcast : ((n % 5 : ℕ) : ZMod 5) =
      (q i + (K.val : ℕ) * s i : ZMod 5) := by
    dsimp [n]
    simp [Nat.cast_add, Nat.cast_mul, ZMod.natCast_mod]
  have hn0 : n % 5 ≠ 0 := by
    intro hz
    apply hnot0
    rw [← hcast, hz]
    norm_num
  have hn4 : n % 5 ≠ 4 := by
    intro hz
    apply hnot4
    rw [← hcast, hz]
    norm_num
  have hnlt : n % 5 < 5 := Nat.mod_lt _ (by decide)
  change 1 ≤ n % 5 ∧ n % 5 ≤ 3
  omega

/-- Equal residues modulo the next five-adic power have the same selected digit. -/
theorem fiveAdicDigit_of_mod_eq (m x y : ℕ)
    (h : x % (5 * 5 ^ m) = y % (5 * 5 ^ m)) :
    fiveAdicDigit m x = fiveAdicDigit m y := by
  unfold fiveAdicDigit
  have h' := congrArg (fun z : ℕ => z / 5 ^ m) h
  simpa [Nat.mod_mul_left_div_self] using h'

/-- Reduction modulo `5^(m+1)` preserves a five-adic unit and every product residue. -/
theorem fiveAdic_unit_representative (m A : ℕ) (hA : ¬ 5 ∣ A) :
    0 < A % (5 * 5 ^ m) ∧ A % (5 * 5 ^ m) < 5 * 5 ^ m ∧
      ¬ 5 ∣ A % (5 * 5 ^ m) ∧ (A % (5 * 5 ^ m)) % 5 = A % 5 ∧
        ∀ d : ℕ, ((A % (5 * 5 ^ m)) * d) % (5 * 5 ^ m) =
          (A * d) % (5 * 5 ^ m) := by
  have hM : 0 < 5 * 5 ^ m := by positivity
  have hdiv : 5 ∣ 5 * 5 ^ m := Nat.dvd_mul_right 5 (5 ^ m)
  have hmod5 : (A % (5 * 5 ^ m)) % 5 = A % 5 :=
    Nat.mod_mod_of_dvd A hdiv
  refine ⟨?_, Nat.mod_lt _ hM, ?_, hmod5, fun d => ?_⟩
  · apply Nat.pos_of_ne_zero
    intro hz
    apply hA
    apply Nat.dvd_iff_mod_eq_zero.mpr
    rw [← hmod5, hz]
  · intro hd
    apply hA
    apply Nat.dvd_iff_mod_eq_zero.mpr
    rw [← hmod5, Nat.mod_eq_zero_of_dvd hd]
  · simp [Nat.mul_mod]

/-- A layer with at most two labels can be filled with good five-adic digits. -/
theorem fiveAdic_fill_level {I : Type*} [Fintype I] [DecidableEq I]
    (d ell u : I → ℕ) (m r A : ℕ) (hr : r ≤ m)
    (hdecomp : ∀ i, d i = 5 ^ (ell i) * u i)
    (hu : ∀ i, ¬ 5 ∣ u i) (hA : ¬ 5 ∣ A)
    (hcard : (Finset.univ.filter fun i => ell i = r).card ≤ 2) :
    ∃ k : Fin 5, ∀ i, ell i = r →
      FiveAdicGoodDigit m (fiveAdicCorrection m r k.val * (A * d i)) := by
  classical
  let L := {i : I // ell i = r}
  have hLcard : Fintype.card L ≤ 2 := by
    simpa [L, Fintype.card_subtype] using hcard
  have hsunit : ∀ i : L, ¬ 5 ∣ A * u i.val := by
    intro i h
    rcases (by norm_num : Nat.Prime 5).dvd_mul.mp h with h' | h'
    · exact hA h'
    · exact hu i.val h'
  obtain ⟨k, hk⟩ := fiveAdic_avoid_two
    (fun i : L => fiveAdicDigit m (A * d i.val)) (fun i => A * u i.val)
    hLcard hsunit
  refine ⟨k, fun i hi => ?_⟩
  have hdec : d i = 5 ^ r * u i := by simpa [hi] using hdecomp i
  unfold FiveAdicGoodDigit
  rw [hdec, fiveAdicCorrection_selected_digit m r k.val A (u i) hr]
  have hk' := hk ⟨i, hi⟩
  rw [hdec] at hk'
  simpa [Nat.add_mod, Nat.mul_mod] using hk'

/-- Descending five-adic filtering with an arbitrary positive unit seed.

The multiplier is deliberately left unbounded here: reducing it modulo the
next five-adic power is a separate, residue-only step. -/
theorem fiveAdic_seeded_unbounded {I : Type*} [Fintype I] [DecidableEq I]
    (d ell u : I → ℕ) (m h A : ℕ)
    (hd : ∀ i, 0 < d i)
    (hdecomp : ∀ i, d i = 5 ^ (ell i) * u i)
    (hu : ∀ i, ¬ 5 ∣ u i)
    (hell : ∀ i, ell i ≤ m)
    (hh : h ≤ m) (hApos : 0 < A) (hAunit : ¬ 5 ∣ A)
    (hcard : ∀ j, j < h → (Finset.univ.filter fun i => ell i = j).card ≤ 2)
    (hhigh : ∀ i, h ≤ ell i →
      5 ^ m ≤ cyclicResidueDistance (5 * 5 ^ m) (A * d i)) :
    ∃ B : ℕ, 0 < B ∧ ¬ 5 ∣ B ∧ B % 5 = A % 5 ∧
      (∀ i, h ≤ ell i → (B * d i) % (5 * 5 ^ m) = (A * d i) % (5 * 5 ^ m)) ∧
      (∀ i, ell i < h → FiveAdicGoodDigit m (B * d i)) ∧
      (∀ i, 5 ^ m ≤ cyclicResidueDistance (5 * 5 ^ m) (B * d i)) := by
  classical
  induction h generalizing A with
  | zero =>
      refine ⟨A, hApos, hAunit, rfl, ?_, ?_, ?_⟩
      · intro i _
        rfl
      · intro i hi
        omega
      · intro i
        exact hhigh i (Nat.zero_le _)
  | succ r ih =>
      have hrm : r < m := by omega
      have hrcard : (Finset.univ.filter fun i => ell i = r).card ≤ 2 := hcard r (by omega)
      obtain ⟨k, hk⟩ := fiveAdic_fill_level d ell u m r A (by omega)
        hdecomp hu hAunit hrcard
      let A' := fiveAdicCorrection m r k.val * A
      have hA'pos : 0 < A' := by
        dsimp [A']
        exact Nat.mul_pos (fiveAdicCorrection_pos m r k.val) hApos
      have hcorrunit : ¬ 5 ∣ fiveAdicCorrection m r k.val := by
        intro hc
        have hz : fiveAdicCorrection m r k.val % 5 = 0 := Nat.dvd_iff_mod_eq_zero.mp hc
        have hone := fiveAdicCorrection_mod_five m r k.val hrm
        omega
      have hA'unit : ¬ 5 ∣ A' := by
        intro hdiv
        rcases (by norm_num : Nat.Prime 5).dvd_mul.mp hdiv with hc | ha
        · exact hcorrunit hc
        · exact hAunit ha
      have hcard' : ∀ j, j < r → (Finset.univ.filter fun i => ell i = j).card ≤ 2 := by
        intro j hj
        exact hcard j (by omega)
      have hhigh' : ∀ i, r ≤ ell i →
          5 ^ m ≤ cyclicResidueDistance (5 * 5 ^ m) (A' * d i) := by
        intro i hi
        rcases lt_or_eq_of_le hi with hlt | heq
        · have hres : (A' * d i) % (5 * 5 ^ m) = (A * d i) % (5 * 5 ^ m) := by
            dsimp [A']
            rw [hdecomp i]
            simpa [Nat.mul_assoc] using
              fiveAdicCorrection_higher_residue m r (ell i) k.val A (u i) hlt (hell i)
          rw [cyclicResidueDistance, hres]
          exact hhigh i (by omega)
        · have hgood : FiveAdicGoodDigit m (A' * d i) := by
            dsimp [A']
            simpa [Nat.mul_assoc] using hk i heq.symm
          exact fiveAdicGoodDigit_distance m (A' * d i) hgood
      obtain ⟨B, hBpos, hBunit, hBmod, hBres, hBgood, hBdist⟩ :=
        ih A' (by omega) hA'pos hA'unit hcard' hhigh'
      refine ⟨B, hBpos, hBunit, ?_, ?_, ?_, hBdist⟩
      · rw [hBmod]
        dsimp [A']
        rw [Nat.mul_mod, fiveAdicCorrection_mod_five m r k.val hrm]
        simp
      · intro i hi
        calc
          (B * d i) % (5 * 5 ^ m) = (A' * d i) % (5 * 5 ^ m) := hBres i (by omega)
          _ = (A * d i) % (5 * 5 ^ m) := by
            dsimp [A']
            rw [hdecomp i]
            simpa [Nat.mul_assoc] using fiveAdicCorrection_higher_residue m r (ell i)
              k.val A (u i) (by omega) (hell i)
      · intro i hi
        rcases lt_or_eq_of_le (Nat.le_of_lt_succ hi) with hlt | heq
        · exact hBgood i hlt
        · have hres := hBres i (by omega)
          have hdigit : fiveAdicDigit m (B * d i) = fiveAdicDigit m (A' * d i) :=
            fiveAdicDigit_of_mod_eq m _ _ hres
          have hgood : FiveAdicGoodDigit m (A' * d i) := by
            dsimp [A']
            simpa [Nat.mul_assoc] using hk i heq
          unfold FiveAdicGoodDigit at hgood ⊢
          rw [hdigit]
          exact hgood

/-- The seeded descent reduced to the canonical positive representative. -/
theorem fiveAdic_seeded_multiplier {I : Type*} [Fintype I] [DecidableEq I]
    (d ell u : I → ℕ) (m h A : ℕ)
    (hd : ∀ i, 0 < d i)
    (hdecomp : ∀ i, d i = 5 ^ (ell i) * u i)
    (hu : ∀ i, ¬ 5 ∣ u i)
    (hell : ∀ i, ell i ≤ m)
    (hh : h ≤ m) (hApos : 0 < A) (hAunit : ¬ 5 ∣ A)
    (hcard : ∀ j, j < h → (Finset.univ.filter fun i => ell i = j).card ≤ 2)
    (hhigh : ∀ i, h ≤ ell i →
      5 ^ m ≤ cyclicResidueDistance (5 * 5 ^ m) (A * d i)) :
    ∃ lam : ℕ, 0 < lam ∧ lam < 5 * 5 ^ m ∧ ¬ 5 ∣ lam ∧ lam % 5 = A % 5 ∧
      (∀ i, h ≤ ell i → (lam * d i) % (5 * 5 ^ m) = (A * d i) % (5 * 5 ^ m)) ∧
      (∀ i, ell i < h → FiveAdicGoodDigit m (lam * d i)) ∧
      (∀ i, 5 ^ m ≤ cyclicResidueDistance (5 * 5 ^ m) (lam * d i)) := by
  obtain ⟨B, hBpos, hBunit, hBmod, hBres, hBgood, hBdist⟩ :=
    fiveAdic_seeded_unbounded d ell u m h A hd hdecomp hu hell hh hApos hAunit hcard hhigh
  obtain ⟨hlampos, hlamlt, hlamunit, hlammod, hlamprod⟩ :=
    fiveAdic_unit_representative m B hBunit
  refine ⟨B % (5 * 5 ^ m), hlampos, hlamlt, hlamunit, ?_, ?_, ?_, ?_⟩
  · exact hlammod.trans hBmod
  · intro i hi
    exact (hlamprod (d i)).trans (hBres i hi)
  · intro i hi
    have hdigit : fiveAdicDigit m ((B % (5 * 5 ^ m)) * d i) =
        fiveAdicDigit m (B * d i) :=
      fiveAdicDigit_of_mod_eq m _ _ (hlamprod (d i))
    unfold FiveAdicGoodDigit
    rw [hdigit]
    exact hBgood i hi
  · intro i
    rw [cyclicResidueDistance, hlamprod (d i)]
    exact hBdist i

/-- A bounded multiplier filtering every lower five-adic layer of a finite family. -/
theorem exists_five_adic_filtered_multiplier {I : Type*} [Fintype I] [DecidableEq I]
    (d ell u : I → ℕ) (m : ℕ)
    (hd : ∀ i, 0 < d i)
    (hdecomp : ∀ i, d i = 5 ^ (ell i) * u i)
    (hu : ∀ i, ¬ 5 ∣ u i)
    (hell : ∀ i, ell i ≤ m)
    (hcard : ∀ j, j < m → (Finset.univ.filter fun i => ell i = j).card ≤ 2) :
    ∃ lam : ℕ, 0 < lam ∧ lam < 5 * 5 ^ m ∧ lam % 5 = 1 ∧ ¬ 5 ∣ lam ∧
      (∀ i, ell i < m → FiveAdicGoodDigit m (lam * d i)) ∧
      (∀ i, ell i = m → (lam * d i) % (5 * 5 ^ m) = d i % (5 * 5 ^ m)) ∧
      (∀ i, 5 ^ m ≤ cyclicResidueDistance (5 * 5 ^ m) (lam * d i)) := by
  obtain ⟨lam, hlampos, hlamlt, hlamunit, hlammod, hlamres, hlamgood, hlamdist⟩ :=
    fiveAdic_seeded_multiplier d ell u m m 1 hd hdecomp hu hell (by omega)
      (by norm_num) (by norm_num) hcard (by
        intro i hi
        have heq : ell i = m := Nat.le_antisymm (hell i) hi
        have hunit : ¬ 5 ∣ 1 * u i := by simpa using hu i
        have htop := fiveAdic_top_distance m 1 (u i) hunit
        rw [hdecomp i, heq]
        simpa using htop)
  refine ⟨lam, hlampos, hlamlt, ?_, hlamunit, hlamgood, ?_, hlamdist⟩
  · simpa using hlammod
  · intro i hi
    simpa using hlamres i (by omega)

end LonelyRunner
