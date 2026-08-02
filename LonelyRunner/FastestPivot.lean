import LonelyRunner.PivotResidues
import Mathlib.Algebra.Order.Floor.Div

/-!
# A sufficient criterion at the fastest pivot

Let `B` be a fastest positive integer speed.  If every speed `s` satisfies
`B ≤ (N - 1) * s`, then the explicit numerator `r = N - 1` is safe on the
`B`-pivot grid.  Indeed, `(N - 1) * s` lies in the closed interval
`[B, N * B - B]`, so its cyclic residue distance modulo `N * B` is at least
`B`.  The endpoints are included, matching the closed `1 / N` Lonely Runner
boundary.

The final theorem records the useful contrapositive: if the fastest pivot has
no certificate at all, then `(N - 1) * a_min < a_max`.  This is a restriction
on a possible failure of the fastest-pivot strategy, not a proof of the
unrestricted Lonely Runner Conjecture.
-/

namespace LonelyRunner

open Finset

/-- For `N ≥ 2` and a positive pivot, `N - 1` is a pivot candidate. -/
theorem N_sub_one_mem_pivotCandidates {N pivot : Nat}
    (hN : 2 ≤ N) (hpivot : 0 < pivot) :
    N - 1 ∈ pivotCandidates N pivot := by
  rw [mem_pivotCandidates]
  constructor
  · have hNpos : 0 < N := by omega
    have hpivotOne : 1 ≤ pivot := hpivot
    calc
      N - 1 < N := Nat.sub_lt (by omega) (by omega)
      _ ≤ N * pivot := by
        simpa using Nat.mul_le_mul_left N hpivotOne
  · intro hdvd
    have hmod : (N - 1) % N = N - 1 := Nat.mod_eq_of_lt (Nat.sub_lt (by omega) (by omega))
    have hzero : (N - 1) % N = 0 := Nat.dvd_iff_mod_eq_zero.mp hdvd
    omega

/-- The numerator `N - 1` has cyclic residue distance at least `pivot` for
every speed between the ratio lower bound and the fastest pivot. -/
theorem pivot_le_cyclicResidueDistance_N_sub_one_mul
    {N pivot other : Nat} (hN : 2 ≤ N) (hpivot : 0 < pivot)
    (hotherPivot : other ≤ pivot)
    (hratio : pivot ≤ (N - 1) * other) :
    pivot ≤ cyclicResidueDistance (N * pivot) ((N - 1) * other) := by
  have hNdecomp : N = (N - 1) + 1 := by omega
  have hmuldecomp : N * pivot = (N - 1) * pivot + pivot := by
    calc
      N * pivot = ((N - 1) + 1) * pivot :=
        congrArg (fun k => k * pivot) hNdecomp
      _ = (N - 1) * pivot + pivot := by rw [Nat.add_mul, Nat.one_mul]
  have hupper : (N - 1) * other ≤ (N - 1) * pivot :=
    Nat.mul_le_mul_left (N - 1) hotherPivot
  have hlt : (N - 1) * other < N * pivot := by
    calc
      (N - 1) * other ≤ (N - 1) * pivot := hupper
      _ < (N - 1) * pivot + pivot := Nat.lt_add_of_pos_right hpivot
      _ = N * pivot := hmuldecomp.symm
  rw [cyclicResidueDistance, Nat.mod_eq_of_lt hlt]
  apply le_min hratio
  apply Nat.le_sub_of_add_le
  calc
    pivot + (N - 1) * other ≤ pivot + (N - 1) * pivot :=
      Nat.add_le_add_left hupper pivot
    _ = N * pivot := by simpa [Nat.add_comm] using hmuldecomp.symm

