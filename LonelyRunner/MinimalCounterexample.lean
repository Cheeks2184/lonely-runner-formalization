import LonelyRunner.FiniteFamilyEquivalence
import LonelyRunner.PivotBoundary
import Mathlib.Algebra.GCDMonoid.Finset
import Mathlib.Tactic

open scoped BigOperators

namespace LonelyRunner

/-- A positive integer speed family fails when every time has a runner strictly
below the closed lonely-runner threshold. -/
def PositiveIntegerFailure {n : ℕ} (v : Fin n → ℕ) : Prop :=
  ∀ t : ℝ, ∃ i : Fin n,
    circleNorm (t * (v i : ℝ)) < (((n + 1 : ℕ) : ℝ)⁻¹)

/-- A lexicographically minimal positive injective integer failure, with a
secondary minimum of the sum of its speeds. -/
structure MinimalPositiveIntegerFailure {n : ℕ}
    (v : Fin n → ℕ) : Prop where
  count_pos : 1 ≤ n
  positive : ∀ i, 0 < v i
  injective : Function.Injective v
  failure : PositiveIntegerFailure v
  previous_counts : ∀ d : ℕ, 1 ≤ d → d < n → PositiveIntegerAtCount d
  sum_minimal : ∀ w : Fin n → ℕ,
    Function.Injective w → (∀ i, 0 < w i) →
    PositiveIntegerFailure w →
    (∑ i : Fin n, v i) ≤ (∑ i : Fin n, w i)
  primitive : Finset.univ.gcd v = 1

theorem positiveIntegerFailure_iff_no_witness
    {n : ℕ} (v : Fin n → ℕ) :
    PositiveIntegerFailure v ↔
      ¬ ∃ t : ℝ, ∀ i : Fin n,
        (((n + 1 : ℕ) : ℝ)⁻¹) ≤ circleNorm (t * (v i : ℝ)) := by
  constructor
  · intro h hw
    obtain ⟨t, ht⟩ := hw
    obtain ⟨i, hi⟩ := h t
    exact (not_lt_of_ge (ht i)) hi
  · intro h t
    by_contra hnone
    apply h
    refine ⟨t, ?_⟩
    intro i
    exact le_of_not_gt (fun hi => hnone ⟨i, hi⟩)

theorem positiveIntegerFailure_factor_iff
    {n : ℕ} (v w : Fin n → ℕ) (g : ℕ) (hg : 0 < g)
    (hfactor : ∀ i, v i = g * w i) :
    PositiveIntegerFailure v ↔ PositiveIntegerFailure w := by
  have hgR : (g : ℝ) ≠ 0 := by exact_mod_cast (Nat.ne_of_gt hg)
  constructor
  · intro hv t
    obtain ⟨i, hi⟩ := hv (t / (g : ℝ))
    refine ⟨i, ?_⟩
    rw [hfactor i] at hi
    have hphase : (t / (g : ℝ)) * (((g * w i : ℕ) : ℝ)) =
        t * (w i : ℝ) := by
      push_cast
      field_simp
    rwa [hphase] at hi
  · intro hw t
    obtain ⟨i, hi⟩ := hw ((g : ℝ) * t)
    refine ⟨i, ?_⟩
    rw [hfactor i]
    have hphase : ((g : ℝ) * t) * (w i : ℝ) =
        t * (((g * w i : ℕ) : ℝ)) := by
      push_cast
      ring
    rwa [← hphase]

private theorem exists_failed_positive_count (hnot : ¬ Conjecture) :
    ∃ d : ℕ, 1 ≤ d ∧ ¬ PositiveIntegerAtCount d := by
  have hnotPositive : ¬ PositiveIntegerConjecture := by
    intro h
    exact hnot (conjecture_iff_positiveIntegerConjecture.mpr h)
  by_contra hnone
  apply hnotPositive
  intro d hd speeds hinj hpos
  by_contra hnowitness
  apply hnone
  refine ⟨d, hd, ?_⟩
  intro hatcount
  exact hnowitness (hatcount speeds hinj hpos)

private theorem exists_positive_failure_at_count
    {n : ℕ} (hnot : ¬ PositiveIntegerAtCount n) :
    ∃ v : Fin n → ℕ, Function.Injective v ∧ (∀ i, 0 < v i) ∧
      PositiveIntegerFailure v := by
  classical
  simp only [PositiveIntegerAtCount] at hnot
  push Not at hnot
  obtain ⟨v, hinj, hpos, hnowitness⟩ := hnot
  refine ⟨v, hinj, hpos, ?_⟩
  exact hnowitness

