import LonelyRunner.CoefficientFourHeight

/-!
The coefficient-three bounded-height theorem.

Short Kanold intervals are no longer finite in this regime.  The replacement
argument counts missing base heights against occupied extra heights: every
unrepaired short hole lies above `N/2`, and blocking its reciprocal witness
uses the distinct extra speed `2*c`.  There is always one more base hole than
extra speed.  Three small parameter pairs are repaired explicitly.
-/

open Finset

namespace LonelyRunner

private def omegaBelow11 (c : Nat) : Nat :=
  [0, 0, 1, 1, 1, 1, 2, 1, 1, 1, 2].getD c 0

private theorem cardDistinctFactors_eq_omegaBelow11
    (c : Nat) (hc : c < 11) :
    ArithmeticFunction.cardDistinctFactors c = omegaBelow11 c := by
  interval_cases c <;>
    norm_num [cardDistinctFactors_eq_primeFactors_card, omegaBelow11,
      Nat.primeFactors, Nat.primeFactorsList, Nat.minFac]

/-- A coefficient-three short interval has its hole strictly above `N/2`,
apart from five exact small triples. -/
theorem three_short_interval_large_or_exception
    {N t c : Nat} (ht : 0 < t) (hc : 0 < c) (hcN : c ≤ N)
    (hgrowth : 3 * t ≤ N) (h2c : 2 * c ≤ N + t)
    (hshort : N - c - t <
      2 ^ ArithmeticFunction.cardDistinctFactors c) :
    (N < 2 * c ∧ 2 * c ≤ N + t ∧
      N - c - t < 2 ^ ArithmeticFunction.cardDistinctFactors c) ∨
      (N = 4 ∧ t = 1 ∧ c = 2) ∨
      (N = 6 ∧ t = 2 ∧ c = 3) ∨
      (N = 12 ∧ t = 3 ∧ c = 6) ∨
      (N = 12 ∧ t = 4 ∧ c = 6) ∨
      (N = 13 ∧ t = 4 ∧ c = 6) := by
  have hguard : c + t ≤ N := by omega
  by_cases hc10 : c < 11
  · have hw := cardDistinctFactors_eq_omegaBelow11 c hc10
    rw [hw] at hshort ⊢
    interval_cases c <;>
      norm_num [omegaBelow11] at hshort ⊢ <;>
      omega
  · have hmass := three_mul_two_pow_omega_le c (by omega) (by omega)
    left
    exact ⟨by omega, by omega, hshort⟩

/-- For a chosen missing height in the coefficient-three regime, either the
usual selector works, the hole is above `N/2`, or one of five small triples
has occurred. -/
theorem three_witness_or_large_or_exception
    (hkanold : KanoldIntervalBound)
    {n N t c : Nat} (speeds : Fin n → Nat)
    (hnN : n + 1 = N) (ht : 0 < t)
    (hpos : ∀ i, 0 < speeds i) (hbound : ∀ i, speeds i ≤ N + t)
    (hgrowth : 3 * t ≤ N) (hc : 0 < c) (hcN : c ≤ N)
    (hmissc : ∀ i, speeds i ≠ c) :
    (∃ tau : Real, ∀ i,
      (N : Real)⁻¹ ≤ circleNorm (tau * (speeds i : Real))) ∨
    ((N < 2 * c ∧ 2 * c ≤ N + t ∧
        N - c - t < 2 ^ ArithmeticFunction.cardDistinctFactors c) ∨
      (N = 4 ∧ t = 1 ∧ c = 2) ∨
      (N = 6 ∧ t = 2 ∧ c = 3) ∨
      (N = 12 ∧ t = 3 ∧ c = 6) ∨
      (N = 12 ∧ t = 4 ∧ c = 6) ∨
      (N = 13 ∧ t = 4 ∧ c = 6)) := by
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
    have hguard : c + t ≤ N := by omega
    let start := N + c + t + 1
    let ell := N - c - t
    by_cases hpell :
        2 ^ ArithmeticFunction.cardDistinctFactors c ≤ ell
    · left
      have hellpos : 0 < ell := lt_of_lt_of_le (by positivity) hpell
      have hctlt : c + t < N := by
        dsimp [ell] at hellpos
        omega
      have hsum : start + ell = 2 * N + 1 := by
        dsimp [start, ell]
        omega
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
      apply three_short_interval_large_or_exception
        ht hc hcN hgrowth h2c
      dsimp [ell] at hpell
      omega

