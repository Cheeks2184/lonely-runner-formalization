import LonelyRunner.SimultaneousApproximation

namespace LonelyRunner

/-- Simultaneous approximation of the `m` internal labels of an integer
configuration, with the labels `0` and `H` pinned to integral endpoints. -/
theorem exists_endpoint_affine_approximation {m : ℕ}
    (s : Fin (m + 2) → ℕ) (H Q : ℕ)
    (hH : 0 < H) (hQ : 0 < Q)
    (hs0 : s 0 = 0) (hsH : s (Fin.last (m + 1)) = H) :
    ∃ q : ℕ, 1 ≤ q ∧ q ≤ Q ^ m ∧
      ∃ u : Fin (m + 2) → ℤ,
        u 0 = 0 ∧ u (Fin.last (m + 1)) = (q : ℤ) ∧
        ∀ i, |(q : ℚ) * (s i : ℚ) / (H : ℚ) - (u i : ℚ)| <
          (1 : ℚ) / (Q : ℚ) := by
  let x : Fin m → ℝ := fun j =>
    (s (j.castSucc.succ) : ℝ) / (H : ℝ)
  obtain ⟨q, hqpos, hqbound, z, hz⟩ :=
    exists_simultaneous_integer_approximation m Q hQ x
  refine ⟨q, Nat.succ_le_iff.mpr hqpos, hqbound, ?_⟩
  let u : Fin (m + 2) → ℤ :=
    Fin.cases 0 (Fin.lastCases (q : ℤ) z)
  have huLast : u (Fin.last (m + 1)) = (q : ℤ) := by
    unfold u
    calc
      Fin.cases 0 (Fin.lastCases (q : ℤ) z) (Fin.last (m + 1)) =
          Fin.cases 0 (Fin.lastCases (q : ℤ) z) ((Fin.last m).succ) :=
        congrArg _ (Fin.succ_last m).symm
      _ = Fin.lastCases (q : ℤ) z (Fin.last m) := Fin.cases_succ _
      _ = (q : ℤ) := Fin.lastCases_last
  refine ⟨u, by simp [u], huLast, ?_⟩
  intro i
  refine Fin.cases ?_ ?_ i
  · simp [u, hs0]
    positivity
  · intro j
    refine Fin.lastCases ?_ ?_ j
    · have hsLast : s ((Fin.last m).succ) = H := by
        simpa only [Fin.succ_last] using hsH
      have huLast' : u ((Fin.last m).succ) = (q : ℤ) := by
        simpa only [Fin.succ_last] using huLast
      have hHq : (H : ℚ) ≠ 0 := by exact_mod_cast Nat.ne_of_gt hH
      rw [huLast', hsLast]
      simp [hHq]
      positivity
    · intro k
      have hk := hz k
      simp only [u, Fin.cases_succ, Fin.lastCases_castSucc]
      change |(q : ℚ) * (s (k.castSucc.succ) : ℚ) / (H : ℚ) -
        (z k : ℚ)| < (1 : ℚ) / (Q : ℚ)
      have hk' : |(q : ℝ) * ((s (k.castSucc.succ) : ℝ) / (H : ℝ)) -
          (z k : ℝ)| < (1 : ℝ) / (Q : ℝ) := by
        simpa [x] using hk
      have hkq : |(q : ℚ) * ((s (k.castSucc.succ) : ℚ) / (H : ℚ)) -
          (z k : ℚ)| < (1 : ℚ) / (Q : ℚ) := by
        apply (Rat.cast_lt (K := ℝ)).mp
        push_cast
        exact hk'
      calc
        |(q : ℚ) * (s (k.castSucc.succ) : ℚ) / (H : ℚ) - (z k : ℚ)| =
            |(q : ℚ) * ((s (k.castSucc.succ) : ℚ) / (H : ℚ)) - (z k : ℚ)| := by
          congr 1
          ring
        _ < (1 : ℚ) / (Q : ℚ) := hkq

end LonelyRunner