private theorem positive_sum_of_positive {n : ℕ} (v : Fin n → ℕ)
    (hpos : ∀ i, 0 < v i) (i : Fin n) : 0 < ∑ j : Fin n, v j := by
  exact lt_of_lt_of_le (hpos i)
    (Finset.single_le_sum (fun _ _ => Nat.zero_le _) (Finset.mem_univ i))

private theorem quotient_injective {n : ℕ} {v : Fin n → ℕ} {g : ℕ}
    (hinj : Function.Injective v) (hfactor : ∀ i, v i = g * (v i / g)) :
    Function.Injective (fun i => v i / g) := by
  intro i j hij
  apply hinj
  rw [hfactor i, hfactor j]
  exact congrArg (fun q => g * q) hij

private theorem quotient_positive {n : ℕ} {v : Fin n → ℕ} {g : ℕ}
    (hpos : ∀ i, 0 < v i) (hg : 0 < g)
    (hdiv : ∀ i, g ∣ v i) : ∀ i, 0 < v i / g := by
  intro i
  exact Nat.div_pos (Nat.le_of_dvd (hpos i) (hdiv i)) hg

private theorem sum_quotient_lt_sum_of_factor_gt_one
    {n : ℕ} {v : Fin n → ℕ} {g : ℕ}
    (hn : 1 ≤ n) (hpos : ∀ i, 0 < v i) (hg : 1 < g)
    (hfactor : ∀ i, v i = g * (v i / g)) :
    (∑ i : Fin n, v i / g) < ∑ i : Fin n, v i := by
  let i0 : Fin n := ⟨0, Nat.zero_lt_of_lt hn⟩
  have hnonempty : (Finset.univ : Finset (Fin n)).Nonempty :=
    ⟨i0, Finset.mem_univ _⟩
  apply Finset.sum_lt_sum_of_nonempty hnonempty
  intro i _
  have hqpos : 0 < v i / g := by
    by_contra hnot
    have hz : v i / g = 0 := Nat.eq_zero_of_not_pos hnot
    have hf := hfactor i
    rw [hz, mul_zero] at hf
    exact (Nat.ne_of_gt (hpos i)) hf
  calc
    v i / g < g * (v i / g) := lt_mul_of_one_lt_left hqpos hg
    _ = v i := (hfactor i).symm

