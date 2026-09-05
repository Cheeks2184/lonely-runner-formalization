import LonelyRunner.OwnerKernelBound

/-!
# Exact zero-product kernels on a pivot row

The strict bad-residue sets contain a particularly useful literal subset: the
candidate residues whose product with the other speed is exactly zero modulo
the pivot modulus.  This file keeps that subset separate from the surrounding
strict ball, so multi-owner arguments can retain its overlap structure.
-/

namespace LonelyRunner

open Finset

/-- Candidate residues whose phase product is literally zero modulo the
pivot modulus. -/
def pivotZeroResidues (N p d : ℕ) : Finset ℕ :=
  (pivotCandidates N p).filter fun r => (r * d) % (N * p) = 0

theorem mem_pivotZeroResidues {N p d r : ℕ} :
    r ∈ pivotZeroResidues N p d ↔
      r ∈ pivotCandidates N p ∧ (r * d) % (N * p) = 0 := by
  simp [pivotZeroResidues]

/-- In one complete residue period, multiplication has exactly one zero
fiber for each divisor of the modulus by its gcd with the multiplier. -/
theorem card_range_mul_mod_eq_zero (M d : ℕ) (hM : 0 < M) :
    ((Finset.range M).filter fun r => (r * d) % M = 0).card = Nat.gcd M d := by
  classical
  let g := Nat.gcd M d
  let K := M / g
  have hg : 0 < g := Nat.gcd_pos_of_pos_left d hM
  have hgM : g ∣ M := Nat.gcd_dvd_left M d
  have hgd : g ∣ d := Nat.gcd_dvd_right M d
  have hMK : g * K = M := by
    dsimp [K]
    exact Nat.mul_div_cancel' hgM
  have hK : 0 < K := by
    rw [← hMK] at hM
    exact Nat.pos_of_mul_pos_right (by simpa [Nat.mul_comm] using hM)
  have hzero :
      (Finset.range M).filter (fun r => (r * d) % M = 0) =
        (Finset.range g).image (fun q => K * q) := by
    ext r
    simp only [Finset.mem_filter, Finset.mem_range, Finset.mem_image]
    constructor
    · rintro ⟨hrM, hrzero⟩
      have hmod : r * d ≡ 0 * d [MOD M] := by
        simpa using (Nat.modEq_zero_iff_dvd.mpr
          (Nat.dvd_iff_mod_eq_zero.mpr hrzero))
      have hdiv : K ∣ r := by
        have hcancel := Nat.ModEq.cancel_right_div_gcd hM hmod
        simpa [K, g] using (Nat.modEq_zero_iff_dvd.mp hcancel)
      obtain ⟨q, hq⟩ := hdiv
      refine ⟨q, ?_, hq.symm⟩
      rw [hq] at hrM
      rw [← hMK] at hrM
      exact (Nat.mul_lt_mul_right hK).mp (by simpa [Nat.mul_comm] using hrM)
    · rintro ⟨q, hq, rfl⟩
      constructor
      · rw [← hMK]
        exact (by simpa [Nat.mul_comm] using (Nat.mul_lt_mul_right hK).mpr hq)
      · obtain ⟨d', hd'⟩ := hgd
        apply Nat.mod_eq_zero_of_dvd
        rw [← hMK, hd']
        refine ⟨q * d', ?_⟩
        ring
  rw [hzero, Finset.card_image_iff.mpr]
  · simp [g]
  · intro x hx y hy hxy
    exact Nat.mul_left_cancel (Nat.pos_of_ne_zero (by
      intro hK
      simp [hK] at hMK
      omega)) hxy

/-- Exact cardinality of the literal zero-product kernel after removing the
candidate-forbidden multiples of `N`. -/
theorem card_pivotZeroResidues (N p d : ℕ) (hN : 0 < N) (hp : 0 < p) :
    (pivotZeroResidues N p d).card =
      Nat.gcd d (N * p) - Nat.gcd d p := by
  classical
  let M := N * p
  let A : Finset ℕ := (Finset.range M).filter fun r => (r * d) % M = 0
  let D : Finset ℕ := (Finset.range M).filter fun r =>
    N ∣ r ∧ (r * d) % M = 0
  let Q : Finset ℕ := (Finset.range p).filter fun q => (q * d) % p = 0
  have hM : 0 < M := Nat.mul_pos hN hp
  have hA : A.card = Nat.gcd M d := by
    simpa [A] using card_range_mul_mod_eq_zero M d hM
  have hDimage : D = Q.image (fun q => N * q) := by
    ext r
    simp only [D, Q, M, Finset.mem_filter, Finset.mem_range, Finset.mem_image]
    constructor
    · rintro ⟨hr, hNr, hzero⟩
      obtain ⟨q, hq⟩ := hNr
      refine ⟨q, ?_, hq.symm⟩
      constructor
      · exact (Nat.mul_lt_mul_left hN).mp (by simpa [Nat.mul_comm, hq] using hr)
      · have hscaled : (N * (q * d)) % (N * p) = 0 := by
          simpa [hq, mul_assoc] using hzero
        rw [Nat.mul_mod_mul_left] at hscaled
        exact Nat.mul_left_cancel hN (by simpa using hscaled)
    · rintro ⟨q, ⟨hq, hzero⟩, rfl⟩
      constructor
      · exact (Nat.mul_lt_mul_left hN).mpr (by simpa [Nat.mul_comm] using hq)
      constructor
      · exact dvd_mul_right N q
      · rw [show N * q * d = N * (q * d) by ring,
          Nat.mul_mod_mul_left]
        simp [hzero]
  have hD : D.card = Nat.gcd p d := by
    rw [hDimage, Finset.card_image_iff.mpr]
    · simpa [Q] using card_range_mul_mod_eq_zero p d hp
    · intro x hx y hy hxy
      exact Nat.mul_left_cancel hN hxy
  have hDsub : D ⊆ A := by
    intro r hr
    exact Finset.mem_filter.mpr
      ⟨(Finset.mem_filter.mp hr).1, (Finset.mem_filter.mp hr).2.2⟩
  have hzero : pivotZeroResidues N p d = A \ D := by
    ext r
    simp only [pivotZeroResidues, pivotCandidates, A, D, M,
      Finset.mem_filter, Finset.mem_range, Finset.mem_sdiff]
    tauto
  rw [hzero, Finset.card_sdiff_of_subset hDsub, hA, hD]
  simp only [M, Nat.gcd_comm]

/-- A literal zero product lies in every positive-radius strict bad set. -/
theorem pivotZeroResidues_subset_pivotBadResidues (N p d : ℕ) (hp : 0 < p) :
    pivotZeroResidues N p d ⊆ pivotBadResidues N p d := by
  intro r hr
  have hr' := Finset.mem_filter.mp hr
  apply Finset.mem_filter.mpr
  refine ⟨hr'.1, ?_⟩
  simp [cyclicResidueDistance, hr'.2, hp]

/-- Divisibility between the two gcds gives literal inclusion of zero kernels. -/
theorem pivotZeroResidues_subset_of_gcd_dvd (N p d e : ℕ)
    (hde : Nat.gcd d (N * p) ∣ Nat.gcd e (N * p)) :
    pivotZeroResidues N p d ⊆ pivotZeroResidues N p e := by
  intro r hr
  have hr' := Finset.mem_filter.mp hr
  refine Finset.mem_filter.mpr ⟨hr'.1, ?_⟩
  have hMpos : 0 < N * p := by
    by_contra h
    have hMzero : N * p = 0 := Nat.eq_zero_of_not_pos h
    have hrc := (mem_pivotCandidates.mp hr'.1).1
    omega
  have hmod : r * d ≡ 0 * d [MOD N * p] := by
    simpa using (Nat.modEq_zero_iff_dvd.mpr
      (Nat.dvd_iff_mod_eq_zero.mpr hr'.2))
  have hsmall : (N * p) / Nat.gcd (N * p) d ∣ r := by
    exact Nat.modEq_zero_iff_dvd.mp
      (Nat.ModEq.cancel_right_div_gcd hMpos hmod)
  have hquot : (N * p) / Nat.gcd (N * p) e ∣
      (N * p) / Nat.gcd (N * p) d := by
    apply Nat.div_dvd_div_left
    · exact Nat.gcd_dvd_left _ _
    · simpa [Nat.gcd_comm] using hde
  have hdiv : (N * p) / Nat.gcd (N * p) e ∣ r := hquot.trans hsmall
  have hezero : N * p ∣ r * e := by
    let g := Nat.gcd (N * p) e
    let K := (N * p) / g
    obtain ⟨q, hq⟩ := hdiv
    have hq' : r = K * q := by simpa [K, g] using hq
    obtain ⟨e', he'⟩ := Nat.gcd_dvd_right (N * p) e
    have he'' : e = g * e' := by simpa [g] using he'
    have hfact : g * K = N * p := by
      dsimp [g, K]
      exact Nat.mul_div_cancel' (Nat.gcd_dvd_left (N * p) e)
    refine ⟨q * e', ?_⟩
    calc
      r * e = (K * q) * (g * e') := by rw [hq', he'']
      _ = (g * K) * (q * e') := by ring
      _ = (N * p) * (q * e') := by rw [hfact]
  exact Nat.dvd_iff_mod_eq_zero.mp hezero

/-- The reviewed normalized zero-kernel gap.  Keeping the gap in factored
form exposes the two independent sources of slack: `P > k` and `N ≥ k`. -/
theorem normalizedZeroKernel_capacity (N P k : ℕ)
    (hN : 2 ≤ N) (hk : 0 < k) (hkN : k ≤ N) (hkP : k < P) :
    (N + 1) * (k - 1) ≤ (N - 1) * P := by
  have hkone : 1 ≤ k := hk
  have hP1 : k + 1 ≤ P := by omega
  apply (Nat.cast_le (α := Int)).mp
  push_cast [Nat.cast_sub (by omega : 1 ≤ N), Nat.cast_sub hkone]
  nlinarith

/-- A literal zero-product kernel has capacity at most one `(N+1)`-share of
the candidate row.  This is the actual, unnormalized form used by family
certificates; it assumes only the genuine lower-speed condition. -/
theorem pivotZeroResidues_capacity (N p d : ℕ)
    (hN : 2 ≤ N) (hp : 0 < p) (hd : 0 < d) (hdp : d < p) :
    (N + 1) * (pivotZeroResidues N p d).card ≤
      (N - 1) * p := by
  let h := Nat.gcd d p
  let P := p / h
  let D := d / h
  let k := Nat.gcd D N
  have hh : 0 < h := by
    exact Nat.gcd_pos_of_pos_left p hd
  have hPmul : p = h * P := by
    rw [show P = p / h by rfl]
    rw [Nat.mul_comm, Nat.div_mul_cancel (Nat.gcd_dvd_right d p)]
  have hDmul : d = h * D := by
    rw [show D = d / h by rfl]
    rw [Nat.mul_comm, Nat.div_mul_cancel (Nat.gcd_dvd_left d p)]
  have hDP : Nat.Coprime D P := by
    rw [show D = d / h by rfl, show P = p / h by rfl]
    exact Nat.coprime_div_gcd_div_gcd hh
  have hDpos : 0 < D := by
    by_contra hD
    have hDzero : D = 0 := Nat.eq_zero_of_not_pos hD
    simp [hDzero] at hDmul
    omega
  have hk : 0 < k := by
    rw [show k = Nat.gcd D N by rfl]
    exact Nat.gcd_pos_of_pos_right D (by omega)
  have hkN : k ≤ N := by
    rw [show k = Nat.gcd D N by rfl]
    exact Nat.gcd_le_right D (by omega)
  have hkD : k ≤ D := by
    rw [show k = Nat.gcd D N by rfl]
    simpa [Nat.gcd_comm] using Nat.gcd_le_left N hDpos
  have hDPlt : D < P := by
    apply (Nat.mul_lt_mul_left hh).mp
    rw [← hDmul, ← hPmul]
    exact hdp
  have hkP : k < P := hkD.trans_lt hDPlt
  have hcap := normalizedZeroKernel_capacity N P k hN hk hkN hkP
  have hgcdBig : Nat.gcd d (N * p) = h * k := by
    rw [hDmul, hPmul]
    calc
      Nat.gcd (h * D) (N * (h * P)) =
          Nat.gcd (h * D) (h * (N * P)) := by congr 1 <;> ac_rfl
      _ = h * Nat.gcd D (N * P) := Nat.gcd_mul_left h D (N * P)
      _ = h * Nat.gcd D N := by rw [hDP.symm.gcd_mul_right_cancel_right N]
      _ = h * k := by rfl
  have hcard : (pivotZeroResidues N p d).card = h * (k - 1) := by
    rw [card_pivotZeroResidues N p d (by omega) hp, hgcdBig]
    have hsub : h * k - h = h * (k - 1) := by
      simpa using (Nat.mul_sub_left_distrib h k 1).symm
    simpa [h] using hsub
  rw [hcard, hPmul]
  have hmul := Nat.mul_le_mul_left h hcap
  simpa [Nat.mul_assoc, Nat.mul_left_comm, Nat.mul_comm] using hmul

/-- Every genuine lower speed has the two shared nonzero bad phases `1` and
`N*p - 1`.  They are kept outside the literal zero kernel, which is the form
needed when union bounds split each bad row into zero and nonzero parts. -/
theorem one_and_last_mem_pivotBadResidues_sdiff_pivotZeroResidues
    (N p d : ℕ) (hN : 3 ≤ N) (hp : 0 < p) (hd : 0 < d) (hdp : d < p) :
    1 ∈ pivotBadResidues N p d \ pivotZeroResidues N p d ∧
      N * p - 1 ∈ pivotBadResidues N p d \ pivotZeroResidues N p d ∧
      1 ≠ N * p - 1 := by
  let M := N * p
  have hM : 3 ≤ M := by
    dsimp [M]
    nlinarith
  have hMpos : 0 < M := by omega
  have hdM : d < M := by
    dsimp [M]
    nlinarith
  have hdMle : d ≤ M := by omega
  have hMdpos : 0 < M - d := by omega
  have hMdlt : M - d < M := by omega
  have honeCandidate : 1 ∈ pivotCandidates N p := by
    apply mem_pivotCandidates.mpr
    constructor
    · dsimp [M] at hM
      omega
    · intro hdiv
      have : N = 1 := Nat.dvd_one.mp hdiv
      omega
  have hlastCandidate : M - 1 ∈ pivotCandidates N p := by
    apply mem_pivotCandidates.mpr
    constructor
    · dsimp [M]
      omega
    · intro hdiv
      have hNM : N ∣ M := by
        dsimp [M]
        exact dvd_mul_right N p
      have hOne : N ∣ M - (M - 1) := Nat.dvd_sub hNM hdiv
      have hsub : M - (M - 1) = 1 := by omega
      have : N ∣ 1 := hsub ▸ hOne
      have : N = 1 := Nat.dvd_one.mp this
      omega
  have honeMod : (1 * d) % M = d := by
    simp [Nat.mod_eq_of_lt hdM]
  have hident : (M - 1) * d = M * (d - 1) + (M - d) := by
    apply (Nat.cast_injective : Function.Injective (fun n : Nat => (n : Int)))
    push_cast [Nat.cast_sub (by omega : 1 ≤ M),
      Nat.cast_sub (by omega : 1 ≤ d), Nat.cast_sub hdMle]
    ring
  have hlastMod : ((M - 1) * d) % M = M - d := by
    rw [hident, Nat.add_mod, Nat.mul_mod]
    simp [Nat.mod_eq_of_lt hMdlt]
  have honeBad : 1 ∈ pivotBadResidues N p d := by
    apply mem_pivotBadResidues.mpr
    refine ⟨honeCandidate, ?_⟩
    unfold cyclicResidueDistance
    rw [honeMod]
    exact (min_le_left _ _).trans_lt hdp
  have hlastBad : M - 1 ∈ pivotBadResidues N p d := by
    apply mem_pivotBadResidues.mpr
    refine ⟨hlastCandidate, ?_⟩
    unfold cyclicResidueDistance
    rw [hlastMod, Nat.sub_sub_self hdMle]
    exact (min_le_right _ _).trans_lt hdp
  have honeNotZero : 1 ∉ pivotZeroResidues N p d := by
    intro hz
    have := (mem_pivotZeroResidues.mp hz).2
    rw [show N * p = M by rfl, honeMod] at this
    omega
  have hlastNotZero : M - 1 ∉ pivotZeroResidues N p d := by
    intro hz
    have := (mem_pivotZeroResidues.mp hz).2
    rw [show N * p = M by rfl, hlastMod] at this
    omega
  refine ⟨Finset.mem_sdiff.mpr ⟨honeBad, honeNotZero⟩,
    Finset.mem_sdiff.mpr ⟨?_, ?_⟩, ?_⟩
  · simpa [M] using hlastBad
  · simpa [M] using hlastNotZero
  · dsimp [M] at hM
    omega

end LonelyRunner
