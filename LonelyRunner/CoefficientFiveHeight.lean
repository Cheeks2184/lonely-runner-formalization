import LonelyRunner.KanoldVandermonde

/-!
The coefficient-five bounded-height theorem.

Kanold's interval selector handles every chosen missing height except three
short-interval triples. The exceptional families are repaired by an explicit
q = 19 selector or by counting a second missing height and rerunning the same
selector. Every conclusion uses the closed 1/N boundary.
-/

open Finset

namespace LonelyRunner

/-- Except for `c = 10`, every `c >= 7` has enough arithmetic mass for
the coefficient-five short-interval argument. -/
theorem three_mul_two_pow_omega_le
    (c : Nat) (hc7 : 7 ≤ c) (hc10 : c ≠ 10) :
    3 * 2 ^ ArithmeticFunction.cardDistinctFactors c ≤ c := by
  rw [cardDistinctFactors_eq_primeFactors_card]
  let s := c.primeFactors
  change 3 * 2 ^ s.card ≤ c
  by_cases hcard1 : s.card ≤ 1
  · have hp2 : 2 ^ s.card ≤ 2 := by
      exact Nat.pow_le_pow_right (by omega) hcard1
    omega
  by_cases hcard2 : s.card ≤ 2
  · have hcard : s.card = 2 := by omega
    by_cases hc12 : 12 ≤ c
    · simp [hcard]
      exact hc12
    · have hpf7 : (7 : Nat).primeFactors.card = 1 := by
        rw [show (7 : Nat) = 7 ^ 1 by norm_num,
          Nat.primeFactors_prime_pow (by norm_num) (by norm_num)]
        simp
      have hpf8 : (8 : Nat).primeFactors.card = 1 := by
        rw [show (8 : Nat) = 2 ^ 3 by norm_num,
          Nat.primeFactors_prime_pow (by norm_num) (by norm_num)]
        simp
      have hpf9 : (9 : Nat).primeFactors.card = 1 := by
        rw [show (9 : Nat) = 3 ^ 2 by norm_num,
          Nat.primeFactors_prime_pow (by norm_num) (by norm_num)]
        simp
      have hpf11 : (11 : Nat).primeFactors.card = 1 := by
        rw [show (11 : Nat) = 11 ^ 1 by norm_num,
          Nat.primeFactors_prime_pow (by norm_num) (by norm_num)]
        simp
      have hcCases : c = 7 ∨ c = 8 ∨ c = 9 ∨ c = 10 ∨ c = 11 := by
        omega
      rcases hcCases with rfl | rfl | rfl | rfl | rfl <;> simp_all [s]
  · have hcard3 : 3 ≤ s.card := by omega
    have hsne : s.Nonempty := Finset.card_pos.mp (by omega)
    let m := s.max' hsne
    let r := s.erase m
    have hm_mem : m ∈ s := by simpa [m] using Finset.max'_mem s hsne
    have hm5 : 5 ≤ m := by
      by_contra hmnot
      have hm_lt : m < 5 := by omega
      have hsub : s ⊆ {2, 3} := by
        intro p hp
        have hpprime : p.Prime :=
          Nat.prime_of_mem_primeFactors (by simpa [s] using hp)
        have hple : p ≤ m := Finset.le_max' s p hp
        have hp2 := hpprime.two_le
        have hp5 : p < 5 := lt_of_le_of_lt hple hm_lt
        have hp23 : p = 2 ∨ p = 3 := by
          have hp4 : p ≠ 4 := by
            intro hp
            subst p
            norm_num at hpprime
          omega
        simp [hp23]
      have := Finset.card_le_card hsub
      norm_num at this
      omega
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
    by_cases hm6 : 6 ≤ m
    · have hmul : 6 * 2 ^ r.card ≤ m * ∏ p ∈ r, p :=
        Nat.mul_le_mul hm6 hrest
      calc
        3 * 2 ^ s.card = 6 * 2 ^ r.card := by rw [hpow]; ring
        _ ≤ (∏ p ∈ r, p) * m := by
          simpa [Nat.mul_comm] using hmul
        _ = ∏ p ∈ s, p := hprod
        _ ≤ c := hrad_le
    · have hm : m = 5 := by omega
      have hsub : s ⊆ {2, 3, 5} := by
        intro p hp
        have hpprime : p.Prime :=
          Nat.prime_of_mem_primeFactors (by simpa [s] using hp)
        have hple : p ≤ m := Finset.le_max' s p hp
        have hp2 := hpprime.two_le
        have hp4 : p ≠ 4 := by
          intro hp
          subst p
          norm_num at hpprime
        have : p = 2 ∨ p = 3 ∨ p = 5 := by omega
        simp [this]
      have hcardle : s.card ≤ ({2, 3, 5} : Finset Nat).card :=
        Finset.card_le_card hsub
      have hcardeq : s.card = ({2, 3, 5} : Finset Nat).card := by
        norm_num at hcardle ⊢
        omega
      have hs : s = {2, 3, 5} :=
        Finset.eq_of_subset_of_card_le hsub hcardeq.ge
      rw [hs] at hrad_le ⊢
      norm_num at hrad_le ⊢
      omega

