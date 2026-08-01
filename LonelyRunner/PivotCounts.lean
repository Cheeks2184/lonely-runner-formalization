import LonelyRunner.PivotResidues
import Mathlib.Algebra.Order.Floor.Div
import Mathlib.Data.Finset.Interval

/-!
# Exact modular-pivot counts

This file develops the exact cardinality layer for `pivotBadResidues`.  The
strict inequality in the bad-set definition is retained throughout.
-/

namespace LonelyRunner

open Finset

/-- The strict cyclic ball of natural residues of radius `p` modulo `M`. -/
def strictCyclicBall (M p : ℕ) : Finset ℕ :=
  (Finset.range M).filter fun x => cyclicResidueDistance M x < p

theorem mem_strictCyclicBall {M p x : ℕ} :
    x ∈ strictCyclicBall M p ↔
      x < M ∧ (x < p ∨ M - p < x) := by
  by_cases hx : x < M
  · simp only [strictCyclicBall, Finset.mem_filter, Finset.mem_range, hx, true_and]
    rw [cyclicResidueDistance, Nat.mod_eq_of_lt hx, min_lt_iff]
    omega
  · simp [strictCyclicBall, hx]

/-- A strict cyclic ball is the disjoint union of its initial and terminal
arcs whenever the two arcs do not overlap.  The sharp hypothesis permits the
odd-modulus case in which the radius is `(M + 1) / 2`. -/
theorem strictCyclicBall_eq_union (M p : ℕ) (hp : 0 < p)
    (hsep : 2 * p ≤ M + 1) :
    strictCyclicBall M p =
      Finset.range p ∪ Finset.Ioo (M - p) M := by
  have hpM : p ≤ M := by omega
  ext x
  rw [mem_strictCyclicBall]
  simp only [Finset.mem_union, Finset.mem_range, Finset.mem_Ioo]
  omega

/-- Exact strict cyclic-ball count, including the closed antipodal endpoint:
under the no-overlap condition its cardinality is `2 * p - 1`. -/
theorem card_strictCyclicBall (M p : ℕ) (hp : 0 < p)
    (hsep : 2 * p ≤ M + 1) :
    (strictCyclicBall M p).card = 2 * p - 1 := by
  rw [strictCyclicBall_eq_union M p hp hsep]
  have hdisj : Disjoint (Finset.range p) (Finset.Ioo (M - p) M) := by
    rw [Finset.disjoint_left]
    intro x hxRange hxIoo
    simp only [Finset.mem_range] at hxRange
    simp only [Finset.mem_Ioo] at hxIoo
    omega
  rw [Finset.card_union_of_disjoint hdisj, Finset.card_range, Nat.card_Ioo]
  omega

/-- Multiplication by a positive scale preserves cyclic residue distance up to
that scale when the modulus is scaled by the same factor. -/
theorem cyclicResidueDistance_mul_left (g K q : ℕ) :
    cyclicResidueDistance (g * K) (g * q) =
      g * cyclicResidueDistance K q := by
  by_cases hK : K = 0
  · simp [hK, cyclicResidueDistance]
  unfold cyclicResidueDistance
  rw [Nat.mul_mod_mul_left]
  rw [← Nat.mul_sub_left_distrib]
  exact min_mul_mul_left g _ _

/-- Strict multiplication is the order-theoretic dual of natural ceiling
division.  This form is exactly what strict residue balls require. -/
theorem mul_lt_iff_lt_ceilDiv {g p q : ℕ} (hg : 0 < g) :
    g * q < p ↔ q < p ⌈/⌉ g := by
  rw [← not_iff_not]
  simp only [not_lt]
  exact (ceilDiv_le_iff_le_mul hg).symm

/-- Iterated natural ceiling division combines its positive denominators. -/
theorem ceilDiv_ceilDiv (p a b : ℕ) (ha : 0 < a) (hb : 0 < b) :
    (p ⌈/⌉ a) ⌈/⌉ b = p ⌈/⌉ (a * b) := by
  apply Nat.le_antisymm
  · rw [ceilDiv_le_iff_le_mul hb, ceilDiv_le_iff_le_mul ha]
    have h := le_smul_ceilDiv (β := ℕ) (b := p) (mul_pos ha hb)
    simpa [mul_assoc] using h
  · rw [ceilDiv_le_iff_le_mul (mul_pos ha hb)]
    have hp : p ≤ a * (p ⌈/⌉ a) :=
      le_smul_ceilDiv (β := ℕ) (b := p) ha
    have hc : p ⌈/⌉ a ≤ b * ((p ⌈/⌉ a) ⌈/⌉ b) :=
      le_smul_ceilDiv (β := ℕ) (b := p ⌈/⌉ a) hb
    calc
      p ≤ a * (p ⌈/⌉ a) := hp
      _ ≤ a * (b * ((p ⌈/⌉ a) ⌈/⌉ b)) := Nat.mul_le_mul_left a hc
      _ = (a * b) * ((p ⌈/⌉ a) ⌈/⌉ b) := by ring

