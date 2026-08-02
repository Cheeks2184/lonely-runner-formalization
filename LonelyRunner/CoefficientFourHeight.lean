import LonelyRunner.CoefficientFiveHeight

/-!
The coefficient-four bounded-height theorem.

The Kanold selector can now have twelve short intervals.  Nine have an
explicit coprime modulus above the whole speed range.  In each of the other
three, an explicit modulus has complementary hole exactly `N + t`; if that
height occurs, counting supplies a second missing height and the selector is
rerun.
-/

open Finset

namespace LonelyRunner

/-- Above `39`, five times the Kanold length is bounded by the height. -/
theorem five_mul_two_pow_omega_le_of_40_le
    (c : Nat) (hc40 : 40 ≤ c) :
    5 * 2 ^ ArithmeticFunction.cardDistinctFactors c ≤ c := by
  rw [cardDistinctFactors_eq_primeFactors_card]
  let s := c.primeFactors
  change 5 * 2 ^ s.card ≤ c
  by_cases hcard2 : s.card ≤ 2
  · have hp4 : 2 ^ s.card ≤ 4 := by
      exact Nat.pow_le_pow_right (by omega) hcard2
    omega
  · have hcard3 : 3 ≤ s.card := by omega
    have hsne : s.Nonempty := Finset.card_pos.mp (by omega)
    let m := s.max' hsne
    let r := s.erase m
    have hm_mem : m ∈ s := by simpa [m] using Finset.max'_mem s hsne
    have hcardr : r.card + 1 = s.card := by
      simpa [r] using Finset.card_erase_add_one hm_mem
    have hrest : 2 ^ r.card ≤ ∏ p ∈ r, p := by
      apply Finset.pow_card_le_prod
      intro p hp
      exact (Nat.prime_of_mem_primeFactors
        (by simpa [s] using Finset.mem_of_mem_erase hp)).two_le
    have hprod : (∏ p ∈ r, p) * m = ∏ p ∈ s, p := by
      simpa [r] using Finset.prod_erase_mul s (fun p : Nat ↦ p) hm_mem
    have hrad_dvd : (∏ p ∈ s, p) ∣ c := by
      simpa [s] using Nat.prod_primeFactors_dvd c
    have hrad_le : (∏ p ∈ s, p) ≤ c :=
      Nat.le_of_dvd (by omega) hrad_dvd
    have hpow : 2 ^ s.card = 2 * 2 ^ r.card := by
      rw [← hcardr, pow_succ]
      ring
    by_cases hm10 : 10 ≤ m
    · have hmul : 10 * 2 ^ r.card ≤ m * ∏ p ∈ r, p :=
        Nat.mul_le_mul hm10 hrest
      calc
        5 * 2 ^ s.card = 10 * 2 ^ r.card := by rw [hpow]; ring
        _ ≤ (∏ p ∈ r, p) * m := by
          simpa [Nat.mul_comm] using hmul
        _ = ∏ p ∈ s, p := hprod
        _ ≤ c := hrad_le
    · have hm_lt : m < 10 := by omega
      have hsub : s ⊆ {2, 3, 5, 7} := by
        intro p hp
        have hpprime : p.Prime :=
          Nat.prime_of_mem_primeFactors (by simpa [s] using hp)
        have hple : p ≤ m := Finset.le_max' s p hp
        have hp2 := hpprime.two_le
        have hp4 : p ≠ 4 := by
          intro h
          subst p
          norm_num at hpprime
        have hp6 : p ≠ 6 := by
          intro h
          subst p
          norm_num at hpprime
        have hp8 : p ≠ 8 := by
          intro h
          subst p
          norm_num at hpprime
        have hp9 : p ≠ 9 := by
          intro h
          subst p
          norm_num at hpprime
        have : p = 2 ∨ p = 3 ∨ p = 5 ∨ p = 7 := by omega
        simp [this]
      have hcard4 : s.card ≤ 4 := by
        have := Finset.card_le_card hsub
        norm_num at this ⊢
        exact this
      by_cases hcard3le : s.card ≤ 3
      · have hp8 : 2 ^ s.card ≤ 8 := by
          exact Nat.pow_le_pow_right (by omega) hcard3le
        omega
      · have hcardeq : s.card = ({2, 3, 5, 7} : Finset Nat).card := by
          norm_num
          omega
        have hs : s = {2, 3, 5, 7} :=
          Finset.eq_of_subset_of_card_le hsub hcardeq.ge
        rw [hs] at hrad_le ⊢
        norm_num at hrad_le ⊢
        omega

