import LonelyRunner.MirroredBlockWitness
import Mathlib.Order.Interval.Finset.Nat

/-!
# The full mirrored consecutive speed family

The finite configuration consists of both closed endpoint blocks.  The
pointwise relative witnesses below are translated to every injective labelling
of its exact cardinality, without claiming anything about arbitrary families.
-/

namespace LonelyRunner

/-- The `2m+2` runner configuration with the two mirrored endpoint blocks. -/
def mirroredBlockSpeeds (m p : ℕ) : Finset ℕ :=
  Finset.Icc 0 m ∪ Finset.Icc (p - m) p

theorem card_mirroredBlockSpeeds (m p : ℕ) (hp : 2 * m + 1 ≤ p) :
    (mirroredBlockSpeeds m p).card = 2 * m + 2 := by
  have hdisjoint : Disjoint (Finset.Icc 0 m) (Finset.Icc (p - m) p) := by
    refine Finset.disjoint_left.2 ?_
    intro x hx hy
    have hx' := Finset.mem_Icc.mp hx
    have hy' := Finset.mem_Icc.mp hy
    omega
  rw [mirroredBlockSpeeds, Finset.card_union_of_disjoint hdisjoint]
  rw [Nat.card_Icc, Nat.card_Icc]
  omega

/-- A positive witness for every magnitude in either block
`[1,m] ∪ [P-m,P]`, at the original denominator `2m+2`. -/
theorem mirroredBlockMagnitudeCover (m P : ℕ) (hm : 1 ≤ m)
    (hP : m + 1 ≤ P) :
    ∃ t : ℝ, 0 < t ∧ ∀ d : ℕ,
      ((1 ≤ d ∧ d ≤ m) ∨ (P - m ≤ d ∧ d ≤ P)) →
        (((2 * m + 2 : ℕ) : ℝ)⁻¹) ≤ circleNorm (t * (d : ℝ)) := by
  let N : ℕ := 2 * m + 2
  let δ : ℝ := (N : ℝ)⁻¹
  have hNpos : 0 < N := by dsimp [N]; omega
  have hNreal : (0 : ℝ) < (N : ℝ) := by exact_mod_cast hNpos
  have hδ : δ = ((2 * m + 2 : ℕ) : ℝ)⁻¹ := by dsimp [δ, N]
  by_cases hsmall : P ≤ 2 * m + 1
  · refine ⟨δ, ?_, ?_⟩
    · exact inv_pos.mpr hNreal
    intro d hd
    rcases hd with hd | hd
    all_goals
      have hd1 : 1 ≤ d := by omega
      have hdN : d + 1 ≤ N := by dsimp [N]; omega
      have hd1R : (1 : ℝ) ≤ (d : ℝ) := by exact_mod_cast hd1
      have hdNR : (d : ℝ) + 1 ≤ (N : ℝ) := by exact_mod_cast hdN
      have hδpos : 0 < δ := by exact inv_pos.mpr hNreal
      have hNδ : (N : ℝ) * δ = 1 := by simp [δ, hNreal.ne']
      have hlow := mul_le_mul_of_nonneg_right hd1R (le_of_lt hδpos)
      have hupp := mul_le_mul_of_nonneg_right hdNR (le_of_lt hδpos)
      apply circleNorm_ge_of_int_band 0 (δ * (d : ℝ)) δ (le_of_lt hδpos) ?_ ?_ ?_
      · have hNfour : (4 : ℝ) ≤ (N : ℝ) := by
          dsimp [N]
          norm_num
          exact_mod_cast (show 4 ≤ 2 * m + 2 by omega)
        nlinarith [hNδ]
      · norm_num
        simpa [one_mul, mul_comm] using hlow
      · norm_num
        nlinarith [hNδ]
  · obtain ⟨t, ht, hpNorm, hcoords⟩ :=
      mirroredConsecutiveBlockWitness m P hm (by omega)
    refine ⟨t, ht, ?_⟩
    intro d hd
    rcases hd with hd | hd
    · exact (hcoords d hd.1 hd.2).1
    · by_cases hdP : d = P
      · subst d
        exact hpNorm
      · let i : ℕ := P - d
        have hi1 : 1 ≤ i := by
          dsimp [i]
          omega
        have him : i ≤ m := by
          dsimp [i]
          omega
        have hhigh := (hcoords i hi1 him).2
        have hident : P - i = d := by
          dsimp [i]
          omega
        simpa [hident] using hhigh

/-- Every runner in the lower endpoint block has a positive relative witness. -/
theorem mirroredBlockLowerRunner (m p r : ℕ) (hm : 1 ≤ m)
    (hp : 2 * m + 1 ≤ p) (hr : r ≤ m) :
    ∃ t : ℝ, 0 < t ∧ ∀ s : ℕ, s ∈ mirroredBlockSpeeds m p → s ≠ r →
      (((2 * m + 2 : ℕ) : ℝ)⁻¹) ≤ circleNorm (t * ((s : ℝ) - (r : ℝ))) := by
  obtain ⟨t, ht, hcover⟩ := mirroredBlockMagnitudeCover m (p - r) hm (by omega)
  refine ⟨t, ht, ?_⟩
  intro s hs hsr
  by_cases hle : s ≤ r
  · let d : ℕ := r - s
    have hd1 : 1 ≤ d := by
      dsimp [d]
      omega
    have hdm : d ≤ m := by
      dsimp [d]
      omega
    have hbound := hcover d (Or.inl ⟨hd1, hdm⟩)
    have hcast : ((r - s : ℕ) : ℝ) = (r : ℝ) - (s : ℝ) := by
      rw [Nat.cast_sub hle]
    rw [hcast] at hbound
    have hphase : t * ((s : ℝ) - (r : ℝ)) = -(t * ((r : ℝ) - (s : ℝ))) := by ring
    rw [hphase, circleNorm_neg]
    exact hbound
  · have hlt : r < s := Nat.lt_of_not_ge hle
    let d : ℕ := s - r
    have hcast : ((s - r : ℕ) : ℝ) = (s : ℝ) - (r : ℝ) := by
      rw [Nat.cast_sub (Nat.le_of_lt hlt)]
    have hmem : s ≤ m ∨ (p - m ≤ s ∧ s ≤ p) := by
      rw [mirroredBlockSpeeds] at hs
      rcases Finset.mem_union.mp hs with hs | hs
      · exact Or.inl (Finset.mem_Icc.mp hs).2
      · exact Or.inr (Finset.mem_Icc.mp hs)
    rcases hmem with hsm | hsp
    · have hd1 : 1 ≤ d := by dsimp [d]; omega
      have hdm : d ≤ m := by dsimp [d]; omega
      have hbound := hcover d (Or.inl ⟨hd1, hdm⟩)
      simpa [d, hcast] using hbound
    · have hdm : p - r - m ≤ d := by dsimp [d]; omega
      have hdp : d ≤ p - r := by dsimp [d]; omega
      have hbound := hcover d (Or.inr ⟨hdm, hdp⟩)
      simpa [d, hcast] using hbound

/-- Every chosen speed in the full mirrored block has a positive relative
witness at the configuration's canonical closed threshold. -/
theorem mirroredBlockRunnerWitness (m p : ℕ) (hm : 1 ≤ m)
    (hp : 2 * m + 1 ≤ p) (r : ℕ) (hr : r ∈ mirroredBlockSpeeds m p) :
    ∃ t : ℝ, 0 < t ∧ ∀ s : ℕ, s ∈ mirroredBlockSpeeds m p → s ≠ r →
      (((2 * m + 2 : ℕ) : ℝ)⁻¹) ≤ circleNorm (t * ((s : ℝ) - (r : ℝ))) := by
  by_cases hrlow : r ≤ m
  · exact mirroredBlockLowerRunner m p r hm hp hrlow
  · have hrupper : p - m ≤ r ∧ r ≤ p := by
      rw [mirroredBlockSpeeds] at hr
      rcases Finset.mem_union.mp hr with hr | hr
      · exact False.elim (hrlow (Finset.mem_Icc.mp hr).2)
      · exact Finset.mem_Icc.mp hr
    have hrp : r ≤ p := hrupper.2
    have hreflect : p - r ≤ m := by omega
    obtain ⟨t, ht, hlower⟩ := mirroredBlockLowerRunner m p (p - r) hm hp hreflect
    refine ⟨t, ht, ?_⟩
    intro s hs hsr
    have hsP : s ≤ p := by
      rw [mirroredBlockSpeeds] at hs
      rcases Finset.mem_union.mp hs with hs | hs
      · have hmp : m ≤ p := by omega
        have hs' := Finset.mem_Icc.mp hs
        omega
      · exact (Finset.mem_Icc.mp hs).2
    have hmem : p - s ∈ mirroredBlockSpeeds m p := by
      rw [mirroredBlockSpeeds] at hs ⊢
      rcases Finset.mem_union.mp hs with hs | hs
      · apply Finset.mem_union.mpr
        right
        apply Finset.mem_Icc.mpr
        have hs' := Finset.mem_Icc.mp hs
        omega
      · apply Finset.mem_union.mpr
        left
        apply Finset.mem_Icc.mpr
        have hs' := Finset.mem_Icc.mp hs
        omega
    have hne : p - s ≠ p - r := by omega
    have hgood := hlower (p - s) hmem hne
    rw [Nat.cast_sub hsP, Nat.cast_sub hrp] at hgood
    have hphase : t * ((p : ℝ) - (s : ℝ) - ((p : ℝ) - (r : ℝ))) =
        -(t * ((s : ℝ) - (r : ℝ))) := by ring
    rw [hphase, circleNorm_neg] at hgood
    exact hgood

/-- The exact finite configuration yields a lonely witness for every chosen
runner under any injective labelling by its natural speeds. -/
theorem mirroredBlockLonelyAt (m p : ℕ) (hm : 1 ≤ m)
    (hp : 2 * m + 1 ≤ p) (speeds : Fin (2 * m + 2) → ℕ)
    (hinj : Function.Injective speeds)
    (hmem : ∀ i, speeds i ∈ mirroredBlockSpeeds m p) :
    ∀ runner, ∃ t : ℝ, 0 < t ∧ LonelyAt (fun i => (speeds i : ℝ)) runner t := by
  intro runner
  obtain ⟨t, ht, hpoint⟩ :=
    mirroredBlockRunnerWitness m p hm hp (speeds runner) (hmem runner)
  refine ⟨t, ht, (lonelyAt_iff_relativeLonelyAt (fun i => (speeds i : ℝ)) runner t).mpr ?_⟩
  intro other hother
  have hneq : speeds other ≠ speeds runner := hinj.ne hother
  have hbound := hpoint (speeds other) (hmem other) hneq
  simpa [circleNorm] using hbound

end LonelyRunner