/-- Residues in a strict cyclic ball which are divisible by `g`, with the
modulus presented as `g * K`. -/
def strictCyclicBallMultiples (g K p : ℕ) : Finset ℕ :=
  (strictCyclicBall (g * K) p).filter fun x => g ∣ x

/-- Dividing every residue and the modulus by `g` identifies the divisible
part of a strict ball with a strict ball of ceiling-divided radius. -/
theorem strictCyclicBallMultiples_eq_image (g K p : ℕ) (hg : 0 < g) :
    strictCyclicBallMultiples g K p =
      (strictCyclicBall K (p ⌈/⌉ g)).image (fun q => g * q) := by
  ext x
  simp only [strictCyclicBallMultiples, Finset.mem_filter, Finset.mem_image]
  constructor
  · rintro ⟨hxBall, ⟨q, rfl⟩⟩
    refine ⟨q, ?_, rfl⟩
    have hdist : cyclicResidueDistance (g * K) (g * q) < p :=
      (Finset.mem_filter.mp hxBall).2
    have hqK : q < K := by
      have := (Finset.mem_filter.mp hxBall).1
      simp only [Finset.mem_range] at this
      exact (Nat.mul_lt_mul_left hg).mp this
    apply Finset.mem_filter.mpr
    refine ⟨Finset.mem_range.mpr hqK, ?_⟩
    rw [cyclicResidueDistance_mul_left, mul_lt_iff_lt_ceilDiv hg] at hdist
    exact hdist
  · rintro ⟨q, hqBall, rfl⟩
    refine ⟨?_, dvd_mul_right g q⟩
    apply Finset.mem_filter.mpr
    have hqK : q < K := by
      exact Finset.mem_range.mp (Finset.mem_filter.mp hqBall).1
    refine ⟨Finset.mem_range.mpr ((Nat.mul_lt_mul_left hg).mpr hqK), ?_⟩
    have hdist : cyclicResidueDistance K q < p ⌈/⌉ g := by
      exact (Finset.mem_filter.mp hqBall).2
    rw [cyclicResidueDistance_mul_left, mul_lt_iff_lt_ceilDiv hg]
    exact hdist

