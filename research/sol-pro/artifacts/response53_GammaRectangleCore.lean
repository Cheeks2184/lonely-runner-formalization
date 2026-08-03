import Mathlib.Data.Finset.Interval
import Mathlib.Data.Finset.Card
import Mathlib.Tactic

namespace LonelyRunner

open Finset

/-- Exact Gamma neighborhood used in the coefficient-two Hall reduction.
The lower sum boundary is strict, while `c + d = 2*N` is included. -/
def gammaNeighborhood (N t c : Nat) : Finset Nat :=
  (Finset.Icc (N + 1) (N + t)).filter fun d =>
    N + t < c + d ∧ c + d ≤ 2 * N ∧ Nat.Coprime c d

theorem mem_gammaNeighborhood {N t c d : Nat} :
    d ∈ gammaNeighborhood N t c ↔
      N < d ∧ d ≤ N + t ∧
      N + t < c + d ∧ c + d ≤ 2 * N ∧
      Nat.Coprime c d := by
  simp [gammaNeighborhood]
  omega

def rectangleQ (t : Nat) : Nat := t / 4
def rectangleEll (t : Nat) : Nat := 2 * rectangleQ t
def rectangleB (N t : Nat) : Nat := (N + t) / 2

def rectangleA0 (N t : Nat) : Nat :=
  max (t - rectangleEll t)
    (rectangleB N t - 2 * rectangleEll t + 1)

def rectangleC0 (N t : Nat) : Finset Nat :=
  Finset.Ico (rectangleA0 N t) (rectangleA0 N t + rectangleEll t)

def rectangleC1 (N t : Nat) : Finset Nat :=
  Finset.Ico (rectangleA0 N t + rectangleEll t)
    (rectangleA0 N t + 2 * rectangleEll t)

def rectangleD0 (N t : Nat) : Finset Nat :=
  Finset.Ico (N + 1) (N + rectangleEll t + 1)

def rectangleD1 (N t : Nat) : Finset Nat :=
  Finset.Ico (N + rectangleEll t + 1)
    (N + 2 * rectangleEll t + 1)

/-- The generic active coefficient-two band. -/
def inGenericGammaBand (N t c : Nat) : Prop :=
  2 * c ≤ N + t ∧ 3 * (N - t) < 4 * c

private theorem rectangle_division_facts (t N : Nat) :
    4 * (t / 4) + t % 4 = t ∧
    t % 4 < 4 ∧
    2 * ((N + t) / 2) + (N + t) % 2 = N + t ∧
    (N + t) % 2 < 2 := by
  constructor
  · simpa [Nat.mul_comm] using Nat.div_add_mod t 4
  constructor
  · exact Nat.mod_lt _ (by norm_num)
  constructor
  · simpa [Nat.mul_comm] using Nat.div_add_mod (N + t) 2
  · exact Nat.mod_lt _ (by norm_num)

/-- The two adjacent left rectangles cover every generic-band integer. -/
theorem mem_rectangleC0_union_C1_of_generic
    {N t c : Nat} (ht : 16 ≤ t) (h2t : 2 * t ≤ N)
    (hc : inGenericGammaBand N t c) :
    c ∈ rectangleC0 N t ∪ rectangleC1 N t := by
  obtain ⟨htdiv, htmod, hbdiv, hbmod⟩ := rectangle_division_facts t N
  have h2c : 2 * c ≤ N + t := hc.1
  have hband : 3 * (N - t) < 4 * c := hc.2
  let q := rectangleQ t
  let ell := rectangleEll t
  let b := rectangleB N t
  let a0 := rectangleA0 N t
  have hell : ell = 2 * (t / 4) := by rfl
  have hb : b = (N + t) / 2 := by rfl
  have ha0 : a0 =
      max (t - ell) (b - 2 * ell + 1) := by rfl
  have hlowOne : t - ell ≤ c := by
    dsimp [ell, rectangleEll, rectangleQ]
    omega
  have hlowTwo : b - 2 * ell + 1 ≤ c := by
    dsimp [b, ell, rectangleB, rectangleEll, rectangleQ]
    omega
  have ha0le : a0 ≤ c := by
    rw [ha0, max_le_iff]
    exact ⟨hlowOne, hlowTwo⟩
  have hclt : c < a0 + 2 * ell := by
    have hbge : b - 2 * ell + 1 ≤ a0 := by
      rw [ha0]
      exact le_max_right _ _
    dsimp [b, ell, rectangleB, rectangleEll, rectangleQ] at hbge ⊢
    omega
  by_cases hc0 : c < a0 + ell
  · exact Finset.mem_union.mpr <| Or.inl <|
      Finset.mem_Ico.mpr
        ⟨by simpa [a0] using ha0le, by simpa [a0, ell] using hc0⟩
  · exact Finset.mem_union.mpr <| Or.inr <|
      Finset.mem_Ico.mpr
        ⟨by simpa [a0, ell] using (Nat.le_of_not_gt hc0),
         by simpa [a0, ell] using hclt⟩