/-- Any numerator whose product with a speed lies in the closed safe band
`[pivot, (N - 1) * pivot]` has cyclic residue distance at least `pivot`.
This is the arithmetic core of the fastest-pivot interval-compression
criterion. -/
theorem pivot_le_cyclicResidueDistance_mul_of_band
    {N pivot r other : Nat} (hN : 2 ≤ N) (hpivot : 0 < pivot)
    (hlower : pivot ≤ r * other)
    (hupper : r * other ≤ (N - 1) * pivot) :
    pivot ≤ cyclicResidueDistance (N * pivot) (r * other) := by
  have hNm1N : N - 1 < N := Nat.sub_lt (by omega) (by omega)
  have hupperLt : (N - 1) * pivot < N * pivot :=
    Nat.mul_lt_mul_of_pos_right hNm1N hpivot
  have hlt : r * other < N * pivot := hupper.trans_lt hupperLt
  rw [cyclicResidueDistance, Nat.mod_eq_of_lt hlt]
  apply le_min hlower
  exact Nat.le_sub_of_add_le (by
    have hdecomp : N * pivot = (N - 1) * pivot + pivot := by
      have hNdecomp : N = (N - 1) + 1 := by omega
      calc
        N * pivot = ((N - 1) + 1) * pivot :=
          congrArg (fun k => k * pivot) hNdecomp
        _ = (N - 1) * pivot + pivot := by rw [Nat.add_mul, Nat.one_mul]
    calc
      pivot + r * other ≤ pivot + (N - 1) * pivot :=
        Nat.add_le_add_left hupper pivot
      _ = N * pivot := by simpa [Nat.add_comm] using hdecomp.symm)

/-- Sol Pro Response 49's exact fastest-pivot interval-compression lemma.
If all nonpivot speeds lie between a chosen lower and upper extremum, and one
numerator maps those extrema into the closed safe band, that numerator is a
canonical certificate at the fastest pivot. -/
theorem exists_fastestPivotCertificate_of_extremal_band
    {n N upper r : Nat} (speeds : Fin n → Nat)
    (slowest fastest : Fin n) (hN : 2 ≤ N)
    (hpos : ∀ i, 0 < speeds i) (hupperPos : 0 < upper)
    (hslowest : ∀ i, i ≠ fastest → speeds slowest ≤ speeds i)
    (hupper : ∀ i, i ≠ fastest → speeds i ≤ upper)
    (hlowerBand : speeds fastest ≤ r * speeds slowest)
    (hupperBand : r * upper ≤ (N - 1) * speeds fastest)
    (hrNotDvd : ¬N ∣ r) :
    ∃ q : Nat,
      q ∈ pivotCandidates N (speeds fastest) ∧
        ∀ i, i ≠ fastest →
          q ∉ pivotBadResidues N (speeds fastest) (speeds i) := by
  have hrUpper : r ≤ r * upper := by
    simpa using Nat.mul_le_mul_left r hupperPos
  have hNm1N : N - 1 < N := Nat.sub_lt (by omega) (by omega)
  have hbandLt : (N - 1) * speeds fastest < N * speeds fastest :=
    Nat.mul_lt_mul_of_pos_right hNm1N (hpos fastest)
  have hrLt : r < N * speeds fastest :=
    lt_of_le_of_lt hrUpper (hupperBand.trans_lt hbandLt)
  have hrCandidate : r ∈ pivotCandidates N (speeds fastest) := by
    rw [mem_pivotCandidates]
    exact ⟨hrLt, hrNotDvd⟩
  refine ⟨r, hrCandidate, ?_⟩
  intro i hi
  intro hbad
  have hlower : speeds fastest ≤ r * speeds i :=
    hlowerBand.trans (Nat.mul_le_mul_left r (hslowest i hi))
  have hupp : r * speeds i ≤ (N - 1) * speeds fastest :=
    (Nat.mul_le_mul_left r (hupper i hi)).trans hupperBand
  have hdist := pivot_le_cyclicResidueDistance_mul_of_band
    hN (hpos fastest) hlower hupp
  exact (Nat.not_lt_of_ge hdist) (mem_pivotBadResidues.mp hbad).2

/-- Every nonmultiple in the exact natural ceiling/floor interval gives the
fastest-pivot certificate supplied by the extremal-band theorem.  The lower
and upper endpoints are closed. -/
theorem exists_fastestPivotCertificate_of_mem_extremal_interval
    {n N upper r : Nat} (speeds : Fin n → Nat)
    (slowest fastest : Fin n) (hN : 2 ≤ N)
    (hpos : ∀ i, 0 < speeds i) (hupperPos : 0 < upper)
    (hslowest : ∀ i, i ≠ fastest → speeds slowest ≤ speeds i)
    (hupper : ∀ i, i ≠ fastest → speeds i ≤ upper)
    (hrLower : speeds fastest ⌈/⌉ speeds slowest ≤ r)
    (hrUpper : r ≤ ((N - 1) * speeds fastest) / upper)
    (hrNotDvd : ¬ N ∣ r) :
    ∃ q : Nat,
      q ∈ pivotCandidates N (speeds fastest) ∧
        ∀ i, i ≠ fastest →
          q ∉ pivotBadResidues N (speeds fastest) (speeds i) := by
  apply exists_fastestPivotCertificate_of_extremal_band
    speeds slowest fastest hN hpos hupperPos hslowest hupper
  · have h := (ceilDiv_le_iff_le_mul (hpos slowest)).mp hrLower
    simpa [Nat.mul_comm] using h
  · exact (Nat.le_div_iff_mul_le hupperPos).mp hrUpper
  · exact hrNotDvd