/-- Distinct positive integer speeds of height at most `N+t` are lonely at
the exact closed `1/N` boundary whenever `3*t ≤ N`. -/
theorem threeHeight_family_witness
    {n N t : Nat} (speeds : Fin n → Nat)
    (hnN : n + 1 = N) (ht : 0 < t)
    (hpos : ∀ i, 0 < speeds i) (hinj : Function.Injective speeds)
    (hbound : ∀ i, speeds i ≤ N + t)
    (hgrowth : 3 * t ≤ N) :
    ∃ tau : Real, ∀ i,
      (N : Real)⁻¹ ≤ circleNorm (tau * (speeds i : Real)) := by
  classical
  have hN : 0 < N := by omega
  have hkanold : KanoldIntervalBound := by
    intro c start hc
    exact kanoldIntervalBound_vandermonde c start hc
  let S : Finset Nat := Finset.univ.image speeds
  let U : Finset Nat := Finset.Icc 1 N
  let M : Finset Nat := U \ S
  let E : Finset Nat := S \ U
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
  have hcardME : M.card = E.card + 1 := by
    have hM := Finset.card_sdiff_add_card_inter U S
    have hE := Finset.card_sdiff_add_card_inter S U
    rw [Finset.inter_comm S U] at hE
    rw [hcardU] at hM
    rw [hcardS] at hE
    change (U \ S).card = (S \ U).card + 1
    omega
  have hMne : M.Nonempty := Finset.card_pos.mp (by omega)
  have hdata (c : Nat) (hcM : c ∈ M) :
      0 < c ∧ c ≤ N ∧ ∀ i, speeds i ≠ c := by
    have hcUS := Finset.mem_sdiff.mp (by simpa [M] using hcM)
    have hcIcc := Finset.mem_Icc.mp (by simpa [U] using hcUS.1)
    refine ⟨hcIcc.1, hcIcc.2, ?_⟩
    intro i heq
    apply hcUS.2
    exact Finset.mem_image.mpr ⟨i, Finset.mem_univ i, heq⟩
  by_contra hno
  by_cases h62 : N = 6 ∧ t = 2
  · rcases h62 with ⟨rfl, rfl⟩
    have hMsub : M ⊆ {3, 4} := by
      intro c hcM
      obtain ⟨hc, hcN, hmissc⟩ := hdata c hcM
      obtain hw | hcase := three_witness_or_large_or_exception hkanold
        speeds hnN (by norm_num) hpos hbound (by norm_num)
          hc hcN hmissc
      · exact (hno hw).elim
      · rcases hcase with hlarge | h412 | h623 | h1236 | h1246 | h1346
        all_goals simp only [Finset.mem_insert, Finset.mem_singleton]
        all_goals omega
    by_cases h4M : 4 ∈ M
    · by_cases h8miss : ∀ i, speeds i ≠ 8
      · apply hno
        apply smallDenominator_family_witness speeds (by norm_num)
          (by norm_num : 0 < 4) (by norm_num : 4 ≤ 6)
        intro i hdiv
        rcases hdiv with ⟨k, hk⟩
        have hp := hpos i
        have hb := hbound i
        have hm4 := (hdata 4 h4M).2.2 i
        have hm8 := h8miss i
        omega
      · push Not at h8miss
        obtain ⟨i8, hi8⟩ := h8miss
        have h8E : 8 ∈ E := by
          apply Finset.mem_sdiff.mpr
          constructor
          · exact Finset.mem_image.mpr ⟨i8, Finset.mem_univ i8, hi8⟩
          · intro h8U
            have h8bounds : (8 : Nat) ∈ Finset.Icc 1 6 := by
              simpa [U] using h8U
            norm_num at h8bounds
        have hEcard : E.card = 1 := by
          have hMle := Finset.card_le_card hMsub
          have hEpos := Finset.card_pos.mpr ⟨8, h8E⟩
          norm_num at hMle
          omega
        have hMcard : M.card = 2 := by omega
        have h3M : 3 ∈ M := by
          by_contra h3not
          have hsub : M ⊆ {4} := by
            intro x hx
            have hxB := hMsub hx
            have hx3 : x ≠ 3 := by
              intro h
              subst x
              exact h3not hx
            simp only [Finset.mem_insert, Finset.mem_singleton] at hxB ⊢
            omega
          have := Finset.card_le_card hsub
          norm_num at this
          omega
        have h7miss : ∀ i, speeds i ≠ 7 := by
          intro i7 hi7
          have h7E : 7 ∈ E := by
            apply Finset.mem_sdiff.mpr
            constructor
            · exact Finset.mem_image.mpr ⟨i7, Finset.mem_univ i7, hi7⟩
            · intro h7U
              have h7bounds : (7 : Nat) ∈ Finset.Icc 1 6 := by
                simpa [U] using h7U
              norm_num at h7bounds
          have hsub : ({7, 8} : Finset Nat) ⊆ E := by
            intro x hx
            simp only [Finset.mem_insert, Finset.mem_singleton] at hx
            rcases hx with rfl | rfl
            · exact h7E
            · exact h8E
          have := Finset.card_le_card hsub
          norm_num at this
          omega
        apply hno
        apply twoHoleDenominator_family_witness speeds
          (by norm_num : 0 < 6) (by norm_num : 0 < 3)
          (by norm_num : 3 < 10) (by norm_num : 6 < 10)
          (by norm_num : 10 ≤ 2 * 6) (by norm_num : Nat.Coprime 3 10)
          hpos
        · intro i
          have := hbound i
          omega
        · exact (hdata 3 h3M).2.2
        · norm_num
          exact h7miss
    · have h3M : 3 ∈ M := by
        obtain ⟨c, hcM⟩ := hMne
        have hcB := hMsub hcM
        simp only [Finset.mem_insert, Finset.mem_singleton] at hcB
        have hc4 : c ≠ 4 := by
          intro h
          subst c
          exact h4M hcM
        have hc3 : c = 3 := by omega
        simpa [hc3] using hcM
      have hEzero : E.card = 0 := by
        have hsub : M ⊆ {3} := by
          intro x hx
          have hxB := hMsub hx
          have hx4 : x ≠ 4 := by
            intro h
            subst x
            exact h4M hx
          simp only [Finset.mem_insert, Finset.mem_singleton] at hxB ⊢
          omega
        have := Finset.card_le_card hsub
        norm_num at this
        omega
      have h7miss : ∀ i, speeds i ≠ 7 := by
        intro i7 hi7
        have h7E : 7 ∈ E := by
          apply Finset.mem_sdiff.mpr
          constructor
          · exact Finset.mem_image.mpr ⟨i7, Finset.mem_univ i7, hi7⟩
          · intro h7U
            have h7bounds : (7 : Nat) ∈ Finset.Icc 1 6 := by
              simpa [U] using h7U
            norm_num at h7bounds
        exact (Finset.card_ne_zero.mpr ⟨7, h7E⟩) hEzero
      apply hno
      apply twoHoleDenominator_family_witness speeds
        (by norm_num : 0 < 6) (by norm_num : 0 < 3)
        (by norm_num : 3 < 10) (by norm_num : 6 < 10)
        (by norm_num : 10 ≤ 2 * 6) (by norm_num : Nat.Coprime 3 10)
        hpos
      · intro i
        have := hbound i
        omega
      · exact (hdata 3 h3M).2.2
      · norm_num
        exact h7miss
  by_cases h124 : N = 12 ∧ t = 4
  · rcases h124 with ⟨rfl, rfl⟩
    have hMsub : M ⊆ {6, 7, 8} := by
      intro c hcM
      obtain ⟨hc, hcN, hmissc⟩ := hdata c hcM
      obtain hw | hcase := three_witness_or_large_or_exception hkanold
        speeds hnN (by norm_num) hpos hbound (by norm_num)
          hc hcN hmissc
      · exact (hno hw).elim
      · rcases hcase with hlarge | h412 | h623 | h1236 | h1246 | h1346
        all_goals simp only [Finset.mem_insert, Finset.mem_singleton]
        all_goals omega
    have h14_of_h7 (h7M : 7 ∈ M) : ∃ i, speeds i = 14 := by
      by_contra h14miss
      push Not at h14miss
      apply hno
      apply smallDenominator_family_witness speeds (by norm_num)
        (by norm_num : 0 < 7) (by norm_num : 7 ≤ 12)
      intro i hdiv
      rcases hdiv with ⟨k, hk⟩
      have hp := hpos i
      have hb := hbound i
      have hm7 := (hdata 7 h7M).2.2 i
      have hm14 := h14miss i
      omega
    have h16_of_h8 (h8M : 8 ∈ M) : ∃ i, speeds i = 16 := by
      by_contra h16miss
      push Not at h16miss
      apply hno
      apply smallDenominator_family_witness speeds (by norm_num)
        (by norm_num : 0 < 8) (by norm_num : 8 ≤ 12)
      intro i hdiv
      rcases hdiv with ⟨k, hk⟩
      have hp := hpos i
      have hb := hbound i
      have hm8 := (hdata 8 h8M).2.2 i
      have hm16 := h16miss i
      omega
    have hdouble (c : Nat) (hcM : c ∈ M) (hc6 : c ≠ 6) :
        ∃ i, speeds i = 2 * c := by
      have hcB := hMsub hcM
      simp only [Finset.mem_insert, Finset.mem_singleton] at hcB
      rcases hcB with rfl | rfl | rfl
      · exact (hc6 rfl).elim
      · exact h14_of_h7 hcM
      · exact h16_of_h8 hcM
    have h6M : 6 ∈ M := by
      by_contra h6not
      have hmap : M.image (fun c : Nat ↦ 2 * c) ⊆ E := by
        intro z hz
        obtain ⟨c, hcM, rfl⟩ := Finset.mem_image.mp hz
        obtain ⟨i, hi⟩ := hdouble c hcM (by
          intro h
          subst c
          exact h6not hcM)
        apply Finset.mem_sdiff.mpr
        constructor
        · exact Finset.mem_image.mpr ⟨i, Finset.mem_univ i, hi⟩
        · intro hU
          have hcB := hMsub hcM
          have hboundU := Finset.mem_Icc.mp (by simpa [U] using hU)
          simp only [Finset.mem_insert, Finset.mem_singleton] at hcB
          rcases hcB with rfl | rfl | rfl
          · exact h6not hcM
          · norm_num at hboundU
          · norm_num at hboundU
      have hcardImage : (M.image (fun c : Nat ↦ 2 * c)).card = M.card := by
        rw [Finset.card_image_iff.mpr]
        intro a _ b _ hab
        change 2 * a = 2 * b at hab
        omega
      have hle := Finset.card_le_card hmap
      rw [hcardImage] at hle
      omega
    let A := M.erase 6
    let D := A.image (fun c : Nat ↦ 2 * c)
    have hDsub : D ⊆ E := by
      intro z hz
      obtain ⟨c, hcA, rfl⟩ := Finset.mem_image.mp (by simpa [D] using hz)
      have hcErase := Finset.mem_erase.mp (by simpa [A] using hcA)
      obtain ⟨i, hi⟩ := hdouble c hcErase.2 hcErase.1
      apply Finset.mem_sdiff.mpr
      constructor
      · exact Finset.mem_image.mpr ⟨i, Finset.mem_univ i, hi⟩
      · intro hU
        have hcB := hMsub hcErase.2
        have := Finset.mem_Icc.mp (by simpa [U] using hU)
        simp only [Finset.mem_insert, Finset.mem_singleton] at hcB
        omega
    have hcardD : D.card + 1 = M.card := by
      have hcardA : A.card + 1 = M.card := by
        simpa [A] using Finset.card_erase_add_one h6M
      have himage : D.card = A.card := by
        dsimp [D]
        rw [Finset.card_image_iff.mpr]
        intro a _ b _ hab
        change 2 * a = 2 * b at hab
        omega
      omega
    have h13miss : ∀ i, speeds i ≠ 13 := by
      intro i13 hi13
      have h13E : 13 ∈ E := by
        apply Finset.mem_sdiff.mpr
        constructor
        · exact Finset.mem_image.mpr ⟨i13, Finset.mem_univ i13, hi13⟩
        · intro hU
          have hbounds : (13 : Nat) ∈ Finset.Icc 1 12 := by
            simpa [U] using hU
          norm_num at hbounds
      have h13notD : 13 ∉ D := by
        intro hz
        obtain ⟨c, _, hc⟩ := Finset.mem_image.mp (by simpa [D] using hz)
        omega
      have hsub : insert 13 D ⊆ E := by
        intro x hx
        rw [Finset.mem_insert] at hx
        rcases hx with rfl | hx
        · exact h13E
        · exact hDsub hx
      have hle := Finset.card_le_card hsub
      rw [Finset.card_insert_of_notMem h13notD] at hle
      omega
    apply hno
    apply twoHoleDenominator_family_witness speeds
      (by norm_num : 0 < 12) (by norm_num : 0 < 6)
      (by norm_num : 6 < 19) (by norm_num : 12 < 19)
      (by norm_num : 19 ≤ 2 * 12) (by norm_num : Nat.Coprime 6 19)
      hpos
    · intro i
      have := hbound i
      omega
    · exact (hdata 6 h6M).2.2
    · norm_num
      exact h13miss
  by_cases h134 : N = 13 ∧ t = 4
  · rcases h134 with ⟨rfl, rfl⟩
    have hMsub : M ⊆ {6, 8} := by
      intro c hcM
      obtain ⟨hc, hcN, hmissc⟩ := hdata c hcM
      obtain hw | hcase := three_witness_or_large_or_exception hkanold
        speeds hnN (by norm_num) hpos hbound (by norm_num)
          hc hcN hmissc
      · exact (hno hw).elim
      · rcases hcase with hlarge | h412 | h623 | h1236 | h1246 | h1346
        · have hw := cardDistinctFactors_eq_omegaBelow11 c (by omega)
          rw [hw] at hlarge
          simp only [Finset.mem_insert, Finset.mem_singleton]
          have hc78 : c = 7 ∨ c = 8 := by omega
          rcases hc78 with rfl | rfl
          · norm_num [omegaBelow11] at hlarge
          · omega
        all_goals simp only [Finset.mem_insert, Finset.mem_singleton]
        all_goals omega
    have h16_of_h8 (h8M : 8 ∈ M) : ∃ i, speeds i = 16 := by
      by_contra h16miss
      push Not at h16miss
      apply hno
      apply smallDenominator_family_witness speeds (by norm_num)
        (by norm_num : 0 < 8) (by norm_num : 8 ≤ 13)
      intro i hdiv
      rcases hdiv with ⟨k, hk⟩
      have hp := hpos i
      have hb := hbound i
      have hm8 := (hdata 8 h8M).2.2 i
      have hm16 := h16miss i
      omega
    have h6M : 6 ∈ M := by
      by_contra h6not
      obtain ⟨c, hcM⟩ := hMne
      have hcB := hMsub hcM
      have hc6 : c ≠ 6 := by
        intro h
        subst c
        exact h6not hcM
      have hc8 : c = 8 := by
        simp only [Finset.mem_insert, Finset.mem_singleton] at hcB
        omega
      subst c
      have hEzero : E.card = 0 := by
        have hsub : M ⊆ {8} := by
          intro x hx
          have hxB := hMsub hx
          have hx6 : x ≠ 6 := by
            intro h
            subst x
            exact h6not hx
          simp only [Finset.mem_insert, Finset.mem_singleton] at hxB ⊢
          omega
        have := Finset.card_le_card hsub
        norm_num at this
        omega
      obtain ⟨i16, hi16⟩ := h16_of_h8 hcM
      have h16E : 16 ∈ E := by
        apply Finset.mem_sdiff.mpr
        constructor
        · exact Finset.mem_image.mpr ⟨i16, Finset.mem_univ i16, hi16⟩
        · intro hU
          have hbounds : (16 : Nat) ∈ Finset.Icc 1 13 := by
            simpa [U] using hU
          norm_num at hbounds
      exact (Finset.card_ne_zero.mpr ⟨16, h16E⟩) hEzero
    have h17miss : ∀ i, speeds i ≠ 17 := by
      intro i17 hi17
      have h17E : 17 ∈ E := by
        apply Finset.mem_sdiff.mpr
        constructor
        · exact Finset.mem_image.mpr ⟨i17, Finset.mem_univ i17, hi17⟩
        · intro hU
          have hbounds : (17 : Nat) ∈ Finset.Icc 1 13 := by
            simpa [U] using hU
          norm_num at hbounds
      by_cases h8Magain : 8 ∈ M
      · obtain ⟨i16, hi16⟩ := h16_of_h8 h8Magain
        have h16E : 16 ∈ E := by
          apply Finset.mem_sdiff.mpr
          constructor
          · exact Finset.mem_image.mpr ⟨i16, Finset.mem_univ i16, hi16⟩
          · intro hU
            have hbounds : (16 : Nat) ∈ Finset.Icc 1 13 := by
              simpa [U] using hU
            norm_num at hbounds
        have hMcard : M.card = 2 := by
          have hsub : ({6, 8} : Finset Nat) ⊆ M := by
            intro x hx
            simp only [Finset.mem_insert, Finset.mem_singleton] at hx
            rcases hx with rfl | rfl
            · exact h6M
            · exact h8Magain
          have hlo := Finset.card_le_card hsub
          have hhi := Finset.card_le_card hMsub
          norm_num at hlo hhi
          omega
        have hEcard : E.card = 1 := by omega
        have hsub : ({16, 17} : Finset Nat) ⊆ E := by
          intro x hx
          simp only [Finset.mem_insert, Finset.mem_singleton] at hx
          rcases hx with rfl | rfl
          · exact h16E
          · exact h17E
        have := Finset.card_le_card hsub
        norm_num at this
        omega
      · have hsub : M ⊆ {6} := by
          intro x hx
          have hxB := hMsub hx
          have hx8 : x ≠ 8 := by
            intro h
            subst x
            exact h8Magain hx
          simp only [Finset.mem_insert, Finset.mem_singleton] at hxB ⊢
          omega
        have hMle := Finset.card_le_card hsub
        norm_num at hMle
        have hEzero : E.card = 0 := by omega
        exact (Finset.card_ne_zero.mpr ⟨17, h17E⟩) hEzero
    apply hno
    apply twoHoleDenominator_family_witness speeds
      (by norm_num : 0 < 13) (by norm_num : 0 < 6)
      (by norm_num : 6 < 23) (by norm_num : 13 < 23)
      (by norm_num : 23 ≤ 2 * 13) (by norm_num : Nat.Coprime 6 23)
      hpos
    · intro i
      have := hbound i
      omega
    · exact (hdata 6 h6M).2.2
    · norm_num
      exact h17miss
  have hmap : M.image (fun c : Nat ↦ 2 * c) ⊆ E := by
    intro z hz
    obtain ⟨c, hcM, rfl⟩ := Finset.mem_image.mp hz
    obtain ⟨hc, hcN, hmissc⟩ := hdata c hcM
    obtain hw | hcase := three_witness_or_large_or_exception hkanold
      speeds hnN ht hpos hbound hgrowth hc hcN hmissc
    · exact (hno hw).elim
    have hlarge : N < 2 * c := by
      rcases hcase with hlarge | h412 | h623 | h1236 | h1246 | h1346
      · exact hlarge.1
      · rcases h412 with ⟨rfl, rfl, rfl⟩
        have hw := fourHeight_family_witness speeds hnN (by norm_num)
          hpos hinj hbound (by norm_num)
        exact (hno hw).elim
      · exact (h62 ⟨h623.1, h623.2.1⟩).elim
      · rcases h1236 with ⟨rfl, rfl, rfl⟩
        have hw := fourHeight_family_witness speeds hnN (by norm_num)
          hpos hinj hbound (by norm_num)
        exact (hno hw).elim
      · exact (h124 ⟨h1246.1, h1246.2.1⟩).elim
      · exact (h134 ⟨h1346.1, h1346.2.1⟩).elim
    have htwo : ∃ i, speeds i = 2 * c := by
      by_contra hnot
      push Not at hnot
      have hdivnone : ∀ i, ¬ c ∣ speeds i := by
        intro i hdiv
        rcases hdiv with ⟨k, hk⟩
        have hp := hpos i
        have hb := hbound i
        have htltc : t < c := by omega
        have hkCases : k = 0 ∨ k = 1 ∨ k = 2 ∨ 3 ≤ k := by omega
        rcases hkCases with rfl | rfl | rfl | hk3
        · simp at hk
          omega
        · exact hmissc i (by simpa using hk)
        · exact hnot i (by simpa [Nat.mul_comm] using hk)
        · have hmul := Nat.mul_le_mul_left c hk3
          omega
      have hw := smallDenominator_family_witness speeds hN hc hcN hdivnone
      exact hno hw
    obtain ⟨i2, hi2⟩ := htwo
    apply Finset.mem_sdiff.mpr
    constructor
    · exact Finset.mem_image.mpr ⟨i2, Finset.mem_univ i2, hi2⟩
    · intro hU
      have := Finset.mem_Icc.mp (by simpa [U] using hU)
      omega
  have hcardImage : (M.image (fun c : Nat ↦ 2 * c)).card = M.card := by
    rw [Finset.card_image_iff.mpr]
    intro a _ b _ hab
    change 2 * a = 2 * b at hab
    omega
  have hle := Finset.card_le_card hmap
  rw [hcardImage] at hle
  omega

end LonelyRunner
