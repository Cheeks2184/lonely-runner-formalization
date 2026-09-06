import Mathlib.Tactic

namespace LonelyRunner

/-- Even atom indices denote singleton cuts; odd indices denote the open
interval immediately following the corresponding cut. -/
def CutAtomMem (C : ℕ → ℕ) (D a : ℕ) (x : ℝ) : Prop :=
  if a % 2 = 0 then
    x = (C (a / 2) : ℝ) / (D : ℝ)
  else
    (C (a / 2) : ℝ) / (D : ℝ) < x ∧
      x < (C (a / 2 + 1) : ℝ) / (D : ℝ)

/-- Any finite sequence whose endpoints straddle `x` has an adjacent upward
crossing.  The argument deliberately makes no monotonicity assumption. -/
theorem exists_adjacent_cut_interval
    (C : ℕ → ℝ) (n : ℕ) (x : ℝ)
    (hleft : C 0 ≤ x) (hright : x < C n) :
    ∃ i : ℕ, i < n ∧ C i ≤ x ∧ x < C (i + 1) := by
  induction n with
  | zero => exfalso; linarith
  | succ n ih =>
    by_cases h : x < C n
    · obtain ⟨i, hi, h1, h2⟩ := ih h
      exact ⟨i, Nat.lt_succ_of_lt hi, h1, h2⟩
    · exact ⟨n, Nat.lt_succ_self _, le_of_not_gt h, hright⟩

/-- Singleton cuts together with open adjacent intervals cover `[0,1)`.
The cut numerators need not be sorted. -/
theorem cutAtomMem_covers_unit_interval
    (n D : ℕ) (_hn : 0 < n) (hD : 0 < D) (C : ℕ → ℕ)
    (hfirst : C 0 = 0) (hlast : C n = D) :
    ∀ x : ℝ, 0 ≤ x → x < 1 →
      ∃ a : Fin (2 * n), CutAtomMem C D a.val x := by
  intro x hx0 hx1
  have hDR : 0 < (D : ℝ) := by exact_mod_cast hD
  obtain ⟨i, hi, hix, hxi⟩ := exists_adjacent_cut_interval
    (fun j => (C j : ℝ) / (D : ℝ)) n x
    (by simpa [hfirst] using hx0)
    (by simpa [hlast, ne_of_gt hDR] using hx1)
  by_cases heq : x = (C i : ℝ) / (D : ℝ)
  · refine ⟨⟨2 * i, by omega⟩, ?_⟩
    simp [CutAtomMem, heq]
  · refine ⟨⟨2 * i + 1, by omega⟩, ?_⟩
    have hlt : (C i : ℝ) / (D : ℝ) < x := lt_of_le_of_ne hix (Ne.symm heq)
    have hd : (2 * i + 1) / 2 = i := by omega
    have hm : (2 * i + 1) % 2 = 1 := by omega
    simpa [CutAtomMem, hd, hm] using And.intro hlt hxi

end LonelyRunner