/-- If the fastest pivot has no certificate, its exact ceiling/floor interval
is either empty or a singleton consisting of a multiple of `N`. -/
theorem extremal_interval_compression_of_no_fastestPivotCertificate
    {n N upper : Nat} (speeds : Fin n → Nat)
    (slowest fastest : Fin n) (hN : 2 ≤ N)
    (hpos : ∀ i, 0 < speeds i) (hupperPos : 0 < upper)
    (hslowest : ∀ i, i ≠ fastest → speeds slowest ≤ speeds i)
    (hupper : ∀ i, i ≠ fastest → speeds i ≤ upper)
    (hfail : ¬ ∃ r : Nat,
      r ∈ pivotCandidates N (speeds fastest) ∧
        ∀ i, i ≠ fastest →
          r ∉ pivotBadResidues N (speeds fastest) (speeds i)) :
    let L := speeds fastest ⌈/⌉ speeds slowest
    let U := ((N - 1) * speeds fastest) / upper
    U < L ∨ (U = L ∧ N ∣ L) := by
  dsimp only
  let L := speeds fastest ⌈/⌉ speeds slowest
  let U := ((N - 1) * speeds fastest) / upper
  by_cases hUL : U < L
  · exact Or.inl hUL
  have hLU : L ≤ U := Nat.le_of_not_gt hUL
  by_cases hEq : U = L
  · refine Or.inr ⟨hEq, ?_⟩
    by_contra hnotDvd
    exact hfail (exists_fastestPivotCertificate_of_mem_extremal_interval
      speeds slowest fastest hN hpos hupperPos hslowest hupper
      (r := L) (by simp [L]) (by simpa [U] using hLU) hnotDvd)
  have hLt : L < U := by omega
  by_cases hdiv : N ∣ L
  · have hnotSucc : ¬ N ∣ L + 1 := by
      intro hsucc
      have hNOne : N ∣ 1 := (Nat.dvd_add_iff_left hdiv).mpr (by
        simpa [Nat.add_comm] using hsucc)
      have hNleOne : N ≤ 1 := Nat.le_of_dvd (by decide) hNOne
      omega
    exfalso
    exact hfail (exists_fastestPivotCertificate_of_mem_extremal_interval
      speeds slowest fastest hN hpos hupperPos hslowest hupper
      (r := L + 1) (by simp [L])
      (by simpa [U] using (show L + 1 ≤ U by omega)) hnotSucc)
  · exfalso
    exact hfail (exists_fastestPivotCertificate_of_mem_extremal_interval
      speeds slowest fastest hN hpos hupperPos hslowest hupper
      (r := L) (by simp [L]) (by simpa [U] using hLU) hdiv)

/-- Normalization regression for `N=4`, fastest speed `10`, and speed `4`.
The pivot time is `3 / (4*10)`, not `3 / 10`; the resulting phase is `3/10`
and meets the closed `1/4` threshold. -/
theorem fastestPivot_normalization_regression :
    ((4 : Real)⁻¹) ≤
      circleNorm (((3 : Real) / ((4 * 10 : Nat) : Real)) * (4 : Real)) := by
  have hres : 10 ≤ cyclicResidueDistance 40 12 := by
    norm_num [cyclicResidueDistance]
  have h := circleNorm_nat_div_ge (M := 40) (x := 12) (b := 10)
    (by norm_num) hres
  convert h using 1 <;> norm_num

/-- Under the fastest-pivot ratio condition, `N - 1` avoids every strict bad
set on the fastest pivot grid. -/
theorem N_sub_one_not_mem_fastestPivotBadResidues
    {N pivot other : Nat} (hN : 2 ≤ N) (hpivot : 0 < pivot)
    (hotherPivot : other ≤ pivot)
    (hratio : pivot ≤ (N - 1) * other) :
    N - 1 ∉ pivotBadResidues N pivot other := by
  intro hbad
  have hlt := (mem_pivotBadResidues.mp hbad).2
  exact (Nat.not_lt_of_ge
    (pivot_le_cyclicResidueDistance_N_sub_one_mul
      hN hpivot hotherPivot hratio)) hlt

