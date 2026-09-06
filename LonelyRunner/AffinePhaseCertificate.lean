import LonelyRunner.FiniteCutCover
import LonelyRunner.RealPhaseBands

/-!
# Generic affine phase-certificate interfaces

These reusable interfaces separate finite row certificates from the real
affine-phase bridge.  They deliberately contain no Renault 6.1 or 6.4 data.
-/

namespace LonelyRunner

/-- The doubled cut numerator for a singleton, or the endpoint sum for an
open cut atom. -/
def affineSixthRepresentative (C : ℕ → ℕ) (a : ℕ) : ℕ :=
  if a % 2 = 0 then 2 * C (a / 2) else C (a / 2) + C (a / 2 + 1)

/-- The natural numerator of the affine phase, on denominator `720`. -/
def affineSixthNumerator (C : ℕ → ℕ) (a A S : ℕ) : ℕ :=
  A * affineSixthRepresentative C a + 120 * S

/-- The integer band selected by the affine numerator. -/
def affineSixthQuotient (C : ℕ → ℕ) (a A S : ℕ) : ℕ :=
  affineSixthNumerator C a A S / 720

/-- Finite arithmetic sufficient to certify one affine candidate on one cut
atom.  Singleton strictness is retained exactly; open atoms use closed
endpoint bounds, which yield strict interior goodness for every positive
slope. -/
structure AffineSixthBandFact (C : ℕ → ℕ) (a A S : ℕ) (s : Bool) : Prop where
  singleton : a % 2 = 0 →
    if s then
      120 < affineSixthNumerator C a A S % 720 ∧
        affineSixthNumerator C a A S % 720 < 600
    else
      120 ≤ affineSixthNumerator C a A S % 720 ∧
        affineSixthNumerator C a A S % 720 ≤ 600
  interval : a % 2 ≠ 0 →
    360 * affineSixthQuotient C a A S + 60 ≤ A * C (a / 2) + 60 * S ∧
      A * C (a / 2 + 1) + 60 * S ≤ 360 * affineSixthQuotient C a A S + 300

