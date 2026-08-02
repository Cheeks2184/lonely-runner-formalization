import LonelyRunner.SmallDenominatorWitness
import Mathlib.Data.Nat.ModEq
import Mathlib.Data.Finset.Interval
import Mathlib.Tactic

/-!
# The two-hole bounded-height theorem

Positive distinct integer speeds bounded by `n+2` have a lonely time at the
closed `1/(n+1)` boundary.  The reusable modular lemma explicitly records the
range assumptions needed to identify the two residues adjacent to zero.
-/

namespace LonelyRunner

/-- Every inclusive interval containing at least `c` consecutive naturals
contains a representative congruent to one modulo positive `c`. -/
theorem exists_modEq_one_in_interval {c L U : Nat} (hc : 0 < c)
    (hlen : L + c - 1 ≤ U) :
    ∃ u, L ≤ u ∧ u ≤ U ∧ u % c = 1 % c := by
  let e := (1 + c - L % c) % c
  have he : e < c := Nat.mod_lt _ hc
  refine ⟨L + e, by omega, ?_, ?_⟩
  · omega
  · rw [Nat.add_mod]
    by_cases hc1 : c = 1
    · subst c
      exact Nat.mod_eq_zero_of_dvd (one_dvd _)
    have hc2 : 2 ≤ c := by omega
    let z := L % c
    have hzlt : z < c := Nat.mod_lt _ hc
    rw [Nat.mod_eq_of_lt he]
    change (z + e) % c = 1 % c
    have hone : 1 % c = 1 := Nat.mod_eq_of_lt hc2
    rw [hone]
    by_cases hz0 : z = 0
    · have heval : e = 1 := by
        dsimp [e]
        rw [show L % c = z by rfl, hz0]
        simpa using Nat.mod_eq_of_lt hc2
      simp [hz0, heval, Nat.mod_eq_of_lt hc2]
    by_cases hz1 : z = 1
    · have heval : e = 0 := by
        dsimp [e]
        rw [show L % c = z by rfl, hz1]
        simp
      simp [hz1, heval, Nat.mod_eq_of_lt hc2]
    · have harglt : 1 + c - z < c := by omega
      have heval : e = 1 + c - z := by
        dsimp [e]
        rw [show L % c = z by rfl]
        exact Nat.mod_eq_of_lt harglt
      rw [heval]
      have hsum : z + (1 + c - z) = c + 1 := by omega
      rw [hsum, Nat.add_mod]
      simp [Nat.mod_eq_of_lt hc2]

/-- The congruence used in the interval construction gives the required
coprimality after adding one further copy of `c`. -/
theorem coprime_add_of_mod_eq_one {c u : Nat} (hc : 0 < c)
    (hu : u % c = 1 % c) : c.Coprime (c + u) := by
  by_cases hc1 : c = 1
  · subst c
    simp
  have hc2 : 2 ≤ c := by omega
  have hu' : u % c = 1 := by simpa [Nat.mod_eq_of_lt hc2] using hu
  have hdecomp : u = c * (u / c) + 1 := by
    have h := (Nat.div_add_mod u c).symm
    omega
  rw [Nat.coprime_iff_gcd_eq_one]
  rw [hdecomp]
  have hsum : c + (c * (u / c) + 1) = 1 + c * (u / c + 1) := by ring
  rw [hsum, Nat.gcd_add_mul_left_right]
  simp

