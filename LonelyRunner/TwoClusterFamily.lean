import LonelyRunner.TwoClusterWitness

/-!
# Finite two-cluster speed families

This module records the finite-set bookkeeping for the two endpoint clusters
used by the phase-band construction.  The sets of offsets may differ: under
reflection, their roles are deliberately swapped.
-/

namespace LonelyRunner

/-- The speed set with a lower cluster `0 ∪ A` and the reflected upper
cluster `p - (0 ∪ B)`. -/
def twoClusterSpeeds (A B : Finset ℕ) (p : ℕ) : Finset ℕ :=
  insert 0 A ∪ (insert 0 B).image (fun b => p - b)

/-- The two endpoint clusters have their expected cardinality when their
positive offsets lie through `M` and their separating gap is large enough. -/
theorem card_twoClusterSpeeds (A B : Finset ℕ) (M p : ℕ)
    (hA : ∀ a, a ∈ A → 1 ≤ a ∧ a ≤ M)
    (hB : ∀ b, b ∈ B → 1 ≤ b ∧ b ≤ M)
    (hp : 2 * M + 1 ≤ p) :
    (twoClusterSpeeds A B p).card = A.card + B.card + 2 := by
  have h0A : 0 ∉ A := by
    intro hzero
    have h := hA 0 hzero
    omega
  have h0B : 0 ∉ B := by
    intro hzero
    have h := hB 0 hzero
    omega
  have hAcard : (insert 0 A).card = A.card + 1 := by
    rw [Finset.card_insert_of_notMem h0A]
  have hBcard : (insert 0 B).card = B.card + 1 := by
    rw [Finset.card_insert_of_notMem h0B]
  have hBinj : Set.InjOn (fun b : ℕ => p - b) ↑(insert 0 B) := by
    intro b hb c hc heq
    have hbM : b ≤ M := by
      rcases Finset.mem_insert.mp hb with rfl | hb
      · omega
      · exact (hB b hb).2
    have hcM : c ≤ M := by
      rcases Finset.mem_insert.mp hc with rfl | hc
      · omega
      · exact (hB c hc).2
    have hbp : b ≤ p := by omega
    have hcp : c ≤ p := by omega
    calc
      b = p - (p - b) := (Nat.sub_sub_self hbp).symm
      _ = p - (p - c) := congrArg (fun z => p - z) heq
      _ = c := Nat.sub_sub_self hcp
  have huppercard : ((insert 0 B).image (fun b => p - b)).card = B.card + 1 := by
    rw [Finset.card_image_iff.mpr hBinj, hBcard]
  have hdisjoint : Disjoint (insert 0 A) ((insert 0 B).image (fun b => p - b)) := by
    refine Finset.disjoint_left.2 ?_
    intro x hxA hxB
    have hxM : x ≤ M := by
      rcases Finset.mem_insert.mp hxA with rfl | hxA
      · omega
      · exact (hA x hxA).2
    obtain ⟨b, hb, hxb⟩ := Finset.mem_image.mp hxB
    have hbM : b ≤ M := by
      rcases Finset.mem_insert.mp hb with rfl | hb
      · omega
      · exact (hB b hb).2
    omega
  rw [twoClusterSpeeds, Finset.card_union_of_disjoint hdisjoint, hAcard, huppercard]
  omega

/-- Every speed in a separated two-cluster family lies at or below its upper
endpoint. -/
theorem twoClusterSpeeds_member_le (A B : Finset ℕ) (M p s : ℕ)
    (hA : ∀ a, a ∈ A → 1 ≤ a ∧ a ≤ M)
    (_hB : ∀ b, b ∈ B → 1 ≤ b ∧ b ≤ M)
    (hp : 2 * M + 1 ≤ p)
    (hs : s ∈ twoClusterSpeeds A B p) :
    s ≤ p := by
  rw [twoClusterSpeeds] at hs
  rcases Finset.mem_union.mp hs with hs | hs
  · rcases Finset.mem_insert.mp hs with rfl | hs
    · omega
    · have h := hA s hs
      omega
  · obtain ⟨b, _hb, rfl⟩ := Finset.mem_image.mp hs
    exact Nat.sub_le _ _

/-- Reflection sends a member of `twoClusterSpeeds A B p` to the explicitly
swapped configuration `twoClusterSpeeds B A p`. -/
theorem twoClusterSpeeds_reflect_mem (A B : Finset ℕ) (M p s : ℕ)
    (_hA : ∀ a, a ∈ A → 1 ≤ a ∧ a ≤ M)
    (hB : ∀ b, b ∈ B → 1 ≤ b ∧ b ≤ M)
    (hp : 2 * M + 1 ≤ p)
    (hs : s ∈ twoClusterSpeeds A B p) :
    p - s ∈ twoClusterSpeeds B A p := by
  rw [twoClusterSpeeds] at hs ⊢
  rcases Finset.mem_union.mp hs with hs | hs
  · apply Finset.mem_union.mpr
    right
    apply Finset.mem_image.mpr
    exact ⟨s, hs, rfl⟩
  · obtain ⟨b, hb, rfl⟩ := Finset.mem_image.mp hs
    apply Finset.mem_union.mpr
    left
    have hbM : b ≤ M := by
      rcases Finset.mem_insert.mp hb with rfl | hb
      · omega
      · exact (hB b hb).2
    have hbp : b ≤ p := by omega
    simpa [Nat.sub_sub_self hbp] using hb