private def omegaBelow40 (c : Nat) : Nat :=
  [0, 0, 1, 1, 1, 1, 2, 1, 1, 1,
   2, 1, 2, 1, 2, 2, 1, 1, 2, 1,
   2, 2, 2, 1, 2, 1, 2, 1, 2, 1,
   3, 1, 1, 2, 2, 2, 2, 1, 2, 2].getD c 0

private theorem cardDistinctFactors_eq_omegaBelow40
    (c : Nat) (hc : c < 40) :
    ArithmeticFunction.cardDistinctFactors c = omegaBelow40 c := by
  interval_cases c <;>
    norm_num [cardDistinctFactors_eq_primeFactors_card, omegaBelow40,
      Nat.primeFactors, Nat.primeFactorsList, Nat.minFac]

/-- Exact classification of every coefficient-four interval on which the
Kanold length does not fit. -/
theorem four_short_interval_exception_classification
    {N t c : Nat} (ht : 0 < t) (hc : 0 < c) (hcN : c ≤ N)
    (hgrowth : 4 * t ≤ N) (h2c : 2 * c ≤ N + t)
    (hshort : N - c - t <
      2 ^ ArithmeticFunction.cardDistinctFactors c) :
    (N = 4 ∧ t = 1 ∧ c = 2) ∨
      (N = 5 ∧ t = 1 ∧ c = 3) ∨
      (N = 8 ∧ t = 2 ∧ c = 5) ∨
      (N = 10 ∧ t = 2 ∧ c = 6) ∨
      (N = 11 ∧ t = 2 ∧ c = 6) ∨
      (N = 12 ∧ t = 3 ∧ c = 6) ∨
      (N = 16 ∧ t = 4 ∧ c = 10) ∨
      (N = 17 ∧ t = 4 ∧ c = 10) ∨
      (N = 20 ∧ t = 5 ∧ c = 12) ∨
      (N = 24 ∧ t = 6 ∧ c = 15) ∨
      (N = 48 ∧ t = 12 ∧ c = 30) ∨
      (N = 49 ∧ t = 12 ∧ c = 30) := by
  have hguard : c + t ≤ N := by omega
  have hcFive : c ≤ 5 * (N - c - t) := by omega
  have hc40 : c < 40 := by
    by_contra hnot
    have hmass := five_mul_two_pow_omega_le_of_40_le c (by omega)
    omega
  have hw := cardDistinctFactors_eq_omegaBelow40 c hc40
  rw [hw] at hshort
  interval_cases c <;>
    norm_num [omegaBelow40] at hshort ⊢ <;>
    omega

