import LonelyRunner.PairSumGeometry
import LonelyRunner.PivotBoundary
import LonelyRunner.StructuredClasses
import LonelyRunner.BHKRealReduction
import Mathlib.Data.Finset.Max
import Mathlib.Algebra.Order.Floor.Ring

/-!
# Completeness of finite pair-sum certificates

For a supplied positive-integer witness, a finite floor cell has an attained
minimum pair.  Its two active cell faces give a pair-sum time with no loss of
the supplied closed margin.  This proves equivalence of witness and certificate
existence; it does not supply a certificate uniformly.
-/

namespace LonelyRunner

/-- Circle distance is bounded by distance to every prescribed integer lift. -/
theorem circleNorm_le_abs_sub_int (x : ℝ) (z : ℤ) :
    circleNorm x ≤ |x - (z : ℝ)| := by
  rw [circleNorm_eq_abs_sub_round]
  exact round_le x z

/-- A point with closed circle margin lies in the corresponding closed unit band. -/
theorem int_band_of_circleNorm_ge (z : ℤ) (x δ : ℝ)
    (hlower : (z : ℝ) ≤ x) (hupper : x ≤ (z : ℝ) + 1)
    (hgood : δ ≤ circleNorm x) :
    (z : ℝ) + δ ≤ x ∧ x ≤ (z : ℝ) + 1 - δ := by
  have hleft : δ ≤ x - (z : ℝ) := by
    have h := hgood.trans (circleNorm_le_abs_sub_int x z)
    rw [abs_of_nonneg (sub_nonneg.mpr hlower)] at h
    linarith
  have hright : δ ≤ (z : ℝ) + 1 - x := by
    have h := hgood.trans (circleNorm_le_abs_sub_int x (z + 1))
    rw [show x - ((z + 1 : ℤ) : ℝ) = - ((z : ℝ) + 1 - x) by push_cast; ring,
      abs_neg, abs_of_nonneg (by linarith)] at h
    exact h
  constructor <;> linarith

