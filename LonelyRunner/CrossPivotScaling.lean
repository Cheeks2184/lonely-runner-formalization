import LonelyRunner.PivotResidues
import Mathlib.Data.Nat.GCD.Basic
import Mathlib.Tactic

/-!
# Cross-pivot scaling

When one pivot speed is a coprime integer multiple of another, multiplication
of candidate numerators by the same factor embeds the smaller pivot grid into
the larger one and preserves every strict bad-set decision.
-/

namespace LonelyRunner

/-- Circular residue distance is homogeneous when both the modulus and the
argument are multiplied by the same natural factor. -/
theorem cyclicResidueDistance_mul_left (q M x : Nat) :
    cyclicResidueDistance (q * M) (q * x) =
      q * cyclicResidueDistance M x := by
  unfold cyclicResidueDistance
  rw [Nat.mul_mod_mul_left]
  rw [← Nat.mul_sub_left_distrib]
  exact (mul_min q (x % M) (M - x % M)).symm

/-- Coprime scaling preserves the condition of not being divisible by `N`. -/
theorem not_dvd_mul_iff_of_coprime {N q r : Nat} (hcop : Nat.Coprime q N) :
    ¬N ∣ q * r ↔ ¬N ∣ r := by
  rw [not_iff_not]
  exact hcop.symm.dvd_mul_left

/-- Scaling gives an exact equivalence of candidate membership on the source
grid and membership of the scaled numerator on the target grid. -/
theorem mem_pivotCandidates_mul_iff {N pivot q r : Nat}
    (hq : 0 < q) (hcop : Nat.Coprime q N) :
    q * r ∈ pivotCandidates N (q * pivot) ↔
      r ∈ pivotCandidates N pivot := by
  rw [mem_pivotCandidates, mem_pivotCandidates]
  constructor
  · rintro ⟨hrange, hnot⟩
    constructor
    · apply (Nat.mul_lt_mul_left hq).mp
      simpa only [Nat.mul_assoc, Nat.mul_left_comm, Nat.mul_comm] using hrange
    · exact (not_dvd_mul_iff_of_coprime hcop).mp hnot
  · rintro ⟨hrange, hnot⟩
    constructor
    · have hscaled := (Nat.mul_lt_mul_left hq).mpr hrange
      simpa only [Nat.mul_assoc, Nat.mul_left_comm, Nat.mul_comm] using hscaled
    · exact (not_dvd_mul_iff_of_coprime hcop).mpr hnot

/-- Every coordinate's strict bad decision is preserved along the scaled
candidate injection. -/
theorem mem_pivotBadResidues_mul_iff {N pivot q other r : Nat}
    (hq : 0 < q) (hcop : Nat.Coprime q N) :
    q * r ∈ pivotBadResidues N (q * pivot) other ↔
      r ∈ pivotBadResidues N pivot other := by
  rw [mem_pivotBadResidues, mem_pivotBadResidues]
  rw [mem_pivotCandidates_mul_iff hq hcop]
  apply and_congr_right
  intro _
  have hscale :
      cyclicResidueDistance (N * (q * pivot)) ((q * r) * other) =
        q * cyclicResidueDistance (N * pivot) (r * other) := by
    simpa only [Nat.mul_assoc, Nat.mul_left_comm, Nat.mul_comm] using
      cyclicResidueDistance_mul_left q (N * pivot) (r * other)
  rw [hscale]
  exact Nat.mul_lt_mul_left hq

/-- Closed-good decisions are preserved as well; this is just the negated
strict-bad equivalence and therefore includes equality at the boundary. -/
theorem not_mem_pivotBadResidues_mul_iff {N pivot q other r : Nat}
    (hq : 0 < q) (hcop : Nat.Coprime q N) :
    q * r ∉ pivotBadResidues N (q * pivot) other ↔
      r ∉ pivotBadResidues N pivot other := by
  rw [mem_pivotBadResidues_mul_iff hq hcop]

/-- Candidates simultaneously safe against every speed in a finite family. -/
def pivotSafeResidues {n : Nat} (N pivot : Nat) (speeds : Fin n → Nat) :
    Finset Nat :=
  (pivotCandidates N pivot).filter fun r =>
    ∀ i, r ∉ pivotBadResidues N pivot (speeds i)

theorem mem_pivotSafeResidues {n N pivot r : Nat} {speeds : Fin n → Nat} :
    r ∈ pivotSafeResidues N pivot speeds ↔
      r ∈ pivotCandidates N pivot ∧
        ∀ i, r ∉ pivotBadResidues N pivot (speeds i) := by
  simp [pivotSafeResidues]

/-- The scaling map sends every source-safe residue to a target-safe residue. -/
theorem mul_mem_pivotSafeResidues {n N pivot q r : Nat}
    {speeds : Fin n → Nat} (hq : 0 < q) (hcop : Nat.Coprime q N)
    (hr : r ∈ pivotSafeResidues N pivot speeds) :
    q * r ∈ pivotSafeResidues N (q * pivot) speeds := by
  rw [mem_pivotSafeResidues] at hr ⊢
  constructor
  · exact (mem_pivotCandidates_mul_iff hq hcop).mpr hr.1
  · intro i
    exact (not_mem_pivotBadResidues_mul_iff hq hcop).mpr (hr.2 i)

/-- Cross-pivot monotonicity of safe-candidate counts.  The theorem asserts
only an injection into the larger grid; it makes no surjectivity claim. -/
theorem card_pivotSafeResidues_le_mul {n N pivot q : Nat}
    (speeds : Fin n → Nat) (hq : 0 < q) (hcop : Nat.Coprime q N) :
    (pivotSafeResidues N pivot speeds).card ≤
      (pivotSafeResidues N (q * pivot) speeds).card := by
  classical
  let source := pivotSafeResidues N pivot speeds
  let target := pivotSafeResidues N (q * pivot) speeds
  let scale : Nat → Nat := fun r => q * r
  have hinj : Set.InjOn scale (source : Set Nat) := by
    intro x _ y _ hxy
    exact Nat.mul_left_cancel hq hxy
  have hcard : (source.image scale).card = source.card :=
    Finset.card_image_iff.mpr hinj
  have hsubset : source.image scale ⊆ target := by
    intro y hy
    obtain ⟨r, hr, rfl⟩ := Finset.mem_image.mp hy
    exact mul_mem_pivotSafeResidues hq hcop hr
  rw [← hcard]
  exact Finset.card_le_card hsubset

end LonelyRunner