/-- A coprime numerator strictly below the modulus has an inverse represented
by a natural number in the standard residue range. -/
theorem exists_inverseRepresentative {c q : Nat} (hq : 1 < q)
    (hc : c < q) (hcoprime : c.Coprime q) :
    ∃ r, r < q ∧ c * r % q = 1 := by
  let z : ZMod q :=
    (↑((ZMod.unitOfCoprime c hcoprime)⁻¹) : ZMod q)
  haveI : NeZero q := ⟨by omega⟩
  haveI : Fact (1 < q) := ⟨hq⟩
  refine ⟨z.val, ZMod.val_lt z, ?_⟩
  have hz : (c : ZMod q) * (z.val : ZMod q) = 1 := by
    rw [ZMod.natCast_zmod_val]
    change (↑(ZMod.unitOfCoprime c hcoprime) : ZMod q) * z = 1
    simp [z]
  have hval := congrArg ZMod.val hz
  simpa [ZMod.val_mul, ZMod.val_natCast, Nat.mod_eq_of_lt hc,
    ZMod.val_one] using hval

/-- Multiplying by an inverse of either omitted residue keeps every other
positive residue at cyclic distance at least two. -/
theorem two_le_cyclicResidueDistance_of_inverse_avoids_two_holes
    {a c q r : Nat} (hq : 1 < q) (hc : 0 < c) (hcq : c < q)
    (hr : r < q) (hinv : c * r % q = 1)
    (ha : 0 < a) (haq : a < q) (hac : a ≠ c) (haqc : a ≠ q - c) :
    2 ≤ cyclicResidueDistance q (r * a) := by
  haveI : NeZero q := ⟨by omega⟩
  haveI : Fact (1 < q) := ⟨hq⟩
  have hcrZ : (c : ZMod q) * (r : ZMod q) = 1 := by
    apply ZMod.val_injective
    simp [ZMod.val_mul, ZMod.val_natCast, Nat.mod_eq_of_lt hcq,
      Nat.mod_eq_of_lt hr, hinv, ZMod.val_one]
  let y := r * a % q
  have hylt : y < q := Nat.mod_lt _ (by omega)
  have hy0 : y ≠ 0 := by
    intro hy
    have hraZ : (r : ZMod q) * (a : ZMod q) = 0 := by
      apply ZMod.val_injective
      simp [ZMod.val_mul, ZMod.val_natCast, Nat.mod_eq_of_lt hr,
        Nat.mod_eq_of_lt haq, y, hy]
    have haZ : (a : ZMod q) = 0 := by
      calc
        (a : ZMod q) = 1 * a := by simp
        _ = (c * r) * a := by rw [hcrZ]
        _ = c * (r * a) := by ring
        _ = 0 := by rw [hraZ]; simp
    have hval := congrArg ZMod.val haZ
    simp [ZMod.val_natCast, Nat.mod_eq_of_lt haq] at hval
    omega
  have hy1 : y ≠ 1 := by
    intro hy
    have hraZ : (r : ZMod q) * (a : ZMod q) = 1 := by
      apply ZMod.val_injective
      simp [ZMod.val_mul, ZMod.val_natCast, Nat.mod_eq_of_lt hr,
        Nat.mod_eq_of_lt haq, y, hy, ZMod.val_one]
    have haZ : (a : ZMod q) = (c : ZMod q) := by
      calc
        (a : ZMod q) = 1 * a := by simp
        _ = (c * r) * a := by rw [hcrZ]
        _ = c * (r * a) := by ring
        _ = c := by rw [hraZ]; simp
    have hval := congrArg ZMod.val haZ
    have : a = c := by
      simpa [ZMod.val_natCast, Nat.mod_eq_of_lt haq,
        Nat.mod_eq_of_lt hcq] using hval
    exact hac this
  have hyTop : y ≠ q - 1 := by
    intro hy
    have hraZ : (r : ZMod q) * (a : ZMod q) = -1 := by
      have hraNatZ : (r : ZMod q) * (a : ZMod q) = (q - 1 : Nat) := by
        apply ZMod.val_injective
        have htop_lt : q - 1 < q := by omega
        simp [ZMod.val_mul, ZMod.val_natCast, Nat.mod_eq_of_lt hr,
          Nat.mod_eq_of_lt haq, Nat.mod_eq_of_lt htop_lt, y, hy]
      calc
        (r : ZMod q) * (a : ZMod q) = (q - 1 : Nat) := hraNatZ
        _ = -1 := by
          rw [Nat.cast_sub (by omega : 1 ≤ q), ZMod.natCast_self]
          simp
    have haZ : (a : ZMod q) = -(c : ZMod q) := by
      calc
        (a : ZMod q) = 1 * a := by simp
        _ = (c * r) * a := by rw [hcrZ]
        _ = c * (r * a) := by ring
        _ = -c := by rw [hraZ]; ring
    have hqcZ : ((q - c : Nat) : ZMod q) = -(c : ZMod q) := by
      rw [Nat.cast_sub hcq.le, ZMod.natCast_self]
      simp
    have heqZ : (a : ZMod q) = ((q - c : Nat) : ZMod q) := haZ.trans hqcZ.symm
    have hval := congrArg ZMod.val heqZ
    have hqc_lt : q - c < q := by omega
    have : a = q - c := by
      simpa [ZMod.val_natCast, Nat.mod_eq_of_lt haq,
        Nat.mod_eq_of_lt hqc_lt] using hval
    exact haqc this
  unfold cyclicResidueDistance
  change 2 ≤ min y (q - y)
  apply le_min
  · omega
  · omega