/-- The coefficient-five interval can be shorter than Kanold's length only
at the three listed triples. All subtraction is guarded by the hypotheses. -/
theorem five_short_interval_exception_classification
    {N t c : Nat} (ht : 0 < t) (hc : 0 < c) (hcN : c ≤ N)
    (hgrowth : 5 * t ≤ N) (h2c : 2 * c ≤ N + t)
    (hshort : N - c - t <
      2 ^ ArithmeticFunction.cardDistinctFactors c) :
    (N = 5 ∧ t = 1 ∧ c = 3) ∨
      (N = 10 ∧ t = 2 ∧ c = 6) ∨
      (N = 11 ∧ t = 2 ∧ c = 6) := by
  have hguard : c + t ≤ N := by omega
  have hw1 : ArithmeticFunction.cardDistinctFactors 1 = 0 :=
    cardDistinctFactors_one
  have hw2 : ArithmeticFunction.cardDistinctFactors 2 = 1 := by
    simpa using
      cardDistinctFactors_prime_pow (p := 2) (k := 1) (by norm_num) (by norm_num)
  have hw3 : ArithmeticFunction.cardDistinctFactors 3 = 1 := by
    simpa using
      cardDistinctFactors_prime_pow (p := 3) (k := 1) (by norm_num) (by norm_num)
  have hw4 : ArithmeticFunction.cardDistinctFactors 4 = 1 := by
    simpa [show (4 : Nat) = 2 ^ 2 by norm_num] using
      cardDistinctFactors_prime_pow (p := 2) (k := 2) (by norm_num) (by norm_num)
  have hw5 : ArithmeticFunction.cardDistinctFactors 5 = 1 := by
    simpa using
      cardDistinctFactors_prime_pow (p := 5) (k := 1) (by norm_num) (by norm_num)
  have hw6 : ArithmeticFunction.cardDistinctFactors 6 = 2 :=
    cardDistinctFactors_six
  by_cases hc6 : c ≤ 6
  · have hcCases : c = 1 ∨ c = 2 ∨ c = 3 ∨ c = 4 ∨ c = 5 ∨ c = 6 := by
      omega
    rcases hcCases with rfl | rfl | rfl | rfl | rfl | rfl
    all_goals simp only [hw1, hw2, hw3, hw4, hw5, hw6] at hshort
    all_goals omega
  · have hc7 : 7 ≤ c := by omega
    by_cases hc10 : c = 10
    · subst c
      have hw10 : ArithmeticFunction.cardDistinctFactors 10 = 2 := by
        rw [cardDistinctFactors_eq_primeFactors_card,
          show (10 : Nat) = 2 * 5 by norm_num,
          Nat.primeFactors_mul (by norm_num) (by norm_num)]
        have hpf2 : (2 : Nat).primeFactors = {2} := by
          simpa using Nat.primeFactors_prime_pow (p := 2) (k := 1)
            (by norm_num) (by norm_num)
        have hpf5 : (5 : Nat).primeFactors = {5} := by
          simpa using Nat.primeFactors_prime_pow (p := 5) (k := 1)
            (by norm_num) (by norm_num)
        rw [hpf2, hpf5]
        norm_num
      rw [hw10] at hshort
      norm_num at hshort
      omega
    · have hthree := three_mul_two_pow_omega_le c hc7 hc10
      omega