/-- A chosen missing height either yields a witness or belongs to the exact
twelve-element coefficient-four exception table. -/
theorem four_witness_or_exception
    (hkanold : KanoldIntervalBound)
    {n N t c : Nat} (speeds : Fin n → Nat)
    (hnN : n + 1 = N) (ht : 0 < t)
    (hpos : ∀ i, 0 < speeds i) (hbound : ∀ i, speeds i ≤ N + t)
    (hgrowth : 4 * t ≤ N) (hc : 0 < c) (hcN : c ≤ N)
    (hmissc : ∀ i, speeds i ≠ c) :
    (∃ tau : Real, ∀ i,
      (N : Real)⁻¹ ≤ circleNorm (tau * (speeds i : Real))) ∨
    ((N = 4 ∧ t = 1 ∧ c = 2) ∨
      (N = 5 ∧ t = 1 ∧ c = 3) ∨
      (N = 8 ∧ t = 2 ∧ c = 5) ∨
      (N = 10 ∧ t = 2 ∧ c = 6) ∨
      (N = 11 ∧ t = 2 ∧ c = 6) ∨
      (N = 12 ∧ t = 3 ∧ c = 6) ∨
      (N = 16 ∧ t = 4 ∧ c = 10) ∨
      (N = 17 ∧ t = 4 ∧ c = 10) ∨
      (N = 20 ∧ t = 5 ∧ c = 12) ∨
      (N = 24 ∧ t = 6 ∧ c = 15) ∨
      (N = 48 ∧ t = 12 ∧ c = 30) ∨
      (N = 49 ∧ t = 12 ∧ c = 30)) := by
  unfold KanoldIntervalBound at hkanold
  have hN : 0 < N := by omega
  by_cases hrecip : N + t < 2 * c
  · left
    apply smallDenominator_family_witness speeds hN hc hcN
    intro i hdiv
    rcases hdiv with ⟨k, hk⟩
    have hkpos : 0 < k := by
      by_contra hkzero
      have : k = 0 := by omega
      subst k
      simp at hk
      exact (Nat.ne_of_gt (hpos i)) hk
    have hkle : k = 1 := by
      by_contra hkone
      have hk2 : 2 ≤ k := by omega
      have hmul := Nat.mul_le_mul_left c hk2
      have hb := hbound i
      omega
    subst k
    apply hmissc i
    simpa using hk
  · have h2c : 2 * c ≤ N + t := by omega
    have hctlt : c + t < N := by omega
    let start := N + c + t + 1
    let ell := N - c - t
    have hellpos : 0 < ell := by
      dsimp [ell]
      omega
    have hsum : start + ell = 2 * N + 1 := by
      dsimp [start, ell]
      omega
    by_cases hpell :
        2 ^ ArithmeticFunction.cardDistinctFactors c ≤ ell
    · left
      obtain ⟨q, hq, hcop⟩ := hkanold c start hc
      have hqm := Finset.mem_Ico.mp hq
      apply twoHole_witness_of_coprime_modulus_above_height
        speeds hN hc hpos hbound hmissc
      refine ⟨q, ?_, ?_, ?_, hcop⟩
      · dsimp [start] at hqm
        omega
      · have hqell : q < start + ell :=
          hqm.2.trans_le (Nat.add_le_add_left hpell start)
        rw [hsum] at hqell
        omega
      · dsimp [start] at hqm
        omega
    · right
      apply four_short_interval_exception_classification
        ht hc hcN hgrowth h2c
      dsimp [ell] at hpell
      omega