/-- A finite floor cell has an attained pair-sum peak preserving its supplied margin. -/
theorem exists_balanced_pairSum_cell_peak {n : ℕ}
    (hn : 2 ≤ n) (speeds z : Fin n → ℕ)
    (hspeeds : ∀ i, 0 < speeds i)
    (hzlt : ∀ i, z i < speeds i)
    (δ time : ℝ) (hδ : 0 < δ)
    (hlower : ∀ i, (z i : ℝ) + δ ≤ time * (speeds i : ℝ))
    (hupper : ∀ i, time * (speeds i : ℝ) ≤ (z i : ℝ) + 1 - δ) :
    ∃ p q : Fin n, p ≠ q ∧ ∃ (r : ℕ) (M T : ℝ),
      0 < r ∧ r < speeds p + speeds q ∧
      T = (r : ℝ) / ((speeds p + speeds q : ℕ) : ℝ) ∧
      δ ≤ M ∧ M ≤ (1 : ℝ) / 2 ∧
      T * (speeds p : ℝ) = (z p : ℝ) + M ∧
      T * (speeds q : ℝ) = (z q : ℝ) + 1 - M ∧
      ∀ i, (z i : ℝ) + M ≤ T * (speeds i : ℝ) ∧
        T * (speeds i : ℝ) ≤ (z i : ℝ) + 1 - M := by
  classical
  let L : Fin n → ℝ → ℝ := fun i m => ((z i : ℝ) + m) / (speeds i : ℝ)
  let R : Fin n → ℝ → ℝ := fun i m => ((z i : ℝ) + 1 - m) / (speeds i : ℝ)
  let C : Fin n × Fin n → ℝ := fun ij =>
    ((speeds ij.1 : ℝ) * ((z ij.2 : ℝ) + 1) -
      (speeds ij.2 : ℝ) * (z ij.1 : ℝ)) /
      ((speeds ij.1 : ℝ) + (speeds ij.2 : ℝ))
  have hspeedR : ∀ i, 0 < (speeds i : ℝ) := fun i => by exact_mod_cast hspeeds i
  have hsumR : ∀ i j, 0 < (speeds i : ℝ) + (speeds j : ℝ) := fun i j =>
    add_pos (hspeedR i) (hspeedR j)
  -- This equivalence turns the simultaneous cell constraints into pair margins.
  have hC : ∀ i j m, m ≤ C (i, j) ↔ L i m ≤ R j m := by
    intro i j m
    dsimp [C, L, R]
    rw [div_le_div_iff₀ (hspeedR i) (hspeedR j), le_div_iff₀ (hsumR i j)]
    constructor <;> intro h <;> linarith
  have hCδ : ∀ i j, δ ≤ C (i, j) := by
    intro i j
    apply (hC i j δ).mpr
    dsimp [L, R]
    rw [div_le_div_iff₀ (hspeedR i) (hspeedR j)]
    nlinarith [hlower i, hupper j]
  have hnonempty : (Finset.univ : Finset (Fin n × Fin n)).Nonempty := by
    exact ⟨(⟨0, by omega⟩, ⟨0, by omega⟩), Finset.mem_univ _⟩
  -- Minimize over all ordered pairs, deliberately retaining diagonal candidates.
  obtain ⟨pq, hpqmem, hpqmin⟩ :=
    Finset.exists_min_image (Finset.univ : Finset (Fin n × Fin n)) C hnonempty
  let p := pq.1
  let q := pq.2
  let M : ℝ := C pq
  let T : ℝ := ((z p : ℝ) + (z q : ℝ) + 1) /
    ((speeds p : ℝ) + (speeds q : ℝ))
  have hsumPQ : 0 < (speeds p : ℝ) + (speeds q : ℝ) := hsumR p q
  have hpqsum : (speeds pq.1 : ℝ) + (speeds pq.2 : ℝ) ≠ 0 := by
    simpa [p, q] using hsumPQ.ne'
  have hmin : ∀ ij : Fin n × Fin n, M ≤ C ij := by
    intro ij
    exact hpqmin ij (Finset.mem_univ _)
  have hMδ : δ ≤ M := by simpa [M, p, q] using hCδ p q
  have hMhalf : M ≤ (1 : ℝ) / 2 := by
    have hdiag := hmin (p, p)
    have hCpp : C (p, p) = (1 : ℝ) / 2 := by
      dsimp [C]
      rw [show (speeds p : ℝ) + speeds p = 2 * (speeds p : ℝ) by ring]
      field_simp [hspeedR p |>.ne']
      ring
    simpa [M, hCpp] using hdiag
  have hactiveL : L p M = T := by
    apply (div_eq_iff (hspeedR p).ne').mpr
    dsimp [L, M, T, C, p, q]
    field_simp [hpqsum] <;> ring
  have hactiveR : T = R q M := by
    apply (eq_div_iff (hspeedR q).ne').mpr
    dsimp [R, M, T, C, p, q]
    field_simp [hpqsum] <;> ring
  have hbands : ∀ i, (z i : ℝ) + M ≤ T * (speeds i : ℝ) ∧
      T * (speeds i : ℝ) ≤ (z i : ℝ) + 1 - M := by
    intro i
    -- The two orientations `(i,q)` and `(p,i)` give the lower and upper bands.
    have hleft : L i M ≤ R q M := (hC i q M).mp (hmin (i, q))
    have hright : L p M ≤ R i M := (hC p i M).mp (hmin (p, i))
    rw [← hactiveR] at hleft
    rw [hactiveL] at hright
    constructor
    · dsimp [L] at hleft
      exact (div_le_iff₀ (hspeedR i)).mp hleft
    · dsimp [R] at hright
      exact (le_div_iff₀ (hspeedR i)).mp hright
  have hactp : T * (speeds p : ℝ) = (z p : ℝ) + M := by
    dsimp [L] at hactiveL
    exact ((div_eq_iff (hspeedR p).ne').mp hactiveL).symm
  have hactq : T * (speeds q : ℝ) = (z q : ℝ) + 1 - M := by
    dsimp [R] at hactiveR
    exact (eq_div_iff (hspeedR q).ne').mp hactiveR
  by_cases hpq : p = q
  · subst q
    -- A diagonal minimum is the half-cell case; replace it by labels zero and one.
    have hMeq : M = (1 : ℝ) / 2 := by
      rw [← hpq] at hactq
      nlinarith [hactp, hactq]
    let a : Fin n := ⟨0, by omega⟩
    let b : Fin n := ⟨1, by omega⟩
    have hab : a ≠ b := by
      intro h
      have := congrArg Fin.val h
      dsimp [a, b] at this
      omega
    let r : ℕ := z a + z b + 1
    refine ⟨a, b, hab, r, M, T, ?_, ?_, ?_, hMδ, hMhalf, ?_, ?_, ?_⟩
    · omega
    · have ha := hzlt a; have hb := hzlt b; omega
    · dsimp [r]
      have hsum : T * ((speeds a : ℝ) + (speeds b : ℝ)) =
          ((z a + z b + 1 : ℕ) : ℝ) := by
        rw [show T * ((speeds a : ℝ) + (speeds b : ℝ)) =
          T * (speeds a : ℝ) + T * (speeds b : ℝ) by ring]
        have ha := (hbands a).1
        have ha' := (hbands a).2
        have hb := (hbands b).1
        have hb' := (hbands b).2
        rw [hMeq] at ha ha' hb hb'
        have haeq : T * (speeds a : ℝ) = (z a : ℝ) + (1 : ℝ) / 2 := by
          norm_num at ha ha'
          linarith
        have hbeq : T * (speeds b : ℝ) = (z b : ℝ) + (1 : ℝ) / 2 := by
          norm_num at hb hb'
          linarith
        rw [haeq, hbeq]
        push_cast
        ring
      convert (eq_div_iff (hsumR a b).ne').mpr hsum using 1 <;> push_cast <;> rfl
    · have ha := hbands a
      rw [hMeq] at ha ⊢
      linarith [ha.1, ha.2]
    · have hb := hbands b
      rw [hMeq] at hb ⊢
      linarith [hb.1, hb.2]
    · exact hbands
  · let r : ℕ := z p + z q + 1
    refine ⟨p, q, hpq, r, M, T, ?_, ?_, ?_, hMδ, hMhalf, hactp, hactq, hbands⟩
    · omega
    · have hp := hzlt p; have hq := hzlt q; omega
    · dsimp [r, T]
      push_cast
      rfl

/-- Every positive-margin witness for positive integer speeds yields a positive pair-sum time. -/
theorem exists_pairSum_time_of_witness {n : ℕ}
    (hn : 2 ≤ n) (speeds : Fin n → ℕ)
    (hspeeds : ∀ i, 0 < speeds i)
    (δ time : ℝ) (hδ : 0 < δ)
    (hwitness : ∀ i, δ ≤ circleNorm (time * (speeds i : ℝ))) :
    ∃ p q : Fin n, p ≠ q ∧ ∃ r : ℕ,
      0 < r ∧ r < speeds p + speeds q ∧
      ∀ i, δ ≤ circleNorm
        (((r : ℝ) / ((speeds p + speeds q : ℕ) : ℝ)) *
          (speeds i : ℝ)) := by
  let tau : ℝ := Int.fract time
  let z : Fin n → ℕ := fun i => ⌊tau * (speeds i : ℝ)⌋₊
  have ht0 : 0 ≤ tau := Int.fract_nonneg _
  have ht1 : tau < 1 := Int.fract_lt_one _
  have hphase0 : ∀ i, 0 ≤ tau * (speeds i : ℝ) := by intro i; positivity
  have hphaseLt : ∀ i, tau * (speeds i : ℝ) < speeds i := by
    intro i
    have := mul_lt_mul_of_pos_right ht1 (by exact_mod_cast hspeeds i : (0:ℝ)<speeds i)
    simpa [mul_one] using this
  have hzlt : ∀ i, z i < speeds i := by
    intro i
    exact (Nat.floor_lt (hphase0 i)).mpr (hphaseLt i)
  have hfloorlo : ∀ i, (z i : ℝ) ≤ tau * (speeds i : ℝ) := by
    intro i; exact Nat.floor_le (hphase0 i)
  have hfloorhi : ∀ i, tau * (speeds i : ℝ) ≤ (z i : ℝ) + 1 := by
    intro i; exact (Nat.lt_floor_add_one _).le
  have hband : ∀ i, (z i : ℝ) + δ ≤ tau * (speeds i : ℝ) ∧
      tau * (speeds i : ℝ) ≤ (z i : ℝ) + 1 - δ := by
    intro i
    apply int_band_of_circleNorm_ge (z i : ℤ)
    · exact_mod_cast hfloorlo i
    · exact_mod_cast hfloorhi i
    · rw [circleNorm_fract_mul_nat time (speeds i)]
      exact hwitness i
  obtain ⟨p, q, hpq, r, M, T, hr0, hrlt, hT, hδM, hMhalf, _, _, hbands⟩ :=
    exists_balanced_pairSum_cell_peak hn speeds z hspeeds hzlt δ tau hδ
      (fun i => (hband i).1) (fun i => (hband i).2)
  refine ⟨p, q, hpq, r, hr0, hrlt, fun i => ?_⟩
  rw [← hT]
  exact hδM.trans (circleNorm_ge_of_int_band (z i : ℤ)
    (T * (speeds i : ℝ)) M (le_of_lt (lt_of_lt_of_le hδ hδM)) hMhalf
    (hbands i).1 (hbands i).2)

/-- A witness at threshold `1 / N` yields the original finite pair-sum certificate. -/
theorem pairSumCertificate_of_witness {n N : ℕ}
    (hn : 2 ≤ n) (speeds : Fin n → ℕ)
    (hN : 0 < N) (hspeeds : ∀ i, 0 < speeds i)
    (time : ℝ)
    (hwitness : ∀ i, (N : ℝ)⁻¹ ≤ circleNorm (time * (speeds i : ℝ))) :
    PairSumCertificate N speeds := by
  obtain ⟨p, q, hpq, r, hr0, hrlt, hgood⟩ :=
    exists_pairSum_time_of_witness hn speeds hspeeds ((N : ℝ)⁻¹) time
      (by positivity) hwitness
  exact (pairSumCertificate_iff_pair_time speeds hN hspeeds).mpr
    ⟨p, q, hpq, r, hrlt, hgood⟩

/-- Fixed-instance completeness of pair-sum certificates for at least two speeds. -/
theorem exists_witness_iff_pairSumCertificate {n N : ℕ}
    (hn : 2 ≤ n) (speeds : Fin n → ℕ)
    (hN : 0 < N) (hspeeds : ∀ i, 0 < speeds i) :
    (∃ time : ℝ, ∀ i,
      (N : ℝ)⁻¹ ≤ circleNorm (time * (speeds i : ℝ))) ↔
    PairSumCertificate N speeds := by
  constructor
  · rintro ⟨time, htime⟩
    exact pairSumCertificate_of_witness hn speeds hN hspeeds time htime
  · exact pairSumCertificate_circleNorm speeds hN hspeeds

/-- The positive-integer conjecture is equivalent to its finite pair-sum formulation. -/
theorem positiveIntegerConjecture_iff_pairSumCertificateConjecture :
    PositiveIntegerConjecture ↔ PositiveIntegerPairSumCertificateConjecture := by
  constructor
  · intro h n hn speeds hinj hspeeds
    obtain ⟨time, htime⟩ := h n (by omega) speeds hinj hspeeds
    exact pairSumCertificate_of_witness hn speeds (by omega) hspeeds time htime
  · exact positiveIntegerPairSumCertificateConjecture_imp_positiveIntegerConjecture

/-- Transport pair-sum completeness through the existing canonical BHK equivalence. -/
theorem conjecture_iff_pairSumCertificateConjecture :
    Conjecture ↔ PositiveIntegerPairSumCertificateConjecture :=
  conjecture_iff_positiveIntegerConjecture.trans
    positiveIntegerConjecture_iff_pairSumCertificateConjecture

end LonelyRunner