/-- A finite affine band fact transfers to the corresponding real circular
distance statement. -/
theorem affineSixthBandFact_sound
    (C : ℕ → ℕ) (a A S : ℕ) (s : Bool) (hA : 0 < A)
    (h : AffineSixthBandFact C a A S s) (x : ℝ)
    (hx : CutAtomMem C 360 a x) :
    if s then (1 : ℝ) / 6 < circleNorm ((A : ℝ) * x + (S : ℝ) / 6)
    else (1 : ℝ) / 6 ≤ circleNorm ((A : ℝ) * x + (S : ℝ) / 6) := by
  cases s with
  | false =>
    simp only [Bool.false_eq_true, ↓reduceIte]
    by_cases ha : a % 2 = 0
    · have hxsingle : x = (C (a / 2) : ℝ) / 360 := by
        simpa [CutAtomMem, ha] using hx
      let P : ℕ := affineSixthNumerator C a A S
      let Q : ℕ := affineSixthQuotient C a A S
      let R : ℕ := affineSixthNumerator C a A S % 720
      have hP : P = A * (2 * C (a / 2)) + 120 * S := by
        simp [P, affineSixthNumerator, affineSixthRepresentative, ha]
      have hQ : Q = P / 720 := by simp [Q, P, affineSixthQuotient]
      have hR : R = P % 720 := by simp [R, P]
      have hdiv : 720 * Q + R = P := by
        rw [hQ, hR]
        simpa [Nat.mul_comm] using (Nat.div_add_mod P 720)
      have hdivR : (720 : ℝ) * (Q : ℝ) + (R : ℝ) = (P : ℝ) := by
        exact_mod_cast hdiv
      have hphase : (A : ℝ) * x + (S : ℝ) / 6 =
          (Q : ℝ) + (R : ℝ) / 720 := by
        rw [hxsingle]
        norm_num [hP] at hdivR ⊢
        nlinarith [hdivR]
      have hrem := h.singleton ha
      simp only [Bool.false_eq_true, ↓reduceIte] at hrem
      have hRlower : (120 : ℝ) ≤ (R : ℝ) := by
        rw [hR]
        exact_mod_cast hrem.1
      have hRupper : (R : ℝ) ≤ 600 := by
        rw [hR]
        exact_mod_cast hrem.2
      rw [hphase]
      apply circleNorm_ge_of_int_band (Q : ℤ)
        ((Q : ℝ) + (R : ℝ) / 720) ((1 : ℝ) / 6)
      · norm_num
      · norm_num
      · norm_num
        nlinarith [hRlower]
      · norm_num
        nlinarith [hRupper]
    · obtain ⟨hxlower, hxupper⟩ :
          (C (a / 2) : ℝ) / 360 < x ∧
            x < (C (a / 2 + 1) : ℝ) / 360 := by
        simpa [CutAtomMem, ha] using hx
      let Q : ℕ := affineSixthQuotient C a A S
      have hinterval := h.interval ha
      have hlowerNat : 360 * Q + 60 ≤ A * C (a / 2) + 60 * S := by
        simpa [Q] using hinterval.1
      have hupperNat : A * C (a / 2 + 1) + 60 * S ≤ 360 * Q + 300 := by
        simpa [Q] using hinterval.2
      have hlowerReal : (360 : ℝ) * (Q : ℝ) + 60 ≤
          (A : ℝ) * (C (a / 2) : ℝ) + 60 * (S : ℝ) := by
        exact_mod_cast hlowerNat
      have hupperReal : (A : ℝ) * (C (a / 2 + 1) : ℝ) + 60 * (S : ℝ) ≤
          (360 : ℝ) * (Q : ℝ) + 300 := by
        exact_mod_cast hupperNat
      have hlowerBand : ((Q : ℤ) : ℝ) + (1 : ℝ) / 6 ≤
          (A : ℝ) * ((C (a / 2) : ℝ) / 360) + (S : ℝ) / 6 := by
        norm_num
        nlinarith [hlowerReal]
      have hupperBand :
          (A : ℝ) * ((C (a / 2 + 1) : ℝ) / 360) + (S : ℝ) / 6 ≤
            ((Q : ℤ) : ℝ) + 1 - (1 : ℝ) / 6 := by
        norm_num
        nlinarith [hupperReal]
      exact le_of_lt (circleNorm_gt_of_affine_open_band (Q : ℤ)
        (A : ℝ) ((S : ℝ) / 6)
        ((C (a / 2) : ℝ) / 360) ((C (a / 2 + 1) : ℝ) / 360) x ((1 : ℝ) / 6)
        (by exact_mod_cast hA) (by norm_num)
        hlowerBand hupperBand hxlower hxupper)
  | true =>
    simp only [↓reduceIte]
    by_cases ha : a % 2 = 0
    · have hxsingle : x = (C (a / 2) : ℝ) / 360 := by
        simpa [CutAtomMem, ha] using hx
      let P : ℕ := affineSixthNumerator C a A S
      let Q : ℕ := affineSixthQuotient C a A S
      let R : ℕ := affineSixthNumerator C a A S % 720
      have hP : P = A * (2 * C (a / 2)) + 120 * S := by
        simp [P, affineSixthNumerator, affineSixthRepresentative, ha]
      have hQ : Q = P / 720 := by simp [Q, P, affineSixthQuotient]
      have hR : R = P % 720 := by simp [R, P]
      have hdiv : 720 * Q + R = P := by
        rw [hQ, hR]
        simpa [Nat.mul_comm] using (Nat.div_add_mod P 720)
      have hdivR : (720 : ℝ) * (Q : ℝ) + (R : ℝ) = (P : ℝ) := by
        exact_mod_cast hdiv
      have hphase : (A : ℝ) * x + (S : ℝ) / 6 =
          (Q : ℝ) + (R : ℝ) / 720 := by
        rw [hxsingle]
        norm_num [hP] at hdivR ⊢
        nlinarith [hdivR]
      have hrem := h.singleton ha
      simp only [↓reduceIte] at hrem
      have hRlower : (120 : ℝ) < (R : ℝ) := by
        rw [hR]
        exact_mod_cast hrem.1
      have hRupper : (R : ℝ) < 600 := by
        rw [hR]
        exact_mod_cast hrem.2
      rw [hphase]
      apply circleNorm_gt_of_int_band (Q : ℤ)
        ((Q : ℝ) + (R : ℝ) / 720) ((1 : ℝ) / 6)
      · norm_num
      · norm_num
        nlinarith [hRlower]
      · norm_num
        nlinarith [hRupper]
    · obtain ⟨hxlower, hxupper⟩ :
          (C (a / 2) : ℝ) / 360 < x ∧
            x < (C (a / 2 + 1) : ℝ) / 360 := by
        simpa [CutAtomMem, ha] using hx
      let Q : ℕ := affineSixthQuotient C a A S
      have hinterval := h.interval ha
      have hlowerNat : 360 * Q + 60 ≤ A * C (a / 2) + 60 * S := by
        simpa [Q] using hinterval.1
      have hupperNat : A * C (a / 2 + 1) + 60 * S ≤ 360 * Q + 300 := by
        simpa [Q] using hinterval.2
      have hlowerReal : (360 : ℝ) * (Q : ℝ) + 60 ≤
          (A : ℝ) * (C (a / 2) : ℝ) + 60 * (S : ℝ) := by
        exact_mod_cast hlowerNat
      have hupperReal : (A : ℝ) * (C (a / 2 + 1) : ℝ) + 60 * (S : ℝ) ≤
          (360 : ℝ) * (Q : ℝ) + 300 := by
        exact_mod_cast hupperNat
      have hlowerBand : ((Q : ℤ) : ℝ) + (1 : ℝ) / 6 ≤
          (A : ℝ) * ((C (a / 2) : ℝ) / 360) + (S : ℝ) / 6 := by
        norm_num
        nlinarith [hlowerReal]
      have hupperBand :
          (A : ℝ) * ((C (a / 2 + 1) : ℝ) / 360) + (S : ℝ) / 6 ≤
            ((Q : ℤ) : ℝ) + 1 - (1 : ℝ) / 6 := by
        norm_num
        nlinarith [hupperReal]
      exact circleNorm_gt_of_affine_open_band (Q : ℤ)
        (A : ℝ) ((S : ℝ) / 6)
        ((C (a / 2) : ℝ) / 360) ((C (a / 2 + 1) : ℝ) / 360) x ((1 : ℝ) / 6)
        (by exact_mod_cast hA) (by norm_num)
        hlowerBand hupperBand hxlower hxupper

