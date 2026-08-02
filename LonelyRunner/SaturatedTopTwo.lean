import LonelyRunner.PivotBoundary

/-!
# The saturated lower-interval top-two class

This file proves the explicit modular-pivot certificate for the speed family
`1, 2, ..., N - 2, B`, where `4 ≤ N` and `N - 2 < B`.  The certificate uses
one of the two numerically largest speeds, `N - 2` or `B`.

This is only one structured infinite class.  It does not prove the unrestricted
top-two pivot conjecture or the Lonely Runner Conjecture.
-/

namespace LonelyRunner

open Finset

/-- Exact finite certificate for the saturated family `1, ..., N - 2, B`.

The inequalities are non-strict: equality with the pivot is the valid closed
Lonely Runner boundary.  The selected pivot is explicitly one of the two
largest speeds of this family. -/
def SaturatedTopTwoPivotCertificate (N B : ℕ) : Prop :=
  ∃ pivot r : ℕ,
    (pivot = N - 2 ∨ pivot = B) ∧
    r ∈ pivotCandidates N pivot ∧
    (∀ a : ℕ, 1 ≤ a → a ≤ N - 2 →
      pivot ≤ cyclicResidueDistance (N * pivot) (r * a)) ∧
    pivot ≤ cyclicResidueDistance (N * pivot) (r * B)

private theorem firstPivot_lower_safe {N A a : ℕ} (hNA : N = A + 2)
    (hApos : 0 < A) (ha0 : 1 ≤ a) (haA : a ≤ A) :
    A ≤ cyclicResidueDistance (N * A) (A * a) := by
  have haN : a < N := by omega
  have hprodLt : A * a < N * A := by
    nlinarith
  rw [cyclicResidueDistance, Nat.mod_eq_of_lt hprodLt]
  apply le_min
  · nlinarith
  · have : A * a + A ≤ N * A := by
      nlinarith
    omega

private theorem firstPivot_top_safe {N A B : ℕ} (hNA : N = A + 2)
    (hApos : 0 < A)
    (hnot : ¬N ∣ B) :
    A ≤ cyclicResidueDistance (N * A) (A * B) := by
  let s := B % N
  have hNpos : 0 < N := by omega
  have hs0 : 1 ≤ s := by
    have : s ≠ 0 := by
      intro hs
      exact hnot (Nat.dvd_iff_mod_eq_zero.mpr hs)
    omega
  have hsN : s < N := Nat.mod_lt B hNpos
  have hmod : (A * B) % (N * A) = A * s := by
    rw [Nat.mul_comm N A, Nat.mul_mod_mul_left]
  rw [cyclicResidueDistance, hmod]
  apply le_min
  · nlinarith
  · have : A * s + A ≤ N * A := by
      nlinarith
    omega

private theorem secondPivot_lower_safe {N A a : ℕ} (hNA : N = A + 2)
    (hApos : 0 < A) (ha0 : 1 ≤ a) (haA : a ≤ A) :
    A ≤ cyclicResidueDistance (N * A) ((N - 1) * a) := by
  have hNm1pos : 0 < N - 1 := by omega
  have hxle : (N - 1) * a ≤ (N - 1) * A :=
    Nat.mul_le_mul_left _ haA
  have hprodLt : (N - 1) * a < N * A :=
    hxle.trans_lt (Nat.mul_lt_mul_of_pos_right (by omega) hApos)
  rw [cyclicResidueDistance, Nat.mod_eq_of_lt hprodLt]
  apply le_min
  · calc
      A ≤ (N - 1) * 1 := by simp; omega
      _ ≤ (N - 1) * a := Nat.mul_le_mul_left _ ha0
  · have hsum : (N - 1) * a + A ≤ N * A := by
      calc
        (N - 1) * a + A ≤ (N - 1) * A + A := Nat.add_le_add_right hxle A
        _ = N * A := by
          calc
            (N - 1) * A + A = ((N - 1) + 1) * A := by
              simp [Nat.add_mul]
            _ = N * A := by rw [Nat.sub_add_cancel (by omega : 1 ≤ N)]
    omega