/-- Membership is equivalent after reflection, with the offset sets swapped.
The bound on `s` makes the second reflection an involution on naturals. -/
theorem mem_twoClusterSpeeds_reflect_iff (A B : Finset ℕ) (M p s : ℕ)
    (hA : ∀ a, a ∈ A → 1 ≤ a ∧ a ≤ M)
    (hB : ∀ b, b ∈ B → 1 ≤ b ∧ b ≤ M)
    (hp : 2 * M + 1 ≤ p) (hsP : s ≤ p) :
    p - s ∈ twoClusterSpeeds B A p ↔ s ∈ twoClusterSpeeds A B p := by
  constructor
  · intro hs
    have hreflection := twoClusterSpeeds_reflect_mem B A M p (p - s) hB hA hp hs
    simpa [Nat.sub_sub_self hsP] using hreflection
  · exact twoClusterSpeeds_reflect_mem A B M p s hA hB hp

/-- A lower-cluster reference speed has a phase-cell witness against every
speed in the two-cluster family.  This helper deliberately does not require
`r` itself to belong to the family; the later all-runner theorem supplies
that membership separately. -/
theorem twoClusterLowerRunner (A B : Finset ℕ) (N M p r : ℕ)
    (hA : ∀ a, a ∈ A → 1 ≤ a ∧ a ≤ M)
    (hB : ∀ b, b ∈ B → 1 ≤ b ∧ b ≤ M)
    (hN : 4 ≤ N) (hM : 1 ≤ M) (hMN : M < N - 2)
    (hp : 2 * M + 1 ≤ p)
    (hg : M * (N - 1) ≤ (p - M) * (N - 2 - M))
    (hr : r ≤ M) :
    ∃ t : ℝ, 0 < t ∧ ∀ s : ℕ, s ∈ twoClusterSpeeds A B p → s ≠ r →
      ((N : ℝ)⁻¹) ≤ circleNorm (t * ((s : ℝ) - (r : ℝ))) := by
  have hP : M + 1 ≤ p - r := by omega
  have hPM : p - M ≤ p - r := by omega
  have hfactor : 0 < N - 2 - M := by omega
  have hgrow : M * (N - 1) ≤ (p - r) * (N - 2 - M) := by
    apply le_trans hg
    exact Nat.mul_le_mul_right _ hPM
  obtain ⟨t, ht, htop, hcoords⟩ :=
    twoClusterPhaseCellWitness N M (p - r) hN hM hMN hP hgrow
  refine ⟨t, ht, ?_⟩
  intro s hs hsr
  by_cases hle : s ≤ r
  · let d : ℕ := r - s
    have hd1 : 1 ≤ d := by
      dsimp [d]
      omega
    have hdM : d ≤ M := by
      dsimp [d]
      omega
    have hbound := (hcoords d hd1 hdM).1
    have hcast : ((r - s : ℕ) : ℝ) = (r : ℝ) - (s : ℝ) := by
      rw [Nat.cast_sub hle]
    rw [hcast] at hbound
    have hphase : t * ((s : ℝ) - (r : ℝ)) =
        -(t * ((r : ℝ) - (s : ℝ))) := by ring
    rw [hphase, circleNorm_neg]
    exact hbound
  · have hlt : r < s := Nat.lt_of_not_ge hle
    let d : ℕ := s - r
    have hd1 : 1 ≤ d := by
      dsimp [d]
      omega
    have hcast : ((s - r : ℕ) : ℝ) = (s : ℝ) - (r : ℝ) := by
      rw [Nat.cast_sub (Nat.le_of_lt hlt)]
    rw [twoClusterSpeeds] at hs
    rcases Finset.mem_union.mp hs with hs | hs
    · have hsM : s ≤ M := by
        rcases Finset.mem_insert.mp hs with rfl | hs
        · omega
        · exact (hA s hs).2
      have hdM : d ≤ M := by
        dsimp [d]
        omega
      have hbound := (hcoords d hd1 hdM).1
      rw [hcast] at hbound
      exact hbound
    · obtain ⟨b, hb, rfl⟩ := Finset.mem_image.mp hs
      rcases Finset.mem_insert.mp hb with rfl | hb
      · have hrp : r ≤ p := by omega
        rw [Nat.cast_sub hrp] at htop
        simpa using htop
      · have hbdata := hB b hb
        have hbp : b ≤ p := by omega
        have hbr : b ≤ p - r := by omega
        have hbound := (hcoords b hbdata.1 hbdata.2).2
        have hcastP : (((p - r) - b : ℕ) : ℝ) =
            (p : ℝ) - (r : ℝ) - (b : ℝ) := by
          rw [Nat.cast_sub hbr, Nat.cast_sub (show r ≤ p by omega)]
        rw [hcastP] at hbound
        have hphase : t * ((p : ℝ) - (r : ℝ) - (b : ℝ)) =
            t * (((p - b : ℕ) : ℝ) - (r : ℝ)) := by
          rw [Nat.cast_sub hbp]
          ring
        rw [hphase] at hbound
        exact hbound