/-- Singleton cuts and open adjacent intervals cover a closed cut interval.
The final singleton `2*n` is included, including in the `n = 0` case. -/
theorem cutAtomMem_covers_closed_interval
    (n D : ℕ) (hD : 0 < D) (C : ℕ → ℕ) (x : ℝ)
    (hlo : (C 0 : ℝ) / (D : ℝ) ≤ x)
    (hhi : x ≤ (C n : ℝ) / (D : ℝ)) :
    ∃ a : Fin (2 * n + 1), CutAtomMem C D a.val x := by
  by_cases hlast : x = (C n : ℝ) / (D : ℝ)
  · refine ⟨⟨2 * n, by omega⟩, ?_⟩
    simp [CutAtomMem, hlast]
  · have hright : x < (C n : ℝ) / (D : ℝ) :=
      lt_of_le_of_ne hhi hlast
    obtain ⟨i, hi, hix, hxi⟩ := exists_adjacent_cut_interval
      (fun j => (C j : ℝ) / (D : ℝ)) n x hlo hright
    by_cases heq : x = (C i : ℝ) / (D : ℝ)
    · refine ⟨⟨2 * i, by omega⟩, ?_⟩
      simp [CutAtomMem, heq]
    · refine ⟨⟨2 * i + 1, by omega⟩, ?_⟩
      have hlt : (C i : ℝ) / (D : ℝ) < x :=
        lt_of_le_of_ne hix (Ne.symm heq)
      have hd : (2 * i + 1) / 2 = i := by omega
      have hm : (2 * i + 1) % 2 = 1 := by omega
      simpa [CutAtomMem, hd, hm] using And.intro hlt hxi

/-- Assemble coordinate-indexed sound rows with one common candidate choice
for all three coordinates. -/
theorem typed_phase_certificate_sound
    (B : ℕ) (m : Fin 3 → ℕ)
    (M : (j : Fin 3) → Fin (m j) → Finset (Fin B))
    (Domain : Fin 3 → ℝ → Prop) (Good : Fin 3 → Fin B → ℝ → Prop)
    (hrow : ∀ j x, Domain j x →
      ∃ i, ∀ c, c ∈ M j i → Good j c x)
    (hcommon : ∀ i : (j : Fin 3) → Fin (m j),
      ∃ c, ∀ j, c ∈ M j (i j)) :
    ∀ x : Fin 3 → ℝ, (∀ j, Domain j (x j)) →
      ∃ c, ∀ j, Good j c (x j) := by
  classical
  intro x hx
  choose i hi using fun j => hrow j (x j) (hx j)
  obtain ⟨c, hc⟩ := hcommon i
  refine ⟨c, ?_⟩
  intro j
  exact hi j c (hc j)

end LonelyRunner
