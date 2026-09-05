import Mathlib.FieldTheory.Finite.Basic
import Mathlib.Algebra.Polynomial.Eval.Degree

/-!
# Prime-field affine avoidance

The lemmas in this file isolate the finite-field calculation used by the
affine-avoidance route.  The public theorem is intentionally stated over an
arbitrary finite index type: repeated slopes are permitted.
-/

namespace LonelyRunner

open scoped BigOperators
open Finset Polynomial

private theorem zmod_sum_pow_card_sub_one (p : ℕ) [Fact p.Prime] :
    ∑ x : ZMod p, x ^ (p - 1) = -1 := by
  let F := ZMod p
  have hp : 0 < p := (Fact.out : p.Prime).pos
  have htwo : 2 ≤ p := (Fact.out : p.Prime).two_le
  have hexp : p - 1 ≠ 0 := by omega
  let e : Fˣ ↪ F := ⟨fun x => x, Units.val_injective⟩
  have he : Finset.univ.map e = (Finset.univ : Finset F) \ {0} := by
    ext x
    simpa only [Finset.mem_map, Finset.mem_univ, Function.Embedding.coeFn_mk,
      true_and, Finset.mem_sdiff, Finset.mem_singleton, e] using! isUnit_iff_ne_zero
  calc
    ∑ x : F, x ^ (p - 1) = ∑ x ∈ (Finset.univ : Finset F) \ {0}, x ^ (p - 1) := by
      rw [← Finset.sum_sdiff ({0} : Finset F).subset_univ, Finset.sum_singleton,
        zero_pow hexp, add_zero]
    _ = ∑ x : Fˣ, (x ^ (p - 1) : F) := by
      simp [e, ← he, Finset.univ.sum_map]
    _ = -1 := by
      rw [FiniteField.sum_pow_units F]
      apply if_pos
      rw [show Fintype.card F = p by exact ZMod.card p]

/-- The top-degree finite-field power-sum calculation used by the polynomial
route.  This is deliberately kept separate from the affine argument. -/
private theorem sum_eval_monic_degree_card_sub_one
    (p : ℕ) [Fact p.Prime] (f : (ZMod p)[X])
    (hmonic : f.Monic) (hdegree : f.natDegree = p - 1) :
    ∑ x : ZMod p, f.eval x = -1 := by
  classical
  simp_rw [Polynomial.eval_eq_sum_range]
  rw [hdegree]
  rw [Finset.sum_comm]
  -- Each lower-degree power sum vanishes; the top coefficient is monic.
  rw [Finset.sum_eq_single (p - 1)]
  · rw [← hdegree, hmonic.coeff_natDegree]
    simp only [one_mul]
    rw [hdegree, zmod_sum_pow_card_sub_one]
  · intro i hi hmem
    have hil : i < p - 1 := by
      rw [Finset.mem_range] at hi
      omega
    rw [← Finset.mul_sum, FiniteField.sum_pow_lt_card_sub_one (ZMod p) i]
    · simp
    · simpa [ZMod.card] using hil
  · simp

private theorem zmod_prod_univ_units_coe_eq_neg_one (p : ℕ) [Fact p.Prime] :
    ∏ x : (ZMod p)ˣ, (x : ZMod p) = -1 := by
  have h := congrArg (Units.coeHom (ZMod p))
    (FiniteField.prod_univ_units_id_eq_neg_one (K := ZMod p))
  simpa only [map_prod, Units.coeHom_apply, Units.val_neg, Units.val_one] using h

private noncomputable def affineProduct {p : ℕ} [Fact p.Prime] {I : Type*}
    [Fintype I] (a v : I → ZMod p) : (ZMod p)[X] :=
  ∏ i : I, (X + C (v i / a i))

private def affineGoodSet {p : ℕ} [Fact p.Prime] {I : Type*}
    [Fintype I] (a v : I → ZMod p) : Finset (ZMod p) :=
  ((Finset.univ : Finset (ZMod p)).erase 0).filter fun m =>
    ∀ i, v i + m * a i ≠ 0

private theorem mem_affineGoodSet {p : ℕ} [Fact p.Prime] {I : Type*}
    [Fintype I] (a v : I → ZMod p) (m : ZMod p) :
    m ∈ affineGoodSet a v ↔ m ≠ 0 ∧ ∀ i, v i + m * a i ≠ 0 := by
  simp [affineGoodSet]