theorem rectangleD0_disjoint_D1 (N t : Nat) :
    Disjoint (rectangleD0 N t) (rectangleD1 N t) := by
  rw [Finset.disjoint_left]
  intro d hd0 hd1
  have h0 := Finset.mem_Ico.mp hd0
  have h1 := Finset.mem_Ico.mp hd1
  dsimp [rectangleD0, rectangleD1] at h0 h1
  omega

theorem rectangleD0_subset_extra
    {N t : Nat} (h2ell : 2 * rectangleEll t ≤ t) :
    rectangleD0 N t ⊆ Finset.Icc (N + 1) (N + t) := by
  intro d hd
  have h := Finset.mem_Ico.mp hd
  apply Finset.mem_Icc.mpr
  dsimp [rectangleD0] at h
  constructor
  · exact h.1
  · omega

theorem rectangleD1_subset_extra
    {N t : Nat} (h2ell : 2 * rectangleEll t ≤ t) :
    rectangleD1 N t ⊆ Finset.Icc (N + 1) (N + t) := by
  intro d hd
  have h := Finset.mem_Ico.mp hd
  apply Finset.mem_Icc.mpr
  dsimp [rectangleD1] at h
  constructor
  · omega
  · omega

/-- Arithmetic bounds used by both cross-rectangle pairings. -/
private theorem rectangleA0_threeEll_le
    {N t : Nat} (ht : 16 ≤ t) (h2t : 2 * t ≤ N) :
    rectangleA0 N t + 3 * rectangleEll t ≤ N + 1 := by
  obtain ⟨htdiv, htmod, hbdiv, hbmod⟩ := rectangle_division_facts t N
  let ell := rectangleEll t
  let b := rectangleB N t
  have hleft : t - ell + 3 * ell ≤ N + 1 := by
    dsimp [ell, rectangleEll, rectangleQ]
    omega
  have hright : b - 2 * ell + 1 + 3 * ell ≤ N + 1 := by
    dsimp [b, ell, rectangleB, rectangleEll, rectangleQ]
    omega
  dsimp [rectangleA0]
  by_cases hmax :
      t - rectangleEll t ≤ rectangleB N t - 2 * rectangleEll t + 1
  · rw [max_eq_right hmax]
    exact hright
  · rw [max_eq_left (Nat.le_of_not_ge hmax)]
    exact hleft

theorem rectangleC0_D1_band
    {N t c d : Nat} (ht : 16 ≤ t) (h2t : 2 * t ≤ N)
    (hc : c ∈ rectangleC0 N t) (hd : d ∈ rectangleD1 N t) :
    N + t < c + d ∧ c + d ≤ 2 * N := by
  obtain ⟨htdiv, htmod, _, _⟩ := rectangle_division_facts t N
  have hc' := Finset.mem_Ico.mp hc
  have hd' := Finset.mem_Ico.mp hd
  have ha0 := rectangleA0_threeEll_le ht h2t
  dsimp [rectangleC0, rectangleD1] at hc' hd'
  have ha0lower :
      t - rectangleEll t ≤ rectangleA0 N t := by
    dsimp [rectangleA0]
    exact le_max_left _ _
  constructor
  · dsimp [rectangleEll, rectangleQ] at *
    omega
  · omega

theorem rectangleC1_D0_band
    {N t c d : Nat} (ht : 16 ≤ t) (h2t : 2 * t ≤ N)
    (hc : c ∈ rectangleC1 N t) (hd : d ∈ rectangleD0 N t) :
    N + t < c + d ∧ c + d ≤ 2 * N := by
  obtain ⟨htdiv, htmod, _, _⟩ := rectangle_division_facts t N
  have hc' := Finset.mem_Ico.mp hc
  have hd' := Finset.mem_Ico.mp hd
  have ha0 := rectangleA0_threeEll_le ht h2t
  dsimp [rectangleC1, rectangleD0] at hc' hd'
  have ha0lower :
      t - rectangleEll t ≤ rectangleA0 N t := by
    dsimp [rectangleA0]
    exact le_max_left _ _
  constructor
  · dsimp [rectangleEll, rectangleQ] at *
    omega
  · omega