/-- A chosen missing height either yields the usual reciprocal/Kanold
witness, or it is one of the three exact short-interval exceptions. -/
theorem five_witness_or_exception
    (hkanold : KanoldIntervalBound)
    {n N t c : Nat} (speeds : Fin n → Nat)
    (hnN : n + 1 = N) (ht : 0 < t)
    (hpos : ∀ i, 0 < speeds i) (hbound : ∀ i, speeds i ≤ N + t)
    (hgrowth : 5 * t ≤ N) (hc : 0 < c) (hcN : c ≤ N)
    (hmissc : ∀ i, speeds i ≠ c) :
    (∃ tau : Real, ∀ i,
      (N : Real)⁻¹ ≤ circleNorm (tau * (speeds i : Real))) ∨
    ((N = 5 ∧ t = 1 ∧ c = 3) ∨
      (N = 10 ∧ t = 2 ∧ c = 6) ∨
      (N = 11 ∧ t = 2 ∧ c = 6)) := by
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
      apply five_short_interval_exception_classification ht hc hcN hgrowth h2c
      dsimp [ell] at hpell
      omega

/-- If one speed lies strictly above `[1,N]`, a family of `N-1` distinct
speeds cannot occupy every point of `[1,N]` except one prescribed hole. -/
theorem exists_second_missing_of_extra_speed
    {n N c e : Nat} (speeds : Fin n → Nat)
    (hnN : n + 1 = N) (hinj : Function.Injective speeds)
    (hc : 0 < c) (hcN : c ≤ N)
    (heN : N < e) (he : ∃ i, speeds i = e) :
    ∃ d, d ∈ Finset.Icc 1 N ∧ d ≠ c ∧ ∀ i, speeds i ≠ d := by
  classical
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
  have hcU : c ∈ U := by
    exact Finset.mem_Icc.mpr ⟨hc, hcN⟩
  have heS : e ∈ S := by
    obtain ⟨i, hi⟩ := he
    exact Finset.mem_image.mpr ⟨i, Finset.mem_univ i, hi⟩
  have heNotU : e ∉ U := by
    intro heU
    have := (Finset.mem_Icc.mp heU).2
    omega
  have hmissing : ∃ d, d ∈ U ∧ d ≠ c ∧ d ∉ S := by
    by_cases hdiff : (U.erase c \ S).Nonempty
    · obtain ⟨d, hd⟩ := hdiff
      have hdData := Finset.mem_sdiff.mp hd
      have hdErase := Finset.mem_erase.mp hdData.1
      exact ⟨d, hdErase.2, hdErase.1, hdData.2⟩
    · have heraseSub : U.erase c ⊆ S := by
        intro x hx
        by_contra hxS
        exact hdiff ⟨x, Finset.mem_sdiff.mpr ⟨hx, hxS⟩⟩
      have hsub : insert e (U.erase c) ⊆ S := by
        intro x hx
        rw [Finset.mem_insert] at hx
        rcases hx with rfl | hx
        · exact heS
        · exact heraseSub hx
      have heNotErase : e ∉ U.erase c := by
        intro heErase
        exact heNotU (Finset.mem_of_mem_erase heErase)
      have hcardErase : (U.erase c).card + 1 = U.card :=
        Finset.card_erase_add_one hcU
      have hcardInsert : (insert e (U.erase c)).card = N := by
        rw [Finset.card_insert_of_notMem heNotErase]
        omega
      have hle := Finset.card_le_card hsub
      rw [hcardInsert, hcardS] at hle
      omega
  obtain ⟨d, hdU, hdc, hdS⟩ := hmissing
  refine ⟨d, by simpa [U] using hdU, hdc, ?_⟩
  intro i hid
  apply hdS
  exact Finset.mem_image.mpr ⟨i, Finset.mem_univ i, hid⟩