private theorem secondPivot_top_safe {N A k : ℕ} (hNA : N = A + 2)
    (hApos : 0 < A) (hk : ¬A ∣ k) :
    A ≤ cyclicResidueDistance (N * A) ((N - 1) * (N * k)) := by
  let s := k % A
  have hs0 : 1 ≤ s := by
    have : s ≠ 0 := by
      intro hs
      exact hk (Nat.dvd_iff_mod_eq_zero.mpr hs)
    omega
  have hsA : s < A := Nat.mod_lt k hApos
  have hNm1 : N - 1 = A + 1 := by omega
  have hmod : ((N - 1) * (N * k)) % (N * A) = N * s := by
    calc
      ((N - 1) * (N * k)) % (N * A) =
          (N * ((N - 1) * k)) % (N * A) := by ring_nf
      _ = N * (((N - 1) * k) % A) := Nat.mul_mod_mul_left _ _ _
      _ = N * s := by
        congr 1
        rw [hNm1, Nat.add_mul]
        simp [s, Nat.add_mod]
  rw [cyclicResidueDistance, hmod]
  apply le_min
  · nlinarith
  · have : N * s + A ≤ N * A := by
      nlinarith
    omega

private theorem fastPivot_lower_safe {N A B k a : ℕ} (hNA : N = A + 2)
    (hApos : 0 < A) (hk : 1 ≤ k) (hB : B = N * A * k)
    (ha0 : 1 ≤ a) (haA : a ≤ A) :
    B ≤ cyclicResidueDistance (N * B) (((N - 1) * N * k - 1) * a) := by
  let q := (N - 1) * N * k
  have hqPos : 1 ≤ q := by
    dsimp [q]
    exact Nat.mul_pos (Nat.mul_pos (by omega) (by omega)) (by omega)
  have hrSucc : q - 1 + 1 = q := Nat.sub_add_cancel hqPos
  have hNm1 : N - 1 = A + 1 := by omega
  have hqEq : q = B + N * k := by
    dsimp [q]
    rw [hNm1, hB]
    ring
  have hNkPos : 0 < N * k := Nat.mul_pos (by omega) (by omega)
  have hrB : B ≤ q - 1 := by omega
  have hxa : (q - 1) * a ≤ q * A := by
    exact Nat.mul_le_mul (by omega) haA
  have hsum : q * A + B = N * B := by
    dsimp [q]
    rw [hNm1, hB, hNA]
    ring
  have hprodLt : ((N - 1) * N * k - 1) * a < N * B := by
    change (q - 1) * a < N * B
    have hBpos : 0 < B := by
      rw [hB]
      exact Nat.mul_pos (Nat.mul_pos (by omega) hApos) (by omega)
    have hle : (q - 1) * a + B ≤ N * B := by
      calc
        (q - 1) * a + B ≤ q * A + B := Nat.add_le_add_right hxa B
        _ = N * B := hsum
    omega
  rw [cyclicResidueDistance, Nat.mod_eq_of_lt hprodLt]
  apply le_min
  · change B ≤ (q - 1) * a
    calc
      B ≤ q - 1 := hrB
      _ = (q - 1) * 1 := by simp
      _ ≤ (q - 1) * a := Nat.mul_le_mul_left _ ha0
  · have : (q - 1) * a + B ≤ N * B := by
      calc
        (q - 1) * a + B ≤ q * A + B := Nat.add_le_add_right hxa B
        _ = N * B := hsum
    change B ≤ N * B - (q - 1) * a
    omega

private theorem fastPivot_mem {N A k : ℕ} (hNA : N = A + 2)
    (hApos : 0 < A) (hk : 1 ≤ k) :
    (N - 1) * N * k - 1 ∈ pivotCandidates N (N * (A * k)) := by
  let q := (N - 1) * N * k
  let r := q - 1
  have hqPos : 1 ≤ q := by
    dsimp [q]
    exact Nat.mul_pos (Nat.mul_pos (by omega) (by omega)) (by omega)
  have hrSucc : r + 1 = q := by
    dsimp [r]
    exact Nat.sub_add_cancel hqPos
  have hpivotPos : 0 < N * (A * k) :=
    Nat.mul_pos (by omega) (Nat.mul_pos hApos (by omega))
  have hNm1 : N - 1 = A + 1 := by omega
  have hqA : q * A + N * A * k = N * (N * (A * k)) := by
    dsimp [q]
    rw [hNm1, hNA]
    ring
  have hqLe : q ≤ q * A := by
    calc
      q = q * 1 := by simp
      _ ≤ q * A := Nat.mul_le_mul_left q (by omega)
  have hrLt : r < N * (N * (A * k)) := by
    have htermPos : 0 < N * A * k :=
      Nat.mul_pos (Nat.mul_pos (by omega) hApos) (by omega)
    have hqLt : q < N * (N * (A * k)) := by omega
    omega
  rw [mem_pivotCandidates]
  refine ⟨by simpa [r, q] using hrLt, ?_⟩
  intro hdr
  have hdq : N ∣ q := by
    dsimp [q]
    rw [show (N - 1) * N * k = N * ((N - 1) * k) by ring]
    exact dvd_mul_right N ((N - 1) * k)
  have hmodr : r % N = 0 := Nat.dvd_iff_mod_eq_zero.mp hdr
  have hmodq : q % N = 0 := Nat.dvd_iff_mod_eq_zero.mp hdq
  have heq := congrArg (fun x : ℕ => x % N) hrSucc
  simp [Nat.add_mod, hmodr, hmodq, Nat.mod_eq_of_lt (by omega : 1 < N)] at heq