/-- Two complementary omitted residues give a closed-boundary witness at the
inverse of the first residue.  In particular, `q = 2*N` is allowed. -/
theorem twoHoleDenominator_family_witness {n N c q : Nat}
    (speeds : Fin n → Nat) (hN : 0 < N) (hc : 0 < c) (hcq : c < q)
    (_hNq : N < q) (hq2N : q ≤ 2 * N) (hcoprime : c.Coprime q)
    (hpos : ∀ i, 0 < speeds i) (hlt : ∀ i, speeds i < q)
    (hnotc : ∀ i, speeds i ≠ c) (hnotqc : ∀ i, speeds i ≠ q - c) :
    ∃ t : Real, ∀ i,
      (N : Real)⁻¹ ≤ circleNorm (t * (speeds i : Real)) := by
  have hq : 1 < q := by omega
  obtain ⟨r, hrq, hinv⟩ :=
    exists_inverseRepresentative hq hcq hcoprime
  refine ⟨(r : Real) / (q : Real), fun i => ?_⟩
  have hcyc : 2 ≤ cyclicResidueDistance q (r * speeds i) :=
    two_le_cyclicResidueDistance_of_inverse_avoids_two_holes
      hq hc hcq hrq hinv (hpos i) (hlt i) (hnotc i) (hnotqc i)
  have hcircle := circleNorm_nat_div_ge (M := q) (x := r * speeds i)
    (b := 2) (by omega) hcyc
  have hNreal : (0 : Real) < (N : Real) := by exact_mod_cast hN
  have hqreal : (0 : Real) < (q : Real) := by exact_mod_cast (by omega : 0 < q)
  have hq2Nreal : (q : Real) ≤ 2 * (N : Real) := by exact_mod_cast hq2N
  have hratio : (N : Real)⁻¹ ≤ (2 : Real) / (q : Real) := by
    have hdiv : (1 : Real) / (N : Real) ≤ (2 : Real) / (q : Real) :=
      (div_le_div_iff₀ hNreal hqreal).2 (by simpa using hq2Nreal)
    simpa [one_div] using hdiv
  apply hratio.trans
  rw [show ((r : Real) / (q : Real)) * (speeds i : Real) =
      ((r * speeds i : Nat) : Real) / (q : Real) by push_cast; ring]
  exact hcircle