private theorem affineProduct_eval {p : ℕ} [Fact p.Prime] {I : Type*}
    [Fintype I] (a v : I → ZMod p) (m : ZMod p) :
    (affineProduct a v).eval m = ∏ i : I, (m + v i / a i) := by
  simp [affineProduct, Polynomial.eval_prod]

private theorem affineProduct_monic {p : ℕ} [Fact p.Prime] {I : Type*}
    [Fintype I] (a v : I → ZMod p) : (affineProduct a v).Monic := by
  classical
  unfold affineProduct
  apply Finset.prod_induction
  · intro q r hq hr
    exact hq.mul hr
  · exact Polynomial.monic_one
  · intro i _
    exact Polynomial.monic_X_add_C _

private theorem affineProduct_natDegree {p : ℕ} [Fact p.Prime] {I : Type*}
    [Fintype I] (a v : I → ZMod p) :
    (affineProduct a v).natDegree = Fintype.card I := by
  classical
  unfold affineProduct
  rw [Polynomial.natDegree_prod]
  · simp only [Polynomial.natDegree_X_add_C, Finset.sum_const, nsmul_eq_mul,
      mul_one, Finset.card_univ]
    rfl
  · intro i _
    exact (Polynomial.monic_X_add_C (v i / a i)).ne_zero

private theorem affineProduct_eval_eq_zero_of_exists_zero
    {p : ℕ} [Fact p.Prime] {I : Type*} [Fintype I]
    (a v : I → ZMod p) (ha : ∀ i, a i ≠ 0) (m : ZMod p)
    (hm : ∃ i, v i + m * a i = 0) :
    (affineProduct a v).eval m = 0 := by
  classical
  rw [affineProduct_eval]
  obtain ⟨i, hi⟩ := hm
  apply Finset.prod_eq_zero (Finset.mem_univ i)
  have hai := ha i
  have hdiv : m = (-v i) / a i :=
    (eq_div_iff hai).mpr (eq_neg_of_add_eq_zero_right hi)
  rw [hdiv]
  field_simp [hai]
  simp

private theorem affineProduct_eval_eq_one_of_product
    {p : ℕ} [Fact p.Prime] {I : Type*} [Fintype I]
    (a v : I → ZMod p) (ha : ∀ i, a i ≠ 0) (m : ZMod p)
    (hvalues : ∏ i : I, (v i + m * a i) = -1)
    (hslopes : ∏ i : I, a i = -1) :
    (affineProduct a v).eval m = 1 := by
  classical
  rw [affineProduct_eval]
  calc
    (∏ i : I, (m + v i / a i)) = ∏ i : I, (v i + m * a i) / a i := by
      apply Finset.prod_congr rfl
      intro i _
      field_simp [ha i]
      ring
    _ = (∏ i : I, (v i + m * a i)) / ∏ i : I, a i :=
      Finset.prod_div_distrib _ _
    _ = 1 := by rw [hvalues, hslopes]; simp

/- A failure of avoidance makes every good affine slice enumerate the units.
The equal-cardinality step is essential: no injectivity of the slopes or the
offsets is assumed. -/
private theorem affineProduct_eval_eq_one_of_no_avoidance
    {p : ℕ} [Fact p.Prime] {I : Type*} [Fintype I]
    (hcard : Fintype.card I = p - 1) (a v : I → ZMod p)
    (ha : ∀ i, a i ≠ 0) (hslopes : ∏ i : I, a i = -1)
    (hno : ¬ ∃ r s : ZMod p, r ≠ 0 ∧ s ≠ 0 ∧
      ∀ i, s * v i + r * a i ≠ 0 ∧ s * v i + r * a i ≠ -1)
    (m : ZMod p) (hm : m ∈ affineGoodSet a v) :
    (affineProduct a v).eval m = 1 := by
  classical
  obtain ⟨hm0, hm⟩ := (mem_affineGoodSet a v m).mp hm
  let f : I → (ZMod p)ˣ := fun i => Units.mk0 (v i + m * a i) (hm i)
  have hsurj : Function.Surjective f := by
    intro x
    let s : ZMod p := -(x : ZMod p)⁻¹
    have hs : s ≠ 0 := neg_ne_zero.mpr (inv_ne_zero x.ne_zero)
    by_contra hx
    apply hno
    refine ⟨s * m, s, mul_ne_zero hs hm0, hs, ?_⟩
    intro i
    have hscale : s * v i + (s * m) * a i = s * (v i + m * a i) := by ring
    rw [hscale]
    refine ⟨mul_ne_zero hs (hm i), ?_⟩
    intro hi
    have hval : v i + m * a i = (x : ZMod p) := by
      apply mul_left_cancel₀ hs
      rw [hi]
      change -1 = -(x : ZMod p)⁻¹ * (x : ZMod p)
      rw [neg_mul, inv_mul_cancel₀ x.ne_zero]
    exact hx ⟨i, Units.ext hval⟩
  have hbij : Function.Bijective f :=
    (Fintype.bijective_iff_surjective_and_card f).mpr
      ⟨hsurj, hcard.trans (ZMod.card_units p).symm⟩
  apply affineProduct_eval_eq_one_of_product a v ha m _ hslopes
  calc
    (∏ i : I, (v i + m * a i)) = ∏ x : (ZMod p)ˣ, (x : ZMod p) :=
      Fintype.prod_bijective f hbij _ _ (fun _ => rfl)
    _ = -1 := zmod_prod_univ_units_coe_eq_neg_one p