/-- The fastest-pivot ratio hypothesis supplies the explicit pivot
certificate `r = N - 1`. -/
theorem exists_fastestPivotCertificate_of_ratio
    {n N : Nat} (speeds : Fin n → Nat) (fastest : Fin n)
    (hN : 2 ≤ N) (hpos : ∀ i, 0 < speeds i)
    (hfastest : ∀ i, speeds i ≤ speeds fastest)
    (hratio : ∀ i, speeds fastest ≤ (N - 1) * speeds i) :
    ∃ r : Nat,
      r ∈ pivotCandidates N (speeds fastest) ∧
        ∀ i, i ≠ fastest →
          r ∉ pivotBadResidues N (speeds fastest) (speeds i) := by
  refine ⟨N - 1, N_sub_one_mem_pivotCandidates hN (hpos fastest), ?_⟩
  intro i _hi
  exact N_sub_one_not_mem_fastestPivotBadResidues
    hN (hpos fastest) (hfastest i) (hratio i)

/-- Real closed-boundary witness obtained from the explicit fastest-pivot
certificate.  No cardinality relation between `n` and `N` is needed for this
modular statement. -/
theorem fastestPivot_family_witness
    {n N : Nat} (speeds : Fin n → Nat) (fastest : Fin n)
    (hN : 2 ≤ N) (hpos : ∀ i, 0 < speeds i)
    (hfastest : ∀ i, speeds i ≤ speeds fastest)
    (hratio : ∀ i, speeds fastest ≤ (N - 1) * speeds i) :
    ∃ tau : Real, ∀ i,
      (N : Real)⁻¹ ≤ circleNorm (tau * (speeds i : Real)) := by
  let r := N - 1
  have hr : r ∈ pivotCandidates N (speeds fastest) :=
    N_sub_one_mem_pivotCandidates hN (hpos fastest)
  have havoid : ∀ i, i ≠ fastest →
      r ∉ pivotBadResidues N (speeds fastest) (speeds i) := by
    intro i _hi
    exact N_sub_one_not_mem_fastestPivotBadResidues
      hN (hpos fastest) (hfastest i) (hratio i)
  refine ⟨(r : Real) / ((N * speeds fastest : Nat) : Real), ?_⟩
  exact pivotResidueWitness speeds fastest (by omega) hpos r hr havoid

/-- If the fastest pivot has no modular certificate, some speed violates the
ratio criterion. -/
theorem exists_ratio_gap_of_no_fastestPivotCertificate
    {n N : Nat} (speeds : Fin n → Nat) (fastest : Fin n)
    (hN : 2 ≤ N) (hpos : ∀ i, 0 < speeds i)
    (hfastest : ∀ i, speeds i ≤ speeds fastest)
    (hfail : ¬ ∃ r : Nat,
      r ∈ pivotCandidates N (speeds fastest) ∧
        ∀ i, i ≠ fastest →
          r ∉ pivotBadResidues N (speeds fastest) (speeds i)) :
    ∃ i, (N - 1) * speeds i < speeds fastest := by
  by_contra hgap
  exact hfail (exists_fastestPivotCertificate_of_ratio
    speeds fastest hN hpos hfastest fun i =>
      Nat.le_of_not_gt (fun hi => hgap ⟨i, hi⟩))

/-- In min/max language, failure of every certificate at the fastest pivot
forces the strict spread `(N - 1) * a_min < a_max`. -/
theorem slowest_fastest_gap_of_no_fastestPivotCertificate
    {n N : Nat} (speeds : Fin n → Nat) (slowest fastest : Fin n)
    (hN : 2 ≤ N) (hpos : ∀ i, 0 < speeds i)
    (hslowest : ∀ i, speeds slowest ≤ speeds i)
    (hfastest : ∀ i, speeds i ≤ speeds fastest)
    (hfail : ¬ ∃ r : Nat,
      r ∈ pivotCandidates N (speeds fastest) ∧
        ∀ i, i ≠ fastest →
          r ∉ pivotBadResidues N (speeds fastest) (speeds i)) :
    (N - 1) * speeds slowest < speeds fastest := by
  obtain ⟨i, hi⟩ := exists_ratio_gap_of_no_fastestPivotCertificate
    speeds fastest hN hpos hfastest hfail
  exact lt_of_le_of_lt (Nat.mul_le_mul_left (N - 1) (hslowest i)) hi

end LonelyRunner