/-- Every selected speed in a two-cluster family has a relative witness.
Upper-cluster speeds use reflection into the lower cluster of the explicitly
swapped family, so no equality of `A` and `B` is assumed. -/
theorem twoClusterRunnerWitness (A B : Finset ℕ) (N M p : ℕ)
    (hA : ∀ a, a ∈ A → 1 ≤ a ∧ a ≤ M)
    (hB : ∀ b, b ∈ B → 1 ≤ b ∧ b ≤ M)
    (hN : 4 ≤ N) (hM : 1 ≤ M) (hMN : M < N - 2)
    (hp : 2 * M + 1 ≤ p)
    (hg : M * (N - 1) ≤ (p - M) * (N - 2 - M))
    (r : ℕ) (hr : r ∈ twoClusterSpeeds A B p) :
    ∃ t : ℝ, 0 < t ∧ ∀ s : ℕ, s ∈ twoClusterSpeeds A B p → s ≠ r →
      ((N : ℝ)⁻¹) ≤ circleNorm (t * ((s : ℝ) - (r : ℝ))) := by
  by_cases hrlow : r ≤ M
  · exact twoClusterLowerRunner A B N M p r hA hB hN hM hMN hp hg hrlow
  · have hrreflect : p - r ≤ M := by
      rw [twoClusterSpeeds] at hr
      rcases Finset.mem_union.mp hr with hr | hr
      · exfalso
        apply hrlow
        rcases Finset.mem_insert.mp hr with rfl | hr
        · omega
        · exact (hA r hr).2
      · obtain ⟨b, hb, hbr⟩ := Finset.mem_image.mp hr
        have hbM : b ≤ M := by
          rcases Finset.mem_insert.mp hb with rfl | hb
          · omega
          · exact (hB b hb).2
        omega
    obtain ⟨t, ht, hlower⟩ :=
      twoClusterLowerRunner B A N M p (p - r) hB hA hN hM hMN hp hg hrreflect
    refine ⟨t, ht, ?_⟩
    intro s hs hsr
    have hsP : s ≤ p := twoClusterSpeeds_member_le A B M p s hA hB hp hs
    have hrP : r ≤ p := twoClusterSpeeds_member_le A B M p r hA hB hp hr
    have hsreflect : p - s ∈ twoClusterSpeeds B A p :=
      twoClusterSpeeds_reflect_mem A B M p s hA hB hp hs
    have hne : p - s ≠ p - r := by
      intro heq
      apply hsr
      calc
        s = p - (p - s) := (Nat.sub_sub_self hsP).symm
        _ = p - (p - r) := congrArg (fun z => p - z) heq
        _ = r := Nat.sub_sub_self hrP
    have hgood := hlower (p - s) hsreflect hne
    rw [Nat.cast_sub hsP, Nat.cast_sub hrP] at hgood
    have hphase : t * ((p : ℝ) - (s : ℝ) - ((p : ℝ) - (r : ℝ))) =
        -(t * ((s : ℝ) - (r : ℝ))) := by ring
    rw [hphase, circleNorm_neg] at hgood
    exact hgood

/-- The two-cluster configuration has a lonely witness for every runner under
an injective labelling by its actual finite-set cardinality. -/
theorem twoClusterLonelyAt (A B : Finset ℕ) (M p : ℕ)
    (hA : ∀ a, a ∈ A → 1 ≤ a ∧ a ≤ M)
    (hB : ∀ b, b ∈ B → 1 ≤ b ∧ b ≤ M)
    (hN : 4 ≤ A.card + B.card + 2) (hM : 1 ≤ M)
    (hMN : M < (A.card + B.card + 2) - 2)
    (hp : 2 * M + 1 ≤ p)
    (hg : M * ((A.card + B.card + 2) - 1) ≤
      (p - M) * ((A.card + B.card + 2) - 2 - M))
    (speeds : Fin (A.card + B.card + 2) → ℕ)
    (hinj : Function.Injective speeds)
    (hmem : ∀ i, speeds i ∈ twoClusterSpeeds A B p) :
    ∀ runner, ∃ t : ℝ, 0 < t ∧
      LonelyAt (fun i => (speeds i : ℝ)) runner t := by
  intro runner
  obtain ⟨t, ht, hpoint⟩ := twoClusterRunnerWitness A B (A.card + B.card + 2) M p
    hA hB hN hM hMN hp hg (speeds runner) (hmem runner)
  refine ⟨t, ht,
    (lonelyAt_iff_relativeLonelyAt (fun i => (speeds i : ℝ)) runner t).mpr ?_⟩
  intro other hother
  have hneq : speeds other ≠ speeds runner := hinj.ne hother
  have hbound := hpoint (speeds other) (hmem other) hneq
  simpa [circleNorm] using hbound

end LonelyRunner