/-- Two supplied coprime injections on the cross rectangles combine into
a system of distinct representatives for every actual generic subset. -/
theorem rectangle_coprime_injections_give_sdr
    {N t : Nat} (ht : 16 ≤ t) (h2t : 2 * t ≤ N)
    (f0 f1 : Nat → Nat)
    (hf0mem : ∀ c ∈ rectangleC0 N t, f0 c ∈ rectangleD1 N t)
    (hf1mem : ∀ c ∈ rectangleC1 N t, f1 c ∈ rectangleD0 N t)
    (hf0cop : ∀ c ∈ rectangleC0 N t, Nat.Coprime c (f0 c))
    (hf1cop : ∀ c ∈ rectangleC1 N t, Nat.Coprime c (f1 c))
    (hf0inj : ∀ {x y}, x ∈ rectangleC0 N t → y ∈ rectangleC0 N t →
      f0 x = f0 y → x = y)
    (hf1inj : ∀ {x y}, x ∈ rectangleC1 N t → y ∈ rectangleC1 N t →
      f1 x = f1 y → x = y)
    (A : Finset Nat)
    (hA : ∀ c ∈ A, inGenericGammaBand N t c) :
    ∃ f : Nat → Nat,
      Set.InjOn f (↑A : Set Nat) ∧
      ∀ c ∈ A, f c ∈ gammaNeighborhood N t c := by
  classical
  let f : Nat → Nat := fun c =>
    if c ∈ rectangleC0 N t then f0 c else f1 c
  refine ⟨f, ?_, ?_⟩
  · intro x hx y hy hxy
    have hxA : x ∈ A := hx
    have hyA : y ∈ A := hy
    have hxcover := mem_rectangleC0_union_C1_of_generic ht h2t (hA x hxA)
    have hycover := mem_rectangleC0_union_C1_of_generic ht h2t (hA y hyA)
    by_cases hx0 : x ∈ rectangleC0 N t
    · by_cases hy0 : y ∈ rectangleC0 N t
      · apply hf0inj hx0 hy0
        simpa [f, hx0, hy0] using hxy
      · have hy1 : y ∈ rectangleC1 N t := by
          exact (Finset.mem_union.mp hycover).resolve_left hy0
        have hxD1 := hf0mem x hx0
        have hyD0 := hf1mem y hy1
        have heq : f0 x = f1 y := by simpa [f, hx0, hy0] using hxy
        rw [heq] at hxD1
        exact (Finset.disjoint_left.mp (rectangleD0_disjoint_D1 N t)
          hyD0 hxD1).elim
    · have hx1 : x ∈ rectangleC1 N t :=
        (Finset.mem_union.mp hxcover).resolve_left hx0
      by_cases hy0 : y ∈ rectangleC0 N t
      · have hxD0 := hf1mem x hx1
        have hyD1 := hf0mem y hy0
        have heq : f1 x = f0 y := by simpa [f, hx0, hy0] using hxy
        rw [heq] at hxD0
        exact (Finset.disjoint_left.mp (rectangleD0_disjoint_D1 N t)
          hxD0 hyD1).elim
      · have hy1 : y ∈ rectangleC1 N t :=
          (Finset.mem_union.mp hycover).resolve_left hy0
        apply hf1inj hx1 hy1
        simpa [f, hx0, hy0] using hxy
  · intro c hcA
    have hcover := mem_rectangleC0_union_C1_of_generic ht h2t (hA c hcA)
    have h2ell : 2 * rectangleEll t ≤ t := by
      obtain ⟨htdiv, htmod, _, _⟩ := rectangle_division_facts t N
      dsimp [rectangleEll, rectangleQ]
      omega
    by_cases hc0 : c ∈ rectangleC0 N t
    · have hd := hf0mem c hc0
      have hband := rectangleC0_D1_band ht h2t hc0 hd
      have hdomain := rectangleD1_subset_extra h2ell hd
      rw [mem_gammaNeighborhood]
      have hdIcc := Finset.mem_Icc.mp hdomain
      simpa [f, hc0] using
        (show N < f0 c ∧ f0 c ≤ N + t ∧
            N + t < c + f0 c ∧ c + f0 c ≤ 2 * N ∧
            Nat.Coprime c (f0 c) from
          ⟨by omega, hdIcc.2, hband.1, hband.2, hf0cop c hc0⟩)
    · have hc1 : c ∈ rectangleC1 N t :=
        (Finset.mem_union.mp hcover).resolve_left hc0
      have hd := hf1mem c hc1
      have hband := rectangleC1_D0_band ht h2t hc1 hd
      have hdomain := rectangleD0_subset_extra h2ell hd
      rw [mem_gammaNeighborhood]
      have hdIcc := Finset.mem_Icc.mp hdomain
      simpa [f, hc0] using
        (show N < f1 c ∧ f1 c ≤ N + t ∧
            N + t < c + f1 c ∧ c + f1 c ≤ 2 * N ∧
            Nat.Coprime c (f1 c) from
          ⟨by omega, hdIcc.2, hband.1, hband.2, hf1cop c hc1⟩)

end LonelyRunner