/-- Affine avoidance over an odd prime field with a prescribed slope product.
The slopes may repeat; their product is the only global slope hypothesis.
This finite-field theorem does not assume, or establish, a Lonely Runner
instance or a supply of suitable primes for arbitrary integer speeds. -/
theorem affine_avoidance_of_slope_product
    (p : ℕ) [Fact p.Prime] (_hodd : Odd p)
    {I : Type*} [Fintype I] (hcard : Fintype.card I = p - 1)
    (a v : I → ZMod p) (ha : ∀ i, a i ≠ 0)
    (hslopes : ∏ i : I, a i = -1)
    (hvzero : ∃ i, v i = 0) (hvnonzero : ∃ i, v i ≠ 0) :
    ∃ r s : ZMod p, r ≠ 0 ∧ s ≠ 0 ∧
      ∀ i, s * v i + r * a i ≠ 0 ∧ s * v i + r * a i ≠ -1 := by
  classical
  by_contra hno
  let G := affineGoodSet a v
  have heval : ∀ m : ZMod p, (affineProduct a v).eval m =
      if m ∈ G then 1 else 0 := by
    intro m
    split_ifs with hm
    · exact affineProduct_eval_eq_one_of_no_avoidance hcard a v ha hslopes hno m hm
    · apply affineProduct_eval_eq_zero_of_exists_zero a v ha m
      by_cases hm0 : m = 0
      · obtain ⟨i, hi⟩ := hvzero
        exact ⟨i, by simp [hm0, hi]⟩
      · have hbad : ¬ ∀ i, v i + m * a i ≠ 0 := by
          intro hall
          exact hm ((mem_affineGoodSet a v m).mpr ⟨hm0, hall⟩)
        simpa only [not_forall, not_not] using hbad
  have hsum : ∑ m : ZMod p, (affineProduct a v).eval m = (G.card : ZMod p) := by
    simp_rw [heval]
    simp
  have hcast : (G.card : ZMod p) = -1 := by
    rw [← hsum]
    exact sum_eval_monic_degree_card_sub_one p (affineProduct a v)
      (affineProduct_monic a v) ((affineProduct_natDegree a v).trans hcard)
  -- The natural cardinal lies below p.  This is where a prime field, rather
  -- than an arbitrary finite extension of it, matters to the argument.
  have hsubset : G ⊆ (Finset.univ : Finset (ZMod p)).erase 0 :=
    Finset.filter_subset _ _
  have hbound : G.card ≤ p - 1 := by
    have h := Finset.card_le_card hsubset
    simpa [ZMod.card] using h
  have hp : 0 < p := (Fact.out : p.Prime).pos
  have hlt : G.card < p := by omega
  have hcardG : G.card = p - 1 := by
    have h := congrArg ZMod.val hcast
    rw [ZMod.val_natCast_of_lt hlt] at h
    have hneg : (-1 : ZMod p).val = p - 1 := by
      obtain ⟨n, rfl⟩ := Nat.exists_eq_succ_of_ne_zero (Nat.ne_of_gt hp)
      exact ZMod.val_neg_one n
    exact h.trans hneg
  have hfull : G = (Finset.univ : Finset (ZMod p)).erase 0 := by
    apply Finset.eq_of_subset_of_card_le hsubset
    simp [hcardG, ZMod.card]
  -- A nonzero offset supplies an explicit nonzero root outside the good set,
  -- contradicting its forced equality with every nonzero field element.
  obtain ⟨j, hj⟩ := hvnonzero
  let m : ZMod p := -v j / a j
  have hm0 : m ≠ 0 := div_ne_zero (neg_ne_zero.mpr hj) (ha j)
  have hmG : m ∈ G := by rw [hfull]; simp [hm0]
  have hgood := ((mem_affineGoodSet a v m).mp hmG).2 j
  apply hgood
  simp [m, div_mul_cancel₀ _ (ha j)]