/-- Distinct positive integer speeds of height at most `N+t` are lonely at
the exact closed `1/N` boundary whenever `4*t ≤ N`. -/
theorem fourHeight_family_witness
    {n N t : Nat} (speeds : Fin n → Nat)
    (hnN : n + 1 = N) (ht : 0 < t)
    (hpos : ∀ i, 0 < speeds i) (hinj : Function.Injective speeds)
    (hbound : ∀ i, speeds i ≤ N + t)
    (hgrowth : 4 * t ≤ N) :
    ∃ tau : Real, ∀ i,
      (N : Real)⁻¹ ≤ circleNorm (tau * (speeds i : Real)) := by
  classical
  have hN : 0 < N := by omega
  have hkanold : KanoldIntervalBound := by
    intro c start hc
    exact kanoldIntervalBound_vandermonde c start hc
  let S : Finset Nat := Finset.univ.image speeds
  let U : Finset Nat := Finset.Icc 1 N
  have hcardS : S.card = n := by
    dsimp [S]
    rw [Finset.card_image_iff.mpr]
    · simp
    · intro i _ j _ hij
      exact hinj hij
  have hcardU : U.card = N := by
    dsimp [U]
    rw [Nat.card_Icc]
    omega
  have hnotSubset : ¬ U ⊆ S := by
    intro hsub
    have hcard := Finset.card_le_card hsub
    rw [hcardU, hcardS] at hcard
    omega
  obtain ⟨c, hcU, hcNotS⟩ := Finset.not_subset.mp hnotSubset
  have hcBounds : 0 < c ∧ c ≤ N := by
    have hcIcc : c ∈ Finset.Icc 1 N := by simpa [U] using hcU
    exact Finset.mem_Icc.mp hcIcc
  have hmissc : ∀ i, speeds i ≠ c := by
    intro i heq
    apply hcNotS
    exact Finset.mem_image.mpr ⟨i, Finset.mem_univ i, heq⟩
  obtain hwitness | hexception := four_witness_or_exception hkanold
    speeds hnN ht hpos hbound hgrowth hcBounds.1 hcBounds.2 hmissc
  · exact hwitness
  rcases hexception with h412 | h513 | h825 | h106 | h116 | h1236 |
      h16410 | h17410 | h20512 | h24615 | h481230 | h491230
  · rcases h412 with ⟨rfl, rfl, rfl⟩
    by_cases h5miss : ∀ i, speeds i ≠ 5
    · apply twoHoleDenominator_family_witness speeds
        (by norm_num : 0 < 4) (by norm_num : 0 < 2)
        (by norm_num : 2 < 7) (by norm_num : 4 < 7)
        (by norm_num : 7 ≤ 2 * 4) (by norm_num : Nat.Coprime 2 7)
        hpos
      · intro i
        have hb := hbound i
        omega
      · exact hmissc
      · norm_num
        exact h5miss
    · push Not at h5miss
      obtain ⟨i5, hi5⟩ := h5miss
      obtain ⟨d, hdIcc, hd2, hmissd⟩ :=
        exists_second_missing_of_extra_speed speeds hnN hinj
          (by norm_num : 0 < 2) (by norm_num : 2 ≤ 4)
          (by norm_num : 4 < 5) ⟨i5, hi5⟩
      have hdBounds := Finset.mem_Icc.mp hdIcc
      obtain hdwitness | hdexception := four_witness_or_exception hkanold
        speeds hnN (by norm_num) hpos hbound (by norm_num)
          hdBounds.1 hdBounds.2 hmissd
      · exact hdwitness
      · rcases hdexception with h1 | h2 | h3 | h4 | h5 | h6 |
            h7 | h8 | h9 | h10 | h11 | h12 <;> omega
  · rcases h513 with ⟨rfl, rfl, rfl⟩
    apply twoHole_witness_of_coprime_modulus_above_height
      speeds (by norm_num : 0 < 5) (by norm_num : 0 < 3)
      hpos hbound hmissc
    refine ⟨10, ?_, ?_, ?_, ?_⟩ <;> norm_num
  · rcases h825 with ⟨rfl, rfl, rfl⟩
    apply twoHole_witness_of_coprime_modulus_above_height
      speeds (by norm_num : 0 < 8) (by norm_num : 0 < 5)
      hpos hbound hmissc
    refine ⟨16, ?_, ?_, ?_, ?_⟩ <;> norm_num
  · rcases h106 with ⟨rfl, rfl, rfl⟩
    apply twoHole_witness_of_coprime_modulus_above_height
      speeds (by norm_num : 0 < 10) (by norm_num : 0 < 6)
      hpos hbound hmissc
    refine ⟨19, ?_, ?_, ?_, ?_⟩ <;> norm_num
  · rcases h116 with ⟨rfl, rfl, rfl⟩
    by_cases h13miss : ∀ i, speeds i ≠ 13
    · apply twoHoleDenominator_family_witness speeds
        (by norm_num : 0 < 11) (by norm_num : 0 < 6)
        (by norm_num : 6 < 19) (by norm_num : 11 < 19)
        (by norm_num : 19 ≤ 2 * 11) (by norm_num : Nat.Coprime 6 19)
        hpos
      · intro i
        have hb := hbound i
        omega
      · exact hmissc
      · norm_num
        exact h13miss
    · push Not at h13miss
      obtain ⟨i13, hi13⟩ := h13miss
      obtain ⟨d, hdIcc, hd6, hmissd⟩ :=
        exists_second_missing_of_extra_speed speeds hnN hinj
          (by norm_num : 0 < 6) (by norm_num : 6 ≤ 11)
          (by norm_num : 11 < 13) ⟨i13, hi13⟩
      have hdBounds := Finset.mem_Icc.mp hdIcc
      obtain hdwitness | hdexception := four_witness_or_exception hkanold
        speeds hnN (by norm_num) hpos hbound (by norm_num)
          hdBounds.1 hdBounds.2 hmissd
      · exact hdwitness
      · rcases hdexception with h1 | h2 | h3 | h4 | h5 | h6 |
            h7 | h8 | h9 | h10 | h11 | h12 <;> omega
  · rcases h1236 with ⟨rfl, rfl, rfl⟩
    apply twoHole_witness_of_coprime_modulus_above_height
      speeds (by norm_num : 0 < 12) (by norm_num : 0 < 6)
      hpos hbound hmissc
    refine ⟨23, ?_, ?_, ?_, ?_⟩ <;> norm_num
  · rcases h16410 with ⟨rfl, rfl, rfl⟩
    apply twoHole_witness_of_coprime_modulus_above_height
      speeds (by norm_num : 0 < 16) (by norm_num : 0 < 10)
      hpos hbound hmissc
    refine ⟨31, ?_, ?_, ?_, ?_⟩ <;> norm_num
  · rcases h17410 with ⟨rfl, rfl, rfl⟩
    apply twoHole_witness_of_coprime_modulus_above_height
      speeds (by norm_num : 0 < 17) (by norm_num : 0 < 10)
      hpos hbound hmissc
    refine ⟨33, ?_, ?_, ?_, ?_⟩ <;> norm_num
  · rcases h20512 with ⟨rfl, rfl, rfl⟩
    by_cases h25miss : ∀ i, speeds i ≠ 25
    · apply twoHoleDenominator_family_witness speeds
        (by norm_num : 0 < 20) (by norm_num : 0 < 12)
        (by norm_num : 12 < 37) (by norm_num : 20 < 37)
        (by norm_num : 37 ≤ 2 * 20) (by norm_num : Nat.Coprime 12 37)
        hpos
      · intro i
        have hb := hbound i
        omega
      · exact hmissc
      · norm_num
        exact h25miss
    · push Not at h25miss
      obtain ⟨i25, hi25⟩ := h25miss
      obtain ⟨d, hdIcc, hd12, hmissd⟩ :=
        exists_second_missing_of_extra_speed speeds hnN hinj
          (by norm_num : 0 < 12) (by norm_num : 12 ≤ 20)
          (by norm_num : 20 < 25) ⟨i25, hi25⟩
      have hdBounds := Finset.mem_Icc.mp hdIcc
      obtain hdwitness | hdexception := four_witness_or_exception hkanold
        speeds hnN (by norm_num) hpos hbound (by norm_num)
          hdBounds.1 hdBounds.2 hmissd
      · exact hdwitness
      · rcases hdexception with h1 | h2 | h3 | h4 | h5 | h6 |
            h7 | h8 | h9 | h10 | h11 | h12 <;> omega
  · rcases h24615 with ⟨rfl, rfl, rfl⟩
    apply twoHole_witness_of_coprime_modulus_above_height
      speeds (by norm_num : 0 < 24) (by norm_num : 0 < 15)
      hpos hbound hmissc
    refine ⟨46, ?_, ?_, ?_, ?_⟩ <;> norm_num
  · rcases h481230 with ⟨rfl, rfl, rfl⟩
    apply twoHole_witness_of_coprime_modulus_above_height
      speeds (by norm_num : 0 < 48) (by norm_num : 0 < 30)
      hpos hbound hmissc
    refine ⟨91, ?_, ?_, ?_, ?_⟩ <;> norm_num
  · rcases h491230 with ⟨rfl, rfl, rfl⟩
    apply twoHole_witness_of_coprime_modulus_above_height
      speeds (by norm_num : 0 < 49) (by norm_num : 0 < 30)
      hpos hbound hmissc
    refine ⟨97, ?_, ?_, ?_, ?_⟩ <;> norm_num

end LonelyRunner