private theorem candidate_self_safe {N pivot r : ℕ} (hN : 0 < N)
    (hpivot : 0 < pivot) (hr : r ∈ pivotCandidates N pivot) :
    pivot ≤ cyclicResidueDistance (N * pivot) (r * pivot) := by
  have hgood := pivot_circleNorm_ge hN hpivot hr
  have hnotbad := (not_mem_pivotBadResidues_iff_circleNorm_ge
    hN hpivot hr).2 hgood
  exact Nat.le_of_not_gt fun hlt => hnotbad
    (mem_pivotBadResidues.mpr ⟨hr, hlt⟩)

/-- The saturated lower-interval family has a closed modular certificate at
one of its two largest speeds. -/
theorem saturatedTopTwoPivotCertificate {N B : ℕ} (hN : 4 ≤ N)
    (hB : N - 2 < B) : SaturatedTopTwoPivotCertificate N B := by
  let A := N - 2
  have hApos : 0 < A := by dsimp [A]; omega
  have hNpos : 0 < N := by omega
  have hNA : N = A + 2 := by dsimp [A]; omega
  by_cases hNB : N ∣ B
  · obtain ⟨k, rfl⟩ := hNB
    by_cases hAk : A ∣ k
    · obtain ⟨k, rfl⟩ := hAk
      have hk : 1 ≤ k := by
        by_contra hzero
        have : k = 0 := by omega
        subst k
        simp at hB
      let r := (N - 1) * N * k - 1
      refine ⟨N * (A * k), r, Or.inr rfl, ?_, ?_, ?_⟩
      · exact fastPivot_mem hNA hApos hk
      · intro a ha0 haA
        exact fastPivot_lower_safe hNA hApos hk (by simp [Nat.mul_assoc]) ha0 haA
      · exact candidate_self_safe hNpos
          (Nat.mul_pos (by omega) (Nat.mul_pos hApos (by omega)))
          (fastPivot_mem hNA hApos hk)
    · refine ⟨A, N - 1, Or.inl rfl, ?_, ?_, ?_⟩
      · rw [mem_pivotCandidates]
        constructor
        · have hNm1A : N - 1 < N * A := by
            calc
              N - 1 < N := by omega
              _ ≤ N * A := by simpa using Nat.mul_le_mul_left N hApos
          exact hNm1A
        · exact Nat.not_dvd_of_pos_of_lt (by omega) (by omega)
      · intro a ha0 haA
        exact secondPivot_lower_safe hNA hApos ha0 haA
      · exact secondPivot_top_safe hNA hApos hAk
  · refine ⟨A, A, Or.inl rfl, ?_, ?_, ?_⟩
    · rw [mem_pivotCandidates]
      constructor
      · rw [hNA]
        nlinarith
      · exact Nat.not_dvd_of_pos_of_lt hApos (by omega)
    · intro a ha0 haA
      exact firstPivot_lower_safe hNA hApos ha0 haA
    · exact firstPivot_top_safe hNA hApos hNB

/-- Canonical bad-set formulation of the saturated top-two theorem.  Every
speed in the lower interval and the exceptional top speed avoids its strict
`pivotBadResidues` set at the selected top-two pivot. -/
theorem saturatedTopTwo_avoids_pivotBadResidues {N B : ℕ} (hN : 4 ≤ N)
    (hB : N - 2 < B) :
    ∃ pivot r : ℕ,
      (pivot = N - 2 ∨ pivot = B) ∧
      r ∈ pivotCandidates N pivot ∧
      (∀ a : ℕ, 1 ≤ a → a ≤ N - 2 →
        r ∉ pivotBadResidues N pivot a) ∧
      r ∉ pivotBadResidues N pivot B := by
  obtain ⟨pivot, r, hpivot, hr, hlower, htop⟩ :=
    saturatedTopTwoPivotCertificate hN hB
  refine ⟨pivot, r, hpivot, hr, ?_, ?_⟩
  · intro a ha0 haA hbad
    have hlt := (mem_pivotBadResidues.mp hbad).2
    exact (Nat.not_lt_of_ge (hlower a ha0 haA)) hlt
  · intro hbad
    have hlt := (mem_pivotBadResidues.mp hbad).2
    exact (Nat.not_lt_of_ge htop) hlt

end LonelyRunner