/-- With one fewer slope, no product condition or restriction on the offsets
is needed.  A dummy zero-offset row completes the prescribed product when
some offset is nonzero; the all-zero case is a direct finite counting argument. -/
theorem affine_avoidance_card_sub_two
    (p : ℕ) [Fact p.Prime] (hodd : Odd p)
    {I : Type*} [Fintype I] (hcard : Fintype.card I = p - 2)
    (a v : I → ZMod p) (ha : ∀ i, a i ≠ 0) :
    ∃ r s : ZMod p, r ≠ 0 ∧ s ≠ 0 ∧
      ∀ i, s * v i + r * a i ≠ 0 ∧ s * v i + r * a i ≠ -1 := by
  classical
  have hp2 : 2 ≤ p := (Fact.out : p.Prime).two_le
  by_cases hv : ∃ i, v i ≠ 0
  · let A : ZMod p := ∏ i : I, a i
    have hA : A ≠ 0 := Finset.prod_ne_zero_iff.mpr (fun i _ => ha i)
    let a' : Option I → ZMod p := fun o => Option.elim o (-A⁻¹) a
    let v' : Option I → ZMod p := fun o => Option.elim o 0 v
    have hc' : Fintype.card (Option I) = p - 1 := by
      simp only [Fintype.card_option, hcard]
      omega
    have ha' : ∀ i, a' i ≠ 0 := by
      intro i
      cases i with
      | none => exact neg_ne_zero.mpr (inv_ne_zero hA)
      | some i => exact ha i
    have hprod : ∏ i : Option I, a' i = -1 := by
      rw [Fintype.prod_option]
      change -A⁻¹ * A = -1
      rw [neg_mul, inv_mul_cancel₀ hA]
    have hzero : ∃ i, v' i = 0 := ⟨none, rfl⟩
    have hnonzero : ∃ i, v' i ≠ 0 := by
      obtain ⟨i, hi⟩ := hv
      exact ⟨some i, hi⟩
    obtain ⟨r, s, hr, hs, h⟩ := affine_avoidance_of_slope_product p hodd
      hc' a' v' ha' hprod hzero hnonzero
    exact ⟨r, s, hr, hs, fun i => h (some i)⟩
  · have hv0 : ∀ i, v i = 0 := by simpa only [not_exists, not_not] using hv
    -- At most p−2 forbidden nonzero values cannot exhaust p−1 units.
    have hex : ∃ r : (ZMod p)ˣ, ∀ i, (r : ZMod p) * a i ≠ -1 := by
      by_contra hnone
      let f : I → (ZMod p)ˣ := fun i => Units.mk0 (-(a i)⁻¹)
        (neg_ne_zero.mpr (inv_ne_zero (ha i)))
      have hf : Function.Surjective f := by
        intro r
        by_contra hr
        apply hnone
        refine ⟨r, ?_⟩
        intro i hi
        apply hr
        refine ⟨i, Units.ext ?_⟩
        change -(a i)⁻¹ = (r : ZMod p)
        apply mul_right_cancel₀ (ha i)
        rw [neg_mul, inv_mul_cancel₀ (ha i), hi]
      have hc := Fintype.card_le_of_surjective f hf
      rw [ZMod.card_units, hcard] at hc
      omega
    obtain ⟨r, hr⟩ := hex
    refine ⟨r, 1, r.ne_zero, one_ne_zero, ?_⟩
    intro i
    simp only [hv0 i, mul_zero, zero_add]
    exact ⟨mul_ne_zero r.ne_zero (ha i), hr i⟩

end LonelyRunner