private theorem gcd_is_one_of_sum_minimal
    {n : ℕ} {v : Fin n → ℕ} (hn : 1 ≤ n)
    (hpos : ∀ i, 0 < v i) (hinj : Function.Injective v)
    (hfailure : PositiveIntegerFailure v)
    (hsum : ∀ w : Fin n → ℕ, Function.Injective w → (∀ i, 0 < w i) →
      PositiveIntegerFailure w → (∑ i : Fin n, v i) ≤ ∑ i : Fin n, w i) :
    Finset.univ.gcd v = 1 := by
  let g := Finset.univ.gcd v
  have hdiv : ∀ i, g ∣ v i := by
    intro i
    exact Finset.gcd_dvd (Finset.mem_univ i)
  have hgpos : 0 < g := by
    let i0 : Fin n := ⟨0, Nat.zero_lt_of_lt hn⟩
    apply Nat.pos_of_ne_zero
    exact (Finset.gcd_ne_zero_iff).mpr
      ⟨i0, Finset.mem_univ _, Nat.ne_of_gt (hpos i0)⟩
  have hfactor : ∀ i, v i = g * (v i / g) := by
    intro i
    exact (Nat.mul_div_cancel' (hdiv i)).symm
  have hqinj : Function.Injective (fun i => v i / g) :=
    quotient_injective hinj hfactor
  have hqpos : ∀ i, 0 < v i / g := quotient_positive hpos hgpos hdiv
  have hqfail : PositiveIntegerFailure (fun i => v i / g) :=
    (positiveIntegerFailure_factor_iff v (fun i => v i / g) g hgpos hfactor).mp hfailure
  have hgle : g ≤ 1 := by
    by_contra hnotle
    have hgt : 1 < g := by omega
    have hlt := sum_quotient_lt_sum_of_factor_gt_one hn hpos hgt hfactor
    exact (not_lt_of_ge (hsum _ hqinj hqpos hqfail)) hlt
  omega

theorem exists_minimalPositiveIntegerFailure
    (hnot : ¬ Conjecture) :
    ∃ (n : ℕ) (v : Fin n → ℕ), MinimalPositiveIntegerFailure v := by
  classical
  have hcount := exists_failed_positive_count hnot
  let n : ℕ := Nat.find hcount
  have hnspec : 1 ≤ n ∧ ¬ PositiveIntegerAtCount n := Nat.find_spec hcount
  obtain ⟨u, huinj, hupos, hufail⟩ := exists_positive_failure_at_count hnspec.2
  let Q : ℕ → Prop := fun s => ∃ w : Fin n → ℕ,
    Function.Injective w ∧ (∀ i, 0 < w i) ∧ PositiveIntegerFailure w ∧
      (∑ i : Fin n, w i) = s
  have hQ : ∃ s, Q s := ⟨∑ i : Fin n, u i, u, huinj, hupos, hufail, rfl⟩
  let s : ℕ := Nat.find hQ
  have hsspec : Q s := Nat.find_spec hQ
  obtain ⟨v, hv_inj, hv_pos, hv_fail, hv_sum⟩ := hsspec
  refine ⟨n, v, ?_⟩
  refine ⟨hnspec.1, hv_pos, hv_inj, hv_fail, ?_, ?_, ?_⟩
  · intro d hd hdn
    by_contra hbad
    exact (Nat.find_min hcount hdn) ⟨hd, hbad⟩
  · intro w hwinj hwpos hwfail
    have hQw : Q (∑ i : Fin n, w i) := ⟨w, hwinj, hwpos, hwfail, rfl⟩
    have hmin : s ≤ ∑ i : Fin n, w i := Nat.find_min' hQ hQw
    simpa [hv_sum] using hmin
  · exact gcd_is_one_of_sum_minimal hnspec.1 hv_pos hv_inj hv_fail (by
      intro w hwinj hwpos hwfail
      have hQw : Q (∑ i : Fin n, w i) := ⟨w, hwinj, hwpos, hwfail, rfl⟩
      have hmin : s ≤ ∑ i : Fin n, w i := Nat.find_min' hQ hQw
      simpa [hv_sum] using hmin)

theorem MinimalPositiveIntegerFailure.witness_of_sum_lt
    {n : ℕ} {v : Fin n → ℕ} (hv : MinimalPositiveIntegerFailure v)
    (w : Fin n → ℕ) (hinj : Function.Injective w)
    (hpos : ∀ i, 0 < w i)
    (hlt : (∑ i : Fin n, w i) < (∑ i : Fin n, v i)) :
    ∃ t : ℝ, ∀ i : Fin n,
      (((n + 1 : ℕ) : ℝ)⁻¹) ≤ circleNorm (t * (w i : ℝ)) := by
  by_contra hnone
  have hfail : PositiveIntegerFailure w :=
    positiveIntegerFailure_iff_no_witness w |>.mpr hnone
  exact (not_lt_of_ge (hv.sum_minimal w hinj hpos hfail)) hlt

private theorem exists_positive_minimum_time
    {n : ℕ} (v : Fin n → ℕ) (anchor : Fin n) (hpos : ∀ i, 0 < v i) :
    ∃ t : ℝ, t ∈ Set.Icc (0 : ℝ) 1 ∧
      0 < minimumCircleNorm (fun i => (v i : ℝ)) anchor t := by
  let S : ℕ := ∑ i : Fin n, v i
  let t : ℝ := 1 / (2 * (S : ℝ))
  have hS : 0 < S := positive_sum_of_positive v hpos anchor
  have hSR : 0 < (S : ℝ) := by exact_mod_cast hS
  have ht : 0 < t := by
    dsimp [t]
    positivity
  have htS : t * (S : ℝ) = 1 / 2 := by
    dsimp [t]
    field_simp
  have hmem : t ∈ Set.Icc (0 : ℝ) 1 := by
    constructor
    · exact ht.le
    · have hSone : (1 : ℝ) ≤ S := by
        exact_mod_cast (Nat.succ_le_iff.mpr hS)
      dsimp [t]
      apply (div_le_iff₀ (by positivity)).mpr
      nlinarith
  refine ⟨t, hmem, ?_⟩
  apply lt_of_lt_of_le ht
  apply le_minimumCircleNorm
  intro i
  have hvi : v i ≤ S := by
    dsimp [S]
    exact Finset.single_le_sum (fun _ _ => Nat.zero_le _) (Finset.mem_univ i)
  have hviR : (v i : ℝ) ≤ (S : ℝ) := by exact_mod_cast hvi
  have hvone : (1 : ℝ) ≤ v i := by exact_mod_cast (Nat.succ_le_iff.mpr (hpos i))
  have hphase_nonneg : 0 ≤ t * (v i : ℝ) := mul_nonneg ht.le (by positivity)
  have hphase_le : t * (v i : ℝ) ≤ 1 / 2 := by
    have := mul_le_mul_of_nonneg_left hviR ht.le
    rw [htS] at this
    exact this
  have hnorm : circleNorm (t * (v i : ℝ)) = t * (v i : ℝ) := by
    rw [circleNorm_eq_abs_of_abs_le_half (by
      rwa [abs_of_nonneg hphase_nonneg]), abs_of_nonneg hphase_nonneg]
  rw [hnorm]
  calc t = t * 1 := (mul_one t).symm
       _ ≤ t * (v i : ℝ) := mul_le_mul_of_nonneg_left hvone ht.le

private theorem minimumCircleNorm_fract
    {n : ℕ} (v : Fin n → ℕ) (anchor : Fin n) (t : ℝ) :
    minimumCircleNorm (fun i => (v i : ℝ)) anchor (Int.fract t) =
      minimumCircleNorm (fun i => (v i : ℝ)) anchor t := by
  apply le_antisymm
  · obtain ⟨i, hi⟩ := exists_eq_minimumCircleNorm (fun i => (v i : ℝ)) anchor t
    calc
      minimumCircleNorm (fun i => (v i : ℝ)) anchor (Int.fract t) ≤
          circleNorm (Int.fract t * (v i : ℝ)) :=
        minimumCircleNorm_le (fun i => (v i : ℝ)) anchor i (Int.fract t)
      _ = circleNorm (t * (v i : ℝ)) := by
        rw [circleNorm_fract_mul_nat t (v i)]
      _ = minimumCircleNorm (fun i => (v i : ℝ)) anchor t := hi
  · obtain ⟨i, hi⟩ :=
      exists_eq_minimumCircleNorm (fun i => (v i : ℝ)) anchor (Int.fract t)
    calc
      minimumCircleNorm (fun i => (v i : ℝ)) anchor t ≤
          circleNorm (t * (v i : ℝ)) :=
        minimumCircleNorm_le (fun i => (v i : ℝ)) anchor i t
      _ = circleNorm (Int.fract t * (v i : ℝ)) := by
        rw [circleNorm_fract_mul_nat t (v i)]
      _ = minimumCircleNorm (fun i => (v i : ℝ)) anchor (Int.fract t) := hi

theorem exists_attained_strict_failure_margin
    {n : ℕ} (v : Fin n → ℕ) (anchor : Fin n)
    (hpos : ∀ i, 0 < v i) (hfail : PositiveIntegerFailure v) :
    ∃ (mu tau : ℝ), tau ∈ Set.Icc (0 : ℝ) 1 ∧
      0 < mu ∧ mu < (((n + 1 : ℕ) : ℝ)⁻¹) ∧
      minimumCircleNorm (fun i => (v i : ℝ)) anchor tau = mu ∧
      ∀ t : ℝ,
        minimumCircleNorm (fun i => (v i : ℝ)) anchor t ≤ mu := by
  classical
  let F : ℝ → ℝ := minimumCircleNorm (fun i => (v i : ℝ)) anchor
  have hcont : Continuous F := continuous_minimumCircleNorm (fun i => (v i : ℝ)) anchor
  have hcompact : IsCompact (Set.Icc (0 : ℝ) 1) := isCompact_Icc
  obtain ⟨tau, htau, hmax⟩ :=
    hcompact.exists_isMaxOn (by exact ⟨0, by norm_num⟩) hcont.continuousOn
  obtain ⟨tpos, htpos_mem, htpos⟩ := exists_positive_minimum_time v anchor hpos
  have hmu_pos : 0 < F tau := by
    have hle := hmax htpos_mem
    exact lt_of_lt_of_le htpos hle
  have hglobal : ∀ t : ℝ, F t ≤ F tau := by
    intro t
    have hfract_mem : Int.fract t ∈ Set.Icc (0 : ℝ) 1 :=
      ⟨Int.fract_nonneg t, (Int.fract_lt_one t).le⟩
    calc
      F t = F (Int.fract t) := by
        dsimp [F]
        exact (minimumCircleNorm_fract v anchor t).symm
      _ ≤ F tau := hmax hfract_mem
  obtain ⟨i, hi⟩ := hfail tau
  have hmu_lt : F tau < (((n + 1 : ℕ) : ℝ)⁻¹) :=
    lt_of_le_of_lt (minimumCircleNorm_le (fun i => (v i : ℝ)) anchor i tau) hi
  exact ⟨F tau, tau, htau, hmu_pos, hmu_lt, rfl, hglobal⟩

end LonelyRunner