/-- The complete arithmetic case split once two omitted heights have been
identified.  No assertion that these are the only holes is needed. -/
theorem boundedHeight_family_witness_of_two_holes {n N c d : Nat}
    (speeds : Fin n → Nat) (hN : 4 ≤ N) (hc : 0 < c) (hcd : c < d)
    (hd : d ≤ N + 1) (hpos : ∀ i, 0 < speeds i)
    (hbound : ∀ i, speeds i ≤ N + 1)
    (hmissc : ∀ i, speeds i ≠ c) (hmissd : ∀ i, speeds i ≠ d) :
    ∃ t : Real, ∀ i,
      (N : Real)⁻¹ ≤ circleNorm (t * (speeds i : Real)) := by
  have hNpos : 0 < N := by omega
  by_cases hdTop : d = N + 1
  · have hboundN : ∀ i, speeds i ≤ N := by
      intro i
      have := hbound i
      have hne : speeds i ≠ N + 1 := by simpa [hdTop] using hmissd i
      omega
    by_cases hcTop : c = N
    · subst c
      apply smallDenominator_family_witness speeds hNpos hNpos (le_refl N)
      intro i hdiv
      have haeq : speeds i = N := by
        rcases hdiv with ⟨k, hk⟩
        have hkpos : 0 < k := by
          by_contra hk0
          have : k = 0 := by omega
          subst k
          simp at hk
          have hp := hpos i
          omega
        have hkle : k = 1 := by
          by_contra hk1
          have hk2 : 2 ≤ k := by omega
          have hmul := Nat.mul_le_mul_left N hk2
          have hb := hboundN i
          omega
        subst k
        simpa using hk
      exact hmissc i haeq
    by_cases hcLarge : N < 2 * c
    · apply smallDenominator_family_witness speeds hNpos hc (by omega)
      intro i hdiv
      rcases hdiv with ⟨k, hk⟩
      have hkpos : 0 < k := by
        by_contra hk0
        have : k = 0 := by omega
        subst k
        simp at hk
        exact (Nat.ne_of_gt (hpos i)) hk
      have hkle : k = 1 := by
        by_contra hk1
        have hk2 : 2 ≤ k := by omega
        have hmul := Nat.mul_le_mul_left c hk2
        have hb := hboundN i
        omega
      subst k
      apply hmissc i
      simpa using hk
    · have hcSmall : 2 * c ≤ N := by omega
      obtain ⟨u, huLower, huUpper, huMod⟩ :=
        exists_modEq_one_in_interval hc
          (L := N + 1) (U := 2 * N - c) (by omega)
      let q := c + u
      apply twoHoleDenominator_family_witness speeds hNpos hc
        (q := q) (by dsimp [q]; omega) (by dsimp [q]; omega)
        (by dsimp [q]; omega) (coprime_add_of_mod_eq_one hc huMod)
        hpos
      · intro i
        dsimp [q]
        have := hboundN i
        omega
      · exact hmissc
      · intro i heq
        dsimp [q] at heq
        simp at heq
        have hb := hboundN i
        omega
  · have hdN : d ≤ N := by omega
    by_cases hdLarge : N + 1 < 2 * d
    · apply smallDenominator_family_witness speeds hNpos (by omega) hdN
      intro i hdiv
      rcases hdiv with ⟨k, hk⟩
      have hkpos : 0 < k := by
        by_contra hk0
        have : k = 0 := by omega
        subst k
        simp at hk
        exact (Nat.ne_of_gt (hpos i)) hk
      have hkle : k = 1 := by
        by_contra hk1
        have hk2 : 2 ≤ k := by omega
        have hmul := Nat.mul_le_mul_left d hk2
        have := hbound i
        omega
      subst k
      apply hmissd i
      simpa using hk
    · have hdSmall : 2 * d ≤ N + 1 := by omega
      have hcSmall : 2 * c ≤ N - 1 := by omega
      obtain ⟨u, huLower, huUpper, huMod⟩ :=
        exists_modEq_one_in_interval hc
          (L := N + 2) (U := 2 * N - c) (by omega)
      let q := c + u
      apply twoHoleDenominator_family_witness speeds hNpos hc
        (q := q) (by dsimp [q]; omega) (by dsimp [q]; omega)
        (by dsimp [q]; omega) (coprime_add_of_mod_eq_one hc huMod)
        hpos
      · intro i
        dsimp [q]
        have := hbound i
        omega
      · exact hmissc
      · intro i heq
        dsimp [q] at heq
        simp at heq
        have := hbound i
        omega