/-- Exact number of multiples of `g` in a strict cyclic ball modulo `g * K`.
The hypothesis `2 * p ≤ g * K` implies the sharp non-overlap condition after
ceiling division. -/
theorem card_strictCyclicBallMultiples (g K p : ℕ) (hg : 0 < g) (hp : 0 < p)
    (hsep : 2 * p ≤ g * K + 1) :
    (strictCyclicBallMultiples g K p).card =
      2 * (p ⌈/⌉ g) - 1 := by
  rw [strictCyclicBallMultiples_eq_image g K p hg]
  have hinj : Set.InjOn (fun q => g * q) (strictCyclicBall K (p ⌈/⌉ g)) := by
    intro x hx y hy hxy
    exact Nat.mul_left_cancel hg hxy
  rw [Finset.card_image_iff.mpr hinj]
  have hceilPos : 0 < p ⌈/⌉ g := by
    by_contra hz
    have hz' : p ⌈/⌉ g = 0 := Nat.eq_zero_of_not_pos hz
    have hpZero : p = 0 := by
      have := le_smul_ceilDiv (β := ℕ) (b := p) hg
      simpa [hz'] using this
    exact hp.ne' hpZero
  have hceilSep : 2 * (p ⌈/⌉ g) ≤ K + 1 := by
    by_contra hfail
    have hpredLt : (p ⌈/⌉ g) - 1 < p ⌈/⌉ g := by omega
    have hmulPred : g * ((p ⌈/⌉ g) - 1) < p :=
      (mul_lt_iff_lt_ceilDiv hg).mpr hpredLt
    have hKsmall : K ≤ 2 * ((p ⌈/⌉ g) - 1) := by omega
    have hscaled : g * K ≤ 2 * (g * ((p ⌈/⌉ g) - 1)) := by
      calc
        g * K ≤ g * (2 * ((p ⌈/⌉ g) - 1)) := Nat.mul_le_mul_left g hKsmall
        _ = 2 * (g * ((p ⌈/⌉ g) - 1)) := by ring
    omega
  exact card_strictCyclicBall K (p ⌈/⌉ g) hceilPos hceilSep

/-- A block-periodic predicate has the same count in every block of length
`K`.  This finite equivalence is the combinatorial core of uniform modular
fiber counts. -/
theorem card_filter_range_mul_of_block_periodic (g K : ℕ) (hK : 0 < K)
    (P : ℕ → Prop) [DecidablePred P]
    (hperiod : ∀ k < g, ∀ q < K, P (k * K + q) ↔ P q) :
    ((Finset.range (g * K)).filter P).card =
      g * ((Finset.range K).filter P).card := by
  let S : Finset ℕ := (Finset.range (g * K)).filter P
  let Q : Finset ℕ := (Finset.range K).filter P
  let T : Finset (ℕ × ℕ) := Finset.range g ×ˢ Q
  let e : {r // r ∈ S} ≃ {z // z ∈ T} :=
    { toFun := fun r => by
        refine ⟨(r.1 / K, r.1 % K), ?_⟩
        have hr := (Finset.mem_filter.mp r.2)
        apply Finset.mem_product.mpr
        constructor
        · apply Finset.mem_range.mpr
          rw [Nat.div_lt_iff_lt_mul hK]
          simpa [Nat.mul_comm] using hr.1
        · apply Finset.mem_filter.mpr
          refine ⟨Finset.mem_range.mpr (Nat.mod_lt _ hK), ?_⟩
          have hq := hperiod (r.1 / K)
            ((Nat.div_lt_iff_lt_mul hK).mpr (by simpa [Nat.mul_comm] using hr.1))
            (r.1 % K) (Nat.mod_lt _ hK)
          have hrecompose : r.1 / K * K + r.1 % K = r.1 := by
            simpa [Nat.mul_comm] using (Nat.div_add_mod r.1 K)
          rw [← hrecompose] at hr
          exact hq.mp hr.2
      invFun := fun z => by
        refine ⟨z.1.1 * K + z.1.2, ?_⟩
        have hz := Finset.mem_product.mp z.2
        have hk : z.1.1 < g := Finset.mem_range.mp hz.1
        have hqData := Finset.mem_filter.mp hz.2
        apply Finset.mem_filter.mpr
        constructor
        · apply Finset.mem_range.mpr
          have hq : z.1.2 < K := Finset.mem_range.mp hqData.1
          nlinarith
        · exact (hperiod z.1.1 hk z.1.2
            (Finset.mem_range.mp hqData.1)).mpr hqData.2
      left_inv := fun r => by
        apply Subtype.ext
        simp only
        exact (by simpa [Nat.mul_comm, Nat.add_comm] using (Nat.div_add_mod r.1 K))
      right_inv := fun z => by
        apply Subtype.ext
        have hz := Finset.mem_product.mp z.2
        have hq : z.1.2 < K :=
          Finset.mem_range.mp (Finset.mem_filter.mp hz.2).1
        change ((z.1.1 * K + z.1.2) / K,
          (z.1.1 * K + z.1.2) % K) = z.1
        apply Prod.ext
        · change (z.1.1 * K + z.1.2) / K = z.1.1
          rw [Nat.add_comm, Nat.mul_comm z.1.1 K,
            Nat.add_mul_div_left _ _ hK,
            Nat.div_eq_of_lt hq, Nat.zero_add]
        · change (z.1.1 * K + z.1.2) % K = z.1.2
          simp [Nat.add_comm, Nat.mod_eq_of_lt hq] }
  have hcard := Fintype.card_congr e
  simpa [S, Q, T, Finset.card_product] using hcard

/-- Multiplication modulo `M`, restricted to one period, runs bijectively
through precisely the residues divisible by `gcd M a`. -/
theorem image_mul_mod_eq_filter_gcd (M a : ℕ) (hM : 0 < M) :
    (Finset.range (M / Nat.gcd M a)).image (fun q => (q * a) % M) =
      (Finset.range M).filter fun y => Nat.gcd M a ∣ y := by
  classical
  let g : ℕ := Nat.gcd M a
  let K : ℕ := M / g
  have hg : 0 < g := Nat.gcd_pos_of_pos_left a hM
  have hgM : g ∣ M := Nat.gcd_dvd_left M a
  have hga : g ∣ a := Nat.gcd_dvd_right M a
  have hMK : g * K = M := by
    dsimp [K]
    exact Nat.mul_div_cancel' hgM
  have hK : 0 < K := by
    rw [← hMK] at hM
    exact Nat.pos_of_mul_pos_left hM
  have hinj : Set.InjOn (fun q => (q * a) % M) (Finset.range K) := by
    intro q hq s hs hqs
    have hmod : q * a ≡ s * a [MOD M] := hqs
    have hcancel := hmod.cancel_right_div_gcd hM
    have hmodK : q ≡ s [MOD K] := by
      simpa [g, K] using hcancel
    exact hmodK.eq_of_lt_of_lt (Finset.mem_range.mp hq) (Finset.mem_range.mp hs)
  have hsubset :
      (Finset.range K).image (fun q => (q * a) % M) ⊆
        (Finset.range M).filter (fun y => g ∣ y) := by
    intro y hy
    obtain ⟨q, hq, rfl⟩ := Finset.mem_image.mp hy
    apply Finset.mem_filter.mpr
    constructor
    · exact Finset.mem_range.mpr (Nat.mod_lt _ hM)
    · obtain ⟨a', ha'⟩ := hga
      have hscale : (q * a) % M = g * ((q * a') % K) := by
        rw [ha', ← hMK]
        simpa [mul_assoc, mul_comm, mul_left_comm] using
          (Nat.mul_mod_mul_left g (q * a') K)
      rw [hscale]
      exact dvd_mul_right g _
  have hsourceCard :
      ((Finset.range K).image (fun q => (q * a) % M)).card = K := by
    rw [Finset.card_image_iff.mpr hinj, Finset.card_range]
  have htargetCard :
      ((Finset.range M).filter (fun y => g ∣ y)).card = K := by
    rw [← hMK, filter_range_dvd_eq_image g K hg]
    rw [Finset.card_image_iff.mpr]
    · simp
    · intro x hx y hy hxy
      exact Nat.mul_left_cancel hg hxy
  have heq := Finset.eq_of_subset_of_card_le hsubset
    (by rw [hsourceCard, htargetCard])
  simpa [g, K] using heq

/-- Exact uniform-fiber count for the preimage of a strict cyclic ball under
multiplication modulo `M`.  Every attainable residue has `gcd M a` preimages,
and the attainable residues are exactly that gcd's multiples. -/
theorem card_mul_mod_strictCyclicBall (M a p : ℕ) (hM : 0 < M) (hp : 0 < p)
    (hsep : 2 * p ≤ M + 1) :
    ((Finset.range M).filter fun r =>
      cyclicResidueDistance M (r * a) < p).card =
      Nat.gcd M a * (2 * (p ⌈/⌉ Nat.gcd M a) - 1) := by
  classical
  let g : ℕ := Nat.gcd M a
  let K : ℕ := M / g
  let P : ℕ → Prop := fun r => cyclicResidueDistance M (r * a) < p
  have hg : 0 < g := Nat.gcd_pos_of_pos_left a hM
  have hgM : g ∣ M := Nat.gcd_dvd_left M a
  have hga : g ∣ a := Nat.gcd_dvd_right M a
  have hMK : g * K = M := by
    dsimp [K]
    exact Nat.mul_div_cancel' hgM
  have hK : 0 < K := by
    rw [← hMK] at hM
    exact Nat.pos_of_mul_pos_left hM
  have hperiod : ∀ k < g, ∀ q < K, P (k * K + q) ↔ P q := by
    intro k hk q hq
    obtain ⟨a', ha'⟩ := hga
    have hmod : ((k * K + q) * a) % M = (q * a) % M := by
      rw [ha', ← hMK]
      have heq : (k * K + q) * (g * a') =
          q * (g * a') + (k * a') * (g * K) := by ring
      rw [heq, Nat.mul_comm (k * a') (g * K), Nat.add_mul_mod_self_left]
    unfold P cyclicResidueDistance
    rw [hmod]
  have hblocks := card_filter_range_mul_of_block_periodic g K hK P hperiod
  have hdomain :
      ((Finset.range K).filter P).card =
        (strictCyclicBallMultiples g K p).card := by
    let f : ℕ → ℕ := fun q => (q * a) % M
    have hinj : Set.InjOn f (Finset.range K) := by
      intro q hq s hs hqs
      have hmod : q * a ≡ s * a [MOD M] := hqs
      have hcancel := hmod.cancel_right_div_gcd hM
      have hmodK : q ≡ s [MOD K] := by
        simpa [g, K] using hcancel
      exact hmodK.eq_of_lt_of_lt (Finset.mem_range.mp hq) (Finset.mem_range.mp hs)
    have hinjFilter : Set.InjOn f ((Finset.range K).filter P) :=
      hinj.mono (Finset.filter_subset _ _)
    have hfilterImage :
        ((Finset.range K).filter P).image f =
          ((Finset.range K).image f).filter
            (fun y => cyclicResidueDistance M y < p) := by
      ext y
      constructor
      · intro hy
        obtain ⟨q, hq, rfl⟩ := Finset.mem_image.mp hy
        have hqData := Finset.mem_filter.mp hq
        apply Finset.mem_filter.mpr
        refine ⟨Finset.mem_image.mpr ⟨q, hqData.1, rfl⟩, ?_⟩
        dsimp [f]
        simpa [P, cyclicResidueDistance] using hqData.2
      · intro hy
        have hyData := Finset.mem_filter.mp hy
        obtain ⟨q, hq, rfl⟩ := Finset.mem_image.mp hyData.1
        apply Finset.mem_image.mpr
        refine ⟨q, Finset.mem_filter.mpr ⟨hq, ?_⟩, rfl⟩
        dsimp [f] at hyData ⊢
        simpa [P, cyclicResidueDistance] using hyData.2
    calc
      ((Finset.range K).filter P).card =
          (((Finset.range K).filter P).image f).card := by
            symm
            exact Finset.card_image_of_injOn hinjFilter
      _ = (((Finset.range K).image f).filter
            (fun y => cyclicResidueDistance M y < p)).card := by rw [hfilterImage]
      _ = (((Finset.range M).filter (fun y => g ∣ y)).filter
            (fun y => cyclicResidueDistance M y < p)).card := by
              rw [show (Finset.range K).image f =
                  (Finset.range M).filter (fun y => g ∣ y) by
                simpa [f, g, K] using image_mul_mod_eq_filter_gcd M a hM]
      _ = (strictCyclicBallMultiples g K p).card := by
        apply congrArg Finset.card
        ext y
        simp only [strictCyclicBallMultiples, strictCyclicBall,
          Finset.mem_filter, Finset.mem_range]
        rw [hMK]
        tauto
  have hmultipleCount := card_strictCyclicBallMultiples g K p hg hp
    (by simpa [hMK] using hsep)
  have hblocksM : ((Finset.range M).filter P).card =
      g * ((Finset.range K).filter P).card := by
    simpa only [hMK] using hblocks
  change ((Finset.range M).filter P).card = _
  rw [hblocksM, hdomain, hmultipleCount]

/-- Exact strict-ball count among residues divisible by `N`.  Dividing
`r = N * s` scales both the modulus and cyclic distance by `N`, which turns
the radius into `ceil(pivot / N)`. -/
theorem card_dvd_mul_mod_strictCyclicBall (N pivot other : ℕ)
    (hN : 2 ≤ N) (hpivot : 0 < pivot) :
    ((Finset.range (N * pivot)).filter fun r =>
      N ∣ r ∧ cyclicResidueDistance (N * pivot) (r * other) < pivot).card =
      Nat.gcd pivot other *
        (2 * (pivot ⌈/⌉ (N * Nat.gcd pivot other)) - 1) := by
  classical
  let c : ℕ := pivot ⌈/⌉ N
  let S : Finset ℕ := (Finset.range pivot).filter fun s =>
    cyclicResidueDistance pivot (s * other) < c
  let D : Finset ℕ := (Finset.range (N * pivot)).filter fun r =>
    N ∣ r ∧ cyclicResidueDistance (N * pivot) (r * other) < pivot
  have hNpos : 0 < N := by omega
  have hDS : D = S.image (fun s => N * s) := by
    ext r
    simp only [D, S, Finset.mem_filter, Finset.mem_range, Finset.mem_image]
    constructor
    · rintro ⟨hrBound, ⟨hNdiv, hdist⟩⟩
      obtain ⟨s, rfl⟩ := hNdiv
      refine ⟨s, ?_, rfl⟩
      constructor
      · exact (Nat.mul_lt_mul_left hNpos).mp hrBound
      · rw [show (N * s) * other = N * (s * other) by ring,
          cyclicResidueDistance_mul_left, mul_lt_iff_lt_ceilDiv hNpos] at hdist
        exact hdist
    · rintro ⟨s, ⟨hsBound, hdist⟩, rfl⟩
      constructor
      · exact (Nat.mul_lt_mul_left hNpos).mpr hsBound
      · constructor
        · exact dvd_mul_right N s
        · rw [show (N * s) * other = N * (s * other) by ring,
            cyclicResidueDistance_mul_left, mul_lt_iff_lt_ceilDiv hNpos]
          exact hdist
  have hinj : Set.InjOn (fun s => N * s) S := by
    intro x hx y hy hxy
    exact Nat.mul_left_cancel hNpos hxy
  have hcardDS : D.card = S.card := by
    rw [hDS, Finset.card_image_iff.mpr hinj]
  have hcpos : 0 < c := by
    by_contra hz
    have hz' : c = 0 := Nat.eq_zero_of_not_pos hz
    have hpZero : pivot = 0 := by
      have := le_smul_ceilDiv (β := ℕ) (b := pivot) hNpos
      simpa [c, hz'] using this
    exact hpivot.ne' hpZero
  have hcsep : 2 * c ≤ pivot + 1 := by
    by_contra hfail
    have hpredLt : c - 1 < c := by omega
    have hmulPred : N * (c - 1) < pivot := by
      simpa [c] using (mul_lt_iff_lt_ceilDiv hNpos).mpr hpredLt
    have hsmall : pivot ≤ 2 * (c - 1) := by omega
    have hscale : 2 * (c - 1) ≤ N * (c - 1) :=
      Nat.mul_le_mul_right (c - 1) hN
    omega
  have hsmallCount := card_mul_mod_strictCyclicBall pivot other c hpivot hcpos hcsep
  rw [hcardDS]
  change S.card = _
  rw [show S.card = Nat.gcd pivot other *
      (2 * (c ⌈/⌉ Nat.gcd pivot other) - 1) by simpa [S] using hsmallCount]
  rw [ceilDiv_ceilDiv pivot N (Nat.gcd pivot other) hNpos
    (Nat.gcd_pos_of_pos_left other hpivot)]

/-- Exact cardinality of one modular-pivot bad set.

Writing `g = gcd(other, N * pivot)` and `h = gcd(other, pivot)`, the first
term counts all residues whose multiplied phase lies in the strict cyclic
ball, while the second subtracts exactly those candidate-forbidden residues
which are divisible by `N`.  Because the ball is strict, a residue at distance
exactly `pivot` is not counted as bad. -/
theorem card_pivotBadResidues_exact (N pivot other : ℕ)
    (hN : 2 ≤ N) (hpivot : 0 < pivot) :
    (pivotBadResidues N pivot other).card =
      Nat.gcd other (N * pivot) *
          (2 * (pivot ⌈/⌉ Nat.gcd other (N * pivot)) - 1) -
        Nat.gcd other pivot *
          (2 * (pivot ⌈/⌉ (N * Nat.gcd other pivot)) - 1) := by
  classical
  let M : ℕ := N * pivot
  let A : Finset ℕ := (Finset.range M).filter fun r =>
    cyclicResidueDistance M (r * other) < pivot
  let D : Finset ℕ := (Finset.range M).filter fun r =>
    N ∣ r ∧ cyclicResidueDistance M (r * other) < pivot
  have hNpos : 0 < N := by omega
  have hM : 0 < M := Nat.mul_pos hNpos hpivot
  have hsep : 2 * pivot ≤ M + 1 := by
    have hbase : 2 * pivot ≤ N * pivot := Nat.mul_le_mul_right pivot hN
    omega
  have hA := card_mul_mod_strictCyclicBall M other pivot hM hpivot hsep
  have hD := card_dvd_mul_mod_strictCyclicBall N pivot other hN hpivot
  have hDsub : D ⊆ A := by
    intro r hr
    have hrData := Finset.mem_filter.mp hr
    exact Finset.mem_filter.mpr ⟨hrData.1, hrData.2.2⟩
  have hbad : pivotBadResidues N pivot other = A \ D := by
    ext r
    simp only [pivotBadResidues, pivotCandidates, A, D,
      Finset.mem_filter, Finset.mem_range, Finset.mem_sdiff]
    tauto
  rw [hbad, Finset.card_sdiff_of_subset hDsub, hA]
  rw [show D.card = Nat.gcd pivot other *
      (2 * (pivot ⌈/⌉ (N * Nat.gcd pivot other)) - 1) by
        simpa [D, M] using hD]
  simp only [M, Nat.gcd_comm]

end LonelyRunner