theorem fiveHeight_family_witness
    {n N t : Nat} (speeds : Fin n → Nat)
    (hnN : n + 1 = N) (ht : 0 < t)
    (hpos : ∀ i, 0 < speeds i) (hinj : Function.Injective speeds)
    (hbound : ∀ i, speeds i ≤ N + t)
    (hgrowth : 5 * t ≤ N) :
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
  obtain hwitness | hexception := five_witness_or_exception hkanold
    speeds hnN ht hpos hbound hgrowth hcBounds.1 hcBounds.2 hmissc
  · exact hwitness
  rcases hexception with h513 | h106 | h116
  · rcases h513 with ⟨rfl, rfl, rfl⟩
    by_cases h6miss : ∀ i, speeds i ≠ 6
    · apply smallDenominator_family_witness speeds (by norm_num)
        (by norm_num : 0 < 3) (by norm_num : 3 ≤ 5)
      intro i hdiv
      rcases hdiv with ⟨k, hk⟩
      have hp := hpos i
      have hb := hbound i
      have hm3 := hmissc i
      have hm6 := h6miss i
      omega
    · push Not at h6miss
      obtain ⟨i6, hi6⟩ := h6miss
      obtain ⟨d, hdIcc, hd3, hmissd⟩ :=
        exists_second_missing_of_extra_speed speeds hnN hinj
          (by norm_num : 0 < 3) (by norm_num : 3 ≤ 5)
          (by norm_num : 5 < 6) ⟨i6, hi6⟩
      have hdBounds := Finset.mem_Icc.mp hdIcc
      obtain hdwitness | hdexception := five_witness_or_exception hkanold
        speeds hnN (by norm_num) hpos hbound (by norm_num)
          hdBounds.1 hdBounds.2 hmissd
      · exact hdwitness
      · rcases hdexception with hd513 | hd106 | hd116
        · omega
        · omega
        · omega
  · rcases h106 with ⟨rfl, rfl, rfl⟩
    apply twoHole_witness_of_coprime_modulus_above_height
      speeds (by norm_num : 0 < 10) (by norm_num : 0 < 6)
      hpos hbound hmissc
    refine ⟨19, ?_, ?_, ?_, ?_⟩ <;> norm_num
  · rcases h116 with ⟨rfl, rfl, rfl⟩
    by_cases h12miss : ∀ i, speeds i ≠ 12
    · apply smallDenominator_family_witness speeds (by norm_num)
        (by norm_num : 0 < 6) (by norm_num : 6 ≤ 11)
      intro i hdiv
      rcases hdiv with ⟨k, hk⟩
      have hp := hpos i
      have hb := hbound i
      have hm6 := hmissc i
      have hm12 := h12miss i
      omega
    · push Not at h12miss
      obtain ⟨i12, hi12⟩ := h12miss
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
            (by norm_num : 11 < 12) ⟨i12, hi12⟩
        have hdBounds := Finset.mem_Icc.mp hdIcc
        obtain hdwitness | hdexception := five_witness_or_exception hkanold
          speeds hnN (by norm_num) hpos hbound (by norm_num)
            hdBounds.1 hdBounds.2 hmissd
        · exact hdwitness
        · rcases hdexception with hd513 | hd106 | hd116
          · omega
          · omega
          · omega


end LonelyRunner