/-- A positive injective family of `n` integer speeds of height at most
`n+2` has a stationary lonely-runner witness at the exact closed threshold
`1/(n+1)`. -/
theorem boundedHeight_stationary_witness {n : Nat} (speeds : Fin n → Nat)
    (hn : 3 ≤ n) (hpos : ∀ i, 0 < speeds i)
    (hinj : Function.Injective speeds) (hbound : ∀ i, speeds i ≤ n + 2) :
    ∃ t : Real, ∀ i,
      (((n + 1 : Nat) : Real)⁻¹) ≤
        ‖((t * (speeds i : Real) : Real) : UnitCircle)‖ := by
  classical
  let S : Finset Nat := Finset.univ.image speeds
  let U : Finset Nat := Finset.Icc 1 (n + 2)
  let H : Finset Nat := U \ S
  have hcardS : S.card = n := by
    dsimp [S]
    rw [Finset.card_image_iff.mpr]
    · simp
    · intro i _ j _ hij
      exact hinj hij
  have hSsub : S ⊆ U := by
    intro a ha
    rcases Finset.mem_image.mp ha with ⟨i, -, rfl⟩
    exact Finset.mem_Icc.mpr ⟨hpos i, hbound i⟩
  have hcardU : U.card = n + 2 := by
    dsimp [U]
    rw [Nat.card_Icc]
    omega
  have hcardH : H.card = 2 := by
    dsimp [H]
    rw [Finset.card_sdiff]
    rw [Finset.inter_eq_left.mpr hSsub]
    rw [hcardU, hcardS]
    omega
  obtain ⟨x, y, hxy, hH⟩ := Finset.card_eq_two.mp hcardH
  have hxH : x ∈ H := by rw [hH]; simp
  have hyH : y ∈ H := by rw [hH]; simp
  have hxU : x ∈ U := (Finset.mem_sdiff.mp hxH).1
  have hyU : y ∈ U := (Finset.mem_sdiff.mp hyH).1
  have hxNot : x ∉ S := (Finset.mem_sdiff.mp hxH).2
  have hyNot : y ∉ S := (Finset.mem_sdiff.mp hyH).2
  have hxBounds : 0 < x ∧ x ≤ n + 2 := by
    have hxmem : x ∈ Finset.Icc 1 (n + 2) := by simpa [U] using hxU
    have hx := Finset.mem_Icc.mp hxmem
    omega
  have hyBounds : 0 < y ∧ y ≤ n + 2 := by
    have hymem : y ∈ Finset.Icc 1 (n + 2) := by simpa [U] using hyU
    have hy := Finset.mem_Icc.mp hymem
    omega
  have hxMissing : ∀ i, speeds i ≠ x := by
    intro i heq
    apply hxNot
    exact Finset.mem_image.mpr ⟨i, Finset.mem_univ i, heq⟩
  have hyMissing : ∀ i, speeds i ≠ y := by
    intro i heq
    apply hyNot
    exact Finset.mem_image.mpr ⟨i, Finset.mem_univ i, heq⟩
  have hN : 4 ≤ n + 1 := by omega
  by_cases hlt : x < y
  · obtain ⟨t, ht⟩ := boundedHeight_family_witness_of_two_holes
      speeds hN hxBounds.1 hlt (by omega) hpos hbound hxMissing hyMissing
    exact ⟨t, fun i => by simpa [circleNorm] using ht i⟩
  · have hyx : y < x := by omega
    obtain ⟨t, ht⟩ := boundedHeight_family_witness_of_two_holes
      speeds hN hyBounds.1 hyx (by omega) hpos hbound hyMissing hxMissing
    exact ⟨t, fun i => by simpa [circleNorm] using ht i⟩

end LonelyRunner
